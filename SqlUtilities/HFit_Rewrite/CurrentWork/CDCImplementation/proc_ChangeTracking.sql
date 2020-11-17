
GO
PRINT 'Executing proc_ChangeTracking.sql';
GO
IF EXISTS (SELECT
                  name
           FROM sys.procedures
           WHERE
                  name = 'proc_ChangeTracking') 
    BEGIN
        DROP PROCEDURE
             proc_ChangeTracking;
    END;
GO
-- Use KenticoCMS_Datamart_X
-- exec proc_ChangeTracking @InstanceName = 'KenticoCMS_1', @TblName = 'CMS_settingkeybak', @Enable = 1
-- exec proc_ChangeTracking 'KenticoCMS_1', 'CMS_USER', 1,1
CREATE PROCEDURE proc_ChangeTracking (
       @InstanceName AS NVARCHAR (100) 
     , @TblName AS NVARCHAR (100) 
     , @Enable AS BIT
     , @PreviewDDL AS BIT = 0) 
AS
BEGIN
    --DECLARE @InstanceName AS nvarchar (100) = 'KenticoCMS_2';
    --DECLARE @TblName AS nvarchar (100)  = 'CMS_Class';
    --DECLARE @Enable AS bit = 1;
    DECLARE
    @S AS NVARCHAR (2000) = ''
  , @MySql AS NVARCHAR (2000) = ''
  , @iCnt AS INTEGER = 0;

    DECLARE
    @rowcount TABLE (
                    Value INT) ;

    DECLARE
    @TEMPVAR AS TABLE (
                      iCNT INTEGER) ;

    PRINT 'INSIDE proc_ChangeTracking: ' + @InstanceName + ' / ' + @TblName;

    SET @MySql = 'SELECT count(*) FROM ' + @InstanceName + '.INFORMATION_SCHEMA.TABLES 
		WHERE TABLE_NAME = ''' + @TblName + ''' AND TABLE_SCHEMA =''dbo'' and table_type = ''base table'' ';
    IF @PreviewDDL = 1
        BEGIN
            PRINT @mysql
        END;
    INSERT INTO @rowcount
    EXEC (@MySql) ;
    PRINT @mysql;
    SELECT
           @iCnt = Value
    FROM @rowcount;
    IF @iCnt = 0
        BEGIN
            PRINT 'Base Table does not exist: ' + @TblName + ', please verify this is a TABLE, aborting.';
		  THROW 2500, 'The record does not exist.', 1;
            RETURN;
        END;

    SET @MySql = 'SELECT count(*) 
	FROM ' + @InstanceName + '.INFORMATION_SCHEMA.TABLE_CONSTRAINTS 
	WHERE CONSTRAINT_TYPE = ''PRIMARY KEY'' 
	AND TABLE_NAME = ''' + @TblName + ''' AND TABLE_SCHEMA =''dbo'' ';
    IF @PreviewDDL = 1
        BEGIN
            PRINT @MySQl
        END;

    INSERT INTO @rowcount
    EXEC (@MySql) ;
    SELECT
           @iCnt = Value
    FROM @rowcount;

    IF @iCnt = 0
        BEGIN
            BEGIN TRY
                PRINT 'NO PRIMARY KEY ON: ' + @InstanceName + '.dbo.' + @TblName + ', ALTERING TABLE.';
                SET @MySql = 'ALTER TABLE ' + @InstanceName + '.dbo.' + @TblName;
                SET @MySql = @MySql + ' add SurrogateKey_' + @TblName + ' bigint identity(1,1) not null  ';
                IF @PreviewDDL = 1
                    BEGIN
                        PRINT @MySql
                    END;
                EXEC (@MySql) ;

                SET @MySql = 'ALTER TABLE ' + @InstanceName + '.dbo.' + @TblName;
                SET @MySql = @MySql + ' ADD CONSTRAINT PKI_SK_' + @TblName + ' PRIMARY KEY CLUSTERED (SurrogateKey_' + @TblName + ') ';
                IF @PreviewDDL = 1
                    BEGIN
                        PRINT @MySql
                    END;
                EXEC (@MySql) ;
                PRINT 'ADDED Primary key to ' + @InstanceName + '.dbo.' + @TblName;
            END TRY
            BEGIN CATCH
                PRINT 'ERROR: FAILED TO ADD primary key on ' + @InstanceName + '.dbo.' + @TblName + ' and COULD NOT add PKey, aborting. .';
                RETURN;
            END CATCH;

        END;

    IF @Enable = 1
        BEGIN

            SET @S = 'SELECT count(*) as iCNT FROM ' + CHAR (10) ;
            SET @S = @S + '    ' + @InstanceName + '.sys.change_tracking_tables ' + CHAR (10) ;
            SET @S = @S + '        JOIN ' + @InstanceName + '.sys.tables ' + CHAR (10) ;
            SET @S = @S + '           ON ' + @InstanceName + '.sys.tables.object_id = ' + @InstanceName + '.sys.change_tracking_tables.object_id ' + CHAR (10) ;
            SET @S = @S + '               JOIN ' + @InstanceName + '.sys.schemas ' + CHAR (10) ;
            SET @S = @S + '			    ON ' + @InstanceName + '.sys.schemas.schema_id = ' + @InstanceName + '.sys.tables.schema_id ' + CHAR (10) ;
            SET @S = @S + '           WHERE ' + @InstanceName + '.sys.tables.name = ''' + @TblName + '''';

            INSERT INTO @TEMPVAR
            EXEC (@S) ;
            SET @iCnt = (SELECT TOP 1
                                iCNT
                         FROM @TEMPVAR) ;

            IF @iCnt = 0
                BEGIN
                    PRINT 'ENABLING Change Tracking on ' + @InstanceName + '.dbo.' + @TblName;
                    SET @S = 'ALTER TABLE ' + @InstanceName + '.dbo.' + @TblName + ' ENABLE CHANGE_TRACKING WITH (TRACK_COLUMNS_UPDATED = ON) ';
                    PRINT @S;
                    EXEC (@S) ;
                END;
            ELSE
                BEGIN
                    PRINT 'Change Tracking already ENABLED on: ' + + @InstanceName + '.dbo.' + @TblName;
                END;
        END;
    IF @Enable = 0
        BEGIN
            SET @S = 'SELECT count(*) as iCNT FROM ' + CHAR (10) ;
            SET @S = @S + '    ' + @InstanceName + '.sys.change_tracking_tables ' + CHAR (10) ;
            SET @S = @S + '        JOIN ' + @InstanceName + '.sys.tables ' + CHAR (10) ;
            SET @S = @S + '           ON ' + @InstanceName + '.sys.tables.object_id = ' + @InstanceName + '.sys.change_tracking_tables.object_id ' + CHAR (10) ;
            SET @S = @S + '               JOIN ' + @InstanceName + '.sys.schemas ' + CHAR (10) ;
            SET @S = @S + '			    ON ' + @InstanceName + '.sys.schemas.schema_id = ' + @InstanceName + '.sys.tables.schema_id ' + CHAR (10) ;
            SET @S = @S + '           WHERE ' + @InstanceName + '.sys.tables.name = ''' + @TblName + '''';

            INSERT INTO @TEMPVAR
            EXEC (@S) ;
            SET @iCnt = (SELECT TOP 1
                                iCNT
                         FROM @TEMPVAR) ;

            IF @iCnt > 0
                BEGIN
                    PRINT 'DISABLED Change Tracking on ' + @InstanceName + '.dbo.' + @TblName;
                    SET @S = 'ALTER TABLE ' + @InstanceName + '.dbo.' + @TblName + ' DISABLE CHANGE_TRACKING ';
                    EXEC (@S) ;
                END;
            ELSE
                BEGIN
                    PRINT 'Change Tracking is NOT applied to ' + + @InstanceName + '.dbo.' + @TblName + '.';
                END;
        END;
END;

GO
PRINT 'Executed proc_ChangeTracking.sql';
GO
