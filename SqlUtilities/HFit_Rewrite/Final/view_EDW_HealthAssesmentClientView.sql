
if exists(select TABLE_NAME from INFORMATION_SCHEMA.VIEWS where TABLE_NAME = 'view_EDW_HealthAssesmentClientView')
BEGIN
	drop view view_EDW_HealthAssesmentClientView ;
END

GO

--******************************************************************************
--8/8/2014 - Generated corrected view in DEV (WDM)
--09.11.2014 (wdm) added to facilitate EDW last mod date
--******************************************************************************
CREATE VIEW [dbo].[view_EDW_HealthAssesmentClientView]
AS
	SELECT
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
		, CASE	WHEN CAST(HACampaign.DocumentCreatedWhen AS DATE) = CAST(HACampaign.DocumentModifiedWhen AS DATE)
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		, HACampaign.DocumentCreatedWhen
		, HACampaign.DocumentModifiedWhen
		, HAAssessmentMod.DocumentModifiedWhen as AssesmentModule_DocumentModifiedWhen	--09.11.2014 (wdm) added to facilitate EDW last mod date
	FROM
		dbo.View_HFit_HACampaign_Joined AS HACampaign
	INNER JOIN dbo.CMS_Site AS CMSSite ON HACampaign.NodeSiteID = CMSSite.SiteID
	INNER JOIN dbo.HFit_Account AS HFitAcct ON HACampaign.NodeSiteID = HFitAcct.SiteID
	INNER JOIN dbo.View_HFit_HealthAssessment_Joined AS HAJoined ON ( CASE
									WHEN HACampaign.HealthAssessmentConfigurationID < 0
									THEN HACampaign.HealthAssessmentID
									ELSE HACampaign.HealthAssessmentConfigurationID
									END ) = HAJoined.DocumentID
									--END ) = HAJoined.DocumentID
	INNER JOIN dbo.View_HFit_HealthAssesmentModule_Joined AS HAAssessmentMod ON HAJoined.nodeid = HAAssessmentMod.NodeParentID



GO


