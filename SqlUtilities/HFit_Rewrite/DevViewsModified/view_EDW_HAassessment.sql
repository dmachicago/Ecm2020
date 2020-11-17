
GO 
print ('Creating view_EDW_HAassessment');
if not exists(select name from sys.views where name = 'view_EDW_HAassessment')
BEGIN
set @SQL = 
	'create view view_EDW_HAassessment
		as
		SELECT [UserStartedItemID]
				,[HAQuestionNodeGUID]
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
				
			    , HAModuleNodeGUID				--WDM 8/7/2014 as HAModuleDocumentID
			    , CMSNodeGuid						--WDM 8/7/2014 as HAModuleDocumentID

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
				,[UserQuestionCodeName]
				,[HAQuestionVersionID]
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
				,HARiskCategory_ItemModifiedWhen 
				,HAUserRiskArea_ItemModifiedWhen 
				,HAUserQuestion_ItemModifiedWhen 
				,HAUserAnswers_ItemModifiedWhen 
			FROM [dbo].[EDW_HealthAssessment]' ; 
			  exec (@SQL) ;

	  GRANT SELECT ON view_EDW_HAassessment TO public;

END
print ('Created view_EDW_HAassessment');
GO