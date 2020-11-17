Print ('Creating udfTimeSpanFromMilliSeconds');
go

if exists (select * from sysobjects where name = 'udfTimeSpanFromMilliSeconds' and type = 'FN')
BEGIN
	drop function udfTimeSpanFromMilliSeconds ;
END 
go

--DECLARE @ElapsedS INT
--declare @start_date datetime = getdate() ;
--declare @end_date  datetime = getdate() ;
--SET @ElapsedS = DATEDIFF(ms, @start_date, @end_date)
--SELECT TimeSpan = dbo.udfTimeSpanFromMilliSeconds(@ElapsedS)
--go


create FUNCTION [dbo].[udfTimeSpanFromMilliSeconds] ( @milliSecs int )
RETURNS varchar(20)
AS
BEGIN
--**********************************************************************
--Author: W. Dale Miller / June 12, 2008
--USE:
--DECLARE @ElapsedS INT
--declare @start_date datetime = getdate() ;
--declare @end_date  datetime = getdate() ;
--SET @ElapsedS = DATEDIFF(ms, @start_date, @end_date)
--SELECT TimeSpan = dbo.udfTimeSpanFromMilliSeconds(@ElapsedS)
--**********************************************************************
	DECLARE 
		 @DisplayTime varchar(50)
		 , @Seconds int 
		
		--Variable to hold our result
		 , @DHMS varchar(15)
		
		--Integers for doing the math
		, @MS int
		, @Days int --Integer days
		, @Hours int --Integer hours
		, @Minutes int --Integer minutes
		
		--Strings for providing the display : Unused presently
		, @sDays varchar(5) --String days
		, @sHours varchar(2) --String hours
		, @sMinutes varchar(2) --String minutes
		, @sSeconds varchar(2); --String seconds

	set @Minutes = 0 ;
	set @MS = 0 ;
	set @Hours = 0 ; 
	--set @milliSecs = 111071120;
	--print (@milliSecs)

	--Get the values using modulos where appropriate
	SET @Seconds = (@milliSecs / 1000 ) ;	
	--print (@Seconds ) ;

	if (@Seconds > 59 )
	BEGIN
		set @Minutes = @Seconds / 60 ;
		set @Seconds = @Seconds - (@Minutes * 60) ;
	END
	ELSE
		set @Minutes = 0 ;
	
		
	if (@Minutes > 59)
	BEGIN
		set @Hours = @Minutes / 60 ;
		set @Minutes = @Minutes - (@Seconds * 60) ;
	END
	ELSE
		set @Hours = 0 ;
	

	if (@Hours > 24)
	BEGIN
		set @Days = @Hours / 24 ;
		set @Hours = @Hours - (@Minutes * 60) ;
	END
	ELSE
		set @Days = 0 ;
	
	set @milliSecs = @milliSecs % 1000;

	set @DisplayTime = 
		cast(@Days as varchar(50)) + ':' +
			cast(@Hours as varchar(50)) + ':' +
			cast(@Minutes as varchar(50)) + ':' +
			cast(@Seconds as varchar(50))  + '.' +
			cast(@milliSecs as varchar(50))  ;

	--print (@DisplayTime );
	return @DisplayTime ;

END

GO

