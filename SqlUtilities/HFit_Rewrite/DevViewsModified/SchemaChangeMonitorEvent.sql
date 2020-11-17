
GO 
print ('createing SchemaChangeMonitorEvent table');
Go

if not exists(select name from sys.tables where name = 'SchemaChangeMonitorEvent')
BEGIN
	CREATE TABLE [dbo].[SchemaChangeMonitorEvent](
		[Event] [nvarchar](100) NULL,	
	) ;

	insert [SchemaChangeMonitorEvent] (Event) values ('DROP_VIEW') ; 
	insert [SchemaChangeMonitorEvent] (Event) values ('ALTER_TABLE') ; 
	insert [SchemaChangeMonitorEvent] (Event) values ('CREATE_TABLE') ; 
	insert [SchemaChangeMonitorEvent] (Event) values ('ALTER_VIEW') ; 
	insert [SchemaChangeMonitorEvent] (Event) values ('CREATE_VIEW') ; 
	insert [SchemaChangeMonitorEvent] (Event) values ('DROP_TABLE') ; 
	insert [SchemaChangeMonitorEvent] (Event) values ('RENAME') ; 
	
END
GO



GO 
print ('created SchemaChangeMonitorEvent table');
Go
