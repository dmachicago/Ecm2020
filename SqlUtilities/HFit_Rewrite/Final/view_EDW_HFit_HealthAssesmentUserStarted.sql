/*
alter table HFit_HealthAssesmentUserStarted add HADateReceived datetime null 
go
alter table HFit_HealthAssesmentUserStarted add HSFulfillmentCulture nvarchar(10) null 
GO
alter table HFit_HealthAssesmentUserStarted add HATelephonicFlg bit not null default 1
GO

alter table HFit_HealthAssesmentUserStarted drop column HADateReceived 
go
alter table HFit_HealthAssesmentUserStarted drop column HSFulfillmentCulture 
GO
alter table HFit_HealthAssesmentUserStarted drop column HATelephonicFlg
GO
*/



--GRANT SELECT
--	ON [dbo].[view_EDW_HFit_HealthAssesmentUserStarted]
--	TO [EDWReader_PRD]
--GO


if exists (select * from sysobjects where name = 'view_EDW_HFit_HealthAssesmentUserStarted' and Xtype = 'V')
BEGIN
	drop view view_EDW_HFit_HealthAssesmentUserStarted ;
END 
go


create view view_EDW_HFit_HealthAssesmentUserStarted
as
--*****************************************************************************
--8.16.2014 (wdm) - This view was created as a stopgap method until the 
--			required GUID fields are contained within all tables and 
--			populated correctly. Once those fields are accessable,
--			this view should go awway and the base table use in its place.
--*****************************************************************************
SELECT [ItemID]
      ,[UserID]
      ,[HADocumentID]
      ,[HAVersionID]
      ,[HAPaperFlg]
      ,[ItemCreatedBy]
      ,[ItemCreatedWhen]
      ,[ItemModifiedBy]
      ,[ItemModifiedWhen]
      ,[ItemOrder]
      ,[ItemGUID]
      ,[HAIPadFlg]
      ,[HAStartedDt]
      ,[HACompletedDt]
      ,[HALastDocumentID]
      ,[HALastVersionID]
      ,[HAScore]
      ,[HALastSectionCompleted]
      ,[HADocumentConfigID]
      ,[HACampaignNodeGUID]
      ,[HADateReceived]
      ,[HSFulfillmentCulture]
      ,[HATelephonicFlg]	  
	  ,CMS_DOCUMENT.DocumentGUID as HealthAssesmentUserStartedDocGUID	--MARK and DALE chose not to use NodeGUID here  
	  ,CMSTREE2.NodeGUID as HealthAssesmentUserStartedNodeGUID
  FROM [dbo].[HFit_HealthAssesmentUserStarted] 
  join CMS_DOCUMENT on CMS_DOCUMENT.DocumentID = [HFit_HealthAssesmentUserStarted].[HADocumentID]
  INNER JOIN View_CMS_Tree_Joined AS CMSTREE2 ON CMS_DOCUMENT.DocumentNodeID = CMSTREE2.NodeID
GO
