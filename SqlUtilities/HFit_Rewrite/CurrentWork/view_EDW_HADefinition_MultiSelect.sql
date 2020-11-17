
print ('Processing: view_EDW_HealthAssesmentDeffinition ' + cast(getdate() as nvarchar(50))) ;
go


if exists(select TABLE_NAME from INFORMATION_SCHEMA.VIEWS where TABLE_NAME = 'view_EDW_HealthAssesmentDeffinition')
BEGIN
	drop view view_EDW_HealthAssesmentDeffinition ;
END
GO

--**************************************************************************************************************
--NOTE: The column DocumentModifiedWhen comes from the CMS_TREE join - it was left 
--		unchanged when other dates added for the Last Mod Date additions. 
--		Therefore, the 'ChangeType' was left dependent upon this date only. 09.12.2014 (wdm)
--**************************************************************************************************************
--WDM - 6/25/2014
--Query was returning a NULL dataset. Found that it is being caused by the AccountCD join.
--Worked with Shane to discover the CMS Tree had been modified.
--Modified the code so that reads it reads the CMS tree correctly - working.
--7/14/2014 1:29 time to run - 79024 rows - DEV
--7/14/2014 0:58 time to run - 57472 rows - PROD1
--7/15/2014 - Query was returning NodeName of 'Campaigns' only
--	Found the issue in view View_HFit_HACampaign_Joined. Documented the change in the view.
--7/16/2014 - Full Select: Using a DocumentModifiedWhen filter 00:17:28 - Record Cnt: 793,520
--8/7/2014 - Executed in DEV with GUID changes and returned 1.13M Rows in 23:14.
--8/8/2014 - Executed in DEV with GUID changes, new views, and returned 1.13M Rows in 20:16.
--8/8/2014 - Generated corrected view in DEV
--8/12/2014 - John C. explained that Account Code and Site Guid are not needed, NULLED
--				them out. With them in the QRY, returned 43104 rows, with them nulled
--				out, returned 43104 rows. Using a DISTINCT, 28736 rows returned and execution
--				time doubled approximately.
--				Has to add a DISTINCT to all the queries - .
--				Original Query 0:25 @ 43104
--				Original Query 0:46 @ 28736 (distinct)
--				Filter added - VHFHAQ.DocumentCulture 0:22 @ 14368
--				Filter added - and VHFHARCJ.DocumentCulture = 'en-us'	 0:06 @ 3568
--				Filter added - and VHFHARAJ.DocumentCulture = 'en-us'	 0:03 @ 1784
--8/12/2014 - Applied the language filters with John C. and performance improved, as expected,
--				such that when running the view in QA: 
--*********************************************************************************************************************
--select * from [view_EDW_HealthAssesmentDeffinition] where DocumentModifiedWhen between '2000-11-14' and '2014-11-15'
--08/12/2014 - ProdStaging 00:21:52 @ 2442
--08/12/2014 - ProdStaging 00:21:09 @ 13272 (UNION ALL   --UNION)
--08/12/2014 - ProdStaging 00:21:37 @ 13272 (UNION ONLY)
--08/12/2014 - ProdStaging 00:06:26 @ 1582 (UNION ONLY & Select Filters Added for Culture)
--08/12/2014 - ProdStaging 00:10:07 @ 6636 (UNION ALL   --UNION) and all selected
--08/12/2014 - ProdStaging added PI PI_View_CMS_Tree_Joined_Regular_DocumentCulture: 00:2:34 @ 6636 
--08/12/2014 - DEV 00:00:58 @ 3792
--09.11.2014 - (wdm) added the needed date fields to help EDW in determining the last mod date of a row.
--10.01.2014 - Dale and Mark reworked this view to use NodeGUIDS and eliminated the CMS_TREE View from participating as well as Site and Account data
--11.25.2014 - (wdm) added multi-select column. The values can be 0,1, NULL
--*********************************************************************************************************************
go

create VIEW [dbo].[view_EDW_HealthAssesmentDeffinition] 
AS
SELECT distinct 
		NULL as SiteGUID --cs.SiteGUID								--WDM 08.12.2014 per John C.
		, NULL as AccountCD	 --, HFA.AccountCD						--WDM 08.07.2014 per John C.
		, HA.NodeID AS HANodeID										--WDM 08.07.2014
		, HA.NodeName AS HANodeName									--WDM 08.07.2014
		--, HA.DocumentID AS HADocumentID								--WDM 08.07.2014 commented out and left in place for history
		, NULL AS HADocumentID										--WDM 08.07.2014
																	--09.29.2014: Mark and Dale discussed that NODEGUID should be used 
																	--such that the multi-language/culture is not a problem.
		, HA.NodeSiteID AS HANodeSiteID								--WDM 08.07.2014
		, HA.DocumentPublishedVersionHistoryID AS HADocPubVerID		--WDM 08.07.2014
		, VHFHAMJ.Title AS ModTitle
 		
		, dbo.udf_StripHTML(left(VHFHAMJ.IntroText,4000)) AS IntroText
		, VHFHAMJ.NodeGuid AS ModDocGuid	--, VHFHAMJ.DocumentID AS ModDocID	--WDM 08.07.2014	M&D 10.01.2014
		, VHFHAMJ.Weight AS ModWeight
		, VHFHAMJ.IsEnabled AS ModIsEnabled
		, VHFHAMJ.CodeName AS ModCodeName
		, VHFHAMJ.DocumentPublishedVersionHistoryID AS ModDocPubVerID
		, VHFHARCJ.Title AS RCTitle
		, VHFHARCJ.Weight AS RCWeight
		, VHFHARCJ.NodeGuid AS RCDocumentGUID	--, VHFHARCJ.DocumentID AS RCDocumentID	--WDM 08.07.2014	M&D 10.01.2014
		, VHFHARCJ.IsEnabled AS RCIsEnabled
		, VHFHARCJ.CodeName AS RCCodeName
		, VHFHARCJ.DocumentPublishedVersionHistoryID AS RCDocPubVerID
		, VHFHARAJ.Title AS RATytle
		, VHFHARAJ.Weight AS RAWeight
		, VHFHARAJ.NodeGuid AS RADocumentGuid	--, VHFHARAJ.DocumentID AS RADocumentID	--WDM 08.07.2014	M&D 10.01.2014
		, VHFHARAJ.IsEnabled AS RAIsEnabled
		, VHFHARAJ.CodeName AS RACodeName
		, VHFHARAJ.ScoringStrategyID AS RAScoringStrategyID
		, VHFHARAJ.DocumentPublishedVersionHistoryID AS RADocPubVerID
		, VHFHAQ.QuestionType
		, dbo.udf_StripHTML(left(VHFHAQ.Title,4000)) AS QuesTitle
		, VHFHAQ.Weight AS QuesWeight
		, VHFHAQ.IsRequired AS QuesIsRequired

		--, VHFHAQ.DocumentGuid AS QuesDocumentGuid	--, VHFHAQ.DocumentID AS QuesDocumentID	--WDM 08.07.2014	M&D 10.01.2014
		, VHFHAQ.NodeGuid AS QuesDocumentGuid	--, VHFHAQ.DocumentID AS QuesDocumentID	--WDM 08.07.2014
		
		, VHFHAQ.IsEnabled AS QuesIsEnabled
		, left(VHFHAQ.IsVisible,4000) AS QuesIsVisible
		, VHFHAQ.IsStaging AS QuesIsSTaging
		, VHFHAQ.CodeName AS QuestionCodeName
		, VHFHAQ.DocumentPublishedVersionHistoryID AS QuesDocPubVerID
		, VHFHAA.Value AS AnsValue
		, VHFHAA.Points AS AnsPoints
		
		--, VHFHAA.DocumentGuid AS AnsDocumentGuid	--, VHFHAA.DocumentID AS AnsDocumentID	--WDM 08.07.2014	M&D 10.01.2014
		, VHFHAA.NodeGuid AS AnsDocumentGuid	--, VHFHAA.DocumentID AS AnsDocumentID	--WDM 08.07.2014
		
		, VHFHAA.IsEnabled AS AnsIsEnabled
		, VHFHAA.CodeName AS AnsCodeName
		, VHFHAA.UOM AS AnsUOM
		, VHFHAA.DocumentPublishedVersionHistoryID AS AnsDocPUbVerID
		, CASE	WHEN CAST(HA.DocumentCreatedWhen AS DATE) = CAST(HA.DocumentModifiedWhen AS DATE)
			THEN 'I'
			ELSE 'U'
		END AS ChangeType
		, HA.DocumentCreatedWhen
		, HA.DocumentModifiedWhen
		, HA.NodeGuid as CmsTreeNodeGuid	--WDM 08.07.2014 ADDED TO the returned Columns
		, HA.NodeGUID as HANodeGUID

		--, NULL as SiteLastModified
		, NULL as SiteLastModified
		--, NULL as Account_ItemModifiedWhen
		, NULL as Account_ItemModifiedWhen
		--, c.DocumentModifiedWhen as Campaign_DocumentModifiedWhen
		, NULL as Campaign_DocumentModifiedWhen
		, HA.DocumentModifiedWhen as Assessment_DocumentModifiedWhen
		, VHFHAMJ.DocumentModifiedWhen as Module_DocumentModifiedWhen
		, VHFHARCJ.DocumentModifiedWhen as RiskCategory_DocumentModifiedWhen
		, VHFHARAJ.DocumentModifiedWhen as RiskArea_DocumentModifiedWhen
		, VHFHAQ.DocumentModifiedWhen as Question_DocumentModifiedWhen
		, VHFHAA.DocumentModifiedWhen as Answer_DocumentModifiedWhen
		, HAMCQ.AllowMultiSelect
	 FROM
		--dbo.View_CMS_Tree_Joined AS VCTJ
		--INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
		--INNER JOIN HFit_Account hfa WITH(NOLOCK) ON cs.SiteID = hfa.SiteID
 
		--Campaign links Client which links to Assessment
		--INNER JOIN dbo.View_HFit_HACampaign_Joined as c WITH(NOLOCK) ON VCTJ.NodeID = c.NodeParentID	--Note: 
 
		View_HFit_HealthAssessment_Joined as HA WITH (NOLOCK) 
		INNER JOIN dbo.View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ ON HA.NodeID = VHFHAMJ.NodeParentID		
		INNER JOIN dbo.View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
		INNER JOIN dbo.View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
		INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
		LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA ON VHFHAQ.NodeID = VHFHAA.NodeParentID
		left outer join [View_HFit_HealthAssesmentMultipleChoiceQuestion_Joined] as HAMCQ 
			on VHFHAQ.Nodeguid = HAMCQ.Nodeguid
			AND HAMCQ.DocumentCulture = 'en-US'
	where VHFHAQ.DocumentCulture = 'en-us'	--WDM 08.12.2014	
		and (VHFHAA.DocumentCulture = 'en-us' OR VHFHAA.DocumentCulture is null)	--WDM 08.12.2014		
		and VHFHARCJ.DocumentCulture = 'en-us'	--WDM 08.12.2014		
		and VHFHARAJ.DocumentCulture = 'en-us'	--WDM 08.12.2014		
		and VHFHAMJ.DocumentCulture = 'en-us'	--WDM 08.12.2014	
		and HA.DocumentCulture = 'en-us'		--WDM 08.12.2014	
		

UNION ALL   --UNION
--WDM Retrieve Matrix Level 1 Question Group
	SELECT distinct
		NULL as SiteGUID --cs.SiteGUID		--WDM 08.12.2014
		, NULL as AccountCD	 --, HFA.AccountCD												--WDM 08.07.2014
		, HA.NodeID		--WDM 08.07.2014
		, HA.NodeName		--WDM 08.07.2014
		, NULL AS HADocumentID		--WDM 08.07.2014
		, HA.NodeSiteID		--WDM 08.07.2014
       --,VCTJ.NodeAliasPath
		, HA.DocumentPublishedVersionHistoryID		--WDM 08.07.2014
		, VHFHAMJ.Title
		, dbo.udf_StripHTML(left(left(VHFHAMJ.IntroText,4000),4000)) AS IntroText
		, VHFHAMJ.NodeGuid
		, VHFHAMJ.Weight
		, VHFHAMJ.IsEnabled
		, VHFHAMJ.CodeName
       --,VHFHAMJ.NodeAliasPath
		, VHFHAMJ.DocumentPublishedVersionHistoryID
		, VHFHARCJ.Title
		, VHFHARCJ.Weight
		, VHFHARCJ.NodeGuid
		, VHFHARCJ.IsEnabled
		, VHFHARCJ.CodeName
       --,VHFHARCJ.NodeAliasPath
		, VHFHARCJ.DocumentPublishedVersionHistoryID
		, VHFHARAJ.Title
		, VHFHARAJ.Weight
		, VHFHARAJ.NodeGuid
		, VHFHARAJ.IsEnabled
		, VHFHARAJ.CodeName
       --,VHFHARAJ.NodeAliasPath
		, VHFHARAJ.ScoringStrategyID
		, VHFHARAJ.DocumentPublishedVersionHistoryID
		, VHFHAQ2.QuestionType
		, dbo.udf_StripHTML(left(VHFHAQ2.Title,4000)) AS QuesTitle
		, VHFHAQ2.Weight
		, VHFHAQ2.IsRequired
		, VHFHAQ2.NodeGuid
		, VHFHAQ2.IsEnabled
		, left(VHFHAQ2.IsVisible,4000)
		, VHFHAQ2.IsStaging
		, VHFHAQ2.CodeName AS QuestionCodeName
       --,VHFHAQ2.NodeAliasPath
		, VHFHAQ2.DocumentPublishedVersionHistoryID
		, VHFHAA2.Value
		, VHFHAA2.Points
		, VHFHAA2.NodeGuid
		, VHFHAA2.IsEnabled
		, VHFHAA2.CodeName
		, VHFHAA2.UOM
       --,VHFHAA2.NodeAliasPath
		, VHFHAA2.DocumentPublishedVersionHistoryID
		, CASE	WHEN CAST(HA.DocumentCreatedWhen AS DATE) = CAST(HA.DocumentModifiedWhen AS DATE)
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		, HA.DocumentCreatedWhen
		, HA.DocumentModifiedWhen
		, HA.NodeGuid as CmsTreeNodeGuid	--WDM 08.07.2014
		, HA.NodeGUID as HANodeGUID
	 
		, NULL as SiteLastModified
		, NULL as Account_ItemModifiedWhen
		--, c.DocumentModifiedWhen as Campaign_DocumentModifiedWhen
		, NULL as Campaign_DocumentModifiedWhen
		, HA.DocumentModifiedWhen as Assessment_DocumentModifiedWhen
		, VHFHAMJ.DocumentModifiedWhen as Module_DocumentModifiedWhen
		, VHFHARCJ.DocumentModifiedWhen as RiskCategory_DocumentModifiedWhen
		, VHFHARAJ.DocumentModifiedWhen as RiskArea_DocumentModifiedWhen
		, VHFHAQ.DocumentModifiedWhen as Question_DocumentModifiedWhen
		, VHFHAA.DocumentModifiedWhen as Answer_DocumentModifiedWhen
		, HAMCQ.AllowMultiSelect
	FROM
 --dbo.View_CMS_Tree_Joined AS VCTJ
		--INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
		--INNER JOIN HFit_Account hfa WITH(NOLOCK) ON cs.SiteID = hfa.SiteID
 
		--Campaign links Client which links to Assessment
		--INNER JOIN dbo.View_HFit_HACampaign_Joined as c WITH(NOLOCK) ON VCTJ.NodeID = c.NodeParentID	--Note: 
 
View_HFit_HealthAssessment_Joined HA WITH (NOLOCK) 
 INNER JOIN dbo.View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ ON HA.NodeID = VHFHAMJ.NodeParentID
 INNER JOIN dbo.View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
 INNER JOIN dbo.View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
 INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
 LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA ON VHFHAQ.NodeID = VHFHAA.NodeParentID
--matrix level 1 questiongroup
	INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ2 ON VHFHAQ.NodeID = VHFHAQ2.NodeParentID
	INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA2 ON VHFHAQ2.NodeID = VHFHAA2.NodeParentID
	left outer join [View_HFit_HealthAssesmentMultipleChoiceQuestion_Joined] as HAMCQ 
			on VHFHAQ.Nodeguid = HAMCQ.Nodeguid
			AND HAMCQ.DocumentCulture = 'en-US'
where VHFHAQ.DocumentCulture = 'en-us'	
		and (VHFHAA.DocumentCulture = 'en-us' OR VHFHAA.DocumentCulture is null)	--WDM 08.12.2014		
		and VHFHARCJ.DocumentCulture = 'en-us'	
		and VHFHARAJ.DocumentCulture = 'en-us'	
		and VHFHAMJ.DocumentCulture = 'en-us'	--WDM 08.12.2014	
		and HA.DocumentCulture = 'en-us'	--WDM 08.12.2014		

UNION ALL   --UNION
--WDM Retrieve Branching Level 1 Question and Matrix Level 1 Question Group
	SELECT distinct
		NULL as SiteGUID --cs.SiteGUID		--WDM 08.12.2014
		, NULL as AccountCD	 --, HFA.AccountCD												--WDM 08.07.2014
		, HA.NodeID		--WDM 08.07.2014
		, HA.NodeName		--WDM 08.07.2014
		, NULL AS HADocumentID		--WDM 08.07.2014
		, HA.NodeSiteID		--WDM 08.07.2014
       --,VCTJ.NodeAliasPath
		, HA.DocumentPublishedVersionHistoryID		--WDM 08.07.2014
		, VHFHAMJ.Title
		, dbo.udf_StripHTML(left(VHFHAMJ.IntroText,4000)) AS IntroText
		, VHFHAMJ.NodeGuid
		, VHFHAMJ.Weight
		, VHFHAMJ.IsEnabled
		, VHFHAMJ.CodeName
       --,VHFHAMJ.NodeAliasPath
		, VHFHAMJ.DocumentPublishedVersionHistoryID
		, VHFHARCJ.Title
		, VHFHARCJ.Weight
		, VHFHARCJ.NodeGuid
		, VHFHARCJ.IsEnabled
		, VHFHARCJ.CodeName
       --,VHFHARCJ.NodeAliasPath
		, VHFHARCJ.DocumentPublishedVersionHistoryID
		, VHFHARAJ.Title
		, VHFHARAJ.Weight
		, VHFHARAJ.NodeGuid
		, VHFHARAJ.IsEnabled
		, VHFHARAJ.CodeName
       --,VHFHARAJ.NodeAliasPath
		, VHFHARAJ.ScoringStrategyID
		, VHFHARAJ.DocumentPublishedVersionHistoryID
		, VHFHAQ3.QuestionType
		, dbo.udf_StripHTML(left(VHFHAQ3.Title,4000)) AS QuesTitle
		, VHFHAQ3.Weight
		, VHFHAQ3.IsRequired
		, VHFHAQ3.NodeGuid
		, VHFHAQ3.IsEnabled
		, left(VHFHAQ3.IsVisible,4000)
		, VHFHAQ3.IsStaging
		, VHFHAQ3.CodeName AS QuestionCodeName
       --,VHFHAQ3.NodeAliasPath
		, VHFHAQ3.DocumentPublishedVersionHistoryID
		, VHFHAA3.Value
		, VHFHAA3.Points
		, VHFHAA3.NodeGuid
		, VHFHAA3.IsEnabled
		, VHFHAA3.CodeName
		, VHFHAA3.UOM
       --,VHFHAA3.NodeAliasPath
		, VHFHAA3.DocumentPublishedVersionHistoryID
		, CASE	WHEN CAST(HA.DocumentCreatedWhen AS DATE) = CAST(HA.DocumentModifiedWhen AS DATE)
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		, HA.DocumentCreatedWhen
		, HA.DocumentModifiedWhen
		, HA.NodeGuid as CmsTreeNodeGuid	--WDM 08.07.2014
		, HA.NodeGUID as HANodeGUID
 
		, NULL as SiteLastModified
		, NULL as Account_ItemModifiedWhen
		--, c.DocumentModifiedWhen as Campaign_DocumentModifiedWhen
		, NULL as Campaign_DocumentModifiedWhen
		, HA.DocumentModifiedWhen as Assessment_DocumentModifiedWhen
		, VHFHAMJ.DocumentModifiedWhen as Module_DocumentModifiedWhen
		, VHFHARCJ.DocumentModifiedWhen as RiskCategory_DocumentModifiedWhen
		, VHFHARAJ.DocumentModifiedWhen as RiskArea_DocumentModifiedWhen
		, VHFHAQ.DocumentModifiedWhen as Question_DocumentModifiedWhen
		, VHFHAA.DocumentModifiedWhen as Answer_DocumentModifiedWhen
		, HAMCQ.AllowMultiSelect
FROM
 --dbo.View_CMS_Tree_Joined AS VCTJ
		--INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
		--INNER JOIN HFit_Account hfa WITH(NOLOCK) ON cs.SiteID = hfa.SiteID
 
		--Campaign links Client which links to Assessment
		--INNER JOIN dbo.View_HFit_HACampaign_Joined as c WITH(NOLOCK) ON VCTJ.NodeID = c.NodeParentID	--Note: 
 
View_HFit_HealthAssessment_Joined HA WITH (NOLOCK)
 INNER JOIN dbo.View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ ON HA.NodeID = VHFHAMJ.NodeParentID
 INNER JOIN dbo.View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
 INNER JOIN dbo.View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
 INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
 LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA ON VHFHAQ.NodeID = VHFHAA.NodeParentID

--matrix level 1 questiongroup
--INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ2 ON VHFHAQ.NodeID = VHFHAQ2.NodeParentID
--INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA2 ON VHFHAQ2.NodeID = VHFHAA2.NodeParentID

--Branching Level 1 Question 
	INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ3 ON VHFHAA.NodeID = VHFHAQ3.NodeParentID
	LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA3 ON VHFHAQ3.NodeID = VHFHAA3.NodeParentID
	left outer join [View_HFit_HealthAssesmentMultipleChoiceQuestion_Joined] as HAMCQ 
			on VHFHAQ.Nodeguid = HAMCQ.Nodeguid
			AND HAMCQ.DocumentCulture = 'en-US'
where VHFHAQ.DocumentCulture = 'en-us'	
		and (VHFHAA.DocumentCulture = 'en-us' OR VHFHAA.DocumentCulture is null)	--WDM 08.12.2014		
		and VHFHARCJ.DocumentCulture = 'en-us'	
		and VHFHARAJ.DocumentCulture = 'en-us'	
		and VHFHAMJ.DocumentCulture = 'en-us'	--WDM 08.12.2014	
		and HA.DocumentCulture = 'en-us'	--WDM 08.12.2014		

UNION ALL   --UNION
--WDM Retrieve Branching Level 1 Question and Matrix Level 2 Question Group
	SELECT distinct
		NULL as SiteGUID --cs.SiteGUID		--WDM 08.12.2014
		, NULL as AccountCD	 --, HFA.AccountCD												--WDM 08.07.2014
		, HA.NodeID		--WDM 08.07.2014
		, HA.NodeName		--WDM 08.07.2014
		, NULL AS HADocumentID		--WDM 08.07.2014
		, HA.NodeSiteID		--WDM 08.07.2014
       --,VCTJ.NodeAliasPath
		, HA.DocumentPublishedVersionHistoryID		--WDM 08.07.2014
		, VHFHAMJ.Title
		, dbo.udf_StripHTML(left(VHFHAMJ.IntroText,4000)) AS IntroText
		, VHFHAMJ.NodeGuid
		, VHFHAMJ.Weight
		, VHFHAMJ.IsEnabled
		, VHFHAMJ.CodeName
       --,VHFHAMJ.NodeAliasPath
		, VHFHAMJ.DocumentPublishedVersionHistoryID
		, VHFHARCJ.Title
		, VHFHARCJ.Weight
		, VHFHARCJ.NodeGuid
		, VHFHARCJ.IsEnabled
		, VHFHARCJ.CodeName
       --,VHFHARCJ.NodeAliasPath
		, VHFHARCJ.DocumentPublishedVersionHistoryID
		, VHFHARAJ.Title
		, VHFHARAJ.Weight
		, VHFHARAJ.NodeGuid
		, VHFHARAJ.IsEnabled
		, VHFHARAJ.CodeName
       --,VHFHARAJ.NodeAliasPath
		, VHFHARAJ.ScoringStrategyID
		, VHFHARAJ.DocumentPublishedVersionHistoryID
		, VHFHAQ7.QuestionType
		, dbo.udf_StripHTML(left(VHFHAQ7.Title,4000)) AS QuesTitle
		, VHFHAQ7.Weight
		, VHFHAQ7.IsRequired
		, VHFHAQ7.NodeGuid
		, VHFHAQ7.IsEnabled
		, left(VHFHAQ7.IsVisible,4000)
		, VHFHAQ7.IsStaging
		, VHFHAQ7.CodeName AS QuestionCodeName
       --,VHFHAQ7.NodeAliasPath
		, VHFHAQ7.DocumentPublishedVersionHistoryID
		, VHFHAA7.Value
		, VHFHAA7.Points
		, VHFHAA7.NodeGuid
		, VHFHAA7.IsEnabled
		, VHFHAA7.CodeName
		, VHFHAA7.UOM
       --,VHFHAA7.NodeAliasPath
		, VHFHAA7.DocumentPublishedVersionHistoryID
		, CASE	WHEN CAST(HA.DocumentCreatedWhen AS DATE) = CAST(HA.DocumentModifiedWhen AS DATE)
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		, HA.DocumentCreatedWhen
		, HA.DocumentModifiedWhen
		, HA.NodeGuid as CmsTreeNodeGuid	--WDM 08.07.2014
		, HA.NodeGUID as HANodeGUID
 
		, NULL as SiteLastModified
		, NULL as Account_ItemModifiedWhen
		--, c.DocumentModifiedWhen as Campaign_DocumentModifiedWhen
		, NULL as Campaign_DocumentModifiedWhen
		, HA.DocumentModifiedWhen as Assessment_DocumentModifiedWhen
		, VHFHAMJ.DocumentModifiedWhen as Module_DocumentModifiedWhen
		, VHFHARCJ.DocumentModifiedWhen as RiskCategory_DocumentModifiedWhen
		, VHFHARAJ.DocumentModifiedWhen as RiskArea_DocumentModifiedWhen
		, VHFHAQ.DocumentModifiedWhen as Question_DocumentModifiedWhen
		, VHFHAA.DocumentModifiedWhen as Answer_DocumentModifiedWhen
		, HAMCQ.AllowMultiSelect
FROM
 --dbo.View_CMS_Tree_Joined AS VCTJ
		--INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
		--INNER JOIN HFit_Account hfa WITH(NOLOCK) ON cs.SiteID = hfa.SiteID
 
		--Campaign links Client which links to Assessment
		--INNER JOIN dbo.View_HFit_HACampaign_Joined as c WITH(NOLOCK) ON VCTJ.NodeID = c.NodeParentID	--Note: 
 
View_HFit_HealthAssessment_Joined HA WITH (NOLOCK)
 INNER JOIN dbo.View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ ON HA.NodeID = VHFHAMJ.NodeParentID
 INNER JOIN dbo.View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
 INNER JOIN dbo.View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
 INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
 LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA ON VHFHAQ.NodeID = VHFHAA.NodeParentID

--matrix level 1 questiongroup
--INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ2 ON VHFHAQ.NodeID = VHFHAQ2.NodeParentID
--INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA2 ON VHFHAQ2.NodeID = VHFHAA2.NodeParentID

--Branching Level 1 Question 
	INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ3 ON VHFHAA.NodeID = VHFHAQ3.NodeParentID
--LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA3 ON VHFHAQ3.NodeID = VHFHAA3.NodeParentID

--Matrix Level 2 Question Group
	INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ7 ON VHFHAQ3.NodeID = VHFHAQ7.NodeParentID
	INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA7 ON VHFHAQ7.NodeID = VHFHAA7.NodeParentID
	left outer join [View_HFit_HealthAssesmentMultipleChoiceQuestion_Joined] as HAMCQ 
			on VHFHAQ.Nodeguid = HAMCQ.Nodeguid
			AND HAMCQ.DocumentCulture = 'en-US'
where VHFHAQ.DocumentCulture = 'en-us'	
		and (VHFHAA.DocumentCulture = 'en-us' OR VHFHAA.DocumentCulture is null)	--WDM 08.12.2014		
		and VHFHARCJ.DocumentCulture = 'en-us'	
		and VHFHARAJ.DocumentCulture = 'en-us'	
		and VHFHAMJ.DocumentCulture = 'en-us'	--WDM 08.12.2014	
		and HA.DocumentCulture = 'en-us'	--WDM 08.12.2014		

UNION ALL   --UNION
	--****************************************************
	--WDM 6/25/2014 Retrieve the Branching level 1 Question Group
	--THE PROBLEM LIES HERE in this part of query : 1:40 minute
	-- Added two perf indexes to the first query: 25 Sec
	--****************************************************
	SELECT distinct
		NULL as SiteGUID --cs.SiteGUID		--WDM 08.12.2014
		, NULL as AccountCD	 --, HFA.AccountCD												--WDM 08.07.2014
		, HA.NodeID		--WDM 08.07.2014
		, HA.NodeName		--WDM 08.07.2014
		, NULL AS HADocumentID		--WDM 08.07.2014
		, HA.NodeSiteID		--WDM 08.07.2014
       --,VCTJ.NodeAliasPath
		, HA.DocumentPublishedVersionHistoryID		--WDM 08.07.2014
		, VHFHAMJ.Title
		, dbo.udf_StripHTML(left(VHFHAMJ.IntroText,4000)) AS IntroText
		, VHFHAMJ.NodeGuid
		, VHFHAMJ.Weight
		, VHFHAMJ.IsEnabled
		, VHFHAMJ.CodeName
       --,VHFHAMJ.NodeAliasPath
		, VHFHAMJ.DocumentPublishedVersionHistoryID
		, VHFHARCJ.Title
		, VHFHARCJ.Weight
		, VHFHARCJ.NodeGuid
		, VHFHARCJ.IsEnabled
		, VHFHARCJ.CodeName
       --,VHFHARCJ.NodeAliasPath
		, VHFHARCJ.DocumentPublishedVersionHistoryID
		, VHFHARAJ.Title
		, VHFHARAJ.Weight
		, VHFHARAJ.NodeGuid
		, VHFHARAJ.IsEnabled
		, VHFHARAJ.CodeName
       --,VHFHARAJ.NodeAliasPath
		, VHFHARAJ.ScoringStrategyID
		, VHFHARAJ.DocumentPublishedVersionHistoryID
		, VHFHAQ8.QuestionType
		, dbo.udf_StripHTML(left(VHFHAQ8.Title,4000)) AS QuesTitle
		, VHFHAQ8.Weight
		, VHFHAQ8.IsRequired
		, VHFHAQ8.NodeGuid
		, VHFHAQ8.IsEnabled
		, left(VHFHAQ8.IsVisible,4000)
		, VHFHAQ8.IsStaging
		, VHFHAQ8.CodeName AS QuestionCodeName
       --,VHFHAQ8.NodeAliasPath
		, VHFHAQ8.DocumentPublishedVersionHistoryID
		, VHFHAA8.Value
		, VHFHAA8.Points
		, VHFHAA8.NodeGuid
		, VHFHAA8.IsEnabled
		, VHFHAA8.CodeName
		, VHFHAA8.UOM
       --,VHFHAA8.NodeAliasPath
		, VHFHAA8.DocumentPublishedVersionHistoryID
		, CASE	WHEN CAST(HA.DocumentCreatedWhen AS DATE) = CAST(HA.DocumentModifiedWhen AS DATE)
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		, HA.DocumentCreatedWhen
		, HA.DocumentModifiedWhen
		, HA.NodeGuid as CmsTreeNodeGuid	--WDM 08.07.2014
		, HA.NodeGUID as HANodeGUID
	
		, NULL as SiteLastModified
		, NULL as Account_ItemModifiedWhen
		--, c.DocumentModifiedWhen as Campaign_DocumentModifiedWhen
		, NULL as Campaign_DocumentModifiedWhen
		, HA.DocumentModifiedWhen as Assessment_DocumentModifiedWhen
		, VHFHAMJ.DocumentModifiedWhen as Module_DocumentModifiedWhen
		, VHFHARCJ.DocumentModifiedWhen as RiskCategory_DocumentModifiedWhen
		, VHFHARAJ.DocumentModifiedWhen as RiskArea_DocumentModifiedWhen
		, VHFHAQ.DocumentModifiedWhen as Question_DocumentModifiedWhen
		, VHFHAA.DocumentModifiedWhen as Answer_DocumentModifiedWhen
		, HAMCQ.AllowMultiSelect
FROM
 --dbo.View_CMS_Tree_Joined AS VCTJ
		--INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
		--INNER JOIN HFit_Account hfa WITH(NOLOCK) ON cs.SiteID = hfa.SiteID
 
		--Campaign links Client which links to Assessment
		--INNER JOIN dbo.View_HFit_HACampaign_Joined as c WITH(NOLOCK) ON VCTJ.NodeID = c.NodeParentID	--Note: 
 
View_HFit_HealthAssessment_Joined HA WITH (NOLOCK)
 INNER JOIN dbo.View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ ON HA.NodeID = VHFHAMJ.NodeParentID
 INNER JOIN dbo.View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
 INNER JOIN dbo.View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
 INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
 LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA ON VHFHAQ.NodeID = VHFHAA.NodeParentID

			--matrix level 1 questiongroup
			--INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ2 ON VHFHAQ.NodeID = VHFHAQ2.NodeParentID
			--INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA2 ON VHFHAQ2.NodeID = VHFHAA2.NodeParentID

			--Branching Level 1 Question 
			INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ3 ON VHFHAA.NodeID = VHFHAQ3.NodeParentID
			--LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA3 ON VHFHAQ3.NodeID = VHFHAA3.NodeParentID

			--Matrix Level 2 Question Group
			INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ7 ON VHFHAQ3.NodeID = VHFHAQ7.NodeParentID
			INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA7 ON VHFHAQ7.NodeID = VHFHAA7.NodeParentID

			--Matrix branching level 1 question group
			INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ8 ON VHFHAA7.NodeID = VHFHAQ8.NodeParentID
			INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA8 ON VHFHAQ8.NodeID = VHFHAA8.NodeParentID
			left outer join [View_HFit_HealthAssesmentMultipleChoiceQuestion_Joined] as HAMCQ 
			on VHFHAQ.Nodeguid = HAMCQ.Nodeguid
			AND HAMCQ.DocumentCulture = 'en-US'
where VHFHAQ.DocumentCulture = 'en-us'	
		and (VHFHAA.DocumentCulture = 'en-us' OR VHFHAA.DocumentCulture is null)	--WDM 08.12.2014		
		and VHFHARCJ.DocumentCulture = 'en-us'	
		and VHFHARAJ.DocumentCulture = 'en-us'	
		and VHFHAMJ.DocumentCulture = 'en-us'	--WDM 08.12.2014	
		and HA.DocumentCulture = 'en-us'	--WDM 08.12.2014		

UNION ALL   --UNION
	--****************************************************
	--WDM 6/25/2014 Retrieve the Branching level 2 Question Group
	--THE PROBLEM LIES HERE in this part of query : 1:48  minutes
	--With the new indexes: 29 Secs
	--****************************************************
	SELECT distinct
		NULL as SiteGUID --cs.SiteGUID		--WDM 08.12.2014
		, NULL as AccountCD	 --, HFA.AccountCD												--WDM 08.07.2014
		, HA.NodeID		--WDM 08.07.2014
		, HA.NodeName		--WDM 08.07.2014
		, NULL AS HADocumentID		--WDM 08.07.2014
		, HA.NodeSiteID		--WDM 08.07.2014
       --,VCTJ.NodeAliasPath
		, HA.DocumentPublishedVersionHistoryID		--WDM 08.07.2014
		, VHFHAMJ.Title
		, dbo.udf_StripHTML(left(VHFHAMJ.IntroText,4000)) AS IntroText
		, VHFHAMJ.NodeGuid
		, VHFHAMJ.Weight
		, VHFHAMJ.IsEnabled
		, VHFHAMJ.CodeName
       --,VHFHAMJ.NodeAliasPath
		, VHFHAMJ.DocumentPublishedVersionHistoryID
		, VHFHARCJ.Title
		, VHFHARCJ.Weight
		, VHFHARCJ.NodeGuid
		, VHFHARCJ.IsEnabled
		, VHFHARCJ.CodeName
       --,VHFHARCJ.NodeAliasPath
		, VHFHARCJ.DocumentPublishedVersionHistoryID
		, VHFHARAJ.Title
		, VHFHARAJ.Weight
		, VHFHARAJ.NodeGuid
		, VHFHARAJ.IsEnabled
		, VHFHARAJ.CodeName
       --,VHFHARAJ.NodeAliasPath
		, VHFHARAJ.ScoringStrategyID
		, VHFHARAJ.DocumentPublishedVersionHistoryID
		, VHFHAQ4.QuestionType
		, dbo.udf_StripHTML(left(VHFHAQ4.Title,4000)) AS QuesTitle
		, VHFHAQ4.Weight
		, VHFHAQ4.IsRequired
		, VHFHAQ4.NodeGuid
		, VHFHAQ4.IsEnabled
		, left(VHFHAQ4.IsVisible,4000)
		, VHFHAQ4.IsStaging
		, VHFHAQ4.CodeName AS QuestionCodeName
       --,VHFHAQ4.NodeAliasPath
		, VHFHAQ4.DocumentPublishedVersionHistoryID
		, VHFHAA4.Value
		, VHFHAA4.Points
		, VHFHAA4.NodeGuid
		, VHFHAA4.IsEnabled
		, VHFHAA4.CodeName
		, VHFHAA4.UOM
       --,VHFHAA4.NodeAliasPath
		, VHFHAA4.DocumentPublishedVersionHistoryID
		, CASE	WHEN CAST(HA.DocumentCreatedWhen AS DATE) = CAST(HA.DocumentModifiedWhen AS DATE)
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		, HA.DocumentCreatedWhen
		, HA.DocumentModifiedWhen
		, HA.NodeGuid as CmsTreeNodeGuid	--WDM 08.07.2014
		, HA.NodeGUID as HANodeGUID
 
		, NULL as SiteLastModified
		, NULL as Account_ItemModifiedWhen
		--, c.DocumentModifiedWhen as Campaign_DocumentModifiedWhen
		, NULL as Campaign_DocumentModifiedWhen
		, HA.DocumentModifiedWhen as Assessment_DocumentModifiedWhen
		, VHFHAMJ.DocumentModifiedWhen as Module_DocumentModifiedWhen
		, VHFHARCJ.DocumentModifiedWhen as RiskCategory_DocumentModifiedWhen
		, VHFHARAJ.DocumentModifiedWhen as RiskArea_DocumentModifiedWhen
		, VHFHAQ.DocumentModifiedWhen as Question_DocumentModifiedWhen
		, VHFHAA.DocumentModifiedWhen as Answer_DocumentModifiedWhen
		, HAMCQ.AllowMultiSelect
FROM
 --dbo.View_CMS_Tree_Joined AS VCTJ
		--INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
		--INNER JOIN HFit_Account hfa WITH(NOLOCK) ON cs.SiteID = hfa.SiteID
 
		--Campaign links Client which links to Assessment
		--INNER JOIN dbo.View_HFit_HACampaign_Joined as c WITH(NOLOCK) ON VCTJ.NodeID = c.NodeParentID	--Note: 
 
View_HFit_HealthAssessment_Joined HA WITH (NOLOCK) 
 INNER JOIN dbo.View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ ON HA.NodeID = VHFHAMJ.NodeParentID
 INNER JOIN dbo.View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
 INNER JOIN dbo.View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
 INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
 LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA ON VHFHAQ.NodeID = VHFHAA.NodeParentID

			--matrix level 1 questiongroup
			--INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ2 ON VHFHAQ.NodeID = VHFHAQ2.NodeParentID
			--INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA2 ON VHFHAQ2.NodeID = VHFHAA2.NodeParentID

			--Branching Level 1 Question 
			INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ3 ON VHFHAA.NodeID = VHFHAQ3.NodeParentID
			LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA3 ON VHFHAQ3.NodeID = VHFHAA3.NodeParentID

			--Matrix Level 2 Question Group
			--INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ7 ON VHFHAQ3.NodeID = VHFHAQ7.NodeParentID
			--INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA7 ON VHFHAQ7.NodeID = VHFHAA7.NodeParentID

			--Matrix branching level 1 question group
			--INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ8 ON VHFHAA7.NodeID = VHFHAQ8.NodeParentID
			--INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA8 ON VHFHAQ8.NodeID = VHFHAA8.NodeParentID

			--Branching level 2 Question Group
			INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ4 ON VHFHAA3.NodeID = VHFHAQ4.NodeParentID
			INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA4 ON VHFHAQ4.NodeID = VHFHAA4.NodeParentID
			left outer join [View_HFit_HealthAssesmentMultipleChoiceQuestion_Joined] as HAMCQ 
			on VHFHAQ.Nodeguid = HAMCQ.Nodeguid
			AND HAMCQ.DocumentCulture = 'en-US'
where VHFHAQ.DocumentCulture = 'en-us'	
		and (VHFHAA.DocumentCulture = 'en-us' OR VHFHAA.DocumentCulture is null)	--WDM 08.12.2014		
		and VHFHARCJ.DocumentCulture = 'en-us'	
		and VHFHARAJ.DocumentCulture = 'en-us'	
		and VHFHAMJ.DocumentCulture = 'en-us'	--WDM 08.12.2014	
		and HA.DocumentCulture = 'en-us'	--WDM 08.12.2014		

UNION ALL   --UNION
--WDM 6/25/2014 Retrieve the Branching level 3 Question Group
	SELECT distinct
		NULL as SiteGUID --cs.SiteGUID		--WDM 08.12.2014
		, NULL as AccountCD	 --, HFA.AccountCD												--WDM 08.07.2014
		, HA.NodeID		--WDM 08.07.2014
		, HA.NodeName		--WDM 08.07.2014
		, NULL AS HADocumentID		--WDM 08.07.2014
		, HA.NodeSiteID		--WDM 08.07.2014
       --,VCTJ.NodeAliasPath
		, HA.DocumentPublishedVersionHistoryID		--WDM 08.07.2014
		, VHFHAMJ.Title
		, dbo.udf_StripHTML(left(VHFHAMJ.IntroText,4000)) AS IntroText
		, VHFHAMJ.NodeGuid
		, VHFHAMJ.Weight
		, VHFHAMJ.IsEnabled
		, VHFHAMJ.CodeName
       --,VHFHAMJ.NodeAliasPath
		, VHFHAMJ.DocumentPublishedVersionHistoryID
		, VHFHARCJ.Title
		, VHFHARCJ.Weight
		, VHFHARCJ.NodeGuid
		, VHFHARCJ.IsEnabled
		, VHFHARCJ.CodeName
       --,VHFHARCJ.NodeAliasPath
		, VHFHARCJ.DocumentPublishedVersionHistoryID
		, VHFHARAJ.Title
		, VHFHARAJ.Weight
		, VHFHARAJ.NodeGuid
		, VHFHARAJ.IsEnabled
		, VHFHARAJ.CodeName
       --,VHFHARAJ.NodeAliasPath
		, VHFHARAJ.ScoringStrategyID
		, VHFHARAJ.DocumentPublishedVersionHistoryID
		, VHFHAQ5.QuestionType
		, dbo.udf_StripHTML(left(VHFHAQ5.Title,4000)) AS QuesTitle
		, VHFHAQ5.Weight
		, VHFHAQ5.IsRequired
		, VHFHAQ5.NodeGuid
		, VHFHAQ5.IsEnabled
		, left(VHFHAQ5.IsVisible,4000)
		, VHFHAQ5.IsStaging
		, VHFHAQ5.CodeName AS QuestionCodeName
       --,VHFHAQ5.NodeAliasPath
		, VHFHAQ5.DocumentPublishedVersionHistoryID
		, VHFHAA5.Value
		, VHFHAA5.Points
		, VHFHAA5.NodeGuid
		, VHFHAA5.IsEnabled
		, VHFHAA5.CodeName
		, VHFHAA5.UOM
       --,VHFHAA5.NodeAliasPath
		, VHFHAA5.DocumentPublishedVersionHistoryID
		, CASE	WHEN CAST(HA.DocumentCreatedWhen AS DATE) = CAST(HA.DocumentModifiedWhen AS DATE)
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		, HA.DocumentCreatedWhen
		, HA.DocumentModifiedWhen
		, HA.NodeGuid as CmsTreeNodeGuid	--WDM 08.07.2014
		, HA.NodeGUID as HANodeGUID
 
		, NULL as SiteLastModified
		, NULL as Account_ItemModifiedWhen
		--, c.DocumentModifiedWhen as Campaign_DocumentModifiedWhen
		, NULL as Campaign_DocumentModifiedWhen
		, HA.DocumentModifiedWhen as Assessment_DocumentModifiedWhen
		, VHFHAMJ.DocumentModifiedWhen as Module_DocumentModifiedWhen
		, VHFHARCJ.DocumentModifiedWhen as RiskCategory_DocumentModifiedWhen
		, VHFHARAJ.DocumentModifiedWhen as RiskArea_DocumentModifiedWhen
		, VHFHAQ.DocumentModifiedWhen as Question_DocumentModifiedWhen
		, VHFHAA.DocumentModifiedWhen as Answer_DocumentModifiedWhen
		, HAMCQ.AllowMultiSelect
FROM
--dbo.View_CMS_Tree_Joined AS VCTJ
		--INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
		--INNER JOIN HFit_Account hfa WITH(NOLOCK) ON cs.SiteID = hfa.SiteID
 
		--Campaign links Client which links to Assessment
		--INNER JOIN dbo.View_HFit_HACampaign_Joined as c WITH(NOLOCK) ON VCTJ.NodeID = c.NodeParentID	--Note: 
 
View_HFit_HealthAssessment_Joined HA WITH (NOLOCK)  
 INNER JOIN dbo.View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ ON HA.NodeID = VHFHAMJ.NodeParentID
 INNER JOIN dbo.View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
 INNER JOIN dbo.View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
 INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
 LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA ON VHFHAQ.NodeID = VHFHAA.NodeParentID

		--matrix level 1 questiongroup
		--INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ2 ON VHFHAQ.NodeID = VHFHAQ2.NodeParentID
		--INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA2 ON VHFHAQ2.NodeID = VHFHAA2.NodeParentID

		--Branching Level 1 Question 
		INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ3 ON VHFHAA.NodeID = VHFHAQ3.NodeParentID
		LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA3 ON VHFHAQ3.NodeID = VHFHAA3.NodeParentID

		--Matrix Level 2 Question Group
		--INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ7 ON VHFHAQ3.NodeID = VHFHAQ7.NodeParentID
		--INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA7 ON VHFHAQ7.NodeID = VHFHAA7.NodeParentID

		--Matrix branching level 1 question group
		--INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ8 ON VHFHAA7.NodeID = VHFHAQ8.NodeParentID
		--INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA8 ON VHFHAQ8.NodeID = VHFHAA8.NodeParentID

		--Branching level 2 Question Group
		INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ4 ON VHFHAA3.NodeID = VHFHAQ4.NodeParentID
		INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA4 ON VHFHAQ4.NodeID = VHFHAA4.NodeParentID

		--Branching level 3 Question Group
		INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ5 ON VHFHAA4.NodeID = VHFHAQ5.NodeParentID
		INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA5 ON VHFHAQ5.NodeID = VHFHAA5.NodeParentID
		left outer join [View_HFit_HealthAssesmentMultipleChoiceQuestion_Joined] as HAMCQ 
			on VHFHAQ.Nodeguid = HAMCQ.Nodeguid
			AND HAMCQ.DocumentCulture = 'en-US'
where VHFHAQ.DocumentCulture = 'en-us'	
		and (VHFHAA.DocumentCulture = 'en-us' OR VHFHAA.DocumentCulture is null)	--WDM 08.12.2014		
		and VHFHARCJ.DocumentCulture = 'en-us'	
		and VHFHARAJ.DocumentCulture = 'en-us'	
		and VHFHAMJ.DocumentCulture = 'en-us'	--WDM 08.12.2014	
		and HA.DocumentCulture = 'en-us'	--WDM 08.12.2014		

UNION ALL   --UNION
--WDM 6/25/2014 Retrieve the Branching level 4 Question Group
	SELECT distinct
		NULL as SiteGUID --cs.SiteGUID		--WDM 08.12.2014
		, NULL as AccountCD	 --, HFA.AccountCD												--WDM 08.07.2014
		, HA.NodeID		--WDM 08.07.2014
		, HA.NodeName		--WDM 08.07.2014
		, NULL AS HADocumentID		--WDM 08.07.2014
		, HA.NodeSiteID		--WDM 08.07.2014
       --,VCTJ.NodeAliasPath
		, HA.DocumentPublishedVersionHistoryID		--WDM 08.07.2014
		, VHFHAMJ.Title
		, dbo.udf_StripHTML(left(VHFHAMJ.IntroText,4000)) AS IntroText
		, VHFHAMJ.NodeGuid
		, VHFHAMJ.Weight
		, VHFHAMJ.IsEnabled
		, VHFHAMJ.CodeName
       --,VHFHAMJ.NodeAliasPath
		, VHFHAMJ.DocumentPublishedVersionHistoryID
		, VHFHARCJ.Title
		, VHFHARCJ.Weight
		, VHFHARCJ.NodeGuid
		, VHFHARCJ.IsEnabled
		, VHFHARCJ.CodeName
       --,VHFHARCJ.NodeAliasPath
		, VHFHARCJ.DocumentPublishedVersionHistoryID
		, VHFHARAJ.Title
		, VHFHARAJ.Weight
		, VHFHARAJ.NodeGuid
		, VHFHARAJ.IsEnabled
		, VHFHARAJ.CodeName
       --,VHFHARAJ.NodeAliasPath
		, VHFHARAJ.ScoringStrategyID
		, VHFHARAJ.DocumentPublishedVersionHistoryID
		, VHFHAQ6.QuestionType
		, dbo.udf_StripHTML(left(VHFHAQ6.Title,4000)) AS QuesTitle
		, VHFHAQ6.Weight
		, VHFHAQ6.IsRequired
		, VHFHAQ6.NodeGuid
		, VHFHAQ6.IsEnabled
		, left(VHFHAQ6.IsVisible,4000)
		, VHFHAQ6.IsStaging
		, VHFHAQ6.CodeName AS QuestionCodeName
       --,VHFHAQ6.NodeAliasPath
		, VHFHAQ6.DocumentPublishedVersionHistoryID
		, VHFHAA6.Value
		, VHFHAA6.Points
		, VHFHAA6.NodeGuid
		, VHFHAA6.IsEnabled
		, VHFHAA6.CodeName
		, VHFHAA6.UOM
       --,VHFHAA6.NodeAliasPath
		, VHFHAA6.DocumentPublishedVersionHistoryID
		, CASE	WHEN CAST(HA.DocumentCreatedWhen AS DATE) = CAST(HA.DocumentModifiedWhen AS DATE)
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		, HA.DocumentCreatedWhen
		, HA.DocumentModifiedWhen
		, HA.NodeGuid as CmsTreeNodeGuid	--WDM 08.07.2014
		, HA.NodeGUID as HANodeGUID
 
		, NULL as SiteLastModified
		, NULL as Account_ItemModifiedWhen
		--, c.DocumentModifiedWhen as Campaign_DocumentModifiedWhen
		, NULL as Campaign_DocumentModifiedWhen
		, HA.DocumentModifiedWhen as Assessment_DocumentModifiedWhen
		, VHFHAMJ.DocumentModifiedWhen as Module_DocumentModifiedWhen
		, VHFHARCJ.DocumentModifiedWhen as RiskCategory_DocumentModifiedWhen
		, VHFHARAJ.DocumentModifiedWhen as RiskArea_DocumentModifiedWhen
		, VHFHAQ.DocumentModifiedWhen as Question_DocumentModifiedWhen
		, VHFHAA.DocumentModifiedWhen as Answer_DocumentModifiedWhen
		, HAMCQ.AllowMultiSelect
FROM
  --dbo.View_CMS_Tree_Joined AS VCTJ
		--INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
		--INNER JOIN HFit_Account hfa WITH(NOLOCK) ON cs.SiteID = hfa.SiteID
 
		--Campaign links Client which links to Assessment
		--INNER JOIN dbo.View_HFit_HACampaign_Joined as c WITH(NOLOCK) ON VCTJ.NodeID = c.NodeParentID	--Note: 
 
View_HFit_HealthAssessment_Joined HA WITH (NOLOCK) 
 INNER JOIN dbo.View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ ON HA.NodeID = VHFHAMJ.NodeParentID
 INNER JOIN dbo.View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
 INNER JOIN dbo.View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
 INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
 LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA ON VHFHAQ.NodeID = VHFHAA.NodeParentID

		--matrix level 1 questiongroup
		--INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ2 ON VHFHAQ.NodeID = VHFHAQ2.NodeParentID
		--INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA2 ON VHFHAQ2.NodeID = VHFHAA2.NodeParentID

		--Branching Level 1 Question 
		INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ3 ON VHFHAA.NodeID = VHFHAQ3.NodeParentID
		LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA3 ON VHFHAQ3.NodeID = VHFHAA3.NodeParentID

		--Matrix Level 2 Question Group
		--INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ7 ON VHFHAQ3.NodeID = VHFHAQ7.NodeParentID
		--INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA7 ON VHFHAQ7.NodeID = VHFHAA7.NodeParentID

		--Matrix branching level 1 question group
		--INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ8 ON VHFHAA7.NodeID = VHFHAQ8.NodeParentID
		--INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA8 ON VHFHAQ8.NodeID = VHFHAA8.NodeParentID

		--Branching level 2 Question Group
		INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ4 ON VHFHAA3.NodeID = VHFHAQ4.NodeParentID
		INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA4 ON VHFHAQ4.NodeID = VHFHAA4.NodeParentID

		--Branching level 3 Question Group
		--select count(*) from dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA4
		INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ5 ON VHFHAA4.NodeID = VHFHAQ5.NodeParentID
		INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA5 ON VHFHAQ5.NodeID = VHFHAA5.NodeParentID

		--Branching level 4 Question Group
		INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ6 ON VHFHAA5.NodeID = VHFHAQ6.NodeParentID
		INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA6 ON VHFHAQ6.NodeID = VHFHAA6.NodeParentID
		left outer join [View_HFit_HealthAssesmentMultipleChoiceQuestion_Joined] as HAMCQ 
			on VHFHAQ.Nodeguid = HAMCQ.Nodeguid
			AND HAMCQ.DocumentCulture = 'en-US'
where  VHFHAQ.DocumentCulture = 'en-us'	
		and (VHFHAA.DocumentCulture = 'en-us' OR VHFHAA.DocumentCulture is null)	--WDM 08.12.2014		
		and VHFHARCJ.DocumentCulture = 'en-us'	
		and VHFHARAJ.DocumentCulture = 'en-us'	
		and VHFHAMJ.DocumentCulture = 'en-us'	--WDM 08.12.2014	
		and HA.DocumentCulture = 'en-us'	--WDM 08.12.2014		

UNION ALL   --UNION
	--WDM 6/25/2014 Retrieve the Branching level 5 Question Group
	SELECT distinct
		NULL as SiteGUID --cs.SiteGUID		--WDM 08.12.2014
		, NULL as AccountCD	 --, HFA.AccountCD												--WDM 08.07.2014
		, HA.NodeID		--WDM 08.07.2014
		, HA.NodeName		--WDM 08.07.2014
		, NULL AS HADocumentID		--WDM 08.07.2014
		, HA.NodeSiteID		--WDM 08.07.2014
       --,VCTJ.NodeAliasPath
		, HA.DocumentPublishedVersionHistoryID		--WDM 08.07.2014
		, VHFHAMJ.Title
		, dbo.udf_StripHTML(left(VHFHAMJ.IntroText,4000)) AS IntroText
		, VHFHAMJ.NodeGuid
		, VHFHAMJ.Weight
		, VHFHAMJ.IsEnabled
		, VHFHAMJ.CodeName
       --,VHFHAMJ.NodeAliasPath
		, VHFHAMJ.DocumentPublishedVersionHistoryID
		, VHFHARCJ.Title
		, VHFHARCJ.Weight
		, VHFHARCJ.NodeGuid
		, VHFHARCJ.IsEnabled
		, VHFHARCJ.CodeName
       --,VHFHARCJ.NodeAliasPath
		, VHFHARCJ.DocumentPublishedVersionHistoryID
		, VHFHARAJ.Title
		, VHFHARAJ.Weight
		, VHFHARAJ.NodeGuid
		, VHFHARAJ.IsEnabled
		, VHFHARAJ.CodeName
       --,VHFHARAJ.NodeAliasPath
		, VHFHARAJ.ScoringStrategyID
		, VHFHARAJ.DocumentPublishedVersionHistoryID
		, VHFHAQ9.QuestionType
		, dbo.udf_StripHTML(left(VHFHAQ9.Title,4000)) AS QuesTitle
		, VHFHAQ9.Weight
		, VHFHAQ9.IsRequired
		, VHFHAQ9.NodeGuid
		, VHFHAQ9.IsEnabled
		, left(VHFHAQ9.IsVisible,4000)
		, VHFHAQ9.IsStaging
		, VHFHAQ9.CodeName AS QuestionCodeName
       --,VHFHAQ9.NodeAliasPath
		, VHFHAQ9.DocumentPublishedVersionHistoryID
		, VHFHAA9.Value
		, VHFHAA9.Points
		, VHFHAA9.NodeGuid
		, VHFHAA9.IsEnabled
		, VHFHAA9.CodeName
		, VHFHAA9.UOM
       --,VHFHAA9.NodeAliasPath
		, VHFHAA9.DocumentPublishedVersionHistoryID
		, CASE	WHEN CAST(HA.DocumentCreatedWhen AS DATE) = CAST(HA.DocumentModifiedWhen AS DATE)
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		, HA.DocumentCreatedWhen
		, HA.DocumentModifiedWhen
		, HA.NodeGuid as CmsTreeNodeGuid	--WDM 08.07.2014
		, HA.NodeGUID as HANodeGUID
 
		, NULL as SiteLastModified
		, NULL as Account_ItemModifiedWhen
		--, c.DocumentModifiedWhen as Campaign_DocumentModifiedWhen
		, NULL as Campaign_DocumentModifiedWhen
		, HA.DocumentModifiedWhen as Assessment_DocumentModifiedWhen
		, VHFHAMJ.DocumentModifiedWhen as Module_DocumentModifiedWhen
		, VHFHARCJ.DocumentModifiedWhen as RiskCategory_DocumentModifiedWhen
		, VHFHARAJ.DocumentModifiedWhen as RiskArea_DocumentModifiedWhen
		, VHFHAQ.DocumentModifiedWhen as Question_DocumentModifiedWhen
		, VHFHAA.DocumentModifiedWhen as Answer_DocumentModifiedWhen
		, HAMCQ.AllowMultiSelect
FROM

--dbo.View_CMS_Tree_Joined AS VCTJ
		--INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
		--INNER JOIN HFit_Account hfa WITH(NOLOCK) ON cs.SiteID = hfa.SiteID
 
		--Campaign links Client which links to Assessment
		--INNER JOIN dbo.View_HFit_HACampaign_Joined as c WITH(NOLOCK) ON VCTJ.NodeID = c.NodeParentID	--Note: 
 
View_HFit_HealthAssessment_Joined HA WITH (NOLOCK) 
 INNER JOIN dbo.View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ ON HA.NodeID = VHFHAMJ.NodeParentID
 INNER JOIN dbo.View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
 INNER JOIN dbo.View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
 INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
 LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA ON VHFHAQ.NodeID = VHFHAA.NodeParentID

		--matrix level 1 questiongroup
		--INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ2 ON VHFHAQ.NodeID = VHFHAQ2.NodeParentID
		--INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA2 ON VHFHAQ2.NodeID = VHFHAA2.NodeParentID

		--Branching Level 1 Question 
		INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ3 ON VHFHAA.NodeID = VHFHAQ3.NodeParentID
		LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA3 ON VHFHAQ3.NodeID = VHFHAA3.NodeParentID

		--Matrix Level 2 Question Group
		--INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ7 ON VHFHAQ3.NodeID = VHFHAQ7.NodeParentID
		--INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA7 ON VHFHAQ7.NodeID = VHFHAA7.NodeParentID

		--Matrix branching level 1 question group
		--INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ8 ON VHFHAA7.NodeID = VHFHAQ8.NodeParentID
		--INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA8 ON VHFHAQ8.NodeID = VHFHAA8.NodeParentID

		--Branching level 2 Question Group
		INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ4 ON VHFHAA3.NodeID = VHFHAQ4.NodeParentID
		INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA4 ON VHFHAQ4.NodeID = VHFHAA4.NodeParentID

		--Branching level 3 Question Group
		--select count(*) from dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA4
		INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ5 ON VHFHAA4.NodeID = VHFHAQ5.NodeParentID
		INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA5 ON VHFHAQ5.NodeID = VHFHAA5.NodeParentID

		--Branching level 4 Question Group
		INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ6 ON VHFHAA5.NodeID = VHFHAQ6.NodeParentID
		INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA6 ON VHFHAQ6.NodeID = VHFHAA6.NodeParentID

		--Branching level 5 Question Group
		INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ9 ON VHFHAA6.NodeID = VHFHAQ9.NodeParentID
		INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA9 ON VHFHAQ9.NodeID = VHFHAA9.NodeParentID
		left outer join [View_HFit_HealthAssesmentMultipleChoiceQuestion_Joined] as HAMCQ 
			on VHFHAQ.Nodeguid = HAMCQ.Nodeguid
			AND HAMCQ.DocumentCulture = 'en-US'
	where  VHFHAQ.DocumentCulture = 'en-us'	
		and (VHFHAA.DocumentCulture = 'en-us' OR VHFHAA.DocumentCulture is null)	--WDM 08.12.2014		
		and VHFHARCJ.DocumentCulture = 'en-us'	
		and VHFHARAJ.DocumentCulture = 'en-us'	
		and VHFHAMJ.DocumentCulture = 'en-us'	--WDM 08.12.2014	
		and HA.DocumentCulture = 'en-us'	--WDM 08.12.2014		
GO

print ('Processed: view_EDW_HealthAssesmentDeffinition ') ;
go
  --  
  --  
GO 
print('***** FROM: view_EDW_HADefinition_MultiSelect.sql'); 
GO 
