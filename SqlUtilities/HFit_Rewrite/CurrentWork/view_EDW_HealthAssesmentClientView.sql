
GO
PRINT 'Processing: view_EDW_HealthAssesmentClientView ';
GO

IF EXISTS (SELECT
                  TABLE_NAME
                  FROM INFORMATION_SCHEMA.VIEWS
             WHERE TABLE_NAME = 'view_EDW_HealthAssesmentClientView') 
    BEGIN
        DROP VIEW
             view_EDW_HealthAssesmentClientView;
    END;
GO

--GRANT SELECT
--	ON [dbo].[view_EDW_HealthAssesmentClientView]
--	TO [EDWReader_PRD]
--GO

--******************************************************************************
--8/8/2014 - Generated corrected view in DEV (WDM)
--09.11.2014 (wdm) added to facilitate EDW last mod date
--02.04.2015 (wdm) #48828 added , HACampaign.BiometricCampaignStartDate, 
--		  HACampaign.BiometricCampaignEndDate, HACampaign.CampaignStartDate, 
--		  HACampaign.CampaignEndDate, HACampaign.Name, 
--		  HACampaign.NodeGuid as CampaignNodeGuid
--02.05.2015 Ashwin and I reviewed and approved
-- select top 100 * from view_EDW_HealthAssesmentClientView
--03.27.2015 ( Sowmiya V) - made changes to the view to look at the HealthAssesmentID 
--  only in the join condition.
--  The fix was needed to handle the SR#51281: Platform CampaignNodeGuid missing. 
--	   for view view_EDW_HealthAssesmentClientView
--  Leaving the old code as commented with notes. 
-- 03.13.2015 - (WDM) set the view up for change tracking - the SIMPLE version that does not 
--			 require change tracking tables to be involved.
--select count(*) from view_EDW_HealthAssesmentClientView
--SELECT * FROM   INFORMATION_SCHEMA.VIEWS WHERE  VIEW_DEFINITION like '%view_EDW_HealthAssesmentClientView%'
--******************************************************************************
CREATE VIEW dbo.view_EDW_HealthAssesmentClientView
AS SELECT 
          HFitAcct.AccountID
        , HFitAcct.AccountCD
        , HFitAcct.AccountName
        , HFitAcct.ItemGUID AS ClientGuid
        , CMSSite.SiteGUID
        , NULL AS CompanyID
        , NULL AS CompanyGUID
        , NULL AS CompanyName
        , HAJoined.DocumentName
        , cast(HACampaign.DocumentPublishFrom as datetime) AS HAStartDate
        , cast(HACampaign.DocumentPublishTo as datetime) AS HAEndDate
        , HACampaign.NodeSiteID
        , HAAssessmentMod.Title
        , HAAssessmentMod.CodeName
        , HAAssessmentMod.IsEnabled
        , CASE
              WHEN CAST (HACampaign.DocumentCreatedWhen AS date) = CAST (HACampaign.DocumentModifiedWhen AS date) 
                  THEN 'I'
              ELSE 'U'
          END AS ChangeType
        , cast(HACampaign.DocumentCreatedWhen as datetime) as DocumentCreatedWhen
        , cast(HACampaign.DocumentModifiedWhen as datetime) as DocumentModifiedWhen
        , cast(HAAssessmentMod.DocumentModifiedWhen  as datetime) AS AssesmentModule_DocumentModifiedWhen     --09.11.2014 (wdm) added to facilitate EDW last mod date
        , HAAssessmentMod.DocumentCulture AS DocumentCulture_HAAssessmentMod
        , HACampaign.DocumentCulture AS DocumentCulture_HACampaign
        , HAJoined.DocumentCulture AS DocumentCulture_HAJoined
        , cast(HACampaign.BiometricCampaignStartDate as datetime)as BiometricCampaignStartDate
        , cast(HACampaign.BiometricCampaignEndDate as datetime)as BiometricCampaignEndDate
        , cast(HACampaign.CampaignStartDate as datetime)as CampaignStartDate
        , cast(HACampaign.CampaignEndDate as datetime)as CampaignEndDate
        , HACampaign.Name
        , HACampaign.NodeGuid AS CampaignNodeGuid
        , HACampaign.HACampaignID
          FROM
               dbo.View_HFit_HACampaign_Joined AS HACampaign
                   INNER JOIN dbo.CMS_Site AS CMSSite
                       ON HACampaign.NodeSiteID = CMSSite.SiteID
                   INNER JOIN dbo.HFit_Account AS HFitAcct
                       ON HACampaign.NodeSiteID = HFitAcct.SiteID
                   INNER JOIN dbo.View_HFit_HealthAssessment_Joined AS HAJoined
                       ON HACampaign.HealthAssessmentID = HAJoined.DocumentID      
					   --  added line to handle    SR #51281   
                          -- ON CASE --
					   --03.27.2015 - Commented code to release the SR #51281
                          --WHEN [HACampaign].[HealthAssessmentConfigurationID] < 0
                          --THEN [HACampaign].[HealthAssessmentID]
                          --ELSE [HACampaign].[HealthAssessmentConfigurationID]
                          --END = HAJoined.DocumentID
                      AND HAJoined.DocumentCulture = 'en-US'
                   INNER JOIN dbo.View_HFit_HealthAssesmentModule_Joined AS HAAssessmentMod
                       ON HAJoined.nodeid = HAAssessmentMod.NodeParentID
                      AND HAAssessmentMod.DocumentCulture = 'en-US'
     WHERE HACampaign.DocumentCulture = 'en-US';
GO

PRINT 'Created: view_EDW_HealthAssesmentClientView ';
GO
--  
--  
GO
PRINT '***** FROM: view_EDW_HealthAssesmentClientView.sql';
GO 
