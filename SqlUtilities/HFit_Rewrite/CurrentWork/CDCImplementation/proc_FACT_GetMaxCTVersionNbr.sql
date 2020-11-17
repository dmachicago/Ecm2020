

GO
PRINT 'Executing proc_FACT_GetMaxCTVersionNbr.SQL';
GO
IF EXISTS (SELECT
                  name
                  FROM sys.procedures
                  WHERE name = 'proc_FACT_GetMaxCTVersionNbr') 
    BEGIN
        DROP PROCEDURE
             proc_FACT_GetMaxCTVersionNbr
    END;
GO
-- select top 100 * from KenticoCMS_1.dbo.CMS_Document
-- exec proc_FACT_GetMaxCTVersionNbr KenticoCMS_1, 'FACT_CMS_Document_CTVerHIST'
CREATE PROCEDURE proc_FACT_GetMaxCTVersionNbr (@DBMS AS nvarchar (100), @VersionTrackingTabl AS nvarchar (100)) 
AS
BEGIN
    DECLARE @last_sync_version AS bigint = -1;
    DECLARE  @MySql AS nvarchar (1000) = 'select max(SYS_CHANGE_VERSION) from FACT_CMS_Document_CTVerHIST Where DBMS = ''' + @DBMS + '''';

    DECLARE @result TABLE (
                          LastVerNo bigint) ;
    INSERT INTO @result (
           LastVerNo) 
    EXEC (@MySql) ;
    SET @last_sync_version = (SELECT TOP (1) 
                                     LastVerNo
                                     FROM @result);
    if @last_sync_version is null
	   set @last_sync_version = 0 ;

    RETURN @last_sync_version;
END;
GO
PRINT 'Executed proc_FACT_GetMaxCTVersionNbr.SQL';
GO
