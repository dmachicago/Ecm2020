--* USEDFINAnalytics;
go
--truncate table DFS_IO_BoundQry2000;
--truncate table DFS_CPU_BoundQry2000;

--declare @stmt nvarchar(100) = '--* USE?; exec UTIL_CPU_BoundQry2000 ; exec UTIL_IO_BoundQry2000 ;'
declare @stmt nvarchar(100) = 'exec UTIL_CPU_BoundQry2000 ; exec UTIL_IO_BoundQry2000 ;'
exec sp_msForEachDB @stmt ;

/*
select top 20 * from [dbo].[DFS_IO_BoundQry2000] where total_elapsed_time >= 2000000 order by query_hash, Rownbr desc;
select top 20 * from [dbo].[DFS_CPU_BoundQry2000] where total_elapsed_time >= 2000000 order by  query_hash, Rownbr desc;
*/