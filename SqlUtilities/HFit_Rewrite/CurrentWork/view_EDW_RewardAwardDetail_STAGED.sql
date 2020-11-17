
go
print 'Creating view_EDW_RewardAwardDetail_STAGED';
go
if exists (select name from sys.views where name = 'view_EDW_RewardAwardDetail_STAGED')
begin
    drop view view_EDW_RewardAwardDetail_STAGED;
end
go
create view view_EDW_RewardAwardDetail_STAGED
as 
SELECT [UserGUID]
      ,[SiteGUID]
      ,[HFitUserMpiNumber]
      ,[RewardLevelGUID]
      ,[AwardType]
      ,[AwardDisplayName]
      ,[RewardValue]
      ,[ThresholdNumber]
      ,[UserNotified]
      ,[IsFulfilled]
      ,[AccountID]
      ,[AccountCD]
      ,[ChangeType]
      ,[HashCode]
      ,[LastModifiedDate]
      ,[RowNbr]
      ,[DeletedFlg]
  FROM [STAGING_EDW_RewardAwardDetail]
GO
print 'Created view_EDW_RewardAwardDetail_STAGED';
go


