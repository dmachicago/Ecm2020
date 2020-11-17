

GO
PRINT 'Executing proc_EnableBaseEmailNotifications.sql';
GO

IF EXISTS (SELECT name
                  FROM sys.procedures
                  WHERE name = 'proc_EnableBaseEmailNotifications') 
    BEGIN
        DROP PROCEDURE proc_EnableBaseEmailNotifications;
    END;
GO
-- exec proc_EnableBaseEmailNotifications
CREATE PROCEDURE proc_EnableBaseEmailNotifications
AS
BEGIN
    DECLARE @ProfileCnt AS int = ( SELECT count(*)
                                          FROM msdb.dbo.sysmail_profile);
    EXEC sp_configure 'show advanced options', 1;
    RECONFIGURE WITH OVERRIDE;
    EXEC sp_configure 'Database Mail XPs', 1;
    RECONFIGURE;

    BEGIN TRY

        IF @ProfileCnt = 0
            BEGIN
                EXECUTE msdb.dbo.sysmail_add_profile_sp
                @profile_name = 'MARTNotify',
                @description = 'Profile for sending Automated DATAMART Notifications';
            END;
    END TRY
    BEGIN CATCH
        PRINT 'NOTICE: MARTNotify may already exist.';
    END CATCH;

END;
GO
PRINT 'COMPLETED proc_EnableBaseEmailNotifications.sql';
GO
EXEC proc_EnableBaseEmailNotifications;
GO
PRINT 'Executed proc_EnableBaseEmailNotifications';
GO