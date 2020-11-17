--COLUMN NAME: RewardLevelGUIDNOT FOUND IN BOTH VIEWS.
--COLUMN NAME: AwardTypeNOT FOUND IN BOTH VIEWS.

use KenticoCMS_PRD_prod3K7
GO 
if exists (select name from sys.tables where name = 'TEST_K7K8_view_EDW_RewardAwardDetail' )
BEGIN
    DROP Table TEST_K7K8_view_EDW_RewardAwardDetail
END
GO


--****************************************************
Select DISTINCT top 1000 
     UserGUID
    ,SiteGUID
    ,HFitUserMpiNumber
--    ,RewardLevelGUID                  --MISSING from one view
--    ,AwardType                  --MISSING from one view
    ,AwardDisplayName
    ,RewardValue
    ,ThresholdNumber
    ,UserNotified
    ,IsFulfilled
    ,AccountID
    ,AccountCD
    ,ChangeType
INTO KenticoCMS_PRD_prod3K7.dbo.TEST_K7K8_view_EDW_RewardAwardDetail
FROM
KenticoCMS_PRD_prod3K7.dbo.view_EDW_RewardAwardDetail;
--****************************************************
use KenticoCMS_PRD_prod3K8
GO 
if exists (select name from sys.tables where name = 'TEST_K7K8_view_EDW_RewardAwardDetail' )
BEGIN
    DROP Table TEST_K7K8_view_EDW_RewardAwardDetail
END
GO


--****************************************************
Select DISTINCT top 1000 
     UserGUID
    ,SiteGUID
    ,HFitUserMpiNumber
--    ,RewardLevelGUID                  --MISSING from one view
--    ,AwardType                  --MISSING from one view
    ,AwardDisplayName
    ,RewardValue
    ,ThresholdNumber
    ,UserNotified
    ,IsFulfilled
    ,AccountID
    ,AccountCD
    ,ChangeType
INTO KenticoCMS_PRD_prod3K8.dbo.TEST_K7K8_view_EDW_RewardAwardDetail
FROM
KenticoCMS_PRD_prod3K8.dbo.view_EDW_RewardAwardDetail;
--****************************************************
GO

select top 100 * from KenticoCMS_PRD_prod3K7.dbo.TEST_K7K8_view_EDW_RewardAwardDetail;

select top 100 * from KenticoCMS_PRD_prod3K8.dbo.TEST_K7K8_view_EDW_RewardAwardDetail;

--update HFit_EDW_K7K8_TestDDL set Passed = 1 where VIEW_NAME = 'view_EDW_RewardAwardDetail'; 
select * from HFit_EDW_K7K8_TestDDL order by [RowNbr] desc ; 
