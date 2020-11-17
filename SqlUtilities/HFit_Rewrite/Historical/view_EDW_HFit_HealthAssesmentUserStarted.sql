alter view view_EDW_HFit_HealthAssesmentUserStarted
as
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
	  ,CMSTREE2.NodeGUID as HealthAssesmentUserStartedNodeGUID
	  ,CMS_DOCUMENT.DocumentGUID as HealthAssesmentUserStartedDocGUID
  FROM [dbo].[HFit_HealthAssesmentUserStarted] 
  join CMS_DOCUMENT on CMS_DOCUMENT.DocumentID = [HFit_HealthAssesmentUserStarted].[HADocumentID]
  INNER JOIN CMS_Tree AS CMSTREE2 ON CMS_DOCUMENT.DocumentNodeID = CMSTREE2.NodeID
GO
