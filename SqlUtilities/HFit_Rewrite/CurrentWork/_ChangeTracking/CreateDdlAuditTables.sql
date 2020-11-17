
GO
PRINT 'Creating the AUDIT tables.';
GO

--CreateDdlAuditTables

IF NOT EXISTS (SELECT
					  name

			   --FROM tempdb.dbo.sysobjects

				 FROM sysobjects
				 WHERE ID = OBJECT_ID (N'TBL_DIFF1')) 
	BEGIN
		CREATE TABLE dbo.TBL_DIFF1 (
					 table_name sysname NOT NULL
				   , COLUMN_NAME sysname NULL
				   , DATA_TYPE nvarchar (254) NULL
				   , CHARACTER_MAXIMUM_LENGTH nvarchar (254) NULL
				   , table_name2 sysname NULL
				   , DATA_TYPE2 nvarchar (254) NULL
				   , COLUMN_NAME2 sysname NULL
				   , CHARACTER_MAXIMUM_LENGTH2 int NULL
				   , NOTE varchar (max) NULL
				   , CreateDate datetime2 (7) NULL
										 DEFAULT GETDATE () 
				   , RowNbr int IDENTITY) ;
	END;
GO
PRINT 'Created AUDIT table TBL_DIFF1 of 4.';
GO
IF NOT EXISTS (SELECT
					  name

			   --FROM tempdb.dbo.sysobjects

				 FROM sysobjects
				 WHERE ID = OBJECT_ID (N'TBL_DIFF2')) 
	BEGIN
		CREATE TABLE dbo.TBL_DIFF2 (
					 table_name sysname NOT NULL
				   , COLUMN_NAME sysname NULL
				   , DATA_TYPE nvarchar (254) NULL
				   , CHARACTER_MAXIMUM_LENGTH nvarchar (254) NULL
				   , table_name2 sysname NULL
				   , DATA_TYPE2 nvarchar (254) NULL
				   , COLUMN_NAME2 sysname NULL
				   , CHARACTER_MAXIMUM_LENGTH2 int NULL
				   , NOTE varchar (max) NULL
				   , CreateDate datetime2 (7) NULL
										 DEFAULT GETDATE () 
				   , RowNbr int IDENTITY) ;
	END;
GO
PRINT 'Created AUDIT table TBL_DIFF2 of 4.';
GO
IF NOT EXISTS (SELECT
					  name

			   --FROM tempdb.dbo.sysobjects

				 FROM sysobjects
				 WHERE ID = OBJECT_ID (N'TBL_DIFF3')) 
	BEGIN
		CREATE TABLE dbo.TBL_DIFF3 (
					 table_name sysname NOT NULL
				   , COLUMN_NAME sysname NULL
				   , DATA_TYPE nvarchar (254) NULL
				   , CHARACTER_MAXIMUM_LENGTH nvarchar (254) NULL
				   , table_name2 sysname NULL
				   , DATA_TYPE2 nvarchar (254) NULL
				   , COLUMN_NAME2 sysname NULL
				   , CHARACTER_MAXIMUM_LENGTH2 int NULL
				   , NOTE varchar (max) 
				   , CreateDate datetime2 (7) DEFAULT GETDATE () 
				   , RowNbr int IDENTITY) ;
	END;
GO
PRINT 'Created AUDIT table TBL_DIFF3 of 4.';
GO
IF NOT EXISTS (SELECT
					  name

			   --FROM tempdb.dbo.sysobjects

				 FROM sysobjects
				 WHERE ID = OBJECT_ID (N'TBL_DIFF4')) 
	BEGIN
		CREATE TABLE dbo.TBL_DIFF4 (
					 table_name sysname NOT NULL
				   , COLUMN_NAME sysname NULL
				   , DATA_TYPE nvarchar (254) NULL
				   , CHARACTER_MAXIMUM_LENGTH nvarchar (254) NULL
				   , table_name2 sysname NULL
				   , DATA_TYPE2 nvarchar (254) NULL
				   , COLUMN_NAME2 sysname NULL
				   , CHARACTER_MAXIMUM_LENGTH2 int NULL
				   , NOTE varchar (max) 
				   , CreateDate datetime2 (7) DEFAULT GETDATE () 
				   , RowNbr int IDENTITY) ;
	END;
GO
PRINT 'Created AUDIT table TBL_DIFF4 of 4.';
GO
IF EXISTS (SELECT
				  name
			 FROM sys.views
			 WHERE name = 'view_SchemaDiff') 
	BEGIN
		DROP VIEW
			 view_SchemaDiff;
		PRINT 'Removed view_SchemaDiff.';
	END;
GO
PRINT 'Created view_SchemaDiff.';
GO
CREATE VIEW view_SchemaDiff
AS
	 SELECT
			*
	   FROM TBL_DIFF1
	 UNION
	 SELECT
			*
	   FROM TBL_DIFF2
	 UNION
	 SELECT
			*
	   FROM TBL_DIFF3;
GO
PRINT 'Create View view_SchemaChangeMonitor';
GO
IF EXISTS (SELECT
				  name
			 FROM sys.views
			 WHERE name = 'view_SchemaChangeMonitor') 
	BEGIN
		DROP VIEW
			 view_SchemaChangeMonitor;
	END;
GO
CREATE VIEW view_SchemaChangeMonitor
AS
	 SELECT
			PostTime
		  , DB_User
		  , IP_Address
		  , CUR_User
		  , Event
		  , TSQL
		  , OBJ
		  , RowNbr
	   FROM SchemaChangeMonitor;
GO
PRINT 'Created View view_SchemaChangeMonitor';
GO
PRINT 'Create View SchemaChangeMonitor_rptData';
GO
IF EXISTS (SELECT
				  name
			 FROM sys.views
			 WHERE name = 'view_SchemaChangeMonitor_rptData ') 
	BEGIN
		DROP VIEW
			 view_SchemaChangeMonitor_rptData;
	END;
GO
CREATE VIEW view_SchemaChangeMonitor_rptData
AS
	 SELECT
			label
		  , sText
		  , DisplayOrder
		  , RowNbr
	   FROM dbo.SchemaChangeMonitor_rptData;
GO
PRINT 'Created View view_SchemaChangeMonitor_rptData ';
PRINT 'AUDIT Tables created successfully';
GO



