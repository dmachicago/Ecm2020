USE [KenticoCMS_PRD_prod3K7]
GO

/****** Object:  View [dbo].[view_EDW_RewardUserDetail]    Script Date: 5/13/2015 10:02:20 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


/*************************************************
 TESTS
select top 1000 * from [view_EDW_RewardUserDetail]
select * from [view_EDW_RewardUserDetail]
Where VHFRPJ_DocumentCulture <> 'en-us'
			AND VHFRGJ_DocumentCulture <> 'en-us'
			AND VHFRLJ_DocumentCulture <> 'en-us'
			AND VHFRAJ_DocumentCulture <> 'en-us'
			AND VHFRTJ_DocumentCulture <> 'en-us'
select top 1000 * from [view_EDW_RewardUserDetail]
select count(*) from [view_EDW_RewardUserDetail]
*************************************************/

CREATE VIEW [dbo].[view_EDW_RewardUserDetail]
AS

	 --**************************************************************************************************************************************************
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
	 --				RewardExceptionModifiedDate, RewardTrigger_DocumentModifiedWhen. Warned Laura this might create many dups.
	 --11.14.2014 : (wdm) The dups have surfaced. The combination of  HFRUAD.ActivityCompletedDt, 
	 --				HFRUAD.ItemModifiedWhen, HFRE.ItemModifiedWhen, HFRUAD.ItemModifiedWhen, VHFRTJ.DocumentModifiedWhen has exposed
	 --				tens of thousands of semi-redundant rows. Today, I commented these dates out and added a distinct and went from \
	 --				returning more than 100,000 rows for a given MPI and Client to 4 rows. I left in place the original dates of 
	 --				HFRULD.ItemCreatedWhen and HFRULD.ItemModifiedWhen. This gives us whether it is an insert or update. If multiple 
	 --				dates are used to determine changes, then it will be necessary to use a DATE filter to bring back only the 
	 --				rows indicating a change.
	 --11.18.2014 : (wdm) Found a USERID qualifier missing on the join of HFit_RewardsUserActivityDetail. Added this qualifier to USERID
	 --				and the view now appears to be functioning correctly returning about 160K rows in 2.5 minutes. The DISTINCT clause
	 --				made no difference in the number of returned rows, so it was removed and the execution time of the query was cut in half.
	 --01.01.2015 (WDM) added left outer join HFit_LKP_RewardActivity AND VHFRAJ.RewardActivityLKPName to the view - reference CR-47520
	 --01.01.2015 (WDM) Tested modifications - reference CR-47520
	 --02.17.2015 (WDM) and (SR) - modified the indexes and moved the where into a join to force the execution plan to modifiy itself. The 
	 --				view would not run in several hours since the deployment of this past Friday. Now, runs in a few minutes (less than 2).
	 --**************************************************************************************************************************************************

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
		  , HFRUAD.ItemModifiedWhen AS RewardActivityModifiedDate
		  , HFRUAD.ActivityVersionID
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
		  , CASE
			WHEN CAST (HFRULD.ItemCreatedWhen AS date) = CAST (HFRULD.ItemModifiedWhen AS date) 
			THEN 'I'
			ELSE 'U'
			END AS ChangeType
		  , VHFRPJ.DocumentGuid
		  , VHFRPJ.NodeGuid
		  , HFRULD.ItemCreatedWhen
		  , HFRULD.ItemModifiedWhen
		  , HFRE.ItemModifiedWhen AS RewardExceptionModifiedDate
		  , HFRUAD.ItemModifiedWhen AS RewardsUserActivity_ItemModifiedWhen
		  , VHFRTJ.DocumentModifiedWhen AS RewardTrigger_DocumentModifiedWhen

			--01.01.2015 (WDM) added for CR-47520

		  , LKPRA.RewardActivityLKPName
		  , VHFRPJ.DocumentCulture AS VHFRPJ_DocumentCulture
		  , VHFRGJ.DocumentCulture AS VHFRGJ_DocumentCulture
		  , VHFRLJ.DocumentCulture AS VHFRLJ_DocumentCulture
		  , VHFRAJ.DocumentCulture AS VHFRAJ_DocumentCulture
		  , VHFRTJ.DocumentCulture AS VHFRTJ_DocumentCulture
	   FROM dbo.View_HFit_RewardProgram_Joined AS VHFRPJ WITH (NOLOCK) 
				LEFT OUTER JOIN dbo.View_HFit_RewardGroup_Joined AS VHFRGJ WITH (NOLOCK) 
					ON VHFRPJ.NodeID = VHFRGJ.NodeParentID
				LEFT OUTER JOIN dbo.View_HFit_RewardLevel_Joined AS VHFRLJ WITH (NOLOCK) 
					ON VHFRGJ.NodeID = VHFRLJ.NodeParentID
				   AND VHFRLJ.DocumentCulture = 'en-us'
				LEFT OUTER JOIN dbo.HFit_LKP_RewardType AS HFLRT WITH (NOLOCK) 
					ON VHFRLJ.AwardType = HFLRT.RewardTypeLKPID
				LEFT OUTER JOIN dbo.HFit_LKP_RewardLevelType AS HFLRLT WITH (NOLOCK) 
					ON vhfrlj.LevelType = HFLRLT.RewardLevelTypeLKPID
				INNER JOIN dbo.HFit_RewardsUserLevelDetail AS HFRULD WITH (NOLOCK) 
					ON VHFRLJ.NodeID = HFRULD.LevelNodeID
				INNER JOIN dbo.CMS_User AS CU WITH (NOLOCK) 
					ON hfruld.UserID = cu.UserID
				INNER JOIN dbo.CMS_UserSite AS CUS WITH (NOLOCK) 
					ON CU.UserID = CUS.UserID
				INNER JOIN dbo.CMS_Site AS CS2 WITH (NOLOCK) 
					ON CUS.SiteID = CS2.SiteID
				INNER JOIN dbo.HFit_Account AS HFA WITH (NOLOCK) 
					ON cs2.SiteID = HFA.SiteID
				INNER JOIN dbo.CMS_UserSettings AS CUS2 WITH (NOLOCK) 
					ON cu.UserID = cus2.UserSettingsUserID
				LEFT OUTER JOIN dbo.View_HFit_RewardActivity_Joined AS VHFRAJ WITH (NOLOCK) 
					ON VHFRLJ.NodeID = VHFRAJ.NodeParentID
				   AND VHFRAJ.DocumentCulture = 'en-us'
				LEFT OUTER JOIN HFit_LKP_RewardActivity AS LKPRA
					ON LKPRA.RewardActivityLKPID = VHFRAJ.RewardActivityLKPID

	 --11.18.2014 (wdm) added this filter so that only USER Detail was returned.

				INNER JOIN dbo.HFit_RewardsUserActivityDetail AS HFRUAD WITH (NOLOCK) 
					ON VHFRAJ.NodeID = HFRUAD.ActivityNodeID
				   AND cu.UserID = HFRUAD.userid
				LEFT OUTER JOIN dbo.View_HFit_RewardTrigger_Joined AS VHFRTJ WITH (NOLOCK) 
					ON VHFRAJ.NodeID = VHFRTJ.NodeParentID
				   AND VHFRTJ.DocumentCulture = 'en-us'
				LEFT OUTER JOIN dbo.HFit_LKP_RewardTrigger AS HFLRT2 WITH (NOLOCK) 
					ON VHFRTJ.RewardTriggerLKPID = HFLRT2.RewardTriggerLKPID
				LEFT OUTER JOIN dbo.HFit_RewardException AS HFRE WITH (NOLOCK) 
					ON HFRE.RewardActivityID = VHFRAJ.RewardActivityID
				   AND HFRE.UserID = cu.UserID
	   WHERE VHFRPJ.DocumentCulture = 'en-us'
		 AND VHFRGJ.DocumentCulture = 'en-us';

--AND VHFRLJ.DocumentCulture = 'en-us'
--AND VHFRAJ.DocumentCulture = 'en-us'
--AND VHFRTJ.DocumentCulture = 'en-us'


GO


