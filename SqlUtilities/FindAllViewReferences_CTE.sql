SELECT
--referencing_schema_name = SCHEMA_NAME(o.SCHEMA_ID),
referencing_object_name = o.name,
--referencing_object_type_desc = o.type_desc,
--referenced_schema_name,
referenced_object_name = referenced_entity_name
,referenced_object_type_desc = o1.type_desc
--referenced_server_name
--referenced_database_name
--,sed.* -- Uncomment for all the columns
  FROM
       sys.sql_expression_dependencies AS sed
           INNER JOIN sys.objects AS o
               ON sed.referencing_id = o.object_id
           LEFT OUTER JOIN sys.objects AS o1
               ON sed.referenced_id = o1.object_id
  WHERE
  o.name = 'view_EDW_RewardUserDetail';

--or o.name = 'View_HFit_RewardActivity_Joined'
--or o.name = 'View_HFit_RewardGroup_Joined'
--or o.name = 'View_HFit_RewardProgram_Joined'
--or o.name = 'View_HFit_RewardTrigger_Joined'

--or o.name = 'View_CMS_Tree_Joined'




-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
