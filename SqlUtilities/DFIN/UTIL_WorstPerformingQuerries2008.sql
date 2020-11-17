-- W. Dale Miller
-- wdalemiller@gmail.com

USE [DFINAnalytics];
--JOB_UTIL_IO_BoundQry
--JOB_UTIL_CPU_BoundQry
-- exec sp_UTIL_CPU_BoundQry2000
-- exec sp_UTIL_IO_BoundQry2000
--SELECT '[' + column_name + '],' FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'DFS_IO_BoundQry2000';
-- drop table DFINAnalytics.dbo.[DFS_IO_BoundQry2000]

IF NOT EXISTS
(
    SELECT 1
    FROM   INFORMATION_SCHEMA.tables
    WHERE  TABLE_NAME = 'DFS_DB2Skip'
)
    CREATE TABLE DFINAnalytics.dbo.[DFS_DB2Skip]
    (DB nvarchar(100)
    );
GO

IF NOT EXISTS
(
    SELECT 1
    FROM   INFORMATION_SCHEMA.tables
    WHERE  TABLE_NAME = 'DFS_SEQ'
)
    CREATE TABLE DFINAnalytics.dbo.[DFS_SEQ]
    (GenDate DATETIME DEFAULT GETDATE(), 
     SeqID   INT IDENTITY(1, 1) NOT NULL
    );
GO


USE master;
go
IF EXISTS
(
    SELECT 1
    FROM   sys.procedures
    WHERE  name = 'sp_UTIL_GetSeq'
)
    DROP PROCEDURE sp_UTIL_GetSeq;
GO
CREATE PROCEDURE sp_UTIL_GetSeq
AS
    BEGIN
        INSERT INTO DFINAnalytics.dbo.[DFS_SEQ](GenDate)
    VALUES(getdate());
        DECLARE @id INT=
        (
            SELECT MAX(SeqID)
            FROM   DFINAnalytics.dbo.[DFS_SEQ]
        );
        RETURN @id;
    END;
GO

USE [DFINAnalytics];
go

--drop TABLE [dbo].[DFS_IO_BoundQry2000]
IF NOT EXISTS
(
    SELECT 1
    FROM   INFORMATION_SCHEMA.tables
    WHERE  TABLE_NAME = 'DFS_IO_BoundQry2000'
)
    CREATE TABLE [dbo].[DFS_IO_BoundQry2000]
    ([SVRName]                [NVARCHAR](128) NULL, 
     [DBName]                 [NVARCHAR](128) NULL, 
     [text]                   [NVARCHAR](MAX) NULL, 
     [query_plan]             [XML] NULL, 
     [sql_handle]             [VARBINARY](64) NOT NULL, 
     [statement_start_offset] [INT] NOT NULL, 
     [statement_end_offset]   [INT] NOT NULL, 
     [plan_generation_num]    [BIGINT] NOT NULL, 
     [plan_handle]            [VARBINARY](64) NOT NULL, 
     [creation_time]          [DATETIME] NOT NULL, 
     [last_execution_time]    [DATETIME] NOT NULL, 
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
     [query_hash]             [BINARY](8) NOT NULL, 
     [query_plan_hash]        [BINARY](8) NOT NULL, 
     [total_rows]             [BIGINT] NOT NULL, 
     [last_rows]              [BIGINT] NOT NULL, 
     [min_rows]               [BIGINT] NOT NULL, 
     [max_rows]               [BIGINT] NOT NULL, 
     [RunDate]                [DATETIME] NOT NULL, 
     [RunID]                  [INT] NOT NULL,
	 [RowNbr]                  [INT] identity (1,1) not null
    )
    ON [PRIMARY] TEXTIMAGE_ON [PRIMARY];
GO
--SELECT '[' + column_name + '],' FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'DFS_CPU_BoundQry2000';
-- drop table DFINAnalytics.dbo.[DFS_CPU_BoundQry2000]

IF NOT EXISTS
(
    SELECT 1
    FROM   INFORMATION_SCHEMA.tables
    WHERE  TABLE_NAME = 'DFS_CPU_BoundQry2000'
)
    CREATE TABLE [dbo].[DFS_CPU_BoundQry2000]
    ([SVRName]                [NVARCHAR](128) NULL, 
     [DBName]                 [NVARCHAR](128) NULL, 
     [text]                   [NVARCHAR](MAX) NULL, 
     [query_plan]             [XML] NULL, 
     [sql_handle]             [VARBINARY](64) NULL, 
     [statement_start_offset] [INT] NULL, 
     [statement_end_offset]   [INT] NULL, 
     [plan_generation_num]    [BIGINT] NULL, 
     [plan_handle]            [VARBINARY](64) NULL, 
     [creation_time]          [DATETIME] NULL, 
     [last_execution_time]    [DATETIME] NULL, 
     [execution_count]        [BIGINT] NULL, 
     [total_worker_time]      [BIGINT] NULL, 
     [last_worker_time]       [BIGINT] NULL, 
     [min_worker_time]        [BIGINT] NULL, 
     [max_worker_time]        [BIGINT] NULL, 
     [total_physical_reads]   [BIGINT] NULL, 
     [last_physical_reads]    [BIGINT] NULL, 
     [min_physical_reads]     [BIGINT] NULL, 
     [max_physical_reads]     [BIGINT] NULL, 
     [total_logical_writes]   [BIGINT] NULL, 
     [last_logical_writes]    [BIGINT] NULL, 
     [min_logical_writes]     [BIGINT] NULL, 
     [max_logical_writes]     [BIGINT] NULL, 
     [total_logical_reads]    [BIGINT] NULL, 
     [last_logical_reads]     [BIGINT] NULL, 
     [min_logical_reads]      [BIGINT] NULL, 
     [max_logical_reads]      [BIGINT] NULL, 
     [total_clr_time]         [BIGINT] NULL, 
     [last_clr_time]          [BIGINT] NULL, 
     [min_clr_time]           [BIGINT] NULL, 
     [max_clr_time]           [BIGINT] NULL, 
     [total_elapsed_time]     [BIGINT] NULL, 
     [last_elapsed_time]      [BIGINT] NULL, 
     [min_elapsed_time]       [BIGINT] NULL, 
     [max_elapsed_time]       [BIGINT] NULL, 
     [query_hash]             [BINARY](8) NULL, 
     [query_plan_hash]        [BINARY](8) NULL, 
     [total_rows]             [BIGINT] NULL, 
     [last_rows]              [BIGINT] NULL, 
     [min_rows]               [BIGINT] NULL, 
     [max_rows]               [BIGINT] NULL, 
     [RunDate]                [DATETIME] NULL, 
     [RunID]                  [INT] NULL,
	 [RowNbr]                  [INT] identity (1,1) not null
    )
    ON [PRIMARY] TEXTIMAGE_ON [PRIMARY];
GO
--performance bottleneck
--is it CPU or I/O bound? If your performance bottleneck is CPU bound, Find trhe top 5 worst 
--performing queries regarding CPU consumption with the following query:
-- Worst performing CPU bound queries

USE master ;
GO
IF EXISTS
(
    SELECT 1
    FROM   sys.procedures
    WHERE  name = 'sp_UTIL_CPU_BoundQry2000'
)
    BEGIN
        DROP PROCEDURE sp_UTIL_CPU_BoundQry2000;
END;
GO
-- exec sp_UTIL_CPU_BoundQry2000 1
CREATE PROCEDURE sp_UTIL_CPU_BoundQry2000
with recompile
AS
    --UTIL_WorstPerformingQuerries.sql
    BEGIN
		declare @msg varchar(100);
		declare @DBNAME varchar(100) = db_name();
		declare @NextID bigint = 0 ;
		exec @NextID =  sp_UTIL_GetSeq;
        
		if exists (select 1 from DFINAnalytics.dbo.[DFS_DB2Skip] where @DBNAME = [DB])
			begin 
			set @msg = 'SKIPPING: ' + @DBNAME;
				exec DFINAnalytics.dbo.printimmediate @msg;
				return;
			end

		set @msg = 'UTIL CPU DB: ' + @DBNAME;
		exec DFINAnalytics.dbo.printimmediate @msg;

        DECLARE @RunDate AS DATETIME= GETDATE();
        INSERT INTO [DFINAnalytics].[dbo].[DFS_CPU_BoundQry2000]
        ([SVRName], 
         [DBName], 
         [text], 
         [query_plan], 
         [sql_handle], 
         [statement_start_offset], 
         [statement_end_offset], 
         [plan_generation_num], 
         [plan_handle], 
         [creation_time], 
         [last_execution_time], 
         [execution_count], 
         [total_worker_time], 
         [last_worker_time], 
         [min_worker_time], 
         [max_worker_time], 
         [total_physical_reads], 
         [last_physical_reads], 
         [min_physical_reads], 
         [max_physical_reads], 
         [total_logical_writes], 
         [last_logical_writes], 
         [min_logical_writes], 
         [max_logical_writes], 
         [total_logical_reads], 
         [last_logical_reads], 
         [min_logical_reads], 
         [max_logical_reads], 
         [total_clr_time], 
         [last_clr_time], 
         [min_clr_time], 
         [max_clr_time], 
         [total_elapsed_time], 
         [last_elapsed_time], 
         [min_elapsed_time], 
         [max_elapsed_time], 
         [query_hash], 
         [query_plan_hash], 
         [total_rows], 
         [last_rows], 
         [min_rows], 
         [max_rows], 
         [RunDate], 
         [RunID]
        )
        SELECT top 10 @@SERVERNAME AS SVRName, 
                      @DBNAME AS DBName, 
                      st.text, 
                      qp.query_plan, 
                      qs.*, 
                      getdate() AS RunDate, 
                      @NEXTID AS RunID
        FROM          sys.dm_exec_query_stats qs
                      CROSS APPLY sys.dm_exec_sql_text(qs.plan_handle) st
                      CROSS APPLY sys.dm_exec_query_plan(qs.plan_handle) qp;
        --ORDER BY total_worker_time DESC;
    END;
GO
IF EXISTS
(
    SELECT 1
    FROM   sys.procedures
    WHERE  name = 'sp_UTIL_IO_BoundQry2000'
)
    BEGIN
        DROP PROCEDURE sp_UTIL_IO_BoundQry2000;
END;
GO
/*
use master;
declare @DBNAME nvarchar(100) ;
declare @NextID bigint = 1 ;
declare @cmd nvarchar(4000) ;

exec @NextID = sp_UTIL_GetSeq;
print @NextID;
use [BNYUK_ProductionAR_Port]
exec sp_UTIL_IO_BoundQry2000 
use master;
select top 20 * from [dbo].[DFS_IO_BoundQry2000] order by RowNbr
*/
CREATE PROCEDURE sp_UTIL_IO_BoundQry2000
with recompile
AS
    BEGIN
		declare @msg varchar(100);
        declare @DBNAME varchar(100) = db_name();
		declare @NextID bigint = 0 ;
		exec @NextID = sp_UTIL_GetSeq;
        DECLARE @RunDate AS DATETIME= GETDATE();

		if exists (select 1 from DFINAnalytics.dbo.[DFS_DB2Skip] where @DBNAME = [DB])
			begin 
			set @msg = 'SKIPPING: ' + @DBNAME;
				exec DFINAnalytics.dbo.printimmediate @msg;
				return;
			end
		
		set @msg = 'UTIL IO DB: ' + @DBNAME;
		exec DFINAnalytics.dbo.printimmediate @msg;

        INSERT INTO [DFINAnalytics].[dbo].[DFS_IO_BoundQry2000]
        ([SVRName], 
         [DBName], 
         [text], 
         [query_plan], 
         [sql_handle], 
         [statement_start_offset], 
         [statement_end_offset], 
         [plan_generation_num], 
         [plan_handle], 
         [creation_time], 
         [last_execution_time], 
         [execution_count], 
         [total_worker_time], 
         [last_worker_time], 
         [min_worker_time], 
         [max_worker_time], 
         [total_physical_reads], 
         [last_physical_reads], 
         [min_physical_reads], 
         [max_physical_reads], 
         [total_logical_writes], 
         [last_logical_writes], 
         [min_logical_writes], 
         [max_logical_writes], 
         [total_logical_reads], 
         [last_logical_reads], 
         [min_logical_reads], 
         [max_logical_reads], 
         [total_clr_time], 
         [last_clr_time], 
         [min_clr_time], 
         [max_clr_time], 
         [total_elapsed_time], 
         [last_elapsed_time], 
         [min_elapsed_time], 
         [max_elapsed_time], 
         [query_hash], 
         [query_plan_hash], 
         [total_rows], 
         [last_rows], 
         [min_rows], 
         [max_rows], 
         [RunDate], 
         [RunID]
        )
        SELECT top 100 @@SERVERNAME AS SVRName, 
                      'DBNAME' AS DBName, 
                      st.text, 
                      qp.query_plan, 
                      qs.*, 
                      getdate() AS RunDate, 
                      0 AS RunID
        FROM          sys.dm_exec_query_stats qs
                      CROSS APPLY sys.dm_exec_sql_text(qs.plan_handle) st
                      CROSS APPLY sys.dm_exec_query_plan(qs.plan_handle) qp ;
    END;
GO

IF EXISTS
(
    SELECT 1
    FROM   sys.procedures
    WHERE  name = 'sp_UTIL_MSTR_BoundQry2000'
)
    BEGIN
        DROP PROCEDURE sp_UTIL_MSTR_BoundQry2000;
END;
go
CREATE PROCEDURE sp_UTIL_MSTR_BoundQry2000
as
begin 
	exec sp_UTIL_IO_BoundQry2000;
	exec sp_UTIL_CPU_BoundQry2000;
end
GO

/*
print 'Start:';
print getdate();
declare @stmt nvarchar(4000);
--set @stmt = 'use ?; exec sp_UTIL_IO_BoundQry2000; exec sp_UTIL_CPU_BoundQry2000; '
set @stmt = 'use ?; exec sp_UTIL_CPU_BoundQry2000; '
exec sp_msForEachDB @stmt ;
print 'END:';
print getdate();
*/

-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016