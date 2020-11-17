DECLARE @sql NVARCHAR(MAX);
SET @sql = N'select cast(''master'' as sysname) as db_name, name collate Latin1_General_CI_AI, object_id, schema_id, cast(1 as int) as database_id  from master.sys.tables ';
SELECT @sql = @sql + N' union all select ' + QUOTENAME(name, '''') + ', name collate Latin1_General_CI_AI, object_id, schema_id, ' + CAST(database_id AS NVARCHAR(10)) + N' from ' + QUOTENAME(name) + N'.sys.tables'
FROM sys.databases
WHERE database_id > 1
      AND state = 0
      AND user_access = 0;
EXEC sp_executesql 
     @sql;