
go
print 'Creating view_EDW_RewardsDefinition_STAGE' ;
go
if exists (select name from sys.views where name = 'view_EDW_RewardsDefinition_STAGE')
    drop view view_EDW_RewardsDefinition_STAGE;
go
create view view_EDW_RewardsDefinition_STAGE
as
SELECT [SiteGUID]
      ,[AccountID]
      ,[AccountCD]
      ,[RewardProgramGUID]
      ,[RewardProgramName]
      ,[RewardProgramPeriodStart]
      ,[RewardProgramPeriodEnd]
      ,[RewardGroupGuid]
      ,[GroupName]
      ,[RewardLevelGuid]
      ,[Level]
      ,[RewardLevelTypeLKPName]
      ,[AwardDisplayName]
      ,[AwardType]
      ,[AwardThreshold1]
      ,[AwardThreshold2]
      ,[AwardThreshold3]
      ,[AwardThreshold4]
      ,[AwardValue1]
      ,[AwardValue2]
      ,[AwardValue3]
      ,[AwardValue4]
      ,[ExternalFulfillmentRequired]
      ,[RewardActivityGuid]
      ,[ActivityName]
      ,[ActivityFreqOrCrit]
      ,[ActivityPoints]
      ,[IsBundle]
      ,[IsRequired]
      ,[MaxThreshold]
      ,[AwardPointsIncrementally]
      ,[AllowMedicalExceptions]
      ,[RewardTriggerGuid]
      ,[RewardTriggerDynamicValue]
      ,[TriggerName]
      ,[RewardTriggerParameterOperator]
      ,[RewardTriggerParmGUID]
      ,[Value]
      ,[ChangeType]
      ,[DocumentCulture_VHFRAJ]
      ,[DocumentCulture_VHFRPJ]
      ,[DocumentCulture_VHFRGJ]
      ,[DocumentCulture_VHFRLJ]
      ,[DocumentCulture_VHFRTPJ]
      ,[LevelName]
      ,[HashCode]
      ,[LastModifiedDate]
      ,[RowNbr]
      ,[DeletedFlg]
  FROM [dbo].[STAGING_EDW_RewardsDefinition]
GO
print 'CREATED view_EDW_RewardsDefinition_STAGE' ;
go
