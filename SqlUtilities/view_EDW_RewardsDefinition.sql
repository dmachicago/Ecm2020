
go
print('Creating [view_EDW_RewardsDefinition]') ;
go

if exists (select table_name from information_schema.tables where table_name = 'view_EDW_RewardsDefinition')
BEGIN
    print('Updating [view_EDW_RewardsDefinition]') ;
    drop view view_EDW_RewardsDefinition ;
END
go

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



create VIEW [dbo].[view_EDW_RewardsDefinition]
AS
--02.03.2015 : LevelName, LevelHeader, GroupHeadingText, GroupHeadingDescription
	SELECT DISTINCT
		cs.SiteGUID
		, HFA.AccountID
		, hfa.AccountCD
		, RewardProgramID
		, RewardProgramName
		, RewardProgramPeriodStart
		, RewardProgramPeriodEnd
		, ProgramDescription
		, RewardGroupID
		, GroupName
		, RewardContactGroups
		, RewardGroupPeriodStart
		, RewardGroupPeriodEnd
		, RewardLevelID
		, Level
		, RewardLevelTypeLKPName
		, RewardLevelPeriodStart
		, RewardLevelPeriodEnd
		, FrequencyMenu
		, AwardDisplayName
		, AwardType
		, AwardThreshold1
		, AwardThreshold2
		, AwardThreshold3
		, AwardThreshold4
		, AwardValue1
		, AwardValue2
		, AwardValue3
		, AwardValue4
		, CompletionText
		, ExternalFulfillmentRequired
		, RewardHistoryDetailDescription
		, VHFRAJ.RewardActivityID
		, VHFRAJ.ActivityName
		, VHFRAJ.ActivityFreqOrCrit
		, VHFRAJ.RewardActivityPeriodStart
		, VHFRAJ.RewardActivityPeriodEnd
		, VHFRAJ.RewardActivityLKPID
		, VHFRAJ.ActivityPoints
		, VHFRAJ.IsBundle
		, VHFRAJ.IsRequired
		, VHFRAJ.MaxThreshold
		, VHFRAJ.AwardPointsIncrementally
		, VHFRAJ.AllowMedicalExceptions
		, VHFRAJ.BundleText
		, RewardTriggerID
		, HFLRT.RewardTriggerDynamicValue
		, TriggerName
		, RequirementDescription
		, VHFRTPJ.RewardTriggerParameterOperator
		, VHFRTPJ.Value
		, vhfrtpj.ParameterDisplayName
		, CASE	WHEN CAST(VHFRPJ.DocumentCreatedWhen AS DATE) = CAST(VHFRPJ.DocumentModifiedWhen AS DATE)
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		, VHFRPJ.DocumentCreatedWhen
		, VHFRPJ.DocumentModifiedWhen

		    , [RL_Joined].[LevelName]
		    , [RL_Joined].[LevelHeader]
		    , [RL_Joined].[GroupHeadingText]
		    , [RL_Joined].[GroupHeadingDescription]

	FROM
		dbo.View_HFit_RewardProgram_Joined AS VHFRPJ
	INNER JOIN dbo.View_HFit_RewardGroup_Joined AS VHFRGJ ON VHFRPJ.NodeID = VHFRGJ.NodeParentID
	INNER JOIN dbo.View_HFit_RewardLevel_Joined AS RL_Joined ON VHFRGJ.NodeID = RL_Joined.NodeParentID
	INNER JOIN dbo.HFit_LKP_RewardLevelType AS HFLRLT ON RL_Joined.LevelType = HFLRLT.RewardLevelTypeLKPID
	INNER JOIN dbo.View_HFit_RewardActivity_Joined AS VHFRAJ ON RL_Joined.NodeID = VHFRAJ.NodeParentID
	INNER JOIN dbo.View_HFit_RewardTrigger_Joined AS VHFRTJ ON VHFRAJ.NodeID = VHFRTJ.NodeParentID
	INNER JOIN dbo.View_HFit_RewardTriggerParameter_Joined AS VHFRTPJ ON vhfrtj.nodeid = vhfrtpj.nodeparentid
	INNER JOIN dbo.HFit_LKP_RewardTrigger AS HFLRT ON VHFRTJ.RewardTriggerLKPID = HFLRT.RewardTriggerLKPID
	INNER JOIN dbo.CMS_Site AS CS ON VHFRPJ.NodeSiteID = cs.SiteID
	INNER JOIN dbo.HFit_Account AS HFA ON cs.SiteID = HFA.SiteID

	  



GO


print('Created [view_EDW_RewardsDefinition]') ;

go 

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
