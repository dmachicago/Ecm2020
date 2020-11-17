

go
print 'Creating view_EDW_RewardUserDetail_STAGED.sql'

go
if exists (select name from sys.views where name = 'view_EDW_RewardUserDetail_STAGED')
    drop view view_EDW_RewardUserDetail_STAGED;
go

create view view_EDW_RewardUserDetail_STAGED
as
SELECT [UserGUID]
      ,[SiteGUID]
      ,[HFitUserMpiNumber]
      ,[RewardActivityGUID]
      ,[RewardProgramName]
      ,[RewardModifiedDate]
      ,[RewardLevelModifiedDate]
      ,[LevelCompletedDt]
      ,[ActivityPointsEarned]
      ,[ActivityCompletedDt]
      ,[RewardActivityModifiedDate]
      ,[ActivityPoints]
      ,[UserAccepted]
      ,[UserExceptionAppliedTo]
      ,[RewardTriggerGUID]
      ,[AccountID]
      ,[AccountCD]
      ,[ChangeType]
      ,[RewardExceptionModifiedDate]
  FROM [dbo].STAGING_EDW_RewardUserDetail
GO
print 'Created view_EDW_RewardUserDetail_STAGED.sql'
go