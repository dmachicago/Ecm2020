use KenticoCMS_PRD_prod3K7
GO 
if exists (select name from sys.tables where name = 'TEST_K7K8_view_EDW_TrackerTests' )
BEGIN
    DROP Table TEST_K7K8_view_EDW_TrackerTests
END
GO


--****************************************************
Select DISTINCT top 150 
     UserID
    ,UserSettingsUserGUID
    ,HFitUserMpiNumber
    ,SiteID
    ,SiteGUID
    ,EventDate
    ,IsProfessionallyCollected
    ,TrackerCollectionSourceID
    ,Notes
    ,PSATest
    ,OtherExam
    ,TScore
    ,DRA
    ,CotinineTest
    ,ColoCareKit
    ,CustomTest
    ,CustomDesc
    ,TSH
    ,ItemCreatedWhen
    ,ItemModifiedWhen
    ,ItemGUID
INTO KenticoCMS_PRD_prod3K7.dbo.TEST_K7K8_view_EDW_TrackerTests
FROM
KenticoCMS_PRD_prod3K7.dbo.view_EDW_TrackerTests;
--****************************************************
use KenticoCMS_PRD_prod3K8
GO 
if exists (select name from sys.tables where name = 'TEST_K7K8_view_EDW_TrackerTests' )
BEGIN
    DROP Table TEST_K7K8_view_EDW_TrackerTests
END
GO


--****************************************************
Select DISTINCT top 150 
     UserID
    ,UserSettingsUserGUID
    ,HFitUserMpiNumber
    ,SiteID
    ,SiteGUID
    ,EventDate
    ,IsProfessionallyCollected
    ,TrackerCollectionSourceID
    ,Notes
    ,PSATest
    ,OtherExam
    ,TScore
    ,DRA
    ,CotinineTest
    ,ColoCareKit
    ,CustomTest
    ,CustomDesc
    ,TSH
    ,ItemCreatedWhen
    ,ItemModifiedWhen
    ,ItemGUID
INTO KenticoCMS_PRD_prod3K8.dbo.TEST_K7K8_view_EDW_TrackerTests
FROM
KenticoCMS_PRD_prod3K8.dbo.view_EDW_TrackerTests;
--****************************************************
GO

select top 100 * from KenticoCMS_PRD_prod3K7.dbo.TEST_K7K8_view_EDW_TrackerTests order by HFitUserMpiNumber;

select top 100 * from KenticoCMS_PRD_prod3K8.dbo.TEST_K7K8_view_EDW_TrackerTests order by HFitUserMpiNumber;

--update HFit_EDW_K7K8_TestDDL set Passed = 1 where VIEW_NAME = 'view_EDW_TrackerTests'; 