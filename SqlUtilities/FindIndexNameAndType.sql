
SELECT 
    i.name 'Index Name',
    o.create_date,
	o.type 
FROM 
    sys.indexes i
INNER JOIN 
    sys.objects o ON i.object_ID = o.object_ID
WHERE 
    o.is_ms_shipped = 0
    AND o.type IN ('PK', 'FK', 'UQ', 'U', 'V', 'IT')


-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
