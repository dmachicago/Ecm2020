SELECT TOP 50
stmt_text = REPLACE (REPLACE (SUBSTRING (sql.[text], PlanStats.statement_start_offset/2 + 1, CASE WHEN PlanStats.statement_end_offset = -1 THEN LEN (CONVERT(nvarchar(max), sql.[text])) ELSE PlanStats.statement_end_offset/2 - PlanStats.statement_start_offset/2 + 1 END), CHAR(13), ' '), CHAR(10), ' ')
, qp.query_plan
, PlanStats.total_physical_reads
, PlanStats.total_logical_writes
, PlanStats.execution_count
, tot_cpu_ms = PlanStats.total_worker_time/1000.
, tot_duration_ms = PlanStats.total_elapsed_time/1000.
, PlanStats.total_rows
, dbname = db_name( convert(int, pa.value) )
, sql.objectid
, planstats.last_execution_time
FROM ( SELECT *,
ROW_NUMBER() OVER (ORDER BY stat.total_worker_time DESC) AS CpuRank,
ROW_NUMBER() OVER (ORDER BY stat.total_physical_reads DESC) AS PhysicalReadsRank,
ROW_NUMBER() OVER (ORDER BY stat.total_elapsed_time DESC) AS DurationRank
FROM sys.dm_exec_query_stats stat ) AS PlanStats
INNER JOIN sys.dm_exec_cached_plans p ON p.plan_handle = PlanStats.plan_handle
OUTER APPLY sys.dm_exec_plan_attributes (p.plan_handle) pa
OUTER APPLY sys.dm_exec_sql_text (p.plan_handle) AS sql
OUTER APPLY sys.dm_exec_query_plan (p.plan_handle) qp
WHERE pa.attribute = 'dbid'
ORDER BY PlanStats.CpuRank + PlanStats.PhysicalReadsRank + PlanStats.DurationRank asc;