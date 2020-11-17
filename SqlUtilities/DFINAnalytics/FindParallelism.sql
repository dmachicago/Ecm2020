
IF EXISTS
(
    SELECT 1
    FROM sys.tables
    WHERE name = 'DFS_ParallelMonitor'
)
    DROP TABLE [DFS_ParallelMonitor];
GO
CREATE TABLE [dbo].[DFS_ParallelMonitor]
([SVR]                    [NVARCHAR](128) NULL, 
 [DBNAme]                 [NVARCHAR](128) NULL, 
 [sql_handle]             [VARBINARY](64) NOT NULL, 
 [statement_start_offset] [INT] NOT NULL, 
 [statement_end_offset]   [INT] NOT NULL, 
 [dbid]                   [SMALLINT] NULL, 
 [objectid]               [INT] NULL, 
 [number]                 [SMALLINT] NULL, 
 [encrypted]              [BIT] NOT NULL, 
 [QrySql]                 [NVARCHAR](MAX) NULL, 
 [qry_hash]               [VARBINARY](8000) NULL, 
 [CreateDate]             [DATETIME] NOT NULL, 
 [RunID]                  [BIGINT] NULL, 
 [UID]                    [UNIQUEIDENTIFIER] NULL
)
ON [PRIMARY];
CREATE UNIQUE INDEX pk_DFS_ParallelMonitor
ON [DFS_ParallelMonitor]
([UID]
);
GO

/*
Another way to find parallelism is to get queries where the amount 
of time spent by the workers are more than the query execution time. 
Use the below method:
*/

IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'UTIL_ParallelMonitor'
)
    DROP PROCEDURE UTIL_ParallelMonitor;
GO

/*
exec UTIL_ParallelMonitor -9
select * from [DFS_ParallelMonitor]
*/
CREATE PROCEDURE UTIL_ParallelMonitor(@RunID BIGINT)
AS
    BEGIN
        DECLARE @cnt INT= 0;
        SET @cnt =
        (
            SELECT COUNT(1) AS cnt
            FROM sys.dm_exec_query_stats qs
                      CROSS APPLY sys.dm_exec_sql_text(qs.plan_handle) AS q
            WHERE qs.total_worker_time > qs.total_elapsed_time
        );
        
		IF
           (@cnt > 0
           )
            BEGIN
                INSERT INTO [DFS_ParallelMonitor]
                       SELECT SVR = @@serverName, 
                              DBNAme = DB_NAME(), 
                              qs.sql_handle, 
                              qs.statement_start_offset, 
                              qs.statement_end_offset, 
                              q.dbid, 
                              q.objectid, 
                              q.number, 
                              q.encrypted, 
                              q.TEXT AS QrySql, 
                              qry_hash = HASHBYTES('SHA1', SUBSTRING(CAST(q.TEXT AS NVARCHAR(4000)), 1, 4000)), 
                              CreateDate = GETDATE(), 
                              RunID = @RunID, 
                              [UID] = NEWID()
                       FROM sys.dm_exec_query_stats qs
                                 CROSS APPLY sys.dm_exec_sql_text(qs.plan_handle) AS q
                       WHERE qs.total_worker_time > qs.total_elapsed_time;
        END;
    END;