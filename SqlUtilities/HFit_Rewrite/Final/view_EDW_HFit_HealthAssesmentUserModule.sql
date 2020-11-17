
print ('Creating view_EDW_HFit_HealthAssesmentUserModule');
go

if exists (select * from sysobjects where name = 'view_EDW_HFit_HealthAssesmentUserModule' and Xtype = 'V')
BEGIN
	drop view view_EDW_HFit_HealthAssesmentUserModule ;
END 
go

--GRANT SELECT
--	ON [dbo].[view_EDW_HFit_HealthAssesmentUserModule]
--	TO [EDWReader_PRD]
--GO
create view [dbo].[view_EDW_HFit_HealthAssesmentUserModule]
as
--*****************************************************************************
--8.16.2014 (wdm) - This view was created as a stopgap methofd until the 
--			required GUID fields are contained within all tables and 
--			populated correctly. Once those fields are accessable,
--			this view should go awway and the base table use in its place.
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
	  --,CMSTREE2.DocumentGUID as HAModuleNodeGUID	--WDM 09.16.2014	--MARK and DALE use NodeGUID here  
	  ,CMSTREE2.NodeGuid as HAModuleNodeGUID		--WDM 09.16.2014	--MARK and DALE use NodeGUID here  
	  ,CMSTREE2.NodeGuid as CMSNodeGUID				--WDM 09.16.2014	
from	HFit_HealthAssesmentUserModule USERMOD
inner join cms_document CMSDOC3 on USERMOD.HAModuleDocumentID = CMSDOC3.DocumentID
inner join View_CMS_Tree_Joined CMSTREE2 on CMSDOC3.DocumentNodeID = CMSTREE2.NodeID
GO

print ('Created view_EDW_HFit_HealthAssesmentUserModule');
go

