
GO

/* drop table DFS_DBSpace */

IF NOT EXISTS
(
    SELECT 1
    FROM sys.tables
    WHERE name = 'DFS_DBSpace'
)
    BEGIN
        CREATE TABLE DFS_DBSpace
        (SVR                 NVARCHAR(150) NULL, 
         database_name       NVARCHAR(150) NULL, 
         database_size       NVARCHAR(150) NULL, 
         [unallocated space] NVARCHAR(150) NULL, 
         reserved            NVARCHAR(150) NULL, 
         [data]              NVARCHAR(150) NULL, 
         index_size          NVARCHAR(150) NULL, 
         unused              NVARCHAR(150) NULL, 
         CreateDate          DATETIME DEFAULT GETDATE() NOT NULL, 
         [UID]               UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL
        );
END;
GO
IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'UTIL_DBSpace'
)
    BEGIN
        DROP PROCEDURE UTIL_DBSpace;
END;
GO

/*
exec UTIL_DBSpace
SELECT * FROM DFS_DBSpace 
*/

CREATE PROCEDURE UTIL_DBSpace
AS
    BEGIN
        BEGIN
            BEGIN TRY
                CREATE TABLE #DFS_DBSpace
                (database_name       NVARCHAR(150) NULL, 
                 database_size       NVARCHAR(150) NULL, 
                 [unallocated space] NVARCHAR(150) NULL, 
                 reserved            NVARCHAR(150) NULL, 
                 [data]              NVARCHAR(150) NULL, 
                 index_size          NVARCHAR(150) NULL, 
                 unused              NVARCHAR(150) NULL
                );
            END TRY
            BEGIN CATCH
                TRUNCATE TABLE #DFS_DBSpace;
            END CATCH;
            INSERT INTO #DFS_DBSpace
            EXEC sp_spaceused 
                 @oneresultset = 1;
            INSERT INTO DFS_DBSpace
                   SELECT @@servername AS SVR, 
                          database_name, 
                          database_size, 
                          [unallocated space], 
                          reserved, 
                          [data], 
                          index_size, 
                          unused, 
                          GETDATE() AS CreateDate, 
                          NEWID() AS [UID]
                   FROM #DFS_DBSpace;
        END;
    END;
GO

/*******************************************************************************
 drop table DFS_DBTableSpace*/

IF not EXISTS
(
    SELECT 1
    FROM sys.tables
    WHERE name = 'DFS_DBTableSpace'
)
    BEGIN
        CREATE TABLE DFS_DBTableSpace
        (SVR        NVARCHAR(150) NULL, 
         DBName     NVARCHAR(150) NULL, 
         [name]     NVARCHAR(150) NULL, 
         [rows]     NVARCHAR(150) NULL, 
         reserved   NVARCHAR(150) NULL, 
         [data]     NVARCHAR(150) NULL, 
         index_size NVARCHAR(150) NULL, 
         unused     NVARCHAR(150) NULL, 
         CreateDate DATETIME DEFAULT GETDATE() NOT NULL, 
         [UID]      UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL
        );
END; 
GO
IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'UTIL_DBTableSpace'
)
    BEGIN
        DROP PROCEDURE UTIL_DBTableSpace;
END;
GO

/* exec UTIL_DBTableSpace*/

CREATE PROCEDURE UTIL_DBTableSpace
AS
    BEGIN
        BEGIN
            BEGIN TRY
                CREATE TABLE #TgtTables([tblname] NVARCHAR(250) NULL, );
            END TRY
            BEGIN CATCH
                TRUNCATE TABLE #TgtTables;
            END CATCH;
            INSERT INTO #TgtTables
                   SELECT S.name + '.' + T.name AS tblname
                   FROM sys.tables T
                             JOIN sys.schemas S
                             ON S.schema_id = T.schema_id;
            BEGIN TRY
                CREATE TABLE #DFS_DBTableSpace
                ([name]     NVARCHAR(150) NULL, 
                 [rows]     NVARCHAR(150) NULL, 
                 reserved   NVARCHAR(150) NULL, 
                 [data]     NVARCHAR(150) NULL, 
                 index_size NVARCHAR(150) NULL, 
                 unused     NVARCHAR(150) NULL
                );
            END TRY
            BEGIN CATCH
                TRUNCATE TABLE #DFS_DBTableSpace;
            END CATCH;
            DECLARE @name NVARCHAR(250)= '';
            DECLARE db_cursor CURSOR
            FOR SELECT tblname
                FROM #TgtTables;
            OPEN db_cursor;
            FETCH NEXT FROM db_cursor INTO @name;
            WHILE @@FETCH_STATUS = 0
                BEGIN
                    TRUNCATE TABLE #DFS_DBTableSpace;

                    /************************************************/

                    INSERT INTO #DFS_DBTableSpace
                    EXEC sp_spaceused 
                         @name;
                    INSERT INTO DFS_DBTableSpace
                           SELECT @@servername AS SVR, 
                                  DB_NAME() AS DBName, 
                                  [name], 
                                  [rows], 
                                  reserved, 
                                  [data], 
                                  index_size, 
                                  unused, 
                                  GETDATE() AS CreateDate, 
                                  NEWID() AS [UID]
                           FROM #DFS_DBTableSpace;

                    /************************************************/

                    FETCH NEXT FROM db_cursor INTO @name;
                END;
            CLOSE db_cursor;
            DEALLOCATE db_cursor;
        END;

        /*SELECT * FROM DFS_DBTableSpace;*/

    END;