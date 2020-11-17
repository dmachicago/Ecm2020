
print ('Creating view_EDW_HFit_HealthAssesmentUserAnswers');
go

if exists (select * from sysobjects where name = 'view_EDW_HFit_HealthAssesmentUserAnswers' and Xtype = 'V')
BEGIN
	drop view view_EDW_HFit_HealthAssesmentUserAnswers ;
END 
go

--GRANT SELECT
--	ON [dbo].[view_EDW_HFit_HealthAssesmentUserAnswers]
--	TO [EDWReader_PRD]
--GO


create view view_EDW_HFit_HealthAssesmentUserAnswers
as
--*****************************************************************************
--8.16.2014 (wdm) - This view was created as a stopgap methofd until the 
--			required GUID fields are contained within all tables and 
--			populated correctly. Once those fields are accessable,
--			this view should go awway and the base table use in its place.
--*****************************************************************************
SELECT [ItemID]
      ,[UserID]
      ,[HAAnswerDocumentID]
      ,[HAAnswerVersionID]
      ,[HAAnswerPoints]
      ,[ItemCreatedBy]
      ,[ItemCreatedWhen]
      ,[ItemModifiedBy]
      ,[ItemModifiedWhen]
      ,[ItemOrder]
      ,[ItemGUID]
      ,[HAAnswerValue]
      ,[HAQuestionDocumentID]
      ,[HAQuestionItemID]
      ,[UOMCode]
      ,[CodeName]
	  --,CMSTREE2.DocumentGUID as HAAnswerNodeGUID	--Mark and Dale USE NODE GUID HERE
	  ,CMSTREE2.NodeGuid as HAAnswerNodeGUID	--Mark and Dale USE NODE GUID HERE
	  ,CMSTREE2.NodeGuid as CMSNodeGUID
FROM [dbo].[HFit_HealthAssesmentUserAnswers] as UserAnswers
inner join cms_document CMSDOC3 on UserAnswers.HAAnswerDocumentID = CMSDOC3.DocumentID
inner join View_CMS_Tree_Joined CMSTREE2 on CMSDOC3.DocumentNodeID = CMSTREE2.NodeID

GO
print ('Created view_EDW_HFit_HealthAssesmentUserAnswers');
go
