
/*select * from sys.databases where name like 'BNYUK%'
--* USE[BNYSA_Production_Data]
--* USEBNYUK_ProductionAR_data*/
/** USEDFINAnalytics;*/

GO
DECLARE @runnow INT= 0;
IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'sp_UTIL_GetIndexStats'
)
   AND @runnow = 1
    BEGIN

/*declare @RunID BIGINT = NEXT VALUE FOR master_seq;
		truncate TABLE [dbo].[DFS_IndexStats];
		select top 100 * from [dbo].[DFS_IndexStats];
		*/
        DECLARE @RunID BIGINT;
        DECLARE @MaxWaitMS INT= 30;
        DECLARE @MaxWaitCount INT= 3;
        EXEC @RunID = dbo.UTIL_GetSeq;
        DECLARE @command VARCHAR(1000);

        /*SELECT @command = '--* USE?; exec sp_UTIL_GetIndexStats ' + CAST(@RunID AS NVARCHAR(25)) + ', ' + CAST(@MaxWaitMS AS NVARCHAR(15)) + ';';*/

        SELECT @command = 'exec sp_UTIL_GetIndexStats ' + CAST(@RunID AS NVARCHAR(25)) + ', ' + CAST(@MaxWaitMS AS NVARCHAR(15)) + ';';
        EXEC sp_MSforeachdb 
             @command;
END;
GO

/* 
drop table [dbo].[DFS_IndexStats]
select * from [dbo].[DFS_IndexStats]
*/

IF EXISTS
(
    SELECT 1
    FROM sys.tables
    WHERE name = 'DFS_IndexStats'
)
    DROP TABLE [dbo].[DFS_IndexStats];
go
CREATE TABLE [dbo].[DFS_IndexStats]
([SvrName]                [NVARCHAR](150) NULL, 
 [DB]                     [NVARCHAR](150) NULL, 
 [Obj]                    [NVARCHAR](150) NULL, 
 [IdxName]                [SYSNAME] NULL, 
 [range_scan_count]       [BIGINT] NOT NULL, 
 [singleton_lookup_count] [BIGINT] NOT NULL, 
 [row_lock_count]         [BIGINT] NOT NULL, 
 [page_lock_count]        [BIGINT] NOT NULL, 
 [TotNo_Of_Locks]         [BIGINT] NULL, 
 [row_lock_wait_count]    [BIGINT] NOT NULL, 
 [page_lock_wait_count]   [BIGINT] NOT NULL, 
 [TotNo_Of_Blocks]        [BIGINT] NULL, 
 [row_lock_wait_in_ms]    [BIGINT] NOT NULL, 
 [page_lock_wait_in_ms]   [BIGINT] NOT NULL, 
 [TotBlock_Wait_TimeMS]   [BIGINT] NULL, 
 [index_id]               [INT] NOT NULL, 
 [CreateDate]             [DATETIME] NULL, 
 SSVER                    NVARCHAR(300) NULL, 
 RunID                    BIGINT NULL, 
 [UID]                    UNIQUEIDENTIFIER DEFAULT NEWID(), 
 [RowNbr]                 [INT] IDENTITY(1, 1) NOT NULL
)
ON [PRIMARY];
CREATE INDEX pi_DFS_IndexStats
ON DFS_IndexStats
([UID]
);

/*ALTER TABLE [dbo].[DFS_IndexStats] ADD  DEFAULT (getdate()) FOR [CreateDate]*/

GO

/** USEmaster;*/

GO
IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'sp_UTIL_GetIndexStats'
)
    DROP PROCEDURE sp_UTIL_GetIndexStats;
GO

/* select top 100 * from [DFS_IndexStats] order by Rownbr desc
 exec sp_UTIL_GetIndexStats -1, 5*/

CREATE PROCEDURE sp_UTIL_GetIndexStats
(@RunID        BIGINT, 
 @MaxWaitMS    INT    = 30, 
 @MaxWaitCount INT    = 2
)
AS
    BEGIN

/*declare @RunID     BIGINT = -50 ;
		declare @MaxWaitMS INT = 0;
		declare @MaxWaitCount INT = 0 ;*/

        INSERT INTO [dbo].[DFS_IndexStats]
        ( [SvrName], 
          [DB], 
          [Obj], 
          [IdxName], 
          [range_scan_count], 
          [singleton_lookup_count], 
          [row_lock_count], 
          [page_lock_count], 
          [TotNo_Of_Locks], 
          [row_lock_wait_count], 
          [page_lock_wait_count], 
          [TotNo_Of_Blocks], 
          [row_lock_wait_in_ms], 
          [page_lock_wait_in_ms], 
          [TotBlock_Wait_TimeMS], 
          [index_id], 
          [CreateDate], 
          [SSVER], 
          RunID, 
          [UID]
        ) 
               SELECT @@ServerName AS SvrName, 
                      DB_NAME() AS DB, 
                      OBJECT_NAME(IOS.object_id) AS Obj, 
                      i.Name AS IdxName, 
                      range_scan_count, 
                      singleton_lookup_count, 
                      row_lock_count, 
                      page_lock_count, 
                      row_lock_count + page_lock_count AS TotNo_Of_Locks, 
                      row_lock_wait_count, 
                      page_lock_wait_count, 
                      row_lock_wait_count + page_lock_wait_count AS TotNo_Of_Blocks, 
                      row_lock_wait_in_ms, 
                      page_lock_wait_in_ms, 
                      row_lock_wait_in_ms + page_lock_wait_in_ms AS TotBlock_Wait_TimeMS, 
                      IOS.index_id, 
                      GETDATE() AS CreateDate, 
                      @@version AS SSVER, 
                      @RunID AS RunID, 
                      NEWID() AS [UID]
               FROM sys.dm_db_index_operational_stats(NULL, NULL, NULL, NULL) IOS
                         JOIN sys.indexes I
                         ON I.index_id = IOS.index_id
               WHERE DB_NAME() NOT IN('master', 'model', 'msdb', 'tempdb', 'DBA')
               AND OBJECT_NAME(IOS.object_id) IS NOT NULL
               AND (row_lock_wait_count >= 0
                    OR page_lock_wait_count >= 0)
               AND (page_lock_wait_in_ms >= @MaxWaitMS
                    OR row_lock_wait_in_ms >= @MaxWaitMS);
    END;