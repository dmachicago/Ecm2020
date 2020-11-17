--select * from sys.databases where name like 'BNYUK%'
--use [BNYSA_Production_Data]
--use BNYUK_ProductionAR_data
USE [DFINAnalytics];
go
-- drop table [dbo].[DFS_IndexStats]
if not exists (select 1 from sys.tables where name = 'DFS_IndexStats')

CREATE TABLE [dbo].[DFS_IndexStats](
	[SvrName] [nvarchar](128) NULL,
	[DB] [nvarchar](128) NULL,
	[Obj] [nvarchar](128) NULL,
	[IdxName] [sysname] NULL,
	[range_scan_count] [bigint] NOT NULL,
	[singleton_lookup_count] [bigint] NOT NULL,
	[row_lock_count] [bigint] NOT NULL,
	[page_lock_count] [bigint] NOT NULL,
	[TotNo_Of_Locks] [bigint] NULL,
	[row_lock_wait_count] [bigint] NOT NULL,
	[page_lock_wait_count] [bigint] NOT NULL,
	[TotNo_Of_Blocks] [bigint] NULL,
	[row_lock_wait_in_ms] [bigint] NOT NULL,
	[page_lock_wait_in_ms] [bigint] NOT NULL,
	[TotBlock_Wait_TimeMS] [bigint] NULL,
	[index_id] [int] NOT NULL,
	[CreateDate] [datetime] NULL,
	[RowNbr] [int] IDENTITY(1,1) NOT NULL
) ON [PRIMARY]

--ALTER TABLE [dbo].[DFS_IndexStats] ADD  DEFAULT (getdate()) FOR [CreateDate]
go

IF EXISTS
(
    SELECT 1
    FROM   sys.procedures
    WHERE  name = 'UTIL_GetIndexStats'
)
    DROP PROCEDURE UTIL_GetIndexStats;
GO
-- select top 100 * from [master].[dbo].[DFS_IndexStats] order by Rownbr desc
-- exec UTIL_GetIndexStats
CREATE PROCEDURE sp_UTIL_GetIndexStats
AS
    BEGIN
	    INSERT INTO [master].[dbo].[DFS_IndexStats]
        ([SvrName], 
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
		 [CreateDate]
        )
        SELECT @@ServerName AS SvrName, 
               DB_NAME() as DB, 
               OBJECT_NAME(IOS.object_id) Obj, 
               i.Name AS IdxName, 
               range_scan_count, 
               singleton_lookup_count, 
               row_lock_count, 
               page_lock_count, 
               row_lock_count + page_lock_count TotNo_Of_Locks, 
               row_lock_wait_count, 
               page_lock_wait_count, 
               row_lock_wait_count + page_lock_wait_count TotNo_Of_Blocks, 
               row_lock_wait_in_ms, 
               page_lock_wait_in_ms, 
               row_lock_wait_in_ms + page_lock_wait_in_ms TotBlock_Wait_TimeMS, 
               IOS.index_id,
			   getdate()
        --INTO DFINAnalytics.dbo.DFS_IndexStats
        FROM   sys.dm_db_index_operational_stats(NULL, NULL, NULL, NULL) IOS
        JOIN sys.indexes I
                   ON I.index_id = IOS.index_id
        WHERE  DB_NAME() NOT IN('master', 'model', 'msdb', 'tempdb', 'DBA')
        AND OBJECT_NAME(IOS.object_id) IS NOT NULL
        AND (row_lock_wait_count > 0
             OR page_lock_wait_count > 0)
        AND (row_lock_wait_in_ms > 100
             OR page_lock_wait_in_ms > 100);
        -- and OBJECT_NAME(object_id) LIKE @TgtName
        --order by TotBlock_Wait_TimeMS desc
        -- W. Dale Miller
        -- DMA, Limited
        -- Offered under GNU License
        -- July 26, 2016
    END;