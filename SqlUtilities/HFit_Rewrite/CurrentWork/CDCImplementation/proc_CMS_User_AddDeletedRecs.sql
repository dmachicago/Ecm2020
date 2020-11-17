

GO
PRINT 'Executing proc_CMS_User_AddDeletedRecs.sql';
GO
IF EXISTS ( SELECT
                   name
                   FROM sys.procedures
                   WHERE name = 'proc_CMS_User_AddDeletedRecs') 
    BEGIN
        DROP PROCEDURE
             proc_CMS_User_AddDeletedRecs;
    END;
GO
CREATE PROCEDURE proc_CMS_User_AddDeletedRecs
AS
BEGIN

    UPDATE STAGING_cms_user
           SET
               DeletedFlg = 1
             ,LastModifiedDate = GETDATE () 
    WHERE
          UserID IN
          (SELECT
                  UserID
                  FROM CHANGETABLE (CHANGES CMS_USER, NULL) AS CT
                  WHERE SYS_CHANGE_OPERATION = 'D') 
      AND DeletedFlg IS NULL;

    DECLARE
    @iCnt AS int = @@ROWCOUNT;
    PRINT 'Deleted Count: ' + CAST ( @iCnt AS nvarchar (50)) ;

    exec proc_CT_CMS_USER_History 'D'

    RETURN @iCnt;
END;

GO
PRINT 'Executed proc_CMS_User_AddDeletedRecs.sql';
GO
