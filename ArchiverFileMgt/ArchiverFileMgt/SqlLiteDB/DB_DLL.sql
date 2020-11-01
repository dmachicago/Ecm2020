CREATE TABLE [ZipFile] (
  [RowNbr] int identity  NOT NULL
, [DirID] int NULL
, [FileID] int NULL
, [FQN] nvarchar(1000) NOT NULL COLLATE NOCASE
, [EmailAttachment] bit DEFAULT (0) NULL
, [SuccessfullyProcessed] bit DEFAULT (0) NULL
, [fSize] bigint NULL
, [CreateDate] datetime NOT NULL
, [LastAccessDate] datetime NULL
, [NumberOfZipFiles] int NULL
, [ParentGuid] nvarchar(50) NULL COLLATE NOCASE
, [InWork] bit DEFAULT (0) NULL
, [FileHash] nvarchar(50) NULL COLLATE NOCASE
, CONSTRAINT [sqlite_autoindex_ZipFile_1] PRIMARY KEY ([RowNbr])
);
CREATE TABLE [Outlook] (
  [RowID] int identity NOT NULL
, [sKey] nvarchar(500) NOT NULL COLLATE NOCASE
, [KeyExists] bit DEFAULT (1) NULL
, CONSTRAINT [sqlite_autoindex_Outlook_1] PRIMARY KEY ([RowID])
);
CREATE TABLE [MultiLocationFiles] (
  [LocID] int identity NOT NULL
, [DirID] int NOT NULL
, [FileID] int NOT NULL
, [FileHash] nvarchar(50) NOT NULL COLLATE NOCASE
, CONSTRAINT [sqlite_autoindex_MultiLocationFiles_1] PRIMARY KEY ([LocID])
);
CREATE TABLE [Listener] (
  [FQN] nvarchar(2000) NOT NULL COLLATE NOCASE
, [Uploaded] int DEFAULT (0) NOT NULL
, CONSTRAINT [sqlite_autoindex_Listener_1] PRIMARY KEY ([FQN])
);
CREATE TABLE [Inventory] (
  [InvID] int identity  NOT NULL
, [DirID] int NOT NULL
, [FileID] int NOT NULL
, [FileExist] bit DEFAULT (1) NULL
, [FileSize] bigint NULL
, [CreateDate] datetime NULL
, [LastUpdate] datetime NULL
, [LastArchiveUpdate] datetime NULL
, [ArchiveBit] bit NULL
, [NeedsArchive] bit NULL
, [FileHash] nvarchar(50) NULL COLLATE NOCASE
, CONSTRAINT [sqlite_autoindex_Inventory_1] PRIMARY KEY ([InvID])
);
CREATE TABLE [Files] (
  [FileID] int identity  NOT NULL
, [FileName] nvarchar(254) NOT NULL COLLATE NOCASE
, [FileHash] nvarchar(50) NULL COLLATE NOCASE
, CONSTRAINT [sqlite_autoindex_Files_1] PRIMARY KEY ([FileID])
);
CREATE TABLE [Exchange] (
  [sKey] nvarchar(200) NOT NULL COLLATE NOCASE
, [RowID] int identity  NOT NULL
, [KeyExists] bit DEFAULT (1) NULL
, CONSTRAINT [sqlite_autoindex_Exchange_1] PRIMARY KEY ([sKey])
);
CREATE TABLE [Directory] (
  [DirName] nvarchar(1000) NOT NULL COLLATE NOCASE
, [DirID] int identity  NOT NULL
, [UseArchiveBit] bit NOT NULL
, [DirHash] nvarchar(50) NULL COLLATE NOCASE
, CONSTRAINT [sqlite_autoindex_Directory_1] PRIMARY KEY ([DirName])
);
CREATE TABLE [ContactsArchive] (
  [RowID] int identity  NOT NULL
, [Email1Address] nvarchar(100) NOT NULL COLLATE NOCASE
, [FullName] nvarchar(100) NOT NULL COLLATE NOCASE
, CONSTRAINT [sqlite_autoindex_ContactsArchive_1] PRIMARY KEY ([RowID])
);
CREATE UNIQUE INDEX [ZipFile_PI_IDZipFile] ON [ZipFile] ([DirID] ASC,[FileID] ASC);
CREATE INDEX [ZipFile_PI_HashZipFile] ON [ZipFile] ([FileHash] ASC);
CREATE INDEX [Outlook_Outlook_PI_Outlook01] ON [Outlook] ([RowID] ASC);
CREATE INDEX [Outlook_Outlook_PI_Outlook02] ON [Outlook] ([KeyExists] ASC);
CREATE INDEX [Outlook_Outlook_UK_Outlook] ON [Outlook] ([sKey] ASC);
CREATE UNIQUE INDEX [MultiLocationFiles_MultiLocationFiles_PI_DirFile] ON [MultiLocationFiles] ([DirID] ASC,[FileID] ASC);
CREATE INDEX [MultiLocationFiles_MultiLocationFiles_PI_MultiLocationFilesHash] ON [MultiLocationFiles] ([FileHash] ASC);
CREATE UNIQUE INDEX [Inventory_PI_DirFileID] ON [Inventory] ([DirID] ASC,[FileID] ASC);
CREATE INDEX [Inventory_PI_NeedsArchive] ON [Inventory] ([NeedsArchive] ASC);
CREATE INDEX [Inventory_PI_Hash] ON [Inventory] ([FileHash] ASC);
CREATE UNIQUE INDEX [Files_PI_FileName] ON [Files] ([FileName] ASC);
CREATE INDEX [Files_PI_HashFiles] ON [Files] ([FileHash] ASC);
CREATE INDEX [Exchange_PI_Exchange02] ON [Exchange] ([KeyExists] ASC);
CREATE INDEX [Exchange_PI_Exchange01] ON [Exchange] ([RowID] ASC);
CREATE INDEX [Directory_PI_HashDir] ON [Directory] ([DirHash] ASC);
CREATE UNIQUE INDEX [ContactsArchive_PI_ContactsArchive] ON [ContactsArchive] ([Email1Address] ASC,[FullName] ASC);
COMMIT;

