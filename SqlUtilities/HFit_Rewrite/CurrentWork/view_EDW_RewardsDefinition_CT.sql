
GO
-- use KenticoCMS_Prod1

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

/*-------------------------------------------------

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
     , VHFRPJ.NodeGuid AS RewardProgramGUID
     , RewardProgramName
     , RewardProgramPeriodStart
     , RewardProgramPeriodEnd
     , VHFRGJ.NodeGuid AS RewardGroupGuid
     , GroupName
     , VHFRLJ.NodeGuid AS RewardLevelGuid
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
     , VHFRAJ.NodeGuid AS RewardActivityGuid
     , VHFRAJ.ActivityName
     , VHFRAJ.ActivityFreqOrCrit
     , VHFRAJ.ActivityPoints
     , VHFRAJ.IsBundle
     , VHFRAJ.IsRequired
     , VHFRAJ.MaxThreshold
     , VHFRAJ.AwardPointsIncrementally
     , VHFRAJ.AllowMedicalExceptions
     , VHFRTJ.NodeGuid AS RewardTriggerGuid
     , HFLRT.RewardTriggerDynamicValue
     , TriggerName
     , VHFRTPJ.RewardTriggerParameterOperator
     , VHFRTPJ.NodeGuid AS RewardTriggerParmGUID --(WDM/NJ) added 03.03.2015     
     , VHFRTPJ.Value
     , CASE
           WHEN CAST (VHFRPJ.DocumentCreatedWhen AS date) = CAST (VHFRPJ.DocumentModifiedWhen AS date) 
               THEN 'I'
           ELSE 'U'
       END AS ChangeType
     , VHFRAJ.DocumentCulture AS DocumentCulture_VHFRAJ
     , VHFRPJ.DocumentCulture AS DocumentCulture_VHFRPJ
     , VHFRGJ.DocumentCulture AS DocumentCulture_VHFRGJ
     , VHFRLJ.DocumentCulture AS DocumentCulture_VHFRLJ
     , VHFRTPJ.DocumentCulture AS DocumentCulture_VHFRTPJ
     , LevelName
     , HASHBYTES ('sha1',
       ISNULL (CAST ( cs.SiteGUID AS nvarchar (50)) , '-') + ISNULL (CAST ( HFA.AccountID AS nvarchar (50)) , '-') + ISNULL (CAST ( hfa.AccountCD AS nvarchar (50)) , '-') + ISNULL (CAST ( VHFRPJ.NodeGuid AS nvarchar (50)) , '-') + ISNULL (LEFT ( RewardProgramName, 250) , '-') + ISNULL (CAST ( RewardProgramPeriodStart AS nvarchar (50)) , '-') + ISNULL (CAST ( RewardProgramPeriodEnd AS nvarchar (50)) , '-') + ISNULL (CAST ( VHFRGJ.NodeGuid AS nvarchar (50)) , '-') + ISNULL (LEFT ( GroupName, 250) , '-') + ISNULL (CAST ( VHFRLJ.NodeGuid AS nvarchar (50)) , '-') + ISNULL (CAST ( Level AS nvarchar (50)) , '-') + ISNULL (LEFT ( RewardLevelTypeLKPName, 250) , '-') + ISNULL (LEFT ( AwardDisplayName, 250) , '-') + ISNULL (CAST ( AwardType AS nvarchar (50)) , '-') + ISNULL (CAST ( AwardThreshold1 AS nvarchar (50)) , '-') + ISNULL (CAST ( AwardThreshold2 AS nvarchar (50)) , '-') + ISNULL (CAST ( AwardThreshold3 AS nvarchar (50)) , '-') + ISNULL (CAST ( AwardThreshold4 AS nvarchar (50)) , '-') + ISNULL (CAST ( AwardValue1 AS nvarchar (50)) , '-') + ISNULL (CAST ( AwardValue2 AS nvarchar (50)) , '-') + ISNULL (CAST ( AwardValue3 AS nvarchar (50)) , '-') + ISNULL (CAST ( AwardValue4 AS nvarchar (50)) , '-') + ISNULL (CAST ( ExternalFulfillmentRequired AS nvarchar (50)) , '-') + ISNULL (CAST ( VHFRAJ.NodeGuid AS nvarchar (50)) , '-') + ISNULL (LEFT ( VHFRAJ.ActivityName, 250) , '-') + ISNULL (CAST ( VHFRAJ.ActivityFreqOrCrit AS nvarchar (50)) , '-') + ISNULL (CAST ( VHFRAJ.ActivityPoints AS nvarchar (50)) , '-') + ISNULL (CAST ( VHFRAJ.IsBundle AS nvarchar (50)) , '-') + ISNULL (CAST ( VHFRAJ.IsRequired AS nvarchar (50)) , '-') + ISNULL (CAST ( VHFRAJ.MaxThreshold AS nvarchar (50)) , '-') + ISNULL (CAST ( VHFRAJ.AwardPointsIncrementally AS nvarchar (50)) , '-') + ISNULL (CAST ( VHFRAJ.AllowMedicalExceptions AS nvarchar (50)) , '-') + ISNULL (CAST ( VHFRTJ.NodeGuid AS nvarchar (50)) , '-') + ISNULL (CAST ( HFLRT.RewardTriggerDynamicValue AS nvarchar (50)) , '-') + ISNULL (LEFT ( TriggerName, 250) , '-') + ISNULL (CAST ( VHFRTPJ.RewardTriggerParameterOperator AS nvarchar (50)) , '-') + ISNULL (CAST ( VHFRTPJ.NodeGuid AS nvarchar (50)) , '-') + ISNULL (CAST ( VHFRTPJ.Value AS nvarchar (50)) , '-') 
       ) AS HashCode
       FROM
           dbo.View_EDW_RewardProgram_Joined AS VHFRPJ
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
                   ON LKPRA.RewardActivityLKPID = VHFRAJ.RewardActivityLKPID --Added 1.2.2015 for SR-47520
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
               LEFT JOIN HFit_LKP_RewardTriggerParameterOperator AS LKPRTP
                   ON LKPRTP.RewardTriggerParameterOperatorLKPID = VHFRTPJ.RewardTriggerParameterOperator;

GO
PRINT 'Processed: view_EDW_RewardsDefinition_CT ';
GO
/*-------------------------------------------------
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
