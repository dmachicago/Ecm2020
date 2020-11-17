
--****************************************************************
-- NOTE: This database name must be changed in MANY places in 
--	this script. Please search and change.
--****************************************************************

PRINT 'FROM SetDB.sql';
PRINT 'Attached to DATABASE ' + DB_NAME () ;
DECLARE @CurrDB AS nvarchar (250) = DB_NAME () ;
DECLARE @MSQL AS nvarchar (250) = 'USE ' + @CurrDB;
EXEC (@MSQL) ;
GO



--***************************************************************
--***************************************************************

GO
PRINT 'Creating udfGetCurrentIP';
GO
IF EXISTS (SELECT
				  name
			 FROM sys.objects
			 WHERE name = 'udfGetCurrentIP') 
	BEGIN
		DROP FUNCTION
			 udfGetCurrentIP;
	END;
GO
CREATE FUNCTION dbo.udfGetCurrentIP () 
RETURNS varchar (255) 
AS
	 BEGIN

		 --*********************************************************
		 --WDM 03.21.2009 Get the IP address of the current client.
		 --Used to track a DBA/Developer IP address when change is 
		 --applied to a table or view.
		 --*********************************************************

		 DECLARE @IP_Address varchar (254) ;
		 SELECT
				@IP_Address = client_net_address
		   FROM sys.dm_exec_connections
		   WHERE Session_id = @@SPID;
		 RETURN @IP_Address;
	 END;

--Same as above
--SELECT CONVERT(char(15), CONNECTIONPROPERTY('client_net_address'))

GO
PRINT 'Created udfGetCurrentIP';
GO


--***************************************************************
--***************************************************************


GO
PRINT 'Creating TRIGGER trgSchemaMonitor.';
GO
IF EXISTS (SELECT
				  name
				  FROM sys.triggers
				  WHERE name = 'trgSchemaMonitor') 
	BEGIN
		PRINT 'DISABELING TRIGGER trgSchemaMonitor.';
		DECLARE @S nvarchar (200) ;
		SET @S = 'DISABLE TRIGGER trgSchemaMonitor ON DATABASE';
		EXEC (@S) ;
	END;
GO
PRINT 'Creating trgSchemaMonitor for #44945';
PRINT 'Dropping trgSchemaMonitor if it exists';
IF EXISTS (SELECT
				  name
				  FROM sys.triggers
				  WHERE name = 'trgSchemaMonitor') 
	BEGIN
		PRINT 'Dropping trgSchemaMonitor';
		DROP TRIGGER
			 trgSchemaMonitor ON DATABASE;
	END;
GO

--print('CHANGING to the instrument DB.');
--GO
--use instrument
--go

PRINT 'FQN: trgSchemaMonitor.SQL';
PRINT 'Processing trgSchemaMonitor.sql';
GO

--if exists(Select name from sys.triggers where name = 'trgSchemaMonitor')
--BEGIN
--	drop trigger trgSchemaMonitor ;
--	print('TRIGGER trgSchemaMonitor found and removed, continuing.');
--END
--go

IF EXISTS (SELECT
				  name
				  FROM sys.tables
				  WHERE name = 'SchemaChangeMonitor') 
	BEGIN
		DROP TABLE
			 dbo.SchemaChangeMonitor;
		PRINT 'Table SchemaChangeMonitor found, continuing.';
	END;
GO
SET ANSI_NULLS ON;
SET ANSI_PADDING ON;
SET ANSI_WARNINGS ON;
SET ARITHABORT ON;
SET CONCAT_NULL_YIELDS_NULL ON;
SET NUMERIC_ROUNDABORT OFF;

--WDM

SET QUOTED_IDENTIFIER ON;
IF NOT EXISTS (SELECT
					  name
					  FROM sys.tables
					  WHERE name = 'SchemaChangeMonitor') 
	BEGIN
		PRINT 'Creating table SchemaChangeMonitor.';

		--drop TABLE SchemaChangeMonitor 
		--go

		CREATE TABLE dbo.SchemaChangeMonitor (
					 PostTime datetime2 (7) NULL
				   , DB_User nvarchar (254) NULL
				   , IP_Address nvarchar (254) NULL
				   , CUR_User nvarchar (254) NULL
				   , Event nvarchar (254) NULL
				   , TSQL nvarchar (max) NULL
				   , OBJ nvarchar (254) NULL
				   , RowNbr int IDENTITY (1, 1) 
								NOT NULL
				   , ServerName nvarchar (254) NULL) ;

	--ON [PRIMARY] TEXTIMAGE_ON [PRIMARY];
	--ALTER TABLE dbo.SchemaChangeMonitor
	--ADD
	--			CONSTRAINT DF_SchemaChangeMonitor_ServerName DEFAULT @@servername FOR ServerName;
	--CREATE NONCLUSTERED INDEX PI_SchemaChangeMonitor ON dbo.SchemaChangeMonitor (OBJ ASC) ;
	--GRANT SELECT ON [dbo].[SchemaChangeMonitor] TO [platformuser_dev] ;
	--GRANT INSERT ON [dbo].[SchemaChangeMonitor] TO [platformuser_dev] ;
	--REVOKE DELETE ON [dbo].[SchemaChangeMonitor] TO [platformuser_dev] ;
	--REVOKE UPDATE ON [dbo].[SchemaChangeMonitor] TO [platformuser_dev] ;

	END;
GO
IF EXISTS (SELECT
				  name
				  FROM sys.tables
				  WHERE name = 'SchemaMonitorObjectName') 
	BEGIN
		PRINT 'Table SchemaMonitorObjectName FOUND, continuing.';
	END;
IF NOT EXISTS (SELECT
					  name
					  FROM sys.tables
					  WHERE name = 'SchemaMonitorObjectName') 
	BEGIN
		PRINT 'Creating table SchemaMonitorObjectName';
		SET ANSI_NULLS ON;
		SET ANSI_PADDING ON;
		SET ANSI_WARNINGS ON;
		SET ARITHABORT ON;
		SET CONCAT_NULL_YIELDS_NULL ON;
		SET NUMERIC_ROUNDABORT OFF;
		SET QUOTED_IDENTIFIER ON;

		--drop TABLE dbo.SchemaMonitorObjectName
		--go

		CREATE TABLE dbo.SchemaMonitorObjectName (
					 ObjectName nvarchar (254) 
				   , ObjectType nvarchar (25)) ;
		CREATE UNIQUE CLUSTERED INDEX PKI_SchemaMonitorObjectName ON dbo.SchemaMonitorObjectName (ObjectName ASC, ObjectType ASC) ;
	END;
GO
IF EXISTS (SELECT
				  name
				  FROM sys.tables
				  WHERE name = 'SchemaMonitorObjectNotify') 
	BEGIN
		PRINT 'Table SchemaMonitorObjectNotify NOT FOUND, continuing.';
	END;
IF NOT EXISTS (SELECT
					  name
					  FROM sys.tables
					  WHERE name = 'SchemaMonitorObjectNotify') 
	BEGIN		
		SET ANSI_NULLS ON;
		SET ANSI_PADDING ON;
		SET ANSI_WARNINGS ON;
		SET ARITHABORT ON;
		SET CONCAT_NULL_YIELDS_NULL ON;
		SET NUMERIC_ROUNDABORT OFF;
		SET QUOTED_IDENTIFIER ON;
		CREATE TABLE dbo.SchemaMonitorObjectNotify (
					 EmailAddr nvarchar (254)) ;
		CREATE UNIQUE CLUSTERED INDEX PCI_SchemaMonitorObjectNotify ON dbo.SchemaMonitorObjectNotify (EmailAddr ASC) ;

		--GRANT SELECT ON [dbo].SchemaMonitorObjectNotify TO [platformuser_dev] ;
		--GRANT INSERT ON [dbo].SchemaMonitorObjectNotify TO [platformuser_dev] ;
		--REVOKE DELETE ON [dbo].SchemaMonitorObjectNotify TO [platformuser_dev] ;
		--REVOKE UPDATE ON [dbo].SchemaMonitorObjectNotify TO [platformuser_dev] ;		

		INSERT INTO dbo.SchemaMonitorObjectNotify (
					EmailAddr) 
		VALUES
			 ('wdalemiller@gmail.com') ;
	END;
GO
PRINT 'Creating view_SchemaChangeMonitor';
GO

--DROP TRIGGER trgSchemaMonitor on DATABASE
--disable TRIGGER trgSchemaMonitor on DATABASE
--enable TRIGGER trgSchemaMonitor on DATABASE

IF EXISTS (SELECT
				  name
				  FROM sys.views
				  WHERE name = 'view_SchemaChangeMonitor') 
	BEGIN
		PRINT 'Creating view_SchemaChangeMonitor, continuing';
		DROP VIEW
			 view_SchemaChangeMonitor;
	END;
GO
CREATE VIEW view_SchemaChangeMonitor
AS SELECT
		  PostTime
		, DB_User
		, IP_Address
		, CUR_User
		, Event
		, TSQL
		, OBJ
		  FROM SchemaChangeMonitor;
GO

--GRANT SELECT ON  [dbo].view_SchemaChangeMonitor TO [platformuser_dev] ;
--GRANT INSERT ON  [Schema].[Table] TO [User] ;
--REVOKE DELETE ON  [Schema].[Table] TO [User] ;
--REVOKE UPDATE ON  [Schema].[Table] TO [User] ;

PRINT 'Created view_SchemaChangeMonitor';
GO
IF EXISTS (SELECT
				  name
				  FROM sys.triggers
				  WHERE name = 'trgSchemaMonitor') 
	BEGIN
		PRINT 'creating trgSchemaMonitor';
		DROP TRIGGER
			 trgSchemaMonitor;
	END;
GO
PRINT 'Updating trgSchemaMonitor';
GO

--disable TRIGGER dbo.trgSchemaMonitor database

DECLARE @DB nvarchar (100) = (SELECT
									 DB_NAME ()) ;
PRINT 'Current DB: ' + @DB;
IF @DB = 'KenticoCMS_QA'
	BEGIN
		DECLARE @I int = 0;
		SET @i = (SELECT
						 COUNT (*) 
						 FROM SchemaMonitorObjectNotify
						 WHERE EmailAddr = 'John.Croft@hfit.com') ;
		IF @i = 0
			BEGIN
				INSERT INTO dbo.SchemaMonitorObjectNotify (
							EmailAddr) 
				VALUES
					 ('John.Croft@hfit.com') ;
			END;
		ELSE
			BEGIN
				PRINT 'Croft already exists in GREEN.';
			END;
		GRANT SELECT ON dbo.view_SchemaDiff TO JCroft;
		GRANT SELECT ON dbo.view_SchemaChangeMonitor TO JCroft;
		PRINT 'Added John Croft to the Schema Monitor system.';
	END;
GO
CREATE TRIGGER trgSchemaMonitor ON DATABASE
	FOR DDL_DATABASE_LEVEL_EVENTS
AS
SET ANSI_NULLS ON;
SET ANSI_PADDING ON;
SET ANSI_WARNINGS ON;
SET ARITHABORT ON;
SET CONCAT_NULL_YIELDS_NULL ON;
SET NUMERIC_ROUNDABORT OFF;
SET QUOTED_IDENTIFIER ON;
DECLARE @data xml;
DECLARE @IPADDR nvarchar (254) ;
DECLARE @CUR_User nvarchar (254) ;
SET @CUR_User = SYSTEM_USER;
SET @IPADDR = (SELECT
					  CONVERT (nvarchar (254) , CONNECTIONPROPERTY ('client_net_address'))) ;
SET @data = EVENTDATA () ;
SET NOCOUNT ON;
INSERT INTO SchemaChangeMonitor (
			PostTime
		  , DB_User
		  , IP_Address
		  , CUR_User
		  , OBJ
		  , Event
		  , TSQL) 
VALUES
	 (GETDATE () , CONVERT (nvarchar (254) , CURRENT_USER) , @IPADDR, @CUR_User, @data.value ('(/EVENT_INSTANCE/ObjectName)[1]', 'nvarchar(254)') , @data.value ('(/EVENT_INSTANCE/EventType)[1]', 'nvarchar(254)') , @data.value ('(/EVENT_INSTANCE/TSQLCommand)[1]', 'nvarchar(max)')) ;

--THIS WILL DELETE records older than 90 days.
--delete from SchemaChangeMonitor where PostTime < getdate() - 90 ;

SET NOCOUNT OFF;
GO

--grant execute on trgSchemaMonitor to PUBLIC ;
--go
--grant execute on sp_SchemaMonitorReport to platformuser_dev ; 
--GO

DISABLE TRIGGER
 trgSchemaMonitor ON DATABASE;
PRINT '********************************************************************';
PRINT 'DATABASE trgSchemaMonitor HAS BEEN DISABLED       ******************';
PRINT '********************************************************************';
PRINT 'Processed trgSchemaMonitor.sql';

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




--exec sp_SchemaMonitorReport

GO
PRINT 'FQN: sp_SchemaMonitorReport.SQL';
PRINT 'Creating procedure sp_SchemaMonitorReport ';
GO
IF EXISTS (SELECT name
				  FROM sys.objects
				  WHERE name = 'sp_SchemaMonitorReport') 
	BEGIN
		DROP PROCEDURE sp_schemamonitorreport;
	END;
GO
CREATE PROC dbo.sp_schemamonitorreport
AS
BEGIN

	--print('Start') ;

	truncate TABLE schemachangemonitor_rptdata;
	DECLARE deltas CURSOR
		FOR SELECT posttime
				 , db_user
				 , ip_address
				 , cur_user
				 , event
				 , tsql
				 , obj
				 , rownbr
				   FROM schemachangemonitor
				   WHERE posttime BETWEEN GETDATE () - 1 AND GETDATE () 
					 AND event IN (
								   SELECT event
										  FROM schemachangemonitorevent) 
				   ORDER BY obj, posttime;
	DECLARE @Posttime datetime;
	DECLARE @Db_User nvarchar (254) ;
	DECLARE @Ip_Address nvarchar (254) ;
	DECLARE @Cur_User nvarchar (254) ;
	DECLARE @Event nvarchar (254) ;
	DECLARE @Tsql nvarchar (max) ;
	DECLARE @Obj nvarchar (254) ;
	DECLARE @Displayorder int;
	DECLARE @Rownbr int;
	DECLARE @Dorder int;
	DECLARE @Onerecipient varchar (254) ;
	DECLARE @Allrecipients varchar (max) = '';
	DECLARE @Fromdate varchar (254) = CAST (GETDATE () - 1 AS varchar (254)) ;
	DECLARE @Todate varchar (254) = CAST (GETDATE () AS varchar (254)) ;
	DECLARE @Subj varchar (254) = 'Schema Mods between ' + @Fromdate + ' and ' + @Todate;
	OPEN deltas;
	FETCH next FROM deltas INTO @Posttime, @Db_User, @Ip_Address, @Cur_User, @Event, @Tsql, @Obj, @Rownbr;
	WHILE @@Fetch_Status = 0
		BEGIN
			SET @Dorder = 1;
			INSERT INTO schemachangemonitor_rptdata (label
												   , stext
												   , displayorder
												   , rownbr) 
			VALUES
				 ('OBJ', @Obj, @Dorder, @Rownbr) ;
			SET @Dorder = 2;
			INSERT INTO schemachangemonitor_rptdata (label
												   , stext
												   , displayorder
												   , rownbr) 
			VALUES
				 ('Event', @Event, @Dorder, @Rownbr) ;
			SET @Dorder = 3;
			INSERT INTO schemachangemonitor_rptdata (label
												   , stext
												   , displayorder
												   , rownbr) 
			VALUES
				 ('TSQL', @Tsql, @Dorder, @Rownbr) ;
			SET @Dorder = @Dorder + 1;
			INSERT INTO schemachangemonitor_rptdata (label
												   , stext
												   , displayorder
												   , rownbr) 
			VALUES
				 ('PostTime', @Posttime, @Dorder, @Rownbr) ;
			SET @Dorder = @Dorder + 1;
			INSERT INTO schemachangemonitor_rptdata (label
												   , stext
												   , displayorder
												   , rownbr) 
			VALUES
				 ('IP_Address', @Ip_Address, @Dorder, @Rownbr) ;
			SET @Dorder = @Dorder + 1;
			INSERT INTO schemachangemonitor_rptdata (label
												   , stext
												   , displayorder
												   , rownbr) 
			VALUES
				 ('DB_User', @Db_User, @Dorder, @Rownbr) ;
			SET @Dorder = @Dorder + 1;
			INSERT INTO schemachangemonitor_rptdata (label
												   , stext
												   , displayorder
												   , rownbr) 
			VALUES
				 ('CUR_User', @Cur_User, @Dorder, @Rownbr) ;
			SET @Dorder = @Dorder + 1;
			INSERT INTO schemachangemonitor_rptdata (label
												   , stext
												   , displayorder
												   , rownbr) 
			VALUES
				 ('END', '******************************', @Dorder, @Rownbr) ;
			FETCH next FROM deltas INTO @Posttime, @Db_User, @Ip_Address, @Cur_User, @Event, @Tsql, @Obj, @Rownbr;
		END;
	CLOSE deltas;
	DEALLOCATE deltas;
	DECLARE getemails CURSOR
		FOR SELECT emailaddr
				   FROM schemamonitorobjectnotify;
	OPEN getemails;
	FETCH next FROM getemails INTO @Onerecipient;
	WHILE @@Fetch_Status = 0
		BEGIN
			SET @Allrecipients = @Allrecipients + @Onerecipient + ';';
			FETCH next FROM getemails INTO @Onerecipient;
		END;
	CLOSE getemails;
	DEALLOCATE getemails;
	DECLARE @Currsvr AS nvarchar (254) = '';
	SET @Currsvr = @@Servername;
	DECLARE @Modifiedobjects AS nvarchar (max) = 'Server: ' + @Currsvr + CHAR (13) + CHAR (10) + '- The following DB Objects have been modified within the last 24 hours:' + CHAR (13) + CHAR (10) ;
	DECLARE @Stext AS nvarchar (max) ;
	DECLARE getobjs CURSOR
		FOR SELECT DISTINCT obj + ' : ' + event + ' : ' + ' : ' + cur_user AS info
				   FROM kenticocms_qa.dbo.schemachangemonitor
				   WHERE posttime > GETDATE () - 1;

	--SELECT DISTINCT
	--  sText
	--  FROM view_SchemaChangeMonitor_rptData
	--  WHERE label = 'OBJ'
	--  GROUP BY
	--		sText
	--  ORDER BY
	--		sText;

	OPEN getobjs;
	FETCH next FROM getobjs INTO @Stext;
	WHILE @@Fetch_Status = 0
		BEGIN
			SET @Modifiedobjects = @Modifiedobjects + CHAR (13) + CHAR (10) + CHAR (13) + CHAR (10) + @Stext;
			FETCH next FROM getobjs INTO @Stext;
		END;
	CLOSE getobjs;
	DEALLOCATE getobjs;
	SET @Modifiedobjects = @Modifiedobjects + CHAR (13) + CHAR (10) + ' ';
	SET @Modifiedobjects = @Modifiedobjects + CHAR (13) + CHAR (10) + '_______________________________________________________' + CHAR (13) + CHAR (10) ;
	SET @Modifiedobjects = @Modifiedobjects + 'The Following Views can be used to review the changes:' + CHAR (13) + CHAR (10) + ' ';
	SET @Modifiedobjects = @Modifiedobjects + '    view_SchemaChangeMonitor_rptData' + CHAR (13) + CHAR (10) + ' ';
	SET @Modifiedobjects = @Modifiedobjects + '    view_SchemaChangeMonitor' + CHAR (13) + CHAR (10) + ' ';
	PRINT @Modifiedobjects;
	DECLARE @Db AS nvarchar (250) ;
	DECLARE @Qry AS nvarchar (254) ;
	SET @Db = DB_NAME () ;
	SET @Qry = 'SELECT distinct OBJ, Event, CUR_User, IP_Address, TSQL FROM ' + @Db + '..SchemaChangeMonitor where PostTime between getdate()- 1 and getdate()';
	PRINT 'Report Sent To: ' + @Allrecipients;

	--EXEC msdb..sp_send_dbmail @profile_name = 'databaseBot', @recipients = @allrecipients, @subject = @subj, @body = @ModifiedObjects, @execute_query_database = 'msdb', @query = @QRY;

	EXEC msdb..sp_send_dbmail @Profile_Name = 'databaseBot', @Recipients = @Allrecipients, @Subject = @Subj, @Body = @Modifiedobjects, @Execute_Query_Database = 'msdb', @Query = NULL;
END;
GO
PRINT 'Created sp_SchemaMonitorReport';
GO

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

GO
PRINT 'FQN: SchemaChangeMonitor.SQL';
PRINT 'Creating SchemaChangeMonitor table';
GO
SET ANSI_NULLS ON
SET ANSI_PADDING ON
SET ANSI_WARNINGS ON
SET ARITHABORT ON
SET CONCAT_NULL_YIELDS_NULL ON
SET NUMERIC_ROUNDABORT OFF
SET QUOTED_IDENTIFIER ON
IF EXISTS (SELECT
				  name
			 FROM sys.tables
			 WHERE name = 'SchemaChangeMonitor') 
	BEGIN
		PRINT 'DROP SchemaChangeMonitor table';
		DROP TABLE
			 dbo.SchemaChangeMonitor;
	END;
IF NOT EXISTS (SELECT
					  name
				 FROM sys.tables
				 WHERE name = 'SchemaChangeMonitor') 
	BEGIN
		
CREATE TABLE [dbo].[SchemaChangeMonitor](
	[PostTime] [datetime2](7) NULL,
	[DB_User] [nvarchar](254) NULL,
	[IP_Address] [nvarchar](254) NULL,
	[CUR_User] [nvarchar](254) NULL,
	[Event] [nvarchar](254) NULL,
	[TSQL] [nvarchar](max) NULL,
	[OBJ] [nvarchar](254) NULL,
	[RowNbr] [int] IDENTITY(1,1) NOT NULL,
	[ServerName] [nvarchar](254) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY] ;

ALTER TABLE [dbo].[SchemaChangeMonitor] ADD  CONSTRAINT [DF_SchemaChangeMonitor_ServerName]  DEFAULT (@@servername) FOR [ServerName];

	END;
GO
GO
PRINT 'Created SchemaChangeMonitor table';
GO


--drop table [TBL_DIFF1] ;
--drop table [TBL_DIFF2] ;
--drop table [TBL_DIFF3] ;
--drop table [TBL_DIFF4] ;

GO
PRINT 'Processing Proc_EDW_Compare_Tables';
GO
IF EXISTS (SELECT
				  name
			 FROM sys.procedures
			 WHERE name = 'Proc_EDW_Compare_Tables') 
	BEGIN
		PRINT 'Updating Proc_EDW_Compare_Tables';
		DROP PROCEDURE
			 Proc_EDW_Compare_Tables;
	END;
GO
CREATE PROCEDURE Proc_EDW_Compare_Tables (@LinkedSVR AS nvarchar (254) 
										, @LinkedDB AS nvarchar (254) 
										, @LinkedTBL AS nvarchar (254) 
										, @CurrDB AS nvarchar (254) 
										, @CurrTBL AS nvarchar (254) 
										, @NewRun AS int) 
AS
	 BEGIN
		 PRINT 'Comparing: ' + @LinkedSVR + ' : ' + @LinkedDB + ' : ' + @LinkedTBL;
		 PRINT 'TO: ' + @CurrDB + ' : ' + @CurrTBL;
		 DECLARE @ParmDefinition AS nvarchar (max) ;
		 DECLARE @retval int = 0;
		 DECLARE @S AS nvarchar (254) = '';
		 DECLARE @SVR AS varchar (254) = @LinkedSVR;
		 DECLARE @iCnt AS int;
		 DECLARE @iRetval AS int = 0;
		 DECLARE @Note AS nvarchar (max) = '';
		 SET @S = 'SELECT @retval = count(*) FROM sys.servers WHERE name = @TgtSVR ';
		 SET @ParmDefinition = N'@TgtSVR nvarchar(254), @retval bit OUTPUT';
		 EXEC sp_executesql @S, @ParmDefinition, @TgtSVR = @LinkedSVR, @retval = @iRetval OUTPUT;
		 SET @iCnt = (SELECT
							 @iRetval) ;
		 IF @iCnt = 1
			 BEGIN EXEC master.sys.sp_dropserver @LinkedSVR, 'droplogins'
			 END;
		 EXEC sp_addlinkedserver @LinkedSVR, 'SQL Server';
		 SET @S = 'select @retval = count(*) from [' + @LinkedSVR + '].[' + @LinkedDB + '].sys.tables where NAME = @TgtTBL ';
		 SET @ParmDefinition = N'@TgtTBL nvarchar(254), @retval int OUTPUT';
		 EXEC sp_executesql @S, @ParmDefinition, @TgtTBL = @LinkedTBL, @retval = @iRetval OUTPUT;
		 SET @iCnt = (SELECT
							 @iRetval) ;

		 --print ('Step01');

		 IF @iCnt = 0
			 BEGIN
				 PRINT @LinkedTBL + ' : Table does not exist on server ' + @LinkedSVR + ' in database ' + @LinkedDB + '.';
				 DECLARE @SSQL AS nvarchar (max) = '';
				 DECLARE @msg AS nvarchar (max) = '';
				 SET @msg = @LinkedTBL + ' : Table does not exist on server ' + @LinkedSVR + ' in database ' + @LinkedDB + '.';
				 SET @SSQL = 'INSERT INTO TBL_DIFF1 (table_name, COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH, table_name2, DATA_TYPE2, COLUMN_NAME2, CHARACTER_MAXIMUM_LENGTH2, Note) ';
				 SET @SSQL = @SSQL + 'VALUES ( ';
				 SET @SSQL = @SSQL + '''' + @CurrTBL + ''', null, null , null, null ,null,null, null, ''' + @msg + ''' ';
				 SET @SSQL = @SSQL + ')';
				 EXEC (@SSQL) ;
				 RETURN;
			 END;

		 --set @S  = 'SELECT @retval = count(*) FROM sys.servers WHERE name = @TgtSVR ' ;
		 --set @ParmDefinition  = N'@TgtSVR nvarchar(254), @retval bit OUTPUT' ;
		 --exec sp_executesql @S, @ParmDefinition, @TgtSVR = @LinkedSVR, @retval = @iRetval OUTPUT ;
		 --set @iCnt = (select @iRetval) ;
		 --IF (@iCnt = 1)
		 --	EXEC master.sys.sp_dropserver @LinkedSVR,'droplogins'  ;
		 --print ('Step02');

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
							, CreateDate datetime2(7) DEFAULT GETDATE () 
							, RowNbr int IDENTITY) ;
			 END;
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
							, CreateDate datetime2(7) DEFAULT GETDATE () 
							, RowNbr int IDENTITY) ;
			 END;
		 IF @NewRun = 1
			 BEGIN
				 truncate TABLE TBL_DIFF1;
				 truncate TABLE TBL_DIFF2;
				 truncate TABLE TBL_DIFF3;
			 END;
		 DECLARE @MySQL AS nvarchar (max) ;
		 SET @MySQL = 'INSERT INTO TBL_DIFF1 (table_name, COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH, table_name2, DATA_TYPE2, COLUMN_NAME2, CHARACTER_MAXIMUM_LENGTH2, Note) ';
		 SET @MySQL = @MySql + 'select c1.table_name, c1.COLUMN_NAME, c1.DATA_TYPE , cast (c1.CHARACTER_MAXIMUM_LENGTH as nvarchar(254)) as CHARACTER_MAXIMUM_LENGTH, c2.table_name as table_name2 ,c2.DATA_TYPE as DATA_TYPE2 ,c2.COLUMN_NAME as COLUMN_NAME2, c2.CHARACTER_MAXIMUM_LENGTH as CHARACTER_MAXIMUM_LENGTH2, ''Data Types or Data Length Differ'' ';
		 SET @MySQL = @MySQL + 'from [' + @LinkedSVR + '].[' + @LinkedDB + '].[INFORMATION_SCHEMA].[COLUMNS] c1 ';
		 SET @MySQL = @MySQL + 'left join ' + @CurrDB + '.[INFORMATION_SCHEMA].[COLUMNS] c2 on c1.TABLE_NAME = c2.TABLE_NAME ';
		 SET @MySQL = @MySQL + 'where c1.TABLE_NAME= ''' + @LinkedTBL + ''' and c2.TABLE_NAME = ''' + @CurrTBL + ''' ';
		 SET @MySQL = @MySQL + 'and C1.column_name = c2.column_name ';
		 SET @MySQL = @MySQL + 'and ((c1.data_type <> c2.DATA_TYPE) ';
		 SET @MySQL = @MySQL + '		OR (c1.data_type = c2.DATA_TYPE AND c1.CHARACTER_MAXIMUM_LENGTH <> c2.CHARACTER_MAXIMUM_LENGTH))';
		 EXEC (@MySql) ;

		 --print ('Step05');

		 SET @MySQL = '';
		 SET @MySQL = 'INSERT INTO TBL_DIFF2 (table_name, COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH, table_name2, DATA_TYPE2, COLUMN_NAME2, CHARACTER_MAXIMUM_LENGTH2, Note) ';
		 SET @MySQL = @MySQL + 'SELECT c1.TABLE_NAME, c1.COLUMN_NAME, c1.DATA_TYPE, ''' + @CurrDB + ''' as DBNAME, ''MISSING'' as C1, ''NA'' as C2 , ''NA'' as C3, 0 as I1, ''Column ''+c1.COLUMN_NAME+'' Missing in: ' + @CurrDB + ' / ' + @CurrTBL + ' ''  ';
		 SET @MySQL = @MySQL + ' FROM  [' + @LinkedSVR + '].[' + @LinkedDB + '].INFORMATION_SCHEMA.COLUMNS AS c1 ';
		 SET @MySQL = @MySQL + ' WHERE  C1.table_name = ''' + @CurrTBL + ''' ';
		 SET @MySQL = @MySQL + ' 	AND c1.column_name not in ';
		 SET @MySQL = @MySQL + ' 	(select column_name from ' + @CurrDB + '.INFORMATION_SCHEMA.columns C2 where C2.table_name = ''' + @LinkedTBL + ''') ';
		 EXEC (@MySql) ;

		 --print ('Step06');

		 SET @MySQL = 'INSERT INTO TBL_DIFF3 (table_name, COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH, table_name2, DATA_TYPE2, COLUMN_NAME2, CHARACTER_MAXIMUM_LENGTH2, Note) ';
		 SET @MySQL = @MySQL + 'SELECT c1.TABLE_NAME, c1.COLUMN_NAME, c1.DATA_TYPE, ''' + @LinkedDB + ''' as DBNAME, ''MISSING'' as C1, ''NA'' as C2, ''NA'' as C3, -1 as I1, ''Column ''+c1.COLUMN_NAME+'' Missing in: ' + @LinkedDB + ' / ' + @LinkedTBL + ' ''  ';
		 SET @MySQL = @MySQL + ' FROM [' + @CurrDB + '].INFORMATION_SCHEMA.COLUMNS as C1 ';
		 SET @MySQL = @MySQL + ' WHERE  C1.table_name = ''' + @CurrTBL + ''' ';
		 SET @MySQL = @MySQL + ' AND c1.column_name not in ';
		 SET @MySQL = @MySQL + ' (select column_name from [' + @LinkedSVR + '].[' + @LinkedDB + '].INFORMATION_SCHEMA.columns C2 where C2.table_name = ''' + @LinkedTBL + ''') ';
		 EXEC (@MySql) ;

		 --print ('Step07');

		 SET @S = 'SELECT @retval = count(*) FROM sys.servers WHERE name = @TgtSVR ';
		 SET @ParmDefinition = N'@TgtSVR nvarchar(254), @retval bit OUTPUT';
		 EXEC sp_executesql @S, @ParmDefinition, @TgtSVR = @LinkedSVR, @retval = @iRetval OUTPUT;
		 SET @iCnt = (SELECT
							 @iRetval) ;
		 IF @iCnt = 1
			 BEGIN EXEC master.sys.sp_dropserver @LinkedSVR, 'droplogins'
			 END;

		 --print ('Step08');

		 IF NOT EXISTS (SELECT
							   name
						  FROM sys.views
						  WHERE name = 'view_SchemaDiff') 
			 BEGIN
				 DECLARE @sTxt AS nvarchar (max) = '';
				 SET @sTxt = @sTxt + 'Create view view_SchemaDiff AS ';
				 SET @sTxt = @sTxt + 'Select * from TBL_DIFF1 ';
				 SET @sTxt = @sTxt + 'union ';
				 SET @sTxt = @sTxt + 'Select * from TBL_DIFF2  ';
				 SET @sTxt = @sTxt + 'union ';
				 SET @sTxt = @sTxt + 'Select * from TBL_DIFF3  ';
				 EXEC (@sTxt) ;
				 PRINT 'Created view view_SchemaDiff.';
			 END;

		 --Select * from TBL_DIFF1 
		 --union
		 --Select * from TBL_DIFF2 
		 --union
		 --Select * from TBL_DIFF3 

		 PRINT 'To see "deltas" - select * from view_SchemaDiff';
		 PRINT '_________________________________________________';
	 END;
GO
PRINT 'Created Proc_EDW_Compare_Tables';
GO

	
--drop table [TBL_DIFF1] ;
--drop table [TBL_DIFF2] ;
--drop table [TBL_DIFF3] ;
--drop table [TBL_DIFF4] ;

GO
PRINT 'Creating Proc_EDW_Compare_Views';
GO
IF EXISTS (SELECT
				  name
			 FROM sys.procedures
			 WHERE name = 'Proc_EDW_Compare_Views') 
	BEGIN
		DROP PROCEDURE
			 Proc_EDW_Compare_Views;
	END;
GO
CREATE PROCEDURE Proc_EDW_Compare_Views (@LinkedSVR AS nvarchar (254) 
									   , @LinkedDB AS nvarchar (254) 
									   , @LinkedVIEW AS nvarchar (254) 
									   , @CurrDB AS nvarchar (254) 
									   , @CurrVIEW AS nvarchar (254) 
									   , @NewRun AS int) 
AS
	 BEGIN
		 DECLARE @ParmDefinition AS nvarchar (max) ;
		 DECLARE @retval int = 0;
		 DECLARE @S AS nvarchar (250) = '';
		 DECLARE @SVR AS varchar (254) = @LinkedSVR;
		 DECLARE @iCnt AS int;
		 DECLARE @iRetval AS int = 0;
		 DECLARE @Note AS nvarchar (max) = '';
		 SET @S = 'SELECT @retval = count(*) FROM sys.servers WHERE name = @TgtSVR ';
		 SET @ParmDefinition = N'@TgtSVR nvarchar(254), @retval bit OUTPUT';
		 EXEC sp_executesql @S, @ParmDefinition, @TgtSVR = @LinkedSVR, @retval = @iRetval OUTPUT;
		 SET @iCnt = (SELECT
							 @iRetval) ;
		 IF @iCnt = 1
			 BEGIN EXEC master.sys.sp_dropserver @LinkedSVR, 'droplogins'
			 END;
		 EXEC sp_addlinkedserver @LinkedSVR, 'SQL Server';
		 SET @S = 'select @retval = count(*) from [' + @LinkedSVR + '].[' + @LinkedDB + '].sys.views where NAME = @TgtVIEW ';
		 SET @ParmDefinition = N'@TgtVIEW nvarchar(254), @retval int OUTPUT';
		 EXEC sp_executesql @S, @ParmDefinition, @TgtVIEW = @LinkedVIEW, @retval = @iRetval OUTPUT;
		 SET @iCnt = (SELECT
							 @iRetval) ;

		 --print ('Step01');

		 IF @iCnt = 0
			 BEGIN
				 PRINT @LinkedVIEW + ' : VIEW does not exist on server ' + @LinkedSVR + ' in database ' + @LinkedDB + '.';
				 DECLARE @SSQL AS nvarchar (max) = '';
				 DECLARE @msg AS nvarchar (max) = '';
				 SET @msg = @LinkedVIEW + ' : VIEW does not exist on server ' + @LinkedSVR + ' in database ' + @LinkedDB + '.';
				 SET @SSQL = 'INSERT INTO TBL_DIFF1 (table_name, COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH, table_name2, DATA_TYPE2, COLUMN_NAME2, CHARACTER_MAXIMUM_LENGTH2, Note) ';
				 SET @SSQL = @SSQL + 'VALUES ( ';
				 SET @SSQL = @SSQL + '''' + @CurrVIEW + ''', null, null , null, null ,null,null, null, ''' + @msg + ''' ';
				 SET @SSQL = @SSQL + ')';
				 EXEC (@SSQL) ;
				 RETURN;
			 END;
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
							, NOTE varchar (max) 
							, CreateDate datetime2 (7) NULL
												  DEFAULT GETDATE () 
							, RowNbr int IDENTITY) ;
			 END;
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
							, NOTE varchar (max) 
							, RowNbr int IDENTITY) ;
			 END;
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
							, CreateDate datetime2 (7) NULL
												  DEFAULT GETDATE () 
							, RowNbr int IDENTITY) ;
			 END;
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
							, CreateDate datetime2 (7) NULL
												  DEFAULT GETDATE () 
							, RowNbr int IDENTITY) ;
			 END;
		 IF @NewRun = 1
			 BEGIN
				 truncate TABLE TBL_DIFF1;
				 truncate TABLE TBL_DIFF2;
				 truncate TABLE TBL_DIFF3;
			 END;
		 DECLARE @MySQL AS nvarchar (max) ;
		 SET @MySQL = 'INSERT INTO TBL_DIFF1 (table_name, COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH, table_name2, DATA_TYPE2, COLUMN_NAME2, CHARACTER_MAXIMUM_LENGTH2, Note) ';
		 SET @MySQL = @MySql + 'select c1.table_name, c1.COLUMN_NAME, c1.DATA_TYPE , cast (c1.CHARACTER_MAXIMUM_LENGTH as nvarchar(254)) as CHARACTER_MAXIMUM_LENGTH, c2.table_name as table_name2 ,c2.DATA_TYPE as DATA_TYPE2 ,c2.COLUMN_NAME as COLUMN_NAME2, c2.CHARACTER_MAXIMUM_LENGTH as CHARACTER_MAXIMUM_LENGTH2, ''Data Types or Data Length Differ'' ';
		 SET @MySQL = @MySQL + 'from [' + @LinkedSVR + '].[' + @LinkedDB + '].[INFORMATION_SCHEMA].[COLUMNS] c1 ';
		 SET @MySQL = @MySQL + 'left join ' + @CurrDB + '.[INFORMATION_SCHEMA].[COLUMNS] c2 on c1.TABLE_NAME = c2.TABLE_NAME ';
		 SET @MySQL = @MySQL + 'where c1.TABLE_NAME= ''' + @LinkedVIEW + ''' and c2.TABLE_NAME = ''' + @CurrVIEW + ''' ';
		 SET @MySQL = @MySQL + 'and C1.column_name = c2.column_name ';
		 SET @MySQL = @MySQL + 'and ((c1.data_type <> c2.DATA_TYPE) ';
		 SET @MySQL = @MySQL + '		OR (c1.data_type = c2.DATA_TYPE AND c1.CHARACTER_MAXIMUM_LENGTH <> c2.CHARACTER_MAXIMUM_LENGTH))';
		 EXEC (@MySql) ;

		 --print ('Step05');

		 SET @MySQL = '';
		 SET @MySQL = 'INSERT INTO TBL_DIFF2 (table_name, COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH, table_name2, DATA_TYPE2, COLUMN_NAME2, CHARACTER_MAXIMUM_LENGTH2, Note) ';
		 SET @MySQL = @MySQL + 'SELECT c1.TABLE_NAME, c1.COLUMN_NAME, c1.DATA_TYPE, ''' + @CurrDB + ''' as DBNAME, ''MISSING'' as C1, ''NA'' as C2 , ''NA'' as C3, 0 as I1, ''Column ''+c1.COLUMN_NAME+'' Missing in: ' + @CurrDB + '/' + @CurrVIEW + ' ''  ';
		 SET @MySQL = @MySQL + ' FROM  [' + @LinkedSVR + '].[' + @LinkedDB + '].INFORMATION_SCHEMA.COLUMNS AS c1 ';
		 SET @MySQL = @MySQL + ' WHERE  C1.table_name = ''' + @CurrVIEW + ''' ';
		 SET @MySQL = @MySQL + ' 	AND c1.column_name not in ';
		 SET @MySQL = @MySQL + ' 	(select column_name from ' + @CurrDB + '.INFORMATION_SCHEMA.columns C2 where C2.table_name = ''' + @LinkedVIEW + ''') ';
		 PRINT @MySql;
		 EXEC (@MySql) ;

		 --print ('Step06');

		 SET @MySQL = 'INSERT INTO TBL_DIFF3 (table_name, COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH, table_name2, DATA_TYPE2, COLUMN_NAME2, CHARACTER_MAXIMUM_LENGTH2, Note) ';
		 SET @MySQL = @MySQL + 'SELECT c1.TABLE_NAME, c1.COLUMN_NAME, c1.DATA_TYPE, ''' + @LinkedDB + ''' as DBNAME, ''MISSING'' as C1, ''NA'' as C2, ''NA'' as C3, -1 as I1, ''Column ''+c1.COLUMN_NAME+'' Missing in: ' + @LinkedDB + '/' + @LinkedVIEW + ' ''  ';
		 SET @MySQL = @MySQL + ' FROM [' + @CurrDB + '].INFORMATION_SCHEMA.COLUMNS as C1 ';
		 SET @MySQL = @MySQL + ' WHERE  C1.table_name = ''' + @CurrVIEW + ''' ';
		 SET @MySQL = @MySQL + ' AND c1.column_name not in ';
		 SET @MySQL = @MySQL + ' (select column_name from [' + @LinkedSVR + '].[' + @LinkedDB + '].INFORMATION_SCHEMA.columns C2 where C2.table_name = ''' + @LinkedVIEW + ''') ';
		 EXEC (@MySql) ;

		 --print ('Step07');

		 SET @S = 'SELECT @retval = count(*) FROM sys.servers WHERE name = @TgtSVR ';
		 SET @ParmDefinition = N'@TgtSVR nvarchar(254), @retval bit OUTPUT';
		 EXEC sp_executesql @S, @ParmDefinition, @TgtSVR = @LinkedSVR, @retval = @iRetval OUTPUT;
		 SET @iCnt = (SELECT
							 @iRetval) ;
		 IF @iCnt = 1
			 BEGIN EXEC master.sys.sp_dropserver @LinkedSVR, 'droplogins'
			 END;

		 --print ('Step08');

		 IF NOT EXISTS (SELECT
							   name
						  FROM sys.views
						  WHERE name = 'view_SchemaDiff') 
			 BEGIN
				 DECLARE @sTxt AS nvarchar (max) = '';
				 SET @sTxt = @sTxt + 'Create view view_SchemaDiff AS ';
				 SET @sTxt = @sTxt + 'Select * from TBL_DIFF1 ';
				 SET @sTxt = @sTxt + 'union ';
				 SET @sTxt = @sTxt + 'Select * from TBL_DIFF2  ';
				 SET @sTxt = @sTxt + 'union ';
				 SET @sTxt = @sTxt + 'Select * from TBL_DIFF3  ';
				 EXEC (@sTxt) ;
				 PRINT 'Created view view_SchemaDiff.';
			 END;

		 --Select * from TBL_DIFF1 
		 --union
		 --Select * from TBL_DIFF2 
		 --union
		 --Select * from TBL_DIFF3 

		 PRINT 'To see "deltas" - select * from view_SchemaDiff';
		 PRINT '_________________________________________________';

	 --print ('Step09');

	 END;
GO
PRINT 'Created Proc_EDW_Compare_Views';
GO

GO
PRINT 'Creating Proc_EDW_Compare_MASTER';
GO
IF EXISTS (SELECT
				  name
			 FROM sys.procedures
			 WHERE name = 'Proc_EDW_Compare_MASTER') 
	BEGIN
		DROP PROCEDURE
			 Proc_EDW_Compare_MASTER;
	END;
GO
CREATE PROC Proc_EDW_Compare_MASTER (@LinkedSVR AS nvarchar (254) 
								   , @LinkedDB AS nvarchar (254) 
								   , @CurrDB AS nvarchar (254)) 
AS
	 BEGIN
		 DECLARE @LinkedVIEW AS nvarchar (254) ;
		 DECLARE @CurrVIEW AS nvarchar (254) ;
		 DECLARE @NewRun AS int = 0;
		 SET @LinkedVIEW = 'SchemaChangeMonitor';
		 SET @CurrVIEW = 'SchemaChangeMonitor';
		 SET @NewRun = 1;
		 SET @LinkedVIEW = 'CMS_Class';
		 SET @CurrVIEW = 'CMS_Class';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @NewRun = 0;
		 SET @LinkedVIEW = 'CMS_Document';
		 SET @CurrVIEW = 'CMS_Document';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'CMS_Site';
		 SET @CurrVIEW = 'CMS_Site';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'CMS_Tree';
		 SET @CurrVIEW = 'CMS_Tree';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'CMS_User';
		 SET @CurrVIEW = 'CMS_User';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'CMS_UserSettings';
		 SET @CurrVIEW = 'CMS_UserSettings';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'CMS_UserSite';
		 SET @CurrVIEW = 'CMS_UserSite';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'COM_SKU';
		 SET @CurrVIEW = 'COM_SKU';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'EDW_HealthAssessment';
		 SET @CurrVIEW = 'EDW_HealthAssessment';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'EDW_HealthAssessmentDefinition';
		 SET @CurrVIEW = 'EDW_HealthAssessmentDefinition';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_Account';
		 SET @CurrVIEW = 'HFit_Account';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_Coaches';
		 SET @CurrVIEW = 'HFit_Coaches';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_Company';
		 SET @CurrVIEW = 'HFit_Company';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_Goal';
		 SET @CurrVIEW = 'HFit_Goal';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_GoalOutcome';
		 SET @CurrVIEW = 'HFit_GoalOutcome';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_HACampaign';
		 SET @CurrVIEW = 'HFit_HACampaign';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_HealthAssesmentMatrixQuestion';
		 SET @CurrVIEW = 'HFit_HealthAssesmentMatrixQuestion';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_HealthAssesmentModule';
		 SET @CurrVIEW = 'HFit_HealthAssesmentModule';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_HealthAssesmentMultipleChoiceQuestion';
		 SET @CurrVIEW = 'HFit_HealthAssesmentMultipleChoiceQuestion';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_HealthAssesmentPredefinedAnswer';
		 SET @CurrVIEW = 'HFit_HealthAssesmentPredefinedAnswer';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_HealthAssesmentRiskArea';
		 SET @CurrVIEW = 'HFit_HealthAssesmentRiskArea';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_HealthAssesmentRiskCategory';
		 SET @CurrVIEW = 'HFit_HealthAssesmentRiskCategory';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_HealthAssesmentUserAnswers';
		 SET @CurrVIEW = 'HFit_HealthAssesmentUserAnswers';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_HealthAssesmentUserModule';
		 SET @CurrVIEW = 'HFit_HealthAssesmentUserModule';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_HealthAssesmentUserQuestion';
		 SET @CurrVIEW = 'HFit_HealthAssesmentUserQuestion';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_HealthAssesmentUserQuestionGroupResults';
		 SET @CurrVIEW = 'HFit_HealthAssesmentUserQuestionGroupResults';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_HealthAssesmentUserRiskArea';
		 SET @CurrVIEW = 'HFit_HealthAssesmentUserRiskArea';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_HealthAssesmentUserRiskCategory';
		 SET @CurrVIEW = 'HFit_HealthAssesmentUserRiskCategory';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_HealthAssesmentUserStarted';
		 SET @CurrVIEW = 'HFit_HealthAssesmentUserStarted';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_HealthAssessment';
		 SET @CurrVIEW = 'HFit_HealthAssessment';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_HealthAssessmentFreeForm';
		 SET @CurrVIEW = 'HFit_HealthAssessmentFreeForm';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_LKP_Frequency';
		 SET @CurrVIEW = 'HFit_LKP_Frequency';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_LKP_GoalStatus';
		 SET @CurrVIEW = 'HFit_LKP_GoalStatus';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_LKP_RewardLevelType';
		 SET @CurrVIEW = 'HFit_LKP_RewardLevelType';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_LKP_RewardTrigger';
		 SET @CurrVIEW = 'HFit_LKP_RewardTrigger';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_LKP_RewardTriggerParameterOperator';
		 SET @CurrVIEW = 'HFit_LKP_RewardTriggerParameterOperator';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_LKP_RewardType';
		 SET @CurrVIEW = 'HFit_LKP_RewardType';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_LKP_UnitOfMeasure';
		 SET @CurrVIEW = 'HFit_LKP_UnitOfMeasure';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'hfit_ppteligibility';
		 SET @CurrVIEW = 'hfit_ppteligibility';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_RewardActivity';
		 SET @CurrVIEW = 'HFit_RewardActivity';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_RewardException';
		 SET @CurrVIEW = 'HFit_RewardException';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_RewardGroup';
		 SET @CurrVIEW = 'HFit_RewardGroup';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_RewardLevel';
		 SET @CurrVIEW = 'HFit_RewardLevel';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_RewardProgram';
		 SET @CurrVIEW = 'HFit_RewardProgram';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_RewardsAwardUserDetail';
		 SET @CurrVIEW = 'HFit_RewardsAwardUserDetail';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_RewardsUserActivityDetail';
		 SET @CurrVIEW = 'HFit_RewardsUserActivityDetail';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_RewardsUserLevelDetail';
		 SET @CurrVIEW = 'HFit_RewardsUserLevelDetail';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_RewardTrigger';
		 SET @CurrVIEW = 'HFit_RewardTrigger';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_RewardTriggerParameter';
		 SET @CurrVIEW = 'HFit_RewardTriggerParameter';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_Tobacco_Goal';
		 SET @CurrVIEW = 'HFit_Tobacco_Goal';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFIT_Tracker';
		 SET @CurrVIEW = 'HFIT_Tracker';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_TrackerBloodPressure';
		 SET @CurrVIEW = 'HFit_TrackerBloodPressure';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_TrackerBloodSugarAndGlucose';
		 SET @CurrVIEW = 'HFit_TrackerBloodSugarAndGlucose';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_TrackerBMI';
		 SET @CurrVIEW = 'HFit_TrackerBMI';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_TrackerBodyFat';
		 SET @CurrVIEW = 'HFit_TrackerBodyFat';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_TrackerBodyMeasurements';
		 SET @CurrVIEW = 'HFit_TrackerBodyMeasurements';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_TrackerCardio';
		 SET @CurrVIEW = 'HFit_TrackerCardio';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_TrackerCholesterol';
		 SET @CurrVIEW = 'HFit_TrackerCholesterol';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_TrackerCollectionSource';
		 SET @CurrVIEW = 'HFit_TrackerCollectionSource';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_TrackerDailySteps';
		 SET @CurrVIEW = 'HFit_TrackerDailySteps';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_TrackerFlexibility';
		 SET @CurrVIEW = 'HFit_TrackerFlexibility';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_TrackerFruits';
		 SET @CurrVIEW = 'HFit_TrackerFruits';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_TrackerHbA1c';
		 SET @CurrVIEW = 'HFit_TrackerHbA1c';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_TrackerHeight';
		 SET @CurrVIEW = 'HFit_TrackerHeight';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_TrackerHighFatFoods';
		 SET @CurrVIEW = 'HFit_TrackerHighFatFoods';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_TrackerHighSodiumFoods';
		 SET @CurrVIEW = 'HFit_TrackerHighSodiumFoods';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_TrackerInstance_Tracker';
		 SET @CurrVIEW = 'HFit_TrackerInstance_Tracker';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_TrackerMealPortions';
		 SET @CurrVIEW = 'HFit_TrackerMealPortions';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_TrackerMedicalCarePlan';
		 SET @CurrVIEW = 'HFit_TrackerMedicalCarePlan';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_TrackerRegularMeals';
		 SET @CurrVIEW = 'HFit_TrackerRegularMeals';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_TrackerRestingHeartRate';
		 SET @CurrVIEW = 'HFit_TrackerRestingHeartRate';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_TrackerShots';
		 SET @CurrVIEW = 'HFit_TrackerShots';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_TrackerSitLess';
		 SET @CurrVIEW = 'HFit_TrackerSitLess';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_TrackerSleepPlan';
		 SET @CurrVIEW = 'HFit_TrackerSleepPlan';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_TrackerStrength';
		 SET @CurrVIEW = 'HFit_TrackerStrength';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_TrackerStress';
		 SET @CurrVIEW = 'HFit_TrackerStress';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_TrackerStressManagement';
		 SET @CurrVIEW = 'HFit_TrackerStressManagement';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_TrackerSugaryDrinks';
		 SET @CurrVIEW = 'HFit_TrackerSugaryDrinks';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_TrackerSugaryFoods';
		 SET @CurrVIEW = 'HFit_TrackerSugaryFoods';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_TrackerTests';
		 SET @CurrVIEW = 'HFit_TrackerTests';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_TrackerTobaccoFree';
		 SET @CurrVIEW = 'HFit_TrackerTobaccoFree';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_TrackerVegetables';
		 SET @CurrVIEW = 'HFit_TrackerVegetables';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_TrackerWater';
		 SET @CurrVIEW = 'HFit_TrackerWater';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_TrackerWeight';
		 SET @CurrVIEW = 'HFit_TrackerWeight';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_TrackerWholeGrains';
		 SET @CurrVIEW = 'HFit_TrackerWholeGrains';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_UserGoal';
		 SET @CurrVIEW = 'HFit_UserGoal';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'Tracker_EDW_Metadata';
		 SET @CurrVIEW = 'Tracker_EDW_Metadata';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'View_CMS_Tree_Joined';
		 SET @CurrVIEW = 'View_CMS_Tree_Joined';
		 EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'VIEW_CMS_Tree_Joined_Linked';
		 SET @CurrVIEW = 'VIEW_CMS_Tree_Joined_Linked';
		 EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'VIEW_CMS_Tree_Joined_Regular';
		 SET @CurrVIEW = 'VIEW_CMS_Tree_Joined_Regular';
		 EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'VIEW_COM_SKU';
		 SET @CurrVIEW = 'VIEW_COM_SKU';
		 EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'VIEW_EDW_ClientCompany';
		 SET @CurrVIEW = 'VIEW_EDW_ClientCompany';
		 EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'VIEW_EDW_Coaches';
		 SET @CurrVIEW = 'VIEW_EDW_Coaches';
		 EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'VIEW_EDW_CoachingDefinition';
		 SET @CurrVIEW = 'VIEW_EDW_CoachingDefinition';
		 EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'VIEW_EDW_CoachingDetail';
		 SET @CurrVIEW = 'VIEW_EDW_CoachingDetail';
		 EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'VIEW_EDW_HAassessment';
		 SET @CurrVIEW = 'VIEW_EDW_HAassessment';
		 EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'VIEW_EDW_HADefinition';
		 SET @CurrVIEW = 'VIEW_EDW_HADefinition';
		 EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'VIEW_EDW_HealthAssesment';
		 SET @CurrVIEW = 'VIEW_EDW_HealthAssesment';
		 EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'VIEW_EDW_HealthAssesmentAnswers';
		 SET @CurrVIEW = 'VIEW_EDW_HealthAssesmentAnswers';
		 EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'VIEW_EDW_HealthAssesmentClientView';
		 SET @CurrVIEW = 'VIEW_EDW_HealthAssesmentClientView';
		 EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'VIEW_EDW_HealthAssesmentDeffinition';
		 SET @CurrVIEW = 'VIEW_EDW_HealthAssesmentDeffinition';
		 EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'VIEW_EDW_HealthAssesmentDeffinitionCustom';
		 SET @CurrVIEW = 'VIEW_EDW_HealthAssesmentDeffinitionCustom';
		 EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'VIEW_EDW_HealthAssesmentQuestions';
		 SET @CurrVIEW = 'VIEW_EDW_HealthAssesmentQuestions';
		 EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'VIEW_EDW_HealthAssessment_Staged';
		 SET @CurrVIEW = 'VIEW_EDW_HealthAssessment_Staged';
		 EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'VIEW_EDW_HealthAssessmentDefinition_Staged';
		 SET @CurrVIEW = 'VIEW_EDW_HealthAssessmentDefinition_Staged';
		 EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'VIEW_EDW_Participant';
		 SET @CurrVIEW = 'VIEW_EDW_Participant';
		 EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'VIEW_EDW_RewardAwardDetail';
		 SET @CurrVIEW = 'VIEW_EDW_RewardAwardDetail';
		 EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'VIEW_EDW_RewardsDefinition';
		 SET @CurrVIEW = 'VIEW_EDW_RewardsDefinition';
		 EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'VIEW_EDW_RewardTriggerParameters';
		 SET @CurrVIEW = 'VIEW_EDW_RewardTriggerParameters';
		 EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'VIEW_EDW_RewardUserDetail';
		 SET @CurrVIEW = 'VIEW_EDW_RewardUserDetail';
		 EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'VIEW_EDW_ScreeningsFromTrackers';
		 SET @CurrVIEW = 'VIEW_EDW_ScreeningsFromTrackers';
		 EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'VIEW_EDW_TrackerCompositeDetails';
		 SET @CurrVIEW = 'VIEW_EDW_TrackerCompositeDetails';
		 EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'VIEW_EDW_TrackerMetadata';
		 SET @CurrVIEW = 'VIEW_EDW_TrackerMetadata';
		 EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'VIEW_EDW_TrackerShots';
		 SET @CurrVIEW = 'VIEW_EDW_TrackerShots';
		 EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'VIEW_EDW_TrackerTests';
		 SET @CurrVIEW = 'VIEW_EDW_TrackerTests';
		 EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'VIEW_HFit_Goal_Joined';
		 SET @CurrVIEW = 'VIEW_HFit_Goal_Joined';
		 EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'VIEW_HFit_HACampaign_Joined';
		 SET @CurrVIEW = 'VIEW_HFit_HACampaign_Joined';
		 EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'VIEW_HFit_HealthAssesmentMatrixQuestion_Joined';
		 SET @CurrVIEW = 'VIEW_HFit_HealthAssesmentMatrixQuestion_Joined';
		 EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'VIEW_HFit_HealthAssesmentModule_Joined';
		 SET @CurrVIEW = 'VIEW_HFit_HealthAssesmentModule_Joined';
		 EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'VIEW_HFit_HealthAssesmentMultipleChoiceQuestion_Joined';
		 SET @CurrVIEW = 'VIEW_HFit_HealthAssesmentMultipleChoiceQuestion_Joined';
		 EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'VIEW_HFit_HealthAssesmentPredefinedAnswer_Joined';
		 SET @CurrVIEW = 'VIEW_HFit_HealthAssesmentPredefinedAnswer_Joined';
		 EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'VIEW_HFit_HealthAssesmentRiskArea_Joined';
		 SET @CurrVIEW = 'VIEW_HFit_HealthAssesmentRiskArea_Joined';
		 EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'VIEW_HFit_HealthAssesmentRiskCategory_Joined';
		 SET @CurrVIEW = 'VIEW_HFit_HealthAssesmentRiskCategory_Joined';
		 EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'VIEW_HFit_HealthAssessment_Joined';
		 SET @CurrVIEW = 'VIEW_HFit_HealthAssessment_Joined';
		 EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'VIEW_HFit_HealthAssessmentFreeForm_Joined';
		 SET @CurrVIEW = 'VIEW_HFit_HealthAssessmentFreeForm_Joined';
		 EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'VIEW_HFit_RewardActivity_Joined';
		 SET @CurrVIEW = 'VIEW_HFit_RewardActivity_Joined';
		 EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'VIEW_HFit_RewardGroup_Joined';
		 SET @CurrVIEW = 'VIEW_HFit_RewardGroup_Joined';
		 EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'VIEW_HFit_RewardLevel_Joined';
		 SET @CurrVIEW = 'VIEW_HFit_RewardLevel_Joined';
		 EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'VIEW_HFit_RewardProgram_Joined';
		 SET @CurrVIEW = 'VIEW_HFit_RewardProgram_Joined';
		 EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'VIEW_HFit_RewardTrigger_Joined';
		 SET @CurrVIEW = 'VIEW_HFit_RewardTrigger_Joined';
		 EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'VIEW_HFit_RewardTriggerParameter_Joined';
		 SET @CurrVIEW = 'VIEW_HFit_RewardTriggerParameter_Joined';
		 EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'VIEW_HFit_Tobacco_Goal_Joined';
		 SET @CurrVIEW = 'VIEW_HFit_Tobacco_Goal_Joined';
		 EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SELECT
				*
		   FROM view_SchemaDiff;
	 END;
GO
PRINT 'CREATED Proc_EDW_Compare_MASTER';
GO 




GO
PRINT 'FQN: Create_Job_SchemaMonitorReport.SQL';
PRINT 'Processing Job SchemaMonitorReport';
GO

IF EXISTS (SELECT
				  job_id
			 FROM msdb.dbo.sysjobs_view
			 WHERE name = N'SchemaMonitorReport') 
	BEGIN EXEC msdb.dbo.sp_delete_job @job_name = N'SchemaMonitorReport', @delete_unused_schedule = 1;
	END;
GO

/**********************************************************************************
***** Object:  Job [SchemaMonitorReport]    Script Date: 2/24/2015 2:23:59 PM *****
**********************************************************************************/

declare @DB as nvarchar(254) = DB_NAME() ;

BEGIN TRANSACTION;
DECLARE @ReturnCode int;
SELECT
	   @ReturnCode = 0;

/***********************************************************************************************
***** Object:  JobCategory [[Uncategorized (Local)]]]    Script Date: 2/24/2015 2:24:00 PM *****
***********************************************************************************************/

IF NOT EXISTS (SELECT
					  name
				 FROM msdb.dbo.syscategories
				 WHERE name = N'[Uncategorized (Local)]'
				   AND category_class = 1) 
	BEGIN EXEC @ReturnCode = msdb.dbo.sp_add_category @class = N'JOB', @type = N'LOCAL', @name = N'[Uncategorized (Local)]';
		IF @@ERROR <> 0
		OR @ReturnCode <> 0
			BEGIN
				GOTO QuitWithRollback
			END;
	END;
DECLARE @jobId binary (16) ;
EXEC @ReturnCode = msdb.dbo.sp_add_job @job_name = N'SchemaMonitorReport', @enabled = 1, @notify_level_eventlog = 2, @notify_level_email = 0, @notify_level_netsend = 0, @notify_level_page = 0, @delete_level = 0, @description = N'No description available.', @category_name = N'[Uncategorized (Local)]', @owner_login_name = N'sa', @job_id = @jobId OUTPUT;
IF @@ERROR <> 0
OR @ReturnCode <> 0
	BEGIN
		GOTO QuitWithRollback
	END;

/**********************************************************************************************
***** Object:  Step [execute sp_SchemaMonitorReport]    Script Date: 2/24/2015 2:24:01 PM *****
**********************************************************************************************/

EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id = @jobId, @step_name = N'execute sp_SchemaMonitorReport', @step_id = 1, @cmdexec_success_code = 0, @on_success_action = 1, @on_success_step_id = 0, @on_fail_action = 2, @on_fail_step_id = 0, @retry_attempts = 0, @retry_interval = 0, @os_run_priority = 0, @subsystem = N'TSQL', @command = N'exec sp_SchemaMonitorReport', @database_name = @DB, @flags = 0;
IF @@ERROR <> 0
OR @ReturnCode <> 0
	BEGIN
		GOTO QuitWithRollback
	END;
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1;
IF @@ERROR <> 0
OR @ReturnCode <> 0
	BEGIN
		GOTO QuitWithRollback
	END;
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id = @jobId, @name = N'SchemaMonitorReport Schedule', @enabled = 1, @freq_type = 4, @freq_interval = 1, @freq_subday_type = 1, @freq_subday_interval = 0, @freq_relative_interval = 0, @freq_recurrence_factor = 0, @active_start_date = 20141017, @active_end_date = 99991231, @active_start_time = 220000, @active_end_time = 235959, @schedule_uid = N'd64376a9-39f9-4344-b403-5526b03d70d7';
IF @@ERROR <> 0
OR @ReturnCode <> 0
	BEGIN
		GOTO QuitWithRollback
	END;
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id = @jobId, @name = N'SchemaMonitorReport Schedule', @enabled = 1, @freq_type = 4, @freq_interval = 1, @freq_subday_type = 1, @freq_subday_interval = 0, @freq_relative_interval = 0, @freq_recurrence_factor = 0, @active_start_date = 20141017, @active_end_date = 99991231, @active_start_time = 220000, @active_end_time = 235959, @schedule_uid = N'37dd0949-b104-47c6-864c-2df7b166d28f';
IF @@ERROR <> 0
OR @ReturnCode <> 0
	BEGIN
		GOTO QuitWithRollback
	END;
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)';
IF @@ERROR <> 0
OR @ReturnCode <> 0
	BEGIN
		GOTO QuitWithRollback
	END;
COMMIT TRANSACTION;
GOTO EndSave;
QuitWithRollback:
IF @@TRANCOUNT > 0
	BEGIN
		ROLLBACK TRANSACTION
	END;
EndSave:
GO

--DECLARE @CurrDB AS nvarchar (250) = (SELECT TOP 1
--											CurrDB
--									   FROM #SMR_CurrDB) ;
--DECLARE @MSQL AS nvarchar (250) = 'USE ' + @CurrDB;
--EXEC (@MSQL) ;
PRINT 'Switched back to DB ' + DB_NAME () ;
GO
PRINT 'Job SchemaMonitorReport created.';
GO

print (' ' );
print ('Processing complete - please check for errors.' );