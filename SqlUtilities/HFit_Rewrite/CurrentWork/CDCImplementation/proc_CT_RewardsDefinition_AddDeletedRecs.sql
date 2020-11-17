
go
-- use KenticoCMS_Prod1

GO
PRINT 'Executing proc_CT_RewardsDefinition_AddDeletedRecs.sql';
GO
IF EXISTS ( SELECT
                   name
                   FROM sys.procedures
                   WHERE name = 'proc_CT_RewardsDefinition_AddDeletedRecs') 
    BEGIN
        DROP PROCEDURE
             proc_CT_RewardsDefinition_AddDeletedRecs;
    END;
GO
CREATE PROCEDURE proc_CT_RewardsDefinition_AddDeletedRecs
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
                       FROM DIM_EDW_RewardsDefinition
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
                       FROM ##TEMP_EDW_RewardsDefinition_DATA )
                UPDATE S
                  SET
                      S.DeletedFlg = 1
                  FROM CTE AS T JOIN DIM_EDW_RewardsDefinition AS S
                       ON
                       S.SiteGUID = T.SiteGUID
                   AND S.AccountID = T.AccountID
                   AND S.AccountCD = T.AccountCD
                   AND S.RewardProgramGUID = T.RewardProgramGUID
                   AND S.RewardGroupGuid = T.RewardGroupGuid
                   AND S.RewardLevelGuid = T.RewardLevelGuid
                   AND S.RewardActivityGuid = T.RewardActivityGuid
                   AND S.RewardTriggerGuid = T.RewardTriggerGuid
                   AND S.RewardTriggerParmGUID = T.RewardTriggerParmGUID AND S.DeletedFlg is null;

    DECLARE
    @iInserts AS int = @@ROWCOUNT;

    update DIM_EDW_RewardsDefinition set LastModifiedDate = getdate() where LastModifiedDate is null and DeletedFlg is NOT null ;

    PRINT 'Deleted Record Count: ' + CAST ( @iInserts AS nvarchar (50)) ;
    RETURN @iInserts;
END;

GO
PRINT 'Executed proc_CT_RewardsDefinition_AddDeletedRecs.sql';
GO
