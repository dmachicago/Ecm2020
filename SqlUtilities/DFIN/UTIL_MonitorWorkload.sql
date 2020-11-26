-- W. Dale Miller @ 1/1/2019
use [DFINAnalytics];
go

/*
--select '[' + column_name +'],' from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = 'DFS_Workload'
--go
--drop table DFS_Workload;
--go
--ALTER TABLE DFS_Workload
--ADD RowID BIGINT IDENTITY(1, 1) NOT NULL;
--ALTER TABLE DFS_Workload
--ADD RunDate DATETIME DEFAULT GETDATE() NOT NULL;
--exec sp_UTIL_MonitorWorkload
--select * from DFS_Workload
--GO
*/

-- drop table DFINAnalytics.dbo.[DFS_Workload]
IF NOT EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.TABLES
    WHERE TABLE_NAME = 'DFS_Workload'
)
    BEGIN
        CREATE TABLE DFINAnalytics.dbo.[DFS_Workload]
        (SVRNAME NVARCHAR(150) NULL,
		DBNAME  NVARCHAR(150) NULL,
		SSVER   NVARCHAR(250) NULL,
			[OptimizationPct]             [DECIMAL](5, 2) NULL, 
         [TrivialPlanPct]              [DECIMAL](5, 2) NULL, 
         [NoPlanPct]                   [DECIMAL](5, 2) NULL, 
         [Search0Pct]                  [DECIMAL](5, 2) NULL, 
         [Search1Pct]                  [DECIMAL](5, 2) NULL, 
         [Search2Pct]                  [DECIMAL](5, 2) NULL, 
         [TimeoutPct]                  [DECIMAL](5, 2) NULL, 
         [MemoryLimitExceededPct]      [DECIMAL](5, 2) NULL, 
         [InsertStmtPct]               [DECIMAL](5, 2) NULL, 
         [DeleteStmt]                  [DECIMAL](5, 2) NULL, 
         [UpdateStmt]                  [DECIMAL](5, 2) NULL, 
         [MergeStmt]                   [DECIMAL](5, 2) NULL, 
         [ContainsSubqueryPct]         [DECIMAL](5, 2) NULL, 
         [ViewReferencePct]            [DECIMAL](5, 2) NULL, 
         [RemoteQueryPct]              [DECIMAL](5, 2) NULL, 
         [DynamicCursorRequestPct]     [DECIMAL](5, 2) NULL, 
         [FastForwardCursorRequestPct] [DECIMAL](5, 2) NULL, 
         RowID                         BIGINT IDENTITY(1, 1) NOT NULL, 
         RunDate                       DATETIME DEFAULT GETDATE() NOT NULL
        )
        ON [PRIMARY];
END;

--The below common_table_expression (CTE) uses this DMV to provide 
--information about the workload, such as the percentage of queries 
--that reference a view. The results returned by this query do not 
--indicate a performance problem by themselves, but can expose 
--underlying issues when combined with users' complaints of slow-performing 
--queries.
--exec sp_UTIL_MonitorWorkload
IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'sp_UTIL_MonitorWorkload'
)
    BEGIN
        DROP PROCEDURE sp_UTIL_MonitorWorkload;
END;
GO
/*

DECLARE @RunID BIGINT;
EXEC @RunID = sp_UTIL_GetSeq;
PRINT 'RUN ID: ' + cast(@RunID as nvarchar(10));
DECLARE @command NVARCHAR(1000);
SELECT @command = 'USE ?; exec sp_UTIL_MonitorWorkload ' + CAST(@RunID AS NVARCHAR(10)) ;
EXEC sp_MSforeachdb @command;
*/

USE master;
go
-- exec sp_UTIL_MonitorWorkload 
IF EXISTS (SELECT 1 FROM sys.procedures WHERE name = 'sp_UTIL_MonitorWorkload')
	drop PROCEDURE sp_UTIL_MonitorWorkload 
go
CREATE PROCEDURE sp_UTIL_MonitorWorkload 
AS
	--sp_UTIL_MonitorWorkload.sql
    BEGIN
		declare @DBname nvarchar(100) = db_name();
		declare @msg nvarchar(1000);
		set @msg = 'WORKLOAD Processing: ' + @DBname;
		exec DFINAnalytics.dbo.PrintImmediate @msg;
        IF OBJECT_ID('tempdb..#TMP_WorkLoad') IS NOT NULL
            DROP TABLE #TMP_WorkLoad;
        WITH CTE_QO
             AS (SELECT occurrence
                 FROM sys.dm_exec_query_optimizer_info
                 WHERE([counter] = 'optimizations')),
             QOInfo
             AS (SELECT [counter], 
                        [%] = CAST((occurrence * 100.00) /
                 (
                     SELECT occurrence
                     FROM CTE_QO
                 ) AS DECIMAL(5, 2))
                 FROM sys.dm_exec_query_optimizer_info
                 WHERE [counter] IN('optimizations', 'trivial plan', 'no plan', 'search 0', 'search 1', 'search 2', 'timeout', 'memory limit exceeded', 'insert stmt', 'delete stmt', 'update stmt', 'merge stmt', 'contains subquery', 'view reference', 'remote query', 'dynamic cursor request', 'fast forward cursor request'))
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
        INSERT INTO DFINAnalytics.dbo.DFS_Workload
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

		update DFINAnalytics.dbo.DFS_Workload 
			set SvrName = @@servername, 
			DBName = @DBname ,
			SSVER = @@VERSION
			where SvrName is null and DBName is null;

    END;
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016