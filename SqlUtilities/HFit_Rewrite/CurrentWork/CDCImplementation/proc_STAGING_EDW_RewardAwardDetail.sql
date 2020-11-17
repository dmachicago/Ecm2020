
/*---------------------------------------
***************************************
Developer  : W. Dale Miller
05.28.2015 : WDM - completed unit testing
***************************************
*/

/*---------------------------------------
***************************************
exec proc_EDW_RewardAwardDetail 0
exec proc_EDW_RewardAwardDetail 1
***************************************
*/

GO

PRINT 'FROM proc_EDW_RewardAwardDetail.SQL';

PRINT 'Creating proc_EDW_RewardAwardDetail';

GO

IF EXISTS ( SELECT
                   name
                   FROM sys.procedures
                   WHERE
                   name = 'proc_EDW_RewardAwardDetail') 

    BEGIN

        PRINT 'Replacing proc_EDW_RewardAwardDetail proc';

        DROP PROCEDURE
             proc_EDW_RewardAwardDetail;
    END;

GO

CREATE PROCEDURE proc_EDW_RewardAwardDetail
       @Reloadall int = 0
     , @TrackProgress int = 0
     , @KeepData AS bit = 0
AS
BEGIN

    SET NOCOUNT ON;

    DECLARE
    @Synchronization_Version bigint = 0
  , @CurrentDbVersion AS int
  , @STime AS datetime
  , @TgtView AS nvarchar ( 100) = 'view_EDW_RewardAwardDetail_CT'
  , @ExtractionDate AS datetime
  , @ExtractedVersion AS int
  , @ExtractedRowCnt AS int
  , @EndTime AS datetime
  , @CNT_PulledRecords AS int = 0
  , @iCnt AS int = 0
  , @RowNbr AS int = 0
  , @StartTime AS datetime = GETDATE () 
  , @SVRName AS nvarchar ( 100) 
  , @DBName AS nvarchar ( 100) = DB_NAME () 
  , @CNT_Insert AS int = 0
  , @CNT_Update AS int = 0
  , @CNT_Delete AS int = 0
  , @CNT_StagingTable int = 0
  , @VersionNBR int = 0;

    DECLARE
    @iTotal AS bigint = 0;
    EXEC @iTotal = proc_QuickRowCount 'DIM_EDW_RewardAwardDetail';

    IF @iTotal = 1

        BEGIN

            SET @Reloadall = 1;
        END;

    SET @SVRName = ( SELECT
                            @@SERVERNAME) ;

    SET @STime = GETDATE () ;

    DECLARE
    @RecordID AS uniqueidentifier = NEWID () ;
    EXEC proc_EDW_CT_ExecutionLog_Update @RecordID , 'proc_EDW_RewardAwardDetail' , @STime , 0 , 'I';

    IF @Reloadall = 1

        BEGIN

            IF EXISTS ( SELECT
                               NAME
                               FROM sys.tables
                               WHERE
                               name = 'DIM_EDW_RewardAwardDetail') 

                BEGIN

                    PRINT 'Dropping DIM_EDW_RewardAwardDetail for FULL reload.';

                    DROP TABLE
                         DIM_EDW_RewardAwardDetail;
                END;
            ELSE

                BEGIN

                    IF
                    @TrackProgress = 1

                        BEGIN

                            PRINT 'Reloading DIM_EDW_RewardAwardDetail.';
                        END;
                END;

            IF
            @TrackProgress = 1

                BEGIN

                    PRINT 'Standby, performing initial load of the HA definitions - this could take a couple of hours, Started at: ' + CAST ( GETDATE () AS nvarchar ( 50)) ;
                END;

            IF @Reloadall = 1

                BEGIN

                    PRINT 'RELOADING ALL EDW HA Data.';

                    SELECT
                           * INTO
                                  DIM_EDW_RewardAwardDetail
                           FROM view_EDW_RewardAwardDetail_CT;
                    EXEC proc_Add_EDW_CT_StdCols 'DIM_EDW_RewardAwardDetail';
                    EXEC proc_EDW_CT_ExecutionLog_Update_Counts @RecordID , 'I' , @@ROWCOUNT;

                    IF
                    @TrackProgress = 1

                        BEGIN

                            SET @iCnt = ( SELECT
                                                 COUNT ( *) 
                                                 FROM DIM_EDW_RewardAwardDetail) ;

                            PRINT DB_NAME () + ' - Completed FULL RELOAD at: ' + CAST ( GETDATE () AS nvarchar ( 50)) + ' , loaded ' + CAST ( @iCnt AS nvarchar ( 50)) + ' records.';
                        END;

                    SET @CNT_PulledRecords = ( SELECT
                                                      COUNT ( *) 
                                                      FROM DIM_EDW_RewardAwardDetail) ;

                    SET @CNT_StagingTable = @CNT_PulledRecords;

                    IF NOT EXISTS ( SELECT
                                           name
                                           FROM sys.indexes
                                           WHERE
                                           name = 'PI_EDW_RewardAwardDetail_IDs') 

                        BEGIN

                            IF
                            @TrackProgress = 1

                                BEGIN

                                    PRINT 'Adding INDEX PI_EDW_RewardAwardDetail_IDs at: ' + CAST ( GETDATE () AS nvarchar ( 50)) ;
                                END;

                            CREATE NONCLUSTERED INDEX PI_EDW_RewardAwardDetail_IDs ON dbo.DIM_EDW_RewardAwardDetail ( UserGUID
                            , SiteGUID
                            , HFitUserMpiNumber
                            , RewardLevelGUID
                            , AwardType
                            , AwardDisplayName
                            , RewardValue
                            , ThresholdNumber
                            , UserNotified
                            , IsFulfilled
                            , AccountID
                            , AccountCD) 
                            WITH ( PAD_INDEX = OFF , STATISTICS_NORECOMPUTE = OFF , SORT_IN_TEMPDB = OFF , DROP_EXISTING = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ;
                        END;

                    SET @ExtractionDate = GETDATE () ;

                    SET @ExtractedVersion = -1;

                    SET @ExtractedRowCnt = ( SELECT
                                                    COUNT ( *) 
                                                    FROM DIM_EDW_RewardAwardDetail) ;

                    --SET @TgtView = 'view_EDW_RewardAwardDetail';

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
                         , CNT_StagingTable
                    ) 
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

                            PRINT 'Completed , RELOAD at: ' + CAST ( GETDATE () AS nvarchar ( 50)) ;
                        END;
                END;

            -- SELECT * INTO [DIM_EDW_RewardAwardDetail] FROM [view_EDW_RewardAwardDetail_CT];

            IF
            @TrackProgress = 1

                BEGIN

                    PRINT 'Completed , reloading at: ' + CAST ( GETDATE () AS nvarchar ( 50)) ;
                END;

            IF
            @TrackProgress = 1

                BEGIN

                    PRINT
                    'Completed FULL RELOAD at: ' + CAST ( GETDATE () AS nvarchar ( 50)) ;
                END;

            SET @STime = GETDATE () ;
            EXEC proc_EDW_ChangeGmtToCentralTime 'DIM_EDW_RewardAwardDetail';
            EXEC proc_EDW_CT_ExecutionLog_Update @RecordID , 'proc_EDW_RewardAwardDetail' , @STime , @CNT_PulledRecords , 'U';

            RETURN;
        END;

    IF NOT EXISTS ( SELECT
                           NAME
                           FROM sys.tables
                           WHERE
                           name = 'DIM_EDW_RewardAwardDetail') 

        BEGIN

            PRINT '****************************************************************************';

            PRINT 'FATAL ERROR: table DIM_EDW_RewardAwardDetail was NOT found, aborting.';

            PRINT '****************************************************************************';
        END;
    ELSE

        BEGIN
            IF NOT EXISTS ( SELECT
                                   name
                                   FROM sys.indexes
                                   WHERE
                                   name = 'PI_EDW_RewardAwardDetail_IDs') 

                BEGIN

                    PRINT 'Adding INDEX PI_EDW_RewardAwardDetail_IDs';

                    CREATE CLUSTERED INDEX PI_EDW_RewardAwardDetail_IDs ON dbo.DIM_EDW_RewardAwardDetail (
                    UserGUID
                    , SiteGUID
                    , HFitUserMpiNumber
                    , RewardLevelGUID
                    , AwardType
                    , AwardDisplayName
                    , RewardValue
                    , ThresholdNumber
                    , UserNotified
                    , IsFulfilled
                    , AccountID
                    , AccountCD) 
                    WITH ( PAD_INDEX = OFF , STATISTICS_NORECOMPUTE = OFF , SORT_IN_TEMPDB = OFF , DROP_EXISTING = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ;
                END;

            --The staging table exists, CHANGES will be determined and applied.

            IF EXISTS ( SELECT
                               name
                               FROM tempdb.dbo.sysobjects
                               WHERE
                               id = OBJECT_ID ( N'tempdb..#TEMP_EDW_RewardAwardDetail_DATA')) 

                BEGIN

                    PRINT 'Dropping #TEMP_EDW_RewardAwardDetail_DATA';

                    DROP TABLE
                         #TEMP_EDW_RewardAwardDetail_DATA;
                END;

/*---------------------------------------------------------------------------
***************************************************************************
*****************************************************************************
***************************************************************************
*/

            IF EXISTS ( SELECT
                               name
                               FROM sys.tables
                               WHERE
                               name = '#TEMP_EDW_RewardAwardDetail_DATA') 

                BEGIN

                    DROP TABLE
                         #TEMP_EDW_RewardAwardDetail_DATA;
                END;

            SELECT
                   * INTO
                          #TEMP_EDW_RewardAwardDetail_DATA
                   FROM view_EDW_RewardAwardDetail_CT;

            --WHERE CHANGED_FLG IS NOT NULL;

            ALTER TABLE #TEMP_EDW_RewardAwardDetail_DATA
            ADD
                        LastModifiedDate datetime NULL;

            ALTER TABLE #TEMP_EDW_RewardAwardDetail_DATA
            ADD
                        RowNbr  int NULL;

            ALTER TABLE #TEMP_EDW_RewardAwardDetail_DATA
            ADD
                        DeletedFlg  bit NULL;

            ALTER TABLE #TEMP_EDW_RewardAwardDetail_DATA
            ADD
                        ConvertedToCentralTime bit NULL;

            ALTER TABLE #TEMP_EDW_RewardAwardDetail_DATA
            ADD
                        TimeZone nvarchar ( 10) NULL;

            CREATE CLUSTERED INDEX temp_PI_EDW_RewardAwardDetail_IDs ON dbo.#TEMP_EDW_RewardAwardDetail_DATA (
            UserGUID
            , SiteGUID
            , HFitUserMpiNumber
            , RewardLevelGUID
            , AwardType
            , AwardDisplayName
            , RewardValue
            , ThresholdNumber
            , UserNotified
            , IsFulfilled
            , AccountID
            , AccountCD) 
            WITH ( PAD_INDEX = OFF , STATISTICS_NORECOMPUTE = OFF , SORT_IN_TEMPDB = OFF , DROP_EXISTING = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ;

            IF @KeepData = 1

                BEGIN

                    PRINT 'KEEPING TEMP DATA IN TABLE TEMP_EDW_RewardAwardDetail_DATA';

                    IF EXISTS ( SELECT
                                       name
                                       FROM sys.tables
                                       WHERE
                                       name = 'TEMP_EDW_RewardAwardDetail_DATA') 

                        BEGIN

                            DROP TABLE
                                 TEMP_EDW_RewardAwardDetail_DATA;
                        END;

                    SELECT
                           * INTO
                                  TEMP_EDW_RewardAwardDetail_DATA
                           FROM #TEMP_EDW_RewardAwardDetail_DATA;

                    CREATE CLUSTERED INDEX temp_PI_EDW_RewardAwardDetail_IDs ON TEMP_EDW_RewardAwardDetail_DATA (
                    UserGUID
                    , SiteGUID
                    , HFitUserMpiNumber
                    , RewardLevelGUID
                    , AwardType
                    , AwardDisplayName
                    , RewardValue
                    , ThresholdNumber
                    , UserNotified
                    , IsFulfilled
                    , AccountID
                    , AccountCD) 
                    WITH ( PAD_INDEX = OFF , STATISTICS_NORECOMPUTE = OFF , SORT_IN_TEMPDB = OFF , DROP_EXISTING = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ;
                END;

            SET @CNT_PulledRecords = ( SELECT
                                              COUNT ( *) 
                                              FROM #TEMP_EDW_RewardAwardDetail_DATA) ;

/*------------------------------------------------------------------------------------------------------------------------------------------------------------------
            delete from DIM_EDW_RewardAwardDetail where Hashcode  = (select top 1 hashcode from #TEMP_EDW_RewardAwardDetail_DATA order by hashcode desc)
*/
            DECLARE
            @iIns AS int = 0;
            EXEC @iIns = proc_CT_RewardAwardDetail_AddNewRecs ;
            PRINT 'ROWS Inserted: ' + CAST ( @iIns AS nvarchar ( 50)) ;
            EXEC proc_EDW_CT_ExecutionLog_Update_Counts @RecordID , 'I' , @iIns;

/*-----------------------------------------------------------------------------------------------------------------------------------------------------------------
*****************************************************************************************************************************************************************
					   --declare oldhash varbinary(8000) = (select top 1 hashcode from #TEMP_EDW_RewardAwardDetail_DATA order by hashcode); 
					   --declare tgthash varbinary(8000) = (select top 1 hashcode from #TEMP_EDW_RewardAwardDetail_DATA order by hashcode desc);
					   update #TEMP_EDW_RewardAwardDetail_DATA set hashcode = (select top 1 hashcode from #TEMP_EDW_RewardAwardDetail_DATA order by hashcode desc)
					   where hashcode =  (select top 1 hashcode from #TEMP_EDW_RewardAwardDetail_DATA order by hashcode) ;

            --Check to see if CURRENT records have differnet HASH codes and if so, update the staging table
*****************************************************************************************************************************************************************
*/
exec @Icnt = proc_CT_RewardAwardDetail_AddUpdatedRecs ;

 

            DECLARE
            @iUpdt AS int = @@ROWCOUNT;

            PRINT 'UPDATE Count: ' + CAST ( @iUpdt  AS nvarchar ( 50)) ;
            EXEC proc_EDW_CT_ExecutionLog_Update_Counts @RecordID , 'U' , @@ROWCOUNT;

/*----------------------------------------------------------------------------------------------------------------------------------------------------------------
****************************************************************************************************************************************************************
************************************************************************************************
FIND DELETED ROWS
delete from #TEMP_EDW_RewardAwardDetail_DATA where hashcode in (select top 5 hashcode from #TEMP_EDW_RewardAwardDetail_DATA order by hashcode) ;
******************************************************************************************************************************************************************
****************************************************************************************************************************************************************
*/
            DECLARE
            @idel AS int = @@ROWCOUNT;
		  exec @idel = proc_CT_RewardAwardDetail_AddNewRecs ;

            PRINT 'DELETED Count: ' + CAST ( @idel AS nvarchar ( 50)) ;
            EXEC proc_EDW_CT_ExecutionLog_Update_Counts @RecordID , 'D' , @@ROWCOUNT;

            SET @CNT_StagingTable = ( SELECT
                                             COUNT ( *) 
                                             FROM DIM_EDW_RewardAwardDetail) ;

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
                                              FROM #TEMP_EDW_RewardAwardDetail_DATA) ;
            EXEC proc_EDW_ChangeGmtToCentralTime 'DIM_EDW_RewardAwardDetail';

            SET @STime = GETDATE () ;
            EXEC proc_EDW_CT_ExecutionLog_Update @RecordID , 'proc_EDW_RewardAwardDetail' , @STime , @CNT_PulledRecords , 'U';
        END;

    SET NOCOUNT OFF;
END;

GO

PRINT 'Created proc_EDW_RewardAwardDetail';

GO 
