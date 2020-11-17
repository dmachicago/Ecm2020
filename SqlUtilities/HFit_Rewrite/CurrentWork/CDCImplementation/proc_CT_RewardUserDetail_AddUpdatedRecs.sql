
GO
PRINT 'Executing proc_CT_RewardUserDetail_AddUpdatedRecs.sql';
GO
IF EXISTS ( SELECT
                   name
                   FROM sys.procedures
                   WHERE name = 'proc_CT_RewardUserDetail_AddUpdatedRecs') 
    BEGIN
        DROP PROCEDURE
             proc_CT_RewardUserDetail_AddUpdatedRecs;
    END;
GO
CREATE PROCEDURE proc_CT_RewardUserDetail_AddUpdatedRecs
AS
BEGIN

    DECLARE
       @RUNDATE AS  datetime2 ( 7 ) = GETDATE ( );

    UPDATE S
      SET
          S.RewardProgramName = T.RewardProgramName
          ,S.RewardModifiedDate = T.RewardModifiedDate
          ,S.RewardLevelModifiedDate = T.RewardLevelModifiedDate
          ,S.LevelCompletedDt = T.LevelCompletedDt
          ,S.ActivityPointsEarned = T.ActivityPointsEarned
          ,S.ActivityCompletedDt = T.ActivityCompletedDt
          ,S.RewardActivityModifiedDate = T.RewardActivityModifiedDate
          ,S.ActivityPoints = T.ActivityPoints
          ,S.UserAccepted = T.UserAccepted
          ,S.UserExceptionAppliedTo = T.UserExceptionAppliedTo
          ,S.ChangeType = T.ChangeType
          ,S.HashCode = T.HashCode
          ,S.LastModifiedDate = GETDATE ( )
          ,S.RewardExceptionModifiedDate = T.RewardExceptionModifiedDate
          ,S.ConvertedToCentralTime = NULL
      FROM ##Temp_RewardUserDetail AS T JOIN DIM_EDW_RewardUserDetail AS S
           ON
           S.UserGUID = T.UserGUID
       AND S.AccountID = T.AccountID
       AND S.AccountCD = T.AccountCD
       AND S.SiteGUID = T.SiteGUID
       AND S.HFitUserMpiNumber = T.HFitUserMpiNumber
           --AND S.RewardGroupGUID = T.RewardGroupGUID
       AND S.RewardActivityGUID = T.RewardActivityGUID
       AND S.RewardTriggerGUID = T.RewardTriggerGUID
       AND S.HASHCODE != T.HASHCODE
       AND S.LastModifiedDate IS NULL;

    DECLARE
    @iInserts AS int = @@ROWCOUNT;
    PRINT 'Updated Record Count: ' + CAST ( @iInserts AS nvarchar (50)) ;
    RETURN @iInserts;
END;

GO
PRINT 'Executed proc_CT_RewardUserDetail_AddUpdatedRecs.sql';
GO
