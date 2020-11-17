
GO
PRINT 'FQN: SchemaChangeMonitor_rptData.SQL';
PRINT 'Creating SchemaChangeMonitor_rptData table';
GO
IF EXISTS (SELECT
				  name
			 FROM sys.tables
			 WHERE name = 'SchemaChangeMonitor_rptData') 
	BEGIN
		DROP TABLE
			 dbo.SchemaChangeMonitor_rptData;
	END;
IF NOT EXISTS (SELECT
					  name
				 FROM sys.tables
				 WHERE name = 'SchemaChangeMonitor_rptData') 
	BEGIN
		CREATE TABLE dbo.SchemaChangeMonitor_rptData (
					 label nvarchar (254) NOT NULL
				   , sText nvarchar (max) NOT NULL
				   , DisplayOrder int NOT NULL
				   , RowNbr int NOT NULL) ;
	END;
GO
PRINT 'Created SchemaChangeMonitor_rptData table';
GO

