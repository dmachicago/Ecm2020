
/****** Object:  StoredProcedure [dbo].[proc_EDW_MeasurePerf]    Script Date: 8/19/2014 2:18:31 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



ALTER procedure [dbo].[proc_EDW_MeasurePerf] (@TypeTest as nvarchar(50),@ObjectName as nvarchar(50),@RecCount as int, @StartTime as datetime,@EndTime as datetime)
as
Begin

	declare @T int ;
	declare @eSecs int ;
	declare @hrs int ;
	declare @mins int ;
	declare @secs int ;
	declare @ms int ;

	set @ms = datediff(ms, @StartTime,@EndTime) ;
	set @secs = datediff(ss, @StartTime,@EndTime) ;
	set @mins = datediff(mi, @StartTime,@EndTime) ;
	set @hrs = datediff(hh, @StartTime,@EndTime) ;

	--set @hrs = @T / 1000000 % 100 ;
	--set @mins = @T / 10000 % 100 ;
	--set @secs = @T / 100 % 100 ;
	--set @ms = @T % 1000 % 10 ;

	set @EndTime = (select dateadd(hour, (@T / 1000000) % 100,
		   dateadd(minute, (@T / 10000) % 100,
		   dateadd(second, (@T / 100) % 100,
		   dateadd(millisecond, (@T % 100) * 10, cast('00:00:00' as time(2))))))  );
		INSERT INTO [dbo].[EDW_PerformanceMeasure]
           ([TypeTest],[ObjectName],[RecCount],[StartTime],[EndTime],hrs,mins,secs,ms)
     VALUES
           (@TypeTest,@ObjectName,@RecCount,@StartTime,@EndTime,@hrs,@mins,@secs,@ms)
End


GO


