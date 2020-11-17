select distinct @@Servername, db_name() as DBName, t.name ,s.row_count, getdate() as RunDate from sys.tables t
join sys.dm_db_partition_stats s
ON t.object_id = s.object_id
and t.type_desc = 'USER_TABLE'
and t.name like 'DFS%'
and s.row_count > 0

/*
select top 100 * from DFS_Workload order by SvrName, RunDate desc;

select top 10 * from DFS_DBSpace order by Database_name, SVR, database_size desc, createdate desc;

select top 10 * from DFS_IO_BoundQry2000 order by RunDate desc, total_worker_Time desc ;
select top 10 * from DFS_CPU_BoundQry2000 order by RunDate desc, total_worker_Time desc ;
select top 10 * from DFS_QryPlanBridge;
select top 10 * from DFS_QrysPlans;

select top 10 * from DFS_MonitorMostCommonWaits order by SVR, DBName, Wait_type, wait_time_ms desc ;

select top 10 * from DFS_TxMonitorIDX order by TableName, SvrName, DBName ;
select top 10 * from DFS_TxMonitorTableIndexStats order by TableName, SVR, DBName, ExecutionDate desc ;

select top 10 * from DFS_TxMonitorTableStats order by TableName, SVR, DBName ;
select top 10 * from DFS_DBTableSpace order by name, svr, DBName ;
select top 10 * from DFS_TableSizeAndRowCnt order by TableName, SvrName, DBName ;
*/