create view view_CMS_Tree_Joined_BaseLine
as
SELECT SITE.SiteName, CLASS.ClassName, CLASS.ClassDisplayName, CTREE.NodeID, DOC.DocumentID, DOC.DocumentNodeID, DOC.DocumentGUID, 
	CTREE.NodeGUID
FROM     CMS_Tree AS CTREE INNER JOIN
                  CMS_Document AS DOC ON CTREE.NodeID = DOC.DocumentNodeID 
				  INNER JOIN CMS_Site AS SITE ON CTREE.NodeSiteID = SITE.SiteID 
				  INNER JOIN CMS_Class AS CLASS ON CTREE.NodeClassID = CLASS.ClassID
UNION ALL
SELECT SITE.SiteName, CLASS.ClassName, CLASS.ClassDisplayName, CTREE.NodeID, DOC.DocumentID, DOC.DocumentNodeID, DOC.DocumentGUID, 
	CTREE.NodeGUID
FROM dbo.CMS_Tree CTREE INNER JOIN 
	dbo.CMS_Document DOC ON CTREE.NodeLinkedNodeID = DOC.DocumentNodeID 
	INNER JOIN dbo.CMS_Site SITE ON CTREE.NodeSiteID = SITE.SiteID 
	INNER JOIN dbo.CMS_Class CLASS ON CTREE.NodeClassID = CLASS.ClassID

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
