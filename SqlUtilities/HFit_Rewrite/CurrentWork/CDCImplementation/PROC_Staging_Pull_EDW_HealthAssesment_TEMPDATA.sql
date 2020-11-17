
/*
73 Changes found
0 Inserts found
73 Updates found
0 Deletes found
**Notice: Changes found, NO DELETES found, processing only new HA inserts and updates.
Jun  8 2015  7:14PM
TEMP RECORDS RETURNED:252021
ENDTIME: 
Jun  8 2015  8:28PM
**********
@secs = 4428.000
@mins = 73.800
@@hrs = 1.230
***INFO: Number of records that have changes: 252021
TIME TO PULL DATA in minutes: 74.00 minutes.
TIME TO PULL DATA in hours: 1.00 hours.
 

--*********************************************************
3 Changes found
0 Inserts found
3 Updates found
0 Deletes found
**Notice: NO DELETES found, processing only HA inserts and updates.
Jun  5 2015  2:54PM
TEMP RECORDS RETURNED:252021
ENDTIME: 
Jun  5 2015  3:53PM
**********
@secs = 3539.000
@mins = 58.983
@@hrs = 0.983
***INFO: Number of records that have changes: 252021
TIME TO PULL DATA in minutes: 59.00 minutes.
TIME TO PULL DATA in hours: 1.00 hours.
 --**********************************************************
2 Changes found
0 Inserts found
2 Updates found
0 Deletes found
**Notice: NO DELETES found, processing only inserts and updates.
TIME TO BUILD TEMP TABLES in seconds: 4
***INFO: Number of records to evaluate for changes: 221
***INFO: Number of records removed that do not have changes: 221
***INFO: Number of records left to process: 0
Time REMOVE non-changed: 0
TIME TO PULL DATA in seconds: 4 @ 0.00 minutes.
TIME TO CONVERT HASH in seconds: 0 @ Minutes = 0.00
TIME TOTAL Elapsed Time in seconds: 8 @ Minutes = 0.00
** LOADING STAGING Data to table FACT_MART_EDW_HealthAssesment.
TIME TOTAL TO Load from @HARECS : 2 @ Minutes = 0.00
TOTAL RECORDS PULLED: 0
 

*/

GO

PRINT 'Creating procedure PROC_STAGING_Pull_EDW_HealthAssesment_TEMPDATA';
PRINT 'FROM PROC_STAGING_Pull_EDW_HealthAssesment_TEMPDATA.sql';

GO

/*    
    select * into TEMP_HA_DO_NOT_KEEP from TEMP_EDW_HealthAssessment_DATA
*/

IF EXISTS ( SELECT
                   name
              FROM sys.procedures
              WHERE name = 'PROC_STAGING_Pull_EDW_HealthAssesment_TEMPDATA' )

    BEGIN

        DROP PROCEDURE
             PROC_STAGING_Pull_EDW_HealthAssesment_TEMPDATA;
    END;

GO

CREATE PROCEDURE PROC_STAGING_Pull_EDW_HealthAssesment_TEMPDATA ( @ReloadAllData AS int = 0
                                                                , @StartID AS bigint = -1
                                                                , @EndID AS bigint = 0 )
AS
BEGIN

    --***********************************************************************
    --EXEC PROC_STAGING_Pull_EDW_HealthAssesment_TEMPDATA 1 ;
    --EXEC PROC_STAGING_Pull_EDW_HealthAssesment_TEMPDATA 0;
    --PullChangesOnly = 0; fills the TEMP table ONLY with data that has changed
    --PullChangesOnly = 1; fills the TEMP STAGING TABLE for FULL Reloads.
    --@StartID >= 0 and @EndID > 0 and PullChangesOnly = 0, then only changes 
    --		 between the Start and End ID will be pulled.
    --Select count(*) from TEMP_EDW_HealthAssessment_DATA
    --Select top 1000 * from TEMP_EDW_HealthAssessment_DATA
    --***********************************************************************
    --** CHANGES:
    --05.11.2015 - (WDM) Changed proc to FILL the TEMP table
    --***********************************************************************

    SET NOCOUNT ON;

    --declare @ReloadAllData as int  = 0 ;

    DECLARE
       @startdate datetime2 = GETDATE ( )
       ,@startPullDate datetime2 = GETDATE ( )
       ,@RecordsPulled AS int
       ,@HRPART AS decimal ( 10 , 2 )
       ,@MINPART AS decimal ( 10 , 2 )
       ,@SECPART AS decimal ( 10 , 2 )
       ,@TOTSECS AS decimal ( 10 , 2 ) = 0
       ,@proc_RowGuid AS uniqueidentifier = NEWID ( )
       ,@CALLING_PROC AS nvarchar ( 100 ) = 'PROC_STAGING_Pull_EDW_HealthAssesment_TEMPDATA'
       ,@PROC_LOCATION AS nvarchar ( 100 ) = ''
       ,@proc_starttime AS datetime = GETDATE ( )
       ,@proc_endtime AS datetime = NULL
       ,@proc_elapsedsecs AS bigint = 0
       ,@proc_RowsProcessed AS bigint = 0
       ,@MINS AS decimal ( 10 , 2 ) = 0;

    EXEC proc_EDW_Procedure_Performance_Monitor 'D' , @CALLING_PROC;
    EXEC proc_EDW_Procedure_Performance_Monitor 'I' , @CALLING_PROC , '001';

    --  exec proc_CT_Performance_History @proc_RowGuid, @CALLING_PROC, @PROC_LOCATION, @proc_starttime, @proc_endtime, @proc_elapsedsecs, @proc_RowsProcessed ;

    IF
           @ReloadAllData = 0
        OR @ReloadAllData IS NULL
        BEGIN
            SET @PROC_LOCATION = 'LOAD CHANGES ONLY';
        END;

    IF @ReloadAllData = 1
        BEGIN
            SET @PROC_LOCATION = 'FULL RELOAD';
            EXEC proc_EDW_Procedure_Performance_Monitor 'I' , @CALLING_PROC , 'START FULL RELOAD';
            --***************************************************
            EXEC @RecordsPulled = proc_Load_HA_CT_TempTable 2 , @StartID , @EndID;
            --***************************************************
            PRINT '***INFO: Number of records to evaluate: ' + CAST ( @RecordsPulled AS nvarchar ( 20 ));
            EXEC proc_EDW_Procedure_Performance_Monitor 'I' , @CALLING_PROC , 'FULL RELOAD';
            EXEC proc_EDW_Procedure_Performance_Monitor 'T' , @CALLING_PROC;
            PRINT '***MSG: ALL HA DATA RELOADED';
            RETURN @RecordsPulled;
        END;

    --********************************************************************************
    -- ** BEFORE WE DO ANYTHING, LET'S SEE IF THERE ARE CHANGES TO PROCESS
    --********************************************************************************
    -- 0 = no changes, 1 = changes found and no deletes, 2 = DELETES found


declare @iChgTypes as int = 0 ; 
declare @NbrOfDetectedChanges as bigint = 0 ; 
    EXEC @iChgTypes = proc_CkHaDataChanged NULL, @NbrOfDetectedChanges OUTPUT;
    PRINT 'iChgType is: ' + CAST (@iChgTypes AS nvarchar (50)) ;
    PRINT 'Total Number Of Changes to process is: ' + CAST (@NbrOfDetectedChanges AS nvarchar (50)) ;

    IF
    @iChgTypes = 0
        BEGIN
            PRINT '**NO CHANGES FOUND, RETURNING.';
            EXEC proc_EDW_Procedure_Performance_Monitor 'T' , @CALLING_PROC;
            RETURN 0;
        END;

    IF
           @ReloadAllData = 0
       AND @StartID >= 0
       AND @EndID > 0
        BEGIN
            EXEC proc_EDW_Procedure_Performance_Monitor 'I' , @CALLING_PROC , 'PULLING CHANGES BETWEEN IDs';
            PRINT '***INFO: PULLING CHANGES BETWEEN CHANGE TRACKING IDs.';
            --***************************************************
            EXEC @RecordsPulled = proc_Load_HA_CT_TempTable 3 , @StartID , @EndID;
            --***************************************************
            PRINT '***INFO: PULLING CHANGES BETWEEN CHANGE TRACKING IDs.';
            PRINT '***INFO: Number of records to evaluate: ' + CAST ( @RecordsPulled AS nvarchar ( 20 ));
            EXEC proc_EDW_Procedure_Performance_Monitor 'I' , @CALLING_PROC , 'FULL RELOAD';
            EXEC proc_EDW_Procedure_Performance_Monitor 'T' , @CALLING_PROC;
            PRINT '***MSG: ALL HA DATA RELOADED';
            RETURN @RecordsPulled;
        END;

    EXEC proc_EDW_Procedure_Performance_Monitor 'I' , @CALLING_PROC , '006 - Populate Table VAR';
    IF @iChgTypes = 2
        BEGIN
            PRINT '**Notice: DELETES found, processing ALL HA records.';
            SET @PROC_LOCATION = 'CHANGES WITH DELETES';

            --** Changes were found but no deletes, so remove NON-changed data
            EXEC @RecordsPulled = proc_Load_HA_CT_TempTable 1 , @StartID , @EndID;

            PRINT '***INFO: Number of records to evaluate: ' + CAST ( @RecordsPulled AS nvarchar ( 20 ));
            EXEC proc_EDW_Procedure_Performance_Monitor 'I' , @CALLING_PROC , '007 - DATA Extract DELETES found';
        END;
    IF @iChgTypes = 1
        BEGIN
            PRINT '**Notice: Changes found, NO DELETES found, processing only new HA inserts and updates.';
            SET @PROC_LOCATION = 'CHANGES ONLY No DELETES';

            DECLARE
               @START_CLEANUP_TIME AS datetime = GETDATE ( );

            --** Changes were found but no deletes
            EXEC @RecordsPulled = proc_Load_HA_CT_TempTable 0 , @StartID , @EndID;

            PRINT '***INFO: Number of records that have changes: ' + CAST ( @RecordsPulled AS nvarchar ( 20 ));
            EXEC proc_EDW_Procedure_Performance_Monitor 'I' , @CALLING_PROC , '007 - DATA Extract changes Only';
        END;
    EXEC proc_EDW_Procedure_Performance_Monitor 'I' , @CALLING_PROC , '007 - DATA PULL';

    SET @HRPART = DATEDIFF ( hour , @startPullDate , GETDATE ( ));
    SET @MINPART = DATEDIFF ( minute , @startPullDate , GETDATE ( ));
    SET @SECPART = DATEDIFF ( second , @startPullDate , GETDATE ( ));
    SET @TOTSECS = DATEDIFF ( second , @startPullDate , GETDATE ( ));
    SET @MINS = @TOTSECS / 60;

    PRINT 'TIME TO PULL DATA in minutes: ' + CAST ( @MINPART AS nvarchar( 10 )) + ' minutes.';
    PRINT 'TIME TO PULL DATA in hours: ' + CAST ( @HRPART AS nvarchar( 10 )) + ' hours.';

    EXEC proc_EDW_Procedure_Performance_Monitor 'T' , @CALLING_PROC;
    RETURN @RecordsPulled;
END;

GO

PRINT 'Created procedure PROC_STAGING_Pull_EDW_HealthAssesment_TEMPDATA';

GO
