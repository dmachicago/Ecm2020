--Added ,6239885,7670860 to get return data for comparison
select USERSTARTEDITEMID, HFitUserMpiNumber, HACompletedDT
from dbo.view_EDW_HealthAssesment
where HFitUserMpiNumber in ( 7655977,7645528,7644773,7642714,7642697,7638625,7644907) 
order by HFitUserMpiNumber


--Added ,6239885,7670860 to get return data for comparison
select USERSTARTEDITEMID as ITEMID, HFitUserMpiNumber as MPI , HACompletedDT as DT, *
from dbo.view_EDW_HealthAssesment
where HFitUserMpiNumber in ( 7655977,7645528,7644773,7642714,7642697,7638625,7644907) 
order by HFitUserMpiNumber, HACompletedDT


/*
Findings:
- The HACompletedDT is contained within table HFit_HealthAssesmentUserStarted
- Table HFit_HealthAssesmentUserStarted is the ROOT table for the view. Therefore, for the data in column HACompletedDT
    to exist, it must be present in table HFit_HealthAssesmentUserStarted. 
- For the MPI numbers supplied, there are NULL HACompletedDT within the table HFit_HealthAssesmentUserStarted
- This will return the HACompletedDT as a null within the view
- Which leads to the question, is this a process issue in that the HACompletedDT should be filled in or can it be null?
- 
*/

select HFitUserMpiNumber, HAUserStarted.HACompletedDt as CompletedDate, * from HFit_HealthAssesmentUserStarted as HAUserStarted
INNER JOIN dbo.CMS_User AS CMSUser
                 ON HAUserStarted.UserID = CMSUser.UserID
INNER JOIN dbo.CMS_UserSettings AS UserSettings
                 ON
                    UserSettings.UserSettingsUserID = CMSUser.UserID AND
                    HFitUserMpiNumber >= 0 AND
                    HFitUserMpiNumber IS NOT NULL -- (WDM) CR47516 
where UserSettings.HFitUserMpiNumber in (7655977,7645528,7644773,7642714,7642697,7638625,7644907) 
order by UserSettings.HFitUserMpiNumber, ItemID