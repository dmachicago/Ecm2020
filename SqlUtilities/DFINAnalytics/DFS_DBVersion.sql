
/** USEDFINAnalytics;*/

GO

/* select * from  DFS_DBVersion*/

IF EXISTS
(
    SELECT name
    FROM sys.tables
    WHERE name = 'DFS_DBVersion'
)
    DROP TABLE DFS_DBVersion;
GO
CREATE TABLE DFS_DBVersion
([SVRName] [NVARCHAR](150) NULL, 
 [DBName]  [NVARCHAR](150) NULL, 
 [SSVER]   [NVARCHAR](250) NOT NULL, 
 [SSVERID] UNIQUEIDENTIFIER NOT NULL
  DEFAULT NEWID(), 
 [UID]     UNIQUEIDENTIFIER NOT NULL
  DEFAULT NEWID(),
);
CREATE UNIQUE INDEX PK_DFS_DBVersion
ON DFS_DBVersion
([SSVERID]
) INCLUDE([SSVER]);
GO
IF EXISTS
(
    SELECT name
    FROM sys.procedures
    WHERE name = 'UTIL_DFS_DBVersion'
)
    DROP PROCEDURE UTIL_DFS_DBVersion;
GO

/* exec UTIL_DFS_DBVersion
 select * from DFS_DBVersion*/

CREATE PROCEDURE UTIL_DFS_DBVersion
AS
    BEGIN
 DECLARE @SSVER NVARCHAR(150)= @@version;
 DECLARE @SSID NVARCHAR(60);
 DECLARE @ID INT;
 IF EXISTS
 (
     SELECT [SSVERID]
     FROM DFS_DBVersion
     WHERE [SSVER] = @SSVER
 )
     BEGIN
  SET @SSID =
  (
 SELECT [SSVERID]
 FROM DFS_DBVersion
 WHERE [SSVER] = @SSVER
  );
 END;
     ELSE
     BEGIN
  SET @SSID = NEWID();
  INSERT INTO DFS_DBVersion
  ( [SVRName], 
    [DBName], 
    [SSVER], 
    [SSVERID]
  ) 
  VALUES
  (
    @@servername
  , DB_NAME()
  , @@version
  , CAST(@SSID AS NVARCHAR(60))
  );
  SET @SSVER =
  (
 SELECT [SSVERID]
 FROM DFS_DBVersion
 WHERE [SSVER] = @SSVER
  );
 END;
 PRINT @SSVER;
    END;
GO
EXEC UTIL_DFS_DBVersion;
GO