
GO
PRINT 'Processing: view_EDW_RewardAwardDetail ';
GO
IF EXISTS (SELECT
				  TABLE_NAME
				  FROM INFORMATION_SCHEMA.VIEWS
				  WHERE TABLE_NAME = 'view_EDW_RewardAwardDetail') 
	BEGIN
		DROP VIEW
			 view_EDW_RewardAwardDetail;
	END;
GO
CREATE VIEW dbo.view_EDW_RewardAwardDetail
AS

--*************************************************************************************************
--WDM Reviewed 8/6/2014 for needed updates, none required
--09.11.2014 : (wdm) reviewed for EDW last mod date and the view is OK as is
--11.19.2014 : added language to verify returned data
--02.03.2015 : LevelName, LevelHeader, GroupHeadingText, GroupHeadingDescription
--03.03.2015 : (dale/nathan) Added RewardLevelGUID
--03.19.2015 : by request of the EDW team, removed all columns not specificially requested
--			 and verified that was the request before initiating. The commented out columns
--			 were removed as a the solution to this request. 
--			 /*
--			 (WDM) Kept only these coulmns IAW CR-51005
--			 UserGUID
--			 SiteGUID 
--			 HFitUserMPINumber
--			 RewardLevelGUID
--			 RewardValue
--			 ThresholdNumber
--			 UserNotified
--			 IsFulfilled
--			 AccountID
--			 AccountCD
--			 ChangeType
--*/
--04.03.2015 : CR 51853 requested to put back columns that were previously removed. 
--			 AwardDisplayName and AwardType
--*************************************************************************************************

SELECT DISTINCT
	   cu.UserGUID
	 , cs.SiteGUID
	 , cus.HFitUserMpiNumber
	 --, RL_Joined.RewardLevelID
	 , RL_Joined.NodeGuid AS RewardLevelGUID
	   , RL_Joined.AwardType
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
	   END AS                ChangeType
	 --, HFRAUD.ItemCreatedWhen
	 --, HFRAUD.ItemModifiedWhen
	 --, RL_Joined.DocumentCulture 
	 --, HFRAUD.CultureCode
	 --, RL_Joined.LevelName
	 --, RL_Joined.LevelHeader
	 --, RL_Joined.GroupHeadingText
	 --, RL_Joined.GroupHeadingDescription
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
PRINT 'Processed: view_EDW_RewardAwardDetail ';


GO
PRINT '***** FROM: view_EDW_RewardAwardDetail.sql';
GO 
