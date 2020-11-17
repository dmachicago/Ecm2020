
GO
-- USe KenticoCMS_Prod1

PRINT 'Executing proc_CT_CMS_User_AddNewRecs.sql';
GO
IF EXISTS ( SELECT
                   name
                   FROM sys.procedures
                   WHERE name = 'proc_CT_CMS_User_AddNewRecs') 
    BEGIN
        DROP PROCEDURE
             proc_CT_CMS_User_AddNewRecs;
    END;
GO
-- proc_CT_CMS_User_AddNewRecs
CREATE PROCEDURE proc_CT_CMS_User_AddNewRecs
AS
BEGIN

    SET IDENTITY_INSERT STAGING_cms_user ON;

    WITH CTE (
         UserID) 
        AS ( SELECT
                    UserID
                    FROM cms_user
             EXCEPT
             SELECT
                    UserID
                    FROM STAGING_cms_user
                    WHERE DeletedFlg IS NULL) 
        INSERT INTO STAGING_cms_user
        (
               UserID
             , UserName
             , FirstName
             , MiddleName
             , LastName
             , FullName
             , Email
             , UserPassword
             , PreferredCultureCode
             , PreferredUICultureCode
             , UserEnabled
             , UserIsEditor
             , UserIsGlobalAdministrator
             , UserIsExternal
             , UserPasswordFormat
             , UserCreated
             , LastLogon
             , UserStartingAliasPath
             , UserGUID
             , UserLastModified
             , UserLastLogonInfo
             , UserIsHidden
             , UserVisibility
             , UserIsDomain
             , UserHasAllowedCultures
             , UserSiteManagerDisabled
             , UserPasswordBuffer
             , UserTokenID
             , UserMFRequired
             , UserTokenIteration
             , LastModifiedDate
               --,[RowNbr]
             , DeletedFlg
             , TimeZone
             , ConvertedToCentralTime
             , SVR
             , DBNAME
             , SYS_CHANGE_VERSION) 
        SELECT
               T.UserID
             , T.UserName
             , T.FirstName
             , T.MiddleName
             , T.LastName
             , T.FullName
             , T.Email
             , T.UserPassword
             , T.PreferredCultureCode
             , T.PreferredUICultureCode
             , T.UserEnabled
             , T.UserIsEditor
             , T.UserIsGlobalAdministrator
             , T.UserIsExternal
             , T.UserPasswordFormat
             , T.UserCreated
             , T.LastLogon
             , T.UserStartingAliasPath
             , T.UserGUID
             , T.UserLastModified
             , T.UserLastLogonInfo
             , T.UserIsHidden
             , T.UserVisibility
             , T.UserIsDomain
             , T.UserHasAllowedCultures
             , T.UserSiteManagerDisabled
             , T.UserPasswordBuffer
             , T.UserTokenID
             , T.UserMFRequired
             , T.UserTokenIteration
             , GETDATE () AS LastModifiedDate
             , NULL AS DeletedFlg
             , NULL AS TimeZone
             , NULL AS ConvertedToCentralTime
             , @@SERVERNAME AS SVR
             , DB_NAME () AS DBNAME
             , NULL AS SYS_CHANGE_VERSION
               FROM
                   cms_user AS T
                       JOIN CTE AS S
                           ON S.UserID = T.UserID;
    DECLARE
    @iInserts AS int = @@ROWCOUNT;
    SET IDENTITY_INSERT STAGING_cms_user OFF;
    PRINT 'NEW Insert Count: ' + CAST ( @iInserts AS nvarchar (50)) ;

    exec proc_CT_CMS_USER_History 'I'

    RETURN @iInserts;
END;

GO
PRINT 'Executed proc_CT_CMS_User_AddNewRecs.sql';
GO
