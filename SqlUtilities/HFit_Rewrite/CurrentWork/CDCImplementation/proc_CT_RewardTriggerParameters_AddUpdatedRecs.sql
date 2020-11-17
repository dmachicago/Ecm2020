

go
-- use KenticoCMS_Prod1
GO
PRINT 'Executing proc_CT_RewardTriggerParameters_AddUpdatedRecs.sql';
GO
IF EXISTS ( SELECT
                   name
                   FROM sys.procedures
                   WHERE name = 'proc_CT_RewardTriggerParameters_AddUpdatedRecs') 
    BEGIN
        DROP PROCEDURE
             proc_CT_RewardTriggerParameters_AddUpdatedRecs;
    END;
GO
CREATE PROCEDURE proc_CT_RewardTriggerParameters_AddUpdatedRecs
AS
BEGIN

    DECLARE
       @RUNDATE AS  datetime2 ( 7 ) = GETDATE ( );

       UPDATE S
              SET
                  S.SiteGUID = T.SiteGUID
                  ,S.RewardTriggerID = T.RewardTriggerID
                  ,S.TriggerName = T.TriggerName
                  ,S.RewardTriggerParameterOperatorLKPDisplayName = T.RewardTriggerParameterOperatorLKPDisplayName
                  ,S.ParameterDisplayName = T.ParameterDisplayName
                  ,S.RewardTriggerParameterOperator = T.RewardTriggerParameterOperator
                  ,S.Value = T.Value
                  ,S.AccountID = T.AccountID
                  ,S.AccountCD = T.AccountCD
                  ,S.ChangeType = T.ChangeType
                  ,S.DocumentGuid = T.DocumentGuid
                  ,S.NodeGuid = T.NodeGuid
                  ,S.DocumentCreatedWhen = T.DocumentCreatedWhen
                  ,S.DocumentModifiedWhen = T.DocumentModifiedWhen
                  ,S.RewardTriggerParameter_DocumentModifiedWhen = T.RewardTriggerParameter_DocumentModifiedWhen
                  ,S.documentculture_VHFRTPJ = T.documentculture_VHFRTPJ
                  ,S.documentculture_VHFRTJ = T.documentculture_VHFRTJ
                  ,S.HashCode = T.HashCode
                  ,S.LastModifiedDate = GETDATE ( )
                  ,S.DeletedFlg = NULL
                  ,S.ConvertedToCentralTime = NULL

              FROM DIM_EDW_RewardTriggerParameters AS S JOIN ##TEMP_RewardTriggerParameters AS T
                   ON
                   S.SiteGUID = T.SiteGUID
               AND S.RewardTriggerID = T.RewardTriggerID
               AND S.ParameterDisplayName = T.ParameterDisplayName
               AND S.RewardTriggerParameterOperator = T.RewardTriggerParameterOperator
               AND S.Value = T.Value
               AND S.AccountID = T.AccountID
               AND S.AccountCD = T.AccountCD
               AND S.DocumentGuid = T.DocumentGuid
               AND S.NodeGuid = T.NodeGuid
              WHERE
                            S.HashCode != T.HashCode and S.DeletedFlg is null;

    DECLARE
    @iInserts AS int = @@ROWCOUNT;
    PRINT 'Updated Record Count: ' + CAST ( @iInserts AS nvarchar (50)) ;
    RETURN @iInserts;
END;

GO
PRINT 'Executed proc_CT_RewardTriggerParameters_AddUpdatedRecs.sql';
GO
