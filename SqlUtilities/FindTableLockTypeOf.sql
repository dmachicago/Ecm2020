--exec sp_who2

SELECT OBJECT_NAME(P.object_id) AS TableName, 
       resource_type, 
       resource_description, 
       request_mode,
       CASE REQUEST_MODE
           WHEN 'S'
           THEN 'Shared'
           WHEN 'U'
           THEN 'Update'
           WHEN 'X'
           THEN 'Exclusive'
           WHEN 'IS'
           THEN 'Intent Shared'
           WHEN 'IU'
           THEN 'Intent Update'
           WHEN 'IX'
           THEN 'Intent Exclusive'
           WHEN 'SIU'
           THEN 'Shared Intent Update'
           WHEN 'SIX'
           THEN 'Shared Intent Exclusive'
           WHEN 'UIX'
           THEN 'Update Intent Exclusive'
           WHEN 'BU'
           THEN 'Bulk Update'
           WHEN 'RangeS_S'
           THEN 'Shared Range S'
           WHEN 'RangeS_U'
           THEN 'Shared Range U'
           WHEN 'RangeI_N'
           THEN 'Insert Range'
           WHEN 'RangeI_S'
           THEN 'Insert Range S'
           WHEN 'RangeI_U'
           THEN 'Insert Range U'
           WHEN 'RangeI_X'
           THEN 'Insert Range X'
           WHEN 'RangeX_S'
           THEN 'Exclusive range S'
           WHEN 'RangeX_U'
           THEN 'Exclusive range U'
           WHEN 'RangeX_X'
           THEN 'Exclusive range X'
           WHEN 'SCH-M'
           THEN 'Schema-Modification'
           WHEN 'SCH-S'
           THEN 'Schema-Stability'
           ELSE NULL
       END AS REQUEST_LOCK_MODE
FROM sys.dm_tran_locks AS L
     JOIN sys.partitions AS P ON L.resource_associated_entity_id = p.hobt_id;
--WHERE p.object_id = OBJECT_ID('STAGING_EDW_HealthAssessment')
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016