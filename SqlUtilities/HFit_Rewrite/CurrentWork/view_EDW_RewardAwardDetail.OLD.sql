USE [KenticoCMS_PRD_prod3K7]
GO

/****** Object:  View [dbo].[view_EDW_RewardAwardDetail]    Script Date: 5/13/2015 10:01:14 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[view_EDW_RewardAwardDetail]
AS

	 --*************************************************************************************************
	 --WDM Reviewed 8/6/2014 for needed updates, none required
	 --09.11.2014 : (wdm) reviewed for EDW last mod date and the view is OK as is
	 --11.19.2014 : added language to verify returned data
	 --02.03.2015 : LevelName, LevelHeader, GroupHeadingText, GroupHeadingDescription
	 --*************************************************************************************************

	 SELECT DISTINCT
			cu.UserGUID
		  , cs.SiteGUID
		  , cus.HFitUserMpiNumber
		  , RL_Joined.RewardLevelID
		  , HFRAUD.AwardDisplayName
		  , HFRAUD.RewardValue
		  , HFRAUD.ThresholdNumber
		  , HFRAUD.UserNotified
		  , HFRAUD.IsFulfilled
		  , hfa.AccountID
		  , HFA.AccountCD
		  , CASE
				WHEN CAST (HFRAUD.ItemCreatedWhen AS date) = CAST (HFRAUD.ItemModifiedWhen AS date) 
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		  , HFRAUD.ItemCreatedWhen
		  , HFRAUD.ItemModifiedWhen
		  , RL_Joined.DocumentCulture
		  , HFRAUD.CultureCode
		  , RL_Joined.LevelName
		  , RL_Joined.LevelHeader
		  , RL_Joined.GroupHeadingText
		  , RL_Joined.GroupHeadingDescription
	   FROM dbo.HFit_RewardsAwardUserDetail AS HFRAUD
				INNER JOIN dbo.View_HFit_RewardLevel_Joined AS RL_Joined
					ON hfraud.RewardLevelNodeId = RL_Joined.NodeID
				   AND RL_Joined.DocumentCulture = 'en-US'
				   AND HFRAUD.CultureCode = 'en-US'
				INNER JOIN dbo.CMS_User AS CU
					ON hfraud.UserId = cu.UserID
				INNER JOIN dbo.CMS_UserSite AS CUS2
					ON cu.UserID = cus2.UserID
				INNER JOIN dbo.HFit_Account AS HFA
					ON cus2.SiteID = HFA.SiteID
				INNER JOIN dbo.CMS_Site AS CS
					ON CUS2.SiteID = CS.SiteID
				INNER JOIN dbo.CMS_UserSettings AS CUS
					ON cu.UserID = cus.UserSettingsUserID;

GO


