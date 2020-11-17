--HFitSiteAcctBySiteID
select distinct SITEMSTR.SiteName, SITEMSTR.SiteGuid, SITEMSTR.SiteID, ACCT.AccountName, ACCT.AccountCD
FROM
 dbo.View_CMS_Tree_Joined AS SITETREE
 INNER JOIN dbo.CMS_Site AS SITEMSTR ON SITETREE.NodeSiteID = SITEMSTR.SiteID
 INNER JOIN HFit_Account ACCT WITH(NOLOCK) ON SITEMSTR.SiteID = ACCT.SiteID
 
 INNER JOIN dbo.View_HFit_HACampaign_Joined c WITH(NOLOCK) ON SITETREE.NodeID = c.NodeParentID
 INNER JOIN View_HFit_HealthAssessment_Joined ha WITH (NOLOCK) ON c.HealthAssessmentID = ha.DocumentID
 INNER JOIN dbo.View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ ON ha.NodeID = VHFHAMJ.NodeParentID
 INNER JOIN dbo.View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
 INNER JOIN dbo.View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
 INNER JOIN dbo.View_HFit_HealthAssesmentQuestions AS VHFHAQ ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
 LEFT OUTER JOIN dbo.View_HFit_HealthAssesmentAnswers AS VHFHAA ON VHFHAQ.NodeID = VHFHAA.NodeParentID