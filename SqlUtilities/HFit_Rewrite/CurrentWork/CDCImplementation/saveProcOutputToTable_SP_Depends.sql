use master
go
-- drop table DFS_TempDependencies 
-- truncate table DFS_TempDependencies
if not exists (select 1 from sys.tables where name = 'DFS_TempDependencies')
create table DFS_TempDependencies ([TargetObject] nvarchar(250), [name] nvarchar(250), [type] nvarchar(50), [updated] nvarchar(50), [selected] nvarchar(50), [column] nvarchar(250), RowNbr int identity(1,1) not null)
if not exists (select 1 from sys.tables where name = 'TempDependencies')
create table TempDependencies ([name] nvarchar(250), [type] nvarchar(50))
go


use BNYUK_ProductionAR_Port
go
--exec sp_depends 'IssuerCaption'; --table
--exec sp_depends 'IssuerLibrary'; --table

--show entities that gp_InsertIssuerCaptionFromHoldingsLoad depends upon
select * from sys.dm_sql_referencing_entities ('dbo.gp_InsertIssuerCaptionFromHoldingsLoad', 'OBJECT');
exec sp_depends 'gp_MigrateHoldingsLoad';
go

-- select * from DFINAnalytics.dbo.TempDependencies
if exists (select 1 from sys.procedures where name = 'UTIL_ObjectGetDependencies')
drop procedure UTIL_ObjectGetDependencies;
go

alter procedure UTIL_ObjectGetDependencies (@ObjectName nvarchar(250))
as 
begin
	declare @colcnt int = 0 ;
	declare @StartingRow int = (select max(RowNbr) from DFINAnalytics.dbo.DFS_TempDependencies);
	truncate table DFINAnalytics.dbo.TempDependencies;
	insert into DFINAnalytics.dbo.TempDependencies
	exec sp_depends @ObjectName;

	insert into DFINAnalytics.dbo.DFS_TempDependencies
	select @ObjectName, name, [type], NULL, NULL, NULL from DFINAnalytics.dbo.TempDependencies;
	set @StartingRow = @StartingRow + 1;
	print '@StartingRow = ' + cast(@StartingRow as nvarchar(50));
	select 'exec UTIL_ObjectGetDependencies' + name + ' where RowNbr > ' + cast(@StartingRow as nvarchar(50))  
		from DFINAnalytics.dbo.DFS_TempDependencies;
end 

/*
-- First Item;
-- truncate table DFINAnalytics.dbo.DFS_TempDependencies
-- select * from DFINAnalytics.dbo.DFS_TempDependencies
select 'exec UTIL_ObjectGetDependencies ''' + name  +''''
		from DFINAnalytics.dbo.DFS_TempDependencies where RowNbr > 0 ;
*/
exec sp_depends 'gp_InsertIssuerCaptionFromHoldingsLoad';

exec sp_depends 'IssuerCaption'; --table
exec sp_depends 'IssuerLibrary'; --table

exec UTIL_ObjectGetDependencies 'IssuerCaption';
exec UTIL_ObjectGetDependencies 'IssuerLibrary';

--exec sp_depends 'Staging_DataLoadBatchOptions'; --table
--exec sp_depends 'IssuerCaptionStaging'; --table
--exec sp_depends 'Staging_HoldingsLoad'; --table

exec sp_depends 'gf_GetHoldingsAndCategoryInformationView'; -- inline func
exec sp_depends 'gf_GetNMFPFundHoldingsAllByCriteria'; --table function
exec sp_depends 'gp_CopyIssuerLibrary'; --SP
exec sp_depends 'rdq_HoldingsInformationView'; --view

exec UTIL_ObjectGetDependencies 'IssuerCaption' ;
-- FOLLOWING ITEMS FROM HERE 
exec sp_depends 'IssuerCaption'
exec sp_depends 'gf_GetHoldingsAndCategoryInformationView'