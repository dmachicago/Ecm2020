
select distinct T.TABLE_NAME, COLUMN_NAME
from INFORMATION_SCHEMA.TABLES T
join INFORMATION_SCHEMA.COLUMNS c on c.TABLE_SCHEMA = T.TABLE_SCHEMA
and c.TABLE_NAME = T.TABLE_NAME
--and (column_name like '%modi%' )
and T.Table_Name like 'EDW_HealthAssessment'
and c.DATA_TYPE = 'datetime'
order by T.TABLE_NAME, COLUMN_NAME


-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
