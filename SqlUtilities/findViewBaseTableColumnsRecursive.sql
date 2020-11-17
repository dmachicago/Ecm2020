
/*
--Copyright @ DMA Limited, June 2012, all rights reserved.
--FIND a top level view's nested tables and views using a CTE.
--Author: W. Dale Miller
--Narritive:
--  A recursive CTE requires four elements in order to work properly.
--  Anchor query (runs once and the results ‘seed’ the Recursive query)
--  Recursive query (runs multiple times and is the criteria for the remaining results)
--  UNION ALL statement to bind the Anchor and Recursive queries together.
--  INNER JOIN statement to bind the Recursive query to the results of the CTE.
*/

GO
select top 100 * from INFORMATION_SCHEMA.columns 
go 
WITH mycte
    AS (SELECT
               TU.view_name
             , TU.Table_Name
             , IST.TABLE_TYPE, ISC.COLUMN_NAME, ISC.ORDINAL_POSITION, ISC.DATA_TYPE
               FROM
                    INFORMATION_SCHEMA.VIEW_TABLE_USAGE AS TU WITH (NOLOCK) 
                        JOIN INFORMATION_SCHEMA.tables AS IST
                            ON IST.TABLE_NAME = TU.TABLE_NAME
				join INFORMATION_SCHEMA.columns as ISC on ISC.TABLE_NAME = TU.TABLE_NAME
          WHERE view_name = 'view_EDW_HEalthAssesment'

        UNION ALL

        SELECT
               ISV.view_name
             , ISV.Table_Name
             , IST.TABLE_TYPE, ISC.COLUMN_NAME, ISC.ORDINAL_POSITION, ISC.DATA_TYPE
               FROM
                    INFORMATION_SCHEMA.VIEW_TABLE_USAGE AS ISV
                        JOIN INFORMATION_SCHEMA.tables AS IST
                            ON IST.TABLE_NAME = ISV.TABLE_NAME
                        INNER JOIN mycte
                            ON ISV.view_name = mycte.table_name
				    join INFORMATION_SCHEMA.columns as ISC on ISC.TABLE_NAME = mycte.TABLE_NAME
    ) 

    SELECT
           *
           FROM mycte
      ORDER BY
               view_name, table_name;
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
