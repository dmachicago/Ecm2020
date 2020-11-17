
SELECT TOP 250 * FROM [dbo].[DFS_BlockingHistory] ORDER BY RowNbr desc
SELECT TOP 25 * FROM [dbo].[DFS_CPU_BoundQry2000] ORDER BY RowNbr desc
SELECT TOP 25 * FROM [dbo].[DFS_IO_BoundQry2000] ORDER BY RowNbr DESC

SELECT TOP 250 * FROM [dbo].[DFS_TableGrowthHistory] 
WHERE Tablename NOT LIKE 'DFS_%'
ORDER BY DBName,TableName, RowNbr desc;

SELECT TOP 250 * FROM [dbo].[DFS_Workload] ORDER BY RowNbr desc
