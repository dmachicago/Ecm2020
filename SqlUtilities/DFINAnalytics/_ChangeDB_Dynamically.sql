--**************************************************
--If the ultimate goal is to execute some other 
--dynamic SQL inside the chosen database, this is 
--easy enough:

DECLARE @db sysname = N'AW2016';
DECLARE @exec nvarchar(max) = QUOTENAME(@db) + N'.sys.sp_executesql',
 @sql  nvarchar(max) = N'SELECT DB_NAME(), ;';
EXEC @exec @sql;
go

--**************************************************
--If you need to pass parameters, no problem:
--**************************************************

DECLARE @db sysname = N'TestDB', @i int = 99;
DECLARE @exec nvarchar(max) = QUOTENAME(@db) + N'.sys.sp_executesql',
 @sql  nvarchar(max) = N'SELECT DB_NAME(), @i;';
EXEC @exec @sql, N'@i int', @i;
go

--*******************************************************
--If the goal is to execute some static SQL OR SP 
--inside the chosen database, maybe consider 
--storing that static SQL in a stored procedure in 
--an ownerdatabase, and generating it dynamically 
--like this:
--*******************************************************
go
if exists (select 1 from sys.procedures where name = 'spDemoDBContext')
drop procedure spDemoDBContext ;
go
create procedure spDemoDBContext 
as
	print 'PROC EXECUTING THRU DATABASE: ' + db_name() + ' on ' + cast(getdate() as nvarchar(50));
go

declare @rc as int = 0 ;
exec @rc = dbo._CreateTempProc 'spDemoDBContext';
print '---> @rc = ' + cast(@rc as nvarchar(10));
DECLARE @db sysname = N'AW2016';
DECLARE @msg nvarchar(150) = 'My message: ' + cast(getdate() as nvarchar(50));
DECLARE @exec nvarchar(max) = QUOTENAME(@db) + N'.sys.sp_executesql',
 @sql  nvarchar(max) = N'EXEC #spDemoDBContext;';
EXEC @exec @sql;
print 'CALLED FROM DB: ' + db_name();