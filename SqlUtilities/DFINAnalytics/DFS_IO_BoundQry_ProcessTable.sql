go
--* USEDFINAnalytics
go
IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'UTIL_IO_BoundQry'
)
    DROP PROCEDURE UTIL_IO_BoundQry;
GO

/*
exec UTIL_IO_BoundQry
*/

CREATE PROCEDURE UTIL_IO_BoundQry
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
     B.[query_hash], B.[query_plan_hash], MAX(uid) AS [UID], COUNT(*) AS cnt
     FROM
   [dbo].[DFS_QryPlanBridge] AS A
   JOIN [dbo].[DFS_IO_BoundQry] AS B
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
 FROM [dbo].[DFS_IO_BoundQry]
 WHERE [UID] = @uid
  );
  SET @plan =
  (
 SELECT [query_plan]
 FROM [dbo].[DFS_IO_BoundQry]
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
  UPDATE [dbo].[DFS_IO_BoundQry]
    SET Processed = 1, [text] = null, query_plan = null
  WHERE [query_hash] = @query_hash
   AND [query_plan_hash] = @query_plan_hash
   AND processed = 0;
  FETCH NEXT FROM db_cursor INTO @query_hash, @query_plan_hash, @UID, @cnt;
     END;
 CLOSE db_cursor;
 DEALLOCATE db_cursor;
 UPDATE [dbo].[DFS_IO_BoundQry]
   SET Processed = 1, [text] = null, query_plan = null
 WHERE [UID] IN
 (
     SELECT B.[UID]
     FROM
   [dbo].[DFS_QryPlanBridge] AS A
   JOIN [dbo].[DFS_IO_BoundQry] AS B
   ON B.[query_hash] = A.[query_hash]
    AND B.[query_plan_hash] = A.[query_plan_hash]
     WHERE B.processed = 0
 );
    END;