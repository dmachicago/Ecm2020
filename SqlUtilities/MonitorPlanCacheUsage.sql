--MonitorPlanCacheUsage.sql
--Plan Cache in SQL Server 2005 and 2008 is one of the most underused assets for troubleshooting performance problems in SQL Server. As a part of the normal execution of batches and queries, SQL Server tracks the accumulated execution information for each of the plans that is stored inside of the plan cache, up to the point where the plan is flushed from the cache as a result of DDL operations, memory pressure, or general cache maintenance. The execution information stored inside of the plan cache can be found in the sys.dm_exec_query_stats DMV as shown in the example query in Listing 1.6. This query will list the top ten statements based on the average number of physical reads that the statements performed as a part of their execution.
SELECT TOP 10 execution_count, 
              statement_start_offset AS stmt_start_offset, 
              execution_count,
			  total_physical_reads,
			  total_physical_reads / execution_count AS avg_physical_reads, 
              total_logical_reads,
			  total_logical_reads / execution_count AS avg_logical_reads, 
              total_logical_writes,
			  total_logical_writes / execution_count AS avg_logical_writes, 
              t.[TEXT],
			  [sql_handle], 
              plan_handle
			  
FROM sys.dm_exec_query_stats AS s
     CROSS APPLY sys.dm_exec_sql_text(s.sql_handle) AS t
ORDER BY avg_physical_reads DESC;