IF NOT EXISTS ( SELECT  *
                FROM    sys.schemas
                WHERE   name = N'lsnr' )
    EXEC('CREATE SCHEMA [lsnr]');
GO

--select * from [lsnr].[DirListener] 
go
drop TABLE [lsnr].[DirListener] 
go
if not exists (select 1 from INFORMATION_SCHEMA.tables where table_schema = 'lsnr' and TABLE_NAME = 'DirListener')
CREATE TABLE [lsnr].[DirListener] (
  [RowID] integer primary key identity(1,1)
, [UserID] varchar(50) not null
, [ListenerFileName] varchar(800) NOT NULL
, [LastIdProcessed] integer null
, [LastProcessDate] datetime NULL
, FileCanBeDropped integer default 0
, [RowCreateDate] datetime default getdate()
)
go
--select * from [lsnr].[Exts]
drop table [lsnr].[Exts]
go
if not exists (select 1 from INFORMATION_SCHEMA.tables where table_schema = 'lsnr' and TABLE_NAME = 'Exts')
CREATE TABLE [lsnr].[Exts] (
    [UserID] varchar(50) not null,
	[Extension]	varchar(50),
	"Validated"	INTEGER
)
go
if not exists (select 1 from sys.indexes where name = 'PK_EXTS')
	CREATE UNIQUE INDEX PK_EXTS on [lsnr].[Exts] ([UserID], [Extension])

drop TABLE [lsnr].[FileNeedProcessing]
go
if not exists (select 1 from INFORMATION_SCHEMA.tables where table_schema = 'lsnr' and TABLE_NAME = 'FileNeedProcessing')
CREATE TABLE [lsnr].[FileNeedProcessing] (
  [RowID] integer primary key identity (1,1)
, [ContainingFile] varchar(100) NOT NULL
, [UserID] varchar(50) not null
, [FQN] varchar(800) NOT NULL 
, [LineID] integer null
, [LastProcessDate] datetime NULL
, FileApplied integer default 0 
, [RowCreateDate] datetime DEFAULT getdate()
, OldFileName varchar(800) null)
go

drop TABLE [lsnr].[ProcessedListenerFiles] 
go
if not exists (select 1 from INFORMATION_SCHEMA.tables where table_schema = 'lsnr' and TABLE_NAME = 'ProcessedListenerFiles')
CREATE TABLE [lsnr].[ProcessedListenerFiles] (
  [RowID] integer primary key identity(1,1)
, [UserID] varchar(50) not null
, [ListenerFileName] varchar(100) NOT NULL
, [RowCreateDate] datetime default getdate()
)
go

if not exists (select 1 from sys.indexes where name = 'PI_DLDrop')
CREATE INDEX PI_DLDrop on [lsnr].[DirListener] (FileCanBeDropped)
go

if not exists (select 1 from sys.indexes where name = 'PI_FileNeedProcessingFQN')
CREATE INDEX PI_FileNeedProcessingFQN on [lsnr].[FileNeedProcessing] (FQN, UserID)
go

if not exists (select 1 from sys.indexes where name = 'PI_FileNeedProcessingRowid')
CREATE INDEX PI_FileNeedProcessingRowid on lsnr.FileNeedProcessing (RowID)
go

if not exists (select 1 from sys.indexes where name = 'PI_FileProcessed')
CREATE INDEX PI_FileProcessed on lsnr.FileNeedProcessing (FileApplied)
go

if not exists (select 1 from sys.indexes where name = 'PK_DirListener')
CREATE UNIQUE INDEX PK_DirListener on lsnr.DirListener (UserID, ListenerFileName)
go

if not exists (select 1 from sys.indexes where name = 'PK_FileNeedProcessing')
CREATE UNIQUE INDEX PK_FileNeedProcessing on lsnr.FileNeedProcessing (ContainingFile, FQN)
go

if not exists (select 1 from sys.indexes where name = 'PK_FileNeedProcessing')
CREATE UNIQUE INDEX PK_FileNeedProcessing on lsnr.FileNeedProcessing (ContainingFile, FQN)
go

if not exists (select 1 from sys.indexes where name = 'PK_ProcessedListenerFiles')
CREATE UNIQUE INDEX PK_ProcessedListenerFiles on lsnr.ProcessedListenerFiles (ListenerFileName)