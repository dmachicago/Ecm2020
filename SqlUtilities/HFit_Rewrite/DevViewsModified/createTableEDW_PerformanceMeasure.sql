
print ('Create Table: EDW_PerformanceMeasure');
go

if not exists (select name from sys.tables where name = 'EDW_PerformanceMeasure')
BEGIN
	CREATE TABLE [dbo].[EDW_PerformanceMeasure](
		[TypeTest] [nvarchar](50) NULL,
		[ObjectName] [nvarchar](80) NULL,
		[RecCount] [int] NULL,
		[StartTime] [datetime] NULL,
		[EndTime] [datetime] NULL,
		[hrs] [int] NULL,
		[mins] [int] NULL,
		[secs] [int] NULL,
		[ms] [nchar](10) NULL
	) ON [PRIMARY]
END

GO

print ('Created Table: EDW_PerformanceMeasure');
go
