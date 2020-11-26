USE [KenticoCMS_ProdStaging]
GO

DECLARE @RC int
DECLARE @TargetView nvarchar(80)

-- TODO: Set parameter values here.
set @TargetView = 'view_EDW_HealthAssesmentDeffinition'
EXECUTE @RC = [dbo].[wdmViewAnalysis] 
   @TargetView
GO

SELECT Table_Name, Column_Name, Data_type, Character_Maximum_Length
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME in 
('view_EDW_HealthAssesmentDeffinition',
'HFit_Account',
'View_HFit_HealthAssessment_Joined',
'CMS_Site',
'udf_StripHTML',
'View_CMS_Tree_Joined',
'View_HFit_HACampaign_Joined',
'View_HFit_HealthAssesmentAnswers',
'View_HFit_HealthAssesmentModule_Joined',
'View_HFit_HealthAssesmentQuestions',
'View_HFit_HealthAssesmentRiskArea_Joined',
'View_HFit_HealthAssesmentRiskCategory_Joined',
'HFit_HealthAssessment',
'View_CMS_Tree_Joined',
'View_CMS_Tree_Joined_Linked',
'View_CMS_Tree_Joined_Regular',
'CMS_User',
'View_COM_SKU',
'HFit_HACampaign',
'View_CMS_Tree_Joined',
'View_HFit_HealthAssesmentPredefinedAnswer_Joined',
'HFit_HealthAssesmentModule',
'View_CMS_Tree_Joined',
'CMS_Tree',
'View_HFit_HealthAssesmentMatrixQuestion_Joined',
'View_HFit_HealthAssesmentMultipleChoiceQuestion_Joined',
'View_HFit_HealthAssessmentFreeForm_Joined',
'HFit_HealthAssesmentRiskArea',
'View_CMS_Tree_Joined',
'HFit_HealthAssesmentRiskCategory',
'View_CMS_Tree_Joined',
'View_CMS_Tree_Joined_Linked',
'View_CMS_Tree_Joined_Regular',
'CMS_User',
'View_COM_SKU',
'CMS_Class',
'CMS_Document',
'CMS_Site',
'CMS_Tree',
'CMS_Class',
'CMS_Document',
'CMS_Site',
'CMS_Tree',
'COM_SKU',
'View_CMS_Tree_Joined_Linked',
'View_CMS_Tree_Joined_Regular',
'CMS_User',
'View_COM_SKU',
'HFit_HealthAssesmentPredefinedAnswer',
'View_CMS_Tree_Joined',
'View_CMS_Tree_Joined_Linked',
'View_CMS_Tree_Joined_Regular',
'CMS_User',
'View_COM_SKU',
'HFit_HealthAssesmentMatrixQuestion',
'View_CMS_Tree_Joined',
'HFit_HealthAssesmentMultipleChoiceQuestion',
'View_CMS_Tree_Joined',
'HFit_HealthAssessmentFreeForm',
'View_CMS_Tree_Joined',
'View_CMS_Tree_Joined_Linked',
'View_CMS_Tree_Joined_Regular',
'CMS_User',
'View_COM_SKU',
'View_CMS_Tree_Joined_Linked',
'View_CMS_Tree_Joined_Regular',
'CMS_User',
'View_COM_SKU',
'CMS_Class',
'CMS_Document',
'CMS_Site',
'CMS_Tree',
'CMS_Class',
'CMS_Document',
'CMS_Site',
'CMS_Tree',
'COM_SKU',
'CMS_Class',
'CMS_Document',
'CMS_Site',
'CMS_Tree',
'CMS_Class',
'CMS_Document',
'CMS_Site',
'CMS_Tree',
'COM_SKU',
'View_CMS_Tree_Joined_Linked',
'View_CMS_Tree_Joined_Regular',
'CMS_User',
'View_COM_SKU',
'CMS_Class',
'CMS_Document',
'CMS_Site',
'CMS_Tree',
'CMS_Class',
'CMS_Document',
'CMS_Site',
'CMS_Tree',
'COM_SKU',
'View_CMS_Tree_Joined_Linked',
'View_CMS_Tree_Joined_Regular',
'CMS_User',
'View_COM_SKU',
'View_CMS_Tree_Joined_Linked',
'View_CMS_Tree_Joined_Regular',
'CMS_User',
'View_COM_SKU',
'View_CMS_Tree_Joined_Linked',
'View_CMS_Tree_Joined_Regular',
'CMS_User',
'View_COM_SKU',
'CMS_Class',
'CMS_Document',
'CMS_Site',
'CMS_Tree',
'CMS_Class',
'CMS_Document',
'CMS_Site',
'CMS_Tree',
'COM_SKU',
'CMS_Class',
'CMS_Document',
'CMS_Site',
'CMS_Tree',
'CMS_Class',
'CMS_Document',
'CMS_Site',
'CMS_Tree',
'COM_SKU',
'CMS_Class',
'CMS_Document',
'CMS_Site',
'CMS_Tree',
'CMS_Class',
'CMS_Document',
'CMS_Site',
'CMS_Tree',
'COM_SKU',
'CMS_Class',
'CMS_Document',
'CMS_Site',
'CMS_Tree',
'CMS_Class',
'CMS_Document',
'CMS_Site',
'CMS_Tree',
'COM_SKU',
'CMS_Class',
'CMS_Document',
'CMS_Site',
'CMS_Tree',
'CMS_Class',
'CMS_Document',
'CMS_Site',
'CMS_Tree',
'COM_SKU',
'CMS_Class',
'CMS_Document',
'CMS_Site',
'CMS_Tree',
'CMS_Class',
'CMS_Document',
'CMS_Site',
'CMS_Tree',
'COM_SKU',
'testcharlen'
)
and Data_type in ('varchar', 'nvarchar')
and Character_Maximum_Length < 0


SELECT Table_Name, Column_Name, Data_type, Character_Maximum_Length
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME in 
('view_EDW_HealthAssesmentDeffinition',
'HFit_Account',
'View_HFit_HealthAssessment_Joined',
'CMS_Site',
'udf_StripHTML',
'View_CMS_Tree_Joined',
'View_HFit_HACampaign_Joined',
'View_HFit_HealthAssesmentAnswers',
'View_HFit_HealthAssesmentModule_Joined',
'View_HFit_HealthAssesmentQuestions',
'View_HFit_HealthAssesmentRiskArea_Joined',
'View_HFit_HealthAssesmentRiskCategory_Joined',
'HFit_HealthAssessment',
'View_CMS_Tree_Joined',
'View_CMS_Tree_Joined_Linked',
'View_CMS_Tree_Joined_Regular',
'CMS_User',
'View_COM_SKU',
'HFit_HACampaign',
'View_CMS_Tree_Joined',
'View_HFit_HealthAssesmentPredefinedAnswer_Joined',
'HFit_HealthAssesmentModule',
'View_CMS_Tree_Joined',
'CMS_Tree',
'View_HFit_HealthAssesmentMatrixQuestion_Joined',
'View_HFit_HealthAssesmentMultipleChoiceQuestion_Joined',
'View_HFit_HealthAssessmentFreeForm_Joined',
'HFit_HealthAssesmentRiskArea',
'View_CMS_Tree_Joined',
'HFit_HealthAssesmentRiskCategory',
'View_CMS_Tree_Joined',
'View_CMS_Tree_Joined_Linked',
'View_CMS_Tree_Joined_Regular',
'CMS_User',
'View_COM_SKU',
'CMS_Class',
'CMS_Document',
'CMS_Site',
'CMS_Tree',
'CMS_Class',
'CMS_Document',
'CMS_Site',
'CMS_Tree',
'COM_SKU',
'View_CMS_Tree_Joined_Linked',
'View_CMS_Tree_Joined_Regular',
'CMS_User',
'View_COM_SKU',
'HFit_HealthAssesmentPredefinedAnswer',
'View_CMS_Tree_Joined',
'View_CMS_Tree_Joined_Linked',
'View_CMS_Tree_Joined_Regular',
'CMS_User',
'View_COM_SKU',
'HFit_HealthAssesmentMatrixQuestion',
'View_CMS_Tree_Joined',
'HFit_HealthAssesmentMultipleChoiceQuestion',
'View_CMS_Tree_Joined',
'HFit_HealthAssessmentFreeForm',
'View_CMS_Tree_Joined',
'View_CMS_Tree_Joined_Linked',
'View_CMS_Tree_Joined_Regular',
'CMS_User',
'View_COM_SKU',
'View_CMS_Tree_Joined_Linked',
'View_CMS_Tree_Joined_Regular',
'CMS_User',
'View_COM_SKU',
'CMS_Class',
'CMS_Document',
'CMS_Site',
'CMS_Tree',
'CMS_Class',
'CMS_Document',
'CMS_Site',
'CMS_Tree',
'COM_SKU',
'CMS_Class',
'CMS_Document',
'CMS_Site',
'CMS_Tree',
'CMS_Class',
'CMS_Document',
'CMS_Site',
'CMS_Tree',
'COM_SKU',
'View_CMS_Tree_Joined_Linked',
'View_CMS_Tree_Joined_Regular',
'CMS_User',
'View_COM_SKU',
'CMS_Class',
'CMS_Document',
'CMS_Site',
'CMS_Tree',
'CMS_Class',
'CMS_Document',
'CMS_Site',
'CMS_Tree',
'COM_SKU',
'View_CMS_Tree_Joined_Linked',
'View_CMS_Tree_Joined_Regular',
'CMS_User',
'View_COM_SKU',
'View_CMS_Tree_Joined_Linked',
'View_CMS_Tree_Joined_Regular',
'CMS_User',
'View_COM_SKU',
'View_CMS_Tree_Joined_Linked',
'View_CMS_Tree_Joined_Regular',
'CMS_User',
'View_COM_SKU',
'CMS_Class',
'CMS_Document',
'CMS_Site',
'CMS_Tree',
'CMS_Class',
'CMS_Document',
'CMS_Site',
'CMS_Tree',
'COM_SKU',
'CMS_Class',
'CMS_Document',
'CMS_Site',
'CMS_Tree',
'CMS_Class',
'CMS_Document',
'CMS_Site',
'CMS_Tree',
'COM_SKU',
'CMS_Class',
'CMS_Document',
'CMS_Site',
'CMS_Tree',
'CMS_Class',
'CMS_Document',
'CMS_Site',
'CMS_Tree',
'COM_SKU',
'CMS_Class',
'CMS_Document',
'CMS_Site',
'CMS_Tree',
'CMS_Class',
'CMS_Document',
'CMS_Site',
'CMS_Tree',
'COM_SKU',
'CMS_Class',
'CMS_Document',
'CMS_Site',
'CMS_Tree',
'CMS_Class',
'CMS_Document',
'CMS_Site',
'CMS_Tree',
'COM_SKU',
'CMS_Class',
'CMS_Document',
'CMS_Site',
'CMS_Tree',
'CMS_Class',
'CMS_Document',
'CMS_Site',
'CMS_Tree',
'COM_SKU'
)
and Data_type in ('varchar', 'nvarchar')
and Character_Maximum_Length < 0
and Table_Name = 'view_EDW_HealthAssesmentDeffinition'