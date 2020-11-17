select object_name(object_id) as TableName, name, type_desc from sys.indexes 
where name like 'CI%' or name like '%CI'
order by TableNAme
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
