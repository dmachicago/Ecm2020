select distinct object_name(i.object_id) AS tablename, i.name AS indexname, i.type_desc     as type 
from sys.indexes i
join sys.index_columns ic on ic.object_id = i.object_id and ic.index_id = i.index_id
join sys.columns c on c.column_id = ic.index_column_id 
join sys.types t on t.system_type_id = c.system_type_id
join sys.objects o on o.object_id = i.object_id
where i.type_desc = 'clustered'
--AND t.name = 'uniqueidentifier'
and object_name(i.object_id) not like 'sys%'
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
