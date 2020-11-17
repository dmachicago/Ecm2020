
DECLARE
@FromTbl AS NVARCHAR (250) = 'view_EDW_HealthAssesment_MART'
, @ToTbl AS NVARCHAR (250) = 'view_EDW_HealthAssessmentV2';

-- Use KenticoCMS_Datamart_2

--Select table_name, column_name, data_type
--from INFORMATION_SCHEMA.COLUMNS
--where table_name = @FromTbl
--union all
--Select table_name, column_name, data_type
--from INFORMATION_SCHEMA.COLUMNS 
--where table_name = @ToTbl
--order by column_name,table_name asc,  data_type

-- drop table #TEMP_VIEW_COL_COMPARE

SELECT
       X.*
INTO
     #TEMP_VIEW_COL_COMPARE
FROM (SELECT
             table_name
           , column_name
           , data_type
      FROM INFORMATION_SCHEMA.COLUMNS
      WHERE
             table_name = @FromTbl
      UNION ALL
      SELECT
             table_name
           , column_name
           , data_type
      FROM INFORMATION_SCHEMA.COLUMNS
      WHERE
             table_name = @ToTbl) AS X;

SELECT
       *
FROM #TEMP_VIEW_COL_COMPARE
WHERE column_name IN
(
SELECT
       column_name
     , table_name
FROM #TEMP_VIEW_COL_COMPARE
GROUP BY
         column_name
HAVING COUNT (*) != 2
);