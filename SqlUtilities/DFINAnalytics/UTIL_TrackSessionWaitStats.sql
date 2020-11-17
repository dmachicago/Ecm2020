USE DFINAnalytics;
GO

/* 
truncate TABLE DFINAnalytics.[dbo].[DFS_WaitStats]
*/

/*
declare @MaxWaitMS int = 30;
DECLARE @RunID INT= 0;
EXEC @RunID = DFINAnalytics.dbo.UTIL_GetSeq;
declare @stmt nvarchar(100) = 'use ?; exec sp_UTIL_DFS_WaitStats '+cast(@RunID as nvarchar(15))+', '+cast(@MaxWaitMS as nvarchar(15))+' ; '
exec sp_msForEachDB @stmt ;
select * from [DFINAnalytics].dbo.DFS_WaitStats where RunID = @RunID order by DBName,session_id, wait_type ;
*/


/* DROP TABLE [dbo].[DFS_WaitStats]*/

IF NOT EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.TABLES
    WHERE TABLE_NAME = 'DFS_WaitStats'
          AND TABLE_TYPE = 'BASE TABLE'
)
    BEGIN
        CREATE TABLE [dbo].[DFS_WaitStats]
        (SvrName               NVARCHAR(150) NOT NULL
                                             DEFAULT @@servername, 
         DBName                NVARCHAR(150) NOT NULL
                                             DEFAULT DB_NAME(), 
         [session_id]          [SMALLINT] NOT NULL, 
         [wait_type]           [NVARCHAR](60) NOT NULL, 
         [waiting_tasks_count] [BIGINT] NOT NULL, 
         [wait_time_ms]        [BIGINT] NOT NULL, 
         [max_wait_time_ms]    [BIGINT] NOT NULL, 
         [signal_wait_time_ms] [BIGINT] NOT NULL, 
         RunID                 INT NULL, 
         CreateDate            DATETIME NOT NULL
                                        DEFAULT GETDATE(), 
         [UID]                 UNIQUEIDENTIFIER NOT NULL
                                                DEFAULT NEWID()
        )
        ON [PRIMARY];

		create index pi_DFS_WaitStatsSVR on DFS_WaitStats (SvrName,DBName,[session_id]);
		create index pi_DFS_WaitStatsUID on DFS_WaitStats ([UID]);

END;
GO
USE master;
GO
IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'sp_UTIL_DFS_WaitStats'
)
    DROP PROCEDURE sp_UTIL_DFS_WaitStats;
GO
CREATE PROCEDURE sp_UTIL_DFS_WaitStats
(@RunID     INT, 
 @MaxWaitMS BIGINT
)
AS

/*DECLARE @RunID INT= 0;
EXEC @RunID = DFINAnalytics.dbo.UTIL_GetSeq;*/

    BEGIN
        INSERT INTO [DFINAnalytics].dbo.DFS_WaitStats
               SELECT @@servername AS [SvrName], 
                      DB_NAME() AS [DBName], 
                      WS.[session_id], 
                      WS.[wait_type], 
                      WS.[waiting_tasks_count], 
                      WS.[wait_time_ms], 
                      WS.[max_wait_time_ms], 
                      WS.[signal_wait_time_ms], 
                      @RunID, 
                      GETDATE(), 
                      NEWID()
               FROM sys.dm_exec_session_wait_stats WS
               WHERE WS.wait_time_ms >= @MaxWaitMS;
    END;