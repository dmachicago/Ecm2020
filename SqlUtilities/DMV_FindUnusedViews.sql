
--DMV_FindUnusedViews.sql
--DMV sys.dmv_exec_cached_plans. Execution plan cache is 
--dynamic, and results can vary. Use this query over time 
--to find views that are actually being used or not.

IF OBJECT_ID('tempdb..#Results') IS NOT NULL
    DROP TABLE #FindUnusedViews

SELECT * 
INTO #FindUnusedViews
FROM (
SELECT
  SCHEMA_NAME(vw.schema_id) AS schemaname
  ,vw.name AS name
  ,vw.object_id AS viewid
FROM
  sys.views AS vw
WHERE
  (vw.is_ms_shipped = 0)
EXCEPT
SELECT
  SCHEMA_NAME(o.schema_id) AS schemaname
  ,o.name AS name
  ,st.objectid AS viewid
FROM
  sys.dm_exec_cached_plans cp
CROSS APPLY
  sys.dm_exec_sql_text(cp.plan_handle) st
INNER JOIN
  sys.objects o ON st.[objectid] = o.[object_id]
WHERE
  st.dbid = DB_ID()
) as X
select * from #FindUnusedViews ;
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
