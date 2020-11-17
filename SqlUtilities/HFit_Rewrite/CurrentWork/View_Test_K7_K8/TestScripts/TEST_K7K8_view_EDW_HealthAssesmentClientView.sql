use KenticoCMS_PRD_prod3K7
GO 
if exists (select name from sys.tables where name = 'TEST_K7K8_view_EDW_HealthAssesmentClientView' )
BEGIN
    DROP Table TEST_K7K8_view_EDW_HealthAssesmentClientView
END
GO


--****************************************************
Select DISTINCT top 150 
     AccountID
    ,AccountCD
    ,AccountName
    ,ClientGuid
    ,SiteGUID
    ,CompanyID
    ,CompanyGUID
    ,CompanyName
    ,DocumentName
    ,HAStartDate
    ,HAEndDate
    ,NodeSiteID
    ,Title
    ,CodeName
    ,IsEnabled
    ,ChangeType
    ,DocumentCreatedWhen
    ,DocumentModifiedWhen
    ,AssesmentModule_DocumentModifiedWhen
    ,DocumentCulture_HAAssessmentMod
    ,DocumentCulture_HACampaign
    ,DocumentCulture_HAJoined
    ,BiometricCampaignStartDate
    ,BiometricCampaignEndDate
    ,CampaignStartDate
    ,CampaignEndDate
    ,Name
    ,CampaignNodeGuid
    ,HACampaignID
INTO KenticoCMS_PRD_prod3K7.dbo.TEST_K7K8_view_EDW_HealthAssesmentClientView
FROM
KenticoCMS_PRD_prod3K7.dbo.view_EDW_HealthAssesmentClientView order by AssesmentModule_DocumentModifiedWhen, Title;
--****************************************************
use KenticoCMS_PRD_prod3K8
GO 
if exists (select name from sys.tables where name = 'TEST_K7K8_view_EDW_HealthAssesmentClientView' )
BEGIN
    DROP Table TEST_K7K8_view_EDW_HealthAssesmentClientView
END
GO


--****************************************************
Select DISTINCT top 150 
     AccountID
    ,AccountCD
    ,AccountName
    ,ClientGuid
    ,SiteGUID
    ,CompanyID
    ,CompanyGUID
    ,CompanyName
    ,DocumentName
    ,HAStartDate
    ,HAEndDate
    ,NodeSiteID
    ,Title
    ,CodeName
    ,IsEnabled
    ,ChangeType
    ,DocumentCreatedWhen
    ,DocumentModifiedWhen
    ,AssesmentModule_DocumentModifiedWhen
    ,DocumentCulture_HAAssessmentMod
    ,DocumentCulture_HACampaign
    ,DocumentCulture_HAJoined
    ,BiometricCampaignStartDate
    ,BiometricCampaignEndDate
    ,CampaignStartDate
    ,CampaignEndDate
    ,Name
    ,CampaignNodeGuid
    ,HACampaignID
INTO KenticoCMS_PRD_prod3K8.dbo.TEST_K7K8_view_EDW_HealthAssesmentClientView
FROM
KenticoCMS_PRD_prod3K8.dbo.view_EDW_HealthAssesmentClientView order by AssesmentModule_DocumentModifiedWhen, Title;
--****************************************************
GO

select top 100 * from KenticoCMS_PRD_prod3K7.dbo.TEST_K7K8_view_EDW_HealthAssesmentClientView order by AssesmentModule_DocumentModifiedWhen, Title;

select top 100 * from KenticoCMS_PRD_prod3K8.dbo.TEST_K7K8_view_EDW_HealthAssesmentClientView order by AssesmentModule_DocumentModifiedWhen, Title;

--update HFit_EDW_K7K8_TestDDL set Passed = 1 where VIEW_NAME = 'view_EDW_HealthAssesmentClientView'; 