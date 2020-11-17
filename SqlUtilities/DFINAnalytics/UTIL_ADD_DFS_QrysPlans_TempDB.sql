
/*
D:\dev\SQL\DFINAnalytics\UTIL_ADD_DFS_QrysPlans_TempDB.sql

delete from [dbo].[DFS_QrysPlans] 
delete from [dbo].[DFS_QryPlanBridge] 
select * from [dbo].[DFS_QryPlanBridge] 
update [DFS_CPU_BoundQry2000] set processed = 0 
*/
/*

update [dbo].[DFS_CPU_BoundQry2000] set processed = 0 ;
update [dbo].[DFS_IO_BoundQry2000] set processed = 0 ;
update [dbo].[DFS_CPU_BoundQry] set processed = 0 ;
update [dbo].[DFS_CPU_BoundQry] set processed = 0 ;


select count(*) from [dbo].[DFS_CPU_BoundQry2000] where processed = 1 ;
select count(*) from [dbo].[DFS_IO_BoundQry2000] where processed  = 1 ;
select count(*) from [dbo].[DFS_CPU_BoundQry] where processed  = 1 ;
select count(*) from [dbo].[DFS_CPU_BoundQry] where processed  = 1 ;

select count(*) from [dbo].[DFS_CPU_BoundQry2000] where processed = 0 ;
select count(*) from [dbo].[DFS_IO_BoundQry2000] where processed  = 0 ;
select count(*) from [dbo].[DFS_CPU_BoundQry] where processed  = 0 ;
select count(*) from [dbo].[DFS_CPU_BoundQry] where processed  = 0 ;
*/
IF OBJECT_ID('tempdb..#PrintImmediate') IS NOT NULL
    BEGIN
 PRINT 'Replacing #PrintImmediate';
 DROP PROCEDURE #PrintImmediate;
END;

GO
CREATE PROCEDURE #PrintImmediate (@MSG AS NVARCHAR(MAX))
AS
    BEGIN
 RAISERROR(@MSG, 10, 1) WITH NOWAIT;
    END;
GO

IF OBJECT_ID('tempdb..#UTIL_Process_QrysPlans') IS NOT NULL
    BEGIN
 PRINT 'Replacing #UTIL_Process_QrysPlans';
 DROP PROCEDURE #UTIL_Process_QrysPlans;
END;
GO

/* exec #UTIL_Process_QrysPlans*/

CREATE PROCEDURE #UTIL_Process_QrysPlans
AS
    BEGIN
 DECLARE @query_hash BINARY(8);
 DECLARE @query_plan_hash BINARY(8);
 DECLARE @UID UNIQUEIDENTIFIER;
 DECLARE @PerfType CHAR(1);
 DECLARE @TBLID NVARCHAR(10);
 DECLARE @stmt NVARCHAR(1000);
 DECLARE @msg NVARCHAR(1000);
 DECLARE @i INT= 0;
 DECLARE @rc INT= 0;
 DECLARE db_cursor CURSOR
 FOR SELECT TOP 5 query_hash, 
    query_plan_hash, 
    [UID], 
    'C' AS PerfType, 
    '2000' AS TBLID
     FROM   [dbo].[DFS_CPU_BoundQry2000]
     WHERE   Processed = 0
     UNION ALL
     SELECT TOP 5 query_hash, 
    query_plan_hash, 
    [UID], 
    'I' AS PerfType, 
    '2000' AS TBLID
     FROM   [dbo].[DFS_IO_BoundQry2000]
     WHERE   Processed = 0
     UNION ALL
     SELECT TOP 5 query_hash, 
    query_plan_hash, 
    [UID], 
    'I' AS PerfType, 
    NULL AS TBLID
     FROM   [dbo].[DFS_IO_BoundQry]
     WHERE   Processed = 0
     UNION ALL
     SELECT TOP 5 query_hash, 
    query_plan_hash, 
    [UID], 
    'C' AS PerfType, 
    NULL AS TBLID
     FROM  [dbo].[DFS_CPU_BoundQry]
     WHERE Processed = 0;
 OPEN db_cursor;
 FETCH NEXT FROM db_cursor INTO @query_hash, @query_plan_hash, @UID, @PerfType, @TBLID;
 WHILE @@FETCH_STATUS = 0
     BEGIN
  SET @i = @i + 1;
  SET @msg = 'Processing: ' + CAST(@i AS NVARCHAR(15));
  EXEC PrintImmediate 
  @msg;
  EXEC #UTIL_ADD_DFS_QrysPlans 
  @query_hash, 
  @query_plan_hash, 
  @UID, 
  @PerfType, 
  @TBLID;
  FETCH NEXT FROM db_cursor INTO @query_hash, @query_plan_hash, @UID, @PerfType, @TBLID;
     END;
 CLOSE db_cursor;
 DEALLOCATE db_cursor;
    END;
GO
IF OBJECT_ID('tempdb..#UTIL_ADD_DFS_QrysPlans') IS NOT NULL
    BEGIN
 PRINT 'Replacing #UTIL_ADD_DFS_QrysPlans';
 DROP PROCEDURE #UTIL_ADD_DFS_QrysPlans;
END;
GO

/*
delete from [dbo].[DFS_QryPlanBridge];
delete from [dbo].[DFS_QrysPlans];

select top 100 * from [dbo].[DFS_QryPlanBridge];
select top 100 * from [dbo].[DFS_QrysPlans];
select top 10 query_hash, query_plan_hash, [UID], 'C' as PerfType, '2000' TBLID from [dbo].[DFS_CPU_BoundQry2000] 

exec UTIL_ADD_DFS_QrysPlans 0x8FF8B9B49B3D4D91, 0x23760A4951D12752,'BEE20640-A8B2-4414-9531-32BE9CA6CE11', 'C', '2000'

exec UTIL_ADD_DFS_QrysPlans 0xFFEA84560B343DC3, 0x8B1212D7E6280FBC,'13171F02-82B6-424B-82C9-C9B0F82E3981', 'C', '2000'
exec UTIL_ADD_DFS_QrysPlans 0x8FF8B9B49B3D4D91, 0x23760A4951D12752,'BEE20640-A8B2-4414-9531-32BE9CA6CE11', 'C', '2000'

*/

GO
CREATE PROCEDURE #UTIL_ADD_DFS_QrysPlans
(@query_hash BINARY(8), 
 @query_plan_hash BINARY(8), 
 @UID UNIQUEIDENTIFIER, 
 @PerfType CHAR(1), 
 @TBLID    NVARCHAR(10)
)
AS
    BEGIN
 DECLARE @debug INT= 0;
 DECLARE @cnt INT;
 DECLARE @i INT= 0;
 DECLARE @SQL NVARCHAR(MAX);
 DECLARE @PLAN XML;
 DECLARE @Success BIT= 0;
 DECLARE @AddRec BIT= 0;
 IF @debug = 1
     BEGIN
  PRINT '@query_hash: ' + CAST(@query_hash AS NVARCHAR(MAX));
  PRINT '@query_plan_hash: ' + CAST(@query_plan_hash AS NVARCHAR(MAX));
  PRINT '@UID: ' + CAST(@UID AS NVARCHAR(MAX));
  PRINT '@PerfType:' + @PerfType;
  PRINT '@TBLID: ' + @TBLID;
 END;
 IF(@PerfType = 'C'
    OR @PerfType = 'I')
     BEGIN
  SET @Success = 0;
 END;
     ELSE
     BEGIN
  PRINT 'FAILED @PerfType: must be C or I : "' + @PerfType + '"';
  RETURN @success;
 END;
 IF(@TBLID = '2000'
    OR @TBLID IS NULL)
     BEGIN
  SET @Success = 0;
 END;
     ELSE
     BEGIN
  PRINT 'FAILED @TBLID must be 2000 or NULL: ' + CAST(@success AS NVARCHAR(10));
  RETURN @success;
 END;
 SET @cnt =
 (
     SELECT COUNT(*)
     FROM   dbo.DFS_QryPlanBridge
     WHERE  query_hash = @query_hash
     AND query_plan_hash = @query_plan_hash
 );
 IF(@cnt = 0)
     BEGIN
  SET @AddRec = 1;
 END;
 IF(@cnt = 1)
     BEGIN
  UPDATE  [dbo].[DFS_QryPlanBridge]
 SET 
   NbrHits = NbrHits + 1, 
   LastUpdate = GETDATE()
  WHERE   query_hash = @query_hash
   AND query_plan_hash = @query_plan_hash;
  SET @success = 1;
  RETURN @success;
 END;
 SET @success = 0;
 IF(@cnt = 0)
     BEGIN
  IF @PerfType = 'C'
 BEGIN
   IF @TBLID = '2000'
  BEGIN
    SET @PLAN =
    (
   SELECT query_plan
   FROM   [dbo].[DFS_CPU_BoundQry2000]
   WHERE  [UID] = @UID
    );
    SET @SQL =
    (
   SELECT [text]
   FROM   [dbo].[DFS_CPU_BoundQry2000]
   WHERE  [UID] = @UID
    );
    SET @success = 1;
   END;
  ELSE
  BEGIN
    SET @PLAN =
    (
   SELECT query_plan
   FROM   [dbo].[DFS_CPU_BoundQry]
   WHERE  [UID] = @UID
    );
    SET @SQL =
    (
   SELECT [text]
   FROM   [dbo].[DFS_CPU_BoundQry]
   WHERE  [UID] = @UID
    );
    SET @success = 1;
   END;
  END;
  IF @PerfType = 'I'
 BEGIN
   IF @TBLID = '2000'
  BEGIN
    SET @PLAN =
    (
   SELECT query_plan
   FROM   [dbo].[DFS_IO_BoundQry2000]
   WHERE  [UID] = @UID
    );
    SET @SQL =
    (
   SELECT [text]
   FROM   [dbo].[DFS_IO_BoundQry2000]
   WHERE  [UID] = @UID
    );
    SET @success = 1;
   END;
  ELSE
  BEGIN
    SET @PLAN =
    (
   SELECT query_plan
   FROM   [dbo].[DFS_IO_BoundQry]
   WHERE  [UID] = @UID
    );
    SET @SQL =
    (
   SELECT [text]
   FROM   [dbo].[DFS_IO_BoundQry]
   WHERE  [UID] = @UID
    );
    SET @success = 1;
   END;
  END;
 END;
 IF(@success <> 1
    OR @AddRec <> 1)
     BEGIN
  PRINT 'select * from XXX where [UID] = ''' + CAST(@UID AS NVARCHAR(60)) + ''';';
 END;
 IF(@success = 1
    AND @AddRec = 1)
     BEGIN
  INSERT INTO [dbo].[DFS_QryPlanBridge]
  ([query_hash], 
   [query_plan_hash], 
   [PerfType], 
   [TblType], 
   [CreateDate], 
   [LastUpdate], 
   [NbrHits]
  )
  VALUES
  (@query_hash, 
   @query_plan_hash, 
   @PerfType, 
   @TBLID, 
   GETDATE(), 
   GETDATE(), 
   1
  );
  INSERT INTO [dbo].[DFS_QrysPlans]
  ([query_hash], 
   [query_plan_hash], 
   [UID], 
   [PerfType], 
   [text], 
   [query_plan], 
   [CreateDate]
  )
  VALUES
  (@query_hash, 
   @query_plan_hash, 
   NEWID(), 
   @PerfType, 
   @SQL, 
   @PLAN, 
   GETDATE()
  );
  IF @TBLID = '2000'
     AND @PerfType = 'I'
 BEGIN
   UPDATE  [dbo].[DFS_IO_BoundQry2000]
  SET 
    query_plan = 'SAVED', 
    [text] = 'SAVED', 
    Processed = 1
   WHERE   [UID] = @UID;
   PRINT 'DFS_IO_BoundQry2000: ' + CAST(@i AS NVARCHAR(15)) + ' Processed set to 1';
  END;
  IF @TBLID = '2000'
     AND @PerfType = 'C'
 BEGIN
   UPDATE  [dbo].[DFS_CPU_BoundQry2000]
  SET 
    query_plan = 'SAVED', 
    [text] = 'SAVED', 
    Processed = 1
   WHERE   [UID] = @UID;
   PRINT 'DFS_CPU_BoundQry2000: ' + CAST(@i AS NVARCHAR(15)) + ' Processed set to 1';
  END;
  IF @TBLID IS NULL
     AND @PerfType = 'I'
 BEGIN
   UPDATE  [dbo].[DFS_IO_BoundQry]
  SET 
    query_plan = 'SAVED', 
    [text] = 'SAVED', 
    Processed = 1
   WHERE   [UID] = @UID;
   PRINT 'DFS_IO_BoundQry: ' + CAST(@i AS NVARCHAR(15)) + ' Processed set to 1';
  END;
  IF @TBLID IS NULL
     AND @PerfType = 'C'
 BEGIN
   UPDATE  [dbo].[DFS_cpu_BoundQry]
  SET 
    query_plan = 'SAVED', 
    [text] = 'SAVED', 
    Processed = 1
   WHERE   [UID] = @UID;
   PRINT 'DFS_cpu_BoundQry: ' + CAST(@i AS NVARCHAR(15)) + ' Processed set to 1';
  END;
 END;
 RETURN @success;
    END;
GO

/*DECLARE @MaxWaitMS INT= 0;
DECLARE @RunID INT= 0;
EXEC @RunID = dbo.UTIL_GetSeq;*/

DECLARE @stmt NVARCHAR(100)= '--* USE?; exec #UTIL_Process_QrysPlans ; ';
EXEC sp_msForEachDB @stmt;