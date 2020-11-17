
/*SELECT * FROM sys.dm_exec_procedure_stats*/

SELECT DB_NAME() AS DatabaseName, 
       (total_worker_time / execution_count) / 1000 AS AvgExec_ms, 
       execution_count, 
       max_worker_time / 1000 AS MaxExec_ms, 
       OBJECT_NAME(object_id) AS ProcName, 
       object_id, 
       type_desc, 
       cached_time, 
       last_execution_time, 
       total_worker_time / 1000 AS total_worker_time_ms, 
       total_elapsed_time / 1000 AS total_elapsed_time_ms, 
       OBJECT_NAME(object_id) AS SQLText, 
       OBJECT_NAME(object_id) AS full_statement_text
FROM sys.dm_exec_procedure_stats
WHERE database_id = DB_ID()
      AND execution_count >= 1
      AND (total_worker_time / execution_count) / 1000 >= 1

/* BREAK HERE */

UNION
SELECT DB_NAME() AS DatabaseName, 
       (qs.total_worker_time / qs.execution_count) / 1000 AS AvgExec_ms, 
       qs.execution_count, 
       qs.max_worker_time / 1000 AS MaxExec_ms, 
       OBJECT_NAME(st.objectid) AS ProcName, 
       st.objectid AS object_id, 
       'STATEMENT' AS type_desc, 
       '1901-01-01 00:00:00' AS cached_time, 
       qs.last_execution_time, 
       qs.total_worker_time / 1000 AS total_worker_time_ms, 
       qs.total_elapsed_time / 1000 AS total_elapsed_time_ms, 
       SUBSTRING(st.text, qs.statement_start_offset / 2 + 1, 50) + '...' AS SQLText, 
       SUBSTRING(st.text, qs.statement_start_offset / 2 + 1, (CASE qs.statement_end_offset
                                                                  WHEN-1
                                                                  THEN DATALENGTH(st.text)
                                                                  ELSE qs.statement_end_offset
                                                              END - qs.statement_start_offset) / 2 + 1) AS full_statement_text
FROM sys.dm_exec_query_stats AS qs
          CROSS APPLY sys.dm_exec_plan_attributes(qs.plan_handle) AS pa
               CROSS APPLY sys.dm_exec_sql_text(qs.sql_handle) AS st
WHERE st.dbid = DB_ID()
      OR pa.attribute = 'dbid'
      AND pa.value = DB_ID();