
/****** Object:  View [dbo].[view_EDW_RewardTriggerParameters]    Script Date: 7/30/2014 1:13:42 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO





ALTER VIEW [dbo].[view_EDW_RewardTriggerParameters]
AS
	SELECT distinct
		cs.SiteGUID
		, VHFRTJ.RewardTriggerID
		, VHFRTJ.TriggerName
		, HFLRTPO.RewardTriggerParameterOperatorLKPDisplayName
		, VHFRTPJ.ParameterDisplayName
		, VHFRTPJ.RewardTriggerParameterOperator
		, VHFRTPJ.Value
		, hfa.AccountID
		, hfa.AccountCD
		, CASE	WHEN CAST(VHFRTJ.DocumentCreatedWhen AS DATE) = CAST(VHFRTJ.DocumentModifiedWhen AS DATE)
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		, VHFRTJ.DocumentCreatedWhen
		, VHFRTJ.DocumentModifiedWhen
	FROM
		dbo.View_HFit_RewardTrigger_Joined AS VHFRTJ WITH ( NOLOCK )
	INNER JOIN dbo.View_HFit_RewardTriggerParameter_Joined AS VHFRTPJ WITH ( NOLOCK ) ON vhfrtj.NodeID = VHFRTPJ.NodeParentID
	INNER JOIN dbo.HFit_LKP_RewardTriggerParameterOperator AS HFLRTPO WITH ( NOLOCK ) ON VHFRTPJ.RewardTriggerParameterOperator = HFLRTPO.RewardTriggerParameterOperatorLKPID
	INNER JOIN dbo.CMS_Site AS CS WITH ( NOLOCK ) ON VHFRTJ.NodeSiteID = cs.SiteID
	INNER JOIN dbo.HFit_Account AS HFA WITH ( NOLOCK ) ON cs.SiteID = HFA.SiteID
      





GO



-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
