
GO
PRINT 'Executing proc_EDW_HA_Master.SQL';
GO
IF EXISTS (SELECT
                  name
                  FROM sys.procedures
                  WHERE name = 'proc_EDW_HA_Master') 
    BEGIN
        DROP PROCEDURE
             proc_EDW_HA_Master;
    END;

GO

--  exec proc_EDW_HA_Master
CREATE PROCEDURE proc_EDW_HA_Master
     @ReloadAll AS int = 0
AS
BEGIN

    declare @CT_NAME AS nvarchar ( 50) = 'proc_Staging_EDW_Data' ;
    declare @RecordID AS uniqueidentifier = NEWID () ;
    declare @NbrOfDetectedChanges as bigint = 0 ; 

    EXEC proc_EDW_Procedure_Performance_Monitor 'I' , @CT_NAME , '001 START proc_EDW_HA_Master';

    IF @ReloadAll = 1
        BEGIN
            
            EXEC proc_EDW_Procedure_Performance_Monitor 'I' , @CT_NAME , '002 BEGIN RELOAD ALL';

            --**************************************************************************************************
            PRINT 'START proc_EDW_Reload_EDW_HealthAssessment: ' + ' @@  ' + CONVERT (nvarchar (50) , GETDATE () , 13) ;
            EXEC @NbrOfDetectedChanges = proc_EDW_Reload_EDW_HealthAssessment ;
            PRINT 'ENDED proc_EDW_Reload_EDW_HealthAssessment: ' + ' @@  ' + CONVERT (nvarchar (50) , GETDATE () , 13) ;
            --**************************************************************************************************

            PRINT '00 Number of records loaded: ' + CAST (@NbrOfDetectedChanges AS nvarchar (50)) + ' @@  ' + CONVERT (nvarchar (50) , GETDATE () , 13) ;
            EXEC proc_EDW_Procedure_Performance_Monitor 'I' , @CT_NAME , '003 END RELOAD ALL';

            EXEC proc_EDW_Procedure_Performance_Monitor 'I' , @CT_NAME , '004 Begin Converting Time to Central';
            --**************************************************************************************************
            PRINT 'START Converting Time to Central' + ' @@  ' + CONVERT (nvarchar (50) , GETDATE () , 13) ;
            EXEC proc_EDW_ChangeGmtToCentralTime 'FACT_MART_EDW_HealthAssesment';
            PRINT 'END Converting Time to Central' + ' @@  ' + CONVERT (nvarchar (50) , GETDATE () , 13) ;
            --**************************************************************************************************
            EXEC proc_EDW_Procedure_Performance_Monitor 'I' , @CT_NAME , '005 Complete Converting Time to Central';

            EXEC proc_EDW_Procedure_Performance_Monitor 'I' , @CT_NAME , '006 Begin Cleaning Staging Data';
            PRINT 'START Cleaning Staging Data' + ' @@  ' + CONVERT (nvarchar (50) , GETDATE () , 13) ;
            EXEC proc_clean_EDW_Staging;
            PRINT 'END Cleaning Staging Data' + ' @@  ' + CONVERT (nvarchar (50) , GETDATE () , 13) ;
            EXEC proc_EDW_Procedure_Performance_Monitor 'I' , @CT_NAME , '007 END Cleaning Staging Data';

            PRINT 'Load Complete' + ' @@  ' + CONVERT (nvarchar (50) , GETDATE () , 13) ;
            EXEC proc_EDW_CT_ExecutionLog_Update_Counts @RecordID , 'T' , 0;

            RETURN;
        END;

    DECLARE @ST AS datetime = GETDATE () 
          , @CT AS datetime = GETDATE () 
          , @ET AS datetime = GETDATE () ;

    DECLARE @LatestDbVersionToPull AS bigint = 0;
    SET @LatestDbVersionToPull = CHANGE_TRACKING_CURRENT_VERSION () - 1;

    SET @CT = GETDATE () ;
    EXEC proc_trace 'START MASTER proc_EDW_HA_Master', @CT, NULL;

    --*********************************************************************
    DECLARE @TgtView AS nvarchar ( 100) = 'view_EDW_HealthAssesment';
    DECLARE @CTVersionToPullNow AS int = ( SELECT
                                                  MAX ( CurrentDbVersion) 
                                                  FROM CT_VersionTracking
                                                  WHERE
                                                  SVRname = @@ServerName
                                              AND DBName = DB_NAME () 
                                              AND TgtView = 'view_EDW_HealthAssesment');

    --*********************************************************************
    DECLARE @iChgTypes AS int = 0 ;
    EXEC @iChgTypes = proc_CkHaDataChanged NULL, @NbrOfDetectedChanges OUTPUT;
    PRINT 'iChgType is: ' + CAST (@iChgTypes AS nvarchar (50)) ;
    PRINT 'Total Number Of Changes to process is: ' + CAST (@NbrOfDetectedChanges AS nvarchar (50)) ;
    IF @iChgTypes = 0
        BEGIN
            PRINT 'NO CHANGES found.';
            RETURN 0;
        END;
    --*********************************************************************
    SET @CT = GETDATE () ;
    EXEC proc_trace 'START proc_EDW_UpdateDIMTables', @CT, NULL;
    EXEC proc_EDW_UpdateDIMTables @CTVersionToPullNow;
    SET @ET = GETDATE () ;
    EXEC proc_trace 'END proc_EDW_UpdateDIMTables', @CT, @ET;
    --*********************************************************************
    SET @CT = GETDATE () ;
    EXEC proc_trace 'START proc_Create_FACT_EDW_PkHashkey_TBL', @CT, NULL;
    EXEC proc_Create_FACT_EDW_PkHashkey_TBL ;
    SET @ET = GETDATE () ;
    EXEC proc_trace 'END proc_Create_FACT_EDW_PkHashkey_TBL', @CT, @ET;
    --*********************************************************************
/*-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------
if @iChgTypes = 
    0 - no changes 1 - updates only 2 - deletes only 3 - deletes and updates 4 - inserts only 5 - inserts and updates 6 - inserts and deletes 7 - inserts, updates, and deletes
*/
    IF @iChgTypes = 1
    OR @iChgTypes = 3
    OR @iChgTypes = 4
    OR @iChgTypes = 5
    OR @iChgTypes = 6
    OR @iChgTypes = 7
        BEGIN
            --*********************************************************************
            SET @CT = GETDATE () ;
            EXEC proc_trace 'START proc_EDW_Gen_Temp_PkHashKeys', @CT, NULL;
            EXEC proc_EDW_Gen_Temp_PkHashKeys ;
            SET @ET = GETDATE () ;
            EXEC proc_trace 'END proc_EDW_Gen_Temp_PkHashKeys', @CT, @ET;
        --*********************************************************************
        END;

    --************************************************
    --MAKE SURE THE STAGED HASH KEY Table exists
    EXEC proc_Create_FACT_EDW_PkHashkey_TBL ;
    --************************************************
    DECLARE @TotalAvailRecs AS bigint = 0;
    EXEC @TotalAvailRecs = proc_QuickRowCount 'FACT_MART_EDW_HealthAssesment';

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
           @LatestDbVersionToPull , @NbrOfDetectedChanges , @ST , GETDATE () , NULL ,
           NULL, NULL, @TotalAvailRecs , @NbrOfDetectedChanges) ;
    --************************************************

    DECLARE @DBNAME AS nvarchar (100) = DB_NAME () ;
    DECLARE @jName AS nvarchar (100) = '';

    SET @jname = 'job_EDW_CT_HA_MarkDeletedRecords_' + @DBNAME;
    EXEC msdb.dbo.sp_start_job @jname;

    SET @jname = 'job_EDW_CT_HA_MarkUpdatedRecords_' + @DBNAME;
    EXEC msdb.dbo.sp_start_job @jname;

    SET @jname = 'job_EDW_CT_HA_MarkNewRecords_' + @DBNAME;
    EXEC msdb.dbo.sp_start_job @jname;

    SET @ET = GETDATE () ;
    EXEC proc_trace 'END MASTER proc_EDW_HA_Master', @CT, @ET;

--*************************************************************************************
 EXEC proc_EDW_CT_ExecutionLog_Update_Counts @RecordID , 'T' , 0;
--*************************************************************************************

END;

GO
PRINT 'Executed proc_EDW_HA_Master.SQL';
GO
