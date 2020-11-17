use KenticoCMS_PRD_prod3K7
GO 
if exists (select name from sys.tables where name = 'TEST_K7K8_view_EDW_ScreeningsFromTrackers' )
BEGIN
    DROP Table TEST_K7K8_view_EDW_ScreeningsFromTrackers
END
GO


--****************************************************
Select DISTINCT top 100 
     userid
    ,eventdate
    ,TrackerCollectionSourceID
    ,ItemCreatedBy
    ,ItemCreatedWhen
    ,ItemModifiedBy
    ,ItemModifiedWhen
INTO KenticoCMS_PRD_prod3K7.dbo.TEST_K7K8_view_EDW_ScreeningsFromTrackers
FROM
view_EDW_ScreeningsFromTrackers;
--****************************************************
use KenticoCMS_PRD_prod3K8
GO 
if exists (select name from sys.tables where name = 'TEST_K7K8_view_EDW_ScreeningsFromTrackers' )
BEGIN
    DROP Table TEST_K7K8_view_EDW_ScreeningsFromTrackers
END
GO


--****************************************************
Select DISTINCT top 100 
     userid
    ,eventdate
    ,TrackerCollectionSourceID
    ,ItemCreatedBy
    ,ItemCreatedWhen
    ,ItemModifiedBy
    ,ItemModifiedWhen
INTO KenticoCMS_PRD_prod3K8.dbo.TEST_K7K8_view_EDW_ScreeningsFromTrackers
FROM
view_EDW_ScreeningsFromTrackers;
--****************************************************
GO

select top 100 * from KenticoCMS_PRD_prod3K7.dbo.TEST_K7K8_view_EDW_ScreeningsFromTrackers order by UserID;

select top 100 * from KenticoCMS_PRD_prod3K8.dbo.TEST_K7K8_view_EDW_ScreeningsFromTrackers order by UserID;

--update HFit_EDW_K7K8_TestDDL set Passed = 1 where VIEW_NAME = 'view_EDW_ScreeningsFromTrackers'; 