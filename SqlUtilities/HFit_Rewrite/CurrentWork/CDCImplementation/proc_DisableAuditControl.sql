

GO
PRINT 'Executing proc_DisableAuditControl.sql';
GO
IF EXISTS (SELECT
                  name
                  FROM sys.procedures
                  WHERE name = 'proc_DisableAuditControl') 
    BEGIN
        DROP PROCEDURE
             proc_DisableAuditControl;
    END;
GO

-- exec proc_DisableAuditControl
CREATE PROCEDURE proc_DisableAuditControl
AS
BEGIN
    DECLARE @DB nvarchar (100) = DB_NAME () ;
    DECLARE @S nvarchar (2000) = '';
    DECLARE @TrgName  nvarchar (100) = '';
    DECLARE @TBL  nvarchar (100) = '';

    PRINT 'ONLY TRIIGERS WIL BE DISABLED for Audit Control, no Change Tracking Tables will be modified.';

    SET @TBL = 'CMS_User';
    SET @TrgName = 'trig_INS_CMS_User_Audit';
    IF EXISTS (SELECT
                      name
                      FROM sys.triggers
                      WHERE name = @TrgName) 
        BEGIN
            SET @S = 'DISABLE TRIGGER ' + @TrgName + ' ON ' + @TBL;
            EXEC (@S) ;
            PRINT 'TRIGGER ' + @TrgName + ' ON ' + @TBL + ', DISABLED';
        END;

    SET @TBL = 'CMS_UserSettings';
    SET @TrgName = 'trig_INS_CMS_UserSettings_Audit';
    IF EXISTS (SELECT
                      name
                      FROM sys.triggers
                      WHERE name = @TrgName) 
        BEGIN
            SET @S = 'DISABLE TRIGGER ' + @TrgName + ' ON ' + @TBL;
            EXEC (@S) ;
            PRINT 'TRIGGER ' + @TrgName + ' ON ' + @TBL + ', DISABLED';
        END;

    SET @TBL = 'CMS_UserSite';
    SET @TrgName = 'trig_INS_CMS_UserSite_Audit';
    IF EXISTS (SELECT
                      name
                      FROM sys.triggers
                      WHERE name = @TrgName) 
        BEGIN
            SET @S = 'DISABLE TRIGGER ' + @TrgName + ' ON ' + @TBL;
            EXEC (@S) ;
            PRINT 'TRIGGER ' + @TrgName + ' ON ' + @TBL + ', DISABLED';
        END;

    SET @TBL = 'HFIT_PPTEligibility';
    SET @TrgName = 'trig_UPDT_HFIT_PPTEligibility_Audit';
    IF EXISTS (SELECT
                      name
                      FROM sys.triggers
                      WHERE name = @TrgName) 
        BEGIN
            SET @S = 'DISABLE TRIGGER ' + @TrgName + ' ON ' + @TBL;
            EXEC (@S) ;
            PRINT 'TRIGGER ' + @TrgName + ' ON ' + @TBL + ', DISABLED';
        END;

END;
GO
PRINT 'Executed proc_DisableAuditControl.sql';
GO
