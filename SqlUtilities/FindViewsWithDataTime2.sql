
select C.TABLE_NAME,COLUMN_NAME,DATA_TYPE from information_schema.columns C
    join information_schema.tables T on T.Table_name = C.Table_name
where C.table_name like '%EDW%'
--and column_name like '%when%'
and DATA_TYPE like '%datetime2%'
and T.TABLE_TYPE = 'VIEW'
order by C.TABLE_NAME,COLUMN_NAME
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
