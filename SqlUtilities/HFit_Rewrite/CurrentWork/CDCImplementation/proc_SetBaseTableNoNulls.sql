-- exec proc_InstantiateDefaults_BASE_CMS_User
USE KenticoCMS_DataMart_2;

GO
PRINT 'Executing proc_SetBaseTableNoNulls.sql';
GO
IF EXISTS (SELECT
                  name
                  FROM sys.procedures
                  WHERE
                  name = 'proc_SetBaseTableNoNulls') 
    BEGIN
        DROP PROCEDURE
             dbo.proc_SetBaseTableNoNulls;
    END;
GO
-- exec proc_SetBaseTableNoNulls 'BASE_HFit_PPTEligibility', 1
-- exec proc_SetBaseTableNoNulls 'BASE_CMS_Site', 1
-- exec proc_SetBaseTableNoNulls 'BASE_CMS_User'
-- exec proc_SetBaseTableNoNulls 'BASE_COM_SKU'
-- exec proc_SetBaseTableNoNulls 'BASE_HFit_HealthAssesmentUserStarted', 1
-- exec proc_SetBaseTableNoNulls 'BASE_HFit_HealthAssesmentRiskArea'
-- exec proc_SetBaseTableNoNulls 'BASE_HFit_HealthAssesment',1
-- select * from VIEW_BASE_CMS_Site_NoNulls
CREATE PROCEDURE proc_SetBaseTableNoNulls (
       @TblName AS NVARCHAR (200) 
     , @Preview AS INT = 0) 
AS
BEGIN

    --declare @TblName as nvarchar(200) = 'BASE_HFit_PPTEligibility' ;

    DECLARE
           @MySql AS NVARCHAR (MAX) = ''
         , @DropSQL AS NVARCHAR (MAX) = ''
         , @ProcName AS NVARCHAR (MAX) = ''
         , @StartTran AS NVARCHAR (MAX) = ''
         , @EndTran AS NVARCHAR (MAX) = ''
         , @TranName AS NVARCHAR (MAX) = ''
         , @DATA_TYPE AS NVARCHAR (50) 
         , @IS_NULLABLE AS NVARCHAR (50) 
         , @CHARACTER_MAXIMUM_LENGTH AS INT
         , @COLUMN_DEFAULT AS NVARCHAR (50) 
         , @COLUMN_NAME AS NVARCHAR (250) 
         , @iCnt AS BIGINT = 0;

    SET @ProcName = 'proc_InstantiateDefaults_' + @TblName;
    SET @DropSQL = +'if exists (select name from sys.procedures where name = ''' + @ProcName + ''')' + char (10) ;
    SET @DropSQL = @DropSQL + '    drop procedure ' + @ProcName + ';' + char (10) ;

    SET @MySql = 'Create procedure ' + @ProcName + char (10) ;
    SET @MySql = @MySql + 'AS ' + char (10) ;
    SET @MySql = @MySql + 'BEGIN ' + char (10) ;
    SET @MySql = @MySql + '  declare @i as bigint = 0 ; ' + char (10) ;
    SET @MySql = @MySql + '  declare @msg as nvarchar(max)  ; ' + char (10) ;
    SET @MySql = @MySql + '  set nocount on ; ' + char (10) ;

    -- SELECT top 100 * FROM INFORMATION_SCHEMA.columns AS TC where table_name = 'BASE_HFit_PPTEligibility'
    -- SELECT top 100 column_name, data_type, is_nullable, column_default,CHARACTER_MAXIMUM_LENGTH  FROM INFORMATION_SCHEMA.columns AS TC where table_name = 'BASE_HFit_PPTEligibility'
    DECLARE
           @InitSQL AS NVARCHAR (MAX) = '';
    DECLARE
           @S AS NVARCHAR (MAX) = '';
    SET @S = 'DECLARE PCursor CURSOR FOR ' + CHAR (10) ;
    SET @S = @S + ' SELECT ' + CHAR (10) ;
    SET @S = @S + '     COLUMN_NAME ' + CHAR (10) ;
    SET @S = @S + '     , DATA_TYPE ' + CHAR (10) ;
    SET @S = @S + '     , IS_NULLABLE ' + CHAR (10) ;
    SET @S = @S + '     , COLUMN_DEFAULT ' + CHAR (10) ;
    SET @S = @S + '     , CHARACTER_MAXIMUM_LENGTH ' + CHAR (10) ;
    SET @S = @S + ' FROM INFORMATION_SCHEMA.columns AS TC ' + CHAR (10) ;
    SET @S = @S + ' where table_name = ''' + @TblName + ''' ' + CHAR (10) ;
    SET @S = @S + ' and COLUMN_NAME !=  ''HASHCODE''  ' + CHAR (10) ;
    SET @S = @S + ' and COLUMN_NAME !=  ''SVR''  ' + CHAR (10) ;
    SET @S = @S + ' and COLUMN_NAME !=  ''DBNAME''  ' + CHAR (10) ;
    SET @S = @S + ' and COLUMN_NAME !=  ''Action''  ' + CHAR (10) ;
    SET @S = @S + ' and COLUMN_NAME !=  ''LastModifiedDate''  ' + CHAR (10) ;
    SET @S = @S + ' and IS_NULLABLE =  ''YES'' ; ' + CHAR (10) ;
    EXEC (@S) ;

    --print @S ;

    OPEN PCursor;
    FETCH NEXT FROM PCursor INTO @COLUMN_NAME , @DATA_TYPE , @IS_NULLABLE , @COLUMN_DEFAULT , @CHARACTER_MAXIMUM_LENGTH;
    WHILE
           @@FETCH_STATUS = 0
        BEGIN
            SET @InitSQL = '';
            SET @TranName = 'TR_' + cast (@iCnt AS NVARCHAR (50)) ;
            SET @StartTran = char (10) + '    BEGIN transaction ' + @TranName + '; ' + char (10) ;
            SET @StartTran = @StartTran + '      BEGIN try ' + char (10) ;

            SET @EndTran = '    set @i = @@ROWCOUNT; ' + char (10) ;
            SET @EndTran = @EndTran + '    set @msg = ''' + @COLUMN_NAME + ''' + '':'' + cast(@i as nvarchar(50))  ; ' + char (10) ;
            SET @EndTran = @EndTran + '    exec PrintImmediate @msg ; ' + char (10) ;
            SET @EndTran = @EndTran + '    COMMIT transaction ' + @TranName + '; ' + char (10) ;
            SET @EndTran = @EndTran + '      END try ' + char (10) ;
            SET @EndTran = @EndTran + '      BEGIN catch' + char (10) ;
            SET @EndTran = @EndTran + '        rollback transaction ' + @TranName + '; ' + char (10) ;
            SET @EndTran = @EndTran + '        PRINT ''ERROR - COL DEFAULT: ' + @TblName + '.' + @COLUMN_NAME + ' FAILED ; ''' + char (10) ;
            SET @EndTran = @EndTran + '      END catch' + char (10) ;

            IF
                   @DATA_TYPE = 'INT'
                BEGIN
                    SET @InitSQL = @InitSQL + '    Update ' + @TblName + ' set ' + @COLUMN_NAME + ' = -1 where ' + @COLUMN_NAME + ' IS NULL ;' + char (10) ;
                END;
            IF
                   @DATA_TYPE = 'VARCHAR'
                BEGIN
                    SET @InitSQL = @InitSQL + '    Update ' + @TblName + ' set ' + @COLUMN_NAME + ' = ''?'' where ' + @COLUMN_NAME + ' IS NULL ;' + char (10) ;
                END;
            IF
                   @DATA_TYPE = 'NVARCHAR'
                BEGIN
                    SET @InitSQL = @InitSQL + '    Update ' + @TblName + ' set ' + @COLUMN_NAME + ' = ''?'' where ' + @COLUMN_NAME + ' IS NULL ;' + char (10) ;
                END;
            IF
                   @DATA_TYPE = 'NCHAR'
                BEGIN
                    SET @InitSQL = @InitSQL + '    Update ' + @TblName + ' set ' + @COLUMN_NAME + ' = ''?'' where ' + @COLUMN_NAME + ' IS NULL ;' + char (10) ;
                END;
            IF
                   @DATA_TYPE = 'CHAR'
                BEGIN
                    SET @InitSQL = @InitSQL + '    Update ' + @TblName + ' set ' + @COLUMN_NAME + ' = ''?'' where ' + @COLUMN_NAME + ' IS NULL ;' + char (10) ;
                END;
            IF
                   @DATA_TYPE = 'DATETIME'
                BEGIN
                    SET @InitSQL = @InitSQL + '    Update ' + @TblName + ' set ' + @COLUMN_NAME + ' = ''1700-01-01'' where ' + @COLUMN_NAME + ' IS NULL ;' + char (10) ;
                END;
            IF
                   @DATA_TYPE = 'DATETIME2'
                BEGIN
                    SET @InitSQL = @InitSQL + '    Update ' + @TblName + ' set ' + @COLUMN_NAME + ' = ''1700-01-01'' where ' + @COLUMN_NAME + ' IS NULL ;' + char (10) ;
                END;
            IF
                   @DATA_TYPE = 'BIT'
                BEGIN
                    SET @InitSQL = @InitSQL + '    Update ' + @TblName + ' set ' + @COLUMN_NAME + ' = -1 where ' + @COLUMN_NAME + ' IS NULL ;' + char (10) ;
                END;
            IF
                   @DATA_TYPE = 'DECIMAL'
                BEGIN
                    SET @InitSQL = @InitSQL + '    Update ' + @TblName + ' set ' + @COLUMN_NAME + ' = -1 where ' + @COLUMN_NAME + ' IS NULL ;' + char (10) ;
                END;
            IF
                   @DATA_TYPE = 'FLOAT'
                BEGIN
                    SET @InitSQL = @InitSQL + '    Update ' + @TblName + ' set ' + @COLUMN_NAME + ' = -1 where ' + @COLUMN_NAME + ' IS NULL ;' + char (10) ;
                END;
            IF
                   @DATA_TYPE = 'varbinary'
                BEGIN
                    SET @InitSQL = @InitSQL + '    Update ' + @TblName + ' set ' + @COLUMN_NAME + ' = -1 where ' + @COLUMN_NAME + ' IS NULL ;' + char (10) ;
                END;
            IF
                   @DATA_TYPE = 'uniqueidentifier'
                BEGIN
                    SET @InitSQL = @InitSQL + '    Update ' + @TblName + ' set ' + @COLUMN_NAME + ' = ''00000000-0000-0000-0000-000000000000'' where ' + @COLUMN_NAME + ' IS NULL ;' + char (10) ;
                END;
            IF
                   @DATA_TYPE = 'bigint'
                BEGIN
                    SET @InitSQL = @InitSQL + '    Update ' + @TblName + ' set ' + @COLUMN_NAME + ' = -1 where ' + @COLUMN_NAME + ' IS NULL ;' + char (10) ;
                END;

            --print 'S: ' + @StartTran;
            --print 'I: ' + @InitSQL;
            --print 'E: ' + @EndTran;

            SET @MySql = @MySQl + @StartTran;
            SET @MySql = @MySQl + @InitSQL;
            SET @MySql = @MySQl + @EndTran;

            FETCH NEXT FROM PCursor INTO @COLUMN_NAME , @DATA_TYPE , @IS_NULLABLE , @COLUMN_DEFAULT , @CHARACTER_MAXIMUM_LENGTH;
            SET @iCnt = @iCnt + 1;
        END;

    CLOSE PCursor;
    DEALLOCATE PCursor;

    SET @MySql = @MySql + '  set nocount off ; ' + char (10) ;
    SET @MySql = @MySql + 'END; ';

    IF @Preview = 1
        BEGIN
            SELECT
                   @DropSQL;
            SELECT
                   @MySql;
        END;
    ELSE
        BEGIN EXEC (@DropSQL) ;
            EXEC (@MySql) ;
        END;
    IF EXISTS (SELECT
                      name
                      FROM sys.procedures
                      WHERE name = @ProcName) 
        BEGIN
            PRINT 'PROC ' + @ProcName + ' successfully created.';
        END;
    ELSE
        BEGIN
            PRINT 'ERROR: PROC ' + @ProcName + ' failed to create.';
        END;

END;
GO
PRINT 'Executed proc_SetBaseTableNoNulls.sql';
GO