
GO
print ('Creating procedure sp_SchemaMonitorReport ') ;
GO

if exists(select name from sys.objects where name = 'sp_SchemaMonitorReport')
BEGIN 
	drop procedure sp_SchemaMonitorReport ;
END
GO

CREATE proc [dbo].[sp_SchemaMonitorReport]
as
BEGIN
	--print('Start') ;

	truncate table SchemaChangeMonitor_rptData ;

	declare deltas cursor for 
		SELECT PostTime, DB_User, IP_Address, CUR_User, Event, TSQL, OBJ, RowNbr
		FROM     SchemaChangeMonitor
		where PostTime between getdate()-1 and getdate()
		and [Event] in (select [Event] from SchemaChangeMonitorEvent)
		ORDER BY OBJ, PostTime ;
	
	declare @PostTime datetime ;
	declare @DB_User nvarchar(50) ;
	declare @IP_Address nvarchar(50) ;
	declare @CUR_User nvarchar(50) ;
	declare @Event nvarchar(50) ;
	declare @TSQL nvarchar(4000) ;
	declare @OBJ nvarchar(50) ;
	declare @DisplayOrder int ;
	declare @RowNbr int ;
	declare @DOrder int ;

	declare @onerecipient varchar(80) ;
	declare @allrecipients varchar(4000) = '' ;
	declare @fromDate varchar(50) = cast(getdate()-1 as varchar(50)) ;
	declare @toDate varchar(50) = cast(getdate() as varchar(50)) ;
	declare @subj varchar(10) = 'Schema Mods between ' + @fromDate + ' and ' + @toDate ;

	open deltas;
	fetch next from deltas into @PostTime, @DB_User, @IP_Address, @CUR_User, @Event, @TSQL, @OBJ, @RowNbr ;
	while (@@fetch_status=0)
	begin
			set @DOrder = 1 ; 
			insert into SchemaChangeMonitor_rptData (label,sText,DisplayOrder,RowNbr) 
				values ('OBJ',@OBJ,@DOrder,@RowNbr);
			set @DOrder = 2  ; 
			insert into SchemaChangeMonitor_rptData (label,sText,DisplayOrder,RowNbr) 
				values ('Event',@Event,@DOrder,@RowNbr);
			set @DOrder = 3  ; 
			insert into SchemaChangeMonitor_rptData (label,sText,DisplayOrder,RowNbr) 
				values ('TSQL',@TSQL,@DOrder,@RowNbr);

			set @DOrder = @DOrder +1  ; 
			insert into SchemaChangeMonitor_rptData (label,sText,DisplayOrder,RowNbr) 
				values ('PostTime',@PostTime,@DOrder,@RowNbr);
			set @DOrder = @DOrder +1  ; 
			insert into SchemaChangeMonitor_rptData (label,sText,DisplayOrder,RowNbr) 
				values ('IP_Address',@IP_Address,@DOrder,@RowNbr);
			set @DOrder = @DOrder +1  ; 
			insert into SchemaChangeMonitor_rptData (label,sText,DisplayOrder,RowNbr) 
				values ('DB_User',@DB_User,@DOrder,@RowNbr);
			set @DOrder = @DOrder +1  ; 
			insert into SchemaChangeMonitor_rptData (label,sText,DisplayOrder,RowNbr) 
				values ('CUR_User',@CUR_User,@DOrder,@RowNbr);
			set @DOrder = @DOrder +1  ; 
			insert into SchemaChangeMonitor_rptData (label,sText,DisplayOrder,RowNbr) 
				values ('END','******************************',@DOrder,@RowNbr);

			fetch next from deltas into @PostTime, @DB_User, @IP_Address, @CUR_User, @Event, @TSQL, @OBJ, @RowNbr ;
	end
	close deltas;
	deallocate deltas;

	declare getemails cursor for 
		select EmailAddr from SchemaMonitorObjectNotify ;

	open getemails;
	fetch next from getemails into @onerecipient;
	while (@@fetch_status=0)
	begin
			set @allrecipients = @allrecipients + @onerecipient+';'
			fetch next from getemails into @onerecipient;
	end
	close getemails;
	deallocate getemails;

	print ('Report Sent To: ' + @allrecipients);

		EXEC msdb..sp_send_dbmail
		  @profile_name = 'databaseBot',
		  @recipients = @allrecipients,
		  @subject = @subj,
		  @body = 'Modified Items Below.',
		  @execute_query_database = 'msdb',
		  --@query = 'SELECT distinct OBJ, Event, CUR_User, IP_Address, TSQL FROM KenticoCMS_DEV..SchemaChangeMonitor where PostTime between getdate()- 1 and getdate()'
		  @query = 'select * from KenticoCMS_DEV..SchemaChangeMonitor_rptData'
		  
END

GO
print ('Created sp_SchemaMonitorReport') ;
GO


