use KenticoCMS_PRD_prod3K7
GO 
if exists (select name from sys.tables where name = 'TEST_K7K8_view_EDW_TrackerMetadata' )
BEGIN
    DROP Table TEST_K7K8_view_EDW_TrackerMetadata
END
GO


--****************************************************
Select DISTINCT top 1000 
     TableName
    ,ColName
    ,AttrName
    ,AttrVal
    ,CreatedDate
    ,LastModifiedDate
    ,ID
    ,ClassLastModified
INTO KenticoCMS_PRD_prod3K7.dbo.TEST_K7K8_view_EDW_TrackerMetadata
FROM
view_EDW_TrackerMetadata;
--****************************************************
use KenticoCMS_PRD_prod3K8
GO 
if exists (select name from sys.tables where name = 'TEST_K7K8_view_EDW_TrackerMetadata' )
BEGIN
    DROP Table TEST_K7K8_view_EDW_TrackerMetadata
END
GO


--****************************************************
Select DISTINCT top 1000 
     TableName
    ,ColName
    ,AttrName
    ,AttrVal
    ,CreatedDate
    ,LastModifiedDate
    ,ID
    ,ClassLastModified
INTO KenticoCMS_PRD_prod3K8.dbo.TEST_K7K8_view_EDW_TrackerMetadata
FROM
view_EDW_TrackerMetadata;
--****************************************************
GO

select top 100 * from KenticoCMS_PRD_prod3K7.dbo.TEST_K7K8_view_EDW_TrackerMetadata order by ID, LastModifiedDate, AttrVal;

select top 100 * from KenticoCMS_PRD_prod3K8.dbo.TEST_K7K8_view_EDW_TrackerMetadata  order by ID, LastModifiedDate, AttrVal;

--update HFit_EDW_K7K8_TestDDL set Passed = 1 where VIEW_NAME = 'view_EDW_TrackerMetadata'; 