USE [KenticoCMS_DEV]
GO

--CREATE VIEW [dbo].[View_CMS_Tree_Joined_Regular] 
--as
SELECT distinct top 10 SITE.SiteName, SITE.*
FROM dbo.CMS_Tree CMSTREE 
	INNER JOIN dbo.CMS_Site SITE ON CMSTREE.NodeSiteID = SITE.SiteID 
	


-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
