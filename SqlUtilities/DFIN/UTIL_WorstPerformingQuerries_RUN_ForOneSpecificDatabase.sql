

use [DFINAnalytics];

declare @DBNAME nvarchar(100) = 'BNYUK_ProductionAR_Port' ;
declare @NextID bigint = 0 ;
declare @cmd nvarchar(4000) ;

exec @NextID = sp_UTIL_GetSeq;
print @DBNAME;
print @NextID;

use [BNYUK_ProductionAR_Port]
exec sp_UTIL_IO_BoundQry2000 @DBNAME, @NextID

select * from [DFINAnalytics].[dbo].[DFS_CPU_BoundQry2000] where RunID = @NextID order by RunID desc;
select * from [DFINAnalytics].[dbo].[DFS_IO_BoundIO2000] where RunID = @NextID order by RunID desc;

select top 100 * from [DFINAnalytics].[dbo].[DFS_CPU_BoundQry2000] order by RunID desc ;
select top 100 * from [DFINAnalytics].[dbo].[DFS_IO_BoundQry2000] order by RunID desc ;