
select distinct v.TABLE_NAME, COLUMN_NAME
from INFORMATION_SCHEMA.VIEWS v
join INFORMATION_SCHEMA.COLUMNS c on c.TABLE_SCHEMA = v.TABLE_SCHEMA
and c.TABLE_NAME = v.TABLE_NAME
and column_name like '%guid%' 
and v.Table_Name like 'View_HFit_HACampaign_Joined'
order by v.TABLE_NAME, COLUMN_NAME


select distinct T.TABLE_NAME, COLUMN_NAME
from INFORMATION_SCHEMA.TABLES T
join INFORMATION_SCHEMA.COLUMNS c on c.TABLE_SCHEMA = T.TABLE_SCHEMA
and c.TABLE_NAME = T.TABLE_NAME
and (column_name like '%ScreeningEventCategoryID%' )
--and T.Table_Name like 'HFit_Company'
order by T.TABLE_NAME, COLUMN_NAME


select distinct T.TABLE_NAME, c.COLUMN_NAME, c2.COLUMN_NAME
from INFORMATION_SCHEMA.TABLES T
join INFORMATION_SCHEMA.COLUMNS c on c.TABLE_SCHEMA = T.TABLE_SCHEMA
and c.TABLE_NAME = T.TABLE_NAME
and (column_name like '%survey%')
and T.Table_Name like '%challenge%'
join INFORMATION_SCHEMA.COLUMNS c2 on c2.TABLE_SCHEMA = T.TABLE_SCHEMA
and c2.TABLE_NAME = T.TABLE_NAME
and (c2.column_name like '%part%')
and T.Table_Name like '%challenge%'
order by T.TABLE_NAME, c.COLUMN_NAME, c2.COLUMN_NAME

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
