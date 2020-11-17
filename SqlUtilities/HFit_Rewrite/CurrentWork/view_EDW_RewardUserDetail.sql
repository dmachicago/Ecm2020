
GO
PRINT 'Processing: view_EDW_RewardUserDetail ';
GO

IF EXISTS (SELECT
                  NAME
                  FROM sys.VIEWS
                  WHERE NAME = 'view_EDW_RewardUserDetail') 
    BEGIN
        DROP VIEW
             view_EDW_RewardUserDetail;
    END;
GO
-- select count(*) from view_EDW_RewardUserDetail --334654
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
--03.26.2015 : Removed the following per Shankar  (ItemModifiedWhen/RewardExceptionModifiedDate)
--05.02.2015 : WDM - modified view for change tracking implementation (testing only)
--05.13.2015 : PUT IT BACK per discussion with Lee Allison. However, I can easily remove it again. (ItemModifiedWhen/RewardExceptionModifiedDate)
--05.13.2015 : Pulled the column from HFRUAD.ActivityCompletedDt AS RewardExceptionModifiedDate per Nathan 
--05.14.2015 : VHFRGJ.NodeGuid AS RewardGroupGUID	 --(03.03.2015 dale/nathan corrected) and removed 03.26.2015 per Shankar; put back 03.30.2015 deemed needed; removed 05.14.2015 who knows why.
--06.26.2015 : Dhaval and Dale discuss change request to view. 
--			 HFRUAD -> HFit_RewardsUserActivityDetail, we are asked to change a field (UserExceptionAppliedTo)
--			 to now point to ActivityCompletedId -> HFit_RewardsUserActivityDetail. This req made today 
--			 from Corina thru Laura. Dhaval and I CONNOT make this change without a CR. 
--			 We decided to implement as: HFRAUD.ActivityCompletedId as UserExceptionAppliedTo
--06.28.2015 : Reviewed, tested, and Passed by Corina
--07.13.2015 : #55054 raised by Corina indicates there may be data anomolies (returned number of rows) based on whether 
--			 a LEFT or INNER join is used. WDM tested the return counts on all machines using both inner and left joins.
--				288,480 with inner join   P5/P1	 @ 07.13.2015
--				288,480 with left join	 P5/P1	 @ 07.13.2015
--				372,060 with 2 left join	 P5/P1	 @ 07.13.2015
--				24,833 with inner join    P5/P2	 @ 07.13.2015
--				24,833 with left join	 P5/P2	 @ 07.13.2015
--				40,738 with 2 left join	 P5/P2	 @ 07.13.2015    
--				374,876 with inner join   P5/P3	 @ 07.13.2015
--				374,876 with left join	 P5/P3	 @ 07.13.2015
--				523,203 with 2 left join	 P5/P3	 @ 07.13.2015		  
--			 NOTE: In all instances on Prod5 and TGT, the returned row count is the same.
--08.02.2015	 Corina and Dale reviewed and tested the view DDL with corrections suggested by Corina that will cause a more 
--			 complete set of User Rewards to be returned.
--08.06.2015	 Yesterday the ciew was approved by Corina and is being scheduled for implementation tonight.
--**************************************************************************************************************************************************

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
PRINT 'Completed : view_EDW_RewardUserDetail ';
GO

/*----------------------------------------
(WDM) Kept only these columns IAW CR-51005
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
