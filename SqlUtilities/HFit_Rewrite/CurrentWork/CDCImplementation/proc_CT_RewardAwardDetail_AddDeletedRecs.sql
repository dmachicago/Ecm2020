
GO
PRINT 'Executing proc_CT_RewardAwardDetail_AddDeletedRecs.sql';
GO
IF EXISTS ( SELECT
                   name
                   FROM sys.procedures
                   WHERE name = 'proc_CT_RewardAwardDetail_AddDeletedRecs') 
    BEGIN
        DROP PROCEDURE
             proc_CT_RewardAwardDetail_AddDeletedRecs;
    END;
GO
CREATE PROCEDURE proc_CT_RewardAwardDetail_AddDeletedRecs
AS
BEGIN

     WITH CTE (
         UserGUID
       , SiteGUID
       , HFitUserMpiNumber
       , RewardLevelGUID
       , AwardType
       , AwardDisplayName
       , RewardValue
       , ThresholdNumber
       , UserNotified
       , IsFulfilled
       , AccountID
       , AccountCD, DeletedFlg) 
        AS (
        SELECT
               UserGUID
             , SiteGUID
             , HFitUserMpiNumber
             , RewardLevelGUID
             , AwardType
             , AwardDisplayName
             , RewardValue
             , ThresholdNumber
             , UserNotified
             , IsFulfilled
             , AccountID
             , AccountCD
		  , isNUll(DeletedFlg, 0) as DeletedFlg
               FROM DIM_EDW_RewardAwardDetail
		  --WHERE DeletedFlg IS NULL
        EXCEPT
        SELECT
               UserGUID
             , SiteGUID
             , HFitUserMpiNumber
             , RewardLevelGUID
             , AwardType
             , AwardDisplayName
             , RewardValue
             , ThresholdNumber
             , UserNotified
             , IsFulfilled
             , AccountID
             , AccountCD
		  , 0 as DeletedFlg
	   FROM ##TEMP_EDW_RewardAwardDetail_DATA                              
        ) 
        UPDATE S
          SET
              S.DeletedFlg = 1, LastModifiedDate = getdate()
              FROM CTE AS T JOIN
              DIM_EDW_RewardAwardDetail AS S
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
                            S.AccountCD = T.AccountCD 
					   AND isNUll(S.DeletedFlg,0) = isNUll(T.DeletedFlg,0)
					   AND isNUll(S.DeletedFlg,0) = 0 ;

    DECLARE
    @iInserts AS int = @@ROWCOUNT;

    update DIM_EDW_RewardAwardDetail set LastModifiedDate = getdate() where LastModifiedDate is null and DeletedFlg is NOT null ;

    PRINT 'Deleted Record Count: ' + CAST ( @iInserts AS nvarchar (50)) ;
    RETURN @iInserts;
END;

GO
PRINT 'Executed proc_CT_RewardAwardDetail_AddDeletedRecs.sql';
GO
