use KenticoCMS_PRD_prod3K7
GO 
if exists (select name from sys.tables where name = 'TEST_K7K8_view_EDW_Awards' )
BEGIN
    DROP Table TEST_K7K8_view_EDW_Awards
END
GO


--****************************************************
Select DISTINCT top 150 
     ItemID
    ,ItemCreatedBy
    ,ItemCreatedWhen
    ,ItemModifiedBy
    ,ItemModifiedWhen
    ,ItemOrder
    ,ItemGUID
    ,UserID
    ,EventDate
    ,RewardTriggerID
    ,Value
    ,Challenge_GUID
    ,HESAwardID
    ,AwardType
    ,RewardTriggerLKPName
    ,RewardTriggerRewardActivityLKPID
    ,RewardTriggerLKPDisplayName
    ,HESCode
INTO KenticoCMS_PRD_prod3K7.dbo.TEST_K7K8_view_EDW_Awards
FROM
KenticoCMS_PRD_prod3K7.dbo.view_EDW_Awards;
--****************************************************
use KenticoCMS_PRD_prod3K8
GO 
if exists (select name from sys.tables where name = 'TEST_K7K8_view_EDW_Awards' )
BEGIN
    DROP Table TEST_K7K8_view_EDW_Awards
END
GO


--****************************************************
Select DISTINCT top 150 
     ItemID
    ,ItemCreatedBy
    ,ItemCreatedWhen
    ,ItemModifiedBy
    ,ItemModifiedWhen
    ,ItemOrder
    ,ItemGUID
    ,UserID
    ,EventDate
    ,RewardTriggerID
    ,Value
    ,Challenge_GUID
    ,HESAwardID
    ,AwardType
    ,RewardTriggerLKPName
    ,RewardTriggerRewardActivityLKPID
    ,RewardTriggerLKPDisplayName
    ,HESCode
INTO KenticoCMS_PRD_prod3K8.dbo.TEST_K7K8_view_EDW_Awards
FROM
KenticoCMS_PRD_prod3K8.dbo.view_EDW_Awards;
--****************************************************
GO

select top 100 * from KenticoCMS_PRD_prod3K7.dbo.TEST_K7K8_view_EDW_Awards;

select top 100 * from KenticoCMS_PRD_prod3K8.dbo.TEST_K7K8_view_EDW_Awards;

--update HFit_EDW_K7K8_TestDDL set Passed = 1 where VIEW_NAME = 'view_EDW_Awards'; 