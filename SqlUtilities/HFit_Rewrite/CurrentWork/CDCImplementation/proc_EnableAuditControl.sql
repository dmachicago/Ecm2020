
GO
PRINT 'executing proc_EnableAuditControl.sql;';
GO
IF EXISTS (SELECT
                  name
                  FROM sys.procedures
                  WHERE name = 'proc_EnableAuditControl') 
    BEGIN
        DROP PROCEDURE
             proc_EnableAuditControl;
    END;

GO
CREATE PROCEDURE proc_EnableAuditControl
AS
BEGIN

    DECLARE @DB nvarchar (100) = DB_NAME () ;
    DECLARE @S nvarchar (2000) = '';
    DECLARE @TrgName  nvarchar (100) = '';
    DECLARE @TBL  nvarchar (100) = '';

    IF NOT EXISTS (SELECT
                          database_id
                          FROM sys.change_tracking_databases
                          WHERE database_id = DB_ID (@DB)) 
        BEGIN
            SET @S = 'ALTER DATABASE ' + @DB + ' SET CHANGE_TRACKING = ON (CHANGE_RETENTION = 2 DAYS, AUTO_CLEANUP = ON) ';
            EXEC (@S) ;
            PRINT 'TURNED ON CHANGE TRACKING FOR: ' + @@ServerName + ' and Database ' + DB_NAME () ;
        END;
    ELSE
        BEGIN
            PRINT 'CHANGE TRACKING IS ACTIVE FOR: ' + @@ServerName + ' and Database ' + DB_NAME () ;
        END;

    EXEC proc_ChangeTracking 'hfit_ppteligibility', 1;
    EXEC proc_ChangeTracking 'CMS_Class', 1;
    EXEC proc_ChangeTracking 'CMS_Document', 1;
    EXEC proc_ChangeTracking 'CMS_Site', 1;
    EXEC proc_ChangeTracking 'CMS_Tree', 1;
    EXEC proc_ChangeTracking 'cms_user', 1;
    EXEC proc_ChangeTracking 'cms_usersettings', 1;
    EXEC proc_ChangeTracking 'cms_usersite', 1;
    --EXEC proc_ChangeTracking 'COM_SKU', 1;

    PRINT 'Enabeling Audit Control Triggers on server ' + @@ServerName + ' and Database ' + DB_NAME () ;

    SET @TBL = 'CMS_User';
    SET @TrgName = 'trig_INS_CMS_User_Audit';
    IF EXISTS (SELECT
                      name
                      FROM sys.triggers
                      WHERE name = @TrgName) 
        BEGIN
            PRINT 'Enabled Trigger: ' + @TrgName;
            SET @S = 'ENABLE TRIGGER ' + @TrgName + ' ON ' + @TBL;
            EXEC (@S) ;
        END;
    ELSE
        BEGIN
            PRINT @TrgName + ' does not exist.';
        END;

    SET @TBL = 'CMS_UserSettings';
    SET @TrgName = 'trig_INS_CMS_UserSettings_Audit';
    IF EXISTS (SELECT
                      name
                      FROM sys.triggers
                      WHERE name = @TrgName) 
        BEGIN
            PRINT 'Enabled Trigger: ' + @TrgName;
            SET @S = 'ENABLE TRIGGER ' + @TrgName + ' ON ' + @TBL;
            EXEC (@S) ;
        END;
    ELSE
        BEGIN
            PRINT @TrgName + ' does not exist.';
        END;

    SET @TBL = 'CMS_UserSite';
    SET @TrgName = 'trig_INS_CMS_UserSite_Audit';
    IF EXISTS (SELECT
                      name
                      FROM sys.triggers
                      WHERE name = @TrgName) 
        BEGIN
            PRINT 'Enabled Trigger: ' + @TrgName;
            SET @S = 'ENABLE TRIGGER ' + @TrgName + ' ON ' + @TBL;
            EXEC (@S) ;
        END;
    ELSE
        BEGIN
            PRINT @TrgName + ' does not exist.';
        END;

    SET @TBL = 'HFIT_PPTEligibility';
    SET @TrgName = 'trig_UPDT_HFIT_PPTEligibility_Audit';
    IF EXISTS (SELECT
                      name
                      FROM sys.triggers
                      WHERE name = @TrgName) 
        BEGIN
            PRINT 'Enabled Trigger: ' + @TrgName;
            SET @S = 'ENABLE TRIGGER ' + @TrgName + ' ON ' + @TBL;
            EXEC (@S) ;
        END;
    ELSE
        BEGIN
            PRINT @TrgName + ' does not exist.';
        END;

END;
GO
EXEC proc_EnableAuditControl;
GO
PRINT 'executing proc_EnableAuditControl.sq;';
GO