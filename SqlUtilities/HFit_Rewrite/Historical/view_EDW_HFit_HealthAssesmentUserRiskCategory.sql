
/****** Object:  View [dbo].[view_EDW_HFit_HealthAssesmentUserRiskCategory]    Script Date: 8/20/2014 11:19:49 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


ALTER view [dbo].[view_EDW_HFit_HealthAssesmentUserRiskCategory]
as
SELECT [ItemID]
      ,[ItemCreatedBy]
      ,[ItemCreatedWhen]
      ,[ItemModifiedBy]
      ,[ItemModifiedWhen]
      ,[ItemOrder]
      ,[ItemGUID]
      ,[UserID]
      ,[HARiskCategoryDocumentID]
      ,[HARiskCategoryVersionID]
      ,[HARiskCategoryWeight]
      ,[HARiskCategoryScore]
      ,[HAModuleDocumentID]
      ,[HAModuleItemID]
      ,[CodeName]
      ,[PreWeightedScore]
	  ,CMSTREE2.NodeGuid as HARiskCategoryNodeGUID
--FROM [dbo].[HFit_HealthAssesmentUserRiskCategory]
--Select distinct CMSTREE2.NodeGuid as HARiskCategoryNodeGUID, CMSDOC3.DocumentID, CMSDOC3.DocumentNodeID 
from	HFit_HealthAssesmentUserRiskCategory RISKCAT
inner join cms_document CMSDOC3 on RISKCAT.HARiskCategoryDocumentID = CMSDOC3.DocumentID
inner join cms_tree CMSTREE2 on CMSDOC3.DocumentNodeID = CMSTREE2.NodeID


GO


