
--use KenticoCMS_Datamart_2 ;
GO
PRINT 'Executing proc_SetPrimaryKeyToSurrogateKey.sql';
GO
IF EXISTS (SELECT
                  name
           FROM sys.procedures
           WHERE
                  name = 'proc_SetPrimaryKeyToSurrogateKey') 
    BEGIN
        DROP PROCEDURE
             proc_SetPrimaryKeyToSurrogateKey;
    END;
GO

CREATE PROCEDURE proc_SetPrimaryKeyToSurrogateKey (
       @BASETable AS NVARCHAR (250) 
     , @ReferenceInstanceName NVARCHAR (250) = 'KenticoCMS_1') 
AS
BEGIN
    -- @ReferenceInstanceName: The initial primary key definition must be pulled from an existing Database and table.
    -- @BASETable: The table within the ReferenceInstanceName that contains the primary key.
    -- Usage: exec proc_SetPrimaryKeyToSurrogateKey 'cms_usersite'

    -- DECLARE @ReferenceInstanceName NVARCHAR (250) = 'KenticoCMS_1';
    DECLARE
         @TblName NVARCHAR (250) = ''
       , @DelTable NVARCHAR (250) = @BASETable + '_DEL'
       , @msg AS NVARCHAR (MAX) ;

    SET @TblName = LTRIM (RTRIM ( SUBSTRING (@BASETable , CHARINDEX ('_' , @BASETable) + 1 , 9999))) ;
    SET @msg = 'calling proc_SetPrimaryKeyToSurrogateKey ' + @TblName;
    EXEC printImmediate @msg;

    DECLARE
         @S NVARCHAR (MAX) = ''
       , @mysql NVARCHAR (MAX) = ''
       , @SurrogateKeyName AS NVARCHAR (100) = '';

    SET @SurrogateKeyName = 'SurrogateKey_' + @TblName;
    IF NOT EXISTS (SELECT
                          COLUMN_NAME
                   FROM INFORMATION_SCHEMA.COLUMNS
                   WHERE
                          COLUMN_NAME = @SurrogateKeyName AND
                          TABLE_NAME = @BASETable) 
        BEGIN
            SET @msg = 'Adding Column ' + @SurrogateKeyName;
            EXEC printImmediate @msg;
            SET @S = 'ALTER TABLE ' + @BASETable + ' ADD ' + @SurrogateKeyName + ' bigint identity (1,1) not NULL ';
            EXEC printImmediate @s;
            EXEC (@S) ;
        END;
    ELSE
        BEGIN
            PRINT 'Column ' + @SurrogateKeyName + ' already exists in ' + @BASETable + '.';
        END;

    IF NOT EXISTS (SELECT
                          COLUMN_NAME
                   FROM INFORMATION_SCHEMA.COLUMNS
                   WHERE
                          COLUMN_NAME = @SurrogateKeyName AND
                          TABLE_NAME = @DelTable) 
        BEGIN
            SET @msg = 'Adding Column ' + @SurrogateKeyName;
            EXEC printImmediate @msg;

            SET @S = 'ALTER TABLE ' + @DelTable + ' ADD ' + @SurrogateKeyName + ' bigint NULL ';
            PRINT @s;
            EXEC (@S) ;
        END;
    ELSE
        BEGIN
            PRINT 'Column ' + @SurrogateKeyName + ' already exists in ' + @DelTable + '.';
        END;

    -- EXEC proc_ChangeTracking  @ReferenceInstanceName , @BASETable , 0;

    BEGIN TRY
        SET @S = 'ALTER TABLE dbo.' + @BASETable + ' DISABLE CHANGE_TRACKING ';
        EXEC (@S) ;
        EXEC printImmediate 'Change Tracking disabled, proceeding.';
    END TRY
    BEGIN CATCH
        EXEC printImmediate 'Change Tracking not enabled, proceeding.';
    END CATCH;

    DECLARE
         @TblKeys AS NVARCHAR (2000) = '';
    DECLARE
         @PK AS NVARCHAR (2000) = NULL;

    EXEC @TblKeys = procGetTablePK @ReferenceInstanceName , @BASETable , @PK OUT;

    SET @TblKeys = @PK;
    PRINT @TblKeys;

    DECLARE --@NewPkCols AS NVARCHAR (2000) = 'SVR, DBNAME, SYS_CHANGE_VERSION, ' + @TblKeys;
         @NewPkCols AS NVARCHAR (2000) = 'SVR, DBNAME, ' + @TblKeys;

    SET @mysql = '';
    DECLARE
         @IdxName AS NVARCHAR (2000) = 'UKI_' + @BASETable + ' ';

    SET @IdxName = 'CI_' + @BASETable + ' ';

    IF NOT EXISTS (SELECT
                          name
                   FROM sys.indexes
                   WHERE name = @IdxName) 
        BEGIN
            DECLARE
                 @CICols AS NVARCHAR (2000) = @NewPkCols;
            SET @msg = 'Creating Index: ' + @IdxName;
            EXEC printImmediate @msg;

            SET @mysql = 'CREATE NONCLUSTERED INDEX [' + @IdxName + '] ON [dbo].[' + @BASETable + '] ' + CHAR (10) ;
            SET @mysql += '(' + CHAR (10) ;
            SET @mysql += @CICols + CHAR (10) ;
            SET @mysql += ')' + CHAR (10) ;
            SET @mysql += ' INCLUDE (LastModifiedDate, HashCode) ' + CHAR (10) ;
            EXEC (@mysql) ;
            PRINT @mysql;
            PRINT 'Created: ' + @IdxName;
        END;

    DECLARE
         @PKIndexName AS  NVARCHAR (500) = '';

    SET @PKIndexName = 'PKey_CT_' + @TblName;

    --SELECT TOP 100
    --       *
    --FROM information_schema.key_column_usage;

    DECLARE
         @SKIndexName AS NVARCHAR (250) = 'SurrogateKey_' + @TblName
       , @SKIndexCnt AS INT = 0;

    SET @SKIndexCnt = (SELECT
                              COUNT (*) 
                       FROM information_schema.key_column_usage
                       WHERE
                              TABLE_NAME = @BaseTable AND
                              column_name = @SKIndexName) ;

    set @Msg = '@PKIndexName = ' + @PKIndexName;
    exec PrintImmediate @msg

    IF @SKIndexCnt = 0
        BEGIN
            SET @msg = 'CERATING Index: ' + @BASETable + '  - KEY: ' + @NewPkCols;
            EXEC printImmediate @msg;
            --SET @MySql = 'ALTER TABLE ' + @BASETable + ' DROP CONSTRAINT ' + @PKIndexName;
            --EXEC (@MySQl) ;

            BEGIN TRY
                --ALTER TABLE ConstraintTable ADD CONSTRAINT Ct_ID PRIMARY KEY (ID)
                SET @MySql = 'ALTER TABLE ' + @BASETable + ' ADD CONSTRAINT ' + @PKIndexName + ' PRIMARY KEY CLUSTERED (' + @SurrogateKeyName + ') ';
                EXEC printImmediate @MySql;
                EXEC (@MySql) ;
                PRINT 'Added Primary Key: ' + @PKIndexName + ' ON ' + @SurrogateKeyName;
            END TRY
            BEGIN CATCH
                SET @msg = '!!! WARNING ON : Primary Key: ' + @PKIndexName + ' ON ' + @NewPkCols;
                EXEC printImmediate @msg;
            --EXECUTE usp_GetErrorInfo;
            END CATCH;
        END;
    ELSE
        BEGIN
            SET @msg = 'index "' + @PKIndexName + '" ALREADY EXISTS, WILL NOT RECREATE.';
            EXEC printImmediate @msg;
        END;

    BEGIN TRY
        SET @S = 'ALTER TABLE dbo.' + @BASETable + ' ENABLE CHANGE_TRACKING ';
        EXEC (@S) ;
        EXEC printImmediate  'Change Tracking enabled, proceeding.';
    END TRY
    BEGIN CATCH
        EXEC printImmediate  'Change Tracking not disabled, proceeding.';
    END CATCH;
END;
GO
PRINT 'Executed proc_SetPrimaryKeyToSurrogateKey.sql';
GO
