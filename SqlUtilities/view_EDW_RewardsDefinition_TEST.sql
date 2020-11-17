--Duplicates exist when this query is executed
--view_EDW_RewardsDefinition -- has dups
--View_Hfit_GoalTracker  -- has dups


--view_EDW_RewardsDefinition
  Select  SiteGUID, AccountID, AccountCD, RewardProgramID, RewardProgramName, RewardProgramPeriodStart, RewardProgramPeriodEnd, ProgramDescription, RewardGroupID, GroupName, RewardContactGroups, RewardGroupPeriodStart, RewardGroupPeriodEnd, RewardLevelID, Level, RewardLevelTypeLKPName, RewardLevelPeriodStart, RewardLevelPeriodEnd, FrequencyMenu, AwardDisplayName, AwardType, AwardThreshold1, AwardThreshold2, AwardThreshold3, AwardThreshold4, AwardValue1, AwardValue2, AwardValue3, AwardValue4, CompletionText, ExternalFulfillmentRequired, RewardHistoryDetailDescription, RewardActivityID, ActivityName, ActivityFreqOrCrit, RewardActivityPeriodStart, RewardActivityPeriodEnd, RewardActivityLKPID, ActivityPoints, IsBundle, IsRequired, MaxThreshold, AwardPointsIncrementally, AllowMedicalExceptions, BundleText, RewardTriggerID, RewardTriggerDynamicValue, TriggerName, RequirementDescription, RewardTriggerParameterOperator, Value, ParameterDisplayName, ChangeType, DocumentCreatedWhen, count(0) 
  from view_EDW_RewardsDefinition
  group by SiteGUID, AccountID, AccountCD, RewardProgramID, RewardProgramName, RewardProgramPeriodStart, RewardProgramPeriodEnd, ProgramDescription, RewardGroupID, GroupName, RewardContactGroups, RewardGroupPeriodStart, RewardGroupPeriodEnd, RewardLevelID, Level, RewardLevelTypeLKPName, RewardLevelPeriodStart, RewardLevelPeriodEnd, FrequencyMenu, AwardDisplayName, AwardType, AwardThreshold1, AwardThreshold2, AwardThreshold3, AwardThreshold4, AwardValue1, AwardValue2, AwardValue3, AwardValue4, CompletionText, ExternalFulfillmentRequired, RewardHistoryDetailDescription, RewardActivityID, ActivityName, ActivityFreqOrCrit, RewardActivityPeriodStart, RewardActivityPeriodEnd, RewardActivityLKPID, ActivityPoints, IsBundle, IsRequired, MaxThreshold, AwardPointsIncrementally, AllowMedicalExceptions, BundleText, RewardTriggerID, RewardTriggerDynamicValue, TriggerName, RequirementDescription, RewardTriggerParameterOperator, Value, ParameterDisplayName, ChangeType, DocumentCreatedWhen
  having count(0)>1


Select distinct *
  from view_EDW_RewardsDefinition
  where siteguid in ('4E9F445E-A8F5-4CD2-AAD9-3494535EA818','EC3181A6-64F7-45D5-A5E0-3FE046549C51')
  AND AccountID in (14,5)
  and AccountCD in ('Sandbox','JnJ')
  and RewardProgramID in (336,313)
  and TriggerName = 'Blood Pressure'
  group by SiteGUID, AccountID, AccountCD, RewardProgramID, RewardProgramName, RewardProgramPeriodStart, RewardProgramPeriodEnd, ProgramDescription, RewardGroupID, GroupName, RewardContactGroups, RewardGroupPeriodStart, RewardGroupPeriodEnd, RewardLevelID, Level, RewardLevelTypeLKPName, RewardLevelPeriodStart, RewardLevelPeriodEnd, FrequencyMenu, AwardDisplayName, AwardType, AwardThreshold1, AwardThreshold2, AwardThreshold3, AwardThreshold4, AwardValue1, AwardValue2, AwardValue3, AwardValue4, CompletionText, ExternalFulfillmentRequired, RewardHistoryDetailDescription, RewardActivityID, ActivityName, ActivityFreqOrCrit, RewardActivityPeriodStart, RewardActivityPeriodEnd, RewardActivityLKPID, ActivityPoints, IsBundle, IsRequired, MaxThreshold, AwardPointsIncrementally, AllowMedicalExceptions, BundleText, RewardTriggerID, RewardTriggerDynamicValue, TriggerName, RequirementDescription, RewardTriggerParameterOperator, Value, ParameterDisplayName, ChangeType, DocumentCreatedWhen

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
