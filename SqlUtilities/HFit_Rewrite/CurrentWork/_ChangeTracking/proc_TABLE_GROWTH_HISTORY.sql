USE DFINAnalytics;
GO

/****** Object:  StoredProcedure [dbo].[UTIL_TableGrowthHistory]    Script Date: 2/15/2017 7:46:17 AM ******/

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

-- select top 1008 * from DFS_TableGrowthHistory where NbrRows > 0 order by table_name
-- select top 1008 * from DFS_TableGrowthHistory where NbrRows > 0 order by NbrRows desc, table_name

if exists (select 1 from sys.procedures where name = 'UTIL_TableGrowthHistory')
	drop PROCEDURE dbo.UTIL_TableGrowthHistory;
go


--exec UTIL_TableGrowthHistory
CREATE PROCEDURE dbo.UTIL_TableGrowthHistory
AS
BEGIN
    IF NOT EXISTS (SELECT name
                     FROM sys.tables
                     WHERE name = 'DFS_TableGrowthHistory') 
        BEGIN
            CREATE TABLE DFS_TableGrowthHistory (Table_name nvarchar (250) NOT NULL
                                             , NbrRows int NOT NULL
                                             , EntryDate datetime DEFAULT GETDATE ()) ;
        END;

    DECLARE
           @i int = 0;
    DECLARE
           @itot int = 0;
    DECLARE
           @icnt int = 0;
    DECLARE
           @irecs int = 0;
    DECLARE
           @msg nvarchar (1000) = '';
    DECLARE
           @mysql nvarchar (2000) = '';

    SET NOCOUNT ON;

    SET @itot = (SELECT COUNT (*)
                   FROM information_schema.tables T
                        JOIN
                        information_schema.columns C
                        ON T.table_name = C.table_name
                   WHERE column_name = 'dbname'
                     AND table_type <> 'view'
                     AND T.table_name LIKE 'BASE[_]%'
                     AND t.table_name NOT LIKE 'VIEW[_]%') ;
    DECLARE
           @rowcount TABLE (Value int) ;

    DECLARE db_cursor CURSOR
        FOR SELECT T.table_name
              FROM information_schema.tables T
                   JOIN
                   information_schema.columns C
                   ON T.table_name = C.table_name
              WHERE column_name = 'dbname'
                AND table_type <> 'view'
                AND T.table_name LIKE 'BASE[_]%'
                AND t.table_name NOT LIKE 'VIEW[_]%'
                AND t.table_name NOT LIKE 'BASE_HFit_GoalOutcome%'
              ORDER BY T.TABLE_NAME;

    DECLARE
           @name nvarchar (254) = NULL;

    OPEN db_cursor;
    FETCH NEXT FROM db_cursor INTO @name;

    WHILE @@FETCH_STATUS = 0
        BEGIN
            SET @i = @i + 1;
            EXEC PrintImmediate '-------------------------------';
            SET @msg = 'Processing ' + @name + ' : ' + CAST (@i AS nvarchar (50)) + ' of ' + CAST (@itot AS nvarchar (50)) ;
            EXEC PrintImmediate @msg;
            EXEC @irecs = proc_quickRowCount @name;
            INSERT INTO DFS_TableGrowthHistory (Table_name
                                            , NbrRows) 
            VALUES
                   (@name, @irecs) ;

            FETCH NEXT FROM db_cursor INTO @name;
        END;

    CLOSE db_cursor;
    DEALLOCATE db_cursor;
END;
GO


