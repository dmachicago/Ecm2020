
--START ENDING THE IVP
GO

DECLARE @DBNAME nvarchar (100) ;
DECLARE @ServerName nvarchar (80) ;
SET @ServerName = (SELECT
                          @@SERVERNAME);
SET @DBNAME = (SELECT
                      DB_NAME () AS [Current Database]);

IF @@TRANCOUNT > 0
    BEGIN
	   print 'OPEN Transaction Committed!!'
        COMMIT TRANSACTION
    END;

PRINT '--';
PRINT '*************************************************************************************************************';
PRINT 'IVP Processing complete - please check for errors: on database ' + @DBNAME + ' : ON SERVER : ' + @ServerName + ' ON ' + CAST (GETDATE () AS nvarchar (50)) ;
PRINT '*************************************************************************************************************';
--  
GO
PRINT '***** FROM: TheEnd.sql';
GO 
