use [ECM.Library.FS]

/**************************************************
1
**************************************************/
if exists (SELECT 1 as TableName FROM sys.fulltext_indexes 
where OBJECT_NAME(object_id) = 'DataSource')
begin
	DROP FULLTEXT INDEX ON DataSource
end
GO

IF EXISTS (SELECT 1 FROM sys.fulltext_catalogs WHERE [name] = 'ftCatalog')
	DROP FULLTEXT CATALOG ftCatalog;

CREATE FULLTEXT CATALOG ftCatalog
WITH ACCENT_SENSITIVITY = OFF
GO

CREATE FULLTEXT INDEX ON [dbo].[DataSource] (
	SourceName Language 1033 
	,SourceImage TYPE COLUMN SourceTypeCode Language 1033 
	,Description Language 1033 
	,KeyWords Language 1033 
	,Notes Language 1033 
	,OcrText Language 1033 
) 
KEY INDEX PK_DataSource
	ON ftCatalog
	WITH CHANGE_TRACKING AUTO
GO
/**************************************************
2
**************************************************/
if exists (SELECT 1 as TableName FROM sys.fulltext_indexes 
where OBJECT_NAME(object_id) = 'Email')
begin
	DROP FULLTEXT INDEX ON Email
end
GO

IF EXISTS (SELECT 1 FROM sys.fulltext_catalogs WHERE [name] = 'ftEmail')
	DROP FULLTEXT CATALOG ftEmail;


CREATE FULLTEXT CATALOG ftEmail
WITH ACCENT_SENSITIVITY = OFF
GO

CREATE FULLTEXT INDEX ON [dbo].[Email] (
	SUBJECT Language 1033 
	,Body Language 1033 
	,EmailImage TYPE COLUMN SourceTypeCode Language 1033 
	,ShortSubj Language 1033 
	,Description Language 1033 
	,KeyWords Language 1033 
	,notes Language 1033 
) 
KEY INDEX PK__Email__24383F235DE40451
	ON ftEmail
	WITH CHANGE_TRACKING AUTO
GO

/**************************************************
3
**************************************************/

if exists (SELECT 1 as TableName FROM sys.fulltext_indexes 
where OBJECT_NAME(object_id) = 'EmailAttachment')
begin
	DROP FULLTEXT INDEX ON EmailAttachment
end
GO

IF EXISTS (SELECT 1 FROM sys.fulltext_catalogs WHERE [name] = 'ftEmailAttachment')
	DROP FULLTEXT CATALOG ftEmailAttachment;
	
CREATE FULLTEXT CATALOG ftEmailAttachment
WITH ACCENT_SENSITIVITY = OFF
GO

CREATE FULLTEXT INDEX ON [dbo].[EmailAttachment] (
	Attachment TYPE COLUMN [AttachmentType] Language 1033 
	,AttachmentName Language 1033 
	,OcrText Language 1033 
) 
KEY INDEX PK__EmailAtt__B975DD8289908A26
	ON ftEmailAttachment
	WITH CHANGE_TRACKING AUTO
GO

if not exists (select 1 from sys.tables where name = 'DataSourceImage')
begin
	CREATE TABLE [dbo].[DataSourceImage](
		[RowGuid] [uniqueidentifier] NOT NULL,
		[SourceTypeCode] [nvarchar](50) NOT NULL,
		[OriginalFileType] [nvarchar](50) NOT NULL,
		[Description] [nvarchar](max) NULL,
		[KeyWords] [nvarchar](2000) NULL,
		[Notes] [nvarchar](2000) NULL,
		[OcrText] [nvarchar](max) NULL,
		[OcrPerformed] [nchar](1) NULL,
		[SourceImage] [varbinary](max) NULL,
		[SourceName] [nvarchar](254) NULL,
		[Imagehash] [nvarchar](80) NULL,
		[ImageLen] [int] NULL,
		[FileLength] [int] NULL,
		[LastUpdate] [datetime] NULL,
		[CRC] [nvarchar](50) NULL,
	 CONSTRAINT [PKey_DataSourceImage] PRIMARY KEY NONCLUSTERED 
	(
		[RowGuid] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

	ALTER TABLE [dbo].[DataSourceImage] ADD  DEFAULT (newid()) FOR [RowGuid]
	ALTER TABLE [dbo].[DataSourceImage] ADD  DEFAULT (getdate()) FOR [LastUpdate]

end

GO

-- DROP INDEX [PI_DataSourceHash] ON [dbo].[DataSourceImage]
if not exists (select 1 from sys.indexes where name = 'PI_DataSourceHash')
begin
	CREATE UNIQUE NONCLUSTERED INDEX [PI_DataSourceHash] ON [dbo].[DataSourceImage]
	(
		[Imagehash] ASC
	)
end
GO

if not exists (select 1 from sys.indexes where name = 'PI_DataSourceHash')
begin
	ALTER TABLE [dbo].[DataSourceImage] ADD  CONSTRAINT [PKey_DataSourceImage] PRIMARY KEY NONCLUSTERED 
	(
		[RowGuid] ASC
	)
end
GO
	
--*****************************************
if NOT exists (select 1 from sys.tables where name = 'DataSourceImage')
begin
	if not exists (select 1 from sys.fulltext_catalogs where name = 'ftDataSourceImage')
		CREATE FULLTEXT CATALOG ftDataSourceImage AS DEFAULT; 
	--select OBJECT_NAME(object_id) from sys.fulltext_indexes where OBJECT_NAME(object_id) = 'DataSourceImage'
	if NOT exists (select 1 from sys.fulltext_indexes where OBJECT_NAME(object_id) = 'DataSourceImage')
	begin
		CREATE FULLTEXT INDEX ON [dbo].DataSourceImage (
			SourceName Language 1033 
			,SourceImage TYPE COLUMN SourceTypeCode Language 1033 
			,[Description] Language 1033 
			,KeyWords Language 1033 
			,Notes Language 1033 
			,OcrText Language 1033 
		) 
		KEY INDEX PKey_DataSourceImage
			ON ftDataSource
			WITH CHANGE_TRACKING AUTO
	end
end