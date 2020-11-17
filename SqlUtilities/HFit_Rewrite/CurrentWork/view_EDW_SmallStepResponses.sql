
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
     , cast(ss.ItemCreatedWhen as datetime)  AS SSItemCreatedWhen
     , ss.ItemModifiedBy AS SSItemModifiedBy
     , cast(ss.ItemModifiedWhen  as datetime) AS SSItemModifiedWhen
     , ss.ItemOrder AS SSItemOrder
     , ss.ItemGUID AS SSItemGUID
     , ss.HealthAssesmentUserStartedItemID AS SSHealthAssesmentUserStartedItemID
     , ss.OutComeMessageGUID AS SSOutcomeMessageGuid
     , REPLACE (vwOutcome.Message, '&#39;', '''') AS SSOutcomeMessage
     , usrstd.HACampaignNodeGUID
     , vwCamp.Name AS HACampaignName
     , cast(vwCamp.CampaignStartDate  as datetime) AS HACampaignStartDate
     , cast(vwCamp.CampaignEndDate  as datetime) AS HACampaignEndDate
     , cast(usrstd.HAStartedDt  as datetime) AS HAStartedDate
     , cast(usrstd.HACompletedDt  as datetime) AS HACompletedDate
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
