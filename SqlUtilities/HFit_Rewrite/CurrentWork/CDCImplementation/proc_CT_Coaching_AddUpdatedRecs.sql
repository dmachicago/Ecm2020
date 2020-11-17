

GO
PRINT 'Executing proc_CT_Coaching_AddUpdatedRecs.sql';
GO
IF EXISTS ( SELECT
                   name
              FROM sys.procedures
              WHERE name = 'proc_CT_Coaching_AddUpdatedRecs' )
    BEGIN
        DROP PROCEDURE
             proc_CT_Coaching_AddUpdatedRecs;
    END;
GO
CREATE PROCEDURE proc_CT_Coaching_AddUpdatedRecs
AS
BEGIN

    UPDATE S
      SET
          S.UserGUID = T.UserGUID
          ,S.SiteGUID = T.SiteGUID
          ,S.AccountID = T.AccountID
          ,S.AccountCD = T.AccountCD
          ,S.CoachID = T.CoachID
          ,S.LastName = T.LastName
          ,S.FirstName = T.FirstName
          ,S.StartDate = T.StartDate
          ,S.Phone = T.Phone
          ,S.email = T.email
          ,S.Supervisor = T.Supervisor
          ,S.SuperCoach = T.SuperCoach
          ,S.MaxParticipants = T.MaxParticipants
          ,S.Inactive = T.Inactive
          ,S.MaxRiskLevel = T.MaxRiskLevel
          ,S.Locked = T.Locked
          ,S.TimeLocked = T.TimeLocked
          ,S.terminated = T.terminated
          ,S.APMaxParticipants = T.APMaxParticipants
          ,S.RNMaxParticipants = T.RNMaxParticipants
          ,S.RNPMaxParticipants = T.RNPMaxParticipants
          ,S.Change_Type = T.Change_Type
          ,S.Last_Update_Dt = T.Last_Update_Dt
          ,S.HashCode = T.HashCode
          ,S.LastModifiedDate = GETDATE ( )
          ,S.DeletedFlg = NULL
          ,S.ConvertedToCentralTime = NULL
      FROM DIM_EDW_Coaches AS S JOIN
                ##DIM_TEMPTBL_EDW_Coaches_DATA AS T
                                    ON
           S.UserGUID = T.UserGUID
       AND ISNULL( S.SiteGUID , '00000000-0000-0000-0000-000000000000' ) = ISNULL( T.SiteGUID , '00000000-0000-0000-0000-000000000000' )
       AND ISNULL( S.AccountID , '' ) = ISNULL( T.AccountID , '' )
       AND ISNULL( S.AccountCD , '' ) = ISNULL( T.AccountCD , '' )
       AND ISNULL( S.CoachID , -1 ) = ISNULL( T.CoachID , -1 )
       AND S.email = T.email
      WHERE
           T.HashCode != S.HashCode
       AND S.DeletedFlg IS NULL;

    DECLARE
       @iUpdates AS int = @@ROWCOUNT;
    PRINT 'Updated Count: ' + CAST ( @iUpdates AS nvarchar( 50 ));
    RETURN @iUpdates;
END;

GO
PRINT 'Executed proc_CT_Coaching_AddUpdatedRecs.sql';
GO
