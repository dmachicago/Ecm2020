
-- use KenticoCMS_DataMart_2
GO
PRINT 'Executing proc_GenBaseTableDefaults.sql';
GO
IF EXISTS (SELECT
                  name
                  FROM sys.procedures
                  WHERE
                  name = 'proc_GenBaseTableDefaults') 
    BEGIN
        DROP PROCEDURE
             dbo.proc_GenBaseTableDefaults;
    END;
GO
-- exec proc_GenBaseTableDefaults 'BASE_HFit_PPTEligibility'
-- exec proc_GenBaseTableDefaults 'BASE_CMS_Site'
-- select * from VIEW_BASE_CMS_Site_NoNulls
CREATE PROCEDURE proc_GenBaseTableDefaults (
       @TblName AS NVARCHAR (200) 
     , @PreviewOnly AS NVARCHAR (10) = 'YES') 
AS
BEGIN

    --declare @TblName as nvarchar(200) = 'BASE_HFit_PPTEligibility' ;

    DECLARE
           @ViewName AS NVARCHAR (200) = 'VIEW_' + @TblName + '_NoNulls';

    DECLARE
           @MySql AS NVARCHAR (MAX) = ''
         , @DropSql AS NVARCHAR (MAX) = ''
         , @Msg AS NVARCHAR (MAX) = ''
         , @DATA_TYPE AS NVARCHAR (50) 
         , @COLUMN_NAME AS NVARCHAR (250) 
         , @is_nullable AS NVARCHAR (50) 
         , @iCnt AS BIGINT = 0
         , @exists AS BIT = 0;

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
    SET @S = @S + '     , is_nullable ' + CHAR (10) ;
    SET @S = @S + ' FROM INFORMATION_SCHEMA.columns AS TC ' + CHAR (10) ;
    SET @S = @S + ' where table_name = ''' + @TblName + ''' ; ' + CHAR (10) ;
    EXEC (@S) ;

    OPEN PCursor;
    FETCH NEXT FROM PCursor INTO @COLUMN_NAME , @DATA_TYPE , @is_nullable;
    WHILE
           @@FETCH_STATUS = 0
        BEGIN
            SET @exists = 0;
            IF EXISTS (SELECT
                              t.name
                              FROM
                                   sys.all_columns AS c JOIN sys.tables AS t
                                       ON
                              t.object_id = c.object_id
                                                        JOIN sys.schemas AS s
                                       ON
                              s.schema_id = t.schema_id
                                                        JOIN sys.default_constraints AS d
                                       ON
                              c.default_object_id = d.object_id
                              WHERE
                              t.name = @TblName AND
                              c.name = @COLUMN_NAME AND
                              s.name = 'DBO') 
                BEGIN
                    SET @exists = 1;
                END;
            SET @MySql = '';
            IF
                   @DATA_TYPE = 'INT' AND
                   @is_nullable = 'YES'
                BEGIN
                    SET @MySql = 'ALTER TABLE ' + @TblName + ' ADD DEFAULT 0 FOR ' + @COLUMN_NAME;
                END;
            IF
                   @DATA_TYPE = 'VARCHAR' AND
                   @is_nullable = 'YES'
                BEGIN
                    SET @MySql = 'ALTER TABLE ' + @TblName + ' ADD DEFAULT ''?'' FOR ' + @COLUMN_NAME;
                END;
            IF
                   @DATA_TYPE = 'NVARCHAR' AND
                   @is_nullable = 'YES'
                BEGIN
                    SET @MySql = 'ALTER TABLE ' + @TblName + ' ADD DEFAULT ''?'' FOR ' + @COLUMN_NAME;
                END;
            IF
                   @DATA_TYPE = 'NCHAR' AND
                   @is_nullable = 'YES'
                BEGIN
                    SET @MySql = 'ALTER TABLE ' + @TblName + ' ADD DEFAULT ''?'' FOR ' + @COLUMN_NAME;
                END;
            IF
                   @DATA_TYPE = 'CHAR' AND
                   @is_nullable = 'YES'
                BEGIN
                    SET @MySql = 'ALTER TABLE ' + @TblName + ' ADD DEFAULT ''?'' FOR ' + @COLUMN_NAME;
                END;
            IF
                   @DATA_TYPE = 'DATETIME' AND
                   @is_nullable = 'YES'
                BEGIN
                    SET @MySql = 'ALTER TABLE ' + @TblName + ' ADD DEFAULT ''1700-01-01'' FOR ' + @COLUMN_NAME;
                END;
            IF
                   @DATA_TYPE = 'DATETIME2' AND
                   @is_nullable = 'YES'
                BEGIN
                    SET @MySql = 'ALTER TABLE ' + @TblName + ' ADD DEFAULT ''1700-01-01'' FOR ' + @COLUMN_NAME;
                END;
            IF
                   @DATA_TYPE = 'BIT' AND
                   @is_nullable = 'YES'
                BEGIN
                    SET @MySql = 'ALTER TABLE ' + @TblName + ' ADD DEFAULT 0 FOR ' + @COLUMN_NAME;
                END;
            IF
                   @DATA_TYPE = 'DECIMAL' AND
                   @is_nullable = 'YES'
                BEGIN
                    SET @MySql = 'ALTER TABLE ' + @TblName + ' ADD DEFAULT 0 FOR ' + @COLUMN_NAME;
                END;
            IF
                   @DATA_TYPE = 'FLOAT' AND
                   @is_nullable = 'YES'
                BEGIN
                    SET @MySql = 'ALTER TABLE ' + @TblName + ' ADD DEFAULT 0 FOR ' + @COLUMN_NAME;
                END;
            IF
                   @DATA_TYPE = 'varbinary' AND
                   @is_nullable = 'YES'
                BEGIN
                    SET @MySql = 'ALTER TABLE ' + @TblName + ' ADD DEFAULT 0 FOR ' + @COLUMN_NAME;
                END;
            IF
                   @DATA_TYPE = 'uniqueidentifier' AND
                   @is_nullable = 'YES'
                BEGIN
                    SET @MySql = 'ALTER TABLE ' + @TblName + ' ADD DEFAULT ''00000000-0000-0000-0000-000000000000'' FOR ' + @COLUMN_NAME;
                END;
            IF
                   @DATA_TYPE = 'bigint' AND
                   @is_nullable = 'YES'
                BEGIN
                    SET @MySql = 'ALTER TABLE ' + @TblName + ' ADD DEFAULT 0 FOR ' + @COLUMN_NAME;
                END;

            --SET @msg = '@is_nullable:' + cast (@is_nullable AS NVARCHAR (50)) + ' / @DATA_TYPE: ' + @DATA_TYPE + ' / @exists = ' + cast (@exists AS NVARCHAR (50)) + ' / @PreviewOnly = ' + @PreviewOnly + ' / ' + @MySql + ';;;';
            --EXEC PrintImmediate @msg;

            IF @exists = 0
                BEGIN
                    --print 'XX 001' ;
                    BEGIN TRY
                        IF
                               @PreviewOnly = 'NO'
                            BEGIN
                                --print 'XX 002' ;
                                SET @msg = 'DEFAULT: ' + @MySql;
                                EXEC PrintImmediate @MySql;
                                EXEC (@MySql) ;
                            END;
                        ELSE
                            BEGIN
                                --print 'XX 003' ;
                                SET @msg = 'PREVIEW: ' + @MySql;
                                EXEC PrintImmediate @MySql;
                            END;
                    END TRY
                    BEGIN CATCH
                        --print 'XX 004' ;
                        SET @msg = 'FAILED TO Set default on ' + @TblName + '.' + @COLUMN_NAME;
                        EXEC PrintImmediate @msg;
                    END CATCH;
                END;
            ELSE
                BEGIN
                    SET @msg = 'Default ALREADY assigned to: ' + @TblName + '.' + @COLUMN_NAME;
                    EXEC PrintImmediate @msg;
                END;
            --print 'XX 005' ;
            FETCH NEXT FROM PCursor INTO @COLUMN_NAME , @DATA_TYPE , @is_nullable;
            SET @iCnt = @iCnt + 1;
        END;
    -- set @MySql = @MySql + char(10) ;
    SET @MySql = @MySql + ' FROM ' + @TblName;

    CLOSE PCursor;
    DEALLOCATE PCursor;

    SET @msg = 'Set defaults for: ' + @tblname;
    EXEC dbo.printImmediate @msg;

END;
GO
PRINT 'Executed proc_GenBaseTableDefaults.sql';
GO