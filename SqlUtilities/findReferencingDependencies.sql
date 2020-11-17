SELECT referencing_id,OBJECT_SCHEMA_NAME ( referencing_id ) 
	+ '.' + 
    OBJECT_NAME(referencing_id) AS referencing_object_name, 
    obj.type_desc AS referencing_object_type, 
    referenced_schema_name + '.' + 
    referenced_entity_name As referenced_object_name
FROM sys.sql_expression_dependencies AS sed
INNER JOIN sys.objects AS obj ON sed.referencing_id = obj.object_id
WHERE referencing_id =OBJECT_ID('dbo.gp_InsertIssuerCaptionFromHoldingsLoad')
GO