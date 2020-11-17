

GO
PRINT 'Executing sync_SurrogateKey_CMS_User.sql';
GO
IF EXISTS (SELECT
                  *
                  FROM   sys.procedures
                  WHERE  name = 'sync_SurrogateKey_CMS_User') 
    BEGIN
        PRINT 'Replacing function sync_SurrogateKey_CMS_User';
        DROP PROCEDURE
             sync_SurrogateKey_CMS_User;
    END;

GO
-- exec sync_SurrogateKey_CMS_User base_CMS_UserSettings, UserSettingsUserID
CREATE PROCEDURE sync_SurrogateKey_CMS_User (@ChildTblName nvarchar (250), @ChildColumnName varchar(250) = 'UserID' ) 
AS
BEGIN

    DECLARE
          @MySql AS nvarchar (max) = '';

begin try
    begin transaction TX1
    SET @MySql = 'UPDATE TGT ' + CHAR (10) ;
    SET @MySql = @MySql + 'SET TGT.SurrogateKey_cms_user = ISNULL (CMSUSER.SurrogateKey_cms_user , -999) ' + CHAR (10) ;
    SET @MySql = @MySql + 'FROM ' + @ChildTblName + ' TGT ' + CHAR (10) ;
    SET @MySql = @MySql + '     JOIN BASE_CMS_User CMSUSER ' + CHAR (10) ;
    SET @MySql = @MySql + '     ON CMSUSER.UserID = TGT.' + @ChildColumnName + CHAR (10) ;
    SET @MySql = @MySql + '    AND CMSUSER.DBNAME = TGT.DBNAME ' + CHAR (10) ;
    
    exec proc_DisableAllTableTriggers @ChildTblName ;

    execute PrintImmediate @MySql ;
    exec (@MySql) ;

    exec proc_EnableAllTableTriggers @ChildTblName ;
    commit transaction TX1
    end try
    begin catch 
	   rollback transaction TX1
	   print'FAILED: ' + @MySql ;
    end catch 
END;
GO
PRINT 'Executed sync_SurrogateKey_CMS_User.sql';
GO



