

GO
IF NOT EXISTS
(
    SELECT 1
    FROM sys.tables
    WHERE name = 'DFS_SEQ'
)
    BEGIN
CREATE TABLE [dbo].[DFS_SEQ](
	[GenDate] [datetime] NULL,
	[SeqID] [int] IDENTITY(1,1) NOT NULL,
	[UID] [uniqueidentifier] NOT NULL
) ON [PRIMARY]
ALTER TABLE [dbo].[DFS_SEQ] ADD  DEFAULT (getdate()) FOR [GenDate]
ALTER TABLE [dbo].[DFS_SEQ] ADD  DEFAULT (newid()) FOR [UID]
end

GO
IF NOT EXISTS
(
    SELECT 1
    FROM sys.tables
    WHERE name = 'DFS_PerfMonitor'
)
    BEGIN
        CREATE TABLE [dbo].[DFS_PerfMonitor]
        ([SVRNAME]     [NVARCHAR](150) NULL, 
         [DBNAME]      [NVARCHAR](150) NULL, 
         [SSVER]       [NVARCHAR](250) NULL, 
         [RunID]       [INT] NOT NULL, 
         [ProcName]    [VARCHAR](100) NOT NULL, 
         [LocID]       [VARCHAR](50) NOT NULL, 
         [UKEY]        [UNIQUEIDENTIFIER] NOT NULL, 
         [StartTime]   [DATETIME2](7) NULL, 
         [EndTime]     [DATETIME2](7) NULL, 
         [ElapsedTime] [DECIMAL](18, 3) NULL, 
         [CreateDate]  [DATETIME] NULL, 
         [UID]         [UNIQUEIDENTIFIER] NULL, 
         CONSTRAINT [PK_PerfMonitor] PRIMARY KEY CLUSTERED([UKEY] ASC)
         WITH(PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
        )
        ON [PRIMARY];
        ALTER TABLE [dbo].[DFS_PerfMonitor]
        ADD CONSTRAINT [DF_PerfMonitor_UKEY] DEFAULT(NEWID()) FOR [UKEY];
        ALTER TABLE [dbo].[DFS_PerfMonitor]
        ADD DEFAULT(GETDATE()) FOR [CreateDate];
        ALTER TABLE [dbo].[DFS_PerfMonitor]
        ADD DEFAULT(NEWID()) FOR [UID];
END;
GO
IF NOT EXISTS
(
    SELECT 1
    FROM sys.tables
    WHERE name = 'DFS_TxMonitorTblUpdates'
)
    BEGIN
        CREATE TABLE [dbo].[DFS_TxMonitorTblUpdates]
        ([SVR]            [NVARCHAR](128) NULL, 
         [database_id]    [INT] NOT NULL, 
         [SchemaName]     [NVARCHAR](128) NULL, 
         [DBname]         [NVARCHAR](128) NULL, 
         [TableName]      [NVARCHAR](128) NULL, 
         [user_lookups]   [INT] NULL, 
         [user_scans]     [INT] NULL, 
         [user_seeks]     [INT] NULL, 
         [UpdatedRows]    [BIGINT] NOT NULL, 
         [LastUpdateTime] [DATETIME] NULL, 
         [CreateDate]     [DATETIME] NULL, 
         [ExecutionDate]  [DATETIME] NOT NULL, 
         [RowID]          [BIGINT] IDENTITY(1, 1) NOT NULL, 
         [RunID]          [INT] NULL, 
         [UID]            [UNIQUEIDENTIFIER] NOT NULL
        )
        ON [PRIMARY];
        ALTER TABLE [dbo].[DFS_TxMonitorTblUpdates]
        ADD DEFAULT(GETDATE()) FOR [CreateDate];
        ALTER TABLE [dbo].[DFS_TxMonitorTblUpdates]
        ADD DEFAULT(NEWID()) FOR [UID];
END;
GO
IF NOT EXISTS
(
    SELECT 1
    FROM sys.tables
    WHERE name = 'DFS_TableStats'
)
    BEGIN
        CREATE TABLE [dbo].[DFS_TableStats]
        ([ServerName]    [NVARCHAR](128) NULL, 
         [DBName]        [NVARCHAR](128) NULL, 
         [TableName]     [NVARCHAR](128) NULL, 
         [Reads]         [INT] NULL, 
         [Writes]        [INT] NULL, 
         [ReadsWrites]   [INT] NULL, 
         [SampleDays]    [DECIMAL](18, 8) NULL, 
         [SampleSeconds] [INT] NULL, 
         [RunDate]       [DATETIME] NULL, 
         [UID]           [UNIQUEIDENTIFIER] NULL, 
         [RowID]         [BIGINT] IDENTITY(1, 1) NOT NULL
        )
        ON [PRIMARY];
        ALTER TABLE [dbo].[DFS_TableStats]
        ADD CONSTRAINT [DF_DFS_TableStats_RunDate] DEFAULT(GETDATE()) FOR [RunDate];
        ALTER TABLE [dbo].[DFS_TableStats]
        ADD DEFAULT(NEWID()) FOR [UID];
END;
GO
IF NOT EXISTS
(
    SELECT 1
    FROM sys.tables
    WHERE name = 'DFS_IndexReorgCmds'
)
    BEGIN
        CREATE TABLE [dbo].[DFS_IndexReorgCmds]
        ([CMD]     [NVARCHAR](MAX) NULL, 
         [RowNbr]  [INT] IDENTITY(1, 1) NOT NULL, 
         [PctFrag] [DECIMAL](10, 2) NULL, 
         [UID]     [UNIQUEIDENTIFIER] NOT NULL
        )
        ON [PRIMARY];
        ALTER TABLE [dbo].[DFS_IndexReorgCmds] ADD DEFAULT(NEWID()) FOR [UID];
END;
GO
IF NOT EXISTS
(
    SELECT 1
    FROM sys.tables
    WHERE name = 'DFS_$ActiveDatabases'
)
    BEGIN
        CREATE TABLE [dbo].[DFS_$ActiveDatabases]
        ([GroupName]  [NVARCHAR](50) NOT NULL, 
         [ServerName] [NVARCHAR](150) NOT NULL, 
         [DBName]     [NVARCHAR](150) NOT NULL, 
         [isAzure]    [BIT] NULL, 
         [UserID]     [NVARCHAR](60) NULL, 
         [pwd]        [NVARCHAR](60) NULL, 
         [UID]        [UNIQUEIDENTIFIER] NOT NULL
        )
        ON [PRIMARY];
        ALTER TABLE [dbo].[DFS_$ActiveDatabases]
        ADD DEFAULT('NA') FOR [GroupName];
        ALTER TABLE [dbo].[DFS_$ActiveDatabases]
        ADD DEFAULT((0)) FOR [isAzure];
        ALTER TABLE [dbo].[DFS_$ActiveDatabases]
        ADD DEFAULT(NEWID()) FOR [UID];
END;
GO
IF NOT EXISTS
(
    SELECT 1
    FROM sys.tables
    WHERE name = 'DFIN_TRACKED_DATABASES'
)
    BEGIN
        CREATE TABLE [dbo].[DFIN_TRACKED_DATABASES]
        ([INSTANCE]           [VARCHAR](50) NOT NULL, 
         [DATABASENAME]       [VARCHAR](100) NOT NULL, 
         [REGION]             [VARCHAR](4) NOT NULL, 
         [AuthenticationType] [CHAR](1) NOT NULL, 
         [UtilityUserID]      [NVARCHAR](50) NULL, 
         [UtilityUserPW]      [NVARCHAR](50) NULL, 
         [UID]                [UNIQUEIDENTIFIER] NOT NULL
        )
        ON [PRIMARY];
END;
GO
IF NOT EXISTS
(
    SELECT 1
    FROM sys.tables
    WHERE name = 'DFIN_TRACKED_DATABASE_PROCS'
)
    BEGIN
        CREATE TABLE [dbo].[DFIN_TRACKED_DATABASE_PROCS]
        ([PROCNAME] [VARCHAR](100) NOT NULL, 
         [UID]      [UNIQUEIDENTIFIER] NOT NULL
        )
        ON [PRIMARY];
        ALTER TABLE [dbo].[DFIN_TRACKED_DATABASE_PROCS]
        ADD DEFAULT(NEWID()) FOR [UID];
END; 
GO

/*
select 
'if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where table_name = '''+table_name+''' and column_name = ''UID'')
	alter table '+table_name+' add [UID] uniqueidentifier null default newid() ; ' + char(10) + 'GO'
from information_schema.columns
where column_name = 'UID'
union
select distinct 'if not exists (select 1 from sys.indexes where [name] = ''pi_'+ C.table_name +  '_UID'')' +
	char(10) + '    create index pi_' + C.table_name + '_UID on '  + C.table_name + ' ([UID]);' + char(10) + 'GO'
	  from INFORMATION_SCHEMA.columns C 
	  join INFORMATION_SCHEMA.tables T on T.TABLE_NAME = C.TABLE_NAME and T.TABLE_TYPE = 'BASE TABLE'
	  where column_name = 'UID'
*/
/********************************************************************************************/

IF NOT EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE table_name = 'ActiveJob'
          AND column_name = 'UID'
)
    ALTER TABLE ActiveJob
    ADD [UID] UNIQUEIDENTIFIER NULL
                               DEFAULT NEWID(); 
GO
IF NOT EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE table_name = 'ActiveServers'
          AND column_name = 'UID'
)
    ALTER TABLE ActiveServers
    ADD [UID] UNIQUEIDENTIFIER NULL
                               DEFAULT NEWID(); 
GO
IF NOT EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE table_name = 'DFIN_TRACKED_DATABASE_PROCS'
          AND column_name = 'UID'
)
    ALTER TABLE DFIN_TRACKED_DATABASE_PROCS
    ADD [UID] UNIQUEIDENTIFIER NULL
                               DEFAULT NEWID(); 
GO
IF NOT EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE table_name = 'DFIN_TRACKED_DATABASES'
          AND column_name = 'UID'
)
    ALTER TABLE DFIN_TRACKED_DATABASES
    ADD [UID] UNIQUEIDENTIFIER NULL
                               DEFAULT NEWID(); 
GO
IF NOT EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE table_name = 'DFS_$ActiveDatabases'
          AND column_name = 'UID'
)
    ALTER TABLE DFS_$ActiveDatabases
    ADD [UID] UNIQUEIDENTIFIER NULL
                               DEFAULT NEWID(); 
GO
IF NOT EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE table_name = 'DFS_BlockingHistory'
          AND column_name = 'UID'
)
    ALTER TABLE DFS_BlockingHistory
    ADD [UID] UNIQUEIDENTIFIER NULL
                               DEFAULT NEWID(); 
GO
IF NOT EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE table_name = 'DFS_CleanedDFSTables'
          AND column_name = 'UID'
)
    ALTER TABLE DFS_CleanedDFSTables
    ADD [UID] UNIQUEIDENTIFIER NULL
                               DEFAULT NEWID(); 
GO
IF NOT EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE table_name = 'DFS_CPU_BoundQry'
          AND column_name = 'UID'
)
    ALTER TABLE DFS_CPU_BoundQry
    ADD [UID] UNIQUEIDENTIFIER NULL
                               DEFAULT NEWID(); 
GO
IF NOT EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE table_name = 'DFS_CPU_BoundQry2000'
          AND column_name = 'UID'
)
    ALTER TABLE DFS_CPU_BoundQry2000
    ADD [UID] UNIQUEIDENTIFIER NULL
                               DEFAULT NEWID(); 
GO
IF NOT EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE table_name = 'DFS_DbFileSizing'
          AND column_name = 'UID'
)
    ALTER TABLE DFS_DbFileSizing
    ADD [UID] UNIQUEIDENTIFIER NULL
                               DEFAULT NEWID(); 
GO
IF NOT EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE table_name = 'DFS_DBSpace'
          AND column_name = 'UID'
)
    ALTER TABLE DFS_DBSpace
    ADD [UID] UNIQUEIDENTIFIER NULL
                               DEFAULT NEWID(); 
GO
IF NOT EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE table_name = 'DFS_DBTableSpace'
          AND column_name = 'UID'
)
    ALTER TABLE DFS_DBTableSpace
    ADD [UID] UNIQUEIDENTIFIER NULL
                               DEFAULT NEWID(); 
GO
IF NOT EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE table_name = 'DFS_DBVersion'
          AND column_name = 'UID'
)
    ALTER TABLE DFS_DBVersion
    ADD [UID] UNIQUEIDENTIFIER NULL
                               DEFAULT NEWID(); 
GO
IF NOT EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE table_name = 'DFS_DeadlockStats'
          AND column_name = 'UID'
)
    ALTER TABLE DFS_DeadlockStats
    ADD [UID] UNIQUEIDENTIFIER NULL
                               DEFAULT NEWID(); 
GO
IF NOT EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE table_name = 'DFS_IndexFragErrors'
          AND column_name = 'UID'
)
    ALTER TABLE DFS_IndexFragErrors
    ADD [UID] UNIQUEIDENTIFIER NULL
                               DEFAULT NEWID(); 
GO
IF NOT EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE table_name = 'DFS_IndexFragHist'
          AND column_name = 'UID'
)
    ALTER TABLE DFS_IndexFragHist
    ADD [UID] UNIQUEIDENTIFIER NULL
                               DEFAULT NEWID(); 
GO
IF NOT EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE table_name = 'DFS_IndexFragProgress'
          AND column_name = 'UID'
)
    ALTER TABLE DFS_IndexFragProgress
    ADD [UID] UNIQUEIDENTIFIER NULL
                               DEFAULT NEWID(); 
GO
IF NOT EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE table_name = 'DFS_IndexFragReorgHistory'
          AND column_name = 'UID'
)
    ALTER TABLE DFS_IndexFragReorgHistory
    ADD [UID] UNIQUEIDENTIFIER NULL
                               DEFAULT NEWID(); 
GO
IF NOT EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE table_name = 'DFS_IndexReorgCmds'
          AND column_name = 'UID'
)
    ALTER TABLE DFS_IndexReorgCmds
    ADD [UID] UNIQUEIDENTIFIER NULL
                               DEFAULT NEWID(); 
GO
IF NOT EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE table_name = 'DFS_IndexStats'
          AND column_name = 'UID'
)
    ALTER TABLE DFS_IndexStats
    ADD [UID] UNIQUEIDENTIFIER NULL
                               DEFAULT NEWID(); 
GO
IF NOT EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE table_name = 'DFS_IO_BoundQry'
          AND column_name = 'UID'
)
    ALTER TABLE DFS_IO_BoundQry
    ADD [UID] UNIQUEIDENTIFIER NULL
                               DEFAULT NEWID(); 
GO
IF NOT EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE table_name = 'DFS_IO_BoundQry2000'
          AND column_name = 'UID'
)
    ALTER TABLE DFS_IO_BoundQry2000
    ADD [UID] UNIQUEIDENTIFIER NULL
                               DEFAULT NEWID(); 
GO
IF NOT EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE table_name = 'DFS_MissingFKIndexes'
          AND column_name = 'UID'
)
    ALTER TABLE DFS_MissingFKIndexes
    ADD [UID] UNIQUEIDENTIFIER NULL
                               DEFAULT NEWID(); 
GO
IF NOT EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE table_name = 'DFS_MissingIndexes'
          AND column_name = 'UID'
)
    ALTER TABLE DFS_MissingIndexes
    ADD [UID] UNIQUEIDENTIFIER NULL
                               DEFAULT NEWID(); 
GO
IF NOT EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE table_name = 'DFS_MonitorMostCommonWaits'
          AND column_name = 'UID'
)
    ALTER TABLE DFS_MonitorMostCommonWaits
    ADD [UID] UNIQUEIDENTIFIER NULL
                               DEFAULT NEWID(); 
GO
IF NOT EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE table_name = 'DFS_ParallelMonitor'
          AND column_name = 'UID'
)
    ALTER TABLE DFS_ParallelMonitor
    ADD [UID] UNIQUEIDENTIFIER NULL
                               DEFAULT NEWID(); 
GO
IF NOT EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE table_name = 'DFS_PerfMonitor'
          AND column_name = 'UID'
)
    ALTER TABLE DFS_PerfMonitor
    ADD [UID] UNIQUEIDENTIFIER NULL
                               DEFAULT NEWID(); 
GO
IF NOT EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE table_name = 'DFS_PowershellJobSchedule'
          AND column_name = 'UID'
)
    ALTER TABLE DFS_PowershellJobSchedule
    ADD [UID] UNIQUEIDENTIFIER NULL
                               DEFAULT NEWID(); 
GO
IF NOT EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE table_name = 'DFS_QryOptStats'
          AND column_name = 'UID'
)
    ALTER TABLE DFS_QryOptStats
    ADD [UID] UNIQUEIDENTIFIER NULL
                               DEFAULT NEWID(); 
GO
IF NOT EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE table_name = 'DFS_QrysPlans'
          AND column_name = 'UID'
)
    ALTER TABLE DFS_QrysPlans
    ADD [UID] UNIQUEIDENTIFIER NULL
                               DEFAULT NEWID(); 
GO
IF NOT EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE table_name = 'DFS_RecordCount'
          AND column_name = 'UID'
)
    ALTER TABLE DFS_RecordCount
    ADD [UID] UNIQUEIDENTIFIER NULL
                               DEFAULT NEWID(); 
GO
IF NOT EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE table_name = 'DFS_SEQ'
          AND column_name = 'UID'
)
    ALTER TABLE DFS_SEQ
    ADD [UID] UNIQUEIDENTIFIER NULL
                               DEFAULT NEWID(); 
GO
IF NOT EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE table_name = 'DFS_TableGrowthHistory'
          AND column_name = 'UID'
)
    ALTER TABLE DFS_TableGrowthHistory
    ADD [UID] UNIQUEIDENTIFIER NULL
                               DEFAULT NEWID(); 
GO
IF NOT EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE table_name = 'DFS_TableReadWrites'
          AND column_name = 'UID'
)
    ALTER TABLE DFS_TableReadWrites
    ADD [UID] UNIQUEIDENTIFIER NULL
                               DEFAULT NEWID(); 
GO
IF NOT EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE table_name = 'DFS_TableSizeAndRowCnt'
          AND column_name = 'UID'
)
    ALTER TABLE DFS_TableSizeAndRowCnt
    ADD [UID] UNIQUEIDENTIFIER NULL
                               DEFAULT NEWID(); 
GO
IF NOT EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE table_name = 'DFS_TableStats'
          AND column_name = 'UID'
)
    ALTER TABLE DFS_TableStats
    ADD [UID] UNIQUEIDENTIFIER NULL
                               DEFAULT NEWID(); 
GO
IF NOT EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE table_name = 'DFS_TempDbMonitor'
          AND column_name = 'UID'
)
    ALTER TABLE DFS_TempDbMonitor
    ADD [UID] UNIQUEIDENTIFIER NULL
                               DEFAULT NEWID(); 
GO
IF NOT EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE table_name = 'DFS_TempProcErrors'
          AND column_name = 'UID'
)
    ALTER TABLE DFS_TempProcErrors
    ADD [UID] UNIQUEIDENTIFIER NULL
                               DEFAULT NEWID(); 
GO
IF NOT EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE table_name = 'DFS_TranLocks'
          AND column_name = 'UID'
)
    ALTER TABLE DFS_TranLocks
    ADD [UID] UNIQUEIDENTIFIER NULL
                               DEFAULT NEWID(); 
GO
IF NOT EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE table_name = 'DFS_TxMonitorIDX'
          AND column_name = 'UID'
)
    ALTER TABLE DFS_TxMonitorIDX
    ADD [UID] UNIQUEIDENTIFIER NULL
                               DEFAULT NEWID(); 
GO
IF NOT EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE table_name = 'DFS_TxMonitorTableIndexStats'
          AND column_name = 'UID'
)
    ALTER TABLE DFS_TxMonitorTableIndexStats
    ADD [UID] UNIQUEIDENTIFIER NULL
                               DEFAULT NEWID(); 
GO
IF NOT EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE table_name = 'DFS_TxMonitorTableStats'
          AND column_name = 'UID'
)
    ALTER TABLE DFS_TxMonitorTableStats
    ADD [UID] UNIQUEIDENTIFIER NULL
                               DEFAULT NEWID(); 
GO
IF NOT EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE table_name = 'DFS_TxMonitorTblUpdates'
          AND column_name = 'UID'
)
    ALTER TABLE DFS_TxMonitorTblUpdates
    ADD [UID] UNIQUEIDENTIFIER NULL
                               DEFAULT NEWID(); 
GO
IF NOT EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE table_name = 'DFS_WaitStats'
          AND column_name = 'UID'
)
    ALTER TABLE DFS_WaitStats
    ADD [UID] UNIQUEIDENTIFIER NULL
                               DEFAULT NEWID(); 
GO
IF NOT EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE table_name = 'DFS_Workload'
          AND column_name = 'UID'
)
    ALTER TABLE DFS_Workload
    ADD [UID] UNIQUEIDENTIFIER NULL
                               DEFAULT NEWID(); 
GO
IF NOT EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE table_name = 'vTrackTblReadsWrites'
          AND column_name = 'UID'
)
    ALTER TABLE vTrackTblReadsWrites
    ADD [UID] UNIQUEIDENTIFIER NULL
                               DEFAULT NEWID(); 
GO
IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE [name] = 'pi_ActiveJob_UID'
)
    CREATE INDEX pi_ActiveJob_UID
    ON ActiveJob
    ([UID]
    );
GO
IF EXISTS (select 1 from sys.indexes where name = 'pi_ActiveServers_UID')
	drop index pi_ActiveServers_UID on [ActiveServers];
GO
IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE [name] = 'pi_ActiveServers_UID'
)
    CREATE unique NONCLUSTERED INDEX [pi_ActiveServers_UID] ON [dbo].[ActiveServers]
(
	GroupName, SvrName, DBName ASC
);

GO
IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE [name] = 'pi_DFIN_TRACKED_DATABASE_PROCS_UID'
)
    CREATE INDEX pi_DFIN_TRACKED_DATABASE_PROCS_UID
    ON DFIN_TRACKED_DATABASE_PROCS
    ([UID]
    );
GO
IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE [name] = 'pi_DFIN_TRACKED_DATABASES_UID'
)
    CREATE INDEX pi_DFIN_TRACKED_DATABASES_UID
    ON DFIN_TRACKED_DATABASES
    ([UID]
    );
GO
IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE [name] = 'pi_DFS_$ActiveDatabases_UID'
)
    CREATE INDEX pi_DFS_$ActiveDatabases_UID
    ON DFS_$ActiveDatabases
    ([UID]
    );
GO
IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE [name] = 'pi_DFS_BlockingHistory_UID'
)
    CREATE INDEX pi_DFS_BlockingHistory_UID
    ON DFS_BlockingHistory
    ([UID]
    );
GO
IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE [name] = 'pi_DFS_CleanedDFSTables_UID'
)
    CREATE INDEX pi_DFS_CleanedDFSTables_UID
    ON DFS_CleanedDFSTables
    ([UID]
    );
GO
IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE [name] = 'pi_DFS_CPU_BoundQry_UID'
)
    CREATE INDEX pi_DFS_CPU_BoundQry_UID
    ON DFS_CPU_BoundQry
    ([UID]
    );
GO
IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE [name] = 'pi_DFS_CPU_BoundQry2000_UID'
)
    CREATE INDEX pi_DFS_CPU_BoundQry2000_UID
    ON DFS_CPU_BoundQry2000
    ([UID]
    );
GO
IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE [name] = 'pi_DFS_DbFileSizing_UID'
)
    CREATE INDEX pi_DFS_DbFileSizing_UID
    ON DFS_DbFileSizing
    ([UID]
    );
GO
IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE [name] = 'pi_DFS_DBSpace_UID'
)
    CREATE INDEX pi_DFS_DBSpace_UID
    ON DFS_DBSpace
    ([UID]
    );
GO
IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE [name] = 'pi_DFS_DBTableSpace_UID'
)
    CREATE INDEX pi_DFS_DBTableSpace_UID
    ON DFS_DBTableSpace
    ([UID]
    );
GO
IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE [name] = 'pi_DFS_DBVersion_UID'
)
    CREATE INDEX pi_DFS_DBVersion_UID
    ON DFS_DBVersion
    ([UID]
    );
GO
IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE [name] = 'pi_DFS_DeadlockStats_UID'
)
    CREATE INDEX pi_DFS_DeadlockStats_UID
    ON DFS_DeadlockStats
    ([UID]
    );
GO
IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE [name] = 'pi_DFS_IndexFragErrors_UID'
)
    CREATE INDEX pi_DFS_IndexFragErrors_UID
    ON DFS_IndexFragErrors
    ([UID]
    );
GO
IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE [name] = 'pi_DFS_IndexFragHist_UID'
)
    CREATE INDEX pi_DFS_IndexFragHist_UID
    ON DFS_IndexFragHist
    ([UID]
    );
GO
IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE [name] = 'pi_DFS_IndexFragProgress_UID'
)
    CREATE INDEX pi_DFS_IndexFragProgress_UID
    ON DFS_IndexFragProgress
    ([UID]
    );
GO
IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE [name] = 'pi_DFS_IndexFragReorgHistory_UID'
)
    CREATE INDEX pi_DFS_IndexFragReorgHistory_UID
    ON DFS_IndexFragReorgHistory
    ([UID]
    );
GO
IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE [name] = 'pi_DFS_IndexReorgCmds_UID'
)
    CREATE INDEX pi_DFS_IndexReorgCmds_UID
    ON DFS_IndexReorgCmds
    ([UID]
    );
GO
IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE [name] = 'pi_DFS_IndexStats_UID'
)
    CREATE INDEX pi_DFS_IndexStats_UID
    ON DFS_IndexStats
    ([UID]
    );
GO
IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE [name] = 'pi_DFS_IO_BoundQry_UID'
)
    CREATE INDEX pi_DFS_IO_BoundQry_UID
    ON DFS_IO_BoundQry
    ([UID]
    );
GO
IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE [name] = 'pi_DFS_IO_BoundQry2000_UID'
)
    CREATE INDEX pi_DFS_IO_BoundQry2000_UID
    ON DFS_IO_BoundQry2000
    ([UID]
    );
GO
IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE [name] = 'pi_DFS_MissingFKIndexes_UID'
)
    CREATE INDEX pi_DFS_MissingFKIndexes_UID
    ON DFS_MissingFKIndexes
    ([UID]
    );
GO
IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE [name] = 'pi_DFS_MissingIndexes_UID'
)
    CREATE INDEX pi_DFS_MissingIndexes_UID
    ON DFS_MissingIndexes
    ([UID]
    );
GO
IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE [name] = 'pi_DFS_MonitorMostCommonWaits_UID'
)
    CREATE INDEX pi_DFS_MonitorMostCommonWaits_UID
    ON DFS_MonitorMostCommonWaits
    ([UID]
    );
GO
IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE [name] = 'pi_DFS_ParallelMonitor_UID'
)
    CREATE INDEX pi_DFS_ParallelMonitor_UID
    ON DFS_ParallelMonitor
    ([UID]
    );
GO
IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE [name] = 'pi_DFS_PerfMonitor_UID'
)
    CREATE INDEX pi_DFS_PerfMonitor_UID
    ON DFS_PerfMonitor
    ([UID]
    );
GO
IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE [name] = 'pi_DFS_PowershellJobSchedule_UID'
)
    CREATE INDEX pi_DFS_PowershellJobSchedule_UID
    ON DFS_PowershellJobSchedule
    ([UID]
    );
GO
IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE [name] = 'pi_DFS_QryOptStats_UID'
)
    CREATE INDEX pi_DFS_QryOptStats_UID
    ON DFS_QryOptStats
    ([UID]
    );
GO
IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE [name] = 'pi_DFS_QrysPlans_UID'
)
    CREATE INDEX pi_DFS_QrysPlans_UID
    ON DFS_QrysPlans
    ([UID]
    );
GO
IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE [name] = 'pi_DFS_RecordCount_UID'
)
    CREATE INDEX pi_DFS_RecordCount_UID
    ON DFS_RecordCount
    ([UID]
    );
GO
IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE [name] = 'pi_DFS_SEQ_UID'
)
    CREATE INDEX pi_DFS_SEQ_UID
    ON DFS_SEQ
    ([UID]
    );
GO
IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE [name] = 'pi_DFS_TableGrowthHistory_UID'
)
    CREATE INDEX pi_DFS_TableGrowthHistory_UID
    ON DFS_TableGrowthHistory
    ([UID]
    );
GO
IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE [name] = 'pi_DFS_TableReadWrites_UID'
)
    CREATE INDEX pi_DFS_TableReadWrites_UID
    ON DFS_TableReadWrites
    ([UID]
    );
GO
IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE [name] = 'pi_DFS_TableSizeAndRowCnt_UID'
)
    CREATE INDEX pi_DFS_TableSizeAndRowCnt_UID
    ON DFS_TableSizeAndRowCnt
    ([UID]
    );
GO
IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE [name] = 'pi_DFS_TableStats_UID'
)
    CREATE INDEX pi_DFS_TableStats_UID
    ON DFS_TableStats
    ([UID]
    );
GO
IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE [name] = 'pi_DFS_TempDbMonitor_UID'
)
    CREATE INDEX pi_DFS_TempDbMonitor_UID
    ON DFS_TempDbMonitor
    ([UID]
    );
GO
IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE [name] = 'pi_DFS_TempProcErrors_UID'
)
    CREATE INDEX pi_DFS_TempProcErrors_UID
    ON DFS_TempProcErrors
    ([UID]
    );
GO
IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE [name] = 'pi_DFS_TranLocks_UID'
)
    CREATE INDEX pi_DFS_TranLocks_UID
    ON DFS_TranLocks
    ([UID]
    );
GO
IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE [name] = 'pi_DFS_TxMonitorIDX_UID'
)
    CREATE INDEX pi_DFS_TxMonitorIDX_UID
    ON DFS_TxMonitorIDX
    ([UID]
    );
GO
IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE [name] = 'pi_DFS_TxMonitorTableIndexStats_UID'
)
    CREATE INDEX pi_DFS_TxMonitorTableIndexStats_UID
    ON DFS_TxMonitorTableIndexStats
    ([UID]
    );
GO
IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE [name] = 'pi_DFS_TxMonitorTableStats_UID'
)
    CREATE INDEX pi_DFS_TxMonitorTableStats_UID
    ON DFS_TxMonitorTableStats
    ([UID]
    );
GO
IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE [name] = 'pi_DFS_TxMonitorTblUpdates_UID'
)
    CREATE INDEX pi_DFS_TxMonitorTblUpdates_UID
    ON DFS_TxMonitorTblUpdates
    ([UID]
    );
GO
IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE [name] = 'pi_DFS_WaitStats_UID'
)
    CREATE INDEX pi_DFS_WaitStats_UID
    ON DFS_WaitStats
    ([UID]
    );
GO
IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE [name] = 'pi_DFS_Workload_UID'
)
    CREATE INDEX pi_DFS_Workload_UID
    ON DFS_Workload
    ([UID]
    );
GO