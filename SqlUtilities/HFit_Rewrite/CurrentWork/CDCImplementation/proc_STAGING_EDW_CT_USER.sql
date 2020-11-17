

GO
-- use KenticoCMS_Prod1

/*---------------------------------------
Developer  : W. Dale Miller
05.28.2015 : WDM - completed unit testing
*/

GO
PRINT 'creating proc_STAGING_EDW_CT_USER';
PRINT GETDATE () ;
GO

IF EXISTS ( SELECT
                   name
                   FROM sys.procedures
                   WHERE name = 'proc_STAGING_EDW_CT_USER') 
    BEGIN
        PRINT 'UPDATING proc_STAGING_EDW_CT_USER';
        DROP PROCEDURE
             proc_STAGING_EDW_CT_USER;
    END;

GO

-- exec proc_STAGING_EDW_CT_USER

CREATE PROCEDURE proc_STAGING_EDW_CT_USER (
     @ReloadAll AS int = 0) 
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE
    @iTotal AS bigint = 0;

    EXEC @iTotal = proc_QuickRowCount 'STAGING_cms_user';

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
        @CT_NAME AS nvarchar ( 50) = 'proc_STAGING_EDW_CT_USER';
        EXEC proc_EDW_CT_ExecutionLog_Update @RecordID , @CT_NAME , @CT_DateTimeNow , 0 , 'I';

        IF @ReloadAll = 1
            BEGIN
                PRINT 'RELOADING ALL Change Tracking CT_USER records';
                EXEC proc_Create_Table_STAGING_cms_user ;
                PRINT 'RELOAD COMPLETE';
            END;
        ELSE
            BEGIN
                EXEC proc_CT_CMS_User_AddNewRecs ;
                EXEC proc_CT_CMS_USER_AddUpdatedRecs ;
                EXEC proc_CMS_User_AddDeletedRecs ;
            END;

    END;
END;

GO
PRINT 'CREATED proc_STAGING_EDW_CT_USER';
PRINT GETDATE () ;
GO