


GO
PRINT 'Creating view view_EDW_HealthAssesmentClientView_STAGED';
PRINT 'Generated FROM: view_EDW_HealthAssesmentClientView_STAGED.SQL';
GO
IF EXISTS (SELECT
                  name
                  FROM sys.views
             WHERE name = 'view_EDW_HealthAssesmentClientView_STAGED') 
    BEGIN
        PRINT 'VIEW view_EDW_HealthAssesmentClientView_STAGED, replacing.';
        DROP VIEW
             view_EDW_HealthAssesmentClientView_STAGED;
    END;
GO

create view view_EDW_HealthAssesmentClientView_STAGED
as 
SELECT [AccountID]
      ,[AccountCD]
      ,[AccountName]
      ,[ClientGuid]
      ,[SiteGUID]
      ,[CompanyID]
      ,[CompanyGUID]
      ,[CompanyName]
      ,[DocumentName]
      ,[HAStartDate]
      ,[HAEndDate]
      ,[NodeSiteID]
      ,[Title]
      ,[CodeName]
      ,[IsEnabled]
      ,[ChangeType]
      ,[DocumentCreatedWhen]
      ,[DocumentModifiedWhen]
      ,[AssesmentModule_DocumentModifiedWhen]
      ,[DocumentCulture_HAAssessmentMod]
      ,[DocumentCulture_HACampaign]
      ,[DocumentCulture_HAJoined]
      ,[BiometricCampaignStartDate]
      ,[BiometricCampaignEndDate]
      ,[CampaignStartDate]
      ,[CampaignEndDate]
      ,[Name]
      ,[CampaignNodeGuid]
      ,[HACampaignID]
  FROM [dbo].[view_EDW_HealthAssesmentClientView]
GO

PRINT 'Created view view_EDW_HealthAssesmentClientView_STAGED';
GO