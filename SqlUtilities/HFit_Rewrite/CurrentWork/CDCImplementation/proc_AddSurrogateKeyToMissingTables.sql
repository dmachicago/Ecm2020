
-- use KenticoCMS_Datamart_2
-- drop table #MissingCols
-- Alter table BASE_CMS_Class_CTVerHIST ADD SurrogateKey_BASE_CMS_Class_CTVerHIST bigint identity (1,1) not null 

SELECT
       table_name
INTO
     #MissingCols
FROM INFORMATION_SCHEMA.TABLES AS T
WHERE
       T.TABLE_CATALOG = 'KenticoCMS_Datamart_2' AND
       T.table_name != 'sysdiagrams' AND
	   T.table_type = 'BASE TABLE' AND
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

DECLARE
       @table_name AS NVARCHAR (250) 
     , @MySql AS NVARCHAR (250) 
     , @KeyName AS NVARCHAR (250) 
     , @i AS INTEGER = 0;

DELETE FROM #MissingCols
WHERE
      table_name LIKE 'view%';

DECLARE C10 CURSOR
    FOR SELECT
               table_name
        FROM #MissingCols;

OPEN C10;
FETCH NEXT FROM C10 INTO @table_name;

WHILE
       @@FETCH_STATUS = 0
    BEGIN

        SET @i = (SELECT
                         count (*) 
                  FROM	sys.columns
                  WHERE
                         object_id = object_id (@table_name) AND
                         is_identity = 1) ;
        IF @i = 0
            BEGIN
                SET @KeyName = 'SurrogateKey_' + @table_name;
                SET @MySql = 'Alter table ' + @table_name + ' ADD ' + @KeyName + ' bigint identity (1,1) not null ';
                PRINT @MySql;
                EXEC (@MySql) ;
            END;
        ELSE
            BEGIN
                PRINT 'NOTICE: ' + @table_name + ' already has an IDENTITY column, skipping. ';
            END;
        FETCH NEXT FROM C10 INTO @table_name;
    END;

CLOSE C10;
DEALLOCATE C10;