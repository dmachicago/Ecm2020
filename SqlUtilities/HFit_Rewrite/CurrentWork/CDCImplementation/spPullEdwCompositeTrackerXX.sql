
/*
select top 1000 * from DIM_EDW_Trackers

exec proc_STAGING_EDW_CompositeTracker 0   --Process Changed Data only
exec proc_STAGING_EDW_CompositeTracker 1   --Reload ALL
exec proc_STAGING_EDW_CompositeTracker 0,7

select * from DIM_TEMPTBL_Staging_EDW_Tracker_DATA
select  * from CT_VersionTracking ; 
PULLING Changes for versions between: 0  and 36


SELECT COUNT(*) FROM DIM_EDW_Trackers
SELECT COUNT(*) FROM [view_EDW_TrackerCompositeDetails_CT]
SELECT top 10 * FROM [view_EDW_TrackerCompositeDetails_CT]
SELECT TOP 100 * FROM [DIM_EDW_Trackers];
SELECT COUNT (*) FROM [DIM_EDW_Trackers]; 

PERF Measurements
03.26.2015 : 4681580 rows - 01:26:36 run time / PROD 1 @ LAB - full reload

03.29.2015 : Prod2  @ LAB : (xx row(s) affected) : 01:56:01 - Changed Records
*/

GO
PRINT 'FROM proc_STAGING_EDW_CompositeTracker.SQL';
PRINT 'Creating proc_STAGING_EDW_CompositeTracker';
GO
IF EXISTS ( SELECT
            name
              FROM sys.procedures
              WHERE name = 'proc_STAGING_EDW_CompositeTracker') 
    BEGIN
        PRINT 'Replacing proc_STAGING_EDW_CompositeTracker proc';
        DROP PROCEDURE proc_STAGING_EDW_CompositeTracker;
    END;
GO

CREATE PROCEDURE proc_STAGING_EDW_CompositeTracker
@Reloadall int = 0
, @VersionNBR AS int = NULL
, @TrackProgress AS bit = 1
AS
BEGIN

    DECLARE
       @Synchronization_Version bigint = 0
     , @iVersion AS int
     , @Lastviewpull_Version AS bigint
     , @Lastpullversion AS bigint
     , @CurrentDbVersion AS int
     , @STime AS datetime
     , @TgtView AS nvarchar (100) = 'view_EDW_TrackerCompositeDetails'
     , @ExtractionDate AS datetime
     , @ExtractedVersion AS int
     , @ExtractedRowCnt AS int
     , @EndTime AS datetime
     , @CNT_PulledRecords AS int = 0
     , @iCnt AS int = 0
     , @RowNbr AS int = 0
     , @StartTime AS datetime = GETDATE () 
     , @SVRName AS nvarchar (100) 
     , @DBName AS nvarchar (100) = DB_NAME () 
     , @CNT_Insert AS int = 0
     , @CNT_Update AS int = 0
     , @CNT_Delete AS int = 0
     , @CNT_StagingTable int = 0;

    SET @SVRName = (SELECT @@SERVERNAME) ;

    declare @RecordID as uniqueidentifier = newid() ;
    set @STime  = getdate();
    exec proc_EDW_CT_ExecutionLog_Update @RecordID, 'proc_STAGING_EDW_CompositeTracker', @STime, 0, 'I';    

    IF @Reloadall = NULL
        BEGIN
            SET @Reloadall = 0;
        END;

    IF @Reloadall = 1
        BEGIN
            SET @VersionNBR = NULL;
            IF @TrackProgress = 1
                BEGIN
                    PRINT 'RELOAD is ON: ' + CAST ( @Reloadall AS nvarchar ( 50)) ;
                    PRINT 'Change Version is: ' + CAST ( @VersionNBR AS nvarchar ( 50)) ;
                END;
        END;
    ELSE
        BEGIN
            IF  @VersionNBR IS NULL
                BEGIN

                    SET @iVersion = ( SELECT MAX ( ExtractedVersion) 
                                        FROM CT_VersionTracking
                                        WHERE TgtView = @TgtView) ;
                    IF @iVersion IS NULL
                        BEGIN
                            SET @ExtractedVersion = - 1;
                        END;
                    ELSE
                        BEGIN
                            SET @ExtractedVersion = @iVersion;
                        END;

                    IF @iVersion IS NULL
                        BEGIN
                            SET @VersionNBR = NULL;
                        END;
                    ELSE
                        BEGIN
                            SET @VersionNBR = @iVersion - 1;
                        END;
                END;
            IF @TrackProgress = 1
                BEGIN
                    PRINT 'RELOAD is OFF: ' + CAST ( @Reloadall AS nvarchar ( 50)) ;
                    PRINT 'Change Version is: ' + CAST ( @VersionNBR AS nvarchar ( 50)) ;
                END;
        END;

    SET @CurrentDbVersion = CHANGE_TRACKING_CURRENT_VERSION () ;

    IF @Reloadall = 1
        BEGIN
            IF EXISTS ( SELECT
                        NAME
                          FROM sys.tables
                          WHERE name = 'DIM_EDW_Trackers') 
                BEGIN
                    IF @TrackProgress = 1
                        BEGIN
                            PRINT 'Dropping DIM_EDW_Trackers for FULL reload.';
                        END;
                    DROP TABLE
                    DIM_EDW_Trackers;
                END;
            ELSE
                BEGIN
                    IF @TrackProgress = 1
                        BEGIN
                            PRINT 'Reloading DIM_EDW_Trackers.';
                        END;
                END;
            IF @TrackProgress = 1
                BEGIN
                    PRINT 'Standby, performing initial load of the HA data - this could take several hours, Started at: ' + CAST ( GETDATE () AS nvarchar ( 50)) ;
                END;

            IF @Reloadall = 1
                BEGIN
                    IF @TrackProgress = 1
                        BEGIN
                            PRINT 'RELOADING ALL EDW HA Data.';
                        END;

                    SELECT * INTO DIM_EDW_Trackers
                      FROM view_EDW_TrackerCompositeDetails_CT;

                    ALTER TABLE DIM_EDW_Trackers
                    ADD DeleteFlg bit NULL;
                    ALTER TABLE DIM_EDW_Trackers
                    ADD ItemLastUpdated datetime NULL;

                    IF @TrackProgress = 1
                        BEGIN
                            SET @iCnt = (SELECT COUNT (*) 
                                           FROM DIM_EDW_Trackers) ;
                            PRINT DB_NAME () + ' - Completed FULL RELOAD at: ' + CAST ( GETDATE () AS nvarchar ( 50)) + ' , loaded ' + CAST (@iCnt AS nvarchar (50)) + ' records.';
                        END;

                    SET @CNT_PulledRecords = (SELECT COUNT (*) 
                                                FROM DIM_EDW_Trackers) ;
                    SET @CNT_StagingTable = @CNT_PulledRecords;
                    IF NOT EXISTS ( SELECT name
                                      FROM sys.indexes
                                      WHERE name = 'PI_Staging_EDW_Tracker_Dates'
                    ) 
                        BEGIN
                            IF @TrackProgress = 1
                                BEGIN
                                    PRINT 'Adding INDEX PI_Staging_EDW_Tracker_Dates at: ' + CAST ( GETDATE () AS nvarchar ( 50)) ;
                                END;
                            CREATE NONCLUSTERED INDEX PI_Staging_EDW_Tracker_Dates ON dbo.DIM_EDW_Trackers (TrackerNameAggregateTable, itemID, ItemModifiedWhen) WITH ( PAD_INDEX = OFF , STATISTICS_NORECOMPUTE = OFF , SORT_IN_TEMPDB = OFF , DROP_EXISTING = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ;
                        END;

                    SET @ExtractionDate = GETDATE () ;
                    SET @ExtractedVersion = -1;
                    SET @ExtractedRowCnt = (SELECT COUNT (*) 
                                              FROM DIM_EDW_Trackers) ;

                    SET @EndTime = GETDATE () ;

                    INSERT INTO CT_VersionTracking (ExtractionDate
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
                                                  , CNT_StagingTable
                    ) 
                    VALUES
                           (@ExtractionDate ,
                           @ExtractedVersion ,
                           @CurrentDbVersion ,
                           @ExtractedRowCnt ,
                           @TgtView ,
                           @StartTime ,
                           @EndTime,
                           @SVRName,
                           @DBName,
                           @CNT_Insert,
                           @CNT_Update,
                           @CNT_delete,
                           @CNT_PulledRecords,
                           @CNT_StagingTable) ;

                    IF @TrackProgress = 1
                        BEGIN
                            PRINT 'Completed , RELOAD at: ' + CAST ( GETDATE () AS nvarchar ( 50)) ;
                        END;

                END;
            -- SELECT * INTO [DIM_EDW_Trackers] FROM [view_EDW_TrackerCompositeDetails_CT];
            IF @TrackProgress = 1
                BEGIN
                    PRINT 'Completed , reloading at: ' + CAST ( GETDATE () AS nvarchar ( 50)) ;
                END;
            IF NOT EXISTS ( SELECT
                            name
                              FROM sys.indexes
                              WHERE name = 'PI_Staging_EDW_Tracker_Dates') 
                BEGIN
                    IF @TrackProgress = 1
                        BEGIN
                            PRINT
                            'Adding INDEX PI_Staging_EDW_Tracker_Dates at: ' + CAST ( GETDATE () AS nvarchar ( 50)) ;
                        END;
                    CREATE NONCLUSTERED INDEX PI_Staging_EDW_Tracker_Dates ON dbo.DIM_EDW_Trackers ( TrackerNameAggregateTable, itemID, ItemModifiedWhen) WITH ( PAD_INDEX = OFF , STATISTICS_NORECOMPUTE = OFF , SORT_IN_TEMPDB = OFF , DROP_EXISTING = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ;
                END;
            IF @TrackProgress = 1
                BEGIN
                    PRINT
                    'Completed FULL RELOAD at: ' + CAST ( GETDATE () AS nvarchar ( 50)) ;
                END;
	   
		  set @STime  = getdate();
		  exec proc_EDW_CT_ExecutionLog_Update @RecordID, 'proc_STAGING_EDW_CompositeTracker', @STime, @CNT_PulledRecords, 'U';

            RETURN;
        END;

    IF NOT EXISTS ( SELECT
                    NAME
                      FROM sys.tables
                      WHERE name = 'DIM_EDW_Trackers') 
        BEGIN
            PRINT '****************************************************************************';
            PRINT 'FATAL ERROR: table DIM_EDW_Trackers was NOT found, aborting.';
            PRINT '****************************************************************************';
        END;
    ELSE
        BEGIN

            IF NOT EXISTS ( SELECT
                            name
                              FROM sys.indexes
                              WHERE name = 'PI_Staging_EDW_Tracker_Dates') 
                BEGIN
                    IF @TrackProgress = 1
                        BEGIN
                            PRINT 'Adding INDEX PI_Staging_EDW_Tracker_Dates';
                        END;
                    CREATE NONCLUSTERED INDEX PI_Staging_EDW_Tracker_Dates ON dbo.DIM_EDW_Trackers ( TrackerNameAggregateTable, itemID, ItemModifiedWhen) WITH ( PAD_INDEX = OFF , STATISTICS_NORECOMPUTE = OFF , SORT_IN_TEMPDB = OFF , DROP_EXISTING = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ;
                END;

            IF NOT EXISTS ( SELECT
                            name
                              FROM sys.indexes
                              WHERE name = 'PI_Staging_EDW_Tracker_IDs') 
                BEGIN
                    IF @TrackProgress = 1
                        BEGIN
                            PRINT 'Adding INDEX PI_Staging_EDW_Tracker_IDs';
                        END;
                    CREATE CLUSTERED INDEX PI_Staging_EDW_Tracker_IDs ON dbo.DIM_EDW_Trackers ( TrackerNameAggregateTable, itemID) WITH ( PAD_INDEX = OFF , STATISTICS_NORECOMPUTE = OFF , SORT_IN_TEMPDB = OFF , DROP_EXISTING = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ;
                END;

            --The staging table exists, CHANGES will be determined and applied.

            IF EXISTS ( SELECT
                        name
                        --FROM tempdb.dbo.sysobjects
                        --WHERE id = OBJECT_ID ( N'tempdb..#DIM_EDW_Trackers')) 
                          FROM sys.tables
                          WHERE name = 'DIM_TEMPTBL_Staging_EDW_Tracker_DATA') 
                BEGIN
                    IF @TrackProgress = 1
                        BEGIN
                            PRINT 'Dropping DIM_TEMPTBL_Staging_EDW_Tracker_DATA';
                        END;
                    DROP TABLE
                    DIM_TEMPTBL_Staging_EDW_Tracker_DATA;
                END;
            PRINT
            'Standby, PULL HA changes- this could take several hours: ' + CAST ( GETDATE () AS nvarchar ( 50)) ;

            SET 	@LastpullVersion = ( SELECT  MAX (CurrentDbVersion) 
                                           FROM CT_VersionTracking
                                           WHERE SVRname = @@ServerName
                                             AND DBName = DB_NAME () 
                                             AND TgtView = @TgtView) ;
            SET @LastViewPull_Version = ( SELECT MAX ( ExtractedVersion) 
                                            FROM CT_VersionTracking
                                            WHERE SVRname = @@ServerName
                                              AND DBName = DB_NAME () 
                                              AND TgtView = @TgtView) ;

            IF @LastpullVersion < 0
            OR @LastpullVersion IS NULL
                BEGIN
                    SET @LastpullVersion = 0;
                END;
            IF @LastViewPull_Version < 0
            OR @LastpullVersion IS NULL
                BEGIN
                    SET @LastViewPull_Version = 0;
                END;
            IF @TrackProgress = 1
                BEGIN
                    PRINT 'Pulling @LastpullVersion ' + CAST (@LastpullVersion AS nvarchar (50)) ;
                    PRINT 'Pulling @LastViewPull_Version ' + CAST (@LastViewPull_Version AS nvarchar (50)) ;
                END;

            IF @LastpullVersion = @CurrentDbVersion
                BEGIN
                    PRINT
                    'NO Changes found as the db version of ' + CAST (@CurrentDbVersion AS nvarchar (50)) + ' has not changed.';
                    RETURN;
                END;
            ELSE
                BEGIN
                    PRINT 'PULLING Changes for versions between: ' + CAST (@LastpullVersion AS nvarchar (50)) + '  and ' + CAST (@CurrentDbVersion AS nvarchar (50)) ;
                END;

            /*******************************************************************************/

            SELECT * INTO DIM_TEMPTBL_Staging_EDW_Tracker_DATA
              FROM view_EDW_TrackerCompositeDetails_CT
              WHERE CMS_Operation IS NOT NULL;

            ALTER TABLE DIM_TEMPTBL_Staging_EDW_Tracker_DATA
            ADD DeleteFlg bit NULL;
            ALTER TABLE DIM_TEMPTBL_Staging_EDW_Tracker_DATA
            ADD ItemLastUpdated datetime NULL;
            UPDATE DIM_TEMPTBL_Staging_EDW_Tracker_DATA
                SET ItemLastUpdated = GETDATE () ;

            IF NOT EXISTS (SELECT name
                             FROM sys.indexes
                             WHERE name = 'temp_PI_Staging_EDW_Tracker_IDs') 
                BEGIN
                    CREATE CLUSTERED INDEX temp_PI_Staging_EDW_Tracker_IDs ON dbo.DIM_TEMPTBL_Staging_EDW_Tracker_DATA ( TrackerNameAggregateTable, itemID, ItemModifiedWhen) WITH ( PAD_INDEX = OFF , STATISTICS_NORECOMPUTE = OFF , SORT_IN_TEMPDB = OFF , DROP_EXISTING = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ;
                END;

            SET @CNT_PulledRecords = (SELECT COUNT (*) 
                                        FROM DIM_TEMPTBL_Staging_EDW_Tracker_DATA) ;

            IF @TrackProgress = 1

                BEGIN
                    SET @iCnt = (SELECT COUNT (*) 
                                   FROM DIM_TEMPTBL_Staging_EDW_Tracker_DATA) ;
                    PRINT DB_NAME () + ' - Completed PULL at: ' + CAST ( GETDATE () AS nvarchar ( 50)) + ' , loaded ' + CAST (@iCnt AS nvarchar (50)) + ' records.';
                END;

            SET @STime = GETDATE () ;
            SET @CurrentDbVersion = CHANGE_TRACKING_CURRENT_VERSION () ;
            IF @TrackProgress = 1
                BEGIN
                    PRINT '@CurrentDbVersion: ' + CAST (@CurrentDbVersion AS nvarchar (50)) ;
                END;
            SET @ExtractionDate = GETDATE () ;
            SET @ExtractedRowCnt = (SELECT COUNT (*) 
                                      FROM DIM_TEMPTBL_Staging_EDW_Tracker_DATA) ;
            --SET @TgtView = 'view_EDW_TrackerCompositeDetails';
            SET @EndTime = GETDATE () ;

            IF @TrackProgress = 1
                BEGIN
                    PRINT 'ADDING THE TRACKING RECORD.';
                END;
            INSERT INTO CT_VersionTracking (ExtractionDate
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
            ) 
            VALUES
                   (@ExtractionDate ,
                   --@LastpullVersion ,
                   @CurrentDbVersion,
                   @CurrentDbVersion ,
                   @ExtractedRowCnt ,
                   @TgtView ,
                   @StartTime ,
                   @EndTime,
                   @SVRName,
                   @DBName,
                   @CNT_Insert,
                   @CNT_Update,
                   @CNT_delete,
                   @CNT_PulledRecords) ;

            SET @RowNbr = (SELECT MAX (RowNbr) 
                             FROM CT_VersionTracking
                             WHERE SVRName = @SVRName
                               AND DBName = @DBName
                               AND TgtView = @TgtView) ;

            SET @CNT_PulledRecords = (SELECT COUNT (*) 
                                        FROM
                                      DIM_TEMPTBL_Staging_EDW_Tracker_DATA) ;
            UPDATE CT_VersionTracking
                SET CNT_PulledRecords = @iCnt
              WHERE RowNbr = @RowNbr;

            --SELECT * FROM CT_VersionTracking
            --The temp table is loaded.
            --Check to see if NEW records exist and if not, insert them into the staging table
            SET @iCnt = ( SELECT COUNT (*) 
                            FROM
                          DIM_TEMPTBL_Staging_EDW_Tracker_DATA AS T1
                              LEFT JOIN DIM_EDW_Trackers AS T2
                                  ON T1.TrackerNameAggregateTable = T2.TrackerNameAggregateTable
                                 AND T1.ItemId = T2.ItemId
                            WHERE
                            T2.ItemID IS NULL) ;
            IF @TrackProgress = 1
                BEGIN
                    PRINT '#New Records found: ' + CAST (@iCnt AS nvarchar (50)) + '. Updating VersionTracking RowNbr: ' + CAST (@RowNbr AS nvarchar (5)) ;
                END;

            UPDATE CT_VersionTracking
                SET CNT_Insert = @iCnt
              WHERE RowNbr = @RowNbr;

            INSERT INTO dbo.DIM_EDW_Trackers (
            TrackerNameAggregateTable
          , ItemID
          , EventDate
          , IsProfessionallyCollected
          , TrackerCollectionSourceID
          , Notes
          , UserID
          , CollectionSourceName_Internal
          , CollectionSourceName_External
          , EventName
          , UOM
          , KEY1
          , VAL1
          , KEY2
          , VAL2
          , KEY3
          , VAL3
          , KEY4
          , VAL4
          , KEY5
          , VAL5
          , KEY6
          , VAL6
          , KEY7
          , VAL7
          , KEY8
          , VAL8
          , KEY9
          , VAL9
          , KEY10
          , VAL10
          , ItemCreatedBy
          , ItemCreatedWhen
          , ItemModifiedBy
          , ItemModifiedWhen
          , IsProcessedForHa
          , TXTKEY1
          , TXTVAL1
          , TXTKEY2
          , TXTVAL2
          , TXTKEY3
          , TXTVAL3
          , ItemOrder
          , ItemGuid
          , UserGuid
          , MPI
          , ClientCode
          , SiteGUID
          , AccountID
          , AccountCD
          , IsAvailable
          , IsCustom
          , UniqueName
          , ColDesc
          , VendorID
          , VendorName
          , CT_ItemID
          , CT_ChangeVersion
          , CMS_Operation) 
            SELECT
            T1.TrackerNameAggregateTable
          , T1.ItemID
          , T1.EventDate
          , T1.IsProfessionallyCollected
          , T1.TrackerCollectionSourceID
          , T1.Notes
          , T1.UserID
          , T1.CollectionSourceName_Internal
          , T1.CollectionSourceName_External
          , T1.EventName
          , T1.UOM
          , T1.KEY1
          , T1.VAL1
          , T1.KEY2
          , T1.VAL2
          , T1.KEY3
          , T1.VAL3
          , T1.KEY4
          , T1.VAL4
          , T1.KEY5
          , T1.VAL5
          , T1.KEY6
          , T1.VAL6
          , T1.KEY7
          , T1.VAL7
          , T1.KEY8
          , T1.VAL8
          , T1.KEY9
          , T1.VAL9
          , T1.KEY10
          , T1.VAL10
          , T1.ItemCreatedBy
          , T1.ItemCreatedWhen
          , T1.ItemModifiedBy
          , T1.ItemModifiedWhen
          , T1.IsProcessedForHa
          , T1.TXTKEY1
          , T1.TXTVAL1
          , T1.TXTKEY2
          , T1.TXTVAL2
          , T1.TXTKEY3
          , T1.TXTVAL3
          , T1.ItemOrder
          , T1.ItemGuid
          , T1.UserGuid
          , T1.MPI
          , T1.ClientCode
          , T1.SiteGUID
          , T1.AccountID
          , T1.AccountCD
          , T1.IsAvailable
          , T1.IsCustom
          , T1.UniqueName
          , T1.ColDesc
          , T1.VendorID
          , T1.VendorName
          , T1.CT_ItemID
          , T1.CT_ChangeVersion
          , T1.CMS_Operation
              FROM
            DIM_TEMPTBL_Staging_EDW_Tracker_DATA AS T1
                LEFT JOIN DIM_EDW_Trackers AS T2
                    ON T1.TrackerNameAggregateTable = T2.TrackerNameAggregateTable
                   AND T1.ItemId = T2.ItemId

              WHERE
              T2.ItemID IS NULL;

            --Check to see if CURRENT records have differnet HASH codes and if so, update the staging table
            SET @iCnt = (SELECT COUNT (*) 
                           FROM
                         DIM_EDW_Trackers AS T2
                             JOIN DIM_TEMPTBL_Staging_EDW_Tracker_DATA AS T1
                                 ON T1.TrackerNameAggregateTable = T2.TrackerNameAggregateTable
                                AND T1.ItemId = T2.ItemId
                           WHERE
                           T1.CMS_Operation IS NOT NULL
                        );
            IF @TrackProgress = 1
                BEGIN
                    PRINT '#Records found to update: ' + CAST (@iCnt AS  nvarchar (50)) + '. Updating VersionTracking RowNbr: ' + CAST (@RowNbr AS nvarchar (5)) ;
                END;

            UPDATE CT_VersionTracking
                SET CNT_Update = @iCnt
              WHERE RowNbr = @RowNbr;

            UPDATE T2
                SET
            T2.TrackerNameAggregateTable = T1.TrackerNameAggregateTable
          , T2.ItemID = T1.ItemID
          , T2.EventDate = T1.EventDate
          , T2.IsProfessionallyCollected = T1.IsProfessionallyCollected
          , T2.TrackerCollectionSourceID = T1.TrackerCollectionSourceID
          , T2.Notes = T1.Notes
          , T2.UserID = T1.UserID
          , T2.CollectionSourceName_Internal = T1.CollectionSourceName_Internal
          , T2.CollectionSourceName_External = T1.CollectionSourceName_External
          , T2.EventName = T1.EventName
          , T2.UOM = T1.UOM
          , T2.KEY1 = T1.KEY1
          , T2.VAL1 = T1.VAL1
          , T2.KEY2 = T1.KEY2
          , T2.VAL2 = T1.VAL2
          , T2.KEY3 = T1.KEY3
          , T2.VAL3 = T1.VAL3
          , T2.KEY4 = T1.KEY4
          , T2.VAL4 = T1.VAL4
          , T2.KEY5 = T1.KEY5
          , T2.VAL5 = T1.VAL5
          , T2.KEY6 = T1.KEY6
          , T2.VAL6 = T1.VAL6
          , T2.KEY7 = T1.KEY7
          , T2.VAL7 = T1.VAL7
          , T2.KEY8 = T1.KEY8
          , T2.VAL8 = T1.VAL8
          , T2.KEY9 = T1.KEY9
          , T2.VAL9 = T1.VAL9
          , T2.KEY10 = T1.KEY10
          , T2.VAL10 = T1.VAL10
          , T2.ItemCreatedBy = T1.ItemCreatedBy
          , T2.ItemCreatedWhen = T1.ItemCreatedWhen
          , T2.ItemModifiedBy = T1.ItemModifiedBy
          , T2.ItemModifiedWhen = T1.ItemModifiedWhen
          , T2.IsProcessedForHa = T1.IsProcessedForHa
          , T2.TXTKEY1 = T1.TXTKEY1
          , T2.TXTVAL1 = T1.TXTVAL1
          , T2.TXTKEY2 = T1.TXTKEY2
          , T2.TXTVAL2 = T1.TXTVAL2
          , T2.TXTKEY3 = T1.TXTKEY3
          , T2.TXTVAL3 = T1.TXTVAL3
          , T2.ItemOrder = T1.ItemOrder
          , T2.ItemGuid = T1.ItemGuid
          , T2.UserGuid = T1.UserGuid
          , T2.MPI = T1.MPI
          , T2.ClientCode = T1.ClientCode
          , T2.SiteGUID = T1.SiteGUID
          , T2.AccountID = T1.AccountID
          , T2.AccountCD = T1.AccountCD
          , T2.IsAvailable = T1.IsAvailable
          , T2.IsCustom = T1.IsCustom
          , T2.UniqueName = T1.UniqueName
          , T2.ColDesc = T1.ColDesc
          , T2.VendorID = T1.VendorID
          , T2.VendorName = T1.VendorName
          , T2.CT_ItemID = T1.CT_ItemID
          , T2.CT_ChangeVersion = T1.CT_ChangeVersion
          , T2.CMS_Operation = T1.CMS_Operation

              FROM DIM_EDW_Trackers AS T2
                       JOIN DIM_TEMPTBL_Staging_EDW_Tracker_DATA AS T1
                           ON T1.ItemID = T2.ItemID
                          AND T1.TrackerNameAggregateTable = T2.TrackerNameAggregateTable
                          AND T1.CMS_Operation IS NOT NULL;

            --Check to see if records exist in the Staging Table and not in the Temp Table and if so, update the DeleteFlg in the staging table
            SET @iCnt = (SELECT COUNT (*) 
                           FROM
                         DIM_TEMPTBL_Staging_EDW_Tracker_DATA AS ChangedData
                             INNER JOIN DIM_EDW_Trackers AS StagedData
                                 ON ChangedData.ItemID = StagedData. ItemID
                                AND ChangedData.TrackerNameAggregateTable = StagedData.TrackerNameAggregateTable
                                AND ChangedData.CMS_Operation = 'D') ;

            IF @TrackProgress = 1
                BEGIN
                    PRINT '#Records found to delete: ' + CAST (@iCnt AS nvarchar (50)) ;
                END;

            UPDATE CT_VersionTracking
                SET CNT_delete = @iCnt
              WHERE RowNbr = @RowNbr;

            UPDATE StagedData
                SET
            DeleteFlg = 1
              FROM DIM_TEMPTBL_Staging_EDW_Tracker_DATA AS ChangedData
                       INNER JOIN DIM_EDW_Trackers AS StagedData
                           ON ChangedData.ItemID = StagedData. ItemID
                          AND ChangedData.TrackerNameAggregateTable = StagedData.TrackerNameAggregateTable
                          AND ChangedData.CMS_Operation = 'D';

            SET @CNT_StagingTable = (SELECT COUNT (*) 
                                       FROM DIM_EDW_Trackers) ;
            UPDATE CT_VersionTracking
                SET CNT_PulledRecords = @iCnt
              WHERE RowNbr = @RowNbr;

            UPDATE CT_VersionTracking
                SET CNT_StagingTable = @CNT_StagingTable
              WHERE RowNbr = @RowNbr;

		  set @STime  = getdate();
		  exec proc_EDW_CT_ExecutionLog_Update @RecordID, 'proc_STAGING_EDW_CompositeTracker', @STime, @CNT_PulledRecords, 'U';


        END;
END;

GO
PRINT 'Created proc_STAGING_EDW_CompositeTracker';
GO 
