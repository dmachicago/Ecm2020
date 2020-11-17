
GO
-- use KenticoCMS_Prod1

GO
PRINT 'Executing proc_CT_RewardTriggerParameters_AddDeletedRecs.sql';
GO
IF EXISTS ( SELECT
                   name
                   FROM sys.procedures
                   WHERE name = 'proc_CT_RewardTriggerParameters_AddDeletedRecs') 
    BEGIN
        DROP PROCEDURE
             proc_CT_RewardTriggerParameters_AddDeletedRecs;
    END;
GO
CREATE PROCEDURE proc_CT_RewardTriggerParameters_AddDeletedRecs
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
       , NodeGuid) 
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
               FROM DIM_EDW_RewardTriggerParameters
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
               FROM ##TEMP_RewardTriggerParameters
        ) 
        UPDATE S
          SET
              S.DeletedFlg = 1
              FROM CTE AS T
                        JOIN DIM_EDW_RewardTriggerParameters AS S
                        ON
                        S.SiteGUID = T.SiteGUID AND
                        S.RewardTriggerID = T.RewardTriggerID AND
                        S.ParameterDisplayName = T.ParameterDisplayName AND
                        S.RewardTriggerParameterOperator = T.RewardTriggerParameterOperator AND
                        S.Value = T.Value AND
                        S.AccountID = T.AccountID AND
                        S.AccountCD = T.AccountCD AND
                        S.DocumentGuid = T.DocumentGuid AND
                        S.NodeGuid = T.NodeGuid AND
                        S.DeletedFlg IS NULL;

    DECLARE
    @iInserts AS int = @@ROWCOUNT;

    UPDATE DIM_EDW_RewardTriggerParameters
      SET
          LastModifiedDate = GETDATE () 
           WHERE
                 LastModifiedDate IS NULL AND
                 DeletedFlg IS NOT NULL;

    PRINT 'Deleted Record Count: ' + CAST ( @iInserts AS nvarchar (50)) ;
    RETURN @iInserts;
END;

GO
PRINT 'Executed proc_CT_RewardTriggerParameters_AddDeletedRecs.sql';
GO
