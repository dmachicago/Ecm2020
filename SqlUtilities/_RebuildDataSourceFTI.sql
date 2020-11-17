
USE [ECM.Library.FS]
GO

if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = 'DataSource' and COLUMN_NAME = 'RowGuid')
	alter table DataSource add RowGuid uniqueidentifier not null default newid();
go

IF not EXISTS (
		SELECT 1
		FROM sys.fulltext_catalogs
		WHERE [name] = 'ftCatalog'
		)
		begin
DROP FULLTEXT INDEX ON DataSource;
end
go

ALTER TABLE [dbo].[DataSource] DROP CONSTRAINT [PK_DataSource_1]
GO

ALTER TABLE [dbo].[DataSource] ADD  CONSTRAINT [PK_DataSource_1] PRIMARY KEY NONCLUSTERED 
(
	[RowGuid] ASC
)
GO

--**************************************************
-- Item #2
--**************************************************
if (select [name] from sys.fulltext_catalogs where [name] = 'ftCatalog') is null
BEGIN
	CREATE FULLTEXT CATALOG ftCatalog
	WITH ACCENT_SENSITIVITY = OFF
END
GO
if (select [name] from sys.fulltext_catalogs where [name] = 'ftCatalog') is null
BEGIN
	CREATE FULLTEXT INDEX ON [dbo].[DataSource] (
	SourceName Language 1033 
	,FQN Language 1033 
	,Description Language 1033 
	,KeyWords Language 1033 
	,Notes Language 1033 
	,OcrText Language 1033 
	,SourceImage Language 1033 
	) 
	KEY INDEX PK_DataSource
	ON ftCatalog
	WITH CHANGE_TRACKING AUTO
END
GO

--**************************************************
-- Item #4
--**************************************************
if (select [name] from sys.fulltext_catalogs where [name] = 'ftDataSourceImage') is null
BEGIN
CREATE FULLTEXT CATALOG ftDataSourceImage
WITH ACCENT_SENSITIVITY = OFF
END
GO
if (select [name] from sys.fulltext_catalogs where [name] = 'ftDataSourceImage') is null
BEGIN

CREATE FULLTEXT INDEX ON [dbo].[DataSourceImage] (
SourceImage Language 1033 
) 
KEY INDEX PKey_DataSourceImage
ON ftDataSourceImage
WITH CHANGE_TRACKING AUTO
END
GO

--**************************************************
-- Item #7
--**************************************************
if (select [name] from sys.fulltext_catalogs where [name] = 'ftEmailCatalog') is null
BEGIN
CREATE FULLTEXT CATALOG ftEmailCatalog
WITH ACCENT_SENSITIVITY = OFF
END
GO

if (select [name] from sys.fulltext_catalogs where [name] = 'ftEmailCatalog') is null
BEGIN

CREATE FULLTEXT INDEX ON [dbo].[Email] (
SUBJECT Language 1033 
,Body Language 1033 
,EmailImage Language 1033 
,ShortSubj Language 1033 
,Description Language 1033 
,KeyWords Language 1033 
,notes Language 1033 
) 
KEY INDEX PK__Email__24383F235DE40451
ON ftEmailCatalog
WITH CHANGE_TRACKING AUTO
END
GO
if (select [name] from sys.fulltext_catalogs where [name] = 'ftEmailCatalog') is null
BEGIN

CREATE FULLTEXT INDEX ON [dbo].[EmailAttachment] (
AttachmentName Language 1033 
,OcrText Language 1033 
,Attachment Language 1033 
) 
KEY INDEX PK__EmailAtt__B975DD8289908A26
ON ftEmailCatalog
WITH CHANGE_TRACKING AUTO
END
GO
