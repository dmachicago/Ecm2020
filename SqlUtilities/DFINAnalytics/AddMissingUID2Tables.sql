select 'Alter table ' +  T.table_name + ' ADD [UID] uniqueidentifier not null default newid() ; '  as CMD from INFORMATION_SCHEMA.TABLES T
where T.table_name not in (
select table_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'UID'
)
and t.TABLE_TYPE = 'BASE TABLE'
and t.TABLE_NAME like 'DFS%'

Alter table DFS_PerfMonitor ADD [UID] uniqueidentifier not null default newid() ; 
Alter table DFS_DBVersion ADD [UID] uniqueidentifier not null default newid() ; 
Alter table DFS_MissingIndexes ADD [UID] uniqueidentifier not null default newid() ; 
Alter table DFS_MissingFKIndexes ADD [UID] uniqueidentifier not null default newid() ; 
Alter table DFS_IndexReorgCmds ADD [UID] uniqueidentifier not null default newid() ; 
Alter table DFS_TableStats ADD [UID] uniqueidentifier not null default newid() ; 
Alter table DFS_TempProcErrors ADD [UID] uniqueidentifier not null default newid() ; 
Alter table DFS_IndexFragProgress ADD [UID] uniqueidentifier not null default newid() ; 
Alter table DFS_IndexFragErrors ADD [UID] uniqueidentifier not null default newid() ; 
Alter table DFS_IndexFragHist ADD [UID] uniqueidentifier not null default newid() ; 
Alter table DFS_BlockingHistory ADD [UID] uniqueidentifier not null default newid() ; 
Alter table DFS_DB2Skip ADD [UID] uniqueidentifier not null default newid() ; 
Alter table DFS_SEQ ADD [UID] uniqueidentifier not null default newid() ; 
Alter table DFS_SequenceTABLE ADD [UID] uniqueidentifier not null default newid() ; 
Alter table DFS_RecordCount ADD [UID] uniqueidentifier not null default newid() ; 
Alter table DFS_IndexStats ADD [UID] uniqueidentifier not null default newid() ; 
Alter table DFS_TxMonitorTblUpdates ADD [UID] uniqueidentifier not null default newid() ; 
Alter table DFS_DbFileSizing ADD [UID] uniqueidentifier not null default newid() ; 
Alter table DFS_IndexFragReorgHistory ADD [UID] uniqueidentifier not null default newid() ; 
Alter table DFS_TableGrowthHistory ADD [UID] uniqueidentifier not null default newid() ; 
Alter table DFS_QryPlanBridge ADD [UID] uniqueidentifier not null default newid() ; 