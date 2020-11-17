-- W. Dale Miller @ 2016
USE [DFINAnalytics];
GO

-- drop table DFS_TableGrowthHistory
IF NOT EXISTS
(
    SELECT 1
    FROM   information_schema.tables
    WHERE  table_name = 'DFS_TableGrowthHistory'
)
    CREATE TABLE [dbo].[DFS_TableGrowthHistory]
    ([SvrName]    [SYSNAME] NOT NULL, 
     [DBName]     [SYSNAME] NOT NULL, 
     [SchemaName] [SYSNAME] NOT NULL, 
     [TableName]  [SYSNAME] NOT NULL, 
     [RowCounts]  [BIGINT] NOT NULL, 
     [Used_MB]    [NUMERIC](36, 2) NULL, 
     [Unused_MB]  [NUMERIC](36, 2) NULL, 
     [Total_MB]   [NUMERIC](36, 2) NULL, 
     RunID        NVARCHAR(60) NULL, 
     CreateDate   DATETIME DEFAULT GETDATE(), 
     RowNbr       INT IDENTITY(1, 1) NOT NULL
    )
    ON [PRIMARY];
GO
USE master;
go
-- exec DFINAnalytics.dbo.UTIL_GetTableRowsSize 'AP_ProductionAF_Data'
CREATE PROCEDURE dbo.sp_UTIL_GetTableRowsSize (@RunID nvarchar(60))
AS
    BEGIN
        DECLARE @DBNAME NVARCHAR(100);
        SET @DBNAME = DB_NAME();
        INSERT INTO [dbo].[DFS_TableGrowthHistory]
        ([SvrName], 
         [DBName], 
         [SchemaName], 
         [TableName], 
         [RowCounts], 
         [Used_MB], 
         [Unused_MB], 
         [Total_MB], 
         [RunID], 
         [CreateDate]
        )
        SELECT @@servername AS SvrName, 
               [DBNAME] = @DBNAME, 
               s.Name AS SchemaName, 
               t.Name AS TableName, 
               p.rows AS RowCounts, 
               CAST(ROUND((SUM(a.used_pages) / 128.00), 2) AS NUMERIC(36, 2)) AS Used_MB, 
               CAST(ROUND((SUM(a.total_pages) - SUM(a.used_pages)) / 128.00, 2) AS NUMERIC(36, 2)) AS Unused_MB, 
               CAST(ROUND((SUM(a.total_pages) / 128.00), 2) AS NUMERIC(36, 2)) AS Total_MB, 
               @RunID AS RunID, 
               GETDATE() AS CreateDate
        FROM   sys.tables t
        INNER JOIN sys.indexes i
                   ON t.OBJECT_ID = i.object_id
        INNER JOIN sys.partitions p
                   ON i.object_id = p.OBJECT_ID
                      AND i.index_id = p.index_id
        INNER JOIN sys.allocation_units a
                   ON p.partition_id = a.container_id
        INNER JOIN sys.schemas s
                   ON t.schema_id = s.schema_id
        GROUP BY t.Name, 
                 s.Name, 
                 p.Rows;
        --ORDER BY s.Name, t.Name

    END;
GO
-- Unmodified source:
--SELECT s.Name AS SchemaName, 
--       t.Name AS TableName, 
--       p.rows AS RowCounts, 
--       CAST(ROUND((SUM(a.used_pages) / 128.00), 2) AS NUMERIC(36, 2)) AS Used_MB, 
--       CAST(ROUND((SUM(a.total_pages) - SUM(a.used_pages)) / 128.00, 2) AS NUMERIC(36, 2)) AS Unused_MB, 
--       CAST(ROUND((SUM(a.total_pages) / 128.00), 2) AS NUMERIC(36, 2)) AS Total_MB
--INTO DFS_TableGrowthHistory
--FROM   sys.tables t
--INNER JOIN sys.indexes i
--           ON t.OBJECT_ID = i.object_id
--INNER JOIN sys.partitions p
--           ON i.object_id = p.OBJECT_ID
--              AND i.index_id = p.index_id
--INNER JOIN sys.allocation_units a
--           ON p.partition_id = a.container_id
--INNER JOIN sys.schemas s
--           ON t.schema_id = s.schema_id
--GROUP BY t.Name, 
--         s.Name, 
--         p.Rows
--ORDER BY s.Name, 
--         t.Name;
GO