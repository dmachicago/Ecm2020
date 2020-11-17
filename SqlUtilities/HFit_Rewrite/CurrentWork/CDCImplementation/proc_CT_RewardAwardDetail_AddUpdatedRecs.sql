
GO
PRINT 'Executing proc_CT_RewardAwardDetail_AddUpdatedRecs.sql';
GO
IF EXISTS ( SELECT
                   name
                   FROM sys.procedures
                   WHERE name = 'proc_CT_RewardAwardDetail_AddUpdatedRecs') 
    BEGIN
        DROP PROCEDURE
             proc_CT_RewardAwardDetail_AddUpdatedRecs;
    END;
GO
CREATE PROCEDURE proc_CT_RewardAwardDetail_AddUpdatedRecs
AS
BEGIN

    UPDATE S
      SET
          S.UserGUID = T.UserGUID
        ,S.SiteGUID = T.SiteGUID
        ,S.HFitUserMpiNumber = T.HFitUserMpiNumber
        ,S.RewardLevelGUID = T.RewardLevelGUID
        ,S.AwardType = T.AwardType
        ,S.AwardDisplayName = T.AwardDisplayName
        ,S.RewardValue = T.RewardValue
        ,S.ThresholdNumber = T.ThresholdNumber
        ,S.UserNotified = T.UserNotified
        ,S.IsFulfilled = T.IsFulfilled
        ,S.AccountID = T.AccountID
        ,S.AccountCD = T.AccountCD
        ,S.ChangeType = T.ChangeType
        ,S.HashCode = T.HashCode
        ,S.LastModifiedDate = GETDATE () 
        ,S.DeletedFlg = T.DeletedFlg
        ,S.ConvertedToCentralTime = NULL
          FROM DIM_EDW_RewardAwardDetail AS S JOIN
          ##TEMP_EDW_RewardAwardDetail_DATA AS T
                                                  ON
                                                  S.UserGUID = T.UserGUID AND
                                                  S.SiteGUID = T.SiteGUID AND
                                                  S.HFitUserMpiNumber = T.HFitUserMpiNumber AND
                                                  S.RewardLevelGUID = T.RewardLevelGUID AND
                                                  S.AwardType = T.AwardType AND
                                                  S.AwardDisplayName = T.AwardDisplayName AND
                                                  S.RewardValue = T.RewardValue AND
                                                  S.ThresholdNumber = T.ThresholdNumber AND
                                                  S.UserNotified = T.UserNotified AND
                                                  S.IsFulfilled = T.IsFulfilled AND
                                                  S.AccountID = T.AccountID AND
                                                  S.AccountCD = T.AccountCD AND
                                                  ISNULL (S.DeletedFlg , 0) = 0
           WHERE
                 T.HashCode != S.HashCode;

    DECLARE
    @iInserts AS int = @@ROWCOUNT;
    PRINT 'Updated Record Count: ' + CAST ( @iInserts AS nvarchar (50)) ;
    RETURN @iInserts;
END;

GO
PRINT 'Executed proc_CT_RewardAwardDetail_AddUpdatedRecs.sql';
GO
