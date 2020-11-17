
print ('Processing: Proc_EDW_GenerateMetadata') ;
go


if exists (select * from sysobjects where name = 'Proc_EDW_GenerateMetadata' and Xtype = 'P')
BEGIN
	drop procedure Proc_EDW_GenerateMetadata ;
END 
go

--select * from view_EDW_TrackerMetadata where TableName = 'HFit.CustomTrackerInstances'
--select * from Tracker_EDW_Metadata
--delete from Tracker_EDW_Metadata where TableName = 'HFit.TrackerWholeGrains'

--exec Proc_EDW_GenerateMetadata
--2014-07-30 20:59:10.940

CREATE procedure [dbo].[Proc_EDW_GenerateMetadata]
as 
BEGIN
	--truncate table Tracker_EDW_Metadata;
	BEGIN TRAN T1;
	EXEC Proc_EDW_TrackerMetadataExtract 'HFIT.Tracker';	
	COMMIT TRAN T1;
	BEGIN TRAN T2;
	EXEC Proc_EDW_TrackerMetadataExtract 'HFit.TrackerCategory';
	COMMIT TRAN T2;
	BEGIN TRAN T3;
	EXEC Proc_EDW_TrackerMetadataExtract 'HFit.TrackerDocument';
	COMMIT TRAN T3;
	BEGIN TRAN T4;
	EXEC Proc_EDW_TrackerMetadataExtract 'HFit.UserTracker';
	COMMIT TRAN T4;
	BEGIN TRAN T5;
	EXEC Proc_EDW_TrackerMetadataExtract 'HFit.UserTrackerCategory';
	COMMIT TRAN T5;
	BEGIN TRAN T6;	
	EXEC Proc_EDW_TrackerMetadataExtract 'HFit.TrackerCollectionSource';
	COMMIT TRAN T6;
	BEGIN TRAN T7;
	EXEC Proc_EDW_TrackerMetadataExtract 'HFit.TrackerVegetables';	
	COMMIT TRAN T7;
	BEGIN TRAN T8;
	EXEC Proc_EDW_TrackerMetadataExtract 'HFit.LKP_TrackerTobaccoQuitAids';
	COMMIT TRAN T8;
	BEGIN TRAN T9;
	EXEC Proc_EDW_TrackerMetadataExtract 'HFit.TrackerTobaccoFree';
	COMMIT TRAN T9;
	BEGIN TRAN T10;
	EXEC Proc_EDW_TrackerMetadataExtract 'HFit.TrackerWholeGrains';
	COMMIT TRAN T10;
	BEGIN TRAN T11;
	EXEC Proc_EDW_TrackerMetadataExtract 'HFit.TrackerFruits';
	COMMIT TRAN T11;
	BEGIN TRAN T12;
	EXEC Proc_EDW_TrackerMetadataExtract 'HFit.TrackerSugaryDrinks';
	COMMIT TRAN T12;
	BEGIN  TRAN T13;
	EXEC Proc_EDW_TrackerMetadataExtract 'HFit.TrackerWater';
	COMMIT TRAN T13;
	BEGIN  TRAN T14;
	EXEC Proc_EDW_TrackerMetadataExtract 'HFit.TrackerHighSodiumFoods';
	COMMIT TRAN T15;
	BEGIN  TRAN T16;
	EXEC Proc_EDW_TrackerMetadataExtract 'HFit.TrackerHighFatFoods';
	COMMIT TRAN T16;
	BEGIN  TRAN T17;
	EXEC Proc_EDW_TrackerMetadataExtract 'HFit.TrackerSleepPlan';
	COMMIT TRAN T17;
	BEGIN  TRAN T18;
	EXEC Proc_EDW_TrackerMetadataExtract 'HFit.LKP_TrackerSleepPlanTechniques';
	COMMIT TRAN T18;
	BEGIN  TRAN T19;
	EXEC Proc_EDW_TrackerMetadataExtract 'HFit.TrackerMedicalCarePlan';
	COMMIT TRAN T19;
	BEGIN  TRAN T20;
	EXEC Proc_EDW_TrackerMetadataExtract 'HFit.TrackerSummary';
	COMMIT TRAN T20;
	BEGIN  TRAN T21;
	EXEC Proc_EDW_TrackerMetadataExtract 'HFit.TrackerRegularMeals';
	COMMIT TRAN T21;
	BEGIN  TRAN T22;
	EXEC Proc_EDW_TrackerMetadataExtract 'HFit.TrackerBodyFat';
	COMMIT TRAN T22;
	BEGIN  TRAN T23;
	EXEC Proc_EDW_TrackerMetadataExtract 'HFit.TrackerWeight';
	COMMIT TRAN T23;
	BEGIN  TRAN T24;
	EXEC Proc_EDW_TrackerMetadataExtract 'HFit.TrackerBloodSugarGlucose';
	COMMIT TRAN T24;
	BEGIN  TRAN T25;
	EXEC Proc_EDW_TrackerMetadataExtract 'HFit.TrackerHbA1c';
	COMMIT TRAN T25;
	BEGIN  TRAN T26;
	EXEC Proc_EDW_TrackerMetadataExtract 'HFit.TrackerMealPortions';
	COMMIT TRAN T26;
	BEGIN  TRAN T27;
	EXEC Proc_EDW_TrackerMetadataExtract 'HFit.TrackerSugaryFoods';
	COMMIT TRAN T27;
	BEGIN  TRAN T28;
	EXEC Proc_EDW_TrackerMetadataExtract 'HFit.LKP_TrackerStrengthActivity';
	COMMIT TRAN T29;
	BEGIN  TRAN T30;
	EXEC Proc_EDW_TrackerMetadataExtract 'HFit.TrackerRestingHeartRate';
	COMMIT TRAN T30;
	BEGIN  TRAN T31;
	EXEC Proc_EDW_TrackerMetadataExtract 'HFit.TrackerCholesterol';
	COMMIT TRAN T31;
	BEGIN  TRAN T32;
	EXEC Proc_EDW_TrackerMetadataExtract 'HFit.TrackerBodyMeasurements';
	COMMIT TRAN T32;
	BEGIN  TRAN T33;
	EXEC Proc_EDW_TrackerMetadataExtract 'HFit.TrackerBloodPressure';
	COMMIT TRAN T33;
	BEGIN  TRAN T34;
	EXEC Proc_EDW_TrackerMetadataExtract 'HFit.LKP_TrackerFlexibilityActivity';
	COMMIT TRAN T34;
	BEGIN  TRAN T35;
	EXEC Proc_EDW_TrackerMetadataExtract 'HFit.TrackerStressManagement';
	COMMIT TRAN T35;
	BEGIN  TRAN T36;
	EXEC Proc_EDW_TrackerMetadataExtract 'HFit.TrackerFlexibility';
	COMMIT TRAN T36;
	BEGIN  TRAN T37;
	EXEC Proc_EDW_TrackerMetadataExtract 'HFit.TrackerStress';
	COMMIT TRAN T37;
	BEGIN  TRAN T38;
	EXEC Proc_EDW_TrackerMetadataExtract 'HFit.TrackerCardio';
	COMMIT TRAN T39;
	BEGIN  TRAN T40;
	EXEC Proc_EDW_TrackerMetadataExtract 'HFit.TrackerSitLess';
	COMMIT TRAN T40;
	BEGIN  TRAN T41;
	EXEC Proc_EDW_TrackerMetadataExtract 'HFit.TrackerStrength';
	COMMIT TRAN T41;
	BEGIN  TRAN T42;
	EXEC Proc_EDW_TrackerMetadataExtract 'HFit.LKP_TrackerCardioActivity';
	COMMIT TRAN T42;
	BEGIN  TRAN T43;
	EXEC Proc_EDW_TrackerMetadataExtract 'HFit.TrackerBMI';
	COMMIT TRAN T43;
	BEGIN  TRAN T44;
	EXEC Proc_EDW_TrackerMetadataExtract 'HFit.Ref_RewardTrackerValidation';
	COMMIT TRAN T45;
	BEGIN  TRAN T46;
	EXEC Proc_EDW_TrackerMetadataExtract 'HFit.HFit_TrackerHeight';
	COMMIT TRAN T46;
	BEGIN  TRAN T47;
	EXEC Proc_EDW_TrackerMetadataExtract 'HFit.HFit_TrackerShots';
	COMMIT TRAN T47;
	BEGIN  TRAN T48;
	EXEC Proc_EDW_TrackerMetadataExtract 'HFit.HFit_TrackerTests';
	COMMIT TRAN T48;
	--BEGIN  TRAN T49;
	--EXEC Proc_EDW_TrackerMetadataExtract 'HFit.HealthAssessmentCodeNamesToTrackerMapping';
	--COMMIT TRAN T49;
	BEGIN  TRAN T50;
	EXEC Proc_EDW_TrackerMetadataExtract 'HFit.CustomTrackerInstances';
	COMMIT TRAN T50;
	BEGIN  TRAN T51;
	EXEC Proc_EDW_TrackerMetadataExtract 'HFit.TrackerDailySteps';
	COMMIT TRAN T51;
END

GO


