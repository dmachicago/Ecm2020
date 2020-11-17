

go
-- use KenticoCMS_Prod1


GO
PRINT 'Processing: view_EDW_HealthAssesmentClientView_CT ';
GO

IF EXISTS (SELECT
                  TABLE_NAME
                  FROM INFORMATION_SCHEMA.VIEWS
             WHERE TABLE_NAME = 'view_EDW_HealthAssesmentClientView_CT') 
    BEGIN
        DROP VIEW
             view_EDW_HealthAssesmentClientView_CT;
    END;
GO

CREATE VIEW dbo.view_EDW_HealthAssesmentClientView_CT
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
        , HACampaign.DocumentPublishFrom AS HAStartDate
        , HACampaign.DocumentPublishTo AS HAEndDate
        , HACampaign.NodeSiteID
        , HAAssessmentMod.Title
        , HAAssessmentMod.CodeName
        , HAAssessmentMod.IsEnabled
        , CASE
              WHEN CAST (HACampaign.DocumentCreatedWhen AS date) = CAST (HACampaign.DocumentModifiedWhen AS date) 
                  THEN 'I'
              ELSE 'U'
          END AS ChangeType
        , HACampaign.DocumentCreatedWhen
        , HACampaign.DocumentModifiedWhen
        , HAAssessmentMod.DocumentModifiedWhen AS AssesmentModule_DocumentModifiedWhen     --09.11.2014 (wdm) added to facilitate EDW last mod date
        , HAAssessmentMod.DocumentCulture AS DocumentCulture_HAAssessmentMod
        , HACampaign.DocumentCulture AS DocumentCulture_HACampaign
        , HAJoined.DocumentCulture AS DocumentCulture_HAJoined
        , HACampaign.BiometricCampaignStartDate
        , HACampaign.BiometricCampaignEndDate
        , HACampaign.CampaignStartDate
        , HACampaign.CampaignEndDate
        , HACampaign.Name
        , HACampaign.NodeGuid AS CampaignNodeGuid
        , HACampaign.HACampaignID
,	   HASHBYTES ('sha1', isNull(cast(HFitAcct.AccountID as nvarchar(50)), '-') 
					+ isNull(cast(HFitAcct.AccountCD as nvarchar(50)), '-') 
					+ isNull(cast(HFitAcct.AccountName as nvarchar(50)), '-') 
					+ isNull(cast(HFitAcct.ItemGUID as nvarchar(50)), '-') 
					+ isNull(cast(CMSSite.SiteGUID as nvarchar(50)), '-') 
					+ isNull(cast(HAJoined.DocumentName as nvarchar(50)), '-') 
					+ isNull(cast(HACampaign.DocumentPublishFrom as nvarchar(50)), '-') 
					+ isNull(cast(HACampaign.DocumentPublishTo  as nvarchar(50)), '-') 
					+ isNull(cast(HACampaign.NodeSiteID as nvarchar(50)), '-') 
					+ isNull(cast(left(HAAssessmentMod.Title,2000) as nvarchar(50)), '-') 
					+ isNull(cast(HAAssessmentMod.CodeName as nvarchar(50)), '-') 
					+ isNull(cast(HAAssessmentMod.IsEnabled as nvarchar(50)), '-') 
					+ isNull(cast(HACampaign.DocumentCreatedWhen as nvarchar(50)), '-') 
					+ isNull(cast(HACampaign.DocumentModifiedWhen as nvarchar(50)), '-') 
					+ isNull(cast(HAAssessmentMod.DocumentModifiedWhen as nvarchar(50)), '-') 
					+ isNull(cast(HACampaign.BiometricCampaignStartDate as nvarchar(50)), '-') 
					+ isNull(cast(HACampaign.BiometricCampaignEndDate as nvarchar(50)), '-') 
					+ isNull(cast(HACampaign.CampaignStartDate as nvarchar(50)), '-') 
					+ isNull(cast(HACampaign.CampaignEndDate as nvarchar(50)), '-') 
					+ isNull(cast(HACampaign.Name as nvarchar(50)), '-') 
					+ isNull(cast(HACampaign.NodeGuid as nvarchar(50)), '-') 
					+ isNull(cast(HACampaign.HACampaignID as nvarchar(50)), '-') )as HashCode
         , @@SERVERNAME as SVR
    , DB_NAME() as DBNAME
	   FROM
               dbo.View_HFit_HACampaign_Joined AS HACampaign
                   INNER JOIN dbo.CMS_Site AS CMSSite
                       ON HACampaign.NodeSiteID = CMSSite.SiteID
                   INNER JOIN dbo.HFit_Account AS HFitAcct
                       ON HACampaign.NodeSiteID = HFitAcct.SiteID
                   INNER JOIN dbo.View_HFit_HealthAssessment_Joined AS HAJoined
                       ON HACampaign.HealthAssessmentID = HAJoined.DocumentID      --  added line to handle    SR #51281   
                          -- ON CASE ----03.27.2015 - Commented code to release the SR #51281
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

PRINT 'Created: view_EDW_HealthAssesmentClientView_CT ';
GO
--  
--  
GO
PRINT '***** FROM: view_EDW_HealthAssesmentClientView_CT.sql';
GO 
