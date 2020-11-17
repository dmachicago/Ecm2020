
-- exec UTIL_FindText 'miller'
Alter PROCEDURE dbo.UTIL_FindText
    @SearchValue nvarchar(500) 
AS 
-- DMA, Limited July 26, 2014
-- Developer:	W. Dale Miller
-- License MIT Open Source
SELECT DISTINCT
    s.name+'.'+o.name AS Object_Name,o.type_desc
    FROM sys.sql_modules        m
        INNER JOIN sys.objects  o ON m.object_id=o.object_id
        INNER JOIN sys.schemas  s ON o.schema_id=s.schema_id
    WHERE m.definition Like '%'+@SearchValue+'%'
        --AND o.Type='P'  --<uncomment if you only want to search procedures
    ORDER BY 1
GO
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
