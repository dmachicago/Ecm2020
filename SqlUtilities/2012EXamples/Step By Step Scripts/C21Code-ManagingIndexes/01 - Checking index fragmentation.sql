
declare @dbname nvarchar(100) = 'DFSAnalytics';
declare @MaxPct decimal (6,2) = 20.5;

SELECT DB_NAME(ips.database_id) DBName, 
       OBJECT_NAME(ips.object_id) ObjName, 
       i.name IdxName, 
       cast(ips.avg_fragmentation_in_percent as decimal(6,2)) as AvgFragPct
FROM sys.dm_db_index_physical_stats(DB_ID(@dbname), DEFAULT, DEFAULT, DEFAULT, DEFAULT) ips
     INNER JOIN sys.indexes i ON ips.index_id = i.index_id
                                 AND ips.object_id = i.object_id
WHERE ips.object_id > 99
      AND ips.avg_fragmentation_in_percent >= @MaxPct
      AND ips.index_id > 0;