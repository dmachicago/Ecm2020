

GO
PRINT 'Executing proc_FACT_SaveCurrCTVersionNbr.SQL';
GO
IF EXISTS (SELECT
                  name
                  FROM sys.procedures
                  WHERE name = 'proc_FACT_SaveCurrCTVersionNbr') 
    BEGIN
        DROP PROCEDURE
             proc_FACT_SaveCurrCTVersionNbr;
    END;
GO
-- select count(*) from FACT_CMS_User_CTVerHIST  where DBMS = 'XXXX' and SYS_CHANGE_VERSION = 12
-- select * from FACT_CMS_User_CTVerHIST 
-- exec proc_FACT_SaveCurrCTVersionNbr 'XXXX', 'CMS_User', 12
CREATE PROCEDURE proc_FACT_SaveCurrCTVersionNbr (
     @DBMS AS nvarchar (100) 
   , @TblName AS nvarchar (100) 
   , @CurrVerNo AS bigint) 
AS
BEGIN

    --declare @DBMS as nvarchar (100) = 'XXXX' ;
    --declare @TblName as nvarchar (100) = 'CMS_User' ;  
    --declare @CurrVerNo as bigint = 111 ;
    DECLARE @VersionTrackingTabl AS nvarchar (250) = 'FACT_' + @TblName + '_CTVerHIST ';
    DECLARE @last_sync_version AS bigint = -1;

    DECLARE @iCnt AS int = 0;
    DECLARE  @MySql AS nvarchar (1000) = '';
    SET @MySql = 'select count(*) from ' + @VersionTrackingTabl + ' where DBMS = ''' + @DBMS + ''' and SYS_CHANGE_VERSION = ' + CAST (@CurrVerNo AS nvarchar (50)) ;

    DECLARE @rowcount TABLE (
                            Value int) ;
    INSERT INTO @rowcount
    EXEC (@MySql) ;

    SET @iCnt = (SELECT TOP 1
                        *
                        FROM @rowcount);

    IF @iCnt > 0
        BEGIN
            PRINT 'Current Version already registered, returning.';
            RETURN;
        END;

    PRINT @MySql;
    SET @MySql = 'Insert into ' + @VersionTrackingTabl + ' (DBMS, SYS_CHANGE_VERSION) values (''' + @DBMS + ''',' + CAST (@CurrVerNo AS nvarchar (50)) + ')';
    PRINT @MySql;
    EXEC (@MySql) ;

END;
GO
PRINT 'Executed proc_FACT_SaveCurrCTVersionNbr.SQL';
GO