
GO
PRINT 'Executing proc_CT_Coaching_AddNewRecs.sql';
GO
IF EXISTS ( SELECT
                   name
              FROM sys.procedures
              WHERE name = 'proc_CT_Coaching_AddNewRecs' )
    BEGIN
        DROP PROCEDURE
             proc_CT_Coaching_AddNewRecs;
    END;
GO
CREATE PROCEDURE proc_CT_Coaching_AddNewRecs
AS
BEGIN

    WITH CTE (
         UserGUID
         ,SiteGUID
         ,AccountID
         ,AccountCD
         ,CoachID
         ,email
    )
        AS (
        SELECT
               UserGUID
               ,isnull(SiteGUID,'00000000-0000-0000-0000-000000000000') 
               ,isnull(AccountID,' ')
               ,isnull(AccountCD, ' ' )
               ,isnull(CoachID,-1)
               ,email
          FROM ##DIM_TEMPTBL_EDW_Coaches_DATA
        EXCEPT
        SELECT
               UserGUID
               ,isnull(SiteGUID,'00000000-0000-0000-0000-000000000000') 
               ,isnull(AccountID,' ')
               ,isnull(AccountCD, ' ' )
               ,isnull(CoachID,-1)
               ,email
          FROM DIM_EDW_Coaches
          WHERE LastModifiedDate IS NULL
        )
        INSERT INTO dbo.DIM_EDW_Coaches
        (
               UserGUID
               ,SiteGUID
               ,AccountID
               ,AccountCD
               ,CoachID
               ,LastName
               ,FirstName
               ,StartDate
               ,Phone
               ,email
               ,Supervisor
               ,SuperCoach
               ,MaxParticipants
               ,Inactive
               ,MaxRiskLevel
               ,Locked
               ,TimeLocked
               ,terminated
               ,APMaxParticipants
               ,RNMaxParticipants
               ,RNPMaxParticipants
               ,Change_Type
               ,Last_Update_Dt
               ,HashCode
               ,LastModifiedDate
               ,DeletedFlg
        )
        SELECT
               T.UserGUID
               ,T.SiteGUID
               ,T.AccountID
               ,T.AccountCD
               ,T.CoachID
               ,T.LastName
               ,T.FirstName
               ,T.StartDate
               ,T.Phone
               ,T.email
               ,T.Supervisor
               ,T.SuperCoach
               ,T.MaxParticipants
               ,T.Inactive
               ,T.MaxRiskLevel
               ,T.Locked
               ,T.TimeLocked
               ,T.terminated
               ,T.APMaxParticipants
               ,T.RNMaxParticipants
               ,T.RNPMaxParticipants
               ,T.Change_Type
               ,T.Last_Update_Dt
               ,T.HashCode
               ,NULL AS LastModifiedDate
               ,NULL AS DeletedFlg
          FROM
               ##DIM_TEMPTBL_EDW_Coaches_DATA AS T JOIN
                    CTE AS S
                                                    ON
               S.UserGUID = T.UserGUID
           AND ISNULL( S.SiteGUID , '00000000-0000-0000-0000-000000000000' ) = ISNULL( T.SiteGUID , '00000000-0000-0000-0000-000000000000' )
           AND ISNULL( S.AccountID , '' ) = ISNULL( T.AccountID , '' )
           AND ISNULL( S.AccountCD , '' ) = ISNULL( T.AccountCD , '' )
           AND ISNULL( S.CoachID , -1 ) = ISNULL( T.CoachID , -1 )
           AND S.email = T.email;

    DECLARE
       @iInserts AS int = @@ROWCOUNT;
    PRINT 'Insert Count: ' + CAST ( @iInserts AS nvarchar( 50 ));
    RETURN @iInserts;
END;

GO
PRINT 'Executed proc_CT_Coaching_AddNewRecs.sql';
GO
