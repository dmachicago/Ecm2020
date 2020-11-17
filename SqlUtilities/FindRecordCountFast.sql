SELECT CONVERT(bigint, rows)
FROM sysindexes
WHERE id = OBJECT_ID('Device_RawNotification')
AND indid < 2

SELECT CAST(p.rows AS float)
FROM sys.tables AS tbl
INNER JOIN sys.indexes AS idx ON idx.object_id = tbl.object_id and idx.index_id < 2
INNER JOIN sys.partitions AS p ON p.object_id=CAST(tbl.object_id AS int)
AND p.index_id=idx.index_id
WHERE ((tbl.name=N'Device_RawNotification'
AND SCHEMA_NAME(tbl.schema_id)='dbo'))

SELECT SUM (row_count)
FROM sys.dm_db_partition_stats
WHERE object_id=OBJECT_ID('Device_RawNotification')   
AND (index_id=0 or index_id=1);
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
