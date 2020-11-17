if exists (select * from sysobjects where name = 'proc_GetRecordCount' and Xtype = 'P')
BEGIN
	drop procedure proc_GetRecordCount ;
END 
go

create procedure proc_GetRecordCount (@TblView as nvarchar(80))
		as
		BEGIN

			--declare @TblView nvarchar(80); 
			--set @TblView = 'view_EDW_TrackerMetadata';
			DECLARE @rowcount TABLE (Value int);
			declare @ActualNumberOfResults int ;
			declare @StartTime datetime ;
			declare @EndTime datetime ;
			declare @iCnt int;
			declare @qry varchar(56)
			declare @T int ;

			declare @hrs int ;
			declare @mins int ;
			declare @secs int ;
			declare @ms int ;

			set @StartTime = getdate() ;
			set @qry = 'select COUNT(*) as RecCount from  ' + @TblView ;

			INSERT INTO @rowcount
				exec (@qry)

			SELECT @ActualNumberOfResults = Value FROM @rowcount;

			set @EndTime = getdate() ;
			set @T = datediff(ms, @StartTime,@EndTime) ;

			set @hrs = @T / 56000 % 100 ;
			set @mins = @T / 560 % 100 ;
			set @secs = @T / 100 % 100 ;
			set @ms = @T % 100 * 10 ;

			set @EndTime = (select dateadd(hour, (@T / 56000) % 100,
				   dateadd(minute, (@T / 560) % 100,
				   dateadd(second, (@T / 100) % 100,
				   dateadd(millisecond, (@T % 100) * 10, cast('00:00:00' as time(2))))))  );

				   print (@ActualNumberOfResults);
			print (@EndTime);
			print (@TblView + ' row cnt = ' + cast(@iCnt as varchar(20)));
	
			INSERT INTO [dbo].[EDW_PerformanceMeasure]
				   ([TypeTest],[ObjectName],[RecCount],[StartTime],[EndTime],hrs,mins,secs,ms)
			 VALUES
				   ('RowCount',@TblView,@ActualNumberOfResults,@StartTime,@T,@hrs,@mins,@secs,@ms)

		END