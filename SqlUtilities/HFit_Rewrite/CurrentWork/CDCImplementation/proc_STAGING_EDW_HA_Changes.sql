
/*-----------------------------------------------------------------------------------------------
***********************************************************************************************
Developer  : W. Dale Miller
05.28.2015 : WDM - completed unit testing

exec proc_STAGING_EDW_HA_Changes 0   --Process Changed Data only
exec proc_STAGING_EDW_HA_Changes 1   --Reload ALL
exec proc_STAGING_EDW_HA_Changes 0, @PullLatestVersionOnly = 1

select * from TEMP_EDW_HealthAssessment_DATA
select  * from CT_VersionTracking ; 

select * from information_schema.columns where column_name = 'HAModuleScore'
SELECT top 100 * FROM [HFit_HealthAssesmentUserModule]

update HFit_HealthAssesmentUserModule set HAModuleScore = HAModuleScore + .03 where ItemID = 1526
update HFit_HealthAssesmentUserModule set HAModuleScore = HAModuleScore + .03 where ItemID = 1527

update HFit_HealthAssesmentUserModule set HAModuleScore = HAModuleScore - .03 where ItemID = 1526
update HFit_HealthAssesmentUserModule set HAModuleScore = HAModuleScore - .03 where ItemID = 1527

SELECT COUNT(*) FROM FACT_MART_EDW_HealthAssesment
SELECT COUNT(*) FROM [view_EDW_HealthAssesment_CT]
SELECT top 100 * FROM [view_EDW_HealthAssesment_CT]
SELECT TOP 100 * FROM [FACT_MART_EDW_HealthAssesment];
SELECT COUNT (*) FROM [FACT_MART_EDW_HealthAssesment]; 

select * from FACT_MART_EDW_HealthAssesment where Hashcode = '����f#��K��j92%�2�'
select count(*), HashCode
from FACT_MART_EDW_HealthAssesment
group by HashCode 
having Count(*) > 1
***********************************************************************************************
*/

/*---------------------------------------------------
-----------------------------------------------------
USES:
    PROCS:
    dbo.proc_EDW_Procedure_Performance_Monitor
    dbo.proc_EDW_ChangeGmtToCentralTime
    dbo.proc_CkHaDataChanged
    dbo.proc_CT_Performance_History
    dbo.proc_clean_EDW_Staging
    dbo.proc_EDW_PullHA_Temp_Data
    dbo.proc_trace
    dbo.proc_EDW_CT_ExecutionLog_Update_Counts
    dbo.proc_EDW_CT_ExecutionLog_Update
    dbo.proc_EDW_UpdateDIMTables
    dbo.proc_CT_HA_AddNewRecs
    dbo.proc_CT_HA_AddUpdatedRecs
    dbo.proc_CT_HA_AddDeletedRecs
    dbo.proc_EDW_Reload_EDW_HealthAssessment
    dbo.proc_QuickRowCount
    dbo.proc_EDW_Create_HFIT_LKP_EDW_ALLOWED_MPI
    
    TABLE:
    CT_VersionTracking
    EDW_Proc_Performance_Monitor

    JOBS:
    job_EDW_GetStagingData_HA_KenticoCMS_ProdXX
*/

GO
-- use KenticoCMS_Datamart_2
PRINT 'FROM proc_STAGING_EDW_HA_Changes.SQL';
PRINT 'Creating proc_STAGING_EDW_HA_Changes';

GO

IF EXISTS ( SELECT
                   name
                   FROM sys.procedures
                   WHERE
                   name = 'proc_STAGING_EDW_HA_Changes') 

    BEGIN
        PRINT 'Replacing proc_STAGING_EDW_HA_Changes proc';
        DROP PROCEDURE
             proc_STAGING_EDW_HA_Changes;
    END;

GO
-- exec proc_STAGING_EDW_HA_Changes
CREATE PROCEDURE proc_STAGING_EDW_HA_Changes
       @LoadType INT = 0
     , @TrackProgress AS BIT = 0
     , @CTVersionOverride AS INT = NULL
     , @PullLatestVersionOnly AS BIT = 0
AS
BEGIN

    SET NOCOUNT ON;

/*------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------
***************************************************************************************************
Developer		 : W. Dale Miller
@LoadType		 :	0 load only changes, 
				1 is reload the staging table with all data.
				2 is reload the staging table with all data.
@TrackProgress			 : 1 causes tracing data to be displayed, 0 skips the tracing display
@CTVersionOverride		 : NULL is no action, Any positive number will force the specified version 
					   and all above that to be pulled.
@PullLatestVersionOnly    : 0 pull all changes, 1 pull only data between the last and current CHANGE ID.
***************************************************************************************************
*/

    DECLARE
           @ActivateTestMode AS BIT = 0
         , @iTotal AS BIGINT = 0
         , @NbrOfDetectedChanges AS BIGINT = 0
         , @CT_NAME AS NVARCHAR ( 50) = 'proc_Staging_EDW_Data'
         , @CT AS DATETIME = GETDATE () 
         , @ET AS DATETIME = GETDATE () 
         , @STime AS DATETIME = GETDATE () 
         , @RecordID AS UNIQUEIDENTIFIER = NEWID () 
         , @PROC_LOCATION AS NVARCHAR ( 100) = ''
         , @iCnt AS BIGINT = 0
         , @proc_RowsProcessed AS BIGINT = 0
         , @proc_endtime AS DATETIME
         , @CT_DateTimeNow AS DATETIME
         , @TOTSECS AS BIGINT = 0
         , @RowNbr  AS BIGINT = 0
         , @CNT_StagingTable  AS BIGINT = 0
         , @MINS AS BIGINT = 0
         , @proc_elapsedsecs AS BIGINT = 0;

    DECLARE
           @ExtractionDate AS DATETIME = GETDATE () ;

    DECLARE
           @CTVersionToPullNow AS BIGINT = 0
         , @ExtractedVersion AS BIGINT = 0;

    DECLARE
           @TgtView AS NVARCHAR ( 100) = 'view_EDW_HealthAssesment';

    DECLARE
           @StartTime AS DATETIME = GETDATE () 
         , @EndTime AS DATETIME = GETDATE () ;

    DECLARE
           @SVRName AS NVARCHAR ( 100) = @@SERVERNAME
         , @DBName AS NVARCHAR ( 100) = DB_NAME () ;

    DECLARE
           @CNT_Insert AS BIGINT = 0
         , @CNT_Update  AS BIGINT = 0
         , @CNT_delete  AS BIGINT = 0;

    DECLARE
           @proc_RowGuid  AS UNIQUEIDENTIFIER = @RecordID;

    EXEC @iTotal = proc_QuickRowCount 'FACT_MART_EDW_HealthAssesment';

    IF @iTotal <= 1
        BEGIN
            PRINT 'NO RECORDS FOUND IN STAGING TABLE - Reloading all.' + ' @@  ' + CONVERT (NVARCHAR (50) , GETDATE () , 13) ;
            SET @LoadType = 1;
        END;

    IF @LoadType = NULL
        BEGIN
            SET @LoadType = 0;
        END;

    IF @LoadType = 1
        BEGIN
            EXEC proc_EDW_Procedure_Performance_Monitor 'I' , @CT_NAME , '001 RELOAD ALL';
            EXEC proc_EDW_Procedure_Performance_Monitor 'I' , @CT_NAME , '002 BEGIN RELOAD ALL';

            --**************************************************************************************************
            PRINT 'START proc_EDW_Reload_EDW_HealthAssessment: ' + ' @@  ' + CONVERT (NVARCHAR (50) , GETDATE () , 13) ;
            EXEC @NbrOfDetectedChanges = proc_EDW_Reload_EDW_HealthAssessment ;
            PRINT 'ENDED proc_EDW_Reload_EDW_HealthAssessment: ' + ' @@  ' + CONVERT (NVARCHAR (50) , GETDATE () , 13) ;
            --**************************************************************************************************

            PRINT '00 Number of records loaded: ' + CAST (@NbrOfDetectedChanges AS NVARCHAR (50)) + ' @@  ' + CONVERT (NVARCHAR (50) , GETDATE () , 13) ;
            EXEC proc_EDW_Procedure_Performance_Monitor 'I' , @CT_NAME , '003 END RELOAD ALL';

            EXEC proc_EDW_Procedure_Performance_Monitor 'I' , @CT_NAME , '004 Begin Converting Time to Central';
            --**************************************************************************************************
            PRINT 'START Converting Time to Central' + ' @@  ' + CONVERT (NVARCHAR (50) , GETDATE () , 13) ;
            EXEC proc_EDW_ChangeGmtToCentralTime 'FACT_MART_EDW_HealthAssesment';
            PRINT 'END Converting Time to Central' + ' @@  ' + CONVERT (NVARCHAR (50) , GETDATE () , 13) ;
            --**************************************************************************************************
            EXEC proc_EDW_Procedure_Performance_Monitor 'I' , @CT_NAME , '005 Complete Converting Time to Central';

            EXEC proc_EDW_Procedure_Performance_Monitor 'I' , @CT_NAME , '006 Begin Cleaning Staging Data';
            PRINT 'START Cleaning Staging Data' + ' @@  ' + CONVERT (NVARCHAR (50) , GETDATE () , 13) ;
            EXEC proc_clean_EDW_Staging;
            PRINT 'END Cleaning Staging Data' + ' @@  ' + CONVERT (NVARCHAR (50) , GETDATE () , 13) ;
            EXEC proc_EDW_Procedure_Performance_Monitor 'I' , @CT_NAME , '007 END Cleaning Staging Data';

            PRINT 'Load Complete' + ' @@  ' + CONVERT (NVARCHAR (50) , GETDATE () , 13) ;
            EXEC proc_EDW_CT_ExecutionLog_Update_Counts @RecordID , 'T' , 0;

            RETURN;
        END;

    --********************************************************************************************************
    SET @CT = GETDATE () ;
    EXEC proc_trace 'START proc_EDW_Create_HFIT_LKP_EDW_ALLOWED_MPI' , @CT , NULL;
    EXEC proc_EDW_Create_HFIT_LKP_EDW_ALLOWED_MPI ;
    SET @ET = GETDATE () ;
    EXEC proc_trace 'END proc_EDW_Create_HFIT_LKP_EDW_ALLOWED_MPI' , @CT , @ET;
    --********************************************************************************************************

    DECLARE
           @LatestDbVersionToPull AS BIGINT = 0;
    SET @LatestDbVersionToPull = CHANGE_TRACKING_CURRENT_VERSION () - 1;
    PRINT 'The Current Change Version ID is : ' + CAST (@LatestDbVersionToPull AS NVARCHAR (50)) + ' @@  ' + CONVERT (NVARCHAR (50) , GETDATE () , 13) ;

    IF
       @CTVersionOverride IS NOT NULL AND
           @CTVersionOverride >= 0
        BEGIN
            SET @CTVersionToPullNow = @CTVersionOverride;
        END;
    ELSE
        BEGIN
            SET @CTVersionToPullNow = ( SELECT
                                               MAX ( CurrentDbVersion) 
                                               FROM CT_VersionTracking
                                               WHERE
                                               SVRname = @@ServerName AND
                                               DBName = DB_NAME () AND
                                               TgtView = @TgtView) ;
        END;

    PRINT 'The Previous Change Version ID is ' + CAST ( @CTVersionToPullNow AS NVARCHAR (50)) ;

    DECLARE
           @iChgTypes AS INT = 0;

    --**************************************************************
    SET @CT = GETDATE () ;
    EXEC proc_trace 'START proc_CkHaDataChanged :' , @CT , NULL;
    EXEC @iChgTypes = proc_CkHaDataChanged @CTVersionToPullNow , @NbrOfDetectedChanges OUTPUT;
    PRINT 'iChgType is: ' + CAST (@iChgTypes AS NVARCHAR (50)) ;
    SET @ET = GETDATE () ;
    EXEC proc_trace 'END proc_CkHaDataChanged :' , @CT , @ET;
    --**************************************************************

    IF
           @CTVersionToPullNow < 0 OR
           @CTVersionToPullNow IS NULL
        BEGIN
            SET @CTVersionToPullNow = 0;
        END;

    IF
           @TrackProgress = 1
        BEGIN
            PRINT 'Pulling @CTVersionToPullNow ' + CAST ( @CTVersionToPullNow AS NVARCHAR (50)) + ' @@  ' + CONVERT (NVARCHAR (50) , GETDATE () , 13) ;
        END;

    IF
           @CTVersionToPullNow = @LatestDbVersionToPull AND
           @PullLatestVersionOnly = 1
        BEGIN

            PRINT 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX';
            PRINT 'NO Changes found in the db version of ' + CAST ( @LatestDbVersionToPull AS NVARCHAR ( 50)) + ' - RETURNING' + ' @@  ' + CONVERT (NVARCHAR (50) , GETDATE () , 13) ;
            PRINT 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX';

            SET @STime = GETDATE () ;

            EXEC proc_EDW_CT_ExecutionLog_Update_Counts @RecordID , 'I' , 0;
            EXEC proc_EDW_CT_ExecutionLog_Update_Counts @RecordID , 'T' , 0;
            EXEC proc_EDW_CT_ExecutionLog_Update @RecordID , @CT_NAME , @CT_DateTimeNow , 0 , 'D';

            SET @proc_RowsProcessed = 0;
            SET @PROC_LOCATION = 'End Of Run - NO CHANGES FOUND';
            SET @proc_endtime = GETDATE () ;
            EXEC proc_CT_Performance_History @proc_RowGuid , @CT_NAME , @PROC_LOCATION , @STime , @proc_endtime , @proc_elapsedsecs , @proc_RowsProcessed;
            EXEC proc_EDW_Procedure_Performance_Monitor 'I' , @CT_NAME , '008';
            EXEC proc_EDW_Procedure_Performance_Monitor 'T' , @CT_NAME , '009';

            RETURN;
        END;
    ELSE
        BEGIN
            PRINT 'PULLING Changes for versions between: ' + CAST ( @CTVersionToPullNow AS NVARCHAR ( 50)) + '  and ' + CAST ( @LatestDbVersionToPull
                  AS NVARCHAR ( 50)) + ' @@  ' + CONVERT (NVARCHAR (50) , GETDATE () , 13) ;
        END;

    IF @iChgTypes = 0
        BEGIN
            PRINT '**01 Notice: No changes found to process, done.' + ' @@  ' + CONVERT (NVARCHAR (50) , GETDATE () , 13) ;
            RETURN 0;
        END;

/*-----------------------------------
-------------------------------
    if @iChgTypes = 
    0 - no changes
    1 - updates only
    2 - deletes only
    3 - deletes and updates
    4 - inserts only
    5 - inserts and updates
    6 - inserts and deletes
    7 - inserts, updates, and deletes
*/
    -- EXEC proc_EDW_UpdateDIMTables null
    --*********************************************************************************************************
    PRINT '**Populating Staging Tables: ' + ' @@  ' + CONVERT (NVARCHAR (50) , GETDATE () , 13) ;
    EXEC proc_EDW_UpdateDIMTables @CTVersionToPullNow;
    PRINT '**ENDED Populating Staging Tables: ' + ' @@  ' + CONVERT (NVARCHAR (50) , GETDATE () , 13) ;
    --*********************************************************************************************************

    DECLARE
           @ReloadCnt AS BIGINT = 0;
    IF
       @iChgTypes > 0 AND
       @iChgTypes != 2
        BEGIN
            DECLARE
                   @st100 AS DATETIME = GETDATE () ;
            PRINT 'Loading temp table: version# ' + CAST (@CTVersionToPullNow AS NVARCHAR (50)) + ' @@  ' + CONVERT (NVARCHAR (50) , GETDATE () , 13) ;
            SET @CT = GETDATE () ;
            EXEC proc_trace 'START Loading temp table' , @CT , NULL;
            EXEC proc_trace 'START proc_EDW_PullHA_Temp_Data: ' , @st100 , NULL;
            EXEC proc_EDW_Procedure_Performance_Monitor 'I' , @CT_NAME , '010 pulling changes into Temp Table';
			--******************************************************************
            EXEC @ReloadCnt = proc_EDW_PullHA_Temp_Data @CTVersionToPullNow;
			--******************************************************************
            EXEC proc_EDW_Procedure_Performance_Monitor 'I' , @CT_NAME , '011 - ENDING data pull';
            PRINT 'ENDED loading temp table: ' + ' @@  ' + CONVERT (NVARCHAR (50) , GETDATE () , 13) ;
            SET @ET = GETDATE () ;
            EXEC proc_trace 'END Loading temp table' , @CT , @ET;
            DECLARE
                   @ed100 AS DATETIME = GETDATE () ;
            EXEC proc_trace 'ENDED loading temp table: ' , @st100 , @ed100;
        END;

    DECLARE
           @iInserts AS INT = 0
         , @iUpdates AS INT = 0
         , @iDeletes AS INT = 0;

    SET @CT = GETDATE () ;

    IF @iChgTypes = 1
        BEGIN
            SET @ET = GETDATE () ;
            EXEC proc_trace 'START Processing UPDATES ONLY' , @CT , NULL;
            EXEC proc_EDW_Procedure_Performance_Monitor 'I' , @CT_NAME , '200 Pulling UPDATES only';
			--******************************************************************
            EXEC @iUpdates = proc_CT_HA_AddUpdatedRecs;			
			--******************************************************************
            EXEC proc_EDW_Procedure_Performance_Monitor 'I' , @CT_NAME , '201 - ENDING data pull';
            SET @ET = GETDATE () ;
            EXEC proc_trace 'END Process' , @CT , @ET;
        END;
    IF @iChgTypes = 2
        BEGIN
            PRINT '**START Processing DELETES ONLY: ' + ' @@  ' + CONVERT (NVARCHAR (50) , GETDATE () , 13) ;
            EXEC proc_trace 'START Processing DELETES ONLY' , @CT , NULL;
            EXEC proc_EDW_Procedure_Performance_Monitor 'I' , @CT_NAME , '250 Pulling DELETES only';
			--******************************************************************
            EXEC @iDeletes = proc_CT_HA_AddDeletedRecs ;
			--******************************************************************
            --exec @iDeletes = proc_CT_MarkDeletedRecords ;
            EXEC proc_EDW_Procedure_Performance_Monitor 'I' , @CT_NAME , '251 - ENDING data pull';
            PRINT '** ENDED Processing DELETES ONLY: ' + ' @@  ' + CONVERT (NVARCHAR (50) , GETDATE () , 13) ;
            SET @ET = GETDATE () ;
            EXEC proc_trace 'END Process' , @CT , @ET;
        END;
    IF @iChgTypes = 3
        BEGIN
            PRINT '**START Processing Updates & DELETES ONLY: ' + ' @@  ' + CONVERT (NVARCHAR (50) , GETDATE () , 13) ;
            EXEC proc_trace 'START Processing Updates & DELETES ONLY' , @CT , NULL;
            EXEC proc_EDW_Procedure_Performance_Monitor 'I' , @CT_NAME , '300 Pulling DELETES and UPDATES';
			--******************************************************************
            EXEC @iUpdates = proc_CT_HA_AddUpdatedRecs;
            PRINT '**ENDED Step 1 - Start Step 2: ' + ' @@  ' + CONVERT (NVARCHAR (50) , GETDATE () , 13) ;
			--******************************************************************
            EXEC @iDeletes = proc_CT_HA_AddDeletedRecs ;
			--******************************************************************
            --exec @iDeletes = proc_CT_MarkDeletedRecords ;
            EXEC proc_EDW_Procedure_Performance_Monitor 'I' , @CT_NAME , '301 - ENDING data pull';
            PRINT '**ENDED Processing Updates & DELETES ONLY: ' + ' @@  ' + CONVERT (NVARCHAR (50) , GETDATE () , 13) ;
            SET @ET = GETDATE () ;
            EXEC proc_trace 'END Process' , @CT , @ET;
        END;
    IF @iChgTypes = 4
        BEGIN
            PRINT '**START Processing INSERTS ONLY: ' + ' @@  ' + CONVERT (NVARCHAR (50) , GETDATE () , 13) ;
            EXEC proc_trace 'START Processing INSERTS ONLY' , @CT , NULL;
            EXEC proc_EDW_Procedure_Performance_Monitor 'I' , @CT_NAME , '400 Pulling INSERTS ONLY';
			--******************************************************************
            EXEC @iInserts = proc_CT_HA_AddNewRecs ;
			--******************************************************************
            EXEC proc_EDW_Procedure_Performance_Monitor 'I' , @CT_NAME , '401 - ENDING data pull';
            PRINT '** ENDED Processing INSERTS ONLY: ' + ' @@  ' + CONVERT (NVARCHAR (50) , GETDATE () , 13) ;
            SET @ET = GETDATE () ;
            EXEC proc_trace 'END Process' , @CT , @ET;
        END;
    IF @iChgTypes = 5
        BEGIN
            PRINT '**START Processing Inserts and UPDATES ONLY: ' + ' @@  ' + CONVERT (NVARCHAR (50) , GETDATE () , 13) ;
            EXEC proc_trace 'START Processing Inserts and UPDATES' , @CT , NULL;
            EXEC proc_EDW_Procedure_Performance_Monitor 'I' , @CT_NAME , '500 Pulling INSERTS and UPDATES';
			--******************************************************************
            EXEC @iInserts = proc_CT_HA_AddNewRecs ;
            PRINT '**ENDED Step 1 - Start Step 2: ' + ' @@  ' + CONVERT (NVARCHAR (50) , GETDATE () , 13) ;
			--******************************************************************
            EXEC @iUpdates = proc_CT_HA_AddUpdatedRecs;
			--******************************************************************
            EXEC proc_EDW_Procedure_Performance_Monitor 'I' , @CT_NAME , '501 - ENDING data pull';
            PRINT '**ENDED Processing Inserts and Updates ONLY: ' + ' @@  ' + CONVERT (NVARCHAR (50) , GETDATE () , 13) ;
            SET @ET = GETDATE () ;
            EXEC proc_trace 'END Process' , @CT , @ET;
        END;
    IF @iChgTypes = 6
        BEGIN
            PRINT '**START Processing INSERTS and DELETES: ' + ' @@  ' + CONVERT (NVARCHAR (50) , GETDATE () , 13) ;
            EXEC proc_trace 'START Processing Inserts and DELETES' , @CT , NULL;
            EXEC proc_EDW_Procedure_Performance_Monitor 'I' , @CT_NAME , '600	     Pulling INSERTS and DELETES';
			--******************************************************************
            EXEC @iInserts = proc_CT_HA_AddNewRecs ;
            PRINT '**ENDED Step 1 Start Step 2: ' + ' @@  ' + CONVERT (NVARCHAR (50) , GETDATE () , 13) ;
			--******************************************************************
            EXEC @iDeletes = proc_CT_HA_AddDeletedRecs ;
			--******************************************************************
            --exec @iDeletes = proc_CT_MarkDeletedRecords ;
            EXEC proc_EDW_Procedure_Performance_Monitor 'I' , @CT_NAME , '601 - ENDING data pull';
            PRINT '**ENDED Processing INSERTS and DELETES: ' + ' @@  ' + CONVERT (NVARCHAR (50) , GETDATE () , 13) ;
            SET @ET = GETDATE () ;
            EXEC proc_trace 'END Process' , @CT , @ET;
        END;
    IF @iChgTypes = 7
        BEGIN
            PRINT '**Start Processing INSERTS/DELETES/UPDATES ONLY: ' + ' @@  ' + CONVERT (NVARCHAR (50) , GETDATE () , 13) ;
            EXEC proc_trace 'START Processing INSERTS/DELETES/UPDATES' , @CT , NULL;
            EXEC proc_EDW_Procedure_Performance_Monitor 'I' , @CT_NAME , '700	 Pulling INSERTS/DELETES/UPDATES';
			--******************************************************************
            EXEC @iInserts = proc_CT_HA_AddNewRecs ;
            PRINT '**ENDED Step 1 - Start Step 2: ' + ' @@  ' + CONVERT (NVARCHAR (50) , GETDATE () , 13) ;
			--******************************************************************
            EXEC @iUpdates = proc_CT_HA_AddUpdatedRecs;
			--******************************************************************
            PRINT '**ENDED Step 2 - Start Step 3: ' + ' @@  ' + CONVERT (NVARCHAR (50) , GETDATE () , 13) ;
            EXEC @iDeletes = proc_CT_HA_AddDeletedRecs ;
			--******************************************************************
            --exec @iDeletes = proc_CT_MarkDeletedRecords ;
            EXEC proc_EDW_Procedure_Performance_Monitor 'I' , @CT_NAME , '701 - ENDING data pull';
            PRINT '**ENDED Processing INSERTS/DELETES/UPDATES ONLY: ' + ' @@  ' + CONVERT (NVARCHAR (50) , GETDATE () , 13) ;
            SET @ET = GETDATE () ;
            EXEC proc_trace 'END Process' , @CT , @ET;
        END;

    DECLARE
           @TotalAvailRecs AS BIGINT = 0;
    EXEC @TotalAvailRecs = proc_QuickRowCount 'FACT_MART_EDW_HealthAssesment';

    IF @ReloadCnt > 0
        BEGIN
            SET @NbrOfDetectedChanges = @ReloadCnt;
        END;
    ELSE
        BEGIN
            SET @NbrOfDetectedChanges = @iInserts + @iUpdates + @iDeletes;
        END;

    INSERT INTO CT_VersionTracking (
           SVRName
         , DBName
         , TgtView
         , ExtractionDate
         , ExtractedVersion
         , CurrentDbVersion
         , ExtractedRowCnt
         , StartTime
         , EndTime
         , CNT_Insert
         , CNT_Update
         , CNT_Delete
         , CNT_StagingTable
         , CNT_PulledRecords) 
    VALUES
    (
    @@SERVERNAME , DB_NAME () , @TgtView , GETDATE () , @LatestDbVersionToPull ,
    @LatestDbVersionToPull , @NbrOfDetectedChanges , @StartTime , GETDATE () , @iInserts ,
    @iUpdates , @iDeletes , @TotalAvailRecs , @NbrOfDetectedChanges) ;

    --************************************************************************************************    
    SET @CT = GETDATE () ;
    EXEC proc_trace 'START Cleaning Staging Data' , @CT , NULL;
    EXEC proc_clean_EDW_Staging;
    SET @ET = GETDATE () ;
    EXEC proc_trace 'END Process' , @CT , @ET;
    --************************************************************************************************
    --************************************************************************************************
    SET @CT = GETDATE () ;
    EXEC proc_trace 'START Converting Time to Central' , @CT , NULL;
    EXEC proc_EDW_ChangeGmtToCentralTime 'FACT_MART_EDW_HealthAssesment';
    SET @ET = GETDATE () ;
    EXEC proc_trace 'END Process' , @CT , @ET;
    --************************************************************************************************

    EXEC proc_EDW_Procedure_Performance_Monitor 'I' , @CT_NAME , '800 - PROC FINISHED';
    EXEC proc_EDW_Procedure_Performance_Monitor 'T' , @CT_NAME , '801 - END OF RUN';

    PRINT '015 LOAD Complete: PERF Monitor Table - EDW_Proc_Performance_Monitor' + ' @@  ' + CONVERT (NVARCHAR (50) , GETDATE () , 13) ;
    SET @ET = GETDATE () ;
    EXEC proc_trace 'RUN COMPETE - TOTAL TIME: ' , @STime , @ET;

-- select * from EDW_Proc_Performance_Monitor where TraceName = 'proc_Staging_EDW_Data' order by RowNbr Desc
-- SELECT * FROM CT_VersionTracking
-- select * from EDW_Proc_Performance_Monitor where TraceName = 'proc_Staging_EDW_Data' order by RowNbr
END;

GO

PRINT 'Created proc_STAGING_EDW_HA_Changes';

GO 

