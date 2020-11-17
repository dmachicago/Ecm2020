select * from INFORMATION_SCHEMA.TABLES
select * from INFORMATION_SCHEMA.COLUMNS

--The table description is an extended property, you can query them from sys.extended_properties:

select top 100
    TableName = tbl.table_schema + '.' + tbl.table_name, 
    TableDescription = prop.value,
    ColumnName = col.column_name, 
    ColumnDataType = col.data_type
FROM information_schema.tables tbl
INNER JOIN information_schema.columns col 
    ON col.table_name = tbl.table_name
LEFT JOIN sys.extended_properties prop 
    ON prop.major_id = object_id(tbl.table_schema + '.' + tbl.table_name) 
    AND prop.minor_id = 0
    AND prop.name = 'MS_Description' 
WHERE tbl.table_type = 'base table'
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
