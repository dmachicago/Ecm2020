--* USEmaster;
GO
IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'sp_ckProcessDB'
)
    DROP PROCEDURE sp_ckProcessDB;
GO
CREATE PROCEDURE sp_ckProcessDB
AS
    BEGIN
 DECLARE @DBNAME NVARCHAR(100)= DB_NAME();
 IF @DBName = 'model'
     BEGIN
  PRINT 'SKIPPING: ' + @DBNAME;
  RETURN 0;
 END;
 IF @DBName = 'msdb'
     BEGIN
  PRINT 'SKIPPING: ' + @DBNAME;
  RETURN 0;
 END;
 IF @DBName = 'tempdb'
     BEGIN
  PRINT 'SKIPPING: ' + @DBNAME;
  RETURN 0;
 END;
 IF @DBName = 'master'
     BEGIN
  PRINT 'SKIPPING: ' + @DBNAME;
  RETURN 0;
 END;
 RETURN 1;
    END;