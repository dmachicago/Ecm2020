
GO
PRINT 'Creating view view_EDW_RewardUserLevel';
GO

IF EXISTS (SELECT [name]
		   FROM [sys].[views]
		   WHERE [name] = 'view_EDW_RewardUserLevel') 
    BEGIN
	   DROP VIEW [view_EDW_RewardUserLevel];
    END;
GO

CREATE VIEW [view_EDW_RewardUserLevel]
AS

--***********************************************************************************************************
--Changes:
--01.20.2015 - (WDM) Added RL_Joined.nodeguid to satisfy #38393
--02.03.2015 : LevelName, LevelHeader, GroupHeadingText, GroupHeadingDescription, SiteGuid
--03.03.2015 : Reviewed by nathan and dale, no change required.
--04.17.2017 : WDM - found the Document Culture was not present and added it after talking with John C.
--***********************************************************************************************************

SELECT DISTINCT [us].[UserId]
		    , cast([dl].[LevelCompletedDt] as datetime) as [LevelCompletedDt]
		    , [RL_Joined].[NodeName] AS [LevelName]
		    , [s].[SiteName]
		    , [RL_Joined].[nodeguid]
		    , [s].[SiteGuid]
		    , [RL_Joined].[LevelHeader]
		    , [RL_Joined].[GroupHeadingText]
		    , [RL_Joined].[GroupHeadingDescription]

  FROM
	  [HFit_RewardsUserLevelDetail] AS [dl]
		 INNER JOIN [View_HFit_RewardLevel_Joined] AS [RL_Joined]
			ON [RL_Joined].[NodeId] = [dl].[LevelNodeId]
				AND RL_Joined.DocumentCulture= 'EN-US'
		 JOIN [CMS_UserSite] AS [us]
			ON [us].[UserId] = [dl].[UserId]
		 JOIN [CMS_Site] AS [s]
			ON [s].[SiteId] = [us].[SiteId];

GO

PRINT 'Created view view_EDW_RewardUserLevel';
GO
--  
--  
GO
PRINT '***** FROM: view_EDW_RewardUserLevel.sql';
GO 

