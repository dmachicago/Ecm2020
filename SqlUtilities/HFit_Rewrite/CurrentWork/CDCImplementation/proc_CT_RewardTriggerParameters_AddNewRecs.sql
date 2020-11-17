
GO
-- use KenticoCMS_Prod1

GO
PRINT 'Executing proc_CT_RewardTriggerParameters_AddNewRecs.sql';
GO
IF EXISTS ( SELECT
                   name
                   FROM sys.procedures
                   WHERE name = 'proc_CT_RewardTriggerParameters_AddNewRecs') 
    BEGIN
        DROP PROCEDURE
             proc_CT_RewardTriggerParameters_AddNewRecs;
    END;
GO
CREATE PROCEDURE proc_CT_RewardTriggerParameters_AddNewRecs
AS
BEGIN

    WITH CTE (
         SiteGUID
       , RewardTriggerID
       , ParameterDisplayName
       , RewardTriggerParameterOperator
       , [Value]
       , AccountID
       , AccountCD
       , DocumentGuid
       , NodeGuid
    ) 
        AS (
        SELECT
               SiteGUID
             , RewardTriggerID
             , ParameterDisplayName
             , RewardTriggerParameterOperator
             , [Value]
             , AccountID
             , AccountCD
             , DocumentGuid
             , NodeGuid
               FROM ##TEMP_RewardTriggerParameters
        EXCEPT
        SELECT
               SiteGUID
             , RewardTriggerID
             , ParameterDisplayName
             , RewardTriggerParameterOperator
             , [Value]
             , AccountID
             , AccountCD
             , DocumentGuid
             , NodeGuid
               FROM DIM_EDW_RewardTriggerParameters
               WHERE LastModifiedDate IS NULL
        ) 
        INSERT INTO dbo.DIM_EDW_RewardTriggerParameters
        (
               SiteGUID
             , RewardTriggerID
             , TriggerName
             , RewardTriggerParameterOperatorLKPDisplayName
             , ParameterDisplayName
             , RewardTriggerParameterOperator
             , [Value]
             , AccountID
             , AccountCD
             , ChangeType
             , DocumentGuid
             , NodeGuid
             , DocumentCreatedWhen
             , DocumentModifiedWhen
             , RewardTriggerParameter_DocumentModifiedWhen
             , documentculture_VHFRTPJ
             , documentculture_VHFRTJ
             , HashCode
             , LastModifiedDate
             , DeletedFlg
        ) 
        SELECT
               T.SiteGUID
             , T.RewardTriggerID
             , T.TriggerName
             , T.RewardTriggerParameterOperatorLKPDisplayName
             , T.ParameterDisplayName
             , T.RewardTriggerParameterOperator
             , T.[Value]
             , T.AccountID
             , T.AccountCD
             , T.ChangeType
             , T.DocumentGuid
             , T.NodeGuid
             , T.DocumentCreatedWhen
             , T.DocumentModifiedWhen
             , T.RewardTriggerParameter_DocumentModifiedWhen
             , T.documentculture_VHFRTPJ
             , T.documentculture_VHFRTJ
             , T.HashCode
             , NULL AS LastModifiedDate
             , NULL AS DeletedFlg
               FROM
                    ##TEMP_RewardTriggerParameters AS T
                         JOIN CTE AS S
                         ON
                            S.SiteGUID = T.SiteGUID AND
                            S.RewardTriggerID = T.RewardTriggerID AND
                            S.ParameterDisplayName = T.ParameterDisplayName AND
                            S.RewardTriggerParameterOperator = T.RewardTriggerParameterOperator AND
                            S.Value = T.Value AND
                            S.AccountID = T.AccountID AND
                            S.AccountCD = T.AccountCD AND
                            S.DocumentGuid = T.DocumentGuid AND
                            S.NodeGuid = T.NodeGuid;

    DECLARE
    @iInserts AS int = @@ROWCOUNT;
    PRINT 'NEW Insert Count: ' + CAST ( @iInserts AS nvarchar (50)) ;
    RETURN @iInserts;
END;

GO
PRINT 'Executed proc_CT_RewardTriggerParameters_AddNewRecs.sql';
GO
