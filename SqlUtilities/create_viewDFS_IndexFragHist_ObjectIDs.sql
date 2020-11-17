EXEC UTIL_ReorgFragmentedIndexes 0;

select I.index_id as IDXID from AP_ProductionAR_Port.sys.tables T
join AP_ProductionAR_Port.sys.indexes I on I.object_id = T.object_id
where T.name = 'TabularDataDefinition' and I.name = 'PK_TabularDataDefinition';

select top 10 * from [master].[dbo].[DFS_IndexFragHist];
go
create view dbo.viewDFS_IndexFragHist_ObjectIDs
as
SELECT *, 
DB_ID([DBName]) as DBID,
OBJECT_ID(DBName +'.'+[Schema]+'.'+[Table]) as TblObjID,
(select I.index_id as IDXID from AP_ProductionAR_Port.sys.tables T
join AP_ProductionAR_Port.sys.indexes I 
	on I.object_id = T.object_id
	--and I.index_id = T.index_id
where T.name = [Table] and I.name = [Index]) as IDXID
FROM [master].[dbo].[DFS_IndexFragHist] 
go

select * from viewDFS_IndexFragHist_ObjectIDs
where [Index] = 'IDX_RequestStatus_Polling_UpdatedBy';

select [DBID], TblObjID, IDXID from viewDFS_IndexFragHist_ObjectIDs;

select 'Select max(avg_fragmentation_in_percent)  from sys.dm_db_index_physical_stats ( '
+cast([DBID] as varchar(25)) +',' + cast([TblObjID]  as varchar(25)) +','+cast(IDXID as varchar(25))+', NULL, ''DETAILED''' + ');' as CMD
from viewDFS_IndexFragHist_ObjectIDs
where [DBName] = 'AP_ProductionAF_Port'
and [schema] = 'dbo'
and [Table] = 'OutputQueue' 
and [Index] = 'IDX_RequestStatus_Polling_UpdatedBy' ;

Select max(avg_fragmentation_in_percent)  from sys.dm_db_index_physical_stats ( 861,85627398,27, NULL, 'DETAILED');
Select max(avg_fragmentation_in_percent)  from sys.dm_db_index_physical_stats ( 964,2021634295,27, NULL, 'DETAILED');

Select * from sys.dm_db_index_physical_stats ( 234,1749581271,4, NULL, 'DETAILED');
Select max(avg_fragmentation_in_percent)  from sys.dm_db_index_physical_stats ( 234,1749581271,4, NULL, 'DETAILED');

select 'Alter Index [' + [Index] + '] ON [' + [DBName]+'].['+ [Schema] + '].[' + [Table] + '] REORGANIZE; ' as CMD 
from viewDFS_IndexFragHist_ObjectIDs
where [DBID] = 861 
AND [TblObjID] = 293628139
AND IDXID = 2;

Alter Index [IDX_FundKey] ON [AP_ProductionAF_Port].[dbo].[OutputLog] REORGANIZE; 
Select * from sys.dm_db_index_physical_stats ( 861,293628139,2, 0, 'DETAILED');

