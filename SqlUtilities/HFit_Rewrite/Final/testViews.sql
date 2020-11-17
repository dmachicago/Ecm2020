Select top 100 * from View_EDW_HealthAssesmentQuestions
GO
--Select top 100 * from view_EDW_HFit_HealthAssesmentUserRiskArea
GO
Select top 100 * from view_EDW_HAassessment
GO
Select top 100 * from view_EDW_ClientCompany
GO
Select top 100 * from view_EDW_Coaches
GO
Select top 100 * from view_EDW_CoachingDefinition
GO
--Select top 100 * from view_EDW_HARiskCategoryNodeGUID
GO
Select top 100 * from view_EDW_CoachingDetail
GO
Select top 100 * from View_EDW_HealthAssesmentAnswers
GO
Select top 100 * from view_EDW_HealthAssesmentClientView
GO
Select top 100 * from view_EDW_HealthAssesmentDeffinition
GO
Select top 100 * from view_EDW_HealthAssesmentDeffinitionCustom
GO
--Select top 100 * from view_EDW_HFit_HealthAssesmentUserAnswers
GO
--Select top 100 * from view_EDW_HFit_HealthAssesmentUserModule
GO
--Select top 100 * from view_EDW_HFit_HealthAssesmentUserQuestion
GO
--Select top 100 * from view_EDW_HFit_HealthAssesmentUserRiskCategory
GO
Select top 100 * from view_EDW_QuestionNodeGuid
GO
--Select top 100 * from view_EDW_HFit_HealthAssesmentUserStarted
GO
Select top 100 * from view_EDW_Participant
GO
Select top 100 * from view_EDW_HAModuleNodeGUID
GO
Select top 100 * from view_EDW_RewardAwardDetail
GO
Select top 100 * from view_EDW_RewardsDefinition
GO
Select top 100 * from view_EDW_RewardTriggerParameters
GO
Select top 100 * from view_EDW_RewardUserDetail
GO
Select top 100 * from view_EDW_ScreeningsFromTrackers
GO
Select top 100 * from view_EDW_TrackerCompositeDetails
GO
Select top 100 * from view_EDW_TrackerMetadata
GO
Select top 100 * from view_EDW_TrackerShots
GO
Select top 100 * from view_EDW_TrackerTests
GO
Select top 100 * from view_EDW_HealthAssesment where 
ItemModifiedWhen between '2014-08-02 00:00:00.001' and '2014-08-03 00:00:00.000'
OR HARiskCategory_ItemModifiedWhen between '2014-08-02 00:00:00.001' and '2014-08-03 00:00:00.000'
OR HAUserRiskArea_ItemModifiedWhen between '2014-08-02 00:00:00.001' and '2014-08-03 00:00:00.000'
OR HAUserQuestion_ItemModifiedWhen between '2014-08-02 00:00:00.001' and '2014-08-03 00:00:00.000'
OR HAUserAnswers_ItemModifiedWhen between '2014-08-02 00:00:00.001' and '2014-08-03 00:00:00.000'
GO