print ('Processing: view_EDW_HealthAssessment_Staged ') ;
go

if exists(select TABLE_NAME from INFORMATION_SCHEMA.VIEWS where TABLE_NAME = 'view_EDW_HealthAssessment_Staged')
BEGIN
	drop view view_EDW_HealthAssessment_Staged ;
END
GO

create view [dbo].[view_EDW_HealthAssessment_Staged]
as
--****************************************************************************
--09/04/2014 WDM
--The view Health Assessment runs poorly. This view/table is created as 
--as a staging table allowing the data to already exist when the EDW needs it.
--This is the view that pulls data from the staging table (EDW_HealthAssessment) 
--allowing the EDW to launch a much faster start when processing Health 
--Assessment data.
--****************************************************************************

SELECT [UserStartedItemID]
      ,[HealthAssesmentUserStartedNodeGUID]
      ,[UserID]
      ,[UserGUID]
      ,[HFitUserMpiNumber]
      ,[SiteGUID]
      ,[AccountID]
      ,[AccountCD]
      ,[HAStartedDt]
      ,[HACompletedDt]
      ,[UserModuleItemId]
      ,[UserModuleCodeName]
      ,[HAModuleNodeGUID]
      ,[CMSNodeGuid]
      ,[HAModuleVersionID]
      ,[UserRiskCategoryItemID]
      ,[UserRiskCategoryCodeName]
      ,[HARiskCategoryNodeGUID]
      ,[HARiskCategoryVersionID]
      ,[UserRiskAreaItemID]
      ,[UserRiskAreaCodeName]
      ,[HARiskAreaNodeGUID]
      ,[HARiskAreaVersionID]
      ,[UserQuestionItemID]
      ,[Title]
      ,[HAQuestionGuid]
      ,[UserQuestionCodeName]
      ,[HAQuestionDocumentID]
      ,[HAQuestionVersionID]
      ,[HAQuestionNodeGUID]
      ,[UserAnswerItemID]
      ,[HAAnswerNodeGUID]
      ,[HAAnswerVersionID]
      ,[UserAnswerCodeName]
      ,[HAAnswerValue]
      ,[HAModuleScore]
      ,[HARiskCategoryScore]
      ,[HARiskAreaScore]
      ,[HAQuestionScore]
      ,[HAAnswerPoints]
      ,[PointResults]
      ,[UOMCode]
      ,[HAScore]
      ,[ModulePreWeightedScore]
      ,[RiskCategoryPreWeightedScore]
      ,[RiskAreaPreWeightedScore]
      ,[QuestionPreWeightedScore]
      ,[QuestionGroupCodeName]
      ,[ChangeType]
      ,[IsProfessionallyCollected]
      ,[ItemCreatedWhen]
      ,[ItemModifiedWhen]
      ,[HARiskCategory_ItemModifiedWhen]
      ,[HAUserRiskArea_ItemModifiedWhen]
      ,[HAUserQuestion_ItemModifiedWhen]
      ,[HAUserAnswers_ItemModifiedWhen]
  FROM [dbo].[EDW_HealthAssessment]
GO


