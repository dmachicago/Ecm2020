
if exists (select * from sysobjects where name = 'view_EDW_HFit_HealthAssesmentUserRiskCategory' and Xtype = 'V')
BEGIN
	drop view view_EDW_HFit_HealthAssesmentUserRiskCategory ;
END 
go

--GRANT SELECT
--	ON [dbo].[view_EDW_HFit_HealthAssesmentUserRiskCategory]
--	TO [EDWReader_PRD]
--GO

create view [dbo].[view_EDW_HFit_HealthAssesmentUserRiskCategory]
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
	  --,CMSTREE2.DocumentGuid as HARiskCategoryNodeGUID	--MARK and DALE use NodeGUID here  
	  ,CMSTREE2.NodeGuid as HARiskCategoryNodeGUID	--MARK and DALE use NodeGUID here  
	  ,CMSTREE2.NodeGuid as CMSNodeGUID
from	HFit_HealthAssesmentUserRiskCategory RISKCAT
inner join cms_document CMSDOC3 on RISKCAT.HARiskCategoryDocumentID = CMSDOC3.DocumentID
inner join View_CMS_Tree_Joined CMSTREE2 on CMSDOC3.DocumentNodeID = CMSTREE2.NodeID


GO


