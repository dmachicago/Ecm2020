USE [DFINAnalytics]
go
--EXEC sp_who2;
--EXEC sp_who;
--GO
IF EXISTS
(
    SELECT 1
    FROM   sys.procedures
    WHERE  name = 'UTIL_ListQryTextBySpid'
)
    DROP PROCEDURE UTIL_ListQryTextBySpid;
	GO
CREATE PROC UTIL_ListQryTextBySpid(@SPID INT)
AS
     --Exec UTIL_ListQryBySpid 306  
     --To see the last statement sent from a client to an SQL Server instance run: (for example for the blocking session ID)
     DBCC INPUTBUFFER(@SPID);
GO
GRANT EXECUTE ON OBJECT ::dbo.UTIL_ListQryTextBySpid TO public;
GO
IF EXISTS
(
    SELECT 1
    FROM   sys.procedures
    WHERE  name = 'UTIL_getRunningQueryText'
)
    DROP PROCEDURE UTIL_getRunningQueryText;
GO
CREATE PROC UTIL_getRunningQueryText(@SPID INT)
AS
     --Lists all currently running queries in SQL Server and their text
     SELECT r.session_id, 
            s.host_name, 
            s.login_name, 
            s.original_login_name, 
            r.STATUS, 
            r.command, 
            r.cpu_time, 
            r.total_elapsed_time, 
            t.text AS Query_Text
     FROM   sys.dm_exec_requests r
     CROSS APPLY sys.dm_exec_sql_text(sql_handle) t
     INNER JOIN sys.dm_exec_sessions s
                     ON r.session_id = s.session_id
     WHERE  r.session_id = @SPID;
GO
IF EXISTS
(
    SELECT 1
    FROM   sys.procedures
    WHERE  name = 'UTIL_ListCurrentRunningQueries'
)
    DROP PROCEDURE UTIL_ListCurrentRunningQueries;
	GO
CREATE PROC UTIL_ListCurrentRunningQueries
AS
     --Lists all currently running queries in SQL Server and their text
     SELECT r.session_id, 
            s.host_name, 
            s.login_name, 
            s.original_login_name, 
            r.STATUS, 
            r.command, 
            r.cpu_time, 
            r.total_elapsed_time, 
            t.text AS Query_Text
     FROM   sys.dm_exec_requests r
     CROSS APPLY sys.dm_exec_sql_text(sql_handle) t
     INNER JOIN sys.dm_exec_sessions s
                     ON r.session_id = s.session_id;
GO
GRANT EXECUTE ON OBJECT ::dbo.UTIL_ListCurrentRunningQueries TO public;
GO
-- drop TABLE [dbo].[DFS_BlockingHistory]
IF NOT EXISTS
(
    SELECT 1
    FROM   sys.tables
    WHERE  name = 'DFS_BlockingHistory'
)
    CREATE TABLE [dbo].[DFS_BlockingHistory]
    ([session_id]          [SMALLINT] NOT NULL, 
     [blocking_session_id] [SMALLINT] NULL, 
     [cpu_time]            [INT] NOT NULL, 
     [total_elapsed_time]  [INT] NOT NULL, 
     [Database_Name]       [NVARCHAR](128) NULL, 
     [host_name]           [NVARCHAR](128) NULL, 
     [login_name]          [NVARCHAR](128) NOT NULL, 
     [original_login_name] [NVARCHAR](128) NOT NULL, 
     [STATUS]              [NVARCHAR](30) NOT NULL, 
     [command]             [NVARCHAR](16) NOT NULL, 
     [Query_Text]          [NVARCHAR](MAX) NULL, 
     CreateDate            DATETIME NULL, 
     RunID                 INT NULL, 
     RowNbr                INT IDENTITY(1, 1) NOT NULL
    )
    ON [PRIMARY] TEXTIMAGE_ON [PRIMARY];
GO
IF EXISTS
(
    SELECT 1
    FROM   sys.procedures
    WHERE  name = 'UTIL_ListQueryAndBlocks'
)
    DROP PROCEDURE UTIL_ListQueryAndBlocks;
	GO

--Lists database name that requests are executing against and blocking session ID for blocked queries:
-- select top 1000 * from [dbo].[DFS_BlockingHistory]
-- truncate table [dbo].[DFS_BlockingHistory]
/*
declare @msg nvarchar(250);
declare @i int = 1 ;
while (@i <60)
begin
	set @msg = '@I = ' + cast(@i as nvarchar(10));
	exec printimmediate @msg;
	waitfor delay '00:00:10'
	exec UTIL_ListQueryAndBlocks
	set @i = @i + 1;	
end
select top 20 * from [dbo].[DFS_BlockingHistory] order by RowNbr desc;

select Count(*) SpidCnt, RunID from [dbo].[DFS_BlockingHistory] Group by RunID order by RunID;

exec UTIL_ListQueryAndBlocks
select top 25 * from [dbo].[DFS_BlockingHistory] order by RowNbr desc
*/

CREATE PROC UTIL_ListQueryAndBlocks
AS
    BEGIN
        DECLARE @RunID INT= 0;
        DECLARE @cnt INT= 0;
        SET @cnt =
        (
            SELECT COUNT(*)
            FROM   sys.dm_exec_requests
            WHERE  [blocking_session_id] > 0
        );
        IF @cnt > 0
            BEGIN
                EXEC @RunID = sp_UTIL_GetSeq;
                PRINT 'RUNID: ' + CAST(@RunID AS NVARCHAR(10)) + '->Blocked Count: ' + cast(@cnt as nvarchar(10)) ;
                WITH BlockedSpids
                     AS (SELECT [blocking_session_id] AS SID
                         FROM     sys.dm_exec_requests
                         WHERE   [blocking_session_id] > 0
                         UNION ALL
                         SELECT [session_id]
                         FROM   sys.dm_exec_requests
                         WHERE  [blocking_session_id] > 0)
                     INSERT INTO [dbo].[DFS_BlockingHistory]
                     ([session_id], 
                      [blocking_session_id], 
                      [cpu_time], 
                      [total_elapsed_time], 
                      [Database_Name], 
                      [host_name], 
                      [login_name], 
                      [original_login_name], 
                      [STATUS], 
                      [command], 
                      [Query_Text], 
                      [CreateDate], 
                      RunID
                     )
                     SELECT r.session_id, 
                            r.blocking_session_id, 
                            r.cpu_time, 
                            r.total_elapsed_time, 
                            DB_NAME(r.database_id) AS Database_Name, 
                            s.host_name, 
                            s.login_name, 
                            s.original_login_name, 
                            r.STATUS, 
                            r.command, 
                            t.text AS Query_Text, 
                            GETDATE(), 
                            @RunID
                     FROM   sys.dm_exec_requests r
                     CROSS APPLY sys.dm_exec_sql_text(sql_handle) t
                     INNER JOIN sys.dm_exec_sessions s
                                     ON r.session_id = s.session_id
                     JOIN BlockedSpids B
                                     ON r.session_id = B.sid;
        END;
    END;
GO
GRANT EXECUTE ON OBJECT ::dbo.UTIL_ListQueryAndBlocks TO public;
GO
IF EXISTS
(
    SELECT 1
    FROM   sys.procedures
    WHERE  name = 'UTIL_ListBlocks'
)
    DROP PROCEDURE UTIL_ListBlocks;
	GO
CREATE PROC UTIL_ListBlocks
AS
     --Only running queries that are blocked and session ID of blocking queries:
     SELECT r.session_id, 
            r.blocking_session_id, 
            DB_NAME(r.database_id) AS Database_Name, 
            s.host_name, 
            s.login_name, 
            s.original_login_name, 
            r.STATUS, 
            r.command, 
            r.cpu_time, 
            r.total_elapsed_time, 
            t.text AS Query_Text
     FROM   sys.dm_exec_requests r
     CROSS APPLY sys.dm_exec_sql_text(sql_handle) t
     INNER JOIN sys.dm_exec_sessions s
                     ON r.session_id = s.session_id
     WHERE  r.blocking_session_id <> 0;
GO
GRANT EXECUTE ON OBJECT ::dbo.UTIL_ListBlocks TO public;
GO
IF EXISTS
(
    SELECT 1
    FROM   sys.procedures
    WHERE  name = 'UTIL_ListMostCommonWaits'
)
    DROP PROCEDURE UTIL_ListMostCommonWaits;
	GO
CREATE PROC UTIL_ListMostCommonWaits
AS
     --Display the top 10 most frequent WAITS occuring in the DB
     SELECT TOP 10 wait_type, 
                   wait_time_ms, 
                   Percentage = 100. * wait_time_ms / SUM(wait_time_ms) OVER()
     FROM          sys.dm_os_wait_stats wt
     WHERE         wt.wait_type NOT LIKE '%SLEEP%'
     ORDER BY Percentage DESC;
GO
GRANT EXECUTE ON OBJECT ::dbo.UTIL_ListMostCommonWaits TO public;
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016