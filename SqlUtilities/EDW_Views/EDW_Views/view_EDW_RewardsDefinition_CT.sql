

GO
PRINT '***** FROM: view_EDW_RewardsDefinition_CT.sql';
GO 
PRINT 'Processing: view_EDW_RewardsDefinition_CT:';
GO
IF EXISTS (SELECT
				  NAME
				  FROM sys.VIEWS
				  WHERE NAME = 'view_EDW_RewardsDefinition_CT') 
	BEGIN
		DROP VIEW
			 view_EDW_RewardsDefinition_CT;
	END;
GO

--GRANT SELECT
--	ON [dbo].[view_EDW_RewardsDefinition_CT]
--	TO [EDWReader_PRD]
--GO

/*

select top 100 * from view_EDW_RewardsDefinition_CT

select * 
into TEMP_view_EDW_RewardsDefinition_CT
from view_EDW_RewardsDefinition_CT
*/

CREATE VIEW dbo.view_EDW_RewardsDefinition_CT
AS
--select count(*) from view_EDW_RewardsDefinition_CT
SELECT DISTINCT
	   cs.SiteGUID
	 , HFA.AccountID
	 , hfa.AccountCD
	 , VHFRPJ.NodeGuid AS             RewardProgramGUID
	 , RewardProgramName
	 , RewardProgramPeriodStart
	 , RewardProgramPeriodEnd
	 , VHFRGJ.NodeGuid AS             RewardGroupGuid
	 , GroupName
	 , VHFRLJ.NodeGuid AS             RewardLevelGuid
	 , Level
	 , RewardLevelTypeLKPName
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
	 , ExternalFulfillmentRequired
	 , VHFRAJ.NodeGuid AS             RewardActivityGuid 
	 , VHFRAJ.ActivityName
	 , VHFRAJ.ActivityFreqOrCrit
	 , VHFRAJ.ActivityPoints
	 , VHFRAJ.IsBundle
	 , VHFRAJ.IsRequired
	 , VHFRAJ.MaxThreshold
	 , VHFRAJ.AwardPointsIncrementally
	 , VHFRAJ.AllowMedicalExceptions
	 , VHFRTJ.NodeGuid AS             RewardTriggerGuid 
	 , HFLRT.RewardTriggerDynamicValue
	 , TriggerName
	 , VHFRTPJ.RewardTriggerParameterOperator
	 , VHFRTPJ.NodeGuid AS            RewardTriggerParmGUID --(WDM/NJ) added 03.03.2015     
	 , VHFRTPJ.Value
	 , CASE
		   WHEN CAST (VHFRPJ.DocumentCreatedWhen AS date) = CAST (VHFRPJ.DocumentModifiedWhen AS date) 
		   THEN 'I'
		   ELSE 'U'
	   END AS                         ChangeType
	 , VHFRAJ.DocumentCulture AS      DocumentCulture_VHFRAJ
	 , VHFRPJ.DocumentCulture AS      DocumentCulture_VHFRPJ
	 , VHFRGJ.DocumentCulture AS      DocumentCulture_VHFRGJ
	 , VHFRLJ.DocumentCulture AS      DocumentCulture_VHFRLJ
	 , VHFRTPJ.DocumentCulture AS     DocumentCulture_VHFRTPJ
	 , LevelName
,hashbytes ('sha1',
	 isNull(cast( cs.SiteGUID as nvarchar(50)),'-')
	 + isNull(cast( HFA.AccountID as nvarchar(50)),'-')
	 + isNull(cast( hfa.AccountCD as nvarchar(50)),'-')
	 + isNull(cast( VHFRPJ.NodeGuid as nvarchar(50)),'-')

+ isNull(left( RewardProgramName,250),'-')

	 + isNull(cast( RewardProgramPeriodStart as nvarchar(50)),'-')
	 + isNull(cast( RewardProgramPeriodEnd as nvarchar(50)),'-')
	 + isNull(cast( VHFRGJ.NodeGuid as nvarchar(50)),'-')
	 
+ isNull(left( GroupName,250),'-')
	
      + isNull(cast( VHFRLJ.NodeGuid as nvarchar(50)),'-')
	 + isNull(cast( Level as nvarchar(50)),'-')
	 
+ isNull(left( RewardLevelTypeLKPName,250),'-')
+ isNull(left( AwardDisplayName,250),'-')

	 + isNull(cast( AwardType as nvarchar(50)),'-')
	 + isNull(cast( AwardThreshold1 as nvarchar(50)),'-')
	 + isNull(cast( AwardThreshold2 as nvarchar(50)),'-')
	 + isNull(cast( AwardThreshold3 as nvarchar(50)),'-')
	 + isNull(cast( AwardThreshold4 as nvarchar(50)),'-')
	 + isNull(cast( AwardValue1 as nvarchar(50)),'-')
	 + isNull(cast( AwardValue2 as nvarchar(50)),'-')
	 + isNull(cast( AwardValue3 as nvarchar(50)),'-')
	 + isNull(cast( AwardValue4 as nvarchar(50)),'-')
	 + isNull(cast( ExternalFulfillmentRequired as nvarchar(50)),'-')
	 + isNull(cast( VHFRAJ.NodeGuid as nvarchar(50)),'-')

+ isNull(left( VHFRAJ.ActivityName,250),'-')

	 + isNull(cast( VHFRAJ.ActivityFreqOrCrit as nvarchar(50)),'-')
	 + isNull(cast( VHFRAJ.ActivityPoints as nvarchar(50)),'-')
	 + isNull(cast( VHFRAJ.IsBundle as nvarchar(50)),'-')
	 + isNull(cast( VHFRAJ.IsRequired as nvarchar(50)),'-')
	 + isNull(cast( VHFRAJ.MaxThreshold as nvarchar(50)),'-')
	 + isNull(cast( VHFRAJ.AwardPointsIncrementally as nvarchar(50)),'-')
	 + isNull(cast( VHFRAJ.AllowMedicalExceptions as nvarchar(50)),'-')
	 + isNull(cast( VHFRTJ.NodeGuid as nvarchar(50)),'-')
	 + isNull(cast( HFLRT.RewardTriggerDynamicValue as nvarchar(50)),'-')

+ isNull(left( TriggerName,250),'-')

	 + isNull(cast( VHFRTPJ.RewardTriggerParameterOperator as nvarchar(50)),'-')
	 + isNull(cast( VHFRTPJ.NodeGuid as nvarchar(50)),'-')
	 + isNull(cast( VHFRTPJ.Value as nvarchar(50)),'-')
) as HashCode
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
					ON LKPRTP.RewardTriggerParameterOperatorLKPID = VHFRTPJ.RewardTriggerParameterOperator

GO
PRINT 'Processed: view_EDW_RewardsDefinition_CT ';
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
