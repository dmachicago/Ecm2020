
GO
--* USEDFINAnalytics;
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
IF NOT EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.tables
    WHERE TABLE_NAME = 'DFS_QryPlanBridge'
)
	-- drop TABLE [dbo].DFS_QryPlanBridge
    BEGIN
 CREATE TABLE [dbo].DFS_QryPlanBridge
 ([query_hash] [BINARY](8) NULL, 
  [query_plan_hash] [BINARY](8) NULL, 
		 [PerfType] char(1) not null,
		 [TblType] nvarchar(10) not null,
  [CreateDate] [DATETIME] DEFAULT GETDATE() NOT NULL, 
		 [LastUpdate] [DATETIME] DEFAULT GETDATE() NOT NULL, 
  NbrHits    INT DEFAULT 0,
 );
 CREATE INDEX pkDFS_DFS_QryPlanBridge ON DFS_QryPlanBridge(query_hash, query_plan_hash);
END;
GO
IF NOT EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.tables
    WHERE TABLE_NAME = 'DFS_QrysPlans'
)
	-- drop TABLE [dbo].[DFS_QrysPlans]
    BEGIN
 CREATE TABLE [dbo].[DFS_QrysPlans]
 ([query_hash] [BINARY](8)  NULL, 
  [query_plan_hash] [BINARY](8)  NULL, 
		 [UID] uniqueidentifier default newid() not null,
		 [PerfType] nvarchar(10) not null,
  [text]     [NVARCHAR](MAX) NULL, 
  [query_plan] [XML] NULL, 
  [CreateDate] [DATETIME] DEFAULT GETDATE() NOT NULL, 
 );
 CREATE INDEX pkDFS_QrysPlans ON DFS_QrysPlans(query_hash, query_plan_hash);
END;
GO

-- drop table DFS_CPU_BoundQry2000
IF NOT EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.tables
    WHERE TABLE_NAME = 'DFS_CPU_BoundQry2000'
)
begin
    CREATE TABLE [dbo].[DFS_CPU_BoundQry2000]
    ([SVRName]  [NVARCHAR](150) NULL, 
     [DBName]   [NVARCHAR](150) NULL, 
     [text]     [NVARCHAR](MAX) NULL, 
     [query_plan] [XML] NULL, 
     [sql_handle] [VARBINARY](64) NOT NULL, 
     [statement_start_offset] [INT] NOT NULL, 
     [statement_end_offset]   [INT] NOT NULL, 
     [plan_generation_num]    [BIGINT] NULL, 
     [plan_handle]     [VARBINARY](64) NOT NULL, 
     [creation_time]   [DATETIME] NULL, 
     [last_execution_time]    [DATETIME] NULL, 
     [execution_count] [BIGINT] NOT NULL, 
     [total_worker_time] [BIGINT] NOT NULL, 
     [last_worker_time]  [BIGINT] NOT NULL, 
     [min_worker_time] [BIGINT] NOT NULL, 
     [max_worker_time] [BIGINT] NOT NULL, 
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
     [min_logical_reads] [BIGINT] NOT NULL, 
     [max_logical_reads] [BIGINT] NOT NULL, 
     [total_clr_time]  [BIGINT] NOT NULL, 
     [last_clr_time]   [BIGINT] NOT NULL, 
     [min_clr_time]    [BIGINT] NOT NULL, 
     [max_clr_time]    [BIGINT] NOT NULL, 
     [total_elapsed_time]     [BIGINT] NOT NULL, 
     [last_elapsed_time] [BIGINT] NOT NULL, 
     [min_elapsed_time]  [BIGINT] NOT NULL, 
     [max_elapsed_time]  [BIGINT] NOT NULL, 
     [query_hash] [BINARY](8) NULL, 
     [query_plan_hash] [BINARY](8) NULL, 
     [total_rows] [BIGINT] NULL, 
     [last_rows]  [BIGINT] NULL, 
     [min_rows]   [BIGINT] NULL, 
     [max_rows]   [BIGINT] NULL, 
     [statement_sql_handle]   [VARBINARY](64) NULL, 
     [statement_context_id]   [BIGINT] NULL, 
     [total_dop]  [BIGINT] NULL, 
     [last_dop]   [BIGINT] NULL, 
     [min_dop]  [BIGINT] NULL, 
     [max_dop]  [BIGINT] NULL, 
     [total_grant_kb]  [BIGINT] NULL, 
     [last_grant_kb]   [BIGINT] NULL, 
     [min_grant_kb]    [BIGINT] NULL, 
     [max_grant_kb]    [BIGINT] NULL, 
     [total_used_grant_kb]    [BIGINT] NULL, 
     [last_used_grant_kb]     [BIGINT] NULL, 
     [min_used_grant_kb] [BIGINT] NULL, 
     [max_used_grant_kb] [BIGINT] NULL, 
     [total_ideal_grant_kb]   [BIGINT] NULL, 
     [last_ideal_grant_kb]    [BIGINT] NULL, 
     [min_ideal_grant_kb]     [BIGINT] NULL, 
     [max_ideal_grant_kb]     [BIGINT] NULL, 
     [total_reserved_threads] [BIGINT] NULL, 
     [last_reserved_threads]  [BIGINT] NULL, 
     [min_reserved_threads]   [BIGINT] NULL, 
     [max_reserved_threads]   [BIGINT] NULL, 
     [total_used_threads]     [BIGINT] NULL, 
     [last_used_threads] [BIGINT] NULL, 
     [min_used_threads]  [BIGINT] NULL, 
     [max_used_threads]  [BIGINT] NULL, 
     [RunDate]  [DATETIME] NOT NULL, 
     [SSVer]    [NVARCHAR](300) NULL, 
     [RunID]    [INT] NOT NULL, 
	 [UID] uniqueidentifier default newid() not null,
	 [Processed] int default 0,
     RowNbr     INT IDENTITY(1, 1) NOT NULL
    )
    ON [PRIMARY];
	CREATE INDEX piDFS_CPU_BoundQry2000 ON DFS_CPU_BoundQry2000 (query_hash, query_plan_hash);
	CREATE INDEX piDFS_CPU_BoundQry2000_Processed ON DFS_CPU_BoundQry2000 (Processed, UID );
end
GO

--drop TABLE [dbo].[DFS_IO_BoundQry2000]
IF NOT EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.tables
    WHERE TABLE_NAME = 'DFS_IO_BoundQry2000'
)
begin 
    CREATE TABLE [dbo].[DFS_IO_BoundQry2000]
    ([SVRName]  [NVARCHAR](150) NULL, 
     [DBName]   [VARCHAR](6) NOT NULL, 
     [text]     [NVARCHAR](MAX) NULL, 
     [query_plan] [XML] NULL, 
     [sql_handle] [VARBINARY](64) NOT NULL, 
     [statement_start_offset] [INT] NOT NULL, 
     [statement_end_offset]   [INT] NOT NULL, 
     [plan_generation_num]    [BIGINT] NULL, 
     [plan_handle]     [VARBINARY](64) NOT NULL, 
     [creation_time]   [DATETIME] NULL, 
     [last_execution_time]    [DATETIME] NULL, 
     [execution_count] [BIGINT] NOT NULL, 
     [total_worker_time] [BIGINT] NOT NULL, 
     [last_worker_time]  [BIGINT] NOT NULL, 
     [min_worker_time] [BIGINT] NOT NULL, 
     [max_worker_time] [BIGINT] NOT NULL, 
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
     [min_logical_reads] [BIGINT] NOT NULL, 
     [max_logical_reads] [BIGINT] NOT NULL, 
     [total_clr_time]  [BIGINT] NOT NULL, 
     [last_clr_time]   [BIGINT] NOT NULL, 
     [min_clr_time]    [BIGINT] NOT NULL, 
     [max_clr_time]    [BIGINT] NOT NULL, 
     [total_elapsed_time]     [BIGINT] NOT NULL, 
     [last_elapsed_time] [BIGINT] NOT NULL, 
     [min_elapsed_time]  [BIGINT] NOT NULL, 
     [max_elapsed_time]  [BIGINT] NOT NULL, 
     [query_hash] [BINARY](8) NULL, 
     [query_plan_hash] [BINARY](8) NULL, 
     [total_rows] [BIGINT] NULL, 
     [last_rows]  [BIGINT] NULL, 
     [min_rows]   [BIGINT] NULL, 
     [max_rows]   [BIGINT] NULL, 
     [statement_sql_handle]   [VARBINARY](64) NULL, 
     [statement_context_id]   [BIGINT] NULL, 
     [total_dop]  [BIGINT] NULL, 
     [last_dop]   [BIGINT] NULL, 
     [min_dop]  [BIGINT] NULL, 
     [max_dop]  [BIGINT] NULL, 
     [total_grant_kb]  [BIGINT] NULL, 
     [last_grant_kb]   [BIGINT] NULL, 
     [min_grant_kb]    [BIGINT] NULL, 
     [max_grant_kb]    [BIGINT] NULL, 
     [total_used_grant_kb]    [BIGINT] NULL, 
     [last_used_grant_kb]     [BIGINT] NULL, 
     [min_used_grant_kb] [BIGINT] NULL, 
     [max_used_grant_kb] [BIGINT] NULL, 
     [total_ideal_grant_kb]   [BIGINT] NULL, 
     [last_ideal_grant_kb]    [BIGINT] NULL, 
     [min_ideal_grant_kb]     [BIGINT] NULL, 
     [max_ideal_grant_kb]     [BIGINT] NULL, 
     [total_reserved_threads] [BIGINT] NULL, 
     [last_reserved_threads]  [BIGINT] NULL, 
     [min_reserved_threads]   [BIGINT] NULL, 
     [max_reserved_threads]   [BIGINT] NULL, 
     [total_used_threads]     [BIGINT] NULL, 
     [last_used_threads] [BIGINT] NULL, 
     [min_used_threads]  [BIGINT] NULL, 
     [max_used_threads]  [BIGINT] NULL, 
     [RunDate]  [DATETIME] NOT NULL, 
     [SSVER]    [NVARCHAR](250) NULL, 
     [RunID]    [INT] NOT NULL, 
     [UID] uniqueidentifier default newid() not null,
	 [Processed] int default 0,     
     RunNbr     INT IDENTITY(1, 1) NOT NULL
    )
    ON [PRIMARY];
	CREATE INDEX piDFS_IO_BoundQry2000 ON DFS_IO_BoundQry2000 (query_hash, query_plan_hash);
	CREATE INDEX piDFS_IO_BoundQry2000_Processed ON DFS_IO_BoundQry2000 (Processed, UID );
end 
GO
IF NOT EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.tables
    WHERE TABLE_NAME = 'DFS_CPU_BoundQry'
)
begin
    CREATE TABLE [dbo].[DFS_CPU_BoundQry]
    ([SVRName]  [NVARCHAR](150) NULL, 
     [DBName]   [NVARCHAR](150) NULL, 
     [text]     [NVARCHAR](MAX) NULL, 
     [query_plan] [XML] NULL, 
     [sql_handle] [VARBINARY](64) NOT NULL, 
     [statement_start_offset] [INT] NOT NULL, 
     [statement_end_offset]   [INT] NOT NULL, 
     [plan_generation_num]    [BIGINT] NULL, 
     [plan_handle]     [VARBINARY](64) NOT NULL, 
     [creation_time]   [DATETIME] NULL, 
     [last_execution_time]    [DATETIME] NULL, 
     [execution_count] [BIGINT] NOT NULL, 
     [total_worker_time] [BIGINT] NOT NULL, 
     [last_worker_time]  [BIGINT] NOT NULL, 
     [min_worker_time] [BIGINT] NOT NULL, 
     [max_worker_time] [BIGINT] NOT NULL, 
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
     [min_logical_reads] [BIGINT] NOT NULL, 
     [max_logical_reads] [BIGINT] NOT NULL, 
     [total_clr_time]  [BIGINT] NOT NULL, 
     [last_clr_time]   [BIGINT] NOT NULL, 
     [min_clr_time]    [BIGINT] NOT NULL, 
     [max_clr_time]    [BIGINT] NOT NULL, 
     [total_elapsed_time]     [BIGINT] NOT NULL, 
     [last_elapsed_time] [BIGINT] NOT NULL, 
     [min_elapsed_time]  [BIGINT] NOT NULL, 
     [max_elapsed_time]  [BIGINT] NOT NULL, 
     [query_hash] [BINARY](8) NULL, 
     [query_plan_hash] [BINARY](8) NULL, 
     [total_rows] [BIGINT] NULL, 
     [last_rows]  [BIGINT] NULL, 
     [min_rows]   [BIGINT] NULL, 
     [max_rows]   [BIGINT] NULL, 
     [statement_sql_handle]   [VARBINARY](64) NULL, 
     [statement_context_id]   [BIGINT] NULL, 
     [total_dop]  [BIGINT] NULL, 
     [last_dop]   [BIGINT] NULL, 
     [min_dop]  [BIGINT] NULL, 
     [max_dop]  [BIGINT] NULL, 
     [total_grant_kb]  [BIGINT] NULL, 
     [last_grant_kb]   [BIGINT] NULL, 
     [min_grant_kb]    [BIGINT] NULL, 
     [max_grant_kb]    [BIGINT] NULL, 
     [total_used_grant_kb]    [BIGINT] NULL, 
     [last_used_grant_kb]     [BIGINT] NULL, 
     [min_used_grant_kb] [BIGINT] NULL, 
     [max_used_grant_kb] [BIGINT] NULL, 
     [total_ideal_grant_kb]   [BIGINT] NULL, 
     [last_ideal_grant_kb]    [BIGINT] NULL, 
     [min_ideal_grant_kb]     [BIGINT] NULL, 
     [max_ideal_grant_kb]     [BIGINT] NULL, 
     [total_reserved_threads] [BIGINT] NULL, 
     [last_reserved_threads]  [BIGINT] NULL, 
     [min_reserved_threads]   [BIGINT] NULL, 
     [max_reserved_threads]   [BIGINT] NULL, 
     [total_used_threads]     [BIGINT] NULL, 
     [last_used_threads] [BIGINT] NULL, 
     [min_used_threads]  [BIGINT] NULL, 
     [max_used_threads]  [BIGINT] NULL, 
     [RunDate]  [DATETIME] NULL, 
     [RunID]    [BIGINT] NULL,
	 [UID] uniqueidentifier default newid() not null,
	 [Processed] int default 0,     
    )
    ON [PRIMARY];

	CREATE INDEX piDFS_CPU_BoundQry ON DFS_CPU_BoundQry (query_hash, query_plan_hash);
	CREATE INDEX piDFS_CPU_BoundQry_Processed ON DFS_CPU_BoundQry (Processed, UID );
end
GO
IF NOT EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.tables
    WHERE TABLE_NAME = 'DFS_IO_BoundQry'
)
begin
    CREATE TABLE [dbo].[DFS_IO_BoundQry]
    ([SVRName]  [NVARCHAR](150) NULL, 
     [DBName]   [NVARCHAR](150) NULL, 
     [text]     [NVARCHAR](MAX) NULL, 
     [query_plan] [XML] NULL, 
     [sql_handle] [VARBINARY](64) NOT NULL, 
     [statement_start_offset] [INT] NOT NULL, 
     [statement_end_offset]   [INT] NOT NULL, 
     [plan_generation_num]    [BIGINT] NULL, 
     [plan_handle]     [VARBINARY](64) NOT NULL, 
     [creation_time]   [DATETIME] NULL, 
     [last_execution_time]    [DATETIME] NULL, 
     [execution_count] [BIGINT] NOT NULL, 
     [total_worker_time] [BIGINT] NOT NULL, 
     [last_worker_time]  [BIGINT] NOT NULL, 
     [min_worker_time] [BIGINT] NOT NULL, 
     [max_worker_time] [BIGINT] NOT NULL, 
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
     [min_logical_reads] [BIGINT] NOT NULL, 
     [max_logical_reads] [BIGINT] NOT NULL, 
     [total_clr_time]  [BIGINT] NOT NULL, 
     [last_clr_time]   [BIGINT] NOT NULL, 
     [min_clr_time]    [BIGINT] NOT NULL, 
     [max_clr_time]    [BIGINT] NOT NULL, 
     [total_elapsed_time]     [BIGINT] NOT NULL, 
     [last_elapsed_time] [BIGINT] NOT NULL, 
     [min_elapsed_time]  [BIGINT] NOT NULL, 
     [max_elapsed_time]  [BIGINT] NOT NULL, 
     [query_hash] [BINARY](8) NULL, 
     [query_plan_hash] [BINARY](8) NULL, 
     [total_rows] [BIGINT] NULL, 
     [last_rows]  [BIGINT] NULL, 
     [min_rows]   [BIGINT] NULL, 
     [max_rows]   [BIGINT] NULL, 
     [statement_sql_handle]   [VARBINARY](64) NULL, 
     [statement_context_id]   [BIGINT] NULL, 
     [total_dop]  [BIGINT] NULL, 
     [last_dop]   [BIGINT] NULL, 
     [min_dop]  [BIGINT] NULL, 
     [max_dop]  [BIGINT] NULL, 
     [total_grant_kb]  [BIGINT] NULL, 
     [last_grant_kb]   [BIGINT] NULL, 
     [min_grant_kb]    [BIGINT] NULL, 
     [max_grant_kb]    [BIGINT] NULL, 
     [total_used_grant_kb]    [BIGINT] NULL, 
     [last_used_grant_kb]     [BIGINT] NULL, 
     [min_used_grant_kb] [BIGINT] NULL, 
     [max_used_grant_kb] [BIGINT] NULL, 
     [total_ideal_grant_kb]   [BIGINT] NULL, 
     [last_ideal_grant_kb]    [BIGINT] NULL, 
     [min_ideal_grant_kb]     [BIGINT] NULL, 
     [max_ideal_grant_kb]     [BIGINT] NULL, 
     [total_reserved_threads] [BIGINT] NULL, 
     [last_reserved_threads]  [BIGINT] NULL, 
     [min_reserved_threads]   [BIGINT] NULL, 
     [max_reserved_threads]   [BIGINT] NULL, 
     [total_used_threads]     [BIGINT] NULL, 
     [last_used_threads] [BIGINT] NULL, 
     [min_used_threads]  [BIGINT] NULL, 
     [max_used_threads]  [BIGINT] NULL, 
     [RunDate]  [DATETIME] NULL, 
     [UID] uniqueidentifier default newid() not null,
	 [Processed] int default 0,     
     [RunID]    [BIGINT] NULL
    )
    ON [PRIMARY];

	CREATE INDEX piDFS_IO_BoundQry ON DFS_IO_BoundQry (query_hash, query_plan_hash);
	CREATE INDEX piDFS_IO_BoundQry_Processed ON DFS_IO_BoundQry (Processed, UID );
	end 
GO
IF NOT EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.tables
    WHERE TABLE_NAME = 'DFS_SEQ'
)
    CREATE TABLE dbo.[DFS_SEQ]
    (GenDate DATETIME DEFAULT GETDATE(), 
     SeqID   INT IDENTITY(1, 1) NOT NULL
    );
GO

-- truncate table DFS_WaitTypes
-- select count(*) from DFS_WaitTypes
IF NOT EXISTS
(
    SELECT 1
    FROM sys.tables
    WHERE name = 'DFS_WaitTypes'
)
    BEGIN
 CREATE TABLE DFS_WaitTypes
 (typecode   NVARCHAR(50) NOT NULL, 
  definition NVARCHAR(MAX) NOT NULL,
 );
 CREATE INDEX pk_DFS_WaitTypes ON DFS_WaitTypes(typecode);
END;
GO
if not exists (select 1 from INFORMATION_SCHEMA.TABLES where TABLE_NAME = 'DFS_SequenceTABLE')
CREATE TABLE [DFINAnalytics].dbo.DFS_SequenceTABLE
(
    ID BIGINT IDENTITY  
);
GO
IF NOT EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.tables
    WHERE table_name = 'DFS_MissingFKIndexes'
)
    CREATE TABLE [dbo].[DFS_MissingFKIndexes]
    (SVR [NVARCHAR](150) NULL, 
     [DBName] [NVARCHAR](150) NULL, 
     SSVER    [NVARCHAR](250) NULL, 
     [FK_Constraint] [SYSNAME] NOT NULL, 
     [FK_Table] [SYSNAME] NOT NULL, 
     [FK_Column]     [NVARCHAR](150) NULL, 
     [ParentTable]   [SYSNAME] NOT NULL, 
     [ParentColumn]  [NVARCHAR](150) NULL, 
     [IndexName]     [SYSNAME] NULL, 
     [SQL]    [NVARCHAR](1571) NULL, 
     [CreateDate]    [DATETIME] NOT NULL
    )
    ON [PRIMARY];
go

IF NOT EXISTS
(
    SELECT 1
    FROM sys.tables
    WHERE name = 'DFS_MissingIndexes'
)
    BEGIN
 CREATE TABLE [dbo].[DFS_MissingIndexes]
 ([ServerName] [NVARCHAR](150) NULL, 
  [DBName]   [NVARCHAR](150) NULL, 
  [Affected_table]  [SYSNAME] NOT NULL, 
  [K]   [INT] NULL, 
  [Keys]     [NVARCHAR](4000) NULL, 
  [INCLUDE]  [NVARCHAR](4000) NULL, 
  [sql_statement]   [NVARCHAR](4000) NULL, 
  [user_seeks] [BIGINT] NOT NULL, 
  [user_scans] [BIGINT] NOT NULL, 
  [est_impact] [BIGINT] NULL, 
  [avg_user_impact] [FLOAT] NULL, 
  [last_user_seek]  [DATETIME] NULL, 
  [SecondsUptime]   [INT] NULL, 
  CreateDate DATETIME DEFAULT GETDATE(), 
  RowNbr     INT IDENTITY(1, 1) NOT NULL
 )
 ON [PRIMARY];
 CREATE INDEX idxDFS_SuggestMissingIndexes ON DFS_MissingIndexes(DBName, Affected_table);
END;
GO

-- drop table [DFS_TableReadWrites]
IF NOT EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.TABLES
    WHERE TABLE_NAME = 'DFS_TableReadWrites'
)
    BEGIN
 CREATE TABLE dbo.[DFS_TableReadWrites]
 ([ServerName]    [NVARCHAR](150) NULL, 
  [DBName] [NVARCHAR](150) NULL, 
  [TableName]     [NVARCHAR](150) NULL, 
  [Reads]  [BIGINT] NULL, 
  [Writes] [BIGINT] NULL, 
  [Reads&Writes]  [BIGINT] NULL, 
  [SampleDays]    [NUMERIC](18, 7) NULL, 
  [SampleSeconds] [INT] NULL, 
  [RunDate]  [DATETIME] NOT NULL, 
		 SSVER NVARCHAR(150) null,
  RowID    BIGINT IDENTITY(1, 1) NOT NULL
 )
 ON [PRIMARY];
		create index idxDFS_TableReadWrites on DFS_TableReadWrites ([DBName], [TableName]);
END;
GO

IF NOT EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.tables
    WHERE TABLE_NAME = 'DFS_QryOptStats'
)
    BEGIN
 CREATE TABLE [dbo].[DFS_QryOptStats]
 ([schemaname] [NVARCHAR](150) NULL, 
  [viewname]   [SYSNAME] NOT NULL, 
  [viewid]   [INT] NOT NULL, 
  [databasename]    [NVARCHAR](150) NULL, 
  [databaseid] [SMALLINT] NULL, 
  [text]     [NVARCHAR](MAX) NULL, 
  [query_plan] [XML] NULL, 
  [sql_handle] [VARBINARY](64) NOT NULL, 
  [statement_start_offset] [INT] NOT NULL, 
  [statement_end_offset]   [INT] NOT NULL, 
  [plan_generation_num]    [BIGINT] NULL, 
  [plan_handle]     [VARBINARY](64) NOT NULL, 
  [creation_time]   [DATETIME] NULL, 
  [last_execution_time]    [DATETIME] NULL, 
  [execution_count] [BIGINT] NOT NULL, 
  [total_worker_time] [BIGINT] NOT NULL, 
  [last_worker_time]  [BIGINT] NOT NULL, 
  [min_worker_time] [BIGINT] NOT NULL, 
  [max_worker_time] [BIGINT] NOT NULL, 
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
  [min_logical_reads] [BIGINT] NOT NULL, 
  [max_logical_reads] [BIGINT] NOT NULL, 
  [total_clr_time]  [BIGINT] NOT NULL, 
  [last_clr_time]   [BIGINT] NOT NULL, 
  [min_clr_time]    [BIGINT] NOT NULL, 
  [max_clr_time]    [BIGINT] NOT NULL, 
  [total_elapsed_time]     [BIGINT] NOT NULL, 
  [last_elapsed_time] [BIGINT] NOT NULL, 
  [min_elapsed_time]  [BIGINT] NOT NULL, 
  [max_elapsed_time]  [BIGINT] NOT NULL, 
  [query_hash] [BINARY](8) NULL, 
  [query_plan_hash] [BINARY](8) NULL, 
  [total_rows] [BIGINT] NULL, 
  [last_rows]  [BIGINT] NULL, 
  [min_rows]   [BIGINT] NULL, 
  [max_rows]   [BIGINT] NULL, 
  [statement_sql_handle]   [VARBINARY](64) NULL, 
  [statement_context_id]   [BIGINT] NULL, 
  [total_dop]  [BIGINT] NULL, 
  [last_dop]   [BIGINT] NULL, 
  [min_dop]  [BIGINT] NULL, 
  [max_dop]  [BIGINT] NULL, 
  [total_grant_kb]  [BIGINT] NULL, 
  [last_grant_kb]   [BIGINT] NULL, 
  [min_grant_kb]    [BIGINT] NULL, 
  [max_grant_kb]    [BIGINT] NULL, 
  [total_used_grant_kb]    [BIGINT] NULL, 
  [last_used_grant_kb]     [BIGINT] NULL, 
  [min_used_grant_kb] [BIGINT] NULL, 
  [max_used_grant_kb] [BIGINT] NULL, 
  [total_ideal_grant_kb]   [BIGINT] NULL, 
  [last_ideal_grant_kb]    [BIGINT] NULL, 
  [min_ideal_grant_kb]     [BIGINT] NULL, 
  [max_ideal_grant_kb]     [BIGINT] NULL, 
  [total_reserved_threads] [BIGINT] NULL, 
  [last_reserved_threads]  [BIGINT] NULL, 
  [min_reserved_threads]   [BIGINT] NULL, 
  [max_reserved_threads]   [BIGINT] NULL, 
  [total_used_threads]     [BIGINT] NULL, 
  [last_used_threads] [BIGINT] NULL, 
  [min_used_threads]  [BIGINT] NULL, 
  [max_used_threads]  [BIGINT] NULL,
		 RunDate datetime default getdate(),
		 SSVER NVARCHAR(150) null,
		 RowID bigint identity (1,1) not null		 
 )
 ON [PRIMARY];
END
GO

IF NOT EXISTS
(
    SELECT 1
    FROM sys.tables
    WHERE name = 'DFS_IndexStats'
)
    CREATE TABLE [dbo].[DFS_IndexStats]
    ([SvrName]  [NVARCHAR](150) NULL, 
     [DB]  [NVARCHAR](150) NULL, 
     [Obj] [NVARCHAR](150) NULL, 
     [IdxName]  [SYSNAME] NULL, 
     [range_scan_count]  [BIGINT] NOT NULL, 
     [singleton_lookup_count] [BIGINT] NOT NULL, 
     [row_lock_count]  [BIGINT] NOT NULL, 
     [page_lock_count] [BIGINT] NOT NULL, 
     [TotNo_Of_Locks]  [BIGINT] NULL, 
     [row_lock_wait_count]    [BIGINT] NOT NULL, 
     [page_lock_wait_count]   [BIGINT] NOT NULL, 
     [TotNo_Of_Blocks] [BIGINT] NULL, 
     [row_lock_wait_in_ms]    [BIGINT] NOT NULL, 
     [page_lock_wait_in_ms]   [BIGINT] NOT NULL, 
     [TotBlock_Wait_TimeMS]   [BIGINT] NULL, 
     [index_id]   [INT] NOT NULL, 
     [CreateDate] [DATETIME] NULL, 
     SSVER NVARCHAR(150) NULL, 
     [RowNbr]   [INT] IDENTITY(1, 1) NOT NULL
    )
    ON [PRIMARY];

--ALTER TABLE [dbo].[DFS_IndexStats] ADD  DEFAULT (getdate()) FOR [CreateDate]
GO

-- drop TABLE [dbo].[DFS_BlockingHistory]
IF NOT EXISTS
(
    SELECT 1
    FROM   sys.tables
    WHERE  name = 'DFS_BlockingHistory'
)
    CREATE TABLE [dbo].[DFS_BlockingHistory]
    ([session_id]   [SMALLINT] NOT NULL, 
     [blocking_session_id] [SMALLINT] NULL, 
     [cpu_time]     [INT] NOT NULL, 
     [total_elapsed_time]  [INT] NOT NULL, 
     [Database_Name]  [NVARCHAR](150) NULL, 
     [host_name]    [NVARCHAR](150) NULL, 
     [login_name]   [NVARCHAR](150) NOT NULL, 
     [original_login_name] [NVARCHAR](150) NOT NULL, 
     [STATUS]  [NVARCHAR](30) NOT NULL, 
     [command] [NVARCHAR](16) NOT NULL, 
     [Query_Text]   [NVARCHAR](MAX) NULL, 
     CreateDate     DATETIME NULL, 
     RunID   INT NULL, 
     RowNbr  INT IDENTITY(1, 1) NOT NULL
    )
    ON [PRIMARY] TEXTIMAGE_ON [PRIMARY];
GO

IF NOT EXISTS
(
    SELECT 1
    FROM sys.tables
    WHERE name = 'DFS_TranLocks'
)
    CREATE TABLE [dbo].[DFS_TranLocks]
    ([SPID]   [INT] NOT NULL, 
     [DatabaseName]  [NVARCHAR](150) NULL, 
     [LockedObjectName]     [SYSNAME] NOT NULL, 
     [LockedObjectId]  [INT] NOT NULL, 
     [LockedResource]  [NVARCHAR](60) NOT NULL, 
     [LockType] [NVARCHAR](60) NOT NULL, 
     [SqlStatementText]     [NVARCHAR](MAX) NULL, 
     [LoginName]     [NVARCHAR](150) NOT NULL, 
     [HostName] [NVARCHAR](150) NULL, 
     [IsUserTransaction]    [BIT] NOT NULL, 
     [TransactionName] [NVARCHAR](32) NOT NULL, 
     [AuthenticationMethod] [NVARCHAR](40) NOT NULL, 
     RunID    INT NULL, 
     CreateDate DATETIME DEFAULT GETDATE(), 
     RowNbr   INT IDENTITY(1, 1)
    )
    ON [PRIMARY];
GO

IF EXISTS
(
    SELECT 1
    FROM   master.information_schema.tables
    WHERE  table_name = 'DFS_IndexReorgCmds'
)
    TRUNCATE TABLE dbo.DFS_IndexReorgCmds;
    ELSE
    CREATE TABLE dbo.DFS_IndexReorgCmds
    (CMD     NVARCHAR(MAX) NULL, 
     RowNbr  INT IDENTITY(1, 1) NOT NULL, 
     PctFrag DECIMAL(10, 2) NULL
    );

go

IF NOT EXISTS
(
    SELECT 1
    FROM information_schema.tables
    WHERE table_name = 'DFS_TableGrowthHistory'
)
    CREATE TABLE [dbo].[DFS_TableGrowthHistory]
    ([SvrName]    [SYSNAME] NOT NULL, 
     [DBName]     [SYSNAME] NOT NULL, 
     [SchemaName] [SYSNAME] NOT NULL, 
     [TableName]  [SYSNAME] NOT NULL, 
     [RowCounts]  [BIGINT] NOT NULL, 
     [Used_MB]    [NUMERIC](36, 2) NULL, 
     [Unused_MB]  [NUMERIC](36, 2) NULL, 
     [Total_MB]   [NUMERIC](36, 2) NULL, 
     RunID NVARCHAR(60) NULL, 
     CreateDate   DATETIME DEFAULT GETDATE(), 
     RowNbr  INT IDENTITY(1, 1) NOT NULL
    )
    ON [PRIMARY];
GO

-- drop table [dbo].[DFS_TranLocks]
IF NOT EXISTS
(
    SELECT 1
    FROM   sys.tables
    WHERE  name = 'DFS_TranLocks'
)
    CREATE TABLE [dbo].[DFS_TranLocks]
    ([SPID]   [INT] NOT NULL, 
     [DatabaseName]  [NVARCHAR](150) NULL, 
     [LockedObjectName]     [SYSNAME] NOT NULL, 
     [LockedObjectId]  [INT] NOT NULL, 
     [LockedResource]  [NVARCHAR](60) NOT NULL, 
     [LockType] [NVARCHAR](60) NOT NULL, 
     [SqlStatementText]     [NVARCHAR](MAX) NULL, 
     [LoginName]     [NVARCHAR](150) NOT NULL, 
     [HostName] [NVARCHAR](150) NULL, 
     [IsUserTransaction]    [BIT] NOT NULL, 
     [TransactionName] [NVARCHAR](32) NOT NULL, 
     [AuthenticationMethod] [NVARCHAR](40) NOT NULL, 
     RunID    INT NULL, 
     CreateDate DATETIME DEFAULT GETDATE(), 
     RowNbr   INT IDENTITY(1, 1)
    )
    ON [PRIMARY] ;
GO

-- drop table [dbo].[DFS_PerfMonitor]
IF NOT EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.tables
    WHERE TABLE_NAME = 'DFS_PerfMonitor'
)
    BEGIN
 CREATE TABLE [dbo].[DFS_PerfMonitor]
 (SVRNAME  NVARCHAR(150) NULL, 
  DBNAME NVARCHAR(150) NULL, 
  SSVER  NVARCHAR(150) NULL, 
  [RunID]  [INT] NOT NULL, 
  [ProcName]    [VARCHAR](100) NOT NULL, 
  [LocID]  [VARCHAR](50) NOT NULL, 
  [UKEY] [UNIQUEIDENTIFIER] NOT NULL, 
  [StartTime]   [DATETIME2](7) NULL, 
  [EndTime]     [DATETIME2](7) NULL, 
  [ElapsedTime] [DECIMAL](18, 3) NULL, 
  CreateDate    DATETIME DEFAULT GETDATE(), 
		 CONSTRAINT [PK_PerfMonitor] PRIMARY KEY CLUSTERED ([UKEY] ASC)
  WITH(PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
 )
 ON [PRIMARY];
 ALTER TABLE [dbo].[DFS_PerfMonitor]
 ADD CONSTRAINT [DF_PerfMonitor_UKEY] DEFAULT(NEWID()) FOR [UKEY];
END;
GO

IF NOT EXISTS
(
    SELECT name
    FROM sys.tables
    WHERE name = 'DFS_TableGrowthHistory'
)
    BEGIN
 CREATE TABLE dbo.DFS_TableGrowthHistory
 (SvrName     NVARCHAR(150) NOT NULL, 
  DBName NVARCHAR(150) NOT NULL, 
  Table_name  NVARCHAR(150) NOT NULL, 
  NbrRows     INT NOT NULL, 
  EntryDate   DATETIME DEFAULT GETDATE(), 
  RunID  BIGINT NOT NULL, 
  TableSchema NVARCHAR(50) NULL,
		 RowId	     int identity(1,1) not null
 );
END;
GO

IF NOT EXISTS
(
    SELECT name
    FROM sys.tables
    WHERE name = 'DFS_TableGrowthHistory'
)
    BEGIN
 CREATE TABLE dbo.DFS_TableGrowthHistory
 (SvrName     NVARCHAR(150) NOT NULL, 
  DBName NVARCHAR(150) NOT NULL, 
  Table_name  NVARCHAR(150) NOT NULL, 
  NbrRows     INT NOT NULL, 
  EntryDate   DATETIME DEFAULT GETDATE(), 
  RunID  BIGINT NOT NULL, 
  TableSchema NVARCHAR(50) NULL,
		 RowId	     int identity(1,1) not null
 );
END;
GO

-- drop table DFS_TableGrowthHistory
IF NOT EXISTS
(
    SELECT 1
    FROM   information_schema.tables
    WHERE  table_name = 'DFS_TableGrowthHistory'
)
    CREATE TABLE [dbo].[DFS_TableGrowthHistory]
    ([SvrName]    [SYSNAME] NOT NULL, 
     [DBName]     [SYSNAME] NOT NULL, 
     [SchemaName] [SYSNAME] NOT NULL, 
     [TableName]  [SYSNAME] NOT NULL, 
     [RowCounts]  [BIGINT] NOT NULL, 
     [Used_MB]    [NUMERIC](36, 2) NULL, 
     [Unused_MB]  [NUMERIC](36, 2) NULL, 
     [Total_MB]   [NUMERIC](36, 2) NULL, 
     RunID NVARCHAR(60) NULL, 
     CreateDate   DATETIME DEFAULT GETDATE(), 
	 SSVer nvarchar(100) null,
     RowNbr  INT IDENTITY(1, 1) NOT NULL
    )
    ON [PRIMARY];
GO

-- drop table DFS_DBVersion
IF NOT EXISTS
(
    SELECT name
    FROM   sys.tables
    WHERE  name = 'DFS_DBVersion'
)
    BEGIN
 CREATE TABLE DFS_DBVersion
 ([SVRName] [NVARCHAR](150) NULL, 
  [DBName]  [NVARCHAR](150) NULL, 
  [SSVER]   [NVARCHAR](250) NOT NULL, 
  [SSVERID] [NVARCHAR](60) NOT NULL
 DEFAULT NEWID(),
		Rownbr int identity (1,1) not null
 );
 CREATE UNIQUE INDEX PK_DFS_DBVersion
 ON DFS_DBVersion
 ([SSVERID]
 ) INCLUDE([SSVER]);
END;
GO

IF NOT EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.TABLES
    WHERE TABLE_NAME = 'DFS_SequenceTABLE'
)
    BEGIN
 CREATE TABLE [dbo].[DFS_SequenceTABLE]
 ([ID] [BIGINT] IDENTITY(1, 1) NOT NULL,
 )
 ON [PRIMARY];
 CREATE UNIQUE INDEX pk_SequenceTABLE ON DFS_SequenceTABLE(id);
END;
GO

IF NOT EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.tables
    WHERE TABLE_NAME = 'DFS_DB2Skip'
)
begin 
    CREATE TABLE dbo.[DFS_DB2Skip](DB NVARCHAR(100));
	create unique index PK_DFS_DB2Skip on DFS_DB2Skip (DB);
	insert into dbo.[DFS_DB2Skip] (DB) values ('master');
	insert into dbo.[DFS_DB2Skip] (DB) values ('DBA');
	insert into dbo.[DFS_DB2Skip] (DB) values ('model');
	insert into dbo.[DFS_DB2Skip] (DB) values ('msdb');
	insert into dbo.[DFS_DB2Skip] (DB) values ('tempdb');
end 
GO

-- DROP TABLE [dbo].[DFS_DbFileSizing]
IF NOT EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.TABLES
    WHERE TABLE_NAME = 'DFS_DbFileSizing'
)
    CREATE TABLE [dbo].[DFS_DbFileSizing]
    ([Svr]  [SYSNAME] NOT NULL, 
	[Database]  [SYSNAME] NOT NULL, 
     [File]    [SYSNAME] NOT NULL, 
     [size]    [INT] NOT NULL, 
     [SizeMB]  [INT] NULL, 
     [Database Total] [INT] NULL, 
     [max_size]  [INT] NOT NULL, 
     CreateDate  DATETIME DEFAULT GETDATE(), 
     RowNbr    INT IDENTITY(1, 1), 
     RunID     BIGINT
    )
    ON [PRIMARY];
GO

IF NOT EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.tables
    WHERE TABLE_NAME = 'DFS_TxMonitorTableStats'
)
    BEGIN
 CREATE TABLE dbo.DFS_TxMonitorTableStats
 (SvrName   NVARCHAR(150) NULL, 
  DBName    NVARCHAR(150) NULL, 
  SchemaName  NVARCHAR(150) NULL, 
  TableName NVARCHAR(150) NULL, 
  IndexName NVARCHAR(150) NULL, 
  IndexID   INT NULL, 
  user_seeks  BIGINT NULL, 
  user_scans  BIGINT NULL, 
  user_lookups     BIGINT NULL, 
  user_updates     BIGINT NULL, 
  last_user_seek   DATETIME NULL, 
  last_user_scan   DATETIME NULL, 
  last_user_lookup DATETIME NULL, 
  last_user_update DATETIME NULL, 
  DBID INT NULL, 
  CreateDate  DATETIME NULL
  DEFAULT GETDATE(), 
  ExecutionDate    DATETIME NOT NULL, 
  RunID     INT NULL, 
  RowNbr    INT IDENTITY(1, 1) NOT NULL
 )
 ON [PRIMARY];
END;
GO

IF NOT EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.TABLES
    WHERE TABLE_NAME = 'DFS_TxMonitorTblUpdates'
)
    BEGIN
 --* USEDFINAnalytics;
 CREATE TABLE dbo.DFS_TxMonitorTblUpdates
 (SVR     NVARCHAR(150) NULL, 
  database_id    INT NOT NULL, 
		 SchemaName  NVARCHAR(150) NULL, 
  DBname  NVARCHAR(150) NULL, 
  TableName NVARCHAR(150) NULL, 
  user_lookups   INT NULL, 
  user_scans     INT NULL, 
  user_seeks     INT NULL, 
  UpdatedRows    BIGINT NOT NULL, 
  LastUpdateTime DATETIME NULL, 
  CreateDate     DATETIME NULL, 
  ExecutionDate  DATETIME NOT NULL, 
  RowID   BIGINT IDENTITY(1, 1) NOT NULL, 
  RunID   INT NULL
 )
 ON [PRIMARY];
 ALTER TABLE dbo.DFS_TxMonitorTblUpdates
 ADD DEFAULT GETDATE() FOR CreateDate;
END;
GO

IF NOT EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.TABLES
    WHERE TABLE_NAME = 'DFS_TxMonitorTableIndexStats'
)
    BEGIN
 CREATE TABLE [dbo].[DFS_TxMonitorTableIndexStats]
 ([SVR]  [NVARCHAR](150) NULL, 
  [SchemaName]  [NVARCHAR](150) NULL, 
  [DBName]    [NVARCHAR](150) NULL, 
  [TableName] [NVARCHAR](150) NULL, 
  [IndexName] [SYSNAME] NULL, 
  [IndexID]   [INT] NOT NULL, 
  [user_seeks]  [BIGINT] NOT NULL, 
  [user_scans]  [BIGINT] NOT NULL, 
  [user_lookups]     [BIGINT] NOT NULL, 
  [user_updates]     [BIGINT] NOT NULL, 
  [last_user_seek]   [DATETIME] NULL, 
  [last_user_scan]   [DATETIME] NULL, 
  [last_user_lookup] [DATETIME] NULL, 
  [last_user_update] [DATETIME] NULL, 
  [DBID] [SMALLINT] NULL, 
  [ExecutionDate]    [DATETIME] NOT NULL, 
  [RunID]     [INT] NOT NULL, 
  RowNbr INT IDENTITY(1, 1) NOT NULL
 )
 ON [PRIMARY];
 CREATE NONCLUSTERED INDEX [IDX_TxMonitorTableStats_RID] ON [dbo].[DFS_TxMonitorTableIndexStats]([RunID] ASC, [ExecutionDate] ASC) WITH(PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];
 CREATE UNIQUE CLUSTERED INDEX [PK_TxMonitorTableStats] ON [dbo].[DFS_TxMonitorTableIndexStats]([RowNbr] ASC) WITH(PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];
END;
GO

IF NOT EXISTS ( SELECT 1
  FROM information_schema.tables
  WHERE table_name = 'DFS_IndexFragProgress'
  ) 
    BEGIN
		print 'Creating TABLE dbo.DFS_IndexFragProgress';
 CREATE TABLE dbo.DFS_IndexFragProgress ( 
  SqlCmd    VARCHAR(MAX) NULL , 
  DBNAME    NVARCHAR(100) , 
  StartTime DATETIME NULL , 
  EndTime   DATETIME NULL , 
  RunID     NVARCHAR(60) NULL , 
  RowNbr    INT IDENTITY(1 , 1) NOT NULL ,
  ) 
 ON [PRIMARY];
 CREATE INDEX idxDFS_DFS_IndexFragProgress ON dbo.DFS_IndexFragProgress ( DBNAME
      );
END;
GO

IF NOT EXISTS ( SELECT 1
  FROM information_schema.tables
  WHERE table_name = 'DFS_IndexFragErrors'
  ) 
    BEGIN
 CREATE TABLE dbo.DFS_IndexFragErrors ( 
  SqlCmd VARCHAR(MAX) NULL , 
  DBNAME NVARCHAR(100) , 
  RunID  NVARCHAR(60) NULL , 
  RowNbr INT IDENTITY(1 , 1) NOT NULL ,
     ) 
 ON [PRIMARY];
 CREATE INDEX idxDFS_IndexFragErrors ON dbo.DFS_IndexFragErrors ( DBNAME
     );
 CREATE INDEX pxDFS_IndexFragErrors ON dbo.DFS_IndexFragErrors ( RowNbr
    );
END;
GO

IF NOT EXISTS ( SELECT 1
  FROM information_schema.tables
  WHERE table_name = 'DFS_IndexFragHist'
  ) 
    BEGIN
 CREATE TABLE dbo.DFS_IndexFragHist ( 
  DBName   NVARCHAR(150) NULL , 
  [Schema] NVARCHAR(150)  NOT NULL , 
  [Table]  NVARCHAR(150)  NOT NULL , 
  [Index]  NVARCHAR(150)  NULL , 
  alloc_unit_type_desc NVARCHAR(60) NULL , 
  IndexProcessed  INTEGER NULL DEFAULT 0 , 
  AvgPctFrag    DECIMAL(8 , 2) NULL , 
  page_count    BIGINT NULL , 
  RunDate  DATETIME DEFAULT GETDATE() , 
  RunID  NVARCHAR(60) NULL , 
  Success  INT NULL , 
  RowNbr   INT IDENTITY(1 , 1) NOT NULL
   ) 
 ON [PRIMARY];
 CREATE INDEX idxRUNIdentifier ON dbo.DFS_IndexFragHist ( RunID
    );
 CREATE INDEX idxIndexPorcessed ON dbo.DFS_IndexFragHist ( IndexProcessed
     );
END;
GO

IF NOT EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.tables
    WHERE table_name = 'DFS_TableStats'
)
    BEGIN
 CREATE TABLE [dbo].[DFS_TableStats]
 ([ServerName]    [NVARCHAR](150) NULL, 
  [DBName] [NVARCHAR](150) NULL, 
  [TableName]     [NVARCHAR](150) NULL, 
  [Reads]  [INT] NULL, 
  [Writes] [INT] NULL, 
  [ReadsWrites]   [INT] NULL, 
  [SampleDays]    [DECIMAL](18, 8) NULL, 
  [SampleSeconds] [INT] NULL, 
  [RunDate]  [DATETIME] NULL,
		 [RowID] bigint identity (1,1) not null
 )
 ON [PRIMARY];
 ALTER TABLE [dbo].[DFS_TableStats]
 ADD CONSTRAINT [DF_DFS_TableStats_RunDate] DEFAULT(GETDATE()) FOR [RunDate];
END;
GO

IF NOT EXISTS
(
    SELECT 1
    FROM sys.tables
    WHERE name = 'DFS_TxMonitorTableStats'
)
    CREATE TABLE [dbo].[DFS_TxMonitorTableStats]
    ([SvrName]   [NVARCHAR](150) NULL, 
     [DBName]    [NVARCHAR](150) NULL, 
     [TableName] [NVARCHAR](150) NULL, 
     [IndexName] [NVARCHAR](250) NULL, 
     [IndexID]   [INT] NULL, 
     [user_seeks]  [BIGINT] NULL, 
     [user_scans]  [BIGINT] NULL, 
     [user_lookups]     [BIGINT] NULL, 
     [user_updates]     [BIGINT] NULL, 
     [last_user_seek]   [DATETIME] NULL, 
     [last_user_scan]   [DATETIME] NULL, 
     [last_user_lookup] [DATETIME] NULL, 
     [last_user_update] [DATETIME] NULL, 
     [DBID] [INT] NULL, 
     CreateDate  DATETIME NULL
     DEFAULT GETDATE(), 
     ExecutionDate DATETIME NOT NULL, 
     Rownbr INT IDENTITY(1, 1) NOT NULL
    )
    ON [PRIMARY];
GO
-- drop		TABLE [dbo].[DFS_TxMonitorIDX]
IF NOT EXISTS
(
    SELECT 1
    FROM sys.tables
    WHERE name = 'DFS_TxMonitorIDX'
)
    CREATE TABLE [dbo].[DFS_TxMonitorIDX]
    ([SvrName] [NVARCHAR](150) NULL, 
     [DBName]  [NVARCHAR](150) NULL, 
     [database_id]    [INT] NOT NULL, 
     [TableName] [NVARCHAR](150) NULL, 
     [UpdatedRows]    [BIGINT] NOT NULL, 
     [LastUpdateTime] [DATETIME] NULL, 
     CreateDate  DATETIME NULL
     DEFAULT GETDATE(), 
     ExecutionDate    DATETIME NOT NULL, 
     Rownbr    INT IDENTITY(1, 1) NOT NULL
    )
    ON [PRIMARY];
GO

IF NOT EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.tables
    WHERE table_name = 'DFS_DeadlockStats'
)
    CREATE TABLE DFS_DeadlockStats
    (SPID INT, 
     STATUS VARCHAR(1000) NULL, 
     Login  SYSNAME NULL, 
     HostName    SYSNAME NULL, 
     BlkBy  SYSNAME NULL, 
     DBName SYSNAME NULL, 
     Command     VARCHAR(1000) NULL, 
     CPUTime     INT NULL, 
     DiskIO INT NULL, 
     LastBatch   VARCHAR(1000) NULL, 
     ProgramName VARCHAR(1000) NULL, 
     SPID2  INT, 
     REQUESTID   INT NULL, 
     RunDate     DATETIME DEFAULT GETDATE(), 
     RunID  INT, 
     RowID  INT IDENTITY(1, 1) NOT NULL
    );
GO

IF NOT EXISTS
(
    SELECT 1
    FROM   information_schema.tables
    WHERE  table_name = 'DFS_IndexFragReorgHistory'
)
    BEGIN
 CREATE TABLE [dbo].DFS_IndexFragReorgHistory
 ([DBName] [NVARCHAR](150) NULL, 
  [Schema] NVARCHAR(150)  NOT NULL, 
  [Table]  NVARCHAR(150)  NOT NULL, 
  [Index]  NVARCHAR(150)  NULL, 
  [OnlineReorg] [VARCHAR](10) NULL, 
  [Success]     [VARCHAR](10) NULL, 
  Rundate  DATETIME NULL, 
  RunID  NVARCHAR(60) NULL, 
  Stmt   VARCHAR(MAX) NULL, 
  RowNbr INT IDENTITY(1, 1) NOT NULL
 )
 ON [PRIMARY];
 ALTER TABLE [dbo].DFS_IndexFragReorgHistory
 ADD DEFAULT(GETDATE()) FOR [RunDate];

END;

go

IF NOT EXISTS
(
    SELECT 1
    FROM   information_schema.tables
    WHERE  table_name = 'DFS_TableGrowthHistory'
)
begin
    CREATE TABLE [dbo].[DFS_TableGrowthHistory]
    ([SvrName]    [SYSNAME] NOT NULL, 
     [DBName]     [SYSNAME] NOT NULL, 
     [SchemaName] [SYSNAME] NOT NULL, 
     [TableName]  [SYSNAME] NOT NULL, 
     [RowCounts]  [BIGINT] NOT NULL, 
     [Used_MB]    [NUMERIC](36, 2) NULL, 
     [Unused_MB]  [NUMERIC](36, 2) NULL, 
     [Total_MB]   [NUMERIC](36, 2) NULL, 
     RunID NVARCHAR(60) NULL, 
     CreateDate   DATETIME DEFAULT GETDATE(), 
     RowNbr  INT IDENTITY(1, 1) NOT NULL
    )
    ON [PRIMARY];


CREATE INDEX pidx_DFS_TableGrowthHistory
ON DFS_TableGrowthHistory
(DBname, TableName, Rownbr
);
END

go