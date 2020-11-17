DECLARE @DB_Name varchar(100) 
DECLARE @Command nvarchar(200) 
DECLARE @msg nvarchar(200) 
DECLARE database_cursor CURSOR FOR 
SELECT name
FROM MASTER.sys.sysdatabases 
where status  = 65536
order by name ;

OPEN database_cursor 

FETCH NEXT FROM database_cursor INTO @DB_Name 

WHILE @@FETCH_STATUS = 0 
BEGIN 
	 set @msg = 'Processing : ' +  @DB_name;
	 exec sp_printimmediate @msg;
	 SELECT @Command = '--* USE' + @DB_name;
     EXEC sp_executesql @Command 

     SELECT @Command = 'exec UTIL_IO_BoundQry2000 '
     EXEC sp_executesql @Command 

     FETCH NEXT FROM database_cursor INTO @DB_Name 
END 

CLOSE database_cursor 
DEALLOCATE database_cursor 