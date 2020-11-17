
GO
PRINT 'Executing proc_CT_CoachingDetail_AddUpdatedRecs.sql';
GO
-- exec proc_CT_CoachingDetail_AddUpdatedRecs
IF EXISTS ( SELECT
                   name
                   FROM sys.procedures
                   WHERE name = 'proc_CT_CoachingDetail_AddUpdatedRecs') 
    BEGIN
        DROP PROCEDURE
             proc_CT_CoachingDetail_AddUpdatedRecs;
    END;
GO
CREATE PROCEDURE proc_CT_CoachingDetail_AddUpdatedRecs
AS
BEGIN

    UPDATE S
      SET
          S.ItemID = T.ItemID
        ,S.ItemGUID = T.ItemGUID
        ,S.GoalID = T.GoalID
        ,S.UserID = T.UserID
        ,S.UserGUID = T.UserGUID
        ,S.HFitUserMpiNumber = T.HFitUserMpiNumber
        ,S.SiteGUID = T.SiteGUID
        ,S.AccountID = T.AccountID
        ,S.AccountCD = T.AccountCD
        ,S.AccountName = T.AccountName
        ,S.IsCreatedByCoach = T.IsCreatedByCoach
        ,S.BaselineAmount = T.BaselineAmount
        ,S.GoalAmount = T.GoalAmount
        ,S.DocumentID = T.DocumentID
        ,S.GoalStatusLKPID = T.GoalStatusLKPID
        ,S.GoalStatusLKPName = T.GoalStatusLKPName
        ,S.EvaluationStartDate = T.EvaluationStartDate
        ,S.EvaluationEndDate = T.EvaluationEndDate
        ,S.GoalStartDate = T.GoalStartDate
        ,S.CoachDescription = T.CoachDescription
        ,S.EvaluationDate = T.EvaluationDate
        ,S.Passed = T.Passed
        ,S.WeekendDate = T.WeekendDate
        ,S.ChangeType = T.ChangeType
        ,S.ItemCreatedWhen = T.ItemCreatedWhen
        ,S.ItemModifiedWhen = T.ItemModifiedWhen
        ,S.NodeGUID = T.NodeGUID
        ,S.CloseReasonLKPID = T.CloseReasonLKPID
        ,S.CloseReason = T.CloseReason
        ,S.HashCode = T.HashCode
        ,S.RowNbr = NULL
        ,S.TimeZone = NULL
        ,S.LastModifiedDate = GETDATE () 
        ,S.DeletedFlg = NULL
        ,S.ConvertedToCentralTime = NULL
          FROM DIM_EDW_CoachingDetail AS S
                    JOIN ##TEMP_EDW_CoachingDetail_DATA AS T
                    ON
                    S.ItemGUID = T.ItemGUID AND
                    S.GoalID = T.GoalID AND
                    S.UserGUID = T.UserGUID AND
                    S.SiteGUID = T.SiteGUID AND
                    S.AccountID = T.AccountID AND
                    S.AccountCD = T.AccountCD AND
                    S.WeekendDate = T.WeekendDate AND
                    S.NodeGUID = T.NodeGUID

           WHERE
                 T.HashCode != S.HashCode AND
                 T.LastModifiedDate IS NULL;

    DECLARE
    @iCnt AS int = @@ROWCOUNT;
    PRINT 'Updated Count: ' + CAST ( @iCnt AS nvarchar (50)) ;
    RETURN @iCnt;
END;

GO
PRINT 'Executed proc_CT_CoachingDetail_AddUpdatedRecs.sql';
GO
