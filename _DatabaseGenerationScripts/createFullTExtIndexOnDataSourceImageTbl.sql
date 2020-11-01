
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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