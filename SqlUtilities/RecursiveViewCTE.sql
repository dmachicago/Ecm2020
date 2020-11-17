WITH DepTree
    AS (
    SELECT  o.name
          , o.object_id AS referenced_id
          ,o.name AS referenced_name
          ,o.object_id AS referencing_id
          ,o.name AS referencing_name
          ,0 AS NestLevel
      FROM sys.objects AS o
      WHERE o.is_ms_shipped = 0
        AND o.type = 'V'
    --and o.name ='view_EDW_HealthAssesment'

    UNION ALL

    SELECT  r.name
          , d1.referenced_id
          ,OBJECT_NAME ( d1.referenced_id) 
          ,d1.referencing_id
          ,OBJECT_NAME ( d1.referencing_id) 
          ,NestLevel + 1
      FROM
           sys.sql_expression_dependencies AS d1
               JOIN DepTree AS r
                   ON d1.referenced_id = r.referencing_id
    ) 
    SELECT DISTINCT name AS ViewName
                  , MAX (NestLevel) AS MaxNestLevel
      FROM DepTree
      --where name = 'view_EDW_HealthAssesment'
      GROUP BY name
      --HAVING MAX(NestLevel) > 4
      ORDER BY MAX (NestLevel) DESC;
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
