USE [KenticoCMS_PRD_prod3K7]
GO

/****** Object:  View [dbo].[view_EDW_RewardsDefinition]    Script Date: 5/13/2015 10:02:00 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


--select RewardActivityID,* from View_HFit_RewardActivity_Joined
--GRANT SELECT
--	ON [dbo].[view_EDW_RewardsDefinition]
--	TO [EDWReader_PRD]
--GO

--select top 100 * from view_EDW_RewardsDefinition

CREATE VIEW [dbo].[view_EDW_RewardsDefinition]
AS

	 --****************************************************************************************************************************************************
	 --WDM Reviewed 8/6/2014 for needed updates, may be needed
	 --	My question - Is NodeGUID going to be passed onto the children
	 --8/7/2014 - added and commented out DocumentGuid in case needed later
	 --8/8/2014 - Generated corrected view in DEV (WDM)
	 --8/19/2014 - (WDM) Added where clause to make the query return english data only.	
	 --09.11.2014 : Added to facilitate EDW Last Mod Date determination and added language filters
	 --11.14.2014 : Found that this view was in PRod Staging and not in Prod.
	 --11.17.2014 : John C. found that Spanish was coming across. This was due to the view
	 --				View_HFit_RewardProgram_Joined not having the capability to FITER at the 
	 --				Document Culture level. Created a view, View_EDW_RewardProgram_Joined, that
	 --				used View_HFit_RewardProgram_Joined and added the capability to fiter languages.
	 --12.31.2014 (WDM) added left outer join HFit_LKP_RewardActivity AND VHFRAJ.RewardActivityLKPName to the view reference CR-47520
	 --01.01.2014 (WDM) tested changes for CR-47520
	 --02.16.2015 (WDM) Requested by John C. added as all required is a reference to the name
	 --		    ,[LevelName]
	 --			,[LevelHeader]
	 --		    ,[GroupHeadingText]
	 --		    ,[GroupHeadingDescription]
	 --****************************************************************************************************************************************************

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
		  , LKPRA.RewardActivityLKPName
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
		  , CASE
			WHEN CAST (VHFRPJ.DocumentCreatedWhen AS date) = CAST (VHFRPJ.DocumentModifiedWhen AS date) 
			THEN 'I'
			ELSE 'U'
			END AS ChangeType
		  , VHFRPJ.DocumentGuid

			--WDM Added 8/7/2014 in case needed

		  , VHFRPJ.DocumentCreatedWhen
		  , VHFRPJ.DocumentModifiedWhen
		  , VHFRAJ.DocumentModifiedWhen AS RewardActivity_DocumentModifiedWhen

			--09.11.2014 : Added to facilitate EDW Last Mod Date determination

		  , VHFRAJ.DocumentCulture AS DocumentCulture_VHFRAJ
		  , VHFRPJ.DocumentCulture AS DocumentCulture_VHFRPJ
		  , VHFRGJ.DocumentCulture AS DocumentCulture_VHFRGJ
		  , VHFRLJ.DocumentCulture AS DocumentCulture_VHFRLJ
		  , VHFRTPJ.DocumentCulture AS DocumentCulture_VHFRTPJ
		  , LevelName
		  , LevelHeader
		  , GroupHeadingText
		  , GroupHeadingDescription
	   FROM dbo.View_EDW_RewardProgram_Joined AS VHFRPJ
				INNER JOIN dbo.View_HFit_RewardGroup_Joined AS VHFRGJ
					ON VHFRPJ.NodeID = VHFRGJ.NodeParentID
				   AND VHFRPJ.DocumentCulture = 'en-US'
				   AND VHFRGJ.DocumentCulture = 'en-US'
				INNER JOIN dbo.View_HFit_RewardLevel_Joined AS VHFRLJ
					ON VHFRGJ.NodeID = VHFRLJ.NodeParentID
				   AND VHFRLJ.DocumentCulture = 'en-US'
				INNER JOIN dbo.HFit_LKP_RewardLevelType AS HFLRLT
					ON VHFRLJ.LevelType = HFLRLT.RewardLevelTypeLKPID
				INNER JOIN dbo.View_HFit_RewardActivity_Joined AS VHFRAJ
					ON VHFRLJ.NodeID = VHFRAJ.NodeParentID
				   AND VHFRAJ.DocumentCulture = 'en-US'
				LEFT OUTER JOIN HFit_LKP_RewardActivity AS LKPRA
					ON LKPRA.RewardActivityLKPID = VHFRAJ.RewardActivityLKPID

	 --Added 1.2.2015 for SR-47520

				INNER JOIN dbo.View_HFit_RewardTrigger_Joined AS VHFRTJ
					ON VHFRAJ.NodeID = VHFRTJ.NodeParentID
				   AND VHFRTJ.DocumentCulture = 'en-US'
				INNER JOIN dbo.View_HFit_RewardTriggerParameter_Joined AS VHFRTPJ
					ON vhfrtj.nodeid = vhfrtpj.nodeparentid
				   AND VHFRTPJ.DocumentCulture = 'en-US'
				INNER JOIN dbo.HFit_LKP_RewardTrigger AS HFLRT
					ON VHFRTJ.RewardTriggerLKPID = HFLRT.RewardTriggerLKPID
				INNER JOIN dbo.CMS_Site AS CS
					ON VHFRPJ.NodeSiteID = cs.SiteID
				INNER JOIN dbo.HFit_Account AS HFA
					ON cs.SiteID = HFA.SiteID;

GO


