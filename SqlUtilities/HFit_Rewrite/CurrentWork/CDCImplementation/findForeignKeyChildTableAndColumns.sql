SELECT *
                FROM
                     SYS.FOREIGN_KEYS AS FK
                     INNER JOIN SYS.TABLES AS T
                     ON
                       FK.PARENT_OBJECT_ID = T.OBJECT_ID

declare @TgtTable as nvarchar(200) = 'dbo.SM_TwitterApplication' ;
SELECT 
    f.name AS foreign_key_name
   ,OBJECT_NAME(f.parent_object_id) AS ParentTable
   ,COL_NAME(fc.parent_object_id, fc.parent_column_id) AS ParentTable_column_name
   ,OBJECT_NAME (f.referenced_object_id) AS ChildTable
   ,COL_NAME(fc.referenced_object_id, fc.referenced_column_id) AS ChildTable_column_name
   ,is_disabled
   ,delete_referential_action_desc
   ,update_referential_action_desc
FROM sys.foreign_keys AS f
INNER JOIN sys.foreign_key_columns AS fc 
   ON f.object_id = fc.constraint_object_id 
WHERE f.parent_object_id = OBJECT_ID(@TgtTable)