
-- use KenticoCMS_DataMart_2
GO
PRINT 'Executing proc_GenBaseViewNoNulls.sql';
GO
IF EXISTS (SELECT
                  name
                  FROM sys.procedures
                  WHERE
                  name = 'proc_GenBaseViewNoNulls') 
    BEGIN
        DROP PROCEDURE
             proc_GenBaseViewNoNulls
    END;
GO
-- exec proc_GenBaseViewNoNulls 'BASE_HFit_PPTEligibility'
-- exec proc_GenBaseViewNoNulls 'BASE_CMS_Site'
-- select * from VIEW_BASE_CMS_Site_NoNulls
CREATE PROCEDURE proc_GenBaseViewNoNulls (
       @TblName AS NVARCHAR (200)) 
AS
BEGIN

    --declare @TblName as nvarchar(200) = 'BASE_HFit_PPTEligibility' ;

    DECLARE
           @ViewName AS NVARCHAR (200) = 'VIEW_' + @TblName + '_NoNulls';

    DECLARE
           @MySql AS NVARCHAR (MAX) = ''
         , @DropSql AS NVARCHAR (MAX) = ''
         , @DATA_TYPE AS NVARCHAR (50) 
         , @COLUMN_NAME AS NVARCHAR (250) 
         , @iCnt AS BIGINT = 0;

    SET @DropSql = 'IF Exists (select name from sys.views where name = ''' + @ViewName + ''') drop view ' + @ViewName + ';' + char (10) ;
    SET @MySql = 'Create VIEW ' + @ViewName + ' AS ' + char (10) ;
    SET @MySql = @MySql + 'SELECT ' + char (10) ;

    -- SELECT DISTINCT(DATA_TYPE) FROM INFORMATION_SCHEMA.columns AS TC where table_name = 'BASE_HFit_PPTEligibility'
    DECLARE
           @S AS NVARCHAR (MAX) = '';
    SET @S = 'DECLARE PCursor CURSOR FOR ' + CHAR (10) ;
    SET @S = @S + ' SELECT ' + CHAR (10) ;
    SET @S = @S + '     COLUMN_NAME ' + CHAR (10) ;
    SET @S = @S + '     , DATA_TYPE ' + CHAR (10) ;
    SET @S = @S + ' FROM INFORMATION_SCHEMA.columns AS TC ' + CHAR (10) ;
    SET @S = @S + ' where table_name = ''' + @TblName + ''' ; ' + CHAR (10) ;

    EXEC (@S) ;

    OPEN PCursor;
    FETCH NEXT FROM PCursor INTO @COLUMN_NAME , @DATA_TYPE;
    WHILE
           @@FETCH_STATUS = 0
        BEGIN
            IF @iCnt > 0
                BEGIN
                    SET @MySql = @MySql + ', '
                END;
            IF
                   @DATA_TYPE = 'INT'
                BEGIN
                    SET @MySql = @MySql + '    isnull(' + @COLUMN_NAME + ', -1) AS ' + @COLUMN_NAME + char (10) 
                END;
            IF
                   @DATA_TYPE = 'VARCHAR'
                BEGIN
                    SET @MySql = @MySql + '    isnull(' + @COLUMN_NAME + ', ''-'') AS ' + @COLUMN_NAME + char (10) 
                END;
            IF
                   @DATA_TYPE = 'NVARCHAR'
                BEGIN
                    SET @MySql = @MySql + '    isnull(' + @COLUMN_NAME + ', ''-'') AS ' + @COLUMN_NAME + char (10) 
                END;
            IF
                   @DATA_TYPE = 'NCHAR'
                BEGIN
                    SET @MySql = @MySql + '    isnull(' + @COLUMN_NAME + ', ''-'') AS ' + @COLUMN_NAME + char (10) 
                END;
            IF
                   @DATA_TYPE = 'CHAR'
                BEGIN
                    SET @MySql = @MySql + '    isnull(' + @COLUMN_NAME + ', ''-'') AS ' + @COLUMN_NAME + char (10) 
                END;
            IF
                   @DATA_TYPE = 'DATETIME'
                BEGIN
                    SET @MySql = @MySql + '    isnull(' + @COLUMN_NAME + ', ''1700-01-01'') AS ' + @COLUMN_NAME + char (10) 
                END;
            IF
                   @DATA_TYPE = 'DATETIME2'
                BEGIN
                    SET @MySql = @MySql + '    isnull(' + @COLUMN_NAME + ', ''1700-01-01'') AS ' + @COLUMN_NAME + char (10) 
                END;
            IF
                   @DATA_TYPE = 'BIT'
                BEGIN
                    SET @MySql = @MySql + '    isnull(' + @COLUMN_NAME + ', 0) AS ' + @COLUMN_NAME + char (10) 
                END;
            IF
                   @DATA_TYPE = 'DECIMAL'
                BEGIN
                    SET @MySql = @MySql + '    isnull(' + @COLUMN_NAME + ', 0) AS ' + @COLUMN_NAME + char (10) 
                END;
            IF
                   @DATA_TYPE = 'FLOAT'
                BEGIN
                    SET @MySql = @MySql + '    isnull(' + @COLUMN_NAME + ', 0) AS ' + @COLUMN_NAME + char (10) 
                END;
            IF
                   @DATA_TYPE = 'varbinary'
                BEGIN
                    SET @MySql = @MySql + '    isnull(' + @COLUMN_NAME + ', 0) AS ' + @COLUMN_NAME + char (10) 
                END;
            IF
                   @DATA_TYPE = 'uniqueidentifier'
                BEGIN
                    SET @MySql = @MySql + '    isnull(' + @COLUMN_NAME + ', ''00000000-0000-0000-0000-000000000000'') AS ' + @COLUMN_NAME + char (10) 
                END;
            IF
                   @DATA_TYPE = 'bigint'
                BEGIN
                    SET @MySql = @MySql + '    isnull(' + @COLUMN_NAME + ', 0) AS ' + @COLUMN_NAME + char (10) 
                END;

            FETCH NEXT FROM PCursor INTO @COLUMN_NAME , @DATA_TYPE;
            SET @iCnt = @iCnt + 1;
        END;

    -- set @MySql = @MySql + char(10) ;
    SET @MySql = @MySql + ' FROM ' + @TblName;

    CLOSE PCursor;
    DEALLOCATE PCursor;

    EXEC (@DropSql) ;
    EXEC (@MySql) ;

    IF EXISTS (SELECT
                      name
                      FROM sys.views
                      WHERE name = @ViewName) 
        BEGIN
            PRINT 'View ' + @ViewName + ' successfully created.';
        END
    ELSE
        BEGIN
            PRINT 'ERROR: View ' + @ViewName + ' failed to create.';
        END;

END;
GO
PRINT 'Executed proc_GenBaseViewNoNulls.sql';
GO