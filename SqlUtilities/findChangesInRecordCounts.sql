
--Find changes in record counts
SELECT TableName = SCHEMA_NAME(schema_id)+'.'+o.name,Rows = max(i.rows)
FROM sys.sysobjects o
INNER JOIN sys.sysindexes i ON o.id = i.id
INNER JOIN sys.objects oo ON o.id = oo.object_id
WHERE xtype = 'u' AND OBJECTPROPERTY(o.id,N'IsUserTable') = 1
GROUP BY schema_id, o.name
ORDER BY TableName asc
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
