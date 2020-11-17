----truncate table DFINAnalytics.[dbo].[DFS_Workload];
use [DFINAnalytics];
declare @ProcSQL nvarchar(max);
exec UTIL_GetSpCode @DBName ='master', @Schema = 'dbo' , @PName = 'UTIL_MonitorWorkload', @sql = @ProcSQL output;
select @ProcSQL;

use [AW2016];
if exists (select 1 from sys.procedures where name = 'DFS_Workload')
    drop procedure DFS_Workload;

exec sp_executesql @ProcSQL;

exec DFINAnalytics.dbo.UTIL_MonitorWorkload ;

if exists (select 1 from sys.procedures where name = 'DFS_Workload')
    drop procedure DFS_Workload;


select top 100 * from DFINAnalytics.[dbo].[DFS_Workload];

--DECLARE @RunID BIGINT;
--EXEC @RunID = sp_UTIL_GetSeq;
--PRINT 'RUN ID: ' + cast(@RunID as nvarchar(10));
--DECLARE @command NVARCHAR(1000);
--SELECT @command = 'USE ?; declare @DB as nvarchar(100) = DB_NAME() ; exec DFINAnalytics.dbo.UTIL_MonitorWorkload @DB' ;
--EXEC sp_MSforeachdb @command;