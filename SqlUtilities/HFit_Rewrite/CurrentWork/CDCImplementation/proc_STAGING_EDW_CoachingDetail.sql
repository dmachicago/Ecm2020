

GO

--use KenticoCMS_Prod1

/*---------------------------------------
Developer  : W. Dale Miller
05.28.2015 : WDM - completed unit testing
*/

GO
PRINT 'FROM proc_EDW_CoachingDetail.SQL';
PRINT 'Creating proc_EDW_CoachingDetail';
GO
IF EXISTS ( SELECT
                   name
            FROM sys.procedures
            WHERE
                   name = 'proc_EDW_CoachingDetail') 
    BEGIN
        PRINT 'Replacing proc_EDW_CoachingDetail proc';
        DROP PROCEDURE
             proc_EDW_CoachingDetail;
    END;
GO

/*--------------------------------
exec proc_EDW_CoachingDetail 1,1,0
exec proc_EDW_CoachingDetail 1,1,1
exec proc_EDW_CoachingDetail 1,0,1

exec proc_EDW_CoachingDetail 0,1,0
exec proc_EDW_CoachingDetail 0,1,1
exec proc_EDW_CoachingDetail 0,0,1
*/

CREATE PROCEDURE proc_EDW_CoachingDetail
       @Reloadall INT = 0
     , @TrackProgress INT = 0
     , @KeepData AS BIT = 0
AS
BEGIN

    DECLARE
           @iTotal AS BIGINT = 0;

    EXEC @iTotal = proc_QuickRowCount 'DIM_EDW_CoachingDetail';

    IF @iTotal = 1
        BEGIN
            PRINT 'NO RECORDS FOUND IN STAGING TABLE - Reloading all.';
            SET @Reloadall = 1;
        END;

    DECLARE
           @Synchronization_Version BIGINT = 0
         , @CurrentDbVersion AS INT
         , @STime AS DATETIME
         , @TgtView AS NVARCHAR ( 100) = 'view_EDW_CoachingDetail_CT'
         , @ExtractionDate AS DATETIME
         , @ExtractedVersion AS INT
         , @ExtractedRowCnt AS INT
         , @EndTime AS DATETIME
         , @CNT_PulledRecords AS INT = 0
         , @iCnt AS INT = 0
         , @RowNbr AS INT = 0
         , @StartTime AS DATETIME = GETDATE () 
         , @SVRName AS NVARCHAR ( 100) 
         , @DBName AS NVARCHAR ( 100) = DB_NAME () 
         , @CNT_Insert AS INT = 0
         , @CNT_Update AS INT = 0
         , @CNT_Delete AS INT = 0
         , @CNT_StagingTable INT = 0
         , @VersionNBR INT = 0;

    SET @SVRName = ( SELECT
                            @@SERVERNAME) ;

    SET @STime = GETDATE () ;

    DECLARE
           @RecordID AS UNIQUEIDENTIFIER = NEWID () ;
    EXEC proc_EDW_CT_ExecutionLog_Update @RecordID , 'proc_EDW_CoachingDetail' , @STime , 0 , 'I';

    IF @Reloadall = 1
        BEGIN
            IF EXISTS ( SELECT
                               NAME
                        FROM sys.tables
                        WHERE
                               name = 'DIM_EDW_CoachingDetail') 
                BEGIN

                    PRINT 'Dropping DIM_EDW_CoachingDetail for FULL reload.';
                    DROP TABLE
                         DIM_EDW_CoachingDetail;
                END;
            ELSE
                BEGIN
                    PRINT 'Reloading DIM_EDW_CoachingDetail.';
                END;
            IF
                   @TrackProgress = 1
                BEGIN
                    PRINT 'Standby, performing initial load of the HA definitions - this could take a couple of hours, Started at: ' + CAST ( GETDATE
                          () AS NVARCHAR ( 50)) ;
                END;

            IF @Reloadall = 1
                BEGIN

                    PRINT 'RELOADING ALL EDW HA Data.';
                    SELECT
                           * INTO
                                  DIM_EDW_CoachingDetail
                    FROM view_EDW_CoachingDetail_CT;

                    EXEC proc_Add_EDW_CT_StdCols 'DIM_EDW_CoachingDetail';

                    IF
                           @TrackProgress = 1
                        BEGIN
                            SET @iCnt = ( SELECT
                                                 COUNT ( *) 
                                          FROM DIM_EDW_CoachingDetail) ;
                            PRINT DB_NAME () + ' - Completed FULL RELOAD at: ' + CAST ( GETDATE () AS NVARCHAR ( 50)) + ' , loaded ' + CAST ( @iCnt
                                  AS NVARCHAR ( 50)) + ' records.';
                        END;

                    SET @CNT_PulledRecords = ( SELECT
                                                      COUNT ( *) 
                                               FROM DIM_EDW_CoachingDetail) ;
                    SET @CNT_StagingTable = @CNT_PulledRecords;
                    IF NOT EXISTS ( SELECT
                                           name
                                    FROM sys.indexes
                                    WHERE
                                           name = 'PI_EDW_CoachingDetail_IDs') 
                        BEGIN
                            IF
                                   @TrackProgress = 1
                                BEGIN
                                    PRINT 'Adding INDEX PI_EDW_CoachingDetail_IDs at: ' + CAST ( GETDATE () AS NVARCHAR ( 50)) ;
                                END;
                            CREATE CLUSTERED INDEX PI_EDW_CoachingDetail_IDs ON dbo.DIM_EDW_CoachingDetail ( ItemID
                            , ItemGUID
                            , GoalID
                            , UserGUID
                            , SiteGUID
                            , AccountID
                            , AccountCD
                            , WeekendDate
                            , NodeGUID) 
                            WITH ( PAD_INDEX = OFF , STATISTICS_NORECOMPUTE = OFF , SORT_IN_TEMPDB = OFF , DROP_EXISTING = OFF , ONLINE = OFF ,
                            ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ;
                        END;

                    SET @ExtractionDate = GETDATE () ;
                    SET @ExtractedVersion = -1;
                    SET @ExtractedRowCnt = ( SELECT
                                                    COUNT ( *) 
                                             FROM DIM_EDW_CoachingDetail) ;
                    --SET @TgtView = 'view_EDW_CoachingDetail_MART';
                    SET @EndTime = GETDATE () ;

                    INSERT INTO CT_VersionTracking (
                           ExtractionDate
                         , ExtractedVersion
                         , CurrentDbVersion
                         , ExtractedRowCnt
                         , TgtView
                         , StartTime
                         , EndTime
                         , SVRName
                         , DBName
                         , CNT_Insert
                         , CNT_Update
                         , CNT_delete
                         , CNT_PulledRecords
                         , CNT_StagingTable) 
                    VALUES
                    (
                    @ExtractionDate , @ExtractedVersion , @CurrentDbVersion , @ExtractedRowCnt , @TgtView , @StartTime , @EndTime , @SVRName ,
                    @DBName , @CNT_Insert , @CNT_Update , @CNT_delete , @CNT_PulledRecords , @CNT_StagingTable) ;

                    IF
                           @TrackProgress = 1
                        BEGIN
                            PRINT 'Completed , RELOAD at: ' + CAST ( GETDATE () AS NVARCHAR ( 50)) ;
                        END;

                END;
            -- SELECT * INTO [DIM_EDW_CoachingDetail] FROM [view_EDW_CoachingDetail_CT];
            IF
                   @TrackProgress = 1
                BEGIN
                    PRINT 'Completed , reloading at: ' + CAST ( GETDATE () AS NVARCHAR ( 50)) ;
                END;

            IF
                   @TrackProgress = 1
                BEGIN
                    PRINT 'Completed FULL RELOAD at: ' + CAST ( GETDATE () AS NVARCHAR ( 50)) ;
                END;

            SET @STime = GETDATE () ;
            EXEC proc_EDW_ChangeGmtToCentralTime 'DIM_EDW_CoachingDetail';
            EXEC proc_EDW_CT_ExecutionLog_Update @RecordID , 'proc_EDW_CoachingDetail' , @STime , @CNT_PulledRecords , 'U';
            EXEC proc_EDW_CT_ExecutionLog_Update_Counts @RecordID , 'I' , @CNT_PulledRecords;

            EXEC proc_CT_EDW_CoachingDetail_NoDups ;
            RETURN;
        END;

    IF NOT EXISTS ( SELECT
                           NAME
                    FROM sys.tables
                    WHERE
                           name = 'DIM_EDW_CoachingDetail') 
        BEGIN
            PRINT '****************************************************************************';
            PRINT 'FATAL ERROR: table DIM_EDW_CoachingDetail was NOT found, aborting.';
            PRINT '****************************************************************************';
        END;
    ELSE
        BEGIN

            --IF NOT EXISTS ( SELECT
            --                name
            --                  FROM sys.indexes
            --                  WHERE name = 'PI_EDW_CoachingDetail_IDs') 
            --    BEGIN
            --        IF @TrackProgress = 1
            --            BEGIN
            --                PRINT 'Adding INDEX PI_EDW_CoachingDetail_IDs';
            --            END;
            --        CREATE NONCLUSTERED INDEX PI_EDW_CoachingDetail_IDs ON dbo.DIM_EDW_CoachingDetail ( ItemCreatedWhen ASC , ItemModifiedWhen ASC , HARiskCategory_ItemModifiedWhen ASC , HAUserRiskArea_ItemModifiedWhen ASC , HAUserQuestion_ItemModifiedWhen ASC , HAUserAnswers_ItemModifiedWhen ASC) WITH ( PAD_INDEX = OFF , STATISTICS_NORECOMPUTE = OFF , SORT_IN_TEMPDB = OFF , DROP_EXISTING = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ;
            --    END;

            IF NOT EXISTS ( SELECT
                                   name
                            FROM sys.indexes
                            WHERE
                                   name = 'PI_EDW_CoachingDetail_IDs') 
                BEGIN

                    PRINT 'Adding INDEX PI_EDW_CoachingDetail_IDs';

                    CREATE CLUSTERED INDEX PI_EDW_CoachingDetail_IDs ON dbo.DIM_EDW_CoachingDetail ( ItemID
                    , ItemGUID
                    , GoalID
                    , UserGUID
                    , SiteGUID
                    , AccountID
                    , AccountCD
                    , WeekendDate
                    , NodeGUID) WITH ( PAD_INDEX = OFF , STATISTICS_NORECOMPUTE = OFF ,
                    SORT_IN_TEMPDB = OFF , DROP_EXISTING = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ;
                END;

            --The staging table exists, CHANGES will be determined and applied.

            IF EXISTS ( SELECT
                               name
                        FROM tempdb.dbo.sysobjects
                        WHERE
                               id = OBJECT_ID ( N'tempdb..##TEMP_EDW_CoachingDetail_DATA')) 

                BEGIN
                    PRINT 'Dropping ##TEMP_EDW_CoachingDetail_DATA';
                    DROP TABLE
                         ##TEMP_EDW_CoachingDetail_DATA;
                END;

/*---------------------------------------------------------------------------
*****************************************************************************
*/

            SELECT
                   * INTO
                          ##TEMP_EDW_CoachingDetail_DATA
            FROM view_EDW_CoachingDetail_CT;
            --WHERE CHANGED_FLG IS NOT NULL;

            --EXEC proc_Add_EDW_CT_StdCols '##TEMP_EDW_CoachingDetail_DATA';
            ALTER TABLE ##TEMP_EDW_CoachingDetail_DATA
            ADD
                        LastModifiedDate DATETIME NULL;
            ALTER TABLE ##TEMP_EDW_CoachingDetail_DATA
            ADD
                        RowNbr INT NULL;
            ALTER TABLE ##TEMP_EDW_CoachingDetail_DATA
            ADD
                        DeletedFlg BIT NULL;
            ALTER TABLE ##TEMP_EDW_CoachingDetail_DATA
            ADD
                        TimeZone NVARCHAR (10) NULL;
            ALTER TABLE ##TEMP_EDW_CoachingDetail_DATA
            ADD
                        ConvertedToCentralTime BIT NULL;

            CREATE CLUSTERED INDEX temp_PI_EDW_CoachingDetail_IDs ON dbo.##TEMP_EDW_CoachingDetail_DATA ( ItemID
            , ItemGUID
            , GoalID
            , UserGUID
            , SiteGUID
            , AccountID
            , AccountCD
            , WeekendDate
            , NodeGUID) WITH ( PAD_INDEX = OFF , STATISTICS_NORECOMPUTE = OFF ,
            SORT_IN_TEMPDB = OFF , DROP_EXISTING = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ;

            IF @KeepData = 1
                BEGIN
                    PRINT 'KEEPING TEMP DATA IN TABLE TEMP_EDW_CoachingDetail_DATA';
                    IF EXISTS ( SELECT
                                       name
                                FROM sys.tables
                                WHERE
                                       name = 'TEMP_EDW_CoachingDetail_DATA') 
                        BEGIN
                            DROP TABLE
                                 TEMP_EDW_CoachingDetail_DATA;
                        END;

                    SELECT
                           * INTO
                                  TEMP_EDW_CoachingDetail_DATA
                    FROM ##TEMP_EDW_CoachingDetail_DATA;

                    CREATE CLUSTERED INDEX temp_PI_EDW_CoachingDetail_IDs ON TEMP_EDW_CoachingDetail_DATA ( ItemID
                    , ItemGUID
                    , GoalID
                    , UserGUID
                    , SiteGUID
                    , AccountID
                    , AccountCD
                    , WeekendDate
                    , NodeGUID) WITH ( PAD_INDEX = OFF ,
                    STATISTICS_NORECOMPUTE = OFF , SORT_IN_TEMPDB = OFF , DROP_EXISTING = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ;

                END;

            SET @CNT_PulledRecords = ( SELECT
                                              COUNT ( *) 
                                       FROM ##TEMP_EDW_CoachingDetail_DATA) ;

            --***************************************************************
            -- ADD NEW INSERTS
            DECLARE
                   @iInsert AS INT = 0;
            EXEC @iInsert = proc_CT_CoachingDetail_AddNewRecs ;
            EXEC proc_EDW_CT_ExecutionLog_Update_Counts @RecordID , 'I' , @iInsert;

            --***************************************************************
            -- FIND UPDATES
            DECLARE
                   @iUpdt AS INT = 0;
            EXEC @iUpdt = proc_CT_CoachingDetail_AddUpdatedRecs ;
            PRINT 'Updated Count: ' + CAST ( @iUpdt AS NVARCHAR ( 50)) ;

            EXEC proc_EDW_CT_ExecutionLog_Update_Counts @RecordID , 'U' , @iUpdt;

            --***********************************************
            --FIND DELETED ROWS
            DECLARE
                   @iDels AS INT = 0;
            EXEC @iDels = proc_CT_CoachingDetail_AddDeletedRecs ;

            PRINT 'Deleted Count: ' + CAST ( @iDels AS NVARCHAR ( 50)) ;

            EXEC proc_EDW_CT_ExecutionLog_Update_Counts @RecordID , 'D' , @iDels;

            SET @CNT_StagingTable = ( SELECT
                                             COUNT ( *) 
                                      FROM DIM_EDW_CoachingDetail) ;
            UPDATE CT_VersionTracking
                SET
                    CNT_PulledRecords = @iCnt
            WHERE
                  RowNbr = @RowNbr;

            UPDATE CT_VersionTracking
                SET
                    CNT_StagingTable = @CNT_StagingTable
            WHERE
                  RowNbr = @RowNbr;

            SET @CNT_PulledRecords = ( SELECT
                                              COUNT ( *) 
                                       FROM ##TEMP_EDW_CoachingDetail_DATA) ;

            EXEC proc_CT_EDW_CoachingDetail_NoDups ;
            EXEC proc_EDW_ChangeGmtToCentralTime 'DIM_EDW_CoachingDetail';
            SET @STime = GETDATE () ;
            EXEC proc_EDW_CT_ExecutionLog_Update @RecordID , 'proc_EDW_CoachingDetail' , @STime , @CNT_PulledRecords , 'U';

        END;
END;

GO
PRINT 'Created proc_EDW_CoachingDetail';
GO 
