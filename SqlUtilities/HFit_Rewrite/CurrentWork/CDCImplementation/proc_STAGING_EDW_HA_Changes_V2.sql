
GO
-- EXEC proc_STAGING_EDW_HA_Changes_V2
PRINT 'FROM proc_STAGING_EDW_HA_Changes_V2.SQL';
PRINT 'Creating proc_STAGING_EDW_HA_Changes_V2';

GO

IF EXISTS ( SELECT
                   name
                   FROM sys.procedures
                   WHERE name = 'proc_STAGING_EDW_HA_Changes_V2') 

    BEGIN
        PRINT 'Replacing proc_STAGING_EDW_HA_Changes_V2 proc';
        DROP PROCEDURE
             proc_STAGING_EDW_HA_Changes_V2;
    END;

GO

--select top 100 * from BASE_HFIT_HEALTHASSESMENTUSERQUESTION
--update BASE_HFIT_HEALTHASSESMENTUSERQUESTION set CodeNAme = 'height' where ItemID = 570

CREATE PROCEDURE proc_STAGING_EDW_HA_Changes_V2
     @LoadType int = 0
AS
BEGIN

    SET NOCOUNT ON;

/*-------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------
***************************************************************************************************
Developer		 :	W. Dale Miller
Date			 :	07.26.2015
@LoadType		 :	0 load only changes, 
				1 reload the staging table with all current data.

Interfaces:
	   dbo.proc_EDW_CT_ExecutionLog_Update_Counts
	   dbo.proc_EDW_CT_ExecutionLog_Update
	   dbo.proc_EDW_UpdateDIMTables
	   dbo.proc_Apply_EDW_HA_Updates_ToStaging_Table
	   dbo.PROC_CREATE_FACT_Tables
	   dbo.proc_QuickRowCount
	   dbo.proc_clean_EDW_Staging
	   dbo.proc_EDW_Procedure_Performance_Monitor
	   dbo.proc_EDW_ChangeGmtToCentralTime
	   dbo.proc_CkHaDataChanged
	   dbo.proc_CT_Performance_History
	   dbo.isJobRunning
***************************************************************************************************
*/

    DECLARE
	   @iTotal AS bigint = 0
	 , @CT_NAME AS nvarchar ( 50) = 'proc_Staging_EDW_Data'
	 , @STime AS datetime = GETDATE () 
	 , @RecordID AS uniqueidentifier = NEWID () 
	 , @PROC_LOCATION AS nvarchar ( 100) = ''
	 , @iCnt AS bigint = 0
	 , @proc_RowsProcessed AS bigint = 0
	 , @proc_endtime AS datetime
	 , @CT_DateTimeNow AS datetime
	 , @TOTSECS AS bigint = 0
	 , @RowNbr  AS bigint = 0
	 , @CNT_StagingTable  AS bigint = 0
	 , @MINS AS bigint = 0
	 , @proc_elapsedsecs AS bigint = 0;

    DECLARE @JobName AS nvarchar (100) = '';
    SET @JobName = 'job_EDW_GetFACTData_HA_' + DB_NAME () ;
    DECLARE @iRunning AS int = 0;
    EXEC @iRunning = isJobRunning @JobName;
    IF @iRunning = 1
        BEGIN
            PRINT 'CANNOT RUN AT THIS TIME, JOB ,' + @JobName + ', IS CURRENTLY EXECUTING...';
            RETURN;
        END;

    DECLARE
    @TgtView AS nvarchar ( 100) = 'view_EDW_HealthAssesment';

    DECLARE
    @proc_RowGuid  AS uniqueidentifier = @RecordID;

    DECLARE
    @proc_starttime AS datetime = @STime;

    EXEC @iTotal = proc_QuickRowCount 'FACT_MART_EDW_HealthAssesment';

    IF @iTotal <= 1
        BEGIN
            PRINT 'NO RECORDS FOUND IN STAGING TABLE - Reloading all.' + ' @@  ' + CONVERT (nvarchar (50) , GETDATE () , 13) ;
            SET @LoadType = 1;
        END;

declare @iChgTypes as int = 0 ; 
declare @NbrOfDetectedChanges as bigint = 0 ; 
    EXEC @iChgTypes = proc_CkHaDataChanged NULL, @NbrOfDetectedChanges OUTPUT;
    PRINT 'iChgType is: ' + CAST (@iChgTypes AS nvarchar (50)) ;
    PRINT 'Total Number Of Changes to process is: ' + CAST (@NbrOfDetectedChanges AS nvarchar (50)) ;

    IF @iChgTypes != 0
        BEGIN
            EXEC proc_EDW_UpdateDIMTables ;
        END;

    IF @LoadType = NULL
        BEGIN
            SET @LoadType = 0;
        END;

    IF @LoadType = 1
        BEGIN
            EXEC proc_EDW_Procedure_Performance_Monitor 'I' , @CT_NAME , '00A RELOAD ALL';
            IF EXISTS ( SELECT
                               NAME
                               FROM sys.tables
                               WHERE name = 'FACT_MART_EDW_HealthAssesment') 
                BEGIN
                    PRINT 'Truncating FACT_MART_EDW_HealthAssesment for FULL reload.' + ' @@  ' + CONVERT (nvarchar (50) , GETDATE () , 13) ;
                    truncate TABLE FACT_MART_EDW_HealthAssesment;
                END;
            ELSE
                BEGIN
                    EXEC PROC_CREATE_FACT_Tables;
                END;

            PRINT 'RELOAD ALL SELECTED.';
            EXEC proc_EDW_Procedure_Performance_Monitor 'I' , @CT_NAME , '00B BEGIN RELOAD ALL';
		  --alter table FACT_MART_EDW_HealthAssesment add HEALTHASSESSMENTTYPE nvarchar(20) null
		  --alter table FACT_MART_EDW_HealthAssesment add DBNAME nvarchar(50) null
		  --alter table FACT_MART_EDW_HealthAssesment add SVR nvarchar(50) null

            --**************************************************************************************************
            --EXEC @NbrOfDetectedChanges = proc_EDW_Populate_Staging_Tables @LoadType, @CT_NAME;
            INSERT INTO FACT_MART_EDW_HealthAssesment
            (
                   ACCOUNTCD
                 , ACCOUNTID
                 , ACCOUNTNAME
                 , CAMPAIGNNODEGUID
                 , CHANGED_FLG
                 --, ChangeType
                 , CMSNODEGUID
                 , DOCUMENTCULTURE_HAQUESTIONSVIEW
                 , DOCUMENTCULTURE_VHCJ
                 , HAANSWERNODEGUID
                 , HAANSWERPOINTS
                 , HAANSWERVALUE
                 , HAANSWERVERSIONID
                 , HACAMPAIGNID
                 , HACOMPLETEDDT
                 , HACOMPLETEDMODE
                 , HAMODULENODEGUID
                 , HAMODULESCORE
                 , HAMODULEVERSIONID
                 , HAPAPERFLG
                 , HAQUESTIONDOCUMENTID
                 , HAQUESTIONGUID
                 , HAQUESTIONNODEGUID
                 , HAQUESTIONSCORE
                 , HAQUESTIONVERSIONID
                 , HARISKAREANODEGUID
                 , HARISKAREASCORE
                 , HARISKAREAVERSIONID
                 , HARISKCATEGORY_ITEMMODIFIEDWHEN
                 , HARISKCATEGORYNODEGUID
                 , HARISKCATEGORYSCORE
                 , HARISKCATEGORYVERSIONID
                 , HASCORE
                 , HASHCODE
                 , HASTARTEDDT
                 , HASTARTEDMODE
                 , HATELEPHONICFLG
                 , HAUSERANSWERS_ITEMMODIFIEDWHEN
                 , HAUSERQUESTION_ITEMMODIFIEDWHEN
                 , HAUSERRISKAREA_ITEMMODIFIEDWHEN
                 , HEALTHASSESMENTUSERSTARTEDNODEGUID
                 , HEALTHASSESSMENTTYPE
                 , HFITUSERMPINUMBER
                 , ISPROFESSIONALLYCOLLECTED
                 , ITEMCREATEDWHEN
                 , ITEMMODIFIEDWHEN
                 , MODULEPREWEIGHTEDSCORE
                 , PKHASHCODE
                 , POINTRESULTS
                 , QUESTIONGROUPCODENAME
                 , QUESTIONPREWEIGHTEDSCORE
                 , RISKAREAPREWEIGHTEDSCORE
                 , RISKCATEGORYPREWEIGHTEDSCORE
                 , SITEGUID
                 , TITLE
                 , UOMCODE
                 , USERANSWERCODENAME
                 , USERANSWERITEMID
                 , USERGUID
                 , USERID
                 , USERMODULECODENAME
                 , USERMODULEITEMID
                 , USERQUESTIONCODENAME
                 , USERQUESTIONITEMID
                 , USERRISKAREACODENAME
                 , USERRISKAREAITEMID
                 , USERRISKCATEGORYCODENAME
                 , USERRISKCATEGORYITEMID
                 , USERSTARTEDITEMID
                 , DBNAME
                 , SVR
                 , LastModifiedDATE
                 , ConvertedToCentralTime
                 , RowNbr
                 , DELETEDFLG
                 , TimeZone) 
            SELECT
                   V.ACCOUNTCD
                 , V.ACCOUNTID
                 , V.ACCOUNTNAME
                 , V.CAMPAIGNNODEGUID
                 , V.CHANGED_FLG
                 --, 'U' AS ChangeType
                 , V.CMSNODEGUID
                 , V.DOCUMENTCULTURE_HAQUESTIONSVIEW
                 , V.DOCUMENTCULTURE_VHCJ
                 , V.HAANSWERNODEGUID
                 , V.HAANSWERPOINTS
                 , V.HAANSWERVALUE
                 , V.HAANSWERVERSIONID
                 , V.HACAMPAIGNID
                 , V.HACOMPLETEDDT
                 , V.HACOMPLETEDMODE
                 , V.HAMODULENODEGUID
                 , V.HAMODULESCORE
                 , V.HAMODULEVERSIONID
                 , V.HAPAPERFLG
                 , V.HAQUESTIONDOCUMENTID
                 , V.HAQUESTIONGUID
                 , V.HAQUESTIONNODEGUID
                 , V.HAQUESTIONSCORE
                 , V.HAQUESTIONVERSIONID
                 , V.HARISKAREANODEGUID
                 , V.HARISKAREASCORE
                 , V.HARISKAREAVERSIONID
                 , V.HARISKCATEGORY_ITEMMODIFIEDWHEN
                 , V.HARISKCATEGORYNODEGUID
                 , V.HARISKCATEGORYSCORE
                 , V.HARISKCATEGORYVERSIONID
                 , V.HASCORE
                 , V.HASHCODE
                 , V.HASTARTEDDT
                 , V.HASTARTEDMODE
                 , V.HATELEPHONICFLG
                 , V.HAUSERANSWERS_ITEMMODIFIEDWHEN
                 , V.HAUSERQUESTION_ITEMMODIFIEDWHEN
                 , V.HAUSERRISKAREA_ITEMMODIFIEDWHEN
                 , V.HEALTHASSESMENTUSERSTARTEDNODEGUID
                 , V.HEALTHASSESSMENTTYPE
                 , V.HFITUSERMPINUMBER
                 , V.ISPROFESSIONALLYCOLLECTED
                 , V.ITEMCREATEDWHEN
                 , V.ITEMMODIFIEDWHEN
                 , V.MODULEPREWEIGHTEDSCORE
                 , V.PKHASHCODE
                 , V.POINTRESULTS
                 , V.QUESTIONGROUPCODENAME
                 , V.QUESTIONPREWEIGHTEDSCORE
                 , V.RISKAREAPREWEIGHTEDSCORE
                 , V.RISKCATEGORYPREWEIGHTEDSCORE
                 , V.SITEGUID
                 , V.TITLE
                 , V.UOMCODE
                 , V.USERANSWERCODENAME
                 , V.USERANSWERITEMID
                 , V.USERGUID
                 , V.USERID
                 , V.USERMODULECODENAME
                 , V.USERMODULEITEMID
                 , V.USERQUESTIONCODENAME
                 , V.USERQUESTIONITEMID
                 , V.USERRISKAREACODENAME
                 , V.USERRISKAREAITEMID
                 , V.USERRISKCATEGORYCODENAME
                 , V.USERRISKCATEGORYITEMID
                 , V.USERSTARTEDITEMID
                 , DB_NAME () AS DBNAME
                 , @@SERVERNAME AS SVR
                 , NULL AS LastModifiedDATE
                 , NULL AS ConvertedToCentralTime
                 , NULL AS RowNbr
                 , NULL AS DeletedFlg
                 , NULL AS TimeZone
                   FROM
            view_EDW_PullHAData_NoCT AS V;
            --**************************************************************************************************

            --PRINT '00 Number of records loaded: ' + CAST (@NbrOfDetectedChanges AS nvarchar (50)) + ' @@  ' + CONVERT (nvarchar (50) , GETDATE () , 13) ;
            EXEC proc_EDW_Procedure_Performance_Monitor 'I' , @CT_NAME , '00C END RELOAD ALL';

            PRINT 'A0 Converting Time to Central' + ' @@  ' + CONVERT (nvarchar (50) , GETDATE () , 13) ;
            EXEC proc_EDW_Procedure_Performance_Monitor 'I' , @CT_NAME , '00D Begin Converting Time to Central';
            --**************************************************************************************************
            EXEC proc_EDW_ChangeGmtToCentralTime 'FACT_MART_EDW_HealthAssesment';
            --**************************************************************************************************
            EXEC proc_EDW_Procedure_Performance_Monitor 'I' , @CT_NAME , '00E Complete Converting Time to Central';

            PRINT 'A1 Cleaning Staging Data' + ' @@  ' + CONVERT (nvarchar (50) , GETDATE () , 13) ;
            EXEC proc_EDW_Procedure_Performance_Monitor 'I' , @CT_NAME , '00F Begin Cleaning Staging Data';
            --**************************************************************************************************
            EXEC proc_clean_EDW_Staging;
            --**************************************************************************************************
            EXEC proc_EDW_Procedure_Performance_Monitor 'I' , @CT_NAME , '00G END Cleaning Staging Data';

            PRINT 'Load Complete' + ' @@  ' + CONVERT (nvarchar (50) , GETDATE () , 13) ;
            EXEC proc_EDW_CT_ExecutionLog_Update_Counts @RecordID , 'T' , 0;

            RETURN;
        END;

    IF @iChgTypes = 0
        BEGIN

            PRINT 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX';
            PRINT 'NO Changes found - RETURNING' + ' @@  ' + CONVERT (nvarchar (50) , GETDATE () , 13) ;
            PRINT 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX';

            SET @STime = GETDATE () ;

            EXEC proc_EDW_CT_ExecutionLog_Update_Counts @RecordID , 'I' , 0;
            EXEC proc_EDW_CT_ExecutionLog_Update_Counts @RecordID , 'T' , 0;
            EXEC proc_EDW_CT_ExecutionLog_Update @RecordID , @CT_NAME , @CT_DateTimeNow , 0 , 'D';

            SET @proc_RowsProcessed = 0;
            SET @PROC_LOCATION = 'End Of Run - NO CHANGES FOUND';
            SET @proc_endtime = GETDATE () ;
            EXEC proc_CT_Performance_History @proc_RowGuid , @CT_NAME , @PROC_LOCATION , @proc_starttime , @proc_endtime , @proc_elapsedsecs , @proc_RowsProcessed;
            EXEC proc_EDW_Procedure_Performance_Monitor 'I' , @CT_NAME , '901';
            EXEC proc_EDW_Procedure_Performance_Monitor 'T' , @CT_NAME , '1001';

            RETURN;
        END;

    IF @iChgTypes = 1
    OR @iChgTypes = 2
        BEGIN
            PRINT '**02 Notice: changes found.' + ' @@  ' + CONVERT (nvarchar (50) , GETDATE () , 13) ;
            BEGIN
                PRINT '02b Starting applying Changes.' + ' @@  ' + CONVERT (nvarchar (50) , GETDATE () , 13) ;
                EXEC proc_EDW_Procedure_Performance_Monitor 'I' , @CT_NAME , '02b APPLYING changes';
                --**************************************************************************************************
                --EXEC @NbrOfDetectedChanges = proc_EDW_Populate_Staging_Tables @LoadType, @CT_NAME;
                EXEC proc_Apply_EDW_HA_Updates_ToStaging_Table ;
                --**************************************************************************************************
                EXEC proc_EDW_Procedure_Performance_Monitor 'I' , @CT_NAME , '02b - ENDING data pull';
            END;
        END;

    IF NOT EXISTS ( SELECT
                           name
                           FROM sys.indexes
                           WHERE name = 'PI_EDW_HealthAssessment_Dates') 
        BEGIN
            PRINT '05 Adding INDEX PI_EDW_HealthAssessment_Dates' + ' @@  ' + CONVERT (nvarchar (50) , GETDATE () , 13) ;
            CREATE INDEX PI_EDW_HealthAssessment_Dates ON dbo.FACT_MART_EDW_HealthAssesment ( ItemCreatedWhen ASC ,
            ItemModifiedWhen ASC) WITH ( PAD_INDEX = OFF , STATISTICS_NORECOMPUTE = OFF , SORT_IN_TEMPDB = OFF ,
            DROP_EXISTING = OFF , ONLINE = OFF ,
            ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ;
        END;

    IF NOT EXISTS
    ( SELECT
             name
             FROM sys.indexes
             WHERE name = 'PI_EDW_HealthAssessment_NATKEY') 

        BEGIN

            PRINT '07 Adding INDEX PI_EDW_HealthAssessment_NATKEY at: ' + CAST ( GETDATE () AS nvarchar ( 50)) + ' @@  ' + CONVERT (nvarchar (50) , GETDATE () , 13) ;

            CREATE CLUSTERED INDEX PI_EDW_HealthAssessment_NATKEY ON dbo.FACT_MART_EDW_HealthAssesment ( UserStartedItemID , UserGUID , PKHashCode , HashCode, DeletedFlg , LastModifiedDate) ;
        END;

    PRINT '013 Cleaning Staging Data' + ' @@  ' + CONVERT (nvarchar (50) , GETDATE () , 13) ;
    EXEC proc_clean_EDW_Staging;

    PRINT '014 Converting Time to Central' + ' @@  ' + CONVERT (nvarchar (50) , GETDATE () , 13) ;
    EXEC proc_EDW_ChangeGmtToCentralTime 'FACT_MART_EDW_HealthAssesment';
    EXEC proc_EDW_Procedure_Performance_Monitor 'I' , @CT_NAME , '009 - PROC FINISHED';
    EXEC proc_EDW_Procedure_Performance_Monitor 'T' , @CT_NAME , '010 - END OF RUN';

    PRINT '015 LOAD Complete: PERF Monitor Table - EDW_Proc_Performance_Monitor' + ' @@  ' + CONVERT (nvarchar (50) , GETDATE () , 13) ;

--select * from EDW_Proc_Performance_Monitor where TraceName = 'proc_Staging_EDW_Data' order by RowNbr Desc

END;

GO

PRINT 'Created proc_STAGING_EDW_HA_Changes_V2';

GO 

