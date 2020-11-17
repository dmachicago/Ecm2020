
SELECT  table_name = OBJECT_NAME(parent_object_id) ,
        trigger_name = name ,
        trigger_owner = USER_NAME(schema_id) ,
        OBJECTPROPERTY(object_id, 'ExecIsUpdateTrigger') AS isupdate ,
        OBJECTPROPERTY(object_id, 'ExecIsDeleteTrigger') AS isdelete ,
        OBJECTPROPERTY(object_id, 'ExecIsInsertTrigger') AS isinsert ,
        OBJECTPROPERTY(object_id, 'ExecIsAfterTrigger') AS isafter ,
        OBJECTPROPERTY(object_id, 'ExecIsInsteadOfTrigger') AS isinsteadof ,
        CASE OBJECTPROPERTY(object_id, 'ExecIsTriggerDisabled')
          WHEN 1 THEN 'Disabled'
          ELSE 'Enabled'
        END AS status
FROM    sys.objects
WHERE   type = 'TR'
ORDER BY OBJECT_NAME(parent_object_id)

SELECT  table_name = OBJECT_NAME(parent_object_id) ,
        trigger_name = name ,
        trigger_owner = USER_NAME(schema_id) ,
        OBJECTPROPERTY(object_id, 'ExecIsUpdateTrigger') AS isupdate ,
        OBJECTPROPERTY(object_id, 'ExecIsDeleteTrigger') AS isdelete ,
        OBJECTPROPERTY(object_id, 'ExecIsInsertTrigger') AS isinsert ,
        OBJECTPROPERTY(object_id, 'ExecIsAfterTrigger') AS isafter ,
        OBJECTPROPERTY(object_id, 'ExecIsInsteadOfTrigger') AS isinsteadof ,
        CASE OBJECTPROPERTY(object_id, 'ExecIsTriggerDisabled')
          WHEN 1 THEN 'Disabled'
          ELSE 'Enabled'
        END AS status
FROM    sys.objects
WHERE   type = 'TR'
ORDER BY OBJECT_NAME(parent_object_id)
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
