--***************************************************************************
--Author:	  W. Dale Miller
--Contact:  wdalemiller@gmail.com
--Date:		Jan. 2, 2012
--Updateed: Jan. 4, 2019
--Purpose:  Find Duplicate Indexes across a server
--Use:	    Modify the variable @TgtDB and execute the script.
--		    Set the name of the DB to limit the return to a single DB
--		    Comment out the WHERE clause portion of @TgtDB to process 
--			ALL databases on the server.
--***************************************************************************

DECLARE @TgtDB NVARCHAR(250)= 'AW2016';

SET NOCOUNT ON;

DECLARE @First [SMALLINT] , @Last [SMALLINT] , @DBName [NVARCHAR](128) , @SQLServer [NVARCHAR](128) , @StringToExecuteP1 [NVARCHAR](MAX) , @StringToExecuteP2 [NVARCHAR](MAX) , @StringToExecuteP3 [NVARCHAR](MAX);

IF OBJECT_ID('tempdb..#DUPLICATE_INDEXES_INFO') IS NOT NULL
    BEGIN
        DROP TABLE #DUPLICATE_INDEXES_INFO;
END;

CREATE TABLE #DUPLICATE_INDEXES_INFO ( 
             [Server]             [NVARCHAR](128) , 
             [Database]           [NVARCHAR](128) , 
             [TableName]          [VARCHAR](256) , 
             [IndexName]          [VARCHAR](256) , 
             [IndexType]          [VARCHAR](13) , 
             [KeyColumns]         [VARCHAR](512) , 
             [NonKeyColumns]      [VARCHAR](512) , 
             [KeyColumnsOrder]    [VARCHAR](512) , 
             [NonKeyColumnsOrder] [VARCHAR](512) , 
             [IsUnique]           [CHAR](1) , 
             [HasNonKeyColumns]   [CHAR](1) , 
             [CheckDate]          [DATETIME]
                                     );

IF OBJECT_ID('Tempdb..#Indexes') IS NOT NULL
    BEGIN
        DROP TABLE #Indexes;
END;

CREATE TABLE #Indexes ( 
             [RowNo]     [SMALLINT] IDENTITY(1 , 1) , 
             [TableName] [VARCHAR](256) , 
             [IndexName] [VARCHAR](256) , 
             [IsUnique]  [SMALLINT] , 
             [IndexType] [VARCHAR](13)
                      );

IF OBJECT_ID('Tempdb..#AllIndexesInfo') IS NOT NULL
    BEGIN
        DROP TABLE #AllIndexesInfo;
END;

CREATE TABLE #AllIndexesInfo ( 
             [ObjectID]        [INT] NOT NULL , 
             [TableName]       [NVARCHAR](128) NULL , 
             [IndexID]         [INT] NOT NULL , 
             [IndexName]       [SYSNAME] NULL , 
             [IndexType]       [VARCHAR](13) NOT NULL , 
             [ColumnID]        [INT] NOT NULL , 
             [ColumnName]      [SYSNAME] NULL , 
             [IncludedColumns] [BIT] NULL , 
             [IsUnique]        [BIT] NULL
                             );

IF OBJECT_ID('Tempdb..#AllIndexesDetailedInfo') IS NOT NULL
    BEGIN
        DROP TABLE #AllIndexesDetailedInfo;
END;

CREATE TABLE #AllIndexesDetailedInfo ( 
             [TableName]          [VARCHAR](256) , 
             [IndexName]          [VARCHAR](256) , 
             [IndexType]          [VARCHAR](13) , 
             [KeyColumns]         [VARCHAR](512) , 
             [NonKeyColumns]      [VARCHAR](512) , 
             [KeyColumnsOrder]    [VARCHAR](512) , 
             [NonKeyColumnsOrder] [VARCHAR](512) , 
             [IsUnique]           [CHAR](1) , 
             [HasNonKeyColumns]   [CHAR](1)
                                     );

DECLARE @DatabaseList TABLE ( 
                            [RowNo]  [SMALLINT] IDENTITY(1 , 1) , 
                            [DBName] [VARCHAR](200)
                            );

SELECT @SQLServer = CAST(SERVERPROPERTY('ServerName') AS [NVARCHAR](128));

INSERT INTO @DatabaseList
       SELECT [name]
       FROM [master].[sys].[databases] WITH(NOLOCK)
       WHERE [state_desc] = 'ONLINE'
             AND 
             [source_database_id] IS NULL
             AND 
             [database_id] > 4;
--AND name = @TgtDB;
--Comment out the above line to do all databases

SELECT @First = MIN([@DatabaseList].RowNo)
FROM @DatabaseList;

SELECT @Last = MAX([@DatabaseList].RowNo)
FROM @DatabaseList;

WHILE @First <= @Last
    BEGIN
        SELECT @DBName = [@DatabaseList].DBName
        FROM @DatabaseList
        WHERE [@DatabaseList].RowNo = @First;
        SET @StringToExecuteP1 = 'USE [' + @DBName + '];
		INSERT INTO #AllIndexesInfo
				   ([ObjectID]
				   ,[TableName]
				   ,[IndexID]
				   ,[IndexName]
				   ,[IndexType]
				   ,[ColumnID]
				   ,[ColumnName]
				   ,[IncludedColumns]
				   ,[IsUnique])
		SELECT o.[object_id] AS [ObjectID]
			  ,OBJECT_NAME(o.[object_id]) AS [TableName]
			  ,i.[index_id] AS [IndexID]
			  ,i.[name] AS [IndexName]
			  ,CASE i.[type]
				WHEN 0
					THEN ''Heap''
				WHEN 1
					THEN ''Clustered''
				WHEN 2
					THEN ''Non-Clustered''
				WHEN 3
					THEN ''XML''
				ELSE ''Unknown''
				END AS [IndexType]
			,ic.[column_id] AS [ColumnID]
			,c.[name] AS [ColumnName]
			,ic.[is_included_column] [IncludedColumns]
			,i.[is_unique] AS [IsUnique]
		FROM [' + @DBName + '].[sys].[indexes] i
		INNER JOIN [' + @DBName + '].[sys].[objects] o 
			ON i.[object_id] = o.[object_id]
				AND o.[type] = ''U''
				AND i.[index_id] > 0
		INNER JOIN [' + @DBName + '].[sys].[index_columns] ic 
			ON i.[index_id] = ic.[index_id]
				AND i.[object_id] = ic.[object_id]
		INNER JOIN [' + @DBName + '].[sys].[columns] c 
			ON c.[column_id] = ic.[column_id]
				AND c.[object_id] = ic.[object_id]
			
		INSERT INTO #Indexes
		SELECT DISTINCT [TableName]
			,[IndexName]
			,[IsUnique]
			,[IndexType]
		FROM #AllIndexesInfo';
        EXEC (@StringToExecuteP1);
        SET @StringToExecuteP2 = 'USE [' + @DBName + '];
		DECLARE @First				[smallint]
			   ,@Last				[smallint]
			   ,@IsUnique			[smallint]
			   ,@HasNonKeyCols		[char] (1)
			   ,@TableName			[varchar] (256)
			   ,@IndexName			[varchar] (256)
			   ,@IndexType			[varchar] (13)
			   ,@IndexColumns		[varchar] (2000)
			   ,@IncludedColumns	[varchar] (2000)
			   ,@IndexColsOrder		[varchar] (2000)
			   ,@IncludedColsOrder  [varchar] (2000)

		SELECT @First = MIN([RowNo])
		FROM #Indexes

		SELECT @Last = MAX([RowNo])
		FROM #Indexes

		WHILE @First <= @Last
		BEGIN
			SET @IndexColumns = NULL
			SET @IncludedColumns = NULL
			SET @IncludedColsOrder = NULL
			SET @IndexColsOrder = NULL

			SELECT @TableName = [TableName]
				  ,@IndexName = [IndexName]
				  ,@IsUnique  = [IsUnique]
				  ,@IndexType = [IndexType]
			FROM #Indexes
			WHERE [RowNo] = @First

			SELECT @IndexColumns = COALESCE(@IndexColumns + '', '', '''') 
										+ [ColumnName]
			FROM #AllIndexesInfo
			WHERE [TableName] = @TableName
				AND [IndexName] = @IndexName
				AND [IncludedColumns] = 0
			ORDER BY [IndexName]
					,[ColumnName]

			SELECT @IncludedColumns = COALESCE(@IncludedColumns + '', '', '''') 
										+ [ColumnName]
			FROM #AllIndexesInfo
			WHERE [TableName] = @TableName
				AND [IndexName] = @IndexName
				AND [IncludedColumns] = 1
			ORDER BY [IndexName]
					,[ColumnName]

			SELECT @IndexColsOrder = COALESCE(@IndexColsOrder + '', '', '''') 
										+ [ColumnName]
			FROM #AllIndexesInfo
			WHERE [TableName] = @TableName
				AND [IndexName] = @IndexName
				AND [IncludedColumns] = 0

			SELECT @IncludedColsOrder = COALESCE(@IncludedColsOrder + '', '', '''') 
										+ [ColumnName]
			FROM #AllIndexesInfo
			WHERE [TableName] = @TableName
				AND [IndexName] = @IndexName
				AND [IncludedColumns] = 1

			SET @HasNonKeyCols = ''N''

			IF @IncludedColumns IS NOT NULL
			BEGIN
				SET @HasNonKeyCols = ''Y''
			END

			INSERT INTO #AllIndexesDetailedInfo (
				[TableName]
				,[IndexName]
				,[IndexType]
				,[IsUnique]
				,[KeyColumns]
				,[KeyColumnsOrder]
				,[HasNonKeyColumns]
				,[NonKeyColumns]
				,[NonKeyColumnsOrder]
				)
			SELECT @TableName
				,@IndexName
				,@IndexType
				,CASE @IsUnique
					WHEN 1
						THEN ''Y''
					WHEN 0
						THEN ''N''
					END
				,@IndexColumns
				,@IndexColsOrder
				,@HasNonKeyCols
				,@IncludedColumns
				,@IncludedColsOrder

			SET @First = @First + 1
		END';
        EXEC (@StringToExecuteP2);
        SET @StringToExecuteP3 = 'USE [' + @DBName + '];
	  INSERT INTO [tempdb].[dbo].[DUPLICATE_INDEXES_INFO]
			   ([Server]
			   ,[Database]
			   ,[TableName]
			   ,[IndexName]
			   ,[IndexType]
	   		   ,[KeyColumns]
			   ,[HasNonKeyColumns]
			   ,[NonKeyColumns]
			   ,[KeyColumnsOrder]
			   ,[NonKeyColumnsOrder]
			   ,[IsUnique]
			   ,[CheckDate])
		SELECT  ''' + @SQLServer + '''
			   ,''' + @DBName + '''
			   ,[TableName]
			   ,[IndexName]
			   ,[IndexType]
	   		   ,[KeyColumns]
			   ,[HasNonKeyColumns]
			   ,[NonKeyColumns]
			   ,[KeyColumnsOrder]
			   ,[NonKeyColumnsOrder]
			   ,[IsUnique]
			   ,CURRENT_TIMESTAMP
		FROM
		(
		  SELECT DISTINCT 
			 a1.[TableName]
			,a1.[IndexName]
			,a1.[IndexType]
			,a1.[KeyColumns]
			,a1.[HasNonKeyColumns]
			,a1.[NonKeyColumns]
			,a1.[KeyColumnsOrder]
			,a1.[NonKeyColumnsOrder]
			,a1.[IsUnique]
		  FROM #AllIndexesDetailedInfo a1
		  INNER JOIN #AllIndexesDetailedInfo a2 
			ON a1.[TableName] = a2.TableName
			 AND a1.[IndexName] <> a2.[IndexName]
			 AND a1.[KeyColumns] = a2.[KeyColumns]
			 AND ISNULL(a1.[NonKeyColumns], '''') = ISNULL(a2.[NonKeyColumns], '''')
		  WHERE a1.[IndexType] <> ''XML''
		 ) a ';
        EXEC (@StringToExecuteP3);
        TRUNCATE TABLE #Indexes;
        TRUNCATE TABLE #AllIndexesInfo;
        TRUNCATE TABLE #AllIndexesDetailedInfo;
        SET @First = @First + 1;
    END;

SELECT [Server] , [Database] , 'If exists (select name from sys.indexes where name = ''' + IndexName + ''')' + CHAR(13) + CHAR(10) + 'BEGIN ' + CHAR(13) + CHAR(10) + 'Drop Index ' + QUOTENAME(IndexName) + ' ON ' + QUOTENAME(TableName) + CHAR(13) + CHAR(10) + 'END ' + CHAR(13) + CHAR(10) AS DropStmt , [TableName] , [IndexName] , [IndexType] , [KeyColumns] , [NonKeyColumns] , [KeyColumnsOrder] , [NonKeyColumnsOrder] , [IsUnique] , [HasNonKeyColumns] , [CheckDate]
FROM [tempdb].[dbo].[DUPLICATE_INDEXES_INFO];
--where [Database] = 'KenticoCMS_Prod3'
--  and (IndexName like 'PI%' 
--	OR IndexName like '%PI' 
--	OR IndexName like 'CI%' 
--	OR IndexName like '%CI')
--	AND [Database] = 'KenticoCMS_Prod3'

SET NOCOUNT OFF;

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016