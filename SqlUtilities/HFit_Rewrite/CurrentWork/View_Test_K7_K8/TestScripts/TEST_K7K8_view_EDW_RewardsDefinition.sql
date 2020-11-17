-------- VIEW BEING PROCESSED -------- 
-------- view_EDW_RewardsDefinition
----------------------------------------
/*
COLUMN NAME: RewardProgramGUIDNOT FOUND IN BOTH VIEWS.
COLUMN NAME: RewardGroupGuidNOT FOUND IN BOTH VIEWS.
COLUMN NAME: RewardLevelGuidNOT FOUND IN BOTH VIEWS.
COLUMN NAME: RewardActivityGuidNOT FOUND IN BOTH VIEWS.
COLUMN NAME: RewardActivityNameNOT FOUND IN BOTH VIEWS.
COLUMN NAME: RewardTriggerGuidNOT FOUND IN BOTH VIEWS.
COLUMN NAME: RewardTriggerParameterGUIDNOT FOUND IN BOTH VIEWS.
*/

use KenticoCMS_PRD_prod3K7
GO 
if exists (select name from sys.tables where name = 'TEST_K7K8_view_EDW_RewardsDefinition' )
BEGIN
    DROP Table TEST_K7K8_view_EDW_RewardsDefinition
END
GO


--****************************************************
Select DISTINCT top 1000 
     SiteGUID
    ,AccountID
    ,AccountCD
--    ,RewardProgramGUID                  --MISSING from one view
    ,RewardProgramName
    ,RewardProgramPeriodStart
    ,RewardProgramPeriodEnd
--    ,RewardGroupGuid                  --MISSING from one view
    ,GroupName
--    ,RewardLevelGuid                  --MISSING from one view
    ,Level
    ,RewardLevelTypeLKPName
    ,AwardDisplayName
    ,AwardType
    ,AwardThreshold1
    ,AwardThreshold2
    ,AwardThreshold3
    ,AwardThreshold4
    ,AwardValue1
    ,AwardValue2
    ,AwardValue3
    ,AwardValue4
    ,ExternalFulfillmentRequired
--    ,RewardActivityGuid                  --MISSING from one view
--    ,RewardActivityName                  --MISSING from one view
    ,ActivityFreqOrCrit
    ,ActivityPoints
    ,IsBundle
    ,IsRequired
    ,MaxThreshold
    ,AwardPointsIncrementally
    ,AllowMedicalExceptions
--    ,RewardTriggerGuid                  --MISSING from one view
    ,RewardTriggerDynamicValue
    ,TriggerName
    ,RewardTriggerParameterOperator
--    ,RewardTriggerParameterGUID                  --MISSING from one view
    ,Value
    ,ChangeType
    ,DocumentCulture_VHFRAJ
    ,DocumentCulture_VHFRPJ
    ,DocumentCulture_VHFRGJ
    ,DocumentCulture_VHFRLJ
    ,DocumentCulture_VHFRTPJ
    ,LevelName
INTO KenticoCMS_PRD_prod3K7.dbo.TEST_K7K8_view_EDW_RewardsDefinition
FROM
KenticoCMS_PRD_prod3K7.dbo.view_EDW_RewardsDefinition;
--****************************************************
use KenticoCMS_PRD_prod3K8
GO 
if exists (select name from sys.tables where name = 'TEST_K7K8_view_EDW_RewardsDefinition' )
BEGIN
    DROP Table TEST_K7K8_view_EDW_RewardsDefinition
END
GO


--****************************************************
Select DISTINCT top 1000 
     SiteGUID
    ,AccountID
    ,AccountCD
--    ,RewardProgramGUID                  --MISSING from one view
    ,RewardProgramName
    ,RewardProgramPeriodStart
    ,RewardProgramPeriodEnd
--    ,RewardGroupGuid                  --MISSING from one view
    ,GroupName
--    ,RewardLevelGuid                  --MISSING from one view
    ,Level
    ,RewardLevelTypeLKPName
    ,AwardDisplayName
    ,AwardType
    ,AwardThreshold1
    ,AwardThreshold2
    ,AwardThreshold3
    ,AwardThreshold4
    ,AwardValue1
    ,AwardValue2
    ,AwardValue3
    ,AwardValue4
    ,ExternalFulfillmentRequired
--    ,RewardActivityGuid                  --MISSING from one view
--    ,RewardActivityName                  --MISSING from one view
    ,ActivityFreqOrCrit
    ,ActivityPoints
    ,IsBundle
    ,IsRequired
    ,MaxThreshold
    ,AwardPointsIncrementally
    ,AllowMedicalExceptions
--    ,RewardTriggerGuid                  --MISSING from one view
    ,RewardTriggerDynamicValue
    ,TriggerName
    ,RewardTriggerParameterOperator
--    ,RewardTriggerParameterGUID                  --MISSING from one view
    ,Value
    ,ChangeType
    ,DocumentCulture_VHFRAJ
    ,DocumentCulture_VHFRPJ
    ,DocumentCulture_VHFRGJ
    ,DocumentCulture_VHFRLJ
    ,DocumentCulture_VHFRTPJ
    ,LevelName
INTO KenticoCMS_PRD_prod3K8.dbo.TEST_K7K8_view_EDW_RewardsDefinition
FROM
KenticoCMS_PRD_prod3K8.dbo.view_EDW_RewardsDefinition;
--****************************************************
GO

select top 100 * from KenticoCMS_PRD_prod3K7.dbo.TEST_K7K8_view_EDW_RewardsDefinition;

select top 100 * from KenticoCMS_PRD_prod3K8.dbo.TEST_K7K8_view_EDW_RewardsDefinition;

--update HFit_EDW_K7K8_TestDDL set Passed = 1 where VIEW_NAME = 'view_EDW_RewardsDefinition'; 
select * from HFit_EDW_K7K8_TestDDL order by [RowNbr] desc ; 
