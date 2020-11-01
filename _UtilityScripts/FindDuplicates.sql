IF NOT EXISTS
(
    SELECT 1
        FROM INFORMATION_SCHEMA.COLUMNS
        WHERE table_name = 'Email'
              AND COLUMN_NAME = 'ImageHash'
)
    BEGIN
        ALTER TABLE email
        ADD Imagehash NVARCHAR(80);
END;
GO
if not exists (select 1 from sys.indexes where name = 'PI_emailImagehash')
	create index PI_emailImagehash on email (Imagehash);
go
IF NOT EXISTS
(
    SELECT 1
        FROM INFORMATION_SCHEMA.COLUMNS
        WHERE table_name = 'DataSource'
              AND COLUMN_NAME = 'ImageHash'
)
    BEGIN
        ALTER TABLE datasource
        ADD Imagehash NVARCHAR(80);
END;
GO

go
IF NOT EXISTS
(
    SELECT 1
        FROM INFORMATION_SCHEMA.COLUMNS
        WHERE table_name = 'DataSource'
              AND COLUMN_NAME = 'ImageLen'
)
    BEGIN
        ALTER TABLE datasource
        ADD ImageLen INT NULL;
END;
GO
IF EXISTS
(
    SELECT 1
        FROM sys.indexes
        WHERE name = 'PI_Imagehash'
)
drop index PI_Imagehash on DataSource

alter table DataSource alter column Imagehash nvarchar(250) not null;


/****** Object:  Index [CI_dataSource01]    Script Date: 7/1/2020 12:18:31 PM ******/
DROP INDEX [CI_dataSource01] ON [dbo].[DataSource]
DROP INDEX [PI_SrcNameCRC] ON [dbo].[DataSource]
DROP INDEX [PI03_SrcFilLenCrc] ON [dbo].[DataSource]
GO

alter table DataSource alter column CRC nvarchar(250) not null;
GO

CREATE NONCLUSTERED INDEX [PI03_SrcFilLenCrc] ON [dbo].[DataSource]
(
	[SourceName] ASC,
	[FileLength] ASC,
	[CRC] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [PI_SrcNameCRC] ON [dbo].[DataSource]
(
	[SourceName] ASC,
	[CRC] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [CI_dataSource01] ON [dbo].[DataSource]
(
	[SourceName] ASC
)
INCLUDE ( 	[CreateDate],
	[LastAccessDate],
	[FileLength],
	[CRC]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

if not exists (select 1 from sys.indexes where name = 'PI_Imagehash')
	CREATE INDEX PI_Imagehash
	ON datasource
		(Imagehash
		);
GO

PRINT('Step 1 Updating DataSource ImageHash: ' + CONVERT(NVARCHAR(20), GETDATE()));
UPDATE DataSource
  SET 
	  CRC = HASHBYTES('SHA2_512', SourceImage), 
      Imagehash = HASHBYTES('SHA2_512', SourceImage), 
      ImageLen = DATALENGTH(SourceImage) + 1
    WHERE Imagehash IS NULL;
GO

UPDATE DataSource set CRC = CONVERT(VARBINARY(MAX), CONVERT(NVARCHAR(MAX), CRC, 1)) 
UPDATE DataSource set CRC = CONVERT(VARBINARY(MAX), CONVERT(NVARCHAR(MAX), ImageHash, 1))
UPDATE DataSource set ImageHash = CRC

go
PRINT('Step 1 Complete: ' + CONVERT(NVARCHAR(20), GETDATE()));
IF EXISTS
(
    SELECT 1
        FROM sys.tables
        WHERE name = '_DuplicateFiles'
)
    BEGIN
        DROP TABLE _DuplicateFiles;
END;
PRINT('Step 2 Create New Table: ' + CONVERT(NVARCHAR(20), GETDATE()));
CREATE TABLE [dbo].[_DuplicateFiles]
   (GroupID                 INT, 
    [RowGuid]               [UNIQUEIDENTIFIER] NOT NULL, 
    [SourceName]            [NVARCHAR](254) NULL, 
    [FQN]                   [VARCHAR](712) NULL, 
    [VersionNbr]            [INT] NOT NULL, 
    [FileLength]            [INT] NULL, 
    [UserID]                [NVARCHAR](50) NULL, 
    [DataSourceOwnerUserID] [NVARCHAR](50) NOT NULL, 
    [FileDirectory]         [NVARCHAR](300) NULL, 
    [OriginalFileType]      [NVARCHAR](50) NULL, 
    [OcrText]               [NVARCHAR](MAX) NULL, 
    [RecHash]               [VARCHAR](50) NULL, 
    [RowID]                 [INT] NOT NULL, 
    Imagehash               NVARCHAR(80), 
    ImageLen                INT, 
    EntryDate               DATETIME DEFAULT GETDATE(), 
    TotalDuplicates         INT NULL
   );
GO
IF NOT EXISTS
(
    SELECT 1
        FROM sys.indexes
        WHERE name = 'PI_DupImagehash'
)
    BEGIN
        CREATE INDEX PI_DupImagehash
        ON [_DuplicateFiles]
           (Imagehash
           );
END;
GO
GO
IF NOT EXISTS
(
    SELECT 1
        FROM sys.indexes
        WHERE name = 'PI_DupRowGUID'
)
    BEGIN
        CREATE INDEX PI_DupRowGUID
        ON [_DuplicateFiles]
           (RowGUID
           );
END;
GO
IF OBJECT_ID('_TempHash') IS NOT NULL
    BEGIN
        DROP TABLE _TempHash;
END;

-- Set @FindDupFilesWithDifferentNames = to 1 to find DUP Documents with different names
-- or a 0 to find duplicate documents with the same name.

DECLARE @FindDupFilesWithDifferentNames INT = 1;
DECLARE @MySql NVARCHAR(2000) = '';
IF @FindDupFilesWithDifferentNames = 0
    BEGIN
        SET @MySql = 'select SourceName, ImageHash, Imagelen, FileLength, count(*) as CNT
						into _TempHash
						from DataSource
						group by SourceName, Imagehash,Imagelen,FileLength
						having count(*) > 1; ';
END;
    ELSE
    BEGIN
        SET @MySql = 'select ImageHash, Imagelen, FileLength, count(*) as CNT
						into _TempHash
						from DataSource
						group by Imagehash,Imagelen,FileLength
						having count(*) > 1;';
END;
PRINT('Step 3 Populate Temp Hash: ' + CONVERT(NVARCHAR(20), GETDATE()));
EXECUTE sp_executesql 
        @MySql;
CREATE INDEX PI_TempImageHash
ON _TempHash
   (ImageHash
   );
PRINT('Step 4 Temp Hash Populated: ' + CONVERT(NVARCHAR(20), GETDATE()));

-- select SourceName, convert (varbinary,[Imagehash]) as Imagehash,Imagelen,FileLength, CNT  from _TempHash

PRINT('Step 5 Populate Duplicate Files: ' + CONVERT(NVARCHAR(20), GETDATE()));
INSERT INTO [_DuplicateFiles]
( [RowGuid], 
  [SourceName], 
  [FQN], 
  [VersionNbr], 
  [FileLength], 
  [UserID], 
  [DataSourceOwnerUserID], 
  [FileDirectory], 
  [OriginalFileType], 
  [OcrText], 
  [RecHash], 
  [RowID], 
  Imagehash, 
  ImageLen, 
  TotalDuplicates
) 
       SELECT DS.[RowGuid], 
              DS.[SourceName], 
              DS.[FQN], 
              DS.[VersionNbr], 
              DS.[FileLength], 
              DS.[UserID], 
              DS.[DataSourceOwnerUserID], 
              DS.[FileDirectory], 
              DS.[OriginalFileType], 
              DS.[OcrText], 
              DS.[RecHash], 
              DS.[RowID], 
              DS.Imagehash, 
              DS.ImageLen, 
              TH.CNT
           FROM DataSource AS DS
                     JOIN _TempHash AS TH
                     ON DS.ImageHash = TH.ImageHash
       ORDER BY DS.Imagehash, 
                SourceName;
GO
PRINT('Step 6 Duplicate Files Populated : ' + CONVERT(NVARCHAR(20), GETDATE()));
PRINT('Step 7 Setting Groups : ' + CONVERT(NVARCHAR(20), GETDATE()));
IF CURSOR_STATUS('global', 'CSR') >= -1
    BEGIN
        DEALLOCATE CSR;
END;
DECLARE @ImageHash NVARCHAR(100) = '';
DECLARE @GroupID AS INT = 0;
DECLARE CSR CURSOR
FOR SELECT DISTINCT 
           ImageHash
        FROM [_DuplicateFiles]
    ORDER BY ImageHash;
OPEN CSR;
FETCH NEXT FROM CSR INTO @ImageHash;
WHILE @@FETCH_STATUS = 0
    BEGIN
        SET @GroupID = @GroupID + 1;
        UPDATE [_DuplicateFiles]
          SET 
              GroupID = @GroupID
            WHERE ImageHash = @ImageHash;
        FETCH NEXT FROM CSR INTO @ImageHash;
    END;
CLOSE CSR;
DEALLOCATE CSR;
PRINT('Step 8 Groups Set : ' + CONVERT(NVARCHAR(20), GETDATE()));
PRINT('Run Complete : ' + CONVERT(NVARCHAR(20), GETDATE()));
--********************************************************************
-- Run all the code above this first, this is the query that will
-- identify duplicate documents.
--********************************************************************

SELECT GroupID, 
               [RowGuid], 
               [SourceName], 
               [FQN], 
               [VersionNbr], 
               [UserID], 
               [DataSourceOwnerUserID], 
               [FileDirectory], 
               [OriginalFileType], 
               [OcrText], 
               [RecHash], 
               [RowID], 
               CONVERT(VARBINARY, [Imagehash]) AS Imagehash, 
               Imagelen, 
               [FileLength], 
               [EntryDate], 
               [TotalDuplicates]
    FROM [dbo].[_DuplicateFiles]
ORDER BY GroupID, 
         ImageHash, 
         SourceName;
GO
IF EXISTS
(
    SELECT 1
        FROM SYS.TABLES
        WHERE NAME = '_TEMPCOUNT'
)
    BEGIN
        DROP TABLE _TEMPCOUNT;
END;
SELECT GROUPID, 
       COUNT(*) AS CNT, 
       0 AS DUPS
INTO _TEMPCOUNT
    FROM _DuplicateFiles
    GROUP BY GroupID
ORDER BY CNT DESC;
UPDATE _TEMPCOUNT
  SET 
      DUPS = CNT - 1;
SELECT SUM(DUPS)
    FROM _TEMPCOUNT;


--******************************************************************************
DECLARE @ImageHash NVARCHAR(100) = '';
DECLARE @GroupID AS INT = 0;
DECLARE CSR CURSOR
FOR SELECT DISTINCT 
           ImageHash
        FROM [_DuplicateFiles]
    ORDER BY ImageHash;
OPEN CSR;
FETCH NEXT FROM CSR INTO @ImageHash;
WHILE @@FETCH_STATUS = 0
    BEGIN
        SET @GroupID = @GroupID + 1;
        UPDATE [_DuplicateFiles]
          SET 
              GroupID = @GroupID
            WHERE ImageHash = @ImageHash;
        FETCH NEXT FROM CSR INTO @ImageHash;
    END;
CLOSE CSR;
DEALLOCATE CSR;
PRINT('Step 8 Groups Set : ' + CONVERT(NVARCHAR(20), GETDATE()));