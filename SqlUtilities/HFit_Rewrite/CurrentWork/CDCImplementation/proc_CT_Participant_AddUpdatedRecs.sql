
GO
PRINT 'Executing proc_CT_Participant_AddUpdatedRecs.sql';
GO
IF EXISTS ( SELECT
                   name
              FROM sys.procedures
              WHERE name = 'proc_CT_Participant_AddUpdatedRecs' )
    BEGIN
        DROP PROCEDURE
             proc_CT_Participant_AddUpdatedRecs;
    END;
GO
CREATE PROCEDURE proc_CT_Participant_AddUpdatedRecs
AS
BEGIN

    UPDATE S
      SET
          S.UserID = T.UserID
          ,S.UserGUID = T.UserGUID
          ,S.SiteGUID = T.SiteGUID
          ,S.AccountID = T.AccountID
          ,S.AccountCD = T.AccountCD
          ,S.HFitUserPreferredMailingAddress = T.HFitUserPreferredMailingAddress
          ,S.HFitUserPreferredMailingCity = T.HFitUserPreferredMailingCity
          ,S.HFitUserPreferredMailingState = T.HFitUserPreferredMailingState
          ,S.HFitUserPreferredMailingPostalCode = T.HFitUserPreferredMailingPostalCode
          ,S.HFitCoachingEnrollDate = T.HFitCoachingEnrollDate
          ,S.HFitUserAltPreferredPhone = T.HFitUserAltPreferredPhone
          ,S.HFitUserAltPreferredPhoneExt = T.HFitUserAltPreferredPhoneExt
          ,S.HFitUserAltPreferredPhoneType = T.HFitUserAltPreferredPhoneType
          ,S.HFitUserPreferredPhone = T.HFitUserPreferredPhone
          ,S.HFitUserPreferredFirstName = T.HFitUserPreferredFirstName
          ,S.HFitUserPreferredEmail = T.HFitUserPreferredEmail
          ,S.HFitUserRegistrationDate = T.HFitUserRegistrationDate
          ,S.HFitUserIsRegistered = T.HFitUserIsRegistered
          ,S.ChangeType = T.ChangeType
          ,S.UserCreated = T.UserCreated
          ,S.UserLastModified = T.UserLastModified
          ,S.Account_ItemModifiedWhen = T.Account_ItemModifiedWhen
          ,S.HashCode = T.HashCode
          ,S.LastModifiedDate = GETDATE ( )
          ,S.DeletedFlg = NULL
          ,S.ConvertedToCentralTime = NULL
      FROM DIM_EDW_Participant AS S JOIN
                ##TEMP_DIM_EDW_Participant_DATA AS T
                                        ON
           S.UserGUID = T.UserGUID
       AND S.SiteGUID = T.SiteGUID
       AND S.AccountID = T.AccountID
       AND S.AccountCD = T.AccountCD
      WHERE
           T.HashCode != S.HashCode
       AND S.LastModifiedDate IS NULL;

    DECLARE
       @iCnt AS int = @@ROWCOUNT;
    PRINT 'Updated Count: ' + CAST ( @iCnt AS nvarchar( 50 ));
    RETURN @iCnt;
END;

GO
PRINT 'Executed proc_CT_Participant_AddUpdatedRecs.sql';
GO
 