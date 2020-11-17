

/*---------------------------------------
Developer  : W. Dale Miller
05.28.2015 : WDM - completed unit testing
*/

GO
PRINT 'FROM proc_EDW_BioMetrics.SQL';
PRINT 'Creating proc_EDW_BioMetrics';
GO
IF EXISTS ( SELECT
                   name
            FROM sys.procedures
            WHERE
                   name = 'proc_EDW_BioMetrics') 
    BEGIN
        PRINT 'Replacing proc_EDW_BioMetrics proc';
        DROP PROCEDURE
             proc_EDW_BioMetrics;
    END;
GO

/*---------------------------------------------------------------------------
--------------------------------------------------
****************************************************

Use KenticoCMS_Datamart_2
select * from information_schema.columns where table_name like '%BioMetrics%' 
select * from KenticoCMS_2.information_schema.columns where table_name like '%BioMetrics%' 
select count(*) from KenticoCMS_2.dbo.view_EDW_BioMetrics

quickcount DIM_EDW_BioMetrics;
exec proc_EDW_BioMetrics 1,1,0
exec proc_EDW_BioMetrics 1,1,1
exec proc_EDW_BioMetrics 1,0,1

exec proc_EDW_BioMetrics 0,1,0
exec proc_EDW_BioMetrics 0,1,1
exec proc_EDW_BioMetrics 0,0,1

--1201906 / 1199488 / 2418
select count(*) from DIM_EDW_BioMetrics 
    where DeletedFlg is null
****************************************************
*/

CREATE PROCEDURE proc_EDW_BioMetrics
       @Reloadall INT = 0
     , @TrackProgress INT = 0
     , @KeepData AS BIT = 0
AS
BEGIN

    --declare @Reloadall int = 0 ;
    --declare @TrackProgress int = 0 ;
    --declare @KeepData AS bit = 0 ;

    SET NOCOUNT ON;

    DECLARE
           @iTotal AS BIGINT = 0;

    EXEC @iTotal = proc_QuickRowCount 'DIM_EDW_BioMetrics';

    IF @iTotal <= 1
        BEGIN
            SET @Reloadall = 1;
        END;

    DECLARE
           @Synchronization_Version BIGINT = 0
         , @CurrentDbVersion AS INT = CHANGE_TRACKING_CURRENT_VERSION () 
         , @STime AS DATETIME
         , @TgtView AS NVARCHAR ( 100) = 'view_EDW_BioMetrics_CT'
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
         , @VersionNBR INT = 0
         , @LoadStartTime AS DATETIME = GETDATE () ;

    SET @SVRName = ( SELECT
                            @@SERVERNAME) ;
    SET @STime = GETDATE () ;

    DECLARE
           @Mins AS DECIMAL ( 10 , 2) ;
    DECLARE
           @RecordID AS UNIQUEIDENTIFIER = NEWID () ;

    DECLARE
           @startdate DATETIME2 = GETDATE () 
         , @HRPART AS DECIMAL ( 10 , 2) 
         , @MINPART AS DECIMAL ( 10 , 2) 
         , @SECPART AS DECIMAL ( 10 , 2) 
         , @TOTSECS AS DECIMAL ( 10 , 2) = 0
         , @proc_RowGuid AS UNIQUEIDENTIFIER = NEWID () 
         , @CALLING_PROC AS NVARCHAR ( 100) = 'proc_EDW_BioMetrics'
         , @PROC_LOCATION AS NVARCHAR ( 100) = ''
         , @proc_starttime AS DATETIME = GETDATE () 
         , @proc_endtime AS DATETIME = NULL
         , @proc_elapsedsecs AS BIGINT = 0
         , @proc_RowsProcessed AS BIGINT = 0;

    EXEC proc_EDW_CT_ExecutionLog_Update @RecordID , 'proc_EDW_BioMetrics' , @STime , 0 , 'I';
    IF @Reloadall = 1
        BEGIN
            IF EXISTS ( SELECT
                               NAME
                        FROM sys.tables
                        WHERE
                               name = 'DIM_EDW_BioMetrics') 
                BEGIN
                    IF
                           @TrackProgress = 1
                        BEGIN
                            PRINT 'Dropping DIM_EDW_BioMetrics for FULL reload.';
                        END;

                    --*******************************	 
                    --** DROP THE TABLE AND RECREATE
                    --*******************************
                    DROP TABLE
                         DIM_EDW_BioMetrics;
                END;
            ELSE
                BEGIN
                    IF
                           @TrackProgress = 1
                        BEGIN
                            PRINT 'Reloading DIM_EDW_BioMetrics.';
                        END;
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
                                  DIM_EDW_BioMetrics
                    FROM view_EDW_BioMetrics_CT;

                    SET @proc_RowsProcessed = @@rowcount;
                    EXEC proc_EDW_CT_ExecutionLog_Update_Counts @RecordID , 'I' , @proc_RowsProcessed;

                    --*************************************************************************
                    EXEC proc_Add_EDW_CT_StdCols 'DIM_EDW_BioMetrics';
                    --*************************************************************************

                    IF
                           @TrackProgress = 1
                        BEGIN
                            SET @iCnt = ( SELECT
                                                 COUNT ( *) 
                                          FROM DIM_EDW_BioMetrics) ;
                            PRINT DB_NAME () + ' - Completed FULL RELOAD at: ' + CAST ( GETDATE () AS NVARCHAR ( 50)) + ' , loaded ' + CAST ( @iCnt
                                  AS NVARCHAR ( 50)) + ' records.';
                        END;
                    SET @CNT_PulledRecords = ( SELECT
                                                      COUNT ( *) 
                                               FROM DIM_EDW_BioMetrics) ;
                    SET @CNT_StagingTable = @CNT_PulledRecords;
                    IF NOT EXISTS ( SELECT
                                           name
                                    FROM sys.indexes
                                    WHERE
                                           name = 'PI_EDW_BioMetrics_IDs') 
                        BEGIN
                            IF
                                   @TrackProgress = 1
                                BEGIN
                                    PRINT 'Adding INDEX PI_EDW_BioMetrics_IDs at: ' + CAST ( GETDATE () AS NVARCHAR ( 50)) ;
                                END;
                            CREATE CLUSTERED INDEX PI_EDW_BioMetrics_IDs ON dbo.DIM_EDW_BioMetrics ( UserID , UserGUID , SiteID ,
                            SiteGUID , itemid , TBL) WITH ( PAD_INDEX = OFF , STATISTICS_NORECOMPUTE = OFF , SORT_IN_TEMPDB = OFF ,
                            DROP_EXISTING = OFF , ONLINE = OFF ,
                            ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ;
                        END;
                    SET @ExtractionDate = GETDATE () ;
                    SET @ExtractedVersion = -1;
                    SET @ExtractedRowCnt = ( SELECT
                                                    COUNT ( *) 
                                             FROM DIM_EDW_BioMetrics) ;

                    --SET @TgtView = 'view_EDW_BioMetrics';

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
                END;
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
            EXEC proc_EDW_CT_ExecutionLog_Update @RecordID , 'proc_EDW_BioMetrics' , @STime , @CNT_PulledRecords , 'U';

            SET @HRPART = DATEDIFF ( hour , @startdate , GETDATE ()) ;
            SET @MINPART = DATEDIFF ( minute , @startdate , GETDATE ()) % 60;
            SET @SECPART = DATEDIFF ( second , @startdate , GETDATE ()) % 60;
            SET @TOTSECS = DATEDIFF ( second , @LoadStartTime , GETDATE ()) ;

            SET @Mins = @TOTSECS / 60;
            PRINT 'TIME TOTAL time to PULL : ' + CAST ( @TOTSECS AS NVARCHAR ( 10)) + ' @ Seconds or ' + CAST ( @Mins AS NVARCHAR ( 50)) + ' minutes.';
            PRINT 'TOTAL RECORDS PULLED    : ' + CAST ( @proc_RowsProcessed AS NVARCHAR ( 20)) ;

            SET @PROC_LOCATION = 'End Of Run';

            EXEC proc_EDW_ChangeGmtToCentralTime 'DIM_EDW_BioMetrics';

            SET @proc_endtime = GETDATE () ;
            EXEC proc_CT_Performance_History @proc_RowGuid , @CALLING_PROC , @PROC_LOCATION , @proc_starttime , @proc_endtime , @proc_elapsedsecs , @proc_RowsProcessed;

            SET NOCOUNT OFF;

            RETURN;
        END;
    IF NOT EXISTS ( SELECT
                           NAME
                    FROM sys.tables
                    WHERE
                           name = 'DIM_EDW_BioMetrics') 
        BEGIN
            PRINT '****************************************************************************';
            PRINT 'FATAL ERROR: table DIM_EDW_BioMetrics was NOT found, aborting.';
            PRINT '****************************************************************************';
        END;
    ELSE
        BEGIN
            PRINT 'Trace 100';
            IF NOT EXISTS ( SELECT
                                   name
                            FROM sys.indexes
                            WHERE
                                   name = 'PI_EDW_BioMetrics_IDs') 
                BEGIN
                    PRINT 'Adding INDEX PI_EDW_BioMetrics_IDs';
                    CREATE CLUSTERED INDEX PI_EDW_BioMetrics_IDs ON dbo.DIM_EDW_BioMetrics ( UserID , UserGUID , SiteID , SiteGUID ,
                    itemid , TBL) WITH ( PAD_INDEX = OFF , STATISTICS_NORECOMPUTE = OFF , SORT_IN_TEMPDB = OFF , DROP_EXISTING = OFF , ONLINE = OFF ,
                    ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ;
                END;

            --The staging table exists, CHANGES will be determined and applied.

            IF EXISTS ( SELECT
                               name
                        FROM tempdb.dbo.sysobjects
                        WHERE
                               id = OBJECT_ID ( N'tempdb..##Temp_BioMetrics') 

            ) 
                BEGIN
                    PRINT 'Dropping ##Temp_BioMetrics';
                    DROP TABLE
                         ##Temp_BioMetrics;
                END;
            PRINT 'Trace 200';

            DECLARE
                   @iChanges AS INT = 0;

            EXEC @iChanges = proc_CkBioMetricChanges ;

            IF @iChanges = 0
                BEGIN
                    PRINT 'Trace 275;';
                    PRINT '----------------------------------------------';
                    PRINT 'NO UPDATES FOUND, ending.';

                    SET @STime = GETDATE () ;
                    EXEC proc_EDW_CT_ExecutionLog_Update @RecordID , 'proc_EDW_BioMetrics' , @STime , 0 , 'U';

                    SET @HRPART = DATEDIFF ( hour , @startdate , GETDATE ()) ;
                    SET @MINPART = DATEDIFF ( minute , @startdate , GETDATE ()) % 60;
                    SET @SECPART = DATEDIFF ( second , @startdate , GETDATE ()) % 60;
                    SET @TOTSECS = DATEDIFF ( second , @LoadStartTime , GETDATE ()) ;

                    SET @Mins = @TOTSECS / 60;
                    PRINT 'TIME TOTAL time to PULL : ' + CAST ( @TOTSECS AS NVARCHAR ( 10)) + ' @ Seconds or ' + CAST ( @Mins AS NVARCHAR ( 50)) + ' minutes.';

                    PRINT 'TOTAL RECORDS PULLED: ' + CAST ( @proc_RowsProcessed AS NVARCHAR ( 20)) ;

                    SET @PROC_LOCATION = 'End Of Run - No changes found';

                    EXEC proc_EDW_ChangeGmtToCentralTime 'DIM_EDW_BioMetrics';
                    SET @proc_endtime = GETDATE () ;
                    EXEC proc_CT_Performance_History @proc_RowGuid , @CALLING_PROC , @PROC_LOCATION , @proc_starttime , @proc_endtime , @proc_elapsedsecs , @proc_RowsProcessed;

                    SET NOCOUNT OFF;
                    RETURN;
                END;
            PRINT 'Trace 300;';
            PRINT '@iChanges = ' + CAST (@iChanges AS NVARCHAR (50)) ;
            PRINT '-----------------------';

            DECLARE
                   @MySql AS NVARCHAR (2000) = '';

            IF @iChanges = 2
                BEGIN   --00:40:46
                    PRINT 'Trace 300A;';
                    PRINT 'DELETES found - processing all records';
                    PRINT 'Trace 310';
                    SET @MySql = ' SELECT * INTO ##Temp_BioMetrics FROM view_EDW_BioMetrics_CT; ';
                    EXEC (@MySql) ;
                    SET @proc_RowsProcessed = @@rowcount;
                --WHERE CT_ChangeType IS NOT NULL;
                END;

            IF @iChanges = 1
                BEGIN
                    --select * from ##Temp_BioMetrics
                    PRINT 'Trace 300B;';
                    PRINT 'Changes found with No deletes - processing only changed records';
                    SET @MySql = ' SELECT * INTO ##Temp_BioMetrics FROM view_EDW_BioMetrics_CT WHERE CT_ChangeType IS NOT NULL; ';
                    EXEC (@MySql) ;
                    SET @proc_RowsProcessed = @@rowcount;
                    PRINT '#Changes found: ' + CAST ( @proc_RowsProcessed AS NVARCHAR ( 50)) ;
                END;
            PRINT 'Trace 300C;';
            --*************************************************************************
            EXEC proc_Add_EDW_CT_StdCols '##Temp_BioMetrics';
            --*************************************************************************
            PRINT 'Trace 400';

            IF NOT EXISTS ( SELECT
                                   name
                            FROM sys.indexes
                            WHERE
                                   name = 'temp_PI_EDW_BioMetrics_IDs') 
                BEGIN
                    CREATE CLUSTERED INDEX temp_PI_EDW_BioMetrics_IDs ON dbo.##Temp_BioMetrics ( UserID , UserGUID , SiteID , SiteGUID ,
                    itemid , TBL) WITH ( PAD_INDEX = OFF , STATISTICS_NORECOMPUTE = OFF , SORT_IN_TEMPDB = OFF , DROP_EXISTING = OFF , ONLINE = OFF ,
                    ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ;
                END;
            PRINT 'Trace 500';
            IF @KeepData = 1
                BEGIN
                    PRINT '*** KEEPING TEMP DATA IN TABLE TEMP_EDW_BioMetrics_BACKUP_DATA';
                    IF EXISTS ( SELECT
                                       name
                                FROM sys.tables
                                WHERE
                                       name = 'TEMP_EDW_BioMetrics_BACKUP_DATA') 
                        BEGIN
                            DROP TABLE
                                 TEMP_EDW_BioMetrics_BACKUP_DATA;
                        END;
                    SELECT
                           * INTO
                                  TEMP_EDW_BioMetrics_BACKUP_DATA
                    FROM ##Temp_BioMetrics;
                    CREATE CLUSTERED INDEX temp_PI_TEMP_EDW_BioMetrics_BACKUP_DATA ON TEMP_EDW_BioMetrics_BACKUP_DATA ( UserID , UserGUID , SiteID ,
                    SiteGUID , itemid , TBL) WITH ( PAD_INDEX = OFF , STATISTICS_NORECOMPUTE = OFF , SORT_IN_TEMPDB = OFF , DROP_EXISTING = OFF ,
                    ONLINE = OFF ,
                    ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ;
                END;
            PRINT 'Trace 600';

            --**********************************************************************
            --	 Find any new records and insert them into the staging table.
            --**********************************************************************
            DECLARE
                   @iInserted AS INT = @@ROWCOUNT;
            EXEC @iInserted = proc_CT_BioMetrics_AddNewRecs ;
            SET @CNT_PulledRecords = @iInserted;
            PRINT 'NEW Records Inserted: ' + CAST ( @iInserted AS NVARCHAR ( 50)) ;
            EXEC proc_EDW_CT_ExecutionLog_Update_Counts @RecordID , 'I' , @iInserted;

            --**********************************************************************
            --Update records that have differnet HASH codes as they have changed.
            --**********************************************************************
            DECLARE
                   @iUpdates AS INT = 0;
            EXEC @iUpdates = proc_CT_BioMetrics_AddUpdatedRecs ;
            EXEC proc_EDW_CT_ExecutionLog_Update_Counts @RecordID , 'U' , @iUpdates;
            PRINT 'Records Updated: ' + CAST ( @iUpdates AS NVARCHAR ( 50)) ;

            --**********************************************************************
            --Update records that have been deleted.
            --**********************************************************************            
            DECLARE
                   @iDeleted AS INT = 0;
            IF @iChanges = 2
                BEGIN
                    PRINT '@iChanges indicates deteles are present, processing all deletes';
                    EXEC @iDeleted = proc_CT_BioMetrics_AddDeletedRecs	   ;
                END;
            EXEC proc_EDW_CT_ExecutionLog_Update_Counts @RecordID , 'D' , @iDeleted;
            PRINT 'Records Marked as Deleted: ' + CAST ( @iDeleted AS NVARCHAR ( 50)) ;

            SET @CNT_StagingTable = ( SELECT
                                             COUNT ( *) 
                                      FROM DIM_EDW_BioMetrics) ;
            UPDATE CT_VersionTracking
                SET
                    CNT_PulledRecords = @iCnt
            WHERE
                  RowNbr = @RowNbr;

            SET @CNT_PulledRecords = ( SELECT
                                              COUNT ( *) 
                                       FROM ##Temp_BioMetrics) ;
            UPDATE CT_VersionTracking
                SET
                    CNT_StagingTable = @CNT_StagingTable
            WHERE
                  RowNbr = @RowNbr;

            SET @STime = GETDATE () ;
            EXEC proc_EDW_CT_ExecutionLog_Update @RecordID , 'proc_EDW_BioMetrics' , @STime , @CNT_PulledRecords , 'U';

            SET @HRPART = DATEDIFF ( hour , @startdate , GETDATE ()) ;
            SET @MINPART = DATEDIFF ( minute , @startdate , GETDATE ()) % 60;
            SET @SECPART = DATEDIFF ( second , @startdate , GETDATE ()) % 60;
            SET @TOTSECS = DATEDIFF ( second , @LoadStartTime , GETDATE ()) ;

            SET @Mins = @TOTSECS / 60;
            PRINT 'TIME TOTAL time to PULL : ' + CAST ( @TOTSECS AS NVARCHAR ( 10)) + ' @ Seconds or ' + CAST ( @Mins AS NVARCHAR ( 50)) + ' minutes.';
            PRINT 'TOTAL RECORDS PULLED: ' + CAST ( @proc_RowsProcessed AS NVARCHAR ( 20)) ;

            SET @PROC_LOCATION = 'End Of Run';

            EXEC proc_EDW_ChangeGmtToCentralTime 'DIM_EDW_BioMetrics';
            SET @proc_endtime = GETDATE () ;
            EXEC proc_CT_Performance_History @proc_RowGuid , @CALLING_PROC , @PROC_LOCATION , @proc_starttime , @proc_endtime , @proc_elapsedsecs , @proc_RowsProcessed;

            SET NOCOUNT OFF;

        END;
END;
GO
PRINT 'Created proc_EDW_BioMetrics';
GO 
