/*
use master
go
if exists(select 1 from sys.objects where object_id = OBJECT_ID(N'udfDfsGetIndexStats')
	AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
	drop function dbo.udfDfsGetIndexStats
go

create function udfDfsGetIndexStats (@DBName nvarchar(100), @TableFqn  nvarchar(100)) 
returns table
as
return
    SELECT *
    FROM   sys.dm_db_index_physical_stats(DB_ID(@DBName), OBJECT_ID(@TableFqn), NULL, NULL, 'DETAILED') AS IPS;
go
*/
--******************************************************
--******************************************************

--USE BNYUK_ProductionAR_Port; -- replace your dbname
USE BNYUK_ProductionAR_Data -- replace your dbname

if OBJECT_ID('tempdb..#TablesToAnalyze') is not null
drop table #TablesToAnalyze;

SELECT DB_NAME() AS 'DB', 
       T.name AS [TBL], 
		T.object_id ,
       I.name AS [IDX], 
       I.allow_row_locks, 
       I.allow_page_locks,
	   I.index_id
into #TablesToAnalyze
FROM   sys.tables T
JOIN sys.indexes I
           ON I.object_id = T.object_id
WHERE  T.name IN('IssuerCaption', 'IssuerCaptionStaging', 'SecurityIssuer', 'IssuerLibrary', 'Staging_DataLoadBatchOptions', 'Staging_HoldingsLoad', 'DataloadBatchOptions', 'HoldingsLoad');

--select * from #TablesToAnalyze;
--******************************************************

if OBJECT_ID('tempdb..#TableSizeStats') is not null
drop table #TableSizeStats;

SELECT s.Name AS SchemaName, 
       t.Name AS TableName, 
	   t.object_id, 
       p.rows AS RowCounts, 
       CAST(ROUND((SUM(a.used_pages) / 128.00), 2) AS NUMERIC(36, 2)) AS Used_MB, 
       CAST(ROUND((SUM(a.total_pages) - SUM(a.used_pages)) / 128.00, 2) AS NUMERIC(36, 2)) AS Unused_MB, 
       CAST(ROUND((SUM(a.total_pages) / 128.00), 2) AS NUMERIC(36, 2)) AS Total_MB
into #TableSizeStats
FROM   sys.tables t
INNER JOIN sys.indexes i
           ON t.OBJECT_ID = i.object_id
INNER JOIN sys.partitions p
           ON i.object_id = p.OBJECT_ID
              AND i.index_id = p.index_id
INNER JOIN sys.allocation_units a
           ON p.partition_id = a.container_id
INNER JOIN sys.schemas s
           ON t.schema_id = s.schema_id
join #TablesToAnalyze TA 
			ON TA.object_id = t.object_id
GROUP BY t.Name, 
		 t.object_id,
         s.Name, 
         p.Rows
ORDER BY s.Name, 
         t.Name;

--select * from #TableSizeStats;
--******************************************************
if OBJECT_ID('tempdb..#IndexStats') is not null
	drop table #IndexStats;

CREATE TABLE #IndexStats(
	[database_id] [smallint] NULL,
	[object_id] [int] NULL,
	[index_id] [int] NULL,
	[partition_number] [int] NULL,
	[index_type_desc] [nvarchar](60) NULL,
	[alloc_unit_type_desc] [nvarchar](60) NULL,
	[index_depth] [tinyint] NULL,
	[index_level] [tinyint] NULL,
	[avg_fragmentation_in_percent] [float] NULL,
	[fragment_count] [bigint] NULL,
	[avg_fragment_size_in_pages] [float] NULL,
	[page_count] [bigint] NULL,
	[avg_page_space_used_in_percent] [float] NULL,
	[record_count] [bigint] NULL,
	[ghost_record_count] [bigint] NULL,
	[version_ghost_record_count] [bigint] NULL,
	[min_record_size_in_bytes] [int] NULL,
	[max_record_size_in_bytes] [int] NULL,
	[avg_record_size_in_bytes] [float] NULL,
	[forwarded_record_count] [bigint] NULL,
	[compressed_page_count] [bigint] NULL
) ON [PRIMARY]

declare @DBName nvarchar(100) ='BNYUK_ProductionAR_Port' ;
declare  @TableFqn nvarchar(100) = 'dbo.IssuerCaption';

declare  @DB nvarchar(100) = 'BNYUK_ProductionAR_Port'; 
declare  @TBL nvarchar(100) = 'IssuerCaption'; 
declare  @IDX nvarchar(100) = 'IDX_FK_AccountPeriod'; 
declare  @index_id int = 4 ;

    
	
	declare db_cursor cursor for 
		select DB, TBL, IDX, index_id from #TablesToAnalyze ;
	open db_cursor
	fetch next from db_Cursor into @DB, @TBL, @IDX, @index_id;

	while @@fetch_status = 0 
	begin		
		insert into #IndexStats
			SELECT *
			FROM   sys.dm_db_index_physical_stats(DB_ID(@DB), OBJECT_ID(@TBL), @index_id, NULL, 'DETAILED') AS IPS;

		fetch next from db_Cursor into @DB, @TBL, @IDX, @index_id;
	end
	
	close db_cursor ;
	deallocate db_cursor ;

SELECT DB_NAME() as DBNAME,
	T.name AS TBL, 
		TS.SchemaName,
		TS.RowCounts as TblRowCnt,
		TS.Used_MB as UsedTblMB,
		TS.Unused_MB as UnUsedTblMB,
		TS.Total_MB as TotalMB,
       I.name AS IDX, 
       I.allow_row_locks, 
       allow_page_locks, 
       CAST((8600 / avg_record_size_in_bytes) AS INT) AS DBRowsLockedPerPageLock, 
       X.*
FROM   #IndexStats X
JOIN sys.tables T
           ON T.object_id = X.object_id
JOIN sys.indexes I
           ON T.object_id = I.object_id
join #TableSizeStats TS
	ON TS.object_id = T.object_id
		

