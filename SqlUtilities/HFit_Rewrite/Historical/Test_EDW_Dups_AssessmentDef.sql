
--/****** Object:  View [dbo].[Test_EDW_Dups_AssessmentDef]    Script Date: 8/8/2014 9:57:33 AM ******/
--SET ANSI_NULLS ON
--GO

--SET QUOTED_IDENTIFIER ON
--GO

--create view [dbo].[Test_EDW_Dups_AssessmentDef]
--as
--SELECT cs.SiteGUID
--		, HFA.AccountCD		--WDM 08.07.2014
--		, HA.NodeID AS HANodeID		--WDM 08.07.2014
--		, HA.NodeName AS HANodeName		--WDM 08.07.2014
--		, HA.DocumentID AS HADocumentID		--WDM 08.07.2014
--		, HA.NodeSiteID AS HANodeSiteID		--WDM 08.07.2014
--		, HA.DocumentPublishedVersionHistoryID AS HADocPubVerID		--WDM 08.07.2014
--		, VHFHAMJ.Title AS ModTitle
--		--Per EDW Team, HTML text is truncated to 4000 bytes - we'll just do it here
--		, dbo.udf_StripHTML(left(left(VHFHAMJ.IntroText,4000),4000)) AS IntroText
--		, VHFHAMJ.DocumentGuid AS ModDocGuid	--, VHFHAMJ.DocumentID AS ModDocID	--WDM 08.07.2014
--		, VHFHAMJ.Weight AS ModWeight
--		, VHFHAMJ.IsEnabled AS ModIsEnabled
--		, VHFHAMJ.CodeName AS ModCodeName
--		, VHFHAMJ.DocumentPublishedVersionHistoryID AS ModDocPubVerID
--		, VHFHARCJ.Title AS RCTitle
--		, VHFHARCJ.Weight AS RCWeight
--		, VHFHARCJ.DocumentGuid AS RCDocumentGUID	--, VHFHARCJ.DocumentID AS RCDocumentID	--WDM 08.07.2014
--		, VHFHARCJ.IsEnabled AS RCIsEnabled
--		, VHFHARCJ.CodeName AS RCCodeName
--		, VHFHARCJ.DocumentPublishedVersionHistoryID AS RCDocPubVerID
--		, VHFHARAJ.Title AS RATytle
--		, VHFHARAJ.Weight AS RAWeight
--		, VHFHARAJ.DocumentGuid AS RADocumentGuid	--, VHFHARAJ.DocumentID AS RADocumentID	--WDM 08.07.2014
--		, VHFHARAJ.IsEnabled AS RAIsEnabled
--		, VHFHARAJ.CodeName AS RACodeName
--		, VHFHARAJ.ScoringStrategyID AS RAScoringStrategyID
--		, VHFHARAJ.DocumentPublishedVersionHistoryID AS RADocPubVerID
--		, VHFHAQ.QuestionType
--		, dbo.udf_StripHTML(left(VHFHAQ.Title,4000)) AS QuesTitle
--		, VHFHAQ.Weight AS QuesWeight
--		, VHFHAQ.IsRequired AS QuesIsRequired

--		, VHFHAQ.DocumentGuid AS QuesDocumentGuid	--, VHFHAQ.DocumentID AS QuesDocumentID	--WDM 08.07.2014
		
--		, VHFHAQ.IsEnabled AS QuesIsEnabled
--		, left(VHFHAQ.IsVisible,4000) AS QuesIsVisible
--		, VHFHAQ.IsStaging AS QuesIsSTaging
--		, VHFHAQ.CodeName AS QuestionCodeName
--		, VHFHAQ.DocumentPublishedVersionHistoryID AS QuesDocPubVerID
--		, VHFHAA.Value AS AnsValue
--		, VHFHAA.Points AS AnsPoints
		
--		, VHFHAA.DocumentGuid AS AnsDocumentGuid	--, VHFHAA.DocumentID AS AnsDocumentID	--WDM 08.07.2014
		
--		, VHFHAA.IsEnabled AS AnsIsEnabled
--		, VHFHAA.CodeName AS AnsCodeName
--		, VHFHAA.UOM AS AnsUOM
--		, VHFHAA.DocumentPublishedVersionHistoryID AS AnsDocPUbVerID
--		, CASE	WHEN CAST(VCTJ.DocumentCreatedWhen AS DATE) = CAST(vctj.DocumentModifiedWhen AS DATE)
--			THEN 'I'
--			ELSE 'U'
--		END AS ChangeType
--		, VCTJ.DocumentCreatedWhen
--		, VCTJ.DocumentModifiedWhen
--		, VCTJ.NodeGuid as CmsTreeNodeGuid	--WDM 08.07.2014 ADDED TO the returned Columns
--	 FROM
--		dbo.View_CMS_Tree_Joined AS VCTJ
--		INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
--		INNER JOIN HFit_Account hfa WITH(NOLOCK) ON cs.SiteID = hfa.SiteID
 
--		--Campaign links Client which links to Assessment
--		INNER JOIN dbo.View_HFit_HACampaign_Joined as c WITH(NOLOCK) ON VCTJ.NodeID = c.NodeParentID
 
--		INNER JOIN View_HFit_HealthAssessment_Joined as HA WITH (NOLOCK) ON c.HealthAssessmentID = HA.DocumentID
--		--WDM 08.07.2014
--		INNER JOIN dbo.View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ ON HA.NodeID = VHFHAMJ.NodeParentID		
--		INNER JOIN dbo.View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
--		INNER JOIN dbo.View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
--		INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
--		LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA ON VHFHAQ.NodeID = VHFHAA.NodeParentID
--		where VCTJ.DocumentCulture = 'en-us'	--WDM 08.07.2014

--GO

SELECT distinct count(*) as icnt,
	[SiteGUID]
      ,[AccountCD]
      ,[HANodeID]
      ,[HANodeName]
      ,[HADocumentID]
      ,[HANodeSiteID]
      ,[HADocPubVerID]
      ,[ModTitle]
      ,[IntroText]
      ,[ModDocGuid]
      ,[ModWeight]
      ,[ModIsEnabled]
      ,[ModCodeName]
      ,[ModDocPubVerID]
      ,[RCTitle]
      ,[RCWeight]
      ,[RCDocumentGUID]
      ,[RCIsEnabled]
      ,[RCCodeName]
      ,[RCDocPubVerID]
      ,[RATytle]
      ,[RAWeight]
      ,[RADocumentGuid]
      ,[RAIsEnabled]
      ,[RACodeName]
      ,[RAScoringStrategyID]
      ,[RADocPubVerID]
      ,[QuestionType]
      ,[QuesTitle]
      ,[QuesWeight]
      ,[QuesIsRequired]
      ,[QuesDocumentGuid]
      ,[QuesIsEnabled]
      ,[QuesIsVisible]
      ,[QuesIsSTaging]
      ,[QuestionCodeName]
      ,[QuesDocPubVerID]
      ,[AnsValue]
      ,[AnsPoints]
      ,[AnsDocumentGuid]
      ,[AnsIsEnabled]
      ,[AnsCodeName]
      ,[AnsUOM]
      ,[AnsDocPUbVerID]
      ,[ChangeType]
      ,[DocumentCreatedWhen]
      ,[DocumentModifiedWhen]
      ,[CmsTreeNodeGuid]
  FROM [dbo].[Test_EDW_Dups_AssessmentDef]
group by 
[SiteGUID]
      ,[AccountCD]
      ,[HANodeID]
      ,[HANodeName]
      ,[HADocumentID]
      ,[HANodeSiteID]
      ,[HADocPubVerID]
      ,[ModTitle]
      ,[IntroText]
      ,[ModDocGuid]
      ,[ModWeight]
      ,[ModIsEnabled]
      ,[ModCodeName]
      ,[ModDocPubVerID]
      ,[RCTitle]
      ,[RCWeight]
      ,[RCDocumentGUID]
      ,[RCIsEnabled]
      ,[RCCodeName]
      ,[RCDocPubVerID]
      ,[RATytle]
      ,[RAWeight]
      ,[RADocumentGuid]
      ,[RAIsEnabled]
      ,[RACodeName]
      ,[RAScoringStrategyID]
      ,[RADocPubVerID]
      ,[QuestionType]
      ,[QuesTitle]
      ,[QuesWeight]
      ,[QuesIsRequired]
      ,[QuesDocumentGuid]
      ,[QuesIsEnabled]
      ,[QuesIsVisible]
      ,[QuesIsSTaging]
      ,[QuestionCodeName]
      ,[QuesDocPubVerID]
      ,[AnsValue]
      ,[AnsPoints]
      ,[AnsDocumentGuid]
      ,[AnsIsEnabled]
      ,[AnsCodeName]
      ,[AnsUOM]
      ,[AnsDocPUbVerID]
      ,[ChangeType]
      ,[DocumentCreatedWhen]
      ,[DocumentModifiedWhen]
      ,[CmsTreeNodeGuid]
having count(*) > 1