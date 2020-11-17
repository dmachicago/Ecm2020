
GO

SELECT distinct top 10 DOCUMENT.[DocumentID], DOCUMENT.[DocumentName], DOCUMENT.*		
FROM dbo.CMS_Tree CMSTREE 
	INNER JOIN dbo.CMS_Document DOCUMENT ON CMSTREE.NodeID = DOCUMENT.DocumentNodeID 

GO


  --  
  --  
GO 
print('***** FROM: HFIT_GetDocumentData.sql'); 
GO 
