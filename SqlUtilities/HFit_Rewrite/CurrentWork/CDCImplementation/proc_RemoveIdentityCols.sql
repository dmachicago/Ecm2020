

GO
PRINT 'Executing proc_RemoveIdentityCols.sql';
GO
IF EXISTS (SELECT
                  name
           FROM sys.procedures
           WHERE
                  name = 'proc_RemoveIdentityCols') 
    BEGIN
        DROP PROCEDURE
             proc_RemoveIdentityCols;
    END;
GO
-- USe KenticoCMS_Datamart_2
-- drop table #IdentCols
-- exec proc_RemoveIdentityCols 'HFit_HealthAssesmentMultipleChoiceQuestion_DEL'
CREATE PROCEDURE proc_RemoveIdentityCols (
       @TblName AS NVARCHAR (1000) 
     , @SetAsNotNUll AS INT = 0) 
AS
BEGIN

    DECLARE
         @iColCnt AS INT = 0
       , @MySql AS NVARCHAR (MAX) = ''
       , @TempColBit AS BIT = 0
       , @SchemaOwner AS NVARCHAR (50) = 'dbo';
    SET @iColCnt = (SELECT
                           COUNT (*) 
                    FROM INFORMATION_SCHEMA.COLUMNS
                    WHERE
                           TABLE_SCHEMA = @SchemaOwner AND
                           table_name = @TblName) ;
    PRINT 'Column Count: ' + CAST (@iColCnt AS NVARCHAR (50)) ;

    -- If a table has only one column, MSSS will NOT allow cahnges to the identity field.
    -- Add an extra column, do the fix, and remove it at the end.    
    IF @iColCnt = 1
        BEGIN
            SET @MySql = 'Alter table ' + @TblName + ' add CT_TempInt int not null ';
            EXEC PrintImmediate @MySql;
            EXEC (@MySQl) ;
            SET @TempColBit = 1;
        END;

    BEGIN
        SELECT
               COLUMN_NAME
             , DATA_TYPE
        INTO
             #IdentCols
        FROM INFORMATION_SCHEMA.COLUMNS
        WHERE
               TABLE_SCHEMA = 'dbo' AND
               COLUMNPROPERTY (OBJECT_ID (TABLE_NAME) , COLUMN_NAME , 'IsIdentity') = 1 AND
               TABLE_NAME = @TblName;

        DECLARE
             @DelStmt AS NVARCHAR (1000) = '';
        DECLARE
             @AddStmt AS NVARCHAR (1000) = '';
        DECLARE
             @Dtype AS NVARCHAR (1000) = '';
        DECLARE
             @tCol AS NVARCHAR (1000) = '';

        DECLARE TCursor CURSOR
            FOR
                SELECT
                       COLUMN_NAME
                     , DATA_TYPE
                FROM #IdentCols;
        OPEN TCursor;
        FETCH NEXT FROM TCursor INTO @tCol , @Dtype;
        WHILE
               @@FETCH_STATUS = 0
            BEGIN
                SET @DelStmt = 'ALTER TABLE ' + @TblName + ' DROP COLUMN ' + @tCol;
                IF
                       @SetAsNotNUll = 0
                    BEGIN
                        SET  @AddStmt = 'ALTER TABLE ' + @TblName + ' ADD ' + @tCol + ' ' + @Dtype + ' NULL ';
                    END;
                ELSE
                    BEGIN
                        SET  @AddStmt = 'ALTER TABLE ' + @TblName + ' ADD ' + @tCol + ' ' + @Dtype + ' NOT NULL ';
                    END;
                PRINT 'REMOVED Identity Column: ' + @TblName + '.' + @tCol;
                IF @DelStmt IS NOT NULL
                    BEGIN
                        EXEC (@DelStmt) ;
                    END;
                IF @AddStmt IS NOT NULL
                    BEGIN
                        EXEC (@AddStmt) ;
                    END;
                FETCH NEXT FROM TCursor INTO @tCol , @Dtype;
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

/*------------------------------------------------------------------------------------------
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
*/
END;

GO
PRINT 'Executed proc_RemoveIdentityCols.sql';
GO