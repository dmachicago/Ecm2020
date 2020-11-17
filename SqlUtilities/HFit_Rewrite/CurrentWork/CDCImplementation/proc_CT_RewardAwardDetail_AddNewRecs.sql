--use KenticoCMS_Prod1
GO
PRINT 'Executing proc_CT_RewardAwardDetail_AddNewRecs.sql';
GO
IF EXISTS ( SELECT
                   name
                   FROM sys.procedures
                   WHERE name = 'proc_CT_RewardAwardDetail_AddNewRecs') 
    BEGIN
        DROP PROCEDURE
             proc_CT_RewardAwardDetail_AddNewRecs;
    END;
GO

CREATE PROCEDURE proc_CT_RewardAwardDetail_AddNewRecs
AS
BEGIN

    WITH CTE_NEW (
         UserGUID
         ,AccountID
         ,AccountCD
         ,SiteGUID
         ,HFitUserMpiNumber
         ,RewardActivityGUID
         ,RewardTriggerGUID
    --, RewardGroupGUID
    )
        AS (
        SELECT
               UserGUID
               ,AccountID
               ,AccountCD
               ,SiteGUID
               ,HFitUserMpiNumber
               ,RewardActivityGUID
               ,RewardTriggerGUID
        --, RewardGroupGUID
          FROM ##Temp_RewardUserDetail
        EXCEPT
        SELECT
               UserGUID
               ,AccountID
               ,AccountCD
               ,SiteGUID
               ,HFitUserMpiNumber
               ,RewardActivityGUID
               ,RewardTriggerGUID
        --, RewardGroupGUID
          FROM DIM_EDW_RewardUserDetail
          WHERE LastModifiedDate IS NULL
        )
        INSERT INTO DIM_EDW_RewardUserDetail
        SELECT
               T.UserGUID
               ,T.SiteGUID
               ,T.HFitUserMpiNumber
               ,T.RewardActivityGUID
               ,T.RewardProgramName
               ,T.RewardModifiedDate
               ,T.RewardLevelModifiedDate
               ,T.LevelCompletedDt
               ,T.ActivityPointsEarned
               ,T.ActivityCompletedDt
               ,T.RewardActivityModifiedDate
               ,T.ActivityPoints
               ,T.UserAccepted
               ,T.UserExceptionAppliedTo
               ,T.RewardTriggerGUID
               ,T.AccountID
               ,T.AccountCD
               ,T.ChangeType
               ,T.RewardExceptionModifiedDate
               ,T.HASHCODE
               ,NULL AS LastModifiedDate
               ,NULL AS RowNbr
               ,NULL AS DeletedFlg
               ,NULL AS TimeZone
               ,NULL AS ConvertedToCentralTime
          FROM
               ##Temp_RewardUserDetail AS T JOIN CTE_NEW AS C
               ON
               C.UserGUID = T.UserGUID
           AND C.AccountID = T.AccountID
           AND C.AccountCD = T.AccountCD
           AND C.SiteGUID = T.SiteGUID
           AND C.HFitUserMpiNumber = T.HFitUserMpiNumber
           AND C.RewardActivityGUID = T.RewardActivityGUID
           AND C.RewardTriggerGUID = T.RewardTriggerGUID;
    

    DECLARE
    @iInserts AS int = @@ROWCOUNT;
    PRINT 'NEW Insert Count: ' + CAST ( @iInserts AS nvarchar (50)) ;
    RETURN @iInserts;
END;

GO
PRINT 'Executed proc_CT_RewardAwardDetail_AddNewRecs.sql';
GO
