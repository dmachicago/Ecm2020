
DECLARE @MissingProcs AS INTEGER = 0;
IF NOT EXISTS (SELECT
                      database_id
                      FROM sys.change_tracking_databases
                      WHERE database_id = DB_ID ('KenticoCMS_DataMart')) 
    BEGIN
        DECLARE @MySql AS NVARCHAR (2000) = '';
        PRINT 'ENABLED CHANGE TRACKING ON: KenticoCMS_DataMart';
        SET @MySql = 'ALTER DATABASE KenticoCMS_DataMart SET CHANGE_TRACKING = ON (CHANGE_RETENTION = 2 DAYS, AUTO_CLEANUP = ON) ';
        EXEC (@MySql) ;
    END;
IF NOT EXISTS ( SELECT
                       name
                       FROM sys.procedures
                       WHERE name = 'proc_GetTableColumnsNoIdentity') 
    BEGIN
        PRINT 'MISSING proc_GetTableColumnsNoIdentity';
        SET @MissingProcs = 1;
    END;
IF NOT EXISTS ( SELECT
                       name
                       FROM sys.procedures
                       WHERE name = 'proc_FACT_GetMaxCTVersionNbr') 
    BEGIN
        PRINT 'MISSING proc_FACT_GetMaxCTVersionNbr';
        SET @MissingProcs = 1;
    END;
IF NOT EXISTS ( SELECT
                       name
                       FROM sys.procedures
                       WHERE name = 'proc_FACT_SaveCurrCTVersionNbr') 
    BEGIN
        PRINT 'MISSING proc_FACT_SaveCurrCTVersionNbr';
        SET @MissingProcs = 1;
    END;
IF NOT EXISTS (SELECT
                      name
                      FROM sys.tables
                      WHERE name = 'PERFMON_PullTime_DEL') 
    BEGIN
        PRINT 'MISSING table PERFMON_PullTime_DEL';
        SET @MissingProcs = 1;
    END;
IF @MissingProcs = 1
    BEGIN
        RETURN;
    END;
GO
-- DBCC FREEPROCCACHE
GO

EXEC proc_EnableChangeTracking 'KenticoCMS_1';
GO
EXEC proc_EnableChangeTracking 'KenticoCMS_2';
GO
EXEC proc_EnableChangeTracking 'KenticoCMS_3';
GO

DECLARE @SkipParm AS  INT = 0;

IF @SkipParm = 0
    BEGIN
        truncate TABLE PERFMON_PullTime_HIST;
    END;

DBCC FREEPROCCACHE;
--EXEC proc_CreateFactTable  @InstanceName = 'KenticoCMS_1', @TblName = 'View_EDW_HealthAssesmentQuestions', @SkipIfExists = 1;
--EXEC proc_CreateFactTable  @InstanceName = 'KenticoCMS_1', @TblName = 'View_HFit_HACampaign_Joined', @SkipIfExists = 1;

EXEC proc_CreateFactTable  @InstanceName = 'KenticoCMS_1', @TblName = 'HFit_RewardLevel', @SkipIfExists = @SkipParm;
EXEC proc_CreateFactTable  @InstanceName = 'KenticoCMS_2', @TblName = 'HFit_RewardLevel', @SkipIfExists = 1;
EXEC proc_CreateFactTable  @InstanceName = 'KenticoCMS_3', @TblName = 'HFit_RewardLevel', @SkipIfExists = 1;

EXEC proc_CreateFactTable  @InstanceName = 'KenticoCMS_1', @TblName = 'HFit_HealthAssessmentFreeForm', @SkipIfExists = @SkipParm;
EXEC proc_CreateFactTable  @InstanceName = 'KenticoCMS_2', @TblName = 'HFit_HealthAssessmentFreeForm', @SkipIfExists = 1;
EXEC proc_CreateFactTable  @InstanceName = 'KenticoCMS_3', @TblName = 'HFit_HealthAssessmentFreeForm', @SkipIfExists = 1;

EXEC proc_CreateFactTable  @InstanceName = 'KenticoCMS_1', @TblName = 'HFit_HealthAssesmentMultipleChoiceQuestion', @SkipIfExists = @SkipParm;
EXEC proc_CreateFactTable  @InstanceName = 'KenticoCMS_2', @TblName = 'HFit_HealthAssesmentMultipleChoiceQuestion', @SkipIfExists = 1;
EXEC proc_CreateFactTable  @InstanceName = 'KenticoCMS_3', @TblName = 'HFit_HealthAssesmentMultipleChoiceQuestion', @SkipIfExists = 1;

EXEC proc_CreateFactTable  @InstanceName = 'KenticoCMS_1', @TblName = 'CMS_Class', @SkipIfExists = @SkipParm;
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_1', @TblName = 'CMS_Document', @SkipIfExists = @SkipParm;
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_1', @TblName = 'CMS_Site', @SkipIfExists = @SkipParm;
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_1', @TblName = 'CMS_Tree', @SkipIfExists = @SkipParm;
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_1', @TblName = 'cms_user', @SkipIfExists = @SkipParm;
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_1', @TblName = 'cms_usersettings', @SkipIfExists = @SkipParm;
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_1', @TblName = 'cms_usersite', @SkipIfExists = @SkipParm;
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_1', @TblName = 'COM_SKU', @SkipIfExists = @SkipParm;
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_1', @TblName = 'HFit_Account', @SkipIfExists = @SkipParm;
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_1', @TblName = 'HFit_CoachingHealthArea', @SkipIfExists = @SkipParm;
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_1', @TblName = 'HFit_CoachingHealthInterest', @SkipIfExists = @SkipParm;
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_1', @TblName = 'HFit_HACampaign', @SkipIfExists = @SkipParm;
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_1', @TblName = 'HFit_HealthAssesmentMatrixQuestion', @SkipIfExists = @SkipParm;
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_1', @TblName = 'HFit_HealthAssesmentModule', @SkipIfExists = @SkipParm;
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_1', @TblName = 'HFit_HealthAssesmentMultipleChoiceQuestion', @SkipIfExists = @SkipParm;
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_1', @TblName = 'HFit_HealthAssesmentRiskArea', @SkipIfExists = @SkipParm;
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_1', @TblName = 'HFit_HealthAssesmentRiskCategory', @SkipIfExists = @SkipParm;
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_1', @TblName = 'HFit_HealthAssesmentUserAnswers', @SkipIfExists = @SkipParm;
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_1', @TblName = 'HFit_HealthAssesmentUserModule', @SkipIfExists = @SkipParm;
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_1', @TblName = 'HFit_HealthAssesmentUserQuestion', @SkipIfExists = @SkipParm;
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_1', @TblName = 'HFit_HealthAssesmentUserQuestionGroupResults', @SkipIfExists = @SkipParm;
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_1', @TblName = 'HFit_HealthAssesmentUserRiskArea', @SkipIfExists = @SkipParm;
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_1', @TblName = 'HFit_HealthAssesmentUserRiskCategory', @SkipIfExists = @SkipParm;
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_1', @TblName = 'HFit_HealthAssesmentUserStarted', @SkipIfExists = @SkipParm;
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_1', @TblName = 'HFit_HealthAssessment', @SkipIfExists = @SkipParm;
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_1', @TblName = 'HFit_HealthAssessmentFreeForm', @SkipIfExists = @SkipParm;
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_1', @TblName = 'HFit_LKP_EDW_RejectMPI', @SkipIfExists = @SkipParm;
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_1', @TblName = 'HFit_LKP_RewardActivity', @SkipIfExists = @SkipParm;
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_1', @TblName = 'HFit_LKP_RewardLevelType', @SkipIfExists = @SkipParm;
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_1', @TblName = 'HFit_LKP_RewardTrigger', @SkipIfExists = @SkipParm;
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_1', @TblName = 'HFit_LKP_RewardType', @SkipIfExists = @SkipParm;
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_1', @TblName = 'HFit_LKP_TrackerVendor', @SkipIfExists = @SkipParm;
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_1', @TblName = 'HFit_OutComeMessages', @SkipIfExists = @SkipParm;
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_1', @TblName = 'hfit_PPTEligibility', @SkipIfExists = @SkipParm;
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_1', @TblName = 'HFit_RewardActivity', @SkipIfExists = @SkipParm;
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_1', @TblName = 'HFit_RewardException', @SkipIfExists = @SkipParm;
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_1', @TblName = 'HFit_RewardGroup', @SkipIfExists = @SkipParm;
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_1', @TblName = 'HFit_RewardLevel', @SkipIfExists = @SkipParm;
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_1', @TblName = 'HFit_RewardProgram', @SkipIfExists = @SkipParm;
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_1', @TblName = 'HFit_RewardsUserActivityDetail', @SkipIfExists = @SkipParm;
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_1', @TblName = 'HFit_RewardsUserLevelDetail', @SkipIfExists = @SkipParm;
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_1', @TblName = 'HFit_RewardTrigger', @SkipIfExists = @SkipParm;
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_1', @TblName = 'HFit_RewardTriggerParameter', @SkipIfExists = @SkipParm;
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_1', @TblName = 'Hfit_SmallStepResponses', @SkipIfExists = @SkipParm;
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_1', @TblName = 'HFit_ToDoSmallSteps', @SkipIfExists = @SkipParm;
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_1', @TblName = 'HFIT_Tracker', @SkipIfExists = @SkipParm;
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_1', @TblName = 'HFit_TrackerBloodPressure', @SkipIfExists = @SkipParm;
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_1', @TblName = 'HFit_TrackerBloodSugarAndGlucose', @SkipIfExists = @SkipParm;
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_1', @TblName = 'HFit_TrackerBMI', @SkipIfExists = @SkipParm;
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_1', @TblName = 'HFit_TrackerBodyFat', @SkipIfExists = @SkipParm;
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_1', @TblName = 'HFit_TrackerBodyMeasurements', @SkipIfExists = @SkipParm;
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_1', @TblName = 'HFit_TrackerCardio', @SkipIfExists = @SkipParm;
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_1', @TblName = 'HFit_TrackerCholesterol', @SkipIfExists = @SkipParm;
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_1', @TblName = 'HFit_TrackerCollectionSource', @SkipIfExists = @SkipParm;
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_1', @TblName = 'HFit_TrackerCotinine', @SkipIfExists = @SkipParm;
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_1', @TblName = 'HFit_TrackerDailySteps', @SkipIfExists = @SkipParm;
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_1', @TblName = 'HFit_TrackerDef_Tracker', @SkipIfExists = @SkipParm;
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_1', @TblName = 'HFit_TrackerFlexibility', @SkipIfExists = @SkipParm;
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_1', @TblName = 'HFit_TrackerFruits', @SkipIfExists = @SkipParm;
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_1', @TblName = 'HFit_TrackerHbA1c', @SkipIfExists = @SkipParm;
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_1', @TblName = 'HFit_TrackerHeight', @SkipIfExists = @SkipParm;
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_1', @TblName = 'HFit_TrackerHighFatFoods', @SkipIfExists = @SkipParm;
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_1', @TblName = 'HFit_TrackerHighSodiumFoods', @SkipIfExists = @SkipParm;
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_1', @TblName = 'HFit_TrackerInstance_Tracker', @SkipIfExists = @SkipParm;
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_1', @TblName = 'HFit_TrackerMealPortions', @SkipIfExists = @SkipParm;
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_1', @TblName = 'HFit_TrackerMedicalCarePlan', @SkipIfExists = @SkipParm;
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_1', @TblName = 'HFit_TrackerPreventiveCare', @SkipIfExists = @SkipParm;
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_1', @TblName = 'HFit_TrackerRegularMeals', @SkipIfExists = @SkipParm;
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_1', @TblName = 'HFit_TrackerRestingHeartRate', @SkipIfExists = @SkipParm;
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_1', @TblName = 'HFit_TrackerShots', @SkipIfExists = @SkipParm;
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_1', @TblName = 'HFit_TrackerSitLess', @SkipIfExists = @SkipParm;
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_1', @TblName = 'HFit_TrackerSleepPlan', @SkipIfExists = @SkipParm;
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_1', @TblName = 'HFit_TrackerStrength', @SkipIfExists = @SkipParm;
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_1', @TblName = 'HFit_TrackerStress', @SkipIfExists = @SkipParm;
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_1', @TblName = 'HFit_TrackerStressManagement', @SkipIfExists = @SkipParm;
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_1', @TblName = 'HFit_TrackerSugaryDrinks', @SkipIfExists = @SkipParm;
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_1', @TblName = 'HFit_TrackerSugaryFoods', @SkipIfExists = @SkipParm;
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_1', @TblName = 'HFit_TrackerTests', @SkipIfExists = @SkipParm;
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_1', @TblName = 'HFit_TrackerTobaccoAttestation', @SkipIfExists = @SkipParm;
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_1', @TblName = 'HFit_TrackerTobaccoFree', @SkipIfExists = @SkipParm;
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_1', @TblName = 'HFit_TrackerVegetables', @SkipIfExists = @SkipParm;
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_1', @TblName = 'HFit_TrackerWater', @SkipIfExists = @SkipParm;
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_1', @TblName = 'HFit_TrackerWeight', @SkipIfExists = @SkipParm;
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_1', @TblName = 'HFit_TrackerWholeGrains', @SkipIfExists = @SkipParm;
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_1', @TblName = 'HFit_UserTracker', @SkipIfExists = @SkipParm;

GO
EXEC proc_CreateFactTable  @InstanceName = 'KenticoCMS_2', @TblName = 'CMS_Class', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_2', @TblName = 'CMS_Document', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_2', @TblName = 'CMS_Site', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_2', @TblName = 'CMS_Tree', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_2', @TblName = 'cms_user', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_2', @TblName = 'cms_usersettings', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_2', @TblName = 'cms_usersite', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_2', @TblName = 'COM_SKU', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_2', @TblName = 'HFit_Account', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_2', @TblName = 'HFit_CoachingHealthArea', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_2', @TblName = 'HFit_CoachingHealthInterest', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_2', @TblName = 'HFit_HACampaign', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_2', @TblName = 'HFit_HealthAssesmentMatrixQuestion', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_2', @TblName = 'HFit_HealthAssesmentModule', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_2', @TblName = 'HFit_HealthAssesmentMultipleChoiceQuestion', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_2', @TblName = 'HFit_HealthAssesmentRiskArea', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_2', @TblName = 'HFit_HealthAssesmentRiskCategory', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_2', @TblName = 'HFit_HealthAssesmentUserAnswers', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_2', @TblName = 'HFit_HealthAssesmentUserModule', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_2', @TblName = 'HFit_HealthAssesmentUserQuestion', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_2', @TblName = 'HFit_HealthAssesmentUserQuestionGroupResults', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_2', @TblName = 'HFit_HealthAssesmentUserRiskArea', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_2', @TblName = 'HFit_HealthAssesmentUserRiskCategory', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_2', @TblName = 'HFit_HealthAssesmentUserStarted', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_2', @TblName = 'HFit_HealthAssessment', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_2', @TblName = 'HFit_HealthAssessmentFreeForm', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_2', @TblName = 'HFit_LKP_EDW_RejectMPI', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_2', @TblName = 'HFit_LKP_RewardActivity', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_2', @TblName = 'HFit_LKP_RewardLevelType', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_2', @TblName = 'HFit_LKP_RewardTrigger', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_2', @TblName = 'HFit_LKP_RewardType', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_2', @TblName = 'HFit_LKP_TrackerVendor', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_2', @TblName = 'HFit_OutComeMessages', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_2', @TblName = 'hfit_PPTEligibility', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_2', @TblName = 'HFit_RewardActivity', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_2', @TblName = 'HFit_RewardException', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_2', @TblName = 'HFit_RewardGroup', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_2', @TblName = 'HFit_RewardLevel', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_2', @TblName = 'HFit_RewardProgram', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_2', @TblName = 'HFit_RewardsUserActivityDetail', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_2', @TblName = 'HFit_RewardsUserLevelDetail', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_2', @TblName = 'HFit_RewardTrigger', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_2', @TblName = 'HFit_RewardTriggerParameter', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_2', @TblName = 'Hfit_SmallStepResponses', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_2', @TblName = 'HFit_ToDoSmallSteps', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_2', @TblName = 'HFIT_Tracker', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_2', @TblName = 'HFit_TrackerBloodPressure', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_2', @TblName = 'HFit_TrackerBloodSugarAndGlucose', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_2', @TblName = 'HFit_TrackerBMI', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_2', @TblName = 'HFit_TrackerBodyFat', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_2', @TblName = 'HFit_TrackerBodyMeasurements', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_2', @TblName = 'HFit_TrackerCardio', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_2', @TblName = 'HFit_TrackerCholesterol', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_2', @TblName = 'HFit_TrackerCollectionSource', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_2', @TblName = 'HFit_TrackerCotinine', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_2', @TblName = 'HFit_TrackerDailySteps', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_2', @TblName = 'HFit_TrackerDef_Tracker', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_2', @TblName = 'HFit_TrackerFlexibility', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_2', @TblName = 'HFit_TrackerFruits', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_2', @TblName = 'HFit_TrackerHbA1c', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_2', @TblName = 'HFit_TrackerHeight', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_2', @TblName = 'HFit_TrackerHighFatFoods', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_2', @TblName = 'HFit_TrackerHighSodiumFoods', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_2', @TblName = 'HFit_TrackerInstance_Tracker', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_2', @TblName = 'HFit_TrackerMealPortions', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_2', @TblName = 'HFit_TrackerMedicalCarePlan', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_2', @TblName = 'HFit_TrackerPreventiveCare', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_2', @TblName = 'HFit_TrackerRegularMeals', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_2', @TblName = 'HFit_TrackerRestingHeartRate', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_2', @TblName = 'HFit_TrackerShots', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_2', @TblName = 'HFit_TrackerSitLess', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_2', @TblName = 'HFit_TrackerSleepPlan', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_2', @TblName = 'HFit_TrackerStrength', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_2', @TblName = 'HFit_TrackerStress', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_2', @TblName = 'HFit_TrackerStressManagement', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_2', @TblName = 'HFit_TrackerSugaryDrinks', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_2', @TblName = 'HFit_TrackerSugaryFoods', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_2', @TblName = 'HFit_TrackerTests', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_2', @TblName = 'HFit_TrackerTobaccoAttestation', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_2', @TblName = 'HFit_TrackerTobaccoFree', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_2', @TblName = 'HFit_TrackerVegetables', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_2', @TblName = 'HFit_TrackerWater', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_2', @TblName = 'HFit_TrackerWeight', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_2', @TblName = 'HFit_TrackerWholeGrains', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_2', @TblName = 'HFit_UserTracker', @SkipIfExists = 1;
GO

EXEC proc_CreateFactTable  @InstanceName = 'KenticoCMS_3', @TblName = 'CMS_Class', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_3', @TblName = 'CMS_Document', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_3', @TblName = 'CMS_Site', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_3', @TblName = 'CMS_Tree', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_3', @TblName = 'cms_user', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_3', @TblName = 'cms_usersettings', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_3', @TblName = 'cms_usersite', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_3', @TblName = 'COM_SKU', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_3', @TblName = 'HFit_Account', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_3', @TblName = 'HFit_CoachingHealthArea', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_3', @TblName = 'HFit_CoachingHealthInterest', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_3', @TblName = 'HFit_HACampaign', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_3', @TblName = 'HFit_HealthAssesmentMatrixQuestion', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_3', @TblName = 'HFit_HealthAssesmentModule', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_3', @TblName = 'HFit_HealthAssesmentMultipleChoiceQuestion', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_3', @TblName = 'HFit_HealthAssesmentRiskArea', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_3', @TblName = 'HFit_HealthAssesmentRiskCategory', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_3', @TblName = 'HFit_HealthAssesmentUserAnswers', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_3', @TblName = 'HFit_HealthAssesmentUserModule', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_3', @TblName = 'HFit_HealthAssesmentUserQuestion', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_3', @TblName = 'HFit_HealthAssesmentUserQuestionGroupResults', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_3', @TblName = 'HFit_HealthAssesmentUserRiskArea', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_3', @TblName = 'HFit_HealthAssesmentUserRiskCategory', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_3', @TblName = 'HFit_HealthAssesmentUserStarted', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_3', @TblName = 'HFit_HealthAssessment', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_3', @TblName = 'HFit_HealthAssessmentFreeForm', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_3', @TblName = 'HFit_LKP_EDW_RejectMPI', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_3', @TblName = 'HFit_LKP_RewardActivity', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_3', @TblName = 'HFit_LKP_RewardLevelType', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_3', @TblName = 'HFit_LKP_RewardTrigger', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_3', @TblName = 'HFit_LKP_RewardType', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_3', @TblName = 'HFit_LKP_TrackerVendor', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_3', @TblName = 'HFit_OutComeMessages', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_3', @TblName = 'hfit_PPTEligibility', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_3', @TblName = 'HFit_RewardActivity', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_3', @TblName = 'HFit_RewardException', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_3', @TblName = 'HFit_RewardGroup', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_3', @TblName = 'HFit_RewardLevel', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_3', @TblName = 'HFit_RewardProgram', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_3', @TblName = 'HFit_RewardsUserActivityDetail', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_3', @TblName = 'HFit_RewardsUserLevelDetail', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_3', @TblName = 'HFit_RewardTrigger', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_3', @TblName = 'HFit_RewardTriggerParameter', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_3', @TblName = 'Hfit_SmallStepResponses', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_3', @TblName = 'HFit_ToDoSmallSteps', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_3', @TblName = 'HFIT_Tracker', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_3', @TblName = 'HFit_TrackerBloodPressure', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_3', @TblName = 'HFit_TrackerBloodSugarAndGlucose', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_3', @TblName = 'HFit_TrackerBMI', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_3', @TblName = 'HFit_TrackerBodyFat', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_3', @TblName = 'HFit_TrackerBodyMeasurements', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_3', @TblName = 'HFit_TrackerCardio', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_3', @TblName = 'HFit_TrackerCholesterol', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_3', @TblName = 'HFit_TrackerCollectionSource', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_3', @TblName = 'HFit_TrackerCotinine', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_3', @TblName = 'HFit_TrackerDailySteps', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_3', @TblName = 'HFit_TrackerDef_Tracker', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_3', @TblName = 'HFit_TrackerFlexibility', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_3', @TblName = 'HFit_TrackerFruits', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_3', @TblName = 'HFit_TrackerHbA1c', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_3', @TblName = 'HFit_TrackerHeight', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_3', @TblName = 'HFit_TrackerHighFatFoods', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_3', @TblName = 'HFit_TrackerHighSodiumFoods', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_3', @TblName = 'HFit_TrackerInstance_Tracker', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_3', @TblName = 'HFit_TrackerMealPortions', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_3', @TblName = 'HFit_TrackerMedicalCarePlan', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_3', @TblName = 'HFit_TrackerPreventiveCare', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_3', @TblName = 'HFit_TrackerRegularMeals', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_3', @TblName = 'HFit_TrackerRestingHeartRate', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_3', @TblName = 'HFit_TrackerShots', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_3', @TblName = 'HFit_TrackerSitLess', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_3', @TblName = 'HFit_TrackerSleepPlan', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_3', @TblName = 'HFit_TrackerStrength', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_3', @TblName = 'HFit_TrackerStress', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_3', @TblName = 'HFit_TrackerStressManagement', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_3', @TblName = 'HFit_TrackerSugaryDrinks', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_3', @TblName = 'HFit_TrackerSugaryFoods', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_3', @TblName = 'HFit_TrackerTests', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_3', @TblName = 'HFit_TrackerTobaccoAttestation', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_3', @TblName = 'HFit_TrackerTobaccoFree', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_3', @TblName = 'HFit_TrackerVegetables', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_3', @TblName = 'HFit_TrackerWater', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_3', @TblName = 'HFit_TrackerWeight', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_3', @TblName = 'HFit_TrackerWholeGrains', @SkipIfExists = 1;
GO
EXEC proc_CreateFactTable @InstanceName = 'KenticoCMS_3', @TblName = 'HFit_UserTracker', @SkipIfExists = 1;
GO
