

GO
PRINT 'Executing proc_CMS_UserSettings_AddDeletedRecs.sql';
GO
IF EXISTS ( SELECT
                   name
                   FROM sys.procedures
                   WHERE name = 'proc_CMS_UserSettings_AddDeletedRecs') 
    BEGIN
        DROP PROCEDURE
             proc_CMS_UserSettings_AddDeletedRecs;
    END;
GO
/*
    SELECT TOP 100 * FROM CMS_UserSettings
    DELETE FROM CMS_UserSettings where UserSettingsID = 20174
    EXEC proc_CMS_UserSettings_AddDeletedRecs
*/
CREATE PROCEDURE proc_CMS_UserSettings_AddDeletedRecs 
AS
BEGIN

    UPDATE STAGING_CMS_UserSettings
           SET
               DeletedFlg = 1
             ,LastModifiedDate = GETDATE () 
    WHERE
          UserSettingsID IN
          (SELECT
                  UserSettingsID
                  FROM CHANGETABLE (CHANGES CMS_UserSettings, NULL) AS CT
                  WHERE SYS_CHANGE_OPERATION = 'D') 
      AND DeletedFlg IS NULL;

    DECLARE
    @iCnt AS int = @@ROWCOUNT;
    PRINT 'Deleted Count: ' + CAST ( @iCnt AS nvarchar (50)) ;
    RETURN @iCnt;
END;

GO
PRINT 'Executed proc_CMS_UserSettings_AddDeletedRecs.sql';
GO
