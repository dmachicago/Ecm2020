alter proc wdmFindTablesInViews @TBL nvarchar(80)
as
SELECT
	--****************************************************************
	--W. Dale Miller - March 2009
	--Find objects referneced within other objects.
	--In this instance, I needed to find tables referenced in views.
	--To get all references of an object's use, remove the AND
	--portion of the WHERE clause.
	--USE: exec wdmFindTablesInViews 'CMS_Tree'
	--****************************************************************
	referencing_schema_name = SCHEMA_NAME(o.SCHEMA_ID),
	referencing_object_name = o.name,
	referencing_object_type_desc = o.type_desc,
	referenced_schema_name,
	referenced_object_name = referenced_entity_name,
	referenced_object_type_desc = o1.type_desc,
	referenced_server_name, referenced_database_name
	--,sed.* -- Uncomment for all the columns
	FROM
	sys.sql_expression_dependencies sed
	INNER JOIN
	sys.objects o ON sed.referencing_id = o.[object_id]
	LEFT OUTER JOIN
	sys.objects o1 ON sed.referenced_id = o1.[object_id]
WHERE referenced_entity_name = @TBL
--AND o.type_desc like 'VIEW'
