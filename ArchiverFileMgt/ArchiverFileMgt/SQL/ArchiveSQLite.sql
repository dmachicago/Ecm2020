
-- Script Date: 11/4/2019 12:05 PM  - ErikEJ.SqlCeScripting version 3.5.2.80

drop TABLE [MultiLocationFiles] ;
go
CREATE TABLE [MultiLocationFiles] (
  [LocID] int identity  NOT NULL
, [DirID] int NOT NULL
, [FileID] int NOT NULL
, [FileHash] nvarchar(50) NOT NULL COLLATE NOCASE
, CONSTRAINT [sqlite_autoindex_MultiLocationFiles_1] PRIMARY KEY ([LocID])
);
go
CREATE INDEX [MultiLocationFiles_PI_MultiLocationFilesHash] ON [MultiLocationFiles] ([FileHash] ASC);
go
CREATE unique INDEX [MultiLocationFiles_PI_DirFile] ON [MultiLocationFiles] ([DirID] , [FileID] ASC);

go
DROP TABLE [Listener];
go
CREATE TABLE [Listener] (
  [RowID] int identity  NOT NULL
, [FQN] nvarchar(2000) NOT NULL COLLATE NOCASE
, [Uploaded] int DEFAULT 0 NOT NULL
, CONSTRAINT [sqlite_autoindex_Listener_1] PRIMARY KEY (RowID)
);
go
CREATE unique INDEX [PI_Listener] ON [Listener] ([FQN] ASC);
go


DROP TABLE [ContactsArchive];
go
CREATE TABLE [ContactsArchive] (
	[RowID] int IDENTITY (1,1) NOT NULL
	, [Email1Address] nvarchar(100) NOT NULL COLLATE NOCASE
	, [FullName] nvarchar(100) NOT NULL COLLATE NOCASE
	, CONSTRAINT [sqlite_autoindex_ContactsArchive_1] PRIMARY KEY (RowID)
);
CREATE unique INDEX [PI_ContactsArchive] ON [ContactsArchive] ([Email1Address],[FullName]);
go

drop TABLE [Inventory]
go
CREATE TABLE [Inventory] (
  [InvID] int IDENTITY (1,1) NOT NULL
, [DirID] int NOT NULL
, [FileID] int NOT NULL
, [FileExist] bit DEFAULT 1 NULL
, [FileSize] bigint NULL
, [CreateDate] datetime NULL
, [LastUpdate] datetime NULL
, [LastArchiveUpdate] datetime NULL
, [ArchiveBit] bit NULL
, [NeedsArchive] bit NULL
, [FileHash] nvarchar(50) NULL
, CONSTRAINT Inventory_pk PRIMARY KEY (InvID)
);
GO
CREATE INDEX [PI_Hash] ON [Inventory] ([FileHash] ASC);
GO
CREATE INDEX [PI_NeedsArchive] ON [Inventory] ([NeedsArchive] ASC);
GO
CREATE unique INDEX [PI_DirFileID] ON [Inventory] ([DirID],FileID);
GO

drop TABLE [Directory] 
go
CREATE TABLE [Directory] (
  [DirName] nvarchar(1000) NOT NULL
, [DirID] int IDENTITY (1,1) NOT NULL
, [UseArchiveBit] bit NOT NULL
, [DirHash] nvarchar(50) NULL
, CONSTRAINT Directory_pk PRIMARY KEY (DirName)
);
GO
CREATE INDEX [PI_HashDir] ON [Directory] ([DirHash] ASC);
GO

drop TABLE [Exchange] 
go
CREATE TABLE [Exchange] (
  [sKey] nvarchar(200) NOT NULL
, [RowID] int IDENTITY (1,1) NOT NULL
, [KeyExists] bit DEFAULT 1 NULL
, CONSTRAINT Exchange_pk PRIMARY KEY (sKey)
);
GO
CREATE INDEX [PI_Exchange01] ON [Exchange] ([RowID] ASC);
GO
CREATE INDEX [PI_Exchange02] ON [Exchange] ([KeyExists] ASC);
GO


drop TABLE [Files] 
go
CREATE TABLE [Files] (
  [FileID] int IDENTITY (1,1) NOT NULL
, [FileName] nvarchar(254) NOT NULL
, [FileHash] nvarchar(50) NULL
, CONSTRAINT Files_pk PRIMARY KEY (FileID)
);
GO
CREATE INDEX [PI_HashFiles] ON [Files] ([FileHash] ASC);
GO
CREATE unique INDEX [PI_FileName] ON [Files] ([FileName] ASC);
GO

drop TABLE [Listener] 
go
CREATE TABLE [Listener] (
  [FQN] nvarchar(2000) NOT NULL
, [Uploaded] int DEFAULT 0 NOT NULL
, CONSTRAINT Listener_pk PRIMARY KEY (FQN)
);
GO

DROP TABLE [ZipFile];
GO
CREATE TABLE [ZipFile] (
  [RowNbr] int IDENTITY (1,1) NOT NULL
, [DirID] int null
, [FileID] int null
, [FQN] nvarchar(1000) NOT NULL
, [EmailAttachment] bit DEFAULT 0 NULL
, [SuccessfullyProcessed] bit DEFAULT 0 NULL
, [fSize] bigint NULL
, [CreateDate] datetime not NULL
, [LastAccessDate] datetime NULL
, [NumberOfZipFiles] int NULL
, [ParentGuid] nvarchar(50) NULL
, [InWork] bit DEFAULT 0 NULL
, [FileHash] nvarchar(50) NULL
, CONSTRAINT ZipFile_pk PRIMARY KEY (RowNbr)
);
GO
CREATE INDEX [PI_HashZipFile] ON [ZipFile] ([FileHash] ASC);
GO
CREATE unique INDEX [PI_IDZipFile] ON [ZipFile] (DirID, FileId ASC);
GO

DROP TABLE [Outlook];
go
CREATE TABLE [Outlook] (
  [RowID] int identity  NOT NULL
, [sKey] nvarchar(500) NOT NULL COLLATE NOCASE
, [KeyExists] bit DEFAULT 1 NULL
, CONSTRAINT [sqlite_autoindex_Outlook_1] PRIMARY KEY ([RowID])
);
CREATE INDEX [Outlook_UK_Outlook] ON [Outlook] ([sKey] ASC);
CREATE INDEX [Outlook_PI_Outlook02] ON [Outlook] ([KeyExists] ASC);
CREATE INDEX [Outlook_PI_Outlook01] ON [Outlook] ([RowID] ASC);
go
