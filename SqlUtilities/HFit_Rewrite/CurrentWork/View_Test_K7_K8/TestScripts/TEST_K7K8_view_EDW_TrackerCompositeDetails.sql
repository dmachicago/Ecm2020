use KenticoCMS_PRD_prod3K7
GO 
if exists (select name from sys.tables where name = 'TEST_K7K8_view_EDW_TrackerCompositeDetails' )
BEGIN
    DROP Table TEST_K7K8_view_EDW_TrackerCompositeDetails
END
GO


--****************************************************
Select DISTINCT top 100 
     TrackerNameAggregateTable
    ,ItemID
    ,EventDate
    ,IsProfessionallyCollected
    ,TrackerCollectionSourceID
    ,Notes
    ,UserID
    ,CollectionSourceName_Internal
    ,CollectionSourceName_External
    ,EventName
    ,UOM
    ,KEY1
    ,VAL1
    ,KEY2
    ,VAL2
    ,KEY3
    ,VAL3
    ,KEY4
    ,VAL4
    ,KEY5
    ,VAL5
    ,KEY6
    ,VAL6
    ,KEY7
    ,VAL7
    ,KEY8
    ,VAL8
    ,KEY9
    ,VAL9
    ,KEY10
    ,VAL10
    ,ItemCreatedBy
    ,ItemCreatedWhen
    ,ItemModifiedBy
    ,ItemModifiedWhen
    ,IsProcessedForHa
    ,TXTKEY1
    ,TXTVAL1
    ,TXTKEY2
    ,TXTVAL2
    ,TXTKEY3
    ,TXTVAL3
    ,ItemOrder
    ,ItemGuid
    ,UserGuid
    ,MPI
    ,ClientCode
    ,SiteGUID
    ,AccountID
    ,AccountCD
    ,IsAvailable
    ,IsCustom
    ,UniqueName
    ,ColDesc
    ,VendorID
    ,VendorName
INTO KenticoCMS_PRD_prod3K7.dbo.TEST_K7K8_view_EDW_TrackerCompositeDetails
FROM
view_EDW_TrackerCompositeDetails;
--****************************************************
use KenticoCMS_PRD_prod3K8
GO 
if exists (select name from sys.tables where name = 'TEST_K7K8_view_EDW_TrackerCompositeDetails' )
BEGIN
    DROP Table TEST_K7K8_view_EDW_TrackerCompositeDetails
END
GO


--****************************************************
Select DISTINCT top 100 
     TrackerNameAggregateTable
    ,ItemID
    ,EventDate
    ,IsProfessionallyCollected
    ,TrackerCollectionSourceID
    ,Notes
    ,UserID
    ,CollectionSourceName_Internal
    ,CollectionSourceName_External
    ,EventName
    ,UOM
    ,KEY1
    ,VAL1
    ,KEY2
    ,VAL2
    ,KEY3
    ,VAL3
    ,KEY4
    ,VAL4
    ,KEY5
    ,VAL5
    ,KEY6
    ,VAL6
    ,KEY7
    ,VAL7
    ,KEY8
    ,VAL8
    ,KEY9
    ,VAL9
    ,KEY10
    ,VAL10
    ,ItemCreatedBy
    ,ItemCreatedWhen
    ,ItemModifiedBy
    ,ItemModifiedWhen
    ,IsProcessedForHa
    ,TXTKEY1
    ,TXTVAL1
    ,TXTKEY2
    ,TXTVAL2
    ,TXTKEY3
    ,TXTVAL3
    ,ItemOrder
    ,ItemGuid
    ,UserGuid
    ,MPI
    ,ClientCode
    ,SiteGUID
    ,AccountID
    ,AccountCD
    ,IsAvailable
    ,IsCustom
    ,UniqueName
    ,ColDesc
    ,VendorID
    ,VendorName
INTO KenticoCMS_PRD_prod3K8.dbo.TEST_K7K8_view_EDW_TrackerCompositeDetails
FROM
view_EDW_TrackerCompositeDetails 
where itemId in (Select ItemID from KenticoCMS_PRD_prod3K7.dbo.TEST_K7K8_view_EDW_TrackerCompositeDetails);
--****************************************************
GO

select top 100 * from KenticoCMS_PRD_prod3K7.dbo.TEST_K7K8_view_EDW_TrackerCompositeDetails order by ItemModifiedWhen, ItemID;

select top 100 * from KenticoCMS_PRD_prod3K8.dbo.TEST_K7K8_view_EDW_TrackerCompositeDetails order by ItemModifiedWhen, ItemID;

--update HFit_EDW_K7K8_TestDDL set Passed = 1 where VIEW_NAME = 'view_EDW_TrackerCompositeDetails'; 