/*
Developed W. Dale Miller 
Copyright @DMA, Ltd, July 26, 2012 all rights reserved.
Licensed under the MIT Open Code License
Free to use as long as the copyright is retained in the code.
*/

-- exec UTIL_QryPlanStats

--The below CTE provides information about the number of executions, 
--total run time, and pages read from memory. The results can be used 
--to identify queries that may be candidates for optimization.
--Note: The results of this query can vary depending on the version of SQL Server.
--select * into QueryUseStats
--IF OBJECT_ID('tempdb..#Results') IS NOT NULL
--    DROP TABLE #FindUnusedViews;

USE DFSAnalytics;
go
if exists( select 1 from INFORMATION_SCHEMA.TABLES where TABLE_NAME = 'DFS_QryOptStats')
	drop table DFS_QryOptStats;
GO
IF NOT EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.tables
    WHERE TABLE_NAME = 'DFS_QryOptStats'
)
    BEGIN
        CREATE TABLE DFSAnalytics.[dbo].[DFS_QryOptStats]
        ([schemaname]             [NVARCHAR](128) NULL, 
         [viewname]               [SYSNAME] NOT NULL, 
         [viewid]                 [INT] NOT NULL, 
         [databasename]           [NVARCHAR](128) NULL, 
         [databaseid]             [SMALLINT] NULL, 
         [text]                   [NVARCHAR](MAX) NULL, 
         [query_plan]             [XML] NULL, 
         [sql_handle]             [VARBINARY](64) NOT NULL, 
         [statement_start_offset] [INT] NOT NULL, 
         [statement_end_offset]   [INT] NOT NULL, 
         [plan_generation_num]    [BIGINT] NULL, 
         [plan_handle]            [VARBINARY](64) NOT NULL, 
         [creation_time]          [DATETIME] NULL, 
         [last_execution_time]    [DATETIME] NULL, 
         [execution_count]        [BIGINT] NOT NULL, 
         [total_worker_time]      [BIGINT] NOT NULL, 
         [last_worker_time]       [BIGINT] NOT NULL, 
         [min_worker_time]        [BIGINT] NOT NULL, 
         [max_worker_time]        [BIGINT] NOT NULL, 
         [total_physical_reads]   [BIGINT] NOT NULL, 
         [last_physical_reads]    [BIGINT] NOT NULL, 
         [min_physical_reads]     [BIGINT] NOT NULL, 
         [max_physical_reads]     [BIGINT] NOT NULL, 
         [total_logical_writes]   [BIGINT] NOT NULL, 
         [last_logical_writes]    [BIGINT] NOT NULL, 
         [min_logical_writes]     [BIGINT] NOT NULL, 
         [max_logical_writes]     [BIGINT] NOT NULL, 
         [total_logical_reads]    [BIGINT] NOT NULL, 
         [last_logical_reads]     [BIGINT] NOT NULL, 
         [min_logical_reads]      [BIGINT] NOT NULL, 
         [max_logical_reads]      [BIGINT] NOT NULL, 
         [total_clr_time]         [BIGINT] NOT NULL, 
         [last_clr_time]          [BIGINT] NOT NULL, 
         [min_clr_time]           [BIGINT] NOT NULL, 
         [max_clr_time]           [BIGINT] NOT NULL, 
         [total_elapsed_time]     [BIGINT] NOT NULL, 
         [last_elapsed_time]      [BIGINT] NOT NULL, 
         [min_elapsed_time]       [BIGINT] NOT NULL, 
         [max_elapsed_time]       [BIGINT] NOT NULL, 
         [query_hash]             [BINARY](8) NULL, 
         [query_plan_hash]        [BINARY](8) NULL, 
         [total_rows]             [BIGINT] NULL, 
         [last_rows]              [BIGINT] NULL, 
         [min_rows]               [BIGINT] NULL, 
         [max_rows]               [BIGINT] NULL, 
         [statement_sql_handle]   [VARBINARY](64) NULL, 
         [statement_context_id]   [BIGINT] NULL, 
         [total_dop]              [BIGINT] NULL, 
         [last_dop]               [BIGINT] NULL, 
         [min_dop]                [BIGINT] NULL, 
         [max_dop]                [BIGINT] NULL, 
         [total_grant_kb]         [BIGINT] NULL, 
         [last_grant_kb]          [BIGINT] NULL, 
         [min_grant_kb]           [BIGINT] NULL, 
         [max_grant_kb]           [BIGINT] NULL, 
         [total_used_grant_kb]    [BIGINT] NULL, 
         [last_used_grant_kb]     [BIGINT] NULL, 
         [min_used_grant_kb]      [BIGINT] NULL, 
         [max_used_grant_kb]      [BIGINT] NULL, 
         [total_ideal_grant_kb]   [BIGINT] NULL, 
         [last_ideal_grant_kb]    [BIGINT] NULL, 
         [min_ideal_grant_kb]     [BIGINT] NULL, 
         [max_ideal_grant_kb]     [BIGINT] NULL, 
         [total_reserved_threads] [BIGINT] NULL, 
         [last_reserved_threads]  [BIGINT] NULL, 
         [min_reserved_threads]   [BIGINT] NULL, 
         [max_reserved_threads]   [BIGINT] NULL, 
         [total_used_threads]     [BIGINT] NULL, 
         [last_used_threads]      [BIGINT] NULL, 
         [min_used_threads]       [BIGINT] NULL, 
         [max_used_threads]       [BIGINT] NULL,
		 RowID bigint identity (1,1) not null,
		 RunDate datetime default getdate()
        )
        ON [PRIMARY];
END
GO
-- exec UTIL_QryPlanStats
if exists (select 1 from sys.procedures where name = 'UTIL_QryPlanStats')
begin
	drop PROCEDURE UTIL_QryPlanStats	
end
go
create PROCEDURE UTIL_QryPlanStats
AS
    BEGIN
        WITH CTE_VW_STATS
             AS (SELECT SCHEMA_NAME(vw.schema_id) AS schemaname, 
                        vw.name AS viewname, 
                        vw.object_id AS viewid
                 FROM sys.views AS vw
                 WHERE(vw.is_ms_shipped = 0)
                 INTERSECT
                 SELECT SCHEMA_NAME(o.schema_id) AS schemaname, 
                        o.Name AS name, 
                        st.objectid AS viewid
                 FROM sys.dm_exec_cached_plans cp
                      CROSS APPLY sys.dm_exec_sql_text(cp.plan_handle) st
                      INNER JOIN sys.objects o ON st.[objectid] = o.[object_id]
                 WHERE st.dbid = DB_ID())
             INSERT INTO DFS_QryOptStats
             ([schemaname], 
              [viewname], 
              [viewid], 
              [databasename], 
              [databaseid], 
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
              [max_used_threads]
             )
                    SELECT vw.schemaname, 
                           vw.viewname, 
                           vw.viewid, 
                           DB_NAME(t.databaseid) AS databasename, 
                           --t.databaseid, 
                           t.*
                    FROM CTE_VW_STATS AS vw
                         CROSS APPLY
                    (
                        SELECT st.dbid AS databaseid, 
                               st.text, 
                               qp.query_plan, 
                               qs.*
                        FROM sys.dm_exec_query_stats AS qs
                             CROSS APPLY sys.dm_exec_sql_text(qs.plan_handle) AS st
                             CROSS APPLY sys.dm_exec_query_plan(qs.plan_handle) AS qp
                        WHERE(CHARINDEX(vw.schemaname, st.text, 1) > 0)
                             AND (st.dbid = DB_ID())
                    ) AS t;
    END;
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

