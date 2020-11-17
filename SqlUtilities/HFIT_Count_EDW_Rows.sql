
create table #TEMPCNTS (tblname varchar(80), cnt int)

truncate table #TEMPCNTS ;
declare @cnt int ;
declare @tbl varchar(80) ;

set @tbl = 'View_CMS_Tree_Joined';
set @cnt = (select count(*) from View_CMS_Tree_Joined);
insert into #TEMPCNTS (tblname, cnt) values (@tbl, @cnt);

set @tbl = 'View_CMS_Tree_Joined_Linked';
set @cnt = (select count(*) from View_CMS_Tree_Joined_Linked);
insert into #TEMPCNTS (tblname, cnt) values (@tbl, @cnt);

set @tbl = 'View_CMS_Tree_Joined_Regular';
set @cnt = (select count(*) from View_CMS_Tree_Joined_Regular);
insert into #TEMPCNTS (tblname, cnt) values (@tbl, @cnt);

set @tbl = 'View_COM_SKU';
set @cnt = (select count(*) from View_COM_SKU);
insert into #TEMPCNTS (tblname, cnt) values (@tbl, @cnt);

set @tbl = 'View_EDW_CDC_HealthAssesmentUserAnswers';
set @cnt = (select count(*) from View_EDW_CDC_HealthAssesmentUserAnswers);
insert into #TEMPCNTS (tblname, cnt) values (@tbl, @cnt);

--set @tbl = 'view_EDW_HealthAssesment';
--set @cnt = (select count(*) from view_EDW_HealthAssesment);
--insert into #TEMPCNTS (tblname, cnt) values (@tbl, @cnt);

set @tbl = 'view_EDW_HealthAssesmentClientView';
set @cnt = (select count(*) from view_EDW_HealthAssesmentClientView);
insert into #TEMPCNTS (tblname, cnt) values (@tbl, @cnt);

set @tbl = 'view_EDW_HealthAssesmentDeffinition';
set @cnt = (select count(*) from view_EDW_HealthAssesmentDeffinition);
insert into #TEMPCNTS (tblname, cnt) values (@tbl, @cnt);

set @tbl = 'view_EDW_HealthAssesmentDeffinitionCustom';
set @cnt = (select count(*) from view_EDW_HealthAssesmentDeffinitionCustom);
insert into #TEMPCNTS (tblname, cnt) values (@tbl, @cnt);

set @tbl = 'view_EDW_Participant';
set @cnt = (select count(*) from view_EDW_Participant);
insert into #TEMPCNTS (tblname, cnt) values (@tbl, @cnt);

set @tbl = 'view_EDW_RewardAwardDetail';
set @cnt = (select count(*) from view_EDW_RewardAwardDetail);
insert into #TEMPCNTS (tblname, cnt) values (@tbl, @cnt);

set @tbl = 'view_EDW_RewardsDefinition';
set @cnt = (select count(*) from view_EDW_RewardsDefinition);
insert into #TEMPCNTS (tblname, cnt) values (@tbl, @cnt);

set @tbl = 'view_EDW_RewardTriggerParameters';
set @cnt = (select count(*) from view_EDW_RewardTriggerParameters);
insert into #TEMPCNTS (tblname, cnt) values (@tbl, @cnt);

set @tbl = 'view_EDW_RewardUserDetail';
set @cnt = (select count(*) from view_EDW_RewardUserDetail);
insert into #TEMPCNTS (tblname, cnt) values (@tbl, @cnt);

set @tbl = 'view_EDW_ScreeningsFromTrackers';
set @cnt = (select count(*) from view_EDW_ScreeningsFromTrackers);
insert into #TEMPCNTS (tblname, cnt) values (@tbl, @cnt);

set @tbl = 'view_EDW_TrackerShots';
set @cnt = (select count(*) from view_EDW_TrackerShots);
insert into #TEMPCNTS (tblname, cnt) values (@tbl, @cnt);

set @tbl = 'view_EDW_TrackerTests';
set @cnt = (select count(*) from view_EDW_TrackerTests);
insert into #TEMPCNTS (tblname, cnt) values (@tbl, @cnt);

set @tbl = 'View_HFit_HACampaign_Joined';
set @cnt = (select count(*) from View_HFit_HACampaign_Joined);
insert into #TEMPCNTS (tblname, cnt) values (@tbl, @cnt);

set @tbl = 'View_HFit_HealthAssesmentAnswers';
set @cnt = (select count(*) from View_HFit_HealthAssesmentAnswers);
insert into #TEMPCNTS (tblname, cnt) values (@tbl, @cnt);

set @tbl = 'View_HFit_HealthAssesmentMatrixQuestion_Joined';
set @cnt = (select count(*) from View_HFit_HealthAssesmentMatrixQuestion_Joined);
insert into #TEMPCNTS (tblname, cnt) values (@tbl, @cnt);

set @tbl = 'View_HFit_HealthAssesmentModule_Joined';
set @cnt = (select count(*) from View_HFit_HealthAssesmentModule_Joined);
insert into #TEMPCNTS (tblname, cnt) values (@tbl, @cnt);

set @tbl = 'View_HFit_HealthAssesmentMultipleChoiceQuestion_Joined';
set @cnt = (select count(*) from View_HFit_HealthAssesmentMultipleChoiceQuestion_Joined);
insert into #TEMPCNTS (tblname, cnt) values (@tbl, @cnt);

set @tbl = 'View_HFit_HealthAssesmentPredefinedAnswer_Joined';
set @cnt = (select count(*) from View_HFit_HealthAssesmentPredefinedAnswer_Joined);
insert into #TEMPCNTS (tblname, cnt) values (@tbl, @cnt);

set @tbl = 'View_HFit_HealthAssesmentQuestions';
set @cnt = (select count(*) from View_HFit_HealthAssesmentQuestions);
insert into #TEMPCNTS (tblname, cnt) values (@tbl, @cnt);

set @tbl = 'View_HFit_HealthAssesmentRiskArea_Joined';
set @cnt = (select count(*) from View_HFit_HealthAssesmentRiskArea_Joined);
insert into #TEMPCNTS (tblname, cnt) values (@tbl, @cnt);

set @tbl = 'View_HFit_HealthAssesmentRiskCategory_Joined';
set @cnt = (select count(*) from View_HFit_HealthAssesmentRiskCategory_Joined);
insert into #TEMPCNTS (tblname, cnt) values (@tbl, @cnt);

set @tbl = 'View_HFit_HealthAssessment_Joined';
set @cnt = (select count(*) from View_HFit_HealthAssessment_Joined);
insert into #TEMPCNTS (tblname, cnt) values (@tbl, @cnt);

set @tbl = 'View_HFit_HealthAssessmentFreeForm_Joined';
set @cnt = (select count(*) from View_HFit_HealthAssessmentFreeForm_Joined);
insert into #TEMPCNTS (tblname, cnt) values (@tbl, @cnt);

set @tbl = 'View_HFit_RewardActivity_Joined';
set @cnt = (select count(*) from View_HFit_RewardActivity_Joined);
insert into #TEMPCNTS (tblname, cnt) values (@tbl, @cnt);

set @tbl = 'View_HFit_RewardDefaultSettings_Joined';
set @cnt = (select count(*) from View_HFit_RewardDefaultSettings_Joined);
insert into #TEMPCNTS (tblname, cnt) values (@tbl, @cnt);

set @tbl = 'View_HFit_RewardGroup_Joined';
set @cnt = (select count(*) from View_HFit_RewardGroup_Joined);
insert into #TEMPCNTS (tblname, cnt) values (@tbl, @cnt);

set @tbl = 'View_HFIT_RewardGroupWithContactGroupIDs';
set @cnt = (select count(*) from View_HFIT_RewardGroupWithContactGroupIDs);
insert into #TEMPCNTS (tblname, cnt) values (@tbl, @cnt);

set @tbl = 'View_HFit_RewardLevel_Joined';
set @cnt = (select count(*) from View_HFit_RewardLevel_Joined);
insert into #TEMPCNTS (tblname, cnt) values (@tbl, @cnt);

set @tbl = 'View_HFit_RewardProgram_Joined';
set @cnt = (select count(*) from View_HFit_RewardProgram_Joined);
insert into #TEMPCNTS (tblname, cnt) values (@tbl, @cnt);

set @tbl = 'View_HFit_RewardsAboutInfoItem_Joined';
set @cnt = (select count(*) from View_HFit_RewardsAboutInfoItem_Joined);
insert into #TEMPCNTS (tblname, cnt) values (@tbl, @cnt);

set @tbl = 'View_HFit_RewardTrigger_Joined';
set @cnt = (select count(*) from View_HFit_RewardTrigger_Joined);
insert into #TEMPCNTS (tblname, cnt) values (@tbl, @cnt);

set @tbl = 'View_HFit_RewardTriggerParameter_Joined';
set @cnt = (select count(*) from View_HFit_RewardTriggerParameter_Joined);
insert into #TEMPCNTS (tblname, cnt) values (@tbl, @cnt);

set @tbl = 'view_HFit_TrackerCompositeDetails';
set @cnt = (select count(*) from View_HFit_RewardTriggerParameter_Joined);
insert into #TEMPCNTS (tblname, cnt) values (@tbl, @cnt);

set @tbl = 'CMS_Class';
set @cnt = (select count(*) from CMS_Class) ;
insert into #TEMPCNTS (tblname, cnt) values (@tbl, @cnt);

set @tbl = 'CMS_Document';
set @cnt = (select count(*) from CMS_Document) ;
insert into #TEMPCNTS (tblname, cnt) values (@tbl, @cnt);

set @tbl = 'CMS_Site';
set @cnt = (select count(*) from CMS_Site) ;
insert into #TEMPCNTS (tblname, cnt) values (@tbl, @cnt);

set @tbl = 'CMS_Tree';
set @cnt = (select count(*) from CMS_Tree) ;
insert into #TEMPCNTS (tblname, cnt) values (@tbl, @cnt);

set @tbl = 'CMS_User';
set @cnt = (select count(*) from CMS_User) ;
insert into #TEMPCNTS (tblname, cnt) values (@tbl, @cnt);

set @tbl = 'CMS_UserSettings';
set @cnt = (select count(*) from CMS_UserSettings) ;
insert into #TEMPCNTS (tblname, cnt) values (@tbl, @cnt);

set @tbl = 'CMS_UserSite';
set @cnt = (select count(*) from CMS_UserSite) ;
insert into #TEMPCNTS (tblname, cnt) values (@tbl, @cnt);

set @tbl = 'COM_SKU';
set @cnt = (select count(*) from COM_SKU) ;
insert into #TEMPCNTS (tblname, cnt) values (@tbl, @cnt);

set @tbl = 'cdc.dbo_HFit_HealthAssesmentUserAnswers_CT';
set @cnt = (select count(*) from cdc.dbo_HFit_HealthAssesmentUserAnswers_CT) ;
insert into #TEMPCNTS (tblname, cnt) values (@tbl, @cnt);

set @tbl = 'HFit_Account';
set @cnt = (select count(*) from HFit_Account) ;
insert into #TEMPCNTS (tblname, cnt) values (@tbl, @cnt);

set @tbl = 'HFit_HACampaign';
set @cnt = (select count(*) from HFit_HACampaign) ;
insert into #TEMPCNTS (tblname, cnt) values (@tbl, @cnt);

set @tbl = 'HFit_HealthAssesmentMatrixQuestion';
set @cnt = (select count(*) from HFit_HealthAssesmentMatrixQuestion) ;
insert into #TEMPCNTS (tblname, cnt) values (@tbl, @cnt);

set @tbl = 'HFit_HealthAssesmentModule';
set @cnt = (select count(*) from HFit_HealthAssesmentModule) ;
insert into #TEMPCNTS (tblname, cnt) values (@tbl, @cnt);

set @tbl = 'HFit_HealthAssesmentMultipleChoiceQuestion';
set @cnt = (select count(*) from HFit_HealthAssesmentMultipleChoiceQuestion) ;
insert into #TEMPCNTS (tblname, cnt) values (@tbl, @cnt);

set @tbl = 'HFit_HealthAssesmentPredefinedAnswer';
set @cnt = (select count(*) from HFit_HealthAssesmentPredefinedAnswer) ;
insert into #TEMPCNTS (tblname, cnt) values (@tbl, @cnt);

set @tbl = 'HFit_HealthAssesmentRiskArea';
set @cnt = (select count(*) from HFit_HealthAssesmentRiskArea) ;
insert into #TEMPCNTS (tblname, cnt) values (@tbl, @cnt);

set @tbl = 'HFit_HealthAssesmentRiskCategory';
set @cnt = (select count(*) from HFit_HealthAssesmentRiskCategory) ;
insert into #TEMPCNTS (tblname, cnt) values (@tbl, @cnt);

set @tbl = 'HFit_HealthAssesmentUserAnswers';
set @cnt = (select count(*) from HFit_HealthAssesmentUserAnswers) ;
insert into #TEMPCNTS (tblname, cnt) values (@tbl, @cnt);

set @tbl = 'HFit_HealthAssesmentUserModule';
set @cnt = (select count(*) from HFit_HealthAssesmentUserModule) ;
insert into #TEMPCNTS (tblname, cnt) values (@tbl, @cnt);

set @tbl = 'HFit_HealthAssesmentUserQuestion';
set @cnt = (select count(*) from HFit_HealthAssesmentUserQuestion) ;
insert into #TEMPCNTS (tblname, cnt) values (@tbl, @cnt);

set @tbl = 'HFit_HealthAssesmentUserQuestionGroupResults';
set @cnt = (select count(*) from HFit_HealthAssesmentUserQuestionGroupResults) ;
insert into #TEMPCNTS (tblname, cnt) values (@tbl, @cnt);

set @tbl = 'HFit_HealthAssesmentUserRiskArea';
set @cnt = (select count(*) from HFit_HealthAssesmentUserRiskArea) ;
insert into #TEMPCNTS (tblname, cnt) values (@tbl, @cnt);

set @tbl = 'HFit_HealthAssesmentUserRiskCategory';
set @cnt = (select count(*) from HFit_HealthAssesmentUserRiskCategory) ;
insert into #TEMPCNTS (tblname, cnt) values (@tbl, @cnt);

set @tbl = 'HFit_HealthAssesmentUserStarted';
set @cnt = (select count(*) from HFit_HealthAssesmentUserStarted) ;
insert into #TEMPCNTS (tblname, cnt) values (@tbl, @cnt);

set @tbl = 'HFit_HealthAssessment';
set @cnt = (select count(*) from HFit_HealthAssessment) ;
insert into #TEMPCNTS (tblname, cnt) values (@tbl, @cnt);

set @tbl = 'HFit_HealthAssessmentFreeForm';
set @cnt = (select count(*) from HFit_HealthAssessmentFreeForm) ;
insert into #TEMPCNTS (tblname, cnt) values (@tbl, @cnt);

set @tbl = 'HFit_LKP_RewardLevelType';
set @cnt = (select count(*) from HFit_LKP_RewardLevelType) ;
insert into #TEMPCNTS (tblname, cnt) values (@tbl, @cnt);

set @tbl = 'HFit_LKP_RewardTrigger';
set @cnt = (select count(*) from HFit_LKP_RewardTrigger) ;
insert into #TEMPCNTS (tblname, cnt) values (@tbl, @cnt);

set @tbl = 'HFit_LKP_RewardTriggerParameterOperator';
set @cnt = (select count(*) from HFit_LKP_RewardTriggerParameterOperator) ;
insert into #TEMPCNTS (tblname, cnt) values (@tbl, @cnt);

set @tbl = 'HFit_LKP_RewardType';
set @cnt = (select count(*) from HFit_LKP_RewardType) ;
insert into #TEMPCNTS (tblname, cnt) values (@tbl, @cnt);

set @tbl = 'HFit_PPTEligibility';
set @cnt = (select count(*) from HFit_PPTEligibility) ;
insert into #TEMPCNTS (tblname, cnt) values (@tbl, @cnt);

set @tbl = 'HFit_RewardActivity';
set @cnt = (select count(*) from HFit_RewardActivity) ;
insert into #TEMPCNTS (tblname, cnt) values (@tbl, @cnt);

set @tbl = 'HFit_RewardDefaultSettings';
set @cnt = (select count(*) from HFit_RewardDefaultSettings) ;
insert into #TEMPCNTS (tblname, cnt) values (@tbl, @cnt);

set @tbl = 'HFit_RewardException';
set @cnt = (select count(*) from HFit_RewardException) ;
insert into #TEMPCNTS (tblname, cnt) values (@tbl, @cnt);

set @tbl = 'HFit_RewardGroup';
set @cnt = (select count(*) from HFit_RewardGroup) ;
insert into #TEMPCNTS (tblname, cnt) values (@tbl, @cnt);

set @tbl = 'HFit_RewardLevel';
set @cnt = (select count(*) from HFit_RewardLevel) ;
insert into #TEMPCNTS (tblname, cnt) values (@tbl, @cnt);

set @tbl = 'HFit_RewardProgram';
set @cnt = (select count(*) from HFit_RewardProgram) ;
insert into #TEMPCNTS (tblname, cnt) values (@tbl, @cnt);

set @tbl = 'HFit_RewardsAboutInfoItem';
set @cnt = (select count(*) from HFit_RewardsAboutInfoItem) ;
insert into #TEMPCNTS (tblname, cnt) values (@tbl, @cnt);

set @tbl = 'HFit_RewardsAwardUserDetail';
set @cnt = (select count(*) from HFit_RewardsAwardUserDetail) ;
insert into #TEMPCNTS (tblname, cnt) values (@tbl, @cnt);

set @tbl = 'HFit_RewardsUserActivityDetail';
set @cnt = (select count(*) from HFit_RewardsUserActivityDetail) ;
insert into #TEMPCNTS (tblname, cnt) values (@tbl, @cnt);

set @tbl = 'HFit_RewardsUserLevelDetail';
set @cnt = (select count(*) from HFit_RewardsUserLevelDetail) ;
insert into #TEMPCNTS (tblname, cnt) values (@tbl, @cnt);

set @tbl = 'HFit_RewardTrigger';
set @cnt = (select count(*) from HFit_RewardTrigger) ;
insert into #TEMPCNTS (tblname, cnt) values (@tbl, @cnt);

set @tbl = 'HFit_RewardTriggerParameter';
set @cnt = (select count(*) from HFit_RewardTriggerParameter) ;
insert into #TEMPCNTS (tblname, cnt) values (@tbl, @cnt);

set @tbl = 'HFit_TrackerBloodPressure';
set @cnt = (select count(*) from HFit_TrackerBloodPressure) ;
insert into #TEMPCNTS (tblname, cnt) values (@tbl, @cnt);

set @tbl = 'HFit_TrackerBloodSugarAndGlucose';
set @cnt = (select count(*) from HFit_TrackerBloodSugarAndGlucose) ;
insert into #TEMPCNTS (tblname, cnt) values (@tbl, @cnt);

set @tbl = 'HFit_TrackerBMI';
set @cnt = (select count(*) from HFit_TrackerBMI) ;
insert into #TEMPCNTS (tblname, cnt) values (@tbl, @cnt);

set @tbl = 'HFit_TrackerBodyFat';
set @cnt = (select count(*) from HFit_TrackerBodyFat) ;
insert into #TEMPCNTS (tblname, cnt) values (@tbl, @cnt);

set @tbl = 'HFit_TrackerBodyMeasurements';
set @cnt = (select count(*) from HFit_TrackerBodyMeasurements) ;
insert into #TEMPCNTS (tblname, cnt) values (@tbl, @cnt);

set @tbl = 'HFit_TrackerCardio';
set @cnt = (select count(*) from HFit_TrackerCardio) ;
insert into #TEMPCNTS (tblname, cnt) values (@tbl, @cnt);

set @tbl = 'HFit_TrackerCholesterol';
set @cnt = (select count(*) from HFit_TrackerCholesterol) ;
insert into #TEMPCNTS (tblname, cnt) values (@tbl, @cnt);

set @tbl = 'HFit_TrackerCollectionSource';
set @cnt = (select count(*) from HFit_TrackerCollectionSource) ;
insert into #TEMPCNTS (tblname, cnt) values (@tbl, @cnt);

set @tbl = 'HFit_TrackerDailySteps';
set @cnt = (select count(*) from HFit_TrackerDailySteps) ;
insert into #TEMPCNTS (tblname, cnt) values (@tbl, @cnt);

set @tbl = 'HFit_TrackerFlexibility';
set @cnt = (select count(*) from HFit_TrackerFlexibility) ;
insert into #TEMPCNTS (tblname, cnt) values (@tbl, @cnt);

set @tbl = 'HFit_TrackerFruits';
set @cnt = (select count(*) from HFit_TrackerFruits) ;
insert into #TEMPCNTS (tblname, cnt) values (@tbl, @cnt);

set @tbl = 'HFit_TrackerHbA1c';
set @cnt = (select count(*) from HFit_TrackerHbA1c) ;
insert into #TEMPCNTS (tblname, cnt) values (@tbl, @cnt);

set @tbl = 'HFit_TrackerHeight';
set @cnt = (select count(*) from HFit_TrackerHeight) ;
insert into #TEMPCNTS (tblname, cnt) values (@tbl, @cnt);

set @tbl = 'HFit_TrackerHighFatFoods';
set @cnt = (select count(*) from HFit_TrackerHighFatFoods) ;
insert into #TEMPCNTS (tblname, cnt) values (@tbl, @cnt);

set @tbl = 'HFit_TrackerHighSodiumFoods';
set @cnt = (select count(*) from HFit_TrackerHighSodiumFoods) ;
insert into #TEMPCNTS (tblname, cnt) values (@tbl, @cnt);

set @tbl = 'HFit_TrackerInstance_Tracker';
set @cnt = (select count(*) from HFit_TrackerInstance_Tracker) ;
insert into #TEMPCNTS (tblname, cnt) values (@tbl, @cnt);

set @tbl = 'HFit_TrackerMealPortions';
set @cnt = (select count(*) from HFit_TrackerMealPortions) ;
insert into #TEMPCNTS (tblname, cnt) values (@tbl, @cnt);

set @tbl = 'HFit_TrackerMedicalCarePlan';
set @cnt = (select count(*) from HFit_TrackerMedicalCarePlan) ;
insert into #TEMPCNTS (tblname, cnt) values (@tbl, @cnt);

set @tbl = 'HFit_TrackerRegularMeals';
set @cnt = (select count(*) from HFit_TrackerRegularMeals) ;
insert into #TEMPCNTS (tblname, cnt) values (@tbl, @cnt);

set @tbl = 'HFit_TrackerRestingHeartRate';
set @cnt = (select count(*) from HFit_TrackerRestingHeartRate) ;
insert into #TEMPCNTS (tblname, cnt) values (@tbl, @cnt);

set @tbl = 'HFit_TrackerShots';
set @cnt = (select count(*) from HFit_TrackerShots) ;
insert into #TEMPCNTS (tblname, cnt) values (@tbl, @cnt);

set @tbl = 'HFit_TrackerSitLess';
set @cnt = (select count(*) from HFit_TrackerSitLess) ;
insert into #TEMPCNTS (tblname, cnt) values (@tbl, @cnt);

set @tbl = 'HFit_TrackerSleepPlan';
set @cnt = (select count(*) from HFit_TrackerSleepPlan) ;
insert into #TEMPCNTS (tblname, cnt) values (@tbl, @cnt);

set @tbl = 'HFit_TrackerStrength';
set @cnt = (select count(*) from HFit_TrackerStrength) ;
insert into #TEMPCNTS (tblname, cnt) values (@tbl, @cnt);

set @tbl = 'HFit_TrackerStress';
set @cnt = (select count(*) from HFit_TrackerStress) ;
insert into #TEMPCNTS (tblname, cnt) values (@tbl, @cnt);

set @tbl = 'HFit_TrackerStressManagement';
set @cnt = (select count(*) from HFit_TrackerStressManagement) ;
insert into #TEMPCNTS (tblname, cnt) values (@tbl, @cnt);

set @tbl = 'HFit_TrackerSugaryDrinks';
set @cnt = (select count(*) from HFit_TrackerSugaryDrinks) ;
insert into #TEMPCNTS (tblname, cnt) values (@tbl, @cnt);

set @tbl = 'HFit_TrackerSugaryFoods';
set @cnt = (select count(*) from HFit_TrackerSugaryFoods) ;
insert into #TEMPCNTS (tblname, cnt) values (@tbl, @cnt);

set @tbl = 'HFit_TrackerTests';
set @cnt = (select count(*) from HFit_TrackerTests) ;
insert into #TEMPCNTS (tblname, cnt) values (@tbl, @cnt);

set @tbl = 'HFit_TrackerTobaccoFree';
set @cnt = (select count(*) from HFit_TrackerTobaccoFree) ;
insert into #TEMPCNTS (tblname, cnt) values (@tbl, @cnt);

set @tbl = 'HFit_TrackerVegetables';
set @cnt = (select count(*) from HFit_TrackerVegetables) ;
insert into #TEMPCNTS (tblname, cnt) values (@tbl, @cnt);

set @tbl = 'HFit_TrackerWater';
set @cnt = (select count(*) from HFit_TrackerWater) ;
insert into #TEMPCNTS (tblname, cnt) values (@tbl, @cnt);

set @tbl = 'HFit_TrackerWeight';
set @cnt = (select count(*) from HFit_TrackerWeight) ;
insert into #TEMPCNTS (tblname, cnt) values (@tbl, @cnt);

set @tbl = 'HFit_TrackerWholeGrains';
set @cnt = (select count(*) from HFit_TrackerWholeGrains) ;
insert into #TEMPCNTS (tblname, cnt) values (@tbl, @cnt);

set @tbl = 'cdc.lsn_time_mapping';
set @cnt = (select count(*) from cdc.lsn_time_mapping) ;
insert into #TEMPCNTS (tblname, cnt) values (@tbl, @cnt);


select * from #TEMPCNTS 
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
