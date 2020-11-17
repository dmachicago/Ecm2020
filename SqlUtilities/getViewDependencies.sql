SELECT
	   OBJECT_NAME (referencing_id) AS                                         referencing_entity_name
	 , o.type_desc AS                                                          referencing_desciption
	 --, COALESCE (COL_NAME (referencing_id, referencing_minor_id) , '(n/a)') AS referencing_minor_id
	 --, referencing_class_desc
	 --, referenced_class_desc
	 --, referenced_server_name
	 --, referenced_database_name
	 --, referenced_schema_name
	 , referenced_entity_name
	 --, COALESCE (COL_NAME (referenced_id, referenced_minor_id) , '(n/a)') AS   referenced_column_name
	 , is_caller_dependent
	 , is_ambiguous
	   FROM
			sys.sql_expression_dependencies AS sed INNER JOIN sys.objects AS o
					ON sed.referencing_id = o.object_id
	   WHERE referencing_id = OBJECT_ID (N'view_EDW_HealthAssesment') ;


SELECT
	   OBJECT_DEFINITION (OBJECT_ID ('view_EDW_HealthAssesment')) AS objectdefinition;
EXEC sp_helptext 'view_EDW_HealthAssesment';
EXEC sp_helptext 'sp_depends';
EXEC sp_depends 'view_EDW_HealthAssesment';
EXEC sp_depends 'View_EDW_HealthAssesmentQuestions';
SELECT
	   referencing_schema_name
	 , referencing_entity_name
	 , referencing_id
	 , referencing_class_desc
	 , is_caller_dependent
	   FROM sys.dm_sql_referencing_entities ('view_EDW_HealthAssesment', 'OBJECT') ;
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
