use KenticoCMS_PRD_prod3K7
GO 
if exists (select name from sys.tables where name = 'TEST_K7K8_view_EDW_HealthAssesment' )
BEGIN
    DROP Table KenticoCMS_PRD_prod3K7.dbo.TEST_K7K8_view_EDW_HealthAssesment
END
GO


--****************************************************
Select  top 250 
     UserStartedItemID
    ,HealthAssesmentUserStartedNodeGUID
    ,UserID
    ,UserGUID
    ,HFitUserMpiNumber
    ,SiteGUID
    ,AccountID
    ,AccountCD
    ,AccountName
    ,HAStartedDt
    ,HACompletedDt
    ,UserModuleItemId
    ,UserModuleCodeName
    ,HAModuleNodeGUID
    ,CMSNodeGuid
    ,HAModuleVersionID
    ,UserRiskCategoryItemID
    ,UserRiskCategoryCodeName
    ,HARiskCategoryNodeGUID
    ,HARiskCategoryVersionID
    ,UserRiskAreaItemID
    ,UserRiskAreaCodeName
    ,HARiskAreaNodeGUID
    ,HARiskAreaVersionID
    ,UserQuestionItemID
    ,Title
    ,HAQuestionGuid
    ,UserQuestionCodeName
    ,HAQuestionDocumentID
    ,HAQuestionVersionID
    ,HAQuestionNodeGUID
    ,UserAnswerItemID
    ,HAAnswerNodeGUID
    ,HAAnswerVersionID
    ,UserAnswerCodeName
    ,HAAnswerValue
    ,HAModuleScore
    ,HARiskCategoryScore
    ,HARiskAreaScore
    ,HAQuestionScore
    ,HAAnswerPoints
    ,PointResults
    ,UOMCode
    ,HAScore
    ,ModulePreWeightedScore
    ,RiskCategoryPreWeightedScore
    ,RiskAreaPreWeightedScore
    ,QuestionPreWeightedScore
    ,QuestionGroupCodeName
    ,ChangeType
    ,ItemCreatedWhen
    ,ItemModifiedWhen
    ,IsProfessionallyCollected
    ,HARiskCategory_ItemModifiedWhen
    ,HAUserRiskArea_ItemModifiedWhen
    ,HAUserQuestion_ItemModifiedWhen
    ,HAUserAnswers_ItemModifiedWhen
    ,HAPaperFlg
    ,HATelephonicFlg
    ,HAStartedMode
    ,HACompletedMode
    ,DocumentCulture_VHCJ
    ,DocumentCulture_HAQuestionsView
    ,CampaignNodeGUID
INTO KenticoCMS_PRD_prod3K7.dbo.TEST_K7K8_view_EDW_HealthAssesment
FROM
KenticoCMS_PRD_prod3K7.dbo.view_EDW_HealthAssesment where HFitUserMpiNumber > 0 order by HFitUserMpiNumber ;
--****************************************************
use KenticoCMS_PRD_prod3K8
GO 
if exists (select name from sys.tables where name = 'TEST_K7K8_view_EDW_HealthAssesment' )
BEGIN
    DROP Table KenticoCMS_PRD_prod3K8.dbo.TEST_K7K8_view_EDW_HealthAssesment
END
GO


--****************************************************
Select  top 250 
     UserStartedItemID
    ,HealthAssesmentUserStartedNodeGUID
    ,UserID
    ,UserGUID
    ,HFitUserMpiNumber
    ,SiteGUID
    ,AccountID
    ,AccountCD
    ,AccountName
    ,HAStartedDt
    ,HACompletedDt
    ,UserModuleItemId
    ,UserModuleCodeName
    ,HAModuleNodeGUID
    ,CMSNodeGuid
    ,HAModuleVersionID
    ,UserRiskCategoryItemID
    ,UserRiskCategoryCodeName
    ,HARiskCategoryNodeGUID
    ,HARiskCategoryVersionID
    ,UserRiskAreaItemID
    ,UserRiskAreaCodeName
    ,HARiskAreaNodeGUID
    ,HARiskAreaVersionID
    ,UserQuestionItemID
    ,Title
    ,HAQuestionGuid
    ,UserQuestionCodeName
    ,HAQuestionDocumentID
    ,HAQuestionVersionID
    ,HAQuestionNodeGUID
    ,UserAnswerItemID
    ,HAAnswerNodeGUID
    ,HAAnswerVersionID
    ,UserAnswerCodeName
    ,HAAnswerValue
    ,HAModuleScore
    ,HARiskCategoryScore
    ,HARiskAreaScore
    ,HAQuestionScore
    ,HAAnswerPoints
    ,PointResults
    ,UOMCode
    ,HAScore
    ,ModulePreWeightedScore
    ,RiskCategoryPreWeightedScore
    ,RiskAreaPreWeightedScore
    ,QuestionPreWeightedScore
    ,QuestionGroupCodeName
    ,ChangeType
    ,ItemCreatedWhen
    ,ItemModifiedWhen
    ,IsProfessionallyCollected
    ,HARiskCategory_ItemModifiedWhen
    ,HAUserRiskArea_ItemModifiedWhen
    ,HAUserQuestion_ItemModifiedWhen
    ,HAUserAnswers_ItemModifiedWhen
    ,HAPaperFlg
    ,HATelephonicFlg
    ,HAStartedMode
    ,HACompletedMode
    ,DocumentCulture_VHCJ
    ,DocumentCulture_HAQuestionsView
    ,CampaignNodeGUID
INTO KenticoCMS_PRD_prod3K8.dbo.TEST_K7K8_view_EDW_HealthAssesment
FROM
KenticoCMS_PRD_prod3K8.dbo.view_EDW_HealthAssesment where HFitUserMpiNumber > 0  order by HFitUserMpiNumber;
--****************************************************
GO

select top 100 * from KenticoCMS_PRD_prod3K7.dbo.TEST_K7K8_view_EDW_HealthAssesment order by HFitUserMpiNumber, UserQUestionItemID, HARiskCategory_ItemModifiedWhen;

select top 100 * from KenticoCMS_PRD_prod3K8.dbo.TEST_K7K8_view_EDW_HealthAssesment order by HFitUserMpiNumber, UserQUestionItemID, HARiskCategory_ItemModifiedWhen;

--update HFit_EDW_K7K8_TestDDL set Passed = 1 where VIEW_NAME = 'view_EDW_HealthAssesment'; 