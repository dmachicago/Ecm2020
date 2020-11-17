use KenticoCMS_PRD_prod3K7
GO 
if exists (select name from sys.tables where name = 'TEST_K7K8_view_EDW_RewardTriggerParameters' )
BEGIN
    DROP Table KenticoCMS_PRD_prod3K7.dbo.TEST_K7K8_view_EDW_RewardTriggerParameters
END
GO


--****************************************************
Select DISTINCT top 150 
     SiteGUID
    ,RewardTriggerID
    ,TriggerName
    ,RewardTriggerParameterOperatorLKPDisplayName
    ,ParameterDisplayName
    ,RewardTriggerParameterOperator
    ,Value
    ,AccountID
    ,AccountCD
    ,ChangeType
    ,DocumentGuid
    ,NodeGuid
    ,DocumentCreatedWhen
    ,DocumentModifiedWhen
    ,RewardTriggerParameter_DocumentModifiedWhen
    ,documentculture_VHFRTPJ
    ,documentculture_VHFRTJ
INTO KenticoCMS_PRD_prod3K7.dbo.TEST_K7K8_view_EDW_RewardTriggerParameters
FROM
KenticoCMS_PRD_prod3K7.dbo.view_EDW_RewardTriggerParameters;
--****************************************************
use KenticoCMS_PRD_prod3K8
GO 
if exists (select name from sys.tables where name = 'TEST_K7K8_view_EDW_RewardTriggerParameters' )
BEGIN
    DROP Table KenticoCMS_PRD_prod3K8.dbo.TEST_K7K8_view_EDW_RewardTriggerParameters
END
GO


--****************************************************
Select DISTINCT top 150 
     SiteGUID
    ,RewardTriggerID
    ,TriggerName
    ,RewardTriggerParameterOperatorLKPDisplayName
    ,ParameterDisplayName
    ,RewardTriggerParameterOperator
    ,Value
    ,AccountID
    ,AccountCD
    ,ChangeType
    ,DocumentGuid
    ,NodeGuid
    ,DocumentCreatedWhen
    ,DocumentModifiedWhen
    ,RewardTriggerParameter_DocumentModifiedWhen
    ,documentculture_VHFRTPJ
    ,documentculture_VHFRTJ
INTO KenticoCMS_PRD_prod3K8.dbo.TEST_K7K8_view_EDW_RewardTriggerParameters
FROM
KenticoCMS_PRD_prod3K8.dbo.view_EDW_RewardTriggerParameters;
--****************************************************
GO

select top 100 * from KenticoCMS_PRD_prod3K7.dbo.TEST_K7K8_view_EDW_RewardTriggerParameters order by TriggerName;

select top 100 * from KenticoCMS_PRD_prod3K8.dbo.TEST_K7K8_view_EDW_RewardTriggerParameters order by TriggerName;

--update HFit_EDW_K7K8_TestDDL set Passed = 0 where VIEW_NAME = 'view_EDW_RewardTriggerParameters'; 