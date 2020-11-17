
GO
PRINT 'Executing TRIG_DEL_BASE_MART_EDW_HealthAssesment.sql';
GO

IF EXISTS (
SELECT
       *
FROM sys.objects
WHERE
      type = 'TR' AND
       name = 'TRIG_DEL_BASE_MART_EDW_HealthAssesment'
) 
    BEGIN
        DROP TRIGGER
             TRIG_DEL_BASE_MART_EDW_HealthAssesment
    END;
GO
CREATE TRIGGER TRIG_DEL_BASE_MART_EDW_HealthAssesment
ON dbo.BASE_MART_EDW_HealthAssesment
    FOR DELETE
AS
BEGIN
    -- Generated on: Apr  6 2016  2:15PM
    DECLARE @ACTION AS CHAR (1) = 'D';
    INSERT INTO BASE_MART_EDW_HealthAssesment_DEL
    (
           UserStartedItemID
         , UserID
         , UserGUID
         , HFitUserMpiNumber
         , SiteGUID
         , AccountID
         , AccountCD
         , AccountName
         , HAStartedDt
         , HACompletedDt
         , UserModuleItemId
         , UserModuleCodeName
         , HAModuleNodeGUID
         , CMSNodeGuid
         , HAModuleVersionID
         , UserRiskCategoryItemID
         , UserRiskCategoryCodeName
         , HARiskCategoryNodeGUID
         , HARiskCategoryVersionID
         , UserRiskAreaItemID
         , UserRiskAreaCodeName
         , HARiskAreaNodeGUID
         , HARiskAreaVersionID
         , UserQuestionItemID
         , Title
         , HAQuestionGuid
         , UserQuestionCodeName
         , HAQuestionDocumentID
         , HAQuestionVersionID
         , HAQuestionNodeGUID
         , UserAnswerItemID
         , HAAnswerNodeGUID
         , HAAnswerVersionID
         , UserAnswerCodeName
         , HAAnswerValue
         , HAModuleScore
         , HARiskCategoryScore
         , HARiskAreaScore
         , HAQuestionScore
         , HAAnswerPoints
         , UOMCode
         , HAScore
         , ModulePreWeightedScore
         , RiskCategoryPreWeightedScore
         , RiskAreaPreWeightedScore
         , QuestionPreWeightedScore
         , ChangeType
         , ItemCreatedWhen
         , ItemModifiedWhen
         , IsProfessionallyCollected
         , HAPaperFlg
         , HATelephonicFlg
         , HAStartedMode
         , HACompletedMode
         , DocumentCulture_VHCJ
         , DocumentCulture_HAQuestionsView
         , CampaignNodeGUID
         , HealthAssessmentType
         , HAUserStarted_LastModifiedDate
         , CMSUser_LastModifiedDate
         , UserSettings_LastModifiedDate
         , UserSite_LastModifiedDate
         , ACCT_LastModifiedDate
         , HAUserModule_LastModifiedDate
         , HARiskCategory_LastModifiedDate
         , HAUserRiskArea_LastModifiedDate
         , HAUserQuestion_LastModifiedDate
         , HAUserAnswers_LastModifiedDate
         , HealthAssesmentUserStartedNodeGUID
         , PointResults
         , QuestionGroupCodeName
         , CT_HAStartedMode
         , CT_HATelephonicFlg
         , CT_HADocumentConfigID
         , CT_HFitUserMpiNumber
         , CT_IsProfessionallyCollected
         , CT_CodeName
         , SurrogateKey_HFit_HealthAssesmentUserStarted
         , SurrogateKey_CMS_User
         , SurrogateKey_CMS_UserSettings
         , SurrogateKey_CMS_UserSite
         , SurrogateKey_CMS_Site
         , SurrogateKey_HFit_Account
         , SurrogateKey_HFit_HealthAssesmentUserModule
         , SurrogateKey_View_HFit_HACampaign_Joined
         , SurrogateKey_View_HFit_HealthAssessment_Joined
         , SurrogateKey_HFit_HealthAssesmentUserRiskCategory
         , SurrogateKey_HFit_HealthAssesmentUserRiskArea
         , SurrogateKey_HFit_HealthAssesmentUserQuestion
         , SurrogateKey_View_EDW_HealthAssesmentQuestions
         , SurrogateKey_HFit_HealthAssesmentUserAnswers
         , HARiskCategory_ItemModifiedWhen
         , HAUserRiskArea_ItemModifiedWhen
         , HAUserQuestion_ItemModifiedWhen
         , HAUserAnswers_ItemModifiedWhen
         , LastModifiedDate
         , RowDataChanged
         , SVR
         , DBNAME) 
    SELECT
           UserStartedItemID
         , UserID
         , UserGUID
         , HFitUserMpiNumber
         , SiteGUID
         , AccountID
         , AccountCD
         , AccountName
         , HAStartedDt
         , HACompletedDt
         , UserModuleItemId
         , UserModuleCodeName
         , HAModuleNodeGUID
         , CMSNodeGuid
         , HAModuleVersionID
         , UserRiskCategoryItemID
         , UserRiskCategoryCodeName
         , HARiskCategoryNodeGUID
         , HARiskCategoryVersionID
         , UserRiskAreaItemID
         , UserRiskAreaCodeName
         , HARiskAreaNodeGUID
         , HARiskAreaVersionID
         , UserQuestionItemID
         , Title
         , HAQuestionGuid
         , UserQuestionCodeName
         , HAQuestionDocumentID
         , HAQuestionVersionID
         , HAQuestionNodeGUID
         , UserAnswerItemID
         , HAAnswerNodeGUID
         , HAAnswerVersionID
         , UserAnswerCodeName
         , HAAnswerValue
         , HAModuleScore
         , HARiskCategoryScore
         , HARiskAreaScore
         , HAQuestionScore
         , HAAnswerPoints
         , UOMCode
         , HAScore
         , ModulePreWeightedScore
         , RiskCategoryPreWeightedScore
         , RiskAreaPreWeightedScore
         , QuestionPreWeightedScore
         , ChangeType
         , ItemCreatedWhen
         , ItemModifiedWhen
         , IsProfessionallyCollected
         , HAPaperFlg
         , HATelephonicFlg
         , HAStartedMode
         , HACompletedMode
         , DocumentCulture_VHCJ
         , DocumentCulture_HAQuestionsView
         , CampaignNodeGUID
         , HealthAssessmentType
         , HAUserStarted_LastModifiedDate
         , CMSUser_LastModifiedDate
         , UserSettings_LastModifiedDate
         , UserSite_LastModifiedDate
         , ACCT_LastModifiedDate
         , HAUserModule_LastModifiedDate
         , HARiskCategory_LastModifiedDate
         , HAUserRiskArea_LastModifiedDate
         , HAUserQuestion_LastModifiedDate
         , HAUserAnswers_LastModifiedDate
         , HealthAssesmentUserStartedNodeGUID
         , PointResults
         , QuestionGroupCodeName
         , CT_HAStartedMode
         , CT_HATelephonicFlg
         , CT_HADocumentConfigID
         , CT_HFitUserMpiNumber
         , CT_IsProfessionallyCollected
         , CT_CodeName
         , SurrogateKey_HFit_HealthAssesmentUserStarted
         , SurrogateKey_CMS_User
         , SurrogateKey_CMS_UserSettings
         , SurrogateKey_CMS_UserSite
         , SurrogateKey_CMS_Site
         , SurrogateKey_HFit_Account
         , SurrogateKey_HFit_HealthAssesmentUserModule
         , SurrogateKey_View_HFit_HACampaign_Joined
         , SurrogateKey_View_HFit_HealthAssessment_Joined
         , SurrogateKey_HFit_HealthAssesmentUserRiskCategory
         , SurrogateKey_HFit_HealthAssesmentUserRiskArea
         , SurrogateKey_HFit_HealthAssesmentUserQuestion
         , SurrogateKey_View_EDW_HealthAssesmentQuestions
         , SurrogateKey_HFit_HealthAssesmentUserAnswers
         , HARiskCategory_ItemModifiedWhen
         , HAUserRiskArea_ItemModifiedWhen
         , HAUserQuestion_ItemModifiedWhen
         , HAUserAnswers_ItemModifiedWhen
         , getdate()
         , RowDataChanged
         , SVR
         , DBNAME
    FROM deleted;
END;
GO
PRINT 'Executed TRIG_DEL_BASE_MART_EDW_HealthAssesment.sql';
GO