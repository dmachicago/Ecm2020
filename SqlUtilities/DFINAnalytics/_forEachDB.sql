

DROP TABLE #TempDB;

CREATE TABLE #TempDB ( 
             SNO    INT IDENTITY(1 , 1) , 
             [Name] VARCHAR(100)
                     );

INSERT INTO #TempDB ( [Name]
                    ) 
       SELECT Name
       FROM sys.sysdatabases;

DECLARE @i INT;

DECLARE @Count INT;

DECLARE @Stmt VARCHAR(4000);

DECLARE @Name VARCHAR(100);

SET @i = 0;

SELECT @Count = COUNT(*)
FROM #TempDB;

/*SELECT @Name=[Name] FROM #TempDB*/

WHILE @i < @Count
    BEGIN
        SET @i = @i + 1;
        SELECT @Name = Name
        FROM #TempDB
        WHERE Sno = @i;
        SET @Stmt = 'sp_UTIL_TrackTblReadsWrites ' + CAST(@i AS NVARCHAR(10));
        EXEC (@Stmt);

        /*PRINT @Stmt*/

    END;

SELECT *
FROM DFINAnalytics.dbo.[DFS_TableReadWrites];