USE [KenticoCMS_DEV]
GO

SELECT distinct top 10 DOCUMENT.[DocumentID], DOCUMENT.[DocumentName], DOCUMENT.*		
FROM dbo.CMS_Tree CMSTREE 
	INNER JOIN dbo.CMS_Document DOCUMENT ON CMSTREE.NodeID = DOCUMENT.DocumentNodeID 

GO



-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
