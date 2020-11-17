SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


ALTER view [dbo].[view_EDW_HFit_HealthAssesmentUserModule]
as
--*****************************************************************************
--8.16.2014 (wdm) - This view was created as a stopgap methofd until the 
--			required GUID fields are contained within all tables and 
--			populated correctly. Once those fields are accessable,
--			this view should go away and the base table use in its place.
--*****************************************************************************
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
  FROM [dbo].[HFit_HealthAssesmentUserModule]
   join CMS_DOCUMENT on CMS_DOCUMENT.DocumentID = [HFit_HealthAssesmentUserModule].HAModuleDocumentID
  INNER JOIN CMS_Tree AS CMSTREE2 ON CMS_DOCUMENT.DocumentNodeID = CMSTREE2.NodeID


GO



-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
