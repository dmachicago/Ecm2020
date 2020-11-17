--* USEDFINAnalytics
go

IF OBJECT_ID('tempdb..#tempidx') IS NOT NULL
    DROP TABLE #tempidx;
DECLARE @db_id INT;
DECLARE @object_id INT;
SET @db_id = DB_ID(N'BNYUK_ProductionAR_Port');
SET @object_id = OBJECT_ID(N'dbo.IssuerCaption');
BEGIN
    SELECT *
    INTO #tempidx
    --FROM sys.dm_db_index_physical_stats(@db_Id, @object_ID, NULL, NULL, 'DETAILED') AS IPS;
	FROM sys.dm_db_index_physical_stats(null, null, NULL, NULL, 'DETAILED') AS IPS
	where IPS.avg_fragmentation_in_percent >= 30;
END;
SELECT DB.name AS DB, 
  T.name AS TBL, 
  i.name AS IDX, 
  *
FROM #tempidx TIDX
     JOIN sys.tables T ON TIDX.object_id = T.object_id
     JOIN sys.indexes I ON TIDX.index_id = I.index_id
     JOIN sys.databases DB ON TIDX.database_id = DB.database_id
ORDER BY DB.name, 
  T.name, 
  I.name;
