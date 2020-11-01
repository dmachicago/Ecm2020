USE [ECM.Library.FS]
GO
DBCC TRACEON (661)
go
with db_file_cte as
(
    select
        name,
        type_desc,
        physical_name,
        size_mb = 
            convert(decimal(11, 2), size * 8.0 / 1024),
        space_used_mb = 
            convert(decimal(11, 2), fileproperty(name, 'spaceused') * 8.0 / 1024)
    from sys.database_files
)
select
    name,
    type_desc,
    physical_name,
    size_mb,
    space_used_mb,
    space_used_percent = 
        case size_mb
            when 0 then 0
            else convert(decimal(5, 2), space_used_mb / size_mb * 100)
        end
from db_file_cte;
go

DISABLE TRIGGER [trgDataSourceDelete] ON DataSource;
DISABLE TRIGGER [trigSetDataSourceOcr] ON DataSource;

DROP TABLE IF EXISTS DataSource_Temp
DROP TABLE IF EXISTS TEMP_IMAGE
DROP TABLE IF EXISTS TEMP_JACK
go

select ImageHash 
into TEMP_JACK
from DataSource 
where FQN like '%jack%'

CREATE INDEX PI_TEMP_IMAGE ON TEMP_JACK(IMAGEHASH)
EXEC sp_PrintImmediate 'TEMP_JACK Index Created';
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

--**** Populate TEMP_IMAGE ****
GO
EXEC sp_PrintImmediate 'Temp tables dropped and Recreated';
--CREATE TABLE TEMP_IMAGE(IMAGEHASH NVARCHAR(100),row_num INT)
GO

WITH cte
     AS (SELECT ImageHash, ROW_NUMBER() OVER(PARTITION BY ImageHash
         ORDER BY ImageHash) AS row_num
         FROM dbo.DataSource)
    select ImageHash, Row_Num
into TEMP_IMAGE
FROM cte
     --WHERE row_num = 1;
EXEC sp_PrintImmediate 'TEMP_IMAGE Created';

-- select * from TEMP_IMAGE
alter table TEMP_IMAGE add SourceGuid nvarchar(50)

CREATE INDEX PI_TEMP_IMAGE ON TEMP_IMAGE(IMAGEHASH)
EXEC sp_PrintImmediate 'TEMP_IMAGE Index PI_TEMP_IMAGE Created';
CREATE INDEX PI_TEMP_SourceGuid ON TEMP_IMAGE(SourceGuid)
EXEC sp_PrintImmediate 'TEMP_IMAGE Index PI_TEMP_SourceGuid Created';

delete from TEMP_IMAGE
where ImageHash in (Select ImageHash from TEMP_JACK)

-- Select * from TEMP_IMAGE where SourceGuid = '212d4ee4-8c65-4402-8a7d-7123b7faf6d4'
update TEMP_IMAGE 
set SourceGuid = DS.SourceGuid
from DataSource DS
inner join TEMP_IMAGE T
	on DS.ImageHash = T.ImageHash;

delete from TEMP_IMAGE where Row_Num > 1 ;

-- *** NOT NEEDED AS THEY WILL BE DELETED WHEN TRUNCATED
--INSERT INTO TEMP_IMAGE SELECT Imagehash, 100 FROM DataSource WHERE FQN LIKE '%jack.haskell%';
--GO
--EXEC sp_PrintImmediate 'Jack Haskell documents added';
GO


--***************************************************************
EXEC sp_PrintImmediate 'Copying data to keep into DataSource_TEMP tabe';
--set IDENTITY_INSERT dbo.DataSource_Temp ON;
insert into DataSource_Temp
SELECT [RowGuid]
      ,DS.[SourceGuid]
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
INNER JOIN TEMP_IMAGE T 
	ON  DS.SourceGuid = T.SourceGuid ;
go
EXEC sp_PrintImmediate 'DataSource_TEMP data copied';
EXEC sp_PrintImmediate '-------------------------------------';
EXEC sp_PrintImmediate 'Truncating DataSource';
--************* CAREFUL ************
truncate table datasource ;
go

--EXEC sp_helpfile
DBCC SHRINKFILE ([ECM.Library.FS])
DBCC SHRINKFILE ([ECM.Library.FS_log])

go
EXEC sp_PrintImmediate 'DataSource Truncated';

declare @iCnt integer = 0 ;
declare @msg nvarchar(200) = '';

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
EXEC sp_PrintImmediate 'DataSource rows have been re-inserted and all duplicates removed';

--**********************************************************************
EXEC sp_PrintImmediate '*** Cleaning CLC_Download'
DELETE FROM CLC_Download where ContentGuid IN(SELECT SourceGuid FROM DataSource) ; 
go
EXEC sp_PrintImmediate '*** Cleaning CLC_Preview'
DELETE FROM CLC_Preview where ContentGuid IN(SELECT SourceGuid FROM DataSource) ; 
go
EXEC sp_PrintImmediate '*** Cleaning ContentUser'
DELETE FROM ContentUser where ContentGuid IN(SELECT SourceGuid FROM DataSource) ; 
go
EXEC sp_PrintImmediate '*** Cleaning DataOwners'
DELETE FROM DataOwners where SourceGuid IN(SELECT SourceGuid FROM DataSource) ; 
go
EXEC sp_PrintImmediate '*** Cleaning DataSourceCheckOut'
DELETE FROM DataSourceCheckOut where SourceGuid IN(SELECT SourceGuid FROM DataSource) ; 
go
EXEC sp_PrintImmediate '*** Cleaning DataSourceOwner'
DELETE FROM DataSourceOwner where SourceGuid IN(SELECT SourceGuid FROM DataSource) ; 
go
EXEC sp_PrintImmediate '*** Cleaning DataSourceRestoreHistory'
DELETE FROM DataSourceRestoreHistory where SourceGuid IN(SELECT SourceGuid FROM DataSource) ; 
go
EXEC sp_PrintImmediate '*** Cleaning FileKey'
DELETE FROM FileKey where SourceGuid IN(SELECT SourceGuid FROM DataSource) ; 
go
EXEC sp_PrintImmediate '*** Cleaning GlobalSeachResults'
DELETE FROM GlobalSeachResults where ContentGuid IN(SELECT SourceGuid FROM DataSource) ; 
go
EXEC sp_PrintImmediate '*** Cleaning LibraryItems'
DELETE FROM LibraryItems where SourceGuid IN(SELECT SourceGuid FROM DataSource) ; 
go
EXEC sp_PrintImmediate '*** Cleaning Machine'
DELETE FROM Machine where SourceGuid IN(SELECT SourceGuid FROM DataSource) ; 
go
EXEC sp_PrintImmediate '*** Cleaning QuickRefItems'
DELETE FROM QuickRefItems where SourceGuid IN(SELECT SourceGuid FROM DataSource) ; 
go
EXEC sp_PrintImmediate '*** Cleaning RestorationHistory'
DELETE FROM RestorationHistory where SourceGuid IN(SELECT SourceGuid FROM DataSource) ; 
go
EXEC sp_PrintImmediate '*** Cleaning RestoreQueue'
DELETE FROM RestoreQueue where ContentGuid IN(SELECT SourceGuid FROM DataSource) ; 
go
EXEC sp_PrintImmediate '*** Cleaning RestoreQueueHistory'
DELETE FROM RestoreQueueHistory where ContentGuid IN(SELECT SourceGuid FROM DataSource) ; 
go
EXEC sp_PrintImmediate '*** Cleaning RetentionTemp'
DELETE FROM RetentionTemp where ContentGuid IN(SELECT SourceGuid FROM DataSource) ; 
go
EXEC sp_PrintImmediate '*** Cleaning RSSChildren'
DELETE FROM RSSChildren where SourceGuid IN(SELECT SourceGuid FROM DataSource) ; 
go
EXEC sp_PrintImmediate '*** Cleaning SearchGuids'
DELETE FROM SearchGuids where SourceGuid IN(SELECT SourceGuid FROM DataSource) ; 
go
EXEC sp_PrintImmediate '*** Cleaning SourceAttribute'
DELETE FROM SourceAttribute where SourceGuid IN(SELECT SourceGuid FROM DataSource) ; 
go
EXEC sp_PrintImmediate '*** Cleaning StructuredData'
DELETE FROM StructuredData where SourceGuid IN(SELECT SourceGuid FROM DataSource) ; 
go
EXEC sp_PrintImmediate '*** Cleaning TempUserLibItems'
DELETE FROM TempUserLibItems where SourceGuid IN(SELECT SourceGuid FROM DataSource) ; 
go
EXEC sp_PrintImmediate '*** Cleaning WebSource'
DELETE FROM WebSource where SourceGuid IN(SELECT SourceGuid FROM DataSource) ; 
go
EXEC sp_PrintImmediate '*** Cleaning ZippedFiles'
DELETE FROM ZippedFiles where ContentGUID IN(SELECT SourceGuid FROM DataSource) ; 
go
--**********************************************************************
CHECKPOINT;

ENABLE TRIGGER [trgDataSourceDelete] ON DataSource;
ENABLE TRIGGER [trigSetDataSourceOcr] ON DataSource;

DROP TABLE IF EXISTS TEMP_IMAGE
DROP TABLE IF EXISTS TEMP_JACK

DBCC TRACEOFF (661)

EXEC sp_PrintImmediate '*******************************'
EXEC sp_PrintImmediate '** RUN COMPLETE'
EXEC sp_PrintImmediate '*******************************'
