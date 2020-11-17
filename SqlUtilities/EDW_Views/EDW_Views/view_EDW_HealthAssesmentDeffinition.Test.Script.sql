
select *
from 
 dbo.View_CMS_Tree_Joined AS VCTJ
 INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
 INNER JOIN HFit_Account hfa WITH(NOLOCK) ON cs.SiteID = hfa.SiteID
 --INNER JOIN dbo.View_HFit_HACampaign_Joined c WITH(NOLOCK) ON VCTJ.NodeID = c.NodeParentID
 --INNER JOIN View_HFit_HealthAssessment_Joined ha WITH (NOLOCK) ON c.HealthAssessmentID = ha.DocumentID
 --INNER JOIN View_HFit_HealthAssessment_Joined ha WITH (NOLOCK) ON  VCTJ.[NodeID] = ha.NodeID
 INNER JOIN View_HFit_HealthAssessment_Joined ha WITH (NOLOCK) ON  VCTJ.[NodeID] = ha.NodeParentID

 INNER JOIN dbo.View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ ON ha.NodeID = VHFHAMJ.NodeParentID
 INNER JOIN dbo.View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
 INNER JOIN dbo.View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
 INNER JOIN dbo.View_HFit_HealthAssesmentQuestions AS VHFHAQ ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
 --LEFT OUTER JOIN dbo.View_HFit_HealthAssesmentAnswers AS VHFHAA ON VHFHAQ.NodeID = VHFHAA.NodeParentID
 inner JOIN dbo.View_HFit_HealthAssesmentAnswers AS VHFHAA ON VHFHAQ.NodeID = VHFHAA.NodeParentID

  --  
  --  
GO 
print('***** FROM: view_EDW_HealthAssesmentDeffinition.Test.Script.sql'); 
GO 
