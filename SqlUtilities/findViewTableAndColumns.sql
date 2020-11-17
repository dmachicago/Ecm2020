select * from information_schema.columns 
where 
column_name like '%ID' and 
table_name in 
(
select distinct objs.referenced_entity_name
from
  sys.sql_expression_dependencies objs
  outer apply sys.dm_sql_referenced_entities ( OBJECT_SCHEMA_NAME(objs.referencing_id) + N'.' + object_name(objs.referencing_id), N'OBJECT' ) as cols
where
  objs.referencing_id = object_id('view_EDW_HealthAssesmentDeffinition')
)

select * from information_schema.columns 
where 
column_name like '%GUID' and table_name = 'view_EDW_HealthAssesmentDeffinition'
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
