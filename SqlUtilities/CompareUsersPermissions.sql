
EXEC sp_helplogins 'dmiller';

select top 10 * from [sys].[database_principals] where ;


--Database user and role memberships (if any).
SELECT u.name, 
       r.name
FROM sys.database_principals u
     LEFT JOIN sys.database_role_members rm ON rm.member_principal_id = u.principal_id
     LEFT JOIN sys.database_principals r ON r.principal_id = rm.role_principal_id
WHERE u.type != 'R'
      AND u.[name] = 'dmiller'
GO

--Individual GRANTs and DENYs.
SELECT prin.[name] [User], 
       sec.state_desc + ' ' + sec.permission_name [Permission], 
       sec.class_desc Class, 
       OBJECT_NAME(sec.major_id) [Securable], 
       sec.major_id [Securible_Id]
FROM [sys].[database_permissions] sec
     JOIN [sys].[database_principals] prin ON sec.[grantee_principal_id] = prin.[principal_id]
WHERE prin.[name] = 'dmiller'
ORDER BY [User], 
         [Permission];
GO