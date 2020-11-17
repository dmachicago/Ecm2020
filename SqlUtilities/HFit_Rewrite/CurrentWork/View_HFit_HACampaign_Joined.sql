
/****** Object:  View [dbo].[View_HFit_HACampaign_Joined]    Script Date: 7/16/2014 7:48:09 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

alter VIEW [dbo].[View_HFit_HACampaign_Joined] AS 
SELECT View_CMS_Tree_Joined.*, HFit_HACampaign.* 
FROM View_CMS_Tree_Joined INNER JOIN HFit_HACampaign 
	ON View_CMS_Tree_Joined.DocumentForeignKeyValue = HFit_HACampaign.[HACampaignID] 
WHERE (ClassName = 'HFit.HACampaign')
GO

  --  
  --  
GO 
print('***** FROM: View_HFit_HACampaign_Joined.sql'); 
GO 
