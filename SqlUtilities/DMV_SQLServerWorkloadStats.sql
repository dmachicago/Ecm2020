
/*
DMV_SQLServerWorkloadStats.sql
The DMV sys.dm_exec_query_optimizer_info exposes statistics about 
optimizations performed by the SQL Server query optimizer. These 
values are cumulative and begin recording when SQL Server starts. 
For more information on the query optimizer, see the Query Processing 
Architecture Guide.

This CTE uses this DMV to provide information about the workload, such 
as the percentage of queries that reference a view. The results returned 
by this query do not indicate a performance problem by themselves, but 
can expose underlying issues when combined with users' complaints of 
slow-performing queries.
*/
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
     SELECT [optimizations] AS [optimizations %], 
            [trivial plan] AS [trivial plan %], 
            [no plan] AS [no plan %], 
            [search 0] AS [search 0 %], 
            [search 1] AS [search 1 %], 
            [search 2] AS [search 2 %], 
            [timeout] AS [timeout %], 
            [memory limit exceeded] AS [memory limit exceeded %], 
            [insert stmt] AS [insert stmt %], 
            [delete stmt] AS [delete stmt], 
            [update stmt] AS [update stmt], 
            [merge stmt] AS [merge stmt], 
            [contains subquery] AS [contains subquery %], 
            [view reference] AS [view reference %], 
            [remote query] AS [remote query %], 
            [dynamic cursor request] AS [dynamic cursor request %], 
            [fast forward cursor request] AS [fast forward cursor request %]
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
GO
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
