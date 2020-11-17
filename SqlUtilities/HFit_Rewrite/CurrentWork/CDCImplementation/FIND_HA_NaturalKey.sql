set rowcount 0;

select distinct  COUNT_BIG(*), UserStartedItemID from 
view_MART_HealthAssesment
group by  
    --SVR
    --,DBNAME
    UserStartedItemID
    , HealthAssesmentUserStartedNodeGUID 
    --, UserID 
    , UserGUID 
    --, HFitUserMpiNumber 
    , SiteGUID 
    , AccountID 
    --, AccountCD 
    --, AccountName 
    , HAStartedDt 
    --, HACompletedDt 
    , UserModuleItemId 
    , CMSNodeGuid 
    --, HAModuleVersionID 
    , UserRiskCategoryItemID 
    --, UserRiskCategoryCodeName 
    --, HARiskCategoryNodeGUID 
    --, HARiskCategoryVersionID 
    , UserRiskAreaItemID 
    --, UserRiskAreaCodeName 
    --, HARiskAreaNodeGUID 
    --, HARiskAreaVersionID 
    , UserQuestionItemID 
    --, HAQuestionGuid       
    , HAQuestionDocumentID 
    --, HAQuestionVersionID 
    --, HAQuestionNodeGUID 
    , UserAnswerItemID 
    --, HAAnswerNodeGUID 
    --, HAAnswerVersionID 
      --, HAAnswerValue 
      --, HAModuleScore 
      --, HARiskCategoryScore 
      --, HARiskAreaScore 
      --, HAQuestionScore 
      --, HAAnswerPoints 
      , ItemCreatedWhen 
      , ItemModifiedWhen 
      , HARiskCategory_ItemModifiedWhen 
      , HAUserRiskArea_ItemModifiedWhen 
      , HAUserQuestion_ItemModifiedWhen 
      , HAUserAnswers_ItemModifiedWhen
having count(*) > 1

      , UserModuleCodeName 
      , HAModuleNodeGUID 
      , Title 
      
      , UserQuestionCodeName 
      , UserAnswerCodeName 
      
      , PointResults 
      , UOMCode 
      , HAScore 
      , ModulePreWeightedScore 
      , RiskCategoryPreWeightedScore 
      , RiskAreaPreWeightedScore 
      , QuestionPreWeightedScore 
      , QuestionGroupCodeName 
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
      , HealthAssessmentType )
 SELECT 
     UserStartedItemID
     , HealthAssesmentUserStartedNodeGUID 
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
     , PointResults 
     , UOMCode 
     , HAScore 
     , ModulePreWeightedScore 
     , RiskCategoryPreWeightedScore 
     , RiskAreaPreWeightedScore 
     , QuestionPreWeightedScore 
     , QuestionGroupCodeName 
     , ChangeType 
     , ItemCreatedWhen 
     , ItemModifiedWhen 
     , IsProfessionallyCollected 
     , HARiskCategory_ItemModifiedWhen 
     , HAUserRiskArea_ItemModifiedWhen 
     , HAUserQuestion_ItemModifiedWhen 
     , HAUserAnswers_ItemModifiedWhen 
     , HAPaperFlg 
     , HATelephonicFlg 
     , HAStartedMode 
     , HACompletedMode 
     , DocumentCulture_VHCJ 
     , DocumentCulture_HAQuestionsView 
     , CampaignNodeGUID 
     , HealthAssessmentType 
FROM view_MART_HealthAssesment
