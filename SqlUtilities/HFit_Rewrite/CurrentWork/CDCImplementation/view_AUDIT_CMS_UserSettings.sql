

GO
PRINT 'EXECUTING view_AUDIT_CMS_UserSettings.SQL';
GO

IF EXISTS (SELECT
                  name
                  FROM sys.views
                  WHERE name = 'view_AUDIT_CMS_UserSettings') 
    BEGIN
        DROP VIEW
             view_AUDIT_CMS_UserSettings
    END;

GO

/*---------------------------------------------------
select * from STAGING_CMS_UserSettings
select * from STAGING_CMS_UserSettings_Update_History
select * from STAGING_CMS_UserSettings_Audit
*/
-- select * from view_AUDIT_CMS_UserSettings order by UserSettingsID
CREATE VIEW view_AUDIT_CMS_UserSettings
AS 
    SELECT DISTINCT
          A.SysUser
        , A.IPADDR
        , A.CreateDate
        , A.SYS_CHANGE_OPERATION
        , A.SYS_CHANGE_VERSION AS SysChangeVersion
        , S.*
          FROM
              STAGING_CMS_UserSettings_Audit AS A
                  JOIN STAGING_CMS_UserSettings AS S
                      ON S.UserSettingsID = A.UserSettingsID;

GO
PRINT 'EXECUTED view_AUDIT_CMS_UserSettings.SQL';
GO
