SELECT
    c.name AS columnName,
    columnTypes.name as dataType,
    aliases.name as alias
FROM 
sys.views v 
JOIN sys.sql_dependencies d 
    ON d.object_id = v.object_id
JOIN .sys.objects t 
    ON t.object_id = d.referenced_major_id
JOIN sys.columns c 
    ON c.object_id = d.referenced_major_id 
JOIN sys.types AS columnTypes 
    ON c.user_type_id=columnTypes.user_type_id
    AND c.column_id = d.referenced_minor_id
JOIN sys.columns AS aliases
    on c.column_id=aliases.column_id
    AND aliases.object_id = object_id('view_EDW_HealthAssesmentDeffinition')
WHERE
    v.name = 'view_EDW_HealthAssesmentDeffinition';
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
