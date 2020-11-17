SELECT referencing_schema_name, referencing_entity_name,
referencing_id, referencing_class_desc, is_caller_dependent
FROM sys.dm_sql_referencing_entities ('view_EDW_RewardTriggerParameters', 'OBJECT');
GO

exec sp_depends 'view_EDW_RewardTriggerParameters'