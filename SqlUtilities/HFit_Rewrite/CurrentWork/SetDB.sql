--****************************************************************
-- NOTE: This database name must be changed in MANY places in 
--	this script. Please search and change.
--****************************************************************
DECLARE @DBNAME nvarchar(100);
declare @ServerName nvarchar(80);
set @ServerName = (SELECT @@SERVERNAME ) ;
set @DBNAME = (SELECT DB_NAME() AS [Current Database]);

print ('***************************************************************************************************************************');
print ('Applying Updates to database ' + @DBNAME + ' : ON SERVER : '+ @ServerName + ' ON ' + cast(getdate() as nvarchar(50)));
print ('***************************************************************************************************************************');
go
  --  
  --  
GO 
print('***** FROM: SetDB.sql'); 
GO 
