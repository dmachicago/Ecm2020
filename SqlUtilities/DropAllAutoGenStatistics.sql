SELECT DISTINCT 'DROP STATISTICS '
+ QUOTENAME(SCHEMA_NAME(ob.Schema_id)) + '.'
+ QUOTENAME(OBJECT_NAME(s.object_id)) + '.' +
QUOTENAME(s.name) +char(10) +'GO' DropStatisticsStatement
FROM sys.stats s
INNER JOIN sys.Objects ob ON ob.Object_id = s.object_id
WHERE SCHEMA_NAME(ob.Schema_id) <> 'sys'
AND Auto_Created = 1