DECLARE @PctFrag INT= 30;
SELECT @@SERVERNAME AS SVRNAME, 
       DB_NAME() AS DBNAME, 
       a.index_id, 
       OBJECT_NAME(a.object_id), 
       name, 
       cast(avg_fragmentation_in_percent as decimal(5,2)) as PctFrag
FROM sys.dm_db_index_physical_stats(DB_ID(DB_NAME()), NULL, NULL, NULL, NULL) AS a
     JOIN sys.indexes AS b ON a.object_id = b.object_id
                              AND a.index_id = b.index_id
WHERE avg_fragmentation_in_percent > @PctFrag
ORDER BY avg_fragmentation_in_percent DESC;
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
