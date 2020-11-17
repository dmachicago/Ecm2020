

GO
PRINT '***** FROM: view_EDW_RewardsDefinition.sql';
GO 
PRINT 'Processing: view_EDW_RewardsDefinition:';
GO
IF EXISTS (SELECT
				  NAME
				  FROM sys.VIEWS
				  WHERE NAME = 'view_EDW_RewardsDefinition') 
	BEGIN
		DROP VIEW
			 view_EDW_RewardsDefinition;
	END;
GO

--GRANT SELECT
--	ON [dbo].[view_EDW_RewardsDefinition]
--	TO [EDWReader_PRD]
--GO

CREATE VIEW dbo.view_EDW_RewardsDefinition
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
-- 03.03.2015 (WDM/NJ) added VHFRPJ.NodeGuid as RewardProgramGUID, RewardGroupGuid, RewardLevelGuid, VHFRAJ.RewardActivityGuid, VHFRAJ.RewardActivityLKPGuid
--			RewardTriggerGuid, VHFRTPJ.NodeGuid,LKPRTP.ItemGuid as OperatorGUID, RewardTriggerGuid
-- 03.03.2015 (WDM/NJ) added new joined table LKPRTP
-- 
--****************************************************************************************************************************************************
--select * from information_schema.columns where column_name = 'RewardProgramGuid' 
--select top 100 * from View_EDW_RewardProgram_Joined 

SELECT DISTINCT
	   cs.SiteGUID
	 , HFA.AccountID
	 , hfa.AccountCD
	 --, RewardProgramID
	 , VHFRPJ.NodeGuid AS             RewardProgramGUID --(WDM/NJ) added 03.03.2015     
	 , RewardProgramName
	 , cast(RewardProgramPeriodStart as datetime) as RewardProgramPeriodStart
	 , cast(RewardProgramPeriodEnd as datetime) as RewardProgramPeriodEnd
	 --, ProgramDescription
	 --, RewardGroupID
	 , VHFRGJ.NodeGuid AS             RewardGroupGuid --(WDM/NJ) added 03.03.2015     
	 , GroupName
	 --, RewardContactGroups
	 --, RewardGroupPeriodStart
	 --, RewardGroupPeriodEnd
	 --, RewardLevelID
	 , VHFRLJ.NodeGuid AS             RewardLevelGuid --(WDM/NJ) added 03.03.2015     
	 , Level
	 , RewardLevelTypeLKPName
	 --, RewardLevelPeriodStart
	 --, RewardLevelPeriodEnd
	 --, FrequencyMenu
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
	 --, CompletionText
	 , ExternalFulfillmentRequired
	 --, RewardHistoryDetailDescription
	 --, VHFRAJ.RewardActivityID
	 , VHFRAJ.NodeGuid AS             RewardActivityGuid --(WDM/NJ) added 03.03.2015     
	 , VHFRAJ.ActivityName
	 , VHFRAJ.ActivityFreqOrCrit
	 --, VHFRAJ.RewardActivityPeriodStart
	 --, VHFRAJ.RewardActivityPeriodEnd
	 --, VHFRAJ.RewardActivityLKPID
	 --, LKPRA.ItemGuid AS              RewardActivityLKPGuid --(WDM/NJ) added 03.03.2015     
	 --, LKPRA.RewardActivityLKPName
	 , VHFRAJ.ActivityPoints
	 , VHFRAJ.IsBundle
	 , VHFRAJ.IsRequired
	 , VHFRAJ.MaxThreshold
	 , VHFRAJ.AwardPointsIncrementally
	 , VHFRAJ.AllowMedicalExceptions
	 --, VHFRAJ.BundleText
	 --, RewardTriggerID
	 , VHFRTJ.NodeGuid AS             RewardTriggerGuid --(WDM/NJ) added 03.03.2015     
	 , HFLRT.RewardTriggerDynamicValue
	 , TriggerName
	 --, RequirementDescription
	 --, LKPRTP.ItemGuid AS             OperatorGUID --(WDM/NJ) added 03.03.2015     
	 , VHFRTPJ.RewardTriggerParameterOperator
	 , VHFRTPJ.NodeGuid AS            RewardTriggerParmGUID --(WDM/NJ) added 03.03.2015     
	 , VHFRTPJ.Value
	 --, vhfrtpj.ParameterDisplayName
	 , CASE
		   WHEN CAST (VHFRPJ.DocumentCreatedWhen AS date) = CAST (VHFRPJ.DocumentModifiedWhen AS date) 
		   THEN 'I'
		   ELSE 'U'
	   END AS                         ChangeType
	 --, VHFRPJ.DocumentGuid --WDM Added 8/7/2014 in case needed
	 --, VHFRPJ.DocumentCreatedWhen
	 --, VHFRPJ.DocumentModifiedWhen
	 --, VHFRAJ.DocumentModifiedWhen AS RewardActivity_DocumentModifiedWhen --09.11.2014 : Added to facilitate EDW Last Mod Date determination
	 , VHFRAJ.DocumentCulture AS      DocumentCulture_VHFRAJ
	 , VHFRPJ.DocumentCulture AS      DocumentCulture_VHFRPJ
	 , VHFRGJ.DocumentCulture AS      DocumentCulture_VHFRGJ
	 , VHFRLJ.DocumentCulture AS      DocumentCulture_VHFRLJ
	 , VHFRTPJ.DocumentCulture AS     DocumentCulture_VHFRTPJ
	 , LevelName
	 --, LevelHeader
	 --, GroupHeadingText
	 --, GroupHeadingDescription
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
					ON LKPRA.RewardActivityLKPID = VHFRAJ.RewardActivityLKPID   --Added 1.2.2015 for SR-47520
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
					ON cs.SiteID = HFA.SiteID
				 INNER JOIN HFit_LKP_RewardTriggerParameterOperator AS LKPRTP
					ON LKPRTP.RewardTriggerParameterOperatorLKPID = VHFRTPJ.RewardTriggerParameterOperator;
GO
PRINT 'Processed: view_EDW_RewardsDefinition ';
GO
/*
(WDM) Kept only these coulmns IAW CR-51005
SiteGUID 
AccountID
AccountCD 
RewardProgramGUID
RewardProgramName
RewardProgramPeriodStart
RewardProgramPeriodEnd
RewardGroupGUID
GroupName
RewardLevelGUID
Level
RewardLevelTypeLKPName
AwardDisplayName
AwardType
AwardThreshold1
AwardThreshold2
AwardThreshold3
AwardThreshold4
AwardValue1
AwardValue2
AwardValue3
AwardValue4
ExternalFulfillmentRequired
RewardActivityGUID
RewardActivityName	--VHFRAJ.ActivityName
ActivityFreqOrCrit
ActivityPoints
IsBundle
IsRequired
MaxThreshold
AwardPointsIncrementally
AllowMedicalExceptions
RewardTriggerGUID
RewardTriggerDynamicValue
TriggerName
RewardTriggerParameterOperator
RewardTriggerParameterGUID  --RewardTriggerParmGUID
Value
ChangeType
DocumentCulture_VHFRAJ
DocumentCulture_VHFRPJ
DocumentCulture_VHFRGJ
DocumentCulture_
DocumentCulture_VHFRTPJ
LevelName
*/
GO
