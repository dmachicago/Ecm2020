/*
5/23/2009
Author: W. Dale Miller
Coptright: 
    @ May 2009
    DMA Limited, 742 Laurel Ave., Highland PArk, IL 60035
    All rights reserved
*/
SELECT T.table_name, T.table_type
FROM information_schema.tables T
WHERE NOT EXISTS 
   (
     SELECT * FROM information_schema.columns AS C
     WHERE T.table_name = C.table_name
     AND C.column_name like '%GUID%'
   )
AND T.table_name like '%EDW%'
AND T.table_TYPE like 'VIEW'
ORDER BY table_name;
GO

--view_EDW_RewardUserLevel
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
