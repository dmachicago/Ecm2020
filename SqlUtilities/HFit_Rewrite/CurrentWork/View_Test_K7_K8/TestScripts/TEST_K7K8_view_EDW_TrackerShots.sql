use KenticoCMS_PRD_prod3K7
GO 
if exists (select name from sys.tables where name = 'TEST_K7K8_view_EDW_TrackerShots' )
BEGIN
    DROP Table TEST_K7K8_view_EDW_TrackerShots
END
GO


--****************************************************
Select DISTINCT top 1000 
     UserID
    ,UserSettingsUserGUID
    ,HFitUserMpiNumber
    ,SiteID
    ,SiteGUID
    ,ItemID
    ,EventDate
    ,IsProfessionallyCollected
    ,TrackerCollectionSourceID
    ,Notes
    ,FluShot
    ,PneumoniaShot
    ,ItemCreatedWhen
    ,ItemModifiedWhen
    ,ItemGUID
INTO KenticoCMS_PRD_prod3K7.dbo.TEST_K7K8_view_EDW_TrackerShots
FROM
KenticoCMS_PRD_prod3K7.dbo.view_EDW_TrackerShots;
--****************************************************
use KenticoCMS_PRD_prod3K8
GO 
if exists (select name from sys.tables where name = 'TEST_K7K8_view_EDW_TrackerShots' )
BEGIN
    DROP Table TEST_K7K8_view_EDW_TrackerShots
END
GO


--****************************************************
Select DISTINCT top 1000 
     UserID
    ,UserSettingsUserGUID
    ,HFitUserMpiNumber
    ,SiteID
    ,SiteGUID
    ,ItemID
    ,EventDate
    ,IsProfessionallyCollected
    ,TrackerCollectionSourceID
    ,Notes
    ,FluShot
    ,PneumoniaShot
    ,ItemCreatedWhen
    ,ItemModifiedWhen
    ,ItemGUID
INTO KenticoCMS_PRD_prod3K8.dbo.TEST_K7K8_view_EDW_TrackerShots
FROM
KenticoCMS_PRD_prod3K8.dbo.view_EDW_TrackerShots;
--****************************************************
GO

select top 100 * from KenticoCMS_PRD_prod3K7.dbo.TEST_K7K8_view_EDW_TrackerShots order by HFitUserMpiNumber, itemid;

select top 100 * from KenticoCMS_PRD_prod3K8.dbo.TEST_K7K8_view_EDW_TrackerShots order by HFitUserMpiNumber, itemid;

--update HFit_EDW_K7K8_TestDDL set Passed = 1 where VIEW_NAME = 'view_EDW_TrackerShots'; 