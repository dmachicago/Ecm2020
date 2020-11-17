

GO
PRINT 'Executing proc_CT_Participant_AddDeletedRecs.sql';
GO
IF EXISTS ( SELECT
                   name
              FROM sys.procedures
              WHERE name = 'proc_CT_Participant_AddDeletedRecs' )
    BEGIN
        DROP PROCEDURE
             proc_CT_Participant_AddDeletedRecs;
    END;
GO
CREATE PROCEDURE proc_CT_Participant_AddDeletedRecs
AS
BEGIN

    WITH CTE (
         UserGUID ,
         SiteGUID ,
         AccountID ,
         AccountCD )
        AS ( SELECT
                    UserGUID ,
                    SiteGUID ,
                    AccountID ,
                    AccountCD
               FROM DIM_EDW_Participant
             EXCEPT
             SELECT
                    UserGUID ,
                    SiteGUID ,
                    AccountID ,
                    AccountCD
               FROM ##TEMP_DIM_EDW_Participant_DATA )
        UPDATE S
          SET
              S.DeletedFlg = 1
          FROM CTE AS T JOIN
                    DIM_EDW_Participant AS S
                        ON
               S.UserGUID = T.UserGUID
           AND S.SiteGUID = T.SiteGUID
           AND S.AccountID = T.AccountID
           AND S.AccountCD = T.AccountCD;

    DECLARE
       @iCnt AS int = @@ROWCOUNT;
    PRINT 'Updated Count: ' + CAST ( @iCnt AS nvarchar( 50 ));
    RETURN @iCnt;
END;

GO
PRINT 'Executed proc_CT_Participant_AddDeletedRecs.sql';
GO
