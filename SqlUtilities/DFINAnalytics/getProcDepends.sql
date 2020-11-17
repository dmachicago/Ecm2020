if exists (select 1 from sys.procedures where name = 'getProcDepends')
	drop procedure getProcDepends
go
create procedure getProcDepends
as 
begin
SELECT OBJECT_SCHEMA_NAME ( referencing_id ) AS referencing_schema_name,  
    OBJECT_NAME(referencing_id) AS referencing_entity_name,   
    o.type_desc AS referencing_desciption,   
    COALESCE(COL_NAME(referencing_id, referencing_minor_id), '(n/a)') AS referencing_minor_id,   
    referencing_class_desc, referenced_class_desc,  
    referenced_server_name, referenced_database_name, referenced_schema_name,  
    referenced_entity_name,   
    COALESCE(COL_NAME(referenced_id, referenced_minor_id), '(n/a)') AS referenced_column_name,  
    is_caller_dependent, is_ambiguous ,
	T.[type_desc]
FROM sys.sql_expression_dependencies AS sed  
INNER JOIN sys.objects AS o ON sed.referencing_id = o.object_id  
left outer join sys.tables T on T.object_id = referenced_id
--INNER JOIN sys.objects AS deps ON o.object_id  = object_id(referenced_entity_name)
WHERE referencing_id = OBJECT_ID(N'dbo.UTIL_ADD_DFS_QrysPlans')  
end