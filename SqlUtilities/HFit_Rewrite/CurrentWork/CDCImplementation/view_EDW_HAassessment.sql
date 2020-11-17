

-- WDM 07.15.2014 THIS VIEW was created so John C. can look at the base table
create view [dbo].[view_EDW_HAassessment]
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
			FROM [dbo].[EDW_HealthAssessment]
GO


