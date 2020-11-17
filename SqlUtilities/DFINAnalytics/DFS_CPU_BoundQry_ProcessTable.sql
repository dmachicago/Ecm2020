
--* USEDFINAnalytics;
GO

IF EXISTS
(
    SELECT name
    FROM sys.tables
    WHERE name = 'DFS_CPU_BoundQry'
)
drop table DFS_CPU_BoundQry;

begin
 CREATE TABLE [dbo].[DFS_CPU_BoundQry]
 ([SVRName]  [NVARCHAR](150) NULL, 
  [DBName]   [NVARCHAR](150) NULL, 
  [text]     [NVARCHAR](MAX) NULL, 
  [query_plan] [XML] NULL, 
  [sql_handle] [VARBINARY](64) NOT NULL, 
  [statement_start_offset] [INT] NOT NULL, 
  [statement_end_offset]   [INT] NOT NULL, 
  [plan_generation_num]    [BIGINT] NULL, 
  [plan_handle]     [VARBINARY](64) NOT NULL, 
  [creation_time]   [DATETIME] NULL, 
  [last_execution_time]    [DATETIME] NULL, 
  [execution_count] [BIGINT] NOT NULL, 
  [total_worker_time] [BIGINT] NOT NULL, 
  [last_worker_time]  [BIGINT] NOT NULL, 
  [min_worker_time] [BIGINT] NOT NULL, 
  [max_worker_time] [BIGINT] NOT NULL, 
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
  [min_logical_reads] [BIGINT] NOT NULL, 
  [max_logical_reads] [BIGINT] NOT NULL, 
  [total_clr_time]  [BIGINT] NOT NULL, 
  [last_clr_time]   [BIGINT] NOT NULL, 
  [min_clr_time]    [BIGINT] NOT NULL, 
  [max_clr_time]    [BIGINT] NOT NULL, 
  [total_elapsed_time]     [BIGINT] NOT NULL, 
  [last_elapsed_time] [BIGINT] NOT NULL, 
  [min_elapsed_time]  [BIGINT] NOT NULL, 
  [max_elapsed_time]  [BIGINT] NOT NULL, 
  [query_hash] [BINARY](8) NULL, 
  [query_plan_hash] [BINARY](8) NULL, 
  [total_rows] [BIGINT] NULL, 
  [last_rows]  [BIGINT] NULL, 
  [min_rows]   [BIGINT] NULL, 
  [max_rows]   [BIGINT] NULL, 
  [statement_sql_handle]   [VARBINARY](64) NULL, 
  [statement_context_id]   [BIGINT] NULL, 
  [total_dop]  [BIGINT] NULL, 
  [last_dop]   [BIGINT] NULL, 
  [min_dop]  [BIGINT] NULL, 
  [max_dop]  [BIGINT] NULL, 
  [total_grant_kb]  [BIGINT] NULL, 
  [last_grant_kb]   [BIGINT] NULL, 
  [min_grant_kb]    [BIGINT] NULL, 
  [max_grant_kb]    [BIGINT] NULL, 
  [total_used_grant_kb]    [BIGINT] NULL, 
  [last_used_grant_kb]     [BIGINT] NULL, 
  [min_used_grant_kb] [BIGINT] NULL, 
  [max_used_grant_kb] [BIGINT] NULL, 
  [total_ideal_grant_kb]   [BIGINT] NULL, 
  [last_ideal_grant_kb]    [BIGINT] NULL, 
  [min_ideal_grant_kb]     [BIGINT] NULL, 
  [max_ideal_grant_kb]     [BIGINT] NULL, 
  [total_reserved_threads] [BIGINT] NULL, 
  [last_reserved_threads]  [BIGINT] NULL, 
  [min_reserved_threads]   [BIGINT] NULL, 
  [max_reserved_threads]   [BIGINT] NULL, 
  [total_used_threads]     [BIGINT] NULL, 
  [last_used_threads] [BIGINT] NULL, 
  [min_used_threads]  [BIGINT] NULL, 
  [max_used_threads]  [BIGINT] NULL, 
  [RunDate]  [DATETIME] NULL, 
  [RunID]    [BIGINT] NULL, 
  [UID] [UNIQUEIDENTIFIER] NOT NULL, 
  [Processed]  [INT] NULL
 )
 ON [PRIMARY];
 ALTER TABLE [dbo].[DFS_CPU_BoundQry]
 ADD DEFAULT(NEWID()) FOR [UID];
 ALTER TABLE [dbo].[DFS_CPU_BoundQry]
 ADD DEFAULT((0)) FOR [Processed];

		create index PI_DFS_CPU_BoundQryUID on DFS_CPU_BoundQry ([UID]);
		create index PI_DFS_CPU_BoundQryProcessed on DFS_CPU_BoundQry ([Processed]);
		create index pkDFS_CPU_BoundQry on DFS_CPU_BoundQry (SvrName, DBName, query_hash, query_plan_hash);
end 
IF EXISTS
(
    SELECT 1
    FROM sys.tables
    WHERE name = 'DFS_QryPlanBridge'
)
drop TABLE [dbo].[DFS_QryPlanBridge];


 CREATE TABLE [dbo].[DFS_QryPlanBridge]
 ([query_hash] [BINARY](8) NULL, 
  [query_plan_hash] [BINARY](8) NULL, 
  [PerfType] [CHAR](1) NOT NULL, 
  [TblType]  [NVARCHAR](10) NOT NULL, 
  [CreateDate] [DATETIME] NOT NULL, 
  [LastUpdate] [DATETIME] NOT NULL, 
  [NbrHits]  [INT] NULL
 )
 ON [PRIMARY];
 ALTER TABLE [dbo].[DFS_QryPlanBridge]
 ADD DEFAULT(GETDATE()) FOR [CreateDate];
 ALTER TABLE [dbo].[DFS_QryPlanBridge]
 ADD DEFAULT(GETDATE()) FOR [LastUpdate];
 ALTER TABLE [dbo].[DFS_QryPlanBridge]
 ADD DEFAULT((0)) FOR [NbrHits];

		create index PI_DFS_QryPlanBridgeQuery_hash on DFS_QryPlanBridge ([query_hash],[query_plan_hash]);

IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'UTIL_DFS_CPU_BoundQry'
)
    DROP PROCEDURE UTIL_DFS_CPU_BoundQry;
GO

/*
exec UTIL_DFS_CPU_BoundQry
*/

CREATE PROCEDURE UTIL_DFS_CPU_BoundQry
AS
    BEGIN
 DECLARE @query_hash BINARY(8);
 DECLARE @query_plan_hash BINARY(8);
 DECLARE @UID UNIQUEIDENTIFIER;
 DECLARE @cnt AS INT;
 DECLARE @i AS INT= 0;
 DECLARE @SQL AS NVARCHAR(MAX);
 DECLARE @plan AS XML;
 DECLARE db_cursor CURSOR
 FOR SELECT DISTINCT 
     B.[query_hash], 
     B.[query_plan_hash], 
     MAX([UID]) AS [UID], 
     COUNT(*) AS cnt
     FROM [dbo].[DFS_QryPlanBridge] AS A
   JOIN [dbo].[DFS_CPU_BoundQry] AS B
   ON B.[query_hash] = A.[query_hash]
    AND B.[query_plan_hash] = A.[query_plan_hash]
     WHERE B.processed = 0
     GROUP BY B.[query_hash], 
  B.[query_plan_hash];
 OPEN db_cursor;
 FETCH NEXT FROM db_cursor INTO @query_hash, @query_plan_hash, @UID, @cnt;
 WHILE @@FETCH_STATUS = 0
     BEGIN
  SET @i = @i + 1;
  PRINT 'I: ' + CAST(@i AS NVARCHAR(15));
  SET @SQL =
  (
 SELECT [text]
 FROM [dbo].[DFS_CPU_BoundQry]
 WHERE [UID] = @uid
  );
  SET @plan =
  (
 SELECT [query_plan]
 FROM [dbo].[DFS_CPU_BoundQry]
 WHERE [UID] = @uid
  );
  SET @cnt =
  (
 SELECT COUNT(*)
 FROM [dbo].[DFS_QryPlanBridge]
 WHERE [query_hash] = @query_hash
     AND [query_plan_hash] = @query_plan_hash
  );
  IF
     (@cnt = 0
     )
 BEGIN
   INSERT INTO [dbo].[DFS_QryPlanBridge]
   ( [query_hash], 
     [query_plan_hash], 
     [PerfType], 
     [TblType], 
     [CreateDate], 
     [LastUpdate], 
     NbrHits
   ) 
   VALUES
   (
     @query_hash
   , @query_plan_hash
   , 'C'
   , '2000'
   , GETDATE()
   , GETDATE()
   , 1
   );
  END;
  SET @cnt =
  (
 SELECT COUNT(*)
 FROM [dbo].[DFS_QrysPlans]
 WHERE [query_hash] = @query_hash
     AND [query_plan_hash] = @query_plan_hash
  );
  IF
     (@cnt = 0
     )
 BEGIN
   INSERT INTO [dbo].[DFS_QrysPlans]
   ( [query_hash], 
     [query_plan_hash], 
     [UID], 
     [PerfType], 
     [text], 
     [query_plan], 
     [CreateDate]
   ) 
   VALUES
   (
     @query_hash
   , @query_plan_hash
   , @UID
   , 'C'
   , @SQL
   , @plan
   , GETDATE()
   );
  END;
  UPDATE [dbo].[DFS_CPU_BoundQry]
    SET Processed = 1, [text] = null, query_plan = null
  WHERE [query_hash] = @query_hash
   AND [query_plan_hash] = @query_plan_hash
   AND processed = 0;
  FETCH NEXT FROM db_cursor INTO @query_hash, @query_plan_hash, @UID, @cnt;
     END;
 CLOSE db_cursor;
 DEALLOCATE db_cursor;
 UPDATE [dbo].[DFS_CPU_BoundQry]
   SET Processed = 1, [text] = null, query_plan = null
 WHERE [UID] IN
 (
     SELECT B.[UID]
     FROM [dbo].[DFS_QryPlanBridge] AS A
   JOIN [dbo].[DFS_CPU_BoundQry] AS B
   ON B.[query_hash] = A.[query_hash]
    AND B.[query_plan_hash] = A.[query_plan_hash]
     WHERE B.processed = 0
 );
    END;