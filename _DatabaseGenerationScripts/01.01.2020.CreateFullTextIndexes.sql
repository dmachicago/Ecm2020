
go
USE [ECM.Library.FS];
GO
--**************************************************
-- Item #1
--**************************************************

/****** Object:  Index [PK_DataSource]    Script Date: 10/30/2019 11:06:06 AM ******/

IF EXISTS(SELECT 1
FROM sys.fulltext_indexes
WHERE object_id = OBJECT_ID('DataSourceImage'))
	drop FULLTEXT INDEX ON [dbo].[DataSourceImage];

IF NOT EXISTS(SELECT 1
FROM sys.fulltext_indexes
WHERE object_id = OBJECT_ID('DataSourceImage'))
BEGIN
CREATE FULLTEXT INDEX ON [dbo].[DataSourceImage]
	(
	[Description] LANGUAGE 'English', 
	[KeyWords] LANGUAGE 'English', 
	[Notes] LANGUAGE 'English', 
	[OcrText] LANGUAGE 'English', 
	[SourceImage] TYPE COLUMN [SourceTypeCode] LANGUAGE 'English', 
	[SourceName] LANGUAGE 'English'
	) KEY INDEX [PKey_DataSourceImage] ON([ftDataSourceImage], FILEGROUP [PRIMARY]) WITH(CHANGE_TRACKING=AUTO, STOPLIST=SYSTEM);
END;
GO

IF not EXISTS
( SELECT 1 FROM sys.indexes WHERE name = 'PK_DataSource')
BEGIN
	CREATE UNIQUE CLUSTERED INDEX [PK_DataSource] ON [dbo].[DataSource]
	([SourceGuid] ASC) 
	WITH(PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];
END

GO

IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE name = 'UI_DataSource_Rowid'
)
    BEGIN
        CREATE UNIQUE NONCLUSTERED INDEX [UI_DataSource_Rowid] ON [dbo].[DataSource]([RowID] ASC) WITH(PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];
END;
GO
IF NOT EXISTS(SELECT 1
FROM sys.fulltext_indexes
WHERE object_id = OBJECT_ID('DataSource'))
BEGIN
CREATE FULLTEXT INDEX ON [dbo].[DataSource]([Description] LANGUAGE 'English', [KeyWords] LANGUAGE 'English', [OcrText] LANGUAGE 'English', [SourceImage] TYPE COLUMN [SourceTypeCode] LANGUAGE 'English', [SourceName] LANGUAGE 'English') KEY INDEX [UI_DataSource_Rowid] ON([ftDataSource], FILEGROUP [PRIMARY]) WITH(CHANGE_TRACKING=AUTO, STOPLIST=SYSTEM);
END;
GO
IF NOT EXISTS(SELECT 1
FROM sys.fulltext_indexes
WHERE object_id = OBJECT_ID('Email'))
BEGIN
CREATE FULLTEXT INDEX ON [dbo].[Email]([Body] LANGUAGE 'English', [Description] LANGUAGE 'English', [EmailImage] TYPE COLUMN [SourceTypeCode] LANGUAGE 'English', [KeyWords] LANGUAGE 'English', [notes] LANGUAGE 'English', [ShortSubj] LANGUAGE 'English', [SUBJECT] LANGUAGE 'English') KEY INDEX [PK__Email__24383F235DE40451] ON([ftEmail], FILEGROUP [PRIMARY]) WITH(CHANGE_TRACKING=AUTO, STOPLIST=SYSTEM);
END;
GO

/****** Object:  FullTextIndex     Script Date: 10/30/2019 11:21:09 AM ******/

IF NOT EXISTS(SELECT 1
FROM sys.fulltext_indexes
WHERE object_id = OBJECT_ID('EmailAttachment'))
BEGIN
CREATE FULLTEXT INDEX ON [dbo].[EmailAttachment]([Attachment] TYPE COLUMN [AttachmentType] LANGUAGE 'English', [AttachmentName] LANGUAGE 'English', [OcrText] LANGUAGE 'English') KEY INDEX [PK__EmailAtt__B975DD8289908A26] ON([ftEmailAttachment], FILEGROUP [PRIMARY]) WITH(CHANGE_TRACKING=AUTO, STOPLIST=SYSTEM);
END;
GO

