DECLARE @referencing_entity AS sysname;
SET @referencing_entity = N'proc_STAGING_EDW_HA_Changes';
SET @referencing_entity = N'proc_EDW_BuildStagingTables';

WITH ObjectDepends(entity_name,referenced_schema, referenced_entity, referenced_id,level)
AS (
    SELECT entity_name = 
       CASE referencing_class
          WHEN 1 THEN OBJECT_NAME(referencing_id)
          WHEN 12 THEN (SELECT t.name FROM sys.triggers AS t 
                       WHERE t.object_id = sed.referencing_id)
          WHEN 13 THEN (SELECT st.name FROM sys.server_triggers AS st
                       WHERE st.object_id = sed.referencing_id) COLLATE database_default
       END
    ,referenced_schema_name
    ,referenced_entity_name
    ,referenced_id
    ,0 AS level 
    FROM sys.sql_expression_dependencies AS sed 
    WHERE OBJECT_NAME(referencing_id) = @referencing_entity 
UNION ALL
    SELECT entity_name = 
       CASE sed.referencing_class
          WHEN 1 THEN OBJECT_NAME(sed.referencing_id)
          WHEN 12 THEN (SELECT t.name FROM sys.triggers AS t 
                       WHERE t.object_id = sed.referencing_id)
          WHEN 13 THEN (SELECT st.name FROM sys.server_triggers AS st
                       WHERE st.object_id = sed.referencing_id) COLLATE database_default
       END
    ,sed.referenced_schema_name
    ,sed.referenced_entity_name
    ,sed.referenced_id
    ,level + 1   
    FROM ObjectDepends AS o
    JOIN sys.sql_expression_dependencies AS sed ON sed.referencing_id = o.referenced_id
    )
SELECT distinct entity_name,referenced_schema, referenced_entity, SO.type_desc, level
FROM ObjectDepends
join sys.objects as SO
    on SO.name = referenced_entity
--SELECT name AS object_name 
--  ,SCHEMA_NAME(schema_id) AS schema_name
--  ,type_desc
--  ,create_date
--  ,modify_date
--FROM sys.objects

ORDER BY level;
GO
