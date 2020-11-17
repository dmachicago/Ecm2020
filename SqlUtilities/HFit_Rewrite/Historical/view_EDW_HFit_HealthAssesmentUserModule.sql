
alter view view_EDW_HFit_HealthAssesmentUserModule
as
SELECT [ItemID]
      ,[UserID]
      ,[HAModuleDocumentID]
      ,[HAModuleVersionID]
      ,[HAModuleWeight]
      ,[ItemCreatedBy]
      ,[ItemCreatedWhen]
      ,[ItemModifiedBy]
      ,[ItemModifiedWhen]
      ,[ItemOrder]
      ,[ItemGUID]
      ,[HAModuleScore]
      ,[HADocumentID]
      ,[HAStartedItemID]
      ,[CodeName]
      ,[PreWeightedScore]
	  ,CMSTREE2.NodeGuid as HAModuleNodeGUID
  --FROM [dbo].[HFit_HealthAssesmentUserModule]
--Select distinct CMSTREE2.NodeGuid as HAModuleNodeGUID, CMSDOC3.DocumentID, CMSDOC3.DocumentNodeID 
from	HFit_HealthAssesmentUserModule USERMOD
inner join cms_document CMSDOC3 on USERMOD.HAModuleDocumentID = CMSDOC3.DocumentID
inner join cms_tree CMSTREE2 on CMSDOC3.DocumentNodeID = CMSTREE2.NodeID
GO


