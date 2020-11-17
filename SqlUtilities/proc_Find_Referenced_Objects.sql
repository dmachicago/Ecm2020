
SELECT
       j.name
     , js.step_name
     , jh.sql_severity
     , jh.message
     , jh.run_date
     , jh.run_time
FROM msdb.dbo.sysjobs AS j
     INNER JOIN msdb.dbo.sysjobsteps AS js
     ON
       js.job_id = j.job_id
     INNER JOIN msdb.dbo.sysjobhistory AS jh
     ON
       jh.job_id = j.job_id
WHERE
       jh.run_status = 0 AND
       message LIKE '%Foreign Key%';

SELECT
    'DROP DDL' = case
    when o.type_desc like '%SQL_STORED_PROCEDURE%' then 
       'DROP procedure ' + o.name + char(10) + 'GO' 
    when o.type_desc like 'VIEW' then 
       'DROP VIEW ' + o.name   + char(10) + 'GO' 
    END 
     ,referencing_schema_name = SCHEMA_NAME (o.SCHEMA_ID) 
     ,referencing_object_name = o.name
     ,referencing_object_type_desc = o.type_desc
     ,referenced_schema_name
     ,referenced_object_name = referenced_entity_name
     ,referenced_object_type_desc = o1.type_desc
     ,referenced_server_name
     , referenced_database_name
--,sed.* -- Uncomment for all the columns
FROM sys.sql_expression_dependencies AS sed
     INNER JOIN sys.objects AS o
     ON
       sed.referencing_id = o.object_id
     LEFT OUTER JOIN sys.objects AS o1
     ON
       sed.referenced_id = o1.object_id
WHERE
referenced_entity_name LIKE '%FACT_%';

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
