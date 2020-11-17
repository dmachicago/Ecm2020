
GO
PRINT 'FQN: SchemaChangeMonitorEvent.SQL';
PRINT 'createing SchemaChangeMonitorEvent table';
GO
IF EXISTS (SELECT
				  name
			 FROM sys.tables
			 WHERE name = 'SchemaChangeMonitorEvent') 
	BEGIN
		DROP TABLE
			 dbo.SchemaChangeMonitorEvent;
	END;
GO
IF NOT EXISTS (SELECT
					  name
				 FROM sys.tables
				 WHERE name = 'SchemaChangeMonitorEvent') 
	BEGIN
		CREATE TABLE dbo.SchemaChangeMonitorEvent (
					 Event nvarchar (254) NULL,) ;
		INSERT INTO SchemaChangeMonitorEvent (
					Event) 
		VALUES
			   ('DROP_VIEW') ;
		INSERT INTO SchemaChangeMonitorEvent (
					Event) 
		VALUES
			   ('ALTER_TABLE') ;
		INSERT INTO SchemaChangeMonitorEvent (
					Event) 
		VALUES
			   ('CREATE_TABLE') ;
		INSERT INTO SchemaChangeMonitorEvent (
					Event) 
		VALUES
			   ('ALTER_VIEW') ;
		INSERT INTO SchemaChangeMonitorEvent (
					Event) 
		VALUES
			   ('CREATE_VIEW') ;
		INSERT INTO SchemaChangeMonitorEvent (
					Event) 
		VALUES
			   ('DROP_TABLE') ;
		INSERT INTO SchemaChangeMonitorEvent (
					Event) 
		VALUES
			   ('RENAME') ;
	END;
GO
PRINT 'created SchemaChangeMonitorEvent table';
GO
