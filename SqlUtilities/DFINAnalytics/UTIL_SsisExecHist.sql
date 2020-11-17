
GO
/*
	truncate table DFS_SsisExecHist
	
	select * from DFS_SsisExecHist
	select * from ActiveServers order by SvrName, DBName

	delete from ActiveServers where DBNAme in ('master', 'ReportServer', 'ReportServerTempDB')

	update ActiveServers set [enable] = 0 where SvrName = 'ALIEN15' and DBName = 'TestDB'
	update ActiveServers set [enable] = 0 where SvrName = 'SVR2016' and DBName = 'TestDB'
	update ActiveServers set [enable] = 0 where SvrName = 'ALIEN15' and DBName = 'AW_AZURE'
	update ActiveServers set [enable] = 0 where SvrName = 'ALIEN15' and DBName = 'TestXml'
	update ActiveServers set [enable] = 0 where SvrName = 'ALIEN15' and DBName = 'DFINAnalytics'
	update ActiveServers set [enable] = 0 where SvrName = 'ALIEN15' and DBName = 'PowerDatabase'
*/
if not exists(select 1 from sys.tables where name = 'DFS_SsisExecHist')
begin 
	create table DFS_SsisExecHist(
		SvrName nvarchar(150) null,
		DBName nvarchar(150) null,
		CreateDate datetime default getdate(),
		RowNbr int identity (1,1) not null
	)
end ;
go
if exists(select 1 from sys.procedures where name = 'UTIL_SsisExecHist')
	drop procedure UTIL_SsisExecHist;
go
create procedure UTIL_SsisExecHist (@SVR nvarchar(150), @DB nvarchar(150))
as
	insert into DFS_SsisExecHist (SvrName,DBName) values (@SVR, @DB);

GO