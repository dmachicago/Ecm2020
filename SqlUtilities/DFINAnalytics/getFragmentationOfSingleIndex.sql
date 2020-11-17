
if exists (select 1 from sys.procedures where name = 'getIndexFragPct')
	drop procedure getIndexFragPct;
go
select top 10 * from sys.tables
select top 10 * from sys.databases
select top 10 * from sys.schemas



select db_id('DFINAnalytics');
select db_nAME();

SELECT top 1 OBJECT_NAME(ind.OBJECT_ID) AS TableName, 
ind.name AS IndexName, indexstats.index_type_desc AS IndexType, 
indexstats.avg_fragmentation_in_percent 
FROM sys.dm_db_index_physical_stats(DB_ID(), NULL, NULL, NULL, NULL) indexstats 
INNER JOIN sys.indexes ind  
ON ind.object_id = indexstats.object_id 
AND ind.index_id = indexstats.index_id 
join sys.tables T on T.object_id = ind.object_id
join sys.schemas S on T.schema_id = S.schema_id
and T.type = 'U'
--WHERE indexstats.avg_fragmentation_in_percent >  5
where OBJECT_NAME(ind.OBJECT_ID) = 'JobCandidate'
and ind.name = 'PK_JobCandidate_JobCandidateID'
and indexstats.avg_fragmentation_in_percent > 0
ORDER BY indexstats.avg_fragmentation_in_percent DESC