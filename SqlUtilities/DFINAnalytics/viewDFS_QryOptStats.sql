
go

if exists (select 1 from INFORMATION_SCHEMA.tables where TABLE_NAME = 'viewDFS_QryOptStats')
drop view viewDFS_QryOptStats
go
/*
	select * from viewDFS_QryOptStats
*/
create view viewDFS_QryOptStats
as
select  [schemaname]
      ,[viewname]
      ,[viewid]
      ,[databasename]
      ,[databaseid]
      ,[sql_handle]
      ,[statement_start_offset]
      ,[statement_end_offset]
      ,[plan_generation_num]
      ,[plan_handle]
      ,[creation_time]
      ,[last_execution_time]
      ,[execution_count]
      ,[total_worker_time]
      ,[last_worker_time]
      ,[min_worker_time]
      ,[max_worker_time]
      ,[total_physical_reads]
      ,[last_physical_reads]
      ,[min_physical_reads]
      ,[max_physical_reads]
      ,[total_logical_writes]
      ,[last_logical_writes]
      ,[min_logical_writes]
      ,[max_logical_writes]
      ,[total_logical_reads]
      ,[last_logical_reads]
      ,[min_logical_reads]
      ,[max_logical_reads]
      ,[total_clr_time]
      ,[last_clr_time]
      ,[min_clr_time]
      ,[max_clr_time]
      ,[total_elapsed_time]
      ,[last_elapsed_time]
      ,[min_elapsed_time]
      ,[max_elapsed_time]
      ,[query_hash]
      ,[query_plan_hash]
      ,[total_rows]
      ,[last_rows]
      ,[min_rows]
      ,[max_rows]
      ,[statement_sql_handle]
      ,[statement_context_id]
      ,[total_dop]
      ,[last_dop]
      ,[min_dop]
      ,[max_dop]
      ,[total_grant_kb]
      ,[last_grant_kb]
      ,[min_grant_kb]
      ,[max_grant_kb]
      ,[total_used_grant_kb]
      ,[last_used_grant_kb]
      ,[min_used_grant_kb]
      ,[max_used_grant_kb]
      ,[total_ideal_grant_kb]
      ,[last_ideal_grant_kb]
      ,[min_ideal_grant_kb]
      ,[max_ideal_grant_kb]
      ,[total_reserved_threads]
      ,[last_reserved_threads]
      ,[min_reserved_threads]
      ,[max_reserved_threads]
      ,[total_used_threads]
      ,[last_used_threads]
      ,[min_used_threads]
      ,[max_used_threads]
      ,[total_columnstore_segment_reads]
      ,[last_columnstore_segment_reads]
      ,[min_columnstore_segment_reads]
      ,[max_columnstore_segment_reads]
      ,[total_columnstore_segment_skips]
      ,[last_columnstore_segment_skips]
      ,[min_columnstore_segment_skips]
      ,[max_columnstore_segment_skips]
      ,[total_spills]
      ,[last_spills]
      ,[min_spills]
      ,[max_spills]
      ,[RunDate]
      ,[SSVER]
      ,[UID]
  FROM [DFS_QryOptStats]
  go
  go

if exists (select 1 from INFORMATION_SCHEMA.tables where TABLE_NAME = 'viewDFS_QryOptStatsPlanText')
drop view viewDFS_QryOptStatsPlanText
go
/*
	select * from viewDFS_QryOptStatsPlanText
*/
create view viewDFS_QryOptStatsPlanText
as
select  [query_hash]
	    , [query_plan_hash]
		, '-' as [PerfType]
		, [text]
		, [query_plan]
        , [UID]
  FROM [DFS_QryOptStats]
  go
