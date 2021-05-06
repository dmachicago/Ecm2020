USE [ECM.Library.FS]
go

if not exists (select 1 from INFORMATION_SCHEMA.columns where COLUMN_NAME = 'SecCode' and TABLE_NAME = 'DataSource')
ALTER TABLE dbo.DataSource ADD SecCode nvarchar(50)  NULL
go
if not exists (select 1 from sys.indexes where NAME = 'DS_SecCode')
CREATE INDEX DS_SecCode ON [dbo].[DataSource]
(
	SourceGuid, SecCode ASC
)
go

if not exists (select 1 from INFORMATION_SCHEMA.columns where COLUMN_NAME = 'SecCode' and TABLE_NAME = 'Directory')
ALTER TABLE dbo.Directory ADD SecCode nvarchar(50)  NULL
go
if not exists (select 1 from sys.indexes where NAME = 'DIR_SecCode')
create index DIR_SecCode on [Directory]
(
	[UserID] ASC,
	[FQN] ASC,
	SecCode ASC
)
GO

if not exists (select 1 from INFORMATION_SCHEMA.columns where COLUMN_NAME = 'SecCode' and TABLE_NAME = 'Email')
ALTER TABLE dbo.Email ADD SecCode nvarchar(50)  NULL
go
if not exists (select 1 from sys.indexes where NAME = 'EMAIL_SecCode')
CREATE index [EMAIL_SecCode] ON [dbo].[Email]
(
	EmailIdentifier ASC,
	SecCode asc
)
GO

if not exists (select 1 from INFORMATION_SCHEMA.columns where COLUMN_NAME = 'SecCode' and TABLE_NAME = 'EmailAttachment')
ALTER TABLE dbo.EmailAttachment ADD SecCode nvarchar(50)  NULL
go
if not exists (select 1 from sys.indexes where NAME = 'EA_SecCode')
CREATE index [EA_SecCode] ON [dbo].EmailAttachment
(
	RowGuid ASC,
	SecCode asc
)
GO

if not exists (select 1 from INFORMATION_SCHEMA.TABLES where TABLE_NAME = 'Clearance')
CREATE TABLE dbo.Clearance
(
    SecCode       nvarchar(50)    NOT NULL,
    ClearanceDesc nvarchar(1000)  NULL,
    AuthLevel     int             DEFAULT (1) NULL,
    CreateDate    datetime2       DEFAULT (getdate()) NULL,
    CONSTRAINT PK228
    PRIMARY KEY CLUSTERED (SecCode)
)
go
if not exists (Select 1 from Clearance where SecCode = 'NA')
insert into Clearance (SecCode, ClearanceDesc) values ('NA','No clearance defined for this item');
go
if not exists (select 1 from INFORMATION_SCHEMA.TABLES where TABLE_NAME = 'UserClearance')
CREATE TABLE dbo.UserClearance
(
    SecCode    nvarchar(50)  NOT NULL,
    UserID     nvarchar(50)  NOT NULL,
    ExpireDate datetime2     NULL,
    CreateDate datetime2     DEFAULT (getdate()) NULL,
    CONSTRAINT PK229
    PRIMARY KEY NONCLUSTERED (SecCode,UserID)
)
go

-- Add Referencing Foreign Keys SQL

ALTER TABLE dbo.UserClearance 
    ADD FOREIGN KEY (SecCode)
REFERENCES dbo.Clearance (SecCode)
go
ALTER TABLE dbo.UserClearance 
    ADD FOREIGN KEY (UserID)
REFERENCES dbo.Users (UserID)
go
ALTER TABLE dbo.DataSource ADD FOREIGN KEY (SecCode)
REFERENCES dbo.Clearance (SecCode)
go
ALTER TABLE dbo.Directory ADD FOREIGN KEY (SecCode)
REFERENCES dbo.Clearance (SecCode)
go
ALTER TABLE dbo.Email ADD FOREIGN KEY (SecCode)
REFERENCES dbo.Clearance (SecCode)
go
ALTER TABLE dbo.EmailAttachment ADD FOREIGN KEY (SecCode)
REFERENCES dbo.Clearance (SecCode)

GO
update [DataSource] set SecCode = 'NA' where SecCode is null;
go
update [Directory] set SecCode = 'NA' where SecCode is null;
go
update Email set SecCode = 'NA' where SecCode is null;
go
update EmailAttachment set SecCode = 'NA' where SecCode is null;
go
