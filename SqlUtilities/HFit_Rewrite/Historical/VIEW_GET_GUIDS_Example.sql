--HARiskCategoryNodeGUID **
--HARiskAreaNodeGUID **
--HAQuestionNodeGUID **
--HAModuleNodeGUID **


SELECT distinct CMSTREE1.NodeGUID AS QuestionNodeGuid, CMSDOC1.DocumentID, CMSDOC1.DocumentNodeID
FROM     HFit_HealthAssesmentUserQuestion AS USERQUES 
		INNER JOIN CMS_Document AS CMSDOC1 ON USERQUES.HAQuestionDocumentID = CMSDOC1.DocumentID 
		INNER JOIN CMS_Tree AS CMSTREE1 ON CMSDOC1.DocumentNodeID = CMSTREE1.NodeID 

SELECT distinct CMSTREE2.NodeGUID AS RiskAreaNodeGuid,CMSDOC2.DocumentID, CMSDOC2.DocumentNodeID 
FROM     HFit_HealthAssesmentUserQuestion AS USERQUES 		
		INNER JOIN HFit_HealthAssesmentUserRiskArea AS RISKAREA ON USERQUES.HARiskAreaItemID = RISKAREA.ItemID 
		INNER JOIN CMS_Document AS CMSDOC2 ON RISKAREA.HARiskAreaDocumentID = CMSDOC2.DocumentID 
		INNER JOIN CMS_Tree AS CMSTREE2 ON CMSDOC2.DocumentNodeID = CMSTREE2.NodeID
		

Select distinct CMSTREE2.NodeGuid as HAModuleNodeGUID, CMSDOC3.DocumentID, CMSDOC3.DocumentNodeID 
from	HFit_HealthAssesmentUserModule USERMOD
inner join cms_document CMSDOC3 on USERMOD.HAModuleDocumentID = CMSDOC3.DocumentID
inner join cms_tree CMSTREE2 on CMSDOC3.DocumentNodeID = CMSTREE2.NodeID


Select distinct CMSTREE2.NodeGuid as HARiskCategoryNodeGUID, CMSDOC3.DocumentID, CMSDOC3.DocumentNodeID 
from	HFit_HealthAssesmentUserRiskCategory RISKCAT
inner join cms_document CMSDOC3 on RISKCAT.HARiskCategoryDocumentID = CMSDOC3.DocumentID
inner join cms_tree CMSTREE2 on CMSDOC3.DocumentNodeID = CMSTREE2.NodeID
