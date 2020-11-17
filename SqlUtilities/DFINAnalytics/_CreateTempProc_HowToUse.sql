--**********************************************************************
declare @mstrproc nvarchar(150) = 'PrintImmediate';
exec dbo._CreateTempProc @mstrproc;

declare @msg NVARCHAR(150) ;
set @msg = 'Test EXECUTION... of ' + @mstrproc ;

exec #PrintImmediate @msg;

	IF OBJECT_ID('tempdb..#printimmediate') IS NOT NULL
	BEGIN
		PRINT 'DROPPED Proc: ' + 'tempdb..#' + @mstrproc;
		drop procedure #printimmediate;
	END;

--**********************************************************************
declare @i int = 0 ;
declare @name nvarchar(150) = '';
DECLARE db_cursor CURSOR FOR 
SELECT ROUTINE_NAME FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_TYPE = 'PROCEDURE'

OPEN db_cursor  
FETCH NEXT FROM db_cursor INTO @name  

WHILE @@FETCH_STATUS = 0  
BEGIN  
 exec @i = dbo._CreateTempProc @name;
	  if (@i = 1)
		print @name + ' placed into TEMPDB.';
		else 
		print @name + ' FAILED to place into TEMPDB.';
 FETCH NEXT FROM db_cursor INTO @name 
END 

CLOSE db_cursor  
DEALLOCATE db_cursor 
--**********************************************************************

select * from DFS_TempProcErrors order by ProcName, CreateDate desc;

--***********************************************************************
SELECT 'exec dbo._CreateTempProc ''' + ROUTINE_NAME + ''', 1;' FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_TYPE = 'PROCEDURE'

--***********************************************************************
exec dbo._CreateTempProc 'test_GetNbr1', 1;
exec dbo._CreateTempProc 'genInsertStatements', 1;
exec dbo._CreateTempProc 'UTIL_Process_QrysPlans', 1;
exec dbo._CreateTempProc 'UTIL_ADD_DFS_QrysPlans', 1;
exec dbo._CreateTempProc 'UTIL_RecordCount', 1;
exec dbo._CreateTempProc 'PrintImmediate', 1;
exec dbo._CreateTempProc 'UTIL_DFS_DBVersion', 1;
exec dbo._CreateTempProc 'GetSEQUENCE', 1;
exec dbo._CreateTempProc 'sp_UTIL_QryPlanStats', 1;
exec dbo._CreateTempProc 'sp_DFS_FindMissingFKIndexes', 1;
exec dbo._CreateTempProc 'UTIL_MonitorWorkload', 1;
exec dbo._CreateTempProc 'DFS_MonitorLocks', 1;
exec dbo._CreateTempProc 'UTIL_ListQryTextBySpid', 1;
exec dbo._CreateTempProc 'UTIL_MSforeachdb', 1;
exec dbo._CreateTempProc 'UTIL_getRunningQueryText', 1;
exec dbo._CreateTempProc 'UTIL_ListCurrentRunningQueries', 1;
exec dbo._CreateTempProc 'DMA_ForEachDB', 1;
exec dbo._CreateTempProc 'UTIL_ListQueryAndBlocks', 1;
exec dbo._CreateTempProc 'UTIL_ListBlocks', 1;
exec dbo._CreateTempProc 'UTIL_ListMostCommonWaits', 1;
exec dbo._CreateTempProc 'UTIL_findLocks', 1;
exec dbo._CreateTempProc 'sp_foreachdb', 1;
exec dbo._CreateTempProc '_Emergency_StartAllAnalyticsJobs', 1;
exec dbo._CreateTempProc 'sp_foreachdb_TempDB', 1;
exec dbo._CreateTempProc 'UTIL_DFS_DeadlockStats', 1;
exec dbo._CreateTempProc 'UTIL_CleanUpOneTable', 1;
exec dbo._CreateTempProc 'UTIL_CleanDFSTables', 1;
exec dbo._CreateTempProc 'UTIL_DefragAllIndexes', 1;
exec dbo._CreateTempProc 'sp_MeasurePerformanceInSP', 1;
exec dbo._CreateTempProc 'DFS_IO_BoundQry2000_ProcessTable', 1;
exec dbo._CreateTempProc 'DFS_CPU_BoundQry2000_ProcessTable', 1;
exec dbo._CreateTempProc 'UTIL_DFS_CPU_BoundQry', 1;
exec dbo._CreateTempProc 'DFS_GetAllTableSizesAndRowCnt', 1;
exec dbo._CreateTempProc 'usp_GetErrorInfo', 1;
exec dbo._CreateTempProc '_CreateTempProc', 1;
exec dbo._CreateTempProc 'UTIL_GetSeq', 1;
exec dbo._CreateTempProc 'sp_UTIL_CPU_BoundQry', 1;
exec dbo._CreateTempProc 'sp_UTIL_IO_BoundQry', 1;
exec dbo._CreateTempProc 'UTIL_DFS_DbFileSizing', 1;
exec dbo._CreateTempProc 'UTIL_DFS_TxMonitorTblUpdates', 1;