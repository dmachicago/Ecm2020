
-- drop table DataSourceFQN
-- update DataSource set fqnhash = null

alter table DataSource alter column HashFile nvarchar(150) null
go

if not exists (select 1 from sys.tables where name = 'DataSourceFQN')
	create table DataSourceFQN (
	FqnHASH nvarchar(150) not null,
	FQN nvarchar(max)
	)
go 
if not exists (select 1 from sys.indexes where name = 'PI_DataSourceFQN')
create index PI_DataSourceFQN on DataSourceFQN(FqnHASH);
go
if not exists (select 1 from INFORMATION_SCHEMA.columns where table_name = 'DataSource' and COLUMN_NAME = 'FqnHASH')
	alter table DataSource add FqnHASH nvarchar(150) null
go
-- drop index PI_FQNHASH on DataSource;
if not exists (select 1 from sys.indexes where name = 'PI_FQNHASH')
	create index PI_FQNHASH on DataSource (FqnHASH) ;
go

if exists (select 1 from sys.procedures where name = 'spValidateLongFileNames')
	drop procedure spValidateLongFileNames;
go

create procedure spValidateLongFileNames
as
begin
	update DataSource set FqnHASH = (select UPPER(convert(char(128), HASHBYTES('sha2_512', upper(FQN)), 1))) where FqnHASH is null;

	INSERT INTO DataSourceFQN (FqnHASH, fqn) 
	select distinct FqnHASH, upper(fqn) from DataSource D
	WHERE D.FqnHASH NOT IN (SELECT FqnHASH FROM DataSourceFQN);

end
go
-- exec spValidateLongFileNames
checkpoint
