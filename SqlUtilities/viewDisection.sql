

--Copyright @ DMA Limited, October 2008, all rights reserved.
--List the source table name of columns in a VIEW 
--Author: W. Dale Miller

--select top 100 * from INFORMATION_SCHEMA.VIEW_COLUMN_USAGE where view_name  = 'view_EDW_HealthAssesment'
--select top 100 * from INFORMATION_SCHEMA.COLUMNS where table_name  = 'view_EDW_HealthAssesment'
--select top 100 * from INFORMATION_SCHEMA.views

SELECT
       'BaseName'
, CU.COLUMN_NAME
	   , CU.VIEW_NAME
     , CU.TABLE_NAME
     
     , C.ORDINAL_POSITION
	   , C.DATA_TYPE
     --, *
       FROM
            INFORMATION_SCHEMA.VIEW_COLUMN_USAGE AS cu
                JOIN INFORMATION_SCHEMA.COLUMNS AS c
                    ON c.TABLE_SCHEMA = cu.TABLE_SCHEMA
                   AND c.TABLE_CATALOG = cu.TABLE_CATALOG
                   AND c.TABLE_NAME = cu.TABLE_NAME
                   AND c.COLUMN_NAME = cu.COLUMN_NAME
  WHERE   cu.VIEW_NAME = 'view_EDW_HealthAssesment'
--order by COLUMN_NAME, TABLE_NAME ;
--AND     cu.VIEW_SCHEMA  = 'dbo'
--AND	   cu.column_name like '%culture%'
union 
SELECT
       'Alias', column_name, table_name, null as 'Table_Name', ordinal_position, data_type
       FROM information_schema.columns
  WHERE table_name = 'view_EDW_HealthAssesment'
    --AND column_name LIKE '%culture%'
order by column_name;


-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
