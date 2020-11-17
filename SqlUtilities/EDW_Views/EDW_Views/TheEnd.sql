
--START ENDING THE IVP
GO

DECLARE @DBNAME nvarchar(100);
declare @ServerName nvarchar(80);
set @ServerName = (SELECT @@SERVERNAME ) ;
set @DBNAME = (SELECT DB_NAME() AS [Current Database]);

print ('--');
print ('*************************************************************************************************************');
print ('IVP Processing complete - please check for errors: on database ' + @DBNAME + ' : ON SERVER : '+ @ServerName + ' ON ' + cast(getdate() as nvarchar(50)));
print ('*************************************************************************************************************');
  --  
GO 
print('***** FROM: TheEnd.sql'); 
GO 
