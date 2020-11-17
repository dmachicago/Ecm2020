
--* USEDFINAnalytics
go

if not exists (select 1 from sys.tables where name = 'DFS_IO_BoundQry2000')
begin
CREATE TABLE [dbo].[DFS_IO_BoundQry2000](
	[SVRName] [NVARCHAR](150) NULL,
	[DBName] [varchar](6) NOT NULL,
	[text] [nvarchar](max) NULL,
	[query_plan] [xml] NULL,
	[sql_handle] [varbinary](64) NOT NULL,
	[statement_start_offset] [int] NOT NULL,
	[statement_end_offset] [int] NOT NULL,
	[plan_generation_num] [bigint] NULL,
	[plan_handle] [varbinary](64) NOT NULL,
	[creation_time] [datetime] NULL,
	[last_execution_time] [datetime] NULL,
	[execution_count] [bigint] NOT NULL,
	[total_worker_time] [bigint] NOT NULL,
	[last_worker_time] [bigint] NOT NULL,
	[min_worker_time] [bigint] NOT NULL,
	[max_worker_time] [bigint] NOT NULL,
	[total_physical_reads] [bigint] NOT NULL,
	[last_physical_reads] [bigint] NOT NULL,
	[min_physical_reads] [bigint] NOT NULL,
	[max_physical_reads] [bigint] NOT NULL,
	[total_logical_writes] [bigint] NOT NULL,
	[last_logical_writes] [bigint] NOT NULL,
	[min_logical_writes] [bigint] NOT NULL,
	[max_logical_writes] [bigint] NOT NULL,
	[total_logical_reads] [bigint] NOT NULL,
	[last_logical_reads] [bigint] NOT NULL,
	[min_logical_reads] [bigint] NOT NULL,
	[max_logical_reads] [bigint] NOT NULL,
	[total_clr_time] [bigint] NOT NULL,
	[last_clr_time] [bigint] NOT NULL,
	[min_clr_time] [bigint] NOT NULL,
	[max_clr_time] [bigint] NOT NULL,
	[total_elapsed_time] [bigint] NOT NULL,
	[last_elapsed_time] [bigint] NOT NULL,
	[min_elapsed_time] [bigint] NOT NULL,
	[max_elapsed_time] [bigint] NOT NULL,
	[query_hash] [binary](8) NULL,
	[query_plan_hash] [binary](8) NULL,
	[total_rows] [bigint] NULL,
	[last_rows] [bigint] NULL,
	[min_rows] [bigint] NULL,
	[max_rows] [bigint] NULL,
	[statement_sql_handle] [varbinary](64) NULL,
	[statement_context_id] [bigint] NULL,
	[total_dop] [bigint] NULL,
	[last_dop] [bigint] NULL,
	[min_dop] [bigint] NULL,
	[max_dop] [bigint] NULL,
	[total_grant_kb] [bigint] NULL,
	[last_grant_kb] [bigint] NULL,
	[min_grant_kb] [bigint] NULL,
	[max_grant_kb] [bigint] NULL,
	[total_used_grant_kb] [bigint] NULL,
	[last_used_grant_kb] [bigint] NULL,
	[min_used_grant_kb] [bigint] NULL,
	[max_used_grant_kb] [bigint] NULL,
	[total_ideal_grant_kb] [bigint] NULL,
	[last_ideal_grant_kb] [bigint] NULL,
	[min_ideal_grant_kb] [bigint] NULL,
	[max_ideal_grant_kb] [bigint] NULL,
	[total_reserved_threads] [bigint] NULL,
	[last_reserved_threads] [bigint] NULL,
	[min_reserved_threads] [bigint] NULL,
	[max_reserved_threads] [bigint] NULL,
	[total_used_threads] [bigint] NULL,
	[last_used_threads] [bigint] NULL,
	[min_used_threads] [bigint] NULL,
	[max_used_threads] [bigint] NULL,
	[RunDate] [datetime] NOT NULL,
	[SSVER] [nvarchar](300) NULL,
	[RunID] [int] NOT NULL,
	[UID] [uniqueidentifier] NOT NULL,
	[Processed] [int] NULL
) ON [PRIMARY] ;

ALTER TABLE [dbo].[DFS_IO_BoundQry2000] ADD  DEFAULT (newid()) FOR [UID]

ALTER TABLE [dbo].[DFS_IO_BoundQry2000] ADD  DEFAULT ((0)) FOR [Processed]

End
go
IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'DFS_IO_BoundQry2000_ProcessTable'
)
    DROP PROCEDURE DFS_IO_BoundQry2000_ProcessTable;
GO
/*
exec DFS_IO_BoundQry2000_ProcessTable
*/
CREATE PROCEDURE DFS_IO_BoundQry2000_ProcessTable
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
     B.[query_hash], B.[query_plan_hash], MAX(B.uid) AS [UID], COUNT(*) AS cnt
     FROM
   [dbo].[DFS_QryPlanBridge] AS A
   JOIN [dbo].[DFS_IO_BoundQry2000] AS B
   ON B.[query_hash] = A.[query_hash]
    AND B.[query_plan_hash] = A.[query_plan_hash]
     WHERE B.processed = 0
     GROUP BY B.[query_hash], B.[query_plan_hash];
 OPEN db_cursor;
 FETCH NEXT FROM db_cursor INTO @query_hash, @query_plan_hash, @UID, @cnt;
 WHILE @@FETCH_STATUS = 0
     BEGIN
  SET @i = @i + 1;
  PRINT 'I: ' + CAST(@i AS NVARCHAR(15));
  SET @SQL =
  (
 SELECT [text]
 FROM [dbo].[DFS_IO_BoundQry2000]
 WHERE [UID] = @uid
  );
  SET @plan =
  (
 SELECT [query_plan]
 FROM [dbo].[DFS_IO_BoundQry2000]
 WHERE [UID] = @uid
  );
  SET @cnt =
  (
 SELECT COUNT(*)
 FROM [dbo].[DFS_QryPlanBridge]
 WHERE [query_hash] = @query_hash
     AND [query_plan_hash] = @query_plan_hash
  );
  IF(@cnt = 0)
 BEGIN
   INSERT INTO [dbo].[DFS_QryPlanBridge] ([query_hash], [query_plan_hash], [PerfType], [TblType], [CreateDate], [LastUpdate], NbrHits) 
 VALUES
   (
 @query_hash, 
 @query_plan_hash, 
 'C', 
 '2000', 
 GETDATE(), 
 GETDATE(), 
 1
   );
  END;
  SET @cnt =
  (
 SELECT COUNT(*)
 FROM [dbo].[DFS_QrysPlans]
 WHERE [query_hash] = @query_hash
     AND [query_plan_hash] = @query_plan_hash
  );
  IF(@cnt = 0)
 BEGIN
   INSERT INTO [dbo].[DFS_QrysPlans] ([query_hash], [query_plan_hash], [UID], [PerfType], [text], [query_plan], [CreateDate]) 
 VALUES
   (
 @query_hash, 
 @query_plan_hash, 
 @UID, 
 'C', 
 @SQL, 
 @plan, 
 GETDATE()
   );
  END;
  UPDATE [dbo].[DFS_IO_BoundQry2000]
    SET Processed = 1, [text] = null, query_plan = null
  WHERE [query_hash] = @query_hash
   AND [query_plan_hash] = @query_plan_hash;
  FETCH NEXT FROM db_cursor INTO @query_hash, @query_plan_hash, @UID, @cnt;
     END;
 CLOSE db_cursor;
 DEALLOCATE db_cursor;
 UPDATE [dbo].[DFS_IO_BoundQry2000]
   SET Processed = 1, [text] = null, query_plan = null
 WHERE [UID] IN
 (
     SELECT B.[UID]
     FROM
   [dbo].[DFS_QryPlanBridge] AS A
   JOIN [dbo].[DFS_IO_BoundQry2000] AS B
   ON B.[query_hash] = A.[query_hash]
    AND B.[query_plan_hash] = A.[query_plan_hash]
     WHERE B.processed = 0
 );
    END;