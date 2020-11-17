

GO
PRINT 'Executing proc_RemoveNotNullCols.sql';
GO
IF EXISTS (SELECT
                  name
           FROM sys.procedures
           WHERE
                  name = 'proc_RemoveNotNullCols') 
    BEGIN
        DROP PROCEDURE
             proc_RemoveNotNullCols;
    END;
GO
-- Use KenticoCMS_Datamart_2
-- select top 50 * from INFORMATION_SCHEMA.tables where table_name like '%_TestData'
-- select top 50 * from INFORMATION_SCHEMA.COLUMNS where data_type like 'date%'
-- select * from INFORMATION_SCHEMA.COLUMNS where table_name = 'BASE_HFit_HealthAssesmentMultipleChoiceQuestion_DEL'
-- drop table #IdentCols
-- exec proc_RemoveNotNullCols 'BASE_CMS_AllowedChildClasses_TESTDATA', 1
CREATE PROCEDURE proc_RemoveNotNullCols (
       @TblName NVARCHAR (1000) 
     , @PreviewOnly BIT = 0) 
AS
BEGIN

    DECLARE @iColCnt AS INT = 0
          , @MySql AS NVARCHAR (MAX) = ''
          , @TempColBit AS BIT = 0
          , @SchemaOwner AS NVARCHAR (50) = 'dbo';

    DECLARE @Table_SCHEMA AS NVARCHAR (50) = ''
          , @Table_Name AS NVARCHAR (250) = ''
          , @Column_Name AS NVARCHAR (250) = ''
          , @Is_Nullable AS NVARCHAR (10) = ''
          , @Data_Type AS NVARCHAR (50) = ''
          , @Character_Maximum_Length AS INT = 0
          , @Numeric_Precision_Radix AS INT = 0
          , @Numeric_Precision AS INT = 0
          , @Numeric_Scale AS INT = 0
          , @Datetime_Precision AS INT = 0;

    --SET @iColCnt = (SELECT
    --                       COUNT (*) 
    --                FROM INFORMATION_SCHEMA.COLUMNS
    --                WHERE
    --                       TABLE_SCHEMA = @SchemaOwner AND
    --                       table_name = @TblName) ;

    --PRINT 'Column Count: ' + CAST (@iColCnt AS NVARCHAR (50)) ;

    ---- If a table has only one column, MSSS will NOT allow changes to the identity field.
    ---- Add an extra column, do the fix, and remove it at the end.    
    --IF @iColCnt = 1
    --    BEGIN
    --        SET @MySql = 'Alter table ' + @TblName + ' add CT_TempInt int not null ';
    --        EXEC PrintImmediate @MySql;
    --        EXEC (@MySQl) ;
    --        SET @TempColBit = 1;
    --    END;

    BEGIN

        DECLARE TCursor CURSOR
            FOR
                SELECT
                       Table_SCHEMA
                     , Table_Name
                     , Column_Name
                     , Is_Nullable
                     , Data_Type
                     , Character_Maximum_Length
                     , Numeric_Precision_Radix
                     , Numeric_Precision
                     , Numeric_Scale
                     , Datetime_Precision
                FROM information_schema.columns
                WHERE
                       table_name = @TblName AND
                       COLUMNPROPERTY (OBJECT_ID (TABLE_NAME) , COLUMN_NAME, 'IsIdentity') != 1;

        OPEN TCursor;

        FETCH NEXT FROM TCursor INTO @Table_SCHEMA, @Table_Name, @Column_Name, @Is_Nullable , @Data_Type , @Character_Maximum_Length
        , @Numeric_Precision_Radix
        , @Numeric_Precision
        , @Numeric_Scale
        , @Datetime_Precision;
        WHILE
               @@FETCH_STATUS = 0
            BEGIN

                IF
                       @data_type = 'nchar' OR
                       @data_type = 'char' OR
                       @data_type = 'varchar' OR
				   @data_type = 'varbinary' OR
                       @data_type = 'nvarchar'
				   
                    BEGIN
                        IF
                               @Character_Maximum_Length < 0
                            BEGIN
                                SET @MySQl = 'Alter Table ' + @TblName + ' alter column ' + @column_name + ' ' + @Data_Type + ' (max) NULL';
                            END;
                        ELSE
                            BEGIN
                                SET @MySQl = 'Alter Table ' + @TblName + ' alter column ' + @column_name + ' ' + @Data_Type + ' (' + CAST (@Character_Maximum_Length AS NVARCHAR (50)) + ') NULL';
                            END;
                    END;
                ELSE
                    BEGIN IF
                                 @data_type = 'datetime2' OR
                                 @data_type = 'char' OR
                                 @data_type = 'varchar' OR
                                 @data_type = 'nvarchar'
                              BEGIN
                                  SET @MySQl = 'Alter Table ' + @TblName + ' alter column ' + @column_name + ' datetime2(7) NULL ';
                              END;
                          ELSE
                              BEGIN
                                  SET @MySQl = 'Alter Table ' + @TblName + ' alter column ' + @column_name + ' ' + @Data_Type + ' NULL';
                              END;
                    END;

                --PRINT 'Altered Column : ' + @TblName + '.' + @column_name;
                PRINT @MySql;

                IF @PreviewOnly = 0
                    BEGIN
                        EXEC (@MySQl) 
                    END;

                FETCH NEXT FROM TCursor INTO @Table_SCHEMA, @Table_Name, @Column_Name, @Is_Nullable , @Data_Type , @Character_Maximum_Length
                , @Numeric_Precision_Radix
                , @Numeric_Precision
                , @Numeric_Scale
                , @Datetime_Precision;

            END;

        CLOSE TCursor;
        DEALLOCATE TCursor;

        IF @TempColBit = 1
            BEGIN
                SET @MySql = 'Alter table ' + @TblName + ' drop column CT_TempInt ';
                EXEC (@MySQl) ;
                SET @TempColBit = 0;
            END;

    END;

/*******************************************************************************************
------------------------------------------------------------------------------------------
----------------------------------------------------
ALTER TABLE dbo.CMS_User_DEL DROP COLUMN UserID
ALTER TABLE dbo.CMS_User_DEL ADD UserID int NULL 
 
SELECT
               COLUMN_NAME
             , DATA_TYPE
        INTO
             #IdentCols
               FROM INFORMATION_SCHEMA.COLUMNS
               WHERE TABLE_SCHEMA = 'dbo'
                 AND COLUMNPROPERTY (OBJECT_ID (TABLE_NAME) , COLUMN_NAME, 'IsIdentity') = 1
                 AND TABLE_NAME = @TblName;
*******************************************************************************************/
END;

GO
PRINT 'Executed proc_RemoveNotNullCols.sql';
GO

