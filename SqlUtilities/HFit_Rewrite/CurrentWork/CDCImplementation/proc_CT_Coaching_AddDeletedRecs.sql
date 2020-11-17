
GO
PRINT 'Executing proc_CT_Coaching_AddDeletedRecs.sql';
GO
IF EXISTS ( SELECT
                   name
              FROM sys.procedures
              WHERE name = 'proc_CT_Coaching_AddDeletedRecs' )
    BEGIN
        DROP PROCEDURE
             proc_CT_Coaching_AddDeletedRecs;
    END;
GO
CREATE PROCEDURE proc_CT_Coaching_AddDeletedRecs
AS
BEGIN

    WITH CTE (
         UserGUID
         ,SiteGUID
         ,AccountID
         ,AccountCD
         ,CoachID
         ,email )
        AS (
        SELECT
               UserGUID
               ,isnull(SiteGUID,'00000000-0000-0000-0000-000000000000') 
               ,isnull(AccountID,' ')
               ,isnull(AccountCD, ' ' )
               ,isnull(CoachID,-1)
               ,email
          FROM DIM_EDW_Coaches
        EXCEPT
        SELECT
               UserGUID
               ,isnull(SiteGUID,'00000000-0000-0000-0000-000000000000') 
               ,isnull(AccountID,' ')
               ,isnull(AccountCD, ' ' )
               ,isnull(CoachID,-1)
               ,email
          FROM ##DIM_TEMPTBL_EDW_Coaches_DATA
        )
        UPDATE S
          SET
              S.DeletedFlg = 1
          FROM CTE AS T JOIN
                    DIM_EDW_Coaches AS S
                        ON
               S.UserGUID = T.UserGUID
           AND ISNULL( S.SiteGUID , '00000000-0000-0000-0000-000000000000' ) = ISNULL( T.SiteGUID , '00000000-0000-0000-0000-000000000000' )
           AND ISNULL( S.AccountID , '' ) = ISNULL( T.AccountID , '' )
           AND ISNULL( S.AccountCD , '' ) = ISNULL( T.AccountCD , '' )
           AND ISNULL( S.CoachID , -1 ) = ISNULL( T.CoachID , -1 )
           AND S.email = T.email;

    DECLARE
       @idels AS int = @@ROWCOUNT;
    PRINT 'Deleted Count: ' + CAST ( @idels  AS nvarchar( 50 ));
    RETURN @idels;
END;

GO
PRINT 'Executed proc_CT_Coaching_AddDeletedRecs.sql';
GO
