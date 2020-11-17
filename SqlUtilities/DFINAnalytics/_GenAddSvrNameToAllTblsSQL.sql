select 'ALTER TABLE ' + T.table_name + ' ADD [SVRName] nvarchar(150) not null; ' as CMD
from INFORMATION_SCHEMA.tables T
where table_name not in (
select C.table_name from INFORMATION_SCHEMA.COLUMNS C
where C.COLUMN_NAME = 'SVRNAME'
OR C.COLUMN_NAME = 'ServerName'
OR C.COLUMN_NAME = 'SVR'
)
AND T.TABLE_TYPE = 'BASE TABLE'





ALTER TABLE DFS_PerfMonitor ADD [UID] uniqueidentifier default newid() null; 
ALTER TABLE DFS_DBVersion ADD [UID] uniqueidentifier default newid() null; 
ALTER TABLE DFS_WaitTypes ADD [UID] uniqueidentifier default newid() null; 
ALTER TABLE SequenceTABLE ADD [UID] uniqueidentifier default newid() null; 
ALTER TABLE DFS_MissingIndexes ADD [UID] uniqueidentifier default newid() null; 
ALTER TABLE DFS_MissingFKIndexes ADD [UID] uniqueidentifier default newid() null; 
ALTER TABLE DFS_QryOptStats ADD [UID] uniqueidentifier default newid() null; 
ALTER TABLE DFS_TableReadWrites ADD [UID] uniqueidentifier default newid() null; 
ALTER TABLE DFS_IndexFragProgress ADD [UID] uniqueidentifier default newid() null; 
ALTER TABLE DFS_IndexFragErrors ADD [UID] uniqueidentifier default newid() null; 
ALTER TABLE DFS_IndexFragHist ADD [UID] uniqueidentifier default newid() null; 
ALTER TABLE DFS_BlockingHistory ADD [UID] uniqueidentifier default newid() null; 
ALTER TABLE DFS_DB2Skip ADD [UID] uniqueidentifier default newid() null; 
ALTER TABLE DFS_SEQ ADD [UID] uniqueidentifier default newid() null; 
ALTER TABLE DFS_SequenceTABLE ADD [UID] uniqueidentifier default newid() null; 
ALTER TABLE DFS_IndexStats ADD [UID] uniqueidentifier default newid() null; 
ALTER TABLE DFS_TxMonitorTblUpdates ADD [UID] uniqueidentifier default newid() null; 
ALTER TABLE DFS_DbFileSizing ADD [UID] uniqueidentifier default newid() null; 
ALTER TABLE DFS_IndexFragReorgHistory ADD [UID] uniqueidentifier default newid() null; 
ALTER TABLE DFS_TableGrowthHistory ADD [UID] uniqueidentifier default newid() null; 
ALTER TABLE DFS_QryPlanBridge ADD [UID] uniqueidentifier default newid() null; 