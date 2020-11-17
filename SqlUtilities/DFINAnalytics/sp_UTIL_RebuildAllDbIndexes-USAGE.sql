use [AW2016]
--use [DFINAnalytics]
exec sp_UTIL_RebuildAllDbIndexes


DECLARE @Tables TABLE ( 
  DatabaseName sysname, 
  SchemaName sysname, 
  TableName sysname 
);
INSERT INTO @Tables (DatabaseName, SchemaName, TableName) 
EXEC sp_msforeachdb 'select ''?'', s.name, t.name from [?].sys.tables t inner join [?].sys.schemas s on t.schema_id = s.schema_id';

SELECT * FROM @Tables ORDER BY 1, 2, 3;

