--* USEDFINAnalytics;
GO

/*
declare @cmd nvarchar(1000) ;
set @cmd = '--* USE?; exec UTIL_IO_BoundQry2000 ; exec UTIL_CPU_BoundQry2000 ;'
exec sp_msForEachDB @cmd ;
*/
/*
--performance bottleneck
--is it CPU or I/O bound? If your performance bottleneck is CPU bound, Find trhe top 5 worst 
--performing queries regarding CPU consumption with the following query:
-- Worst performing CPU bound queries
*/
IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'sp_UTIL_CPU_BoundQry'
)
    BEGIN
 DROP PROCEDURE sp_UTIL_CPU_BoundQry;
END;
GO
CREATE PROCEDURE sp_UTIL_CPU_BoundQry(@RunID INT = -1)
AS

    /*UTIL_WorstPerformingQuerries.sql*/

    BEGIN
 PRINT @@Servername;
 PRINT DB_NAME();
 DECLARE @NEXTID AS BIGINT= NEXT VALUE FOR master_seq;
 DECLARE @RunDate AS DATETIME= GETDATE();
 INSERT INTO [dbo].[DFS_CPU_BoundQry]
 ( [SVRName], 
   [DBName], 
   [text], 
   [query_plan], 
   [sql_handle], 
   [statement_start_offset], 
   [statement_end_offset], 
   [plan_generation_num], 
   [plan_handle], 
   [creation_time], 
   [last_execution_time], 
   [execution_count], 
   [total_worker_time], 
   [last_worker_time], 
   [min_worker_time], 
   [max_worker_time], 
   [total_physical_reads], 
   [last_physical_reads], 
   [min_physical_reads], 
   [max_physical_reads], 
   [total_logical_writes], 
   [last_logical_writes], 
   [min_logical_writes], 
   [max_logical_writes], 
   [total_logical_reads], 
   [last_logical_reads], 
   [min_logical_reads], 
   [max_logical_reads], 
   [total_clr_time], 
   [last_clr_time], 
   [min_clr_time], 
   [max_clr_time], 
   [total_elapsed_time], 
   [last_elapsed_time], 
   [min_elapsed_time], 
   [max_elapsed_time], 
   [query_hash], 
   [query_plan_hash], 
   [total_rows], 
   [last_rows], 
   [min_rows], 
   [max_rows], 
   [statement_sql_handle], 
   [statement_context_id], 
   [total_dop], 
   [last_dop], 
   [min_dop], 
   [max_dop], 
   [total_grant_kb], 
   [last_grant_kb], 
   [min_grant_kb], 
   [max_grant_kb], 
   [total_used_grant_kb], 
   [last_used_grant_kb], 
   [min_used_grant_kb], 
   [max_used_grant_kb], 
   [total_ideal_grant_kb], 
   [last_ideal_grant_kb], 
   [min_ideal_grant_kb], 
   [max_ideal_grant_kb], 
   [total_reserved_threads], 
   [last_reserved_threads], 
   [min_reserved_threads], 
   [max_reserved_threads], 
   [total_used_threads], 
   [last_used_threads], 
   [min_used_threads], 
   [max_used_threads], 
   [RunDate], 
   [RunID]
 ) 
   SELECT TOP 25 @@SERVERNAME AS SVRName, 
   DB_NAME() AS DBName, 
   st.text, 
   qp.query_plan, 
   qs.*, 
   @RunDate AS RunDate, 
   @NEXTID AS RunID
   FROM sys.dm_exec_query_stats qs
    CROSS APPLY sys.dm_exec_sql_text(qs.plan_handle) st
    CROSS APPLY sys.dm_exec_query_plan(qs.plan_handle) qp
   ORDER BY total_worker_time DESC;
    END;
GO
IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'sp_UTIL_IO_BoundQry'
)
    BEGIN
 DROP PROCEDURE sp_UTIL_IO_BoundQry;
END;
GO
/*
exec sp_UTIL_IO_BoundQry
*/
CREATE PROCEDURE sp_UTIL_IO_BoundQry
AS
    BEGIN

 /* Worst performing IO bound queries*/

 DECLARE @NEXTID AS BIGINT= NEXT VALUE FOR master_seq;
 DECLARE @RunDate AS DATETIME= GETDATE();
 INSERT INTO dbo.DFS_IO_BoundQry
 ( [SVRName], 
   [DBName], 
   [text], 
   [query_plan], 
   [sql_handle], 
   [statement_start_offset], 
   [statement_end_offset], 
   [plan_generation_num], 
   [plan_handle], 
   [creation_time], 
   [last_execution_time], 
   [execution_count], 
   [total_worker_time], 
   [last_worker_time], 
   [min_worker_time], 
   [max_worker_time], 
   [total_physical_reads], 
   [last_physical_reads], 
   [min_physical_reads], 
   [max_physical_reads], 
   [total_logical_writes], 
   [last_logical_writes], 
   [min_logical_writes], 
   [max_logical_writes], 
   [total_logical_reads], 
   [last_logical_reads], 
   [min_logical_reads], 
   [max_logical_reads], 
   [total_clr_time], 
   [last_clr_time], 
   [min_clr_time], 
   [max_clr_time], 
   [total_elapsed_time], 
   [last_elapsed_time], 
   [min_elapsed_time], 
   [max_elapsed_time], 
   [query_hash], 
   [query_plan_hash], 
   [total_rows], 
   [last_rows], 
   [min_rows], 
   [max_rows], 
   [statement_sql_handle], 
   [statement_context_id], 
   [total_dop], 
   [last_dop], 
   [min_dop], 
   [max_dop], 
   [total_grant_kb], 
   [last_grant_kb], 
   [min_grant_kb], 
   [max_grant_kb], 
   [total_used_grant_kb], 
   [last_used_grant_kb], 
   [min_used_grant_kb], 
   [max_used_grant_kb], 
   [total_ideal_grant_kb], 
   [last_ideal_grant_kb], 
   [min_ideal_grant_kb], 
   [max_ideal_grant_kb], 
   [total_reserved_threads], 
   [last_reserved_threads], 
   [min_reserved_threads], 
   [max_reserved_threads], 
   [total_used_threads], 
   [last_used_threads], 
   [min_used_threads], 
   [max_used_threads], 
   [RunDate], 
   [RunID]
 ) 
   SELECT TOP 25 @@SERVERNAME AS SVRName, 
   DB_NAME() AS DBName, 
   st.text, 
   qp.query_plan, 
   qs.*, 
   @RunDate AS RunDate, 
   @NEXTID AS RunID
   FROM sys.dm_exec_query_stats qs
    CROSS APPLY sys.dm_exec_sql_text(qs.plan_handle) st
    CROSS APPLY sys.dm_exec_query_plan(qs.plan_handle) qp
   ORDER BY total_logical_reads DESC;
    END;
GO

/* W. Dale Miller
 DMA, Limited
 Offered under GNU License
 July 26, 2016*/