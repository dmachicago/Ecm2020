BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS "KeyTable" (
	"ErrRowNbr"	INTEGER,
	"TableKey"	TEXT,
	"SourceName"	varchar(1000),
	"OccrCnt"	integer,
	"TypeCode"	varchar(50),
	"OriginalExt"	varchar(50),
	PRIMARY KEY("ErrRowNbr","TableKey")
);
CREATE TABLE IF NOT EXISTS "Errors" (
	"ErrRowNbr"	integer,
	"ErrorMsg"	text UNIQUE,
	"ErrTbl"	varchar(100),
	"TypeErr"	varchar(25),
	"OccrCnt"	integer,
	PRIMARY KEY("ErrRowNbr" AUTOINCREMENT)
);
CREATE INDEX IF NOT EXISTS "PI_KeyTable" ON "KeyTable" (
	"TableKey"
);
CREATE UNIQUE INDEX IF NOT EXISTS "UI_Errors" ON "Errors" (
	"ErrorMsg",
	"ErrTbl",
	"TypeErr"
);
CREATE INDEX IF NOT EXISTS "UI_KeyTable" ON "KeyTable" (
	"TableKey",
	"SourceName"
);
COMMIT;
