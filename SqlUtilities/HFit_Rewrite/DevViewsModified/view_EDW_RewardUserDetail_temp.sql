
print ('Processing: view_EDW_RewardUserDetail ') ;
go

if exists(select TABLE_NAME from INFORMATION_SCHEMA.VIEWS where TABLE_NAME = 'view_EDW_RewardUserDetail')
BEGIN
	drop view view_EDW_RewardUserDetail ;
END
GO

create VIEW [dbo].[view_EDW_RewardUserDetail]
AS

	--********************************************************************************************************************
	--select * from [view_EDW_RewardUserDetail] where ItemModifiedWhen between '2000-11-14' and '2014-11-15'
	--select * from [view_EDW_RewardUserDetail] where ItemModifiedWhen between '2014-05-12' and '2014-05-13' 
	--8/7/2014 - added and commented out DocumentGuid and NodeGuid in case needed later
	--8/08/2014 - Generated corrected view in DEV (WDM)
	--8/12/2014 - Performance Issue - 00:06:49 @ 258502
	--8/12/2014 - Performance Issue - Add PI01_view_EDW_RewardUserDetail
	--8/12/2014 - Performance Issue - 00:03:46 @ 258502
	--8/12/2014 - Performance Issue - Add PI02_view_EDW_RewardUserDetail
	--8/12/2014 - Performance Issue - 00:03:45 @ 258502
	--8/19/2014 - (WDM) Added where clause to make the query return english data only.	
	--09.11.2014 : (wdm) Verified last mod date available to EDW - RewardsUserActivity_ItemModifiedWhen
	--				RewardExceptionModifiedDate, RewardTrigger_DocumentModifiedWhen
	--********************************************************************************************************************

	SELECT 
		cu.UserGUID
		, CS2.SiteGUID
		, cus2.HFitUserMpiNumber
		, VHFRAJ.RewardActivityID
		, VHFRPJ.RewardProgramName
		, VHFRPJ.RewardProgramID
		, VHFRPJ.RewardProgramPeriodStart
		, VHFRPJ.RewardProgramPeriodEnd
		, VHFRPJ.DocumentModifiedWhen AS RewardModifiedDate
		, VHFRGJ.GroupName
		, VHFRGJ.RewardGroupID
		, VHFRGJ.RewardGroupPeriodStart
		, VHFRGJ.RewardGroupPeriodEnd
		, VHFRGJ.DocumentModifiedWhen AS RewardGroupModifieDate
		, VHFRLJ.Level
		, HFLRLT.RewardLevelTypeLKPName
		, VHFRLJ.DocumentModifiedWhen AS RewardLevelModifiedDate
		, HFRULD.LevelCompletedDt
		, HFRULD.LevelVersionHistoryID
		, VHFRLJ.RewardLevelPeriodStart
		, VHFRLJ.RewardLevelPeriodEnd
		, VHFRAJ.ActivityName
		, HFRUAD.ActivityPointsEarned
		, HFRUAD.ActivityCompletedDt
		, HFRUAD.ActivityVersionID
		, HFRUAD.ItemModifiedWhen AS RewardActivityModifiedDate
		, VHFRAJ.RewardActivityPeriodStart
		, VHFRAJ.RewardActivityPeriodEnd
		, VHFRAJ.ActivityPoints
		, HFRE.UserAccepted
		, HFRE.UserExceptionAppliedTo		
		, VHFRTJ.TriggerName
		, VHFRTJ.RewardTriggerID
		, HFLRT2.RewardTriggerLKPDisplayName
		, HFLRT2.RewardTriggerDynamicValue
		, HFLRT2.ItemModifiedWhen AS RewardTriggerModifiedDate
		, HFLRT.RewardTypeLKPName
		, HFA.AccountID
		, HFA.AccountCD
		, CASE	WHEN CAST(HFRULD.ItemCreatedWhen AS DATE) = CAST(HFRULD.ItemModifiedWhen AS DATE)
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		, VHFRPJ.DocumentGuid		--WDM added 8/7/2014 in case needed
		, VHFRPJ.NodeGuid			--WDM added 8/7/2014 in case needed
		, HFRULD.ItemCreatedWhen
		, HFRULD.ItemModifiedWhen
		
		, HFRE.ItemModifiedWhen AS RewardExceptionModifiedDate
		, HFRUAD.ItemModifiedWhen as RewardsUserActivity_ItemModifiedWhen	--09.11.2014 (wdm) added for EDW
		, VHFRTJ.DocumentModifiedWhen as  RewardTrigger_DocumentModifiedWhen
	FROM
		dbo.View_HFit_RewardProgram_Joined AS VHFRPJ WITH ( NOLOCK )
			
		LEFT OUTER JOIN dbo.View_HFit_RewardGroup_Joined AS VHFRGJ WITH ( NOLOCK ) ON VHFRPJ.NodeID = VHFRGJ.NodeParentID
			
		LEFT OUTER JOIN dbo.View_HFit_RewardLevel_Joined AS VHFRLJ WITH ( NOLOCK ) ON VHFRGJ.NodeID = VHFRLJ.NodeParentID
			
		LEFT OUTER JOIN dbo.HFit_LKP_RewardType AS HFLRT WITH ( NOLOCK ) ON VHFRLJ.AwardType = HFLRT.RewardTypeLKPID
		LEFT OUTER JOIN dbo.HFit_LKP_RewardLevelType AS HFLRLT WITH ( NOLOCK ) ON vhfrlj.LevelType = HFLRLT.RewardLevelTypeLKPID
		INNER JOIN dbo.HFit_RewardsUserLevelDetail AS HFRULD WITH ( NOLOCK ) ON VHFRLJ.NodeID = HFRULD.LevelNodeID
		INNER JOIN dbo.CMS_User AS CU WITH ( NOLOCK ) ON hfruld.UserID = cu.UserID
		INNER JOIN dbo.CMS_UserSite AS CUS WITH ( NOLOCK ) ON CU.UserID = CUS.UserID
		INNER JOIN dbo.CMS_Site AS CS2 WITH ( NOLOCK ) ON CUS.SiteID = CS2.SiteID
		INNER JOIN dbo.HFit_Account AS HFA WITH ( NOLOCK ) ON cs2.SiteID = HFA.SiteID
		INNER JOIN dbo.CMS_UserSettings AS CUS2 WITH ( NOLOCK ) ON cu.UserID = cus2.UserSettingsUserID
		LEFT OUTER JOIN dbo.View_HFit_RewardActivity_Joined AS VHFRAJ WITH ( NOLOCK ) ON VHFRLJ.NodeID = VHFRAJ.NodeParentID
			
		INNER JOIN dbo.HFit_RewardsUserActivityDetail AS HFRUAD WITH ( NOLOCK ) ON VHFRAJ.NodeID = HFRUAD.ActivityNodeID
		LEFT OUTER JOIN dbo.View_HFit_RewardTrigger_Joined AS VHFRTJ WITH ( NOLOCK ) ON VHFRAJ.NodeID = VHFRTJ.NodeParentID
			
		LEFT OUTER JOIN dbo.HFit_LKP_RewardTrigger AS HFLRT2 WITH ( NOLOCK ) ON VHFRTJ.RewardTriggerLKPID = HFLRT2.RewardTriggerLKPID
		LEFT OUTER JOIN dbo.HFit_RewardException AS HFRE WITH ( NOLOCK ) ON HFRE.RewardActivityID = VHFRAJ.RewardActivityID
				AND HFRE.UserID = cu.UserID

		Where VHFRPJ.DocumentCulture = 'en-us'
			AND VHFRGJ.DocumentCulture = 'en-us'
			AND VHFRLJ.DocumentCulture = 'en-us'
			AND VHFRAJ.DocumentCulture = 'en-us'
			AND VHFRTJ.DocumentCulture = 'en-us'
		





GO


