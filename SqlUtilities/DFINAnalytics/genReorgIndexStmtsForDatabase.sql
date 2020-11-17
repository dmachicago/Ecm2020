
declare @RunID nvarchar(60) = '1' ; 
declare @MaxPct int = 30 ;
declare @PreviewOnly   INT    = 0;
declare @ReorgIndexes  INT    = 1;
exec dbo.UTIL_DefragAllIndexes 'Sun_ProductionAF_Data', 'TS_PSCAR_Port', @MaxPct,@PreviewOnly, @ReorgIndexes , @RunID ;
-- SSC_Production3_Log

select 'exec dbo.UTIL_DefragAllIndexes ''' + name +''',NULL, 30,0,1,10 ;' + char(10) + 'go' from sys.databases
where name not in ('master', 'model','msdb','tempdb')
and name > 'TS_PSCAR_Port';

