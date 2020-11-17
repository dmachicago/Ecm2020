
alter view view_EDW_HFit_HealthAssesmentUserAnswers
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
	  ,CMSTREE2.NodeGuid as HAAnswerNodeGUID
FROM [dbo].[HFit_HealthAssesmentUserAnswers] as UserAnswers
inner join cms_document CMSDOC3 on UserAnswers.HAAnswerDocumentID = CMSDOC3.DocumentID
inner join cms_tree CMSTREE2 on CMSDOC3.DocumentNodeID = CMSTREE2.NodeID


