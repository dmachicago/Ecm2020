
SELECT
	   table_name
	 , column_name AS PK_COL
	   FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
	   WHERE OBJECTPROPERTY (OBJECT_ID (constraint_name) , 'IsPrimaryKey') = 1
		 AND table_name IN ('CMS_UserSite', 'CMS_Class', 'CMS_Document', 'cms_MembershipRole', 'cms_MembershipUser', 'CMS_Role', 'CMS_Site', 'CMS_Tree', 'CMS_User', 'CMS_USERSettings', 'CMS_UserSite', 'COM_SKU', 'EDW_BiometricViewRejectCriteria', 'EDW_GroupMemberHistory', 'EDW_HealthAssessment', 'EDW_HealthAssessmentDefinition', 'HFit_Account', 'HFit_Coaches', 'HFit_CoachingHealthArea', 'HFit_CoachingHealthInterest', 'HFit_Company', 'HFit_ContactGroupMembership', 'HFit_Goal', 'HFit_GoalOutcome', 'HFit_HACampaign', 'HFit_HealthAssesmentMatrixQuestion', 'HFit_HealthAssesmentModule', 'HFit_HealthAssesmentMultipleChoiceQuestion', 'HFit_HealthAssesmentPredefinedAnswer', 'HFit_HealthAssesmentRiskArea', 'HFit_HealthAssesmentRiskCategory', 'HFit_HealthAssesmentUserAnswers', 'HFit_HealthAssesmentUserModule', 'HFit_HealthAssesmentUserQuestion', 'HFit_HealthAssesmentUserQuestionGroupResults', 'HFit_HealthAssesmentUserRiskArea', 'HFit_HealthAssesmentUserRiskCategory', 'HFit_HealthAssesmentUserStarted', 'HFit_HealthAssessment', 'HFit_HealthAssessmentFreeForm', 'HFit_HES_Award', 'HFit_LKP_Frequency', 'HFit_LKP_GoalCloseReason', 'HFit_LKP_GoalStatus', 'HFit_LKP_HES_AwardType', 'HFit_LKP_RewardActivity', 'HFit_LKP_RewardLevelType', 'HFit_LKP_RewardTrigger', 'HFit_LKP_RewardTriggerParameterOperator', 'HFit_LKP_RewardType', 'HFit_LKP_TrackerVendor', 'HFit_LKP_UnitOfMeasure', 'HFit_OutComeMessages', 'HFit_PPTEligibility', 'HFit_RewardActivity', 'HFit_RewardException', 'HFit_RewardGroup', 'HFit_RewardLevel', 'HFit_RewardProgram', 'HFit_RewardsAwardUserDetail', 'HFit_RewardsUserActivityDetail', 'HFit_RewardsUserLevelDetail', 'HFit_RewardTrigger', 'HFit_RewardTriggerParameter', 'Hfit_SmallStepResponses', 'HFit_Tobacco_Goal', 'HFit_ToDoSmallSteps', 'HFIT_Tracker', 'HFit_TrackerBloodPressure', 'HFit_TrackerBloodSugarAndGlucose', 'HFit_TrackerBMI', 'HFit_TrackerBodyFat', 'HFit_TrackerBodyMeasurements', 'HFit_TrackerCardio', 'HFit_TrackerCholesterol', 'HFit_TrackerCollectionSource', 'HFit_TrackerCotinine', 'HFit_TrackerDailySteps', 'HFit_TrackerFlexibility', 'HFit_TrackerFruits', 'HFit_TrackerHbA1c', 'HFit_TrackerHeight', 'HFit_TrackerHighFatFoods', 'HFit_TrackerHighSodiumFoods', 'HFit_TrackerInstance_Tracker', 'HFit_TrackerMealPortions', 'HFit_TrackerMedicalCarePlan', 'HFit_TrackerPreventiveCare', 'HFit_TrackerRegularMeals', 'HFit_TrackerRestingHeartRate', 'HFit_TrackerShots', 'HFit_TrackerSitLess', 'HFit_TrackerSleepPlan', 'HFit_TrackerStrength', 'HFit_TrackerStress', 'HFit_TrackerStressManagement', 'HFit_TrackerSugaryDrinks', 'HFit_TrackerSugaryFoods', 'HFit_TrackerTests', 'HFit_TrackerTobaccoAttestation', 'HFit_TrackerTobaccoFree', 'HFit_TrackerVegetables', 'HFit_TrackerWater', 'HFit_TrackerWeight', 'HFit_TrackerWholeGrains', 'HFit_UserGoal', 'HFit_UserTracker', 'OM_ContactGroup', 'OM_ContactGroupMember') 
	   ORDER BY
				table_name, column_name;

--table_name	PK_COL
--CMS_Class	ClassID
--CMS_Document	DocumentID
--CMS_MembershipRole	MembershipID
--CMS_MembershipRole	RoleID
--CMS_MembershipUser	MembershipUserID
--CMS_Role	RoleID
--CMS_Site	SiteID
--CMS_Tree	NodeID
--CMS_User	UserID
--CMS_UserSettings	UserSettingsID
--CMS_UserSite	UserSiteID
--COM_SKU	SKUID
--HFit_Account	AccountID
--HFit_Coaches	ItemID
--HFit_CoachingHealthArea	CoachingHealthAreaID
--HFit_CoachingHealthInterest	CoachingHealthInterestID
--HFit_Company	CompanyID
--HFit_ContactGroupMembership	ContactGroupMembershipID
--HFit_Goal	GoalID
--HFit_GoalOutcome	GoalOutcomeID
--HFit_HACampaign	HACampaignID
--HFit_HealthAssesmentMatrixQuestion	HealthAssesmentMultipleChoiceQuestionID
--HFit_HealthAssesmentModule	HealthAssesmentModuleID
--HFit_HealthAssesmentMultipleChoiceQuestion	HealthAssesmentMultipleChoiceQuestionID
--HFit_HealthAssesmentPredefinedAnswer	HealthAssesmentPredefinedAnswerID
--HFit_HealthAssesmentRiskArea	HealthAssesmentRiskAreaID
--HFit_HealthAssesmentRiskCategory	HealthAssesmentRiskCategoryID
--HFit_HealthAssesmentUserAnswers	ItemID
--HFit_HealthAssesmentUserModule	ItemID
--HFit_HealthAssesmentUserQuestion	ItemID
--HFit_HealthAssesmentUserQuestionGroupResults	ItemID
--HFit_HealthAssesmentUserRiskArea	ItemID
--HFit_HealthAssesmentUserRiskCategory	ItemID
--HFit_HealthAssesmentUserStarted	ItemID
--HFit_HealthAssessment	HealthAssessmentID
--HFit_HealthAssessmentFreeForm	HealthAssesmentMultipleChoiceQuestionID
--HFit_HES_Award	ItemID
--HFit_LKP_Frequency	FrequencyID
--HFit_LKP_GoalCloseReason	CloseReasonID
--HFit_LKP_GoalStatus	GoalStatusLKPID
--HFit_LKP_HES_AwardType	ItemID
--HFit_LKP_RewardActivity	RewardActivityLKPID
--HFit_LKP_RewardLevelType	RewardLevelTypeLKPID
--HFit_LKP_RewardTrigger	RewardTriggerLKPID
--HFit_LKP_RewardTriggerParameterOperator	RewardTriggerParameterOperatorLKPID
--HFit_LKP_RewardType	RewardTypeLKPID
--HFit_LKP_TrackerVendor	ItemID
--HFit_LKP_UnitOfMeasure	UnitOfMeasureID
--HFit_OutComeMessages	OutComeMessagesID
--HFit_PPTEligibility	PPTID
--HFit_RewardActivity	RewardActivityID
--HFit_RewardException	RewardExceptionID
--HFit_RewardGroup	RewardGroupID
--HFit_RewardLevel	RewardLevelID
--HFit_RewardProgram	RewardProgramID
--HFit_RewardsAwardUserDetail	ItemID
--HFit_RewardsUserActivityDetail	ItemID
--HFit_RewardsUserLevelDetail	ItemID
--HFit_RewardTrigger	RewardTriggerID
--HFit_RewardTriggerParameter	RewardTriggerParameterID
--Hfit_SmallStepResponses	ItemID
--HFit_Tobacco_Goal	GoalID
--HFit_ToDoSmallSteps	ItemID
--HFIT_Tracker	ItemID
--HFit_TrackerBloodPressure	ItemID
--HFit_TrackerBloodSugarAndGlucose	ItemID
--HFit_TrackerBMI	ItemID
--HFit_TrackerBodyFat	ItemID
--HFit_TrackerBodyMeasurements	ItemID
--HFit_TrackerCardio	ItemID
--HFit_TrackerCholesterol	ItemID
--HFit_TrackerCollectionSource	ItemID
--HFit_TrackerCotinine	ItemID
--HFit_TrackerDailySteps	ItemID
--HFit_TrackerFlexibility	ItemID
--HFit_TrackerFruits	ItemID
--HFit_TrackerHbA1c	ItemID
--HFit_TrackerHeight	ItemID
--HFit_TrackerHighFatFoods	ItemID
--HFit_TrackerHighSodiumFoods	ItemID
--HFit_TrackerInstance_Tracker	ItemID
--HFit_TrackerMealPortions	ItemID
--HFit_TrackerMedicalCarePlan	ItemID
--HFit_TrackerPreventiveCare	ItemID
--HFit_TrackerRegularMeals	ItemID
--HFit_TrackerRestingHeartRate	ItemID
--HFit_TrackerShots	ItemID
--HFit_TrackerSitLess	ItemID
--HFit_TrackerSleepPlan	ItemID
--HFit_TrackerStrength	ItemID
--HFit_TrackerStress	ItemID
--HFit_TrackerStressManagement	ItemID
--HFit_TrackerSugaryDrinks	ItemID
--HFit_TrackerSugaryFoods	ItemID
--HFit_TrackerTests	ItemID
--HFit_TrackerTobaccoAttestation	ItemID
--HFit_TrackerTobaccoFree	ItemID
--HFit_TrackerVegetables	ItemID
--HFit_TrackerWater	ItemID
--HFit_TrackerWeight	ItemID
--HFit_TrackerWholeGrains	ItemID
--HFit_UserGoal	ItemID
--HFit_UserTracker	ItemID
--OM_ContactGroup	ContactGroupID
--OM_ContactGroupMember	ContactGroupMemberID
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
