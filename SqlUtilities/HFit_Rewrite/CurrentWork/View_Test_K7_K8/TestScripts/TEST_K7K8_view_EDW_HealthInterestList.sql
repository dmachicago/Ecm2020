use KenticoCMS_PRD_prod3K7
GO 
if exists (select name from sys.tables where name = 'TEST_K7K8_view_EDW_HealthInterestList' )
BEGIN
    DROP Table TEST_K7K8_view_EDW_HealthInterestList
END
GO


--****************************************************
Select DISTINCT top 1000 
     HealthAreaID
    ,NodeID
    ,NodeGuid
    ,AccountCD
    ,HealthAreaName
    ,HealthAreaDescription
    ,CodeName
    ,DocumentCreatedWhen
    ,DocumentModifiedWhen
INTO KenticoCMS_PRD_prod3K7.dbo.TEST_K7K8_view_EDW_HealthInterestList
FROM
view_EDW_HealthInterestList;
--****************************************************
use KenticoCMS_PRD_prod3K8
GO 
if exists (select name from sys.tables where name = 'TEST_K7K8_view_EDW_HealthInterestList' )
BEGIN
    DROP Table TEST_K7K8_view_EDW_HealthInterestList
END
GO


--****************************************************
Select DISTINCT top 1000 
     HealthAreaID
    ,NodeID
    ,NodeGuid
    ,AccountCD
    ,HealthAreaName
    ,HealthAreaDescription
    ,CodeName
    ,DocumentCreatedWhen
    ,DocumentModifiedWhen
INTO KenticoCMS_PRD_prod3K8.dbo.TEST_K7K8_view_EDW_HealthInterestList
FROM
view_EDW_HealthInterestList;
--****************************************************
GO

select top 100 * from KenticoCMS_PRD_prod3K7.dbo.TEST_K7K8_view_EDW_HealthInterestList order by HealthAreaID;

select top 100 * from KenticoCMS_PRD_prod3K8.dbo.TEST_K7K8_view_EDW_HealthInterestList order by HealthAreaID;

--update HFit_EDW_K7K8_TestDDL set Passed = 1 where VIEW_NAME = 'view_EDW_HealthInterestList'; 