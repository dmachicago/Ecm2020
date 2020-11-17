
GO

--CREATE VIEW [dbo].[View_CMS_Tree_Joined_Regular] 
--as
SELECT distinct top 10 CMSCLASS.ClassName, CMSCLASS.*		
FROM dbo.CMS_Tree CMSTREE 
	INNER JOIN dbo.CMS_Class CMSCLASS ON CMSTREE.NodeClassID = CMSCLASS.ClassID

GO


  --  
  --  
GO 
print('***** FROM: HFIT_GetClassData.sql'); 
GO 
