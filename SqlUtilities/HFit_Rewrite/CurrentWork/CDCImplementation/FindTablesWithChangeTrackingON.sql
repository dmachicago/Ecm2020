
DECLARE @Db AS nvarchar (100) = DB_NAME () ;

/********************************************
ENABLE Change Trackgin at the database level.
********************************************/

ALTER DATABASE kenticocms_qa SET CHANGE_TRACKING = ON (CHANGE_RETENTION = 7 DAYS, AUTO_CLEANUP = ON) ;

/*********************************************
DISABLE Change Trackgin at the database level.
*********************************************/

ALTER DATABASE kenticocms_qa SET CHANGE_TRACKING = OFF;

/**************************************************************************************************************
Find the tables that have Change Tracking enabled, execute the following script against the tracked database
**************************************************************************************************************/

SELECT
	   sys.schemas.name AS Schema_name
	 , sys.tables.name AS  table_name
	   FROM
			sys.change_tracking_tables JOIN sys.tables
					ON sys.tables.object_id = sys.change_tracking_tables.object_id
				 JOIN sys.schemas
					ON sys.schemas.schema_id = sys.tables.schema_id;

/********************************
DISABLE Change Tracking on Tables
********************************/

SELECT
	   'ALTER TABLE ' + sys.tables.name + ' DISABLE CHANGE_TRACKING;'
	   FROM
			sys.change_tracking_tables JOIN sys.tables
					ON sys.tables.object_id = sys.change_tracking_tables.object_id
				 JOIN sys.schemas
					ON sys.schemas.schema_id = sys.tables.schema_id;
