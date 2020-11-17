
/* W. Dale Miller
 wdalemiller@gmail.com*/
/** USEDFINAnalytics;*/

GO

/* DROP TABLE dbo.DFS_IndexFragProgress*/

IF EXISTS
(
    SELECT 1
    FROM information_schema.tables
    WHERE table_name = 'DFS_IndexFragProgress'
)
drop TABLE dbo.DFS_IndexFragProgress
go
    BEGIN
        PRINT 'Creating TABLE dbo.DFS_IndexFragProgress';
        CREATE TABLE dbo.DFS_IndexFragProgress
        (SqlCmd    VARCHAR(MAX) NULL, 
         DBNAME    NVARCHAR(100), 
         StartTime DATETIME NULL, 
         EndTime   DATETIME NULL, 
         RunID     NVARCHAR(60) NULL, 
         [UID]     UNIQUEIDENTIFIER DEFAULT NEWID(), 
         RowNbr    INT IDENTITY(1, 1) NOT NULL,
        )
        ON [PRIMARY];
        CREATE INDEX idxDFS_DFS_IndexFragProgress
        ON dbo.DFS_IndexFragProgress
        (DBNAME
        );
END;
GO

/* DROP TABLE dbo.DFS_IndexFragErrors*/

IF EXISTS
(
    SELECT 1
    FROM information_schema.tables
    WHERE table_name = 'DFS_IndexFragErrors'
)
    DROP TABLE dbo.DFS_IndexFragErrors;
GO
CREATE TABLE dbo.DFS_IndexFragErrors
(SqlCmd VARCHAR(MAX) NULL, 
 DBNAME NVARCHAR(100), 
 RunID  NVARCHAR(60) NULL, 
 [UID]  UNIQUEIDENTIFIER DEFAULT NEWID(), 
 RowNbr INT IDENTITY(1, 1) NOT NULL,
)
ON [PRIMARY];
CREATE INDEX idxDFS_IndexFragErrors
ON dbo.DFS_IndexFragErrors
(DBNAME
);
CREATE INDEX pxDFS_IndexFragErrors
ON dbo.DFS_IndexFragErrors
(RowNbr
);
GO

/* select top 100 * from DFS_IndexFragHist
 drop TABLE dbo.DFS_IndexFragHist*/

IF EXISTS
(
    SELECT 1
    FROM information_schema.tables
    WHERE table_name = 'DFS_IndexFragHist'
)
drop TABLE dbo.DFS_IndexFragHist
go
    BEGIN
        CREATE TABLE dbo.DFS_IndexFragHist
        (DBName               NVARCHAR(150) NULL, 
         [Schema]             NVARCHAR(150) NOT NULL, 
         [Table]              NVARCHAR(150) NOT NULL, 
         [Index]              NVARCHAR(150) NULL, 
         alloc_unit_type_desc NVARCHAR(60) NULL, 
         IndexProcessed       INTEGER NULL
                                      DEFAULT 0, 
         AvgPctFrag           DECIMAL(8, 2) NULL, 
         page_count           BIGINT NULL, 
         RunDate              DATETIME DEFAULT GETDATE(), 
         RunID                NVARCHAR(60) NULL, 
         Success              INT NULL, 
         [UID]                UNIQUEIDENTIFIER DEFAULT NEWID(), 
         RowNbr               INT IDENTITY(1, 1) NOT NULL
        )
        ON [PRIMARY];
        CREATE INDEX idxRUNIdentifier
        ON dbo.DFS_IndexFragHist
        (RunID
        );
        CREATE INDEX idxIndexPorcessed
        ON dbo.DFS_IndexFragHist
        (IndexProcessed
        );
END;
GO
IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'UTIL_DefragAllIndexes'
)
    BEGIN
        DROP PROCEDURE UTIL_DefragAllIndexes;
END;
GO

/* exec UTIL_DefragAllIndexes 'BNY_Production_NMFP_Data', 'BNYUK_ProductionAR_Port', 30, 0, 1;
exec UTIL_DefragAllIndexes null, null, 30, 0, 1, -1;
*/

CREATE PROCEDURE UTIL_DefragAllIndexes
(@StartingDB   NVARCHAR(100), 
 @EndingDB     NVARCHAR(100), 
 @MaxPct       DECIMAL(6, 2)  = 30, 
 @PreviewOnly  INT           = 1, 
 @ReorgIndexes INT           = 0, 
 @RunID        VARCHAR(60)   = NULL
)
AS

/*IF @EndingDB IS NULL and @StartingDB is null ALL databases are processed
	IF @EndingDB IS NULL and @StartingDB is NOT null only database @StartingDB is processed*/

    BEGIN
        EXEC UTIL_RecordCount 
             N'UTIL_DefragAllIndexes';
        DECLARE @msg NVARCHAR(2000);
        DECLARE @DBNAME NVARCHAR(150);
        IF @RunID IS NULL
            BEGIN
                SET @RunID = '-1';
        END;
        DECLARE @RUNDATE DATETIME= GETDATE();
        DECLARE @Schema NVARCHAR(100), @Table NVARCHAR(100), @Index NVARCHAR(100);
        IF OBJECT_ID('tempdb..#TEMP_CMDS') IS NOT NULL
            BEGIN
                DROP TABLE #TEMP_CMDS;
        END;
        CREATE TABLE #TEMP_CMDS(CMD NVARCHAR(MAX) NOT NULL);
        IF OBJECT_ID('tempdb..#TEMP_DBS2PROCESS') IS NOT NULL
            BEGIN
                DROP TABLE #TEMP_DBS2PROCESS;
        END;
        CREATE TABLE #TEMP_DBS2PROCESS(DBNAME NVARCHAR(100) NOT NULL);
        IF @EndingDB IS NULL
           AND @StartingDB IS NULL
            BEGIN
                INSERT INTO #TEMP_DBS2PROCESS
                       SELECT name
                       FROM sys.databases;
                DELETE FROM #TEMP_DBS2PROCESS
                WHERE DBNAME IN
                (
                    SELECT DB
                    FROM dbo.[DFS_DB2Skip]
                );
        END;
        IF @EndingDB IS NOT NULL
           AND @StartingDB IS NOT NULL
            BEGIN
                INSERT INTO #TEMP_DBS2PROCESS
                       SELECT name
                       FROM sys.databases
                       WHERE name >= @StartingDB
                             AND name <= @EndingDB;
                SELECT *
                FROM #TEMP_DBS2PROCESS;
        END;
        IF @EndingDB IS NOT NULL
           AND @StartingDB IS NULL
            BEGIN
                PRINT 'FATAL ERROR: @StartingDB is null and @EndingDB IS NOT NULL, this is not ALLOWED, aborting';
                RETURN;
        END;
        DELETE FROM #TEMP_DBS2PROCESS
        WHERE DBNAME IN
        (
            SELECT DB
            FROM dbo.[DFS_DB2Skip]
        );
        DECLARE @RowCnt INT;
        SET @RowCnt =
        (
            SELECT COUNT(*) AS #TEMP_DBS2PROCESS
        );
        IF @RowCnt > 0
            BEGIN

                /* DO NOT PROCESS DATABASES CURRENTLY AWAITING PROCESSING*/

                DELETE FROM #TEMP_DBS2PROCESS
                WHERE DBNAME IN
                (
                    SELECT DISTINCT 
                           [DBName]
                    FROM [dbo].[DFS_IndexFragHist]
                    WHERE [IndexProcessed] = 0
                );
                DELETE FROM #TEMP_DBS2PROCESS
                WHERE DBNAME IN
                (
                    SELECT DB
                    FROM dbo.[DFS_DB2Skip]
                );
        END;
        DECLARE @tempstmt NVARCHAR(2000);
        DECLARE xcursor CURSOR
        FOR SELECT DBNAME
            FROM #TEMP_DBS2PROCESS;
        DECLARE @stmt NVARCHAR(2000);
        OPEN xcursor;
        FETCH NEXT FROM xcursor INTO @dbname;
        WHILE @@FETCH_STATUS = 0
            BEGIN
                SET @msg = 'PROCESSING DB: ' + @dbname;
                EXEC sp_printimmediate 
                     @msg;
                SET @msg = 'ReorgIndexes: ' + CAST(@ReorgIndexes AS NVARCHAR(10));
                EXEC sp_printimmediate 
                     @msg;
                SET @stmt = 'INSERT INTO dbo.[DFS_IndexFragProgress] ';
                SET @stmt = @stmt + ' (';
                SET @stmt = @stmt + ' [DBNAME] ';
                SET @stmt = @stmt + ' ,[StartTime] ';
                SET @stmt = @stmt + ' ,[EndTime] ';
                SET @stmt = @stmt + ' ,[RunID]) ';
                SET @stmt = @stmt + ' VALUES ';
                SET @stmt = @stmt + ' (';
                SET @stmt = @stmt + ' ''' + @dbname + '''';
                SET @stmt = @stmt + ' ,getdate() ';
                SET @stmt = @stmt + ' ,null';
                SET @stmt = @stmt + ' ,''' + @RunID + ''');  ';
                SET @stmt = @stmt + 'INSERT INTO dbo.DFS_IndexFragHist ' + CHAR(10) + 'SELECT DB_NAME() AS DBName,
				dbschemas.[name] AS ''Schema'', 
				dbtables.[name] AS ''Table'', 
				dbindexes.[name] AS ''Index'', 
				indexstats.alloc_unit_type_desc,
				0, 
				CAST(indexstats.avg_fragmentation_in_percent AS DECIMAL(6, 2)) AS AvgPctFrag, 
				indexstats.page_count, getdate(), ''' + @RunID + ''',0,newid()
				FROM sys.dm_db_index_physical_stats(DB_ID(), NULL, NULL, NULL, NULL) AS indexstats
				INNER JOIN sys.tables dbtables ON dbtables.[object_id] = indexstats.[object_id]
				INNER JOIN sys.schemas dbschemas ON dbtables.[schema_id] = dbschemas.[schema_id]
				INNER JOIN sys.indexes AS dbindexes ON dbindexes.[object_id] = indexstats.[object_id]
												AND indexstats.index_id = dbindexes.index_id
				WHERE indexstats.database_id = DB_ID()
				AND indexstats.avg_fragmentation_in_percent >= ' + CAST(@MaxPct AS VARCHAR(50)) + '
				ORDER BY indexstats.avg_fragmentation_in_percent DESC; ';
                SET @stmt = @stmt + 'update dbo.[DFS_IndexFragProgress] ';
                SET @stmt = @stmt + '  set EndTime = getdate() where EndTime is null';
                SET @stmt = RTRIM(@stmt);
                IF @PreviewOnly = 0
                    BEGIN
                        SET @stmt = '--* USE' + @dbname + ';' + @stmt;
                        INSERT INTO #TEMP_CMDS ( cmd ) 
                        VALUES
                        (
                               @stmt
                        );
                END;
                IF @PreviewOnly = 1
                    BEGIN
                        INSERT INTO #TEMP_CMDS ( cmd ) 
                    VALUES
                        (
                           '--* USE' + @dbname + ' ; '
                        );
                        INSERT INTO #TEMP_CMDS ( cmd ) 
                        VALUES
                        (
                               @stmt
                        );
                        INSERT INTO #TEMP_CMDS ( cmd ) 
                        VALUES
                        (
                               'GO'
                        );
                END;
                FETCH NEXT FROM xcursor INTO @dbname;
            END;
        CLOSE xcursor;
        DEALLOCATE xcursor;
        DECLARE @ii INT= 0;
        DECLARE @ix INT= 0;
        DECLARE @using NVARCHAR(100);
        DECLARE @CntTot INT=
        (
            SELECT COUNT(*)
            FROM #TEMP_CMDS
        );
        DECLARE xcmd CURSOR
        FOR SELECT CMD
            FROM #TEMP_CMDS;
        OPEN xcmd;
        FETCH NEXT FROM xcmd INTO @stmt;
        WHILE @@FETCH_STATUS = 0
            BEGIN
                SET @ii = @ii + 1;
                SET @stmt = LTRIM(@stmt);
                SET @stmt = RTRIM(@stmt);
                SET @ix = CHARINDEX(';', @stmt);
                SET @using = SUBSTRING(@stmt, 1, @ix);
                SET @msg = 'ANALYZING #' + CAST(@ii AS VARCHAR(10)) + ' of ' + CAST(@CntTot AS VARCHAR(10)) + ' : ' + @using;
                EXEC sp_printimmediate 
                     @msg;
                IF @PreviewOnly = 1
                    BEGIN
                        PRINT @stmt;
                END;
                    ELSE
                    BEGIN
                        BEGIN TRY
                            EXECUTE sp_executesql 
                                    @stmt;
                END TRY
                        BEGIN CATCH
                            SET @msg = '-- **************************************';
                            EXEC sp_printimmediate 
                                 @msg;
                            SET @msg = 'ERR MSG @1: ' +
                            (
                                SELECT ERROR_MESSAGE()
                            );
                            EXEC sp_printimmediate 
                                 @msg;
                            SET @msg = 'ERROR DB: ' + @dbname;
                            EXEC sp_printimmediate 
                                 @msg;
                            SET @msg = 'ERROR: ' + @stmt;
                            EXEC sp_printimmediate 
                                 @msg;
                            PRINT '***********************************************';
                END CATCH;
                END;
                FETCH NEXT FROM xcmd INTO @stmt;
            END;
        CLOSE xcmd;
        DEALLOCATE xcmd;
        DELETE FROM dbo.DFS_IndexFragHist
        WHERE DBName IN
        (
            SELECT name
            FROM sys.databases
            WHERE [state] != 0
        )
              AND IndexProcessed = 0;
        IF @PreviewOnly = 1
            BEGIN
                INSERT INTO #TEMP_CMDS ( cmd ) 
            VALUES
                (
                   'SELECT * FROM dbo.DFS_IndexFragHist where IndexProcessed != 1;'
                );
        END;
        IF @ReorgIndexes = 1
            BEGIN
                EXEC sp_UTIL_ReorgFragmentedIndexes 
                     @PreviewOnly;
        END;
    END;