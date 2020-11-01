--UPDATE DB tyo carry RejectFileType
if exists (select 1 from sys.tables where name = 'RejectFileType');
	drop table RejectFileType;
go
create table RejectFileType
(
	FileExt nvarchar(20) not null
)

create unique clustered index PK_RejectFileType on RejectFileType (FileExt)
go

insert into RejectFileType (FileExt) values  ('.ext' );
insert into RejectFileType (FileExt) values  ('.dll' );
insert into RejectFileType (FileExt) values  ('.obj' );

