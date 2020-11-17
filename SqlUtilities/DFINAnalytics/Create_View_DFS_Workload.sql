--* USEDFINAnalytics;
GO
-- drop view view_DFS_Workload_Averages
-- select * from view_DFS_Workload_Averages 

if exists (select 1 from INFORMATION_SCHEMA.TABLES where TABLE_NAME = 'view_DFS_Workload_Averages')
drop view view_DFS_Workload_Averages;
go

CREATE VIEW view_DFS_Workload_Averages
AS
     SELECT DISTINCT 
     --[SVRNAME], 
     [DBName], 
     AVG([OptimizationPct]) AS AvgOptimizationPct, 
     AVG([TrivialPlanPct]) AS AvgTrivialPlanPct
     ,
     --,[NoPlanPct]
     --,[Search0Pct]
     --,[Search1Pct]
     --,[Search2Pct]
     --,[TimeoutPct]
     --,[MemoryLimitExceededPct] 
     AVG([InsertStmtPct]) AS AvgInsertStmtPct, 
     AVG([DeleteStmt]) AS AvgDeleteStmtPct, 
     AVG([UpdateStmt]) AS AvgUpdateStmtPct, 
     AVG([MergeStmt]) AS AvgMergeStmtPct, 
     AVG([ContainsSubqueryPct]) AS AvgContainsSubqueryPct, 
     AVG([ViewReferencePct]) AS AvgViewReferencePct
     ,
     --,[RemoteQueryPct]
     --,[DynamicCursorRequestPct]
     --,[FastForwardCursorRequestPct]
     --,[RowID] 
     MIN([RunDate]) AS StartDate, 
     MAX([RunDate]) AS EndDate, 
     COUNT(*) AS RowSampleSize
     FROM [DFINAnalytics].dbo.[DFS_Workload]
     GROUP BY [DBName];
GO

-- drop view view_DFS_Workload_AveragesByDay
-- select * from view_DFS_Workload_AveragesByDay
if exists (select 1 from INFORMATION_SCHEMA.TABLES where TABLE_NAME = 'view_DFS_Workload_AveragesByDay')
drop view view_DFS_Workload_AveragesByDay;
go

CREATE VIEW view_DFS_Workload_AveragesByDay
AS
     SELECT DISTINCT 
     CONVERT(DATE, RunDate) AS RunDay, 
     datename(dw, CONVERT(DATE, RunDate)) AS DOW, 
     AVG([OptimizationPct]) AS AvgOptimizationPct, 
     AVG([TrivialPlanPct]) AS AvgTrivialPlanPct
     ,
     --,[NoPlanPct]
     --,[Search0Pct]
     --,[Search1Pct]
     --,[Search2Pct]
     --,[TimeoutPct]
     --,[MemoryLimitExceededPct] 
     AVG([InsertStmtPct]) AS AvgInsertStmtPct, 
     AVG([DeleteStmt]) AS AvgDeleteStmtPct, 
     AVG([UpdateStmt]) AS AvgUpdateStmtPct, 
     AVG([MergeStmt]) AS AvgMergeStmtPct, 
     AVG([ContainsSubqueryPct]) AS AvgContainsSubqueryPct, 
     AVG([ViewReferencePct]) AS AvgViewReferencePct
     ,
     --,[RemoteQueryPct]
     --,[DynamicCursorRequestPct]
     --,[FastForwardCursorRequestPct]
     --,[RowID] 
     MIN([RunDate]) AS StartDate, 
     MAX([RunDate]) AS EndDate, 
     COUNT(*) AS RowSampleSize
     FROM [DFINAnalytics].dbo.[DFS_Workload]
     GROUP BY CONVERT(DATE, RunDate), 
  [DBName];
