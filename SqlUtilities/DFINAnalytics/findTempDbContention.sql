
/****** Object:  Table [dbo].[XX]    Script Date: 2/12/2019 9:33:07 AM ******/
IF EXISTS
(
    SELECT 1
    FROM sys.tables
    WHERE name = 'DFS_TempDbMonitor'
)
    DROP TABLE [DFS_TempDbMonitor];
GO
CREATE TABLE [dbo].[DFS_TempDbMonitor]
([SVR]                  [NVARCHAR](128) NULL, 
 [DBNAme]               [NVARCHAR](128) NULL, 
 [session_id]           [SMALLINT] NULL, 
 [exec_context_id]      [INT] NULL, 
 [wait_duration_ms]     [BIGINT] NULL, 
 [wait_type]            [NVARCHAR](60) NULL, 
 [blocking_session_id]  [SMALLINT] NULL, 
 [resource_description] [NVARCHAR](3072) NULL, 
 [Node ID]              [NVARCHAR](3072) NULL, 
 [program_name]         [NVARCHAR](128) NULL, 
 [Qry_Sql]              [NVARCHAR](MAX) NULL, 
 [database_id]          [SMALLINT] NOT NULL, 
 [query_plan]           [XML] NULL, 
 [cpu_time]             [INT] NOT NULL, 
 [plan_hash]            [VARBINARY](8000) NULL, 
 [qry_hash]             [VARBINARY](8000) NULL, 
 CreateDate             DATETIME DEFAULT GETDATE(), 
 RunID                  BIGINT, 
 [UID]                  [UNIQUEIDENTIFIER] NULL
)
ON [PRIMARY];
CREATE UNIQUE INDEX pk_DFS_TempDbMonitor
ON [DFS_TempDbMonitor]
([UID]
);
GO

/*
Consider the scenario of hundreds of concurrent queries that all 
create, use, and then drop small temporary tables (that by their 
very nature are always stored in tempdb). Each time a temp table 
is created, a data page must be allocated, plus an allocation 
metadata page to keep track of the data pages allocated to the 
table. This requires making a note in an allocation page (called 
a PFS page – see here for in-depth info) that those two pages have 
been allocated in the database. When the temp table is dropped, 
those pages are deallocated, and they must be marked as such in that 
PFS page again. Only one thread at a time can be changing the allocation 
page, making it a hotspot and slowing down the overall workload.
*/

IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'UTIL_TempDbMonitor'
)
    DROP PROCEDURE UTIL_TempDbMonitor;
GO

/*
exec UTIL_TempDbMonitor -9
select * from [DFS_TempDbMonitor]
*/

CREATE PROCEDURE UTIL_TempDbMonitor(@RunID BIGINT)
AS
    BEGIN
        INSERT INTO DFS_TempDbMonitor
               SELECT SVR = @@serverName, 
                      DBNAme = DB_NAME(), 
                      [owt].[session_id], 
                      [owt].[exec_context_id], 
                      [owt].[wait_duration_ms], 
                      [owt].[wait_type], 
                      [owt].[blocking_session_id], 
                      [owt].[resource_description],
                      CASE [owt].[wait_type]
                          WHEN N'CXPACKET'
                          THEN RIGHT([owt].[resource_description], CHARINDEX(N'=', REVERSE([owt].[resource_description])) - 1)
                          ELSE NULL
                      END AS [Node ID], 
                      [es].[program_name], 
                      [est].text AS Qry_Sql, 
                      [er].[database_id], 
                      [eqp].[query_plan], 
                      [er].[cpu_time], 
                      plan_hash = HASHBYTES('SHA1', SUBSTRING(CAST([eqp].[query_plan] AS NVARCHAR(4000)), 1, 4000)), 
                      qry_hash = HASHBYTES('SHA1', SUBSTRING(CAST([est].text AS NVARCHAR(4000)), 1, 4000)), 
                      CreateDate = GETDATE(), 
                      RunID = @RunID, 
                      [UID] = NEWID()
               FROM sys.dm_os_waiting_tasks [owt]
                         INNER JOIN sys.dm_exec_sessions [es]
                         ON [owt].[session_id] = [es].[session_id]
                              INNER JOIN sys.dm_exec_requests [er]
                         ON [es].[session_id] = [er].[session_id]
                                   OUTER APPLY sys.dm_exec_sql_text([er].[sql_handle]) [est]
                                        OUTER APPLY sys.dm_exec_query_plan([er].[plan_handle]) [eqp]
               WHERE [es].[is_user_process] = 1
               ORDER BY [owt].[session_id], 
                        [owt].[exec_context_id];
    END;
GO