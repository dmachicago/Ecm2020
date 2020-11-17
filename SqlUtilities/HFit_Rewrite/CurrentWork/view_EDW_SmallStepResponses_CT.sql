
GO

-- use KenticoCMS_Prod1

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

CREATE VIEW dbo.view_EDW_SmallStepResponses_CT
AS
/*
select top 100 * from view_EDW_SmallStepResponses_CT

select distinct count(*), SSItemID
from view_EDW_SmallStepResponses_CT
group by SSItemID 
having count(*) > 1

drop table ##Temp_SmallSteps
go
select  TOP 10 *
into STAGING_EDW_SmallSteps
from view_EDW_SmallStepResponses_CT
select * from ##Temp_SmallSteps
*/

SELECT  
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
     , null AS DeletedFlg
	, getdate() as LastModifiedDate
     , cast( HASHBYTES ('sha1', ISNULL (LEFT (OutcomeMSG.Message, 2000) , '-') 
			 + ISNULL ( CAST (SS.ItemModifiedBy AS nvarchar (50)) , '-') 
			 + ISNULL ( CAST (SS.ItemModifiedWhen AS nvarchar (50)) , '-') 
			 + ISNULL ( CAST (SS.ItemOrder AS nvarchar (50)) , '-') 
			 + ISNULL (vwCamp.Name, '-') 
			 + ISNULL ( CAST (vwCamp.CampaignStartDate AS nvarchar (50)) , '-') 
			 + ISNULL ( CAST (vwCamp.CampaignEndDate AS nvarchar (50)) , '-') 
			 + ISNULL ( CAST (HAUS.HAStartedDt AS nvarchar (50)) , '-') 
			 + ISNULL ( CAST (HAUS.HACompletedDt AS nvarchar (50)) , '-') 
			 + ISNULL ( CAST (HAUS.HAStartedMode AS nvarchar (50)) , '-') 
			 + ISNULL ( CAST (HAUS.HACompletedMode AS nvarchar (50)) , '-') 
			 + ISNULL ( TODO.HaCodeName, '-') 
			 + ISNULL ( CAST (SS.ItemGUID AS nvarCHAR (50)) , '-') 
			 + ISNULL ( CAST (vwCamp.CampaignStartDate AS nvarchar (50)) , '-') 
			 + ISNULL ( CAST (vwCamp.CampaignEndDate AS nvarchar (50)) , '-') 
			 + ISNULL(CAST(CMS_US.HFitUserMPINumber AS NVARCHAR(50)),'-')
			 ) as nvarchar(100)) AS HashCode
     , COALESCE ( 
		  --CT_Hfit_SmallStepResponses.SYS_CHANGE_OPERATION,
				CT_HFit_ToDoSmallSteps.SYS_CHANGE_OPERATION,
				CT_HFit_Account.SYS_CHANGE_OPERATION,
				CT_HFit_OutComeMessages.SYS_CHANGE_OPERATION,
				CT_HFit_HealthAssesmentUserStarted.SYS_CHANGE_OPERATION,
				CT_HFit_HACampaign.SYS_CHANGE_OPERATION,
				CT_CMS_Site.SYS_CHANGE_OPERATION,
				CT_CMS_UserSettings.SYS_CHANGE_OPERATION
       ) AS ChangeType

    --   /********************************************/

     , CT_CMS_UserSettings.UserSettingsID AS CT_UserSettingsID     
     , CT_CMS_UserSettings.SYS_CHANGE_VERSION AS CT_CMS_UserSettings_SCV

     , CT_CMS_Site.SiteID AS SiteID_CtID
     , CT_CMS_Site.SYS_CHANGE_OPERATION AS SiteID_CHANGE_OPERATION
     , CT_CMS_Site.SYS_CHANGE_VERSION AS SITE_SCV

     , CT_HFit_HACampaign.HACampaignID AS Campaign_CtID
     , CT_HFit_HACampaign.SYS_CHANGE_VERSION AS Campaign_SCV

     , CT_HFit_HealthAssesmentUserStarted.ItemID AS HealthAssesmentUserStarted_CtID
     , CT_HFit_HealthAssesmentUserStarted.SYS_CHANGE_VERSION AS HealthAssesmentUserStarted_SCV

     , CT_HFit_OutComeMessages.OutComeMessagesID AS OutComeMessages_CtID
     , CT_HFit_OutComeMessages.SYS_CHANGE_VERSION AS OutComeMessages_SCV

     , CT_HFit_Account.AccountID AS HFit_Account_CtID
     , CT_HFit_Account.SYS_CHANGE_VERSION AS HFit_Account_SCV

     , CT_HFit_ToDoSmallSteps.ItemID AS ToDoSmallSteps_CtID
     , CT_HFit_ToDoSmallSteps.SYS_CHANGE_VERSION AS ToDoSmallSteps_SCV

	, CT_CMS_UserSettings.SYS_CHANGE_OPERATION AS CT_UserSettings_CHANGE_OPERATION
     , CT_HFit_HACampaign.SYS_CHANGE_OPERATION AS Campaign_CHANGE_OPERATION
     , CT_HFit_HealthAssesmentUserStarted.SYS_CHANGE_OPERATION AS HealthAssesmentUserStarted_CHANGE_OPERATION
     , CT_HFit_OutComeMessages.SYS_CHANGE_OPERATION AS OutComeMessages_CHANGE_OPERATION
     , CT_HFit_Account.SYS_CHANGE_OPERATION AS HFit_Account_CHANGE_OPERATION
     , CT_HFit_ToDoSmallSteps.SYS_CHANGE_OPERATION AS ToDoSmallSteps_CHANGE_OPERATION

    /* THE BELOW CAUSES A MASSIVE PERFORMANCE HIT - SO IT IS COMMENTED OUT (WDM) */
    , CT_Hfit_SmallStepResponses.ItemID AS SmallStepResponses_CtID
    , CT_Hfit_SmallStepResponses.SYS_CHANGE_VERSION AS SmallStepResponses_SCV
    , CT_Hfit_SmallStepResponses.SYS_CHANGE_OPERATION AS SmallStepResponses_CHANGE_OPERATION

    --, newid() AS RowNbr

       , @@SERVERNAME as SVR
    , DB_NAME() as DBNAME
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
			 LEFT JOIN CHANGETABLE (CHANGES Hfit_SmallStepResponses, NULL) AS CT_Hfit_SmallStepResponses
                   ON SS.ItemID = CT_Hfit_SmallStepResponses.ItemID
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
                   ON TODO.ItemID = CT_HFit_ToDoSmallSteps.ItemID

			 --where 
			 --CT_UserSettings_CHANGE_OPERATION.SYS_CHANGE_OPERATION is not null 
				-- Campaign_CHANGE_OPERATION.SYS_CHANGE_OPERATION is not null OR
				-- HealthAssesmentUserStarted_CHANGE_OPERATION.SYS_CHANGE_OPERATION is not null OR
				-- OutComeMessages_CHANGE_OPERATION.SYS_CHANGE_OPERATION is not null OR
				-- HFit_Account_CHANGE_OPERATION.SYS_CHANGE_OPERATION is not null OR
				-- ToDoSmallSteps_CHANGE_OPERATION.SYS_CHANGE_OPERATION is not null OR
				-- SmallStepResponses_CHANGE_OPERATION.SYS_CHANGE_OPERATION is not null


GO
PRINT 'Created view view_EDW_SmallStepResponses_CT';
GO
