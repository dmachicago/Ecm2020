-- USE [KenticoCMS_DataMart_2];

GO
PRINT 'Executing proc_RI_Tracker_User.sql';
GO
IF EXISTS (SELECT
                  name
           FROM sys.procedures
           WHERE
                  name = 'proc_RI_Tracker_User') 
    BEGIN
        DROP PROCEDURE
             proc_RI_Tracker_User;
    END;
GO
--*********************************************************************
-- exec proc_RI_Tracker_User 'YES'
CREATE PROCEDURE proc_RI_Tracker_User (
       @PreviewOnly AS NVARCHAR (10) = 'NO') 
AS
BEGIN
    DECLARE
           @TblName AS NVARCHAR (100) = ''
         , @ConstraintName AS NVARCHAR (100) = ''
         , @TrackerName AS NVARCHAR (100) = ''
         , @ColName AS NVARCHAR (100) = ''
         , @KCols AS NVARCHAR (MAX) = ''
         , @msg AS NVARCHAR (4000) = ''
         , @cmd AS NVARCHAR (4000) = ''
         , @PkeyCols AS NVARCHAR (4000) = ''
         , @DropCmd AS NVARCHAR (MAX) = ''
         , @GenCmd AS NVARCHAR (MAX) = ''
         , @MySql AS NVARCHAR (MAX) = ''
         , @FKName AS NVARCHAR (MAX) = ''
         , @iCntUserID INT = 0
         , @iCnt INT = 0
         , @iCTFlg INT = 0
         , @i INT = 0;

    DECLARE
           @TBL TABLE
           (
                      PkeyCol NVARCHAR (500) 
           );

    DECLARE
           @TBLCOLS TABLE
           (
                          TblName NVARCHAR (500) 
                        , ColName NVARCHAR (500) 
           );

    BEGIN TRY
        DROP TABLE
             #ChangeTrackingTables;
    END TRY
    BEGIN CATCH
        PRINT 'Init table #ChangeTrackingTables ';
    END CATCH;
    BEGIN TRY
        DROP TABLE
             #TableColumns;
    END TRY
    BEGIN CATCH
        PRINT 'Init table #TableColumns';
    END CATCH;
    BEGIN TRY
        DROP TABLE
             #Tables;
    END TRY
    BEGIN CATCH
        PRINT 'Init table #Tables ';
    END CATCH;

    SELECT
           sys.tables.name AS Table_name
    INTO
         #ChangeTrackingTables
    FROM
         sys.change_tracking_tables
         JOIN sys.tables
         ON
           sys.tables.object_id = sys.change_tracking_tables.object_id
         JOIN sys.schemas
         ON
           sys.schemas.schema_id = sys.tables.schema_id
    WHERE
           sys.schemas.name = 'dbo';
    --select top 100 * from information_Schema.tables
    SELECT
           table_name
         , column_name
    INTO
         #TableColumns
    FROM information_Schema.columns
    ORDER BY
             table_name , column_name;

    SELECT
           table_name
    INTO
         #Tables
    FROM information_Schema.tables
    ORDER BY
             table_name;

    DECLARE C CURSOR
        FOR
            SELECT
                   table_name
            FROM information_Schema.tables
            WHERE
            table_name NOT LIKE 'BASE_CMS_User' AND
                   TABLE_TYPE = 'BASE TABLE';

    OPEN C;

    FETCH NEXT FROM C INTO @TblName;

    WHILE
           @@FETCH_STATUS = 0
        BEGIN

            SET @msg = '--****************************************************** ';
            EXEC PrintImmediate @msg;
            SET @msg = 'RI Tracker Processing: ' + @TblName;
            EXEC PrintImmediate @msg;
            SET @i = 9999;
            SET @i = (SELECT
                             count (*) 
                      FROM information_schema.columns
                      WHERE
                             table_name = @TblName AND
                             column_name = 'SVR') ;
            IF @i = 0
                BEGIN
                    SET @Msg = @tblName + ' missing SVR, skipping.';
                    EXEC PrintImmediate @msg;
                    GOTO SKIPIT;
                END;
            SET @i = (SELECT
                             count (*) 
                      FROM information_schema.columns
                      WHERE
                             table_name = @TblName AND
                             column_name = 'DBNAME') ;
            IF @i = 0
                BEGIN
                    SET @Msg = @tblName + ' missing DBNAME, skipping.';
                    EXEC PrintImmediate @msg;
                    GOTO SKIPIT;
                END;
            SET @i = (SELECT
                             count (*) 
                      FROM information_schema.columns
                      WHERE
                             table_name = @TblName AND
                             column_name = 'UserID') ;
            IF @i = 0
                BEGIN
                    SET @Msg = @tblName + ' missing UserID, skipping.';
                    EXEC PrintImmediate @msg;
                    GOTO SKIPIT;
                END;

            SET @ConstraintName = 'FK_' + @TblName + '_BASE_cms_user';

            --CHECK if FK Constraint exists, skip it
            SET @iCnt = (SELECT
                                count (*) 
                         FROM INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS
                         WHERE
                                CONSTRAINT_NAME = @ConstraintName) ;

            IF @iCnt > 0
                BEGIN
                    SET @msg = 'Already Exists: RI Between ' + @TblName + ' and CMS_USER.' + char (10) + @MySql;
                    EXEC PrintImmediate @msg;
                    GOTO SKIPIT;
                END;

            --EXAMPLE Code:
            --ALTER TABLE BASE_HFit_HealthAssesmentUserRiskCategory 
            --ADD CONSTRAINT FK_BASE_HFit_HealthAssesmentUserRiskCategory_BASE_cms_user 
            --FOREIGN KEY (SVR, DBNAME, UserID)
            --REFERENCES BASE_cms_user(SVR, DBNAME, UserID) ON DELETE CASCADE ON UPDATE CASCADE  NOT FOR REPLICATION		  

            DECLARE
                   @SKEYNAME AS NVARCHAR (250) = 'Surrogate';
            SET @SKEYNAME = @SKEYNAME + substring (@TblName , charindex ('_' , @TblName) , 999) ;
            PRINT '@SKEYNAME = ' + @SKEYNAME;


            SET @i = (SELECT
                             count (*) 
                      FROM information_schema.columns
                      WHERE
                             table_name = @TblName AND
                             column_name = 'SurrogateKey_cms_user') ;

            IF @i = 0
                BEGIN
                    SET @Msg = '-- Adding SurrogateKey_cms_user to ' + @TblName;
                    EXEC PrintImmediate @msg;
                    SET @MySql = 'Alter table ' + @TblName + ' add SurrogateKey_cms_user bigint null ; ';
                    EXEC PrintImmediate @MySql;
                    IF
                           @PreviewOnly = 'NO'
                        BEGIN
                            EXEC (@MySql) 
                        END;
                END;

            -- create the RI Reference 
            SET @MySql = 'ALTER TABLE [dbo].[' + @TblName + ']  WITH NOCHECK  ' + char (10) ;
            SET @MySql = @MySql + ' ADD  CONSTRAINT [' + @ConstraintName + ']  ' + char (10) ;
            --SET @MySql = @MySql + ' FOREIGN KEY([SVR], [DBNAME], [UserID]) ' + char (10) ;
            SET @MySql = @MySql + ' FOREIGN KEY(SurrogateKey_cms_user) ' + char (10) ;
            --SET @MySql = @MySql + ' REFERENCES [dbo].[BASE_cms_user] ([SVR], [DBNAME], [UserID]) ' + char (10) ;
            SET @MySql = @MySql + ' REFERENCES [dbo].[BASE_cms_user] (SurrogateKey_cms_user) ' + char (10) ;
            SET @MySql = @MySql + ' ON DELETE CASCADE ON UPDATE CASCADE ' + char (10) ;
            SET @MySql = @MySql + ' NOT FOR REPLICATION' + char (10) ;

            BEGIN TRY
                EXEC PrintImmediate @MySql;
                IF
                       @PreviewOnly = 'NO'
                    BEGIN
                        EXEC (@MySql) ;
                    END;
                SET @msg = 'ADDED RI Between ' + @TblName + ' and CMS_USER.';
                EXEC PrintImmediate @msg;
            END TRY
            BEGIN CATCH
                SET @msg = 'FAILED: RI Between ' + @TblName + ' and CMS_USER.' + char (10) + @MySql;
                EXEC PrintImmediate @msg;
            END CATCH;

            SKIPIT:

            --if charindex('_DEL', @TblName) > 0 -- and @i != 0 
            --begin
            --set @i = charindex('_DEL', @TblName) - 1 ;
            --declare @ParentTable nvarchar(100) = substring(@TblName,1,@i) ;
            --print '@ParentTable: ' + @ParentTable ;

            --set @ConstraintName = 'Ref_' + @ParentTable +'_Hist' ;
            --SET @iCnt = (SELECT
            --                            count (*) 
            --                     FROM INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS
            --                     WHERE
            --                            CONSTRAINT_NAME = @ConstraintName) ;

            --IF @iCnt = 0
            --BEGIN								
            ----BASE_HFit_TrackerBMI_DEL
            --set @MySql = '' ;
            --SET @MySql = @MySql + ' ALTER TABLE '+@TblName+' ADD CONSTRAINT ' + @ConstraintName + char(10) ;
            --SET @MySql = @MySql + '     FOREIGN KEY (ItemID, UserID, TrackerName, SVR, DBNAME) ' + char(10) ;
            --SET @MySql = @MySql + '     REFERENCES '+@ParentTable+'(ItemID, UserID, TrackerName, SVR, DBNAME) ' + char(10) ;
            --SET @MySql = @MySql + ' NOT FOR REPLICATION' + char (10) ;
            --print 'HIST: ' + @MySql;
            --end ;
            --end; 

            FETCH NEXT FROM C INTO @TblName;

        END;

    PRINT 'RUN COMPLETE.';
    CLOSE C;
    DEALLOCATE C;
END;

GO
PRINT 'Executed proc_RI_Tracker_User.sql';
GO
