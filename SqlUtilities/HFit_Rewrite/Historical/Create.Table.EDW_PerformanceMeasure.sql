
IF NOT EXISTS
	(
		SELECT name
		FROM sys.tables
		WHERE NAME = 'EDW_PerformanceMeasure'
	)
	BEGIN
		CREATE TABLE [dbo].[EDW_PerformanceMeasure](
			[TypeTest] [nvarchar](50) NOT NULL,
			[ObjectName] [nvarchar](80) NOT NULL,
			[RecCount] [int] NOT NULL,
			[StartTime] [datetime] NOT NULL,
			[EndTime] [datetime] NOT NULL,
			[hrs] [int] NULL,
			[mins] [int] NULL,
			[secs] [int] NULL,
			[ms] [int] NULL
		) ON [PRIMARY]

		ALTER TABLE [dbo].[EDW_PerformanceMeasure] ADD  CONSTRAINT [DF_EDW_PerformanceMeasure_StartTime]  DEFAULT (getdate()) FOR [StartTime]
END