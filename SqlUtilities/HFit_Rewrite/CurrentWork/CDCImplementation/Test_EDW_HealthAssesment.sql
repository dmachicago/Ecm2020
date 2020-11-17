
--TEST proc_STAGING_EDW_HA_Changes
--drop table #XXX

PRINT '****************************************************************';
PRINT '** TEST Initial counts ';
PRINT '****************************************************************';
RAISERROR ( 'PRINT Check' , 10 , 1) WITH NOWAIT;

DECLARE
@iCnt AS int = 0
, @iTotalRecs AS int = 0
, @iTotal AS int = 0
, @ERROR_CNT AS int = 0
, @ReuseExistingData AS bit = 1
,@AllColumnsPresent AS bit = 1;

IF NOT EXISTS ( SELECT
                       name
                       FROM sys.tables
                       WHERE name = 'FACT_MART_EDW_HealthAssesment') 
    BEGIN
        PRINT '**ERROR ERROR ERROR ERROR ERROR **';
        PRINT ' Table FACT_MART_EDW_HealthAssesment does not exist.';
        RETURN;
    END;

DECLARE @StagingRecCount AS bigint = 0;
EXEC @StagingRecCount = proc_QuickRowCount 'FACT_MART_EDW_HealthAssesment';
PRINT 'Records in FACT_MART_EDW_HealthAssesment: ' + CAST ( @StagingRecCount AS nvarchar (50)) ;
IF @StagingRecCount < 1000
    BEGIN
        PRINT 'NO Records found - reloading all HA records... takes several hours.';
        EXEC proc_STAGING_EDW_HA_Changes 1;
    END;

IF not EXISTS ( SELECT
                               name
                          FROM tempdb.dbo.sysobjects
                          WHERE id = OBJECT_ID ( N'tempdb..##HealthAssessmentData' ))
                BEGIN
                    PRINT 'Generating ##HealthAssessmentData';
                    select * into ##HealthAssessmentData from FACT_MART_EDW_HealthAssesment ;
                END;

DECLARE
@TempCnt AS bigint = 0;
EXEC @TempCnt = proc_QuickRowCount 'TEMP_EDW_HealthAssessment_DATA';
PRINT 'Records in TEMP_EDW_HealthAssessment_DATA: ' + CAST ( @TempCnt  AS nvarchar (50)) ;
DECLARE @BackupRecs AS bigint = 0;
EXEC @BackupRecs = proc_QuickRowCount 'TEMP_EDW_HealthAssessment_DATA';
IF @BackupRecs = 0
    BEGIN
        INSERT INTO TEMP_EDW_HealthAssessment_DATA
        (
               UserStartedItemID
             , HealthAssesmentUserStartedNodeGUID
             , UserID
             , UserGUID
             , HFitUserMpiNumber
             , SiteGUID
             , AccountID
             , AccountCD
             , AccountName
             , HAStartedDt
             , HACompletedDt
             , UserModuleItemId
             , UserModuleCodeName
             , HAModuleNodeGUID
             , CMSNodeGuid
             , HAModuleVersionID
             , UserRiskCategoryItemID
             , UserRiskCategoryCodeName
             , HARiskCategoryNodeGUID
             , HARiskCategoryVersionID
             , UserRiskAreaItemID
             , UserRiskAreaCodeName
             , HARiskAreaNodeGUID
             , HARiskAreaVersionID
             , UserQuestionItemID
             , Title
             , HAQuestionGuid
             , UserQuestionCodeName
             , HAQuestionDocumentID
             , HAQuestionVersionID
             , HAQuestionNodeGUID
             , UserAnswerItemID
             , HAAnswerNodeGUID
             , HAAnswerVersionID
             , UserAnswerCodeName
             , HAAnswerValue
             , HAModuleScore
             , HARiskCategoryScore
             , HARiskAreaScore
             , HAQuestionScore
             , HAAnswerPoints
             , PointResults
             , UOMCode
             , HAScore
             , ModulePreWeightedScore
             , RiskCategoryPreWeightedScore
             , RiskAreaPreWeightedScore
             , QuestionPreWeightedScore
             , QuestionGroupCodeName
             , ItemCreatedWhen
             , ItemModifiedWhen
             , IsProfessionallyCollected
             , HARiskCategory_ItemModifiedWhen
             , HAUserRiskArea_ItemModifiedWhen
             , HAUserQuestion_ItemModifiedWhen
             , HAUserAnswers_ItemModifiedWhen
             , HAPaperFlg
             , HATelephonicFlg
             , HAStartedMode
             , HACompletedMode
             , DocumentCulture_VHCJ
             , DocumentCulture_HAQuestionsView
             , CampaignNodeGUID
             , HACampaignID
             , HashCode
             , ChangeType
             , CHANGED_FLG
             , DeleteFlg
             , CT_CMS_User_UserID
             , CT_CMS_User_CHANGE_OPERATION
             , CT_UserSettingsID
             , CT_UserSettingsID_CHANGE_OPERATION
             , SiteID_CtID
             , SiteID_CHANGE_OPERATION
             , UserSiteID_CtID
             , UserSiteID_CHANGE_OPERATION
             , AccountID_CtID
             , AccountID__CHANGE_OPERATION
             , HAUserAnswers_CtID
             , HAUserAnswers_CHANGE_OPERATION
             , HFit_HealthAssesmentUserModule_CtID
             , HFit_HealthAssesmentUserModule_CHANGE_OPERATION
             , HFit_HealthAssesmentUserQuestion_CtID
             , HFit_HealthAssesmentUserQuestion_CHANGE_OPERATION
             , HFit_HealthAssesmentUserQuestionGroupResults_CtID
             , HFit_HealthAssesmentUserQuestionGroupResults_CHANGE_OPERATION
             , HFit_HealthAssesmentUserRiskArea_CtID
             , HFit_HealthAssesmentUserRiskArea_CHANGE_OPERATION
             , HFit_HealthAssesmentUserRiskCategory_CtID
             , HFit_HealthAssesmentUserRiskCategory_CHANGE_OPERATION
             , HFit_HealthAssesmentUserStarted_CtID
             , HFit_HealthAssesmentUserStarted_CHANGE_OPERATION
             , CT_CMS_User_SCV
             , CT_CMS_UserSettings_SCV
             , CT_CMS_Site_SCV
             , CT_CMS_UserSite_SCV
             , CT_HFit_Account_SCV
             , CT_HFit_HealthAssesmentUserAnswers_SCV
             , CT_HFit_HealthAssesmentUserModule_SCV
             , CT_HFit_HealthAssesmentUserQuestionGroupResults_SCV
             , CT_HFit_HealthAssesmentUserRiskArea_SCV
             , CT_HFit_HealthAssesmentUserRiskCategory_SCV
             , CT_HFit_HealthAssesmentUserStarted_SCV
             , CT_HFit_HealthAssesmentUserQuestion_SCV
             , ConvertedToCentralTime
             , LastModifiedDate
             , RowNbr
             , DeletedFlg
             , TimeZone
             , PKHashCode) 
        SELECT
               UserStartedItemID
             , HealthAssesmentUserStartedNodeGUID
             , UserID
             , UserGUID
             , HFitUserMpiNumber
             , SiteGUID
             , AccountID
             , AccountCD
             , AccountName
             , HAStartedDt
             , HACompletedDt
             , UserModuleItemId
             , UserModuleCodeName
             , HAModuleNodeGUID
             , CMSNodeGuid
             , HAModuleVersionID
             , UserRiskCategoryItemID
             , UserRiskCategoryCodeName
             , HARiskCategoryNodeGUID
             , HARiskCategoryVersionID
             , UserRiskAreaItemID
             , UserRiskAreaCodeName
             , HARiskAreaNodeGUID
             , HARiskAreaVersionID
             , UserQuestionItemID
             , Title
             , HAQuestionGuid
             , UserQuestionCodeName
             , HAQuestionDocumentID
             , HAQuestionVersionID
             , HAQuestionNodeGUID
             , UserAnswerItemID
             , HAAnswerNodeGUID
             , HAAnswerVersionID
             , UserAnswerCodeName
             , HAAnswerValue
             , HAModuleScore
             , HARiskCategoryScore
             , HARiskAreaScore
             , HAQuestionScore
             , HAAnswerPoints
             , PointResults
             , UOMCode
             , HAScore
             , ModulePreWeightedScore
             , RiskCategoryPreWeightedScore
             , RiskAreaPreWeightedScore
             , QuestionPreWeightedScore
             , QuestionGroupCodeName
             , ItemCreatedWhen
             , ItemModifiedWhen
             , IsProfessionallyCollected
             , HARiskCategory_ItemModifiedWhen
             , HAUserRiskArea_ItemModifiedWhen
             , HAUserQuestion_ItemModifiedWhen
             , HAUserAnswers_ItemModifiedWhen
             , HAPaperFlg
             , HATelephonicFlg
             , HAStartedMode
             , HACompletedMode
             , DocumentCulture_VHCJ
             , DocumentCulture_HAQuestionsView
             , CampaignNodeGUID
             , HACampaignID
             , HashCode
             , ChangeType
             , CHANGED_FLG
             , DeleteFlg
             , CT_CMS_User_UserID
             , CT_CMS_User_CHANGE_OPERATION
             , CT_UserSettingsID
             , CT_UserSettingsID_CHANGE_OPERATION
             , SiteID_CtID
             , SiteID_CHANGE_OPERATION
             , UserSiteID_CtID
             , UserSiteID_CHANGE_OPERATION
             , AccountID_CtID
             , AccountID__CHANGE_OPERATION
             , HAUserAnswers_CtID
             , HAUserAnswers_CHANGE_OPERATION
             , HFit_HealthAssesmentUserModule_CtID
             , HFit_HealthAssesmentUserModule_CHANGE_OPERATION
             , HFit_HealthAssesmentUserQuestion_CtID
             , HFit_HealthAssesmentUserQuestion_CHANGE_OPERATION
             , HFit_HealthAssesmentUserQuestionGroupResults_CtID
             , HFit_HealthAssesmentUserQuestionGroupResults_CHANGE_OPERATION
             , HFit_HealthAssesmentUserRiskArea_CtID
             , HFit_HealthAssesmentUserRiskArea_CHANGE_OPERATION
             , HFit_HealthAssesmentUserRiskCategory_CtID
             , HFit_HealthAssesmentUserRiskCategory_CHANGE_OPERATION
             , HFit_HealthAssesmentUserStarted_CtID
             , HFit_HealthAssesmentUserStarted_CHANGE_OPERATION
             , CT_CMS_User_SCV
             , CT_CMS_UserSettings_SCV
             , CT_CMS_Site_SCV
             , CT_CMS_UserSite_SCV
             , CT_HFit_Account_SCV
             , CT_HFit_HealthAssesmentUserAnswers_SCV
             , CT_HFit_HealthAssesmentUserModule_SCV
             , CT_HFit_HealthAssesmentUserQuestionGroupResults_SCV
             , CT_HFit_HealthAssesmentUserRiskArea_SCV
             , CT_HFit_HealthAssesmentUserRiskCategory_SCV
             , CT_HFit_HealthAssesmentUserStarted_SCV
             , CT_HFit_HealthAssesmentUserQuestion_SCV
             , NULL AS ConvertedToCentralTime
             , NULL AS LastModifiedDate
             , NULL AS RowNbr
             , NULL AS DeletedFlg
             , NULL AS TimeZone
             , PKHashCode
               FROM FACT_MART_EDW_HealthAssesment;
    END;

EXEC @iTotalRecs = proc_QuickRowCount 'FACT_MART_EDW_HealthAssesment';

--**************************************************************
-- BEGIN TRACKING THE PERFORMANCE
--**************************************************************
EXEC proc_EDW_Procedure_Performance_Monitor 'D' , 'TestHealthAssessmentChangeTracking';
EXEC proc_EDW_Procedure_Performance_Monitor 'I' , 'TestHealthAssessmentChangeTracking' , '001';

DECLARE
@DBN AS nvarchar ( 100) = DB_NAME () 
,@JNAME AS nvarchar ( 100) = 'job_EDW_GetFACTData_HA_' + @DBN
,@b AS int = 0;

EXEC @b = isJobRunning @JNAME;

IF @b = 1
    BEGIN
        PRINT ' '; PRINT ' ';
        --PRINT '*********************************** NOTICE ***************************************';
        PRINT 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX';
        PRINT 'XXXX WARNING XXXX WARNING XXXX WARNING XXXX WARNING XXXX WARNING XXXX WARNING XXXX';
        PRINT '*********************************** NOTICE ***************************************';
        PRINT @JNAME + ' Currently running, aborting test.';
        PRINT 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX';
        RETURN;
    END;

/*----------------------------------------------------------------------------------------
********DISABLE ANY JOBS THAT MIGHT INTERFERE ********************************************
*/

--DECLARE
--   @NewJname AS nvarchar ( 100 ) = @JNAME + ' -- Disabled';
--DECLARE
--   @NewJdesc AS nvarchar ( 100 ) = @JNAME + ' disabled during TESTING.';

--EXEC dbo.sp_update_job

--@job_name = @JNAME ,
--@new_name = @NewJname ,
--@description = @NewJdesc ,
--@enabled = 0;
--PRINT '*********************************** NOTICE ****************************************';
--PRINT @JNAME + ' DISABLED FOR TEST.';
--PRINT '*********************************** NOTICE ****************************************';
--EXEC proc_EDW_Procedure_Performance_Monitor 'I' , 'TestHealthAssessmentChangeTracking' , '002 - Jobs Disabled';

/*----------------------------------------------------------------------------------------
******************************************************************************************
*/

IF @ReuseExistingData = 0
    BEGIN
        SET @iTotalRecs = ( SELECT
                                   COUNT ( *) 
                                   FROM view_EDW_HealthAssesment) ;
    END;
ELSE
    BEGIN
        EXEC @iTotalRecs = proc_QuickRowCount 'FACT_MART_EDW_HealthAssesment';
    END;

PRINT 'TOTAL HA RECS TO PROCESS: ' + CAST ( @iTotalRecs AS nvarchar (50)) ;

SET @iCnt = ( SELECT
                     COUNT ( *) 
                     FROM HFit_Account) ;

PRINT 'Row count from BASE TABLE Staging EDW : ' + CAST ( @iTotalRecs AS nvarchar (50)) ;
PRINT 'Row count from parent view: ' + CAST ( @iCnt AS nvarchar (50)) ;

RAISERROR ( '@iCnt records in Staging table' , 10 , 1) WITH NOWAIT;

EXEC proc_EDW_Procedure_Performance_Monitor 'I' , 'TestHealthAssessmentChangeTracking' , '003 - Count Records';

--TEST THE Change Tracking View
DECLARE
@iCntCT AS int = 0;

IF @ReuseExistingData = 0
    BEGIN
        EXEC proc_EDW_Procedure_Performance_Monitor 'I' , 'TestHealthAssessmentChangeTracking' , '004 - Count Records using view';
        SET @iCntCT = ( SELECT
                               COUNT ( *) 
                               FROM view_WDW_HealthAssesment_CT) ;
        PRINT 'Row count from CT view: ' + CAST ( @iCntCT AS nvarchar ( 50)) ;
        EXEC proc_EDW_Procedure_Performance_Monitor 'I' , 'TestHealthAssessmentChangeTracking' , '005 - Counted Records using view';
    END;
ELSE
    BEGIN
        SET @iCntCT = @iTotalRecs;
        RAISERROR ( 'Row count from Staging Table: @iCnt' , 10 , 1) WITH NOWAIT;
    END;

DECLARE
@iCntDIFF AS int = 0;

SET @iCntDIFF = @iTotalRecs - @iCntCT;

PRINT '*****************************************************************';
IF @iCntDIFF = 0
    BEGIN
        PRINT 'TEST #1 PASSED - ROW DIFF Between BASE View and CT View is ZERO) ';
    END;
ELSE
    BEGIN
        PRINT 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx';
        PRINT 'ERROR ; TEST #1 FAILED - ROW DIFF Between BASE View and CT View: ' + CAST ( @iCntDIFF AS nvarchar ( 50)) + ', should be ZERO.';
        SET @ERROR_CNT = @ERROR_CNT + 1;
    END;
PRINT '*****************************************************************';
RAISERROR ( 'PRINT Check' , 10 , 1) WITH NOWAIT;

--Test the RELOAD ALL of the procedure 130

PRINT '**----------------------------------------------------------------**';
PRINT '** TEST #2 Initial LOADS ';
PRINT '**----------------------------------------------------------------**';

IF @ReuseExistingData = 0
    BEGIN
        EXEC proc_EDW_Procedure_Performance_Monitor 'I' , 'TestHealthAssessmentChangeTracking' , '006a - EXEC proc_STAGING_EDW_HA_Changes 1';
        EXEC proc_STAGING_EDW_HA_Changes 1;
        EXEC proc_EDW_Procedure_Performance_Monitor 'I' , 'TestHealthAssessmentChangeTracking' , '006b - END proc_STAGING_EDW_HA_Changes 1';
    END;
IF @ReuseExistingData = 0
    BEGIN
        EXEC proc_EDW_Procedure_Performance_Monitor 'I' , 'TestHealthAssessmentChangeTracking' , '007b - Start proc_STAGING_EDW_HA_Changes 0';
        EXEC proc_STAGING_EDW_HA_Changes 0;
        EXEC proc_EDW_Procedure_Performance_Monitor 'I' , 'TestHealthAssessmentChangeTracking' , '007b - END proc_STAGING_EDW_HA_Changes 0';
    END;

DECLARE
@iTempRecCnt AS int = 0;
EXEC @iTempRecCnt = proc_QuickRowCount 'TEMP_EDW_HealthAssessment_DATA';

DECLARE
@iStagingRecCnt AS int = 0;
EXEC @iStagingRecCnt = proc_QuickRowCount 'FACT_MART_EDW_HealthAssesment';

EXEC proc_EDW_Procedure_Performance_Monitor 'I' , 'TestHealthAssessmentChangeTracking' , '008 - GET COUNTS';
PRINT '****************************************************************';
PRINT '** TEST #2 Initial LOADS COUNTS: ';
PRINT 'Temp Records Created: ' + CAST ( @iTempRecCnt AS nvarchar (50)) ;
PRINT 'Staging Records Created: ' + CAST ( @iStagingRecCnt AS nvarchar (50)) ;
PRINT '****************************************************************';
RAISERROR ( 'PRINT Check' , 10 , 1) WITH NOWAIT;
IF EXISTS ( SELECT
                   name
                   FROM sys.tables
                   WHERE name = 'Temp_HaTEST') 
    BEGIN
        PRINT 'Dropped Temp_HaTEST table ';
        DROP TABLE
             Temp_HaTEST;
    END;

/*-------------------------------------------
*******************************************
** BACKUP THE BASE TABLE BEFORE PROCEEDING **
*******************************************
*/

SELECT
       *
       FROM HFit_Account AS Temp_HFit_Account_FULL_Backup;
IF NOT EXISTS ( SELECT
                       name
                       FROM sys.tables
                       WHERE name = 'Temp_HFit_Account_FULL_Backup') 

    BEGIN
        PRINT 'backing up staging data';
        SELECT
               * INTO
                      Temp_HFit_Account_FULL_Backup
               FROM HFit_Account;
    END;

--IF NOT EXISTS ( SELECT
--                       name
--                  FROM sys.tables
--                  WHERE name = 'Temp_EDW_HealthAssessment_FULL_Backup' )

--    BEGIN
--        SELECT
--               * INTO
--                      Temp_EDW_HealthAssessment_FULL_Backup
--          FROM FACT_MART_EDW_HealthAssesment;
--    END;

EXEC proc_EDW_Procedure_Performance_Monitor 'I' , 'TestHealthAssessmentChangeTracking' , '009 - BACKUPS';

/*---------------------------------------------
*********************************************
Get 100 rows and save them for testing purposes
*********************************************
*/

--select * from Temp_HaTEST

--SELECT
--       *
--INTO
--     Temp_HaTEST
--       FROM HFit_Account
--       ORDER BY
--                AccountID;

--select * from Temp_HaTEST

/*
    Modify a portion of the 100 rows AND validate that change tracking finds them and updates the staging table.
    NOTE: The column to be modified will have to be validated for each base table to ensure it is used in the view.
*/

DBCC DROPCLEANBUFFERS;
/*
select * from view_WDW_HealthAssesment_CT WHERE AccountID = 23268;
SELECT
       *
  FROM HFit_Account;
*/

UPDATE HFit_Account
  SET
      AccountCD = UPPER( AccountCD ), ItemModifiedWhen = getdate()
  WHERE
        AccountCD = 'TrustMark' or AccountCD = 'dovercor';

/*-----------------------------
select * from HFit_Account
UPDATE HFit_Account
  SET
      AccountName = 'Dupont'
  WHERE
        AccountName = 'dupont';

UPDATE HFit_Account
  SET
      AccountName = 'dst'
  WHERE
        AccountName = 'DST';
*/

DECLARE
@iChgCnt AS int = 0;

SET @iChgCnt = ( SELECT
                        COUNT ( *) 
                        FROM HFit_Account
                        WHERE
                        --AccountName = 'dupont' OR
                        AccountName = 'FIS') ;

PRINT 'HFit_Account ROWS changed: ' + CAST ( @iChgCnt AS nvarchar (50)) ;

/*------------------------------------
************************************
**************************************
    Make sure Changes ARE detected
**************************************
************************************
*/

DECLARE
@PreInsertDate AS datetime = GETDATE () ;
DECLARE
@iCurrentCngCnt AS int = ( SELECT
                                  COUNT ( *) 
                                  FROM FACT_MART_EDW_HealthAssesment
                                  WHERE LastModifiedDate > @PreInsertDate) ;

PRINT 'Make sure Changes ARE detected.';
EXEC proc_STAGING_EDW_HA_Changes;

DECLARE
@iNewCngCnt AS int = ( SELECT
                              COUNT ( *) 
                              FROM FACT_MART_EDW_HealthAssesment
                              WHERE LastModifiedDate > @PreInsertDate) ;

PRINT '************************************************************************';
PRINT 'RECORDS BEFORE UPDATE: ' + CAST ( @iCurrentCngCnt AS nvarchar (50)) ;
PRINT 'RECORDS AFTER  UPDATE: ' + CAST ( @iNewCngCnt AS nvarchar (50)) ;

DECLARE
@iDiff AS int = @iNewCngCnt - @iCurrentCngCnt;
PRINT 'UPDATED RECORD COUNT: ' + CAST ( @iDiff AS nvarchar (50)) ;
IF @iDiff = 0
    BEGIN
        PRINT '??????????????????????????????';
        PRINT 'WARNING - no changes recorded.';
    END;
ELSE
    BEGIN
        PRINT 'PASSED TEST- changes recorded.';
    END;
PRINT '************************************************************************';
RAISERROR ( 'PRINT Check' , 10 , 1) WITH NOWAIT;

/*------------------------------------------------------------------------
**************************************************************************
    Put back the original Data
**************************************************************************
*/

--delete from FACT_MART_EDW_HealthAssesment where PkHashcode in (select top 30000 pkhashcode from FACT_MART_EDW_HealthAssesment)
--delete from FACT_MART_EDW_HealthAssesment where AccountName like 'TrstMark' ;

PRINT 'Reset data in base table.';

UPDATE HFit_Account
  SET
      AccountCD = lower( AccountCD )
  WHERE
        AccountCD = 'dst' or AccountCD = 'dovercor';
/*
UPDATE HFit_Account
  SET
      AccountName = 'duPont'
  WHERE
        AccountName = 'dupont';
*/

UPDATE HFit_Account
  SET
      AccountName = 'FIS'
       WHERE
             AccountName = 'fis';

PRINT 'Changes to HFit_Account data reset: ';

PRINT 'Make sure Changes ARE PUT BACK to HFit_Account.';
EXEC proc_EDW_Procedure_Performance_Monitor 'I' , 'TestHealthAssessmentChangeTracking' , '010 - Make sure Changes ARE PUT BACK';

EXEC proc_STAGING_EDW_HA_Changes;

EXEC proc_EDW_Procedure_Performance_Monitor 'I' , 'TestHealthAssessmentChangeTracking' , '011 - Changes PUT BACK ended';
EXEC proc_EDW_Procedure_Performance_Monitor 'T' , 'TestHealthAssessmentChangeTracking' , '011 - Changes PUT BACK ended';

/*----------------------------------------
****************************************
******************************************
    DROP ROWS AND LOOK FOR DELETES 
******************************************
****************************************
*/

PRINT 'Record count before delete: ' + CAST ( @iTotalRecs AS nvarchar (50)) ;

DELETE FROM HFit_Account
       WHERE
             AccountID IN ( SELECT TOP 1
                                   AccountID
                                   FROM Temp_HaTEST) ;

DECLARE
@CntAfterDelete AS int = 0;

SET @CntAfterDelete = ( SELECT
                               COUNT ( *) 
                               FROM HFit_Account) ;

PRINT 'Rows DEleted from BASE Table: ' + CAST ( @CntAfterDelete AS nvarchar (50)) ;

PRINT 'Validating deletes are detected and marked.';
RAISERROR ( 'PRINT Check: @CntAfterDelete' , 10 , 1) WITH NOWAIT;

EXEC proc_STAGING_EDW_HA_Changes;

DECLARE
@CntMArkedAsDeleted AS int = 0;

SET @CntMArkedAsDeleted = ( SELECT
                                   COUNT ( *) 
                                   FROM FACT_MART_EDW_HealthAssesment
                                   WHERE DeleteFlg IS NOT NULL) ;

PRINT '**********************************************************';
PRINT 'Record count marked as deleted: ' + CAST ( @CntMArkedAsDeleted AS nvarchar (50)) ;
PRINT '**********************************************************';
RAISERROR ( 'PRINT Check' , 10 , 1) WITH NOWAIT;

IF @CntMArkedAsDeleted = 0
    BEGIN
        PRINT '**********************************************************';
        PRINT 'ERROR: Deleted records not found and marked.';
        PRINT '**********************************************************';
    END;

PRINT 'Put back the deleted records to the base table.';

SET IDENTITY_INSERT HFit_Account ON;

INSERT INTO HFit_Account (
       AccountID
     , SiteID
     , AccountName
     , ItemCreatedBy
     , ItemCreatedWhen
     , ItemModifiedBy
     , ItemModifiedWhen
     , ItemOrder
     , ItemGUID
     , AccountCD
     , FaceToFaceAdvising) 
SELECT
       AccountID
     , SiteID
     , AccountName
     , ItemCreatedBy
     , ItemCreatedWhen
     , ItemModifiedBy
     , ItemModifiedWhen
     , ItemOrder
     , ItemGUID
     , AccountCD
     , FaceToFaceAdvising
       FROM Temp_HaTEST
       WHERE AccountID NOT IN (
       SELECT
              AccountID
              FROM HFit_Account) ;

SET IDENTITY_INSERT HFit_Account OFF;
--update HFit_Account set AccountCD = 'TrstMark' where accountID = 2
--select * from KenticoCMS_Prod3..HFit_Account
--select * from HFit_Account
--select * from Temp_HA_FULL_Backup

/*-----------------------------------------------------------
***********************************************************
*************************************************************
Confirm that INSERTS are detected and registered.
select * from Temp_HaTEST
NOTE: This statement will have to be tailored for each use
*************************************************************
***********************************************************
*/

SELECT TOP 10
       *
INTO
     #XXX
       FROM TEMP_EDW_HealthAssessment_DATA;

UPDATE #XXX
  SET
      UserID = -1
    ,Hashcode = HASHBYTES ( 'sha1' , CAST ( UserID AS nvarchar (50)) + CAST ( SiteGuid AS nvarchar (50)) + CAST ( HashCode AS nvarchar (100))) 
    ,LastModifiedDate = NULL;

INSERT INTO TEMP_EDW_HealthAssessment_DATA
(
       UserStartedItemID
     , HealthAssesmentUserStartedNodeGUID
     , UserID
     , UserGUID
     , HFitUserMpiNumber
     , SiteGUID
     , AccountID
     , AccountCD
     , AccountName
     , HAStartedDt
     , HACompletedDt
     , UserModuleItemId
     , UserModuleCodeName
     , HAModuleNodeGUID
     , CMSNodeGuid
     , HAModuleVersionID
     , UserRiskCategoryItemID
     , UserRiskCategoryCodeName
     , HARiskCategoryNodeGUID
     , HARiskCategoryVersionID
     , UserRiskAreaItemID
     , UserRiskAreaCodeName
     , HARiskAreaNodeGUID
     , HARiskAreaVersionID
     , UserQuestionItemID
     , Title
     , HAQuestionGuid
     , UserQuestionCodeName
     , HAQuestionDocumentID
     , HAQuestionVersionID
     , HAQuestionNodeGUID
     , UserAnswerItemID
     , HAAnswerNodeGUID
     , HAAnswerVersionID
     , UserAnswerCodeName
     , HAAnswerValue
     , HAModuleScore
     , HARiskCategoryScore
     , HARiskAreaScore
     , HAQuestionScore
     , HAAnswerPoints
     , PointResults
     , UOMCode
     , HAScore
     , ModulePreWeightedScore
     , RiskCategoryPreWeightedScore
     , RiskAreaPreWeightedScore
     , QuestionPreWeightedScore
     , QuestionGroupCodeName
     , ItemCreatedWhen
     , ItemModifiedWhen
     , IsProfessionallyCollected
     , HARiskCategory_ItemModifiedWhen
     , HAUserRiskArea_ItemModifiedWhen
     , HAUserQuestion_ItemModifiedWhen
     , HAUserAnswers_ItemModifiedWhen
     , HAPaperFlg
     , HATelephonicFlg
     , HAStartedMode
     , HACompletedMode
     , DocumentCulture_VHCJ
     , DocumentCulture_HAQuestionsView
     , CampaignNodeGUID
     , HACampaignID
     , HashCode
     , ChangeType
     , CHANGED_FLG
     , DeleteFlg
     , CT_CMS_User_UserID
     , CT_CMS_User_CHANGE_OPERATION
     , CT_UserSettingsID
     , CT_UserSettingsID_CHANGE_OPERATION
     , SiteID_CtID
     , SiteID_CHANGE_OPERATION
     , UserSiteID_CtID
     , UserSiteID_CHANGE_OPERATION
     , AccountID_CtID
     , AccountID__CHANGE_OPERATION
     , HAUserAnswers_CtID
     , HAUserAnswers_CHANGE_OPERATION
     , HFit_HealthAssesmentUserModule_CtID
     , HFit_HealthAssesmentUserModule_CHANGE_OPERATION
     , HFit_HealthAssesmentUserQuestion_CtID
     , HFit_HealthAssesmentUserQuestion_CHANGE_OPERATION
     , HFit_HealthAssesmentUserQuestionGroupResults_CtID
     , HFit_HealthAssesmentUserQuestionGroupResults_CHANGE_OPERATION
     , HFit_HealthAssesmentUserRiskArea_CtID
     , HFit_HealthAssesmentUserRiskArea_CHANGE_OPERATION
     , HFit_HealthAssesmentUserRiskCategory_CtID
     , HFit_HealthAssesmentUserRiskCategory_CHANGE_OPERATION
     , HFit_HealthAssesmentUserStarted_CtID
     , HFit_HealthAssesmentUserStarted_CHANGE_OPERATION
     , CT_CMS_User_SCV
     , CT_CMS_UserSettings_SCV
     , CT_CMS_Site_SCV
     , CT_CMS_UserSite_SCV
     , CT_HFit_Account_SCV
     , CT_HFit_HealthAssesmentUserAnswers_SCV
     , CT_HFit_HealthAssesmentUserModule_SCV
     , CT_HFit_HealthAssesmentUserQuestionGroupResults_SCV
     , CT_HFit_HealthAssesmentUserRiskArea_SCV
     , CT_HFit_HealthAssesmentUserRiskCategory_SCV
     , CT_HFit_HealthAssesmentUserStarted_SCV
     , CT_HFit_HealthAssesmentUserQuestion_SCV
     , ConvertedToCentralTime
     , LastModifiedDate
     , RowNbr
     , DeletedFlg
     , TimeZone
     , PKHashCode
) 
SELECT
       *
       FROM #XXX;

DECLARE
@iCntBeforeInsert AS int = 0;

SET @iCntBeforeInsert = ( SELECT
                                 COUNT ( *) 
                                 FROM FACT_MART_EDW_HealthAssesment) ;

PRINT '*************************************************************';
PRINT 'Staging Record Count Before Insert: ' + CAST ( @iCntBeforeInsert AS nvarchar (50)) ;
PRINT '*************************************************************';
RAISERROR ( 'PRINT Check' , 10 , 1) WITH NOWAIT;

/*------------------------------------------------------------------
******************************************************************
********************************************************************
THIS IS A MANUAL TEST STEP: Test Finding and inserting new records
1 - OPEN proc_STAGING_EDW_HA_Changes
2 - FIND "--INSERT TEST START"
3 - HIGHLIGHT THRU "--INSERT TEST END"
4 - EXECUTE THE HIGHLIGHTED CODE
********************************************************************
******************************************************************
*/

/*-----------------------------------------------------------------------------------------------
*************************************************************************************************
*/

WITH CTE (
     UserStartedItemID
   , UserGUID
   , PKHashCode) 
    AS ( SELECT
                UserStartedItemID
              , UserGUID
              , PKHashCode
                FROM TEMP_EDW_HealthAssessment_DATA
         EXCEPT
         SELECT
                UserStartedItemID
              , UserGUID
              , PKHashCode
                FROM FACT_MART_EDW_HealthAssesment
                WHERE LastModifiedDate IS NULL) 
    INSERT INTO dbo.FACT_MART_EDW_HealthAssesment (
           UserStartedItemID
         , HealthAssesmentUserStartedNodeGUID
         , UserID
         , UserGUID
         , HFitUserMpiNumber
         , SiteGUID
         , AccountID
         , AccountCD
         , AccountName
         , HAStartedDt
         , HACompletedDt
         , UserModuleItemId
         , UserModuleCodeName
         , HAModuleNodeGUID
         , CMSNodeGuid
         , HAModuleVersionID
         , UserRiskCategoryItemID
         , UserRiskCategoryCodeName
         , HARiskCategoryNodeGUID
         , HARiskCategoryVersionID
         , UserRiskAreaItemID
         , UserRiskAreaCodeName
         , HARiskAreaNodeGUID
         , HARiskAreaVersionID
         , UserQuestionItemID
         , Title
         , HAQuestionGuid
         , UserQuestionCodeName
         , HAQuestionDocumentID
         , HAQuestionVersionID
         , HAQuestionNodeGUID
         , UserAnswerItemID
         , HAAnswerNodeGUID
         , HAAnswerVersionID
         , UserAnswerCodeName
         , HAAnswerValue
         , HAModuleScore
         , HARiskCategoryScore
         , HARiskAreaScore
         , HAQuestionScore
         , HAAnswerPoints
         , PointResults
         , UOMCode
         , HAScore
         , ModulePreWeightedScore
         , RiskCategoryPreWeightedScore
         , RiskAreaPreWeightedScore
         , QuestionPreWeightedScore
         , QuestionGroupCodeName
         , ItemCreatedWhen
         , ItemModifiedWhen
         , IsProfessionallyCollected
         , HARiskCategory_ItemModifiedWhen
         , HAUserRiskArea_ItemModifiedWhen
         , HAUserQuestion_ItemModifiedWhen
         , HAUserAnswers_ItemModifiedWhen
         , HAPaperFlg
         , HATelephonicFlg
         , HAStartedMode
         , HACompletedMode
         , DocumentCulture_VHCJ
         , DocumentCulture_HAQuestionsView
         , CampaignNodeGUID
         , HACampaignID
         , HashCode
         , ChangeType
         , CHANGED_FLG
         , DeleteFlg
         , CT_CMS_User_UserID
         , CT_CMS_User_CHANGE_OPERATION
         , CT_UserSettingsID
         , CT_UserSettingsID_CHANGE_OPERATION
         , SiteID_CtID
         , SiteID_CHANGE_OPERATION
         , UserSiteID_CtID
         , UserSiteID_CHANGE_OPERATION
         , AccountID_CtID
         , AccountID__CHANGE_OPERATION
         , HAUserAnswers_CtID
         , HAUserAnswers_CHANGE_OPERATION
         , HFit_HealthAssesmentUserModule_CtID
         , HFit_HealthAssesmentUserModule_CHANGE_OPERATION
         , HFit_HealthAssesmentUserQuestion_CtID
         , HFit_HealthAssesmentUserQuestion_CHANGE_OPERATION
         , HFit_HealthAssesmentUserQuestionGroupResults_CtID
         , HFit_HealthAssesmentUserQuestionGroupResults_CHANGE_OPERATION
         , HFit_HealthAssesmentUserRiskArea_CtID
         , HFit_HealthAssesmentUserRiskArea_CHANGE_OPERATION
         , HFit_HealthAssesmentUserRiskCategory_CtID
         , HFit_HealthAssesmentUserRiskCategory_CHANGE_OPERATION
         , HFit_HealthAssesmentUserStarted_CtID
         , HFit_HealthAssesmentUserStarted_CHANGE_OPERATION
         , CT_CMS_User_SCV
         , CT_CMS_UserSettings_SCV
         , CT_CMS_Site_SCV
         , CT_CMS_UserSite_SCV
         , CT_HFit_Account_SCV
         , CT_HFit_HealthAssesmentUserAnswers_SCV
         , CT_HFit_HealthAssesmentUserModule_SCV
         , CT_HFit_HealthAssesmentUserQuestionGroupResults_SCV
         , CT_HFit_HealthAssesmentUserRiskArea_SCV
         , CT_HFit_HealthAssesmentUserRiskCategory_SCV
         , CT_HFit_HealthAssesmentUserStarted_SCV
         , CT_HFit_HealthAssesmentUserQuestion_SCV
         , ConvertedToCentralTime
         , LastModifiedDate
         , RowNbr
         , DeletedFlg
         , TimeZone
         , PKHashCode) 
    SELECT
           T.UserStartedItemID
         , T.HealthAssesmentUserStartedNodeGUID
         , T.UserID
         , T.UserGUID
         , T.HFitUserMpiNumber
         , T.SiteGUID
         , T.AccountID
         , T.AccountCD
         , T.AccountName
         , T.HAStartedDt
         , T.HACompletedDt
         , T.UserModuleItemId
         , T.UserModuleCodeName
         , T.HAModuleNodeGUID
         , T.CMSNodeGuid
         , T.HAModuleVersionID
         , T.UserRiskCategoryItemID
         , T.UserRiskCategoryCodeName
         , T.HARiskCategoryNodeGUID
         , T.HARiskCategoryVersionID
         , T.UserRiskAreaItemID
         , T.UserRiskAreaCodeName
         , T.HARiskAreaNodeGUID
         , T.HARiskAreaVersionID
         , T.UserQuestionItemID
         , T.Title
         , T.HAQuestionGuid
         , T.UserQuestionCodeName
         , T.HAQuestionDocumentID
         , T.HAQuestionVersionID
         , T.HAQuestionNodeGUID
         , T.UserAnswerItemID
         , T.HAAnswerNodeGUID
         , T.HAAnswerVersionID
         , T.UserAnswerCodeName
         , T.HAAnswerValue
         , T.HAModuleScore
         , T.HARiskCategoryScore
         , T.HARiskAreaScore
         , T.HAQuestionScore
         , T.HAAnswerPoints
         , T.PointResults
         , T.UOMCode
         , T.HAScore
         , T.ModulePreWeightedScore
         , T.RiskCategoryPreWeightedScore
         , T.RiskAreaPreWeightedScore
         , T.QuestionPreWeightedScore
         , T.QuestionGroupCodeName
         , T.ItemCreatedWhen
         , T.ItemModifiedWhen
         , T.IsProfessionallyCollected
         , T.HARiskCategory_ItemModifiedWhen
         , T.HAUserRiskArea_ItemModifiedWhen
         , T.HAUserQuestion_ItemModifiedWhen
         , T.HAUserAnswers_ItemModifiedWhen
         , T.HAPaperFlg
         , T.HATelephonicFlg
         , T.HAStartedMode
         , T.HACompletedMode
         , T.DocumentCulture_VHCJ
         , T.DocumentCulture_HAQuestionsView
         , T.CampaignNodeGUID
         , T.HACampaignID
         , T.HashCode
         , T.ChangeType
         , T.CHANGED_FLG
         , T.DeleteFlg
         , T.CT_CMS_User_UserID
         , T.CT_CMS_User_CHANGE_OPERATION
         , T.CT_UserSettingsID
         , T.CT_UserSettingsID_CHANGE_OPERATION
         , T.SiteID_CtID
         , T.SiteID_CHANGE_OPERATION
         , T.UserSiteID_CtID
         , T.UserSiteID_CHANGE_OPERATION
         , T.AccountID_CtID
         , T.AccountID__CHANGE_OPERATION
         , T.HAUserAnswers_CtID
         , T.HAUserAnswers_CHANGE_OPERATION
         , T.HFit_HealthAssesmentUserModule_CtID
         , T.HFit_HealthAssesmentUserModule_CHANGE_OPERATION
         , T.HFit_HealthAssesmentUserQuestion_CtID
         , T.HFit_HealthAssesmentUserQuestion_CHANGE_OPERATION
         , T.HFit_HealthAssesmentUserQuestionGroupResults_CtID
         , T.HFit_HealthAssesmentUserQuestionGroupResults_CHANGE_OPERATION
         , T.HFit_HealthAssesmentUserRiskArea_CtID
         , T.HFit_HealthAssesmentUserRiskArea_CHANGE_OPERATION
         , T.HFit_HealthAssesmentUserRiskCategory_CtID
         , T.HFit_HealthAssesmentUserRiskCategory_CHANGE_OPERATION
         , T.HFit_HealthAssesmentUserStarted_CtID
         , T.HFit_HealthAssesmentUserStarted_CHANGE_OPERATION
         , T.CT_CMS_User_SCV
         , T.CT_CMS_UserSettings_SCV
         , T.CT_CMS_Site_SCV
         , T.CT_CMS_UserSite_SCV
         , T.CT_HFit_Account_SCV
         , T.CT_HFit_HealthAssesmentUserAnswers_SCV
         , T.CT_HFit_HealthAssesmentUserModule_SCV
         , T.CT_HFit_HealthAssesmentUserQuestionGroupResults_SCV
         , T.CT_HFit_HealthAssesmentUserRiskArea_SCV
         , T.CT_HFit_HealthAssesmentUserRiskCategory_SCV
         , T.CT_HFit_HealthAssesmentUserStarted_SCV
         , T.CT_HFit_HealthAssesmentUserQuestion_SCV
         , T.ConvertedToCentralTime
         , T.LastModifiedDate
         , T.RowNbr
         , T.DeletedFlg
         , T.TimeZone
         , T.PKHashCode
           FROM
                TEMP_EDW_HealthAssessment_DATA AS T
                     JOIN #XXX AS S
                     ON
                        S.UserStartedItemID = T.UserStartedItemID AND
                        S.UserGUID = T.UserGUID AND
                        S.PKHashCode = T.PKHashCode;

DECLARE
@iInserted AS int = @@ROWCOUNT;
PRINT '**Inserted Rows: ' + CAST ( @iInserted AS nvarchar (50)) ;

/*-----------------------------------------------------------------------------------------------
*************************************************************************************************
*/

DECLARE
@iCntAfterInsert AS int = 0;

SET @iCntAfterInsert = ( SELECT
                                COUNT ( *) 
                                FROM FACT_MART_EDW_HealthAssesment) ;

PRINT 'Staging Record Count After Insert: ' + CAST ( @iCntAfterInsert AS nvarchar (50)) ;
PRINT 'New Records found: ' + CAST ( @iCntAfterInsert - @iCntBeforeInsert AS nvarchar (50)) ;
PRINT '*********************************************************************';
IF @iCntAfterInsert - @iCntBeforeInsert = 0

    BEGIN
        PRINT 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX';
        PRINT 'ERROR: New inserts not found';
    END;
ELSE
    BEGIN
        PRINT 'PASSED INSERT TEST.';
    END;
PRINT '*********************************************************************';
RAISERROR ( 'PRINT Check' , 10 , 1) WITH NOWAIT;

/*--------------------------------------------------------
********************************************************
Remove the newly added test records 
NOTE: This statement will have to be tailored for each use
********************************************************
*/

DELETE FROM TEMP_EDW_HealthAssessment_DATA
       WHERE
             UserID < 0;

PRINT '#Test Records removed: ' + CAST ( @@ROWCOUNT AS nvarchar (50)) ;

/*---------------------------------------------------------
*********************************************************
***********************************************************
Now, let's make totally certain deleted records are found.
***********************************************************
*********************************************************
*/

DELETE FROM TEMP_EDW_HealthAssessment_DATA
       WHERE
             PkHashCode IN
             ( SELECT TOP 10
                      T.PkHashCode
                      FROM
                           TEMP_EDW_HealthAssessment_DATA AS T
                                JOIN FACT_MART_EDW_HealthAssesment AS S
                                ON T.PkHashCode = S.PkHashCode) ;

DECLARE
@iCntBeforeDEL AS int = 0
,@EndingCount AS bigint = 0;

SET @iCntBeforeDEL = ( SELECT
                              COUNT ( *) 
                              FROM FACT_MART_EDW_HealthAssesment
                              WHERE DeletedFlg IS NULL) ;

PRINT 'Counting Staging Records Before Delete: ' + CAST ( @iCntBeforeDEL AS nvarchar (50)) ;
RAISERROR ( 'PRINT Check' , 10 , 1) WITH NOWAIT;

EXEC proc_STAGING_EDW_HA_Changes;

SET @EndingCount = ( SELECT
                            COUNT ( *) 
                            FROM FACT_MART_EDW_HealthAssesment
                            WHERE DeletedFlg IS NULL) ;

PRINT 'Staging Record Count After Insert: ' + CAST ( @EndingCount AS nvarchar (50)) ;

PRINT 'New Records found: ' + CAST ( @iCntBeforeDEL - @EndingCount AS nvarchar (50)) ;

PRINT '*********************************************************************';
RAISERROR ( 'PRINT Check' , 10 , 1) WITH NOWAIT;

IF @iCntBeforeDEL - @EndingCount = 0
    BEGIN
        PRINT 'ERROR: DELETES not found';
    END;
ELSE
    BEGIN
        PRINT 'PASSED DELETE TEST';
    END;

PRINT '*********************************************************************';

/*----------------------------------------------------------------------------------------
********ENABLE ANY JOBS THAT WERE DISABLED    ********************************************
*/

--SET @NewJname = @JNAME + ' -- Disabled';
--SET @NewJdesc = @JNAME + ' disabled during TESTING.';
--EXEC dbo.sp_update_job
--@job_name = @JNAME ,
--@new_name = @NewJname ,
--@description = @NewJdesc ,
--@enabled = 0;
PRINT '*********************************** NOTICE ****************************************';
PRINT @JNAME + ' RE-ENABLED.';
PRINT '*********************************** NOTICE ****************************************';

/*----------------------------------------------------------------------------------------
******************************************************************************************
*/

SELECT
       *
       FROM EDW_CT_ExecutionLog
       WHERE CT_NAME = 'proc_STAGING_EDW_HA_Changes'
       ORDER BY
                CT_Start DESC;
