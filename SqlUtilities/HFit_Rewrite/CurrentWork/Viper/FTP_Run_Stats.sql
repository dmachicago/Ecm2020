
-- drop table FTP_Run_Stats
create table FTP_Run_Stats
(
FileID int not null,
ClientID int not null,
[FileName] nvarchar(500) not null,
StatName  nvarchar(100) not null,
StatTime nvarchar(100) null ,
CreateDate datetime default getdate(),
RowNumber int identity (1,1) not null
)
create unique clustered index PKI_FTP_Run_Stats on FTP_Run_Stats (RowNumber);
go

-- truncate table FTP_Run_Stats
select * from FTP_Run_Stats order by RowNUmber
