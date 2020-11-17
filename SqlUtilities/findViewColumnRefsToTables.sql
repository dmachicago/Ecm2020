select distinct
  cols.*, objs.referenced_entity_name
from
  sys.sql_expression_dependencies objs
  outer apply sys.dm_sql_referenced_entities ( OBJECT_SCHEMA_NAME(objs.referencing_id) + N'.' + object_name(objs.referencing_id), N'OBJECT' ) as cols
where
  --objs.referencing_id = object_id('view_EDW_HealthAssesment')
  objs.referencing_id like object_id('view_EDW_HealthAssesment')
  and referenced_minor_name like '%Guid'

select distinct
  cols.*, objs.referenced_entity_name
from
  sys.sql_expression_dependencies objs
  outer apply sys.dm_sql_referenced_entities ( OBJECT_SCHEMA_NAME(objs.referencing_id) + N'.' + object_name(objs.referencing_id), N'OBJECT' ) as cols
where
  --objs.referencing_id = object_id('view_EDW_HealthAssesment')
  objs.referencing_id like object_id('view_EDW_HFit_HealthAssesmentUserRiskArea')
  and referenced_minor_name like '%Guid'
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
