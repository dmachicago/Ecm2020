-- drop table #MissingCols
SELECT
       table_name
INTO
     #MissingCols
FROM INFORMATION_SCHEMA.TABLES AS T
WHERE
       T.TABLE_CATALOG = 'KenticoCMS_Datamart_2' AND
       T.table_name != 'sysdiagrams' AND
       T.table_name NOT LIKE 'schema%' AND
       NOT EXISTS (
       SELECT
              *
       FROM INFORMATION_SCHEMA.COLUMNS AS C
       WHERE
              C.TABLE_CATALOG = T.TABLE_CATALOG AND
              C.TABLE_SCHEMA = T.TABLE_SCHEMA AND
              C.TABLE_NAME = T.TABLE_NAME AND
              C.COLUMN_NAME LIKE 'SurrogateKey%') ;

DELETE FROM #MissingCols
WHERE
      table_name LIKE 'view%';

SELECT * FROM #MissingCols; 