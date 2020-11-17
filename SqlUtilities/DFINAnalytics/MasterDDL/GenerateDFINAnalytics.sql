USE DFINAnalytics
GO
/****** Object:  StoredProcedure [dbo].[UTIL_TableGrowthHistory]    Script Date: 2/6/2019 8:19:31 AM ******/
DROP PROCEDURE [dbo].[UTIL_TableGrowthHistory]
GO
/****** Object:  StoredProcedure [dbo].[UTIL_RecordCount]    Script Date: 2/6/2019 8:19:31 AM ******/
DROP PROCEDURE [dbo].[UTIL_RecordCount]
GO
/****** Object:  StoredProcedure [dbo].[UTIL_QryPlanStats]    Script Date: 2/6/2019 8:19:31 AM ******/
DROP PROCEDURE [dbo].[UTIL_QryPlanStats]
GO
/****** Object:  StoredProcedure [dbo].[UTIL_Process_QrysPlans]    Script Date: 2/6/2019 8:19:31 AM ******/
DROP PROCEDURE [dbo].[UTIL_Process_QrysPlans]
GO
/****** Object:  StoredProcedure [dbo].[UTIL_MSforeachdb]    Script Date: 2/6/2019 8:19:31 AM ******/
DROP PROCEDURE [dbo].[UTIL_MSforeachdb]
GO
/****** Object:  StoredProcedure [dbo].[UTIL_MonitorWorkload]    Script Date: 2/6/2019 8:19:31 AM ******/
DROP PROCEDURE [dbo].[UTIL_MonitorWorkload]
GO
/****** Object:  StoredProcedure [dbo].[UTIL_ListQueryAndBlocks]    Script Date: 2/6/2019 8:19:31 AM ******/
DROP PROCEDURE [dbo].[UTIL_ListQueryAndBlocks]
GO
/****** Object:  StoredProcedure [dbo].[UTIL_ListQryTextBySpid]    Script Date: 2/6/2019 8:19:31 AM ******/
DROP PROCEDURE [dbo].[UTIL_ListQryTextBySpid]
GO
/****** Object:  StoredProcedure [dbo].[UTIL_ListMostCommonWaits]    Script Date: 2/6/2019 8:19:31 AM ******/
DROP PROCEDURE [dbo].[UTIL_ListMostCommonWaits]
GO
/****** Object:  StoredProcedure [dbo].[UTIL_ListCurrentRunningQueries]    Script Date: 2/6/2019 8:19:31 AM ******/
DROP PROCEDURE [dbo].[UTIL_ListCurrentRunningQueries]
GO
/****** Object:  StoredProcedure [dbo].[UTIL_ListBlocks]    Script Date: 2/6/2019 8:19:31 AM ******/
DROP PROCEDURE [dbo].[UTIL_ListBlocks]
GO
/****** Object:  StoredProcedure [dbo].[UTIL_IO_BoundQry]    Script Date: 2/6/2019 8:19:31 AM ******/
DROP PROCEDURE [dbo].[UTIL_IO_BoundQry]
GO
/****** Object:  StoredProcedure [dbo].[UTIL_GetTableRowsSize]    Script Date: 2/6/2019 8:19:31 AM ******/
DROP PROCEDURE [dbo].[UTIL_GetTableRowsSize]
GO
/****** Object:  StoredProcedure [dbo].[UTIL_GetSeq]    Script Date: 2/6/2019 8:19:31 AM ******/
DROP PROCEDURE [dbo].[UTIL_GetSeq]
GO
/****** Object:  StoredProcedure [dbo].[UTIL_getRunningQueryText]    Script Date: 2/6/2019 8:19:31 AM ******/
DROP PROCEDURE [dbo].[UTIL_getRunningQueryText]
GO
/****** Object:  StoredProcedure [dbo].[UTIL_GetErrorInfo]    Script Date: 2/6/2019 8:19:31 AM ******/
DROP PROCEDURE [dbo].[UTIL_GetErrorInfo]
GO
/****** Object:  StoredProcedure [dbo].[UTIL_findLocks]    Script Date: 2/6/2019 8:19:31 AM ******/
DROP PROCEDURE [dbo].[UTIL_findLocks]
GO
/****** Object:  StoredProcedure [dbo].[UTIL_DFS_TxMonitorTblUpdates]    Script Date: 2/6/2019 8:19:31 AM ******/
DROP PROCEDURE [dbo].[UTIL_DFS_TxMonitorTblUpdates]
GO
/****** Object:  StoredProcedure [dbo].[UTIL_DFS_DeadlockStats]    Script Date: 2/6/2019 8:19:31 AM ******/
DROP PROCEDURE [dbo].[UTIL_DFS_DeadlockStats]
GO
/****** Object:  StoredProcedure [dbo].[UTIL_DFS_DBVersion]    Script Date: 2/6/2019 8:19:31 AM ******/
DROP PROCEDURE [dbo].[UTIL_DFS_DBVersion]
GO
/****** Object:  StoredProcedure [dbo].[UTIL_DFS_DbFileSizing]    Script Date: 2/6/2019 8:19:31 AM ******/
DROP PROCEDURE [dbo].[UTIL_DFS_DbFileSizing]
GO
/****** Object:  StoredProcedure [dbo].[UTIL_DFS_CPU_BoundQry]    Script Date: 2/6/2019 8:19:31 AM ******/
DROP PROCEDURE [dbo].[UTIL_DFS_CPU_BoundQry]
GO
/****** Object:  StoredProcedure [dbo].[UTIL_DefragAllIndexes]    Script Date: 2/6/2019 8:19:31 AM ******/
DROP PROCEDURE [dbo].[UTIL_DefragAllIndexes]
GO
/****** Object:  StoredProcedure [dbo].[UTIL_CleanUpOneTable]    Script Date: 2/6/2019 8:19:31 AM ******/
DROP PROCEDURE [dbo].[UTIL_CleanUpOneTable]
GO
/****** Object:  StoredProcedure [dbo].[UTIL_CleanDFSTables]    Script Date: 2/6/2019 8:19:31 AM ******/
DROP PROCEDURE [dbo].[UTIL_CleanDFSTables]
GO
/****** Object:  StoredProcedure [dbo].[UTIL_ADD_DFS_QrysPlans]    Script Date: 2/6/2019 8:19:31 AM ******/
DROP PROCEDURE [dbo].[UTIL_ADD_DFS_QrysPlans]
GO
/****** Object:  StoredProcedure [dbo].[usp_GetErrorInfo]    Script Date: 2/6/2019 8:19:31 AM ******/
DROP PROCEDURE [dbo].[usp_GetErrorInfo]
GO
/****** Object:  StoredProcedure [dbo].[test_GetNbr1]    Script Date: 2/6/2019 8:19:31 AM ******/
DROP PROCEDURE [dbo].[test_GetNbr1]
GO
/****** Object:  StoredProcedure [dbo].[spDemoDBContext]    Script Date: 2/6/2019 8:19:31 AM ******/
DROP PROCEDURE [dbo].[spDemoDBContext]
GO
/****** Object:  StoredProcedure [dbo].[sp_UTIL_IO_BoundQry]    Script Date: 2/6/2019 8:19:31 AM ******/
DROP PROCEDURE [dbo].[sp_UTIL_IO_BoundQry]
GO
/****** Object:  StoredProcedure [dbo].[sp_UTIL_CPU_BoundQry]    Script Date: 2/6/2019 8:19:31 AM ******/
DROP PROCEDURE [dbo].[sp_UTIL_CPU_BoundQry]
GO
/****** Object:  StoredProcedure [dbo].[sp_MeasurePerformanceInSP]    Script Date: 2/6/2019 8:19:31 AM ******/
DROP PROCEDURE [dbo].[sp_MeasurePerformanceInSP]
GO
/****** Object:  StoredProcedure [dbo].[sp_foreachdb_TempDB]    Script Date: 2/6/2019 8:19:31 AM ******/
DROP PROCEDURE [dbo].[sp_foreachdb_TempDB]
GO
/****** Object:  StoredProcedure [dbo].[sp_foreachdb]    Script Date: 2/6/2019 8:19:31 AM ******/
DROP PROCEDURE [dbo].[sp_foreachdb]
GO
/****** Object:  StoredProcedure [dbo].[sp_DFS_FindMissingFKIndexes]    Script Date: 2/6/2019 8:19:31 AM ******/
DROP PROCEDURE [dbo].[sp_DFS_FindMissingFKIndexes]
GO
/****** Object:  StoredProcedure [dbo].[PrintImmediate]    Script Date: 2/6/2019 8:19:31 AM ******/
DROP PROCEDURE [dbo].[PrintImmediate]
GO
/****** Object:  StoredProcedure [dbo].[GetSEQUENCE]    Script Date: 2/6/2019 8:19:31 AM ******/
DROP PROCEDURE [dbo].[GetSEQUENCE]
GO
/****** Object:  StoredProcedure [dbo].[genInsertStatements]    Script Date: 2/6/2019 8:19:31 AM ******/
DROP PROCEDURE [dbo].[genInsertStatements]
GO
/****** Object:  StoredProcedure [dbo].[DMA_ForEachDB]    Script Date: 2/6/2019 8:19:31 AM ******/
DROP PROCEDURE [dbo].[DMA_ForEachDB]
GO
/****** Object:  StoredProcedure [dbo].[DFS_MonitorTableStats]    Script Date: 2/6/2019 8:19:31 AM ******/
DROP PROCEDURE [dbo].[DFS_MonitorTableStats]
GO
/****** Object:  StoredProcedure [dbo].[DFS_MonitorLocks]    Script Date: 2/6/2019 8:19:31 AM ******/
DROP PROCEDURE [dbo].[DFS_MonitorLocks]
GO
/****** Object:  StoredProcedure [dbo].[DFS_IO_BoundQry2000_ProcessTable]    Script Date: 2/6/2019 8:19:31 AM ******/
DROP PROCEDURE [dbo].[DFS_IO_BoundQry2000_ProcessTable]
GO
/****** Object:  StoredProcedure [dbo].[DFS_GetAllTableSizesAndRowCnt]    Script Date: 2/6/2019 8:19:31 AM ******/
DROP PROCEDURE [dbo].[DFS_GetAllTableSizesAndRowCnt]
GO
/****** Object:  StoredProcedure [dbo].[DFS_CPU_BoundQry2000_ProcessTable]    Script Date: 2/6/2019 8:19:31 AM ******/
DROP PROCEDURE [dbo].[DFS_CPU_BoundQry2000_ProcessTable]
GO
/****** Object:  StoredProcedure [dbo].[_GetProcDependencies]    Script Date: 2/6/2019 8:19:31 AM ******/
DROP PROCEDURE [dbo].[_GetProcDependencies]
GO
/****** Object:  StoredProcedure [dbo].[_Emergency_StartAllAnalyticsJobs]    Script Date: 2/6/2019 8:19:31 AM ******/
DROP PROCEDURE [dbo].[_Emergency_StartAllAnalyticsJobs]
GO
/****** Object:  StoredProcedure [dbo].[_CreateTempProc]    Script Date: 2/6/2019 8:19:31 AM ******/
DROP PROCEDURE [dbo].[_CreateTempProc]
GO
ALTER TABLE [dbo].[DFS_Workload] DROP CONSTRAINT [DF__DFS_Workl__RunDa__42ACE4D4]
GO
ALTER TABLE [dbo].[DFS_Workload] DROP CONSTRAINT [DF__DFS_Workloa__UID__41B8C09B]
GO
ALTER TABLE [dbo].[DFS_WaitTypes] DROP CONSTRAINT [DF__DFS_WaitTyp__UID__168449D3]
GO
ALTER TABLE [dbo].[DFS_WaitStats] DROP CONSTRAINT [DF__DFS_WaitSta__UID__28ED12D1]
GO
ALTER TABLE [dbo].[DFS_WaitStats] DROP CONSTRAINT [DF__DFS_WaitS__Creat__27F8EE98]
GO
ALTER TABLE [dbo].[DFS_WaitStats] DROP CONSTRAINT [DF__DFS_WaitS__DBNam__2704CA5F]
GO
ALTER TABLE [dbo].[DFS_WaitStats] DROP CONSTRAINT [DF__DFS_WaitS__SvrNa__2610A626]
GO
ALTER TABLE [dbo].[DFS_TxMonitorTblUpdates] DROP CONSTRAINT [DF__DFS_TxMonit__UID__26BAB19C]
GO
ALTER TABLE [dbo].[DFS_TxMonitorTblUpdates] DROP CONSTRAINT [DF__DFS_TxMon__Creat__6C190EBB]
GO
ALTER TABLE [dbo].[DFS_TxMonitorTableIndexStats] DROP CONSTRAINT [DF__DFS_TxMonit__UID__7E77B618]
GO
ALTER TABLE [dbo].[DFS_TxMonitorIDX] DROP CONSTRAINT [DF__DFS_TxMon__Creat__7B9B496D]
GO
ALTER TABLE [dbo].[DFS_TranLocks] DROP CONSTRAINT [DF__DFS_TranLoc__UID__0524B3A7]
GO
ALTER TABLE [dbo].[DFS_TranLocks] DROP CONSTRAINT [DF__DFS_TranL__Creat__04308F6E]
GO
ALTER TABLE [dbo].[DFS_TempProcErrors] DROP CONSTRAINT [DF__DFS_TempPro__UID__1D314762]
GO
ALTER TABLE [dbo].[DFS_TempProcErrors] DROP CONSTRAINT [DF__DFS_TempP__Creat__3943762B]
GO
ALTER TABLE [dbo].[DFS_TableStats] DROP CONSTRAINT [DF__DFS_TableSt__UID__2E5BD364]
GO
ALTER TABLE [dbo].[DFS_TableStats] DROP CONSTRAINT [DF_DFS_TableStats_RunDate]
GO
ALTER TABLE [dbo].[DFS_TableSizeAndRowCnt] DROP CONSTRAINT [DF__DFS_Table__Creat__7FB5F314]
GO
ALTER TABLE [dbo].[DFS_TableSizeAndRowCnt] DROP CONSTRAINT [DF__DFS_TableSi__UID__7EC1CEDB]
GO
ALTER TABLE [dbo].[DFS_TableGrowthHistory] DROP CONSTRAINT [DF__DFS_TableGr__UID__58520D30]
GO
ALTER TABLE [dbo].[DFS_TableGrowthHistory] DROP CONSTRAINT [DF__DFS_Table__Entry__575DE8F7]
GO
ALTER TABLE [dbo].[DFS_SequenceTABLE] DROP CONSTRAINT [DF__DFS_Sequenc__UID__23DE44F1]
GO
ALTER TABLE [dbo].[DFS_SEQ] DROP CONSTRAINT [DF__DFS_SEQ__UID__22EA20B8]
GO
ALTER TABLE [dbo].[DFS_SEQ] DROP CONSTRAINT [DF__DFS_SEQ__GenDate__45F365D3]
GO
ALTER TABLE [dbo].[DFS_RecordCount] DROP CONSTRAINT [DF__DFS_RecordC__UID__51A50FA1]
GO
ALTER TABLE [dbo].[DFS_RecordCount] DROP CONSTRAINT [DF__DFS_Recor__HitCo__50B0EB68]
GO
ALTER TABLE [dbo].[DFS_QrysPlans] DROP CONSTRAINT [DF__DFS_QrysP__Creat__76619304]
GO
ALTER TABLE [dbo].[DFS_QrysPlans] DROP CONSTRAINT [DF__DFS_QrysPla__UID__756D6ECB]
GO
ALTER TABLE [dbo].[DFS_QryPlanBridge] DROP CONSTRAINT [DF__DFS_QryPlan__UID__2A8B4280]
GO
ALTER TABLE [dbo].[DFS_QryPlanBridge] DROP CONSTRAINT [DF__DFS_QryPl__NbrHi__7C1A6C5A]
GO
ALTER TABLE [dbo].[DFS_QryPlanBridge] DROP CONSTRAINT [DF__DFS_QryPl__LastU__7B264821]
GO
ALTER TABLE [dbo].[DFS_QryPlanBridge] DROP CONSTRAINT [DF__DFS_QryPl__Creat__7A3223E8]
GO
ALTER TABLE [dbo].[DFS_QryOptStats] DROP CONSTRAINT [DF__DFS_QryOptS__UID__75E27017]
GO
ALTER TABLE [dbo].[DFS_QryOptStats] DROP CONSTRAINT [DF__DFS_QryOp__RunDa__74EE4BDE]
GO
ALTER TABLE [dbo].[DFS_PerfMonitor] DROP CONSTRAINT [DF__DFS_PerfMon__UID__5D16C24D]
GO
ALTER TABLE [dbo].[DFS_PerfMonitor] DROP CONSTRAINT [DF__DFS_PerfM__Creat__5C229E14]
GO
ALTER TABLE [dbo].[DFS_PerfMonitor] DROP CONSTRAINT [DF_PerfMonitor_UKEY]
GO
ALTER TABLE [dbo].[DFS_MissingIndexes] DROP CONSTRAINT [DF__DFS_Missing__UID__79B300FB]
GO
ALTER TABLE [dbo].[DFS_MissingIndexes] DROP CONSTRAINT [DF__DFS_Missi__Creat__78BEDCC2]
GO
ALTER TABLE [dbo].[DFS_MissingFKIndexes] DROP CONSTRAINT [DF__DFS_Missing__UID__1A54DAB7]
GO
ALTER TABLE [dbo].[DFS_IO_BoundQry2000] DROP CONSTRAINT [DF__DFS_IO_Bo__proce__62108194]
GO
ALTER TABLE [dbo].[DFS_IO_BoundQry2000] DROP CONSTRAINT [DF__DFS_IO_Boun__UID__611C5D5B]
GO
ALTER TABLE [dbo].[DFS_IO_BoundQry] DROP CONSTRAINT [DF__DFS_IO_Bo__Proce__00DF2177]
GO
ALTER TABLE [dbo].[DFS_IO_BoundQry] DROP CONSTRAINT [DF__DFS_IO_Boun__UID__55F4C372]
GO
ALTER TABLE [dbo].[DFS_IndexStats] DROP CONSTRAINT [DF__DFS_IndexSt__UID__7306036C]
GO
ALTER TABLE [dbo].[DFS_IndexReorgCmds] DROP CONSTRAINT [DF__DFS_IndexRe__UID__1B48FEF0]
GO
ALTER TABLE [dbo].[DFS_IndexFragReorgHistory] DROP CONSTRAINT [DF__DFS_IndexFr__UID__28A2FA0E]
GO
ALTER TABLE [dbo].[DFS_IndexFragReorgHistory] DROP CONSTRAINT [DF__DFS_Index__Runda__76969D2E]
GO
ALTER TABLE [dbo].[DFS_IndexFragProgress] DROP CONSTRAINT [DF__DFS_IndexFr__UID__33208881]
GO
ALTER TABLE [dbo].[DFS_IndexFragHist] DROP CONSTRAINT [DF__DFS_IndexFr__UID__38D961D7]
GO
ALTER TABLE [dbo].[DFS_IndexFragHist] DROP CONSTRAINT [DF__DFS_Index__RunDa__37E53D9E]
GO
ALTER TABLE [dbo].[DFS_IndexFragHist] DROP CONSTRAINT [DF__DFS_Index__Index__36F11965]
GO
ALTER TABLE [dbo].[DFS_IndexFragErrors] DROP CONSTRAINT [DF__DFS_IndexFr__UID__3508D0F3]
GO
ALTER TABLE [dbo].[DFS_DeadlockStats] DROP CONSTRAINT [DF__DFS_Deadloc__UID__54CB950F]
GO
ALTER TABLE [dbo].[DFS_DeadlockStats] DROP CONSTRAINT [DF__DFS_Deadl__RunDa__53D770D6]
GO
ALTER TABLE [dbo].[DFS_DBVersion] DROP CONSTRAINT [DF__DFS_DBVersi__UID__186C9245]
GO
ALTER TABLE [dbo].[DFS_DBVersion] DROP CONSTRAINT [DF__DFS_DBVer__SSVER__1EA48E88]
GO
ALTER TABLE [dbo].[DFS_DbFileSizing] DROP CONSTRAINT [DF__DFS_DbFileS__UID__4356F04A]
GO
ALTER TABLE [dbo].[DFS_DbFileSizing] DROP CONSTRAINT [DF__DFS_DbFil__Creat__4262CC11]
GO
ALTER TABLE [dbo].[DFS_DB2Skip] DROP CONSTRAINT [DF__DFS_DB2Skip__UID__21F5FC7F]
GO
ALTER TABLE [dbo].[DFS_CPU_BoundQry2000] DROP CONSTRAINT [DF__DFS_CPU_B__Proce__64ECEE3F]
GO
ALTER TABLE [dbo].[DFS_CPU_BoundQry2000] DROP CONSTRAINT [DF__DFS_CPU_Bou__UID__63F8CA06]
GO
ALTER TABLE [dbo].[DFS_CPU_BoundQry] DROP CONSTRAINT [DF__DFS_CPU_B__Proce__2E70E1FD]
GO
ALTER TABLE [dbo].[DFS_CPU_BoundQry] DROP CONSTRAINT [DF__DFS_CPU_Bou__UID__2D7CBDC4]
GO
ALTER TABLE [dbo].[DFS_CleanedDFSTables] DROP CONSTRAINT [DF__DFS_Cleaned__UID__15A53433]
GO
ALTER TABLE [dbo].[DFS_CleanedDFSTables] DROP CONSTRAINT [DF__DFS_Clean__Creat__14B10FFA]
GO
ALTER TABLE [dbo].[DFS_BlockingHistory] DROP CONSTRAINT [DF__DFS_Blockin__UID__6E414E4F]
GO
/****** Object:  Table [dbo].[SequenceTABLE]    Script Date: 2/6/2019 8:19:31 AM ******/
DROP TABLE [dbo].[SequenceTABLE]
GO
/****** Object:  Table [dbo].[DFS_WaitStats]    Script Date: 2/6/2019 8:19:31 AM ******/
DROP TABLE [dbo].[DFS_WaitStats]
GO
/****** Object:  Table [dbo].[DFS_TxMonitorTblUpdates]    Script Date: 2/6/2019 8:19:31 AM ******/
DROP TABLE [dbo].[DFS_TxMonitorTblUpdates]
GO
/****** Object:  Table [dbo].[DFS_TxMonitorTableStats]    Script Date: 2/6/2019 8:19:31 AM ******/
DROP TABLE [dbo].[DFS_TxMonitorTableStats]
GO
/****** Object:  Table [dbo].[DFS_TxMonitorTableIndexStats]    Script Date: 2/6/2019 8:19:31 AM ******/
DROP TABLE [dbo].[DFS_TxMonitorTableIndexStats]
GO
/****** Object:  Table [dbo].[DFS_TxMonitorIDX]    Script Date: 2/6/2019 8:19:31 AM ******/
DROP TABLE [dbo].[DFS_TxMonitorIDX]
GO
/****** Object:  Table [dbo].[DFS_TranLocks]    Script Date: 2/6/2019 8:19:31 AM ******/
DROP TABLE [dbo].[DFS_TranLocks]
GO
/****** Object:  Table [dbo].[DFS_TempProcErrors]    Script Date: 2/6/2019 8:19:31 AM ******/
DROP TABLE [dbo].[DFS_TempProcErrors]
GO
/****** Object:  Table [dbo].[DFS_TableStats]    Script Date: 2/6/2019 8:19:31 AM ******/
DROP TABLE [dbo].[DFS_TableStats]
GO
/****** Object:  Table [dbo].[DFS_TableSizeAndRowCnt]    Script Date: 2/6/2019 8:19:31 AM ******/
DROP TABLE [dbo].[DFS_TableSizeAndRowCnt]
GO
/****** Object:  Table [dbo].[DFS_SequenceTABLE]    Script Date: 2/6/2019 8:19:31 AM ******/
DROP TABLE [dbo].[DFS_SequenceTABLE]
GO
/****** Object:  Table [dbo].[DFS_SEQ]    Script Date: 2/6/2019 8:19:31 AM ******/
DROP TABLE [dbo].[DFS_SEQ]
GO
/****** Object:  Table [dbo].[DFS_RecordCount]    Script Date: 2/6/2019 8:19:31 AM ******/
DROP TABLE [dbo].[DFS_RecordCount]
GO
/****** Object:  Table [dbo].[DFS_QrysPlans]    Script Date: 2/6/2019 8:19:31 AM ******/
DROP TABLE [dbo].[DFS_QrysPlans]
GO
/****** Object:  Table [dbo].[DFS_QryPlanBridge]    Script Date: 2/6/2019 8:19:31 AM ******/
DROP TABLE [dbo].[DFS_QryPlanBridge]
GO
/****** Object:  Table [dbo].[DFS_QryOptStats]    Script Date: 2/6/2019 8:19:31 AM ******/
DROP TABLE [dbo].[DFS_QryOptStats]
GO
/****** Object:  Table [dbo].[DFS_PerfMonitor]    Script Date: 2/6/2019 8:19:31 AM ******/
DROP TABLE [dbo].[DFS_PerfMonitor]
GO
/****** Object:  Table [dbo].[DFS_MissingIndexes]    Script Date: 2/6/2019 8:19:31 AM ******/
DROP TABLE [dbo].[DFS_MissingIndexes]
GO
/****** Object:  Table [dbo].[DFS_MissingFKIndexes]    Script Date: 2/6/2019 8:19:31 AM ******/
DROP TABLE [dbo].[DFS_MissingFKIndexes]
GO
/****** Object:  Table [dbo].[DFS_IO_BoundQry2000]    Script Date: 2/6/2019 8:19:31 AM ******/
DROP TABLE [dbo].[DFS_IO_BoundQry2000]
GO
/****** Object:  Table [dbo].[DFS_IO_BoundQry]    Script Date: 2/6/2019 8:19:31 AM ******/
DROP TABLE [dbo].[DFS_IO_BoundQry]
GO
/****** Object:  Table [dbo].[DFS_IndexStats]    Script Date: 2/6/2019 8:19:31 AM ******/
DROP TABLE [dbo].[DFS_IndexStats]
GO
/****** Object:  Table [dbo].[DFS_IndexReorgCmds]    Script Date: 2/6/2019 8:19:31 AM ******/
DROP TABLE [dbo].[DFS_IndexReorgCmds]
GO
/****** Object:  Table [dbo].[DFS_IndexFragReorgHistory]    Script Date: 2/6/2019 8:19:31 AM ******/
DROP TABLE [dbo].[DFS_IndexFragReorgHistory]
GO
/****** Object:  Table [dbo].[DFS_IndexFragProgress]    Script Date: 2/6/2019 8:19:31 AM ******/
DROP TABLE [dbo].[DFS_IndexFragProgress]
GO
/****** Object:  Table [dbo].[DFS_IndexFragHist]    Script Date: 2/6/2019 8:19:31 AM ******/
DROP TABLE [dbo].[DFS_IndexFragHist]
GO
/****** Object:  Table [dbo].[DFS_IndexFragErrors]    Script Date: 2/6/2019 8:19:31 AM ******/
DROP TABLE [dbo].[DFS_IndexFragErrors]
GO
/****** Object:  Table [dbo].[DFS_DeadlockStats]    Script Date: 2/6/2019 8:19:31 AM ******/
DROP TABLE [dbo].[DFS_DeadlockStats]
GO
/****** Object:  Table [dbo].[DFS_DBVersion]    Script Date: 2/6/2019 8:19:31 AM ******/
DROP TABLE [dbo].[DFS_DBVersion]
GO
/****** Object:  Table [dbo].[DFS_DbFileSizing]    Script Date: 2/6/2019 8:19:31 AM ******/
DROP TABLE [dbo].[DFS_DbFileSizing]
GO
/****** Object:  Table [dbo].[DFS_DB2Skip]    Script Date: 2/6/2019 8:19:31 AM ******/
DROP TABLE [dbo].[DFS_DB2Skip]
GO
/****** Object:  Table [dbo].[DFS_CPU_BoundQry2000]    Script Date: 2/6/2019 8:19:31 AM ******/
DROP TABLE [dbo].[DFS_CPU_BoundQry2000]
GO
/****** Object:  Table [dbo].[DFS_CPU_BoundQry]    Script Date: 2/6/2019 8:19:31 AM ******/
DROP TABLE [dbo].[DFS_CPU_BoundQry]
GO
/****** Object:  Table [dbo].[DFS_CleanedDFSTables]    Script Date: 2/6/2019 8:19:31 AM ******/
DROP TABLE [dbo].[DFS_CleanedDFSTables]
GO
/****** Object:  Table [dbo].[DFS_BlockingHistory]    Script Date: 2/6/2019 8:19:31 AM ******/
DROP TABLE [dbo].[DFS_BlockingHistory]
GO
/****** Object:  View [dbo].[vProcDependencies]    Script Date: 2/6/2019 8:19:31 AM ******/
DROP VIEW [dbo].[vProcDependencies]
GO
/****** Object:  View [dbo].[view_SessionStatus]    Script Date: 2/6/2019 8:19:31 AM ******/
DROP VIEW [dbo].[view_SessionStatus]
GO
/****** Object:  Table [dbo].[DFS_WaitTypes]    Script Date: 2/6/2019 8:19:31 AM ******/
DROP TABLE [dbo].[DFS_WaitTypes]
GO
/****** Object:  View [dbo].[vTrackTblReadsWrites]    Script Date: 2/6/2019 8:19:31 AM ******/
DROP VIEW [dbo].[vTrackTblReadsWrites]
GO
/****** Object:  Table [dbo].[DFS_TableReadWrites]    Script Date: 2/6/2019 8:19:31 AM ******/
DROP TABLE [dbo].[DFS_TableReadWrites]
GO
/****** Object:  View [dbo].[viewTableGrowthStats]    Script Date: 2/6/2019 8:19:31 AM ******/
DROP VIEW [dbo].[viewTableGrowthStats]
GO
/****** Object:  Table [dbo].[DFS_TableGrowthHistory]    Script Date: 2/6/2019 8:19:31 AM ******/
DROP TABLE [dbo].[DFS_TableGrowthHistory]
GO
/****** Object:  View [dbo].[view_DFS_Workload_AveragesByDay]    Script Date: 2/6/2019 8:19:31 AM ******/
DROP VIEW [dbo].[view_DFS_Workload_AveragesByDay]
GO
/****** Object:  View [dbo].[view_DFS_Workload_Averages]    Script Date: 2/6/2019 8:19:31 AM ******/
DROP VIEW [dbo].[view_DFS_Workload_Averages]
GO
/****** Object:  Table [dbo].[DFS_Workload]    Script Date: 2/6/2019 8:19:31 AM ******/
DROP TABLE [dbo].[DFS_Workload]
GO
/****** Object:  UserDefinedFunction [dbo].[UtilFn_RemoveComments]    Script Date: 2/6/2019 8:19:31 AM ******/
DROP FUNCTION [dbo].[UtilFn_RemoveComments]
GO
/****** Object:  UserDefinedFunction [dbo].[UTIL_RemoveCommentsFromCode]    Script Date: 2/6/2019 8:19:31 AM ******/
DROP FUNCTION [dbo].[UTIL_RemoveCommentsFromCode]
GO
/****** Object:  UserDefinedFunction [dbo].[genInsertSql]    Script Date: 2/6/2019 8:19:31 AM ******/
DROP FUNCTION [dbo].[genInsertSql]
GO
/****** Object:  UserDefinedFunction [dbo].[f_celsiustofahrenheit]    Script Date: 2/6/2019 8:19:31 AM ******/
DROP FUNCTION [dbo].[f_celsiustofahrenheit]
GO
/****** Object:  UserDefinedFunction [dbo].[f_celsiustofahrenheit]    Script Date: 2/6/2019 8:19:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[f_celsiustofahrenheit](@celcius real)
RETURNS real
AS 
BEGIN
	
	RETURN  @celcius*1.8+32
END
GO
/****** Object:  UserDefinedFunction [dbo].[genInsertSql]    Script Date: 2/6/2019 8:19:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--DROP PROCEDURE genInsertSql;
--GO

CREATE function [dbo].[genInsertSql] ( 
                 @FromTBL NVARCHAR(250) , 
                 @IntoTBL NVARCHAR(250)
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
        SET @stmt = @stmt + CHAR(10) + @colx +char(10) +')' + CHAR(10) + 'Select ' +char(10) + @stmtcopy + CHAR(10) + ' From ' + @FromTBL + ';';

        RETURN @stmt;
    END;
GO
/****** Object:  UserDefinedFunction [dbo].[UTIL_RemoveCommentsFromCode]    Script Date: 2/6/2019 8:19:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
In order to compile/recompile a stored procedure that is pulled from the database
as an existing stored procedure, it is much easier to parse and find the parts needed
to make it transfer across and compile on TEMPDB if there are no comments in the code.
This function removes all comments from source code, or any SQL based code.
*/

CREATE FUNCTION [dbo].[UTIL_RemoveCommentsFromCode]
( 
				@def varchar(max)
)
RETURNS varchar(max)
AS
BEGIN
	DECLARE @comment varchar(100), @endPosition int, @startPosition int, @commentLen int, @substrlen int, @len int;

	WHILE(CHARINDEX('/*', @def) <> 0)
	BEGIN
		SET @endPosition = CHARINDEX('*/', @def);
		SET @substrlen = LEN(SUBSTRING(@def, 1, @endPosition - 1));
		SET @startPosition = @substrlen - CHARINDEX('*/', REVERSE(SUBSTRING(@def, 1, @endPosition - 1))) + 1;
		SET @commentLen = @endPosition - @startPosition;
		SET @comment = SUBSTRING(@def, @startPosition - 1, @commentLen + 3);
		SET @def = REPLACE(@def, @comment, CHAR(13));
	END;


	--* Dealing with --... kind of comments *
	WHILE PATINDEX('%--%', @def) <> 0
	BEGIN
		SET @startPosition = PATINDEX('%--%', @def);
		SET @endPosition = ISNULL(CHARINDEX(CHAR(13), @def, @startPosition), 0);
		SET @len = ( @endPosition ) - @startPosition;

		-- This happens at the end of the code block, 
		--   when the last line is commented code with no CRLF characters
		IF @len <= 0
		BEGIN
			SET @len = ( LEN(@def) + 1 ) - @startPosition;
		END;

		SET @Comment = SUBSTRING(@def, @startPosition, @len);
		SET @def = REPLACE(@def, @comment, CHAR(13));
	END;

	RETURN @def;
END;
GO
/****** Object:  UserDefinedFunction [dbo].[UtilFn_RemoveComments]    Script Date: 2/6/2019 8:19:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create FUNCTION [dbo].[UtilFn_RemoveComments]  (@def VARCHAR(MAX)) RETURNS VARCHAR(MAX)
AS
BEGIN
DECLARE 
        @comment VARCHAR(100), 
        @endPosition INT, 
        @startPosition INT, 
        @commentLen INT,
        @substrlen INT, 
        @len INT

        WHILE (CHARINDEX('/*',@def)<>0)
        BEGIN
                SET @endPosition  = charindex('*/',@def)
                SET @substrlen=len(substring(@def,1,@endPosition-1))
                SET @startPosition = @substrlen - charINDEX('*/',reverse(substring(@def,1,@endPosition-1)))+1
                SET @commentLen = @endPosition - @startPosition
                SET @comment = substring(@def,@startPosition-1,@commentLen+3 ) 
                SET @def = REPLACE(@def,@comment,CHAR(13))
        END


--* Dealing with --... kind of comments *
        WHILE Patindex('%--%',@def) <> 0
        BEGIN
                SET @startPosition = Patindex('%--%',@def)
                SET @endPosition = Isnull(Charindex(CHAR(13),@def,@startPosition),0)
                SET @len = (@endPosition) - @startPosition

                -- This happens at the end of the code block, 
                --   when the last line is commented code with no CRLF characters
                IF @len <= 0 
                        SET @len = (Len(@def) + 1) - @startPosition

                SET @Comment = Substring(@def,@startPosition,@len)
                SET @def = REPLACE(@def,@comment,CHAR(13))
        END

RETURN @def 
END;
GO
/****** Object:  Table [dbo].[DFS_Workload]    Script Date: 2/6/2019 8:19:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DFS_Workload](
	[Svrname] [nvarchar](150) NULL,
	[OptimizationPct] [decimal](5, 2) NULL,
	[TrivialPlanPct] [decimal](5, 2) NULL,
	[NoPlanPct] [decimal](5, 2) NULL,
	[Search0Pct] [decimal](5, 2) NULL,
	[Search1Pct] [decimal](5, 2) NULL,
	[Search2Pct] [decimal](5, 2) NULL,
	[TimeoutPct] [decimal](5, 2) NULL,
	[MemoryLimitExceededPct] [decimal](5, 2) NULL,
	[InsertStmtPct] [decimal](5, 2) NULL,
	[DeleteStmt] [decimal](5, 2) NULL,
	[UpdateStmt] [decimal](5, 2) NULL,
	[MergeStmt] [decimal](5, 2) NULL,
	[ContainsSubqueryPct] [decimal](5, 2) NULL,
	[ViewReferencePct] [decimal](5, 2) NULL,
	[RemoteQueryPct] [decimal](5, 2) NULL,
	[DynamicCursorRequestPct] [decimal](5, 2) NULL,
	[FastForwardCursorRequestPct] [decimal](5, 2) NULL,
	[UID] [uniqueidentifier] NULL,
	[RowID] [bigint] IDENTITY(1,1) NOT NULL,
	[RunDate] [datetime] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[view_DFS_Workload_Averages]    Script Date: 2/6/2019 8:19:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[view_DFS_Workload_Averages]
AS
     SELECT DISTINCT 
            --[SVRNAME], 
            [DBName], 
            AVG([OptimizationPct]) AS AvgOptimizationPct, 
            AVG([TrivialPlanPct]) AS AvgTrivialPlanPct
            ,
            --,[NoPlanPct]
            --,[Search0Pct]
            --,[Search1Pct]
            --,[Search2Pct]
            --,[TimeoutPct]
            --,[MemoryLimitExceededPct] 
            AVG([InsertStmtPct]) AS AvgInsertStmtPct, 
            AVG([DeleteStmt]) AS AvgDeleteStmtPct, 
            AVG([UpdateStmt]) AS AvgUpdateStmtPct, 
            AVG([MergeStmt]) AS AvgMergeStmtPct, 
            AVG([ContainsSubqueryPct]) AS AvgContainsSubqueryPct, 
            AVG([ViewReferencePct]) AS AvgViewReferencePct
            ,
            --,[RemoteQueryPct]
            --,[DynamicCursorRequestPct]
            --,[FastForwardCursorRequestPct]
            --,[RowID] 
            MIN([RunDate]) AS StartDate, 
            MAX([RunDate]) AS EndDate, 
            COUNT(*) AS RowSampleSize
     FROM [DFINAnalytics].dbo.[DFS_Workload]
     GROUP BY [DBName];
GO
/****** Object:  View [dbo].[view_DFS_Workload_AveragesByDay]    Script Date: 2/6/2019 8:19:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[view_DFS_Workload_AveragesByDay]
AS
     SELECT DISTINCT 
            CONVERT(DATE, RunDate) AS RunDay, 
            datename(dw, CONVERT(DATE, RunDate)) AS DOW, 
            AVG([OptimizationPct]) AS AvgOptimizationPct, 
            AVG([TrivialPlanPct]) AS AvgTrivialPlanPct
            ,
            --,[NoPlanPct]
            --,[Search0Pct]
            --,[Search1Pct]
            --,[Search2Pct]
            --,[TimeoutPct]
            --,[MemoryLimitExceededPct] 
            AVG([InsertStmtPct]) AS AvgInsertStmtPct, 
            AVG([DeleteStmt]) AS AvgDeleteStmtPct, 
            AVG([UpdateStmt]) AS AvgUpdateStmtPct, 
            AVG([MergeStmt]) AS AvgMergeStmtPct, 
            AVG([ContainsSubqueryPct]) AS AvgContainsSubqueryPct, 
            AVG([ViewReferencePct]) AS AvgViewReferencePct
            ,
            --,[RemoteQueryPct]
            --,[DynamicCursorRequestPct]
            --,[FastForwardCursorRequestPct]
            --,[RowID] 
            MIN([RunDate]) AS StartDate, 
            MAX([RunDate]) AS EndDate, 
            COUNT(*) AS RowSampleSize
     FROM [DFINAnalytics].dbo.[DFS_Workload]
     GROUP BY CONVERT(DATE, RunDate), 
              [DBName];
GO
/****** Object:  Table [dbo].[DFS_TableGrowthHistory]    Script Date: 2/6/2019 8:19:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DFS_TableGrowthHistory](
	[SvrName] [nvarchar](250) NOT NULL,
	[DBName] [nvarchar](250) NOT NULL,
	[Table_name] [nvarchar](250) NOT NULL,
	[NbrRows] [int] NOT NULL,
	[EntryDate] [datetime] NULL,
	[RunID] [bigint] NOT NULL,
	[TableSchema] [nvarchar](50) NULL,
	[UID] [uniqueidentifier] NULL,
	[RowId] [int] IDENTITY(1,1) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[viewTableGrowthStats]    Script Date: 2/6/2019 8:19:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[viewTableGrowthStats]
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
/****** Object:  Table [dbo].[DFS_TableReadWrites]    Script Date: 2/6/2019 8:19:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DFS_TableReadWrites](
	[ServerName] [nvarchar](128) NULL,
	[DBName] [nvarchar](128) NULL,
	[TableName] [nvarchar](128) NULL,
	[Reads] [bigint] NULL,
	[Writes] [bigint] NULL,
	[Reads&Writes] [bigint] NULL,
	[SampleDays] [numeric](18, 7) NULL,
	[SampleSeconds] [int] NULL,
	[RunDate] [datetime] NOT NULL,
	[SSVER] [nvarchar](250) NULL,
	[RowID] [bigint] IDENTITY(1,1) NOT NULL,
	[UID] [uniqueidentifier] NULL,
	[RunID] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vTrackTblReadsWrites]    Script Date: 2/6/2019 8:19:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vTrackTblReadsWrites]
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
     FROM DFINAnalytics.[dbo].[DFS_TableReadWrites];

/*order BY TableName, 
       RunDate, 
       DBName, 
       ServerName;*/

GO
/****** Object:  Table [dbo].[DFS_WaitTypes]    Script Date: 2/6/2019 8:19:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DFS_WaitTypes](
	[typecode] [nvarchar](50) NOT NULL,
	[definition] [nvarchar](max) NOT NULL,
	[UID] [uniqueidentifier] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[view_SessionStatus]    Script Date: 2/6/2019 8:19:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[view_SessionStatus]
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
/****** Object:  View [dbo].[vProcDependencies]    Script Date: 2/6/2019 8:19:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[vProcDependencies]
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
GO
/****** Object:  Table [dbo].[DFS_BlockingHistory]    Script Date: 2/6/2019 8:19:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DFS_BlockingHistory](
	[session_id] [smallint] NOT NULL,
	[blocking_session_id] [smallint] NULL,
	[cpu_time] [int] NOT NULL,
	[total_elapsed_time] [int] NOT NULL,
	[Database_Name] [nvarchar](128) NULL,
	[host_name] [nvarchar](128) NULL,
	[login_name] [nvarchar](128) NOT NULL,
	[original_login_name] [nvarchar](128) NOT NULL,
	[STATUS] [nvarchar](30) NOT NULL,
	[command] [nvarchar](16) NOT NULL,
	[Query_Text] [nvarchar](max) NULL,
	[CreateDate] [datetime] NULL,
	[RunID] [int] NULL,
	[UID] [uniqueidentifier] NULL,
	[RowNbr] [int] IDENTITY(1,1) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DFS_CleanedDFSTables]    Script Date: 2/6/2019 8:19:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DFS_CleanedDFSTables](
	[SvrName] [nvarchar](150) NOT NULL,
	[DBName] [nvarchar](150) NOT NULL,
	[TBLName] [nvarchar](150) NOT NULL,
	[RowCNT] [int] NULL,
	[DropRowCNT] [int] NULL,
	[CreateDate] [datetime] NULL,
	[UID] [uniqueidentifier] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DFS_CPU_BoundQry]    Script Date: 2/6/2019 8:19:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DFS_CPU_BoundQry](
	[SVRName] [nvarchar](128) NULL,
	[DBName] [nvarchar](128) NULL,
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
	[RunDate] [datetime] NULL,
	[RunID] [bigint] NULL,
	[UID] [uniqueidentifier] NOT NULL,
	[Processed] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DFS_CPU_BoundQry2000]    Script Date: 2/6/2019 8:19:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DFS_CPU_BoundQry2000](
	[SVRName] [nvarchar](128) NULL,
	[DBName] [nvarchar](128) NULL,
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
	[total_columnstore_segment_reads] [bigint] NULL,
	[last_columnstore_segment_reads] [bigint] NULL,
	[min_columnstore_segment_reads] [bigint] NULL,
	[max_columnstore_segment_reads] [bigint] NULL,
	[total_columnstore_segment_skips] [bigint] NULL,
	[last_columnstore_segment_skips] [bigint] NULL,
	[min_columnstore_segment_skips] [bigint] NULL,
	[max_columnstore_segment_skips] [bigint] NULL,
	[total_spills] [bigint] NULL,
	[last_spills] [bigint] NULL,
	[min_spills] [bigint] NULL,
	[max_spills] [bigint] NULL,
	[RunDate] [datetime] NOT NULL,
	[SSVer] [nvarchar](300) NULL,
	[RunID] [int] NOT NULL,
	[UID] [uniqueidentifier] NULL,
	[Processed] [int] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DFS_DB2Skip]    Script Date: 2/6/2019 8:19:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DFS_DB2Skip](
	[DB] [nvarchar](100) NULL,
	[UID] [uniqueidentifier] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DFS_DbFileSizing]    Script Date: 2/6/2019 8:19:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DFS_DbFileSizing](
	[Svr] [sysname] NOT NULL,
	[Database] [sysname] NOT NULL,
	[File] [sysname] NOT NULL,
	[size] [int] NOT NULL,
	[SizeMB] [int] NULL,
	[Database Total] [int] NULL,
	[max_size] [int] NOT NULL,
	[CreateDate] [datetime] NULL,
	[RowNbr] [int] IDENTITY(1,1) NOT NULL,
	[RunID] [bigint] NULL,
	[UID] [uniqueidentifier] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DFS_DBVersion]    Script Date: 2/6/2019 8:19:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DFS_DBVersion](
	[SVRName] [nvarchar](128) NULL,
	[DBName] [nvarchar](128) NULL,
	[SSVER] [nvarchar](250) NOT NULL,
	[SSVERID] [nvarchar](60) NOT NULL,
	[Rownbr] [int] IDENTITY(1,1) NOT NULL,
	[UID] [uniqueidentifier] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DFS_DeadlockStats]    Script Date: 2/6/2019 8:19:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DFS_DeadlockStats](
	[SPID] [int] NULL,
	[STATUS] [varchar](1000) NULL,
	[Login] [sysname] NULL,
	[HostName] [sysname] NULL,
	[BlkBy] [sysname] NULL,
	[DBName] [sysname] NULL,
	[Command] [varchar](1000) NULL,
	[CPUTime] [int] NULL,
	[DiskIO] [int] NULL,
	[LastBatch] [varchar](1000) NULL,
	[ProgramName] [varchar](1000) NULL,
	[SPID2] [int] NULL,
	[REQUESTID] [int] NULL,
	[RunDate] [datetime] NULL,
	[RunID] [int] NULL,
	[UID] [uniqueidentifier] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DFS_IndexFragErrors]    Script Date: 2/6/2019 8:19:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DFS_IndexFragErrors](
	[SqlCmd] [varchar](max) NULL,
	[DBNAME] [nvarchar](100) NULL,
	[RunID] [nvarchar](60) NULL,
	[UID] [uniqueidentifier] NULL,
	[RowNbr] [int] IDENTITY(1,1) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DFS_IndexFragHist]    Script Date: 2/6/2019 8:19:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DFS_IndexFragHist](
	[DBName] [nvarchar](254) NULL,
	[Schema] [nvarchar](254) NOT NULL,
	[Table] [nvarchar](254) NOT NULL,
	[Index] [nvarchar](254) NULL,
	[alloc_unit_type_desc] [nvarchar](60) NULL,
	[IndexProcessed] [int] NULL,
	[AvgPctFrag] [decimal](8, 2) NULL,
	[page_count] [bigint] NULL,
	[RunDate] [datetime] NULL,
	[RunID] [nvarchar](60) NULL,
	[Success] [int] NULL,
	[UID] [uniqueidentifier] NULL,
	[RowNbr] [int] IDENTITY(1,1) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DFS_IndexFragProgress]    Script Date: 2/6/2019 8:19:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DFS_IndexFragProgress](
	[SqlCmd] [varchar](max) NULL,
	[DBNAME] [nvarchar](100) NULL,
	[StartTime] [datetime] NULL,
	[EndTime] [datetime] NULL,
	[RunID] [nvarchar](60) NULL,
	[UID] [uniqueidentifier] NULL,
	[RowNbr] [int] IDENTITY(1,1) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DFS_IndexFragReorgHistory]    Script Date: 2/6/2019 8:19:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DFS_IndexFragReorgHistory](
	[DBName] [nvarchar](128) NULL,
	[Schema] [nvarchar](254) NOT NULL,
	[Table] [nvarchar](254) NOT NULL,
	[Index] [nvarchar](254) NULL,
	[OnlineReorg] [varchar](10) NULL,
	[Success] [varchar](10) NULL,
	[Rundate] [datetime] NULL,
	[RunID] [nvarchar](60) NULL,
	[Stmt] [varchar](max) NULL,
	[RowNbr] [int] IDENTITY(1,1) NOT NULL,
	[UID] [uniqueidentifier] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DFS_IndexReorgCmds]    Script Date: 2/6/2019 8:19:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DFS_IndexReorgCmds](
	[CMD] [nvarchar](max) NULL,
	[RowNbr] [int] IDENTITY(1,1) NOT NULL,
	[PctFrag] [decimal](10, 2) NULL,
	[UID] [uniqueidentifier] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DFS_IndexStats]    Script Date: 2/6/2019 8:19:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DFS_IndexStats](
	[SvrName] [nvarchar](128) NULL,
	[DB] [nvarchar](128) NULL,
	[Obj] [nvarchar](128) NULL,
	[IdxName] [sysname] NULL,
	[range_scan_count] [bigint] NOT NULL,
	[singleton_lookup_count] [bigint] NOT NULL,
	[row_lock_count] [bigint] NOT NULL,
	[page_lock_count] [bigint] NOT NULL,
	[TotNo_Of_Locks] [bigint] NULL,
	[row_lock_wait_count] [bigint] NOT NULL,
	[page_lock_wait_count] [bigint] NOT NULL,
	[TotNo_Of_Blocks] [bigint] NULL,
	[row_lock_wait_in_ms] [bigint] NOT NULL,
	[page_lock_wait_in_ms] [bigint] NOT NULL,
	[TotBlock_Wait_TimeMS] [bigint] NULL,
	[index_id] [int] NOT NULL,
	[CreateDate] [datetime] NULL,
	[SSVER] [nvarchar](250) NULL,
	[RunID] [bigint] NULL,
	[UID] [uniqueidentifier] NULL,
	[RowNbr] [int] IDENTITY(1,1) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DFS_IO_BoundQry]    Script Date: 2/6/2019 8:19:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DFS_IO_BoundQry](
	[SVRName] [nvarchar](128) NULL,
	[DBName] [nvarchar](128) NULL,
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
	[RunDate] [datetime] NULL,
	[RunID] [bigint] NULL,
	[UID] [uniqueidentifier] NOT NULL,
	[Processed] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DFS_IO_BoundQry2000]    Script Date: 2/6/2019 8:19:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DFS_IO_BoundQry2000](
	[SVRName] [nvarchar](128) NULL,
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
	[total_columnstore_segment_reads] [bigint] NULL,
	[last_columnstore_segment_reads] [bigint] NULL,
	[min_columnstore_segment_reads] [bigint] NULL,
	[max_columnstore_segment_reads] [bigint] NULL,
	[total_columnstore_segment_skips] [bigint] NULL,
	[last_columnstore_segment_skips] [bigint] NULL,
	[min_columnstore_segment_skips] [bigint] NULL,
	[max_columnstore_segment_skips] [bigint] NULL,
	[total_spills] [bigint] NULL,
	[last_spills] [bigint] NULL,
	[min_spills] [bigint] NULL,
	[max_spills] [bigint] NULL,
	[RunDate] [datetime] NOT NULL,
	[SSVER] [nvarchar](300) NULL,
	[RunID] [int] NOT NULL,
	[UID] [uniqueidentifier] NULL,
	[processed] [int] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DFS_MissingFKIndexes]    Script Date: 2/6/2019 8:19:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DFS_MissingFKIndexes](
	[SVR] [nvarchar](128) NULL,
	[DBName] [nvarchar](128) NULL,
	[SSVER] [nvarchar](250) NULL,
	[FK_Constraint] [sysname] NOT NULL,
	[FK_Table] [sysname] NOT NULL,
	[FK_Column] [nvarchar](128) NULL,
	[ParentTable] [sysname] NOT NULL,
	[ParentColumn] [nvarchar](128) NULL,
	[IndexName] [sysname] NULL,
	[SQL] [nvarchar](1571) NULL,
	[CreateDate] [datetime] NOT NULL,
	[UID] [uniqueidentifier] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DFS_MissingIndexes]    Script Date: 2/6/2019 8:19:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DFS_MissingIndexes](
	[ServerName] [nvarchar](128) NULL,
	[DBName] [nvarchar](128) NULL,
	[Affected_table] [sysname] NOT NULL,
	[K] [int] NULL,
	[Keys] [nvarchar](4000) NULL,
	[INCLUDE] [nvarchar](4000) NULL,
	[sql_statement] [nvarchar](4000) NULL,
	[user_seeks] [bigint] NOT NULL,
	[user_scans] [bigint] NOT NULL,
	[est_impact] [bigint] NULL,
	[avg_user_impact] [float] NULL,
	[last_user_seek] [datetime] NULL,
	[SecondsUptime] [int] NULL,
	[CreateDate] [datetime] NULL,
	[UID] [uniqueidentifier] NULL,
	[RowNbr] [int] IDENTITY(1,1) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DFS_PerfMonitor]    Script Date: 2/6/2019 8:19:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DFS_PerfMonitor](
	[SVRNAME] [nvarchar](150) NULL,
	[DBNAME] [nvarchar](150) NULL,
	[SSVER] [nvarchar](250) NULL,
	[RunID] [int] NOT NULL,
	[ProcName] [varchar](100) NOT NULL,
	[LocID] [varchar](50) NOT NULL,
	[UKEY] [uniqueidentifier] NOT NULL,
	[StartTime] [datetime2](7) NULL,
	[EndTime] [datetime2](7) NULL,
	[ElapsedTime] [decimal](18, 3) NULL,
	[CreateDate] [datetime] NULL,
	[UID] [uniqueidentifier] NULL,
 CONSTRAINT [PK_PerfMonitor] PRIMARY KEY CLUSTERED 
(
	[UKEY] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DFS_QryOptStats]    Script Date: 2/6/2019 8:19:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DFS_QryOptStats](
	[schemaname] [nvarchar](128) NULL,
	[viewname] [sysname] NOT NULL,
	[viewid] [int] NOT NULL,
	[databasename] [nvarchar](128) NULL,
	[databaseid] [smallint] NULL,
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
	[total_columnstore_segment_reads] [bigint] NULL,
	[last_columnstore_segment_reads] [bigint] NULL,
	[min_columnstore_segment_reads] [bigint] NULL,
	[max_columnstore_segment_reads] [bigint] NULL,
	[total_columnstore_segment_skips] [bigint] NULL,
	[last_columnstore_segment_skips] [bigint] NULL,
	[min_columnstore_segment_skips] [bigint] NULL,
	[max_columnstore_segment_skips] [bigint] NULL,
	[total_spills] [bigint] NULL,
	[last_spills] [bigint] NULL,
	[min_spills] [bigint] NULL,
	[max_spills] [bigint] NULL,
	[RunDate] [datetime] NULL,
	[SSVER] [nvarchar](300) NULL,
	[UID] [uniqueidentifier] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DFS_QryPlanBridge]    Script Date: 2/6/2019 8:19:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DFS_QryPlanBridge](
	[query_hash] [binary](8) NULL,
	[query_plan_hash] [binary](8) NULL,
	[PerfType] [char](1) NOT NULL,
	[TblType] [nvarchar](10) NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[LastUpdate] [datetime] NOT NULL,
	[NbrHits] [int] NULL,
	[UID] [uniqueidentifier] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DFS_QrysPlans]    Script Date: 2/6/2019 8:19:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DFS_QrysPlans](
	[query_hash] [binary](8) NULL,
	[query_plan_hash] [binary](8) NULL,
	[UID] [uniqueidentifier] NOT NULL,
	[PerfType] [nvarchar](10) NOT NULL,
	[text] [nvarchar](max) NULL,
	[query_plan] [xml] NULL,
	[CreateDate] [datetime] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DFS_RecordCount]    Script Date: 2/6/2019 8:19:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DFS_RecordCount](
	[ProcName] [nvarchar](150) NOT NULL,
	[HitCount] [int] NULL,
	[SvrName] [nvarchar](150) NOT NULL,
	[DBName] [nvarchar](150) NOT NULL,
	[LastUpdate] [datetime] NULL,
	[UID] [uniqueidentifier] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DFS_SEQ]    Script Date: 2/6/2019 8:19:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DFS_SEQ](
	[GenDate] [datetime] NULL,
	[SeqID] [int] IDENTITY(1,1) NOT NULL,
	[UID] [uniqueidentifier] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DFS_SequenceTABLE]    Script Date: 2/6/2019 8:19:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DFS_SequenceTABLE](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[UID] [uniqueidentifier] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DFS_TableSizeAndRowCnt]    Script Date: 2/6/2019 8:19:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DFS_TableSizeAndRowCnt](
	[SvrName] [nvarchar](150) NOT NULL,
	[DBName] [nvarchar](150) NOT NULL,
	[TableName] [sysname] NOT NULL,
	[SchemaName] [sysname] NULL,
	[RowCounts] [bigint] NULL,
	[TotalSpaceKB] [bigint] NULL,
	[UsedSpaceKB] [bigint] NULL,
	[UnusedSpaceKB] [bigint] NULL,
	[UID] [uniqueidentifier] NOT NULL,
	[CreateDate] [datetime] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DFS_TableStats]    Script Date: 2/6/2019 8:19:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DFS_TableStats](
	[ServerName] [nvarchar](128) NULL,
	[DBName] [nvarchar](128) NULL,
	[TableName] [nvarchar](128) NULL,
	[Reads] [int] NULL,
	[Writes] [int] NULL,
	[ReadsWrites] [int] NULL,
	[SampleDays] [decimal](18, 8) NULL,
	[SampleSeconds] [int] NULL,
	[RunDate] [datetime] NULL,
	[UID] [uniqueidentifier] NULL,
	[RowID] [bigint] IDENTITY(1,1) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DFS_TempProcErrors]    Script Date: 2/6/2019 8:19:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DFS_TempProcErrors](
	[ProcName] [nvarchar](150) NOT NULL,
	[ProcText] [nvarchar](max) NULL,
	[Success] [char](1) NULL,
	[CreateDate] [datetime] NULL,
	[UID] [uniqueidentifier] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DFS_TranLocks]    Script Date: 2/6/2019 8:19:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DFS_TranLocks](
	[SPID] [int] NOT NULL,
	[SvrName] [nvarchar](128) NULL,
	[DatabaseName] [nvarchar](128) NULL,
	[LockedObjectName] [sysname] NOT NULL,
	[LockedObjectId] [int] NOT NULL,
	[LockedResource] [nvarchar](60) NOT NULL,
	[LockType] [nvarchar](60) NOT NULL,
	[SqlStatementText] [nvarchar](max) NULL,
	[LoginName] [nvarchar](128) NOT NULL,
	[HostName] [nvarchar](128) NULL,
	[IsUserTransaction] [bit] NOT NULL,
	[TransactionName] [nvarchar](32) NOT NULL,
	[AuthenticationMethod] [nvarchar](40) NOT NULL,
	[RunID] [int] NULL,
	[CreateDate] [datetime] NULL,
	[UID] [uniqueidentifier] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DFS_TxMonitorIDX]    Script Date: 2/6/2019 8:19:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DFS_TxMonitorIDX](
	[SvrName] [nvarchar](128) NULL,
	[DBName] [nvarchar](128) NULL,
	[database_id] [int] NOT NULL,
	[TableName] [nvarchar](128) NULL,
	[UpdatedRows] [bigint] NOT NULL,
	[LastUpdateTime] [datetime] NULL,
	[CreateDate] [datetime] NULL,
	[ExecutionDate] [datetime] NOT NULL,
	[UID] [uniqueidentifier] NOT NULL,
	[RunID] [int] NULL,
	[Rownbr] [int] IDENTITY(1,1) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DFS_TxMonitorTableIndexStats]    Script Date: 2/6/2019 8:19:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DFS_TxMonitorTableIndexStats](
	[SVR] [nvarchar](128) NULL,
	[SchemaName] [nvarchar](128) NULL,
	[DBName] [nvarchar](128) NULL,
	[TableName] [nvarchar](128) NULL,
	[IndexName] [sysname] NULL,
	[IndexID] [int] NOT NULL,
	[user_seeks] [bigint] NOT NULL,
	[user_scans] [bigint] NOT NULL,
	[user_lookups] [bigint] NOT NULL,
	[user_updates] [bigint] NOT NULL,
	[last_user_seek] [datetime] NULL,
	[last_user_scan] [datetime] NULL,
	[last_user_lookup] [datetime] NULL,
	[last_user_update] [datetime] NULL,
	[DBID] [smallint] NULL,
	[ExecutionDate] [datetime] NOT NULL,
	[RunID] [int] NOT NULL,
	[UID] [uniqueidentifier] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DFS_TxMonitorTableStats]    Script Date: 2/6/2019 8:19:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DFS_TxMonitorTableStats](
	[SVR] [nvarchar](128) NULL,
	[SchemaName] [nvarchar](128) NULL,
	[DBName] [nvarchar](128) NULL,
	[TableName] [nvarchar](128) NULL,
	[IndexName] [sysname] NULL,
	[IndexID] [int] NOT NULL,
	[user_seeks] [bigint] NOT NULL,
	[user_scans] [bigint] NOT NULL,
	[user_lookups] [bigint] NOT NULL,
	[user_updates] [bigint] NOT NULL,
	[last_user_seek] [datetime] NULL,
	[last_user_scan] [datetime] NULL,
	[last_user_lookup] [datetime] NULL,
	[last_user_update] [datetime] NULL,
	[DBID] [smallint] NULL,
	[ExecutionDate] [datetime] NOT NULL,
	[RunID] [int] NOT NULL,
	[UID] [uniqueidentifier] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DFS_TxMonitorTblUpdates]    Script Date: 2/6/2019 8:19:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DFS_TxMonitorTblUpdates](
	[SVR] [nvarchar](128) NULL,
	[database_id] [int] NOT NULL,
	[SchemaName] [nvarchar](128) NULL,
	[DBname] [nvarchar](128) NULL,
	[TableName] [nvarchar](128) NULL,
	[user_lookups] [int] NULL,
	[user_scans] [int] NULL,
	[user_seeks] [int] NULL,
	[UpdatedRows] [bigint] NOT NULL,
	[LastUpdateTime] [datetime] NULL,
	[CreateDate] [datetime] NULL,
	[ExecutionDate] [datetime] NOT NULL,
	[RowID] [bigint] IDENTITY(1,1) NOT NULL,
	[RunID] [int] NULL,
	[UID] [uniqueidentifier] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DFS_WaitStats]    Script Date: 2/6/2019 8:19:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DFS_WaitStats](
	[SvrName] [nvarchar](150) NOT NULL,
	[DBName] [nvarchar](150) NOT NULL,
	[session_id] [smallint] NOT NULL,
	[wait_type] [nvarchar](60) NOT NULL,
	[waiting_tasks_count] [bigint] NOT NULL,
	[wait_time_ms] [bigint] NOT NULL,
	[max_wait_time_ms] [bigint] NOT NULL,
	[signal_wait_time_ms] [bigint] NOT NULL,
	[RunID] [int] NULL,
	[CreateDate] [datetime] NOT NULL,
	[UID] [uniqueidentifier] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SequenceTABLE]    Script Date: 2/6/2019 8:19:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SequenceTABLE](
	[ID] [bigint] IDENTITY(1,1) NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DFS_BlockingHistory] ADD  DEFAULT (newid()) FOR [UID]
GO
ALTER TABLE [dbo].[DFS_CleanedDFSTables] ADD  DEFAULT (getdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[DFS_CleanedDFSTables] ADD  DEFAULT (newid()) FOR [UID]
GO
ALTER TABLE [dbo].[DFS_CPU_BoundQry] ADD  DEFAULT (newid()) FOR [UID]
GO
ALTER TABLE [dbo].[DFS_CPU_BoundQry] ADD  DEFAULT ((0)) FOR [Processed]
GO
ALTER TABLE [dbo].[DFS_CPU_BoundQry2000] ADD  DEFAULT (newid()) FOR [UID]
GO
ALTER TABLE [dbo].[DFS_CPU_BoundQry2000] ADD  DEFAULT ((0)) FOR [Processed]
GO
ALTER TABLE [dbo].[DFS_DB2Skip] ADD  DEFAULT (newid()) FOR [UID]
GO
ALTER TABLE [dbo].[DFS_DbFileSizing] ADD  DEFAULT (getdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[DFS_DbFileSizing] ADD  DEFAULT (newid()) FOR [UID]
GO
ALTER TABLE [dbo].[DFS_DBVersion] ADD  DEFAULT (newid()) FOR [SSVERID]
GO
ALTER TABLE [dbo].[DFS_DBVersion] ADD  DEFAULT (newid()) FOR [UID]
GO
ALTER TABLE [dbo].[DFS_DeadlockStats] ADD  DEFAULT (getdate()) FOR [RunDate]
GO
ALTER TABLE [dbo].[DFS_DeadlockStats] ADD  DEFAULT (newid()) FOR [UID]
GO
ALTER TABLE [dbo].[DFS_IndexFragErrors] ADD  DEFAULT (newid()) FOR [UID]
GO
ALTER TABLE [dbo].[DFS_IndexFragHist] ADD  DEFAULT ((0)) FOR [IndexProcessed]
GO
ALTER TABLE [dbo].[DFS_IndexFragHist] ADD  DEFAULT (getdate()) FOR [RunDate]
GO
ALTER TABLE [dbo].[DFS_IndexFragHist] ADD  DEFAULT (newid()) FOR [UID]
GO
ALTER TABLE [dbo].[DFS_IndexFragProgress] ADD  DEFAULT (newid()) FOR [UID]
GO
ALTER TABLE [dbo].[DFS_IndexFragReorgHistory] ADD  DEFAULT (getdate()) FOR [Rundate]
GO
ALTER TABLE [dbo].[DFS_IndexFragReorgHistory] ADD  DEFAULT (newid()) FOR [UID]
GO
ALTER TABLE [dbo].[DFS_IndexReorgCmds] ADD  DEFAULT (newid()) FOR [UID]
GO
ALTER TABLE [dbo].[DFS_IndexStats] ADD  DEFAULT (newid()) FOR [UID]
GO
ALTER TABLE [dbo].[DFS_IO_BoundQry] ADD  DEFAULT (newid()) FOR [UID]
GO
ALTER TABLE [dbo].[DFS_IO_BoundQry] ADD  DEFAULT ((0)) FOR [Processed]
GO
ALTER TABLE [dbo].[DFS_IO_BoundQry2000] ADD  DEFAULT (newid()) FOR [UID]
GO
ALTER TABLE [dbo].[DFS_IO_BoundQry2000] ADD  DEFAULT ((0)) FOR [processed]
GO
ALTER TABLE [dbo].[DFS_MissingFKIndexes] ADD  DEFAULT (newid()) FOR [UID]
GO
ALTER TABLE [dbo].[DFS_MissingIndexes] ADD  DEFAULT (getdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[DFS_MissingIndexes] ADD  DEFAULT (newid()) FOR [UID]
GO
ALTER TABLE [dbo].[DFS_PerfMonitor] ADD  CONSTRAINT [DF_PerfMonitor_UKEY]  DEFAULT (newid()) FOR [UKEY]
GO
ALTER TABLE [dbo].[DFS_PerfMonitor] ADD  DEFAULT (getdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[DFS_PerfMonitor] ADD  DEFAULT (newid()) FOR [UID]
GO
ALTER TABLE [dbo].[DFS_QryOptStats] ADD  DEFAULT (getdate()) FOR [RunDate]
GO
ALTER TABLE [dbo].[DFS_QryOptStats] ADD  DEFAULT (newid()) FOR [UID]
GO
ALTER TABLE [dbo].[DFS_QryPlanBridge] ADD  DEFAULT (getdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[DFS_QryPlanBridge] ADD  DEFAULT (getdate()) FOR [LastUpdate]
GO
ALTER TABLE [dbo].[DFS_QryPlanBridge] ADD  DEFAULT ((0)) FOR [NbrHits]
GO
ALTER TABLE [dbo].[DFS_QryPlanBridge] ADD  DEFAULT (newid()) FOR [UID]
GO
ALTER TABLE [dbo].[DFS_QrysPlans] ADD  DEFAULT (newid()) FOR [UID]
GO
ALTER TABLE [dbo].[DFS_QrysPlans] ADD  DEFAULT (getdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[DFS_RecordCount] ADD  DEFAULT ((0)) FOR [HitCount]
GO
ALTER TABLE [dbo].[DFS_RecordCount] ADD  DEFAULT (newid()) FOR [UID]
GO
ALTER TABLE [dbo].[DFS_SEQ] ADD  DEFAULT (getdate()) FOR [GenDate]
GO
ALTER TABLE [dbo].[DFS_SEQ] ADD  DEFAULT (newid()) FOR [UID]
GO
ALTER TABLE [dbo].[DFS_SequenceTABLE] ADD  DEFAULT (newid()) FOR [UID]
GO
ALTER TABLE [dbo].[DFS_TableGrowthHistory] ADD  DEFAULT (getdate()) FOR [EntryDate]
GO
ALTER TABLE [dbo].[DFS_TableGrowthHistory] ADD  DEFAULT (newid()) FOR [UID]
GO
ALTER TABLE [dbo].[DFS_TableSizeAndRowCnt] ADD  DEFAULT (newid()) FOR [UID]
GO
ALTER TABLE [dbo].[DFS_TableSizeAndRowCnt] ADD  DEFAULT (getdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[DFS_TableStats] ADD  CONSTRAINT [DF_DFS_TableStats_RunDate]  DEFAULT (getdate()) FOR [RunDate]
GO
ALTER TABLE [dbo].[DFS_TableStats] ADD  DEFAULT (newid()) FOR [UID]
GO
ALTER TABLE [dbo].[DFS_TempProcErrors] ADD  DEFAULT (getdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[DFS_TempProcErrors] ADD  DEFAULT (newid()) FOR [UID]
GO
ALTER TABLE [dbo].[DFS_TranLocks] ADD  DEFAULT (getdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[DFS_TranLocks] ADD  DEFAULT (newid()) FOR [UID]
GO
ALTER TABLE [dbo].[DFS_TxMonitorIDX] ADD  DEFAULT (getdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[DFS_TxMonitorTableIndexStats] ADD  DEFAULT (newid()) FOR [UID]
GO
ALTER TABLE [dbo].[DFS_TxMonitorTblUpdates] ADD  DEFAULT (getdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[DFS_TxMonitorTblUpdates] ADD  DEFAULT (newid()) FOR [UID]
GO
ALTER TABLE [dbo].[DFS_WaitStats] ADD  DEFAULT (@@servername) FOR [SvrName]
GO
ALTER TABLE [dbo].[DFS_WaitStats] ADD  DEFAULT (db_name()) FOR [DBName]
GO
ALTER TABLE [dbo].[DFS_WaitStats] ADD  DEFAULT (getdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[DFS_WaitStats] ADD  DEFAULT (newid()) FOR [UID]
GO
ALTER TABLE [dbo].[DFS_WaitTypes] ADD  DEFAULT (newid()) FOR [UID]
GO
ALTER TABLE [dbo].[DFS_Workload] ADD  DEFAULT (newid()) FOR [UID]
GO
ALTER TABLE [dbo].[DFS_Workload] ADD  DEFAULT (getdate()) FOR [RunDate]
GO
/****** Object:  StoredProcedure [dbo].[_CreateTempProc]    Script Date: 2/6/2019 8:19:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
Procedure _CreateTempProc pulls the source code from an existing stored procedure
and converts it to be created on the TEMPDB. This is done so thet the loss of the 
hidden functionality of an "sp_" procedure created in the master Database can be 
overcome. Having a proc in TEMPDB allows us to run it under any database and use the 
context of the current database. 
*/
CREATE PROCEDURE [dbo].[_CreateTempProc]
( 
				 @ProcName nvarchar(150), @ShowsqL int= 0
)
AS
BEGIN
	DECLARE @rc int= 1;
	DECLARE @tgtproc nvarchar(150)= @ProcName;
	DECLARE @i int= 0;
	DECLARE @j int= 0;
	DECLARE @k int= 0;
	DECLARE @sql nvarchar(max)= '';
	DECLARE @tgttext nvarchar(50)= 'create procedure';
	DECLARE @str nvarchar(150)= '';
	DECLARE @pname nvarchar(150)= '';
	DECLARE @firstline nvarchar(1000)= '';
	SET @pname =
	(
		SELECT ROUTINE_NAME
		FROM INFORMATION_SCHEMA.ROUTINES
		WHERE ROUTINE_NAME = @ProcName
	);
	DECLARE @objectid int= 0;
	SELECT @objectid = OBJECT_ID(@pname);
	SET @sql = OBJECT_DEFINITION(@objectid);
	SET @sql = dbo.UTIL_RemoveCommentsFromCode( @sql );
	SET @i = @i + LEN(@sql);

	PRINT @ProcName + ' LEN = ' + CAST(@i AS nvarchar(15));

	SET @j = (SELECT CHARINDEX(@pname, @sql));
	SET @i = (SELECT CHARINDEX(@tgttext, @sql));
	SET @i = @i + LEN(@tgttext);
	SET @sql = SUBSTRING(@sql, @j, 99999);
	SET @sql = LTRIM(@sql);
	SET @k = (SELECT CHARINDEX(CHAR(10), @sql));
	if (@k <=0 or @k > 1000 )
		set @k = 1000;
	SET @firstline = SUBSTRING(@sql, 1, @k);
	SET @k = (SELECT CHARINDEX(']', @firstline));
	IF(@k > 0)
	BEGIN
		SET @sql = STUFF(@sql, @k, 1, ' ');
	END;
	SET @str = SUBSTRING(@sql, 1, 99999);
	DECLARE @obj nvarchar(150)= 'tempdb..#' + @pname;
	SET @sql = 'create procedure #' + @sql;

	BEGIN TRY
		IF OBJECT_ID('tempdb..#' + @pname + '''') IS NULL
		BEGIN
			INSERT INTO DFS_TempProcErrors( ProcName, ProcText )
			VALUES( @pname, @sql );
			EXECUTE sp_executesql @sql;
			UPDATE DFS_TempProcErrors
			  SET success = 'Y'
			WHERE ProcName = @pname;
			SET @rc = 1;
		END;
		ELSE
		BEGIN
			PRINT '#' + @pname + ' already in temp...';
			INSERT INTO DFS_TempProcErrors( ProcName, ProcText, success )
			VALUES( @pname, @sql, 'X' );
			SET @rc = 1;
		END;
	END TRY
	BEGIN CATCH
		SET @rc = 0;
		UPDATE DFS_TempProcErrors
		  SET success = 'N'
		WHERE ProcName = @pname;
		EXECUTE @i = UTIL_GetErrorInfo;

		IF @i = -1
		BEGIN
			INSERT INTO DFS_TempProcErrors( ProcName, ProcText, success )
			VALUES( @pname, @sql, 'X' );
			SET @rc = 1;
		END;
		IF @i = 1
		BEGIN
			SET @rc = -1;
			PRINT 'IT APPEARS ' + 'tempdb..#' + @pname + ' FAILED.';
			IF(@ShowsqL = 1)
			BEGIN
				PRINT '****************************************';
				PRINT @SQL;
				SELECT @procname AS ProcName, @SQL AS SqlText;
				PRINT '****************************************';
			END;
		END;
	END CATCH;
	RETURN @rc;
END;


/****************** PROCESSING FILE *************************************/

GO
/****** Object:  StoredProcedure [dbo].[_Emergency_StartAllAnalyticsJobs]    Script Date: 2/6/2019 8:19:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- exec _Emergency_StartAllAnalyticsJobs
CREATE PROCEDURE [dbo].[_Emergency_StartAllAnalyticsJobs]
AS
    BEGIN

        /* SELECT 'exec _Emergency_StartAllAnalyticsJobs  N'''+  [name] + ''';' FROM msdb.dbo.sysjobs where name like 'JOB_%';*/

        EXEC msdb.dbo.sp_start_job N'JOB_ UTIL_DefragAllIndexes';
        EXEC msdb.dbo.sp_start_job N'JOB_ UTIL_Monitor_TPS';
        EXEC msdb.dbo.sp_start_job N'JOB_ UTIL_ReorgFragmentedIndexes';
        EXEC msdb.dbo.sp_start_job N'JOB_DBMON_TxMonitorTableStats';
        EXEC msdb.dbo.sp_start_job N'JOB_DFS_CleanDFSTables';
        EXEC msdb.dbo.sp_start_job N'JOB_DFS_GetAllTableSizesAndRowCnt';
        EXEC msdb.dbo.sp_start_job N'JOB_DFS_MonitorLocks';
        EXEC msdb.dbo.sp_start_job N'JOB_MonitorWorkload';
        EXEC msdb.dbo.sp_start_job N'JOB_UTIL_DbMon_IndexVolitity';
        EXEC msdb.dbo.sp_start_job N'JOB_UTIL_DFS_DbSize';
        EXEC msdb.dbo.sp_start_job N'JOB_UTIL_GetIndexStats';
        EXEC msdb.dbo.sp_start_job N'JOB_UTIL_MonitorDeadlocks';
        EXEC msdb.dbo.sp_start_job N'JOB_UTIL_QryPlanStats';
        EXEC msdb.dbo.sp_start_job N'JOB_UTIL_TrackSessionWaitStats';
        EXEC msdb.dbo.sp_start_job N'JOB_UTIL_WorstPerformingQuerries';
		EXEC msdb.dbo.sp_start_job N'[UTIL_DBMon_EachDB]';
    END;
GO
/****** Object:  StoredProcedure [dbo].[_GetProcDependencies]    Script Date: 2/6/2019 8:19:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[_GetProcDependencies] (@ProcName nvarchar(150))
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
GO
/****** Object:  StoredProcedure [dbo].[DFS_CPU_BoundQry2000_ProcessTable]    Script Date: 2/6/2019 8:19:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
exec DFS_CPU_BoundQry2000_ProcessTable
*/

CREATE PROCEDURE [dbo].[DFS_CPU_BoundQry2000_ProcessTable]
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
            FROM [DFINAnalytics].[dbo].[DFS_QryPlanBridge] AS A
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
                  SET 
                      Processed = 1
                WHERE [query_hash] = @query_hash
                      AND [query_plan_hash] = @query_plan_hash
                      AND processed = 0;
                FETCH NEXT FROM db_cursor INTO @query_hash, @query_plan_hash, @UID, @cnt;
            END;
        CLOSE db_cursor;
        DEALLOCATE db_cursor;
        UPDATE [dbo].[DFS_CPU_BoundQry2000]
          SET 
              Processed = 1
        WHERE [UID] IN
        (
            SELECT B.[UID]
            FROM [DFINAnalytics].[dbo].[DFS_QryPlanBridge] AS A
                      JOIN [dbo].[DFS_CPU_BoundQry2000] AS B
                      ON B.[query_hash] = A.[query_hash]
                         AND B.[query_plan_hash] = A.[query_plan_hash]
            WHERE B.processed = 0
        );
    END;

/****************** PROCESSING FILE *************************************/

GO
/****** Object:  StoredProcedure [dbo].[DFS_GetAllTableSizesAndRowCnt]    Script Date: 2/6/2019 8:19:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- exec DFS_GetAllTableSizesAndRowCnt
CREATE PROCEDURE [dbo].[DFS_GetAllTableSizesAndRowCnt]
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
               ORDER BY t.Name;
    END;
GO
/****** Object:  StoredProcedure [dbo].[DFS_IO_BoundQry2000_ProcessTable]    Script Date: 2/6/2019 8:19:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
exec DFS_IO_BoundQry2000_ProcessTable
*/
CREATE PROCEDURE [dbo].[DFS_IO_BoundQry2000_ProcessTable]
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
                 [DFINAnalytics].[dbo].[DFS_QryPlanBridge] AS A
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
                  SET Processed = 1
                WHERE [query_hash] = @query_hash
                      AND [query_plan_hash] = @query_plan_hash;
                FETCH NEXT FROM db_cursor INTO @query_hash, @query_plan_hash, @UID, @cnt;
            END;
        CLOSE db_cursor;
        DEALLOCATE db_cursor;
        UPDATE [dbo].[DFS_IO_BoundQry2000]
          SET Processed = 1
        WHERE [UID] IN
        (
            SELECT B.[UID]
            FROM
                 [DFINAnalytics].[dbo].[DFS_QryPlanBridge] AS A
                 JOIN [dbo].[DFS_IO_BoundQry2000] AS B
                      ON B.[query_hash] = A.[query_hash]
                         AND B.[query_plan_hash] = A.[query_plan_hash]
            WHERE B.processed = 0
        );
    END;

/****************** PROCESSING FILE *************************************/

GO
/****** Object:  StoredProcedure [dbo].[DFS_MonitorLocks]    Script Date: 2/6/2019 8:19:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
 exec [DFINAnalytics].dbo.DFS_MonitorLocks
 select * from DFINAnalytics.[dbo].[DFS_TranLocks]
 */
CREATE PROCEDURE [dbo].[DFS_MonitorLocks]
AS
begin
     DECLARE @RunID INT;
     EXEC @RunID = sp_UTIL_GetSeq;
     INSERT INTO DFINAnalytics.[dbo].[DFS_TranLocks]
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
      [CreateDate]
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
            GETDATE()
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
     -- W. Dale Miller
     -- DMA, Limited
     -- Offered under GNU License
     -- July 26, 2016
end
GO
/****** Object:  StoredProcedure [dbo].[DFS_MonitorTableStats]    Script Date: 2/6/2019 8:19:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DFS_MonitorTableStats]
AS
    BEGIN
        DECLARE DBNameCursor CURSOR
        FOR SELECT Name
            FROM sys.databases
            WHERE Name NOT IN('master', 'model', 'msdb', 'tempdb', 'distribution')
            ORDER BY Name;
        DECLARE @DBName NVARCHAR(128) = db_name();
        DECLARE @cmd VARCHAR(4000);
        IF OBJECT_ID(N'tempdb..#TempResults') IS NOT NULL
            BEGIN
                DROP TABLE #TempResults;
        END;
        CREATE TABLE #TempResults
        (ServerName    NVARCHAR(128), 
         DBName        NVARCHAR(128), 
         TableName     NVARCHAR(128), 
         Reads         INT, 
         Writes        INT, 
         ReadsWrites   INT, 
         SampleDays    DECIMAL(18, 8), 
         SampleSeconds INT
        );
        OPEN DBNameCursor;
        FETCH NEXT FROM DBNameCursor INTO @DBName;
        WHILE @@fetch_status = 0
            BEGIN 
                ---------------------------------------------------- 
                -- Print @DBName 
                SELECT @cmd = 'Use ' + @DBName + '; ';
                SELECT @cmd = @cmd + ' Insert Into #TempResults 
	SELECT @@ServerName AS ServerName, 
	DB_NAME() AS DBName, 
	object_name(ddius.object_id) AS TableName , 
	SUM(ddius.user_seeks 
	+ ddius.user_scans 
	+ ddius.user_lookups) AS Reads, 
	SUM(ddius.user_updates) as Writes, 
	SUM(ddius.user_seeks 
	+ ddius.user_scans 
	+ ddius.user_lookups 
	+ ddius.user_updates) as ReadsWrites, 
	(SELECT datediff(s,create_date, GETDATE()) / 86400.0 
	FROM sys.databases WHERE name = ''tempdb'') AS SampleDays, 
	(SELECT datediff(s,create_date, GETDATE()) 
	FROM sys.databases WHERE name = ''tempdb'') as SampleSeconds 
	FROM sys.dm_db_index_usage_stats ddius 
	INNER JOIN sys.indexes i
	ON ddius.object_id = i.object_id 
	AND i.index_id = ddius.index_id 
	WHERE objectproperty(ddius.object_id,''IsUserTable'') = 1 --True 
	AND ddius.database_id = db_id() 
	GROUP BY object_name(ddius.object_id) 
	ORDER BY ReadsWrites DESC;'; 
                --PRINT @cmd 
                EXECUTE (@cmd); 
                ----------------------------------------------------- 
                FETCH NEXT FROM DBNameCursor INTO @DBName;
            END;
        CLOSE DBNameCursor;
        DEALLOCATE DBNameCursor;
        INSERT INTO dbo.DFS_TableStats
        ([ServerName], 
         [DBName], 
         [TableName], 
         [Reads], 
         [Writes], 
         [ReadsWrites], 
         [SampleDays], 
         [SampleSeconds]
        )
               SELECT *
               FROM #TempResults
               ORDER BY DBName, 
                        TableName;        		
		DROP TABLE #TempResults; 
    END;
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

GO
/****** Object:  StoredProcedure [dbo].[DMA_ForEachDB]    Script Date: 2/6/2019 8:19:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/* Author: W. Dale Miller
 Date:   2011/07/26

 Description: Executes a statement against multiple databases
 Parameters:
    @statement:    The statement to execute
    @replacechar:  The character to replace with the database name
    @name_pattern: The pattern to select the databases
                   It can be:
                   * NULL     - Returns all databases
                   * [USER]   - Returns users databases only
                   * [SYSTEM] - Returns system databases only
                   * A pattern to use in a LIKE predicate against the database name*/

CREATE PROCEDURE [dbo].[DMA_ForEachDB] @statement    NVARCHAR(MAX), 
                                 @replacechar  NCHAR(1)      = N'?', 
                                 @name_pattern NVARCHAR(500) = NULL
AS
    BEGIN
        SET NOCOUNT ON;
        DECLARE @sql NVARCHAR(MAX);

/* LEVEL 3:
     Build an intermediate statement that replaces the '?' char*/

        SET @sql = 'SET @statement = REPLACE(@statement,''' + @replacechar + ''',DB_NAME()); EXEC(@statement);';
        SET @sql = REPLACE(@sql, '''', '''''');
        SET @sql = 'N''' + @sql + '''';

/* LEVEL 2:
     Build a statement to execute on each database context*/

        WITH dbs
             AS (SELECT *, 
                        system_db = CASE
                                        WHEN name IN('master', 'model', 'msdb', 'tempdb')
                                        THEN 1
                                        ELSE 0
                                    END
                 FROM sys.databases
                 WHERE DATABASEPROPERTY(name, 'IsSingleUser') = 0
                       AND HAS_DBACCESS(name) = 1
                       AND state_desc = 'ONLINE')
             SELECT @sql =
             (
                 SELECT 'EXEC ' + QUOTENAME(name) + '.sys.sp_executesql ' + @sql + ',' + 'N''@statement nvarchar(max)'',' + '@statement;' AS [text()]
                 FROM dbs
                 WHERE 1 = CASE

                           /* No filter? Return all databases*/

                               WHEN @name_pattern IS NULL
                               THEN 1

                           /* User databases*/

                               WHEN @name_pattern = '[USER]'
                               THEN system_db + 1

                           /* System databases*/

                               WHEN @name_pattern = '[SYSTEM]'
                               THEN system_db

                           /* LIKE filter*/

                               WHEN name LIKE @name_pattern
                               THEN 1
                           END
                 ORDER BY name FOR XML PATH('')
             );

/* LEVEL 1:
     Execute multi-db sql and pass in the actual statement*/

        EXEC sp_executeSQL 
             @sql, 
             N'@statement nvarchar(max)', 
             @statement;
    END;
GO
/****** Object:  StoredProcedure [dbo].[genInsertStatements]    Script Date: 2/6/2019 8:19:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[genInsertStatements] (
       @tableName VARCHAR (100) 
     ,@NbrOfStatments AS INT = 25) 
AS
BEGIN
    --D. Miller Copyright @ August 2000
    --Declare a cursor to retrieve column specific information 
    --for the specified table
    DECLARE cursCol CURSOR FAST_FORWARD
        FOR SELECT
                   column_name
                 ,data_type
            FROM information_schema.columns
            WHERE
                   table_name = @tableName;
    OPEN cursCol;
    DECLARE
    @string NVARCHAR (MAX) ; --for storing the first half 
    --of INSERT statement
    DECLARE
    @stringData NVARCHAR (MAX) ; --for storing the data 
    --(VALUES) related statement
    DECLARE
    @dataType NVARCHAR (1000) ; --data types returned 
    --for respective columns
    DECLARE
    @iCnt AS INT = 0;
    SET @string = 'INSERT ' + @tableName + '(';
    SET @stringData = '';

    DECLARE
    @colName NVARCHAR (80) ;

    FETCH NEXT FROM cursCol INTO @colName , @dataType;

    IF
           @@fetch_status <> 0
        BEGIN
            PRINT 'Table ' + @tableName + ' not found, processing skipped.';
            CLOSE curscol;
            DEALLOCATE curscol;
            RETURN;
        END;

    WHILE
           @@FETCH_STATUS = 0
        BEGIN
            SET @iCnt = @iCnt + 1;
            --IF @NbrOfStatments > @iCnt
            --    BEGIN
            --        BREAK
            --    END;

            IF @dataType IN ('varchar' , 'char' , 'nchar' , 'nvarchar') 
                BEGIN
                    SET @stringData = @stringData + '''''''''+
            isnull(' + @colName + ','''')+'''''',''+';
                END;
            ELSE
                BEGIN
                    IF @dataType IN ('text' , 'ntext') --if the datatype 
                        --is text or something else 
                        BEGIN
                            SET @stringData = @stringData + '''''''''+
          isnull(cast(' + @colName + ' as varchar(2000)),'''')+'''''',''+';
                        END;
                    ELSE
                        BEGIN
                            IF
                                   @dataType = 'money' --because money doesn't get converted 
                                --from varchar implicitly
                                BEGIN
                                    SET @stringData = @stringData + '''convert(money,''''''+
        isnull(cast(' + @colName + ' as varchar(200)),''0.0000'')+''''''),''+';
                                END;
                            ELSE
                                BEGIN
                                    IF
                                           @dataType = 'datetime'
                                        BEGIN
                                            SET @stringData = @stringData + '''convert(datetime,''''''+
        isnull(cast(' + @colName + ' as varchar(200)),''0'')+''''''),''+';
                                        END;
                                    ELSE
                                        BEGIN
                                            IF
                                                   @dataType = 'image'
                                                BEGIN
                                                    SET @stringData = @stringData + '''''''''+
       isnull(cast(convert(varbinary,' + @colName + ') 
       as varchar(6)),''0'')+'''''',''+';
                                                END;
                                            ELSE --presuming the data type is int,bit,numeric,decimal 
                                                BEGIN
                                                    SET @stringData = @stringData + '''''''''+
          isnull(cast(' + @colName + ' as varchar(200)),''0'')+'''''',''+';
                                                END;
                                        END;
                                END;
                        END;
                END;

            SET @string = @string + @colName + ',';

            FETCH NEXT FROM cursCol INTO @colName , @dataType;
        END;

    DECLARE
    @Query NVARCHAR (MAX) ; -- provide for the whole query, 
    -- you may increase the size

    SET @query = 'SELECT top ' + CAST (@NbrOfStatments AS NVARCHAR (50)) + ' ''' + SUBSTRING (@string , 0 , LEN (@string)) + ') 
    VALUES(''+ ' + SUBSTRING (@stringData , 0 , LEN (@stringData) - 2) + '''+'')'' 
    FROM ' + @tableName;

    --print @query ;
    EXEC sp_executesql @query; --load and run the built query

    CLOSE cursCol;
    DEALLOCATE cursCol;
END;
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
GO
/****** Object:  StoredProcedure [dbo].[GetSEQUENCE]    Script Date: 2/6/2019 8:19:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--This procedure is for convenience in retrieving a sequence.
create PROCEDURE [dbo].[GetSEQUENCE] ( @value BIGINT OUTPUT)
AS
    --Act like we are INSERTing a row to increment the IDENTITY
  
    INSERT DFS_SequenceTABLE WITH (TABLOCKX) DEFAULT VALUES;
    --Return the latest IDENTITY value.
    SELECT @value = SCOPE_IDENTITY();
GO
/****** Object:  StoredProcedure [dbo].[PrintImmediate]    Script Date: 2/6/2019 8:19:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PrintImmediate](@MSG AS NVARCHAR(MAX))
AS
    BEGIN
        RAISERROR(@MSG, 10, 1) WITH NOWAIT;
    END;
GO
/****** Object:  StoredProcedure [dbo].[sp_DFS_FindMissingFKIndexes]    Script Date: 2/6/2019 8:19:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- drop table DFINAnalytics.dbo..DFS_MissingFKIndexes
CREATE PROCEDURE [dbo].[sp_DFS_FindMissingFKIndexes]
AS
    BEGIN
        PRINT 'INSIDE: ' + DB_NAME();
        INSERT INTO DFINAnalytics.dbo.DFS_MissingFKIndexes
               SELECT @@servername as SVR,
			   DB_NAME() AS DBName, 
                      @@VERSION AS SSVER, 
                      rc.Constraint_Name AS FK_Constraint, 
                      -- rc.Constraint_Catalog AS FK_Database, 
                      -- rc.Constraint_Schema AS FKSch, 
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
                      GETDATE() AS CreateDate
               FROM information_schema.referential_constraints RC
                    JOIN INFORMATION_SCHEMA.CONSTRAINT_COLUMN_USAGE ccu ON rc.CONSTRAINT_NAME = ccu.CONSTRAINT_NAME
                    JOIN INFORMATION_SCHEMA.CONSTRAINT_COLUMN_USAGE ccu2 ON rc.UNIQUE_CONSTRAINT_NAME = ccu2.CONSTRAINT_NAME
                    LEFT JOIN sys.columns c ON ccu.Column_Name = C.name
                                               AND ccu.Table_Name = OBJECT_NAME(C.OBJECT_ID)
                    LEFT JOIN sys.index_columns ic ON C.OBJECT_ID = IC.OBJECT_ID
                                                      AND c.column_id = ic.column_id
                                                      AND index_column_id = 1
                    -- index found has the foreign key
                    --  as the first column 
                    LEFT JOIN sys.indexes i ON IC.OBJECT_ID = i.OBJECT_ID
                                               AND ic.index_Id = i.index_Id
               WHERE I.name IS NULL
               ORDER BY FK_table, 
                        ParentTable, 
                        ParentColumn;

        DELETE FROM [DFINAnalytics].[dbo].DFS_MissingFKIndexes
        WHERE [DBName] IN('msdb', 'model', 'tempdb', 'master', 'dba');
    END;
GO
/****** Object:  StoredProcedure [dbo].[sp_foreachdb]    Script Date: 2/6/2019 8:19:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*	Author: W. Dale Miller
	Date:   2018/07/26
 */
CREATE PROCEDURE [dbo].[sp_foreachdb]
    @command NVARCHAR(MAX),
    @replace_character NCHAR(1) = N'?',
    @print_dbname BIT = 0,
    @print_command_only BIT = 0,
    @suppress_quotename BIT = 0,
    @system_only BIT = NULL,
    @user_only BIT = NULL,
    @name_pattern NVARCHAR(300) = N'%', 
    @database_list NVARCHAR(MAX) = NULL,
    @recovery_model_desc NVARCHAR(120) = NULL,
    @compatibility_level TINYINT = NULL,
    @state_desc NVARCHAR(120) = N'ONLINE',
    @is_read_only BIT = 0,
    @is_auto_close_on BIT = NULL,
    @is_auto_shrink_on BIT = NULL,
    @is_broker_enabled BIT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE
        @sql NVARCHAR(MAX),
        @dblist NVARCHAR(MAX),
        @db NVARCHAR(300),
        @i INT;

    IF @database_list > N''
    BEGIN
        ;WITH n(n) AS 
        (
            SELECT ROW_NUMBER() OVER (ORDER BY s1.name) - 1
            FROM sys.objects AS s1 
            CROSS JOIN sys.objects AS s2
        )
        SELECT @dblist = REPLACE(REPLACE(REPLACE(x,'</x><x>',','),
        '</x>',''),'<x>','')
        FROM 
        (
            SELECT DISTINCT x = 'N''' + LTRIM(RTRIM(SUBSTRING(
            @database_list, n,
            CHARINDEX(',', @database_list + ',', n) - n))) + ''''
            FROM n WHERE n <= LEN(@database_list)
            AND SUBSTRING(',' + @database_list, n, 1) = ','
            FOR XML PATH('')
        ) AS y(x);
    END

    CREATE TABLE #x(db NVARCHAR(300));

    SET @sql = N'SELECT name FROM sys.databases WHERE 1=1'
        + CASE WHEN @system_only = 1 THEN 
            ' AND database_id IN (1,2,3,4)' 
            ELSE '' END
        + CASE WHEN @user_only = 1 THEN 
            ' AND database_id NOT IN (1,2,3,4)' 
            ELSE '' END
        + CASE WHEN @name_pattern <> N'%' THEN 
            ' AND name LIKE N''%' + REPLACE(@name_pattern, '''', '''''') + '%''' 
            ELSE '' END
        + CASE WHEN @dblist IS NOT NULL THEN 
            ' AND name IN (' + @dblist + ')' 
            ELSE '' END
        + CASE WHEN @recovery_model_desc IS NOT NULL THEN
            ' AND recovery_model_desc = N''' + @recovery_model_desc + ''''
            ELSE '' END
        + CASE WHEN @compatibility_level IS NOT NULL THEN
            ' AND compatibility_level = ' + RTRIM(@compatibility_level)
            ELSE '' END
        + CASE WHEN @state_desc IS NOT NULL THEN
            ' AND state_desc = N''' + @state_desc + ''''
            ELSE '' END
        + CASE WHEN @is_read_only IS NOT NULL THEN
            ' AND is_read_only = ' + RTRIM(@is_read_only)
            ELSE '' END
        + CASE WHEN @is_auto_close_on IS NOT NULL THEN
            ' AND is_auto_close_on = ' + RTRIM(@is_auto_close_on)
            ELSE '' END
        + CASE WHEN @is_auto_shrink_on IS NOT NULL THEN
            ' AND is_auto_shrink_on = ' + RTRIM(@is_auto_shrink_on)
            ELSE '' END
        + CASE WHEN @is_broker_enabled IS NOT NULL THEN
            ' AND is_broker_enabled = ' + RTRIM(@is_broker_enabled)
        ELSE '' END;

        INSERT #x EXEC sp_executesql @sql;

        DECLARE c CURSOR 
            LOCAL FORWARD_ONLY STATIC READ_ONLY
            FOR SELECT CASE WHEN @suppress_quotename = 1 THEN 
                    db
                ELSE
                    QUOTENAME(db)
                END 
            FROM #x ORDER BY db;

        OPEN c;

        FETCH NEXT FROM c INTO @db;

        WHILE @@FETCH_STATUS = 0
        BEGIN
            SET @sql = REPLACE(@command, @replace_character, @db);

            IF @print_command_only = 1
            BEGIN
                PRINT '/* For ' + @db + ': */'
                + CHAR(13) + CHAR(10) + CHAR(13) + CHAR(10)
                + @sql 
                + CHAR(13) + CHAR(10) + CHAR(13) + CHAR(10);
            END
            ELSE
            BEGIN
                IF @print_dbname = 1
                BEGIN
                    PRINT '/* ' + @db + ' */';
                END

                EXEC sp_executesql @sql;
            END

            FETCH NEXT FROM c INTO @db;
    END

    CLOSE c;
    DEALLOCATE c;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_foreachdb_TempDB]    Script Date: 2/6/2019 8:19:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*	Author: W. Dale Miller
	Date:   2018/07/26
 */
CREATE PROCEDURE [dbo].[sp_foreachdb_TempDB]
    @command NVARCHAR(MAX),
    @replace_character NCHAR(1) = N'?',
    @print_dbname BIT = 0,
    @print_command_only BIT = 0,
    @suppress_quotename BIT = 0,
    @system_only BIT = NULL,
    @user_only BIT = NULL,
    @name_pattern NVARCHAR(300) = N'%', 
    @database_list NVARCHAR(MAX) = NULL,
    @recovery_model_desc NVARCHAR(120) = NULL,
    @compatibility_level TINYINT = NULL,
    @state_desc NVARCHAR(120) = N'ONLINE',
    @is_read_only BIT = 0,
    @is_auto_close_on BIT = NULL,
    @is_auto_shrink_on BIT = NULL,
    @is_broker_enabled BIT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE
        @sql NVARCHAR(MAX),
        @dblist NVARCHAR(MAX),
        @db NVARCHAR(300),
        @i INT;

    IF @database_list > N''
    BEGIN
        ;WITH n(n) AS 
        (
            SELECT ROW_NUMBER() OVER (ORDER BY s1.name) - 1
            FROM sys.objects AS s1 
            CROSS JOIN sys.objects AS s2
        )
        SELECT @dblist = REPLACE(REPLACE(REPLACE(x,'</x><x>',','),
        '</x>',''),'<x>','')
        FROM 
        (
            SELECT DISTINCT x = 'N''' + LTRIM(RTRIM(SUBSTRING(
            @database_list, n,
            CHARINDEX(',', @database_list + ',', n) - n))) + ''''
            FROM n WHERE n <= LEN(@database_list)
            AND SUBSTRING(',' + @database_list, n, 1) = ','
            FOR XML PATH('')
        ) AS y(x);
    END

    CREATE TABLE #x(db NVARCHAR(300));

    SET @sql = N'SELECT name FROM sys.databases WHERE 1=1'
        + CASE WHEN @system_only = 1 THEN 
            ' AND database_id IN (1,2,3,4)' 
            ELSE '' END
        + CASE WHEN @user_only = 1 THEN 
            ' AND database_id NOT IN (1,2,3,4)' 
            ELSE '' END
        + CASE WHEN @name_pattern <> N'%' THEN 
            ' AND name LIKE N''%' + REPLACE(@name_pattern, '''', '''''') + '%''' 
            ELSE '' END
        + CASE WHEN @dblist IS NOT NULL THEN 
            ' AND name IN (' + @dblist + ')' 
            ELSE '' END
        + CASE WHEN @recovery_model_desc IS NOT NULL THEN
            ' AND recovery_model_desc = N''' + @recovery_model_desc + ''''
            ELSE '' END
        + CASE WHEN @compatibility_level IS NOT NULL THEN
            ' AND compatibility_level = ' + RTRIM(@compatibility_level)
            ELSE '' END
        + CASE WHEN @state_desc IS NOT NULL THEN
            ' AND state_desc = N''' + @state_desc + ''''
            ELSE '' END
        + CASE WHEN @is_read_only IS NOT NULL THEN
            ' AND is_read_only = ' + RTRIM(@is_read_only)
            ELSE '' END
        + CASE WHEN @is_auto_close_on IS NOT NULL THEN
            ' AND is_auto_close_on = ' + RTRIM(@is_auto_close_on)
            ELSE '' END
        + CASE WHEN @is_auto_shrink_on IS NOT NULL THEN
            ' AND is_auto_shrink_on = ' + RTRIM(@is_auto_shrink_on)
            ELSE '' END
        + CASE WHEN @is_broker_enabled IS NOT NULL THEN
            ' AND is_broker_enabled = ' + RTRIM(@is_broker_enabled)
        ELSE '' END;

        INSERT #x EXEC sp_executesql @sql;

        DECLARE c CURSOR 
            LOCAL FORWARD_ONLY STATIC READ_ONLY
            FOR SELECT CASE WHEN @suppress_quotename = 1 THEN 
                    db
                ELSE
                    QUOTENAME(db)
                END 
            FROM #x ORDER BY db;

        OPEN c;

        FETCH NEXT FROM c INTO @db;

        WHILE @@FETCH_STATUS = 0
        BEGIN
            SET @sql = REPLACE(@command, @replace_character, @db);

            IF @print_command_only = 1
            BEGIN
                PRINT '/* For ' + @db + ': */'
                + CHAR(13) + CHAR(10) + CHAR(13) + CHAR(10)
                + @sql 
                + CHAR(13) + CHAR(10) + CHAR(13) + CHAR(10);
            END
            ELSE
            BEGIN
                IF @print_dbname = 1
                BEGIN
                    PRINT '/* ' + @db + ' */';
                END

                EXEC sp_executesql @sql;
            END

            FETCH NEXT FROM c INTO @db;
    END

    CLOSE c;
    DEALLOCATE c;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_MeasurePerformanceInSP]    Script Date: 2/6/2019 8:19:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  StoredProcedure [dbo].[sp_UTIL_CPU_BoundQry]    Script Date: 2/6/2019 8:19:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_UTIL_CPU_BoundQry]
AS
    --UTIL_WorstPerformingQuerries.sql
    BEGIN
        PRINT @@Servername;
        PRINT DB_NAME();
        DECLARE @NEXTID AS BIGINT= NEXT VALUE FOR master_seq;
        DECLARE @RunDate AS DATETIME= GETDATE();
        INSERT INTO DFINAnalytics.[dbo].[DFS_CPU_BoundQry]
        ([SVRName], 
         [DBName], 
         [text], 
         [query_plan], 
         [sql_handle], 
         [statement_start_offset], 
         [statement_end_offset], 
         [plan_generation_num], 
         [plan_handle], 
         [creation_time], 
         [last_execution_time], 
         [execution_count], 
         [total_worker_time], 
         [last_worker_time], 
         [min_worker_time], 
         [max_worker_time], 
         [total_physical_reads], 
         [last_physical_reads], 
         [min_physical_reads], 
         [max_physical_reads], 
         [total_logical_writes], 
         [last_logical_writes], 
         [min_logical_writes], 
         [max_logical_writes], 
         [total_logical_reads], 
         [last_logical_reads], 
         [min_logical_reads], 
         [max_logical_reads], 
         [total_clr_time], 
         [last_clr_time], 
         [min_clr_time], 
         [max_clr_time], 
         [total_elapsed_time], 
         [last_elapsed_time], 
         [min_elapsed_time], 
         [max_elapsed_time], 
         [query_hash], 
         [query_plan_hash], 
         [total_rows], 
         [last_rows], 
         [min_rows], 
         [max_rows], 
         [statement_sql_handle], 
         [statement_context_id], 
         [total_dop], 
         [last_dop], 
         [min_dop], 
         [max_dop], 
         [total_grant_kb], 
         [last_grant_kb], 
         [min_grant_kb], 
         [max_grant_kb], 
         [total_used_grant_kb], 
         [last_used_grant_kb], 
         [min_used_grant_kb], 
         [max_used_grant_kb], 
         [total_ideal_grant_kb], 
         [last_ideal_grant_kb], 
         [min_ideal_grant_kb], 
         [max_ideal_grant_kb], 
         [total_reserved_threads], 
         [last_reserved_threads], 
         [min_reserved_threads], 
         [max_reserved_threads], 
         [total_used_threads], 
         [last_used_threads], 
         [min_used_threads], 
         [max_used_threads], 
         [RunDate], 
         [RunID]
        )
               SELECT TOP 25 @@SERVERNAME AS SVRName, 
                             DB_NAME() AS DBName, 
                             st.text, 
                             qp.query_plan, 
                             qs.*, 
                             @RunDate AS RunDate, 
                             @NEXTID AS RunID
               FROM sys.dm_exec_query_stats qs
                    CROSS APPLY sys.dm_exec_sql_text(qs.plan_handle) st
                    CROSS APPLY sys.dm_exec_query_plan(qs.plan_handle) qp
               ORDER BY total_worker_time DESC;
    END;
GO
/****** Object:  StoredProcedure [dbo].[sp_UTIL_IO_BoundQry]    Script Date: 2/6/2019 8:19:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_UTIL_IO_BoundQry]
AS
    BEGIN
        -- Worst performing IO bound queries
        DECLARE @NEXTID AS BIGINT= NEXT VALUE FOR master_seq;
        DECLARE @RunDate AS DATETIME= GETDATE();
        INSERT INTO DFINAnalytics.dbo.DFS_IO_BoundQry
        ([SVRName], 
         [DBName], 
         [text], 
         [query_plan], 
         [sql_handle], 
         [statement_start_offset], 
         [statement_end_offset], 
         [plan_generation_num], 
         [plan_handle], 
         [creation_time], 
         [last_execution_time], 
         [execution_count], 
         [total_worker_time], 
         [last_worker_time], 
         [min_worker_time], 
         [max_worker_time], 
         [total_physical_reads], 
         [last_physical_reads], 
         [min_physical_reads], 
         [max_physical_reads], 
         [total_logical_writes], 
         [last_logical_writes], 
         [min_logical_writes], 
         [max_logical_writes], 
         [total_logical_reads], 
         [last_logical_reads], 
         [min_logical_reads], 
         [max_logical_reads], 
         [total_clr_time], 
         [last_clr_time], 
         [min_clr_time], 
         [max_clr_time], 
         [total_elapsed_time], 
         [last_elapsed_time], 
         [min_elapsed_time], 
         [max_elapsed_time], 
         [query_hash], 
         [query_plan_hash], 
         [total_rows], 
         [last_rows], 
         [min_rows], 
         [max_rows], 
         [statement_sql_handle], 
         [statement_context_id], 
         [total_dop], 
         [last_dop], 
         [min_dop], 
         [max_dop], 
         [total_grant_kb], 
         [last_grant_kb], 
         [min_grant_kb], 
         [max_grant_kb], 
         [total_used_grant_kb], 
         [last_used_grant_kb], 
         [min_used_grant_kb], 
         [max_used_grant_kb], 
         [total_ideal_grant_kb], 
         [last_ideal_grant_kb], 
         [min_ideal_grant_kb], 
         [max_ideal_grant_kb], 
         [total_reserved_threads], 
         [last_reserved_threads], 
         [min_reserved_threads], 
         [max_reserved_threads], 
         [total_used_threads], 
         [last_used_threads], 
         [min_used_threads], 
         [max_used_threads], 
         [RunDate], 
         [RunID]
        )
               SELECT TOP 25 @@SERVERNAME AS SVRName, 
                             DB_NAME() AS DBName, 
                             st.text, 
                             qp.query_plan, 
                             qs.*, 
                             @RunDate AS RunDate, 
                             @NEXTID AS RunID
               FROM sys.dm_exec_query_stats qs
                    CROSS APPLY sys.dm_exec_sql_text(qs.plan_handle) st
                    CROSS APPLY sys.dm_exec_query_plan(qs.plan_handle) qp
               ORDER BY total_logical_reads DESC;
    END;
GO
/****** Object:  StoredProcedure [dbo].[spDemoDBContext]    Script Date: 2/6/2019 8:19:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[spDemoDBContext] 
as
	print 'PROC EXECUTING THRU DATABASE: ' + db_name() + ' on ' + cast(getdate() as nvarchar(50));
GO
/****** Object:  StoredProcedure [dbo].[test_GetNbr1]    Script Date: 2/6/2019 8:19:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[test_GetNbr1]
as
return 10;
GO
/****** Object:  StoredProcedure [dbo].[usp_GetErrorInfo]    Script Date: 2/6/2019 8:19:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
-- Create procedure to retrieve error information.  

CREATE PROCEDURE [dbo].[usp_GetErrorInfo]
AS
BEGIN
	SELECT ERROR_NUMBER() AS ErrorNumber, ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE() AS ErrorState, ERROR_PROCEDURE() AS ErrorProcedure, ERROR_LINE() AS ErrorLine, ERROR_MESSAGE() AS ErrorMessage;
END;  
GO
/****** Object:  StoredProcedure [dbo].[UTIL_ADD_DFS_QrysPlans]    Script Date: 2/6/2019 8:19:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UTIL_ADD_DFS_QrysPlans]
(@query_hash      BINARY(8), 
 @query_plan_hash BINARY(8), 
 @UID             UNIQUEIDENTIFIER, 
 @PerfType        CHAR(1), 
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
            FROM dbo.DFS_QryPlanBridge
            WHERE query_hash = @query_hash
                  AND query_plan_hash = @query_plan_hash
        );
        IF
           (@cnt = 0
           )
            BEGIN
                SET @AddRec = 1;
        END;
        IF
           (@cnt = 1
           )
            BEGIN
                UPDATE [dbo].[DFS_QryPlanBridge]
                  SET 
                      NbrHits = NbrHits + 1, 
                      LastUpdate = GETDATE()
                WHERE query_hash = @query_hash
                      AND query_plan_hash = @query_plan_hash;
                SET @success = 1;
                RETURN @success;
        END;
        SET @success = 0;
        IF
           (@cnt = 0
           )
            BEGIN
                IF @PerfType = 'C'
                    BEGIN
                        IF @TBLID = '2000'
                            BEGIN
                                SET @PLAN =
                                (
                                    SELECT query_plan
                                    FROM [dbo].[DFS_CPU_BoundQry2000]
                                    WHERE [UID] = @UID
                                );
                                SET @SQL =
                                (
                                    SELECT [text]
                                    FROM [dbo].[DFS_CPU_BoundQry2000]
                                    WHERE [UID] = @UID
                                );
                                SET @success = 1;
                        END;
                            ELSE
                            BEGIN
                                SET @PLAN =
                                (
                                    SELECT query_plan
                                    FROM [dbo].[DFS_CPU_BoundQry]
                                    WHERE [UID] = @UID
                                );
                                SET @SQL =
                                (
                                    SELECT [text]
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
                                SET @PLAN =
                                (
                                    SELECT query_plan
                                    FROM [dbo].[DFS_IO_BoundQry2000]
                                    WHERE [UID] = @UID
                                );
                                SET @SQL =
                                (
                                    SELECT [text]
                                    FROM [dbo].[DFS_IO_BoundQry2000]
                                    WHERE [UID] = @UID
                                );
                                SET @success = 1;
                        END;
                            ELSE
                            BEGIN
                                SET @PLAN =
                                (
                                    SELECT query_plan
                                    FROM [dbo].[DFS_IO_BoundQry]
                                    WHERE [UID] = @UID
                                );
                                SET @SQL =
                                (
                                    SELECT [text]
                                    FROM [dbo].[DFS_IO_BoundQry]
                                    WHERE [UID] = @UID
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
                ( [query_hash], 
                  [query_plan_hash], 
                  [PerfType], 
                  [TblType], 
                  [CreateDate], 
                  [LastUpdate], 
                  [NbrHits]
                ) 
                VALUES
                (
                       @query_hash
                     , @query_plan_hash
                     , @PerfType
                     , @TBLID
                     , GETDATE()
                     , GETDATE()
                     , 1
                );
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
                     , NEWID()
                     , @PerfType
                     , @SQL
                     , @PLAN
                     , GETDATE()
                );
                IF @TBLID = '2000'
                   AND @PerfType = 'I'
                    BEGIN
                        UPDATE [dbo].[DFS_IO_BoundQry2000]
                          SET 
                              query_plan = 'SAVED', 
                              [text] = 'SAVED', 
                              Processed = 1
                        WHERE [UID] = @UID;
                        PRINT 'DFS_IO_BoundQry2000: ' + CAST(@i AS NVARCHAR(15)) + ' Processed set to 1';
                END;
                IF @TBLID = '2000'
                   AND @PerfType = 'C'
                    BEGIN
                        UPDATE [dbo].[DFS_CPU_BoundQry2000]
                          SET 
                              query_plan = 'SAVED', 
                              [text] = 'SAVED', 
                              Processed = 1
                        WHERE [UID] = @UID;
                        PRINT 'DFS_CPU_BoundQry2000: ' + CAST(@i AS NVARCHAR(15)) + ' Processed set to 1';
                END;
                IF @TBLID IS NULL
                   AND @PerfType = 'I'
                    BEGIN
                        UPDATE [dbo].[DFS_IO_BoundQry]
                          SET 
                              query_plan = 'SAVED', 
                              [text] = 'SAVED', 
                              Processed = 1
                        WHERE [UID] = @UID;
                        PRINT 'DFS_IO_BoundQry: ' + CAST(@i AS NVARCHAR(15)) + ' Processed set to 1';
                END;
                IF @TBLID IS NULL
                   AND @PerfType = 'C'
                    BEGIN
                        UPDATE [dbo].[DFS_cpu_BoundQry]
                          SET 
                              query_plan = 'SAVED', 
                              [text] = 'SAVED', 
                              Processed = 1
                        WHERE [UID] = @UID;
                        PRINT 'DFS_cpu_BoundQry: ' + CAST(@i AS NVARCHAR(15)) + ' Processed set to 1';
                END;
        END;
        RETURN @success;
    END;
GO
/****** Object:  StoredProcedure [dbo].[UTIL_CleanDFSTables]    Script Date: 2/6/2019 8:19:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/* exec UTIL_CleanDFSTables @DaysToDelete = 2 */

CREATE PROCEDURE [dbo].[UTIL_CleanDFSTables](@DaysToDelete INT = 3)
AS
    BEGIN
        exec UTIL_CleanUpOneTable 'DFS_SequenceTABLE', 'CreateDate', @DaysToDelete  ;
        exec UTIL_CleanUpOneTable 'DFS_MissingIndexes','CreateDate',@DaysToDelete;
        exec UTIL_CleanUpOneTable 'DFS_MissingFKIndexes','CreateDate',@DaysToDelete;
        exec UTIL_CleanUpOneTable 'DFS_MissingFKIndexes','CreateDate',@DaysToDelete;
        exec UTIL_CleanUpOneTable 'DFS_TableReadWrites','RunDate',@DaysToDelete;
        exec UTIL_CleanUpOneTable 'DFS_IndexStats','CreateDate',@DaysToDelete;
        exec UTIL_CleanUpOneTable 'DFS_BlockingHistory','CreateDate',@DaysToDelete;
        exec UTIL_CleanUpOneTable 'DFS_SEQ','GenDate',@DaysToDelete;
        exec UTIL_CleanUpOneTable 'DFS_CPU_BoundQry2000','RunDate',@DaysToDelete;
        exec UTIL_CleanUpOneTable 'DFS_IO_BoundQry2000','RunDate',@DaysToDelete;
        exec UTIL_CleanUpOneTable 'DFS_TranLocks','CreateDate',@DaysToDelete;
        exec UTIL_CleanUpOneTable 'DFS_QryOptStats','RunDate',@DaysToDelete;
        exec UTIL_CleanUpOneTable 'DFS_Workload','RunDate',@DaysToDelete;
        exec UTIL_CleanUpOneTable 'DFS_PerfMonitor','CreateDate',@DaysToDelete;
        exec UTIL_CleanUpOneTable 'DFS_TxMonitorTableStats','CreateDate',@DaysToDelete;
        exec UTIL_CleanUpOneTable 'DFS_TxMonitorTblUpdates','CreateDate',@DaysToDelete;
        exec UTIL_CleanUpOneTable 'DFS_DbFileSizing','CreateDate',@DaysToDelete;
        exec UTIL_CleanUpOneTable 'DFS_TxMonitorIDX','CreateDate',@DaysToDelete;
        exec UTIL_CleanUpOneTable 'DFS_DeadlockStats','RunDate',@DaysToDelete;
        exec UTIL_CleanUpOneTable 'DFS_IndexFragReorgHistory','RunDate',@DaysToDelete;
        exec UTIL_CleanUpOneTable 'DFS_TableGrowthHistory','CreateDate',@DaysToDelete;
        exec UTIL_CleanUpOneTable 'DFS_IO_BoundQry','RunDate',@DaysToDelete;
        exec UTIL_CleanUpOneTable 'DFS_CPU_BoundQry','RunDate',@DaysToDelete;
    END;
       

/****************** PROCESSING FILE *************************************/

GO
/****** Object:  StoredProcedure [dbo].[UTIL_CleanUpOneTable]    Script Date: 2/6/2019 8:19:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[UTIL_CleanUpOneTable] (@tbl nvarchar(150), @DateColumn nvarchar(50), @DaysToDelete int)
as
begin
		DECLARE @Acnt int   
		DECLARE @Bcnt int   
		DECLARE @retval int   
		DECLARE @sSQL nvarchar(500);
		DECLARE @ParmDefinition nvarchar(500);
		declare @i int ;
		DECLARE @tablename nvarchar(50)  
		SELECT @tablename = @tbl

		SELECT @sSQL = N'SELECT @retvalOUT = count(*) FROM ' + @tablename;  
		SET @ParmDefinition = N'@retvalOUT int OUTPUT';
		EXEC sp_executesql @sSQL, @ParmDefinition, @retvalOUT=@retval OUTPUT;
		set @Acnt = (SELECT @retval);
		print @tbl + ' @Bcnt = ' + cast(@Bcnt as nvarchar(50));

		SELECT @sSQL = 'delete from DFINAnalytics.dbo.' + @tbl + ' where ' + @DateColumn + ' <= getdate() - ' + cast(@DaysToDelete as nvarchar(10)); 
		print @sSQL ;

		SELECT @sSQL = N'SELECT @retvalOUT = count(*) FROM ' + @tablename;  
		SET @ParmDefinition = N'@retvalOUT int OUTPUT';
		EXEC sp_executesql @sSQL, @ParmDefinition, @retvalOUT=@retval OUTPUT;
		set @Bcnt = (SELECT @retval);
		print @tbl + ' @Bcnt = ' + cast(@Bcnt as nvarchar(50));

        INSERT INTO [dbo].[DFS_CleanedDFSTables]
        ( [SvrName], 
          [DBName], 
          [TBLName], 
          [RowCNT], 
          [DropRowCNT], 
          [CreateDate], 
          [UID]
        ) 
        VALUES
        (
               @@servername
             , DB_NAME()
             , @tbl
             , @Acnt
             , @Bcnt
             , GETDATE()
             , NEWID()
        );
end

GO
/****** Object:  StoredProcedure [dbo].[UTIL_DefragAllIndexes]    Script Date: 2/6/2019 8:19:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/* exec UTIL_DefragAllIndexes 'BNY_Production_NMFP_Data', 'BNYUK_ProductionAR_Port', 30, 0, 1;
exec UTIL_DefragAllIndexes null, null, 30, 0, 1, -1;
*/

CREATE PROCEDURE [dbo].[UTIL_DefragAllIndexes]
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
        DECLARE @msg NVARCHAR(2000);
        DECLARE @DBNAME NVARCHAR(250);
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
                    FROM DFINAnalytics.dbo.[DFS_DB2Skip]
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
            FROM DFINAnalytics.dbo.[DFS_DB2Skip]
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
                    FROM [DFINAnalytics].[dbo].[DFS_IndexFragHist]
                    WHERE [IndexProcessed] = 0
                );
                DELETE FROM #TEMP_DBS2PROCESS
                WHERE DBNAME IN
                (
                    SELECT DB
                    FROM DFINAnalytics.dbo.[DFS_DB2Skip]
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
                SET @stmt = 'INSERT INTO DFINAnalytics.dbo.[DFS_IndexFragProgress] ';
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
                SET @stmt = @stmt + 'INSERT INTO DFINAnalytics.dbo.DFS_IndexFragHist ' + CHAR(10) + 'SELECT DB_NAME() AS DBName,
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
                SET @stmt = @stmt + 'update DFINAnalytics.dbo.[DFS_IndexFragProgress] ';
                SET @stmt = @stmt + '  set EndTime = getdate() where EndTime is null';
                SET @stmt = RTRIM(@stmt);
                IF @PreviewOnly = 0
                    BEGIN
                        SET @stmt = 'USE ' + @dbname + ';' + @stmt;
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
                           'USE ' + @dbname + ' ; '
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
        DELETE FROM DFINAnalytics.dbo.DFS_IndexFragHist
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
                   'SELECT * FROM DFINAnalytics.dbo.DFS_IndexFragHist where IndexProcessed != 1;'
                );
        END;
        IF @ReorgIndexes = 1
            BEGIN
                EXEC sp_UTIL_ReorgFragmentedIndexes 
                     @PreviewOnly;
        END;
    END;
GO
/****** Object:  StoredProcedure [dbo].[UTIL_DFS_CPU_BoundQry]    Script Date: 2/6/2019 8:19:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
exec DFS_CPU_BoundQry
*/

CREATE PROCEDURE [dbo].[UTIL_DFS_CPU_BoundQry]
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
            FROM [DFINAnalytics].[dbo].[DFS_QryPlanBridge] AS A
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
                  SET 
                      Processed = 1
                WHERE [query_hash] = @query_hash
                      AND [query_plan_hash] = @query_plan_hash
                      AND processed = 0;
                FETCH NEXT FROM db_cursor INTO @query_hash, @query_plan_hash, @UID, @cnt;
            END;
        CLOSE db_cursor;
        DEALLOCATE db_cursor;
        UPDATE [dbo].[DFS_CPU_BoundQry]
          SET 
              Processed = 1
        WHERE [UID] IN
        (
            SELECT B.[UID]
            FROM [DFINAnalytics].[dbo].[DFS_QryPlanBridge] AS A
                      JOIN [dbo].[DFS_CPU_BoundQry] AS B
                      ON B.[query_hash] = A.[query_hash]
                         AND B.[query_plan_hash] = A.[query_plan_hash]
            WHERE B.processed = 0
        );
    END;

/****************** PROCESSING FILE *************************************/

GO
/****** Object:  StoredProcedure [dbo].[UTIL_DFS_DbFileSizing]    Script Date: 2/6/2019 8:19:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- exec UTIL_DFS_DbFileSizing
CREATE PROCEDURE [dbo].[UTIL_DFS_DbFileSizing]
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
GO
/****** Object:  StoredProcedure [dbo].[UTIL_DFS_DBVersion]    Script Date: 2/6/2019 8:19:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- exec UTIL_DFS_DBVersion
CREATE PROCEDURE [dbo].[UTIL_DFS_DBVersion]
AS
    BEGIN
        DECLARE @SSVER NVARCHAR(250)= @@version;
        DECLARE @SSID NVARCHAR(60);
		DECLARE @ID int;

        IF EXISTS
        (
            SELECT RowNbr
            FROM   DFS_DBVersion
            WHERE  [SSVER] = @SSVER
        )
            BEGIN
			    SET @ID =
                (
                    SELECT RowNbr
                    FROM   DFS_DBVersion
                    WHERE  [SSVER] = @SSVER
                );
        END;
            ELSE
            BEGIN
                SET @SSID = NEWID();
                INSERT INTO DFS_DBVersion
                ([SVRName], 
                 [DBName], 
                 [SSVER], 
                 [SSVERID]
                )
                VALUES
                (@@servername, 
                 DB_NAME(), 
                 @@version, 
                 cast(@SSID as nvarchar(60))
                );
				 SET @ID =
                (
                    SELECT Rownbr
                    FROM   DFS_DBVersion
                    WHERE  [SSVER] = @SSVER
                );
        END;
		print @ID;
        RETURN @ID;
    END;PRINT '--- "D:\dev\SQL\DFINAnalytics\DFS_DBVersion.sql"' 
PRINT '--- "D:\dev\SQL\DFINAnalytics\DFS_DBVersion.sql"' 


/****************** PROCESSING FILE *************************************/

GO
/****** Object:  StoredProcedure [dbo].[UTIL_DFS_DeadlockStats]    Script Date: 2/6/2019 8:19:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- exec UTIL_DFS_DeadlockStats
CREATE PROCEDURE [dbo].[UTIL_DFS_DeadlockStats]
AS
    BEGIN
        IF OBJECT_ID('tempdb..#tempDFS_DeadlockStats') IS NOT NULL
            DROP TABLE #tempDFS_DeadlockStats;
        CREATE TABLE #tempDFS_DeadlockStats
        (SPID        INT, 
         STATUS      VARCHAR(1000) NULL, 
         Login       SYSNAME NULL, 
         HostName    SYSNAME NULL, 
         BlkBy       SYSNAME NULL, 
         DBName      SYSNAME NULL, 
         Command     VARCHAR(1000) NULL, 
         CPUTime     INT NULL, 
         DiskIO      INT NULL, 
         LastBatch   VARCHAR(1000) NULL, 
         ProgramName VARCHAR(1000) NULL, 
         SPID2       INT, 
         REQUESTID   INT NULL --comment out for SQL 2000 databases
        );
        -- select * from #tempDFS_DeadlockStats
        INSERT INTO #tempDFS_DeadlockStats
        EXEC sp_who2;
        DECLARE @RUNID AS INT;
        SET @RUNID = NEXT VALUE FOR master_seq;
        --SET @RUNID = 78;
        INSERT INTO DFINAnalytics.dbo.DFS_DeadlockStats
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
                      RunID = @RUNID
               FROM #tempDFS_DeadlockStats;
        --WHERE DBName = 'DFINAnalytics';
        UPDATE DFINAnalytics.dbo.DFS_DeadlockStats
          SET 
              BlkBy = NULL
        WHERE LTRIM(blkby) = '.';

        --SELECT * FROM DFINAnalytics.dbo.DFS_DeadlockStats;
        --update DFINAnalytics.dbo.DFS_DeadlockStats set BlkBy = 264 where RowID = 260

        DECLARE @BlockedSPIDS TABLE(BlockedSpid INT);
        INSERT INTO @BlockedSPIDS(BlockedSpid)
        (
            --select cast(blkby as int) as BlockedSpid from DFINAnalytics.dbo.DFS_DeadlockStats where blkby is not null
            SELECT RowID AS BlockedSpid
            FROM DFINAnalytics.dbo.DFS_DeadlockStats
            WHERE blkby IS NOT NULL
                  AND RunID = @RUNID
        );
        --select * from @BlockedSPIDS;

        DECLARE @BlockingSPIDS TABLE(BlockedingSpid INT);
        INSERT INTO @BlockingSPIDS(BlockedingSpid)
        (
            --select cast(blkby as int) as BlockedSpid from DFINAnalytics.dbo.DFS_DeadlockStats where blkby is not null
            SELECT CAST(BlkBy AS INT) AS BlockedingSpid
            FROM DFINAnalytics.dbo.DFS_DeadlockStats
            WHERE RowID IN
            (
                SELECT BlockedSpid
                FROM @BlockedSPIDS
            )
        );
        --select * from @BlockingSPIDS;

        UPDATE DFINAnalytics.dbo.DFS_DeadlockStats
          SET 
              BlkBy = 'X'
        WHERE DFINAnalytics.dbo.DFS_DeadlockStats.RowID IN
        (
            SELECT BlockedingSpid
            FROM @BlockingSPIDS
        );
        DELETE FROM DFINAnalytics.dbo.DFS_DeadlockStats
        WHERE BlkBy IS NULL
              AND RUNID = @RUNID;
    END;
GO
/****** Object:  StoredProcedure [dbo].[UTIL_DFS_TxMonitorTblUpdates]    Script Date: 2/6/2019 8:19:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- select * from sys.dm_db_index_usage_stats 
CREATE PROCEDURE [dbo].[UTIL_DFS_TxMonitorTblUpdates](@DBID AS INT)
AS
    BEGIN
        SET NOCOUNT ON;
        DECLARE @RunID AS BIGINT= NEXT VALUE FOR master_seq;
        DECLARE @ExecutionDate DATETIME= GETDATE();
        -- Collect our working data
        INSERT INTO DFINAnalytics.dbo.DFS_TxMonitorTblUpdates
               SELECT @@SERVERNAME, 
                      database_id, 
					  sch.name as SchemaName,
                      DB_NAME(database_id), 
                      OBJECT_NAME(us.object_id) AS TableName, 
                      us.user_lookups, 
                      us.user_scans, 
                      user_seeks, 
                      user_updates AS UpdatedRows, 
                      last_user_update AS LastUpdateTime, 
                      GETDATE() AS CreateDate, 
                      ExecutionDate = @ExecutionDate, 
                      RunID = @RunID,
					  [UID] = newid()
               FROM sys.dm_db_index_usage_stats us
                    JOIN sys.indexes si ON us.object_id = si.object_id
                                           AND us.index_id = si.index_id
               JOIN sys.objects AS O ON O.object_id = si.object_id
                    JOIN sys.schemas AS sch ON O.schema_id = sch.schema_id
               WHERE user_seeks + user_scans + user_lookups + user_updates > 0
                     AND si.index_id IN(0, 1)
               ORDER BY OBJECT_NAME(us.object_id);
    END;
        -- W. Dale Miller
        -- DMA, Limited
        -- Offered under GNU License
        -- July 26, 2016
GO
/****** Object:  StoredProcedure [dbo].[UTIL_findLocks]    Script Date: 2/6/2019 8:19:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- exec UTIL_findLocks
CREATE PROCEDURE [dbo].[UTIL_findLocks]
AS
    BEGIN
        SET NOCOUNT ON;
        IF OBJECT_ID('TempDB.dbo.#TempLocks') IS NOT NULL
		DROP TABLE #TempLocks;

        --declare @tsql as nvarchar(1000) = '' ;
        --declare @tcmd as nvarchar(1000) = 'exec sp_lock 63' ;
        --set  @tsql = @tsql + ' SELECT * INTO #TempLocks ' + char(10) ;
        --set  @tsql = @tsql + '        FROM OPENROWSET (''SQLNCLI'', ''Server=localhost;Trusted_Connection=yes;'', '''+@tcmd+''' ) ;' ;
        --exec (@tsql) ;

        IF OBJECT_ID('TempDB.dbo.#TEmpBlocked') IS NOT NULL
            DROP TABLE #TEmpBlocked;
        
        SELECT spid , STATUS , blocked , open_tran , waitresource , waittype , waittime , cmd , lastwaittype
        INTO #TempBlocked
        FROM DFINAnalytics.dbo.sysprocesses
        WHERE blocked <> 0;
        IF ( SELECT COUNT(*)
             FROM #TempBlocked
           ) = 0
            BEGIN
                PRINT 'NO Blocks found.';
                RETURN;
        END;

        --    SELECT
        --           * INTO
        --                  #TempBlocked
        --           FROM OPENROWSET ('SQLNCLI', 'Server=localhost;Trusted_Connection=yes;', 'select spid, status, Blocked, open_tran, waitresource, waittype, waittime, cmd, lastwaittype
        --from DFINAnalytics.dbo.sysprocesses
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
/****** Object:  StoredProcedure [dbo].[UTIL_GetErrorInfo]    Script Date: 2/6/2019 8:19:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
/*
A procedure to retrieve error information.  
*/

CREATE PROCEDURE [dbo].[UTIL_GetErrorInfo]
AS
BEGIN
	DECLARE @i int= -1;
	SET @i = (SELECT CHARINDEX('There is already an object', ERROR_MESSAGE()));
	IF(@i >= 0)
	BEGIN
		PRINT 'ALREADY IN TEMPDB... Skipping.';
		PRINT ERROR_MESSAGE();
		RETURN -1;
	END;
	SELECT ERROR_NUMBER() AS ErrorNumber, ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE() AS ErrorState, ERROR_PROCEDURE() AS ErrorProcedure, ERROR_LINE() AS ErrorLine, ERROR_MESSAGE() AS ErrorMessage;
	RETURN 1;
END;  
GO
/****** Object:  StoredProcedure [dbo].[UTIL_getRunningQueryText]    Script Date: 2/6/2019 8:19:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[UTIL_getRunningQueryText](@SPID INT)
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
/****** Object:  StoredProcedure [dbo].[UTIL_GetSeq]    Script Date: 2/6/2019 8:19:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- select * from [DFINAnalytics].dbo.DFS_SequenceTABLE
-- exec UTIL_GetSeq
CREATE PROCEDURE [dbo].[UTIL_GetSeq]
AS
    BEGIN
        DECLARE @id BIGINT;
        INSERT INTO [DFINAnalytics].dbo.DFS_SequenceTABLE WITH(TABLOCKX)
        DEFAULT VALUES;
        --Return the latest IDENTITY value.
        SET @id =
        (
            SELECT MAX(id)
            FROM [DFINAnalytics].dbo.DFS_SequenceTABLE
        );
        RETURN @id;
    END;

GO
/****** Object:  StoredProcedure [dbo].[UTIL_GetTableRowsSize]    Script Date: 2/6/2019 8:19:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- exec DFINAnalytics.dbo.UTIL_GetTableRowsSize 'AP_ProductionAF_Data'
CREATE PROCEDURE [dbo].[UTIL_GetTableRowsSize]
AS
    BEGIN
        SELECT [DBNAME] = db_name(), 
               s.Name AS SchemaName, 
               t.Name AS TableName, 
               p.rows AS RowCounts, 
               CAST(ROUND((SUM(a.used_pages) / 128.00), 2) AS NUMERIC(36, 2)) AS Used_MB, 
               CAST(ROUND((SUM(a.total_pages) - SUM(a.used_pages)) / 128.00, 2) AS NUMERIC(36, 2)) AS Unused_MB, 
               CAST(ROUND((SUM(a.total_pages) / 128.00), 2) AS NUMERIC(36, 2)) AS Total_MB
        FROM sys.tables t
             INNER JOIN sys.indexes i ON t.OBJECT_ID = i.object_id
             INNER JOIN sys.partitions p ON i.object_id = p.OBJECT_ID
                                            AND i.index_id = p.index_id
             INNER JOIN sys.allocation_units a ON p.partition_id = a.container_id
             INNER JOIN sys.schemas s ON t.schema_id = s.schema_id
        GROUP BY t.Name, 
                 s.Name, 
                 p.Rows;
        --ORDER BY s.Name, t.Name

    END;
GO
/****** Object:  StoredProcedure [dbo].[UTIL_IO_BoundQry]    Script Date: 2/6/2019 8:19:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
exec DFS_IO_BoundQry
*/

CREATE PROCEDURE [dbo].[UTIL_IO_BoundQry]
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
                 [DFINAnalytics].[dbo].[DFS_QryPlanBridge] AS A
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
                  SET Processed = 1
                WHERE [query_hash] = @query_hash
                      AND [query_plan_hash] = @query_plan_hash
                      AND processed = 0;
                FETCH NEXT FROM db_cursor INTO @query_hash, @query_plan_hash, @UID, @cnt;
            END;
        CLOSE db_cursor;
        DEALLOCATE db_cursor;
        UPDATE [dbo].[DFS_IO_BoundQry]
          SET Processed = 1
        WHERE [UID] IN
        (
            SELECT B.[UID]
            FROM
                 [DFINAnalytics].[dbo].[DFS_QryPlanBridge] AS A
                 JOIN [dbo].[DFS_IO_BoundQry] AS B
                      ON B.[query_hash] = A.[query_hash]
                         AND B.[query_plan_hash] = A.[query_plan_hash]
            WHERE B.processed = 0
        );
    END;

/****************** PROCESSING FILE *************************************/

GO
/****** Object:  StoredProcedure [dbo].[UTIL_ListBlocks]    Script Date: 2/6/2019 8:19:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[UTIL_ListBlocks]
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
/****** Object:  StoredProcedure [dbo].[UTIL_ListCurrentRunningQueries]    Script Date: 2/6/2019 8:19:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[UTIL_ListCurrentRunningQueries]
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
/****** Object:  StoredProcedure [dbo].[UTIL_ListMostCommonWaits]    Script Date: 2/6/2019 8:19:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[UTIL_ListMostCommonWaits]
AS

     /*Display the top 10 most frequent WAITS occuring in the DB*/

     SELECT TOP 10 wait_type, 
                   wait_time_ms, 
                   Percentage = 100. * wait_time_ms / SUM(wait_time_ms) OVER()
     FROM sys.dm_os_wait_stats wt
     WHERE wt.wait_type NOT LIKE '%SLEEP%'
     ORDER BY Percentage DESC;
GO
/****** Object:  StoredProcedure [dbo].[UTIL_ListQryTextBySpid]    Script Date: 2/6/2019 8:19:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[UTIL_ListQryTextBySpid](@SPID INT)
AS

/*Exec UTIL_ListQryBySpid 306  
     To see the last statement sent from a client to an SQL Server instance run: (for example for the blocking session ID)*/

     DBCC INPUTBUFFER(@SPID);
GO
/****** Object:  StoredProcedure [dbo].[UTIL_ListQueryAndBlocks]    Script Date: 2/6/2019 8:19:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*Lists database name that requests are executing against and blocking session ID for blocked queries:
 select top 1000 * from [dbo].[DFS_BlockingHistory]
 truncate table [dbo].[DFS_BlockingHistory]*/
/*
declare @msg nvarchar(250);
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

CREATE PROC [dbo].[UTIL_ListQueryAndBlocks]
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
                EXEC @RunID = DFINAnalytics.dbo.UTIL_GetSeq;
                PRINT 'RUNID: ' + CAST(@RunID AS NVARCHAR(10)) + '->Blocked Count: ' + CAST(@cnt AS NVARCHAR(10));
                WITH BlockedSpids
                     AS (SELECT [blocking_session_id] AS SID
                         FROM sys.dm_exec_requests
                         WHERE [blocking_session_id] > 0
                         UNION ALL
                         SELECT [session_id]
                         FROM sys.dm_exec_requests
                         WHERE [blocking_session_id] > 0)
                     INSERT INTO [DFINAnalytics].[dbo].[DFS_BlockingHistory]
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
/****** Object:  StoredProcedure [dbo].[UTIL_MonitorWorkload]    Script Date: 2/6/2019 8:19:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UTIL_MonitorWorkload] 
AS
	--UTIL_MonitorWorkload.sql
    BEGIN
		declare @DBname nvarchar(100) = db_name();
		declare @msg nvarchar(1000);
		set @msg = 'WORKLOAD Processing: ' + @DBname;
		exec DFINAnalytics.dbo.printimmediate @msg;
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
        INSERT INTO DFINAnalytics.dbo.DFS_Workload
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
/****** Object:  StoredProcedure [dbo].[UTIL_MSforeachdb]    Script Date: 2/6/2019 8:19:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UTIL_MSforeachdb] @command1    NVARCHAR(2000), 
                                  @replacechar NCHAR(1)       = N'?', 
                                  @command2    NVARCHAR(2000) = NULL, 
                                  @command3    NVARCHAR(2000) = NULL, 
                                  @precommand  NVARCHAR(2000) = NULL, 
                                  @postcommand NVARCHAR(2000) = NULL
AS
begin
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
         EXEC (@precommand);
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
         EXEC @retval = sys.sp_MSforeach_worker 
              @command1, 
              @replacechar, 
              @command2, 
              @command3, 
              1;
     IF(@retval = 0
        AND @postcommand IS NOT NULL)
         EXEC (@postcommand);
     DECLARE @tempdb NVARCHAR(258);
     SELECT @tempdb = REPLACE(@origdb, N']', N']]');
     EXEC (N'use '+N'['+@tempdb+N']');
     RETURN @retval;
end
GO
/****** Object:  StoredProcedure [dbo].[UTIL_Process_QrysPlans]    Script Date: 2/6/2019 8:19:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/* exec [DFINAnalytics].dbo.UTIL_Process_QrysPlans */

CREATE PROCEDURE [dbo].[UTIL_Process_QrysPlans]
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
        FOR SELECT query_hash, 
                   query_plan_hash, 
                   [UID], 
                   'C' AS PerfType, 
                   '2000' AS TBLID
            FROM [dbo].[DFS_CPU_BoundQry2000]
            WHERE Processed = 0
            UNION ALL
            SELECT query_hash, 
                   query_plan_hash, 
                   [UID], 
                   'I' AS PerfType, 
                   '2000' AS TBLID
            FROM [dbo].[DFS_IO_BoundQry2000]
            WHERE Processed = 0
            UNION ALL
            SELECT query_hash, 
                   query_plan_hash, 
                   [UID], 
                   'I' AS PerfType, 
                   NULL AS TBLID
            FROM [dbo].[DFS_IO_BoundQry]
            WHERE Processed = 0
            UNION ALL
            SELECT query_hash, 
                   query_plan_hash, 
                   [UID], 
                   'C' AS PerfType, 
                   NULL AS TBLID
            FROM [dbo].[DFS_CPU_BoundQry]
            WHERE Processed = 0;
        OPEN db_cursor;
        FETCH NEXT FROM db_cursor INTO @query_hash, @query_plan_hash, @UID, @PerfType, @TBLID;
        WHILE @@FETCH_STATUS = 0
            BEGIN
                SET @i = @i + 1;
                SET @msg = 'Processing: ' + CAST(@i AS NVARCHAR(15));
                EXEC PrintImmediate 
                     @msg;
                EXEC UTIL_ADD_DFS_QrysPlans 
                     @query_hash, 
                     @query_plan_hash, 
                     @UID, 
                     @PerfType, 
                     @TBLID;
                FETCH NEXT FROM db_cursor INTO @query_hash, @query_plan_hash, @UID, @PerfType, @TBLID;
            END;
        CLOSE db_cursor;
        DEALLOCATE db_cursor;
        IF
        (
            SELECT COUNT(*)
            FROM DFINAnalytics.[dbo].[DFS_IO_BoundQry2000]
            WHERE Processed = 0
        ) > 0
            BEGIN
                UPDATE DFINAnalytics.[dbo].[DFS_IO_BoundQry2000]
                  SET 
                      processed = 1
                WHERE Processed = 0;
        END;
        IF
        (
            SELECT COUNT(*)
            FROM DFINAnalytics.[dbo].[DFS_CPU_BoundQry2000]
            WHERE Processed = 0
        ) > 0
            BEGIN
                UPDATE DFINAnalytics.[dbo].[DFS_CPU_BoundQry2000]
                  SET 
                      processed = 1
                WHERE Processed = 0;
        END;
        IF
        (
            SELECT COUNT(*)
            FROM DFINAnalytics.[dbo].[DFS_IO_BoundQry]
            WHERE Processed = 0
        ) > 0
            BEGIN
                UPDATE DFINAnalytics.[dbo].[DFS_IO_BoundQry]
                  SET 
                      processed = 1
                WHERE Processed = 0;
        END;
        IF
        (
            SELECT COUNT(*)
            FROM DFINAnalytics.[dbo].[DFS_CPU_BoundQry]
            WHERE Processed = 0
        ) > 0
            BEGIN
                UPDATE DFINAnalytics.[dbo].[DFS_CPU_BoundQry]
                  SET 
                      processed = 1
                WHERE Processed = 0;
        END;
    END;
GO
/****** Object:  StoredProcedure [dbo].[UTIL_QryPlanStats]    Script Date: 2/6/2019 8:19:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/* exec UTIL_QryPlanStats*/

CREATE PROCEDURE [dbo].[UTIL_QryPlanStats]
AS
    BEGIN
        IF OBJECT_ID('tempdb..#TEMP_DFS_QryOptStats') IS NOT NULL
            DROP TABLE #TEMP_DFS_QryOptStats;
        BEGIN
            WITH CTE_VW_STATS
                 AS (SELECT SCHEMA_NAME(vw.schema_id) AS schemaname, 
                            vw.name AS viewname, 
                            vw.object_id AS viewid
                     FROM sys.views AS vw
                     WHERE
                           (vw.is_ms_shipped = 0
                           )
                     INTERSECT
                     SELECT SCHEMA_NAME(o.schema_id) AS schemaname, 
                            o.Name AS name, 
                            st.objectid AS viewid
                     FROM sys.dm_exec_cached_plans AS cp
                               CROSS APPLY sys.dm_exec_sql_text(cp.plan_handle) AS st
                                    INNER JOIN sys.objects AS o
                                                ON st.[objectid] = o.[object_id]
                     WHERE st.dbid = DB_ID())
                 SELECT vw.schemaname, 
                        vw.viewname, 
                        vw.viewid, 
                        DB_NAME(t.databaseid) AS databasename, 
                        t.*
                 INTO #TEMP_DFS_QryOptStats
                 FROM CTE_VW_STATS AS vw
                           CROSS APPLY
                 (
                     SELECT st.dbid AS databaseid, 
                            st.text, 
                            qp.query_plan, 
                            qs.*, 
                            GETDATE() AS RunDate, 
                            @@VERSION AS SSVER, 
                            NEWID() AS [UID]
                     FROM sys.dm_exec_query_stats AS qs
                               CROSS APPLY sys.dm_exec_sql_text(qs.plan_handle) AS st
                                    CROSS APPLY sys.dm_exec_query_plan(qs.plan_handle) AS qp
                     WHERE
                           (CHARINDEX(vw.schemaname, st.text, 1) > 0
                           )
                           AND
                           (st.dbid = DB_ID()
                           )
                 ) AS t;
            DECLARE @s NVARCHAR(MAX);
            SET @s = DFINAnalytics.dbo.genInsertSql('#TEMP_DFS_QryOptStats', 'DFINAnalytics.dbo.DFS_QryOptStats');
            PRINT @s;
            EXECUTE sp_executesql 
                    @s;
        END;

/* W. Dale Miller
 DMA, Limited
 Offered under GNU License
 July 26, 2016*/

    END;
GO
/****** Object:  StoredProcedure [dbo].[UTIL_RecordCount]    Script Date: 2/6/2019 8:19:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- truncate table DFS_RecordCount;
-- EXEC UTIL_RecordCount 'xx1';
-- SELECT * FROM DFS_RecordCount;
CREATE PROCEDURE [dbo].[UTIL_RecordCount]
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
GO
/****** Object:  StoredProcedure [dbo].[UTIL_TableGrowthHistory]    Script Date: 2/6/2019 8:19:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- exec UTIL_TableGrowthHistory

CREATE PROCEDURE [dbo].[UTIL_TableGrowthHistory]
AS
    BEGIN
        SET NOCOUNT ON;
        DECLARE @TblToCount TABLE
        (SchemaTbl VARCHAR(250), 
         cnt       BIGINT NULL
        );
        DECLARE @TBLS TABLE
        (schema_name VARCHAR(250), 
         table_name  VARCHAR(250), 
         pk_name     VARCHAR(250), 
         columns     VARCHAR(2000),
         UNIQUE NONCLUSTERED(schema_name, table_name)
        );
        INSERT INTO @TBLS
               SELECT SCHEMA_NAME(tab.schema_id) AS schema_name, 
                      tab.name AS table_name, 
                      pk.name AS pk_name, 
                      SUBSTRING(column_names, 1, LEN(column_names) - 1) AS columns
               FROM sys.tables AS tab
                    LEFT OUTER JOIN sys.indexes AS pk ON tab.object_id = pk.object_id
                                                         AND pk.is_primary_key = 1
                    CROSS APPLY
               (
                   SELECT col.name + ', '
                   FROM sys.index_columns AS ic
                        INNER JOIN sys.columns AS col ON ic.object_id = col.object_id
                                                         AND ic.column_id = col.column_id
                   WHERE ic.object_id = tab.object_id
                         AND ic.index_id = pk.index_id
                   ORDER BY col.column_id FOR XML PATH('')
               ) AS D(column_names)
               ORDER BY SCHEMA_NAME(tab.schema_id), 
                        tab.name;
        UPDATE @TBLS
          SET 
              pk_name = '@'
        WHERE pk_name IS NULL;
        --select * from @TBLS
        --DECLARE @RUNID BIGINT= NEXT VALUE FOR master_seq;
		DECLARE @RUNID BIGINT;
		EXEC @RunID = DFINAnalytics.dbo.UTIL_GetSeq;
        DECLARE @i INT= 0;
        DECLARE @itot INT= 0;
        DECLARE @icnt INT= 0;
        DECLARE @msg NVARCHAR(1000)= '';
        DECLARE @mysql NVARCHAR(2000)= '';
        SET NOCOUNT ON;
        --select top 100 * from information_schema.tables 
        --select top 100 * from information_schema.columns 
        SET @itot =
        (
            SELECT COUNT(*)
            FROM information_schema.tables AS T
            WHERE T.table_type <> 'view'
        --and column_name = 'dbname'
        );
        DECLARE @TSchema VARCHAR(50);
        DECLARE @rowcount TABLE(Value INT);
        --DECLARE db_cursor CURSOR
        --FOR SELECT DISTINCT 
        --           T.table_name, 
        --           T.TABLE_SCHEMA
        --    FROM information_schema.tables T
        --         JOIN information_schema.columns C ON T.table_name = C.table_name
        --    WHERE table_type <> 'view'
        --    --and column_name = 'dbname'
        --    ORDER BY T.TABLE_NAME;
        DECLARE db_cursor CURSOR
        FOR SELECT schema_name, 
                   table_name, 
                   pk_name
            FROM @TBLS;
        DECLARE @pkname NVARCHAR(254)= NULL;
        DECLARE @name NVARCHAR(254)= NULL;
        DECLARE @irec INT= 0;
        OPEN db_cursor;
        FETCH NEXT FROM db_cursor INTO @TSchema, @name, @pkname;
        WHILE @@FETCH_STATUS = 0
            BEGIN
                DECLARE @FQN NVARCHAR(500)= @TSchema + '.' + @name;
                SET @i = @i + 1;
                --EXEC sp_printimmediate  '-------------------------------';
                SET @msg = 'Processing ' + @FQN + ' : ' + CAST(@i AS NVARCHAR(50)) + ' of ' + CAST(@itot AS NVARCHAR(50));
                --EXEC sp_printimmediate @msg;
                IF @pkname != '@'
                    BEGIN
                        EXEC @irec = proc_quickRowCount 
                             @name, 
                             @TSchema;
                        SET @msg = 'ROW CNT @1: ' + CAST(@irec AS NVARCHAR(50));
                        --EXEC sp_printimmediate @msg;
                END;
                    ELSE
                    BEGIN
                        DECLARE @STMT VARCHAR(500), @RowCnt INT, @SQL NVARCHAR(1000);
                        --SELECT @STMT = 'from ' + @fqn;
                        SELECT @SQL = N'SELECT @RowCnt = COUNT(*) from ' + @fqn;
                        EXEC sp_executesql 
                             @SQL, 
                             N'@RowCnt INT OUTPUT', 
                             @RowCnt OUTPUT;
                        SET @irec = @RowCnt;
                        SET @msg = 'ROW CNT @2: ' + CAST(@irec AS NVARCHAR(50));
                        --EXEC sp_printimmediate @msg;
                END;
                INSERT INTO DFINAnalytics.dbo.DFS_TableGrowthHistory
                (SvrName, 
                 DBName, 
                 Table_name, 
                 NbrRows, 
                 RUNID, 
                 TableSchema
                )
                VALUES
                (@@SERVERNAME, 
                 DB_NAME(), 
                 @name, 
                 @irec, 
                 @RUNID, 
                 @TSchema
                );
                FETCH NEXT FROM db_cursor INTO @TSchema, @name, @pkname;
            END;
        CLOSE db_cursor;
        DEALLOCATE db_cursor;
        SET NOCOUNT OFF;  
        -- W. Dale Miller
        -- DMA, Limited
        -- Offered under GNU License
        -- July 26, 2016
    END;
GO
