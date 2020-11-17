
/*
Developed W. Dale Miller 
Copyright @DMA, Ltd, July 26, 2012 all rights reserved.
Licensed under the MIT Open Code License
Free to --* USEas long as the copyright is retained in the code.
*/
/*
-- exec UTIL_QryPlanStats

--The below CTE provides information about the number of executions, 
--total run time, and pages read from memory. The results can be used 
--to identify queries that may be candidates for optimization.
--Note: The results of this query can vary depending on the version of SQL Server.
--select * into QueryUseStats
IF OBJECT_ID('tempdb..#Results') IS NOT NULL
    DROP TABLE #FindUnusedViews;
*/
/** USEDFINAnalytics;*/

go

if exists (select 1 from sys.procedures where name = 'sp_PerfMonitor')
	DROP PROCEDURE [dbo].[sp_PerfMonitor]
GO


/*
--************************************************************
--**** HOW TO USE
--************************************************************
*/
/*
DECLARE @action VARCHAR(10)= NULL;
DECLARE @RunID int;
DECLARE @UKEY VARCHAR(50);
DECLARE @ProcName VARCHAR(50);
DECLARE @LocID VARCHAR(50);
exec @RunID = dbo.UTIL_GetSeq ;
--SET @RunID = NEXT VALUE FOR master_seq;
SET @action = 'start';
SET @UKEY = NEWID();
SET @ProcName = 'spTestProcName';
SET @LocID = 'Loc3';
EXEC master.dbo.sp_PerfMonitor 
     @action, 
     @RunID, 
     @UKEY, 
     @ProcName, 
     @LocID;  
-- For example, wait a couple of seconds before ending it...
WAITFOR DELAY '00:00:12';
EXEC master.dbo.sp_PerfMonitor 
     'end', 
     @RunID, 
     @UKEY, 
     @ProcName, 
     @LocID;
*/

CREATE PROCEDURE [dbo].[sp_PerfMonitor]
(@action   VARCHAR(10), 
 @RunID    INT, 
 @UKEY     uniqueidentifier,
 @ProcName VARCHAR(50) = NULL, 
 @LocID    VARCHAR(50) = NULL
)
AS
    BEGIN
 IF(@action = 'start')
     BEGIN
  INSERT INTO [dbo].[DFS_PerfMonitor]
  (
		SVRNAME,
		DBNAME,
		SSVER,
		[RunID], 
		[ProcName], 
		[LocID], 
		[UKEY], 
		[StartTime], 
		[EndTime], 
		[ElapsedTime],
		CreateDate
  )
  VALUES (
		@@servername ,
		Db_name(),
		substring(@@version,1,149),
		@RunID, 
		@ProcName, 
		@LocID, 
		@UKEY, 
		GETDATE(), 
		NULL, 
		NULL,
		getdate()
  );
 END;
 IF(@action = 'end')
     BEGIN
  UPDATE [dbo].[DFS_PerfMonitor]
    SET 
   [EndTime] = GETDATE()
  WHERE UKEY = @UKEY;
  UPDATE [dbo].[DFS_PerfMonitor]
    SET 
   [ElapsedTime] = DATEDIFF(MILLISECOND, [StartTime], [EndTime])
  WHERE UKEY = @UKEY;
 END;
    END;

GO

IF EXISTS
(
	SELECT 1
	FROM INFORMATION_SCHEMA.TABLES
	WHERE TABLE_NAME = 'DFS_QryOptStats'
)
BEGIN
	DROP TABLE DFS_QryOptStats;
END;
GO

IF NOT EXISTS
(
	SELECT 1
	FROM INFORMATION_SCHEMA.tables
	WHERE TABLE_NAME = 'DFS_QryOptStats'
)
BEGIN
	CREATE TABLE [dbo].[DFS_QryOptStats]
	( 
				 [SvrName] [NVARCHAR](150) NULL, [schemaname] [NVARCHAR](150) NULL, [viewname] [sysname] NOT NULL, [viewid] [int] NOT NULL, [databasename] [NVARCHAR](150) NULL, [databaseid] [smallint] NULL, [text] [nvarchar](max) NULL, [query_plan] [xml] NULL, [sql_handle] [varbinary](64) NOT NULL, [statement_start_offset] [int] NOT NULL, [statement_end_offset] [int] NOT NULL, [plan_generation_num] [bigint] NULL, [plan_handle] [varbinary](64) NOT NULL, [creation_time] [datetime] NULL, [last_execution_time] [datetime] NULL, [execution_count] [bigint] NOT NULL, [total_worker_time] [bigint] NOT NULL, [last_worker_time] [bigint] NOT NULL, [min_worker_time] [bigint] NOT NULL, [max_worker_time] [bigint] NOT NULL, [total_physical_reads] [bigint] NOT NULL, [last_physical_reads] [bigint] NOT NULL, [min_physical_reads] [bigint] NOT NULL, [max_physical_reads] [bigint] NOT NULL, [total_logical_writes] [bigint] NOT NULL, [last_logical_writes] [bigint] NOT NULL, [min_logical_writes] [bigint] NOT NULL, [max_logical_writes] [bigint] NOT NULL, [total_logical_reads] [bigint] NOT NULL, [last_logical_reads] [bigint] NOT NULL, [min_logical_reads] [bigint] NOT NULL, [max_logical_reads] [bigint] NOT NULL, [total_clr_time] [bigint] NOT NULL, [last_clr_time] [bigint] NOT NULL, [min_clr_time] [bigint] NOT NULL, [max_clr_time] [bigint] NOT NULL, [total_elapsed_time] [bigint] NOT NULL, [last_elapsed_time] [bigint] NOT NULL, [min_elapsed_time] [bigint] NOT NULL, [max_elapsed_time] [bigint] NOT NULL, [query_hash] [binary](8) NULL, [query_plan_hash] [binary](8) NULL, [total_rows] [bigint] NULL, [last_rows] [bigint] NULL, [min_rows] [bigint] NULL, [max_rows] [bigint] NULL, [statement_sql_handle] [varbinary](64) NULL, [statement_context_id] [bigint] NULL, [total_dop] [bigint] NULL, [last_dop] [bigint] NULL, [min_dop] [bigint] NULL, [max_dop] [bigint] NULL, [total_grant_kb] [bigint] NULL, [last_grant_kb] [bigint] NULL, [min_grant_kb] [bigint] NULL, [max_grant_kb] [bigint] NULL, [total_used_grant_kb] [bigint] NULL, [last_used_grant_kb] [bigint] NULL, [min_used_grant_kb] [bigint] NULL, [max_used_grant_kb] [bigint] NULL, [total_ideal_grant_kb] [bigint] NULL, [last_ideal_grant_kb] [bigint] NULL, [min_ideal_grant_kb] [bigint] NULL, [max_ideal_grant_kb] [bigint] NULL, [total_reserved_threads] [bigint] NULL, [last_reserved_threads] [bigint] NULL, [min_reserved_threads] [bigint] NULL, [max_reserved_threads] [bigint] NULL, [total_used_threads] [bigint] NULL, [last_used_threads] [bigint] NULL, [min_used_threads] [bigint] NULL, [max_used_threads] [bigint] NULL, [total_columnstore_segment_reads] [bigint] NULL, [last_columnstore_segment_reads] [bigint] NULL, [min_columnstore_segment_reads] [bigint] NULL, [max_columnstore_segment_reads] [bigint] NULL, [total_columnstore_segment_skips] [bigint] NULL, [last_columnstore_segment_skips] [bigint] NULL, [min_columnstore_segment_skips] [bigint] NULL, [max_columnstore_segment_skips] [bigint] NULL, [total_spills] [bigint] NULL, [last_spills] [bigint] NULL, [min_spills] [bigint] NULL, [max_spills] [bigint] NULL, RunDate datetime DEFAULT GETDATE(), [SSVER] [nvarchar](300) NULL, [UID] uniqueidentifier NOT NULL DEFAULT NEWID()
	)
	ON [PRIMARY];
END;
GO

/* exec UTIL_QryPlanStats*/

IF EXISTS
(
	SELECT 1
	FROM sys.procedures
	WHERE name = 'UTIL_QryPlanStats'
)
BEGIN
	DROP PROCEDURE UTIL_QryPlanStats;
END;
GO

/* 
exec UTIL_QryPlanStats 1

declare @ukey as uniqueidentifier = newid();
exec sp_PerfMonitor 'start', 0, @ukey,  'UTIL_QryPlanStats', '00';
exec sp_PerfMonitor 'end', 0, @ukey,  'UTIL_QryPlanStats', '00';
*/

CREATE PROCEDURE UTIL_QryPlanStats
( 
				 @debug int= 0
)
AS
BEGIN
	DECLARE @cnt AS int= 0;
	declare @ukey as uniqueidentifier = newid() ;

	exec sp_PerfMonitor 'start', 0, @ukey,  'UTIL_QryPlanStats', '00';

	IF OBJECT_ID('tempdb..#TEMP_DFS_QryOptStats') IS NOT NULL
	BEGIN
		DROP TABLE #TEMP_DFS_QryOptStats;
	END;

	BEGIN
		PRINT 'USING DB: ' + DB_NAME();

		WITH CTE_VW_STATS
			 AS (SELECT SCHEMA_NAME(vw.schema_id) AS schemaname, vw.name AS viewname, vw.object_id AS viewid
				 FROM sys.views AS vw
				 WHERE(vw.is_ms_shipped = 0)
				 INTERSECT
				 SELECT SCHEMA_NAME(o.schema_id) AS schemaname, o.Name AS name, st.objectid AS viewid
				 FROM sys.dm_exec_cached_plans AS cp
					  CROSS APPLY
					  sys.dm_exec_sql_text( cp.plan_handle ) AS st
					  INNER JOIN
					  sys.objects AS o
					  ON st.[objectid] = o.[object_id]
				 WHERE st.dbid = DB_ID())
			 SELECT vw.schemaname, vw.viewname, vw.viewid, DB_NAME(t.databaseid) AS databasename, t.*
			 INTO #TEMP_DFS_QryOptStats
			 FROM CTE_VW_STATS AS vw
				  CROSS APPLY
			 (
				 SELECT st.dbid AS databaseid, st.text, qp.query_plan, qs.*, GETDATE() AS RunDate, @@VERSION AS SSVER, NEWID() AS [UID]
				 FROM sys.dm_exec_query_stats AS qs
					  CROSS APPLY
					  sys.dm_exec_sql_text( qs.plan_handle ) AS st
					  CROSS APPLY
					  sys.dm_exec_query_plan( qs.plan_handle ) AS qp
				 WHERE(CHARINDEX(vw.schemaname, st.text, 1) > 0) AND 
					  (st.dbid = DB_ID())
			 ) AS t;
		SET @cnt =
		(
			SELECT COUNT(*)
			FROM #TEMP_DFS_QryOptStats
		);
		IF(@cnt > 0 or @debug = 1)
		BEGIN
			DECLARE @s nvarchar(max);
			SET @s = dbo.genInsertSql( '#TEMP_DFS_QryOptStats', 'dbo.DFS_QryOptStats' );
			IF(@debug = 1)
			BEGIN
				PRINT @s;
			END;
			EXECUTE sp_executesql @s;
		END;
		
	END;

exec dbo.sp_PerfMonitor 'end', 0, @ukey,  'UTIL_QryPlanStats', '00';

END;