--**************
print('END: ' + cast(getdate() as nvarchar(50)));
print('@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-');
print'***************************************************************' ;
print('START: ' + cast(getdate() as nvarchar(50)));
--**************

--SET ANSI_NULLS ON;
--SET ANSI_PADDING ON;
--SET ANSI_WARNINGS ON;
--SET ARITHABORT ON;
--SET CONCAT_NULL_YIELDS_NULL ON;
--SET NUMERIC_ROUNDABORT OFF;
--SET QUOTED_IDENTIFIER ON;





GO
PRINT 'Creating view view_EDW_SmallStepResponses';
PRINT 'Generated FROM: view_EDW_SmallStepResponses.SQL';
GO
IF EXISTS (SELECT
                  name
                  FROM sys.views
             WHERE name = 'view_EDW_SmallStepResponses') 
    BEGIN
        PRINT 'VIEW view_EDW_SmallStepResponses, replacing.';
        DROP VIEW
             view_EDW_SmallStepResponses;
    END;
GO

CREATE VIEW dbo.view_EDW_SmallStepResponses
AS

--********************************************************************************************************
--IVP Version NO: 1.0
--02.13.2014 : (Sowmiya Venkiteswaran) : Updated the view to include  the fields:
--AccountCD, SiteGUID,SSOutcomeMessage as info. text,
-- Small Steps Program Info( HACampaignNodeGUID,HACampaignName,HACampaignStartDate,HACampaignEndDate)
-- HAUserStartedRecord Info (HAStartedDate,HACompletedDate,HAStartedMode,HACompletedMode)
-- Added filters by document culture and replacing HTML quote with a SQL single quote
--********************************************************************************************************
--02.23.2014 : (Dale Miller & Sowmiya V) : Performance tuning - removed the following WHERE clause and 
--			incorporated them into the JOIN statements for perfoamnce enhancement.
--			 WHERE vwOutcome.DocumentCulture = 'en-US' AND vwCamp.DocumentCulture = 'en-US';
--********************************************************************************************************
--02.23.2014 : (Dale Miller & Sowmiya V) : Performance tuning
--	Prod1, 2 and 3 Labs - Incorporated doc. culture to the Joins
-- 1 - executed DBCC dropcleanbuffers everytime
-- 2 - Tested REPLACE against No REPLACE, insignificant perf. hit.
-- Test Controls:
-- Prod1 Lab - NO SQL DISTINCT - 184311 ( rows) - 14 (seconds) 
-- Prod1 Lab - WITH SQL DISTINCT - 184311 ( rows) - 32 (seconds) 
-- Prod2 Lab - NO SQL DISTINCT -  81120( rows) -  10(seconds) 
-- Prod2 Lab - WITH SQL DISTINCT - 81120 ( rows) -  22(seconds) 
-- Prod3 Lab - NO SQL DISTINCT - 136763 ( rows) - 10 (seconds) 
-- Prod3 Lab - WITH SQL DISTINCT - 136763 ( rows) -  21(seconds)  
--02.24.2015 (SV) - Added column SSHealthAssesmentUserStartedItemID per request from John C.
--02.24.2015 (WDM) - Verified changes applied correctly from within the IVP
--02.24.2015 (WDM) - Verified changes are tracked from within the Schema Change Monitor
--02.24.2015 (WDM) - Add the view to the Data/View IVP
--03.02.2015 (WDM) - The view got out of sync most likely due to multiple users with CRUD capability.
--		Re-executed the master DDL.
--03.03.2015 (WDM/SV) - Added new columns HaCodeName and HFitUserMPINumber.
--03.04.2015 (WDM/SV) - Tested view and reviewed output - added DISTINCT and tuned for perf.
--03.04.2015 (WDM/Ashwin) - Ashwin started testing. Modified the JOIN for UserID - now returns expected MPI.
--03.04.2015 (WDM/Ashwin) - Ashwin certified the view as tested.
--04.06.2015 (WDM/JC) John found an error in the JOIN of user ID - changed to CMS_US.UserSettingsUserID = ss.UserID
--04.15.2015 (WDM/Shane) Found an issue with duplicate rows. Added the SiteID to the JOIN (eg.
--			  vwCamp.NodeSiteID = usrste.SiteID and moved the join down in the list.)
--04.16.2015 (WDM) completed CR-51962
--********************************************************************************************************

SELECT DISTINCT
       ss.UserID
     , acct.AccountCD
     , ste.SiteGUID
     , ss.ItemID AS SSItemID
     , ss.ItemCreatedBy AS SSItemCreatedBy
     , ss.ItemCreatedWhen AS SSItemCreatedWhen
     , ss.ItemModifiedBy AS SSItemModifiedBy
     , ss.ItemModifiedWhen AS SSItemModifiedWhen
     , ss.ItemOrder AS SSItemOrder
     , ss.ItemGUID AS SSItemGUID
     , ss.HealthAssesmentUserStartedItemID AS SSHealthAssesmentUserStartedItemID
     , ss.OutComeMessageGUID AS SSOutcomeMessageGuid
     , REPLACE (vwOutcome.Message, '&#39;', '''') AS SSOutcomeMessage
     , usrstd.HACampaignNodeGUID
     , vwCamp.Name AS HACampaignName
     , vwCamp.CampaignStartDate AS HACampaignStartDate
     , vwCamp.CampaignEndDate AS HACampaignEndDate
     , usrstd.HAStartedDt AS HAStartedDate
     , usrstd.HACompletedDt AS HACompletedDate
     , usrstd.HAStartedMode
     , usrstd.HACompletedMode
     , TODO.HaCodeName
     , CMS_US.HFitUserMPINumber

       FROM
           dbo.Hfit_SmallStepResponses AS ss
               JOIN HFit_HealthAssesmentUserStarted AS usrstd
                   ON usrstd.UserID = ss.UserID
                  AND usrstd.ItemID = ss.HealthAssesmentUserStartedItemID
                 JOIN View_HFit_OutComeMessages_Joined AS vwOutcome
                   ON vwOutcome.NodeGUID = ss.OutComeMessageGUID
                  AND vwOutcome.DocumentCulture = 'en-US'
                 JOIN CMS_UserSite AS usrste
                   ON usrste.UserID = ss.UserID
                 JOIN CMS_Site AS ste
                   ON ste.SiteID = usrste.SiteID
                 JOIN View_HFit_HACampaign_Joined AS vwCamp
                   ON vwCamp.NodeGuid = usrstd.HACampaignNodeGUID
                  AND vwCamp.DocumentCulture = 'en-US'
                  AND vwCamp.NodeSiteID = usrste.SiteID
                 JOIN HFit_Account AS acct
                   ON acct.SiteID = usrste.SiteID
                 JOIN HFit_ToDoSmallSteps AS TODO
                   ON ss.OutComeMessageGUID = TODO.OutComeMessageGUID
                 JOIN CMS_UserSettings AS CMS_US
                   ON CMS_US.UserSettingsUserID = ss.UserID
                  AND CMS_US.HFitUserMPINumber > 0
                  AND CMS_US.HFitUserMPINumber IS NOT NULL;

GO
PRINT 'Created view view_EDW_SmallStepResponses';
GO
--**************
print('END: ' + cast(getdate() as nvarchar(50)));
print('@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-');
print'***************************************************************' ;
print('START: ' + cast(getdate() as nvarchar(50)));
--**************

--SET ANSI_NULLS ON;
--SET ANSI_PADDING ON;
--SET ANSI_WARNINGS ON;
--SET ARITHABORT ON;
--SET CONCAT_NULL_YIELDS_NULL ON;
--SET NUMERIC_ROUNDABORT OFF;
--SET QUOTED_IDENTIFIER ON;





GO
PRINT 'Processing: view_EDW_RewardUserDetail ';
GO

--IF NOT EXISTS (SELECT
--					  name
--				 FROM sys.indexes
--				 WHERE name = 'CI_HFit_RewardsUserActivityDetail_Activity') 
--	BEGIN
--		CREATE NONCLUSTERED INDEX CI_HFit_RewardsUserActivityDetail_Activity ON dbo.HFit_RewardsUserActivityDetail (ActivityNodeID) INCLUDE (
--			   UserID
--			 , ActivityVersionID
--			 , ActivityPointsEarned
--			 , ActivityCompletedDt
--			 , ItemModifiedWhen) ;
--	END;
--GO

IF EXISTS (SELECT
                  NAME
                  FROM sys.VIEWS
             WHERE NAME = 'view_EDW_RewardUserDetail') 
    BEGIN
        DROP VIEW
             view_EDW_RewardUserDetail;
    END;
GO

/*************************************************
 TESTS
select top 1000 * from [view_EDW_RewardUserDetail]
select count(*) from [view_EDW_RewardUserDetail]
select * from [view_EDW_RewardUserDetail]
Where VHFRPJ_DocumentCulture <> 'en-us'
			AND VHFRGJ_DocumentCulture <> 'en-us'
			AND VHFRLJ_DocumentCulture <> 'en-us'
			AND VHFRAJ_DocumentCulture <> 'en-us'
			AND VHFRTJ_DocumentCulture <> 'en-us'
select top 1000 * from [view_EDW_RewardUserDetail]
select count(*) from [view_EDW_RewardUserDetail]
*************************************************/

CREATE VIEW dbo.view_EDW_RewardUserDetail
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
--11.18.2014 (wdm) added this filter so that only USER Detail was returned.
--01.01.2015 (WDM) added left outer join HFit_LKP_RewardActivity AND VHFRAJ.RewardActivityLKPName to the view - reference CR-47520
--01.01.2015 (WDM) Tested modifications - reference CR-47520
--02.17.2015 (WDM) and (SR) - modified the indexes and moved the where into a join to force the execution plan to modifiy itself. The 
--				view would not run in several hours since the deployment of this past Friday. Now, runs in a few minutes (less than 2).
-- 03.03.2015 Reviewed by nathan and dale and changes made as noted within.
--			ADDED THE FOLLOWING:
--				VHFRAJ.NodeGuid as RewardActivityGUID	--(03.03.2015 dale/nathan corrected)
--				VHFRPJ.DocumentGuid 	--(03.03.2015 dale/nathan corrected)
--				VHFRPJ.NodeGuid		--as RewardProgramGUID	--(03.03.2015 dale/nathan corrected)
--				VHFRGJ.NodeGuid	as RewardGroupGUID	--(03.03.2015 dale/nathan corrected)
--				VHFRTJ.NodeGuid AS RewardTriggerGUID	--(03.03.2015 dale/nathan corrected)
--03.19.2015 : by request of the EDW team, removed all columns not specificially requested
--			 and verified that was the request before initiating. The commented out columns
--			 were removed as a the solution to this request. 
--03.26.2015 : RewardGroupGUID removed per Shankar
--03.26.2015 : RewardExceptionModifiedDate Removed per Shankar
--03.12.2015 : WDM - modified view for change tracking implementation
--**************************************************************************************************************************************************

SELECT DISTINCT
       cu.UserGUID
     , CS2.SiteGUID
     , cus2.HFitUserMpiNumber
     , VHFRAJ.NodeGuid AS RewardActivityGUID	--(03.03.2015 dale/nathan corrected)
     , VHFRPJ.RewardProgramName
     , VHFRPJ.DocumentModifiedWhen AS RewardModifiedDate
     , VHFRGJ.NodeGuid AS RewardGroupGUID	 --(03.03.2015 dale/nathan corrected) and removed 03.26.2015 per Shankar
     , VHFRLJ.DocumentModifiedWhen AS RewardLevelModifiedDate
     , HFRULD.LevelCompletedDt
     , HFRUAD.ActivityPointsEarned
     , HFRUAD.ActivityCompletedDt
     , HFRUAD.ItemModifiedWhen AS RewardActivityModifiedDate
     , VHFRAJ.ActivityPoints
     , HFRE.UserAccepted
     , HFRE.UserExceptionAppliedTo
     , VHFRTJ.NodeGuid AS RewardTriggerGUID	--(03.03.2015 dale/nathan corrected)
     , HFA.AccountID
     , HFA.AccountCD
     , CASE
           WHEN CAST (HFRULD.ItemCreatedWhen AS date) = CAST (HFRULD.ItemModifiedWhen AS date) 
               THEN 'I'
           ELSE 'U'
       END AS ChangeType
	 , HASHBYTES ('sha1',
				isnull (cast(RewardProgramName as nvarchar(50)) , '-')
				+ isnull (cast( VHFRPJ.DocumentModifiedWhen as nvarchar(50)) , '-')
				+ isnull (cast(VHFRLJ.DocumentModifiedWhen as nvarchar(50)) , '-')
				+ isnull (cast(HFRULD.LevelCompletedDt as nvarchar(50)) , '-')
				+ isnull (cast(HFRUAD.ActivityPointsEarned as nvarchar(50)) , '-')
				+ isnull (cast(HFRUAD.ActivityCompletedDt as nvarchar(50)) , '-')
				+ isnull (cast(HFRUAD.ItemModifiedWhen as nvarchar(50)) , '-')
				+ isnull (cast(VHFRAJ.ActivityPoints as nvarchar(50)) , '-')
				+ isnull (cast(HFRE.UserAccepted as nvarchar(50)) , '-')
				+ isnull (cast(HFRE.UserExceptionAppliedTo as nvarchar(50)) , '-')
				+ isnull (cast(HFA.AccountID as nvarchar(50)) , '-')
				+ isnull (cast(HFA.AccountCD as nvarchar(50)) , '-')	   
				) as HashCode	   
	   ,NULL as DeletedFlg

	   --, VHFRAJ.RewardActivityID	 
	   --, VHFRPJ.RewardProgramID
	   --, VHFRPJ.DocumentGuid --(03.03.2015 dale/nathan corrected)
	   --, VHFRPJ.NodeGuid --(03.03.2015 dale/nathan corrected) RewardProgramGUID: View_HFit_RewardProgram_Joined
	   --, VHFRPJ.RewardProgramPeriodStart
	   --, VHFRPJ.RewardProgramPeriodEnd
	   --, VHFRGJ.GroupName
	   --, VHFRGJ.RewardGroupID
	   --, VHFRGJ.RewardGroupPeriodStart
	   --, VHFRGJ.RewardGroupPeriodEnd
	   --, VHFRGJ.DocumentModifiedWhen AS RewardGroupModifieDate
	   --, VHFRLJ.Level
	   --, HFLRLT.RewardLevelTypeLKPName
	   --, HFRULD.LevelVersionHistoryID
	   --, VHFRLJ.RewardLevelPeriodStart
	   --, VHFRLJ.RewardLevelPeriodEnd
	   --, VHFRAJ.ActivityName
	   --, HFRUAD.ActivityVersionID
	   --, VHFRAJ.RewardActivityPeriodStart
	   --, VHFRAJ.RewardActivityPeriodEnd
	   --, VHFRTJ.TriggerName
	   --, VHFRTJ.RewardTriggerID
	   --, HFLRT2.RewardTriggerLKPDisplayName
	   --, HFLRT2.RewardTriggerDynamicValue
	   --, HFLRT2.ItemModifiedWhen AS     RewardTriggerModifiedDate
	   --, HFLRT.RewardTypeLKPName
	   --, HFRULD.ItemCreatedWhen
	   --, HFRULD.ItemModifiedWhen

	   --, HFRE.ItemModifiedWhen AS       RewardExceptionModifiedDate	  --Removed 03.26.2015 per Shankar

	   --, HFRUAD.ItemModifiedWhen AS     RewardsUserActivity_ItemModifiedWhen
	   --, VHFRTJ.DocumentModifiedWhen AS RewardTrigger_DocumentModifiedWhen	 --01.01.2015 (WDM) added for CR-47520

	   --, LKPRA.RewardActivityLKPName
	   --, VHFRPJ.DocumentCulture AS      VHFRPJ_DocumentCulture
	   --, VHFRGJ.DocumentCulture AS      VHFRGJ_DocumentCulture
	   --, VHFRLJ.DocumentCulture AS      VHFRLJ_DocumentCulture
	   --, VHFRAJ.DocumentCulture AS      VHFRAJ_DocumentCulture
	   --, VHFRTJ.DocumentCulture AS      VHFRTJ_DocumentCulture
       FROM
            dbo.View_HFit_RewardProgram_Joined AS VHFRPJ WITH (NOLOCK) 
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

GO
PRINT 'Completed : view_EDW_RewardUserDetail ';
GO

/*
(WDM) Kept only these coulmns IAW CR-51005
UserGUID
SiteGUID 
HFitUserMPINumber
RewardActivityGUID
RewardProgramName
RewardModifiedDate
RewardGroupGUID
RewardLevelModifiedDate
LevelCompletedDt
ActivityPointsEarned
ActivityCompletedDt
RewardActivityModifiedDate
ActivityPoints
UserAccepted
UserExceptionAppliedTo
RewardTriggerGUID
AccountID
AccountCD 
ChangeType
RewardExceptionModifiedDate
*/

PRINT '***** FROM: view_EDW_RewardUserDetail.sql';
GO 
--**************
print('END: ' + cast(getdate() as nvarchar(50)));
print('@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-');
print'***************************************************************' ;
print('START: ' + cast(getdate() as nvarchar(50)));
--**************

--SET ANSI_NULLS ON;
--SET ANSI_PADDING ON;
--SET ANSI_WARNINGS ON;
--SET ARITHABORT ON;
--SET CONCAT_NULL_YIELDS_NULL ON;
--SET NUMERIC_ROUNDABORT OFF;
--SET QUOTED_IDENTIFIER ON;






GO
PRINT '***** FROM: view_EDW_RewardsDefinition.sql';
GO 
PRINT 'Processing: view_EDW_RewardsDefinition:';
GO
IF EXISTS (SELECT
				  NAME
				  FROM sys.VIEWS
				  WHERE NAME = 'view_EDW_RewardsDefinition') 
	BEGIN
		DROP VIEW
			 view_EDW_RewardsDefinition;
	END;
GO

--GRANT SELECT
--	ON [dbo].[view_EDW_RewardsDefinition]
--	TO [EDWReader_PRD]
--GO

CREATE VIEW dbo.view_EDW_RewardsDefinition
AS

--****************************************************************************************************************************************************
--WDM Reviewed 8/6/2014 for needed updates, may be needed
--	My question - Is NodeGUID going to be passed onto the children
--8/7/2014 - added and commented out DocumentGuid in case needed later
--8/8/2014 - Generated corrected view in DEV (WDM)
--8/19/2014 - (WDM) Added where clause to make the query return english data only.	
--09.11.2014 : Added to facilitate EDW Last Mod Date determination and added language filters
--11.14.2014 : Found that this view was in PRod Staging and not in Prod.
--11.17.2014 : John C. found that Spanish was coming across. This was due to the view
--				View_HFit_RewardProgram_Joined not having the capability to FITER at the 
--				Document Culture level. Created a view, View_EDW_RewardProgram_Joined, that
--				used View_HFit_RewardProgram_Joined and added the capability to fiter languages.
--12.31.2014 (WDM) added left outer join HFit_LKP_RewardActivity AND VHFRAJ.RewardActivityLKPName to the view reference CR-47520
--01.01.2014 (WDM) tested changes for CR-47520
--02.16.2015 (WDM) Requested by John C. added as all required is a reference to the name
--		    ,[LevelName]
--			,[LevelHeader]
--		    ,[GroupHeadingText]
--		    ,[GroupHeadingDescription]
-- 03.03.2015 (WDM/NJ) added VHFRPJ.NodeGuid as RewardProgramGUID, RewardGroupGuid, RewardLevelGuid, VHFRAJ.RewardActivityGuid, VHFRAJ.RewardActivityLKPGuid
--			RewardTriggerGuid, VHFRTPJ.NodeGuid,LKPRTP.ItemGuid as OperatorGUID, RewardTriggerGuid
-- 03.03.2015 (WDM/NJ) added new joined table LKPRTP
-- 
--****************************************************************************************************************************************************
--select * from information_schema.columns where column_name = 'RewardProgramGuid' 
--select top 100 * from View_EDW_RewardProgram_Joined 

SELECT DISTINCT
	   cs.SiteGUID
	 , HFA.AccountID
	 , hfa.AccountCD
	 --, RewardProgramID
	 , VHFRPJ.NodeGuid AS             RewardProgramGUID --(WDM/NJ) added 03.03.2015     
	 , RewardProgramName
	 , RewardProgramPeriodStart
	 , RewardProgramPeriodEnd
	 --, ProgramDescription
	 --, RewardGroupID
	 , VHFRGJ.NodeGuid AS             RewardGroupGuid --(WDM/NJ) added 03.03.2015     
	 , GroupName
	 --, RewardContactGroups
	 --, RewardGroupPeriodStart
	 --, RewardGroupPeriodEnd
	 --, RewardLevelID
	 , VHFRLJ.NodeGuid AS             RewardLevelGuid --(WDM/NJ) added 03.03.2015     
	 , Level
	 , RewardLevelTypeLKPName
	 --, RewardLevelPeriodStart
	 --, RewardLevelPeriodEnd
	 --, FrequencyMenu
	 , AwardDisplayName
	 , AwardType
	 , AwardThreshold1
	 , AwardThreshold2
	 , AwardThreshold3
	 , AwardThreshold4
	 , AwardValue1
	 , AwardValue2
	 , AwardValue3
	 , AwardValue4
	 --, CompletionText
	 , ExternalFulfillmentRequired
	 --, RewardHistoryDetailDescription
	 --, VHFRAJ.RewardActivityID
	 , VHFRAJ.NodeGuid AS             RewardActivityGuid --(WDM/NJ) added 03.03.2015     
	 , VHFRAJ.ActivityName
	 , VHFRAJ.ActivityFreqOrCrit
	 --, VHFRAJ.RewardActivityPeriodStart
	 --, VHFRAJ.RewardActivityPeriodEnd
	 --, VHFRAJ.RewardActivityLKPID
	 --, LKPRA.ItemGuid AS              RewardActivityLKPGuid --(WDM/NJ) added 03.03.2015     
	 --, LKPRA.RewardActivityLKPName
	 , VHFRAJ.ActivityPoints
	 , VHFRAJ.IsBundle
	 , VHFRAJ.IsRequired
	 , VHFRAJ.MaxThreshold
	 , VHFRAJ.AwardPointsIncrementally
	 , VHFRAJ.AllowMedicalExceptions
	 --, VHFRAJ.BundleText
	 --, RewardTriggerID
	 , VHFRTJ.NodeGuid AS             RewardTriggerGuid --(WDM/NJ) added 03.03.2015     
	 , HFLRT.RewardTriggerDynamicValue
	 , TriggerName
	 --, RequirementDescription
	 --, LKPRTP.ItemGuid AS             OperatorGUID --(WDM/NJ) added 03.03.2015     
	 , VHFRTPJ.RewardTriggerParameterOperator
	 , VHFRTPJ.NodeGuid AS            RewardTriggerParmGUID --(WDM/NJ) added 03.03.2015     
	 , VHFRTPJ.Value
	 --, vhfrtpj.ParameterDisplayName
	 , CASE
		   WHEN CAST (VHFRPJ.DocumentCreatedWhen AS date) = CAST (VHFRPJ.DocumentModifiedWhen AS date) 
		   THEN 'I'
		   ELSE 'U'
	   END AS                         ChangeType
	 --, VHFRPJ.DocumentGuid --WDM Added 8/7/2014 in case needed
	 --, VHFRPJ.DocumentCreatedWhen
	 --, VHFRPJ.DocumentModifiedWhen
	 --, VHFRAJ.DocumentModifiedWhen AS RewardActivity_DocumentModifiedWhen --09.11.2014 : Added to facilitate EDW Last Mod Date determination
	 , VHFRAJ.DocumentCulture AS      DocumentCulture_VHFRAJ
	 , VHFRPJ.DocumentCulture AS      DocumentCulture_VHFRPJ
	 , VHFRGJ.DocumentCulture AS      DocumentCulture_VHFRGJ
	 , VHFRLJ.DocumentCulture AS      DocumentCulture_VHFRLJ
	 , VHFRTPJ.DocumentCulture AS     DocumentCulture_VHFRTPJ
	 , LevelName
	 --, LevelHeader
	 --, GroupHeadingText
	 --, GroupHeadingDescription
	   FROM dbo.View_EDW_RewardProgram_Joined AS VHFRPJ
				INNER JOIN dbo.View_HFit_RewardGroup_Joined AS VHFRGJ
					ON VHFRPJ.NodeID = VHFRGJ.NodeParentID
				   AND VHFRPJ.DocumentCulture = 'en-US'
				   AND VHFRGJ.DocumentCulture = 'en-US'
				 INNER JOIN dbo.View_HFit_RewardLevel_Joined AS VHFRLJ
					ON VHFRGJ.NodeID = VHFRLJ.NodeParentID
				   AND VHFRLJ.DocumentCulture = 'en-US'
				 INNER JOIN dbo.HFit_LKP_RewardLevelType AS HFLRLT
					ON VHFRLJ.LevelType = HFLRLT.RewardLevelTypeLKPID
				 INNER JOIN dbo.View_HFit_RewardActivity_Joined AS VHFRAJ
					ON VHFRLJ.NodeID = VHFRAJ.NodeParentID
				   AND VHFRAJ.DocumentCulture = 'en-US'
				 LEFT OUTER JOIN HFit_LKP_RewardActivity AS LKPRA
					ON LKPRA.RewardActivityLKPID = VHFRAJ.RewardActivityLKPID   --Added 1.2.2015 for SR-47520
				 INNER JOIN dbo.View_HFit_RewardTrigger_Joined AS VHFRTJ
					ON VHFRAJ.NodeID = VHFRTJ.NodeParentID
				   AND VHFRTJ.DocumentCulture = 'en-US'
				 INNER JOIN dbo.View_HFit_RewardTriggerParameter_Joined AS VHFRTPJ
					ON vhfrtj.nodeid = vhfrtpj.nodeparentid
				   AND VHFRTPJ.DocumentCulture = 'en-US'
				 INNER JOIN dbo.HFit_LKP_RewardTrigger AS HFLRT
					ON VHFRTJ.RewardTriggerLKPID = HFLRT.RewardTriggerLKPID
				 INNER JOIN dbo.CMS_Site AS CS
					ON VHFRPJ.NodeSiteID = cs.SiteID
				 INNER JOIN dbo.HFit_Account AS HFA
					ON cs.SiteID = HFA.SiteID
				 INNER JOIN HFit_LKP_RewardTriggerParameterOperator AS LKPRTP
					ON LKPRTP.RewardTriggerParameterOperatorLKPID = VHFRTPJ.RewardTriggerParameterOperator;
GO
PRINT 'Processed: view_EDW_RewardsDefinition ';
GO
/*
(WDM) Kept only these coulmns IAW CR-51005
SiteGUID 
AccountID
AccountCD 
RewardProgramGUID
RewardProgramName
RewardProgramPeriodStart
RewardProgramPeriodEnd
RewardGroupGUID
GroupName
RewardLevelGUID
Level
RewardLevelTypeLKPName
AwardDisplayName
AwardType
AwardThreshold1
AwardThreshold2
AwardThreshold3
AwardThreshold4
AwardValue1
AwardValue2
AwardValue3
AwardValue4
ExternalFulfillmentRequired
RewardActivityGUID
RewardActivityName	--VHFRAJ.ActivityName
ActivityFreqOrCrit
ActivityPoints
IsBundle
IsRequired
MaxThreshold
AwardPointsIncrementally
AllowMedicalExceptions
RewardTriggerGUID
RewardTriggerDynamicValue
TriggerName
RewardTriggerParameterOperator
RewardTriggerParameterGUID  --RewardTriggerParmGUID
Value
ChangeType
DocumentCulture_VHFRAJ
DocumentCulture_VHFRPJ
DocumentCulture_VHFRGJ
DocumentCulture_
DocumentCulture_VHFRTPJ
LevelName
*/
GO
--**************
print('END: ' + cast(getdate() as nvarchar(50)));
print('@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-');
print'***************************************************************' ;
print('START: ' + cast(getdate() as nvarchar(50)));
--**************

--SET ANSI_NULLS ON;
--SET ANSI_PADDING ON;
--SET ANSI_WARNINGS ON;
--SET ARITHABORT ON;
--SET CONCAT_NULL_YIELDS_NULL ON;
--SET NUMERIC_ROUNDABORT OFF;
--SET QUOTED_IDENTIFIER ON;





--GO
--IF EXISTS (SELECT name FROM sys.triggers where name = 'trgSchemaMonitor')    
--DISABLE TRIGGER trgSchemaMonitor ON DATABASE;

GO
PRINT '***** FROM: view_EDW_TrackerCompositeDetails.sql';
PRINT 'Processing: view_EDW_TrackerCompositeDetails ';
GO
--SELECT * from view_EDW_TrackerCompositeDetails
IF EXISTS ( SELECT DISTINCT
                   TABLE_NAME
                   FROM INFORMATION_SCHEMA.VIEWS
                   WHERE
                   TABLE_NAME = 'view_EDW_TrackerCompositeDetails') 
    BEGIN
        DROP VIEW
             view_EDW_TrackerCompositeDetails;
    END;
GO
--count with UNION ALL xx @ 00:00:24
--count with UNION ALL and DISTINCT xx @ 00:00:24
--count with UNION 3,218,556 @ 00:00:24
--SELECT count(*) from view_EDW_TrackerCompositeDetails;
GO
CREATE VIEW dbo.view_EDW_TrackerCompositeDetails
AS
--************************************************************************************************************************************
-- NOTES:
--************************************************************************************************************************************
--WDM 6/26/2014
--This view is needed by EDW in order to process the Tracker tables' data.
--As of now, the Tracker tables are representative of objects and that would cause 
--	large volumes of ETL to be devloped and maintained. 
--This view represents a columnar representation of all tracker tables in a Key/Value pair representation.
--Each tracker table to be processed into the EDW must be represented in this view.
--ALL new tracker tables need only be entered once using the structure contained within this view
--	and the same EDW ETL should be able to process it.
--If there is a change to the strucuture of any one query in this view, then all have to be modified 
--	to be support the change.
--Column TrackerNameAggregratetable (AggregateTableName) will be NULL if the Tracker is not a member 
--		of the DISPLAYED Trackers. This allows us to capture all trackers, displayed or not.

--7/29/2014
--ISSUE: HFit_TrackerBMI,  HFit_TrackerCholesterol, and HFit_TrackerHeight are not in the HFIT_Tracker
--		table. This causes T.IsAvailable, T.IsCustom, T.UniqueName to be NULL. 
--		This raises the need for the Tracker Definition Table.

--NOTE: It is a goal to keep this view using BASE tables in order to gain max performance. Nested views will 
--		be avoided here if possible.

--**************** SPECIFIC TRACKER DATA **********************
--**************** on 7/29/2014          **********************
--Tracker GUID or Unique ID across all DB Instances (ItemGuid)
--Tracker NodeID (we use it for the External ID for Audit and error Triage)  (John: can use ItemID in this case)
--Tracker Table Name or Value Group Name (e.g. Body Measurements) - Categorization (TrackerNameAggregateTable)
--Tracker Column Unique Name ( In English)  Must be consistent across all DB Instances  ([UniqueName] will be 
--		the TABLE NAME if tracker name not found in the HFIT_Tracker table)
--Tracker Column Description (In English) (???)
--Tracker Column Data Type (e.g. Character, Numeric, Date, Bit or Yes/No) – so that we can set up the answer type
--	NULLS accepted for No Answer?	(KEY1, KEY2, VAL1, VAL2, etc)
--Tracker Active flag (IsAvailable will be null if tracker name not found in the HFIT_Tracker table)
--Tracker Unit of Measure (character) (Currently, the UOM is supplied in the view based on the table and type of Tracker)
--Tracker Insert Date ([ItemCreatedWhen])
--Tracker Last Update Date ([ItemModifiedWhen])
--NOTE: Convert all numerics to floats 7/30/2104 John/Dale
--****************************************************************************************************************************
-- 12.21.2014 - Added Select Distincts to avoid possible dups.
-- 12.23.2014 - Added the Vendor ID and Vendor name to the view via the HFit_LKP_TrackerVendor table
-- 12.25.2014 - Tested the view to see that it returned the correct VendorID description
--****************************************************************************************************************************
-- NEW ADDITIONS: 02.01.2015	Need for the updates to be completed and then we add.
--	  HFit_TrackerTobaccoAttestation
--	  HFit_TrackerPreventiveCare
--	  HFit_TrackerCotinine
--(03.20.2015) - (WDM) The DISTINCT in this qry in should eliminate duplicate rows found by John C.
--			 All worked correctly in 12.25.2014, NO changes effected since then, and unexplicably rows stated to 
--			 duplicate in three tables (tracker views) Shots, Tests, and TrackerInstance
--(03.20.2015) - WDM : HFit_TrackerInstance_Tracker has a problem that will require developer help - it is still OPEN.
--			    John C. and I looked at the issue and the LEFT join is causing a cartisian as there is no KEY 
--			    on which to join.
-- TGT (PRod1) NO DISTINCT: 
--  SELECT DISTINCT count(*) from view_EDW_TrackerCompositeDetails 00:08:36 @ 3,210,081
--- TGT (PRod1) WITH DISTINCT and Union all: 
--  SELECT DISTINCT count(*) from view_EDW_TrackerCompositeDetails 00:00:30 @ 3,210,081
--- TGT (PRod1) No DISTINCT and UNion all: 
--  SELECT DISTINCT count(*) from view_EDW_TrackerCompositeDetails 00:00:14 @ 3,218,556
--****************************************************************************************************************************
--USE:
--SELECT DISTINCT * from view_EDW_TrackerCompositeDetails where EventDate between '2013-11-01 15:02:00.000' and '2013-12-01 15:02:00.000'

--Set statistics IO ON
--GO

SELECT DISTINCT
       'HFit_TrackerBloodPressure' AS TrackerNameAggregateTable
     , TT.ItemID
     , EventDate
     , TT.IsProfessionallyCollected
     , TT.TrackerCollectionSourceID
     , Notes
     , TT.UserID
     , CollectionSourceName_Internal
     , CollectionSourceName_External
     , 'MISSING' AS EventName
     , 'mm/Hg' AS UOM
     , 'Systolic' AS KEY1
     , CAST ( Systolic AS float) AS VAL1
     , 'Diastolic' AS KEY2
     , CAST ( Diastolic AS float) AS VAL2
     , 'NA' AS KEY3
     , NULL AS VAL3
     , 'NA' AS KEY4
     , NULL AS VAL4
     , 'NA' AS KEY5
     , NULL AS VAL5
     , 'NA' AS KEY6
     , NULL AS VAL6
     , 'NA' AS KEY7
     , NULL AS VAL7
     , 'NA' AS KEY8
     , NULL AS VAL8
     , 'NA' AS KEY9
     , NULL AS VAL9
     , 'NA' AS KEY10
     , NULL AS VAL10
     , TT.ItemCreatedBy
     , TT.ItemCreatedWhen
     , TT.ItemModifiedBy
     , TT.ItemModifiedWhen
     , IsProcessedForHa
     , 'NA' AS TXTKEY1
     , NULL AS TXTVAL1
     , 'NA' AS TXTKEY2
     , NULL AS TXTVAL2
     , 'NA' AS TXTKEY3
     , NULL AS TXTVAL3
     , NULL AS ItemOrder
     , NULL AS ItemGuid
     , C.UserGuid
     , PP.MPI
     , PP.ClientCode
     , S.SiteGUID
     , ACCT.AccountID
     , ACCT.AccountCD
     , T.IsAvailable
     , T.IsCustom
     , ISNULL ( T.UniqueName , 'bp') AS UniqueName
     , ISNULL ( T.UniqueName , 'bp') AS ColDesc
     , VENDOR.ItemID AS VendorID
     , VENDOR.VendorName
       FROM
            dbo.HFit_TrackerBloodPressure AS TT
                INNER JOIN dbo.CMS_User AS C
                ON C.UserID = TT.UserID
                INNER JOIN dbo.hfit_ppteligibility AS PP
                ON TT.UserID = PP.userID
                INNER JOIN dbo.HFit_Account AS ACCT
                ON PP.ClientCode = ACCT.AccountCD
                INNER JOIN dbo.CMS_Site AS S
                ON ACCT.SiteID = S.SiteID
                INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
                ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                LEFT OUTER JOIN dbo.HFIT_Tracker AS T
                ON T.AggregateTableName = 'HFit_TrackerBloodPressure'
                LEFT OUTER JOIN HFit_LKP_TrackerVendor AS VENDOR
                ON TT.VendorID = VENDOR.ItemID
UNION ALL
SELECT DISTINCT
       'HFit_TrackerBloodSugarAndGlucose' AS TrackerNameAggregateTable
     , TT.ItemID
     , EventDate
     , TT.IsProfessionallyCollected
     , TT.TrackerCollectionSourceID
     , Notes
     , TT.UserID
     , CollectionSourceName_Internal
     , CollectionSourceName_External
     , 'MISSING' AS EventName
     , 'mmol/L' AS UOM
     , 'Units' AS KEY1
     , CAST ( Units AS float) AS VAL1
     , 'FastingState' AS KEY2
     , CAST ( FastingState AS float) AS VAL2
     , 'NA' AS KEY3
     , NULL AS VAL3
     , 'NA' AS KEY4
     , NULL AS VAL4
     , 'NA' AS KEY5
     , NULL AS VAL5
     , 'NA' AS KEY6
     , NULL AS VAL6
     , 'NA' AS KEY7
     , NULL AS VAL7
     , 'NA' AS KEY8
     , NULL AS VAL8
     , 'NA' AS KEY9
     , NULL AS VAL9
     , 'NA' AS KEY10
     , NULL AS VAL10
     , TT.ItemCreatedBy
     , TT.ItemCreatedWhen
     , TT.ItemModifiedBy
     , TT.ItemModifiedWhen
     , IsProcessedForHa
     , 'NA' AS TXTKEY1
     , NULL AS TXTVAL1
     , 'NA' AS TXTKEY2
     , NULL AS TXTVAL2
     , 'NA' AS TXTKEY3
     , NULL AS TXTVAL3
     , NULL AS ItemOrder
     , NULL AS ItemGuid
     , C.UserGuid
     , PP.MPI
     , PP.ClientCode
     , S.SiteGUID
     , ACCT.AccountID
     , ACCT.AccountCD
     , T.IsAvailable
     , T.IsCustom
     , ISNULL ( T.UniqueName , 'glucose') AS UniqueName
     , ISNULL ( T.UniqueName , 'glucose') AS ColDesc
     , VENDOR.ItemID AS VendorID
     , VENDOR.VendorName
       FROM
            dbo.HFit_TrackerBloodSugarAndGlucose AS TT
                INNER JOIN dbo.CMS_User AS C
                ON C.UserID = TT.UserID
                INNER JOIN dbo.hfit_ppteligibility AS PP
                ON TT.UserID = PP.userID
                INNER JOIN dbo.HFit_Account AS ACCT
                ON PP.ClientCode = ACCT.AccountCD
                INNER JOIN dbo.CMS_Site AS S
                ON ACCT.SiteID = S.SiteID
                INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
                ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                LEFT OUTER JOIN dbo.HFIT_Tracker AS T
                ON T.AggregateTableName = 'HFit_TrackerBloodSugarAndGlucose'
                LEFT OUTER JOIN HFit_LKP_TrackerVendor AS VENDOR
                ON TT.VendorID = VENDOR.ItemID
UNION ALL
SELECT DISTINCT
       'HFit_TrackerBMI' AS TrackerNameAggregateTable
     , TT.ItemID
     , EventDate
     , TT.IsProfessionallyCollected
     , TT.TrackerCollectionSourceID
     , Notes
     , TT.UserID
     , CollectionSourceName_Internal
     , CollectionSourceName_External
     , 'MISSING' AS EventName
     , 'kg/m2' AS UOM
     , 'BMI' AS KEY1
     , CAST ( BMI AS float) AS VAL1
     , 'NA' AS KEY2
     , 0 AS VAL2
     , 'NA' AS KEY3
     , NULL AS VAL3
     , 'NA' AS KEY4
     , NULL AS VAL4
     , 'NA' AS KEY5
     , NULL AS VAL5
     , 'NA' AS KEY6
     , NULL AS VAL6
     , 'NA' AS KEY7
     , NULL AS VAL7
     , 'NA' AS KEY8
     , NULL AS VAL8
     , 'NA' AS KEY9
     , NULL AS VAL9
     , 'NA' AS KEY10
     , NULL AS VAL10
     , TT.ItemCreatedBy
     , TT.ItemCreatedWhen
     , TT.ItemModifiedBy
     , TT.ItemModifiedWhen
     , NULL AS IsProcessedForHa
     , 'NA' AS TXTKEY1
     , NULL AS TXTVAL1
     , 'NA' AS TXTKEY2
     , NULL AS TXTVAL2
     , 'NA' AS TXTKEY3
     , NULL AS TXTVAL3
     , TT.ItemOrder
     , NULL AS ItemGuid
     , C.UserGuid
     , PP.MPI
     , PP.ClientCode
     , S.SiteGUID
     , ACCT.AccountID
     , ACCT.AccountCD
     , T.IsAvailable
     , T.IsCustom
     , ISNULL ( T.UniqueName , 'HFit_TrackerBMI') AS UniqueName
     , ISNULL ( T.UniqueName , 'HFit_TrackerBMI') AS ColDesc
     , VENDOR.ItemID AS VendorID
     , VENDOR.VendorName
       FROM
            dbo.HFit_TrackerBMI AS TT
                INNER JOIN dbo.CMS_User AS C
                ON C.UserID = TT.UserID
                INNER JOIN dbo.hfit_ppteligibility AS PP
                ON TT.UserID = PP.userID
                INNER JOIN dbo.HFit_Account AS ACCT
                ON PP.ClientCode = ACCT.AccountCD
                INNER JOIN dbo.CMS_Site AS S
                ON ACCT.SiteID = S.SiteID
                INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
                ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                LEFT OUTER JOIN dbo.HFIT_Tracker AS T
                ON T.AggregateTableName = 'HFit_TrackerBMI'
                LEFT OUTER JOIN HFit_LKP_TrackerVendor AS VENDOR
                ON TT.VendorID = VENDOR.ItemID
UNION ALL
SELECT DISTINCT
       'HFit_TrackerBodyFat' AS TrackerNameAggregateTable
     , TT.ItemID
     , EventDate
     , TT.IsProfessionallyCollected
     , TT.TrackerCollectionSourceID
     , Notes
     , TT.UserID
     , CollectionSourceName_Internal
     , CollectionSourceName_External
     , 'MISSING' AS EventName
     , 'PCT' AS UOM
     , 'Value' AS KEY1
     , CAST ( [Value] AS float) AS VAL1
     , 'NA' AS KEY2
     , 0 AS VAL2
     , 'NA' AS KEY3
     , NULL AS VAL3
     , 'NA' AS KEY4
     , NULL AS VAL4
     , 'NA' AS KEY5
     , NULL AS VAL5
     , 'NA' AS KEY6
     , NULL AS VAL6
     , 'NA' AS KEY7
     , NULL AS VAL7
     , 'NA' AS KEY8
     , NULL AS VAL8
     , 'NA' AS KEY9
     , NULL AS VAL9
     , 'NA' AS KEY10
     , NULL AS VAL10
     , TT.ItemCreatedBy
     , TT.ItemCreatedWhen
     , TT.ItemModifiedBy
     , TT.ItemModifiedWhen
     , NULL AS IsProcessedForHa
     , 'NA' AS TXTKEY1
     , NULL AS TXTVAL1
     , 'NA' AS TXTKEY2
     , NULL AS TXTVAL2
     , 'NA' AS TXTKEY3
     , NULL AS TXTVAL3
     , NULL AS ItemOrder
     , NULL AS ItemGuid
     , C.UserGuid
     , PP.MPI
     , PP.ClientCode
     , S.SiteGUID
     , ACCT.AccountID
     , ACCT.AccountCD
     , T.IsAvailable
     , T.IsCustom
     , ISNULL ( T.UniqueName , 'HFit_TrackerBodyFat') AS UniqueName
     , ISNULL ( T.UniqueName , 'HFit_TrackerBodyFat') AS ColDesc
     , VENDOR.ItemID AS VendorID
     , VENDOR.VendorName
       FROM
            dbo.HFit_TrackerBodyFat AS TT
                INNER JOIN dbo.CMS_User AS C
                ON C.UserID = TT.UserID
                INNER JOIN dbo.hfit_ppteligibility AS PP
                ON TT.UserID = PP.userID
                INNER JOIN dbo.HFit_Account AS ACCT
                ON PP.ClientCode = ACCT.AccountCD
                INNER JOIN dbo.CMS_Site AS S
                ON ACCT.SiteID = S.SiteID
                INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
                ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                LEFT OUTER JOIN dbo.HFIT_Tracker AS T
                ON T.AggregateTableName = 'HFit_TrackerBodyFat'
                LEFT OUTER JOIN HFit_LKP_TrackerVendor AS VENDOR
                ON TT.VendorID = VENDOR.ItemID
UNION ALL
--******************************************************************************
SELECT DISTINCT
       'HFit_TrackerBodyMeasurements' AS TrackerNameAggregateTable
     , TT.ItemID
     , EventDate
     , TT.IsProfessionallyCollected
     , TT.TrackerCollectionSourceID
     , Notes
     , TT.UserID
     , CollectionSourceName_Internal
     , CollectionSourceName_External
     , 'MISSING' AS EventName
     , 'Inch' AS UOM
     , 'WaistInches' AS KEY1
     , CAST ( WaistInches AS float) AS VAL1
     , 'HipInches' AS KEY2
     , CAST ( HipInches AS float) AS VAL2
     , 'ThighInches' AS KEY3
     , CAST ( ThighInches AS float) AS VAL3
     , 'ArmInches' AS KEY4
     , CAST ( ArmInches AS float) AS VAL4
     , 'ChestInches' AS KEY5
     , CAST ( ChestInches AS float) AS VAL5
     , 'CalfInches' AS KEY6
     , CAST ( CalfInches AS float) AS VAL6
     , 'NeckInches' AS KEY7
     , CAST ( NeckInches AS float) AS VAL7
     , 'NA' AS KEY8
     , NULL AS VAL8
     , 'NA' AS KEY9
     , NULL AS VAL9
     , 'NA' AS KEY10
     , NULL AS VAL10
     , TT.ItemCreatedBy
     , TT.ItemCreatedWhen
     , TT.ItemModifiedBy
     , TT.ItemModifiedWhen
     , IsProcessedForHa
     , 'NA' AS TXTKEY1
     , NULL AS TXTVAL1
     , 'NA' AS TXTKEY2
     , NULL AS TXTVAL2
     , 'NA' AS TXTKEY3
     , NULL AS TXTVAL3
     , NULL AS ItemOrder
     , NULL AS ItemGuid
     , C.UserGuid
     , PP.MPI
     , PP.ClientCode
     , S.SiteGUID
     , ACCT.AccountID
     , ACCT.AccountCD
     , T.IsAvailable
     , T.IsCustom
     , T.UniqueName
     , T.UniqueName AS ColDesc
     , VENDOR.ItemID AS VendorID
     , VENDOR.VendorName
       FROM
            dbo.HFit_TrackerBodyMeasurements AS TT
                INNER JOIN dbo.CMS_User AS C
                ON C.UserID = TT.UserID
                INNER JOIN dbo.hfit_ppteligibility AS PP
                ON TT.UserID = PP.userID
                INNER JOIN dbo.HFit_Account AS ACCT
                ON PP.ClientCode = ACCT.AccountCD
                INNER JOIN dbo.CMS_Site AS S
                ON ACCT.SiteID = S.SiteID
                INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
                ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                LEFT OUTER JOIN dbo.HFIT_Tracker AS T
                ON T.AggregateTableName = 'HFit_TrackerBodyMeasurements'
                LEFT OUTER JOIN HFit_LKP_TrackerVendor AS VENDOR
                ON TT.VendorID = VENDOR.ItemID
--******************************************************************************
UNION ALL
SELECT DISTINCT
       'HFit_TrackerCardio' AS TrackerNameAggregateTable
     , TT.ItemID
     , EventDate
     , TT.IsProfessionallyCollected
     , TT.TrackerCollectionSourceID
     , Notes
     , TT.UserID
     , CollectionSourceName_Internal
     , CollectionSourceName_External
     , 'MISSING' AS EventName
     , 'NA' AS UOM
     , 'Minutes' AS KEY1
     , CAST ( Minutes AS float) AS VAL1
     , 'Distance' AS KEY2
     , CAST ( Distance AS float) AS VAL2
     , 'DistanceUnit' AS KEY3
     , CAST ( DistanceUnit AS float) AS VAL3
     , 'Intensity' AS KEY4
     , CAST ( Intensity AS float) AS VAL4
     , 'ActivityID' AS KEY5
     , CAST ( ActivityID AS float) AS VAL5
     , 'NA' AS KEY6
     , NULL AS VAL6
     , 'NA' AS KEY7
     , NULL AS VAL7
     , 'NA' AS KEY8
     , NULL AS VAL8
     , 'NA' AS KEY9
     , NULL AS VAL9
     , 'NA' AS KEY10
     , NULL AS VAL10
     , TT.ItemCreatedBy
     , TT.ItemCreatedWhen
     , TT.ItemModifiedBy
     , TT.ItemModifiedWhen
     , NULL AS IsProcessedForHa
     , 'NA' AS TXTKEY1
     , NULL AS TXTVAL1
     , 'NA' AS TXTKEY2
     , NULL AS TXTVAL2
     , 'NA' AS TXTKEY3
     , NULL AS TXTVAL3
     , NULL AS ItemOrder
     , NULL AS ItemGuid
     , C.UserGuid
     , PP.MPI
     , PP.ClientCode
     , S.SiteGUID
     , ACCT.AccountID
     , ACCT.AccountCD
     , T.IsAvailable
     , T.IsCustom
     , T.UniqueName
     , T.UniqueName AS ColDesc
     , NULL AS VendorID	--VENDOR.ItemID as VendorID
     ,
       NULL AS VendorName --VENDOR.VendorName
       FROM
            dbo.HFit_TrackerCardio AS TT
                INNER JOIN dbo.CMS_User AS C
                ON C.UserID = TT.UserID
                INNER JOIN dbo.hfit_ppteligibility AS PP
                ON TT.UserID = PP.userID
                INNER JOIN dbo.HFit_Account AS ACCT
                ON PP.ClientCode = ACCT.AccountCD
                INNER JOIN dbo.CMS_Site AS S
                ON ACCT.SiteID = S.SiteID
                INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
                ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                LEFT OUTER JOIN dbo.HFIT_Tracker AS T
                ON T.AggregateTableName = 'HFit_TrackerCardio'
--left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID
UNION ALL
SELECT DISTINCT
       'HFit_TrackerCholesterol' AS TrackerNameAggregateTable
     , TT.ItemID
     , EventDate
     , TT.IsProfessionallyCollected
     , TT.TrackerCollectionSourceID
     , Notes
     , TT.UserID
     , CollectionSourceName_Internal
     , CollectionSourceName_External
     , 'MISSING' AS EventName
     , 'mg/dL' AS UOM
     , 'HDL' AS KEY1
     , CAST ( HDL AS float) AS VAL1
     , 'LDL' AS KEY2
     , CAST ( LDL AS float) AS VAL2
     , 'Total' AS KEY3
     , CAST ( Total AS float) AS VAL3
     , 'Tri' AS KEY4
     , CAST ( Tri AS float) AS VAL4
     , 'Ratio' AS KEY5
     , CAST ( Ratio AS float) AS VAL5
     , 'Fasting' AS KEY6
     , CAST ( Fasting AS float) AS VAL6
     , 'VLDL' AS VLDL
     , CAST ( VLDL AS float) AS VAL7
     , 'NA' AS KEY8
     , NULL AS VAL8
     , 'NA' AS KEY9
     , NULL AS VAL9
     , 'NA' AS KEY10
     , NULL AS VAL10
     , TT.ItemCreatedBy
     , TT.ItemCreatedWhen
     , TT.ItemModifiedBy
     , TT.ItemModifiedWhen
     , IsProcessedForHa
     , 'NA' AS TXTKEY1
     , NULL AS TXTVAL1
     , 'NA' AS TXTKEY2
     , NULL AS TXTVAL2
     , 'NA' AS TXTKEY3
     , NULL AS TXTVAL3
     , NULL AS ItemOrder
     , NULL AS ItemGuid
     , C.UserGuid
     , PP.MPI
     , PP.ClientCode
     , S.SiteGUID
     , ACCT.AccountID
     , ACCT.AccountCD
     , T.IsAvailable
     , T.IsCustom
     , ISNULL ( T.UniqueName , 'HFit_TrackerCholesterol') AS UniqueName
     , ISNULL ( T.UniqueName , 'HFit_TrackerCholesterol') AS ColDesc
     , VENDOR.ItemID AS VendorID
     , VENDOR.VendorName
       FROM
            dbo.HFit_TrackerCholesterol AS TT
                INNER JOIN dbo.CMS_User AS C
                ON C.UserID = TT.UserID
                INNER JOIN dbo.hfit_ppteligibility AS PP
                ON TT.UserID = PP.userID
                INNER JOIN dbo.HFit_Account AS ACCT
                ON PP.ClientCode = ACCT.AccountCD
                INNER JOIN dbo.CMS_Site AS S
                ON ACCT.SiteID = S.SiteID
                INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
                ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                LEFT OUTER JOIN dbo.HFIT_Tracker AS T
                ON T.AggregateTableName = 'HFit_TrackerCholesterol'
                LEFT OUTER JOIN HFit_LKP_TrackerVendor AS VENDOR
                ON TT.VendorID = VENDOR.ItemID
UNION ALL
SELECT DISTINCT
       'HFit_TrackerDailySteps' AS TrackerNameAggregateTable
     , TT.ItemID
     , EventDate
     , TT.IsProfessionallyCollected
     , TT.TrackerCollectionSourceID
     , Notes
     , TT.UserID
     , CollectionSourceName_Internal
     , CollectionSourceName_External
     , 'MISSING' AS EventName
     , 'Step' AS UOM
     , 'Steps' AS KEY1
     , CAST ( Steps AS float) AS VAL1
     , 'NA' AS KEY2
     , NULL AS VAL2
     , 'NA' AS KEY3
     , NULL AS VAL3
     , 'NA' AS KEY4
     , NULL AS VAL4
     , 'NA' AS KEY5
     , NULL AS VAL5
     , 'NA' AS KEY6
     , NULL AS VAL6
     , 'NA' AS KEY7
     , NULL AS VAL7
     , 'NA' AS KEY8
     , NULL AS VAL8
     , 'NA' AS KEY9
     , NULL AS VAL9
     , 'NA' AS KEY10
     , NULL AS VAL10
     , TT.ItemCreatedBy
     , TT.ItemCreatedWhen
     , TT.ItemModifiedBy
     , TT.ItemModifiedWhen
     , NULL AS IsProcessedForHa
     , 'NA' AS TXTKEY1
     , NULL AS TXTVAL1
     , 'NA' AS TXTKEY2
     , NULL AS TXTVAL2
     , 'NA' AS TXTKEY3
     , NULL AS TXTVAL3
     , NULL AS ItemOrder
     , NULL AS ItemGuid
     , C.UserGuid
     , PP.MPI
     , PP.ClientCode
     , S.SiteGUID
     , ACCT.AccountID
     , ACCT.AccountCD
     , T.IsAvailable
     , T.IsCustom
     , ISNULL ( T.UniqueName , 'HFit_TrackerDailySteps') AS UniqueName
     , ISNULL ( T.UniqueName , 'HFit_TrackerDailySteps') AS ColDesc
     , NULL AS VendorID	--VENDOR.ItemID as VendorID
     ,
       NULL AS VendorName --VENDOR.VendorName
       FROM
            dbo.HFit_TrackerDailySteps AS TT
                INNER JOIN dbo.CMS_User AS C
                ON C.UserID = TT.UserID
                INNER JOIN dbo.hfit_ppteligibility AS PP
                ON TT.UserID = PP.userID
                INNER JOIN dbo.HFit_Account AS ACCT
                ON PP.ClientCode = ACCT.AccountCD
                INNER JOIN dbo.CMS_Site AS S
                ON ACCT.SiteID = S.SiteID
                INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
                ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                LEFT OUTER JOIN dbo.HFIT_Tracker AS T
                ON T.AggregateTableName = 'HFit_TrackerDailySteps'
--left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID
UNION ALL
SELECT DISTINCT
       'HFit_TrackerFlexibility' AS TrackerNameAggregateTable
     , TT.ItemID
     , EventDate
     , TT.IsProfessionallyCollected
     , TT.TrackerCollectionSourceID
     , Notes
     , TT.UserID
     , CollectionSourceName_Internal
     , CollectionSourceName_External
     , 'MISSING' AS EventName
     , 'Y/N' AS UOM
     , 'HasStretched' AS KEY1
     , CAST ( HasStretched AS float) AS VAL1
     , 'NA' AS KEY2
     , NULL AS VAL2
     , 'NA' AS KEY3
     , NULL AS VAL3
     , 'NA' AS KEY4
     , NULL AS VAL4
     , 'NA' AS KEY5
     , NULL AS VAL5
     , 'NA' AS KEY6
     , NULL AS VAL6
     , 'NA' AS KEY7
     , NULL AS VAL7
     , 'NA' AS KEY8
     , NULL AS VAL8
     , 'NA' AS KEY9
     , NULL AS VAL9
     , 'NA' AS KEY10
     , NULL AS VAL10
     , TT.ItemCreatedBy
     , TT.ItemCreatedWhen
     , TT.ItemModifiedBy
     , TT.ItemModifiedWhen
     , NULL AS IsProcessedForHa
     , 'Activity' AS TXTKEY1
     , Activity AS TXTVAL1
     , 'NA' AS TXTKEY2
     , NULL AS TXTVAL2
     , 'NA' AS TXTKEY3
     , NULL AS TXTVAL3
     , NULL AS ItemOrder
     , NULL AS ItemGuid
     , C.UserGuid
     , PP.MPI
     , PP.ClientCode
     , S.SiteGUID
     , ACCT.AccountID
     , ACCT.AccountCD
     , T.IsAvailable
     , T.IsCustom
     , T.UniqueName
     , T.UniqueName AS ColDesc
     , NULL AS VendorID	--VENDOR.ItemID as VendorID
     ,
       NULL AS VendorName --VENDOR.VendorName
       FROM
            dbo.HFit_TrackerFlexibility AS TT
                INNER JOIN dbo.CMS_User AS C
                ON C.UserID = TT.UserID
                INNER JOIN dbo.hfit_ppteligibility AS PP
                ON TT.UserID = PP.userID
                INNER JOIN dbo.HFit_Account AS ACCT
                ON PP.ClientCode = ACCT.AccountCD
                INNER JOIN dbo.CMS_Site AS S
                ON ACCT.SiteID = S.SiteID
                INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
                ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                LEFT OUTER JOIN dbo.HFIT_Tracker AS T
                ON T.AggregateTableName = 'HFit_TrackerFlexibility'
--left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID
UNION ALL
SELECT DISTINCT
       'HFit_TrackerFruits' AS TrackerNameAggregateTable
     , TT.ItemID
     , EventDate
     , TT.IsProfessionallyCollected
     , TT.TrackerCollectionSourceID
     , Notes
     , TT.UserID
     , CollectionSourceName_Internal
     , CollectionSourceName_External
     , 'MISSING' AS EventName
     , 'CUP(8oz)' AS UOM
     , 'Cups' AS KEY1
     , CAST ( Cups AS float) AS VAL1
     , 'NA' AS KEY2
     , NULL AS VAL2
     , 'NA' AS KEY3
     , NULL AS VAL3
     , 'NA' AS KEY4
     , NULL AS VAL4
     , 'NA' AS KEY5
     , NULL AS VAL5
     , 'NA' AS KEY6
     , NULL AS VAL6
     , 'NA' AS KEY7
     , NULL AS VAL7
     , 'NA' AS KEY8
     , NULL AS VAL8
     , 'NA' AS KEY9
     , NULL AS VAL9
     , 'NA' AS KEY10
     , NULL AS VAL10
     , TT.ItemCreatedBy
     , TT.ItemCreatedWhen
     , TT.ItemModifiedBy
     , TT.ItemModifiedWhen
     , NULL AS IsProcessedForHa
     , 'NA' AS TXTKEY1
     , NULL AS TXTVAL1
     , 'NA' AS TXTKEY2
     , NULL AS TXTVAL2
     , 'NA' AS TXTKEY3
     , NULL AS TXTVAL3
     , NULL AS ItemOrder
     , NULL AS ItemGuid
     , C.UserGuid
     , PP.MPI
     , PP.ClientCode
     , S.SiteGUID
     , ACCT.AccountID
     , ACCT.AccountCD
     , T.IsAvailable
     , T.IsCustom
     , T.UniqueName
     , T.UniqueName AS ColDesc
     , NULL AS VendorID	--VENDOR.ItemID as VendorID
     ,
       NULL AS VendorName --VENDOR.VendorName
       FROM
            dbo.HFit_TrackerFruits AS TT
                INNER JOIN dbo.CMS_User AS C
                ON C.UserID = TT.UserID
                INNER JOIN dbo.hfit_ppteligibility AS PP
                ON TT.UserID = PP.userID
                INNER JOIN dbo.HFit_Account AS ACCT
                ON PP.ClientCode = ACCT.AccountCD
                INNER JOIN dbo.CMS_Site AS S
                ON ACCT.SiteID = S.SiteID
                INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
                ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                LEFT OUTER JOIN dbo.HFIT_Tracker AS T
                ON T.AggregateTableName = 'HFit_TrackerFruits'
--left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID
UNION ALL
SELECT DISTINCT
       'HFit_TrackerHbA1c' AS TrackerNameAggregateTable
     , TT.ItemID
     , EventDate
     , TT.IsProfessionallyCollected
     , TT.TrackerCollectionSourceID
     , Notes
     , TT.UserID
     , CollectionSourceName_Internal
     , CollectionSourceName_External
     , 'MISSING' AS EventName
     , 'mmol/mol' AS UOM
     , 'Value' AS KEY1
     , CAST ( [Value] AS float) AS VAL1
     , 'NA' AS KEY2
     , NULL AS VAL2
     , 'NA' AS KEY3
     , NULL AS VAL3
     , 'NA' AS KEY4
     , NULL AS VAL4
     , 'NA' AS KEY5
     , NULL AS VAL5
     , 'NA' AS KEY6
     , NULL AS VAL6
     , 'NA' AS KEY7
     , NULL AS VAL7
     , 'NA' AS KEY8
     , NULL AS VAL8
     , 'NA' AS KEY9
     , NULL AS VAL9
     , 'NA' AS KEY10
     , NULL AS VAL10
     , TT.ItemCreatedBy
     , TT.ItemCreatedWhen
     , TT.ItemModifiedBy
     , TT.ItemModifiedWhen
     , IsProcessedForHa
     , 'NA' AS TXTKEY1
     , NULL AS TXTVAL1
     , 'NA' AS TXTKEY2
     , NULL AS TXTVAL2
     , 'NA' AS TXTKEY3
     , NULL AS TXTVAL3
     , NULL AS ItemOrder
     , NULL AS ItemGuid
     , C.UserGuid
     , PP.MPI
     , PP.ClientCode
     , S.SiteGUID
     , ACCT.AccountID
     , ACCT.AccountCD
     , T.IsAvailable
     , T.IsCustom
     , T.UniqueName
     , T.UniqueName AS ColDesc
     , VENDOR.ItemID AS VendorID
     , VENDOR.VendorName
       FROM
            dbo.HFit_TrackerHbA1c AS TT
                INNER JOIN dbo.CMS_User AS C
                ON C.UserID = TT.UserID
                INNER JOIN dbo.hfit_ppteligibility AS PP
                ON TT.UserID = PP.userID
                INNER JOIN dbo.HFit_Account AS ACCT
                ON PP.ClientCode = ACCT.AccountCD
                INNER JOIN dbo.CMS_Site AS S
                ON ACCT.SiteID = S.SiteID
                INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
                ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                LEFT OUTER JOIN dbo.HFIT_Tracker AS T
                ON T.AggregateTableName = 'HFit_TrackerHbA1c'
                LEFT OUTER JOIN HFit_LKP_TrackerVendor AS VENDOR
                ON TT.VendorID = VENDOR.ItemID
UNION ALL
SELECT DISTINCT
       'HFit_TrackerHeight' AS TrackerNameAggregateTable
     , TT.ItemID
     , EventDate
     , TT.IsProfessionallyCollected
     , TT.TrackerCollectionSourceID
     , Notes
     , TT.UserID
     , CollectionSourceName_Internal
     , CollectionSourceName_External
     , 'MISSING' AS EventName
     , 'inch' AS UOM
     , 'Height' AS KEY1
     , Height AS VAL1
     , 'NA' AS KEY2
     , NULL AS VAL2
     , 'NA' AS KEY3
     , NULL AS VAL3
     , 'NA' AS KEY4
     , NULL AS VAL4
     , 'NA' AS KEY5
     , NULL AS VAL5
     , 'NA' AS KEY6
     , NULL AS VAL6
     , 'NA' AS KEY7
     , NULL AS VAL7
     , 'NA' AS KEY8
     , NULL AS VAL8
     , 'NA' AS KEY9
     , NULL AS VAL9
     , 'NA' AS KEY10
     , NULL AS VAL10
     , TT.ItemCreatedBy
     , TT.ItemCreatedWhen
     , TT.ItemModifiedBy
     , TT.ItemModifiedWhen
     , IsProcessedForHa
     , 'NA' AS TXTKEY1
     , NULL AS TXTVAL1
     , 'NA' AS TXTKEY2
     , NULL AS TXTVAL2
     , 'NA' AS TXTKEY3
     , NULL AS TXTVAL3
     , TT.ItemOrder
     , TT.ItemGuid
     , C.UserGuid
     , PP.MPI
     , PP.ClientCode
     , S.SiteGUID
     , ACCT.AccountID
     , ACCT.AccountCD
     , T.IsAvailable
     , T.IsCustom
     , ISNULL ( T.UniqueName , 'HFit_TrackerHeight') AS UniqueName
     , ISNULL ( T.UniqueName , 'HFit_TrackerHeight') AS ColDesc
     , VENDOR.ItemID AS VendorID
     , VENDOR.VendorName
       FROM
            dbo.HFit_TrackerHeight AS TT
                INNER JOIN dbo.CMS_User AS C
                ON C.UserID = TT.UserID
                INNER JOIN dbo.hfit_ppteligibility AS PP
                ON TT.UserID = PP.userID
                INNER JOIN dbo.HFit_Account AS ACCT
                ON PP.ClientCode = ACCT.AccountCD
                INNER JOIN dbo.CMS_Site AS S
                ON ACCT.SiteID = S.SiteID
                INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
                ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                LEFT OUTER JOIN dbo.HFIT_Tracker AS T
                ON T.AggregateTableName = 'HFit_TrackerHeight'
                LEFT OUTER JOIN HFit_LKP_TrackerVendor AS VENDOR
                ON TT.VendorID = VENDOR.ItemID
UNION ALL
SELECT DISTINCT
       'HFit_TrackerHighFatFoods' AS TrackerNameAggregateTable
     , TT.ItemID
     , EventDate
     , TT.IsProfessionallyCollected
     , TT.TrackerCollectionSourceID
     , Notes
     , TT.UserID
     , CollectionSourceName_Internal
     , CollectionSourceName_External
     , 'MISSING' AS EventName
     , 'Occurs' AS UOM
     , 'Times' AS KEY1
     , CAST ( Times AS float) AS VAL1
     , 'NA' AS KEY2
     , NULL AS VAL2
     , 'NA' AS KEY3
     , NULL AS VAL3
     , 'NA' AS KEY4
     , NULL AS VAL4
     , 'NA' AS KEY5
     , NULL AS VAL5
     , 'NA' AS KEY6
     , NULL AS VAL6
     , 'NA' AS KEY7
     , NULL AS VAL7
     , 'NA' AS KEY8
     , NULL AS VAL8
     , 'NA' AS KEY9
     , NULL AS VAL9
     , 'NA' AS KEY10
     , NULL AS VAL10
     , TT.ItemCreatedBy
     , TT.ItemCreatedWhen
     , TT.ItemModifiedBy
     , TT.ItemModifiedWhen
     , NULL AS IsProcessedForHa
     , 'NA' AS TXTKEY1
     , NULL AS TXTVAL1
     , 'NA' AS TXTKEY2
     , NULL AS TXTVAL2
     , 'NA' AS TXTKEY3
     , NULL AS TXTVAL3
     , NULL AS ItemOrder
     , NULL AS ItemGuid
     , C.UserGuid
     , PP.MPI
     , PP.ClientCode
     , S.SiteGUID
     , ACCT.AccountID
     , ACCT.AccountCD
     , T.IsAvailable
     , T.IsCustom
     , T.UniqueName
     , T.UniqueName AS ColDesc
     , NULL AS VendorID	--VENDOR.ItemID as VendorID
     ,
       NULL AS VendorName --VENDOR.VendorName
       FROM
            dbo.HFit_TrackerHighFatFoods AS TT
                INNER JOIN dbo.CMS_User AS C
                ON C.UserID = TT.UserID
                INNER JOIN dbo.hfit_ppteligibility AS PP
                ON TT.UserID = PP.userID
                INNER JOIN dbo.HFit_Account AS ACCT
                ON PP.ClientCode = ACCT.AccountCD
                INNER JOIN dbo.CMS_Site AS S
                ON ACCT.SiteID = S.SiteID
                INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
                ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                LEFT OUTER JOIN dbo.HFIT_Tracker AS T
                ON T.AggregateTableName = 'HFit_TrackerHighFatFoods'
--left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID
UNION ALL
SELECT DISTINCT
       'HFit_TrackerHighSodiumFoods' AS TrackerNameAggregateTable
     , TT.ItemID
     , EventDate
     , TT.IsProfessionallyCollected
     , TT.TrackerCollectionSourceID
     , Notes
     , TT.UserID
     , CollectionSourceName_Internal
     , CollectionSourceName_External
     , 'MISSING' AS EventName
     , 'Occurs' AS UOM
     , 'Times' AS KEY1
     , CAST ( Times AS float) AS VAL1
     , 'NA' AS KEY2
     , NULL AS VAL2
     , 'NA' AS KEY3
     , NULL AS VAL3
     , 'NA' AS KEY4
     , NULL AS VAL4
     , 'NA' AS KEY5
     , NULL AS VAL5
     , 'NA' AS KEY6
     , NULL AS VAL6
     , 'NA' AS KEY7
     , NULL AS VAL7
     , 'NA' AS KEY8
     , NULL AS VAL8
     , 'NA' AS KEY9
     , NULL AS VAL9
     , 'NA' AS KEY10
     , NULL AS VAL10
     , TT.ItemCreatedBy
     , TT.ItemCreatedWhen
     , TT.ItemModifiedBy
     , TT.ItemModifiedWhen
     , NULL AS IsProcessedForHa
     , 'NA' AS TXTKEY1
     , NULL AS TXTVAL1
     , 'NA' AS TXTKEY2
     , NULL AS TXTVAL2
     , 'NA' AS TXTKEY3
     , NULL AS TXTVAL3
     , NULL AS ItemOrder
     , NULL AS ItemGuid
     , C.UserGuid
     , PP.MPI
     , PP.ClientCode
     , S.SiteGUID
     , ACCT.AccountID
     , ACCT.AccountCD
     , T.IsAvailable
     , T.IsCustom
     , T.UniqueName
     , T.UniqueName AS ColDesc
     , NULL AS VendorID	--VENDOR.ItemID as VendorID
     ,
       NULL AS VendorName --VENDOR.VendorName
       FROM
            dbo.HFit_TrackerHighSodiumFoods AS TT
                INNER JOIN dbo.CMS_User AS C
                ON C.UserID = TT.UserID
                INNER JOIN dbo.hfit_ppteligibility AS PP
                ON TT.UserID = PP.userID
                INNER JOIN dbo.HFit_Account AS ACCT
                ON PP.ClientCode = ACCT.AccountCD
                INNER JOIN dbo.CMS_Site AS S
                ON ACCT.SiteID = S.SiteID
                INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
                ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                LEFT OUTER JOIN dbo.HFIT_Tracker AS T
                ON T.AggregateTableName = 'HFit_TrackerHighSodiumFoods'
--left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID
UNION ALL
--w/o  distinct 00:02:07 @ 477120 PRD1
--with distinct 00:03:20 @ 475860 PRD1
--(03.20.2015) - (WDM) verified SELECT DISTINCT to this qry in order to eliminate duplicate rows found by John C.
SELECT DISTINCT 'HFit_TrackerInstance_Tracker' AS TrackerNameAggregateTable ,
                     TT.ItemID ,
                     EventDate ,
                     TT.IsProfessionallyCollected ,
                     TT.TrackerCollectionSourceID ,
                     Notes ,
                     TT.UserID ,
                     CollectionSourceName_Internal ,
                     CollectionSourceName_External ,
                     'MISSING' AS EventName ,
                     'Y/N' AS UOM ,
                     'TrackerDefID' AS KEY1 ,
                     CAST (TrackerDefID AS float) AS VAL1 ,
                     'YesNoValue' AS KEY2 ,
                     CAST (YesNoValue AS float) AS VAL2 ,
                     'NA' AS KEY3 ,
                     NULL AS VAL3 ,
                     'NA' AS KEY4 ,
                     NULL AS VAL4 ,
                     'NA' AS KEY5 ,
                     NULL AS VAL5 ,
                     'NA' AS KEY6 ,
                     NULL AS VAL6 ,
                     'NA' AS KEY7 ,
                     NULL AS VAL7 ,
                     'NA' AS KEY8 ,
                     NULL AS VAL8 ,
                     'NA' AS KEY9 ,
                     NULL AS VAL9 ,
                     'NA' AS KEY10 ,
                     NULL AS VAL10 ,
                     TT.ItemCreatedBy ,
                     TT.ItemCreatedWhen ,
                     TT.ItemModifiedBy ,
                     TT.ItemModifiedWhen ,
                     NULL AS IsProcessedForHa ,
                     'NA' AS TXTKEY1 ,
                     NULL AS TXTVAL1 ,
                     'NA' AS TXTKEY2 ,
                     NULL AS TXTVAL2 ,
                     'NA' AS TXTKEY3 ,
                     NULL AS TXTVAL3 ,
                     NULL AS ItemOrder ,
                     NULL AS ItemGuid ,
                     C.UserGuid ,
                     PP.MPI ,
                     PP.ClientCode ,
                     S.SiteGUID ,
                     ACCT.AccountID ,
                     ACCT.AccountCD ,
                     T.IsAvailable ,
                     T.IsCustom ,
                     T.UniqueName ,
                     T.UniqueName AS ColDesc ,
                     NULL AS VendorID,
                     NULL AS VendorName
          FROM dbo.HFit_TrackerInstance_Tracker AS TT
                              INNER JOIN dbo.HFit_TrackerDef_Tracker TDT     
                                  ON TDT.trackerid = TT.trackerDefID
                           INNER JOIN dbo.CMS_User AS C
                                  ON C.UserID = TT.UserID
                           INNER JOIN dbo.hfit_ppteligibility AS PP
                                  ON TT.UserID = PP.userID
                           INNER JOIN dbo.HFit_Account AS ACCT
                                  ON PP.ClientCode = ACCT.AccountCD
                           INNER JOIN dbo.CMS_Site AS S
                                  ON ACCT.SiteID = S.SiteID
                           INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
                                  ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                           LEFT OUTER JOIN dbo.HFIT_Tracker AS T
                                  ON T.AggregateTableName = 'HFit_TrackerInstance_Tracker'
                                                         AND T.uniquename = TDT.name
UNION ALL
SELECT DISTINCT
       'HFit_TrackerMealPortions' AS TrackerNameAggregateTable
     , TT.ItemID
     , EventDate
     , TT.IsProfessionallyCollected
     , TT.TrackerCollectionSourceID
     , Notes
     , TT.UserID
     , CollectionSourceName_Internal
     , CollectionSourceName_External
     , 'MISSING' AS EventName
     , 'NA-portion' AS UOM
     , 'Portions' AS KEY1
     , CAST ( Portions AS float) AS VAL1
     , 'NA' AS KEY2
     , NULL AS VAL2
     , 'NA' AS KEY3
     , NULL AS VAL3
     , 'NA' AS KEY4
     , NULL AS VAL4
     , 'NA' AS KEY5
     , NULL AS VAL5
     , 'NA' AS KEY6
     , NULL AS VAL6
     , 'NA' AS KEY7
     , NULL AS VAL7
     , 'NA' AS KEY8
     , NULL AS VAL8
     , 'NA' AS KEY9
     , NULL AS VAL9
     , 'NA' AS KEY10
     , NULL AS VAL10
     , TT.ItemCreatedBy
     , TT.ItemCreatedWhen
     , TT.ItemModifiedBy
     , TT.ItemModifiedWhen
     , NULL AS IsProcessedForHa
     , 'NA' AS TXTKEY1
     , NULL AS TXTVAL1
     , 'NA' AS TXTKEY2
     , NULL AS TXTVAL2
     , 'NA' AS TXTKEY3
     , NULL AS TXTVAL3
     , NULL AS ItemOrder
     , NULL AS ItemGuid
     , C.UserGuid
     , PP.MPI
     , PP.ClientCode
     , S.SiteGUID
     , ACCT.AccountID
     , ACCT.AccountCD
     , T.IsAvailable
     , T.IsCustom
     , T.UniqueName
     , T.UniqueName AS ColDesc
     , NULL AS VendorID	--VENDOR.ItemID as VendorID
     ,
       NULL AS VendorName --VENDOR.VendorName
       FROM
            dbo.HFit_TrackerMealPortions AS TT
                INNER JOIN dbo.CMS_User AS C
                ON C.UserID = TT.UserID
                INNER JOIN dbo.hfit_ppteligibility AS PP
                ON TT.UserID = PP.userID
                INNER JOIN dbo.HFit_Account AS ACCT
                ON PP.ClientCode = ACCT.AccountCD
                INNER JOIN dbo.CMS_Site AS S
                ON ACCT.SiteID = S.SiteID
                INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
                ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                LEFT OUTER JOIN dbo.HFIT_Tracker AS T
                ON T.AggregateTableName = 'HFit_TrackerMealPortions'
--left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID
UNION ALL
SELECT DISTINCT
       'HFit_TrackerMedicalCarePlan' AS TrackerNameAggregateTable
     , TT.ItemID
     , EventDate
     , TT.IsProfessionallyCollected
     , TT.TrackerCollectionSourceID
     , Notes
     , TT.UserID
     , CollectionSourceName_Internal
     , CollectionSourceName_External
     , 'MISSING' AS EventName
     , 'Y/N' AS UOM
     , 'FollowedPlan' AS KEY1
     , CAST ( FollowedPlan AS float) AS VAL1
     , 'NA' AS KEY2
     , NULL AS VAL2
     , 'NA' AS KEY3
     , NULL AS VAL3
     , 'NA' AS KEY4
     , NULL AS VAL4
     , 'NA' AS KEY5
     , NULL AS VAL5
     , 'NA' AS KEY6
     , NULL AS VAL6
     , 'NA' AS KEY7
     , NULL AS VAL7
     , 'NA' AS KEY8
     , NULL AS VAL8
     , 'NA' AS KEY9
     , NULL AS VAL9
     , 'NA' AS KEY10
     , NULL AS VAL10
     , TT.ItemCreatedBy
     , TT.ItemCreatedWhen
     , TT.ItemModifiedBy
     , TT.ItemModifiedWhen
     , NULL AS IsProcessedForHa
     , 'NA' AS TXTKEY1
     , NULL AS TXTVAL1
     , 'NA' AS TXTKEY2
     , NULL AS TXTVAL2
     , 'NA' AS TXTKEY3
     , NULL AS TXTVAL3
     , NULL AS ItemOrder
     , NULL AS ItemGuid
     , C.UserGuid
     , PP.MPI
     , PP.ClientCode
     , S.SiteGUID
     , ACCT.AccountID
     , ACCT.AccountCD
     , T.IsAvailable
     , T.IsCustom
     , T.UniqueName
     , T.UniqueName AS ColDesc
     , NULL AS VendorID	--VENDOR.ItemID as VendorID
     ,
       NULL AS VendorName --VENDOR.VendorName
       FROM
            dbo.HFit_TrackerMedicalCarePlan AS TT
                INNER JOIN dbo.CMS_User AS C
                ON C.UserID = TT.UserID
                INNER JOIN dbo.hfit_ppteligibility AS PP
                ON TT.UserID = PP.userID
                INNER JOIN dbo.HFit_Account AS ACCT
                ON PP.ClientCode = ACCT.AccountCD
                INNER JOIN dbo.CMS_Site AS S
                ON ACCT.SiteID = S.SiteID
                INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
                ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                LEFT OUTER JOIN dbo.HFIT_Tracker AS T
                ON T.AggregateTableName = 'HFit_TrackerMedicalCarePlan'
--left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID
UNION ALL
SELECT DISTINCT
       'HFit_TrackerRegularMeals' AS TrackerNameAggregateTable
     , TT.ItemID
     , EventDate
     , TT.IsProfessionallyCollected
     , TT.TrackerCollectionSourceID
     , Notes
     , TT.UserID
     , CollectionSourceName_Internal
     , CollectionSourceName_External
     , 'MISSING' AS EventName
     , 'Occurs' AS UOM
     , 'Units' AS KEY1
     , CAST ( Units AS float) AS VAL1
     , 'NA' AS KEY2
     , NULL AS VAL2
     , 'NA' AS KEY3
     , NULL AS VAL3
     , 'NA' AS KEY4
     , NULL AS VAL4
     , 'NA' AS KEY5
     , NULL AS VAL5
     , 'NA' AS KEY6
     , NULL AS VAL6
     , 'NA' AS KEY7
     , NULL AS VAL7
     , 'NA' AS KEY8
     , NULL AS VAL8
     , 'NA' AS KEY9
     , NULL AS VAL9
     , 'NA' AS KEY10
     , NULL AS VAL10
     , TT.ItemCreatedBy
     , TT.ItemCreatedWhen
     , TT.ItemModifiedBy
     , TT.ItemModifiedWhen
     , NULL AS IsProcessedForHa
     , 'NA' AS TXTKEY1
     , NULL AS TXTVAL1
     , 'NA' AS TXTKEY2
     , NULL AS TXTVAL2
     , 'NA' AS TXTKEY3
     , NULL AS TXTVAL3
     , NULL AS ItemOrder
     , NULL AS ItemGuid
     , C.UserGuid
     , PP.MPI
     , PP.ClientCode
     , S.SiteGUID
     , ACCT.AccountID
     , ACCT.AccountCD
     , T.IsAvailable
     , T.IsCustom
     , T.UniqueName
     , T.UniqueName AS ColDesc
     , NULL AS VendorID	--VENDOR.ItemID as VendorID
     ,
       NULL AS VendorName --VENDOR.VendorName
       FROM
            dbo.HFit_TrackerRegularMeals AS TT
                INNER JOIN dbo.CMS_User AS C
                ON C.UserID = TT.UserID
                INNER JOIN dbo.hfit_ppteligibility AS PP
                ON TT.UserID = PP.userID
                INNER JOIN dbo.HFit_Account AS ACCT
                ON PP.ClientCode = ACCT.AccountCD
                INNER JOIN dbo.CMS_Site AS S
                ON ACCT.SiteID = S.SiteID
                INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
                ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                LEFT OUTER JOIN dbo.HFIT_Tracker AS T
                ON T.AggregateTableName = 'HFit_TrackerRegularMeals'
--left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID
UNION ALL
SELECT DISTINCT
       'HFit_TrackerRestingHeartRate' AS TrackerNameAggregateTable
     , TT.ItemID
     , EventDate
     , TT.IsProfessionallyCollected
     , TT.TrackerCollectionSourceID
     , Notes
     , TT.UserID
     , CollectionSourceName_Internal
     , CollectionSourceName_External
     , 'MISSING' AS EventName
     , 'BPM' AS UOM
     , 'HeartRate' AS KEY1
     , CAST ( HeartRate AS float) AS VAL1
     , 'NA' AS KEY2
     , NULL AS VAL2
     , 'NA' AS KEY3
     , NULL AS VAL3
     , 'NA' AS KEY4
     , NULL AS VAL4
     , 'NA' AS KEY5
     , NULL AS VAL5
     , 'NA' AS KEY6
     , NULL AS VAL6
     , 'NA' AS KEY7
     , NULL AS VAL7
     , 'NA' AS KEY8
     , NULL AS VAL8
     , 'NA' AS KEY9
     , NULL AS VAL9
     , 'NA' AS KEY10
     , NULL AS VAL10
     , TT.ItemCreatedBy
     , TT.ItemCreatedWhen
     , TT.ItemModifiedBy
     , TT.ItemModifiedWhen
     , NULL AS IsProcessedForHa
     , 'NA' AS TXTKEY1
     , NULL AS TXTVAL1
     , 'NA' AS TXTKEY2
     , NULL AS TXTVAL2
     , 'NA' AS TXTKEY3
     , NULL AS TXTVAL3
     , NULL AS ItemOrder
     , NULL AS ItemGuid
     , C.UserGuid
     , PP.MPI
     , PP.ClientCode
     , S.SiteGUID
     , ACCT.AccountID
     , ACCT.AccountCD
     , T.IsAvailable
     , T.IsCustom
     , T.UniqueName
     , T.UniqueName AS ColDesc
     , VENDOR.ItemID AS VendorID
     , VENDOR.VendorName
       FROM
            dbo.HFit_TrackerRestingHeartRate AS TT
                INNER JOIN dbo.CMS_User AS C
                ON C.UserID = TT.UserID
                INNER JOIN dbo.hfit_ppteligibility AS PP
                ON TT.UserID = PP.userID
                INNER JOIN dbo.HFit_Account AS ACCT
                ON PP.ClientCode = ACCT.AccountCD
                INNER JOIN dbo.CMS_Site AS S
                ON ACCT.SiteID = S.SiteID
                INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
                ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                LEFT OUTER JOIN dbo.HFIT_Tracker AS T
                ON T.AggregateTableName = 'HFit_TrackerRestingHeartRate'
                LEFT OUTER JOIN HFit_LKP_TrackerVendor AS VENDOR
                ON TT.VendorID = VENDOR.ItemID
UNION ALL
--With DISTINCT 00:14 @ 40041
--With NO DISTINCT 00:14 @ 40060
--(03.20.2015) - (WDM) added a SELECT DISTINCT to this qry in order to eliminate duplicate rows found by John C.
SELECT DISTINCT
       'HFit_TrackerShots' AS TrackerNameAggregateTable
     , TT.ItemID
     , EventDate
     , TT.IsProfessionallyCollected
     , TT.TrackerCollectionSourceID
     , Notes
     , TT.UserID
     , CollectionSourceName_Internal
     , CollectionSourceName_External
     , 'MISSING' AS EventName
     , 'Y/N' AS UOM
     , 'FluShot' AS KEY1
     , CAST ( FluShot AS float) AS VAL1
     , 'PneumoniaShot' AS KEY2
     , CAST ( PneumoniaShot AS float) AS VAL2
     , 'NA' AS KEY3
     , NULL AS VAL3
     , 'NA' AS KEY4
     , NULL AS VAL4
     , 'NA' AS KEY5
     , NULL AS VAL5
     , 'NA' AS KEY6
     , NULL AS VAL6
     , 'NA' AS KEY7
     , NULL AS VAL7
     , 'NA' AS KEY8
     , NULL AS VAL8
     , 'NA' AS KEY9
     , NULL AS VAL9
     , 'NA' AS KEY10
     , NULL AS VAL10
     , TT.ItemCreatedBy
     , TT.ItemCreatedWhen
     , TT.ItemModifiedBy
     , TT.ItemModifiedWhen
     , NULL AS IsProcessedForHa
     , 'NA' AS TXTKEY1
     , NULL AS TXTVAL1
     , 'NA' AS TXTKEY2
     , NULL AS TXTVAL2
     , 'NA' AS TXTKEY3
     , NULL AS TXTVAL3
     , TT.ItemOrder
     , TT.ItemGuid
     , C.UserGuid
     , PP.MPI
     , PP.ClientCode
     , S.SiteGUID
     , ACCT.AccountID
     , ACCT.AccountCD
     , T.IsAvailable
     , T.IsCustom
     , T.UniqueName
     , T.UniqueName AS ColDesc
     , VENDOR.ItemID AS VendorID
     , VENDOR.VendorName
       FROM
            dbo.HFit_TrackerShots AS TT
                INNER JOIN dbo.CMS_User AS C
                ON C.UserID = TT.UserID
                INNER JOIN dbo.hfit_ppteligibility AS PP
                ON TT.UserID = PP.userID
                INNER JOIN dbo.HFit_Account AS ACCT
                ON PP.ClientCode = ACCT.AccountCD
                INNER JOIN dbo.CMS_Site AS S
                ON ACCT.SiteID = S.SiteID
                INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
                ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                LEFT OUTER JOIN dbo.HFIT_Tracker AS T
                ON T.AggregateTableName = 'HFit_TrackerShots'
                LEFT OUTER JOIN HFit_LKP_TrackerVendor AS VENDOR
                ON TT.VendorID = VENDOR.ItemID
UNION ALL
SELECT DISTINCT
       'HFit_TrackerSitLess' AS TrackerNameAggregateTable
     , TT.ItemID
     , EventDate
     , TT.IsProfessionallyCollected
     , TT.TrackerCollectionSourceID
     , Notes
     , TT.UserID
     , CollectionSourceName_Internal
     , CollectionSourceName_External
     , 'MISSING' AS EventName
     , 'Occurs' AS UOM
     , 'Times' AS KEY1
     , CAST ( Times AS float) AS VAL1
     , 'NA' AS KEY2
     , NULL AS VAL2
     , 'NA' AS KEY3
     , NULL AS VAL3
     , 'NA' AS KEY4
     , NULL AS VAL4
     , 'NA' AS KEY5
     , NULL AS VAL5
     , 'NA' AS KEY6
     , NULL AS VAL6
     , 'NA' AS KEY7
     , NULL AS VAL7
     , 'NA' AS KEY8
     , NULL AS VAL8
     , 'NA' AS KEY9
     , NULL AS VAL9
     , 'NA' AS KEY10
     , NULL AS VAL10
     , TT.ItemCreatedBy
     , TT.ItemCreatedWhen
     , TT.ItemModifiedBy
     , TT.ItemModifiedWhen
     , NULL AS IsProcessedForHa
     , 'NA' AS TXTKEY1
     , NULL AS TXTVAL1
     , 'NA' AS TXTKEY2
     , NULL AS TXTVAL2
     , 'NA' AS TXTKEY3
     , NULL AS TXTVAL3
     , NULL AS ItemOrder
     , NULL AS ItemGuid
     , C.UserGuid
     , PP.MPI
     , PP.ClientCode
     , S.SiteGUID
     , ACCT.AccountID
     , ACCT.AccountCD
     , T.IsAvailable
     , T.IsCustom
     , T.UniqueName
     , T.UniqueName AS ColDesc
     , NULL AS VendorID	--VENDOR.ItemID as VendorID
     ,
       NULL AS VendorName --VENDOR.VendorName
       FROM
            dbo.HFit_TrackerSitLess AS TT
                INNER JOIN dbo.CMS_User AS C
                ON C.UserID = TT.UserID
                INNER JOIN dbo.hfit_ppteligibility AS PP
                ON TT.UserID = PP.userID
                INNER JOIN dbo.HFit_Account AS ACCT
                ON PP.ClientCode = ACCT.AccountCD
                INNER JOIN dbo.CMS_Site AS S
                ON ACCT.SiteID = S.SiteID
                INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
                ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                LEFT OUTER JOIN dbo.HFIT_Tracker AS T
                ON T.AggregateTableName = 'HFit_TrackerSitLess'
--left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID
UNION ALL
SELECT DISTINCT
       'HFit_TrackerSleepPlan' AS TrackerNameAggregateTable
     , TT.ItemID
     , EventDate
     , TT.IsProfessionallyCollected
     , TT.TrackerCollectionSourceID
     , Notes
     , TT.UserID
     , CollectionSourceName_Internal
     , CollectionSourceName_External
     , 'MISSING' AS EventName
     , 'HR' AS UOM
     , 'DidFollow' AS KEY1
     , CAST ( DidFollow AS float) AS VAL1
     , 'HoursSlept' AS KEY2
     , HoursSlept AS VAL2
     , 'NA' AS KEY3
     , NULL AS VAL3
     , 'NA' AS KEY4
     , NULL AS VAL4
     , 'NA' AS KEY5
     , NULL AS VAL5
     , 'NA' AS KEY6
     , NULL AS VAL6
     , 'NA' AS KEY7
     , NULL AS VAL7
     , 'NA' AS KEY8
     , NULL AS VAL8
     , 'NA' AS KEY9
     , NULL AS VAL9
     , 'NA' AS KEY10
     , NULL AS VAL10
     , TT.ItemCreatedBy
     , TT.ItemCreatedWhen
     , TT.ItemModifiedBy
     , TT.ItemModifiedWhen
     , NULL AS IsProcessedForHa
     , 'Techniques' AS TXTKEY1
     , Techniques AS TXTVAL1
     , 'NA' AS TXTKEY2
     , NULL AS TXTVAL2
     , 'NA' AS TXTKEY3
     , NULL AS TXTVAL3
     , NULL AS ItemOrder
     , NULL AS ItemGuid
     , C.UserGuid
     , PP.MPI
     , PP.ClientCode
     , S.SiteGUID
     , ACCT.AccountID
     , ACCT.AccountCD
     , T.IsAvailable
     , T.IsCustom
     , T.UniqueName
     , T.UniqueName AS ColDesc
     , NULL AS VendorID	--VENDOR.ItemID as VendorID
     ,
       NULL AS VendorName --VENDOR.VendorName
       FROM
            dbo.HFit_TrackerSleepPlan AS TT
                INNER JOIN dbo.CMS_User AS C
                ON C.UserID = TT.UserID
                INNER JOIN dbo.hfit_ppteligibility AS PP
                ON TT.UserID = PP.userID
                INNER JOIN dbo.HFit_Account AS ACCT
                ON PP.ClientCode = ACCT.AccountCD
                INNER JOIN dbo.CMS_Site AS S
                ON ACCT.SiteID = S.SiteID
                INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
                ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                LEFT OUTER JOIN dbo.HFIT_Tracker AS T
                ON T.AggregateTableName = 'HFit_TrackerSleepPlan'
--left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID
UNION ALL
SELECT DISTINCT
       'HFit_TrackerStrength' AS TrackerNameAggregateTable
     , TT.ItemID
     , EventDate
     , TT.IsProfessionallyCollected
     , TT.TrackerCollectionSourceID
     , Notes
     , TT.UserID
     , CollectionSourceName_Internal
     , CollectionSourceName_External
     , 'MISSING' AS EventName
     , 'Y/N' AS UOM
     , 'HasTrained' AS KEY1
     , CAST ( HasTrained AS float) AS VAL1
     , 'NA' AS KEY2
     , NULL AS VAL2
     , 'NA' AS KEY3
     , NULL AS VAL3
     , 'NA' AS KEY4
     , NULL AS VAL4
     , 'NA' AS KEY5
     , NULL AS VAL5
     , 'NA' AS KEY6
     , NULL AS VAL6
     , 'NA' AS KEY7
     , NULL AS VAL7
     , 'NA' AS KEY8
     , NULL AS VAL8
     , 'NA' AS KEY9
     , NULL AS VAL9
     , 'NA' AS KEY10
     , NULL AS VAL10
     , TT.ItemCreatedBy
     , TT.ItemCreatedWhen
     , TT.ItemModifiedBy
     , TT.ItemModifiedWhen
     , NULL AS IsProcessedForHa
     , 'Activity' AS TXTKEY1
     , Activity AS TXTVAL1
     , 'NA' AS TXTKEY2
     , NULL AS TXTVAL2
     , 'NA' AS TXTKEY3
     , NULL AS TXTVAL3
     , NULL AS ItemOrder
     , NULL AS ItemGuid
     , C.UserGuid
     , PP.MPI
     , PP.ClientCode
     , S.SiteGUID
     , ACCT.AccountID
     , ACCT.AccountCD
     , T.IsAvailable
     , T.IsCustom
     , T.UniqueName
     , T.UniqueName AS ColDesc
     , NULL AS VendorID	--VENDOR.ItemID as VendorID
     ,
       NULL AS VendorName --VENDOR.VendorName
       FROM
            dbo.HFit_TrackerStrength AS TT
                INNER JOIN dbo.CMS_User AS C
                ON C.UserID = TT.UserID
                INNER JOIN dbo.hfit_ppteligibility AS PP
                ON TT.UserID = PP.userID
                INNER JOIN dbo.HFit_Account AS ACCT
                ON PP.ClientCode = ACCT.AccountCD
                INNER JOIN dbo.CMS_Site AS S
                ON ACCT.SiteID = S.SiteID
                INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
                ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                LEFT OUTER JOIN dbo.HFIT_Tracker AS T
                ON T.AggregateTableName = 'HFit_TrackerStrength'
--left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID
UNION ALL
SELECT DISTINCT
       'HFit_TrackerStress' AS TrackerNameAggregateTable
     , TT.ItemID
     , EventDate
     , TT.IsProfessionallyCollected
     , TT.TrackerCollectionSourceID
     , Notes
     , TT.UserID
     , CollectionSourceName_Internal
     , CollectionSourceName_External
     , 'MISSING' AS EventName
     , 'gradient' AS UOM
     , 'Intensity' AS KEY1
     , CAST ( Intensity AS float) AS VAL1
     , 'NA' AS KEY2
     , NULL AS VAL2
     , 'NA' AS KEY3
     , NULL AS VAL3
     , 'NA' AS KEY4
     , NULL AS VAL4
     , 'NA' AS KEY5
     , NULL AS VAL5
     , 'NA' AS KEY6
     , NULL AS VAL6
     , 'NA' AS KEY7
     , NULL AS VAL7
     , 'NA' AS KEY8
     , NULL AS VAL8
     , 'NA' AS KEY9
     , NULL AS VAL9
     , 'NA' AS KEY10
     , NULL AS VAL10
     , TT.ItemCreatedBy
     , TT.ItemCreatedWhen
     , TT.ItemModifiedBy
     , TT.ItemModifiedWhen
     , NULL AS IsProcessedForHa
     , 'Awareness' AS TXTKEY1
     , Awareness AS TXTVAL1
     , 'NA' AS TXTKEY2
     , NULL AS TXTVAL2
     , 'NA' AS TXTKEY3
     , NULL AS TXTVAL3
     , NULL AS ItemOrder
     , NULL AS ItemGuid
     , C.UserGuid
     , PP.MPI
     , PP.ClientCode
     , S.SiteGUID
     , ACCT.AccountID
     , ACCT.AccountCD
     , T.IsAvailable
     , T.IsCustom
     , T.UniqueName
     , T.UniqueName AS ColDesc
     , NULL AS VendorID	--VENDOR.ItemID as VendorID
     ,
       NULL AS VendorName --VENDOR.VendorName
       FROM
            dbo.HFit_TrackerStress AS TT
                INNER JOIN dbo.CMS_User AS C
                ON C.UserID = TT.UserID
                INNER JOIN dbo.hfit_ppteligibility AS PP
                ON TT.UserID = PP.userID
                INNER JOIN dbo.HFit_Account AS ACCT
                ON PP.ClientCode = ACCT.AccountCD
                INNER JOIN dbo.CMS_Site AS S
                ON ACCT.SiteID = S.SiteID
                INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
                ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                LEFT OUTER JOIN dbo.HFIT_Tracker AS T
                ON T.AggregateTableName = 'HFit_TrackerStress'
--left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID
UNION ALL
SELECT DISTINCT
       'HFit_TrackerStressManagement' AS TrackerNameAggregateTable
     , TT.ItemID
     , EventDate
     , TT.IsProfessionallyCollected
     , TT.TrackerCollectionSourceID
     , Notes
     , TT.UserID
     , CollectionSourceName_Internal
     , CollectionSourceName_External
     , 'MISSING' AS EventName
     , 'gradient' AS UOM
     , 'HasPracticed' AS KEY1
     , CAST ( HasPracticed AS float) AS VAL1
     , 'Effectiveness' AS KEY2
     , CAST ( Effectiveness AS float) AS VAL2
     , 'NA' AS KEY3
     , NULL AS VAL3
     , 'NA' AS KEY4
     , NULL AS VAL4
     , 'NA' AS KEY5
     , NULL AS VAL5
     , 'NA' AS KEY6
     , NULL AS VAL6
     , 'NA' AS KEY7
     , NULL AS VAL7
     , 'NA' AS KEY8
     , NULL AS VAL8
     , 'NA' AS KEY9
     , NULL AS VAL9
     , 'NA' AS KEY10
     , NULL AS VAL10
     , TT.ItemCreatedBy
     , TT.ItemCreatedWhen
     , TT.ItemModifiedBy
     , TT.ItemModifiedWhen
     , NULL AS IsProcessedForHa
     , 'Activity' AS TXTKEY1
     , Activity AS TXTVAL1
     , 'NA' AS TXTKEY2
     , NULL AS TXTVAL2
     , 'NA' AS TXTKEY3
     , NULL AS TXTVAL3
     , NULL AS ItemOrder
     , NULL AS ItemGuid
     , C.UserGuid
     , PP.MPI
     , PP.ClientCode
     , S.SiteGUID
     , ACCT.AccountID
     , ACCT.AccountCD
     , T.IsAvailable
     , T.IsCustom
     , T.UniqueName
     , T.UniqueName AS ColDesc
     , NULL AS VendorID	--VENDOR.ItemID as VendorID
     ,
       NULL AS VendorName --VENDOR.VendorName
       FROM
            dbo.HFit_TrackerStressManagement AS TT
                INNER JOIN dbo.CMS_User AS C
                ON C.UserID = TT.UserID
                INNER JOIN dbo.hfit_ppteligibility AS PP
                ON TT.UserID = PP.userID
                INNER JOIN dbo.HFit_Account AS ACCT
                ON PP.ClientCode = ACCT.AccountCD
                INNER JOIN dbo.CMS_Site AS S
                ON ACCT.SiteID = S.SiteID
                INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
                ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                LEFT OUTER JOIN dbo.HFIT_Tracker AS T
                ON T.AggregateTableName = 'HFit_TrackerStressManagement'
--left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID
UNION ALL
SELECT DISTINCT
       'HFit_TrackerSugaryDrinks' AS TrackerNameAggregateTable
     , TT.ItemID
     , EventDate
     , TT.IsProfessionallyCollected
     , TT.TrackerCollectionSourceID
     , Notes
     , TT.UserID
     , CollectionSourceName_Internal
     , CollectionSourceName_External
     , 'MISSING' AS EventName
     , 'OZ' AS UOM
     , 'Ounces' AS KEY1
     , CAST ( Ounces AS float) AS VAL1
     , 'NA' AS KEY2
     , NULL AS VAL2
     , 'NA' AS KEY3
     , NULL AS VAL3
     , 'NA' AS KEY4
     , NULL AS VAL4
     , 'NA' AS KEY5
     , NULL AS VAL5
     , 'NA' AS KEY6
     , NULL AS VAL6
     , 'NA' AS KEY7
     , NULL AS VAL7
     , 'NA' AS KEY8
     , NULL AS VAL8
     , 'NA' AS KEY9
     , NULL AS VAL9
     , 'NA' AS KEY10
     , NULL AS VAL10
     , TT.ItemCreatedBy
     , TT.ItemCreatedWhen
     , TT.ItemModifiedBy
     , TT.ItemModifiedWhen
     , NULL AS IsProcessedForHa
     , 'NA' AS TXTKEY1
     , NULL AS TXTVAL1
     , 'NA' AS TXTKEY2
     , NULL AS TXTVAL2
     , 'NA' AS TXTKEY3
     , NULL AS TXTVAL3
     , NULL AS ItemOrder
     , NULL AS ItemGuid
     , C.UserGuid
     , PP.MPI
     , PP.ClientCode
     , S.SiteGUID
     , ACCT.AccountID
     , ACCT.AccountCD
     , T.IsAvailable
     , T.IsCustom
     , T.UniqueName
     , T.UniqueName AS ColDesc
     , NULL AS VendorID	--VENDOR.ItemID as VendorID
     ,
       NULL AS VendorName --VENDOR.VendorName
       FROM
            dbo.HFit_TrackerSugaryDrinks AS TT
                INNER JOIN dbo.CMS_User AS C
                ON C.UserID = TT.UserID
                INNER JOIN dbo.hfit_ppteligibility AS PP
                ON TT.UserID = PP.userID
                INNER JOIN dbo.HFit_Account AS ACCT
                ON PP.ClientCode = ACCT.AccountCD
                INNER JOIN dbo.CMS_Site AS S
                ON ACCT.SiteID = S.SiteID
                INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
                ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                LEFT OUTER JOIN dbo.HFIT_Tracker AS T
                ON T.AggregateTableName = 'HFit_TrackerSugaryDrinks'
--left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID
UNION ALL
SELECT DISTINCT
       'HFit_TrackerSugaryFoods' AS TrackerNameAggregateTable
     , TT.ItemID
     , EventDate
     , TT.IsProfessionallyCollected
     , TT.TrackerCollectionSourceID
     , Notes
     , TT.UserID
     , CollectionSourceName_Internal
     , CollectionSourceName_External
     , 'MISSING' AS EventName
     , 'NA-portion' AS UOM
     , 'Portions' AS KEY1
     , CAST ( Portions AS float) AS VAL1
     , 'NA' AS KEY2
     , NULL AS VAL2
     , 'NA' AS KEY3
     , NULL AS VAL3
     , 'NA' AS KEY4
     , NULL AS VAL4
     , 'NA' AS KEY5
     , NULL AS VAL5
     , 'NA' AS KEY6
     , NULL AS VAL6
     , 'NA' AS KEY7
     , NULL AS VAL7
     , 'NA' AS KEY8
     , NULL AS VAL8
     , 'NA' AS KEY9
     , NULL AS VAL9
     , 'NA' AS KEY10
     , NULL AS VAL10
     , TT.ItemCreatedBy
     , TT.ItemCreatedWhen
     , TT.ItemModifiedBy
     , TT.ItemModifiedWhen
     , NULL AS IsProcessedForHa
     , 'NA' AS TXTKEY1
     , NULL AS TXTVAL1
     , 'NA' AS TXTKEY2
     , NULL AS TXTVAL2
     , 'NA' AS TXTKEY3
     , NULL AS TXTVAL3
     , NULL AS ItemOrder
     , NULL AS ItemGuid
     , C.UserGuid
     , PP.MPI
     , PP.ClientCode
     , S.SiteGUID
     , ACCT.AccountID
     , ACCT.AccountCD
     , T.IsAvailable
     , T.IsCustom
     , T.UniqueName
     , T.UniqueName AS ColDesc
     , NULL AS VendorID	--VENDOR.ItemID as VendorID
     ,
       NULL AS VendorName --VENDOR.VendorName
       FROM
            dbo.HFit_TrackerSugaryFoods AS TT
                INNER JOIN dbo.CMS_User AS C
                ON C.UserID = TT.UserID
                INNER JOIN dbo.hfit_ppteligibility AS PP
                ON TT.UserID = PP.userID
                INNER JOIN dbo.HFit_Account AS ACCT
                ON PP.ClientCode = ACCT.AccountCD
                INNER JOIN dbo.CMS_Site AS S
                ON ACCT.SiteID = S.SiteID
                INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
                ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                LEFT OUTER JOIN dbo.HFIT_Tracker AS T
                ON T.AggregateTableName = 'HFit_TrackerSugaryFoods'
--left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID
UNION ALL
--Using DISTINCT PROD1 - 00:08:41 @ 40313
--Using DISTINCT PRD1 - 00:00:09 @ 45502
--Using NO DISTINCT PRD1 00:19 @ 40332
--Using DISTINCT PRD1 - 00:00:11 @ 44483
--(03.20.2015) - (WDM) added a SELECT DISTINCT to this qry in order to eliminate duplicate rows found by John C.
SELECT DISTINCT
       'HFit_TrackerTests' AS TrackerNameAggregateTable
     , TT.ItemID
     , EventDate
     , TT.IsProfessionallyCollected
     , TT.TrackerCollectionSourceID
     , Notes
     , TT.UserID
     , CollectionSourceName_Internal
     , CollectionSourceName_External
     , 'MISSING' AS EventName
     , 'NA' AS UOM
     , 'PSATest' AS KEY1
     , CAST ( PSATest AS float) AS VAL1
     , 'OtherExam' AS KEY1
     , CAST ( OtherExam AS float) AS VAL2
     , 'TScore' AS KEY3
     , CAST ( TScore AS float) AS VAL3
     , 'DRA' AS KEY4
     , CAST ( DRA AS float) AS VAL4
     , 'CotinineTest' AS KEY5
     , CAST ( CotinineTest AS float) AS VAL5
     , 'ColoCareKit' AS KEY6
     , CAST ( ColoCareKit AS float) AS VAL6
     , 'CustomTest' AS KEY7
     , CAST ( CustomTest AS float) AS VAL7
     , 'TSH' AS KEY8
     , CAST ( TSH AS float) AS VAL8
     , 'NA' AS KEY9
     , NULL AS VAL9
     , 'NA' AS KEY10
     , NULL AS VAL10
     , TT.ItemCreatedBy
     , TT.ItemCreatedWhen
     , TT.ItemModifiedBy
     , TT.ItemModifiedWhen
     , NULL AS IsProcessedForHa
     , 'CustomDesc' AS TXTKEY1
     , CustomDesc AS TXTVAL1
     , 'NA' AS TXTKEY2
     , NULL AS TXTVAL2
     , 'NA' AS TXTKEY3
     , NULL AS TXTVAL3
     , TT.ItemOrder
     , TT.ItemGuid
     , C.UserGuid
     , PP.MPI
     , PP.ClientCode
     , S.SiteGUID
     , ACCT.AccountID
     , ACCT.AccountCD
     , T.IsAvailable
     , T.IsCustom
     , T.UniqueName
     , T.UniqueName AS ColDesc
     , VENDOR.ItemID AS VendorID
     , VENDOR.VendorName
       FROM
            dbo.HFit_TrackerTests AS TT
                INNER JOIN dbo.CMS_User AS C
                ON C.UserID = TT.UserID
                INNER JOIN dbo.hfit_ppteligibility AS PP
                ON TT.UserID = PP.userID
                INNER JOIN dbo.HFit_Account AS ACCT
                ON PP.ClientCode = ACCT.AccountCD
                INNER JOIN dbo.CMS_Site AS S
                ON ACCT.SiteID = S.SiteID
                INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
                ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                LEFT OUTER JOIN dbo.HFIT_Tracker AS T
                ON T.AggregateTableName = 'HFit_TrackerTests'
                LEFT OUTER JOIN HFit_LKP_TrackerVendor AS VENDOR
                ON TT.VendorID = VENDOR.ItemID
UNION ALL
SELECT DISTINCT
       'HFit_TrackerTobaccoFree' AS TrackerNameAggregateTable
     , TT.ItemID
     , EventDate
     , TT.IsProfessionallyCollected
     , TT.TrackerCollectionSourceID
     , Notes
     , TT.UserID
     , CollectionSourceName_Internal
     , CollectionSourceName_External
     , 'MISSING' AS EventName
     , 'Y/N' AS UOM
     , 'WasTobaccoFree' AS KEY1
     , CAST ( WasTobaccoFree AS float) AS VAL1
     , 'NA' AS KEY2
     , NULL AS VAL2
     , 'NA' AS KEY3
     , NULL AS VAL3
     , 'NA' AS KEY4
     , NULL AS VAL4
     , 'NA' AS KEY5
     , NULL AS VAL5
     , 'NA' AS KEY6
     , NULL AS VAL6
     , 'NA' AS KEY7
     , NULL AS VAL7
     , 'NA' AS KEY8
     , NULL AS VAL8
     , 'NA' AS KEY9
     , NULL AS VAL9
     , 'NA' AS KEY10
     , NULL AS VAL10
     , TT.ItemCreatedBy
     , TT.ItemCreatedWhen
     , TT.ItemModifiedBy
     , TT.ItemModifiedWhen
     , NULL AS IsProcessedForHa
     , 'QuitAids' AS TXTKEY1
     , QuitAids AS TXTVAL1
     , 'QuitMeds' AS TXTKEY2
     , QuitMeds AS TXTVAL2
     , 'NA' AS TXTKEY3
     , NULL AS TXTVAL3
     , NULL AS ItemOrder
     , NULL AS ItemGuid
     , C.UserGuid
     , PP.MPI
     , PP.ClientCode
     , S.SiteGUID
     , ACCT.AccountID
     , ACCT.AccountCD
     , T.IsAvailable
     , T.IsCustom
     , T.UniqueName
     , T.UniqueName AS ColDesc
     , NULL AS VendorID	--VENDOR.ItemID as VendorID
     ,
       NULL AS VendorName --VENDOR.VendorName
       FROM
            dbo.HFit_TrackerTobaccoFree AS TT
                INNER JOIN dbo.CMS_User AS C
                ON C.UserID = TT.UserID
                INNER JOIN dbo.hfit_ppteligibility AS PP
                ON TT.UserID = PP.userID
                INNER JOIN dbo.HFit_Account AS ACCT
                ON PP.ClientCode = ACCT.AccountCD
                INNER JOIN dbo.CMS_Site AS S
                ON ACCT.SiteID = S.SiteID
                INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
                ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                LEFT OUTER JOIN dbo.HFIT_Tracker AS T
                ON T.AggregateTableName = 'HFit_TrackerTobaccoFree'
--left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID
UNION ALL
SELECT DISTINCT
       'HFit_TrackerVegetables' AS TrackerNameAggregateTable
     , TT.ItemID
     , EventDate
     , TT.IsProfessionallyCollected
     , TT.TrackerCollectionSourceID
     , Notes
     , TT.UserID
     , CollectionSourceName_Internal
     , CollectionSourceName_External
     , 'MISSING' AS EventName
     , 'CUP(8oz)' AS UOM
     , 'Cups' AS KEY1
     , CAST ( Cups AS float) AS VAL1
     , 'NA' AS KEY2
     , NULL AS VAL2
     , 'NA' AS KEY3
     , NULL AS VAL3
     , 'NA' AS KEY4
     , NULL AS VAL4
     , 'NA' AS KEY5
     , NULL AS VAL5
     , 'NA' AS KEY6
     , NULL AS VAL6
     , 'NA' AS KEY7
     , NULL AS VAL7
     , 'NA' AS KEY8
     , NULL AS VAL8
     , 'NA' AS KEY9
     , NULL AS VAL9
     , 'NA' AS KEY10
     , NULL AS VAL10
     , TT.ItemCreatedBy
     , TT.ItemCreatedWhen
     , TT.ItemModifiedBy
     , TT.ItemModifiedWhen
     , NULL AS IsProcessedForHa
     , 'NA' AS TXTKEY1
     , NULL AS TXTVAL1
     , 'NA' AS TXTKEY2
     , NULL AS TXTVAL2
     , 'NA' AS TXTKEY3
     , NULL AS TXTVAL3
     , NULL AS ItemOrder
     , NULL AS ItemGuid
     , C.UserGuid
     , PP.MPI
     , PP.ClientCode
     , S.SiteGUID
     , ACCT.AccountID
     , ACCT.AccountCD
     , T.IsAvailable
     , T.IsCustom
     , T.UniqueName
     , T.UniqueName AS ColDesc
     , NULL AS VendorID	--VENDOR.ItemID as VendorID
     ,
       NULL AS VendorName --VENDOR.VendorName
       FROM
            dbo.HFit_TrackerVegetables AS TT
                INNER JOIN dbo.CMS_User AS C
                ON C.UserID = TT.UserID
                INNER JOIN dbo.hfit_ppteligibility AS PP
                ON TT.UserID = PP.userID
                INNER JOIN dbo.HFit_Account AS ACCT
                ON PP.ClientCode = ACCT.AccountCD
                INNER JOIN dbo.CMS_Site AS S
                ON ACCT.SiteID = S.SiteID
                INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
                ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                LEFT OUTER JOIN dbo.HFIT_Tracker AS T
                ON T.AggregateTableName = 'HFit_TrackerVegetables'
--left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID
UNION ALL
SELECT DISTINCT
       'HFit_TrackerWater' AS TrackerNameAggregateTable
     , TT.ItemID
     , EventDate
     , TT.IsProfessionallyCollected
     , TT.TrackerCollectionSourceID
     , Notes
     , TT.UserID
     , CollectionSourceName_Internal
     , CollectionSourceName_External
     , 'MISSING' AS EventName
     , 'OZ' AS UOM
     , 'Ounces' AS KEY1
     , CAST ( Ounces AS float) AS VAL1
     , 'NA' AS KEY2
     , NULL AS VAL2
     , 'NA' AS KEY3
     , NULL AS VAL3
     , 'NA' AS KEY4
     , NULL AS VAL4
     , 'NA' AS KEY5
     , NULL AS VAL5
     , 'NA' AS KEY6
     , NULL AS VAL6
     , 'NA' AS KEY7
     , NULL AS VAL7
     , 'NA' AS KEY8
     , NULL AS VAL8
     , 'NA' AS KEY9
     , NULL AS VAL9
     , 'NA' AS KEY10
     , NULL AS VAL10
     , TT.ItemCreatedBy
     , TT.ItemCreatedWhen
     , TT.ItemModifiedBy
     , TT.ItemModifiedWhen
     , NULL AS IsProcessedForHa
     , 'NA' AS TXTKEY1
     , NULL AS TXTVAL1
     , 'NA' AS TXTKEY2
     , NULL AS TXTVAL2
     , 'NA' AS TXTKEY3
     , NULL AS TXTVAL3
     , NULL AS ItemOrder
     , NULL AS ItemGuid
     , C.UserGuid
     , PP.MPI
     , PP.ClientCode
     , S.SiteGUID
     , ACCT.AccountID
     , ACCT.AccountCD
     , T.IsAvailable
     , T.IsCustom
     , T.UniqueName
     , T.UniqueName AS ColDesc
     , NULL AS VendorID	--VENDOR.ItemID as VendorID
     ,
       NULL AS VendorName --VENDOR.VendorName
       FROM
            dbo.HFit_TrackerWater AS TT
                INNER JOIN dbo.CMS_User AS C
                ON C.UserID = TT.UserID
                INNER JOIN dbo.hfit_ppteligibility AS PP
                ON TT.UserID = PP.userID
                INNER JOIN dbo.HFit_Account AS ACCT
                ON PP.ClientCode = ACCT.AccountCD
                INNER JOIN dbo.CMS_Site AS S
                ON ACCT.SiteID = S.SiteID
                INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
                ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                LEFT OUTER JOIN dbo.HFIT_Tracker AS T
                ON T.AggregateTableName = 'HFit_TrackerWater'
--left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID
UNION ALL
SELECT DISTINCT
       'HFit_TrackerWeight' AS TrackerNameAggregateTable
     , TT.ItemID
     , EventDate
     , TT.IsProfessionallyCollected
     , TT.TrackerCollectionSourceID
     , Notes
     , TT.UserID
     , CollectionSourceName_Internal
     , CollectionSourceName_External
     , 'MISSING' AS EventName
     , 'LBS' AS UOM
     , 'Value' AS KEY1
     , [Value] AS VAL1
     , 'NA' AS KEY2
     , NULL AS VAL2
     , 'NA' AS KEY3
     , NULL AS VAL3
     , 'NA' AS KEY4
     , NULL AS VAL4
     , 'NA' AS KEY5
     , NULL AS VAL5
     , 'NA' AS KEY6
     , NULL AS VAL6
     , 'NA' AS KEY7
     , NULL AS VAL7
     , 'NA' AS KEY8
     , NULL AS VAL8
     , 'NA' AS KEY9
     , NULL AS VAL9
     , 'NA' AS KEY10
     , NULL AS VAL10
     , TT.ItemCreatedBy
     , TT.ItemCreatedWhen
     , TT.ItemModifiedBy
     , TT.ItemModifiedWhen
     , IsProcessedForHa
     , 'NA' AS TXTKEY1
     , NULL AS TXTVAL1
     , 'NA' AS TXTKEY2
     , NULL AS TXTVAL2
     , 'NA' AS TXTKEY3
     , NULL AS TXTVAL3
     , NULL AS ItemOrder
     , NULL AS ItemGuid
     , C.UserGuid
     , PP.MPI
     , PP.ClientCode
     , S.SiteGUID
     , ACCT.AccountID
     , ACCT.AccountCD
     , T.IsAvailable
     , T.IsCustom
     , T.UniqueName
     , T.UniqueName AS ColDesc
     , VENDOR.ItemID AS VendorID
     , VENDOR.VendorName
       FROM
            dbo.HFit_TrackerWeight AS TT
                INNER JOIN dbo.CMS_User AS C
                ON C.UserID = TT.UserID
                INNER JOIN dbo.hfit_ppteligibility AS PP
                ON TT.UserID = PP.userID
                INNER JOIN dbo.HFit_Account AS ACCT
                ON PP.ClientCode = ACCT.AccountCD
                INNER JOIN dbo.CMS_Site AS S
                ON ACCT.SiteID = S.SiteID
                INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
                ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                LEFT OUTER JOIN dbo.HFIT_Tracker AS T
                ON T.AggregateTableName = 'HFit_TrackerWeight'
                LEFT OUTER JOIN HFit_LKP_TrackerVendor AS VENDOR
                ON TT.VendorID = VENDOR.ItemID
UNION ALL
SELECT DISTINCT
       'HFit_TrackerWholeGrains' AS TrackerNameAggregateTable
     , TT.ItemID
     , EventDate
     , TT.IsProfessionallyCollected
     , TT.TrackerCollectionSourceID
     , Notes
     , TT.UserID
     , CollectionSourceName_Internal
     , CollectionSourceName_External
     , 'MISSING' AS EventName
     , 'NA-serving' AS UOM
     , 'Servings' AS KEY1
     , CAST ( Servings AS float) AS VAL1
     , 'NA' AS KEY2
     , NULL AS VAL2
     , 'NA' AS KEY3
     , NULL AS VAL3
     , 'NA' AS KEY4
     , NULL AS VAL4
     , 'NA' AS KEY5
     , NULL AS VAL5
     , 'NA' AS KEY6
     , NULL AS VAL6
     , 'NA' AS KEY7
     , NULL AS VAL7
     , 'NA' AS KEY8
     , NULL AS VAL8
     , 'NA' AS KEY9
     , NULL AS VAL9
     , 'NA' AS KEY10
     , NULL AS VAL10
     , TT.ItemCreatedBy
     , TT.ItemCreatedWhen
     , TT.ItemModifiedBy
     , TT.ItemModifiedWhen
     , NULL AS IsProcessedForHa
     , 'NA' AS TXTKEY1
     , NULL AS TXTVAL1
     , 'NA' AS TXTKEY2
     , NULL AS TXTVAL2
     , 'NA' AS TXTKEY3
     , NULL AS TXTVAL3
     , NULL AS ItemOrder
     , NULL AS ItemGuid
     , C.UserGuid
     , PP.MPI
     , PP.ClientCode
     , S.SiteGUID
     , ACCT.AccountID
     , ACCT.AccountCD
     , T.IsAvailable
     , T.IsCustom
     , T.UniqueName
     , T.UniqueName AS ColDesc
     , NULL AS VendorID	--VENDOR.ItemID as VendorID
     ,
       NULL AS VendorName --VENDOR.VendorName
       FROM
            dbo.HFit_TrackerWholeGrains AS TT
                INNER JOIN dbo.CMS_User AS C
                ON C.UserID = TT.UserID
                INNER JOIN dbo.hfit_ppteligibility AS PP
                ON TT.UserID = PP.userID
                INNER JOIN dbo.HFit_Account AS ACCT
                ON PP.ClientCode = ACCT.AccountCD
                INNER JOIN dbo.CMS_Site AS S
                ON ACCT.SiteID = S.SiteID
                INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
                ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                LEFT OUTER JOIN dbo.HFIT_Tracker AS T
                ON T.AggregateTableName = 'HFit_TrackerWholeGrains'
--left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID
UNION ALL
SELECT DISTINCT
       'HFit_TrackerShots' AS TrackerNameAggregateTable
     , TT.ItemID
     , EventDate
     , TT.IsProfessionallyCollected
     , TT.TrackerCollectionSourceID
     , Notes
     , TT.UserID
     , NULL AS CollectionSourceName_Internal
     , NULL AS CollectionSourceName_External
     , 'MISSING' AS EventName
     , 'NA' AS UOM
     , 'FluShot' AS KEY1
     , CAST ( FluShot AS float) AS VAL1
     , 'PneumoniaShot' AS KEY2
     , CAST ( PneumoniaShot AS float) AS VAL2
     , 'NA' AS KEY3
     , NULL AS VAL3
     , 'NA' AS KEY4
     , NULL AS VAL4
     , 'NA' AS KEY5
     , NULL AS VAL5
     , 'NA' AS KEY6
     , NULL AS VAL6
     , 'NA' AS KEY7
     , NULL AS VAL7
     , 'NA' AS KEY8
     , NULL AS VAL8
     , 'NA' AS KEY9
     , NULL AS VAL9
     , 'NA' AS KEY10
     , NULL AS VAL10
     , TT.ItemCreatedBy
     , TT.ItemCreatedWhen
     , TT.ItemModifiedBy
     , TT.ItemModifiedWhen
     , NULL AS IsProcessedForHa
     , 'NA' AS TXTKEY1
     , NULL AS TXTVAL1
     , 'NA' AS TXTKEY2
     , NULL AS TXTVAL2
     , 'NA' AS TXTKEY3
     , NULL AS TXTVAL3
     , NULL AS ItemOrder
     , NULL AS ItemGuid
     , C.UserGuid
     , PP.MPI
     , PP.ClientCode
     , S.SiteGUID
     , ACCT.AccountID
     , ACCT.AccountCD
     , T.IsAvailable
     , T.IsCustom
     , T.UniqueName
     , T.UniqueName AS ColDesc
     , VENDOR.ItemID AS VendorID
     , VENDOR.VendorName
       FROM
            dbo.HFit_TrackerShots AS TT
                INNER JOIN dbo.CMS_User AS C
                ON C.UserID = TT.UserID
                INNER JOIN dbo.hfit_ppteligibility AS PP
                ON TT.UserID = PP.userID
                INNER JOIN dbo.HFit_Account AS ACCT
                ON PP.ClientCode = ACCT.AccountCD
                INNER JOIN dbo.CMS_Site AS S
                ON ACCT.SiteID = S.SiteID
                INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
                ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                LEFT OUTER JOIN dbo.HFIT_Tracker AS T
                ON T.AggregateTableName = 'HFit_TrackerShots'
                LEFT OUTER JOIN HFit_LKP_TrackerVendor AS VENDOR
                ON TT.VendorID = VENDOR.ItemID
UNION ALL
SELECT DISTINCT
       'HFit_TrackerTests' AS TrackerNameAggregateTable
     , TT.ItemID
     , EventDate
     , TT.IsProfessionallyCollected
     , TT.TrackerCollectionSourceID
     , Notes
     , TT.UserID
     , NULL AS CollectionSourceName_Internal
     , NULL AS CollectionSourceName_External
     , 'MISSING' AS EventName
     , 'NA' AS UOM
     , 'PSATest' AS KEY1
     , CAST ( PSATest AS float) AS VAL1
     , 'OtherExam' AS KEY2
     , CAST ( OtherExam AS float) AS VAL2
     , 'TScore' AS KEY3
     , CAST ( TScore AS float) AS VAL3
     , 'DRA' AS KEY4
     , CAST ( DRA AS float) AS VAL4
     , 'CotinineTest' AS KEY5
     , CAST ( CotinineTest AS float) AS VAL5
     , 'ColoCareKit' AS KEY6
     , CAST ( ColoCareKit AS float) AS VAL6
     , 'CustomTest' AS KEY7
     , CAST ( CustomTest AS float) AS VAL7
     , 'NA' AS KEY8
     , NULL AS VAL8
     , 'NA' AS KEY9
     , NULL AS VAL9
     , 'NA' AS KEY10
     , NULL AS VAL10
     , TT.ItemCreatedBy
     , TT.ItemCreatedWhen
     , TT.ItemModifiedBy
     , TT.ItemModifiedWhen
     , NULL AS IsProcessedForHa
     , 'CustomDesc' AS TXTKEY1
     , CustomDesc AS TXTVAL1
     , 'NA' AS TXTKEY2
     , NULL AS TXTVAL2
     , 'NA' AS TXTKEY3
     , NULL AS TXTVAL3
     , NULL AS ItemOrder
     , NULL AS ItemGuid
     , C.UserGuid
     , PP.MPI
     , PP.ClientCode
     , S.SiteGUID
     , ACCT.AccountID
     , ACCT.AccountCD
     , T.IsAvailable
     , T.IsCustom
     , T.UniqueName
     , T.UniqueName AS ColDesc
     , VENDOR.ItemID AS VendorID
     , VENDOR.VendorName
       FROM
            dbo.HFit_TrackerTests AS TT
                INNER JOIN dbo.CMS_User AS C
                ON C.UserID = TT.UserID
                INNER JOIN dbo.hfit_ppteligibility AS PP
                ON TT.UserID = PP.userID
                INNER JOIN dbo.HFit_Account AS ACCT
                ON PP.ClientCode = ACCT.AccountCD
                INNER JOIN dbo.CMS_Site AS S
                ON ACCT.SiteID = S.SiteID
                INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
                ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                LEFT OUTER JOIN dbo.HFIT_Tracker AS T
                ON T.AggregateTableName = 'HFit_TrackerTests'
                LEFT OUTER JOIN HFit_LKP_TrackerVendor AS VENDOR
                ON TT.VendorID = VENDOR.ItemID
UNION ALL
SELECT DISTINCT
       'HFit_TrackerCotinine' AS TrackerNameAggregateTable
     , TT.ItemID
     , EventDate
     , TT.IsProfessionallyCollected
     , TT.TrackerCollectionSourceID
     , Notes
     , TT.UserID
     , NULL AS CollectionSourceName_Internal
     , NULL AS CollectionSourceName_External
     , 'MISSING' AS EventName
     , 'NA' AS UOM
     , 'NicotineAssessment' AS KEY1
     , CAST ( NicotineAssessment AS float) AS VAL1
     , 'NA' AS KEY2
     , NULL AS VAL2
     , 'NA' AS KEY3
     , NULL AS VAL3
     , 'NA' AS KEY4
     , NULL AS VAL4
     , 'NA' AS KEY5
     , NULL AS VAL5
     , 'NA' AS KEY6
     , NULL AS VAL6
     , 'NA' AS KEY7
     , NULL AS VAL7
     , 'NA' AS KEY8
     , NULL AS VAL8
     , 'NA' AS KEY9
     , NULL AS VAL9
     , 'NA' AS KEY10
     , NULL AS VAL10
     , TT.ItemCreatedBy
     , TT.ItemCreatedWhen
     , TT.ItemModifiedBy
     , TT.ItemModifiedWhen
     , IsProcessedForHa
     , 'NA' AS TXTKEY1
     , NULL AS TXTVAL1
     , 'NA' AS TXTKEY2
     , NULL AS TXTVAL2
     , 'NA' AS TXTKEY3
     , NULL AS TXTVAL3
     , NULL AS ItemOrder
     , NULL AS ItemGuid
     , C.UserGuid
     , PP.MPI
     , PP.ClientCode
     , S.SiteGUID
     , ACCT.AccountID
     , ACCT.AccountCD
     , T.IsAvailable
     , T.IsCustom
     , T.UniqueName
     , T.UniqueName AS ColDesc
     , --VENDOR.ItemID AS VendorID ,
       --VENDOR.VendorName,
       NULL AS VendorID
     , NULL AS VendorName
       FROM
            dbo.HFit_TrackerCotinine AS TT
                INNER JOIN dbo.CMS_User AS C
                ON C.UserID = TT.UserID
                INNER JOIN dbo.hfit_ppteligibility AS PP
                ON TT.UserID = PP.userID
                INNER JOIN dbo.HFit_Account AS ACCT
                ON PP.ClientCode = ACCT.AccountCD
                INNER JOIN dbo.CMS_Site AS S
                ON ACCT.SiteID = S.SiteID
                INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
                ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                LEFT OUTER JOIN dbo.HFIT_Tracker AS T
                ON T.AggregateTableName = 'HFit_TrackerTests'
--LEFT OUTER JOIN HFit_LKP_TrackerVendor AS VENDOR
--	ON TT.VendorID = VENDOR.ItemID;

UNION ALL
SELECT DISTINCT
       'HFit_TrackerPreventiveCare' AS TrackerNameAggregateTable
     , TT.ItemID
     , EventDate
     , TT.IsProfessionallyCollected
     , TT.TrackerCollectionSourceID
     , Notes
     , TT.UserID
     , NULL AS CollectionSourceName_Internal
     , NULL AS CollectionSourceName_External
     , 'MISSING' AS EventName
     , 'NA' AS UOM
     , 'PreventiveCare' AS KEY1
     , CAST ( PreventiveCare AS float) AS VAL1
     , 'NA' AS KEY2
     , NULL AS VAL2
     , 'NA' AS KEY3
     , NULL AS VAL3
     , 'NA' AS KEY4
     , NULL AS VAL4
     , 'NA' AS KEY5
     , NULL AS VAL5
     , 'NA' AS KEY6
     , NULL AS VAL6
     , 'NA' AS KEY7
     , NULL AS VAL7
     , 'NA' AS KEY8
     , NULL AS VAL8
     , 'NA' AS KEY9
     , NULL AS VAL9
     , 'NA' AS KEY10
     , NULL AS VAL10
     , TT.ItemCreatedBy
     , TT.ItemCreatedWhen
     , TT.ItemModifiedBy
     , TT.ItemModifiedWhen
     , IsProcessedForHa
     , 'NA' AS TXTKEY1
     , NULL AS TXTVAL1
     , 'NA' AS TXTKEY2
     , NULL AS TXTVAL2
     , 'NA' AS TXTKEY3
     , NULL AS TXTVAL3
     , NULL AS ItemOrder
     , NULL AS ItemGuid
     , C.UserGuid
     , PP.MPI
     , PP.ClientCode
     , S.SiteGUID
     , ACCT.AccountID
     , ACCT.AccountCD
     , T.IsAvailable
     , T.IsCustom
     , T.UniqueName
     , T.UniqueName AS ColDesc
     , --VENDOR.ItemID AS VendorID ,
       --VENDOR.VendorName,
       NULL AS VendorID
     , NULL AS VendorName
       FROM
            dbo.HFit_TrackerPreventiveCare AS TT
                INNER JOIN dbo.CMS_User AS C
                ON C.UserID = TT.UserID
                INNER JOIN dbo.hfit_ppteligibility AS PP
                ON TT.UserID = PP.userID
                INNER JOIN dbo.HFit_Account AS ACCT
                ON PP.ClientCode = ACCT.AccountCD
                INNER JOIN dbo.CMS_Site AS S
                ON ACCT.SiteID = S.SiteID
                INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
                ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                LEFT OUTER JOIN dbo.HFIT_Tracker AS T
                ON T.AggregateTableName = 'HFit_TrackerTests'
--LEFT OUTER JOIN HFit_LKP_TrackerVendor AS VENDOR
--	ON TT.VendorID = VENDOR.ItemID;
UNION ALL
SELECT DISTINCT
       'HFit_TrackerTobaccoAttestation' AS TrackerNameAggregateTable
     , TT.ItemID
     , EventDate
     , TT.IsProfessionallyCollected
     , TT.TrackerCollectionSourceID
     , Notes
     , TT.UserID
     , NULL AS CollectionSourceName_Internal
     , NULL AS CollectionSourceName_External
     , 'MISSING' AS EventName
     , 'NA' AS UOM
     , 'TobaccoAttestation' AS KEY1
     , CAST ( TobaccoAttestation AS float) AS VAL1
     , 'NA' AS KEY2
     , NULL AS VAL2
     , 'NA' AS KEY3
     , NULL AS VAL3
     , 'NA' AS KEY4
     , NULL AS VAL4
     , 'NA' AS KEY5
     , NULL AS VAL5
     , 'NA' AS KEY6
     , NULL AS VAL6
     , 'NA' AS KEY7
     , NULL AS VAL7
     , 'NA' AS KEY8
     , NULL AS VAL8
     , 'NA' AS KEY9
     , NULL AS VAL9
     , 'NA' AS KEY10
     , NULL AS VAL10
     , TT.ItemCreatedBy
     , TT.ItemCreatedWhen
     , TT.ItemModifiedBy
     , TT.ItemModifiedWhen
     , IsProcessedForHa
     , 'NA' AS TXTKEY1
     , NULL AS TXTVAL1
     , 'NA' AS TXTKEY2
     , NULL AS TXTVAL2
     , 'NA' AS TXTKEY3
     , NULL AS TXTVAL3
     , NULL AS ItemOrder
     , NULL AS ItemGuid
     , C.UserGuid
     , PP.MPI
     , PP.ClientCode
     , S.SiteGUID
     , ACCT.AccountID
     , ACCT.AccountCD
     , T.IsAvailable
     , T.IsCustom
     , T.UniqueName
     , T.UniqueName AS ColDesc
     , --VENDOR.ItemID AS VendorID ,
       --VENDOR.VendorName,
       NULL AS VendorID
     , NULL AS VendorName
       FROM
            dbo.HFit_TrackerTobaccoAttestation AS TT
                INNER JOIN dbo.CMS_User AS C
                ON C.UserID = TT.UserID
                INNER JOIN dbo.hfit_ppteligibility AS PP
                ON TT.UserID = PP.userID
                INNER JOIN dbo.HFit_Account AS ACCT
                ON PP.ClientCode = ACCT.AccountCD
                INNER JOIN dbo.CMS_Site AS S
                ON ACCT.SiteID = S.SiteID
                INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
                ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                LEFT OUTER JOIN dbo.HFIT_Tracker AS T
                ON T.AggregateTableName = 'HFit_TrackerTests';
--LEFT OUTER JOIN HFit_LKP_TrackerVendor AS VENDOR
--	ON TT.VendorID = VENDOR.ItemID;

GO

--  
--  
GO
PRINT '***** CREATED: view_EDW_TrackerCompositeDetails.sql';
GO 

--IF EXISTS (SELECT name FROM sys.triggers where name = 'trgSchemaMonitor')    
--enable TRIGGER trgSchemaMonitor ON DATABASE;

GO--**************
print('END: ' + cast(getdate() as nvarchar(50)));
print('@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-');
print'***************************************************************' ;
print('START: ' + cast(getdate() as nvarchar(50)));
--**************

--SET ANSI_NULLS ON;
--SET ANSI_PADDING ON;
--SET ANSI_WARNINGS ON;
--SET ARITHABORT ON;
--SET CONCAT_NULL_YIELDS_NULL ON;
--SET NUMERIC_ROUNDABORT OFF;
--SET QUOTED_IDENTIFIER ON;





print ('Creating View_EDW_RewardProgram_Joined: ' +  cast(getdate() as nvarchar(50)));
go
if exists (select name from sys.views where name = 'View_EDW_RewardProgram_Joined')
BEGIN
	print ('Re-creating View_EDW_RewardProgram_Joined' +  cast(getdate() as nvarchar(50)));
	drop view View_EDW_RewardProgram_Joined ;
END
go

--This view is created in place of View_Hfit_RewardProgram_Joined so that 
--Document Culture can be taken into consideration. 
CREATE VIEW [dbo].[View_EDW_RewardProgram_Joined] AS 

--03.03.2015 : Reviewed by NAthan and Dale, no change required.

SELECT View_CMS_Tree_Joined.*, HFit_RewardProgram.* 
	FROM View_CMS_Tree_Joined 
	INNER JOIN HFit_RewardProgram 
		ON View_CMS_Tree_Joined.DocumentForeignKeyValue = HFit_RewardProgram.[RewardProgramID] 
WHERE ClassName = 'HFit.RewardProgram'
AND View_CMS_Tree_Joined.documentculture = 'en-US'
GO

print ('Created View_EDW_RewardProgram_Joined: ' + cast(getdate() as nvarchar(50)));
go  --  
  --  
GO 
print('***** FROM: View_EDW_RewardProgram_Joined.sql'); 
GO 
--**************
print('END: ' + cast(getdate() as nvarchar(50)));
print('@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-');
print'***************************************************************' ;
print('START: ' + cast(getdate() as nvarchar(50)));
--**************

--SET ANSI_NULLS ON;
--SET ANSI_PADDING ON;
--SET ANSI_WARNINGS ON;
--SET ARITHABORT ON;
--SET CONCAT_NULL_YIELDS_NULL ON;
--SET NUMERIC_ROUNDABORT OFF;
--SET QUOTED_IDENTIFIER ON;





GO
print ('Processing: view_EDW_RewardTriggerParameters ') ;
go

if exists(select NAME from sys.VIEWS where NAME = 'view_EDW_RewardTriggerParameters')
BEGIN
	drop view view_EDW_RewardTriggerParameters ;
END
GO


--GRANT SELECT
--	ON [dbo].[view_EDW_RewardTriggerParameters]
--	TO [EDWReader_PRD]
--GO


--*******************************************************************************************************************
--8/7/2014  VHFRTJ.DocumentGuid		  --WDM Added in case needed
--8/7/2014  VHFRTJ.NodeGuid			  --WDM Added in case needed
--09.11.2014 : (wdm) Verified last mod date available to EDW - RewardTriggerParameter_DocumentModifiedWhen
--11.17.2014 : (wdm) John C. found that Spanish was being brought across in TriggerName and 
--				ParameterDisplayName. Found that View_HFit_RewardTrigger_Joined has no way to limit the 
--				returned data to Spanish. Created a new view, View_EDW_RewardProgram_Joined, and provided 
--				a FILTER on Document Culture. The, added Launguage fitlers as: 
--					where VHFRTJ.DocumentCulture = 'en-US' AND VHFRTPJ.DocumentCulture = 'en-US'
--				This appears to have eliminated the Spanish.
-- 03.03.2015 : (Dale/Natahn) no changes required.
-- 04.12.2015 : (WDM) In order to implement change tracking on this view, a STAGING table will simply be 
--			 dropped and recreated everytime using this view. It is too small to worry about otherwise.
--SELECT * FROM [view_EDW_RewardTriggerParameters]
--*******************************************************************************************************************
create VIEW [dbo].[view_EDW_RewardTriggerParameters]
AS
--8/7/2014 - added and commented out DocumentGuid and NodeGuid in case needed later
--8/8/2014 - Generated corrected view in DEV (WDM)
	SELECT distinct
		cs.SiteGUID															 --CMS_Site
		, VHFRTJ.RewardTriggerID													 --HFit_RewardTrigger
		, VHFRTJ.TriggerName													 --HFit_RewardTrigger
		, HFLRTPO.RewardTriggerParameterOperatorLKPDisplayName							 --HFit_LKP_RewardTriggerParameterOperator 
		, VHFRTPJ.ParameterDisplayName											 --HFit_RewardTriggerParameter
		, VHFRTPJ.RewardTriggerParameterOperator									 --HFit_RewardTriggerParameter
		, VHFRTPJ.Value														 --HFit_RewardTriggerParameter
		, hfa.AccountID														 --HFit_Account
		, hfa.AccountCD														 --HFit_Account
		, CASE	WHEN CAST(VHFRTJ.DocumentCreatedWhen AS DATE) = CAST(VHFRTJ.DocumentModifiedWhen AS DATE)
				THEN 'I'
				ELSE 'U'
			END AS ChangeType		
		, VHFRTJ.DocumentGuid													 --CMS_Document
		, VHFRTJ.NodeGuid														 --CMS_Document
		, VHFRTJ.DocumentCreatedWhen												 --CMS_Document
		, VHFRTJ.DocumentModifiedWhen												 --CMS_Document
		,VHFRTPJ.DocumentModifiedWhen as RewardTriggerParameter_DocumentModifiedWhen	  	 --CMS_Document
		,VHFRTPJ.documentculture as documentculture_VHFRTPJ							 --CMS_Document
		,VHFRTJ.documentculture as documentculture_VHFRTJ								 --CMS_Document
	FROM
		dbo.View_HFit_RewardTrigger_Joined AS VHFRTJ 
		--dbo.[View_EDW_RewardProgram_Joined] AS VHFRTJ 		
	INNER JOIN dbo.View_HFit_RewardTriggerParameter_Joined AS VHFRTPJ  ON vhfrtj.NodeID = VHFRTPJ.NodeParentID
	INNER JOIN dbo.HFit_LKP_RewardTriggerParameterOperator AS HFLRTPO  ON VHFRTPJ.RewardTriggerParameterOperator = HFLRTPO.RewardTriggerParameterOperatorLKPID
	INNER JOIN dbo.CMS_Site AS CS  ON VHFRTJ.NodeSiteID = cs.SiteID
	INNER JOIN dbo.HFit_Account AS HFA  ON cs.SiteID = HFA.SiteID
	where VHFRTJ.DocumentCulture = 'en-US'
	AND VHFRTPJ.DocumentCulture = 'en-US'
      

GO


  --  
  --  
GO 
print('***** Created: view_EDW_RewardTriggerParameters.sql'); 
GO 
--**************
print('END: ' + cast(getdate() as nvarchar(50)));
print('@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-');
print'***************************************************************' ;
print('START: ' + cast(getdate() as nvarchar(50)));
--**************

--SET ANSI_NULLS ON;
--SET ANSI_PADDING ON;
--SET ANSI_WARNINGS ON;
--SET ARITHABORT ON;
--SET CONCAT_NULL_YIELDS_NULL ON;
--SET NUMERIC_ROUNDABORT OFF;
--SET QUOTED_IDENTIFIER ON;





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
		    , [dl].[LevelCompletedDt]
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

--**************
print('END: ' + cast(getdate() as nvarchar(50)));
print('@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-');
print'***************************************************************' ;
print('START: ' + cast(getdate() as nvarchar(50)));
--**************

--SET ANSI_NULLS ON;
--SET ANSI_PADDING ON;
--SET ANSI_WARNINGS ON;
--SET ARITHABORT ON;
--SET CONCAT_NULL_YIELDS_NULL ON;
--SET NUMERIC_ROUNDABORT OFF;
--SET QUOTED_IDENTIFIER ON;





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
--**************
print('END: ' + cast(getdate() as nvarchar(50)));
print('@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-');
print'***************************************************************' ;
print('START: ' + cast(getdate() as nvarchar(50)));
--**************

--SET ANSI_NULLS ON;
--SET ANSI_PADDING ON;
--SET ANSI_WARNINGS ON;
--SET ARITHABORT ON;
--SET CONCAT_NULL_YIELDS_NULL ON;
--SET NUMERIC_ROUNDABORT OFF;
--SET QUOTED_IDENTIFIER ON;




PRINT 'Processing: Proc_EDW_TrackerMetadataExtract';
GO
IF EXISTS (SELECT
				  *
				  FROM sysobjects
				  WHERE name = 'Proc_EDW_TrackerMetadataExtract'
					AND Xtype = 'P') 
	BEGIN
		DROP PROCEDURE
			 Proc_EDW_TrackerMetadataExtract;
	END;
GO

--exec Proc_EDW_TrackerMetadataExtract 'HFit.TrackerWater'
--select * from #Temp_TrackerMetaData
--select * from Tracker_EDW_Metadata
--truncate table Tracker_EDW_Metadata

CREATE PROCEDURE dbo.Proc_EDW_TrackerMetadataExtract (
	   @TrackerClassName AS nvarchar (250)) 
AS
BEGIN
	IF EXISTS (SELECT
					  name
					  FROM tempdb.dbo.sysobjects
					  WHERE ID = OBJECT_ID (N'tempdb..#Temp_TrackerMetaData')) 
		BEGIN
			DROP TABLE
				 #Temp_TrackerMetaData;
		END;
	DECLARE @MetaDataLastLoadDate datetime;
	DECLARE @ClassLastModified datetime;
	DECLARE @Xml xml;
	DECLARE @docHandle int;
	DECLARE @form nvarchar (250) ;
	DECLARE @dbForm nvarchar (250) ;
	DECLARE @id int;
	DECLARE @parent int;
	DECLARE @nodetype int;
	DECLARE @localname nvarchar (250) ;
	DECLARE @prefix nvarchar (250) ;
	DECLARE @namespaceuri nvarchar (250) ;
	DECLARE @datatype nvarchar (250) ;
	DECLARE @prev nvarchar (250) ;
	DECLARE @dbText nvarchar (250) ;
	DECLARE @ParentName nvarchar (250) ;
	DECLARE @TableName nvarchar (100) ;
	DECLARE @ColName nvarchar (100) ;
	DECLARE @AttrName nvarchar (100) ;
	DECLARE @AttrVal nvarchar (250) ;
	DECLARE @CurrName nvarchar (250) ;
	DECLARE @SkipIfNoChange bit;

		--alter table [Tracker_EDW_Metadata] add ClassLastModified datetime null
	--drop table Tracker_EDW_Metadata; 
	IF NOT EXISTS (SELECT
						  name
						  FROM sysobjects
						  WHERE ID = OBJECT_ID (N'Tracker_EDW_Metadata')) 
		BEGIN
			CREATE TABLE dbo.Tracker_EDW_Metadata (
						 TableName nvarchar (100) NOT NULL
					   , ColName nvarchar (100) NOT NULL
					   , AttrName nvarchar (100) NOT NULL
					   , AttrVal nvarchar (250) NULL
					   , CreatedDate datetime2 (7) NULL
					   , LastModifiedDate datetime2 (7) NULL
					   , ID int IDENTITY (1, 1) 
								NOT NULL
					   , ClassLastModified datetime2 (7) NULL) ;
			ALTER TABLE dbo.Tracker_EDW_Metadata
			ADD
						CONSTRAINT DF_Tracker_EDW_Metadata_CreatedDate DEFAULT GETDATE () FOR CreatedDate;
			ALTER TABLE dbo.Tracker_EDW_Metadata
			ADD
						CONSTRAINT DF_Tracker_EDW_Metadata_LastModifiedDate DEFAULT GETDATE () FOR LastModifiedDate;
			CREATE UNIQUE CLUSTERED INDEX PK_Tracker_EDW_Metadata ON dbo.Tracker_EDW_Metadata (TableName ASC, ColName ASC, AttrName ASC) ;
		END;
	IF NOT EXISTS (SELECT
						  column_name
						  FROM information_schema.columns
						  WHERE column_name = 'ClassLastModified'
							AND table_name = 'Tracker_EDW_Metadata') 
		BEGIN
			PRINT 'MISSING: Tracker_EDW_Metadata ClassLastModified, added to table.';
			ALTER TABLE Tracker_EDW_Metadata
			ADD
						ClassLastModified datetime NULL;
		END;
	ELSE
		BEGIN
			PRINT 'FOUND: Tracker_EDW_Metadata ClassLastModified';
		END;

	SELECT
		   @form = @TrackerClassName;

	--select * from information_schema.columns where column_name = 'ClassLastModified'

	IF EXISTS (SELECT
					  column_name
					  FROM information_schema.columns
					  WHERE column_name = 'ClassLastModified'
						AND table_name = 'Tracker_EDW_Metadata') 
		BEGIN
			SELECT
				   @MetaDataLastLoadDate = (
											SELECT TOP 1
												   ClassLastModified
												   FROM Tracker_EDW_Metadata
												   WHERE TableName = @form) ;
			SELECT
				   @ClassLastModified = (
										 SELECT TOP 1
												ClassLastModified
												FROM CMS_CLASS
												WHERE ClassName = @form) ;
			SET @SkipIfNoChange = 1;
			IF @SkipIfNoChange = 1
				BEGIN
					IF @MetaDataLastLoadDate = @ClassLastModified
						BEGIN
							PRINT 'No Change in ' + @form + ', no updates needed.';
							RETURN;
						END;
					ELSE
						BEGIN
							PRINT 'Changes found in ' + @form + ', processing.';
						END;
				END;
			PRINT '@MetaDataLastLoadDate: ' + CAST (@MetaDataLastLoadDate AS varchar (50)) ;
			PRINT '@ClassLastModified: ' + CAST (@ClassLastModified AS varchar (50)) ;
		END;
	SELECT
		   @Xml = (
				   SELECT
						  ClassFormDefinition
						  FROM CMS_Class
						  WHERE ClassName LIKE @form) ;

	--print (cast( @Xml as varchar(max)));

	EXEC sp_xml_preparedocument @docHandle OUTPUT, @Xml;


	IF NOT EXISTS (SELECT
						  name
						  FROM tempdb.dbo.sysobjects
						  WHERE ID = OBJECT_ID (N'tempdb..#Temp_TrackerMetaData')) 
		BEGIN
			SELECT
				   @form AS form
				 , id
				 , parentid
				 , nodetype
				 , localname
				 , prefix
				 , namespaceuri
				 , datatype
				 , prev
				 , text INTO
							 #Temp_TrackerMetaData
				   FROM OPENXML (@docHandle, N'/form/field') AS XMLDATA;

			--WHERE localname not in ('isPK');		

			CREATE INDEX TMPPI_HealthAssesmentUserQuestion ON #Temp_TrackerMetaData (parentid) ;
			CREATE INDEX TMPPI2_HealthAssesmentUserQuestion ON #Temp_TrackerMetaData (id) ;
		END;
	ELSE
		BEGIN
			truncate TABLE #Temp_TrackerMetaData;
			INSERT INTO #Temp_TrackerMetaData
			SELECT
				   @form AS form
				 , id
				 , parentid
				 , nodetype
				 , localname
				 , prefix
				 , namespaceuri
				 , datatype
				 , prev
				 , text
				   FROM OPENXML (@docHandle, N'/form/field') AS XMLDATA;
		END;
	DELETE FROM Tracker_EDW_Metadata
	WHERE
		  TableName = @form;
	SET @ClassLastModified = (SELECT
									 ClassLastModified
									 FROM CMS_CLASS
									 WHERE ClassName = @Form) ;
	PRINT '@ClassLastModified: ' + CAST (@ClassLastModified AS varchar (250)) ;
	DECLARE C CURSOR
		FOR SELECT
				   @form AS form
				 , id
				 , parentid
				 , nodetype
				 , localname
				 , prefix
				 , namespaceuri
				 , datatype
				 , prev
				 , text
				   FROM #Temp_TrackerMetaData AS XMLDATA;
	OPEN C;
	FETCH NEXT FROM C INTO @dbForm, @id, @parent, @nodetype, @localname, @prefix, @namespaceuri, @datatype, @prev, @dbText;
	WHILE @@FETCH_STATUS = 0
		BEGIN

			--print ('* @localname :' + @localname) ;
			--print ('* @ColName :' + isnull(@ColName, 'XX') + ':') ;
			--print ('* @dbText :' + @dbText + ':') ;

			IF @localname = 'column'
				BEGIN

					--print ('** START COLUMN DEF: ') ;

					SET @ColName = (SELECT
										   text
										   FROM #Temp_TrackerMetaData
										   WHERE parentid = @id) ;

				--print ('** COLUMN DEF: ' + @form + ' : ' + @colname) ;

				END;
			IF @dbText IS NOT NULL
				BEGIN

					--print ('* ENTER @dbText :' + @dbText + ':' + cast(@parent as varchar(10))) ;

					SET @AttrName = (SELECT
											localname
											FROM #Temp_TrackerMetaData
											WHERE id = @parent) ;

					--set @ParentName = (select [localname] FROM OPENXML(@docHandle, N'/form/field') where id = @parent);	
					--print ('1 - @AttrName: ' + @form +' : ' + isnull(@ColName, 'NA') + ' : ' + @AttrName + ' : ' + @dbText) ;	

					IF EXISTS (SELECT
									  TableName
									  FROM Tracker_EDW_Metadata
									  WHERE Tablename = @form
										AND ColName = @ColName
										AND AttrName = @dbText) 
						BEGIN

							--print('Update Tracker_EDW_Metadata set AttrVal = ' + @dbText + ' Where Tablename = ' + @form + ' and ColName = ' + @ColName + ' and AttrName = ' + @AttrName + ';');

							UPDATE Tracker_EDW_Metadata
							SET
								AttrVal = @dbText
							  ,
								ClassLastModified = @ClassLastModified
							WHERE
								  Tablename = @form
							  AND ColName = @ColName
							  AND AttrName = @dbText;
						END;
					ELSE
						BEGIN

							--print ('insert into Tracker_EDW_Metadata (TableName, ColName, AttrName, AttrVal, ClassLastModified) values ('+@form+', '+@ColName+', '+@AttrName+', '+@dbText +', ' + cast(@ClassLastModified as varchar(50))+ ') ') ;

							INSERT INTO Tracker_EDW_Metadata (
										TableName
									  , ColName
									  , AttrName
									  , AttrVal
									  , ClassLastModified) 
							VALUES
								 (@form, @ColName, @AttrName, @dbText, @ClassLastModified) ;
							UPDATE Tracker_EDW_Metadata
							SET
								ClassLastModified = @ClassLastModified
							WHERE
								  Tablename = @form
							  AND ColName = @ColName
							  AND AttrName = @dbText;
						END;
				END;
			IF @localname = 'columntype'
		   AND @ColName IS NOT NULL
				BEGIN
					PRINT '---- COLUMN TYPE DEF: ' + @form + ' : ' + @colname + ' : ' + @dbText;
				END;
			IF @localname = 'field'
				BEGIN
					SET @ParentName = NULL;
					SET @ColName = NULL;

				--print ('***** field @ParentName: ' + @ParentName) ;

				END;
			FETCH NEXT FROM C INTO @dbForm, @id, @parent, @nodetype, @localname, @prefix, @namespaceuri, @datatype, @prev, @dbText;
		END;
	CLOSE C;
	DEALLOCATE C;
END;

--Clean up the EDW Tracker MetaData
--delete from Tracker_EDW_Metadata where colname in ('ItemID','ItemCreatedBy','ItemCreatedWhen','ItemModifiedBy','ItemModifiedWhen','EventDate','IsProfessionally Collected','TrackerCollectionSourceId','UserID','Notes','IsProcessedForHA');

GO
PRINT 'ProcessED and created : Proc_EDW_TrackerMetadataExtract';
GO
PRINT '***** FROM: Proc_EDW_TrackerMetadataExtract.sql';
GO 
--**************
print('END: ' + cast(getdate() as nvarchar(50)));
print('@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-');
print'***************************************************************' ;
print('START: ' + cast(getdate() as nvarchar(50)));
--**************

--SET ANSI_NULLS ON;
--SET ANSI_PADDING ON;
--SET ANSI_WARNINGS ON;
--SET ARITHABORT ON;
--SET CONCAT_NULL_YIELDS_NULL ON;
--SET NUMERIC_ROUNDABORT OFF;
--SET QUOTED_IDENTIFIER ON;






GO
PRINT 'Creating table HFit_LKP_GoalCloseReason for SR-47923 ';
GO

-- 01.02.2014 (WDM) added column HFUG.CloseReasonLKPID in order to satisfy Story #47923

IF EXISTS (SELECT name
			 FROM sys.tables
			 WHERE name = 'HFit_LKP_GoalCloseReason') 
	BEGIN
		PRINT 'Dropping table HFit_LKP_GoalCloseReason';
		DROP TABLE dbo.HFit_LKP_GoalCloseReason;
	END;
GO
CREATE TABLE dbo.HFit_LKP_GoalCloseReason (
	ItemID int IDENTITY (1, 1) NOT NULL, 
	CloseReasonID int NOT NULL, 
	CloseReason varchar (250) NOT NULL, 
	ItemCreatedBy int NULL, 
	ItemCreatedWhen datetime2 (7) NULL, 
	ItemModifiedBy int NULL, 
	ItemModifiedWhen datetime2 (7) NULL, 
	ItemOrder int NULL, 
	ItemGUID uniqueidentifier NOT NULL, 
	CONSTRAINT PK_HFit_LKP_GoalCloseReason PRIMARY KEY CLUSTERED (CloseReasonID ASC) 
		WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
		ON [PRIMARY]) 
ON [PRIMARY];
GO
SET ANSI_PADDING OFF;
GO
ALTER TABLE dbo.HFit_LKP_GoalCloseReason
ADD CONSTRAINT DEFAULT_HFit_LKP_GoalCloseReason_ItemGUID DEFAULT '00000000-0000-0000-0000-000000000000' FOR ItemGUID;
GO
IF NOT EXISTS (SELECT name
				 FROM sys.indexes
				 WHERE name = 'CI_HFit_LKP_GoalCloseReason') 
	BEGIN
		PRINT 'Creating index [CI_HFit_LKP_GoalCloseReason]';
		CREATE UNIQUE NONCLUSTERED INDEX CI_HFit_LKP_GoalCloseReason ON dbo.HFit_LKP_GoalCloseReason (CloseReasonID ASC) INCLUDE (CloseReason) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ;
	END;
GO
INSERT INTO dbo.HFit_LKP_GoalCloseReason (CloseReasonID, CloseReason, ItemCreatedBy, ItemCreatedWhen, ItemModifiedBy, ItemModifiedWhen, ItemOrder, ItemGUID) 
VALUES
	   (0, 'Not Set', -1, GETDATE () , -1, GETDATE () , 0, NEWID ()) ;
INSERT INTO dbo.HFit_LKP_GoalCloseReason (CloseReasonID, CloseReason, ItemCreatedBy, ItemCreatedWhen, ItemModifiedBy, ItemModifiedWhen, ItemOrder, ItemGUID) 
VALUES
	   (1, 'Achieved Personal target', -1, GETDATE () , -1, GETDATE () , 0, NEWID ()) ;
INSERT INTO dbo.HFit_LKP_GoalCloseReason (CloseReasonID, CloseReason, ItemCreatedBy, ItemCreatedWhen, ItemModifiedBy, ItemModifiedWhen, ItemOrder, ItemGUID) 
VALUES
	   (2, 'Change In Tx Plan', -1, GETDATE () , -1, GETDATE () , 0, NEWID ()) ;
INSERT INTO dbo.HFit_LKP_GoalCloseReason (CloseReasonID, CloseReason, ItemCreatedBy, ItemCreatedWhen, ItemModifiedBy, ItemModifiedWhen, ItemOrder, ItemGUID) 
VALUES
	   (3, 'Setback', -1, GETDATE () , -1, GETDATE () , 0, NEWID ()) ;
INSERT INTO dbo.HFit_LKP_GoalCloseReason (CloseReasonID, CloseReason, ItemCreatedBy, ItemCreatedWhen, ItemModifiedBy, ItemModifiedWhen, ItemOrder, ItemGUID) 
VALUES
	   (4, 'Not Interested', -1, GETDATE () , -1, GETDATE () , 0, NEWID ()) ;
INSERT INTO dbo.HFit_LKP_GoalCloseReason (CloseReasonID, CloseReason, ItemCreatedBy, ItemCreatedWhen, ItemModifiedBy, ItemModifiedWhen, ItemOrder, ItemGUID) 
VALUES
	   (5, 'Not Eligible', -1, GETDATE () , -1, GETDATE () , 0, NEWID ()) ;
INSERT INTO dbo.HFit_LKP_GoalCloseReason (CloseReasonID, CloseReason, ItemCreatedBy, ItemCreatedWhen, ItemModifiedBy, ItemModifiedWhen, ItemOrder, ItemGUID) 
VALUES
	   (6, 'Program Period End', -1, GETDATE () , -1, GETDATE () , 0, NEWID ()) ;
GO
--SELECT * FROM HFit_LKP_GoalCloseReason;
GO
PRINT 'Created HFit_LKP_GoalCloseReason';
GO--**************
print('END: ' + cast(getdate() as nvarchar(50)));
print('@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-');
print'***************************************************************' ;
print('START: ' + cast(getdate() as nvarchar(50)));
--**************

--SET ANSI_NULLS ON;
--SET ANSI_PADDING ON;
--SET ANSI_WARNINGS ON;
--SET ARITHABORT ON;
--SET CONCAT_NULL_YIELDS_NULL ON;
--SET NUMERIC_ROUNDABORT OFF;
--SET QUOTED_IDENTIFIER ON;





print('Processing: Tracker_EDW_Metadata');
go


--create proc CreateTracker_EDW_Metadata
--as
GO 
if exists(Select name from sys.tables where name = 'Tracker_EDW_Metadata')
BEGIN
	print ('MAY NEED TO DROP the Tracker_EDW_Metadata table');
	drop table Tracker_EDW_Metadata;
END
go
if not exists(Select name from sys.tables where name = 'Tracker_EDW_Metadata')
BEGIN
	print ('Creating the Tracker_EDW_Metadata table');
	CREATE TABLE [dbo].[Tracker_EDW_Metadata] (
			[TableName]             [nvarchar](100) NOT NULL,
			[ColName]               [nvarchar](100) NOT NULL,
			[AttrName]              [nvarchar](100) NOT NULL,
			[AttrVal]               [nvarchar](250) NULL,
			[CreatedDate]           [datetime2] (7) NULL,
			[LastModifiedDate]      [datetime2] (7) NULL,
			[ID]                    [int] IDENTITY(1, 1) NOT NULL,
			[ClassLastModified]     [datetime] NULL
	) ON [PRIMARY]

	ALTER TABLE [dbo].[Tracker_EDW_Metadata]
	ADD
	CONSTRAINT [DF_Tracker_EDW_Metadata_CreatedDate]
	DEFAULT (getdate()) FOR [CreatedDate]

	ALTER TABLE [dbo].[Tracker_EDW_Metadata]
		ADD
		CONSTRAINT [DF_Tracker_EDW_Metadata_LastModifiedDate]
		DEFAULT (getdate()) FOR [LastModifiedDate]

	CREATE UNIQUE CLUSTERED INDEX [PK_Tracker_EDW_Metadata]
		ON [dbo].[Tracker_EDW_Metadata] ([TableName], [ColName], [AttrName]) ON [PRIMARY]

	ALTER TABLE [dbo].[Tracker_EDW_Metadata] SET (LOCK_ESCALATION = TABLE)

END
GO

print ('Created the Tracker_EDW_Metadata table');
  --  
  --  
GO 
print('***** FROM: CreateTracker_EDW_Metadata.sql'); 
GO 
--**************
print('END: ' + cast(getdate() as nvarchar(50)));
print('@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-');
print'***************************************************************' ;
print('START: ' + cast(getdate() as nvarchar(50)));
--**************

--SET ANSI_NULLS ON;
--SET ANSI_PADDING ON;
--SET ANSI_WARNINGS ON;
--SET ARITHABORT ON;
--SET CONCAT_NULL_YIELDS_NULL ON;
--SET NUMERIC_ROUNDABORT OFF;
--SET QUOTED_IDENTIFIER ON;





/***********************************************************
Copyright @ DMA Limited, June 2012, all rights reserved.
FIND a top level view's nested tables and views using a CTE.
Author: W. Dale Miller
Description:
  A recursive CTE requires four elements in order to work properly.
  Anchor query (runs once and the results ‘seed’ the Recursive query)
  Recursive query (runs multiple times and is the criteria for the remaining results)
  UNION ALL statement to bind the Anchor and Recursive queries together.
  INNER JOIN statement to bind the Recursive query to the results of the CTE.
***********************************************************/


/***************************************************************
exec proc_GetViewBaseTables 'view_EDW_HealthAssesment'
exec proc_GetViewBaseTablesExpanded 'view_EDW_HealthAssesment'
exec proc_GetViewBaseTables 'View_EDW_HealthAssesmentQuestions'
exec proc_GetViewBaseTables 'view_EDW_BioMetrics'
exec proc_GetViewBaseTables 'view_EDW_TrackerCompositeDetails'
***************************************************************/

go

if exists (select name from sys.procedures where name = 'proc_GetViewBaseTables')
BEGIN
    drop procedure proc_GetViewBaseTables ;
END

GO
create procedure proc_GetViewBaseTables (@tgtView as nvarchar(100))
as 
begin
WITH mycte
    AS (SELECT 
               --TU.view_name
             TU.Table_Name
             , IST.TABLE_TYPE
               FROM
                    INFORMATION_SCHEMA.VIEW_TABLE_USAGE AS TU WITH (NOLOCK) 
                        JOIN INFORMATION_SCHEMA.tables AS IST
                            ON IST.TABLE_NAME = TU.TABLE_NAME
          WHERE view_name = @tgtView

        UNION ALL

        SELECT 
             --  ISV.view_name
             ISV.Table_Name
             , IST.TABLE_TYPE
               FROM
                    INFORMATION_SCHEMA.VIEW_TABLE_USAGE AS ISV
                        JOIN INFORMATION_SCHEMA.tables AS IST
                            ON IST.TABLE_NAME = ISV.TABLE_NAME
                        INNER JOIN mycte
                            ON ISV.view_name = mycte.table_name
    ) 

    SELECT DISTINCT  table_name, table_type
           FROM mycte
      ORDER BY
               table_name;
end 

go


if exists (select name from sys.procedures where name = 'proc_GetViewBaseTablesExpanded')
BEGIN
    drop procedure proc_GetViewBaseTablesExpanded ;
END
go
--exec proc_GetViewBaseTablesExpanded 'view_EDW_HealthAssesment'
create procedure proc_GetViewBaseTablesExpanded (@tgtView as nvarchar(100))
as 
begin
WITH mycte
    AS (SELECT 
               TU.view_name
             , TU.Table_Name
             , IST.TABLE_TYPE
               FROM
                    INFORMATION_SCHEMA.VIEW_TABLE_USAGE AS TU WITH (NOLOCK) 
                        JOIN INFORMATION_SCHEMA.tables AS IST
                            ON IST.TABLE_NAME = TU.TABLE_NAME
          WHERE view_name = @tgtView

        UNION ALL

        SELECT 
               ISV.view_name
             , ISV.Table_Name
             , IST.TABLE_TYPE
               FROM
                    INFORMATION_SCHEMA.VIEW_TABLE_USAGE AS ISV
                        JOIN INFORMATION_SCHEMA.tables AS IST
                            ON IST.TABLE_NAME = ISV.TABLE_NAME
                        INNER JOIN mycte
                            ON ISV.view_name = mycte.table_name
    ) 

    SELECT DISTINCT view_name, table_name, table_type
           FROM mycte
      ORDER BY
               view_name, table_name;
end 

go
--**************
print('END: ' + cast(getdate() as nvarchar(50)));
print('@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-');
print'***************************************************************' ;
print('START: ' + cast(getdate() as nvarchar(50)));
--**************

--SET ANSI_NULLS ON;
--SET ANSI_PADDING ON;
--SET ANSI_WARNINGS ON;
--SET ARITHABORT ON;
--SET CONCAT_NULL_YIELDS_NULL ON;
--SET NUMERIC_ROUNDABORT OFF;
--SET QUOTED_IDENTIFIER ON;





--Test Cases
--exec IVP_DataValidation 'view_EDW_RewardUserDetail' ;
--exec IVP_DataValidation 'view_EDW_SmallStepResponses' 
--exec IVP_DataValidation 'view_EDW_Coaches';
--go

GO
PRINT 'Executing C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\IVP_Views.sql ';
GO
PRINT 'Creating procedure IVP_DataValidation';
GO
IF EXISTS (SELECT
				  name
			 FROM sys.procedures
			 WHERE name = 'IVP_DataValidation') 
	BEGIN
		DROP PROCEDURE
			 IVP_DataValidation;
	END;
GO
CREATE PROCEDURE IVP_DataValidation @vname AS nvarchar (250) 
AS

	 --02.23.2015 (WDM) - Started development if the IVP procedure.
	 --02.24.2015 (WDM) - Completed and generated the procedure in the different environments.

	 BEGIN
		 IF EXISTS (SELECT
						   name
					  FROM sysobjects
					  WHERE ID = OBJECT_ID (N'IVP_Temp_II')) 
			 BEGIN
				 DROP TABLE
					  IVP_Temp_II;
			 END;
		 IF EXISTS (SELECT
						   name
					  FROM sysobjects
					  WHERE ID = OBJECT_ID (N'IVP_Temp_III')) 
			 BEGIN
				 DROP TABLE
					  IVP_Temp_III;
			 END;
		 IF EXISTS (SELECT
						   name
					  FROM sysobjects
					  WHERE ID = OBJECT_ID (N'IVP_Temp_IV')) 
			 BEGIN
				 DROP TABLE
					  IVP_Temp_IV;
			 END;
		 IF EXISTS (SELECT
						   name
					  FROM sysobjects
					  WHERE ID = OBJECT_ID (N'IVP_Temp_V')) 
			 BEGIN
				 DROP TABLE
					  IVP_Temp_V;
			 END;
		 IF EXISTS (SELECT
						   name
					  FROM sysobjects
					  WHERE ID = OBJECT_ID (N'IVP_Temp_IV')) 
			 BEGIN
				 DROP TABLE
					  IVP_Temp_IV;
			 END;
		 IF NOT EXISTS (SELECT
							   name
						  FROM sys.views
						  WHERE name = @vname) 
			 BEGIN
				 PRINT '<><><><><><><><><><><><><><><><><><><><><><><><><>';
				 PRINT 'ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ';
				 PRINT '<><><><><><><><><><><><><><><><><><><><><><><><><>';
				 PRINT ' ';
				 PRINT 'ERROR: ' + @vname + ' is missing.';
				 PRINT '<><><><><><><><><><><><><><><><><><><><><><><><><>';
				 RETURN;
			 END;
		 DECLARE @iTotal AS int = 0;
		 DECLARE @mysql AS nvarchar (2000) = '';
		 DECLARE @ProcStartTime AS datetime = GETDATE () ;
		 DECLARE @StartTime AS datetime = GETDATE () ;
		 DECLARE @EndTime AS datetime = GETDATE () ;
		 DECLARE @ETime AS nvarchar (200) = '';
		 DECLARE @CurrSvr nvarchar (250) = (SELECT
												   @@servername) ;
		 DECLARE @CurrDB nvarchar (250) = (SELECT
												  DB_NAME ()) ;
		 SET NOCOUNT ON;

		 --select count(*) as cnt into IVP_Temp_II from view_EDW_SmallStepResponses

		 PRINT '**************************************************************************************';
		 PRINT 'Veryfying Data From: ' + @vname + ' on server ' + @CurrSvr + ' within DB: ' + @CurrDB;
		 IF EXISTS (SELECT
						   name
					  FROM sysobjects
					  WHERE ID = OBJECT_ID (N'IVP_Temp_II')) 
			 BEGIN
				 DROP TABLE
					  IVP_Temp_II;
			 END;

		 --select count(*) as cnt into IVP_Temp_II from view_EDW_Coaches;		

		 SET @mysql = 'select count(*) as cnt into IVP_Temp_II from ' + @vname;
		 EXEC (@mysql) ;
		 DECLARE @rowcount int = (SELECT TOP (1) 
										 cnt
									FROM IVP_Temp_II) ;
		 SET @EndTime = GETDATE () ;

		 --hours over 24, minutes,  seconds, milliseconds

		 SET @ETime = (SELECT
							  CAST (CAST (CAST (@EndTime AS float) - CAST (@StartTime AS float) AS int) * 24 + DATEPART (hh, @EndTime - @StartTime) AS varchar (10)) + ':' + RIGHT ('0' + CAST (DATEPART (mi, @EndTime - @StartTime) AS varchar (2)) , 2) + ':' + RIGHT ('0' + CAST (DATEPART (ss, @EndTime - @StartTime) AS varchar (2)) , 2) + '.' + RIGHT ('0' + CAST (DATEPART (ms, @EndTime - @StartTime) AS varchar (2)) , 2)) ;
		 PRINT 'TOTAL Records in ' + @vname + ': ' + CAST (@rowcount AS nvarchar (50)) + '.';
		 PRINT 'Execution Time: ' + @ETime;

		 --********************************************

		 IF EXISTS (SELECT
						   name
					  FROM sysobjects
					  WHERE ID = OBJECT_ID (N'IVP_Temp_III')) 
			 BEGIN
				 DROP TABLE
					  IVP_Temp_III;
			 END;
		 SET @StartTime = GETDATE () ;
		 SET @mysql = 'select top 100 * into IVP_Temp_III from ' + @vname;
		 EXEC (@mysql) ;
		 SET @EndTime = GETDATE () ;

		 --hours over 24, minutes,  seconds, milliseconds

		 SET @ETime = (SELECT
							  CAST (CAST (CAST (@EndTime AS float) - CAST (@StartTime AS float) AS int) * 24 + DATEPART (hh, @EndTime - @StartTime) AS varchar (10)) + ':' + RIGHT ('0' + CAST (DATEPART (mi, @EndTime - @StartTime) AS varchar (2)) , 2) + ':' + RIGHT ('0' + CAST (DATEPART (ss, @EndTime - @StartTime) AS varchar (2)) , 2) + '.' + RIGHT ('0' + CAST (DATEPART (ms, @EndTime - @StartTime) AS varchar (2)) , 2)) ;
		 PRINT '-------------------';
		 PRINT 'Execution Time to Select 100 Rows into TEMP TABLE: ' + @ETime;

		 --********************************************

		 IF EXISTS (SELECT
						   name
					  FROM sysobjects
					  WHERE ID = OBJECT_ID (N'IVP_Temp_IV')) 
			 BEGIN
				 DROP TABLE
					  IVP_Temp_IV;
			 END;
		 IF @rowcount > 1000
			 BEGIN
				 SET @StartTime = GETDATE () ;
				 SET @mysql = 'select top 1000 * into IVP_Temp_IV from ' + @vname;
				 EXEC (@mysql) ;
				 SET @EndTime = GETDATE () ;

				 --hours over 24, minutes,  seconds, milliseconds

				 SET @ETime = (SELECT
									  CAST (CAST (CAST (@EndTime AS float) - CAST (@StartTime AS float) AS int) * 24 + DATEPART (hh, @EndTime - @StartTime) AS varchar (10)) + ':' + RIGHT ('0' + CAST (DATEPART (mi, @EndTime - @StartTime) AS varchar (2)) , 2) + ':' + RIGHT ('0' + CAST (DATEPART (ss, @EndTime - @StartTime) AS varchar (2)) , 2) + '.' + RIGHT ('0' + CAST (DATEPART (ms, @EndTime - @StartTime) AS varchar (2)) , 2)) ;
				 PRINT '-------------------';
				 PRINT 'Execution Time to Select 1,000 Rows into TEMP TABLE: ' + @ETime;
			 END;

		 --********************************************

		 IF EXISTS (SELECT
						   name
					  FROM sysobjects
					  WHERE ID = OBJECT_ID (N'IVP_Temp_V')) 
			 BEGIN
				 DROP TABLE
					  IVP_Temp_V;
			 END;
		 IF @rowcount > 10000
			 BEGIN
				 SET @StartTime = GETDATE () ;
				 SET @mysql = 'select top 10000 * into IVP_Temp_V from ' + @vname;
				 EXEC (@mysql) ;
				 SET @EndTime = GETDATE () ;

				 --hours over 24, minutes,  seconds, milliseconds

				 SET @ETime = (SELECT
									  CAST (CAST (CAST (@EndTime AS float) - CAST (@StartTime AS float) AS int) * 24 + DATEPART (hh, @EndTime - @StartTime) AS varchar (10)) + ':' + RIGHT ('0' + CAST (DATEPART (mi, @EndTime - @StartTime) AS varchar (2)) , 2) + ':' + RIGHT ('0' + CAST (DATEPART (ss, @EndTime - @StartTime) AS varchar (2)) , 2) + '.' + RIGHT ('0' + CAST (DATEPART (ms, @EndTime - @StartTime) AS varchar (2)) , 2)) ;
				 PRINT '-------------------';
				 PRINT 'Execution Time to Select 10,000 Rows into TEMP TABLE: ' + @ETime;
			 END;

		 --********************************************

		 IF EXISTS (SELECT
						   name
					  FROM sysobjects
					  WHERE ID = OBJECT_ID (N'IVP_Temp_IV')) 
			 BEGIN
				 DROP TABLE
					  IVP_Temp_IV;
			 END;
		 IF @rowcount > 100000
			 BEGIN
				 SET @StartTime = GETDATE () ;
				 SET @mysql = 'select top 100000 * into IVP_Temp_IV from ' + @vname;
				 EXEC (@mysql) ;
				 SET @EndTime = GETDATE () ;

				 --hours over 24, minutes,  seconds, milliseconds

				 SET @ETime = (SELECT
									  CAST (CAST (CAST (@EndTime AS float) - CAST (@StartTime AS float) AS int) * 24 + DATEPART (hh, @EndTime - @StartTime) AS varchar (10)) + ':' + RIGHT ('0' + CAST (DATEPART (mi, @EndTime - @StartTime) AS varchar (2)) , 2) + ':' + RIGHT ('0' + CAST (DATEPART (ss, @EndTime - @StartTime) AS varchar (2)) , 2) + '.' + RIGHT ('0' + CAST (DATEPART (ms, @EndTime - @StartTime) AS varchar (2)) , 2)) ;
				 PRINT '-------------------';
				 PRINT 'Execution Time to Select 100,000 Rows into TEMP TABLE: ' + @ETime;
			 END;
		 PRINT '**************************************************************************************';
		 IF EXISTS (SELECT
						   name
					  FROM sysobjects
					  WHERE ID = OBJECT_ID (N'IVP_Temp_II')) 
			 BEGIN
				 DROP TABLE
					  IVP_Temp_II;
			 END;
		 IF EXISTS (SELECT
						   name
					  FROM sysobjects
					  WHERE ID = OBJECT_ID (N'IVP_Temp_III')) 
			 BEGIN
				 DROP TABLE
					  IVP_Temp_III;
			 END;
		 IF EXISTS (SELECT
						   name
					  FROM sysobjects
					  WHERE ID = OBJECT_ID (N'IVP_Temp_IV')) 
			 BEGIN
				 DROP TABLE
					  IVP_Temp_IV;
			 END;
		 IF EXISTS (SELECT
						   name
					  FROM sysobjects
					  WHERE ID = OBJECT_ID (N'IVP_Temp_V')) 
			 BEGIN
				 DROP TABLE
					  IVP_Temp_V;
			 END;
		 IF EXISTS (SELECT
						   name
					  FROM sysobjects
					  WHERE ID = OBJECT_ID (N'IVP_Temp_IV')) 
			 BEGIN
				 DROP TABLE
					  IVP_Temp_IV;
			 END;
		 SET NOCOUNT OFF;
	 END;
GO
PRINT 'CREATED procedure IVP_DataValidation';
GO