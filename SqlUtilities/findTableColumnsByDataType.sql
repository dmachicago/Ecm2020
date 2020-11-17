

-- use KenticoCMS_DataMArt

SELECT
       *
FROM INFORMATION_SCHEMA.columns
WHERE
       table_Name = 'view_MART_HealthAssesment' AND
       TABLE_SCHEMA = 'dbo' AND
       DATA_TYPE IN ('int' , 'decimal' , 'tinyint' , 'bigint' , 'bit' , 'float') ;

SELECT
       *
FROM INFORMATION_SCHEMA.columns
WHERE
       table_Name = 'view_MART_HealthAssesment' AND
       TABLE_SCHEMA = 'dbo' AND
       DATA_TYPE LIKE 'datetime%';

SELECT
       *
FROM INFORMATION_SCHEMA.columns
WHERE
       table_Name = 'view_MART_HealthAssesment' AND
       TABLE_SCHEMA = 'dbo' AND
       DATA_TYPE LIKE '%char%';

SELECT
       *
FROM INFORMATION_SCHEMA.columns
WHERE
       table_Name = 'view_MART_HealthAssesment' AND
       TABLE_SCHEMA = 'dbo' AND
       DATA_TYPE NOT IN ('int' , 'decimal' , 'tinyint' , 'bigint' , 'bit' , 'float') ;

SELECT DISTINCT
       data_type
FROM INFORMATION_SCHEMA.columns;
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
