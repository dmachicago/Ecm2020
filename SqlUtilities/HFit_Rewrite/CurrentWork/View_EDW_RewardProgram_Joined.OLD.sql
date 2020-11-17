USE [KenticoCMS_PRD_prod3K7]
GO

/****** Object:  View [dbo].[View_EDW_RewardProgram_Joined]    Script Date: 5/13/2015 10:01:25 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


--This view is created in place of View_Hfit_RewardProgram_Joined so that 
--Document Culture can be taken into consideration. 
CREATE VIEW [dbo].[View_EDW_RewardProgram_Joined] AS 
SELECT View_CMS_Tree_Joined.*, HFit_RewardProgram.* 
	FROM View_CMS_Tree_Joined 
	INNER JOIN HFit_RewardProgram 
		ON View_CMS_Tree_Joined.DocumentForeignKeyValue = HFit_RewardProgram.[RewardProgramID] 
WHERE ClassName = 'HFit.RewardProgram'
AND View_CMS_Tree_Joined.documentculture = 'en-US'

GO


