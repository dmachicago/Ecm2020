select OBJECT_NAME(object_id) AS tblName, name from sys.indexes where name like 'PI_%'
union
select OBJECT_NAME(object_id) AS tblName, name from sys.indexes where name like '%_PI'
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
