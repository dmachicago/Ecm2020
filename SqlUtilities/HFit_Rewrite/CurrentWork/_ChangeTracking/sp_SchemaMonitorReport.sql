
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
