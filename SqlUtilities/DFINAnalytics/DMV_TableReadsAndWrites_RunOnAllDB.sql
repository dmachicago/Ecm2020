USE master;
GO
--declare @DBName nvarchar(max) ='Invesco_ProductionAF_Data';
--declare @Schema nvarchar(max) = 'dbo' ;
--declare @PName nvarchar(max) = 'UTIL_TrackTblReadsWrites';
--declare @ProcSQL nvarchar(max);

IF EXISTS
(
    SELECT 1
    FROM   sys.procedures
    WHERE  name = 'DFS_TableReadsAndWrites_RunOnAllDB'
)
    DROP PROCEDURE DFS_TableReadsAndWrites_RunOnAllDB;
GO
-- exec DFS_TableReadsAndWrites_RunOnAllDB ;
CREATE PROCEDURE DFS_TableReadsAndWrites_RunOnAllDB
AS
    BEGIN
        DECLARE @stmt NVARCHAR(MAX);
        SET @stmt = 'Use ? ;';
        SET @stmt = @stmt + 'INSERT INTO DFINAnalytics.dbo.[DFS_TableReadWrites]
        ([ServerName], 
         [DBName], 
         [TableName], 
         [Reads], 
         [Writes], 
         [Reads&Writes], 
         [SampleDays], 
         [SampleSeconds], 
         [RunDate]
        )
               SELECT @@ServerName AS ServerName, 
                      DB_NAME() AS DBName, 
                      OBJECT_NAME(ddius.object_id) AS TableName, 
                      SUM(ddius.user_seeks + ddius.user_scans + ddius.user_lookups) AS Reads, 
                      SUM(ddius.user_updates) AS Writes, 
                      SUM(ddius.user_seeks + ddius.user_scans + ddius.user_lookups + ddius.user_updates) AS [Reads&Writes], 
               (
                   SELECT DATEDIFF(s, create_date, GETDATE()) / 86400.0
                   FROM master.sys.databases
                   WHERE name = ''tempdb''
               ) AS SampleDays, 
               (
                   SELECT DATEDIFF(s, create_date, GETDATE()) AS SecoundsRunnig
                   FROM master.sys.databases
                   WHERE name = ''tempdb''
               ) AS SampleSeconds, 
                      GETDATE() AS RunDate
               FROM sys.dm_db_index_usage_stats ddius
                    INNER JOIN sys.indexes i ON ddius.object_id = i.object_id
                                                AND i.index_id = ddius.index_id
               WHERE OBJECTPROPERTY(ddius.object_id, ''IsUserTable'') = 1
                     AND ddius.database_id = DB_ID()
               GROUP BY OBJECT_NAME(ddius.object_id)
               ORDER BY [Reads&Writes] DESC;
';
        EXEC sp_MSForEachDB 
             @stmt;
        DELETE FROM DFINAnalytics.dbo.[DFS_TableReadWrites]
        WHERE       DBName IN('master', 'tempdb', 'msdb', 'model', 'DBA');
    END;