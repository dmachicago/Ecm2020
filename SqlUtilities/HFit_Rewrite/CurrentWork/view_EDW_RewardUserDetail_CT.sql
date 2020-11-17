
GO
-- use KenticoCMS_Prod1

GO

PRINT 'Processing: view_EDW_RewardUserDetail_CT ';

GO

IF EXISTS ( SELECT
                   NAME
                   FROM sys.VIEWS
                   WHERE NAME = 'view_EDW_RewardUserDetail_CT') 

    BEGIN

        DROP VIEW
             view_EDW_RewardUserDetail_CT;
    END;

GO

/*----------------------------
TABLES USED IN VIEW:
CMS_Class
CMS_Document
CMS_Site
CMS_Tree
CMS_User
CMS_UserSettings
CMS_UserSite
COM_SKU
HFit_Account
HFit_LKP_RewardActivity
HFit_LKP_RewardLevelType
HFit_LKP_RewardTrigger
HFit_LKP_RewardType
HFit_RewardActivity
HFit_RewardException
HFit_RewardGroup
HFit_RewardLevel
HFit_RewardProgram
HFit_RewardsUserActivityDetail
HFit_RewardsUserLevelDetail
HFit_RewardTrigger
*/
--**************************************************************************************************************************************************
--06.26.2015 : Dhaval and Dale discuss change request to view. 
--			 HFRUAD -> HFit_RewardsUserActivityDetail, we are asked to change a field (UserExceptionAppliedTo)
--			 to now point to ActivityCompletedId -> HFit_RewardsUserActivityDetail. This req made today 
--			 from Corina thru Laura. Dhaval and I CONNOT make this change without a CR. 
--			 We decided to implement as: HFRAUD.ActivityCompletedId as UserExceptionAppliedTo
--**************************************************************************************************************************************************
-- select top 100 LevelCompletedDt, from view_EDW_RewardUserDetail_CT

CREATE VIEW dbo.view_EDW_RewardUserDetail_CT
AS 
SELECT DISTINCT
       cu.UserGUID
     , CS2.SiteGUID
     , cus2.HFitUserMpiNumber
     , VHFRAJ.NodeGuid AS RewardActivityGUID	--(03.03.2015 dale/nathan corrected)
     , VHFRPJ.RewardProgramName
     , CAST (VHFRPJ.DocumentModifiedWhen AS datetime) AS RewardModifiedDate

     , CAST (VHFRLJ.DocumentModifiedWhen  AS datetime) AS RewardLevelModifiedDate
     , CAST (HFRULD.LevelCompletedDt AS datetime) AS LevelCompletedDt
     , HFRUAD.ActivityPointsEarned
     , CAST (HFRUAD.ActivityCompletedDt AS datetime) AS ActivityCompletedDt
     , CAST (HFRUAD.ItemModifiedWhen  AS datetime) AS RewardActivityModifiedDate
     , VHFRAJ.ActivityPoints
     , HFRE.UserAccepted		  --Corina, please verify whether this column is needde or not
       --, HFRE.UserExceptionAppliedTo
     , HFRUAD.ActivityCompletedId AS UserExceptionAppliedTo
     , VHFRTJ.NodeGuid AS RewardTriggerGUID	--(03.03.2015 dale/nathan corrected)
     , HFA.AccountID
     , HFA.AccountCD
     , CASE
           WHEN CAST (HFRULD.ItemCreatedWhen AS date) = CAST (HFRULD.ItemModifiedWhen AS date) 
               THEN 'I'
           ELSE 'U'
       END AS ChangeType
     , CAST (HFRUAD.ActivityCompletedDt AS datetime) AS RewardExceptionModifiedDate

       FROM
           dbo.HFit_RewardsUserActivityDetail AS HFRUAD WITH (NOLOCK) 
               INNER JOIN dbo.View_HFit_RewardActivity_Joined AS VHFRAJ WITH (NOLOCK) 
                   ON VHFRAJ.NodeID = HFRUAD.ActivityNodeID
                  AND VHFRAJ.DocumentCulture = 'en-us'
               LEFT OUTER JOIN dbo.View_HFit_RewardGroup_Joined AS VHFRGJ WITH (NOLOCK) 
                   ON HFRUAD.rewardgroupnodeid = VHFRGJ.NodeID
                  AND VHFRGJ.DocumentCulture = 'en-us'
               LEFT OUTER JOIN dbo.View_HFit_RewardProgram_Joined AS VHFRPJ WITH (NOLOCK) 
                   ON HFRUAD.rewardprogramnodeid = VHFRPJ.NodeID
                  AND VHFRPJ.DocumentCulture = 'en-us'
               LEFT OUTER JOIN dbo.View_HFit_RewardLevel_Joined AS VHFRLJ WITH (NOLOCK) 
                   ON HFRUAD.rewardlevelnodeid = VHFRLJ.NodeID
                  AND VHFRLJ.DocumentCulture = 'en-us'
               INNER JOIN dbo.CMS_User AS CU WITH (NOLOCK) 
                   ON cu.UserID = HFRUAD.userid
               INNER JOIN dbo.CMS_UserSite AS CUS WITH (NOLOCK) 
                   ON CU.UserID = CUS.UserID
               INNER JOIN dbo.CMS_Site AS CS2 WITH (NOLOCK) 
                   ON CUS.SiteID = CS2.SiteID
               INNER JOIN dbo.HFit_Account AS HFA WITH (NOLOCK) 
                   ON cs2.SiteID = HFA.SiteID
               INNER JOIN dbo.CMS_UserSettings AS CUS2 WITH (NOLOCK) 
                   ON cu.UserID = cus2.UserSettingsUserID
               LEFT JOIN dbo.HFit_RewardsUserLevelDetail AS HFRULD WITH (NOLOCK) 
                   ON HFRUAD.rewardlevelnodeid = HFRULD.LevelNodeID
                  AND HFRULD.rewardgroupnodeid = HFRUAD.rewardgroupnodeid
                  AND HFRULD.rewardprogramnodeid = HFRUAD.rewardprogramnodeid
                  AND HFRULD.userid = HFRUAD.userid
               LEFT OUTER JOIN dbo.View_HFit_RewardTrigger_Joined AS VHFRTJ WITH (NOLOCK) 
                   ON VHFRAJ.NodeID = VHFRTJ.NodeParentID
                  AND VHFRTJ.DocumentCulture = 'en-us'
               LEFT OUTER JOIN dbo.HFit_RewardException AS HFRE WITH (NOLOCK) 
                   ON HFRE.RewardActivityID = VHFRAJ.RewardActivityID
                  AND HFRE.UserID = cu.UserID
       WHERE  cus2.HFitUserMpiNumber > 0;

GO

PRINT 'Completed : view_EDW_RewardUserDetail_CT ';

GO

PRINT '***** FROM: view_EDW_RewardUserDetail_CT.sql';

GO 
