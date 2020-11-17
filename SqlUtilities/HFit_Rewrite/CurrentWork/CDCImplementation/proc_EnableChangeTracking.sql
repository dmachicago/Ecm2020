USE [KenticoCMS_DataMart_2]
GO

print 'Processing proc_EnableChangeTracking.SQL';
GO
if exists (select name from sys.procedures where name = 'proc_EnableChangeTracking')
DROP PROCEDURE [dbo].[proc_EnableChangeTracking]
GO

/****** Object:  StoredProcedure [dbo].[proc_EnableChangeTracking]    Script Date: 11/30/2015 9:48:20 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- exec proc_EnableChangeTracking 'KenticoCMS_1'
-- exec proc_EnableChangeTracking 'KenticoCMS_2'
-- exec proc_EnableChangeTracking 'KenticoCMS_3'
CREATE PROCEDURE [dbo].[proc_EnableChangeTracking] ( @DatabaseName AS nvarchar (100) )
AS
BEGIN
    DECLARE @DB AS nvarchar (100) = DB_NAME () ;
    DECLARE @MySql AS nvarchar (1000) = '';
    --DECLARE @DatabaseName AS nvarchar (2000) = 'KenticoCMS_2';

    IF NOT EXISTS (SELECT
                          database_id
                          FROM sys.change_tracking_databases
                          WHERE database_id = DB_ID (@DatabaseName)) 
        BEGIN
		  PRINT ('ENABLED CHANGE TRACKING ON: ' + @DatabaseName);
            SET @MySql = 'ALTER DATABASE ' + @DatabaseName + ' SET CHANGE_TRACKING = ON (CHANGE_RETENTION = 2 DAYS, AUTO_CLEANUP = ON) ';
            EXEC (@MySql) ;
        END;

    DECLARE @DBID AS int = 0;
    DECLARE @s AS nvarchar (2000) = '';
    
    EXEC proc_ChangeTracking  @DatabaseName, 'HFit_LKP_RewardTriggerParameterOperator', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'CMS_Class', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'CMS_Document', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'CMS_Site', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'CMS_Tree', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'cms_user', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'cms_usersettings', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'cms_usersite', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'COM_SKU', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'HFit_Account', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'HFit_CoachingHealthArea', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'HFit_CoachingHealthInterest', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'HFit_HACampaign', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'HFit_HealthAssesmentMatrixQuestion', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'HFit_HealthAssesmentModule', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'HFit_HealthAssesmentMultipleChoiceQuestion', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'HFit_HealthAssesmentRiskArea', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'HFit_HealthAssesmentRiskCategory', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'HFit_HealthAssesmentUserAnswers', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'HFit_HealthAssesmentUserModule', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'HFit_HealthAssesmentUserQuestion', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'HFit_HealthAssesmentUserQuestionGroupResults', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'HFit_HealthAssesmentUserRiskArea', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'HFit_HealthAssesmentUserRiskCategory', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'HFit_HealthAssesmentUserStarted', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'HFit_HealthAssessment', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'HFit_HealthAssessmentFreeForm', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'HFIT_LKP_EDW_REJECTMPI', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'HFit_LKP_RewardActivity', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'HFit_LKP_RewardLevelType', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'HFit_LKP_RewardTrigger', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'HFit_LKP_RewardType', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'HFit_LKP_TrackerVendor', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'HFit_OutComeMessages', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'hfit_PPTEligibility', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'HFit_RewardActivity', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'HFit_RewardException', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'HFit_RewardGroup', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'HFit_RewardLevel', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'HFit_RewardProgram', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'HFit_RewardsUserActivityDetail', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'HFit_RewardsUserLevelDetail', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'HFit_RewardTrigger', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'HFit_RewardTriggerParameter', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'Hfit_SmallStepResponses', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'HFit_ToDoSmallSteps', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'HFIT_Tracker', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'HFit_TrackerBloodPressure', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'HFit_TrackerBloodSugarAndGlucose', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'HFit_TrackerBMI', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'HFit_TrackerBodyFat', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'HFit_TrackerBodyMeasurements', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'HFit_TrackerCardio', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'HFit_TrackerCholesterol', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'HFit_TrackerCollectionSource', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'HFit_TrackerCotinine', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'HFit_TrackerDailySteps', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'HFit_TrackerDef_Tracker', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'HFit_TrackerFlexibility', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'HFit_TrackerFruits', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'HFit_TrackerHbA1c', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'HFit_TrackerHeight', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'HFit_TrackerHighFatFoods', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'HFit_TrackerHighSodiumFoods', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'HFit_TrackerInstance_Tracker', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'HFit_TrackerMealPortions', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'HFit_TrackerMedicalCarePlan', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'HFit_TrackerPreventiveCare', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'HFit_TrackerRegularMeals', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'HFit_TrackerRestingHeartRate', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'HFit_TrackerShots', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'HFit_TrackerSitLess', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'HFit_TrackerSleepPlan', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'HFit_TrackerStrength', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'HFit_TrackerStress', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'HFit_TrackerStressManagement', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'HFit_TrackerSugaryDrinks', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'HFit_TrackerSugaryFoods', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'HFit_TrackerTests', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'HFit_TrackerTobaccoAttestation', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'HFit_TrackerTobaccoFree', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'HFit_TrackerVegetables', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'HFit_TrackerWater', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'HFit_TrackerWeight', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'HFit_TrackerWholeGrains', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'HFit_UserTracker', 1;


    IF EXISTS (SELECT
                      job_id
                      FROM msdb.dbo.sysjobs_view
                      WHERE name = 'job_EDW_CT_HA_MarkDeletedRecords_KenticoCMS_1') 
        BEGIN
            EXEC msdb.dbo.sp_update_job @job_name = 'job_EDW_CT_HA_MarkDeletedRecords_KenticoCMS_1', @enabled = 1;
        END;

    IF EXISTS (SELECT
                      job_id
                      FROM msdb.dbo.sysjobs_view
                      WHERE name = 'job_EDW_CT_HA_MarkNewRecords_KenticoCMS_1') 
        BEGIN
            EXEC msdb.dbo.sp_update_job @job_name = 'job_EDW_CT_HA_MarkNewRecords_KenticoCMS_1', @enabled = 1;
        END;

    IF EXISTS (SELECT
                      job_id
                      FROM msdb.dbo.sysjobs_view
                      WHERE name = 'job_EDW_CT_HA_MarkUpdatedRecords_KenticoCMS_1') 
        BEGIN
            EXEC msdb.dbo.sp_update_job @job_name = 'job_EDW_CT_HA_MarkUpdatedRecords_KenticoCMS_1', @enabled = 1;
        END;

    IF EXISTS (SELECT
                      job_id
                      FROM msdb.dbo.sysjobs_view
                      WHERE name = 'job_EDW_Generate_BMI_Staging_Data_KenticoCMS_1') 
        BEGIN
            EXEC msdb.dbo.sp_update_job @job_name = 'job_EDW_Generate_BMI_Staging_Data_KenticoCMS_1', @enabled = 1;
        END;

    IF EXISTS (SELECT
                      job_id
                      FROM msdb.dbo.sysjobs_view
                      WHERE name = 'job_EDW_GetStagingData_BioMetrics_KenticoCMS_1') 
        BEGIN
            EXEC msdb.dbo.sp_update_job @job_name = 'job_EDW_GetStagingData_BioMetrics_KenticoCMS_1', @enabled = 1;
        END;

    IF EXISTS (SELECT
                      job_id
                      FROM msdb.dbo.sysjobs_view
                      WHERE name = 'job_EDW_GetStagingData_CMS_UserSettings_KenticoCMS_1') 
        BEGIN
            EXEC msdb.dbo.sp_update_job @job_name = 'job_EDW_GetStagingData_CMS_UserSettings_KenticoCMS_1', @enabled = 1;
        END;

    IF EXISTS (SELECT
                      job_id
                      FROM msdb.dbo.sysjobs_view
                      WHERE name = 'job_EDW_GetStagingData_CMS_UserSite_KenticoCMS_1') 
        BEGIN
            EXEC msdb.dbo.sp_update_job @job_name = 'job_EDW_GetStagingData_CMS_UserSite_KenticoCMS_1', @enabled = 1;
        END;

    IF EXISTS (SELECT
                      job_id
                      FROM msdb.dbo.sysjobs_view
                      WHERE name = 'job_EDW_GetStagingData_CoachingDetail_KenticoCMS_1') 
        BEGIN
            EXEC msdb.dbo.sp_update_job @job_name = 'job_EDW_GetStagingData_CoachingDetail_KenticoCMS_1', @enabled = 1;
        END;

    IF EXISTS (SELECT
                      job_id
                      FROM msdb.dbo.sysjobs_view
                      WHERE name = 'job_EDW_GetStagingData_CT_USER_KenticoCMS_1') 
        BEGIN
            EXEC msdb.dbo.sp_update_job @job_name = 'job_EDW_GetStagingData_CT_USER_KenticoCMS_1', @enabled = 1;
        END;

    IF EXISTS (SELECT
                      job_id
                      FROM msdb.dbo.sysjobs_view
                      WHERE name = 'job_EDW_GetStagingData_HA_KenticoCMS_1') 
        BEGIN
            EXEC msdb.dbo.sp_update_job @job_name = 'job_EDW_GetStagingData_HA_KenticoCMS_1', @enabled = 1;
        END;

    IF EXISTS (SELECT
                      job_id
                      FROM msdb.dbo.sysjobs_view
                      WHERE name = 'job_EDW_GetStagingData_HADefinition_KenticoCMS_1') 
        BEGIN
            EXEC msdb.dbo.sp_update_job @job_name = 'job_EDW_GetStagingData_HADefinition_KenticoCMS_1', @enabled = 1;
        END;

    IF EXISTS (SELECT
                      job_id
                      FROM msdb.dbo.sysjobs_view
                      WHERE name = 'job_EDW_GetStagingData_HFIT_PPTEligibility_KenticoCMS_1') 
        BEGIN
            EXEC msdb.dbo.sp_update_job @job_name = 'job_EDW_GetStagingData_HFIT_PPTEligibility_KenticoCMS_1', @enabled = 1;
        END;

    IF EXISTS (SELECT
                      job_id
                      FROM msdb.dbo.sysjobs_view
                      WHERE name = 'job_EDW_GetStagingData_RewardAwardDetail_KenticoCMS_1') 
        BEGIN
            EXEC msdb.dbo.sp_update_job @job_name = 'job_EDW_GetStagingData_RewardAwardDetail_KenticoCMS_1', @enabled = 1;
        END;

    IF EXISTS (SELECT
                      job_id
                      FROM msdb.dbo.sysjobs_view
                      WHERE name = 'job_EDW_GetStagingData_RewardsDefinition_KenticoCMS_1') 
        BEGIN
            EXEC msdb.dbo.sp_update_job @job_name = 'job_EDW_GetStagingData_RewardsDefinition_KenticoCMS_1', @enabled = 1;
        END;

    IF EXISTS (SELECT
                      job_id
                      FROM msdb.dbo.sysjobs_view
                      WHERE name = 'job_EDW_GetStagingData_RewardTriggerParameters_KenticoCMS_1') 
        BEGIN
            EXEC msdb.dbo.sp_update_job @job_name = 'job_EDW_GetStagingData_RewardTriggerParameters_KenticoCMS_1', @enabled = 1;
        END;

    IF EXISTS (SELECT
                      job_id
                      FROM msdb.dbo.sysjobs_view
                      WHERE name = 'job_EDW_GetStagingData_RewardUserDetail_KenticoCMS_1') 
        BEGIN
            EXEC msdb.dbo.sp_update_job @job_name = 'job_EDW_GetStagingData_RewardUserDetail_KenticoCMS_1', @enabled = 1;
        END;

    IF EXISTS (SELECT
                      job_id
                      FROM msdb.dbo.sysjobs_view
                      WHERE name = 'job_EDW_GetStagingData_RewardUserLevel_KenticoCMS_1') 
        BEGIN
            EXEC msdb.dbo.sp_update_job @job_name = 'job_EDW_GetStagingData_RewardUserLevel_KenticoCMS_1', @enabled = 1;
        END;

    IF EXISTS (SELECT
                      job_id
                      FROM msdb.dbo.sysjobs_view
                      WHERE name = 'job_EDW_GetStagingData_Trackers_KenticoCMS_1') 
        BEGIN
            EXEC msdb.dbo.sp_update_job @job_name = 'job_EDW_GetStagingData_Trackers_KenticoCMS_1', @enabled = 1;
        END;

    IF EXISTS (SELECT
                      job_id
                      FROM msdb.dbo.sysjobs_view
                      WHERE name = 'job_EDW_HA_Master_KenticoCMS_1') 
        BEGIN
            EXEC msdb.dbo.sp_update_job @job_name = 'job_EDW_HA_Master_KenticoCMS_1', @enabled = 1;
        END;
    PRINT 'Activated Change Tracking for EDW Views and tables';
END;


GO

print 'Processed proc_EnableChangeTracking.SQL';
GO
