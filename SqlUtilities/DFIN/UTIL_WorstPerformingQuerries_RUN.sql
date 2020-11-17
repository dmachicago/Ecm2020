-- W. Dale Miller
-- wdalemiller@gmail.com

use [DFINAnalytics];
declare @DBNAME nvarchar(100) ;
declare @NextID bigint = 1 ;
declare @cmd nvarchar(4000) ;

exec @NextID = sp_UTIL_GetSeq;
print @NextID;

set @cmd = 'use ? ; exec DFINAnalytics.dbo.UTIL_IO_BoundQry2000 ?, '+cast(@NextID as varchar(10))+'; exec DFINAnalytics.dbo.UTIL_CPU_BoundQry2000 ?,'+cast(@NextID as varchar(10))+';';
print @cmd;
exec sp_MSforeachdb @cmd ;

--set @DBNAME = db_name();
--print 'USING: ' + @cmd;

--exec DFINAnalytics.dbo.UTIL_IO_BoundQry2000 @DBNAME, @NextID;
--exec DFINAnalytics.dbo.UTIL_CPU_BoundQry2000 @DBNAME, @NextID;

--SELECT  'IO' as TypeRun, [SVRName]
--      ,[DBName]
--      ,[creation_time]
--      ,[last_execution_time]
--      ,[execution_count]
--      ,[total_worker_time]
--      ,[last_worker_time]
--      ,[min_worker_time]
--      ,[max_worker_time]
--      ,[total_physical_reads]
--      ,[last_physical_reads]
--      ,[min_physical_reads]
--      ,[max_physical_reads]
--      ,[total_logical_writes]
--      ,[last_logical_writes]
--      ,[min_logical_writes]
--      ,[max_logical_writes]
--      ,[total_logical_reads]
--      ,[last_logical_reads]
--      ,[min_logical_reads]
--      ,[max_logical_reads]
--      ,[total_clr_time]
--      ,[last_clr_time]
--      ,[min_clr_time]
--      ,[max_clr_time]
--      ,[total_elapsed_time]
--      ,[last_elapsed_time]
--      ,[min_elapsed_time]
--      ,[max_elapsed_time]
--      ,[query_hash]
--      ,[query_plan_hash]
--      ,[total_rows]
--      ,[last_rows]
--      ,[min_rows]
--      ,[max_rows]
--      ,[RunDate]
--      ,[RunID]
--  FROM [DFINAnalytics].[dbo].[DFS_CPU_BoundQry2000]

--SELECT 'IO' as TypeRun, [SVRName]
--      ,[DBName]
--      ,[creation_time]
--      ,[last_execution_time]
--      ,[execution_count]
--      ,[total_worker_time]
--      ,[last_worker_time]
--      ,[min_worker_time]
--      ,[max_worker_time]
--      ,[total_physical_reads]
--      ,[last_physical_reads]
--      ,[min_physical_reads]
--      ,[max_physical_reads]
--      ,[total_logical_writes]
--      ,[last_logical_writes]
--      ,[min_logical_writes]
--      ,[max_logical_writes]
--      ,[total_logical_reads]
--      ,[last_logical_reads]
--      ,[min_logical_reads]
--      ,[max_logical_reads]
--      ,[total_clr_time]
--      ,[last_clr_time]
--      ,[min_clr_time]
--      ,[max_clr_time]
--      ,[total_elapsed_time]
--      ,[last_elapsed_time]
--      ,[min_elapsed_time]
--      ,[max_elapsed_time]
--      ,[query_hash]
--      ,[query_plan_hash]
--      ,[total_rows]
--      ,[last_rows]
--      ,[min_rows]
--      ,[max_rows]
--      ,[RunDate]
--      ,[RunID]
--  FROM [DFINAnalytics].[dbo].[DFS_IO_BoundQry2000]


----truncate table [DFINAnalytics].[dbo].[DFS_IO_BoundQry2000];
----truncate table [DFINAnalytics].[dbo].[DFS_CPU_BoundQry2000];