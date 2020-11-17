
GO
PRINT 'Creating Proc_EDW_Compare_MASTER';
GO
IF EXISTS (SELECT
				  name
			 FROM sys.procedures
			 WHERE name = 'Proc_EDW_Compare_MASTER') 
	BEGIN
		DROP PROCEDURE
			 Proc_EDW_Compare_MASTER;
	END;
GO
CREATE PROC Proc_EDW_Compare_MASTER (@LinkedSVR AS nvarchar (254) 
								   , @LinkedDB AS nvarchar (254) 
								   , @CurrDB AS nvarchar (254)) 
AS
	 BEGIN
		 DECLARE @LinkedVIEW AS nvarchar (254) ;
		 DECLARE @CurrVIEW AS nvarchar (254) ;
		 DECLARE @NewRun AS int = 0;
		 SET @LinkedVIEW = 'SchemaChangeMonitor';
		 SET @CurrVIEW = 'SchemaChangeMonitor';
		 SET @NewRun = 1;
		 SET @LinkedVIEW = 'CMS_Class';
		 SET @CurrVIEW = 'CMS_Class';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @NewRun = 0;
		 SET @LinkedVIEW = 'CMS_Document';
		 SET @CurrVIEW = 'CMS_Document';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'CMS_Site';
		 SET @CurrVIEW = 'CMS_Site';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'CMS_Tree';
		 SET @CurrVIEW = 'CMS_Tree';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'CMS_User';
		 SET @CurrVIEW = 'CMS_User';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'CMS_UserSettings';
		 SET @CurrVIEW = 'CMS_UserSettings';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'CMS_UserSite';
		 SET @CurrVIEW = 'CMS_UserSite';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'COM_SKU';
		 SET @CurrVIEW = 'COM_SKU';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'EDW_HealthAssessment';
		 SET @CurrVIEW = 'EDW_HealthAssessment';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'EDW_HealthAssessmentDefinition';
		 SET @CurrVIEW = 'EDW_HealthAssessmentDefinition';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_Account';
		 SET @CurrVIEW = 'HFit_Account';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_Coaches';
		 SET @CurrVIEW = 'HFit_Coaches';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_Company';
		 SET @CurrVIEW = 'HFit_Company';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_Goal';
		 SET @CurrVIEW = 'HFit_Goal';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_GoalOutcome';
		 SET @CurrVIEW = 'HFit_GoalOutcome';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_HACampaign';
		 SET @CurrVIEW = 'HFit_HACampaign';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_HealthAssesmentMatrixQuestion';
		 SET @CurrVIEW = 'HFit_HealthAssesmentMatrixQuestion';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_HealthAssesmentModule';
		 SET @CurrVIEW = 'HFit_HealthAssesmentModule';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_HealthAssesmentMultipleChoiceQuestion';
		 SET @CurrVIEW = 'HFit_HealthAssesmentMultipleChoiceQuestion';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_HealthAssesmentPredefinedAnswer';
		 SET @CurrVIEW = 'HFit_HealthAssesmentPredefinedAnswer';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_HealthAssesmentRiskArea';
		 SET @CurrVIEW = 'HFit_HealthAssesmentRiskArea';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_HealthAssesmentRiskCategory';
		 SET @CurrVIEW = 'HFit_HealthAssesmentRiskCategory';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_HealthAssesmentUserAnswers';
		 SET @CurrVIEW = 'HFit_HealthAssesmentUserAnswers';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_HealthAssesmentUserModule';
		 SET @CurrVIEW = 'HFit_HealthAssesmentUserModule';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_HealthAssesmentUserQuestion';
		 SET @CurrVIEW = 'HFit_HealthAssesmentUserQuestion';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_HealthAssesmentUserQuestionGroupResults';
		 SET @CurrVIEW = 'HFit_HealthAssesmentUserQuestionGroupResults';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_HealthAssesmentUserRiskArea';
		 SET @CurrVIEW = 'HFit_HealthAssesmentUserRiskArea';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_HealthAssesmentUserRiskCategory';
		 SET @CurrVIEW = 'HFit_HealthAssesmentUserRiskCategory';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_HealthAssesmentUserStarted';
		 SET @CurrVIEW = 'HFit_HealthAssesmentUserStarted';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_HealthAssessment';
		 SET @CurrVIEW = 'HFit_HealthAssessment';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_HealthAssessmentFreeForm';
		 SET @CurrVIEW = 'HFit_HealthAssessmentFreeForm';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_LKP_Frequency';
		 SET @CurrVIEW = 'HFit_LKP_Frequency';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_LKP_GoalStatus';
		 SET @CurrVIEW = 'HFit_LKP_GoalStatus';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_LKP_RewardLevelType';
		 SET @CurrVIEW = 'HFit_LKP_RewardLevelType';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_LKP_RewardTrigger';
		 SET @CurrVIEW = 'HFit_LKP_RewardTrigger';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_LKP_RewardTriggerParameterOperator';
		 SET @CurrVIEW = 'HFit_LKP_RewardTriggerParameterOperator';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_LKP_RewardType';
		 SET @CurrVIEW = 'HFit_LKP_RewardType';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_LKP_UnitOfMeasure';
		 SET @CurrVIEW = 'HFit_LKP_UnitOfMeasure';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'hfit_ppteligibility';
		 SET @CurrVIEW = 'hfit_ppteligibility';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_RewardActivity';
		 SET @CurrVIEW = 'HFit_RewardActivity';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_RewardException';
		 SET @CurrVIEW = 'HFit_RewardException';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_RewardGroup';
		 SET @CurrVIEW = 'HFit_RewardGroup';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_RewardLevel';
		 SET @CurrVIEW = 'HFit_RewardLevel';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_RewardProgram';
		 SET @CurrVIEW = 'HFit_RewardProgram';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_RewardsAwardUserDetail';
		 SET @CurrVIEW = 'HFit_RewardsAwardUserDetail';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_RewardsUserActivityDetail';
		 SET @CurrVIEW = 'HFit_RewardsUserActivityDetail';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_RewardsUserLevelDetail';
		 SET @CurrVIEW = 'HFit_RewardsUserLevelDetail';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_RewardTrigger';
		 SET @CurrVIEW = 'HFit_RewardTrigger';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_RewardTriggerParameter';
		 SET @CurrVIEW = 'HFit_RewardTriggerParameter';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_Tobacco_Goal';
		 SET @CurrVIEW = 'HFit_Tobacco_Goal';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFIT_Tracker';
		 SET @CurrVIEW = 'HFIT_Tracker';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_TrackerBloodPressure';
		 SET @CurrVIEW = 'HFit_TrackerBloodPressure';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_TrackerBloodSugarAndGlucose';
		 SET @CurrVIEW = 'HFit_TrackerBloodSugarAndGlucose';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_TrackerBMI';
		 SET @CurrVIEW = 'HFit_TrackerBMI';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_TrackerBodyFat';
		 SET @CurrVIEW = 'HFit_TrackerBodyFat';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_TrackerBodyMeasurements';
		 SET @CurrVIEW = 'HFit_TrackerBodyMeasurements';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_TrackerCardio';
		 SET @CurrVIEW = 'HFit_TrackerCardio';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_TrackerCholesterol';
		 SET @CurrVIEW = 'HFit_TrackerCholesterol';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_TrackerCollectionSource';
		 SET @CurrVIEW = 'HFit_TrackerCollectionSource';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_TrackerDailySteps';
		 SET @CurrVIEW = 'HFit_TrackerDailySteps';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_TrackerFlexibility';
		 SET @CurrVIEW = 'HFit_TrackerFlexibility';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_TrackerFruits';
		 SET @CurrVIEW = 'HFit_TrackerFruits';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_TrackerHbA1c';
		 SET @CurrVIEW = 'HFit_TrackerHbA1c';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_TrackerHeight';
		 SET @CurrVIEW = 'HFit_TrackerHeight';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_TrackerHighFatFoods';
		 SET @CurrVIEW = 'HFit_TrackerHighFatFoods';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_TrackerHighSodiumFoods';
		 SET @CurrVIEW = 'HFit_TrackerHighSodiumFoods';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_TrackerInstance_Tracker';
		 SET @CurrVIEW = 'HFit_TrackerInstance_Tracker';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_TrackerMealPortions';
		 SET @CurrVIEW = 'HFit_TrackerMealPortions';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_TrackerMedicalCarePlan';
		 SET @CurrVIEW = 'HFit_TrackerMedicalCarePlan';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_TrackerRegularMeals';
		 SET @CurrVIEW = 'HFit_TrackerRegularMeals';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_TrackerRestingHeartRate';
		 SET @CurrVIEW = 'HFit_TrackerRestingHeartRate';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_TrackerShots';
		 SET @CurrVIEW = 'HFit_TrackerShots';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_TrackerSitLess';
		 SET @CurrVIEW = 'HFit_TrackerSitLess';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_TrackerSleepPlan';
		 SET @CurrVIEW = 'HFit_TrackerSleepPlan';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_TrackerStrength';
		 SET @CurrVIEW = 'HFit_TrackerStrength';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_TrackerStress';
		 SET @CurrVIEW = 'HFit_TrackerStress';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_TrackerStressManagement';
		 SET @CurrVIEW = 'HFit_TrackerStressManagement';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_TrackerSugaryDrinks';
		 SET @CurrVIEW = 'HFit_TrackerSugaryDrinks';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_TrackerSugaryFoods';
		 SET @CurrVIEW = 'HFit_TrackerSugaryFoods';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_TrackerTests';
		 SET @CurrVIEW = 'HFit_TrackerTests';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_TrackerTobaccoFree';
		 SET @CurrVIEW = 'HFit_TrackerTobaccoFree';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_TrackerVegetables';
		 SET @CurrVIEW = 'HFit_TrackerVegetables';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_TrackerWater';
		 SET @CurrVIEW = 'HFit_TrackerWater';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_TrackerWeight';
		 SET @CurrVIEW = 'HFit_TrackerWeight';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_TrackerWholeGrains';
		 SET @CurrVIEW = 'HFit_TrackerWholeGrains';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_UserGoal';
		 SET @CurrVIEW = 'HFit_UserGoal';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'Tracker_EDW_Metadata';
		 SET @CurrVIEW = 'Tracker_EDW_Metadata';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'View_CMS_Tree_Joined';
		 SET @CurrVIEW = 'View_CMS_Tree_Joined';
		 EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'VIEW_CMS_Tree_Joined_Linked';
		 SET @CurrVIEW = 'VIEW_CMS_Tree_Joined_Linked';
		 EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'VIEW_CMS_Tree_Joined_Regular';
		 SET @CurrVIEW = 'VIEW_CMS_Tree_Joined_Regular';
		 EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'VIEW_COM_SKU';
		 SET @CurrVIEW = 'VIEW_COM_SKU';
		 EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'VIEW_EDW_ClientCompany';
		 SET @CurrVIEW = 'VIEW_EDW_ClientCompany';
		 EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'VIEW_EDW_Coaches';
		 SET @CurrVIEW = 'VIEW_EDW_Coaches';
		 EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'VIEW_EDW_CoachingDefinition';
		 SET @CurrVIEW = 'VIEW_EDW_CoachingDefinition';
		 EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'VIEW_EDW_CoachingDetail';
		 SET @CurrVIEW = 'VIEW_EDW_CoachingDetail';
		 EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'VIEW_EDW_HAassessment';
		 SET @CurrVIEW = 'VIEW_EDW_HAassessment';
		 EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'VIEW_EDW_HADefinition';
		 SET @CurrVIEW = 'VIEW_EDW_HADefinition';
		 EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'VIEW_EDW_HealthAssesment';
		 SET @CurrVIEW = 'VIEW_EDW_HealthAssesment';
		 EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'VIEW_EDW_HealthAssesmentAnswers';
		 SET @CurrVIEW = 'VIEW_EDW_HealthAssesmentAnswers';
		 EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'VIEW_EDW_HealthAssesmentClientView';
		 SET @CurrVIEW = 'VIEW_EDW_HealthAssesmentClientView';
		 EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'VIEW_EDW_HealthAssesmentDeffinition';
		 SET @CurrVIEW = 'VIEW_EDW_HealthAssesmentDeffinition';
		 EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'VIEW_EDW_HealthAssesmentDeffinitionCustom';
		 SET @CurrVIEW = 'VIEW_EDW_HealthAssesmentDeffinitionCustom';
		 EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'VIEW_EDW_HealthAssesmentQuestions';
		 SET @CurrVIEW = 'VIEW_EDW_HealthAssesmentQuestions';
		 EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'VIEW_EDW_HealthAssessment_Staged';
		 SET @CurrVIEW = 'VIEW_EDW_HealthAssessment_Staged';
		 EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'VIEW_EDW_HealthAssessmentDefinition_Staged';
		 SET @CurrVIEW = 'VIEW_EDW_HealthAssessmentDefinition_Staged';
		 EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'VIEW_EDW_Participant';
		 SET @CurrVIEW = 'VIEW_EDW_Participant';
		 EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'VIEW_EDW_RewardAwardDetail';
		 SET @CurrVIEW = 'VIEW_EDW_RewardAwardDetail';
		 EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'VIEW_EDW_RewardsDefinition';
		 SET @CurrVIEW = 'VIEW_EDW_RewardsDefinition';
		 EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'VIEW_EDW_RewardTriggerParameters';
		 SET @CurrVIEW = 'VIEW_EDW_RewardTriggerParameters';
		 EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'VIEW_EDW_RewardUserDetail';
		 SET @CurrVIEW = 'VIEW_EDW_RewardUserDetail';
		 EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'VIEW_EDW_ScreeningsFromTrackers';
		 SET @CurrVIEW = 'VIEW_EDW_ScreeningsFromTrackers';
		 EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'VIEW_EDW_TrackerCompositeDetails';
		 SET @CurrVIEW = 'VIEW_EDW_TrackerCompositeDetails';
		 EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'VIEW_EDW_TrackerMetadata';
		 SET @CurrVIEW = 'VIEW_EDW_TrackerMetadata';
		 EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'VIEW_EDW_TrackerShots';
		 SET @CurrVIEW = 'VIEW_EDW_TrackerShots';
		 EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'VIEW_EDW_TrackerTests';
		 SET @CurrVIEW = 'VIEW_EDW_TrackerTests';
		 EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'VIEW_HFit_Goal_Joined';
		 SET @CurrVIEW = 'VIEW_HFit_Goal_Joined';
		 EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'VIEW_HFit_HACampaign_Joined';
		 SET @CurrVIEW = 'VIEW_HFit_HACampaign_Joined';
		 EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'VIEW_HFit_HealthAssesmentMatrixQuestion_Joined';
		 SET @CurrVIEW = 'VIEW_HFit_HealthAssesmentMatrixQuestion_Joined';
		 EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'VIEW_HFit_HealthAssesmentModule_Joined';
		 SET @CurrVIEW = 'VIEW_HFit_HealthAssesmentModule_Joined';
		 EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'VIEW_HFit_HealthAssesmentMultipleChoiceQuestion_Joined';
		 SET @CurrVIEW = 'VIEW_HFit_HealthAssesmentMultipleChoiceQuestion_Joined';
		 EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'VIEW_HFit_HealthAssesmentPredefinedAnswer_Joined';
		 SET @CurrVIEW = 'VIEW_HFit_HealthAssesmentPredefinedAnswer_Joined';
		 EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'VIEW_HFit_HealthAssesmentRiskArea_Joined';
		 SET @CurrVIEW = 'VIEW_HFit_HealthAssesmentRiskArea_Joined';
		 EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'VIEW_HFit_HealthAssesmentRiskCategory_Joined';
		 SET @CurrVIEW = 'VIEW_HFit_HealthAssesmentRiskCategory_Joined';
		 EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'VIEW_HFit_HealthAssessment_Joined';
		 SET @CurrVIEW = 'VIEW_HFit_HealthAssessment_Joined';
		 EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'VIEW_HFit_HealthAssessmentFreeForm_Joined';
		 SET @CurrVIEW = 'VIEW_HFit_HealthAssessmentFreeForm_Joined';
		 EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'VIEW_HFit_RewardActivity_Joined';
		 SET @CurrVIEW = 'VIEW_HFit_RewardActivity_Joined';
		 EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'VIEW_HFit_RewardGroup_Joined';
		 SET @CurrVIEW = 'VIEW_HFit_RewardGroup_Joined';
		 EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'VIEW_HFit_RewardLevel_Joined';
		 SET @CurrVIEW = 'VIEW_HFit_RewardLevel_Joined';
		 EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'VIEW_HFit_RewardProgram_Joined';
		 SET @CurrVIEW = 'VIEW_HFit_RewardProgram_Joined';
		 EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'VIEW_HFit_RewardTrigger_Joined';
		 SET @CurrVIEW = 'VIEW_HFit_RewardTrigger_Joined';
		 EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'VIEW_HFit_RewardTriggerParameter_Joined';
		 SET @CurrVIEW = 'VIEW_HFit_RewardTriggerParameter_Joined';
		 EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'VIEW_HFit_Tobacco_Goal_Joined';
		 SET @CurrVIEW = 'VIEW_HFit_Tobacco_Goal_Joined';
		 EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SELECT
				*
		   FROM view_SchemaDiff;
	 END;
GO
PRINT 'CREATED Proc_EDW_Compare_MASTER';
GO 



