
go
-- use KenticoCMS_Prod1

GO
PRINT 'Processing: view_EDW_RewardAwardDetail_CT ';
PRINT '***** FROM: view_EDW_RewardAwardDetail_CT.sql';
GO
IF EXISTS (SELECT
				  TABLE_NAME
				  FROM INFORMATION_SCHEMA.VIEWS
				  WHERE TABLE_NAME = 'view_EDW_RewardAwardDetail_CT') 
	BEGIN
		DROP VIEW
			 view_EDW_RewardAwardDetail_CT;
	END;
GO
CREATE VIEW dbo.view_EDW_RewardAwardDetail_CT
AS

--*************************************************************************************************
--(WDM) 03.17.2015 modified for change tracking
--select * from view_EDW_RewardAwardDetail_CT
--*************************************************************************************************

SELECT DISTINCT
	   cu.UserGUID
	 , cs.SiteGUID
	 , cus.HFitUserMpiNumber
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
	   ,hashbytes ('sha1',
		    + isnull(cast(cu.UserGUID as nvarchar(50)),'-')
		    + isnull(cast(cs.SiteGUID as nvarchar(50)),'-')
		    + isnull(cast(cus.HFitUserMpiNumber as nvarchar(50)),'-')
		    + isnull(cast(RL_Joined.NodeGuid as nvarchar(50)),'-')
		    + isnull(cast(RL_Joined.AwardType as nvarchar(100)),'-')
		    + isnull(cast(HFRAUD.AwardDisplayName as nvarchar(250)),'-')
		    + isnull(cast(HFRAUD.RewardValue as nvarchar(50)),'-')
		    + isnull(cast(HFRAUD.ThresholdNumber as nvarchar(50)),'-')
		    + isnull(cast(HFRAUD.UserNotified as nvarchar(50)),'-')
		    + isnull(cast(HFRAUD.IsFulfilled as nvarchar(50)),'-')
		    + isnull(cast(hfa.AccountID as nvarchar(50)),'-')
		    + isnull(cast(HFA.AccountCD as nvarchar(50)),'-')
		  ) as HashCode
	   , @@SERVERNAME as SVR
    , DB_NAME() as DBNAME
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
PRINT 'Processed: view_EDW_RewardAwardDetail_CT ';

GO 
