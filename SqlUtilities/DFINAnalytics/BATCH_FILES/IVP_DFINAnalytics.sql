

/****************** PROCESSING FILE *************************************/

GO  
PRINT 'ID# 1'  
print 'D:\dev\SQL\DFINAnalytics\_DropAllDFINTables.sql' 
go
--Select 'if exists (select 1 from sys.tables where name = ''' + name +''')' +char(10) + '    drop table ' + name + ';' as CMD from sys.tables  where name like 'DFS%'
go
declare @DropAllTables int = 0 ;
if (@DropAllTables = 1)
Begin
		if exists (select 1 from sys.tables where name = 'PerfMonitor')
			drop table PerfMonitor;
		if exists (select 1 from sys.tables where name = 'DFS_TableGrowthHistory')
			drop table DFS_TableGrowthHistory;
		if exists (select 1 from sys.tables where name = 'DFS_CleanedDFSTables')
			drop table DFS_CleanedDFSTables;
		if exists (select 1 from sys.tables where name = 'DFS_TxMonitorTableStats')
			drop table DFS_TxMonitorTableStats;
		if exists (select 1 from sys.tables where name = 'DFS_TxMonitorIDX')
			drop table DFS_TxMonitorIDX;
		if exists (select 1 from sys.tables where name = 'DFS_IndexFragProgress')
			drop table DFS_IndexFragProgress;
		if exists (select 1 from sys.tables where name = 'DFS_IndexFragErrors')
			drop table DFS_IndexFragErrors;
		if exists (select 1 from sys.tables where name = 'DFS_IndexFragHist')
			drop table DFS_IndexFragHist;
		if exists (select 1 from sys.tables where name = 'DFS_CPU_BoundQry')
			drop table DFS_CPU_BoundQry;
		if exists (select 1 from sys.tables where name = 'DFS_IO_BoundQry')
			drop table DFS_IO_BoundQry;
		if exists (select 1 from sys.tables where name = 'DFS_QryPlanBridge')
			drop table DFS_QryPlanBridge;
		if exists (select 1 from sys.tables where name = 'DFS_WaitStats')
			drop table DFS_WaitStats;
		if exists (select 1 from sys.tables where name = 'DFS_TableSizeAndRowCnt')
			drop table DFS_TableSizeAndRowCnt;
		if exists (select 1 from sys.tables where name = 'DFS_TestDBContext')
			drop table DFS_TestDBContext;
		if exists (select 1 from sys.tables where name = 'DFS_TempProcErrors')
			drop table DFS_TempProcErrors;
		if exists (select 1 from sys.tables where name = 'DFS_RecordCount')
			drop table DFS_RecordCount;
		if exists (select 1 from sys.tables where name = 'DFS_DB2Skip')
			drop table DFS_DB2Skip;
		if exists (select 1 from sys.tables where name = 'DFS_DBVersion')
			drop table DFS_DBVersion;
		if exists (select 1 from sys.tables where name = 'DFS_WaitTypes')
			drop table DFS_WaitTypes;
		if exists (select 1 from sys.tables where name = 'DFS_MissingIndexes')
			drop table DFS_MissingIndexes;
		if exists (select 1 from sys.tables where name = 'DFS_MissingFKIndexes')
			drop table DFS_MissingFKIndexes;
		if exists (select 1 from sys.tables where name = 'DFS_TableReadWrites')
			drop table DFS_TableReadWrites;
		if exists (select 1 from sys.tables where name = 'DFS_QryOptStats')
			drop table DFS_QryOptStats;
		if exists (select 1 from sys.tables where name = 'DFS_IndexStats')
			drop table DFS_IndexStats;
		if exists (select 1 from sys.tables where name = 'DFS_IO_BoundQry2000')
			drop table DFS_IO_BoundQry2000;
		if exists (select 1 from sys.tables where name = 'DFS_CPU_BoundQry2000')
			drop table DFS_CPU_BoundQry2000;
		if exists (select 1 from sys.tables where name = 'DFS_Workload')
			drop table DFS_Workload;
		if exists (select 1 from sys.tables where name = 'DFS_BlockingHistory')
			drop table DFS_BlockingHistory;
		if exists (select 1 from sys.tables where name = 'DFS_TranLocks')
			drop table DFS_TranLocks;
		if exists (select 1 from sys.tables where name = 'DFS_SequenceTABLE')
			drop table DFS_SequenceTABLE;
		if exists (select 1 from sys.tables where name = 'DFS_DeadlockStats')
			drop table DFS_DeadlockStats;
		if exists (select 1 from sys.tables where name = 'DFS_IndexFragReorgHistory')
			drop table DFS_IndexFragReorgHistory;
end

go

/****************** PROCESSING FILE *************************************/

GO  
PRINT 'ID# 2'  
print 'D:\dev\SQL\DFINAnalytics\_DropAllDFINProcs.sql' 

go
--Select 'if exists (select 1 from sys.procedures where name = ''' + name +''')' +char(10) + '    drop procedure ' + name + ';' as CMD from sys.procedures where name like 'DFS%'
--Select 'if exists (select 1 from sys.procedures where name = ''' + name +''')' +char(10) + '    drop procedure ' + name + ';' as CMD from sys.procedures order by name;
go
declare @DropAllProcs int = 0 ;
if (@DropAllProcs = 1)
Begin
	if exists (select 1 from sys.procedures where name = 'UTIL_UpdateQryPlansAndText')
		DROP PROCEDURE UTIL_UpdateQryPlansAndText;
	
	if exists (select 1 from sys.procedures where name = 'DFS_IO_BoundQry2000_ProcessTable')
		drop procedure DFS_IO_BoundQry2000_ProcessTable;
	if exists (select 1 from sys.procedures where name = 'DFS_CPU_BoundQry2000_ProcessTable')
		drop procedure DFS_CPU_BoundQry2000_ProcessTable;
	if exists (select 1 from sys.procedures where name = 'DFS_GetAllTableSizesAndRowCnt')
		drop procedure DFS_GetAllTableSizesAndRowCnt;
	if exists (select 1 from sys.procedures where name = 'DFS_MonitorTableStats')
		drop procedure DFS_MonitorTableStats;
	if exists (select 1 from sys.procedures where name = 'DFS_MonitorLocks')
		drop procedure DFS_MonitorLocks;
	if exists (select 1 from sys.procedures where name = '_CreateTempProc')
		drop procedure _CreateTempProc;
	if exists (select 1 from sys.procedures where name = '_Emergency_StartAllAnalyticsJobs')
		drop procedure _Emergency_StartAllAnalyticsJobs;
	if exists (select 1 from sys.procedures where name = '_GetProcDependencies')
		drop procedure _GetProcDependencies;
	if exists (select 1 from sys.procedures where name = 'az_foreach_worker')
		drop procedure az_foreach_worker;
	if exists (select 1 from sys.procedures where name = 'az_foreachdb')
		drop procedure az_foreachdb;
	if exists (select 1 from sys.procedures where name = 'az_foreachtable')
		drop procedure az_foreachtable;
	if exists (select 1 from sys.procedures where name = 'azure_sp_MSforeachdb')
		drop procedure azure_sp_MSforeachdb;
	if exists (select 1 from sys.procedures where name = 'Azure_sp_MSforeachdb
	')
		drop procedure Azure_sp_MSforeachdb
	;
	if exists (select 1 from sys.procedures where name = 'DMA_ForEachDB')
		drop procedure DMA_ForEachDB;
	if exists (select 1 from sys.procedures where name = 'genInsertStatements')
		drop procedure genInsertStatements;
	if exists (select 1 from sys.procedures where name = 'GetSEQUENCE')
		drop procedure GetSEQUENCE;
	if exists (select 1 from sys.procedures where name = 'PrintImmediate')
		drop procedure PrintImmediate;
	if exists (select 1 from sys.procedures where name = 'sp_ckProcessDB')
		drop procedure sp_ckProcessDB;
	if exists (select 1 from sys.procedures where name = 'sp_DFS_FindMissingFKIndexes')
		drop procedure sp_DFS_FindMissingFKIndexes;
	if exists (select 1 from sys.procedures where name = 'sp_DFS_MonitorLocks')
		drop procedure sp_DFS_MonitorLocks;
	if exists (select 1 from sys.procedures where name = 'sp_DFS_SuggestMissingIndexes')
		drop procedure sp_DFS_SuggestMissingIndexes;
	if exists (select 1 from sys.procedures where name = 'sp_foreachdb')
		drop procedure sp_foreachdb;
	if exists (select 1 from sys.procedures where name = 'sp_foreachdb_TempDB')
		drop procedure sp_foreachdb_TempDB;
	if exists (select 1 from sys.procedures where name = 'sp_MeasurePerformanceInSP')
		drop procedure sp_MeasurePerformanceInSP;
	if exists (select 1 from sys.procedures where name = 'sp_PrintImmediate')
		drop procedure sp_PrintImmediate;
	if exists (select 1 from sys.procedures where name = 'sp_UTIL_CPU_BoundQry')
		drop procedure sp_UTIL_CPU_BoundQry;
	if exists (select 1 from sys.procedures where name = 'sp_UTIL_CPU_BoundQry2000')
		drop procedure sp_UTIL_CPU_BoundQry2000;
	if exists (select 1 from sys.procedures where name = 'sp_UTIL_DFS_DeadlockStats')
		drop procedure sp_UTIL_DFS_DeadlockStats;
	if exists (select 1 from sys.procedures where name = 'sp_UTIL_DFS_WaitStats')
		drop procedure sp_UTIL_DFS_WaitStats;
	if exists (select 1 from sys.procedures where name = 'sp_UTIL_GetIndexStats')
		drop procedure sp_UTIL_GetIndexStats;
	if exists (select 1 from sys.procedures where name = 'sp_UTIL_GetSeq')
		drop procedure sp_UTIL_GetSeq;
	if exists (select 1 from sys.procedures where name = 'sp_UTIL_IO_BoundQry')
		drop procedure sp_UTIL_IO_BoundQry;
	if exists (select 1 from sys.procedures where name = 'sp_UTIL_IO_BoundQry2000')
		drop procedure sp_UTIL_IO_BoundQry2000;
	if exists (select 1 from sys.procedures where name = 'sp_UTIL_MSTR_BoundQry2000')
		drop procedure sp_UTIL_MSTR_BoundQry2000;
	if exists (select 1 from sys.procedures where name = 'sp_UTIL_RebuildAllDbIndexes')
		drop procedure sp_UTIL_RebuildAllDbIndexes;
	if exists (select 1 from sys.procedures where name = 'sp_UTIL_RebuildAllDbIndexUsingDBCC')
		drop procedure sp_UTIL_RebuildAllDbIndexUsingDBCC;
	if exists (select 1 from sys.procedures where name = 'sp_UTIL_ReorgFragmentedIndexes')
		drop procedure sp_UTIL_ReorgFragmentedIndexes;
	if exists (select 1 from sys.procedures where name = 'sp_UTIL_TableGrowthHistory')
		drop procedure sp_UTIL_TableGrowthHistory;
	if exists (select 1 from sys.procedures where name = 'sp_UTIL_TrackTblReadsWrites')
		drop procedure sp_UTIL_TrackTblReadsWrites;
	if exists (select 1 from sys.procedures where name = 'sp_UTIL_TxMonitorIDX')
		drop procedure sp_UTIL_TxMonitorIDX;
	if exists (select 1 from sys.procedures where name = 'sp_UTIL_TxMonitorTableStats')
		drop procedure sp_UTIL_TxMonitorTableStats;
	if exists (select 1 from sys.procedures where name = 'spDemoDBContext')
		drop procedure spDemoDBContext;
	if exists (select 1 from sys.procedures where name = 'test_GetAllTableNames')
		drop procedure test_GetAllTableNames;
	if exists (select 1 from sys.procedures where name = 'test_GetNbr1')
		drop procedure test_GetNbr1;
	if exists (select 1 from sys.procedures where name = 'usp_GetErrorInfo')
		drop procedure usp_GetErrorInfo;
	if exists (select 1 from sys.procedures where name = 'UTIL_ADD_DFS_QrysPlans')
		drop procedure UTIL_ADD_DFS_QrysPlans;
	if exists (select 1 from sys.procedures where name = 'UTIL_CleanDFSTables')
		drop procedure UTIL_CleanDFSTables;
	if exists (select 1 from sys.procedures where name = 'UTIL_CleanUpOneTable')
		drop procedure UTIL_CleanUpOneTable;
	if exists (select 1 from sys.procedures where name = 'UTIL_DefragAllIndexes')
		drop procedure UTIL_DefragAllIndexes;
	if exists (select 1 from sys.procedures where name = 'UTIL_DFS_CPU_BoundQry')
		drop procedure UTIL_DFS_CPU_BoundQry;
	if exists (select 1 from sys.procedures where name = 'UTIL_DFS_DbFileSizing')
		drop procedure UTIL_DFS_DbFileSizing;
	if exists (select 1 from sys.procedures where name = 'UTIL_DFS_DBVersion')
		drop procedure UTIL_DFS_DBVersion;
	if exists (select 1 from sys.procedures where name = 'UTIL_DFS_DeadlockStats')
		drop procedure UTIL_DFS_DeadlockStats;
	if exists (select 1 from sys.procedures where name = 'UTIL_DFS_TxMonitorTblUpdates')
		drop procedure UTIL_DFS_TxMonitorTblUpdates;
	if exists (select 1 from sys.procedures where name = 'UTIL_findLocks')
		drop procedure UTIL_findLocks;
	if exists (select 1 from sys.procedures where name = 'UTIL_GetErrorInfo')
		drop procedure UTIL_GetErrorInfo;
	if exists (select 1 from sys.procedures where name = 'UTIL_getRunningQueryText')
		drop procedure UTIL_getRunningQueryText;
	if exists (select 1 from sys.procedures where name = 'UTIL_GetSeq')
		drop procedure UTIL_GetSeq;
	if exists (select 1 from sys.procedures where name = 'UTIL_GetTableRowsSize')
		drop procedure UTIL_GetTableRowsSize;
	if exists (select 1 from sys.procedures where name = 'UTIL_IO_BoundQry')
		drop procedure UTIL_IO_BoundQry;
	if exists (select 1 from sys.procedures where name = 'UTIL_ListBlocks')
		drop procedure UTIL_ListBlocks;
	if exists (select 1 from sys.procedures where name = 'UTIL_ListCurrentRunningQueries')
		drop procedure UTIL_ListCurrentRunningQueries;
	if exists (select 1 from sys.procedures where name = 'UTIL_ListMostCommonWaits')
		drop procedure UTIL_ListMostCommonWaits;
	if exists (select 1 from sys.procedures where name = 'UTIL_ListQryTextBySpid')
		drop procedure UTIL_ListQryTextBySpid;
	if exists (select 1 from sys.procedures where name = 'UTIL_ListQueryAndBlocks')
		drop procedure UTIL_ListQueryAndBlocks;
	if exists (select 1 from sys.procedures where name = 'UTIL_MonitorWorkload')
		drop procedure UTIL_MonitorWorkload;
	if exists (select 1 from sys.procedures where name = 'UTIL_MSforeachdb')
		drop procedure UTIL_MSforeachdb;
	if exists (select 1 from sys.procedures where name = 'UTIL_Process_QrysPlans')
		drop procedure UTIL_Process_QrysPlans;
	if exists (select 1 from sys.procedures where name = 'UTIL_QryPlanStats')
		drop procedure UTIL_QryPlanStats;
	if exists (select 1 from sys.procedures where name = 'UTIL_RecordCount')
		drop procedure UTIL_RecordCount;
	if exists (select 1 from sys.procedures where name = 'UTIL_TableGrowthHistory')
		drop procedure UTIL_TableGrowthHistory;
	if exists (select 1 from sys.procedures where name = 'UTIL_TestDBContext')
		drop procedure UTIL_TestDBContext;
	if exists (select 1 from sys.procedures where name = 'UTIL_TestDBProcCall')
		drop procedure UTIL_TestDBProcCall;
	if exists (select 1 from sys.procedures where name = 'UTIL_TestDBProcCallWithParms')
		drop procedure UTIL_TestDBProcCallWithParms;
end

/****************** PROCESSING FILE *************************************/

GO  
PRINT 'ID# 2'  
print 'D:\dev\SQL\DFINAnalytics\Func_genInsertSql.sql' 
--* USEDFINAnalytics
GO

IF EXISTS ( SELECT *
     FROM sys.objects
     WHERE object_id = OBJECT_ID(N'[dbo].[genInsertSql]')
    AND 
    type IN ( N'FN' , N'IF' , N'TF' , N'FS' , N'FT'
     )
   ) 
    BEGIN
 DROP FUNCTION [dbo].[genInsertSql];
END;
GO

--DROP PROCEDURE genInsertSql;
--GO

CREATE function genInsertSql ( 
   @FromTBL NVARCHAR(150) , 
   @IntoTBL NVARCHAR(150)
    )
RETURNS VARCHAR(max)
AS
    BEGIN
 DECLARE @colx NVARCHAR(MAX) = '';
		DECLARE @stmt VARCHAR(MAX) = '';
 DECLARE @stmtcopy VARCHAR(MAX) = '';
 DECLARE @colname VARCHAR(250) = '';
 DECLARE @tempname VARCHAR(250) = '';

 SET @tempname = SUBSTRING(@FromTBL , 2 , 999);
 SET @stmt = 'INSERT INTO ' + @IntoTBL + ' (' ;

 DECLARE db_cursor CURSOR
 FOR SELECT c.name + ',' + CHAR(10) AS ColName
     FROM tempdb.sys.tables AS t INNER JOIN tempdb.sys.columns AS c ON t.object_id = c.object_id
     WHERE t.Name LIKE '%' + @tempname + '%';
 OPEN db_cursor;
 
 FETCH NEXT FROM db_cursor INTO @colname;
 WHILE @@FETCH_STATUS = 0
     BEGIN
  set @colx = @colx + '    ' + @colname ;
  FETCH NEXT FROM db_cursor INTO @colname;
     END;
 CLOSE db_cursor;
 DEALLOCATE db_cursor;

 SET @colx = RTRIM(@colx);
 SET @colx = CASE @colx
   WHEN NULL
   THEN NULL
   ELSE ( CASE LEN(@colx)
  WHEN 0
  THEN @colx
  ELSE LEFT(@colx , LEN(@colx) - 2)
     END )
 END;
 --SET @stmtcopy = REPLACE(@colx , 'B.' , 'A.');
		SET @stmtcopy = @colx;
 SET @stmt = 'INSERT INTO ' + @IntoTBL + ' (' + CHAR(10) + @colx +char(10) +')' + CHAR(10) + 'Select ' +char(10) + @stmtcopy + CHAR(10) + ' From ' + @FromTBL + ';';

 RETURN @stmt;
    END;
GO

/*************  USAGE  *************/
/*
IF OBJECT_ID('tempdb..#DFS_IO_BoundQry2000') IS NOT NULL
    BEGIN
 DROP TABLE #DFS_IO_BoundQry2000;
END;

SELECT TOP 10 @@SERVERNAME AS SVRName , 'DBNAME' AS DBName , st.text , qp.query_plan , qs.* , GETDATE() AS RunDate , @@version AS SSVER , 333 AS RunID , NEWID() AS [UID] , 0 AS processed
INTO [#DFS_IO_BoundQry2000]
FROM sys.dm_exec_query_stats AS qs CROSS APPLY sys.dm_exec_sql_text ( qs.plan_handle
  ) AS st
  CROSS APPLY sys.dm_exec_query_plan ( qs.plan_handle
    ) AS qp
ORDER BY total_logical_reads DESC;

DECLARE @FromTable NVARCHAR(150) = ;
DECLARE @IntoTable NVARCHAR(150);

DECLARE @s NVARCHAR(MAX);

set @s = dbo.genInsertSql ('#DFS_IO_BoundQry2000' , 'dbo.DFS_IO_BoundQry2000');

PRINT @s;

*/

/****************** PROCESSING FILE *************************************/

GO  
PRINT 'ID# 3'  
print 'D:\dev\SQL\DFINAnalytics\UTIL_ADD_DFS_QrysPlans.sql' 

GO

if exists (select 1 from sys.tables where name = 'DFS_QryOptStatsHistory')
	DROP TABLE [dbo].[DFS_QryOptStatsHistory]
GO

CREATE TABLE [dbo].[DFS_QryOptStatsHistory](
	SvrName nvarchar(150) not null,
	DbName nvarchar(150) not null,
	[query_hash] [binary](8) NULL,
	[query_plan_hash] [binary](8) NULL,
	ExecutionDate datetime default getdate(),
	[UID] uniqueidentifier default newid(),
	AffectedRows int default 0 
) ON [PRIMARY]

create clustered index piDFS_QryOptStatsHistory on DFS_QryOptStatsHistory (SvrName,DbName,[query_hash],[query_plan_hash],ExecutionDate) ;
create index piDFS_QryOptStatsHistoryUID on DFS_QryOptStatsHistory ([UID]) ;

go

IF EXISTS ( SELECT 1
            FROM sys.tables
            WHERE name = 'DFS_QryPlanBridge'
          ) 
    BEGIN
        DROP TABLE [dbo].DFS_QryPlanBridge;
END;
GO

IF EXISTS ( SELECT 1
            FROM sys.tables
            WHERE name = 'DFS_QryOptStats'
          ) 
    BEGIN
        DROP TABLE [dbo].[DFS_QryOptStats];
END;
GO

CREATE TABLE [dbo].[DFS_QryOptStats] ( 
             SvrName                           [NVARCHAR](150) NULL , 
             [schemaname]                      [NVARCHAR](150) NULL , 
             [viewname]                        [SYSNAME] NOT NULL , 
             [viewid]                          [INT] NOT NULL , 
             [databasename]                    [NVARCHAR](150) NULL , 
             [databaseid]                      [SMALLINT] NULL , 
             [text]                            [NVARCHAR](MAX) NULL , 
             [query_plan]                      [XML] NULL , 
             [sql_handle]                      [VARBINARY](64) NOT NULL , 
             [statement_start_offset]          [INT] NOT NULL , 
             [statement_end_offset]            [INT] NOT NULL , 
             [plan_generation_num]             [BIGINT] NULL , 
             [plan_handle]                     [VARBINARY](64) NOT NULL , 
             [creation_time]                   [DATETIME] NULL , 
             [last_execution_time]             [DATETIME] NULL , 
             [execution_count]                 [BIGINT] NOT NULL , 
             [total_worker_time]               [BIGINT] NOT NULL , 
             [last_worker_time]                [BIGINT] NOT NULL , 
             [min_worker_time]                 [BIGINT] NOT NULL , 
             [max_worker_time]                 [BIGINT] NOT NULL , 
             [total_physical_reads]            [BIGINT] NOT NULL , 
             [last_physical_reads]             [BIGINT] NOT NULL , 
             [min_physical_reads]              [BIGINT] NOT NULL , 
             [max_physical_reads]              [BIGINT] NOT NULL , 
             [total_logical_writes]            [BIGINT] NOT NULL , 
             [last_logical_writes]             [BIGINT] NOT NULL , 
             [min_logical_writes]              [BIGINT] NOT NULL , 
             [max_logical_writes]              [BIGINT] NOT NULL , 
             [total_logical_reads]             [BIGINT] NOT NULL , 
             [last_logical_reads]              [BIGINT] NOT NULL , 
             [min_logical_reads]               [BIGINT] NOT NULL , 
             [max_logical_reads]               [BIGINT] NOT NULL , 
             [total_clr_time]                  [BIGINT] NOT NULL , 
             [last_clr_time]                   [BIGINT] NOT NULL , 
             [min_clr_time]                    [BIGINT] NOT NULL , 
             [max_clr_time]                    [BIGINT] NOT NULL , 
             [total_elapsed_time]              [BIGINT] NOT NULL , 
             [last_elapsed_time]               [BIGINT] NOT NULL , 
             [min_elapsed_time]                [BIGINT] NOT NULL , 
             [max_elapsed_time]                [BIGINT] NOT NULL , 
             [query_hash]                      [BINARY](8) NULL , 
             [query_plan_hash]                 [BINARY](8) NULL , 
             [total_rows]                      [BIGINT] NULL , 
             [last_rows]                       [BIGINT] NULL , 
             [min_rows]                        [BIGINT] NULL , 
             [max_rows]                        [BIGINT] NULL , 
             [statement_sql_handle]            [VARBINARY](64) NULL , 
             [statement_context_id]            [BIGINT] NULL , 
             [total_dop]                       [BIGINT] NULL , 
             [last_dop]                        [BIGINT] NULL , 
             [min_dop]                         [BIGINT] NULL , 
             [max_dop]                         [BIGINT] NULL , 
             [total_grant_kb]                  [BIGINT] NULL , 
             [last_grant_kb]                   [BIGINT] NULL , 
             [min_grant_kb]                    [BIGINT] NULL , 
             [max_grant_kb]                    [BIGINT] NULL , 
             [total_used_grant_kb]             [BIGINT] NULL , 
             [last_used_grant_kb]              [BIGINT] NULL , 
             [min_used_grant_kb]               [BIGINT] NULL , 
             [max_used_grant_kb]               [BIGINT] NULL , 
             [total_ideal_grant_kb]            [BIGINT] NULL , 
             [last_ideal_grant_kb]             [BIGINT] NULL , 
             [min_ideal_grant_kb]              [BIGINT] NULL , 
             [max_ideal_grant_kb]              [BIGINT] NULL , 
             [total_reserved_threads]          [BIGINT] NULL , 
             [last_reserved_threads]           [BIGINT] NULL , 
             [min_reserved_threads]            [BIGINT] NULL , 
             [max_reserved_threads]            [BIGINT] NULL , 
             [total_used_threads]              [BIGINT] NULL , 
             [last_used_threads]               [BIGINT] NULL , 
             [min_used_threads]                [BIGINT] NULL , 
             [max_used_threads]                [BIGINT] NULL , 
             [total_columnstore_segment_reads] [BIGINT] NULL , 
             [last_columnstore_segment_reads]  [BIGINT] NULL , 
             [min_columnstore_segment_reads]   [BIGINT] NULL , 
             [max_columnstore_segment_reads]   [BIGINT] NULL , 
             [total_columnstore_segment_skips] [BIGINT] NULL , 
             [last_columnstore_segment_skips]  [BIGINT] NULL , 
             [min_columnstore_segment_skips]   [BIGINT] NULL , 
             [max_columnstore_segment_skips]   [BIGINT] NULL , 
             [total_spills]                    [BIGINT] NULL , 
             [last_spills]                     [BIGINT] NULL , 
             [min_spills]                      [BIGINT] NULL , 
             [max_spills]                      [BIGINT] NULL , 
             [RunDate]                         [DATETIME] NULL , 
             [SSVER]                           [NVARCHAR](300) NULL , 
             [UID]                             [UNIQUEIDENTIFIER] NOT NULL
                                     ) 
ON [PRIMARY];
GO

ALTER TABLE [dbo].[DFS_QryOptStats]
ADD DEFAULT(GETDATE()) FOR [RunDate];
GO

ALTER TABLE [dbo].[DFS_QryOptStats]
ADD DEFAULT(NEWID()) FOR [UID];
GO

IF NOT EXISTS ( SELECT 1
                FROM sys.indexes
                WHERE name = 'pi_DFS_QryOptStats_UID'
              ) 
    BEGIN
        PRINT 'Creating index pi_DFS_QryOptStats_UID';
        CREATE NONCLUSTERED INDEX [pi_DFS_QryOptStats_UID] ON [dbo].[DFS_QryOptStats] ( [UID] ASC
                                                                                      );
END;

IF NOT EXISTS ( SELECT 1
                FROM sys.indexes
                WHERE name = 'pi_DFS_QryOptStats_Hash'
              ) 
    BEGIN
        PRINT 'Creating index pi_DFS_QryOptStats_Hash';
        CREATE NONCLUSTERED INDEX [pi_DFS_QryOptStats_Hash] ON [dbo].[DFS_QryOptStats] ( [query_hash] , [query_plan_hash]
                                                                                       );
END;
GO

CREATE TABLE [dbo].[DFS_QryPlanBridge] ( 
             [query_hash]      [BINARY](8) NULL , 
             [query_plan_hash] [BINARY](8) NULL , 
             [PerfType]        [CHAR](1) NOT NULL , 
             [TblType]         [NVARCHAR](10) NOT NULL , 
             [CreateDate]      [DATETIME] NOT NULL , 
             [LastUpdate]      [DATETIME] NOT NULL , 
             [NbrHits]         [INT] NULL
                                       ) 
ON [PRIMARY];
GO

ALTER TABLE [dbo].[DFS_QryPlanBridge]
ADD DEFAULT(GETDATE()) FOR [CreateDate];
GO

ALTER TABLE [dbo].[DFS_QryPlanBridge]
ADD DEFAULT(GETDATE()) FOR [LastUpdate];
GO

ALTER TABLE [dbo].[DFS_QryPlanBridge]
ADD DEFAULT( ( 0 ) ) FOR [NbrHits];
GO

/*ALTER TABLE [dbo].[DFS_QryPlanBridge]  WITH CHECK ADD  CONSTRAINT [FK_DFS_QryPlanBridge_DFS_QrysPlans] FOREIGN KEY([query_hash], [query_plan_hash])
REFERENCES [dbo].[DFS_QrysPlans] ([query_hash], [query_plan_hash])*/

GO

/****** Object:  Table [dbo].[DFS_QrysPlans]    Script Date: 2/18/2019 12:07:36 PM ******/

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

IF NOT EXISTS ( SELECT 1
                FROM sys.tables
                WHERE name = 'DFS_QrysPlans'
              ) 
    BEGIN
        CREATE TABLE [dbo].[DFS_QrysPlans] ( 
                     [query_hash]      [BINARY](8) NULL , 
                     [query_plan_hash] [BINARY](8) NULL , 
                     [UID]             [UNIQUEIDENTIFIER] NOT NULL , 
                     [PerfType]        [NVARCHAR](10) NOT NULL , 
                     [text]            [NVARCHAR](MAX) NULL , 
                     [query_plan]      [XML] NULL , 
                     [CreateDate]      [DATETIME] NOT NULL
                                           ) 
        ON [PRIMARY];
        ALTER TABLE [dbo].[DFS_QrysPlans]
        ADD DEFAULT(NEWID()) FOR [UID];
        ALTER TABLE [dbo].[DFS_QrysPlans]
        ADD DEFAULT(GETDATE()) FOR [CreateDate];
        CREATE NONCLUSTERED INDEX [pi_DFS_QrysPlans_UID] ON [dbo].[DFS_QrysPlans] ( [UID] ASC
                                                                                  ) 
               WITH ( PAD_INDEX = OFF , STATISTICS_NORECOMPUTE = OFF , SORT_IN_TEMPDB = OFF , DROP_EXISTING = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON
                    ) ON [PRIMARY];
        CREATE NONCLUSTERED INDEX [pkDFS_QrysPlans] ON [dbo].[DFS_QrysPlans] ( [query_hash] ASC , [query_plan_hash] ASC
                                                                             ) 
               WITH ( PAD_INDEX = OFF , STATISTICS_NORECOMPUTE = OFF , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , DROP_EXISTING = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON
                    ) ON [PRIMARY];
END;
GO

/*
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
/** USEDFINAnalytics;*/

GO

/* drop TABLE [dbo].[DFS_CPU_BoundQry]*/

IF EXISTS ( SELECT 1
            FROM sys.tables
            WHERE NAME = 'DFS_CPU_BoundQry'
          ) 
    BEGIN
        DROP TABLE [dbo].[DFS_CPU_BoundQry];
END;

BEGIN
    CREATE TABLE [dbo].[DFS_CPU_BoundQry] ( 
                 [SVRName]                [NVARCHAR](150) NULL , 
                 [DBName]                 [NVARCHAR](150) NULL , 
                 [text]                   [NVARCHAR](MAX) NULL , 
                 [query_plan]             [XML] NULL , 
                 [sql_handle]             [VARBINARY](64) NOT NULL , 
                 [statement_start_offset] [INT] NOT NULL , 
                 [statement_end_offset]   [INT] NOT NULL , 
                 [plan_generation_num]    [BIGINT] NULL , 
                 [plan_handle]            [VARBINARY](64) NOT NULL , 
                 [creation_time]          [DATETIME] NULL , 
                 [last_execution_time]    [DATETIME] NULL , 
                 [execution_count]        [BIGINT] NOT NULL , 
                 [total_worker_time]      [BIGINT] NOT NULL , 
                 [last_worker_time]       [BIGINT] NOT NULL , 
                 [min_worker_time]        [BIGINT] NOT NULL , 
                 [max_worker_time]        [BIGINT] NOT NULL , 
                 [total_physical_reads]   [BIGINT] NOT NULL , 
                 [last_physical_reads]    [BIGINT] NOT NULL , 
                 [min_physical_reads]     [BIGINT] NOT NULL , 
                 [max_physical_reads]     [BIGINT] NOT NULL , 
                 [total_logical_writes]   [BIGINT] NOT NULL , 
                 [last_logical_writes]    [BIGINT] NOT NULL , 
                 [min_logical_writes]     [BIGINT] NOT NULL , 
                 [max_logical_writes]     [BIGINT] NOT NULL , 
                 [total_logical_reads]    [BIGINT] NOT NULL , 
                 [last_logical_reads]     [BIGINT] NOT NULL , 
                 [min_logical_reads]      [BIGINT] NOT NULL , 
                 [max_logical_reads]      [BIGINT] NOT NULL , 
                 [total_clr_time]         [BIGINT] NOT NULL , 
                 [last_clr_time]          [BIGINT] NOT NULL , 
                 [min_clr_time]           [BIGINT] NOT NULL , 
                 [max_clr_time]           [BIGINT] NOT NULL , 
                 [total_elapsed_time]     [BIGINT] NOT NULL , 
                 [last_elapsed_time]      [BIGINT] NOT NULL , 
                 [min_elapsed_time]       [BIGINT] NOT NULL , 
                 [max_elapsed_time]       [BIGINT] NOT NULL , 
                 [query_hash]             [BINARY](8) NULL , 
                 [query_plan_hash]        [BINARY](8) NULL , 
                 [total_rows]             [BIGINT] NULL , 
                 [last_rows]              [BIGINT] NULL , 
                 [min_rows]               [BIGINT] NULL , 
                 [max_rows]               [BIGINT] NULL , 
                 [statement_sql_handle]   [VARBINARY](64) NULL , 
                 [statement_context_id]   [BIGINT] NULL , 
                 [total_dop]              [BIGINT] NULL , 
                 [last_dop]               [BIGINT] NULL , 
                 [min_dop]                [BIGINT] NULL , 
                 [max_dop]                [BIGINT] NULL , 
                 [total_grant_kb]         [BIGINT] NULL , 
                 [last_grant_kb]          [BIGINT] NULL , 
                 [min_grant_kb]           [BIGINT] NULL , 
                 [max_grant_kb]           [BIGINT] NULL , 
                 [total_used_grant_kb]    [BIGINT] NULL , 
                 [last_used_grant_kb]     [BIGINT] NULL , 
                 [min_used_grant_kb]      [BIGINT] NULL , 
                 [max_used_grant_kb]      [BIGINT] NULL , 
                 [total_ideal_grant_kb]   [BIGINT] NULL , 
                 [last_ideal_grant_kb]    [BIGINT] NULL , 
                 [min_ideal_grant_kb]     [BIGINT] NULL , 
                 [max_ideal_grant_kb]     [BIGINT] NULL , 
                 [total_reserved_threads] [BIGINT] NULL , 
                 [last_reserved_threads]  [BIGINT] NULL , 
                 [min_reserved_threads]   [BIGINT] NULL , 
                 [max_reserved_threads]   [BIGINT] NULL , 
                 [total_used_threads]     [BIGINT] NULL , 
                 [last_used_threads]      [BIGINT] NULL , 
                 [min_used_threads]       [BIGINT] NULL , 
                 [max_used_threads]       [BIGINT] NULL , 
                 [RunDate]                [DATETIME] NULL , 
                 [RunID]                  [BIGINT] NULL , 
                 [UID]                    UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL , 
                 [Processed]              INT DEFAULT 0 ,
                                          ) 
    ON [PRIMARY];
    CREATE INDEX piDFS_CPU_BoundQry ON DFS_CPU_BoundQry ( query_hash , query_plan_hash
                                                        );
    CREATE INDEX piDFS_CPU_BoundQry_Processed ON DFS_CPU_BoundQry ( Processed , UID
                                                                  );
    CREATE INDEX pkDFS_CPU_BoundQry ON DFS_CPU_BoundQry ( SvrName , DBName , query_hash , query_plan_hash
                                                        );
END; 
GO

IF EXISTS ( SELECT 1
            FROM sys.procedures
            WHERE name = 'UTIL_Process_QrysPlans'
          ) 
    BEGIN
        DROP PROCEDURE UTIL_Process_QrysPlans;
END;
GO

/* exec dbo.UTIL_Process_QrysPlans */

CREATE PROCEDURE UTIL_Process_QrysPlans
AS
    BEGIN
		declare @SvrName nvarchar(150) = @@servername ;
		declare @DBName nvarchar(150) = db_name() ;
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
        FOR SELECT query_hash , query_plan_hash , [UID] , 'C' AS PerfType , '2000' AS TBLID
            FROM [dbo].[DFS_CPU_BoundQry2000]
            WHERE Processed = 0
            UNION ALL
            SELECT query_hash , query_plan_hash , [UID] , 'I' AS PerfType , '2000' AS TBLID
            FROM [dbo].[DFS_IO_BoundQry2000]
            WHERE Processed = 0
            UNION ALL
            SELECT query_hash , query_plan_hash , [UID] , 'I' AS PerfType , NULL AS TBLID
            FROM [dbo].[DFS_IO_BoundQry]
            WHERE Processed = 0
            UNION ALL
            SELECT query_hash , query_plan_hash , [UID] , 'C' AS PerfType , NULL AS TBLID
            FROM [dbo].[DFS_CPU_BoundQry]
            WHERE Processed = 0;
        OPEN db_cursor;
        FETCH NEXT FROM db_cursor INTO @query_hash , @query_plan_hash , @UID , @PerfType , @TBLID;
        WHILE @@FETCH_STATUS = 0
            BEGIN
                SET @i = @i + 1;
                SET @msg = 'Processing: ' + CAST(@i AS NVARCHAR(15));
                EXEC PrintImmediate @msg;
                EXEC UTIL_ADD_DFS_QrysPlans @query_hash , @query_plan_hash , @UID , @PerfType , @TBLID;

				--exec UTIL_QryOptStatsHistory  @SvrName,@DbName,@query_hash,@query_plan_hash ;

                FETCH NEXT FROM db_cursor INTO @query_hash , @query_plan_hash , @UID , @PerfType , @TBLID;
            END;
        CLOSE db_cursor;
        DEALLOCATE db_cursor;
        IF ( SELECT COUNT(*)
             FROM [dbo].[DFS_IO_BoundQry2000]
             WHERE Processed = 0
           ) > 0
            BEGIN
                UPDATE [dbo].[DFS_IO_BoundQry2000]
                       SET processed = 1
                WHERE Processed = 0;
        END;
        IF ( SELECT COUNT(*)
             FROM [dbo].[DFS_CPU_BoundQry2000]
             WHERE Processed = 0
           ) > 0
            BEGIN
                UPDATE [dbo].[DFS_CPU_BoundQry2000]
                       SET processed = 1
                WHERE Processed = 0;
        END;
        IF ( SELECT COUNT(*)
             FROM [dbo].[DFS_IO_BoundQry]
             WHERE Processed = 0
           ) > 0
            BEGIN
                UPDATE [dbo].[DFS_IO_BoundQry]
                       SET processed = 1
                WHERE Processed = 0;
        END;
        IF ( SELECT COUNT(*)
             FROM [dbo].[DFS_CPU_BoundQry]
             WHERE Processed = 0
           ) > 0
            BEGIN
                UPDATE [dbo].[DFS_CPU_BoundQry]
                       SET processed = 1
                WHERE Processed = 0;
        END;
    END;
GO

IF EXISTS ( SELECT 1
            FROM sys.procedures
            WHERE name = 'UTIL_ADD_DFS_QrysPlans'
          ) 
    BEGIN
        DROP PROCEDURE UTIL_ADD_DFS_QrysPlans;
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

CREATE PROCEDURE UTIL_ADD_DFS_QrysPlans ( 
                 @query_hash      BINARY(8) , 
                 @query_plan_hash BINARY(8) , 
                 @UID             UNIQUEIDENTIFIER , 
                 @PerfType        CHAR(1) , 
                 @TBLID           NVARCHAR(10)
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
        IF ( @PerfType = 'C'
             OR 
             @PerfType = 'I' ) 
            BEGIN
                SET @Success = 0;
        END;
            ELSE
            BEGIN
                PRINT 'FAILED @PerfType: must be C or I : "' + @PerfType + '"';
                RETURN @success;
        END;
        IF ( @TBLID = '2000'
             OR 
             @TBLID IS NULL ) 
            BEGIN
                SET @Success = 0;
        END;
            ELSE
            BEGIN
                PRINT 'FAILED @TBLID must be 2000 or NULL: ' + CAST(@success AS NVARCHAR(10));
                RETURN @success;
        END;
        SET @cnt = ( SELECT COUNT(*)
                     FROM dbo.DFS_QryPlanBridge
                     WHERE query_hash = @query_hash
                           AND 
                           query_plan_hash = @query_plan_hash
                   );
        IF ( @cnt = 0 ) 
            BEGIN
                SET @AddRec = 1;
        END;
        IF ( @cnt = 1 ) 
            BEGIN
                UPDATE [dbo].[DFS_QryPlanBridge]
                       SET NbrHits = NbrHits + 1 , LastUpdate = GETDATE()
                WHERE query_hash = @query_hash
                      AND 
                      query_plan_hash = @query_plan_hash;
                SET @success = 1;
                RETURN @success;
        END;
        SET @success = 0;
        IF ( @cnt = 0 ) 
            BEGIN
                IF @PerfType = 'C'
                    BEGIN
                        IF @TBLID = '2000'
                            BEGIN
                                SET @PLAN = ( SELECT query_plan
                                              FROM [dbo].[DFS_CPU_BoundQry2000]
                                              WHERE [UID] = @UID
                                            );
                                SET @SQL = ( SELECT [text]
                                             FROM [dbo].[DFS_CPU_BoundQry2000]
                                             WHERE [UID] = @UID
                                           );
                                SET @success = 1;
                        END;
                            ELSE
                            BEGIN
                                SET @PLAN = ( SELECT query_plan
                                              FROM [dbo].[DFS_CPU_BoundQry]
                                              WHERE [UID] = @UID
                                            );
                                SET @SQL = ( SELECT [text]
                                             FROM [dbo].[DFS_CPU_BoundQry]
                                             WHERE [UID] = @UID
                                           );
                                SET @success = 1;
                        END;
                END;
                IF @PerfType = 'I'
                    BEGIN
                        IF @TBLID = '2000'
                            BEGIN
                                SET @PLAN = ( SELECT query_plan
                                              FROM [dbo].[DFS_IO_BoundQry2000]
                                              WHERE [UID] = @UID
                                            );
                                SET @SQL = ( SELECT [text]
                                             FROM [dbo].[DFS_IO_BoundQry2000]
                                             WHERE [UID] = @UID
                                           );
                                SET @success = 1;
                        END;
                            ELSE
                            BEGIN
                                SET @PLAN = ( SELECT query_plan
                                              FROM [dbo].[DFS_IO_BoundQry]
                                              WHERE [UID] = @UID
                                            );
                                SET @SQL = ( SELECT [text]
                                             FROM [dbo].[DFS_IO_BoundQry]
                                             WHERE [UID] = @UID
                                           );
                                SET @success = 1;
                        END;
                END;
        END;
        IF ( @success <> 1
             OR 
             @AddRec <> 1 ) 
            BEGIN
                PRINT 'select * from XXX where [UID] = ''' + CAST(@UID AS NVARCHAR(60)) + ''';';
        END;
        IF ( @success = 1
             AND 
             @AddRec = 1 ) 
            BEGIN
                INSERT INTO [dbo].[DFS_QryPlanBridge] ( [query_hash] , [query_plan_hash] , [PerfType] , [TblType] , [CreateDate] , [LastUpdate] , [NbrHits]
                                                      ) 
                VALUES ( @query_hash , @query_plan_hash , @PerfType , @TBLID , GETDATE() , GETDATE() , 1
                       );
                INSERT INTO [dbo].[DFS_QrysPlans] ( [query_hash] , [query_plan_hash] , [UID] , [PerfType] , [text] , [query_plan] , [CreateDate]
                                                  ) 
                VALUES ( @query_hash , @query_plan_hash , NEWID() , @PerfType , @SQL , @PLAN , GETDATE()
                       );
                IF @TBLID = '2000'
                   AND 
                   @PerfType = 'I'
                    BEGIN
                        UPDATE [dbo].[DFS_IO_BoundQry2000]
                               SET query_plan = 'SAVED' , [text] = 'SAVED' , Processed = 1
                        WHERE [UID] = @UID;
                        PRINT 'DFS_IO_BoundQry2000: ' + CAST(@i AS NVARCHAR(15)) + ' Processed set to 1';
                END;
                IF @TBLID = '2000'
                   AND 
                   @PerfType = 'C'
                    BEGIN
                        UPDATE [dbo].[DFS_CPU_BoundQry2000]
                               SET query_plan = 'SAVED' , [text] = 'SAVED' , Processed = 1
                        WHERE [UID] = @UID;
                        PRINT 'DFS_CPU_BoundQry2000: ' + CAST(@i AS NVARCHAR(15)) + ' Processed set to 1';
                END;
                IF @TBLID IS NULL
                   AND 
                   @PerfType = 'I'
                    BEGIN
                        UPDATE [dbo].[DFS_IO_BoundQry]
                               SET query_plan = 'SAVED' , [text] = 'SAVED' , Processed = 1
                        WHERE [UID] = @UID;
                        PRINT 'DFS_IO_BoundQry: ' + CAST(@i AS NVARCHAR(15)) + ' Processed set to 1';
                END;
                IF @TBLID IS NULL
                   AND 
                   @PerfType = 'C'
                    BEGIN
                        UPDATE [dbo].[DFS_cpu_BoundQry]
                               SET query_plan = 'SAVED' , [text] = 'SAVED' , Processed = 1
                        WHERE [UID] = @UID;
                        PRINT 'DFS_cpu_BoundQry: ' + CAST(@i AS NVARCHAR(15)) + ' Processed set to 1';
                END;
        END;
        RETURN @success;
    END;

GO

IF EXISTS ( SELECT 1
            FROM sys.procedures
            WHERE name = 'UTIL_QryOptStatsHistory'
          ) 
    BEGIN
        DROP PROCEDURE UTIL_QryOptStatsHistory;
END;
GO

/* exec UTIL_QryOptStatsHistory */

CREATE PROCEDURE UTIL_QryOptStatsHistory 
AS
    BEGIN

		declare @cnt as int = 0 ;

		insert into DFS_QryOptStatsHistory
		SELECT T1.[SVRName]
			  ,T1.[DBName]
			  ,T1.[query_hash]
			  ,T1.[query_plan_hash] 
			  ,T1.RunDate
			  ,t1.[UID]
			  ,t1.total_rows
		  FROM [dbo].[DFS_CPU_BoundQry2000] T1
		left join DFS_QryOptStatsHistory T2
		on T1.SvrName = T2.SvrName 
		and T1.DbName = T2.DbName 
		and T1.query_hash = T2.query_hash
		and T1.query_plan_hash = T2.query_plan_hash
		where T2.SvrName is null

		set @cnt = @@rowcount ;
		print 'UTIL_QryOptStatsHistory added ' + cast(@cnt as nvarchar(50)) + ' new records.';

		insert into DFS_QryOptStatsHistory
		SELECT T1.[SVRName]
			  ,T1.[DBName]
			  ,T1.[query_hash]
			  ,T1.[query_plan_hash] 
			  ,T1.RunDate
			  ,t1.[UID]
			  ,t1.total_rows
		  FROM [dbo].[DFS_CPU_BoundQry] T1
		left join DFS_QryOptStatsHistory T2
		on T1.SvrName = T2.SvrName 
		and T1.DbName = T2.DbName 
		and T1.query_hash = T2.query_hash
		and T1.query_plan_hash = T2.query_plan_hash
		where T2.SvrName is null

		insert into DFS_QryOptStatsHistory
		SELECT T1.[SVRName]
			  ,T1.[DBName]
			  ,T1.[query_hash]
			  ,T1.[query_plan_hash] 
			  ,T1.RunDate
			  ,t1.[UID]
			  ,t1.total_rows
		  FROM [dbo].[DFS_IO_BoundQry2000] T1
		left join DFS_QryOptStatsHistory T2
		on T1.SvrName = T2.SvrName 
		and T1.DbName = T2.DbName 
		and T1.query_hash = T2.query_hash
		and T1.query_plan_hash = T2.query_plan_hash
		where T2.SvrName is null

		set @cnt = @@rowcount ;
		print 'UTIL_QryOptStatsHistory added ' + cast(@cnt as nvarchar(50)) + ' new records.';

		insert into DFS_QryOptStatsHistory
		SELECT T1.[SVRName]
			  ,T1.[DBName]
			  ,T1.[query_hash]
			  ,T1.[query_plan_hash] 
			  ,T1.RunDate
			  ,t1.[UID]
			  ,t1.total_rows
		  FROM [dbo].[DFS_IO_BoundQry] T1
		left join DFS_QryOptStatsHistory T2
		on T1.SvrName = T2.SvrName 
		and T1.DbName = T2.DbName 
		and T1.query_hash = T2.query_hash
		and T1.query_plan_hash = T2.query_plan_hash
		where T2.SvrName is null

		set @cnt = @@rowcount ;
		print 'UTIL_QryOptStatsHistory added ' + cast(@cnt as nvarchar(50)) + ' new records.';

		--DELETE t1 
		--FROM [DFS_IO_BoundQry] t1
		--JOIN DFS_QryOptStatsHistory t2 
		--on T1.SvrName = T2.SvrName 
		--and T1.DbName = T2.DbName 
		--and T1.query_hash = T2.query_hash
		--and T1.query_plan_hash = T2.query_plan_hash;

	end
go

/****************** PROCESSING FILE *************************************/

GO  
PRINT 'ID# 4'  
print 'D:\dev\SQL\DFINAnalytics\_GetProcDependencies.sql' 

GO
if exists (select 1 from sys.procedures where name = '_GetProcDependencies')
	drop procedure _GetProcDependencies;
go
-- exec _GetProcDependencies 'UTIL_Process_QrysPlans'
create procedure _GetProcDependencies (@ProcName nvarchar(150))
as
begin
SELECT referencing_id, 
       OBJECT_SCHEMA_NAME(referencing_id) as RefSchema, 
	   OBJECT_NAME(referencing_id) AS ReferencingName, 
       obj.type_desc AS ReferencingType, 
       referenced_schema_name , 
	   referenced_entity_name AS referenced_object_name,
	   isnull((select type_desc from sys.objects where object_id = sed.referenced_id),'SP') as ReferencedType,
	   obj.is_ms_shipped
FROM sys.sql_expression_dependencies AS sed
          INNER JOIN sys.objects AS obj
          ON sed.referencing_id = obj.object_id
		  --ON sed.referenced_id = obj.object_id
WHERE referencing_id = OBJECT_ID(@ProcName)
and referenced_entity_name is not null 
order by referenced_entity_name;
end
go

if exists (Select 1 from INFORMATION_SCHEMA.tables where table_name = 'vProcDependencies')
	drop view vProcDependencies
go

/* USE:
SELECT referenced_object_name, ReferencedType 
FROM vProcDependencies 
WHERE ReferencingName = 'UTIL_QryPlanStats'
and ReferencedType = 'SP'
order by ReferencedType
*/

create view vProcDependencies
as
SELECT referencing_id, 
       OBJECT_SCHEMA_NAME(referencing_id) as RefSchema, 
	   OBJECT_NAME(referencing_id) AS ReferencingName, 
       obj.type_desc AS ReferencingType, 
       referenced_schema_name , 
	   referenced_entity_name AS referenced_object_name,
	   isnull((select type_desc from sys.objects where object_id = sed.referenced_id),'SP') as ReferencedType,
	   obj.is_ms_shipped
FROM sys.sql_expression_dependencies AS sed
          INNER JOIN sys.objects AS obj
          ON sed.referencing_id = obj.object_id
		  --ON sed.referenced_id = obj.object_id
and referenced_entity_name is not null ;



/****************** PROCESSING FILE *************************************/

GO  
PRINT 'ID# 5'  
print 'FQN: D:\dev\SQL\DFINAnalytics\create_master_seq.sql' 
go
--* USEmaster;
go
IF NOT EXISTS
(
    SELECT 1
    FROM sys.sequences
    WHERE name = 'master_seq'
)
    BEGIN
 CREATE SEQUENCE master_seq
 AS BIGINT
 START WITH 1
 INCREMENT BY 1
 MINVALUE 1
 MAXVALUE 999999999
 NO CYCLE
 CACHE 10;
END;
GO



/****************** PROCESSING FILE *************************************/

GO  
PRINT 'ID# 6'  
print 'FQN: D:\dev\SQL\DFINAnalytics\TestDBConnection.sql' 
/****************************************************************************************/
-- select * from DFS_TestDBContext
-- drop Table DFS_TestDBContext
if not exists (select 1 from sys.tables where name = 'DFS_TestDBContext')
	create Table DFS_TestDBContext (
		SVR nvarchar (150) null,
		DBNAME nvarchar (150) null,
		ProcName nvarchar (150) null,
		ExecuteDate datetime default getdate(),
		ProcValues nvarchar (max) null
	)
go
/****************************************************************************************/
if exists (select 1 from sys.procedures where name = 'UTIL_TestDBContext')
	drop procedure UTIL_TestDBContext;
go
create procedure UTIL_TestDBContext
as
begin
		insert into DFS_TestDBContext (SVR, DBNAME, ProcName, ExecuteDate) values (@@SERVERNAME, db_name(),'UTIL_TestDBContext', getdate());
end

go
/****************************************************************************************/
if exists (select 1 from sys.procedures where name = 'UTIL_TestDBProcCall')
	drop procedure UTIL_TestDBProcCall;
go
create procedure UTIL_TestDBProcCall
as
begin
		insert into DFS_TestDBContext (SVR, DBNAME, ProcName, ExecuteDate) values (@@SERVERNAME, db_name(),'UTIL_TestDBProcCall', getdate());
end

go
/****************************************************************************************/
if exists (select 1 from sys.procedures where name = 'UTIL_TestDBProcCallWithParms')
	drop procedure UTIL_TestDBProcCallWithParms;
go
create procedure UTIL_TestDBProcCallWithParms (@parm1 nvarchar(150), @int int)
as
begin
		declare @parms nvarchar(500) = '' ;
		set @parms = @parms + @parm1 + ' :: ' + cast(@int as nvarchar(150));
		insert into DFS_TestDBContext (SVR, DBNAME, ProcName, ExecuteDate, ProcValues) values (@@SERVERNAME, db_name(),'UTIL_TestDBProcCallWithParms', getdate(), @parms);
end

go

/****************** PROCESSING FILE *************************************/

GO  
PRINT 'ID# 10'  
print 'FQN: D:\dev\SQL\DFINAnalytics\sp_UTIL_GetSeq.sql' 

--* USEDFINAnalytics;
GO

/*
select * from [SequenceTABLE]
*/

IF NOT EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.TABLES
    WHERE TABLE_NAME = 'SequenceTABLE'
)
    BEGIN
 CREATE TABLE [dbo].[SequenceTABLE]
 ([ID] [BIGINT] IDENTITY(1, 1) NOT NULL,
 )
 ON [PRIMARY];
 CREATE UNIQUE INDEX pk_SequenceTABLE ON SequenceTABLE(id);
END;
GO
--* USEmaster;
GO
IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'sp_UTIL_GetSeq'
)
    DROP PROCEDURE sp_UTIL_GetSeq;
GO

-- select * from dbo.SequenceTABLE
-- exec sp_UTIL_GetSeq
CREATE PROCEDURE sp_UTIL_GetSeq
AS
    BEGIN
 DECLARE @id BIGINT;
 INSERT INTO dbo.SequenceTABLE WITH(TABLOCKX)
 DEFAULT VALUES;
 --Return the latest IDENTITY value.
 SET @id =
 (
     SELECT MAX(id)
     FROM dbo.SequenceTABLE
 );
 RETURN @id;
    END;



/****************** PROCESSING FILE *************************************/

GO  
PRINT 'ID# 10.1'  
print 'D:\dev\SQL\DFINAnalytics\UTIL_ActiveDatabases.sql' 

GO

/*
select * from ActiveServers
delete from ActiveServers

select distinct isAzure +'|' + SvrName + '|' + DBName +'|' + isnull(UserID,'') + '|' + isnull(pwd,'') as [DATA]
from [dbo].[ActiveServers]

*/

IF EXISTS
(
    SELECT 1
    FROM sys.tables
    WHERE name = 'ActiveServers'
)
    DROP TABLE ActiveServers;
GO
BEGIN
    CREATE TABLE ActiveServers
    (GroupName NVARCHAR(50) NOT NULL
                            DEFAULT 'NA', 
     isAzure   CHAR(1) DEFAULT 'Y', 
     SvrName   NVARCHAR(150) NOT NULL, 
     DBName    NVARCHAR(150) NOT NULL, 
     UserID    NVARCHAR(60) NULL, 
     pwd       NVARCHAR(60) NULL, 
     [UID]     UNIQUEIDENTIFIER NOT NULL
                                DEFAULT NEWID()
    );
    CREATE INDEX pkActiveDatabases
    ON ActiveServers
    ([UID]
    );
    CREATE INDEX pi01ActiveDatabases
    ON ActiveServers
    (GroupName
    );
    CREATE INDEX pi02ActiveDatabases
    ON ActiveServers
    (SvrName, DBName
    );
END;
GO
IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'UTIL_ActiveDatabases'
)
    BEGIN
        DROP PROCEDURE UTIL_ActiveDatabases;
END;
GO
CREATE PROCEDURE UTIL_ActiveDatabases
(@GroupName NVARCHAR(50), 
 @SvrName   NVARCHAR(150), 
 @DBName    NVARCHAR(150), 
 @isAzure   CHAR(1)       = 'Y', 
 @UserID    NVARCHAR(60)  = NULL, 
 @pwd       NVARCHAR(60)  = NULL
)
AS
    BEGIN
        DECLARE @cnt INT= 0;
        SET @cnt =
        (
            SELECT COUNT(*)
            FROM ActiveServers
            WHERE GroupName = @GroupName
                  AND SvrName = @SvrName
                  AND DBName = @DBName
        );
        IF
           (@cnt = 1
           )
            BEGIN
                UPDATE ActiveServers
                  SET 
                      UserID = @Userid, 
                      pwd = @pwd, 
                      isAzure = @isAzure
                WHERE GroupName = @GroupName
                      AND SvrName = @SvrName
                      AND DBName = @DBName;
                PRINT 'UPDATING: ' + @GroupName + ' @ ' + @SvrName + '.' + @DBName;
        END;
            ELSE
            BEGIN
                PRINT 'ADDING: ' + @GroupName + ' @ ' + @SvrName + '.' + @DBName;
                INSERT INTO ActiveServers
                ( GroupName, 
                  SvrName, 
                  DBName, 
                  isAzure, 
                  UserID, 
                  pwd
                ) 
                VALUES
                (
                       @GroupName
                     , @SvrName
                     , @DBName
                     , @isAzure
                     , @UserID
                     , @pwd
                );
        END;
    END;
GO

/*
select * from ActiveServers ;
*/
DECLARE @currdb NVARCHAR(150)= DB_NAME();
IF
   (@currdb = 'DFINAnalytics'
   )
   print '********************** Executing EXEC UTIL_ActiveDatabases into ActiveServers **********************';
    BEGIN		
        DECLARE @GroupName NVARCHAR(50), @SvrName NVARCHAR(150), @DBName NVARCHAR(150), @isAzure CHAR(1), @UserID NVARCHAR(60), @pwd NVARCHAR(60);
        SET @GroupName = 'dfintest';
        SET @isAzure = 'Y';
        SET @SvrName = 'dfin.database.windows.net,1433';
        SET @DBName = 'TestAzureDB';
        SET @UserID = 'wmiller';
        SET @pwd = 'Junebug1';
        EXEC UTIL_ActiveDatabases 
             @GroupName, 
             @SvrName, 
             @DBName, 
             @isAzure, 
             @UserID, 
             @pwd;
        SET @GroupName = 'dfintest';
        SET @isAzure = 'Y';
        SET @SvrName = 'dfin.database.windows.net,1433';
        SET @DBName = 'AW_AZURE';
        SET @UserID = 'wmiller';
        SET @pwd = 'Junebug1';
        EXEC UTIL_ActiveDatabases 
             @GroupName, 
             @SvrName, 
             @DBName, 
             @isAzure, 
             @UserID, 
             @pwd;
        SET @GroupName = 'dfintest';
        SET @isAzure = 'N';
        SET @SvrName = 'ALIEN15';
        SET @DBName = 'TestDB';
        SET @UserID = NULL;
        SET @pwd = NULL;
        EXEC UTIL_ActiveDatabases 
             @GroupName, 
             @SvrName, 
             @DBName, 
             @isAzure, 
             @UserID, 
             @pwd;

/*SET @GroupName = 'dfintest';
SET @isAzure = 'N';
SET @SvrName = 'SVR2016';
SET @DBName = 'DFINAnalytics';
SET @UserID = 'sa';
SET @pwd = 'Junebug1';
EXEC UTIL_ActiveDatabases @GroupName, @SvrName, @DBName, @isAzure, @UserID, @pwd;*/

        SET @GroupName = 'dfintest';
        SET @isAzure = 'N';
        SET @SvrName = 'SVR2016';
        SET @DBName = 'DFS';
        SET @UserID = 'sa';
        SET @pwd = 'Junebug1';
        EXEC UTIL_ActiveDatabases 
             @GroupName, 
             @SvrName, 
             @DBName, 
             @isAzure, 
             @UserID, 
             @pwd;
        SET @GroupName = 'dfintest';
        SET @isAzure = 'N';
        SET @SvrName = 'SVR2016';
        SET @DBName = 'MstrData';
        SET @UserID = 'sa';
        SET @pwd = 'Junebug1';
        EXEC UTIL_ActiveDatabases 
             @GroupName, 
             @SvrName, 
             @DBName, 
             @isAzure, 
             @UserID, 
             @pwd;
        SET @GroupName = 'dfintest';
        SET @isAzure = 'N';
        SET @SvrName = 'SVR2016';
        SET @DBName = 'MstrPort';
        SET @UserID = 'sa';
        SET @pwd = 'Junebug1';
        EXEC UTIL_ActiveDatabases 
             @GroupName, 
             @SvrName, 
             @DBName, 
             @isAzure, 
             @UserID, 
             @pwd;
        SET @GroupName = 'dfintest';
        SET @isAzure = 'N';
        SET @SvrName = 'SVR2016';
        SET @DBName = 'TestXml';
        SET @UserID = 'sa';
        SET @pwd = 'Junebug1';
        EXEC UTIL_ActiveDatabases 
             @GroupName, 
             @SvrName, 
             @DBName, 
             @isAzure, 
             @UserID, 
             @pwd;
        SET @GroupName = 'dfintest';
        SET @isAzure = 'N';
        SET @SvrName = 'SVR2016';
        SET @DBName = 'AW_VMWARE';
        SET @UserID = 'sa';
        SET @pwd = 'Junebug1';
        EXEC UTIL_ActiveDatabases 
             @GroupName, 
             @SvrName, 
             @DBName, 
             @isAzure, 
             @UserID, 
             @pwd;

/*SET @GroupName = 'dfintest';
SET @isAzure = 'N';
SET @SvrName = 'ALIEN15';
SET @DBName = 'DFINAnalytics';
SET @UserID = NULL;
SET @pwd = NULL;
EXEC UTIL_ActiveDatabases @GroupName, @SvrName, @DBName, @isAzure, @UserID, @pwd;*/

        SET @GroupName = 'dfintest';
        SET @isAzure = 'N';
        SET @SvrName = 'ALIEN15';
        SET @DBName = 'PowerDatabase';
        SET @UserID = NULL;
        SET @pwd = NULL;
        EXEC UTIL_ActiveDatabases 
             @GroupName, 
             @SvrName, 
             @DBName, 
             @isAzure, 
             @UserID, 
             @pwd;
        SET @GroupName = 'dfintest';
        SET @isAzure = 'N';
        SET @SvrName = 'ALIEN15';
        SET @DBName = 'WDM';
        SET @UserID = NULL;
        SET @pwd = NULL;
        EXEC UTIL_ActiveDatabases 
             @GroupName, 
             @SvrName, 
             @DBName, 
             @isAzure, 
             @UserID, 
             @pwd;
        IF(@@SERVERNAME != 'ALIEN15'
           AND DB_NAME() != 'DFINAnalytics')
            BEGIN
                PRINT 'SERVER: Truncating ActiveServers ' + @@SERVERNAME + '.' + DB_NAME();
                TRUNCATE TABLE [dbo].[ActiveServers];
        END;
            ELSE
            BEGIN
                PRINT 'SERVER: NOT deleting ActiveServers ' + @@SERVERNAME + '.' + DB_NAME();
        END;
END;
GO

/****************** PROCESSING FILE *************************************/

GO  
PRINT 'ID# 11'  
print 'D:\dev\SQL\DFINAnalytics\UTIL_GetSeq.sql' 

--USE DFINAnalytics;
GO

/*
select * from [DFS_SequenceTABLE]
*/

IF NOT EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.TABLES
    WHERE TABLE_NAME = 'DFS_SequenceTABLE'
)
    BEGIN
        CREATE TABLE [dbo].[DFS_SequenceTABLE]
        ([ID] [BIGINT] IDENTITY(1, 1) NOT NULL,
        )
        ON [PRIMARY];
        CREATE UNIQUE INDEX pk_SequenceTABLE ON DFS_SequenceTABLE(id);
END;
GO

IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'UTIL_GetSeq'
)
    DROP PROCEDURE UTIL_GetSeq;
GO

-- select * from dbo.DFS_SequenceTABLE
-- exec UTIL_GetSeq
CREATE PROCEDURE UTIL_GetSeq
AS
    BEGIN
        DECLARE @id BIGINT;
        INSERT INTO dbo.DFS_SequenceTABLE WITH(TABLOCKX)
        DEFAULT VALUES;
        --Return the latest IDENTITY value.
        SET @id =
        (
            SELECT MAX(id)
            FROM dbo.DFS_SequenceTABLE
        );
        RETURN @id;
    END;



/****************** PROCESSING FILE *************************************/

GO  
PRINT 'ID# 12'  
print 'FQN: D:\dev\SQL\DFINAnalytics\_CreateTempProc.sql' 

GO

/** USEDFINAnalytics;*/

GO
IF EXISTS
(
    SELECT *
    FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[UTIL_RemoveCommentsFromCode]')
   AND type IN(N'FN', N'IF', N'TF', N'FS', N'FT')
)
    BEGIN
 DROP FUNCTION [dbo].[UTIL_RemoveCommentsFromCode];
END;
GO

/*
In order to compile/recompile a stored procedure that is pulled from the database
as an existing stored procedure, it is much easier to parse and find the parts needed
to make it transfer across and compile on TEMPDB if there are no comments in the code.
This function removes all comments from source code, or any SQL based code.
*/

CREATE FUNCTION dbo.UTIL_RemoveCommentsFromCode
(@def VARCHAR(MAX)
)
RETURNS VARCHAR(MAX)
AS
     BEGIN
  DECLARE @comment VARCHAR(100), @endPosition INT, @startPosition INT, @commentLen INT, @substrlen INT, @len INT;
  WHILE
   (CHARINDEX('/*', @def) <> 0
   )
 BEGIN
   SET @endPosition = CHARINDEX('*/', @def);
   SET @substrlen = LEN(SUBSTRING(@def, 1, @endPosition - 1));
   SET @startPosition = @substrlen - CHARINDEX('*/', REVERSE(SUBSTRING(@def, 1, @endPosition - 1))) + 1;
   SET @commentLen = @endPosition - @startPosition;
   SET @comment = SUBSTRING(@def, @startPosition - 1, @commentLen + 3);
   SET @def = REPLACE(@def, @comment, CHAR(13));
 END;

  /** Dealing with --... kind of comments **/

  WHILE PATINDEX('%--%', @def) <> 0
 BEGIN
   SET @startPosition = PATINDEX('%--%', @def);
   SET @endPosition = ISNULL(CHARINDEX(CHAR(13), @def, @startPosition), 0);
   SET @len = (@endPosition) - @startPosition;

/* This happens at the end of the code block, 
		   when the last line is commented code with no CRLF characters*/

   IF @len <= 0
  BEGIN
    SET @len = (LEN(@def) + 1) - @startPosition;
   END;
   SET @Comment = SUBSTRING(@def, @startPosition, @len);
   SET @def = REPLACE(@def, @comment, CHAR(13));
 END;
  RETURN @def;
     END;
GO

/* drop  table DFS_TempProcErrors*/

IF EXISTS
(
    SELECT 1
    FROM sys.tables
    WHERE name = 'DFS_TempProcErrors'
)
    DROP TABLE DFS_TempProcErrors;
GO
CREATE TABLE DFS_TempProcErrors
(ProcName   NVARCHAR(150) NOT NULL, 
 ProcText   NVARCHAR(MAX) NULL, 
 Success    CHAR(1) NULL, 
 CreateDate DATETIME DEFAULT GETDATE(), 
 [UID] UNIQUEIDENTIFIER DEFAULT NEWID()
);
CREATE INDEX pi_DFS_TempProcErrors
ON DFS_TempProcErrors
(ProcName
);
GO

/* Verify that the stored procedure does not already exist.  */

IF OBJECT_ID('UTIL_GetErrorInfo', 'P') IS NOT NULL
    BEGIN
 DROP PROCEDURE UTIL_GetErrorInfo;
END;  
GO

/*
A procedure to retrieve error information.  
*/

CREATE PROCEDURE UTIL_GetErrorInfo
AS
    BEGIN
 DECLARE @i INT= -1;
 SET @i =
 (
     SELECT CHARINDEX('There is already an object', ERROR_MESSAGE())
 );
 IF
    (@i >= 0
    )
     BEGIN
  PRINT 'ALREADY IN TEMPDB... Skipping.';
  PRINT ERROR_MESSAGE();
  RETURN -1;
 END;
 SELECT ERROR_NUMBER() AS ErrorNumber, 
   ERROR_SEVERITY() AS ErrorSeverity, 
   ERROR_STATE() AS ErrorState, 
   ERROR_PROCEDURE() AS ErrorProcedure, 
   ERROR_LINE() AS ErrorLine, 
   ERROR_MESSAGE() AS ErrorMessage;
 RETURN 1;
    END;  
GO
IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = '_CreateTempProc'
)
    BEGIN
 DROP PROCEDURE _CreateTempProc;
END;
GO

/*
Procedure _CreateTempProc pulls the source code from an existing stored procedure
and converts it to be created on the TEMPDB. This is done so thet the loss of the 
hidden functionality of an "sp_" procedure created in the master Database can be 
overcome. Having a proc in TEMPDB allows us to run it under any database and --* USEthe 
context of the current database. 
*/
CREATE PROCEDURE _CreateTempProc
(@ProcName NVARCHAR(150), 
 @ShowsqL  INT    = 0
)
AS
    BEGIN
 DECLARE @rc INT= 1;
 DECLARE @tgtproc NVARCHAR(150)= @ProcName;
 DECLARE @i INT= 0;
 DECLARE @j INT= 0;
 DECLARE @k INT= 0;
 DECLARE @sql NVARCHAR(MAX)= '';
 DECLARE @tgttext NVARCHAR(50)= 'create procedure';
 DECLARE @str NVARCHAR(150)= '';
 DECLARE @pname NVARCHAR(150)= '';
 DECLARE @firstline NVARCHAR(1000)= '';
 SET @pname =
 (
     SELECT ROUTINE_NAME
     FROM INFORMATION_SCHEMA.ROUTINES
     WHERE ROUTINE_NAME = @ProcName
 );
 DECLARE @objectid INT= 0;
 SELECT @objectid = OBJECT_ID(@pname);
 SET @sql = OBJECT_DEFINITION(@objectid);
 SET @sql = dbo.UTIL_RemoveCommentsFromCode(@sql);
 SET @i = @i + LEN(@sql);
 PRINT @ProcName + ' LEN = ' + CAST(@i AS NVARCHAR(15));
 SET @j =
 (
     SELECT CHARINDEX(@pname, @sql)
 );
 SET @i =
 (
     SELECT CHARINDEX(@tgttext, @sql)
 );
 SET @i = @i + LEN(@tgttext);
 SET @sql = SUBSTRING(@sql, @j, 99999);
 SET @sql = LTRIM(@sql);
 SET @k =
 (
     SELECT CHARINDEX(CHAR(10), @sql)
 );
 IF(@k <= 0
    OR @k > 1000)
     SET @k = 1000;
 SET @firstline = SUBSTRING(@sql, 1, @k);
 SET @k =
 (
     SELECT CHARINDEX(']', @firstline)
 );
 IF
    (@k > 0
    )
     BEGIN
  SET @sql = STUFF(@sql, @k, 1, ' ');
 END;
 SET @str = SUBSTRING(@sql, 1, 99999);
 DECLARE @obj NVARCHAR(150)= 'tempdb..#' + @pname;
 SET @sql = 'create procedure #' + @sql;
 BEGIN TRY
     IF OBJECT_ID('tempdb..#' + @pname + '''') IS NULL
  BEGIN
 INSERT INTO DFS_TempProcErrors
 ( ProcName, 
   ProcText
 ) 
 VALUES
 (
 @pname
    , @sql
 );
 EXECUTE sp_executesql 
  @sql;
 UPDATE DFS_TempProcErrors
   SET 
     success = 'Y'
 WHERE ProcName = @pname;
 SET @rc = 1;
     END;
  ELSE
  BEGIN
 PRINT '#' + @pname + ' already in temp...';
 INSERT INTO DFS_TempProcErrors
 ( ProcName, 
   ProcText, 
   success
 ) 
 VALUES
 (
 @pname
    , @sql
    , 'X'
 );
 SET @rc = 1;
     END;
 END TRY
 BEGIN CATCH
     SET @rc = 0;
     UPDATE DFS_TempProcErrors
  SET 
    success = 'N'
     WHERE ProcName = @pname;
     EXECUTE @i = UTIL_GetErrorInfo;
     IF @i = -1
  BEGIN
 INSERT INTO DFS_TempProcErrors
 ( ProcName, 
   ProcText, 
   success
 ) 
 VALUES
 (
 @pname
    , @sql
    , 'X'
 );
 SET @rc = 1;
     END;
     IF @i = 1
  BEGIN
 SET @rc = -1;
 PRINT 'IT APPEARS ' + 'tempdb..#' + @pname + ' FAILED.';
 IF
    (@ShowsqL = 1
    )
   BEGIN
  PRINT '****************************************';
  PRINT @SQL;
  SELECT @procname AS ProcName, 
  @SQL AS SqlText;
  PRINT '****************************************';
 END;
     END;
 END CATCH;
 RETURN @rc;
    END;

/****************** PROCESSING FILE *************************************/

GO  
PRINT 'ID# 13'  
print 'D:\dev\SQL\DFINAnalytics\UTIL_DbMon_IndexVolitity.sql' 
--* USEDFINAnalytics;

/*UTIL_DBMon_EachDB.sql*/

DECLARE @runnow INT= 0;

IF EXISTS ( SELECT 1
     FROM sys.procedures
     WHERE name = 'UTIL_TxMonitorTableIndexStats'
   )
   AND 
   @runnow = 1
    BEGIN

 /*declare @RunID BIGINT = NEXT VALUE FOR master_seq;*/

 DECLARE @RunID BIGINT;
 EXEC @RunID = dbo.UTIL_GetSeq;
 PRINT @RunID;
 DECLARE @command VARCHAR(1000);
 SELECT @command = '--* USE?; declare @DB as int = DB_ID() ; exec sp_UTIL_TxMonitorTableIndexStats ' + CAST(@RunID AS NVARCHAR(25)) + ' ;';
 EXEC sp_MSforeachdb @command;
END;

/* =======================================================
 DROP TABLE [DFS_TxMonitorTableIndexStats];*/

IF EXISTS ( SELECT 1
     FROM INFORMATION_SCHEMA.TABLES
     WHERE TABLE_NAME = 'DFS_TxMonitorTableIndexStats'
   ) 
    BEGIN
 DROP TABLE [dbo].[DFS_TxMonitorTableIndexStats]
END;
GO

CREATE TABLE [dbo].[DFS_TxMonitorTableIndexStats] ( 
 [SVR]  [NVARCHAR](150) NULL , 
 [SchemaName]  [NVARCHAR](150) NULL , 
 [DBName]    [NVARCHAR](150) NULL , 
 [TableName] [NVARCHAR](150) NULL , 
 [IndexName] [SYSNAME] NULL , 
 [IndexID]   [INT] NOT NULL , 
 [user_seeks]  [BIGINT] NOT NULL , 
 [user_scans]  [BIGINT] NOT NULL , 
 [user_lookups]     [BIGINT] NOT NULL , 
 [user_updates]     [BIGINT] NOT NULL , 
 [last_user_seek]   [DATETIME] NULL , 
 [last_user_scan]   [DATETIME] NULL , 
 [last_user_lookup] [DATETIME] NULL , 
 [last_user_update] [DATETIME] NULL , 
 [DBID] [SMALLINT] NULL , 
 [ExecutionDate]    [DATETIME] NOT NULL , 
 [RunID]     [INT] NOT NULL , 
 [UID]  UNIQUEIDENTIFIER DEFAULT NEWID() , 
 RowNbr INT IDENTITY(1 , 1) NOT NULL
   ) 
ON [PRIMARY];

CREATE INDEX [IDX_TxMonitorTableStats_UID] ON [dbo].[DFS_TxMonitorTableIndexStats] ( [UID] , [ExecutionDate]
   ) 
  ON [primary];

CREATE NONCLUSTERED INDEX [IDX_TxMonitorTableStats_RID] ON [dbo].[DFS_TxMonitorTableIndexStats] ( [RunID] ASC , [ExecutionDate] ASC
  ) 
  WITH ( PAD_INDEX = OFF , STATISTICS_NORECOMPUTE = OFF , SORT_IN_TEMPDB = OFF , DROP_EXISTING = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON
     ) ON [PRIMARY];
GO

/******************************************
Using sys.dm_db_index_usage_stats:
There's a handy dynamic management view called sys.dm_db_index_usage_stats that shows you
number of rows in both SELECT and DML statements against all the tables and indexes in your
database, either since the object was created or since the database instance was last restarted:
SELECT *
FROM sys.dm_db_index_usage_stats
******************************************/

--* USEmaster;
GO

IF EXISTS ( SELECT 1
     FROM sys.procedures
     WHERE name = 'sp_UTIL_TxMonitorTableIndexStats'
   ) 
    BEGIN
 DROP PROCEDURE sp_UTIL_TxMonitorTableIndexStats;
END;
GO

/*
----* USE[AW2016];
declare @RunID BIGINT = NEXT VALUE FOR master_seq;
exec @RunID = dbo.UTIL_GetSeq 
print @RunID
exec sp_UTIL_TxMonitorTableIndexStats @RunID;
select * from [dbo].[DFS_TxMonitorTableIndexStats]
*/

CREATE PROCEDURE dbo.sp_UTIL_TxMonitorTableIndexStats ( 
   @RunID BIGINT
  ) 
AS
    BEGIN
		declare @StartCount int = 0 
		declare @EndCount int = 0 
		declare @ProcessedCount int = 0 
 DECLARE @DBID AS INT= DB_ID();
 DECLARE @ExecutionDate DATETIME= GETDATE();
 DECLARE @sql NVARCHAR(4000);

		set @StartCount = (select count(*) from [dbo].[DFS_TxMonitorTableIndexStats]);

		INSERT INTO [dbo].[DFS_TxMonitorTableIndexStats]
   SELECT @@SERVERNAME AS SvrName, 
   sch.name, 
   DB_NAME() AS DBName, 
   OBJECT_NAME(ius.object_id) AS TableName, 
   si.name AS IndexName, 
   si.index_id AS IndexID, 
   ius.user_seeks, 
   ius.user_scans, 
   ius.user_lookups, 
   ius.user_updates, 
   ius.last_user_seek, 
   ius.last_user_scan, 
   ius.last_user_lookup, 
   ius.last_user_update, 
   DBID = DB_ID(), 
   ExecutionDate = GETDATE(), 
   RunID = @RunID , 
   [UID] = NEWID()
   FROM sys.dm_db_index_usage_stats AS ius
    JOIN sys.indexes AS si
    ON ius.object_id = si.object_id
  AND ius.index_id = si.index_id
    JOIN sys.objects AS O
    ON O.object_id = ius.object_id
  JOIN sys.schemas AS sch
    ON O.schema_id = sch.schema_id;
 
		set @EndCount = (select count(*) from [dbo].[DFS_TxMonitorTableIndexStats]);
		set @ProcessedCount = @EndCount - @StartCount
		print 'Total Records Added: ' + cast(@ProcessedCount as nvarchar(50));

-- SET @sql = 'INSERT INTO [dbo].[DFS_TxMonitorTableIndexStats]
--   SELECT @@SERVERNAME AS SvrName, 
--   sch.name, 
--   DB_NAME() AS DBName, 
--   OBJECT_NAME(ius.object_id) AS TableName, 
--   si.name AS IndexName, 
--   si.index_id AS IndexID, 
--   ius.user_seeks, 
--   ius.user_scans, 
--   ius.user_lookups, 
--   ius.user_updates, 
--   ius.last_user_seek, 
--   ius.last_user_scan, 
--   ius.last_user_lookup, 
--   ius.last_user_update, 
--   DBID = DB_ID(), 
--   ExecutionDate = GETDATE(), 
--   RunID = ' + CAST(@RunID AS NVARCHAR(50)) + ', 
--   [UID] = NEWID()
--   FROM sys.dm_db_index_usage_stats AS ius
--    JOIN sys.indexes AS si
--    ON ius.object_id = si.object_id
--  AND ius.index_id = si.index_id
--    JOIN sys.objects AS O
--    ON O.object_id = ius.object_id
--  JOIN sys.schemas AS sch
--    ON O.schema_id = sch.schema_id;
--';
-- EXECUTE sp_executesql @sql;
    END;
GO

--* USEDFINAnalytics;

/* W. Dale Miller
  DMA, Limited
  Offered under GNU License
  July 26, 2016*/


/****************** PROCESSING FILE *************************************/

GO  
PRINT 'ID# 14'  
print 'D:\dev\SQL\DFINAnalytics\azure_sp_MSforeachdb.sql' 
IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'az_foreach_worker'
)
    BEGIN
        DROP PROCEDURE az_foreach_worker;
END;
GO
CREATE PROC [dbo].[az_foreach_worker] @command1    NVARCHAR(2000), 
                                        @replacechar NCHAR(1)       = N'?', 
                                        @command2    NVARCHAR(2000) = NULL, 
                                        @command3    NVARCHAR(2000) = NULL, 
                                        @worker_type INT            = 1
AS
    BEGIN
        CREATE TABLE #qtemp
        (

        /* Temp command storage */

        qnum  INT NOT NULL, 
        qchar NVARCHAR(2000) COLLATE database_default NULL
        );
        SET NOCOUNT ON;
        DECLARE @name NVARCHAR(517), @namelen INT, @q1 NVARCHAR(2000), @q2 NVARCHAR(2000);
        DECLARE @q3 NVARCHAR(2000), @q4 NVARCHAR(2000), @q5 NVARCHAR(2000);
        DECLARE @q6 NVARCHAR(2000), @q7 NVARCHAR(2000), @q8 NVARCHAR(2000), @q9 NVARCHAR(2000), @q10 NVARCHAR(2000);
        DECLARE @cmd NVARCHAR(2000), @replacecharindex INT, @useq TINYINT, @usecmd TINYINT, @nextcmd NVARCHAR(2000);
        DECLARE @namesave NVARCHAR(517), @nametmp NVARCHAR(517), @nametmp2 NVARCHAR(258);
        DECLARE @local_cursor CURSOR;
        IF @worker_type = 1
            BEGIN
                SET @local_cursor = hCForEachDatabase;
        END;
            ELSE
            BEGIN
                SET @local_cursor = hCForEachTable;
        END;
        OPEN @local_cursor;
        FETCH @local_cursor INTO @name;
        WHILE
              (@@fetch_status >= 0
              )
            BEGIN
                SELECT @namesave = @name;
                SELECT @useq = 1, 
                       @usecmd = 1, 
                       @cmd = @command1, 
                       @namelen = DATALENGTH(@name);
                WHILE(@cmd IS NOT NULL)
                    BEGIN

                        /* Generate @q* for exec() */

                        SELECT @replacecharindex = CHARINDEX(@replacechar, @cmd);
                        WHILE
                              (@replacecharindex <> 0
                              )
                            BEGIN

                                /* 7.0, if name contains ' character, and the name has been single quoted in command, double all of them in dbname */
                                /* if the name has not been single quoted in command, do not doulbe them */
                                /* if name contains ] character, and the name has been [] quoted in command, double all of ] in dbname */

                                SELECT @name = @namesave;
                                SELECT @namelen = DATALENGTH(@name);
                                DECLARE @tempindex INT;
                                IF
                                   (SUBSTRING(@cmd, @replacecharindex - 1, 1) = N''''
                                   )
                                    BEGIN

                                        /* if ? is inside of '', we need to double all the ' in name */

                                        SELECT @name = REPLACE(@name, N'''', N'''''');
                                END;
                                    ELSE
                                    BEGIN
                                        IF
                                           (SUBSTRING(@cmd, @replacecharindex - 1, 1) = N'['
                                           )
                                            BEGIN

                                                /* if ? is inside of [], we need to double all the ] in name */

                                                SELECT @name = REPLACE(@name, N']', N']]');
                                        END;
                                            ELSE
                                            BEGIN
                                                IF((@name LIKE N'%].%]')
                                                   AND
                                                   (SUBSTRING(@name, 1, 1) = N'['
                                                   ))
                                                    BEGIN

                                                        /* ? is NOT inside of [] nor '', and the name is in [owner].[name] format, handle it */
                                                        /* !!! work around, when using LIKE to find string pattern, can't use '[', since LIKE operator is treating '[' as a wide char */

                                                        SELECT @tempindex = CHARINDEX(N'].[', @name);
                                                        SELECT @nametmp = SUBSTRING(@name, 2, @tempindex - 2);
                                                        SELECT @nametmp2 = SUBSTRING(@name, @tempindex + 3, LEN(@name) - @tempindex - 3);
                                                        SELECT @nametmp = REPLACE(@nametmp, N']', N']]');
                                                        SELECT @nametmp2 = REPLACE(@nametmp2, N']', N']]');
                                                        SELECT @name = N'[' + @nametmp + N'].[' + @nametmp2 + ']';
                                                END;
                                                    ELSE
                                                    BEGIN
                                                        IF((@name LIKE N'%]')
                                                           AND
                                                           (SUBSTRING(@name, 1, 1) = N'['
                                                           ))
                                                            BEGIN

                                                                /* ? is NOT inside of [] nor '', and the name is in [name] format, handle it */
                                                                /* j.i.c., since we should not fall into this case */
                                                                /* !!! work around, when using LIKE to find string pattern, can't use '[', since LIKE operator is treating '[' as a wide char */

                                                                SELECT @nametmp = SUBSTRING(@name, 2, LEN(@name) - 2);
                                                                SELECT @nametmp = REPLACE(@nametmp, N']', N']]');
                                                                SELECT @name = N'[' + @nametmp + N']';
                                                        END;
                                                END;
                                        END;
                                END;

                                /* Get the new length */

                                SELECT @namelen = DATALENGTH(@name);

                                /* start normal process */

                                IF
                                   (DATALENGTH(@cmd) + @namelen - 1 > 2000
                                   )
                                    BEGIN

                                        /* Overflow; put preceding stuff into the temp table */

                                        IF
                                           (@useq > 9
                                           )
                                            BEGIN
                                                CLOSE @local_cursor;
                                                IF @worker_type = 1
                                                    BEGIN
                                                        DEALLOCATE hCForEachDatabase;
                                                END;
                                                    ELSE
                                                    BEGIN
                                                        DEALLOCATE hCForEachTable;
                                                END;
                                                RETURN 1;
                                        END;
                                        IF
                                           (@replacecharindex < @namelen
                                           )
                                            BEGIN

                                                /* If this happened close to beginning, make sure expansion has enough room. */
                                                /* In this case no trailing space can occur as the row ends with @name. */

                                                SELECT @nextcmd = SUBSTRING(@cmd, 1, @replacecharindex);
                                                SELECT @cmd = SUBSTRING(@cmd, @replacecharindex + 1, 2000);
                                                SELECT @nextcmd = STUFF(@nextcmd, @replacecharindex, 1, @name);
                                                SELECT @replacecharindex = CHARINDEX(@replacechar, @cmd);
                                                INSERT INTO #qtemp
                                                VALUES
                                                (
                                                       @useq
                                                     , @nextcmd
                                                );
                                                SELECT @useq = @useq + 1;
                                                CONTINUE;
                                        END;

                                        /* Move the string down and stuff() in-place. */
                                        /* Because varchar columns trim trailing spaces, we may need to prepend one to the following string. */
                                        /* In this case, the char to be replaced is moved over by one. */

                                        INSERT INTO #qtemp
                                        VALUES
                                        (
                                               @useq
                                             , SUBSTRING(@cmd, 1, @replacecharindex - 1)
                                        );
                                        IF
                                           (SUBSTRING(@cmd, @replacecharindex - 1, 1) = N' '
                                           )
                                            BEGIN
                                                SELECT @cmd = N' ' + SUBSTRING(@cmd, @replacecharindex, 2000);
                                                SELECT @replacecharindex = 2;
                                        END;
                                            ELSE
                                            BEGIN
                                                SELECT @cmd = SUBSTRING(@cmd, @replacecharindex, 2000);
                                                SELECT @replacecharindex = 1;
                                        END;
                                        SELECT @useq = @useq + 1;
                                END;
                                SELECT @cmd = STUFF(@cmd, @replacecharindex, 1, @name);
                                SELECT @replacecharindex = CHARINDEX(@replacechar, @cmd);
                            END;

                        /* Done replacing for current @cmd.  Get the next one and see if it's to be appended. */

                        SELECT @usecmd = @usecmd + 1;
                        SELECT @nextcmd = CASE(@usecmd)
                                              WHEN 2
                                              THEN @command2
                                              WHEN 3
                                              THEN @command3
                                              ELSE NULL
                                          END;
                        IF(@nextcmd IS NOT NULL
                           AND SUBSTRING(@nextcmd, 1, 2) = N'++')
                            BEGIN
                                INSERT INTO #qtemp
                                VALUES
                                (
                                       @useq
                                     , @cmd
                                );
                                SELECT @cmd = SUBSTRING(@nextcmd, 3, 2000), 
                                       @useq = @useq + 1;
                                CONTINUE;
                        END;

                        /* Now exec() the generated @q*, and see if we had more commands to exec().  Continue even if errors. */
                        /* Null them first as the no-result-set case won't. */

                        SELECT @q1 = NULL, 
                               @q2 = NULL, 
                               @q3 = NULL, 
                               @q4 = NULL, 
                               @q5 = NULL, 
                               @q6 = NULL, 
                               @q7 = NULL, 
                               @q8 = NULL, 
                               @q9 = NULL, 
                               @q10 = NULL;
                        SELECT @q1 = qchar
                        FROM #qtemp
                        WHERE qnum = 1;
                        SELECT @q2 = qchar
                        FROM #qtemp
                        WHERE qnum = 2;
                        SELECT @q3 = qchar
                        FROM #qtemp
                        WHERE qnum = 3;
                        SELECT @q4 = qchar
                        FROM #qtemp
                        WHERE qnum = 4;
                        SELECT @q5 = qchar
                        FROM #qtemp
                        WHERE qnum = 5;
                        SELECT @q6 = qchar
                        FROM #qtemp
                        WHERE qnum = 6;
                        SELECT @q7 = qchar
                        FROM #qtemp
                        WHERE qnum = 7;
                        SELECT @q8 = qchar
                        FROM #qtemp
                        WHERE qnum = 8;
                        SELECT @q9 = qchar
                        FROM #qtemp
                        WHERE qnum = 9;
                        SELECT @q10 = qchar
                        FROM #qtemp
                        WHERE qnum = 10;
                        TRUNCATE TABLE #qtemp;
                        EXEC (@q1+@q2+@q3+@q4+@q5+@q6+@q7+@q8+@q9+@q10+@cmd);
                        SELECT @cmd = @nextcmd, 
                               @useq = 1;
                    END;
                FETCH @local_cursor INTO @name;
            END;

        /* while FETCH_SUCCESS */

        CLOSE @local_cursor;
        IF @worker_type = 1
            BEGIN
                DEALLOCATE hCForEachDatabase;
        END;
            ELSE
            BEGIN
                DEALLOCATE hCForEachTable;
        END;
        RETURN 0;
    END;
GO
IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'az_foreachtable'
)
    BEGIN
        DROP PROCEDURE az_foreachtable;
END;
GO
CREATE PROC [dbo].[az_foreachtable]
(@command1    NVARCHAR(2000), 
 @replacechar NCHAR(1)       = N'?', 
 @command2    NVARCHAR(2000) = NULL, 
 @command3    NVARCHAR(2000) = NULL, 
 @whereand    NVARCHAR(2000) = NULL, 
 @precommand  NVARCHAR(2000) = NULL, 
 @postcommand NVARCHAR(2000) = NULL
)
AS
    BEGIN
        DECLARE @mscat NVARCHAR(12);
        SELECT @mscat = LTRIM(STR(CONVERT(INT, 0x0002)));
        IF(@precommand IS NOT NULL)
            BEGIN
                EXEC (@precommand);
        END;
        EXEC (N'declare hCForEachTable cursor global for select ''['' + REPLACE(schema_name(syso.schema_id), N'']'', N'']]'') + '']'' + ''.'' + ''['' + REPLACE(object_name(o.id), N'']'', N'']]'') + '']'' from dbo.sysobjects o join sys.all_objects syso on o.id = syso.object_id '+N' where OBJECTPROPERTY(o.id, N''IsUserTable'') = 1 '+N' and o.category & '+@mscat+N' = 0 '+@whereand);
        DECLARE @retval INT;
        SELECT @retval = @@error;
        IF
           (@retval = 0
           )
            BEGIN
                EXEC @retval = dbo.az_foreach_worker 
                     @command1, 
                     @replacechar, 
                     @command2, 
                     @command3, 
                     0;
        END;
        IF(@retval = 0
           AND @postcommand IS NOT NULL)
            BEGIN
                EXEC (@postcommand);
        END;
        RETURN @retval;
    END;
GO
IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'az_foreachdb'
)
    BEGIN
        DROP PROCEDURE az_foreachdb;
END;
GO
SET ANSI_NULLS ON; 
GO
SET QUOTED_IDENTIFIER OFF; 
GO

/* 
* The following table definition will be created by SQLDMO at start of each connection. 
* We don't create it here temporarily because we need it in Exec() or upgrade won't work. 
*/

CREATE PROCEDURE [az_foreachdb]
(@command1    NVARCHAR(2000), 
 @replacechar NCHAR(1)       = N'?', 
 @command2    NVARCHAR(2000) = NULL, 
 @command3    NVARCHAR(2000) = NULL, 
 @precommand  NVARCHAR(2000) = NULL, 
 @postcommand NVARCHAR(2000) = NULL
)
AS
    BEGIN
        SET DEADLOCK_PRIORITY low;

        /* This proc returns one or more rows for each accessible db, with each db defaulting to its own result set */
        /* @precommand and @postcommand may be used to force a single result set via a temp table. */
        /* Preprocessor won't replace within quotes so have to use str(). */

        DECLARE @inaccessible NVARCHAR(12), @invalidlogin NVARCHAR(12), @dbinaccessible NVARCHAR(12);
        SELECT @inaccessible = LTRIM(STR(CONVERT(INT, 0x03e0), 11));
        SELECT @invalidlogin = LTRIM(STR(CONVERT(INT, 0x40000000), 11));
        SELECT @dbinaccessible = N'0x80000000';

        /* SQLDMODbUserProf_InaccessibleDb; the negative number doesn't work in convert() */

        IF(@precommand IS NOT NULL)
            BEGIN
                EXEC (@precommand);
        END;
        DECLARE @origdb NVARCHAR(128);
        SELECT @origdb = DB_NAME();

        /* If it's a single user db and there's an entry for it in sysprocesses who isn't us, we can't use it. */
        /* Create the select */

        EXEC (N'declare hCForEachDatabase cursor global for select name from master.dbo.sysdatabases d '+N' where (d.status & '+@inaccessible+N' = 0)'+N' and (DATABASEPROPERTY(d.name, ''issingleuser'') = 0 and (has_dbaccess(d.name) = 1))');
        DECLARE @retval INT;
        SELECT @retval = @@error;
        IF
           (@retval = 0
           )
            BEGIN
                EXEC @retval = dbo.az_foreach_worker 
                     @command1, 
                     @replacechar, 
                     @command2, 
                     @command3, 
                     1;
        END;
        IF(@retval = 0
           AND @postcommand IS NOT NULL)
            BEGIN
                EXEC (@postcommand);
        END;
        DECLARE @tempdb NVARCHAR(258);
        SELECT @tempdb = REPLACE(@origdb, N']', N']]');
        EXEC (N'use '+N'['+@tempdb+N']');
        RETURN @retval;
    END;

/****************** PROCESSING FILE *************************************/

GO  
PRINT 'ID# 15'  
print 'FQN: D:\dev\SQL\DFINAnalytics\UTIL_RecordCount.sql' 


--* USEDFINAnalytics;
GO

IF NOT EXISTS
(
	SELECT 1
	FROM SYS.tables
	WHERE name = 'DFS_RecordCount'
)
-- drop TABLE DFS_RecordCount
-- select * from dbo.DFS_RecordCount
BEGIN
	CREATE TABLE DFS_RecordCount
	( 
				 ProcName nvarchar(150) NOT NULL, 
				 HitCount int NULL DEFAULT 0,
				 SvrName  nvarchar(150) NOT NULL, 
				 DBName  nvarchar(150) NOT NULL, 
				 LastUpdate datetime null,
				 [UID] uniqueidentifier default newid()
	);
END;
GO

IF EXISTS
(
	SELECT 1
	FROM SYS.procedures
	WHERE name = 'UTIL_RecordCount'
)
BEGIN
	DROP PROCEDURE UTIL_RecordCount;
END;
GO

-- truncate table DFS_RecordCount;
-- EXEC UTIL_RecordCount 'xx1';
-- SELECT * FROM DFS_RecordCount;
CREATE PROCEDURE UTIL_RecordCount
( 
				 @procname nvarchar(100)
)
AS
BEGIN
	DECLARE @cnt AS int= 0;
	DECLARE @SvrName nvarchar(150) = @@servername;
	DECLARE @DBName nvarchar(150) = db_name();
	SET @cnt =
	(
		SELECT COUNT(*)
		FROM DFS_RecordCount
		WHERE ProcName = @procname
		and SvrName = @SvrName
		and DBName  =@DBName
	);
	IF @cnt = 0
	BEGIN
		INSERT INTO DFS_RecordCount( ProcName , HitCount, SvrName , DBName, LastUpdate)
		VALUES( @procname, 1, @SvrName, @DBName, getdate() );
	END;
	IF @cnt > 0
	BEGIN
		UPDATE DFS_RecordCount
		  SET HitCount = HitCount + 1, LastUpdate = getdate()
		WHERE ProcName = @procname
		and SvrName = @SvrName
		and DBName  =@DBName;
	END;
END;

/****************** PROCESSING FILE *************************************/

GO  
PRINT 'ID# 16'  
print 'FQN: D:\dev\SQL\DFINAnalytics\UTIL_DatabaseAndFileSize.sql' 
-- UTIL_DatabaseAndFileSize.sql
--* USEDFINAnalytics;
GO
-- DROP TABLE [dbo].[DFS_DbFileSizing]
IF EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.TABLES
    WHERE TABLE_NAME = 'DFS_DbFileSizing'
)
drop TABLE [dbo].[DFS_DbFileSizing]
go
    CREATE TABLE [dbo].[DFS_DbFileSizing]
    ([Svr]  [SYSNAME] NOT NULL, 
	[Database]  [SYSNAME] NOT NULL, 
     [File]    [SYSNAME] NOT NULL, 
     [size]    [INT] NOT NULL, 
     [SizeMB]  [INT] NULL, 
     [Database Total] [INT] NULL, 
     [max_size]  [INT] NOT NULL, 
     CreateDate  DATETIME DEFAULT GETDATE(), 
     RowNbr    INT IDENTITY(1, 1), 
     RunID     BIGINT,
	 [UID] uniqueidentifier default newid()
    )
    ON [PRIMARY];
GO
IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'UTIL_DFS_DbFileSizing'
)
    DROP PROCEDURE UTIL_DFS_DbFileSizing;
GO
-- exec UTIL_DFS_DbFileSizing
CREATE PROCEDURE UTIL_DFS_DbFileSizing
AS
    BEGIN
 DECLARE @RunID AS BIGINT= NEXT VALUE FOR master_seq;
 DECLARE @ExecutionDate DATETIME= GETDATE();
 INSERT INTO [dbo].[DFS_DbFileSizing]
 ([Svr],[Database], 
  [File], 
  [size], 
  [SizeMB], 
  [Database Total], 
  [max_size], 
  [CreateDate], 
  [RunID],
		 [UID]
 )
   SELECT @@SERVERNAME, d.name AS 'Database', 
   m.name AS 'File', 
   m.size, 
   m.size * 8 / 1024 'SizeMB', 
   SUM(m.size * 8 / 1024) OVER(PARTITION BY d.name) AS 'Database Total', 
   m.max_size, 
   create_date = @ExecutionDate, 
   RunID = @RunID,
					  [UID] = newid()
   FROM sys.master_files m
 INNER JOIN sys.databases d ON d.database_id = m.database_id
   WHERE d.name NOT IN('msdb', 'master', 'ReportServer', 'ReportServerTempDB', 'TempDB', 'model');
    END;

/****************** PROCESSING FILE *************************************/

GO  
PRINT 'ID# 17'  
print 'FQN: D:\dev\SQL\DFINAnalytics\UTIL_DB_And_Table_Size_Monitor.sql' 

GO

/* drop table DFS_DBSpace */

IF NOT EXISTS
(
    SELECT 1
    FROM sys.tables
    WHERE name = 'DFS_DBSpace'
)
    BEGIN
        CREATE TABLE DFS_DBSpace
        (SVR                 NVARCHAR(150) NULL, 
         database_name       NVARCHAR(150) NULL, 
         database_size       NVARCHAR(150) NULL, 
         [unallocated space] NVARCHAR(150) NULL, 
         reserved            NVARCHAR(150) NULL, 
         [data]              NVARCHAR(150) NULL, 
         index_size          NVARCHAR(150) NULL, 
         unused              NVARCHAR(150) NULL, 
         CreateDate          DATETIME DEFAULT GETDATE() NOT NULL, 
         [UID]               UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL
        );
END;
GO
IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'UTIL_DBSpace'
)
    BEGIN
        DROP PROCEDURE UTIL_DBSpace;
END;
GO

/*
exec UTIL_DBSpace
SELECT * FROM DFS_DBSpace 
*/

CREATE PROCEDURE UTIL_DBSpace
AS
    BEGIN
        BEGIN
            BEGIN TRY
                CREATE TABLE #DFS_DBSpace
                (database_name       NVARCHAR(150) NULL, 
                 database_size       NVARCHAR(150) NULL, 
                 [unallocated space] NVARCHAR(150) NULL, 
                 reserved            NVARCHAR(150) NULL, 
                 [data]              NVARCHAR(150) NULL, 
                 index_size          NVARCHAR(150) NULL, 
                 unused              NVARCHAR(150) NULL
                );
            END TRY
            BEGIN CATCH
                TRUNCATE TABLE #DFS_DBSpace;
            END CATCH;
            INSERT INTO #DFS_DBSpace
            EXEC sp_spaceused 
                 @oneresultset = 1;
            INSERT INTO DFS_DBSpace
                   SELECT @@servername AS SVR, 
                          database_name, 
                          database_size, 
                          [unallocated space], 
                          reserved, 
                          [data], 
                          index_size, 
                          unused, 
                          GETDATE() AS CreateDate, 
                          NEWID() AS [UID]
                   FROM #DFS_DBSpace;
        END;
    END;
GO

/*******************************************************************************
 drop table DFS_DBTableSpace*/

IF not EXISTS
(
    SELECT 1
    FROM sys.tables
    WHERE name = 'DFS_DBTableSpace'
)
    BEGIN
        CREATE TABLE DFS_DBTableSpace
        (SVR        NVARCHAR(150) NULL, 
         DBName     NVARCHAR(150) NULL, 
         [name]     NVARCHAR(150) NULL, 
         [rows]     NVARCHAR(150) NULL, 
         reserved   NVARCHAR(150) NULL, 
         [data]     NVARCHAR(150) NULL, 
         index_size NVARCHAR(150) NULL, 
         unused     NVARCHAR(150) NULL, 
         CreateDate DATETIME DEFAULT GETDATE() NOT NULL, 
         [UID]      UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL
        );
END; 
GO
IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'UTIL_DBTableSpace'
)
    BEGIN
        DROP PROCEDURE UTIL_DBTableSpace;
END;
GO

/* exec UTIL_DBTableSpace*/

CREATE PROCEDURE UTIL_DBTableSpace
AS
    BEGIN
        BEGIN
            BEGIN TRY
                CREATE TABLE #TgtTables([tblname] NVARCHAR(250) NULL, );
            END TRY
            BEGIN CATCH
                TRUNCATE TABLE #TgtTables;
            END CATCH;
            INSERT INTO #TgtTables
                   SELECT S.name + '.' + T.name AS tblname
                   FROM sys.tables T
                             JOIN sys.schemas S
                             ON S.schema_id = T.schema_id;
            BEGIN TRY
                CREATE TABLE #DFS_DBTableSpace
                ([name]     NVARCHAR(150) NULL, 
                 [rows]     NVARCHAR(150) NULL, 
                 reserved   NVARCHAR(150) NULL, 
                 [data]     NVARCHAR(150) NULL, 
                 index_size NVARCHAR(150) NULL, 
                 unused     NVARCHAR(150) NULL
                );
            END TRY
            BEGIN CATCH
                TRUNCATE TABLE #DFS_DBTableSpace;
            END CATCH;
            DECLARE @name NVARCHAR(250)= '';
            DECLARE db_cursor CURSOR
            FOR SELECT tblname
                FROM #TgtTables;
            OPEN db_cursor;
            FETCH NEXT FROM db_cursor INTO @name;
            WHILE @@FETCH_STATUS = 0
                BEGIN
                    TRUNCATE TABLE #DFS_DBTableSpace;

                    /************************************************/

                    INSERT INTO #DFS_DBTableSpace
                    EXEC sp_spaceused 
                         @name;
                    INSERT INTO DFS_DBTableSpace
                           SELECT @@servername AS SVR, 
                                  DB_NAME() AS DBName, 
                                  [name], 
                                  [rows], 
                                  reserved, 
                                  [data], 
                                  index_size, 
                                  unused, 
                                  GETDATE() AS CreateDate, 
                                  NEWID() AS [UID]
                           FROM #DFS_DBTableSpace;

                    /************************************************/

                    FETCH NEXT FROM db_cursor INTO @name;
                END;
            CLOSE db_cursor;
            DEALLOCATE db_cursor;
        END;

        /*SELECT * FROM DFS_DBTableSpace;*/

    END;

/****************** PROCESSING FILE *************************************/

GO  
PRINT 'ID# 19'  
print 'D:\dev\SQL\DFINAnalytics\UTIL_DetermineWhichWaitsMostCommon.sql' 

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

/****************** PROCESSING FILE *************************************/

GO  
PRINT 'ID# 20'  
print 'D:\dev\SQL\DFINAnalytics\PrintImmediate.sql' 
--* USEDFINAnalytics;
GO
IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'PrintImmediate'
)
    DROP PROCEDURE PrintImmediate;
GO
CREATE PROCEDURE [dbo].[PrintImmediate](@MSG AS NVARCHAR(MAX))
AS
    BEGIN
 RAISERROR(@MSG, 10, 1) WITH NOWAIT;
    END;
GO
--* USEMASTER;
GO
IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'sp_PrintImmediate'
)
    DROP PROCEDURE sp_PrintImmediate;
GO
CREATE PROCEDURE [dbo].[sp_PrintImmediate](@MSG AS NVARCHAR(MAX))
AS
    BEGIN
 RAISERROR(@MSG, 10, 1) WITH NOWAIT;
    END;


/****************** PROCESSING FILE *************************************/

GO  
PRINT 'ID# 21'  
print 'D:\dev\SQL\DFINAnalytics\UTIL_SavePullCnt.sql' 

/*

--drop TABLE [dbo].[DFS_PullCounts]
select * from DFS_PullCounts where PulledCount > 0 order by PulledBy, Svr, DB, PullDate, RowNbr desc
--alter TABLE [dbo].[DFS_PullCounts] add RowNbr int identity (1,1) not null

*/

if not exists (select name from sys.tables where name = 'DFS_PullCounts')
	begin
		CREATE TABLE [dbo].[DFS_PullCounts](
			[svr] [nvarchar](150) NULL,
			[DB] [nvarchar](150) NULL,
			PulledBy [nvarchar](150) NULL,
			PullDate datetime default getdate(),
			PulledCount bigint null, 
			RowNbr int identity (1,1) not null
		) ON [PRIMARY]

	end
go
if exists (select 1 from sys.procedures where name = 'UTIL_SavePullCnt')
begin 
	drop procedure UTIL_SavePullCnt;
end

go

/*
exec procedure UTIL_SavePullCnt @svr,@DB,@PulledBy,@PulledCount;
*/

create procedure UTIL_SavePullCnt (@svr nvarchar(150),
			@DB nvarchar(150) ,
			@PulledBy nvarchar(150),			
			@PulledCount bigint null)
as
begin 
	declare @PullDate datetime = getdate();

	insert into [DFS_PullCounts] (
		[svr],
		[DB],
		PulledBy,
		PullDate,
		PulledCount
	)
	values (
		@svr,
		@DB,
		@PulledBy,
		@PullDate,
		@PulledCount
	)
	OPTION (MAXDOP 1);  
end

/****************** PROCESSING FILE *************************************/

GO  
PRINT 'ID# 25'  
print 'D:\dev\SQL\DFINAnalytics\findTempDbContention.sql' 

/****** Object:  Table [dbo].[XX]    Script Date: 2/12/2019 9:33:07 AM ******/
IF EXISTS
(
    SELECT 1
    FROM sys.tables
    WHERE name = 'DFS_TempDbMonitor'
)
    DROP TABLE [DFS_TempDbMonitor];
GO
CREATE TABLE [dbo].[DFS_TempDbMonitor]
([SVR]                  [NVARCHAR](128) NULL, 
 [DBNAme]               [NVARCHAR](128) NULL, 
 [session_id]           [SMALLINT] NULL, 
 [exec_context_id]      [INT] NULL, 
 [wait_duration_ms]     [BIGINT] NULL, 
 [wait_type]            [NVARCHAR](60) NULL, 
 [blocking_session_id]  [SMALLINT] NULL, 
 [resource_description] [NVARCHAR](3072) NULL, 
 [Node ID]              [NVARCHAR](3072) NULL, 
 [program_name]         [NVARCHAR](128) NULL, 
 [Qry_Sql]              [NVARCHAR](MAX) NULL, 
 [database_id]          [SMALLINT] NOT NULL, 
 [query_plan]           [XML] NULL, 
 [cpu_time]             [INT] NOT NULL, 
 [plan_hash]            [VARBINARY](8000) NULL, 
 [qry_hash]             [VARBINARY](8000) NULL, 
 CreateDate             DATETIME DEFAULT GETDATE(), 
 RunID                  BIGINT, 
 [UID]                  [UNIQUEIDENTIFIER] NULL
)
ON [PRIMARY];
CREATE UNIQUE INDEX pk_DFS_TempDbMonitor
ON [DFS_TempDbMonitor]
([UID]
);
GO

/*
Consider the scenario of hundreds of concurrent queries that all 
create, use, and then drop small temporary tables (that by their 
very nature are always stored in tempdb). Each time a temp table 
is created, a data page must be allocated, plus an allocation 
metadata page to keep track of the data pages allocated to the 
table. This requires making a note in an allocation page (called 
a PFS page – see here for in-depth info) that those two pages have 
been allocated in the database. When the temp table is dropped, 
those pages are deallocated, and they must be marked as such in that 
PFS page again. Only one thread at a time can be changing the allocation 
page, making it a hotspot and slowing down the overall workload.
*/

IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'UTIL_TempDbMonitor'
)
    DROP PROCEDURE UTIL_TempDbMonitor;
GO

/*
exec UTIL_TempDbMonitor -9
select * from [DFS_TempDbMonitor]
*/

CREATE PROCEDURE UTIL_TempDbMonitor(@RunID BIGINT)
AS
    BEGIN
        INSERT INTO DFS_TempDbMonitor
               SELECT SVR = @@serverName, 
                      DBNAme = DB_NAME(), 
                      [owt].[session_id], 
                      [owt].[exec_context_id], 
                      [owt].[wait_duration_ms], 
                      [owt].[wait_type], 
                      [owt].[blocking_session_id], 
                      [owt].[resource_description],
                      CASE [owt].[wait_type]
                          WHEN N'CXPACKET'
                          THEN RIGHT([owt].[resource_description], CHARINDEX(N'=', REVERSE([owt].[resource_description])) - 1)
                          ELSE NULL
                      END AS [Node ID], 
                      [es].[program_name], 
                      [est].text AS Qry_Sql, 
                      [er].[database_id], 
                      [eqp].[query_plan], 
                      [er].[cpu_time], 
                      plan_hash = HASHBYTES('SHA1', SUBSTRING(CAST([eqp].[query_plan] AS NVARCHAR(4000)), 1, 4000)), 
                      qry_hash = HASHBYTES('SHA1', SUBSTRING(CAST([est].text AS NVARCHAR(4000)), 1, 4000)), 
                      CreateDate = GETDATE(), 
                      RunID = @RunID, 
                      [UID] = NEWID()
               FROM sys.dm_os_waiting_tasks [owt]
                         INNER JOIN sys.dm_exec_sessions [es]
                         ON [owt].[session_id] = [es].[session_id]
                              INNER JOIN sys.dm_exec_requests [er]
                         ON [es].[session_id] = [er].[session_id]
                                   OUTER APPLY sys.dm_exec_sql_text([er].[sql_handle]) [est]
                                        OUTER APPLY sys.dm_exec_query_plan([er].[plan_handle]) [eqp]
               WHERE [es].[is_user_process] = 1
               ORDER BY [owt].[session_id], 
                        [owt].[exec_context_id];
    END;
GO

/****************** PROCESSING FILE *************************************/

GO  
PRINT 'ID# 26'  
print 'D:\dev\SQL\DFINAnalytics\FindParallelism.sql' 

IF EXISTS
(
    SELECT 1
    FROM sys.tables
    WHERE name = 'DFS_ParallelMonitor'
)
    DROP TABLE [DFS_ParallelMonitor];
GO
CREATE TABLE [dbo].[DFS_ParallelMonitor]
([SVR]                    [NVARCHAR](128) NULL, 
 [DBNAme]                 [NVARCHAR](128) NULL, 
 [sql_handle]             [VARBINARY](64) NOT NULL, 
 [statement_start_offset] [INT] NOT NULL, 
 [statement_end_offset]   [INT] NOT NULL, 
 [dbid]                   [SMALLINT] NULL, 
 [objectid]               [INT] NULL, 
 [number]                 [SMALLINT] NULL, 
 [encrypted]              [BIT] NOT NULL, 
 [QrySql]                 [NVARCHAR](MAX) NULL, 
 [qry_hash]               [VARBINARY](8000) NULL, 
 [CreateDate]             [DATETIME] NOT NULL, 
 [RunID]                  [BIGINT] NULL, 
 [UID]                    [UNIQUEIDENTIFIER] NULL
)
ON [PRIMARY];
CREATE UNIQUE INDEX pk_DFS_ParallelMonitor
ON [DFS_ParallelMonitor]
([UID]
);
GO

/*
Another way to find parallelism is to get queries where the amount 
of time spent by the workers are more than the query execution time. 
Use the below method:
*/

IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'UTIL_ParallelMonitor'
)
    DROP PROCEDURE UTIL_ParallelMonitor;
GO

/*
exec UTIL_ParallelMonitor -9
select * from [DFS_ParallelMonitor]
*/
CREATE PROCEDURE UTIL_ParallelMonitor(@RunID BIGINT)
AS
    BEGIN
        DECLARE @cnt INT= 0;
        SET @cnt =
        (
            SELECT COUNT(1) AS cnt
            FROM sys.dm_exec_query_stats qs
                      CROSS APPLY sys.dm_exec_sql_text(qs.plan_handle) AS q
            WHERE qs.total_worker_time > qs.total_elapsed_time
        );
        
		IF
           (@cnt > 0
           )
            BEGIN
                INSERT INTO [DFS_ParallelMonitor]
                       SELECT SVR = @@serverName, 
                              DBNAme = DB_NAME(), 
                              qs.sql_handle, 
                              qs.statement_start_offset, 
                              qs.statement_end_offset, 
                              q.dbid, 
                              q.objectid, 
                              q.number, 
                              q.encrypted, 
                              q.TEXT AS QrySql, 
                              qry_hash = HASHBYTES('SHA1', SUBSTRING(CAST(q.TEXT AS NVARCHAR(4000)), 1, 4000)), 
                              CreateDate = GETDATE(), 
                              RunID = @RunID, 
                              [UID] = NEWID()
                       FROM sys.dm_exec_query_stats qs
                                 CROSS APPLY sys.dm_exec_sql_text(qs.plan_handle) AS q
                       WHERE qs.total_worker_time > qs.total_elapsed_time;
        END;
    END;

/****************** PROCESSING FILE *************************************/

GO  
PRINT 'ID# 27'  
print 'D:\dev\SQL\DFINAnalytics\UTIL_SsisExecHist.sql' 

GO
/*
	truncate table DFS_SsisExecHist
	
	select * from DFS_SsisExecHist
	select * from ActiveServers order by SvrName, DBName

	delete from ActiveServers where DBNAme in ('master', 'ReportServer', 'ReportServerTempDB')

	update ActiveServers set [enable] = 0 where SvrName = 'ALIEN15' and DBName = 'TestDB'
	update ActiveServers set [enable] = 0 where SvrName = 'SVR2016' and DBName = 'TestDB'
	update ActiveServers set [enable] = 0 where SvrName = 'ALIEN15' and DBName = 'AW_AZURE'
	update ActiveServers set [enable] = 0 where SvrName = 'ALIEN15' and DBName = 'TestXml'
	update ActiveServers set [enable] = 0 where SvrName = 'ALIEN15' and DBName = 'DFINAnalytics'
	update ActiveServers set [enable] = 0 where SvrName = 'ALIEN15' and DBName = 'PowerDatabase'
*/
if not exists(select 1 from sys.tables where name = 'DFS_SsisExecHist')
begin 
	create table DFS_SsisExecHist(
		SvrName nvarchar(150) null,
		DBName nvarchar(150) null,
		CreateDate datetime default getdate(),
		RowNbr int identity (1,1) not null
	)
end ;
go
if exists(select 1 from sys.procedures where name = 'UTIL_SsisExecHist')
	drop procedure UTIL_SsisExecHist;
go
create procedure UTIL_SsisExecHist (@SVR nvarchar(150), @DB nvarchar(150))
as
	insert into DFS_SsisExecHist (SvrName,DBName) values (@SVR, @DB);

GO

/****************** PROCESSING FILE *************************************/

GO  
PRINT 'ID# 28'  
print 'D:\dev\SQL\DFINAnalytics\UTIL_getActiveDatabases.sql' 
GO
PRINT '***  WORKING IN DATABASE ' + DB_NAME();
GO
IF EXISTS
(
    SELECT 1
    FROM sys.tables
    WHERE name = 'ActiveServers'
)
    BEGIN
        DROP TABLE ActiveServers;
        PRINT '*********** RESET table ActiveServers ***********';
END; 
GO
CREATE TABLE ActiveServers
([GroupName] [NVARCHAR](50) NOT NULL, 
 [isAzure]   [CHAR](1) NOT NULL, 
 [SvrName]   [NVARCHAR](250) NOT NULL, 
 [DBName]    [NVARCHAR](150) NOT NULL, 
 [UserID]    [NVARCHAR](50) NULL, 
 [pwd]       [NVARCHAR](50) NULL, 
 [UID]       [UNIQUEIDENTIFIER] NOT NULL, 
 [Enable]    [BIT] NULL
)
ON [PRIMARY];
ALTER TABLE [dbo].[ActiveServers]
ADD CONSTRAINT [DF_ActiveServers_UID] DEFAULT(NEWID()) FOR [UID];
ALTER TABLE [dbo].[ActiveServers]
ADD DEFAULT((1)) FOR [Enable];
GO
IF EXISTS
(
    SELECT 1
    FROM sys.views
    WHERE name = 'viewAwaitingJobs'
)
    BEGIN
        DROP VIEW viewAwaitingJobs;
END;
GO

/*
alter table [dbo].[ActiveJob] add [Enable] char(1) default 'Y';
update [dbo].[ActiveJob] set [Enable] = 'Y'
*/

IF EXISTS
(
    SELECT 1
    FROM sys.tables
    WHERE name = 'ActiveJob'
)
    BEGIN
        DROP TABLE ActiveJob;
END;
GO
CREATE TABLE [dbo].[ActiveJob]
([JobName]      [NVARCHAR](150) NOT NULL, 
 [disabled]     [CHAR](1) NULL, 
 [UID]          [UNIQUEIDENTIFIER] NOT NULL, 
 [ScheduleUnit] [NVARCHAR](25) NULL, 
 [ScheduleVal]  [INT] NULL, 
 [LastRunDate]  [DATETIME] NULL, 
 [NextRunDate]  [DATETIME] NULL, 
 [Enable]       CHAR(1) DEFAULT 'Y', 
 [RowNbr]       [INT] IDENTITY(1, 1) NOT NULL
)
ON [PRIMARY];
ALTER TABLE [dbo].[ActiveJob]
ADD DEFAULT('N') FOR [disabled];
ALTER TABLE [dbo].[ActiveJob]
ADD DEFAULT(NEWID()) FOR [UID];
ALTER TABLE [dbo].[ActiveJob]
ADD DEFAULT(GETDATE()) FOR [LastRunDate];
ALTER TABLE [dbo].[ActiveJob]
ADD DEFAULT(GETDATE()) FOR [NextRunDate];
GO
IF NOT EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.columns
    WHERE TABLE_NAME = 'ActiveJob'
          AND COLUMN_NAME = 'Enable'
)
    BEGIN
        ALTER TABLE [dbo].[ActiveJob]
        ADD [Enable] CHAR(1) DEFAULT 'Y';
        UPDATE [dbo].[ActiveJob]
          SET 
              [Enable] = 'Y';
END;
GO

/*
drop table ActiveJobSchedule
*/

IF NOT EXISTS
(
    SELECT 1
    FROM sys.tables
    WHERE name = 'ActiveJobSchedule'
)
    BEGIN
        CREATE TABLE ActiveJobSchedule
        (SvrName     NVARCHAR(150) NOT NULL, 
         JobName     NVARCHAR(150) NOT NULL, 
         [Disabled]  CHAR(1) NOT NULL
                             DEFAULT 'N', 
         LastRunDate DATETIME NULL
                              DEFAULT GETDATE(), 
         NextRunDate DATETIME NULL
                              DEFAULT GETDATE()
        );
        CREATE UNIQUE INDEX pkActiveJobSchedule
        ON ActiveJobSchedule
        (SvrName, JobName
        );
        CREATE INDEX piActiveJobScheduleDisabled
        ON ActiveJobSchedule
        ([Disabled]
        );
END;
GO
IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'UTIL_ActiveJobSetLastRunDate'
)
    BEGIN
        DROP PROCEDURE UTIL_ActiveJobSetLastRunDate;
END;
GO

/*
exec UTIL_ActiveJobSetLastRunDate 6
exec UTIL_ActiveJobSetLastRunDate 170
*/

CREATE PROCEDURE UTIL_ActiveJobSetLastRunDate(@JobName NVARCHAR(150))
AS
    BEGIN
        DECLARE @ScheduleUnit AS NVARCHAR(25)= '';
        DECLARE @ScheduleVal INT= 0;
        DECLARE @NextRunDate AS DATETIME= NULL;
        DECLARE @UpdateNow AS INT= 0;
        SET @ScheduleUnit =
        (
            SELECT ScheduleUnit
            FROM [dbo].[ActiveJob]
            WHERE JobName = @JobName
        );
        SET @ScheduleVal =
        (
            SELECT ScheduleVal
            FROM [dbo].[ActiveJob]
            WHERE JobName = @JobName
        );
        IF
           (@ScheduleUnit = 'sec'
           )
            BEGIN
                SET @NextRunDate = DATEADD(SECOND, @ScheduleVal, GETDATE());
                SET @UpdateNow = 1;
        END;
        IF
           (@ScheduleUnit = 'min'
           )
            BEGIN
                SET @NextRunDate = DATEADD(MINUTE, @ScheduleVal, GETDATE());
                SET @UpdateNow = 1;
        END;
        IF
           (@ScheduleUnit = 'hour'
           )
            BEGIN
                SET @NextRunDate = DATEADD(HOUR, @ScheduleVal, GETDATE());
                SET @UpdateNow = 1;
        END;
        IF
           (@ScheduleUnit = 'day'
           )
            BEGIN
                SET @NextRunDate = DATEADD(DAY, @ScheduleVal, GETDATE());
                SET @UpdateNow = 1;
        END;
        IF
           (@UpdateNow = 1
           )
            BEGIN
                UPDATE [dbo].[ActiveJob]
                  SET 
                      [NextRunDate] = @NextRunDate
                WHERE JobName = @JobName;
        END;
        PRINT 'LastRunDate set to : ' + CAST(@NextRunDate AS NVARCHAR(60)) + ' on Job ' + @JobName;
    END;
GO

/*
exec UTIL_ActiveJobSetLastRunDate 'JOB_DFS_BoundQry_ProcessAllTables', '93b33429-854e-4d96-a001-2b0f4da547ba'
select * from ActiveJob 
delete from ActiveJob

select distinct isAzure +'|' + SvrName + '|' + DBName +'|' + isnull(UserID,'') + '|' + isnull(pwd,'') as [DATA]
from [dbo].[ActiveJob]

drop table ActiveJob;
drop table ActiveJobStep;
drop table ActiveJobExecutions;
*/

IF NOT EXISTS
(
    SELECT 1
    FROM sys.tables
    WHERE name = 'ActiveJobExecutions'
)
    BEGIN
        CREATE TABLE ActiveJobExecutions
        ([JobName]          NVARCHAR(150) NOT NULL, 
         [SvrName]          NVARCHAR(150) NOT NULL, 
         [DBName]           NVARCHAR(150) NOT NULL, 
         [StepName]         NVARCHAR(150) NOT NULL, 
         [JOBUID]           UNIQUEIDENTIFIER NOT NULL, 
         ExecutionDate      DATE DEFAULT GETDATE(), 
         StartExecutionDate DATETIME2 DEFAULT GETDATE(), 
         EndExecutionDate   DATETIME2 NULL, 
         NextRunDate        DATETIME2 NULL, 
         [ScheduleUnit]     NVARCHAR(25) NULL, 
         [ScheduleVal]      INT NULL, 
         elapsedMS          DECIMAL(18, 4) NULL, 
         elapsedSEC         DECIMAL(18, 4) NULL, 
         elapsedMIN         DECIMAL(18, 4) NULL, 
         elapsedHR          DECIMAL(18, 4) NULL, 
         JobRowNbr          INT NULL, 
         StepRowNbr         INT NULL, 
         RowNbr             INT IDENTITY(1, 1) NOT NULL
        );
        CREATE INDEX piActiveJobExecutionsRowNbr
        ON ActiveJobExecutions
        (SvrName, DBName, [JobName], [StepName], RowNbr
        );
        CREATE INDEX piActiveJobExecutions
        ON ActiveJobExecutions
        (SvrName, DBName, [StepName], [JobName], [JOBUID]
        );
        CREATE INDEX piActiveJobExecutionsUID
        ON ActiveJobExecutions
        (JobRowNbr, StepRowNbr
        );
END;
GO
IF NOT EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.columns
    WHERE TABLE_NAME = 'ActiveJobExecutions'
          AND COLUMN_NAME = 'RowNbr'
)
    BEGIN
        ALTER TABLE ActiveJobExecutions
        ADD RowNbr INT IDENTITY(1, 1) NOT NULL;
END;
IF NOT EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.columns
    WHERE TABLE_NAME = 'ActiveJobExecutions'
          AND COLUMN_NAME = 'NextRunDate'
)
    BEGIN
        ALTER TABLE ActiveJobExecutions
        ADD NextRunDate DATETIME NULL
                                 DEFAULT GETDATE();
END;
IF NOT EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.columns
    WHERE TABLE_NAME = 'ActiveJobExecutions'
          AND COLUMN_NAME = 'ScheduleUnit'
)
    BEGIN
        ALTER TABLE ActiveJobExecutions
        ADD ScheduleUnit NVARCHAR(25) NULL;
END;
IF NOT EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.columns
    WHERE TABLE_NAME = 'ActiveJobExecutions'
          AND COLUMN_NAME = 'ScheduleVal'
)
    BEGIN
        ALTER TABLE ActiveJobExecutions
        ADD ScheduleVal INT NULL;
END;
GO
IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'UTIL_ActiveJobExecutions'
)
    BEGIN
        DROP PROCEDURE UTIL_ActiveJobExecutions;
END;
GO

/*
delete from ActiveJobExecutions

declare @UID uniqueidentifier = newid();
print @UID
exec UTIL_ActiveJobExecutions 'S', 'XXX', 'Step01', 'MAIN_SERVER', 'MASTER_DB', '95B723BD-7110-4A40-BD21-2E65C8D317FE';
select top 100 * from ActiveJobExecutions ;
select top 100 * from ActiveJob order by lastRunDate desc ;
exec UTIL_ActiveJobExecutions 'E', 'XXX', 'Step01', 'MAIN_SERVER', 'MASTER_DB', '95B723BD-7110-4A40-BD21-2E65C8D317FE';
select * from ActiveJobExecutions ;
select datediff(millisecond, StartExecutionDate,EndExecutionDate) as DD from ActiveJobExecutions ;
select * from ActiveJob ;

this procedure is called with "function setTimer" within D:\dev\SQL\DFINAnalytics\PowerShell\JobsDFIN\modules\JOB_StdFunctions.ps1

*/

CREATE PROCEDURE UTIL_ActiveJobExecutions
(@action   CHAR(1), 
 @JobName  NVARCHAR(150), 
 @StepName NVARCHAR(150), 
 @SvrName  NVARCHAR(150), 
 @DBName   NVARCHAR(150), 
 @JOBUID   NVARCHAR(60)
)
AS
    BEGIN
        DECLARE @ScheduleUnit NVARCHAR(50)= '';
        DECLARE @ScheduleVal INT= -1;
        DECLARE @NextRunDate DATETIME;
        SET @ScheduleUnit =
        (
            SELECT ScheduleUnit
            FROM [dbo].[ActiveJob]
            WHERE Jobname = @Jobname
        );
        SET @ScheduleVal =
        (
            SELECT ScheduleVal
            FROM [dbo].[ActiveJob]
            WHERE Jobname = @Jobname
        );
        SET @NextRunDate =
        (
            SELECT dbo.CalcNextRunDate(@ScheduleUnit, @ScheduleVal)
        );
        IF
           (@action = 'S'
           )
            BEGIN
                INSERT INTO [dbo].[ActiveJobExecutions]
                ( [JobName], 
                  [SvrName], 
                  [DBName], 
                  [StepName], 
                  [JOBUID], 
                  [ExecutionDate], 
                  [StartExecutionDate], 
                  ScheduleUnit, 
                  ScheduleVal
                ) 
                VALUES
                (
                       @JobName
                     , @SvrName
                     , @DBName
                     , @StepName
                     , CAST(@JOBUID AS UNIQUEIDENTIFIER)
                     , GETDATE()
                     , GETDATE()
                     , @ScheduleUnit
                     , @ScheduleVal
                );
                PRINT 'ADDED: ' + @SvrName + ' @ ' + @DBName + ' @ ' + @StepName + ' @ ' + @JobName + ' @ ' + @JOBUID;
        END;
        IF
           (@action = 'E'
           )
            BEGIN
                UPDATE [ActiveJobExecutions]
                  SET 
                      [EndExecutionDate] = GETDATE(), 
                      elapsedMS = DATEDIFF(MILLISECOND, StartExecutionDate, GETDATE()), 
                      elapsedSEC = DATEDIFF(SECOND, StartExecutionDate, GETDATE()), 
                      elapsedMIN = DATEDIFF(MINUTE, StartExecutionDate, GETDATE()), 
                      elapsedHR = DATEDIFF(HOUR, StartExecutionDate, GETDATE()), 
                      NextRunDate = @NextRunDate
                WHERE JobName = @JobName
                      AND StepName = @StepName
                      AND SvrName = @SvrName
                      AND [EndExecutionDate] IS NULL;
                PRINT 'UPDATED: ' + @SvrName + ' @ ' + @DBName + ' @ ' + @StepName + ' @ ' + @JobName + ' @ ' + @JOBUID;
                UPDATE [dbo].[ActiveJob]
                  SET 
                      [LastRunDate] = GETDATE()
                WHERE JobName = @JobName;
                PRINT 'ActiveJob LastRunDate set to : ' + CAST(GETDATE() AS NVARCHAR(60));
        END;
    END;
GO
IF NOT EXISTS
(
    SELECT 1
    FROM sys.tables
    WHERE name = 'ActiveJob'
)
    BEGIN
        CREATE TABLE ActiveJob
        ([JobName]    NVARCHAR(150) NOT NULL, 
         [disabled]   CHAR(1) DEFAULT 'N', 
         [UID]        UNIQUEIDENTIFIER NOT NULL
                                       DEFAULT NEWID(), 
         ScheduleUnit NVARCHAR(25) NULL, 
         ScheduleVal  INT NULL, 
         LastRunDate  DATETIME DEFAULT GETDATE(), 
         NextRunDate  DATETIME DEFAULT GETDATE(), 
         RowNbr       INT IDENTITY(1, 1) NOT NULL
        );
        CREATE INDEX piActiveJob
        ON ActiveJob
        ([UID]
        );
        CREATE UNIQUE INDEX pk01ActiveJob
        ON ActiveJob
        (JobName
        );
END;
GO
IF NOT EXISTS
(
    SELECT 1
    FROM sys.tables
    WHERE name = 'ActiveJobStep'
)
    BEGIN
        CREATE TABLE ActiveJobStep
        ([JobName]      NVARCHAR(150) NOT NULL, 
         [StepName]     NVARCHAR(150) NOT NULL, 
         ExecutionOrder INT NULL
                            DEFAULT 1, 
         [StepSQL]      NVARCHAR(MAX) NOT NULL, 
         [disabled]     CHAR(1) DEFAULT 'N', 
         [RunIdReq]     CHAR(1) DEFAULT 'N', 
         [JOBUID]       UNIQUEIDENTIFIER NOT NULL, 
         AzureOK        CHAR(1) DEFAULT 'Y', 
         RowNbr         INT IDENTITY(1, 1) NOT NULL
        );
        CREATE UNIQUE INDEX pkActiveJobStep
        ON ActiveJobStep
        ([JobName], [StepName]
        );
END;
GO
IF NOT EXISTS
(
    SELECT column_name
    FROM INFORMATION_SCHEMA.columns
    WHERE table_name = 'ActiveJobStep'
          AND column_name = 'ExecutionOrder'
)
    BEGIN
        ALTER TABLE ActiveJobStep
        ADD ExecutionOrder INT NULL;
END;
GO
IF NOT EXISTS
(
    SELECT column_name
    FROM INFORMATION_SCHEMA.columns
    WHERE table_name = 'ActiveJobStep'
          AND column_name = 'JobName'
)
    BEGIN
        ALTER TABLE ActiveJobStep
        ADD JobName NVARCHAR(150) NULL;
END;
GO
IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE name = 'pkActiveJobStep'
)
    BEGIN
        CREATE UNIQUE NONCLUSTERED INDEX [pkActiveJobStep]
        ON [dbo].[ActiveJobStep]
        ([JOBUID] ASC, [StepName] ASC
        ) WITH(PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
        ON [PRIMARY];
END;
GO

/*alter table ActiveJobStep add JobName nvarchar(150)  null*/

GO
IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'UTIL_ActiveJob'
)
    BEGIN
        DROP PROCEDURE UTIL_ActiveJob;
END;
GO
CREATE PROCEDURE UTIL_ActiveJob
(@JobName      NVARCHAR(150), 
 @ScheduleUnit NVARCHAR(25), 
 @ScheduleVal  INT, 
 @NextRunDate  DATETIME, 
 @JobDisabled  CHAR(1)       = 'N', 
 @StepName     NVARCHAR(150), 
 @StepDisabled CHAR(1)       = 'N', 
 @StepSQL      NVARCHAR(150), 
 @RunIdReq     CHAR(1)       = 'N', 
 @AzureOK      CHAR(1)       = 'Y'
)
AS
    BEGIN
        DECLARE @JobRowNbr INT= 0;
        DECLARE @StepRowNbr INT= 0;
        DECLARE @jobguid UNIQUEIDENTIFIER= NULL;
        DECLARE @cnt INT= 0;
        SET @cnt =
        (
            SELECT COUNT(*)
            FROM ActiveJob
            WHERE JobName = @JobName
        );
        IF
           (@cnt = 1
           )
            BEGIN
                UPDATE ActiveJob
                  SET 
                      ScheduleUnit = @ScheduleUnit, 
                      ScheduleVal = @ScheduleVal, 
                      [disabled] = @JobDisabled
                WHERE JobName = @JobName;
                PRINT 'UPDATING Job: ' + @JobName + ' SET TO ' + @JobDisabled;
        END;
            ELSE
            BEGIN
                PRINT 'ADDING Job: ' + @JobName;
                INSERT INTO ActiveJob
                ( JobName, 
                  ScheduleUnit, 
                  ScheduleVal, 
                  [disabled]
                ) 
                VALUES
                (
                       @JobName
                     , @ScheduleUnit
                     , @ScheduleVal
                     , @JobDisabled
                );
        END;
        SET @jobguid =
        (
            SELECT [UID]
            FROM ActiveJob
            WHERE JobName = @JobName
        );
        PRINT '@jobguid = ' + CAST(@jobguid AS NVARCHAR(60));
        SET @cnt =
        (
            SELECT COUNT(*)
            FROM ActiveJobStep
            WHERE JobName = @JobName 
				  and StepName = @StepName
                  AND JOBUID = @jobguid
        );
        PRINT 'COUNT FROM ActiveJobStep = ' + CAST(@cnt AS NVARCHAR(50));
        IF
           (@cnt = 0
           )
            BEGIN
                PRINT 'ADDING Step: ' + @JobName + ' : '  + @StepName;
                INSERT INTO ActiveJobStep
                ( JobName, [StepName], 
                  [StepSQL], 
                  [disabled], 
                  [RunIdReq], 
                  [JOBUID], 
                  AzureOK
                ) 
                VALUES
                (
                     @JobName
					 ,  @StepName
                     , @StepSQL
                     , @StepDisabled
                     , @RunIdReq
                     , @jobguid
                     , @AzureOK
                );
        END;
            ELSE
            BEGIN
                PRINT 'UPDATING Step: ' + @StepName;
                UPDATE ActiveJobStep
                  SET 
                      [StepSQL] = @StepSQL, 
                      [disabled] = @StepDisabled, 
                      [RunIdReq] = @RunIdReq, 
                      AzureOK = @AzureOK
                WHERE StepName = @StepName
                      AND JOBUID = @jobguid;
        END;
        SET @cnt =
        (
            SELECT COUNT(*)
            FROM ActiveJob
        );
        PRINT 'COUNT FROM ActiveJob = ' + CAST(@cnt AS NVARCHAR(50));
    END;
GO
GO
IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'UTIL_ActiveJobFetch'
)
    BEGIN
        DROP PROCEDURE UTIL_ActiveJobFetch;
END;
GO

/*
	exec UTIL_ActiveJobFetch ;
*/

CREATE PROCEDURE UTIL_ActiveJobFetch(@JobName NVARCHAR(150) = NULL)
AS
    BEGIN
        IF(@JobName IS NULL)
            BEGIN
                SELECT AJ.[JobName], 
                       AJ.[disabled] AS JobDisabled, 
                       AJ.ScheduleUnit, 
                       AJ.ScheduleVal, 
                       AJ.LastRunDate, 
                       AJ.NextRunDate, 
                       AJS.[StepName], 
                       AJS.[StepSQL], 
                       AJS.[disabled] AS StepDisabled, 
                       [RunIdReq], 
                       AzureOK, 
                       AJS.RowNbr AS StepRownbr, 
                       AJ.RowNbr AS JobRownbr
                FROM ActiveJob AS AJ
                          JOIN ActiveJobStep AS AJS
                          ON [JOBUID] = [UID]
                WHERE AJ.[disabled] = 'N'
                      AND AJ.NextRunDate <= GETDATE()
                ORDER BY AJS.RowNbr;
        END;
            ELSE
            BEGIN
                SELECT AJ.[JobName], 
                       AJ.[disabled] AS JobDisabled, 
                       AJ.ScheduleUnit, 
                       AJ.ScheduleVal, 
                       AJ.LastRunDate, 
                       AJ.NextRunDate, 
                       AJS.[StepName], 
                       AJS.[StepSQL], 
                       AJS.[disabled] AS StepDisabled, 
                       [RunIdReq], 
                       AzureOK, 
                       AJS.RowNbr AS StepRownbr, 
                       AJ.RowNbr AS JobRownbr
                FROM ActiveJob AS AJ
                          JOIN ActiveJobStep AS AJS
                          ON [JOBUID] = [UID]
                WHERE AJ.[disabled] = 'N'
                      AND AJ.JobName = @JobName
                      AND AJ.NextRunDate <= GETDATE()
                ORDER BY AJS.RowNbr;
        END;
    END;
GO
GO
IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'UTIL_ActiveJobSchedule'
)
    BEGIN
        DROP PROCEDURE UTIL_ActiveJobSchedule;
END;
GO

/*
	truncate table ActiveJobSchedule
*/

CREATE PROCEDURE UTIL_ActiveJobSchedule
AS
    BEGIN
        DECLARE @SvrName NVARCHAR(250)= '';
        DECLARE @JobName NVARCHAR(250)= '';
        DECLARE @cnt INT= 0;
        DECLARE @SvrUID UNIQUEIDENTIFIER;
        DECLARE @JobUID UNIQUEIDENTIFIER;
        DECLARE cursorDb CURSOR
        FOR SELECT DISTINCT 
                   SvrName
            FROM ActiveServers;
        OPEN cursorDb;
        FETCH NEXT FROM cursorDb INTO @SvrName;
        WHILE @@FETCH_STATUS = 0
            BEGIN
                PRINT @SvrName;
                DECLARE cursorJobs CURSOR
                FOR SELECT DISTINCT 
                           JobName
                    FROM ActiveJob;
                OPEN cursorJobs;
                FETCH NEXT FROM cursorJobs INTO @JobName;
                WHILE @@FETCH_STATUS = 0
                    BEGIN
                        PRINT @SvrName + ' : ' + @JobName;
                        SET @cnt =
                        (
                            SELECT COUNT(*)
                            FROM ActiveJobSchedule
                            WHERE SvrName = @SvrName
                                  AND JobName = @JobName
                        );
                        IF
                           (@cnt = 0
                           )
                            BEGIN
                                INSERT INTO [dbo].ActiveJobSchedule
                                ( SvrName, 
                                  JobName, 
                                  [Disabled], 
                                  [LastRunDate]
                                ) 
                                VALUES
                                (
                                       @SvrName
                                     , @JobName
                                     , 'N'
                                     , GETDATE()
                                );
                        END;
                        FETCH NEXT FROM cursorJobs INTO @JobName;
                    END;
                CLOSE cursorJobs;
                DEALLOCATE cursorJobs;
                FETCH NEXT FROM cursorDb INTO @SvrName;
            END;
        CLOSE cursorDb;
        DEALLOCATE cursorDb;
    END;
GO
GO
IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'UTIL_ActiveJobScheduleSetLastRunDate'
)
    BEGIN
        DROP PROCEDURE UTIL_ActiveJobScheduleSetLastRunDate;
END;
GO
CREATE PROCEDURE UTIL_ActiveJobScheduleSetLastRunDate
(@SvrName NVARCHAR(150), 
 @JobName NVARCHAR(150)
)
AS
    BEGIN
        DECLARE @ScheduleUnit AS NVARCHAR(25)= '';
        DECLARE @ScheduleVal INT= 0;
        DECLARE @NextRunDate AS DATETIME= NULL;
        DECLARE @UpdateNow AS INT= 0;
        DECLARE @now DATETIME= GETDATE();
        SET @ScheduleUnit =
        (
            SELECT ScheduleUnit
            FROM [dbo].[ActiveJob]
            WHERE JobName = @JobName
        );
        SET @ScheduleVal =
        (
            SELECT ScheduleVal
            FROM [dbo].[ActiveJob]
            WHERE JobName = @JobName
        );
        IF
           (@ScheduleUnit = 'sec'
           )
            BEGIN
                SET @NextRunDate = DATEADD(SECOND, @ScheduleVal, @now);
                SET @UpdateNow = 1;
        END;
        IF
           (@ScheduleUnit = 'min'
           )
            BEGIN
                SET @NextRunDate = DATEADD(MINUTE, @ScheduleVal, @now);
                SET @UpdateNow = 1;
        END;
        IF
           (@ScheduleUnit = 'hour'
           )
            BEGIN
                SET @NextRunDate = DATEADD(HOUR, @ScheduleVal, @now);
                SET @UpdateNow = 1;
        END;
        IF
           (@ScheduleUnit = 'day'
           )
            BEGIN
                SET @NextRunDate = DATEADD(DAY, @ScheduleVal, @now);
                SET @UpdateNow = 1;
        END;
        IF
           (@UpdateNow = 1
           )
            BEGIN
                UPDATE [dbo].ActiveJobSchedule
                  SET 
                      [NextRunDate] = @NextRunDate, 
                      [lastRunDate] = @now
                WHERE SvrName = @SvrName
                      AND JobName = @JobName;
        END;

/*print 'ScheduleUnit: ' + @ScheduleUnit ;
		print 'ScheduleVal: ' + cast(@ScheduleVal as nvarchar(15));
		print 'Current Datetime: ' + CAST(GETDATE() AS NVARCHAR(60));*/

        PRINT 'LastRunDate set to : ' + CAST(@NextRunDate AS NVARCHAR(60)) + ' on SvrName: ' + @SvrName + ' @ JobName: ' + @JobName;
    END;
GO
IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'UTIL_getActiveDatabases'
)
    BEGIN
        DROP PROCEDURE UTIL_getActiveDatabases;
END;
GO

/*
SELECT *
FROM [ActiveServers];
exec UTIL_getActiveDatabases 'dfintest'
*/

CREATE PROCEDURE UTIL_getActiveDatabases(@TgtGroup NVARCHAR(50))
AS
    BEGIN
        IF
           (@TgtGroup != '*'
           )
            BEGIN
                SELECT SvrName, 
                       DBName, 
                       ISNULL(UserID, 'NA') AS UserID, 
                       ISNULL(pwd, 'NA') AS pwd, 
                       isAzure, 
                       [UID]
                FROM [dbo].[ActiveServers]
                WHERE [Enable] = 1
                      AND GroupName = @TgtGroup;
        END;
            ELSE
            BEGIN
                SELECT SvrName, 
                       DBName, 
                       ISNULL(UserID, 'NA') AS UserID, 
                       ISNULL(pwd, 'NA') AS pwd, 
                       isAzure, 
                       [UID]
                FROM [dbo].[ActiveServers]
                WHERE [Enable] = 1;
        END;
    END;
GO
GO
IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'UTIL_getActiveSvrJobs'
)
    BEGIN
        DROP PROCEDURE UTIL_getActiveSvrJobs;
END;
GO

/*
exec UTIL_getActiveSvrJobs 
exec UTIL_getActiveSvrJobs 'dfintest'
*/

CREATE PROCEDURE UTIL_getActiveSvrJobs(@TgtGroup NVARCHAR(50) = NULL)
AS
    BEGIN
        IF(@TgtGroup IS NOT NULL)
            BEGIN
                SELECT [GroupName], 
                       [SvrName], 
                       [DBName], 
                       [JobName], 
                       [UserID], 
                       [pwd], 
                       [isAzure], 
                       [DBUID], 
                       [JobUID], 
                       [ScheduleUnit], 
                       [ScheduleVal], 
                       [LastRunDate], 
                       MAX(NextRunDate) AS NextRunDate, 
                       [StepName], 
                       [ExecutionOrder], 
                       [StepSQL], 
                       [RunIdReq], 
                       [AzureOK],
					   JobExecutionOrder
                FROM [dbo].[viewAwaitingJobs]
                WHERE GroupName = @TgtGroup
                GROUP BY [GroupName], 
                         [SvrName], 
                         [DBName], 
                         [JobName], 
                         [UserID], 
                         [pwd], 
                         [isAzure], 
                         [DBUID], 
                         [JobUID], 
                         [ScheduleUnit], 
                         [ScheduleVal], 
                         [LastRunDate], 
                         [StepName], 
                         [ExecutionOrder], 
                         [StepSQL], 
                         [RunIdReq], 
                         [AzureOK],
						 JobExecutionOrder
                ORDER BY JobExecutionOrder,
					     SvrName, 
                         JobName, 
                         ExecutionOrder, 
                         NextRunDate DESC;
        END;
            ELSE
            BEGIN
                SELECT [GroupName], 
                       [SvrName], 
                       [DBName], 
                       [JobName], 
                       [UserID], 
                       [pwd], 
                       [isAzure], 
                       [DBUID], 
                       [JobUID], 
                       [ScheduleUnit], 
                       [ScheduleVal], 
                       [LastRunDate], 
                       MAX(NextRunDate) AS NextRunDate, 
                       [StepName], 
                       [ExecutionOrder], 
                       [StepSQL], 
                       [RunIdReq], 
                       [AzureOK],
					   JobExecutionOrder
                FROM [dbo].[viewAwaitingJobs]
                GROUP BY [GroupName], 
                         [SvrName], 
                         [DBName], 
                         [JobName], 
                         [UserID], 
                         [pwd], 
                         [isAzure], 
                         [DBUID], 
                         [JobUID], 
                         [ScheduleUnit], 
                         [ScheduleVal], 
                         [LastRunDate], 
                         [StepName], 
                         [ExecutionOrder], 
                         [StepSQL], 
                         [RunIdReq], 
                         [AzureOK],
						 JobExecutionOrder
                ORDER BY JobExecutionOrder, SvrName, 
                         JobName, 
                         ExecutionOrder, 
                         NextRunDate DESC;
        END;
    END;
GO
IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'UTIL_getActiveSvrJobsDelimited'
)
    BEGIN
        DROP PROCEDURE UTIL_getActiveSvrJobsDelimited;
END;
GO

/*
exec UTIL_getActiveSvrJobsDelimited 
*/

CREATE PROCEDURE UTIL_getActiveSvrJobsDelimited(@TgtGroup NVARCHAR(50) = NULL)
AS
    BEGIN
        DECLARE @tblID INT= 0;
        IF(@TgtGroup IS NOT NULL)
            BEGIN
                SET @tblID = 1;
                SELECT DISTINCT 
                       [GroupName], 
                       [SvrName], 
                       [DBName], 
                       [JobName], 
                       [UserID], 
                       [pwd], 
                       [isAzure], 
                       DBUID, 
                       [JobUID], 
                       [ScheduleUnit], 
                       [ScheduleVal], 
                       [LastRunDate], 
                       [NextRunDate], 
                       [StepName], 
                       [StepSQL], 
                       [RunIdReq], 
                       [AzureOK], 
                       ExecutionOrder
                INTO #TempJobs1
                FROM [dbo].[viewAwaitingJobs]
                WHERE GroupName = @TgtGroup
                GROUP BY [GroupName], 
                         [SvrName], 
                         [DBName], 
                         [JobName], 
                         [UserID], 
                         [pwd], 
                         [isAzure], 
                         DBUID, 
                         [JobUID], 
                         [ScheduleUnit], 
                         [ScheduleVal], 
                         [LastRunDate], 
                         [NextRunDate], 
                         [StepName], 
                         [StepSQL], 
                         [RunIdReq], 
                         [AzureOK], 
                         ExecutionOrder
                ORDER BY JobName, 
                         SvrName;
        END;
            ELSE
            BEGIN
                SET @tblID = 2;
                SELECT DISTINCT 
                       [GroupName], 
                       [SvrName], 
                       [DBName], 
                       [JobName], 
                       [UserID], 
                       [pwd], 
                       [isAzure], 
                       DBUID, 
                       [JobUID], 
                       [ScheduleUnit], 
                       [ScheduleVal], 
                       [LastRunDate], 
                       [NextRunDate], 
                       [StepName], 
                       [StepSQL], 
                       [RunIdReq], 
                       [AzureOK], 
                       ExecutionOrder
                INTO #TempJobs2
                FROM [dbo].[viewAwaitingJobs]
                GROUP BY [GroupName], 
                         [SvrName], 
                         [DBName], 
                         [JobName], 
                         [UserID], 
                         [pwd], 
                         [isAzure], 
                         DBUID, 
                         [JobUID], 
                         [ScheduleUnit], 
                         [ScheduleVal], 
                         [LastRunDate], 
                         [NextRunDate], 
                         [StepName], 
                         [StepSQL], 
                         [RunIdReq], 
                         [AzureOK], 
                         ExecutionOrder
                ORDER BY JobName, 
                         SvrName;
        END;
        IF
           (@tblID = 1
           )
            BEGIN
                SELECT [GroupName] + '|' + [SvrName] + '|' + [DBName] + '|' + [JobName] + '|' + [UserID] + '|' + [pwd] + '|' + [isAzure] + '|' + CAST(DBUID AS NVARCHAR(60)) + '|' + CAST([JobUID] AS NVARCHAR(60)) + '|' + [ScheduleUnit] + '|' + CAST([ScheduleVal] AS NVARCHAR(60)) + '|' + CAST([LastRunDate] AS NVARCHAR(60)) + '|' + CAST([NextRunDate] AS NVARCHAR(60)) + '|' + [StepName] + '|' + [StepSQL] + '|' + [RunIdReq] + '|' + [AzureOK] + '|' + CAST(ExecutionOrder AS NVARCHAR(60)) + ';'
                FROM #TempJobs1;
        END;
        IF
           (@tblID = 2
           )
            BEGIN
                SELECT [GroupName] + '|' + [SvrName] + '|' + [DBName] + '|' + [JobName] + '|' + [UserID] + '|' + [pwd] + '|' + [isAzure] + '|' + CAST(DBUID AS NVARCHAR(60)) + '|' + CAST([JobUID] AS NVARCHAR(60)) + '|' + [ScheduleUnit] + '|' + CAST([ScheduleVal] AS NVARCHAR(60)) + '|' + CAST([LastRunDate] AS NVARCHAR(60)) + '|' + CAST([NextRunDate] AS NVARCHAR(60)) + '|' + [StepName] + '|' + [StepSQL] + '|' + [RunIdReq] + '|' + [AzureOK] + '|' + CAST(ExecutionOrder AS NVARCHAR(60)) + ';'
                FROM #TempJobs2;
        END;
    END;
GO

/*
select 'DECLARE @JobName NVARCHAR(150), @JobDisabled CHAR(1), @StepName NVARCHAR(150), @StepDisabled CHAR(1), @StepSQL NVARCHAR(150), @RunIdReq CHAR(1);'+char(10) as cmd
union
SELECT 'set @Jobname = ''' + AJ.[JobName] + ''';' +char(10) +
	   'set @JobDisabled = ''' + AJ.[disabled] + ''';' + char(10) +
	   'set @StepName = ''' + AJS.[StepName] + ''';' + char(10) +
	   'set @StepDisabled = ''' + AJS.[disabled] + ''';' + char(10) +
	   'set @StepSQL = ''' + AJS.[StepSQL] + ''';' + char(10) +
	   'set @RunIdReq = ''' + [RunIdReq]+ + ''';'  + char(10) +
	   'exec UTIL_ActiveJob @JobName, @ScheduleUnit,@ScheduleVal , @NextRunDate , @JobDisabled, @StepName, @StepDisabled, @StepSQL, @RunIdReq, @AzureOK;'+ char(10) as cmd
                FROM ActiveJob AJ
                          JOIN ActiveJobStep AJS
                          ON [JOBUID] = [UID]

TRUNCATE TABLE [dbo].[ActiveJob];
TRUNCATE TABLE [dbo].[ActiveJobStep];

*/

DECLARE @db NVARCHAR(150)= DB_NAME();
DECLARE @AddJobsToDatabase INT= 0;
IF
   (@db != 'DFINAnalytics'
   )
    BEGIN
        PRINT '>>> JOBS WILL NOT BE ADDED TO THIS DATABASE: ' + @DB + ', THEY EXIST IN DFINAnalytics database.';
END;
IF(@AddJobsToDatabase = 1
   AND @db = 'DFINAnalytics')
    BEGIN
        DECLARE @JobName NVARCHAR(150), @JobDisabled CHAR(1), @StepName NVARCHAR(150), @StepDisabled CHAR(1), @StepSQL NVARCHAR(150), @RunIdReq CHAR(1), @AzureOK CHAR(1);
        DECLARE @ScheduleUnit NVARCHAR(25), @ScheduleVal INT, @LastRunDate DATETIME, @NextRunDate DATETIME;
        SET @Jobname = 'JOB_CaptureWorstPerfQuery';
        SET @JobDisabled = 'N';
        SET @StepName = 'Step01';
        SET @StepDisabled = 'N';
        SET @StepSQL = 'sp_UTIL_MSTR_BoundQry2000';
        SET @RunIdReq = 'N';
        SET @AzureOK = 'Y';
        SET @ScheduleUnit = 'min';
        SET @ScheduleVal = 15;
        SET @LastRunDate = NULL;
        SET @NextRunDate = GETDATE();
        EXEC UTIL_ActiveJob 
             @JobName, 
             @ScheduleUnit, 
             @ScheduleVal, 
             @NextRunDate, 
             @JobDisabled, 
             @StepName, 
             @StepDisabled, 
             @StepSQL, 
             @RunIdReq, 
             @AzureOK;
        SET @Jobname = 'JOB_DFS_BoundQry_ProcessAllTables';
        SET @JobDisabled = 'N';
        SET @StepName = 'Step01';
        SET @StepDisabled = 'N';
        SET @StepSQL = 'UTIL_UpdateQryPlansAndText ''DFS_IO_BoundQry2000''';
        SET @RunIdReq = 'N';
        SET @AzureOK = 'Y';
        SET @ScheduleUnit = 'min';
        SET @ScheduleVal = 15;
        SET @LastRunDate = NULL;
        SET @NextRunDate = GETDATE();
        EXEC UTIL_ActiveJob 
             @JobName, 
             @ScheduleUnit, 
             @ScheduleVal, 
             @NextRunDate, 
             @JobDisabled, 
             @StepName, 
             @StepDisabled, 
             @StepSQL, 
             @RunIdReq, 
             @AzureOK;
        SET @Jobname = 'JOB_DFS_BoundQry_ProcessAllTables';
        SET @JobDisabled = 'N';
        SET @StepName = 'Step02';
        SET @StepDisabled = 'N';
        SET @StepSQL = 'UTIL_UpdateQryPlansAndText ''DFS_CPU_BoundQry2000''';
        SET @RunIdReq = 'N';
        SET @AzureOK = 'Y';
        SET @ScheduleUnit = 'min';
        SET @ScheduleVal = 30;
        SET @LastRunDate = NULL;
        SET @NextRunDate = GETDATE();
        EXEC UTIL_ActiveJob 
             @JobName, 
             @ScheduleUnit, 
             @ScheduleVal, 
             @NextRunDate, 
             @JobDisabled, 
             @StepName, 
             @StepDisabled, 
             @StepSQL, 
             @RunIdReq, 
             @AzureOK;
        SET @Jobname = 'JOB_DFS_BoundQry_ProcessAllTables';
        SET @JobDisabled = 'N';
        SET @StepName = 'Step03';
        SET @StepDisabled = 'N';
        SET @StepSQL = 'UTIL_UpdateQryPlansAndText ''DFS_IO_BoundQry''';
        SET @RunIdReq = 'N';
        SET @AzureOK = 'Y';
        SET @ScheduleUnit = 'min';
        SET @ScheduleVal = 30;
        SET @LastRunDate = NULL;
        SET @NextRunDate = GETDATE();
        EXEC UTIL_ActiveJob 
             @JobName, 
             @ScheduleUnit, 
             @ScheduleVal, 
             @NextRunDate, 
             @JobDisabled, 
             @StepName, 
             @StepDisabled, 
             @StepSQL, 
             @RunIdReq, 
             @AzureOK;
        SET @Jobname = 'JOB_DFS_BoundQry_ProcessAllTables';
        SET @JobDisabled = 'N';
        SET @StepName = 'Step04';
        SET @StepDisabled = 'N';
        SET @StepSQL = 'UTIL_UpdateQryPlansAndText ''DFS_CPU_BoundQry''';
        SET @RunIdReq = 'N';
        SET @AzureOK = 'Y';
        SET @ScheduleUnit = 'min';
        SET @ScheduleVal = 30;
        SET @LastRunDate = NULL;
        SET @NextRunDate = GETDATE();
        EXEC UTIL_ActiveJob 
             @JobName, 
             @ScheduleUnit, 
             @ScheduleVal, 
             @NextRunDate, 
             @JobDisabled, 
             @StepName, 
             @StepDisabled, 
             @StepSQL, 
             @RunIdReq, 
             @AzureOK;
        SET @Jobname = 'JOB_DFS_BoundQry_ProcessAllTables';
        SET @JobDisabled = 'N';
        SET @StepName = 'Step05';
        SET @StepDisabled = 'N';
        SET @StepSQL = 'DFS_CPU_BoundQry2000_ProcessTable';
        SET @RunIdReq = 'N';
        SET @AzureOK = 'Y';
        SET @ScheduleUnit = 'min';
        SET @ScheduleVal = 30;
        SET @LastRunDate = NULL;
        SET @NextRunDate = GETDATE();
        EXEC UTIL_ActiveJob 
             @JobName, 
             @ScheduleUnit, 
             @ScheduleVal, 
             @NextRunDate, 
             @JobDisabled, 
             @StepName, 
             @StepDisabled, 
             @StepSQL, 
             @RunIdReq, 
             @AzureOK;
        SET @Jobname = 'JOB_DFS_BoundQry_ProcessAllTables';
        SET @JobDisabled = 'N';
        SET @StepName = 'Step06';
        SET @StepDisabled = 'N';
        SET @StepSQL = 'DFS_IO_BoundQry2000_ProcessTable';
        SET @RunIdReq = 'N';
        SET @AzureOK = 'Y';
        SET @ScheduleUnit = 'min';
        SET @ScheduleVal = 30;
        SET @LastRunDate = NULL;
        SET @NextRunDate = GETDATE();
        EXEC UTIL_ActiveJob 
             @JobName, 
             @ScheduleUnit, 
             @ScheduleVal, 
             @NextRunDate, 
             @JobDisabled, 
             @StepName, 
             @StepDisabled, 
             @StepSQL, 
             @RunIdReq, 
             @AzureOK;
        SET @Jobname = 'JOB_DFS_BoundQry_ProcessAllTables';
        SET @JobDisabled = 'N';
        SET @StepName = 'Step07';
        SET @StepDisabled = 'N';
        SET @StepSQL = 'UTIL_DFS_CPU_BoundQry';
        SET @RunIdReq = 'N';
        SET @AzureOK = 'Y';
        SET @ScheduleUnit = 'min';
        SET @ScheduleVal = 15;
        SET @LastRunDate = NULL;
        SET @NextRunDate = GETDATE();
        EXEC UTIL_ActiveJob 
             @JobName, 
             @ScheduleUnit, 
             @ScheduleVal, 
             @NextRunDate, 
             @JobDisabled, 
             @StepName, 
             @StepDisabled, 
             @StepSQL, 
             @RunIdReq, 
             @AzureOK;
        SET @Jobname = 'JOB_DFS_BoundQry_ProcessAllTables';
        SET @JobDisabled = 'N';
        SET @StepName = 'Step08';
        SET @StepDisabled = 'N';
        SET @StepSQL = 'UTIL_IO_BoundQry';
        SET @RunIdReq = 'N';
        SET @AzureOK = 'Y';
        SET @ScheduleUnit = 'min';
        SET @ScheduleVal = 30;
        SET @LastRunDate = NULL;
        SET @NextRunDate = GETDATE();
        EXEC UTIL_ActiveJob 
             @JobName, 
             @ScheduleUnit, 
             @ScheduleVal, 
             @NextRunDate, 
             @JobDisabled, 
             @StepName, 
             @StepDisabled, 
             @StepSQL, 
             @RunIdReq, 
             @AzureOK;
        SET @Jobname = 'JOB_DFS_CleanDFSTables';
        SET @JobDisabled = 'N';
        SET @StepName = 'Step01';
        SET @StepDisabled = 'N';
        SET @StepSQL = 'UTIL_CleanDFSTables';
        SET @RunIdReq = 'N';
        SET @AzureOK = 'Y';
        SET @ScheduleUnit = 'hour';
        SET @ScheduleVal = 12;
        SET @LastRunDate = NULL;
        SET @NextRunDate = GETDATE();
        EXEC UTIL_ActiveJob 
             @JobName, 
             @ScheduleUnit, 
             @ScheduleVal, 
             @NextRunDate, 
             @JobDisabled, 
             @StepName, 
             @StepDisabled, 
             @StepSQL, 
             @RunIdReq, 
             @AzureOK;
        SET @Jobname = 'JOB_DFS_GetAllTableSizesAndRowCnt';
        SET @JobDisabled = 'N';
        SET @StepName = 'Step01';
        SET @StepDisabled = 'N';
        SET @StepSQL = 'DFS_GetAllTableSizesAndRowCnt';
        SET @RunIdReq = 'N';
        SET @AzureOK = 'Y';
        SET @ScheduleUnit = 'day';
        SET @ScheduleVal = 1;
        SET @LastRunDate = NULL;
        SET @NextRunDate = GETDATE();
        EXEC UTIL_ActiveJob 
             @JobName, 
             @ScheduleUnit, 
             @ScheduleVal, 
             @NextRunDate, 
             @JobDisabled, 
             @StepName, 
             @StepDisabled, 
             @StepSQL, 
             @RunIdReq, 
             @AzureOK;
        SET @Jobname = 'JOB_DFS_MonitorLocks';
        SET @JobDisabled = 'N';
        SET @StepName = 'Step01';
        SET @StepDisabled = 'N';
        SET @StepSQL = 'sp_DFS_MonitorLocks';
        SET @RunIdReq = 'N';
        SET @AzureOK = 'Y';
        SET @ScheduleUnit = 'min';
        SET @ScheduleVal = 5;
        SET @LastRunDate = NULL;
        SET @NextRunDate = GETDATE();
        EXEC UTIL_ActiveJob 
             @JobName, 
             @ScheduleUnit, 
             @ScheduleVal, 
             @NextRunDate, 
             @JobDisabled, 
             @StepName, 
             @StepDisabled, 
             @StepSQL, 
             @RunIdReq, 
             @AzureOK;
        SET @Jobname = 'JOB_JOB_UTIL_MonitorDeadlocks';
        SET @JobDisabled = 'N';
        SET @StepName = 'Step01';
        SET @StepDisabled = 'N';
        SET @StepSQL = 'sp_UTIL_DFS_DeadlockStats';
        SET @RunIdReq = 'Y';
        SET @AzureOK = 'Y';
        EXEC UTIL_ActiveJob 
             @JobName, 
             @ScheduleUnit, 
             @ScheduleVal, 
             @NextRunDate, 
             @JobDisabled, 
             @StepName, 
             @StepDisabled, 
             @StepSQL, 
             @RunIdReq, 
             @AzureOK;
        SET @Jobname = 'JOB_MonitorWorkload';
        SET @JobDisabled = 'N';
        SET @StepName = 'Step01';
        SET @StepDisabled = 'N';
        SET @StepSQL = 'UTIL_MonitorWorkload';
        SET @RunIdReq = 'N';
        SET @AzureOK = 'Y';
        SET @ScheduleUnit = 'min';
        SET @ScheduleVal = 10;
        SET @LastRunDate = NULL;
        SET @NextRunDate = GETDATE();
        EXEC UTIL_ActiveJob 
             @JobName, 
             @ScheduleUnit, 
             @ScheduleVal, 
             @NextRunDate, 
             @JobDisabled, 
             @StepName, 
             @StepDisabled, 
             @StepSQL, 
             @RunIdReq, 
             @AzureOK;
        SET @Jobname = 'JOB_UTIL_DbMon_IndexVolitity';
        SET @JobDisabled = 'N';
        SET @StepName = 'Step01';
        SET @StepDisabled = 'N';
        SET @StepSQL = 'sp_UTIL_TxMonitorTableIndexStats';
        SET @RunIdReq = 'Y';
        SET @AzureOK = 'Y';
        EXEC UTIL_ActiveJob 
             @JobName, 
             @ScheduleUnit, 
             @ScheduleVal, 
             @NextRunDate, 
             @JobDisabled, 
             @StepName, 
             @StepDisabled, 
             @StepSQL, 
             @RunIdReq, 
             @AzureOK;
        SET @Jobname = 'JOB_UTIL_DBSpace';
        SET @JobDisabled = 'N';
        SET @StepName = 'Step01';
        SET @StepDisabled = 'N';
        SET @StepSQL = 'UTIL_DBSpace';
        SET @RunIdReq = 'N';
        SET @AzureOK = 'Y';
        SET @ScheduleUnit = 'day';
        SET @ScheduleVal = 7;
        SET @LastRunDate = NULL;
        SET @NextRunDate = GETDATE();
        EXEC UTIL_ActiveJob 
             @JobName, 
             @ScheduleUnit, 
             @ScheduleVal, 
             @NextRunDate, 
             @JobDisabled, 
             @StepName, 
             @StepDisabled, 
             @StepSQL, 
             @RunIdReq, 
             @AzureOK;
        SET @Jobname = 'JOB_UTIL_DBTableSpace';
        SET @JobDisabled = 'N';
        SET @StepName = 'Step01';
        SET @StepDisabled = 'N';
        SET @StepSQL = 'UTIL_DBTableSpace';
        SET @RunIdReq = 'N';
        SET @AzureOK = 'Y';
        SET @ScheduleUnit = 'day';
        SET @ScheduleVal = 1;
        SET @LastRunDate = NULL;
        SET @NextRunDate = GETDATE();
        EXEC UTIL_ActiveJob 
             @JobName, 
             @ScheduleUnit, 
             @ScheduleVal, 
             @NextRunDate, 
             @JobDisabled, 
             @StepName, 
             @StepDisabled, 
             @StepSQL, 
             @RunIdReq, 
             @AzureOK;
        SET @Jobname = 'JOB_UTIL_DFS_DbSize';
        SET @JobDisabled = 'N';
        SET @StepName = 'Step01';
        SET @StepDisabled = 'N';
        SET @StepSQL = 'UTIL_DFS_DbFileSizing';
        SET @RunIdReq = 'N';
        SET @AzureOK = 'N';
        SET @ScheduleUnit = 'day';
        SET @ScheduleVal = 1;
        SET @LastRunDate = NULL;
        SET @NextRunDate = GETDATE();
        EXEC UTIL_ActiveJob 
             @JobName, 
             @ScheduleUnit, 
             @ScheduleVal, 
             @NextRunDate, 
             @JobDisabled, 
             @StepName, 
             @StepDisabled, 
             @StepSQL, 
             @RunIdReq, 
             @AzureOK;
        SET @Jobname = 'JOB_UTIL_GetIndexStats';
        SET @JobDisabled = 'N';
        SET @StepName = 'Step01';
        SET @StepDisabled = 'N';
        SET @StepSQL = 'sp_UTIL_GetIndexStats';
        SET @RunIdReq = 'Y';
        SET @AzureOK = 'Y';
        EXEC UTIL_ActiveJob 
             @JobName, 
             @ScheduleUnit, 
             @ScheduleVal, 
             @NextRunDate, 
             @JobDisabled, 
             @StepName, 
             @StepDisabled, 
             @StepSQL, 
             @RunIdReq, 
             @AzureOK;
        SET @Jobname = 'JOB_UTIL_MonitorDeadlocks';
        SET @JobDisabled = 'N';
        SET @StepName = 'Step01';
        SET @StepDisabled = 'N';
        SET @StepSQL = 'sp_UTIL_DFS_DeadlockStats ';
        SET @RunIdReq = 'Y';
        SET @AzureOK = 'Y';
        EXEC UTIL_ActiveJob 
             @JobName, 
             @ScheduleUnit, 
             @ScheduleVal, 
             @NextRunDate, 
             @JobDisabled, 
             @StepName, 
             @StepDisabled, 
             @StepSQL, 
             @RunIdReq, 
             @AzureOK;
        SET @Jobname = 'JOB_UTIL_MonitorMostCommonWaits';
        SET @JobDisabled = 'N';
        SET @StepName = 'Step01';
        SET @StepDisabled = 'N';
        SET @StepSQL = 'UTIL_MonitorMostCommonWaits';
        SET @RunIdReq = 'N';
        SET @AzureOK = 'Y';
        SET @ScheduleUnit = 'min';
        SET @ScheduleVal = 15;
        SET @LastRunDate = NULL;
        SET @NextRunDate = GETDATE();
        EXEC UTIL_ActiveJob 
             @JobName, 
             @ScheduleUnit, 
             @ScheduleVal, 
             @NextRunDate, 
             @JobDisabled, 
             @StepName, 
             @StepDisabled, 
             @StepSQL, 
             @RunIdReq, 
             @AzureOK;
        SET @Jobname = 'JOB_UTIL_ParallelMonitor';
        SET @JobDisabled = 'N';
        SET @StepName = 'Step01';
        SET @StepDisabled = 'N';
        SET @StepSQL = 'UTIL_ParallelMonitor';
        SET @RunIdReq = 'Y';
        SET @AzureOK = 'Y';
        EXEC UTIL_ActiveJob 
             @JobName, 
             @ScheduleUnit, 
             @ScheduleVal, 
             @NextRunDate, 
             @JobDisabled, 
             @StepName, 
             @StepDisabled, 
             @StepSQL, 
             @RunIdReq, 
             @AzureOK;
        SET @Jobname = 'JOB_UTIL_QryPlanStats';
        SET @JobDisabled = 'N';
        SET @StepName = 'Step01';
        SET @StepDisabled = 'N';
        SET @StepSQL = 'UTIL_QryPlanStats';
        SET @RunIdReq = 'N';
        SET @AzureOK = 'Y';
        SET @ScheduleUnit = 'min';
        SET @ScheduleVal = 30;
        SET @LastRunDate = NULL;
        SET @NextRunDate = GETDATE();
        EXEC UTIL_ActiveJob 
             @JobName, 
             @ScheduleUnit, 
             @ScheduleVal, 
             @NextRunDate, 
             @JobDisabled, 
             @StepName, 
             @StepDisabled, 
             @StepSQL, 
             @RunIdReq, 
             @AzureOK;
        SET @Jobname = 'JOB_UTIL_ReorgFragmentedIndexes';
        SET @JobDisabled = 'N';
        SET @StepName = 'Step01';
        SET @StepDisabled = 'N';
        SET @StepSQL = 'sp_UTIL_ReorgFragmentedIndexes';
        SET @RunIdReq = 'N';
        SET @AzureOK = 'Y';
        SET @ScheduleUnit = 'day';
        SET @ScheduleVal = 7;
        SET @LastRunDate = NULL;
        SET @NextRunDate = GETDATE();
        EXEC UTIL_ActiveJob 
             @JobName, 
             @ScheduleUnit, 
             @ScheduleVal, 
             @NextRunDate, 
             @JobDisabled, 
             @StepName, 
             @StepDisabled, 
             @StepSQL, 
             @RunIdReq, 
             @AzureOK;
        SET @Jobname = 'JOB_UTIL_TempDbMonitor';
        SET @JobDisabled = 'N';
        SET @StepName = 'Step01';
        SET @StepDisabled = 'N';
        SET @StepSQL = 'UTIL_TempDbMonitor';
        SET @RunIdReq = 'Y';
        SET @AzureOK = 'N';
        EXEC UTIL_ActiveJob 
             @JobName, 
             @ScheduleUnit, 
             @ScheduleVal, 
             @NextRunDate, 
             @JobDisabled, 
             @StepName, 
             @StepDisabled, 
             @StepSQL, 
             @RunIdReq, 
             @AzureOK;
        SET @Jobname = 'JOB_UTIL_TrackSessionWaitStats';
        SET @JobDisabled = 'N';
        SET @StepName = 'Step01';
        SET @StepDisabled = 'N';
        SET @StepSQL = 'sp_UTIL_DFS_WaitStats @RunID 30';
        SET @RunIdReq = 'N';
        SET @AzureOK = 'Y';
        SET @ScheduleUnit = 'min';
        SET @ScheduleVal = 10;
        SET @LastRunDate = NULL;
        SET @NextRunDate = GETDATE();
        EXEC UTIL_ActiveJob 
             @JobName, 
             @ScheduleUnit, 
             @ScheduleVal, 
             @NextRunDate, 
             @JobDisabled, 
             @StepName, 
             @StepDisabled, 
             @StepSQL, 
             @RunIdReq, 
             @AzureOK;
        SET @Jobname = 'JOB_UTIL_TxMonitorTableStats';
        SET @JobDisabled = 'N';
        SET @StepName = 'Step01';
        SET @StepDisabled = 'N';
        SET @StepSQL = 'sp_UTIL_TxMonitorTableStats';
        SET @RunIdReq = 'Y';
        SET @AzureOK = 'Y';
        EXEC UTIL_ActiveJob 
             @JobName, 
             @ScheduleUnit, 
             @ScheduleVal, 
             @NextRunDate, 
             @JobDisabled, 
             @StepName, 
             @StepDisabled, 
             @StepSQL, 
             @RunIdReq, 
             @AzureOK;
        SET @Jobname = 'UTIL_TxMonitorIDX';
        SET @JobDisabled = 'N';
        SET @StepName = 'Step01';
        SET @StepDisabled = 'N';
        SET @StepSQL = 'sp_UTIL_TxMonitorIDX';
        SET @RunIdReq = 'Y';
        SET @AzureOK = 'Y';
        EXEC UTIL_ActiveJob 
             @JobName, 
             @ScheduleUnit, 
             @ScheduleVal, 
             @NextRunDate, 
             @JobDisabled, 
             @StepName, 
             @StepDisabled, 
             @StepSQL, 
             @RunIdReq, 
             @AzureOK;
END;
EXEC UTIL_ActiveJobSchedule;
GO
IF NOT EXISTS
(
    SELECT 1
    FROM sys.tables
    WHERE name = 'ActiveJobStep'
)
    BEGIN
        PRINT '*********** CREATING table ActiveJobStep ***********';
        CREATE TABLE ActiveJobStep
        ([StepName] NVARCHAR(150) NOT NULL, 
         [StepSQL]  NVARCHAR(MAX) NOT NULL, 
         [disabled] CHAR(1) DEFAULT 'N', 
         [RunIdReq] CHAR(1) DEFAULT 'N', 
         [JOBUID]   UNIQUEIDENTIFIER NOT NULL, 
         AzureOK    CHAR(1) DEFAULT 'Y', 
         RowNbr     INT IDENTITY(1, 1) NOT NULL
        );
        CREATE UNIQUE INDEX pkActiveJobStep
        ON ActiveJobStep
        ([JOBUID], [StepName]
        );
END;
GO
IF NOT EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.columns
    WHERE table_name = 'ActiveServers'
          AND COLUMN_NAME = 'Enable'
)
    BEGIN
        ALTER TABLE ActiveServers
        ADD [Enable] BIT NOT NULL
                         DEFAULT 1;
        UPDATE ActiveServers
          SET 
              [Enable] = 1;
END; 
GO

/*
after creating, execute D:\dev\SQL\DFINAnalytics\UTIL_ActiveDatabases.sql

select * from viewAwaitingJobs where SvrName like 'DFIN%'

select SvrName, DbName, JobName, StepName, count(*) as CNT
from viewAwaitingJobs
group by SvrName, DbName, JobName, StepName

*/

IF EXISTS
(
    SELECT 1
    FROM sys.views
    WHERE name = 'viewActiveJobExecutions'
)
    BEGIN
        DROP VIEW viewActiveJobExecutions;
END;
GO
CREATE VIEW viewActiveJobExecutions
AS
     SELECT DISTINCT 
            SvrName, 
            DBName, 
            JobName, 
            StepName, 
            MAX(NextRunDate) AS NextRunDate
     FROM [dbo].[ActiveJobExecutions]
     GROUP BY SvrName, 
              DBName, 
              JobName, 
              StepName;
GO
IF EXISTS
(
    SELECT 1
    FROM sys.views
    WHERE name = 'viewAwaitingJobs'
)
    BEGIN
        DROP VIEW viewAwaitingJobs;
END;
GO

if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = 'ActiveJob' and column_name = 'ExecutionOrder')
	alter table ActiveJob add ExecutionOrder int default 999;

go
CREATE VIEW viewAwaitingJobs
AS

/*
select count(*) from [dbo].[ActiveJob] AS AJ
select count(*) from [dbo].[ActiveJobStep] AS AJS
select count(*) from ActiveJobSchedule AS SCH
select count(*) from [dbo].[ActiveServers] AS SVR
select * from viewAwaitingJobs
*/

     SELECT DISTINCT 
            SVR.GroupName, 
            SVR.SvrName, 
            SVR.DBName, 
            AJ.[JobName], 
            SVR.UserID, 
            SVR.pwd, 
            SVR.isAzure, 
            SVR.UID AS DBUID, 
            AJ.[UID] AS JobUID, 
            AJ.[ScheduleUnit], 
            AJ.[ScheduleVal], 
            AJ.[LastRunDate], 
            --ISNULL(AJE.[NextRunDate], GETDATE() - 1) AS NextRunDate, 
			SCH.NextRunDate,
            AJS.[StepName], 
            AJS.ExecutionOrder, 
            AJS.[StepSQL], 
            AJS.[RunIdReq], 
            AJS.[AzureOK],
			AJ.ExecutionOrder as JobExecutionOrder
     FROM [dbo].[ActiveJob] AS AJ
               JOIN [dbo].[ActiveJobStep] AS AJS
					ON AJ.JobName = AJS.JobName
					AND AJS.[disabled] = 'N'
               JOIN ActiveJobSchedule AS SCH
				ON SCH.JobName = AJ.JobName
               JOIN [dbo].[ActiveServers] AS SVR
					ON SVR.SvrName = SCH.SvrName
					AND SVR.[Enable] = 1
               --LEFT OUTER JOIN viewActiveJobExecutions AS AJE
               --ON AJE.JobName = SCH.JobName
               --   AND AJE.SvrName = SCH.SvrName
               --   AND AJE.StepName = AJS.StepName
     WHERE AJ.[disabled] = 'N'
           AND SCH.[NextRunDate] <= GETDATE()
           --OR AJE.[NextRunDate] IS NULL;
GO
IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'UTIL_getActiveDatabases'
)
    BEGIN
        DROP PROCEDURE UTIL_getActiveDatabases;
END;
GO

/*
SELECT *
FROM [ActiveServers];
exec UTIL_getActiveDatabases 'dfintest'
*/

CREATE PROCEDURE UTIL_getActiveDatabases(@TgtGroup NVARCHAR(50))
AS
    BEGIN
        IF
           (@TgtGroup != '*'
           )
            BEGIN
                SELECT SvrName, 
                       DBName, 
                       ISNULL(UserID, 'NA') AS UserID, 
                       ISNULL(pwd, 'NA') AS pwd, 
                       isAzure, 
                       [UID]
                FROM [dbo].[ActiveServers]
                WHERE [Enable] = 1
                      AND GroupName = @TgtGroup;
        END;
            ELSE
            BEGIN
                SELECT SvrName, 
                       DBName, 
                       ISNULL(UserID, 'NA') AS UserID, 
                       ISNULL(pwd, 'NA') AS pwd, 
                       isAzure, 
                       [UID]
                FROM [dbo].[ActiveServers]
                WHERE [Enable] = 1;
        END;
    END;
GO
GO
IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'UTIL_getActiveSvrJobs'
)
    BEGIN
        DROP PROCEDURE UTIL_getActiveSvrJobs;
END;
GO

/*
exec UTIL_getActiveSvrJobs 
exec UTIL_getActiveSvrJobs 'dfintest'
*/

CREATE PROCEDURE UTIL_getActiveSvrJobs(@TgtGroup NVARCHAR(50) = NULL)
AS
    BEGIN
        IF(@TgtGroup IS NOT NULL)
            BEGIN
                SELECT [GroupName], 
                       [SvrName], 
                       [DBName], 
                       [JobName], 
                       [UserID], 
                       [pwd], 
                       [isAzure], 
                       [DBUID], 
                       [JobUID], 
                       [ScheduleUnit], 
                       [ScheduleVal], 
                       [LastRunDate], 
                       [NextRunDate], 
                       [StepName], 
                       [ExecutionOrder], 
                       [StepSQL], 
                       [RunIdReq], 
                       [AzureOK]
                FROM [dbo].[viewAwaitingJobs]
                WHERE GroupName = @TgtGroup
                ORDER BY SvrName, 
                         JobName, 
                         [ExecutionOrder];
        END;
            ELSE
            BEGIN
                SELECT [GroupName], 
                       [SvrName], 
                       [DBName], 
                       [JobName], 
                       [UserID], 
                       [pwd], 
                       [isAzure], 
                       [DBUID], 
                       [JobUID], 
                       [ScheduleUnit], 
                       [ScheduleVal], 
                       [LastRunDate], 
                       [NextRunDate], 
                       [StepName], 
                       [ExecutionOrder], 
                       [StepSQL], 
                       [RunIdReq], 
                       [AzureOK]
                FROM [dbo].[viewAwaitingJobs]
                ORDER BY SvrName, 
                         JobName, 
                         [ExecutionOrder];
        END;
    END;
GO
IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'UTIL_getActiveSvrJobsDelimited'
)
    BEGIN
        DROP PROCEDURE UTIL_getActiveSvrJobsDelimited;
END;
GO

/*
exec UTIL_getActiveSvrJobsDelimited 
*/

CREATE PROCEDURE UTIL_getActiveSvrJobsDelimited(@TgtGroup NVARCHAR(50) = NULL)
AS
    BEGIN
        DECLARE @tblID INT= 0;
        IF(@TgtGroup IS NOT NULL)
            BEGIN
                SET @tblID = 1;
                SELECT DISTINCT 
                       [GroupName], 
                       [SvrName], 
                       [DBName], 
                       [JobName], 
                       [UserID], 
                       [pwd], 
                       [isAzure], 
                       DBUID, 
                       [JobUID], 
                       [ScheduleUnit], 
                       [ScheduleVal], 
                       [LastRunDate], 
                       [NextRunDate], 
                       [StepName], 
                       [StepSQL], 
                       [RunIdReq], 
                       [AzureOK], 
                       ExecutionOrder
                INTO #TempJobs1
                FROM [dbo].[viewAwaitingJobs]
                WHERE GroupName = @TgtGroup
                GROUP BY [GroupName], 
                         [SvrName], 
                         [DBName], 
                         [JobName], 
                         [UserID], 
                         [pwd], 
                         [isAzure], 
                         DBUID, 
                         [JobUID], 
                         [ScheduleUnit], 
                         [ScheduleVal], 
                         [LastRunDate], 
                         [NextRunDate], 
                         [StepName], 
                         [StepSQL], 
                         [RunIdReq], 
                         [AzureOK], 
                         ExecutionOrder;
        END;
            ELSE
            BEGIN
                SET @tblID = 2;
                SELECT DISTINCT 
                       [GroupName], 
                       [SvrName], 
                       [DBName], 
                       [JobName], 
                       [UserID], 
                       [pwd], 
                       [isAzure], 
                       DBUID, 
                       [JobUID], 
                       [ScheduleUnit], 
                       [ScheduleVal], 
                       [LastRunDate], 
                       [NextRunDate], 
                       [StepName], 
                       [StepSQL], 
                       [RunIdReq], 
                       [AzureOK], 
                       ExecutionOrder
                INTO #TempJobs2
                FROM [dbo].[viewAwaitingJobs]
                GROUP BY [GroupName], 
                         [SvrName], 
                         [DBName], 
                         [JobName], 
                         [UserID], 
                         [pwd], 
                         [isAzure], 
                         DBUID, 
                         [JobUID], 
                         [ScheduleUnit], 
                         [ScheduleVal], 
                         [LastRunDate], 
                         [NextRunDate], 
                         [StepName], 
                         [StepSQL], 
                         [RunIdReq], 
                         [AzureOK], 
                         ExecutionOrder
                ORDER BY JobName, 
                         SvrName;
        END;
        IF
           (@tblID = 1
           )
            BEGIN
                SELECT [GroupName] + '|' + [SvrName] + '|' + [DBName] + '|' + [JobName] + '|' + [UserID] + '|' + [pwd] + '|' + [isAzure] + '|' + CAST(DBUID AS NVARCHAR(60)) + '|' + CAST([JobUID] AS NVARCHAR(60)) + '|' + [ScheduleUnit] + '|' + CAST([ScheduleVal] AS NVARCHAR(60)) + '|' + CAST([LastRunDate] AS NVARCHAR(60)) + '|' + CAST([NextRunDate] AS NVARCHAR(60)) + '|' + [StepName] + '|' + [StepSQL] + '|' + [RunIdReq] + '|' + [AzureOK] + '|' + CAST([ExecutionOrder] AS NVARCHAR(60)) +';'
                FROM #TempJobs1;
        END;
        IF
           (@tblID = 2
           )
            BEGIN
                SELECT [GroupName] + '|' + [SvrName] + '|' + [DBName] + '|' + [JobName] + '|' + [UserID] + '|' + [pwd] + '|' + [isAzure] + '|' + CAST(DBUID AS NVARCHAR(60)) + '|' + CAST([JobUID] AS NVARCHAR(60)) + '|' + [ScheduleUnit] + '|' + CAST([ScheduleVal] AS NVARCHAR(60)) + '|' + CAST([LastRunDate] AS NVARCHAR(60)) + '|' + CAST([NextRunDate] AS NVARCHAR(60)) + '|' + [StepName] + '|' + [StepSQL] + '|' + [RunIdReq] + '|' + [AzureOK] + '|' + CAST([ExecutionOrder] AS NVARCHAR(60)) +';'
                FROM #TempJobs2;
        END;
    END;
GO

IF EXISTS
(
    SELECT *
    FROM sys.objects
    WHERE object_id = OBJECT_ID(N'CalcNextRunDate')
          AND type IN(N'FN', N'IF', N'TF', N'FS', N'FT')
)
    BEGIN
        DROP FUNCTION CalcNextRunDate;
END;
GO

/*
declare @nextRunDate as datetime = null;
set @nextRunDate = (SELECT dbo.CalcNextRunDate('day',3));
print @nextRunDate ;
*/

CREATE FUNCTION dbo.CalcNextRunDate
(@Unit NVARCHAR(50), 
 @Val  INT
)
RETURNS DATETIME
WITH EXECUTE AS CALLER
AS
     BEGIN
         DECLARE @NextRunDate DATETIME= NULL;
         DECLARE @now DATETIME= GETDATE();
         DECLARE @ExtVal INT= 0;
         IF(@unit = 'hr'
            OR @unit = 'hour')
             BEGIN
                 SET @NextRunDate =
                 (
                     SELECT DATEADD(hour, @Val, @now) AS DateAdd
                 );
                 RETURN @NextRunDate;
         END;
         IF(@unit = 'min'
            OR @unit = 'minute')
             BEGIN
                 SET @NextRunDate =
                 (
                     SELECT DATEADD(minute, @Val, @now) AS DateAdd
                 );
                 RETURN @NextRunDate;
         END;
         IF(@unit = 'sec'
            OR @unit = 'second')
             BEGIN
                 SET @NextRunDate =
                 (
                     SELECT DATEADD(second, @Val, @now) AS DateAdd
                 );
                 RETURN @NextRunDate;
         END;
         IF
            (@unit = 'day'
            )
             BEGIN
                 SET @NextRunDate =
                 (
                     SELECT DATEADD(day, @Val, @now) AS DateAdd
                 );
                 RETURN @NextRunDate;
         END;
         IF
            (@unit = 'week'
            )
             BEGIN
                 SET @NextRunDate =
                 (
                     SELECT DATEADD(week, @Val, @now) AS DateAdd
                 );
                 RETURN @NextRunDate;
         END;
         IF
            (@unit = 'month'
            )
             BEGIN
                 SET @NextRunDate =
                 (
                     SELECT DATEADD(month, @Val, @now) AS DateAdd
                 );
                 RETURN @NextRunDate;
         END;
         IF
            (@unit = 'quarter'
            )
             BEGIN
                 SET @NextRunDate =
                 (
                     SELECT DATEADD(quarter, @Val, @now) AS DateAdd
                 );
                 RETURN @NextRunDate;
         END;
         RETURN GETDATE() + 1;
     END;  
GO

/*
select * from ActiveJobStep where StepSql like '%sp_UTIL_GetIndexStats%' 

update ActiveJobStep set StepSql = StepSql + ' @RunID'  where StepSql = 'sp_UTIL_GetIndexStats' 
@RunID

*/

GO
IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'sp_UTIL_GetIndexStats'
)
    DROP PROCEDURE [dbo].[sp_UTIL_GetIndexStats];
GO
CREATE PROCEDURE [dbo].[sp_UTIL_GetIndexStats]
(@RunID        BIGINT, 
 @MaxWaitMS    INT    = 30, 
 @MaxWaitCount INT    = 2
)
AS
    BEGIN

/*declare @RunID     BIGINT = -50 ;
		declare @MaxWaitMS INT = 0;
		declare @MaxWaitCount INT = 0 ;*/

        INSERT INTO [dbo].[DFS_IndexStats]
        ( [SvrName], 
          [DB], 
          [Obj], 
          [IdxName], 
          [range_scan_count], 
          [singleton_lookup_count], 
          [row_lock_count], 
          [page_lock_count], 
          [TotNo_Of_Locks], 
          [row_lock_wait_count], 
          [page_lock_wait_count], 
          [TotNo_Of_Blocks], 
          [row_lock_wait_in_ms], 
          [page_lock_wait_in_ms], 
          [TotBlock_Wait_TimeMS], 
          [index_id], 
          [CreateDate], 
          [SSVER], 
          RunID, 
          [UID]
        ) 
               SELECT @@ServerName AS SvrName, 
                      DB_NAME() AS DB, 
                      OBJECT_NAME(IOS.object_id) AS Obj, 
                      i.Name AS IdxName, 
                      range_scan_count, 
                      singleton_lookup_count, 
                      row_lock_count, 
                      page_lock_count, 
                      row_lock_count + page_lock_count AS TotNo_Of_Locks, 
                      row_lock_wait_count, 
                      page_lock_wait_count, 
                      row_lock_wait_count + page_lock_wait_count AS TotNo_Of_Blocks, 
                      row_lock_wait_in_ms, 
                      page_lock_wait_in_ms, 
                      row_lock_wait_in_ms + page_lock_wait_in_ms AS TotBlock_Wait_TimeMS, 
                      IOS.index_id, 
                      GETDATE() AS CreateDate, 
                      @@version AS SSVER, 
                      @RunID AS RunID, 
                      NEWID() AS [UID]
               FROM sys.dm_db_index_operational_stats(NULL, NULL, NULL, NULL) IOS
                         JOIN sys.indexes I
                         ON I.index_id = IOS.index_id
               WHERE DB_NAME() NOT IN('master', 'model', 'msdb', 'tempdb', 'DBA')
               AND OBJECT_NAME(IOS.object_id) IS NOT NULL
               AND (row_lock_wait_count >= 0
                    OR page_lock_wait_count >= 0)
               AND (page_lock_wait_in_ms >= @MaxWaitMS
                    OR row_lock_wait_in_ms >= @MaxWaitMS);
    END;
GO
UPDATE ActiveJobStep
  SET 
      StepSql = StepSql + ' @RunID'
WHERE StepSql = 'sp_UTIL_GetIndexStats';
GO

/****************** PROCESSING FILE *************************************/

GO  
PRINT 'ID# 29'  
print 'D:\dev\SQL\DFINAnalytics\UTIL_ActiveJobs.sql' 



GO
print '***********************************************************************************'
print 'This file replaced by D:\dev\SQL\DFINAnalytics\UTIL_getActiveDatabases.sql '
print '***********************************************************************************'
go

DECLARE @InitActiveJobs int= 1;

IF(@InitActiveJobs = 1 and db_name() = 'DFINAnalytics')
BEGIN
	delete from ActiveJobStep;

	DECLARE @JobName nvarchar(150), @JobDisabled char(1), @StepName nvarchar(150), @StepDisabled char(1), @StepSQL nvarchar(150), @RunIdReq char(1), @AzureOK char(1);
	DECLARE @ScheduleUnit nvarchar(25), @ScheduleVal int, @LastRunDate datetime, @NextRunDate datetime;
	SET @Jobname = 'JOB_CaptureWorstPerfQuery';
	SET @JobDisabled = 'N';
	SET @StepName = 'Step01';
	SET @StepDisabled = 'N';
	SET @StepSQL = 'sp_UTIL_MSTR_BoundQry2000';
	SET @RunIdReq = 'N';
	SET @AzureOK = 'Y';
	SET @ScheduleUnit = 'min';
	SET @ScheduleVal = 15;
	SET @LastRunDate = NULL;
	SET @NextRunDate = GETDATE();
	EXEC UTIL_ActiveJob @JobName, @ScheduleUnit, @ScheduleVal, @NextRunDate, @JobDisabled, @StepName, @StepDisabled, @StepSQL, @RunIdReq, @AzureOK;
	SET @Jobname = 'JOB_DFS_BoundQry_ProcessAllTables';
	SET @JobDisabled = 'N';
	SET @StepName = 'Step01';
	SET @StepDisabled = 'N';
	SET @StepSQL = 'UTIL_UpdateQryPlansAndText ''DFS_IO_BoundQry2000''';
	SET @RunIdReq = 'N';
	SET @AzureOK = 'Y';
	SET @ScheduleUnit = 'min';
	SET @ScheduleVal = 15;
	SET @LastRunDate = NULL;
	SET @NextRunDate = GETDATE();
	EXEC UTIL_ActiveJob @JobName, @ScheduleUnit, @ScheduleVal, @NextRunDate, @JobDisabled, @StepName, @StepDisabled, @StepSQL, @RunIdReq, @AzureOK;
	SET @Jobname = 'JOB_DFS_BoundQry_ProcessAllTables';
	SET @JobDisabled = 'N';
	SET @StepName = 'Step02';
	SET @StepDisabled = 'N';
	SET @StepSQL = 'UTIL_UpdateQryPlansAndText ''DFS_CPU_BoundQry2000''';
	SET @RunIdReq = 'N';
	SET @AzureOK = 'Y';
	SET @ScheduleUnit = 'min';
	SET @ScheduleVal = 30;
	SET @LastRunDate = NULL;
	SET @NextRunDate = GETDATE();
	EXEC UTIL_ActiveJob @JobName, @ScheduleUnit, @ScheduleVal, @NextRunDate, @JobDisabled, @StepName, @StepDisabled, @StepSQL, @RunIdReq, @AzureOK;
	SET @Jobname = 'JOB_DFS_BoundQry_ProcessAllTables';
	SET @JobDisabled = 'N';
	SET @StepName = 'Step03';
	SET @StepDisabled = 'N';
	SET @StepSQL = 'UTIL_UpdateQryPlansAndText ''DFS_IO_BoundQry''';
	SET @RunIdReq = 'N';
	SET @AzureOK = 'Y';
	SET @ScheduleUnit = 'min';
	SET @ScheduleVal = 30;
	SET @LastRunDate = NULL;
	SET @NextRunDate = GETDATE();
	EXEC UTIL_ActiveJob @JobName, @ScheduleUnit, @ScheduleVal, @NextRunDate, @JobDisabled, @StepName, @StepDisabled, @StepSQL, @RunIdReq, @AzureOK;
	SET @Jobname = 'JOB_DFS_BoundQry_ProcessAllTables';
	SET @JobDisabled = 'N';
	SET @StepName = 'Step04';
	SET @StepDisabled = 'N';
	SET @StepSQL = 'UTIL_UpdateQryPlansAndText ''DFS_CPU_BoundQry''';
	SET @RunIdReq = 'N';
	SET @AzureOK = 'Y';
	SET @ScheduleUnit = 'min';
	SET @ScheduleVal = 30;
	SET @LastRunDate = NULL;
	SET @NextRunDate = GETDATE();
	EXEC UTIL_ActiveJob @JobName, @ScheduleUnit, @ScheduleVal, @NextRunDate, @JobDisabled, @StepName, @StepDisabled, @StepSQL, @RunIdReq, @AzureOK;
	SET @Jobname = 'JOB_DFS_BoundQry_ProcessAllTables';
	SET @JobDisabled = 'N';
	SET @StepName = 'Step05';
	SET @StepDisabled = 'N';
	SET @StepSQL = 'DFS_CPU_BoundQry2000_ProcessTable';
	SET @RunIdReq = 'N';
	SET @AzureOK = 'Y';
	SET @ScheduleUnit = 'min';
	SET @ScheduleVal = 30;
	SET @LastRunDate = NULL;
	SET @NextRunDate = GETDATE();
	EXEC UTIL_ActiveJob @JobName, @ScheduleUnit, @ScheduleVal, @NextRunDate, @JobDisabled, @StepName, @StepDisabled, @StepSQL, @RunIdReq, @AzureOK;
	SET @Jobname = 'JOB_DFS_BoundQry_ProcessAllTables';
	SET @JobDisabled = 'N';
	SET @StepName = 'Step06';
	SET @StepDisabled = 'N';
	SET @StepSQL = 'DFS_IO_BoundQry2000_ProcessTable';
	SET @RunIdReq = 'N';
	SET @AzureOK = 'Y';
	SET @ScheduleUnit = 'min';
	SET @ScheduleVal = 30;
	SET @LastRunDate = NULL;
	SET @NextRunDate = GETDATE();
	EXEC UTIL_ActiveJob @JobName, @ScheduleUnit, @ScheduleVal, @NextRunDate, @JobDisabled, @StepName, @StepDisabled, @StepSQL, @RunIdReq, @AzureOK;
	SET @Jobname = 'JOB_DFS_BoundQry_ProcessAllTables';
	SET @JobDisabled = 'N';
	SET @StepName = 'Step07';
	SET @StepDisabled = 'N';
	SET @StepSQL = 'UTIL_DFS_CPU_BoundQry';
	SET @RunIdReq = 'N';
	SET @AzureOK = 'Y';
	SET @ScheduleUnit = 'min';
	SET @ScheduleVal = 15;
	SET @LastRunDate = NULL;
	SET @NextRunDate = GETDATE();
	EXEC UTIL_ActiveJob @JobName, @ScheduleUnit, @ScheduleVal, @NextRunDate, @JobDisabled, @StepName, @StepDisabled, @StepSQL, @RunIdReq, @AzureOK;
	SET @Jobname = 'JOB_DFS_BoundQry_ProcessAllTables';
	SET @JobDisabled = 'N';
	SET @StepName = 'Step08';
	SET @StepDisabled = 'N';
	SET @StepSQL = 'UTIL_IO_BoundQry';
	SET @RunIdReq = 'N';
	SET @AzureOK = 'Y';
	SET @ScheduleUnit = 'min';
	SET @ScheduleVal = 30;
	SET @LastRunDate = NULL;
	SET @NextRunDate = GETDATE();
	EXEC UTIL_ActiveJob @JobName, @ScheduleUnit, @ScheduleVal, @NextRunDate, @JobDisabled, @StepName, @StepDisabled, @StepSQL, @RunIdReq, @AzureOK;
	SET @Jobname = 'JOB_DFS_CleanDFSTables';
	SET @JobDisabled = 'N';
	SET @StepName = 'Step01';
	SET @StepDisabled = 'N';
	SET @StepSQL = 'UTIL_CleanDFSTables';
	SET @RunIdReq = 'N';
	SET @AzureOK = 'Y';
	SET @ScheduleUnit = 'hour';
	SET @ScheduleVal = 12;
	SET @LastRunDate = NULL;
	SET @NextRunDate = GETDATE();
	EXEC UTIL_ActiveJob @JobName, @ScheduleUnit, @ScheduleVal, @NextRunDate, @JobDisabled, @StepName, @StepDisabled, @StepSQL, @RunIdReq, @AzureOK;
	SET @Jobname = 'JOB_DFS_GetAllTableSizesAndRowCnt';
	SET @JobDisabled = 'N';
	SET @StepName = 'Step01';
	SET @StepDisabled = 'N';
	SET @StepSQL = 'DFS_GetAllTableSizesAndRowCnt';
	SET @RunIdReq = 'N';
	SET @AzureOK = 'Y';
	SET @ScheduleUnit = 'day';
	SET @ScheduleVal = 1;
	SET @LastRunDate = NULL;
	SET @NextRunDate = GETDATE();
	EXEC UTIL_ActiveJob @JobName, @ScheduleUnit, @ScheduleVal, @NextRunDate, @JobDisabled, @StepName, @StepDisabled, @StepSQL, @RunIdReq, @AzureOK;
	SET @Jobname = 'JOB_DFS_MonitorLocks';
	SET @JobDisabled = 'N';
	SET @StepName = 'Step01';
	SET @StepDisabled = 'N';
	SET @StepSQL = 'sp_DFS_MonitorLocks';
	SET @RunIdReq = 'N';
	SET @AzureOK = 'Y';
	SET @ScheduleUnit = 'min';
	SET @ScheduleVal = 5;
	SET @LastRunDate = NULL;
	SET @NextRunDate = GETDATE();
	EXEC UTIL_ActiveJob @JobName, @ScheduleUnit, @ScheduleVal, @NextRunDate, @JobDisabled, @StepName, @StepDisabled, @StepSQL, @RunIdReq, @AzureOK;
	SET @Jobname = 'JOB_JOB_UTIL_MonitorDeadlocks';
	SET @JobDisabled = 'N';
	SET @StepName = 'Step01';
	SET @StepDisabled = 'N';
	SET @StepSQL = 'sp_UTIL_DFS_DeadlockStats';
	SET @RunIdReq = 'Y';
	SET @AzureOK = 'Y';
	EXEC UTIL_ActiveJob @JobName, @ScheduleUnit, @ScheduleVal, @NextRunDate, @JobDisabled, @StepName, @StepDisabled, @StepSQL, @RunIdReq, @AzureOK;
	SET @Jobname = 'JOB_MonitorWorkload';
	SET @JobDisabled = 'N';
	SET @StepName = 'Step01';
	SET @StepDisabled = 'N';
	SET @StepSQL = 'UTIL_MonitorWorkload';
	SET @RunIdReq = 'N';
	SET @AzureOK = 'Y';
	SET @ScheduleUnit = 'min';
	SET @ScheduleVal = 10;
	SET @LastRunDate = NULL;
	SET @NextRunDate = GETDATE();
	EXEC UTIL_ActiveJob @JobName, @ScheduleUnit, @ScheduleVal, @NextRunDate, @JobDisabled, @StepName, @StepDisabled, @StepSQL, @RunIdReq, @AzureOK;
	SET @Jobname = 'JOB_UTIL_DbMon_IndexVolitity';
	SET @JobDisabled = 'N';
	SET @StepName = 'Step01';
	SET @StepDisabled = 'N';
	SET @StepSQL = 'sp_UTIL_TxMonitorTableIndexStats';
	SET @RunIdReq = 'Y';
	SET @AzureOK = 'Y';
	EXEC UTIL_ActiveJob @JobName, @ScheduleUnit, @ScheduleVal, @NextRunDate, @JobDisabled, @StepName, @StepDisabled, @StepSQL, @RunIdReq, @AzureOK;
	SET @Jobname = 'JOB_UTIL_DBSpace';
	SET @JobDisabled = 'N';
	SET @StepName = 'Step01';
	SET @StepDisabled = 'N';
	SET @StepSQL = 'UTIL_DBSpace';
	SET @RunIdReq = 'N';
	SET @AzureOK = 'Y';
	SET @ScheduleUnit = 'day';
	SET @ScheduleVal = 7;
	SET @LastRunDate = NULL;
	SET @NextRunDate = GETDATE();
	EXEC UTIL_ActiveJob @JobName, @ScheduleUnit, @ScheduleVal, @NextRunDate, @JobDisabled, @StepName, @StepDisabled, @StepSQL, @RunIdReq, @AzureOK;
	SET @Jobname = 'JOB_UTIL_DBTableSpace';
	SET @JobDisabled = 'N';
	SET @StepName = 'Step01';
	SET @StepDisabled = 'N';
	SET @StepSQL = 'UTIL_DBTableSpace';
	SET @RunIdReq = 'N';
	SET @AzureOK = 'Y';
	SET @ScheduleUnit = 'day';
	SET @ScheduleVal = 1;
	SET @LastRunDate = NULL;
	SET @NextRunDate = GETDATE();
	EXEC UTIL_ActiveJob @JobName, @ScheduleUnit, @ScheduleVal, @NextRunDate, @JobDisabled, @StepName, @StepDisabled, @StepSQL, @RunIdReq, @AzureOK;
	SET @Jobname = 'JOB_UTIL_DFS_DbSize';
	SET @JobDisabled = 'N';
	SET @StepName = 'Step01';
	SET @StepDisabled = 'N';
	SET @StepSQL = 'UTIL_DFS_DbFileSizing';
	SET @RunIdReq = 'N';
	SET @AzureOK = 'N';
	SET @ScheduleUnit = 'day';
	SET @ScheduleVal = 1;
	SET @LastRunDate = NULL;
	SET @NextRunDate = GETDATE();
	EXEC UTIL_ActiveJob @JobName, @ScheduleUnit, @ScheduleVal, @NextRunDate, @JobDisabled, @StepName, @StepDisabled, @StepSQL, @RunIdReq, @AzureOK;
	SET @Jobname = 'JOB_UTIL_GetIndexStats';
	SET @JobDisabled = 'N';
	SET @StepName = 'Step01';
	SET @StepDisabled = 'N';
	SET @StepSQL = 'sp_UTIL_GetIndexStats';
	SET @RunIdReq = 'Y';
	SET @AzureOK = 'Y';
	EXEC UTIL_ActiveJob @JobName, @ScheduleUnit, @ScheduleVal, @NextRunDate, @JobDisabled, @StepName, @StepDisabled, @StepSQL, @RunIdReq, @AzureOK;
	SET @Jobname = 'JOB_UTIL_MonitorDeadlocks';
	SET @JobDisabled = 'N';
	SET @StepName = 'Step01';
	SET @StepDisabled = 'N';
	SET @StepSQL = 'sp_UTIL_DFS_DeadlockStats ';
	SET @RunIdReq = 'Y';
	SET @AzureOK = 'Y';
	EXEC UTIL_ActiveJob @JobName, @ScheduleUnit, @ScheduleVal, @NextRunDate, @JobDisabled, @StepName, @StepDisabled, @StepSQL, @RunIdReq, @AzureOK;
	SET @Jobname = 'JOB_UTIL_MonitorMostCommonWaits';
	SET @JobDisabled = 'N';
	SET @StepName = 'Step01';
	SET @StepDisabled = 'N';
	SET @StepSQL = 'UTIL_MonitorMostCommonWaits';
	SET @RunIdReq = 'N';
	SET @AzureOK = 'Y';
	SET @ScheduleUnit = 'min';
	SET @ScheduleVal = 15;
	SET @LastRunDate = NULL;
	SET @NextRunDate = GETDATE();
	EXEC UTIL_ActiveJob @JobName, @ScheduleUnit, @ScheduleVal, @NextRunDate, @JobDisabled, @StepName, @StepDisabled, @StepSQL, @RunIdReq, @AzureOK;
	SET @Jobname = 'JOB_UTIL_ParallelMonitor';
	SET @JobDisabled = 'N';
	SET @StepName = 'Step01';
	SET @StepDisabled = 'N';
	SET @StepSQL = 'UTIL_ParallelMonitor';
	SET @RunIdReq = 'Y';
	SET @AzureOK = 'Y';
	EXEC UTIL_ActiveJob @JobName, @ScheduleUnit, @ScheduleVal, @NextRunDate, @JobDisabled, @StepName, @StepDisabled, @StepSQL, @RunIdReq, @AzureOK;
	SET @Jobname = 'JOB_UTIL_QryPlanStats';
	SET @JobDisabled = 'N';
	SET @StepName = 'Step01';
	SET @StepDisabled = 'N';
	SET @StepSQL = 'UTIL_QryPlanStats';
	SET @RunIdReq = 'N';
	SET @AzureOK = 'Y';
	SET @ScheduleUnit = 'min';
	SET @ScheduleVal = 30;
	SET @LastRunDate = NULL;
	SET @NextRunDate = GETDATE();
	EXEC UTIL_ActiveJob @JobName, @ScheduleUnit, @ScheduleVal, @NextRunDate, @JobDisabled, @StepName, @StepDisabled, @StepSQL, @RunIdReq, @AzureOK;
	SET @Jobname = 'JOB_UTIL_ReorgFragmentedIndexes';
	SET @JobDisabled = 'N';
	SET @StepName = 'Step01';
	SET @StepDisabled = 'N';
	SET @StepSQL = 'sp_UTIL_ReorgFragmentedIndexes';
	SET @RunIdReq = 'N';
	SET @AzureOK = 'Y';
	SET @ScheduleUnit = 'day';
	SET @ScheduleVal = 7;
	SET @LastRunDate = NULL;
	SET @NextRunDate = GETDATE();
	EXEC UTIL_ActiveJob @JobName, @ScheduleUnit, @ScheduleVal, @NextRunDate, @JobDisabled, @StepName, @StepDisabled, @StepSQL, @RunIdReq, @AzureOK;
	SET @Jobname = 'JOB_UTIL_TempDbMonitor';
	SET @JobDisabled = 'N';
	SET @StepName = 'Step01';
	SET @StepDisabled = 'N';
	SET @StepSQL = 'UTIL_TempDbMonitor';
	SET @RunIdReq = 'Y';
	SET @AzureOK = 'N';
	EXEC UTIL_ActiveJob @JobName, @ScheduleUnit, @ScheduleVal, @NextRunDate, @JobDisabled, @StepName, @StepDisabled, @StepSQL, @RunIdReq, @AzureOK;
	SET @Jobname = 'JOB_UTIL_TrackSessionWaitStats';
	SET @JobDisabled = 'N';
	SET @StepName = 'Step01';
	SET @StepDisabled = 'N';
	SET @StepSQL = 'sp_UTIL_DFS_WaitStats @RunID , 30';
	SET @RunIdReq = 'N';
	SET @AzureOK = 'Y';
	SET @ScheduleUnit = 'min';
	SET @ScheduleVal = 10;
	SET @LastRunDate = NULL;
	SET @NextRunDate = GETDATE();
	EXEC UTIL_ActiveJob @JobName, @ScheduleUnit, @ScheduleVal, @NextRunDate, @JobDisabled, @StepName, @StepDisabled, @StepSQL, @RunIdReq, @AzureOK;
	SET @Jobname = 'JOB_UTIL_TxMonitorTableStats';
	SET @JobDisabled = 'N';
	SET @StepName = 'Step01';
	SET @StepDisabled = 'N';
	SET @StepSQL = 'sp_UTIL_TxMonitorTableStats';
	SET @RunIdReq = 'Y';
	SET @AzureOK = 'Y';
	EXEC UTIL_ActiveJob @JobName, @ScheduleUnit, @ScheduleVal, @NextRunDate, @JobDisabled, @StepName, @StepDisabled, @StepSQL, @RunIdReq, @AzureOK;
	SET @Jobname = 'UTIL_TxMonitorIDX';
	SET @JobDisabled = 'N';
	SET @StepName = 'Step01';
	SET @StepDisabled = 'N';
	SET @StepSQL = 'sp_UTIL_TxMonitorIDX';
	SET @RunIdReq = 'Y';
	SET @AzureOK = 'Y';
	EXEC UTIL_ActiveJob @JobName, @ScheduleUnit, @ScheduleVal, @NextRunDate, @JobDisabled, @StepName, @StepDisabled, @StepSQL, @RunIdReq, @AzureOK;
END;

EXEC UTIL_ActiveJobSchedule;

/****************** PROCESSING FILE *************************************/

GO  
PRINT 'ID# 30'  
print 'D:\dev\SQL\DFINAnalytics\CREATE_DFS_DB2Skip.sql' 
--* USEDFINAnalytics;
go

IF NOT EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.tables
    WHERE TABLE_NAME = 'DFS_DB2Skip'
)
begin 
    CREATE TABLE dbo.[DFS_DB2Skip](DB NVARCHAR(100));
	create unique index PK_DFS_DB2Skip on DFS_DB2Skip (DB);
	insert into dbo.[DFS_DB2Skip] (DB) values ('master');
	insert into dbo.[DFS_DB2Skip] (DB) values ('DBA');
	insert into dbo.[DFS_DB2Skip] (DB) values ('model');
	insert into dbo.[DFS_DB2Skip] (DB) values ('msdb');
	insert into dbo.[DFS_DB2Skip] (DB) values ('tempdb');
end 


/****************** PROCESSING FILE *************************************/

GO  
PRINT 'ID# 31'  
print 'D:\dev\SQL\DFINAnalytics\UTIL_PowershellJobSchedule.sql' 

GO

/*
update DFS_PowershellJobSchedule set ExecutionOrder = RowNbr;
select * from DFS_PowershellJobSchedule order by RowNbr;
select distinct scheduleunit from DFS_PowershellJobSchedule;
*/

IF EXISTS
(
    SELECT 1
    FROM sys.tables
    WHERE name = 'DFS_PowershellJobSchedule'
)
    BEGIN
        DROP TABLE DFS_PowershellJobSchedule;
END;
GO
CREATE TABLE [dbo].[DFS_PowershellJobSchedule]
([Enabled]           INT NOT NULL
                         DEFAULT 1, 
 [FQN]               NVARCHAR(750) NOT NULL, 
 [psJobName]          NVARCHAR(75) NOT NULL, 
 [ScheduleUnit]      NVARCHAR(50) NOT NULL, 
 [ScheduleExecValue] INT NOT NULL, 
 [StartTime]         DATETIME NOT NULL, 
 [LastRunTime]       DATETIME NOT NULL, 
 [NextRunTime]       DATETIME NOT NULL, 
 [UID] [UNIQUEIDENTIFIER] NULL, 
 ExecutionOrder INT null,
 RunIdReq int null default 0,
 RowNbr              INT IDENTITY(1, 1) NOT NULL
)
ON [PRIMARY];
CREATE UNIQUE INDEX pkDFS_PowershellJobSchedule
ON DFS_PowershellJobSchedule
([UID], RunIdReq
);
CREATE UNIQUE INDEX uiDFS_PowershellJobSchedule
ON DFS_PowershellJobSchedule
([FQN],psJobName
);
GO

/*
year	yy, yyyy
quarter	qq, q
month	mm, m
dayofyear	dy, y
day	dd, d
week	wk, ww
weekday	dw, w
hour	hh
minute	mi, n
second	ss, s
millisecond	ms
microsecond	mcs
nanosecond	ns
*/

IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'UTIL_PowershellJobSchedule'
)
    BEGIN
        DROP PROCEDURE UTIL_PowershellJobSchedule;
END;
GO
CREATE PROCEDURE UTIL_PowershellJobSchedule(@psJobName NVARCHAR(100))
AS
    BEGIN
        IF
           (@psJobName = '*'
           )
            BEGIN
                UPDATE DFS_PowershellJobSchedule
                  SET 
                      NextRunTime = DATEADD(year, ScheduleExecValue, LastRunTime)
                WHERE ScheduleUnit = 'year';
                UPDATE DFS_PowershellJobSchedule
                  SET 
                      NextRunTime = DATEADD(quarter, ScheduleExecValue, LastRunTime)
                WHERE ScheduleUnit = 'quarter';
                UPDATE DFS_PowershellJobSchedule
                  SET 
                      NextRunTime = DATEADD(dayofyear, ScheduleExecValue, LastRunTime)
                WHERE ScheduleUnit = 'dayofyear';
                UPDATE DFS_PowershellJobSchedule
                  SET 
                      NextRunTime = DATEADD(day, ScheduleExecValue, LastRunTime)
                WHERE ScheduleUnit = 'day';
                UPDATE DFS_PowershellJobSchedule
                  SET 
                      NextRunTime = DATEADD(WEEK, ScheduleExecValue, LastRunTime)
                WHERE ScheduleUnit = 'week';
                UPDATE DFS_PowershellJobSchedule
                  SET 
                      NextRunTime = DATEADD(minute, ScheduleExecValue, LastRunTime)
                WHERE ScheduleUnit = 'minute';
                UPDATE DFS_PowershellJobSchedule
                  SET 
                      NextRunTime = DATEADD(second, ScheduleExecValue, LastRunTime)
                WHERE ScheduleUnit = 'second';
                UPDATE DFS_PowershellJobSchedule
                  SET 
                      NextRunTime = DATEADD(millisecond, ScheduleExecValue, LastRunTime)
                WHERE ScheduleUnit = 'millisecond';
        END;
    END;
GO
IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'UTIL_PowershellJobScheduleLastRunTime'
)
    BEGIN
        DROP PROCEDURE UTIL_PowershellJobScheduleLastRunTime;
END;
GO
CREATE PROCEDURE UTIL_PowershellJobScheduleLastRunTime(@psJobName NVARCHAR(100))
AS
    BEGIN
        UPDATE DFS_PowershellJobSchedule
          SET 
              LastRunTime = GETDATE()
        WHERE psJobName = @psJobName;
    END;
GO

/*
POPULATE TABLE
*/

DECLARE @path NVARCHAR(2000)= 'D:\dev\SQL\DFINAnalytics\PowerShell\JobsDFIN\';
PRINT @path;
DECLARE @fqn NVARCHAR(2000)= @path;
DECLARE @psJobName NVARCHAR(100)= '';
SET @psJobName = 'JOB_DFS_BoundQry_ProcessAllTables.ps1';
INSERT INTO [DFS_PowershellJobSchedule]
( [Enabled], 
  [FQN], 
  psJobName, 
  [ScheduleUnit], 
  [ScheduleExecValue], 
  [StartTime], 
  [LastRunTime], 
  [NextRunTime], 
  [UID], RunIdReq
) 
VALUES
(
       1
     , @fqn
     , @psJobName
     , 'minute'
     , 15
     , GETDATE()
     , GETDATE()
     , GETDATE()
     , NEWID(), 0
);
SET @psJobName = 'JOB_ UTIL_Monitor_TPS.ps1';
INSERT INTO [DFS_PowershellJobSchedule]
( [Enabled], 
  [FQN], 
  psJobName, 
  [ScheduleUnit], 
  [ScheduleExecValue], 
  [StartTime], 
  [LastRunTime], 
  [NextRunTime], 
  [UID], RunIdReq
) 
VALUES
(
       1
     , @fqn
     , @psJobName
     , 'minute'
     , 10
     , GETDATE()
     , GETDATE()
     , GETDATE()
     , NEWID(), 0
);
SET @psJobName = 'JOB_ UTIL_ReorgFragmentedIndexes.ps1';
INSERT INTO [DFS_PowershellJobSchedule]
( [Enabled], 
  [FQN], 
  psJobName, 
  [ScheduleUnit], 
  [ScheduleExecValue], 
  [StartTime], 
  [LastRunTime], 
  [NextRunTime], 
  [UID], RunIdReq
) 
VALUES
(
       1
     , @fqn
     , @psJobName
     , 'day'
     , 7
     , GETDATE()
     , GETDATE()
     , GETDATE()
     , NEWID(), 0
);
SET @psJobName = 'JOB_CaptureWorstPerfQuery.ps1';
INSERT INTO [DFS_PowershellJobSchedule]
( [Enabled], 
  [FQN], 
  psJobName, 
  [ScheduleUnit], 
  [ScheduleExecValue], 
  [StartTime], 
  [LastRunTime], 
  [NextRunTime], 
  [UID], RunIdReq
) 
VALUES
(
       1
     , @fqn
     , @psJobName
     , 'hour'
     , 1
     , GETDATE()
     , GETDATE()
     , GETDATE()
     , NEWID(), 0
);
SET @psJobName = 'JOB_DFS_CleanDFSTables.ps1';
INSERT INTO [DFS_PowershellJobSchedule]
( [Enabled], 
  [FQN], 
  psJobName, 
  [ScheduleUnit], 
  [ScheduleExecValue], 
  [StartTime], 
  [LastRunTime], 
  [NextRunTime], 
  [UID], RunIdReq
) 
VALUES
(
       1
     , @fqn
     , @psJobName
     , 'hour'
     , 3
     , GETDATE()
     , GETDATE()
     , GETDATE()
     , NEWID(), 0
);
SET @psJobName = 'JOB_DFS_GetAllTableSizesAndRowCnt.ps1';
INSERT INTO [DFS_PowershellJobSchedule]
( [Enabled], 
  [FQN], 
  psJobName, 
  [ScheduleUnit], 
  [ScheduleExecValue], 
  [StartTime], 
  [LastRunTime], 
  [NextRunTime], 
  [UID], RunIdReq
) 
VALUES
(
       1
     , @fqn
     , @psJobName
     , 'day'
     , 1
     , GETDATE()
     , GETDATE()
     , GETDATE()
     , NEWID(), 0
);
SET @psJobName = 'JOB_DFS_MonitorLocks.ps1';
INSERT INTO [DFS_PowershellJobSchedule]
( [Enabled], 
  [FQN], 
  psJobName, 
  [ScheduleUnit], 
  [ScheduleExecValue], 
  [StartTime], 
  [LastRunTime], 
  [NextRunTime], 
  [UID], RunIdReq
) 
VALUES
(
       1
     , @fqn
     , @psJobName
     , 'minute'
     , 10
     , GETDATE()
     , GETDATE()
     , GETDATE()
     , NEWID(), 0
);
SET @psJobName = 'JOB_JOB_UTIL_MonitorDeadlocks.ps1';
INSERT INTO [DFS_PowershellJobSchedule]
( [Enabled], 
  [FQN], 
  psJobName, 
  [ScheduleUnit], 
  [ScheduleExecValue], 
  [StartTime], 
  [LastRunTime], 
  [NextRunTime], 
  [UID], RunIdReq
) 
VALUES
(
       1
     , @fqn
     , @psJobName
     , 'minute'
     , 10
     , GETDATE()
     , GETDATE()
     , GETDATE()
     , NEWID(), 0
);
SET @psJobName = 'JOB_MonitorWorkload.ps1';
INSERT INTO [DFS_PowershellJobSchedule]
( [Enabled], 
  [FQN], 
  psJobName, 
  [ScheduleUnit], 
  [ScheduleExecValue], 
  [StartTime], 
  [LastRunTime], 
  [NextRunTime], 
  [UID], RunIdReq
) 
VALUES
(
       1
     , @fqn
     , @psJobName
     , 'minute'
     , 15
     , GETDATE()
     , GETDATE()
     , GETDATE()
     , NEWID(), 0
);
SET @psJobName = 'JOB_UTIL_DbMon_IndexVolitity.ps1';
INSERT INTO [DFS_PowershellJobSchedule]
( [Enabled], 
  [FQN], 
  psJobName, 
  [ScheduleUnit], 
  [ScheduleExecValue], 
  [StartTime], 
  [LastRunTime], 
  [NextRunTime], 
  [UID], RunIdReq
) 
VALUES
(
       1
     , @fqn
     , @psJobName
     , 'day'
     , 1
     , GETDATE()
     , GETDATE()
     , GETDATE()
     , NEWID(), 0
);
SET @psJobName = 'JOB_UTIL_DBSpace.ps1';
INSERT INTO [DFS_PowershellJobSchedule]
( [Enabled], 
  [FQN], 
  psJobName, 
  [ScheduleUnit], 
  [ScheduleExecValue], 
  [StartTime], 
  [LastRunTime], 
  [NextRunTime], 
  [UID], RunIdReq
) 
VALUES
(
       1
     , @fqn
     , @psJobName
     , 'day'
     , 1
     , GETDATE()
     , GETDATE()
     , GETDATE()
     , NEWID(), 0
);
SET @psJobName = 'JOB_UTIL_DBTableSpace.ps1';
INSERT INTO [DFS_PowershellJobSchedule]
( [Enabled], 
  [FQN], 
  psJobName, 
  [ScheduleUnit], 
  [ScheduleExecValue], 
  [StartTime], 
  [LastRunTime], 
  [NextRunTime], 
  [UID], RunIdReq
) 
VALUES
(
       1
     , @fqn
     , @psJobName
     , 'day'
     , 1
     , GETDATE()
     , GETDATE()
     , GETDATE()
     , NEWID(), 0
);
SET @psJobName = 'JOB_UTIL_DFS_DbSize.ps1';
INSERT INTO [DFS_PowershellJobSchedule]
( [Enabled], 
  [FQN], 
  psJobName, 
  [ScheduleUnit], 
  [ScheduleExecValue], 
  [StartTime], 
  [LastRunTime], 
  [NextRunTime], 
  [UID], RunIdReq
) 
VALUES
(
       1
     , @fqn
     , @psJobName
     , 'day'
     , 1
     , GETDATE()
     , GETDATE()
     , GETDATE()
     , NEWID(), 0
);
SET @psJobName = 'JOB_UTIL_GetIndexStats.ps1';
INSERT INTO [DFS_PowershellJobSchedule]
( [Enabled], 
  [FQN], 
  psJobName, 
  [ScheduleUnit], 
  [ScheduleExecValue], 
  [StartTime], 
  [LastRunTime], 
  [NextRunTime], 
  [UID], RunIdReq
) 
VALUES
(
       1
     , @fqn
     , @psJobName
     , 'day'
     , 1
     , GETDATE()
     , GETDATE()
     , GETDATE()
     , NEWID(), 0
);
SET @psJobName = 'JOB_UTIL_MonitorDeadlocks.ps1';
INSERT INTO [DFS_PowershellJobSchedule]
( [Enabled], 
  [FQN], 
  psJobName, 
  [ScheduleUnit], 
  [ScheduleExecValue], 
  [StartTime], 
  [LastRunTime], 
  [NextRunTime], 
  [UID], RunIdReq
) 
VALUES
(
       1
     , @fqn
     , @psJobName
     , 'minute'
     , 10
     , GETDATE()
     , GETDATE()
     , GETDATE()
     , NEWID(), 0
);
SET @psJobName = 'JOB_UTIL_MonitorMostCommonWaits.ps1';
INSERT INTO [DFS_PowershellJobSchedule]
( [Enabled], 
  [FQN], 
  psJobName, 
  [ScheduleUnit], 
  [ScheduleExecValue], 
  [StartTime], 
  [LastRunTime], 
  [NextRunTime], 
  [UID], RunIdReq
) 
VALUES
(
       1
     , @fqn
     , @psJobName
     , 'minute'
     , 30
     , GETDATE()
     , GETDATE()
     , GETDATE()
     , NEWID(), 0
);
SET @psJobName = 'JOB_UTIL_ParallelMonitor.ps1';
INSERT INTO [DFS_PowershellJobSchedule]
( [Enabled], 
  [FQN], 
  psJobName, 
  [ScheduleUnit], 
  [ScheduleExecValue], 
  [StartTime], 
  [LastRunTime], 
  [NextRunTime], 
  [UID], RunIdReq
) 
VALUES
(
       1
     , @fqn
     , @psJobName
     , 'minute'
     , 10
     , GETDATE()
     , GETDATE()
     , GETDATE()
     , NEWID(), 1
);
SET @psJobName = 'JOB_UTIL_QryPlanStats.ps1';
INSERT INTO [DFS_PowershellJobSchedule]
( [Enabled], 
  [FQN], 
  psJobName, 
  [ScheduleUnit], 
  [ScheduleExecValue], 
  [StartTime], 
  [LastRunTime], 
  [NextRunTime], 
  [UID], RunIdReq
) 
VALUES
(
       1
     , @fqn
     , @psJobName
     , 'minute'
     , 30
     , GETDATE()
     , GETDATE()
     , GETDATE()
     , NEWID(), 0
);
SET @psJobName = 'JOB_UTIL_TempDbMonitor.ps1';
INSERT INTO [DFS_PowershellJobSchedule]
( [Enabled], 
  [FQN], 
  psJobName, 
  [ScheduleUnit], 
  [ScheduleExecValue], 
  [StartTime], 
  [LastRunTime], 
  [NextRunTime], 
  [UID], RunIdReq
) 
VALUES
(
       1
     , @fqn
     , @psJobName
     , 'minute'
     , 15
     , GETDATE()
     , GETDATE()
     , GETDATE()
     , NEWID(), 1
);
SET @psJobName = 'JOB_UTIL_TrackSessionWaitStats.ps1';
INSERT INTO [DFS_PowershellJobSchedule]
( [Enabled], 
  [FQN], 
  psJobName, 
  [ScheduleUnit], 
  [ScheduleExecValue], 
  [StartTime], 
  [LastRunTime], 
  [NextRunTime], 
  [UID], RunIdReq
) 
VALUES
(
       1
     , @fqn
     , @psJobName
     , 'minute'
     , 10
     , GETDATE()
     , GETDATE()
     , GETDATE()
     , NEWID(), 0
);
SET @psJobName = 'JOB_UTIL_TxMonitorTableStats.ps1';
INSERT INTO [DFS_PowershellJobSchedule]
( [Enabled], 
  [FQN], 
  psJobName, 
  [ScheduleUnit], 
  [ScheduleExecValue], 
  [StartTime], 
  [LastRunTime], 
  [NextRunTime], 
  [UID], RunIdReq
) 
VALUES
(
       1
     , @fqn
     , @psJobName
     , 'day'
     , 1
     , GETDATE()
     , GETDATE()
     , GETDATE()
     , NEWID(), 0
);

/****************** PROCESSING FILE *************************************/

GO  
PRINT 'ID# 40'  
print 'D:\dev\SQL\DFINAnalytics\sp_ckProcessDB.sql' 
--* USEmaster;
GO
IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'sp_ckProcessDB'
)
    DROP PROCEDURE sp_ckProcessDB;
GO
CREATE PROCEDURE sp_ckProcessDB
AS
    BEGIN
 DECLARE @DBNAME NVARCHAR(100)= DB_NAME();
 IF @DBName = 'model'
     BEGIN
  PRINT 'SKIPPING: ' + @DBNAME;
  RETURN 0;
 END;
 IF @DBName = 'msdb'
     BEGIN
  PRINT 'SKIPPING: ' + @DBNAME;
  RETURN 0;
 END;
 IF @DBName = 'tempdb'
     BEGIN
  PRINT 'SKIPPING: ' + @DBNAME;
  RETURN 0;
 END;
 IF @DBName = 'master'
     BEGIN
  PRINT 'SKIPPING: ' + @DBNAME;
  RETURN 0;
 END;
 RETURN 1;
    END;

/****************** PROCESSING FILE *************************************/

GO  
PRINT 'ID# 50'  
print 'D:\dev\SQL\DFINAnalytics\DFS_DBVersion.sql' 

/** USEDFINAnalytics;*/

GO

/* select * from  DFS_DBVersion*/

IF EXISTS
(
    SELECT name
    FROM sys.tables
    WHERE name = 'DFS_DBVersion'
)
    DROP TABLE DFS_DBVersion;
GO
CREATE TABLE DFS_DBVersion
([SVRName] [NVARCHAR](150) NULL, 
 [DBName]  [NVARCHAR](150) NULL, 
 [SSVER]   [NVARCHAR](250) NOT NULL, 
 [SSVERID] UNIQUEIDENTIFIER NOT NULL
  DEFAULT NEWID(), 
 [UID]     UNIQUEIDENTIFIER NOT NULL
  DEFAULT NEWID(),
);
CREATE UNIQUE INDEX PK_DFS_DBVersion
ON DFS_DBVersion
([SSVERID]
) INCLUDE([SSVER]);
GO
IF EXISTS
(
    SELECT name
    FROM sys.procedures
    WHERE name = 'UTIL_DFS_DBVersion'
)
    DROP PROCEDURE UTIL_DFS_DBVersion;
GO

/* exec UTIL_DFS_DBVersion
 select * from DFS_DBVersion*/

CREATE PROCEDURE UTIL_DFS_DBVersion
AS
    BEGIN
 DECLARE @SSVER NVARCHAR(150)= @@version;
 DECLARE @SSID NVARCHAR(60);
 DECLARE @ID INT;
 IF EXISTS
 (
     SELECT [SSVERID]
     FROM DFS_DBVersion
     WHERE [SSVER] = @SSVER
 )
     BEGIN
  SET @SSID =
  (
 SELECT [SSVERID]
 FROM DFS_DBVersion
 WHERE [SSVER] = @SSVER
  );
 END;
     ELSE
     BEGIN
  SET @SSID = NEWID();
  INSERT INTO DFS_DBVersion
  ( [SVRName], 
    [DBName], 
    [SSVER], 
    [SSVERID]
  ) 
  VALUES
  (
    @@servername
  , DB_NAME()
  , @@version
  , CAST(@SSID AS NVARCHAR(60))
  );
  SET @SSVER =
  (
 SELECT [SSVERID]
 FROM DFS_DBVersion
 WHERE [SSVER] = @SSVER
  );
 END;
 PRINT @SSVER;
    END;
GO
EXEC UTIL_DFS_DBVersion;
GO

/****************** PROCESSING FILE *************************************/

GO  
PRINT 'ID# 60'  
print 'D:\dev\SQL\DFINAnalytics\createSeq2008.sql' 
--* USEDFINAnalytics
go
--Create a dummy TABLE to generate a SEQUENCE. No actual records will be stored.

if not exists (select 1 from INFORMATION_SCHEMA.TABLES where TABLE_NAME = 'DFS_SequenceTABLE')
CREATE TABLE DFS_SequenceTABLE
(
    ID BIGINT IDENTITY  
);
GO

if exists (select 1 from sys.procedures where name = 'GetSEQUENCE')
	drop procedure GetSEQUENCE;
go

--This procedure is for convenience in retrieving a sequence.
create PROCEDURE dbo.GetSEQUENCE ( @value BIGINT OUTPUT)
AS
    --Act like we are INSERTing a row to increment the IDENTITY
  
    INSERT DFS_SequenceTABLE WITH (TABLOCKX) DEFAULT VALUES;
    --Return the latest IDENTITY value.
    SELECT @value = SCOPE_IDENTITY();
GO

/*Example execution
DECLARE @value BIGINT;
EXECUTE dbo.GetSEQUENCE @value OUTPUT;
SELECT @value AS [@value];
*/


/****************** PROCESSING FILE *************************************/

GO  
PRINT 'ID# 70'  
print 'D:\dev\SQL\DFINAnalytics\create_DFS_WaitTypes_TableAndPopulate.sql' 

--* USEDFINAnalytics;
GO
-- truncate table DFS_WaitTypes
-- select count(*) from DFS_WaitTypes
IF NOT EXISTS
(
    SELECT 1
    FROM sys.tables
    WHERE name = 'DFS_WaitTypes'
)
    BEGIN
 CREATE TABLE DFS_WaitTypes
 (typecode   NVARCHAR(50) NOT NULL, 
  definition NVARCHAR(MAX) NOT NULL,
 );
 CREATE INDEX pk_DFS_WaitTypes ON DFS_WaitTypes(typecode);
END;
GO
SET NOCOUNT ON;

truncate table DFS_WaitTypes;

INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('ABR', 
 'Identified for informational purposes only. Not supported. Future compatibility is not guaranteed.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('AM_INDBUILD_ALLOCATION', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('AM_SCHEMAMGR_UNSHARED_CACHE', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('ASSEMBLY_FILTER_HASHTABLE', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('ASSEMBLY_LOAD', 
 'Occurs during exclusive access to assembly loading.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('ASYNC_DISKPOOL_LOCK', 
 'Occurs when there is an attempt to synchronize parallel threads that are performing tasks such as creating or initializing a file.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('ASYNC_IO_COMPLETION', 
 'Occurs when a task is waiting for I/Os to finish.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('ASYNC_NETWORK_IO', 
 'Occurs on network writes when the task is blocked behind the network. Verify that the client is processing data from the server.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('ASYNC_OP_COMPLETION', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('ASYNC_OP_CONTEXT_READ', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('ASYNC_OP_CONTEXT_WRITE', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('ASYNC_SOCKETDUP_IO', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('AUDIT_GROUPCACHE_LOCK', 
 'Occurs when there is a wait on a lock that controls access to a special cache. The cache contains information about which audits are being used to audit each audit action group.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('AUDIT_LOGINCACHE_LOCK', 
 'Occurs when there is a wait on a lock that controls access to a special cache. The cache contains information about which audits are being used to audit login audit action groups.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('AUDIT_ON_DEMAND_TARGET_LOCK', 
 'Occurs when there is a wait on a lock that is used to ensure single initialization of audit related Extended Event targets.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('AUDIT_XE_SESSION_MGR', 
 'Occurs when there is a wait on a lock that is used to synchronize the starting and stopping of audit related Extended Events sessions.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('BACKUP', 
 'Occurs when a task is blocked as part of backup processing.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('BACKUP_OPERATOR', 
 'Occurs when a task is waiting for a tape mount. To view the tape status, query sys.dm_io_backup_tapes. If a mount operation is not pending, this wait type may indicate a hardware problem with the tape drive.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('BACKUPBUFFER', 
 'Occurs when a backup task is waiting for data, or is waiting for a buffer in which to store data. This type is not typical, except when a task is waiting for a tape mount.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('BACKUPIO', 
 'Occurs when a backup task is waiting for data, or is waiting for a buffer in which to store data. This type is not typical, except when a task is waiting for a tape mount.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('BACKUPTHREAD', 
 'Occurs when a task is waiting for a backup task to finish. Wait times may be long, from several minutes to several hours. If the task that is being waited on is in an I/O process, this type does not indicate a problem.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('BAD_PAGE_PROCESS', 
 'Occurs when the background suspect page logger is trying to avoid running more than every five seconds. Excessive suspect pages cause the logger to run frequently.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('BLOB_METADATA', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('BMPALLOCATION', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('BMPBUILD', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('BMPREPARTITION', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('BMPREPLICATION', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('BPSORT', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('BROKER_CONNECTION_RECEIVE_TASK', 
 'Occurs when waiting for access to receive a message on a connection endpoint. Receive access to the endpoint is serialized.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('BROKER_DISPATCHER', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('BROKER_ENDPOINT_STATE_MUTEX', 
 'Occurs when there is contention to access the state of a Service Broker connection endpoint. Access to the state for changes is serialized.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('BROKER_EVENTHANDLER', 
 'Occurs when a task is waiting in the primary event handler of the Service Broker. This should occur very briefly.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('BROKER_FORWARDER', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('BROKER_INIT', 
 'Occurs when initializing Service Broker in each active database. This should occur infrequently.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('BROKER_MASTERSTART', 
 'Occurs when a task is waiting for the primary event handler of the Service Broker to start. This should occur very briefly.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('BROKER_RECEIVE_WAITFOR', 
 'Occurs when the RECEIVE WAITFOR is waiting. This may mean that either no messages are ready to be received in the queue or a lock contention is preventing it from receiving messages from the queue.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('BROKER_REGISTERALLENDPOINTS', 
 'Occurs during the initialization of a Service Broker connection endpoint. This should occur very briefly.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('BROKER_SERVICE', 
 'Occurs when the Service Broker destination list that is associated with a target service is updated or re-prioritized.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('BROKER_SHUTDOWN', 
 'Occurs when there is a planned shutdown of Service Broker. This should occur very briefly, if at all.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('BROKER_START', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('BROKER_TASK_SHUTDOWN', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('BROKER_TASK_STOP', 
 'Occurs when the Service Broker queue task handler tries to shut down the task. The state check is serialized and must be in a running state beforehand.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('BROKER_TASK_SUBMIT', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('BROKER_TO_FLUSH', 
 'Occurs when the Service Broker lazy flusher flushes the in-memory transmission objects to a work table.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('BROKER_TRANSMISSION_OBJECT', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('BROKER_TRANSMISSION_TABLE', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('BROKER_TRANSMISSION_WORK', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('BROKER_TRANSMITTER', 
 'Occurs when the Service Broker transmitter is waiting for work. Service Broker has a component known as the Transmitter which schedules messages from multiple dialogs to be sent across the wire over one or more connection endpoints. The transmitter has 2 dedicated threads for this purpose. This wait type is charged when these transmitter threads are waiting for dialog messages to be sent using the transport connections. High values of waiting_tasks_count for this wait type point to intermittent work for these transmitter threads and are not indications of any performance problem. If service broker is not used at all, waiting_tasks_count should be 2 (for the 2 transmitter threads) and wait_time_ms should be twice the duration since instance startup. See Service broker wait stats.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('BUILTIN_HASHKEY_MUTEX', 
 'May occur after startup of instance, while internal data structures are initializing. Will not recur once data structures have initialized.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('CHANGE_TRACKING_WAITFORCHANGES', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('CHECK_PRINT_RECORD', 
 'Identified for informational purposes only. Not supported. Future compatibility is not guaranteed.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('CHECK_SCANNER_MUTEX', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('CHECK_TABLES_INITIALIZATION', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('CHECK_TABLES_SINGLE_SCAN', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('CHECK_TABLES_THREAD_BARRIER', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('CHECKPOINT_QUEUE', 
 'Occurs while the checkpoint task is waiting for the next checkpoint request.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('CHKPT', 
 'Occurs at server startup to tell the checkpoint thread that it can start.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('CLEAR_DB', 
 'Occurs during operations that change the state of a database, such as opening or closing a database.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('CLR_AUTO_EVENT', 
 'Occurs when a task is currently performing common language runtime (CLR) execution and is waiting for a particular autoevent to be initiated. Long waits are typical, and do not indicate a problem.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('CLR_CRST', 
 'Occurs when a task is currently performing CLR execution and is waiting to enter a critical section of the task that is currently being used by another task.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('CLR_JOIN', 
 'Occurs when a task is currently performing CLR execution and waiting for another task to end. This wait state occurs when there is a join between tasks.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('CLR_MANUAL_EVENT', 
 'Occurs when a task is currently performing CLR execution and is waiting for a specific manual event to be initiated.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('CLR_MEMORY_SPY', 
 'Occurs during a wait on lock acquisition for a data structure that is used to record all virtual memory allocations that come from CLR. The data structure is locked to maintain its integrity if there is parallel access.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('CLR_MONITOR', 
 'Occurs when a task is currently performing CLR execution and is waiting to obtain a lock on the monitor.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('CLR_RWLOCK_READER', 
 'Occurs when a task is currently performing CLR execution and is waiting for a reader lock.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('CLR_RWLOCK_WRITER', 
 'Occurs when a task is currently performing CLR execution and is waiting for a writer lock.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('CLR_SEMAPHORE', 
 'Occurs when a task is currently performing CLR execution and is waiting for a semaphore.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('CLR_TASK_START', 
 'Occurs while waiting for a CLR task to complete startup.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('CLRHOST_STATE_ACCESS', 
 'Occurs where there is a wait to acquire exclusive access to the CLR-hosting data structures. This wait type occurs while setting up or tearing down the CLR runtime.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('CMEMPARTITIONED', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('CMEMTHREAD', 
 'Occurs when a task is waiting on a thread-safe memory object. The wait time might increase when there is contention caused by multiple tasks trying to allocate memory from the same memory object.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('COLUMNSTORE_BUILD_THROTTLE', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('COLUMNSTORE_COLUMNDATASET_SESSION_LIST', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('COMMIT_TABLE', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('CONNECTION_ENDPOINT_LOCK', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('COUNTRECOVERYMGR', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('CREATE_DATINISERVICE', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('CXCONSUMER', 
 'Occurs with parallel query plans when a consumer thread waits for a producer thread to send rows. This is a normal part of parallel query execution.: Applies to: SQL Server (Starting with SQL Server 2016 (13.x) SP2, SQL Server 2017 (14.x) CU3), SQL Database'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('CXPACKET', 
 'Occurs with parallel query plans when synchronizing the query processor exchange iterator, and when producing and consuming rows. If waiting is excessive and cannot be reduced by tuning the query (such as adding indexes), consider adjusting the cost threshold for parallelism or lowering the degree of parallelism.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('CXROWSET_SYNC', 
 'Occurs during a parallel range scan.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('DAC_INIT', 
 'Occurs while the dedicated administrator connection is initializing.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('DBCC_SCALE_OUT_EXPR_CACHE', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('DBMIRROR_DBM_EVENT', 
 'Identified for informational purposes only. Not supported. Future compatibility is not guaranteed.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('DBMIRROR_DBM_MUTEX', 
 'Identified for informational purposes only. Not supported. Future compatibility is not guaranteed.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('DBMIRROR_EVENTS_QUEUE', 
 'Occurs when database mirroring waits for events to process.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('DBMIRROR_SEND', 
 'Occurs when a task is waiting for a communications backlog at the network layer to clear to be able to send messages. Indicates that the communications layer is starting to become overloaded and affect the database mirroring data throughput.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('DBMIRROR_WORKER_QUEUE', 
 'Indicates that the database mirroring worker task is waiting for more work.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('DBMIRRORING_CMD', 
 'Occurs when a task is waiting for log records to be flushed to disk. This wait state is expected to be held for long periods of time.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('DBSEEDING_FLOWCONTROL', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('DBSEEDING_OPERATION', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('DEADLOCK_ENUM_MUTEX', 
 'Occurs when the deadlock monitor and sys.dm_os_waiting_tasks try to make sure that SQL Server is not running multiple deadlock searches at the same time.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('DEADLOCK_TASK_SEARCH', 
 'Large waiting time on this resource indicates that the server is executing queries on top of sys.dm_os_waiting_tasks, and these queries are blocking deadlock monitor from running deadlock search. This wait type is used by deadlock monitor only. Queries on top of sys.dm_os_waiting_tasks --* USEDEADLOCK_ENUM_MUTEX.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('DEBUG', 
 'Occurs during Transact-SQL and CLR debugging for internal synchronization.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('DIRECTLOGCONSUMER_LIST', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('DIRTY_PAGE_POLL', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('DIRTY_PAGE_SYNC', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('DIRTY_PAGE_TABLE_LOCK', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('DISABLE_VERSIONING', 
 'Occurs when SQL Server polls the version transaction manager to see whether the timestamp of the earliest active transaction is later than the timestamp of when the state started changing. If this is this case, all the snapshot transactions that were started before the ALTER DATABASE statement was run have finished. This wait state is used when SQL Server disables versioning by using the ALTER DATABASE statement.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('DISKIO_SUSPEND', 
 'Occurs when a task is waiting to access a file when an external backup is active. This is reported for each waiting user process. A count larger than five per user process may indicate that the external backup is taking too much time to finish.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('DISPATCHER_PRIORITY_QUEUE_SEMAPHORE', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('DISPATCHER_QUEUE_SEMAPHORE', 
 'Occurs when a thread from the dispatcher pool is waiting for more work to process. The wait time for this wait type is expected to increase when the dispatcher is idle.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('DLL_LOADING_MUTEX', 
 'Occurs once while waiting for the XML parser DLL to load.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('DPT_ENTRY_LOCK', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('DROP_DATABASE_TIMER_TASK', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('DROPTEMP', 
 'Occurs between attempts to drop a temporary object if the previous attempt failed. The wait duration grows exponentially with each failed drop attempt.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('DTC', 
 'Occurs when a task is waiting on an event that is used to manage state transition. This state controls when the recovery of Microsoft Distributed Transaction Coordinator (MS DTC) transactions occurs after SQL Server receives notification that the MS DTC service has become unavailable.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('DTC_ABORT_REQUEST', 
 'Occurs in a MS DTC worker session when the session is waiting to take ownership of a MS DTC transaction. After MS DTC owns the transaction, the session can roll back the transaction. Generally, the session will wait for another session that is using the transaction.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('DTC_RESOLVE', 
 'Occurs when a recovery task is waiting for the master database in a cross-database transaction so that the task can query the outcome of the transaction.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('DTC_STATE', 
 'Occurs when a task is waiting on an event that protects changes to the internal MS DTC global state object. This state should be held for very short periods of time.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('DTC_TMDOWN_REQUEST', 
 'Occurs in a MS DTC worker session when SQL Server receives notification that the MS DTC service is not available. First, the worker will wait for the MS DTC recovery process to start. Then, the worker waits to obtain the outcome of the distributed transaction that the worker is working on. This may continue until the connection with the MS DTC service has been reestablished.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('DTC_WAITFOR_OUTCOME', 
 'Occurs when recovery tasks wait for MS DTC to become active to enable the resolution of prepared transactions.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('DTCNEW_ENLIST', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('DTCNEW_PREPARE', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('DTCNEW_RECOVERY', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('DTCNEW_TM', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('DTCNEW_TRANSACTION_ENLISTMENT', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('DTCPNTSYNC', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('DUMP_LOG_COORDINATOR', 
 'Occurs when a main task is waiting for a subtask to generate data. Ordinarily, this state does not occur. A long wait indicates an unexpected blockage. The subtask should be investigated.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('DUMP_LOG_COORDINATOR_QUEUE', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('DUMPTRIGGER', 
 'Identified for informational purposes only. Not supported. Future compatibility is not guaranteed.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('EC', 
 'Identified for informational purposes only. Not supported. Future compatibility is not guaranteed.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('EE_PMOLOCK', 
 'Occurs during synchronization of certain types of memory allocations during statement execution.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('EE_SPECPROC_MAP_INIT', 
 'Occurs during synchronization of internal procedure hash table creation. This wait can only occur during the initial accessing of the hash table after the SQL Server instance starts.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('ENABLE_EMPTY_VERSIONING', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('ENABLE_VERSIONING', 
 'Occurs when SQL Server waits for all update transactions in this database to finish before declaring the database ready to transition to snapshot isolation allowed state. This state is used when SQL Server enables snapshot isolation by using the ALTER DATABASE statement.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('ERROR_REPORTING_MANAGER', 
 'Occurs during synchronization of multiple concurrent error log initializations.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('EXCHANGE', 
 'Occurs during synchronization in the query processor exchange iterator during parallel queries.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('EXECSYNC', 
 'Occurs during parallel queries while synchronizing in query processor in areas not related to the exchange iterator. Examples of such areas are bitmaps, large binary objects (LOBs), and the spool iterator. LOBs may frequently --* USEthis wait state.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('EXECUTION_PIPE_EVENT_INTERNAL', 
 'Occurs during synchronization between producer and consumer parts of batch execution that are submitted through the connection context.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('EXTERNAL_RG_UPDATE', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('EXTERNAL_SCRIPT_NETWORK_IO', 
 'TBD: Applies to: SQL Server 2017 (14.x) through current.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('EXTERNAL_SCRIPT_PREPARE_SERVICE', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('EXTERNAL_SCRIPT_SHUTDOWN', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('EXTERNAL_WAIT_ON_LAUNCHER,', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FABRIC_HADR_TRANSPORT_CONNECTION', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FABRIC_REPLICA_CONTROLLER_LIST', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FABRIC_REPLICA_CONTROLLER_STATE_AND_CONFIG', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FABRIC_REPLICA_PUBLISHER_EVENT_PUBLISH', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FABRIC_REPLICA_PUBLISHER_SUBSCRIBER_LIST', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FABRIC_WAIT_FOR_BUILD_REPLICA_EVENT_PROCESSING', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FAILPOINT', 
 'Identified for informational purposes only. Not supported. Future compatibility is not guaranteed.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FCB_REPLICA_READ', 
 'Occurs when the reads of a snapshot (or a temporary snapshot created by DBCC) sparse file are synchronized.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FCB_REPLICA_WRITE', 
 'Occurs when the pushing or pulling of a page to a snapshot (or a temporary snapshot created by DBCC) sparse file is synchronized.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FEATURE_SWITCHES_UPDATE', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FFT_NSO_DB_KILL_FLAG', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FFT_NSO_DB_LIST', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FFT_NSO_FCB', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FFT_NSO_FCB_FIND', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FFT_NSO_FCB_PARENT', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FFT_NSO_FCB_RELEASE_CACHED_ENTRIES', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FFT_NSO_FCB_STATE', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FFT_NSO_FILEOBJECT', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FFT_NSO_TABLE_LIST', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FFT_NTFS_STORE', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FFT_RECOVERY', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FFT_RSFX_COMM', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FFT_RSFX_WAIT_FOR_MEMORY', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FFT_STARTUP_SHUTDOWN', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FFT_STORE_DB', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FFT_STORE_ROWSET_LIST', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FFT_STORE_TABLE', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FILE_VALIDATION_THREADS', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FILESTREAM_CACHE', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FILESTREAM_CHUNKER', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FILESTREAM_CHUNKER_INIT', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FILESTREAM_FCB', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FILESTREAM_FILE_OBJECT', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FILESTREAM_WORKITEM_QUEUE', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FILETABLE_SHUTDOWN', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FOREIGN_REDO', 
 'TBD: Applies to: SQL Server 2017 (14.x) through current.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FORWARDER_TRANSITION', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FS_FC_RWLOCK', 
 'Occurs when there is a wait by the FILESTREAM garbage collector to do either of the following:'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FS_GARBAGE_COLLECTOR_SHUTDOWN', 
 'Occurs when the FILESTREAM garbage collector is waiting for cleanup tasks to be completed.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FS_HEADER_RWLOCK', 
 'Occurs when there is a wait to acquire access to the FILESTREAM header of a FILESTREAM data container to either read or update contents in the FILESTREAM header file (Filestream.hdr).'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FS_LOGTRUNC_RWLOCK', 
 'Occurs when there is a wait to acquire access to FILESTREAM log truncation to do either of the following:'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FSA_FORCE_OWN_XACT', 
 'Occurs when a FILESTREAM file I/O operation needs to bind to the associated transaction, but the transaction is currently owned by another session.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FSAGENT', 
 'Occurs when a FILESTREAM file I/O operation is waiting for a FILESTREAM agent resource that is being used by another file I/O operation.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FSTR_CONFIG_MUTEX', 
 'Occurs when there is a wait for another FILESTREAM feature reconfiguration to be completed.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FSTR_CONFIG_RWLOCK', 
 'Occurs when there is a wait to serialize access to the FILESTREAM configuration parameters.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FT_COMPROWSET_RWLOCK', 
 'Full-text is waiting on fragment metadata operation. Documented for informational purposes only. Not supported. Future compatibility is not guaranteed.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FT_IFTS_RWLOCK', 
 'Full-text is waiting on internal synchronization. Documented for informational purposes only. Not supported. Future compatibility is not guaranteed.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FT_IFTS_SCHEDULER_IDLE_WAIT', 
 'Full-text scheduler sleep wait type. The scheduler is idle.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FT_IFTSHC_MUTEX', 
 'Full-text is waiting on an fdhost control operation. Documented for informational purposes only. Not supported. Future compatibility is not guaranteed.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FT_IFTSISM_MUTEX', 
 'Full-text is waiting on communication operation. Documented for informational purposes only. Not supported. Future compatibility is not guaranteed.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FT_MASTER_MERGE', 
 'Full-text is waiting on master merge operation. Documented for informational purposes only. Not supported. Future compatibility is not guaranteed.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FT_MASTER_MERGE_COORDINATOR', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FT_METADATA_MUTEX', 
 'Documented for informational purposes only. Not supported. Future compatibility is not guaranteed.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FT_PROPERTYLIST_CACHE', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FT_RESTART_CRAWL', 
 'Occurs when a full-text crawl needs to restart from a last known good point to recover from a transient failure. The wait lets the worker tasks currently working on that population to complete or exit the current step.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FULLTEXT GATHERER', 
 'Occurs during synchronization of full-text operations.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('GDMA_GET_RESOURCE_OWNER', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('GHOSTCLEANUP_UPDATE_STATS', 
 'TBD: Applies to: SQL Server 2017 (14.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('GHOSTCLEANUPSYNCMGR', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('GLOBAL_QUERY_CANCEL', 
 'TBD: Applies to: SQL Server 2017 (14.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('GLOBAL_QUERY_CLOSE', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('GLOBAL_QUERY_CONSUMER', 
 'TBD: Applies to: SQL Server 2017 (14.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('GLOBAL_QUERY_PRODUCER', 
 'TBD: Applies to: SQL Server 2017 (14.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('GLOBAL_TRAN_CREATE', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('GLOBAL_TRAN_UCS_SESSION', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('GUARDIAN', 
 'Identified for informational purposes only. Not supported. Future compatibility is not guaranteed.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_AG_MUTEX', 
 'Occurs when an Always On DDL statement or Windows Server Failover Clustering command is waiting for exclusive read/write access to the configuration of an availability group.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_AR_CRITICAL_SECTION_ENTRY', 
 'Occurs when an Always On DDL statement or Windows Server Failover Clustering command is waiting for exclusive read/write access to the runtime state of the local replica of the associated availability group.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_AR_MANAGER_MUTEX', 
 'Occurs when an availability replica shutdown is waiting for startup to complete or an availability replica startup is waiting for shutdown to complete. Internal --* USEonly.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_AR_UNLOAD_COMPLETED', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_ARCONTROLLER_NOTIFICATIONS_SUBSCRIBER_LIST', 
 'The publisher for an availability replica event (such as a state change or configuration change) is waiting for exclusive read/write access to the list of event subscribers. Internal --* USEonly.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_BACKUP_BULK_LOCK', 
 'The Always On primary database received a backup request from a secondary database and is waiting for the background thread to finish processing the request on acquiring or releasing the BulkOp lock.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_BACKUP_QUEUE', 
 'The backup background thread of the Always On primary database is waiting for a new work request from the secondary database. (typically, this occurs when the primary database is holding the BulkOp log and is waiting for the secondary database to indicate that the primary database can release the lock).,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_CLUSAPI_CALL', 
 'A SQL Server thread is waiting to switch from non-preemptive mode (scheduled by SQL Server) to preemptive mode (scheduled by the operating system) in order to invoke Windows Server Failover Clustering APIs.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_COMPRESSED_CACHE_SYNC', 
 'Waiting for access to the cache of compressed log blocks that is used to avoid redundant compression of the log blocks sent to multiple secondary databases.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_CONNECTIVITY_INFO', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_DATABASE_FLOW_CONTROL', 
 'Waiting for messages to be sent to the partner when the maximum number of queued messages has been reached. Indicates that the log scans are running faster than the network sends. This is an issue only if network sends are slower than expected.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_DATABASE_VERSIONING_STATE', 
 'Occurs on the versioning state change of an Always On secondary database. This wait is for internal data structures and is usually is very short with no direct effect on data access.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_DATABASE_WAIT_FOR_RECOVERY', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_DATABASE_WAIT_FOR_RESTART', 
 'Waiting for the database to restart under Always On Availability Groups control. Under normal conditions, this is not a customer issue because waits are expected here.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_DATABASE_WAIT_FOR_TRANSITION_TO_VERSIONING', 
 'A query on object(s) in a readable secondary database of an Always On availability group is blocked on row versioning while waiting for commit or rollback of all transactions that were in-flight when the secondary replica was enabled for read workloads. This wait type guarantees that row versions are available before execution of a query under snapshot isolation.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_DB_COMMAND', 
 'Waiting for responses to conversational messages (which require an explicit response from the other side, using the Always On conversational message infrastructure). A number of different message types --* USEthis wait type.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_DB_OP_COMPLETION_SYNC', 
 'Waiting for responses to conversational messages (which require an explicit response from the other side, using the Always On conversational message infrastructure). A number of different message types --* USEthis wait type.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_DB_OP_START_SYNC', 
 'An Always On DDL statement or a Windows Server Failover Clustering command is waiting for serialized access to an availability database and its runtime state.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_DBR_SUBSCRIBER', 
 'The publisher for an availability replica event (such as a state change or configuration change) is waiting for exclusive read/write access to the runtime state of an event subscriber that corresponds to an availability database. Internal --* USEonly.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_DBR_SUBSCRIBER_FILTER_LIST', 
 'The publisher for an availability replica event (such as a state change or configuration change) is waiting for exclusive read/write access to the list of event subscribers that correspond to availability databases. Internal --* USEonly.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_DBSEEDING', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_DBSEEDING_LIST', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_DBSTATECHANGE_SYNC', 
 'Concurrency control wait for updating the internal state of the database replica.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_FABRIC_CALLBACK', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_FILESTREAM_BLOCK_FLUSH', 
 'The FILESTREAM Always On transport manager is waiting until processing of a log block is finished.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_FILESTREAM_FILE_CLOSE', 
 'The FILESTREAM Always On transport manager is waiting until the next FILESTREAM file gets processed and its handle gets closed.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_FILESTREAM_FILE_REQUEST', 
 'An Always On secondary replica is waiting for the primary replica to send all requested FILESTREAM files during UNDO.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_FILESTREAM_IOMGR', 
 'The FILESTREAM Always On transport manager is waiting for R/W lock that protects the FILESTREAM Always On I/O manager during startup or shutdown.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_FILESTREAM_IOMGR_IOCOMPLETION', 
 'The FILESTREAM Always On I/O manager is waiting for I/O completion.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_FILESTREAM_MANAGER', 
 'The FILESTREAM Always On transport manager is waiting for the R/W lock that protects the FILESTREAM Always On transport manager during startup or shutdown.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_FILESTREAM_PREPROC', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_GROUP_COMMIT', 
 'Transaction commit processing is waiting to allow a group commit so that multiple commit log records can be put into a single log block. This wait is an expected condition that optimizes the log I/O, capture, and send operations.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_LOGCAPTURE_SYNC', 
 'Concurrency control around the log capture or apply object when creating or destroying scans. This is an expected wait when partners change state or connection status.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_LOGCAPTURE_WAIT', 
 'Waiting for log records to become available. Can occur either when waiting for new log records to be generated by connections or for I/O completion when reading log not in the cache. This is an expected wait if the log scan is caught up to the end of log or is reading from disk.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_LOGPROGRESS_SYNC', 
 'Concurrency control wait when updating the log progress status of database replicas.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_NOTIFICATION_DEQUEUE', 
 'A background task that processes Windows Server Failover Clustering notifications is waiting for the next notification. Internal --* USEonly.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_NOTIFICATION_WORKER_EXCLUSIVE_ACCESS', 
 'The Always On availability replica manager is waiting for serialized access to the runtime state of a background task that processes Windows Server Failover Clustering notifications. Internal --* USEonly.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_NOTIFICATION_WORKER_STARTUP_SYNC', 
 'A background task is waiting for the completion of the startup of a background task that processes Windows Server Failover Clustering notifications. Internal --* USEonly.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_NOTIFICATION_WORKER_TERMINATION_SYNC', 
 'A background task is waiting for the termination of a background task that processes Windows Server Failover Clustering notifications. Internal --* USEonly.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_PARTNER_SYNC', 
 'Concurrency control wait on the partner list.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_READ_ALL_NETWORKS', 
 'Waiting to get read or write access to the list of WSFC networks. Internal --* USEonly. Note: The engine keeps a list of WSFC networks that is used in dynamic management views (such as sys.dm_hadr_cluster_networks) or to validate Always On Transact-SQL statements that reference WSFC network information. This list is updated upon engine startup, WSFC related notifications, and internal Always On restart (for example, losing and regaining of WSFC quorum). Tasks will usually be blocked when an update in that list is in progress. ,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_RECOVERY_WAIT_FOR_CONNECTION', 
 'Waiting for the secondary database to connect to the primary database before running recovery. This is an expected wait, which can lengthen if the connection to the primary is slow to establish.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_RECOVERY_WAIT_FOR_UNDO', 
 'Database recovery is waiting for the secondary database to finish the reverting and initializing phase to bring it back to the common log point with the primary database. This is an expected wait after failovers.Undo progress can be tracked through the Windows System Monitor (perfmon.exe) and dynamic management views.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_REPLICAINFO_SYNC', 
 'Waiting for concurrency control to update the current replica state.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_SEEDING_CANCELLATION', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_SEEDING_FILE_LIST', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_SEEDING_LIMIT_BACKUPS', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_SEEDING_SYNC_COMPLETION', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_SEEDING_TIMEOUT_TASK', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_SEEDING_WAIT_FOR_COMPLETION', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_SYNC_COMMIT', 
 'Waiting for transaction commit processing for the synchronized secondary databases to harden the log. This wait is also reflected by the Transaction Delay performance counter. This wait type is expected for synchronized availability groups and indicates the time to send, write, and acknowledge log to the secondary databases.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_SYNCHRONIZING_THROTTLE', 
 'Waiting for transaction commit processing to allow a synchronizing secondary database to catch up to the primary end of log in order to transition to the synchronized state. This is an expected wait when a secondary database is catching up.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_TDS_LISTENER_SYNC', 
 'Either the internal Always On system or the WSFC cluster will request that listeners are started or stopped. The processing of this request is always asynchronous, and there is a mechanism to remove redundant requests. There are also moments that this process is suspended because of configuration changes. All waits related with this listener synchronization mechanism --* USEthis wait type. Internal --* USEonly.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_TDS_LISTENER_SYNC_PROCESSING', 
 'Used at the end of an Always On Transact-SQL statement that requires starting and/or stopping anavailability group listener. Since the start/stop operation is done asynchronously, the user thread will block using this wait type until the situation of the listener is known.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_THROTTLE_LOG_RATE_GOVERNOR', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_THROTTLE_LOG_RATE_LOG_SIZE', 
 'TBD: Applies to: SQL Server 2017 (14.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_THROTTLE_LOG_RATE_SEEDING', 
 'TBD: Applies to: SQL Server 2017 (14.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_THROTTLE_LOG_RATE_SEND_RECV_QUEUE_SIZE', 
 'TBD: Applies to: SQL Server 2017 (14.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_TIMER_TASK', 
 'Waiting to get the lock on the timer task object and is also used for the actual waits between times that work is being performed. For example, for a task that runs every 10 seconds, after one execution, Always On Availability Groups waits about 10 seconds to reschedule the task, and the wait is included here.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_TRANSPORT_DBRLIST', 
 'Waiting for access to the transport layer`s database replica list. Used for the spinlock that grants access to it.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_TRANSPORT_FLOW_CONTROL', 
 'Waiting when the number of outstanding unacknowledged Always On messages is over the out flow control threshold. This is on an availability replica-to-replica basis (not on a database-to-database basis).,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_TRANSPORT_SESSION', 
 'Always On Availability Groups is waiting while changing or accessing the underlying transport state.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_WORK_POOL', 
 'Concurrency control wait on the Always On Availability Groups background work task object.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_WORK_QUEUE', 
 'Always On Availability Groups background worker thread waiting for new work to be assigned. This is an expected wait when there are ready workers waiting for new work, which is the normal state.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_XRF_STACK_ACCESS', 
 'Accessing (look up, add, and delete) the extended recovery fork stack for an Always On availability database.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HCCO_CACHE', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HK_RESTORE_FILEMAP', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HKCS_PARALLEL_MIGRATION', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HKCS_PARALLEL_RECOVERY', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HTBUILD', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HTDELETE', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HTMEMO', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HTREINIT', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HTREPARTITION', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HTTP_ENUMERATION', 
 'Occurs at startup to enumerate the HTTP endpoints to start HTTP.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HTTP_START', 
 'Occurs when a connection is waiting for HTTP to complete initialization.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HTTP_STORAGE_CONNECTION', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('IMPPROV_IOWAIT', 
 'Occurs when SQL Server waits for a bulkload I/O to finish.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('INSTANCE_LOG_RATE_GOVERNOR', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('INTERNAL_TESTING', 
 'Identified for informational purposes only. Not supported. Future compatibility is not guaranteed.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('IO_AUDIT_MUTEX', 
 'Occurs during synchronization of trace event buffers.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('IO_COMPLETION', 
 'Occurs while waiting for I/O operations to complete. This wait type generally represents non-data page I/Os. Data page I/O completion waits appear as PAGEIOLATCH_* waits.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('IO_QUEUE_LIMIT', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('IO_RETRY', 
 'Occurs when an I/O operation such as a read or a write to disk fails because of insufficient resources, and is then retried.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('IOAFF_RANGE_QUEUE', 
 'Identified for informational purposes only. Not supported. Future compatibility is not guaranteed.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('KSOURCE_WAKEUP', 
 'Used by the service control task while waiting for requests from the Service Control Manager. Long waits are expected and do not indicate a problem.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('KTM_ENLISTMENT', 
 'Identified for informational purposes only. Not supported. Future compatibility is not guaranteed.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('KTM_RECOVERY_MANAGER', 
 'Identified for informational purposes only. Not supported. Future compatibility is not guaranteed.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('KTM_RECOVERY_RESOLUTION', 
 'Identified for informational purposes only. Not supported. Future compatibility is not guaranteed.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LATCH_DT', 
 'Occurs when waiting for a DT (destroy) latch. This does not include buffer latches or transaction mark latches. A listing of LATCH_* waits is available in sys.dm_os_latch_stats. Note that sys.dm_os_latch_stats groups LATCH_NL, LATCH_SH, LATCH_UP, LATCH_EX, and LATCH_DT waits together.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LATCH_EX', 
 'Occurs when waiting for an EX (exclusive) latch. This does not include buffer latches or transaction mark latches. A listing of LATCH_* waits is available in sys.dm_os_latch_stats. Note that sys.dm_os_latch_stats groups LATCH_NL, LATCH_SH, LATCH_UP, LATCH_EX, and LATCH_DT waits together.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LATCH_KP', 
 'Occurs when waiting for a KP (keep) latch. This does not include buffer latches or transaction mark latches. A listing of LATCH_* waits is available in sys.dm_os_latch_stats. Note that sys.dm_os_latch_stats groups LATCH_NL, LATCH_SH, LATCH_UP, LATCH_EX, and LATCH_DT waits together.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LATCH_NL', 
 'Identified for informational purposes only. Not supported. Future compatibility is not guaranteed.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LATCH_SH', 
 'Occurs when waiting for an SH (share) latch. This does not include buffer latches or transaction mark latches. A listing of LATCH_* waits is available in sys.dm_os_latch_stats. Note that sys.dm_os_latch_stats groups LATCH_NL, LATCH_SH, LATCH_UP, LATCH_EX, and LATCH_DT waits together.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LATCH_UP', 
 'Occurs when waiting for an UP (update) latch. This does not include buffer latches or transaction mark latches. A listing of LATCH_* waits is available in sys.dm_os_latch_stats. Note that sys.dm_os_latch_stats groups LATCH_NL, LATCH_SH, LATCH_UP, LATCH_EX, and LATCH_DT waits together.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LAZYWRITER_SLEEP', 
 'Occurs when lazywriter tasks are suspended. This is a measure of the time spent by background tasks that are waiting. Do not consider this state when you are looking for user stalls.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_BU', 
 'Occurs when a task is waiting to acquire a Bulk Update (BU) lock.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_BU_ABORT_BLOCKERS', 
 'Occurs when a task is waiting to acquire a Bulk Update (BU) lock with Abort Blockers. (Related to the low priority wait option of ALTER TABLE and ALTER INDEX.),: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_BU_LOW_PRIORITY', 
 'Occurs when a task is waiting to acquire a Bulk Update (BU) lock with Low Priority. (Related to the low priority wait option of ALTER TABLE and ALTER INDEX.),: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_IS', 
 'Occurs when a task is waiting to acquire an Intent Shared (IS) lock.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_IS_ABORT_BLOCKERS', 
 'Occurs when a task is waiting to acquire an Intent Shared (IS) lock with Abort Blockers. (Related to the low priority wait option of ALTER TABLE and ALTER INDEX.),: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_IS_LOW_PRIORITY', 
 'Occurs when a task is waiting to acquire an Intent Shared (IS) lock with Low Priority. (Related to the low priority wait option of ALTER TABLE and ALTER INDEX.),: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_IU', 
 'Occurs when a task is waiting to acquire an Intent Update (IU) lock.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_IU_ABORT_BLOCKERS', 
 'Occurs when a task is waiting to acquire an Intent Update (IU) lock with Abort Blockers. (Related to the low priority wait option of ALTER TABLE and ALTER INDEX.),: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_IU_LOW_PRIORITY', 
 'Occurs when a task is waiting to acquire an Intent Update (IU) lock with Low Priority. (Related to the low priority wait option of ALTER TABLE and ALTER INDEX.),: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_IX', 
 'Occurs when a task is waiting to acquire an Intent Exclusive (IX) lock.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_IX_ABORT_BLOCKERS', 
 'Occurs when a task is waiting to acquire an Intent Exclusive (IX) lock with Abort Blockers. (Related to the low priority wait option of ALTER TABLE and ALTER INDEX.),: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_IX_LOW_PRIORITY', 
 'Occurs when a task is waiting to acquire an Intent Exclusive (IX) lock with Low Priority. (Related to the low priority wait option of ALTER TABLE and ALTER INDEX.),: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_RIn_NL', 
 'Occurs when a task is waiting to acquire a NULL lock on the current key value, and an Insert Range lock between the current and previous key. A NULL lock on the key is an instant release lock.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_RIn_NL_ABORT_BLOCKERS', 
 'Occurs when a task is waiting to acquire a NULL lock with Abort Blockers on the current key value, and an Insert Range lock with Abort Blockers between the current and previous key. A NULL lock on the key is an instant release lock. (Related to the low priority wait option of ALTER TABLE and ALTER INDEX.),: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_RIn_NL_LOW_PRIORITY', 
 'Occurs when a task is waiting to acquire a NULL lock with Low Priority on the current key value, and an Insert Range lock with Low Priority between the current and previous key. A NULL lock on the key is an instant release lock. (Related to the low priority wait option of ALTER TABLE and ALTER INDEX.),: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_RIn_S', 
 'Occurs when a task is waiting to acquire a shared lock on the current key value, and an Insert Range lock between the current and previous key.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_RIn_S_ABORT_BLOCKERS', 
 'Occurs when a task is waiting to acquire a shared lock with Abort Blockers on the current key value, and an Insert Range lock with Abort Blockers between the current and previous key. (Related to the low priority wait option of ALTER TABLE and ALTER INDEX.),: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_RIn_S_LOW_PRIORITY', 
 'Occurs when a task is waiting to acquire a shared lock with Low Priority on the current key value, and an Insert Range lock with Low Priority between the current and previous key. (Related to the low priority wait option of ALTER TABLE and ALTER INDEX.),: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_RIn_U', 
 'Task is waiting to acquire an Update lock on the current key value, and an Insert Range lock between the current and previous key.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_RIn_U_ABORT_BLOCKERS', 
 'Task is waiting to acquire an Update lock with Abort Blockers on the current key value, and an Insert Range lock with Abort Blockers between the current and previous key. (Related to the low priority wait option of ALTER TABLE and ALTER INDEX.),: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_RIn_U_LOW_PRIORITY', 
 'Task is waiting to acquire an Update lock with Low Priority on the current key value, and an Insert Range lock with Low Priority between the current and previous key. (Related to the low priority wait option of ALTER TABLE and ALTER INDEX.),: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_RIn_X', 
 'Occurs when a task is waiting to acquire an Exclusive lock on the current key value, and an Insert Range lock between the current and previous key.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_RIn_X_ABORT_BLOCKERS', 
 'Occurs when a task is waiting to acquire an Exclusive lock with Abort Blockers on the current key value, and an Insert Range lock with Abort Blockers between the current and previous key. (Related to the low priority wait option of ALTER TABLE and ALTER INDEX.),: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_RIn_X_LOW_PRIORITY', 
 'Occurs when a task is waiting to acquire an Exclusive lock with Low Priority on the current key value, and an Insert Range lock with Low Priority between the current and previous key. (Related to the low priority wait option of ALTER TABLE and ALTER INDEX.),: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_RS_S', 
 'Occurs when a task is waiting to acquire a Shared lock on the current key value, and a Shared Range lock between the current and previous key.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_RS_S_ABORT_BLOCKERS', 
 'Occurs when a task is waiting to acquire a Shared lock with Abort Blockers on the current key value, and a Shared Range lock with Abort Blockers between the current and previous key. (Related to the low priority wait option of ALTER TABLE and ALTER INDEX.),: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_RS_S_LOW_PRIORITY', 
 'Occurs when a task is waiting to acquire a Shared lock with Low Priority on the current key value, and a Shared Range lock with Low Priority between the current and previous key. (Related to the low priority wait option of ALTER TABLE and ALTER INDEX.),: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_RS_U', 
 'Occurs when a task is waiting to acquire an Update lock on the current key value, and an Update Range lock between the current and previous key.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_RS_U_ABORT_BLOCKERS', 
 'Occurs when a task is waiting to acquire an Update lock with Abort Blockers on the current key value, and an Update Range lock with Abort Blockers between the current and previous key. (Related to the low priority wait option of ALTER TABLE and ALTER INDEX.),: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_RS_U_LOW_PRIORITY', 
 'Occurs when a task is waiting to acquire an Update lock with Low Priority on the current key value, and an Update Range lock with Low Priority between the current and previous key. (Related to the low priority wait option of ALTER TABLE and ALTER INDEX.),: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_RX_S', 
 'Occurs when a task is waiting to acquire a Shared lock on the current key value, and an Exclusive Range lock between the current and previous key.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_RX_S_ABORT_BLOCKERS', 
 'Occurs when a task is waiting to acquire a Shared lock with Abort Blockers on the current key value, and an Exclusive Range with Abort Blockers lock between the current and previous key. (Related to the low priority wait option of ALTER TABLE and ALTER INDEX.),: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_RX_S_LOW_PRIORITY', 
 'Occurs when a task is waiting to acquire a Shared lock with Low Priority on the current key value, and an Exclusive Range with Low Priority lock between the current and previous key. (Related to the low priority wait option of ALTER TABLE and ALTER INDEX.),: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_RX_U', 
 'Occurs when a task is waiting to acquire an Update lock on the current key value, and an Exclusive range lock between the current and previous key.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_RX_U_ABORT_BLOCKERS', 
 'Occurs when a task is waiting to acquire an Update lock with Abort Blockers on the current key value, and an Exclusive range lock with Abort Blockers between the current and previous key. (Related to the low priority wait option of ALTER TABLE and ALTER INDEX.),: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_RX_U_LOW_PRIORITY', 
 'Occurs when a task is waiting to acquire an Update lock with Low Priority on the current key value, and an Exclusive range lock with Low Priority between the current and previous key. (Related to the low priority wait option of ALTER TABLE and ALTER INDEX.),: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_RX_X', 
 'Occurs when a task is waiting to acquire an Exclusive lock on the current key value, and an Exclusive Range lock between the current and previous key.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_RX_X_ABORT_BLOCKERS', 
 'Occurs when a task is waiting to acquire an Exclusive lock with Abort Blockers on the current key value, and an Exclusive Range lock with Abort Blockers between the current and previous key. (Related to the low priority wait option of ALTER TABLE and ALTER INDEX.),: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_RX_X_LOW_PRIORITY', 
 'Occurs when a task is waiting to acquire an Exclusive lock with Low Priority on the current key value, and an Exclusive Range lock with Low Priority between the current and previous key. (Related to the low priority wait option of ALTER TABLE and ALTER INDEX.),: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_S', 
 'Occurs when a task is waiting to acquire a Shared lock.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_S_ABORT_BLOCKERS', 
 'Occurs when a task is waiting to acquire a Shared lock with Abort Blockers. (Related to the low priority wait option of ALTER TABLE and ALTER INDEX.),: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_S_LOW_PRIORITY', 
 'Occurs when a task is waiting to acquire a Shared lock with Low Priority. (Related to the low priority wait option of ALTER TABLE and ALTER INDEX.),: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_SCH_M', 
 'Occurs when a task is waiting to acquire a Schema Modify lock.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_SCH_M_ABORT_BLOCKERS', 
 'Occurs when a task is waiting to acquire a Schema Modify lock with Abort Blockers. (Related to the low priority wait option of ALTER TABLE and ALTER INDEX.),: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_SCH_M_LOW_PRIORITY', 
 'Occurs when a task is waiting to acquire a Schema Modify lock with Low Priority. (Related to the low priority wait option of ALTER TABLE and ALTER INDEX.),: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_SCH_S', 
 'Occurs when a task is waiting to acquire a Schema Share lock.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_SCH_S_ABORT_BLOCKERS', 
 'Occurs when a task is waiting to acquire a Schema Share lock with Abort Blockers. (Related to the low priority wait option of ALTER TABLE and ALTER INDEX.),: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_SCH_S_LOW_PRIORITY', 
 'Occurs when a task is waiting to acquire a Schema Share lock with Low Priority. (Related to the low priority wait option of ALTER TABLE and ALTER INDEX.),: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_SIU', 
 'Occurs when a task is waiting to acquire a Shared With Intent Update lock.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_SIU_ABORT_BLOCKERS', 
 'Occurs when a task is waiting to acquire a Shared With Intent Update lock with Abort Blockers. (Related to the low priority wait option of ALTER TABLE and ALTER INDEX.),: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_SIU_LOW_PRIORITY', 
 'Occurs when a task is waiting to acquire a Shared With Intent Update lock with Low Priority. (Related to the low priority wait option of ALTER TABLE and ALTER INDEX.),: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_SIX', 
 'Occurs when a task is waiting to acquire a Shared With Intent Exclusive lock.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_SIX_ABORT_BLOCKERS', 
 'Occurs when a task is waiting to acquire a Shared With Intent Exclusive lock with Abort Blockers. (Related to the low priority wait option of ALTER TABLE and ALTER INDEX.),: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_SIX_LOW_PRIORITY', 
 'Occurs when a task is waiting to acquire a Shared With Intent Exclusive lock with Low Priority. (Related to the low priority wait option of ALTER TABLE and ALTER INDEX.),: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_U', 
 'Occurs when a task is waiting to acquire an Update lock.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_U_ABORT_BLOCKERS', 
 'Occurs when a task is waiting to acquire an Update lock with Abort Blockers. (Related to the low priority wait option of ALTER TABLE and ALTER INDEX.),: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_U_LOW_PRIORITY', 
 'Occurs when a task is waiting to acquire an Update lock with Low Priority. (Related to the low priority wait option of ALTER TABLE and ALTER INDEX.),: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_UIX', 
 'Occurs when a task is waiting to acquire an Update With Intent Exclusive lock.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_UIX_ABORT_BLOCKERS', 
 'Occurs when a task is waiting to acquire an Update With Intent Exclusive lock with Abort Blockers. (Related to the low priority wait option of ALTER TABLE and ALTER INDEX.),: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_UIX_LOW_PRIORITY', 
 'Occurs when a task is waiting to acquire an Update With Intent Exclusive lock with Low Priority. (Related to the low priority wait option of ALTER TABLE and ALTER INDEX.),: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_X', 
 'Occurs when a task is waiting to acquire an Exclusive lock.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_X_ABORT_BLOCKERS', 
 'Occurs when a task is waiting to acquire an Exclusive lock with Abort Blockers. (Related to the low priority wait option of ALTER TABLE and ALTER INDEX.),: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_X_LOW_PRIORITY', 
 'Occurs when a task is waiting to acquire an Exclusive lock with Low Priority. (Related to the low priority wait option of ALTER TABLE and ALTER INDEX.),: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LOG_POOL_SCAN', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LOG_RATE_GOVERNOR', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LOGBUFFER', 
 'Occurs when a task is waiting for space in the log buffer to store a log record. Consistently high values may indicate that the log devices cannot keep up with the amount of log being generated by the server.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LOGCAPTURE_LOGPOOLTRUNCPOINT', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LOGGENERATION', 
 'Identified for informational purposes only. Not supported. Future compatibility is not guaranteed.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LOGMGR', 
 'Occurs when a task is waiting for any outstanding log I/Os to finish before shutting down the log while closing the database.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LOGMGR_FLUSH', 
 'Identified for informational purposes only. Not supported. Future compatibility is not guaranteed.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LOGMGR_PMM_LOG', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LOGMGR_QUEUE', 
 'Occurs while the log writer task waits for work requests.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LOGMGR_RESERVE_APPEND', 
 'Occurs when a task is waiting to see whether log truncation frees up log space to enable the task to write a new log record. Consider increasing the size of the log file(s) for the affected database to reduce this wait.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LOGPOOL_CACHESIZE', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LOGPOOL_CONSUMER', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LOGPOOL_CONSUMERSET', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LOGPOOL_FREEPOOLS', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LOGPOOL_MGRSET', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LOGPOOL_REPLACEMENTSET', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LOGPOOLREFCOUNTEDOBJECT_REFDONE', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LOWFAIL_MEMMGR_QUEUE', 
 'Occurs while waiting for memory to be available for use.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('MD_AGENT_YIELD', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('MD_LAZYCACHE_RWLOCK', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('MEMORY_ALLOCATION_EXT', 
 'Occurs while allocating memory from either the internal SQL Server memory pool or the operation system.,: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('MEMORY_GRANT_UPDATE', 
 'TBD: Applies to: SQL Server 2017 (14.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('METADATA_LAZYCACHE_RWLOCK', 
 'TBD: Applies to: SQL Server 2008 R2 only.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('MIGRATIONBUFFER', 
 'TBD: Applies to: SQL Server 2017 (14.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('MISCELLANEOUS', 
 'Identified for informational purposes only. Not supported. Future compatibility is not guaranteed.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('MISCELLANEOUS', 
 'Identified for informational purposes only. Not supported. Future compatibility is not guaranteed.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('MSQL_DQ', 
 'Occurs when a task is waiting for a distributed query operation to finish. This is used to detect potential Multiple Active Result Set (MARS) application deadlocks. The wait ends when the distributed query call finishes.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('MSQL_XACT_MGR_MUTEX', 
 'Occurs when a task is waiting to obtain ownership of the session transaction manager to perform a session level transaction operation.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('MSQL_XACT_MUTEX', 
 'Occurs during synchronization of transaction usage. A request must acquire the mutex before it can --* USEthe transaction.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('MSQL_XP', 
 'Occurs when a task is waiting for an extended stored procedure to end. SQL Server uses this wait state to detect potential MARS application deadlocks. The wait stops when the extended stored procedure call ends.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('MSSEARCH', 
 'Occurs during Full-Text Search calls. This wait ends when the full-text operation completes. It does not indicate contention, but rather the duration of full-text operations.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('NET_WAITFOR_PACKET', 
 'Occurs when a connection is waiting for a network packet during a network read.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('NETWORKSXMLMGRLOAD', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('NODE_CACHE_MUTEX', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('OLEDB', 
 'Occurs when SQL Server calls the SQL Server Native Client OLE DB Provider. This wait type is not used for synchronization. Instead, it indicates the duration of calls to the OLE DB provider.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('ONDEMAND_TASK_QUEUE', 
 'Occurs while a background task waits for high priority system task requests. Long wait times indicate that there have been no high priority requests to process, and should not cause concern.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PAGEIOLATCH_DT', 
 'Occurs when a task is waiting on a latch for a buffer that is in an I/O request. The latch request is in Destroy mode. Long waits may indicate problems with the disk subsystem.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PAGEIOLATCH_EX', 
 'Occurs when a task is waiting on a latch for a buffer that is in an I/O request. The latch request is in Exclusive mode. Long waits may indicate problems with the disk subsystem.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PAGEIOLATCH_KP', 
 'Occurs when a task is waiting on a latch for a buffer that is in an I/O request. The latch request is in Keep mode. Long waits may indicate problems with the disk subsystem.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PAGEIOLATCH_NL', 
 'Identified for informational purposes only. Not supported. Future compatibility is not guaranteed.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PAGEIOLATCH_SH', 
 'Occurs when a task is waiting on a latch for a buffer that is in an I/O request. The latch request is in Shared mode. Long waits may indicate problems with the disk subsystem.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PAGEIOLATCH_UP', 
 'Occurs when a task is waiting on a latch for a buffer that is in an I/O request. The latch request is in Update mode. Long waits may indicate problems with the disk subsystem.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PAGELATCH_DT', 
 'Occurs when a task is waiting on a latch for a buffer that is not in an I/O request. The latch request is in Destroy mode.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PAGELATCH_EX', 
 'Occurs when a task is waiting on a latch for a buffer that is not in an I/O request. The latch request is in Exclusive mode.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PAGELATCH_KP', 
 'Occurs when a task is waiting on a latch for a buffer that is not in an I/O request. The latch request is in Keep mode.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PAGELATCH_NL', 
 'Identified for informational purposes only. Not supported. Future compatibility is not guaranteed.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PAGELATCH_SH', 
 'Occurs when a task is waiting on a latch for a buffer that is not in an I/O request. The latch request is in Shared mode.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PAGELATCH_UP', 
 'Occurs when a task is waiting on a latch for a buffer that is not in an I/O request. The latch request is in Update mode.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PARALLEL_BACKUP_QUEUE', 
 'Occurs when serializing output produced by RESTORE HEADERONLY, RESTORE FILELISTONLY, or RESTORE LABELONLY.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PARALLEL_REDO_DRAIN_WORKER', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PARALLEL_REDO_FLOW_CONTROL', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PARALLEL_REDO_LOG_CACHE', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PARALLEL_REDO_TRAN_LIST', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PARALLEL_REDO_TRAN_TURN', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PARALLEL_REDO_WORKER_SYNC', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PARALLEL_REDO_WORKER_WAIT_WORK', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PERFORMANCE_COUNTERS_RWLOCK', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PHYSICAL_SEEDING_DMV', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('POOL_LOG_RATE_GOVERNOR', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_ABR', 
 'Identified for informational purposes only. Not supported. Future compatibility is not guaranteed.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_AUDIT_ACCESS_EVENTLOG', 
 'Occurs when the SQL Server Operating System (SQLOS) scheduler switches to preemptive mode to write an audit event to the Windows event log.: Applies to: SQL Server 2008 R2 only.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_AUDIT_ACCESS_SECLOG', 
 'Occurs when the SQLOS scheduler switches to preemptive mode to write an audit event to the Windows Security log.: Applies to: SQL Server 2008 R2 only.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_CLOSEBACKUPMEDIA', 
 'Occurs when the SQLOS scheduler switches to preemptive mode to close backup media.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_CLOSEBACKUPTAPE', 
 'Occurs when the SQLOS scheduler switches to preemptive mode to close a tape backup device.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_CLOSEBACKUPVDIDEVICE', 
 'Occurs when the SQLOS scheduler switches to preemptive mode to close a virtual backup device.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_CLUSAPI_CLUSTERRESOURCECONTROL', 
 'Occurs when the SQLOS scheduler switches to preemptive mode to perform Windows failover cluster operations.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_COM_COCREATEINSTANCE', 
 'Occurs when the SQLOS scheduler switches to preemptive mode to create a COM object.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_COM_COGETCLASSOBJECT', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_COM_CREATEACCESSOR', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_COM_DELETEROWS', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_COM_GETCOMMANDTEXT', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_COM_GETDATA', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_COM_GETNEXTROWS', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_COM_GETRESULT', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_COM_GETROWSBYBOOKMARK', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_COM_LBFLUSH', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_COM_LBLOCKREGION', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_COM_LBREADAT', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_COM_LBSETSIZE', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_COM_LBSTAT', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_COM_LBUNLOCKREGION', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_COM_LBWRITEAT', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_COM_QUERYINTERFACE', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_COM_RELEASE', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_COM_RELEASEACCESSOR', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_COM_RELEASEROWS', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_COM_RELEASESESSION', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_COM_RESTARTPOSITION', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_COM_SEQSTRMREAD', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_COM_SEQSTRMREADANDWRITE', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_COM_SETDATAFAILURE', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_COM_SETPARAMETERINFO', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_COM_SETPARAMETERPROPERTIES', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_COM_STRMLOCKREGION', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_COM_STRMSEEKANDREAD', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_COM_STRMSEEKANDWRITE', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_COM_STRMSETSIZE', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_COM_STRMSTAT', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_COM_STRMUNLOCKREGION', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_CONSOLEWRITE', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_CREATEPARAM', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_DEBUG', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_DFSADDLINK', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_DFSLINKEXISTCHECK', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_DFSLINKHEALTHCHECK', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_DFSREMOVELINK', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_DFSREMOVEROOT', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_DFSROOTFOLDERCHECK', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_DFSROOTINIT', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_DFSROOTSHARECHECK', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_DTC_ABORT', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_DTC_ABORTREQUESTDONE', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_DTC_BEGINTRANSACTION', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_DTC_COMMITREQUESTDONE', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_DTC_ENLIST', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_DTC_PREPAREREQUESTDONE', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_FILESIZEGET', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_FSAOLEDB_ABORTTRANSACTION', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_FSAOLEDB_COMMITTRANSACTION', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_FSAOLEDB_STARTTRANSACTION', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_FSRECOVER_UNCONDITIONALUNDO', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_GETRMINFO', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_HADR_LEASE_MECHANISM', 
 'Always On Availability Groups lease manager scheduling for CSS diagnostics.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_HTTP_EVENT_WAIT', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_HTTP_REQUEST', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_LOCKMONITOR', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_MSS_RELEASE', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_ODBCOPS', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OLE_UNINIT', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OLEDB_ABORTORCOMMITTRAN', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OLEDB_ABORTTRAN', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OLEDB_GETDATASOURCE', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OLEDB_GETLITERALINFO', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OLEDB_GETPROPERTIES', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OLEDB_GETPROPERTYINFO', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OLEDB_GETSCHEMALOCK', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OLEDB_JOINTRANSACTION', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OLEDB_RELEASE', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OLEDB_SETPROPERTIES', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OLEDBOPS', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_ACCEPTSECURITYCONTEXT', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_ACQUIRECREDENTIALSHANDLE', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_AUTHENTICATIONOPS', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_AUTHORIZATIONOPS', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_AUTHZGETINFORMATIONFROMCONTEXT', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_AUTHZINITIALIZECONTEXTFROMSID', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_AUTHZINITIALIZERESOURCEMANAGER', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_BACKUPREAD', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_CLOSEHANDLE', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_CLUSTEROPS', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_COMOPS', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_COMPLETEAUTHTOKEN', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_COPYFILE', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_CREATEDIRECTORY', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_CREATEFILE', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_CRYPTACQUIRECONTEXT', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_CRYPTIMPORTKEY', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_CRYPTOPS', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_DECRYPTMESSAGE', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_DELETEFILE', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_DELETESECURITYCONTEXT', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_DEVICEIOCONTROL', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_DEVICEOPS', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_DIRSVC_NETWORKOPS', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_DISCONNECTNAMEDPIPE', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_DOMAINSERVICESOPS', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_DSGETDCNAME', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_DTCOPS', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_ENCRYPTMESSAGE', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_FILEOPS', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_FINDFILE', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_FLUSHFILEBUFFERS', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_FORMATMESSAGE', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_FREECREDENTIALSHANDLE', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_FREELIBRARY', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_GENERICOPS', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_GETADDRINFO', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_GETCOMPRESSEDFILESIZE', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_GETDISKFREESPACE', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_GETFILEATTRIBUTES', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_GETFILESIZE', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_GETFINALFILEPATHBYHANDLE', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_GETLONGPATHNAME', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_GETPROCADDRESS', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_GETVOLUMENAMEFORVOLUMEMOUNTPOINT', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_GETVOLUMEPATHNAME', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_INITIALIZESECURITYCONTEXT', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_LIBRARYOPS', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_LOADLIBRARY', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_LOGONUSER', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_LOOKUPACCOUNTSID', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_MESSAGEQUEUEOPS', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_MOVEFILE', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_NETGROUPGETUSERS', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_NETLOCALGROUPGETMEMBERS', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_NETUSERGETGROUPS', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_NETUSERGETLOCALGROUPS', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_NETUSERMODALSGET', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_NETVALIDATEPASSWORDPOLICY', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_NETVALIDATEPASSWORDPOLICYFREE', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_OPENDIRECTORY', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_PDH_WMI_INIT', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_PIPEOPS', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_PROCESSOPS', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_QUERYCONTEXTATTRIBUTES', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_QUERYREGISTRY', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_QUERYSECURITYCONTEXTTOKEN', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_REMOVEDIRECTORY', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_REPORTEVENT', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_REVERTTOSELF', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_RSFXDEVICEOPS', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_SECURITYOPS', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_SERVICEOPS', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_SETENDOFFILE', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_SETFILEPOINTER', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_SETFILEVALIDDATA', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_SETNAMEDSECURITYINFO', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_SQLCLROPS', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_SQMLAUNCH', 
 'TBD: Applies to: SQL Server 2008 R2 through SQL Server 2016 (13.x).'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_VERIFYSIGNATURE', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_VERIFYTRUST', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_VSSOPS', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_WAITFORSINGLEOBJECT', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_WINSOCKOPS', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_WRITEFILE', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_WRITEFILEGATHER', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_WSASETLASTERROR', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_REENLIST', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_RESIZELOG', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_ROLLFORWARDREDO', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_ROLLFORWARDUNDO', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_SB_STOPENDPOINT', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_SERVER_STARTUP', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_SETRMINFO', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_SHAREDMEM_GETDATA', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_SNIOPEN', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_SOSHOST', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_SOSTESTING', 
 'Identified for informational purposes only. Not supported. Future compatibility is not guaranteed.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_SP_SERVER_DIAGNOSTICS', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_STARTRM', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_STREAMFCB_CHECKPOINT', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_STREAMFCB_RECOVER', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_STRESSDRIVER', 
 'Identified for informational purposes only. Not supported. Future compatibility is not guaranteed.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_TESTING', 
 'Identified for informational purposes only. Not supported. Future compatibility is not guaranteed.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_TRANSIMPORT', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_UNMARSHALPROPAGATIONTOKEN', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_VSS_CREATESNAPSHOT', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_VSS_CREATEVOLUMESNAPSHOT', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_XE_CALLBACKEXECUTE', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_XE_CX_FILE_OPEN', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_XE_CX_HTTP_CALL', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_XE_DISPATCHER', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_XE_ENGINEINIT', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_XE_GETTARGETSTATE', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_XE_SESSIONCOMMIT', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_XE_TARGETFINALIZE', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_XE_TARGETINIT', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_XE_TIMERRUN', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_XETESTING', 
 'Identified for informational purposes only. Not supported. Future compatibility is not guaranteed.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PRINT_ROLLBACK_PROGRESS', 
 'Used to wait while user processes are ended in a database that has been transitioned by using the ALTER DATABASE termination clause. For more information, see ALTER DATABASE (Transact-SQL).'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PRU_ROLLBACK_DEFERRED', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PWAIT_ALL_COMPONENTS_INITIALIZED', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PWAIT_COOP_SCAN', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PWAIT_DIRECTLOGCONSUMER_GETNEXT', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PWAIT_EVENT_SESSION_INIT_MUTEX', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PWAIT_FABRIC_REPLICA_CONTROLLER_DATA_LOSS', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PWAIT_HADR_ACTION_COMPLETED', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PWAIT_HADR_CHANGE_NOTIFIER_TERMINATION_SYNC', 
 'Occurs when a background task is waiting for the termination of the background task that receives (via polling) Windows Server Failover Clustering notifications.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PWAIT_HADR_CLUSTER_INTEGRATION', 
 'An append, replace, and/or remove operation is waiting to grab a write lock on an Always On internal list (such as a list of networks, network addresses, or availability group listeners). Internal --* USEonly,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PWAIT_HADR_FAILOVER_COMPLETED', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PWAIT_HADR_JOIN', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PWAIT_HADR_OFFLINE_COMPLETED', 
 'An Always On drop availability group operation is waiting for the target availability group to go offline before destroying Windows Server Failover Clustering objects.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PWAIT_HADR_ONLINE_COMPLETED', 
 'An Always On create or failover availability group operation is waiting for the target availability group to come online.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PWAIT_HADR_POST_ONLINE_COMPLETED', 
 'An Always On drop availability group operation is waiting for the termination of any background task that was scheduled as part of a previous command. For example, there may be a background task that is transitioning availability databases to the primary role. The DROP AVAILABILITY GROUP DDL must wait for this background task to terminate in order to avoid race conditions.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PWAIT_HADR_SERVER_READY_CONNECTIONS', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PWAIT_HADR_WORKITEM_COMPLETED', 
 'Internal wait by a thread waiting for an async work task to complete. This is an expected wait and is for CSS use.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PWAIT_HADRSIM', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PWAIT_LOG_CONSOLIDATION_IO', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PWAIT_LOG_CONSOLIDATION_POLL', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PWAIT_MD_LOGIN_STATS', 
 'Occurs during internal synchronization in metadata on login stats.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PWAIT_MD_RELATION_CACHE', 
 'Occurs during internal synchronization in metadata on table or index.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PWAIT_MD_SERVER_CACHE', 
 'Occurs during internal synchronization in metadata on linked servers.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PWAIT_MD_UPGRADE_CONFIG', 
 'Occurs during internal synchronization in upgrading server wide configurations.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PWAIT_PREEMPTIVE_APP_USAGE_TIMER', 
 'TBD: Applies to: SQL Server 2017 (14.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PWAIT_PREEMPTIVE_AUDIT_ACCESS_WINDOWSLOG', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PWAIT_QRY_BPMEMORY', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PWAIT_REPLICA_ONLINE_INIT_MUTEX', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PWAIT_RESOURCE_SEMAPHORE_FT_PARALLEL_QUERY_SYNC', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PWAIT_SBS_FILE_OPERATION', 
 'TBD: Applies to: SQL Server 2017 (14.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PWAIT_XTP_FSSTORAGE_MAINTENANCE', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PWAIT_XTP_HOST_STORAGE_WAIT', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('QDS_ASYNC_CHECK_CONSISTENCY_TASK', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('QDS_ASYNC_PERSIST_TASK', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('QDS_ASYNC_PERSIST_TASK_START', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('QDS_ASYNC_QUEUE', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('QDS_BCKG_TASK', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('QDS_BLOOM_FILTER', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('QDS_CLEANUP_STALE_QUERIES_TASK_MAIN_LOOP_SLEEP', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('QDS_CTXS', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('QDS_DB_DISK', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('QDS_DYN_VECTOR', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('QDS_EXCLUSIVE_ACCESS', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('QDS_HOST_INIT', 
 'TBD: Applies to: SQL Server 2017 (14.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('QDS_LOADDB', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('QDS_PERSIST_TASK_MAIN_LOOP_SLEEP', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('QDS_QDS_CAPTURE_INIT', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('QDS_SHUTDOWN_QUEUE', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('QDS_STMT', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('QDS_STMT_DISK', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('QDS_TASK_SHUTDOWN', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('QDS_TASK_START', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('QE_WARN_LIST_SYNC', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('QPJOB_KILL', 
 'Indicates that an asynchronous automatic statistics update was canceled by a call to KILL as the update was starting to run. The terminating thread is suspended, waiting for it to start listening for KILL commands. A good value is less than one second.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('QPJOB_WAITFOR_ABORT', 
 'Indicates that an asynchronous automatic statistics update was canceled by a call to KILL when it was running. The update has now completed but is suspended until the terminating thread message coordination is complete. This is an ordinary but rare state, and should be very short. A good value is less than one second.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('QRY_MEM_GRANT_INFO_MUTEX', 
 'Occurs when Query Execution memory management tries to control access to static grant information list. This state lists information about the current granted and waiting memory requests. This state is a simple access control state. There should never be a long wait on this state. If this mutex is not released, all new memory-using queries will stop responding.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('QRY_PARALLEL_THREAD_MUTEX', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('QRY_PROFILE_LIST_MUTEX', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('QUERY_ERRHDL_SERVICE_DONE', 
 'Identified for informational purposes only. Not supported.: Applies to: SQL Server 2008 R2 only.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('QUERY_WAIT_ERRHDL_SERVICE', 
 'Identified for informational purposes only. Not supported.: Applies to: SQL Server 2008 R2 only.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('QUERY_EXECUTION_INDEX_SORT_EVENT_OPEN', 
 'Occurs in certain cases when offline create index build is run in parallel, and the different worker threads that are sorting synchronize access to the sort files.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('QUERY_NOTIFICATION_MGR_MUTEX', 
 'Occurs during synchronization of the garbage collection queue in the Query Notification Manager.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('QUERY_NOTIFICATION_SUBSCRIPTION_MUTEX', 
 'Occurs during state synchronization for transactions in Query Notifications.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('QUERY_NOTIFICATION_TABLE_MGR_MUTEX', 
 'Occurs during internal synchronization within the Query Notification Manager.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('QUERY_NOTIFICATION_UNITTEST_MUTEX', 
 'Identified for informational purposes only. Not supported. Future compatibility is not guaranteed.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('QUERY_OPTIMIZER_PRINT_MUTEX', 
 'Occurs during synchronization of query optimizer diagnostic output production. This wait type only occurs if diagnostic settings have been enabled under direction of Microsoft Product Support.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('QUERY_TASK_ENQUEUE_MUTEX', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('QUERY_TRACEOUT', 
 'Identified for informational purposes only. Not supported. Future compatibility is not guaranteed.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('RBIO_WAIT_VLF', 
 'TBD: Applies to: SQL Server 2017 (14.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('RECOVER_CHANGEDB', 
 'Occurs during synchronization of database status in warm standby database.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('RECOVERY_MGR_LOCK', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('REDO_THREAD_PENDING_WORK', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('REDO_THREAD_SYNC', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('REMOTE_BLOCK_IO', 
 'TBD: Applies to: SQL Server 2017 (14.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('REMOTE_DATA_ARCHIVE_MIGRATION_DMV', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('REMOTE_DATA_ARCHIVE_SCHEMA_DMV', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('REMOTE_DATA_ARCHIVE_SCHEMA_TASK_QUEUE', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('REPL_CACHE_ACCESS', 
 'Occurs during synchronization on a replication article cache. During these waits, the replication log reader stalls, and data definition language (DDL) statements on a published table are blocked.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('REPL_HISTORYCACHE_ACCESS', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('REPL_SCHEMA_ACCESS', 
 'Occurs during synchronization of replication schema version information. This state exists when DDL statements are executed on the replicated object, and when the log reader builds or consumes versioned schema based on DDL occurrence. Contention can be seen on this wait type if you have many published databases on a single publisher with transactional replication and the published databases are very active.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('REPL_TRANFSINFO_ACCESS', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('REPL_TRANHASHTABLE_ACCESS', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('REPL_TRANTEXTINFO_ACCESS', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('REPLICA_WRITES', 
 'Occurs while a task waits for completion of page writes to database snapshots or DBCC replicas.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('REQUEST_DISPENSER_PAUSE', 
 'Occurs when a task is waiting for all outstanding I/O to complete, so that I/O to a file can be frozen for snapshot backup.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('REQUEST_FOR_DEADLOCK_SEARCH', 
 'Occurs while the deadlock monitor waits to start the next deadlock search. This wait is expected between deadlock detections, and lengthy total waiting time on this resource does not indicate a problem.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('RESERVED_MEMORY_ALLOCATION_EXT', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('RESMGR_THROTTLED', 
 'Occurs when a new request comes in and is throttled based on the GROUP_MAX_REQUESTS setting.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('RESOURCE_GOVERNOR_IDLE', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('RESOURCE_QUEUE', 
 'Occurs during synchronization of various internal resource queues.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('RESOURCE_SEMAPHORE', 
 'Occurs when a query memory request cannot be granted immediately due to other concurrent queries. High waits and wait times may indicate excessive number of concurrent queries, or excessive memory request amounts.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('RESOURCE_SEMAPHORE_MUTEX', 
 'Occurs while a query waits for its request for a thread reservation to be fulfilled. It also occurs when synchronizing query compile and memory grant requests.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('RESOURCE_SEMAPHORE_QUERY_COMPILE', 
 'Occurs when the number of concurrent query compilations reaches a throttling limit. High waits and wait times may indicate excessive compilations, recompiles, or uncachable plans.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('RESOURCE_SEMAPHORE_SMALL_QUERY', 
 'Occurs when memory request by a small query cannot be granted immediately due to other concurrent queries. Wait time should not exceed more than a few seconds, because the server transfers the request to the main query memory pool if it fails to grant the requested memory within a few seconds. High waits may indicate an excessive number of concurrent small queries while the main memory pool is blocked by waiting queries.: Applies to: SQL Server 2008 R2 only.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('RESTORE_FILEHANDLECACHE_ENTRYLOCK', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('RESTORE_FILEHANDLECACHE_LOCK', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('RG_RECONFIG', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('ROWGROUP_OP_STATS', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('ROWGROUP_VERSION', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('RTDATA_LIST', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SATELLITE_CARGO', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SATELLITE_SERVICE_SETUP', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SATELLITE_TASK', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SBS_DISPATCH', 
 'TBD: Applies to: SQL Server 2017 (14.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SBS_RECEIVE_TRANSPORT', 
 'TBD: Applies to: SQL Server 2017 (14.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SBS_TRANSPORT', 
 'TBD: Applies to: SQL Server 2017 (14.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SCAN_CHAR_HASH_ARRAY_INITIALIZATION', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SEC_DROP_TEMP_KEY', 
 'Occurs after a failed attempt to drop a temporary security key before a retry attempt.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SECURITY_CNG_PROVIDER_MUTEX', 
 'TBD: Applies to: SQL Server 2017 (14.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SECURITY_CRYPTO_CONTEXT_MUTEX', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SECURITY_DBE_STATE_MUTEX', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SECURITY_KEYRING_RWLOCK', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SECURITY_MUTEX', 
 'Occurs when there is a wait for mutexes that control access to the global list of Extensible Key Management (EKM) cryptographic providers and the session-scoped list of EKM sessions.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SECURITY_RULETABLE_MUTEX', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SEMPLAT_DSI_BUILD', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SEQUENCE_GENERATION', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SEQUENTIAL_GUID', 
 'Occurs while a new sequential GUID is being obtained.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SERVER_IDLE_CHECK', 
 'Occurs during synchronization of SQL Server instance idle status when a resource monitor is attempting to declare a SQL Server instance as idle or trying to wake up.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SERVER_RECONFIGURE', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SESSION_WAIT_STATS_CHILDREN', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SHARED_DELTASTORE_CREATION', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SHUTDOWN', 
 'Occurs while a shutdown statement waits for active connections to exit.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SLEEP_BPOOL_FLUSH', 
 'Occurs when a checkpoint is throttling the issuance of new I/Os in order to avoid flooding the disk subsystem.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SLEEP_BUFFERPOOL_HELPLW', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SLEEP_DBSTARTUP', 
 'Occurs during database startup while waiting for all databases to recover.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SLEEP_DCOMSTARTUP', 
 'Occurs once at most during SQL Server instance startup while waiting for DCOM initialization to complete.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SLEEP_MASTERDBREADY', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SLEEP_MASTERMDREADY', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SLEEP_MASTERUPGRADED', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SLEEP_MEMORYPOOL_ALLOCATEPAGES', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SLEEP_MSDBSTARTUP', 
 'Occurs when SQL Trace waits for the msdb database to complete startup.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SLEEP_RETRY_VIRTUALALLOC', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SLEEP_SYSTEMTASK', 
 'Occurs during the start of a background task while waiting for tempdb to complete startup.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SLEEP_TASK', 
 'Occurs when a task sleeps while waiting for a generic event to occur.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SLEEP_TEMPDBSTARTUP', 
 'Occurs while a task waits for tempdb to complete startup.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SLEEP_WORKSPACE_ALLOCATEPAGE', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SLO_UPDATE', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SMSYNC', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SNI_CONN_DUP', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SNI_CRITICAL_SECTION', 
 'Occurs during internal synchronization within SQL Server networking components.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SNI_HTTP_WAITFOR_0_DISCON', 
 'Occurs during SQL Server shutdown, while waiting for outstanding HTTP connections to exit.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SNI_LISTENER_ACCESS', 
 'Occurs while waiting for non-uniform memory access (NUMA) nodes to update state change. Access to state change is serialized.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SNI_TASK_COMPLETION', 
 'Occurs when there is a wait for all tasks to finish during a NUMA node state change.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SNI_WRITE_ASYNC', 
 'TBD: Applies to: SQL Server 2017 (14.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SOAP_READ', 
 'Occurs while waiting for an HTTP network read to complete.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SOAP_WRITE', 
 'Occurs while waiting for an HTTP network write to complete.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SOCKETDUPLICATEQUEUE_CLEANUP', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SOS_CALLBACK_REMOVAL', 
 'Occurs while performing synchronization on a callback list in order to remove a callback. It is not expected for this counter to change after server initialization is completed.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SOS_DISPATCHER_MUTEX', 
 'Occurs during internal synchronization of the dispatcher pool. This includes when the pool is being adjusted.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SOS_LOCALALLOCATORLIST', 
 'Occurs during internal synchronization in the SQL Server memory manager.: Applies to: SQL Server 2008 R2 only.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SOS_MEMORY_TOPLEVELBLOCKALLOCATOR', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SOS_MEMORY_USAGE_ADJUSTMENT', 
 'Occurs when memory usage is being adjusted among pools.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SOS_OBJECT_STORE_DESTROY_MUTEX', 
 'Occurs during internal synchronization in memory pools when destroying objects from the pool.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SOS_PHYS_PAGE_CACHE', 
 'Accounts for the time a thread waits to acquire the mutex it must acquire before it allocates physical pages or before it returns those pages to the operating system. Waits on this type only appear if the instance of SQL Server uses AWE memory.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SOS_PROCESS_AFFINITY_MUTEX', 
 'Occurs during synchronizing of access to process affinity settings.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SOS_RESERVEDMEMBLOCKLIST', 
 'Occurs during internal synchronization in the SQL Server memory manager.: Applies to: SQL Server 2008 R2 only.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SOS_SCHEDULER_YIELD', 
 'Occurs when a task voluntarily yields the scheduler for other tasks to execute. During this wait the task is waiting for its quantum to be renewed.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SOS_SMALL_PAGE_ALLOC', 
 'Occurs during the allocation and freeing of memory that is managed by some memory objects.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SOS_STACKSTORE_INIT_MUTEX', 
 'Occurs during synchronization of internal store initialization.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SOS_SYNC_TASK_ENQUEUE_EVENT', 
 'Occurs when a task is started in a synchronous manner. Most tasks in SQL Server are started in an asynchronous manner, in which control returns to the starter immediately after the task request has been placed on the work queue.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SOS_VIRTUALMEMORY_LOW', 
 'Occurs when a memory allocation waits for a resource manager to free up virtual memory.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SOSHOST_EVENT', 
 'Occurs when a hosted component, such as CLR, waits on a SQL Server event synchronization object.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SOSHOST_INTERNAL', 
 'Occurs during synchronization of memory manager callbacks used by hosted components, such as CLR.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SOSHOST_MUTEX', 
 'Occurs when a hosted component, such as CLR, waits on a SQL Server mutex synchronization object.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SOSHOST_RWLOCK', 
 'Occurs when a hosted component, such as CLR, waits on a SQL Server reader-writer synchronization object.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SOSHOST_SEMAPHORE', 
 'Occurs when a hosted component, such as CLR, waits on a SQL Server semaphore synchronization object.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SOSHOST_SLEEP', 
 'Occurs when a hosted task sleeps while waiting for a generic event to occur. Hosted tasks are used by hosted components such as CLR.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SOSHOST_TRACELOCK', 
 'Occurs during synchronization of access to trace streams.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SOSHOST_WAITFORDONE', 
 'Occurs when a hosted component, such as CLR, waits for a task to complete.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SP_PREEMPTIVE_SERVER_DIAGNOSTICS_SLEEP', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SP_SERVER_DIAGNOSTICS_BUFFER_ACCESS', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SP_SERVER_DIAGNOSTICS_INIT_MUTEX', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SP_SERVER_DIAGNOSTICS_SLEEP', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SQLCLR_APPDOMAIN', 
 'Occurs while CLR waits for an application domain to complete startup.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SQLCLR_ASSEMBLY', 
 'Occurs while waiting for access to the loaded assembly list in the appdomain.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SQLCLR_DEADLOCK_DETECTION', 
 'Occurs while CLR waits for deadlock detection to complete.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SQLCLR_QUANTUM_PUNISHMENT', 
 'Occurs when a CLR task is throttled because it has exceeded its execution quantum. This throttling is done in order to reduce the effect of this resource-intensive task on other tasks.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SQLSORT_NORMMUTEX', 
 'Occurs during internal synchronization, while initializing internal sorting structures.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SQLSORT_SORTMUTEX', 
 'Occurs during internal synchronization, while initializing internal sorting structures.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SQLTRACE_BUFFER_FLUSH', 
 'Occurs when a task is waiting for a background task to flush trace buffers to disk every four seconds.: Applies to: SQL Server 2008 R2 only.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SQLTRACE_FILE_BUFFER', 
 'Occurs during synchronization on trace buffers during a file trace.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SQLTRACE_FILE_READ_IO_COMPLETION', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SQLTRACE_FILE_WRITE_IO_COMPLETION', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SQLTRACE_INCREMENTAL_FLUSH_SLEEP', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SQLTRACE_LOCK', 
 'TBD: APPLIES TO: SQL Server 2008 R2 only.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SQLTRACE_PENDING_BUFFER_WRITERS', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SQLTRACE_SHUTDOWN', 
 'Occurs while trace shutdown waits for outstanding trace events to complete.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SQLTRACE_WAIT_ENTRIES', 
 'Occurs while a SQL Trace event queue waits for packets to arrive on the queue.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SRVPROC_SHUTDOWN', 
 'Occurs while the shutdown process waits for internal resources to be released to shutdown cleanly.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('STARTUP_DEPENDENCY_MANAGER', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('TDS_BANDWIDTH_STATE', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('TDS_INIT', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
SET NOCOUNT OFF;PRINT '--- "D:\dev\SQL\DFINAnalytics\create_DFS_WaitTypes_TableAndPopulate.sql"' 
PRINT '--- "D:\dev\SQL\DFINAnalytics\create_DFS_WaitTypes_TableAndPopulate.sql"' 


/****************** PROCESSING FILE *************************************/

GO  
PRINT 'ID# 80'  
print 'D:\dev\SQL\DFINAnalytics\DMV_SuggestMissingIndexes.sql' 
/*
-- W. Dale Miller
-- @ July 26, 2016
--DMV_SuggestMissingIndexes.sql
--The indexing related DMVs store statistics that SQL Server uses recommend 
--indexes that could offer performance benefits, based on previously executed queries.
--Do not add these indexes blindly. I would review and question each index suggested. 
--Included column my come with a high cost of maintaining duplicate data.
-- Missing Indexes DMV Suggestions 
*/

/*
DECLARE @Command NVARCHAR(200);
set @Command = '--* USE?; exec sp_DFS_SuggestMissingIndexes ;';
exec sp_msForEachDb @Command;
*/
-- drop table DFS_MissingIndexes
--* USEDFINAnalytics;
GO
IF NOT EXISTS
(
    SELECT 1
    FROM sys.tables
    WHERE name = 'DFS_MissingIndexes'
)
    BEGIN
 CREATE TABLE [dbo].[DFS_MissingIndexes]
 ([ServerName] [NVARCHAR](150) NULL, 
  [DBName]   [NVARCHAR](150) NULL, 
  [Affected_table]  [SYSNAME] NOT NULL, 
  [K]   [INT] NULL, 
  [Keys]     [NVARCHAR](4000) NULL, 
  [INCLUDE]  [NVARCHAR](4000) NULL, 
  [sql_statement]   [NVARCHAR](4000) NULL, 
  [user_seeks] [BIGINT] NOT NULL, 
  [user_scans] [BIGINT] NOT NULL, 
  [est_impact] [BIGINT] NULL, 
  [avg_user_impact] [FLOAT] NULL, 
  [last_user_seek]  [DATETIME] NULL, 
  [SecondsUptime]   [INT] NULL, 
  CreateDate DATETIME DEFAULT GETDATE(),
		 [UID] uniqueidentifier default newid(), 
  RowNbr     INT IDENTITY(1, 1) NOT NULL
 )
 ON [PRIMARY];
 CREATE INDEX idxDFS_SuggestMissingIndexes ON DFS_MissingIndexes(DBName, Affected_table);
END;
GO

--* USEmaster;
GO

IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'sp_DFS_SuggestMissingIndexes'
)
    DROP PROCEDURE sp_DFS_SuggestMissingIndexes;
GO
-- exec sp_DFS_SuggestMissingIndexes;
CREATE PROCEDURE sp_DFS_SuggestMissingIndexes
AS
    BEGIN
 PRINT 'INSIDE: ' + DB_NAME();
 INSERT INTO [dbo].[DFS_MissingIndexes]
 ([ServerName], 
  [DBName], 
  [Affected_table], 
  [K], 
  [Keys], 
  [INCLUDE], 
  [sql_statement], 
  [user_seeks], 
  [user_scans], 
  [est_impact], 
  [avg_user_impact], 
  [last_user_seek], 
  [SecondsUptime], 
  [CreateDate]
 )
   SELECT @@ServerName AS ServerName, 
   DB_NAME() AS DBName, 
   t.name AS 'Affected_table', 
   LEN(ISNULL(ddmid.equality_columns, N'') + CASE
  WHEN ddmid.equality_columns IS NOT NULL
     AND ddmid.inequality_columns IS NOT NULL
  THEN ','
  ELSE ''
   END) - LEN(REPLACE(ISNULL(ddmid.equality_columns, N'') + CASE
     WHEN ddmid.equality_columns IS NOT NULL
   AND ddmid.inequality_columns IS NOT NULL
     THEN ','
     ELSE ''
      END, ',', '')) + 1 AS K, 
   COALESCE(ddmid.equality_columns, '') + CASE
    WHEN ddmid.equality_columns IS NOT NULL
    AND ddmid.inequality_columns IS NOT NULL
    THEN ','
    ELSE ''
  END + COALESCE(ddmid.inequality_columns, '') AS Keys, 
   COALESCE(ddmid.included_columns, '') AS INCLUDE, 
   'Create NonClustered Index IX_' + t.name + '_missing_' + CAST(ddmid.index_handle AS VARCHAR(20)) + ' On ' + ddmid.[statement] COLLATE database_default + ' (' + ISNULL(ddmid.equality_columns, '') + CASE
         WHEN ddmid.equality_columns IS NOT NULL
       AND ddmid.inequality_columns IS NOT NULL
         THEN ','
         ELSE ''
     END + ISNULL(ddmid.inequality_columns, '') + ')' + ISNULL(' Include (' + ddmid.included_columns + ');', ';') AS sql_statement, 
   ddmigs.user_seeks, 
   ddmigs.user_scans, 
   CAST((ddmigs.user_seeks + ddmigs.user_scans) * ddmigs.avg_user_impact AS BIGINT) AS 'est_impact', 
   avg_user_impact, 
   ddmigs.last_user_seek, 
   (
     SELECT DATEDIFF(Second, create_date, GETDATE()) Seconds
     FROM sys.databases
     WHERE name = 'tempdb'
   ) SecondsUptime, 
   GETDATE()
   FROM sys.dm_db_missing_index_groups ddmig
 INNER JOIN sys.dm_db_missing_index_group_stats ddmigs ON ddmigs.group_handle = ddmig.index_group_handle
 INNER JOIN sys.dm_db_missing_index_details ddmid ON ddmig.index_handle = ddmid.index_handle
 INNER JOIN sys.tables t ON ddmid.OBJECT_ID = t.OBJECT_ID
   WHERE ddmid.database_id = DB_ID()
   ORDER BY est_impact DESC;
 DELETE FROM [dbo].[DFS_MissingIndexes]
 WHERE [DBName] IN('msdb', 'model', 'tempdb', 'master', 'dba');
    END;
	GO

--************************************************************************
-- select * from dbo.DFS_MissingIndexes ;
PRINT '--- "D:\dev\SQL\DFINAnalytics\DMV_SuggestMissingIndexes.sql"' 


/****************** PROCESSING FILE *************************************/

GO  
PRINT 'ID# 90'  
print 'D:\dev\SQL\DFINAnalytics\DMV_SuggestMissingFKIndexes.sql' 

/*
-- --* USEBNYUK_ProductionAR_Port
-- W. Dale Miller
-- @ July 26, 2016
--As a general best practice, it is recommended to have an index associated 
--with each foreign key. This facilitates faster table joins, which are 
--typically joined on foreign key columns anyway. Indexes on foreign keys 
--also facilitate faster deletes. If these supporting indexes are missing, 
--SQL will perform a table scale on the related table each time a record in 
--the first table is deleted.
-- Foreign Keys missing indexes 
-- Note this script only works for creating single column indexes. 
-- Multiple FK columns are out of scope for this script. 
*/
/*
DECLARE @Command NVARCHAR(200);
SET @Command = '--* USE?; exec sp_DFS_FindMissingFKIndexes ;';
EXEC sp_msForEachDb @Command;
GO
*/
/** USEDFINAnalytics;*/

GO

/*
drop TABLE [dbo].[DFS_MissingFKIndexes];
*/

IF EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.tables
    WHERE table_name = 'DFS_MissingFKIndexes'
)
    DROP TABLE [dbo].[DFS_MissingFKIndexes];
CREATE TABLE [dbo].[DFS_MissingFKIndexes]
(SVR             [NVARCHAR](150) NULL, 
 [DBName]        [NVARCHAR](150) NULL, 
 SSVER           [NVARCHAR](250) NULL, 
 [FK_Constraint] [SYSNAME] NOT NULL, 
 [FK_Table]      [SYSNAME] NOT NULL, 
 [FK_Column]     [NVARCHAR](150) NULL, 
 [ParentTable]   [SYSNAME] NOT NULL, 
 [ParentColumn]  [NVARCHAR](150) NULL, 
 [IndexName]     [SYSNAME] NULL, 
 [SQL]           [NVARCHAR](1571) NULL, 
 [CreateDate]    [DATETIME] NOT NULL, 
 [UID]           UNIQUEIDENTIFIER DEFAULT NEWID()
)
ON [PRIMARY];
CREATE INDEX pi_DFS_MissingFKIndexes
ON DFS_MissingFKIndexes
([UID]
);

/** USEmaster;*/

GO
IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'sp_DFS_FindMissingFKIndexes'
)
    BEGIN
        DROP PROCEDURE sp_DFS_FindMissingFKIndexes;
END;
GO

/* drop table dbo..DFS_MissingFKIndexes*/

CREATE PROCEDURE sp_DFS_FindMissingFKIndexes
AS
    BEGIN
        PRINT 'INSIDE: ' + DB_NAME();
        INSERT INTO dbo.DFS_MissingFKIndexes
               SELECT @@servername AS SVR, 
                      DB_NAME() AS DBName, 
                      @@VERSION AS SSVER, 
                      rc.Constraint_Name AS FK_Constraint,

                      /* rc.Constraint_Catalog AS FK_Database, rc.Constraint_Schema AS FKSch, */
                      ccu.Table_Name AS FK_Table, 
                      ccu.Column_Name AS FK_Column, 
                      ccu2.Table_Name AS ParentTable, 
                      ccu2.Column_Name AS ParentColumn, 
                      I.Name AS IndexName,
                      CASE
                          WHEN I.Name IS NULL
                          THEN 'IF NOT EXISTS (SELECT * FROM sys.indexes
	   WHERE object_id = OBJECT_ID(N''' + RC.Constraint_Schema + '.' + ccu.Table_Name + ''') AND name = N''IX_' + ccu.Table_Name + '_' + ccu.Column_Name + ''') ' + 'CREATE NONCLUSTERED INDEX IX_' + ccu.Table_Name + '_' + ccu.Column_Name + ' ON ' + rc.Constraint_Schema + '.' + ccu.Table_Name + '( ' + ccu.Column_Name + ' ASC ) WITH (PAD_INDEX = OFF, 
	  STATISTICS_NORECOMPUTE = OFF,
	  SORT_IN_TEMPDB = ON, IGNORE_DUP_KEY = OFF,
	  DROP_EXISTING = OFF, ONLINE = ON);'
                          ELSE ''
                      END AS SQL, 
                      GETDATE() AS CreateDate, 
                      NEWID() AS [UID]
               FROM information_schema.referential_constraints AS RC
                         JOIN INFORMATION_SCHEMA.CONSTRAINT_COLUMN_USAGE AS ccu
                         ON rc.CONSTRAINT_NAME = ccu.CONSTRAINT_NAME
                              JOIN INFORMATION_SCHEMA.CONSTRAINT_COLUMN_USAGE AS ccu2
                         ON rc.UNIQUE_CONSTRAINT_NAME = ccu2.CONSTRAINT_NAME
                                   LEFT JOIN sys.columns AS c
                         ON ccu.Column_Name = C.name
                            AND ccu.Table_Name = OBJECT_NAME(C.OBJECT_ID)
                                        LEFT JOIN sys.index_columns AS ic
                         ON C.OBJECT_ID = IC.OBJECT_ID
                            AND c.column_id = ic.column_id
                            AND index_column_id = 1
                                             LEFT JOIN sys.indexes AS i
                         ON IC.OBJECT_ID = i.OBJECT_ID
                            AND ic.index_Id = i.index_Id
               WHERE I.name IS NULL
               ORDER BY FK_table, 
                        ParentTable, 
                        ParentColumn;
        DELETE FROM [dbo].DFS_MissingFKIndexes
        WHERE [DBName] IN('msdb', 'model', 'tempdb', 'master', 'dba');
    END;
GO

/****************** PROCESSING FILE *************************************/

GO  
PRINT 'ID# 100'  
print 'D:\dev\SQL\DFINAnalytics\DMV_TableReadsAndWrites.sql' 

/*
--DMV_TableReadsAndWrites.sql
Developed W. Dale Miller 
Copyright @DMA, Ltd, July 26, 2012 all rights reserved.
Licensed under the MIT Open Code License
Free to --* USEas long as the copyright is retained in the code.
*/
/* exec sp_UTIL_TrackTblReadsWrites */
--* USEDFINAnalytics;
GO

/* drop table [DFS_TableReadWrites]*/

IF NOT EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.TABLES
    WHERE TABLE_NAME = 'DFS_TableReadWrites'
)
    BEGIN
 CREATE TABLE [dbo].[DFS_TableReadWrites]
 ([ServerName]    [NVARCHAR](150) NULL, 
  [DBName] [NVARCHAR](150) NULL, 
  [TableName]     [NVARCHAR](150) NULL, 
  [Reads]  [BIGINT] NULL, 
  [Writes] [BIGINT] NULL, 
  [Reads&Writes]  [BIGINT] NULL, 
  [SampleDays]    [NUMERIC](18, 7) NULL, 
  [SampleSeconds] [INT] NULL, 
  [RunDate]  [DATETIME] NOT NULL, 
  [SSVER]  [NVARCHAR](250) NULL, 
  [RowID]  [BIGINT] IDENTITY(1, 1) NOT NULL, 
  [UID]    [UNIQUEIDENTIFIER] NULL, 
  [RunID]  [INT] NULL
 )
 ON [PRIMARY];
 CREATE INDEX idxDFS_TableReadWrites
 ON DFS_TableReadWrites
 ([DBName], [TableName]
 );
END;
GO

if not exists (Select 1 from information_schema.columns where table_name = 'DFS_TableReadWrites' and COLUMN_NAME = 'UID')
begin 
	alter table DFS_TableReadWrites add [UID] uniqueidentifier null default newid();
end 

if not exists (Select 1 from information_schema.columns where table_name = 'DFS_TableReadWrites' and COLUMN_NAME = 'RunID')
begin 
	alter table DFS_TableReadWrites add [RunID] int null ;
end 


--* USEmaster;
GO
IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'sp_UTIL_TrackTblReadsWrites'
)
    BEGIN
 DROP PROCEDURE sp_UTIL_TrackTblReadsWrites;
END;
GO

/*
-- Table Reads and Writes 
-- Heap tables out of scope for this query. Heaps do not have indexes. 
-- Only lists tables referenced since the last server restart 
-- exec sp_UTIL_TrackTblReadsWrites

--JOB_UTIL_TrackTblReadsWrites
DECLARE @RunID BIGINT;
EXEC @RunID = dbo.UTIL_GetSeq;
PRINT @RunID;
DECLARE @command VARCHAR(1000);
SELECT @command = '--* USE?; declare @DB as int = DB_ID() ; print db_name(); exec master.dbo.sp_UTIL_TrackTblReadsWrites ' + CAST(@RunID AS NVARCHAR(25)) + ' ;';
EXEC master.sys.sp_MSforeachdb @command;
*/
/* select * from DFS_TableReadWrites*/

--* USEmaster;
GO
CREATE PROCEDURE sp_UTIL_TrackTblReadsWrites(@RunID INT)
AS
     IF DB_NAME() IN('master', 'tempdb', 'msdb', 'model', 'DBA')
  BEGIN
 PRINT 'Skipping DB : ' + DB_NAME();
 RETURN;
     END;
    BEGIN
 EXEC dbo.UTIL_RecordCount 
 'sp_UTIL_TrackTblReadsWrites';
 PRINT 'Processing DB : ' + DB_NAME();
 DECLARE @i AS INT;
 SET @i =
 (
     SELECT COUNT(*)
     FROM dbo.[DFS_TableReadWrites]
 );
 PRINT 'Starting rows: ' + CAST(@i AS NVARCHAR(15));
 INSERT INTO dbo.[DFS_TableReadWrites]
 ( [ServerName], 
   [DBName], 
   [TableName], 
   [Reads], 
   [Writes], 
   [Reads&Writes], 
   [SampleDays], 
   [SampleSeconds], 
   [RunDate], 
   SSVER, 
   [UID], 
   RunID
 ) 
   SELECT @@ServerName AS ServerName, 
   DB_NAME() AS DBName, 
   OBJECT_NAME(ddius.object_id) AS TableName, 
   SUM(ddius.user_seeks + ddius.user_scans + ddius.user_lookups) AS Reads, 
   SUM(ddius.user_updates) AS Writes, 
   SUM(ddius.user_seeks + ddius.user_scans + ddius.user_lookups + ddius.user_updates) AS [Reads&Writes], 
   (
     SELECT DATEDIFF(s, create_date, GETDATE()) / 86400.0
     FROM sys.databases
     WHERE name = 'tempdb'
   ) AS SampleDays, 
   (
     SELECT DATEDIFF(s, create_date, GETDATE()) AS SecoundsRunnig
     FROM sys.databases
     WHERE name = 'tempdb'
   ) AS SampleSeconds, 
   GETDATE() AS RunDate, 
   @@version AS SSVER, 
   NEWID() AS [UID], 
   @RunID AS RunID
   FROM sys.dm_db_index_usage_stats ddius
    INNER JOIN sys.indexes i
    ON ddius.object_id = i.object_id
  AND i.index_id = ddius.index_id
   WHERE OBJECTPROPERTY(ddius.object_id, 'IsUserTable') = 1
  AND ddius.database_id = DB_ID()
   GROUP BY OBJECT_NAME(ddius.object_id)
   ORDER BY [Reads&Writes] DESC;
 SET @i =
 (
     SELECT COUNT(*)
     FROM dbo.[DFS_TableReadWrites]
 );
 PRINT 'Ending rows: ' + CAST(@i AS NVARCHAR(15));
    END;
GO
--* USEDFINAnalytics;
GO
IF EXISTS
(
    SELECT table_name
    FROM INFORMATION_SCHEMA.tables
    WHERE TABLE_NAME = 'vTrackTblReadsWrites'
)
    BEGIN
 DROP VIEW dbo.vTrackTblReadsWrites;
END;
GO
CREATE VIEW dbo.vTrackTblReadsWrites
AS
     SELECT [ServerName], 
     [DBName], 
     [TableName], 
     [Reads], 
     [Writes], 
     [Reads&Writes], 
     [SampleDays], 
     [SampleSeconds], 
     [RunDate], 
     [UID], 
     [RowID]
     FROM [dbo].[DFS_TableReadWrites];

/*order BY TableName, 
  RunDate, 
  DBName, 
  ServerName;*/

GO

/* W. Dale Miller
 DMA, Limited
 Offered under GNU License
 July 26, 2016*/

/****************** PROCESSING FILE *************************************/

GO  
PRINT 'ID# 110'  
print 'D:\dev\SQL\DFINAnalytics\DVM_IdentifyQueriesCandidatesForOptimization.sql' 

/*
Developed W. Dale Miller 
Copyright @DMA, Ltd, July 26, 2012 all rights reserved.
Licensed under the MIT Open Code License
Free to --* USEas long as the copyright is retained in the code.
*/
/*
-- exec UTIL_QryPlanStats

--The below CTE provides information about the number of executions, 
--total run time, and pages read from memory. The results can be used 
--to identify queries that may be candidates for optimization.
--Note: The results of this query can vary depending on the version of SQL Server.
--select * into QueryUseStats
IF OBJECT_ID('tempdb..#Results') IS NOT NULL
    DROP TABLE #FindUnusedViews;
*/
/** USEDFINAnalytics;*/

go

if exists (select 1 from sys.procedures where name = 'sp_PerfMonitor')
	DROP PROCEDURE [dbo].[sp_PerfMonitor]
GO


/*
--************************************************************
--**** HOW TO USE
--************************************************************
*/
/*
DECLARE @action VARCHAR(10)= NULL;
DECLARE @RunID int;
DECLARE @UKEY VARCHAR(50);
DECLARE @ProcName VARCHAR(50);
DECLARE @LocID VARCHAR(50);
exec @RunID = dbo.UTIL_GetSeq ;
--SET @RunID = NEXT VALUE FOR master_seq;
SET @action = 'start';
SET @UKEY = NEWID();
SET @ProcName = 'spTestProcName';
SET @LocID = 'Loc3';
EXEC master.dbo.sp_PerfMonitor 
     @action, 
     @RunID, 
     @UKEY, 
     @ProcName, 
     @LocID;  
-- For example, wait a couple of seconds before ending it...
WAITFOR DELAY '00:00:12';
EXEC master.dbo.sp_PerfMonitor 
     'end', 
     @RunID, 
     @UKEY, 
     @ProcName, 
     @LocID;
*/

CREATE PROCEDURE [dbo].[sp_PerfMonitor]
(@action   VARCHAR(10), 
 @RunID    INT, 
 @UKEY     uniqueidentifier,
 @ProcName VARCHAR(50) = NULL, 
 @LocID    VARCHAR(50) = NULL
)
AS
    BEGIN
 IF(@action = 'start')
     BEGIN
  INSERT INTO [dbo].[DFS_PerfMonitor]
  (
		SVRNAME,
		DBNAME,
		SSVER,
		[RunID], 
		[ProcName], 
		[LocID], 
		[UKEY], 
		[StartTime], 
		[EndTime], 
		[ElapsedTime],
		CreateDate
  )
  VALUES (
		@@servername ,
		Db_name(),
		substring(@@version,1,149),
		@RunID, 
		@ProcName, 
		@LocID, 
		@UKEY, 
		GETDATE(), 
		NULL, 
		NULL,
		getdate()
  );
 END;
 IF(@action = 'end')
     BEGIN
  UPDATE [dbo].[DFS_PerfMonitor]
    SET 
   [EndTime] = GETDATE()
  WHERE UKEY = @UKEY;
  UPDATE [dbo].[DFS_PerfMonitor]
    SET 
   [ElapsedTime] = DATEDIFF(MILLISECOND, [StartTime], [EndTime])
  WHERE UKEY = @UKEY;
 END;
    END;

GO

IF EXISTS
(
	SELECT 1
	FROM INFORMATION_SCHEMA.TABLES
	WHERE TABLE_NAME = 'DFS_QryOptStats'
)
BEGIN
	DROP TABLE DFS_QryOptStats;
END;
GO

IF NOT EXISTS
(
	SELECT 1
	FROM INFORMATION_SCHEMA.tables
	WHERE TABLE_NAME = 'DFS_QryOptStats'
)
BEGIN
	CREATE TABLE [dbo].[DFS_QryOptStats]
	( 
				 [SvrName] [NVARCHAR](150) NULL, [schemaname] [NVARCHAR](150) NULL, [viewname] [sysname] NOT NULL, [viewid] [int] NOT NULL, [databasename] [NVARCHAR](150) NULL, [databaseid] [smallint] NULL, [text] [nvarchar](max) NULL, [query_plan] [xml] NULL, [sql_handle] [varbinary](64) NOT NULL, [statement_start_offset] [int] NOT NULL, [statement_end_offset] [int] NOT NULL, [plan_generation_num] [bigint] NULL, [plan_handle] [varbinary](64) NOT NULL, [creation_time] [datetime] NULL, [last_execution_time] [datetime] NULL, [execution_count] [bigint] NOT NULL, [total_worker_time] [bigint] NOT NULL, [last_worker_time] [bigint] NOT NULL, [min_worker_time] [bigint] NOT NULL, [max_worker_time] [bigint] NOT NULL, [total_physical_reads] [bigint] NOT NULL, [last_physical_reads] [bigint] NOT NULL, [min_physical_reads] [bigint] NOT NULL, [max_physical_reads] [bigint] NOT NULL, [total_logical_writes] [bigint] NOT NULL, [last_logical_writes] [bigint] NOT NULL, [min_logical_writes] [bigint] NOT NULL, [max_logical_writes] [bigint] NOT NULL, [total_logical_reads] [bigint] NOT NULL, [last_logical_reads] [bigint] NOT NULL, [min_logical_reads] [bigint] NOT NULL, [max_logical_reads] [bigint] NOT NULL, [total_clr_time] [bigint] NOT NULL, [last_clr_time] [bigint] NOT NULL, [min_clr_time] [bigint] NOT NULL, [max_clr_time] [bigint] NOT NULL, [total_elapsed_time] [bigint] NOT NULL, [last_elapsed_time] [bigint] NOT NULL, [min_elapsed_time] [bigint] NOT NULL, [max_elapsed_time] [bigint] NOT NULL, [query_hash] [binary](8) NULL, [query_plan_hash] [binary](8) NULL, [total_rows] [bigint] NULL, [last_rows] [bigint] NULL, [min_rows] [bigint] NULL, [max_rows] [bigint] NULL, [statement_sql_handle] [varbinary](64) NULL, [statement_context_id] [bigint] NULL, [total_dop] [bigint] NULL, [last_dop] [bigint] NULL, [min_dop] [bigint] NULL, [max_dop] [bigint] NULL, [total_grant_kb] [bigint] NULL, [last_grant_kb] [bigint] NULL, [min_grant_kb] [bigint] NULL, [max_grant_kb] [bigint] NULL, [total_used_grant_kb] [bigint] NULL, [last_used_grant_kb] [bigint] NULL, [min_used_grant_kb] [bigint] NULL, [max_used_grant_kb] [bigint] NULL, [total_ideal_grant_kb] [bigint] NULL, [last_ideal_grant_kb] [bigint] NULL, [min_ideal_grant_kb] [bigint] NULL, [max_ideal_grant_kb] [bigint] NULL, [total_reserved_threads] [bigint] NULL, [last_reserved_threads] [bigint] NULL, [min_reserved_threads] [bigint] NULL, [max_reserved_threads] [bigint] NULL, [total_used_threads] [bigint] NULL, [last_used_threads] [bigint] NULL, [min_used_threads] [bigint] NULL, [max_used_threads] [bigint] NULL, [total_columnstore_segment_reads] [bigint] NULL, [last_columnstore_segment_reads] [bigint] NULL, [min_columnstore_segment_reads] [bigint] NULL, [max_columnstore_segment_reads] [bigint] NULL, [total_columnstore_segment_skips] [bigint] NULL, [last_columnstore_segment_skips] [bigint] NULL, [min_columnstore_segment_skips] [bigint] NULL, [max_columnstore_segment_skips] [bigint] NULL, [total_spills] [bigint] NULL, [last_spills] [bigint] NULL, [min_spills] [bigint] NULL, [max_spills] [bigint] NULL, RunDate datetime DEFAULT GETDATE(), [SSVER] [nvarchar](300) NULL, [UID] uniqueidentifier NOT NULL DEFAULT NEWID()
	)
	ON [PRIMARY];
END;
GO

/* exec UTIL_QryPlanStats*/

IF EXISTS
(
	SELECT 1
	FROM sys.procedures
	WHERE name = 'UTIL_QryPlanStats'
)
BEGIN
	DROP PROCEDURE UTIL_QryPlanStats;
END;
GO

/* 
exec UTIL_QryPlanStats 1

declare @ukey as uniqueidentifier = newid();
exec sp_PerfMonitor 'start', 0, @ukey,  'UTIL_QryPlanStats', '00';
exec sp_PerfMonitor 'end', 0, @ukey,  'UTIL_QryPlanStats', '00';
*/

CREATE PROCEDURE UTIL_QryPlanStats
( 
				 @debug int= 0
)
AS
BEGIN
	DECLARE @cnt AS int= 0;
	declare @ukey as uniqueidentifier = newid() ;

	exec sp_PerfMonitor 'start', 0, @ukey,  'UTIL_QryPlanStats', '00';

	IF OBJECT_ID('tempdb..#TEMP_DFS_QryOptStats') IS NOT NULL
	BEGIN
		DROP TABLE #TEMP_DFS_QryOptStats;
	END;

	BEGIN
		PRINT 'USING DB: ' + DB_NAME();

		WITH CTE_VW_STATS
			 AS (SELECT SCHEMA_NAME(vw.schema_id) AS schemaname, vw.name AS viewname, vw.object_id AS viewid
				 FROM sys.views AS vw
				 WHERE(vw.is_ms_shipped = 0)
				 INTERSECT
				 SELECT SCHEMA_NAME(o.schema_id) AS schemaname, o.Name AS name, st.objectid AS viewid
				 FROM sys.dm_exec_cached_plans AS cp
					  CROSS APPLY
					  sys.dm_exec_sql_text( cp.plan_handle ) AS st
					  INNER JOIN
					  sys.objects AS o
					  ON st.[objectid] = o.[object_id]
				 WHERE st.dbid = DB_ID())
			 SELECT vw.schemaname, vw.viewname, vw.viewid, DB_NAME(t.databaseid) AS databasename, t.*
			 INTO #TEMP_DFS_QryOptStats
			 FROM CTE_VW_STATS AS vw
				  CROSS APPLY
			 (
				 SELECT st.dbid AS databaseid, st.text, qp.query_plan, qs.*, GETDATE() AS RunDate, @@VERSION AS SSVER, NEWID() AS [UID]
				 FROM sys.dm_exec_query_stats AS qs
					  CROSS APPLY
					  sys.dm_exec_sql_text( qs.plan_handle ) AS st
					  CROSS APPLY
					  sys.dm_exec_query_plan( qs.plan_handle ) AS qp
				 WHERE(CHARINDEX(vw.schemaname, st.text, 1) > 0) AND 
					  (st.dbid = DB_ID())
			 ) AS t;
		SET @cnt =
		(
			SELECT COUNT(*)
			FROM #TEMP_DFS_QryOptStats
		);
		IF(@cnt > 0 or @debug = 1)
		BEGIN
			DECLARE @s nvarchar(max);
			SET @s = dbo.genInsertSql( '#TEMP_DFS_QryOptStats', 'dbo.DFS_QryOptStats' );
			IF(@debug = 1)
			BEGIN
				PRINT @s;
			END;
			EXECUTE sp_executesql @s;
		END;
		
	END;

exec dbo.sp_PerfMonitor 'end', 0, @ukey,  'UTIL_QryPlanStats', '00';

END;

/****************** PROCESSING FILE *************************************/

GO  
PRINT 'ID# 120'  
print 'D:\dev\SQL\DFINAnalytics\find_Blocking_History.sql' 

/*select * from sys.databases where name like 'BNYUK%'
--* USE[BNYSA_Production_Data]
--* USEBNYUK_ProductionAR_data*/
/** USEDFINAnalytics;*/

GO
DECLARE @runnow INT= 0;
IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'sp_UTIL_GetIndexStats'
)
   AND @runnow = 1
    BEGIN

/*declare @RunID BIGINT = NEXT VALUE FOR master_seq;
		truncate TABLE [dbo].[DFS_IndexStats];
		select top 100 * from [dbo].[DFS_IndexStats];
		*/
        DECLARE @RunID BIGINT;
        DECLARE @MaxWaitMS INT= 30;
        DECLARE @MaxWaitCount INT= 3;
        EXEC @RunID = dbo.UTIL_GetSeq;
        DECLARE @command VARCHAR(1000);

        /*SELECT @command = '--* USE?; exec sp_UTIL_GetIndexStats ' + CAST(@RunID AS NVARCHAR(25)) + ', ' + CAST(@MaxWaitMS AS NVARCHAR(15)) + ';';*/

        SELECT @command = 'exec sp_UTIL_GetIndexStats ' + CAST(@RunID AS NVARCHAR(25)) + ', ' + CAST(@MaxWaitMS AS NVARCHAR(15)) + ';';
        EXEC sp_MSforeachdb 
             @command;
END;
GO

/* 
drop table [dbo].[DFS_IndexStats]
select * from [dbo].[DFS_IndexStats]
*/

IF EXISTS
(
    SELECT 1
    FROM sys.tables
    WHERE name = 'DFS_IndexStats'
)
    DROP TABLE [dbo].[DFS_IndexStats];
go
CREATE TABLE [dbo].[DFS_IndexStats]
([SvrName]                [NVARCHAR](150) NULL, 
 [DB]                     [NVARCHAR](150) NULL, 
 [Obj]                    [NVARCHAR](150) NULL, 
 [IdxName]                [SYSNAME] NULL, 
 [range_scan_count]       [BIGINT] NOT NULL, 
 [singleton_lookup_count] [BIGINT] NOT NULL, 
 [row_lock_count]         [BIGINT] NOT NULL, 
 [page_lock_count]        [BIGINT] NOT NULL, 
 [TotNo_Of_Locks]         [BIGINT] NULL, 
 [row_lock_wait_count]    [BIGINT] NOT NULL, 
 [page_lock_wait_count]   [BIGINT] NOT NULL, 
 [TotNo_Of_Blocks]        [BIGINT] NULL, 
 [row_lock_wait_in_ms]    [BIGINT] NOT NULL, 
 [page_lock_wait_in_ms]   [BIGINT] NOT NULL, 
 [TotBlock_Wait_TimeMS]   [BIGINT] NULL, 
 [index_id]               [INT] NOT NULL, 
 [CreateDate]             [DATETIME] NULL, 
 SSVER                    NVARCHAR(300) NULL, 
 RunID                    BIGINT NULL, 
 [UID]                    UNIQUEIDENTIFIER DEFAULT NEWID(), 
 [RowNbr]                 [INT] IDENTITY(1, 1) NOT NULL
)
ON [PRIMARY];
CREATE INDEX pi_DFS_IndexStats
ON DFS_IndexStats
([UID]
);

/*ALTER TABLE [dbo].[DFS_IndexStats] ADD  DEFAULT (getdate()) FOR [CreateDate]*/

GO

/** USEmaster;*/

GO
IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'sp_UTIL_GetIndexStats'
)
    DROP PROCEDURE sp_UTIL_GetIndexStats;
GO

/* select top 100 * from [DFS_IndexStats] order by Rownbr desc
 exec sp_UTIL_GetIndexStats -1, 5*/

CREATE PROCEDURE sp_UTIL_GetIndexStats
(@RunID        BIGINT, 
 @MaxWaitMS    INT    = 30, 
 @MaxWaitCount INT    = 2
)
AS
    BEGIN

/*declare @RunID     BIGINT = -50 ;
		declare @MaxWaitMS INT = 0;
		declare @MaxWaitCount INT = 0 ;*/

        INSERT INTO [dbo].[DFS_IndexStats]
        ( [SvrName], 
          [DB], 
          [Obj], 
          [IdxName], 
          [range_scan_count], 
          [singleton_lookup_count], 
          [row_lock_count], 
          [page_lock_count], 
          [TotNo_Of_Locks], 
          [row_lock_wait_count], 
          [page_lock_wait_count], 
          [TotNo_Of_Blocks], 
          [row_lock_wait_in_ms], 
          [page_lock_wait_in_ms], 
          [TotBlock_Wait_TimeMS], 
          [index_id], 
          [CreateDate], 
          [SSVER], 
          RunID, 
          [UID]
        ) 
               SELECT @@ServerName AS SvrName, 
                      DB_NAME() AS DB, 
                      OBJECT_NAME(IOS.object_id) AS Obj, 
                      i.Name AS IdxName, 
                      range_scan_count, 
                      singleton_lookup_count, 
                      row_lock_count, 
                      page_lock_count, 
                      row_lock_count + page_lock_count AS TotNo_Of_Locks, 
                      row_lock_wait_count, 
                      page_lock_wait_count, 
                      row_lock_wait_count + page_lock_wait_count AS TotNo_Of_Blocks, 
                      row_lock_wait_in_ms, 
                      page_lock_wait_in_ms, 
                      row_lock_wait_in_ms + page_lock_wait_in_ms AS TotBlock_Wait_TimeMS, 
                      IOS.index_id, 
                      GETDATE() AS CreateDate, 
                      @@version AS SSVER, 
                      @RunID AS RunID, 
                      NEWID() AS [UID]
               FROM sys.dm_db_index_operational_stats(NULL, NULL, NULL, NULL) IOS
                         JOIN sys.indexes I
                         ON I.index_id = IOS.index_id
               WHERE DB_NAME() NOT IN('master', 'model', 'msdb', 'tempdb', 'DBA')
               AND OBJECT_NAME(IOS.object_id) IS NOT NULL
               AND (row_lock_wait_count >= 0
                    OR page_lock_wait_count >= 0)
               AND (page_lock_wait_in_ms >= @MaxWaitMS
                    OR row_lock_wait_in_ms >= @MaxWaitMS);
    END;

/****************** PROCESSING FILE *************************************/

GO  
PRINT 'ID# 130'  
print 'D:\dev\SQL\DFINAnalytics\UTIL_WorstPerformingQuerries2008.sql' 

/*
-- W. Dale Miller
-- wdalemiller@gmail.com

declare @cmd nvarchar(1000) ;
set @cmd = '--* USE?; exec UTIL_IO_BoundQry2000 ; exec UTIL_CPU_BoundQry2000 ;'
exec sp_msForEachDB @cmd ;
*/
/** USEDFINAnalytics;*/

GO
IF EXISTS
(
    SELECT 1
    FROM sys.tables
    WHERE name = 'DFS_IO_BoundQry'
)
    DROP TABLE [dbo].[DFS_IO_BoundQry];
BEGIN
    CREATE TABLE [dbo].[DFS_IO_BoundQry]
    ([SVRName]                [NVARCHAR](250) NULL, 
     [DBName]                 [NVARCHAR](250) NULL, 
     [text]                   [NVARCHAR](MAX) NULL, 
     [query_plan]             [XML] NULL, 
     [sql_handle]             [VARBINARY](64) NOT NULL, 
     [statement_start_offset] [INT] NOT NULL, 
     [statement_end_offset]   [INT] NOT NULL, 
     [plan_generation_num]    [BIGINT] NULL, 
     [plan_handle]            [VARBINARY](64) NOT NULL, 
     [creation_time]          [DATETIME] NULL, 
     [last_execution_time]    [DATETIME] NULL, 
     [execution_count]        [BIGINT] NOT NULL, 
     [total_worker_time]      [BIGINT] NOT NULL, 
     [last_worker_time]       [BIGINT] NOT NULL, 
     [min_worker_time]        [BIGINT] NOT NULL, 
     [max_worker_time]        [BIGINT] NOT NULL, 
     [total_physical_reads]   [BIGINT] NOT NULL, 
     [last_physical_reads]    [BIGINT] NOT NULL, 
     [min_physical_reads]     [BIGINT] NOT NULL, 
     [max_physical_reads]     [BIGINT] NOT NULL, 
     [total_logical_writes]   [BIGINT] NOT NULL, 
     [last_logical_writes]    [BIGINT] NOT NULL, 
     [min_logical_writes]     [BIGINT] NOT NULL, 
     [max_logical_writes]     [BIGINT] NOT NULL, 
     [total_logical_reads]    [BIGINT] NOT NULL, 
     [last_logical_reads]     [BIGINT] NOT NULL, 
     [min_logical_reads]      [BIGINT] NOT NULL, 
     [max_logical_reads]      [BIGINT] NOT NULL, 
     [total_clr_time]         [BIGINT] NOT NULL, 
     [last_clr_time]          [BIGINT] NOT NULL, 
     [min_clr_time]           [BIGINT] NOT NULL, 
     [max_clr_time]           [BIGINT] NOT NULL, 
     [total_elapsed_time]     [BIGINT] NOT NULL, 
     [last_elapsed_time]      [BIGINT] NOT NULL, 
     [min_elapsed_time]       [BIGINT] NOT NULL, 
     [max_elapsed_time]       [BIGINT] NOT NULL, 
     [query_hash]             [BINARY](8) NULL, 
     [query_plan_hash]        [BINARY](8) NULL, 
     [total_rows]             [BIGINT] NULL, 
     [last_rows]              [BIGINT] NULL, 
     [min_rows]               [BIGINT] NULL, 
     [max_rows]               [BIGINT] NULL, 
     [statement_sql_handle]   [VARBINARY](64) NULL, 
     [statement_context_id]   [BIGINT] NULL, 
     [total_dop]              [BIGINT] NULL, 
     [last_dop]               [BIGINT] NULL, 
     [min_dop]                [BIGINT] NULL, 
     [max_dop]                [BIGINT] NULL, 
     [total_grant_kb]         [BIGINT] NULL, 
     [last_grant_kb]          [BIGINT] NULL, 
     [min_grant_kb]           [BIGINT] NULL, 
     [max_grant_kb]           [BIGINT] NULL, 
     [total_used_grant_kb]    [BIGINT] NULL, 
     [last_used_grant_kb]     [BIGINT] NULL, 
     [min_used_grant_kb]      [BIGINT] NULL, 
     [max_used_grant_kb]      [BIGINT] NULL, 
     [total_ideal_grant_kb]   [BIGINT] NULL, 
     [last_ideal_grant_kb]    [BIGINT] NULL, 
     [min_ideal_grant_kb]     [BIGINT] NULL, 
     [max_ideal_grant_kb]     [BIGINT] NULL, 
     [total_reserved_threads] [BIGINT] NULL, 
     [last_reserved_threads]  [BIGINT] NULL, 
     [min_reserved_threads]   [BIGINT] NULL, 
     [max_reserved_threads]   [BIGINT] NULL, 
     [total_used_threads]     [BIGINT] NULL, 
     [last_used_threads]      [BIGINT] NULL, 
     [min_used_threads]       [BIGINT] NULL, 
     [max_used_threads]       [BIGINT] NULL, 
     [RunDate]                [DATETIME] NULL, 
     [RunID]                  [BIGINT] NULL, 
     [UID]                    [UNIQUEIDENTIFIER] NOT NULL, 
     [Processed]              [INT] NULL
    )
    ON [PRIMARY];
    ALTER TABLE [dbo].[DFS_IO_BoundQry]
    ADD DEFAULT(NEWID()) FOR [UID];
    ALTER TABLE [dbo].[DFS_IO_BoundQry]
    ADD DEFAULT((0)) FOR [Processed];
    CREATE INDEX pkDFS_IO_BoundQry
    ON DFS_IO_BoundQry
    (SvrName, DBName, query_hash, query_plan_hash
    );
END;
IF EXISTS
(
    SELECT 1
    FROM sys.tables
    WHERE name = 'DFS_IO_BoundQry2000'
)
    DROP TABLE [dbo].[DFS_IO_BoundQry2000];
IF NOT EXISTS
(
    SELECT 1
    FROM sys.tables
    WHERE name = 'DFS_IO_BoundQry2000'
)
    BEGIN
        CREATE TABLE [dbo].[DFS_IO_BoundQry2000]
        ([SVRName]                         [NVARCHAR](250) NULL, 
         [DBName]                          [VARCHAR](250) NOT NULL, 
         [text]                            [NVARCHAR](MAX) NULL, 
         [query_plan]                      [XML] NULL, 
         [sql_handle]                      [VARBINARY](64) NOT NULL, 
         [statement_start_offset]          [INT] NOT NULL, 
         [statement_end_offset]            [INT] NOT NULL, 
         [plan_generation_num]             [BIGINT] NULL, 
         [plan_handle]                     [VARBINARY](64) NOT NULL, 
         [creation_time]                   [DATETIME] NULL, 
         [last_execution_time]             [DATETIME] NULL, 
         [execution_count]                 [BIGINT] NOT NULL, 
         [total_worker_time]               [BIGINT] NOT NULL, 
         [last_worker_time]                [BIGINT] NOT NULL, 
         [min_worker_time]                 [BIGINT] NOT NULL, 
         [max_worker_time]                 [BIGINT] NOT NULL, 
         [total_physical_reads]            [BIGINT] NOT NULL, 
         [last_physical_reads]             [BIGINT] NOT NULL, 
         [min_physical_reads]              [BIGINT] NOT NULL, 
         [max_physical_reads]              [BIGINT] NOT NULL, 
         [total_logical_writes]            [BIGINT] NOT NULL, 
         [last_logical_writes]             [BIGINT] NOT NULL, 
         [min_logical_writes]              [BIGINT] NOT NULL, 
         [max_logical_writes]              [BIGINT] NOT NULL, 
         [total_logical_reads]             [BIGINT] NOT NULL, 
         [last_logical_reads]              [BIGINT] NOT NULL, 
         [min_logical_reads]               [BIGINT] NOT NULL, 
         [max_logical_reads]               [BIGINT] NOT NULL, 
         [total_clr_time]                  [BIGINT] NOT NULL, 
         [last_clr_time]                   [BIGINT] NOT NULL, 
         [min_clr_time]                    [BIGINT] NOT NULL, 
         [max_clr_time]                    [BIGINT] NOT NULL, 
         [total_elapsed_time]              [BIGINT] NOT NULL, 
         [last_elapsed_time]               [BIGINT] NOT NULL, 
         [min_elapsed_time]                [BIGINT] NOT NULL, 
         [max_elapsed_time]                [BIGINT] NOT NULL, 
         [query_hash]                      [BINARY](8) NULL, 
         [query_plan_hash]                 [BINARY](8) NULL, 
         [total_rows]                      [BIGINT] NULL, 
         [last_rows]                       [BIGINT] NULL, 
         [min_rows]                        [BIGINT] NULL, 
         [max_rows]                        [BIGINT] NULL, 
         [statement_sql_handle]            [VARBINARY](64) NULL, 
         [statement_context_id]            [BIGINT] NULL, 
         [total_dop]                       [BIGINT] NULL, 
         [last_dop]                        [BIGINT] NULL, 
         [min_dop]                         [BIGINT] NULL, 
         [max_dop]                         [BIGINT] NULL, 
         [total_grant_kb]                  [BIGINT] NULL, 
         [last_grant_kb]                   [BIGINT] NULL, 
         [min_grant_kb]                    [BIGINT] NULL, 
         [max_grant_kb]                    [BIGINT] NULL, 
         [total_used_grant_kb]             [BIGINT] NULL, 
         [last_used_grant_kb]              [BIGINT] NULL, 
         [min_used_grant_kb]               [BIGINT] NULL, 
         [max_used_grant_kb]               [BIGINT] NULL, 
         [total_ideal_grant_kb]            [BIGINT] NULL, 
         [last_ideal_grant_kb]             [BIGINT] NULL, 
         [min_ideal_grant_kb]              [BIGINT] NULL, 
         [max_ideal_grant_kb]              [BIGINT] NULL, 
         [total_reserved_threads]          [BIGINT] NULL, 
         [last_reserved_threads]           [BIGINT] NULL, 
         [min_reserved_threads]            [BIGINT] NULL, 
         [max_reserved_threads]            [BIGINT] NULL, 
         [total_used_threads]              [BIGINT] NULL, 
         [last_used_threads]               [BIGINT] NULL, 
         [min_used_threads]                [BIGINT] NULL, 
         [max_used_threads]                [BIGINT] NULL, 
         [total_columnstore_segment_reads] [BIGINT] NULL, 
         [last_columnstore_segment_reads]  [BIGINT] NULL, 
         [min_columnstore_segment_reads]   [BIGINT] NULL, 
         [max_columnstore_segment_reads]   [BIGINT] NULL, 
         [total_columnstore_segment_skips] [BIGINT] NULL, 
         [last_columnstore_segment_skips]  [BIGINT] NULL, 
         [min_columnstore_segment_skips]   [BIGINT] NULL, 
         [max_columnstore_segment_skips]   [BIGINT] NULL, 
         [total_spills]                    [BIGINT] NULL, 
         [last_spills]                     [BIGINT] NULL, 
         [min_spills]                      [BIGINT] NULL, 
         [max_spills]                      [BIGINT] NULL, 
         [RunDate]                         [DATETIME] NOT NULL, 
         [SSVER]                           [NVARCHAR](300) NULL, 
         [RunID]                           [INT] NOT NULL, 
         [UID]                             [UNIQUEIDENTIFIER] NULL, 
         [processed]                       [INT] NOT NULL
        )
        ON [PRIMARY];
        ALTER TABLE [dbo].[DFS_IO_BoundQry2000]
        ADD DEFAULT(NEWID()) FOR [UID];
        ALTER TABLE [dbo].[DFS_IO_BoundQry2000]
        ADD DEFAULT((0)) FOR [Processed];
        CREATE INDEX pkDFS_IO_BoundQry2000
        ON DFS_IO_BoundQry2000
        (SvrName, DBName, query_hash, query_plan_hash
        );
END;
IF EXISTS
(
    SELECT 1
    FROM sys.tables
    WHERE name = 'DFS_CPU_BoundQry2000'
)
    BEGIN
        DROP TABLE DFS_CPU_BoundQry2000;
END;
IF NOT EXISTS
(
    SELECT 1
    FROM sys.tables
    WHERE name = 'DFS_CPU_BoundQry2000'
)
    BEGIN
        CREATE TABLE [dbo].[DFS_CPU_BoundQry2000]
        ([SVRName]                         [NVARCHAR](250) NULL, 
         [DBName]                          [NVARCHAR](250) NULL, 
         [text]                            [NVARCHAR](MAX) NULL, 
         [query_plan]                      [XML] NULL, 
         [sql_handle]                      [VARBINARY](64) NOT NULL, 
         [statement_start_offset]          [INT] NOT NULL, 
         [statement_end_offset]            [INT] NOT NULL, 
         [plan_generation_num]             [BIGINT] NULL, 
         [plan_handle]                     [VARBINARY](64) NOT NULL, 
         [creation_time]                   [DATETIME] NULL, 
         [last_execution_time]             [DATETIME] NULL, 
         [execution_count]                 [BIGINT] NOT NULL, 
         [total_worker_time]               [BIGINT] NOT NULL, 
         [last_worker_time]                [BIGINT] NOT NULL, 
         [min_worker_time]                 [BIGINT] NOT NULL, 
         [max_worker_time]                 [BIGINT] NOT NULL, 
         [total_physical_reads]            [BIGINT] NOT NULL, 
         [last_physical_reads]             [BIGINT] NOT NULL, 
         [min_physical_reads]              [BIGINT] NOT NULL, 
         [max_physical_reads]              [BIGINT] NOT NULL, 
         [total_logical_writes]            [BIGINT] NOT NULL, 
         [last_logical_writes]             [BIGINT] NOT NULL, 
         [min_logical_writes]              [BIGINT] NOT NULL, 
         [max_logical_writes]              [BIGINT] NOT NULL, 
         [total_logical_reads]             [BIGINT] NOT NULL, 
         [last_logical_reads]              [BIGINT] NOT NULL, 
         [min_logical_reads]               [BIGINT] NOT NULL, 
         [max_logical_reads]               [BIGINT] NOT NULL, 
         [total_clr_time]                  [BIGINT] NOT NULL, 
         [last_clr_time]                   [BIGINT] NOT NULL, 
         [min_clr_time]                    [BIGINT] NOT NULL, 
         [max_clr_time]                    [BIGINT] NOT NULL, 
         [total_elapsed_time]              [BIGINT] NOT NULL, 
         [last_elapsed_time]               [BIGINT] NOT NULL, 
         [min_elapsed_time]                [BIGINT] NOT NULL, 
         [max_elapsed_time]                [BIGINT] NOT NULL, 
         [query_hash]                      [BINARY](8) NULL, 
         [query_plan_hash]                 [BINARY](8) NULL, 
         [total_rows]                      [BIGINT] NULL, 
         [last_rows]                       [BIGINT] NULL, 
         [min_rows]                        [BIGINT] NULL, 
         [max_rows]                        [BIGINT] NULL, 
         [statement_sql_handle]            [VARBINARY](64) NULL, 
         [statement_context_id]            [BIGINT] NULL, 
         [total_dop]                       [BIGINT] NULL, 
         [last_dop]                        [BIGINT] NULL, 
         [min_dop]                         [BIGINT] NULL, 
         [max_dop]                         [BIGINT] NULL, 
         [total_grant_kb]                  [BIGINT] NULL, 
         [last_grant_kb]                   [BIGINT] NULL, 
         [min_grant_kb]                    [BIGINT] NULL, 
         [max_grant_kb]                    [BIGINT] NULL, 
         [total_used_grant_kb]             [BIGINT] NULL, 
         [last_used_grant_kb]              [BIGINT] NULL, 
         [min_used_grant_kb]               [BIGINT] NULL, 
         [max_used_grant_kb]               [BIGINT] NULL, 
         [total_ideal_grant_kb]            [BIGINT] NULL, 
         [last_ideal_grant_kb]             [BIGINT] NULL, 
         [min_ideal_grant_kb]              [BIGINT] NULL, 
         [max_ideal_grant_kb]              [BIGINT] NULL, 
         [total_reserved_threads]          [BIGINT] NULL, 
         [last_reserved_threads]           [BIGINT] NULL, 
         [min_reserved_threads]            [BIGINT] NULL, 
         [max_reserved_threads]            [BIGINT] NULL, 
         [total_used_threads]              [BIGINT] NULL, 
         [last_used_threads]               [BIGINT] NULL, 
         [min_used_threads]                [BIGINT] NULL, 
         [max_used_threads]                [BIGINT] NULL, 
         [total_columnstore_segment_reads] [BIGINT] NULL, 
         [last_columnstore_segment_reads]  [BIGINT] NULL, 
         [min_columnstore_segment_reads]   [BIGINT] NULL, 
         [max_columnstore_segment_reads]   [BIGINT] NULL, 
         [total_columnstore_segment_skips] [BIGINT] NULL, 
         [last_columnstore_segment_skips]  [BIGINT] NULL, 
         [min_columnstore_segment_skips]   [BIGINT] NULL, 
         [max_columnstore_segment_skips]   [BIGINT] NULL, 
         [total_spills]                    [BIGINT] NULL, 
         [last_spills]                     [BIGINT] NULL, 
         [min_spills]                      [BIGINT] NULL, 
         [max_spills]                      [BIGINT] NULL, 
         [RunDate]                         [DATETIME] NOT NULL, 
         [SSVer]                           [NVARCHAR](300) NULL, 
         [RunID]                           [INT] NOT NULL, 
         [UID]                             [UNIQUEIDENTIFIER] NULL, 
         [Processed]                       [INT] NOT NULL
        )
        ON [PRIMARY];
        ALTER TABLE [dbo].[DFS_CPU_BoundQry2000]
        ADD DEFAULT(NEWID()) FOR [UID];
        ALTER TABLE [dbo].[DFS_CPU_BoundQry2000]
        ADD DEFAULT((0)) FOR [Processed];
        CREATE INDEX pkDFS_CPU_BoundQry2000
        ON DFS_CPU_BoundQry2000
        (SvrName, DBName, query_hash, query_plan_hash
        );
END;
GO

/*SELECT '[' + column_name + '],' FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'DFS_CPU_BoundQry2000';
 drop table dbo.[DFS_CPU_BoundQry2000]
performance bottleneck
is it CPU or I/O bound? If your performance bottleneck is CPU bound, Find trhe top 5 worst 
performing queries regarding CPU consumption with the following query:
 Worst performing CPU bound queries

exec sp_UTIL_MSTR_BoundQry2000
exec UTIL_CPU_BoundQry2000 
wdmxx

 */

GO
IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'UTIL_CPU_BoundQry2000'
)
    BEGIN
        DROP PROCEDURE UTIL_CPU_BoundQry2000;
END;
GO
CREATE PROCEDURE UTIL_CPU_BoundQry2000(@NextID BIGINT = NULL)
AS
    BEGIN
		DECLARE @s NVARCHAR(MAX);
		DECLARE @dbug as int = 0 ;
		declare @zcnt as int = 0;
        DECLARE @RunDate AS DATETIME= GETDATE();
        DECLARE @msg VARCHAR(100);
        DECLARE @DBNAME VARCHAR(100)= DB_NAME();
        IF @NextID IS NULL
            BEGIN
                EXEC @NextID = [dbo].[sp_UTIL_GetSeq];
        END;
        IF EXISTS
        (
            SELECT 1
            FROM dbo.[DFS_DB2Skip]
            WHERE @DBNAME = [DB]
        )
            BEGIN
                SET @msg = 'SKIPPING: ' + @DBNAME;
                EXEC sp_printimmediate 
                     @msg;
                RETURN;
        END;
        SET @msg = 'UTIL CPU DB: ' + @DBNAME;
        EXEC sp_printimmediate 
             @msg;
        IF OBJECT_ID('tempdb..#DFS_CPU_BoundQry2000') IS NOT NULL
            BEGIN
                DROP TABLE #DFS_CPU_BoundQry2000;
        END;
        SELECT TOP 10 @@SERVERNAME AS SVRName, 
                      DB_NAME() AS DBName, 
                      st.text, 
                      qp.query_plan, 
                      qs.*, 
                      GETDATE() AS RunDate, 
                      @@VERSION AS SSVer, 
                      15 AS RunID, 
                      NEWID() AS [UID], 
                      0 AS Processed
        INTO [#DFS_CPU_BoundQry2000]
        FROM sys.dm_exec_query_stats AS qs
                  CROSS APPLY sys.dm_exec_sql_text(qs.plan_handle) AS st
                       CROSS APPLY sys.dm_exec_query_plan(qs.plan_handle) AS qp
        ORDER BY total_worker_time DESC;

		if (@dbug = 1 AND OBJECT_ID('tempdb..#DFS_CPU_BoundQry2000') IS NOT NULL)
		begin
			set @zcnt = (select count(*) from [#DFS_CPU_BoundQry2000]) ;
			print '#DFS_CPU_BoundQry2000 COUNT: ' + cast(@zcnt as nvarchar(50));
		end;

		if ( OBJECT_ID('tempdb..#DFS_CPU_BoundQry2000') IS NOT NULL)
		begin
			WITH cteExisting
			AS (
				SELECT distinct SvrName, DbName, query_hash, query_plan_hash
				FROM DFS_QryOptStatsHistory
				)
			DELETE t1
			FROM #DFS_CPU_BoundQry2000 t1 
			INNER JOIN cteExisting ts 
				ON t1.SVRName = ts.SvrName
				and t1.DBName = ts.DbName
				and t1.query_hash = ts.query_hash
				and t1.query_plan_hash = ts.query_plan_hash;
		end 
		if (@dbug = 1 AND OBJECT_ID('tempdb..#DFS_CPU_BoundQry2000') IS NOT NULL)
		begin
			print '#ROWS Already exists: ' + cast(@@rowcount as nvarchar(50)) ;
			set @zcnt = (select count(*) from [#DFS_CPU_BoundQry2000]) ;
			print '#DFS_CPU_BoundQry2000 COUNT: ' + cast(@zcnt as nvarchar(50));
		end 
        
        SET @s = dbo.genInsertSql('#DFS_CPU_BoundQry2000', 'dbo.DFS_CPU_BoundQry2000');
        EXECUTE sp_executesql @s;
    END;
GO
IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'UTIL_IO_BoundQry2000'
)
    BEGIN
        DROP PROCEDURE UTIL_IO_BoundQry2000;
END;
GO

/*
select count(*) from information_schema.columns where table_name = 'TEMP_FS_IO_BoundQry2016'
exec UTIL_IO_BoundQry2000 -99 ;
drop table #DFS_IO_BoundQry2000
*/
/*
EXEC UTIL_IO_BoundQry2000 -99
*/
CREATE PROCEDURE UTIL_IO_BoundQry2000(@NextID BIGINT = NULL)
AS
    BEGIN
        BEGIN TRY
            DROP TABLE #DFS_IO_BoundQry2000;
        END TRY
        BEGIN CATCH
            PRINT 'drop #DFS_IO_BoundQry2000';
        END CATCH;

        /*declare @NextID BIGINT = -99;*/

		declare @dbug as int = 0 ;
		declare @zcnt as int = 0 ;
		
        DECLARE @ver NVARCHAR(MAX)= @@version;
        PRINT @ver;
        DECLARE @IsAzure INT= 0;
        IF CHARINDEX('Azure', @ver) > 0
            SET @IsAzure = 1;
            ELSE
            SET @IsAzure = 0;
        DECLARE @msg VARCHAR(100);
        DECLARE @DBNAME VARCHAR(100)= DB_NAME();
        IF @NextID IS NULL
            BEGIN
                EXEC @NextID = [dbo].[sp_UTIL_GetSeq];
        END;
        DECLARE @RunDate AS DATETIME= GETDATE();
        IF EXISTS
        (
            SELECT 1
            FROM dbo.[DFS_DB2Skip]
            WHERE @DBNAME = [DB]
        )
            BEGIN
                SET @msg = 'SKIPPING: ' + @DBNAME;
                EXEC sp_printimmediate 
                     @msg;
                RETURN;
        END;
        SET @msg = 'UTIL IO DB: ' + @DBNAME;
        EXEC sp_printimmediate 
             @msg;
        SELECT TOP 10 @@SERVERNAME AS SVRName, 
                      DB_NAME() AS DBName, 
                      st.text, 
                      qp.query_plan, 
                      qs.*, 
                      GETDATE() AS RunDate, 
                      @@version AS SSVER, 
                      @NextID AS RunID, 
                      NEWID() AS [UID], 
                      0 AS processed
        INTO #DFS_IO_BoundQry2000
        FROM sys.dm_exec_query_stats AS qs
                  CROSS APPLY sys.dm_exec_sql_text(qs.plan_handle) AS st
                       CROSS APPLY sys.dm_exec_query_plan(qs.plan_handle) AS qp
        ORDER BY total_logical_reads DESC;
        DECLARE @s NVARCHAR(MAX);
        DECLARE @tempcolcnt INT=
        (
            SELECT COUNT(*)
            FROM tempdb.sys.columns
            WHERE object_id = OBJECT_ID('tempdb..#DFS_IO_BoundQry2000')
        );

		if (@dbug = 1)
		begin
			set @zcnt = (select count(*) from [#DFS_IO_BoundQry2000]) ;
			print '#DFS_CPU_BoundQry2000 COUNT: ' + cast(@zcnt as nvarchar(50));
		end;

		WITH cteExisting
		AS (
			SELECT distinct SvrName, DbName, query_hash, query_plan_hash
			FROM DFS_QryOptStatsHistory
			)
		DELETE t1
		FROM #DFS_IO_BoundQry2000 t1 
		INNER JOIN cteExisting ts 
			ON t1.SVRName = ts.SvrName
			and t1.DBName = ts.DbName
			and t1.query_hash = ts.query_hash
			and t1.query_plan_hash = ts.query_plan_hash;
		
		if (@dbug = 1)
		begin
			print '#ROWS Already exists: ' + cast(@@rowcount as nvarchar(50)) ;
			set @zcnt = (select count(*) from [#DFS_IO_BoundQry2000]) ;
			print '#DFS_IO_BoundQry2000 COUNT: ' + cast(@zcnt as nvarchar(50));
		end 

        SET @s = dbo.genInsertSql('#DFS_IO_BoundQry2000', 'dbo.DFS_IO_BoundQry2000');
        EXECUTE sp_executesql 
                @s;
    END;
GO
IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'sp_UTIL_MSTR_BoundQry2000'
)
    BEGIN
        DROP PROCEDURE sp_UTIL_MSTR_BoundQry2000;
END;
GO

/*
	exec sp_UTIL_MSTR_BoundQry2000 ;	
*/
CREATE PROCEDURE sp_UTIL_MSTR_BoundQry2000
AS
    BEGIN

		DECLARE @NextID AS INT= 0;
		EXEC @NextID = [dbo].[sp_UTIL_GetSeq];

        EXEC UTIL_UpdateQryPlansAndText 'DFS_CPU_BoundQry2000';
        EXEC UTIL_UpdateQryPlansAndText 'DFS_IO_BoundQry2000';
        EXEC UTIL_UpdateQryPlansAndText 'DFS_CPU_BoundQry';
        EXEC UTIL_UpdateQryPlansAndText 'DFS_IO_BoundQry';
		
        EXEC UTIL_CPU_BoundQry2000 @NextID;
        EXEC UTIL_IO_BoundQry2000 @NextID;
		
        EXEC UTIL_UpdateQryPlansAndText 'DFS_CPU_BoundQry2000';
        EXEC UTIL_UpdateQryPlansAndText 'DFS_IO_BoundQry2000';
        EXEC UTIL_UpdateQryPlansAndText 'DFS_CPU_BoundQry';
        EXEC UTIL_UpdateQryPlansAndText 'DFS_IO_BoundQry';

		exec UTIL_Process_QrysPlans;
		exec UTIL_QryOptStatsHistory;
		

    END;
GO

/* DMA, Limited
 Offered under GNU License
 July 26, 2016
 */

/****************** PROCESSING FILE *************************************/

GO  
PRINT 'ID# 140'  
print 'D:\dev\SQL\DFINAnalytics\FindBlockingDetail.sql' 

--* USEDFINAnalytics;
GO
DECLARE @runnow INT= 0;
IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'UTIL_TxMonitorTableIndexStats'
)
   AND @runnow = 1
    BEGIN

 /*declare @RunID BIGINT = NEXT VALUE FOR master_seq;*/

 DECLARE @RunID BIGINT;
 EXEC @RunID = dbo.UTIL_GetSeq;
 PRINT @RunID;
 DECLARE @command VARCHAR(1000);
 --SELECT @command = '--* USE?; declare @DB as int = DB_ID() ; exec sp_DFS_MonitorLocks ' + CAST(@RunID AS NVARCHAR(25)) + ' ;';
		SELECT @command = 'declare @DB as int = DB_ID() ; exec sp_DFS_MonitorLocks ' + CAST(@RunID AS NVARCHAR(25)) + ' ;';
 EXEC sp_MSforeachdb @command;
END;
go
/* drop TABLE [dbo].[DFS_TranLocks]*/

IF EXISTS
(
    SELECT 1
    FROM sys.tables
    WHERE name = 'DFS_TranLocks'
)
drop TABLE [dbo].[DFS_TranLocks];

    CREATE TABLE [dbo].[DFS_TranLocks]
    ([SPID]   [INT] NOT NULL, 
     [SvrName]  [NVARCHAR](150) NULL, 
     [DatabaseName]  [NVARCHAR](150) NULL, 
     [LockedObjectName]     [SYSNAME] NOT NULL, 
     [LockedObjectId]  [INT] NOT NULL, 
     [LockedResource]  [NVARCHAR](60) NOT NULL, 
     [LockType] [NVARCHAR](60) NOT NULL, 
     [SqlStatementText]     [NVARCHAR](MAX) NULL, 
     [LoginName]     [NVARCHAR](150) NOT NULL, 
     [HostName] [NVARCHAR](150) NULL, 
     [IsUserTransaction]    [BIT] NOT NULL, 
     [TransactionName] [NVARCHAR](32) NOT NULL, 
     [AuthenticationMethod] [NVARCHAR](40) NOT NULL, 
     RunID    INT NULL, 
     CreateDate DATETIME DEFAULT GETDATE(), 
     [UID]    UNIQUEIDENTIFIER DEFAULT NEWID()
    )
    ON [PRIMARY];
GO

--* USEmaster 
go
/* Select * from DFS_TranLocks
DECLARE @RunID BIGINT;
EXEC @RunID = dbo.UTIL_GetSeq;
PRINT @RunID;
exec sp_DFS_MonitorLocks @RunID
*/

IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'sp_DFS_MonitorLocks '
)
    DROP PROCEDURE sp_DFS_MonitorLocks;
GO

/*
 exec [DFINAnalytics].dbo.sp_DFS_MonitorLocks -99
 select * from [dbo].[DFS_TranLocks]
 */
 
CREATE PROCEDURE sp_DFS_MonitorLocks (@RunID INT)
AS
    BEGIN

 INSERT INTO [dbo].[DFS_TranLocks]
 ( [SPID], 
   [SvrName], 
   [DatabaseName], 
   [LockedObjectName], 
   [LockedObjectId], 
   [LockedResource], 
   [LockType], 
   [SqlStatementText], 
   [LoginName], 
   [HostName], 
   [IsUserTransaction], 
   [TransactionName], 
   [AuthenticationMethod], 
   [RunID], 
   [CreateDate], 
   [UID]
 ) 
   SELECT LOCKS.request_session_id AS SPID, 
   @@SERVERNAME, 
   DB_NAME(LOCKS.resource_database_id) AS DatabaseName, 
   OBJ.Name AS LockedObjectName, 
   P.object_id AS LockedObjectId, 
   LOCKS.resource_type AS LockedResource, 
   LOCKS.request_mode AS LockType, 
   ST.text AS SqlStatementText, 
   ES.login_name AS LoginName, 
   ES.host_name AS HostName, 
   SESSIONTX.is_user_transaction AS IsUserTransaction, 
   ATX.name AS TransactionName, 
   CN.auth_scheme AS AuthenticationMethod, 
   @RunID, 
   GETDATE(), 
   NEWID()
   FROM sys.dm_tran_locks LOCKS
    JOIN sys.partitions P
    ON P.hobt_id = LOCKS.resource_associated_entity_id
    JOIN sys.objects OBJ
    ON OBJ.object_id = P.object_id
  JOIN sys.dm_exec_sessions ES
    ON ES.session_id = LOCKS.request_session_id
     JOIN sys.dm_tran_session_transactions SESSIONTX
    ON ES.session_id = SESSIONTX.session_id
     JOIN sys.dm_tran_active_transactions ATX
    ON SESSIONTX.transaction_id = ATX.transaction_id
   JOIN sys.dm_exec_connections CN
    ON CN.session_id = ES.session_id
   CROSS APPLY sys.dm_exec_sql_text(CN.most_recent_sql_handle) AS ST
   WHERE resource_database_id = DB_ID()
   ORDER BY LOCKS.request_session_id;

/* W. Dale Miller
  DMA, Limited
  Offered under GNU License
  July 26, 2016*/

    END;

/****************** PROCESSING FILE *************************************/

GO  
PRINT 'ID# 150'  
print 'D:\dev\SQL\DFINAnalytics\UTIL_RebuildAllDbIndexUsingDBCC.sql' 
--* USE master;
GO
IF EXISTS
(
    SELECT 1
    FROM   sys.procedures
    WHERE  name = 'sp_UTIL_RebuildAllDbIndexUsingDBCC'
)
    DROP PROCEDURE sp_UTIL_RebuildAllDbIndexUsingDBCC;
	GO
CREATE PROCEDURE sp_UTIL_RebuildAllDbIndexUsingDBCC
AS
    BEGIN
        DECLARE @tblname VARCHAR(250);
        DECLARE tbl CURSOR
        FOR SELECT table_name
            FROM   information_schema.tables
            WHERE  table_type = 'base table';
        OPEN tbl;
        DECLARE @msg VARCHAR(1000);
        FETCH NEXT FROM tbl INTO @tblname;
        WHILE @@FETCH_STATUS = 0
            BEGIN
                SET @msg = 'Processing: ' + @tblname;
                EXEC sp_printimmediate 
                     @msg;
                DBCC DBREINDEX(@tblname, ' ', 80);
                FETCH NEXT FROM tbl INTO @tblname;
            END;
        CLOSE tbl;
        DEALLOCATE tbl;
    END;PRINT '--- "D:\dev\SQL\DFINAnalytics\UTIL_RebuildAllDbIndexUsingDBCC.sql"' 


/****************** PROCESSING FILE *************************************/

GO  
PRINT 'ID# 160'  
print 'D:\dev\SQL\DFINAnalytics\UTIL_MonitorWorkload.sql' 
-- W. Dale Miller @ 1/1/2019
--* USEDFINAnalytics;
go

/*
DECLARE @RunID BIGINT;
EXEC @RunID = dbo.UTIL_GetSeq;
PRINT 'RUN ID: ' + cast(@RunID as nvarchar(10));
DECLARE @command NVARCHAR(1000);
SELECT @command = '--* USE?; exec dbo.UTIL_MonitorWorkload ' + CAST(@RunID AS NVARCHAR(10)) ;
EXEC sp_MSforeachdb @command;
*/


/*
--select '[' + column_name +'],' from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = 'DFS_Workload'
--go
--drop table DFS_Workload;
--go
--ALTER TABLE DFS_Workload
--ADD RowID BIGINT IDENTITY(1, 1) NOT NULL;
--ALTER TABLE DFS_Workload
--ADD RunDate DATETIME DEFAULT GETDATE() NOT NULL;
--exec dbo.UTIL_MonitorWorkload
--select * from DFS_Workload
--GO
*/

IF NOT EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.TABLES
    WHERE TABLE_NAME = 'DFS_Workload'
)
    BEGIN
 CREATE TABLE dbo.[DFS_Workload]
 (Svrname nvarchar(150) null,
		[OptimizationPct] [DECIMAL](5, 2) NULL, 
  [TrivialPlanPct]  [DECIMAL](5, 2) NULL, 
  [NoPlanPct]     [DECIMAL](5, 2) NULL, 
  [Search0Pct]    [DECIMAL](5, 2) NULL, 
  [Search1Pct]    [DECIMAL](5, 2) NULL, 
  [Search2Pct]    [DECIMAL](5, 2) NULL, 
  [TimeoutPct]    [DECIMAL](5, 2) NULL, 
  [MemoryLimitExceededPct] [DECIMAL](5, 2) NULL, 
  [InsertStmtPct]   [DECIMAL](5, 2) NULL, 
  [DeleteStmt]    [DECIMAL](5, 2) NULL, 
  [UpdateStmt]    [DECIMAL](5, 2) NULL, 
  [MergeStmt]     [DECIMAL](5, 2) NULL, 
  [ContainsSubqueryPct]  [DECIMAL](5, 2) NULL, 
  [ViewReferencePct]     [DECIMAL](5, 2) NULL, 
  [RemoteQueryPct]  [DECIMAL](5, 2) NULL, 
  [DynamicCursorRequestPct]     [DECIMAL](5, 2) NULL, 
  [FastForwardCursorRequestPct] [DECIMAL](5, 2) NULL,
		 [UID] uniqueidentifier default newid(), 
  RowID    BIGINT IDENTITY(1, 1) NOT NULL, 
  RunDate    DATETIME DEFAULT GETDATE() NOT NULL
 )
 ON [PRIMARY];
END;

go
----* USEmaster;
go
--The below common_table_expression (CTE) uses this DMV to provide 
--information about the workload, such as the percentage of queries 
--that reference a view. The results returned by this query do not 
--indicate a performance problem by themselves, but can expose 
--underlying issues when combined with users' complaints of slow-performing 
--queries.
--exec dbo.UTIL_MonitorWorkload
IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'UTIL_MonitorWorkload'
)
    BEGIN
 DROP PROCEDURE UTIL_MonitorWorkload;
END;
GO

-- exec dbo.UTIL_MonitorWorkload 
IF EXISTS (SELECT 1 FROM sys.procedures WHERE name = 'UTIL_MonitorWorkload')
	drop PROCEDURE UTIL_MonitorWorkload 
go
CREATE PROCEDURE UTIL_MonitorWorkload 
AS
	--UTIL_MonitorWorkload.sql
    BEGIN
		declare @DBname nvarchar(100) = db_name();
		declare @msg nvarchar(1000);
		set @msg = 'WORKLOAD Processing: ' + @DBname;
		exec dbo.printimmediate @msg;
 IF OBJECT_ID('tempdb..#TMP_WorkLoad') IS NOT NULL
     DROP TABLE #TMP_WorkLoad;
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
 SELECT @@servername as SvrName,
					[optimizations] AS [OptimizationPct], 
 [trivial plan] AS [TrivialPlanPct], 
 [no plan] AS [NoPlanPct], 
 [search 0] AS [Search0Pct], 
 [search 1] AS [Search1Pct], 
 [search 2] AS [Search2Pct], 
 [timeout] AS [TimeoutPct], 
 [memory limit exceeded] AS [MemoryLimitExceededPct], 
 [insert stmt] AS [InsertStmtPct], 
 [delete stmt] AS [DeleteStmt], 
 [update stmt] AS [UpdateStmt], 
 [merge stmt] AS [MergeStmt], 
 [contains subquery] AS [ContainsSubqueryPct], 
 [view reference] AS [ViewReferencePct], 
 [remote query] AS [RemoteQueryPct], 
 [dynamic cursor request] AS [DynamicCursorRequestPct], 
 [fast forward cursor request] AS [FastForwardCursorRequestPct],
					newid() as [UID] 
 INTO #TMP_WorkLoad
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
 INSERT INTO dbo.DFS_Workload
 ([SvrName]
    ,[OptimizationPct]
    ,[TrivialPlanPct]
    ,[NoPlanPct]
    ,[Search0Pct]
    ,[Search1Pct]
    ,[Search2Pct]
    ,[TimeoutPct]
    ,[MemoryLimitExceededPct]
    ,[InsertStmtPct]
    ,[DeleteStmt]
    ,[UpdateStmt]
    ,[MergeStmt]
    ,[ContainsSubqueryPct]
    ,[ViewReferencePct]
    ,[RemoteQueryPct]
    ,[DynamicCursorRequestPct]
    ,[FastForwardCursorRequestPct],
		   [UID]
 )
   SELECT *
   FROM #TMP_WorkLoad;

    END;
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016


/****************** PROCESSING FILE *************************************/

GO  
PRINT 'ID# 170'  
print 'D:\dev\SQL\DFINAnalytics\FindBlockedSPIDS.sql' 
--* USEDFINAnalytics;
GO

/*EXEC sp_who2;
EXEC sp_who;
GO*/

IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'UTIL_ListQryTextBySpid'
)
    DROP PROCEDURE UTIL_ListQryTextBySpid;
	GO
CREATE PROC UTIL_ListQryTextBySpid(@SPID INT)
AS

/*Exec UTIL_ListQryBySpid 306  
     To see the last statement sent from a client to an SQL Server instance run: (for example for the blocking session ID)*/

     DBCC INPUTBUFFER(@SPID);
GO
GRANT EXECUTE ON OBJECT ::dbo.UTIL_ListQryTextBySpid TO public;
GO
IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'UTIL_getRunningQueryText'
)
    DROP PROCEDURE UTIL_getRunningQueryText;
GO
CREATE PROC UTIL_getRunningQueryText(@SPID INT)
AS

     /*Lists query by @SPID in SQL Server and the text*/

     SELECT r.session_id, 
     s.host_name, 
     s.login_name, 
     s.original_login_name, 
     r.STATUS, 
     r.command, 
     r.cpu_time, 
     r.total_elapsed_time, 
     t.text AS Query_Text
     FROM sys.dm_exec_requests r
   CROSS APPLY sys.dm_exec_sql_text(sql_handle) t
 INNER JOIN sys.dm_exec_sessions s
    ON r.session_id = s.session_id
     WHERE r.session_id = @SPID;
GO
IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'UTIL_ListCurrentRunningQueries'
)
    DROP PROCEDURE UTIL_ListCurrentRunningQueries;
	GO
CREATE PROC UTIL_ListCurrentRunningQueries
AS

     /*Lists all currently running queries in SQL Server and their text*/

     SELECT r.session_id, 
     s.host_name, 
     s.login_name, 
     s.original_login_name, 
     r.STATUS, 
     r.command, 
     r.cpu_time, 
     r.total_elapsed_time, 
     t.text AS Query_Text
     FROM sys.dm_exec_requests r
   CROSS APPLY sys.dm_exec_sql_text(sql_handle) t
 INNER JOIN sys.dm_exec_sessions s
    ON r.session_id = s.session_id;
GO
GRANT EXECUTE ON OBJECT ::dbo.UTIL_ListCurrentRunningQueries TO public;
GO

/* drop TABLE [dbo].[DFS_BlockingHistory]*/

IF EXISTS
(
    SELECT 1
    FROM sys.tables
    WHERE name = 'DFS_BlockingHistory'
)
	DROP TABLE [dbo].[DFS_BlockingHistory];

CREATE TABLE [dbo].[DFS_BlockingHistory]
    ([session_id]   [SMALLINT] NOT NULL, 
     [blocking_session_id] [SMALLINT] NULL, 
     [cpu_time]     [INT] NOT NULL, 
     [total_elapsed_time]  [INT] NOT NULL, 
     [Database_Name]  [NVARCHAR](150) NULL, 
     [host_name]    [NVARCHAR](150) NULL, 
     [login_name]   [NVARCHAR](150) NOT NULL, 
     [original_login_name] [NVARCHAR](150) NOT NULL, 
     [STATUS]  [NVARCHAR](30) NOT NULL, 
     [command] [NVARCHAR](16) NOT NULL, 
     [Query_Text]   [NVARCHAR](MAX) NULL, 
     CreateDate     DATETIME NULL, 
     RunID   INT NULL, 
	 [UID] uniqueidentifier default newid()
     --RowNbr  INT IDENTITY(1, 1) NOT NULL
    )
    ON [PRIMARY];

	CREATE INDEX pi_DFS_BlockingHistory ON [DFS_BlockingHistory] ([uid]);
	

GO
IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'UTIL_ListQueryAndBlocks'
)
    DROP PROCEDURE UTIL_ListQueryAndBlocks;
	GO

/*Lists database name that requests are executing against and blocking session ID for blocked queries:
 select top 1000 * from [dbo].[DFS_BlockingHistory]
 truncate table [dbo].[DFS_BlockingHistory]*/
/*
declare @msg NVARCHAR(150);
declare @i int = 1 ;
while (@i <60)
begin
	set @msg = '@I = ' + cast(@i as nvarchar(10));
	exec sp_printimmediate @msg;
	waitfor delay '00:00:10'
	exec UTIL_ListQueryAndBlocks
	set @i = @i + 1;	
end
select top 20 * from [dbo].[DFS_BlockingHistory] order by RowNbr desc;

select Count(*) SpidCnt, RunID from [dbo].[DFS_BlockingHistory] Group by RunID order by RunID;

exec UTIL_ListQueryAndBlocks
select top 25 * from [dbo].[DFS_BlockingHistory] order by RowNbr desc
*/

CREATE PROC UTIL_ListQueryAndBlocks
AS
    BEGIN
 DECLARE @RunID INT= 0;
 DECLARE @cnt INT= 0;
 SET @cnt =
 (
     SELECT COUNT(*)
     FROM sys.dm_exec_requests
     WHERE [blocking_session_id] > 0
 );
 IF @cnt > 0
     BEGIN
  EXEC @RunID = dbo.UTIL_GetSeq;
  PRINT 'RUNID: ' + CAST(@RunID AS NVARCHAR(10)) + '->Blocked Count: ' + CAST(@cnt AS NVARCHAR(10));
  WITH BlockedSpids
  AS (SELECT [blocking_session_id] AS SID
    FROM sys.dm_exec_requests
    WHERE [blocking_session_id] > 0
    UNION ALL
    SELECT [session_id]
    FROM sys.dm_exec_requests
    WHERE [blocking_session_id] > 0)
  INSERT INTO [dbo].[DFS_BlockingHistory]
  ( [session_id], 
    [blocking_session_id], 
    [cpu_time], 
    [total_elapsed_time], 
    [Database_Name], 
    [host_name], 
    [login_name], 
    [original_login_name], 
    [STATUS], 
    [command], 
    [Query_Text], 
    [CreateDate], 
    RunID,
					   [UID]
  ) 
  SELECT r.session_id, 
  r.blocking_session_id, 
  r.cpu_time, 
  r.total_elapsed_time, 
  DB_NAME(r.database_id) AS Database_Name, 
  s.host_name, 
  s.login_name, 
  s.original_login_name, 
  r.STATUS, 
  r.command, 
  t.text AS Query_Text, 
  GETDATE(), 
  @RunID,
								   newid()
  FROM sys.dm_exec_requests r
     CROSS APPLY sys.dm_exec_sql_text(sql_handle) t
   INNER JOIN sys.dm_exec_sessions s
   ON r.session_id = s.session_id
 JOIN BlockedSpids B
   ON r.session_id = B.sid;
 END;
    END;
GO
GRANT EXECUTE ON OBJECT ::dbo.UTIL_ListQueryAndBlocks TO public;
GO
IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'UTIL_ListBlocks'
)
    DROP PROCEDURE UTIL_ListBlocks;
	GO
CREATE PROC UTIL_ListBlocks
AS

     /*Only running queries that are blocked and session ID of blocking queries:*/

     SELECT r.session_id, 
     r.blocking_session_id, 
     DB_NAME(r.database_id) AS Database_Name, 
     s.host_name, 
     s.login_name, 
     s.original_login_name, 
     r.STATUS, 
     r.command, 
     r.cpu_time, 
     r.total_elapsed_time, 
     t.text AS Query_Text
     FROM sys.dm_exec_requests r
   CROSS APPLY sys.dm_exec_sql_text(sql_handle) t
 INNER JOIN sys.dm_exec_sessions s
    ON r.session_id = s.session_id
     WHERE r.blocking_session_id <> 0;
GO
GRANT EXECUTE ON OBJECT ::dbo.UTIL_ListBlocks TO public;
GO
IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'UTIL_ListMostCommonWaits'
)
    DROP PROCEDURE UTIL_ListMostCommonWaits;
	GO
CREATE PROC UTIL_ListMostCommonWaits
AS

     /*Display the top 10 most frequent WAITS occuring in the DB*/

     SELECT TOP 10 wait_type, 
     wait_time_ms, 
     Percentage = 100. * wait_time_ms / SUM(wait_time_ms) OVER()
     FROM sys.dm_os_wait_stats wt
     WHERE wt.wait_type NOT LIKE '%SLEEP%'
     ORDER BY Percentage DESC;
GO
GRANT EXECUTE ON OBJECT ::dbo.UTIL_ListMostCommonWaits TO public;

/* W. Dale Miller
 DMA, Limited
 Offered under GNU License
 July 26, 2016PRINT '--- "D:\dev\SQL\DFINAnalytics\FindBlockedSPIDS.sql"' */

/****************** PROCESSING FILE *************************************/

GO  
PRINT 'ID# 180'  
print 'D:\dev\SQL\DFINAnalytics\findLocks.sql' 
--* USEDFINAnalytics
go

/* IF NEEDED, RUN THIS
go
sp_configure 'Show Advanced Options', 1
GO
RECONFIGURE
GO
sp_configure 'Ad Hoc Distributed Queries', 1
GO
RECONFIGURE
*/
/*
exec sp_who2 

select spid, status, Blocked,  open_tran, waitresource, waittype, waittime, cmd, lastwaittype
from dbo.sysprocesses
where Blocked <> 0

dbcc inputbuffer (21)
dbcc inputbuffer (64)

exec sp_lock 56
exec sp_lock 
*/

-- UTIL_findLocks;
GO

IF EXISTS ( SELECT name
     FROM sys.procedures
     WHERE name = 'UTIL_findLocks'
   ) 
    BEGIN
 DROP PROCEDURE UTIL_findLocks;
END;
GO

-- exec UTIL_findLocks
CREATE PROCEDURE UTIL_findLocks
AS
    BEGIN
 SET NOCOUNT ON;
 IF OBJECT_ID('TempDB.dbo.#TempLocks') IS NOT NULL
		DROP TABLE #TempLocks;

 --declare @tsql as nvarchar(1000) = '' ;
 --declare @tcmd as nvarchar(1000) = 'exec sp_lock 63' ;
 --set  @tsql = @tsql + ' SELECT * INTO #TempLocks ' + char(10) ;
 --set  @tsql = @tsql + ' FROM OPENROWSET (''SQLNCLI'', ''Server=localhost;Trusted_Connection=yes;'', '''+@tcmd+''' ) ;' ;
 --exec (@tsql) ;

 IF OBJECT_ID('TempDB.dbo.#TEmpBlocked') IS NOT NULL
     DROP TABLE #TEmpBlocked;
 
 SELECT spid , STATUS , blocked , open_tran , waitresource , waittype , waittime , cmd , lastwaittype
 INTO #TempBlocked
 FROM dbo.sysprocesses
 WHERE blocked <> 0;
 IF ( SELECT COUNT(*)
 FROM #TempBlocked
    ) = 0
     BEGIN
  PRINT 'NO Blocks found.';
  RETURN;
 END;

 --    SELECT
 --    * INTO
 --    #TempBlocked
 --    FROM OPENROWSET ('SQLNCLI', 'Server=localhost;Trusted_Connection=yes;', 'select spid, status, Blocked, open_tran, waitresource, waittype, waittime, cmd, lastwaittype
 --from dbo.sysprocesses
 --where Blocked <> 0') ;
 --select * from #TempBlocked

 DECLARE @lastwaittype NVARCHAR(1000)= '';
 DECLARE @CMD NVARCHAR(1000)= '';
 DECLARE @waitresource NVARCHAR(1000)= '';
 DECLARE @waittype BINARY(2)= NULL;
 DECLARE @waittime BIGINT= NULL;
 DECLARE @open_tran INT= 0;
 DECLARE @Blocked INT= 0;
 DECLARE @spid INT= 0;
 DECLARE @status AS NVARCHAR(100)= '';
 DECLARE @spid2 AS INT= NULL;
 DECLARE @dbid AS INT= NULL;
 DECLARE @txtObjId AS NVARCHAR(100)= NULL;
 DECLARE @ObjId AS INT= NULL;
 DECLARE @InDid AS INT= NULL;
 DECLARE @Type AS NVARCHAR(100)= NULL;
 DECLARE @Resource AS NVARCHAR(100)= NULL;
 DECLARE @Mode AS NVARCHAR(100)= NULL;
 DECLARE @Status2 AS NVARCHAR(100)= NULL;
 DECLARE @MyParm AS NVARCHAR(100)= NULL;
 DECLARE @MySql AS NVARCHAR(4000)= NULL;
 DECLARE C CURSOR
 FOR SELECT spid , STATUS , Blocked , open_tran , waitresource , waittype , waittime , cmd , lastwaittype
     FROM #TEmpBlocked;
 OPEN C;
 FETCH NEXT FROM C INTO @spid , @status , @Blocked , @open_tran , @waitresource , @waittype , @waittime , @cmd , @lastwaittype;
 PRINT '@spid';
 PRINT @spid;
 WHILE @@FETCH_STATUS = 0
     BEGIN

  --print 'SPID: ' + cast(@spid as nvarchar(50)) ;
  SET @waitresource = LTRIM(@waitresource);
  SET @waitresource = RTRIM(@waitresource);
  --print '-' + @waitresource + '-'
  SET @MyParm = 'EXEC SP_LOCK ' + CAST(@Blocked AS NVARCHAR(50));
  PRINT '@MyParm: ' + @MyParm;
  BEGIN TRY
 DROP TABLE #TempLocks;
  END TRY
  BEGIN CATCH
 EXEC sp_PrintImmediate 'filling table #TempLocks ';
  END CATCH;

  --declare @MySql nvarchar(1000) = '' ;
  --declare @Blocked as int = 50 ;
  --declare @MyParm nvarchar(1000) = 'EXEC SP_LOCK ' + cast(@Blocked as nvarchar(50)) ;

  SET @MySql = 'SELECT * INTO #TempLocks ';
  SET @MySql = @MySql + '   FROM OPENROWSET (''SQLNCLI'', ''Server=localhost;Trusted_Connection=yes;'', ''' + @MyParm + ''' ) '; 
  --print @MySql ;
  EXEC (@MySql);
  DECLARE C2 CURSOR
  FOR SELECT spid , dbid , ObjId , InDid , Type , resource , Mode , STATUS
 FROM #TempLocks;
  OPEN C2;
  FETCH NEXT FROM C2 INTO @spid2 , @dbid , @ObjId , @InDid , @Type , @resource , @Mode , @Status2;
  WHILE @@FETCH_STATUS = 0
 BEGIN
   SET @txtObjId = CAST(@ObjId AS NVARCHAR(50));
   --print @txtObjId +',' + @Status2 ;
   IF CHARINDEX(@txtObjId , @waitresource) > 0
 AND 
 @txtObjId <> '0'
  BEGIN
    PRINT 'SPID ' + CAST(@spid AS NVARCHAR(50)) + ' is blocking ' + CAST(@Blocked AS NVARCHAR(50)) + ', at the ' + @Type + ' Level, with a Mode of ' + @mode + ' and a status of ' + @Status2 + ' / from COMMAND: ' + @cmd;
   END;
   FETCH NEXT FROM C2 INTO @spid2 , @dbid , @ObjId , @InDid , @Type , @resource , @Mode , @status2;
 END;
  CLOSE C2;
  DEALLOCATE C2;
  FETCH NEXT FROM C INTO @spid , @status , @Blocked , @open_tran , @waitresource , @waittype , @waittime , @cmd , @lastwaittype;
     END;
 CLOSE C;
 DEALLOCATE C;
 SET NOCOUNT OFF;
    END;
GO

PRINT 'Executed findLocks.sql';
GO

/*
SELECT * INTO #TempLocks    FROM OPENROWSET ('SQLNCLI', 'Server=localhost;Trusted_Connection=yes;', 'EXEC SP_LOCK 53' ) 
select * from #TempLocks
*/

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016PRINT '--- "D:\dev\SQL\DFINAnalytics\findLocks.sql"' 


/****************** PROCESSING FILE *************************************/

GO  
PRINT 'ID# 190'  
print 'D:\dev\SQL\DFINAnalytics\MonitorBlockingDetail.sql' 

/*
REPLACED BY FindBlockingDetail.sql
*/
--* USEDFINAnalytics;
GO
-- drop table [dbo].[DFS_TranLocks]
IF EXISTS
(
    SELECT 1
    FROM   sys.tables
    WHERE  name = 'DFS_TranLocks'
)
	DROP TABLE [dbo].[DFS_TranLocks];


CREATE TABLE [dbo].[DFS_TranLocks]
    ([SPID]   [INT] NOT NULL, 
     [DatabaseName]  [NVARCHAR](150) NULL, 
     [LockedObjectName]     [SYSNAME] NOT NULL, 
     [LockedObjectId]  [INT] NOT NULL, 
     [LockedResource]  [NVARCHAR](60) NOT NULL, 
     [LockType] [NVARCHAR](60) NOT NULL, 
     [SqlStatementText]     [NVARCHAR](MAX) NULL, 
     [LoginName]     [NVARCHAR](150) NOT NULL, 
     [HostName] [NVARCHAR](150) NULL, 
     [IsUserTransaction]    [BIT] NOT NULL, 
     [TransactionName] [NVARCHAR](32) NOT NULL, 
     [AuthenticationMethod] [NVARCHAR](40) NOT NULL, 
     RunID    INT NULL, 
     CreateDate DATETIME DEFAULT GETDATE(), 
	 [UID] uniqueidentifier default newid()
     --RowNbr   INT IDENTITY(1, 1)
    )
    ON [PRIMARY] ;

	CREATE INDEX pi_DFS_TranLocks ON DFS_TranLocks ([uid]);

GO

--* USEMASTER;
GO
-- Select top 20 * from DFS_TranLocks order by RowNbr desc
-- exec sp_DFS_MonitorLocks 
IF EXISTS
(
    SELECT 1
    FROM   sys.procedures
    WHERE  name = 'sp_DFS_MonitorLocks '
)
    DROP PROCEDURE sp_DFS_MonitorLocks;
GO

--* USEmaster;
go
-- exec sp_DFS_MonitorLocks
-- select top 20 * from [DFS_TranLocks] order by RowNbr desc;
IF EXISTS (SELECT 1 FROM sys.procedures WHERE name = 'sp_DFS_MonitorLocks')
drop PROCEDURE sp_DFS_MonitorLocks;
go
CREATE PROCEDURE sp_DFS_MonitorLocks
AS
begin
     DECLARE @RunID INT;
     EXEC @RunID = dbo.UTIL_GetSeq;
     INSERT INTO dbo.[DFS_TranLocks]
     ([SPID], 
 [DatabaseName], 
 [LockedObjectName], 
 [LockedObjectId], 
 [LockedResource], 
 [LockType], 
 [SqlStatementText], 
 [LoginName], 
 [HostName], 
 [IsUserTransaction], 
 [TransactionName], 
 [AuthenticationMethod], 
 [RunID], 
 [CreateDate],
	  [UID]
     )
     SELECT LOCKS.request_session_id AS SPID, 
     DB_NAME(LOCKS.resource_database_id) AS DatabaseName, 
     OBJ.Name AS LockedObjectName, 
     P.object_id AS LockedObjectId, 
     LOCKS.resource_type AS LockedResource, 
     LOCKS.request_mode AS LockType, 
     ST.text AS SqlStatementText, 
     ES.login_name AS LoginName, 
     ES.host_name AS HostName, 
     SESSIONTX.is_user_transaction AS IsUserTransaction, 
     ATX.name AS TransactionName, 
     CN.auth_scheme AS AuthenticationMethod, 
     @RunID, 
     GETDATE(),
			newid()
     FROM   sys.dm_tran_locks LOCKS
     JOIN sys.partitions P
  ON P.hobt_id = LOCKS.resource_associated_entity_id
     JOIN sys.objects OBJ
  ON OBJ.object_id = P.object_id
     JOIN sys.dm_exec_sessions ES
  ON ES.session_id = LOCKS.request_session_id
     JOIN sys.dm_tran_session_transactions SESSIONTX
  ON ES.session_id = SESSIONTX.session_id
     JOIN sys.dm_tran_active_transactions ATX
  ON SESSIONTX.transaction_id = ATX.transaction_id
     JOIN sys.dm_exec_connections CN
  ON CN.session_id = ES.session_id
     CROSS APPLY sys.dm_exec_sql_text(CN.most_recent_sql_handle) AS ST
     WHERE  resource_database_id = DB_ID()
     ORDER BY LOCKS.request_session_id;

	 update dbo.[DFS_TranLocks] set RunID = @RunID, CreateDate = getdate() where RunID is null

     -- W. Dale Miller
     -- DMA, Limited
     -- Offered under GNU License
     -- July 26, 2016
end


/****************** PROCESSING FILE *************************************/

GO  
PRINT 'ID# 200'  
print 'D:\dev\SQL\DFINAnalytics\UTIL_MonitorDeadlocks.sql' 

/*
exec sp_UTIL_DFS_DeadlockStats
go
SELECT *
FROM dbo.DFS_DeadlockStats
*/

----* USEmaster;
GO
DECLARE @runnow INT= 0;
IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'sp_UTIL_DFS_DeadlockStats'
)
   AND @runnow = 1
    BEGIN
 /*declare @RunID BIGINT = NEXT VALUE FOR master_seq;*/

 DECLARE @RunID BIGINT;
 EXEC @RunID = dbo.UTIL_GetSeq;
 PRINT @RunID;
 DECLARE @command VARCHAR(1000);
 SELECT @command = '--* USE?; exec sp_UTIL_DFS_DeadlockStats ' + CAST(@RunID AS NVARCHAR(25)) + ' ;';
 EXEC sp_MSforeachdb 
 @command;
END;
go

----* USEDFINAnalytics;
go
--drop table dbo.DFS_DeadlockStats
IF EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.tables
    WHERE table_name = 'DFS_DeadlockStats'
)
	DROP TABLE DFS_DeadlockStats;

CREATE TABLE DFS_DeadlockStats
    (SPID INT, 
     STATUS VARCHAR(1000) NULL, 
     Login  SYSNAME NULL, 
     HostName    SYSNAME NULL, 
     BlkBy  SYSNAME NULL, 
     DBName SYSNAME NULL, 
     Command     VARCHAR(1000) NULL, 
     CPUTime     INT NULL, 
     DiskIO INT NULL, 
     LastBatch   VARCHAR(1000) NULL, 
     ProgramName VARCHAR(1000) NULL, 
     SPID2  INT, 
     REQUESTID   INT NULL, 
     RunDate     DATETIME DEFAULT GETDATE(), 
     RunID  INT, 
     [UID] uniqueidentifier default newid()
    );
	create index PI_DFS_DeadlockStats on DFS_DeadlockStats (RunID, [UID]) ;
	create index PI_DFS_DeadlockStatsUID on DFS_DeadlockStats ([UID]) ;

GO
----* USEmaster
go
IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'sp_UTIL_DFS_DeadlockStats'
)
    DROP PROCEDURE sp_UTIL_DFS_DeadlockStats;
GO
-- exec sp_UTIL_DFS_DeadlockStats
CREATE PROCEDURE sp_UTIL_DFS_DeadlockStats (@RunID int)
AS
    BEGIN
 IF OBJECT_ID('tempdb..#tempDFS_DeadlockStats') IS NOT NULL
     DROP TABLE #tempDFS_DeadlockStats;
 CREATE TABLE #tempDFS_DeadlockStats
 (SPID INT, 
  STATUS VARCHAR(1000) NULL, 
  Login  SYSNAME NULL, 
  HostName    SYSNAME NULL, 
  BlkBy  SYSNAME NULL, 
  DBName SYSNAME NULL, 
  Command     VARCHAR(1000) NULL, 
  CPUTime     INT NULL, 
  DiskIO INT NULL, 
  LastBatch   VARCHAR(1000) NULL, 
  ProgramName VARCHAR(1000) NULL, 
  SPID2  INT, 
  REQUESTID   INT NULL --comment out for SQL 2000 databases
 );
 -- select * from #tempDFS_DeadlockStats
 INSERT INTO #tempDFS_DeadlockStats
 EXEC sp_who2;
 
 --SET @RUNID = 78;
 INSERT INTO dbo.DFS_DeadlockStats
   SELECT SPID, 
   STATUS, 
   Login, 
   HostName, 
   BlkBy, 
   DBName, 
   Command, 
   CPUTime, 
   DiskIO, 
   LastBatch, 
   ProgramName, 
   SPID2, 
   REQUESTID, 
   GETDATE(), 
   RunID = @RUNID,
					  NEWID() AS [UID]
   FROM #tempDFS_DeadlockStats;
 --WHERE DBName = 'DFINAnalytics';
 UPDATE dbo.DFS_DeadlockStats
   SET 
  BlkBy = NULL
 WHERE LTRIM(blkby) = '.';

 --SELECT * FROM dbo.DFS_DeadlockStats;
 --update dbo.DFS_DeadlockStats set BlkBy = 264 where RowID = 260

 DECLARE @BlockedSPIDS TABLE(BlockedSpid uniqueidentifier);
 INSERT INTO @BlockedSPIDS(BlockedSpid)
 (
     --select cast(blkby as int) as BlockedSpid from dbo.DFS_DeadlockStats where blkby is not null
     SELECT [UID] AS BlockedSpid
     FROM dbo.DFS_DeadlockStats
     WHERE blkby IS NOT NULL
    AND RunID = @RUNID
 );
 --select * from @BlockedSPIDS;

 DECLARE @BlockingSPIDS TABLE(BlockedingSpid uniqueidentifier);
 INSERT INTO @BlockingSPIDS(BlockedingSpid)
 (
     --select cast(blkby as int) as BlockedSpid from dbo.DFS_DeadlockStats where blkby is not null
     SELECT [UID] AS BlockedingSpid
     FROM dbo.DFS_DeadlockStats
     WHERE [UID] IN
     (
  SELECT BlockedSpid
  FROM @BlockedSPIDS
     )
 );
 --select * from @BlockingSPIDS;

 UPDATE dbo.DFS_DeadlockStats
   SET 
  BlkBy = 'X'
 WHERE dbo.DFS_DeadlockStats.[UID] IN
 (
     SELECT BlockedingSpid
     FROM @BlockingSPIDS
 );
 DELETE FROM dbo.DFS_DeadlockStats
 WHERE BlkBy IS NULL
  AND RUNID = @RUNID;
    END;
GO



-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016


/****************** PROCESSING FILE *************************************/

GO  
PRINT 'ID# 210'  
print 'D:\dev\SQL\DFINAnalytics\UTIL_ReorgFragmentedIndexes.sql' 

/* W. Dale Miller
 wdalemiller@gmail.com*/

--* USEDFINAnalytics;
GO
DECLARE @runnow INT= 0;
IF @runnow = 1
    BEGIN

/*declare @RunID BIGINT = NEXT VALUE FOR master_seq;
		truncate TABLE [dbo].[DFS_IndexStats];
		select top 100 * from [dbo].[DFS_IndexStats];
		*/
 DECLARE @command VARCHAR(1000);
 SELECT @command = '--* USE?; exec sp_UTIL_ReorgFragmentedIndexes 0;';
 EXEC sp_MSforeachdb 
 @command;
END;
GO

/*drop TABLE [dbo].DFS_IndexFragReorgHistory*/

IF NOT EXISTS
(
    SELECT 1
    FROM information_schema.tables
    WHERE table_name = 'DFS_IndexFragReorgHistory'
)
    BEGIN
 CREATE TABLE [dbo].DFS_IndexFragReorgHistory
 ([DBName] [NVARCHAR](150) NULL, 
  [Schema] NVARCHAR(150) NOT NULL, 
  [Table]  NVARCHAR(150) NOT NULL, 
  [Index]  NVARCHAR(150) NULL, 
  [OnlineReorg] [VARCHAR](10) NULL, 
  [Success]     [VARCHAR](10) NULL, 
  Rundate  DATETIME NULL, 
  RunID  NVARCHAR(60) NULL, 
  Stmt   VARCHAR(MAX) NULL, 
		 [UID] uniqueidentifier default newid(),
  RowNbr INT IDENTITY(1, 1) NOT NULL
 )
 ON [PRIMARY];
 ALTER TABLE [dbo].DFS_IndexFragReorgHistory
 ADD DEFAULT(GETDATE()) FOR [RunDate];
END;

/****** Object:  StoredProcedure [dbo].[sp_UTIL_ReorgFragmentedIndexes]    Script Date: 1/10/2019 4:27:24 PM ******/

GO

/* select * FROM dbo.DFS_IndexFragHist 
 exec sp_UTIL_ReorgFragmentedIndexes 'B5E6A690-F150-44E2-BF57-AB4765A94357', 0*/

--* USEmaster;
GO
IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'sp_UTIL_ReorgFragmentedIndexes'
)
    BEGIN
 DROP PROCEDURE sp_UTIL_ReorgFragmentedIndexes;
END;
GO

/* EXEC sp_UTIL_ReorgFragmentedIndexes 0;*/

CREATE PROCEDURE [dbo].[sp_UTIL_ReorgFragmentedIndexes](@PreviewOnly INT = 1)
AS
    BEGIN
	IF CURSOR_STATUS('global','CursorReorg')>=-1
	BEGIN
	 DEALLOCATE CursorReorg
	END
 /********************CLEAN UP THE INDEXES TO BE PROCESSED *****************		  */

 DELETE FROM [dbo].[DFS_IndexFragHist]
 WHERE [Index] IS NULL;
 DELETE FROM [dbo].[DFS_IndexFragHist]
 WHERE EXISTS
 (
     SELECT *
     FROM [dbo].[DFS_IndexFragHist] AS b
     WHERE b.[DBName] = [dbo].[DFS_IndexFragHist].[DBName]
    AND b.[Schema] = [dbo].[DFS_IndexFragHist].[Schema]
    AND b.[Table] = [dbo].[DFS_IndexFragHist].[Table]
    AND b.[Index] = [dbo].[DFS_IndexFragHist].[Index]
    AND b.IndexProcessed = [dbo].[DFS_IndexFragHist].[IndexProcessed]
     GROUP BY b.[DBName], 
  b.[Schema], 
  b.[Table], 
  b.[Index], 
  b.IndexProcessed
     HAVING [dbo].[DFS_IndexFragHist].[RowNbr] > MIN(b.[RowNbr])
 );

 /********************************************************************************/

 DECLARE @msg NVARCHAR(2000);
 DECLARE @RunID VARCHAR(60);
 DECLARE @stmt NVARCHAR(2000);
 DECLARE @Rownbr INT;
 DECLARE @TotCnt INT;
 DECLARE @i INT= 0;
 DECLARE @dbname NVARCHAR(100);
 DECLARE @Schema NVARCHAR(100), @Table NVARCHAR(100), @Index NVARCHAR(100);
 SET @TotCnt =
 (
     SELECT COUNT(*)
     FROM [dbo].[DFS_IndexFragHist]
     WHERE IndexProcessed = 0
 );
 DELETE FROM [dbo].[DFS_IndexFragHist]
 WHERE DBNAME IN
 (
     SELECT DB
     FROM dbo.[DFS_DB2Skip]
 );
 DECLARE CursorReorg CURSOR
 FOR SELECT DBName, 
     [Schema], 
     [Table], 
     [Index], 
     Rownbr, 
     RunID
     FROM dbo.DFS_IndexFragHist
     WHERE IndexProcessed != 1
    AND [index] IS NOT NULL;
 OPEN CursorReorg;
 FETCH NEXT FROM CursorReorg INTO @DBName, @Schema, @Table, @Index, @Rownbr, @RunID;
 WHILE @@FETCH_STATUS = 0
     BEGIN
  SET @i = @i + 1;
  SET @msg = '#' + CAST(@i AS NVARCHAR(10)) + ' of ' + CAST(@TotCnt AS NVARCHAR(10));
  SET @msg = 'REORGANIZE: ' + @DBName + '.' + @Schema + '.' + @Table + ' / ' + @Index;
  EXEC sp_PrintImmediate 
  @msg;
  SET @stmt = 'ALTER Index ' + @Index + ' ON ' + @DBName + '.' + @Schema + '.' + @Table;

  /*SET @stmt = @stmt + ' REORGANIZE ';*/

  SET @stmt = @stmt + ' REBUILD WITH ';
  SET @stmt = @stmt + '(';
  SET @stmt = @stmt + '  FILLFACTOR = 80 ';
  SET @stmt = @stmt + '  ,ONLINE = ON ';
  SET @stmt = @stmt + ');';
  IF @PreviewOnly = 1
 BEGIN
   PRINT('Preview: ' + @stmt);
  END;
  IF @PreviewOnly = 0
 BEGIN
   BEGIN TRY
  SET @msg = 'Starting the REBUILD: ON ' + @DBName + '.' + @Schema + '.' + @Table;
  EXEC sp_PrintImmediate 
     @msg;
  EXECUTE sp_executesql 
   @stmt;
  BEGIN TRY
    INSERT INTO [dbo].[DFS_IndexFragReorgHistory]
    ( [DBName], 
 [Schema], 
 [Table], 
 [Index], 
 [OnlineReorg], 
 [Success], 
 [Rundate], 
 [RunID], 
 [Stmt]
    ) 
    VALUES
    (
      @DBName
    , @Schema
    , @Table
    , @Index
    , 'YES'
    , 'YES'
    , GETDATE()
    , @RunID
    , @stmt
    );
  END TRY
  BEGIN CATCH
    SET @msg = 'FAILED TO SAVE HISTORY:';
    SET @msg = @msg + '|' + @DBName;
    SET @msg = @msg + '.' + @Schema;
    SET @msg = @msg + '.' + @Table;
    SET @msg = @msg + '.' + @Index;
    SET @msg = @msg + ' @' + @stmt;
    SET @msg = @msg + '@';
    EXEC sp_PrintImmediate 
    @msg;
    SET @msg = 'ERR MSG @0: ' +
    (
   SELECT ERROR_MESSAGE()
    );
    EXEC sp_PrintImmediate 
    @msg;
  END CATCH;
  END TRY
   BEGIN CATCH
  SET @msg = '-- **************************************';
  EXEC sp_PrintImmediate 
     @msg;
  SET @msg = 'ERR MSG @1: ' +
  (
    SELECT ERROR_MESSAGE()
  );
  EXEC sp_PrintImmediate 
     @msg;
  SET @msg = 'CURRENT DB: ' + @dbname;
  EXEC sp_PrintImmediate 
     @msg;
  SET @msg = 'ERROR: ' + @stmt;
  EXEC sp_PrintImmediate 
     @msg;
  BEGIN TRY
    SET @stmt = 'ALTER Index ' + @Index + ' ON ' + @DBName + '.' + @Schema + '.' + @Table;
    SET @stmt = @stmt + ' reorganize;';

/*SET @stmt = 'ALTER Index ' + @Index + ' ON ' + @DBName + '.' + @Schema + '.' + @Table;
    SET @stmt = @stmt + ' reorganize;';*/

    EXECUTE sp_executesql 
     @stmt;
    PRINT '-- **************************************';
    SET @msg = 'Reorganize : ' + @stmt;
    EXEC sp_PrintImmediate 
    @msg;
    PRINT '-- **************************************';
    INSERT INTO [dbo].[DFS_IndexFragReorgHistory]
    ( [DBName], 
 [Schema], 
 [Table], 
 [Index], 
 [OnlineReorg], 
 [Success], 
 [Rundate], 
 [RunID], 
 [Stmt]
    ) 
    VALUES
    (
      @DBName
    , @Schema
    , @Table
    , @Index
    , 'NO @1'
    , 'YES'
    , GETDATE()
    , @RunID
    , @stmt
    );
  END TRY
  BEGIN CATCH
    SET @msg = 'ERR MSG: ' +
    (
   SELECT ERROR_MESSAGE()
    );
    EXEC sp_PrintImmediate 
    @msg;
    INSERT INTO [dbo].[DFS_IndexFragErrors]
    ( [SqlCmd], 
 DBNAME
    ) 
    VALUES
    (
      @stmt
    , @DBName
    );
    INSERT INTO [dbo].[DFS_IndexFragReorgHistory]
    ( [DBName], 
 [Schema], 
 [Table], 
 [Index], 
 [OnlineReorg], 
 [Success], 
 [Rundate], 
 [RunID], 
 [Stmt]
    ) 
    VALUES
    (
      @DBName
    , @Schema
    , @Table
    , @Index
    , 'NO @2'
    , 'NO'
    , GETDATE()
    , @RunID
    , @stmt
    );
  END CATCH;
  END CATCH;
  END;
  IF @PreviewOnly = 0
 BEGIN
   UPDATE [dbo].[DFS_IndexFragHist]
     SET 
    IndexProcessed = 1
   WHERE RowNbr = @Rownbr;
  END;
  FETCH NEXT FROM CursorReorg INTO @DBName, @Schema, @Table, @Index, @Rownbr, @RunID;
     END;
 CLOSE CursorReorg;
 DEALLOCATE CursorReorg;
    END;

/****************** PROCESSING FILE *************************************/

GO  
PRINT 'ID# 220'  
print 'D:\dev\SQL\DFINAnalytics\UTIL_TableGrowthHistory.sql' 
-- W. Dale Miller @ 2016
--* USE DFINAnalytics; -- replace your dbname
GO

-- drop table DFS_TableGrowthHistory
-- select top 1000 * from DFS_TableGrowthHistory order by DBname, TableName, Rownbr desc;
-- select count(*) from DFS_TableGrowthHistory ;
IF EXISTS
(
    SELECT 1
    FROM   information_schema.tables
    WHERE  table_name = 'DFS_TableGrowthHistory'
)
drop table DFS_TableGrowthHistory;

    CREATE TABLE [dbo].[DFS_TableGrowthHistory]
    ([SvrName]    [SYSNAME] NOT NULL, 
     [DBName]     [SYSNAME] NOT NULL, 
     [SchemaName] [SYSNAME] NOT NULL, 
     [TableName]  [SYSNAME] NOT NULL, 
     [RowCounts]  [BIGINT] NOT NULL, 
     [Used_MB]    [NUMERIC](36, 2) NULL, 
     [Unused_MB]  [NUMERIC](36, 2) NULL, 
     [Total_MB]   [NUMERIC](36, 2) NULL, 
     RunID NVARCHAR(60) NULL, 
     CreateDate   DATETIME DEFAULT GETDATE(),
	 [UID] uniqueidentifier default newid(), 
     RowNbr  INT IDENTITY(1, 1) NOT NULL
    )
    ON [PRIMARY];


CREATE INDEX pidx_DFS_TableGrowthHistory
ON DFS_TableGrowthHistory
(DBname, TableName, Rownbr
);

-- select * from viewTableGrowthStats
IF EXISTS
(
    SELECT 1
    FROM   information_schema.tables
    WHERE  table_name = 'viewTableGrowthStats'
)
    DROP VIEW viewTableGrowthStats;
GO
CREATE VIEW viewTableGrowthStats
AS
     SELECT DBName, 
     SchemaName, 
     TableName, 
     MIN(RowCounts) StartRowCnt, 
     MAX(RowCounts) EndRowCnt, 
     MAX(RowCounts) - MIN(RowCounts) AS RowGrowth, 
     MIN(Used_MB) StartMB, 
     MAX(Used_MB) EndMB, 
     MAX(Used_MB) - MIN(Used_MB) AS MBGrowth, 
     DATEDIFF(DAY, MIN(CreateDate), MAX(CreateDate)) AS OverNbrDays
     FROM   DFS_TableGrowthHistory
     GROUP BY DBName, 
  SchemaName, 
  TableName;
GO

--* USE master;
go

IF EXISTS
(
    SELECT 1
    FROM   sys.procedures
    WHERE  name = 'sp_UTIL_TableGrowthHistory'
)
    DROP PROCEDURE sp_UTIL_TableGrowthHistory;
GO
/*
DECLARE @RunID BIGINT;
EXEC @RunID = dbo.UTIL_GetSeq;
PRINT 'RUN ID: ' + cast(@RunID as nvarchar(10));
DECLARE @command NVARCHAR(1000);
SELECT @command = '--* USE?; exec sp_UTIL_TableGrowthHistory ' + CAST(@RunID AS NVARCHAR(10)) ;
print @command;
EXEC sp_MSforeachdb @command;
*/
create PROCEDURE dbo.sp_UTIL_TableGrowthHistory (@RunID int )
AS
    BEGIN
		DECLARE @DBNAME NVARCHAR(100)= DB_NAME();
 DECLARE @x INT;
 EXEC @x = sp_ckProcessDB;
 IF(@x < 1)
     RETURN;
 DECLARE @msg NVARCHAR(1000);
 SET @msg = 'Processing DB: ' + @DBNAME;
 EXEC [dbo].[printimmediate] 
 @msg;
 DECLARE @stmt NVARCHAR(4000);
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
 SELECT @@ServerName, 
   [DBNAME] = DB_NAME(), 
   s.Name AS SchemaName, 
   t.Name AS TableName, 
   p.rows AS RowCounts, 
   CAST(ROUND((SUM(a.used_pages) / 128.00), 2) AS NUMERIC(36, 2)) AS Used_MB, 
   CAST(ROUND((SUM(a.total_pages) - SUM(a.used_pages)) / 128.00, 2) AS NUMERIC(36, 2)) AS Unused_MB, 
   CAST(ROUND((SUM(a.total_pages) / 128.00), 2) AS NUMERIC(36, 2)) AS Total_MB, 
   RunId = cast(@RunId as nvarchar(10)), 
   CreateDate = GETDATE()
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
 --ORDER BY s.Name, t.Name ';
    END;
GO

-- Unmodified source:
--SELECT
--s.Name AS SchemaName,
--t.Name AS TableName,
--p.rows AS RowCounts,
--CAST(ROUND((SUM(a.used_pages) / 128.00), 2) AS NUMERIC(36, 2)) AS Used_MB,
--CAST(ROUND((SUM(a.total_pages) - SUM(a.used_pages)) / 128.00, 2) AS NUMERIC(36, 2)) AS Unused_MB,
--CAST(ROUND((SUM(a.total_pages) / 128.00), 2) AS NUMERIC(36, 2)) AS Total_MB
--into DFS_TableGrowthHistory
--FROM sys.tables t
--INNER JOIN sys.indexes i ON t.OBJECT_ID = i.object_id
--INNER JOIN sys.partitions p ON i.object_id = p.OBJECT_ID AND i.index_id = p.index_id
--INNER JOIN sys.allocation_units a ON p.partition_id = a.container_id
--INNER JOIN sys.schemas s ON t.schema_id = s.schema_id
--GROUP BY t.Name, s.Name, p.Rows
--ORDER BY s.Name, t.Name
--GOPRINT '--- "D:\dev\SQL\DFINAnalytics\UTIL_TableGrowthHistory.sql"' 


/****************** PROCESSING FILE *************************************/

GO  
PRINT 'ID# 230'  

/** USEDFINAnalytics;*/

GO

/* drop table [dbo].[DFS_PerfMonitor]*/

IF EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.tables
    WHERE TABLE_NAME = 'DFS_PerfMonitor'
)
    DROP TABLE [dbo].[DFS_PerfMonitor];
GO
CREATE TABLE [dbo].[DFS_PerfMonitor]
(SVRNAME       NVARCHAR(150) NULL, 
 DBNAME        NVARCHAR(150) NULL, 
 SSVER         NVARCHAR(150) NULL, 
 [RunID]       [INT] NOT NULL, 
 [ProcName]    [VARCHAR](100) NOT NULL, 
 [LocID]       [VARCHAR](50) NOT NULL, 
 [UKEY]        [UNIQUEIDENTIFIER] NOT NULL, 
 [StartTime]   [DATETIME2](7) NULL, 
 [EndTime]     [DATETIME2](7) NULL, 
 [ElapsedTime] [DECIMAL](18, 3) NULL, 
 CreateDate    DATETIME DEFAULT GETDATE(), 
 [UID]         UNIQUEIDENTIFIER DEFAULT NEWID(), 
 CONSTRAINT [PK_PerfMonitor] PRIMARY KEY CLUSTERED([UKEY] ASC)
 WITH(PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY];
ALTER TABLE [dbo].[DFS_PerfMonitor]
ADD CONSTRAINT [DF_PerfMonitor_UKEY] DEFAULT(NEWID()) FOR [UKEY];
GO



/****************** PROCESSING FILE *************************************/

GO  
PRINT 'ID# 240'  
print 'D:\dev\SQL\DFINAnalytics\DFS_CleanDFSTables.sql' 

/** USEDFINAnalytics;*/

GO

IF NOT EXISTS ( SELECT 1
  FROM information_schema.tables
  WHERE table_name = 'DFS_CleanedDFSTables'
   AND 
   TABLE_TYPE = 'BASE TABLE'
  ) 
    BEGIN
 CREATE TABLE DFS_CleanedDFSTables ( 
  SvrName    NVARCHAR(150) NOT NULL , 
  DBName     NVARCHAR(150) NOT NULL , 
  TBLName    NVARCHAR(150) NOT NULL , 
  RowCNT     INT NULL , 
  DropRowCNT INT NULL , 
  CreateDate DATETIME DEFAULT GETDATE() , 
  [UID] UNIQUEIDENTIFIER DEFAULT NEWID()
  );
 CREATE INDEX pi_DFS_CleanedDFSTables ON DFS_CleanedDFSTables ( TBLName
   );
END;
GO

IF EXISTS ( SELECT 1
     FROM sys.procedures
     WHERE name = 'UTIL_CleanUpOneTable'
   ) 
    BEGIN
 DROP PROCEDURE UTIL_CleanUpOneTable;
END;
GO
/*
	exec UTIL_CleanUpOneTable 'DFS_QryOptStatsHistory', 'ExecutionDate', 21 ;
*/
CREATE PROCEDURE UTIL_CleanUpOneTable ( 
   @tbl   NVARCHAR(150) , 
   @DateColumn   NVARCHAR(50) , 
   @DaysToDelete INT
     ) 
AS
    BEGIN
		 exec UTIL_DFS_DBVersion;
		 
		 DECLARE @Acnt INT;
		 DECLARE @Bcnt INT;
		 DECLARE @retval INT;
		 DECLARE @sSQL NVARCHAR(500);
		 DECLARE @ParmDefinition NVARCHAR(500);
		 DECLARE @i INT;
		 DECLARE @tablename NVARCHAR(50);
		 
		 SELECT @tablename = @tbl;
		 SELECT @sSQL = N'SELECT @retvalOUT = count(*) FROM ' + @tablename;
		 SET @ParmDefinition = N'@retvalOUT int OUTPUT';
		 EXEC sp_executesql @sSQL , @ParmDefinition , @retvalOUT = @retval OUTPUT;
		 SET @Acnt = ( SELECT @retval );
		 PRINT @tbl + ' @Bcnt = ' + CAST(@Bcnt AS NVARCHAR(50));
		 SELECT @sSQL = 'delete from dbo.' + @tbl + ' where ' + @DateColumn + ' <= getdate() - ' + CAST(@DaysToDelete AS NVARCHAR(10));
		 PRINT @sSQL;
		 SELECT @sSQL = N'SELECT @retvalOUT = count(*) FROM ' + @tablename;
		 SET @ParmDefinition = N'@retvalOUT int OUTPUT';
		 EXEC sp_executesql @sSQL , @ParmDefinition , @retvalOUT = @retval OUTPUT;
		 SET @Bcnt = ( SELECT @retval );
		 PRINT @tbl + ' @Bcnt = ' + CAST(@Bcnt AS NVARCHAR(50));
		 INSERT INTO [dbo].[DFS_CleanedDFSTables] ( [SvrName] , [DBName] , [TBLName] , [RowCNT] , [DropRowCNT] , [CreateDate] , [UID]
		  ) 
		 VALUES ( @@servername , DB_NAME() , @tbl , @Acnt , @Bcnt , GETDATE() , NEWID()
		   );
    END;
GO

IF EXISTS ( SELECT 1
     FROM sys.procedures
     WHERE name = 'UTIL_CleanDFSTables'
   ) 
    BEGIN
 DROP PROCEDURE UTIL_CleanDFSTables;
END;
GO

/* exec UTIL_CleanDFSTables @DaysToDelete = 1 */

CREATE PROCEDURE UTIL_CleanDFSTables ( 
   @DaysToDelete INT = 3
    ) 
AS
    BEGIN
		exec UTIL_DFS_DBVersion;
 IF EXISTS ( SELECT 1
 FROM sys.tables
 WHERE name = ' DFS_SequenceTABLE'
    ) 
     BEGIN
  EXEC UTIL_CleanUpOneTable 'DFS_SequenceTABLE' , 'CreateDate' , @DaysToDelete;
 END;
 IF EXISTS ( SELECT 1
 FROM sys.tables
 WHERE name = ' DFS_MissingIndexes'
    ) 
     BEGIN
  EXEC UTIL_CleanUpOneTable 'DFS_MissingIndexes' , 'CreateDate' , @DaysToDelete;
 END;
 IF EXISTS ( SELECT 1
 FROM sys.tables
 WHERE name = ' DFS_MissingFKIndexes'
    ) 
     BEGIN
  EXEC UTIL_CleanUpOneTable 'DFS_MissingFKIndexes' , 'CreateDate' , @DaysToDelete;
 END;
 IF EXISTS ( SELECT 1
 FROM sys.tables
 WHERE name = ' DFS_MissingFKIndexes'
    ) 
     BEGIN
  EXEC UTIL_CleanUpOneTable 'DFS_MissingFKIndexes' , 'CreateDate' , @DaysToDelete;
 END;
 IF EXISTS ( SELECT 1
 FROM sys.tables
 WHERE name = ' DFS_TableReadWrites'
    ) 
     BEGIN
  EXEC UTIL_CleanUpOneTable 'DFS_TableReadWrites' , 'RunDate' , @DaysToDelete;
 END;
 IF EXISTS ( SELECT 1
 FROM sys.tables
 WHERE name = ' DFS_IndexStats'
    ) 
     BEGIN
  EXEC UTIL_CleanUpOneTable 'DFS_IndexStats' , 'CreateDate' , @DaysToDelete;
 END;
 IF EXISTS ( SELECT 1
 FROM sys.tables
 WHERE name = ' DFS_BlockingHistory'
    ) 
     BEGIN
  EXEC UTIL_CleanUpOneTable 'DFS_BlockingHistory' , 'CreateDate' , @DaysToDelete;
 END;
 IF EXISTS ( SELECT 1
 FROM sys.tables
 WHERE name = ' DFS_SEQ'
    ) 
     BEGIN
  EXEC UTIL_CleanUpOneTable 'DFS_SEQ' , 'GenDate' , @DaysToDelete;
 END;
 IF EXISTS ( SELECT 1
 FROM sys.tables
 WHERE name = ' DFS_CPU_BoundQry2000'
    ) 
     BEGIN
  EXEC UTIL_CleanUpOneTable 'DFS_CPU_BoundQry2000' , 'RunDate' , @DaysToDelete;
 END;
 IF EXISTS ( SELECT 1
 FROM sys.tables
 WHERE name = ' DFS_IO_BoundQry2000'
    ) 
     BEGIN
  EXEC UTIL_CleanUpOneTable 'DFS_IO_BoundQry2000' , 'RunDate' , @DaysToDelete;
 END;
 IF EXISTS ( SELECT 1
 FROM sys.tables
 WHERE name = ' DFS_TranLocks'
    ) 
     BEGIN
  EXEC UTIL_CleanUpOneTable 'DFS_TranLocks' , 'CreateDate' , @DaysToDelete;
 END;
 IF EXISTS ( SELECT 1
 FROM sys.tables
 WHERE name = ' DFS_QryOptStats'
    ) 
     BEGIN
  EXEC UTIL_CleanUpOneTable 'DFS_QryOptStats' , 'RunDate' , @DaysToDelete;
 END;
 IF EXISTS ( SELECT 1
 FROM sys.tables
 WHERE name = ' DFS_Workload'
    ) 
     BEGIN
  EXEC UTIL_CleanUpOneTable 'DFS_Workload' , 'RunDate' , @DaysToDelete;
 END;
 IF EXISTS ( SELECT 1
 FROM sys.tables
 WHERE name = ' DFS_PerfMonitor'
    ) 
     BEGIN
  EXEC UTIL_CleanUpOneTable 'DFS_PerfMonitor' , 'CreateDate' , @DaysToDelete;
 END;
 IF EXISTS ( SELECT 1
 FROM sys.tables
 WHERE name = ' DFS_TxMonitorTableStats'
    ) 
     BEGIN
  EXEC UTIL_CleanUpOneTable 'DFS_TxMonitorTableStats' , 'CreateDate' , @DaysToDelete;
 END;
 IF EXISTS ( SELECT 1
 FROM sys.tables
 WHERE name = ' DFS_TxMonitorTblUpdates'
    ) 
     BEGIN
  EXEC UTIL_CleanUpOneTable 'DFS_TxMonitorTblUpdates' , 'CreateDate' , @DaysToDelete;
 END;
 IF EXISTS ( SELECT 1
 FROM sys.tables
 WHERE name = ' DFS_DbFileSizing'
    ) 
     BEGIN
  EXEC UTIL_CleanUpOneTable 'DFS_DbFileSizing' , 'CreateDate' , @DaysToDelete;
 END;
 IF EXISTS ( SELECT 1
 FROM sys.tables
 WHERE name = ' DFS_TxMonitorIDX'
    ) 
     BEGIN
  EXEC UTIL_CleanUpOneTable 'DFS_TxMonitorIDX' , 'CreateDate' , @DaysToDelete;
 END;
 IF EXISTS ( SELECT 1
 FROM sys.tables
 WHERE name = ' DFS_DeadlockStats'
    ) 
     BEGIN
  EXEC UTIL_CleanUpOneTable 'DFS_DeadlockStats' , 'RunDate' , @DaysToDelete;
 END;
 IF EXISTS ( SELECT 1
 FROM sys.tables
 WHERE name = ' DFS_IndexFragReorgHistory'
    ) 
     BEGIN
  EXEC UTIL_CleanUpOneTable 'DFS_IndexFragReorgHistory' , 'RunDate' , @DaysToDelete;
 END;
 IF EXISTS ( SELECT 1
 FROM sys.tables
 WHERE name = ' DFS_TableGrowthHistory'
    ) 
     BEGIN
  EXEC UTIL_CleanUpOneTable 'DFS_TableGrowthHistory' , 'CreateDate' , @DaysToDelete;
 END;
 IF EXISTS ( SELECT 1
 FROM sys.tables
 WHERE name = ' DFS_IO_BoundQry'
    ) 
     BEGIN
  EXEC UTIL_CleanUpOneTable 'DFS_IO_BoundQry' , 'RunDate' , @DaysToDelete;
 END;
 IF EXISTS ( SELECT 1
 FROM sys.tables
 WHERE name = ' DFS_CPU_BoundQry'
    ) 
     BEGIN
  EXEC UTIL_CleanUpOneTable 'DFS_CPU_BoundQry' , 'RunDate' , @DaysToDelete;
 END;
    END;

/****************** PROCESSING FILE *************************************/

GO  
PRINT 'ID# 250'  
print 'D:\dev\SQL\DFINAnalytics\UTIL_Monitor_TPS.sql' 

/* D:\dev\SQL\DFINAnalytics\UTIL_Monitor_TPS.sql */

--* USEDFINAnalytics;
GO
DECLARE @runnow INT= 0;
IF @runnow = 1
    BEGIN

/*declare @RunID BIGINT = NEXT VALUE FOR master_seq;
		truncate TABLE [dbo].[DFS_IndexStats];
		select top 100 * from [dbo].[DFS_IndexStats];
		*/

 DECLARE @RunID BIGINT;
 EXEC @RunID = dbo.UTIL_GetSeq;
 DECLARE @command VARCHAR(1000);
 SELECT @command = '--* USE?; exec sp_UTIL_TxMonitorIDX ' + CAST(@RunID AS NVARCHAR(50)) + ' ; exec sp_UTIL_TxMonitorTableStats ' + CAST(@RunID AS NVARCHAR(25)) + ';';
 EXEC sp_MSforeachdb 
 @command;
END;
GO

/*
-- JOB NAME
JOB_DFS_TxMonitorIDX
-- JOB STEP
exec sp_UTIL_TxMonitorIDX -22
*/
/*
-- JOB NAME
JOB_UTIL_TxMonitorTableStats
-- JOB STEP
exec dbo.sp_UTIL_TxMonitorTableStats
*/
/*
-- =======================================================
DECLARE @command VARCHAR(1000);
SELECT @command = '--* USE?; declare @DB as int = DB_ID() ; exec dbo.sp_UTIL_TxMonitorIDX @DB';
EXEC sp_MSforeachdb @command;
-- =======================================================
*/

--* USEDFINAnalytics;
GO
-- DROP TABLE [DFS_TxMonitorTableStats];

IF NOT EXISTS
(
    SELECT 1
    FROM sys.tables
    WHERE name = 'DFS_TxMonitorTableStats'
)
    BEGIN
 CREATE TABLE [dbo].[DFS_TxMonitorTableStats]
 ([SVR]  [NVARCHAR](150) NULL, 
  [SchemaName]  [NVARCHAR](150) NULL, 
  [DBName]    [NVARCHAR](150) NULL, 
  [TableName] [NVARCHAR](150) NULL, 
  [IndexName] [SYSNAME] NULL, 
  [IndexID]   [INT] NOT NULL, 
  [user_seeks]  [BIGINT] NOT NULL, 
  [user_scans]  [BIGINT] NOT NULL, 
  [user_lookups]     [BIGINT] NOT NULL, 
  [user_updates]     [BIGINT] NOT NULL, 
  [last_user_seek]   [DATETIME] NULL, 
  [last_user_scan]   [DATETIME] NULL, 
  [last_user_lookup] [DATETIME] NULL, 
  [last_user_update] [DATETIME] NULL, 
  [DBID] [SMALLINT] NULL, 
  [ExecutionDate]    [DATETIME] NOT NULL, 
  [RunID]     [INT] NOT NULL, 
  [UID]  [UNIQUEIDENTIFIER] NULL
 )
 ON [PRIMARY];
END;
GO
-- drop		TABLE [dbo].[DFS_TxMonitorIDX]

IF EXISTS
(
    SELECT 1
    FROM sys.tables
    WHERE name = 'DFS_TxMonitorIDX'
)
drop TABLE [dbo].[DFS_TxMonitorIDX]
go
 CREATE TABLE [dbo].[DFS_TxMonitorIDX]
 ([SvrName] [NVARCHAR](150) NULL, 
  [DBName]  [NVARCHAR](150) NULL, 
  [database_id]    [INT] NOT NULL, 
  [TableName] [NVARCHAR](150) NULL, 
  [UpdatedRows]    [BIGINT] NOT NULL, 
  [LastUpdateTime] [DATETIME] NULL, 
  CreateDate  DATETIME NULL
  DEFAULT GETDATE(), 
  ExecutionDate    DATETIME NOT NULL, 
  [UID]     UNIQUEIDENTIFIER NOT NULL, 
  RunID     INT NULL, 
  Rownbr    INT IDENTITY(1, 1) NOT NULL
 )
 ON [PRIMARY];

GO

/******************************************
Using sys.dm_db_index_usage_stats:
There's a handy dynamic management view called sys.dm_db_index_usage_stats that shows you
number of rows in both SELECT and DML statements against all the tables and indexes in your
database, either since the object was created or since the database instance was last restarted:
SELECT *
FROM sys.dm_db_index_usage_stats
******************************************/

--* USEmaster;
GO
IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'sp_UTIL_TxMonitorIDX'
)
    BEGIN
 DROP PROCEDURE sp_UTIL_TxMonitorIDX;
END;
GO

/*
exec sp_UTIL_TxMonitorIDX -22
*/

CREATE PROCEDURE sp_UTIL_TxMonitorIDX(@RunID INT)
AS
    BEGIN
		exec UTIL_RecordCount N'sp_UTIL_TxMonitorIDX';
 SET NOCOUNT ON;
 DECLARE @ExecutionDate DATETIME= GETDATE();
 -- Collect our working data
 INSERT INTO dbo.DFS_TxMonitorIDX ([SvrName],[DBName],[database_id],[TableName],[UpdatedRows],[LastUpdateTime],[CreateDate],[ExecutionDate],[UID],[RunID])
   SELECT @@SERVERNAME as SvrName, 
   DB_NAME() as DBName, 
   database_id, 
   OBJECT_NAME(us.object_id) AS TableName, 
   user_updates AS UpdatedRows, 
   last_user_update AS LastUpdateTime, 
   GETDATE() AS CreateDate, 
   ExecutionDate = GETDATE(), 
   [UID] = NEWID(), 
   RunID = -99
   FROM sys.dm_db_index_usage_stats AS us
 JOIN sys.indexes AS si ON us.object_id = si.object_id
      AND us.index_id = si.index_id
   --where database_id =  @DBID
   WHERE user_seeks + user_scans + user_lookups + user_updates > 0
  AND si.index_id IN(0, 1)
   ORDER BY OBJECT_NAME(us.object_id)
    END;
GO
-- drop procedure sp_UTIL_TxMonitorTableStats

IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'sp_UTIL_TxMonitorTableStats'
)
    BEGIN
 DROP PROCEDURE sp_UTIL_TxMonitorTableStats;
END;
	GO

/*
exec dbo.sp_UTIL_TxMonitorTableStats -99
*/

CREATE PROCEDURE dbo.sp_UTIL_TxMonitorTableStats(@RunID INT)
AS
    BEGIN
		exec UTIL_RecordCount N'sp_UTIL_TxMonitorTableStats';
 IF OBJECT_ID('tempdb..#DFS_TxMonitorTableStats') IS NOT NULL
     BEGIN
  DROP TABLE #DFS_TxMonitorTableStats;
 END;
 DECLARE @DBID AS INT= DB_ID();
 DECLARE @ExecutionDate DATETIME= GETDATE();
 SELECT SVR = @@SERVERNAME, 
   SchemaName = OBJECT_SCHEMA_NAME(ius.object_id), 
   DBName = DB_NAME(), 
   TableName = OBJECT_NAME(ius.object_id), 
   si.name AS IndexName, 
   si.index_id AS IndexID, 
   ius.user_seeks, 
   ius.user_scans, 
   ius.user_lookups, 
   ius.user_updates, 
   ius.last_user_seek, 
   ius.last_user_scan, 
   ius.last_user_lookup, 
   ius.last_user_update, 
   DBID = DB_ID(), 
   ExecutionDate = GETDATE(), 
   RunID = @RunID, 
   [UID] = NEWID()
 INTO #DFS_TxMonitorTableStats
 FROM sys.dm_db_index_usage_stats AS ius
 JOIN sys.indexes AS si ON ius.object_id = si.object_id
      AND ius.index_id = si.index_id;
 DECLARE @rowcnt AS INT= 0;
 SET @rowcnt =
 (
     SELECT COUNT(*)
     FROM #DFS_TxMonitorTableStats
 );
 IF(@rowcnt > 0)
     BEGIN
  INSERT INTO dbo.DFS_TxMonitorTableStats
  ([SVR], 
   [SchemaName], 
   [DBName], 
   [TableName], 
   [IndexName], 
   [IndexID], 
   [user_seeks], 
   [user_scans], 
   [user_lookups], 
   [user_updates], 
   [last_user_seek], 
   [last_user_scan], 
   [last_user_lookup], 
   [last_user_update], 
   [DBID], 
   [ExecutionDate], 
   [RunID], 
   [UID]
  )
    SELECT [SVR], 
    [SchemaName], 
    [DBName], 
    [TableName], 
    [IndexName], 
    [IndexID], 
    [user_seeks], 
    [user_scans], 
    [user_lookups], 
    [user_updates], 
    [last_user_seek], 
    [last_user_scan], 
    [last_user_lookup], 
    [last_user_update], 
    [DBID], 
    [ExecutionDate], 
    [RunID], 
    [UID]
    FROM [dbo].#DFS_TxMonitorTableStats;
  IF OBJECT_ID('tempdb..#DFS_TxMonitorTableStats') IS NOT NULL
 BEGIN
   DROP TABLE #DFS_TxMonitorTableStats;
  END;
 END;
    END;

/*
 In the results, you'll have the following columns:
 TableName - The name of the table (the easiest column)
 IndexName - when populated, the name of the index. When it's NULL, it refers to a HEAP - a table without a clustered index IndexID -
  If this is 0, it's a HEAP (IndexName should also be NULL in these cases). When 1, this refers to a clustered index (meaning that the activity columns still all refer to the table data itself). When 2 or greater, this is a standard non-clustered index.
  User activity (the number of times each type of operation has been performed on the index/table):
  User Seeks - searched for a small number of rows - this is the most effecient index operation.
  User Scans - scanned through the whole index looking for rows that meet the WHERE criteria.
  User Lookups - query used the index to find a row number, then pulled data from the table itself to satisfy the query.
  User Updates - number of times the data in this index/table has been updated. Note that not every table update will update every query - if an update modifies a column that's not part of an index, the table
  update
     counter will increment
    , but the index counter will not User activity timestamps - these show the most recent occurance of each of the four types of "User" events 
*/

GO
--**********************************************************************************************
--Making the leap to "transactions per second"
--**********************************************************************************************
--**********************************************************************************************
--Making the leap to "transactions per second"
--**********************************************************************************************

/****************** PROCESSING FILE *************************************/

GO  
PRINT 'ID# 260'  
print 'D:\dev\SQL\DFINAnalytics\UTIL_DefragAllIndexes.sql' 

/* W. Dale Miller
 wdalemiller@gmail.com*/
/** USEDFINAnalytics;*/

GO

/* DROP TABLE dbo.DFS_IndexFragProgress*/

IF EXISTS
(
    SELECT 1
    FROM information_schema.tables
    WHERE table_name = 'DFS_IndexFragProgress'
)
drop TABLE dbo.DFS_IndexFragProgress
go
    BEGIN
        PRINT 'Creating TABLE dbo.DFS_IndexFragProgress';
        CREATE TABLE dbo.DFS_IndexFragProgress
        (SqlCmd    VARCHAR(MAX) NULL, 
         DBNAME    NVARCHAR(100), 
         StartTime DATETIME NULL, 
         EndTime   DATETIME NULL, 
         RunID     NVARCHAR(60) NULL, 
         [UID]     UNIQUEIDENTIFIER DEFAULT NEWID(), 
         RowNbr    INT IDENTITY(1, 1) NOT NULL,
        )
        ON [PRIMARY];
        CREATE INDEX idxDFS_DFS_IndexFragProgress
        ON dbo.DFS_IndexFragProgress
        (DBNAME
        );
END;
GO

/* DROP TABLE dbo.DFS_IndexFragErrors*/

IF EXISTS
(
    SELECT 1
    FROM information_schema.tables
    WHERE table_name = 'DFS_IndexFragErrors'
)
    DROP TABLE dbo.DFS_IndexFragErrors;
GO
CREATE TABLE dbo.DFS_IndexFragErrors
(SqlCmd VARCHAR(MAX) NULL, 
 DBNAME NVARCHAR(100), 
 RunID  NVARCHAR(60) NULL, 
 [UID]  UNIQUEIDENTIFIER DEFAULT NEWID(), 
 RowNbr INT IDENTITY(1, 1) NOT NULL,
)
ON [PRIMARY];
CREATE INDEX idxDFS_IndexFragErrors
ON dbo.DFS_IndexFragErrors
(DBNAME
);
CREATE INDEX pxDFS_IndexFragErrors
ON dbo.DFS_IndexFragErrors
(RowNbr
);
GO

/* select top 100 * from DFS_IndexFragHist
 drop TABLE dbo.DFS_IndexFragHist*/

IF EXISTS
(
    SELECT 1
    FROM information_schema.tables
    WHERE table_name = 'DFS_IndexFragHist'
)
drop TABLE dbo.DFS_IndexFragHist
go
    BEGIN
        CREATE TABLE dbo.DFS_IndexFragHist
        (DBName               NVARCHAR(150) NULL, 
         [Schema]             NVARCHAR(150) NOT NULL, 
         [Table]              NVARCHAR(150) NOT NULL, 
         [Index]              NVARCHAR(150) NULL, 
         alloc_unit_type_desc NVARCHAR(60) NULL, 
         IndexProcessed       INTEGER NULL
                                      DEFAULT 0, 
         AvgPctFrag           DECIMAL(8, 2) NULL, 
         page_count           BIGINT NULL, 
         RunDate              DATETIME DEFAULT GETDATE(), 
         RunID                NVARCHAR(60) NULL, 
         Success              INT NULL, 
         [UID]                UNIQUEIDENTIFIER DEFAULT NEWID(), 
         RowNbr               INT IDENTITY(1, 1) NOT NULL
        )
        ON [PRIMARY];
        CREATE INDEX idxRUNIdentifier
        ON dbo.DFS_IndexFragHist
        (RunID
        );
        CREATE INDEX idxIndexPorcessed
        ON dbo.DFS_IndexFragHist
        (IndexProcessed
        );
END;
GO
IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'UTIL_DefragAllIndexes'
)
    BEGIN
        DROP PROCEDURE UTIL_DefragAllIndexes;
END;
GO

/* exec UTIL_DefragAllIndexes 'BNY_Production_NMFP_Data', 'BNYUK_ProductionAR_Port', 30, 0, 1;
exec UTIL_DefragAllIndexes null, null, 30, 0, 1, -1;
*/

CREATE PROCEDURE UTIL_DefragAllIndexes
(@StartingDB   NVARCHAR(100), 
 @EndingDB     NVARCHAR(100), 
 @MaxPct       DECIMAL(6, 2)  = 30, 
 @PreviewOnly  INT           = 1, 
 @ReorgIndexes INT           = 0, 
 @RunID        VARCHAR(60)   = NULL
)
AS

/*IF @EndingDB IS NULL and @StartingDB is null ALL databases are processed
	IF @EndingDB IS NULL and @StartingDB is NOT null only database @StartingDB is processed*/

    BEGIN
        EXEC UTIL_RecordCount 
             N'UTIL_DefragAllIndexes';
        DECLARE @msg NVARCHAR(2000);
        DECLARE @DBNAME NVARCHAR(150);
        IF @RunID IS NULL
            BEGIN
                SET @RunID = '-1';
        END;
        DECLARE @RUNDATE DATETIME= GETDATE();
        DECLARE @Schema NVARCHAR(100), @Table NVARCHAR(100), @Index NVARCHAR(100);
        IF OBJECT_ID('tempdb..#TEMP_CMDS') IS NOT NULL
            BEGIN
                DROP TABLE #TEMP_CMDS;
        END;
        CREATE TABLE #TEMP_CMDS(CMD NVARCHAR(MAX) NOT NULL);
        IF OBJECT_ID('tempdb..#TEMP_DBS2PROCESS') IS NOT NULL
            BEGIN
                DROP TABLE #TEMP_DBS2PROCESS;
        END;
        CREATE TABLE #TEMP_DBS2PROCESS(DBNAME NVARCHAR(100) NOT NULL);
        IF @EndingDB IS NULL
           AND @StartingDB IS NULL
            BEGIN
                INSERT INTO #TEMP_DBS2PROCESS
                       SELECT name
                       FROM sys.databases;
                DELETE FROM #TEMP_DBS2PROCESS
                WHERE DBNAME IN
                (
                    SELECT DB
                    FROM dbo.[DFS_DB2Skip]
                );
        END;
        IF @EndingDB IS NOT NULL
           AND @StartingDB IS NOT NULL
            BEGIN
                INSERT INTO #TEMP_DBS2PROCESS
                       SELECT name
                       FROM sys.databases
                       WHERE name >= @StartingDB
                             AND name <= @EndingDB;
                SELECT *
                FROM #TEMP_DBS2PROCESS;
        END;
        IF @EndingDB IS NOT NULL
           AND @StartingDB IS NULL
            BEGIN
                PRINT 'FATAL ERROR: @StartingDB is null and @EndingDB IS NOT NULL, this is not ALLOWED, aborting';
                RETURN;
        END;
        DELETE FROM #TEMP_DBS2PROCESS
        WHERE DBNAME IN
        (
            SELECT DB
            FROM dbo.[DFS_DB2Skip]
        );
        DECLARE @RowCnt INT;
        SET @RowCnt =
        (
            SELECT COUNT(*) AS #TEMP_DBS2PROCESS
        );
        IF @RowCnt > 0
            BEGIN

                /* DO NOT PROCESS DATABASES CURRENTLY AWAITING PROCESSING*/

                DELETE FROM #TEMP_DBS2PROCESS
                WHERE DBNAME IN
                (
                    SELECT DISTINCT 
                           [DBName]
                    FROM [dbo].[DFS_IndexFragHist]
                    WHERE [IndexProcessed] = 0
                );
                DELETE FROM #TEMP_DBS2PROCESS
                WHERE DBNAME IN
                (
                    SELECT DB
                    FROM dbo.[DFS_DB2Skip]
                );
        END;
        DECLARE @tempstmt NVARCHAR(2000);
        DECLARE xcursor CURSOR
        FOR SELECT DBNAME
            FROM #TEMP_DBS2PROCESS;
        DECLARE @stmt NVARCHAR(2000);
        OPEN xcursor;
        FETCH NEXT FROM xcursor INTO @dbname;
        WHILE @@FETCH_STATUS = 0
            BEGIN
                SET @msg = 'PROCESSING DB: ' + @dbname;
                EXEC sp_printimmediate 
                     @msg;
                SET @msg = 'ReorgIndexes: ' + CAST(@ReorgIndexes AS NVARCHAR(10));
                EXEC sp_printimmediate 
                     @msg;
                SET @stmt = 'INSERT INTO dbo.[DFS_IndexFragProgress] ';
                SET @stmt = @stmt + ' (';
                SET @stmt = @stmt + ' [DBNAME] ';
                SET @stmt = @stmt + ' ,[StartTime] ';
                SET @stmt = @stmt + ' ,[EndTime] ';
                SET @stmt = @stmt + ' ,[RunID]) ';
                SET @stmt = @stmt + ' VALUES ';
                SET @stmt = @stmt + ' (';
                SET @stmt = @stmt + ' ''' + @dbname + '''';
                SET @stmt = @stmt + ' ,getdate() ';
                SET @stmt = @stmt + ' ,null';
                SET @stmt = @stmt + ' ,''' + @RunID + ''');  ';
                SET @stmt = @stmt + 'INSERT INTO dbo.DFS_IndexFragHist ' + CHAR(10) + 'SELECT DB_NAME() AS DBName,
				dbschemas.[name] AS ''Schema'', 
				dbtables.[name] AS ''Table'', 
				dbindexes.[name] AS ''Index'', 
				indexstats.alloc_unit_type_desc,
				0, 
				CAST(indexstats.avg_fragmentation_in_percent AS DECIMAL(6, 2)) AS AvgPctFrag, 
				indexstats.page_count, getdate(), ''' + @RunID + ''',0,newid()
				FROM sys.dm_db_index_physical_stats(DB_ID(), NULL, NULL, NULL, NULL) AS indexstats
				INNER JOIN sys.tables dbtables ON dbtables.[object_id] = indexstats.[object_id]
				INNER JOIN sys.schemas dbschemas ON dbtables.[schema_id] = dbschemas.[schema_id]
				INNER JOIN sys.indexes AS dbindexes ON dbindexes.[object_id] = indexstats.[object_id]
												AND indexstats.index_id = dbindexes.index_id
				WHERE indexstats.database_id = DB_ID()
				AND indexstats.avg_fragmentation_in_percent >= ' + CAST(@MaxPct AS VARCHAR(50)) + '
				ORDER BY indexstats.avg_fragmentation_in_percent DESC; ';
                SET @stmt = @stmt + 'update dbo.[DFS_IndexFragProgress] ';
                SET @stmt = @stmt + '  set EndTime = getdate() where EndTime is null';
                SET @stmt = RTRIM(@stmt);
                IF @PreviewOnly = 0
                    BEGIN
                        SET @stmt = '--* USE' + @dbname + ';' + @stmt;
                        INSERT INTO #TEMP_CMDS ( cmd ) 
                        VALUES
                        (
                               @stmt
                        );
                END;
                IF @PreviewOnly = 1
                    BEGIN
                        INSERT INTO #TEMP_CMDS ( cmd ) 
                    VALUES
                        (
                           '--* USE' + @dbname + ' ; '
                        );
                        INSERT INTO #TEMP_CMDS ( cmd ) 
                        VALUES
                        (
                               @stmt
                        );
                        INSERT INTO #TEMP_CMDS ( cmd ) 
                        VALUES
                        (
                               'GO'
                        );
                END;
                FETCH NEXT FROM xcursor INTO @dbname;
            END;
        CLOSE xcursor;
        DEALLOCATE xcursor;
        DECLARE @ii INT= 0;
        DECLARE @ix INT= 0;
        DECLARE @using NVARCHAR(100);
        DECLARE @CntTot INT=
        (
            SELECT COUNT(*)
            FROM #TEMP_CMDS
        );
        DECLARE xcmd CURSOR
        FOR SELECT CMD
            FROM #TEMP_CMDS;
        OPEN xcmd;
        FETCH NEXT FROM xcmd INTO @stmt;
        WHILE @@FETCH_STATUS = 0
            BEGIN
                SET @ii = @ii + 1;
                SET @stmt = LTRIM(@stmt);
                SET @stmt = RTRIM(@stmt);
                SET @ix = CHARINDEX(';', @stmt);
                SET @using = SUBSTRING(@stmt, 1, @ix);
                SET @msg = 'ANALYZING #' + CAST(@ii AS VARCHAR(10)) + ' of ' + CAST(@CntTot AS VARCHAR(10)) + ' : ' + @using;
                EXEC sp_printimmediate 
                     @msg;
                IF @PreviewOnly = 1
                    BEGIN
                        PRINT @stmt;
                END;
                    ELSE
                    BEGIN
                        BEGIN TRY
                            EXECUTE sp_executesql 
                                    @stmt;
                END TRY
                        BEGIN CATCH
                            SET @msg = '-- **************************************';
                            EXEC sp_printimmediate 
                                 @msg;
                            SET @msg = 'ERR MSG @1: ' +
                            (
                                SELECT ERROR_MESSAGE()
                            );
                            EXEC sp_printimmediate 
                                 @msg;
                            SET @msg = 'ERROR DB: ' + @dbname;
                            EXEC sp_printimmediate 
                                 @msg;
                            SET @msg = 'ERROR: ' + @stmt;
                            EXEC sp_printimmediate 
                                 @msg;
                            PRINT '***********************************************';
                END CATCH;
                END;
                FETCH NEXT FROM xcmd INTO @stmt;
            END;
        CLOSE xcmd;
        DEALLOCATE xcmd;
        DELETE FROM dbo.DFS_IndexFragHist
        WHERE DBName IN
        (
            SELECT name
            FROM sys.databases
            WHERE [state] != 0
        )
              AND IndexProcessed = 0;
        IF @PreviewOnly = 1
            BEGIN
                INSERT INTO #TEMP_CMDS ( cmd ) 
            VALUES
                (
                   'SELECT * FROM dbo.DFS_IndexFragHist where IndexProcessed != 1;'
                );
        END;
        IF @ReorgIndexes = 1
            BEGIN
                EXEC sp_UTIL_ReorgFragmentedIndexes 
                     @PreviewOnly;
        END;
    END;

/****************** PROCESSING FILE *************************************/

GO  
PRINT 'ID# 270'  
print 'D:\dev\SQL\DFINAnalytics\sp_MeasurePerformanceInSP.sql' 
--* USEDFINAnalytics;
GO

/****** Object:  StoredProcedure [dbo].[sp_MeasurePerformanceInSP]    Script Date: 12/31/2018 7:50:02 AM ******/

SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO
IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'sp_MeasurePerformanceInSP'
)
    DROP PROCEDURE sp_MeasurePerformanceInSP;
GO
CREATE PROCEDURE [dbo].[sp_MeasurePerformanceInSP]
(@action   VARCHAR(10), 
 @RunID    INT, 
 @UKEY     VARCHAR(50), 
 @ProcName VARCHAR(50) = NULL, 
 @LocID    VARCHAR(50) = NULL
)
AS
    -- DMA, Limited July 26, 2014
    -- Developer:	W. Dale Miller
    -- License MIT Open Source
    BEGIN
        IF(@action = 'start')
            BEGIN
                INSERT INTO [dbo].[PerfMonitor]
                ([RunID], 
                 [ProcName], 
                 [LocID], 
                 [UKEY], 
                 [StartTime], 
                 [EndTime], 
                 [ElapsedTime]
                )
                VALUES
                (@RunID, 
                 @ProcName, 
                 @LocID, 
                 @UKEY, 
                 GETDATE(), 
                 NULL, 
                 NULL
                );
        END;
        IF(@action = 'end')
            BEGIN
                UPDATE [dbo].[PerfMonitor]
                  SET 
                      [EndTime] = GETDATE()
                WHERE UKEY = @UKEY;
                UPDATE [dbo].[PerfMonitor]
                  SET 
                      [ElapsedTime] = DATEDIFF(MILLISECOND, [StartTime], [EndTime])
                WHERE UKEY = @UKEY;
                UPDATE [dbo].[PerfMonitor]
                  SET 
                      ExecutionTime =
                (
                    SELECT CONVERT(CHAR(13), DATEADD(ms, [ElapsedTime], '01/01/00'), 14)
                )
                WHERE UKEY = @UKEY;
        END;
    END;
GO

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

/****************** PROCESSING FILE *************************************/

GO  
PRINT 'ID# 280'  
print 'D:\dev\SQL\DFINAnalytics\sp_UTIL_RebuildAllDbIndexes.sql' 

--* USEDFINAnalytics;
GO
--* USEmaster;
GO
IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'sp_UTIL_RebuildAllDbIndexes'
)
    DROP PROCEDURE sp_UTIL_RebuildAllDbIndexes;
	GO

/*
--* USE[AW2016]
--* USEDFINAnalytics
exec sp_UTIL_RebuildAllDbIndexes
*/

CREATE PROCEDURE sp_UTIL_RebuildAllDbIndexes
AS
    BEGIN
 PRINT 'USING: ' + DB_NAME();
		DECLARE @DBName VARCHAR(250);
 DECLARE @tblName VARCHAR(250);
 DECLARE @schemaName VARCHAR(250);
 DECLARE @idxName VARCHAR(250);
 
		DECLARE @Tables TABLE
 (DatabaseName SYSNAME, 
  SchemaName   SYSNAME, 
  TableName    SYSNAME
 );
 INSERT INTO @Tables
 (DatabaseName, 
  SchemaName, 
  TableName
 )
 EXEC sp_msforeachdb 
 'select ''?'', s.name, t.name from [?].sys.tables t inner join [?].sys.schemas s on t.schema_id = s.schema_id';
 
		--SELECT * FROM @Tables where DatabaseName not in ('msdb','tempdb','DBA','model', 'master', 'ReportServer', 'ReportServerTempDB') ORDER BY 1, 2, 3;

		delete from @Tables where DatabaseName in ('msdb','tempdb','DBA','model', 'master', 'ReportServer', 'ReportServerTempDB')

 --SELECT 'ALTER INDEX ALL ON ' + TABLE_SCHEMA + '.' + TABLE_NAME + ' rebuild;' AS cmd
 --INTO #CMDS
 
		DECLARE tbl CURSOR
 FOR SELECT DatabaseName, SchemaName, TableName
     FROM @Tables where DatabaseName not in ('msdb','tempdb','DBA','model');
 OPEN tbl;
 
		DECLARE @msg NVARCHAR(1000);
 DECLARE @stmt NVARCHAR(1000);
 FETCH NEXT FROM tbl INTO @DBName,@schemaName, @tblName ;
 WHILE @@FETCH_STATUS = 0
     BEGIN
				set @stmt = 'ALTER INDEX ALL ON ' +@DBName+'.' + @schemaName + '.' + @tblName + ' rebuild;' 
  --SET @msg = 'Processing: ' + DB_NAME() + '.' + @schemaName + '.' + @tblname;
  --EXEC sp_printimmediate @msg;
  EXEC sp_printimmediate @stmt;
  BEGIN TRY
 EXEC sp_executesql 
    @stmt;
  END TRY
  BEGIN CATCH
 SET @msg = 'ERROR Processing: ' + @stmt;
 EXEC sp_printimmediate 
    @msg;
  END CATCH;
  FETCH NEXT FROM tbl INTO @DBName,@schemaName, @tblName ;
     END;
 CLOSE tbl;
 DEALLOCATE tbl;
    END;

/****************** PROCESSING FILE *************************************/

GO  
PRINT 'ID# 281'  
print 'D:\dev\SQL\DFINAnalytics\DFS_IO_BoundQry2000_ProcessTable.sql' 

--* USEDFINAnalytics
go

if not exists (select 1 from sys.tables where name = 'DFS_IO_BoundQry2000')
begin
CREATE TABLE [dbo].[DFS_IO_BoundQry2000](
	[SVRName] [NVARCHAR](150) NULL,
	[DBName] [varchar](6) NOT NULL,
	[text] [nvarchar](max) NULL,
	[query_plan] [xml] NULL,
	[sql_handle] [varbinary](64) NOT NULL,
	[statement_start_offset] [int] NOT NULL,
	[statement_end_offset] [int] NOT NULL,
	[plan_generation_num] [bigint] NULL,
	[plan_handle] [varbinary](64) NOT NULL,
	[creation_time] [datetime] NULL,
	[last_execution_time] [datetime] NULL,
	[execution_count] [bigint] NOT NULL,
	[total_worker_time] [bigint] NOT NULL,
	[last_worker_time] [bigint] NOT NULL,
	[min_worker_time] [bigint] NOT NULL,
	[max_worker_time] [bigint] NOT NULL,
	[total_physical_reads] [bigint] NOT NULL,
	[last_physical_reads] [bigint] NOT NULL,
	[min_physical_reads] [bigint] NOT NULL,
	[max_physical_reads] [bigint] NOT NULL,
	[total_logical_writes] [bigint] NOT NULL,
	[last_logical_writes] [bigint] NOT NULL,
	[min_logical_writes] [bigint] NOT NULL,
	[max_logical_writes] [bigint] NOT NULL,
	[total_logical_reads] [bigint] NOT NULL,
	[last_logical_reads] [bigint] NOT NULL,
	[min_logical_reads] [bigint] NOT NULL,
	[max_logical_reads] [bigint] NOT NULL,
	[total_clr_time] [bigint] NOT NULL,
	[last_clr_time] [bigint] NOT NULL,
	[min_clr_time] [bigint] NOT NULL,
	[max_clr_time] [bigint] NOT NULL,
	[total_elapsed_time] [bigint] NOT NULL,
	[last_elapsed_time] [bigint] NOT NULL,
	[min_elapsed_time] [bigint] NOT NULL,
	[max_elapsed_time] [bigint] NOT NULL,
	[query_hash] [binary](8) NULL,
	[query_plan_hash] [binary](8) NULL,
	[total_rows] [bigint] NULL,
	[last_rows] [bigint] NULL,
	[min_rows] [bigint] NULL,
	[max_rows] [bigint] NULL,
	[statement_sql_handle] [varbinary](64) NULL,
	[statement_context_id] [bigint] NULL,
	[total_dop] [bigint] NULL,
	[last_dop] [bigint] NULL,
	[min_dop] [bigint] NULL,
	[max_dop] [bigint] NULL,
	[total_grant_kb] [bigint] NULL,
	[last_grant_kb] [bigint] NULL,
	[min_grant_kb] [bigint] NULL,
	[max_grant_kb] [bigint] NULL,
	[total_used_grant_kb] [bigint] NULL,
	[last_used_grant_kb] [bigint] NULL,
	[min_used_grant_kb] [bigint] NULL,
	[max_used_grant_kb] [bigint] NULL,
	[total_ideal_grant_kb] [bigint] NULL,
	[last_ideal_grant_kb] [bigint] NULL,
	[min_ideal_grant_kb] [bigint] NULL,
	[max_ideal_grant_kb] [bigint] NULL,
	[total_reserved_threads] [bigint] NULL,
	[last_reserved_threads] [bigint] NULL,
	[min_reserved_threads] [bigint] NULL,
	[max_reserved_threads] [bigint] NULL,
	[total_used_threads] [bigint] NULL,
	[last_used_threads] [bigint] NULL,
	[min_used_threads] [bigint] NULL,
	[max_used_threads] [bigint] NULL,
	[RunDate] [datetime] NOT NULL,
	[SSVER] [nvarchar](300) NULL,
	[RunID] [int] NOT NULL,
	[UID] [uniqueidentifier] NOT NULL,
	[Processed] [int] NULL
) ON [PRIMARY] ;

ALTER TABLE [dbo].[DFS_IO_BoundQry2000] ADD  DEFAULT (newid()) FOR [UID]

ALTER TABLE [dbo].[DFS_IO_BoundQry2000] ADD  DEFAULT ((0)) FOR [Processed]

End
go
IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'DFS_IO_BoundQry2000_ProcessTable'
)
    DROP PROCEDURE DFS_IO_BoundQry2000_ProcessTable;
GO
/*
exec DFS_IO_BoundQry2000_ProcessTable
*/
CREATE PROCEDURE DFS_IO_BoundQry2000_ProcessTable
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
     B.[query_hash], B.[query_plan_hash], MAX(B.uid) AS [UID], COUNT(*) AS cnt
     FROM
   [dbo].[DFS_QryPlanBridge] AS A
   JOIN [dbo].[DFS_IO_BoundQry2000] AS B
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
 FROM [dbo].[DFS_IO_BoundQry2000]
 WHERE [UID] = @uid
  );
  SET @plan =
  (
 SELECT [query_plan]
 FROM [dbo].[DFS_IO_BoundQry2000]
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
  UPDATE [dbo].[DFS_IO_BoundQry2000]
    SET Processed = 1, [text] = null, query_plan = null
  WHERE [query_hash] = @query_hash
   AND [query_plan_hash] = @query_plan_hash;
  FETCH NEXT FROM db_cursor INTO @query_hash, @query_plan_hash, @UID, @cnt;
     END;
 CLOSE db_cursor;
 DEALLOCATE db_cursor;
 UPDATE [dbo].[DFS_IO_BoundQry2000]
   SET Processed = 1, [text] = null, query_plan = null
 WHERE [UID] IN
 (
     SELECT B.[UID]
     FROM
   [dbo].[DFS_QryPlanBridge] AS A
   JOIN [dbo].[DFS_IO_BoundQry2000] AS B
   ON B.[query_hash] = A.[query_hash]
    AND B.[query_plan_hash] = A.[query_plan_hash]
     WHERE B.processed = 0
 );
    END;

/****************** PROCESSING FILE *************************************/

GO  
PRINT 'ID# 282'  
print 'D:\dev\SQL\DFINAnalytics\DFS_CPU_BoundQry2000_ProcessTable.sql' 
--* USEDFINAnalytics;
GO
IF NOT EXISTS
(
    SELECT 1
    FROM sys.tables
    WHERE name = 'DFS_CPU_BoundQry2000'
)
    BEGIN
 CREATE TABLE [dbo].[DFS_CPU_BoundQry2000]
 ([SVRName]  [NVARCHAR](150) NULL, 
  [DBName]   [NVARCHAR](150) NULL, 
  [text]     [NVARCHAR](MAX) NULL, 
  [query_plan] [XML] NULL, 
  [sql_handle] [VARBINARY](64) NOT NULL, 
  [statement_start_offset] [INT] NOT NULL, 
  [statement_end_offset]   [INT] NOT NULL, 
  [plan_generation_num]    [BIGINT] NULL, 
  [plan_handle]     [VARBINARY](64) NOT NULL, 
  [creation_time]   [DATETIME] NULL, 
  [last_execution_time]    [DATETIME] NULL, 
  [execution_count] [BIGINT] NOT NULL, 
  [total_worker_time] [BIGINT] NOT NULL, 
  [last_worker_time]  [BIGINT] NOT NULL, 
  [min_worker_time] [BIGINT] NOT NULL, 
  [max_worker_time] [BIGINT] NOT NULL, 
  [total_physical_reads]   [BIGINT] NOT NULL, 
  [last_physical_reads]    [BIGINT] NOT NULL, 
  [min_physical_reads]     [BIGINT] NOT NULL, 
  [max_physical_reads]     [BIGINT] NOT NULL, 
  [total_logical_writes]   [BIGINT] NOT NULL, 
  [last_logical_writes]    [BIGINT] NOT NULL, 
  [min_logical_writes]     [BIGINT] NOT NULL, 
  [max_logical_writes]     [BIGINT] NOT NULL, 
  [total_logical_reads]    [BIGINT] NOT NULL, 
  [last_logical_reads]     [BIGINT] NOT NULL, 
  [min_logical_reads] [BIGINT] NOT NULL, 
  [max_logical_reads] [BIGINT] NOT NULL, 
  [total_clr_time]  [BIGINT] NOT NULL, 
  [last_clr_time]   [BIGINT] NOT NULL, 
  [min_clr_time]    [BIGINT] NOT NULL, 
  [max_clr_time]    [BIGINT] NOT NULL, 
  [total_elapsed_time]     [BIGINT] NOT NULL, 
  [last_elapsed_time] [BIGINT] NOT NULL, 
  [min_elapsed_time]  [BIGINT] NOT NULL, 
  [max_elapsed_time]  [BIGINT] NOT NULL, 
  [query_hash] [BINARY](8) NULL, 
  [query_plan_hash] [BINARY](8) NULL, 
  [total_rows] [BIGINT] NULL, 
  [last_rows]  [BIGINT] NULL, 
  [min_rows]   [BIGINT] NULL, 
  [max_rows]   [BIGINT] NULL, 
  [statement_sql_handle]   [VARBINARY](64) NULL, 
  [statement_context_id]   [BIGINT] NULL, 
  [total_dop]  [BIGINT] NULL, 
  [last_dop]   [BIGINT] NULL, 
  [min_dop]  [BIGINT] NULL, 
  [max_dop]  [BIGINT] NULL, 
  [total_grant_kb]  [BIGINT] NULL, 
  [last_grant_kb]   [BIGINT] NULL, 
  [min_grant_kb]    [BIGINT] NULL, 
  [max_grant_kb]    [BIGINT] NULL, 
  [total_used_grant_kb]    [BIGINT] NULL, 
  [last_used_grant_kb]     [BIGINT] NULL, 
  [min_used_grant_kb] [BIGINT] NULL, 
  [max_used_grant_kb] [BIGINT] NULL, 
  [total_ideal_grant_kb]   [BIGINT] NULL, 
  [last_ideal_grant_kb]    [BIGINT] NULL, 
  [min_ideal_grant_kb]     [BIGINT] NULL, 
  [max_ideal_grant_kb]     [BIGINT] NULL, 
  [total_reserved_threads] [BIGINT] NULL, 
  [last_reserved_threads]  [BIGINT] NULL, 
  [min_reserved_threads]   [BIGINT] NULL, 
  [max_reserved_threads]   [BIGINT] NULL, 
  [total_used_threads]     [BIGINT] NULL, 
  [last_used_threads] [BIGINT] NULL, 
  [min_used_threads]  [BIGINT] NULL, 
  [max_used_threads]  [BIGINT] NULL, 
  [RunDate]  [DATETIME] NOT NULL, 
  [SSVer]    [NVARCHAR](300) NULL, 
  [RunID]    [INT] NOT NULL, 
  [UID] [UNIQUEIDENTIFIER] NOT NULL, 
  [Processed]  [INT] NULL, 
  [RowNbr]   [INT] IDENTITY(1, 1) NOT NULL
 )
 ON [PRIMARY];
 ALTER TABLE [dbo].[DFS_CPU_BoundQry2000]
 ADD DEFAULT(NEWID()) FOR [UID];
 ALTER TABLE [dbo].[DFS_CPU_BoundQry2000]
 ADD DEFAULT((0)) FOR [Processed];
END;
GO
IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'DFS_CPU_BoundQry2000_ProcessTable'
)
    DROP PROCEDURE DFS_CPU_BoundQry2000_ProcessTable;
GO

/*
exec DFS_CPU_BoundQry2000_ProcessTable
*/

CREATE PROCEDURE DFS_CPU_BoundQry2000_ProcessTable
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
     B.[query_hash], 
     B.[query_plan_hash], 
     MAX(uid) AS [UID], 
     COUNT(*) AS cnt
     FROM [dbo].[DFS_QryPlanBridge] AS A
   JOIN [dbo].[DFS_CPU_BoundQry2000] AS B
   ON B.[query_hash] = A.[query_hash]
    AND B.[query_plan_hash] = A.[query_plan_hash]
     WHERE B.processed = 0
     GROUP BY B.[query_hash], 
  B.[query_plan_hash];
 OPEN db_cursor;
 FETCH NEXT FROM db_cursor INTO @query_hash, @query_plan_hash, @UID, @cnt;
 WHILE @@FETCH_STATUS = 0
     BEGIN
  SET @i = @i + 1;
  PRINT 'I: ' + CAST(@i AS NVARCHAR(15));
  SET @SQL =
  (
 SELECT [text]
 FROM [dbo].[DFS_CPU_BoundQry2000]
 WHERE [UID] = @uid
  );
  SET @plan =
  (
 SELECT [query_plan]
 FROM [dbo].[DFS_CPU_BoundQry2000]
 WHERE [UID] = @uid
  );
  SET @cnt =
  (
 SELECT COUNT(*)
 FROM [dbo].[DFS_QryPlanBridge]
 WHERE [query_hash] = @query_hash
     AND [query_plan_hash] = @query_plan_hash
  );
  IF
     (@cnt = 0
     )
 BEGIN
   INSERT INTO [dbo].[DFS_QryPlanBridge]
   ( [query_hash], 
     [query_plan_hash], 
     [PerfType], 
     [TblType], 
     [CreateDate], 
     [LastUpdate], 
     NbrHits
   ) 
   VALUES
   (
     @query_hash
   , @query_plan_hash
   , 'C'
   , '2000'
   , GETDATE()
   , GETDATE()
   , 1
   );
  END;
  SET @cnt =
  (
 SELECT COUNT(*)
 FROM [dbo].[DFS_QrysPlans]
 WHERE [query_hash] = @query_hash
     AND [query_plan_hash] = @query_plan_hash
  );
  IF
     (@cnt = 0
     )
 BEGIN
   INSERT INTO [dbo].[DFS_QrysPlans]
   ( [query_hash], 
     [query_plan_hash], 
     [UID], 
     [PerfType], 
     [text], 
     [query_plan], 
     [CreateDate]
   ) 
   VALUES
   (
     @query_hash
   , @query_plan_hash
   , @UID
   , 'C'
   , @SQL
   , @plan
   , GETDATE()
   );
  END;
  UPDATE [dbo].[DFS_CPU_BoundQry2000]
    SET Processed = 1, [text] = null, query_plan = null
  WHERE [query_hash] = @query_hash
   AND [query_plan_hash] = @query_plan_hash
   AND processed = 0;
  FETCH NEXT FROM db_cursor INTO @query_hash, @query_plan_hash, @UID, @cnt;
     END;
 CLOSE db_cursor;
 DEALLOCATE db_cursor;
 UPDATE [dbo].[DFS_CPU_BoundQry2000]
		  SET Processed = 1, [text] = null, query_plan = null
 WHERE [UID] IN
 (
     SELECT B.[UID]
     FROM [dbo].[DFS_QryPlanBridge] AS A
   JOIN [dbo].[DFS_CPU_BoundQry2000] AS B
   ON B.[query_hash] = A.[query_hash]
    AND B.[query_plan_hash] = A.[query_plan_hash]
     WHERE B.processed = 0
 );
    END;

/****************** PROCESSING FILE *************************************/

GO  
PRINT 'ID# 283'  
print 'D:\dev\SQL\DFINAnalytics\DFS_CPU_BoundQry_ProcessTable.sql' 

--* USEDFINAnalytics;
GO

IF EXISTS
(
    SELECT name
    FROM sys.tables
    WHERE name = 'DFS_CPU_BoundQry'
)
drop table DFS_CPU_BoundQry;

begin
 CREATE TABLE [dbo].[DFS_CPU_BoundQry]
 ([SVRName]  [NVARCHAR](150) NULL, 
  [DBName]   [NVARCHAR](150) NULL, 
  [text]     [NVARCHAR](MAX) NULL, 
  [query_plan] [XML] NULL, 
  [sql_handle] [VARBINARY](64) NOT NULL, 
  [statement_start_offset] [INT] NOT NULL, 
  [statement_end_offset]   [INT] NOT NULL, 
  [plan_generation_num]    [BIGINT] NULL, 
  [plan_handle]     [VARBINARY](64) NOT NULL, 
  [creation_time]   [DATETIME] NULL, 
  [last_execution_time]    [DATETIME] NULL, 
  [execution_count] [BIGINT] NOT NULL, 
  [total_worker_time] [BIGINT] NOT NULL, 
  [last_worker_time]  [BIGINT] NOT NULL, 
  [min_worker_time] [BIGINT] NOT NULL, 
  [max_worker_time] [BIGINT] NOT NULL, 
  [total_physical_reads]   [BIGINT] NOT NULL, 
  [last_physical_reads]    [BIGINT] NOT NULL, 
  [min_physical_reads]     [BIGINT] NOT NULL, 
  [max_physical_reads]     [BIGINT] NOT NULL, 
  [total_logical_writes]   [BIGINT] NOT NULL, 
  [last_logical_writes]    [BIGINT] NOT NULL, 
  [min_logical_writes]     [BIGINT] NOT NULL, 
  [max_logical_writes]     [BIGINT] NOT NULL, 
  [total_logical_reads]    [BIGINT] NOT NULL, 
  [last_logical_reads]     [BIGINT] NOT NULL, 
  [min_logical_reads] [BIGINT] NOT NULL, 
  [max_logical_reads] [BIGINT] NOT NULL, 
  [total_clr_time]  [BIGINT] NOT NULL, 
  [last_clr_time]   [BIGINT] NOT NULL, 
  [min_clr_time]    [BIGINT] NOT NULL, 
  [max_clr_time]    [BIGINT] NOT NULL, 
  [total_elapsed_time]     [BIGINT] NOT NULL, 
  [last_elapsed_time] [BIGINT] NOT NULL, 
  [min_elapsed_time]  [BIGINT] NOT NULL, 
  [max_elapsed_time]  [BIGINT] NOT NULL, 
  [query_hash] [BINARY](8) NULL, 
  [query_plan_hash] [BINARY](8) NULL, 
  [total_rows] [BIGINT] NULL, 
  [last_rows]  [BIGINT] NULL, 
  [min_rows]   [BIGINT] NULL, 
  [max_rows]   [BIGINT] NULL, 
  [statement_sql_handle]   [VARBINARY](64) NULL, 
  [statement_context_id]   [BIGINT] NULL, 
  [total_dop]  [BIGINT] NULL, 
  [last_dop]   [BIGINT] NULL, 
  [min_dop]  [BIGINT] NULL, 
  [max_dop]  [BIGINT] NULL, 
  [total_grant_kb]  [BIGINT] NULL, 
  [last_grant_kb]   [BIGINT] NULL, 
  [min_grant_kb]    [BIGINT] NULL, 
  [max_grant_kb]    [BIGINT] NULL, 
  [total_used_grant_kb]    [BIGINT] NULL, 
  [last_used_grant_kb]     [BIGINT] NULL, 
  [min_used_grant_kb] [BIGINT] NULL, 
  [max_used_grant_kb] [BIGINT] NULL, 
  [total_ideal_grant_kb]   [BIGINT] NULL, 
  [last_ideal_grant_kb]    [BIGINT] NULL, 
  [min_ideal_grant_kb]     [BIGINT] NULL, 
  [max_ideal_grant_kb]     [BIGINT] NULL, 
  [total_reserved_threads] [BIGINT] NULL, 
  [last_reserved_threads]  [BIGINT] NULL, 
  [min_reserved_threads]   [BIGINT] NULL, 
  [max_reserved_threads]   [BIGINT] NULL, 
  [total_used_threads]     [BIGINT] NULL, 
  [last_used_threads] [BIGINT] NULL, 
  [min_used_threads]  [BIGINT] NULL, 
  [max_used_threads]  [BIGINT] NULL, 
  [RunDate]  [DATETIME] NULL, 
  [RunID]    [BIGINT] NULL, 
  [UID] [UNIQUEIDENTIFIER] NOT NULL, 
  [Processed]  [INT] NULL
 )
 ON [PRIMARY];
 ALTER TABLE [dbo].[DFS_CPU_BoundQry]
 ADD DEFAULT(NEWID()) FOR [UID];
 ALTER TABLE [dbo].[DFS_CPU_BoundQry]
 ADD DEFAULT((0)) FOR [Processed];

		create index PI_DFS_CPU_BoundQryUID on DFS_CPU_BoundQry ([UID]);
		create index PI_DFS_CPU_BoundQryProcessed on DFS_CPU_BoundQry ([Processed]);
		create index pkDFS_CPU_BoundQry on DFS_CPU_BoundQry (SvrName, DBName, query_hash, query_plan_hash);
end 
IF EXISTS
(
    SELECT 1
    FROM sys.tables
    WHERE name = 'DFS_QryPlanBridge'
)
drop TABLE [dbo].[DFS_QryPlanBridge];


 CREATE TABLE [dbo].[DFS_QryPlanBridge]
 ([query_hash] [BINARY](8) NULL, 
  [query_plan_hash] [BINARY](8) NULL, 
  [PerfType] [CHAR](1) NOT NULL, 
  [TblType]  [NVARCHAR](10) NOT NULL, 
  [CreateDate] [DATETIME] NOT NULL, 
  [LastUpdate] [DATETIME] NOT NULL, 
  [NbrHits]  [INT] NULL
 )
 ON [PRIMARY];
 ALTER TABLE [dbo].[DFS_QryPlanBridge]
 ADD DEFAULT(GETDATE()) FOR [CreateDate];
 ALTER TABLE [dbo].[DFS_QryPlanBridge]
 ADD DEFAULT(GETDATE()) FOR [LastUpdate];
 ALTER TABLE [dbo].[DFS_QryPlanBridge]
 ADD DEFAULT((0)) FOR [NbrHits];

		create index PI_DFS_QryPlanBridgeQuery_hash on DFS_QryPlanBridge ([query_hash],[query_plan_hash]);

IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'UTIL_DFS_CPU_BoundQry'
)
    DROP PROCEDURE UTIL_DFS_CPU_BoundQry;
GO

/*
exec UTIL_DFS_CPU_BoundQry
*/

CREATE PROCEDURE UTIL_DFS_CPU_BoundQry
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
     B.[query_hash], 
     B.[query_plan_hash], 
     MAX([UID]) AS [UID], 
     COUNT(*) AS cnt
     FROM [dbo].[DFS_QryPlanBridge] AS A
   JOIN [dbo].[DFS_CPU_BoundQry] AS B
   ON B.[query_hash] = A.[query_hash]
    AND B.[query_plan_hash] = A.[query_plan_hash]
     WHERE B.processed = 0
     GROUP BY B.[query_hash], 
  B.[query_plan_hash];
 OPEN db_cursor;
 FETCH NEXT FROM db_cursor INTO @query_hash, @query_plan_hash, @UID, @cnt;
 WHILE @@FETCH_STATUS = 0
     BEGIN
  SET @i = @i + 1;
  PRINT 'I: ' + CAST(@i AS NVARCHAR(15));
  SET @SQL =
  (
 SELECT [text]
 FROM [dbo].[DFS_CPU_BoundQry]
 WHERE [UID] = @uid
  );
  SET @plan =
  (
 SELECT [query_plan]
 FROM [dbo].[DFS_CPU_BoundQry]
 WHERE [UID] = @uid
  );
  SET @cnt =
  (
 SELECT COUNT(*)
 FROM [dbo].[DFS_QryPlanBridge]
 WHERE [query_hash] = @query_hash
     AND [query_plan_hash] = @query_plan_hash
  );
  IF
     (@cnt = 0
     )
 BEGIN
   INSERT INTO [dbo].[DFS_QryPlanBridge]
   ( [query_hash], 
     [query_plan_hash], 
     [PerfType], 
     [TblType], 
     [CreateDate], 
     [LastUpdate], 
     NbrHits
   ) 
   VALUES
   (
     @query_hash
   , @query_plan_hash
   , 'C'
   , '2000'
   , GETDATE()
   , GETDATE()
   , 1
   );
  END;
  SET @cnt =
  (
 SELECT COUNT(*)
 FROM [dbo].[DFS_QrysPlans]
 WHERE [query_hash] = @query_hash
     AND [query_plan_hash] = @query_plan_hash
  );
  IF
     (@cnt = 0
     )
 BEGIN
   INSERT INTO [dbo].[DFS_QrysPlans]
   ( [query_hash], 
     [query_plan_hash], 
     [UID], 
     [PerfType], 
     [text], 
     [query_plan], 
     [CreateDate]
   ) 
   VALUES
   (
     @query_hash
   , @query_plan_hash
   , @UID
   , 'C'
   , @SQL
   , @plan
   , GETDATE()
   );
  END;
  UPDATE [dbo].[DFS_CPU_BoundQry]
    SET Processed = 1, [text] = null, query_plan = null
  WHERE [query_hash] = @query_hash
   AND [query_plan_hash] = @query_plan_hash
   AND processed = 0;
  FETCH NEXT FROM db_cursor INTO @query_hash, @query_plan_hash, @UID, @cnt;
     END;
 CLOSE db_cursor;
 DEALLOCATE db_cursor;
 UPDATE [dbo].[DFS_CPU_BoundQry]
   SET Processed = 1, [text] = null, query_plan = null
 WHERE [UID] IN
 (
     SELECT B.[UID]
     FROM [dbo].[DFS_QryPlanBridge] AS A
   JOIN [dbo].[DFS_CPU_BoundQry] AS B
   ON B.[query_hash] = A.[query_hash]
    AND B.[query_plan_hash] = A.[query_plan_hash]
     WHERE B.processed = 0
 );
    END;

/****************** PROCESSING FILE *************************************/

GO  
PRINT 'ID# 284'  
print 'D:\dev\SQL\DFINAnalytics\DFS_IO_BoundQry_ProcessTable.sql' 
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

/****************** PROCESSING FILE *************************************/

GO  
PRINT 'ID# 284'  
print 'D:\dev\SQL\DFINAnalytics\dm_exec_session_wait_stats.sql' 
--* USEDFINAnalytics;
GO

/* 
truncate TABLE [dbo].[DFS_WaitStats]
*/

/*
declare @MaxWaitMS int = 0;
DECLARE @RunID INT= 0;
EXEC @RunID = sp_UTIL_GetSeq;
declare @stmt nvarchar(100) = '--* USE?; exec sp_UTIL_DFS_WaitStats '+cast(@RunID as nvarchar(15))+', '+cast(@MaxWaitMS as nvarchar(15))+' ; '
exec sp_msForEachDB @stmt ;
select * from dbo.DFS_WaitStats order by DBName,session_id, wait_type;
*/


/* DROP TABLE [dbo].[DFS_WaitStats]*/

IF NOT EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.TABLES
    WHERE TABLE_NAME = 'DFS_WaitStats'
   AND TABLE_TYPE = 'BASE TABLE'
)
    BEGIN
 CREATE TABLE [dbo].[DFS_WaitStats]
 (SvrName   NVARCHAR(150) NOT NULL
     DEFAULT @@servername, 
  DBName  NVARCHAR(150) NOT NULL
     DEFAULT DB_NAME(), 
  [session_id]   [SMALLINT] NOT NULL, 
  [wait_type]    [NVARCHAR](60) NOT NULL, 
  [waiting_tasks_count] [BIGINT] NOT NULL, 
  [wait_time_ms] [BIGINT] NOT NULL, 
  [max_wait_time_ms]    [BIGINT] NOT NULL, 
  [signal_wait_time_ms] [BIGINT] NOT NULL, 
  RunID   INT NULL, 
  CreateDate     DATETIME NOT NULL
     DEFAULT GETDATE(), 
  [UID]   UNIQUEIDENTIFIER NOT NULL
 DEFAULT NEWID()
 )
 ON [PRIMARY];

		create index pi_DFS_WaitStatsSVR on DFS_WaitStats (SvrName,DBName,[session_id]);
		create index pi_DFS_WaitStatsUID on DFS_WaitStats ([UID]);

END;
GO
--* USEmaster;
GO
IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'sp_UTIL_DFS_WaitStats'
)
    DROP PROCEDURE sp_UTIL_DFS_WaitStats;
GO
CREATE PROCEDURE sp_UTIL_DFS_WaitStats
(@RunID     INT, 
 @MaxWaitMS BIGINT
)
AS

/*DECLARE @RunID INT= 0;
EXEC @RunID = sp_UTIL_GetSeq;*/

    BEGIN
 INSERT INTO dbo.DFS_WaitStats
   SELECT @@servername AS [SvrName], 
   DB_NAME() AS [DBName], 
   WS.[session_id], 
   WS.[wait_type], 
   WS.[waiting_tasks_count], 
   WS.[wait_time_ms], 
   WS.[max_wait_time_ms], 
   WS.[signal_wait_time_ms], 
   @RunID, 
   GETDATE(), 
   NEWID()
   FROM sys.dm_exec_session_wait_stats WS
   WHERE WS.wait_time_ms >= @MaxWaitMS;
    END;

/****************** PROCESSING FILE *************************************/

GO  
PRINT 'ID# 290'  
print 'D:\dev\SQL\DFINAnalytics\create_view_SessionStatus.sql' 
--* USEDFINAnalytics;
go
-- drop view view_SessionStatus
-- select top 100 * from sys.dm_exec_connections
-- select * from view_SessionStatus where SPID = 60

if exists (select 1 from INFORMATION_SCHEMA.TABLES where TABLE_NAME = 'view_SessionStatus')
drop VIEW view_SessionStatus;
go
CREATE VIEW view_SessionStatus
AS
     SELECT S.Session_id AS [SPID], 
     S.STATUS, 
			SP.blocked,
			SP.waittime,
			SP.LastWaitType,
			S.cpu_time, 
     S.reads AS SessionReads, 
     S.writes AS SessionWrites, 
     S.total_elapsed_time, 
     C.num_reads AS ConnectionReads, 
     C.num_writes AS ConnectionWrites, 
     U.database_id, 
     U.user_objects_alloc_page_count, 
     U.user_objects_dealloc_page_count, 
     U.internal_objects_alloc_page_count, 
     U.internal_objects_dealloc_page_count, 
     SP.cmd AS CmdState, 
			db_name(SP.dbid) AS DBNAME,
			WT.[definition] AS LastWaitTypeDEF,
     st.[text] AS CmdSQL
     /*,p.[query_plan] */
     FROM   sys.dm_exec_sessions S
     JOIN sys.dm_exec_connections C
  ON C.session_id = S.session_id
     JOIN sys.dm_db_session_space_usage U
  ON U.session_id = S.session_id
     JOIN sys.sysprocesses SP
  ON SP.spid = S.session_id
     CROSS APPLY sys.dm_exec_sql_text(SP.sql_handle) st
	 left outer join [dbo].[DFS_WaitTypes] WT on SP.LastWaitType = WT.typecode
	 /*
	 SELECT TOP 100 * FROM  sys.dm_exec_sessions
	 SELECT TOP 100 * FROM  sys.sysprocesses
	 */
/*CROSS APPLY sys.dm_exec_query_plan(SP.sql_handle) p*/


/****************** PROCESSING FILE *************************************/

GO  
PRINT 'ID# 291'  
print 'D:\dev\SQL\DFINAnalytics\DFS_GetAllTableSizesAndRowCnt.sql' 
GO

/** USE DFINAnalytics;*/

IF NOT EXISTS
(
    SELECT 1
    FROM sys.tables
    WHERE name = 'DFS_TableSizeAndRowCnt'
)
    BEGIN

        /* drop TABLE [dbo].[DFS_TableSizeAndRowCnt];*/

        CREATE TABLE [dbo].[DFS_TableSizeAndRowCnt]
        (SvrName         NVARCHAR(150) NOT NULL, 
         DBName          NVARCHAR(150) NOT NULL, 
         [TableName]     [SYSNAME] NOT NULL, 
         [SchemaName]    [SYSNAME] NULL, 
         [RowCounts]     [BIGINT] NULL, 
         [TotalSpaceKB]  [BIGINT] NULL, 
         [UsedSpaceKB]   [BIGINT] NULL, 
         [UnusedSpaceKB] [BIGINT] NULL, 
         [UID]           UNIQUEIDENTIFIER NOT NULL
                                          DEFAULT NEWID(), 
         CreateDate      DATETIME DEFAULT GETDATE() NOT NULL
        )
        ON [PRIMARY];
END;
GO
IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'DFS_GetAllTableSizesAndRowCnt'
)
    DROP PROCEDURE DFS_GetAllTableSizesAndRowCnt;
GO

/* exec DFS_GetAllTableSizesAndRowCnt*/

CREATE PROCEDURE DFS_GetAllTableSizesAndRowCnt
AS
    BEGIN
        INSERT INTO [dbo].[DFS_TableSizeAndRowCnt]
        ( SvrName, 
          DBName, 
          [TableName], 
          [SchemaName], 
          [RowCounts], 
          [TotalSpaceKB], 
          [UsedSpaceKB], 
          [UnusedSpaceKB], 
          [UID], 
          CreateDate
        ) 
               SELECT @@servername AS SvrName, 
                      DB_NAME() AS DBName, 
                      t.NAME AS TableName, 
                      s.Name AS SchemaName, 
                      p.rows AS RowCounts, 
                      SUM(a.total_pages) * 8 AS TotalSpaceKB, 
                      SUM(a.used_pages) * 8 AS UsedSpaceKB, 
                      (SUM(a.total_pages) - SUM(a.used_pages)) * 8 AS UnusedSpaceKB, 
                      NEWID() AS [UID], 
                      GETDATE() AS createDate
               FROM sys.tables t
                         INNER JOIN sys.indexes i
                         ON t.OBJECT_ID = i.object_id
                              INNER JOIN sys.partitions p
                         ON i.object_id = p.OBJECT_ID
                            AND i.index_id = p.index_id
                                   INNER JOIN sys.allocation_units a
                         ON p.partition_id = a.container_id
                                        LEFT OUTER JOIN sys.schemas s
                         ON t.schema_id = s.schema_id
               WHERE t.NAME NOT LIKE 'dt%'
                     AND t.is_ms_shipped = 0
                     AND i.OBJECT_ID > 255
               GROUP BY t.Name, 
                        s.Name, 
                        p.Rows
               ORDER BY t.Name
			   OPTION (MAXDOP 2);  
    END;
GO

/****************** PROCESSING FILE *************************************/

GO  
PRINT 'ID# 292'  
print 'D:\dev\SQL\DFINAnalytics\UTIL_UpdateQryPlansAndText.sql' 

IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'UTIL_UpdateQryPlansAndText'
)
    BEGIN
        DROP PROCEDURE UTIL_UpdateQryPlansAndText;
END;
GO

/*
exec UTIL_UpdateQryPlansAndText 'DFS_IO_BoundQry2000' ;
exec UTIL_UpdateQryPlansAndText 'DFS_CPU_BoundQry2000' ;
exec UTIL_UpdateQryPlansAndText 'DFS_IO_BoundQry' ;
exec UTIL_UpdateQryPlansAndText 'DFS_CPU_BoundQry' ;

select top 100 * from DFS_QryPlanBridge

*/

CREATE PROCEDURE UTIL_UpdateQryPlansAndText
(@TgtTbl NVARCHAR(150), 
 @debug  INT           = 0
)
AS
    BEGIN
        DECLARE @stmt AS NVARCHAR(MAX)= '';
        DELETE FROM DFS_QryPlanBridge
        WHERE [query_hash] IS NULL
              AND [query_plan_hash] IS NULL;

        /* Delete Duplicate records */
        WITH CTE([query_hash], 
                 [query_plan_hash], 
                 DuplicateCount)
             AS (SELECT [query_hash], 
                        [query_plan_hash], 
                        ROW_NUMBER() OVER(PARTITION BY [query_hash], 
                                                       [query_plan_hash]
                        ORDER BY [query_hash], 
                                 [query_plan_hash]) AS DuplicateCount
                 FROM DFS_QryPlanBridge)
             DELETE FROM CTE
             WHERE DuplicateCount > 1;
        SET @stmt = 'UPDATE DFS_QryPlanBridge SET NbrHits = NbrHits + 1
						where exists (select Q.[query_hash], Q.[query_plan_hash] from DFS_QryPlanBridge Q 
										join ' + @TgtTbl + ' B 
										on B.[query_hash] = Q.[query_hash]
										and B.[query_plan_hash] = Q.[query_plan_hash] )';
        EXECUTE sp_executesql 
                @stmt;
        IF
           (@debug = 1
           )
            PRINT @stmt;
        SET @stmt = 'insert into [dbo].[DFS_QryPlanBridge] ([query_hash],[query_plan_hash],[PerfType],[TblType],[CreateDate],LastUpdate,NbrHits)  
						select distinct Q.[query_hash],Q.[query_plan_hash],''C'' as PerfType, ''2000'' as [TblType],getdate() as [CreateDate], getdate() as LastUpdate,1 as NbrHits
						from ' + @TgtTbl + ' Q 
						WHERE NOT EXISTS 
						   (SELECT distinct [query_hash],[query_plan_hash]
							from [DFS_QryPlanBridge] B
							WHERE B.[query_hash] = Q.[query_hash] AND B.[query_plan_hash] = Q.[query_plan_hash]);
						';
        IF
           (@debug = 1
           )
            PRINT @stmt;
        EXECUTE sp_executesql 
                @stmt;
        SET @stmt = 'insert into [dbo].[DFS_QrysPlans] ([query_hash],[query_plan_hash],[UID],PerfType, [text], query_plan, CreateDate)  
						select Q.[query_hash],Q.[query_plan_hash],newid() as PerfType, ''C'' as PerfType, [text] ,query_plan, getdate() as [CreateDate]
						from ' + @TgtTbl + ' Q 
						WHERE NOT EXISTS 
						   (SELECT distinct [query_hash],[query_plan_hash]
							from [DFS_QrysPlans] B
							WHERE B.[query_hash] = Q.[query_hash] AND B.[query_plan_hash] = Q.[query_plan_hash]);
						';
        IF
           (@debug = 1
           )
            PRINT @stmt;
        EXECUTE sp_executesql 
                @stmt;

        /* truncate table [DFS_QryPlanBridge]*/

        SET @stmt = 'WITH CTE_parent 
						AS
						(
							SELECT  [query_hash], [query_plan_hash]
							FROM    [DFS_QryPlanBridge]
						)    
						UPDATE DFS_CPU_BoundQry2000 
						SET [text] = null, [query_plan] = null
						FROM CTE_parent C
						INNER JOIN ' + @TgtTbl + ' Q 
						ON C.[query_hash] = Q.[query_hash]
						and C.[query_plan_hash] = Q.[query_plan_hash] 
						where Q.Processed = 0; ';
        EXECUTE sp_executesql 
                @stmt;
        IF
           (@debug = 1
           )
            PRINT @stmt;
        SET @stmt = 'UPDATE ' + @TgtTbl + ' SET processed = 1
						where exists (select Q.[query_hash], Q.[query_plan_hash] from DFS_QryPlanBridge Q 
										join ' + @TgtTbl + ' B 
										on B.[query_hash] = Q.[query_hash]
										and B.[query_plan_hash] = Q.[query_plan_hash]
										and B.Processed = 0)';
        EXECUTE sp_executesql 
                @stmt;
        IF
           (@debug = 1
           )
            PRINT @stmt;
        DELETE FROM DFS_QryPlanBridge
        WHERE [query_hash] IS NULL
              AND [query_plan_hash] IS NULL;

        /* Delete Duplicate records */
        WITH CTE([query_hash], 
                 [query_plan_hash], 
                 DuplicateCount)
             AS (SELECT [query_hash], 
                        [query_plan_hash], 
                        ROW_NUMBER() OVER(PARTITION BY [query_hash], 
                                                       [query_plan_hash]
                        ORDER BY [query_hash], 
                                 [query_plan_hash]) AS DuplicateCount
                 FROM DFS_QryPlanBridge)
             DELETE FROM CTE
             WHERE DuplicateCount > 1;
    END;

/****************** PROCESSING FILE *************************************/

GO  
PRINT 'ID# 295'  
print 'D:\dev\SQL\DFINAnalytics\createActiveServersTable.sql' 

GO
-- drop table ActiveServers
DECLARE @db NVARCHAR(150)= '';
SET @db = DB_NAME();
print 'WORKING IN DATABASE: ' + @db ;
IF @db = 'DFINAnalytics'
    BEGIN
        IF NOT EXISTS
        (
            SELECT 1
            FROM sys.tables
            WHERE name = 'ActiveServers'
        )
            BEGIN
                CREATE TABLE [dbo].[ActiveServers]
                (GroupName nvarchar(50) not null,
				[isAzure] [CHAR](1) NOT NULL, 
                 [SvrName] [NVARCHAR](250) NOT NULL, 
                 [DBName]  [NVARCHAR](250) NOT NULL, 
                 [UserID]  [NVARCHAR](50) NULL, 
                 [pwd]     [NVARCHAR](50) NULL, 
                 [UID]     [UNIQUEIDENTIFIER] NOT NULL
                )
                ON [PRIMARY];
                ALTER TABLE [dbo].[ActiveServers]
                ADD CONSTRAINT [DF_ActiveServers_UID] DEFAULT(NEWID()) FOR [UID];
                CREATE UNIQUE INDEX pkActiveServers
                ON ActiveServers
                (GroupName, [UID]
                );
        END;
END;

/****************** PROCESSING FILE *************************************/

GO  
PRINT 'ID# 300'  
print 'D:\dev\SQL\DFINAnalytics\VerifyUIDIndexes.sql' 


GO
IF NOT EXISTS
(
    SELECT 1
    FROM sys.tables
    WHERE name = 'DFS_SEQ'
)
    BEGIN
CREATE TABLE [dbo].[DFS_SEQ](
	[GenDate] [datetime] NULL,
	[SeqID] [int] IDENTITY(1,1) NOT NULL,
	[UID] [uniqueidentifier] NOT NULL
) ON [PRIMARY]
ALTER TABLE [dbo].[DFS_SEQ] ADD  DEFAULT (getdate()) FOR [GenDate]
ALTER TABLE [dbo].[DFS_SEQ] ADD  DEFAULT (newid()) FOR [UID]
end

GO
IF NOT EXISTS
(
    SELECT 1
    FROM sys.tables
    WHERE name = 'DFS_PerfMonitor'
)
    BEGIN
        CREATE TABLE [dbo].[DFS_PerfMonitor]
        ([SVRNAME]     [NVARCHAR](150) NULL, 
         [DBNAME]      [NVARCHAR](150) NULL, 
         [SSVER]       [NVARCHAR](250) NULL, 
         [RunID]       [INT] NOT NULL, 
         [ProcName]    [VARCHAR](100) NOT NULL, 
         [LocID]       [VARCHAR](50) NOT NULL, 
         [UKEY]        [UNIQUEIDENTIFIER] NOT NULL, 
         [StartTime]   [DATETIME2](7) NULL, 
         [EndTime]     [DATETIME2](7) NULL, 
         [ElapsedTime] [DECIMAL](18, 3) NULL, 
         [CreateDate]  [DATETIME] NULL, 
         [UID]         [UNIQUEIDENTIFIER] NULL, 
         CONSTRAINT [PK_PerfMonitor] PRIMARY KEY CLUSTERED([UKEY] ASC)
         WITH(PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
        )
        ON [PRIMARY];
        ALTER TABLE [dbo].[DFS_PerfMonitor]
        ADD CONSTRAINT [DF_PerfMonitor_UKEY] DEFAULT(NEWID()) FOR [UKEY];
        ALTER TABLE [dbo].[DFS_PerfMonitor]
        ADD DEFAULT(GETDATE()) FOR [CreateDate];
        ALTER TABLE [dbo].[DFS_PerfMonitor]
        ADD DEFAULT(NEWID()) FOR [UID];
END;
GO
IF NOT EXISTS
(
    SELECT 1
    FROM sys.tables
    WHERE name = 'DFS_TxMonitorTblUpdates'
)
    BEGIN
        CREATE TABLE [dbo].[DFS_TxMonitorTblUpdates]
        ([SVR]            [NVARCHAR](128) NULL, 
         [database_id]    [INT] NOT NULL, 
         [SchemaName]     [NVARCHAR](128) NULL, 
         [DBname]         [NVARCHAR](128) NULL, 
         [TableName]      [NVARCHAR](128) NULL, 
         [user_lookups]   [INT] NULL, 
         [user_scans]     [INT] NULL, 
         [user_seeks]     [INT] NULL, 
         [UpdatedRows]    [BIGINT] NOT NULL, 
         [LastUpdateTime] [DATETIME] NULL, 
         [CreateDate]     [DATETIME] NULL, 
         [ExecutionDate]  [DATETIME] NOT NULL, 
         [RowID]          [BIGINT] IDENTITY(1, 1) NOT NULL, 
         [RunID]          [INT] NULL, 
         [UID]            [UNIQUEIDENTIFIER] NOT NULL
        )
        ON [PRIMARY];
        ALTER TABLE [dbo].[DFS_TxMonitorTblUpdates]
        ADD DEFAULT(GETDATE()) FOR [CreateDate];
        ALTER TABLE [dbo].[DFS_TxMonitorTblUpdates]
        ADD DEFAULT(NEWID()) FOR [UID];
END;
GO
IF NOT EXISTS
(
    SELECT 1
    FROM sys.tables
    WHERE name = 'DFS_TableStats'
)
    BEGIN
        CREATE TABLE [dbo].[DFS_TableStats]
        ([ServerName]    [NVARCHAR](128) NULL, 
         [DBName]        [NVARCHAR](128) NULL, 
         [TableName]     [NVARCHAR](128) NULL, 
         [Reads]         [INT] NULL, 
         [Writes]        [INT] NULL, 
         [ReadsWrites]   [INT] NULL, 
         [SampleDays]    [DECIMAL](18, 8) NULL, 
         [SampleSeconds] [INT] NULL, 
         [RunDate]       [DATETIME] NULL, 
         [UID]           [UNIQUEIDENTIFIER] NULL, 
         [RowID]         [BIGINT] IDENTITY(1, 1) NOT NULL
        )
        ON [PRIMARY];
        ALTER TABLE [dbo].[DFS_TableStats]
        ADD CONSTRAINT [DF_DFS_TableStats_RunDate] DEFAULT(GETDATE()) FOR [RunDate];
        ALTER TABLE [dbo].[DFS_TableStats]
        ADD DEFAULT(NEWID()) FOR [UID];
END;
GO
IF NOT EXISTS
(
    SELECT 1
    FROM sys.tables
    WHERE name = 'DFS_IndexReorgCmds'
)
    BEGIN
        CREATE TABLE [dbo].[DFS_IndexReorgCmds]
        ([CMD]     [NVARCHAR](MAX) NULL, 
         [RowNbr]  [INT] IDENTITY(1, 1) NOT NULL, 
         [PctFrag] [DECIMAL](10, 2) NULL, 
         [UID]     [UNIQUEIDENTIFIER] NOT NULL
        )
        ON [PRIMARY];
        ALTER TABLE [dbo].[DFS_IndexReorgCmds] ADD DEFAULT(NEWID()) FOR [UID];
END;
GO
IF NOT EXISTS
(
    SELECT 1
    FROM sys.tables
    WHERE name = 'DFS_$ActiveDatabases'
)
    BEGIN
        CREATE TABLE [dbo].[DFS_$ActiveDatabases]
        ([GroupName]  [NVARCHAR](50) NOT NULL, 
         [ServerName] [NVARCHAR](150) NOT NULL, 
         [DBName]     [NVARCHAR](150) NOT NULL, 
         [isAzure]    [BIT] NULL, 
         [UserID]     [NVARCHAR](60) NULL, 
         [pwd]        [NVARCHAR](60) NULL, 
         [UID]        [UNIQUEIDENTIFIER] NOT NULL
        )
        ON [PRIMARY];
        ALTER TABLE [dbo].[DFS_$ActiveDatabases]
        ADD DEFAULT('NA') FOR [GroupName];
        ALTER TABLE [dbo].[DFS_$ActiveDatabases]
        ADD DEFAULT((0)) FOR [isAzure];
        ALTER TABLE [dbo].[DFS_$ActiveDatabases]
        ADD DEFAULT(NEWID()) FOR [UID];
END;
GO
IF NOT EXISTS
(
    SELECT 1
    FROM sys.tables
    WHERE name = 'DFIN_TRACKED_DATABASES'
)
    BEGIN
        CREATE TABLE [dbo].[DFIN_TRACKED_DATABASES]
        ([INSTANCE]           [VARCHAR](50) NOT NULL, 
         [DATABASENAME]       [VARCHAR](100) NOT NULL, 
         [REGION]             [VARCHAR](4) NOT NULL, 
         [AuthenticationType] [CHAR](1) NOT NULL, 
         [UtilityUserID]      [NVARCHAR](50) NULL, 
         [UtilityUserPW]      [NVARCHAR](50) NULL, 
         [UID]                [UNIQUEIDENTIFIER] NOT NULL
        )
        ON [PRIMARY];
END;
GO
IF NOT EXISTS
(
    SELECT 1
    FROM sys.tables
    WHERE name = 'DFIN_TRACKED_DATABASE_PROCS'
)
    BEGIN
        CREATE TABLE [dbo].[DFIN_TRACKED_DATABASE_PROCS]
        ([PROCNAME] [VARCHAR](100) NOT NULL, 
         [UID]      [UNIQUEIDENTIFIER] NOT NULL
        )
        ON [PRIMARY];
        ALTER TABLE [dbo].[DFIN_TRACKED_DATABASE_PROCS]
        ADD DEFAULT(NEWID()) FOR [UID];
END; 
GO

/*
select 
'if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where table_name = '''+table_name+''' and column_name = ''UID'')
	alter table '+table_name+' add [UID] uniqueidentifier null default newid() ; ' + char(10) + 'GO'
from information_schema.columns
where column_name = 'UID'
union
select distinct 'if not exists (select 1 from sys.indexes where [name] = ''pi_'+ C.table_name +  '_UID'')' +
	char(10) + '    create index pi_' + C.table_name + '_UID on '  + C.table_name + ' ([UID]);' + char(10) + 'GO'
	  from INFORMATION_SCHEMA.columns C 
	  join INFORMATION_SCHEMA.tables T on T.TABLE_NAME = C.TABLE_NAME and T.TABLE_TYPE = 'BASE TABLE'
	  where column_name = 'UID'
*/
/********************************************************************************************/

IF NOT EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE table_name = 'ActiveJob'
          AND column_name = 'UID'
)
    ALTER TABLE ActiveJob
    ADD [UID] UNIQUEIDENTIFIER NULL
                               DEFAULT NEWID(); 
GO
IF NOT EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE table_name = 'ActiveServers'
          AND column_name = 'UID'
)
    ALTER TABLE ActiveServers
    ADD [UID] UNIQUEIDENTIFIER NULL
                               DEFAULT NEWID(); 
GO
IF NOT EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE table_name = 'DFIN_TRACKED_DATABASE_PROCS'
          AND column_name = 'UID'
)
    ALTER TABLE DFIN_TRACKED_DATABASE_PROCS
    ADD [UID] UNIQUEIDENTIFIER NULL
                               DEFAULT NEWID(); 
GO
IF NOT EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE table_name = 'DFIN_TRACKED_DATABASES'
          AND column_name = 'UID'
)
    ALTER TABLE DFIN_TRACKED_DATABASES
    ADD [UID] UNIQUEIDENTIFIER NULL
                               DEFAULT NEWID(); 
GO
IF NOT EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE table_name = 'DFS_$ActiveDatabases'
          AND column_name = 'UID'
)
    ALTER TABLE DFS_$ActiveDatabases
    ADD [UID] UNIQUEIDENTIFIER NULL
                               DEFAULT NEWID(); 
GO
IF NOT EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE table_name = 'DFS_BlockingHistory'
          AND column_name = 'UID'
)
    ALTER TABLE DFS_BlockingHistory
    ADD [UID] UNIQUEIDENTIFIER NULL
                               DEFAULT NEWID(); 
GO
IF NOT EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE table_name = 'DFS_CleanedDFSTables'
          AND column_name = 'UID'
)
    ALTER TABLE DFS_CleanedDFSTables
    ADD [UID] UNIQUEIDENTIFIER NULL
                               DEFAULT NEWID(); 
GO
IF NOT EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE table_name = 'DFS_CPU_BoundQry'
          AND column_name = 'UID'
)
    ALTER TABLE DFS_CPU_BoundQry
    ADD [UID] UNIQUEIDENTIFIER NULL
                               DEFAULT NEWID(); 
GO
IF NOT EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE table_name = 'DFS_CPU_BoundQry2000'
          AND column_name = 'UID'
)
    ALTER TABLE DFS_CPU_BoundQry2000
    ADD [UID] UNIQUEIDENTIFIER NULL
                               DEFAULT NEWID(); 
GO
IF NOT EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE table_name = 'DFS_DbFileSizing'
          AND column_name = 'UID'
)
    ALTER TABLE DFS_DbFileSizing
    ADD [UID] UNIQUEIDENTIFIER NULL
                               DEFAULT NEWID(); 
GO
IF NOT EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE table_name = 'DFS_DBSpace'
          AND column_name = 'UID'
)
    ALTER TABLE DFS_DBSpace
    ADD [UID] UNIQUEIDENTIFIER NULL
                               DEFAULT NEWID(); 
GO
IF NOT EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE table_name = 'DFS_DBTableSpace'
          AND column_name = 'UID'
)
    ALTER TABLE DFS_DBTableSpace
    ADD [UID] UNIQUEIDENTIFIER NULL
                               DEFAULT NEWID(); 
GO
IF NOT EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE table_name = 'DFS_DBVersion'
          AND column_name = 'UID'
)
    ALTER TABLE DFS_DBVersion
    ADD [UID] UNIQUEIDENTIFIER NULL
                               DEFAULT NEWID(); 
GO
IF NOT EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE table_name = 'DFS_DeadlockStats'
          AND column_name = 'UID'
)
    ALTER TABLE DFS_DeadlockStats
    ADD [UID] UNIQUEIDENTIFIER NULL
                               DEFAULT NEWID(); 
GO
IF NOT EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE table_name = 'DFS_IndexFragErrors'
          AND column_name = 'UID'
)
    ALTER TABLE DFS_IndexFragErrors
    ADD [UID] UNIQUEIDENTIFIER NULL
                               DEFAULT NEWID(); 
GO
IF NOT EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE table_name = 'DFS_IndexFragHist'
          AND column_name = 'UID'
)
    ALTER TABLE DFS_IndexFragHist
    ADD [UID] UNIQUEIDENTIFIER NULL
                               DEFAULT NEWID(); 
GO
IF NOT EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE table_name = 'DFS_IndexFragProgress'
          AND column_name = 'UID'
)
    ALTER TABLE DFS_IndexFragProgress
    ADD [UID] UNIQUEIDENTIFIER NULL
                               DEFAULT NEWID(); 
GO
IF NOT EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE table_name = 'DFS_IndexFragReorgHistory'
          AND column_name = 'UID'
)
    ALTER TABLE DFS_IndexFragReorgHistory
    ADD [UID] UNIQUEIDENTIFIER NULL
                               DEFAULT NEWID(); 
GO
IF NOT EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE table_name = 'DFS_IndexReorgCmds'
          AND column_name = 'UID'
)
    ALTER TABLE DFS_IndexReorgCmds
    ADD [UID] UNIQUEIDENTIFIER NULL
                               DEFAULT NEWID(); 
GO
IF NOT EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE table_name = 'DFS_IndexStats'
          AND column_name = 'UID'
)
    ALTER TABLE DFS_IndexStats
    ADD [UID] UNIQUEIDENTIFIER NULL
                               DEFAULT NEWID(); 
GO
IF NOT EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE table_name = 'DFS_IO_BoundQry'
          AND column_name = 'UID'
)
    ALTER TABLE DFS_IO_BoundQry
    ADD [UID] UNIQUEIDENTIFIER NULL
                               DEFAULT NEWID(); 
GO
IF NOT EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE table_name = 'DFS_IO_BoundQry2000'
          AND column_name = 'UID'
)
    ALTER TABLE DFS_IO_BoundQry2000
    ADD [UID] UNIQUEIDENTIFIER NULL
                               DEFAULT NEWID(); 
GO
IF NOT EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE table_name = 'DFS_MissingFKIndexes'
          AND column_name = 'UID'
)
    ALTER TABLE DFS_MissingFKIndexes
    ADD [UID] UNIQUEIDENTIFIER NULL
                               DEFAULT NEWID(); 
GO
IF NOT EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE table_name = 'DFS_MissingIndexes'
          AND column_name = 'UID'
)
    ALTER TABLE DFS_MissingIndexes
    ADD [UID] UNIQUEIDENTIFIER NULL
                               DEFAULT NEWID(); 
GO
IF NOT EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE table_name = 'DFS_MonitorMostCommonWaits'
          AND column_name = 'UID'
)
    ALTER TABLE DFS_MonitorMostCommonWaits
    ADD [UID] UNIQUEIDENTIFIER NULL
                               DEFAULT NEWID(); 
GO
IF NOT EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE table_name = 'DFS_ParallelMonitor'
          AND column_name = 'UID'
)
    ALTER TABLE DFS_ParallelMonitor
    ADD [UID] UNIQUEIDENTIFIER NULL
                               DEFAULT NEWID(); 
GO
IF NOT EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE table_name = 'DFS_PerfMonitor'
          AND column_name = 'UID'
)
    ALTER TABLE DFS_PerfMonitor
    ADD [UID] UNIQUEIDENTIFIER NULL
                               DEFAULT NEWID(); 
GO
IF NOT EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE table_name = 'DFS_PowershellJobSchedule'
          AND column_name = 'UID'
)
    ALTER TABLE DFS_PowershellJobSchedule
    ADD [UID] UNIQUEIDENTIFIER NULL
                               DEFAULT NEWID(); 
GO
IF NOT EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE table_name = 'DFS_QryOptStats'
          AND column_name = 'UID'
)
    ALTER TABLE DFS_QryOptStats
    ADD [UID] UNIQUEIDENTIFIER NULL
                               DEFAULT NEWID(); 
GO
IF NOT EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE table_name = 'DFS_QrysPlans'
          AND column_name = 'UID'
)
    ALTER TABLE DFS_QrysPlans
    ADD [UID] UNIQUEIDENTIFIER NULL
                               DEFAULT NEWID(); 
GO
IF NOT EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE table_name = 'DFS_RecordCount'
          AND column_name = 'UID'
)
    ALTER TABLE DFS_RecordCount
    ADD [UID] UNIQUEIDENTIFIER NULL
                               DEFAULT NEWID(); 
GO
IF NOT EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE table_name = 'DFS_SEQ'
          AND column_name = 'UID'
)
    ALTER TABLE DFS_SEQ
    ADD [UID] UNIQUEIDENTIFIER NULL
                               DEFAULT NEWID(); 
GO
IF NOT EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE table_name = 'DFS_TableGrowthHistory'
          AND column_name = 'UID'
)
    ALTER TABLE DFS_TableGrowthHistory
    ADD [UID] UNIQUEIDENTIFIER NULL
                               DEFAULT NEWID(); 
GO
IF NOT EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE table_name = 'DFS_TableReadWrites'
          AND column_name = 'UID'
)
    ALTER TABLE DFS_TableReadWrites
    ADD [UID] UNIQUEIDENTIFIER NULL
                               DEFAULT NEWID(); 
GO
IF NOT EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE table_name = 'DFS_TableSizeAndRowCnt'
          AND column_name = 'UID'
)
    ALTER TABLE DFS_TableSizeAndRowCnt
    ADD [UID] UNIQUEIDENTIFIER NULL
                               DEFAULT NEWID(); 
GO
IF NOT EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE table_name = 'DFS_TableStats'
          AND column_name = 'UID'
)
    ALTER TABLE DFS_TableStats
    ADD [UID] UNIQUEIDENTIFIER NULL
                               DEFAULT NEWID(); 
GO
IF NOT EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE table_name = 'DFS_TempDbMonitor'
          AND column_name = 'UID'
)
    ALTER TABLE DFS_TempDbMonitor
    ADD [UID] UNIQUEIDENTIFIER NULL
                               DEFAULT NEWID(); 
GO
IF NOT EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE table_name = 'DFS_TempProcErrors'
          AND column_name = 'UID'
)
    ALTER TABLE DFS_TempProcErrors
    ADD [UID] UNIQUEIDENTIFIER NULL
                               DEFAULT NEWID(); 
GO
IF NOT EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE table_name = 'DFS_TranLocks'
          AND column_name = 'UID'
)
    ALTER TABLE DFS_TranLocks
    ADD [UID] UNIQUEIDENTIFIER NULL
                               DEFAULT NEWID(); 
GO
IF NOT EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE table_name = 'DFS_TxMonitorIDX'
          AND column_name = 'UID'
)
    ALTER TABLE DFS_TxMonitorIDX
    ADD [UID] UNIQUEIDENTIFIER NULL
                               DEFAULT NEWID(); 
GO
IF NOT EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE table_name = 'DFS_TxMonitorTableIndexStats'
          AND column_name = 'UID'
)
    ALTER TABLE DFS_TxMonitorTableIndexStats
    ADD [UID] UNIQUEIDENTIFIER NULL
                               DEFAULT NEWID(); 
GO
IF NOT EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE table_name = 'DFS_TxMonitorTableStats'
          AND column_name = 'UID'
)
    ALTER TABLE DFS_TxMonitorTableStats
    ADD [UID] UNIQUEIDENTIFIER NULL
                               DEFAULT NEWID(); 
GO
IF NOT EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE table_name = 'DFS_TxMonitorTblUpdates'
          AND column_name = 'UID'
)
    ALTER TABLE DFS_TxMonitorTblUpdates
    ADD [UID] UNIQUEIDENTIFIER NULL
                               DEFAULT NEWID(); 
GO
IF NOT EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE table_name = 'DFS_WaitStats'
          AND column_name = 'UID'
)
    ALTER TABLE DFS_WaitStats
    ADD [UID] UNIQUEIDENTIFIER NULL
                               DEFAULT NEWID(); 
GO
IF NOT EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE table_name = 'DFS_Workload'
          AND column_name = 'UID'
)
    ALTER TABLE DFS_Workload
    ADD [UID] UNIQUEIDENTIFIER NULL
                               DEFAULT NEWID(); 
GO
IF NOT EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE table_name = 'vTrackTblReadsWrites'
          AND column_name = 'UID'
)
    ALTER TABLE vTrackTblReadsWrites
    ADD [UID] UNIQUEIDENTIFIER NULL
                               DEFAULT NEWID(); 
GO
IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE [name] = 'pi_ActiveJob_UID'
)
    CREATE INDEX pi_ActiveJob_UID
    ON ActiveJob
    ([UID]
    );
GO
IF EXISTS (select 1 from sys.indexes where name = 'pi_ActiveServers_UID')
	drop index pi_ActiveServers_UID on [ActiveServers];
GO
IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE [name] = 'pi_ActiveServers_UID'
)
    CREATE unique NONCLUSTERED INDEX [pi_ActiveServers_UID] ON [dbo].[ActiveServers]
(
	GroupName, SvrName, DBName ASC
);

GO
IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE [name] = 'pi_DFIN_TRACKED_DATABASE_PROCS_UID'
)
    CREATE INDEX pi_DFIN_TRACKED_DATABASE_PROCS_UID
    ON DFIN_TRACKED_DATABASE_PROCS
    ([UID]
    );
GO
IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE [name] = 'pi_DFIN_TRACKED_DATABASES_UID'
)
    CREATE INDEX pi_DFIN_TRACKED_DATABASES_UID
    ON DFIN_TRACKED_DATABASES
    ([UID]
    );
GO
IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE [name] = 'pi_DFS_$ActiveDatabases_UID'
)
    CREATE INDEX pi_DFS_$ActiveDatabases_UID
    ON DFS_$ActiveDatabases
    ([UID]
    );
GO
IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE [name] = 'pi_DFS_BlockingHistory_UID'
)
    CREATE INDEX pi_DFS_BlockingHistory_UID
    ON DFS_BlockingHistory
    ([UID]
    );
GO
IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE [name] = 'pi_DFS_CleanedDFSTables_UID'
)
    CREATE INDEX pi_DFS_CleanedDFSTables_UID
    ON DFS_CleanedDFSTables
    ([UID]
    );
GO
IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE [name] = 'pi_DFS_CPU_BoundQry_UID'
)
    CREATE INDEX pi_DFS_CPU_BoundQry_UID
    ON DFS_CPU_BoundQry
    ([UID]
    );
GO
IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE [name] = 'pi_DFS_CPU_BoundQry2000_UID'
)
    CREATE INDEX pi_DFS_CPU_BoundQry2000_UID
    ON DFS_CPU_BoundQry2000
    ([UID]
    );
GO
IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE [name] = 'pi_DFS_DbFileSizing_UID'
)
    CREATE INDEX pi_DFS_DbFileSizing_UID
    ON DFS_DbFileSizing
    ([UID]
    );
GO
IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE [name] = 'pi_DFS_DBSpace_UID'
)
    CREATE INDEX pi_DFS_DBSpace_UID
    ON DFS_DBSpace
    ([UID]
    );
GO
IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE [name] = 'pi_DFS_DBTableSpace_UID'
)
    CREATE INDEX pi_DFS_DBTableSpace_UID
    ON DFS_DBTableSpace
    ([UID]
    );
GO
IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE [name] = 'pi_DFS_DBVersion_UID'
)
    CREATE INDEX pi_DFS_DBVersion_UID
    ON DFS_DBVersion
    ([UID]
    );
GO
IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE [name] = 'pi_DFS_DeadlockStats_UID'
)
    CREATE INDEX pi_DFS_DeadlockStats_UID
    ON DFS_DeadlockStats
    ([UID]
    );
GO
IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE [name] = 'pi_DFS_IndexFragErrors_UID'
)
    CREATE INDEX pi_DFS_IndexFragErrors_UID
    ON DFS_IndexFragErrors
    ([UID]
    );
GO
IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE [name] = 'pi_DFS_IndexFragHist_UID'
)
    CREATE INDEX pi_DFS_IndexFragHist_UID
    ON DFS_IndexFragHist
    ([UID]
    );
GO
IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE [name] = 'pi_DFS_IndexFragProgress_UID'
)
    CREATE INDEX pi_DFS_IndexFragProgress_UID
    ON DFS_IndexFragProgress
    ([UID]
    );
GO
IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE [name] = 'pi_DFS_IndexFragReorgHistory_UID'
)
    CREATE INDEX pi_DFS_IndexFragReorgHistory_UID
    ON DFS_IndexFragReorgHistory
    ([UID]
    );
GO
IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE [name] = 'pi_DFS_IndexReorgCmds_UID'
)
    CREATE INDEX pi_DFS_IndexReorgCmds_UID
    ON DFS_IndexReorgCmds
    ([UID]
    );
GO
IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE [name] = 'pi_DFS_IndexStats_UID'
)
    CREATE INDEX pi_DFS_IndexStats_UID
    ON DFS_IndexStats
    ([UID]
    );
GO
IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE [name] = 'pi_DFS_IO_BoundQry_UID'
)
    CREATE INDEX pi_DFS_IO_BoundQry_UID
    ON DFS_IO_BoundQry
    ([UID]
    );
GO
IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE [name] = 'pi_DFS_IO_BoundQry2000_UID'
)
    CREATE INDEX pi_DFS_IO_BoundQry2000_UID
    ON DFS_IO_BoundQry2000
    ([UID]
    );
GO
IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE [name] = 'pi_DFS_MissingFKIndexes_UID'
)
    CREATE INDEX pi_DFS_MissingFKIndexes_UID
    ON DFS_MissingFKIndexes
    ([UID]
    );
GO
IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE [name] = 'pi_DFS_MissingIndexes_UID'
)
    CREATE INDEX pi_DFS_MissingIndexes_UID
    ON DFS_MissingIndexes
    ([UID]
    );
GO
IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE [name] = 'pi_DFS_MonitorMostCommonWaits_UID'
)
    CREATE INDEX pi_DFS_MonitorMostCommonWaits_UID
    ON DFS_MonitorMostCommonWaits
    ([UID]
    );
GO
IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE [name] = 'pi_DFS_ParallelMonitor_UID'
)
    CREATE INDEX pi_DFS_ParallelMonitor_UID
    ON DFS_ParallelMonitor
    ([UID]
    );
GO
IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE [name] = 'pi_DFS_PerfMonitor_UID'
)
    CREATE INDEX pi_DFS_PerfMonitor_UID
    ON DFS_PerfMonitor
    ([UID]
    );
GO
IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE [name] = 'pi_DFS_PowershellJobSchedule_UID'
)
    CREATE INDEX pi_DFS_PowershellJobSchedule_UID
    ON DFS_PowershellJobSchedule
    ([UID]
    );
GO
IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE [name] = 'pi_DFS_QryOptStats_UID'
)
    CREATE INDEX pi_DFS_QryOptStats_UID
    ON DFS_QryOptStats
    ([UID]
    );
GO
IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE [name] = 'pi_DFS_QrysPlans_UID'
)
    CREATE INDEX pi_DFS_QrysPlans_UID
    ON DFS_QrysPlans
    ([UID]
    );
GO
IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE [name] = 'pi_DFS_RecordCount_UID'
)
    CREATE INDEX pi_DFS_RecordCount_UID
    ON DFS_RecordCount
    ([UID]
    );
GO
IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE [name] = 'pi_DFS_SEQ_UID'
)
    CREATE INDEX pi_DFS_SEQ_UID
    ON DFS_SEQ
    ([UID]
    );
GO
IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE [name] = 'pi_DFS_TableGrowthHistory_UID'
)
    CREATE INDEX pi_DFS_TableGrowthHistory_UID
    ON DFS_TableGrowthHistory
    ([UID]
    );
GO
IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE [name] = 'pi_DFS_TableReadWrites_UID'
)
    CREATE INDEX pi_DFS_TableReadWrites_UID
    ON DFS_TableReadWrites
    ([UID]
    );
GO
IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE [name] = 'pi_DFS_TableSizeAndRowCnt_UID'
)
    CREATE INDEX pi_DFS_TableSizeAndRowCnt_UID
    ON DFS_TableSizeAndRowCnt
    ([UID]
    );
GO
IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE [name] = 'pi_DFS_TableStats_UID'
)
    CREATE INDEX pi_DFS_TableStats_UID
    ON DFS_TableStats
    ([UID]
    );
GO
IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE [name] = 'pi_DFS_TempDbMonitor_UID'
)
    CREATE INDEX pi_DFS_TempDbMonitor_UID
    ON DFS_TempDbMonitor
    ([UID]
    );
GO
IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE [name] = 'pi_DFS_TempProcErrors_UID'
)
    CREATE INDEX pi_DFS_TempProcErrors_UID
    ON DFS_TempProcErrors
    ([UID]
    );
GO
IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE [name] = 'pi_DFS_TranLocks_UID'
)
    CREATE INDEX pi_DFS_TranLocks_UID
    ON DFS_TranLocks
    ([UID]
    );
GO
IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE [name] = 'pi_DFS_TxMonitorIDX_UID'
)
    CREATE INDEX pi_DFS_TxMonitorIDX_UID
    ON DFS_TxMonitorIDX
    ([UID]
    );
GO
IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE [name] = 'pi_DFS_TxMonitorTableIndexStats_UID'
)
    CREATE INDEX pi_DFS_TxMonitorTableIndexStats_UID
    ON DFS_TxMonitorTableIndexStats
    ([UID]
    );
GO
IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE [name] = 'pi_DFS_TxMonitorTableStats_UID'
)
    CREATE INDEX pi_DFS_TxMonitorTableStats_UID
    ON DFS_TxMonitorTableStats
    ([UID]
    );
GO
IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE [name] = 'pi_DFS_TxMonitorTblUpdates_UID'
)
    CREATE INDEX pi_DFS_TxMonitorTblUpdates_UID
    ON DFS_TxMonitorTblUpdates
    ([UID]
    );
GO
IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE [name] = 'pi_DFS_WaitStats_UID'
)
    CREATE INDEX pi_DFS_WaitStats_UID
    ON DFS_WaitStats
    ([UID]
    );
GO
IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE [name] = 'pi_DFS_Workload_UID'
)
    CREATE INDEX pi_DFS_Workload_UID
    ON DFS_Workload
    ([UID]
    );
GO

/****************** PROCESSING FILE *************************************/

GO  
PRINT 'ID# 301'  
print 'D:\dev\SQL\DFINAnalytics\ParallelExecutionStatsOnSPID.sql' 
GO

/*exec sp_who2
declare @spid as int = 52;*/

IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'sp_InspectParallelCpuUsage'
)
    DROP PROCEDURE sp_InspectParallelCpuUsage;
GO
CREATE PROCEDURE sp_InspectParallelCpuUsage(@spid AS INT)
AS
    BEGIN

/*
ANSWERS: How many CPUs is my query using
The scheduler_id column is key. Each scheduler is mapped to one of my virtual CPU cores.
*/
        SELECT ost.session_id, 
               ost.scheduler_id, 
               w.worker_address, 
               ost.task_state, 
               wt.wait_type, 
               wt.wait_duration_ms
        FROM sys.dm_os_tasks ost
                  LEFT JOIN sys.dm_os_workers w
                  ON ost.worker_address = w.worker_address
                       LEFT JOIN sys.dm_os_waiting_tasks wt
                  ON w.task_address = wt.waiting_task_address
        WHERE ost.session_id = @spid
        ORDER BY scheduler_id;

        /******************************************************************************/
/*
If I run my query with ‘actual execution plans’ enabled, I can spy on my 
query using the sys.dm_exec_query_profiles DMV like this:
*/
        SELECT ost.session_id, 
               ost.scheduler_id, 
               w.worker_address, 
               qp.node_id, 
               qp.physical_operator_name, 
               ost.task_state, 
               wt.wait_type, 
               wt.wait_duration_ms, 
               qp.cpu_time_ms
        FROM sys.dm_os_tasks ost
                  LEFT JOIN sys.dm_os_workers w
                  ON ost.worker_address = w.worker_address
                       LEFT JOIN sys.dm_os_waiting_tasks wt
                  ON w.task_address = wt.waiting_task_address
                     AND wt.session_id = ost.session_id
                            LEFT JOIN sys.dm_exec_query_profiles qp
                  ON w.task_address = qp.task_address
        WHERE ost.session_id = @spid
        ORDER BY scheduler_id, 
                 worker_address, 
                 node_id;
    END;
GO
IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'sp_CountParallelCpuUsage'
)
    DROP PROCEDURE sp_CountParallelCpuUsage;
GO
/*
exec sp_CountParallelCpuUsage
*/
CREATE PROCEDURE sp_CountParallelCpuUsage
AS
    BEGIN
		/*
		ANSWERS: How many CPUs each SPID is using
		Using the output here, it is easy to spot potential parallel execution issues before or after they happen.
		*/
        SELECT DISTINCT 
               ost.session_id, 
               COUNT(ost.scheduler_id) AS CPUs_USED
        FROM sys.dm_os_tasks ost
                  LEFT JOIN sys.dm_os_workers w
                  ON ost.worker_address = w.worker_address
                       LEFT JOIN sys.dm_os_waiting_tasks wt
                  ON w.task_address = wt.waiting_task_address
        GROUP BY ost.session_id
        ORDER BY 2 DESC, 
                 session_id;
    END;

/****************** PROCESSING FILE *************************************/

GO  
PRINT 'ID# 302'  
print 'D:\dev\SQL\DFINAnalytics\createActiveServerJobsInsertProcs.sql' 

go
/*
D:\dev\SQL\DFINAnalytics\createActiveServerJobsInsertProcs.sql

ALSO REFER TO:
D:\dev\SQL\DFINAnalytics\_PopulateInitialActiveServersAndJobs.sql

*/
IF not EXISTS
(
	SELECT column_name 
	FROM INFORMATION_SCHEMA.columns 
	WHERE table_name = 'ActiveJobStep'
	and column_name = 'JobName'
)
BEGIN
	alter table ActiveJobStep add JobName nvarchar (150) null;
END;

go

if not exists (select 1 from sys.indexes where name = 'pkActiveJobStep')
	CREATE UNIQUE NONCLUSTERED INDEX [pkActiveJobStep] ON [dbo].[ActiveJobStep]
	(
		[JOBUID] ASC,
		[StepName] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

go
IF EXISTS
(
	SELECT name
	FROM sys.procedures
	WHERE name = 'UTIL_ActiveJobStep'
)
BEGIN
	DROP PROCEDURE UTIL_ActiveJobStep;
END;
GO

CREATE PROCEDURE UTIL_ActiveJobStep
( 
				 @JobName nvarchar(150),@StepName nvarchar(150),  @StepSQL nvarchar(max), @disabled char(1), @RunIdReq char(1), @AzureOK char(1)
)
AS
BEGIN
	DECLARE @icnt AS int= 0;
	SET @icnt =
	(
		SELECT COUNT(*)
		FROM [dbo].ActiveJobStep
			WHERE JobName = @JobName and StepName = @StepName
	);
	declare @JOBUID as uniqueidentifier = null ;
	IF(@icnt = 0)
	BEGIN
		set @JOBUID = (select [UID] from ActiveJob where JobName = @JobName) ;
		INSERT INTO [dbo].ActiveJobStep( JobName , StepName,  StepSQL, [disabled] , RunIdReq , AzureOK, JOBUID )
		VALUES( @JobName ,@StepName ,  @StepSQL , @disabled , @RunIdReq , @AzureOK ,@JOBUID);
	END
	ELSE
	BEGIN
		set @JOBUID = (select [UID] from ActiveJob where JobName = @JobName) ;
		UPDATE [dbo].ActiveJobStep
		  SET StepSQL = @StepSQL , 
			[disabled] = @disabled, 
			RunIdReq = @RunIdReq ,
			AzureOK = @AzureOK ,
			JOBUID = @JOBUID
		WHERE JobName = @JobName and StepName = @StepName
	END;
END;


GO

IF EXISTS
(
	SELECT name
	FROM sys.procedures
	WHERE name = 'UTIL_InsertActiveJobSchedule'
)
BEGIN
	DROP PROCEDURE UTIL_InsertActiveJobSchedule;
END;
GO

CREATE PROCEDURE UTIL_InsertActiveJobSchedule
( 
				 @SvrName nvarchar(150), @JobName nvarchar(150), @Disabled char(1)
)
AS
BEGIN
	DECLARE @icnt AS int= 0;
	SET @icnt =
	(
		SELECT COUNT(*)
		FROM [dbo].ActiveJobSchedule
		WHERE SvrName = @SvrName AND 
			  JobName = @JobName
	);

	begin try
	IF(@icnt = 0)
	BEGIN
		INSERT INTO [dbo].ActiveJobSchedule( SvrName, [JobName], [Disabled],  [LastRunDate], [NextRunDate])
		VALUES( @SvrName, @JobName, @disabled, getdate(), getdate());
	END
	ELSE
	BEGIN
		UPDATE [dbo].ActiveJobSchedule
		  SET [disabled] = @disabled
		WHERE SvrName = @SvrName AND 
			  JobName = @JobName
	END;
	end try
	begin catch 
		print 'ERROR: check data: "' + @SvrName + '" "' + @JobName + '" "' +@Disabled + '"' ;
	end catch 
END;


GO

IF EXISTS
(
	SELECT name
	FROM sys.procedures
	WHERE name = 'UTIL_InsertActiveJob'
)
BEGIN
	DROP PROCEDURE UTIL_InsertActiveJob;
END;
GO

CREATE PROCEDURE UTIL_InsertActiveJob
( 
				 @JobName nvarchar(150), @disabled nvarchar(150), @ScheduleUnit nvarchar(150), @ScheduleVal nvarchar(150), @Enable nvarchar(150)
)
AS
BEGIN
	DECLARE @icnt AS int= 0;
	SET @icnt =
	(
		SELECT COUNT(*)
		FROM [dbo].[ActiveJob]
		WHERE JobName = @JobName
	);

	IF(@icnt = 0)
	BEGIN
		INSERT INTO [dbo].[ActiveJob]( [JobName], [disabled], [ScheduleUnit], [ScheduleVal], [LastRunDate], [NextRunDate], [Enable] )
		VALUES( @JobName, @disabled, @ScheduleUnit, @ScheduleVal, GETDATE(), GETDATE(), @Enable );
	END
	ELSE
	BEGIN
		UPDATE [dbo].[ActiveJob]
		  SET [disabled] = @disabled, [ScheduleUnit] = @ScheduleUnit, [ScheduleVal] = @ScheduleVal, [Enable] = @Enable
		WHERE JobName = @JobName;
	END;
END;



GO

IF EXISTS
(
	SELECT name
	FROM sys.procedures
	WHERE name = 'UTIL_InsertActiveServers'
)
BEGIN
	DROP PROCEDURE UTIL_InsertActiveServers;
END;
GO

/*
exec UTIL_InsertActiveServers 'dfintest', 'N', 'ALIEN15', 'DINAnalytics', 'sa', 'Junebug1', 1 ;
*/

CREATE PROCEDURE UTIL_InsertActiveServers
( 
				 @GroupName nvarchar(50), @isAzure char(1), @SvrName nvarchar(150), @DBName nvarchar(150), @UserID nvarchar(50), @pwd nvarchar(50), @Enable bit
)
AS
BEGIN

	DECLARE @icnt AS int= 0;

	SET @icnt =
	(
		SELECT COUNT(*)
		FROM [dbo].[ActiveServers]
		WHERE GroupName = @GroupName AND 
			  SvrName = @SvrName AND 
			  DBName = @DBName
	);
	IF(@icnt = 1)
	BEGIN
		INSERT INTO [dbo].[ActiveServers]( [GroupName], [isAzure], [SvrName], [DBName], [UserID], [pwd], [Enable] )
		VALUES( @GroupName, @isAzure, @SvrName, @DBName, @UserID, @pwd, @Enable );
	END
	ELSE
	BEGIN
		UPDATE [dbo].[ActiveServers]
		  SET isAzure = @isAzure, UserID = @UserID, pwd = @pwd, Enable = @Enable
		WHERE GroupName = @GroupName AND 
			  SvrName = @SvrName AND 
			  DBName = @DBName;
	END;

END;
GO

/****************** PROCESSING FILE *************************************/

GO  
PRINT 'ID# 303'  
print 'D:\dev\SQL\DFINAnalytics\_FillActiveServerTablesData.sql' 

go

/*
select count(*) from [dbo].[ActiveServers]
select count(*) from [dbo].[ActiveJobStep]
select count(*) from [dbo].[ActiveJobSchedule]
select count(*) from [dbo].[ActiveJobExecutions]
select count(*) from [dbo].[ActiveJob]
*/

GO

declare @RefillTables int = 1 ;
declare @MasterServer nvarchar(150) = 'ALIEN15';
if (@RefillTables = 1 and db_name() = 'DFINAnalytics' and @@SERVERNAME = @MasterServer)
begin

DELETE FROM [dbo].[ActiveServers]
DELETE FROM [dbo].[ActiveJobStep]
DELETE FROM [dbo].[ActiveJobSchedule]
DELETE FROM [dbo].[ActiveJobExecutions]
DELETE FROM [dbo].[ActiveJob]

 
SET IDENTITY_INSERT [dbo].[ActiveJob] ON 
 
INSERT [dbo].[ActiveJob] ([JobName], [disabled], [UID], [ScheduleUnit], [ScheduleVal], [LastRunDate], [NextRunDate], [Enable], [RowNbr], [ExecutionOrder]) VALUES (N'JOB_CaptureWorstPerfQuery', N'N', N'0de20a26-3d64-4804-8d8a-243493368c09', N'min', 15, CAST(N'2019-03-15T09:13:34.060' AS DateTime), CAST(N'2019-03-15T09:28:34.147' AS DateTime), N'Y', 1, 31)
 
INSERT [dbo].[ActiveJob] ([JobName], [disabled], [UID], [ScheduleUnit], [ScheduleVal], [LastRunDate], [NextRunDate], [Enable], [RowNbr], [ExecutionOrder]) VALUES (N'JOB_DFS_BoundQry_ProcessAllTables', N'N', N'345ec8ea-56fd-4c1e-b451-aecfc73f61b4', N'min', 30, CAST(N'2019-03-15T09:11:26.117' AS DateTime), CAST(N'2019-03-15T09:41:26.150' AS DateTime), N'Y', 2, 25)
 
INSERT [dbo].[ActiveJob] ([JobName], [disabled], [UID], [ScheduleUnit], [ScheduleVal], [LastRunDate], [NextRunDate], [Enable], [RowNbr], [ExecutionOrder]) VALUES (N'JOB_DFS_CleanDFSTables', N'N', N'70712bc9-3bdb-41ce-b72f-04813917107a', N'hour', 12, CAST(N'2019-03-15T09:02:29.707' AS DateTime), CAST(N'2019-03-15T21:02:29.720' AS DateTime), N'Y', 3, 1)
 
INSERT [dbo].[ActiveJob] ([JobName], [disabled], [UID], [ScheduleUnit], [ScheduleVal], [LastRunDate], [NextRunDate], [Enable], [RowNbr], [ExecutionOrder]) VALUES (N'JOB_DFS_GetAllTableSizesAndRowCnt', N'N', N'6d81a810-eefb-477c-913a-66c22cf97d55', N'day', 1, CAST(N'2019-03-15T09:02:45.570' AS DateTime), CAST(N'2019-03-16T09:02:45.603' AS DateTime), N'Y', 4, 2)
 
INSERT [dbo].[ActiveJob] ([JobName], [disabled], [UID], [ScheduleUnit], [ScheduleVal], [LastRunDate], [NextRunDate], [Enable], [RowNbr], [ExecutionOrder]) VALUES (N'JOB_DFS_MonitorLocks', N'N', N'c924c740-ff80-489d-83ee-d6499432c55c', N'min', 5, CAST(N'2019-03-15T09:03:06.577' AS DateTime), CAST(N'2019-03-15T09:08:06.607' AS DateTime), N'Y', 5, 3)
 
INSERT [dbo].[ActiveJob] ([JobName], [disabled], [UID], [ScheduleUnit], [ScheduleVal], [LastRunDate], [NextRunDate], [Enable], [RowNbr], [ExecutionOrder]) VALUES (N'JOB_JOB_UTIL_MonitorDeadlocks', N'N', N'9fcee6e6-061d-4439-9037-189feab172c6', N'min', 5, CAST(N'2019-03-15T09:03:38.567' AS DateTime), CAST(N'2019-03-15T09:08:38.593' AS DateTime), N'Y', 6, 4)
 
INSERT [dbo].[ActiveJob] ([JobName], [disabled], [UID], [ScheduleUnit], [ScheduleVal], [LastRunDate], [NextRunDate], [Enable], [RowNbr], [ExecutionOrder]) VALUES (N'JOB_MonitorWorkload', N'N', N'a7b0ea61-e4bb-4139-8cf0-ab913ea2b92e', N'min', 10, CAST(N'2019-03-15T09:04:02.883' AS DateTime), CAST(N'2019-03-15T09:14:02.907' AS DateTime), N'Y', 7, 5)
 
INSERT [dbo].[ActiveJob] ([JobName], [disabled], [UID], [ScheduleUnit], [ScheduleVal], [LastRunDate], [NextRunDate], [Enable], [RowNbr], [ExecutionOrder]) VALUES (N'JOB_UTIL_DbMon_IndexVolitity', N'N', N'bd72610c-219d-4377-bad3-dfb28115c7b4', N'min', 10, CAST(N'2019-03-15T09:04:53.643' AS DateTime), CAST(N'2019-03-15T09:14:53.667' AS DateTime), N'Y', 8, 6)
 
INSERT [dbo].[ActiveJob] ([JobName], [disabled], [UID], [ScheduleUnit], [ScheduleVal], [LastRunDate], [NextRunDate], [Enable], [RowNbr], [ExecutionOrder]) VALUES (N'JOB_UTIL_DBSpace', N'N', N'c9446e5a-521f-4dcc-8ae1-138d9a951210', N'day', 7, CAST(N'2019-03-15T08:50:21.380' AS DateTime), CAST(N'2019-03-15T08:50:21.380' AS DateTime), N'Y', 9, 7)
 
INSERT [dbo].[ActiveJob] ([JobName], [disabled], [UID], [ScheduleUnit], [ScheduleVal], [LastRunDate], [NextRunDate], [Enable], [RowNbr], [ExecutionOrder]) VALUES (N'JOB_UTIL_DBTableSpace', N'N', N'0ca9e101-84f0-4d31-8aab-ae571c4ee3ae', N'day', 1, CAST(N'2019-03-15T09:04:47.900' AS DateTime), CAST(N'2019-03-16T09:04:48.080' AS DateTime), N'Y', 10, 8)
 
INSERT [dbo].[ActiveJob] ([JobName], [disabled], [UID], [ScheduleUnit], [ScheduleVal], [LastRunDate], [NextRunDate], [Enable], [RowNbr], [ExecutionOrder]) VALUES (N'JOB_UTIL_DFS_DbSize', N'N', N'128d40d9-1393-40fa-934e-22e7e961c62f', N'day', 1, CAST(N'2019-03-15T09:04:52.130' AS DateTime), CAST(N'2019-03-16T09:04:52.157' AS DateTime), N'Y', 11, 9)
 
INSERT [dbo].[ActiveJob] ([JobName], [disabled], [UID], [ScheduleUnit], [ScheduleVal], [LastRunDate], [NextRunDate], [Enable], [RowNbr], [ExecutionOrder]) VALUES (N'JOB_UTIL_GetIndexStats', N'N', N'def5324b-0cdf-444e-a570-985ed88087e0', N'day', 1, CAST(N'2019-03-15T09:05:12.073' AS DateTime), CAST(N'2019-03-16T09:05:12.130' AS DateTime), N'Y', 12, 10)
 
INSERT [dbo].[ActiveJob] ([JobName], [disabled], [UID], [ScheduleUnit], [ScheduleVal], [LastRunDate], [NextRunDate], [Enable], [RowNbr], [ExecutionOrder]) VALUES (N'JOB_UTIL_MonitorDeadlocks', N'N', N'1b1607ee-9fe0-40cb-9f0e-8ffbba0a1ecd', N'day', 1, CAST(N'2019-03-15T09:05:11.333' AS DateTime), CAST(N'2019-03-16T09:05:11.357' AS DateTime), N'Y', 13, 11)
 
INSERT [dbo].[ActiveJob] ([JobName], [disabled], [UID], [ScheduleUnit], [ScheduleVal], [LastRunDate], [NextRunDate], [Enable], [RowNbr], [ExecutionOrder]) VALUES (N'JOB_UTIL_MonitorMostCommonWaits', N'N', N'deeffc77-96f8-4ca1-9302-6106e626d6f2', N'min', 15, CAST(N'2019-03-15T09:05:37.870' AS DateTime), CAST(N'2019-03-15T09:20:37.913' AS DateTime), N'Y', 14, 12)
 
INSERT [dbo].[ActiveJob] ([JobName], [disabled], [UID], [ScheduleUnit], [ScheduleVal], [LastRunDate], [NextRunDate], [Enable], [RowNbr], [ExecutionOrder]) VALUES (N'JOB_UTIL_ParallelMonitor', N'N', N'82fcb676-fd64-4c04-9f31-8b40fc4310ae', N'min', 15, CAST(N'2019-03-15T09:07:37.870' AS DateTime), CAST(N'2019-03-15T09:22:37.907' AS DateTime), N'Y', 15, 20)
 
INSERT [dbo].[ActiveJob] ([JobName], [disabled], [UID], [ScheduleUnit], [ScheduleVal], [LastRunDate], [NextRunDate], [Enable], [RowNbr], [ExecutionOrder]) VALUES (N'JOB_UTIL_QryPlanStats', N'N', N'c1370e47-4e70-432e-aedd-37fa95cfb133', N'min', 30, CAST(N'2019-03-15T09:13:27.323' AS DateTime), CAST(N'2019-03-15T09:43:27.363' AS DateTime), N'Y', 16, 30)
 
INSERT [dbo].[ActiveJob] ([JobName], [disabled], [UID], [ScheduleUnit], [ScheduleVal], [LastRunDate], [NextRunDate], [Enable], [RowNbr], [ExecutionOrder]) VALUES (N'JOB_UTIL_ReorgFragmentedIndexes', N'N', N'be385257-47b2-4646-b28b-6240fbb0cf0c', N'day', 7, CAST(N'2019-03-15T08:50:21.383' AS DateTime), CAST(N'2019-03-15T08:50:21.383' AS DateTime), N'Y', 17, 13)
 
INSERT [dbo].[ActiveJob] ([JobName], [disabled], [UID], [ScheduleUnit], [ScheduleVal], [LastRunDate], [NextRunDate], [Enable], [RowNbr], [ExecutionOrder]) VALUES (N'JOB_UTIL_TempDbMonitor', N'N', N'ec6778b5-1ac6-40b9-9636-806f767bd35d', N'day', 7, CAST(N'2019-03-15T08:50:21.383' AS DateTime), CAST(N'2019-03-15T08:50:21.383' AS DateTime), N'Y', 18, 14)
 
INSERT [dbo].[ActiveJob] ([JobName], [disabled], [UID], [ScheduleUnit], [ScheduleVal], [LastRunDate], [NextRunDate], [Enable], [RowNbr], [ExecutionOrder]) VALUES (N'JOB_UTIL_TrackSessionWaitStats', N'N', N'64e66c5f-8315-45c6-ac57-509d2a3f3b1b', N'min', 10, CAST(N'2019-03-15T09:06:14.017' AS DateTime), CAST(N'2019-03-15T09:16:14.037' AS DateTime), N'Y', 19, 15)
 
INSERT [dbo].[ActiveJob] ([JobName], [disabled], [UID], [ScheduleUnit], [ScheduleVal], [LastRunDate], [NextRunDate], [Enable], [RowNbr], [ExecutionOrder]) VALUES (N'JOB_UTIL_TxMonitorTableStats', N'N', N'94bb81c0-eb2a-4a34-9158-cbee0f2c6db8', N'min', 10, CAST(N'2019-03-15T09:06:34.567' AS DateTime), CAST(N'2019-03-15T09:16:34.633' AS DateTime), N'Y', 20, 16)
 
INSERT [dbo].[ActiveJob] ([JobName], [disabled], [UID], [ScheduleUnit], [ScheduleVal], [LastRunDate], [NextRunDate], [Enable], [RowNbr], [ExecutionOrder]) VALUES (N'UTIL_TxMonitorIDX', N'N', N'abd48c8e-8298-4f06-85f4-65bc4378a8f8', N'min', 10, CAST(N'2019-03-15T09:06:58.333' AS DateTime), CAST(N'2019-03-15T09:16:58.357' AS DateTime), N'Y', 21, 17)
 
INSERT [dbo].[ActiveJob] ([JobName], [disabled], [UID], [ScheduleUnit], [ScheduleVal], [LastRunDate], [NextRunDate], [Enable], [RowNbr], [ExecutionOrder]) VALUES (N'JOB_UTIL_DBUsage', N'N', N'abd48c8e-8298-4f06-85f4-65bc4378a8f9', N'min', 10, CAST(N'2019-03-15T09:06:58.333' AS DateTime), CAST(N'2019-03-15T09:16:58.357' AS DateTime), N'Y', 22, 18)
 
SET IDENTITY_INSERT [dbo].[ActiveJob] OFF
 
INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'ALIEN15', N'JOB_CaptureWorstPerfQuery', N'N', CAST(N'2019-02-26T11:41:35.780' AS DateTime), CAST(N'2019-03-08T17:06:40.503' AS DateTime))
 
INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'ALIEN15', N'JOB_DFS_BoundQry_ProcessAllTables', N'N', CAST(N'2019-02-26T11:41:35.793' AS DateTime), CAST(N'2019-03-08T17:22:44.097' AS DateTime))
 
INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'ALIEN15', N'JOB_DFS_CleanDFSTables', N'N', CAST(N'2019-02-26T11:41:35.797' AS DateTime), CAST(N'2019-03-08T22:46:34.607' AS DateTime))
 
INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'ALIEN15', N'JOB_DFS_GetAllTableSizesAndRowCnt', N'N', CAST(N'2019-02-26T11:41:35.797' AS DateTime), CAST(N'2019-03-09T10:46:52.717' AS DateTime))
 
INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'ALIEN15', N'JOB_DFS_MonitorLocks', N'N', CAST(N'2019-02-26T11:41:35.797' AS DateTime), CAST(N'2019-03-08T16:58:00.960' AS DateTime))
 
INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'ALIEN15', N'JOB_JOB_UTIL_MonitorDeadlocks', N'N', CAST(N'2019-02-26T11:41:35.797' AS DateTime), CAST(N'2019-03-08T16:58:00.363' AS DateTime))
 
INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'ALIEN15', N'JOB_MonitorWorkload', N'N', CAST(N'2019-02-26T11:41:35.797' AS DateTime), CAST(N'2019-03-08T17:23:27.457' AS DateTime))
 
INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'ALIEN15', N'JOB_UTIL_DbMon_IndexVolitity', N'N', CAST(N'2019-02-26T11:41:35.797' AS DateTime), CAST(N'2019-03-08T17:03:23.693' AS DateTime))
 
INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'ALIEN15', N'JOB_UTIL_DBSpace', N'N', CAST(N'2019-02-26T11:41:35.797' AS DateTime), CAST(N'2019-03-15T10:49:55.250' AS DateTime))
 
INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'ALIEN15', N'JOB_UTIL_DBTableSpace', N'N', CAST(N'2019-02-26T11:41:35.797' AS DateTime), CAST(N'2019-03-09T10:50:19.367' AS DateTime))
 
INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'ALIEN15', N'JOB_UTIL_DFS_DbSize', N'N', CAST(N'2019-02-26T11:41:35.797' AS DateTime), CAST(N'2019-03-09T10:50:37.570' AS DateTime))
 
INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'ALIEN15', N'JOB_UTIL_GetIndexStats', N'N', CAST(N'2019-02-26T11:41:35.797' AS DateTime), CAST(N'2019-03-09T10:50:52.240' AS DateTime))
 
INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'ALIEN15', N'JOB_UTIL_MonitorDeadlocks', N'N', CAST(N'2019-02-26T11:41:35.797' AS DateTime), CAST(N'2019-03-02T14:48:47.203' AS DateTime))
 
INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'ALIEN15', N'JOB_UTIL_MonitorMostCommonWaits', N'N', CAST(N'2019-02-26T11:41:35.797' AS DateTime), CAST(N'2019-03-08T17:08:51.947' AS DateTime))
 
INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'ALIEN15', N'JOB_UTIL_ParallelMonitor', N'N', CAST(N'2019-02-26T11:41:35.800' AS DateTime), CAST(N'2019-03-08T17:08:50.647' AS DateTime))
 
INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'ALIEN15', N'JOB_UTIL_QryPlanStats', N'N', CAST(N'2019-02-26T11:41:35.800' AS DateTime), CAST(N'2019-03-08T17:24:14.390' AS DateTime))
 
INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'ALIEN15', N'JOB_UTIL_ReorgFragmentedIndexes', N'N', CAST(N'2019-02-26T11:41:35.800' AS DateTime), CAST(N'2019-03-15T12:00:57.943' AS DateTime))
 
INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'ALIEN15', N'JOB_UTIL_TempDbMonitor', N'N', CAST(N'2019-02-26T11:41:35.800' AS DateTime), CAST(N'2019-03-15T12:01:30.920' AS DateTime))
 
INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'ALIEN15', N'JOB_UTIL_TrackSessionWaitStats', N'N', CAST(N'2019-02-26T11:41:35.800' AS DateTime), CAST(N'2019-03-08T17:04:22.337' AS DateTime))
 
INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'ALIEN15', N'JOB_UTIL_TxMonitorTableStats', N'N', CAST(N'2019-02-26T11:41:35.810' AS DateTime), CAST(N'2019-03-02T08:24:26.450' AS DateTime))
 
INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'ALIEN15', N'UTIL_TxMonitorIDX', N'N', CAST(N'2019-02-26T11:41:35.813' AS DateTime), CAST(N'2019-03-02T08:24:50.910' AS DateTime))
 
INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'dfin.database.windows.net,1433', N'JOB_CaptureWorstPerfQuery', N'N', CAST(N'2019-02-26T11:41:35.813' AS DateTime), CAST(N'2019-03-08T17:09:37.093' AS DateTime))
 
INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'dfin.database.windows.net,1433', N'JOB_DFS_BoundQry_ProcessAllTables', N'N', CAST(N'2019-02-26T11:41:35.813' AS DateTime), CAST(N'2019-03-08T17:24:42.110' AS DateTime))
 
INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'dfin.database.windows.net,1433', N'JOB_DFS_CleanDFSTables', N'N', CAST(N'2019-02-26T11:41:35.813' AS DateTime), CAST(N'2019-03-09T02:14:59.367' AS DateTime))
 
INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'dfin.database.windows.net,1433', N'JOB_DFS_GetAllTableSizesAndRowCnt', N'N', CAST(N'2019-02-26T11:41:35.813' AS DateTime), CAST(N'2019-03-09T14:15:16.047' AS DateTime))
 
INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'dfin.database.windows.net,1433', N'JOB_DFS_MonitorLocks', N'N', CAST(N'2019-02-26T11:41:35.813' AS DateTime), CAST(N'2019-03-08T16:59:54.847' AS DateTime))
 
INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'dfin.database.windows.net,1433', N'JOB_JOB_UTIL_MonitorDeadlocks', N'N', CAST(N'2019-02-26T11:41:35.813' AS DateTime), CAST(N'2019-03-08T16:59:57.997' AS DateTime))
 
INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'dfin.database.windows.net,1433', N'JOB_MonitorWorkload', N'N', CAST(N'2019-02-26T11:41:35.813' AS DateTime), CAST(N'2019-03-08T17:25:03.477' AS DateTime))
 
INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'dfin.database.windows.net,1433', N'JOB_UTIL_DbMon_IndexVolitity', N'N', CAST(N'2019-02-26T11:41:35.813' AS DateTime), CAST(N'2019-03-08T17:04:58.090' AS DateTime))
 
INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'dfin.database.windows.net,1433', N'JOB_UTIL_DBSpace', N'N', CAST(N'2019-02-26T11:41:35.813' AS DateTime), CAST(N'2019-03-15T14:15:39.347' AS DateTime))
 
INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'dfin.database.windows.net,1433', N'JOB_UTIL_DBTableSpace', N'N', CAST(N'2019-02-26T11:41:35.817' AS DateTime), CAST(N'2019-03-09T14:15:46.733' AS DateTime))
 
INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'dfin.database.windows.net,1433', N'JOB_UTIL_DFS_DbSize', N'N', CAST(N'2019-02-26T11:41:35.817' AS DateTime), CAST(N'2019-03-09T14:15:57.640' AS DateTime))
 
INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'dfin.database.windows.net,1433', N'JOB_UTIL_GetIndexStats', N'N', CAST(N'2019-02-26T11:41:35.817' AS DateTime), CAST(N'2019-03-09T14:15:59.270' AS DateTime))
 
INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'dfin.database.windows.net,1433', N'JOB_UTIL_MonitorDeadlocks', N'N', CAST(N'2019-02-26T11:41:35.817' AS DateTime), CAST(N'2019-03-02T14:48:40.270' AS DateTime))
 
INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'dfin.database.windows.net,1433', N'JOB_UTIL_MonitorMostCommonWaits', N'N', CAST(N'2019-02-26T11:41:35.843' AS DateTime), CAST(N'2019-03-08T17:10:00.447' AS DateTime))
 
INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'dfin.database.windows.net,1433', N'JOB_UTIL_ParallelMonitor', N'N', CAST(N'2019-02-26T11:41:35.843' AS DateTime), CAST(N'2019-03-08T17:10:15.227' AS DateTime))
 
INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'dfin.database.windows.net,1433', N'JOB_UTIL_QryPlanStats', N'N', CAST(N'2019-02-26T11:41:35.843' AS DateTime), CAST(N'2019-03-08T17:25:47.507' AS DateTime))
 
INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'dfin.database.windows.net,1433', N'JOB_UTIL_ReorgFragmentedIndexes', N'N', CAST(N'2019-02-26T11:41:35.843' AS DateTime), CAST(N'2019-03-15T14:16:21.113' AS DateTime))
 
INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'dfin.database.windows.net,1433', N'JOB_UTIL_TempDbMonitor', N'N', CAST(N'2019-02-26T11:41:35.843' AS DateTime), CAST(N'2019-03-15T14:16:27.410' AS DateTime))
 
INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'dfin.database.windows.net,1433', N'JOB_UTIL_TrackSessionWaitStats', N'N', CAST(N'2019-02-26T11:41:35.843' AS DateTime), CAST(N'2019-03-08T17:05:16.357' AS DateTime))
 
INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'dfin.database.windows.net,1433', N'JOB_UTIL_TxMonitorTableStats', N'N', CAST(N'2019-02-26T11:41:35.843' AS DateTime), CAST(N'2019-03-02T08:24:39.930' AS DateTime))
 
INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'dfin.database.windows.net,1433', N'UTIL_TxMonitorIDX', N'N', CAST(N'2019-02-26T11:41:35.843' AS DateTime), CAST(N'2019-03-02T08:25:05.427' AS DateTime))
 
INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'SVR2016', N'JOB_CaptureWorstPerfQuery', N'N', CAST(N'2019-02-26T11:41:35.847' AS DateTime), CAST(N'2019-03-08T17:10:22.517' AS DateTime))
 
INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'SVR2016', N'JOB_DFS_BoundQry_ProcessAllTables', N'N', CAST(N'2019-02-26T11:41:35.847' AS DateTime), CAST(N'2019-03-08T17:26:17.687' AS DateTime))
 
INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'SVR2016', N'JOB_DFS_CleanDFSTables', N'N', CAST(N'2019-02-26T11:41:35.847' AS DateTime), CAST(N'2019-03-09T02:17:37.073' AS DateTime))
 
INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'SVR2016', N'JOB_DFS_GetAllTableSizesAndRowCnt', N'N', CAST(N'2019-02-26T11:41:35.847' AS DateTime), CAST(N'2019-03-09T14:17:41.683' AS DateTime))
 
INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'SVR2016', N'JOB_DFS_MonitorLocks', N'N', CAST(N'2019-02-26T11:41:35.847' AS DateTime), CAST(N'2019-03-08T17:01:17.110' AS DateTime))
 
INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'SVR2016', N'JOB_JOB_UTIL_MonitorDeadlocks', N'N', CAST(N'2019-02-26T11:41:35.847' AS DateTime), CAST(N'2019-03-08T17:01:39.067' AS DateTime))
 
INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'SVR2016', N'JOB_MonitorWorkload', N'N', CAST(N'2019-02-26T11:41:35.847' AS DateTime), CAST(N'2019-03-08T17:26:38.467' AS DateTime))
 
INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'SVR2016', N'JOB_UTIL_DbMon_IndexVolitity', N'N', CAST(N'2019-02-26T11:41:35.847' AS DateTime), CAST(N'2019-03-08T17:06:54.617' AS DateTime))
 
INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'SVR2016', N'JOB_UTIL_DBSpace', N'N', CAST(N'2019-02-26T11:41:35.867' AS DateTime), CAST(N'2019-03-15T14:18:57.930' AS DateTime))
 
INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'SVR2016', N'JOB_UTIL_DBTableSpace', N'N', CAST(N'2019-02-26T11:41:35.867' AS DateTime), CAST(N'2019-03-09T14:18:58.180' AS DateTime))
 
INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'SVR2016', N'JOB_UTIL_DFS_DbSize', N'N', CAST(N'2019-02-26T11:41:35.867' AS DateTime), CAST(N'2019-03-09T14:19:13.157' AS DateTime))
 
INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'SVR2016', N'JOB_UTIL_GetIndexStats', N'N', CAST(N'2019-02-26T11:41:35.867' AS DateTime), CAST(N'2019-03-09T14:19:31.147' AS DateTime))
 
INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'SVR2016', N'JOB_UTIL_MonitorDeadlocks', N'N', CAST(N'2019-02-26T11:41:35.867' AS DateTime), CAST(N'2019-03-02T14:48:55.500' AS DateTime))
 
INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'SVR2016', N'JOB_UTIL_MonitorMostCommonWaits', N'N', CAST(N'2019-02-26T11:41:35.867' AS DateTime), CAST(N'2019-03-08T17:12:24.473' AS DateTime))
 
INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'SVR2016', N'JOB_UTIL_ParallelMonitor', N'N', CAST(N'2019-02-26T11:41:35.867' AS DateTime), CAST(N'2019-03-08T17:12:26.960' AS DateTime))
 
INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'SVR2016', N'JOB_UTIL_QryPlanStats', N'N', CAST(N'2019-02-26T11:41:35.870' AS DateTime), CAST(N'2019-03-08T17:27:33.660' AS DateTime))
 
INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'SVR2016', N'JOB_UTIL_ReorgFragmentedIndexes', N'N', CAST(N'2019-02-26T11:41:35.870' AS DateTime), CAST(N'2019-03-15T14:20:16.463' AS DateTime))
 
INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'SVR2016', N'JOB_UTIL_TempDbMonitor', N'N', CAST(N'2019-02-26T11:41:35.870' AS DateTime), CAST(N'2019-03-15T14:20:34.230' AS DateTime))
 
INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'SVR2016', N'JOB_UTIL_TrackSessionWaitStats', N'N', CAST(N'2019-02-26T11:41:35.870' AS DateTime), CAST(N'2019-03-08T17:07:25.363' AS DateTime))
 
INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'SVR2016', N'JOB_UTIL_TxMonitorTableStats', N'N', CAST(N'2019-02-26T11:41:35.870' AS DateTime), CAST(N'2019-03-01T18:17:16.863' AS DateTime))
 
INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'SVR2016', N'UTIL_TxMonitorIDX', N'N', CAST(N'2019-02-26T11:41:35.870' AS DateTime), CAST(N'2019-03-01T18:17:31.070' AS DateTime))
 
INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'ALIEN15', N'JOB_TEST', N'N', CAST(N'2019-03-01T10:49:13.340' AS DateTime), CAST(N'2019-03-08T20:48:04.633' AS DateTime))
 
INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'ALIEN15', N'JOB_UpdateQryPlans', N'N', CAST(N'2019-03-01T13:18:49.357' AS DateTime), CAST(N'2019-03-08T19:30:55.677' AS DateTime))
 
INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'SVR2016', N'JOB_TEST', N'N', CAST(N'2019-03-04T16:15:37.093' AS DateTime), CAST(N'2019-03-08T23:27:24.577' AS DateTime))
 
INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'SVR2016', N'JOB_UpdateQryPlans', N'N', CAST(N'2019-03-01T13:19:01.500' AS DateTime), CAST(N'2019-03-08T18:18:32.173' AS DateTime))
 
INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'dfin.database.windows.net,1433', N'JOB_TEST', N'N', CAST(N'2019-03-01T13:19:21.940' AS DateTime), CAST(N'2019-03-08T23:24:42.070' AS DateTime))
 
INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'dfin.database.windows.net,1433', N'JOB_UpdateQryPlans', N'N', CAST(N'2019-03-01T13:19:22.040' AS DateTime), CAST(N'2019-03-08T18:15:46.780' AS DateTime))
 
SET IDENTITY_INSERT [dbo].[ActiveJobStep] ON 
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_UpdateQryPlansAndText ''DFS_IO_BoundQry2000''', N'N', N'N', N'b1229309-626e-4c42-9775-c0161859b46f', N'Y', 30, N'JOB_UpdateQryPlans', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step02', N'UTIL_UpdateQryPlansAndText ''DFS_CPU_BoundQry2000''', N'N', N'N', N'b1229309-626e-4c42-9775-c0161859b46f', N'Y', 31, N'JOB_UpdateQryPlans', 2)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step03', N'UTIL_UpdateQryPlansAndText ''DFS_IO_BoundQry''', N'N', N'N', N'b1229309-626e-4c42-9775-c0161859b46f', N'Y', 32, N'JOB_UpdateQryPlans', 3)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step04', N'UTIL_UpdateQryPlansAndText ''DFS_CPU_BoundQry''', N'N', N'N', N'b1229309-626e-4c42-9775-c0161859b46f', N'Y', 33, N'JOB_UpdateQryPlans', 4)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step05', N'DFS_CPU_BoundQry2000_ProcessTable', N'N', N'N', N'b1229309-626e-4c42-9775-c0161859b46f', N'Y', 34, N'JOB_DFS_BoundQry_ProcessAllTables', 5)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step06', N'DFS_IO_BoundQry2000_ProcessTable', N'N', N'N', N'b1229309-626e-4c42-9775-c0161859b46f', N'Y', 35, N'JOB_DFS_BoundQry_ProcessAllTables', 6)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step07', N'UTIL_DFS_CPU_BoundQry', N'N', N'N', N'b1229309-626e-4c42-9775-c0161859b46f', N'Y', 36, N'JOB_DFS_BoundQry_ProcessAllTables', 7)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step08', N'UTIL_IO_BoundQry', N'N', N'N', N'b1229309-626e-4c42-9775-c0161859b46f', N'Y', 37, N'JOB_DFS_BoundQry_ProcessAllTables', 8)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_CleanDFSTables', N'N', N'N', N'8203bcf3-f0c4-45f7-ba35-3d376582f6bb', N'Y', 38, N'JOB_DFS_CleanDFSTables', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'DFS_GetAllTableSizesAndRowCnt', N'N', N'N', N'65d2aea7-32e8-4990-b508-968615adffef', N'Y', 39, N'JOB_DFS_GetAllTableSizesAndRowCnt', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_DFS_MonitorLocks', N'N', N'N', N'0dae3845-9a38-4b51-8557-1697a61666ff', N'Y', 40, N'JOB_DFS_MonitorLocks', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_DFS_DeadlockStats', N'N', N'Y', N'2307ec0c-aed0-421d-942c-89a732982188', N'Y', 41, N'JOB_JOB_UTIL_MonitorDeadlocks', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_MonitorWorkload', N'N', N'N', N'dff23ef3-b73d-45ef-8c34-a3db3b398029', N'Y', 42, N'JOB_MonitorWorkload', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_TxMonitorTableIndexStats', N'N', N'Y', N'3abfc9cd-311c-41c2-8933-d98a1b9ded23', N'Y', 43, N'JOB_UTIL_DbMon_IndexVolitity', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_DBSpace', N'N', N'N', N'7059151e-344e-497d-b992-b1459f3e6618', N'Y', 44, N'JOB_UTIL_DBSpace', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_DBTableSpace', N'N', N'N', N'815ae81a-f117-4c79-85c2-d9fa59d2f6e6', N'Y', 45, N'JOB_UTIL_DBTableSpace', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_DFS_DbFileSizing', N'N', N'N', N'35b25e59-9bff-4434-a39c-84b23ee735f2', N'N', 46, N'JOB_UTIL_DFS_DbSize', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_GetIndexStats @RunID', N'N', N'Y', N'c86e97ce-cb7f-4da0-938b-5773ab05c8b1', N'Y', 47, N'JOB_UTIL_GetIndexStats', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_DFS_DeadlockStats ', N'N', N'Y', N'70b0d4c1-f08d-4178-9a8b-02a9bd81db5e', N'Y', 48, N'JOB_JOB_UTIL_MonitorDeadlocks', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_MonitorMostCommonWaits', N'N', N'N', N'c88d2e5c-fc6d-4bc8-81c2-2ca721e4d1df', N'Y', 49, N'JOB_UTIL_MonitorMostCommonWaits', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_ParallelMonitor', N'N', N'Y', N'faba3768-5d1f-4841-b757-f5ec4382692c', N'Y', 50, N'JOB_UTIL_ParallelMonitor', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_QryPlanStats', N'N', N'N', N'1b65499d-5337-40a9-8231-443394527bec', N'Y', 51, N'JOB_UTIL_QryPlanStats', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_ReorgFragmentedIndexes', N'N', N'N', N'2d24005d-b3df-4942-ada7-0175006b6e17', N'Y', 52, N'JOB_UTIL_ReorgFragmentedIndexes', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_TempDbMonitor', N'N', N'Y', N'cd0f6c7c-8a11-4b4e-af3b-9cae576a519e', N'N', 53, N'JOB_UTIL_TempDbMonitor', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_DFS_WaitStats @RunID 30', N'N', N'N', N'a2da87ee-174c-474c-b590-0e53ce597af9', N'Y', 54, N'JOB_UTIL_TrackSessionWaitStats', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_TxMonitorTableStats', N'N', N'Y', N'a891279a-6302-47cf-a6da-f80e6350179d', N'Y', 55, N'JOB_UTIL_Monitor_TPS', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_TxMonitorIDX', N'N', N'Y', N'eaa19f60-93c6-4ec6-859c-0487354b4ff3', N'Y', 56, N'JOB_UTIL_Monitor_TPS', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_MSTR_BoundQry2000', N'N', N'N', N'82f20db3-bd15-4b8b-8c34-35e915cde54f', N'Y', 57, N'JOB_CaptureWorstPerfQuery', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_UpdateQryPlansAndText ''DFS_IO_BoundQry2000''', N'N', N'N', N'f18c5f76-4f4b-42f4-988f-4199771b194d', N'Y', 58, N'JOB_UpdateQryPlans', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step02', N'UTIL_UpdateQryPlansAndText ''DFS_CPU_BoundQry2000''', N'N', N'N', N'f18c5f76-4f4b-42f4-988f-4199771b194d', N'Y', 59, N'JOB_UpdateQryPlans', 2)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step03', N'UTIL_UpdateQryPlansAndText ''DFS_IO_BoundQry''', N'N', N'N', N'f18c5f76-4f4b-42f4-988f-4199771b194d', N'Y', 60, N'JOB_UpdateQryPlans', 3)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step04', N'UTIL_UpdateQryPlansAndText ''DFS_CPU_BoundQry''', N'N', N'N', N'f18c5f76-4f4b-42f4-988f-4199771b194d', N'Y', 61, N'JOB_UpdateQryPlans', 4)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step05', N'DFS_CPU_BoundQry2000_ProcessTable', N'N', N'N', N'f18c5f76-4f4b-42f4-988f-4199771b194d', N'Y', 62, N'JOB_DFS_BoundQry_ProcessAllTables', 5)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step06', N'DFS_IO_BoundQry2000_ProcessTable', N'N', N'N', N'f18c5f76-4f4b-42f4-988f-4199771b194d', N'Y', 63, N'JOB_DFS_BoundQry_ProcessAllTables', 6)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step07', N'UTIL_DFS_CPU_BoundQry', N'N', N'N', N'f18c5f76-4f4b-42f4-988f-4199771b194d', N'Y', 64, N'JOB_DFS_BoundQry_ProcessAllTables', 7)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step08', N'UTIL_IO_BoundQry', N'N', N'N', N'f18c5f76-4f4b-42f4-988f-4199771b194d', N'Y', 65, N'JOB_DFS_BoundQry_ProcessAllTables', 8)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_CleanDFSTables', N'N', N'N', N'6dce5caa-6639-49b2-b73c-a2dbf07777aa', N'Y', 66, N'JOB_DFS_CleanDFSTables', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'DFS_GetAllTableSizesAndRowCnt', N'N', N'N', N'5db80b4d-7db3-47a0-8887-bf05a1bd252c', N'Y', 67, N'JOB_DFS_GetAllTableSizesAndRowCnt', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_DFS_MonitorLocks', N'N', N'N', N'ae459a69-c155-4beb-839c-796ba3718ec7', N'Y', 68, N'JOB_DFS_MonitorLocks', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_DFS_DeadlockStats', N'N', N'Y', N'892d2808-902e-4283-a02b-b7eb54675a09', N'Y', 69, N'JOB_JOB_UTIL_MonitorDeadlocks', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_MonitorWorkload', N'N', N'N', N'0fc41e38-03c9-4a30-9221-d6497f398cdb', N'Y', 70, N'JOB_MonitorWorkload', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_TxMonitorTableIndexStats', N'N', N'Y', N'a479c0c3-08a1-454a-8068-59841533f281', N'Y', 71, N'JOB_UTIL_DbMon_IndexVolitity', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_DBSpace', N'N', N'N', N'1d07071c-70b4-4d38-95f2-f2048a3886a7', N'Y', 72, N'JOB_UTIL_DBSpace', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_DBTableSpace', N'N', N'N', N'c7d138f5-487e-4ba5-9964-ea418cf7384b', N'Y', 73, N'JOB_UTIL_DBTableSpace', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_DFS_DbFileSizing', N'N', N'N', N'946e919a-1a5a-42b1-90be-95df2f14b017', N'N', 74, N'JOB_UTIL_DFS_DbSize', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_GetIndexStats @RunID', N'N', N'Y', N'890b31fa-207c-4ad5-b987-09400e625340', N'Y', 75, N'JOB_UTIL_GetIndexStats', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_DFS_DeadlockStats ', N'N', N'Y', N'3b259d59-7f49-4dcf-b9be-f1b63ba7c236', N'Y', 76, N'JOB_JOB_UTIL_MonitorDeadlocks', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_MonitorMostCommonWaits', N'N', N'N', N'4e4f4756-6074-4273-8da6-1079d06487e4', N'Y', 77, N'JOB_UTIL_MonitorMostCommonWaits', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_DFS_MonitorLocks', N'N', N'N', N'9911e4cb-b047-4b66-977c-db19b9e811c1', N'Y', 208, N'JOB_DFS_MonitorLocks', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_DFS_DeadlockStats', N'N', N'Y', N'cb142312-c02d-44e5-a83e-51cebe90ab41', N'Y', 209, N'JOB_JOB_UTIL_MonitorDeadlocks', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_MonitorWorkload', N'N', N'N', N'f7d9a7eb-f7e8-456c-8098-827e2bd5a89b', N'Y', 210, N'JOB_MonitorWorkload', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_TxMonitorTableIndexStats', N'N', N'Y', N'014c0dd0-5432-4c35-9323-814a99e37213', N'Y', 211, N'JOB_UTIL_DbMon_IndexVolitity', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_DBSpace', N'N', N'N', N'fba69c87-a70b-4b48-90d6-eb3f5725a749', N'Y', 212, N'JOB_UTIL_DBSpace', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_DBTableSpace', N'N', N'N', N'ed9a83d8-ba28-4c91-bd33-c2e375e98f0d', N'Y', 213, N'JOB_UTIL_DBTableSpace', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_DFS_DbFileSizing', N'N', N'N', N'b051b960-57d7-47c3-aa93-44be53ae4938', N'N', 214, N'JOB_UTIL_DFS_DbSize', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_GetIndexStats @RunID', N'N', N'Y', N'd654ec5f-1aa2-46ae-bc89-40b8dad0733f', N'Y', 215, N'JOB_UTIL_GetIndexStats', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_DFS_DeadlockStats ', N'N', N'Y', N'7fdb32a9-4c19-4a40-a318-3bc4dc9fbd4d', N'Y', 216, N'JOB_JOB_UTIL_MonitorDeadlocks', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_MonitorMostCommonWaits', N'N', N'N', N'e6121ff3-d94b-4512-8e2c-18de293eddc2', N'Y', 217, N'JOB_UTIL_MonitorMostCommonWaits', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_ParallelMonitor', N'N', N'Y', N'dfb9f3ef-0ffa-4f48-bfe3-5ea8943636d0', N'Y', 218, N'JOB_UTIL_ParallelMonitor', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_QryPlanStats', N'N', N'N', N'd62c9887-d32d-4f67-af3e-9198223d2b35', N'Y', 219, N'JOB_UTIL_QryPlanStats', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_ReorgFragmentedIndexes', N'N', N'N', N'4755e75e-ae38-42c4-a4ee-0fbc650f64c6', N'Y', 220, N'JOB_UTIL_ReorgFragmentedIndexes', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_TempDbMonitor', N'N', N'Y', N'32633074-61ff-418b-b1b2-ca0e51a07c3e', N'N', 221, N'JOB_UTIL_TempDbMonitor', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_DFS_WaitStats @RunID 30', N'N', N'N', N'54cd4fd9-f2ca-477b-a959-ec3a77c1cc38', N'Y', 222, N'JOB_UTIL_TrackSessionWaitStats', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_TxMonitorTableStats', N'N', N'Y', N'ec46336f-42b2-4ac7-aff9-02aa1bbef579', N'Y', 223, N'JOB_UTIL_Monitor_TPS', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_TxMonitorIDX', N'N', N'Y', N'14ffdb3d-b299-4931-8f75-47d7771d5c43', N'Y', 224, N'JOB_UTIL_Monitor_TPS', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_MSTR_BoundQry2000', N'N', N'N', N'faaf4f9b-1f12-49af-9fc1-3897f71d4cb2', N'Y', 225, N'JOB_CaptureWorstPerfQuery', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_UpdateQryPlansAndText ''DFS_IO_BoundQry2000''', N'N', N'N', N'ebf76842-87f8-488e-ae13-c4cacd3a6f39', N'Y', 226, N'JOB_UpdateQryPlans', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step02', N'UTIL_UpdateQryPlansAndText ''DFS_CPU_BoundQry2000''', N'N', N'N', N'ebf76842-87f8-488e-ae13-c4cacd3a6f39', N'Y', 227, N'JOB_UpdateQryPlans', 2)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step03', N'UTIL_UpdateQryPlansAndText ''DFS_IO_BoundQry''', N'N', N'N', N'ebf76842-87f8-488e-ae13-c4cacd3a6f39', N'Y', 228, N'JOB_UpdateQryPlans', 3)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step04', N'UTIL_UpdateQryPlansAndText ''DFS_CPU_BoundQry''', N'N', N'N', N'ebf76842-87f8-488e-ae13-c4cacd3a6f39', N'Y', 229, N'JOB_UpdateQryPlans', 4)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step05', N'DFS_CPU_BoundQry2000_ProcessTable', N'N', N'N', N'ebf76842-87f8-488e-ae13-c4cacd3a6f39', N'Y', 230, N'JOB_DFS_BoundQry_ProcessAllTables', 5)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step06', N'DFS_IO_BoundQry2000_ProcessTable', N'N', N'N', N'ebf76842-87f8-488e-ae13-c4cacd3a6f39', N'Y', 231, N'JOB_DFS_BoundQry_ProcessAllTables', 6)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_MSTR_BoundQry2000', N'N', N'N', N'ae96a724-fa83-450d-8a46-2ba973f1b9a1', N'Y', 85, N'JOB_CaptureWorstPerfQuery', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_UpdateQryPlansAndText ''DFS_IO_BoundQry2000''', N'N', N'N', N'a5aeb6cf-20ad-4f62-b4f0-378d4ed463ad', N'Y', 86, N'JOB_UpdateQryPlans', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step02', N'UTIL_UpdateQryPlansAndText ''DFS_CPU_BoundQry2000''', N'N', N'N', N'a5aeb6cf-20ad-4f62-b4f0-378d4ed463ad', N'Y', 87, N'JOB_UpdateQryPlans', 2)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step03', N'UTIL_UpdateQryPlansAndText ''DFS_IO_BoundQry''', N'N', N'N', N'a5aeb6cf-20ad-4f62-b4f0-378d4ed463ad', N'Y', 88, N'JOB_UpdateQryPlans', 3)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step04', N'UTIL_UpdateQryPlansAndText ''DFS_CPU_BoundQry''', N'N', N'N', N'a5aeb6cf-20ad-4f62-b4f0-378d4ed463ad', N'Y', 89, N'JOB_UpdateQryPlans', 4)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step05', N'DFS_CPU_BoundQry2000_ProcessTable', N'N', N'N', N'a5aeb6cf-20ad-4f62-b4f0-378d4ed463ad', N'Y', 90, N'JOB_DFS_BoundQry_ProcessAllTables', 5)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step06', N'DFS_IO_BoundQry2000_ProcessTable', N'N', N'N', N'a5aeb6cf-20ad-4f62-b4f0-378d4ed463ad', N'Y', 91, N'JOB_DFS_BoundQry_ProcessAllTables', 6)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step07', N'UTIL_DFS_CPU_BoundQry', N'N', N'N', N'a5aeb6cf-20ad-4f62-b4f0-378d4ed463ad', N'Y', 92, N'JOB_DFS_BoundQry_ProcessAllTables', 7)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step08', N'UTIL_IO_BoundQry', N'N', N'N', N'a5aeb6cf-20ad-4f62-b4f0-378d4ed463ad', N'Y', 93, N'JOB_DFS_BoundQry_ProcessAllTables', 8)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_CleanDFSTables', N'N', N'N', N'a29c0bbf-29ea-447e-b89b-a7047da0591c', N'Y', 94, N'JOB_DFS_CleanDFSTables', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'DFS_GetAllTableSizesAndRowCnt', N'N', N'N', N'971bb98b-9714-44af-9d0e-6ec421a3334e', N'Y', 95, N'JOB_DFS_GetAllTableSizesAndRowCnt', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_DFS_MonitorLocks', N'N', N'N', N'16fdefc0-a207-45bd-8951-35e0d2167392', N'Y', 96, N'JOB_DFS_MonitorLocks', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_DFS_DeadlockStats', N'N', N'Y', N'3e720149-1aed-491a-ad18-f142aa4a0e38', N'Y', 97, N'JOB_JOB_UTIL_MonitorDeadlocks', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_MonitorWorkload', N'N', N'N', N'2788b130-9ade-4a4d-a34e-451a0200940e', N'Y', 98, N'JOB_MonitorWorkload', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_TxMonitorTableIndexStats', N'N', N'Y', N'87680695-f42b-4465-8a40-b470573bc656', N'Y', 99, N'JOB_UTIL_DbMon_IndexVolitity', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_DBSpace', N'N', N'N', N'd6c31c69-866b-42ca-94ff-a8b827aaca60', N'Y', 100, N'JOB_UTIL_DBSpace', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_DBTableSpace', N'N', N'N', N'7a483180-5604-49ca-ac47-e848c4eca4a0', N'Y', 101, N'JOB_UTIL_DBTableSpace', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_DFS_DbFileSizing', N'N', N'N', N'f783a590-426c-43b6-8097-212a56eeb0b2', N'N', 102, N'JOB_UTIL_DFS_DbSize', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_GetIndexStats @RunID', N'N', N'Y', N'e7ff3122-05b1-437b-8778-1e6ec0790edb', N'Y', 103, N'JOB_UTIL_GetIndexStats', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_DFS_DeadlockStats ', N'N', N'Y', N'294b86f0-973d-4222-adac-4770689360b6', N'Y', 104, N'JOB_JOB_UTIL_MonitorDeadlocks', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_MonitorMostCommonWaits', N'N', N'N', N'65e9fbf2-9985-404a-8caf-2385d6fba2c5', N'Y', 105, N'JOB_UTIL_MonitorMostCommonWaits', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_ParallelMonitor', N'N', N'Y', N'82b87597-1998-43b9-82bd-8ccabb40a6b2', N'Y', 106, N'JOB_UTIL_ParallelMonitor', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_QryPlanStats', N'N', N'N', N'7c5a20b0-7981-4446-8c58-6766fcf97c17', N'Y', 107, N'JOB_UTIL_QryPlanStats', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_ReorgFragmentedIndexes', N'N', N'N', N'89efb6e5-e151-49a1-b867-067ed953935f', N'Y', 108, N'JOB_UTIL_ReorgFragmentedIndexes', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_ParallelMonitor', N'N', N'Y', N'b22d702d-fffb-4d1a-9a83-479b81692c3e', N'Y', 78, N'JOB_UTIL_ParallelMonitor', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_QryPlanStats', N'N', N'N', N'c6bc37a4-5148-454d-a36c-6b8f2a347ef5', N'Y', 79, N'JOB_UTIL_QryPlanStats', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_ReorgFragmentedIndexes', N'N', N'N', N'25864f68-7c27-40c0-9b11-677a07d3bc26', N'Y', 80, N'JOB_UTIL_ReorgFragmentedIndexes', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_TempDbMonitor', N'N', N'Y', N'5a868f12-1ced-48ce-8e4e-dbfd39fa573b', N'N', 81, N'JOB_UTIL_TempDbMonitor', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_DFS_WaitStats @RunID 30', N'N', N'N', N'babacaef-44d8-410d-b523-567f35450776', N'Y', 82, N'JOB_UTIL_TrackSessionWaitStats', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_TxMonitorTableStats', N'N', N'Y', N'78718fa4-7a86-4388-a81b-d9479c2e1885', N'Y', 83, N'JOB_UTIL_Monitor_TPS', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_TxMonitorIDX', N'N', N'Y', N'263e288d-4eb9-43ad-bd6e-90d0703272f7', N'Y', 84, N'JOB_UTIL_Monitor_TPS', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_MSTR_BoundQry2000', N'N', N'N', N'5ff535ea-5614-4ac4-9140-73c2f16afb5d', N'Y', 113, N'JOB_CaptureWorstPerfQuery', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_UpdateQryPlansAndText ''DFS_IO_BoundQry2000''', N'N', N'N', N'591937ec-d07f-4528-a0d3-1b11b6f43088', N'Y', 114, N'JOB_UpdateQryPlans', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step02', N'UTIL_UpdateQryPlansAndText ''DFS_CPU_BoundQry2000''', N'N', N'N', N'591937ec-d07f-4528-a0d3-1b11b6f43088', N'Y', 115, N'JOB_UpdateQryPlans', 2)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step03', N'UTIL_UpdateQryPlansAndText ''DFS_IO_BoundQry''', N'N', N'N', N'591937ec-d07f-4528-a0d3-1b11b6f43088', N'Y', 116, N'JOB_UpdateQryPlans', 3)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step04', N'UTIL_UpdateQryPlansAndText ''DFS_CPU_BoundQry''', N'N', N'N', N'591937ec-d07f-4528-a0d3-1b11b6f43088', N'Y', 117, N'JOB_UpdateQryPlans', 4)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step05', N'DFS_CPU_BoundQry2000_ProcessTable', N'N', N'N', N'591937ec-d07f-4528-a0d3-1b11b6f43088', N'Y', 118, N'JOB_DFS_BoundQry_ProcessAllTables', 5)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step06', N'DFS_IO_BoundQry2000_ProcessTable', N'N', N'N', N'591937ec-d07f-4528-a0d3-1b11b6f43088', N'Y', 119, N'JOB_DFS_BoundQry_ProcessAllTables', 6)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step07', N'UTIL_DFS_CPU_BoundQry', N'N', N'N', N'591937ec-d07f-4528-a0d3-1b11b6f43088', N'Y', 120, N'JOB_DFS_BoundQry_ProcessAllTables', 7)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step08', N'UTIL_IO_BoundQry', N'N', N'N', N'591937ec-d07f-4528-a0d3-1b11b6f43088', N'Y', 121, N'JOB_DFS_BoundQry_ProcessAllTables', 8)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_CleanDFSTables', N'N', N'N', N'bd5af2ee-cc50-4253-9ef5-56af2131f7e6', N'Y', 122, N'JOB_DFS_CleanDFSTables', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'DFS_GetAllTableSizesAndRowCnt', N'N', N'N', N'ebc5339a-51e6-41ae-97be-7cac8971162f', N'Y', 123, N'JOB_DFS_GetAllTableSizesAndRowCnt', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_DFS_MonitorLocks', N'N', N'N', N'd749b33f-bb2b-43c0-8a0d-cdefc7c4c20b', N'Y', 124, N'JOB_DFS_MonitorLocks', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_DFS_DeadlockStats', N'N', N'Y', N'c9160b0a-ff34-4be4-ab91-e9779287c3ac', N'Y', 125, N'JOB_JOB_UTIL_MonitorDeadlocks', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_MonitorWorkload', N'N', N'N', N'a3ad0aee-6a91-493d-bf67-22cb72de0ff4', N'Y', 126, N'JOB_MonitorWorkload', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_TxMonitorTableIndexStats', N'N', N'Y', N'b57e8106-df52-46df-b4ad-b3a57730b5a5', N'Y', 127, N'JOB_UTIL_DbMon_IndexVolitity', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_DBSpace', N'N', N'N', N'93765a74-9d65-44cd-869d-946f00cd7b81', N'Y', 128, N'JOB_UTIL_DBSpace', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_DBTableSpace', N'N', N'N', N'6a42e0f4-78d9-4029-bdb8-7f0cf06ad7a8', N'Y', 129, N'JOB_UTIL_DBTableSpace', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_DFS_DbFileSizing', N'N', N'N', N'c9fe8a15-244b-42d2-9100-8c7f38323bc9', N'N', 130, N'JOB_UTIL_DFS_DbSize', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_GetIndexStats @RunID', N'N', N'Y', N'507ec161-0114-4f34-8e06-c2d214a91cbc', N'Y', 131, N'JOB_UTIL_GetIndexStats', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_DFS_DeadlockStats ', N'N', N'Y', N'6c2d721d-498c-4d26-94a0-2609397a0ac9', N'Y', 132, N'JOB_JOB_UTIL_MonitorDeadlocks', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_MonitorMostCommonWaits', N'N', N'N', N'0f24f6c2-e149-41cc-8414-d606f293ad1d', N'Y', 133, N'JOB_UTIL_MonitorMostCommonWaits', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_ParallelMonitor', N'N', N'Y', N'0623c052-1fbb-43df-9243-9d7f366ec26b', N'Y', 134, N'JOB_UTIL_ParallelMonitor', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_QryPlanStats', N'N', N'N', N'24227f73-e8cc-4540-ba48-2d8ca41e8123', N'Y', 135, N'JOB_UTIL_QryPlanStats', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_ReorgFragmentedIndexes', N'N', N'N', N'6cf8d9dd-583b-4055-9369-8ea6834b6da9', N'Y', 136, N'JOB_UTIL_ReorgFragmentedIndexes', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_TempDbMonitor', N'N', N'Y', N'4a6cfd66-ccff-4466-a584-5f6a61f29455', N'N', 137, N'JOB_UTIL_TempDbMonitor', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_DFS_WaitStats @RunID 30', N'N', N'N', N'2368ac20-6bb7-4863-991a-f99af95ef90b', N'Y', 138, N'JOB_UTIL_TrackSessionWaitStats', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_TxMonitorTableStats', N'N', N'Y', N'06a6bb48-dcaa-4e78-b859-024551450dea', N'Y', 139, N'JOB_UTIL_Monitor_TPS', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_TxMonitorIDX', N'N', N'Y', N'e22f5cab-98af-4dca-837f-c8a5b1177a52', N'Y', 140, N'JOB_UTIL_Monitor_TPS', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_MSTR_BoundQry2000', N'N', N'N', N'ce610c62-6553-4893-9bd0-f150182a6df0', N'Y', 169, N'JOB_CaptureWorstPerfQuery', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_UpdateQryPlansAndText ''DFS_IO_BoundQry2000''', N'N', N'N', N'7fcbceb8-cfd4-4873-9677-1f5d5ed817bb', N'Y', 170, N'JOB_UpdateQryPlans', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_MSTR_BoundQry2000', N'N', N'N', N'ba44111b-83ce-4de8-915b-e88a7fe18299', N'Y', 197, N'JOB_CaptureWorstPerfQuery', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_UpdateQryPlansAndText ''DFS_IO_BoundQry2000''', N'N', N'N', N'eea70383-6f17-4a63-a650-2860f7d4dd8d', N'Y', 198, N'JOB_UpdateQryPlans', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step02', N'UTIL_UpdateQryPlansAndText ''DFS_CPU_BoundQry2000''', N'N', N'N', N'eea70383-6f17-4a63-a650-2860f7d4dd8d', N'Y', 199, N'JOB_UpdateQryPlans', 2)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step03', N'UTIL_UpdateQryPlansAndText ''DFS_IO_BoundQry''', N'N', N'N', N'eea70383-6f17-4a63-a650-2860f7d4dd8d', N'Y', 200, N'JOB_UpdateQryPlans', 3)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step04', N'UTIL_UpdateQryPlansAndText ''DFS_CPU_BoundQry''', N'N', N'N', N'eea70383-6f17-4a63-a650-2860f7d4dd8d', N'Y', 201, N'JOB_UpdateQryPlans', 4)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step05', N'DFS_CPU_BoundQry2000_ProcessTable', N'N', N'N', N'eea70383-6f17-4a63-a650-2860f7d4dd8d', N'Y', 202, N'JOB_DFS_BoundQry_ProcessAllTables', 5)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step06', N'DFS_IO_BoundQry2000_ProcessTable', N'N', N'N', N'eea70383-6f17-4a63-a650-2860f7d4dd8d', N'Y', 203, N'JOB_DFS_BoundQry_ProcessAllTables', 6)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step07', N'UTIL_DFS_CPU_BoundQry', N'N', N'N', N'eea70383-6f17-4a63-a650-2860f7d4dd8d', N'Y', 204, N'JOB_DFS_BoundQry_ProcessAllTables', 7)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step08', N'UTIL_IO_BoundQry', N'N', N'N', N'eea70383-6f17-4a63-a650-2860f7d4dd8d', N'Y', 205, N'JOB_DFS_BoundQry_ProcessAllTables', 8)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_CleanDFSTables', N'N', N'N', N'dbc36f52-4ac4-4d55-9896-2608dda7620a', N'Y', 206, N'JOB_DFS_CleanDFSTables', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'DFS_GetAllTableSizesAndRowCnt', N'N', N'N', N'cb678e7c-6965-4e51-a128-43bab79b8b0c', N'Y', 207, N'JOB_DFS_GetAllTableSizesAndRowCnt', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_DFS_DeadlockStats ', N'N', N'Y', N'cc071751-3837-4f9b-8bd5-c7afeb4c65e9', N'Y', 272, N'JOB_JOB_UTIL_MonitorDeadlocks', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_MonitorMostCommonWaits', N'N', N'N', N'd675b723-b50e-49bd-9c39-eb0bf30c40c8', N'Y', 273, N'JOB_UTIL_MonitorMostCommonWaits', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_ParallelMonitor', N'N', N'Y', N'10c45ce1-9cf0-4681-8717-dc829a52b213', N'Y', 274, N'JOB_UTIL_ParallelMonitor', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_QryPlanStats', N'N', N'N', N'65836f8d-40dc-43fe-a28b-91cbcb088de4', N'Y', 275, N'JOB_UTIL_QryPlanStats', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_ReorgFragmentedIndexes', N'N', N'N', N'3f03fc66-c7ab-4cdb-85c8-85bd0c49f4c3', N'Y', 276, N'JOB_UTIL_ReorgFragmentedIndexes', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_TempDbMonitor', N'N', N'Y', N'2d242010-ddfb-47e1-b529-a8253ee9dfa7', N'N', 277, N'JOB_UTIL_TempDbMonitor', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_DFS_WaitStats @RunID 30', N'N', N'N', N'c990c1dd-54eb-4d39-8df4-3df7a8f84449', N'Y', 278, N'JOB_UTIL_TrackSessionWaitStats', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_TxMonitorTableStats', N'N', N'Y', N'772a144c-06ac-4963-a4ee-6aba80c370a2', N'Y', 279, N'JOB_UTIL_Monitor_TPS', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_TxMonitorIDX', N'N', N'Y', N'27cf028c-319e-4e88-8dfb-63ab705c10bf', N'Y', 280, N'JOB_UTIL_Monitor_TPS', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_DBUsage', N'N', N'Y', N'27cf028c-319e-4e88-8dfb-63ab705c10aa', N'Y', 281, N'JOB_UTIL_DBUsage', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Check Running processes', N'sp_who2', N'Y', N'N', N'5e70100f-3e00-434c-9f0a-4dffa3e2d4ac', N'Y', 334, N'JOB_TEST', 2)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_MSTR_BoundQry2000', N'N', N'N', N'a1911306-7d38-4688-993a-10d2544911f3', N'Y', 306, NULL, 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_UpdateQryPlansAndText ''DFS_IO_BoundQry2000''', N'N', N'N', N'ec26f965-a86c-48f0-bfae-223b63b16c0a', N'Y', 307, NULL, 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step02', N'UTIL_UpdateQryPlansAndText ''DFS_CPU_BoundQry2000''', N'N', N'N', N'ec26f965-a86c-48f0-bfae-223b63b16c0a', N'Y', 308, NULL, 2)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step03', N'UTIL_UpdateQryPlansAndText ''DFS_IO_BoundQry''', N'N', N'N', N'ec26f965-a86c-48f0-bfae-223b63b16c0a', N'Y', 309, NULL, 3)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step04', N'UTIL_UpdateQryPlansAndText ''DFS_CPU_BoundQry''', N'N', N'N', N'ec26f965-a86c-48f0-bfae-223b63b16c0a', N'Y', 310, NULL, 4)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step05', N'DFS_CPU_BoundQry2000_ProcessTable', N'N', N'N', N'ec26f965-a86c-48f0-bfae-223b63b16c0a', N'Y', 311, NULL, 5)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step06', N'DFS_IO_BoundQry2000_ProcessTable', N'N', N'N', N'ec26f965-a86c-48f0-bfae-223b63b16c0a', N'Y', 312, NULL, 6)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step07', N'UTIL_DFS_CPU_BoundQry', N'N', N'N', N'ec26f965-a86c-48f0-bfae-223b63b16c0a', N'Y', 313, NULL, 7)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step08', N'UTIL_IO_BoundQry', N'N', N'N', N'ec26f965-a86c-48f0-bfae-223b63b16c0a', N'Y', 314, NULL, 8)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_CleanDFSTables', N'N', N'N', N'9ce6f59f-95f8-4c65-970c-83e5fed49fe1', N'Y', 315, NULL, 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'DFS_GetAllTableSizesAndRowCnt', N'N', N'N', N'6e85916b-c139-4cae-9801-145d2832977a', N'Y', 316, NULL, 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_DFS_MonitorLocks', N'N', N'N', N'8af19b38-a6b1-4918-94dc-aa0fda5c4cbb', N'Y', 317, NULL, 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_DFS_DeadlockStats', N'N', N'Y', N'629c8a6e-ce2b-4f37-9328-9b2bfe97d95c', N'Y', 318, NULL, 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_MonitorWorkload', N'N', N'N', N'4a06266b-e886-4920-b5b9-ba93432bce2d', N'Y', 319, NULL, 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_TxMonitorTableIndexStats', N'N', N'Y', N'f632cb11-d36c-401b-acfa-59a84cfe5266', N'Y', 320, NULL, 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_DBSpace', N'N', N'N', N'5aae567d-e776-4bdb-9127-ad159af80d6a', N'Y', 321, NULL, 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_DBTableSpace', N'N', N'N', N'27387393-040b-4cbd-897f-0f2e7a9a43d4', N'Y', 322, NULL, 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_DFS_DbFileSizing', N'N', N'N', N'83058fcb-016f-4e09-90ff-e7d1f3310141', N'N', 323, NULL, 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_GetIndexStats @RunID', N'N', N'Y', N'1b0f4eca-8842-43ac-b5d7-5f8ede7505bb', N'Y', 324, NULL, 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_DFS_DeadlockStats ', N'N', N'Y', N'91d564d0-9890-412f-979f-04b731551e37', N'Y', 325, NULL, 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_MonitorMostCommonWaits', N'N', N'N', N'a09c8059-1051-4b35-84f9-bed176de4cbc', N'Y', 326, NULL, 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_ParallelMonitor', N'N', N'Y', N'55eb5aba-072d-48cd-bae2-ab27b2a56a3b', N'Y', 327, NULL, 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_QryPlanStats', N'N', N'N', N'3d4584ef-710c-46a0-a417-f1e925ea1865', N'Y', 328, NULL, 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_ReorgFragmentedIndexes', N'N', N'N', N'c05ca2cd-4708-48e7-8628-59d36cae8b32', N'Y', 329, NULL, 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_TempDbMonitor', N'N', N'Y', N'b06f95ac-b1df-49a1-af59-3db74abff9cc', N'N', 330, NULL, 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_DFS_WaitStats @RunID 30', N'N', N'N', N'78d69a45-5823-46da-b644-ae99f4ad9c99', N'Y', 331, NULL, 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_TxMonitorTableStats', N'N', N'Y', N'04b9f98f-a4aa-459d-b3d5-53ad3af16363', N'Y', 332, NULL, 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_TxMonitorIDX', N'N', N'Y', N'5dcc09c4-ffcc-4e06-b5bc-834a56398c46', N'Y', 333, NULL, 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_MSTR_BoundQry2000', N'N', N'N', N'7a48e3de-f83d-4b04-85ac-a68d31f8ea7e', N'Y', 1, N'JOB_CaptureWorstPerfQuery', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_UpdateQryPlansAndText ''DFS_IO_BoundQry2000''', N'N', N'N', N'df5f7776-520c-403f-b504-ae0ac65bcf65', N'Y', 2, N'JOB_UpdateQryPlans', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step02', N'UTIL_UpdateQryPlansAndText ''DFS_CPU_BoundQry2000''', N'N', N'N', N'df5f7776-520c-403f-b504-ae0ac65bcf65', N'Y', 3, N'JOB_UpdateQryPlans', 2)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step03', N'UTIL_UpdateQryPlansAndText ''DFS_IO_BoundQry''', N'N', N'N', N'df5f7776-520c-403f-b504-ae0ac65bcf65', N'Y', 4, N'JOB_UpdateQryPlans', 3)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step04', N'UTIL_UpdateQryPlansAndText ''DFS_CPU_BoundQry''', N'N', N'N', N'df5f7776-520c-403f-b504-ae0ac65bcf65', N'Y', 5, N'JOB_UpdateQryPlans', 4)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step05', N'DFS_CPU_BoundQry2000_ProcessTable', N'N', N'N', N'df5f7776-520c-403f-b504-ae0ac65bcf65', N'Y', 6, N'JOB_DFS_BoundQry_ProcessAllTables', 5)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step06', N'DFS_IO_BoundQry2000_ProcessTable', N'N', N'N', N'df5f7776-520c-403f-b504-ae0ac65bcf65', N'Y', 7, N'JOB_DFS_BoundQry_ProcessAllTables', 6)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step07', N'UTIL_DFS_CPU_BoundQry', N'N', N'N', N'df5f7776-520c-403f-b504-ae0ac65bcf65', N'Y', 8, N'JOB_DFS_BoundQry_ProcessAllTables', 7)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step08', N'UTIL_IO_BoundQry', N'N', N'N', N'df5f7776-520c-403f-b504-ae0ac65bcf65', N'Y', 9, N'JOB_DFS_BoundQry_ProcessAllTables', 8)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_CleanDFSTables', N'N', N'N', N'ef0df41d-6f9e-465f-914a-1fc622ecb744', N'Y', 10, N'JOB_DFS_CleanDFSTables', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'DFS_GetAllTableSizesAndRowCnt', N'N', N'N', N'8a351ecf-882a-4128-82e8-14025ba5537e', N'Y', 11, N'JOB_DFS_GetAllTableSizesAndRowCnt', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_DFS_MonitorLocks', N'N', N'N', N'8258bd1d-df74-410b-973f-91c52dbc53de', N'Y', 12, N'JOB_DFS_MonitorLocks', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_DFS_DeadlockStats', N'N', N'Y', N'b559e79a-bc2d-4ddf-b81c-a75e076780a5', N'Y', 13, N'JOB_JOB_UTIL_MonitorDeadlocks', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_MonitorWorkload', N'N', N'N', N'a727351e-a627-4ab6-b138-6e888011fcce', N'Y', 14, N'JOB_MonitorWorkload', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_TxMonitorTableIndexStats', N'N', N'Y', N'2a5020d8-1005-4f2a-ac9a-3a95a9229f5c', N'Y', 15, N'JOB_UTIL_DbMon_IndexVolitity', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_DBSpace', N'N', N'N', N'89c8c938-489d-4b41-b84c-c367488b30b6', N'Y', 16, N'JOB_UTIL_DBSpace', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_DBTableSpace', N'N', N'N', N'025498da-1fb3-4a5e-9fea-60b584060f66', N'Y', 17, N'JOB_UTIL_DBTableSpace', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_DFS_DbFileSizing', N'N', N'N', N'2d5c93d6-2763-4005-8c8e-4bd923910d0f', N'N', 18, N'JOB_UTIL_DFS_DbSize', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_GetIndexStats @RunID', N'N', N'Y', N'1643fbbe-79d5-4d6f-abcf-9bae6338380b', N'Y', 19, N'JOB_UTIL_GetIndexStats', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_DFS_DeadlockStats ', N'N', N'Y', N'9ea424d9-14b1-43d6-bd67-32755137f188', N'Y', 20, N'JOB_JOB_UTIL_MonitorDeadlocks', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_MonitorMostCommonWaits', N'N', N'N', N'86e19be4-bf01-4353-b618-f5620a16ab55', N'Y', 21, N'JOB_UTIL_MonitorMostCommonWaits', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_ParallelMonitor', N'N', N'Y', N'adb0c1fa-5d1a-4a78-8eb3-b11e81e2e3fa', N'Y', 22, N'JOB_UTIL_ParallelMonitor', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_QryPlanStats', N'N', N'N', N'ebbad699-8d7a-4e92-b647-243ff23fbfd2', N'Y', 23, N'JOB_UTIL_QryPlanStats', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_ReorgFragmentedIndexes', N'N', N'N', N'f61e55aa-f9a6-4bd9-a8b9-482ea014658a', N'Y', 24, N'JOB_UTIL_ReorgFragmentedIndexes', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_TempDbMonitor', N'N', N'Y', N'ba42264d-083f-4974-9dbe-1c560ac16630', N'N', 25, N'JOB_UTIL_TempDbMonitor', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_DFS_WaitStats @RunID 30', N'N', N'N', N'ef3111bd-2322-4033-98f6-4674bbc03452', N'Y', 26, N'JOB_UTIL_TrackSessionWaitStats', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_TxMonitorTableStats', N'N', N'Y', N'1c151ba9-98d7-4f06-b88e-8eb1fa72493f', N'Y', 27, N'JOB_UTIL_Monitor_TPS', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_TxMonitorIDX', N'N', N'Y', N'dd4fa58c-38ed-4ace-b349-ab9b467d601c', N'Y', 28, N'JOB_UTIL_Monitor_TPS', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_MSTR_BoundQry2000', N'N', N'N', N'72908a6f-3272-4850-ac54-8f0a9abe5018', N'Y', 29, N'JOB_CaptureWorstPerfQuery', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_TempDbMonitor', N'N', N'Y', N'a1006e4a-c07d-46fe-87ad-7e168003310f', N'N', 109, N'JOB_UTIL_TempDbMonitor', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_DFS_WaitStats @RunID 30', N'N', N'N', N'4384dc46-f064-43bc-8e08-e064aca3b0a8', N'Y', 110, N'JOB_UTIL_TrackSessionWaitStats', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_TxMonitorTableStats', N'N', N'Y', N'702266b2-6ce4-4a59-a9fb-dd4ceeff7cd0', N'Y', 111, N'JOB_UTIL_Monitor_TPS', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_TxMonitorIDX', N'N', N'Y', N'a75f5977-3cda-4199-aa78-53827074c708', N'Y', 112, N'JOB_UTIL_Monitor_TPS', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_MSTR_BoundQry2000', N'N', N'N', N'f5b972b9-c7cb-44d3-ab84-2d40becc1d4d', N'Y', 141, N'JOB_CaptureWorstPerfQuery', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_UpdateQryPlansAndText ''DFS_IO_BoundQry2000''', N'N', N'N', N'652b316f-da35-468e-b7f6-02bda1c17b5c', N'Y', 142, N'JOB_UpdateQryPlans', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step02', N'UTIL_UpdateQryPlansAndText ''DFS_CPU_BoundQry2000''', N'N', N'N', N'652b316f-da35-468e-b7f6-02bda1c17b5c', N'Y', 143, N'JOB_UpdateQryPlans', 2)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step03', N'UTIL_UpdateQryPlansAndText ''DFS_IO_BoundQry''', N'N', N'N', N'652b316f-da35-468e-b7f6-02bda1c17b5c', N'Y', 144, N'JOB_UpdateQryPlans', 3)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step04', N'UTIL_UpdateQryPlansAndText ''DFS_CPU_BoundQry''', N'N', N'N', N'652b316f-da35-468e-b7f6-02bda1c17b5c', N'Y', 145, N'JOB_UpdateQryPlans', 4)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step05', N'DFS_CPU_BoundQry2000_ProcessTable', N'N', N'N', N'652b316f-da35-468e-b7f6-02bda1c17b5c', N'Y', 146, N'JOB_DFS_BoundQry_ProcessAllTables', 5)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step06', N'DFS_IO_BoundQry2000_ProcessTable', N'N', N'N', N'652b316f-da35-468e-b7f6-02bda1c17b5c', N'Y', 147, N'JOB_DFS_BoundQry_ProcessAllTables', 6)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step07', N'UTIL_DFS_CPU_BoundQry', N'N', N'N', N'652b316f-da35-468e-b7f6-02bda1c17b5c', N'Y', 148, N'JOB_DFS_BoundQry_ProcessAllTables', 7)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step08', N'UTIL_IO_BoundQry', N'N', N'N', N'652b316f-da35-468e-b7f6-02bda1c17b5c', N'Y', 149, N'JOB_DFS_BoundQry_ProcessAllTables', 8)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_CleanDFSTables', N'N', N'N', N'5a2f479c-091b-4969-8520-f69fe5b54066', N'Y', 150, N'JOB_DFS_CleanDFSTables', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'DFS_GetAllTableSizesAndRowCnt', N'N', N'N', N'91a3cefa-73e8-493d-bcde-e25fd3acb10b', N'Y', 151, N'JOB_DFS_GetAllTableSizesAndRowCnt', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_DFS_MonitorLocks', N'N', N'N', N'fd5a3191-d65e-408b-8398-c8841d19b8ff', N'Y', 152, N'JOB_DFS_MonitorLocks', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_DFS_DeadlockStats', N'N', N'Y', N'f4801c2b-d4f5-4ef7-8a78-95b8e66edac7', N'Y', 153, N'JOB_JOB_UTIL_MonitorDeadlocks', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_MonitorWorkload', N'N', N'N', N'044ea6d5-0e72-431c-9ebf-0bd81fd66411', N'Y', 154, N'JOB_MonitorWorkload', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_TxMonitorTableIndexStats', N'N', N'Y', N'164e8c2a-67d5-426e-b90c-5bd437b84b11', N'Y', 155, N'JOB_UTIL_DbMon_IndexVolitity', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_DBSpace', N'N', N'N', N'ac77f0a8-2094-4317-88b1-68e2b547b87f', N'Y', 156, N'JOB_UTIL_DBSpace', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_DBTableSpace', N'N', N'N', N'0f74969c-a766-44fa-93e3-f31ce7ef6ec6', N'Y', 157, N'JOB_UTIL_DBTableSpace', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_DFS_DbFileSizing', N'N', N'N', N'6d918491-5046-426b-b490-d6b31d517085', N'N', 158, N'JOB_UTIL_DFS_DbSize', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_GetIndexStats @RunID', N'N', N'Y', N'1ae80569-dcfd-4fd5-9239-650b3ac6fc56', N'Y', 159, N'JOB_UTIL_GetIndexStats', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_DFS_DeadlockStats ', N'N', N'Y', N'40273c83-9116-45a4-a424-b70ba19c70b8', N'Y', 160, N'JOB_JOB_UTIL_MonitorDeadlocks', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_MonitorMostCommonWaits', N'N', N'N', N'2bc61139-4e95-4ea4-8016-98e559cbe853', N'Y', 161, N'JOB_UTIL_MonitorMostCommonWaits', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_ParallelMonitor', N'N', N'Y', N'c679a84b-cf30-47b9-bf58-82588f675f2a', N'Y', 162, N'JOB_UTIL_ParallelMonitor', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_QryPlanStats', N'N', N'N', N'9c39cf2d-d1b0-4366-9a71-a9f03a92f053', N'Y', 163, N'JOB_UTIL_QryPlanStats', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_ReorgFragmentedIndexes', N'N', N'N', N'7bbcc3aa-7c0b-47b5-bfa7-c19cb09af5a3', N'Y', 164, N'JOB_UTIL_ReorgFragmentedIndexes', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_TempDbMonitor', N'N', N'Y', N'a5a1314b-8d8e-4027-a834-eb4d7355650d', N'N', 165, N'JOB_UTIL_TempDbMonitor', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_DFS_WaitStats @RunID 30', N'N', N'N', N'2526cb5d-9785-45ed-812c-39683721c986', N'Y', 166, N'JOB_UTIL_TrackSessionWaitStats', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_TxMonitorTableStats', N'N', N'Y', N'11794906-8865-4514-a661-57c6b47c0222', N'Y', 167, N'JOB_UTIL_Monitor_TPS', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_TxMonitorIDX', N'N', N'Y', N'88473c7b-e79a-4e9b-a67d-cb1076c6879a', N'Y', 168, N'JOB_UTIL_Monitor_TPS', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step07', N'UTIL_DFS_CPU_BoundQry', N'N', N'N', N'ebf76842-87f8-488e-ae13-c4cacd3a6f39', N'Y', 232, N'JOB_DFS_BoundQry_ProcessAllTables', 7)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_CleanDFSTables', N'N', N'N', N'8843fec6-9f47-4a77-a8d4-a467b7be41de', N'Y', 234, N'JOB_DFS_CleanDFSTables', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'DFS_GetAllTableSizesAndRowCnt', N'N', N'N', N'23435859-1bd5-4e1f-aaa4-6cf93f539eae', N'Y', 235, N'JOB_DFS_GetAllTableSizesAndRowCnt', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_DFS_MonitorLocks', N'N', N'N', N'4289831c-2656-4ba7-9212-b9cae9a32a44', N'Y', 236, N'JOB_DFS_MonitorLocks', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_DFS_DeadlockStats', N'N', N'Y', N'03b5ff8d-8622-4fbb-b530-c79ab8f3e85f', N'Y', 237, N'JOB_JOB_UTIL_MonitorDeadlocks', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_MonitorWorkload', N'N', N'N', N'f5da6dc4-cce7-4159-8486-d49e6e73a5b9', N'Y', 238, N'JOB_MonitorWorkload', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_TxMonitorTableIndexStats', N'N', N'Y', N'f3460d20-d1dd-49c6-a08c-5f72bf74b9c4', N'Y', 239, N'JOB_UTIL_DbMon_IndexVolitity', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_DBSpace', N'N', N'N', N'6a775a0a-a1db-4820-af5b-88f15cf18cd0', N'Y', 240, N'JOB_UTIL_DBSpace', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_DBTableSpace', N'N', N'N', N'c77ae818-7d3c-4f97-a293-fa221dc812a3', N'Y', 241, N'JOB_UTIL_DBTableSpace', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_DFS_DbFileSizing', N'N', N'N', N'1a488e87-2467-4433-b765-12e8cff6e933', N'N', 242, N'JOB_UTIL_DFS_DbSize', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_GetIndexStats @RunID', N'N', N'Y', N'c1423989-77f6-4fc7-8c4d-1800de75525b', N'Y', 243, N'JOB_UTIL_GetIndexStats', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_DFS_DeadlockStats ', N'N', N'Y', N'40606dc2-dac7-4256-86cf-5463e7e67a73', N'Y', 244, N'JOB_JOB_UTIL_MonitorDeadlocks', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_MonitorMostCommonWaits', N'N', N'N', N'640eaa80-de60-41c4-8bcb-27ba1e5c7166', N'Y', 245, N'JOB_UTIL_MonitorMostCommonWaits', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_ParallelMonitor', N'N', N'Y', N'e4366e59-c986-4a13-b680-867f154e4279', N'Y', 246, N'JOB_UTIL_ParallelMonitor', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_QryPlanStats', N'N', N'N', N'1d2b3ef1-408d-4aa7-8b2a-46eb08fb194f', N'Y', 247, N'JOB_UTIL_QryPlanStats', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_ReorgFragmentedIndexes', N'N', N'N', N'87f9f163-74e6-4f0b-a284-75355163fd11', N'Y', 248, N'JOB_UTIL_ReorgFragmentedIndexes', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_TempDbMonitor', N'N', N'Y', N'cab12745-105f-45b7-9e5c-2f8167974fdc', N'N', 249, N'JOB_UTIL_TempDbMonitor', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_DFS_WaitStats @RunID 30', N'N', N'N', N'59cd0791-aaf8-48f8-88d6-7096fd3e386b', N'Y', 250, N'JOB_UTIL_TrackSessionWaitStats', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_TxMonitorTableStats', N'N', N'Y', N'6a38d7f7-dacd-4500-a7a4-12ea687ad3a7', N'Y', 251, N'JOB_UTIL_Monitor_TPS', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_TxMonitorIDX', N'N', N'Y', N'91b25b60-a4b7-4f4d-b4be-d18d6494393a', N'Y', 252, N'JOB_UTIL_Monitor_TPS', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step1', N'sp_who3', N'Y', N'N', N'df0414cb-1661-47e5-b41f-0b5dc45de071', N'N', 282, N'JOB_TEST', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step02', N'UTIL_UpdateQryPlansAndText ''DFS_CPU_BoundQry2000''', N'N', N'N', N'7fcbceb8-cfd4-4873-9677-1f5d5ed817bb', N'Y', 171, N'JOB_UpdateQryPlans', 2)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step03', N'UTIL_UpdateQryPlansAndText ''DFS_IO_BoundQry''', N'N', N'N', N'7fcbceb8-cfd4-4873-9677-1f5d5ed817bb', N'Y', 172, N'JOB_UpdateQryPlans', 3)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step04', N'UTIL_UpdateQryPlansAndText ''DFS_CPU_BoundQry''', N'N', N'N', N'7fcbceb8-cfd4-4873-9677-1f5d5ed817bb', N'Y', 173, N'JOB_UpdateQryPlans', 4)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step05', N'DFS_CPU_BoundQry2000_ProcessTable', N'N', N'N', N'7fcbceb8-cfd4-4873-9677-1f5d5ed817bb', N'Y', 174, N'JOB_DFS_BoundQry_ProcessAllTables', 5)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step06', N'DFS_IO_BoundQry2000_ProcessTable', N'N', N'N', N'7fcbceb8-cfd4-4873-9677-1f5d5ed817bb', N'Y', 175, N'JOB_DFS_BoundQry_ProcessAllTables', 6)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step07', N'UTIL_DFS_CPU_BoundQry', N'N', N'N', N'7fcbceb8-cfd4-4873-9677-1f5d5ed817bb', N'Y', 176, N'JOB_DFS_BoundQry_ProcessAllTables', 7)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step08', N'UTIL_IO_BoundQry', N'N', N'N', N'7fcbceb8-cfd4-4873-9677-1f5d5ed817bb', N'Y', 177, N'JOB_DFS_BoundQry_ProcessAllTables', 8)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_CleanDFSTables', N'N', N'N', N'e15ceb1f-75d9-4455-950c-51d78e39dd06', N'Y', 178, N'JOB_DFS_CleanDFSTables', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'DFS_GetAllTableSizesAndRowCnt', N'N', N'N', N'9fce1f76-01b8-4851-be82-4aa0ecd5441b', N'Y', 179, N'JOB_DFS_GetAllTableSizesAndRowCnt', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_DFS_MonitorLocks', N'N', N'N', N'cc440148-dfa7-4169-a8da-0975f9049f11', N'Y', 180, N'JOB_DFS_MonitorLocks', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_DFS_DeadlockStats', N'N', N'Y', N'96aa26f5-3c21-415c-a64e-c786c31c0407', N'Y', 181, N'JOB_JOB_UTIL_MonitorDeadlocks', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_MonitorWorkload', N'N', N'N', N'6cb3d54e-69ae-4d70-8b85-efad3c1051d0', N'Y', 182, N'JOB_MonitorWorkload', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_TxMonitorTableIndexStats', N'N', N'Y', N'062aea06-153b-49b4-9bc1-41d84026817a', N'Y', 183, N'JOB_UTIL_DbMon_IndexVolitity', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_DBSpace', N'N', N'N', N'd77f16ad-bf60-4122-a5ac-e941f62d926b', N'Y', 184, N'JOB_UTIL_DBSpace', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_DBTableSpace', N'N', N'N', N'98f1e17b-c18e-4dc9-b965-6db42f34d060', N'Y', 185, N'JOB_UTIL_DBTableSpace', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_DFS_DbFileSizing', N'N', N'N', N'2b44188f-cd38-451f-89be-aad487565d7a', N'N', 186, N'JOB_UTIL_DFS_DbSize', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_GetIndexStats @RunID', N'N', N'Y', N'2250a5ee-c931-4017-b27e-9248f3dc33dd', N'Y', 187, N'JOB_UTIL_GetIndexStats', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_DFS_DeadlockStats ', N'N', N'Y', N'c9cfb88e-84e3-45fe-9159-3fc01a48da43', N'Y', 188, N'JOB_JOB_UTIL_MonitorDeadlocks', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_MonitorMostCommonWaits', N'N', N'N', N'22a33f12-a84f-4eba-bc30-56de7fa193fe', N'Y', 189, N'JOB_UTIL_MonitorMostCommonWaits', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_ParallelMonitor', N'N', N'Y', N'980e03e5-977b-44f0-8473-cfffb91357b0', N'Y', 190, N'JOB_UTIL_ParallelMonitor', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_QryPlanStats', N'N', N'N', N'36f38e66-00f4-4a0a-b201-1bbedb24f3e0', N'Y', 191, N'JOB_UTIL_QryPlanStats', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_ReorgFragmentedIndexes', N'N', N'N', N'4412fd00-eba3-496f-b3dc-36e72aae3c5d', N'Y', 192, N'JOB_UTIL_ReorgFragmentedIndexes', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_TempDbMonitor', N'N', N'Y', N'c2767c3a-bed7-4c74-b3f3-0e5d88e38cbc', N'N', 193, N'JOB_UTIL_TempDbMonitor', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_DFS_WaitStats @RunID 30', N'N', N'N', N'8b47b8e5-4b4f-43c2-94d0-3e9c1b01eb2c', N'Y', 194, N'JOB_UTIL_TrackSessionWaitStats', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_TxMonitorTableStats', N'N', N'Y', N'4b4f24ca-8b13-4ccc-9871-e298283cac86', N'Y', 195, N'JOB_UTIL_Monitor_TPS', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_TxMonitorIDX', N'N', N'Y', N'6426b370-c08d-486e-b62e-c3e0d8e865c1', N'Y', 196, N'JOB_UTIL_Monitor_TPS', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step08', N'UTIL_IO_BoundQry', N'N', N'N', N'ebf76842-87f8-488e-ae13-c4cacd3a6f39', N'Y', 233, N'JOB_DFS_BoundQry_ProcessAllTables', 8)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_MSTR_BoundQry2000', N'N', N'N', N'448f0260-3a56-4a6f-a1ea-ac4c9c605263', N'Y', 253, N'JOB_CaptureWorstPerfQuery', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_UpdateQryPlansAndText ''DFS_IO_BoundQry2000''', N'N', N'N', N'49c03dd8-f0da-43e2-8ba6-b48e11ed6453', N'Y', 254, N'JOB_UpdateQryPlans', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step02', N'UTIL_UpdateQryPlansAndText ''DFS_CPU_BoundQry2000''', N'N', N'N', N'49c03dd8-f0da-43e2-8ba6-b48e11ed6453', N'Y', 255, N'JOB_UpdateQryPlans', 2)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step03', N'UTIL_UpdateQryPlansAndText ''DFS_IO_BoundQry''', N'N', N'N', N'49c03dd8-f0da-43e2-8ba6-b48e11ed6453', N'Y', 256, N'JOB_UpdateQryPlans', 3)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step04', N'UTIL_UpdateQryPlansAndText ''DFS_CPU_BoundQry''', N'N', N'N', N'49c03dd8-f0da-43e2-8ba6-b48e11ed6453', N'Y', 257, N'JOB_UpdateQryPlans', 4)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step05', N'DFS_CPU_BoundQry2000_ProcessTable', N'N', N'N', N'49c03dd8-f0da-43e2-8ba6-b48e11ed6453', N'Y', 258, N'JOB_DFS_BoundQry_ProcessAllTables', 5)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step06', N'DFS_IO_BoundQry2000_ProcessTable', N'N', N'N', N'49c03dd8-f0da-43e2-8ba6-b48e11ed6453', N'Y', 259, N'JOB_DFS_BoundQry_ProcessAllTables', 6)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step07', N'UTIL_DFS_CPU_BoundQry', N'N', N'N', N'49c03dd8-f0da-43e2-8ba6-b48e11ed6453', N'Y', 260, N'JOB_DFS_BoundQry_ProcessAllTables', 7)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step08', N'UTIL_IO_BoundQry', N'N', N'N', N'49c03dd8-f0da-43e2-8ba6-b48e11ed6453', N'Y', 261, N'JOB_DFS_BoundQry_ProcessAllTables', 8)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_CleanDFSTables', N'N', N'N', N'217899bc-4071-4b75-a8c7-5f0284af3357', N'Y', 262, N'JOB_DFS_CleanDFSTables', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'DFS_GetAllTableSizesAndRowCnt', N'N', N'N', N'942b8bdf-f031-4ab6-809b-329bfcacf195', N'Y', 263, N'JOB_DFS_GetAllTableSizesAndRowCnt', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_DFS_MonitorLocks', N'N', N'N', N'92eb136a-dcff-4249-bf35-ad5cd118d215', N'Y', 264, N'JOB_DFS_MonitorLocks', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_DFS_DeadlockStats', N'N', N'Y', N'a60d4078-74dd-48fd-a245-26002f55061a', N'Y', 265, N'JOB_JOB_UTIL_MonitorDeadlocks', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_MonitorWorkload', N'N', N'N', N'e49fd974-48b9-4d2d-9d77-449b89bacda3', N'Y', 266, N'JOB_MonitorWorkload', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_TxMonitorTableIndexStats', N'N', N'Y', N'410b1946-bc26-4684-9fbf-561b6807f7c8', N'Y', 267, N'JOB_UTIL_DbMon_IndexVolitity', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_DBSpace', N'N', N'N', N'5fd418b9-e3ef-4354-91d4-7c12e351b152', N'Y', 268, N'JOB_UTIL_DBSpace', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_DBTableSpace', N'N', N'N', N'3491e4f1-54fb-4a08-81a8-ee0f26b0f46b', N'Y', 269, N'JOB_UTIL_DBTableSpace', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_DFS_DbFileSizing', N'N', N'N', N'52f96d9f-5789-427c-ad76-0b7a4d23b8fc', N'N', 270, N'JOB_UTIL_DFS_DbSize', 1)
 
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_GetIndexStats @RunID', N'N', N'Y', N'c9bed2a3-8b1e-489d-a255-166f267d8ba7', N'Y', 271, N'JOB_UTIL_GetIndexStats', 1)
 
SET IDENTITY_INSERT [dbo].[ActiveJobStep] OFF
 
INSERT [dbo].[ActiveServers] ([GroupName], [isAzure], [SvrName], [DBName], [UserID], [pwd], [UID], [Enable]) VALUES (N'TESTGROUP', N'Y', N'dfin.database.windows.net,1433', N'TestAzureDB', N'wmiller', N'Junebug1', N'd136a0b9-8c23-4672-96ca-1d7e5376f5ac', 1)
 
INSERT [dbo].[ActiveServers] ([GroupName], [isAzure], [SvrName], [DBName], [UserID], [pwd], [UID], [Enable]) VALUES (N'TESTGROUP', N'Y', N'dfin.database.windows.net,1433', N'AW_AZURE', N'wmiller', N'Junebug1', N'540abc6c-9126-4039-bc68-7a18b99e3828', 1)
 
INSERT [dbo].[ActiveServers] ([GroupName], [isAzure], [SvrName], [DBName], [UserID], [pwd], [UID], [Enable]) VALUES (N'TESTGROUP', N'N', N'ALIEN15', N'AW2016', N'sa', N'Junebug1', N'a5434278-70b0-4163-af44-29d57e6e15bb', 1)
 
INSERT [dbo].[ActiveServers] ([GroupName], [isAzure], [SvrName], [DBName], [UserID], [pwd], [UID], [Enable]) VALUES (N'TESTGROUP', N'N', N'ALIEN15', N'WDM', N'sa', N'Junebug1', N'f7bad9c7-8d54-4c42-8cad-473dd7664a81', 1)
 
INSERT [dbo].[ActiveServers] ([GroupName], [isAzure], [SvrName], [DBName], [UserID], [pwd], [UID], [Enable]) VALUES (N'TESTGROUP', N'N', N'ALIEN15', N'TestDB', N'sa', N'Junebug1', N'8c9cc515-dd09-4d6f-835f-741ff39aabb9', 1)
 
INSERT [dbo].[ActiveServers] ([GroupName], [isAzure], [SvrName], [DBName], [UserID], [pwd], [UID], [Enable]) VALUES (N'TESTGROUP', N'N', N'ALIEN15', N'PowerDatabase', N'sa', N'Junebug1', N'32324e2d-a1b3-4928-84b1-007ad258bf76', 1)
 
INSERT [dbo].[ActiveServers] ([GroupName], [isAzure], [SvrName], [DBName], [UserID], [pwd], [UID], [Enable]) VALUES (N'TESTGROUP', N'N', N'SVR2016', N'DFINAnalytics', N'sa', N'Junebug1', N'4e5e7364-5484-4f24-a5a2-df15fc175be4', 1)
 
INSERT [dbo].[ActiveServers] ([GroupName], [isAzure], [SvrName], [DBName], [UserID], [pwd], [UID], [Enable]) VALUES (N'TESTGROUP', N'N', N'SVR2016', N'DFS', N'sa', N'Junebug1', N'7b2c9ee4-2f62-44b5-87fb-33de848ca871', 1)
 
INSERT [dbo].[ActiveServers] ([GroupName], [isAzure], [SvrName], [DBName], [UserID], [pwd], [UID], [Enable]) VALUES (N'TESTGROUP', N'N', N'SVR2016', N'MstrData', N'sa', N'Junebug1', N'b43dbc4d-4b1b-46cc-96c4-1ccfdfb40696', 1)
 
INSERT [dbo].[ActiveServers] ([GroupName], [isAzure], [SvrName], [DBName], [UserID], [pwd], [UID], [Enable]) VALUES (N'TESTGROUP', N'N', N'SVR2016', N'MstrPort', N'sa', N'Junebug1', N'e0ba728f-71e2-4a04-8d37-d55b276c8ac9', 1)
 
INSERT [dbo].[ActiveServers] ([GroupName], [isAzure], [SvrName], [DBName], [UserID], [pwd], [UID], [Enable]) VALUES (N'TESTGROUP', N'N', N'SVR2016', N'MstrLog', N'sa', N'Junebug1', N'a6ba3c9a-a71d-424b-8556-171cdae6fb16', 1)
 
INSERT [dbo].[ActiveServers] ([GroupName], [isAzure], [SvrName], [DBName], [UserID], [pwd], [UID], [Enable]) VALUES (N'TESTGROUP', N'N', N'SVR2016', N'TestXml', N'sa', N'Junebug1', N'f4e1e59f-9efc-4121-9032-3ab5c2fca608', 1)
 
INSERT [dbo].[ActiveServers] ([GroupName], [isAzure], [SvrName], [DBName], [UserID], [pwd], [UID], [Enable]) VALUES (N'TESTGROUP', N'N', N'SVR2016', N'AW_VMWARE', N'sa', N'Junebug1', N'a028ecba-2f97-4595-b0fc-3b1a142bc689', 1)
 

end

/****************** PROCESSING FILE *************************************/

GO  
PRINT 'ID# 304'  
print 'D:\dev\SQL\DFINAnalytics\UTIL_SSIS_RunStats.sql' 

GO

/*
drop TABLE DFS_SSIS_RunStats
*/

IF EXISTS
(
    SELECT 1
    FROM sys.tables
    WHERE name = 'DFS_SSIS_RunStats'
)
    DROP TABLE DFS_SSIS_RunStats;
GO
BEGIN
    CREATE TABLE DFS_SSIS_RunStats
    (SVRNAME        NVARCHAR(150) NOT NULL, 
     DBNAME         NVARCHAR(150) NOT NULL, 
     STEP_Name      NVARCHAR(150) NOT NULL, 
     StartTime      DATETIME DEFAULT GETDATE() NOT NULL, 
     EndTime        DATETIME, 
     ElapsedSeconds INT NULL, 
     RowsProcessed  INT NULL
                        DEFAULT 0, 
     [UID]          UNIQUEIDENTIFIER NOT NULL
    );
    CREATE INDEX piDFS_SSIS_RunStats ON DFS_SSIS_RunStats(UID);
END;
GO
IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'UTIL_SSIS_RunStats'
)
    BEGIN
        DROP PROCEDURE UTIL_SSIS_RunStats;
END;
GO

/*

delete from DFS_SSIS_RunStats;

exec UTIL_SSIS_RunStats 'TEST_ENTRY3', 0, 'DFS_QryOptStats' ;
exec UTIL_SSIS_RunStats 'TEST_ENTRY3', 0, 'DFS_QryOptStats' ;

select * from DFS_SSIS_RunStats order by EndTime desc, Step_NAme, SvrName, DBNAME,starttime ;

update DFS_SSIS_RunStats set ElapsedSeconds = datediff(second, StartTime,EndTime) where ElapsedSeconds is null;
select *, datediff(second, StartTime,EndTime) as ET from DFS_SSIS_RunStats ;

select SvrName, DBName, count(*) as cnt 
	from DFS_SSIS_RunStats group by SvrName, DBNAME;

*/

CREATE PROCEDURE UTIL_SSIS_RunStats
(@StepName      NVARCHAR(150), 
 @RowsProcessed INT, 
 @TableToTrack  NVARCHAR(150) = NULL
)
AS
    BEGIN
        IF(DB_NAME() = 'DFINAnalytics')
            BEGIN
                PRINT 'CANNOT RUN proc UTIL_SSIS_RunStats against database DFINAnalytics, returning';
                RETURN;
        END;
        DECLARE @i INT= 0;
        SET @i =
        (
            SELECT COUNT(1)
            FROM DFS_SSIS_RunStats
            WHERE STEP_Name = @StepName
                  AND EndTime IS NULL
        );
        IF(@i = 0)
            BEGIN
                DECLARE @cnt INT= 0;
                IF(@TableToTrack IS NOT NULL)
                    BEGIN
                        DECLARE @sqlBody VARCHAR(500), @TableCount INT, @SQL NVARCHAR(1000);
                        SELECT @sqlBody = 'from ' + @TableToTrack;
                        SELECT @SQL = N'SELECT @TableCount = COUNT(*) ' + @sqlBody;
                        EXEC sp_executesql 
                             @SQL, 
                             N'@TableCount INT OUTPUT', 
                             @TableCount OUTPUT;
                        SET @cnt = @TableCount;
                        PRINT 'Rows in' + '@cnt = ' + CAST(@cnt AS NVARCHAR(50));
                        INSERT INTO DFS_SSIS_RunStats
                        (SVRNAME, 
                         DBNAME, 
                         STEP_Name, 
                         StartTime, 
                         EndTime, 
                         RowsProcessed, 
                         [UID]
                        )
                        VALUES
                        (@@SERVERNAME, 
                         DB_NAME(), 
                         @StepName, 
                         GETDATE(), 
                         NULL, 
                         @cnt, 
                         NEWID()
                        );
                END;
                    ELSE
                    BEGIN
                        SET @cnt = @RowsProcessed;
                        INSERT INTO DFS_SSIS_RunStats
                        (SVRNAME, 
                         DBNAME, 
                         STEP_Name, 
                         StartTime, 
                         EndTime, 
                         RowsProcessed, 
                         [UID]
                        )
                        VALUES
                        (@@SERVERNAME, 
                         DB_NAME(), 
                         @StepName, 
                         GETDATE(), 
                         NULL, 
                         @cnt, 
                         NEWID()
                        );
                END;
        END;
            ELSE
            BEGIN
                IF(@TableToTrack IS NULL)
                    BEGIN
                        UPDATE DFS_SSIS_RunStats
                          SET 
                              EndTime = GETDATE(), 
                              RowsProcessed = @RowsProcessed
                        WHERE STEP_Name = @StepName
                              AND EndTime IS NULL;
                END;
                    ELSE
                    BEGIN
                        UPDATE DFS_SSIS_RunStats
                          SET 
                              EndTime = GETDATE()
                        WHERE STEP_Name = @StepName
                              AND EndTime IS NULL;
                END;
        END;
    END;
GO
IF EXISTS
(
    SELECT *
    FROM sys.objects
    WHERE [name] = N'trgUpdate_DFS_SSIS_RunStats'
          AND [type] = 'TR'
)
    BEGIN
        DROP TRIGGER [trgUpdate_DFS_SSIS_RunStats];
END;
GO
CREATE TRIGGER [dbo].[trgUpdate_DFS_SSIS_RunStats] ON [DFS_SSIS_RunStats]
FOR UPDATE
AS
     BEGIN
         UPDATE DFS_SSIS_RunStats
           SET 
               DFS_SSIS_RunStats.ElapsedSeconds = DATEDIFF(second, DFS_SSIS_RunStats.StartTime, DFS_SSIS_RunStats.EndTime)
         FROM inserted
         WHERE DFS_SSIS_RunStats.[uid] = inserted.[UID];
     END;
GO
GO
INSERT INTO [dbo].[DFS_QryOptStatsExistingHashes]
       SELECT DISTINCT 
              [query_hash], 
              [query_plan_hash]
       FROM [dbo].[DFS_QryOptStats];
IF EXISTS
(
    SELECT 1
    FROM sys.tables
    WHERE name = 'DFS_QryOptStatsExistingHashes'
)
    DROP TABLE [dbo].[DFS_QryOptStatsExistingHashes];
GO
CREATE TABLE [dbo].[DFS_QryOptStatsExistingHashes]
([query_hash]      [BINARY](8) NULL, 
 [query_plan_hash] [BINARY](8) NULL
)
ON [PRIMARY];
CREATE UNIQUE INDEX pkDFS_QryOptStatsExistingHashes ON DFS_QryOptStatsExistingHashes([query_hash], [query_plan_hash]);
GO
IF EXISTS
(
    SELECT 1
    FROM sys.views
    WHERE name = 'viewQryOptStatsWOExistingHashes'
)
    DROP VIEW viewQryOptStatsWOExistingHashes;
GO

/*
insert into DFS_QryOptStatsExistingHashes
	select distinct [query_hash],[query_plan_hash] from [dbo].[DFS_QryOptStats];
		
select count(*) from [dbo].[DFS_QryOptStats]
select * from viewQryOptStatsWOExistingHashes
*/

CREATE VIEW viewQryOptStatsWOExistingHashes
AS
     SELECT t1.[SvrName], 
            t1.[schemaname], 
            t1.[viewname], 
            t1.[viewid], 
            t1.[databasename], 
            t1.[databaseid], 
            t1.[text], 
            t1.[query_plan], 
            t1.[sql_handle], 
            t1.[statement_start_offset], 
            t1.[statement_end_offset], 
            t1.[plan_generation_num], 
            t1.[plan_handle], 
            t1.[creation_time], 
            t1.[last_execution_time], 
            t1.[execution_count], 
            t1.[total_worker_time], 
            t1.[last_worker_time], 
            t1.[min_worker_time], 
            t1.[max_worker_time], 
            t1.[total_physical_reads], 
            t1.[last_physical_reads], 
            t1.[min_physical_reads], 
            t1.[max_physical_reads], 
            t1.[total_logical_writes], 
            t1.[last_logical_writes], 
            t1.[min_logical_writes], 
            t1.[max_logical_writes], 
            t1.[total_logical_reads], 
            t1.[last_logical_reads], 
            t1.[min_logical_reads], 
            t1.[max_logical_reads], 
            t1.[total_clr_time], 
            t1.[last_clr_time], 
            t1.[min_clr_time], 
            t1.[max_clr_time], 
            t1.[total_elapsed_time], 
            t1.[last_elapsed_time], 
            t1.[min_elapsed_time], 
            t1.[max_elapsed_time], 
            t1.[query_hash], 
            t1.[query_plan_hash], 
            t1.[total_rows], 
            t1.[last_rows], 
            t1.[min_rows], 
            t1.[max_rows], 
            t1.[statement_sql_handle], 
            t1.[statement_context_id], 
            t1.[total_dop], 
            t1.[last_dop], 
            t1.[min_dop], 
            t1.[max_dop], 
            t1.[total_grant_kb], 
            t1.[last_grant_kb], 
            t1.[min_grant_kb], 
            t1.[max_grant_kb], 
            t1.[total_used_grant_kb], 
            t1.[last_used_grant_kb], 
            t1.[min_used_grant_kb], 
            t1.[max_used_grant_kb], 
            t1.[total_ideal_grant_kb], 
            t1.[last_ideal_grant_kb], 
            t1.[min_ideal_grant_kb], 
            t1.[max_ideal_grant_kb], 
            t1.[total_reserved_threads], 
            t1.[last_reserved_threads], 
            t1.[min_reserved_threads], 
            t1.[max_reserved_threads], 
            t1.[total_used_threads], 
            t1.[last_used_threads], 
            t1.[min_used_threads], 
            t1.[max_used_threads], 
            t1.[total_columnstore_segment_reads], 
            t1.[last_columnstore_segment_reads], 
            t1.[min_columnstore_segment_reads], 
            t1.[max_columnstore_segment_reads], 
            t1.[total_columnstore_segment_skips], 
            t1.[last_columnstore_segment_skips], 
            t1.[min_columnstore_segment_skips], 
            t1.[max_columnstore_segment_skips], 
            t1.[total_spills], 
            t1.[last_spills], 
            t1.[min_spills], 
            t1.[max_spills], 
            t1.[RunDate], 
            t1.[SSVER], 
            t1.[UID]
     FROM [dbo].[DFS_QryOptStats] T1
          LEFT JOIN [dbo].[DFS_QryOptStatsExistingHashes] T2 ON T1.query_hash = T2.query_hash
                                                                AND T1.query_plan_hash = T2.query_plan_hash
     WHERE T2.query_hash IS NULL;
GO
IF EXISTS
(
    SELECT 1
    FROM sys.views
    WHERE name = 'viewQrysPlansWOExistingHashes'
)
    DROP VIEW viewQrysPlansWOExistingHashes;
GO

/*
insert into DFS_QryOptStatsExistingHashes
	select distinct [query_hash],[query_plan_hash] from [dbo].[DFS_QryOptStats];
		
select count(*) from [DFS_QrysPlans]
select * from viewQrysPlansWOExistingHashes
*/

CREATE VIEW viewQrysPlansWOExistingHashes
AS
     SELECT T1.[query_hash], 
            t1.[query_plan_hash], 
            t1.[UID], 
            t1.[PerfType], 
            t1.[text], 
            t1.[query_plan], 
            t1.[CreateDate]
     FROM [dbo].[DFS_QrysPlans] T1
          LEFT JOIN [dbo].[DFS_QryOptStatsExistingHashes] T2 ON T1.query_hash = T2.query_hash
                                                                AND T1.query_plan_hash = T2.query_plan_hash
     WHERE T2.query_hash IS NULL;
GO

/****************** PROCESSING FILE *************************************/

GO  
PRINT 'ID# 305'  
print 'D:\dev\SQL\DFINAnalytics\viewDFS_QryOptStats.sql' 

go

if exists (select 1 from INFORMATION_SCHEMA.tables where TABLE_NAME = 'viewDFS_QryOptStats')
drop view viewDFS_QryOptStats
go
/*
	select * from viewDFS_QryOptStats
*/
create view viewDFS_QryOptStats
as
select  [schemaname]
      ,[viewname]
      ,[viewid]
      ,[databasename]
      ,[databaseid]
      ,[sql_handle]
      ,[statement_start_offset]
      ,[statement_end_offset]
      ,[plan_generation_num]
      ,[plan_handle]
      ,[creation_time]
      ,[last_execution_time]
      ,[execution_count]
      ,[total_worker_time]
      ,[last_worker_time]
      ,[min_worker_time]
      ,[max_worker_time]
      ,[total_physical_reads]
      ,[last_physical_reads]
      ,[min_physical_reads]
      ,[max_physical_reads]
      ,[total_logical_writes]
      ,[last_logical_writes]
      ,[min_logical_writes]
      ,[max_logical_writes]
      ,[total_logical_reads]
      ,[last_logical_reads]
      ,[min_logical_reads]
      ,[max_logical_reads]
      ,[total_clr_time]
      ,[last_clr_time]
      ,[min_clr_time]
      ,[max_clr_time]
      ,[total_elapsed_time]
      ,[last_elapsed_time]
      ,[min_elapsed_time]
      ,[max_elapsed_time]
      ,[query_hash]
      ,[query_plan_hash]
      ,[total_rows]
      ,[last_rows]
      ,[min_rows]
      ,[max_rows]
      ,[statement_sql_handle]
      ,[statement_context_id]
      ,[total_dop]
      ,[last_dop]
      ,[min_dop]
      ,[max_dop]
      ,[total_grant_kb]
      ,[last_grant_kb]
      ,[min_grant_kb]
      ,[max_grant_kb]
      ,[total_used_grant_kb]
      ,[last_used_grant_kb]
      ,[min_used_grant_kb]
      ,[max_used_grant_kb]
      ,[total_ideal_grant_kb]
      ,[last_ideal_grant_kb]
      ,[min_ideal_grant_kb]
      ,[max_ideal_grant_kb]
      ,[total_reserved_threads]
      ,[last_reserved_threads]
      ,[min_reserved_threads]
      ,[max_reserved_threads]
      ,[total_used_threads]
      ,[last_used_threads]
      ,[min_used_threads]
      ,[max_used_threads]
      ,[total_columnstore_segment_reads]
      ,[last_columnstore_segment_reads]
      ,[min_columnstore_segment_reads]
      ,[max_columnstore_segment_reads]
      ,[total_columnstore_segment_skips]
      ,[last_columnstore_segment_skips]
      ,[min_columnstore_segment_skips]
      ,[max_columnstore_segment_skips]
      ,[total_spills]
      ,[last_spills]
      ,[min_spills]
      ,[max_spills]
      ,[RunDate]
      ,[SSVER]
      ,[UID]
  FROM [DFS_QryOptStats]
  go
  go

if exists (select 1 from INFORMATION_SCHEMA.tables where TABLE_NAME = 'viewDFS_QryOptStatsPlanText')
drop view viewDFS_QryOptStatsPlanText
go
/*
	select * from viewDFS_QryOptStatsPlanText
*/
create view viewDFS_QryOptStatsPlanText
as
select  [query_hash]
	    , [query_plan_hash]
		, '-' as [PerfType]
		, [text]
		, [query_plan]
        , [UID]
  FROM [DFS_QryOptStats]
  go


/****************** PROCESSING FILE *************************************/

GO  
PRINT 'ID# 306'  
print 'D:\dev\SQL\DFINAnalytics\UTIL_RecordGrowthHistory.sql' 



go
/*
select 'set @icnt = (select count(*) from ['+name+']);' +char(10) +
'insert into DFS_RecordGrowthHistory (TblName, NbrRows) values  ('''+name+''', @icnt) ; ' as cmd 
from sys.tables 
where name not in ('sysdiagrams', 'sysssislog')
order by name ;

select * from DFS_RecordGrowthHistory order by TblName, CreateDate desc

drop table DFS_RecordGrowthHistory;
*/

go
if not exists (select 1 from sys.tables where name = 'DFS_RecordGrowthHistory') 
create table DFS_RecordGrowthHistory (
	TblName nvarchar(150) not null,
	SvrName  nvarchar(150) null,
	DBNAme  nvarchar(150) null,
	NbrRows bigint ,
	CreateDate datetime null default getdate()
)

go

if exists (select 1 from sys.procedures where name = 'UTIL_RecordGrowthHistory')
	drop procedure UTIL_RecordGrowthHistory;
go

/*
exec UTIL_RecordGrowthHistory ;
*/
create procedure UTIL_RecordGrowthHistory
AS
BEGIN

		declare @icnt int = 0 ;

		set @icnt = (select count(*) from [ActiveJob]);
		insert into DFS_RecordGrowthHistory (TblName, NbrRows) values  ('ActiveJob', @icnt) ; 
		set @icnt = (select count(*) from [ActiveJobExecutions]);
		insert into DFS_RecordGrowthHistory (TblName, NbrRows) values  ('ActiveJobExecutions', @icnt) ; 
		set @icnt = (select count(*) from [ActiveJobSchedule]);
		insert into DFS_RecordGrowthHistory (TblName, NbrRows) values  ('ActiveJobSchedule', @icnt) ; 
		set @icnt = (select count(*) from [ActiveJobStep]);
		insert into DFS_RecordGrowthHistory (TblName, NbrRows) values  ('ActiveJobStep', @icnt) ; 
		set @icnt = (select count(*) from [ActiveServers]);
		insert into DFS_RecordGrowthHistory (TblName, NbrRows) values  ('ActiveServers', @icnt) ; 
		set @icnt = (select count(*) from [DFIN_TRACKED_DATABASE_PROCS]);
		insert into DFS_RecordGrowthHistory (TblName, NbrRows) values  ('DFIN_TRACKED_DATABASE_PROCS', @icnt) ; 
		set @icnt = (select count(*) from [DFIN_TRACKED_DATABASES]);
		insert into DFS_RecordGrowthHistory (TblName, NbrRows) values  ('DFIN_TRACKED_DATABASES', @icnt) ; 
		set @icnt = (select count(*) from [DFS_$ActiveDatabases]);
		insert into DFS_RecordGrowthHistory (TblName, NbrRows) values  ('DFS_$ActiveDatabases', @icnt) ; 
		set @icnt = (select count(*) from [DFS_BlockingHistory]);
		insert into DFS_RecordGrowthHistory (TblName, NbrRows) values  ('DFS_BlockingHistory', @icnt) ; 
		set @icnt = (select count(*) from [DFS_CleanedDFSTables]);
		insert into DFS_RecordGrowthHistory (TblName, NbrRows) values  ('DFS_CleanedDFSTables', @icnt) ; 
		set @icnt = (select count(*) from [DFS_CPU_BoundQry]);
		insert into DFS_RecordGrowthHistory (TblName, NbrRows) values  ('DFS_CPU_BoundQry', @icnt) ; 
		set @icnt = (select count(*) from [DFS_CPU_BoundQry2000]);
		insert into DFS_RecordGrowthHistory (TblName, NbrRows) values  ('DFS_CPU_BoundQry2000', @icnt) ; 
		set @icnt = (select count(*) from [DFS_DB2Skip]);
		insert into DFS_RecordGrowthHistory (TblName, NbrRows) values  ('DFS_DB2Skip', @icnt) ; 
		set @icnt = (select count(*) from [DFS_DbFileSizing]);
		insert into DFS_RecordGrowthHistory (TblName, NbrRows) values  ('DFS_DbFileSizing', @icnt) ; 
		set @icnt = (select count(*) from [DFS_DBSpace]);
		insert into DFS_RecordGrowthHistory (TblName, NbrRows) values  ('DFS_DBSpace', @icnt) ; 
		set @icnt = (select count(*) from [DFS_DBTableSpace]);
		insert into DFS_RecordGrowthHistory (TblName, NbrRows) values  ('DFS_DBTableSpace', @icnt) ; 
		set @icnt = (select count(*) from [DFS_DBVersion]);
		insert into DFS_RecordGrowthHistory (TblName, NbrRows) values  ('DFS_DBVersion', @icnt) ; 
		set @icnt = (select count(*) from [DFS_DeadlockStats]);
		insert into DFS_RecordGrowthHistory (TblName, NbrRows) values  ('DFS_DeadlockStats', @icnt) ; 
		set @icnt = (select count(*) from [DFS_IndexFragErrors]);
		insert into DFS_RecordGrowthHistory (TblName, NbrRows) values  ('DFS_IndexFragErrors', @icnt) ; 
		set @icnt = (select count(*) from [DFS_IndexFragHist]);
		insert into DFS_RecordGrowthHistory (TblName, NbrRows) values  ('DFS_IndexFragHist', @icnt) ; 
		set @icnt = (select count(*) from [DFS_IndexFragProgress]);
		insert into DFS_RecordGrowthHistory (TblName, NbrRows) values  ('DFS_IndexFragProgress', @icnt) ; 
		set @icnt = (select count(*) from [DFS_IndexFragReorgHistory]);
		insert into DFS_RecordGrowthHistory (TblName, NbrRows) values  ('DFS_IndexFragReorgHistory', @icnt) ; 
		set @icnt = (select count(*) from [DFS_IndexReorgCmds]);
		insert into DFS_RecordGrowthHistory (TblName, NbrRows) values  ('DFS_IndexReorgCmds', @icnt) ; 
		set @icnt = (select count(*) from [DFS_IndexStats]);
		insert into DFS_RecordGrowthHistory (TblName, NbrRows) values  ('DFS_IndexStats', @icnt) ; 
		set @icnt = (select count(*) from [DFS_IO_BoundQry]);
		insert into DFS_RecordGrowthHistory (TblName, NbrRows) values  ('DFS_IO_BoundQry', @icnt) ; 
		set @icnt = (select count(*) from [DFS_IO_BoundQry2000]);
		insert into DFS_RecordGrowthHistory (TblName, NbrRows) values  ('DFS_IO_BoundQry2000', @icnt) ; 
		set @icnt = (select count(*) from [DFS_MissingFKIndexes]);
		insert into DFS_RecordGrowthHistory (TblName, NbrRows) values  ('DFS_MissingFKIndexes', @icnt) ; 
		set @icnt = (select count(*) from [DFS_MissingIndexes]);
		insert into DFS_RecordGrowthHistory (TblName, NbrRows) values  ('DFS_MissingIndexes', @icnt) ; 
		set @icnt = (select count(*) from [DFS_MonitorMostCommonWaits]);
		insert into DFS_RecordGrowthHistory (TblName, NbrRows) values  ('DFS_MonitorMostCommonWaits', @icnt) ; 
		set @icnt = (select count(*) from [DFS_ParallelMonitor]);
		insert into DFS_RecordGrowthHistory (TblName, NbrRows) values  ('DFS_ParallelMonitor', @icnt) ; 
		set @icnt = (select count(*) from [DFS_PerfMonitor]);
		insert into DFS_RecordGrowthHistory (TblName, NbrRows) values  ('DFS_PerfMonitor', @icnt) ; 
		set @icnt = (select count(*) from [DFS_PowershellJobSchedule]);
		insert into DFS_RecordGrowthHistory (TblName, NbrRows) values  ('DFS_PowershellJobSchedule', @icnt) ; 
		set @icnt = (select count(*) from [DFS_PullCounts]);
		insert into DFS_RecordGrowthHistory (TblName, NbrRows) values  ('DFS_PullCounts', @icnt) ; 
		set @icnt = (select count(*) from [DFS_QryOptStats]);
		insert into DFS_RecordGrowthHistory (TblName, NbrRows) values  ('DFS_QryOptStats', @icnt) ; 
		set @icnt = (select count(*) from [DFS_QryOptStatsExistingHashes]);
		insert into DFS_RecordGrowthHistory (TblName, NbrRows) values  ('DFS_QryOptStatsExistingHashes', @icnt) ; 
		set @icnt = (select count(*) from [DFS_QryOptStatsHistory]);
		insert into DFS_RecordGrowthHistory (TblName, NbrRows) values  ('DFS_QryOptStatsHistory', @icnt) ; 
		set @icnt = (select count(*) from [DFS_QryPlanBridge]);
		insert into DFS_RecordGrowthHistory (TblName, NbrRows) values  ('DFS_QryPlanBridge', @icnt) ; 
		set @icnt = (select count(*) from [DFS_QrysPlans]);
		insert into DFS_RecordGrowthHistory (TblName, NbrRows) values  ('DFS_QrysPlans', @icnt) ; 
		set @icnt = (select count(*) from [DFS_RecordCount]);
		insert into DFS_RecordGrowthHistory (TblName, NbrRows) values  ('DFS_RecordCount', @icnt) ; 
		set @icnt = (select count(*) from [DFS_RecordGrowthHistory]);
		insert into DFS_RecordGrowthHistory (TblName, NbrRows) values  ('DFS_RecordGrowthHistory', @icnt) ; 
		set @icnt = (select count(*) from [DFS_SEQ]);
		insert into DFS_RecordGrowthHistory (TblName, NbrRows) values  ('DFS_SEQ', @icnt) ; 
		set @icnt = (select count(*) from [DFS_SequenceTABLE]);
		insert into DFS_RecordGrowthHistory (TblName, NbrRows) values  ('DFS_SequenceTABLE', @icnt) ; 
		set @icnt = (select count(*) from [DFS_SSIS_RunStats]);
		insert into DFS_RecordGrowthHistory (TblName, NbrRows) values  ('DFS_SSIS_RunStats', @icnt) ; 
		set @icnt = (select count(*) from [DFS_SsisExecHist]);
		insert into DFS_RecordGrowthHistory (TblName, NbrRows) values  ('DFS_SsisExecHist', @icnt) ; 
		set @icnt = (select count(*) from [DFS_TableGrowthHistory]);
		insert into DFS_RecordGrowthHistory (TblName, NbrRows) values  ('DFS_TableGrowthHistory', @icnt) ; 
		set @icnt = (select count(*) from [DFS_TableReadWrites]);
		insert into DFS_RecordGrowthHistory (TblName, NbrRows) values  ('DFS_TableReadWrites', @icnt) ; 
		set @icnt = (select count(*) from [DFS_TableSizeAndRowCnt]);
		insert into DFS_RecordGrowthHistory (TblName, NbrRows) values  ('DFS_TableSizeAndRowCnt', @icnt) ; 
		set @icnt = (select count(*) from [DFS_TableStats]);
		insert into DFS_RecordGrowthHistory (TblName, NbrRows) values  ('DFS_TableStats', @icnt) ; 
		set @icnt = (select count(*) from [DFS_TempDbMonitor]);
		insert into DFS_RecordGrowthHistory (TblName, NbrRows) values  ('DFS_TempDbMonitor', @icnt) ; 
		set @icnt = (select count(*) from [DFS_TempProcErrors]);
		insert into DFS_RecordGrowthHistory (TblName, NbrRows) values  ('DFS_TempProcErrors', @icnt) ; 
		set @icnt = (select count(*) from [DFS_TestDBContext]);
		insert into DFS_RecordGrowthHistory (TblName, NbrRows) values  ('DFS_TestDBContext', @icnt) ; 
		set @icnt = (select count(*) from [DFS_TranLocks]);
		insert into DFS_RecordGrowthHistory (TblName, NbrRows) values  ('DFS_TranLocks', @icnt) ; 
		set @icnt = (select count(*) from [DFS_TxMonitorIDX]);
		insert into DFS_RecordGrowthHistory (TblName, NbrRows) values  ('DFS_TxMonitorIDX', @icnt) ; 
		set @icnt = (select count(*) from [DFS_TxMonitorTableIndexStats]);
		insert into DFS_RecordGrowthHistory (TblName, NbrRows) values  ('DFS_TxMonitorTableIndexStats', @icnt) ; 
		set @icnt = (select count(*) from [DFS_TxMonitorTableStats]);
		insert into DFS_RecordGrowthHistory (TblName, NbrRows) values  ('DFS_TxMonitorTableStats', @icnt) ; 
		set @icnt = (select count(*) from [DFS_TxMonitorTblUpdates]);
		insert into DFS_RecordGrowthHistory (TblName, NbrRows) values  ('DFS_TxMonitorTblUpdates', @icnt) ; 
		set @icnt = (select count(*) from [DFS_WaitStats]);
		insert into DFS_RecordGrowthHistory (TblName, NbrRows) values  ('DFS_WaitStats', @icnt) ; 
		set @icnt = (select count(*) from [DFS_WaitTypes]);
		insert into DFS_RecordGrowthHistory (TblName, NbrRows) values  ('DFS_WaitTypes', @icnt) ; 
		set @icnt = (select count(*) from [DFS_Workload]);
		insert into DFS_RecordGrowthHistory (TblName, NbrRows) values  ('DFS_Workload', @icnt) ; 
		set @icnt = (select count(*) from [SequenceTABLE]);
		insert into DFS_RecordGrowthHistory (TblName, NbrRows) values  ('SequenceTABLE', @icnt) ; 

end
go


/****************** PROCESSING FILE *************************************/

GO  
PRINT 'ID# 307'  
print 'D:\dev\SQL\DFINAnalytics\_populateActiveServersTable.sql' 

-- select * from [ActiveServers]
-- delete from [ActiveServers]

declare @AddActiveServers as int = 1 ;

if (@AddActiveServers = 1 and db_name() = 'DFINAnalytics')
begin
		delete from [dbo].[ActiveServers] where DBNAME in ('TestAzureDB'
			,'AW_AZURE'
			,'AW2016'
			,'DFINAnalytics'
			,'DFS','MstrData','MstrPort','MstrLog' ,'TestXml','AW_VMWARE','PowerDatabase','TestDB', 'WDM');

		INSERT INTO [dbo].[ActiveServers]([GroupName], [isAzure],[SvrName],[DBName],[UserID],[pwd], [UID]) VALUES
		('TESTGROUP','Y','dfin.database.windows.net,1433','TestAzureDB','wmiller','Junebug1', newid())
		INSERT INTO [dbo].[ActiveServers]([GroupName], [isAzure],[SvrName],[DBName],[UserID],[pwd], [UID]) VALUES
		('TESTGROUP','Y','dfin.database.windows.net,1433','AW_AZURE','wmiller','Junebug1', newid())

		INSERT INTO [dbo].[ActiveServers]([GroupName], [isAzure],[SvrName],[DBName],[UserID],[pwd], [UID]) VALUES
		('TESTGROUP','N','ALIEN15','AW2016','sa','Junebug1', newid())
		INSERT INTO [dbo].[ActiveServers]([GroupName], [isAzure],[SvrName],[DBName],[UserID],[pwd], [UID]) VALUES
		('TESTGROUP','N','ALIEN15','WDM','sa','Junebug1', newid())
		INSERT INTO [dbo].[ActiveServers]([GroupName], [isAzure],[SvrName],[DBName],[UserID],[pwd], [UID]) VALUES
		('TESTGROUP','N','ALIEN15','TestDB','sa','Junebug1', newid())
		INSERT INTO [dbo].[ActiveServers]([GroupName], [isAzure],[SvrName],[DBName],[UserID],[pwd], [UID]) VALUES
		('TESTGROUP','N','ALIEN15','PowerDatabase','sa','Junebug1', newid())

		INSERT INTO [dbo].[ActiveServers]([GroupName], [isAzure],[SvrName],[DBName],[UserID],[pwd], [UID]) VALUES
		('TESTGROUP','N','SVR2016','DFINAnalytics','sa','Junebug1', newid())
		INSERT INTO [dbo].[ActiveServers]([GroupName], [isAzure],[SvrName],[DBName],[UserID],[pwd], [UID]) VALUES
		('TESTGROUP','N','SVR2016','DFS','sa','Junebug1', newid())
		INSERT INTO [dbo].[ActiveServers]([GroupName], [isAzure],[SvrName],[DBName],[UserID],[pwd], [UID]) VALUES
		('TESTGROUP','N','SVR2016','MstrData','sa','Junebug1', newid())
		INSERT INTO [dbo].[ActiveServers]([GroupName], [isAzure],[SvrName],[DBName],[UserID],[pwd], [UID]) VALUES
		('TESTGROUP','N','SVR2016','MstrPort','sa','Junebug1', newid())
		INSERT INTO [dbo].[ActiveServers]([GroupName], [isAzure],[SvrName],[DBName],[UserID],[pwd], [UID]) VALUES
		('TESTGROUP','N','SVR2016','MstrLog','sa','Junebug1', newid())
		INSERT INTO [dbo].[ActiveServers]([GroupName], [isAzure],[SvrName],[DBName],[UserID],[pwd], [UID]) VALUES
		('TESTGROUP','N','SVR2016','TestXml','sa','Junebug1', newid())
		INSERT INTO [dbo].[ActiveServers]([GroupName], [isAzure],[SvrName],[DBName],[UserID],[pwd], [UID]) VALUES
		('TESTGROUP','N','SVR2016','AW_VMWARE','sa','Junebug1', newid())
		
end 

update [ActiveJobStep] set ExecutionOrder = '1' where StepName = 'Step01';
update [ActiveJobStep] set ExecutionOrder = '2' where StepName = 'Step02';
update [ActiveJobStep] set ExecutionOrder = '3' where StepName = 'Step03';
update [ActiveJobStep] set ExecutionOrder = '4' where StepName = 'Step04';
update [ActiveJobStep] set ExecutionOrder = '5' where StepName = 'Step05';
update [ActiveJobStep] set ExecutionOrder = '6' where StepName = 'Step06';
update [ActiveJobStep] set ExecutionOrder = '7' where StepName = 'Step07';
update [ActiveJobStep] set ExecutionOrder = '8' where StepName = 'Step08';
update [ActiveJobStep] set ExecutionOrder = '8' where StepName = 'Step08';


/****************** PROCESSING FILE *************************************/

GO  
PRINT 'ID# 308'  
print 'D:\dev\SQL\DFINAnalytics\fn_GetWorstPerformingSPs.sql' 

go
IF EXISTS (SELECT *
           FROM   sys.objects
           WHERE  object_id = OBJECT_ID(N'[dbo].[fn_GetWorstPerformingSPs]')
                  AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT' ))
  DROP FUNCTION [dbo].[fn_GetWorstPerformingSPs]
go

/*====================================================+========
-- Description:  Returns TOP N worst performing stored procedures	
-- 
   SELECT * FROM dbo.fn_GetWorstPerformingSPs(5, 'test', 30)	
====================================================+========*/
CREATE FUNCTION [dbo].[fn_GetWorstPerformingSPs] (
   @n SMALLINT = 10,
   @dbname SYSNAME = '%',
   @avg_time_threshhold INT = 0
	)
RETURNS TABLE
AS
RETURN (
   SELECT TOP (@n) 
      DB_NAME (database_id) AS DBName,
      OBJECT_SCHEMA_NAME (object_id, database_id) AS [Schema_Name],
      OBJECT_NAME (object_id, database_id) AS [Object_Name],
      total_elapsed_time / execution_count AS Avg_Elapsed_Time,
      (total_physical_reads + total_logical_reads) / execution_count AS Avg_Reads,
      execution_count AS Execution_Count,
      t.text AS Query_Text,
      H.query_plan AS Query_Plan
   FROM 
      sys.dm_exec_procedure_stats
      CROSS APPLY sys.dm_exec_sql_text(sql_handle) T
      CROSS APPLY sys.dm_exec_query_plan(plan_handle) H
   WHERE 
      LOWER(DB_NAME(database_id)) LIKE LOWER(@dbname) 
      AND total_elapsed_time / execution_count > @avg_time_threshhold 
      AND LOWER(DB_NAME (database_id)) NOT IN ('master','tempdb','model','msdb','resource')
   ORDER BY 
       avg_elapsed_time DESC
       )
GO



/****************** PROCESSING FILE *************************************/

GO  
PRINT 'ID# 309'  
print 'D:\dev\SQL\DFINAnalytics\DatabaseUsage.sql' 

GO
IF EXISTS
(
    SELECT 1
    FROM sys.tables
    WHERE name = 'DFS_DBUsage'
)
    DROP TABLE [DFS_DBUsage];
GO
CREATE TABLE [dbo].[DFS_DBUsage]
(SvrName            NVARCHAR(150) NOT NULL, 
 DBName             NVARCHAR(150) NOT NULL, 
 [CPU (%)]          [DECIMAL](5, 2) NULL, 
 [IO (%)]           [DECIMAL](5, 2) NULL, 
 [Buffer Pool (%)]  [DECIMAL](5, 2) NULL, 
 [Plan Cache (%)]   [DECIMAL](5, 2) NULL, 
 [CPU Time (ms)]    [BIGINT] NULL, 
 [IO (mb)]          [BIGINT] NULL, 
 [Buffer Pool (mb)] [DECIMAL](10, 2) NULL, 
 [Plan Cache (mb)]  [INT] NULL, 
 CreateDate         DATETIME NOT NULL
                             DEFAULT GETDATE()
)
ON [PRIMARY];
GO
GO
IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'UTIL_DBUsage'
)
    DROP PROCEDURE UTIL_DBUsage;
GO
CREATE PROCEDURE UTIL_DBUsage
AS
    BEGIN
        WITH DBUsage
             AS (
             -- Fetches IO & CPU stats
             SELECT PA.DatabaseID, 
                    SUM(total_worker_time) AS [CPU Time (ms)], 
                    (SUM(IO.num_of_bytes_read + IO.num_of_bytes_written)) / 1024 / 1024 AS [IO (mb)]
             FROM sys.dm_exec_query_stats AS QS
                  CROSS APPLY
             (
                 SELECT CAST(value AS INT) AS DatabaseID
                 FROM sys.dm_exec_plan_attributes(qs.plan_handle)
                 WHERE attribute = 'dbid'
             ) AS PA
                  LEFT JOIN sys.dm_io_virtual_file_stats(NULL, NULL) AS IO ON IO.database_id = PA.DatabaseID
             WHERE PA.DatabaseID < 32767
             GROUP BY DatabaseID),
             PlanUse
             AS (SELECT PA.DatabaseID, 
                        SUM(P.size_in_bytes) / 1024 / 1024 AS [Plan Cache (mb)]
                 FROM sys.dm_exec_cached_plans P
                      CROSS APPLY
                 (
                     SELECT CAST(value AS INT) AS DatabaseID
                     FROM sys.dm_exec_plan_attributes(p.plan_handle)
                     WHERE attribute = 'dbid'
                 ) AS PA
                 WHERE PA.DatabaseID < 32767
                 GROUP BY PA.DatabaseID),
             BPUsage
             AS (SELECT database_id AS DatabaseID, 
                        CAST(COUNT(*) * 8 / 1024.0 AS DECIMAL(10, 2)) AS [Buffer Pool (mb)]
                 FROM sys.dm_os_buffer_descriptors WITH(NOLOCK)
                 WHERE database_id < 32767
                 GROUP BY database_id)
             INSERT INTO DFS_DBUsage
                    SELECT @@SERVERNAME AS SvrName, 
                           D.name AS DBName, 
                           CAST([CPU Time (ms)] * 1.0 / SUM([CPU Time (ms)]) OVER() * 100.0 AS DECIMAL(5, 2)) AS [CPU (%)], 
                           CAST([IO (mb)] * 1.0 / SUM([IO (mb)]) OVER() * 100.0 AS DECIMAL(5, 2)) AS [IO (%)], 
                           CAST([Buffer Pool (mb)] * 1.0 / SUM([Buffer Pool (mb)]) OVER() * 100.0 AS DECIMAL(5, 2)) AS [Buffer Pool (%)], 
                           CAST([Plan Cache (mb)] * 1.0 / SUM([Plan Cache (mb)]) OVER() * 100.0 AS DECIMAL(5, 2)) AS [Plan Cache (%)], 
                           [CPU Time (ms)], 
                           [IO (mb)], 
                           [Buffer Pool (mb)], 
                           [Plan Cache (mb)], 
                           GETDATE() AS createdate
                    FROM sys.databases D
                         LEFT JOIN DBUsage U ON U.DatabaseID = D.database_id
                         LEFT JOIN BPUsage BP ON BP.DatabaseID = D.database_id
                         LEFT JOIN PlanUse PU ON PU.DatabaseID = D.database_id
                    ORDER BY [CPU Time (ms)] DESC OPTION(RECOMPILE);
    END;

/****************** PROCESSING FILE *************************************/

GO  
PRINT 'ID# 310'  
print 'exec UTIL_DFS_DBVersion' 
exec UTIL_DFS_DBVersion; 
