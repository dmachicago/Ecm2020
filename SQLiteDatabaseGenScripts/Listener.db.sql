BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS "ProcessedListenerFiles" (
	"RowID"	integer,
	"ListenerFileName"	nvarchar(100) NOT NULL COLLATE NOCASE,
	"RowCreateDate"	datetime,
	PRIMARY KEY("RowID" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "DirListener" (
	"RowID"	integer,
	"ListenerFileName"	nvarchar(1000) NOT NULL COLLATE NOCASE,
	"LastIdProcessed"	integer,
	"LastProcessDate"	datetime,
	"FileCanBeDropped"	integer DEFAULT 0,
	"RowCreateDate"	datetime DEFAULT ('now'),
	PRIMARY KEY("RowID" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "FileNeedProcessing" (
	"RowID"	integer,
	"ContainingFile"	nvarchar(100) NOT NULL COLLATE NOCASE,
	"FQN"	nvarchar(1000) NOT NULL COLLATE NOCASE,
	"LineID"	integer,
	"LastProcessDate"	datetime,
	"FileApplied"	integer DEFAULT 0,
	"RowCreateDate"	datetime DEFAULT ('now'),
	"OldFileName"	nvarchar(1000),
	"ListenerDir"	nvarchar(700),
	PRIMARY KEY("RowID" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "Exts" (
	"Extension"	TEXT,
	"Validated"	INTEGER,
	PRIMARY KEY("Extension")
);
CREATE UNIQUE INDEX IF NOT EXISTS "PK_ProcessedListenerFiles" ON "ProcessedListenerFiles" (
	"ListenerFileName"
);
CREATE UNIQUE INDEX IF NOT EXISTS "PK_DirListener" ON "DirListener" (
	"ListenerFileName"
);
CREATE INDEX IF NOT EXISTS "PI_DLDrop" ON "DirListener" (
	"FileCanBeDropped"
);
CREATE INDEX IF NOT EXISTS "PI_DirListenerRowid" ON "DirListener" (
	"RowID"
);
CREATE UNIQUE INDEX IF NOT EXISTS "PK_FileNeedProcessing" ON "FileNeedProcessing" (
	"ContainingFile",
	"FQN"
);
CREATE INDEX IF NOT EXISTS "PI_FileNeedProcessingFQN" ON "FileNeedProcessing" (
	"FQN"
);
CREATE INDEX IF NOT EXISTS "PI_FileNeedProcessingRowid" ON "FileNeedProcessing" (
	"RowID"
);
CREATE INDEX IF NOT EXISTS "PI_FileProcessed" ON "FileNeedProcessing" (
	"FileApplied"
);
COMMIT;
