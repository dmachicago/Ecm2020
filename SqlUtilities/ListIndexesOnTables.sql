SELECT
            so.name AS TableName
            , si.name AS IndexName
            , si.type_desc AS IndexType
FROM
            sys.indexes si
            JOIN sys.objects so ON si.[object_id] = so.[object_id]
WHERE
            so.type = 'U'    --Only get indexes for User Created Tables
            AND si.name IS NOT NULL
			AND so.name like 'HFit_Tracker%'
			AND (si.name like '%createdate' or si.name like '%moddate')
ORDER BY
            so.name, si.type 
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
