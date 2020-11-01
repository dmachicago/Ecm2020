
if exists (select 1 from sys.tables where name = 'FileLongName')
	DROP TABLE [dbo].[FileLongName]
GO

CREATE TABLE [dbo].[FileLongName](
	[RowGuid] [uniqueidentifier] NULL default newid(),
	[FileHASH] [varchar](150) NULL,
	[FilesLongName] [nvarchar](max) NOT NULL,
	RowCreateDate datetime default getdate()
) 
GO

CREATE UNIQUE NONCLUSTERED INDEX [PK_DirHash] ON [dbo].[FileLongName]
(
	[FileHASH] ASC
)
go
CREATE NONCLUSTERED INDEX [PK_DirRowGuis] ON [dbo].[FileLongName]
(
	[RowGuid] ASC
)

go

IF EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[TRIGGERNAME]'))
	DROP TRIGGER [dbo].[Insert_FileLongName]
go
-- create a new trigger
CREATE TRIGGER [dbo].[Insert_FileLongName]
ON FileLongName
AFTER INSERT
AS 
BEGIN   
    SET NOCOUNT ON;

    -- update your table, using a set-based approach
    -- from the "Inserted" pseudo table which CAN and WILL
    -- contain multiple rows!
    UPDATE [dbo].[FileLongName]
    SET  FileHASH = (select convert(char(128), HASHBYTES('sha2_512', i.FilesLongName), 1))
    FROM Inserted i
END
GO

if exists (select 1 from sys.procedures where name = 'spInsertFileLongName')
	drop procedure spInsertFileLongName
go

-- exec spInsertFileLongName 'c:\wdm'
-- select * from [dbo].[FileLongName]
create procedure spInsertFileLongName (@FName varchar(max) )
as
begin 
	insert into [dbo].[FileLongName] ([FilesLongName]) values (@FName)
end

