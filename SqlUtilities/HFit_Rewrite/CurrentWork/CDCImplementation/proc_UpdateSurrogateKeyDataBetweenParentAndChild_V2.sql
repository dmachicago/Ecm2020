
/****** Object:  StoredProcedure [dbo].[proc_UpdateSurrogateKeyDataBetweenParentAndChild]    Script Date: 5/17/2016 10:02:46 AM ******/
DROP PROCEDURE [dbo].[proc_UpdateSurrogateKeyDataBetweenParentAndChild]
GO

/****** Object:  StoredProcedure [dbo].[proc_UpdateSurrogateKeyDataBetweenParentAndChild]    Script Date: 5/17/2016 10:02:46 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- exec proc_UpdateSurrogateKeyDataBetweenParentAndChild "BASE_CMS_Transformation", "SurrogateKey_CMS_Transformation","BASE_CMS_Class","TransformationClassID", "ClassID",1
-- exec proc_UpdateSurrogateKeyDataBetweenParentAndChild "BASE_CMS_Tree", "SurrogateKey_CMS_Tree","BASE_CMS_Class","NodeClassID", "ClassID",1


CREATE PROCEDURE [dbo].[proc_UpdateSurrogateKeyDataBetweenParentAndChild] (
       @ParentTable AS NVARCHAR (254) 
     , @ParentSurrogateKeyName AS NVARCHAR (254) 
     , @ChildTable AS NVARCHAR (254) 
     , @ParentColumn AS NVARCHAR (254) 
     , @ChildColumn AS NVARCHAR (254) 
     , @PreviewOnly AS BIT = 0
	, @ResetSurrogateKey as bit = 0 
) 
AS
BEGIN

    IF @PreviewOnly = 1
        BEGIN
            PRINT '@ParentTable: ' + @ParentTable;
            PRINT '@ChildTable ' + @ChildTable;
            PRINT '@ParentSurrogateKeyName: ' + @ParentSurrogateKeyName;
            PRINT '@ParentColumn: ' + @ParentColumn;
            PRINT '@ChildColumn: ' + @ChildColumn;
        END;
    DECLARE
           @MySql AS NVARCHAR (MAX) = '';

    IF NOT EXISTS (SELECT
                          table_name
                   FROM information_schema.tables
                   WHERE
                          table_name = @ParentTable) 
        BEGIN
            PRINT 'CANNOT find Parent table ' + @ParentTable + ', aborting';
            RETURN;
        END;
    IF NOT EXISTS (SELECT
                          table_name
                   FROM information_schema.tables
                   WHERE
                          table_name = @ChildTable) 
        BEGIN
            DECLARE
                   @S AS NVARCHAR (500) = substring (@ChildTable , 6 , 999) ;
            PRINT 'NOTICE: CANNOT find Child table ' + @S + ', ADDING TO MART.';
            EXEC proc_CreateBaseTable 'KenticoCMS_1' , @S , 0;
            EXEC proc_CreateBaseTable 'KenticoCMS_2' , @S , 1;
            EXEC proc_CreateBaseTable 'KenticoCMS_3' , @S , 1;
        END;
    IF EXISTS (SELECT
                      table_name
               FROM information_schema.tables
               WHERE
                      table_name = @ParentTable) 
        BEGIN
            IF NOT EXISTS (SELECT
                                  column_name
                           FROM information_schema.columns
                           WHERE
                                  table_name = @ChildTable AND
                                  column_name = @ParentSurrogateKeyName) 
                BEGIN
                    PRINT 'Added the surrogate key ' + @ParentSurrogateKeyName + ' to ' + @ChildTable;
                    SET @MySql = 'ALTER TABLE ' + @ChildTable + ' ADD ' + @ParentSurrogateKeyName + '  BIGINT NULL ';
                    EXEC (@MySql) ;
                END;

            PRINT 'Populating ' + @ChildTable + ' with data from ' + @ParentTable + ' using ' + @ParentSurrogateKeyName;

            DECLARE
                   @Msg AS NVARCHAR (MAX) = '';

            IF @PreviewOnly = 1
                BEGIN
                    PRINT '2@ParentTable: ' + @ParentTable;
                    PRINT '2@ChildTable ' + @ChildTable;
                    PRINT '2@ParentSurrogateKeyName: ' + @ParentSurrogateKeyName;
                    PRINT '2@ParentColumn: ' + @ParentColumn;
                    PRINT '2@ChildColumn: ' + @ChildColumn;
                END;

		  IF @ResetSurrogateKey = 1
                BEGIN
				 PRINT 'Reseting SurrogateKey ' + @ParentSurrogateKeyName + ' on table ' + @ChildTable;
                    
				 SET @MySql = '';
				 SET @MySql = @MySQl + ' UPDATE ' + @ChildTable;
				 SET @MySql = @MySQl + ' SET ' + @ParentSurrogateKeyName + ' = NULL';

				 IF @PreviewOnly = 1
				    PRINT '@MySql: ' + @MySql;
				 else 
				    EXEC (@MySql) ;
            END;

            SET @MySql = '';
            SET @MySql = @MySQl + ' UPDATE ChildTable ' + char (10) ;
            SET @MySql = @MySQl + ' SET ' + @ParentSurrogateKeyName + ' = ParentTable.' + @ParentSurrogateKeyName + char (10) ;
            SET @MySql = @MySQl + ' FROM ' + @ChildTable + ' as ChildTable ' + char (10) ;
            SET @MySql = @MySQl + '	JOIN ' + char (10) ;
            SET @MySql = @MySQl + ' 	  ' + @ParentTable + ' as ParentTable  ' + char (10) ;
            SET @MySql = @MySQl + ' 		    ON ChildTable.DBNAME =ParentTable.DBNAME  ' + char (10) ;
            SET @MySql = @MySQl + ' 		    AND ChildTable.' + @ChildColumn + ' = ParentTable.' + @ParentColumn;
            SET @MySql = @MySQl + ' where ChildTable.' + @ParentSurrogateKeyName + ' is null ';

            PRINT '@MySql: ' + @MySql;

            BEGIN TRY
                IF @PreviewOnly = 1
                    BEGIN
                        PRINT @MySQl;
                    END;
                ELSE
                    BEGIN
                        PRINT @MySQl;
                        EXEC (@MySql) ;
                    END;

                BEGIN TRY

                    INSERT INTO MART_SYNC_Table_FKRels (
                           ParentTable
                         , ParentSurrogateKeyName
                         , ChildTable
                         , ParentColumn
                         , ChildColumn) 
                    VALUES
                    (@ParentTable , @ParentSurrogateKeyName , @ChildTable , @ParentColumn , @ChildColumn) ;
                END TRY
                BEGIN CATCH
                    SET @msg = 'Notice: NO ENTRY into MART_SYNC_Table_FKRels: ' + char (10) ;
                    EXEC PrintImmediate @msg;
                END CATCH;

            END TRY
            BEGIN CATCH
                SET @msg = 'ERRORS DETECTED: ' + @MySql;
                EXEC dbo.PrintImmediate @Msg;
                SET @msg = (SELECT
                                   ERROR_MESSAGE ()) ;
                EXEC dbo.PrintImmediate @Msg;
                EXECUTE dbo.USP_GETERRORINFO;
            END CATCH;
        END;
END;


GO


/****** Object:  StoredProcedure [dbo].[proc_UpdateSurrogateKeyDataBetweenParentAndChildFromSYNCTable]    Script Date: 5/17/2016 10:02:56 AM ******/
DROP PROCEDURE [dbo].[proc_UpdateSurrogateKeyDataBetweenParentAndChildFromSYNCTable]
GO

/****** Object:  StoredProcedure [dbo].[proc_UpdateSurrogateKeyDataBetweenParentAndChildFromSYNCTable]    Script Date: 5/17/2016 10:02:56 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- exec proc_UpdateSurrogateKeyDataBetweenParentAndChildFromSYNCTable 0
-- exec proc_UpdateSurrogateKeyDataBetweenParentAndChild "BASE_HFit_Account", "SurrogateKey_HFit_Account","BASE_view_EDW_CoachingPPTEnrolled","AccountCD", "AccountCD",1
CREATE PROCEDURE [dbo].[proc_UpdateSurrogateKeyDataBetweenParentAndChildFromSYNCTable] (
       @PreviewOnly AS BIT = 0) 
AS
BEGIN
    DECLARE
           @MySQl AS NVARCHAR (MAX) = ''
         , @Schema_NAME AS NVARCHAR (500) = ''
         , @ParentTable AS NVARCHAR (500) = ''
         , @ParentColumn AS NVARCHAR (500) = ''
         , @ReferencedTable AS NVARCHAR (500) = ''
         , @ChildColumn AS NVARCHAR (500) = ''
         , @ParentSurrogateKeyName AS NVARCHAR (500) = ''
         , @ChildTable AS NVARCHAR (500) = ''
         , @ChildSurrogateKey AS NVARCHAR (500) = ''
         , @msg AS NVARCHAR (MAX) = '';

    IF NOT EXISTS (SELECT
                          name
                   FROM sys.tables
                   WHERE
                          name = 'MART_SYNC_Table_FKRels') 
        BEGIN
            --exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 'BASE_HFit_Account', 'SurrogateKey_HFit_Account', 'BASE_view_EDW_CoachingPPTAvailable', 'AccountCD', 'AccountCD', 0
            -- drop table MART_SYNC_Table_FKRels
            CREATE TABLE MART_SYNC_Table_FKRels
            (
                         ParentTable VARCHAR (175) 
                       , ParentSurrogateKeyName VARCHAR (175) 
                       , ChildTable VARCHAR (175) 
                       , ParentColumn VARCHAR (175) 
                       , ChildColumn VARCHAR (175) 
                       , RowID INT IDENTITY (1 , 1) 
                                   NOT NULL
            );
            CREATE UNIQUE CLUSTERED INDEX PI_MART_SYNC_Table_FKRels ON MART_SYNC_Table_FKRels (ParentTable , ParentSurrogateKeyName , ChildTable , ParentColumn , ChildColumn) ;

            INSERT INTO MART_SYNC_Table_FKRels (
                   ParentTable
                 , ParentSurrogateKeyName
                 , ChildTable
                 , ParentColumn
                 , ChildColumn) 
            VALUES
            ('BASE_HFit_Account' , 'SurrogateKey_HFit_Account' , 'BASE_view_EDW_CoachingPPTAvailable' , 'AccountCD' , 'AccountCD') ;

            INSERT INTO MART_SYNC_Table_FKRels (
                   ParentTable
                 , ParentSurrogateKeyName
                 , ChildTable
                 , ParentColumn
                 , ChildColumn) 
            VALUES
            ('BASE_HFit_Account' , 'SurrogateKey_HFit_Account' , 'BASE_view_EDW_CoachingPPTEligible' , 'AccountCD' , 'AccountCD') ;

            INSERT INTO MART_SYNC_Table_FKRels (
                   ParentTable
                 , ParentSurrogateKeyName
                 , ChildTable
                 , ParentColumn
                 , ChildColumn) 
            VALUES
            ('BASE_HFit_Account' , 'SurrogateKey_HFit_Account' , 'BASE_view_EDW_CoachingPPTEnrolled' , 'AccountCD' , 'AccountCD') ;

        END;

    IF
           (SELECT
                   count (*) 
            FROM MART_SYNC_Table_FKRels) = 0
        BEGIN
            PRINT 'NO Records in table MART_SYNC_Table_FKRels to process, aborting.';
            RETURN;
        END;

    DECLARE Cursor_MART_Sync CURSOR
        FOR
            SELECT
                   ParentTable
                 , ParentSurrogateKeyName
                 , ChildTable
                 , ParentColumn
                 , ChildColumn
            FROM MART_SYNC_Table_FKRels
            ORDER BY
                     ChildTable , ParentTable;

    OPEN Cursor_MART_Sync;

    FETCH NEXT FROM Cursor_MART_Sync INTO
    @ParentTable
    , @ParentSurrogateKeyName
    , @ChildTable
    , @ParentColumn
    , @ChildColumn;

    WHILE
           @@FETCH_STATUS = 0
        BEGIN
            SET  @MySql = 'exec proc_UpdateSurrogateKeyDataBetweenParentAndChild "' + @ParentTable + '", "' + @ParentSurrogateKeyName + '","' + @ChildTable + '","' + @ParentColumn + '", "' + @ChildColumn + '",0';
            IF @PreviewOnly = 1
                BEGIN
                    PRINT 'SQL STMT: ' + @MySql;
                END;
            ELSE
                BEGIN
                    PRINT 'EXECUTING: ' + @MySql;
                    BEGIN TRY
                        EXEC (@MySql) ;
                    END TRY
                    BEGIN CATCH
                        SET @msg = 'ERRORS DETECTED: ' + @MySql;
                        EXEC dbo.PrintImmediate @Msg;
                        SET @msg = (SELECT
                                           ERROR_MESSAGE ()) ;
                        EXEC dbo.PrintImmediate @Msg;
                        EXECUTE dbo.USP_GETERRORINFO;
                    END CATCH;
                END;
            FETCH NEXT FROM Cursor_MART_Sync INTO
            @ParentTable
            , @ParentSurrogateKeyName
            , @ChildTable
            , @ParentColumn
            , @ChildColumn;
        END;

    CLOSE Cursor_MART_Sync;
    DEALLOCATE Cursor_MART_Sync;

END;

-- ------------------------------------------------------------------

GO

