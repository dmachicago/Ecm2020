
/*
select top 100 * from CMS_UserSettings
update CMS_UserSettings set UserNickNAme = null where UserSettingsID in (select top 100 UserSettingsID from CMS_UserSettings order by UserSettingsID desc) and UserNickName is null
*/

GO
-- use KenticoCMS_Prod1

/*---------------------------------------
Developer  : W. Dale Miller
05.28.2015 : WDM - completed unit testing
*/

GO
PRINT 'creating proc_STAGING_EDW_CMS_UserSettings';
PRINT GETDATE () ;
GO

IF EXISTS ( SELECT
                   name
                   FROM sys.procedures
                   WHERE name = 'proc_STAGING_EDW_CMS_UserSettings') 
    BEGIN
        PRINT 'UPDATING proc_STAGING_EDW_CMS_UserSettings';
        DROP PROCEDURE
             proc_STAGING_EDW_CMS_UserSettings;
    END;

GO

-- exec proc_STAGING_EDW_CMS_UserSettings

CREATE PROCEDURE proc_STAGING_EDW_CMS_UserSettings (
     @ReloadAll AS int = 0) 
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE
    @iTotal AS bigint = 0;

    EXEC @iTotal = proc_QuickRowCount 'STAGING_CMS_UserSettings';

    IF @iTotal <= 1
        BEGIN
            SET @Reloadall = 1;
        END;

    --******************************************************************************************************************************
    -- This procedure is added to the job job_EDW_GetStagingData_RewardUserDetail and set to run automatically on a schedule.
    --******************************************************************************************************************************

    BEGIN

        IF @ReloadAll IS NULL
            BEGIN
                SET @ReloadAll = 0;
            END;

        DECLARE
        @RecordID AS uniqueidentifier = NEWID () ;
        DECLARE
        @CT_DateTimeNow AS datetime = GETDATE () ;
        DECLARE
        @CT_NAME AS nvarchar ( 50) = 'proc_STAGING_EDW_CMS_UserSettings';
        EXEC proc_EDW_CT_ExecutionLog_Update @RecordID , @CT_NAME , @CT_DateTimeNow , 0 , 'I';

        IF @ReloadAll = 1
            BEGIN
                PRINT 'RELOADING ALL Change Tracking CMS_UserSettings records';
                EXEC proc_Create_Table_STAGING_CMS_UserSettings ;
                PRINT 'RELOAD COMPLETE';
            END;
        ELSE
            BEGIN
                EXEC proc_CT_CMS_UserSettings_AddNewRecs ;
                EXEC proc_CT_CMS_UserSettings_AddUpdatedRecs ;
                EXEC proc_CMS_UserSettings_AddDeletedRecs ;
            END;

    END;
END;

GO
PRINT 'CREATED proc_STAGING_EDW_CMS_UserSettings';
PRINT GETDATE () ;
GO