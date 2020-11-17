
declare @DBName varchar(100) = 'KenticoCMS_PRD_1';
DECLARE
       @dbid INT;
SELECT
       @dbid = db_id (@DBName) ;

SELECT
       TableName = object_name (s.object_id) 
     ,Reads = SUM (user_seeks + user_scans + user_lookups) 
     , Writes = SUM (user_updates) 
FROM
     sys.dm_db_index_usage_stats AS s
     INNER JOIN sys.indexes AS i
     ON
       s.object_id = i.object_id AND
       i.index_id = s.index_id
WHERE       
       s.database_id = @dbid
	  -- and objectproperty (s.object_id , 'IsUserTable') = 1
GROUP BY
         object_name (s.object_id) 
ORDER BY Reads  DESC,
         writes DESC;

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
