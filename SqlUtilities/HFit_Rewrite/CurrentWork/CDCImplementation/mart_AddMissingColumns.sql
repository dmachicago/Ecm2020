
/*-----------------------------------------------------------------------
    SELECT
           COLUMN_NAME
         , IS_NULLABLE
         , DATA_TYPE
         , CHARACTER_MAXIMUM_LENGTH  
    FROM information_schema.columns
    WHERE
           table_name = 'BASE_HFit_HealthAssesmentUserStarted' AND
           TABLE_SCHEMA = 'dbo' AND
           column_name NOT IN (
           SELECT
                  column_name
           FROM information_schema.columns
           WHERE
                  table_name = 'BASE_HFit_HealthAssesmentUserStarted_DEL'
           )
*/
-- use KenticoCMS_Datamart_2
--mart_AddMissingColumns

GO
PRINT 'Executing mart_AddMissingColumns.sql';
GO
IF EXISTS (SELECT
                  name
           FROM sys.procedures
           WHERE
                  name = 'mart_AddMissingColumns') 
    BEGIN
        DROP PROCEDURE
             mart_AddMissingColumns;
    END;
GO

-- exec mart_AddMissingColumns  @BaseTableName = 'BASE_HFit_HealthAssesmentUserStarted', @TgtName = 'BASE_HFit_HealthAssesmentUserStarted_DEL'
CREATE PROCEDURE mart_AddMissingColumns (
       @BaseTableName AS NVARCHAR (250) 
     , @TgtName AS NVARCHAR (250)) 
AS
BEGIN

    DECLARE
         @mysql AS NVARCHAR (MAX) ;

    IF NOT EXISTS (SELECT
                          column_name
                   FROM information_schema.columns
                   WHERE
                          table_name = @BaseTableName AND
                          column_name = 'CT_RowDataUpdated') 
        BEGIN
            SET @mysql = 'Alter table ' + @BaseTableName + ' add CT_RowDataUpdated bit null default 1 ';
        END;
    IF NOT EXISTS (SELECT
                          column_name
                   FROM information_schema.columns
                   WHERE
                          table_name = @TgtName AND
                          column_name = 'CT_RowDataUpdated') 
        BEGIN
            SET @mysql = 'Alter table ' + @TgtName + ' add CT_RowDataUpdated bit null default 1 ';
        END;

    IF OBJECT_ID ('tempdb..#TempBaseTbl') IS NOT NULL
        BEGIN DROP TABLE
                   #TempBaseTbl;
        END;
    IF OBJECT_ID ('tempdb..#TempTgtTbl') IS NOT NULL
        BEGIN DROP TABLE
                   #TempTgtTbl;
        END;

    SELECT
           COLUMN_NAME
         , IS_NULLABLE
         , DATA_TYPE
         , CHARACTER_MAXIMUM_LENGTH  INTO
                                          #TempBaseTbl
    FROM information_schema.columns
    WHERE
           table_name = @BaseTableName AND
           TABLE_SCHEMA = 'dbo' AND column_name NOT IN (
           SELECT
                  column_name
           FROM information_schema.columns
           WHERE
                  table_name = @TgtName AND
                  TABLE_SCHEMA = 'dbo'
           );

    SELECT
           COLUMN_NAME
         , IS_NULLABLE
         , DATA_TYPE
         , CHARACTER_MAXIMUM_LENGTH  INTO
                                          #TempTgtTbl
    FROM information_schema.columns
    WHERE
           table_name = @TgtName AND
           TABLE_SCHEMA = 'dbo';

    DECLARE
         @COLUMN_NAME AS NVARCHAR (250) 
       , @IS_NULLABLE AS NVARCHAR (50) 
       , @DATA_TYPE AS NVARCHAR (50) 
       , @CHARACTER_MAXIMUM_LENGTH AS INT
       , @T AS NVARCHAR (250) = ''
       , @Msg AS NVARCHAR (MAX) = ''
       , @i AS INT = 0
       , @j AS INT = 0;

    DECLARE C CURSOR
        FOR
            SELECT
                   COLUMN_NAME
                 , IS_NULLABLE
                 , DATA_TYPE
                 , CHARACTER_MAXIMUM_LENGTH
            FROM #TempBaseTbl;

    OPEN C;
    FETCH NEXT FROM C INTO @COLUMN_NAME , @IS_NULLABLE , @DATA_TYPE , @CHARACTER_MAXIMUM_LENGTH;

    WHILE
           @@FETCH_STATUS = 0
        BEGIN
            SET @i = (SELECT
                             COUNT (1) 
                      FROM information_schema.columns
                      WHERE
                             table_name = @TgtName AND
                             column_name = @COLUMN_NAME) ;
            IF @i = 0
                BEGIN
                    BEGIN TRY
                        SET @MySql = 'Alter table ' + @TgtName + ' add ' + @COLUMN_NAME + ' ' + @DATA_TYPE + ' NULL';
                        EXEC (@MySql) ;
                        SET @Msg = 'SUCCESS: ' + @MySql;
                        EXEC PrintImmediate @MySql;
                    END TRY
                    BEGIN CATCH
                        SET @Msg = 'ERROR: ' + @MySql;
                        EXEC PrintImmediate @msg;
                    END CATCH;

                END;
            FETCH NEXT FROM C INTO @COLUMN_NAME , @IS_NULLABLE , @DATA_TYPE , @CHARACTER_MAXIMUM_LENGTH;
        END;

    CLOSE C;
    DEALLOCATE C;

END;
GO
PRINT 'Executed mart_AddMissingColumns.sql';
GO
