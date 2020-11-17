--HFitSiteAcctBySiteID
select distinct SITE.SiteName, SITE.SiteGuid, SITE.SiteID, ACCT.AccountName, ACCT.AccountCD
FROM
 dbo.View_CMS_Tree_Joined AS TREE
 INNER JOIN dbo.CMS_Site AS SITE WITH(NOLOCK)  
	ON TREE.NodeSiteID = SITE.SiteID
 INNER JOIN HFit_Account as ACCT WITH(NOLOCK) 
	ON SITE.SiteID = ACCT.SiteID
 
 INNER JOIN dbo.View_HFit_HACampaign_Joined c WITH(NOLOCK) ON TREE.NodeID = c.NodeParentID
 INNER JOIN View_HFit_HealthAssessment_Joined ha WITH (NOLOCK) ON c.HealthAssessmentID = ha.DocumentID
 INNER JOIN dbo.View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ ON ha.NodeID = VHFHAMJ.NodeParentID
 INNER JOIN dbo.View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
 INNER JOIN dbo.View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
 INNER JOIN dbo.View_HFit_HealthAssesmentQuestions AS VHFHAQ ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
 LEFT OUTER JOIN dbo.View_HFit_HealthAssesmentAnswers AS VHFHAA ON VHFHAQ.NodeID = VHFHAA.NodeParentID
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
