
PRINT 'Executing proc_CT_CoachingDetail_AddNewRecs.sql';
go
IF EXISTS ( SELECT
                   name
              FROM sys.procedures
              WHERE name = 'proc_CT_CoachingDetail_AddNewRecs' )
    BEGIN
        DROP PROCEDURE
             proc_CT_CoachingDetail_AddNewRecs;
    END;
go
CREATE PROCEDURE proc_CT_CoachingDetail_AddNewRecs
AS
BEGIN

    WITH CTE (
         ItemGUID
         ,GoalID
         ,UserGUID
         ,SiteGUID
         ,AccountID
         ,AccountCD
         ,WeekendDate
         ,NodeGUID )
        AS ( SELECT
                    ISNULL( ItemGUID , '00000000-0000-0000-0000-000000000000' )
                    ,ISNULL( GoalID , -1 )
                    ,ISNULL( UserGUID , '00000000-0000-0000-0000-000000000000' )
                    ,ISNULL( SiteGUID , '00000000-0000-0000-0000-000000000000' )
                    ,ISNULL( AccountID , ' ' )
                    ,ISNULL( AccountCD , ' ' )
                    ,ISNULL( WeekendDate , '01/01/1900' )
                    ,ISNULL( NodeGUID , '00000000-0000-0000-0000-000000000000' )
               FROM ##TEMP_EDW_CoachingDetail_DATA
             EXCEPT
             SELECT
                    ISNULL( ItemGUID , '00000000-0000-0000-0000-000000000000' )
                    ,ISNULL( GoalID , -1 )
                    ,ISNULL( UserGUID , '00000000-0000-0000-0000-000000000000' )
                    ,ISNULL( SiteGUID , '00000000-0000-0000-0000-000000000000' )
                    ,ISNULL( AccountID , ' ' )
                    ,ISNULL( AccountCD , ' ' )
                    ,ISNULL( WeekendDate , '01/01/1900' )
                    ,ISNULL( NodeGUID , '00000000-0000-0000-0000-000000000000' )
               FROM DIM_EDW_CoachingDetail
               WHERE LastModifiedDate IS NULL )
        INSERT INTO dbo.DIM_EDW_CoachingDetail (
               ItemID
               ,ItemGUID
               ,GoalID
               ,UserID
               ,UserGUID
               ,HFitUserMpiNumber
               ,SiteGUID
               ,AccountID
               ,AccountCD
               ,AccountName
               ,IsCreatedByCoach
               ,BaselineAmount
               ,GoalAmount
               ,DocumentID
               ,GoalStatusLKPID
               ,GoalStatusLKPName
               ,EvaluationStartDate
               ,EvaluationEndDate
               ,GoalStartDate
               ,CoachDescription
               ,EvaluationDate
               ,Passed
               ,WeekendDate
               ,ChangeType
               ,ItemCreatedWhen
               ,ItemModifiedWhen
               ,NodeGUID
               ,CloseReasonLKPID
               ,CloseReason
               ,HashCode
               ,LastModifiedDate
               ,DeletedFlg )
        SELECT
               T.ItemID
               ,T.ItemGUID
               ,T.GoalID
               ,T.UserID
               ,T.UserGUID
               ,T.HFitUserMpiNumber
               ,T.SiteGUID
               ,T.AccountID
               ,T.AccountCD
               ,T.AccountName
               ,T.IsCreatedByCoach
               ,T.BaselineAmount
               ,T.GoalAmount
               ,T.DocumentID
               ,T.GoalStatusLKPID
               ,T.GoalStatusLKPName
               ,T.EvaluationStartDate
               ,T.EvaluationEndDate
               ,T.GoalStartDate
               ,T.CoachDescription
               ,T.EvaluationDate
               ,T.Passed
               ,T.WeekendDate
               ,T.ChangeType
               ,T.ItemCreatedWhen
               ,T.ItemModifiedWhen
               ,T.NodeGUID
               ,T.CloseReasonLKPID
               ,T.CloseReason
               ,T.HashCode
               ,NULL AS LastModifiedDate
               ,NULL AS DeletedFlg
          FROM
               ##TEMP_EDW_CoachingDetail_DATA AS T JOIN
                    CTE AS S
                                                           ON
               ISNULL( S.ItemGUID , '00000000-0000-0000-0000-000000000000' ) = ISNULL( T.ItemGUID , '00000000-0000-0000-0000-000000000000' )
           AND ISNULL( S.GoalID , -1 ) = ISNULL( T.GoalID , -1 )
           AND ISNULL( S.UserGUID , '00000000-0000-0000-0000-000000000000' ) = ISNULL( T.UserGUID , '00000000-0000-0000-0000-000000000000' )
           AND ISNULL( S.SiteGUID , '00000000-0000-0000-0000-000000000000' ) = ISNULL( T.SiteGUID , '00000000-0000-0000-0000-000000000000' )
           AND ISNULL( S.AccountID , ' ' ) = ISNULL( T.AccountID , ' ' )
           AND ISNULL( S.AccountCD , ' ' ) = ISNULL( T.AccountCD , ' ' )
           AND ISNULL( S.WeekendDate , '01/01/1900' ) = ISNULL( T.WeekendDate , '01/01/1900' )
           AND ISNULL( S.NodeGUID , '00000000-0000-0000-0000-000000000000' ) = ISNULL( T.NodeGUID , '00000000-0000-0000-0000-000000000000' );

    DECLARE
       @iInserts AS int = @@ROWCOUNT;
    PRINT 'Insert Count: ' + CAST ( @iInserts AS nvarchar( 50 ));
    RETURN @iInserts;
END;

go
PRINT 'Executed proc_CT_CoachingDetail_AddNewRecs.sql';
go
