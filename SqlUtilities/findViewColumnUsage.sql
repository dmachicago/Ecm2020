
/*
--Copyright @ DMA Limited, June 2012, all rights reserved.
--FIND All columns within a view.
--Author: W. Dale Miller 
*/

--View_HFit_HealthAssesmentMultipleChoiceQuestion_Joined

DECLARE
   @tgtView AS nvarchar (100) = 'view_EDW_HealthAssesment';

--GET ALL Columns used within view
SELECT
       *
       FROM information_schema.view_column_usage
  WHERE view_name = 'view_EDW_HealthAssesment';
GO

--**************************************************************************
--GET ALL Columns used within view and see if it is defined as an alias.
--A NULL in ORDINAL_POSITION indicates it is an alias and will have 
--to be manually looked up in the referenced table or view.
--**************************************************************************
SELECT
       CU.TABLE_NAME
     , CU.COLUMN_NAME as SecondaryColumn
     , C.COLUMN_NAME as PrimaryColumn
     , C.ORDINAL_POSITION
     , C.DATA_TYPE
       FROM
            information_schema.view_column_usage AS CU
                full outer JOIN information_schema.columns AS C
                    ON C.TABLE_NAME = CU.VIEW_NAME
                   AND C.COLUMN_NAME = CU.COLUMN_NAME
  WHERE CU.view_name = 'view_EDW_HealthAssesment'
	   --and CU.COLUMN_NAME like '%Weighted%' 
order by C.ORDINAL_POSITION;
GO

--***********************************************************************************
--Using this QRY, ALL ColName_2 that are NULL require lookup in the basetable/view
--***********************************************************************************
SELECT DISTINCT
       ISC.TABLE_NAME
     , ISC.COLUMN_NAME AS COLNAME_1
     , CU.COLUMN_NAME AS COLNAME_2
     , ISC.ORDINAL_POSITION
       FROM
            INFORMATION_SCHEMA.COLUMNS AS ISC
                FULL OUTER JOIN INFORMATION_SCHEMA.VIEW_COLUMN_USAGE AS CU
                    ON ISC.TABLE_NAME = CU.VIEW_NAME
                   AND ISC.COLUMN_NAME = CU.COLUMN_NAME
  WHERE        ISC.TABLE_NAME = 'view_EDW_HealthAssesment'
			and  ( ISC.COLUMN_NAME like '%PreWeighted%' OR CU.COLUMN_NAME like '%PreWeighted%')
  ORDER BY
           ISC.ORDINAL_POSITION;
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
