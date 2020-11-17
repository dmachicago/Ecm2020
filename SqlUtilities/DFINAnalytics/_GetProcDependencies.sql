
GO
if exists (select 1 from sys.procedures where name = '_GetProcDependencies')
	drop procedure _GetProcDependencies;
go
-- exec _GetProcDependencies 'UTIL_Process_QrysPlans'
create procedure _GetProcDependencies (@ProcName nvarchar(150))
as
begin
SELECT referencing_id, 
       OBJECT_SCHEMA_NAME(referencing_id) as RefSchema, 
	   OBJECT_NAME(referencing_id) AS ReferencingName, 
       obj.type_desc AS ReferencingType, 
       referenced_schema_name , 
	   referenced_entity_name AS referenced_object_name,
	   isnull((select type_desc from sys.objects where object_id = sed.referenced_id),'SP') as ReferencedType,
	   obj.is_ms_shipped
FROM sys.sql_expression_dependencies AS sed
          INNER JOIN sys.objects AS obj
          ON sed.referencing_id = obj.object_id
		  --ON sed.referenced_id = obj.object_id
WHERE referencing_id = OBJECT_ID(@ProcName)
and referenced_entity_name is not null 
order by referenced_entity_name;
end
go

if exists (Select 1 from INFORMATION_SCHEMA.tables where table_name = 'vProcDependencies')
	drop view vProcDependencies
go

/* USE:
SELECT referenced_object_name, ReferencedType 
FROM vProcDependencies 
WHERE ReferencingName = 'UTIL_QryPlanStats'
and ReferencedType = 'SP'
order by ReferencedType
*/

create view vProcDependencies
as
SELECT referencing_id, 
       OBJECT_SCHEMA_NAME(referencing_id) as RefSchema, 
	   OBJECT_NAME(referencing_id) AS ReferencingName, 
       obj.type_desc AS ReferencingType, 
       referenced_schema_name , 
	   referenced_entity_name AS referenced_object_name,
	   isnull((select type_desc from sys.objects where object_id = sed.referenced_id),'SP') as ReferencedType,
	   obj.is_ms_shipped
FROM sys.sql_expression_dependencies AS sed
          INNER JOIN sys.objects AS obj
          ON sed.referencing_id = obj.object_id
		  --ON sed.referenced_id = obj.object_id
and referenced_entity_name is not null ;

