

go
-- use KenticoCMS_Prod1
GO
PRINT 'Executing proc_CT_RewardsDefinition_AddUpdatedRecs.sql';
GO
IF EXISTS ( SELECT
                   name
                   FROM sys.procedures
                   WHERE name = 'proc_CT_RewardsDefinition_AddUpdatedRecs') 
    BEGIN
        DROP PROCEDURE
             proc_CT_RewardsDefinition_AddUpdatedRecs;
    END;
GO
CREATE PROCEDURE proc_CT_RewardsDefinition_AddUpdatedRecs
AS
BEGIN

    DECLARE
       @RUNDATE AS  datetime2 ( 7 ) = GETDATE ( );

    UPDATE S
                      SET
                          S.SiteGUID = T.SiteGUID
                          ,S.AccountID = T.AccountID
                          ,S.AccountCD = T.AccountCD
                          ,S.RewardProgramGUID = T.RewardProgramGUID
                          ,S.RewardProgramName = T.RewardProgramName
                          ,S.RewardProgramPeriodStart = T.RewardProgramPeriodStart
                          ,S.RewardProgramPeriodEnd = T.RewardProgramPeriodEnd
                          ,S.RewardGroupGuid = T.RewardGroupGuid
                          ,S.GroupName = T.GroupName
                          ,S.RewardLevelGuid = T.RewardLevelGuid
                          ,S.Level = T.Level
                          ,S.RewardLevelTypeLKPName = T.RewardLevelTypeLKPName
                          ,S.AwardDisplayName = T.AwardDisplayName
                          ,S.AwardType = T.AwardType
                          ,S.AwardThreshold1 = T.AwardThreshold1
                          ,S.AwardThreshold2 = T.AwardThreshold2
                          ,S.AwardThreshold3 = T.AwardThreshold3
                          ,S.AwardThreshold4 = T.AwardThreshold4
                          ,S.AwardValue1 = T.AwardValue1
                          ,S.AwardValue2 = T.AwardValue2
                          ,S.AwardValue3 = T.AwardValue3
                          ,S.AwardValue4 = T.AwardValue4
                          ,S.ExternalFulfillmentRequired = T.ExternalFulfillmentRequired
                          ,S.RewardActivityGuid = T.RewardActivityGuid
                          ,S.ActivityName = T.ActivityName
                          ,S.ActivityFreqOrCrit = T.ActivityFreqOrCrit
                          ,S.ActivityPoints = T.ActivityPoints
                          ,S.IsBundle = T.IsBundle
                          ,S.IsRequired = T.IsRequired
                          ,S.MaxThreshold = T.MaxThreshold
                          ,S.AwardPointsIncrementally = T.AwardPointsIncrementally
                          ,S.AllowMedicalExceptions = T.AllowMedicalExceptions
                          ,S.RewardTriggerGuid = T.RewardTriggerGuid
                          ,S.RewardTriggerDynamicValue = T.RewardTriggerDynamicValue
                          ,S.TriggerName = T.TriggerName
                          ,S.RewardTriggerParameterOperator = T.RewardTriggerParameterOperator
                          ,S.RewardTriggerParmGUID = T.RewardTriggerParmGUID
                          ,S.Value = T.Value
                          ,S.ChangeType = T.ChangeType
                          ,S.DocumentCulture_VHFRAJ = T.DocumentCulture_VHFRAJ
                          ,S.DocumentCulture_VHFRPJ = T.DocumentCulture_VHFRPJ
                          ,S.DocumentCulture_VHFRGJ = T.DocumentCulture_VHFRGJ
                          ,S.DocumentCulture_VHFRLJ = T.DocumentCulture_VHFRLJ
                          ,S.DocumentCulture_VHFRTPJ = T.DocumentCulture_VHFRTPJ
                          ,S.LevelName = T.LevelName
                          ,S.HashCode = T.HashCode
                          ,S.LastModifiedDate = GETDATE ( )
                          ,S.DeletedFlg = NULL
                          ,S.ConvertedToCentralTime = NULL
                      FROM DIM_EDW_RewardsDefinition AS S JOIN ##TEMP_EDW_RewardsDefinition_DATA AS T
                           ON
                           S.SiteGUID = T.SiteGUID
                       AND S.AccountID = T.AccountID
                       AND S.AccountCD = T.AccountCD
                       AND S.RewardProgramGUID = T.RewardProgramGUID
                       AND S.RewardGroupGuid = T.RewardGroupGuid
                       AND S.RewardLevelGuid = T.RewardLevelGuid
                       AND S.RewardActivityGuid = T.RewardActivityGuid
                       AND S.RewardTriggerGuid = T.RewardTriggerGuid
                       AND S.RewardTriggerParmGUID = T.RewardTriggerParmGUID
                      WHERE
                            S.HashCode != T.HashCode and S.DeletedFlg is null;

    DECLARE
    @iInserts AS int = @@ROWCOUNT;
    PRINT 'Updated Record Count: ' + CAST ( @iInserts AS nvarchar (50)) ;
    RETURN @iInserts;
END;

GO
PRINT 'Executed proc_CT_RewardsDefinition_AddUpdatedRecs.sql';
GO
