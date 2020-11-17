
drop table #Temp_View_HFit_HealthAssessment_Joined
go
select DocumentID, NodeID
into #Temp_View_HFit_HealthAssessment_Joined 
from View_HFit_HealthAssessment_Joined 
go

create clustered index PI_Temp_View_HFit_HealthAssessment_Joined on #Temp_View_HFit_HealthAssessment_Joined 
(
DocumentID, NodeID
)
GO 

drop table #Temp_View_HFit_HACampaign_Joined
go
select NodeParentID, HealthAssessmentID
into #Temp_View_HFit_HACampaign_Joined
from 
View_HFit_HACampaign_Joined
GO

CREATE CLUSTERED INDEX [PI_Temp_View_HFit_HACampaign_Joined] ON #Temp_View_HFit_HACampaign_Joined 
(
[NodeParentID] ASC,
HealthAssessmentID )
GO

GO

drop table #Temp_View_CMS_Tree_Joined
go
	SELECT 
		VCTJ.NodeID
		, VCTJ.NodeName
		, VCTJ.DocumentID
		, VCTJ.NodeSiteID 
        , VCTJ.DocumentPublishedVersionHistoryID
		, CASE	WHEN CAST(VCTJ.DocumentCreatedWhen AS DATE) = CAST(vctj.DocumentModifiedWhen AS DATE)
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		, VCTJ.DocumentCreatedWhen
		, VCTJ.DocumentModifiedWhen
	INTO #Temp_View_CMS_Tree_Joined
	FROM
	View_CMS_Tree_Joined AS VCTJ

	GO 
	CREATE CLUSTERED INDEX PI_Temp_View_CMS_Tree_Joined
	ON [dbo].#Temp_View_CMS_Tree_Joined (
		[NodeID], 
		NodeSiteID,
		[NodeName],
		[DocumentID], 
		[DocumentPublishedVersionHistoryID],
		[DocumentCreatedWhen],
		[DocumentModifiedWhen]
	)
	GO 

	drop table #Temp_View_HFit_HealthAssesmentModule_Joined
	go
	SELECT 
		VHFHAMJ.Title AS ModTitle
		, VHFHAMJ.IntroText 
		, VHFHAMJ.DocumentID
		, VHFHAMJ.Weight
		, VHFHAMJ.IsEnabled
		, VHFHAMJ.CodeName AS ModCodeName
        , VHFHAMJ.DocumentPublishedVersionHistoryID AS ModDocPubVerID
		, VHFHAMJ.NodeParentID
		, VHFHAMJ.DocumentNodeID
		, VHFHAMJ.Title
		, VHFHAMJ.CodeName
		, VHFHAMJ.DocumentPublishedVersionHistoryID
	INTO #Temp_View_HFit_HealthAssesmentModule_Joined
	FROM
	View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ

	GO
	Create clustered index PI_Temp_View_HFit_HealthAssesmentModule_Joined on #Temp_View_HFit_HealthAssesmentModule_Joined
	(
		NodeParentID, DocumentNodeID	,
		DocumentID, 
		Weight, 
		IsEnabled, 
		Title, 
		CodeName, 
		DocumentPublishedVersionHistoryID	
	)
	go
 
 drop table #Temp_View_HFit_HealthAssesmentRiskCategory_Joined
 go
	SELECT VHFHARCJ.Title
		, VHFHARCJ.Weight
		, VHFHARCJ.DocumentID
		, VHFHARCJ.IsEnabled
		, VHFHARCJ.CodeName
        , VHFHARCJ.DocumentPublishedVersionHistoryID
		, VHFHARCJ.NodeParentID
		, VHFHARCJ.DocumentNodeID
	INTO #Temp_View_HFit_HealthAssesmentRiskCategory_Joined
	FROM
	View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ
	GO

	create clustered index PI_Temp_View_HFit_HealthAssesmentRiskCategory_Joined on #Temp_View_HFit_HealthAssesmentRiskCategory_Joined
	(
		NodeParentID, DocumentID, DocumentNodeID
	)


	drop table #Temp_View_HFit_HealthAssesmentRiskArea_Joined
	go
	SELECT 
		VHFHARAJ.Title
		, VHFHARAJ.Weight 
		, VHFHARAJ.DocumentID
		, VHFHARAJ.IsEnabled
		, VHFHARAJ.CodeName
        , VHFHARAJ.ScoringStrategyID
		, VHFHARAJ.DocumentPublishedVersionHistoryID
		, VHFHARAJ.NodeParentID
		, VHFHARAJ.DocumentNodeID
	INTO #Temp_View_HFit_HealthAssesmentRiskArea_Joined
	FROM
	View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ
 
 GO
 Create clustered index PI_Temp_View_HFit_HealthAssesmentRiskArea_Joined on #Temp_View_HFit_HealthAssesmentRiskArea_Joined
 (
	DocumentNodeID, NodeParentID, DocumentID
 )
 
 drop table #Temp_View_HFit_HealthAssesmentQuestions
 go
 SELECT 
		VHFHAQ.QuestionType
		, VHFHAQ.Title AS Title
		, VHFHAQ.[Weight]
		, VHFHAQ.IsRequired
		, VHFHAQ.DocumentID
		, VHFHAQ.IsEnabled
		, VHFHAQ.IsVisible
		, VHFHAQ.IsStaging
		, VHFHAQ.CodeName
		, VHFHAQ.DocumentPublishedVersionHistoryID
		, VHFHAQ.NodeParentID
		, VHFHAQ.NodeID
	INTO #Temp_View_HFit_HealthAssesmentQuestions
	FROM
	View_HFit_HealthAssesmentQuestions AS VHFHAQ

	GO
	Create clustered index  PI_Temp_View_HFit_HealthAssesmentQuestions on #Temp_View_HFit_HealthAssesmentQuestions
	(
		NodeID, NodeParentID
	)

	go
	drop table #Temp_View_HFit_HealthAssesmentAnswers
	go
	SELECT 
		VHFHAA.Value
		, VHFHAA.Points
		, VHFHAA.DocumentID
		, VHFHAA.IsEnabled 
		, VHFHAA.CodeName 
		, VHFHAA.UOM 
		, VHFHAA.DocumentPublishedVersionHistoryID 
		, VHFHAA.NodeParentID
		, VHFHAA.Nodeid
	INTO #Temp_View_HFit_HealthAssesmentAnswers
	FROM
	View_HFit_HealthAssesmentAnswers AS VHFHAA 
	GO 

	create clustered index PI_Temp_View_HFit_HealthAssesmentAnswers on #Temp_View_HFit_HealthAssesmentAnswers
	(
		NodeParentID, DocumentID, DocumentPublishedVersionHistoryID,
		Value, Points, IsEnabled, CodeName, UOM
	)

go 

drop index [View_CMS_Tree_Joined_Linked].PI04_View_CMS_Tree_Joined_Linked
GO


CREATE NONCLUSTERED INDEX PI04_View_CMS_Tree_Joined_Linked
ON [dbo].[View_CMS_Tree_Joined_Linked] ([ClassName])
INCLUDE ([NodeParentID],[DocumentID],[DocumentForeignKeyValue],[DocumentPublishedVersionHistoryID],[DocumentNodeID])
GO

drop index #Temp_View_HFit_HealthAssesmentModule_Joined.PI_Temp_View_HFit_HealthAssesmentModule_Joined
GO

create clustered index PI_Temp_View_HFit_HealthAssesmentModule_Joined 
on #Temp_View_HFit_HealthAssesmentModule_Joined
(
	DocumentID, 
	Weight, 
	IsEnabled, 
	Title, 
	CodeName, 
	DocumentPublishedVersionHistoryID	
)

IF NOT EXISTS
	(
		SELECT name
		FROM sys.indexes
		WHERE name = N'PI01_HFit_Account'
	)
BEGIN
		CREATE index PI01_HFit_Account on HFit_Account
		(
			SiteID
		)
END

IF NOT EXISTS
	(
		SELECT name
		FROM sys.indexes
		where name = N'CI01_View_CMS_Tree_Joined_Linked'
	)
BEGIN
	CREATE NONCLUSTERED INDEX [CI01_View_CMS_Tree_Joined_Linked]
	ON [dbo].[View_CMS_Tree_Joined_Linked] 
	([ClassName]) INCLUDE ([NodeID],[DocumentID],[DocumentForeignKeyValue])
END
GO

/****************************************************************************************/
--Begin the view using the TEMP tables
/****************************************************************************************/
	SELECT 
		cs.SiteGUID
		, HFA.AccountCD
		, VCTJ.NodeID AS HANodeID
		, VCTJ.NodeName AS HANodeName
		, VCTJ.DocumentID AS HADocumentID
		, VCTJ.NodeSiteID AS HANodeSiteID
        , VCTJ.DocumentPublishedVersionHistoryID AS HADocPubVerID
		, VHFHAMJ.Title AS ModTitle
		, VHFHAMJ.IntroText
		, VHFHAMJ.DocumentID AS ModDocID
		, VHFHAMJ.Weight AS ModWeight
		, VHFHAMJ.IsEnabled AS ModIsEnabled
		, VHFHAMJ.CodeName AS ModCodeName
        , VHFHAMJ.DocumentPublishedVersionHistoryID AS ModDocPubVerID
		, VHFHARCJ.Title AS RCTitle
		, VHFHARCJ.Weight AS RCWeight
		, VHFHARCJ.DocumentID AS RCDocumentID
		, VHFHARCJ.IsEnabled AS RCIsEnabled
		, VHFHARCJ.CodeName AS RCCodeName
        , VHFHARCJ.DocumentPublishedVersionHistoryID AS RCDocPubVerID
		, VHFHARAJ.Title AS RATytle
		, VHFHARAJ.Weight AS RAWeight
		, VHFHARAJ.DocumentID AS RADocumentID
		, VHFHARAJ.IsEnabled AS RAIsEnabled
		, VHFHARAJ.CodeName AS RACodeName
        , VHFHARAJ.ScoringStrategyID AS RAScoringStrategyID
		, VHFHARAJ.DocumentPublishedVersionHistoryID AS RADocPubVerID
		, VHFHAQ.QuestionType
		, VHFHAQ.Title AS QuesTitle
		, VHFHAQ.Weight AS QuesWeight
		, VHFHAQ.IsRequired AS QuesIsRequired
		, VHFHAQ.DocumentID AS QuesDocumentID
		, VHFHAQ.IsEnabled AS QuesIsEnabled
		, VHFHAQ.IsVisible AS QuesIsVisible
		, VHFHAQ.IsStaging AS QuesIsSTaging
		, VHFHAQ.CodeName AS QuestionCodeName
		, VHFHAQ.DocumentPublishedVersionHistoryID AS QuesDocPubVerID
		, VHFHAA.Value AS AnsValue
		, VHFHAA.Points AS AnsPoints
		, VHFHAA.DocumentID AS AnsDocumentID
		, VHFHAA.IsEnabled AS AnsIsEnabled
		, VHFHAA.CodeName AS AnsCodeName
		, VHFHAA.UOM AS AnsUOM
		, VHFHAA.DocumentPublishedVersionHistoryID AS AnsDocPUbVerID
		, CASE	WHEN CAST(VCTJ.DocumentCreatedWhen AS DATE) = CAST(vctj.DocumentModifiedWhen AS DATE)
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		, VCTJ.DocumentCreatedWhen
		, VCTJ.DocumentModifiedWhen
	FROM
	#Temp_View_CMS_Tree_Joined AS VCTJ
	INNER JOIN CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
	INNER JOIN HFit_Account hfa WITH(NOLOCK) ON cs.SiteID = hfa.SiteID
 
	INNER JOIN #Temp_View_HFit_HACampaign_Joined c ON VCTJ.NodeID = c.NodeParentID
	
	INNER JOIN #Temp_View_HFit_HealthAssessment_Joined ha ON c.HealthAssessmentID = ha.DocumentID
	INNER JOIN #Temp_View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ ON ha.NodeID = VHFHAMJ.NodeParentID
	INNER JOIN #Temp_View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
	INNER JOIN #Temp_View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
	INNER JOIN #Temp_View_HFit_HealthAssesmentQuestions AS VHFHAQ ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
	LEFT OUTER JOIN #Temp_View_HFit_HealthAssesmentAnswers AS VHFHAA ON VHFHAQ.NodeID = VHFHAA.NodeParentID
	
	 
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
		, VHFHAMJ.IntroText
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
		, VHFHAQ2.Title AS QuesTitle
		, VHFHAQ2.Weight
		, VHFHAQ2.IsRequired
		, VHFHAQ2.DocumentID
		, VHFHAQ2.IsEnabled
		, VHFHAQ2.IsVisible
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
  #Temp_View_CMS_Tree_Joined AS VCTJ

 INNER JOIN CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
 INNER JOIN HFit_Account hfa WITH(NOLOCK) ON cs.SiteID = hfa.SiteID
 INNER JOIN #Temp_View_HFit_HACampaign_Joined c WITH(NOLOCK) ON VCTJ.NodeID = c.NodeParentID
 INNER JOIN #Temp_View_HFit_HealthAssessment_Joined ha WITH (NOLOCK) ON c.HealthAssessmentID = ha.DocumentID
 INNER JOIN #Temp_View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ ON ha.NodeID = VHFHAMJ.NodeParentID
 INNER JOIN #Temp_View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
 INNER JOIN #Temp_View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
 INNER JOIN #Temp_View_HFit_HealthAssesmentQuestions AS VHFHAQ ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
 LEFT OUTER JOIN #Temp_View_HFit_HealthAssesmentAnswers AS VHFHAA ON VHFHAQ.NodeID = VHFHAA.NodeParentID
--matrix level 1 questiongroup
	INNER JOIN #Temp_View_HFit_HealthAssesmentQuestions AS VHFHAQ2 ON VHFHAQ.NodeID = VHFHAQ2.NodeParentID
	INNER JOIN #Temp_View_HFit_HealthAssesmentAnswers AS VHFHAA2 ON VHFHAQ2.NodeID = VHFHAA2.NodeParentID

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
		, VHFHAMJ.IntroText
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
		, VHFHAQ3.Title AS QuesTitle
		, VHFHAQ3.Weight
		, VHFHAQ3.IsRequired
		, VHFHAQ3.DocumentID
		, VHFHAQ3.IsEnabled
		, VHFHAQ3.IsVisible
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
  #Temp_View_CMS_Tree_Joined AS VCTJ

 INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
 INNER JOIN HFit_Account hfa WITH(NOLOCK) ON cs.SiteID = hfa.SiteID
 INNER JOIN #Temp_View_HFit_HACampaign_Joined c WITH(NOLOCK) ON VCTJ.NodeID = c.NodeParentID
 INNER JOIN #Temp_View_HFit_HealthAssessment_Joined ha WITH (NOLOCK) ON c.HealthAssessmentID = ha.DocumentID
 INNER JOIN #Temp_View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ ON ha.NodeID = VHFHAMJ.NodeParentID
 INNER JOIN #Temp_View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
 INNER JOIN #Temp_View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
 INNER JOIN #Temp_View_HFit_HealthAssesmentQuestions AS VHFHAQ ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
 LEFT OUTER JOIN #Temp_View_HFit_HealthAssesmentAnswers AS VHFHAA ON VHFHAQ.NodeID = VHFHAA.NodeParentID
 
--matrix level 1 questiongroup
--INNER JOIN #Temp_View_HFit_HealthAssesmentQuestions AS VHFHAQ2 ON VHFHAQ.NodeID = VHFHAQ2.NodeParentID
--INNER JOIN #Temp_View_HFit_HealthAssesmentAnswers AS VHFHAA2 ON VHFHAQ2.NodeID = VHFHAA2.NodeParentID

--Branching Level 1 Question 
	INNER JOIN #Temp_View_HFit_HealthAssesmentQuestions AS VHFHAQ3 ON VHFHAA.NodeID = VHFHAQ3.NodeParentID
	LEFT OUTER JOIN #Temp_View_HFit_HealthAssesmentAnswers AS VHFHAA3 ON VHFHAQ3.NodeID = VHFHAA3.NodeParentID

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
		, VHFHAMJ.IntroText
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
		, VHFHAQ7.Title QuesTitle
		, VHFHAQ7.Weight
		, VHFHAQ7.IsRequired
		, VHFHAQ7.DocumentID
		, VHFHAQ7.IsEnabled
		, VHFHAQ7.IsVisible
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
 #Temp_View_CMS_Tree_Joined AS VCTJ
 INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
 INNER JOIN HFit_Account hfa WITH(NOLOCK) ON cs.SiteID = hfa.SiteID
 INNER JOIN #Temp_View_HFit_HACampaign_Joined c WITH(NOLOCK) ON VCTJ.NodeID = c.NodeParentID
 INNER JOIN #Temp_View_HFit_HealthAssessment_Joined ha WITH (NOLOCK) ON c.HealthAssessmentID = ha.DocumentID
 INNER JOIN #Temp_View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ ON ha.NodeID = VHFHAMJ.NodeParentID
 INNER JOIN #Temp_View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
 INNER JOIN #Temp_View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
 INNER JOIN #Temp_View_HFit_HealthAssesmentQuestions AS VHFHAQ ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
 LEFT OUTER JOIN #Temp_View_HFit_HealthAssesmentAnswers AS VHFHAA ON VHFHAQ.NodeID = VHFHAA.NodeParentID

--matrix level 1 questiongroup
--INNER JOIN #Temp_View_HFit_HealthAssesmentQuestions AS VHFHAQ2 ON VHFHAQ.NodeID = VHFHAQ2.NodeParentID
--INNER JOIN #Temp_View_HFit_HealthAssesmentAnswers AS VHFHAA2 ON VHFHAQ2.NodeID = VHFHAA2.NodeParentID

--Branching Level 1 Question 
	INNER JOIN #Temp_View_HFit_HealthAssesmentQuestions AS VHFHAQ3 ON VHFHAA.NodeID = VHFHAQ3.NodeParentID
--LEFT OUTER JOIN #Temp_View_HFit_HealthAssesmentAnswers AS VHFHAA3 ON VHFHAQ3.NodeID = VHFHAA3.NodeParentID

--Matrix Level 2 Question Group
	INNER JOIN #Temp_View_HFit_HealthAssesmentQuestions AS VHFHAQ7 ON VHFHAQ3.NodeID = VHFHAQ7.NodeParentID
	INNER JOIN #Temp_View_HFit_HealthAssesmentAnswers AS VHFHAA7 ON VHFHAQ7.NodeID = VHFHAA7.NodeParentID


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
		, VHFHAMJ.IntroText
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
		, VHFHAQ8.Title AS QuesTitle
		, VHFHAQ8.Weight
		, VHFHAQ8.IsRequired
		, VHFHAQ8.DocumentID
		, VHFHAQ8.IsEnabled
		, VHFHAQ8.IsVisible 
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
  #Temp_View_CMS_Tree_Joined AS VCTJ

 INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
 INNER JOIN HFit_Account hfa WITH(NOLOCK) ON cs.SiteID = hfa.SiteID
 INNER JOIN #Temp_View_HFit_HACampaign_Joined c WITH(NOLOCK) ON VCTJ.NodeID = c.NodeParentID
 INNER JOIN #Temp_View_HFit_HealthAssessment_Joined ha WITH (NOLOCK) ON c.HealthAssessmentID = ha.DocumentID
 INNER JOIN #Temp_View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ ON ha.NodeID = VHFHAMJ.NodeParentID
 INNER JOIN #Temp_View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
 INNER JOIN #Temp_View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
 INNER JOIN #Temp_View_HFit_HealthAssesmentQuestions AS VHFHAQ ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
 LEFT OUTER JOIN #Temp_View_HFit_HealthAssesmentAnswers AS VHFHAA ON VHFHAQ.NodeID = VHFHAA.NodeParentID

			--matrix level 1 questiongroup
			--INNER JOIN #Temp_View_HFit_HealthAssesmentQuestions AS VHFHAQ2 ON VHFHAQ.NodeID = VHFHAQ2.NodeParentID
			--INNER JOIN #Temp_View_HFit_HealthAssesmentAnswers AS VHFHAA2 ON VHFHAQ2.NodeID = VHFHAA2.NodeParentID

			--Branching Level 1 Question 
			INNER JOIN #Temp_View_HFit_HealthAssesmentQuestions AS VHFHAQ3 ON VHFHAA.NodeID = VHFHAQ3.NodeParentID
			--LEFT OUTER JOIN #Temp_View_HFit_HealthAssesmentAnswers AS VHFHAA3 ON VHFHAQ3.NodeID = VHFHAA3.NodeParentID

			--Matrix Level 2 Question Group
			INNER JOIN #Temp_View_HFit_HealthAssesmentQuestions AS VHFHAQ7 ON VHFHAQ3.NodeID = VHFHAQ7.NodeParentID
			INNER JOIN #Temp_View_HFit_HealthAssesmentAnswers AS VHFHAA7 ON VHFHAQ7.NodeID = VHFHAA7.NodeParentID

			--Matrix branching level 1 question group
			INNER JOIN #Temp_View_HFit_HealthAssesmentQuestions AS VHFHAQ8 ON VHFHAA7.NodeID = VHFHAQ8.NodeParentID
			INNER JOIN #Temp_View_HFit_HealthAssesmentAnswers AS VHFHAA8 ON VHFHAQ8.NodeID = VHFHAA8.NodeParentID

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
		, VHFHAMJ.IntroText
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
		, VHFHAQ4.Title AS QuesTitle
		, VHFHAQ4.Weight
		, VHFHAQ4.IsRequired
		, VHFHAQ4.DocumentID
		, VHFHAQ4.IsEnabled
		, VHFHAQ4.IsVisible 
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
  #Temp_View_CMS_Tree_Joined AS VCTJ

 INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
 INNER JOIN HFit_Account hfa WITH(NOLOCK) ON cs.SiteID = hfa.SiteID
 INNER JOIN #Temp_View_HFit_HACampaign_Joined c WITH(NOLOCK) ON VCTJ.NodeID = c.NodeParentID
 INNER JOIN #Temp_View_HFit_HealthAssessment_Joined ha WITH (NOLOCK) ON c.HealthAssessmentID = ha.DocumentID
 INNER JOIN #Temp_View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ ON ha.NodeID = VHFHAMJ.NodeParentID
 INNER JOIN #Temp_View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
 INNER JOIN #Temp_View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
 INNER JOIN #Temp_View_HFit_HealthAssesmentQuestions AS VHFHAQ ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
 LEFT OUTER JOIN #Temp_View_HFit_HealthAssesmentAnswers AS VHFHAA ON VHFHAQ.NodeID = VHFHAA.NodeParentID

			--matrix level 1 questiongroup
			--INNER JOIN #Temp_View_HFit_HealthAssesmentQuestions AS VHFHAQ2 ON VHFHAQ.NodeID = VHFHAQ2.NodeParentID
			--INNER JOIN #Temp_View_HFit_HealthAssesmentAnswers AS VHFHAA2 ON VHFHAQ2.NodeID = VHFHAA2.NodeParentID

			--Branching Level 1 Question 
			INNER JOIN #Temp_View_HFit_HealthAssesmentQuestions AS VHFHAQ3 ON VHFHAA.NodeID = VHFHAQ3.NodeParentID
			LEFT OUTER JOIN #Temp_View_HFit_HealthAssesmentAnswers AS VHFHAA3 ON VHFHAQ3.NodeID = VHFHAA3.NodeParentID

			--Matrix Level 2 Question Group
			--INNER JOIN #Temp_View_HFit_HealthAssesmentQuestions AS VHFHAQ7 ON VHFHAQ3.NodeID = VHFHAQ7.NodeParentID
			--INNER JOIN #Temp_View_HFit_HealthAssesmentAnswers AS VHFHAA7 ON VHFHAQ7.NodeID = VHFHAA7.NodeParentID

			--Matrix branching level 1 question group
			--INNER JOIN #Temp_View_HFit_HealthAssesmentQuestions AS VHFHAQ8 ON VHFHAA7.NodeID = VHFHAQ8.NodeParentID
			--INNER JOIN #Temp_View_HFit_HealthAssesmentAnswers AS VHFHAA8 ON VHFHAQ8.NodeID = VHFHAA8.NodeParentID

			--Branching level 2 Question Group
			INNER JOIN #Temp_View_HFit_HealthAssesmentQuestions AS VHFHAQ4 ON VHFHAA3.NodeID = VHFHAQ4.NodeParentID
			INNER JOIN #Temp_View_HFit_HealthAssesmentAnswers AS VHFHAA4 ON VHFHAQ4.NodeID = VHFHAA4.NodeParentID

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
		, VHFHAMJ.IntroText
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
		, VHFHAQ5.Title AS QuesTitle
		, VHFHAQ5.Weight
		, VHFHAQ5.IsRequired
		, VHFHAQ5.DocumentID
		, VHFHAQ5.IsEnabled
		, VHFHAQ5.IsVisible 
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
  #Temp_View_CMS_Tree_Joined AS VCTJ

 INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
 INNER JOIN HFit_Account hfa WITH(NOLOCK) ON cs.SiteID = hfa.SiteID
 INNER JOIN #Temp_View_HFit_HACampaign_Joined c WITH(NOLOCK) ON VCTJ.NodeID = c.NodeParentID
 INNER JOIN #Temp_View_HFit_HealthAssessment_Joined ha WITH (NOLOCK) ON c.HealthAssessmentID = ha.DocumentID
 INNER JOIN #Temp_View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ ON ha.NodeID = VHFHAMJ.NodeParentID
 INNER JOIN #Temp_View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
 INNER JOIN #Temp_View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
 INNER JOIN #Temp_View_HFit_HealthAssesmentQuestions AS VHFHAQ ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
 LEFT OUTER JOIN #Temp_View_HFit_HealthAssesmentAnswers AS VHFHAA ON VHFHAQ.NodeID = VHFHAA.NodeParentID

		--matrix level 1 questiongroup
		--INNER JOIN #Temp_View_HFit_HealthAssesmentQuestions AS VHFHAQ2 ON VHFHAQ.NodeID = VHFHAQ2.NodeParentID
		--INNER JOIN #Temp_View_HFit_HealthAssesmentAnswers AS VHFHAA2 ON VHFHAQ2.NodeID = VHFHAA2.NodeParentID

		--Branching Level 1 Question 
		INNER JOIN #Temp_View_HFit_HealthAssesmentQuestions AS VHFHAQ3 ON VHFHAA.NodeID = VHFHAQ3.NodeParentID
		LEFT OUTER JOIN #Temp_View_HFit_HealthAssesmentAnswers AS VHFHAA3 ON VHFHAQ3.NodeID = VHFHAA3.NodeParentID

		--Matrix Level 2 Question Group
		--INNER JOIN #Temp_View_HFit_HealthAssesmentQuestions AS VHFHAQ7 ON VHFHAQ3.NodeID = VHFHAQ7.NodeParentID
		--INNER JOIN #Temp_View_HFit_HealthAssesmentAnswers AS VHFHAA7 ON VHFHAQ7.NodeID = VHFHAA7.NodeParentID

		--Matrix branching level 1 question group
		--INNER JOIN #Temp_View_HFit_HealthAssesmentQuestions AS VHFHAQ8 ON VHFHAA7.NodeID = VHFHAQ8.NodeParentID
		--INNER JOIN #Temp_View_HFit_HealthAssesmentAnswers AS VHFHAA8 ON VHFHAQ8.NodeID = VHFHAA8.NodeParentID

		--Branching level 2 Question Group
		INNER JOIN #Temp_View_HFit_HealthAssesmentQuestions AS VHFHAQ4 ON VHFHAA3.NodeID = VHFHAQ4.NodeParentID
		INNER JOIN #Temp_View_HFit_HealthAssesmentAnswers AS VHFHAA4 ON VHFHAQ4.NodeID = VHFHAA4.NodeParentID

		--Branching level 3 Question Group
		--select count(*) from #Temp_View_HFit_HealthAssesmentAnswers AS VHFHAA4
		INNER JOIN #Temp_View_HFit_HealthAssesmentQuestions AS VHFHAQ5 ON VHFHAA4.NodeID = VHFHAQ5.NodeParentID
		INNER JOIN #Temp_View_HFit_HealthAssesmentAnswers AS VHFHAA5 ON VHFHAQ5.NodeID = VHFHAA5.NodeParentID

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
		, VHFHAMJ.IntroText
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
		, VHFHAQ6.Title AS QuesTitle
		, VHFHAQ6.Weight
		, VHFHAQ6.IsRequired
		, VHFHAQ6.DocumentID
		, VHFHAQ6.IsEnabled
		, VHFHAQ6.IsVisible
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
  #Temp_View_CMS_Tree_Joined AS VCTJ

 INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
 INNER JOIN HFit_Account hfa WITH(NOLOCK) ON cs.SiteID = hfa.SiteID
 INNER JOIN #Temp_View_HFit_HACampaign_Joined c WITH(NOLOCK) ON VCTJ.NodeID = c.NodeParentID
 INNER JOIN #Temp_View_HFit_HealthAssessment_Joined ha WITH (NOLOCK) ON c.HealthAssessmentID = ha.DocumentID
 INNER JOIN #Temp_View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ ON ha.NodeID = VHFHAMJ.NodeParentID
 INNER JOIN #Temp_View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
 INNER JOIN #Temp_View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
 INNER JOIN #Temp_View_HFit_HealthAssesmentQuestions AS VHFHAQ ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
 LEFT OUTER JOIN #Temp_View_HFit_HealthAssesmentAnswers AS VHFHAA ON VHFHAQ.NodeID = VHFHAA.NodeParentID

		--matrix level 1 questiongroup
		--INNER JOIN #Temp_View_HFit_HealthAssesmentQuestions AS VHFHAQ2 ON VHFHAQ.NodeID = VHFHAQ2.NodeParentID
		--INNER JOIN #Temp_View_HFit_HealthAssesmentAnswers AS VHFHAA2 ON VHFHAQ2.NodeID = VHFHAA2.NodeParentID

		--Branching Level 1 Question 
		INNER JOIN #Temp_View_HFit_HealthAssesmentQuestions AS VHFHAQ3 ON VHFHAA.NodeID = VHFHAQ3.NodeParentID
		LEFT OUTER JOIN #Temp_View_HFit_HealthAssesmentAnswers AS VHFHAA3 ON VHFHAQ3.NodeID = VHFHAA3.NodeParentID

		--Matrix Level 2 Question Group
		--INNER JOIN #Temp_View_HFit_HealthAssesmentQuestions AS VHFHAQ7 ON VHFHAQ3.NodeID = VHFHAQ7.NodeParentID
		--INNER JOIN #Temp_View_HFit_HealthAssesmentAnswers AS VHFHAA7 ON VHFHAQ7.NodeID = VHFHAA7.NodeParentID

		--Matrix branching level 1 question group
		--INNER JOIN #Temp_View_HFit_HealthAssesmentQuestions AS VHFHAQ8 ON VHFHAA7.NodeID = VHFHAQ8.NodeParentID
		--INNER JOIN #Temp_View_HFit_HealthAssesmentAnswers AS VHFHAA8 ON VHFHAQ8.NodeID = VHFHAA8.NodeParentID

		--Branching level 2 Question Group
		INNER JOIN #Temp_View_HFit_HealthAssesmentQuestions AS VHFHAQ4 ON VHFHAA3.NodeID = VHFHAQ4.NodeParentID
		INNER JOIN #Temp_View_HFit_HealthAssesmentAnswers AS VHFHAA4 ON VHFHAQ4.NodeID = VHFHAA4.NodeParentID

		--Branching level 3 Question Group
		--select count(*) from #Temp_View_HFit_HealthAssesmentAnswers AS VHFHAA4
		INNER JOIN #Temp_View_HFit_HealthAssesmentQuestions AS VHFHAQ5 ON VHFHAA4.NodeID = VHFHAQ5.NodeParentID
		INNER JOIN #Temp_View_HFit_HealthAssesmentAnswers AS VHFHAA5 ON VHFHAQ5.NodeID = VHFHAA5.NodeParentID

		--Branching level 4 Question Group
		INNER JOIN #Temp_View_HFit_HealthAssesmentQuestions AS VHFHAQ6 ON VHFHAA5.NodeID = VHFHAQ6.NodeParentID
		INNER JOIN #Temp_View_HFit_HealthAssesmentAnswers AS VHFHAA6 ON VHFHAQ6.NodeID = VHFHAA6.NodeParentID

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
		, VHFHAMJ.IntroText
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
		, VHFHAQ9.Title AS QuesTitle
		, VHFHAQ9.Weight
		, VHFHAQ9.IsRequired
		, VHFHAQ9.DocumentID
		, VHFHAQ9.IsEnabled
		, VHFHAQ9.IsVisible
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
  #Temp_View_CMS_Tree_Joined AS VCTJ

 INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
 INNER JOIN HFit_Account hfa WITH(NOLOCK) ON cs.SiteID = hfa.SiteID
 INNER JOIN #Temp_View_HFit_HACampaign_Joined c WITH(NOLOCK) ON VCTJ.NodeID = c.NodeParentID
 INNER JOIN #Temp_View_HFit_HealthAssessment_Joined ha WITH (NOLOCK) ON c.HealthAssessmentID = ha.DocumentID
 INNER JOIN #Temp_View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ ON ha.NodeID = VHFHAMJ.NodeParentID
 INNER JOIN #Temp_View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
 INNER JOIN #Temp_View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
 INNER JOIN #Temp_View_HFit_HealthAssesmentQuestions AS VHFHAQ ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
 LEFT OUTER JOIN #Temp_View_HFit_HealthAssesmentAnswers AS VHFHAA ON VHFHAQ.NodeID = VHFHAA.NodeParentID

		--matrix level 1 questiongroup
		--INNER JOIN #Temp_View_HFit_HealthAssesmentQuestions AS VHFHAQ2 ON VHFHAQ.NodeID = VHFHAQ2.NodeParentID
		--INNER JOIN #Temp_View_HFit_HealthAssesmentAnswers AS VHFHAA2 ON VHFHAQ2.NodeID = VHFHAA2.NodeParentID

		--Branching Level 1 Question 
		INNER JOIN #Temp_View_HFit_HealthAssesmentQuestions AS VHFHAQ3 ON VHFHAA.NodeID = VHFHAQ3.NodeParentID
		LEFT OUTER JOIN #Temp_View_HFit_HealthAssesmentAnswers AS VHFHAA3 ON VHFHAQ3.NodeID = VHFHAA3.NodeParentID

		--Matrix Level 2 Question Group
		--INNER JOIN #Temp_View_HFit_HealthAssesmentQuestions AS VHFHAQ7 ON VHFHAQ3.NodeID = VHFHAQ7.NodeParentID
		--INNER JOIN #Temp_View_HFit_HealthAssesmentAnswers AS VHFHAA7 ON VHFHAQ7.NodeID = VHFHAA7.NodeParentID

		--Matrix branching level 1 question group
		--INNER JOIN #Temp_View_HFit_HealthAssesmentQuestions AS VHFHAQ8 ON VHFHAA7.NodeID = VHFHAQ8.NodeParentID
		--INNER JOIN #Temp_View_HFit_HealthAssesmentAnswers AS VHFHAA8 ON VHFHAQ8.NodeID = VHFHAA8.NodeParentID

		--Branching level 2 Question Group
		INNER JOIN #Temp_View_HFit_HealthAssesmentQuestions AS VHFHAQ4 ON VHFHAA3.NodeID = VHFHAQ4.NodeParentID
		INNER JOIN #Temp_View_HFit_HealthAssesmentAnswers AS VHFHAA4 ON VHFHAQ4.NodeID = VHFHAA4.NodeParentID

		--Branching level 3 Question Group
		--select count(*) from #Temp_View_HFit_HealthAssesmentAnswers AS VHFHAA4
		INNER JOIN #Temp_View_HFit_HealthAssesmentQuestions AS VHFHAQ5 ON VHFHAA4.NodeID = VHFHAQ5.NodeParentID
		INNER JOIN #Temp_View_HFit_HealthAssesmentAnswers AS VHFHAA5 ON VHFHAQ5.NodeID = VHFHAA5.NodeParentID

		--Branching level 4 Question Group
		INNER JOIN #Temp_View_HFit_HealthAssesmentQuestions AS VHFHAQ6 ON VHFHAA5.NodeID = VHFHAQ6.NodeParentID
		INNER JOIN #Temp_View_HFit_HealthAssesmentAnswers AS VHFHAA6 ON VHFHAQ6.NodeID = VHFHAA6.NodeParentID

		--Branching level 5 Question Group
		INNER JOIN #Temp_View_HFit_HealthAssesmentQuestions AS VHFHAQ9 ON VHFHAA6.NodeID = VHFHAQ9.NodeParentID
		INNER JOIN #Temp_View_HFit_HealthAssesmentAnswers AS VHFHAA9 ON VHFHAQ9.NodeID = VHFHAA9.NodeParentID



	GO 
	
	drop index [View_CMS_Tree_Joined_Linked].PI04_View_CMS_Tree_Joined_Linked
	go

	drop index HFit_Account.PI01_HFit_Account
	go

	drop index [View_CMS_Tree_Joined_Linked].[CI01_View_CMS_Tree_Joined_Linked]
	GO  --  
  --  
GO 
print('***** FROM: view_EDW_HealthAssesmentDeffinition_Rewrite.sql'); 
GO 
