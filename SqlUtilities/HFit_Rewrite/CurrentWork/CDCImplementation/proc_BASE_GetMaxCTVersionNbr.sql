

GO
PRINT 'Executing proc_BASE_GetMaxCTVersionNbr.SQL';
GO
IF EXISTS (SELECT
                  name
                  FROM sys.procedures
                  WHERE
                  name = 'proc_BASE_GetMaxCTVersionNbr') 
    BEGIN
        DROP PROCEDURE
             proc_BASE_GetMaxCTVersionNbr;
    END;
GO

/*--------------------------------------------------------------------------------------------------------------
select max(SYS_CHANGE_VERSION) from BASE_CMS_Site_CTVerHIST Where DBMS = 'KenticoCMS_1'
select top 100 * from KenticoCMS_1.dbo.CMS_Document
select top 100 * from BASE_CMS_Site
Update BASE_CMS_Site set SiteIsOffLine = NULL where SiteID = 29
exec proc_BASE_GetMaxCTVersionNbr 'BASE_CMS_Site_CTVerHIST', KenticoCMS_1
CREATE PROCEDURE proc_BASE_GetMaxCTVersionNbr (@DBMS AS nvarchar (100), @VersionTrackingTabl AS nvarchar (100)) 
*/

CREATE PROCEDURE proc_BASE_GetMaxCTVersionNbr (
       @VersionTrackingTabl AS NVARCHAR (100) 
     , @DBMS AS NVARCHAR (100)) 
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
    --print @last_sync_version ;
    RETURN @last_sync_version;
END;
GO
PRINT 'Executed proc_BASE_GetMaxCTVersionNbr.SQL';
GO
