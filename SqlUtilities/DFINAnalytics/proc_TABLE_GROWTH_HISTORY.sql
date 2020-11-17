
/*proc_TABLE_GROWTH_HISTORY.sql*/

GO

/** USEDFINAnalytics;*/

GO

/* drop table dbo.DFS_TableGrowthHistory*/

IF NOT EXISTS
(
    SELECT name
    FROM sys.tables
    WHERE name = 'DFS_TableGrowthHistory'
)
    BEGIN
        CREATE TABLE dbo.DFS_TableGrowthHistory
        (SvrName     NVARCHAR(150) NOT NULL, 
         DBName      NVARCHAR(150) NOT NULL, 
         Table_name  NVARCHAR(150) NOT NULL, 
         NbrRows     INT NOT NULL, 
         EntryDate   DATETIME DEFAULT GETDATE(), 
         RunID       BIGINT NOT NULL, 
         TableSchema NVARCHAR(50) NULL, 
         [UID]       UNIQUEIDENTIFIER NULL
                                      DEFAULT NEWID(), 
         RowId       INT IDENTITY(1, 1) NOT NULL
        );
END;
GO
IF NOT EXISTS
(
    SELECT 1
    FROM sys.sequences
    WHERE name = 'master_seq'
)
    BEGIN
        CREATE SEQUENCE master_seq
             AS BIGINT
             START WITH 1
             INCREMENT BY 1
             MINVALUE 1
             MAXVALUE 999999999
             NO CYCLE
             CACHE 10;
END;
GO
IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'UTIL_TableGrowthHistory'
)
    BEGIN
        DROP PROCEDURE UTIL_TableGrowthHistory;
END;
	GO

/* exec UTIL_TableGrowthHistory*/

CREATE PROCEDURE dbo.UTIL_TableGrowthHistory
AS
    BEGIN
        SET NOCOUNT ON;
        DECLARE @TblToCount TABLE
        (SchemaTbl VARCHAR(250), 
         cnt       BIGINT NULL
        );
        DECLARE @TBLS TABLE
        (schema_name VARCHAR(250), 
         table_name  VARCHAR(250), 
         pk_name     VARCHAR(250), 
         columns     VARCHAR(2000),
         UNIQUE NONCLUSTERED(schema_name, table_name)
        );
        INSERT INTO @TBLS
               SELECT SCHEMA_NAME(tab.schema_id) AS schema_name, 
                      tab.name AS table_name, 
                      pk.name AS pk_name, 
                      SUBSTRING(column_names, 1, LEN(column_names) - 1) AS columns
               FROM sys.tables AS tab
                         LEFT OUTER JOIN sys.indexes AS pk
                         ON tab.object_id = pk.object_id
                            AND pk.is_primary_key = 1
                              CROSS APPLY
               (
                   SELECT col.name + ', '
                   FROM sys.index_columns AS ic
                             INNER JOIN sys.columns AS col
                             ON ic.object_id = col.object_id
                                AND ic.column_id = col.column_id
                   WHERE ic.object_id = tab.object_id
                         AND ic.index_id = pk.index_id
                   ORDER BY col.column_id FOR XML PATH('')
               ) AS D(column_names)
               ORDER BY SCHEMA_NAME(tab.schema_id), 
                        tab.name;
        UPDATE @TBLS
          SET 
              pk_name = '@'
        WHERE pk_name IS NULL;

/*select * from @TBLS
	DECLARE @RUNID BIGINT= NEXT VALUE FOR master_seq;*/

        DECLARE @RUNID BIGINT;
        EXEC @RunID = dbo.UTIL_GetSeq;
        DECLARE @i INT= 0;
        DECLARE @itot INT= 0;
        DECLARE @icnt INT= 0;
        DECLARE @msg NVARCHAR(1000)= '';
        DECLARE @mysql NVARCHAR(2000)= '';
        SET NOCOUNT ON;

/*select top 100 * from information_schema.tables 
	select top 100 * from information_schema.columns */

        SET @itot =
        (
            SELECT COUNT(*)
            FROM information_schema.tables AS T
            WHERE T.table_type <> 'view'

        /*and column_name = 'dbname'*/

        );
        DECLARE @TSchema VARCHAR(50);
        DECLARE @rowcount TABLE(Value INT);

/*DECLARE db_cursor CURSOR
	FOR SELECT DISTINCT 
	    T.table_name, 
	    T.TABLE_SCHEMA
	    FROM information_schema.tables T
	  JOIN information_schema.columns C ON T.table_name = C.table_name
	    WHERE table_type <> 'view'
	    --and column_name = 'dbname'
	    ORDER BY T.TABLE_NAME;*/

        DECLARE db_cursor CURSOR
        FOR SELECT schema_name, 
                   table_name, 
                   pk_name
            FROM @TBLS;
        DECLARE @pkname NVARCHAR(150)= NULL;
        DECLARE @name NVARCHAR(150)= NULL;
        DECLARE @irec INT= 0;
        OPEN db_cursor;
        FETCH NEXT FROM db_cursor INTO @TSchema, @name, @pkname;
        WHILE @@FETCH_STATUS = 0
            BEGIN
                DECLARE @FQN NVARCHAR(500)= @TSchema + '.' + @name;
                SET @i = @i + 1;

                /*EXEC sp_printimmediate  '-------------------------------';*/

                SET @msg = 'Processing ' + @FQN + ' : ' + CAST(@i AS NVARCHAR(50)) + ' of ' + CAST(@itot AS NVARCHAR(50));

                /*EXEC sp_printimmediate @msg;*/

                IF @pkname != '@'
                    BEGIN
                        EXEC @irec = proc_quickRowCount 
                             @name, 
                             @TSchema;
                        SET @msg = 'ROW CNT @1: ' + CAST(@irec AS NVARCHAR(50));

                        /*EXEC sp_printimmediate @msg;*/

                END;
                    ELSE
                    BEGIN
                        DECLARE @STMT VARCHAR(500), @RowCnt INT, @SQL NVARCHAR(1000);

                        /*SELECT @STMT = 'from ' + @fqn;*/

                        SELECT @SQL = N'SELECT @RowCnt = COUNT(*) from ' + @fqn;
                        EXEC sp_executesql 
                             @SQL, 
                             N'@RowCnt INT OUTPUT', 
                             @RowCnt OUTPUT;
                        SET @irec = @RowCnt;
                        SET @msg = 'ROW CNT @2: ' + CAST(@irec AS NVARCHAR(50));

                        /*EXEC sp_printimmediate @msg;*/

                END;
                INSERT INTO dbo.DFS_TableGrowthHistory
                ( SvrName, 
                  DBName, 
                  Table_name, 
                  NbrRows, 
                  RUNID, 
                  TableSchema
                ) 
                VALUES
                (
                       @@SERVERNAME
                     , DB_NAME()
                     , @name
                     , @irec
                     , @RUNID
                     , @TSchema
                );
                FETCH NEXT FROM db_cursor INTO @TSchema, @name, @pkname;
            END;
        CLOSE db_cursor;
        DEALLOCATE db_cursor;
        SET NOCOUNT OFF;

/* W. Dale Miller
	 DMA, Limited
	 Offered under GNU License
	 July 26, 2016*/

    END;
GO