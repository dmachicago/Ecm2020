
GO
PRINT 'Executing proc_CT_RewardUserDetail_AddNewRecs.sql';
GO
IF EXISTS ( SELECT
                   name
                   FROM sys.procedures
                   WHERE name = 'proc_CT_RewardUserDetail_AddNewRecs') 
    BEGIN
        DROP PROCEDURE
             proc_CT_RewardUserDetail_AddNewRecs;
    END;
GO
CREATE PROCEDURE proc_CT_RewardUserDetail_AddNewRecs
AS
BEGIN

    WITH CTE (
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
               WHERE DeletedFlg IS NULL
        ) 

        INSERT INTO dbo.DIM_EDW_RewardUserDetail
        (
              [UserGUID]
      ,[SiteGUID]
      ,[HFitUserMpiNumber]
      ,[RewardActivityGUID]
      ,[RewardProgramName]
      ,[RewardModifiedDate]
      ,[RewardLevelModifiedDate]
      ,[LevelCompletedDt]
      ,[ActivityPointsEarned]
      ,[ActivityCompletedDt]
      ,[RewardActivityModifiedDate]
      ,[ActivityPoints]
      ,[UserAccepted]
      ,[UserExceptionAppliedTo]
      ,[RewardTriggerGUID]
      ,[AccountID]
      ,[AccountCD]
      ,[ChangeType]
      ,[RewardExceptionModifiedDate]
      ,[HASHCODE]
      ,[LastModifiedDate]
      ,[RowNbr]
      ,[DeletedFlg]
      ,[TimeZone]
      ,[ConvertedToCentralTime]
        ) 
        SELECT
               T.[UserGUID]
      ,T.[SiteGUID]
      ,T.[HFitUserMpiNumber]
      ,T.[RewardActivityGUID]
      ,T.[RewardProgramName]
      ,T.[RewardModifiedDate]
      ,T.[RewardLevelModifiedDate]
      ,T.[LevelCompletedDt]
      ,T.[ActivityPointsEarned]
      ,T.[ActivityCompletedDt]
      ,T.[RewardActivityModifiedDate]
      ,T.[ActivityPoints]
      ,T.[UserAccepted]
      ,T.[UserExceptionAppliedTo]
      ,T.[RewardTriggerGUID]
      ,T.[AccountID]
      ,T.[AccountCD]
      ,T.[ChangeType]
      ,T.[RewardExceptionModifiedDate]
      ,T.[HASHCODE]
      ,null as [LastModifiedDate]
      ,null as [RowNbr]
      ,null as [DeletedFlg]
      ,null as [TimeZone]
      ,null as [ConvertedToCentralTime]
               FROM
                    ##Temp_RewardUserDetail AS T JOIN CTE AS S
                                                                  ON
							 S.UserGUID = T.UserGUID AND
							 S.SiteGUID = T.SiteGUID AND
							 S.HFitUserMpiNumber = T.HFitUserMpiNumber AND
							 S.RewardActivityGUID = T.RewardActivityGUID AND
							 S.RewardTriggerGUID = T.RewardTriggerGUID AND
							 S.AccountID = T.AccountID AND
							 S.AccountCD = T.AccountCD;

    DECLARE
    @iInserts AS int = @@ROWCOUNT;
    PRINT 'NEW Insert Count: ' + CAST ( @iInserts AS nvarchar (50)) ;
    RETURN @iInserts;
END;

GO
PRINT 'Executed proc_CT_RewardUserDetail_AddNewRecs.sql';
GO
