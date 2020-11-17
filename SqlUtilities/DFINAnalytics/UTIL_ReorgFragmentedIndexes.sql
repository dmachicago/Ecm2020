
/* W. Dale Miller
 wdalemiller@gmail.com*/

--* USEDFINAnalytics;
GO
DECLARE @runnow INT= 0;
IF @runnow = 1
    BEGIN

/*declare @RunID BIGINT = NEXT VALUE FOR master_seq;
		truncate TABLE [dbo].[DFS_IndexStats];
		select top 100 * from [dbo].[DFS_IndexStats];
		*/
 DECLARE @command VARCHAR(1000);
 SELECT @command = '--* USE?; exec sp_UTIL_ReorgFragmentedIndexes 0;';
 EXEC sp_MSforeachdb 
 @command;
END;
GO

/*drop TABLE [dbo].DFS_IndexFragReorgHistory*/

IF NOT EXISTS
(
    SELECT 1
    FROM information_schema.tables
    WHERE table_name = 'DFS_IndexFragReorgHistory'
)
    BEGIN
 CREATE TABLE [dbo].DFS_IndexFragReorgHistory
 ([DBName] [NVARCHAR](150) NULL, 
  [Schema] NVARCHAR(150) NOT NULL, 
  [Table]  NVARCHAR(150) NOT NULL, 
  [Index]  NVARCHAR(150) NULL, 
  [OnlineReorg] [VARCHAR](10) NULL, 
  [Success]     [VARCHAR](10) NULL, 
  Rundate  DATETIME NULL, 
  RunID  NVARCHAR(60) NULL, 
  Stmt   VARCHAR(MAX) NULL, 
		 [UID] uniqueidentifier default newid(),
  RowNbr INT IDENTITY(1, 1) NOT NULL
 )
 ON [PRIMARY];
 ALTER TABLE [dbo].DFS_IndexFragReorgHistory
 ADD DEFAULT(GETDATE()) FOR [RunDate];
END;

/****** Object:  StoredProcedure [dbo].[sp_UTIL_ReorgFragmentedIndexes]    Script Date: 1/10/2019 4:27:24 PM ******/

GO

/* select * FROM dbo.DFS_IndexFragHist 
 exec sp_UTIL_ReorgFragmentedIndexes 'B5E6A690-F150-44E2-BF57-AB4765A94357', 0*/

--* USEmaster;
GO
IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'sp_UTIL_ReorgFragmentedIndexes'
)
    BEGIN
 DROP PROCEDURE sp_UTIL_ReorgFragmentedIndexes;
END;
GO

/* EXEC sp_UTIL_ReorgFragmentedIndexes 0;*/

CREATE PROCEDURE [dbo].[sp_UTIL_ReorgFragmentedIndexes](@PreviewOnly INT = 1)
AS
    BEGIN
	IF CURSOR_STATUS('global','CursorReorg')>=-1
	BEGIN
	 DEALLOCATE CursorReorg
	END
 /********************CLEAN UP THE INDEXES TO BE PROCESSED *****************		  */

 DELETE FROM [dbo].[DFS_IndexFragHist]
 WHERE [Index] IS NULL;
 DELETE FROM [dbo].[DFS_IndexFragHist]
 WHERE EXISTS
 (
     SELECT *
     FROM [dbo].[DFS_IndexFragHist] AS b
     WHERE b.[DBName] = [dbo].[DFS_IndexFragHist].[DBName]
    AND b.[Schema] = [dbo].[DFS_IndexFragHist].[Schema]
    AND b.[Table] = [dbo].[DFS_IndexFragHist].[Table]
    AND b.[Index] = [dbo].[DFS_IndexFragHist].[Index]
    AND b.IndexProcessed = [dbo].[DFS_IndexFragHist].[IndexProcessed]
     GROUP BY b.[DBName], 
  b.[Schema], 
  b.[Table], 
  b.[Index], 
  b.IndexProcessed
     HAVING [dbo].[DFS_IndexFragHist].[RowNbr] > MIN(b.[RowNbr])
 );

 /********************************************************************************/

 DECLARE @msg NVARCHAR(2000);
 DECLARE @RunID VARCHAR(60);
 DECLARE @stmt NVARCHAR(2000);
 DECLARE @Rownbr INT;
 DECLARE @TotCnt INT;
 DECLARE @i INT= 0;
 DECLARE @dbname NVARCHAR(100);
 DECLARE @Schema NVARCHAR(100), @Table NVARCHAR(100), @Index NVARCHAR(100);
 SET @TotCnt =
 (
     SELECT COUNT(*)
     FROM [dbo].[DFS_IndexFragHist]
     WHERE IndexProcessed = 0
 );
 DELETE FROM [dbo].[DFS_IndexFragHist]
 WHERE DBNAME IN
 (
     SELECT DB
     FROM dbo.[DFS_DB2Skip]
 );
 DECLARE CursorReorg CURSOR
 FOR SELECT DBName, 
     [Schema], 
     [Table], 
     [Index], 
     Rownbr, 
     RunID
     FROM dbo.DFS_IndexFragHist
     WHERE IndexProcessed != 1
    AND [index] IS NOT NULL;
 OPEN CursorReorg;
 FETCH NEXT FROM CursorReorg INTO @DBName, @Schema, @Table, @Index, @Rownbr, @RunID;
 WHILE @@FETCH_STATUS = 0
     BEGIN
  SET @i = @i + 1;
  SET @msg = '#' + CAST(@i AS NVARCHAR(10)) + ' of ' + CAST(@TotCnt AS NVARCHAR(10));
  SET @msg = 'REORGANIZE: ' + @DBName + '.' + @Schema + '.' + @Table + ' / ' + @Index;
  EXEC sp_PrintImmediate 
  @msg;
  SET @stmt = 'ALTER Index ' + @Index + ' ON ' + @DBName + '.' + @Schema + '.' + @Table;

  /*SET @stmt = @stmt + ' REORGANIZE ';*/

  SET @stmt = @stmt + ' REBUILD WITH ';
  SET @stmt = @stmt + '(';
  SET @stmt = @stmt + '  FILLFACTOR = 80 ';
  SET @stmt = @stmt + '  ,ONLINE = ON ';
  SET @stmt = @stmt + ');';
  IF @PreviewOnly = 1
 BEGIN
   PRINT('Preview: ' + @stmt);
  END;
  IF @PreviewOnly = 0
 BEGIN
   BEGIN TRY
  SET @msg = 'Starting the REBUILD: ON ' + @DBName + '.' + @Schema + '.' + @Table;
  EXEC sp_PrintImmediate 
     @msg;
  EXECUTE sp_executesql 
   @stmt;
  BEGIN TRY
    INSERT INTO [dbo].[DFS_IndexFragReorgHistory]
    ( [DBName], 
 [Schema], 
 [Table], 
 [Index], 
 [OnlineReorg], 
 [Success], 
 [Rundate], 
 [RunID], 
 [Stmt]
    ) 
    VALUES
    (
      @DBName
    , @Schema
    , @Table
    , @Index
    , 'YES'
    , 'YES'
    , GETDATE()
    , @RunID
    , @stmt
    );
  END TRY
  BEGIN CATCH
    SET @msg = 'FAILED TO SAVE HISTORY:';
    SET @msg = @msg + '|' + @DBName;
    SET @msg = @msg + '.' + @Schema;
    SET @msg = @msg + '.' + @Table;
    SET @msg = @msg + '.' + @Index;
    SET @msg = @msg + ' @' + @stmt;
    SET @msg = @msg + '@';
    EXEC sp_PrintImmediate 
    @msg;
    SET @msg = 'ERR MSG @0: ' +
    (
   SELECT ERROR_MESSAGE()
    );
    EXEC sp_PrintImmediate 
    @msg;
  END CATCH;
  END TRY
   BEGIN CATCH
  SET @msg = '-- **************************************';
  EXEC sp_PrintImmediate 
     @msg;
  SET @msg = 'ERR MSG @1: ' +
  (
    SELECT ERROR_MESSAGE()
  );
  EXEC sp_PrintImmediate 
     @msg;
  SET @msg = 'CURRENT DB: ' + @dbname;
  EXEC sp_PrintImmediate 
     @msg;
  SET @msg = 'ERROR: ' + @stmt;
  EXEC sp_PrintImmediate 
     @msg;
  BEGIN TRY
    SET @stmt = 'ALTER Index ' + @Index + ' ON ' + @DBName + '.' + @Schema + '.' + @Table;
    SET @stmt = @stmt + ' reorganize;';

/*SET @stmt = 'ALTER Index ' + @Index + ' ON ' + @DBName + '.' + @Schema + '.' + @Table;
    SET @stmt = @stmt + ' reorganize;';*/

    EXECUTE sp_executesql 
     @stmt;
    PRINT '-- **************************************';
    SET @msg = 'Reorganize : ' + @stmt;
    EXEC sp_PrintImmediate 
    @msg;
    PRINT '-- **************************************';
    INSERT INTO [dbo].[DFS_IndexFragReorgHistory]
    ( [DBName], 
 [Schema], 
 [Table], 
 [Index], 
 [OnlineReorg], 
 [Success], 
 [Rundate], 
 [RunID], 
 [Stmt]
    ) 
    VALUES
    (
      @DBName
    , @Schema
    , @Table
    , @Index
    , 'NO @1'
    , 'YES'
    , GETDATE()
    , @RunID
    , @stmt
    );
  END TRY
  BEGIN CATCH
    SET @msg = 'ERR MSG: ' +
    (
   SELECT ERROR_MESSAGE()
    );
    EXEC sp_PrintImmediate 
    @msg;
    INSERT INTO [dbo].[DFS_IndexFragErrors]
    ( [SqlCmd], 
 DBNAME
    ) 
    VALUES
    (
      @stmt
    , @DBName
    );
    INSERT INTO [dbo].[DFS_IndexFragReorgHistory]
    ( [DBName], 
 [Schema], 
 [Table], 
 [Index], 
 [OnlineReorg], 
 [Success], 
 [Rundate], 
 [RunID], 
 [Stmt]
    ) 
    VALUES
    (
      @DBName
    , @Schema
    , @Table
    , @Index
    , 'NO @2'
    , 'NO'
    , GETDATE()
    , @RunID
    , @stmt
    );
  END CATCH;
  END CATCH;
  END;
  IF @PreviewOnly = 0
 BEGIN
   UPDATE [dbo].[DFS_IndexFragHist]
     SET 
    IndexProcessed = 1
   WHERE RowNbr = @Rownbr;
  END;
  FETCH NEXT FROM CursorReorg INTO @DBName, @Schema, @Table, @Index, @Rownbr, @RunID;
     END;
 CLOSE CursorReorg;
 DEALLOCATE CursorReorg;
    END;