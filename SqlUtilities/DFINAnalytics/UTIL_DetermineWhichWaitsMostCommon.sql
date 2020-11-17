
IF NOT EXISTS
(
    SELECT 1
    FROM sys.tables
    WHERE name = 'DFS_MonitorMostCommonWaits'
)
    BEGIN
 CREATE TABLE [dbo].[DFS_MonitorMostCommonWaits]
 ([SVR]   [NVARCHAR](150) NULL, 
  [DBName]  [NVARCHAR](150) NULL, 
  [wait_type]    [NVARCHAR](60) NOT NULL, 
  [wait_time_ms] [BIGINT] NOT NULL, 
  [Percentage]   [NUMERIC](38, 15) NULL, 
  [CreateDate]   [DATETIME] NOT NULL, 
  [UID]   [UNIQUEIDENTIFIER] NULL
 )
 ON [PRIMARY];
 CREATE INDEX PI_DFS_MonitorMostCommonWaits
 ON DFS_MonitorMostCommonWaits
 ([UID]
 );
END; 
GO
IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'UTIL_MonitorMostCommonWaits'
)
    DROP PROC UTIL_MonitorMostCommonWaits;
GO
CREATE PROC UTIL_MonitorMostCommonWaits
AS
    BEGIN
 INSERT INTO DFS_MonitorMostCommonWaits
   SELECT TOP 10 @@servername AS SVR, 
   DB_NAME() AS DBName, 
   wait_type, 
   wait_time_ms, 
   Percentage = 100. * wait_time_ms / SUM(wait_time_ms) OVER(), 
   GETDATE() AS CreateDate, 
   NEWID() AS [UID]
   FROM sys.dm_os_wait_stats wt
   WHERE wt.wait_type NOT LIKE '%SLEEP%'
   ORDER BY Percentage DESC;
    END;