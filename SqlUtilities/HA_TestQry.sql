
SELECT 
    [Extent1].[UserStartedItemID] AS [UserStartedItemID], 
    [Extent1].[HACampaignNodeGUID] AS [HACampaignNodeGUID], 
    [Extent1].[HADocumentConfigID] AS [HADocumentConfigID], 
    [Extent1].[UserID] AS [UserID], 
    [Extent1].[HAStartedDt] AS [HAStartedDt], 
    [Extent1].[HACompletedDt] AS [HACompletedDt], 
    [Extent1].[UserModuleItemId] AS [UserModuleItemId], 
    [Extent1].[UserModuleCodeName] AS [UserModuleCodeName], 
    [Extent1].[HAModuleNodeGUID] AS [HAModuleNodeGUID], 
    [Extent1].[UserRiskCategoryItemID] AS [UserRiskCategoryItemID], 
    [Extent1].[UserRiskCategoryCodeName] AS [UserRiskCategoryCodeName], 
    [Extent1].[HARiskCategoryNodeGUID] AS [HARiskCategoryNodeGUID], 
    [Extent1].[UserRiskAreaItemID] AS [UserRiskAreaItemID], 
    [Extent1].[UserRiskAreaCodeName] AS [UserRiskAreaCodeName], 
    [Extent1].[HARiskAreaNodeGUID] AS [HARiskAreaNodeGUID], 
    [Extent1].[UserQuestionItemID] AS [UserQuestionItemID], 
    [Extent1].[UserQuestionCodeName] AS [UserQuestionCodeName], 
    [Extent1].[HAQuestionNodeGUID] AS [HAQuestionNodeGUID], 
    [Extent1].[UserAnswerItemID] AS [UserAnswerItemID], 
    [Extent1].[HAAnswerNodeGUID] AS [HAAnswerNodeGUID], 
    [Extent1].[UserAnswerCodeName] AS [UserAnswerCodeName], 
    [Extent1].[HAAnswerValue] AS [HAAnswerValue], 
    [Extent1].[HAModuleScore] AS [HAModuleScore], 
    [Extent1].[HARiskCategoryScore] AS [HARiskCategoryScore], 
    [Extent1].[HARiskAreaScore] AS [HARiskAreaScore], 
    [Extent1].[HAQuestionScore] AS [HAQuestionScore], 
    [Extent1].[HAAnswerPoints] AS [HAAnswerPoints], 
    [Extent1].[QuestionGroupPointResults] AS [QuestionGroupPointResults], 
    [Extent1].[QuestionGroupFormulaResult] AS [QuestionGroupFormulaResult], 
    [Extent1].[UOMCode] AS [UOMCode], 
    [Extent1].[HAScore] AS [HAScore], 
    [Extent1].[ModulePreWeightedScore] AS [ModulePreWeightedScore], 
    [Extent1].[RiskCategoryPreWeightedScore] AS [RiskCategoryPreWeightedScore], 
    [Extent1].[RiskAreaPreWeightedScore] AS [RiskAreaPreWeightedScore], 
    [Extent1].[QuestionPreWeightedScore] AS [QuestionPreWeightedScore], 
    [Extent1].[QuestionGroupCodeName] AS [QuestionGroupCodeName], 
    [Extent1].[IsProfessionallyCollected] AS [IsProfessionallyCollected], 
    [Extent1].[ProfessionallyCollectedEventDate] AS [ProfessionallyCollectedEventDate]
    FROM (SELECT 
[view_HFit_HealthAssesmentUserResponses].[UserStartedItemID] AS [UserStartedItemID], 
[view_HFit_HealthAssesmentUserResponses].[HACampaignNodeGUID] AS [HACampaignNodeGUID], 
[view_HFit_HealthAssesmentUserResponses].[HADocumentConfigID] AS [HADocumentConfigID], 
[view_HFit_HealthAssesmentUserResponses].[UserID] AS [UserID], 
[view_HFit_HealthAssesmentUserResponses].[HAStartedDt] AS [HAStartedDt], 
[view_HFit_HealthAssesmentUserResponses].[HACompletedDt] AS [HACompletedDt], 
[view_HFit_HealthAssesmentUserResponses].[UserModuleItemId] AS [UserModuleItemId], 
[view_HFit_HealthAssesmentUserResponses].[UserModuleCodeName] AS [UserModuleCodeName], 
[view_HFit_HealthAssesmentUserResponses].[HAModuleNodeGUID] AS [HAModuleNodeGUID], 
[view_HFit_HealthAssesmentUserResponses].[UserRiskCategoryItemID] AS [UserRiskCategoryItemID], 
[view_HFit_HealthAssesmentUserResponses].[UserRiskCategoryCodeName] AS [UserRiskCategoryCodeName], 
[view_HFit_HealthAssesmentUserResponses].[HARiskCategoryNodeGUID] AS [HARiskCategoryNodeGUID], 
[view_HFit_HealthAssesmentUserResponses].[UserRiskAreaItemID] AS [UserRiskAreaItemID], 
[view_HFit_HealthAssesmentUserResponses].[UserRiskAreaCodeName] AS [UserRiskAreaCodeName], 
[view_HFit_HealthAssesmentUserResponses].[HARiskAreaNodeGUID] AS [HARiskAreaNodeGUID], 
[view_HFit_HealthAssesmentUserResponses].[UserQuestionItemID] AS [UserQuestionItemID], 
[view_HFit_HealthAssesmentUserResponses].[UserQuestionCodeName] AS [UserQuestionCodeName], 
[view_HFit_HealthAssesmentUserResponses].[HAQuestionNodeGUID] AS [HAQuestionNodeGUID], 
[view_HFit_HealthAssesmentUserResponses].[UserAnswerItemID] AS [UserAnswerItemID], 
[view_HFit_HealthAssesmentUserResponses].[HAAnswerNodeGUID] AS [HAAnswerNodeGUID], 
[view_HFit_HealthAssesmentUserResponses].[UserAnswerCodeName] AS [UserAnswerCodeName], 
[view_HFit_HealthAssesmentUserResponses].[HAAnswerValue] AS [HAAnswerValue], 
[view_HFit_HealthAssesmentUserResponses].[HAModuleScore] AS [HAModuleScore], 
[view_HFit_HealthAssesmentUserResponses].[HARiskCategoryScore] AS [HARiskCategoryScore], 
[view_HFit_HealthAssesmentUserResponses].[HARiskAreaScore] AS [HARiskAreaScore], 
[view_HFit_HealthAssesmentUserResponses].[HAQuestionScore] AS [HAQuestionScore], 
[view_HFit_HealthAssesmentUserResponses].[HAAnswerPoints] AS [HAAnswerPoints], 
[view_HFit_HealthAssesmentUserResponses].[QuestionGroupPointResults] AS [QuestionGroupPointResults], 
[view_HFit_HealthAssesmentUserResponses].[QuestionGroupFormulaResult] AS [QuestionGroupFormulaResult], 
[view_HFit_HealthAssesmentUserResponses].[UOMCode] AS [UOMCode], 
[view_HFit_HealthAssesmentUserResponses].[HAScore] AS [HAScore], 
[view_HFit_HealthAssesmentUserResponses].[ModulePreWeightedScore] AS [ModulePreWeightedScore], 
[view_HFit_HealthAssesmentUserResponses].[RiskCategoryPreWeightedScore] AS [RiskCategoryPreWeightedScore], 
[view_HFit_HealthAssesmentUserResponses].[RiskAreaPreWeightedScore] AS [RiskAreaPreWeightedScore], 
[view_HFit_HealthAssesmentUserResponses].[QuestionPreWeightedScore] AS [QuestionPreWeightedScore], 
[view_HFit_HealthAssesmentUserResponses].[QuestionGroupCodeName] AS [QuestionGroupCodeName], 
[view_HFit_HealthAssesmentUserResponses].[IsProfessionallyCollected] AS [IsProfessionallyCollected], 
[view_HFit_HealthAssesmentUserResponses].[ProfessionallyCollectedEventDate] AS [ProfessionallyCollectedEventDate]
FROM [dbo].[view_HFit_HealthAssesmentUserResponses] AS [view_HFit_HealthAssesmentUserResponses]) AS [Extent1]
    WHERE ([Extent1].[HAQuestionNodeGUID] IN (cast('1f6d5e19-f5bf-426d-944e-e1af7ee9c8bf' as uniqueidentifier))) AND ([Extent1].[UserStartedItemID] = 86528)

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016