
print ('Creating view_EDW_HFit_HealthAssesmentUserRiskArea') ;
go

if exists (select * from sysobjects where name = 'view_EDW_HFit_HealthAssesmentUserRiskArea' and Xtype = 'V')
BEGIN
	drop view view_EDW_HFit_HealthAssesmentUserRiskArea ;
END 
go

--GRANT SELECT
--	ON [dbo].[view_EDW_HFit_HealthAssesmentUserRiskArea]
--	TO [EDWReader_PRD]
--GO

create view [dbo].[view_EDW_HFit_HealthAssesmentUserRiskArea]
as
--*****************************************************************************
--8.16.2014 (wdm) - This view was created as a stopgap methofd until the 
--			required GUID fields are contained within all tables and 
--			populated correctly. Once those fields are accessable,
--			this view should go awway and the base table use in its place.
--*****************************************************************************
SELECT RISKAREA.[ItemID]
      ,RISKAREA.[UserID]
      ,RISKAREA.[HARiskAreaDocumentID]
      ,RISKAREA.[HARiskAreaVersionID]
      ,RISKAREA.[HARiskAreaWeight]
      ,RISKAREA.[HARiskAreaScore]
      ,RISKAREA.[ItemCreatedBy]
      ,RISKAREA.[ItemCreatedWhen]
      ,RISKAREA.[ItemModifiedBy]
      ,RISKAREA.[ItemModifiedWhen]
      ,RISKAREA.[ItemOrder]
      ,RISKAREA.[ItemGUID]
      ,RISKAREA.[HARiskCategoryDocumentID]
      ,RISKAREA.[HARiskCategoryItemID]
      ,RISKAREA.[CodeName]
      ,RISKAREA.[PreWeightedScore]
    --,CMSTREE2.DocumentGUID AS HARiskAreaNodeGUID	--Mark and Dale USE NODE GUID HERE
	,CMSTREE2.NodeGUID AS HARiskAreaNodeGUID	--Mark and Dale USE NODE GUID HERE
	,CMSTREE2.NodeGUID AS CMSNodeGUID
FROM [dbo].HFit_HealthAssesmentUserRiskArea as RISKAREA
		inner join HFit_HealthAssesmentUserRiskCategory as CAT ON RISKAREA.HARiskCategoryItemID = CAT.[ItemID]
		INNER JOIN CMS_Document AS CMSDOC2 ON RISKAREA.HARiskAreaDocumentID = CMSDOC2.DocumentID 
		INNER JOIN View_CMS_Tree_Joined AS CMSTREE2 ON CMSDOC2.DocumentNodeID = CMSTREE2.NodeID

GO
print ('Creating view_EDW_HFit_HealthAssesmentUserRiskArea') ;
go
