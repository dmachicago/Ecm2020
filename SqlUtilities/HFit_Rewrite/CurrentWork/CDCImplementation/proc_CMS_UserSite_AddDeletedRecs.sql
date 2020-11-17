

GO
PRINT 'Executing proc_CMS_UserSite_AddDeletedRecs.sql';
GO
IF EXISTS ( SELECT
                   name
                   FROM sys.procedures
                   WHERE name = 'proc_CMS_UserSite_AddDeletedRecs') 
    BEGIN
        DROP PROCEDURE
             proc_CMS_UserSite_AddDeletedRecs;
    END;
GO
CREATE PROCEDURE proc_CMS_UserSite_AddDeletedRecs
AS
BEGIN

    UPDATE STAGING_CMS_UserSite
           SET
               DeletedFlg = 1
             ,LastModifiedDate = GETDATE () 
    WHERE
          UserSiteID IN
          (SELECT
                  UserSiteID
                  FROM CHANGETABLE (CHANGES CMS_UserSite, NULL) AS CT
                  WHERE SYS_CHANGE_OPERATION = 'D') 
      AND DeletedFlg IS NULL;

    DECLARE
    @iCnt AS int = @@ROWCOUNT;
    PRINT 'Deleted Count: ' + CAST ( @iCnt AS nvarchar (50)) ;

    if @iCnt > 0
	   exec proc_CT_CMS_UserSite_History 'D' ;
    
    RETURN @iCnt;
END;

GO
PRINT 'Executed proc_CMS_UserSite_AddDeletedRecs.sql';
GO
