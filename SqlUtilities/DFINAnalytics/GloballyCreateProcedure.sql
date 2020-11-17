
/*
Developed W. Dale Miller 
Copyright @DMA, Ltd, July 26, 2012 all rights reserved.
Licensed under the MIT Open Code License
Free to --* USEas long as the copyright is retained in the code.
*/
/*
If you take a look at the below t-sql source code of the CreateProcedure, you will notice that :
It is reading the text or create code of the stored procedure into a nvarchar(max) parameter;
Then it creates a dynamic t-sql command code. This dynamic t-sql code has the following properties :
First it executes a "--* USEdatabasename;" syntax in order to change the executing database.
Later, it runs the create procedure command text by using the EXEC('sqlcommand') syntax.
The above part of the solution only creates the stored procedure on a given target database.
We have to manually specify the database name.
The solution of this problem is actually very easy by using the sp_MSForEachDB undocumented stored procedure.
All we have to do for a complete solution is as simple as calling the below sp_MSForEachDB command.

EXEC sp_MSForEachDB 'CreateProcedure ''[?]'', ''TestSpForAllDBs'''
As you see, the above t-sql sp_MSForEachDB statement will execute the CreateProcedure stored procedure on master database for each database in the MS SQLServer instance.
Each execution will have a different database name value for the @dbname parameter.
And this difference will enable us deploy our example sql stored procedure on every database on the SQL Server.
*/
/*
SELECT 'EXEC GloballyCreateProcedure ' + name + ', UTIL_CPU_BoundQry, 1;' FROM master.sys.databases where name not in ('ReportServer','ReportServerTempDB','master','msdb','model','tempdb' );

EXEC GloballyCreateProcedure AW2016, UTIL_CPU_BoundQry, 1;
EXEC GloballyCreateProcedure DFINAnalytics, UTIL_CPU_BoundQry, 1;
EXEC GloballyCreateProcedure K3, UTIL_CPU_BoundQry, 1;
EXEC GloballyCreateProcedure TestDB, UTIL_CPU_BoundQry, 1;
EXEC GloballyCreateProcedure AW2016, UTIL_CPU_BoundQry, 1
EXEC GloballyCreateProcedure AW2016, UTIL_IO_BoundQry, 1;

-- =======================================================
DECLARE @command varchar(1000);
SELECT  @command = 'EXEC dbo.GloballyCreateProcedure ?, UTIL_IO_BoundQry, 1;';
EXEC sp_MSforeachdb @command;
-- =======================================================

*/

-- drop PROC GloballyCreateProcedure
CREATE PROC GloballyCreateProcedure
(@dbname   SYSNAME, 
 @spname   SYSNAME, 
 @TestOnly BIT     = 1
)
AS
     SELECT @dbname = REPLACE(REPLACE(@dbname, '[', ''), ']', '');
     IF @dbname <> 'master'
 AND @dbname <> 'msdb'
 AND @dbname <> 'model'
 AND @dbname <> 'tempdb'
 AND @dbname <> 'ReportServer'
 AND @dbname <> 'ReportServerTempDB'
  BEGIN
 DECLARE @proc_text NVARCHAR(MAX);
 SELECT @proc_text = REPLACE([text], '''', '''''')
 FROM [sysobjects] o
    INNER JOIN [syscomments] c ON c.id = o.id
 WHERE o.type = 'P'
     AND o.name = @spname;
 IF @TestOnly = 1
   BEGIN
  PRINT '****** TEST ONLY IS ON ******';
  PRINT '****** DB: ' + @dbname + ' ******';
  PRINT @proc_text;
 END;
   ELSE
   BEGIN
  DECLARE @sql NVARCHAR(MAX);
  SET @sql = '--* USE' + @dbname + '; EXEC ('' ' + @proc_text + ''');';
  EXEC sp_Executesql 
     @sql;
 END;
     END;
GO
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
