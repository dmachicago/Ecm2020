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
dbo.View_HFit_HACampaign_Joined
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
	dbo.View_CMS_Tree_Joined AS VCTJ

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
		, dbo.udf_StripHTML(left(left(VHFHAMJ.IntroText,4000),4000)) AS IntroText
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
	dbo.View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ

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
	dbo.View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ
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
	dbo.View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ
 
 GO
 Create clustered index PI_Temp_View_HFit_HealthAssesmentRiskArea_Joined on #Temp_View_HFit_HealthAssesmentRiskArea_Joined
 (
	DocumentNodeID
 )
 
 drop table #Temp_View_HFit_HealthAssesmentQuestions
 go
 SELECT 
		VHFHAQ.QuestionType
		, dbo.udf_StripHTML(left(VHFHAQ.Title,4000)) AS Title
		, VHFHAQ.[Weight]
		, VHFHAQ.IsRequired
		, VHFHAQ.DocumentID
		, VHFHAQ.IsEnabled
		, left(VHFHAQ.IsVisible,4000) AS IsVisible
		, VHFHAQ.IsStaging
		, VHFHAQ.CodeName
		, VHFHAQ.DocumentPublishedVersionHistoryID
		, VHFHAQ.NodeParentID
		, VHFHAQ.NodeID
	INTO #Temp_View_HFit_HealthAssesmentQuestions
	FROM
	dbo.View_HFit_HealthAssesmentQuestions AS VHFHAQ

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
	INTO #Temp_View_HFit_HealthAssesmentAnswers
	FROM
	dbo.View_HFit_HealthAssesmentAnswers AS VHFHAA 
	GO 

	create clustered index PI_Temp_View_HFit_HealthAssesmentAnswers on #Temp_View_HFit_HealthAssesmentAnswers
	(
		NodeParentID, DocumentID, DocumentPublishedVersionHistoryID
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

GO

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
		, dbo.udf_StripHTML(left(left(VHFHAMJ.IntroText,4000),4000)) AS IntroText
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
		, dbo.udf_StripHTML(left(VHFHAQ.Title,4000)) AS QuesTitle
		, VHFHAQ.Weight AS QuesWeight
		, VHFHAQ.IsRequired AS QuesIsRequired
		, VHFHAQ.DocumentID AS QuesDocumentID
		, VHFHAQ.IsEnabled AS QuesIsEnabled
		, left(VHFHAQ.IsVisible,4000) AS QuesIsVisible
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
	
	GO 
	
	drop index [View_CMS_Tree_Joined_Linked].PI04_View_CMS_Tree_Joined_Linked
	go
