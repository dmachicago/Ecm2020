Set statistics IO ON
declare @S as time = CURRENT_TIMESTAMP ;
select CURRENT_TIMESTAMP ;
SELECT distinct
	[UserGUID]
      ,[SiteGUID]
      ,[HFitUserMpiNumber]
      ,[RewardActivityID]
      ,[RewardProgramName]
      ,[RewardProgramID]
      ,[RewardProgramPeriodStart]
      ,[RewardProgramPeriodEnd]
      ,[RewardModifiedDate]
      ,[GroupName]
      ,[RewardGroupID]
      ,[RewardGroupPeriodStart]
      ,[RewardGroupPeriodEnd]
      ,[RewardGroupModifieDate]
      ,[Level]
      ,[RewardLevelTypeLKPName]
      ,[RewardLevelModifiedDate]
      ,[LevelCompletedDt]
      ,[LevelVersionHistoryID]
      ,[RewardLevelPeriodStart]
      ,[RewardLevelPeriodEnd]
      ,[ActivityName]
      ,[ActivityPointsEarned]
	  ,[ActivityVersionID]      	  
	  ,[RewardActivityPeriodStart]
      ,[RewardActivityPeriodEnd]
      ,[ActivityPoints]
      ,[UserAccepted]
      ,[UserExceptionAppliedTo]
      ,[TriggerName]
      ,[RewardTriggerID]
      ,[RewardTriggerLKPDisplayName]
      ,[RewardTriggerDynamicValue]
      ,[RewardTriggerModifiedDate]
      ,[RewardTypeLKPName]
      ,[AccountID]
      ,[AccountCD]
      ,[ChangeType]
      ,[DocumentGuid]
      ,[NodeGuid]
      ,[ItemCreatedWhen]
      ,[ItemModifiedWhen]
	  --When the below columns are removed from the query, 4 rows are returned.
	  --,[RewardExceptionModifiedDate]      
	  --,[ActivityCompletedDt]	--
	  --,[RewardActivityModifiedDate]	--
	  --,[RewardsUserActivity_ItemModifiedWhen] --
      --,[RewardTrigger_DocumentModifiedWhen]
  FROM [dbo].[view_EDW_RewardUserDetail]
  WHERE AccountCD = 'jnj'
  AND HFitUserMpiNumber = 9195215

  select CURRENT_TIMESTAMP ;

  --ActivityCompletedDt
  --RewardActivityModifiedDate
  --RewardsUserActivity_ItemModifiedWhen

  --With all in place 109564
  --With ActivityCompletedDt commented out and a distinct	- 109491	
  --With RewardActivityModifiedDate commented out and a distinct	- 109506	NOTE: Same value as [RewardTrigger_DocumentModifiedWhen]
  --With RewardsUserActivity_ItemModifiedWhen commented out and a distinct	- 109506	
  --With RewardsUserActivity_ItemModifiedWhen & RewardActivityModifiedDate commented out and a distinct	- 80904	
  --With RewardsUserActivity_ItemModifiedWhen & ActivityCompletedDt commented out and a distinct	- 109491	
  --With RewardActivityModifiedDate & ActivityCompletedDt commented out and a distinct		- 109491

  --With ALL 3 commented out and a distinct	- 4
  --ActivityName (2 diff)
  --TriggerName  (4 diff)
  --RewardTriggerLKPDisplayName (4 diff)
  --RewardTriggerModifiedDate   (4 diff)
  --RewardTrigger_DocumentModifiedWhen   (4 diff)

declare @e as time = CURRENT_TIMESTAMP ;
declare @t as int = DATEDIFF(ms,@s,@e) ;
print ('Qry EXecution Time: ' + cast(@t as nvarchar(20)) + 'ms') ;
Set statistics IO OFF
