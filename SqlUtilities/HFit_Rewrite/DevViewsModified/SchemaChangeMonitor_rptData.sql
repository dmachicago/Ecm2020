
GO 
Print('Creating SchemaChangeMonitor_rptData table') ;
Go
if not exists(select name from sys.tables where name = 'SchemaChangeMonitor_rptData')
BEGIN
	CREATE TABLE [dbo].[SchemaChangeMonitor_rptData](
		[label] [nvarchar](50) NOT NULL,
		[sText] [nvarchar](2500) NOT NULL,
		[DisplayOrder] [int] NOT NULL,
		[RowNbr] [int] NOT NULL
	)
END
GO 
Print('Created SchemaChangeMonitor_rptData table') ;
Go

