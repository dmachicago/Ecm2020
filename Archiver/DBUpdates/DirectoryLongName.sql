
if exists (select 1 from sys.tables where name = 'DirectoryLongName')
	DROP TABLE [dbo].[DirectoryLongName]
GO

CREATE TABLE [dbo].[DirectoryLongName](
	[RowGuid] [uniqueidentifier] NULL default newid(),
	[DIRHASH] [varchar](150) NULL,
	[DirLongName] [nvarchar](max) NOT NULL,
	RowCreateDate datetime default getdate()
) 
GO

CREATE UNIQUE NONCLUSTERED INDEX [PK_DirHash] ON [dbo].[DirectoryLongName]
(
	[DIRHASH] ASC
)
go
CREATE NONCLUSTERED INDEX [PK_DirRowGuis] ON [dbo].[DirectoryLongName]
(
	[RowGuid] ASC
)

go

IF EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[Insert_DirectoryLongName]'))
	DROP TRIGGER [dbo].[Insert_DirectoryLongName]
go
-- create a new trigger
CREATE TRIGGER [dbo].[Insert_DirectoryLongName]
ON DirectoryLongName
AFTER INSERT
AS 
BEGIN   
    SET NOCOUNT ON;

    -- update your table, using a set-based approach
    -- from the "Inserted" pseudo table which CAN and WILL
    -- contain multiple rows!
    UPDATE [dbo].[DirectoryLongName]
    SET  DIRHASH = (select convert(char(128), HASHBYTES('sha2_512', i.DirLongName), 1))
    FROM Inserted i
END
GO

if exists (select 1 from sys.procedures where name = 'spInsertDirectoryLongName')
	drop procedure spInsertDirectoryLongName
go

-- exec spInsertDirectoryLongName 'c:\wdm'
-- select * from [dbo].[DirectoryLongName]
create procedure spInsertDirectoryLongName (@DirName varchar(max) )
as
begin 
	insert into [dbo].[DirectoryLongName] ([DirLongName]) values (@DirName)
end

