
GO
Print('Creating SchemaChangeMonitor table');
GO
if exists(select name from sys.tables where name = 'SchemaChangeMonitor')
BEGIN
	Print('DROP SchemaChangeMonitor table');
	DROP TABLE [SchemaChangeMonitor] ;
END

if not exists(select name from sys.tables where name = 'SchemaChangeMonitor')
BEGIN
	CREATE TABLE [dbo].[SchemaChangeMonitor](
	[PostTime] [datetime] NULL,
	[DB_User] [nvarchar](100) NULL,
	[IP_Address] [nvarchar](50) NULL,
	[CUR_User] [nvarchar](80) NULL,
	[Event] [nvarchar](100) NULL,
	[TSQL] [nvarchar](2000) NULL,
	[OBJ] [nvarchar](50) NULL,
	RowNbr int identity (1,1)
)
END
go



GO
Print('Created SchemaChangeMonitor table');
GO

