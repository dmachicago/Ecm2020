

GO
PRINT 'Executing proc_CT_Participant_AddNewRecs.sql';
GO
IF EXISTS ( SELECT
                   name
              FROM sys.procedures
              WHERE name = 'proc_CT_Participant_AddNewRecs' )
    BEGIN
        DROP PROCEDURE
             proc_CT_Participant_AddNewRecs;
    END;
GO
CREATE PROCEDURE proc_CT_Participant_AddNewRecs
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
               FROM ##TEMP_DIM_EDW_Participant_DATA
             EXCEPT
             SELECT
                    UserGUID ,
                    SiteGUID ,
                    AccountID ,
                    AccountCD
               FROM DIM_EDW_Participant )
        INSERT INTO DIM_EDW_Participant
        (
               HFitUserMpiNumber
               ,UserID
               ,UserGUID
               ,SiteGUID
               ,AccountID
               ,AccountCD
               ,HFitUserPreferredMailingAddress
               ,HFitUserPreferredMailingCity
               ,HFitUserPreferredMailingState
               ,HFitUserPreferredMailingPostalCode
               ,HFitCoachingEnrollDate
               ,HFitUserAltPreferredPhone
               ,HFitUserAltPreferredPhoneExt
               ,HFitUserAltPreferredPhoneType
               ,HFitUserPreferredPhone
               ,HFitUserPreferredFirstName
               ,HFitUserPreferredEmail
               ,HFitUserRegistrationDate
               ,HFitUserIsRegistered
               ,ChangeType
               ,UserCreated
               ,UserLastModified
               ,Account_ItemModifiedWhen
               ,HashCode
               ,LastModifiedDate
               ,RowNbr
               ,DeletedFlg
               ,TimeZone
               ,ConvertedToCentralTime
        )
        SELECT
               T.HFitUserMpiNumber
               ,T.UserID
               ,T.UserGUID
               ,T.SiteGUID
               ,T.AccountID
               ,T.AccountCD
               ,T.HFitUserPreferredMailingAddress
               ,T.HFitUserPreferredMailingCity
               ,T.HFitUserPreferredMailingState
               ,T.HFitUserPreferredMailingPostalCode
               ,T.HFitCoachingEnrollDate
               ,T.HFitUserAltPreferredPhone
               ,T.HFitUserAltPreferredPhoneExt
               ,T.HFitUserAltPreferredPhoneType
               ,T.HFitUserPreferredPhone
               ,T.HFitUserPreferredFirstName
               ,T.HFitUserPreferredEmail
               ,T.HFitUserRegistrationDate
               ,T.HFitUserIsRegistered
               ,T.ChangeType
               ,T.UserCreated
               ,T.UserLastModified
               ,T.Account_ItemModifiedWhen
               ,T.HashCode
               ,NULL AS LastModifiedDate
               ,NULL AS RowNbr
               ,NULL AS DeletedFlg
               ,NULL AS TimeZone
               ,NULL AS ConvertedToCentralTime
          FROM
               ##TEMP_DIM_EDW_Participant_DATA AS T JOIN
                    CTE AS S
                                                        ON
               S.UserGUID = T.UserGUID
           AND S.SiteGUID = T.SiteGUID
           AND S.AccountID = T.AccountID
           AND S.AccountCD = T.AccountCD;

    DECLARE
       @iCnt AS int = @@ROWCOUNT;
    PRINT 'Inserted Count: ' + CAST ( @iCnt AS nvarchar( 50 ));
    RETURN @iCnt;
END;

GO
PRINT 'Executed proc_CT_Participant_AddNewRecs.sql';
GO
