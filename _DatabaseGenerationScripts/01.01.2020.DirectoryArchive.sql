
/****** Object:  Table [dbo].[Directory]    Script Date: 9/23/2020 7:59:03 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
if exists (select 1 from sys.tables where name = 'DirectoryArchive')
	drop TABLE [dbo].[DirectoryArchive];
go

CREATE TABLE [dbo].[DirectoryArchive](
	DirKey varchar (1000) NOT NULL,
	Machinename varchar(250) not null,
	[UserID] [nvarchar](50) NOT NULL,
	[FQN] [varchar](max) NOT NULL,
	NbrFiles int default 0,
	LastArchive datetime default '01/01/1900',
	[RowGuid] [uniqueidentifier] default newid() not null	
 CONSTRAINT [PK_DirectoryArchive] PRIMARY KEY NONCLUSTERED 
(
	Machinename,
	[UserID] ASC,
	DirKey ASC
)
)
go
create unique index UK_DirectoryArchive on DirectoryArchive (UserID,DirKey)
go


if exists (select 1 from sys.procedures where name = 'insert_DirectoryArchive')
	drop procedure insert_DirectoryArchive
go

create procedure insert_DirectoryArchive (@UserID nvarchar(50), @DirName varchar(1000))
as
begin

	declare @i as integer = 0 ;
	declare @dHash as nvarchAR(max) = null;
	declare @DirKey as [binary] = null;

	set @dHash = (SELECT HASHBYTES('SHA2_256', @DirName));

	set @i = (select count(*) from DirectoryArchive where UserID = @UserID and DirKey = @DirKey);

	if @i = 0 begin
		insert into DirectoryArchive (UserID, FQN, DirKey) values (@UserID, @DirName, @DirKey);
	end

end
go

if exists (select 1 from sys.procedures where name = 'delete_DirectoryArchive')
	drop procedure delete_DirectoryArchive
go

create procedure delete_DirectoryArchive (@UserID nvarchar(50), @DirName varchar(1000))
as
begin

	declare @i as integer = 0 ;
	--declare @dHash as nvarchAR(max) = null;
	declare @DirKey as varchar(max) = null;

	--set @dHash = (SELECT HASHBYTES('SHA2_256', @DirName));
	--set @i = (select count from DirectoryArchive where UserID = @UserID and DirKey = @DirKey);

	if @i = 0 begin
		delete from DirectoryArchive where UserID = @UserID and FQN = @DirName;
	end

end

go 

if exists (select 1 from sys.procedures where name = 'update_DirectoryArchiveFileCnt')
	drop procedure update_DirectoryArchiveFileCnt
go
create procedure update_DirectoryArchiveFileCnt (@UserID nvarchar(50), @DirName varchar(1000), @cnt as int)
as
begin

	declare @i as integer = 0 ;
	declare @dHash as nvarchAR(max) = null;
	declare @DirKey as varchar(max) = null;

	set @dHash = (SELECT HASHBYTES('SHA2_256', @DirName));
	--set @i = (select count from DirectoryArchive where UserID = @UserID and DirKey = @DirKey);

	if @i = 0 begin
		update DirectoryArchive set NbrFiles = @cnt where DirKey = @dHash ;
	end

end
go
if exists (select 1 from sys.procedures where name = 'update_DirectoryArchiveFileLastUpdate')
	drop procedure update_DirectoryArchiveFileLastUpdate
go
create procedure update_DirectoryArchiveFileLastUpdate (@UserID nvarchar(50), @DirName varchar(1000))
as
begin

	declare @i as integer = 0 ;
	declare @dHash as nvarchAR(max) = null;
	declare @DirKey as varchar(max) = null;

	set @dHash = (SELECT HASHBYTES('SHA2_256', @DirName));
	--set @i = (select count from DirectoryArchive where UserID = @UserID and DirKey = @DirKey);

	if @i = 0 begin
		update DirectoryArchive set LastArchive = getdate() where DirKey = @dHash ;
	end

end

go

IF EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[trigDirectoryArchive]'))
	DROP TRIGGER [dbo].[trigDirectoryArchive]
go
--CREATE TRIGGER [dbo].[trigDirectoryArchive]
--ON [dbo].DirectoryArchive
--AFTER insert
--AS 
--BEGIN
--  SET NOCOUNT ON;
  
--  UPDATE DirectoryArchive set DirKey = (SELECT HASHBYTES('SHA2_256', FQN) FROM dbo.DirectoryArchive)
--   from INSERTED
--END
--GO

--ALTER TABLE [dbo].DirectoryArchive ENABLE TRIGGER trigDirectoryArchive
--GO


