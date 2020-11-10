BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS 'ContactsArchive' (
	'RowID'	integer,
	'Email1Address'	nvarchar(100) NOT NULL COLLATE NOCASE,
	'FullName'	nvarchar(100) NOT NULL COLLATE NOCASE,
	PRIMARY KEY('RowID' AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS 'Directory' (
	'DirName'	nvarchar(1000) NOT NULL UNIQUE COLLATE NOCASE,
	'DirID'	integer,
	'UseArchiveBit'	bit NOT NULL,
	'DirHash'	nvarchar(512) COLLATE NOCASE,
	'LastArchiveDate'	datetime,
	PRIMARY KEY('DirID' AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS 'Exchange' (
	'sKey'	nvarchar(200) NOT NULL,
	'RowID'	integer,
	'KeyExists'	bit DEFAULT 1,
	PRIMARY KEY('RowID' AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS 'Files' (
	'FileID'	integer,
	'FileName'	nvarchar(254) NOT NULL COLLATE NOCASE,
	'FileHash'	nvarchar(512) COLLATE NOCASE,
	PRIMARY KEY('FileID' AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS 'Inventory' (
	'InvID'	integer,
	'DirID'	int NOT NULL,
	'FileID'	int NOT NULL,
	'FileExist'	bit DEFAULT (1),
	'FileSize'	bigint,
	'CreateDate'	datetime,
	'LastUpdate'	datetime,
	'LastArchiveUpdate'	datetime,
	'ArchiveBit'	bit,
	'NeedsArchive'	bit,
	'FileHash'	nvarchar(512) COLLATE NOCASE,
	PRIMARY KEY('InvID' AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS 'MultiLocationFiles' (
	'LocID'	integer,
	'DirID'	int NOT NULL,
	'FileID'	int NOT NULL,
	'FileHash'	nvarchar(512) NOT NULL COLLATE NOCASE,
	PRIMARY KEY('LocID' AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS 'Outlook' (
	'RowID'	integer,
	'sKey'	nvarchar(500) NOT NULL UNIQUE COLLATE NOCASE,
	'KeyExists'	bit DEFAULT 1,
	PRIMARY KEY('RowID' AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS 'ZipFile' (
	'RowNbr'	integer,
	'DirID'	int,
	'FileID'	int,
	'FQN'	nvarchar(1000) NOT NULL UNIQUE COLLATE NOCASE,
	'EmailAttachment'	bit DEFAULT (0),
	'SuccessfullyProcessed'	bit DEFAULT (0),
	'fSize'	bigint,
	'CreateDate'	datetime NOT NULL,
	'LastAccessDate'	datetime,
	'NumberOfZipFiles'	int,
	'ParentGuid'	nvarchar(50) COLLATE NOCASE,
	'InWork'	bit DEFAULT (0),
	'FileHash'	nvarchar(512) COLLATE NOCASE,
	PRIMARY KEY('RowNbr' AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS 'DirFilesID' (
	'FQN'	nvarchar(1000) NOT NULL,
	'LastArchiveDate'	datetime,
	'FileLength'	bigint,
	'LastModDate'	datetime
);
CREATE TABLE IF NOT EXISTS 'DirListener' (
	'FileID'	integer,
	'ListenerFileName'	nvarchar(100) NOT NULL COLLATE NOCASE,
	'LastIdProcessed'	integer,
	'LastProcessDate'	datetime,
	'FileCanBeDropped'	integer,
	PRIMARY KEY('FileID' AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS 'FileNeedProcessing' (
	'RowID'	integer,
	'FQN'	nvarchar(1000) NOT NULL COLLATE NOCASE,
	'LineID'	integer,
	'LastProcessDate'	datetime,
	'FileCompleted'	integer,
	PRIMARY KEY('RowID' AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS 'Exts' (
	'Extension'	nvarchar(50),
	'Verified'	INTEGER,
	PRIMARY KEY('Extension')
);
CREATE TABLE IF NOT EXISTS 'LastArchive' (
	'LastArchiveDate'	datetime,
	'LastArchiveDateActive'	nvarchar(1)
);
CREATE INDEX IF NOT EXISTS 'PI_CA' ON 'ContactsArchive' (
	'Email1Address',
	'FullName'
);
CREATE INDEX IF NOT EXISTS 'PI_DirHash' ON 'Directory' (
	'DirHash'
);
CREATE INDEX IF NOT EXISTS 'PI_DirName' ON 'Directory' (
	'DirName'
);
CREATE INDEX IF NOT EXISTS 'PI_KEy' ON 'Exchange' (
	'KeyExists'
);
CREATE INDEX IF NOT EXISTS 'PI_Hash' ON 'Files' (
	'FileHash'
);
CREATE INDEX IF NOT EXISTS 'PI_NameHash' ON 'Files' (
	'FileName',
	'FileHash'
);
CREATE INDEX IF NOT EXISTS 'PI_FName' ON 'Files' (
	'FileName'
);
CREATE INDEX IF NOT EXISTS 'PI_InventoryHash' ON 'Inventory' (
	'FileHash'
);
CREATE INDEX IF NOT EXISTS 'PI_Archive' ON 'Inventory' (
	'NeedsArchive'
);
CREATE INDEX IF NOT EXISTS 'PI_DirFileID' ON 'Inventory' (
	'DirID',
	'FileID'
);
CREATE INDEX IF NOT EXISTS 'PI_MFHash' ON 'MultiLocationFiles' (
	'FileHash'
);
CREATE INDEX IF NOT EXISTS 'PI_MFDirFileID' ON 'Inventory' (
	'DirID',
	'FileID'
);
CREATE INDEX IF NOT EXISTS 'PI_SKey' ON 'Outlook' (
	'sKey'
);
CREATE INDEX IF NOT EXISTS 'PI_KeyExists' ON 'Outlook' (
	'KeyExists'
);
CREATE INDEX IF NOT EXISTS 'PI_OutlookSKey' ON 'Outlook' (
	'sKey'
);
CREATE INDEX IF NOT EXISTS 'PI_ZipFileHash' ON 'ZipFile' (
	'FileHash'
);
CREATE INDEX IF NOT EXISTS 'PI_ZipDirFileHash' ON 'ZipFile' (
	'DirID',
	'FileHash'
);
CREATE INDEX IF NOT EXISTS 'PI_ZipFqn' ON 'ZipFile' (
	'FQN'
);
CREATE UNIQUE INDEX IF NOT EXISTS 'PK_DirListener' ON 'DirListener' (
	'ListenerFileName'
);
CREATE UNIQUE INDEX IF NOT EXISTS 'PI_DLDrop' ON 'DirListener' (
	'FileCanBeDropped'
);
CREATE UNIQUE INDEX IF NOT EXISTS 'PK_FileNeedProcessing' ON 'FileNeedProcessing' (
	'FQN'
);
CREATE INDEX IF NOT EXISTS 'PI_Exts' ON 'Exts' (
	'Verified',
	'Extension'
);
CREATE INDEX IF NOT EXISTS 'UI_InvHash' ON 'Inventory' (
	'FileHash'
);
COMMIT;
