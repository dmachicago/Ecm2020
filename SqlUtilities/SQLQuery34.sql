USE [KenticoCMS_DEV]
GO

/****** Object:  View [dbo].[view_EDW_HealthAssesment]    Script Date: 8/18/2014 10:07:55 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


alter VIEW [dbo].[view_EDW_HealthAssesment]
AS
--7/15/2014 17:19 min. 46,750 Rows DEV
--7/15/2014 per Mark Turner
--HAModuleDocumentID is on its way out, so is - 
--Module - RiskCategory - RiskArea - Question - Answer 
--all the "DocumentID" fields are deprecated and replaced by corresponding NodeGUID fields
--8/7/2014 - Executed in DEV with GUID changes and returned 51K Rows in 43:10.
--8/8/2014 - Generated corrected view in DEV
	SELECT  
		HAUserStarted.ItemID AS UserStartedItemID

		--, HAUserModule.HAModuleNodeGUID							--WDM 8/7/2014 as HAModuleDocumentID
		--, HARiskCategory.HARiskCategoryNodeGUID						--WDM 8/7/2014 as HARiskCategoryDocumentID

		, HAUserQuestion.HAQuestionNodeGUID as HADocumentGUID		--WDM 8/7/2014  as HADocumentID
		, HAUserStarted.UserID
		, CMSUser.UserGUID
		, UserSettings.HFitUserMpiNumber
		, CMSSite.SiteGUID
		, ACCT.AccountID
		, ACCT.AccountCD
		, HAUserStarted.HAStartedDt
		, HAUserStarted.HACompletedDt
		, HAUserModule.ItemID AS UserModuleItemId
		, HAUserModule.CodeName AS UserModuleCodeName
		, HAUserModule.HAModuleNodeGUID							--WDM 8/7/2014 as HAModuleDocumentID
		, NULL as HAModuleVersionID
		, HARiskCategory.ItemID AS UserRiskCategoryItemID
		, HARiskCategory.CodeName AS UserRiskCategoryCodeName
		, HARiskCategory.HARiskCategoryNodeGUID						--WDM 8/7/2014 as HARiskCategoryDocumentID
		, NULL as HARiskCategoryVersionID
		, HAUserRiskArea.ItemID AS UserRiskAreaItemID
		, HAUserRiskArea.CodeName AS UserRiskAreaCodeName
		, HAUserRiskArea.HARiskAreaNodeGUID								--WDM 8/7/2014 as HARiskAreaDocumentID
		, NULL as HARiskAreaVersionID
		, HAUserQuestion.ItemID AS UserQuestionItemID
		, HAQuestionsView.Title
		, HAUserQuestion.CodeName AS UserQuestionCodeName
		, HAUserQuestion.HAQuestionNodeGUID								--WDM 8/7/2014 as HAQuestionDocumentID
		, NULL as HAQuestionVersionID
		, HAUserAnswers.ItemID AS UserAnswerItemID
		, HAUserAnswers.HAAnswerNodeGUID									--WDM 8/7/2014 as HAAnswerDocumentID
		, NULL as HAAnswerVersionID
		, HAUserAnswers.CodeName AS UserAnswerCodeName
		, HAUserAnswers.HAAnswerValue
		, HAUserModule.HAModuleScore
		, HARiskCategory.HARiskCategoryScore
		, HAUserRiskArea.HARiskAreaScore
		, HAUserQuestion.HAQuestionScore
		, HAUserAnswers.HAAnswerPoints
		, HAUserQuestionGroupResults.PointResults
		, HAUserAnswers.UOMCode
		, HAUserStarted.HAScore
		, HAUserModule.PreWeightedScore AS ModulePreWeightedScore
		, HARiskCategory.PreWeightedScore AS RiskCategoryPreWeightedScore
		, HAUserRiskArea.PreWeightedScore AS RiskAreaPreWeightedScore
		, HAUserQuestion.PreWeightedScore AS QuestionPreWeightedScore
		, HAUserQuestionGroupResults.CodeName AS QuestionGroupCodeName		
       ,CASE WHEN HAUserAnswers.ItemCreatedWhen = HAUserAnswers.ItemModifiedWhen THEN 'I'
             ELSE 'U'
        END AS ChangeType
       ,HAUserAnswers.ItemCreatedWhen
       ,HAUserAnswers.ItemModifiedWhen
		
	FROM
	dbo.HFit_HealthAssesmentUserStarted AS HAUserStarted
	INNER JOIN dbo.CMS_User AS CMSUser ON HAUserStarted.UserID = CMSUser.UserID
	INNER JOIN dbo.CMS_UserSettings AS UserSettings ON UserSettings.UserSettingsUserID = CMSUser.UserID
	INNER JOIN dbo.CMS_UserSite AS UserSite ON CMSUser.UserID = UserSite.UserID
	INNER JOIN dbo.CMS_Site AS CMSSite ON UserSite.SiteID = CMSSite.SiteID
	INNER JOIN dbo.HFit_Account AS ACCT ON ACCT.SiteID = CMSSite.SiteID
	INNER JOIN dbo.HFit_HealthAssesmentUserModule AS HAUserModule ON HAUserStarted.ItemID = HAUserModule.HAStartedItemID
	INNER JOIN dbo.HFit_HealthAssesmentUserRiskCategory AS HARiskCategory ON HAUserModule.ItemID = HARiskCategory.HAModuleItemID
	INNER JOIN dbo.HFit_HealthAssesmentUserRiskArea AS HAUserRiskArea ON HARiskCategory.ItemID = HAUserRiskArea.HARiskCategoryItemID
	INNER JOIN dbo.HFit_HealthAssesmentUserQuestion AS HAUserQuestion ON HAUserRiskArea.ItemID = HAUserQuestion.HARiskAreaItemID
	INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS HAQuestionsView ON HAUserQuestion.HAQuestionNodeGUID = HAQuestionsView.NodeGUID
	LEFT OUTER JOIN dbo.HFit_HealthAssesmentUserQuestionGroupResults AS HAUserQuestionGroupResults ON HAUserQuestion.ItemID = HAUserQuestionGroupResults.HARiskAreaItemID
	INNER JOIN dbo.HFit_HealthAssesmentUserAnswers AS HAUserAnswers ON HAUserQuestion.ItemID = HAUserAnswers.HAQuestionItemID



GO



-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
