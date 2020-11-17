--WDM: August 12, 2011
--W. Dale Miller
--DMA Limited, Chicago, IL
--This script is a starting point to find unused indexes. Look closley at User Scan, 
--User Lookup, and User Update when you are considering dropping an index. The generic understanding 
--is if this values are all high and User Seek is low, the index needs tuning. The index drop 
--script is also provided in the last column.
SELECT OBJ.name AS ObjectName, 
       IDX.name AS IndexName, 
       IDX.index_id AS IndexID, 
       dm_ius.user_seeks AS UserSeek, 
       dm_ius.user_scans AS UserScans, 
       dm_ius.user_lookups AS UserLookups, 
       dm_ius.user_updates AS UserUpdates, 
       PRTN.TableRows, 
       'DROP INDEX ' + QUOTENAME(IDX.name) + ' ON ' + QUOTENAME(s.name) + '.' + QUOTENAME(OBJECT_NAME(dm_ius.OBJECT_ID)) AS 'drop statement',
	   'ALTER  INDEX ' + QUOTENAME(IDX.name) + ' ON ' + QUOTENAME(s.name) + '.' + QUOTENAME(OBJECT_NAME(dm_ius.OBJECT_ID)) as Rebuild_Stmt
FROM sys.dm_db_index_usage_stats dm_ius
     INNER JOIN sys.indexes IDX ON IDX.index_id = dm_ius.index_id
                                   AND dm_ius.OBJECT_ID = IDX.OBJECT_ID
     INNER JOIN sys.objects OBJ ON dm_ius.OBJECT_ID = OBJ.OBJECT_ID
     INNER JOIN sys.schemas s ON OBJ.schema_id = s.schema_id
     INNER JOIN
(
    SELECT SUM(PRTN.rows) TableRows, 
           PRTN.index_id, 
           PRTN.OBJECT_ID
    FROM sys.partitions PRTN
    GROUP BY PRTN.index_id, 
             PRTN.OBJECT_ID
) PRTN ON PRTN.index_id = dm_ius.index_id
          AND dm_ius.OBJECT_ID = PRTN.OBJECT_ID
WHERE OBJECTPROPERTY(dm_ius.OBJECT_ID, 'IsUserTable') = 1
      AND dm_ius.database_id = DB_ID()
      --AND IDX.type_desc = 'nonclustered'
      AND IDX.is_primary_key = 0
      AND IDX.is_unique_constraint = 0
ORDER BY(dm_ius.user_seeks + dm_ius.user_scans + dm_ius.user_lookups) ASC;
GO
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016