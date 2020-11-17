-------- VIEW BEING PROCESSED -------- 
-------- view_EDW_RewardUserDetail
----------------------------------------
/*
COLUMN NAME: RewardActivityGUID NOT FOUND IN BOTH VIEWS.
COLUMN NAME: RewardTriggerGUID NOT FOUND IN BOTH VIEWS.
*/

use KenticoCMS_PRD_prod3K7
GO 
if exists (select name from sys.tables where name = 'TEST_K7K8_view_EDW_RewardUserDetail' )
BEGIN
    DROP Table TEST_K7K8_view_EDW_RewardUserDetail
END
GO


--****************************************************
Select DISTINCT top 1000 
     UserGUID
    ,SiteGUID
    ,HFitUserMpiNumber
--    ,RewardActivityGUID                  --MISSING from one view
    ,RewardProgramName
    ,RewardModifiedDate
    ,RewardLevelModifiedDate
    ,LevelCompletedDt
    ,ActivityPointsEarned
    ,ActivityCompletedDt
    ,RewardActivityModifiedDate
    ,ActivityPoints
    ,UserAccepted
    ,UserExceptionAppliedTo
--    ,RewardTriggerGUID                  --MISSING from one view
    ,AccountID
    ,AccountCD
    ,ChangeType
    ,RewardExceptionModifiedDate
INTO KenticoCMS_PRD_prod3K7.dbo.TEST_K7K8_view_EDW_RewardUserDetail
FROM
KenticoCMS_PRD_prod3K7.dbo.view_EDW_RewardUserDetail;
--****************************************************
use KenticoCMS_PRD_prod3K8
GO 

if exists (select name from sys.tables where name = 'TEST_K7K8_view_EDW_RewardUserDetail' )
BEGIN
    DROP Table TEST_K7K8_view_EDW_RewardUserDetail
END
GO


--****************************************************
Select DISTINCT top 1000 
     UserGUID
    ,SiteGUID
    ,HFitUserMpiNumber
--    ,RewardActivityGUID                  --MISSING from one view
    ,RewardProgramName
    ,RewardModifiedDate
    ,RewardLevelModifiedDate
    ,LevelCompletedDt
    ,ActivityPointsEarned
    ,ActivityCompletedDt
    ,RewardActivityModifiedDate
    ,ActivityPoints
    ,UserAccepted
    ,UserExceptionAppliedTo
--    ,RewardTriggerGUID                  --MISSING from one view
    ,AccountID
    ,AccountCD
    ,ChangeType
    ,RewardExceptionModifiedDate
INTO KenticoCMS_PRD_prod3K8.dbo.TEST_K7K8_view_EDW_RewardUserDetail
FROM
KenticoCMS_PRD_prod3K8.dbo.view_EDW_RewardUserDetail;
--****************************************************
GO

select top 100 * from KenticoCMS_PRD_prod3K7.dbo.TEST_K7K8_view_EDW_RewardUserDetail order by UserGUID, LevelCompletedDt;

select top 100 * from KenticoCMS_PRD_prod3K8.dbo.TEST_K7K8_view_EDW_RewardUserDetail order by UserGUID, LevelCompletedDt;

--update HFit_EDW_K7K8_TestDDL set Passed = 1 where VIEW_NAME = 'view_EDW_RewardUserDetail'; 
select * from HFit_EDW_K7K8_TestDDL order by [RowNbr] desc ; 
