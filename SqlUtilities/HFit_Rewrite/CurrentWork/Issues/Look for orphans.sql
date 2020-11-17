--Look for orphans
--There are 9 level nodes created that the participants and 
--by whatever, these recreated nodes caused ORPHAN records.
select distinct A.RewardLevelID 
from view_EDW_RewardAwardDetail A
where A.RewardLevelID  not in (select RewardLevelID from view_EDW_RewardsDefinition)