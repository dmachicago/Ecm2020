SELECT U.[UserGUID]
       ,U.[AccountCD]
      ,[HFitUserMpiNumber]
      ,[RewardLevelID]
      ,[AwardDisplayName]
      ,[RewardValue]
      FROM [dbo].[view_EDW_RewardAwardDetail] U
  WHERE not Exists (
  SELECT  D.* FROM [dbo].[view_EDW_RewardsDefinition] D
  WHERE D.[AccountCD] = U.AccountCD
  AND D.[RewardLevelID] = U.RewardLevelID )
 --DocumentCulture = 'en-US'

SELECT *
      FROM [dbo].[view_EDW_RewardAwardDetail] U
WHERE not Exists (
  SELECT  D.* FROM [dbo].[view_EDW_RewardsDefinition] D
  WHERE D.[AccountCD] = U.AccountCD
  AND D.[RewardLevelID] = U.RewardLevelID )

select distinct A.RewardLevelID 
from view_EDW_RewardsDefinition A
where A.RewardLevelID  not in (select RewardLevelID from view_EDW_RewardAwardDetail)

--Look for orphans
select distinct A.RewardLevelID 
from view_EDW_RewardAwardDetail A
where A.RewardLevelID  not in (select RewardLevelID from view_EDW_RewardsDefinition)


