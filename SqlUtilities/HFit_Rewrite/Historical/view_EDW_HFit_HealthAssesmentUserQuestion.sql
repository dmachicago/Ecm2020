
alter view view_EDW_HFit_HealthAssesmentUserQuestion
as
--*********************************************************************************
--8/18/2014 (WDM)
--This VIEW was created to overcome the table GUID columns that are presemt in DEV 
--and missing in the other environments. It will not be needed when DEV is promoted
--to the other environments.
--*********************************************************************************
SELECT [ItemID]
      ,[UserID]
      ,[HAQuestionDocumentID]
      ,[HAQuestionVersionID]
      ,[HAQuestionWeight]
      ,[HAQuestionScore]
      ,[ItemCreatedBy]
      ,[ItemCreatedWhen]
      ,[ItemModifiedBy]
      ,[ItemModifiedWhen]
      ,[ItemOrder]
      ,[ItemGUID]
      ,[HARiskAreaDocumentID]
      ,[HARiskAreaItemID]
      ,[CodeName]
      ,[PreWeightedScore]
      ,[IsProfessionallyCollected]
      ,[ProfessionallyCollectedEventDate]
	  ,CMSTREE1.NodeGUID AS HAQuestionNodeGUID
  FROM [dbo].[HFit_HealthAssesmentUserQuestion] AS USERQUES 
  --SELECT distinct CMSTREE1.NodeGUID AS HAQuestionNodeGUID, CMSDOC1.DocumentID, CMSDOC1.DocumentNodeID
--FROM     HFit_HealthAssesmentUserQuestion AS USERQUES 
		INNER JOIN CMS_Document AS CMSDOC1 ON USERQUES.HAQuestionDocumentID = CMSDOC1.DocumentID 
		INNER JOIN CMS_Tree AS CMSTREE1 ON CMSDOC1.DocumentNodeID = CMSTREE1.NodeID 
GO


