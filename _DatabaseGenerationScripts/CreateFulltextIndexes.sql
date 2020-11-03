
USE [ECM.Library.FS];

/**************************************************
Step 1
**************************************************/

IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE name = 'PK_DataSource_1'
)
    ALTER TABLE dbo.DataSource
    ADD CONSTRAINT PK_DataSource_1 PRIMARY KEY NONCLUSTERED(RowGuid ASC);
GO
IF EXISTS
(
    SELECT 1 AS TableName
    FROM sys.fulltext_indexes
    WHERE OBJECT_NAME(object_id) = 'DataSource'
)
    BEGIN
        DROP FULLTEXT INDEX ON DataSource;
END;
GO
IF EXISTS
(
    SELECT 1
    FROM sys.fulltext_catalogs
    WHERE name = 'ftDataSource'
)
    DROP FULLTEXT CATALOG ftDataSource;
CREATE FULLTEXT CATALOG ftDataSource WITH ACCENT_SENSITIVITY = OFF;
GO
CREATE FULLTEXT INDEX ON dbo.DataSource(
		SourceName LANGUAGE 1033, 
		SourceImage TYPE COLUMN SourceTypeCode LANGUAGE 1033, 
		Description LANGUAGE 1033, 
		KeyWords LANGUAGE 1033, 
		Notes LANGUAGE 1033, 
		OcrText LANGUAGE 1033) 
		KEY INDEX PK_DataSource_1 ON ftDataSource WITH CHANGE_TRACKING AUTO;
GO

/**************************************************
Step 2
**************************************************/

GO
IF EXISTS
(
    SELECT 1 AS TableName
    FROM sys.fulltext_indexes
    WHERE OBJECT_NAME(object_id) = 'Email'
)
    BEGIN
        DROP FULLTEXT INDEX ON Email;
END;
GO
ALTER TABLE dbo.Email DROP CONSTRAINT PKI_Email_FTI WITH(ONLINE = OFF);
GO
ALTER TABLE dbo.Email
ADD CONSTRAINT PKI_Email_FTI PRIMARY KEY CLUSTERED(EmailGuid ASC);
GO
IF EXISTS
(
    SELECT 1
    FROM sys.fulltext_catalogs
    WHERE name = 'ftEmail'
)
    DROP FULLTEXT CATALOG ftEmail;
GO
CREATE FULLTEXT CATALOG ftEmail WITH ACCENT_SENSITIVITY = OFF;
GO
CREATE FULLTEXT INDEX ON dbo.Email(
		SUBJECT LANGUAGE 1033, 
		Body LANGUAGE 1033, 
		EmailImage TYPE COLUMN SourceTypeCode LANGUAGE 1033, 
		ShortSubj LANGUAGE 1033, Description LANGUAGE 1033, 
		KeyWords LANGUAGE 1033, 
		notes LANGUAGE 1033) 
		KEY INDEX PKI_Email_FTI ON ftEmail WITH CHANGE_TRACKING AUTO;
GO

/**************************************************
Step 3
**************************************************/

IF EXISTS
(
    SELECT 1 AS TableName
    FROM sys.fulltext_indexes
    WHERE OBJECT_NAME(object_id) = 'EmailAttachment'
)
    BEGIN
        DROP FULLTEXT INDEX ON EmailAttachment;
END;
GO
IF EXISTS
(
    SELECT 1
    FROM sys.fulltext_catalogs
    WHERE name = 'ftEmailAttachment'
)
    DROP FULLTEXT CATALOG ftEmailAttachment;
CREATE FULLTEXT CATALOG ftEmailAttachment WITH ACCENT_SENSITIVITY = OFF;
GO
CREATE FULLTEXT INDEX ON dbo.EmailAttachment(
		Attachment TYPE COLUMN [Attachmentcode] LANGUAGE 1033, 
		AttachmentName LANGUAGE 1033, 
		OcrText LANGUAGE 1033) 
		KEY INDEX PK__EmailAtt__B975DD8289908A26 ON ftEmailAttachment WITH CHANGE_TRACKING AUTO;
GO
IF NOT EXISTS
(
    SELECT 1
    FROM sys.tables
    WHERE name = 'DataSourceImage'
)
    BEGIN
        CREATE TABLE dbo.DataSourceImage
        (RowGuid          UNIQUEIDENTIFIER NOT NULL, 
         SourceTypeCode   NVARCHAR(50) NOT NULL, 
         OriginalFileType NVARCHAR(50) NOT NULL, 
         Description      NVARCHAR(MAX) NULL, 
         KeyWords         NVARCHAR(2000) NULL, 
         Notes            NVARCHAR(2000) NULL, 
         OcrText          NVARCHAR(MAX) NULL, 
         OcrPerformed     NCHAR(1) NULL, 
         SourceImage      VARBINARY(MAX) NULL, 
         SourceName       NVARCHAR(254) NULL, 
         Imagehash        NVARCHAR(80) NULL, 
         ImageLen         INT NULL, 
         FileLength       INT NULL, 
         LastUpdate       DATETIME NULL, 
         CRC              NVARCHAR(50) NULL, 
         CONSTRAINT PKey_DataSourceImage PRIMARY KEY NONCLUSTERED(RowGuid ASC)
         WITH(PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
        )
        ON [PRIMARY];
        ALTER TABLE dbo.DataSourceImage ADD DEFAULT NEWID() FOR RowGuid;
        ALTER TABLE dbo.DataSourceImage ADD DEFAULT GETDATE() FOR LastUpdate;
END;
GO
-- DROP INDEX [PI_DataSourceHash] ON [dbo].[DataSourceImage]

IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE name = 'PI_DataSourceHash'
)
    BEGIN
        CREATE UNIQUE NONCLUSTERED INDEX PI_DataSourceHash ON dbo.DataSourceImage(Imagehash ASC);
END;
GO
IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE name = 'PI_DataSourceHash'
)
    BEGIN
        ALTER TABLE dbo.DataSourceImage
        ADD CONSTRAINT PKey_DataSourceImage PRIMARY KEY NONCLUSTERED(RowGuid ASC);
END;
GO
--*****************************************

IF NOT EXISTS
(
    SELECT 1
    FROM sys.tables
    WHERE name = 'DataSourceImage'
)
    BEGIN
        IF NOT EXISTS
        (
            SELECT 1
            FROM sys.fulltext_catalogs
            WHERE name = 'ftDataSourceImage'
        )
            CREATE FULLTEXT CATALOG ftDataSourceImage AS DEFAULT; 
        --select OBJECT_NAME(object_id) from sys.fulltext_indexes where OBJECT_NAME(object_id) = 'DataSourceImage'
        IF NOT EXISTS
        (
            SELECT 1
            FROM sys.fulltext_indexes
            WHERE OBJECT_NAME(object_id) = 'DataSourceImage'
        )
            BEGIN
                CREATE FULLTEXT INDEX ON dbo.DataSourceImage(
						SourceName LANGUAGE 1033, 
						SourceImage TYPE COLUMN SourceTypeCode LANGUAGE 1033, 
						Description LANGUAGE 1033, 
						KeyWords LANGUAGE 1033, 
						Notes LANGUAGE 1033, 
						OcrText LANGUAGE 1033) 
						KEY INDEX PKey_DataSourceImage ON ftDataSource WITH CHANGE_TRACKING AUTO;
        END;
END;