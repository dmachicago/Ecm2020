--FindTablesUsedInView
SELECT view_name, Table_Name
FROM INFORMATION_SCHEMA.VIEW_TABLE_USAGE
WHERE View_Name like '%view_EDW_TrackerCompositeDetails%'
ORDER BY view_name, table_name

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
