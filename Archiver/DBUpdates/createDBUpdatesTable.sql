if not exists (select 1 from sys.tables where name = 'DBUpdate')
begin
create table DBUpdate (
	FileName varchar(900) not null,
	DateApplied datetime default getdate() not null,
	RowCreateDate datetime default getdate() not null,
	UpdateApplied integer default 0 null
)
end
go
if not exists (select 1 from sys.indexes where name = 'PC_DBUpdate')
	create unique clustered index PC_DBUpdate on DBUpdate(FileName)
go
