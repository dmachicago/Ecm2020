
SELECT referenced_schema_name, referenced_entity_name,  
referenced_minor_name,referenced_minor_id, referenced_class_desc,  
is_caller_dependent, is_ambiguous  
FROM sys.dm_sql_referenced_entities ('dbo.UTIL_ListQueryAndBlocks', 'OBJECT');  

SELECT * FROM sys.dm_sql_referenced_entities ('dbo.DFS_IO_BoundQry2000', 'OBJECT');  

