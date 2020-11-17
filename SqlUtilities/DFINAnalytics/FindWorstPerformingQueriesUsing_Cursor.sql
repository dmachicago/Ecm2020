--* USEDFINAnalytics;
go
/*
alter table dbo..DFS_IO_BoundQry2000 add RowNbr int identity (1,1) not null;
alter table dbo..DFS_CPU_BoundQry2000 add RowNbr int identity (1,1) not null;
*/

/*
--truncate table DFS_IO_BoundQry2000;
--truncate table DFS_CPU_BoundQry2000;
declare @stmt nvarchar(100) = '--* USE?; exec UTIL_CPU_BoundQry2000 ; exec UTIL_IO_BoundQry2000 ;'
exec sp_msForEachDB @stmt ;
select top 10 * from [dbo].[DFS_IO_BoundQry2000] order by RowNbr desc;
select top 10 * from  [dbo].[DFS_CPU_BoundQry2000] order by RowNbr desc;
*/

begin try
	drop TABLE #cmds
end try
begin catch
	print '#cmds cleaned out...';
end catch
CREATE TABLE #cmds
(cmd NVARCHAR(4000)
);
DECLARE @Preview AS INT= 0;
DECLARE @DB_Name VARCHAR(100);
DECLARE @Command NVARCHAR(200);
DECLARE @msg NVARCHAR(200);
DECLARE database_cursor CURSOR
FOR SELECT name
    FROM   MASTER.sys.sysdatabases
    WHERE  STATUS = 65536
    ORDER BY name;
OPEN database_cursor;
FETCH NEXT FROM database_cursor INTO @DB_Name;
WHILE @@FETCH_STATUS = 0
    BEGIN 
 --set @msg = 'Processing : ' +  @DB_name;
 --exec dbo..printimmediate @msg;
 SELECT @Command = '--* USE' + @DB_name;
 INSERT INTO #cmds(cmd)
 VALUES    (@command);
 IF @Preview = 0 EXEC sp_executesql @Command;
 set  @Command = 'exec UTIL_IO_BoundQry2000 ';
 INSERT INTO #cmds(cmd) VALUES    (@command);
 IF @Preview = 0 EXEC sp_executesql  @Command;
 set  @Command = 'exec UTIL_CPU_BoundQry2000 ';
 INSERT INTO #cmds(cmd) VALUES    (@command);
 IF @Preview = 0 EXEC sp_executesql  @Command;
 FETCH NEXT FROM database_cursor INTO @DB_Name;
    END;
CLOSE database_cursor; 
DEALLOCATE database_cursor;
IF @Preview = 1
    SELECT *
    FROM   #cmds;

