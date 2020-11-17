
SELECT sys.schemas.name AS 'Schema', sys.objects.name AS Object, sys.database_principals.name AS username, 
		sys.database_permissions.type AS permissions_type, sys.database_permissions.permission_name, 
		sys.database_permissions.state AS permission_state, sys.database_permissions.state_desc, 
		state_desc + ' ' + permission_name + ' on [' + sys.schemas.name + '].[' + sys.objects.name + '] to [' + sys.database_principals.name + ']' COLLATE LATIN1_General_CI_AS
  FROM sys.database_permissions
		   JOIN sys.objects
			   ON sys.database_permissions.major_id = sys.objects.object_id
		   JOIN sys.schemas
			   ON sys.objects.schema_id = sys.schemas.schema_id
		   JOIN sys.database_principals
			   ON sys.database_permissions.grantee_principal_id = sys.database_principals.principal_id
  ORDER BY 1, 2, 3, 5;
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
