
/****** Object:  View [dbo].[view_EDW_HARiskCategoryNodeGUID]    Script Date: 8/23/2014 5:06:36 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


ALTER view [dbo].[view_EDW_HARiskCategoryNodeGUID]
as
Select distinct CMSTREE2.NodeGuid as HARiskCategoryNodeGUID, CMSDOC3.DocumentID, CMSDOC3.DocumentNodeID 
from	HFit_HealthAssesmentUserRiskCategory RISKCAT
inner join cms_document CMSDOC3 on RISKCAT.HARiskCategoryDocumentID = CMSDOC3.DocumentID
inner join cms_tree CMSTREE2 on CMSDOC3.DocumentNodeID = CMSTREE2.NodeID

GO


