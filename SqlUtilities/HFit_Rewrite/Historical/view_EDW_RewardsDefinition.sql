/****** Object:  View [dbo].[view_EDW_RewardsDefinition]    Script Date: 8/7/2014 2:27:21 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

alter VIEW [dbo].[view_EDW_RewardsDefinition]
AS
--WDM Reviewed 8/6/2014 for needed updates, may be needed
--	My question - Is NodeGUID going to be passed onto the children
--8/7/2014 - added and commented out DocumentGuid in case needed later
--8/8/2014 - Generated corrected view in DEV (WDM)
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
		, [Level]
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
		--, VHFRPJ.DocumentGuid	--WDM Added 8/7/2014 in case needed
	FROM 
	dbo.View_HFit_RewardProgram_Joined AS VHFRPJ
	INNER JOIN dbo.View_HFit_RewardGroup_Joined AS VHFRGJ ON VHFRPJ.NodeID = VHFRGJ.NodeParentID
	INNER JOIN dbo.View_HFit_RewardLevel_Joined AS VHFRLJ ON VHFRGJ.NodeID = VHFRLJ.NodeParentID
	INNER JOIN dbo.HFit_LKP_RewardLevelType AS HFLRLT ON VHFRLJ.LevelType = HFLRLT.RewardLevelTypeLKPID
	INNER JOIN dbo.View_HFit_RewardActivity_Joined AS VHFRAJ ON VHFRLJ.NodeID = VHFRAJ.NodeParentID
	INNER JOIN dbo.View_HFit_RewardTrigger_Joined AS VHFRTJ ON VHFRAJ.NodeID = VHFRTJ.NodeParentID
	INNER JOIN dbo.View_HFit_RewardTriggerParameter_Joined AS VHFRTPJ ON vhfrtj.nodeid = vhfrtpj.nodeparentid
	INNER JOIN dbo.HFit_LKP_RewardTrigger AS HFLRT ON VHFRTJ.RewardTriggerLKPID = HFLRT.RewardTriggerLKPID
	INNER JOIN dbo.CMS_Site AS CS ON VHFRPJ.NodeSiteID = cs.SiteID
	INNER JOIN dbo.HFit_Account AS HFA ON cs.SiteID = HFA.SiteID
	

GO


