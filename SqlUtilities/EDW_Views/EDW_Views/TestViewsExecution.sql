select top 100 * from View_EDW_HealthAssesmentQuestions
select top 100 * from view_EDW_ClientCompany
select top 100 * from view_EDW_Coaches
select top 100 * from view_EDW_CoachingDefinition
select top 100 * from view_EDW_CoachingDetail
select top 100 * from View_EDW_HealthAssesmentAnswers
select top 100 * from view_EDW_HealthAssesmentClientView
select top 100 * from view_EDW_HealthAssesmentDeffinition
select top 100 * from view_EDW_HealthAssesmentDeffinitionCustom
select top 100 * from view_EDW_HealthAssessmentDefinition_Staged
select top 100 * from view_EDW_HealthAssessment_Staged
select top 100 * from view_EDW_Participant
select top 100 * from view_EDW_RewardAwardDetail
select top 100 * from view_EDW_RewardsDefinition
select top 100 * from view_EDW_RewardTriggerParameters
select top 100 * from view_EDW_ScreeningsFromTrackers
select top 100 * from view_EDW_TrackerCompositeDetails
select top 100 * from view_EDW_TrackerMetadata
select top 100 * from view_EDW_TrackerShots
select top 100 * from view_EDW_TrackerTests
select top 100 * from view_EDW_RewardUserDetail
select top 100 * from view_EDW_HAassessment
select top 100 * from view_EDW_HADefinition
Select  top 1000 * from view_EDW_HealthAssesment where 
ItemModifiedWhen between '2014-09-29 00:00:00.001' and '2014-09-30 00:00:00.000'
OR HARiskCategory_ItemModifiedWhen between '2014-09-29 00:00:00.001' and '2014-09-30 00:00:00.000'
OR HAUserRiskArea_ItemModifiedWhen between '2014-09-29 00:00:00.001' and '2014-09-30 00:00:00.000'
OR HAUserQuestion_ItemModifiedWhen between '2014-09-29 00:00:00.001' and '2014-09-30 00:00:00.000'
OR HAUserAnswers_ItemModifiedWhen between '2014-09-29 00:00:00.001' and '2014-09-30 00:00:00.000'  --  
  --  
GO 
print('***** FROM: TestViewsExecution.sql'); 
GO 
