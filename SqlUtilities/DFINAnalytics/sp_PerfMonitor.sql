
use DFINAnalytics ;

GO

IF NOT EXISTS
   (
	   SELECT
		 1
	   FROM  sys.sequences
	   WHERE name = 'TB_Seq'
   )
	BEGIN
		CREATE SEQUENCE TB_Seq
			AS BIGINT
			START WITH 1
			INCREMENT BY 1
			MINVALUE 1
			MAXVALUE 999999999
			NO CYCLE
			CACHE 10;
END;
GO

GO

IF EXISTS
   (
	   SELECT
		 1
	   FROM  INFORMATION_SCHEMA.tables
	   WHERE TABLE_NAME = 'DFS_PerfMonitor'
   )
	BEGIN
		DROP TABLE DFINAnalytics.[dbo].[DFS_PerfMonitor];
END;
GO
-- select * from DFINAnalytics.dbo.[DFS_PerfMonitor]
CREATE TABLE [dbo].[DFS_PerfMonitor]
   (
	SVRNAME       NVARCHAR(150) NULL
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
   , CONSTRAINT [PK_PerfMonitor] PRIMARY KEY CLUSTERED([UKEY] ASC)
	WITH(PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
   )
ON [PRIMARY];

CREATE INDEX piDFS_PerfMonitor
ON DFS_PerfMonitor
   ([LocID], [EndTime]
   );

ALTER TABLE [dbo].[DFS_PerfMonitor]
ADD CONSTRAINT [DF_PerfMonitor_UKEY] DEFAULT(NEWID()) FOR [UKEY];
GO

IF EXISTS
   (
	   SELECT
		 1
	   FROM  sys.procedures
	   WHERE name = 'sp_PerfMonitor'
   )
	BEGIN
		DROP PROCEDURE
		   [dbo].[sp_PerfMonitor]
END;
GO

CREATE PROCEDURE [dbo].[sp_PerfMonitor]
   (
	@action   VARCHAR(10)
   , @RunID    INT
   --, @UKEY     UNIQUEIDENTIFIER
   , @ProcName VARCHAR(50)      = NULL
   , @LocID    VARCHAR(50)      = NULL
   )
AS
	BEGIN
		declare @UKEY uniqueidentifier = newid();
		IF(@action = 'start' or @action = 'go')
			BEGIN
				INSERT INTO [dbo].[DFS_PerfMonitor]
				   (
				   SVRNAME
				 , DBNAME
				 , SSVER
				 , [RunID]
				 , [ProcName]
				 , [LocID]
				 , [UKEY]
				 , [StartTime]
				 , [EndTime]
				 , [ElapsedTime]
				 , CreateDate
				   )
				VALUES
				(
				   @@servername, DB_NAME(), SUBSTRING(@@version, 1, 149), @RunID, @ProcName, @LocID, @UKEY, GETDATE(), NULL, NULL, GETDATE()
				);
		END;
		IF(@action = 'end' or @action = 'stop' )
			BEGIN
				declare @edate as datetime = getdate();
				UPDATE [dbo].[DFS_PerfMonitor]
				  SET
					 [EndTime] = @edate
					 ,[ElapsedTime] = DATEDIFF(MILLISECOND, [StartTime], @edate)
				WHERE
				   LocID = @LocID
				   and [EndTime] is null;
				
		END;
	END;

GO