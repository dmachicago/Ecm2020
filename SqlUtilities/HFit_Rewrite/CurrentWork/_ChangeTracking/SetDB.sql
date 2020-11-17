
--****************************************************************
-- NOTE: This database name must be changed in MANY places in 
--	this script. Please search and change.
--****************************************************************

PRINT 'FROM SetDB.sql';
PRINT 'Attached to DATABASE ' + DB_NAME () ;
DECLARE @CurrDB AS nvarchar (250) = DB_NAME () ;
DECLARE @MSQL AS nvarchar (250) = 'USE ' + @CurrDB;
EXEC (@MSQL) ;
GO

