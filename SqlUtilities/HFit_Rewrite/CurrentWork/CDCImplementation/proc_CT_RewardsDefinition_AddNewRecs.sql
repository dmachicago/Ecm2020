
go
-- use KenticoCMS_Prod1

GO
PRINT 'Executing proc_CT_RewardsDefinition_AddNewRecs.sql';
GO
IF EXISTS ( SELECT
                   name
                   FROM sys.procedures
                   WHERE name = 'proc_CT_RewardsDefinition_AddNewRecs') 
    BEGIN
        DROP PROCEDURE
             proc_CT_RewardsDefinition_AddNewRecs;
    END;
GO
CREATE PROCEDURE proc_CT_RewardsDefinition_AddNewRecs
AS
BEGIN

WITH CTE (
                 SiteGUID
                 ,AccountID
                 ,AccountCD
                 ,RewardProgramGUID
                 ,RewardGroupGuid
                 ,RewardLevelGuid
                 ,RewardActivityGuid
                 ,RewardTriggerGuid
                 ,RewardTriggerParmGUID )
                AS ( SELECT
                            SiteGUID
                            ,AccountID
                            ,AccountCD
                            ,RewardProgramGUID
                            ,RewardGroupGuid
                            ,RewardLevelGuid
                            ,RewardActivityGuid
                            ,RewardTriggerGuid
                            ,RewardTriggerParmGUID
                       FROM ##TEMP_EDW_RewardsDefinition_DATA
                     EXCEPT
                     SELECT
                            SiteGUID
                            ,AccountID
                            ,AccountCD
                            ,RewardProgramGUID
                            ,RewardGroupGuid
                            ,RewardLevelGuid
                            ,RewardActivityGuid
                            ,RewardTriggerGuid
                            ,RewardTriggerParmGUID
                       FROM DIM_EDW_RewardsDefinition
                       WHERE LastModifiedDate IS NULL )
                INSERT INTO dbo.DIM_EDW_RewardsDefinition (
                       SiteGUID
                       ,AccountID
                       ,AccountCD
                       ,RewardProgramGUID
                       ,RewardProgramName
                       ,RewardProgramPeriodStart
                       ,RewardProgramPeriodEnd
                       ,RewardGroupGuid
                       ,GroupName
                       ,RewardLevelGuid
                       ,Level
                       ,RewardLevelTypeLKPName
                       ,AwardDisplayName
                       ,AwardType
                       ,AwardThreshold1
                       ,AwardThreshold2
                       ,AwardThreshold3
                       ,AwardThreshold4
                       ,AwardValue1
                       ,AwardValue2
                       ,AwardValue3
                       ,AwardValue4
                       ,ExternalFulfillmentRequired
                       ,RewardActivityGuid
                       ,ActivityName
                       ,ActivityFreqOrCrit
                       ,ActivityPoints
                       ,IsBundle
                       ,IsRequired
                       ,MaxThreshold
                       ,AwardPointsIncrementally
                       ,AllowMedicalExceptions
                       ,RewardTriggerGuid
                       ,RewardTriggerDynamicValue
                       ,TriggerName
                       ,RewardTriggerParameterOperator
                       ,RewardTriggerParmGUID
                       ,[Value]
                       ,ChangeType
                       ,DocumentCulture_VHFRAJ
                       ,DocumentCulture_VHFRPJ
                       ,DocumentCulture_VHFRGJ
                       ,DocumentCulture_VHFRLJ
                       ,DocumentCulture_VHFRTPJ
                       ,LevelName
                       ,HashCode
                       ,LastModifiedDate
                       ,DeletedFlg )
                SELECT
                       T.SiteGUID
                       ,T.AccountID
                       ,T.AccountCD
                       ,T.RewardProgramGUID
                       ,T.RewardProgramName
                       ,T.RewardProgramPeriodStart
                       ,T.RewardProgramPeriodEnd
                       ,T.RewardGroupGuid
                       ,T.GroupName
                       ,T.RewardLevelGuid
                       ,T.Level
                       ,T.RewardLevelTypeLKPName
                       ,T.AwardDisplayName
                       ,T.AwardType
                       ,T.AwardThreshold1
                       ,T.AwardThreshold2
                       ,T.AwardThreshold3
                       ,T.AwardThreshold4
                       ,T.AwardValue1
                       ,T.AwardValue2
                       ,T.AwardValue3
                       ,T.AwardValue4
                       ,T.ExternalFulfillmentRequired
                       ,T.RewardActivityGuid
                       ,T.ActivityName
                       ,T.ActivityFreqOrCrit
                       ,T.ActivityPoints
                       ,T.IsBundle
                       ,T.IsRequired
                       ,T.MaxThreshold
                       ,T.AwardPointsIncrementally
                       ,T.AllowMedicalExceptions
                       ,T.RewardTriggerGuid
                       ,T.RewardTriggerDynamicValue
                       ,T.TriggerName
                       ,T.RewardTriggerParameterOperator
                       ,T.RewardTriggerParmGUID
                       ,T.[Value]
                       ,T.ChangeType
                       ,T.DocumentCulture_VHFRAJ
                       ,T.DocumentCulture_VHFRPJ
                       ,T.DocumentCulture_VHFRGJ
                       ,T.DocumentCulture_VHFRLJ
                       ,T.DocumentCulture_VHFRTPJ
                       ,T.LevelName
                       ,T.HashCode
                       ,NULL AS LastModifiedDate
                       ,NULL AS DeletedFlg
                  FROM
                       ##TEMP_EDW_RewardsDefinition_DATA AS T JOIN CTE AS S
                       ON
                       S.SiteGUID = T.SiteGUID
                   AND S.AccountID = T.AccountID
                   AND S.AccountCD = T.AccountCD
                   AND S.RewardProgramGUID = T.RewardProgramGUID
                   AND S.RewardGroupGuid = T.RewardGroupGuid
                   AND S.RewardLevelGuid = T.RewardLevelGuid
                   AND S.RewardActivityGuid = T.RewardActivityGuid
                   AND S.RewardTriggerGuid = T.RewardTriggerGuid
                   AND S.RewardTriggerParmGUID = T.RewardTriggerParmGUID;

    DECLARE
    @iInserts AS int = @@ROWCOUNT;
    PRINT 'NEW Insert Count: ' + CAST ( @iInserts AS nvarchar (50)) ;
    RETURN @iInserts;
END;

GO
PRINT 'Executed proc_CT_RewardsDefinition_AddNewRecs.sql';
GO
