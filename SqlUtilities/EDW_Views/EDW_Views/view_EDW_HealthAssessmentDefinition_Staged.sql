
GO
print ('Processing: view_EDW_HealthAssessmentDefinition_Staged ') ;
go

--select top 100 * from [view_EDW_HealthAssessmentDefinition_Staged]
--select * from [view_EDW_HealthAssessmentDefinition_Staged]

if exists(select TABLE_NAME from INFORMATION_SCHEMA.VIEWS where TABLE_NAME = 'view_EDW_HealthAssessmentDefinition_Staged')
BEGIN
	drop view view_EDW_HealthAssessmentDefinition_Staged ;
END
GO

create view [dbo].[view_EDW_HealthAssessmentDefinition_Staged]
as
--****************************************************************************
--09/04/2014 WDM
--The view Health Assessment Definition runs very poorly. This view/table is 
--created as as a staging table allowing the data to already exist when the 
--EDW needs it. This is the view that data from the staging table 
--(EDW_HealthAssessmentDefinition) allowing the EDW to launch a much faster 
--start when processing Health Assessment Definition data.
--04.16.2015 - (WDM) Converted to run against the staging table.
--****************************************************************************
SELECT [SiteGUID]
      ,[AccountCD]
      ,[HANodeID]
      ,[HANodeName]
      ,[HADocumentID]
      ,[HANodeSiteID]
      ,[HADocPubVerID]
      ,[ModTitle]
      ,[IntroText]
      ,[ModDocGuid]
      ,[ModWeight]
      ,[ModIsEnabled]
      ,[ModCodeName]
      ,[ModDocPubVerID]
      ,[RCTitle]
      ,[RCWeight]
      ,[RCDocumentGUID]
      ,[RCIsEnabled]
      ,[RCCodeName]
      ,[RCDocPubVerID]
      ,[RATytle]
      ,[RAWeight]
      ,[RADocumentGuid]
      ,[RAIsEnabled]
      ,[RACodeName]
      ,[RAScoringStrategyID]
      ,[RADocPubVerID]
      ,[QuestionType]
      ,[QuesTitle]
      ,[QuesWeight]
      ,[QuesIsRequired]
      ,[QuesDocumentGuid]
      ,[QuesIsEnabled]
      ,[QuesIsVisible]
      ,[QuesIsSTaging]
      ,[QuestionCodeName]
      ,[QuesDocPubVerID]
      ,[AnsValue]
      ,[AnsPoints]
      ,[AnsDocumentGuid]
      ,[AnsIsEnabled]
      ,[AnsCodeName]
      ,[AnsUOM]
      ,[AnsDocPUbVerID]
      ,[ChangeType]
      ,cast([DocumentCreatedWhen] as datetime) as [DocumentCreatedWhen]
      ,cast([DocumentModifiedWhen] as datetime) as [DocumentModifiedWhen]
      ,[CmsTreeNodeGuid]
      ,[HANodeGUID]
      ,[SiteLastModified]
      ,[Account_ItemModifiedWhen]
      ,[Campaign_DocumentModifiedWhen]
      ,[Assessment_DocumentModifiedWhen]
      ,[Module_DocumentModifiedWhen]
      ,[RiskCategory_DocumentModifiedWhen]
      ,[RiskArea_DocumentModifiedWhen]
      ,[Question_DocumentModifiedWhen]
      ,[Answer_DocumentModifiedWhen]
      ,[AllowMultiSelect]
      ,[LocID]
      ,[HashCode]
      ,[CMS_Class_CtID]
      ,[CMS_Class_SCV]
      ,[CMS_Document_CtID]
      ,[CMS_Document_SCV]
      ,[CMS_Site_CtID]
      ,[CMS_Site_SCV]
      ,[CMS_Tree_CtID]
      ,[CMS_Tree_SCV]
      ,[CMS_User_CtID]
      ,[CMS_User_SCV]
      ,[COM_SKU_CtID]
      ,[COM_SKU_SCV]
      ,[HFit_HealthAssesmentMatrixQuestion_CtID]
      ,[HFit_HealthAssesmentMatrixQuestion_SCV]
      ,[HFit_HealthAssesmentModule_CtID]
      ,[HFit_HealthAssesmentModule_SCV]
      ,[HFit_HealthAssesmentMultipleChoiceQuestion_CtID]
      ,[HFit_HealthAssesmentMultipleChoiceQuestion_SCV]
      ,[HFit_HealthAssesmentRiskArea_CtID]
      ,[HFit_HealthAssesmentRiskArea_SCV]
      ,[HFit_HealthAssesmentRiskCategory_CtID]
      ,[HFit_HealthAssesmentRiskCategory_SCV]
      ,[HFit_HealthAssessment_CtID]
      ,[HFit_HealthAssessment_SCV]
      ,[HFit_HealthAssessmentFreeForm_CtID]
      ,[HFit_HealthAssessmentFreeForm_SCV]
      ,[CMS_Class_CHANGE_OPERATION]
      ,[CMS_Document_CHANGE_OPERATION]
      ,[CMS_Site_CHANGE_OPERATION]
      ,[CMS_Tree_CHANGE_OPERATION]
      ,[CMS_User_CHANGE_OPERATION]
      ,[COM_SKU_CHANGE_OPERATION]
      ,[HFit_HealthAssesmentMatrixQuestion_CHANGE_OPERATION]
      ,[HFit_HealthAssesmentModule_CHANGE_OPERATION]
      ,[HFit_HealthAssesmentMultipleChoiceQuestion_CHANGE_OPERATION]
      ,[HFit_HealthAssesmentRiskArea_CHANGE_OPERATION]
      ,[HFit_HealthAssesmentRiskCategory_CHANGE_OPERATION]
      ,[HFit_HealthAssessment_CHANGE_OPERATION]
      ,[HFit_HealthAssessmentFreeForm_CHANGE_OPERATION]
      ,[CHANGED_FLG]
      ,[CHANGE_TYPE_CODE]
      ,[LastModifiedDate]
      ,[RowNbr]
      ,[DeletedFlg]
  FROM [Staging_EDW_HealthDefinition]


GO
print('***** FROM: view_EDW_HealthAssessmentDefinition_Staged.sql'); 
GO 
