

GO
PRINT 'Executing proc_ifExistCurrVersionNbr.sql';
GO

IF EXISTS (SELECT
                  name
                  FROM sys.procedures
                  WHERE
                  name = 'proc_ifExistCurrVersionNbr') 
    BEGIN
        DROP PROCEDURE
             proc_ifExistCurrVersionNbr
    END;
GO
CREATE PROCEDURE proc_ifExistCurrVersionNbr (
       @VersionTrackingTabl AS NVARCHAR (100) 
     ,@DBMS AS NVARCHAR (100) 
     , @CurrVerNo AS BIGINT) 
AS
BEGIN
    --*********************************************************************
    DECLARE
           @iCnt AS INT = 0;
    DECLARE
           @MySql AS NVARCHAR (1000) = '';
    SET @MySql = 'select count(*) from ' + @VersionTrackingTabl + ' where DBMS = ''' + @DBMS + ''' and SYS_CHANGE_VERSION = ' + CAST (@CurrVerNo AS NVARCHAR (50)) ;

    DECLARE
           @rowcount TABLE (
                           Value INT) ;
    INSERT INTO @rowcount
    EXEC (@MySql) ;

    SET @iCnt = (SELECT TOP 1
                        *
                        FROM @rowcount) ;
    IF @iCnt IS NULL
        BEGIN
            SET @iCnt = 0
        END;

    IF @iCnt > 0
        BEGIN
            PRINT 'Current Version already registered, returning.';
        END;
    RETURN @iCnt;
END;
GO
PRINT 'Executed proc_ifExistCurrVersionNbr.sql';
GO