select 'Create Index PIUID_' + TBL.name + ' ON ' + TBL.name + ' ([UID]) ;' + char(10) + 'GO'   as TableName 
from sys.tables TBL 
where TBL.Name not in 
(
select distinct T.name from sys.tables T 
join sys.indexes I on T.object_id = I.object_id
join sys.columns C on T.object_id = C.object_id
where I.name is not null and C.Name = 'UID'
)

Create Index PIUID_DFS_TxMonitorTableStats ON DFS_TxMonitorTableStats ([UID]) ;
GO
Create Index PIUID_DFS_TranLocks ON DFS_TranLocks ([UID]) ;
GO
Create Index PIUID_SequenceTABLE ON SequenceTABLE ([UID]) ;
GO
Create Index PIUID_DFS_MissingFKIndexes ON DFS_MissingFKIndexes ([UID]) ;
GO
Create Index PIUID_DFS_TableStats ON DFS_TableStats ([UID]) ;
GO
Create Index PIUID_DFS_IndexReorgCmds ON DFS_IndexReorgCmds ([UID]) ;
GO
Create Index PIUID_DFS_Workload ON DFS_Workload ([UID]) ;
GO
Create Index PIUID_DFS_DbFileSizing ON DFS_DbFileSizing ([UID]) ;
GO
Create Index PIUID_DFS_SEQ ON DFS_SEQ ([UID]) ;
GO
Create Index PIUID_DFS_RecordCount ON DFS_RecordCount ([UID]) ;
GO
Create Index PIUID_DFS_TableGrowthHistory ON DFS_TableGrowthHistory ([UID]) ;
GO
Create Index PIUID_DFS_IO_BoundQry2000 ON DFS_IO_BoundQry2000 ([UID]) ;
GO
Create Index PIUID_DFS_CPU_BoundQry2000 ON DFS_CPU_BoundQry2000 ([UID]) ;
GO
Create Index PIUID_DFS_TxMonitorTblUpdates ON DFS_TxMonitorTblUpdates ([UID]) ;
GO
Create Index PIUID_DFS_BlockingHistory ON DFS_BlockingHistory ([UID]) ;
GO
Create Index PIUID_DFS_IndexStats ON DFS_IndexStats ([UID]) ;
GO
Create Index PIUID_DFS_QryOptStats ON DFS_QryOptStats ([UID]) ;
GO
Create Index PIUID_DFS_IndexFragReorgHistory ON DFS_IndexFragReorgHistory ([UID]) ;
GO
Create Index PIUID_DFS_TxMonitorIDX ON DFS_TxMonitorIDX ([UID]) ;
GO
Create Index PIUID_DFS_TxMonitorTableIndexStats ON DFS_TxMonitorTableIndexStats ([UID]) ;
GO
Create Index PIUID_DFS_TableSizeAndRowCnt ON DFS_TableSizeAndRowCnt ([UID]) ;
GO