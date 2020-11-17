/****************************************************************************************/
-- select * from DFS_TestDBContext
-- drop Table DFS_TestDBContext
if not exists (select 1 from sys.tables where name = 'DFS_TestDBContext')
	create Table DFS_TestDBContext (
		SVR nvarchar (150) null,
		DBNAME nvarchar (150) null,
		ProcName nvarchar (150) null,
		ExecuteDate datetime default getdate(),
		ProcValues nvarchar (max) null
	)
go
/****************************************************************************************/
if exists (select 1 from sys.procedures where name = 'UTIL_TestDBContext')
	drop procedure UTIL_TestDBContext;
go
create procedure UTIL_TestDBContext
as
begin
		insert into DFS_TestDBContext (SVR, DBNAME, ProcName, ExecuteDate) values (@@SERVERNAME, db_name(),'UTIL_TestDBContext', getdate());
end

go
/****************************************************************************************/
if exists (select 1 from sys.procedures where name = 'UTIL_TestDBProcCall')
	drop procedure UTIL_TestDBProcCall;
go
create procedure UTIL_TestDBProcCall
as
begin
		insert into DFS_TestDBContext (SVR, DBNAME, ProcName, ExecuteDate) values (@@SERVERNAME, db_name(),'UTIL_TestDBProcCall', getdate());
end

go
/****************************************************************************************/
if exists (select 1 from sys.procedures where name = 'UTIL_TestDBProcCallWithParms')
	drop procedure UTIL_TestDBProcCallWithParms;
go
create procedure UTIL_TestDBProcCallWithParms (@parm1 nvarchar(150), @int int)
as
begin
		declare @parms nvarchar(500) = '' ;
		set @parms = @parms + @parm1 + ' :: ' + cast(@int as nvarchar(150));
		insert into DFS_TestDBContext (SVR, DBNAME, ProcName, ExecuteDate, ProcValues) values (@@SERVERNAME, db_name(),'UTIL_TestDBProcCallWithParms', getdate(), @parms);
end

go