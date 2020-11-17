
/*
-- W. Dale Miller
-- wdalemiller@gmail.com

declare @cmd nvarchar(1000) ;
set @cmd = '--* USE?; exec UTIL_IO_BoundQry2000 ; exec UTIL_CPU_BoundQry2000 ;'
exec sp_msForEachDB @cmd ;
*/
/** USEDFINAnalytics;*/

GO
IF EXISTS
(
    SELECT 1
    FROM sys.tables
    WHERE name = 'DFS_IO_BoundQry'
)
    DROP TABLE [dbo].[DFS_IO_BoundQry];
BEGIN
    CREATE TABLE [dbo].[DFS_IO_BoundQry]
    ([SVRName]                [NVARCHAR](250) NULL, 
     [DBName]                 [NVARCHAR](250) NULL, 
     [text]                   [NVARCHAR](MAX) NULL, 
     [query_plan]             [XML] NULL, 
     [sql_handle]             [VARBINARY](64) NOT NULL, 
     [statement_start_offset] [INT] NOT NULL, 
     [statement_end_offset]   [INT] NOT NULL, 
     [plan_generation_num]    [BIGINT] NULL, 
     [plan_handle]            [VARBINARY](64) NOT NULL, 
     [creation_time]          [DATETIME] NULL, 
     [last_execution_time]    [DATETIME] NULL, 
     [execution_count]        [BIGINT] NOT NULL, 
     [total_worker_time]      [BIGINT] NOT NULL, 
     [last_worker_time]       [BIGINT] NOT NULL, 
     [min_worker_time]        [BIGINT] NOT NULL, 
     [max_worker_time]        [BIGINT] NOT NULL, 
     [total_physical_reads]   [BIGINT] NOT NULL, 
     [last_physical_reads]    [BIGINT] NOT NULL, 
     [min_physical_reads]     [BIGINT] NOT NULL, 
     [max_physical_reads]     [BIGINT] NOT NULL, 
     [total_logical_writes]   [BIGINT] NOT NULL, 
     [last_logical_writes]    [BIGINT] NOT NULL, 
     [min_logical_writes]     [BIGINT] NOT NULL, 
     [max_logical_writes]     [BIGINT] NOT NULL, 
     [total_logical_reads]    [BIGINT] NOT NULL, 
     [last_logical_reads]     [BIGINT] NOT NULL, 
     [min_logical_reads]      [BIGINT] NOT NULL, 
     [max_logical_reads]      [BIGINT] NOT NULL, 
     [total_clr_time]         [BIGINT] NOT NULL, 
     [last_clr_time]          [BIGINT] NOT NULL, 
     [min_clr_time]           [BIGINT] NOT NULL, 
     [max_clr_time]           [BIGINT] NOT NULL, 
     [total_elapsed_time]     [BIGINT] NOT NULL, 
     [last_elapsed_time]      [BIGINT] NOT NULL, 
     [min_elapsed_time]       [BIGINT] NOT NULL, 
     [max_elapsed_time]       [BIGINT] NOT NULL, 
     [query_hash]             [BINARY](8) NULL, 
     [query_plan_hash]        [BINARY](8) NULL, 
     [total_rows]             [BIGINT] NULL, 
     [last_rows]              [BIGINT] NULL, 
     [min_rows]               [BIGINT] NULL, 
     [max_rows]               [BIGINT] NULL, 
     [statement_sql_handle]   [VARBINARY](64) NULL, 
     [statement_context_id]   [BIGINT] NULL, 
     [total_dop]              [BIGINT] NULL, 
     [last_dop]               [BIGINT] NULL, 
     [min_dop]                [BIGINT] NULL, 
     [max_dop]                [BIGINT] NULL, 
     [total_grant_kb]         [BIGINT] NULL, 
     [last_grant_kb]          [BIGINT] NULL, 
     [min_grant_kb]           [BIGINT] NULL, 
     [max_grant_kb]           [BIGINT] NULL, 
     [total_used_grant_kb]    [BIGINT] NULL, 
     [last_used_grant_kb]     [BIGINT] NULL, 
     [min_used_grant_kb]      [BIGINT] NULL, 
     [max_used_grant_kb]      [BIGINT] NULL, 
     [total_ideal_grant_kb]   [BIGINT] NULL, 
     [last_ideal_grant_kb]    [BIGINT] NULL, 
     [min_ideal_grant_kb]     [BIGINT] NULL, 
     [max_ideal_grant_kb]     [BIGINT] NULL, 
     [total_reserved_threads] [BIGINT] NULL, 
     [last_reserved_threads]  [BIGINT] NULL, 
     [min_reserved_threads]   [BIGINT] NULL, 
     [max_reserved_threads]   [BIGINT] NULL, 
     [total_used_threads]     [BIGINT] NULL, 
     [last_used_threads]      [BIGINT] NULL, 
     [min_used_threads]       [BIGINT] NULL, 
     [max_used_threads]       [BIGINT] NULL, 
     [RunDate]                [DATETIME] NULL, 
     [RunID]                  [BIGINT] NULL, 
     [UID]                    [UNIQUEIDENTIFIER] NOT NULL, 
     [Processed]              [INT] NULL
    )
    ON [PRIMARY];
    ALTER TABLE [dbo].[DFS_IO_BoundQry]
    ADD DEFAULT(NEWID()) FOR [UID];
    ALTER TABLE [dbo].[DFS_IO_BoundQry]
    ADD DEFAULT((0)) FOR [Processed];
    CREATE INDEX pkDFS_IO_BoundQry
    ON DFS_IO_BoundQry
    (SvrName, DBName, query_hash, query_plan_hash
    );
END;
IF EXISTS
(
    SELECT 1
    FROM sys.tables
    WHERE name = 'DFS_IO_BoundQry2000'
)
    DROP TABLE [dbo].[DFS_IO_BoundQry2000];
IF NOT EXISTS
(
    SELECT 1
    FROM sys.tables
    WHERE name = 'DFS_IO_BoundQry2000'
)
    BEGIN
        CREATE TABLE [dbo].[DFS_IO_BoundQry2000]
        ([SVRName]                         [NVARCHAR](250) NULL, 
         [DBName]                          [VARCHAR](250) NOT NULL, 
         [text]                            [NVARCHAR](MAX) NULL, 
         [query_plan]                      [XML] NULL, 
         [sql_handle]                      [VARBINARY](64) NOT NULL, 
         [statement_start_offset]          [INT] NOT NULL, 
         [statement_end_offset]            [INT] NOT NULL, 
         [plan_generation_num]             [BIGINT] NULL, 
         [plan_handle]                     [VARBINARY](64) NOT NULL, 
         [creation_time]                   [DATETIME] NULL, 
         [last_execution_time]             [DATETIME] NULL, 
         [execution_count]                 [BIGINT] NOT NULL, 
         [total_worker_time]               [BIGINT] NOT NULL, 
         [last_worker_time]                [BIGINT] NOT NULL, 
         [min_worker_time]                 [BIGINT] NOT NULL, 
         [max_worker_time]                 [BIGINT] NOT NULL, 
         [total_physical_reads]            [BIGINT] NOT NULL, 
         [last_physical_reads]             [BIGINT] NOT NULL, 
         [min_physical_reads]              [BIGINT] NOT NULL, 
         [max_physical_reads]              [BIGINT] NOT NULL, 
         [total_logical_writes]            [BIGINT] NOT NULL, 
         [last_logical_writes]             [BIGINT] NOT NULL, 
         [min_logical_writes]              [BIGINT] NOT NULL, 
         [max_logical_writes]              [BIGINT] NOT NULL, 
         [total_logical_reads]             [BIGINT] NOT NULL, 
         [last_logical_reads]              [BIGINT] NOT NULL, 
         [min_logical_reads]               [BIGINT] NOT NULL, 
         [max_logical_reads]               [BIGINT] NOT NULL, 
         [total_clr_time]                  [BIGINT] NOT NULL, 
         [last_clr_time]                   [BIGINT] NOT NULL, 
         [min_clr_time]                    [BIGINT] NOT NULL, 
         [max_clr_time]                    [BIGINT] NOT NULL, 
         [total_elapsed_time]              [BIGINT] NOT NULL, 
         [last_elapsed_time]               [BIGINT] NOT NULL, 
         [min_elapsed_time]                [BIGINT] NOT NULL, 
         [max_elapsed_time]                [BIGINT] NOT NULL, 
         [query_hash]                      [BINARY](8) NULL, 
         [query_plan_hash]                 [BINARY](8) NULL, 
         [total_rows]                      [BIGINT] NULL, 
         [last_rows]                       [BIGINT] NULL, 
         [min_rows]                        [BIGINT] NULL, 
         [max_rows]                        [BIGINT] NULL, 
         [statement_sql_handle]            [VARBINARY](64) NULL, 
         [statement_context_id]            [BIGINT] NULL, 
         [total_dop]                       [BIGINT] NULL, 
         [last_dop]                        [BIGINT] NULL, 
         [min_dop]                         [BIGINT] NULL, 
         [max_dop]                         [BIGINT] NULL, 
         [total_grant_kb]                  [BIGINT] NULL, 
         [last_grant_kb]                   [BIGINT] NULL, 
         [min_grant_kb]                    [BIGINT] NULL, 
         [max_grant_kb]                    [BIGINT] NULL, 
         [total_used_grant_kb]             [BIGINT] NULL, 
         [last_used_grant_kb]              [BIGINT] NULL, 
         [min_used_grant_kb]               [BIGINT] NULL, 
         [max_used_grant_kb]               [BIGINT] NULL, 
         [total_ideal_grant_kb]            [BIGINT] NULL, 
         [last_ideal_grant_kb]             [BIGINT] NULL, 
         [min_ideal_grant_kb]              [BIGINT] NULL, 
         [max_ideal_grant_kb]              [BIGINT] NULL, 
         [total_reserved_threads]          [BIGINT] NULL, 
         [last_reserved_threads]           [BIGINT] NULL, 
         [min_reserved_threads]            [BIGINT] NULL, 
         [max_reserved_threads]            [BIGINT] NULL, 
         [total_used_threads]              [BIGINT] NULL, 
         [last_used_threads]               [BIGINT] NULL, 
         [min_used_threads]                [BIGINT] NULL, 
         [max_used_threads]                [BIGINT] NULL, 
         [total_columnstore_segment_reads] [BIGINT] NULL, 
         [last_columnstore_segment_reads]  [BIGINT] NULL, 
         [min_columnstore_segment_reads]   [BIGINT] NULL, 
         [max_columnstore_segment_reads]   [BIGINT] NULL, 
         [total_columnstore_segment_skips] [BIGINT] NULL, 
         [last_columnstore_segment_skips]  [BIGINT] NULL, 
         [min_columnstore_segment_skips]   [BIGINT] NULL, 
         [max_columnstore_segment_skips]   [BIGINT] NULL, 
         [total_spills]                    [BIGINT] NULL, 
         [last_spills]                     [BIGINT] NULL, 
         [min_spills]                      [BIGINT] NULL, 
         [max_spills]                      [BIGINT] NULL, 
         [RunDate]                         [DATETIME] NOT NULL, 
         [SSVER]                           [NVARCHAR](300) NULL, 
         [RunID]                           [INT] NOT NULL, 
         [UID]                             [UNIQUEIDENTIFIER] NULL, 
         [processed]                       [INT] NOT NULL
        )
        ON [PRIMARY];
        ALTER TABLE [dbo].[DFS_IO_BoundQry2000]
        ADD DEFAULT(NEWID()) FOR [UID];
        ALTER TABLE [dbo].[DFS_IO_BoundQry2000]
        ADD DEFAULT((0)) FOR [Processed];
        CREATE INDEX pkDFS_IO_BoundQry2000
        ON DFS_IO_BoundQry2000
        (SvrName, DBName, query_hash, query_plan_hash
        );
END;
IF EXISTS
(
    SELECT 1
    FROM sys.tables
    WHERE name = 'DFS_CPU_BoundQry2000'
)
    BEGIN
        DROP TABLE DFS_CPU_BoundQry2000;
END;
IF NOT EXISTS
(
    SELECT 1
    FROM sys.tables
    WHERE name = 'DFS_CPU_BoundQry2000'
)
    BEGIN
        CREATE TABLE [dbo].[DFS_CPU_BoundQry2000]
        ([SVRName]                         [NVARCHAR](250) NULL, 
         [DBName]                          [NVARCHAR](250) NULL, 
         [text]                            [NVARCHAR](MAX) NULL, 
         [query_plan]                      [XML] NULL, 
         [sql_handle]                      [VARBINARY](64) NOT NULL, 
         [statement_start_offset]          [INT] NOT NULL, 
         [statement_end_offset]            [INT] NOT NULL, 
         [plan_generation_num]             [BIGINT] NULL, 
         [plan_handle]                     [VARBINARY](64) NOT NULL, 
         [creation_time]                   [DATETIME] NULL, 
         [last_execution_time]             [DATETIME] NULL, 
         [execution_count]                 [BIGINT] NOT NULL, 
         [total_worker_time]               [BIGINT] NOT NULL, 
         [last_worker_time]                [BIGINT] NOT NULL, 
         [min_worker_time]                 [BIGINT] NOT NULL, 
         [max_worker_time]                 [BIGINT] NOT NULL, 
         [total_physical_reads]            [BIGINT] NOT NULL, 
         [last_physical_reads]             [BIGINT] NOT NULL, 
         [min_physical_reads]              [BIGINT] NOT NULL, 
         [max_physical_reads]              [BIGINT] NOT NULL, 
         [total_logical_writes]            [BIGINT] NOT NULL, 
         [last_logical_writes]             [BIGINT] NOT NULL, 
         [min_logical_writes]              [BIGINT] NOT NULL, 
         [max_logical_writes]              [BIGINT] NOT NULL, 
         [total_logical_reads]             [BIGINT] NOT NULL, 
         [last_logical_reads]              [BIGINT] NOT NULL, 
         [min_logical_reads]               [BIGINT] NOT NULL, 
         [max_logical_reads]               [BIGINT] NOT NULL, 
         [total_clr_time]                  [BIGINT] NOT NULL, 
         [last_clr_time]                   [BIGINT] NOT NULL, 
         [min_clr_time]                    [BIGINT] NOT NULL, 
         [max_clr_time]                    [BIGINT] NOT NULL, 
         [total_elapsed_time]              [BIGINT] NOT NULL, 
         [last_elapsed_time]               [BIGINT] NOT NULL, 
         [min_elapsed_time]                [BIGINT] NOT NULL, 
         [max_elapsed_time]                [BIGINT] NOT NULL, 
         [query_hash]                      [BINARY](8) NULL, 
         [query_plan_hash]                 [BINARY](8) NULL, 
         [total_rows]                      [BIGINT] NULL, 
         [last_rows]                       [BIGINT] NULL, 
         [min_rows]                        [BIGINT] NULL, 
         [max_rows]                        [BIGINT] NULL, 
         [statement_sql_handle]            [VARBINARY](64) NULL, 
         [statement_context_id]            [BIGINT] NULL, 
         [total_dop]                       [BIGINT] NULL, 
         [last_dop]                        [BIGINT] NULL, 
         [min_dop]                         [BIGINT] NULL, 
         [max_dop]                         [BIGINT] NULL, 
         [total_grant_kb]                  [BIGINT] NULL, 
         [last_grant_kb]                   [BIGINT] NULL, 
         [min_grant_kb]                    [BIGINT] NULL, 
         [max_grant_kb]                    [BIGINT] NULL, 
         [total_used_grant_kb]             [BIGINT] NULL, 
         [last_used_grant_kb]              [BIGINT] NULL, 
         [min_used_grant_kb]               [BIGINT] NULL, 
         [max_used_grant_kb]               [BIGINT] NULL, 
         [total_ideal_grant_kb]            [BIGINT] NULL, 
         [last_ideal_grant_kb]             [BIGINT] NULL, 
         [min_ideal_grant_kb]              [BIGINT] NULL, 
         [max_ideal_grant_kb]              [BIGINT] NULL, 
         [total_reserved_threads]          [BIGINT] NULL, 
         [last_reserved_threads]           [BIGINT] NULL, 
         [min_reserved_threads]            [BIGINT] NULL, 
         [max_reserved_threads]            [BIGINT] NULL, 
         [total_used_threads]              [BIGINT] NULL, 
         [last_used_threads]               [BIGINT] NULL, 
         [min_used_threads]                [BIGINT] NULL, 
         [max_used_threads]                [BIGINT] NULL, 
         [total_columnstore_segment_reads] [BIGINT] NULL, 
         [last_columnstore_segment_reads]  [BIGINT] NULL, 
         [min_columnstore_segment_reads]   [BIGINT] NULL, 
         [max_columnstore_segment_reads]   [BIGINT] NULL, 
         [total_columnstore_segment_skips] [BIGINT] NULL, 
         [last_columnstore_segment_skips]  [BIGINT] NULL, 
         [min_columnstore_segment_skips]   [BIGINT] NULL, 
         [max_columnstore_segment_skips]   [BIGINT] NULL, 
         [total_spills]                    [BIGINT] NULL, 
         [last_spills]                     [BIGINT] NULL, 
         [min_spills]                      [BIGINT] NULL, 
         [max_spills]                      [BIGINT] NULL, 
         [RunDate]                         [DATETIME] NOT NULL, 
         [SSVer]                           [NVARCHAR](300) NULL, 
         [RunID]                           [INT] NOT NULL, 
         [UID]                             [UNIQUEIDENTIFIER] NULL, 
         [Processed]                       [INT] NOT NULL
        )
        ON [PRIMARY];
        ALTER TABLE [dbo].[DFS_CPU_BoundQry2000]
        ADD DEFAULT(NEWID()) FOR [UID];
        ALTER TABLE [dbo].[DFS_CPU_BoundQry2000]
        ADD DEFAULT((0)) FOR [Processed];
        CREATE INDEX pkDFS_CPU_BoundQry2000
        ON DFS_CPU_BoundQry2000
        (SvrName, DBName, query_hash, query_plan_hash
        );
END;
GO

/*SELECT '[' + column_name + '],' FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'DFS_CPU_BoundQry2000';
 drop table dbo.[DFS_CPU_BoundQry2000]
performance bottleneck
is it CPU or I/O bound? If your performance bottleneck is CPU bound, Find trhe top 5 worst 
performing queries regarding CPU consumption with the following query:
 Worst performing CPU bound queries

exec sp_UTIL_MSTR_BoundQry2000
exec UTIL_CPU_BoundQry2000 
wdmxx

 */

GO
IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'UTIL_CPU_BoundQry2000'
)
    BEGIN
        DROP PROCEDURE UTIL_CPU_BoundQry2000;
END;
GO
CREATE PROCEDURE UTIL_CPU_BoundQry2000(@NextID BIGINT = NULL)
AS
    BEGIN
		DECLARE @s NVARCHAR(MAX);
		DECLARE @dbug as int = 0 ;
		declare @zcnt as int = 0;
        DECLARE @RunDate AS DATETIME= GETDATE();
        DECLARE @msg VARCHAR(100);
        DECLARE @DBNAME VARCHAR(100)= DB_NAME();
        IF @NextID IS NULL
            BEGIN
                EXEC @NextID = [dbo].[sp_UTIL_GetSeq];
        END;
        IF EXISTS
        (
            SELECT 1
            FROM dbo.[DFS_DB2Skip]
            WHERE @DBNAME = [DB]
        )
            BEGIN
                SET @msg = 'SKIPPING: ' + @DBNAME;
                EXEC sp_printimmediate 
                     @msg;
                RETURN;
        END;
        SET @msg = 'UTIL CPU DB: ' + @DBNAME;
        EXEC sp_printimmediate 
             @msg;
        IF OBJECT_ID('tempdb..#DFS_CPU_BoundQry2000') IS NOT NULL
            BEGIN
                DROP TABLE #DFS_CPU_BoundQry2000;
        END;
        SELECT TOP 10 @@SERVERNAME AS SVRName, 
                      DB_NAME() AS DBName, 
                      st.text, 
                      qp.query_plan, 
                      qs.*, 
                      GETDATE() AS RunDate, 
                      @@VERSION AS SSVer, 
                      15 AS RunID, 
                      NEWID() AS [UID], 
                      0 AS Processed
        INTO [#DFS_CPU_BoundQry2000]
        FROM sys.dm_exec_query_stats AS qs
                  CROSS APPLY sys.dm_exec_sql_text(qs.plan_handle) AS st
                       CROSS APPLY sys.dm_exec_query_plan(qs.plan_handle) AS qp
        ORDER BY total_worker_time DESC;

		if (@dbug = 1 AND OBJECT_ID('tempdb..#DFS_CPU_BoundQry2000') IS NOT NULL)
		begin
			set @zcnt = (select count(*) from [#DFS_CPU_BoundQry2000]) ;
			print '#DFS_CPU_BoundQry2000 COUNT: ' + cast(@zcnt as nvarchar(50));
		end;

		if ( OBJECT_ID('tempdb..#DFS_CPU_BoundQry2000') IS NOT NULL)
		begin
			WITH cteExisting
			AS (
				SELECT distinct SvrName, DbName, query_hash, query_plan_hash
				FROM DFS_QryOptStatsHistory
				)
			DELETE t1
			FROM #DFS_CPU_BoundQry2000 t1 
			INNER JOIN cteExisting ts 
				ON t1.SVRName = ts.SvrName
				and t1.DBName = ts.DbName
				and t1.query_hash = ts.query_hash
				and t1.query_plan_hash = ts.query_plan_hash;
		end 
		if (@dbug = 1 AND OBJECT_ID('tempdb..#DFS_CPU_BoundQry2000') IS NOT NULL)
		begin
			print '#ROWS Already exists: ' + cast(@@rowcount as nvarchar(50)) ;
			set @zcnt = (select count(*) from [#DFS_CPU_BoundQry2000]) ;
			print '#DFS_CPU_BoundQry2000 COUNT: ' + cast(@zcnt as nvarchar(50));
		end 
        
        SET @s = dbo.genInsertSql('#DFS_CPU_BoundQry2000', 'dbo.DFS_CPU_BoundQry2000');
        EXECUTE sp_executesql @s;
    END;
GO
IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'UTIL_IO_BoundQry2000'
)
    BEGIN
        DROP PROCEDURE UTIL_IO_BoundQry2000;
END;
GO

/*
select count(*) from information_schema.columns where table_name = 'TEMP_FS_IO_BoundQry2016'
exec UTIL_IO_BoundQry2000 -99 ;
drop table #DFS_IO_BoundQry2000
*/
/*
EXEC UTIL_IO_BoundQry2000 -99
*/
CREATE PROCEDURE UTIL_IO_BoundQry2000(@NextID BIGINT = NULL)
AS
    BEGIN
        BEGIN TRY
            DROP TABLE #DFS_IO_BoundQry2000;
        END TRY
        BEGIN CATCH
            PRINT 'drop #DFS_IO_BoundQry2000';
        END CATCH;

        /*declare @NextID BIGINT = -99;*/

		declare @dbug as int = 0 ;
		declare @zcnt as int = 0 ;
		
        DECLARE @ver NVARCHAR(MAX)= @@version;
        PRINT @ver;
        DECLARE @IsAzure INT= 0;
        IF CHARINDEX('Azure', @ver) > 0
            SET @IsAzure = 1;
            ELSE
            SET @IsAzure = 0;
        DECLARE @msg VARCHAR(100);
        DECLARE @DBNAME VARCHAR(100)= DB_NAME();
        IF @NextID IS NULL
            BEGIN
                EXEC @NextID = [dbo].[sp_UTIL_GetSeq];
        END;
        DECLARE @RunDate AS DATETIME= GETDATE();
        IF EXISTS
        (
            SELECT 1
            FROM dbo.[DFS_DB2Skip]
            WHERE @DBNAME = [DB]
        )
            BEGIN
                SET @msg = 'SKIPPING: ' + @DBNAME;
                EXEC sp_printimmediate 
                     @msg;
                RETURN;
        END;
        SET @msg = 'UTIL IO DB: ' + @DBNAME;
        EXEC sp_printimmediate 
             @msg;
        SELECT TOP 10 @@SERVERNAME AS SVRName, 
                      DB_NAME() AS DBName, 
                      st.text, 
                      qp.query_plan, 
                      qs.*, 
                      GETDATE() AS RunDate, 
                      @@version AS SSVER, 
                      @NextID AS RunID, 
                      NEWID() AS [UID], 
                      0 AS processed
        INTO #DFS_IO_BoundQry2000
        FROM sys.dm_exec_query_stats AS qs
                  CROSS APPLY sys.dm_exec_sql_text(qs.plan_handle) AS st
                       CROSS APPLY sys.dm_exec_query_plan(qs.plan_handle) AS qp
        ORDER BY total_logical_reads DESC;
        DECLARE @s NVARCHAR(MAX);
        DECLARE @tempcolcnt INT=
        (
            SELECT COUNT(*)
            FROM tempdb.sys.columns
            WHERE object_id = OBJECT_ID('tempdb..#DFS_IO_BoundQry2000')
        );

		if (@dbug = 1)
		begin
			set @zcnt = (select count(*) from [#DFS_IO_BoundQry2000]) ;
			print '#DFS_CPU_BoundQry2000 COUNT: ' + cast(@zcnt as nvarchar(50));
		end;

		WITH cteExisting
		AS (
			SELECT distinct SvrName, DbName, query_hash, query_plan_hash
			FROM DFS_QryOptStatsHistory
			)
		DELETE t1
		FROM #DFS_IO_BoundQry2000 t1 
		INNER JOIN cteExisting ts 
			ON t1.SVRName = ts.SvrName
			and t1.DBName = ts.DbName
			and t1.query_hash = ts.query_hash
			and t1.query_plan_hash = ts.query_plan_hash;
		
		if (@dbug = 1)
		begin
			print '#ROWS Already exists: ' + cast(@@rowcount as nvarchar(50)) ;
			set @zcnt = (select count(*) from [#DFS_IO_BoundQry2000]) ;
			print '#DFS_IO_BoundQry2000 COUNT: ' + cast(@zcnt as nvarchar(50));
		end 

        SET @s = dbo.genInsertSql('#DFS_IO_BoundQry2000', 'dbo.DFS_IO_BoundQry2000');
        EXECUTE sp_executesql 
                @s;
    END;
GO
IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'sp_UTIL_MSTR_BoundQry2000'
)
    BEGIN
        DROP PROCEDURE sp_UTIL_MSTR_BoundQry2000;
END;
GO

/*
	exec sp_UTIL_MSTR_BoundQry2000 ;	
*/
CREATE PROCEDURE sp_UTIL_MSTR_BoundQry2000
AS
    BEGIN

		DECLARE @NextID AS INT= 0;
		EXEC @NextID = [dbo].[sp_UTIL_GetSeq];

        EXEC UTIL_UpdateQryPlansAndText 'DFS_CPU_BoundQry2000';
        EXEC UTIL_UpdateQryPlansAndText 'DFS_IO_BoundQry2000';
        EXEC UTIL_UpdateQryPlansAndText 'DFS_CPU_BoundQry';
        EXEC UTIL_UpdateQryPlansAndText 'DFS_IO_BoundQry';
		
        EXEC UTIL_CPU_BoundQry2000 @NextID;
        EXEC UTIL_IO_BoundQry2000 @NextID;
		
        EXEC UTIL_UpdateQryPlansAndText 'DFS_CPU_BoundQry2000';
        EXEC UTIL_UpdateQryPlansAndText 'DFS_IO_BoundQry2000';
        EXEC UTIL_UpdateQryPlansAndText 'DFS_CPU_BoundQry';
        EXEC UTIL_UpdateQryPlansAndText 'DFS_IO_BoundQry';

		exec UTIL_Process_QrysPlans;
		exec UTIL_QryOptStatsHistory;
		

    END;
GO

/* DMA, Limited
 Offered under GNU License
 July 26, 2016
 */