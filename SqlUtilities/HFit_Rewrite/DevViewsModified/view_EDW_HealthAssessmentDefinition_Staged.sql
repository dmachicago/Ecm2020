print ('Processing: view_EDW_HealthAssessmentDefinition_Staged ') ;
go

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
--****************************************************************************
SELECT [SiteGuid]
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
      ,[DocumentCreatedWhen]
      ,[DocumentModifiedWhen]
      ,[CmsTreeNodeGuid]
      ,[HANodeGUID]
  FROM [dbo].[EDW_HealthAssessmentDefinition]

GO


