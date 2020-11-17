--exec sp_lock
--* USEDFINAnalytics;
go

DECLARE @DBNAME NVARCHAR(80)= 'DFINAnalytics';
DECLARE @DBID INT= DB_ID(@DBNAME);
DECLARE @TgtTable NVARCHAR(80)= 'dbo.ErrorLog';

IF OBJECT_ID('TempDB.dbo.#TableLocks') IS NOT NULL
    BEGIN
 PRINT '#TableLocks Temporary Table Exists';
END;
    ELSE
    BEGIN
 PRINT '#TableLocks Temporary Table NOT FOUND';
END;

IF OBJECT_ID('tempdb..#TableLocks') IS NOT NULL
    BEGIN
 PRINT 'Dropped table #TableLocks...';
 DROP TABLE #TableLocks;
END;

IF OBJECT_ID('tempdb..#TableLocks2') IS NOT NULL
    BEGIN
 PRINT 'Dropped table #TableLocks2...';
 DROP TABLE #TableLocks2;
END;


IF @TgtTable IS NOT NULL
    BEGIN
 SELECT @DBNAME AS DBName , *
 INTO #TableLocks
 FROM sys.dm_tran_locks
 WHERE resource_database_id = DB_ID()
  AND 
  resource_associated_entity_id = OBJECT_ID(@TgtTable);
END;
    ELSE
    BEGIN
 SELECT @DBNAME AS DBName , *
 INTO #TableLocks2
 FROM sys.dm_tran_locks
 WHERE resource_database_id = DB_ID();
END;

IF OBJECT_ID('tempdb..#TableLocks') IS NOT NULL
    BEGIN
 SELECT *
FROM #TableLocks;
END;
IF OBJECT_ID('tempdb..#TableLocks2') IS NOT NULL
    BEGIN
 SELECT *
FROM #TableLocks2;
END;


-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016