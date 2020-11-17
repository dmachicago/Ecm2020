
GO

/*---------------------------------
 drop table [dbo].[DFS_PerfMonitor]
---------------------------------*/

IF EXISTS
   (
	   SELECT
		 1
	   FROM  INFORMATION_SCHEMA.tables
	   WHERE TABLE_NAME = 'DFS_PerfMonitor'
   )
	BEGIN
		DROP TABLE [dbo].[DFS_PerfMonitor];
END;
GO

CREATE TABLE [dbo].[DFS_PerfMonitor]
   (SVRNAME       NVARCHAR(150) NULL
  , DBNAME        NVARCHAR(150) NULL
  , SSVER         NVARCHAR(150) NULL
  , [RunID]       [INT] NOT NULL
  , [ProcName]    [VARCHAR](100) NOT NULL
  , [LocID]       [VARCHAR](50) NOT NULL
  , [UKEY]        [UNIQUEIDENTIFIER] NOT NULL
  , [StartTime]   [DATETIME2](7) NULL
  , [EndTime]     [DATETIME2](7) NULL
  , [ElapsedTime] [DECIMAL](18, 3) NULL
  , CreateDate    DATETIME DEFAULT GETDATE()
  , [UID]         UNIQUEIDENTIFIER DEFAULT NEWID()
  , CONSTRAINT [PK_PerfMonitor] PRIMARY KEY CLUSTERED([UKEY] ASC)
    WITH(PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
   )
ON [PRIMARY];

ALTER TABLE [dbo].[DFS_PerfMonitor]
ADD CONSTRAINT [DF_PerfMonitor_UKEY] DEFAULT(NEWID()) FOR [UKEY];
GO

