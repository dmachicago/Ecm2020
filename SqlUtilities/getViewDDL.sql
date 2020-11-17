select definition
from sys.objects     o
join sys.sql_modules m on m.object_id = o.object_id
where o.object_id = object_id( 'view_EDW_HealthAssesmentDeffinition')
  and o.type      = 'V'
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
