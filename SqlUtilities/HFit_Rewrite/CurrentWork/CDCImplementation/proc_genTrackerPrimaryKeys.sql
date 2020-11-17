
-- use KenticoCMS_DataMart_2
--proc_genTrackerPrimaryKeys
GO
PRINT 'Executing proc_genTrackerPrimaryKeys.sql';
GO
IF EXISTS (SELECT
                  name
                  FROM sys.procedures
                  WHERE
                  name = 'proc_genTrackerPrimaryKeys') 
    BEGIN
        DROP PROCEDURE
             proc_genTrackerPrimaryKeys;
    END;
GO
-- EXEC proc_genTrackerPrimaryKeys 1
CREATE PROCEDURE proc_genTrackerPrimaryKeys (
       @PreviewOnly AS INT = 0) 
AS
BEGIN
    BEGIN TRY
        CLOSE CUR;
        DEALLOCATE CUR;
    END TRY
    BEGIN CATCH
        PRINT 'CURSOR#1 DEALLOCATED, proceeding.';
    END CATCH;
    BEGIN TRY
        CLOSE CUR2;
        DEALLOCATE CUR2;
    END TRY
    BEGIN CATCH
        PRINT 'CURSOR#2 DEALLOCATED, proceeding.';
    END CATCH;
    DECLARE
           @MySql AS NVARCHAR (MAX) = ''
         , @msg AS NVARCHAR (MAX) = ''
         , @TblName AS NVARCHAR (MAX) = '';
    DECLARE CUR CURSOR
        FOR
            SELECT DISTINCT
                   T.table_name
                 , 'IF not exists ' + char (10) + '(' + char (10) + 'SELECT CONSTRAINT_NAME FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_TYPE = ''PRIMARY KEY'' ' + char (10) + 'AND TABLE_NAME = ''' + T.table_name + ''' ' + char (10) + 'AND TABLE_SCHEMA =''dbo''' + char (10) + ')' + char (10) + 'ALTER TABLE ' + T.table_name + ' ADD CONSTRAINT ' + T.table_name + '_PKID ' + 'PRIMARY KEY (SVR, DBNAME, UserID, ITemID) ' + char (10) + '; -- GO' AS TSQL
                   FROM
                        information_schema.tables AS T JOIN information_schema.columns AS C
                            ON
                   T.Table_name = C.Table_name AND
                   C.Column_name IN ('ItemID' , 'UserID' , 'SVR' , 'DBNAME') 
                   WHERE T.table_name LIKE 'FACT_Hfit_Tracker%';

    OPEN CUR;

    FETCH NEXT FROM CUR INTO @TblName , @MySql;

    WHILE
           @@FETCH_STATUS = 0
        BEGIN
            BEGIN TRY
                IF @PreviewOnly = 0
                    BEGIN
                        EXEC (@MySql) 
                    END;
                SET @msg = 'PKey ON: ' + @TblName;
                EXEC printImmediate @msg;
                IF @PreviewOnly = 1
                    BEGIN
                        PRINT @MySql;
                    END;
            END TRY
            BEGIN CATCH
                SET @msg = 'FAILED: ' + @MySql;
                EXEC printImmediate @msg;
            END CATCH;
            FETCH NEXT FROM CUR INTO @TblName , @MySql;
        END;
    CLOSE CUR;
    DEALLOCATE CUR;

    DECLARE CUR1 CURSOR
        FOR
            SELECT DISTINCT
                   table_name
                 , 'if not exists (select name from sys.indexes where name = ''PISurKey_' + table_name + ''') ' + char (10) + 'BEGIN' + char (10) + '     Create Index PISurKey_' + table_name + ' ON ' + table_name + char (10) + '         (' + Column_name + ')' + char (10) + 'END' + char (10) 
                   FROM information_schema.columns
                   WHERE
                         table_name LIKE 'FACT_Hfit_Tracker%' AND
                   column_name = 'RowNumber';

    OPEN CUR1;

    FETCH NEXT FROM CUR1 INTO @TblName , @MySql;

    WHILE
           @@FETCH_STATUS = 0
        BEGIN
            BEGIN TRY
                IF @PreviewOnly = 0
                    BEGIN
                        EXEC (@MySql) 
                    END;
                SET @msg = 'SUR Key: ' + @TblName;
                EXEC printImmediate @msg;
                IF @PreviewOnly = 1
                    BEGIN
                        PRINT @MySql;
                    END;
            END TRY
            BEGIN CATCH
                SET @msg = 'FAILED: ' + @MySql;
                EXEC printImmediate @msg;
            END CATCH;
            FETCH NEXT FROM CUR1 INTO @TblName , @MySql;
        END;
    CLOSE CUR1;
    DEALLOCATE CUR1;

END;
GO
PRINT 'Executing proc_genTrackerPrimaryKeys.sql';
GO
