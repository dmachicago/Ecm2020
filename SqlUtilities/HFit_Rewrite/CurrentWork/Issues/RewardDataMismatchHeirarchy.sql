--HFit_RewardsAwardUserDetail
select distinct A.RewardLevelID 
from view_EDW_RewardAwardDetail A
where A.RewardLevelID  not in (select RewardLevelID from view_EDW_RewardsDefinition)

--HFit_RewardsUserLevelDetail	--LevelNodeID
--HFit_RewardsUserActivityDetail
--HFit_RewardsUserTrigger
--HFit_RewardsUserRepeatableTriggerDetail

--HFit_RewardsUserSummary

--HFit_RewardsAwardUserDetail
--HFit_RewardsUserLevelDetail	--LevelNodeID
--HFit_RewardsUserActivityDetail
--HFit_RewardsUserTrigger
--HFit_RewardsUserRepeatableTriggerDetail
--HFit_RewardsUserSummary

