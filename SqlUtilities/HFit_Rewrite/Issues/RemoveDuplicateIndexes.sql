GO

--****************************************************************************************
print ('Analyzing DUP Indexes.');
--****************************************************************************************

GO
--************************************************************************************
-- ADD NEW PI's
--************************************************************************************
--if exists (select name from sys.indexes where name = 'IDX_Hfit_HealthAssesmentUserAnswers_HAAnswerNodeGUID')
--Begin
--	drop index IDX_Hfit_HealthAssesmentUserAnswers_HAAnswerNodeGUID ON 'dbo'.'HFit_HealthAssesmentUserAnswers'
--end
--go

IF NOT EXISTS (SELECT name
				 FROM sys.indexes
				 WHERE name = 'IDX_Hfit_HealthAssesmentUserAnswers_HAAnswerNodeGUID') 
	BEGIN
		CREATE NONCLUSTERED INDEX IDX_Hfit_HealthAssesmentUserAnswers_HAAnswerNodeGUID ON HFit_HealthAssesmentUserAnswers (ItemID ASC, HAQuestionItemID ASC, HAAnswerNodeGUID ASC) INCLUDE (HAAnswerPoints, HAAnswerValue, CodeName, UOMCode) ;
	END;
GO

IF NOT EXISTS (SELECT name
				 FROM sys.indexes
				 WHERE name = 'ci_HFit_HealthAssesmentUserQuestion_NodeGUID') 
	BEGIN
		CREATE NONCLUSTERED INDEX CI_HFit_HealthAssesmentUserQuestion_NodeGUID ON HFit_HealthAssesmentUserQuestion (HAQuestionNodeGUID ASC) INCLUDE (ItemID, HAQuestionScore, ItemModifiedWhen, HARiskAreaItemID, CodeName, PreWeightedScore, IsProfessionallyCollected, ProfessionallyCollectedEventDate) ;
	END;
GO
4

IF NOT EXISTS (SELECT name
				 FROM sys.indexes
				 WHERE name = 'CI_HFit_HealthAssesmentUserAnswers') 
	BEGIN
		CREATE INDEX CI_HFit_HealthAssesmentUserAnswers ON HFit_HealthAssesmentUserAnswers (ItemID ASC) INCLUDE (HAAnswerPoints, HAAnswerValue, CodeName, UOMCode, HAAnswerNodeGUID) ;
	END;
GO

IF NOT EXISTS (SELECT name
				 FROM sys.indexes
				 WHERE name = 'CI_HFit_HealthAssesmentUserRiskArea') 
	BEGIN
		CREATE INDEX CI_HFit_HealthAssesmentUserRiskArea ON HFit_HealthAssesmentUserRiskArea (ItemID) INCLUDE (HARiskAreaScore, CodeName, PreWeightedScore, HARiskAreaNodeGUID) ;
	END;
GO

--************************************************************************************
-- REMOVE DUPS
--************************************************************************************

IF EXISTS (SELECT name
			 FROM sys.indexes
			 WHERE name = 'IX_Analytics_ConversionCampaign') 
	BEGIN
		PRINT 'Removing duplicate IDX IX_Analytics_ConversionCampaign';
		DROP INDEX IX_Analytics_ConversionCampaign ON Analytics_ConversionCampaign;
	END;
GO
IF EXISTS (SELECT name
			 FROM sys.indexes
			 WHERE name = 'IX_CMS_Class_ClassName_ClassDisplayName_ClassID') 
	BEGIN
		PRINT 'Removing duplicate IDX IX_CMS_Class_ClassName_ClassDisplayName_ClassID';
		DROP INDEX IX_CMS_Class_ClassName_ClassDisplayName_ClassID ON CMS_Class;
	END;
GO
IF EXISTS (SELECT name
			 FROM sys.indexes
			 WHERE name = 'IX_CMS_Role_SiteID_RoleID') 
	BEGIN
		PRINT 'Removing duplicate IDX IX_CMS_Role_SiteID_RoleID';
		DROP INDEX IX_CMS_Role_SiteID_RoleID ON CMS_Role;
	END;
GO
IF EXISTS (SELECT name
			 FROM sys.indexes
			 WHERE name = 'IX_CMS_Tree_NodeID') 
	BEGIN
		PRINT 'Removing duplicate IDX IX_CMS_Tree_NodeID';
		DROP INDEX IX_CMS_Tree_NodeID ON CMS_Tree;
	END;
GO
IF EXISTS (SELECT name
			 FROM sys.indexes
			 WHERE name = 'pi_CMS_UserSettings_IDMPI') 
	BEGIN
		PRINT 'Removing duplicate IDX pi_CMS_UserSettings_IDMPI';
		DROP INDEX pi_CMS_UserSettings_IDMPI ON CMS_UserSettings;
	END;
GO
IF EXISTS (SELECT name
			 FROM sys.indexes
			 WHERE name = 'IX_CMS_WebFarmServerTask_ServerID_TaskID') 
	BEGIN
		PRINT 'Removing duplicate IDX IX_CMS_WebFarmServerTask_ServerID_TaskID';
		DROP INDEX IX_CMS_WebFarmServerTask_ServerID_TaskID ON CMS_WebFarmServerTask;
	END;
GO
IF EXISTS (SELECT name
			 FROM sys.indexes
			 WHERE name = 'IX_COM_SKU_SKUName_SKUEnabled') 
	BEGIN
		PRINT 'Removing duplicate IDX IX_COM_SKU_SKUName_SKUEnabled';
		DROP INDEX IX_COM_SKU_SKUName_SKUEnabled ON COM_SKU;
	END;
GO
IF EXISTS (SELECT name
			 FROM sys.indexes
			 WHERE name = 'Ref65') 
	BEGIN
		PRINT 'Removing duplicate IDX Ref65';
		DROP INDEX Ref65 ON HFit_HealthAssesmentThresholds;
	END;
GO
IF EXISTS (SELECT name
			 FROM sys.indexes
			 WHERE name = 'HFit_RewardsUserActivityDetail_PiDate') 
	BEGIN
		PRINT 'Removing duplicate IDX HFit_RewardsUserActivityDetail_PiDate';
		DROP INDEX HFit_RewardsUserActivityDetail_PiDate ON HFit_RewardsUserActivityDetail;
	END;
GO
IF EXISTS (SELECT name
			 FROM sys.indexes
			 WHERE name = 'HFit_RewardsUserLevelDetail_PiDate') 
	BEGIN
		PRINT 'Removing duplicate IDX HFit_RewardsUserLevelDetail_PiDate';
		DROP INDEX HFit_RewardsUserLevelDetail_PiDate ON HFit_RewardsUserLevelDetail;
	END;
GO
IF EXISTS (SELECT name
			 FROM sys.indexes
			 WHERE name = 'IX_Hfit_TrackerBloodPressure_1') 
	BEGIN
		PRINT 'Removing duplicate IDX IX_Hfit_TrackerBloodPressure_1';
		DROP INDEX IX_Hfit_TrackerBloodPressure_1 ON HFit_TrackerBloodPressure;
	END;
GO
IF EXISTS (SELECT name
			 FROM sys.indexes
			 WHERE name = 'idx_HFit_TrackerBloodSugarAndGlucose_UserIDEventDate') 
	BEGIN
		PRINT 'Removing duplicate IDX idx_HFit_TrackerBloodSugarAndGlucose_UserIDEventDate';
		DROP INDEX idx_HFit_TrackerBloodSugarAndGlucose_UserIDEventDate ON HFit_TrackerBloodSugarAndGlucose;
	END;
GO
IF EXISTS (SELECT name
			 FROM sys.indexes
			 WHERE name = 'nonContactID') 
	BEGIN
		PRINT 'Removing duplicate IDX nonContactID';
		DROP INDEX nonContactID ON OM_Contact;
	END;
GO
IF EXISTS (SELECT name
			 FROM sys.indexes
			 WHERE name = 'idxpagetemplatetemp') 
	BEGIN
		PRINT 'Removing duplicate IDX idxpagetemplatetemp';
		DROP INDEX idxpagetemplatetemp ON temp_CMS_PageTemplate;
	END;
GO
IF EXISTS (SELECT name
			 FROM sys.indexes
			 WHERE name = 'IX_CMS_TranslationSubmission') 
	BEGIN
		PRINT 'Removing duplicate IDX IX_CMS_TranslationSubmission';
		DROP INDEX IX_CMS_TranslationSubmission ON CMS_TranslationSubmission;
	END;
GO
IF EXISTS (SELECT name
			 FROM sys.indexes
			 WHERE name = 'PI_HFIT_Tracker_LastUpdate') 
	BEGIN
		PRINT 'Removing duplicate IDX PI_HFIT_Tracker_LastUpdate';
		DROP INDEX PI_HFIT_Tracker_LastUpdate ON HFit_TrackerFlexibility;
	END;
GO
IF EXISTS (SELECT name
			 FROM sys.indexes
			 WHERE name = 'PI_HFit_TrackerBloodPressure_LastUpdate') 
	BEGIN
		PRINT 'Removing duplicate IDX PI_HFit_TrackerBloodPressure_LastUpdate';
		DROP INDEX PI_HFit_TrackerBloodPressure_LastUpdate ON HFit_TrackerFlexibility;
	END;
GO
IF EXISTS (SELECT name
			 FROM sys.indexes
			 WHERE name = 'PI_HFit_TrackerBloodSugarAndGlucose_LastUpdate') 
	BEGIN
		PRINT 'Removing duplicate IDX PI_HFit_TrackerBloodSugarAndGlucose_LastUpdate';
		DROP INDEX PI_HFit_TrackerBloodSugarAndGlucose_LastUpdate ON HFit_TrackerFlexibility;
	END;
GO
IF EXISTS (SELECT name
			 FROM sys.indexes
			 WHERE name = 'PI_HFit_TrackerBMI_LastUpdate') 
	BEGIN
		PRINT 'Removing duplicate IDX PI_HFit_TrackerBMI_LastUpdate';
		DROP INDEX PI_HFit_TrackerBMI_LastUpdate ON HFit_TrackerFlexibility;
	END;
GO
IF EXISTS (SELECT name
			 FROM sys.indexes
			 WHERE name = 'PI_HFit_TrackerBodyFat_LastUpdate') 
	BEGIN
		PRINT 'Removing duplicate IDX PI_HFit_TrackerBodyFat_LastUpdate';
		DROP INDEX PI_HFit_TrackerBodyFat_LastUpdate ON HFit_TrackerFlexibility;
	END;
GO
IF EXISTS (SELECT name
			 FROM sys.indexes
			 WHERE name = 'PI_HFit_TrackerBodyMeasurements_LastUpdate') 
	BEGIN
		PRINT 'Removing duplicate IDX PI_HFit_TrackerBodyMeasurements_LastUpdate';
		DROP INDEX PI_HFit_TrackerBodyMeasurements_LastUpdate ON HFit_TrackerFlexibility;
	END;
GO
IF EXISTS (SELECT name
			 FROM sys.indexes
			 WHERE name = 'PI_HFit_TrackerCardio_LastUpdate') 
	BEGIN
		PRINT 'Removing duplicate IDX PI_HFit_TrackerCardio_LastUpdate';
		DROP INDEX PI_HFit_TrackerCardio_LastUpdate ON HFit_TrackerFlexibility;
	END;
GO
IF EXISTS (SELECT name
			 FROM sys.indexes
			 WHERE name = 'PI_HFit_TrackerCategory_LastUpdate') 
	BEGIN
		PRINT 'Removing duplicate IDX PI_HFit_TrackerCategory_LastUpdate';
		DROP INDEX PI_HFit_TrackerCategory_LastUpdate ON HFit_TrackerFlexibility;
	END;
GO
IF EXISTS (SELECT name
			 FROM sys.indexes
			 WHERE name = 'PI_HFit_TrackerCholesterol_LastUpdate') 
	BEGIN
		PRINT 'Removing duplicate IDX PI_HFit_TrackerCholesterol_LastUpdate';
		DROP INDEX PI_HFit_TrackerCholesterol_LastUpdate ON HFit_TrackerFlexibility;
	END;
GO
IF EXISTS (SELECT name
			 FROM sys.indexes
			 WHERE name = 'PI_HFit_TrackerCollectionSource_LastUpdate') 
	BEGIN
		PRINT 'Removing duplicate IDX PI_HFit_TrackerCollectionSource_LastUpdate';
		DROP INDEX PI_HFit_TrackerCollectionSource_LastUpdate ON HFit_TrackerFlexibility;
	END;
GO
IF EXISTS (SELECT name
			 FROM sys.indexes
			 WHERE name = 'PI_HFit_TrackerDailySteps_LastUpdate') 
	BEGIN
		PRINT 'Removing duplicate IDX PI_HFit_TrackerDailySteps_LastUpdate';
		DROP INDEX PI_HFit_TrackerDailySteps_LastUpdate ON HFit_TrackerFlexibility;
	END;
GO
IF EXISTS (SELECT name
			 FROM sys.indexes
			 WHERE name = 'PI_HFit_TrackerDef_Item_LastUpdate') 
	BEGIN
		PRINT 'Removing duplicate IDX PI_HFit_TrackerDef_Item_LastUpdate';
		DROP INDEX PI_HFit_TrackerDef_Item_LastUpdate ON HFit_TrackerFlexibility;
	END;
GO
IF EXISTS (SELECT name
			 FROM sys.indexes
			 WHERE name = 'PI_HFit_TrackerDef_Tracker_LastUpdate') 
	BEGIN
		PRINT 'Removing duplicate IDX PI_HFit_TrackerDef_Tracker_LastUpdate';
		DROP INDEX PI_HFit_TrackerDef_Tracker_LastUpdate ON HFit_TrackerFlexibility;
	END;
GO
IF EXISTS (SELECT name
			 FROM sys.indexes
			 WHERE name = 'PI_HFit_TrackerDocument_LastUpdate') 
	BEGIN
		PRINT 'Removing duplicate IDX PI_HFit_TrackerDocument_LastUpdate';
		DROP INDEX PI_HFit_TrackerDocument_LastUpdate ON HFit_TrackerFlexibility;
	END;
GO
IF EXISTS (SELECT name
			 FROM sys.indexes
			 WHERE name = 'PI_HFit_TrackerFlexibility_LastUpdate') 
	BEGIN
		PRINT 'Removing duplicate IDX PI_HFit_TrackerFlexibility_LastUpdate';
		DROP INDEX PI_HFit_TrackerFlexibility_LastUpdate ON HFit_TrackerFlexibility;
	END;
GO
IF EXISTS (SELECT name
			 FROM sys.indexes
			 WHERE name = 'PI_HFit_TrackerFruits_LastUpdate') 
	BEGIN
		PRINT 'Removing duplicate IDX PI_HFit_TrackerFruits_LastUpdate';
		DROP INDEX PI_HFit_TrackerFruits_LastUpdate ON HFit_TrackerFlexibility;
	END;
GO
IF EXISTS (SELECT name
			 FROM sys.indexes
			 WHERE name = 'PI_HFit_TrackerHbA1c_LastUpdate') 
	BEGIN
		PRINT 'Removing duplicate IDX PI_HFit_TrackerHbA1c_LastUpdate';
		DROP INDEX PI_HFit_TrackerHbA1c_LastUpdate ON HFit_TrackerFlexibility;
	END;
GO
IF EXISTS (SELECT name
			 FROM sys.indexes
			 WHERE name = 'PI_HFit_TrackerHeight_LastUpdate') 
	BEGIN
		PRINT 'Removing duplicate IDX PI_HFit_TrackerHeight_LastUpdate';
		DROP INDEX PI_HFit_TrackerHeight_LastUpdate ON HFit_TrackerFlexibility;
	END;
GO
IF EXISTS (SELECT name
			 FROM sys.indexes
			 WHERE name = 'PI_HFit_TrackerHighFatFoods_LastUpdate') 
	BEGIN
		PRINT 'Removing duplicate IDX PI_HFit_TrackerHighFatFoods_LastUpdate';
		DROP INDEX PI_HFit_TrackerHighFatFoods_LastUpdate ON HFit_TrackerFlexibility;
	END;
GO
IF EXISTS (SELECT name
			 FROM sys.indexes
			 WHERE name = 'PI_HFit_TrackerHighSodiumFoods_LastUpdate') 
	BEGIN
		PRINT 'Removing duplicate IDX PI_HFit_TrackerHighSodiumFoods_LastUpdate';
		DROP INDEX PI_HFit_TrackerHighSodiumFoods_LastUpdate ON HFit_TrackerFlexibility;
	END;
GO
IF EXISTS (SELECT name
			 FROM sys.indexes
			 WHERE name = 'PI_HFit_TrackerInstance_Item_LastUpdate') 
	BEGIN
		PRINT 'Removing duplicate IDX PI_HFit_TrackerInstance_Item_LastUpdate';
		DROP INDEX PI_HFit_TrackerInstance_Item_LastUpdate ON HFit_TrackerFlexibility;
	END;
GO
IF EXISTS (SELECT name
			 FROM sys.indexes
			 WHERE name = 'PI_HFit_TrackerInstance_Tracker_LastUpdate') 
	BEGIN
		PRINT 'Removing duplicate IDX PI_HFit_TrackerInstance_Tracker_LastUpdate';
		DROP INDEX PI_HFit_TrackerInstance_Tracker_LastUpdate ON HFit_TrackerFlexibility;
	END;
GO
IF EXISTS (SELECT name
			 FROM sys.indexes
			 WHERE name = 'PI_HFit_TrackerMealPortions_LastUpdate') 
	BEGIN
		PRINT 'Removing duplicate IDX PI_HFit_TrackerMealPortions_LastUpdate';
		DROP INDEX PI_HFit_TrackerMealPortions_LastUpdate ON HFit_TrackerFlexibility;
	END;
GO
IF EXISTS (SELECT name
			 FROM sys.indexes
			 WHERE name = 'PI_HFit_TrackerMedicalCarePlan_LastUpdate') 
	BEGIN
		PRINT 'Removing duplicate IDX PI_HFit_TrackerMedicalCarePlan_LastUpdate';
		DROP INDEX PI_HFit_TrackerMedicalCarePlan_LastUpdate ON HFit_TrackerFlexibility;
	END;
GO
IF EXISTS (SELECT name
			 FROM sys.indexes
			 WHERE name = 'PI_HFit_TrackerRegularMeals_LastUpdate') 
	BEGIN
		PRINT 'Removing duplicate IDX PI_HFit_TrackerRegularMeals_LastUpdate';
		DROP INDEX PI_HFit_TrackerRegularMeals_LastUpdate ON HFit_TrackerFlexibility;
	END;
GO
IF EXISTS (SELECT name
			 FROM sys.indexes
			 WHERE name = 'PI_HFit_TrackerRestingHeartRate_LastUpdate') 
	BEGIN
		PRINT 'Removing duplicate IDX PI_HFit_TrackerRestingHeartRate_LastUpdate';
		DROP INDEX PI_HFit_TrackerRestingHeartRate_LastUpdate ON HFit_TrackerFlexibility;
	END;
GO
IF EXISTS (SELECT name
			 FROM sys.indexes
			 WHERE name = 'PI_HFit_TrackerShots_LastUpdate') 
	BEGIN
		PRINT 'Removing duplicate IDX PI_HFit_TrackerShots_LastUpdate';
		DROP INDEX PI_HFit_TrackerShots_LastUpdate ON HFit_TrackerFlexibility;
	END;
GO
IF EXISTS (SELECT name
			 FROM sys.indexes
			 WHERE name = 'PI_HFit_TrackerSitLess_LastUpdate') 
	BEGIN
		PRINT 'Removing duplicate IDX PI_HFit_TrackerSitLess_LastUpdate';
		DROP INDEX PI_HFit_TrackerSitLess_LastUpdate ON HFit_TrackerFlexibility;
	END;
GO
IF EXISTS (SELECT name
			 FROM sys.indexes
			 WHERE name = 'PI_HFit_TrackerSleepPlan_LastUpdate') 
	BEGIN
		PRINT 'Removing duplicate IDX PI_HFit_TrackerSleepPlan_LastUpdate';
		DROP INDEX PI_HFit_TrackerSleepPlan_LastUpdate ON HFit_TrackerFlexibility;
	END;
GO
IF EXISTS (SELECT name
			 FROM sys.indexes
			 WHERE name = 'PI_HFit_TrackerStrength_LastUpdate') 
	BEGIN
		PRINT 'Removing duplicate IDX PI_HFit_TrackerStrength_LastUpdate';
		DROP INDEX PI_HFit_TrackerStrength_LastUpdate ON HFit_TrackerFlexibility;
	END;
GO
IF EXISTS (SELECT name
			 FROM sys.indexes
			 WHERE name = 'PI_HFit_TrackerStress_LastUpdate') 
	BEGIN
		PRINT 'Removing duplicate IDX PI_HFit_TrackerStress_LastUpdate';
		DROP INDEX PI_HFit_TrackerStress_LastUpdate ON HFit_TrackerFlexibility;
	END;
GO
IF EXISTS (SELECT name
			 FROM sys.indexes
			 WHERE name = 'PI_HFit_TrackerStressManagement_LastUpdate') 
	BEGIN
		PRINT 'Removing duplicate IDX PI_HFit_TrackerStressManagement_LastUpdate';
		DROP INDEX PI_HFit_TrackerStressManagement_LastUpdate ON HFit_TrackerFlexibility;
	END;
GO
IF EXISTS (SELECT name
			 FROM sys.indexes
			 WHERE name = 'PI_HFit_TrackerSugaryDrinks_LastUpdate') 
	BEGIN
		PRINT 'Removing duplicate IDX PI_HFit_TrackerSugaryDrinks_LastUpdate';
		DROP INDEX PI_HFit_TrackerSugaryDrinks_LastUpdate ON HFit_TrackerFlexibility;
	END;
GO
IF EXISTS (SELECT name
			 FROM sys.indexes
			 WHERE name = 'PI_HFit_TrackerSugaryFoods_LastUpdate') 
	BEGIN
		PRINT 'Removing duplicate IDX PI_HFit_TrackerSugaryFoods_LastUpdate';
		DROP INDEX PI_HFit_TrackerSugaryFoods_LastUpdate ON HFit_TrackerFlexibility;
	END;
GO
IF EXISTS (SELECT name
			 FROM sys.indexes
			 WHERE name = 'PI_HFit_TrackerSummary_LastUpdate') 
	BEGIN
		PRINT 'Removing duplicate IDX PI_HFit_TrackerSummary_LastUpdate';
		DROP INDEX PI_HFit_TrackerSummary_LastUpdate ON HFit_TrackerFlexibility;
	END;
GO
IF EXISTS (SELECT name
			 FROM sys.indexes
			 WHERE name = 'PI_HFit_TrackerTests_LastUpdate') 
	BEGIN
		PRINT 'Removing duplicate IDX PI_HFit_TrackerTests_LastUpdate';
		DROP INDEX PI_HFit_TrackerTests_LastUpdate ON HFit_TrackerFlexibility;
	END;
GO
IF EXISTS (SELECT name
			 FROM sys.indexes
			 WHERE name = 'PI_HFit_TrackerTobaccoFree_LastUpdate') 
	BEGIN
		PRINT 'Removing duplicate IDX PI_HFit_TrackerTobaccoFree_LastUpdate';
		DROP INDEX PI_HFit_TrackerTobaccoFree_LastUpdate ON HFit_TrackerFlexibility;
	END;
GO
IF EXISTS (SELECT name
			 FROM sys.indexes
			 WHERE name = 'PI_HFit_TrackerVegetables_LastUpdate') 
	BEGIN
		PRINT 'Removing duplicate IDX PI_HFit_TrackerVegetables_LastUpdate';
		DROP INDEX PI_HFit_TrackerVegetables_LastUpdate ON HFit_TrackerFlexibility;
	END;
GO
IF EXISTS (SELECT name
			 FROM sys.indexes
			 WHERE name = 'PI_HFit_TrackerWater_LastUpdate') 
	BEGIN
		PRINT 'Removing duplicate IDX PI_HFit_TrackerWater_LastUpdate';
		DROP INDEX PI_HFit_TrackerWater_LastUpdate ON HFit_TrackerFlexibility;
	END;
GO
IF EXISTS (SELECT name
			 FROM sys.indexes
			 WHERE name = 'PI_HFit_TrackerWeight_LastUpdate') 
	BEGIN
		PRINT 'Removing duplicate IDX PI_HFit_TrackerWeight_LastUpdate';
		DROP INDEX PI_HFit_TrackerWeight_LastUpdate ON HFit_TrackerFlexibility;
	END;
GO
IF EXISTS (SELECT name
			 FROM sys.indexes
			 WHERE name = 'PI_HFit_TrackerWholeGrains_LastUpdate') 
	BEGIN
		PRINT 'Removing duplicate IDX PI_HFit_TrackerWholeGrains_LastUpdate';
		DROP INDEX PI_HFit_TrackerWholeGrains_LastUpdate ON HFit_TrackerFlexibility;
	END;
GO
IF EXISTS (SELECT name
			 FROM sys.indexes
			 WHERE name = 'idx_ThresholdTypeID') 
	BEGIN
		DROP INDEX idx_ThresholdTypeID ON HFit_HealthAssesmentThresholds;
	END;
GO

--****************************************************************************************
print ('DUP Indexes removed.');
--****************************************************************************************

GO