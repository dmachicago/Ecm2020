

use KenticoCMS_PRD_prod3K7
GO 
if exists (select name from sys.tables where name = 'TEST_K7K8_view_EDW_BioMetrics' )
BEGIN
    DROP Table TEST_K7K8_view_EDW_BioMetrics
END
GO


--****************************************************
Select distinct top 100
     UserID
    ,UserGUID
    ,HFitUserMpiNumber
    ,SiteID
    ,SiteGUID
    ,CreatedDate
    ,ModifiedDate
    ,Notes
    ,IsProfessionallyCollected
    ,EventDate
    ,EventName
    ,PPTWeight
    ,PPTHbA1C
    ,Fasting
    ,HDL
    ,LDL
    ,Ratio
    ,Total
    ,Triglycerides
    ,Glucose
    ,FastingState
    ,Systolic
    ,Diastolic
    ,PPTBodyFatPCT
    ,BMI
    ,WaistInches
    ,HipInches
    ,ThighInches
    ,ArmInches
    ,ChestInches
    ,CalfInches
    ,NeckInches
    ,Height
    ,HeartRate
    ,FluShot
    ,PneumoniaShot
    ,PSATest
    ,OtherExam
    ,TScore
    ,DRA
    ,CotinineTest
    ,ColoCareKit
    ,CustomTest
    ,CustomDesc
    ,CollectionSource
    ,AccountID
    ,AccountCD
    ,ChangeType
    ,ItemCreatedWhen
    ,ItemModifiedWhen
    ,TrackerCollectionSourceID
    ,itemid
    ,TBL
    ,VendorID
    ,VendorName
INTO KenticoCMS_PRD_prod3K7.dbo.TEST_K7K8_view_EDW_BioMetrics
FROM
view_EDW_BioMetrics where HFitUserMpiNumber > 0 ;;
--****************************************************
use KenticoCMS_PRD_prod3K8
GO 
if exists (select name from sys.tables where name = 'TEST_K7K8_view_EDW_BioMetrics' )
BEGIN
    DROP Table TEST_K7K8_view_EDW_BioMetrics
END
GO


--****************************************************
Select distinct top 100
     UserID
    ,UserGUID
    ,HFitUserMpiNumber
    ,SiteID
    ,SiteGUID
    ,CreatedDate
    ,ModifiedDate
    ,Notes
    ,IsProfessionallyCollected
    ,EventDate
    ,EventName
    ,PPTWeight
    ,PPTHbA1C
    ,Fasting
    ,HDL
    ,LDL
    ,Ratio
    ,Total
    ,Triglycerides
    ,Glucose
    ,FastingState
    ,Systolic
    ,Diastolic
    ,PPTBodyFatPCT
    ,BMI
    ,WaistInches
    ,HipInches
    ,ThighInches
    ,ArmInches
    ,ChestInches
    ,CalfInches
    ,NeckInches
    ,Height
    ,HeartRate
    ,FluShot
    ,PneumoniaShot
    ,PSATest
    ,OtherExam
    ,TScore
    ,DRA
    ,CotinineTest
    ,ColoCareKit
    ,CustomTest
    ,CustomDesc
    ,CollectionSource
    ,AccountID
    ,AccountCD
    ,ChangeType
    ,ItemCreatedWhen
    ,ItemModifiedWhen
    ,TrackerCollectionSourceID
    ,itemid
    ,TBL
    ,VendorID
    ,VendorName
INTO KenticoCMS_PRD_prod3K8.dbo.TEST_K7K8_view_EDW_BioMetrics
FROM
view_EDW_BioMetrics where HFitUserMpiNumber > 0 ;
--****************************************************

select top 50 * from KenticoCMS_PRD_prod3K7.dbo.TEST_K7K8_view_EDW_BioMetrics where HFitUserMpiNumber is not null order by HFitUserMpiNumber, SiteID, ItemModifiedWHen 
select top 50 * from KenticoCMS_PRD_prod3K8.dbo.TEST_K7K8_view_EDW_BioMetrics where HFitUserMpiNumber is not null order by HFitUserMpiNumber, SiteID, ItemModifiedWHen