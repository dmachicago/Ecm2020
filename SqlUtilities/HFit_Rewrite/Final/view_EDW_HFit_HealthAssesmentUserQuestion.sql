
if exists (select * from sysobjects where name = 'view_EDW_HFit_HealthAssesmentUserQuestion' and Xtype = 'V')
BEGIN
	drop view view_EDW_HFit_HealthAssesmentUserQuestion ;
END 
go

--GRANT SELECT
--	ON [dbo].[view_EDW_HFit_HealthAssesmentUserQuestion]
--	TO [EDWReader_PRD]
--GO

--select * from HFit_HealthAssesmentUserQuestion
--select * from view_EDW_HFit_HealthAssesmentUserQuestion
create view view_EDW_HFit_HealthAssesmentUserQuestion
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
	  --,CMSTREE1.DocumentGUID AS HAQuestionNodeGUID	--MARK and DALE use NodeGUID here  
	  ,CMSTREE1.NodeGUID AS HAQuestionNodeGUID	--MARK and DALE use NodeGUID here  
	  ,CMSTREE1.NodeGUID AS CMSNodeGUID
  FROM [dbo].[HFit_HealthAssesmentUserQuestion] AS USERQUES 
  --SELECT distinct CMSTREE1.NodeGUID AS HAQuestionNodeGUID, CMSDOC1.DocumentID, CMSDOC1.DocumentNodeID
--FROM     HFit_HealthAssesmentUserQuestion AS USERQUES 
		INNER JOIN CMS_Document AS CMSDOC1 ON USERQUES.HAQuestionDocumentID = CMSDOC1.DocumentID 
		INNER JOIN View_CMS_Tree_Joined AS CMSTREE1 ON CMSDOC1.DocumentNodeID = CMSTREE1.NodeID 
GO


