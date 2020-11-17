SELECT referencing_schema_name, referencing_entity_name,
referencing_id, referencing_class_desc, is_caller_dependent
FROM sys.dm_sql_referencing_entities ('view_EDW_RewardTriggerParameters', 'OBJECT');
GO

exec sp_depends 'view_EDW_RewardTriggerParameters'
exec sp_depends 'dbo.View_HFit_RewardTrigger_Joined'
exec sp_depends 'dbo.View_CMS_Tree_Joined'
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
