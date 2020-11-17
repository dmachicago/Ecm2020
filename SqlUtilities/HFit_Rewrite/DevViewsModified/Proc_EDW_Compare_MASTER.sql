--exec Proc_EDW_Compare_MASTER 'hfit-sqlUAT.cloudapp.net,3', 'KenticoCMS_ProdStaging', 'KenticoCMS_DEV' 
GO
print ('Creating Proc_EDW_Compare_MASTER') ;
go 

if exists(select name from sys.procedures where name = 'Proc_EDW_Compare_MASTER')
BEGIN
	drop procedure Proc_EDW_Compare_MASTER ;
END
go

create proc Proc_EDW_Compare_MASTER (@LinkedSVR as nvarchar(100),
			@LinkedDB as nvarchar(100),
			@CurrDB as nvarchar(100))
as
BEGIN
	--DECLARE @LinkedSVR as nvarchar(254) ;
	--DECLARE @LinkedDB as nvarchar(80);
	DECLARE @LinkedVIEW as nvarchar(80);
	--DECLARE @CurrDB as nvarchar(80);
	DECLARE @CurrVIEW as nvarchar(80);
	DECLARE @NewRun as int = 0 ;

	--set @LinkedSVR = 'hfit-sqlUAT.cloudapp.net,3' ;
	--set @LinkedDB = 'KenticoCMS_ProdStaging' ;
	set @LinkedVIEW = 'SchemaChangeMonitor' ;
	--set @CurrDB = 'KenticoCMS_DEV' ;
	set @CurrVIEW = 'SchemaChangeMonitor'

	set @NewRun = 1 ;

	Set @LinkedVIEW = 'CMS_Class' ;
	Set @CurrVIEW = 'CMS_Class' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO

	set @NewRun = 0 ;

	Set @LinkedVIEW = 'CMS_Document' ;
	Set @CurrVIEW = 'CMS_Document' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'CMS_Site' ;
	Set @CurrVIEW = 'CMS_Site' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'CMS_Tree' ;
	Set @CurrVIEW = 'CMS_Tree' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'CMS_User' ;
	Set @CurrVIEW = 'CMS_User' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'CMS_UserSettings' ;
	Set @CurrVIEW = 'CMS_UserSettings' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'CMS_UserSite' ;
	Set @CurrVIEW = 'CMS_UserSite' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'COM_SKU' ;
	Set @CurrVIEW = 'COM_SKU' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'EDW_HealthAssessment' ;
	Set @CurrVIEW = 'EDW_HealthAssessment' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'EDW_HealthAssessmentDefinition' ;
	Set @CurrVIEW = 'EDW_HealthAssessmentDefinition' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'HFit_Account' ;
	Set @CurrVIEW = 'HFit_Account' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'HFit_Coaches' ;
	Set @CurrVIEW = 'HFit_Coaches' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'HFit_Company' ;
	Set @CurrVIEW = 'HFit_Company' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'HFit_Goal' ;
	Set @CurrVIEW = 'HFit_Goal' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'HFit_GoalOutcome' ;
	Set @CurrVIEW = 'HFit_GoalOutcome' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'HFit_HACampaign' ;
	Set @CurrVIEW = 'HFit_HACampaign' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'HFit_HealthAssesmentMatrixQuestion' ;
	Set @CurrVIEW = 'HFit_HealthAssesmentMatrixQuestion' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'HFit_HealthAssesmentModule' ;
	Set @CurrVIEW = 'HFit_HealthAssesmentModule' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'HFit_HealthAssesmentMultipleChoiceQuestion' ;
	Set @CurrVIEW = 'HFit_HealthAssesmentMultipleChoiceQuestion' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'HFit_HealthAssesmentPredefinedAnswer' ;
	Set @CurrVIEW = 'HFit_HealthAssesmentPredefinedAnswer' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'HFit_HealthAssesmentRiskArea' ;
	Set @CurrVIEW = 'HFit_HealthAssesmentRiskArea' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'HFit_HealthAssesmentRiskCategory' ;
	Set @CurrVIEW = 'HFit_HealthAssesmentRiskCategory' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'HFit_HealthAssesmentUserAnswers' ;
	Set @CurrVIEW = 'HFit_HealthAssesmentUserAnswers' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'HFit_HealthAssesmentUserModule' ;
	Set @CurrVIEW = 'HFit_HealthAssesmentUserModule' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'HFit_HealthAssesmentUserQuestion' ;
	Set @CurrVIEW = 'HFit_HealthAssesmentUserQuestion' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'HFit_HealthAssesmentUserQuestionGroupResults' ;
	Set @CurrVIEW = 'HFit_HealthAssesmentUserQuestionGroupResults' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'HFit_HealthAssesmentUserRiskArea' ;
	Set @CurrVIEW = 'HFit_HealthAssesmentUserRiskArea' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'HFit_HealthAssesmentUserRiskCategory' ;
	Set @CurrVIEW = 'HFit_HealthAssesmentUserRiskCategory' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'HFit_HealthAssesmentUserStarted' ;
	Set @CurrVIEW = 'HFit_HealthAssesmentUserStarted' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'HFit_HealthAssessment' ;
	Set @CurrVIEW = 'HFit_HealthAssessment' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'HFit_HealthAssessmentFreeForm' ;
	Set @CurrVIEW = 'HFit_HealthAssessmentFreeForm' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'HFit_LKP_Frequency' ;
	Set @CurrVIEW = 'HFit_LKP_Frequency' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'HFit_LKP_GoalStatus' ;
	Set @CurrVIEW = 'HFit_LKP_GoalStatus' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'HFit_LKP_RewardLevelType' ;
	Set @CurrVIEW = 'HFit_LKP_RewardLevelType' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'HFit_LKP_RewardTrigger' ;
	Set @CurrVIEW = 'HFit_LKP_RewardTrigger' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'HFit_LKP_RewardTriggerParameterOperator' ;
	Set @CurrVIEW = 'HFit_LKP_RewardTriggerParameterOperator' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'HFit_LKP_RewardType' ;
	Set @CurrVIEW = 'HFit_LKP_RewardType' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'HFit_LKP_UnitOfMeasure' ;
	Set @CurrVIEW = 'HFit_LKP_UnitOfMeasure' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'hfit_ppteligibility' ;
	Set @CurrVIEW = 'hfit_ppteligibility' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'HFit_RewardActivity' ;
	Set @CurrVIEW = 'HFit_RewardActivity' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'HFit_RewardException' ;
	Set @CurrVIEW = 'HFit_RewardException' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'HFit_RewardGroup' ;
	Set @CurrVIEW = 'HFit_RewardGroup' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'HFit_RewardLevel' ;
	Set @CurrVIEW = 'HFit_RewardLevel' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'HFit_RewardProgram' ;
	Set @CurrVIEW = 'HFit_RewardProgram' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'HFit_RewardsAwardUserDetail' ;
	Set @CurrVIEW = 'HFit_RewardsAwardUserDetail' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'HFit_RewardsUserActivityDetail' ;
	Set @CurrVIEW = 'HFit_RewardsUserActivityDetail' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'HFit_RewardsUserLevelDetail' ;
	Set @CurrVIEW = 'HFit_RewardsUserLevelDetail' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'HFit_RewardTrigger' ;
	Set @CurrVIEW = 'HFit_RewardTrigger' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'HFit_RewardTriggerParameter' ;
	Set @CurrVIEW = 'HFit_RewardTriggerParameter' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'HFit_Tobacco_Goal' ;
	Set @CurrVIEW = 'HFit_Tobacco_Goal' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'HFIT_Tracker' ;
	Set @CurrVIEW = 'HFIT_Tracker' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'HFit_TrackerBloodPressure' ;
	Set @CurrVIEW = 'HFit_TrackerBloodPressure' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'HFit_TrackerBloodSugarAndGlucose' ;
	Set @CurrVIEW = 'HFit_TrackerBloodSugarAndGlucose' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'HFit_TrackerBMI' ;
	Set @CurrVIEW = 'HFit_TrackerBMI' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'HFit_TrackerBodyFat' ;
	Set @CurrVIEW = 'HFit_TrackerBodyFat' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'HFit_TrackerBodyMeasurements' ;
	Set @CurrVIEW = 'HFit_TrackerBodyMeasurements' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'HFit_TrackerCardio' ;
	Set @CurrVIEW = 'HFit_TrackerCardio' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'HFit_TrackerCholesterol' ;
	Set @CurrVIEW = 'HFit_TrackerCholesterol' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'HFit_TrackerCollectionSource' ;
	Set @CurrVIEW = 'HFit_TrackerCollectionSource' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'HFit_TrackerDailySteps' ;
	Set @CurrVIEW = 'HFit_TrackerDailySteps' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'HFit_TrackerFlexibility' ;
	Set @CurrVIEW = 'HFit_TrackerFlexibility' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'HFit_TrackerFruits' ;
	Set @CurrVIEW = 'HFit_TrackerFruits' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'HFit_TrackerHbA1c' ;
	Set @CurrVIEW = 'HFit_TrackerHbA1c' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'HFit_TrackerHeight' ;
	Set @CurrVIEW = 'HFit_TrackerHeight' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'HFit_TrackerHighFatFoods' ;
	Set @CurrVIEW = 'HFit_TrackerHighFatFoods' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'HFit_TrackerHighSodiumFoods' ;
	Set @CurrVIEW = 'HFit_TrackerHighSodiumFoods' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'HFit_TrackerInstance_Tracker' ;
	Set @CurrVIEW = 'HFit_TrackerInstance_Tracker' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'HFit_TrackerMealPortions' ;
	Set @CurrVIEW = 'HFit_TrackerMealPortions' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'HFit_TrackerMedicalCarePlan' ;
	Set @CurrVIEW = 'HFit_TrackerMedicalCarePlan' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'HFit_TrackerRegularMeals' ;
	Set @CurrVIEW = 'HFit_TrackerRegularMeals' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'HFit_TrackerRestingHeartRate' ;
	Set @CurrVIEW = 'HFit_TrackerRestingHeartRate' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'HFit_TrackerShots' ;
	Set @CurrVIEW = 'HFit_TrackerShots' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'HFit_TrackerSitLess' ;
	Set @CurrVIEW = 'HFit_TrackerSitLess' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'HFit_TrackerSleepPlan' ;
	Set @CurrVIEW = 'HFit_TrackerSleepPlan' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'HFit_TrackerStrength' ;
	Set @CurrVIEW = 'HFit_TrackerStrength' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'HFit_TrackerStress' ;
	Set @CurrVIEW = 'HFit_TrackerStress' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'HFit_TrackerStressManagement' ;
	Set @CurrVIEW = 'HFit_TrackerStressManagement' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'HFit_TrackerSugaryDrinks' ;
	Set @CurrVIEW = 'HFit_TrackerSugaryDrinks' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'HFit_TrackerSugaryFoods' ;
	Set @CurrVIEW = 'HFit_TrackerSugaryFoods' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'HFit_TrackerTests' ;
	Set @CurrVIEW = 'HFit_TrackerTests' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'HFit_TrackerTobaccoFree' ;
	Set @CurrVIEW = 'HFit_TrackerTobaccoFree' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'HFit_TrackerVegetables' ;
	Set @CurrVIEW = 'HFit_TrackerVegetables' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'HFit_TrackerWater' ;
	Set @CurrVIEW = 'HFit_TrackerWater' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'HFit_TrackerWeight' ;
	Set @CurrVIEW = 'HFit_TrackerWeight' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'HFit_TrackerWholeGrains' ;
	Set @CurrVIEW = 'HFit_TrackerWholeGrains' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'HFit_UserGoal' ;
	Set @CurrVIEW = 'HFit_UserGoal' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'Tracker_EDW_Metadata' ;
	Set @CurrVIEW = 'Tracker_EDW_Metadata' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO



	Set @LinkedVIEW = 'View_CMS_Tree_Joined' ;
	Set @CurrVIEW = 'View_CMS_Tree_Joined' ;
	EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'VIEW_CMS_Tree_Joined_Linked' ;
	Set @CurrVIEW = 'VIEW_CMS_Tree_Joined_Linked' ;
	EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'VIEW_CMS_Tree_Joined_Regular' ;
	Set @CurrVIEW = 'VIEW_CMS_Tree_Joined_Regular' ;
	EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'VIEW_COM_SKU' ;
	Set @CurrVIEW = 'VIEW_COM_SKU' ;
	EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'VIEW_EDW_ClientCompany' ;
	Set @CurrVIEW = 'VIEW_EDW_ClientCompany' ;
	EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'VIEW_EDW_Coaches' ;
	Set @CurrVIEW = 'VIEW_EDW_Coaches' ;
	EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'VIEW_EDW_CoachingDefinition' ;
	Set @CurrVIEW = 'VIEW_EDW_CoachingDefinition' ;
	EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'VIEW_EDW_CoachingDetail' ;
	Set @CurrVIEW = 'VIEW_EDW_CoachingDetail' ;
	EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'VIEW_EDW_HAassessment' ;
	Set @CurrVIEW = 'VIEW_EDW_HAassessment' ;
	EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'VIEW_EDW_HADefinition' ;
	Set @CurrVIEW = 'VIEW_EDW_HADefinition' ;
	EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'VIEW_EDW_HealthAssesment' ;
	Set @CurrVIEW = 'VIEW_EDW_HealthAssesment' ;
	EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'VIEW_EDW_HealthAssesmentAnswers' ;
	Set @CurrVIEW = 'VIEW_EDW_HealthAssesmentAnswers' ;
	EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'VIEW_EDW_HealthAssesmentClientView' ;
	Set @CurrVIEW = 'VIEW_EDW_HealthAssesmentClientView' ;
	EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'VIEW_EDW_HealthAssesmentDeffinition' ;
	Set @CurrVIEW = 'VIEW_EDW_HealthAssesmentDeffinition' ;
	EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'VIEW_EDW_HealthAssesmentDeffinitionCustom' ;
	Set @CurrVIEW = 'VIEW_EDW_HealthAssesmentDeffinitionCustom' ;
	EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'VIEW_EDW_HealthAssesmentQuestions' ;
	Set @CurrVIEW = 'VIEW_EDW_HealthAssesmentQuestions' ;
	EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'VIEW_EDW_HealthAssessment_Staged' ;
	Set @CurrVIEW = 'VIEW_EDW_HealthAssessment_Staged' ;
	EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'VIEW_EDW_HealthAssessmentDefinition_Staged' ;
	Set @CurrVIEW = 'VIEW_EDW_HealthAssessmentDefinition_Staged' ;
	EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'VIEW_EDW_Participant' ;
	Set @CurrVIEW = 'VIEW_EDW_Participant' ;
	EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'VIEW_EDW_RewardAwardDetail' ;
	Set @CurrVIEW = 'VIEW_EDW_RewardAwardDetail' ;
	EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'VIEW_EDW_RewardsDefinition' ;
	Set @CurrVIEW = 'VIEW_EDW_RewardsDefinition' ;
	EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'VIEW_EDW_RewardTriggerParameters' ;
	Set @CurrVIEW = 'VIEW_EDW_RewardTriggerParameters' ;
	EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'VIEW_EDW_RewardUserDetail' ;
	Set @CurrVIEW = 'VIEW_EDW_RewardUserDetail' ;
	EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'VIEW_EDW_ScreeningsFromTrackers' ;
	Set @CurrVIEW = 'VIEW_EDW_ScreeningsFromTrackers' ;
	EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'VIEW_EDW_TrackerCompositeDetails' ;
	Set @CurrVIEW = 'VIEW_EDW_TrackerCompositeDetails' ;
	EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'VIEW_EDW_TrackerMetadata' ;
	Set @CurrVIEW = 'VIEW_EDW_TrackerMetadata' ;
	EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'VIEW_EDW_TrackerShots' ;
	Set @CurrVIEW = 'VIEW_EDW_TrackerShots' ;
	EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'VIEW_EDW_TrackerTests' ;
	Set @CurrVIEW = 'VIEW_EDW_TrackerTests' ;
	EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'VIEW_HFit_Goal_Joined' ;
	Set @CurrVIEW = 'VIEW_HFit_Goal_Joined' ;
	EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'VIEW_HFit_HACampaign_Joined' ;
	Set @CurrVIEW = 'VIEW_HFit_HACampaign_Joined' ;
	EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'VIEW_HFit_HealthAssesmentMatrixQuestion_Joined' ;
	Set @CurrVIEW = 'VIEW_HFit_HealthAssesmentMatrixQuestion_Joined' ;
	EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'VIEW_HFit_HealthAssesmentModule_Joined' ;
	Set @CurrVIEW = 'VIEW_HFit_HealthAssesmentModule_Joined' ;
	EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'VIEW_HFit_HealthAssesmentMultipleChoiceQuestion_Joined' ;
	Set @CurrVIEW = 'VIEW_HFit_HealthAssesmentMultipleChoiceQuestion_Joined' ;
	EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'VIEW_HFit_HealthAssesmentPredefinedAnswer_Joined' ;
	Set @CurrVIEW = 'VIEW_HFit_HealthAssesmentPredefinedAnswer_Joined' ;
	EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'VIEW_HFit_HealthAssesmentRiskArea_Joined' ;
	Set @CurrVIEW = 'VIEW_HFit_HealthAssesmentRiskArea_Joined' ;
	EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'VIEW_HFit_HealthAssesmentRiskCategory_Joined' ;
	Set @CurrVIEW = 'VIEW_HFit_HealthAssesmentRiskCategory_Joined' ;
	EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'VIEW_HFit_HealthAssessment_Joined' ;
	Set @CurrVIEW = 'VIEW_HFit_HealthAssessment_Joined' ;
	EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'VIEW_HFit_HealthAssessmentFreeForm_Joined' ;
	Set @CurrVIEW = 'VIEW_HFit_HealthAssessmentFreeForm_Joined' ;
	EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'VIEW_HFit_RewardActivity_Joined' ;
	Set @CurrVIEW = 'VIEW_HFit_RewardActivity_Joined' ;
	EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'VIEW_HFit_RewardGroup_Joined' ;
	Set @CurrVIEW = 'VIEW_HFit_RewardGroup_Joined' ;
	EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'VIEW_HFit_RewardLevel_Joined' ;
	Set @CurrVIEW = 'VIEW_HFit_RewardLevel_Joined' ;
	EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'VIEW_HFit_RewardProgram_Joined' ;
	Set @CurrVIEW = 'VIEW_HFit_RewardProgram_Joined' ;
	EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'VIEW_HFit_RewardTrigger_Joined' ;
	Set @CurrVIEW = 'VIEW_HFit_RewardTrigger_Joined' ;
	EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'VIEW_HFit_RewardTriggerParameter_Joined' ;
	Set @CurrVIEW = 'VIEW_HFit_RewardTriggerParameter_Joined' ;
	EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'VIEW_HFit_Tobacco_Goal_Joined' ;
	Set @CurrVIEW = 'VIEW_HFit_Tobacco_Goal_Joined' ;
	EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO

	select * from view_SchemaDiff

END

go
print ('CREATED Proc_EDW_Compare_MASTER') ;
go 



