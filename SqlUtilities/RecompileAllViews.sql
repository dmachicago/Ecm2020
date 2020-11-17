SELECT DISTINCT 'EXEC sp_refreshview ''' + name + '''' 
FROM sys.objects AS so 
INNER JOIN sys.sql_expression_dependencies AS sed 
    ON so.object_id = sed.referencing_id 
WHERE so.type = 'V' 
--AND sed.referenced_id = OBJECT_ID('Person.Person');
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
