
IF OBJECT_ID('tempdb..#TEMP_IDX_FRAG') IS NOT NULL DROP TABLE #TEMP_IDX_FRAG;

CREATE TABLE [#TEMP_IDX_FRAG]
([DBName]               [NVARCHAR](128) NULL, 
 [Schema]               [SYSNAME] NOT NULL, 
 [Table]                [SYSNAME] NOT NULL, 
 [Index]                [SYSNAME] NULL, 
 [alloc_unit_type_desc] [NVARCHAR](60) NULL, 
 [AvgPctFrag]           [DECIMAL](6, 2) NULL, 
 [page_count]           [BIGINT] NULL
)
ON [PRIMARY];


declare @stmt nvarchar(2000) ;
set @stmt =  'print ''Processing DB: '' + DB_NAME(); ';
set @stmt = @stmt + 'INSERT INTO #TEMP_IDX_FRAG '+char(10)+'SELECT DB_NAME() AS DBName,
       dbschemas.[name] AS ''Schema'', 
       dbtables.[name] AS ''Table'', 
       dbindexes.[name] AS ''Index'', 
       indexstats.alloc_unit_type_desc, 
       CAST(indexstats.avg_fragmentation_in_percent AS DECIMAL(6, 2)) AS AvgPctFrag, 
       indexstats.page_count
FROM sys.dm_db_index_physical_stats(DB_ID(), NULL, NULL, NULL, NULL) AS indexstats
     INNER JOIN sys.tables dbtables ON dbtables.[object_id] = indexstats.[object_id]
     INNER JOIN sys.schemas dbschemas ON dbtables.[schema_id] = dbschemas.[schema_id]
     INNER JOIN sys.indexes AS dbindexes ON dbindexes.[object_id] = indexstats.[object_id]
                                            AND indexstats.index_id = dbindexes.index_id
WHERE indexstats.database_id = DB_ID()
      AND indexstats.avg_fragmentation_in_percent >= 10
ORDER BY indexstats.avg_fragmentation_in_percent DESC; ';


DECLARE @command varchar(1000) ;
SELECT @command = 'USE ? ; ' + @stmt;
EXEC sp_MSforeachdb @command ;

select * from [#TEMP_IDX_FRAG]