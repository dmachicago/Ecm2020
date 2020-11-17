Select referencing_schema_name,
	Referencing_entity_name,
	Referencing_id,
	Referencing_class_desc
from sys.dm_sql_referencing_entities ('dbo.HFit_View_EDW_HealthAssesment', 'OBJECT')
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
