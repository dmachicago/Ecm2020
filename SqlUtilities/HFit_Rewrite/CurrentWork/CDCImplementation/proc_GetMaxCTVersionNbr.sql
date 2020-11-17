
-- Use KenticoCMS_Datamart_2
GO
PRINT 'Executing proc_GetMaxCTVersionNbr.SQL';
GO
IF EXISTS (SELECT
                  name
           FROM sys.procedures
           WHERE
                  name = 'proc_GetMaxCTVersionNbr') 
    BEGIN
        DROP PROCEDURE
             proc_GetMaxCTVersionNbr;
    END;
GO

/*************************************************************************************************************
--------------------------------------------------------------------------------------------------------------
select max(SYS_CHANGE_VERSION) from BASE_CMS_Site_CTVerHIST Where DBMS = 'KenticoCMS_1'
select top 100 * from KenticoCMS_1.dbo.CMS_Document
select top 100 * from BASE_CMS_Site
Update BASE_CMS_Site set SiteIsOffLine = NULL where SiteID = 29
exec proc_GetMaxCTVersionNbr 'BASE_HFit_HealthAssesmentUserStarted_CTVerHIST', KenticoCMS_1, 1
CREATE PROCEDURE proc_GetMaxCTVersionNbr (@DBMS AS nvarchar (100), @VersionTrackingTabl AS nvarchar (100)) 
*************************************************************************************************************/

CREATE PROCEDURE proc_GetMaxCTVersionNbr (
       @VersionTrackingTabl AS NVARCHAR (100) 
     , @DBMS AS NVARCHAR (100) 
     , @DisplayVerNo AS BIT = 0) 
AS
BEGIN
    DECLARE
    @last_sync_version AS BIGINT = -1;
    DECLARE
    @MySql AS NVARCHAR (1000) = 'select max(SYS_CHANGE_VERSION) from ' + @VersionTrackingTabl + ' Where DBMS = ''' + @DBMS + '''';
    --print @MySql ;
    DECLARE
    @result TABLE (
                  LastVerNo BIGINT) ;
    INSERT INTO @result (
           LastVerNo) 
    EXEC (@MySql) ;
    SET @last_sync_version = (SELECT TOP (1) 
                                     LastVerNo
                              FROM @result) ;
    IF @last_sync_version IS NULL
        BEGIN
            SET @last_sync_version = 0;
        END;
    ELSE
        BEGIN
            --WDM Added the below 3/15/2016
            PRINT 'PREV Lassync:' + CAST (@last_sync_version AS NVARCHAR (50)) ;
            SET @last_sync_version = @last_sync_version - 1;
            PRINT 'USING Lassync:' + CAST (@last_sync_version AS NVARCHAR (50)) ;
        END;

    IF
           @DisplayVerNo = 1
        BEGIN
            PRINT @last_sync_version
        END;

    RETURN @last_sync_version;
END;
GO
PRINT 'Executed proc_GetMaxCTVersionNbr.SQL';
GO
