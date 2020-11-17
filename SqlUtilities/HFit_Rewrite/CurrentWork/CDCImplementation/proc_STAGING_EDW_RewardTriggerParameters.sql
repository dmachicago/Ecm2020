-- use KenticoCMS_Prod1

/*---------------------------------------
Developer  : W. Dale Miller
05.28.2015 : WDM - completed unit testing
*/

/*-----------------------------------------------------------------------------
exec proc_EDW_RewardTriggerParameters 0 ,1  --Process Changed Data only
exec proc_EDW_RewardTriggerParameters 1 ,1  --Reload ALL

select * from TEMP_EDW_RewardTriggerParameters_DATA
select  * from CT_VersionTracking ; 
select * from view_EDW_RewardTriggerParameters_CT
select * from [view_EDW_HealthAssessmentDefinition_Staged]

PULLING Changes for versions between: 42944  and 43281
PULLING Changes for versions between: 43284  and 43287
PULLING Changes for versions between: 43455  and 43468
PULLING Changes for versions between: 43625  and 43627
PULLING Changes for versions between: 43629  and 43632
PULLING Changes for versions between: 43635  and 43691

PULLING Changes for versions between: 11  and 14

SELECT
       COUNT (*) 
       FROM DIM_EDW_RewardTriggerParameters;

SELECT COUNT(*) FROM [view_EDW_RewardTriggerParameters_CT]	  --00:01:47
SELECT top 10 * FROM [view_EDW_RewardTriggerParameters_CT]
SELECT TOP 100 * FROM [DIM_EDW_RewardTriggerParameters];
SELECT COUNT (*) FROM [DIM_EDW_RewardTriggerParameters]; 

PERF Measurements
03.26.2015 : 4681580 rows - 01:26:36 run time / PROD 1 @ LAB - full reload
03.27.2015 : 4681580 rows - 01:01:20 run time / PROD 1 @ LAB - full reload
03.27.2015 : Prod2  @ LAB : (3711933 row(s) affected) : 01:56:01 - full reload
03.28.2015 : Prod3  @ LAB : (5697805 row(s) affected) : 05:45:57 - full reload
03.29.2015 : Prod2  @ LAB : (xx row(s) affected) : 01:56:01 - Changed Records

04.16.2015 : WDM - complted the SP and started testing.
*/

GO
PRINT 'FROM proc_EDW_RewardTriggerParameters.SQL';
PRINT 'Creating proc_EDW_RewardTriggerParameters';
GO
IF EXISTS ( SELECT
                   name
                   FROM sys.procedures
                   WHERE
                   name = 'proc_EDW_RewardTriggerParameters') 
    BEGIN
        PRINT 'Replacing proc_EDW_RewardTriggerParameters proc';
        DROP PROCEDURE
             proc_EDW_RewardTriggerParameters;
    END;
GO

CREATE PROCEDURE proc_EDW_RewardTriggerParameters
       @Reloadall int = 0
     , @TrackProgress int = 0
     , @KeepData AS bit = 0
AS
BEGIN

    SET NOCOUNT ON;

    DECLARE
    @iTotal AS bigint = 0;

    EXEC @iTotal = proc_QuickRowCount 'DIM_EDW_RewardTriggerParameters';

    IF @iTotal = 1
        BEGIN
            SET @Reloadall = 1;
        END;

    DECLARE
    @Synchronization_Version bigint = 0
  , @CurrentDbVersion AS int
  , @STime AS datetime
  , @TgtView AS nvarchar ( 100) = 'view_EDW_RewardTriggerParameters'
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
    @proc_RowGuid AS uniqueidentifier = NEWID () 
  , @CALLING_PROC AS nvarchar ( 100) = 'proc_EDW_RewardTriggerParameters'
  , @PROC_LOCATION AS nvarchar ( 100) = ''
  , @proc_starttime AS datetime = GETDATE () 
  , @proc_endtime AS datetime = NULL
  , @proc_elapsedsecs AS bigint = 0
  , @proc_RowsProcessed AS bigint = 0
  , @PulledCnt AS bigint;

    DECLARE
    @HRPART AS int
  , @MINPART AS int
  , @SECPART AS int
  , @TOTSECS AS int = 0;

    SET @SVRName = ( SELECT
                            @@SERVERNAME) ;

    SET @STime = GETDATE () ;

    EXEC proc_EDW_CT_ExecutionLog_Update @proc_RowGuid , 'proc_EDW_RewardTriggerParameters' , @STime , 0 , 'I';

    IF @Reloadall = 1
        BEGIN
            IF EXISTS ( SELECT
                               NAME
                               FROM sys.tables
                               WHERE
                               name = 'DIM_EDW_RewardTriggerParameters') 
                BEGIN
                    --*******************************	 
                    --** DROP THE TABLE AND RECREATE
                    --*******************************
                    PRINT 'Dropping DIM_EDW_RewardTriggerParameters for FULL reload.';
                    DROP TABLE
                         DIM_EDW_RewardTriggerParameters;
                END;
            ELSE
                BEGIN
                            PRINT 'Reloading DIM_EDW_RewardTriggerParameters.';                    
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
                                  DIM_EDW_RewardTriggerParameters
                           FROM view_EDW_RewardTriggerParameters_CT;
				SET @PulledCnt = @@ROWCOUNT;

                    EXEC proc_Add_EDW_CT_StdCols 'DIM_EDW_RewardTriggerParameters';
                    EXEC proc_EDW_CT_ExecutionLog_Update_Counts @proc_RowGuid , 'I' , @PulledCnt;
                    PRINT 'TOTAL RECORDS PULLED: ' + CAST ( @PulledCnt AS nvarchar ( 50)) ;

                    IF
                    @TrackProgress = 1
                        BEGIN
                            SET @iCnt = ( SELECT
                                                 COUNT ( *) 
                                                 FROM DIM_EDW_RewardTriggerParameters) ;
                            PRINT DB_NAME () + ' - Completed FULL RELOAD at: ' + CAST ( GETDATE () AS nvarchar ( 50)) + ' , loaded ' + CAST ( @iCnt AS nvarchar ( 50)) + ' records.';
                        END;

                    SET @CNT_PulledRecords = ( SELECT
                                                      COUNT ( *) 
                                                      FROM DIM_EDW_RewardTriggerParameters) ;
                    SET @CNT_StagingTable = @CNT_PulledRecords;
                    IF NOT EXISTS ( SELECT
                                           name
                                           FROM sys.indexes
                                           WHERE
                                           name = 'PI_EDW_RewardTriggerParameters_IDs') 
                        BEGIN
                            IF
                            @TrackProgress = 1
                                BEGIN
                                    PRINT 'Adding INDEX PI_EDW_RewardTriggerParameters_IDs at: ' + CAST ( GETDATE () AS nvarchar ( 50)) ;
                                END;
                            CREATE NONCLUSTERED INDEX PI_EDW_RewardTriggerParameters_IDs ON dbo.DIM_EDW_RewardTriggerParameters ( SiteGUID , RewardTriggerID , ParameterDisplayName , RewardTriggerParameterOperator , [Value] , AccountID , AccountCD , DocumentGuid , NodeGuid) 
                            WITH ( PAD_INDEX = OFF , STATISTICS_NORECOMPUTE = OFF , SORT_IN_TEMPDB = OFF , DROP_EXISTING = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ;
                        END;

                    SET @ExtractionDate = GETDATE () ;
                    SET @ExtractedVersion = -1;
                    SET @ExtractedRowCnt = ( SELECT
                                                    COUNT ( *) 
                                                    FROM DIM_EDW_RewardTriggerParameters) ;
                    --SET @TgtView = 'view_EDW_RewardTriggerParameters';
                    SET @EndTime = GETDATE () ;

                    IF @TrackProgress = 1
                        BEGIN
                            PRINT 'Completed , RELOAD at: ' + CAST ( GETDATE () AS nvarchar ( 50)) ;
                        END;

                END;
            -- SELECT * INTO [DIM_EDW_RewardTriggerParameters] FROM [view_EDW_RewardTriggerParameters_CT];
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
            EXEC proc_EDW_CT_ExecutionLog_Update @proc_RowGuid , 'proc_EDW_RewardTriggerParameters' , @STime , @PulledCnt , 'U';

            SET @HRPART = DATEDIFF ( hour , @proc_starttime , GETDATE ()) ;
            SET @MINPART = DATEDIFF ( minute , @proc_starttime , GETDATE ()) % 60;
            SET @SECPART = DATEDIFF ( second , @proc_starttime , GETDATE ()) % 60;
            SET @TOTSECS = DATEDIFF ( second , @proc_starttime , GETDATE ()) ;

            PRINT 'TIME TO EXECUTE: ' + CAST ( @TOTSECS AS nvarchar ( 10)) + ' Seconds';
            PRINT 'TOTAL RECORDS PULLED: ' + CAST ( @PulledCnt AS nvarchar ( 20)) ;

            SET @proc_RowsProcessed = @PulledCnt;
            SET @PROC_LOCATION = 'End Of Run';
            SET @proc_endtime = GETDATE () ;
            EXEC proc_CT_Performance_History @proc_RowGuid , @CALLING_PROC , @PROC_LOCATION , @proc_starttime , @proc_endtime , @proc_elapsedsecs , @proc_RowsProcessed;

            EXEC proc_EDW_ChangeGmtToCentralTime 'DIM_EDW_RewardTriggerParameters';

            SET NOCOUNT OFF;

            RETURN;
        END;

    IF NOT EXISTS ( SELECT
                           NAME
                           FROM sys.tables
                           WHERE
                           name = 'DIM_EDW_RewardTriggerParameters') 
        BEGIN
            PRINT '****************************************************************************';
            PRINT 'FATAL ERROR: table DIM_EDW_RewardTriggerParameters was NOT found, aborting.';
            PRINT '****************************************************************************';
        END;
    ELSE
        BEGIN

            IF NOT EXISTS ( SELECT
                                   name
                                   FROM sys.indexes
                                   WHERE
                                   name = 'PI_EDW_RewardTriggerParameters_IDs') 
                BEGIN

                    PRINT 'Adding INDEX PI_EDW_RewardTriggerParameters_IDs';

                    CREATE CLUSTERED INDEX PI_EDW_RewardTriggerParameters_IDs ON dbo.DIM_EDW_RewardTriggerParameters (
                    SiteGUID
                    , RewardTriggerID
                    , ParameterDisplayName
                    , RewardTriggerParameterOperator
                    , [Value]
                    , AccountID
                    , AccountCD
                    , DocumentGuid
                    , NodeGuid) 
                    WITH ( PAD_INDEX = OFF , STATISTICS_NORECOMPUTE = OFF , SORT_IN_TEMPDB = OFF , DROP_EXISTING = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ;
                END;

            --The staging table exists, CHANGES will be determined and applied.

            IF EXISTS ( SELECT
                               name
                               FROM tempdb.dbo.sysobjects
                               WHERE id = OBJECT_ID ( N'tempdb..##TEMP_RewardTriggerParameters')) 

                BEGIN
                    PRINT 'Dropping ##TEMP_RewardTriggerParameters';
                    DROP TABLE
                         ##TEMP_RewardTriggerParameters;
                END;

/*---------------------------------------------------------------------------
*****************************************************************************
*/

            SELECT
                   * INTO
                          ##TEMP_RewardTriggerParameters
                   FROM view_EDW_RewardTriggerParameters_CT;
            --WHERE CHANGED_FLG IS NOT NULL;

            SET @PulledCnt = @@ROWCOUNT;

            --select * from ##TEMP_RewardTriggerParameters
            --ALTER TABLE ##TEMP_RewardTriggerParameters add SVR nvarchar(100) not NULL default(@@SERVERNAME)
            --ALTER TABLE ##TEMP_RewardTriggerParameters add DBNAME nvarchar(100) not NULL default(DB_NAME())

            EXEC proc_Add_EDW_CT_StdCols '##TEMP_RewardTriggerParameters';

            CREATE CLUSTERED INDEX temp_PI_EDW_RewardTriggerParameters_IDs ON dbo.##TEMP_RewardTriggerParameters (
            SiteGUID
            , RewardTriggerID
            , ParameterDisplayName
            , RewardTriggerParameterOperator
            , [Value]
            , AccountID
            , AccountCD
            , DocumentGuid
            , NodeGuid) 
            WITH ( PAD_INDEX = OFF , STATISTICS_NORECOMPUTE = OFF , SORT_IN_TEMPDB = OFF , DROP_EXISTING = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ;

            IF @KeepData = 1
                BEGIN
                    PRINT 'KEEPING TEMP DATA IN TABLE TEMP_EDW_RewardTriggerParameters_DATA';
                    IF EXISTS ( SELECT
                                       name
                                       FROM sys.tables
                                       WHERE
                                       name = 'TEMP_EDW_RewardTriggerParameters_DATA') 
                        BEGIN
                            DROP TABLE
                                 TEMP_EDW_RewardTriggerParameters_DATA;
                        END;

                    SELECT
                           * INTO
                                  TEMP_EDW_RewardTriggerParameters_DATA
                           FROM view_EDW_RewardTriggerParameters_CT;

                    EXEC proc_Add_EDW_CT_StdCols 'TEMP_EDW_RewardTriggerParameters_DATA';

                    CREATE CLUSTERED INDEX temp_PI_EDW_RewardTriggerParameters_IDs ON TEMP_EDW_RewardTriggerParameters_DATA (
                    SiteGUID
                    , RewardTriggerID
                    , ParameterDisplayName
                    , RewardTriggerParameterOperator
                    , [Value]
                    , AccountID
                    , AccountCD
                    , DocumentGuid
                    , NodeGuid) 
                    WITH ( PAD_INDEX = OFF , STATISTICS_NORECOMPUTE = OFF , SORT_IN_TEMPDB = OFF , DROP_EXISTING = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ;

                END;

            SET @CNT_PulledRecords = ( SELECT
                                              COUNT ( *) 
                                              FROM ##TEMP_RewardTriggerParameters) ;

            --*******************************************************
            -- ADD NEW RECORDS
            --*******************************************************    
            DECLARE
            @iInserts AS int = 0;
            EXEC @iInserts = proc_CT_RewardTriggerParameters_AddNewRecs ;
            EXEC proc_EDW_CT_ExecutionLog_Update_Counts @proc_RowGuid , 'I' , @iInserts;
            PRINT 'TOTAL RECORDS INSERTED: ' + CAST ( @iInserts AS nvarchar ( 50)) ;

            --*******************************************************
            -- ADD UPDATED RECORDS
            --*******************************************************    	   
            DECLARE
            @iUpdates AS int = 0;
            EXEC @iUpdates = proc_CT_RewardTriggerParameters_AddUpdatedRecs ;
            EXEC proc_EDW_CT_ExecutionLog_Update_Counts @proc_RowGuid , 'U' , @iUpdates;
            PRINT 'TOTAL RECORDS UPDATED: ' + CAST ( @iUpdates AS nvarchar ( 50)) ;

            --*******************************************************
            -- FIND DELETED ROWS
            --*******************************************************
            DECLARE
            @iDeletes AS int = 0;
            EXEC @iDeletes = proc_CT_RewardTriggerParameters_AddDeletedRecs ;
            EXEC proc_EDW_CT_ExecutionLog_Update_Counts @proc_RowGuid , 'D' , @iDeletes;
            PRINT 'TOTAL RECORDS DELETED: ' + CAST ( @iDeletes AS nvarchar ( 50)) ;

            SET @CNT_PulledRecords = ( SELECT
                                              COUNT ( *) 
                                              FROM ##TEMP_RewardTriggerParameters) ;
            SET @STime = GETDATE () ;
            EXEC proc_EDW_CT_ExecutionLog_Update @proc_RowGuid , 'proc_EDW_RewardTriggerParameters' , @STime , @CNT_PulledRecords , 'U';

            SET @HRPART = DATEDIFF ( hour , @proc_starttime , GETDATE ()) ;
            SET @MINPART = DATEDIFF ( minute , @proc_starttime , GETDATE ()) % 60;
            SET @SECPART = DATEDIFF ( second , @proc_starttime , GETDATE ()) % 60;
            SET @TOTSECS = DATEDIFF ( second , @proc_starttime , GETDATE ()) ;

            PRINT 'TIME TO EXECUTE: ' + CAST ( @TOTSECS AS nvarchar ( 10)) ;
            PRINT 'TOTAL RECORDS ANALYZED: ' + CAST ( @PulledCnt AS nvarchar ( 20)) ;

            SET @proc_RowsProcessed = @PulledCnt;
            SET @PROC_LOCATION = 'End Of Run';
            SET @proc_endtime = GETDATE () ;
            EXEC proc_CT_Performance_History @proc_RowGuid , @CALLING_PROC , @PROC_LOCATION , @proc_starttime , @proc_endtime , @proc_elapsedsecs , @proc_RowsProcessed;

            EXEC proc_EDW_ChangeGmtToCentralTime 'DIM_EDW_RewardTriggerParameters';

            SET NOCOUNT OFF;

        END;
END;

GO
PRINT 'Created proc_EDW_RewardTriggerParameters';
GO 
