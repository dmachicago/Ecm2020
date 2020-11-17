
/*---------------------------------------------
Developer  : W. Dale Miller
05.28.2015 : WDM - completed unit testing
07.08.2015 : WDM - competed validation testing 
*/

/*---------------------------------------------------------------------------
***************************************************************************
select top 1000 * from FACT_EDW_Trackers

exec proc_STAGING_EDW_CompositeTracker 0   --Process Changed Data only
exec proc_STAGING_EDW_CompositeTracker 1   --Reload ALL
exec proc_STAGING_EDW_CompositeTracker 0,7

select * from DIM_TEMP_EDW_Tracker_DATA
select  * from CT_VersionTracking ; 
PULLING Changes for versions between: 0  and 36


SELECT COUNT(*) FROM FACT_EDW_Trackers
SELECT COUNT(*) FROM [view_EDW_TrackerCompositeDetails_CT]
SELECT top 10 * FROM [view_EDW_TrackerCompositeDetails_CT]
SELECT TOP 100 * FROM [FACT_EDW_Trackers];
SELECT COUNT (*) FROM [FACT_EDW_Trackers]; 

PERF Measurements
03.26.2015 : 4681580 rows - 01:26:36 run time / PROD 1 @ LAB - full reload
03.29.2015 : Prod2  @ LAB : (xx row(s) affected) : 01:56:01 - Changed Records
04.23.2015 : 00 rows - 00:00:00 run time / PROD 1 @ LAB - full reload
***************************************************************************
*/

GO
PRINT 'FROM proc_STAGING_EDW_CompositeTracker.SQL';
PRINT 'Creating proc_STAGING_EDW_CompositeTracker';
GO
IF EXISTS ( SELECT
                   name
                   FROM sys.procedures
                   WHERE
                   name = 'proc_STAGING_EDW_CompositeTracker') 
    BEGIN
        PRINT 'Replacing proc_STAGING_EDW_CompositeTracker proc';
        DROP PROCEDURE
             proc_STAGING_EDW_CompositeTracker;
    END;
GO

IF EXISTS ( SELECT
                   table_name
                   FROM information_schema.tables
                   WHERE
                   table_name = 'DIM_TEMP_EDW_Tracker_DATA') 
    BEGIN
        IF NOT EXISTS ( SELECT
                               column_name
                               FROM information_schema.columns
                               WHERE
                               column_name = 'DeletedFlg' AND
                               table_name = 'DIM_TEMP_EDW_Tracker_DATA') 
            BEGIN
                ALTER TABLE DIM_TEMP_EDW_Tracker_DATA
                ADD
                            DeletedFlg BIT NULL;
            END;
    END ;
ELSE
    BEGIN
        PRINT 'Creating DIM_TEMP_EDW_Tracker_DATA Table';
        CREATE TABLE dbo.DIM_TEMP_EDW_Tracker_DATA (
                     TrackerNameAggregateTable VARCHAR ( 32) NOT NULL
                   , ItemID INT NOT NULL
                   , EventDate DATETIME NOT NULL
                   , IsProfessionallyCollected BIT NOT NULL
                   , TrackerCollectionSourceID INT NOT NULL
                   , Notes NVARCHAR ( 1000) NULL
                   , UserID INT NOT NULL
                   , CollectionSourceName_Internal NVARCHAR ( 100) NULL
                   , CollectionSourceName_External NVARCHAR ( 100) NULL
                   , EventName VARCHAR ( 7) NOT NULL
                   , UOM VARCHAR ( 10) NOT NULL
                   , KEY1 VARCHAR ( 18) NOT NULL
                   , VAL1 FLOAT NULL
                   , KEY2 VARCHAR ( 13) NOT NULL
                   , VAL2 FLOAT NULL
                   , KEY3 VARCHAR ( 12) NOT NULL
                   , VAL3 FLOAT NULL
                   , KEY4 VARCHAR ( 9) NOT NULL
                   , VAL4 FLOAT NULL
                   , KEY5 VARCHAR ( 12) NOT NULL
                   , VAL5 FLOAT NULL
                   , KEY6 VARCHAR ( 11) NOT NULL
                   , VAL6 FLOAT NULL
                   , KEY7 VARCHAR ( 10) NOT NULL
                   , VAL7 FLOAT NULL
                   , KEY8 VARCHAR ( 3) NOT NULL
                   , VAL8 FLOAT NULL
                   , KEY9 VARCHAR ( 2) NOT NULL
                   , VAL9 INT NULL
                   , KEY10 VARCHAR ( 2) NOT NULL
                   , VAL10 INT NULL
                   , ItemCreatedBy INT NULL
                   , ItemCreatedWhen DATETIME NULL
                   , ItemModifiedBy INT NULL
                   , ItemModifiedWhen DATETIME NULL
                   , IsProcessedForHa BIT NULL
                   , TXTKEY1 VARCHAR ( 10) NOT NULL
                   , TXTVAL1 NVARCHAR ( 500) NULL
                   , TXTKEY2 VARCHAR ( 8) NOT NULL
                   , TXTVAL2 NVARCHAR ( 255) NULL
                   , TXTKEY3 VARCHAR ( 2) NOT NULL
                   , TXTVAL3 INT NULL
                   , ItemOrder INT NULL
                   , ItemGuid UNIQUEIDENTIFIER NULL
                   , UserGuid UNIQUEIDENTIFIER NOT NULL
                   , MPI VARCHAR ( 50) NOT NULL
                   , ClientCode VARCHAR ( 12) NULL
                   , SiteGUID UNIQUEIDENTIFIER NOT NULL
                   , AccountID INT NOT NULL
                   , AccountCD NVARCHAR ( 8) NULL
                   , IsAvailable BIT NULL
                   , IsCustom BIT NULL
                   , UniqueName NVARCHAR ( 50) NULL
                   , ColDesc NVARCHAR ( 50) NULL
                   , VendorID INT NULL
                   , VendorName NVARCHAR ( 32) NULL
                   , CT_ItemID INT NULL
                   , CT_ChangeVersion BIGINT NULL
                   , CMS_Operation NCHAR ( 1) NULL
                   , DeleteFlg BIT NULL
                   , ConvertedToCentralTime BIT NULL
                   , TimeZone NVARCHAR ( 10) NULL
                   , ItemLastUpdated DATETIME NULL
                   , DeletedFlg BIT NULL
        ) 
        ON [PRIMARY];
    END;
GO

CREATE PROCEDURE proc_STAGING_EDW_CompositeTracker
       @Reloadall INT = 0
     , @VersionNBR AS INT = NULL
     , @TrackProgress AS BIT = 0
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE
           @iChangesFound AS INT = 0;
    EXEC @iChangesFound = proc_CkTrackerDataChanged ;
    IF
           @iChangesFound = 0
        BEGIN
            PRINT 'No tracker changes found, run compete.';
            SET NOCOUNT OFF;
            RETURN;
        END;
    IF
           @iChangesFound = 1
        BEGIN
            PRINT 'Tracker changes found, UPDATES or INSERTS only - no deletes.';
        END;
    IF
           @iChangesFound = 2
        BEGIN
            PRINT 'Tracker changes found, UPDATES or INSERTS and DELETES.';
        END;

    DECLARE
           @iTotal AS BIGINT = 0;

    EXEC @iTotal = proc_QuickRowCount 'FACT_EDW_Trackers';

    IF @iTotal = 1
        BEGIN
            SET @Reloadall = 1;
        END;

    DECLARE
           @Synchronization_Version BIGINT = 0
         , @iVersion AS INT
         , @Lastviewpull_Version AS BIGINT
         , @Lastpullversion AS BIGINT
         , @CurrentDbVersion AS INT
         , @STime AS DATETIME
         , @TgtView AS NVARCHAR ( 100) = 'view_EDW_TrackerCompositeDetails'
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
         , @CNT_StagingTable INT = 0;

    PRINT '*******************************************************************************************';
    PRINT '********** NOTICE *************************************************************************';
    PRINT 'ONLY RECORDS WITH A CORRESPONDING CHANGE TRACKING RECORD WILL BE RETURNED BY THIS PROC.';
    PRINT '*******************************************************************************************';

    SET @SVRName = ( SELECT
                            @@SERVERNAME) ;
    DECLARE
           @RecordID AS UNIQUEIDENTIFIER = NEWID () ;
    SET @STime = GETDATE () ;
    EXEC proc_EDW_CT_ExecutionLog_Update @RecordID , 'proc_STAGING_EDW_CompositeTracker' , @STime , 0 , 'I';
    IF
           @Reloadall = NULL
        BEGIN
            SET @Reloadall = 0;
        END;
    IF @Reloadall = 1
        BEGIN

            --print 'Loc #01' ;

            SET @VersionNBR = NULL;
            IF
                   @TrackProgress = 1
                BEGIN
                    PRINT 'RELOAD is ON: ' + CAST ( @Reloadall AS NVARCHAR ( 50)) ;
                    PRINT 'Change Version is: ' + CAST ( @VersionNBR AS NVARCHAR ( 50)) ;
                END;
        END;
    ELSE
        BEGIN

            --print 'Loc #02' ;

            IF
                   @TrackProgress = 1
                BEGIN
                    PRINT 'RELOAD is OFF: ' + CAST ( @Reloadall AS NVARCHAR ( 50)) ;
                    PRINT 'Change Version is: ' + CAST ( @VersionNBR AS NVARCHAR ( 50)) ;
                END;
        END;
    SET @CurrentDbVersion = CHANGE_TRACKING_CURRENT_VERSION () ;

    --print 'Loc #03' ;

    IF @Reloadall = 1
        BEGIN

            --print 'Loc #04' ;

            IF EXISTS ( SELECT
                               NAME
                               FROM sys.tables
                               WHERE
                               name = 'FACT_EDW_Trackers') 
                BEGIN
                    IF
                           @TrackProgress = 1
                        BEGIN
                            PRINT 'Dropping FACT_EDW_Trackers for FULL reload.';
                        END;
                    DROP TABLE
                         FACT_EDW_Trackers;
                END;
            ELSE
                BEGIN

                    --print 'Loc #05' ;

                    IF
                           @TrackProgress = 1
                        BEGIN
                            PRINT 'Reloading FACT_EDW_Trackers.';
                        END;
                END;
            IF
                   @TrackProgress = 1
                BEGIN
                    PRINT 'Standby, performing initial load of the HA data - this could take several hours, Started at: ' + CAST ( GETDATE () AS
                          NVARCHAR ( 50)) ;
                END;
            IF @Reloadall = 1
                BEGIN
                    IF
                           @TrackProgress = 1
                        BEGIN
                            PRINT 'RELOADING ALL EDW TRACKER Data.';
                        END;

                    --print 'Loc #06' ;

                    SELECT
                           * INTO
                                  FACT_EDW_Trackers
                           FROM view_EDW_TrackerCompositeDetails_CT;

                    EXEC proc_Add_EDW_CT_StdCols 'FACT_EDW_Trackers';

                    ALTER TABLE FACT_EDW_Trackers
                    ADD
                                ItemLastUpdated DATETIME NULL;

                    IF
                           @TrackProgress = 1
                        BEGIN
                            SET @iCnt = ( SELECT
                                                 COUNT ( *) 
                                                 FROM FACT_EDW_Trackers) ;
                            PRINT DB_NAME () + ' - Completed FULL RELOAD at: ' + CAST ( GETDATE () AS NVARCHAR ( 50)) + ' , loaded ' + CAST ( @iCnt
                                  AS NVARCHAR ( 50)) + ' records.';
                        END;

                    --print 'Loc #10' ;

                    SET @CNT_PulledRecords = ( SELECT
                                                      COUNT ( *) 
                                                      FROM FACT_EDW_Trackers) ;
                    SET @CNT_StagingTable = @CNT_PulledRecords;
                    IF NOT EXISTS ( SELECT
                                           name
                                           FROM sys.indexes
                                           WHERE
                                           name = 'PI_Staging_EDW_Tracker_Dates') 
                        BEGIN
                            IF
                                   @TrackProgress = 1
                                BEGIN
                                    PRINT 'Adding INDEX PI_Staging_EDW_Tracker_Dates at: ' + CAST ( GETDATE () AS NVARCHAR ( 50)) ;
                                END;
                            CREATE NONCLUSTERED INDEX PI_Staging_EDW_Tracker_Dates ON dbo.FACT_EDW_Trackers ( TrackerNameAggregateTable , itemID ,
                            ItemModifiedWhen) WITH ( PAD_INDEX = OFF , STATISTICS_NORECOMPUTE = OFF , SORT_IN_TEMPDB = OFF , DROP_EXISTING = OFF ,
                            ONLINE = OFF ,
                            ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ;
                        END;
                    SET @ExtractionDate = GETDATE () ;
                    SET @ExtractedVersion = -1;
                    SET @ExtractedRowCnt = ( SELECT
                                                    COUNT ( *) 
                                                    FROM FACT_EDW_Trackers) ;
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
                    @ExtractionDate ,
                    @ExtractedVersion ,
                    @CurrentDbVersion ,
                    @ExtractedRowCnt ,
                    @TgtView ,
                    @StartTime ,
                    @EndTime ,
                    @SVRName ,
                    @DBName ,
                    @CNT_Insert ,
                    @CNT_Update ,
                    @CNT_delete ,
                    @CNT_PulledRecords ,
                    @CNT_StagingTable) ;
                    IF
                           @TrackProgress = 1
                        BEGIN
                            PRINT 'Completed , RELOAD at: ' + CAST ( GETDATE () AS NVARCHAR ( 50)) ;
                        END;

                    --print 'Loc #12' ;

                    SET @iCnt = @@ROWCOUNT;
                    EXEC proc_EDW_CT_ExecutionLog_Update_Counts @RecordID , 'I' , @iCnt;
                END;

            -- SELECT * INTO [FACT_EDW_Trackers] FROM [view_EDW_TrackerCompositeDetails_CT];

            IF
                   @TrackProgress = 1
                BEGIN
                    PRINT 'Completed , reloading at: ' + CAST ( GETDATE () AS NVARCHAR ( 50)) ;
                END;
            IF NOT EXISTS ( SELECT
                                   name
                                   FROM sys.indexes
                                   WHERE
                                   name = 'PI_Staging_EDW_Tracker_Dates') 
                BEGIN
                    IF
                           @TrackProgress = 1
                        BEGIN
                            PRINT 'Adding INDEX PI_Staging_EDW_Tracker_Dates at: ' + CAST ( GETDATE () AS NVARCHAR ( 50)) ;
                        END;
                    CREATE NONCLUSTERED INDEX PI_Staging_EDW_Tracker_Dates ON dbo.FACT_EDW_Trackers ( TrackerNameAggregateTable , itemID ,
                    ItemModifiedWhen) WITH ( PAD_INDEX = OFF , STATISTICS_NORECOMPUTE = OFF , SORT_IN_TEMPDB = OFF , DROP_EXISTING = OFF ,
                    ONLINE = OFF ,
                    ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ;
                END;
            IF
                   @TrackProgress = 1
                BEGIN
                    PRINT 'Completed FULL RELOAD at: ' + CAST ( GETDATE () AS NVARCHAR ( 50)) ;
                END;

            --print 'Loc #13' ;

            SET @STime = GETDATE () ;

            EXEC proc_EDW_ChangeGmtToCentralTime 'FACT_EDW_Trackers';

            EXEC proc_EDW_CT_ExecutionLog_Update @RecordID , 'proc_STAGING_EDW_CompositeTracker' , @STime , @CNT_PulledRecords , 'U';
            EXEC proc_EDW_CT_ExecutionLog_Update_Counts @RecordID , 'I' , @iCnt;
            EXEC proc_EDW_CT_ExecutionLog_Update_Counts @RecordID , 'T' , @iCnt;

            --print 'Loc #15' ;        
            SET NOCOUNT OFF;
            RETURN;
        END;

    --print 'Loc #16' ;

    IF NOT EXISTS ( SELECT
                           NAME
                           FROM sys.tables
                           WHERE
                           name = 'FACT_EDW_Trackers') 
        BEGIN
            PRINT '****************************************************************************';
            PRINT 'FATAL ERROR: table FACT_EDW_Trackers was NOT found, aborting.';
            PRINT '****************************************************************************';
        END;
    ELSE
        BEGIN

            --print 'Loc #17' ;

            IF NOT EXISTS ( SELECT
                                   name
                                   FROM sys.indexes
                                   WHERE
                                   name = 'PI_Staging_EDW_Tracker_Dates') 
                BEGIN
                    IF
                           @TrackProgress = 1
                        BEGIN
                            PRINT 'Adding INDEX PI_Staging_EDW_Tracker_Dates';
                        END;
                    CREATE NONCLUSTERED INDEX PI_Staging_EDW_Tracker_Dates ON dbo.FACT_EDW_Trackers ( TrackerNameAggregateTable , itemID ,
                    ItemModifiedWhen) WITH ( PAD_INDEX = OFF , STATISTICS_NORECOMPUTE = OFF , SORT_IN_TEMPDB = OFF , DROP_EXISTING = OFF ,
                    ONLINE = OFF ,
                    ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ;
                END;
            IF NOT EXISTS ( SELECT
                                   name
                                   FROM sys.indexes
                                   WHERE
                                   name = 'PI_Staging_EDW_Tracker_IDs') 
                BEGIN
                    IF
                           @TrackProgress = 1
                        BEGIN
                            PRINT 'Adding INDEX PI_Staging_EDW_Tracker_IDs';
                        END;
                    CREATE CLUSTERED INDEX PI_Staging_EDW_Tracker_IDs ON dbo.FACT_EDW_Trackers ( TrackerNameAggregateTable , itemID) WITH ( PAD_INDEX = OFF ,
                    STATISTICS_NORECOMPUTE = OFF , SORT_IN_TEMPDB = OFF , DROP_EXISTING = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON ,
                    ALLOW_PAGE_LOCKS = ON) ;
                END;

            --The staging table exists, CHANGES will be determined and applied.

            IF EXISTS ( SELECT
                               name

                        --FROM tempdb.dbo.sysobjects
                        --WHERE id = OBJECT_ID ( N'tempdb..#DIM_TEMP_EDW_Tracker_DATA')) 

                               FROM sys.tables
                               WHERE
                               name = 'DIM_TEMP_EDW_Tracker_DATA') 
                BEGIN
                    IF
                           @TrackProgress = 1
                        BEGIN
                            PRINT 'Dropping DIM_TEMP_EDW_Tracker_DATA';
                        END;
                    DROP TABLE
                         DIM_TEMP_EDW_Tracker_DATA;
                END;
            PRINT 'Standby, PULL HA changes- this could take several hours: ' + CAST ( GETDATE () AS NVARCHAR ( 50)) ;
            SET @LastpullVersion = ( SELECT
                                            MAX ( CurrentDbVersion) 
                                            FROM CT_VersionTracking
                                            WHERE
                                            SVRname = @@ServerName AND
                                            DBName = DB_NAME () AND
                                            TgtView = @TgtView) ;
            SET @LastViewPull_Version = ( SELECT
                                                 MAX ( ExtractedVersion) 
                                                 FROM CT_VersionTracking
                                                 WHERE
                                                 SVRname = @@ServerName AND
                                                 DBName = DB_NAME () AND
                                                 TgtView = @TgtView) ;
            IF
                   @LastpullVersion < 0 OR
                   @LastpullVersion IS NULL
                BEGIN
                    SET @LastpullVersion = 0;
                END;
            IF
                   @LastViewPull_Version < 0 OR
                   @LastpullVersion IS NULL
                BEGIN
                    SET @LastViewPull_Version = 0;
                END;
            IF
                   @TrackProgress = 1
                BEGIN
                    PRINT 'Pulling @LastpullVersion ' + CAST ( @LastpullVersion AS NVARCHAR ( 50)) ;
                    PRINT 'Pulling @LastViewPull_Version ' + CAST ( @LastViewPull_Version AS NVARCHAR ( 50)) ;
                END;

            --****************************************************************************
            --FILL THE TEMP TABLE WITH DATA
            --****************************************************************************

            SELECT
                   * INTO
                          DIM_TEMP_EDW_Tracker_DATA
                   FROM view_EDW_TrackerCompositeDetails_CT
                   WHERE CMS_Operation IS NOT NULL;

            EXEC proc_Add_EDW_CT_StdCols 'DIM_TEMP_EDW_Tracker_DATA';

            SET @CNT_PulledRecords = @@ROWCOUNT;

            IF NOT EXISTS ( SELECT
                                   column_name
                                   FROM information_schema.columns
                                   WHERE
                                   column_name = 'DeletedFlg' AND
                                   table_name = 'DIM_TEMP_EDW_Tracker_DATA') 
                BEGIN
                    ALTER TABLE DIM_TEMP_EDW_Tracker_DATA
                    ADD
                                DeletedFlg BIT NULL;
                END;

            --ALTER TABLE DIM_TEMP_EDW_Tracker_DATA
            --ADD
            --            DeletedFlg bit NULL;

            ALTER TABLE DIM_TEMP_EDW_Tracker_DATA
            ADD
                        ItemLastUpdated DATETIME NULL;
            UPDATE DIM_TEMP_EDW_Tracker_DATA
              SET
                  ItemLastUpdated = GETDATE () ;
            IF NOT EXISTS ( SELECT
                                   name
                                   FROM sys.indexes
                                   WHERE
                                   name = 'temp_PI_Staging_EDW_Tracker_IDs') 
                BEGIN
                    CREATE CLUSTERED INDEX temp_PI_Staging_EDW_Tracker_IDs ON dbo.DIM_TEMP_EDW_Tracker_DATA ( TrackerNameAggregateTable , itemID ,
                    ItemModifiedWhen) WITH ( PAD_INDEX = OFF , STATISTICS_NORECOMPUTE = OFF , SORT_IN_TEMPDB = OFF , DROP_EXISTING = OFF ,
                    ONLINE = OFF ,
                    ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ;
                END;

            IF
                   @TrackProgress = 1
                BEGIN
                    SET @iCnt = ( SELECT
                                         COUNT ( *) 
                                         FROM DIM_TEMP_EDW_Tracker_DATA) ;
                    PRINT DB_NAME () + ' - Completed PULL at: ' + CAST ( GETDATE () AS NVARCHAR ( 50)) + ' , loaded ' + CAST ( @iCnt AS NVARCHAR ( 50)) + ' records.';
                END;
            SET @STime = GETDATE () ;
            SET @CurrentDbVersion = CHANGE_TRACKING_CURRENT_VERSION () ;
            IF
                   @TrackProgress = 1
                BEGIN
                    PRINT '@CurrentDbVersion: ' + CAST ( @CurrentDbVersion AS NVARCHAR ( 50)) ;
                END;
            SET @ExtractionDate = GETDATE () ;
            SET @ExtractedRowCnt = ( SELECT
                                            COUNT ( *) 
                                            FROM DIM_TEMP_EDW_Tracker_DATA) ;

            --SET @TgtView = 'view_EDW_TrackerCompositeDetails';

            SET @EndTime = GETDATE () ;
            IF
                   @TrackProgress = 1
                BEGIN
                    PRINT 'ADDING THE TRACKING RECORD.';
                END;
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
                 , CNT_PulledRecords) 
            VALUES
            (
            @ExtractionDate ,

            --@LastpullVersion ,

            @CurrentDbVersion ,
            @CurrentDbVersion ,
            @ExtractedRowCnt ,
            @TgtView ,
            @StartTime ,
            @EndTime ,
            @SVRName ,
            @DBName ,
            @CNT_Insert ,
            @CNT_Update ,
            @CNT_delete ,
            @CNT_PulledRecords) ;
            SET @RowNbr = ( SELECT
                                   MAX ( RowNbr) 
                                   FROM CT_VersionTracking
                                   WHERE
                                   SVRName = @SVRName AND
                                   DBName = @DBName AND
                                   TgtView = @TgtView) ;
            --SET @CNT_PulledRecords = ( SELECT
            --                              COUNT ( *) 
            --                                  FROM DIM_TEMP_EDW_Tracker_DATA );
            UPDATE CT_VersionTracking
              SET
                  CNT_PulledRecords = @iCnt
                   WHERE
                         RowNbr = @RowNbr;

            --SELECT * FROM CT_VersionTracking
            --The temp table is loaded.
            --Check to see if NEW records exist and if not, insert them into the staging table

            SET @iCnt = ( SELECT
                                 COUNT ( *) 
                                 FROM
                                      DIM_TEMP_EDW_Tracker_DATA AS T1
                                           LEFT JOIN
                                           FACT_EDW_Trackers AS T2
                                           ON
                                 T1.TrackerNameAggregateTable = T2.TrackerNameAggregateTable AND
                                 T1.ItemId = T2.ItemId
                                 WHERE T2.ItemID IS NULL) ;
            IF
                   @TrackProgress = 1
                BEGIN
                    PRINT '#New Records found: ' + CAST ( @iCnt AS NVARCHAR ( 50)) + '. Updating VersionTracking RowNbr: ' + CAST ( @RowNbr AS
                          NVARCHAR ( 5)) ;
                END;
            UPDATE CT_VersionTracking
              SET
                  CNT_Insert = @iCnt
                   WHERE
                         RowNbr = @RowNbr;

            --***************************************************
            --FIND AND PROCESS NEW RECORDS
            --***************************************************
            EXEC @iCnt = proc_CT_TrackerComposite_AddNewRecs ;
            --***************************************************            

            PRINT 'NEW RECORDS FOUND : ' + CAST ( @iCnt AS NVARCHAR ( 50)) ;
            EXEC proc_EDW_CT_ExecutionLog_Update_Counts @RecordID , 'I' , @iCnt;
            EXEC proc_EDW_CT_ExecutionLog_Update_Counts @RecordID , 'I' , @iCnt;
            EXEC proc_EDW_CT_ExecutionLog_Update_Counts @RecordID , 'T' , @iCnt;

            --Check to see if CURRENT records have differnet HASH codes and if so, update the staging table

            SET @iCnt = ( SELECT
                                 COUNT ( *) 
                                 FROM
                                      FACT_EDW_Trackers AS T2
                                           JOIN
                                           DIM_TEMP_EDW_Tracker_DATA AS T1
                                           ON
                                 T1.TrackerNameAggregateTable = T2.TrackerNameAggregateTable AND
                                 T1.ItemId = T2.ItemId
                                 WHERE T1.CMS_Operation IS NOT NULL) ;
            IF
                   @TrackProgress = 1
                BEGIN
                    PRINT '#Records found to update: ' + CAST ( @iCnt AS NVARCHAR ( 50)) + '. Updating VersionTracking RowNbr: ' + CAST ( @RowNbr AS
                          NVARCHAR ( 5)) ;
                END;
            UPDATE CT_VersionTracking
              SET
                  CNT_Update = @iCnt
                   WHERE
                         RowNbr = @RowNbr;

/*-----------------------------------------------------------------------------------------------
*********************************************************************************************
		  FIND AND PROCESS UPDATED ROWS
		  Set and record the Current DB change version and use it to prevent updating the data twice.
		  *********************************************************************************************
*/
            EXEC @iCnt = proc_CT_TrackerComposite_AddUpdatedRecs ;
            PRINT 'UPDATED RECORDS FOUND : ' + CAST ( @iCnt AS NVARCHAR ( 50)) ;

            EXEC proc_EDW_CT_ExecutionLog_Update_Counts @RecordID , 'U' , @iCnt;
            --EXEC proc_EDW_CT_ExecutionLog_Update_Counts @RecordID , 'U' , @iCnt;

/*-------------------------------------------------------------------------------------------------------------------------------
 update DIM_TEMP_EDW_Tracker_DATA Set CMS_Operation = 'D' where ItemID in (Select top 100 ItemID from DIM_TEMP_EDW_Tracker_DATA) 
*/
            --***************************************
            -- MARK Delted records
            EXEC @iCnt = proc_CT_TrackerComposite_AddDeletedRecs ;
            PRINT 'DELETED RECORDS FLAGGED : ' + CAST ( @iCnt AS NVARCHAR ( 50)) ;

            UPDATE CT_VersionTracking
              SET
                  CNT_delete = @iCnt
                   WHERE
                         RowNbr = @RowNbr;

            EXEC proc_EDW_CT_ExecutionLog_Update_Counts @RecordID , 'D' , @iCnt;
            SET @CNT_StagingTable = ( SELECT
                                             COUNT ( *) 
                                             FROM FACT_EDW_Trackers) ;
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
            SET @STime = GETDATE () ;

            EXEC proc_EDW_ChangeGmtToCentralTime 'FACT_EDW_Trackers';
            EXEC proc_EDW_CT_ExecutionLog_Update @RecordID , 'proc_STAGING_EDW_CompositeTracker' , @STime , @CNT_PulledRecords , 'U';

            --EXEC proc_EDW_CT_ExecutionLog_Update_Counts @RecordID , 'D', @iCnt;

            EXEC proc_EDW_CT_ExecutionLog_Update_Counts @RecordID , 'T' , @CNT_PulledRecords;
        END;
    SET NOCOUNT OFF;
END;
GO
PRINT 'Created proc_STAGING_EDW_CompositeTracker';
GO 
