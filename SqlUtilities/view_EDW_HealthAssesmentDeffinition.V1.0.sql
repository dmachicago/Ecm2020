
--select * from [view_EDW_HealthAssesmentDeffinition]
/*
drop index View_CMS_Tree_Joined_Regular.IX_View_CMS_Tree_Joined_Regular_NodeSiteID_DocumentCulture_NodeID
go

CREATE UNIQUE  CLUSTERED  INDEX IX_View_CMS_Tree_Joined_Regular_NodeSiteID_DocumentCulture_NodeID
    ON View_CMS_Tree_Joined_Regular
 (     [NodeSiteID] ASC 
      , [DocumentCulture] ASC 
      , [NodeID] ASC 
, [NodeName]
, [DocumentID]
, [DocumentModifiedWhen]
, [DocumentCreatedWhen]
, [DocumentPublishedVersionHistoryID]
 )

go

Drop index CMS_Site.IX_CMS_Site_SiteDisplayName ;
go
CREATE  CLUSTERED  INDEX IX_CMS_Site_SiteDisplayName
    ON CMS_Site
 (     [SiteDisplayName] ASC 
, [SiteGUID]
 )
GO

Drop index View_CMS_Tree_Joined_Regular.IX_View_CMS_Tree_Joined_Regular_ClassName_NodeSiteID_DocumentForeignKeyValue_DocumentCulture ;
go
CREATE NONCLUSTERED  INDEX IX_View_CMS_Tree_Joined_Regular_ClassName_NodeSiteID_DocumentForeignKeyValue_DocumentCulture
    ON View_CMS_Tree_Joined_Regular
 (     [ClassName] ASC 
      , [NodeSiteID] ASC 
      , [DocumentForeignKeyValue] ASC 
      , [DocumentCulture] ASC 
, [DocumentID] ASC 
, [DocumentPublishedVersionHistoryID] ASC 
, [DocumentNodeID] ASC 
, [NodeParentID] ASC 
, NodeName ASC
,DocumentModifiedWhen ASC
,DocumentCreatedWhen ASC
     , [NodeID] ASC 
 )
 go

 Drop index View_CMS_Tree_Joined_Linked.IX_View_CMS_Tree_Joined_Linked_NodeSiteID_DocumentCulture_NodeID
 go

 CREATE UNIQUE  CLUSTERED  INDEX IX_View_CMS_Tree_Joined_Linked_NodeSiteID_DocumentCulture_NodeID
    ON View_CMS_Tree_Joined_Linked
 (     [NodeSiteID] ASC 
      , [DocumentCulture] ASC 
      , [NodeID] ASC 
, [DocumentID] ASC 
, [DocumentPublishedVersionHistoryID] ASC 
, [DocumentNodeID] ASC 
, [NodeParentID] ASC 
--, [ClassName] asc
 )


*/


/****** Object:  View [dbo].[view_EDW_HealthAssesmentDeffinition]    Script Date: 7/31/2014 11:07:26 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

alter VIEW [dbo].[view_EDW_HealthAssesmentDeffinition]
AS
--*******************************************************************************************
--WDM - 6/25/2014
--Query was returning a NULL dataset. Found that it is being caused by the AccountCD join.
--Worked with Shane to discover the CMS Tree had been modified.
--Modified the code so that reads it reads the CMS tree correctly - working.
--7/14/2014 1:29 time to run - 79024 rows - DEV
--7/14/2014 0:58 time to run - 57472 rows - PROD1
--7/14/2014 1:11 time to run - 57472 rows - PROD1 (with between date)
--7/15/2014 - Query was returning NodeName of 'Campaigns' only
--	Found the issue in view View_HFit_HACampaign_Joined. Documented the change in the view.
--7/16/2014 - Full Select: Using a DocumentModifiedWhen filter 00:17:28 - Record Cnt: 793,520
--*******************************************************************************************
	SELECT 
		cs.SiteGUID
		, HFA.AccountCD
		, VCTJ.NodeID AS HANodeID
		, VCTJ.NodeName AS HANodeName
		, VCTJ.DocumentID AS HADocumentID
		, VCTJ.NodeSiteID AS HANodeSiteID
       --,VCTJ.NodeAliasPath AS HANodeAliasPath
		, VCTJ.DocumentPublishedVersionHistoryID AS HADocPubVerID
		, VHFHAMJ.Title AS ModTitle
		, dbo.udf_StripHTML(left(left(VHFHAMJ.IntroText,4000),4000)) AS IntroText
		, VHFHAMJ.DocumentID AS ModDocID
		, VHFHAMJ.Weight AS ModWeight
		, VHFHAMJ.IsEnabled AS ModIsEnabled
		, VHFHAMJ.CodeName AS ModCodeName
       --,VHFHAMJ.NodeAliasPath AS ModNodeAliasPath
		, VHFHAMJ.DocumentPublishedVersionHistoryID AS ModDocPubVerID
		, VHFHARCJ.Title AS RCTitle
		, VHFHARCJ.Weight AS RCWeight
		, VHFHARCJ.DocumentID AS RCDocumentID
		, VHFHARCJ.IsEnabled AS RCIsEnabled
		, VHFHARCJ.CodeName AS RCCodeName
       --,VHFHARCJ.NodeAliasPath AS RCNodeAliasPath
		, VHFHARCJ.DocumentPublishedVersionHistoryID AS RCDocPubVerID
		, VHFHARAJ.Title AS RATytle
		, VHFHARAJ.Weight AS RAWeight
		, VHFHARAJ.DocumentID AS RADocumentID
		, VHFHARAJ.IsEnabled AS RAIsEnabled
		, VHFHARAJ.CodeName AS RACodeName
       --,VHFHARAJ.NodeAliasPath AS RANodeAliasPath
		, VHFHARAJ.ScoringStrategyID AS RAScoringStrategyID
		, VHFHARAJ.DocumentPublishedVersionHistoryID AS RADocPubVerID
		, VHFHAQ.QuestionType
		, dbo.udf_StripHTML(left(VHFHAQ.Title,4000)) AS QuesTitle
		, VHFHAQ.Weight AS QuesWeight
		, VHFHAQ.IsRequired AS QuesIsRequired
		, VHFHAQ.DocumentID AS QuesDocumentID
		, VHFHAQ.IsEnabled AS QuesIsEnabled
		, left(VHFHAQ.IsVisible,4000) AS QuesIsVisible
		, VHFHAQ.IsStaging AS QuesIsSTaging
		, VHFHAQ.CodeName AS QuestionCodeName
       --,VHFHAQ.NodeAliasPath AS QuesNodeAliasPath
		, VHFHAQ.DocumentPublishedVersionHistoryID AS QuesDocPubVerID
		, VHFHAA.Value AS AnsValue
		, VHFHAA.Points AS AnsPoints
		, VHFHAA.DocumentID AS AnsDocumentID
		, VHFHAA.IsEnabled AS AnsIsEnabled
		, VHFHAA.CodeName AS AnsCodeName
		, VHFHAA.UOM AS AnsUOM
       --,VHFHAA.NodeAliasPath AS AnsNodeAliasPath
		, VHFHAA.DocumentPublishedVersionHistoryID AS AnsDocPUbVerID
		, CASE	WHEN CAST(VCTJ.DocumentCreatedWhen AS DATE) = CAST(vctj.DocumentModifiedWhen AS DATE)
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		, VCTJ.DocumentCreatedWhen
		, VCTJ.DocumentModifiedWhen
--select  VCTJ.NodeName ,*  
	 FROM
  dbo.View_CMS_Tree_Joined AS VCTJ
 INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
 INNER JOIN HFit_Account hfa WITH(NOLOCK) ON cs.SiteID = hfa.SiteID
 
 INNER JOIN dbo.View_HFit_HACampaign_Joined c WITH(NOLOCK) ON VCTJ.NodeID = c.NodeParentID
 
 INNER JOIN View_HFit_HealthAssessment_Joined ha WITH (NOLOCK) ON c.HealthAssessmentID = ha.DocumentID
 INNER JOIN dbo.View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ ON ha.NodeID = VHFHAMJ.NodeParentID
 INNER JOIN dbo.View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
 INNER JOIN dbo.View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
 INNER JOIN dbo.View_HFit_HealthAssesmentQuestions AS VHFHAQ ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
 LEFT OUTER JOIN dbo.View_HFit_HealthAssesmentAnswers AS VHFHAA ON VHFHAQ.NodeID = VHFHAA.NodeParentID
 
UNION ALL
--WDM Retrieve Matrix Level 1 Question Group
	SELECT
		cs.SiteGUID
		, HFA.AccountCD
		, VCTJ.NodeID
		, VCTJ.NodeName
		, VCTJ.DocumentID
		, VCTJ.NodeSiteID
       --,VCTJ.NodeAliasPath
		, VCTJ.DocumentPublishedVersionHistoryID
		, VHFHAMJ.Title
		, dbo.udf_StripHTML(left(left(VHFHAMJ.IntroText,4000),4000)) AS IntroText
		, VHFHAMJ.DocumentID
		, VHFHAMJ.Weight
		, VHFHAMJ.IsEnabled
		, VHFHAMJ.CodeName
       --,VHFHAMJ.NodeAliasPath
		, VHFHAMJ.DocumentPublishedVersionHistoryID
		, VHFHARCJ.Title
		, VHFHARCJ.Weight
		, VHFHARCJ.DocumentID
		, VHFHARCJ.IsEnabled
		, VHFHARCJ.CodeName
       --,VHFHARCJ.NodeAliasPath
		, VHFHARCJ.DocumentPublishedVersionHistoryID
		, VHFHARAJ.Title
		, VHFHARAJ.Weight
		, VHFHARAJ.DocumentID
		, VHFHARAJ.IsEnabled
		, VHFHARAJ.CodeName
       --,VHFHARAJ.NodeAliasPath
		, VHFHARAJ.ScoringStrategyID
		, VHFHARAJ.DocumentPublishedVersionHistoryID
		, VHFHAQ2.QuestionType
		, dbo.udf_StripHTML(left(VHFHAQ2.Title,4000)) AS QuesTitle
		, VHFHAQ2.Weight
		, VHFHAQ2.IsRequired
		, VHFHAQ2.DocumentID
		, VHFHAQ2.IsEnabled
		, left(VHFHAQ2.IsVisible,4000)
		, VHFHAQ2.IsStaging
		, VHFHAQ2.CodeName AS QuestionCodeName
       --,VHFHAQ2.NodeAliasPath
		, VHFHAQ2.DocumentPublishedVersionHistoryID
		, VHFHAA2.Value
		, VHFHAA2.Points
		, VHFHAA2.DocumentID
		, VHFHAA2.IsEnabled
		, VHFHAA2.CodeName
		, VHFHAA2.UOM
       --,VHFHAA2.NodeAliasPath
		, VHFHAA2.DocumentPublishedVersionHistoryID
		, CASE	WHEN CAST(VCTJ.DocumentCreatedWhen AS DATE) = CAST(vctj.DocumentModifiedWhen AS DATE)
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		, VCTJ.DocumentCreatedWhen
		, VCTJ.DocumentModifiedWhen
	 FROM
  dbo.View_CMS_Tree_Joined AS VCTJ

 INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
 INNER JOIN HFit_Account hfa WITH(NOLOCK) ON cs.SiteID = hfa.SiteID
 INNER JOIN dbo.View_HFit_HACampaign_Joined c WITH(NOLOCK) ON VCTJ.NodeID = c.NodeParentID
 INNER JOIN View_HFit_HealthAssessment_Joined ha WITH (NOLOCK) ON c.HealthAssessmentID = ha.DocumentID
 INNER JOIN dbo.View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ ON ha.NodeID = VHFHAMJ.NodeParentID
 INNER JOIN dbo.View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
 INNER JOIN dbo.View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
 INNER JOIN dbo.View_HFit_HealthAssesmentQuestions AS VHFHAQ ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
 LEFT OUTER JOIN dbo.View_HFit_HealthAssesmentAnswers AS VHFHAA ON VHFHAQ.NodeID = VHFHAA.NodeParentID
--matrix level 1 questiongroup
	INNER JOIN dbo.View_HFit_HealthAssesmentQuestions AS VHFHAQ2 ON VHFHAQ.NodeID = VHFHAQ2.NodeParentID
	INNER JOIN dbo.View_HFit_HealthAssesmentAnswers AS VHFHAA2 ON VHFHAQ2.NodeID = VHFHAA2.NodeParentID

UNION ALL
--WDM Retrieve Branching Level 1 Question and Matrix Level 1 Question Group
	SELECT
		cs.SiteGUID
		, HFA.AccountCD
		, VCTJ.NodeID
		, VCTJ.NodeName
		, VCTJ.DocumentID
		, VCTJ.NodeSiteID
       --,VCTJ.NodeAliasPath
		, VCTJ.DocumentPublishedVersionHistoryID
		, VHFHAMJ.Title
		, dbo.udf_StripHTML(left(VHFHAMJ.IntroText,4000)) AS IntroText
		, VHFHAMJ.DocumentID
		, VHFHAMJ.Weight
		, VHFHAMJ.IsEnabled
		, VHFHAMJ.CodeName
       --,VHFHAMJ.NodeAliasPath
		, VHFHAMJ.DocumentPublishedVersionHistoryID
		, VHFHARCJ.Title
		, VHFHARCJ.Weight
		, VHFHARCJ.DocumentID
		, VHFHARCJ.IsEnabled
		, VHFHARCJ.CodeName
       --,VHFHARCJ.NodeAliasPath
		, VHFHARCJ.DocumentPublishedVersionHistoryID
		, VHFHARAJ.Title
		, VHFHARAJ.Weight
		, VHFHARAJ.DocumentID
		, VHFHARAJ.IsEnabled
		, VHFHARAJ.CodeName
       --,VHFHARAJ.NodeAliasPath
		, VHFHARAJ.ScoringStrategyID
		, VHFHARAJ.DocumentPublishedVersionHistoryID
		, VHFHAQ3.QuestionType
		, dbo.udf_StripHTML(left(VHFHAQ3.Title,4000)) AS QuesTitle
		, VHFHAQ3.Weight
		, VHFHAQ3.IsRequired
		, VHFHAQ3.DocumentID
		, VHFHAQ3.IsEnabled
		, left(VHFHAQ3.IsVisible,4000)
		, VHFHAQ3.IsStaging
		, VHFHAQ3.CodeName AS QuestionCodeName
       --,VHFHAQ3.NodeAliasPath
		, VHFHAQ3.DocumentPublishedVersionHistoryID
		, VHFHAA3.Value
		, VHFHAA3.Points
		, VHFHAA3.DocumentID
		, VHFHAA3.IsEnabled
		, VHFHAA3.CodeName
		, VHFHAA3.UOM
       --,VHFHAA3.NodeAliasPath
		, VHFHAA3.DocumentPublishedVersionHistoryID
		, CASE	WHEN CAST(VCTJ.DocumentCreatedWhen AS DATE) = CAST(vctj.DocumentModifiedWhen AS DATE)
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		, VCTJ.DocumentCreatedWhen
		, VCTJ.DocumentModifiedWhen
 FROM
  dbo.View_CMS_Tree_Joined AS VCTJ

 INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
 INNER JOIN HFit_Account hfa WITH(NOLOCK) ON cs.SiteID = hfa.SiteID
 INNER JOIN dbo.View_HFit_HACampaign_Joined c WITH(NOLOCK) ON VCTJ.NodeID = c.NodeParentID
 INNER JOIN View_HFit_HealthAssessment_Joined ha WITH (NOLOCK) ON c.HealthAssessmentID = ha.DocumentID
 INNER JOIN dbo.View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ ON ha.NodeID = VHFHAMJ.NodeParentID
 INNER JOIN dbo.View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
 INNER JOIN dbo.View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
 INNER JOIN dbo.View_HFit_HealthAssesmentQuestions AS VHFHAQ ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
 LEFT OUTER JOIN dbo.View_HFit_HealthAssesmentAnswers AS VHFHAA ON VHFHAQ.NodeID = VHFHAA.NodeParentID

--matrix level 1 questiongroup
--INNER JOIN dbo.View_HFit_HealthAssesmentQuestions AS VHFHAQ2 ON VHFHAQ.NodeID = VHFHAQ2.NodeParentID
--INNER JOIN dbo.View_HFit_HealthAssesmentAnswers AS VHFHAA2 ON VHFHAQ2.NodeID = VHFHAA2.NodeParentID

--Branching Level 1 Question 
	INNER JOIN dbo.View_HFit_HealthAssesmentQuestions AS VHFHAQ3 ON VHFHAA.NodeID = VHFHAQ3.NodeParentID
	LEFT OUTER JOIN dbo.View_HFit_HealthAssesmentAnswers AS VHFHAA3 ON VHFHAQ3.NodeID = VHFHAA3.NodeParentID

UNION ALL
--WDM Retrieve Branching Level 1 Question and Matrix Level 2 Question Group
	SELECT
		cs.SiteGUID
		, HFA.AccountCD
		, VCTJ.NodeID
		, VCTJ.NodeName
		, VCTJ.DocumentID
		, VCTJ.NodeSiteID
       --,VCTJ.NodeAliasPath
		, VCTJ.DocumentPublishedVersionHistoryID
		, VHFHAMJ.Title
		, dbo.udf_StripHTML(left(VHFHAMJ.IntroText,4000)) AS IntroText
		, VHFHAMJ.DocumentID
		, VHFHAMJ.Weight
		, VHFHAMJ.IsEnabled
		, VHFHAMJ.CodeName
       --,VHFHAMJ.NodeAliasPath
		, VHFHAMJ.DocumentPublishedVersionHistoryID
		, VHFHARCJ.Title
		, VHFHARCJ.Weight
		, VHFHARCJ.DocumentID
		, VHFHARCJ.IsEnabled
		, VHFHARCJ.CodeName
       --,VHFHARCJ.NodeAliasPath
		, VHFHARCJ.DocumentPublishedVersionHistoryID
		, VHFHARAJ.Title
		, VHFHARAJ.Weight
		, VHFHARAJ.DocumentID
		, VHFHARAJ.IsEnabled
		, VHFHARAJ.CodeName
       --,VHFHARAJ.NodeAliasPath
		, VHFHARAJ.ScoringStrategyID
		, VHFHARAJ.DocumentPublishedVersionHistoryID
		, VHFHAQ7.QuestionType
		, dbo.udf_StripHTML(left(VHFHAQ7.Title,4000)) AS QuesTitle
		, VHFHAQ7.Weight
		, VHFHAQ7.IsRequired
		, VHFHAQ7.DocumentID
		, VHFHAQ7.IsEnabled
		, left(VHFHAQ7.IsVisible,4000)
		, VHFHAQ7.IsStaging
		, VHFHAQ7.CodeName AS QuestionCodeName
       --,VHFHAQ7.NodeAliasPath
		, VHFHAQ7.DocumentPublishedVersionHistoryID
		, VHFHAA7.Value
		, VHFHAA7.Points
		, VHFHAA7.DocumentID
		, VHFHAA7.IsEnabled
		, VHFHAA7.CodeName
		, VHFHAA7.UOM
       --,VHFHAA7.NodeAliasPath
		, VHFHAA7.DocumentPublishedVersionHistoryID
		, CASE	WHEN CAST(VCTJ.DocumentCreatedWhen AS DATE) = CAST(vctj.DocumentModifiedWhen AS DATE)
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		, VCTJ.DocumentCreatedWhen
		, VCTJ.DocumentModifiedWhen
 FROM
 dbo.View_CMS_Tree_Joined AS VCTJ
 INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
 INNER JOIN HFit_Account hfa WITH(NOLOCK) ON cs.SiteID = hfa.SiteID
 INNER JOIN dbo.View_HFit_HACampaign_Joined c WITH(NOLOCK) ON VCTJ.NodeID = c.NodeParentID
 INNER JOIN View_HFit_HealthAssessment_Joined ha WITH (NOLOCK) ON c.HealthAssessmentID = ha.DocumentID
 INNER JOIN dbo.View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ ON ha.NodeID = VHFHAMJ.NodeParentID
 INNER JOIN dbo.View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
 INNER JOIN dbo.View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
 INNER JOIN dbo.View_HFit_HealthAssesmentQuestions AS VHFHAQ ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
 LEFT OUTER JOIN dbo.View_HFit_HealthAssesmentAnswers AS VHFHAA ON VHFHAQ.NodeID = VHFHAA.NodeParentID

--matrix level 1 questiongroup
--INNER JOIN dbo.View_HFit_HealthAssesmentQuestions AS VHFHAQ2 ON VHFHAQ.NodeID = VHFHAQ2.NodeParentID
--INNER JOIN dbo.View_HFit_HealthAssesmentAnswers AS VHFHAA2 ON VHFHAQ2.NodeID = VHFHAA2.NodeParentID

--Branching Level 1 Question 
	INNER JOIN dbo.View_HFit_HealthAssesmentQuestions AS VHFHAQ3 ON VHFHAA.NodeID = VHFHAQ3.NodeParentID
--LEFT OUTER JOIN dbo.View_HFit_HealthAssesmentAnswers AS VHFHAA3 ON VHFHAQ3.NodeID = VHFHAA3.NodeParentID

--Matrix Level 2 Question Group
	INNER JOIN dbo.View_HFit_HealthAssesmentQuestions AS VHFHAQ7 ON VHFHAQ3.NodeID = VHFHAQ7.NodeParentID
	INNER JOIN dbo.View_HFit_HealthAssesmentAnswers AS VHFHAA7 ON VHFHAQ7.NodeID = VHFHAA7.NodeParentID

UNION ALL
	--****************************************************
	--WDM 6/25/2014 Retrieve the Branching level 1 Question Group
	--THE PROBLEM LIES HERE in this part of query : 1:40 minute
	-- Added two perf indexes to the first query: 25 Sec
	--****************************************************
	SELECT
		cs.SiteGUID
		, HFA.AccountCD
		, VCTJ.NodeID
		, VCTJ.NodeName
		, VCTJ.DocumentID
		, VCTJ.NodeSiteID
       --,VCTJ.NodeAliasPath
		, VCTJ.DocumentPublishedVersionHistoryID
		, VHFHAMJ.Title
		, dbo.udf_StripHTML(left(VHFHAMJ.IntroText,4000)) AS IntroText
		, VHFHAMJ.DocumentID
		, VHFHAMJ.Weight
		, VHFHAMJ.IsEnabled
		, VHFHAMJ.CodeName
       --,VHFHAMJ.NodeAliasPath
		, VHFHAMJ.DocumentPublishedVersionHistoryID
		, VHFHARCJ.Title
		, VHFHARCJ.Weight
		, VHFHARCJ.DocumentID
		, VHFHARCJ.IsEnabled
		, VHFHARCJ.CodeName
       --,VHFHARCJ.NodeAliasPath
		, VHFHARCJ.DocumentPublishedVersionHistoryID
		, VHFHARAJ.Title
		, VHFHARAJ.Weight
		, VHFHARAJ.DocumentID
		, VHFHARAJ.IsEnabled
		, VHFHARAJ.CodeName
       --,VHFHARAJ.NodeAliasPath
		, VHFHARAJ.ScoringStrategyID
		, VHFHARAJ.DocumentPublishedVersionHistoryID
		, VHFHAQ8.QuestionType
		, dbo.udf_StripHTML(left(VHFHAQ8.Title,4000)) AS QuesTitle
		, VHFHAQ8.Weight
		, VHFHAQ8.IsRequired
		, VHFHAQ8.DocumentID
		, VHFHAQ8.IsEnabled
		, left(VHFHAQ8.IsVisible,4000)
		, VHFHAQ8.IsStaging
		, VHFHAQ8.CodeName AS QuestionCodeName
       --,VHFHAQ8.NodeAliasPath
		, VHFHAQ8.DocumentPublishedVersionHistoryID
		, VHFHAA8.Value
		, VHFHAA8.Points
		, VHFHAA8.DocumentID
		, VHFHAA8.IsEnabled
		, VHFHAA8.CodeName
		, VHFHAA8.UOM
       --,VHFHAA8.NodeAliasPath
		, VHFHAA8.DocumentPublishedVersionHistoryID
		, CASE	WHEN CAST(VCTJ.DocumentCreatedWhen AS DATE) = CAST(vctj.DocumentModifiedWhen AS DATE)
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		, VCTJ.DocumentCreatedWhen
		, VCTJ.DocumentModifiedWhen
	FROM
  dbo.View_CMS_Tree_Joined AS VCTJ

 INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
 INNER JOIN HFit_Account hfa WITH(NOLOCK) ON cs.SiteID = hfa.SiteID
 INNER JOIN dbo.View_HFit_HACampaign_Joined c WITH(NOLOCK) ON VCTJ.NodeID = c.NodeParentID
 INNER JOIN View_HFit_HealthAssessment_Joined ha WITH (NOLOCK) ON c.HealthAssessmentID = ha.DocumentID
 INNER JOIN dbo.View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ ON ha.NodeID = VHFHAMJ.NodeParentID
 INNER JOIN dbo.View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
 INNER JOIN dbo.View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
 INNER JOIN dbo.View_HFit_HealthAssesmentQuestions AS VHFHAQ ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
 LEFT OUTER JOIN dbo.View_HFit_HealthAssesmentAnswers AS VHFHAA ON VHFHAQ.NodeID = VHFHAA.NodeParentID

			--matrix level 1 questiongroup
			--INNER JOIN dbo.View_HFit_HealthAssesmentQuestions AS VHFHAQ2 ON VHFHAQ.NodeID = VHFHAQ2.NodeParentID
			--INNER JOIN dbo.View_HFit_HealthAssesmentAnswers AS VHFHAA2 ON VHFHAQ2.NodeID = VHFHAA2.NodeParentID

			--Branching Level 1 Question 
			INNER JOIN dbo.View_HFit_HealthAssesmentQuestions AS VHFHAQ3 ON VHFHAA.NodeID = VHFHAQ3.NodeParentID
			--LEFT OUTER JOIN dbo.View_HFit_HealthAssesmentAnswers AS VHFHAA3 ON VHFHAQ3.NodeID = VHFHAA3.NodeParentID

			--Matrix Level 2 Question Group
			INNER JOIN dbo.View_HFit_HealthAssesmentQuestions AS VHFHAQ7 ON VHFHAQ3.NodeID = VHFHAQ7.NodeParentID
			INNER JOIN dbo.View_HFit_HealthAssesmentAnswers AS VHFHAA7 ON VHFHAQ7.NodeID = VHFHAA7.NodeParentID

			--Matrix branching level 1 question group
			INNER JOIN dbo.View_HFit_HealthAssesmentQuestions AS VHFHAQ8 ON VHFHAA7.NodeID = VHFHAQ8.NodeParentID
			INNER JOIN dbo.View_HFit_HealthAssesmentAnswers AS VHFHAA8 ON VHFHAQ8.NodeID = VHFHAA8.NodeParentID

UNION ALL
	--****************************************************
	--WDM 6/25/2014 Retrieve the Branching level 2 Question Group
	--THE PROBLEM LIES HERE in this part of query : 1:48  minutes
	--With the new indexes: 29 Secs
	--****************************************************
	SELECT
		cs.SiteGUID
		, HFA.AccountCD
		, VCTJ.NodeID
		, VCTJ.NodeName
		, VCTJ.DocumentID
		, VCTJ.NodeSiteID
       --,VCTJ.NodeAliasPath
		, VCTJ.DocumentPublishedVersionHistoryID
		, VHFHAMJ.Title
		, dbo.udf_StripHTML(left(VHFHAMJ.IntroText,4000)) AS IntroText
		, VHFHAMJ.DocumentID
		, VHFHAMJ.Weight
		, VHFHAMJ.IsEnabled
		, VHFHAMJ.CodeName
       --,VHFHAMJ.NodeAliasPath
		, VHFHAMJ.DocumentPublishedVersionHistoryID
		, VHFHARCJ.Title
		, VHFHARCJ.Weight
		, VHFHARCJ.DocumentID
		, VHFHARCJ.IsEnabled
		, VHFHARCJ.CodeName
       --,VHFHARCJ.NodeAliasPath
		, VHFHARCJ.DocumentPublishedVersionHistoryID
		, VHFHARAJ.Title
		, VHFHARAJ.Weight
		, VHFHARAJ.DocumentID
		, VHFHARAJ.IsEnabled
		, VHFHARAJ.CodeName
       --,VHFHARAJ.NodeAliasPath
		, VHFHARAJ.ScoringStrategyID
		, VHFHARAJ.DocumentPublishedVersionHistoryID
		, VHFHAQ4.QuestionType
		, dbo.udf_StripHTML(left(VHFHAQ4.Title,4000)) AS QuesTitle
		, VHFHAQ4.Weight
		, VHFHAQ4.IsRequired
		, VHFHAQ4.DocumentID
		, VHFHAQ4.IsEnabled
		, left(VHFHAQ4.IsVisible,4000)
		, VHFHAQ4.IsStaging
		, VHFHAQ4.CodeName AS QuestionCodeName
       --,VHFHAQ4.NodeAliasPath
		, VHFHAQ4.DocumentPublishedVersionHistoryID
		, VHFHAA4.Value
		, VHFHAA4.Points
		, VHFHAA4.DocumentID
		, VHFHAA4.IsEnabled
		, VHFHAA4.CodeName
		, VHFHAA4.UOM
       --,VHFHAA4.NodeAliasPath
		, VHFHAA4.DocumentPublishedVersionHistoryID
		, CASE	WHEN CAST(VCTJ.DocumentCreatedWhen AS DATE) = CAST(vctj.DocumentModifiedWhen AS DATE)
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		, VCTJ.DocumentCreatedWhen
		, VCTJ.DocumentModifiedWhen
 FROM
  dbo.View_CMS_Tree_Joined AS VCTJ

 INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
 INNER JOIN HFit_Account hfa WITH(NOLOCK) ON cs.SiteID = hfa.SiteID
 INNER JOIN dbo.View_HFit_HACampaign_Joined c WITH(NOLOCK) ON VCTJ.NodeID = c.NodeParentID
 INNER JOIN View_HFit_HealthAssessment_Joined ha WITH (NOLOCK) ON c.HealthAssessmentID = ha.DocumentID
 INNER JOIN dbo.View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ ON ha.NodeID = VHFHAMJ.NodeParentID
 INNER JOIN dbo.View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
 INNER JOIN dbo.View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
 INNER JOIN dbo.View_HFit_HealthAssesmentQuestions AS VHFHAQ ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
 LEFT OUTER JOIN dbo.View_HFit_HealthAssesmentAnswers AS VHFHAA ON VHFHAQ.NodeID = VHFHAA.NodeParentID

			--matrix level 1 questiongroup
			--INNER JOIN dbo.View_HFit_HealthAssesmentQuestions AS VHFHAQ2 ON VHFHAQ.NodeID = VHFHAQ2.NodeParentID
			--INNER JOIN dbo.View_HFit_HealthAssesmentAnswers AS VHFHAA2 ON VHFHAQ2.NodeID = VHFHAA2.NodeParentID

			--Branching Level 1 Question 
			INNER JOIN dbo.View_HFit_HealthAssesmentQuestions AS VHFHAQ3 ON VHFHAA.NodeID = VHFHAQ3.NodeParentID
			LEFT OUTER JOIN dbo.View_HFit_HealthAssesmentAnswers AS VHFHAA3 ON VHFHAQ3.NodeID = VHFHAA3.NodeParentID

			--Matrix Level 2 Question Group
			--INNER JOIN dbo.View_HFit_HealthAssesmentQuestions AS VHFHAQ7 ON VHFHAQ3.NodeID = VHFHAQ7.NodeParentID
			--INNER JOIN dbo.View_HFit_HealthAssesmentAnswers AS VHFHAA7 ON VHFHAQ7.NodeID = VHFHAA7.NodeParentID

			--Matrix branching level 1 question group
			--INNER JOIN dbo.View_HFit_HealthAssesmentQuestions AS VHFHAQ8 ON VHFHAA7.NodeID = VHFHAQ8.NodeParentID
			--INNER JOIN dbo.View_HFit_HealthAssesmentAnswers AS VHFHAA8 ON VHFHAQ8.NodeID = VHFHAA8.NodeParentID

			--Branching level 2 Question Group
			INNER JOIN dbo.View_HFit_HealthAssesmentQuestions AS VHFHAQ4 ON VHFHAA3.NodeID = VHFHAQ4.NodeParentID
			INNER JOIN dbo.View_HFit_HealthAssesmentAnswers AS VHFHAA4 ON VHFHAQ4.NodeID = VHFHAA4.NodeParentID

UNION ALL
--WDM 6/25/2014 Retrieve the Branching level 3 Question Group
	SELECT
		cs.SiteGUID
		, HFA.AccountCD
		, VCTJ.NodeID
		, VCTJ.NodeName
		, VCTJ.DocumentID
		, VCTJ.NodeSiteID
       --,VCTJ.NodeAliasPath
		, VCTJ.DocumentPublishedVersionHistoryID
		, VHFHAMJ.Title
		, dbo.udf_StripHTML(left(VHFHAMJ.IntroText,4000)) AS IntroText
		, VHFHAMJ.DocumentID
		, VHFHAMJ.Weight
		, VHFHAMJ.IsEnabled
		, VHFHAMJ.CodeName
       --,VHFHAMJ.NodeAliasPath
		, VHFHAMJ.DocumentPublishedVersionHistoryID
		, VHFHARCJ.Title
		, VHFHARCJ.Weight
		, VHFHARCJ.DocumentID
		, VHFHARCJ.IsEnabled
		, VHFHARCJ.CodeName
       --,VHFHARCJ.NodeAliasPath
		, VHFHARCJ.DocumentPublishedVersionHistoryID
		, VHFHARAJ.Title
		, VHFHARAJ.Weight
		, VHFHARAJ.DocumentID
		, VHFHARAJ.IsEnabled
		, VHFHARAJ.CodeName
       --,VHFHARAJ.NodeAliasPath
		, VHFHARAJ.ScoringStrategyID
		, VHFHARAJ.DocumentPublishedVersionHistoryID
		, VHFHAQ5.QuestionType
		, dbo.udf_StripHTML(left(VHFHAQ5.Title,4000)) AS QuesTitle
		, VHFHAQ5.Weight
		, VHFHAQ5.IsRequired
		, VHFHAQ5.DocumentID
		, VHFHAQ5.IsEnabled
		, left(VHFHAQ5.IsVisible,4000)
		, VHFHAQ5.IsStaging
		, VHFHAQ5.CodeName AS QuestionCodeName
       --,VHFHAQ5.NodeAliasPath
		, VHFHAQ5.DocumentPublishedVersionHistoryID
		, VHFHAA5.Value
		, VHFHAA5.Points
		, VHFHAA5.DocumentID
		, VHFHAA5.IsEnabled
		, VHFHAA5.CodeName
		, VHFHAA5.UOM
       --,VHFHAA5.NodeAliasPath
		, VHFHAA5.DocumentPublishedVersionHistoryID
		, CASE	WHEN CAST(VCTJ.DocumentCreatedWhen AS DATE) = CAST(vctj.DocumentModifiedWhen AS DATE)
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		, VCTJ.DocumentCreatedWhen
		, VCTJ.DocumentModifiedWhen
 FROM
  dbo.View_CMS_Tree_Joined AS VCTJ

 INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
 INNER JOIN HFit_Account hfa WITH(NOLOCK) ON cs.SiteID = hfa.SiteID
 INNER JOIN dbo.View_HFit_HACampaign_Joined c WITH(NOLOCK) ON VCTJ.NodeID = c.NodeParentID
 INNER JOIN View_HFit_HealthAssessment_Joined ha WITH (NOLOCK) ON c.HealthAssessmentID = ha.DocumentID
 INNER JOIN dbo.View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ ON ha.NodeID = VHFHAMJ.NodeParentID
 INNER JOIN dbo.View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
 INNER JOIN dbo.View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
 INNER JOIN dbo.View_HFit_HealthAssesmentQuestions AS VHFHAQ ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
 LEFT OUTER JOIN dbo.View_HFit_HealthAssesmentAnswers AS VHFHAA ON VHFHAQ.NodeID = VHFHAA.NodeParentID

		--matrix level 1 questiongroup
		--INNER JOIN dbo.View_HFit_HealthAssesmentQuestions AS VHFHAQ2 ON VHFHAQ.NodeID = VHFHAQ2.NodeParentID
		--INNER JOIN dbo.View_HFit_HealthAssesmentAnswers AS VHFHAA2 ON VHFHAQ2.NodeID = VHFHAA2.NodeParentID

		--Branching Level 1 Question 
		INNER JOIN dbo.View_HFit_HealthAssesmentQuestions AS VHFHAQ3 ON VHFHAA.NodeID = VHFHAQ3.NodeParentID
		LEFT OUTER JOIN dbo.View_HFit_HealthAssesmentAnswers AS VHFHAA3 ON VHFHAQ3.NodeID = VHFHAA3.NodeParentID

		--Matrix Level 2 Question Group
		--INNER JOIN dbo.View_HFit_HealthAssesmentQuestions AS VHFHAQ7 ON VHFHAQ3.NodeID = VHFHAQ7.NodeParentID
		--INNER JOIN dbo.View_HFit_HealthAssesmentAnswers AS VHFHAA7 ON VHFHAQ7.NodeID = VHFHAA7.NodeParentID

		--Matrix branching level 1 question group
		--INNER JOIN dbo.View_HFit_HealthAssesmentQuestions AS VHFHAQ8 ON VHFHAA7.NodeID = VHFHAQ8.NodeParentID
		--INNER JOIN dbo.View_HFit_HealthAssesmentAnswers AS VHFHAA8 ON VHFHAQ8.NodeID = VHFHAA8.NodeParentID

		--Branching level 2 Question Group
		INNER JOIN dbo.View_HFit_HealthAssesmentQuestions AS VHFHAQ4 ON VHFHAA3.NodeID = VHFHAQ4.NodeParentID
		INNER JOIN dbo.View_HFit_HealthAssesmentAnswers AS VHFHAA4 ON VHFHAQ4.NodeID = VHFHAA4.NodeParentID

		--Branching level 3 Question Group
		--select count(*) from dbo.View_HFit_HealthAssesmentAnswers AS VHFHAA4
		INNER JOIN dbo.View_HFit_HealthAssesmentQuestions AS VHFHAQ5 ON VHFHAA4.NodeID = VHFHAQ5.NodeParentID
		INNER JOIN dbo.View_HFit_HealthAssesmentAnswers AS VHFHAA5 ON VHFHAQ5.NodeID = VHFHAA5.NodeParentID

UNION ALL
--WDM 6/25/2014 Retrieve the Branching level 4 Question Group
	SELECT
		cs.SiteGUID
		, HFA.AccountCD
		, VCTJ.NodeID
		, VCTJ.NodeName
		, VCTJ.DocumentID
		, VCTJ.NodeSiteID
       --,VCTJ.NodeAliasPath
		, VCTJ.DocumentPublishedVersionHistoryID
		, VHFHAMJ.Title
		, dbo.udf_StripHTML(left(VHFHAMJ.IntroText,4000)) AS IntroText
		, VHFHAMJ.DocumentID
		, VHFHAMJ.Weight
		, VHFHAMJ.IsEnabled
		, VHFHAMJ.CodeName
       --,VHFHAMJ.NodeAliasPath
		, VHFHAMJ.DocumentPublishedVersionHistoryID
		, VHFHARCJ.Title
		, VHFHARCJ.Weight
		, VHFHARCJ.DocumentID
		, VHFHARCJ.IsEnabled
		, VHFHARCJ.CodeName
       --,VHFHARCJ.NodeAliasPath
		, VHFHARCJ.DocumentPublishedVersionHistoryID
		, VHFHARAJ.Title
		, VHFHARAJ.Weight
		, VHFHARAJ.DocumentID
		, VHFHARAJ.IsEnabled
		, VHFHARAJ.CodeName
       --,VHFHARAJ.NodeAliasPath
		, VHFHARAJ.ScoringStrategyID
		, VHFHARAJ.DocumentPublishedVersionHistoryID
		, VHFHAQ6.QuestionType
		, dbo.udf_StripHTML(left(VHFHAQ6.Title,4000)) AS QuesTitle
		, VHFHAQ6.Weight
		, VHFHAQ6.IsRequired
		, VHFHAQ6.DocumentID
		, VHFHAQ6.IsEnabled
		, left(VHFHAQ6.IsVisible,4000)
		, VHFHAQ6.IsStaging
		, VHFHAQ6.CodeName AS QuestionCodeName
       --,VHFHAQ6.NodeAliasPath
		, VHFHAQ6.DocumentPublishedVersionHistoryID
		, VHFHAA6.Value
		, VHFHAA6.Points
		, VHFHAA6.DocumentID
		, VHFHAA6.IsEnabled
		, VHFHAA6.CodeName
		, VHFHAA6.UOM
       --,VHFHAA6.NodeAliasPath
		, VHFHAA6.DocumentPublishedVersionHistoryID
		, CASE	WHEN CAST(VCTJ.DocumentCreatedWhen AS DATE) = CAST(vctj.DocumentModifiedWhen AS DATE)
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		, VCTJ.DocumentCreatedWhen
		, VCTJ.DocumentModifiedWhen
 FROM
  dbo.View_CMS_Tree_Joined AS VCTJ

 INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
 INNER JOIN HFit_Account hfa WITH(NOLOCK) ON cs.SiteID = hfa.SiteID
 INNER JOIN dbo.View_HFit_HACampaign_Joined c WITH(NOLOCK) ON VCTJ.NodeID = c.NodeParentID
 INNER JOIN View_HFit_HealthAssessment_Joined ha WITH (NOLOCK) ON c.HealthAssessmentID = ha.DocumentID
 INNER JOIN dbo.View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ ON ha.NodeID = VHFHAMJ.NodeParentID
 INNER JOIN dbo.View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
 INNER JOIN dbo.View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
 INNER JOIN dbo.View_HFit_HealthAssesmentQuestions AS VHFHAQ ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
 LEFT OUTER JOIN dbo.View_HFit_HealthAssesmentAnswers AS VHFHAA ON VHFHAQ.NodeID = VHFHAA.NodeParentID

		--matrix level 1 questiongroup
		--INNER JOIN dbo.View_HFit_HealthAssesmentQuestions AS VHFHAQ2 ON VHFHAQ.NodeID = VHFHAQ2.NodeParentID
		--INNER JOIN dbo.View_HFit_HealthAssesmentAnswers AS VHFHAA2 ON VHFHAQ2.NodeID = VHFHAA2.NodeParentID

		--Branching Level 1 Question 
		INNER JOIN dbo.View_HFit_HealthAssesmentQuestions AS VHFHAQ3 ON VHFHAA.NodeID = VHFHAQ3.NodeParentID
		LEFT OUTER JOIN dbo.View_HFit_HealthAssesmentAnswers AS VHFHAA3 ON VHFHAQ3.NodeID = VHFHAA3.NodeParentID

		--Matrix Level 2 Question Group
		--INNER JOIN dbo.View_HFit_HealthAssesmentQuestions AS VHFHAQ7 ON VHFHAQ3.NodeID = VHFHAQ7.NodeParentID
		--INNER JOIN dbo.View_HFit_HealthAssesmentAnswers AS VHFHAA7 ON VHFHAQ7.NodeID = VHFHAA7.NodeParentID

		--Matrix branching level 1 question group
		--INNER JOIN dbo.View_HFit_HealthAssesmentQuestions AS VHFHAQ8 ON VHFHAA7.NodeID = VHFHAQ8.NodeParentID
		--INNER JOIN dbo.View_HFit_HealthAssesmentAnswers AS VHFHAA8 ON VHFHAQ8.NodeID = VHFHAA8.NodeParentID

		--Branching level 2 Question Group
		INNER JOIN dbo.View_HFit_HealthAssesmentQuestions AS VHFHAQ4 ON VHFHAA3.NodeID = VHFHAQ4.NodeParentID
		INNER JOIN dbo.View_HFit_HealthAssesmentAnswers AS VHFHAA4 ON VHFHAQ4.NodeID = VHFHAA4.NodeParentID

		--Branching level 3 Question Group
		--select count(*) from dbo.View_HFit_HealthAssesmentAnswers AS VHFHAA4
		INNER JOIN dbo.View_HFit_HealthAssesmentQuestions AS VHFHAQ5 ON VHFHAA4.NodeID = VHFHAQ5.NodeParentID
		INNER JOIN dbo.View_HFit_HealthAssesmentAnswers AS VHFHAA5 ON VHFHAQ5.NodeID = VHFHAA5.NodeParentID

		--Branching level 4 Question Group
		INNER JOIN dbo.View_HFit_HealthAssesmentQuestions AS VHFHAQ6 ON VHFHAA5.NodeID = VHFHAQ6.NodeParentID
		INNER JOIN dbo.View_HFit_HealthAssesmentAnswers AS VHFHAA6 ON VHFHAQ6.NodeID = VHFHAA6.NodeParentID

UNION ALL
	--WDM 6/25/2014 Retrieve the Branching level 5 Question Group
	SELECT
		cs.SiteGUID
		, HFA.AccountCD
		, VCTJ.NodeID
		, VCTJ.NodeName
		, VCTJ.DocumentID
		, VCTJ.NodeSiteID
       --,VCTJ.NodeAliasPath
		, VCTJ.DocumentPublishedVersionHistoryID
		, VHFHAMJ.Title
		, dbo.udf_StripHTML(left(VHFHAMJ.IntroText,4000)) AS IntroText
		, VHFHAMJ.DocumentID
		, VHFHAMJ.Weight
		, VHFHAMJ.IsEnabled
		, VHFHAMJ.CodeName
       --,VHFHAMJ.NodeAliasPath
		, VHFHAMJ.DocumentPublishedVersionHistoryID
		, VHFHARCJ.Title
		, VHFHARCJ.Weight
		, VHFHARCJ.DocumentID
		, VHFHARCJ.IsEnabled
		, VHFHARCJ.CodeName
       --,VHFHARCJ.NodeAliasPath
		, VHFHARCJ.DocumentPublishedVersionHistoryID
		, VHFHARAJ.Title
		, VHFHARAJ.Weight
		, VHFHARAJ.DocumentID
		, VHFHARAJ.IsEnabled
		, VHFHARAJ.CodeName
       --,VHFHARAJ.NodeAliasPath
		, VHFHARAJ.ScoringStrategyID
		, VHFHARAJ.DocumentPublishedVersionHistoryID
		, VHFHAQ9.QuestionType
		, dbo.udf_StripHTML(left(VHFHAQ9.Title,4000)) AS QuesTitle
		, VHFHAQ9.Weight
		, VHFHAQ9.IsRequired
		, VHFHAQ9.DocumentID
		, VHFHAQ9.IsEnabled
		, left(VHFHAQ9.IsVisible,4000)
		, VHFHAQ9.IsStaging
		, VHFHAQ9.CodeName AS QuestionCodeName
       --,VHFHAQ9.NodeAliasPath
		, VHFHAQ9.DocumentPublishedVersionHistoryID
		, VHFHAA9.Value
		, VHFHAA9.Points
		, VHFHAA9.DocumentID
		, VHFHAA9.IsEnabled
		, VHFHAA9.CodeName
		, VHFHAA9.UOM
       --,VHFHAA9.NodeAliasPath
		, VHFHAA9.DocumentPublishedVersionHistoryID
		, CASE	WHEN CAST(VCTJ.DocumentCreatedWhen AS DATE) = CAST(vctj.DocumentModifiedWhen AS DATE)
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		, VCTJ.DocumentCreatedWhen
		, VCTJ.DocumentModifiedWhen
 FROM
  dbo.View_CMS_Tree_Joined AS VCTJ

 INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
 INNER JOIN HFit_Account hfa WITH(NOLOCK) ON cs.SiteID = hfa.SiteID
 INNER JOIN dbo.View_HFit_HACampaign_Joined c WITH(NOLOCK) ON VCTJ.NodeID = c.NodeParentID
 INNER JOIN View_HFit_HealthAssessment_Joined ha WITH (NOLOCK) ON c.HealthAssessmentID = ha.DocumentID
 INNER JOIN dbo.View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ ON ha.NodeID = VHFHAMJ.NodeParentID
 INNER JOIN dbo.View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
 INNER JOIN dbo.View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
 INNER JOIN dbo.View_HFit_HealthAssesmentQuestions AS VHFHAQ ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
 LEFT OUTER JOIN dbo.View_HFit_HealthAssesmentAnswers AS VHFHAA ON VHFHAQ.NodeID = VHFHAA.NodeParentID

		--matrix level 1 questiongroup
		--INNER JOIN dbo.View_HFit_HealthAssesmentQuestions AS VHFHAQ2 ON VHFHAQ.NodeID = VHFHAQ2.NodeParentID
		--INNER JOIN dbo.View_HFit_HealthAssesmentAnswers AS VHFHAA2 ON VHFHAQ2.NodeID = VHFHAA2.NodeParentID

		--Branching Level 1 Question 
		INNER JOIN dbo.View_HFit_HealthAssesmentQuestions AS VHFHAQ3 ON VHFHAA.NodeID = VHFHAQ3.NodeParentID
		LEFT OUTER JOIN dbo.View_HFit_HealthAssesmentAnswers AS VHFHAA3 ON VHFHAQ3.NodeID = VHFHAA3.NodeParentID

		--Matrix Level 2 Question Group
		--INNER JOIN dbo.View_HFit_HealthAssesmentQuestions AS VHFHAQ7 ON VHFHAQ3.NodeID = VHFHAQ7.NodeParentID
		--INNER JOIN dbo.View_HFit_HealthAssesmentAnswers AS VHFHAA7 ON VHFHAQ7.NodeID = VHFHAA7.NodeParentID

		--Matrix branching level 1 question group
		--INNER JOIN dbo.View_HFit_HealthAssesmentQuestions AS VHFHAQ8 ON VHFHAA7.NodeID = VHFHAQ8.NodeParentID
		--INNER JOIN dbo.View_HFit_HealthAssesmentAnswers AS VHFHAA8 ON VHFHAQ8.NodeID = VHFHAA8.NodeParentID

		--Branching level 2 Question Group
		INNER JOIN dbo.View_HFit_HealthAssesmentQuestions AS VHFHAQ4 ON VHFHAA3.NodeID = VHFHAQ4.NodeParentID
		INNER JOIN dbo.View_HFit_HealthAssesmentAnswers AS VHFHAA4 ON VHFHAQ4.NodeID = VHFHAA4.NodeParentID

		--Branching level 3 Question Group
		--select count(*) from dbo.View_HFit_HealthAssesmentAnswers AS VHFHAA4
		INNER JOIN dbo.View_HFit_HealthAssesmentQuestions AS VHFHAQ5 ON VHFHAA4.NodeID = VHFHAQ5.NodeParentID
		INNER JOIN dbo.View_HFit_HealthAssesmentAnswers AS VHFHAA5 ON VHFHAQ5.NodeID = VHFHAA5.NodeParentID

		--Branching level 4 Question Group
		INNER JOIN dbo.View_HFit_HealthAssesmentQuestions AS VHFHAQ6 ON VHFHAA5.NodeID = VHFHAQ6.NodeParentID
		INNER JOIN dbo.View_HFit_HealthAssesmentAnswers AS VHFHAA6 ON VHFHAQ6.NodeID = VHFHAA6.NodeParentID

		--Branching level 5 Question Group
		INNER JOIN dbo.View_HFit_HealthAssesmentQuestions AS VHFHAQ9 ON VHFHAA6.NodeID = VHFHAQ9.NodeParentID
		INNER JOIN dbo.View_HFit_HealthAssesmentAnswers AS VHFHAA9 ON VHFHAQ9.NodeID = VHFHAA9.NodeParentID

GO



-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016