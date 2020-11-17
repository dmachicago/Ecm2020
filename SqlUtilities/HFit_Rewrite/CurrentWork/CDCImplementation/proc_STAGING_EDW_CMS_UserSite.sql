
/*-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
select top 100 * from CMS_UserSite
update CMS_UserSite set UserNickNAme = null where UserSettingsID in (select top 100 UserSettingsID from CMS_UserSite order by UserSettingsID desc) and UserNickName is null
*/

GO
-- use KenticoCMS_Prod1

/*---------------------------------------
Developer  : W. Dale Miller
05.28.2015 : WDM - completed unit testing
*/

GO
PRINT 'creating proc_STAGING_EDW_CMS_UserSite';
PRINT GETDATE () ;
GO

IF EXISTS ( SELECT
                   name
                   FROM sys.procedures
                   WHERE name = 'proc_STAGING_EDW_CMS_UserSite') 
    BEGIN
        PRINT 'UPDATING proc_STAGING_EDW_CMS_UserSite';
        DROP PROCEDURE
             proc_STAGING_EDW_CMS_UserSite;
    END;

GO

-- exec proc_STAGING_EDW_CMS_UserSite

CREATE PROCEDURE proc_STAGING_EDW_CMS_UserSite (
     @ReloadAll AS int = 0) 
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE
    @iTotal AS bigint = 0;

    EXEC @iTotal = proc_QuickRowCount 'STAGING_CMS_UserSite';

    IF @iTotal <= 1
        BEGIN
            SET @Reloadall = 1;
        END;

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
        @CT_NAME AS nvarchar ( 50) = 'proc_STAGING_EDW_CMS_UserSite';
        EXEC proc_EDW_CT_ExecutionLog_Update @RecordID , @CT_NAME , @CT_DateTimeNow , 0 , 'I';

        IF @ReloadAll = 1
            BEGIN
                PRINT 'RELOADING ALL Change Tracking CMS_UserSite records';
                EXEC proc_Create_Table_STAGING_CMS_UserSite ;
                PRINT 'RELOAD COMPLETE';
            END;
        ELSE
            BEGIN
                EXEC proc_CT_CMS_UserSite_AddNewRecs ;
                EXEC proc_CT_CMS_UserSite_AddUpdatedRecs ;
                EXEC proc_CMS_UserSite_AddDeletedRecs ;
            END;

    END;
END;

GO
PRINT 'CREATED proc_STAGING_EDW_CMS_UserSite';
PRINT GETDATE () ;
GO