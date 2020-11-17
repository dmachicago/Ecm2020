
SELECT
DB_NAME(ips.database_id) DBName,
OBJECT_NAME(ips.object_id) ObjName,
i.name InxName,
ips.avg_fragmentation_in_percent
FROM sys.dm_db_index_physical_stats(db_id('KenticoCMS_ProdStaging'),
default, default, default, default) ips
INNER JOIN sys.indexes i
ON ips.index_id = i.index_id AND
ips.object_id = i.object_id
WHERE
ips.object_id > 99 AND
ips.avg_fragmentation_in_percent >= 10 AND
ips.index_id > 0
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
