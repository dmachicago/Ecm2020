
--* USEDFINAnalytics;
declare @stmt nvarchar(max) ;

set @stmt = 'declare @DBname nvarchar(100) = db_name(); print @DBName ;
 IF OBJECT_ID(''tempdb..#TMP_WorkLoad'') IS NOT NULL
     DROP TABLE #TMP_WorkLoad;
 WITH CTE_QO
 AS (SELECT occurrence
   FROM sys.dm_exec_query_optimizer_info
   WHERE([counter] = ''optimizations'')),
 QOInfo
 AS (SELECT [counter], 
   [%] = CAST((occurrence * 100.00) /
   (
  SELECT occurrence
  FROM CTE_QO
   ) AS DECIMAL(5, 2))
   FROM sys.dm_exec_query_optimizer_info
   WHERE [counter] IN(''optimizations'', ''trivial plan'', ''no plan'', ''search 0'', ''search 1'', ''search 2'', ''timeout'', ''memory limit exceeded'', ''insert stmt'', ''delete stmt'', ''update stmt'', ''merge stmt'', ''contains subquery'', ''view reference'', ''remote query'', ''dynamic cursor request'', ''fast forward cursor request''))
 SELECT [optimizations] AS [OptimizationPct], 
 [trivial plan] AS [TrivialPlanPct], 
 [no plan] AS [NoPlanPct], 
 [search 0] AS [Search0Pct], 
 [search 1] AS [Search1Pct], 
 [search 2] AS [Search2Pct], 
 [timeout] AS [TimeoutPct], 
 [memory limit exceeded] AS [MemoryLimitExceededPct], 
 [insert stmt] AS [InsertStmtPct], 
 [delete stmt] AS [DeleteStmt], 
 [update stmt] AS [UpdateStmt], 
 [merge stmt] AS [MergeStmt], 
 [contains subquery] AS [ContainsSubqueryPct], 
 [view reference] AS [ViewReferencePct], 
 [remote query] AS [RemoteQueryPct], 
 [dynamic cursor request] AS [DynamicCursorRequestPct], 
 [fast forward cursor request] AS [FastForwardCursorRequestPct]
 INTO #TMP_WorkLoad
 FROM QOInfo PIVOT(MAX([%]) FOR [counter] IN([optimizations], 
   [trivial plan], 
   [no plan], 
   [search 0], 
   [search 1], 
   [search 2], 
   [timeout], 
   [memory limit exceeded], 
   [insert stmt], 
   [delete stmt], 
   [update stmt], 
   [merge stmt], 
   [contains subquery], 
   [view reference], 
   [remote query], 
   [dynamic cursor request], 
   [fast forward cursor request])) AS p;
 INSERT INTO dbo.DFS_Workload
 ([OptimizationPct], 
  [TrivialPlanPct], 
  [NoPlanPct], 
  [Search0Pct], 
  [Search1Pct], 
  [Search2Pct], 
  [TimeoutPct], 
  [MemoryLimitExceededPct], 
  [InsertStmtPct], 
  [DeleteStmt], 
  [UpdateStmt], 
  [MergeStmt], 
  [ContainsSubqueryPct], 
  [ViewReferencePct], 
  [RemoteQueryPct], 
  [DynamicCursorRequestPct], 
  [FastForwardCursorRequestPct]
 )
   SELECT *
   FROM #TMP_WorkLoad;

		update dbo.DFS_Workload set SvrName = @@servername, DBName = DB_NAME() where SvrName is null and DBName is null;
';
print @stmt;
exec sp_ExecuteSql @stmt;

select top 100 * from dbo.DFS_Workload;
