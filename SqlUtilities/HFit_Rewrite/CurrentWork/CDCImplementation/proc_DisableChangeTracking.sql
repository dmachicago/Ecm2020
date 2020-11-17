--USE [KenticoCMS_Datamart_2]
GO
print 'Executing proc_DisableChangeTracking.sql'
go

if exists (select name from sys.procedures where name = 'proc_DisableChangeTracking') 
    DROP PROCEDURE [dbo].[proc_DisableChangeTracking]
GO

/****** Object:  StoredProcedure [dbo].[proc_DisableChangeTracking]    Script Date: 2/11/2016 9:20:05 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- exec proc_DisableChangeTracking 'KenticoCMS_1' ;
CREATE PROCEDURE [dbo].[proc_DisableChangeTracking] (@DatabaseName as nvarchar(100))
AS
BEGIN
    DECLARE @DB AS nvarchar (100) = @DatabaseName ;
    DECLARE @MySql AS nvarchar (1000) = '';
    DECLARE @DBID AS int = 0;
    DECLARE @s AS nvarchar (2000) = '';

    --declare @DatabaseName as nvarchar(100) = 'KenticoCMS_1' ;
    EXEC proc_ChangeTracking @DatabaseName, 'Hfit_SmallStepResponses', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'CMS_Class', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'CMS_Document', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'CMS_Site', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'CMS_Tree', 0;
    -- The below tables are used in Audit Tracking and cannot be removed from Change TRacking
    --EXEC proc_ChangeTracking @DatabaseName, 'cms_user', 0;
    --EXEC proc_ChangeTracking @DatabaseName, 'cms_usersettings', 0;
    --EXEC proc_ChangeTracking @DatabaseName, 'cms_usersite', 0;
    --EXEC proc_ChangeTracking @DatabaseName, 'hfit_ppteligibility', 0;    
    EXEC proc_ChangeTracking @DatabaseName, 'COM_SKU', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'HFit_Account', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'HFit_CoachingHealthArea', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'HFit_CoachingHealthInterest', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'HFit_HACampaign', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'HFit_HealthAssesmentMatrixQuestion', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'HFit_HealthAssesmentModule', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'HFit_HealthAssesmentMultipleChoiceQuestion', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'HFit_HealthAssesmentRiskArea', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'HFit_HealthAssesmentRiskCategory', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'HFit_HealthAssesmentUserAnswers', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'HFit_HealthAssesmentUserModule', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'HFit_HealthAssesmentUserQuestion', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'HFit_HealthAssesmentUserQuestionGroupResults', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'HFit_HealthAssesmentUserRiskArea', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'HFit_HealthAssesmentUserRiskCategory', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'HFit_HealthAssesmentUserStarted', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'HFit_HealthAssessment', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'HFit_HealthAssessmentFreeForm', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'HFit_LKP_EDW_RejectMPI', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'HFit_LKP_RewardActivity', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'HFit_LKP_RewardLevelType', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'HFit_LKP_RewardTrigger', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'HFit_LKP_RewardType', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'HFit_LKP_TrackerVendor', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'HFit_OutComeMessages', 0;    
    EXEC proc_ChangeTracking @DatabaseName, 'HFit_RewardActivity', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'HFit_RewardException', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'HFit_RewardGroup', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'HFit_RewardLevel', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'HFit_RewardProgram', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'HFit_RewardsUserActivityDetail', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'HFit_RewardsUserLevelDetail', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'HFit_RewardTrigger', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'HFit_RewardTriggerParameter', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'HFit_ToDoSmallSteps', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'HFIT_Tracker', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'HFit_TrackerBloodPressure', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'HFit_TrackerBloodSugarAndGlucose', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'HFit_TrackerBMI', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'HFit_TrackerBodyFat', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'HFit_TrackerBodyMeasurements', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'HFit_TrackerCardio', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'HFit_TrackerCholesterol', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'HFit_TrackerCollectionSource', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'HFit_TrackerCotinine', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'HFit_TrackerCotinine', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'HFit_TrackerDailySteps', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'HFit_TrackerDef_Tracker', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'HFit_TrackerFlexibility', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'HFit_TrackerFruits', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'HFit_TrackerHbA1c', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'HFit_TrackerHeight', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'HFit_TrackerHighFatFoods', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'HFit_TrackerHighSodiumFoods', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'HFit_TrackerInstance_Tracker', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'HFit_TrackerMealPortions', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'HFit_TrackerMedicalCarePlan', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'HFit_TrackerPreventiveCare', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'HFit_TrackerPreventiveCare', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'HFit_TrackerRegularMeals', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'HFit_TrackerRestingHeartRate', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'HFit_TrackerShots', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'HFit_TrackerSitLess', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'HFit_TrackerSleepPlan', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'HFit_TrackerStrength', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'HFit_TrackerStress', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'HFit_TrackerStressManagement', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'HFit_TrackerSugaryDrinks', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'HFit_TrackerSugaryFoods', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'HFit_TrackerTests', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'HFit_TrackerTobaccoAttestation', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'HFit_TrackerTobaccoFree', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'HFit_TrackerVegetables', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'HFit_TrackerWater', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'HFit_TrackerWeight', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'HFit_TrackerWholeGrains', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'HFit_UserTracker', 0;

    IF NOT EXISTS (SELECT
                          database_id
                          FROM sys.change_tracking_databases
                          WHERE database_id = DB_ID (@DB)) 
        BEGIN
            SET @MySql = 'ALTER DATABASE ' + @DB + ' SET CHANGE_TRACKING = OFF ';
            EXEC (@MySql) ;
        END;

    SELECT
           OBJECT_NAME (object_id) AS TABLE_NAME
           FROM sys.change_tracking_tables;

    IF EXISTS (SELECT
                      job_id
                      FROM msdb.dbo.sysjobs_view
                      WHERE name = 'job_EDW_CT_HA_MarkDeletedRecords_KenticoCMS_1') 
        BEGIN
            EXEC msdb.dbo.sp_update_job @job_name = 'job_EDW_CT_HA_MarkDeletedRecords_KenticoCMS_1', @enabled = 0;
        END;

    IF EXISTS (SELECT
                      job_id
                      FROM msdb.dbo.sysjobs_view
                      WHERE name = 'job_EDW_CT_HA_MarkNewRecords_KenticoCMS_1') 
        BEGIN
            EXEC msdb.dbo.sp_update_job @job_name = 'job_EDW_CT_HA_MarkNewRecords_KenticoCMS_1', @enabled = 0;
        END;

    IF EXISTS (SELECT
                      job_id
                      FROM msdb.dbo.sysjobs_view
                      WHERE name = 'job_EDW_CT_HA_MarkUpdatedRecords_KenticoCMS_1') 
        BEGIN
            EXEC msdb.dbo.sp_update_job @job_name = 'job_EDW_CT_HA_MarkUpdatedRecords_KenticoCMS_1', @enabled = 0;
        END;

    IF EXISTS (SELECT
                      job_id
                      FROM msdb.dbo.sysjobs_view
                      WHERE name = 'job_EDW_Generate_BMI_Staging_Data_KenticoCMS_1') 
        BEGIN
            EXEC msdb.dbo.sp_update_job @job_name = 'job_EDW_Generate_BMI_Staging_Data_KenticoCMS_1', @enabled = 0;
        END;

    IF EXISTS (SELECT
                      job_id
                      FROM msdb.dbo.sysjobs_view
                      WHERE name = 'job_EDW_GetStagingData_BioMetrics_KenticoCMS_1') 
        BEGIN
            EXEC msdb.dbo.sp_update_job @job_name = 'job_EDW_GetStagingData_BioMetrics_KenticoCMS_1', @enabled = 0;
        END;

    IF EXISTS (SELECT
                      job_id
                      FROM msdb.dbo.sysjobs_view
                      WHERE name = 'job_EDW_GetStagingData_CMS_UserSettings_KenticoCMS_1') 
        BEGIN
            EXEC msdb.dbo.sp_update_job @job_name = 'job_EDW_GetStagingData_CMS_UserSettings_KenticoCMS_1', @enabled = 0;
        END;

    IF EXISTS (SELECT
                      job_id
                      FROM msdb.dbo.sysjobs_view
                      WHERE name = 'job_EDW_GetStagingData_CMS_UserSite_KenticoCMS_1') 
        BEGIN
            EXEC msdb.dbo.sp_update_job @job_name = 'job_EDW_GetStagingData_CMS_UserSite_KenticoCMS_1', @enabled = 0;
        END;

    IF EXISTS (SELECT
                      job_id
                      FROM msdb.dbo.sysjobs_view
                      WHERE name = 'job_EDW_GetStagingData_CoachingDetail_KenticoCMS_1') 
        BEGIN
            EXEC msdb.dbo.sp_update_job @job_name = 'job_EDW_GetStagingData_CoachingDetail_KenticoCMS_1', @enabled = 0;
        END;

    IF EXISTS (SELECT
                      job_id
                      FROM msdb.dbo.sysjobs_view
                      WHERE name = 'job_EDW_GetStagingData_CT_USER_KenticoCMS_1') 
        BEGIN
            EXEC msdb.dbo.sp_update_job @job_name = 'job_EDW_GetStagingData_CT_USER_KenticoCMS_1', @enabled = 0;
        END;

    IF EXISTS (SELECT
                      job_id
                      FROM msdb.dbo.sysjobs_view
                      WHERE name = 'job_EDW_GetStagingData_HA_KenticoCMS_1') 
        BEGIN
            EXEC msdb.dbo.sp_update_job @job_name = 'job_EDW_GetStagingData_HA_KenticoCMS_1', @enabled = 0;
        END;

    IF EXISTS (SELECT
                      job_id
                      FROM msdb.dbo.sysjobs_view
                      WHERE name = 'job_EDW_GetStagingData_HADefinition_KenticoCMS_1') 
        BEGIN
            EXEC msdb.dbo.sp_update_job @job_name = 'job_EDW_GetStagingData_HADefinition_KenticoCMS_1', @enabled = 0;
        END;

    IF EXISTS (SELECT
                      job_id
                      FROM msdb.dbo.sysjobs_view
                      WHERE name = 'job_EDW_GetStagingData_HFIT_PPTEligibility_KenticoCMS_1') 
        BEGIN
            EXEC msdb.dbo.sp_update_job @job_name = 'job_EDW_GetStagingData_HFIT_PPTEligibility_KenticoCMS_1', @enabled = 0;
        END;

    IF EXISTS (SELECT
                      job_id
                      FROM msdb.dbo.sysjobs_view
                      WHERE name = 'job_EDW_GetStagingData_RewardAwardDetail_KenticoCMS_1') 
        BEGIN
            EXEC msdb.dbo.sp_update_job @job_name = 'job_EDW_GetStagingData_RewardAwardDetail_KenticoCMS_1', @enabled = 0;
        END;

    IF EXISTS (SELECT
                      job_id
                      FROM msdb.dbo.sysjobs_view
                      WHERE name = 'job_EDW_GetStagingData_RewardsDefinition_KenticoCMS_1') 
        BEGIN
            EXEC msdb.dbo.sp_update_job @job_name = 'job_EDW_GetStagingData_RewardsDefinition_KenticoCMS_1', @enabled = 0;
        END;

    IF EXISTS (SELECT
                      job_id
                      FROM msdb.dbo.sysjobs_view
                      WHERE name = 'job_EDW_GetStagingData_RewardTriggerParameters_KenticoCMS_1') 
        BEGIN
            EXEC msdb.dbo.sp_update_job @job_name = 'job_EDW_GetStagingData_RewardTriggerParameters_KenticoCMS_1', @enabled = 0;
        END;

    IF EXISTS (SELECT
                      job_id
                      FROM msdb.dbo.sysjobs_view
                      WHERE name = 'job_EDW_GetStagingData_RewardUserDetail_KenticoCMS_1') 
        BEGIN
            EXEC msdb.dbo.sp_update_job @job_name = 'job_EDW_GetStagingData_RewardUserDetail_KenticoCMS_1', @enabled = 0;
        END;

    IF EXISTS (SELECT
                      job_id
                      FROM msdb.dbo.sysjobs_view
                      WHERE name = 'job_EDW_GetStagingData_RewardUserLevel_KenticoCMS_1') 
        BEGIN
            EXEC msdb.dbo.sp_update_job @job_name = 'job_EDW_GetStagingData_RewardUserLevel_KenticoCMS_1', @enabled = 0;
        END;

    IF EXISTS (SELECT
                      job_id
                      FROM msdb.dbo.sysjobs_view
                      WHERE name = 'job_EDW_GetStagingData_Trackers_KenticoCMS_1') 
        BEGIN
            EXEC msdb.dbo.sp_update_job @job_name = 'job_EDW_GetStagingData_Trackers_KenticoCMS_1', @enabled = 0;
        END;

    IF EXISTS (SELECT
                      job_id
                      FROM msdb.dbo.sysjobs_view
                      WHERE name = 'job_EDW_HA_Master_KenticoCMS_1') 
        BEGIN
            EXEC msdb.dbo.sp_update_job @job_name = 'job_EDW_HA_Master_KenticoCMS_1', @enabled = 0;
        END;

END;


GO


GO
print 'Executed proc_DisableChangeTracking.sql'
go
