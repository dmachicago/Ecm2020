select table_name as VIEW_NAME from information_schema.views
where table_name like '%EDW%'
and VIEW_DEFINITION like '%hashbytes%'

select table_name as VIEW_NAME from information_schema.views
where (table_name like '%_CT' or table_name like '%_CT_%') and table_name like '%EDW%'

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
