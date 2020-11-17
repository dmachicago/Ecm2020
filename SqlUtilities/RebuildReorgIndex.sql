
--If an index is very small (I believe less than 8 pages) it will use mixed extents. 
--Therefore, it'll appear as if there is still fragmentation remaining, as the housing 
--extent will contain pages from multiple indexes.
--Because of this, and also the fact that in such a small index that fragmentation is 
--typically negligable, you really should only be rebuilding indexes with a certain page 
--threshold. It is best practices to rebuild fragmented indexes that are a minimum of 1000 pages.
--After the degree of fragmentation is known, use the following table to determine 
--the best method to correct the fragmentation.
--avg_fragmentation_in_percent value	Corrective statement
--	> 5% and < = 30%						ALTER INDEX REORGANIZE
--	> 30%									ALTER INDEX REBUILD WITH (ONLINE = ON) 
--EXEC sp_updatestats; 
--Gen REBUILD statements
IF OBJECT_ID('tempdb..#IdxRebuild') IS NOT NULL
    DROP TABLE #IdxRebuild;
CREATE TABLE #IdxRebuild(CMD NVARCHAR(MAX) NULL);
go

DECLARE @ShowDetails AS BIT= 0;
DECLARE @MinFragPct INT= 30;
DECLARE @MaxFragPct INT= 30;

IF(@ShowDetails = 1)
    SELECT 'Alter Index ' + SI.name + ' ON ' + SCH.name + '.' + OBJECT_NAME(IPS.object_id) + ' REBUILD  WITH (ONLINE = ON); ' AS CMD, 
           IPS.Index_type_desc, 
           IPS.avg_fragmentation_in_percent, 
           IPS.avg_fragment_size_in_pages, 
           CAST(IPS.avg_page_space_used_in_percent AS DECIMAL(5, 2)) AS avg_page_space_used_in_percent, 
           IPS.record_count, 
           IPS.ghost_record_count, 
           IPS.fragment_count, 
           IPS.avg_fragment_size_in_pages
    FROM sys.dm_db_index_physical_stats(DB_ID(N'DEV'), NULL, NULL, NULL, 'DETAILED') IPS
         JOIN sys.tables ST WITH(NOLOCK) ON IPS.object_id = ST.object_id
         JOIN sys.indexes SI WITH(NOLOCK) ON IPS.object_id = SI.object_id
                                             AND IPS.index_id = SI.index_id
         JOIN sys.schemas SCH ON ST.schema_id = SCH.schema_id
    WHERE ST.is_ms_shipped = 0
          AND IPS.avg_fragmentation_in_percent >= @MaxFragPct
    ORDER BY IPS.avg_fragmentation_in_percent DESC;
INSERT INTO #IdxRebuild(CMD)
       SELECT 'Alter Index ' + SCH.name + '.' + SI.name + ' ON ' + OBJECT_NAME(IPS.object_id) + ' REBUILD  WITH (ONLINE = ON); ' AS CMD
       --SELECT 'Alter Index ' + SI.name + ' ON ' + OBJECT_NAME(IPS.object_id) + ' REBUILD  WITH (ONLINE = ON); ' AS CMD
       FROM sys.dm_db_index_physical_stats(DB_ID(N'DEV'), NULL, NULL, NULL, 'DETAILED') IPS
            JOIN sys.tables ST WITH(NOLOCK) ON IPS.object_id = ST.object_id
            JOIN sys.indexes SI WITH(NOLOCK) ON IPS.object_id = SI.object_id
                                                AND IPS.index_id = SI.index_id
            JOIN sys.schemas SCH ON ST.schema_id = SCH.schema_id
       WHERE ST.is_ms_shipped = 0
             AND IPS.avg_fragmentation_in_percent >= @MaxFragPct
             AND 1 IS NOT NULL;
IF @ShowDetails = 1
    SELECT 'Alter Index ' + sch.name + '.' + SI.name + ' ON ' + OBJECT_NAME(IPS.object_id) + ' REORGANIZE; ' AS CMD, 
           IPS.Index_type_desc, 
           IPS.avg_fragmentation_in_percent, 
           IPS.avg_fragment_size_in_pages, 
           CAST(IPS.avg_page_space_used_in_percent AS DECIMAL(5, 2)) AS avg_page_space_used_in_percent, 
           IPS.record_count, 
           IPS.ghost_record_count, 
           IPS.fragment_count, 
           IPS.avg_fragment_size_in_pages
    FROM sys.dm_db_index_physical_stats(DB_ID(N'DEV'), NULL, NULL, NULL, 'DETAILED') IPS
         JOIN sys.tables ST WITH(NOLOCK) ON IPS.object_id = ST.object_id
         JOIN sys.indexes SI WITH(NOLOCK) ON IPS.object_id = SI.object_id
                                             AND IPS.index_id = SI.index_id
         JOIN sys.schemas SCH ON ST.schema_id = SCH.schema_id
    WHERE ST.is_ms_shipped = 0
          AND IPS.avg_fragmentation_in_percent >= @MinFragPct
          AND IPS.avg_fragmentation_in_percent < @MaxFragPct
    ORDER BY IPS.avg_fragmentation_in_percent DESC;
INSERT INTO #IdxRebuild(CMD)
       SELECT 'Alter Index ' + sch.name + '.' + SI.name + ' ON ' + OBJECT_NAME(IPS.object_id) + ' REORGANIZE; ' AS CMD
       FROM sys.dm_db_index_physical_stats(DB_ID(N'DEV'), NULL, NULL, NULL, 'DETAILED') IPS
            JOIN sys.tables ST WITH(NOLOCK) ON IPS.object_id = ST.object_id
            JOIN sys.indexes SI WITH(NOLOCK) ON IPS.object_id = SI.object_id
                                                AND IPS.index_id = SI.index_id
            JOIN sys.schemas SCH ON ST.schema_id = SCH.schema_id
       WHERE ST.is_ms_shipped = 0
             AND IPS.avg_fragmentation_in_percent >= @MinFragPct
             AND IPS.avg_fragmentation_in_percent < @MaxFragPct
       ORDER BY IPS.avg_fragmentation_in_percent DESC;
IF @ShowDetails = 1
    SELECT OBJECT_NAME(IPS.object_id) AS [TableName], 
           SI.name AS [IndexName], 
           IPS.Index_type_desc, 
           IPS.avg_fragmentation_in_percent, 
           IPS.avg_fragment_size_in_pages, 
           CAST(IPS.avg_page_space_used_in_percent AS DECIMAL(5, 2)) AS avg_page_space_used_in_percent, 
           IPS.record_count, 
           IPS.ghost_record_count, 
           IPS.fragment_count, 
           IPS.avg_fragment_size_in_pages
    FROM sys.dm_db_index_physical_stats(DB_ID(N'DEV'), NULL, NULL, NULL, 'DETAILED') IPS
         JOIN sys.tables ST WITH(NOLOCK) ON IPS.object_id = ST.object_id
         JOIN sys.indexes SI WITH(NOLOCK) ON IPS.object_id = SI.object_id
                                             AND IPS.index_id = SI.index_id
    WHERE ST.is_ms_shipped = 0
          AND IPS.avg_fragmentation_in_percent >= 10
    ORDER BY 1, 
             5;

-- PERFORM TABLE STATISTICS UPDATES
--UPDATE STATISTICS Analytics_HourHits WITH FULLSCAN, ALL
INSERT INTO #IdxRebuild(CMD)
       SELECT 'UPDATE STATISTICS ' + table_schema + '.' + TABLE_NAME + ' WITH FULLSCAN, ALL' + CHAR(10) + 'print ''STATISTICS ON: ' + table_schema + '.' + TABLE_NAME + '''' + CHAR(10) AS CMD
       FROM INFORMATION_SCHEMA.tables
       WHERE TABLE_TYPE = 'BASE TABLE';
DELETE FROM #IdxRebuild
WHERE cmd IS NULL;
UPDATE #IdxRebuild
  SET 
      cmd = cmd + CHAR(10) + 'GO' + CHAR(10);
SELECT *
FROM #IdxRebuild;
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016