USE [ECM.Library.FS];
GO

/****** Object:  Table [dbo].[DataSourceImage]    Script Date: 6/30/2020 1:20:13 PM ******/

IF EXISTS
(
    SELECT 1
        FROM sys.tables
        WHERE name = 'DataSourceAsso'
)
	drop table DataSourceAsso;

CREATE TABLE [dbo].[DataSourceAsso]
	([DataSourceImageGuid] [UNIQUEIDENTIFIER] NOT NULL, 
	[DataSourceGuid]      [UNIQUEIDENTIFIER] NOT NULL,
	ImageHash nvarchar(80) not null
	);
CREATE UNIQUE CLUSTERED INDEX PKey_DataSourceAsso
ON DataSourceAsso
	(DataSourceImageGuid, DataSourceGuid
	);
CREATE INDEX PKey_DataSourceAssoHash
ON DataSourceAsso
	(ImageHash
	);

SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO
IF EXISTS
(
    SELECT 1
        FROM sys.tables
        WHERE name = 'DataSourceImage'
)
    BEGIN
        DROP TABLE DataSourceImage;
END;
GO
CREATE TABLE [dbo].[DataSourceImage]
   ([RowGuid]        [UNIQUEIDENTIFIER] NOT NULL
                                        DEFAULT NEWID(), 
    --[DataSourceGuid] [UNIQUEIDENTIFIER] NOT NULL, 
    [SourceTypeCode] [NVARCHAR](50) NOT NULL, 
    OriginalFileType [NVARCHAR](50) NOT NULL, 
    [Description]    [NVARCHAR](MAX) NULL, 
    [KeyWords]       [NVARCHAR](2000) NULL, 
    [Notes]          [NVARCHAR](2000) NULL, 
    [OcrText]        [NVARCHAR](MAX) NULL, 
    [OcrPerformed]   [NCHAR](1) NULL, 
    [SourceImage]    [VARBINARY](MAX) NULL, 
    [SourceName]     [NVARCHAR](254) NULL, 
    [Imagehash]      [NVARCHAR](80) NULL, 
    [ImageLen]       [INT] NULL, 
    [FileLength]     [INT] NULL, 
    [LastUpdate]     [DATETIME] DEFAULT GETDATE(), 
    [CRC]            [NVARCHAR](50) NULL
                                    --[RowID]          [INT] IDENTITY(1, 1) NOT NULL
                                    CONSTRAINT [PKey_DataSourceImage] PRIMARY KEY NONCLUSTERED ([RowGuid] ASC)
   );
CREATE UNIQUE INDEX PI_DataSourceHash
ON [DataSourceImage]
   ([Imagehash]
   );
--CREATE INDEX PI_DataSourceGuid
--ON [DataSourceImage]
--   ([DataSourceGuid]
--   );
GO
IF EXISTS
(
    SELECT 1
        FROM sys.fulltext_catalogs
        WHERE [name] = 'ftDataSourceImage'
)
    BEGIN
        PRINT 'Catalog ftDataSourceImage exists';
END;
    ELSE
    BEGIN
        CREATE FULLTEXT CATALOG [ftDataSourceImage] WITH ACCENT_SENSITIVITY = OFF;
END;
IF NOT EXISTS(SELECT 1
FROM sys.fulltext_indexes
WHERE object_id = OBJECT_ID('DataSourceImage'))
BEGIN
CREATE FULLTEXT INDEX ON [dbo].[DataSourceImage]([Description] LANGUAGE 'English', [KeyWords] LANGUAGE 'English', [Notes] LANGUAGE 'English', [OcrText] LANGUAGE 'English', [SourceImage] TYPE COLUMN [SourceTypeCode] LANGUAGE 'English', [SourceName] LANGUAGE 'English') KEY INDEX [PKey_DataSourceImage] ON([ftDataSourceImage], FILEGROUP [PRIMARY]) WITH(CHANGE_TRACKING=AUTO, STOPLIST=SYSTEM);
END;
GO
TRUNCATE TABLE [DataSourceImage];
GO
DROP TABLE #UniqueHash;
SELECT DISTINCT 
       Imagehash
INTO #UniqueHash
    FROM DataSource;
CREATE INDEX PI_UniqueHash
ON #UniqueHash
   (Imagehash
   );
GO
DECLARE @msg NVARCHAR(500) = '';
DECLARE @I INT = 0;
DECLARE @hash NVARCHAR(100);
DECLARE @guid UNIQUEIDENTIFIER;
DECLARE C CURSOR
FOR SELECT DISTINCT 
           Imagehash
        FROM DataSource;
OPEN C;
SET NOCOUNT ON;
FETCH NEXT FROM C INTO @hash;
WHILE @@FETCH_STATUS = 0
    BEGIN
        SET @I = @I + 1;
        IF
           (@I % 100 = 0
           )
            BEGIN
                SET @msg = 'Processing row #' + CONVERT(NVARCHAR(20), @I);
                EXEC sp_PrintImmediate @msg;
        END;
        INSERT INTO [dbo].[DataSourceImage]
               SELECT TOP 1 NEWID(), 
                            [SourceTypeCode], 
                            [OriginalFileType], 
                            [Description], 
                            [KeyWords], 
                            [Notes], 
                            [OcrText], 
                            [OcrPerformed], 
                            [SourceImage], 
                            [SourceName], 
                            [Imagehash], 
                            [ImageLen], 
                            [FileLength], 
                            GETDATE(), 
                            [CRC]
                   FROM DataSource
                   WHERE Imagehash = @hash;
        FETCH NEXT FROM C INTO @hash;
    END;
CLOSE C;
DEALLOCATE C;

UPDATE [DataSourceImage]
  SET 
      Imagehash = HASHBYTES('SHA2_512', SourceImage), 
      ImageLen = DATALENGTH(SourceImage) + 1;

SET NOCOUNT OFF;

go

SELECT RowGuid
    FROM [DataSourceImage]
    WHERE CONTAINS(*, 'Channels');
USE [ECM.Library.FS];
GO

TRUNCATE TABLE DataSourceAsso;
GO


DECLARE @msg NVARCHAR(500) = '';
DECLARE @I INT = 0;
DECLARE @hash NVARCHAR(100);
DECLARE @SourceGuid UNIQUEIDENTIFIER;
DECLARE @RowGuid UNIQUEIDENTIFIER;

DECLARE C CURSOR
	FOR select DS.SourceGuid , DSI.RowGuid, DSI.Imagehash
		from DataSource DS
		join DataSourceImage DSI on DSI.Imagehash = DS.Imagehash;

OPEN C;
SET NOCOUNT ON;
FETCH NEXT FROM C INTO @SourceGuid, @RowGuid, @hash;
WHILE @@FETCH_STATUS = 0
    BEGIN
        SET @I = @I + 1;
        IF
           (@I % 100 = 0
           )
            BEGIN
                SET @msg = 'Processing row #' + CONVERT(NVARCHAR(20), @I);
                EXEC sp_PrintImmediate @msg;
        END;

		INSERT INTO DataSourceAsso ([DataSourceImageGuid], [DataSourceGuid], [ImageHash]) values (@RowGuid, @SourceGuid, @hash);

        FETCH NEXT FROM C INTO @SourceGuid, @RowGuid, @hash;
    END;
CLOSE C;
DEALLOCATE C;

SET @msg = 'Total rows processed #' + CONVERT(NVARCHAR(20), @I);
EXEC sp_PrintImmediate @msg;

GO
SELECT DS.[RowGuid], 
       [SourceGuid], 
       [CreateDate], 
       DSI.[SourceName], 
       --DSI.[SourceImage], 
       DSI.[SourceTypeCode], 
       [FQN], 
       [VersionNbr], 
       [LastAccessDate], 
       DSI.[FileLength], 
       [LastWriteTime], 
       [UserID], 
       [DataSourceOwnerUserID], 
       [isPublic], 
       [FileDirectory], 
       DS.[OriginalFileType], 
       [RetentionExpirationDate], 
       [IsPublicPreviousState], 
       [isAvailable], 
       [isContainedWithinZipFile], 
       [IsZipFile], 
       [DataVerified], 
       [ZipFileGuid], 
       [ZipFileFQN], 
       DSI.[Description], 
       DSI.[KeyWords], 
       DSI.[Notes], 
       [isPerm], 
       [isMaster], 
       [CreationDate], 
       DSI.[OcrPerformed], 
       [isGraphic], 
       [GraphicContainsText], 
       DSI.[OcrText], 
       [ImageHiddenText], 
       [isWebPage], 
       [ParentGuid], 
       [RetentionCode], 
       [MachineID], 
       [SharePoint], 
       [SharePointDoc], 
       [SharePointList], 
       [SharePointListItem], 
       [StructuredData], 
       [HiveConnectionName], 
       [HiveActive], 
       [RepoSvrName], 
       [RowCreationDate], 
       [RowLastModDate], 
       [ContainedWithin], 
       [RecLen], 
       [RecHash], 
       [OriginalSize], 
       [CompressedSize], 
       [txStartTime], 
       [txEndTime], 
       [txTotalTime], 
       [TransmitTime], 
       [FileAttached], 
       [BPS], 
       [RepoName], 
       [HashFile], 
       [HashName], 
       [OcrSuccessful], 
       [OcrPending], 
       [PdfIsSearchable], 
       [PdfOcrRequired], 
       [PdfOcrSuccess], 
       [PdfOcrTextExtracted], 
       [PdfPages], 
       [PdfImages], 
       [RequireOcr], 
       [RssLinkFlg], 
       [RssLinkGuid], 
       [PageURL], 
       [RetentionDate], 
       [URLHash], 
       [WebPagePublishDate], 
       [SapData], 
       DS.[RowID],
       --,DSI.[Imagehash] 
       DSI.[ImageLen], 
       CONVERT(VARBINARY, DSI.[Imagehash]) AS Imagehash
    FROM [dbo].[DataSource] AS DS
			JOIN DataSourceAsso AS DA
				ON DA.DataSourceGuid = DS.SourceGuid
			JOIN [dbo].[DataSourceImage] AS DSI
				ON DSI.RowGuid = DA.
    WHERE CONTAINS(DSI.*, 'readme')
    ORDER BY DSI.SourceName, 
             DSI.ImageHash;
GO


SELECT COUNT(*)
    FROM DataSource
    WHERE CONTAINS(*, 'bgcolor');
SELECT COUNT(*)
    FROM DataSourceImage
    WHERE CONTAINS(*, 'bgcolor');

--update DataSourceImage set SourceTypeCode='.txt' where DataSourceGuid in (select SourceGuid from DataSOurce where contains (*,'bgcolor'))

UPDATE DataSource
  SET 
      SourceTypeCode = '.txt'
    WHERE OriginalFileType = '.html';

UPDATE DataSource
  SET 
      SourceTypeCode = '.txt'
    WHERE OriginalFileType = '.htm';

SELECT CONVERT(VARBINARY, [Imagehash]) AS Imagehash, 
       COUNT(*)
    FROM DataSourceAsso
    GROUP BY Imagehash
    HAVING COUNT(*) > 1;

SELECT DataSourceGuid
    FROM DataSourceAsso;
GO
SELECT DSI.[RowGuid], 
       DSI.[SourceTypeCode], 
       DSI.[Description], 
       DSI.[KeyWords], 
       DSI.[Notes], 
       DSI.[OcrText], 
       DSI.[OcrPerformed], 
       DSI.[SourceImage], 
       DSI.[SourceName], 
       DSI.[Imagehash], 
       DSI.[ImageLen], 
       DSI.[FileLength], 
       DSI.[LastUpdate], 
       DSI.[CRC], 
       DSI.[RowID]
    FROM [dbo].[DataSourceImage] AS DSI;
GO