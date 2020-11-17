
-- TEST_CMS_USER_CT.sql 

--drop table TEMP_CMS_USER_1000
IF NOT EXISTS (SELECT
                      name
                      FROM sys.tables
                      WHERE
                      name = 'TEMP_CMS_USER_1000') 
    BEGIN
        SELECT
               * INTO
                      TEMP_CMS_USER_1000
               FROM CMS_USER;
        CREATE UNIQUE CLUSTERED INDEX PI_TEMP_CMS_USER_1000 ON dbo.TEMP_CMS_USER_1000
        (
        UserID ASC
        );
    END;
GO

-- select top 100 * from CMS_USER
UPDATE CMS_USER
       SET
           MiddleName = 'NMN'
WHERE
      UserID IN (SELECT TOP 10000
                        UserID
                        FROM CMS_USER) 
  AND MiddleName IS NULL;

SELECT
       COUNT (*) 
--,CT.UserID
--, CT.SYS_CHANGE_VERSION
--, CT.SYS_CHANGE_OPERATION
       FROM CHANGETABLE (CHANGES CMS_USER, NULL) AS CT
       WHERE
       SYS_CHANGE_OPERATION = 'U';
SELECT
       COUNT (*) 
     , SYS_CHANGE_OPERATION
       FROM DIM_CMS_User_Audit
       GROUP BY
                SYS_CHANGE_OPERATION;

EXEC proc_STAGING_EDW_CT_USER;

ALTER TABLE CMS_Tree NOCHECK CONSTRAINT
            FK_CMS_Tree_NodeOwner_CMS_User;
ALTER TABLE CMS_UserSite NOCHECK CONSTRAINT
            FK_CMS_UserSite_UserID_CMS_User;
ALTER TABLE CMS_ACLItem NOCHECK CONSTRAINT
            FK_CMS_ACLItem_UserID_CMS_User;
ALTER TABLE CMS_ObjectVersionHistory NOCHECK CONSTRAINT
            FK_CMS_ObjectVersionHistory_VersionDeletedByUserID_CMS_User;
ALTER TABLE CMS_ObjectVersionHistory NOCHECK CONSTRAINT
            FK_CMS_ObjectVersionHistory_VersionModifiedByUserID_CMS_User;
ALTER TABLE CMS_WorkflowHistory NOCHECK CONSTRAINT
            FK_CMS_WorkflowHistory_ApprovedByUserID_CMS_User;
ALTER TABLE CMS_Document NOCHECK CONSTRAINT
            FK_CMS_Document_DocumentCheckedOutByUserID_CMS_User;
ALTER TABLE CMS_Document NOCHECK CONSTRAINT
            FK_CMS_Document_DocumentCreatedByUserID_CMS_User;
ALTER TABLE CMS_Document NOCHECK CONSTRAINT
            FK_CMS_Document_DocumentModifiedByUserID_CMS_User;
ALTER TABLE CMS_UserSettings NOCHECK CONSTRAINT
            FK_CMS_UserSettings_UserSettingsUserGUID_CMS_User;
ALTER TABLE CMS_UserSettings NOCHECK CONSTRAINT
            FK_CMS_UserSettings_UserSettingsUserID_CMS_User;
ALTER TABLE Media_File NOCHECK CONSTRAINT
            FK_Media_File_FileCreatedByUserID_CMS_User;
ALTER TABLE dbo.Media_File NOCHECK CONSTRAINT
            FK_Media_File_FileModifiedByUserID_CMS_User;
ALTER TABLE dbo.CMS_VersionHistory NOCHECK CONSTRAINT
            FK_CMS_VersionHistory_ModifiedByUserID_CMS_User;
ALTER TABLE dbo.Messaging_Message NOCHECK CONSTRAINT
            FK_Messaging_Message_MessageRecipientUserID_CMS_User;
ALTER TABLE dbo.Messaging_Message NOCHECK CONSTRAINT
            FK_Messaging_Message_MessageSenderUserID_CMS_User;

DELETE FROM CMS_USER
WHERE
      UserID IN (SELECT TOP 10
                        UserID
                        FROM CMS_USER) ;

ALTER TABLE CMS_Tree CHECK CONSTRAINT
            FK_CMS_Tree_NodeOwner_CMS_User;
ALTER TABLE CMS_UserSite CHECK CONSTRAINT
            FK_CMS_UserSite_UserID_CMS_User;
ALTER TABLE CMS_ACLItem CHECK CONSTRAINT
            FK_CMS_ACLItem_UserID_CMS_User;
ALTER TABLE CMS_ObjectVersionHistory CHECK CONSTRAINT
            FK_CMS_ObjectVersionHistory_VersionDeletedByUserID_CMS_User;
ALTER TABLE CMS_ObjectVersionHistory CHECK CONSTRAINT
            FK_CMS_ObjectVersionHistory_VersionModifiedByUserID_CMS_User;
ALTER TABLE CMS_WorkflowHistory CHECK CONSTRAINT
            FK_CMS_WorkflowHistory_ApprovedByUserID_CMS_User;
ALTER TABLE CMS_Document CHECK CONSTRAINT
            FK_CMS_Document_DocumentCheckedOutByUserID_CMS_User;
ALTER TABLE CMS_Document CHECK CONSTRAINT
            FK_CMS_Document_DocumentCreatedByUserID_CMS_User;
ALTER TABLE CMS_Document CHECK CONSTRAINT
            FK_CMS_Document_DocumentModifiedByUserID_CMS_User;
ALTER TABLE CMS_UserSettings CHECK CONSTRAINT
            FK_CMS_UserSettings_UserSettingsUserGUID_CMS_User;
ALTER TABLE CMS_UserSettings CHECK CONSTRAINT
            FK_CMS_UserSettings_UserSettingsUserID_CMS_User;
ALTER TABLE Media_File CHECK CONSTRAINT
            FK_Media_File_FileCreatedByUserID_CMS_User;
ALTER TABLE dbo.Media_File CHECK CONSTRAINT
            FK_Media_File_FileModifiedByUserID_CMS_User;
ALTER TABLE dbo.CMS_VersionHistory CHECK CONSTRAINT
            FK_CMS_VersionHistory_ModifiedByUserID_CMS_User;
ALTER TABLE dbo.Messaging_Message CHECK CONSTRAINT
            FK_Messaging_Message_MessageRecipientUserID_CMS_User;
ALTER TABLE dbo.Messaging_Message CHECK CONSTRAINT
            FK_Messaging_Message_MessageSenderUserID_CMS_User;

SELECT
       COUNT (*)	--,CT.UserID, CT.SYS_CHANGE_VERSION,CT.SYS_CHANGE_OPERATION
       FROM CHANGETABLE (CHANGES CMS_USER, NULL) AS CT
       WHERE
       SYS_CHANGE_OPERATION = 'D';
SELECT
       COUNT (*) 
     , SYS_CHANGE_OPERATION
       FROM DIM_CMS_User_Audit
       GROUP BY
                SYS_CHANGE_OPERATION;

EXEC proc_STAGING_EDW_CT_USER;

GO
SET IDENTITY_INSERT CMS_USER ON;
GO

WITH CTE (
     UserID) 
    AS (
    SELECT
           UserID
           FROM TEMP_CMS_USER_1000
    EXCEPT
    SELECT
           UserID
           FROM CMS_USER
    ) 
    INSERT INTO CMS_USER
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
         , UserTokenIteration) 
    SELECT
           CTE.UserID
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
           FROM
               TEMP_CMS_USER_1000
                   JOIN CTE
                       ON CTE.UserID = TEMP_CMS_USER_1000.UserID;

GO

SET IDENTITY_INSERT CMS_USER OFF;
GO

SELECT
       COUNT (*) 
--,CT.UserID
--, CT.SYS_CHANGE_VERSION
--, CT.SYS_CHANGE_OPERATION
       FROM CHANGETABLE (CHANGES CMS_USER, NULL) AS CT
       WHERE
       SYS_CHANGE_OPERATION = 'I';
SELECT
       COUNT (*) 
     , SYS_CHANGE_OPERATION
       FROM DIM_CMS_User_Audit
       GROUP BY
                SYS_CHANGE_OPERATION;

EXEC proc_STAGING_EDW_CT_USER;

GO

UPDATE CMS_USER
       SET
           MiddleName = NULL
WHERE
      MiddleName = 'NMN' ;

EXEC proc_STAGING_EDW_CT_USER;

SELECT
       *
       FROM view_AUDIT_CMS_USER
       WHERE UserID IN (
             SELECT TOP 100
                    UserID
                    FROM CMS_USER) 
       ORDER BY
                UserID;

SELECT
       *
       FROM STAGING_CMS_USER_Update_History;
