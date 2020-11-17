use KenticoCMS_PRD_prod3K7
GO 
if exists (select name from sys.tables where name = 'TEST_K7K8_view_EDW_HealthInterestDetail' )
BEGIN
    DROP Table TEST_K7K8_view_EDW_HealthInterestDetail
END
GO


--****************************************************
Select DISTINCT top 100 
     UserID
    ,UserGUID
    ,HFitUserMpiNumber
    ,SiteGUID
    ,CoachingHealthInterestID
    ,FirstHealthAreaID
    ,FirstNodeID
    ,FirstNodeGuid
    ,FirstHealthAreaName
    ,FirstHealthAreaDescription
    ,FirstCodeName
    ,SecondHealthAreaID
    ,SecondNodeID
    ,SecondNodeGuid
    ,SecondHealthAreaName
    ,SecondHealthAreaDescription
    ,SecondCodeName
    ,ThirdHealthAreaID
    ,ThirdNodeID
    ,ThirdNodeGuid
    ,ThirdHealthAreaName
    ,ThirdHealthAreaDescription
    ,ThirdCodeName
    ,ItemCreatedWhen
    ,ItemModifiedWhen
INTO KenticoCMS_PRD_prod3K7.dbo.TEST_K7K8_view_EDW_HealthInterestDetail
FROM
view_EDW_HealthInterestDetail where HFitUserMpiNumber > 0 and ItemCreatedWhen is not null;
--****************************************************
use KenticoCMS_PRD_prod3K8
GO 
if exists (select name from sys.tables where name = 'TEST_K7K8_view_EDW_HealthInterestDetail' )
BEGIN
    DROP Table TEST_K7K8_view_EDW_HealthInterestDetail
END
GO


--****************************************************
Select DISTINCT top 100 
     UserID
    ,UserGUID
    ,HFitUserMpiNumber
    ,SiteGUID
    ,CoachingHealthInterestID
    ,FirstHealthAreaID
    ,FirstNodeID
    ,FirstNodeGuid
    ,FirstHealthAreaName
    ,FirstHealthAreaDescription
    ,FirstCodeName
    ,SecondHealthAreaID
    ,SecondNodeID
    ,SecondNodeGuid
    ,SecondHealthAreaName
    ,SecondHealthAreaDescription
    ,SecondCodeName
    ,ThirdHealthAreaID
    ,ThirdNodeID
    ,ThirdNodeGuid
    ,ThirdHealthAreaName
    ,ThirdHealthAreaDescription
    ,ThirdCodeName
    ,ItemCreatedWhen
    ,ItemModifiedWhen
INTO KenticoCMS_PRD_prod3K8.dbo.TEST_K7K8_view_EDW_HealthInterestDetail
FROM
view_EDW_HealthInterestDetail where HFitUserMpiNumber > 0 and ItemCreatedWhen is not null;
--****************************************************
GO

select top 100 * from KenticoCMS_PRD_prod3K7.dbo.TEST_K7K8_view_EDW_HealthInterestDetail order by UserGuid;

select top 100 * from KenticoCMS_PRD_prod3K8.dbo.TEST_K7K8_view_EDW_HealthInterestDetail order by UserGuid;

--update HFit_EDW_K7K8_TestDDL set Passed = 1 where VIEW_NAME = 'view_EDW_HealthInterestDetail'; 