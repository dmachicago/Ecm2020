USE [KenticoCMS_Prod1]
GO

/****** Object:  View [dbo].[View_Hfit_HealthAssessmentDefinition]    Script Date: 4/16/2015 6:58:10 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[View_Hfit_HealthAssessmentDefinition]
AS
SELECT
      a.CodeName AS AnswerCodeName,
      q.CodeName AS QuestionCodeName,
      ra.CodeName as RiskAreaCodeName,
      rc.CodeName as RiskCategoryCodeName,
      m.CodeName as ModuleCodeName,
      a.NodeGUID AS AnswerNodeGUID,
      q.NodeGUID as QuestionNodeGUID,
      ra.NodeGUID as RiskAreaNodeGUID,
      rc.NodeGUID as RiskCategoryNodeGUID,
      m.NodeGUID as ModuleNodeGUID,
	  h.NodeGUID as HealthAssessmentNodeGUID,
      a.Points as AnswerPoints,
      a.UOM as AnswerUOM,
      q.Weight as QuestionWeight,
      ra.Weight as RiskAreaWeight,
      rc.Weight as RiskCategoryWeight,
      m.Weight as ModuleWeight,
      ra.ScoringStrategyID as RiskAreaScoringStrategyID
  FROM View_HFit_HealthAssesmentPredefinedAnswer_Joined a
  INNER JOIN View_HFit_HealthAssesmentQuestions q
        ON a.NodeParentID = q.NodeID
  INNER JOIN View_HFit_HealthAssesmentRiskArea_Joined ra
        ON q.NodeParentID = ra.NodeID
  INNER JOIN View_HFit_HealthAssesmentRiskCategory_Joined rc
        ON ra.NodeParentID = rc.NodeID
  INNER JOIN View_HFit_HealthAssesmentModule_Joined m
        ON rc.NodeParentID = m.NodeID
  INNER JOIN View_HFit_HealthAssessment_Joined h
		ON m.NodeParentID = h.NodeID
  where	a.documentculture = 'en-us' AND
        q.documentculture = 'en-us' AND
        ra.documentculture = 'en-us' AND
        rc.documentculture = 'en-us' AND
        m.documentculture = 'en-us' AND
		h.documentculture = 'en-us'
UNION ALL
SELECT
      a.CodeName AS AnswerCodeName,
      q.CodeName AS QuestionCodeName,
      ra.CodeName as RiskAreaCodeName,
      rc.CodeName as RiskCategoryCodeName,
      m.CodeName as ModuleCodeName,
      a.NodeGUID AS AnswerNodeGUID,
      q.NodeGUID as QuestionNodeGUID,
      ra.NodeGUID as RiskAreaNodeGUID,
      rc.NodeGUID as RiskCategoryNodeGUID,
      m.NodeGUID as ModuleNodeGUID,
	  h.NodeGUID as HealthAssessmentNodeGUID,
      a.Points as AnswerPoints,
      a.UOM as AnswerUOM,
      q.Weight as QuestionWeight,
      ra.Weight as RiskAreaWeight,
      rc.Weight as RiskCategoryWeight,
      m.Weight as ModuleWeight,
      ra.ScoringStrategyID as RiskAreaScoringStrategyID
  FROM View_HFit_HealthAssesmentPredefinedAnswer_Joined a
  INNER JOIN View_HFit_HealthAssesmentQuestions q
        ON a.NodeParentID = q.NodeID
  INNER JOIN View_HFit_HealthAssesmentPredefinedAnswer_Joined a1
    ON q.NodeParentID = a1.NodeID
  INNER JOIN View_HFit_HealthAssesmentQuestions q1
    ON a1.NodeParentID = q1.NodeID
  INNER JOIN View_HFit_HealthAssesmentRiskArea_Joined ra
        ON q1.NodeParentID = ra.NodeID
  INNER JOIN View_HFit_HealthAssesmentRiskCategory_Joined rc
        ON ra.NodeParentID = rc.NodeID
  INNER JOIN View_HFit_HealthAssesmentModule_Joined m
        ON rc.NodeParentID = m.NodeID
  INNER JOIN View_HFit_HealthAssessment_Joined h
		ON m.NodeParentID = h.NodeID
  where a.documentculture = 'en-us' AND
        q.documentculture = 'en-us' AND
        a1.documentculture = 'en-us' AND
        q1.documentculture = 'en-us' AND
        ra.documentculture = 'en-us' AND
        rc.documentculture = 'en-us' AND
        m.documentculture = 'en-us' AND
		h.documentculture = 'en-us'
UNION ALL
SELECT
      a.CodeName AS AnswerCodeName,
      q.CodeName AS QuestionCodeName,
      ra.CodeName as RiskAreaCodeName,
      rc.CodeName as RiskCategoryCodeName,
      m.CodeName as ModuleCodeName,
      a.NodeGUID AS AnswerNodeGUID,
      q.NodeGUID as QuestionNodeGUID,
      ra.NodeGUID as RiskAreaNodeGUID,
      rc.NodeGUID as RiskCategoryNodeGUID,
      m.NodeGUID as ModuleNodeGUID,
	  h.NodeGUID as HealthAssessmentNodeGUID,
      a.Points as AnswerPoints,
      a.UOM as AnswerUOM,
      q.Weight as QuestionWeight,
      ra.Weight as RiskAreaWeight,
      rc.Weight as RiskCategoryWeight,
      m.Weight as ModuleWeight,
      ra.ScoringStrategyID as RiskAreaScoringStrategyID
  FROM View_HFit_HealthAssesmentPredefinedAnswer_Joined a
  INNER JOIN View_HFit_HealthAssesmentQuestions q
        ON a.NodeParentID = q.NodeID
  INNER JOIN View_HFit_HealthAssesmentQuestions q1
    ON q.NodeParentID = q1.NodeID
  INNER JOIN View_HFit_HealthAssesmentRiskArea_Joined ra
        ON q1.NodeParentID = ra.NodeID
  INNER JOIN View_HFit_HealthAssesmentRiskCategory_Joined rc
        ON ra.NodeParentID = rc.NodeID
  INNER JOIN View_HFit_HealthAssesmentModule_Joined m
        ON rc.NodeParentID = m.NodeID
  INNER JOIN View_HFit_HealthAssessment_Joined h
		ON m.NodeParentID = h.NodeID
  where a.documentculture = 'en-us' AND
        q.documentculture = 'en-us' AND
        q1.documentculture = 'en-us' AND
        ra.documentculture = 'en-us' AND
        rc.documentculture = 'en-us' AND
        m.documentculture = 'en-us' AND
		h.documentculture = 'en-use'
UNION ALL
SELECT
      a.CodeName AS AnswerCodeName,
      q.CodeName AS QuestionCodeName,
      ra.CodeName as RiskAreaCodeName,
      rc.CodeName as RiskCategoryCodeName,
      m.CodeName as ModuleCodeName,
      a.NodeGUID AS AnswerNodeGUID,
      q.NodeGUID as QuestionNodeGUID,
      ra.NodeGUID as RiskAreaNodeGUID,
      rc.NodeGUID as RiskCategoryNodeGUID,
      m.NodeGUID as ModuleNodeGUID,
	  h.NodeGUID as HealthAssessmentNodeGUID,
      a.Points as AnswerPoints,
      a.UOM as AnswerUOM,
      q.Weight as QuestionWeight,
      ra.Weight as RiskAreaWeight,
      rc.Weight as RiskCategoryWeight,
      m.Weight as ModuleWeight,
      ra.ScoringStrategyID as RiskAreaScoringStrategyID
  FROM View_HFit_HealthAssesmentPredefinedAnswer_Joined a
  INNER JOIN View_HFit_HealthAssesmentQuestions q
        ON a.NodeParentID = q.NodeID
  INNER JOIN View_HFit_HealthAssesmentQuestions q1
    ON q.NodeParentID = q1.NodeID
  INNER JOIN View_HFit_HealthAssesmentPredefinedAnswer_Joined a1
        ON q1.NodeParentID = a1.NodeID
  INNER JOIN View_HFit_HealthAssesmentQuestions q2
        ON a1.NodeParentID = q2.NodeID
  INNER JOIN View_HFit_HealthAssesmentRiskArea_Joined ra
        ON q2.NodeParentID = ra.NodeID
  INNER JOIN View_HFit_HealthAssesmentRiskCategory_Joined rc
        ON ra.NodeParentID = rc.NodeID
  INNER JOIN View_HFit_HealthAssesmentModule_Joined m
        ON rc.NodeParentID = m.NodeID
  INNER JOIN View_HFit_HealthAssessment_Joined h
		ON m.NodeParentID = h.NodeID
  where a.documentculture = 'en-us' AND
        q.documentculture = 'en-us' AND
        q1.documentculture = 'en-us' AND
        a1.documentculture = 'en-us' AND
        q2.documentculture = 'en-us' AND
        ra.documentculture = 'en-us' AND
        rc.documentculture = 'en-us' AND
        m.documentculture = 'en-us' AND
		h.documentculture = 'en-us'
UNION ALL
SELECT
      a.CodeName AS AnswerCodeName,
      q.CodeName AS QuestionCodeName,
      ra.CodeName as RiskAreaCodeName,
      rc.CodeName as RiskCategoryCodeName,
      m.CodeName as ModuleCodeName,
      a.NodeGUID AS AnswerNodeGUID,
      q.NodeGUID as QuestionNodeGUID,
      ra.NodeGUID as RiskAreaNodeGUID,
      rc.NodeGUID as RiskCategoryNodeGUID,
      m.NodeGUID as ModuleNodeGUID,
	  h.NodeGUID as HealthAssessmentNodeGUID,
      a.Points as AnswerPoints,
      a.UOM as AnswerUOM,
      q.Weight as QuestionWeight,
      ra.Weight as RiskAreaWeight,
      rc.Weight as RiskCategoryWeight,
      m.Weight as ModuleWeight,
      ra.ScoringStrategyID as RiskAreaScoringStrategyID
  FROM View_HFit_HealthAssesmentPredefinedAnswer_Joined a
  INNER JOIN View_HFit_HealthAssesmentQuestions q
        ON a.NodeParentID = q.NodeID
  INNER JOIN View_HFit_HealthAssesmentPredefinedAnswer_Joined a3
        ON q.NodeParentID = a3.NodeID
  INNER JOIN View_HFit_HealthAssesmentQuestions q1
    ON a3.NodeParentID = q1.NodeID
  INNER JOIN View_HFit_HealthAssesmentPredefinedAnswer_Joined a1
        ON q1.NodeParentID = a1.NodeID
  INNER JOIN View_HFit_HealthAssesmentQuestions q2
        ON a1.NodeParentID = q2.NodeID
  INNER JOIN View_HFit_HealthAssesmentRiskArea_Joined ra
        ON q2.NodeParentID = ra.NodeID
  INNER JOIN View_HFit_HealthAssesmentRiskCategory_Joined rc
        ON ra.NodeParentID = rc.NodeID
  INNER JOIN View_HFit_HealthAssesmentModule_Joined m
        ON rc.NodeParentID = m.NodeID
  INNER JOIN View_HFit_HealthAssessment_Joined h
		ON m.NodeParentID = h.NodeID
  where a.documentculture = 'en-us' AND
        q.documentculture = 'en-us' AND
        a3.documentculture = 'en-us' AND
        q1.documentculture = 'en-us' AND
        a1.documentculture = 'en-us' AND
        q2.documentculture = 'en-us' AND
        ra.documentculture = 'en-us' AND
        rc.documentculture = 'en-us' AND
        m.documentculture = 'en-us' AND
		h.documentculture = 'en-us'
UNION ALL
SELECT
      a.CodeName AS AnswerCodeName,
      q.CodeName AS QuestionCodeName,
      ra.CodeName as RiskAreaCodeName,
      rc.CodeName as RiskCategoryCodeName,
      m.CodeName as ModuleCodeName,
      a.NodeGUID AS AnswerNodeGUID,
      q.NodeGUID as QuestionNodeGUID,
      ra.NodeGUID as RiskAreaNodeGUID,
      rc.NodeGUID as RiskCategoryNodeGUID,
      m.NodeGUID as ModuleNodeGUID,
	  h.NodeGUID as HealthAssessmentNodeGUID,
      a.Points as AnswerPoints,
      a.UOM as AnswerUOM,
      q.Weight as QuestionWeight,
      ra.Weight as RiskAreaWeight,
      rc.Weight as RiskCategoryWeight,
      m.Weight as ModuleWeight,
      ra.ScoringStrategyID as RiskAreaScoringStrategyID
  FROM View_HFit_HealthAssesmentPredefinedAnswer_Joined a
  INNER JOIN View_HFit_HealthAssesmentQuestions q
        ON a.NodeParentID = q.NodeID
  INNER JOIN View_HFit_HealthAssesmentPredefinedAnswer_Joined a1
        ON q.NodeParentID = a1.NodeID
  INNER JOIN View_HFit_HealthAssesmentQuestions q1
    ON a1.NodeParentID = q1.NodeID
  INNER JOIN View_HFit_HealthAssesmentQuestions qm
        ON q1.NodeParentID = qm.NodeID
  INNER JOIN View_HFit_HealthAssesmentPredefinedAnswer_Joined a2
        ON qm.NodeParentID = a2.NodeID
  INNER JOIN View_HFit_HealthAssesmentQuestions q2
        ON a2.NodeParentID = q2.NodeID
  INNER JOIN View_HFit_HealthAssesmentRiskArea_Joined ra
        ON q2.NodeParentID = ra.NodeID
  INNER JOIN View_HFit_HealthAssesmentRiskCategory_Joined rc
        ON ra.NodeParentID = rc.NodeID
  INNER JOIN View_HFit_HealthAssesmentModule_Joined m
        ON rc.NodeParentID = m.NodeID
  INNER JOIN View_HFit_HealthAssessment_Joined h
		ON m.NodeParentID = h.NodeID
  where a.documentculture = 'en-us' AND
        q.documentculture = 'en-us' AND
        a2.documentculture = 'en-us' AND
        q1.documentculture = 'en-us' AND
        qm.documentculture = 'en-us' AND
        a1.documentculture = 'en-us' AND
        q2.documentculture = 'en-us' AND
        ra.documentculture = 'en-us' AND
        rc.documentculture = 'en-us' AND
        m.documentculture = 'en-us' AND
		h.documentculture = 'en-us'

GO


