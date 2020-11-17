
/****** Object:  View [dbo].[view_EDW_RewardAwardDetail]    Script Date: 8/23/2014 5:15:21 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO






ALTER VIEW [dbo].[view_EDW_RewardAwardDetail]
AS
	SELECT DISTINCT
		cu.UserGUID
		, cs.SiteGUID
		, cus.HFitUserMpiNumber
		, VHFRLJ.RewardLevelID
		, HFRAUD.AwardDisplayName
		, HFRAUD.RewardValue
		, HFRAUD.ThresholdNumber
		, HFRAUD.UserNotified
		, HFRAUD.IsFulfilled
		, hfa.AccountID
		, HFA.AccountCD
		, CASE	WHEN CAST(HFRAUD.ItemCreatedWhen AS DATE) = CAST(HFRAUD.ItemModifiedWhen AS DATE)
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		, HFRAUD.ItemCreatedWhen
		, HFRAUD.ItemModifiedWhen
	FROM
		dbo.HFit_RewardsAwardUserDetail AS HFRAUD WITH ( NOLOCK )
	INNER JOIN dbo.View_HFit_RewardLevel_Joined AS VHFRLJ WITH ( NOLOCK ) ON hfraud.RewardLevelNodeId = VHFRLJ.NodeID
	INNER JOIN dbo.CMS_User AS CU WITH ( NOLOCK ) ON hfraud.UserId = cu.UserID
	INNER JOIN dbo.CMS_UserSite AS CUS2 WITH ( NOLOCK ) ON cu.UserID = cus2.UserID
	INNER JOIN dbo.HFit_Account AS HFA WITH ( NOLOCK ) ON cus2.SiteID = HFA.SiteID
	INNER JOIN dbo.CMS_Site AS CS WITH ( NOLOCK ) ON CUS2.SiteID = CS.SiteID
	INNER JOIN dbo.CMS_UserSettings AS CUS WITH ( NOLOCK ) ON cu.UserID = cus.UserSettingsUserID
       





GO


