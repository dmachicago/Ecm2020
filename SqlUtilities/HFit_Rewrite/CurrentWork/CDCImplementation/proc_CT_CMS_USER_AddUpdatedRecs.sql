
GO
PRINT 'Executing proc_CT_CMS_USER_AddUpdatedRecs.sql';
GO
IF EXISTS ( SELECT
                   name
                   FROM sys.procedures
                   WHERE name = 'proc_CT_CMS_USER_AddUpdatedRecs') 
    BEGIN
        DROP PROCEDURE
             proc_CT_CMS_USER_AddUpdatedRecs;
    END;
GO
/*----------------------------------------------------------------------------------------------------------------------------------------------------------
    select top 100 * from CMS_USER
    update CMS_USER set LastName = LastName where UserID in (select top 50 UserID from CMS_USER order by UserID )
    update CMS_USER set UserName = UserName where UserID in (select top 50 UserID from CMS_USER order by UserID desc)
    update CMS_USER set MiddleName = MiddleName where UserID in (select top 100 UserID from CMS_USER order by UserID desc)
    update CMS_USER set Email = Email,PreferredCultureCode = PreferredCultureCode where UserID in (select top 100 UserID from CMS_USER order by UserID desc)

    exec proc_CT_CMS_USER_AddUpdatedRecs

    select * from STAGING_CMS_USER where SYS_CHANGE_VERSION is not null
    select * from STAGING_CMS_USER_Update_History
*/

CREATE PROCEDURE proc_CT_CMS_USER_AddUpdatedRecs
AS
BEGIN
    WITH CTE (
         UserID
       , SYS_CHANGE_VERSION
       , SYS_CHANGE_OPERATION
       , SYS_CHANGE_COLUMNS) 
        AS ( SELECT
                    CT.UserID
                  , CT.SYS_CHANGE_VERSION
                  , CT.SYS_CHANGE_OPERATION
                  , SYS_CHANGE_COLUMNS
                    FROM CHANGETABLE (CHANGES CMS_USER, NULL) AS CT
                    WHERE SYS_CHANGE_OPERATION = 'U') 
        UPDATE S
               SET
                   S.UserName = T.UserName
                 ,S.FirstName = T.FirstName
                 ,S.MiddleName = T.MiddleName
                 ,S.LastName = T.LastName
                 ,S.FullName = T.FullName
                 ,S.Email = T.Email
                 ,S.UserPassword = T.UserPassword
                 ,S.PreferredCultureCode = T.PreferredCultureCode
                 ,S.PreferredUICultureCode = T.PreferredUICultureCode
                 ,S.UserEnabled = T.UserEnabled
                 ,S.UserIsEditor = T.UserIsEditor
                 ,S.UserIsGlobalAdministrator = T.UserIsGlobalAdministrator
                 ,S.UserIsExternal = T.UserIsExternal
                 ,S.UserPasswordFormat = T.UserPasswordFormat
                 ,S.UserCreated = T.UserCreated
                 ,S.LastLogon = T.LastLogon
                 ,S.UserStartingAliasPath = T.UserStartingAliasPath
                 ,S.UserGUID = T.UserGUID
                 ,S.UserLastModified = T.UserLastModified
                 ,S.UserLastLogonInfo = T.UserLastLogonInfo
                 ,S.UserIsHidden = T.UserIsHidden
                 ,S.UserVisibility = T.UserVisibility
                 ,S.UserIsDomain = T.UserIsDomain
                 ,S.UserHasAllowedCultures = T.UserHasAllowedCultures
                 ,S.UserSiteManagerDisabled = T.UserSiteManagerDisabled
                 ,S.UserPasswordBuffer = T.UserPasswordBuffer
                 ,S.UserTokenID = T.UserTokenID
                 ,S.UserMFRequired = T.UserMFRequired
                 ,S.UserTokenIteration = T.UserTokenIteration
                 ,S.LastModifiedDate = GETDATE () 
                 ,S.DeletedFlg = NULL
                 ,S.ConvertedToCentralTime = NULL
                 ,S.SYS_CHANGE_VERSION = CTE.SYS_CHANGE_VERSION
                   FROM STAGING_CMS_USER AS S
                            JOIN
                            CMS_USER AS T
                                ON
                                S.UserID = T.UserID
                            AND S.DeletedFlg IS NULL
                            JOIN CTE
                                ON CTE.Userid = T.UserID
                               AND (CTE.SYS_CHANGE_VERSION != S.SYS_CHANGE_VERSION
                                 OR S.SYS_CHANGE_VERSION IS NULL);

    DECLARE
    @iCnt AS int = @@ROWCOUNT;

    PRINT 'Updated Count: ' + CAST ( @iCnt AS nvarchar (50)) ;

    exec proc_CT_CMS_USER_History 'U'

    --WITH CTE (
    --     UserID
    --   , SYS_CHANGE_VERSION
    --   , SYS_CHANGE_COLUMNS) 
    --    AS ( SELECT
    --                CT.UserID
    --              , CT.SYS_CHANGE_VERSION
    --              , SYS_CHANGE_COLUMNS
    --                FROM CHANGETABLE (CHANGES CMS_USER, NULL) AS CT
    --                WHERE SYS_CHANGE_OPERATION = 'U'
    --         EXCEPT
    --         SELECT
    --                UserID
    --              , SYS_CHANGE_VERSION
    --              , SYS_CHANGE_COLUMNS
    --                FROM STAGING_CMS_USER_Update_History
    --    ) 
    --    INSERT INTO STAGING_CMS_USER_Update_History
    --    (
    --           UserID
    --         , LastModifiedDate
    --         , SVR
    --         , DBNAME
    --         , SYS_CHANGE_VERSION
    --         , SYS_CHANGE_COLUMNS
    --         , commit_time) 
    --    SELECT
    --           CTE.UserID
    --         , GETDATE () AS LastModifiedDate
    --         , @@SERVERNAME AS SVR
    --         , DB_NAME () AS DBNAME
    --         , CTE.SYS_CHANGE_VERSION
    --         , CTE.SYS_CHANGE_COLUMNS
    --         , isnull(tc.commit_time, getdate())
    --           FROM
    --               CTE
    --                   JOIN sys.dm_tran_commit_table AS tc
    --                       ON CTE.sys_change_version = tc.commit_ts;

    RETURN @iCnt;
END;

GO
PRINT 'Executed proc_CT_CMS_USER_AddUpdatedRecs.sql';
GO
 