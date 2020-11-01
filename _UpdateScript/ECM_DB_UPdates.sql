USE [ECM.Library.FS]
go

-- Drop Constraint, Rename and Create Table SQL

EXEC sp_rename 'dbo.DataSourceAsso','DataSource_10252020150922000',OBJECT
go
CREATE TABLE dbo.DataSourceAsso
(
    DataSourceImageGuid uniqueidentifier  NOT NULL,
    DataSourceGuid      uniqueidentifier  NOT NULL,
    SourceGuid          nvarchar(50)      NULL,
    ImageHash           nvarchar(80)      NOT NULL,
    FqnHASH             nvarchar(150)     NULL,
    RowGuid             uniqueidentifier  CONSTRAINT DF__DataSourc__RowGu__61130711 DEFAULT (newid()) NOT NULL
)
ON [PRIMARY]
go
CREATE TABLE dbo.DataSourceActivePeriod
(
    PeriodID     nvarchar(50)      NOT NULL,
    BeginDate    datetime          NULL,
    EndDate      datetime          NULL,
    ImageRowGuid uniqueidentifier  NOT NULL,
    Imagehash    nvarchar(80)      NOT NULL,
    SourceGuid   nvarchar(50)      NOT NULL,
    FqnHASH      nvarchar(150)     NOT NULL,
    RowGuid      uniqueidentifier  NOT NULL,
    CONSTRAINT PK212
    PRIMARY KEY NONCLUSTERED (PeriodID,SourceGuid,FqnHASH,RowGuid)
)
go
CREATE TABLE dbo.DataSourceCols
(
    UserID    nvarchar(50)  NOT NULL,
    ColName   nvarchar(50)  NOT NULL,
    ReturnCol bit           NULL,
    CONSTRAINT PK210
    PRIMARY KEY NONCLUSTERED (ColName,UserID)
)
go
CREATE TABLE dbo.DataSourceImages
(
    SourceGuid nvarchar(50)      NOT NULL,
    FqnHASH    nvarchar(150)     NOT NULL,
    DirHASH    nvarchar(150)     NULL,
    FileHASH   nvarchar(150)     NULL,
    RowGuid    uniqueidentifier  CONSTRAINT DF__DataSourc__RowGu__61130711 DEFAULT (newid()) NOT NULL,
    CONSTRAINT PK214
    PRIMARY KEY NONCLUSTERED (SourceGuid,FqnHASH,RowGuid)
)
go

-- Insert Data SQL

INSERT INTO dbo.DataSourceAsso(
                               DataSourceImageGuid,
                               DataSourceGuid,
                               SourceGuid,
                               ImageHash,
                               FqnHASH
--                             RowGuid,
                              )
                        SELECT 
                               DataSourceImageGuid,
                               DataSourceGuid,
                               NULL,
                               ImageHash,
                               NULL
--                             (newid()),
                          FROM dbo.DataSource_10252020150922000 
go
IF EXISTS (SELECT * FROM sysindexes WHERE id=OBJECT_ID('dbo.DataSource_10252020150922000') AND name='PKey_DataSourceAssoHash')
BEGIN
    DROP INDEX dbo.DataSource_10252020150922000.PKey_DataSourceAssoHash
    IF EXISTS (SELECT * FROM sysindexes WHERE id=OBJECT_ID('dbo.DataSource_10252020150922000') AND name='PKey_DataSourceAssoHash')
        PRINT '<<< FAILED DROPPING INDEX dbo.DataSource_10252020150922000.PKey_DataSourceAssoHash >>>'
    ELSE
        PRINT '<<< DROPPED INDEX dbo.DataSource_10252020150922000.PKey_DataSourceAssoHash >>>'
END
go
IF EXISTS (SELECT * FROM sysindexes WHERE id=OBJECT_ID('dbo.DataSource_10252020150922000') AND name='PKey_DataSourceAsso')
BEGIN
    DROP INDEX dbo.DataSource_10252020150922000.PKey_DataSourceAsso
    IF EXISTS (SELECT * FROM sysindexes WHERE id=OBJECT_ID('dbo.DataSource_10252020150922000') AND name='PKey_DataSourceAsso')
        PRINT '<<< FAILED DROPPING INDEX dbo.DataSource_10252020150922000.PKey_DataSourceAsso >>>'
    ELSE
        PRINT '<<< DROPPED INDEX dbo.DataSource_10252020150922000.PKey_DataSourceAsso >>>'
END
go

-- Add Constraint SQL

CREATE UNIQUE CLUSTERED INDEX PKey_DataSourceAsso
    ON dbo.DataSourceAsso(DataSourceImageGuid,DataSourceGuid)
    ON [PRIMARY]
go
ALTER TABLE dbo.DataSourceAsso ADD CONSTRAINT PK209
PRIMARY KEY NONCLUSTERED (RowGuid)
go

-- Add Indexes SQL

CREATE NONCLUSTERED INDEX PKey_DataSourceAssoHash
    ON dbo.DataSourceAsso(ImageHash)
    ON [PRIMARY]
go

-- Alter Index SQL

CREATE NONCLUSTERED INDEX PI_DSColName
    ON dbo.DataSourceCols(ReturnCol,ColName,UserID)
go

-- Add Referencing Foreign Keys SQL

ALTER TABLE dbo.DataSourceActivePeriod 
    ADD FOREIGN KEY (RowGuid)
REFERENCES dbo.DataSource (RowGuid)
 ON DELETE CASCADE
go
ALTER TABLE dbo.DataSourceImages 
    ADD FOREIGN KEY (RowGuid)
REFERENCES dbo.DataSourceImage (RowGuid)
go
ALTER TABLE dbo.DataSourceImages 
    ADD FOREIGN KEY (RowGuid)
REFERENCES dbo.DataSource (RowGuid)
go
ALTER TABLE dbo.DataSourceImages 
    ADD FOREIGN KEY (RowGuid)
REFERENCES dbo.DataSource (RowGuid)
go
ALTER TABLE dbo.DataSourceAsso ADD FOREIGN KEY (RowGuid)
REFERENCES dbo.DataSource (RowGuid)
go
ALTER TABLE dbo.DataSourceAsso ADD FOREIGN KEY (RowGuid)
REFERENCES dbo.DataSourceImage (RowGuid)
go
