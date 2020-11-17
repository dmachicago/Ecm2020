IF EXISTS (SELECT name
				  FROM sys.procedures
				  WHERE name = 'sp_FindDependentTblSetCtOn') 
	BEGIN
		DROP PROCEDURE sp_FindDependentTblSetCtOn;
	END;
GO

/*******************************************************************************************************************
truncate table [EDW_ViewBaseColumns];
exec sp_FindDependentTblSetCtOn 'view_EDW_SmallStepResponses',1 
exec sp_FindDependentTblSetCtOn 'view_EDW_HealthAssesmentDeffinition'
exec sp_FindDependentTblSetCtOn 'view_EDW_HealthAssesment'
select * from EDW_ViewBaseColumns;
select '"' + TypeObj + '"', * from EDW_ViewBaseColumns where TypeObj like 'T' order by OwnerView, DepObj, ColumnName
*******************************************************************************************************************/

CREATE PROCEDURE sp_FindDependentTblSetCtOn
	   @Viewname AS nvarchar (100), @ApplyChanges as int
AS
BEGIN
	DECLARE @Synchronization_Version AS int = 0;
	SET @Synchronization_Version = change_tracking_current_version () ;
	PRINT 'Preparing the view NESTING levels';

/******************************
GET THE NESTED VIEWS AND TABLES
******************************/

	--DECLARE @ViewName nvarchar (100) = 'view_EDW_HealthAssesmentDeffinition';

	EXEC proc_getviewsnestedobjects @Viewname, 0;
	PRINT 'NESTING levels complete';

/*******************************************
TURN CHANGE TRACKING ON FOR THE DB IF NEEDED
*******************************************/

	IF NOT EXISTS (SELECT database_id
						  FROM sys.change_tracking_databases
						  WHERE database_id = (
											   SELECT database_id
													  FROM sys.databases
													  WHERE name = 'KenticoCMS_QA')) 
		BEGIN
			PRINT 'TURNING CHANGE_TRACKING ON';
			ALTER DATABASE kenticocms_qa SET CHANGE_TRACKING = ON (CHANGE_RETENTION = 7 DAYS, AUTO_CLEANUP = ON) ;
		END;
	ELSE
		BEGIN
			PRINT 'SET CHANGE_TRACKING ON';
		END;

/**********************************
Create the TEMP View Columns table 
**********************************/

	IF EXISTS (SELECT name
					  FROM tempdb.dbo.sysobjects
					  WHERE id = OBJECT_ID (N'tempdb..#ViewCols')) 
		BEGIN
			PRINT 'Dropping #ViewCols';
			DROP TABLE #viewcols;
		END;
	CREATE TABLE #viewcols (obj_name nvarchar (101) 
						  , dep_obj nvarchar (101) 
						  , col_name nvarchar (101)) ;

/************************************************
Get the BASE VIEW columns and store in temp table
************************************************/

	INSERT INTO #viewcols
	SELECT obj_name = SUBSTRING (OBJECT_NAME (d.id) , 1, 100) 
		 , dep_obj = SUBSTRING (OBJECT_NAME (d.depid) , 1, 100) 
		 , col_name = SUBSTRING (name, 1, 100) 
		   FROM
				sysdepends AS d
					JOIN syscolumns AS c
						ON d.depid = c.id
					   AND d.depnumber = c.colid
		   WHERE OBJECT_NAME (d.id) = @Viewname;

	--SELECT * FROM #ViewCols;
	--DECLARE @ViewName nvarchar (100) = 'view_EDW_HealthAssesmentDeffinition';
	--SELECT * FROM temp_ViewObjects WHERE OwnerObject = @ViewName;

	IF EXISTS (SELECT name
					  FROM tempdb.dbo.sysobjects
					  WHERE id = OBJECT_ID (N'tempdb..#BaseCols')) 
		BEGIN
			PRINT 'Dropping #ViewCols';
			DROP TABLE #basecols;
		END;
	CREATE TABLE #basecols (ownerobject nvarchar (101) 
						  , objectname nvarchar (101)) ;

	--select * from temp_ViewObjects where OwnerObject = 'view_EDW_HealthAssesmentDeffinition'
	--select * from #ViewCols
	--select * from #BaseCols		
	--SELECT * FROM INFORMATION_SCHEMA.TABLES where table_name = 'view_EDW_HealthAssesmentDeffinition';
	--DECLARE @ViewName nvarchar (100) = 'view_EDW_HealthAssesmentDeffinition';

	INSERT INTO #basecols
	SELECT objs.objectname
		 , cols.col_name
		   FROM
				temp_viewobjects AS objs
					JOIN #viewcols AS cols
						ON cols.obj_name = objs.objectname
					   AND objs.ownerobject = 'view_EDW_HealthAssesmentDeffinition'

		   --where OwnerObject = @ViewName

		   WHERE objs.objectname IN (
									 SELECT name
											FROM sys.tables

				 --WHERE type = 'U'

				 ) 
			 AND ownerobject = @Viewname
		   ORDER BY objectname, col_name;

	--Setup to build the CHANGE TRACKING alter statements

/************************************************************************
DECLARE @ViewName nvarchar (100) = 'view_EDW_HealthAssesmentDeffinition';
select distinct objectname from temp_ViewObjects 
join sys.tables on name = objectname
where OwnerObject = @ViewName ;
************************************************************************/

	DECLARE @Stxt AS nvarchar (2000) = '';
	DECLARE db_cursor CURSOR LOCAL
		FOR SELECT DISTINCT objectname
				   FROM
						temp_viewobjects
							JOIN sys.tables
								ON name = objectname
				   WHERE ownerobject = @Viewname;

/***********************
Process the base columns
***********************/

	DECLARE @Prevobj AS nvarchar (200) = '';
	DECLARE @Depobj AS nvarchar (200) ;
	DECLARE @Stext AS nvarchar (2000) ;
	OPEN db_cursor;
	FETCH next FROM db_cursor INTO @Depobj;
	WHILE @@Fetch_Status = 0
		BEGIN
			SET @Stext = 'alter table dbo.' + @Depobj + ' ';
			SET @Stext = @Stext + 'ENABLE CHANGE_TRACKING ';
			SET @Stext = @Stext + 'WITH (TRACK_COLUMNS_UPDATED = ON) ; ';
			IF EXISTS (SELECT sys.tables.name AS table_name
							  FROM
								   sys.change_tracking_tables
									   JOIN sys.tables
										   ON sys.tables.object_id = sys.change_tracking_tables.object_id
									   JOIN sys.schemas
										   ON sys.schemas.schema_id = sys.tables.schema_id
							  WHERE sys.tables.name = @Depobj) 
				BEGIN
					PRINT '--** CHANGE TRACKING ALREADY in place for ' + @Depobj;
				END;
			ELSE
				BEGIN					
					PRINT '--ENABLE Change Tracking for ' + @Depobj;
					PRINT @Stext;
					if (@ApplyChanges = 1)
							begin
								PRINT '--ENABLING change tracking ON: ' + @Depobj;
								exec (@Stext);
							end;

				--Execute the ALTER statement.
				--exec (@stext);

				END;
			FETCH next FROM db_cursor INTO @Depobj;
		END;
	CLOSE db_cursor;
	DEALLOCATE db_cursor;
END;