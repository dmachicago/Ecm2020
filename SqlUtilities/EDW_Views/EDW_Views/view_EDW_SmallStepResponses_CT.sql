
GO

PRINT 'Creating view view_EDW_SmallStepResponses_CT';
PRINT 'Generated FROM: view_EDW_SmallStepResponses_CT.SQL';

GO
IF EXISTS (SELECT
                  name
                  FROM sys.views
             WHERE name = 'view_EDW_SmallStepResponses_CT') 
    BEGIN
        PRINT 'VIEW view_EDW_SmallStepResponses_CT, replacing.';
        DROP VIEW
             view_EDW_SmallStepResponses_CT;
    END;
GO

--select * into #Temp1 from view_EDW_SmallStepResponses_CT --108,083 00:01:07 @ Prod1
--select * into #temp2 from view_EDW_SmallStepResponses_CT where ChangeType is not null --0 recs at 00:00:23 @ Prod1

/*
SELECT 
       *
INTO
     #SmallSteps
       FROM view_EDW_SmallStepResponses_CT;
*/

CREATE VIEW dbo.view_EDW_SmallStepResponses_CT
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
-- WHERE OutcomeMSG.DocumentCulture = 'en-US' AND vwCamp.DocumentCulture = 'en-US';
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
--04.06.2014 (WDM/JC) John found an error in the JOIN of user ID - changed to CMS_US.UserSettingsUserID = SS.UserID
--04.15.2015 (WDM/Shane) Found an issue with duplicate rows. Added the SiteID to the JOIN (eg.
--			  vwCamp.NodeSiteID = usrste.SiteID and moved the join down in the list.)
--********************************************************************************************************

/*
select count(*), AccountCD, SiteGUID, SSItemID, SSItemGUID,SSHealthAssesmentUserStartedItemID, SSOutcomeMessageGuid, HFitUserMPINumber,HACampaignNodeGUID , HAStartedMode, HACompletedMode, HaCodeName, HFitUserMPINumber
from view_EDW_SmallStepResponses
group by AccountCD, SiteGUID, SSItemID, SSItemGUID,SSHealthAssesmentUserStartedItemID, SSOutcomeMessageGuid, HFitUserMPINumber,HACampaignNodeGUID , HAStartedMode, HACompletedMode, HaCodeName, HFitUserMPINumber
having count(*) > 1
*/

SELECT DISTINCT
       SS.UserID
     , ACCT.AccountCD
     , CMSSITE.SiteGUID
     , SS.ItemID AS SSItemID
     , SS.ItemCreatedBy AS SSItemCreatedBy
     , SS.ItemCreatedWhen AS SSItemCreatedWhen
     , SS.ItemModifiedBy AS SSItemModifiedBy
     , SS.ItemModifiedWhen AS SSItemModifiedWhen
     , SS.ItemOrder AS SSItemOrder
     , SS.ItemGUID AS SSItemGUID
     , SS.HealthAssesmentUserStartedItemID AS SSHealthAssesmentUserStartedItemID
     , SS.OutComeMessageGUID AS SSOutcomeMessageGuid
     , REPLACE (OutcomeMSG.Message, '&#39;', '''') AS SSOutcomeMessage
     , HAUS.HACampaignNodeGUID
       --, HAUS.ItemID AS HAUSItemID
     , vwCamp.Name AS HACampaignName
     , vwCamp.CampaignStartDate AS HACampaignStartDate
     , vwCamp.CampaignEndDate AS HACampaignEndDate
     , HAUS.HAStartedDt AS HAStartedDate
     , HAUS.HACompletedDt AS HACompletedDate
     , HAUS.HAStartedMode
     , HAUS.HACompletedMode
     , TODO.HaCodeName
     , CMS_US.HFitUserMPINumber
     , HASHBYTES ('sha1', ISNULL (LEFT (OutcomeMSG.Message, 2000) , '-') + ISNULL ( CAST (SS.ItemModifiedBy AS nvarchar (50)) , '-') + ISNULL ( CAST (SS.ItemModifiedWhen AS nvarchar (50)) , '-') + ISNULL ( CAST (SS.ItemOrder AS nvarchar (50)) , '-') + ISNULL (vwCamp.Name, '-') + ISNULL ( CAST (vwCamp.CampaignStartDate AS nvarchar (50)) , '-') + ISNULL ( CAST (vwCamp.CampaignEndDate AS nvarchar (50)) , '-') + ISNULL ( CAST (HAUS.HAStartedDt AS nvarchar (50)) , '-') + ISNULL ( CAST (HAUS.HACompletedDt AS nvarchar (50)) , '-') + ISNULL ( CAST (HAUS.HAStartedMode AS nvarchar (50)) , '-') + ISNULL ( CAST (HAUS.HACompletedMode AS nvarchar (50)) , '-') 
			 + ISNULL ( TODO.HaCodeName, '-') 
			 + ISNULL ( CAST (SS.ItemGUID AS nvarCHAR (50)) , '-') 
			 + ISNULL ( CAST (vwCamp.CampaignStartDate AS nvarchar (50)) , '-') 
			 + ISNULL ( CAST (vwCamp.CampaignEndDate AS nvarchar (50)) , '-') 
			 + ISNULL(CAST(CMS_US.HFitUserMPINumber AS NVARCHAR(50)),'-')
			 + ISNULL(CAST(SS.ItemID AS NVARCHAR(50)) ,'-')
       ) AS HashCode
     , COALESCE ( CT_HFit_ToDoSmallSteps.SYS_CHANGE_OPERATION,
       CT_HFit_Account.SYS_CHANGE_OPERATION,
       CT_HFit_OutComeMessages.SYS_CHANGE_OPERATION,
       CT_HFit_HealthAssesmentUserStarted.SYS_CHANGE_OPERATION,
       CT_HFit_HACampaign.SYS_CHANGE_OPERATION,
       CT_CMS_Site.SYS_CHANGE_OPERATION,
       CT_CMS_UserSettings.SYS_CHANGE_OPERATION
       ) AS ChangeType

       /********************************************/

     , CT_CMS_UserSettings.UserSettingsID AS CT_UserSettingsID
     , CT_CMS_UserSettings.SYS_CHANGE_OPERATION AS CT_UserSettings_CHANGE_OPERATION
     , CT_CMS_UserSettings.SYS_CHANGE_VERSION AS CT_CMS_UserSettings_SCV

     , CT_CMS_Site.SiteID AS SiteID_CtID
     , CT_CMS_Site.SYS_CHANGE_OPERATION AS SiteID_CHANGE_OPERATION
     , CT_CMS_Site.SYS_CHANGE_VERSION AS SITE_SCV

     , CT_HFit_HACampaign.HACampaignID AS Campaign_CtID
     , CT_HFit_HACampaign.SYS_CHANGE_OPERATION AS Campaign_CHANGE_OPERATION
     , CT_HFit_HACampaign.SYS_CHANGE_VERSION AS Campaign_SCV

     , CT_HFit_HealthAssesmentUserStarted.ItemID AS HealthAssesmentUserStarted_CtID
     , CT_HFit_HealthAssesmentUserStarted.SYS_CHANGE_OPERATION AS HealthAssesmentUserStarted_CHANGE_OPERATION
     , CT_HFit_HealthAssesmentUserStarted.SYS_CHANGE_VERSION AS HealthAssesmentUserStarted_SCV

     , CT_HFit_OutComeMessages.OutComeMessagesID AS OutComeMessages_CtID
     , CT_HFit_OutComeMessages.SYS_CHANGE_OPERATION AS OutComeMessages_CHANGE_OPERATION
     , CT_HFit_OutComeMessages.SYS_CHANGE_VERSION AS OutComeMessages_SCV

     , CT_HFit_Account.AccountID AS HFit_Account_CtID
     , CT_HFit_Account.SYS_CHANGE_OPERATION AS HFit_Account_CHANGE_OPERATION
     , CT_HFit_Account.SYS_CHANGE_VERSION AS HFit_Account_SCV

     , CT_HFit_ToDoSmallSteps.ItemID AS ToDoSmallSteps_CtID
     , CT_HFit_ToDoSmallSteps.SYS_CHANGE_OPERATION AS ToDoSmallSteps_CHANGE_OPERATION
     , CT_HFit_ToDoSmallSteps.SYS_CHANGE_VERSION AS ToDoSmallSteps_SCV

       FROM
           dbo.Hfit_SmallStepResponses AS SS
               JOIN HFit_HealthAssesmentUserStarted AS HAUS
                   ON HAUS.UserID = SS.UserID
                  AND HAUS.ItemID = SS.HealthAssesmentUserStartedItemID
                 JOIN View_HFit_OutComeMessages_Joined AS OutcomeMSG
                   ON OutcomeMSG.NodeGUID = SS.OutComeMessageGUID
                  AND OutcomeMSG.DocumentCulture = 'en-US'
                 JOIN CMS_UserSite AS USERSITE
                   ON USERSITE.UserID = SS.UserID
                 JOIN CMS_Site AS CMSSITE
                   ON CMSSITE.SiteID = USERSITE.SiteID
                 JOIN View_HFit_HACampaign_Joined AS vwCamp
                   ON vwCamp.NodeGuid = HAUS.HACampaignNodeGUID
                  AND vwCamp.DocumentCulture = 'en-US'
                  AND vwCamp.NodeSiteID = USERSITE.SiteID
                 JOIN HFit_Account AS ACCT
                   ON ACCT.SiteID = USERSITE.SiteID
                 JOIN HFit_ToDoSmallSteps AS TODO
                   ON SS.OutComeMessageGUID = TODO.OutComeMessageGUID
                 JOIN CMS_UserSettings AS CMS_US
                   ON CMS_US.UserSettingsUserID = SS.UserID
                  AND CMS_US.HFitUserMPINumber > 0
                  AND CMS_US.HFitUserMPINumber IS NOT NULL

           /*********************************************/

                 LEFT JOIN CHANGETABLE (CHANGES CMS_UserSettings, NULL) AS CT_CMS_UserSettings
                   ON CMS_US.UserSettingsID = CT_CMS_UserSettings.UserSettingsID
                 LEFT OUTER JOIN CHANGETABLE (CHANGES CMS_Site, NULL) AS CT_CMS_Site
                   ON CMSSite.SiteID = CT_CMS_Site.SiteID
                 LEFT OUTER JOIN CHANGETABLE (CHANGES HFit_HACampaign, NULL) AS CT_HFit_HACampaign
                   ON vwCamp.HACampaignID = CT_HFit_HACampaign.HACampaignID
                 LEFT OUTER JOIN CHANGETABLE (CHANGES HFit_HealthAssesmentUserStarted, NULL) AS CT_HFit_HealthAssesmentUserStarted
                   ON HAUS.ItemID = CT_HFit_HealthAssesmentUserStarted.ItemID
                 LEFT OUTER JOIN CHANGETABLE (CHANGES HFit_OutComeMessages, NULL) AS CT_HFit_OutComeMessages
                   ON OutcomeMSG.OutComeMessagesID = CT_HFit_OutComeMessages.OutComeMessagesID
                 LEFT OUTER JOIN CHANGETABLE (CHANGES HFit_Account, NULL) AS CT_HFit_Account
                   ON ACCT.AccountID = CT_HFit_Account.AccountID
                 LEFT OUTER JOIN CHANGETABLE (CHANGES HFit_ToDoSmallSteps, NULL) AS CT_HFit_ToDoSmallSteps
                   ON TODO.ItemID = CT_HFit_ToDoSmallSteps.ItemID;
--select top 100 * from HFit_ToDoSmallSteps
--select top 100 * from HFit_HealthAssesmentUserStarted

GO
PRINT 'Created view view_EDW_SmallStepResponses_CT';
GO
