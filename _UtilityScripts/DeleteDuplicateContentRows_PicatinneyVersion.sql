USE [ECM.Library.FS]
GO

DROP TABLE IF EXISTS DataSource_Temp
DROP TABLE IF EXISTS #TEMP_IMAGE
go

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].DataSource_Temp(
	[RowGuid] [uniqueidentifier] NOT NULL,
	[SourceGuid] [nvarchar](50) NOT NULL,
	[CreateDate] [datetime] NULL,
	[SourceName] [nvarchar](254) NULL,
	[SourceImage] [varbinary](max) NULL,
	[SourceTypeCode] [nvarchar](50) NOT NULL,
	[FQN] [varchar](712) NULL,
	[VersionNbr] [int] NOT NULL,
	[LastAccessDate] [datetime] NULL,
	[FileLength] [int] NULL,
	[LastWriteTime] [datetime] NULL,
	[UserID] [nvarchar](50) NULL,
	[DataSourceOwnerUserID] [nvarchar](50) NOT NULL,
	[isPublic] [nchar](1) NULL,
	[FileDirectory] [nvarchar](300) NULL,
	[OriginalFileType] [nvarchar](50) NULL,
	[RetentionExpirationDate] [datetime] NULL,
	[IsPublicPreviousState] [nchar](1) NULL,
	[isAvailable] [nchar](1) NULL,
	[isContainedWithinZipFile] [nchar](1) NULL,
	[IsZipFile] [nchar](1) NULL,
	[DataVerified] [bit] NULL,
	[ZipFileGuid] [nvarchar](50) NULL,
	[ZipFileFQN] [varchar](712) NULL,
	[Description] [nvarchar](max) NULL,
	[KeyWords] [nvarchar](2000) NULL,
	[Notes] [nvarchar](2000) NULL,
	[isPerm] [nchar](1) NULL,
	[isMaster] [nchar](1) NULL,
	[CreationDate] [datetime] NULL,
	[OcrPerformed] [nchar](1) NULL,
	[isGraphic] [nchar](1) NULL,
	[GraphicContainsText] [nchar](1) NULL,
	[OcrText] [nvarchar](max) NULL,
	[ImageHiddenText] [nvarchar](max) NULL,
	[isWebPage] [nchar](1) NULL,
	[ParentGuid] [nvarchar](50) NULL,
	[RetentionCode] [nvarchar](50) NULL,
	[MachineID] [nvarchar](80) NULL,
	[CRC] [nvarchar](250) NOT NULL,
	[SharePoint] [bit] NULL,
	[SharePointDoc] [bit] NULL,
	[SharePointList] [bit] NULL,
	[SharePointListItem] [bit] NULL,
	[StructuredData] [bit] NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[ContainedWithin] [nvarchar](50) NULL,
	[RecLen] [float] NULL,
	[RecHash] [varchar](50) NULL,
	[OriginalSize] [int] NULL,
	[CompressedSize] [int] NULL,
	[txStartTime] [datetime] NULL,
	[txEndTime] [datetime] NULL,
	[txTotalTime] [float] NULL,
	[TransmitTime] [float] NULL,
	[FileAttached] [bit] NULL,
	[BPS] [float] NULL,
	[RepoName] [nvarchar](50) NULL,
	[HashFile] [nvarchar](50) NULL,
	[HashName] [nvarchar](50) NULL,
	[OcrSuccessful] [char](1) NULL,
	[OcrPending] [char](1) NULL,
	[PdfIsSearchable] [char](1) NULL,
	[PdfOcrRequired] [char](1) NULL,
	[PdfOcrSuccess] [char](1) NULL,
	[PdfOcrTextExtracted] [char](1) NULL,
	[PdfPages] [int] NULL,
	[PdfImages] [int] NULL,
	[RequireOcr] [bit] NULL,
	[RssLinkFlg] [bit] NULL,
	[RssLinkGuid] [nvarchar](50) NULL,
	[PageURL] [nvarchar](4000) NULL,
	[RetentionDate] [datetime] NULL,
	[URLHash] [nvarchar](50) NULL,
	[WebPagePublishDate] [nvarchar](50) NULL,
	[SapData] [bit] NULL,
	--[RowID] [int] IDENTITY(1,1) NOT NULL,
	[RowID] [int] NOT NULL,
	[Imagehash] [nvarchar](250) NOT NULL,
	[ImageLen] [int] NULL,
	[FileDirectoryName] [nvarchar](500) NULL,
 CONSTRAINT [PK_DataSource_TEMP] PRIMARY KEY NONCLUSTERED 
(
	[RowGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) 
GO

--**** Populate #TEMP_IMAGE ****
GO
EXEC sp_PrintImmediate 'Temp tables dropped and Recreated';
--CREATE TABLE #TEMP_IMAGE(IMAGEHASH NVARCHAR(100),row_num INT)
GO

WITH cte
     AS (SELECT ImageHash, ROW_NUMBER() OVER(PARTITION BY ImageHash
         ORDER BY ImageHash) AS row_num
         FROM dbo.DataSource)
    select ImageHash, Row_Num
into #TEMP_IMAGE
FROM cte
     WHERE row_num = 1;
EXEC sp_PrintImmediate '#TEMP_IMAGE Created';

CREATE INDEX PI_TEMP_IMAGE ON #TEMP_IMAGE(IMAGEHASH,row_num)
EXEC sp_PrintImmediate '#TEMP_IMAGE Index Created';

-- *** NOT NEEDED AS THEY WILL BE DELETED WHEN TRUNCATED
--INSERT INTO #TEMP_IMAGE SELECT Imagehash, 100 FROM DataSource WHERE FQN LIKE '%jack.haskell%';
--GO
--EXEC sp_PrintImmediate 'Jack Haskell documents added';
GO


--***************************************************************
EXEC sp_PrintImmediate 'Copying data to keep into DataSource_TEMP tabe';
--set IDENTITY_INSERT dbo.DataSource_Temp ON;
insert into DataSource_Temp
SELECT [RowGuid]
      ,[SourceGuid]
      ,[CreateDate]
      ,[SourceName]
      ,[SourceImage]
      ,[SourceTypeCode]
      ,[FQN]
      ,[VersionNbr]
      ,[LastAccessDate]
      ,[FileLength]
      ,[LastWriteTime]
      ,[UserID]
      ,[DataSourceOwnerUserID]
      ,[isPublic]
      ,[FileDirectory]
      ,[OriginalFileType]
      ,[RetentionExpirationDate]
      ,[IsPublicPreviousState]
      ,[isAvailable]
      ,[isContainedWithinZipFile]
      ,[IsZipFile]
      ,[DataVerified]
      ,[ZipFileGuid]
      ,[ZipFileFQN]
      ,[Description]
      ,[KeyWords]
      ,[Notes]
      ,[isPerm]
      ,[isMaster]
      ,[CreationDate]
      ,[OcrPerformed]
      ,[isGraphic]
      ,[GraphicContainsText]
      ,[OcrText]
      ,[ImageHiddenText]
      ,[isWebPage]
      ,[ParentGuid]
      ,[RetentionCode]
      ,[MachineID]
      ,[CRC]
      ,[SharePoint]
      ,[SharePointDoc]
      ,[SharePointList]
      ,[SharePointListItem]
      ,[StructuredData]
      ,[HiveConnectionName]
      ,[HiveActive]
      ,[RepoSvrName]
      ,[RowCreationDate]
      ,[RowLastModDate]
      ,[ContainedWithin]
      ,[RecLen]
      ,[RecHash]
      ,[OriginalSize]
      ,[CompressedSize]
      ,[txStartTime]
      ,[txEndTime]
      ,[txTotalTime]
      ,[TransmitTime]
      ,[FileAttached]
      ,[BPS]
      ,[RepoName]
      ,[HashFile]
      ,[HashName]
      ,[OcrSuccessful]
      ,[OcrPending]
      ,[PdfIsSearchable]
      ,[PdfOcrRequired]
      ,[PdfOcrSuccess]
      ,[PdfOcrTextExtracted]
      ,[PdfPages]
      ,[PdfImages]
      ,[RequireOcr]
      ,[RssLinkFlg]
      ,[RssLinkGuid]
      ,[PageURL]
      ,[RetentionDate]
      ,[URLHash]
      ,[WebPagePublishDate]
      ,[SapData]
      ,[RowID]
      ,DS.[Imagehash]
      ,[ImageLen]
      ,[FileDirectoryName] 
	  FROM DataSource DS 
INNER JOIN #TEMP_IMAGE T ON  DS.ImageHash = T.ImageHash ;
go
EXEC sp_PrintImmediate 'DataSource_TEMP data copied';
EXEC sp_PrintImmediate 'Truncating DataSource';
--************* CAREFUL ************
truncate table datasource ;
go

declare @iCnt integer = 0 ;
declare @msg nvarchar(200) = '';
EXEC sp_PrintImmediate 'DataSource Truncated';

set @iCnt = (select count(*) from DataSource_TEMP);
set @msg = 'Copying ' + cast(@iCnt as nvarchar(20)) + ' records back into DataSource, standby...';
EXEC sp_PrintImmediate @msg;

set IDENTITY_INSERT DataSource ON;
insert into DataSource ([RowGuid]
      ,[SourceGuid]
      ,[CreateDate]
      ,[SourceName]
      ,[SourceImage]
      ,[SourceTypeCode]
      ,[FQN]
      ,[VersionNbr]
      ,[LastAccessDate]
      ,[FileLength]
      ,[LastWriteTime]
      ,[UserID]
      ,[DataSourceOwnerUserID]
      ,[isPublic]
      ,[FileDirectory]
      ,[OriginalFileType]
      ,[RetentionExpirationDate]
      ,[IsPublicPreviousState]
      ,[isAvailable]
      ,[isContainedWithinZipFile]
      ,[IsZipFile]
      ,[DataVerified]
      ,[ZipFileGuid]
      ,[ZipFileFQN]
      ,[Description]
      ,[KeyWords]
      ,[Notes]
      ,[isPerm]
      ,[isMaster]
      ,[CreationDate]
      ,[OcrPerformed]
      ,[isGraphic]
      ,[GraphicContainsText]
      ,[OcrText]
      ,[ImageHiddenText]
      ,[isWebPage]
      ,[ParentGuid]
      ,[RetentionCode]
      ,[MachineID]
      ,[CRC]
      ,[SharePoint]
      ,[SharePointDoc]
      ,[SharePointList]
      ,[SharePointListItem]
      ,[StructuredData]
      ,[HiveConnectionName]
      ,[HiveActive]
      ,[RepoSvrName]
      ,[RowCreationDate]
      ,[RowLastModDate]
      ,[ContainedWithin]
      ,[RecLen]
      ,[RecHash]
      ,[OriginalSize]
      ,[CompressedSize]
      ,[txStartTime]
      ,[txEndTime]
      ,[txTotalTime]
      ,[TransmitTime]
      ,[FileAttached]
      ,[BPS]
      ,[RepoName]
      ,[HashFile]
      ,[HashName]
      ,[OcrSuccessful]
      ,[OcrPending]
      ,[PdfIsSearchable]
      ,[PdfOcrRequired]
      ,[PdfOcrSuccess]
      ,[PdfOcrTextExtracted]
      ,[PdfPages]
      ,[PdfImages]
      ,[RequireOcr]
      ,[RssLinkFlg]
      ,[RssLinkGuid]
      ,[PageURL]
      ,[RetentionDate]
      ,[URLHash]
      ,[WebPagePublishDate]
      ,[SapData]
      ,[RowID]
      ,[Imagehash]
      ,[ImageLen]
      ,[FileDirectoryName] )
SELECT [RowGuid]
      ,[SourceGuid]
      ,[CreateDate]
      ,[SourceName]
      ,[SourceImage]
      ,[SourceTypeCode]
      ,[FQN]
      ,[VersionNbr]
      ,[LastAccessDate]
      ,[FileLength]
      ,[LastWriteTime]
      ,[UserID]
      ,[DataSourceOwnerUserID]
      ,[isPublic]
      ,[FileDirectory]
      ,[OriginalFileType]
      ,[RetentionExpirationDate]
      ,[IsPublicPreviousState]
      ,[isAvailable]
      ,[isContainedWithinZipFile]
      ,[IsZipFile]
      ,[DataVerified]
      ,[ZipFileGuid]
      ,[ZipFileFQN]
      ,[Description]
      ,[KeyWords]
      ,[Notes]
      ,[isPerm]
      ,[isMaster]
      ,[CreationDate]
      ,[OcrPerformed]
      ,[isGraphic]
      ,[GraphicContainsText]
      ,[OcrText]
      ,[ImageHiddenText]
      ,[isWebPage]
      ,[ParentGuid]
      ,[RetentionCode]
      ,[MachineID]
      ,[CRC]
      ,[SharePoint]
      ,[SharePointDoc]
      ,[SharePointList]
      ,[SharePointListItem]
      ,[StructuredData]
      ,[HiveConnectionName]
      ,[HiveActive]
      ,[RepoSvrName]
      ,[RowCreationDate]
      ,[RowLastModDate]
      ,[ContainedWithin]
      ,[RecLen]
      ,[RecHash]
      ,[OriginalSize]
      ,[CompressedSize]
      ,[txStartTime]
      ,[txEndTime]
      ,[txTotalTime]
      ,[TransmitTime]
      ,[FileAttached]
      ,[BPS]
      ,[RepoName]
      ,[HashFile]
      ,[HashName]
      ,[OcrSuccessful]
      ,[OcrPending]
      ,[PdfIsSearchable]
      ,[PdfOcrRequired]
      ,[PdfOcrSuccess]
      ,[PdfOcrTextExtracted]
      ,[PdfPages]
      ,[PdfImages]
      ,[RequireOcr]
      ,[RssLinkFlg]
      ,[RssLinkGuid]
      ,[PageURL]
      ,[RetentionDate]
      ,[URLHash]
      ,[WebPagePublishDate]
      ,[SapData]
      ,[RowID]
      ,[Imagehash]
      ,[ImageLen]
      ,[FileDirectoryName] 
FROM DataSource_Temp
set IDENTITY_INSERT DataSource OFF;
go

--**********************************************************************

SET NOCOUNT ON
set statistics time off

DECLARE @i AS INTEGER= 0;
DECLARE @RowsRemaining AS INTEGER= 0;
DECLARE @Rows AS INTEGER= 0;
DECLARE @msg NVARCHAR(500)= '';
--DECLARE @filter NVARCHAR(500)= 'C:\Users\jack.haskell%';
DECLARE @PCT DECIMAL(6,2);
DECLARE @t1 DATETIME;
DECLARE @t2 DATETIME;
DECLARE @T_DIFF AS INT = 0;
DECLARE @LOOPS_REMAIN AS INT = 0;
DECLARE @MINS AS DECIMAL(10,2) = 0;

PRINT GETDATE();

SET @RowsRemaining =
(
        SELECT COUNT (*)
        FROM #TEMP_IMAGE WHERE row_num > 1

);
SET @Rows = @RowsRemaining;
SET @t1 = GETDATE();
WHILE @RowsRemaining > 0
    BEGIN
        SET @i = @i + 1;
--              SET @msg = 'Process Count : ' + CAST(@i AS NVARCHAR(10));
--                EXEC sp_PrintImmediate @msg;

        IF(@i % 5 = 0)
            BEGIN
                                SET @t2 = GETDATE();
                                SET @T_DIFF = (SELECT DATEDIFF(millisecond,@t1,@t2) AS elapsed_ms);
                                SET @LOOPS_REMAIN = @RowsRemaining / (5 * 50);
                                SET @msg = '@LOOPS_REMAIN : ' + CAST(@LOOPS_REMAIN AS NVARCHAR(20));
                                EXEC sp_PrintImmediate @msg;
                                SET @MINS = CAST(@LOOPS_REMAIN AS FLOAT) * CAST(@T_DIFF AS FLOAT) / 50 /60 /60;
                                SET @msg = 'Hours Remaining : ' + CAST(@MINS AS NVARCHAR(20));
                                EXEC sp_PrintImmediate @msg;
                                PRINT GETDATE()
                                SET @msg = 'Deleted : ' + CAST((@Rows - @RowsRemaining) AS VARCHAR(20)) + ' :  Remaining : ' + CAST(@RowsRemaining AS VARCHAR(20));
                EXEC sp_PrintImmediate @msg;
                SET @PCT = CAST(@RowsRemaining AS FLOAT) / CAST(@Rows AS FLOAT) * 100;
                                SET @msg = 'Percent Remaining : ' + CAST(@PCT AS VARCHAR(20));
                EXEC sp_PrintImmediate @msg;
                                SET @t1 = GETDATE();
        END;
        BEGIN TRANSACTION;
                        DELETE FROM DataSource
                        WHERE Imagehash IN (SELECT TOP 50 Imagehash FROM #TEMP_IMAGE WHERE row_num > 1)
        COMMIT TRANSACTION;
                CHECKPOINT;
                DELETE FROM #TEMP_IMAGE WHERE IMAGEHASH IN (SELECT TOP 50 Imagehash FROM #TEMP_IMAGE WHERE row_num > 1);
                CHECKPOINT;
                SET @RowsRemaining = @RowsRemaining - 50;
    END;
PRINT 'Completed Total Deletions: ' + CAST(@i AS NVARCHAR(20));
--**************************************************************
--**************************************************************

SET @msg = 'Removing remaining duplicates';
EXEC sp_PrintImmediate @msg;
GO
set statistics time OFF
SET NOCOUNT OFF

SELECT COUNT (*)
FROM DATASOURCE
WHERE FQN LIKE '%jack.haskell%'