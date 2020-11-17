USE [KenticoCMS_PRD_prod3K7]
GO

/****** Object:  View [dbo].[view_EDW_RewardTriggerParameters]    Script Date: 5/13/2015 10:02:10 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


--GRANT SELECT
--	ON [dbo].[view_EDW_RewardTriggerParameters]
--	TO [EDWReader_PRD]
--GO
--********************************************************************************************************
--09.11.2014 : (wdm) Verified last mod date available to EDW - RewardTriggerParameter_DocumentModifiedWhen
--11.17.2014 : (wdm) John C. found that Spanish was being brought across in TriggerName and 
--				ParameterDisplayName. Found that View_HFit_RewardTrigger_Joined has no way to limit the 
--				returned data to Spanish. Created a new view, View_EDW_RewardProgram_Joined, and provided 
--				a FILTER on Document Culture. The, added Launguage fitlers as: 
--					where VHFRTJ.DocumentCulture = 'en-US' AND VHFRTPJ.DocumentCulture = 'en-US'
--				This appears to have eliminated the Spanish.
--********************************************************************************************************

CREATE VIEW [dbo].[view_EDW_RewardTriggerParameters]
AS

	 --8/7/2014 - added and commented out DocumentGuid and NodeGuid in case needed later
	 --8/8/2014 - Generated corrected view in DEV (WDM)

	 SELECT DISTINCT
			cs.SiteGUID
		  , VHFRTJ.RewardTriggerID
		  , VHFRTJ.TriggerName
		  , HFLRTPO.RewardTriggerParameterOperatorLKPDisplayName
		  , VHFRTPJ.ParameterDisplayName
		  , VHFRTPJ.RewardTriggerParameterOperator
		  , VHFRTPJ.Value
		  , hfa.AccountID
		  , hfa.AccountCD
		  , CASE
				WHEN CAST (VHFRTJ.DocumentCreatedWhen AS date) = CAST (VHFRTJ.DocumentModifiedWhen AS date) 
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		  , VHFRTJ.DocumentGuid

			--WDM Added 8/7/2014 in case needed

		  , VHFRTJ.NodeGuid

			--WDM Added 8/7/2014 in case needed

		  , VHFRTJ.DocumentCreatedWhen
		  , VHFRTJ.DocumentModifiedWhen
		  , VHFRTPJ.DocumentModifiedWhen AS RewardTriggerParameter_DocumentModifiedWhen
		  , VHFRTPJ.documentculture AS documentculture_VHFRTPJ
		  , VHFRTJ.documentculture AS documentculture_VHFRTJ
	   FROM dbo.View_HFit_RewardTrigger_Joined AS VHFRTJ

	 --dbo.[View_EDW_RewardProgram_Joined] AS VHFRTJ 		

				INNER JOIN dbo.View_HFit_RewardTriggerParameter_Joined AS VHFRTPJ
					ON vhfrtj.NodeID = VHFRTPJ.NodeParentID
				INNER JOIN dbo.HFit_LKP_RewardTriggerParameterOperator AS HFLRTPO
					ON VHFRTPJ.RewardTriggerParameterOperator = HFLRTPO.RewardTriggerParameterOperatorLKPID
				INNER JOIN dbo.CMS_Site AS CS
					ON VHFRTJ.NodeSiteID = cs.SiteID
				INNER JOIN dbo.HFit_Account AS HFA
					ON cs.SiteID = HFA.SiteID
	   WHERE VHFRTJ.DocumentCulture = 'en-US'
		 AND VHFRTPJ.DocumentCulture = 'en-US';

GO


