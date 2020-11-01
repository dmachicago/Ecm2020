use master 
go 

if exists (Select 1 from sys.procedures where name = 'TestProc')
	drop procedure TestProc
go

create procedure TestProc 
as
begin
	print 'TestProc Started...'
	DBCC TRACEON (661, -1)
end
go

exec sp_procoption @ProcName = ['TestProc'], 
@OptionName = 'STARTUP', 
@OptionValue = [on]