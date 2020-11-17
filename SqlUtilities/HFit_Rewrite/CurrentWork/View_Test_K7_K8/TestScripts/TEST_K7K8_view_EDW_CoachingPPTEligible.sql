use KenticoCMS_PRD_prod3K7
GO 
if exists (select name from sys.tables where name = 'TEST_K7K8_view_EDW_CoachingPPTEligible' )
BEGIN
    DROP Table TEST_K7K8_view_EDW_CoachingPPTEligible
END
GO


--****************************************************
Select DISTINCT top 150 
     UserID
    ,UserGUID
    ,HFitUserMpiNumber
    ,SiteGUID
    ,AccountID
    ,AccountCD
    ,AccountName
    ,RoleGUID
    ,RoleDisplayName
    ,CoachingDescription
    ,ServiceLevelDescription
INTO KenticoCMS_PRD_prod3K7.dbo.TEST_K7K8_view_EDW_CoachingPPTEligible
FROM
KenticoCMS_PRD_prod3K7.dbo.view_EDW_CoachingPPTEligible order by HFitUserMpiNumber;
--****************************************************
use KenticoCMS_PRD_prod3K8
GO 
if exists (select name from sys.tables where name = 'TEST_K7K8_view_EDW_CoachingPPTEligible' )
BEGIN
    DROP Table TEST_K7K8_view_EDW_CoachingPPTEligible
END
GO


--****************************************************
Select DISTINCT top 150 
     UserID
    ,UserGUID
    ,HFitUserMpiNumber
    ,SiteGUID
    ,AccountID
    ,AccountCD
    ,AccountName
    ,RoleGUID
    ,RoleDisplayName
    ,CoachingDescription
    ,ServiceLevelDescription
INTO KenticoCMS_PRD_prod3K8.dbo.TEST_K7K8_view_EDW_CoachingPPTEligible
FROM
KenticoCMS_PRD_prod3K8.dbo.view_EDW_CoachingPPTEligible order by HFitUserMpiNumber;
--****************************************************
GO

select top 100 * from KenticoCMS_PRD_prod3K7.dbo.TEST_K7K8_view_EDW_CoachingPPTEligible order by HFitUserMpiNumber;

select top 100 * from KenticoCMS_PRD_prod3K8.dbo.TEST_K7K8_view_EDW_CoachingPPTEligible order by HFitUserMpiNumber;

--update HFit_EDW_K7K8_TestDDL set Passed = 1 where VIEW_NAME = 'view_EDW_CoachingPPTEligible'; 