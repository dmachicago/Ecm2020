SELECT T.name AS [TABLE NAME], 
       I.rows AS [ROWCOUNT] 
FROM   sys.tables AS T 
       INNER JOIN sys.sysindexes AS I 
               ON T.object_id = I.id 
                  AND I.indid < 2 
ORDER  BY T.name, I.rows DESC 
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
