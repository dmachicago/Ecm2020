


/*
--Copyright @ DMA Limited, June 2012, all rights reserved.
--FIND All views that use a specific table.
--Author: W. Dale Miller
*/

SELECT view_name, Table_Name
FROM INFORMATION_SCHEMA.VIEW_TABLE_USAGE
WHERE Table_Name= 'CMS_TREE'
ORDER BY view_name, table_name
GO
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
