
print ('Processing: proc_GetRecordCount') ;
go


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

GO
--END OF proc_GetRecordCount

 if not exists(select name from sys.indexes where name = 'PI_HFIT_Tracker_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFIT_Tracker_LastUpdate ON [HFit_TrackerFlexibility] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerBloodPressure_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerBloodPressure_LastUpdate ON [HFit_TrackerFlexibility] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerBloodSugarAndGlucose_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerBloodSugarAndGlucose_LastUpdate ON [HFit_TrackerFlexibility] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerBMI_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerBMI_LastUpdate ON [HFit_TrackerFlexibility] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerBodyFat_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerBodyFat_LastUpdate ON [HFit_TrackerFlexibility] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerBodyMeasurements_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerBodyMeasurements_LastUpdate ON [HFit_TrackerFlexibility] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerCardio_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerCardio_LastUpdate ON [HFit_TrackerFlexibility] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerCategory_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerCategory_LastUpdate ON [HFit_TrackerFlexibility] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerCholesterol_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerCholesterol_LastUpdate ON [HFit_TrackerFlexibility] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerCollectionSource_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerCollectionSource_LastUpdate ON [HFit_TrackerFlexibility] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerDailySteps_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerDailySteps_LastUpdate ON [HFit_TrackerFlexibility] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerDef_Item_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerDef_Item_LastUpdate ON [HFit_TrackerFlexibility] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerDef_Tracker_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerDef_Tracker_LastUpdate ON [HFit_TrackerFlexibility] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerDocument_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerDocument_LastUpdate ON [HFit_TrackerFlexibility] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerFlexibility_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerFlexibility_LastUpdate ON [HFit_TrackerFlexibility] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerFruits_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerFruits_LastUpdate ON [HFit_TrackerFlexibility] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerHbA1c_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerHbA1c_LastUpdate ON [HFit_TrackerFlexibility] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerHeight_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerHeight_LastUpdate ON [HFit_TrackerFlexibility] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerHighFatFoods_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerHighFatFoods_LastUpdate ON [HFit_TrackerFlexibility] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerHighSodiumFoods_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerHighSodiumFoods_LastUpdate ON [HFit_TrackerFlexibility] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerInstance_Item_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerInstance_Item_LastUpdate ON [HFit_TrackerFlexibility] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerInstance_Tracker_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerInstance_Tracker_LastUpdate ON [HFit_TrackerFlexibility] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerMealPortions_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerMealPortions_LastUpdate ON [HFit_TrackerFlexibility] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerMedicalCarePlan_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerMedicalCarePlan_LastUpdate ON [HFit_TrackerFlexibility] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerRegularMeals_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerRegularMeals_LastUpdate ON [HFit_TrackerFlexibility] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerRestingHeartRate_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerRestingHeartRate_LastUpdate ON [HFit_TrackerFlexibility] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerShots_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerShots_LastUpdate ON [HFit_TrackerFlexibility] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerSitLess_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerSitLess_LastUpdate ON [HFit_TrackerFlexibility] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerSleepPlan_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerSleepPlan_LastUpdate ON [HFit_TrackerFlexibility] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerStrength_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerStrength_LastUpdate ON [HFit_TrackerFlexibility] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerStress_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerStress_LastUpdate ON [HFit_TrackerFlexibility] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerStressManagement_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerStressManagement_LastUpdate ON [HFit_TrackerFlexibility] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerSugaryDrinks_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerSugaryDrinks_LastUpdate ON [HFit_TrackerFlexibility] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerSugaryFoods_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerSugaryFoods_LastUpdate ON [HFit_TrackerFlexibility] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerSummary_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerSummary_LastUpdate ON [HFit_TrackerFlexibility] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerTests_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerTests_LastUpdate ON [HFit_TrackerFlexibility] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerTobaccoFree_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerTobaccoFree_LastUpdate ON [HFit_TrackerFlexibility] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerVegetables_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerVegetables_LastUpdate ON [HFit_TrackerFlexibility] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerWater_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerWater_LastUpdate ON [HFit_TrackerFlexibility] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerWeight_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerWeight_LastUpdate ON [HFit_TrackerFlexibility] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerWholeGrains_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerWholeGrains_LastUpdate ON [HFit_TrackerFlexibility] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go


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

		END
--create proc CreateTracker_EDW_Metadata
--as
GO 

if not exists(Select name from sys.tables where name = 'Tracker_EDW_Metadata')
BEGIN
	print ('Creating the Tracker_EDW_Metadata table');
	CREATE TABLE [dbo].[Tracker_EDW_Metadata] (
			[TableName]             [nvarchar](100) NOT NULL,
			[ColName]               [nvarchar](100) NOT NULL,
			[AttrName]              [nvarchar](100) NOT NULL,
			[AttrVal]               [nvarchar](250) NULL,
			[CreatedDate]           [datetime] NULL,
			[LastModifiedDate]      [datetime] NULL,
			[ID]                    [int] IDENTITY(1, 1) NOT NULL,
			[ClassLastModified]     [datetime] NULL
	) ON [PRIMARY]

	ALTER TABLE [dbo].[Tracker_EDW_Metadata]
	ADD
	CONSTRAINT [DF_Tracker_EDW_Metadata_CreatedDate]
	DEFAULT (getdate()) FOR [CreatedDate]

	ALTER TABLE [dbo].[Tracker_EDW_Metadata]
		ADD
		CONSTRAINT [DF_Tracker_EDW_Metadata_LastModifiedDate]
		DEFAULT (getdate()) FOR [LastModifiedDate]

	CREATE UNIQUE CLUSTERED INDEX [PK_Tracker_EDW_Metadata]
		ON [dbo].[Tracker_EDW_Metadata] ([TableName], [ColName], [AttrName]) ON [PRIMARY]

	ALTER TABLE [dbo].[Tracker_EDW_Metadata] SET (LOCK_ESCALATION = TABLE)

END
GO



if exists (select * from sysobjects where name = 'udfElapsedTime' and type = 'FN')
BEGIN
	drop function udfElapsedTime ;
END 
go
--DECLARE @ElapsedS INT
--declare @start_date datetime = getdate() ;
--declare @end_date  datetime = getdate() ;
--SET @ElapsedS = DATEDIFF(ms, @start_date, @end_date)
--SELECT TimeSpan = dbo.udfTimeSpanFromMilliSeconds(@ElapsedS)
--go

create FUNCTION [dbo].[udfElapsedTime] ( @StartTime as datetime, @EndTime as datetime)
RETURNS varchar(25)
AS
BEGIN
--**********************************************************************
--Author: W. Dale Miller / June 12, 2008
--USE:
--DECLARE @ElapsedS INT
--declare @StartTime datetime = getdate() ;
--declare @EndTime  datetime = getdate() ;
--SET @ElapsedS = DATEDIFF(ms, @start_date, @end_date)
--SELECT TimeSpan = dbo.udfElapsedTime(@StartTime, @EndTime)
--**********************************************************************
	DECLARE 
		 @milliSecs int 
		 , @DisplayTime varchar(50)
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

	set @milliSecs = (SELECT DATEDIFF(millisecond, @StartTime, @EndTime )) ;

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

Print ('Creating udfTimeSpanFromMilliSeconds');

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


print ('Creating UTIL_getUsageCount');

if exists (select * from sysobjects where name = 'UTIL_getUsageCount' and Xtype = 'P')
BEGIN
	drop procedure UTIL_getUsageCount ;
END 
go

-- exec UTIL_getUsageCount 'view_EDW_Coaches'
create proc UTIL_getUsageCount(@SearchToken as nvarchar(200))
as
BEGIN
--***************************************************************************************
--Author: W. Dale Miller
--Date:   08/24/2014
--USE:	  UTIL_getUsageCount('view_EDW_Coaches')
--This utility will wrap @SearchToken in '%' so that is performs a wildcard search.
--The search is limited to a select number of tables, not the entire database.
--To search the entire database, use UTIL_SearchAllTables 'view_EDW_Coaches'.
--Execution time varies upon DB load at the time, but usually in about 40 minutes.
--***************************************************************************************
declare @token nvarchar(250) ;
declare @totCnt int ;
declare @iCnt int ;
DECLARE @sTime datetime ;
DECLARE @eTime datetime ;
DECLARE @Secs int ;
set @iCnt = 0 ; 
set @totCnt = 0 ; 
set @token = '%'+@SearchToken+'%' ;

SET @sTime = GETDATE() ;
set @iCnt = (select COUNT(*) from [CMS_Class] where [ClassFormDefinition] like @token) ;
set @eTime = GETDATE() ;
set @Secs = (SELECT DATEDIFF(SECOND, @sTime, @eTime )) ;
print ('Secs: ' + cast(@Secs as nvarchar));
print ('CMS_Class: ' + cast(@iCnt as nvarchar));
set @totCnt = @totCnt + @iCnt ;

SET @sTime = GETDATE() ;
set @iCnt = (select COUNT(*) from [CMS_Query] where [QueryText] like @token) ;
set @eTime = GETDATE() ;
set @Secs = (SELECT DATEDIFF(SECOND, @sTime, @eTime )) ;
print ('Secs: ' + cast(@Secs as nvarchar));
print ('CMS_Query: ' + cast(@iCnt as nvarchar));
set @totCnt = @totCnt + @iCnt ;

SET @sTime = GETDATE() ;
set @iCnt = (select COUNT(*) from [CMS_Email] where [EmailBody] like @token) ;
set @eTime = GETDATE() ;
set @Secs = (SELECT DATEDIFF(SECOND, @sTime, @eTime )) ;
print ('Secs: ' + cast(@Secs as nvarchar));
print ('CMS_Email: ' + cast(@iCnt as nvarchar));
set @totCnt = @totCnt + @iCnt ;

SET @sTime = GETDATE() ;
set @iCnt = (select COUNT(*) from AuditObjects where [ObjectName] like @token) ;
set @eTime = GETDATE() ;
set @Secs = (SELECT DATEDIFF(SECOND, @sTime, @eTime )) ;
print ('Secs: ' + cast(@Secs as nvarchar));
print ('AuditObjects: ' + cast(@iCnt as nvarchar));
set @totCnt = @totCnt + @iCnt ;
	
SET @sTime = GETDATE() ;
set @iCnt = (select COUNT(*) from [CMS_EventLogArchive] where [EventDescription] like @token) ;
set @eTime = GETDATE() ;
set @Secs = (SELECT DATEDIFF(SECOND, @sTime, @eTime )) ;
print ('Secs: ' + cast(@Secs as nvarchar));
print ('CMS_EventLogArchive: ' + cast(@iCnt as nvarchar));
set @totCnt = @totCnt + @iCnt ;
	
SET @sTime = GETDATE() ;
set @iCnt = (select COUNT(*) from [CMS_ObjectVersionHistory] where [VersionXML] like @token) ;
set @eTime = GETDATE() ;
set @Secs = (SELECT DATEDIFF(SECOND, @sTime, @eTime )) ;
print ('Secs: ' + cast(@Secs as nvarchar));
print ('CMS_ObjectVersionHistory: ' + cast(@iCnt as nvarchar));
set @totCnt = @totCnt + @iCnt ;
--print ('Total Count for '+@token+': ' + cast(@totCnt as nvarchar));

	
SET @sTime = GETDATE() ;
set @iCnt = (select COUNT(*) from [Newsletter_NewsletterIssue] where [IssueText] like @token) ;
set @eTime = GETDATE() ;
set @Secs = (SELECT DATEDIFF(SECOND, @sTime, @eTime )) ;
print ('Secs: ' + cast(@Secs as nvarchar));
print ('[Newsletter_NewsletterIssue]: ' + cast(@iCnt as nvarchar));
set @totCnt = @totCnt + @iCnt ;
--print ('Total Count for '+@token+': ' + cast(@totCnt as nvarchar));

	
SET @sTime = GETDATE() ;
set @iCnt = (select COUNT(*) from [Reporting_ReportGraph] where [GraphQuery] like @token) ;
set @eTime = GETDATE() ;
set @Secs = (SELECT DATEDIFF(SECOND, @sTime, @eTime )) ;
print ('Secs: ' + cast(@Secs as nvarchar));
print ('[Reporting_ReportGraph]: ' + cast(@iCnt as nvarchar));
set @totCnt = @totCnt + @iCnt ;
--print ('Total Count for '+@token+': ' + cast(@totCnt as nvarchar));

	
SET @sTime = GETDATE() ;
set @iCnt = (select COUNT(*) from [CMS_ResourceTranslation] where [TranslationText] like @token) ;
set @eTime = GETDATE() ;
set @Secs = (SELECT DATEDIFF(SECOND, @sTime, @eTime )) ;
print ('Secs: ' + cast(@Secs as nvarchar));
print ('[CMS_ResourceTranslation]: ' + cast(@iCnt as nvarchar));
set @totCnt = @totCnt + @iCnt ;
--print ('Total Count for '+@token+': ' + cast(@totCnt as nvarchar));

	
SET @sTime = GETDATE() ;
set @iCnt = (select COUNT(*) from [CMS_WebPart] where [WebPartProperties] like @token) ;
set @eTime = GETDATE() ;
set @Secs = (SELECT DATEDIFF(SECOND, @sTime, @eTime )) ;
print ('Secs: ' + cast(@Secs as nvarchar));
print ('[CMS_WebPart]: ' + cast(@iCnt as nvarchar));
set @totCnt = @totCnt + @iCnt ;
--print ('Total Count for '+@token+': ' + cast(@totCnt as nvarchar));

	
SET @sTime = GETDATE() ;
set @iCnt = (select COUNT(*) from [CMS_Widget] where [WidgetProperties] like @token) ;
set @eTime = GETDATE() ;
set @Secs = (SELECT DATEDIFF(SECOND, @sTime, @eTime )) ;
print ('Secs: ' + cast(@Secs as nvarchar));
print ('[CMS_Widget]: ' + cast(@iCnt as nvarchar));
set @totCnt = @totCnt + @iCnt ;
--print ('Total Count for '+@token+': ' + cast(@totCnt as nvarchar));

	
SET @sTime = GETDATE() ;
set @iCnt = (select COUNT(*) from [DDLEvents] where [ObjectName] like @token) ;
set @eTime = GETDATE() ;
set @Secs = (SELECT DATEDIFF(SECOND, @sTime, @eTime )) ;
print ('Secs: ' + cast(@Secs as nvarchar));
print ('[DDLEvents]: ' + cast(@iCnt as nvarchar));
set @totCnt = @totCnt + @iCnt ;
--print ('Total Count for '+@token+': ' + cast(@totCnt as nvarchar));

	
SET @sTime = GETDATE() ;
set @iCnt = (select COUNT(*) from [Reporting_ReportTable] where [TableQuery] like @token) ;
set @eTime = GETDATE() ;
set @Secs = (SELECT DATEDIFF(SECOND, @sTime, @eTime )) ;
print ('Secs: ' + cast(@Secs as nvarchar));
print ('[Reporting_ReportTable]: ' + cast(@iCnt as nvarchar));
set @totCnt = @totCnt + @iCnt ;
--print ('Total Count for '+@token+': ' + cast(@totCnt as nvarchar));

	
SET @sTime = GETDATE() ;
set @iCnt = (select COUNT(*) from [Staging_Task] where [TaskData] like @token) ;
set @eTime = GETDATE() ;
set @Secs = (SELECT DATEDIFF(SECOND, @sTime, @eTime )) ;
print ('Secs: ' + cast(@Secs as nvarchar));
print ('[Staging_Task]: ' + cast(@iCnt as nvarchar));
set @totCnt = @totCnt + @iCnt ;
	
SET @sTime = GETDATE() ;
set @iCnt = (select COUNT(*) from [Reporting_ReportValue] where [ValueQuery] like @token) ;
set @eTime = GETDATE() ;
set @Secs = (SELECT DATEDIFF(SECOND, @sTime, @eTime )) ;
print ('Secs: ' + cast(@Secs as nvarchar));
print ('[Reporting_ReportValue]: ' + cast(@iCnt as nvarchar));
set @totCnt = @totCnt + @iCnt ;
	
SET @sTime = GETDATE() ;
set @iCnt = (select COUNT(*) from [EDW_PerformanceMeasure] where ObjectName like @token) ;
set @eTime = GETDATE() ;
set @Secs = (SELECT DATEDIFF(SECOND, @sTime, @eTime )) ;
print ('Secs: ' + cast(@Secs as nvarchar));
print ('[EDW_PerformanceMeasure]: ' + cast(@iCnt as nvarchar));
set @totCnt = @totCnt + @iCnt ;
print ('Total Count for '+@token+': ' + cast(@totCnt as nvarchar));
END

GO

if exists (select * from sysobjects where name = 'UTIL_SearchAllTables' and Xtype = 'P')
BEGIN
	drop procedure UTIL_SearchAllTables ;
END 
go


--EXEC UTIL_SearchAllTables 'View_HFit_UserGoals'
--GO 
--EXEC UTIL_SearchAllTables 'view_HFit_TrackerEvents'
--GO 
--EXEC UTIL_SearchAllTables 'view_EDW_Coaches'
--GO 
--EXEC UTIL_SearchAllTables 'View_EDW_HealthAssesmentQuestions'
--GO 
--select * from [dbo].[EDW_PerformanceMeasure]
--select * from [Staging_Task] where [TaskData] like '%view_HFit_TrackerEvents%'

create PROC UTIL_SearchAllTables
(
	@SearchStr nvarchar(100)
)
AS
BEGIN

--DECLARE @SearchStr NVARCHAR(100);
--SET @SearchStr = 'View_EDW_HealthAssesmentQuestions' ;

	-- Purpose: To search all columns of all tables for a given string
	-- Written by: WDM
	-- Site: http://www.dmachicago.com
	-- Tested on: SQL Server 7.0 and SQL Server 2000, 2005, 2008, 2012
	-- Date created:  26 July 2000
	-- Date modified: 26 July 2004
	-- Date modified: 20 Aug  2014

	--CREATE TABLE #Results (ColumnName nvarchar(370), ColumnValue nvarchar(3630), SearchTerm nvarchar(250))
	CREATE TABLE #Results (ColumnName nvarchar(370), ColumnValue nvarchar(3630))

	SET NOCOUNT ON

	DECLARE @TableName nvarchar(256), @ColumnName nvarchar(128), @SearchStr2 nvarchar(110), @SearchStrMain nvarchar(110)
	SET  @TableName = '' ;
	SET @SearchStr2 = QUOTENAME('%' + @SearchStr + '%','''') ;
	SET @SearchStrMain = @SearchStr ;

	WHILE @TableName IS NOT NULL
	BEGIN
		SET @ColumnName = ''
		SET @TableName = 
		(
			SELECT MIN(QUOTENAME(TABLE_SCHEMA) + '.' + QUOTENAME(TABLE_NAME))
			FROM 	INFORMATION_SCHEMA.TABLES
			WHERE 		TABLE_TYPE = 'BASE TABLE'
				AND	QUOTENAME(TABLE_SCHEMA) + '.' + QUOTENAME(TABLE_NAME) > @TableName
				AND	OBJECTPROPERTY(
						OBJECT_ID(
							QUOTENAME(TABLE_SCHEMA) + '.' + QUOTENAME(TABLE_NAME)
							 ), 'IsMSShipped'
						       ) = 0
		)

		WHILE (@TableName IS NOT NULL) AND (@ColumnName IS NOT NULL)
		BEGIN
			SET @ColumnName =
			(
				SELECT MIN(QUOTENAME(COLUMN_NAME))
				FROM 	INFORMATION_SCHEMA.COLUMNS
				WHERE 		TABLE_SCHEMA	= PARSENAME(@TableName, 2)
					AND	TABLE_NAME	= PARSENAME(@TableName, 1)
					AND	DATA_TYPE IN ('char', 'varchar', 'nchar', 'nvarchar')
					AND	QUOTENAME(COLUMN_NAME) > @ColumnName
			)
	
			IF @ColumnName IS NOT NULL
			BEGIN
				INSERT INTO #Results
				EXEC
				(
					'SELECT ''' + @TableName + '.' + @ColumnName + '.' +@SearchStrMain+  ''', LEFT(' + @ColumnName + ', 3630) 
					FROM ' + @TableName + ' (NOLOCK) ' +
					' WHERE ' + @ColumnName + ' LIKE ' + @SearchStr2
				)
			
				--update #Results set SearchTerm = @SearchStr where SearchTerm is null ;
				
				--INSERT INTO TempResults
				--EXEC
				--(
				--	'Select * from #Results ' 
				--)
				
			END
		END	
	END
				
	SELECT ColumnName, ColumnValue FROM #Results
END


GO
if exists (select * from sysobjects where name = 'UTIL_ViewAnalysis' and Xtype = 'P')
BEGIN
	drop procedure UTIL_ViewAnalysis ;
END 
go



CREATE procedure [dbo].[UTIL_ViewAnalysis] @TargetView nvarchar(80) 
as
BEGIN
----------------------------------------------------------------------------
-- Analyze Nested Views - they will sooner or later cause great pain.
-- Created: 7/26/2008
-- DMA Limited, Chicago, IL
-- W. Dale Miller
-- dm@DmaChicago.com
----------------------------------------------------------------------------
-- Create a temp table to hold the combination view/table hierarchy
	IF EXISTS
		(
			SELECT name
			FROM tempdb.dbo.sysobjects
			WHERE ID = OBJECT_ID(N'tempdb..#NestedViews')
		)
		BEGIN
			DROP TABLE #NestedViews
		END

	CREATE TABLE #NestedViews
		( id INT IDENTITY(1,1)
		, parent_view_id INT
		, referenced_schema_name NVARCHAR(255)
		, referenced_entity_name NVARCHAR(255)
		, join_clause NVARCHAR(MAX)
		, [LEVEL] TINYINT
		, lineage NVARCHAR(MAX)
		)
	DECLARE @viewname NVARCHAR(1000),
	@count INT,        -- Current ID
	@maxCount INT    -- Max ID of the temp table

	-- Set the name of the view you want to analyze
	-- This is generally the TOP Level View, but can be one that is contained within another.
	SELECT @viewName = @TargetView,
	@count = 1
	----------------------------------------------------------------------------
	-- Seed the table with the root view, and the root view's referenced tables.
	----------------------------------------------------------------------------
	INSERT INTO #NestedViews
	SELECT NULL parent_view_id
		, 'dbo' referenced_schema_name
		, @viewName referenced_entity_name
		, NULL join_clause
		, 0 [LEVEL]
		, '/' lineage

	INSERT INTO #NestedViews
	SELECT DISTINCT @count parent_view_id
		, referenced_schema_name
		, referenced_entity_name
		, '' join_clause
		, 1 [LEVEL]
		, '/1/' lineage
		FROM sys.dm_sql_referenced_entities(N'dbo.' + @viewName,'OBJECT')

	SELECT @maxCount = MAX(id)
		FROM #NestedViews
	----------------------------------------------------------------------------
	-- Loop through the nested views and process ALL rows.
	----------------------------------------------------------------------------
	WHILE (@count < @maxCount)
	BEGIN
		SELECT @count = @count + 1

		-- Get the name of the current view (that one of interest where references are desired)
		SELECT @viewName = referenced_entity_name
		FROM #NestedViews
		WHERE id = @count

			-- If it's a view (not a table), insert referenced objects into temp table.
		IF EXISTS (SELECT name FROM sys.objects WHERE name = @viewName AND TYPE = 'v')
		BEGIN
			INSERT INTO #NestedViews
			SELECT DISTINCT @count parent_view_id
			, referenced_schema_name
			, referenced_entity_name
			, '' join_clause
			, NULL [LEVEL]
			, '' lineage
			FROM sys.dm_sql_referenced_entities(N'dbo.' + @viewName,'OBJECT')
			SELECT @maxCount = MAX(id)
			FROM #NestedViews
		END
	END
	--------------------------------------
	--------------------------------------
	WHILE EXISTS (SELECT 1 FROM #NestedViews WHERE [LEVEL] IS NULL)
		UPDATE NVHL2
		SET NVHL2.[Level] = NVHL1.[Level] + 1, NVHL2.Lineage = NVHL1.Lineage + LTRIM(STR(NVHL2.parent_view_id,6,0)) + '/'
	FROM #NestedViews AS NVHL2
		INNER JOIN #NestedViews AS NVHL1 ON (NVHL2.parent_view_id=NVHL1.ID)
	WHERE NVHL1.[Level]>=0
		AND NVHL1.Lineage IS NOT NULL
		AND NVHL2.[Level] IS NULL

	SELECT parent.*, child.id, child.referenced_entity_name ChildName
	FROM #NestedViews parent
		RIGHT OUTER JOIN #NestedViews child ON child.parent_view_id = parent.id
	ORDER BY parent.id, child.id

END

GO



if exists(select TABLE_NAME from INFORMATION_SCHEMA.VIEWS where TABLE_NAME = 'view_EDW_ClientCompany')
BEGIN
	drop view view_EDW_ClientCompany ;
END
GO



CREATE VIEW [dbo].[view_EDW_ClientCompany]
AS
--************************************************************
--One of the few views in the system that is not nested. 
--It combines the Account, Site and Company data.
--Last Tested: 09/04/2014 WDM
--WDM 9.10.2014 - verified dates were available to the EDW
--************************************************************
	SELECT
		hfa.AccountID
		, HFA.AccountCD
		, HFA.AccountName
		, HFA.ItemCreatedWhen as AccountCreated
		, HFA.ItemModifiedWhen as AccountModified
		, HFA.ItemGUID AccountGUID
		, CS.SiteID
		, CS.SiteGUID
		, CS.SiteLastModified
		, HFC.CompanyID
		, HFC.ParentID
		, HFC.CompanyName
		, HFC.CompanyShortName
		, HFC.CompanyStartDate
		, HFC.CompanyEndDate
		, HFC.CompanyStatus
		, CASE	WHEN CAST(hfa.ItemCreatedWhen AS DATE) = CAST(HFA.ItemModifiedWhen AS DATE)
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		, NULL AS CompanyCreated
		, NULL AS CompanyModified
	FROM
		dbo.HFit_Account AS HFA
	INNER JOIN dbo.CMS_Site AS CS ON HFA.SiteID = cs.SiteID
	LEFT OUTER JOIN dbo.HFit_Company AS HFC ON HFA.AccountID = hfc.AccountID






GO



if exists(select TABLE_NAME from INFORMATION_SCHEMA.VIEWS where TABLE_NAME = 'view_EDW_Coaches')
BEGIN
	drop view view_EDW_Coaches ;
END
GO

--****************************************************
-- Verified last mod date available to EDW 9.10.2014
--****************************************************
CREATE VIEW [dbo].[view_EDW_Coaches]

AS

SELECT distinct
    cu.UserGUID
   ,cs.SiteGUID
   ,HFA.AccountID
   ,HFA.AccountCD
   ,CoachID
   ,hfc.LastName
   ,hfc.FirstName
   ,hfc.StartDate
   ,hfc.Phone
   ,hfc.email
   ,hfc.Supervisor
   ,hfc.SuperCoach
   ,hfc.MaxParticipants
   ,hfc.Inactive
   ,hfc.MaxRiskLevel
   ,hfc.Locked
   ,hfc.TimeLocked
   ,hfc.terminated
   ,hfc.APMaxParticipants
   ,hfc.RNMaxParticipants
   ,hfc.RNPMaxParticipants
   ,hfc.Change_Type
   ,hfc.Last_Update_Dt
FROM
    dbo.HFit_Coaches AS HFC
LEFT OUTER JOIN dbo.CMS_User AS CU ON hfc.KenticoUserID = cu.UserID
LEFT OUTER JOIN dbo.CMS_UserSite AS CUS ON cu.userid = cus.UserID
LEFT OUTER JOIN dbo.CMS_Site AS CS ON CS.SiteID = CUS.SiteID
LEFT OUTER JOIN dbo.HFit_Account AS HFA ON cs.SiteID = hfa.SiteID

GO



if exists(select TABLE_NAME from INFORMATION_SCHEMA.VIEWS where TABLE_NAME = 'view_EDW_CoachingDefinition')
BEGIN
	drop view view_EDW_CoachingDefinition ;
END
GO


--GRANT SELECT
--	ON [dbo].[view_EDW_CoachingDefinition]
--	TO [EDWReader_PRD]
--GO


CREATE VIEW [dbo].[view_EDW_CoachingDefinition]
AS
--****************************************************
--8/7/2014 - added DocumentGuid 
--8/8/2014 - Generated corrected view in DEV (WDM)
-- Verified last mod date available to EDW 9.10.2014
--****************************************************
SELECT
	GJ.GoalID
	, GJ.DocumentGuid	--, GJ.DocumentID
	, GJ.NodeSiteID
	, cs.SiteGUID
	, GJ.GoalImage
	, GJ.Goal
	, dbo.udf_StripHTML(GJ.GoalText) GoalText --
	, dbo.udf_StripHTML(GJ.GoalSummary) GoalSummary --
	, GJ.TrackerAssociation  --GJ.TrackerAssociation
	, GJ.GoalFrequency
	, HFLF.FrequencySingular
	, HFLF.FrequencyPlural
	, GJ.GoalUnitOfMeasure
	, HFLUOM.UnitOfMeasure
	, GJ.GoalDirection
	, GJ.GoalPrecision
	, GJ.GoalAbsoluteMin
	, GJ.GoalAbsoluteMax
	, dbo.udf_StripHTML(GJ.SetGoalText) SetGoalText --
	, dbo.udf_StripHTML(GJ.HelpText) HelpText --
	, GJ.EvaluationType
	, GJ.CatalogDisplay
	, GJ.AllowModification
	, GJ.ActivityText
	, dbo.udf_StripHTML(GJ.SetGoalModifyText) SetgoalModifyText
	, GJ.IsLifestyleGoal
	, GJ.CodeName
	, CASE	WHEN CAST(gj.DocumentCreatedWhen AS DATE) = CAST(gj.DocumentModifiedWhen AS DATE)
			THEN 'I'
			ELSE 'U'
		END AS ChangeType
	, GJ.DocumentCreatedWhen
	, GJ.DocumentModifiedWhen
FROM
	(
		SELECT
			VHFGJ.GoalID
			, VHFGJ.DocumentGuid	--, VHFGJ.DocumentID
			, VHFGJ.NodeSiteID
			, VHFGJ.GoalImage
			, VHFGJ.Goal
			, VHFGJ.GoalText
			, VHFGJ.GoalSummary
			, VHFGJ.TrackerNodeGUID as TrackerAssociation  --VHFGJ.TrackerAssociation
			, VHFGJ.GoalFrequency
			, VHFGJ.GoalUnitOfMeasure
			, VHFGJ.GoalDirection
			, VHFGJ.GoalPrecision
			, VHFGJ.GoalAbsoluteMin
			, VHFGJ.GoalAbsoluteMax
			, VHFGJ.SetGoalText
			, VHFGJ.HelpText
			, VHFGJ.EvaluationType
			, VHFGJ.CatalogDisplay
			, VHFGJ.AllowModification
			, VHFGJ.ActivityText
			, VHFGJ.SetGoalModifyText
			, VHFGJ.IsLifestyleGoal
			, VHFGJ.CodeName
			, VHFGJ.DocumentCreatedWhen
			, VHFGJ.DocumentModifiedWhen
		FROM
			dbo.View_HFit_Goal_Joined AS VHFGJ
		UNION ALL
		SELECT
			VHFTGJ.GoalID
			, VHFTGJ.DocumentGuid	--, VHFTGJ.DocumentID
			, VHFTGJ.NodeSiteID
			, VHFTGJ.GoalImage
			, VHFTGJ.Goal
			, NULL AS GoalText
			, VHFTGJ.GoalSummary
			, VHFTGJ.TrackerNodeGUID as TrackerAssociation  --VHFTGJ.TrackerAssociation
			, VHFTGJ.GoalFrequency
			, NULL AS GoalUnitOfMeasure
			, VHFTGJ.GoalDirection
			, VHFTGJ.GoalPrecision
			, VHFTGJ.GoalAbsoluteMin
			, VHFTGJ.GoalAbsoluteMax
			, NULL AS SetGoalText
			, NULL AS HelpText
			, VHFTGJ.EvaluationType
			, VHFTGJ.CatalogDisplay
			, VHFTGJ.AllowModification
			, VHFTGJ.ActivityText
			, NULL SetGoalModifyText
			, VHFTGJ.IsLifestyleGoal
			, VHFTGJ.CodeName
			, VHFTGJ.DocumentCreatedWhen
			, VHFTGJ.DocumentModifiedWhen
		FROM
			dbo.View_HFit_Tobacco_Goal_Joined AS VHFTGJ
	) AS GJ
LEFT OUTER JOIN dbo.HFit_LKP_UnitOfMeasure AS HFLUOM ON GJ.GoalUnitOfMeasure = HFLUOM.UnitOfMeasureID
LEFT OUTER JOIN dbo.HFit_LKP_Frequency AS HFLF ON GJ.GoalFrequency = HFLF.FrequencyID
INNER JOIN cms_site AS CS ON gj.nodesiteid = cs.siteid
--INNER JOIN cms_site AS CS ON gj.siteguid = cs.siteguid
WHERE
	gj.DocumentCreatedWhen IS NOT NULL
	AND gj.DocumentModifiedWhen IS NOT NULL 



GO



if exists(select TABLE_NAME from INFORMATION_SCHEMA.VIEWS where TABLE_NAME = 'view_EDW_CoachingDetail')
BEGIN
	drop view view_EDW_CoachingDetail ;
END
GO




--GRANT SELECT
--	ON [dbo].[[view_EDW_CoachingDetail]]
--	TO [EDWReader_PRD]
--GO

create VIEW [dbo].[view_EDW_CoachingDetail]
AS
--****************************************************
--8/7/2014 - added and commented out DocumentGuid in case needed later
--8/8/2014 - Generated corrected view in DEV (WDM)
-- Verified last mod date available to EDW 9.10.2014
--****************************************************
	SELECT	
		HFUG.ItemID
		, HFUG.ItemGUID
		, GJ.GoalID
		, HFUG.UserID
		, cu.UserGUID
		, cus.HFitUserMpiNumber
		, cs.SiteGUID
		, hfa.AccountID
		, hfa.AccountCD
		, hfa.AccountName
		, HFUG.IsCreatedByCoach
		, HFUG.BaselineAmount
		, HFUG.GoalAmount
		, Null As DocumentID
		, HFUG.GoalStatusLKPID
		, HFLGS.GoalStatusLKPName
		, HFUG.EvaluationStartDate
		, HFUG.EvaluationEndDate
		, HFUG.GoalStartDate
		, HFUG.CoachDescription
		, HFGO.EvaluationDate
		, HFGO.Passed
		, HFGO.WeekendDate
		, CASE	WHEN CAST(HFUG.ItemCreatedWhen AS DATE) = CAST(HFUG.ItemModifiedWhen AS DATE)
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		, HFUG.ItemCreatedWhen
		, HFUG.ItemModifiedWhen
		, GJ.NodeGUID
		--, GJ.DocumentGUID	--WDM 8/7/2014 Added in case needed
		--, GJ.DocumentModifiedWhen as UserGoal_DocumentModifiedWhen	--WDM added 9.10.2014
	FROM
		dbo.HFit_UserGoal AS HFUG WITH ( NOLOCK )
	INNER JOIN (
					SELECT
						VHFGJ.GoalID
						, VHFGJ.NodeID
						, VHFGJ.NodeGUID
						, VHFGJ.DocumentCulture
						, VHFGJ.DocumentGuid
						, VHFGJ.DocumentModifiedWhen	--WDM added 9.10.2014
					FROM
						dbo.View_HFit_Goal_Joined AS VHFGJ WITH ( NOLOCK )
					UNION ALL
					SELECT
						VHFTGJ.GoalID
						, VHFTGJ.NodeID
						, VHFTGJ.NodeGUID
						, VHFTGJ.DocumentCulture
						, VHFTGJ.DocumentGuid
						, VHFTGJ.DocumentModifiedWhen	--WDM added 9.10.2014
					FROM
						dbo.View_HFit_Tobacco_Goal_Joined AS VHFTGJ WITH ( NOLOCK )
				) AS GJ ON hfug.NodeID = gj.NodeID and GJ.DocumentCulture = 'en-us'
	INNER JOIN dbo.HFit_GoalOutcome AS HFGO WITH ( NOLOCK ) ON HFUG.ItemID = HFGO.UserGoalItemID
	INNER JOIN dbo.HFit_LKP_GoalStatus AS HFLGS WITH ( NOLOCK ) ON HFUG.GoalStatusLKPID = HFLGS.GoalStatusLKPID
	INNER JOIN dbo.CMS_User AS CU WITH ( NOLOCK ) ON HFUG.UserID = cu.UserID
	INNER JOIN dbo.CMS_UserSettings AS CUS WITH ( NOLOCK ) ON CU.UserGUID = CUS.UserSettingsUserGUID
	INNER JOIN dbo.CMS_UserSite AS CUS2 WITH ( NOLOCK ) ON cu.UserID = CUS2.UserID
	INNER JOIN dbo.CMS_Site AS CS WITH ( NOLOCK ) ON CUS2.SiteID = CS.SiteID
	INNER JOIN dbo.HFit_Account AS HFA WITH ( NOLOCK ) ON cs.SiteID = hfa.SiteID





GO



if exists(select TABLE_NAME from INFORMATION_SCHEMA.VIEWS where TABLE_NAME = 'view_EDW_HealthAssesment')
BEGIN
	drop view view_EDW_HealthAssesment ;
END
GO


create VIEW [dbo].[view_EDW_HealthAssesment]
AS
--****************************************************
--7/15/2014 17:19 min. 46,750 Rows DEV
--7/15/2014 per Mark Turner
--HAModuleDocumentID is on its way out, so is - 
--Module - RiskCategory - RiskArea - Question - Answer 
--all the "DocumentID" fields are deprecated and replaced by corresponding NodeGUID fields
--8/7/2014 - Executed in DEV with GUID changes and returned 51K Rows in 43:10.
--8/8/2014 - Generated corrected view in DEV
-- Verified last mod date available to EDW 9.10.2014
--****************************************************
	SELECT 
		HAUserStarted.ItemID AS UserStartedItemID		
		, HAUserStarted.HALastQuestionNodeGUID as  HealthAssesmentUserStartedNodeGUID		--WDM 8/7/2014  as HADocumentID
		, HAUserStarted.UserID
		, CMSUser.UserGUID
		, UserSettings.HFitUserMpiNumber
		, CMSSite.SiteGUID
		, ACCT.AccountID
		, ACCT.AccountCD
		, HAUserStarted.HAStartedDt
		, HAUserStarted.HACompletedDt
		, HAUserModule.ItemID AS UserModuleItemId
		, HAUserModule.CodeName AS UserModuleCodeName
		, HAUserModule.HAModuleNodeGUID							--WDM 8/7/2014 as HAModuleDocumentID
		, NULL as HAModuleVersionID
		, HARiskCategory.ItemID AS UserRiskCategoryItemID
		, HARiskCategory.CodeName AS UserRiskCategoryCodeName
		, HARiskCategory.HARiskCategoryNodeGUID						--WDM 8/7/2014 as HARiskCategoryDocumentID
		, NULL as HARiskCategoryVersionID
		, HAUserRiskArea.ItemID AS UserRiskAreaItemID
		, HAUserRiskArea.CodeName AS UserRiskAreaCodeName
		, HAUserRiskArea.HARiskAreaNodeGUID								--WDM 8/7/2014 as HARiskAreaDocumentID
		, NULL as HARiskAreaVersionID
		, HAUserQuestion.ItemID AS UserQuestionItemID
		, HAQuestionsView.Title
		, HAUserQuestion.HAQuestionNodeGUID	as HAQuestionGuid			--WDM 9.2.2014
		, HAUserQuestion.CodeName AS UserQuestionCodeName
		, HAUserQuestion.HAQuestionDocumentID_old as HAQuestionDocumentID	--WDM 9.2.2014
		
		, HAUserQuestion.HAQuestionVersionID_old as HAQuestionVersionID		
		
		, HAUserQuestion.HAQuestionNodeGUID		
						
		, HAUserAnswers.ItemID AS UserAnswerItemID
		, HAUserAnswers.HAAnswerNodeGUID								--WDM 8/7/2014 as HAAnswerDocumentID

		, HAUserAnswers.HAAnswerVersionID_old as HAAnswerVersionID		--WDM 9.2.2014
		, HAUserAnswers.CodeName AS UserAnswerCodeName
		, HAUserAnswers.HAAnswerValue
		, HAUserModule.HAModuleScore
		, HARiskCategory.HARiskCategoryScore
		, HAUserRiskArea.HARiskAreaScore
		, HAUserQuestion.HAQuestionScore
		, HAUserAnswers.HAAnswerPoints
		, HAUserQuestionGroupResults.PointResults
		, HAUserAnswers.UOMCode
		, HAUserStarted.HAScore
		, HAUserModule.PreWeightedScore AS ModulePreWeightedScore
		, HARiskCategory.PreWeightedScore AS RiskCategoryPreWeightedScore
		, HAUserRiskArea.PreWeightedScore AS RiskAreaPreWeightedScore
		, HAUserQuestion.PreWeightedScore AS QuestionPreWeightedScore
		, HAUserQuestionGroupResults.CodeName AS QuestionGroupCodeName       
       ,CASE WHEN HAUserAnswers.ItemCreatedWhen = HAUserAnswers.ItemModifiedWhen THEN 'I'
             ELSE 'U'
        END AS ChangeType
		,HAUserAnswers.ItemCreatedWhen
       ,HAUserAnswers.ItemModifiedWhen
	   ,HAUserQuestion.IsProfessionallyCollected

	   ,HARiskCategory.ItemModifiedWhen as HARiskCategory_ItemModifiedWhen
	   ,HAUserRiskArea.ItemModifiedWhen as HAUserRiskArea_ItemModifiedWhen
	   ,HAUserQuestion.ItemModifiedWhen as HAUserQuestion_ItemModifiedWhen
	   ,HAUserAnswers.ItemModifiedWhen as HAUserAnswers_ItemModifiedWhen

	FROM
	dbo.HFit_HealthAssesmentUserStarted AS HAUserStarted
	INNER JOIN dbo.CMS_User AS CMSUser ON HAUserStarted.UserID = CMSUser.UserID
	INNER JOIN dbo.CMS_UserSettings AS UserSettings ON UserSettings.UserSettingsUserID = CMSUser.UserID
	INNER JOIN dbo.CMS_UserSite AS UserSite ON CMSUser.UserID = UserSite.UserID
	INNER JOIN dbo.CMS_Site AS CMSSite ON UserSite.SiteID = CMSSite.SiteID
	INNER JOIN dbo.HFit_Account AS ACCT ON ACCT.SiteID = CMSSite.SiteID
	
	--The following JOIN can be put back in place once the DEV columns are added to the TABLES and SYNC'D
	--AND THE second JOIN can be removed.
	INNER JOIN dbo.HFit_HealthAssesmentUserModule AS HAUserModule ON HAUserStarted.ItemID = HAUserModule.HAStartedItemID
	--INNER JOIN dbo.view_EDW_HFit_HealthAssesmentUserModule AS HAUserModule ON HAUserStarted.ItemID = HAUserModule.HAStartedItemID

	--The following JOIN can be put back in place once the DEV columns are added to the TABLES and SYNC'D
	--AND THE second JOIN can be removed.
	INNER JOIN dbo.HFit_HealthAssesmentUserRiskCategory AS HARiskCategory ON HAUserModule.ItemID = HARiskCategory.HAModuleItemID
	--INNER JOIN dbo.view_EDW_HFit_HealthAssesmentUserRiskCategory AS HARiskCategory ON HAUserModule.ItemID = HARiskCategory.HAModuleItemID

	--The following JOIN can be put back in place once the DEV columns are added to the TABLES and SYNC'D
	--AND THE second JOIN can be removed.
	INNER JOIN dbo.HFit_HealthAssesmentUserRiskArea AS HAUserRiskArea ON HARiskCategory.ItemID = HAUserRiskArea.HARiskCategoryItemID
	--INNER JOIN dbo.view_EDW_HFit_HealthAssesmentUserRiskArea AS HAUserRiskArea ON HARiskCategory.ItemID = HAUserRiskArea.HARiskCategoryItemID
	
	--The following JOIN can be put back in place once the DEV columns are added to the TABLES and SYNC'D
	--AND THE second JOIN can be removed.
	INNER JOIN dbo.HFit_HealthAssesmentUserQuestion AS HAUserQuestion ON HAUserRiskArea.ItemID = HAUserQuestion.HARiskAreaItemID
	--INNER JOIN dbo.view_EDW_HFit_HealthAssesmentUserQuestion AS HAUserQuestion ON HAUserRiskArea.ItemID = HAUserQuestion.HARiskAreaItemID

	--The following JOIN can be put back in place once the DEV columns are added to the TABLES and SYNC'D
	--AND THE second JOIN can be removed.
	INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS HAQuestionsView ON HAUserQuestion.HAQuestionNodeGUID = HAQuestionsView.NodeGUID
	--INNER JOIN dbo.view_EDW_HFit_HealthAssesmentUserQuestion AS HAQuestionsView ON HAUserQuestion.HAQuestionNodeGUID = HAQuestionsView.NodeGUID

	LEFT OUTER JOIN dbo.HFit_HealthAssesmentUserQuestionGroupResults AS HAUserQuestionGroupResults ON HAUserQuestion.ItemID = HAUserQuestionGroupResults.HARiskAreaItemID
	INNER JOIN dbo.HFit_HealthAssesmentUserAnswers AS HAUserAnswers ON HAUserQuestion.ItemID = HAUserAnswers.HAQuestionItemID


--select * from HFit_HealthAssesmentUserQuestionGroupResults
--where HARiskAreaItemID 
----in (select ItemID from HFit_HealthAssesmentUserQuestion)
--in (73416,73453,73523,88000,88921,89002,89083,89249,89465,89613,89696,89777,89846,89921,89998,90080,90219,90394,90516,90546,90622,90692,90845,90997,91094,91213,91230,91313,91861,91936,92008,92082,92238,92375,92385,92464,92537,92608,92693,92765,92840,92915,92994,93076,93158,93240,93459,93534,93614,93700,93755,94803,98618,98699,98780,98861,98929,99079,99150,99268,99290,99792,99831,99898,100016,100033,100102,100197,100232,100316,100390,100464,100620,100687,100756,100963,101032,101108,101188,101273,101414,176301,176805,176962,182455,192468,192531,192592,192769,192863,192934,193001,89411,89592,90153,90335,90778,90970,92166,99012,99379,99483,99677,100544,192706,73416,73453,73523,88000,88921,89002,89083,89249,89465,89613,89696,89777,89846,89921,89998,90080,90219,90394,90516,90546,90622,90692,90845,90997,91094,91213,91230,91313,91861,91936,92008,92082,92238,92375,92385,92464,92537,92608,92693,92765,92840,92915,92994,93076,93158,93240,93459,93534,93614,93700,93755,94803,98618,98699,98780,98861,98929,99079,99150,99268,99290,99792,99831,99898,100016,100033,100102,100197,100232,100316,100390,100464,100620,100687,100756,100963,101032,101108,101188,101273,101414,176301,176805,176962,182455,192468,192531,192592,192769,192863,192934,193001,89411,89592,90153,90335,90778,90970,92166,99012,99379,99483,99677,100544,192706,73532,88170,89163,89310,89621,89928,90005,90289,90405,90553,91796,91943,92544,92615,92700,93630,98555,98786,99206,99893,100399,100694,101345,176734,191966,192479,92089,99580,73532,88170,89163,89310,89621,89928,90005,90289,90405,90553,91796,91943,92544,92615,92700,93630,98555,98786,99206,99893,100399,100694,101345,176734,191966,192479,92089,99580,54885,54885,54885,54885,54885,54885,54885,54885,54885,54885,73466,73466,73470,73551,73547,73547,73470,73551,73410,73498,73570,73410,73498,73570,74864,74864,92325,92333,92437,92412,92483,92412,92483,92406,92406,176900,176900,176749,176749,176753,176778,176753,176909,176936,176909,192653,192614,192724,192566,192741,192614,192724,192653,192610,192610,192643,192643,192745,192745,192679,100125,100412,100412,100125,100496,100420,100146,100517,100437,100496,100420,100146,91047,91098,91047,91098,90923,90962,91068,91016,91016,91043,91043,99459,99459,99455,91981,92033,92263,92290,92033,92263,92290,92029,92259,92029,92259,89394,89340,89394,89340,89401,89329,89329,89344,89401,89376,89344,92115,92139,92054,92209,92192,92115,92192,92102,92185,92102,92185,92214,92214,92111,92111,91724,91809,91724,91809,91735,91735,92942,92942,92581,92666,92814,92889,92712,92934,92712,92934,89897,89897,89865,89865,89751,89820,89892,89800,89872,89949,89800,89872,89949,99034,99173,99221,99034,99173,99221,99327,98986,99239,99053,99327,99316,99316,93408,93408,93645,93645,93726,93586,93649,93707,93416,93416,93649,93707,89643,89725,89643,89725,89971,89558,89670,89550,89634,89715,89634,89715,89557,89557,93731,93731,93673,87729,87729,92786,92861,92786,92861,92558,92628,92558,92628,92564,92639,92720,92790,92865,92564,92639,92720,92790,92865,92738,92510,89270,89270,91958,91958,91879,91879,91912,91912,91762,91834,91907,91817,91887,91961,91817,91887,91961,90430,90568,90640,90568,90640,90430,90240,90586,90240,90421,90632,90421,90632,100251,100292,100251,100292,100258,100339,100258,100339,100262,100343,100152,100206,100287,100363,100262,100343,98646,98882,98646,98903,98882,98958,98958,98950,98637,98950,98637,93013,93096,93013,93096,92967,93050,93023,93023,101364,101387,101364,101360,101360,90101,90101,90018,90018,90105,90127,90053,90192,90026,90174,90105,90026,90174,89493,89514,89436,89514,89300,89441,89300,89441,89487,89487,89493,93480,93480,93550,93550,93433,93508,93484,93560,93484,93560,90794,90898,90794,90898,90716,90893,90666,90816,90737,90716,90893,90784,90875,90784,90875,90821,90821,90714,90889,90714,90889,91249,91249,91183,91287,91258,91258,89274,89057,88894,89274,88894,89057,87877,87877,99712,99763,99850,99793,99856,99793,99856,99774,99841,99774,73389,73435,73373,73430,73506,73373,73430,73506,73392,73438,73512,73387,73433,73387,73433,73392,73438,73512,73404,73446,73519,73404,73446,73519,73382,73417,73535,73382,73417,73535,92389,92468,92389,92468,92369,92379,92458,92369,92379,92458,92325,92333,92437,92346,92362,92450,92341,92357,92446,92341,92357,92446,92346,92362,92450,92338,92356,92445,92343,92359,92448,92338,92356,92445,176295,176295,176799,176799,176778,176737,176890,176737,176890,176786,176792,176787,176792,176787,176786,176943,176944,176949,176944,176949,176943,177063,177063,176936,176956,176956,192586,192763,192700,192586,192763,192700,192566,192741,192679,192629,192598,192710,192778,192598,192710,192778,192629,192573,192750,192687,192579,192756,192693,192574,192751,192688,192579,192756,192693,192574,192751,192688,192573,192750,192687,100525,100445,100448,100526,100446,100531,100451,100526,100446,100531,100451,100525,100445,100468,100484,100553,100468,100484,100553,100517,100437,100538,100458,100538,100458,90769,90959,90769,90959,90991,90962,91068,90923,90991,91006,91031,91006,91031,90938,90978,90762,90949,90984,91081,90757,90944,90979,91076,90979,91076,90762,90949,90984,91081,90757,90944,90981,91078,90978,90938,99464,99465,99470,99465,99470,99464,99492,99492,99455,99477,99477,92002,91981,92002,92017,92277,92277,92017,91989,91995,91990,91990,91995,91989,91992,98558,98558,89311,89317,89311,89317,89376,89405,89405,89390,89385,89385,89390,89383,89383,92147,92063,92219,92066,92222,92147,92063,92219,92153,92153,92069,92225,92148,92148,92148,92064,92220,92064,92220,92148,92148,92148,92153,92153,92069,92225,92160,92160,92076,92232,92139,92054,92209,92076,92232,92092,92175,92247,92175,92247,92092,91714,91714,92924,92924,92687,92759,92834,92909,92581,92666,92814,92889,92687,92759,92834,92909,92594,92680,92902,92897,92590,92675,92590,92675,92897,92594,92680,92902,92674,92821,92896,92592,92677,92899,92821,92896,92674,89761,89830,89905,89758,89827,89902,89758,89827,89902,89764,89833,89908,89759,89828,89903,89759,89828,89903,89764,89833,89908,89771,89840,89915,89751,89820,89892,89771,89840,89915,89786,89855,89931,89786,89855,89931,91088,91088,91075,91075,99249,98993,98993,99249,98999,98999,98994,99133,98994,99133,99006,99073,99144,99262,99284,99006,99073,99144,99262,99284,99053,99239,98986,99022,99088,99209,99022,99088,99209,93623,93623,93586,93726,93607,93694,93607,93694,93595,93682,93595,93682,93600,93687,93600,93687,93594,93736,93594,93736,93597,93684,89595,89681,89591,89678,89564,89564,89591,89678,89570,89598,89684,89570,89598,89684,89565,89593,89679,89565,89593,89679,89606,89691,89577,89577,89606,89691,89971,89558,89670,89550,89624,89705,89624,89705,93673,93749,93749,93737,93737,93742,93742,93681,93681,93739,87693,87693,92547,92618,92703,92774,92849,92547,92618,92703,92774,92849,92531,92602,92531,92602,92738,92510,92745,92518,92589,92751,92827,92524,92751,92827,92524,92749,92822,92519,92749,92822,92519,92748,92824,92521,92745,92518,92589,89230,89233,89231,89231,89236,89236,89230,89258,89258,91799,91870,91946,91799,91870,91946,91762,91834,91907,91855,91930,91855,91930,91769,91842,91917,91848,91848,91848,91923,91848,91848,91848,91923,91843,91918,91843,91918,91845,91920,91769,91842,91917,90595,90293,90600,90596,90596,90297,90603,90302,90297,90603,90302,90293,90595,90611,90611,90586,90296,90410,90411,90556,90617,90251,90296,90410,90411,90556,90617,90251,100241,100327,100402,100241,100327,100402,100152,100206,100287,100363,100186,100226,100310,100384,100186,100226,100310,100384,100164,100297,100371,100171,100219,100303,100377,100167,100214,100298,100372,100171,100219,100303,100377,100167,100214,100298,100372,100169,100216,100300,100374,100164,100297,100371,98910,98913,98683,98763,98681,98761,98911,98686,98766,98916,98681,98761,98911,98916,98686,98766,98910,98923,98923,98903,98708,98940,98708,98940,93003,93080,93003,93080,92967,93050,92988,93070,92988,93070,92975,93057,92981,93063,92981,93063,92976,93058,92976,93058,92978,93060,92975,93057,101395,101397,101401,101397,101401,101395,101408,101408,101387,101348,101348,90089,90228,90008,90162,90089,90228,90008,90162,90053,90192,90127,89992,90074,90213,90147,90147,89992,90074,90213,90134,89979,90060,90200,89979,90060,90200,90140,89985,90067,90206,90135,90140,89985,90067,90206,90135,89980,90062,90201,89980,90062,90201,90134,89982,90064,90203,89449,89446,89447,89447,89452,89452,89446,89459,89459,89436,89474,89497,89474,89497,93398,93468,93540,93398,93468,93540,93433,93508,93453,93528,93453,93528,93440,93515,93446,93521,93446,93521,93441,93516,93441,93516,93440,93515,93444,93518,90676,90829,90673,90826,90745,90674,90827,90674,90827,90679,90832,90679,90832,90745,90673,90826,90686,90839,90686,90839,90666,90816,90737,90746,90854,90701,90865,90746,90854,90701,90865,91239,91239,91183,91287,91222,91307,91222,91307,91192,91294,91200,91300,91200,91300,91177,91295,91295,91177,91192,91294,91182,91297,88905,88986,89064,88903,88984,88903,88984,88908,88989,88908,88989,88902,88902,89064,88996,89077,89243,88996,89077,89243,89007,89007,87932,87932,87908,87908,87915,87915,87910,87910,87912,99736,99796,99871,99726,99787,99866,99732,99732,99794,99869,99740,99800,99875,99732,99732,99794,99869,99740,99800,99875,99726,99787,99866,99765,99816,99884,99765,99816,99884,99712,99763,99850,99749,99779,99909,99749,99779,99909,99841,99860,99860,87998,87998,93104,93189,93265,93104,93189,93265,93129,93214,93185,93261,93335,93185,93261,93335,93134,93134,93179,93179,93167,93167,93129,93214,93152,93234,93152,93234,93139,93221,93145,93301,93145,93301,93140,93296,93140,93296,93139,93221,93142,93298,90378,90491,90530,90376,90488,90528,90376,90488,90528,90381,90493,90533,90381,90493,90533,90375,90485,90527,90375,90485,90527,90388,90507,90540,90317,90317,90388,90507,90540,90365,90477,90513,90281,90370,90522,90370,90522,90332,90332,90365,90477,90513,90281,90263,90339,90458,90263,90339,90458,100569,100641,100709,100569,100641,100709,100661,100729,100565,100565,100661,100729,100614,100681,100750,100614,100681,100750,100629,100697,100629,100697,100601,100668,100737,100607,100674,100743,100607,100674,100743,100602,100669,100738,100602,100669,100738,100604,100601,100668,100737,91132,91195,91193,91193,91198,91198,91132,91138,91138,91206,91125,91206,91155,91155,91149,91149,91125,91159,91159,88297,88930,88297,88930,99923,100017,99923,100017,99961,100015,100095,99926,99985,100068,99961,100015,100095,99943,99997,100079,99952,100007,100088,99952,100007,100088,99947,100001,100083,99947,100001,100083,99949,100003,100085,99943,99997,100079,100045,100104,100045,100104,99926,99985,100068,100041,100080,100041,100080,94750,94750,94777,94754,94754,94783,94787,94785,94785,94790,94790,94783,94797,94777,94797,94738,94738,98789,98870,98627,98789,98870,98627,98612,98693,98773,98855,98673,98753,98834,98612,98693,98773,98855,98680,98760,98842,98604,98848,98604,98848,98600,98843,98600,98843,98601,98845,98680,98760,98842,98727,98807,98727,98807,98961,98673,98753,98834,98961,98718,98799,98718,98799,101084,101249,101084,101249,101293,101056,101056,101293,101218,101295,101079,101244,101315,101218,101295,101254,101322,101255,101323,101255,101323,101260,101328,101328,101260,101328,101328,101254,101322,101267,101333,101267,101333,101244,101315,101079,101044,101282,101044,101282,89166,88950,89031,89191,88976,89223,89295,88950,89031,89191,88940,89020,89180,88940,89020,89180,89223,88976,99502,99502,99598,99598,99529,99634,99603,99510,99639,99706,99510,99639,99706,99603,99429,99102,99102,99429,99352,99124,99195,99324,99425,99324,99425,99417,99297,99297,99417,101132,101132,100937,101006,101162,100987,101113,101136,100987,101113,101136,192790,192790,192887,192955,192887,192955,192837,192908,192975,192884,192884,192486,192548,192486,192548,192439,192504,192444,192444,176242,176242,176275,176249,176249,54882,54882,54882,54882,54882,54882,54882,54882,54882,54882,54880,54880,54880,54880,54880,54880,54880,54880,54880,54880,54877,54877,54877,54877,54877,54879,54879,54879,54879,54879,54879,54879,54879,54879,54879,54877,54877,54877,54877,54877,73424,73459,73539,73424,73459,73539,73420,73432,73536,73400,73443,73517,73400,73443,73517,73402,73494,73402,73494,73492,73492,73463,73463,73397,73441,73397,73441,73415,73500,73572,73415,73500,73572,73422,73456,73538,73422,73456,73538,73412,73450,73524,73469,73550,73469,73550,73385,73491,73567,73385,73491,73567,73496,73496,73412,73450,73524,73374,73429,73505,73420,73432,73536,73476,73556,73476,73556,73546,73546,73380,73488,73564,73380,73488,73564,73408,73448,73521,73376,73426,73504,73376,73426,73504,73409,73449,73522,73389,73435,73409,73449,73522,73386,73530,73386,73530,73406,73447,73520,73406,73447,73520,73379,73534,73408,73448,73521,73379,73534,73434,73508,73434,73508,74870,74870,74858,74858,74861,74861,74866,74866,92331,92339,92439,92331,92339,92439,92394,92373,92383,92462,92394,92309,92321,92430,92503,92411,92482,92411,92482,92309,92321,92430,92503,92373,92383,92462,92349,92365,92454,92349,92365,92454,92404,92311,92322,92431,92504,92311,92322,92431,92504,92317,92327,92434,92317,92327,92434,92353,92368,92455,92353,92368,92455,92392,92471,92395,92395,92404,92392,92471,92303,92315,92427,92500,92371,92381,92460,92303,92315,92427,92500,92488,92488,92336,92352,92443,92336,92352,92443,92372,92382,92461,92372,92382,92461,92343,92359,92448,92342,92358,92447,92397,92474,92371,92381,92460,92397,92474,92370,92380,92459,92370,92380,92459,92342,92358,92447,92400,92477,92400,92477,176296,176296,176297,176297,176298,176298,176299,176299,176803,176803,176893,176893,176780,176776,176776,176771,176771,176752,176752,176903,176894,176894,176797,176797,176775,176775,176780,176772,176772,176903,176795,176795,176738,176891,176738,176891,176802,176784,176784,176802,176789,176789,176758,176758,176748,176748,176768,176768,176801,176801,176736,176889,176736,176889,176788,176800,176800,176788,176731,176886,176731,176886,176977,176977,176945,176957,176957,176945,176980,176980,176958,176958,176926,176926,176914,176914,176946,176946,176959,176959,177064,177064,176952,176952,176930,176930,176930,176930,176938,176933,176933,176954,176954,177067,177067,176908,176908,176929,176929,176938,177066,177066,176960,176960,192590,192767,192704,192590,192767,192704,192601,192781,192634,192601,192781,192634,192681,192568,192743,192738,192672,192738,192672,192613,192723,192652,192613,192723,192652,192602,192782,192635,192645,192602,192782,192635,192584,192761,192698,192584,192761,192698,192676,192676,192568,192743,192681,192673,192673,192673,192582,192759,192645,192696,192582,192759,192589,192766,192703,192571,192748,192571,192748,192685,192589,192766,192703,192576,192753,192690,192576,192753,192690,192609,192609,192685,192628,192735,192669,192628,192735,192669,192588,192765,192702,192588,192765,192702,192637,192597,192719,192777,192597,192719,192777,192637,192575,192752,192689,192587,192764,192701,192701,192587,192764,192575,192752,192689,192716,192774,192639,192716,192774,192639,100477,100480,100548,100477,100480,100548,100527,100447,100459,100539,100539,100459,100527,100447,100474,100483,100552,100474,100483,100552,100540,100460,100540,100460,100510,100431,100135,100510,100135,100431,100523,100501,100501,100528,100528,100448,100541,100461,100523,100443,100443,100541,100461,90772,90964,90994,90976,91073,90976,91073,90935,90772,90964,90994,90981,91078,90759,90946,90759,90946,90910,91052,91107,90935,91042,91042,90910,91052,91107,90937,91062,90912,90993,90912,90937,91062,90771,90963,90771,90963,90993,90755,91005,91030,91005,91030,90755,90758,90945,90980,91077,90980,91077,90992,90770,90961,90770,90961,90992,90758,90945,90861,90777,91002,91027,91002,91027,90777,90861,99487,99487,99466,99478,99478,99466,99491,99491,99479,99479,99445,99445,99358,99462,99434,99434,99467,99467,99480,99358,99462,99480,92005,91987,91987,92005,91992,92038,92268,92297,92038,92268,92297,92028,92258,92028,92258,92004,92004,92016,92276,92276,92016,91991,92003,91991,92003,92273,92013,92273,92013,98553,98553,98557,98557,98575,98575,89416,89384,89339,89416,89339,89381,89384,89366,89366,89387,89387,89408,89381,89408,89316,89407,89407,89316,89386,89308,89308,89386,89406,89406,92161,92161,92077,92233,92065,92221,92149,92149,92077,92233,92171,92243,92087,92171,92243,92087,92149,92149,92065,92221,92174,92246,92162,92162,92078,92234,92174,92246,92163,92079,92235,92145,92061,92217,92061,92217,92079,92235,92163,92150,92150,92150,92150,92066,92222,92132,91975,92047,92203,92132,91975,92047,92203,92078,92234,92145,92110,92110,92120,92120,91740,91740,91752,91752,91713,91713,91710,91710,92613,92698,92844,92920,92844,92920,92613,92698,92688,92760,92835,92910,92591,92676,92898,92688,92760,92835,92910,92773,92923,92591,92676,92898,92923,92773,92689,92761,92836,92911,92880,92730,92730,92880,92689,92761,92836,92911,92870,92947,92870,92947,92592,92677,92899,92690,92762,92837,92912,92587,92672,92744,92819,92894,92587,92672,92744,92819,92894,92690,92762,92837,92912,89774,89843,89918,89756,89825,89900,89756,89825,89900,89774,89843,89918,89761,89830,89905,89877,89954,89877,89954,89797,89946,89797,89946,89773,89842,89917,89814,89886,89814,89886,89773,89842,89917,89785,89854,89930,89760,89829,89904,89760,89829,89904,89785,89854,89930,89772,89841,89916,89772,89841,89916,89781,89851,89926,89781,89851,89926,91089,91089,91090,91090,91091,91091,99009,99076,99147,99265,99287,99200,99200,98991,99076,99147,99265,99287,99009,98996,98996,99075,99146,99264,99286,99046,99185,99233,98976,99185,99233,98976,99046,98991,99170,99170,99225,99332,99225,99332,99075,99146,99264,99286,99008,99008,99021,99087,99158,99208,99021,99087,99158,99208,98995,99074,99145,99263,99285,99007,99007,99074,99145,99263,99285,98995,99203,99019,99304,99019,99203,99304,93619,93627,93619,93627,93596,93683,93608,93695,93608,93695,93596,93683,93622,93632,93622,93632,93609,93696,93654,93654,93644,93644,93663,93663,93609,93696,93597,93684,93610,93697,93592,93679,93592,93679,93610,93697,89581,89610,89693,89977,89676,89676,89977,89562,89610,89693,89581,89595,89681,89567,89567,89609,89692,89965,89660,89741,89544,89544,89965,89660,89741,89562,89648,89648,89609,89692,89579,89579,89623,89704,89623,89704,89566,89566,89566,89594,89680,89594,89680,89607,89578,89578,89607,89566,89566,89566,89619,89701,89619,89701,93738,93750,93750,93738,93751,93719,93719,93751,93739,93752,93734,93734,93752,87681,87681,92848,92546,92617,92747,92823,92520,92848,92546,92617,92533,92604,92532,92603,92532,92603,92747,92823,92520,92542,92770,92770,92542,92534,92605,92516,92516,92534,92605,92748,92824,92521,92533,92604,92804,92575,92656,92804,92575,92656,92644,92795,92644,92795,92785,92860,92785,92860,89269,89269,89233,88277,89257,89232,89232,89257,88277,91798,91869,91945,91844,91919,91798,91869,91945,91857,91932,91866,91941,91866,91941,91844,91919,91856,91931,91856,91931,91845,91920,91858,91933,91770,91840,91915,91858,91933,91770,91840,91915,91957,91966,91957,91966,91828,91898,91828,91898,91857,91932,90613,90580,90580,90435,90435,90291,90593,90614,90593,90291,90614,90600,90300,90300,90612,90612,90301,90598,90241,90248,90598,90241,90248,90613,90295,90407,90555,90615,90245,90250,90597,90597,90301,90295,90407,90555,90615,90245,90250,100240,100326,100401,100168,100215,100299,100373,100240,100326,100401,100190,100228,100312,100386,100190,100228,100312,100386,100237,100323,100397,100237,100323,100397,100168,100215,100299,100373,100188,100227,100311,100385,100188,100227,100311,100385,100169,100216,100300,100374,100191,100229,100313,100387,100161,100211,100295,100369,100161,100211,100295,100369,100191,100229,100313,100387,100257,100338,100257,100338,100158,100267,100347,100158,100267,100347,100187,100277,100357,100187,100277,100357,98897,98663,98925,98663,98897,98651,98812,98887,98651,98812,98887,98957,98957,98926,98908,98678,98678,98908,98926,98913,98683,98763,98924,98924,98682,98762,98912,98935,98935,98925,98626,98707,98939,98682,98762,98912,98626,98707,98939,93089,92977,93059,93089,92990,93072,92999,93092,92999,93092,92977,93059,92989,93071,92989,93071,92978,93060,92991,93073,92973,93055,92973,93055,92991,93073,93028,93028,92957,93040,92990,93072,92957,93040,101378,101378,101369,101369,101359,101359,101411,101393,101393,101411,101398,101398,101409,101409,101396,101410,101410,101396,90136,89981,90063,90202,89981,90063,90202,90088,90227,90007,90161,90149,90149,89994,90076,90215,90007,90161,90088,90227,90136,89993,90075,90214,90148,90148,89993,90075,90214,90003,90158,90085,90224,90003,90158,90085,90224,90137,90137,89982,90064,90203,90150,89995,90077,90216,90132,90059,90198,90150,89995,90077,90216,90059,90198,90100,90100,90132,90110,90110,90120,90186,90186,90120,89994,90076,90215,89461,89426,89530,89426,89530,89349,89524,89349,89524,89504,89485,89485,89504,89444,89462,89444,89462,89449,89303,89488,89470,89303,89488,89470,89460,89460,89306,89496,89473,89461,89473,89306,89496,89448,89448,93442,93517,93397,93467,93539,93455,93530,93397,93467,93539,93454,93529,93442,93517,93454,93529,93393,93464,93393,93464,93444,93518,93456,93531,93438,93513,93438,93513,93456,93531,93479,93479,93489,93489,93427,93498,93576,93427,93498,93576,93455,93530,90688,90841,90656,90806,90728,90656,90806,90728,90712,90888,90743,90712,90888,90689,90842,90671,90824,90743,90671,90824,90689,90842,90676,90829,90850,90697,90697,90850,90687,90840,90687,90840,90853,90700,90864,90688,90841,90700,90864,90853,90675,90828,90675,90828,91179,91179,91296,91238,91224,91309,91238,91223,91308,91296,91223,91308,91235,91235,91297,91182,91225,91310,91292,91292,91225,91310,91174,91278,91174,91278,91224,91309,88998,89079,89245,88966,88966,88999,89080,89246,88999,89080,89246,88905,88986,89254,88926,89254,88926,88997,89078,89244,88997,89078,89244,88929,89013,88998,89079,89245,88929,89013,88904,88985,88904,88985,87911,87911,87954,87942,87942,87912,87965,87965,87906,87906,87830,87830,87954,99773,99819,99889,99734,99830,99910,99734,99830,99910,99716,99876,99716,99876,99722,99784,99863,99722,99784,99863,99775,99820,99891,99775,99820,99891,99736,99796,99871,99769,99817,99885,99769,99817,99885,99735,99795,99870,99728,99743,99887,99914,99728,99743,99887,99914,99773,99819,99889,99744,99770,99905,99920,99735,99795,99870,99744,99770,99905,99920,88168,88168,93244,93244,93141,93297,93153,93235,93153,93235,93166,93248,93141,93297,93166,93248,93154,93236,93142,93298,93155,93237,93155,93237,93137,93219,93293,93137,93219,93293,93108,93194,93108,93194,93184,93260,93334,93184,93260,93334,93119,93204,93353,93119,93204,93353,93154,93236,90390,90509,90542,90355,90470,90474,90275,90275,90355,90470,90474,90331,90331,90344,90344,90373,90482,90525,90391,90510,90543,90326,90373,90482,90525,90391,90510,90543,90326,90378,90491,90530,90390,90509,90542,90324,90324,90409,90377,90489,90529,90377,90489,90529,90409,90389,90505,90541,90318,90318,90389,90505,90541,90287,90400,90403,90550,90287,90400,90403,90550,88642,88642,100564,100564,100713,100713,100583,100655,100723,100583,100655,100723,100604,100671,100740,100671,100740,100617,100684,100753,100617,100684,100753,100599,100666,100735,100599,100666,100735,100624,100692,100624,100692,100615,100682,100751,100603,100670,100739,100615,100682,100751,100628,100696,100603,100670,100739,100628,100696,100616,100683,100752,100616,100683,100752,91209,91137,91194,91194,91137,91208,91208,91134,91261,91261,91134,91130,91189,91210,91130,91189,91210,91195,91115,91209,91115,91266,91154,91266,91154,88886,88886,88900,88900,99941,99990,100076,99941,99990,100076,99994,100023,100098,99949,100003,100085,99994,100023,100098,99975,100057,99991,100022,100097,99975,100057,100040,100077,100040,100077,99967,100111,99967,100111,99995,99995,99988,100018,100096,99948,100002,100084,99988,100018,100096,100014,99948,100002,100084,100014,99991,100022,100097,94799,94786,94798,94786,94798,94734,94734,94758,94758,94749,94749,94767,94799,94767,94800,94787,94800,94782,94782,98758,98840,98758,98840,98615,98696,98776,98858,98601,98845,98615,98696,98776,98858,98743,98824,98614,98695,98775,98857,98743,98824,98966,98966,98623,98704,98784,98867,98623,98704,98784,98867,98613,98694,98774,98856,98603,98844,98613,98694,98774,98856,98603,98844,98788,98869,98614,98695,98775,98857,98788,98869,101043,101281,101347,101269,101335,101269,101335,101043,101281,101347,101256,101324,101268,101334,101256,101324,101268,101334,101278,101343,101278,101343,101300,101062,101300,101062,101055,101055,101234,101309,101073,101073,101234,101309,101270,101336,101257,101325,101257,101325,101270,101336,101252,101320,101252,101320,89062,89228,88918,89062,89228,89067,88918,89047,89214,89288,89047,89214,89288,88917,89016,89161,89016,89161,88916,88916,89066,89066,89165,88917,89165,89166,89295,88915,88915,88982,88982,89070,89070,89065,89065,89067,99539,99536,99649,99537,99651,99542,99656,99537,99651,99542,99656,99649,99536,99666,99666,99529,99634,99583,99564,99618,99686,99564,99618,99686,99583,99563,99569,99605,99684,99582,99669,99669,99582,99563,99569,99605,99684,99538,99652,99667,99667,99538,99652,99560,99566,99595,99675,99578,99560,99566,99595,99675,99578,99523,99698,99619,99619,99523,99698,99597,99597,99647,99514,99671,99609,99514,99671,99609,99670,99539,99653,99653,99670,99534,99647,99534,99247,99058,99129,99058,99129,99247,99376,99363,99363,99062,99134,99252,99274,99376,99323,99424,99099,99323,99424,99099,99342,99114,99342,99114,99084,99155,99393,99413,99393,99413,99084,99155,99362,99063,99132,99250,99273,99374,99374,99362,99063,99132,99250,99273,99389,99301,99396,99410,99375,99375,99301,99396,99410,99389,99306,99397,99402,99383,99159,99383,99159,99306,99397,99402,99352,99124,99195,99373,99373,99360,99060,99131,99202,99365,99066,99137,99255,99277,99361,99061,99251,99272,99272,99272,99365,99066,99137,99255,99277,99361,99061,99251,99272,99272,99272,99360,99060,99131,99202,99062,99134,99252,99274,100944,101013,101089,101169,100945,101014,101090,101170,100950,101018,101095,101095,101175,100945,101014,101090,101170,100950,101018,101095,101095,101175,100944,101013,101089,101169,100957,101026,101102,101182,100957,101026,101102,101182,101162,100937,101006,101120,101197,100975,100975,101120,101197,101119,101196,100974,100959,101028,101104,101184,100959,101028,101104,101184,101119,101196,100974,100946,101015,101091,101171,100958,101027,101103,101183,100946,101015,101091,101171,100958,101027,101103,101183,100971,101040,101116,101193,100971,101040,101116,101193,101152,100999,100999,101152,101131,101131,100969,101141,101141,100969,100960,101029,101105,101185,100947,101016,101092,101172,100947,101016,101092,101172,100960,101029,101105,101185,100942,101011,101087,101167,100942,101011,101087,101167,192801,192801,192802,192802,192872,192943,192872,192943,192857,192928,192995,192857,192928,192995,192837,192908,192975,192916,192983,192921,192989,192916,192983,192921,192989,192844,192915,192982,192844,192915,192982,192831,192902,192969,192831,192902,192969,192883,192883,192892,192959,192892,192959,192860,192931,192998,192918,192985,192918,192985,192860,192931,192998,192842,192913,192980,192842,192913,192980,192871,192942,192859,192930,192997,192859,192930,192997,192871,192942,192917,192984,192858,192929,192996,192858,192929,192996,192917,192984,192867,192939,192867,192939,192481,192543,192464,192527,192464,192527,192481,192543,192451,192514,192477,192540,192477,192540,192451,192514,192463,192526,192463,192526,192446,192510,192446,192510,192465,192528,192452,192515,192452,192515,192465,192528,192422,192490,192422,192490,192094,192433,192498,192560,192094,192433,192498,192560,192448,192512,192448,192512,192455,192518,192450,192513,192455,192518,192450,192513,192439,192504,192462,192525,192462,192525,192472,192535,192472,192535,176232,176232,176275,176283,176288,176283,176288,176282,176282,176265,176265,176254,176254,176285,176285,176280,176280,176284,176228,176228,176284,176231,176231,54881,54881,54881,54881,54881,54881,54881,54881,54881,54881,54888,54888,54888,54888,54888,54888,54888,54888,54888,54888,54878,54878,54878,54878,54878,54878,54878,54878,54878,54878,54883,54883,54883,54883,54883,54883,54883,54883,54883,54883,54886,54886,54886,54886,54886,54886,54886,54886,54886,54886,54887,54887,54887,54887,54887,54887,54887,54887,54887,54887,73383,73529,73396,73440,73514,73383,73529,73398,73495,73398,73495,73421,73454,73537,73445,73543,73445,73543,73396,73440,73514,73465,73465,73413,73451,73526,73483,73560,73384,73490,73566,73384,73490,73566,73483,73560,73431,73542,73431,73542,73369,73369,73480,73480,73413,73451,73526,73479,73393,73437,73511,73393,73437,73511,73421,73454,73537,73403,73403,73474,73554,73467,73544,73461,73399,73442,73461,73467,73544,73474,73554,73375,73486,73562,73375,73486,73562,73374,73429,73505,73390,73436,73510,73390,73436,73510,73381,73489,73565,73484,73561,73381,73489,73565,73484,73561,73401,73444,73518,73464,73464,73372,73533,73464,73464,73401,73444,73518,73372,73533,73399,73442,74855,74859,74855,74859,74856,74856,74850,74851,74851,74867,74867,74854,74860,74860,74854,92307,92320,92429,92502,92307,92320,92429,92502,92308,92422,92495,92308,92422,92495,92337,92355,92444,92337,92355,92444,92419,92492,92374,92384,92463,92398,92475,92398,92475,92391,92470,92419,92492,92391,92470,92374,92384,92463,92407,92407,92348,92364,92453,92402,92479,92402,92479,92393,92472,92316,92326,92433,92399,92476,92316,92326,92433,92348,92364,92453,92399,92476,92418,92491,92345,92361,92449,92345,92361,92449,92312,92425,92498,92312,92425,92498,92414,92486,92344,92360,92451,92344,92360,92451,92409,92480,92408,92350,92366,92457,92408,92409,92480,92414,92486,92305,92318,92428,92501,92305,92318,92428,92501,92310,92423,92496,92310,92423,92496,92354,92367,92456,92354,92367,92456,92350,92366,92457,92396,92473,92405,92396,92473,92405,92319,92329,92435,92319,92329,92435,92393,92472,176300,176300,176804,176781,176781,176744,176897,176744,176897,176785,176785,176764,176764,176770,176770,176804,176901,176901,176745,176898,176745,176898,176794,176732,176885,176794,176774,176732,176885,176774,176892,176791,176791,176892,176769,176904,176905,176735,176888,176904,176905,176735,176888,176796,176798,176798,176765,176765,176769,176756,176746,176906,176902,176796,176902,176746,176906,176790,176790,176756,176766,176766,176924,176924,176912,176947,176947,176953,176912,176927,176922,176922,176955,176955,176953,176979,176979,176927,176934,176934,177065,176948,176917,176948,177065,176932,176976,176932,176951,176976,176951,177071,177071,176961,176928,176928,176921,176921,176942,176942,177070,176918,177070,176918,176961,192705,192591,192768,192661,192605,192712,192785,192631,192661,192605,192712,192785,192631,192572,192749,192686,192662,192572,192749,192686,192623,192731,192662,192623,192731,192737,192671,192737,192671,192591,192768,192705,192641,192606,192720,192786,192644,192644,192606,192720,192786,192641,192581,192758,192695,192715,192773,192638,192581,192758,192695,192638,192675,192715,192773,192675,192600,192714,192780,192633,192578,192755,192692,192660,192621,192578,192755,192692,192600,192714,192780,192633,192677,192677,192736,192670,192596,192718,192776,192636,192646,192647,192648,192646,192647,192648,192596,192718,192776,192636,192583,192760,192697,192585,192762,192699,192585,192762,192624,192732,192663,192699,192624,192732,192663,192736,192670,192726,192656,192656,192607,192721,192650,192697,192583,192760,192649,192607,192721,192650,192649,192577,192754,192691,192577,192754,192691,192726,192626,192733,192667,192626,192733,192667,192696,192673,192673,192673,192599,192713,192779,192599,192713,192779,192632,192632,100471,100485,100471,100485,100115,100403,100554,100514,100534,100454,100534,100127,100415,100454,100139,100139,100514,100519,100145,100145,100536,100456,100536,100456,100115,100403,100554,100488,100406,100557,100118,100127,100415,100488,100118,100406,100557,100495,100143,100419,100138,100495,100143,100419,100434,100513,100513,100434,100138,100462,100519,100439,100439,100487,100405,100556,100117,100487,100117,100405,100556,100542,100462,100542,100508,100133,100429,100508,100133,100429,100529,100449,100529,100449,100123,100414,100493,100140,100417,100414,100123,100535,100455,100493,100417,100140,100499,100499,100511,100136,100432,100136,100432,100506,100132,100428,100537,100506,100132,100428,100457,100537,100457,100535,100455,100473,100482,100551,100416,100128,100129,100416,100128,100129,100473,100482,100551,100511,100147,100147,100472,100486,100116,100404,100555,100530,100450,100530,100450,100472,100486,100116,100404,100555,100144,100549,100144,100533,100453,100476,100479,100476,100479,100549,100533,100453,100492,100122,100410,100561,100413,100126,100126,100413,100492,100122,100410,100561,100543,100463,100512,100433,100137,100512,100433,100137,100131,100427,100505,100131,100427,100524,100444,100505,100524,100444,100470,100491,100121,100409,100560,100470,100491,100121,100409,100560,100440,100440,100543,100475,100475,100463,90996,90756,90756,90774,90968,90920,91106,91013,91038,90749,91013,91038,90749,90920,91106,90936,90977,90977,90936,90925,91057,91110,90916,90940,91064,90916,90940,91064,90925,91057,91110,90774,90968,90996,91017,91017,91014,91039,91014,91039,90986,91083,90764,90951,90860,90776,91001,91026,90860,90764,90951,90986,91083,90952,90776,91001,91026,90952,91008,91033,90761,90948,90983,91080,90983,91080,90761,90948,90919,91055,91105,91008,91033,90958,90958,90729,90914,90754,91004,91029,91020,91021,91022,91020,91021,91022,90990,91087,90754,91004,91029,90766,90954,90988,91085,90768,90957,90768,90957,90990,91087,90928,91058,91111,90928,91058,91111,90939,91063,90939,91063,90729,90914,91050,91101,91023,91040,90766,90954,90988,91085,91018,91023,91040,91018,90760,90947,90982,91079,90760,90947,90982,91079,91050,91101,90932,91060,91113,90932,91060,91113,90773,90965,90773,90965,90995,91009,91034,91009,91034,90967,91070,90967,91070,90927,90995,90731,90917,90941,90731,90917,91025,91046,90941,91025,91046,91010,91035,91010,91035,91007,91032,90767,90955,90767,90955,90989,91086,90989,91086,90956,90956,90927,90942,90942,90942,90942,90765,90953,90987,91084,91019,91019,90987,91084,90765,90953,91007,91032,99493,99473,99346,99449,99473,99346,99449,99457,99349,99452,99349,99452,99475,99475,99493,99496,99496,99345,99448,99345,99448,99350,99453,99350,99453,99457,99495,99495,99481,99481,99443,99443,99468,99468,99474,99432,99432,99446,99441,99441,99476,99476,99474,99490,99490,99446,99494,99335,99437,99469,99469,99494,99348,99451,99488,99348,99451,99472,99488,99472,99482,99447,99447,99440,99463,99440,99463,99482,92007,92304,91984,91984,92304,92024,92284,92024,92284,91988,91988,92043,92291,92043,92291,92007,91997,92025,92285,92025,92285,92272,92012,92272,91997,92506,92012,92506,92279,92019,91994,91994,92041,92271,92302,92279,92019,92508,92508,92015,92275,92015,92275,91999,92001,92001,92044,92295,92044,92295,92036,92266,92294,92026,92256,92286,91999,92026,92256,92286,91993,91993,92298,92036,92266,92294,92298,92006,92280,92020,92020,92280,91983,91983,92006,92032,92262,92289,92032,92262,92289,92021,92281,92021,92281,92018,92278,92000,92000,92507,92507,91998,91998,92278,92018,98559,98559,98562,98562,98561,98561,98583,98583,98581,98581,98556,98556,98560,98578,98560,98552,98552,98580,98580,89361,89361,89382,89382,89368,89368,89351,89326,89351,89326,89358,89358,89410,89335,89335,89307,89392,89307,89319,89323,89352,89319,89323,89367,89315,89336,89336,89315,89395,89362,89397,89397,89362,89367,89364,89347,89404,89364,89388,89388,89353,89337,89331,89395,89331,89353,89337,89347,89404,89313,89320,89409,89409,89313,89320,89378,89400,89343,89400,89343,89369,89369,89321,89314,89332,89314,89321,89318,89396,89396,89393,89393,89332,89378,89370,89370,89312,89318,89312,92093,92176,92248,92093,92051,92051,92136,92141,92105,92072,92227,92156,92156,92072,92227,92156,92156,92136,92158,92158,92074,92230,92074,92230,92158,92158,92176,92248,92179,92251,92096,92105,92096,92179,92251,92135,92135,91978,92050,92206,92080,92236,92114,92191,91978,92050,92206,92114,92191,92141,92056,92211,92056,92211,92095,92178,92250,92164,92080,92236,92164,92178,92250,92095,92118,92194,92108,92189,92104,92186,92157,92073,92229,92104,92186,92108,92189,92151,92151,92067,92223,92151,92151,92067,92223,92130,92201,92118,92194,92130,92201,92133,91976,92048,92204,91976,92048,92204,92128,92200,92159,92075,92231,92159,92075,92231,92128,92200,92157,92073,92229,92173,92245,92107,92188,92107,92188,92173,92245,92133,92094,92177,92249,91716,91760,91760,91712,91728,91729,91730,91731,91813,91728,91729,91730,91731,91813,91712,91748,91748,91738,91819,91750,91750,91732,91814,91726,91811,91726,91811,91732,91814,91738,91819,91717,91717,91734,91816,91734,91816,91718,91718,91715,91727,91812,91727,91812,91759,91759,91715,92704,92775,92850,92925,92811,92886,92811,92886,92735,92735,92808,92808,92735,92735,92808,92808,92598,92683,92905,92905,92905,92598,92683,92905,92905,92905,92704,92775,92850,92925,92907,92600,92685,92907,92600,92685,92707,92778,92853,92928,92707,92778,92853,92928,92719,92864,92941,92734,92807,92883,92864,92941,92719,92691,92763,92838,92913,92734,92807,92883,92706,92777,92852,92927,92583,92668,92816,92891,92816,92891,92583,92668,92706,92777,92852,92927,92691,92763,92838,92913,92868,92945,92939,92715,92936,92599,92684,92906,92715,92936,92939,92878,92868,92945,92878,92593,92678,92900,92593,92678,92900,92877,92953,92805,92881,92805,92881,92877,92953,92601,92686,92908,92601,92686,92908,92922,92772,92599,92684,92906,92716,92716,92772,92922,92812,92887,92812,92887,92705,92776,92851,92926,89788,89857,89933,89784,89853,89929,89770,89839,89914,89769,89837,89912,89784,89853,89929,89770,89839,89914,89810,89882,89961,89815,89887,89815,89887,89810,89882,89961,89762,89831,89906,89762,89831,89906,89803,89875,89952,89813,89884,89813,89884,89795,89869,89944,89867,89769,89837,89912,89867,89795,89869,89944,89803,89875,89952,89775,89844,89919,89789,89858,89934,89753,89822,89894,89789,89858,89934,89753,89822,89894,89817,89889,89775,89844,89919,89799,89871,89948,89799,89871,89948,89817,89889,89790,89859,89935,89790,89859,89935,89768,89838,89913,89768,89838,89913,89787,89856,89932,89767,89836,89911,89767,89836,89911,89787,89856,89932,91065,91092,91065,91092,99077,99148,99266,99288,99010,99010,99025,99162,99213,99025,99162,99213,99055,99055,99241,98988,98979,99049,99117,99188,98979,99077,99148,99266,99288,99049,99117,99188,99033,99220,99033,99220,99002,99319,98980,99002,99050,99118,99189,99050,99118,99189,98980,99192,98988,99241,99192,98983,98983,99023,99160,99210,99004,99004,99026,99163,99212,99026,99163,99212,99319,99023,99160,99210,99223,99036,99031,99168,99318,99003,99318,99031,99168,98974,99044,99112,99036,99223,99044,99112,98974,98997,98997,99042,99230,98973,99047,99186,99234,99047,99186,99234,98977,99042,99230,98973,99005,99005,99020,99086,99157,99207,99003,99320,99020,99086,99157,99207,99320,99024,99161,99211,98977,98984,99193,99193,98984,93635,93412,93621,93631,93412,93604,93690,93621,93631,93606,93693,93606,93693,93660,93577,93664,93577,93664,93660,93598,93685,93598,93685,93661,93652,93661,93642,93413,93410,93604,93690,93410,93642,93413,93652,93624,93634,93411,93626,93637,93626,93637,93605,93692,93605,93692,93624,93634,93603,93689,93411,93603,93689,93648,93706,93648,93706,93611,93698,93588,93728,93588,93728,93625,93636,93625,93636,93611,93698,89611,89694,89586,89586,89627,89708,89627,89708,89973,89973,89580,89672,89580,89672,89553,89611,89694,89668,89668,89547,89547,89968,89663,89744,89968,89663,89744,89642,89724,89642,89724,89602,89687,89637,89718,89637,89718,89573,89573,89602,89687,89552,89667,89748,89553,89552,89667,89748,89664,89664,89745,89745,89664,89664,89745,89745,89625,89706,89575,89575,89604,89689,89604,89689,89628,89709,89628,89709,89625,89706,89646,89728,89640,89722,89636,89717,89603,89688,89574,89636,89717,89640,89722,89540,89963,89658,89739,89963,89658,89739,89646,89728,89540,89596,89682,89568,89568,89596,89682,89656,89737,89966,89661,89742,89966,89661,89742,89545,89656,89737,89576,89605,89690,89576,89622,89703,89574,89603,89688,89638,89639,89719,89720,89721,89605,89690,89622,89703,89638,89639,89719,89720,89721,89626,89707,89554,89749,89554,89749,89545,93746,93748,93748,93715,93720,93720,93715,93740,93740,93717,93709,93717,93746,93709,93747,93747,93667,93723,93667,93723,93670,93670,93745,93745,93666,93722,93666,93722,93671,93671,93753,93675,93675,93753,87835,87835,87728,87728,87705,87857,87857,87705,87742,87704,87704,87742,87798,87798,87660,87660,87707,92549,92620,92545,92616,92847,92560,92632,92633,92634,92635,92560,92632,92633,92634,92635,92545,92616,92847,92756,92831,92528,92572,92652,92728,92801,92758,92833,92530,92758,92833,92530,92572,92652,92728,92801,92657,92731,92657,92731,92566,92642,92722,92793,92573,92654,92729,92802,92573,92654,92729,92802,92753,92825,92522,92753,92825,92522,92561,92636,92717,92783,92858,92556,92630,92756,92831,92528,92556,92630,92561,92636,92717,92783,92858,92566,92642,92722,92793,92548,92619,92551,92622,92551,92622,92631,92548,92619,92757,92832,92832,92529,92757,92832,92832,92529,92755,92830,92527,92631,92755,92830,92527,92663,92663,92660,92660,92660,92660,92563,92638,92789,92578,92659,92789,92563,92638,92535,92606,92664,92664,92578,92659,92550,92621,92740,92512,92740,92512,92550,92621,92535,92606,89239,89239,89241,89241,89197,89267,89240,89267,89234,89234,89197,89242,89240,88251,89256,89242,89256,88251,91797,91868,91944,91883,91854,91854,91854,91929,91883,91797,91868,91944,91853,91853,91853,91927,91854,91854,91854,91929,91825,91895,91972,91753,91829,91899,91753,91829,91899,91825,91895,91972,91889,91964,91826,91896,91973,91826,91896,91973,91846,91921,91846,91921,91884,91955,91882,91853,91853,91853,91927,91882,91884,91955,91889,91964,91801,91872,91948,91852,91928,91852,91928,91800,91871,91947,91803,91874,91950,91803,91874,91950,91851,91926,91851,91926,91756,91756,91756,91756,91903,91903,91859,91934,91802,91873,91949,91764,91836,91909,91764,91836,91909,91802,91873,91949,91755,91831,91901,91905,91905,91859,91934,91886,91960,91755,91831,91901,91886,91960,91800,91871,91947,90303,90412,90440,90557,90619,90429,90567,90639,90567,90639,90583,90429,90616,90583,90310,90414,90442,90559,90621,90589,90589,90310,90414,90442,90559,90621,90616,90307,90606,90606,90424,90635,90307,90424,90635,90312,90415,90445,90560,90624,90312,90415,90445,90560,90624,90303,90412,90440,90557,90619,90309,90608,90608,90309,90306,90413,90441,90558,90620,90342,90433,90570,90643,90265,90565,90637,90427,90423,90634,90607,90308,90423,90634,90565,90637,90427,90601,90299,90601,90299,90578,90578,90265,90342,90433,90570,90643,90351,90576,90581,90581,90351,90576,90609,90311,90311,90607,90308,90294,90406,90554,90610,90244,90249,90425,90426,90636,90609,90425,90426,90636,90554,90610,90294,90406,90244,90249,100239,100325,100400,100254,100254,100239,100325,100400,100178,100223,100307,100381,100181,100225,100309,100383,100181,100225,100309,100383,100179,100274,100354,100189,100278,100358,100189,100278,100358,100179,100274,100354,100151,100265,100346,100184,100276,100395,100184,100276,100395,100183,100217,100301,100375,100183,100217,100301,100375,100255,100336,100253,100178,100223,100307,100381,100253,100255,100336,100151,100265,100346,100243,100329,100180,100224,100308,100382,100180,100224,100308,100382,100242,100328,100320,100331,100250,100320,100331,100250,100177,100222,100306,100380,100177,100222,100306,100380,100202,100284,100202,100284,100196,100196,100281,100281,100196,100196,100281,100281,100194,100230,100314,100388,100244,100330,100154,100208,100289,100365,100154,100208,100289,100365,100244,100330,100193,100280,100360,100194,100230,100314,100388,100204,100285,100204,100285,100261,100342,100193,100280,100360,100261,100342,100242,100328,98941,98941,98645,98726,98881,98900,98666,98881,98645,98726,98900,98666,98943,98905,98905,98943,98927,98927,98667,98667,98667,98667,98670,98750,98670,98750,98689,98769,98919,98689,98769,98919,98953,98640,98944,98640,98953,98944,98691,98771,98921,98921,98691,98771,98942,98898,98671,98751,98671,98751,98885,98649,98730,98879,98643,98955,98952,98639,98690,98770,98920,98952,98639,98955,98879,98643,98684,98764,98914,98684,98764,98914,98661,98741,98895,98895,98661,98741,98649,98730,98885,98893,98659,98664,98744,98898,98664,98744,98893,98659,98692,98772,98922,98692,98772,98922,98690,98770,98920,98625,98706,98938,98954,98641,98642,98954,98641,98642,98938,98625,98706,93088,93017,93017,93018,93019,93100,93017,93017,93018,93019,93100,93088,92985,93067,92987,93069,92987,93069,93036,92958,93041,92958,93041,93036,93026,92955,93038,92955,93038,92979,93061,92979,93061,93020,93015,93098,92985,93067,93015,93098,93020,93026,92965,93048,92965,93048,93005,93085,92986,93068,92986,93068,93004,93084,93007,93087,93016,93099,93007,93087,93016,93099,92984,93066,92984,93066,92964,93047,92964,93047,92961,93044,93044,92961,93044,93044,92992,93074,93006,93086,92969,93052,92969,93052,93006,93086,92960,93043,92992,93074,93022,92960,93043,93022,93004,93084,101349,101349,101363,101363,101385,101385,101381,101381,101351,101389,101351,101412,101412,101384,101389,101384,101404,101404,101352,101352,101406,101406,101350,101379,101367,101357,101405,101357,101399,101399,101376,101376,101367,101375,101379,101375,101407,101407,101405,90144,89989,90071,90210,90006,90160,90087,90226,90022,89991,90073,90212,90022,90087,90226,90006,90160,90146,90146,89991,90073,90212,90117,90182,90121,90187,90187,90182,90117,90108,90029,90176,90118,90118,90184,90184,90138,89983,90065,90204,90138,89983,90065,90204,90098,90023,90171,90020,90144,89989,90071,90210,90020,90098,90023,90171,90108,90029,90176,90121,90091,90230,90010,90164,90145,89990,90072,90211,89990,90072,90211,90145,90009,90163,90093,90232,90012,90166,90093,90232,90012,90166,89988,90069,90209,90021,90143,90021,90143,89988,90069,90209,90050,90129,90050,90124,90124,90124,90124,90151,90151,89996,90078,90217,90092,90231,90011,90165,90129,90055,90194,90092,90231,90011,90165,90055,90194,90123,90123,90189,90051,90051,89996,90078,90217,90104,90189,90104,90025,90173,90025,90173,90090,90229,90090,90229,90009,90163,89475,89498,89498,89492,89492,89512,89429,89512,89463,89434,89434,89429,89477,89500,89438,89438,89477,89500,89463,89430,89430,89433,89433,89455,89455,89478,89505,89478,89505,89475,89457,89457,89457,89457,89476,89499,89502,89520,89483,89510,89456,89483,89510,89450,89450,89424,89525,89424,89525,89502,89520,89537,89423,89522,89427,89427,89423,89522,89537,89458,89472,89305,89495,89458,89305,89495,89472,89456,93450,93525,93396,93466,93538,93554,93555,93556,93396,93466,93538,93554,93555,93556,93452,93527,93452,93527,93424,93495,93572,93428,93499,93428,93499,93424,93495,93572,93418,93487,93563,93425,93496,93574,93425,93496,93574,93443,93519,93443,93519,93477,93557,93552,93450,93525,93552,93477,93557,93418,93487,93563,93400,93470,93542,93506,93506,93451,93526,93399,93469,93541,93451,93526,93402,93472,93544,93553,93402,93472,93544,93449,93524,93553,93449,93524,93505,93583,93505,93583,93502,93580,93580,93502,93580,93580,93457,93532,93401,93471,93543,93435,93510,93435,93510,93401,93471,93543,93501,93579,93584,93584,93457,93532,93415,93483,93559,93501,93579,93415,93483,93559,93399,93469,93541,90702,90868,90750,90855,90702,90868,90715,90891,90793,90896,90793,90896,90659,90808,90715,90891,90690,90843,90813,90813,90659,90808,90704,90870,90752,90858,90668,90818,90668,90818,90739,90704,90870,90752,90858,90690,90843,90660,90660,90810,90660,90660,90810,90734,90663,90812,90739,90663,90812,90734,90682,90835,90787,90881,90787,90881,90682,90835,90753,90859,90705,90872,90753,90859,90705,90872,90750,90855,90684,90837,90684,90837,90735,90664,90735,90664,90751,90857,90703,90869,90796,90906,90718,90895,90791,90887,90710,90885,90786,90878,90683,90836,90786,90878,90791,90887,90710,90885,90677,90830,90677,90830,90726,90654,90804,90654,90804,90726,90718,90895,90796,90906,90652,90802,90723,90905,90657,90807,90657,90807,90652,90802,90723,90905,90685,90838,90788,90788,90789,90790,90882,90883,90699,90863,90852,90788,90788,90789,90790,90882,90883,90685,90838,90852,90699,90863,90683,90836,91219,91304,91237,91253,91254,91237,91253,91254,91221,91306,91221,91306,91274,91175,91279,91175,91279,91274,91263,91172,91172,91298,91187,91298,91187,91251,91219,91304,91251,91263,91241,91285,91285,91220,91305,91220,91305,91240,91243,91243,91218,91303,91252,91252,91218,91303,91284,91284,91228,91311,91242,91185,91289,91185,91289,91242,91281,91228,91311,91257,91281,91257,91240,89259,89010,89273,89030,89030,89273,89000,89081,89247,89055,89055,89261,89059,88896,88896,89059,89261,89000,89081,89247,88973,89054,88973,89054,88911,88992,88911,88992,89262,89262,89259,89010,88913,88994,88913,88994,88974,88974,89260,89011,89276,89034,88947,89028,88912,88993,88947,89028,88906,88987,88906,88987,88884,88964,89212,89212,88884,88964,89276,89034,89043,88967,88967,89043,88914,88995,88928,89012,88914,88995,88928,89012,88912,88993,87919,87921,87921,87831,87831,87823,87823,87913,87913,87923,87919,87923,87920,87920,87918,87918,87978,87888,87888,87978,87833,87833,87977,87977,99790,99855,99748,99838,99915,99790,99855,99748,99838,99915,99781,99823,99894,99802,99715,99767,99853,99715,99767,99853,99781,99823,99894,99802,99750,99807,99878,99750,99807,99878,99778,99845,99917,99917,99917,99917,99752,99809,99880,99788,99752,99809,99880,99813,99778,99845,99813,99788,99783,99852,99710,99804,99867,99751,99808,99879,99777,99844,99783,99852,99777,99844,99737,99798,99872,99737,99798,99872,99729,99826,99907,99710,99804,99867,99729,99826,99907,99724,99822,99904,99739,99833,99911,99739,99833,99911,99753,99810,99881,99753,99810,99881,99724,99822,99904,99780,99846,99847,99848,99849,99733,99759,99897,99918,99780,99846,99847,99848,99849,99751,99808,99879,99733,99759,99897,99918,99791,88146,88146,88004,88004,93106,93192,93268,93101,93182,93258,93332,93181,93101,93182,93258,93332,93181,93149,93305,93106,93192,93268,93117,93202,93276,93117,93202,93276,93143,93299,93143,93299,93116,93201,93350,93120,93205,93279,93120,93205,93279,93116,93201,93350,93151,93307,93151,93307,93165,93247,93149,93305,93178,93165,93247,93178,93169,93212,93286,93212,93286,93168,93171,93177,93171,93150,93306,93168,93150,93306,93123,93208,93282,93282,93282,93357,93123,93208,93282,93282,93282,93357,93126,93211,93285,93126,93211,93285,93177,93148,93304,93148,93304,93170,93156,93238,93131,93216,93131,93216,93170,93156,93238,93127,93127,93122,93207,93281,93356,93103,93188,93264,93122,93207,93281,93356,93103,93188,93264,90239,90262,90336,90457,90336,90358,90473,90490,90457,90239,90262,90358,90473,90490,90278,90278,90363,90506,90363,90506,90392,90511,90544,90254,90367,90479,90515,90367,90479,90515,90283,90392,90511,90544,90328,90328,90254,90384,90498,90536,90384,90498,90536,90362,90504,90283,90362,90504,90359,90494,90494,90359,90494,90494,90386,90501,90538,90386,90501,90538,90255,90255,90252,90252,90276,90253,90387,90502,90539,90408,90385,90500,90537,90408,90387,90502,90539,90447,90466,90271,90356,90471,90486,90356,90471,90486,90276,90447,90466,90271,90379,90492,90531,90379,90492,90531,90353,90449,90468,90273,90353,90449,90468,90273,90460,90385,90500,90537,90327,90455,90237,90260,90327,90455,90237,90260,90460,88601,88601,100562,100638,100706,100611,100678,100747,100562,100638,100706,100572,100644,100711,100572,100644,100711,100581,100653,100721,100581,100653,100721,100605,100672,100741,100605,100672,100741,100579,100651,100719,100584,100656,100724,100584,100656,100724,100579,100651,100719,100613,100680,100749,100613,100680,100749,100627,100695,100611,100678,100747,100627,100695,100631,100699,100591,100591,100630,100698,100633,100701,100633,100701,100612,100679,100748,100630,100698,100612,100679,100748,100587,100587,100590,100590,100610,100677,100746,100610,100677,100746,100632,100700,100618,100685,100754,100663,100731,100663,100731,100632,100700,100618,100685,100754,100586,100658,100726,100586,100658,100726,100568,100640,100708,100568,100640,100708,91158,91158,91118,91178,91118,91178,91211,91141,91127,91127,91211,91141,91202,91202,91122,91122,91119,91119,91119,91119,91139,91204,91204,91142,91142,91139,91123,91123,91140,91136,91227,91205,91227,91203,91136,91205,91170,91116,91116,91170,91196,91196,91276,91276,91162,91162,91152,91203,91151,91152,91151,88887,88887,88344,88932,88321,88931,88346,88934,88346,88934,88321,88931,88891,88891,88891,88891,88345,88933,88345,88933,88889,88889,88949,88949,99962,100044,100101,99977,100061,99962,100044,100101,99977,100061,99999,100026,100099,99929,100027,99932,99987,100070,99932,99987,100070,99929,100027,99999,100026,100099,99979,100062,99979,100062,99922,99982,100065,99922,99982,100065,99955,100010,100091,99955,100010,100091,99927,100024,99958,100012,100093,99958,100012,100093,99930,100029,99930,100029,99927,100024,99928,100025,99924,99983,100066,99924,99983,100066,99976,100058,99976,100058,99972,100053,99972,100053,99959,100013,100094,99959,100013,100094,100006,99956,100011,100092,100006,99957,100038,100072,99956,100011,100092,99957,100038,100072,99965,100047,100109,99965,100047,100109,99973,100055,99973,100055,99950,100004,100086,99950,100004,100086,94788,94788,94765,94765,94756,94756,94747,94793,94747,94793,94796,94796,94763,94763,94768,94768,94775,94775,94740,94739,94742,94742,94795,94795,94739,94794,94794,94774,94774,94771,94771,94801,94741,94779,94779,94741,94801,94770,94753,94770,94753,98569,98806,98960,98746,98827,98569,98806,98960,98746,98827,98616,98697,98777,98859,98832,98832,98630,98711,98792,98873,98675,98755,98836,98675,98755,98836,98630,98711,98792,98873,98616,98697,98777,98859,98747,98747,98747,98828,98828,98747,98747,98747,98828,98828,98831,98831,98608,98851,98721,98802,98608,98851,98628,98709,98790,98871,98610,98853,98610,98853,98631,98712,98793,98874,98721,98802,98631,98712,98793,98874,98628,98709,98790,98871,98629,98710,98791,98872,98825,98825,98739,98820,98739,98820,98611,98854,98611,98854,98609,98852,98787,98868,98787,98868,98722,98723,98803,98722,98723,98803,98567,98724,98804,98719,98801,98609,98852,98719,98801,98567,98724,98804,98810,98964,98810,98964,98822,98822,98602,98846,98602,98846,101258,101326,101258,101326,101071,101232,101307,101232,101307,101071,101221,101298,101060,101221,101298,101060,101053,101215,101291,101264,101331,101331,101053,101215,101291,101042,101280,101346,101042,101280,101346,101264,101331,101331,101266,182454,101266,182454,101230,101306,101069,101230,101306,101069,101074,101235,101310,101046,101284,101235,101310,101074,101045,101283,101048,101286,101048,101286,101265,101332,101265,101332,101045,101283,101263,182453,101238,101238,101263,182453,101081,101246,101317,101241,101241,101238,101238,101271,101337,101271,101337,101047,101285,101081,101246,101317,101285,101047,101242,101242,101076,101237,101312,101076,101237,101312,101217,101294,101058,101058,101217,101294,89190,89190,88969,89050,89217,89291,88969,89050,89217,89291,89221,89221,88919,89169,89225,89297,88977,89225,89297,88977,89169,88919,88970,88970,89051,89051,89292,88970,88970,89051,89051,89292,89220,89220,89073,88942,89023,89183,88942,89023,89183,89073,89167,89075,89075,89170,89170,89167,89168,89048,89215,89289,89048,89215,89289,88962,89211,89284,88962,89211,89284,89076,89074,89164,89164,88944,88944,88945,88946,89024,89025,89026,89027,89185,88944,88944,88945,88946,89024,89025,89026,89027,89185,89076,89186,88943,89022,89182,89074,88943,89022,89182,89186,88953,88953,89286,89045,89286,89045,89068,89068,99540,99654,99540,99654,99521,99694,99616,99512,99646,99521,99694,99616,99607,99512,99646,99607,99507,99624,99701,99592,99504,99546,99661,99504,99507,99624,99701,99592,99506,99506,99581,99562,99568,99600,99679,99562,99568,99600,99679,99581,99546,99661,99548,99663,99548,99663,99519,99687,99615,99519,99687,99615,99524,99700,99524,99700,99625,99585,99571,99621,99689,99625,99584,99570,99620,99688,99584,99573,99626,99692,99587,99573,99626,99692,99587,99505,99547,99662,99570,99620,99688,99547,99662,99629,99545,99660,99505,99660,99545,99531,99636,99707,99629,99707,99672,99672,99586,99572,99623,99691,99531,99636,99572,99623,99691,99586,99526,99705,99628,99628,99526,99705,99509,99637,99704,99602,99602,99509,99637,99704,99101,99172,99326,99428,99326,99428,99101,99172,99236,99236,99091,99309,99400,99407,99354,99126,99197,99126,99197,99091,99309,99400,99407,99377,99377,99354,99121,99121,99368,99069,99139,99258,99280,99295,99420,99368,99069,99139,99258,99280,99370,99071,99141,99260,99282,99386,99089,99370,99071,99141,99260,99282,99295,99420,99310,99401,99408,99092,99310,99401,99408,99092,99307,99398,99405,99386,99089,99307,99398,99405,99343,99122,99122,99090,99387,99308,99399,99406,99343,99339,99110,99181,99339,99110,99181,99371,99072,99142,99261,99283,99371,99072,99142,99261,99283,99369,99070,99140,99259,99281,99300,99395,99409,99388,99388,99300,99395,99409,99421,99296,99421,99296,99321,99422,99218,99097,99419,99299,99369,99070,99140,99259,99281,99419,99299,99321,99422,99218,99097,99330,99104,99175,99340,99183,99231,99330,99104,99175,99340,99183,99231,99372,99064,99135,99253,99275,99372,99064,99135,99253,99275,100948,101017,101093,101173,100948,101017,101093,101173,101150,100997,100989,101139,100997,101150,101139,100989,101129,100954,100954,101023,101099,101179,101129,101118,101195,100973,101118,101195,100973,100954,100954,101023,101099,101179,100956,101025,101101,101181,100956,101025,101101,101181,101148,100995,101148,100995,101153,101000,101122,101199,100977,101160,101160,101153,101000,101121,101198,100976,100979,101124,101201,101124,101201,100979,100955,101024,101100,101180,100976,101121,101198,100955,101024,101100,101180,100953,100953,101022,101098,101098,101178,100953,100953,101022,101098,101098,101178,101159,101159,100939,101008,101164,101003,101156,101003,101156,100961,101030,101106,101186,100961,101030,101106,101186,101123,101200,100978,101164,100939,101008,101123,101200,100978,101155,101002,101002,101155,101135,100986,100986,101135,192789,192789,192799,192792,192799,192792,192787,192787,192798,192798,192827,192898,192965,192832,192903,192970,192827,192898,192965,192927,192994,192927,192994,192870,192941,192870,192941,192925,192992,192881,192952,192925,192992,192881,192952,192890,192957,192829,192900,192967,192890,192957,192829,192900,192967,192919,192986,192919,192986,192874,192945,192832,192903,192970,192886,192954,192886,192954,192834,192905,192972,192834,192905,192972,192861,192932,192999,192861,192932,192999,192875,192946,192839,192910,192977,192875,192946,192876,192947,192876,192947,192926,192993,192926,192993,192924,192991,192924,192991,192839,192910,192977,192873,192944,192873,192944,191988,192485,192547,191988,192485,192547,192436,192501,192563,192436,192501,192563,192323,192441,192506,192323,192466,192529,192466,192529,192441,192506,192458,192521,192458,192521,192461,192523,192461,192523,192324,192324,192321,192475,192538,192321,192475,192538,192480,192542,192480,192542,192459,192522,192460,192524,192460,192524,192429,192495,192557,192434,192499,192561,192429,192495,192557,192483,192545,192459,192522,192483,192545,192064,192347,192420,192488,192551,192064,192347,192420,192488,192551,192431,192496,192558,192431,192496,192558,192453,192516,192453,192516,192434,192499,192561,192322,176234,176266,176273,176273,176286,176286,176263,176263,176252,176252,176246,176292,176244,176246,176244,176261,176266,176261,176294,176294,176292,176230,176230,176233,176233,176236,176236,176293,176293,176291,176269,176291,176277,176272,176272,176269,176235,176277,176235,176268,176268,176248,176248,54884,54884,54884,54884,54884,54884,54884,54884,54884,54884,73407,73497,73569,73548,73462,73462,73548,73407,73497,73569,73418,73455,73525,73478,73557,73478,73557,73418,73455,73525,73452,73457,73527,73452,73457,73527,73472,73473,73553,73485,73472,73473,73553,73419,73501,73485,73419,73501,73395,73439,73513,73468,73545,73477,73558,73477,73558,73468,73545,73395,73439,73513,73371,73371,73423,73423,73423,73502,73414,73499,73571,73414,73499,73571,73394,73531,73394,73531,73391,73493,73568,73391,73493,73568,73377,73425,73503,73482,73377,73425,73503,73482,73371,73371,73423,73423,73423,73502,73378,73487,73563,73378,73487,73563,73481,73559,73549,73549,73481,73559,73427,73540,73427,73540,73479,73458,73460,73528,73458,73460,73528,74850,74852,74852,74857,74857,74868,74853,74869,74853,74869,74862,74862,74865,74865,74868,74849,74849,74848,74848,74863,74863,92324,92436,92403,92403,92324,92436,92376,92386,92465,92416,92489,92376,92386,92465,92416,92489,92377,92387,92466,92377,92387,92466,92410,92481,92417,92490,92417,92490,92347,92363,92452,92410,92481,92347,92363,92452,92440,92424,92497,92440,92424,92497,92413,92485,92413,92485,92332,92332,92332,92340,92340,92340,92441,92335,92438,92335,92438,92401,92478,92313,92323,92432,92401,92478,92313,92323,92432,92334,92351,92442,92421,92494,92334,92351,92442,92421,92494,92332,92332,92332,92340,92340,92340,92441,92314,92426,92499,92314,92426,92499,92306,92420,92493,92306,92420,92493,92418,92491,92390,92469,92378,92388,92467,92378,92388,92467,92390,92469,176304,176304,176303,176303,176302,176302,176806,176806,176777,176899,176750,176750,176777,176807,176807,176755,176782,176755,176747,176907,176793,176793,176747,176907,176808,176808,176742,176895,176742,176895,176762,176762,176751,176767,176751,176767,176782,176763,176763,176783,176783,176779,176773,176773,176733,176887,176733,176887,176779,176937,176978,176978,176931,176931,176937,176920,176920,176939,176925,176925,176919,176919,177068,176917,177068,176965,176965,176916,176950,176950,176911,176939,176911,176923,176923,176964,176964,176916,176915,176915,176935,176935,176963,176963,192593,192770,192707,192707,192593,192770,192565,192740,192678,192565,192740,192678,192611,192611,192642,192619,192728,192658,192619,192728,192658,192620,192729,192659,192594,192771,192708,192594,192771,192708,192625,192664,192625,192664,192744,192682,192682,192744,192725,192655,192569,192569,192746,192683,192725,192655,192580,192757,192694,192580,192757,192694,192608,192722,192651,192620,192729,192659,192608,192722,192651,192595,192772,192709,192595,192772,192709,192603,192711,192783,192630,192621,192660,192603,192711,192783,192630,192622,192730,192665,192622,192730,192612,192665,192627,192734,192668,192612,192627,192734,192668,192569,192569,192746,192683,192666,192666,192742,192570,192747,192570,192747,192684,192684,192739,192674,192739,192674,192717,192775,192717,192775,192640,192742,192640,100478,100481,100438,100518,100478,100481,100550,100550,100142,100435,100515,100515,100435,100142,100522,100442,100522,100442,100438,100518,100521,100441,100441,100509,100134,100430,100509,100430,100134,100504,100130,100426,100504,100130,100426,100469,100489,100407,100558,100119,100469,100489,100119,100407,100558,100547,100467,100547,100467,100441,100441,100494,100141,100418,100503,100425,100425,100494,100141,100418,100532,100532,100452,100498,100521,100498,100520,100452,100520,100507,100507,100466,100546,100546,100466,100503,100502,100424,100502,100424,100411,100124,100516,100149,100436,100516,100149,100436,100545,100465,100545,100465,90779,90972,90779,90972,90998,90921,90960,90960,90921,91044,91015,91044,91015,90721,90913,91053,91103,90913,91053,91103,90721,90998,90720,90780,90973,90999,90780,90973,90999,90930,91059,91112,90929,90969,90985,91082,90929,90969,91049,91100,90931,90930,91059,91112,91049,91100,90763,90950,90985,91082,90763,90950,91024,91041,90915,91054,91104,90720,91024,91041,90915,91054,91104,90971,90781,90974,90781,90974,91000,91011,91036,90748,91000,91011,91036,90748,90919,91055,91105,90724,90922,91056,91108,90724,90922,91056,91108,91045,91045,90933,91061,91114,90933,91061,91114,90931,90971,90924,91109,90926,90934,90975,91072,90934,90924,91109,90975,91072,90918,90775,91003,91028,90918,90943,90943,90862,90775,91003,91028,90862,90926,90966,91069,90966,91069,99489,99347,99450,99489,99347,99450,99357,99461,99357,99461,99439,99439,99356,99460,99444,99444,99438,99438,99335,99437,99486,99486,99334,99436,99471,99471,99431,99356,99460,99431,99355,99458,99355,99458,99442,99442,99485,99485,99334,99436,99333,99435,99333,99435,99454,99454,99484,99484,92009,92509,91980,92030,92260,91980,92509,92030,92260,92039,92269,92300,92039,92269,92300,92009,92010,92010,91996,92035,92265,92293,92265,92293,92035,91996,92027,92257,92287,92040,92270,92301,92040,92270,92301,92027,92257,92287,92011,92011,92022,92282,92041,92271,92302,92022,92282,92042,92288,92031,92261,92031,92261,92042,92288,92299,92299,91985,91985,91985,91986,91986,92505,92274,92014,92505,92274,92014,91985,91985,91985,98554,98554,98584,98584,98579,98579,98578,98577,98577,98582,98582,98576,98576,89355,89417,89417,89355,89334,89413,89334,89413,89356,89398,89341,89328,89398,89341,89375,89375,89412,89412,89363,89363,89403,89346,89403,89346,89379,89356,89418,89354,89338,89418,89354,89338,89391,89391,89327,89352,89392,89410,89330,89330,89327,89357,89419,89389,89389,89419,89357,89324,89322,89322,89324,89414,89414,89359,89359,89399,89342,89399,89365,89342,89365,89309,89309,89380,89380,89379,89360,89360,92126,92126,92143,92058,92058,92059,92215,92215,92144,92060,92216,92144,92060,92216,92172,92244,92088,92210,92088,92210,92172,92244,92137,91979,92052,92207,92137,91979,92052,92207,92131,92202,92113,92131,92202,92113,92125,92198,92125,92198,92169,92169,92085,92241,92097,92180,92252,92085,92241,92180,92252,92097,92123,92058,92058,92059,92215,92215,92152,92152,92068,92224,92152,92152,92068,92224,92123,92100,92187,92103,92103,92187,92165,92081,92237,92071,92228,92155,92183,92255,92100,92183,92255,92094,92177,92249,92170,92242,92155,92071,92228,92170,92242,92086,92086,92165,92081,92237,92124,92142,92213,92142,92213,92124,92099,92182,92254,92099,92182,92254,92134,91977,92049,92205,92134,91977,92049,92205,92146,92146,92062,92218,92127,92062,92218,92199,92127,92199,92154,92154,92154,92154,92070,92226,92109,92190,92109,92190,92197,92122,92197,92143,92117,92193,92117,92193,92129,92129,92057,92212,92070,92226,92057,92212,92167,92167,92083,92239,92138,92053,92208,92138,92112,92053,92208,92101,92184,92184,92112,92122,92168,92084,92240,92168,92084,92240,92121,92196,92083,92239,92196,92121,91821,91821,91723,91808,91723,91808,91749,91749,91737,91818,91737,91818,91822,91822,91733,91815,91733,91815,91747,91747,91754,91754,91721,91721,91709,91709,91758,91716,91758,91722,91807,91722,91807,91725,91810,91725,91810,91719,91719,91745,91745,91751,91751,91757,91757,91711,91711,91746,91746,92875,92875,92742,92892,92892,92892,92586,92671,92743,92818,92893,92586,92671,92743,92818,92893,92937,92937,92614,92699,92921,92582,92667,92582,92667,92614,92699,92921,92736,92809,92884,92736,92809,92884,92879,92879,92874,92951,92874,92951,92623,92708,92929,92696,92768,92843,92918,92696,92768,92843,92918,92623,92708,92929,92873,92950,92742,92892,92892,92892,92714,92935,92711,92714,92935,92692,92764,92839,92914,92932,92711,92932,92597,92682,92903,92810,92885,92705,92776,92851,92926,92810,92885,92612,92697,92919,92612,92697,92919,92597,92682,92903,92625,92710,92931,92625,92710,92931,92741,92741,92692,92764,92839,92914,92806,92882,92658,92658,92806,92882,92876,92952,92876,92952,92820,92895,92673,92820,92895,92673,92873,92950,92595,92679,92901,92595,92679,92901,92940,92596,92681,92904,92940,92725,92872,92949,92725,92872,92949,92867,92944,92867,92944,92954,92954,92596,92681,92904,92713,92933,92713,92933,92888,92665,92665,92888,92694,92766,92841,92916,92871,92948,92724,92694,92766,92841,92916,92871,92948,92724,92695,92767,92842,92917,92695,92767,92842,92917,89779,89848,89923,89779,89848,89923,89878,89955,89778,89847,89763,89832,89907,89763,89832,89907,89957,89757,89826,89901,89757,89826,89901,89809,89881,89960,89816,89888,89816,89888,89809,89881,89960,89776,89845,89920,89868,89868,89896,89896,89793,89862,89938,89793,89862,89938,89766,89834,89910,89782,89850,89925,89782,89850,89925,89788,89857,89933,89766,89834,89910,89794,89863,89939,89794,89863,89939,89776,89845,89920,89866,89866,89754,89823,89823,89823,89898,89957,89791,89860,89936,89791,89860,89936,89780,89849,89924,89780,89849,89924,89807,89880,89958,89807,89880,89958,89812,89885,89812,89885,89818,89890,89818,89890,89783,89852,89927,89752,89821,89893,89752,89821,89893,89783,89852,89927,89755,89824,89899,89755,89824,89899,89808,89959,89754,89823,89823,89823,89898,89808,89959,91071,91066,91066,91097,91097,91071,91093,91093,91074,91074,99248,98972,98992,99248,98992,99041,99229,99041,99229,98972,99048,99116,98978,98978,99048,99116,99078,99149,99267,99289,188581,99011,188581,99029,99166,99216,99029,99166,99216,99078,99149,99267,99289,99011,99217,99314,99317,99317,99217,99314,99001,99024,99161,99211,99191,98982,99016,99017,99191,98982,99303,99016,99017,99303,99001,98969,98998,98998,99198,99198,99198,99056,99015,99082,99153,99271,99293,99015,99082,99153,99271,99293,99164,99214,99027,99311,99311,99164,99214,99027,98969,99045,99113,98975,99045,99113,98975,99040,99228,98970,99040,99228,98970,98981,99051,99190,99205,99018,99051,99190,98981,99205,99018,99305,99305,98989,98989,98989,99198,99198,99198,99056,98971,98971,99199,98990,98990,99199,93591,93678,93591,93678,93590,93677,93677,93587,93727,93727,93587,93620,93629,93620,93629,93658,93658,93647,93647,93662,93662,93657,93638,93403,93638,93403,93616,93703,93616,93703,93590,93677,93677,93599,93686,93599,93686,93657,93602,93691,93617,93618,93628,93617,93618,93628,93635,93602,93691,93406,93641,93409,93409,93406,93641,93612,93699,93405,93640,93405,93640,93612,93699,93589,93676,93589,93676,93665,93665,93659,93659,93593,93735,93593,93735,89590,89677,89563,89590,89677,89563,89655,89736,89546,89967,89662,89743,89655,89736,89967,89662,89743,89546,89974,89673,89974,89673,89652,89733,89652,89733,89612,89695,89588,89631,89712,89631,89712,89588,89612,89695,89635,89716,89635,89716,89632,89713,89632,89713,89572,89600,89686,89626,89707,89543,89666,89747,89543,89666,89747,89618,89700,89618,89700,89572,89600,89686,89651,89732,89569,89569,89597,89683,89597,89683,89583,89584,89585,89674,89975,89617,89616,89699,89617,89616,89699,89629,89710,89629,89710,89651,89732,89964,89659,89740,89542,89964,89659,89740,89542,89653,89734,89653,89734,89620,89702,89548,89548,89969,89541,89665,89746,89541,89665,89746,89969,89620,89702,89972,89560,89671,89560,89671,89972,89583,89584,89585,89674,89975,89559,89559,89654,89735,89561,89654,89735,89976,89675,89561,89976,89675,93733,93733,93732,93674,93674,93668,93724,93668,93724,93713,93713,93718,93718,93758,93758,93732,93741,93741,93744,93669,93669,93744,93754,93754,93730,93730,93721,93721,93714,93714,93680,93680,87797,87797,87654,87654,87682,87682,87707,87637,87637,87786,87786,92570,92649,92726,92799,92570,92649,92726,92799,92788,92863,92788,92863,92574,92655,92733,92803,92574,92655,92733,92803,92552,92779,92854,92647,92798,92540,92611,92540,92611,92552,92779,92854,92579,92661,92771,92846,92543,92579,92661,92739,92511,92739,92511,92771,92846,92543,92817,92817,92817,92514,92585,92670,92650,92515,92650,92515,92817,92817,92817,92514,92585,92670,92549,92620,92662,92662,92541,92769,92845,92754,92829,92526,92769,92845,92541,92782,92857,92555,92626,92555,92626,92754,92829,92526,92536,92607,92559,92629,92559,92629,92782,92857,92781,92856,92554,92648,92554,92781,92856,92584,92669,92584,92669,92648,92536,92607,92732,92577,92732,92577,92571,92651,92727,92800,92571,92651,92727,92800,92746,92517,92588,92746,92517,92588,92750,92826,92523,92647,92798,92750,92826,92523,89235,89235,89229,89229,89238,89266,89266,89238,89272,89272,91823,91893,91970,91823,91893,91970,91827,91897,91974,91827,91897,91974,91804,91875,91951,91864,91939,91864,91939,91743,91969,91804,91875,91951,91768,91839,91914,91768,91839,91914,91766,91838,91838,91838,91913,91867,91942,91763,91908,91763,91908,91832,91902,91832,91902,91867,91942,91766,91838,91838,91838,91913,91850,91850,91850,91925,91865,91940,91865,91940,91904,91904,91801,91872,91948,91878,91954,91878,91954,91850,91850,91850,91925,91881,91881,91860,91935,91767,91841,91916,91767,91841,91916,91824,91894,91971,91824,91894,91971,91830,91900,91830,91900,91860,91935,91744,91837,91911,91837,91911,91806,91877,91953,91744,91806,91877,91953,91847,91922,91743,91969,91847,91922,90602,90298,90438,90647,90602,90298,90417,90563,90629,90563,90629,90417,90590,90590,90439,90648,90439,90648,90618,90582,90350,90582,90575,90350,90575,90594,90594,90292,90292,90618,90422,90633,90422,90633,90305,90605,90419,90564,90630,90419,90564,90630,90306,90413,90441,90558,90620,90551,90588,90551,90588,90242,90247,90242,90247,90605,90305,90591,90552,90599,90584,90584,90243,90246,90552,90599,90243,90246,90591,90349,90592,90349,90290,90592,90290,90418,90561,90627,90438,90647,90626,90626,90418,90561,90627,90579,90579,90348,90574,90348,90574,100172,100271,100351,100260,100341,100260,100341,100172,100271,100351,100185,100321,100356,100185,100321,100356,100245,100332,100203,100235,100319,100393,100203,100235,100319,100393,100165,100270,100350,100245,100332,100160,100210,100294,100368,100153,100207,100160,100210,100294,100368,100174,100272,100352,100174,100272,100352,100157,100157,100157,100209,100293,100367,100367,100367,100238,100324,100398,100238,100324,100398,100153,100207,100199,100282,100361,100199,100282,100361,100157,100157,100157,100209,100293,100367,100367,100367,100176,100221,100305,100379,100236,100322,100396,100236,100322,100396,100201,100283,100243,100329,100201,100283,100248,100335,100176,100221,100305,100379,100248,100335,100252,100252,100195,100231,100315,100389,100162,100296,100370,100162,100296,100370,100175,100273,100353,100175,100273,100353,100192,100279,100359,100192,100279,100359,100195,100231,100315,100389,100291,100166,100291,100247,100334,100247,100334,100166,100170,100218,100302,100376,100165,100270,100350,100170,100218,100302,100376,98915,98685,98765,98654,98734,98890,98685,98765,98915,98655,98735,98947,98634,98947,98634,98594,98594,98655,98735,98928,100765,100765,98899,98665,98665,98899,98892,98658,98892,98658,98909,98909,98928,98951,98638,98638,98951,98635,98948,98688,98768,98918,98948,98635,98669,98749,98942,98669,98749,98936,98936,98688,98768,98918,98595,98595,98595,98906,98906,98906,98668,98748,98901,98668,98748,98901,98904,98937,98904,98937,98595,98595,98595,98906,98906,98906,98657,98657,98677,98907,98677,98907,98945,98632,98654,98734,98890,98932,98932,98632,98945,98662,98742,98896,98896,98662,98742,98656,98891,98891,98656,93033,93033,92956,93039,92956,93039,93008,93082,92997,93079,92997,93079,93031,93008,93082,92972,93054,92972,93054,93034,93034,92971,93053,93000,93093,93051,93051,92962,93045,92962,93045,93000,93093,92971,93053,92983,93065,92998,93091,92963,93046,92998,93091,93005,93085,92963,93046,93011,93094,93011,93094,92983,93065,93014,93097,93014,93097,92993,93075,92974,93056,92974,93056,93035,93035,92959,93042,92959,93042,93090,93090,92993,93075,93032,93010,93083,93010,93083,93032,92980,93062,93031,92980,93062,101400,101372,101400,101355,101419,101355,101419,101390,101390,101413,101374,101374,101394,101394,101413,101356,101403,101356,101383,101350,101383,101403,101391,101391,101391,101382,101382,101391,101391,101391,101392,101392,101353,101372,101417,101417,101353,101377,101377,101362,101373,101373,101362,90103,90114,90180,90114,90180,90103,90185,90119,90119,90185,90094,90001,90083,90222,90156,90156,90001,90083,90222,90113,90094,90013,90167,90013,90167,90131,90058,90197,90128,90131,90058,90197,90130,90130,90057,90196,90115,90115,90125,90048,90190,90048,90190,90125,90004,90159,90054,90193,90054,90193,90128,90086,90225,90004,90159,90086,90225,90057,90196,90142,89987,90070,90208,90002,90157,90084,90223,90223,90084,90223,90223,90002,90157,90091,90230,90010,90164,90049,90049,90097,90016,90170,90016,90170,90142,89987,90070,90208,90097,90019,90019,90152,89997,90079,90218,90133,90133,89978,90061,90199,90116,89978,90061,90199,90116,90181,90122,90188,90181,90188,90122,90152,89997,90079,90218,90056,90056,90096,90015,90169,90096,90015,90169,90139,89984,90066,90205,89984,90066,90205,90113,90139,89529,89516,89451,89451,89451,89451,89451,89451,89480,89508,89480,89508,89299,89440,89299,89440,89464,89428,89422,89521,89428,89422,89521,89534,89445,89534,89445,89464,89509,89454,89482,88567,89482,88567,89509,89432,89432,89476,89499,89469,89302,89486,89302,89486,89469,89454,89301,89442,89304,89491,89471,89304,89491,89471,89431,89431,89533,89421,89533,89301,89442,89443,89421,89443,89479,89479,89506,89529,89516,89468,89468,89506,89425,89527,89425,89527,89420,89519,89531,89420,89519,89531,89490,89490,93482,93422,93493,93569,93422,93493,93569,93482,93426,93497,93575,93426,93497,93575,93473,93545,93462,93537,93462,93537,93492,93567,93473,93545,93437,93512,93437,93512,93436,93436,93511,93511,93511,93570,93570,93431,93503,93581,93395,93465,93431,93503,93581,93395,93465,93434,93434,93436,93436,93511,93511,93511,93448,93523,93394,93463,93394,93463,93504,93582,93400,93470,93542,93504,93582,93476,93548,93448,93523,93476,93548,93551,93551,93458,93533,93439,93514,93439,93514,93423,93494,93571,93423,93494,93571,93429,93500,93578,93429,93500,93578,93458,93533,93568,93475,93547,93475,93547,93568,93445,93520,93492,93567,93445,93520,90678,90831,90678,90831,90708,90880,90871,90871,90708,90880,90820,90820,90691,90844,90658,90809,90730,90730,90658,90809,90651,90801,90651,90801,90722,90903,90744,90722,90903,90672,90825,90672,90825,90744,90691,90844,90785,90876,90884,90785,90876,90681,90834,90782,90873,90884,90782,90873,90733,90662,90814,90751,90857,90703,90869,90662,90814,90733,90849,90696,90849,90696,90681,90834,90669,90822,90667,90667,90738,90698,90851,90698,90732,90851,90661,90811,90732,90661,90811,90650,90669,90822,90741,90742,90650,90670,90823,90742,90670,90823,90738,90866,90706,90877,90695,90848,90866,90706,90877,90695,90848,90655,90805,90727,90655,90805,90727,90902,90649,90800,90902,90649,90800,91271,91271,91173,91173,91233,91316,91244,91233,91316,91244,91269,91291,91272,91291,91186,91186,91290,91272,91282,91282,91236,91236,91184,91288,91184,91288,91186,91186,91290,91214,91302,91234,91234,91283,91241,91283,91247,91247,91214,91302,91250,91250,91229,91312,91191,91293,91191,91293,91273,91273,91229,91312,91270,91246,91246,91270,91190,91299,91299,91190,91269,89202,88907,88988,88907,88988,89204,89265,89265,89204,89001,89082,89248,89014,89014,89042,89063,88901,89063,88901,88888,88968,89042,88888,88968,89001,89082,89248,88910,88991,88972,89053,88972,89053,89260,89011,89253,88925,89253,88925,88910,88991,88979,89058,89058,89255,88927,89255,88927,88971,89052,88971,89052,89041,88979,89041,89202,89263,89005,89086,89252,89263,89005,89086,89252,88885,88965,89213,89213,88885,88965,89040,89040,87829,87829,88003,88003,87901,87901,87905,87905,87903,87834,87834,87879,87879,87903,87917,87917,87922,87922,87988,87832,87832,87907,87907,87988,87902,87902,87909,87909,87914,87914,99738,99799,99873,99890,99738,99799,99873,99764,99829,99892,99764,99829,99858,99858,99892,99785,99824,99895,99725,99786,99865,99725,99786,99865,99723,99821,99902,99723,99821,99902,99746,99837,99912,99746,99837,99912,99785,99824,99895,99776,99842,99776,99842,99768,99835,99768,99835,99747,99805,99877,99747,99805,99877,99727,99741,99882,99913,99727,99741,99882,99913,99791,99718,99771,99771,99771,99861,99861,99713,99851,99730,99745,99888,99916,99754,99840,99730,99745,99888,99916,99754,99840,99718,99771,99771,99771,99861,99861,99900,99900,99720,99782,99862,99713,99851,99720,99782,99862,99761,99825,99890,99811,99836,99903,99811,99836,99903,99761,99825,99731,99828,99908,99731,99828,99908,99721,99818,99896,99721,99818,99896,88115,88115,88065,88169,88169,88167,88167,88135,88135,88065,93111,93197,93272,93347,93144,93300,93144,93300,93115,93200,93349,93115,93200,93349,93138,93220,93138,93220,93121,93206,93280,93355,93121,93206,93280,93355,93157,93239,93112,93133,93133,93174,93112,93174,93162,93245,93319,93147,93303,93162,93245,93319,93125,93210,93284,93169,93125,93210,93284,93147,93303,93175,93257,93175,93257,93180,93180,93157,93239,93246,93130,93130,93246,93124,93209,93283,93124,93209,93283,93136,93218,93292,93136,93218,93292,93114,93199,93114,93199,93135,93217,93217,93217,93291,93291,93291,93111,93197,93272,93347,93172,93172,93161,93243,93161,93243,93113,93198,93348,93187,93263,93337,93187,93263,93337,93113,93198,93348,93118,93203,93277,93118,93203,93277,93135,93217,93217,93217,93291,93291,93291,90371,90481,90523,90354,90450,90469,90274,90354,90450,90469,90274,90269,90443,90464,90334,90334,90269,90443,90464,90397,90519,90549,90340,90340,90397,90519,90549,90451,90233,90256,90451,90233,90256,90347,90371,90481,90523,90285,90444,90372,90483,90524,90282,90372,90483,90524,90444,90360,90475,90499,90279,90360,90475,90499,90279,90288,90401,90404,90366,90478,90514,90282,90366,90478,90514,90288,90401,90404,90329,90393,90512,90545,90236,90259,90454,90454,90236,90259,90383,90496,90535,90361,90503,90361,90503,90253,90286,90399,90402,90383,90496,90535,90286,90399,90402,90235,90258,90453,90453,90235,90258,90369,90480,90521,90369,90480,90521,90393,90512,90545,90329,90357,90472,90487,90277,90277,90357,90472,90487,90446,90465,90270,90374,90484,90526,90374,90484,90526,90270,90446,90465,90380,90495,90532,90380,90495,90532,90347,88408,88408,88389,88389,100634,100702,100648,100716,100634,100702,100623,100690,100759,100623,100690,100759,100576,100649,100717,100567,100567,100576,100649,100717,100582,100654,100722,100582,100654,100722,100626,100693,100626,100693,100662,100588,100659,100727,100588,100659,100727,100598,100665,100734,100662,100598,100665,100734,100577,100577,100597,100664,100664,100664,100733,100733,100733,100597,100664,100664,100664,100733,100733,100733,100636,100704,100764,100636,100704,100764,100619,100686,100755,100732,100732,100578,100650,100718,100578,100650,100718,100600,100667,100736,100600,100667,100736,100585,100657,100725,100585,100657,100725,100625,100691,100609,100676,100745,100625,100691,100589,100631,100699,100589,100609,100676,100745,100637,100705,100637,100705,100619,100686,100755,100648,100716,100606,100673,100742,100606,100673,100742,91197,91197,91167,91212,91150,91150,91146,91146,91201,91121,91140,91121,91133,91201,91260,91133,91260,91117,91176,91280,91117,91176,91280,91169,91131,91131,91169,91212,91145,91145,91128,91128,91226,91129,91188,91148,91148,91226,91129,91188,91120,91180,91120,91180,91135,91126,91126,91264,91264,91135,91277,91277,91168,91157,91157,91168,91217,91143,91217,91167,91143,88935,88935,88892,88892,88899,88899,88898,88898,88937,88937,88897,88897,88344,88932,99928,100025,99921,99981,100064,99993,99921,99981,100064,99993,99954,100009,100090,99954,100009,100090,99937,100034,100059,99937,100034,100059,100000,100028,100100,100000,100028,100100,99935,100032,99935,100032,99971,100052,99971,100052,99942,99992,100078,99942,99992,100078,99978,100060,99978,100060,100114,99951,100005,100087,99951,100005,100087,99938,99989,100073,99938,99989,100073,99940,99998,100075,99931,99940,99998,100075,99919,99980,100063,99996,99919,99980,100063,99996,99931,99933,100030,100114,100021,100037,100106,99933,100030,100021,100037,100106,99970,100051,100043,100082,100043,100082,99970,100051,99974,100056,99974,100056,94766,94766,94761,94752,94752,94761,94806,94743,94806,94743,94735,94772,94735,94772,94781,94781,94780,94780,94789,94789,94769,94769,94784,94784,94762,94762,94744,94744,94802,94802,94746,94746,94792,94792,94733,94773,94733,94773,94740,98629,98710,98791,98872,98830,98622,98703,98783,98866,98830,98622,98703,98783,98866,98607,98850,98607,98850,98566,98716,98797,98878,98566,98716,98797,98878,98720,98800,98720,98800,98617,98698,98778,98860,98617,98698,98778,98860,98837,98837,98816,98565,98715,98796,98877,98565,98715,98796,98877,98816,98738,98819,98738,98819,98679,98759,98841,98679,98759,98841,98745,98826,98745,98826,98605,98847,98815,98605,98847,98676,98756,98838,98676,98756,98838,98737,98818,98737,98818,98757,98839,98757,98839,98589,98829,98624,98705,98785,98865,98589,98829,98624,98705,98785,98865,98674,98754,98835,98674,98754,98835,98563,98713,98794,98875,98815,98621,98702,98782,98864,98563,98713,98794,98875,98621,98702,98782,98864,98736,98817,98736,98817,98823,98823,101072,101233,101308,101072,101233,101308,101227,101304,101066,101227,101304,101066,101276,101341,101276,101341,101049,101287,101065,101225,101303,101049,101287,101245,101279,101344,101279,101344,101077,101239,101313,101077,101239,101313,101251,101319,101251,101319,101245,101067,101228,101067,101228,101250,101318,101318,101085,101085,101085,101085,101250,101318,101318,101259,101327,101065,101225,101303,101259,101327,101075,101236,101311,101075,101236,101311,101253,101321,101253,101321,101068,101229,101305,101068,101229,101305,101226,101289,101051,101051,101289,101226,101083,101248,101083,101248,101272,101338,101272,101338,101052,101290,101290,101052,101262,101330,101262,101330,101277,101342,101240,101277,101342,101240,101284,101046,89168,89219,89219,89015,89160,89015,89160,89072,89072,88938,89018,89175,88938,89018,89175,88941,89021,89181,88941,89021,89181,88920,88920,88958,89039,89281,88958,89039,89009,89173,89009,89173,89281,88961,89210,89283,88983,88983,89049,89216,89290,89210,89283,88961,89049,89216,89290,89280,88957,89038,89069,89069,89060,89226,89060,89226,89207,88960,89061,89227,89207,88960,89061,89227,89218,89293,89218,89293,89017,89162,89017,89162,88978,89224,89296,89224,89296,88978,89008,89171,89008,89171,89280,88957,89038,88924,88924,88959,89205,89282,89205,89282,88959,89046,89287,89287,89046,99522,99696,99617,99601,99522,99696,99617,99517,99681,99613,99517,99681,99613,99601,99682,99682,99497,99574,99633,99693,99588,99665,99612,99588,99497,99574,99633,99693,99530,99579,99530,99561,99567,99596,99676,99579,99561,99567,99596,99676,99527,99708,99631,99527,99708,99631,99645,99533,99645,99533,99683,99683,99532,99643,99532,99655,99541,99665,99612,99541,99655,99627,99525,99702,99627,99525,99702,99614,99535,99648,99648,99535,99518,99685,99518,99685,99614,99668,99590,99499,99576,99640,99697,99590,99499,99576,99640,99697,99641,99668,99641,99673,99673,99503,99503,99500,99622,99699,99591,99500,99622,99699,99591,99544,99658,99577,99544,99658,99559,99565,99593,99674,99577,99559,99565,99593,99674,99571,99621,99689,99585,99308,99399,99406,99090,99387,99120,99083,99154,99204,99120,99392,99412,99083,99154,99204,99392,99412,99367,99068,99143,99257,99279,99367,99068,99143,99257,99279,99415,99096,99167,99415,99096,99167,99418,99298,99418,99298,99378,99378,99390,99302,99411,99390,99302,99411,99242,99242,99385,99095,99404,99385,99095,99404,99338,99109,99180,99109,99180,99059,99130,99201,99359,99359,99059,99130,99201,99338,99187,99235,99344,99187,99235,99344,99364,99065,99136,99254,99276,99364,99065,99136,99254,99276,99127,99243,99244,99245,99127,99243,99244,99245,99337,99337,99057,99128,99246,99246,99057,99128,99237,99119,99237,99119,99085,99156,99394,99414,99085,99156,99394,99414,99093,99384,99403,99403,99093,99384,99382,99382,99427,99108,99179,99336,99108,99179,99336,99341,99184,99232,99427,99341,99184,99232,101151,100998,101134,101151,100998,101146,100993,101146,100993,101134,100966,101035,101111,101191,100966,101035,101111,101191,100980,101125,101202,101125,101202,100980,101144,101163,100972,101041,101117,101194,100972,101041,101117,101194,100935,101004,101157,100935,101004,101157,100941,101010,101086,101166,100941,101010,101086,101166,101163,100940,100940,101009,101165,101165,100940,100940,101009,101165,101165,100949,101019,101094,101174,100949,101019,101094,101174,101144,101001,101154,101001,101154,100943,101012,101088,101168,100943,101012,101088,101168,100994,101147,100994,101147,101127,101204,100982,101145,100982,101127,101204,101145,188582,101418,188582,101418,100962,101031,101107,101187,100962,101031,101107,101187,100983,101128,101128,100983,100952,101021,101097,101177,100952,101021,101097,101177,100970,101039,101115,101192,101158,100970,101039,101115,101192,101158,101122,101199,100977,192797,192797,192800,192800,192796,192796,192824,192896,192963,192824,192896,192963,192830,192901,192968,192830,192901,192968,192866,192937,193004,192866,192937,193004,192877,192948,192877,192948,192822,192895,192962,192909,192976,192869,192940,192869,192940,192835,192906,192973,192835,192906,192973,192841,192912,192979,192841,192912,192979,192909,192976,192825,192825,192840,192840,192840,192911,192911,192978,192978,192978,192826,192897,192964,192826,192897,192964,192843,192914,192981,192843,192914,192981,192833,192904,192971,192833,192904,192971,192879,192950,192823,192879,192950,192862,192933,193000,192823,192862,192933,193000,192880,192951,192880,192951,192923,192990,192923,192990,192868,192938,192868,192938,192874,192945,192920,192987,192920,192987,192822,192895,192962,192474,192537,191997,192426,192474,192537,191997,192426,192016,192443,192507,192016,192443,192507,192467,192530,192360,192435,192500,192562,192360,192435,192500,192562,192449,192511,192449,192511,192428,192494,192556,192428,192494,192556,192482,192544,192467,192530,192482,192544,192456,192520,192476,192539,192456,192520,192476,192539,192322,191996,192425,192454,192517,192454,192517,192473,192536,192471,192534,192471,192534,192473,192536,191996,192425,192432,192497,192559,192432,192497,192559,192427,192493,192555,192427,192493,192555,192478,192541,192478,192541,192440,192505,192098,192437,192502,192564,192098,192437,192502,192564,192017,192017,192369,192445,192508,192440,192505,192447,192509,192447,192509,176279,176279,176276,176245,176245,176278,176278,176278,176259,176259,176270,176270,176276,176229,176229,176258,176258,176264,176264,176257,176237,176237,176278,176287,176287,176257,176234,176271,176227,176271,176290,176227,176290,176240,176240,176243,176243,176260,176281,176260,176281,176267,176267,176239,176239,73428,73541,73428,73541,73475,73555,73475,73555,73471,73552,73471,73552,74847,74847,92415,92487,92415,92487,92484,92484,92328,92328,176754,176899,176754,176757,176757,176896,176896,177069,177069,176913,176913,176910,176910,192615,192654,192680,192567,192680,192567,192615,192654,192642,192618,192727,192657,192618,192727,192657,192604,192784,192604,192784,100408,100559,100120,100490,100120,100408,100559,100490,100500,100423,100500,100423,100411,100124,100497,100148,100497,100148,91048,91099,91048,91099,90908,91051,91102,90908,91051,91102,90747,91012,91037,90747,91012,91037,99433,99433,99456,99456,91982,92034,92264,92292,91982,92034,92264,92292,92267,92296,92037,92037,92267,92296,92023,92283,92023,92283,98574,98574,89415,89415,89333,89333,89402,89328,89345,89402,89345,89377,89377,89350,89325,89350,89325,92098,92181,92253,92098,92181,92253,92140,92140,92055,92116,92055,92116,92101,92106,92106,92119,92195,92195,92119,91739,91820,91739,91820,91736,91736,91720,91720,92624,92709,92930,92624,92709,92930,92943,92815,92890,92815,92890,92943,92723,92869,92946,92938,92938,92723,92869,92946,89804,89876,89953,89804,89876,89953,89801,89873,89950,89801,89873,89950,89792,89861,89937,89792,89861,89937,89922,89878,89955,89778,89847,89922,89819,89891,89819,89891,89798,89947,89864,89864,89798,89947,89765,89835,89909,89895,89895,89811,89883,89962,89802,89874,89951,89811,89883,89962,89802,89874,89951,89805,89879,89956,89796,89870,89945,89805,89879,89956,89765,89835,89909,89796,89870,89945,91067,91067,91095,91095,91096,91096,99081,99152,99270,99292,99014,98968,99014,99081,99152,99270,99292,99080,99151,99269,99291,99038,99106,99177,98967,99038,99106,99177,98967,99080,99151,99269,99291,99013,99013,99052,99238,98985,99052,99238,99171,98985,99171,99315,99032,99169,99000,99000,99032,99169,99039,99107,99178,99039,99107,99178,98968,99035,99222,98989,98989,98989,99035,99222,99043,99043,99028,99165,99215,99165,99215,99312,99028,99312,99328,99054,99240,98987,98987,99054,99240,99315,99328,99037,99176,99224,99331,99037,99176,99224,99331,93653,93710,93653,93710,93650,93650,93404,93639,93639,93404,93601,93688,93651,93651,93421,93656,93712,93421,93656,93712,93643,93705,93414,93601,93688,93414,93643,93705,93407,93407,93646,93646,93725,93725,93613,93701,93655,93711,93420,93655,93711,93420,93613,93701,93615,93702,93615,93702,89615,89698,89608,89615,89698,89608,89614,89697,89649,89730,89649,89730,89614,89697,89601,89601,89549,89556,89669,89750,89970,89970,89556,89669,89750,89549,89633,89714,89633,89714,89641,89723,89599,89685,89571,89571,89641,89723,89650,89731,89650,89731,89645,89727,89559,89559,89657,89738,89645,89727,89599,89685,89582,89555,89555,89582,89657,89738,89630,89711,89630,89711,89644,89726,89551,89551,89644,89726,89647,89729,89647,89729,93716,93729,93716,93729,93743,93708,93708,93743,93672,93672,93756,93756,93757,93757,87764,87764,87706,87775,87775,87706,87741,87807,87741,87807,87743,87743,87730,87730,87638,87638,92553,92780,92855,92780,92855,92553,92640,92791,92866,92640,92791,92866,92794,92567,92643,92567,92643,92794,92653,92653,92513,92752,92828,92525,92513,92565,92641,92721,92792,92565,92641,92721,92792,92562,92637,92718,92784,92859,92797,92569,92646,92797,92569,92646,92562,92637,92718,92784,92859,92752,92828,92525,92796,92568,92645,92538,92609,92568,92645,92796,92539,92610,92539,92610,92538,92609,92737,92813,92580,92737,92813,92580,92787,92862,92557,92627,92557,92627,92787,92862,89271,89271,89237,89268,89268,89195,89195,89237,89198,89198,91890,91965,91890,91965,91962,91835,91835,91962,91805,91876,91952,91805,91876,91952,91849,91849,91849,91924,91765,91910,91765,91910,91888,91963,91888,91963,91885,91956,91892,91968,91742,91892,91968,91742,91885,91956,91849,91849,91849,91924,91959,91761,91833,91906,91959,91880,91880,91761,91833,91906,91862,91937,91863,91938,91863,91938,91741,91891,91967,91862,91937,91891,91967,91741,90436,90572,90645,90267,90623,90436,90572,90645,90267,90625,90268,90625,90623,90585,90420,90631,90420,90631,90585,90604,90304,90304,90428,90566,90638,90437,90573,90646,90268,90566,90638,90428,90437,90573,90646,90341,90432,90569,90642,90264,90341,90432,90569,90642,90352,90264,90577,90352,90577,90604,90562,90628,90416,90416,90562,90628,90431,90641,90587,90587,90431,90641,90571,90644,90434,90266,90571,90644,90434,90266,100156,100266,100394,100156,100266,100394,100263,100344,100288,100364,100288,100364,100249,100263,100344,100246,100333,100246,100333,100173,100220,100304,100378,100155,100290,100366,100182,100275,100355,100155,100290,100366,100182,100275,100355,100150,100264,100345,100150,100264,100345,100256,100337,100163,100269,100349,100163,100269,100349,100256,100337,100173,100220,100304,100378,100205,100286,100362,100259,100340,100259,100340,100249,100205,100286,100362,100198,100233,100317,100391,100198,100233,100317,100391,100200,100234,100318,100392,100200,100234,100318,100392,100159,100268,100348,100159,100268,100348,98888,98652,98732,98888,98652,98732,98931,98931,98930,98930,98902,98672,98636,98949,98636,98959,98959,98672,98902,98687,98767,98917,98956,98880,98644,98889,98653,98733,98889,98653,98733,98880,98644,98956,98884,98648,98729,98884,98648,98729,98894,98660,98894,98660,98687,98767,98917,98946,98946,98633,98633,98883,98647,98949,98647,98883,98650,98811,98886,98650,98811,98886,93027,93027,93024,92968,92968,93024,93009,93081,93009,93081,92982,93064,92970,93037,93037,92970,93025,93025,93021,93030,93030,93021,92982,93064,92966,93049,93012,93095,93012,93095,92966,93049,92995,93077,92996,93078,92996,93078,93029,92995,93077,93029,101370,101370,101416,101416,101415,101415,101386,101361,101361,101386,101402,101402,101358,101371,101371,101358,101366,101366,101354,101354,101365,101388,101388,101365,101368,101368,90177,90109,90109,90177,90106,90027,90106,90027,90095,90095,90014,90168,90014,90168,90107,90183,90028,90175,90107,90028,90175,90130,90130,90195,90183,90195,89986,90068,90207,90099,90024,90172,90179,90112,90179,90099,90024,90172,90141,90141,89986,90068,90207,90126,90102,90052,90191,90102,90017,90017,90126,90052,90191,90154,90154,89999,90081,90220,90155,90000,90082,90221,90155,90000,90082,90221,90112,90111,90178,89999,90081,90220,90111,90178,89513,89526,89466,89513,89526,89528,89467,89467,89466,89435,89489,89435,89489,89453,89484,89511,89515,89528,89515,89484,89511,89453,89298,89439,89538,89298,89439,89538,89501,89518,89501,89518,89481,89481,89507,89507,89494,89517,89494,89517,89437,89437,89503,89348,89523,89348,89523,89503,93419,93488,93564,93419,93488,93564,93509,93509,93485,93561,93485,93561,93474,93546,93474,93546,93417,93486,93562,93417,93486,93562,93573,93573,93447,93522,93478,93558,93491,93566,93491,93566,93478,93558,93447,93522,93481,93432,93507,93585,93481,93549,93549,93432,93507,93585,93460,93535,93461,93536,93461,93536,93490,93565,93460,93535,93490,93565,90899,90798,90693,90846,90798,90899,90694,90847,90900,90694,90847,90693,90846,90736,90665,90815,90783,90874,90713,90890,90783,90874,90665,90815,90713,90890,90736,90680,90833,90792,90892,90711,90886,90799,90900,90792,90892,90711,90886,90799,90680,90833,90819,90740,90653,90803,90725,90907,90653,90803,90725,90907,90819,90740,90795,90904,90717,90894,90741,90717,90894,90795,90904,90867,90867,90707,90879,90707,90879,90901,90901,90817,90817,90719,90897,90797,90797,90719,90897,91259,91259,91245,91245,91262,91262,91275,91275,91207,91301,91268,91268,91207,91301,91181,91286,91248,91248,91181,91286,91231,91314,91232,91315,91232,91315,91267,91231,91314,91267,89199,89199,89003,89084,89250,89004,89085,89251,89004,89085,89251,89003,89084,89250,88893,88975,89056,88893,88975,89056,88909,88990,88948,89029,89201,89201,88948,89029,88909,88990,89044,89033,89275,89033,89275,89044,89264,89264,88895,88895,89277,89277,87904,87904,87916,87976,87976,87916,87855,87855,88001,88002,88002,88001,99797,99832,99899,99717,99814,99883,99717,99814,99883,99806,99834,99901,99806,99834,99901,99797,99832,99899,99711,99758,99843,99711,99758,99843,99772,99839,99742,99803,99874,99789,99854,99789,99854,99719,99815,99886,99719,99815,99886,99742,99803,99874,99857,99906,99906,99857,99709,99801,99864,99709,99801,99864,99762,99827,99762,99827,99714,99812,99868,99714,99812,99868,99766,99766,99859,99859,99772,99839,88005,88005,87999,88213,87999,88213,88031,88031,88006,88006,93109,93195,93270,93345,93109,93195,93270,93345,93159,93241,93160,93242,93160,93242,93176,93176,93186,93262,93336,93128,93213,93186,93262,93336,93128,93213,93159,93241,93102,93183,93259,93333,93110,93196,93271,93346,93110,93196,93271,93346,93102,93183,93259,93333,93146,93302,93132,93132,93146,93302,93105,93191,93267,93105,93191,93267,93107,93193,93269,93107,93193,93269,93190,93266,93190,93266,93215,93215,93173,93173,90452,90234,90257,90452,90234,90257,90343,90461,90343,90461,90459,90285,90459,90448,90467,90382,90497,90534,90368,90520,90284,90368,90520,90284,90272,90448,90467,90272,90382,90497,90534,90456,90330,90238,90261,90346,90463,90330,90456,90238,90261,90346,90463,90395,90517,90547,90337,90337,90280,90364,90476,90508,90333,90280,90364,90476,90508,90333,90396,90518,90548,90338,90396,90518,90548,90338,90395,90517,90547,90462,90345,90462,90345,88620,88620,88390,88390,100635,100703,100635,100703,100573,100645,100712,100573,100645,100712,100730,100730,100570,100642,100570,100642,100563,100639,100707,100608,100675,100744,100563,100639,100707,100575,100647,100715,100575,100647,100715,100580,100652,100720,100580,100652,100720,100596,100596,100608,100675,100744,100571,100643,100710,100571,100643,100710,100574,100646,100714,100574,100646,100714,100622,100689,100758,100622,100689,100758,100566,100592,100660,100728,100566,100592,100660,100728,100621,100688,100757,100621,100688,100757,91215,91124,91156,91124,91156,91147,91147,91216,91216,91165,91215,91165,91161,91171,91161,91199,91171,91166,91153,91166,91199,91153,91160,91160,91265,91265,91144,91144,88936,88936,99934,100031,99934,100031,99966,100048,100110,99966,100048,100110,100107,99986,100069,99986,100069,100107,99960,100039,100074,99953,100008,100089,99960,100039,100074,99969,100050,100113,99969,100050,100113,100054,99936,100071,100054,99953,100008,100089,99936,100071,99964,100046,100108,99964,100046,100108,99968,100049,100112,100019,100035,100103,99968,100049,100112,100020,100036,100105,100020,100036,100105,100042,100081,99925,99984,100067,100042,100081,99925,99984,100067,100019,100035,100103,94804,94776,94751,94776,94751,94805,94805,94759,94804,94759,94755,94755,94791,94764,94764,94760,94760,94748,94791,94748,94778,94778,94757,94757,94745,94745,98564,98714,98795,98876,98564,98714,98795,98876,98731,98965,98731,98965,98728,98808,98962,98728,98808,98962,98568,98725,98805,98606,98849,98568,98725,98805,98814,98814,98740,98821,98740,98821,98606,98849,98809,98963,98809,98963,98813,98619,98700,98779,98862,98813,98620,98701,98781,98863,98620,98701,98781,98863,98717,98798,98717,98798,98752,98833,98752,98833,98619,98700,98779,98862,101274,101339,101274,101339,101243,101314,101078,101078,101243,101314,101057,101057,101275,101340,101275,101340,101063,101223,101301,101063,101223,101301,101059,101220,101297,101220,101297,101059,101082,101247,101070,101231,101082,101247,101070,101231,101224,101302,101064,101224,101302,101064,101054,101216,101292,101261,101329,101261,101329,101054,101216,101292,101219,101296,101219,101296,101080,101316,101080,101316,101222,101299,101061,101222,101299,101061,101050,101288,101050,101288,89172,89172,88954,89035,88954,89035,88951,89032,89193,88951,89032,89193,89188,89071,89188,88956,89037,89279,88956,89037,89279,89285,88963,89071,89285,88963,88952,88952,88955,89036,89278,88955,89036,89278,88922,88923,88923,88939,89019,89178,88939,89019,89178,89222,89294,89222,89294,88922,99678,99678,99632,99528,99528,99599,99632,99501,99599,99680,99611,99680,99515,99659,99610,99610,99515,99659,99511,99644,99606,99643,99511,99644,99606,99520,99690,99520,99690,99516,99664,99516,99664,99611,99508,99630,99703,99594,99543,99657,99543,99657,99508,99630,99703,99594,99501,99642,99604,99635,99635,99642,99604,99513,99650,99608,99513,99650,99608,99498,99575,99638,99695,99498,99575,99638,99695,99589,99589,99094,99094,99105,99105,99430,99353,99125,99196,99353,99125,99196,99430,99416,99322,99423,99219,99098,99366,99366,99067,99138,99256,99278,99322,99423,99219,99098,99227,99227,99111,99182,99111,99182,99067,99138,99256,99278,99329,99103,99174,99329,99103,99174,99226,99226,99381,99381,99325,99426,99100,99294,99416,99294,99351,99325,99426,99100,99123,99194,99123,99194,99351,99380,99380,100964,101033,101109,101189,100964,101033,101109,101189,101161,100936,101005,100936,101005,101161,101133,101133,100965,101034,101110,101190,100992,100965,101034,101110,101190,101142,100991,101142,100991,101138,100988,101138,100988,100951,101020,101096,101176,101149,100996,101149,100996,101143,101143,100992,101130,100951,101020,101096,101176,101130,101114,101137,100938,101007,100938,101007,101114,101137,101140,100968,100990,101140,100968,100990,101126,101203,100981,101126,101203,100981,192793,192793,192795,192794,192794,192791,192791,192795,192788,192788,192882,192953,192922,192988,192922,192988,192882,192953,192821,192894,192961,192889,192956,192889,192956,192840,192840,192840,192911,192911,192978,192978,192978,192828,192899,192966,192828,192899,192966,192820,192893,192960,192820,192893,192960,192821,192894,192961,192865,192936,193003,192865,192936,193003,192864,192935,193002,192864,192935,193002,192836,192907,192974,192885,192836,192907,192974,192885,192819,192891,192958,192819,192891,192958,192888,192838,192838,192888,192878,192949,192878,192949,192549,192549,192421,192489,192552,192421,192489,192552,192484,192546,192457,192519,192457,192519,192484,192546,191995,192424,192492,192554,192063,192346,192419,192487,192550,192063,192346,192419,192487,192550,192017,192017,192369,192445,192508,192430,192368,192442,192430,192368,192442,192503,192503,192469,192532,192469,192532,192470,192533,192470,192533,191995,192424,192492,192554,191994,192423,192491,192553,191994,192423,192491,192553,176255,176255,176274,176274,176241,176262,176262,176278,176278,176251,176251,176256,176256,176247,176289,176289,176247,176253,176253,176250,176250,176241,176238,176238)


--where HAUserQuestionGroupResults.CodeName is not NULL
--select * from HFit_HealthAssesmentUserQuestionGroupResults


GO




if exists(select TABLE_NAME from INFORMATION_SCHEMA.VIEWS where TABLE_NAME = 'View_EDW_HealthAssesmentAnswers')
BEGIN
	drop view View_EDW_HealthAssesmentAnswers ;
END
GO


CREATE VIEW [dbo].[View_EDW_HealthAssesmentAnswers]
AS
--********************************************************************************************************
--WDM 8.8.2014 - Created this view in order to add the DocumentGUID as 
--			required by the EDW team. Was having a bit of push-back
--			from the developers, so created this one in order to 
--			expedite filling the need for runnable views for the EDW.
-- Verified last mod date available to EDW 9.10.2014
--********************************************************************************************************
      SELECT
        VHFHAPAJ.ClassName AS AnswerType
       ,VHFHAPAJ.Value
       ,VHFHAPAJ.Points
       ,VHFHAPAJ.NodeGUID
       ,VHFHAPAJ.IsEnabled
       ,VHFHAPAJ.CodeName
	   ,VHFHAPAJ.InputType
       ,VHFHAPAJ.UOM
       ,VHFHAPAJ.NodeAliasPath
       ,VHFHAPAJ.DocumentPublishedVersionHistoryID
       ,VHFHAPAJ.NodeID
       ,VHFHAPAJ.NodeOrder
       ,VHFHAPAJ.NodeLevel
       ,VHFHAPAJ.NodeParentID
       ,VHFHAPAJ.NodeLinkedNodeID
	   ,VHFHAPAJ.DocumentCulture
	   ,VHFHAPAJ.DocumentGuid
	   ,VHFHAPAJ.DocumentModifiedWhen
      FROM
        dbo.View_HFit_HealthAssesmentPredefinedAnswer_Joined AS VHFHAPAJ WITH(NOLOCK)









--GO

--EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
--Begin DesignProperties = 
--   Begin PaneConfigurations = 
--      Begin PaneConfiguration = 0
--         NumPanes = 4
--         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
--      End
--      Begin PaneConfiguration = 1
--         NumPanes = 3
--         Configuration = "(H (1 [50] 4 [25] 3))"
--      End
--      Begin PaneConfiguration = 2
--         NumPanes = 3
--         Configuration = "(H (1 [50] 2 [25] 3))"
--      End
--      Begin PaneConfiguration = 3
--         NumPanes = 3
--         Configuration = "(H (4 [30] 2 [40] 3))"
--      End
--      Begin PaneConfiguration = 4
--         NumPanes = 2
--         Configuration = "(H (1 [56] 3))"
--      End
--      Begin PaneConfiguration = 5
--         NumPanes = 2
--         Configuration = "(H (2 [66] 3))"
--      End
--      Begin PaneConfiguration = 6
--         NumPanes = 2
--         Configuration = "(H (4 [50] 3))"
--      End
--      Begin PaneConfiguration = 7
--         NumPanes = 1
--         Configuration = "(V (3))"
--      End
--      Begin PaneConfiguration = 8
--         NumPanes = 3
--         Configuration = "(H (1[56] 4[18] 2) )"
--      End
--      Begin PaneConfiguration = 9
--         NumPanes = 2
--         Configuration = "(H (1 [75] 4))"
--      End
--      Begin PaneConfiguration = 10
--         NumPanes = 2
--         Configuration = "(H (1[66] 2) )"
--      End
--      Begin PaneConfiguration = 11
--         NumPanes = 2
--         Configuration = "(H (4 [60] 2))"
--      End
--      Begin PaneConfiguration = 12
--         NumPanes = 1
--         Configuration = "(H (1) )"
--      End
--      Begin PaneConfiguration = 13
--         NumPanes = 1
--         Configuration = "(V (4))"
--      End
--      Begin PaneConfiguration = 14
--         NumPanes = 1
--         Configuration = "(V (2))"
--      End
--      ActivePaneConfig = 0
--   End
--   Begin DiagramPane = 
--      Begin Origin = 
--         Top = 0
--         Left = 0
--      End
--      Begin Tables = 
--         Begin Table = "VHFHAPAJ"
--            Begin Extent = 
--               Top = 6
--               Left = 38
--               Bottom = 260
--               Right = 362
--            End
--            DisplayFlags = 280
--            TopColumn = 173
--         End
--      End
--   End
--   Begin SQLPane = 
--   End
--   Begin DataPane = 
--      Begin ParameterDefaults = ""
--      End
--   End
--   Begin CriteriaPane = 
--      Begin ColumnWidths = 11
--         Column = 1440
--         Alias = 900
--         Table = 1170
--         Output = 720
--         Append = 1400
--         NewValue = 1170
--         SortType = 1350
--         SortOrder = 1410
--         GroupBy = 1350
--         Filter = 1350
--         Or = 1350
--         Or = 1350
--         Or = 1350
--      End
--   End
--End
--' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_HFit_HealthAssesmentAnswers'
--GO

--EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_HFit_HealthAssesmentAnswers'
--GO




GO




if exists(select TABLE_NAME from INFORMATION_SCHEMA.VIEWS where TABLE_NAME = 'view_EDW_HealthAssesmentClientView')
BEGIN
	drop view view_EDW_HealthAssesmentClientView ;
END
GO

--GRANT SELECT
--	ON [dbo].[view_EDW_HealthAssesmentClientView]
--	TO [EDWReader_PRD]
--GO

--******************************************************************************
--8/8/2014 - Generated corrected view in DEV (WDM)
--09.11.2014 (wdm) added to facilitate EDW last mod date
--******************************************************************************
CREATE VIEW [dbo].[view_EDW_HealthAssesmentClientView]
AS
	SELECT
		HFitAcct.AccountID
		, HFitAcct.AccountCD
		, HFitAcct.AccountName
		, HFitAcct.ItemGUID AS ClientGuid
		, CMSSite.SiteGUID
		, NULL AS CompanyID
		, NULL AS CompanyGUID
		, NULL AS CompanyName
		, HAJoined.DocumentName
		, HACampaign.DocumentPublishFrom AS HAStartDate
		, HACampaign.DocumentPublishTo AS HAEndDate
		, HACampaign.NodeSiteID
		, HAAssessmentMod.Title
		, HAAssessmentMod.CodeName
		, HAAssessmentMod.IsEnabled
		, CASE	WHEN CAST(HACampaign.DocumentCreatedWhen AS DATE) = CAST(HACampaign.DocumentModifiedWhen AS DATE)
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		, HACampaign.DocumentCreatedWhen
		, HACampaign.DocumentModifiedWhen
		, HAAssessmentMod.DocumentModifiedWhen as AssesmentModule_DocumentModifiedWhen	--09.11.2014 (wdm) added to facilitate EDW last mod date
	FROM
		dbo.View_HFit_HACampaign_Joined AS HACampaign
	INNER JOIN dbo.CMS_Site AS CMSSite ON HACampaign.NodeSiteID = CMSSite.SiteID
	INNER JOIN dbo.HFit_Account AS HFitAcct ON HACampaign.NodeSiteID = HFitAcct.SiteID
	INNER JOIN dbo.View_HFit_HealthAssessment_Joined AS HAJoined ON ( CASE
									WHEN HACampaign.HealthAssessmentConfigurationID < 0
									THEN HACampaign.HealthAssessmentID
									ELSE HACampaign.HealthAssessmentConfigurationID
									END ) = HAJoined.DocumentID
	INNER JOIN dbo.View_HFit_HealthAssesmentModule_Joined AS HAAssessmentMod ON HAJoined.nodeid = HAAssessmentMod.NodeParentID



GO



if exists(select TABLE_NAME from INFORMATION_SCHEMA.VIEWS where TABLE_NAME = 'view_EDW_HealthAssesmentDeffinition')
BEGIN
	drop view view_EDW_HealthAssesmentDeffinition ;
END
GO


--GRANT SELECT
--	ON [dbo].[view_EDW_HealthAssesmentDeffinition]
--	TO [EDWReader_PRD]
--GO

--select * from [view_EDW_HealthAssesmentDeffinition] where DocumentModifiedWhen between '2013-11-14 00:00:00.000' and '2013-11-15 00:00:00.000'

create VIEW [dbo].[view_EDW_HealthAssesmentDeffinition] 
AS
/*
--*******************************************************************************
-- The following Indexes were identified as needed for performance.
--*******************************************************************************
IF NOT EXISTS
		(
			SELECT name
			FROM sysindexes
			WHERE NAME = 'IDX_View_CMS_Tree_Joined_Linked_NodeID_DocCulture'
		)
	BEGIN
		CREATE NONCLUSTERED INDEX IDX_View_CMS_Tree_Joined_Linked_NodeID_DocCulture
		ON [dbo].[View_CMS_Tree_Joined_Linked] ([NodeID],[DocumentCulture])
END
GO

IF NOT EXISTS
		(
			SELECT name
			FROM sysindexes
			WHERE NAME = 'IDX_View_CMS_Tree_Joined_Linked_NodeID_DocGuid'
		)
	BEGIN
		CREATE NONCLUSTERED INDEX IDX_View_CMS_Tree_Joined_Linked_NodeID_DocGuid
		ON [dbo].[View_CMS_Tree_Joined_Linked] ([ClassName])
		INCLUDE ([NodeID],[NodeParentID],[DocumentForeignKeyValue],[DocumentPublishedVersionHistoryID],[DocumentGUID])
END
GO

IF NOT EXISTS
		(
			SELECT name
			FROM sysindexes
			WHERE NAME = 'IDX_View_CMS_Tree_Joined_Regular_NodeID_DocGuid'
		)
	BEGIN
		CREATE NONCLUSTERED INDEX IDX_View_CMS_Tree_Joined_Regular_NodeID_DocGuid
		ON [dbo].[View_CMS_Tree_Joined_Regular] ([ClassName])
		INCLUDE ([NodeID],[NodeParentID],[DocumentForeignKeyValue],[DocumentPublishedVersionHistoryID],[DocumentGUID])
END
GO

IF NOT EXISTS
		(
			SELECT name
			FROM sysindexes
			WHERE NAME = 'IX_View_CMS_Tree_Joined_Regular_DocumentCulture_NodeID'
		)
	BEGIN
		CREATE NONCLUSTERED INDEX IX_View_CMS_Tree_Joined_Regular_DocumentCulture_NodeID
		ON [dbo].[View_CMS_Tree_Joined_Regular] ([NodeID],[DocumentCulture],DocumentGUID)
END
GO


IF NOT EXISTS
		(
			SELECT name
			FROM sysindexes
			WHERE NAME = 'PI_View_CMS_Tree_Joined_Regular_NodeSiteID_DocumentCulture_NodeID'
		)
	BEGIN
		CREATE INDEX PI_View_CMS_Tree_Joined_Regular_NodeSiteID_DocumentCulture_NodeID
		ON View_CMS_Tree_Joined_Regular
		(     [NodeSiteID] ASC 
			, [NodeID] ASC 
			, [NodeGUID]
			, [NodeParentID] ASC 
			, [DocumentCulture] ASC             
			, [DocumentID] ASC 
			, [DocumentPublishedVersionHistoryID] ASC 
		, [DocumentGUID]
		, [DocumentModifiedWhen]
		, [DocumentCreatedWhen]
		)
END
GO


IF NOT EXISTS
		(
			SELECT name
			FROM sysindexes
			WHERE NAME = 'PI_View_CMS_Tree_Joined_Linked_NodeSiteID_DocumentCulture_NodeID'
		)
	BEGIN
		CREATE  INDEX PI_View_CMS_Tree_Joined_Linked_NodeSiteID_DocumentCulture_NodeID
		ON View_CMS_Tree_Joined_Linked
		(     [NodeSiteID] ASC 
		, [DocumentCulture] ASC 
		, [NodeID] ASC 
		, [NodeGUID]
		, [DocumentModifiedWhen]
		, [DocumentCreatedWhen]
		)
 END
GO

IF NOT EXISTS
		(
			SELECT name
			FROM sysindexes
			WHERE NAME = 'PI_View_CMS_Tree_Joined_Regular_DocumentCulture'
		)
	BEGIN
		CREATE NONCLUSTERED INDEX [PI_View_CMS_Tree_Joined_Regular_DocumentCulture]
			ON [dbo].[View_CMS_Tree_Joined_Regular] ([NodeID],[DocumentCulture])
	END

*/
--*******************************************************************************************
--WDM - 6/25/2014
--Query was returning a NULL dataset. Found that it is being caused by the AccountCD join.
--Worked with Shane to discover the CMS Tree had been modified.
--Modified the code so that reads it reads the CMS tree correctly - working.
--7/14/2014 1:29 time to run - 79024 rows - DEV
--7/14/2014 0:58 time to run - 57472 rows - PROD1
--7/15/2014 - Query was returning NodeName of 'Campaigns' only
--	Found the issue in view View_HFit_HACampaign_Joined. Documented the change in the view.
--7/16/2014 - Full Select: Using a DocumentModifiedWhen filter 00:17:28 - Record Cnt: 793,520
--8/7/2014 - Executed in DEV with GUID changes and returned 1.13M Rows in 23:14.
--8/8/2014 - Executed in DEV with GUID changes, new views, and returned 1.13M Rows in 20:16.
--8/8/2014 - Generated corrected view in DEV
--8/12/2014 - John C. explained that Account Code and Site Guid are not needed, NULLED
--				them out. With them in the QRY, returned 43104 rows, with them nulled
--				out, returned 43104 rows. Using a DISTINCT, 28736 rows returned and execution
--				time doubled approximately.
--				Has to add a DISTINCT to all the queries - .
--				Original Query 0:25 @ 43104
--				Original Query 0:46 @ 28736 (distinct)
--				Filter added - VHFHAQ.DocumentCulture 0:22 @ 14368
--				Filter added - and VHFHARCJ.DocumentCulture = 'en-us'	 0:06 @ 3568
--				Filter added - and VHFHARAJ.DocumentCulture = 'en-us'	 0:03 @ 1784
--8/12/2014 - Applied the language filters with John C. and performance improved, as expected,
--				such that when running the view in QA: 
--*******************************************************************************************
--*********************************************************************************************************************
--select * from [view_EDW_HealthAssesmentDeffinition] where DocumentModifiedWhen between '2000-11-14' and '2014-11-15'
--08/12/2014 - ProdStaging 00:21:52 @ 2442
--08/12/2014 - ProdStaging 00:21:09 @ 13272 (UNION ALL   --UNION)
--08/12/2014 - ProdStaging 00:21:37 @ 13272 (UNION ONLY)
--08/12/2014 - ProdStaging 00:06:26 @ 1582 (UNION ONLY & Select Filters Added for Culture)
--08/12/2014 - ProdStaging 00:10:07 @ 6636 (UNION ALL   --UNION) and all selected
--08/12/2014 - ProdStaging added PI PI_View_CMS_Tree_Joined_Regular_DocumentCulture: 00:2:34 @ 6636 
--08/12/2014 - DEV 00:00:58 @ 3792
--09.11.2014 - (wdm) added the needed date fields to help EDW in determining the last mod date of a row.
--*********************************************************************************************************************

	SELECT distinct
		NULL as SiteGUID --cs.SiteGUID								--WDM 08.12.2014 per John C.
		, NULL as AccountCD	 --, HFA.AccountCD						--WDM 08.07.2014 per John C.
		, HA.NodeID AS HANodeID										--WDM 08.07.2014
		, HA.NodeName AS HANodeName									--WDM 08.07.2014
		, HA.DocumentID AS HADocumentID								--WDM 08.07.2014
		, HA.NodeSiteID AS HANodeSiteID								--WDM 08.07.2014
		, HA.DocumentPublishedVersionHistoryID AS HADocPubVerID		--WDM 08.07.2014
		, VHFHAMJ.Title AS ModTitle
		--Per EDW Team, HTML text is truncated to 4000 bytes - we'll just do it here
		, dbo.udf_StripHTML(left(VHFHAMJ.IntroText,4000)) AS IntroText
		, VHFHAMJ.DocumentGuid AS ModDocGuid	--, VHFHAMJ.DocumentID AS ModDocID	--WDM 08.07.2014
		, VHFHAMJ.Weight AS ModWeight
		, VHFHAMJ.IsEnabled AS ModIsEnabled
		, VHFHAMJ.CodeName AS ModCodeName
		, VHFHAMJ.DocumentPublishedVersionHistoryID AS ModDocPubVerID
		, VHFHARCJ.Title AS RCTitle
		, VHFHARCJ.Weight AS RCWeight
		, VHFHARCJ.DocumentGuid AS RCDocumentGUID	--, VHFHARCJ.DocumentID AS RCDocumentID	--WDM 08.07.2014
		, VHFHARCJ.IsEnabled AS RCIsEnabled
		, VHFHARCJ.CodeName AS RCCodeName
		, VHFHARCJ.DocumentPublishedVersionHistoryID AS RCDocPubVerID
		, VHFHARAJ.Title AS RATytle
		, VHFHARAJ.Weight AS RAWeight
		, VHFHARAJ.DocumentGuid AS RADocumentGuid	--, VHFHARAJ.DocumentID AS RADocumentID	--WDM 08.07.2014
		, VHFHARAJ.IsEnabled AS RAIsEnabled
		, VHFHARAJ.CodeName AS RACodeName
		, VHFHARAJ.ScoringStrategyID AS RAScoringStrategyID
		, VHFHARAJ.DocumentPublishedVersionHistoryID AS RADocPubVerID
		, VHFHAQ.QuestionType
		, dbo.udf_StripHTML(left(VHFHAQ.Title,4000)) AS QuesTitle
		, VHFHAQ.Weight AS QuesWeight
		, VHFHAQ.IsRequired AS QuesIsRequired

		, VHFHAQ.DocumentGuid AS QuesDocumentGuid	--, VHFHAQ.DocumentID AS QuesDocumentID	--WDM 08.07.2014
		
		, VHFHAQ.IsEnabled AS QuesIsEnabled
		, left(VHFHAQ.IsVisible,4000) AS QuesIsVisible
		, VHFHAQ.IsStaging AS QuesIsSTaging
		, VHFHAQ.CodeName AS QuestionCodeName
		, VHFHAQ.DocumentPublishedVersionHistoryID AS QuesDocPubVerID
		, VHFHAA.Value AS AnsValue
		, VHFHAA.Points AS AnsPoints
		
		, VHFHAA.DocumentGuid AS AnsDocumentGuid	--, VHFHAA.DocumentID AS AnsDocumentID	--WDM 08.07.2014
		
		, VHFHAA.IsEnabled AS AnsIsEnabled
		, VHFHAA.CodeName AS AnsCodeName
		, VHFHAA.UOM AS AnsUOM
		, VHFHAA.DocumentPublishedVersionHistoryID AS AnsDocPUbVerID
		, CASE	WHEN CAST(VCTJ.DocumentCreatedWhen AS DATE) = CAST(vctj.DocumentModifiedWhen AS DATE)
			THEN 'I'
			ELSE 'U'
		END AS ChangeType
		, VCTJ.DocumentCreatedWhen
		, VCTJ.DocumentModifiedWhen
		, VCTJ.NodeGuid as CmsTreeNodeGuid	--WDM 08.07.2014 ADDED TO the returned Columns
		, HA.NodeGUID as HANodeGUID

		, CS.SiteLastModified
		, hfa.ItemModifiedWhen as Account_ItemModifiedWhen
		, c.DocumentModifiedWhen as Campaign_DocumentModifiedWhen
		, HA.DocumentModifiedWhen as Assessment_DocumentModifiedWhen
		, VHFHAMJ.DocumentModifiedWhen as Module_DocumentModifiedWhen
		, VHFHARCJ.DocumentModifiedWhen as RiskCategory_DocumentModifiedWhen
		, VHFHARAJ.DocumentModifiedWhen as RiskArea_DocumentModifiedWhen
		, VHFHAQ.DocumentModifiedWhen as Question_DocumentModifiedWhen
		, VHFHAA.DocumentModifiedWhen as Answer_DocumentModifiedWhen
	 FROM
		dbo.View_CMS_Tree_Joined AS VCTJ
		INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
		INNER JOIN HFit_Account hfa WITH(NOLOCK) ON cs.SiteID = hfa.SiteID
 
		--Campaign links Client which links to Assessment
		INNER JOIN dbo.View_HFit_HACampaign_Joined as c WITH(NOLOCK) ON VCTJ.NodeID = c.NodeParentID
 
		INNER JOIN View_HFit_HealthAssessment_Joined as HA WITH (NOLOCK) ON c.HealthAssessmentID = HA.DocumentID
		--WDM 08.07.2014
		INNER JOIN dbo.View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ ON HA.NodeID = VHFHAMJ.NodeParentID		
		INNER JOIN dbo.View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
		INNER JOIN dbo.View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
		INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
		LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA ON VHFHAQ.NodeID = VHFHAA.NodeParentID
	where VCTJ.DocumentCulture = 'en-us'	--WDM 08.07.2014
		and VHFHAQ.DocumentCulture = 'en-us'	--WDM 08.12.2014	
		and (VHFHAA.DocumentCulture = 'en-us' OR VHFHAA.DocumentCulture is null)	--WDM 08.12.2014		
		and VHFHARCJ.DocumentCulture = 'en-us'	--WDM 08.12.2014		
		and VHFHARAJ.DocumentCulture = 'en-us'	--WDM 08.12.2014		
		and VHFHAMJ.DocumentCulture = 'en-us'	--WDM 08.12.2014		

UNION ALL   --UNION
--WDM Retrieve Matrix Level 1 Question Group
	SELECT distinct
		NULL as SiteGUID --cs.SiteGUID		--WDM 08.12.2014
		, NULL as AccountCD	 --, HFA.AccountCD												--WDM 08.07.2014
		, HA.NodeID		--WDM 08.07.2014
		, HA.NodeName		--WDM 08.07.2014
		, HA.DocumentID		--WDM 08.07.2014
		, HA.NodeSiteID		--WDM 08.07.2014
       --,VCTJ.NodeAliasPath
		, HA.DocumentPublishedVersionHistoryID		--WDM 08.07.2014
		, VHFHAMJ.Title
		, dbo.udf_StripHTML(left(left(VHFHAMJ.IntroText,4000),4000)) AS IntroText
		, VHFHAMJ.DocumentGUID
		, VHFHAMJ.Weight
		, VHFHAMJ.IsEnabled
		, VHFHAMJ.CodeName
       --,VHFHAMJ.NodeAliasPath
		, VHFHAMJ.DocumentPublishedVersionHistoryID
		, VHFHARCJ.Title
		, VHFHARCJ.Weight
		, VHFHARCJ.DocumentGUID
		, VHFHARCJ.IsEnabled
		, VHFHARCJ.CodeName
       --,VHFHARCJ.NodeAliasPath
		, VHFHARCJ.DocumentPublishedVersionHistoryID
		, VHFHARAJ.Title
		, VHFHARAJ.Weight
		, VHFHARAJ.DocumentGUID
		, VHFHARAJ.IsEnabled
		, VHFHARAJ.CodeName
       --,VHFHARAJ.NodeAliasPath
		, VHFHARAJ.ScoringStrategyID
		, VHFHARAJ.DocumentPublishedVersionHistoryID
		, VHFHAQ2.QuestionType
		, dbo.udf_StripHTML(left(VHFHAQ2.Title,4000)) AS QuesTitle
		, VHFHAQ2.Weight
		, VHFHAQ2.IsRequired
		, VHFHAQ2.DocumentGUID
		, VHFHAQ2.IsEnabled
		, left(VHFHAQ2.IsVisible,4000)
		, VHFHAQ2.IsStaging
		, VHFHAQ2.CodeName AS QuestionCodeName
       --,VHFHAQ2.NodeAliasPath
		, VHFHAQ2.DocumentPublishedVersionHistoryID
		, VHFHAA2.Value
		, VHFHAA2.Points
		, VHFHAA2.DocumentGUID
		, VHFHAA2.IsEnabled
		, VHFHAA2.CodeName
		, VHFHAA2.UOM
       --,VHFHAA2.NodeAliasPath
		, VHFHAA2.DocumentPublishedVersionHistoryID
		, CASE	WHEN CAST(VCTJ.DocumentCreatedWhen AS DATE) = CAST(vctj.DocumentModifiedWhen AS DATE)
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		, VCTJ.DocumentCreatedWhen
		, VCTJ.DocumentModifiedWhen
		, VCTJ.NodeGuid as CmsTreeNodeGuid	--WDM 08.07.2014
		, HA.NodeGUID as HANodeGUID
	 
		, CS.SiteLastModified
		, hfa.ItemModifiedWhen as Account_ItemModifiedWhen
		, c.DocumentModifiedWhen as Campaign_DocumentModifiedWhen
		, HA.DocumentModifiedWhen as Assessment_DocumentModifiedWhen
		, VHFHAMJ.DocumentModifiedWhen as Module_DocumentModifiedWhen
		, VHFHARCJ.DocumentModifiedWhen as RiskCategory_DocumentModifiedWhen
		, VHFHARAJ.DocumentModifiedWhen as RiskArea_DocumentModifiedWhen
		, VHFHAQ.DocumentModifiedWhen as Question_DocumentModifiedWhen
		, VHFHAA.DocumentModifiedWhen as Answer_DocumentModifiedWhen
	FROM
  dbo.View_CMS_Tree_Joined AS VCTJ
 INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
 INNER JOIN HFit_Account hfa WITH(NOLOCK) ON cs.SiteID = hfa.SiteID
 INNER JOIN dbo.View_HFit_HACampaign_Joined c WITH(NOLOCK) ON VCTJ.NodeID = c.NodeParentID
 INNER JOIN View_HFit_HealthAssessment_Joined HA WITH (NOLOCK) ON c.HealthAssessmentID = HA.DocumentID
 INNER JOIN dbo.View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ ON HA.NodeID = VHFHAMJ.NodeParentID
 INNER JOIN dbo.View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
 INNER JOIN dbo.View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
 INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
 LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA ON VHFHAQ.NodeID = VHFHAA.NodeParentID
--matrix level 1 questiongroup
	INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ2 ON VHFHAQ.NodeID = VHFHAQ2.NodeParentID
	INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA2 ON VHFHAQ2.NodeID = VHFHAA2.NodeParentID
where VCTJ.DocumentCulture = 'en-us'	--WDM 08.07.2014
and VHFHAQ.DocumentCulture = 'en-us'	
		and (VHFHAA.DocumentCulture = 'en-us' OR VHFHAA.DocumentCulture is null)	--WDM 08.12.2014		
		and VHFHARCJ.DocumentCulture = 'en-us'	
		and VHFHARAJ.DocumentCulture = 'en-us'	
		and VHFHAMJ.DocumentCulture = 'en-us'	--WDM 08.12.2014		

UNION ALL   --UNION
--WDM Retrieve Branching Level 1 Question and Matrix Level 1 Question Group
	SELECT distinct
		NULL as SiteGUID --cs.SiteGUID		--WDM 08.12.2014
		, NULL as AccountCD	 --, HFA.AccountCD												--WDM 08.07.2014
		, HA.NodeID		--WDM 08.07.2014
		, HA.NodeName		--WDM 08.07.2014
		, HA.DocumentID		--WDM 08.07.2014
		, HA.NodeSiteID		--WDM 08.07.2014
       --,VCTJ.NodeAliasPath
		, HA.DocumentPublishedVersionHistoryID		--WDM 08.07.2014
		, VHFHAMJ.Title
		, dbo.udf_StripHTML(left(VHFHAMJ.IntroText,4000)) AS IntroText
		, VHFHAMJ.DocumentGUID
		, VHFHAMJ.Weight
		, VHFHAMJ.IsEnabled
		, VHFHAMJ.CodeName
       --,VHFHAMJ.NodeAliasPath
		, VHFHAMJ.DocumentPublishedVersionHistoryID
		, VHFHARCJ.Title
		, VHFHARCJ.Weight
		, VHFHARCJ.DocumentGUID
		, VHFHARCJ.IsEnabled
		, VHFHARCJ.CodeName
       --,VHFHARCJ.NodeAliasPath
		, VHFHARCJ.DocumentPublishedVersionHistoryID
		, VHFHARAJ.Title
		, VHFHARAJ.Weight
		, VHFHARAJ.DocumentGUID
		, VHFHARAJ.IsEnabled
		, VHFHARAJ.CodeName
       --,VHFHARAJ.NodeAliasPath
		, VHFHARAJ.ScoringStrategyID
		, VHFHARAJ.DocumentPublishedVersionHistoryID
		, VHFHAQ3.QuestionType
		, dbo.udf_StripHTML(left(VHFHAQ3.Title,4000)) AS QuesTitle
		, VHFHAQ3.Weight
		, VHFHAQ3.IsRequired
		, VHFHAQ3.DocumentGUID
		, VHFHAQ3.IsEnabled
		, left(VHFHAQ3.IsVisible,4000)
		, VHFHAQ3.IsStaging
		, VHFHAQ3.CodeName AS QuestionCodeName
       --,VHFHAQ3.NodeAliasPath
		, VHFHAQ3.DocumentPublishedVersionHistoryID
		, VHFHAA3.Value
		, VHFHAA3.Points
		, VHFHAA3.DocumentGUID
		, VHFHAA3.IsEnabled
		, VHFHAA3.CodeName
		, VHFHAA3.UOM
       --,VHFHAA3.NodeAliasPath
		, VHFHAA3.DocumentPublishedVersionHistoryID
		, CASE	WHEN CAST(VCTJ.DocumentCreatedWhen AS DATE) = CAST(vctj.DocumentModifiedWhen AS DATE)
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		, VCTJ.DocumentCreatedWhen
		, VCTJ.DocumentModifiedWhen
		, VCTJ.NodeGuid as CmsTreeNodeGuid	--WDM 08.07.2014
		, HA.NodeGUID as HANodeGUID
 
		, CS.SiteLastModified
		, hfa.ItemModifiedWhen as Account_ItemModifiedWhen
		, c.DocumentModifiedWhen as Campaign_DocumentModifiedWhen
		, HA.DocumentModifiedWhen as Assessment_DocumentModifiedWhen
		, VHFHAMJ.DocumentModifiedWhen as Module_DocumentModifiedWhen
		, VHFHARCJ.DocumentModifiedWhen as RiskCategory_DocumentModifiedWhen
		, VHFHARAJ.DocumentModifiedWhen as RiskArea_DocumentModifiedWhen
		, VHFHAQ.DocumentModifiedWhen as Question_DocumentModifiedWhen
		, VHFHAA.DocumentModifiedWhen as Answer_DocumentModifiedWhen
FROM
  dbo.View_CMS_Tree_Joined AS VCTJ

 INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
 INNER JOIN HFit_Account hfa WITH(NOLOCK) ON cs.SiteID = hfa.SiteID
 INNER JOIN dbo.View_HFit_HACampaign_Joined c WITH(NOLOCK) ON VCTJ.NodeID = c.NodeParentID
 INNER JOIN View_HFit_HealthAssessment_Joined HA WITH (NOLOCK) ON c.HealthAssessmentID = HA.DocumentID
 INNER JOIN dbo.View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ ON HA.NodeID = VHFHAMJ.NodeParentID
 INNER JOIN dbo.View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
 INNER JOIN dbo.View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
 INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
 LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA ON VHFHAQ.NodeID = VHFHAA.NodeParentID

--matrix level 1 questiongroup
--INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ2 ON VHFHAQ.NodeID = VHFHAQ2.NodeParentID
--INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA2 ON VHFHAQ2.NodeID = VHFHAA2.NodeParentID

--Branching Level 1 Question 
	INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ3 ON VHFHAA.NodeID = VHFHAQ3.NodeParentID
	LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA3 ON VHFHAQ3.NodeID = VHFHAA3.NodeParentID
where VCTJ.DocumentCulture = 'en-us'	--WDM 08.07.2014
and VHFHAQ.DocumentCulture = 'en-us'	
		and (VHFHAA.DocumentCulture = 'en-us' OR VHFHAA.DocumentCulture is null)	--WDM 08.12.2014		
		and VHFHARCJ.DocumentCulture = 'en-us'	
		and VHFHARAJ.DocumentCulture = 'en-us'	
		and VHFHAMJ.DocumentCulture = 'en-us'	--WDM 08.12.2014		

UNION ALL   --UNION
--WDM Retrieve Branching Level 1 Question and Matrix Level 2 Question Group
	SELECT distinct
		NULL as SiteGUID --cs.SiteGUID		--WDM 08.12.2014
		, NULL as AccountCD	 --, HFA.AccountCD												--WDM 08.07.2014
		, HA.NodeID		--WDM 08.07.2014
		, HA.NodeName		--WDM 08.07.2014
		, HA.DocumentID		--WDM 08.07.2014
		, HA.NodeSiteID		--WDM 08.07.2014
       --,VCTJ.NodeAliasPath
		, HA.DocumentPublishedVersionHistoryID		--WDM 08.07.2014
		, VHFHAMJ.Title
		, dbo.udf_StripHTML(left(VHFHAMJ.IntroText,4000)) AS IntroText
		, VHFHAMJ.DocumentGUID
		, VHFHAMJ.Weight
		, VHFHAMJ.IsEnabled
		, VHFHAMJ.CodeName
       --,VHFHAMJ.NodeAliasPath
		, VHFHAMJ.DocumentPublishedVersionHistoryID
		, VHFHARCJ.Title
		, VHFHARCJ.Weight
		, VHFHARCJ.DocumentGUID
		, VHFHARCJ.IsEnabled
		, VHFHARCJ.CodeName
       --,VHFHARCJ.NodeAliasPath
		, VHFHARCJ.DocumentPublishedVersionHistoryID
		, VHFHARAJ.Title
		, VHFHARAJ.Weight
		, VHFHARAJ.DocumentGUID
		, VHFHARAJ.IsEnabled
		, VHFHARAJ.CodeName
       --,VHFHARAJ.NodeAliasPath
		, VHFHARAJ.ScoringStrategyID
		, VHFHARAJ.DocumentPublishedVersionHistoryID
		, VHFHAQ7.QuestionType
		, dbo.udf_StripHTML(left(VHFHAQ7.Title,4000)) AS QuesTitle
		, VHFHAQ7.Weight
		, VHFHAQ7.IsRequired
		, VHFHAQ7.DocumentGUID
		, VHFHAQ7.IsEnabled
		, left(VHFHAQ7.IsVisible,4000)
		, VHFHAQ7.IsStaging
		, VHFHAQ7.CodeName AS QuestionCodeName
       --,VHFHAQ7.NodeAliasPath
		, VHFHAQ7.DocumentPublishedVersionHistoryID
		, VHFHAA7.Value
		, VHFHAA7.Points
		, VHFHAA7.DocumentGUID
		, VHFHAA7.IsEnabled
		, VHFHAA7.CodeName
		, VHFHAA7.UOM
       --,VHFHAA7.NodeAliasPath
		, VHFHAA7.DocumentPublishedVersionHistoryID
		, CASE	WHEN CAST(VCTJ.DocumentCreatedWhen AS DATE) = CAST(vctj.DocumentModifiedWhen AS DATE)
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		, VCTJ.DocumentCreatedWhen
		, VCTJ.DocumentModifiedWhen
		, VCTJ.NodeGuid as CmsTreeNodeGuid	--WDM 08.07.2014
		, HA.NodeGUID as HANodeGUID
 
		, CS.SiteLastModified
		, hfa.ItemModifiedWhen as Account_ItemModifiedWhen
		, c.DocumentModifiedWhen as Campaign_DocumentModifiedWhen
		, HA.DocumentModifiedWhen as Assessment_DocumentModifiedWhen
		, VHFHAMJ.DocumentModifiedWhen as Module_DocumentModifiedWhen
		, VHFHARCJ.DocumentModifiedWhen as RiskCategory_DocumentModifiedWhen
		, VHFHARAJ.DocumentModifiedWhen as RiskArea_DocumentModifiedWhen
		, VHFHAQ.DocumentModifiedWhen as Question_DocumentModifiedWhen
		, VHFHAA.DocumentModifiedWhen as Answer_DocumentModifiedWhen
FROM
 dbo.View_CMS_Tree_Joined AS VCTJ
 INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
 INNER JOIN HFit_Account hfa WITH(NOLOCK) ON cs.SiteID = hfa.SiteID
 INNER JOIN dbo.View_HFit_HACampaign_Joined c WITH(NOLOCK) ON VCTJ.NodeID = c.NodeParentID
 INNER JOIN View_HFit_HealthAssessment_Joined HA WITH (NOLOCK) ON c.HealthAssessmentID = HA.DocumentID
 INNER JOIN dbo.View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ ON HA.NodeID = VHFHAMJ.NodeParentID
 INNER JOIN dbo.View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
 INNER JOIN dbo.View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
 INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
 LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA ON VHFHAQ.NodeID = VHFHAA.NodeParentID

--matrix level 1 questiongroup
--INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ2 ON VHFHAQ.NodeID = VHFHAQ2.NodeParentID
--INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA2 ON VHFHAQ2.NodeID = VHFHAA2.NodeParentID

--Branching Level 1 Question 
	INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ3 ON VHFHAA.NodeID = VHFHAQ3.NodeParentID
--LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA3 ON VHFHAQ3.NodeID = VHFHAA3.NodeParentID

--Matrix Level 2 Question Group
	INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ7 ON VHFHAQ3.NodeID = VHFHAQ7.NodeParentID
	INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA7 ON VHFHAQ7.NodeID = VHFHAA7.NodeParentID
where VCTJ.DocumentCulture = 'en-us'	--WDM 08.07.2014
and VHFHAQ.DocumentCulture = 'en-us'	
		and (VHFHAA.DocumentCulture = 'en-us' OR VHFHAA.DocumentCulture is null)	--WDM 08.12.2014		
		and VHFHARCJ.DocumentCulture = 'en-us'	
		and VHFHARAJ.DocumentCulture = 'en-us'	
		and VHFHAMJ.DocumentCulture = 'en-us'	--WDM 08.12.2014		

UNION ALL   --UNION
	--****************************************************
	--WDM 6/25/2014 Retrieve the Branching level 1 Question Group
	--THE PROBLEM LIES HERE in this part of query : 1:40 minute
	-- Added two perf indexes to the first query: 25 Sec
	--****************************************************
	SELECT distinct
		NULL as SiteGUID --cs.SiteGUID		--WDM 08.12.2014
		, NULL as AccountCD	 --, HFA.AccountCD												--WDM 08.07.2014
		, HA.NodeID		--WDM 08.07.2014
		, HA.NodeName		--WDM 08.07.2014
		, HA.DocumentID		--WDM 08.07.2014
		, HA.NodeSiteID		--WDM 08.07.2014
       --,VCTJ.NodeAliasPath
		, HA.DocumentPublishedVersionHistoryID		--WDM 08.07.2014
		, VHFHAMJ.Title
		, dbo.udf_StripHTML(left(VHFHAMJ.IntroText,4000)) AS IntroText
		, VHFHAMJ.DocumentGUID
		, VHFHAMJ.Weight
		, VHFHAMJ.IsEnabled
		, VHFHAMJ.CodeName
       --,VHFHAMJ.NodeAliasPath
		, VHFHAMJ.DocumentPublishedVersionHistoryID
		, VHFHARCJ.Title
		, VHFHARCJ.Weight
		, VHFHARCJ.DocumentGUID
		, VHFHARCJ.IsEnabled
		, VHFHARCJ.CodeName
       --,VHFHARCJ.NodeAliasPath
		, VHFHARCJ.DocumentPublishedVersionHistoryID
		, VHFHARAJ.Title
		, VHFHARAJ.Weight
		, VHFHARAJ.DocumentGUID
		, VHFHARAJ.IsEnabled
		, VHFHARAJ.CodeName
       --,VHFHARAJ.NodeAliasPath
		, VHFHARAJ.ScoringStrategyID
		, VHFHARAJ.DocumentPublishedVersionHistoryID
		, VHFHAQ8.QuestionType
		, dbo.udf_StripHTML(left(VHFHAQ8.Title,4000)) AS QuesTitle
		, VHFHAQ8.Weight
		, VHFHAQ8.IsRequired
		, VHFHAQ8.DocumentGUID
		, VHFHAQ8.IsEnabled
		, left(VHFHAQ8.IsVisible,4000)
		, VHFHAQ8.IsStaging
		, VHFHAQ8.CodeName AS QuestionCodeName
       --,VHFHAQ8.NodeAliasPath
		, VHFHAQ8.DocumentPublishedVersionHistoryID
		, VHFHAA8.Value
		, VHFHAA8.Points
		, VHFHAA8.DocumentGUID
		, VHFHAA8.IsEnabled
		, VHFHAA8.CodeName
		, VHFHAA8.UOM
       --,VHFHAA8.NodeAliasPath
		, VHFHAA8.DocumentPublishedVersionHistoryID
		, CASE	WHEN CAST(VCTJ.DocumentCreatedWhen AS DATE) = CAST(vctj.DocumentModifiedWhen AS DATE)
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		, VCTJ.DocumentCreatedWhen
		, VCTJ.DocumentModifiedWhen
		, VCTJ.NodeGuid as CmsTreeNodeGuid	--WDM 08.07.2014
		, HA.NodeGUID as HANodeGUID
	
		, CS.SiteLastModified
		, hfa.ItemModifiedWhen as Account_ItemModifiedWhen
		, c.DocumentModifiedWhen as Campaign_DocumentModifiedWhen
		, HA.DocumentModifiedWhen as Assessment_DocumentModifiedWhen
		, VHFHAMJ.DocumentModifiedWhen as Module_DocumentModifiedWhen
		, VHFHARCJ.DocumentModifiedWhen as RiskCategory_DocumentModifiedWhen
		, VHFHARAJ.DocumentModifiedWhen as RiskArea_DocumentModifiedWhen
		, VHFHAQ.DocumentModifiedWhen as Question_DocumentModifiedWhen
		, VHFHAA.DocumentModifiedWhen as Answer_DocumentModifiedWhen
FROM
  dbo.View_CMS_Tree_Joined AS VCTJ

 INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
 INNER JOIN HFit_Account hfa WITH(NOLOCK) ON cs.SiteID = hfa.SiteID
 INNER JOIN dbo.View_HFit_HACampaign_Joined c WITH(NOLOCK) ON VCTJ.NodeID = c.NodeParentID
 INNER JOIN View_HFit_HealthAssessment_Joined HA WITH (NOLOCK) ON c.HealthAssessmentID = HA.DocumentID
 INNER JOIN dbo.View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ ON HA.NodeID = VHFHAMJ.NodeParentID
 INNER JOIN dbo.View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
 INNER JOIN dbo.View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
 INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
 LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA ON VHFHAQ.NodeID = VHFHAA.NodeParentID

			--matrix level 1 questiongroup
			--INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ2 ON VHFHAQ.NodeID = VHFHAQ2.NodeParentID
			--INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA2 ON VHFHAQ2.NodeID = VHFHAA2.NodeParentID

			--Branching Level 1 Question 
			INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ3 ON VHFHAA.NodeID = VHFHAQ3.NodeParentID
			--LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA3 ON VHFHAQ3.NodeID = VHFHAA3.NodeParentID

			--Matrix Level 2 Question Group
			INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ7 ON VHFHAQ3.NodeID = VHFHAQ7.NodeParentID
			INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA7 ON VHFHAQ7.NodeID = VHFHAA7.NodeParentID

			--Matrix branching level 1 question group
			INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ8 ON VHFHAA7.NodeID = VHFHAQ8.NodeParentID
			INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA8 ON VHFHAQ8.NodeID = VHFHAA8.NodeParentID
where VCTJ.DocumentCulture = 'en-us'	--WDM 08.07.2014
and VHFHAQ.DocumentCulture = 'en-us'	
		and (VHFHAA.DocumentCulture = 'en-us' OR VHFHAA.DocumentCulture is null)	--WDM 08.12.2014		
		and VHFHARCJ.DocumentCulture = 'en-us'	
		and VHFHARAJ.DocumentCulture = 'en-us'	
		and VHFHAMJ.DocumentCulture = 'en-us'	--WDM 08.12.2014		

UNION ALL   --UNION
	--****************************************************
	--WDM 6/25/2014 Retrieve the Branching level 2 Question Group
	--THE PROBLEM LIES HERE in this part of query : 1:48  minutes
	--With the new indexes: 29 Secs
	--****************************************************
	SELECT distinct
		NULL as SiteGUID --cs.SiteGUID		--WDM 08.12.2014
		, NULL as AccountCD	 --, HFA.AccountCD												--WDM 08.07.2014
		, HA.NodeID		--WDM 08.07.2014
		, HA.NodeName		--WDM 08.07.2014
		, HA.DocumentID		--WDM 08.07.2014
		, HA.NodeSiteID		--WDM 08.07.2014
       --,VCTJ.NodeAliasPath
		, HA.DocumentPublishedVersionHistoryID		--WDM 08.07.2014
		, VHFHAMJ.Title
		, dbo.udf_StripHTML(left(VHFHAMJ.IntroText,4000)) AS IntroText
		, VHFHAMJ.DocumentGUID
		, VHFHAMJ.Weight
		, VHFHAMJ.IsEnabled
		, VHFHAMJ.CodeName
       --,VHFHAMJ.NodeAliasPath
		, VHFHAMJ.DocumentPublishedVersionHistoryID
		, VHFHARCJ.Title
		, VHFHARCJ.Weight
		, VHFHARCJ.DocumentGUID
		, VHFHARCJ.IsEnabled
		, VHFHARCJ.CodeName
       --,VHFHARCJ.NodeAliasPath
		, VHFHARCJ.DocumentPublishedVersionHistoryID
		, VHFHARAJ.Title
		, VHFHARAJ.Weight
		, VHFHARAJ.DocumentGUID
		, VHFHARAJ.IsEnabled
		, VHFHARAJ.CodeName
       --,VHFHARAJ.NodeAliasPath
		, VHFHARAJ.ScoringStrategyID
		, VHFHARAJ.DocumentPublishedVersionHistoryID
		, VHFHAQ4.QuestionType
		, dbo.udf_StripHTML(left(VHFHAQ4.Title,4000)) AS QuesTitle
		, VHFHAQ4.Weight
		, VHFHAQ4.IsRequired
		, VHFHAQ4.DocumentGUID
		, VHFHAQ4.IsEnabled
		, left(VHFHAQ4.IsVisible,4000)
		, VHFHAQ4.IsStaging
		, VHFHAQ4.CodeName AS QuestionCodeName
       --,VHFHAQ4.NodeAliasPath
		, VHFHAQ4.DocumentPublishedVersionHistoryID
		, VHFHAA4.Value
		, VHFHAA4.Points
		, VHFHAA4.DocumentGUID
		, VHFHAA4.IsEnabled
		, VHFHAA4.CodeName
		, VHFHAA4.UOM
       --,VHFHAA4.NodeAliasPath
		, VHFHAA4.DocumentPublishedVersionHistoryID
		, CASE	WHEN CAST(VCTJ.DocumentCreatedWhen AS DATE) = CAST(vctj.DocumentModifiedWhen AS DATE)
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		, VCTJ.DocumentCreatedWhen
		, VCTJ.DocumentModifiedWhen
		, VCTJ.NodeGuid as CmsTreeNodeGuid	--WDM 08.07.2014
		, HA.NodeGUID as HANodeGUID
 
		, CS.SiteLastModified
		, hfa.ItemModifiedWhen as Account_ItemModifiedWhen
		, c.DocumentModifiedWhen as Campaign_DocumentModifiedWhen
		, HA.DocumentModifiedWhen as Assessment_DocumentModifiedWhen
		, VHFHAMJ.DocumentModifiedWhen as Module_DocumentModifiedWhen
		, VHFHARCJ.DocumentModifiedWhen as RiskCategory_DocumentModifiedWhen
		, VHFHARAJ.DocumentModifiedWhen as RiskArea_DocumentModifiedWhen
		, VHFHAQ.DocumentModifiedWhen as Question_DocumentModifiedWhen
		, VHFHAA.DocumentModifiedWhen as Answer_DocumentModifiedWhen
FROM
  dbo.View_CMS_Tree_Joined AS VCTJ

 INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
 INNER JOIN HFit_Account hfa WITH(NOLOCK) ON cs.SiteID = hfa.SiteID
 INNER JOIN dbo.View_HFit_HACampaign_Joined c WITH(NOLOCK) ON VCTJ.NodeID = c.NodeParentID
 INNER JOIN View_HFit_HealthAssessment_Joined HA WITH (NOLOCK) ON c.HealthAssessmentID = HA.DocumentID
 INNER JOIN dbo.View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ ON HA.NodeID = VHFHAMJ.NodeParentID
 INNER JOIN dbo.View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
 INNER JOIN dbo.View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
 INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
 LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA ON VHFHAQ.NodeID = VHFHAA.NodeParentID

			--matrix level 1 questiongroup
			--INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ2 ON VHFHAQ.NodeID = VHFHAQ2.NodeParentID
			--INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA2 ON VHFHAQ2.NodeID = VHFHAA2.NodeParentID

			--Branching Level 1 Question 
			INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ3 ON VHFHAA.NodeID = VHFHAQ3.NodeParentID
			LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA3 ON VHFHAQ3.NodeID = VHFHAA3.NodeParentID

			--Matrix Level 2 Question Group
			--INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ7 ON VHFHAQ3.NodeID = VHFHAQ7.NodeParentID
			--INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA7 ON VHFHAQ7.NodeID = VHFHAA7.NodeParentID

			--Matrix branching level 1 question group
			--INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ8 ON VHFHAA7.NodeID = VHFHAQ8.NodeParentID
			--INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA8 ON VHFHAQ8.NodeID = VHFHAA8.NodeParentID

			--Branching level 2 Question Group
			INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ4 ON VHFHAA3.NodeID = VHFHAQ4.NodeParentID
			INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA4 ON VHFHAQ4.NodeID = VHFHAA4.NodeParentID
where VCTJ.DocumentCulture = 'en-us'	--WDM 08.07.2014
and VHFHAQ.DocumentCulture = 'en-us'	
		and (VHFHAA.DocumentCulture = 'en-us' OR VHFHAA.DocumentCulture is null)	--WDM 08.12.2014		
		and VHFHARCJ.DocumentCulture = 'en-us'	
		and VHFHARAJ.DocumentCulture = 'en-us'	
		and VHFHAMJ.DocumentCulture = 'en-us'	--WDM 08.12.2014		

UNION ALL   --UNION
--WDM 6/25/2014 Retrieve the Branching level 3 Question Group
	SELECT distinct
		NULL as SiteGUID --cs.SiteGUID		--WDM 08.12.2014
		, NULL as AccountCD	 --, HFA.AccountCD												--WDM 08.07.2014
		, HA.NodeID		--WDM 08.07.2014
		, HA.NodeName		--WDM 08.07.2014
		, HA.DocumentID		--WDM 08.07.2014
		, HA.NodeSiteID		--WDM 08.07.2014
       --,VCTJ.NodeAliasPath
		, HA.DocumentPublishedVersionHistoryID		--WDM 08.07.2014
		, VHFHAMJ.Title
		, dbo.udf_StripHTML(left(VHFHAMJ.IntroText,4000)) AS IntroText
		, VHFHAMJ.DocumentGUID
		, VHFHAMJ.Weight
		, VHFHAMJ.IsEnabled
		, VHFHAMJ.CodeName
       --,VHFHAMJ.NodeAliasPath
		, VHFHAMJ.DocumentPublishedVersionHistoryID
		, VHFHARCJ.Title
		, VHFHARCJ.Weight
		, VHFHARCJ.DocumentGUID
		, VHFHARCJ.IsEnabled
		, VHFHARCJ.CodeName
       --,VHFHARCJ.NodeAliasPath
		, VHFHARCJ.DocumentPublishedVersionHistoryID
		, VHFHARAJ.Title
		, VHFHARAJ.Weight
		, VHFHARAJ.DocumentGUID
		, VHFHARAJ.IsEnabled
		, VHFHARAJ.CodeName
       --,VHFHARAJ.NodeAliasPath
		, VHFHARAJ.ScoringStrategyID
		, VHFHARAJ.DocumentPublishedVersionHistoryID
		, VHFHAQ5.QuestionType
		, dbo.udf_StripHTML(left(VHFHAQ5.Title,4000)) AS QuesTitle
		, VHFHAQ5.Weight
		, VHFHAQ5.IsRequired
		, VHFHAQ5.DocumentGUID
		, VHFHAQ5.IsEnabled
		, left(VHFHAQ5.IsVisible,4000)
		, VHFHAQ5.IsStaging
		, VHFHAQ5.CodeName AS QuestionCodeName
       --,VHFHAQ5.NodeAliasPath
		, VHFHAQ5.DocumentPublishedVersionHistoryID
		, VHFHAA5.Value
		, VHFHAA5.Points
		, VHFHAA5.DocumentGUID
		, VHFHAA5.IsEnabled
		, VHFHAA5.CodeName
		, VHFHAA5.UOM
       --,VHFHAA5.NodeAliasPath
		, VHFHAA5.DocumentPublishedVersionHistoryID
		, CASE	WHEN CAST(VCTJ.DocumentCreatedWhen AS DATE) = CAST(vctj.DocumentModifiedWhen AS DATE)
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		, VCTJ.DocumentCreatedWhen
		, VCTJ.DocumentModifiedWhen
		, VCTJ.NodeGuid as CmsTreeNodeGuid	--WDM 08.07.2014
		, HA.NodeGUID as HANodeGUID
 
		, CS.SiteLastModified
		, hfa.ItemModifiedWhen as Account_ItemModifiedWhen
		, c.DocumentModifiedWhen as Campaign_DocumentModifiedWhen
		, HA.DocumentModifiedWhen as Assessment_DocumentModifiedWhen
		, VHFHAMJ.DocumentModifiedWhen as Module_DocumentModifiedWhen
		, VHFHARCJ.DocumentModifiedWhen as RiskCategory_DocumentModifiedWhen
		, VHFHARAJ.DocumentModifiedWhen as RiskArea_DocumentModifiedWhen
		, VHFHAQ.DocumentModifiedWhen as Question_DocumentModifiedWhen
		, VHFHAA.DocumentModifiedWhen as Answer_DocumentModifiedWhen
FROM
  dbo.View_CMS_Tree_Joined AS VCTJ

 INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
 INNER JOIN HFit_Account hfa WITH(NOLOCK) ON cs.SiteID = hfa.SiteID
 INNER JOIN dbo.View_HFit_HACampaign_Joined c WITH(NOLOCK) ON VCTJ.NodeID = c.NodeParentID
 INNER JOIN View_HFit_HealthAssessment_Joined HA WITH (NOLOCK) ON c.HealthAssessmentID = HA.DocumentID
 INNER JOIN dbo.View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ ON HA.NodeID = VHFHAMJ.NodeParentID
 INNER JOIN dbo.View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
 INNER JOIN dbo.View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
 INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
 LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA ON VHFHAQ.NodeID = VHFHAA.NodeParentID

		--matrix level 1 questiongroup
		--INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ2 ON VHFHAQ.NodeID = VHFHAQ2.NodeParentID
		--INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA2 ON VHFHAQ2.NodeID = VHFHAA2.NodeParentID

		--Branching Level 1 Question 
		INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ3 ON VHFHAA.NodeID = VHFHAQ3.NodeParentID
		LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA3 ON VHFHAQ3.NodeID = VHFHAA3.NodeParentID

		--Matrix Level 2 Question Group
		--INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ7 ON VHFHAQ3.NodeID = VHFHAQ7.NodeParentID
		--INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA7 ON VHFHAQ7.NodeID = VHFHAA7.NodeParentID

		--Matrix branching level 1 question group
		--INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ8 ON VHFHAA7.NodeID = VHFHAQ8.NodeParentID
		--INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA8 ON VHFHAQ8.NodeID = VHFHAA8.NodeParentID

		--Branching level 2 Question Group
		INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ4 ON VHFHAA3.NodeID = VHFHAQ4.NodeParentID
		INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA4 ON VHFHAQ4.NodeID = VHFHAA4.NodeParentID

		--Branching level 3 Question Group
		INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ5 ON VHFHAA4.NodeID = VHFHAQ5.NodeParentID
		INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA5 ON VHFHAQ5.NodeID = VHFHAA5.NodeParentID
where VCTJ.DocumentCulture = 'en-us'	--WDM 08.07.2014
and VHFHAQ.DocumentCulture = 'en-us'	
		and (VHFHAA.DocumentCulture = 'en-us' OR VHFHAA.DocumentCulture is null)	--WDM 08.12.2014		
		and VHFHARCJ.DocumentCulture = 'en-us'	
		and VHFHARAJ.DocumentCulture = 'en-us'	
		and VHFHAMJ.DocumentCulture = 'en-us'	--WDM 08.12.2014		

UNION ALL   --UNION
--WDM 6/25/2014 Retrieve the Branching level 4 Question Group
	SELECT distinct
		NULL as SiteGUID --cs.SiteGUID		--WDM 08.12.2014
		, NULL as AccountCD	 --, HFA.AccountCD												--WDM 08.07.2014
		, HA.NodeID		--WDM 08.07.2014
		, HA.NodeName		--WDM 08.07.2014
		, HA.DocumentID		--WDM 08.07.2014
		, HA.NodeSiteID		--WDM 08.07.2014
       --,VCTJ.NodeAliasPath
		, HA.DocumentPublishedVersionHistoryID		--WDM 08.07.2014
		, VHFHAMJ.Title
		, dbo.udf_StripHTML(left(VHFHAMJ.IntroText,4000)) AS IntroText
		, VHFHAMJ.DocumentGUID
		, VHFHAMJ.Weight
		, VHFHAMJ.IsEnabled
		, VHFHAMJ.CodeName
       --,VHFHAMJ.NodeAliasPath
		, VHFHAMJ.DocumentPublishedVersionHistoryID
		, VHFHARCJ.Title
		, VHFHARCJ.Weight
		, VHFHARCJ.DocumentGUID
		, VHFHARCJ.IsEnabled
		, VHFHARCJ.CodeName
       --,VHFHARCJ.NodeAliasPath
		, VHFHARCJ.DocumentPublishedVersionHistoryID
		, VHFHARAJ.Title
		, VHFHARAJ.Weight
		, VHFHARAJ.DocumentGUID
		, VHFHARAJ.IsEnabled
		, VHFHARAJ.CodeName
       --,VHFHARAJ.NodeAliasPath
		, VHFHARAJ.ScoringStrategyID
		, VHFHARAJ.DocumentPublishedVersionHistoryID
		, VHFHAQ6.QuestionType
		, dbo.udf_StripHTML(left(VHFHAQ6.Title,4000)) AS QuesTitle
		, VHFHAQ6.Weight
		, VHFHAQ6.IsRequired
		, VHFHAQ6.DocumentGUID
		, VHFHAQ6.IsEnabled
		, left(VHFHAQ6.IsVisible,4000)
		, VHFHAQ6.IsStaging
		, VHFHAQ6.CodeName AS QuestionCodeName
       --,VHFHAQ6.NodeAliasPath
		, VHFHAQ6.DocumentPublishedVersionHistoryID
		, VHFHAA6.Value
		, VHFHAA6.Points
		, VHFHAA6.DocumentGUID
		, VHFHAA6.IsEnabled
		, VHFHAA6.CodeName
		, VHFHAA6.UOM
       --,VHFHAA6.NodeAliasPath
		, VHFHAA6.DocumentPublishedVersionHistoryID
		, CASE	WHEN CAST(VCTJ.DocumentCreatedWhen AS DATE) = CAST(vctj.DocumentModifiedWhen AS DATE)
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		, VCTJ.DocumentCreatedWhen
		, VCTJ.DocumentModifiedWhen
		, VCTJ.NodeGuid as CmsTreeNodeGuid	--WDM 08.07.2014
		, HA.NodeGUID as HANodeGUID
 
		, CS.SiteLastModified
		, hfa.ItemModifiedWhen as Account_ItemModifiedWhen
		, c.DocumentModifiedWhen as Campaign_DocumentModifiedWhen
		, HA.DocumentModifiedWhen as Assessment_DocumentModifiedWhen
		, VHFHAMJ.DocumentModifiedWhen as Module_DocumentModifiedWhen
		, VHFHARCJ.DocumentModifiedWhen as RiskCategory_DocumentModifiedWhen
		, VHFHARAJ.DocumentModifiedWhen as RiskArea_DocumentModifiedWhen
		, VHFHAQ.DocumentModifiedWhen as Question_DocumentModifiedWhen
		, VHFHAA.DocumentModifiedWhen as Answer_DocumentModifiedWhen
FROM
  dbo.View_CMS_Tree_Joined AS VCTJ

 INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
 INNER JOIN HFit_Account hfa WITH(NOLOCK) ON cs.SiteID = hfa.SiteID
 INNER JOIN dbo.View_HFit_HACampaign_Joined c WITH(NOLOCK) ON VCTJ.NodeID = c.NodeParentID
 INNER JOIN View_HFit_HealthAssessment_Joined HA WITH (NOLOCK) ON c.HealthAssessmentID = HA.DocumentID
 INNER JOIN dbo.View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ ON HA.NodeID = VHFHAMJ.NodeParentID
 INNER JOIN dbo.View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
 INNER JOIN dbo.View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
 INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
 LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA ON VHFHAQ.NodeID = VHFHAA.NodeParentID

		--matrix level 1 questiongroup
		--INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ2 ON VHFHAQ.NodeID = VHFHAQ2.NodeParentID
		--INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA2 ON VHFHAQ2.NodeID = VHFHAA2.NodeParentID

		--Branching Level 1 Question 
		INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ3 ON VHFHAA.NodeID = VHFHAQ3.NodeParentID
		LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA3 ON VHFHAQ3.NodeID = VHFHAA3.NodeParentID

		--Matrix Level 2 Question Group
		--INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ7 ON VHFHAQ3.NodeID = VHFHAQ7.NodeParentID
		--INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA7 ON VHFHAQ7.NodeID = VHFHAA7.NodeParentID

		--Matrix branching level 1 question group
		--INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ8 ON VHFHAA7.NodeID = VHFHAQ8.NodeParentID
		--INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA8 ON VHFHAQ8.NodeID = VHFHAA8.NodeParentID

		--Branching level 2 Question Group
		INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ4 ON VHFHAA3.NodeID = VHFHAQ4.NodeParentID
		INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA4 ON VHFHAQ4.NodeID = VHFHAA4.NodeParentID

		--Branching level 3 Question Group
		--select count(*) from dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA4
		INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ5 ON VHFHAA4.NodeID = VHFHAQ5.NodeParentID
		INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA5 ON VHFHAQ5.NodeID = VHFHAA5.NodeParentID

		--Branching level 4 Question Group
		INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ6 ON VHFHAA5.NodeID = VHFHAQ6.NodeParentID
		INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA6 ON VHFHAQ6.NodeID = VHFHAA6.NodeParentID
where VCTJ.DocumentCulture = 'en-us'	--WDM 08.07.2014
and VHFHAQ.DocumentCulture = 'en-us'	
		and (VHFHAA.DocumentCulture = 'en-us' OR VHFHAA.DocumentCulture is null)	--WDM 08.12.2014		
		and VHFHARCJ.DocumentCulture = 'en-us'	
		and VHFHARAJ.DocumentCulture = 'en-us'	
		and VHFHAMJ.DocumentCulture = 'en-us'	--WDM 08.12.2014		

UNION ALL   --UNION
	--WDM 6/25/2014 Retrieve the Branching level 5 Question Group
	SELECT distinct
		NULL as SiteGUID --cs.SiteGUID		--WDM 08.12.2014
		, NULL as AccountCD	 --, HFA.AccountCD												--WDM 08.07.2014
		, HA.NodeID		--WDM 08.07.2014
		, HA.NodeName		--WDM 08.07.2014
		, HA.DocumentID		--WDM 08.07.2014
		, HA.NodeSiteID		--WDM 08.07.2014
       --,VCTJ.NodeAliasPath
		, HA.DocumentPublishedVersionHistoryID		--WDM 08.07.2014
		, VHFHAMJ.Title
		, dbo.udf_StripHTML(left(VHFHAMJ.IntroText,4000)) AS IntroText
		, VHFHAMJ.DocumentGUID
		, VHFHAMJ.Weight
		, VHFHAMJ.IsEnabled
		, VHFHAMJ.CodeName
       --,VHFHAMJ.NodeAliasPath
		, VHFHAMJ.DocumentPublishedVersionHistoryID
		, VHFHARCJ.Title
		, VHFHARCJ.Weight
		, VHFHARCJ.DocumentGUID
		, VHFHARCJ.IsEnabled
		, VHFHARCJ.CodeName
       --,VHFHARCJ.NodeAliasPath
		, VHFHARCJ.DocumentPublishedVersionHistoryID
		, VHFHARAJ.Title
		, VHFHARAJ.Weight
		, VHFHARAJ.DocumentGUID
		, VHFHARAJ.IsEnabled
		, VHFHARAJ.CodeName
       --,VHFHARAJ.NodeAliasPath
		, VHFHARAJ.ScoringStrategyID
		, VHFHARAJ.DocumentPublishedVersionHistoryID
		, VHFHAQ9.QuestionType
		, dbo.udf_StripHTML(left(VHFHAQ9.Title,4000)) AS QuesTitle
		, VHFHAQ9.Weight
		, VHFHAQ9.IsRequired
		, VHFHAQ9.DocumentGUID
		, VHFHAQ9.IsEnabled
		, left(VHFHAQ9.IsVisible,4000)
		, VHFHAQ9.IsStaging
		, VHFHAQ9.CodeName AS QuestionCodeName
       --,VHFHAQ9.NodeAliasPath
		, VHFHAQ9.DocumentPublishedVersionHistoryID
		, VHFHAA9.Value
		, VHFHAA9.Points
		, VHFHAA9.DocumentGUID
		, VHFHAA9.IsEnabled
		, VHFHAA9.CodeName
		, VHFHAA9.UOM
       --,VHFHAA9.NodeAliasPath
		, VHFHAA9.DocumentPublishedVersionHistoryID
		, CASE	WHEN CAST(VCTJ.DocumentCreatedWhen AS DATE) = CAST(vctj.DocumentModifiedWhen AS DATE)
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		, VCTJ.DocumentCreatedWhen
		, VCTJ.DocumentModifiedWhen
		, VCTJ.NodeGuid as CmsTreeNodeGuid	--WDM 08.07.2014
		, HA.NodeGUID as HANodeGUID
 
		, CS.SiteLastModified
		, hfa.ItemModifiedWhen as Account_ItemModifiedWhen
		, c.DocumentModifiedWhen as Campaign_DocumentModifiedWhen
		, HA.DocumentModifiedWhen as Assessment_DocumentModifiedWhen
		, VHFHAMJ.DocumentModifiedWhen as Module_DocumentModifiedWhen
		, VHFHARCJ.DocumentModifiedWhen as RiskCategory_DocumentModifiedWhen
		, VHFHARAJ.DocumentModifiedWhen as RiskArea_DocumentModifiedWhen
		, VHFHAQ.DocumentModifiedWhen as Question_DocumentModifiedWhen
		, VHFHAA.DocumentModifiedWhen as Answer_DocumentModifiedWhen
FROM
  dbo.View_CMS_Tree_Joined AS VCTJ

 INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
 INNER JOIN HFit_Account hfa WITH(NOLOCK) ON cs.SiteID = hfa.SiteID
 INNER JOIN dbo.View_HFit_HACampaign_Joined c WITH(NOLOCK) ON VCTJ.NodeID = c.NodeParentID
 INNER JOIN View_HFit_HealthAssessment_Joined HA WITH (NOLOCK) ON c.HealthAssessmentID = HA.DocumentID
 INNER JOIN dbo.View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ ON HA.NodeID = VHFHAMJ.NodeParentID
 INNER JOIN dbo.View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
 INNER JOIN dbo.View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
 INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
 LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA ON VHFHAQ.NodeID = VHFHAA.NodeParentID

		--matrix level 1 questiongroup
		--INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ2 ON VHFHAQ.NodeID = VHFHAQ2.NodeParentID
		--INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA2 ON VHFHAQ2.NodeID = VHFHAA2.NodeParentID

		--Branching Level 1 Question 
		INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ3 ON VHFHAA.NodeID = VHFHAQ3.NodeParentID
		LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA3 ON VHFHAQ3.NodeID = VHFHAA3.NodeParentID

		--Matrix Level 2 Question Group
		--INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ7 ON VHFHAQ3.NodeID = VHFHAQ7.NodeParentID
		--INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA7 ON VHFHAQ7.NodeID = VHFHAA7.NodeParentID

		--Matrix branching level 1 question group
		--INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ8 ON VHFHAA7.NodeID = VHFHAQ8.NodeParentID
		--INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA8 ON VHFHAQ8.NodeID = VHFHAA8.NodeParentID

		--Branching level 2 Question Group
		INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ4 ON VHFHAA3.NodeID = VHFHAQ4.NodeParentID
		INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA4 ON VHFHAQ4.NodeID = VHFHAA4.NodeParentID

		--Branching level 3 Question Group
		--select count(*) from dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA4
		INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ5 ON VHFHAA4.NodeID = VHFHAQ5.NodeParentID
		INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA5 ON VHFHAQ5.NodeID = VHFHAA5.NodeParentID

		--Branching level 4 Question Group
		INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ6 ON VHFHAA5.NodeID = VHFHAQ6.NodeParentID
		INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA6 ON VHFHAQ6.NodeID = VHFHAA6.NodeParentID

		--Branching level 5 Question Group
		INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ9 ON VHFHAA6.NodeID = VHFHAQ9.NodeParentID
		INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA9 ON VHFHAQ9.NodeID = VHFHAA9.NodeParentID

	where VCTJ.DocumentCulture = 'en-us'	--WDM 08.07.2014
		and VHFHAQ.DocumentCulture = 'en-us'	
		and (VHFHAA.DocumentCulture = 'en-us' OR VHFHAA.DocumentCulture is null)	--WDM 08.12.2014		
		and VHFHARCJ.DocumentCulture = 'en-us'	
		and VHFHARAJ.DocumentCulture = 'en-us'	
		and VHFHAMJ.DocumentCulture = 'en-us'	--WDM 08.12.2014		



GO




if exists(select TABLE_NAME from INFORMATION_SCHEMA.VIEWS where TABLE_NAME = 'view_EDW_HealthAssesmentDeffinitionCustom')
BEGIN
	drop view view_EDW_HealthAssesmentDeffinitionCustom ;
END
GO

--GRANT SELECT
--	ON [dbo].[view_EDW_HealthAssesmentDeffinitionCustom]
--	TO [EDWReader_PRD]
--GO

--***********************************************************************************************
-- 09.11.2014 : (wdm) Verified DATES to resolve EDW last mod date issue
--***********************************************************************************************
CREATE VIEW [dbo].[view_EDW_HealthAssesmentDeffinitionCustom]
AS
	--8/8/2014 - DocGUID changes, NodeGuid
	--8/8/2014 - Generated corrected view in DEV
	--8/10/2014 - added WHERE to limit to English language
	--09.11.2014 - WDM : Added date fields to facilitate Last Mod Date determination
	SELECT 
		cs.SiteGUID
		, HFA.AccountCD		--WDM 08.07.2014
		, HA.NodeID AS HANodeID		--WDM 08.07.2014
		, HA.NodeName AS HANodeName		--WDM 08.07.2014
		, HA.DocumentID AS HADocumentID		--WDM 08.07.2014
		, HA.NodeSiteID AS HANodeSiteID		--WDM 08.07.2014
		, HA.DocumentPublishedVersionHistoryID AS HADocPubVerID		--WDM 08.07.2014
		, VHFHAMJ.Title AS ModTitle
		--Per EDW Team, HTML text is truncated to 4000 bytes - we'll just do it here
		, dbo.udf_StripHTML(left(left(VHFHAMJ.IntroText,4000),4000)) AS IntroText
		, VHFHAMJ.DocumentGuid AS ModDocGuid	--, VHFHAMJ.DocumentID AS ModDocID	--WDM 08.07.2014
		, VHFHAMJ.Weight AS ModWeight
		, VHFHAMJ.IsEnabled AS ModIsEnabled
		, VHFHAMJ.CodeName AS ModCodeName
		, VHFHAMJ.DocumentPublishedVersionHistoryID AS ModDocPubVerID
		, VHFHARCJ.Title AS RCTitle
		, VHFHARCJ.Weight AS RCWeight
		, VHFHARCJ.DocumentGuid AS RCDocumentGUID	--, VHFHARCJ.DocumentID AS RCDocumentID	--WDM 08.07.2014
		, VHFHARCJ.IsEnabled AS RCIsEnabled
		, VHFHARCJ.CodeName AS RCCodeName
		, VHFHARCJ.DocumentPublishedVersionHistoryID AS RCDocPubVerID
		, VHFHARAJ.Title AS RATytle
		, VHFHARAJ.Weight AS RAWeight
		, VHFHARAJ.DocumentGuid AS RADocumentGuid	--, VHFHARAJ.DocumentID AS RADocumentID	--WDM 08.07.2014
		, VHFHARAJ.IsEnabled AS RAIsEnabled
		, VHFHARAJ.CodeName AS RACodeName
		, VHFHARAJ.ScoringStrategyID AS RAScoringStrategyID
		, VHFHARAJ.DocumentPublishedVersionHistoryID AS RADocPubVerID
		, VHFHAQ.QuestionType
		, dbo.udf_StripHTML(left(VHFHAQ.Title,4000)) AS QuesTitle
		, VHFHAQ.Weight AS QuesWeight
		, VHFHAQ.IsRequired AS QuesIsRequired

		, VHFHAQ.DocumentGuid AS QuesDocumentGuid	--, VHFHAQ.DocumentID AS QuesDocumentID	--WDM 08.07.2014
		
		, VHFHAQ.IsEnabled AS QuesIsEnabled
		, left(VHFHAQ.IsVisible,4000) AS QuesIsVisible
		, VHFHAQ.IsStaging AS QuesIsSTaging
		, VHFHAQ.CodeName AS QuestionCodeName
		, VHFHAQ.DocumentPublishedVersionHistoryID AS QuesDocPubVerID
		, VHFHAA.Value AS AnsValue
		, VHFHAA.Points AS AnsPoints
		
		, VHFHAA.DocumentGuid AS AnsDocumentGuid	--, VHFHAA.DocumentID AS AnsDocumentID	--WDM 08.07.2014
		
		, VHFHAA.IsEnabled AS AnsIsEnabled
		, VHFHAA.CodeName AS AnsCodeName
		, VHFHAA.UOM AS AnsUOM
		, VHFHAA.DocumentPublishedVersionHistoryID AS AnsDocPUbVerID
		, CASE	WHEN CAST(VCTJ.DocumentCreatedWhen AS DATE) = CAST(vctj.DocumentModifiedWhen AS DATE)
			THEN 'I'
			ELSE 'U'
		END AS ChangeType
		, VCTJ.DocumentCreatedWhen
		, VCTJ.DocumentModifiedWhen
		, VCTJ.NodeGuid as CmsTreeNodeGuid	--WDM 08.07.2014 ADDED TO the returned Columns
	 
		, CS.SiteLastModified
		, hfa.ItemModifiedWhen as Account_ItemModifiedWhen
		, c.DocumentModifiedWhen as Campaign_DocumentModifiedWhen
		, HA.DocumentModifiedWhen as Assessment_DocumentModifiedWhen
		, VHFHAMJ.DocumentModifiedWhen as Module_DocumentModifiedWhen
		, VHFHARCJ.DocumentModifiedWhen as RiskCategory_DocumentModifiedWhen
		, VHFHARAJ.DocumentModifiedWhen as RiskArea_DocumentModifiedWhen
		, VHFHAQ.DocumentModifiedWhen as Question_DocumentModifiedWhen
		, VHFHAA.DocumentModifiedWhen as Answer_DocumentModifiedWhen
FROM
		dbo.View_CMS_Tree_Joined AS VCTJ
		INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
		INNER JOIN HFit_Account hfa WITH(NOLOCK) ON cs.SiteID = hfa.SiteID
 
		--Campaign links Client which links to Assessment
		INNER JOIN dbo.View_HFit_HACampaign_Joined as c WITH(NOLOCK) ON VCTJ.NodeID = c.NodeParentID
 
		INNER JOIN View_HFit_HealthAssessment_Joined as HA WITH (NOLOCK) ON c.HealthAssessmentID = HA.DocumentID
		--WDM 08.07.2014
		INNER JOIN dbo.View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ ON HA.NodeID = VHFHAMJ.NodeParentID		
		INNER JOIN dbo.View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
		INNER JOIN dbo.View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
		INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
		LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA ON VHFHAQ.NodeID = VHFHAA.NodeParentID
		where VCTJ.DocumentCulture = 'en-us'	--WDM 08.07.2014
				AND VHFHAMJ.NodeName = 'Custom'
UNION ALL
--WDM Retrieve Matrix Level 1 Question Group
	SELECT
		cs.SiteGUID
		, HFA.AccountCD
		, HA.NodeID		--WDM 08.07.2014
		, HA.NodeName		--WDM 08.07.2014
		, HA.DocumentID		--WDM 08.07.2014
		, HA.NodeSiteID		--WDM 08.07.2014
       --,VCTJ.NodeAliasPath
		, HA.DocumentPublishedVersionHistoryID		--WDM 08.07.2014
		, VHFHAMJ.Title
		, dbo.udf_StripHTML(left(left(VHFHAMJ.IntroText,4000),4000)) AS IntroText
		, VHFHAMJ.DocumentGUID
		, VHFHAMJ.Weight
		, VHFHAMJ.IsEnabled
		, VHFHAMJ.CodeName
       --,VHFHAMJ.NodeAliasPath
		, VHFHAMJ.DocumentPublishedVersionHistoryID
		, VHFHARCJ.Title
		, VHFHARCJ.Weight
		, VHFHARCJ.DocumentGUID
		, VHFHARCJ.IsEnabled
		, VHFHARCJ.CodeName
       --,VHFHARCJ.NodeAliasPath
		, VHFHARCJ.DocumentPublishedVersionHistoryID
		, VHFHARAJ.Title
		, VHFHARAJ.Weight
		, VHFHARAJ.DocumentGUID
		, VHFHARAJ.IsEnabled
		, VHFHARAJ.CodeName
       --,VHFHARAJ.NodeAliasPath
		, VHFHARAJ.ScoringStrategyID
		, VHFHARAJ.DocumentPublishedVersionHistoryID
		, VHFHAQ2.QuestionType
		, dbo.udf_StripHTML(left(VHFHAQ2.Title,4000)) AS QuesTitle
		, VHFHAQ2.Weight
		, VHFHAQ2.IsRequired
		, VHFHAQ2.DocumentGUID
		, VHFHAQ2.IsEnabled
		, left(VHFHAQ2.IsVisible,4000)
		, VHFHAQ2.IsStaging
		, VHFHAQ2.CodeName AS QuestionCodeName
       --,VHFHAQ2.NodeAliasPath
		, VHFHAQ2.DocumentPublishedVersionHistoryID
		, VHFHAA2.Value
		, VHFHAA2.Points
		, VHFHAA2.DocumentGUID
		, VHFHAA2.IsEnabled
		, VHFHAA2.CodeName
		, VHFHAA2.UOM
       --,VHFHAA2.NodeAliasPath
		, VHFHAA2.DocumentPublishedVersionHistoryID
		, CASE	WHEN CAST(VCTJ.DocumentCreatedWhen AS DATE) = CAST(vctj.DocumentModifiedWhen AS DATE)
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		, VCTJ.DocumentCreatedWhen
		, VCTJ.DocumentModifiedWhen
		, VCTJ.NodeGuid as CmsTreeNodeGuid	--WDM 08.07.2014
	 
		, CS.SiteLastModified
		, hfa.ItemModifiedWhen as Account_ItemModifiedWhen
		, c.DocumentModifiedWhen as Campaign_DocumentModifiedWhen
		, HA.DocumentModifiedWhen as Assessment_DocumentModifiedWhen
		, VHFHAMJ.DocumentModifiedWhen as Module_DocumentModifiedWhen
		, VHFHARCJ.DocumentModifiedWhen as RiskCategory_DocumentModifiedWhen
		, VHFHARAJ.DocumentModifiedWhen as RiskArea_DocumentModifiedWhen
		, VHFHAQ.DocumentModifiedWhen as Question_DocumentModifiedWhen
		, VHFHAA.DocumentModifiedWhen as Answer_DocumentModifiedWhen
FROM
  dbo.View_CMS_Tree_Joined AS VCTJ

 INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
 INNER JOIN HFit_Account hfa WITH(NOLOCK) ON cs.SiteID = hfa.SiteID
 INNER JOIN dbo.View_HFit_HACampaign_Joined c WITH(NOLOCK) ON VCTJ.NodeID = c.NodeParentID
 INNER JOIN View_HFit_HealthAssessment_Joined HA WITH (NOLOCK) ON c.HealthAssessmentID = HA.DocumentID
 INNER JOIN dbo.View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ ON HA.NodeID = VHFHAMJ.NodeParentID
 INNER JOIN dbo.View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
 INNER JOIN dbo.View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
 INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
 LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA ON VHFHAQ.NodeID = VHFHAA.NodeParentID
--matrix level 1 questiongroup
	INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ2 ON VHFHAQ.NodeID = VHFHAQ2.NodeParentID
	INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA2 ON VHFHAQ2.NodeID = VHFHAA2.NodeParentID
where VCTJ.DocumentCulture = 'en-us'	--WDM 08.07.2014
				AND VHFHAMJ.NodeName = 'Custom'

UNION ALL
--WDM Retrieve Branching Level 1 Question and Matrix Level 1 Question Group
	SELECT
		cs.SiteGUID
		, HFA.AccountCD
		, HA.NodeID		--WDM 08.07.2014
		, HA.NodeName		--WDM 08.07.2014
		, HA.DocumentID		--WDM 08.07.2014
		, HA.NodeSiteID		--WDM 08.07.2014
       --,VCTJ.NodeAliasPath
		, HA.DocumentPublishedVersionHistoryID		--WDM 08.07.2014
		, VHFHAMJ.Title
		, dbo.udf_StripHTML(left(VHFHAMJ.IntroText,4000)) AS IntroText
		, VHFHAMJ.DocumentGUID
		, VHFHAMJ.Weight
		, VHFHAMJ.IsEnabled
		, VHFHAMJ.CodeName
       --,VHFHAMJ.NodeAliasPath
		, VHFHAMJ.DocumentPublishedVersionHistoryID
		, VHFHARCJ.Title
		, VHFHARCJ.Weight
		, VHFHARCJ.DocumentGUID
		, VHFHARCJ.IsEnabled
		, VHFHARCJ.CodeName
       --,VHFHARCJ.NodeAliasPath
		, VHFHARCJ.DocumentPublishedVersionHistoryID
		, VHFHARAJ.Title
		, VHFHARAJ.Weight
		, VHFHARAJ.DocumentGUID
		, VHFHARAJ.IsEnabled
		, VHFHARAJ.CodeName
       --,VHFHARAJ.NodeAliasPath
		, VHFHARAJ.ScoringStrategyID
		, VHFHARAJ.DocumentPublishedVersionHistoryID
		, VHFHAQ3.QuestionType
		, dbo.udf_StripHTML(left(VHFHAQ3.Title,4000)) AS QuesTitle
		, VHFHAQ3.Weight
		, VHFHAQ3.IsRequired
		, VHFHAQ3.DocumentGUID
		, VHFHAQ3.IsEnabled
		, left(VHFHAQ3.IsVisible,4000)
		, VHFHAQ3.IsStaging
		, VHFHAQ3.CodeName AS QuestionCodeName
       --,VHFHAQ3.NodeAliasPath
		, VHFHAQ3.DocumentPublishedVersionHistoryID
		, VHFHAA3.Value
		, VHFHAA3.Points
		, VHFHAA3.DocumentGUID
		, VHFHAA3.IsEnabled
		, VHFHAA3.CodeName
		, VHFHAA3.UOM
       --,VHFHAA3.NodeAliasPath
		, VHFHAA3.DocumentPublishedVersionHistoryID
		, CASE	WHEN CAST(VCTJ.DocumentCreatedWhen AS DATE) = CAST(vctj.DocumentModifiedWhen AS DATE)
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		, VCTJ.DocumentCreatedWhen
		, VCTJ.DocumentModifiedWhen
		, VCTJ.NodeGuid as CmsTreeNodeGuid	--WDM 08.07.2014
 
		, CS.SiteLastModified
		, hfa.ItemModifiedWhen as Account_ItemModifiedWhen
		, c.DocumentModifiedWhen as Campaign_DocumentModifiedWhen
		, HA.DocumentModifiedWhen as Assessment_DocumentModifiedWhen
		, VHFHAMJ.DocumentModifiedWhen as Module_DocumentModifiedWhen
		, VHFHARCJ.DocumentModifiedWhen as RiskCategory_DocumentModifiedWhen
		, VHFHARAJ.DocumentModifiedWhen as RiskArea_DocumentModifiedWhen
		, VHFHAQ.DocumentModifiedWhen as Question_DocumentModifiedWhen
		, VHFHAA.DocumentModifiedWhen as Answer_DocumentModifiedWhen
FROM
  dbo.View_CMS_Tree_Joined AS VCTJ

 INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
 INNER JOIN HFit_Account hfa WITH(NOLOCK) ON cs.SiteID = hfa.SiteID
 INNER JOIN dbo.View_HFit_HACampaign_Joined c WITH(NOLOCK) ON VCTJ.NodeID = c.NodeParentID
 INNER JOIN View_HFit_HealthAssessment_Joined HA WITH (NOLOCK) ON c.HealthAssessmentID = HA.DocumentID
 INNER JOIN dbo.View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ ON HA.NodeID = VHFHAMJ.NodeParentID
 INNER JOIN dbo.View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
 INNER JOIN dbo.View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
 INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
 LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA ON VHFHAQ.NodeID = VHFHAA.NodeParentID

--matrix level 1 questiongroup
--INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ2 ON VHFHAQ.NodeID = VHFHAQ2.NodeParentID
--INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA2 ON VHFHAQ2.NodeID = VHFHAA2.NodeParentID

--Branching Level 1 Question 
	INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ3 ON VHFHAA.NodeID = VHFHAQ3.NodeParentID
	LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA3 ON VHFHAQ3.NodeID = VHFHAA3.NodeParentID
where VCTJ.DocumentCulture = 'en-us'	--WDM 08.07.2014
				AND VHFHAMJ.NodeName = 'Custom'

UNION ALL
--WDM Retrieve Branching Level 1 Question and Matrix Level 2 Question Group
	SELECT
		cs.SiteGUID
		, HFA.AccountCD
		, HA.NodeID		--WDM 08.07.2014
		, HA.NodeName		--WDM 08.07.2014
		, HA.DocumentID		--WDM 08.07.2014
		, HA.NodeSiteID		--WDM 08.07.2014
       --,VCTJ.NodeAliasPath
		, HA.DocumentPublishedVersionHistoryID		--WDM 08.07.2014
		, VHFHAMJ.Title
		, dbo.udf_StripHTML(left(VHFHAMJ.IntroText,4000)) AS IntroText
		, VHFHAMJ.DocumentGUID
		, VHFHAMJ.Weight
		, VHFHAMJ.IsEnabled
		, VHFHAMJ.CodeName
       --,VHFHAMJ.NodeAliasPath
		, VHFHAMJ.DocumentPublishedVersionHistoryID
		, VHFHARCJ.Title
		, VHFHARCJ.Weight
		, VHFHARCJ.DocumentGUID
		, VHFHARCJ.IsEnabled
		, VHFHARCJ.CodeName
       --,VHFHARCJ.NodeAliasPath
		, VHFHARCJ.DocumentPublishedVersionHistoryID
		, VHFHARAJ.Title
		, VHFHARAJ.Weight
		, VHFHARAJ.DocumentGUID
		, VHFHARAJ.IsEnabled
		, VHFHARAJ.CodeName
       --,VHFHARAJ.NodeAliasPath
		, VHFHARAJ.ScoringStrategyID
		, VHFHARAJ.DocumentPublishedVersionHistoryID
		, VHFHAQ7.QuestionType
		, dbo.udf_StripHTML(left(VHFHAQ7.Title,4000)) AS QuesTitle
		, VHFHAQ7.Weight
		, VHFHAQ7.IsRequired
		, VHFHAQ7.DocumentGUID
		, VHFHAQ7.IsEnabled
		, left(VHFHAQ7.IsVisible,4000)
		, VHFHAQ7.IsStaging
		, VHFHAQ7.CodeName AS QuestionCodeName
       --,VHFHAQ7.NodeAliasPath
		, VHFHAQ7.DocumentPublishedVersionHistoryID
		, VHFHAA7.Value
		, VHFHAA7.Points
		, VHFHAA7.DocumentGUID
		, VHFHAA7.IsEnabled
		, VHFHAA7.CodeName
		, VHFHAA7.UOM
       --,VHFHAA7.NodeAliasPath
		, VHFHAA7.DocumentPublishedVersionHistoryID
		, CASE	WHEN CAST(VCTJ.DocumentCreatedWhen AS DATE) = CAST(vctj.DocumentModifiedWhen AS DATE)
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		, VCTJ.DocumentCreatedWhen
		, VCTJ.DocumentModifiedWhen
		, VCTJ.NodeGuid as CmsTreeNodeGuid	--WDM 08.07.2014
 
		, CS.SiteLastModified
		, hfa.ItemModifiedWhen as Account_ItemModifiedWhen
		, c.DocumentModifiedWhen as Campaign_DocumentModifiedWhen
		, HA.DocumentModifiedWhen as Assessment_DocumentModifiedWhen
		, VHFHAMJ.DocumentModifiedWhen as Module_DocumentModifiedWhen
		, VHFHARCJ.DocumentModifiedWhen as RiskCategory_DocumentModifiedWhen
		, VHFHARAJ.DocumentModifiedWhen as RiskArea_DocumentModifiedWhen
		, VHFHAQ.DocumentModifiedWhen as Question_DocumentModifiedWhen
		, VHFHAA.DocumentModifiedWhen as Answer_DocumentModifiedWhen
FROM
 dbo.View_CMS_Tree_Joined AS VCTJ
 INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
 INNER JOIN HFit_Account hfa WITH(NOLOCK) ON cs.SiteID = hfa.SiteID
 INNER JOIN dbo.View_HFit_HACampaign_Joined c WITH(NOLOCK) ON VCTJ.NodeID = c.NodeParentID
 INNER JOIN View_HFit_HealthAssessment_Joined HA WITH (NOLOCK) ON c.HealthAssessmentID = HA.DocumentID
 INNER JOIN dbo.View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ ON HA.NodeID = VHFHAMJ.NodeParentID
 INNER JOIN dbo.View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
 INNER JOIN dbo.View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
 INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
 LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA ON VHFHAQ.NodeID = VHFHAA.NodeParentID

--matrix level 1 questiongroup
--INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ2 ON VHFHAQ.NodeID = VHFHAQ2.NodeParentID
--INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA2 ON VHFHAQ2.NodeID = VHFHAA2.NodeParentID

--Branching Level 1 Question 
	INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ3 ON VHFHAA.NodeID = VHFHAQ3.NodeParentID
--LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA3 ON VHFHAQ3.NodeID = VHFHAA3.NodeParentID

--Matrix Level 2 Question Group
	INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ7 ON VHFHAQ3.NodeID = VHFHAQ7.NodeParentID
	INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA7 ON VHFHAQ7.NodeID = VHFHAA7.NodeParentID
where VCTJ.DocumentCulture = 'en-us'	--WDM 08.07.2014
				AND VHFHAMJ.NodeName = 'Custom'

UNION ALL
	--****************************************************
	--WDM 6/25/2014 Retrieve the Branching level 1 Question Group
	--THE PROBLEM LIES HERE in this part of query : 1:40 minute
	-- Added two perf indexes to the first query: 25 Sec
	--****************************************************
	SELECT
		cs.SiteGUID
		, HFA.AccountCD
		, HA.NodeID		--WDM 08.07.2014
		, HA.NodeName		--WDM 08.07.2014
		, HA.DocumentID		--WDM 08.07.2014
		, HA.NodeSiteID		--WDM 08.07.2014
       --,VCTJ.NodeAliasPath
		, HA.DocumentPublishedVersionHistoryID		--WDM 08.07.2014
		, VHFHAMJ.Title
		, dbo.udf_StripHTML(left(VHFHAMJ.IntroText,4000)) AS IntroText
		, VHFHAMJ.DocumentGUID
		, VHFHAMJ.Weight
		, VHFHAMJ.IsEnabled
		, VHFHAMJ.CodeName
       --,VHFHAMJ.NodeAliasPath
		, VHFHAMJ.DocumentPublishedVersionHistoryID
		, VHFHARCJ.Title
		, VHFHARCJ.Weight
		, VHFHARCJ.DocumentGUID
		, VHFHARCJ.IsEnabled
		, VHFHARCJ.CodeName
       --,VHFHARCJ.NodeAliasPath
		, VHFHARCJ.DocumentPublishedVersionHistoryID
		, VHFHARAJ.Title
		, VHFHARAJ.Weight
		, VHFHARAJ.DocumentGUID
		, VHFHARAJ.IsEnabled
		, VHFHARAJ.CodeName
       --,VHFHARAJ.NodeAliasPath
		, VHFHARAJ.ScoringStrategyID
		, VHFHARAJ.DocumentPublishedVersionHistoryID
		, VHFHAQ8.QuestionType
		, dbo.udf_StripHTML(left(VHFHAQ8.Title,4000)) AS QuesTitle
		, VHFHAQ8.Weight
		, VHFHAQ8.IsRequired
		, VHFHAQ8.DocumentGUID
		, VHFHAQ8.IsEnabled
		, left(VHFHAQ8.IsVisible,4000)
		, VHFHAQ8.IsStaging
		, VHFHAQ8.CodeName AS QuestionCodeName
       --,VHFHAQ8.NodeAliasPath
		, VHFHAQ8.DocumentPublishedVersionHistoryID
		, VHFHAA8.Value
		, VHFHAA8.Points
		, VHFHAA8.DocumentGUID
		, VHFHAA8.IsEnabled
		, VHFHAA8.CodeName
		, VHFHAA8.UOM
       --,VHFHAA8.NodeAliasPath
		, VHFHAA8.DocumentPublishedVersionHistoryID
		, CASE	WHEN CAST(VCTJ.DocumentCreatedWhen AS DATE) = CAST(vctj.DocumentModifiedWhen AS DATE)
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		, VCTJ.DocumentCreatedWhen
		, VCTJ.DocumentModifiedWhen
		, VCTJ.NodeGuid as CmsTreeNodeGuid	--WDM 08.07.2014
	
		, CS.SiteLastModified
		, hfa.ItemModifiedWhen as Account_ItemModifiedWhen
		, c.DocumentModifiedWhen as Campaign_DocumentModifiedWhen
		, HA.DocumentModifiedWhen as Assessment_DocumentModifiedWhen
		, VHFHAMJ.DocumentModifiedWhen as Module_DocumentModifiedWhen
		, VHFHARCJ.DocumentModifiedWhen as RiskCategory_DocumentModifiedWhen
		, VHFHARAJ.DocumentModifiedWhen as RiskArea_DocumentModifiedWhen
		, VHFHAQ.DocumentModifiedWhen as Question_DocumentModifiedWhen
		, VHFHAA.DocumentModifiedWhen as Answer_DocumentModifiedWhen
FROM
  dbo.View_CMS_Tree_Joined AS VCTJ

 INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
 INNER JOIN HFit_Account hfa WITH(NOLOCK) ON cs.SiteID = hfa.SiteID
 INNER JOIN dbo.View_HFit_HACampaign_Joined c WITH(NOLOCK) ON VCTJ.NodeID = c.NodeParentID
 INNER JOIN View_HFit_HealthAssessment_Joined HA WITH (NOLOCK) ON c.HealthAssessmentID = HA.DocumentID
 INNER JOIN dbo.View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ ON HA.NodeID = VHFHAMJ.NodeParentID
 INNER JOIN dbo.View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
 INNER JOIN dbo.View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
 INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
 LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA ON VHFHAQ.NodeID = VHFHAA.NodeParentID

			--matrix level 1 questiongroup
			--INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ2 ON VHFHAQ.NodeID = VHFHAQ2.NodeParentID
			--INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA2 ON VHFHAQ2.NodeID = VHFHAA2.NodeParentID

			--Branching Level 1 Question 
			INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ3 ON VHFHAA.NodeID = VHFHAQ3.NodeParentID
			--LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA3 ON VHFHAQ3.NodeID = VHFHAA3.NodeParentID

			--Matrix Level 2 Question Group
			INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ7 ON VHFHAQ3.NodeID = VHFHAQ7.NodeParentID
			INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA7 ON VHFHAQ7.NodeID = VHFHAA7.NodeParentID

			--Matrix branching level 1 question group
			INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ8 ON VHFHAA7.NodeID = VHFHAQ8.NodeParentID
			INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA8 ON VHFHAQ8.NodeID = VHFHAA8.NodeParentID
where VCTJ.DocumentCulture = 'en-us'	--WDM 08.07.2014
				AND VHFHAMJ.NodeName = 'Custom'

UNION ALL
	--****************************************************
	--WDM 6/25/2014 Retrieve the Branching level 2 Question Group
	--THE PROBLEM LIES HERE in this part of query : 1:48  minutes
	--With the new indexes: 29 Secs
	--****************************************************
	SELECT
		cs.SiteGUID
		, HFA.AccountCD
		, HA.NodeID		--WDM 08.07.2014
		, HA.NodeName		--WDM 08.07.2014
		, HA.DocumentID		--WDM 08.07.2014
		, HA.NodeSiteID		--WDM 08.07.2014
       --,VCTJ.NodeAliasPath
		, HA.DocumentPublishedVersionHistoryID		--WDM 08.07.2014
		, VHFHAMJ.Title
		, dbo.udf_StripHTML(left(VHFHAMJ.IntroText,4000)) AS IntroText
		, VHFHAMJ.DocumentGUID
		, VHFHAMJ.Weight
		, VHFHAMJ.IsEnabled
		, VHFHAMJ.CodeName
       --,VHFHAMJ.NodeAliasPath
		, VHFHAMJ.DocumentPublishedVersionHistoryID
		, VHFHARCJ.Title
		, VHFHARCJ.Weight
		, VHFHARCJ.DocumentGUID
		, VHFHARCJ.IsEnabled
		, VHFHARCJ.CodeName
       --,VHFHARCJ.NodeAliasPath
		, VHFHARCJ.DocumentPublishedVersionHistoryID
		, VHFHARAJ.Title
		, VHFHARAJ.Weight
		, VHFHARAJ.DocumentGUID
		, VHFHARAJ.IsEnabled
		, VHFHARAJ.CodeName
       --,VHFHARAJ.NodeAliasPath
		, VHFHARAJ.ScoringStrategyID
		, VHFHARAJ.DocumentPublishedVersionHistoryID
		, VHFHAQ4.QuestionType
		, dbo.udf_StripHTML(left(VHFHAQ4.Title,4000)) AS QuesTitle
		, VHFHAQ4.Weight
		, VHFHAQ4.IsRequired
		, VHFHAQ4.DocumentGUID
		, VHFHAQ4.IsEnabled
		, left(VHFHAQ4.IsVisible,4000)
		, VHFHAQ4.IsStaging
		, VHFHAQ4.CodeName AS QuestionCodeName
       --,VHFHAQ4.NodeAliasPath
		, VHFHAQ4.DocumentPublishedVersionHistoryID
		, VHFHAA4.Value
		, VHFHAA4.Points
		, VHFHAA4.DocumentGUID
		, VHFHAA4.IsEnabled
		, VHFHAA4.CodeName
		, VHFHAA4.UOM
       --,VHFHAA4.NodeAliasPath
		, VHFHAA4.DocumentPublishedVersionHistoryID
		, CASE	WHEN CAST(VCTJ.DocumentCreatedWhen AS DATE) = CAST(vctj.DocumentModifiedWhen AS DATE)
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		, VCTJ.DocumentCreatedWhen
		, VCTJ.DocumentModifiedWhen
		, VCTJ.NodeGuid as CmsTreeNodeGuid	--WDM 08.07.2014
 
		, CS.SiteLastModified
		, hfa.ItemModifiedWhen as Account_ItemModifiedWhen
		, c.DocumentModifiedWhen as Campaign_DocumentModifiedWhen
		, HA.DocumentModifiedWhen as Assessment_DocumentModifiedWhen
		, VHFHAMJ.DocumentModifiedWhen as Module_DocumentModifiedWhen
		, VHFHARCJ.DocumentModifiedWhen as RiskCategory_DocumentModifiedWhen
		, VHFHARAJ.DocumentModifiedWhen as RiskArea_DocumentModifiedWhen
		, VHFHAQ.DocumentModifiedWhen as Question_DocumentModifiedWhen
		, VHFHAA.DocumentModifiedWhen as Answer_DocumentModifiedWhen
FROM
  dbo.View_CMS_Tree_Joined AS VCTJ

 INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
 INNER JOIN HFit_Account hfa WITH(NOLOCK) ON cs.SiteID = hfa.SiteID
 INNER JOIN dbo.View_HFit_HACampaign_Joined c WITH(NOLOCK) ON VCTJ.NodeID = c.NodeParentID
 INNER JOIN View_HFit_HealthAssessment_Joined HA WITH (NOLOCK) ON c.HealthAssessmentID = HA.DocumentID
 INNER JOIN dbo.View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ ON HA.NodeID = VHFHAMJ.NodeParentID
 INNER JOIN dbo.View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
 INNER JOIN dbo.View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
 INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
 LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA ON VHFHAQ.NodeID = VHFHAA.NodeParentID

			--matrix level 1 questiongroup
			--INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ2 ON VHFHAQ.NodeID = VHFHAQ2.NodeParentID
			--INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA2 ON VHFHAQ2.NodeID = VHFHAA2.NodeParentID

			--Branching Level 1 Question 
			INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ3 ON VHFHAA.NodeID = VHFHAQ3.NodeParentID
			LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA3 ON VHFHAQ3.NodeID = VHFHAA3.NodeParentID

			--Matrix Level 2 Question Group
			--INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ7 ON VHFHAQ3.NodeID = VHFHAQ7.NodeParentID
			--INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA7 ON VHFHAQ7.NodeID = VHFHAA7.NodeParentID

			--Matrix branching level 1 question group
			--INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ8 ON VHFHAA7.NodeID = VHFHAQ8.NodeParentID
			--INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA8 ON VHFHAQ8.NodeID = VHFHAA8.NodeParentID

			--Branching level 2 Question Group
			INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ4 ON VHFHAA3.NodeID = VHFHAQ4.NodeParentID
			INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA4 ON VHFHAQ4.NodeID = VHFHAA4.NodeParentID
where VCTJ.DocumentCulture = 'en-us'	--WDM 08.07.2014
				AND VHFHAMJ.NodeName = 'Custom'

UNION ALL
--WDM 6/25/2014 Retrieve the Branching level 3 Question Group
	SELECT
		cs.SiteGUID
		, HFA.AccountCD
		, HA.NodeID		--WDM 08.07.2014
		, HA.NodeName		--WDM 08.07.2014
		, HA.DocumentID		--WDM 08.07.2014
		, HA.NodeSiteID		--WDM 08.07.2014
       --,VCTJ.NodeAliasPath
		, HA.DocumentPublishedVersionHistoryID		--WDM 08.07.2014
		, VHFHAMJ.Title
		, dbo.udf_StripHTML(left(VHFHAMJ.IntroText,4000)) AS IntroText
		, VHFHAMJ.DocumentGUID
		, VHFHAMJ.Weight
		, VHFHAMJ.IsEnabled
		, VHFHAMJ.CodeName
       --,VHFHAMJ.NodeAliasPath
		, VHFHAMJ.DocumentPublishedVersionHistoryID
		, VHFHARCJ.Title
		, VHFHARCJ.Weight
		, VHFHARCJ.DocumentGUID
		, VHFHARCJ.IsEnabled
		, VHFHARCJ.CodeName
       --,VHFHARCJ.NodeAliasPath
		, VHFHARCJ.DocumentPublishedVersionHistoryID
		, VHFHARAJ.Title
		, VHFHARAJ.Weight
		, VHFHARAJ.DocumentGUID
		, VHFHARAJ.IsEnabled
		, VHFHARAJ.CodeName
       --,VHFHARAJ.NodeAliasPath
		, VHFHARAJ.ScoringStrategyID
		, VHFHARAJ.DocumentPublishedVersionHistoryID
		, VHFHAQ5.QuestionType
		, dbo.udf_StripHTML(left(VHFHAQ5.Title,4000)) AS QuesTitle
		, VHFHAQ5.Weight
		, VHFHAQ5.IsRequired
		, VHFHAQ5.DocumentGUID
		, VHFHAQ5.IsEnabled
		, left(VHFHAQ5.IsVisible,4000)
		, VHFHAQ5.IsStaging
		, VHFHAQ5.CodeName AS QuestionCodeName
       --,VHFHAQ5.NodeAliasPath
		, VHFHAQ5.DocumentPublishedVersionHistoryID
		, VHFHAA5.Value
		, VHFHAA5.Points
		, VHFHAA5.DocumentGUID
		, VHFHAA5.IsEnabled
		, VHFHAA5.CodeName
		, VHFHAA5.UOM
       --,VHFHAA5.NodeAliasPath
		, VHFHAA5.DocumentPublishedVersionHistoryID
		, CASE	WHEN CAST(VCTJ.DocumentCreatedWhen AS DATE) = CAST(vctj.DocumentModifiedWhen AS DATE)
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		, VCTJ.DocumentCreatedWhen
		, VCTJ.DocumentModifiedWhen
		, VCTJ.NodeGuid as CmsTreeNodeGuid	--WDM 08.07.2014
 
		, CS.SiteLastModified
		, hfa.ItemModifiedWhen as Account_ItemModifiedWhen
		, c.DocumentModifiedWhen as Campaign_DocumentModifiedWhen
		, HA.DocumentModifiedWhen as Assessment_DocumentModifiedWhen
		, VHFHAMJ.DocumentModifiedWhen as Module_DocumentModifiedWhen
		, VHFHARCJ.DocumentModifiedWhen as RiskCategory_DocumentModifiedWhen
		, VHFHARAJ.DocumentModifiedWhen as RiskArea_DocumentModifiedWhen
		, VHFHAQ.DocumentModifiedWhen as Question_DocumentModifiedWhen
		, VHFHAA.DocumentModifiedWhen as Answer_DocumentModifiedWhen
FROM
  dbo.View_CMS_Tree_Joined AS VCTJ

 INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
 INNER JOIN HFit_Account hfa WITH(NOLOCK) ON cs.SiteID = hfa.SiteID
 INNER JOIN dbo.View_HFit_HACampaign_Joined c WITH(NOLOCK) ON VCTJ.NodeID = c.NodeParentID
 INNER JOIN View_HFit_HealthAssessment_Joined HA WITH (NOLOCK) ON c.HealthAssessmentID = HA.DocumentID
 INNER JOIN dbo.View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ ON HA.NodeID = VHFHAMJ.NodeParentID
 INNER JOIN dbo.View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
 INNER JOIN dbo.View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
 INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
 LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA ON VHFHAQ.NodeID = VHFHAA.NodeParentID

		--matrix level 1 questiongroup
		--INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ2 ON VHFHAQ.NodeID = VHFHAQ2.NodeParentID
		--INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA2 ON VHFHAQ2.NodeID = VHFHAA2.NodeParentID

		--Branching Level 1 Question 
		INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ3 ON VHFHAA.NodeID = VHFHAQ3.NodeParentID
		LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA3 ON VHFHAQ3.NodeID = VHFHAA3.NodeParentID

		--Matrix Level 2 Question Group
		--INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ7 ON VHFHAQ3.NodeID = VHFHAQ7.NodeParentID
		--INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA7 ON VHFHAQ7.NodeID = VHFHAA7.NodeParentID

		--Matrix branching level 1 question group
		--INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ8 ON VHFHAA7.NodeID = VHFHAQ8.NodeParentID
		--INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA8 ON VHFHAQ8.NodeID = VHFHAA8.NodeParentID

		--Branching level 2 Question Group
		INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ4 ON VHFHAA3.NodeID = VHFHAQ4.NodeParentID
		INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA4 ON VHFHAQ4.NodeID = VHFHAA4.NodeParentID

		--Branching level 3 Question Group
		INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ5 ON VHFHAA4.NodeID = VHFHAQ5.NodeParentID
		INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA5 ON VHFHAQ5.NodeID = VHFHAA5.NodeParentID
where VCTJ.DocumentCulture = 'en-us'	--WDM 08.07.2014
				AND VHFHAMJ.NodeName = 'Custom'

UNION ALL
--WDM 6/25/2014 Retrieve the Branching level 4 Question Group
	SELECT
		cs.SiteGUID
		, HFA.AccountCD
		, HA.NodeID		--WDM 08.07.2014
		, HA.NodeName		--WDM 08.07.2014
		, HA.DocumentID		--WDM 08.07.2014
		, HA.NodeSiteID		--WDM 08.07.2014
       --,VCTJ.NodeAliasPath
		, HA.DocumentPublishedVersionHistoryID		--WDM 08.07.2014
		, VHFHAMJ.Title
		, dbo.udf_StripHTML(left(VHFHAMJ.IntroText,4000)) AS IntroText
		, VHFHAMJ.DocumentGUID
		, VHFHAMJ.Weight
		, VHFHAMJ.IsEnabled
		, VHFHAMJ.CodeName
       --,VHFHAMJ.NodeAliasPath
		, VHFHAMJ.DocumentPublishedVersionHistoryID
		, VHFHARCJ.Title
		, VHFHARCJ.Weight
		, VHFHARCJ.DocumentGUID
		, VHFHARCJ.IsEnabled
		, VHFHARCJ.CodeName
       --,VHFHARCJ.NodeAliasPath
		, VHFHARCJ.DocumentPublishedVersionHistoryID
		, VHFHARAJ.Title
		, VHFHARAJ.Weight
		, VHFHARAJ.DocumentGUID
		, VHFHARAJ.IsEnabled
		, VHFHARAJ.CodeName
       --,VHFHARAJ.NodeAliasPath
		, VHFHARAJ.ScoringStrategyID
		, VHFHARAJ.DocumentPublishedVersionHistoryID
		, VHFHAQ6.QuestionType
		, dbo.udf_StripHTML(left(VHFHAQ6.Title,4000)) AS QuesTitle
		, VHFHAQ6.Weight
		, VHFHAQ6.IsRequired
		, VHFHAQ6.DocumentGUID
		, VHFHAQ6.IsEnabled
		, left(VHFHAQ6.IsVisible,4000)
		, VHFHAQ6.IsStaging
		, VHFHAQ6.CodeName AS QuestionCodeName
       --,VHFHAQ6.NodeAliasPath
		, VHFHAQ6.DocumentPublishedVersionHistoryID
		, VHFHAA6.Value
		, VHFHAA6.Points
		, VHFHAA6.DocumentGUID
		, VHFHAA6.IsEnabled
		, VHFHAA6.CodeName
		, VHFHAA6.UOM
       --,VHFHAA6.NodeAliasPath
		, VHFHAA6.DocumentPublishedVersionHistoryID
		, CASE	WHEN CAST(VCTJ.DocumentCreatedWhen AS DATE) = CAST(vctj.DocumentModifiedWhen AS DATE)
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		, VCTJ.DocumentCreatedWhen
		, VCTJ.DocumentModifiedWhen
		, VCTJ.NodeGuid as CmsTreeNodeGuid	--WDM 08.07.2014
 
		, CS.SiteLastModified
		, hfa.ItemModifiedWhen as Account_ItemModifiedWhen
		, c.DocumentModifiedWhen as Campaign_DocumentModifiedWhen
		, HA.DocumentModifiedWhen as Assessment_DocumentModifiedWhen
		, VHFHAMJ.DocumentModifiedWhen as Module_DocumentModifiedWhen
		, VHFHARCJ.DocumentModifiedWhen as RiskCategory_DocumentModifiedWhen
		, VHFHARAJ.DocumentModifiedWhen as RiskArea_DocumentModifiedWhen
		, VHFHAQ.DocumentModifiedWhen as Question_DocumentModifiedWhen
		, VHFHAA.DocumentModifiedWhen as Answer_DocumentModifiedWhen
FROM
  dbo.View_CMS_Tree_Joined AS VCTJ

 INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
 INNER JOIN HFit_Account hfa WITH(NOLOCK) ON cs.SiteID = hfa.SiteID
 INNER JOIN dbo.View_HFit_HACampaign_Joined c WITH(NOLOCK) ON VCTJ.NodeID = c.NodeParentID
 INNER JOIN View_HFit_HealthAssessment_Joined HA WITH (NOLOCK) ON c.HealthAssessmentID = HA.DocumentID
 INNER JOIN dbo.View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ ON HA.NodeID = VHFHAMJ.NodeParentID
 INNER JOIN dbo.View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
 INNER JOIN dbo.View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
 INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
 LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA ON VHFHAQ.NodeID = VHFHAA.NodeParentID

		--matrix level 1 questiongroup
		--INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ2 ON VHFHAQ.NodeID = VHFHAQ2.NodeParentID
		--INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA2 ON VHFHAQ2.NodeID = VHFHAA2.NodeParentID

		--Branching Level 1 Question 
		INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ3 ON VHFHAA.NodeID = VHFHAQ3.NodeParentID
		LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA3 ON VHFHAQ3.NodeID = VHFHAA3.NodeParentID

		--Matrix Level 2 Question Group
		--INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ7 ON VHFHAQ3.NodeID = VHFHAQ7.NodeParentID
		--INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA7 ON VHFHAQ7.NodeID = VHFHAA7.NodeParentID

		--Matrix branching level 1 question group
		--INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ8 ON VHFHAA7.NodeID = VHFHAQ8.NodeParentID
		--INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA8 ON VHFHAQ8.NodeID = VHFHAA8.NodeParentID

		--Branching level 2 Question Group
		INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ4 ON VHFHAA3.NodeID = VHFHAQ4.NodeParentID
		INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA4 ON VHFHAQ4.NodeID = VHFHAA4.NodeParentID

		--Branching level 3 Question Group
		--select count(*) from dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA4
		INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ5 ON VHFHAA4.NodeID = VHFHAQ5.NodeParentID
		INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA5 ON VHFHAQ5.NodeID = VHFHAA5.NodeParentID

		--Branching level 4 Question Group
		INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ6 ON VHFHAA5.NodeID = VHFHAQ6.NodeParentID
		INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA6 ON VHFHAQ6.NodeID = VHFHAA6.NodeParentID
where VCTJ.DocumentCulture = 'en-us'	--WDM 08.07.2014
				AND VHFHAMJ.NodeName = 'Custom'

UNION ALL
	--WDM 6/25/2014 Retrieve the Branching level 5 Question Group
	SELECT
		cs.SiteGUID
		, HFA.AccountCD
		, HA.NodeID		--WDM 08.07.2014
		, HA.NodeName		--WDM 08.07.2014
		, HA.DocumentID		--WDM 08.07.2014
		, HA.NodeSiteID		--WDM 08.07.2014
       --,VCTJ.NodeAliasPath
		, HA.DocumentPublishedVersionHistoryID		--WDM 08.07.2014
		, VHFHAMJ.Title
		, dbo.udf_StripHTML(left(VHFHAMJ.IntroText,4000)) AS IntroText
		, VHFHAMJ.DocumentGUID
		, VHFHAMJ.Weight
		, VHFHAMJ.IsEnabled
		, VHFHAMJ.CodeName
       --,VHFHAMJ.NodeAliasPath
		, VHFHAMJ.DocumentPublishedVersionHistoryID
		, VHFHARCJ.Title
		, VHFHARCJ.Weight
		, VHFHARCJ.DocumentGUID
		, VHFHARCJ.IsEnabled
		, VHFHARCJ.CodeName
       --,VHFHARCJ.NodeAliasPath
		, VHFHARCJ.DocumentPublishedVersionHistoryID
		, VHFHARAJ.Title
		, VHFHARAJ.Weight
		, VHFHARAJ.DocumentGUID
		, VHFHARAJ.IsEnabled
		, VHFHARAJ.CodeName
       --,VHFHARAJ.NodeAliasPath
		, VHFHARAJ.ScoringStrategyID
		, VHFHARAJ.DocumentPublishedVersionHistoryID
		, VHFHAQ9.QuestionType
		, dbo.udf_StripHTML(left(VHFHAQ9.Title,4000)) AS QuesTitle
		, VHFHAQ9.Weight
		, VHFHAQ9.IsRequired
		, VHFHAQ9.DocumentGUID
		, VHFHAQ9.IsEnabled
		, left(VHFHAQ9.IsVisible,4000)
		, VHFHAQ9.IsStaging
		, VHFHAQ9.CodeName AS QuestionCodeName
       --,VHFHAQ9.NodeAliasPath
		, VHFHAQ9.DocumentPublishedVersionHistoryID
		, VHFHAA9.Value
		, VHFHAA9.Points
		, VHFHAA9.DocumentGUID
		, VHFHAA9.IsEnabled
		, VHFHAA9.CodeName
		, VHFHAA9.UOM
       --,VHFHAA9.NodeAliasPath
		, VHFHAA9.DocumentPublishedVersionHistoryID
		, CASE	WHEN CAST(VCTJ.DocumentCreatedWhen AS DATE) = CAST(vctj.DocumentModifiedWhen AS DATE)
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		, VCTJ.DocumentCreatedWhen
		, VCTJ.DocumentModifiedWhen
		, VCTJ.NodeGuid as CmsTreeNodeGuid	--WDM 08.07.2014
 
		, CS.SiteLastModified
		, hfa.ItemModifiedWhen as Account_ItemModifiedWhen
		, c.DocumentModifiedWhen as Campaign_DocumentModifiedWhen
		, HA.DocumentModifiedWhen as Assessment_DocumentModifiedWhen
		, VHFHAMJ.DocumentModifiedWhen as Module_DocumentModifiedWhen
		, VHFHARCJ.DocumentModifiedWhen as RiskCategory_DocumentModifiedWhen
		, VHFHARAJ.DocumentModifiedWhen as RiskArea_DocumentModifiedWhen
		, VHFHAQ.DocumentModifiedWhen as Question_DocumentModifiedWhen
		, VHFHAA.DocumentModifiedWhen as Answer_DocumentModifiedWhen
FROM
  dbo.View_CMS_Tree_Joined AS VCTJ

 INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
 INNER JOIN HFit_Account hfa WITH(NOLOCK) ON cs.SiteID = hfa.SiteID
 INNER JOIN dbo.View_HFit_HACampaign_Joined c WITH(NOLOCK) ON VCTJ.NodeID = c.NodeParentID
 INNER JOIN View_HFit_HealthAssessment_Joined HA WITH (NOLOCK) ON c.HealthAssessmentID = HA.DocumentID
 INNER JOIN dbo.View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ ON HA.NodeID = VHFHAMJ.NodeParentID
 INNER JOIN dbo.View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
 INNER JOIN dbo.View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
 INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
 LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA ON VHFHAQ.NodeID = VHFHAA.NodeParentID

		--matrix level 1 questiongroup
		--INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ2 ON VHFHAQ.NodeID = VHFHAQ2.NodeParentID
		--INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA2 ON VHFHAQ2.NodeID = VHFHAA2.NodeParentID

		--Branching Level 1 Question 
		INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ3 ON VHFHAA.NodeID = VHFHAQ3.NodeParentID
		LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA3 ON VHFHAQ3.NodeID = VHFHAA3.NodeParentID

		--Matrix Level 2 Question Group
		--INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ7 ON VHFHAQ3.NodeID = VHFHAQ7.NodeParentID
		--INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA7 ON VHFHAQ7.NodeID = VHFHAA7.NodeParentID

		--Matrix branching level 1 question group
		--INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ8 ON VHFHAA7.NodeID = VHFHAQ8.NodeParentID
		--INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA8 ON VHFHAQ8.NodeID = VHFHAA8.NodeParentID

		--Branching level 2 Question Group
		INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ4 ON VHFHAA3.NodeID = VHFHAQ4.NodeParentID
		INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA4 ON VHFHAQ4.NodeID = VHFHAA4.NodeParentID

		--Branching level 3 Question Group
		--select count(*) from dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA4
		INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ5 ON VHFHAA4.NodeID = VHFHAQ5.NodeParentID
		INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA5 ON VHFHAQ5.NodeID = VHFHAA5.NodeParentID

		--Branching level 4 Question Group
		INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ6 ON VHFHAA5.NodeID = VHFHAQ6.NodeParentID
		INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA6 ON VHFHAQ6.NodeID = VHFHAA6.NodeParentID

		--Branching level 5 Question Group
		INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ9 ON VHFHAA6.NodeID = VHFHAQ9.NodeParentID
		INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA9 ON VHFHAQ9.NodeID = VHFHAA9.NodeParentID
where VCTJ.DocumentCulture = 'en-us'	--WDM 08.07.2014
				AND VHFHAMJ.NodeName = 'Custom'




GO




if exists(select TABLE_NAME from INFORMATION_SCHEMA.VIEWS where TABLE_NAME = 'View_EDW_HealthAssesmentQuestions')
BEGIN
	drop view View_EDW_HealthAssesmentQuestions ;
END
GO


create VIEW [dbo].[View_EDW_HealthAssesmentQuestions]

AS 
--**********************************************************************************
--09.11.2014 (wdm) Added the DocumentModifiedWhen to facilitate the EDW need to 
--		determine the last mod date of a record.
--**********************************************************************************
SELECT 
	VHFHAMCQJ.ClassName AS QuestionType,
	VHFHAMCQJ.Title,
	VHFHAMCQJ.Weight,
	VHFHAMCQJ.IsRequired,
	VHFHAMCQJ.QuestionImageLeft,
	VHFHAMCQJ.QuestionImageRight,
	VHFHAMCQJ.NodeGUID,	
	VHFHAMCQJ.DocumentCulture,
	VHFHAMCQJ.IsEnabled,
	VHFHAMCQJ.IsVisible,
	VHFHAMCQJ.IsStaging,
	VHFHAMCQJ.CodeName,
	VHFHAMCQJ.QuestionGroupCodeName,
	VHFHAMCQJ.NodeAliasPath,
	VHFHAMCQJ.DocumentPublishedVersionHistoryID,
	VHFHAMCQJ.NodeLevel,
	VHFHAMCQJ.NodeOrder,
	VHFHAMCQJ.NodeID,
	VHFHAMCQJ.NodeParentID,
	VHFHAMCQJ.NodeLinkedNodeID, 
	0 AS DontKnowEnabled, 
	'' AS DontKnowLabel,
	(select pp.NodeOrder from dbo.CMS_Tree pp inner join dbo.CMS_Tree p on p.NodeParentID = pp.NodeID where p.NodeID = VHFHAMCQJ.NodeParentID) AS ParentNodeOrder
	,VHFHAMCQJ.DocumentGuid
	,VHFHAMCQJ.DocumentModifiedWhen	--(WDM) 09.11.2014 added to facilitate determining document last mod date 
FROM dbo.View_HFit_HealthAssesmentMultipleChoiceQuestion_Joined AS VHFHAMCQJ WITH(NOLOCK)

UNION ALL 
SELECT 
	VHFHAMQJ.ClassName AS QuestionType,
	VHFHAMQJ.Title,
	VHFHAMQJ.Weight,
	VHFHAMQJ.IsRequired,
	VHFHAMQJ.QuestionImageLeft,
	VHFHAMQJ.QuestionImageRight,
	VHFHAMQJ.NodeGUID,
	VHFHAMQJ.DocumentCulture,
	VHFHAMQJ.IsEnabled,
	VHFHAMQJ.IsVisible,
	VHFHAMQJ.IsStaging,
	VHFHAMQJ.CodeName,
	VHFHAMQJ.QuestionGroupCodeName,
	VHFHAMQJ.NodeAliasPath,
	VHFHAMQJ.DocumentPublishedVersionHistoryID,
	VHFHAMQJ.NodeLevel,
	VHFHAMQJ.NodeOrder,
	VHFHAMQJ.NodeID,
	VHFHAMQJ.NodeParentID,
	VHFHAMQJ.NodeLinkedNodeID,
	0 AS DontKnowEnabled, 
	'' AS DontKnowLabel,
		(select pp.NodeOrder from dbo.CMS_Tree pp inner join dbo.CMS_Tree p on p.NodeParentID = pp.NodeID where p.NodeID = VHFHAMQJ.NodeParentID) AS ParentNodeOrder
	,VHFHAMQJ.DocumentGuid
	,VHFHAMQJ.DocumentModifiedWhen	--(WDM) 09.11.2014 added to facilitate determining document last mod date 
FROM dbo.View_HFit_HealthAssesmentMatrixQuestion_Joined AS VHFHAMQJ WITH(NOLOCK)

UNION ALL 
SELECT 
	VHFHAFFJ.ClassName AS QuestionType,
	VHFHAFFJ.Title,
	VHFHAFFJ.Weight,
	VHFHAFFJ.IsRequired,
	VHFHAFFJ.QuestionImageLeft,
	'' AS QuestionImageRight,
	VHFHAFFJ.NodeGUID,
	VHFHAFFJ.DocumentCulture,
	VHFHAFFJ.IsEnabled,
	VHFHAFFJ.IsVisible,
	VHFHAFFJ.IsStaging,
	VHFHAFFJ.CodeName,
	VHFHAFFJ.QuestionGroupCodeName,
	VHFHAFFJ.NodeAliasPath,
	VHFHAFFJ.DocumentPublishedVersionHistoryID,
	VHFHAFFJ.NodeLevel,
	VHFHAFFJ.NodeOrder,
	VHFHAFFJ.NodeID,
	VHFHAFFJ.NodeParentID,
	VHFHAFFJ.NodeLinkedNodeID,
	VHFHAFFJ.DontKnowEnabled,
	VHFHAFFJ.DontKnowLabel,
	(select pp.NodeOrder from dbo.CMS_Tree pp inner join dbo.CMS_Tree p on p.NodeParentID = pp.NodeID where p.NodeID = VHFHAFFJ.NodeParentID) AS ParentNodeOrder
	,VHFHAFFJ.DocumentGuid
	,VHFHAFFJ.DocumentModifiedWhen	--(WDM) 09.11.2014 added to facilitate determining document last mod date 
FROM dbo.View_HFit_HealthAssessmentFreeForm_Joined AS VHFHAFFJ WITH(NOLOCK)





GO



if exists(select TABLE_NAME from INFORMATION_SCHEMA.VIEWS where TABLE_NAME = 'view_EDW_HealthAssessmentDefinition_Staged')
BEGIN
	drop view view_EDW_HealthAssessmentDefinition_Staged ;
END
GO

create view [dbo].[view_EDW_HealthAssessmentDefinition_Staged]
as
--****************************************************************************
--09/04/2014 WDM
--The view Health Assessment Definition runs very poorly. This view/table is 
--created as as a staging table allowing the data to already exist when the 
--EDW needs it. This is the view that data from the staging table 
--(EDW_HealthAssessmentDefinition) allowing the EDW to launch a much faster 
--start when processing Health Assessment Definition data.
--****************************************************************************
SELECT [SiteGuid]
      ,[AccountCD]
      ,[HANodeID]
      ,[HANodeName]
      ,[HADocumentID]
      ,[HANodeSiteID]
      ,[HADocPubVerID]
      ,[ModTitle]
      ,[IntroText]
      ,[ModDocGuid]
      ,[ModWeight]
      ,[ModIsEnabled]
      ,[ModCodeName]
      ,[ModDocPubVerID]
      ,[RCTitle]
      ,[RCWeight]
      ,[RCDocumentGUID]
      ,[RCIsEnabled]
      ,[RCCodeName]
      ,[RCDocPubVerID]
      ,[RATytle]
      ,[RAWeight]
      ,[RADocumentGuid]
      ,[RAIsEnabled]
      ,[RACodeName]
      ,[RAScoringStrategyID]
      ,[RADocPubVerID]
      ,[QuestionType]
      ,[QuesTitle]
      ,[QuesWeight]
      ,[QuesIsRequired]
      ,[QuesDocumentGuid]
      ,[QuesIsEnabled]
      ,[QuesIsVisible]
      ,[QuesIsSTaging]
      ,[QuestionCodeName]
      ,[QuesDocPubVerID]
      ,[AnsValue]
      ,[AnsPoints]
      ,[AnsDocumentGuid]
      ,[AnsIsEnabled]
      ,[AnsCodeName]
      ,[AnsUOM]
      ,[AnsDocPUbVerID]
      ,[ChangeType]
      ,[DocumentCreatedWhen]
      ,[DocumentModifiedWhen]
      ,[CmsTreeNodeGuid]
      ,[HANodeGUID]
  FROM [dbo].[EDW_HealthAssessmentDefinition]

GO



if exists(select TABLE_NAME from INFORMATION_SCHEMA.VIEWS where TABLE_NAME = 'view_EDW_HealthAssessment_Staged')
BEGIN
	drop view view_EDW_HealthAssessment_Staged ;
END
GO

create view [dbo].[view_EDW_HealthAssessment_Staged]
as
--****************************************************************************
--09/04/2014 WDM
--The view Health Assessment runs poorly. This view/table is created as 
--as a staging table allowing the data to already exist when the EDW needs it.
--This is the view that pulls data from the staging table (EDW_HealthAssessment) 
--allowing the EDW to launch a much faster start when processing Health 
--Assessment data.
--****************************************************************************
SELECT [UserStartedItemID]
      ,[HealthAssesmentUserStartedNodeGUID]
      ,[UserID]
      ,[UserGUID]
      ,[HFitUserMpiNumber]
      ,[SiteGUID]
      ,[AccountID]
      ,[AccountCD]
      ,[HAStartedDt]
      ,[HACompletedDt]
      ,[UserModuleItemId]
      ,[UserModuleCodeName]
      ,[HAModuleNodeGUID]
      ,[HAModuleVersionID]
      ,[UserRiskCategoryItemID]
      ,[UserRiskCategoryCodeName]
      ,[HARiskCategoryNodeGUID]
      ,[HARiskCategoryVersionID]
      ,[UserRiskAreaItemID]
      ,[UserRiskAreaCodeName]
      ,[HARiskAreaNodeGUID]
      ,[HARiskAreaVersionID]
      ,[UserQuestionItemID]
      ,[Title]
      ,[HAQuestionGuid]
      ,[UserQuestionCodeName]
      ,[HAQuestionDocumentID]
      ,[HAQuestionVersionID]
      ,[HAQuestionNodeGUID]
      ,[UserAnswerItemID]
      ,[HAAnswerNodeGUID]
      ,[HAAnswerVersionID]
      ,[UserAnswerCodeName]
      ,[HAAnswerValue]
      ,[HAModuleScore]
      ,[HARiskCategoryScore]
      ,[HARiskAreaScore]
      ,[HAQuestionScore]
      ,[HAAnswerPoints]
      ,[PointResults]
      ,[UOMCode]
      ,[HAScore]
      ,[ModulePreWeightedScore]
      ,[RiskCategoryPreWeightedScore]
      ,[RiskAreaPreWeightedScore]
      ,[QuestionPreWeightedScore]
      ,[QuestionGroupCodeName]
      ,[ChangeType]
      ,[ItemCreatedWhen]
      ,[ItemModifiedWhen]
  FROM [dbo].[EDW_HealthAssessment]

GO




if exists(select TABLE_NAME from INFORMATION_SCHEMA.VIEWS where TABLE_NAME = 'view_EDW_Participant')
BEGIN
	drop view view_EDW_Participant ;
END
GO


--*********************************************************************************************
--WDM Reviewed 8/6/2014 for needed updates, none required
--09.11.2014 (wdm) added date fields to facilitate EDW determination of last mod date 
--*********************************************************************************************
create VIEW [dbo].[view_EDW_Participant]
AS
	SELECT
		cus.HFitUserMpiNumber
		, cu.UserID
		, cu.UserGUID
		, CS.SiteGUID
		, hfa.AccountID
		, hfa.AccountCD
		, cus.HFitUserPreferredMailingAddress
		, cus.HFitUserPreferredMailingCity
		, cus.HFitUserPreferredMailingState
		, cus.HFitUserPreferredMailingPostalCode
		, cus.HFitCoachingEnrollDate
		, cus.HFitUserAltPreferredPhone
		, cus.HFitUserAltPreferredPhoneExt
		, cus.HFitUserAltPreferredPhoneType
		, cus.HFitUserPreferredPhone
		, cus.HFitUserPreferredFirstName
		, CASE	WHEN CAST(cu.UserCreated AS DATE) = CAST(cu.UserLastModified AS DATE)
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		, cu.UserCreated
		, cu.UserLastModified
		, HFA.ItemModifiedWhen as Account_ItemModifiedWhen	--wdm: 09.11.2014 added to view
	FROM
		dbo.CMS_User AS CU
	INNER JOIN dbo.CMS_UserSite AS CUS2 WITH ( NOLOCK ) ON CU.UserID = CUS2.UserID
	INNER JOIN dbo.HFit_Account AS HFA WITH ( NOLOCK ) ON cus2.SiteID = hfa.SiteID
	INNER JOIN dbo.CMS_Site AS CS WITH ( NOLOCK ) ON CUS2.SiteID = CS.SiteID
	INNER JOIN dbo.CMS_UserSettings AS CUS WITH ( NOLOCK ) ON CU.UserID = CUS.UserSettingsUserID







GO



if exists(select TABLE_NAME from INFORMATION_SCHEMA.VIEWS where TABLE_NAME = 'view_EDW_RewardAwardDetail')
BEGIN
	drop view view_EDW_RewardAwardDetail ;
END
GO




--***************************************************************************
--WDM Reviewed 8/6/2014 for needed updates, none required
--09.11.2014 : (wdm) reviewed for EDW last mod date and the view is OK as is
--***************************************************************************
CREATE VIEW [dbo].[view_EDW_RewardAwardDetail]
AS
	SELECT DISTINCT
		cu.UserGUID
		, cs.SiteGUID
		, cus.HFitUserMpiNumber
		, VHFRLJ.RewardLevelID
		, HFRAUD.AwardDisplayName
		, HFRAUD.RewardValue
		, HFRAUD.ThresholdNumber
		, HFRAUD.UserNotified
		, HFRAUD.IsFulfilled
		, hfa.AccountID
		, HFA.AccountCD
		, CASE	WHEN CAST(HFRAUD.ItemCreatedWhen AS DATE) = CAST(HFRAUD.ItemModifiedWhen AS DATE)
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		, HFRAUD.ItemCreatedWhen
		, HFRAUD.ItemModifiedWhen
	FROM
		dbo.HFit_RewardsAwardUserDetail AS HFRAUD WITH ( NOLOCK )
	INNER JOIN dbo.View_HFit_RewardLevel_Joined AS VHFRLJ WITH ( NOLOCK ) ON hfraud.RewardLevelNodeId = VHFRLJ.NodeID
	INNER JOIN dbo.CMS_User AS CU WITH ( NOLOCK ) ON hfraud.UserId = cu.UserID
	INNER JOIN dbo.CMS_UserSite AS CUS2 WITH ( NOLOCK ) ON cu.UserID = cus2.UserID
	INNER JOIN dbo.HFit_Account AS HFA WITH ( NOLOCK ) ON cus2.SiteID = HFA.SiteID
	INNER JOIN dbo.CMS_Site AS CS WITH ( NOLOCK ) ON CUS2.SiteID = CS.SiteID
	INNER JOIN dbo.CMS_UserSettings AS CUS WITH ( NOLOCK ) ON cu.UserID = cus.UserSettingsUserID
       






GO



if exists(select TABLE_NAME from INFORMATION_SCHEMA.VIEWS where TABLE_NAME = 'view_EDW_RewardsDefinition')
BEGIN
	drop view view_EDW_RewardsDefinition ;
END
GO



--GRANT SELECT
--	ON [dbo].[view_EDW_RewardsDefinition]
--	TO [EDWReader_PRD]
--GO



create VIEW [dbo].[view_EDW_RewardsDefinition]
AS
--**********************************************************************************
--WDM Reviewed 8/6/2014 for needed updates, may be needed
--	My question - Is NodeGUID going to be passed onto the children
--8/7/2014 - added and commented out DocumentGuid in case needed later
--8/8/2014 - Generated corrected view in DEV (WDM)
--09.11.2014 : Added to facilitate EDW Last Mod Date determination
--**********************************************************************************
	SELECT DISTINCT
		cs.SiteGUID
		, HFA.AccountID
		, hfa.AccountCD
		, RewardProgramID
		, RewardProgramName
		, RewardProgramPeriodStart
		, RewardProgramPeriodEnd
		, ProgramDescription
		, RewardGroupID
		, GroupName
		, RewardContactGroups
		, RewardGroupPeriodStart
		, RewardGroupPeriodEnd
		, RewardLevelID
		, [Level]
		, RewardLevelTypeLKPName
		, RewardLevelPeriodStart
		, RewardLevelPeriodEnd
		, FrequencyMenu
		, AwardDisplayName
		, AwardType
		, AwardThreshold1
		, AwardThreshold2
		, AwardThreshold3
		, AwardThreshold4
		, AwardValue1
		, AwardValue2
		, AwardValue3
		, AwardValue4
		, CompletionText
		, ExternalFulfillmentRequired
		, RewardHistoryDetailDescription
		, VHFRAJ.RewardActivityID
		, VHFRAJ.ActivityName
		, VHFRAJ.ActivityFreqOrCrit
		, VHFRAJ.RewardActivityPeriodStart
		, VHFRAJ.RewardActivityPeriodEnd
		, VHFRAJ.RewardActivityLKPID
		, VHFRAJ.ActivityPoints
		, VHFRAJ.IsBundle
		, VHFRAJ.IsRequired
		, VHFRAJ.MaxThreshold
		, VHFRAJ.AwardPointsIncrementally
		, VHFRAJ.AllowMedicalExceptions
		, VHFRAJ.BundleText
		, RewardTriggerID
		, HFLRT.RewardTriggerDynamicValue
		, TriggerName
		, RequirementDescription
		, VHFRTPJ.RewardTriggerParameterOperator
		, VHFRTPJ.Value
		, vhfrtpj.ParameterDisplayName
		, CASE	WHEN CAST(VHFRPJ.DocumentCreatedWhen AS DATE) = CAST(VHFRPJ.DocumentModifiedWhen AS DATE)
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		, VHFRPJ.DocumentGuid	--WDM Added 8/7/2014 in case needed
		
		, VHFRPJ.DocumentCreatedWhen
		, VHFRPJ.DocumentModifiedWhen
		
		, VHFRAJ.DocumentModifiedWhen as RewardActivity_DocumentModifiedWhen	--09.11.2014 : Added to facilitate EDW Last Mod Date determination
	FROM 
	dbo.View_HFit_RewardProgram_Joined AS VHFRPJ
	INNER JOIN dbo.View_HFit_RewardGroup_Joined AS VHFRGJ ON VHFRPJ.NodeID = VHFRGJ.NodeParentID
	INNER JOIN dbo.View_HFit_RewardLevel_Joined AS VHFRLJ ON VHFRGJ.NodeID = VHFRLJ.NodeParentID
	INNER JOIN dbo.HFit_LKP_RewardLevelType AS HFLRLT ON VHFRLJ.LevelType = HFLRLT.RewardLevelTypeLKPID
	INNER JOIN dbo.View_HFit_RewardActivity_Joined AS VHFRAJ ON VHFRLJ.NodeID = VHFRAJ.NodeParentID
	INNER JOIN dbo.View_HFit_RewardTrigger_Joined AS VHFRTJ ON VHFRAJ.NodeID = VHFRTJ.NodeParentID
	INNER JOIN dbo.View_HFit_RewardTriggerParameter_Joined AS VHFRTPJ ON vhfrtj.nodeid = vhfrtpj.nodeparentid
	INNER JOIN dbo.HFit_LKP_RewardTrigger AS HFLRT ON VHFRTJ.RewardTriggerLKPID = HFLRT.RewardTriggerLKPID
	INNER JOIN dbo.CMS_Site AS CS ON VHFRPJ.NodeSiteID = cs.SiteID
	INNER JOIN dbo.HFit_Account AS HFA ON cs.SiteID = HFA.SiteID
	


GO



--if exists(select TABLE_NAME from INFORMATION_SCHEMA.VIEWS where TABLE_NAME = 'view_EDW_RewardsDefinition_TEST')
--BEGIN
--	drop view view_EDW_RewardsDefinition_TEST ;
--END
--GO



--CREATE VIEW [dbo].[view_EDW_RewardsDefinition_TEST]
--AS
----WDM Reviewed 8/6/2014 for needed updates, may be needed
----	My question - Is NodeGUID going to be passed onto the children
----8/7/2014 - added and commented out DocumentGuid in case needed later
----8/8/2014 - Generated corrected view in DEV (WDM)
--	SELECT DISTINCT
--		cs.SiteGUID
--		, HFA.AccountID
--		, hfa.AccountCD
--		, RewardProgramID
--		, RewardProgramName
--		, RewardProgramPeriodStart
--		, RewardProgramPeriodEnd
--		, ProgramDescription
--		, RewardGroupID
--		, GroupName
--		, RewardContactGroups
--		, RewardGroupPeriodStart
--		, RewardGroupPeriodEnd
--		, RewardLevelID
--		, [Level]
--		, RewardLevelTypeLKPName
--		, RewardLevelPeriodStart
--		, RewardLevelPeriodEnd
--		, FrequencyMenu
--		, AwardDisplayName
--		, AwardType
--		, AwardThreshold1
--		, AwardThreshold2
--		, AwardThreshold3
--		, AwardThreshold4
--		, AwardValue1
--		, AwardValue2
--		, AwardValue3
--		, AwardValue4
--		, CompletionText
--		, ExternalFulfillmentRequired
--		, RewardHistoryDetailDescription
--		, VHFRAJ.RewardActivityID
--		, VHFRAJ.ActivityName
--		, VHFRAJ.ActivityFreqOrCrit
--		, VHFRAJ.RewardActivityPeriodStart
--		, VHFRAJ.RewardActivityPeriodEnd
--		, VHFRAJ.RewardActivityLKPID
--		, VHFRAJ.ActivityPoints
--		, VHFRAJ.IsBundle
--		, VHFRAJ.IsRequired
--		, VHFRAJ.MaxThreshold
--		, VHFRAJ.AwardPointsIncrementally
--		, VHFRAJ.AllowMedicalExceptions
--		, VHFRAJ.BundleText
--		, RewardTriggerID
--		, HFLRT.RewardTriggerDynamicValue
--		, TriggerName
--		, RequirementDescription
--		, VHFRTPJ.RewardTriggerParameterOperator
--		, VHFRTPJ.Value
--		, vhfrtpj.ParameterDisplayName
--		, CASE	WHEN CAST(VHFRPJ.DocumentCreatedWhen AS DATE) = CAST(VHFRPJ.DocumentModifiedWhen AS DATE)
--				THEN 'I'
--				ELSE 'U'
--			END AS ChangeType
--		, VHFRPJ.DocumentCreatedWhen
--		, VHFRPJ.DocumentModifiedWhen
--		, VHFRPJ.DocumentGuid	--WDM Added 8/7/2014 in case needed		
--		, VHFRGJ.DocumentModifiedWhen as RewardGroup_DocumentModifiedWhen	--WDM Added 9.10.2014
--		, VHFRLJ.DocumentModifiedWhen as RewardLevel_DocumentModifiedWhen	--WDM Added 9.10.2014		
--		, VHFRAJ.DocumentModifiedWhen as RewardActivity_DocumentModifiedWhen	--WDM Added 9.10.2014
--		, VHFRTJ.DocumentModifiedWhen as RewardTrigger_DocumentModifiedWhen	--WDM Added 9.10.2014
--		, VHFRTPJ.DocumentModifiedWhen as RewardTriggerParameter_DocumentModifiedWhen	--WDM Added 9.10.2014
--		, HFLRT.ItemModifiedWhen as LKP_RewardTrigger_ItemModifiedWhen	--WDM Added 9.10.2014
--		, HFA.ItemModifiedWhen as Account_ItemModifiedWhen	--WDM Added 9.10.2014
--		, CS.SiteLastModified as Site_SiteLastModified	--WDM Added 9.10.2014
--	FROM 
--	dbo.View_HFit_RewardProgram_Joined AS VHFRPJ
--	INNER JOIN dbo.View_HFit_RewardGroup_Joined AS VHFRGJ ON VHFRPJ.NodeID = VHFRGJ.NodeParentID
--	INNER JOIN dbo.View_HFit_RewardLevel_Joined AS VHFRLJ ON VHFRGJ.NodeID = VHFRLJ.NodeParentID
--	INNER JOIN dbo.HFit_LKP_RewardLevelType AS HFLRLT ON VHFRLJ.LevelType = HFLRLT.RewardLevelTypeLKPID
--	INNER JOIN dbo.View_HFit_RewardActivity_Joined AS VHFRAJ ON VHFRLJ.NodeID = VHFRAJ.NodeParentID
--	INNER JOIN dbo.View_HFit_RewardTrigger_Joined AS VHFRTJ ON VHFRAJ.NodeID = VHFRTJ.NodeParentID
--	INNER JOIN dbo.View_HFit_RewardTriggerParameter_Joined AS VHFRTPJ ON vhfrtj.nodeid = vhfrtpj.nodeparentid
--	INNER JOIN dbo.HFit_LKP_RewardTrigger AS HFLRT ON VHFRTJ.RewardTriggerLKPID = HFLRT.RewardTriggerLKPID
--	INNER JOIN dbo.CMS_Site AS CS ON VHFRPJ.NodeSiteID = cs.SiteID
--	INNER JOIN dbo.HFit_Account AS HFA ON cs.SiteID = HFA.SiteID
	


--GO



if exists(select TABLE_NAME from INFORMATION_SCHEMA.VIEWS where TABLE_NAME = 'view_EDW_RewardTriggerParameters')
BEGIN
	drop view view_EDW_RewardTriggerParameters ;
END
GO


--GRANT SELECT
--	ON [dbo].[view_EDW_RewardTriggerParameters]
--	TO [EDWReader_PRD]
--GO


--********************************************************************************************************
--09.11.2014 : (wdm) Verified last mod date available to EDW - RewardTriggerParameter_DocumentModifiedWhen
--********************************************************************************************************
create VIEW [dbo].[view_EDW_RewardTriggerParameters]
AS
--8/7/2014 - added and commented out DocumentGuid and NodeGuid in case needed later
--8/8/2014 - Generated corrected view in DEV (WDM)
	SELECT distinct
		cs.SiteGUID
		, VHFRTJ.RewardTriggerID
		, VHFRTJ.TriggerName
		, HFLRTPO.RewardTriggerParameterOperatorLKPDisplayName
		, VHFRTPJ.ParameterDisplayName
		, VHFRTPJ.RewardTriggerParameterOperator
		, VHFRTPJ.Value
		, hfa.AccountID
		, hfa.AccountCD
		, CASE	WHEN CAST(VHFRTJ.DocumentCreatedWhen AS DATE) = CAST(VHFRTJ.DocumentModifiedWhen AS DATE)
				THEN 'I'
				ELSE 'U'
			END AS ChangeType		
		, VHFRTJ.DocumentGuid		--WDM Added 8/7/2014 in case needed
		, VHFRTJ.NodeGuid		--WDM Added 8/7/2014 in case needed
		, VHFRTJ.DocumentCreatedWhen
		, VHFRTJ.DocumentModifiedWhen

		,VHFRTPJ.DocumentModifiedWhen as RewardTriggerParameter_DocumentModifiedWhen
	FROM
		dbo.View_HFit_RewardTrigger_Joined AS VHFRTJ WITH ( NOLOCK )
	INNER JOIN dbo.View_HFit_RewardTriggerParameter_Joined AS VHFRTPJ WITH ( NOLOCK ) ON vhfrtj.NodeID = VHFRTPJ.NodeParentID
	INNER JOIN dbo.HFit_LKP_RewardTriggerParameterOperator AS HFLRTPO WITH ( NOLOCK ) ON VHFRTPJ.RewardTriggerParameterOperator = HFLRTPO.RewardTriggerParameterOperatorLKPID
	INNER JOIN dbo.CMS_Site AS CS WITH ( NOLOCK ) ON VHFRTJ.NodeSiteID = cs.SiteID
	INNER JOIN dbo.HFit_Account AS HFA WITH ( NOLOCK ) ON cs.SiteID = HFA.SiteID
      







GO



if exists(select TABLE_NAME from INFORMATION_SCHEMA.VIEWS where TABLE_NAME = 'view_EDW_RewardUserDetail')
BEGIN
	drop view view_EDW_RewardUserDetail ;
END
GO


--GRANT SELECT
--	ON [dbo].[view_EDW_RewardUserDetail]
--	TO [EDWReader_PRD]
--GO

create VIEW [dbo].[view_EDW_RewardUserDetail]
AS

	--********************************************************************************************************************
	--select * from [view_EDW_RewardUserDetail] where ItemModifiedWhen between '2000-11-14' and '2014-11-15'
	--select * from [view_EDW_RewardUserDetail] where ItemModifiedWhen between '2014-05-12' and '2014-05-13' 
	--8/7/2014 - added and commented out DocumentGuid and NodeGuid in case needed later
	--8/08/2014 - Generated corrected view in DEV (WDM)
	--8/12/2014 - Performance Issue - 00:06:49 @ 258502
	--8/12/2014 - Performance Issue - Add PI01_view_EDW_RewardUserDetail
	--8/12/2014 - Performance Issue - 00:03:46 @ 258502
	--8/12/2014 - Performance Issue - Add PI02_view_EDW_RewardUserDetail
	--8/12/2014 - Performance Issue - 00:03:45 @ 258502
	--8/19/2014 - (WDM) Added where clause to make the query return english data only.	
	--09.11.2014 : (wdm) Verified last mod date available to EDW - RewardsUserActivity_ItemModifiedWhen
	--				RewardExceptionModifiedDate, RewardTrigger_DocumentModifiedWhen
	--********************************************************************************************************************

	SELECT 
		cu.UserGUID
		, CS2.SiteGUID
		, cus2.HFitUserMpiNumber
		, VHFRAJ.RewardActivityID
		, VHFRPJ.RewardProgramName
		, VHFRPJ.RewardProgramID
		, VHFRPJ.RewardProgramPeriodStart
		, VHFRPJ.RewardProgramPeriodEnd
		, VHFRPJ.DocumentModifiedWhen AS RewardModifiedDate
		, VHFRGJ.GroupName
		, VHFRGJ.RewardGroupID
		, VHFRGJ.RewardGroupPeriodStart
		, VHFRGJ.RewardGroupPeriodEnd
		, VHFRGJ.DocumentModifiedWhen AS RewardGroupModifieDate
		, VHFRLJ.Level
		, HFLRLT.RewardLevelTypeLKPName
		, VHFRLJ.DocumentModifiedWhen AS RewardLevelModifiedDate
		, HFRULD.LevelCompletedDt
		, HFRULD.LevelVersionHistoryID
		, VHFRLJ.RewardLevelPeriodStart
		, VHFRLJ.RewardLevelPeriodEnd
		, VHFRAJ.ActivityName
		, HFRUAD.ActivityPointsEarned
		, HFRUAD.ActivityCompletedDt
		, HFRUAD.ActivityVersionID
		, HFRUAD.ItemModifiedWhen AS RewardActivityModifiedDate
		, VHFRAJ.RewardActivityPeriodStart
		, VHFRAJ.RewardActivityPeriodEnd
		, VHFRAJ.ActivityPoints
		, HFRE.UserAccepted
		, HFRE.UserExceptionAppliedTo		
		, VHFRTJ.TriggerName
		, VHFRTJ.RewardTriggerID
		, HFLRT2.RewardTriggerLKPDisplayName
		, HFLRT2.RewardTriggerDynamicValue
		, HFLRT2.ItemModifiedWhen AS RewardTriggerModifiedDate
		, HFLRT.RewardTypeLKPName
		, HFA.AccountID
		, HFA.AccountCD
		, CASE	WHEN CAST(HFRULD.ItemCreatedWhen AS DATE) = CAST(HFRULD.ItemModifiedWhen AS DATE)
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		, VHFRPJ.DocumentGuid		--WDM added 8/7/2014 in case needed
		, VHFRPJ.NodeGuid			--WDM added 8/7/2014 in case needed
		, HFRULD.ItemCreatedWhen
		, HFRULD.ItemModifiedWhen
		
		, HFRE.ItemModifiedWhen AS RewardExceptionModifiedDate
		, HFRUAD.ItemModifiedWhen as RewardsUserActivity_ItemModifiedWhen	--09.11.2014 (wdm) added for EDW
		, VHFRTJ.DocumentModifiedWhen as  RewardTrigger_DocumentModifiedWhen
	FROM
		dbo.View_HFit_RewardProgram_Joined AS VHFRPJ WITH ( NOLOCK )
			
		LEFT OUTER JOIN dbo.View_HFit_RewardGroup_Joined AS VHFRGJ WITH ( NOLOCK ) ON VHFRPJ.NodeID = VHFRGJ.NodeParentID
			
		LEFT OUTER JOIN dbo.View_HFit_RewardLevel_Joined AS VHFRLJ WITH ( NOLOCK ) ON VHFRGJ.NodeID = VHFRLJ.NodeParentID
			
		LEFT OUTER JOIN dbo.HFit_LKP_RewardType AS HFLRT WITH ( NOLOCK ) ON VHFRLJ.AwardType = HFLRT.RewardTypeLKPID
		LEFT OUTER JOIN dbo.HFit_LKP_RewardLevelType AS HFLRLT WITH ( NOLOCK ) ON vhfrlj.LevelType = HFLRLT.RewardLevelTypeLKPID
		INNER JOIN dbo.HFit_RewardsUserLevelDetail AS HFRULD WITH ( NOLOCK ) ON VHFRLJ.NodeID = HFRULD.LevelNodeID
		INNER JOIN dbo.CMS_User AS CU WITH ( NOLOCK ) ON hfruld.UserID = cu.UserID
		INNER JOIN dbo.CMS_UserSite AS CUS WITH ( NOLOCK ) ON CU.UserID = CUS.UserID
		INNER JOIN dbo.CMS_Site AS CS2 WITH ( NOLOCK ) ON CUS.SiteID = CS2.SiteID
		INNER JOIN dbo.HFit_Account AS HFA WITH ( NOLOCK ) ON cs2.SiteID = HFA.SiteID
		INNER JOIN dbo.CMS_UserSettings AS CUS2 WITH ( NOLOCK ) ON cu.UserID = cus2.UserSettingsUserID
		LEFT OUTER JOIN dbo.View_HFit_RewardActivity_Joined AS VHFRAJ WITH ( NOLOCK ) ON VHFRLJ.NodeID = VHFRAJ.NodeParentID
			
		INNER JOIN dbo.HFit_RewardsUserActivityDetail AS HFRUAD WITH ( NOLOCK ) ON VHFRAJ.NodeID = HFRUAD.ActivityNodeID
		LEFT OUTER JOIN dbo.View_HFit_RewardTrigger_Joined AS VHFRTJ WITH ( NOLOCK ) ON VHFRAJ.NodeID = VHFRTJ.NodeParentID
			
		LEFT OUTER JOIN dbo.HFit_LKP_RewardTrigger AS HFLRT2 WITH ( NOLOCK ) ON VHFRTJ.RewardTriggerLKPID = HFLRT2.RewardTriggerLKPID
		LEFT OUTER JOIN dbo.HFit_RewardException AS HFRE WITH ( NOLOCK ) ON HFRE.RewardActivityID = VHFRAJ.RewardActivityID
				AND HFRE.UserID = cu.UserID

		Where VHFRPJ.DocumentCulture = 'en-us'
			AND VHFRGJ.DocumentCulture = 'en-us'
			AND VHFRLJ.DocumentCulture = 'en-us'
			AND VHFRAJ.DocumentCulture = 'en-us'
			AND VHFRTJ.DocumentCulture = 'en-us'
		





GO



if exists(select TABLE_NAME from INFORMATION_SCHEMA.VIEWS where TABLE_NAME = 'view_EDW_ScreeningsFromTrackers')
BEGIN
	drop view view_EDW_ScreeningsFromTrackers ;
END
GO

--********************************************************************************************************
--09.11.2014 : (wdm) Verified last mod date available to EDW 
--********************************************************************************************************
CREATE VIEW [dbo].[view_EDW_ScreeningsFromTrackers]

AS

SELECT
	t.userid
	, t.EventDate
	, t.TrackerCollectionSourceID
	, t.ItemCreatedBy
	, t.ItemCreatedWhen
	, t.ItemModifiedBy
	, t.ItemModifiedWhen
FROM
	(
		SELECT
			userid
			, eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, ItemCreatedWhen
			, ItemModifiedBy
			, ItemModifiedWhen
		FROM
			HFit_TrackerBloodPressure
		UNION ALL
		SELECT
			userid
			, eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, ItemCreatedWhen
			, ItemModifiedBy
			, ItemModifiedWhen
		FROM
			HFit_TrackerBloodSugarAndGlucose
		UNION ALL
		SELECT
			userid
			, eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, ItemCreatedWhen
			, ItemModifiedBy
			, ItemModifiedWhen
		FROM
			HFit_TrackerBMI
		UNION ALL
		SELECT
			userid
			, eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, ItemCreatedWhen
			, ItemModifiedBy
			, ItemModifiedWhen
		FROM
			HFit_TrackerBodyFat
		UNION ALL
		SELECT
			userid
			, eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, ItemCreatedWhen
			, ItemModifiedBy
			, ItemModifiedWhen
		FROM
			HFit_TrackerBodyMeasurements
		UNION ALL
		SELECT
			userid
			, eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, ItemCreatedWhen
			, ItemModifiedBy
			, ItemModifiedWhen
		FROM
			HFit_TrackerCardio
		UNION ALL
		SELECT
			userid
			, eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, ItemCreatedWhen
			, ItemModifiedBy
			, ItemModifiedWhen
		FROM
			HFit_TrackerCholesterol
		UNION ALL
		SELECT
			userid
			, eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, ItemCreatedWhen
			, ItemModifiedBy
			, ItemModifiedWhen
		FROM
			HFit_TrackerDailySteps
		UNION ALL
		SELECT
			userid
			, eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, ItemCreatedWhen
			, ItemModifiedBy
			, ItemModifiedWhen
		FROM
			HFit_TrackerFlexibility
		UNION ALL
		SELECT
			userid
			, eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, ItemCreatedWhen
			, ItemModifiedBy
			, ItemModifiedWhen
		FROM
			HFit_TrackerFruits
		UNION ALL
		SELECT
			userid
			, eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, ItemCreatedWhen
			, ItemModifiedBy
			, ItemModifiedWhen
		FROM
			HFit_TrackerHbA1c
		UNION ALL
		SELECT
			userid
			, eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, ItemCreatedWhen
			, ItemModifiedBy
			, ItemModifiedWhen
		FROM
			HFit_TrackerHeight
		UNION ALL
		SELECT
			userid
			, eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, ItemCreatedWhen
			, ItemModifiedBy
			, ItemModifiedWhen
		FROM
			HFit_TrackerHighFatFoods
		UNION ALL
		SELECT
			userid
			, eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, ItemCreatedWhen
			, ItemModifiedBy
			, ItemModifiedWhen
		FROM
			HFit_TrackerHighSodiumFoods
		UNION ALL
		SELECT
			userid
			, eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, ItemCreatedWhen
			, ItemModifiedBy
			, ItemModifiedWhen
		FROM
			HFit_TrackerInstance_Tracker
		UNION ALL
		SELECT
			userid
			, eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, ItemCreatedWhen
			, ItemModifiedBy
			, ItemModifiedWhen
		FROM
			HFit_TrackerMealPortions
		UNION ALL
		SELECT
			userid
			, eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, ItemCreatedWhen
			, ItemModifiedBy
			, ItemModifiedWhen
		FROM
			HFit_TrackerMedicalCarePlan
		UNION ALL
		SELECT
			userid
			, eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, ItemCreatedWhen
			, ItemModifiedBy
			, ItemModifiedWhen
		FROM
			HFit_TrackerRegularMeals
		UNION ALL
		SELECT
			userid
			, eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, ItemCreatedWhen
			, ItemModifiedBy
			, ItemModifiedWhen
		FROM
			HFit_TrackerRestingHeartRate
		UNION ALL
		SELECT
			userid
			, eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, ItemCreatedWhen
			, ItemModifiedBy
			, ItemModifiedWhen
		FROM
			HFit_TrackerShots
		UNION ALL
		SELECT
			userid
			, eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, ItemCreatedWhen
			, ItemModifiedBy
			, ItemModifiedWhen
		FROM
			HFit_TrackerSitLess
		UNION ALL
		SELECT
			userid
			, eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, ItemCreatedWhen
			, ItemModifiedBy
			, ItemModifiedWhen
		FROM
			HFit_TrackerSleepPlan
		UNION ALL
		SELECT
			userid
			, eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, ItemCreatedWhen
			, ItemModifiedBy
			, ItemModifiedWhen
		FROM
			HFit_TrackerStrength
		UNION ALL
		SELECT
			userid
			, eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, ItemCreatedWhen
			, ItemModifiedBy
			, ItemModifiedWhen
		FROM
			HFit_TrackerStress
		UNION ALL
		SELECT
			userid
			, eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, ItemCreatedWhen
			, ItemModifiedBy
			, ItemModifiedWhen
		FROM
			HFit_TrackerStressManagement
		UNION ALL
		SELECT
			userid
			, eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, ItemCreatedWhen
			, ItemModifiedBy
			, ItemModifiedWhen
		FROM
			HFit_TrackerSugaryDrinks
		UNION ALL
		SELECT
			userid
			, eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, ItemCreatedWhen
			, ItemModifiedBy
			, ItemModifiedWhen
		FROM
			HFit_TrackerSugaryFoods
		UNION ALL
		SELECT
			userid
			, eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, ItemCreatedWhen
			, ItemModifiedBy
			, ItemModifiedWhen
		FROM
			HFit_TrackerTests
		UNION ALL
		SELECT
			userid
			, eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, ItemCreatedWhen
			, ItemModifiedBy
			, ItemModifiedWhen
		FROM
			HFit_TrackerTobaccoFree
		UNION ALL
		SELECT
			userid
			, eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, ItemCreatedWhen
			, ItemModifiedBy
			, ItemModifiedWhen
		FROM
			HFit_TrackerVegetables
		UNION ALL
		SELECT
			userid
			, eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, ItemCreatedWhen
			, ItemModifiedBy
			, ItemModifiedWhen
		FROM
			HFit_TrackerWater
		UNION ALL
		SELECT
			userid
			, eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, ItemCreatedWhen
			, ItemModifiedBy
			, ItemModifiedWhen
		FROM
			HFit_TrackerWeight
		UNION ALL
		SELECT
			userid
			, eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, ItemCreatedWhen
			, ItemModifiedBy
			, ItemModifiedWhen
		FROM
			HFit_TrackerWholeGrains
	) as T
INNER JOIN dbo.HFit_TrackerCollectionSource AS HFTCS ON t.TrackerCollectionSourceID = HFTCS.TrackerCollectionSourceID
WHERE HFTCS.isProfessionallyCollected = 1


GO



if exists(select TABLE_NAME from INFORMATION_SCHEMA.VIEWS where TABLE_NAME = 'view_EDW_TrackerCompositeDetails')
BEGIN
	drop view view_EDW_TrackerCompositeDetails ;
END
GO


Create view [dbo].[view_EDW_TrackerCompositeDetails]
as
--WDM 6/26/2014
--This view is needed by EDW in order to process the Tracker tables' data.
--As of now, the Tracker tables are representative of objects and that would cause 
--	large volumes of ETL to be devloped and maintained. 
--This view represents a columnar representation of all tracker tables in a Key/Value pair representation.
--Each tracker table to be processed into the EDW must be represented in this view.
--ALL new tracker tables need only be entered once using the structure contained within this view
--	and the same EDW ETL should be able to process it.
--If there is a change to the strucuture of any one query in this view, then all have to be modified 
--	to be support the change.
--Column AggregateTableName will be NULL if the Tracker is not a member of the DISPLAYED Trackers. This 
--	allows us to capture all trackers, displayed or not.

--7/29/2014
--ISSUE: HFit_TrackerBMI,  HFit_TrackerCholesterol, and HFit_TrackerHeight are not in the HFIT_Tracker
--		table. This causes T.IsAvailable, T.IsCustom, T.UniqueName to be NULL. 
--		This raises the need for the Tracker Definition Table.

--NOTE: It is a goal to keep this view using BASE tables in order to gain max performance. Nested views will 
--		be avoided here if possible.

--**************** SPECIFIC TRACKER DATA **********************
--**************** on 7/29/2014          **********************
--Tracker GUID or Unique ID across all DB Instances (ItemGuid)
--Tracker NodeID (we use it for the External ID for Audit and error Triage)  (John: can use ItemID in this case)
--Tracker Table Name or Value Group Name (e.g. Body Measurements) - Categorization (TrackerNameAggregateTable)
--Tracker Column Unique Name ( In English)  Must be consistent across all DB Instances  ([UniqueName] will be 
--		the TABLE NAME if tracker name not found in the HFIT_Tracker table)
--Tracker Column Description (In English) (???)
--Tracker Column Data Type (e.g. Character, Numeric, Date, Bit or Yes/No) – so that we can set up the answer type
--	NULLS accepted for No Answer?	(KEY1, KEY2, VAL1, VAL2, etc)
--Tracker Active flag (IsAvailable will be null if tracker name not found in the HFIT_Tracker table)
--Tracker Unit of Measure (character) (Currently, the UOM is supplied in the view based on the table and type of Tracker)
--Tracker Insert Date ([ItemCreatedWhen])
--Tracker Last Update Date ([ItemModifiedWhen])
--NOTE: Convert all numerics to floats 7/30/2104 John/Dale
--**************************************************************

--USE:
--select * from view_EDW_TrackerCompositeDetails
--where EventDate between '2013-11-01 15:02:00.000' and '2013-12-01 15:02:00.000'

--Set statistics IO ON
--GO

SELECT 'HFit_TrackerBloodPressure' as TrackerNameAggregateTable
	  ,TT.[ItemID], [EventDate],TT.[IsProfessionallyCollected],TT.[TrackerCollectionSourceID],[Notes],TT.[UserID]
	  ,CollectionSourceName_Internal,CollectionSourceName_External,'MISSING' as EventName, 'mm/Hg' as UOM
	  ,'Systolic' as KEY1, cast([Systolic] as float) as VAL1
	  ,'Diastolic' as KEY2,cast([Diastolic] as float) as VAL2
	  ,'NA' as KEY3, null as VAL3
	  ,'NA' as KEY4, null as VAL4
      ,'NA' as KEY5, null as VAL5
      ,'NA' as KEY6, null as VAL6
	  ,'NA' as KEY7, null as VAL7
	  ,'NA' as KEY8, null as VAL8
	  ,'NA' as KEY9, null as VAL9
	  ,'NA' as KEY10, null as VAL10
      ,TT.[ItemCreatedBy],TT.[ItemCreatedWhen],TT.[ItemModifiedBy],TT.[ItemModifiedWhen]
	  ,[IsProcessedForHa]
	  ,'NA' as TXTKEY1
	  ,null as TXTVAL1
	  ,'NA' as TXTKEY2
	  ,null as TXTVAL2
	  ,'NA' as TXTKEY3
	  ,null as TXTVAL3
	  ,null as ItemOrder
	  ,null as ItemGuid
	  ,C.UserGuid, PP.MPI, PP.ClientCode 
	  ,S.SiteGUID, ACCT.AccountID, ACCT.AccountCD, T.IsAvailable, T.IsCustom, isnull(T.[UniqueName],'bp') as UniqueName
	  ,isnull(T.[UniqueName],'bp') as ColDesc
  FROM [dbo].[HFit_TrackerBloodPressure] TT
		inner join dbo.CMS_User C on C.UserID = TT.UserID
		inner join dbo.hfit_ppteligibility PP on TT.UserID = PP.userID
		inner join dbo.HFit_Account [ACCT] on PP.ClientCode = ACCT.AccountCD
		inner join dbo.CMS_Site S on ACCT.SiteID = S.SiteID	
		inner join dbo.HFit_TrackerCollectionSource TC on TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
		left outer JOIN dbo.[HFIT_Tracker] T on T.AggregateTableName = 'HFit_TrackerBloodPressure'
union 
SELECT 'HFit_TrackerBloodSugarAndGlucose' as TrackerNameAggregateTable
	  ,TT.[ItemID] ,[EventDate],TT.[IsProfessionallyCollected],TT.[TrackerCollectionSourceID],[Notes],TT.[UserID]
	  ,CollectionSourceName_Internal,CollectionSourceName_External,'MISSING' as EventName, 'mmol/L' as UOM
	  ,'Units' as KEY1,cast([Units] as float) as VAL1
	  ,'FastingState' as KEY2, cast([FastingState] as float) as VAL2
      ,'NA' as KEY3, null as VAL3
	  ,'NA' as KEY4, null as VAL4
      ,'NA' as KEY5, null as VAL5
      ,'NA' as KEY6, null as VAL6
	  ,'NA' as KEY7, null as VAL7
	  ,'NA' as KEY8, null as VAL8
	  ,'NA' as KEY9, null as VAL9
	  ,'NA' as KEY10, null as VAL10
      ,TT.[ItemCreatedBy],TT.[ItemCreatedWhen],TT.[ItemModifiedBy],TT.[ItemModifiedWhen]
	  ,[IsProcessedForHa]
	  ,'NA' as TXTKEY1
	  ,null as TXTVAL1
	  ,'NA' as TXTKEY2
	  ,null as TXTVAL2
	  ,'NA' as TXTKEY3
	  ,null as TXTVAL3
	  ,null as ItemOrder
	  ,null as ItemGuid
	  ,C.UserGuid, PP.MPI, PP.ClientCode 
	  ,S.SiteGUID, ACCT.AccountID, ACCT.AccountCD, T.IsAvailable, T.IsCustom, isnull(T.[UniqueName],'glucose') as UniqueName
	  , isnull(T.[UniqueName],'glucose') as ColDesc
  FROM [dbo].[HFit_TrackerBloodSugarAndGlucose] TT
		inner join dbo.CMS_User C on C.UserID = TT.UserID
		inner join dbo.hfit_ppteligibility PP on TT.UserID = PP.userID
		inner join dbo.HFit_Account [ACCT] on PP.ClientCode = ACCT.AccountCD
		inner join dbo.CMS_Site S on ACCT.SiteID = S.SiteID
		inner join dbo.HFit_TrackerCollectionSource TC on TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
		LEFT OUTER JOIN dbo.[HFIT_Tracker] T on T.AggregateTableName = 'HFit_TrackerBloodSugarAndGlucose'
union
SELECT 'HFit_TrackerBMI' as TrackerNameAggregateTable
	  ,TT.[ItemID] ,[EventDate],TT.[IsProfessionallyCollected],TT.[TrackerCollectionSourceID],[Notes],TT.[UserID]
	  ,CollectionSourceName_Internal,CollectionSourceName_External,'MISSING' as EventName, 'kg/m2' as UOM
      ,'BMI' as KEY1,cast([BMI] as float) as VAL1
	  ,'NA' as KEY2, 0 as VAL2
      ,'NA' as KEY3, null as VAL3
	  ,'NA' as KEY4, null as VAL4
      ,'NA' as KEY5, null as VAL5
      ,'NA' as KEY6, null as VAL6
	  ,'NA' as KEY7, null as VAL7
	  ,'NA' as KEY8, null as VAL8
	  ,'NA' as KEY9, null as VAL9
	  ,'NA' as KEY10, null as VAL10
      ,TT.[ItemCreatedBy],TT.[ItemCreatedWhen],TT.[ItemModifiedBy],TT.[ItemModifiedWhen]
	  ,null as IsProcessedForHa
	  ,'NA' as TXTKEY1
	  ,null as TXTVAL1
	  ,'NA' as TXTKEY2
	  ,null as TXTVAL2
	  ,'NA' as TXTKEY3
	  ,null as TXTVAL3
	  ,TT.[ItemOrder]
	  ,null as ItemGuid
	  ,C.UserGuid, PP.MPI, PP.ClientCode 
	  ,S.SiteGUID, ACCT.AccountID, ACCT.AccountCD, T.IsAvailable, T.IsCustom, isnull(T.[UniqueName],'HFit_TrackerBMI') as UniqueName
	  , isnull(T.[UniqueName],'HFit_TrackerBMI') as ColDesc
  FROM [dbo].[HFit_TrackerBMI] TT
		inner join dbo.CMS_User C on C.UserID = TT.UserID
		inner join dbo.hfit_ppteligibility PP on TT.UserID = PP.userID
		inner join dbo.HFit_Account [ACCT] on PP.ClientCode = ACCT.AccountCD
		inner join dbo.CMS_Site S on ACCT.SiteID = S.SiteID
		inner join dbo.HFit_TrackerCollectionSource TC on TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
		LEFT OUTER JOIN dbo.[HFIT_Tracker] T on T.AggregateTableName = 'HFit_TrackerBMI'
union
SELECT 'HFit_TrackerBodyFat' as TrackerNameAggregateTable
	  ,TT.[ItemID] ,[EventDate],TT.[IsProfessionallyCollected],TT.[TrackerCollectionSourceID],[Notes],TT.[UserID]
	  ,CollectionSourceName_Internal,CollectionSourceName_External,'MISSING' as EventName, 'PCT' as UOM
      ,'Value' as KEY1,cast([Value] as float) as VAL1
	  ,'NA' as KEY2, 0 as VAL2
      ,'NA' as KEY3, null as VAL3
	  ,'NA' as KEY4, null as VAL4
      ,'NA' as KEY5, null as VAL5
      ,'NA' as KEY6, null as VAL6
	  ,'NA' as KEY7, null as VAL7
	  ,'NA' as KEY8, null as VAL8
	  ,'NA' as KEY9, null as VAL9
	  ,'NA' as KEY10, null as VAL10
      ,TT.[ItemCreatedBy],TT.[ItemModifiedBy],TT.[ItemCreatedWhen],TT.[ItemModifiedWhen]
	  ,null as IsProcessedForHa
	  ,'NA' as TXTKEY1
	  ,null as TXTVAL1
	  ,'NA' as TXTKEY2
	  ,null as TXTVAL2
	  ,'NA' as TXTKEY3
	  ,null as TXTVAL3
	  ,null as ItemOrder
	  ,null as ItemGuid
	  ,C.UserGuid, PP.MPI, PP.ClientCode 
	  ,S.SiteGUID, ACCT.AccountID, ACCT.AccountCD, T.IsAvailable, T.IsCustom, isnull(T.[UniqueName],'HFit_TrackerBodyFat') as UniqueName
	  , isnull(T.[UniqueName],'HFit_TrackerBodyFat') as ColDesc
  FROM [dbo].[HFit_TrackerBodyFat] TT
     inner join dbo.CMS_User C on C.UserID = TT.UserID
	inner join dbo.hfit_ppteligibility PP on TT.UserID = PP.userID
	inner join dbo.HFit_Account [ACCT] on PP.ClientCode = ACCT.AccountCD
	inner join dbo.CMS_Site S on ACCT.SiteID = S.SiteID
		inner join dbo.HFit_TrackerCollectionSource TC on TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
		LEFT OUTER JOIN dbo.[HFIT_Tracker] T on T.AggregateTableName = 'HFit_TrackerBodyFat'
union
--******************************************************************************
SELECT 'HFit_TrackerBodyMeasurements' as TrackerNameAggregateTable
	  ,TT.[ItemID] ,[EventDate],TT.[IsProfessionallyCollected],TT.[TrackerCollectionSourceID],[Notes],TT.[UserID]
	  ,CollectionSourceName_Internal,CollectionSourceName_External,'MISSING' as EventName, 'Inch' as UOM
	  ,'WaistInches' as KEY1, cast([WaistInches] as float) as VAL1
      ,'HipInches' as KEY2, cast([HipInches] as float) as VAL2
	  ,'ThighInches' as KEY3, cast([ThighInches] as float) as VAL3
	  ,'ArmInches' as KEY4, cast([ArmInches]  as float) as VAL4
      ,'ChestInches' as KEY5, cast([ChestInches]  as float) as VAL5
      ,'CalfInches' as KEY6, cast([CalfInches]  as float) as VAL6
	  ,'NeckInches' as KEY7, cast([NeckInches]  as float) as VAL7
	  ,'NA' as KEY8, null as VAL8
	  ,'NA' as KEY9, null as VAL9
	  ,'NA' as KEY10, null as VAL10
      ,TT.[ItemCreatedBy],TT.[ItemModifiedBy],TT.[ItemCreatedWhen],TT.[ItemModifiedWhen]
	  ,[IsProcessedForHa]
	  ,'NA' as TXTKEY1
	  ,null as TXTVAL1
	  ,'NA' as TXTKEY2
	  ,null as TXTVAL2
	  ,'NA' as TXTKEY3
	  ,null as TXTVAL3
	  ,null as ItemOrder
	  ,null as ItemGuid
	  ,C.UserGuid, PP.MPI, PP.ClientCode 
	  ,S.SiteGUID, ACCT.AccountID, ACCT.AccountCD, T.IsAvailable, T.IsCustom, T.[UniqueName]
	  , T.[UniqueName] as ColDesc
  FROM [dbo].[HFit_TrackerBodyMeasurements] TT
    inner join dbo.CMS_User C on C.UserID = TT.UserID
	inner join dbo.hfit_ppteligibility PP on TT.UserID = PP.userID
	inner join dbo.HFit_Account [ACCT] on PP.ClientCode = ACCT.AccountCD
	inner join dbo.CMS_Site S on ACCT.SiteID = S.SiteID
		inner join dbo.HFit_TrackerCollectionSource TC on TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
		LEFT OUTER JOIN dbo.[HFIT_Tracker] T on T.AggregateTableName = 'HFit_TrackerBodyMeasurements'
--******************************************************************************
union
SELECT 'HFit_TrackerCardio' as TrackerNameAggregateTable
	  ,TT.[ItemID] ,[EventDate],TT.[IsProfessionallyCollected],TT.[TrackerCollectionSourceID],[Notes],TT.[UserID]
	  ,CollectionSourceName_Internal,CollectionSourceName_External,'MISSING' as EventName, 'NA' as UOM
      ,'Minutes' as KEY1, cast([Minutes]  as float) as VAL1
	  ,'Distance' as KEY2, cast([Distance]  as float) as VAL2
	  ,'DistanceUnit' as KEY3, cast([DistanceUnit]  as float) as VAL3
	  ,'Intensity' as KEY4, cast([Intensity]  as float) as VAL4
      ,'ActivityID' as KEY5, cast([ActivityID]  as float) as VAL5
      ,'NA' as KEY6, null as VAL6
	  ,'NA' as KEY7, null as VAL7
	  ,'NA' as KEY8, null as VAL8
	  ,'NA' as KEY9, null as VAL9
	  ,'NA' as KEY10, null as VAL10
      ,TT.[ItemCreatedBy],TT.[ItemModifiedBy],TT.[ItemCreatedWhen],TT.[ItemModifiedWhen]
	  ,null as [IsProcessedForHa]
	  ,'NA' as TXTKEY1
	  ,null as TXTVAL1
	  ,'NA' as TXTKEY2
	  ,null as TXTVAL2
	  ,'NA' as TXTKEY3
	  ,null as TXTVAL3
	  ,null as ItemOrder
	  ,null as ItemGuid
	  ,C.UserGuid, PP.MPI, PP.ClientCode 
	  ,S.SiteGUID, ACCT.AccountID, ACCT.AccountCD, T.IsAvailable, T.IsCustom, T.[UniqueName]
	  , T.[UniqueName] as ColDesc
  FROM [dbo].[HFit_TrackerCardio] TT
    inner join dbo.CMS_User C on C.UserID = TT.UserID
	inner join dbo.hfit_ppteligibility PP on TT.UserID = PP.userID
	inner join dbo.HFit_Account [ACCT] on PP.ClientCode = ACCT.AccountCD
	inner join dbo.CMS_Site S on ACCT.SiteID = S.SiteID
		inner join dbo.HFit_TrackerCollectionSource TC on TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
		LEFT OUTER JOIN dbo.[HFIT_Tracker] T on T.AggregateTableName = 'HFit_TrackerCardio'
union
SELECT 'HFit_TrackerCholesterol' as TrackerNameAggregateTable
	  ,TT.[ItemID] ,[EventDate],TT.[IsProfessionallyCollected],TT.[TrackerCollectionSourceID],[Notes],TT.[UserID]
	  ,CollectionSourceName_Internal,CollectionSourceName_External,'MISSING' as EventName, 'mg/dL' as UOM
      ,'HDL' as KEY1, cast([HDL]  as float) as VAL1
	  ,'LDL' as KEY2, cast([LDL]  as float) as VAL2
	  ,'Total' as KEY3, cast([Total]  as float) as VAL3
	  ,'Tri' as KEY4, cast([Tri]  as float) as VAL4
      ,'Ratio' as KEY5, cast([Ratio]  as float) as VAL5
      ,'Fasting' as KEY6, cast([Fasting] as float) as VAL6
	  ,'VLDL' as [VLDL], cast(VLDL as float ) as VAL7
	  ,'NA' as KEY8, null as VAL8
	  ,'NA' as KEY9, null as VAL9
	  ,'NA' as KEY10, null as VAL10
      ,TT.[ItemCreatedBy],TT.[ItemCreatedWhen],TT.[ItemModifiedBy],TT.[ItemModifiedWhen]
      ,[IsProcessedForHa]
	  ,'NA' as TXTKEY1
	  ,null as TXTVAL1
	  ,'NA' as TXTKEY2
	  ,null as TXTVAL2
	  ,'NA' as TXTKEY3
	  ,null as TXTVAL3
	  ,null as ItemOrder
	  ,null as ItemGuid
	  ,C.UserGuid, PP.MPI, PP.ClientCode 
	  ,S.SiteGUID, ACCT.AccountID, ACCT.AccountCD, T.IsAvailable, T.IsCustom, isnull(T.[UniqueName],'HFit_TrackerCholesterol') as UniqueName
	  , isnull(T.[UniqueName],'HFit_TrackerCholesterol') as ColDesc
  FROM [dbo].[HFit_TrackerCholesterol] TT
    inner join dbo.CMS_User C on C.UserID = TT.UserID
	inner join dbo.hfit_ppteligibility PP on TT.UserID = PP.userID
	inner join dbo.HFit_Account [ACCT] on PP.ClientCode = ACCT.AccountCD
	inner join dbo.CMS_Site S on ACCT.SiteID = S.SiteID
		inner join dbo.HFit_TrackerCollectionSource TC on TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
		LEFT OUTER JOIN dbo.[HFIT_Tracker] T on T.AggregateTableName = 'HFit_TrackerCholesterol'
union
SELECT 'HFit_TrackerDailySteps' as TrackerNameAggregateTable
   	  ,TT.[ItemID] ,[EventDate],TT.[IsProfessionallyCollected],TT.[TrackerCollectionSourceID],[Notes],TT.[UserID]
	  ,CollectionSourceName_Internal,CollectionSourceName_External,'MISSING' as EventName, 'Step' as UOM
	  ,'Steps' as KEY1, cast([Steps]  as float) as VAL1
	  ,'NA' as KEY2, null as VAL2
	  ,'NA' as KEY3, null as VAL3
	  ,'NA' as KEY4, null as VAL4
      ,'NA' as KEY5, null as VAL5
      ,'NA' as KEY6, null as VAL6
	  ,'NA' as KEY7, null as VAL7      
	  ,'NA' as KEY8, null as VAL8
	  ,'NA' as KEY9, null as VAL9
	  ,'NA' as KEY10, null as VAL10
	  ,TT.[ItemCreatedBy],TT.[ItemCreatedWhen],TT.[ItemModifiedBy],TT.[ItemModifiedWhen]
      ,null as [IsProcessedForHa]
	  ,'NA' as TXTKEY1
	  ,null as TXTVAL1
	  ,'NA' as TXTKEY2
	  ,null as TXTVAL2
	  ,'NA' as TXTKEY3
	  ,null as TXTVAL3
	  ,null as ItemOrder
	  ,null as ItemGuid
	  ,C.UserGuid, PP.MPI, PP.ClientCode 
	  ,S.SiteGUID, ACCT.AccountID, ACCT.AccountCD, T.IsAvailable, T.IsCustom, isnull(T.[UniqueName], 'HFit_TrackerDailySteps') as UniqueName
	  , isnull(T.[UniqueName], 'HFit_TrackerDailySteps') as ColDesc
  FROM [dbo].[HFit_TrackerDailySteps] TT
    inner join dbo.CMS_User C on C.UserID = TT.UserID
	inner join dbo.hfit_ppteligibility PP on TT.UserID = PP.userID
	inner join dbo.HFit_Account [ACCT] on PP.ClientCode = ACCT.AccountCD
	inner join dbo.CMS_Site S on ACCT.SiteID = S.SiteID
		inner join dbo.HFit_TrackerCollectionSource TC on TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
		LEFT OUTER JOIN dbo.[HFIT_Tracker] T on T.AggregateTableName = 'HFit_TrackerDailySteps'
union
SELECT 'HFit_TrackerFlexibility' as TrackerNameAggregateTable
	   	  ,TT.[ItemID] ,[EventDate],TT.[IsProfessionallyCollected],TT.[TrackerCollectionSourceID],[Notes],TT.[UserID]
	  ,CollectionSourceName_Internal,CollectionSourceName_External,'MISSING' as EventName, 'Y/N' as UOM
	,'HasStretched' as KEY1, cast(HasStretched  as float) as VAL1
	  ,'NA' as KEY2, null as VAL2
	  ,'NA' as KEY3, null as VAL3
	  ,'NA' as KEY4, null as VAL4
      ,'NA' as KEY5, null as VAL5
      ,'NA' as KEY6, null as VAL6
	  ,'NA' as KEY7, null as VAL7
	  ,'NA' as KEY8, null as VAL8
	  ,'NA' as KEY9, null as VAL9
	  ,'NA' as KEY10, null as VAL10
	  ,TT.[ItemCreatedBy],TT.[ItemCreatedWhen],TT.[ItemModifiedBy],TT.[ItemModifiedWhen]
      ,null as [IsProcessedForHa]
	  ,'Activity' as TXTKEY1
	  ,Activity as TXTVAL1
	  ,'NA' as TXTKEY2
	  ,null as TXTVAL2
	  ,'NA' as TXTKEY3
	  ,null as TXTVAL3
	  ,null as ItemOrder
	  ,null as ItemGuid
	  ,C.UserGuid, PP.MPI, PP.ClientCode 
	  ,S.SiteGUID, ACCT.AccountID, ACCT.AccountCD, T.IsAvailable, T.IsCustom, T.[UniqueName]
	  , T.[UniqueName] as ColDesc
  FROM [dbo].[HFit_TrackerFlexibility] TT
    inner join dbo.CMS_User C on C.UserID = TT.UserID
	inner join dbo.hfit_ppteligibility PP on TT.UserID = PP.userID
	inner join dbo.HFit_Account [ACCT] on PP.ClientCode = ACCT.AccountCD
	inner join dbo.CMS_Site S on ACCT.SiteID = S.SiteID
		inner join dbo.HFit_TrackerCollectionSource TC on TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
		LEFT OUTER JOIN dbo.[HFIT_Tracker] T on T.AggregateTableName = 'HFit_TrackerFlexibility'
UNION
SELECT 'HFit_TrackerFruits' as TrackerNameAggregateTable	  
	  ,TT.[ItemID] ,[EventDate],TT.[IsProfessionallyCollected],TT.[TrackerCollectionSourceID],[Notes],TT.[UserID]
	  ,CollectionSourceName_Internal,CollectionSourceName_External,'MISSING' as EventName, 'CUP(8oz)' as UOM
	  ,'Cups' as KEY1, cast(Cups  as float) as VAL1
	  ,'NA' as KEY2, null as VAL2
	  ,'NA' as KEY3, null as VAL3
	  ,'NA' as KEY4, null as VAL4
      ,'NA' as KEY5, null as VAL5
      ,'NA' as KEY6, null as VAL6
	  ,'NA' as KEY7, null as VAL7
	  ,'NA' as KEY8, null as VAL8
	  ,'NA' as KEY9, null as VAL9
	  ,'NA' as KEY10, null as VAL10
	  ,TT.[ItemCreatedBy],TT.[ItemCreatedWhen],TT.[ItemModifiedBy],TT.[ItemModifiedWhen]
      ,null as [IsProcessedForHa]
	  ,'NA' as TXTKEY1
	  ,null as TXTVAL1
	  ,'NA' as TXTKEY2
	  ,null as TXTVAL2
	  ,'NA' as TXTKEY3
	  ,null as TXTVAL3
	  ,null as ItemOrder
	  ,null as ItemGuid
	  ,C.UserGuid, PP.MPI, PP.ClientCode 
	  ,S.SiteGUID, ACCT.AccountID, ACCT.AccountCD, T.IsAvailable, T.IsCustom, T.[UniqueName]
	  , T.[UniqueName] as ColDesc
  FROM [dbo].HFit_TrackerFruits TT
    inner join dbo.CMS_User C on C.UserID = TT.UserID
	inner join dbo.hfit_ppteligibility PP on TT.UserID = PP.userID
	inner join dbo.HFit_Account [ACCT] on PP.ClientCode = ACCT.AccountCD
	inner join dbo.CMS_Site S on ACCT.SiteID = S.SiteID
		inner join dbo.HFit_TrackerCollectionSource TC on TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
		LEFT OUTER JOIN dbo.[HFIT_Tracker] T on T.AggregateTableName = 'HFit_TrackerFruits'
union
SELECT 'HFit_TrackerHbA1c' as TrackerNameAggregateTable 
	  ,TT.[ItemID] ,[EventDate],TT.[IsProfessionallyCollected],TT.[TrackerCollectionSourceID],[Notes],TT.[UserID]
	  ,CollectionSourceName_Internal,CollectionSourceName_External,'MISSING' as EventName, 'mmol/mol' as UOM
	  ,'Value' as KEY1, cast([Value]  as float) as VAL1
	  ,'NA' as KEY2, null as VAL2
	  ,'NA' as KEY3, null as VAL3
	  ,'NA' as KEY4, null as VAL4
      ,'NA' as KEY5, null as VAL5
      ,'NA' as KEY6, null as VAL6
	  ,'NA' as KEY7, null as VAL7
	  ,'NA' as KEY8, null as VAL8
	  ,'NA' as KEY9, null as VAL9
	  ,'NA' as KEY10, null as VAL10
	  ,TT.[ItemCreatedBy],TT.[ItemCreatedWhen],TT.[ItemModifiedBy],TT.[ItemModifiedWhen]
      ,[IsProcessedForHa]
	  ,'NA' as TXTKEY1
	  ,null as TXTVAL1
	  ,'NA' as TXTKEY2
	  ,null as TXTVAL2
	  ,'NA' as TXTKEY3
	  ,null as TXTVAL3
	  ,null as ItemOrder
	  ,null as ItemGuid
	  ,C.UserGuid, PP.MPI, PP.ClientCode 
	  ,S.SiteGUID, ACCT.AccountID, ACCT.AccountCD, T.IsAvailable, T.IsCustom, T.[UniqueName]
	  , T.[UniqueName] as ColDesc
  FROM [dbo].HFit_TrackerHbA1c TT
      inner join dbo.CMS_User C on C.UserID = TT.UserID
	inner join dbo.hfit_ppteligibility PP on TT.UserID = PP.userID
	inner join dbo.HFit_Account [ACCT] on PP.ClientCode = ACCT.AccountCD
	inner join dbo.CMS_Site S on ACCT.SiteID = S.SiteID
		inner join dbo.HFit_TrackerCollectionSource TC on TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
		LEFT OUTER JOIN dbo.[HFIT_Tracker] T on T.AggregateTableName = 'HFit_TrackerHbA1c'
union
SELECT 'HFit_TrackerHeight' as TrackerNameAggregateTable
	  ,TT.[ItemID] ,[EventDate],TT.[IsProfessionallyCollected],TT.[TrackerCollectionSourceID],[Notes],TT.[UserID]
	  ,CollectionSourceName_Internal,CollectionSourceName_External,'MISSING' as EventName, 'inch' as UOM
	  ,'Height' as KEY1, Height as VAL1
	  ,'NA' as KEY2, null as VAL2
	  ,'NA' as KEY3, null as VAL3
	  ,'NA' as KEY4, null as VAL4
      ,'NA' as KEY5, null as VAL5
      ,'NA' as KEY6, null as VAL6
	  ,'NA' as KEY7, null as VAL7
	  ,'NA' as KEY8, null as VAL8
	  ,'NA' as KEY9, null as VAL9
	  ,'NA' as KEY10, null as VAL10
	  ,TT.[ItemCreatedBy],TT.[ItemCreatedWhen],TT.[ItemModifiedBy],TT.[ItemModifiedWhen]
      ,[IsProcessedForHa]
	  ,'NA' as TXTKEY1
	  ,null as TXTVAL1
	  ,'NA' as TXTKEY2
	  ,null as TXTVAL2
	  ,'NA' as TXTKEY3
	  ,null as TXTVAL3
	  ,TT.ItemOrder
	  ,TT.ItemGuid
	  ,C.UserGuid, PP.MPI, PP.ClientCode 
	  ,S.SiteGUID, ACCT.AccountID, ACCT.AccountCD, T.IsAvailable, T.IsCustom, isnull(T.[UniqueName], 'HFit_TrackerHeight') as UniqueName
	  , isnull(T.[UniqueName], 'HFit_TrackerHeight') as ColDesc
  FROM [dbo].HFit_TrackerHeight TT
      inner join dbo.CMS_User C on C.UserID = TT.UserID
	inner join dbo.hfit_ppteligibility PP on TT.UserID = PP.userID
	inner join dbo.HFit_Account [ACCT] on PP.ClientCode = ACCT.AccountCD
	inner join dbo.CMS_Site S on ACCT.SiteID = S.SiteID
		inner join dbo.HFit_TrackerCollectionSource TC on TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
		LEFT OUTER JOIN dbo.[HFIT_Tracker] T on T.AggregateTableName = 'HFit_TrackerHeight'
union
SELECT 'HFit_TrackerHighFatFoods' as TrackerNameAggregateTable 
	  ,TT.[ItemID] ,[EventDate],TT.[IsProfessionallyCollected],TT.[TrackerCollectionSourceID],[Notes],TT.[UserID]
	  ,CollectionSourceName_Internal,CollectionSourceName_External,'MISSING' as EventName, 'Occurs' as UOM
	  ,'Times' as KEY1, cast(Times  as float) as VAL1
	  ,'NA' as KEY2, null as VAL2
	  ,'NA' as KEY3, null as VAL3
	  ,'NA' as KEY4, null as VAL4
      ,'NA' as KEY5, null as VAL5
      ,'NA' as KEY6, null as VAL6
	  ,'NA' as KEY7, null as VAL7
	  ,'NA' as KEY8, null as VAL8
	  ,'NA' as KEY9, null as VAL9
	  ,'NA' as KEY10, null as VAL10
	  ,TT.[ItemCreatedBy],TT.[ItemCreatedWhen],TT.[ItemModifiedBy],TT.[ItemModifiedWhen]
      ,null as [IsProcessedForHa]
	  ,'NA' as TXTKEY1
	  ,null as TXTVAL1
	  ,'NA' as TXTKEY2
	  ,null as TXTVAL2
	  ,'NA' as TXTKEY3
	  ,null as TXTVAL3
	  ,null as ItemOrder
	  ,null as ItemGuid
	  ,C.UserGuid, PP.MPI, PP.ClientCode 
	  ,S.SiteGUID, ACCT.AccountID, ACCT.AccountCD, T.IsAvailable, T.IsCustom, T.[UniqueName]
	  , T.[UniqueName] as ColDesc
  FROM [dbo].HFit_TrackerHighFatFoods TT
  inner join dbo.CMS_User C on C.UserID = TT.UserID
	inner join dbo.hfit_ppteligibility PP on TT.UserID = PP.userID
	inner join dbo.HFit_Account [ACCT] on PP.ClientCode = ACCT.AccountCD
	inner join dbo.CMS_Site S on ACCT.SiteID = S.SiteID
		inner join dbo.HFit_TrackerCollectionSource TC on TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
		LEFT OUTER JOIN dbo.[HFIT_Tracker] T on T.AggregateTableName = 'HFit_TrackerHighFatFoods'
union
SELECT 'HFit_TrackerHighSodiumFoods' as TrackerNameAggregateTable 
	   	  ,TT.[ItemID] ,[EventDate],TT.[IsProfessionallyCollected],TT.[TrackerCollectionSourceID],[Notes],TT.[UserID]
	  ,CollectionSourceName_Internal,CollectionSourceName_External,'MISSING' as EventName, 'Occurs' as UOM
	  ,'Times' as KEY1, cast(Times  as float) as VAL1
	  ,'NA' as KEY2, null as VAL2
	  ,'NA' as KEY3, null as VAL3
	  ,'NA' as KEY4, null as VAL4
      ,'NA' as KEY5, null as VAL5
      ,'NA' as KEY6, null as VAL6
	  ,'NA' as KEY7, null as VAL7
	  ,'NA' as KEY8, null as VAL8
	  ,'NA' as KEY9, null as VAL9
	  ,'NA' as KEY10, null as VAL10
	  ,TT.[ItemCreatedBy],TT.[ItemCreatedWhen],TT.[ItemModifiedBy],TT.[ItemModifiedWhen]
      ,null as [IsProcessedForHa]
	  ,'NA' as TXTKEY1
	  ,null as TXTVAL1
	  ,'NA' as TXTKEY2
	  ,null as TXTVAL2
	  ,'NA' as TXTKEY3
	  ,null as TXTVAL3
	  ,null as ItemOrder
	  ,null as ItemGuid
	  ,C.UserGuid, PP.MPI, PP.ClientCode 
	  ,S.SiteGUID, ACCT.AccountID, ACCT.AccountCD, T.IsAvailable, T.IsCustom, T.[UniqueName]
	  , T.[UniqueName] as ColDesc
  FROM [dbo].HFit_TrackerHighSodiumFoods TT
     inner join dbo.CMS_User C on C.UserID = TT.UserID
	inner join dbo.hfit_ppteligibility PP on TT.UserID = PP.userID
	inner join dbo.HFit_Account [ACCT] on PP.ClientCode = ACCT.AccountCD
	inner join dbo.CMS_Site S on ACCT.SiteID = S.SiteID
		inner join dbo.HFit_TrackerCollectionSource TC on TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
		LEFT OUTER JOIN dbo.[HFIT_Tracker] T on T.AggregateTableName = 'HFit_TrackerHighSodiumFoods'
union
SELECT 'HFit_TrackerInstance_Tracker' as TrackerNameAggregateTable 
	   	  ,TT.[ItemID] ,[EventDate],TT.[IsProfessionallyCollected],TT.[TrackerCollectionSourceID],[Notes],TT.[UserID]
	  ,CollectionSourceName_Internal,CollectionSourceName_External,'MISSING' as EventName, 'Y/N' as UOM
	  ,'TrackerDefID' as KEY1, cast(TrackerDefID  as float) as VAL1
	  ,'YesNoValue' as KEY2, cast(YesNoValue as float) as VAL2
	  ,'NA' as KEY3, null as VAL3
	  ,'NA' as KEY4, null as VAL4
      ,'NA' as KEY5, null as VAL5
      ,'NA' as KEY6, null as VAL6
	  ,'NA' as KEY7, null as VAL7
	  ,'NA' as KEY8, null as VAL8
	  ,'NA' as KEY9, null as VAL9
	  ,'NA' as KEY10, null as VAL10
	  ,TT.[ItemCreatedBy],TT.[ItemCreatedWhen],TT.[ItemModifiedBy],TT.[ItemModifiedWhen]
      ,null as [IsProcessedForHa]
	  ,'NA' as TXTKEY1
	  ,null as TXTVAL1
	  ,'NA' as TXTKEY2
	  ,null as TXTVAL2
	  ,'NA' as TXTKEY3
	  ,null as TXTVAL3
	  ,null as ItemOrder
	  ,null as ItemGuid
	  ,C.UserGuid, PP.MPI, PP.ClientCode 
	  ,S.SiteGUID, ACCT.AccountID, ACCT.AccountCD, T.IsAvailable, T.IsCustom, T.[UniqueName]
	  , T.[UniqueName] as ColDesc
  FROM [dbo].HFit_TrackerInstance_Tracker TT
    inner join dbo.CMS_User C on C.UserID = TT.UserID
	inner join dbo.hfit_ppteligibility PP on TT.UserID = PP.userID
	inner join dbo.HFit_Account [ACCT] on PP.ClientCode = ACCT.AccountCD
	inner join dbo.CMS_Site S on ACCT.SiteID = S.SiteID
		inner join dbo.HFit_TrackerCollectionSource TC on TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
		LEFT OUTER JOIN dbo.[HFIT_Tracker] T on T.AggregateTableName = 'HFit_TrackerInstance_Tracker'
union
SELECT 'HFit_TrackerMealPortions' as TrackerNameAggregateTable 
	   	  ,TT.[ItemID] ,[EventDate],TT.[IsProfessionallyCollected],TT.[TrackerCollectionSourceID],[Notes],TT.[UserID]
	  ,CollectionSourceName_Internal,CollectionSourceName_External,'MISSING' as EventName, 'NA-portion' as UOM
	  ,'Portions' as KEY1, cast(Portions  as float) as VAL1
	  ,'NA' as KEY2, null as VAL2
	  ,'NA' as KEY3, null as VAL3
	  ,'NA' as KEY4, null as VAL4
      ,'NA' as KEY5, null as VAL5
      ,'NA' as KEY6, null as VAL6
	  ,'NA' as KEY7, null as VAL7
	  ,'NA' as KEY8, null as VAL8
	  ,'NA' as KEY9, null as VAL9
	  ,'NA' as KEY10, null as VAL10
	  ,TT.[ItemCreatedBy],TT.[ItemCreatedWhen],TT.[ItemModifiedBy],TT.[ItemModifiedWhen]
      ,null as [IsProcessedForHa]
	  ,'NA' as TXTKEY1
	  ,null as TXTVAL1
	  ,'NA' as TXTKEY2
	  ,null as TXTVAL2
	  ,'NA' as TXTKEY3
	  ,null as TXTVAL3
	  ,null as ItemOrder
	  ,null as ItemGuid
	  ,C.UserGuid, PP.MPI, PP.ClientCode 
	  ,S.SiteGUID, ACCT.AccountID, ACCT.AccountCD, T.IsAvailable, T.IsCustom, T.[UniqueName]
	  , T.[UniqueName] as ColDesc
  FROM [dbo].HFit_TrackerMealPortions TT
    inner join dbo.CMS_User C on C.UserID = TT.UserID
	inner join dbo.hfit_ppteligibility PP on TT.UserID = PP.userID
	inner join dbo.HFit_Account [ACCT] on PP.ClientCode = ACCT.AccountCD
	inner join dbo.CMS_Site S on ACCT.SiteID = S.SiteID
		inner join dbo.HFit_TrackerCollectionSource TC on TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
		LEFT OUTER JOIN dbo.[HFIT_Tracker] T on T.AggregateTableName = 'HFit_TrackerMealPortions'
union
SELECT 'HFit_TrackerMedicalCarePlan' as TrackerNameAggregateTable
	   	  ,TT.[ItemID] ,[EventDate],TT.[IsProfessionallyCollected],TT.[TrackerCollectionSourceID],[Notes],TT.[UserID]
	  ,CollectionSourceName_Internal,CollectionSourceName_External,'MISSING' as EventName, 'Y/N' as UOM
	  ,'FollowedPlan' as KEY1, cast(FollowedPlan as float) as VAL1
	  ,'NA' as KEY2, null as VAL2
	  ,'NA' as KEY3, null as VAL3
	  ,'NA' as KEY4, null as VAL4
      ,'NA' as KEY5, null as VAL5
      ,'NA' as KEY6, null as VAL6
	  ,'NA' as KEY7, null as VAL7
	  ,'NA' as KEY8, null as VAL8
	  ,'NA' as KEY9, null as VAL9
	  ,'NA' as KEY10, null as VAL10
	  ,TT.[ItemCreatedBy],TT.[ItemCreatedWhen],TT.[ItemModifiedBy],TT.[ItemModifiedWhen]
      ,null as [IsProcessedForHa]
	  ,'NA' as TXTKEY1
	  ,null as TXTVAL1
	  ,'NA' as TXTKEY2
	  ,null as TXTVAL2
	  ,'NA' as TXTKEY3
	  ,null as TXTVAL3
	  ,null as ItemOrder
	  ,null as ItemGuid
	  ,C.UserGuid, PP.MPI, PP.ClientCode 
	  ,S.SiteGUID, ACCT.AccountID, ACCT.AccountCD, T.IsAvailable, T.IsCustom, T.[UniqueName]
	  , T.[UniqueName] as ColDesc
  FROM [dbo].HFit_TrackerMedicalCarePlan TT
    inner join dbo.CMS_User C on C.UserID = TT.UserID
	inner join dbo.hfit_ppteligibility PP on TT.UserID = PP.userID
	inner join dbo.HFit_Account [ACCT] on PP.ClientCode = ACCT.AccountCD
	inner join dbo.CMS_Site S on ACCT.SiteID = S.SiteID
		inner join dbo.HFit_TrackerCollectionSource TC on TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
		LEFT OUTER JOIN dbo.[HFIT_Tracker] T on T.AggregateTableName = 'HFit_TrackerMedicalCarePlan'
union
SELECT 'HFit_TrackerRegularMeals' as TrackerNameAggregateTable
	   	  ,TT.[ItemID] ,[EventDate],TT.[IsProfessionallyCollected],TT.[TrackerCollectionSourceID],[Notes],TT.[UserID]
	  ,CollectionSourceName_Internal,CollectionSourceName_External,'MISSING' as EventName, 'Occurs' as UOM
	  ,'Units' as KEY1, cast(Units  as float) as VAL1
	  ,'NA' as KEY2, null as VAL2
	  ,'NA' as KEY3, null as VAL3
	  ,'NA' as KEY4, null as VAL4
      ,'NA' as KEY5, null as VAL5
      ,'NA' as KEY6, null as VAL6
	  ,'NA' as KEY7, null as VAL7
	  ,'NA' as KEY8, null as VAL8
	  ,'NA' as KEY9, null as VAL9
	  ,'NA' as KEY10, null as VAL10
	  ,TT.[ItemCreatedBy],TT.[ItemCreatedWhen],TT.[ItemModifiedBy],TT.[ItemModifiedWhen]
      ,null as [IsProcessedForHa]
	  ,'NA' as TXTKEY1
	  ,null as TXTVAL1
	  ,'NA' as TXTKEY2
	  ,null as TXTVAL2
	  ,'NA' as TXTKEY3
	  ,null as TXTVAL3
	  ,null as ItemOrder
	  ,null as ItemGuid
	  ,C.UserGuid, PP.MPI, PP.ClientCode 
	  ,S.SiteGUID, ACCT.AccountID, ACCT.AccountCD, T.IsAvailable, T.IsCustom, T.[UniqueName]
	  , T.[UniqueName] as ColDesc
  FROM [dbo].HFit_TrackerRegularMeals TT
    inner join dbo.CMS_User C on C.UserID = TT.UserID
	inner join dbo.hfit_ppteligibility PP on TT.UserID = PP.userID
	inner join dbo.HFit_Account [ACCT] on PP.ClientCode = ACCT.AccountCD
	inner join dbo.CMS_Site S on ACCT.SiteID = S.SiteID
		inner join dbo.HFit_TrackerCollectionSource TC on TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
		LEFT OUTER JOIN dbo.[HFIT_Tracker] T on T.AggregateTableName = 'HFit_TrackerRegularMeals'
union
SELECT 'HFit_TrackerRestingHeartRate' as TrackerNameAggregateTable
	   	  ,TT.[ItemID] ,[EventDate],TT.[IsProfessionallyCollected],TT.[TrackerCollectionSourceID],[Notes],TT.[UserID]
	  ,CollectionSourceName_Internal,CollectionSourceName_External,'MISSING' as EventName, 'BPM' as UOM
	  ,'HeartRate' as KEY1, cast(HeartRate  as float) as VAL1
	  ,'NA' as KEY2, null as VAL2
	  ,'NA' as KEY3, null as VAL3
	  ,'NA' as KEY4, null as VAL4
      ,'NA' as KEY5, null as VAL5
      ,'NA' as KEY6, null as VAL6
	  ,'NA' as KEY7, null as VAL7
	  ,'NA' as KEY8, null as VAL8
	  ,'NA' as KEY9, null as VAL9
	  ,'NA' as KEY10, null as VAL10
	  ,TT.[ItemCreatedBy],TT.[ItemCreatedWhen],TT.[ItemModifiedBy],TT.[ItemModifiedWhen]
      ,null as [IsProcessedForHa]
	  ,'NA' as TXTKEY1
	  ,null as TXTVAL1
	  ,'NA' as TXTKEY2
	  ,null as TXTVAL2
	  ,'NA' as TXTKEY3
	  ,null as TXTVAL3
	  ,null as ItemOrder
	  ,null as ItemGuid
	  ,C.UserGuid, PP.MPI, PP.ClientCode 
	  ,S.SiteGUID, ACCT.AccountID, ACCT.AccountCD, T.IsAvailable, T.IsCustom, T.[UniqueName]
	  , T.[UniqueName] as ColDesc
  FROM [dbo].HFit_TrackerRestingHeartRate TT
    inner join dbo.CMS_User C on C.UserID = TT.UserID
	inner join dbo.hfit_ppteligibility PP on TT.UserID = PP.userID
	inner join dbo.HFit_Account [ACCT] on PP.ClientCode = ACCT.AccountCD
	inner join dbo.CMS_Site S on ACCT.SiteID = S.SiteID
		inner join dbo.HFit_TrackerCollectionSource TC on TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
		LEFT OUTER JOIN dbo.[HFIT_Tracker] T on T.AggregateTableName = 'HFit_TrackerRestingHeartRate'
union
SELECT 'HFit_TrackerShots' as TrackerNameAggregateTable 
	   	  ,TT.[ItemID] ,[EventDate],TT.[IsProfessionallyCollected],TT.[TrackerCollectionSourceID],[Notes],TT.[UserID]
	  ,CollectionSourceName_Internal,CollectionSourceName_External,'MISSING' as EventName, 'Y/N' as UOM
	  ,'FluShot' as KEY1, cast( FluShot as float) as VAL1
	  ,'PneumoniaShot' as KEY2, cast(PneumoniaShot as float) as VAL2
	  ,'NA' as KEY3, null as VAL3
	  ,'NA' as KEY4, null as VAL4
      ,'NA' as KEY5, null as VAL5
      ,'NA' as KEY6, null as VAL6
	  ,'NA' as KEY7, null as VAL7
	  ,'NA' as KEY8, null as VAL8
	  ,'NA' as KEY9, null as VAL9
	  ,'NA' as KEY10, null as VAL10
	  ,TT.[ItemCreatedBy],TT.[ItemCreatedWhen],TT.[ItemModifiedBy],TT.[ItemModifiedWhen]
      ,null as [IsProcessedForHa]
	  ,'NA' as TXTKEY1
	  ,null as TXTVAL1
	  ,'NA' as TXTKEY2
	  ,null as TXTVAL2
	  ,'NA' as TXTKEY3
	  ,null as TXTVAL3
	  ,TT.ItemOrder
	  ,TT.ItemGuid
	  ,C.UserGuid, PP.MPI, PP.ClientCode 
	  ,S.SiteGUID, ACCT.AccountID, ACCT.AccountCD, T.IsAvailable, T.IsCustom, T.[UniqueName]
	  , T.[UniqueName] as ColDesc
  FROM [dbo].HFit_TrackerShots TT
    inner join dbo.CMS_User C on C.UserID = TT.UserID
	inner join dbo.hfit_ppteligibility PP on TT.UserID = PP.userID
	inner join dbo.HFit_Account [ACCT] on PP.ClientCode = ACCT.AccountCD
	inner join dbo.CMS_Site S on ACCT.SiteID = S.SiteID
		inner join dbo.HFit_TrackerCollectionSource TC on TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
		LEFT OUTER JOIN dbo.[HFIT_Tracker] T on T.AggregateTableName = 'HFit_TrackerShots'
union
SELECT 'HFit_TrackerSitLess' as TrackerNameAggregateTable 
	   	  ,TT.[ItemID] ,[EventDate],TT.[IsProfessionallyCollected],TT.[TrackerCollectionSourceID],[Notes],TT.[UserID]
	  ,CollectionSourceName_Internal,CollectionSourceName_External,'MISSING' as EventName, 'Occurs' as UOM
	  ,'Times' as KEY1, cast(Times  as float) as VAL1
	  ,'NA' as KEY2, null as VAL2
	  ,'NA' as KEY3, null as VAL3
	  ,'NA' as KEY4, null as VAL4
      ,'NA' as KEY5, null as VAL5
      ,'NA' as KEY6, null as VAL6
	  ,'NA' as KEY7, null as VAL7
	  ,'NA' as KEY8, null as VAL8
	  ,'NA' as KEY9, null as VAL9
	  ,'NA' as KEY10, null as VAL10
	  ,TT.[ItemCreatedBy],TT.[ItemCreatedWhen],TT.[ItemModifiedBy],TT.[ItemModifiedWhen]
      ,null as [IsProcessedForHa]
	  ,'NA' as TXTKEY1
	  ,null as TXTVAL1
	  ,'NA' as TXTKEY2
	  ,null as TXTVAL2
	  ,'NA' as TXTKEY3
	  ,null as TXTVAL3
	  ,null as ItemOrder
	  ,null as ItemGuid
	  ,C.UserGuid, PP.MPI, PP.ClientCode 
	  ,S.SiteGUID, ACCT.AccountID, ACCT.AccountCD, T.IsAvailable, T.IsCustom, T.[UniqueName]
	  , T.[UniqueName] as ColDesc
  FROM [dbo].HFit_TrackerSitLess TT
    inner join dbo.CMS_User C on C.UserID = TT.UserID
	inner join dbo.hfit_ppteligibility PP on TT.UserID = PP.userID
	inner join dbo.HFit_Account [ACCT] on PP.ClientCode = ACCT.AccountCD
	inner join dbo.CMS_Site S on ACCT.SiteID = S.SiteID
		inner join dbo.HFit_TrackerCollectionSource TC on TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
		LEFT OUTER JOIN dbo.[HFIT_Tracker] T on T.AggregateTableName = 'HFit_TrackerSitLess'
union
SELECT 'HFit_TrackerSleepPlan' as TrackerNameAggregateTable 
	   	  ,TT.[ItemID] ,[EventDate],TT.[IsProfessionallyCollected],TT.[TrackerCollectionSourceID],[Notes],TT.[UserID]
	  ,CollectionSourceName_Internal,CollectionSourceName_External,'MISSING' as EventName, 'HR' as UOM
	  ,'DidFollow' as KEY1, cast(DidFollow as float) as VAL1
	  ,'HoursSlept' as KEY2, HoursSlept as VAL2
	  ,'NA' as KEY3, null as VAL3
	  ,'NA' as KEY4, null as VAL4
      ,'NA' as KEY5, null as VAL5
      ,'NA' as KEY6, null as VAL6
	  ,'NA' as KEY7, null as VAL7
	  ,'NA' as KEY8, null as VAL8
	  ,'NA' as KEY9, null as VAL9
	  ,'NA' as KEY10, null as VAL10
	  ,TT.[ItemCreatedBy],TT.[ItemCreatedWhen],TT.[ItemModifiedBy],TT.[ItemModifiedWhen]
      ,null as [IsProcessedForHa]
	  ,'Techniques' as TXTKEY1
	  ,Techniques as TXTVAL1
	  ,'NA' as TXTKEY2
	  ,null as TXTVAL2
	  ,'NA' as TXTKEY3
	  ,null as TXTVAL3
	  ,null as ItemOrder
	  ,null as ItemGuid
	  ,C.UserGuid, PP.MPI, PP.ClientCode 
	  ,S.SiteGUID, ACCT.AccountID, ACCT.AccountCD, T.IsAvailable, T.IsCustom, T.[UniqueName]
	  , T.[UniqueName] as ColDesc
  FROM [dbo].HFit_TrackerSleepPlan TT
    inner join dbo.CMS_User C on C.UserID = TT.UserID
	inner join dbo.hfit_ppteligibility PP on TT.UserID = PP.userID
	inner join dbo.HFit_Account [ACCT] on PP.ClientCode = ACCT.AccountCD
	inner join dbo.CMS_Site S on ACCT.SiteID = S.SiteID
		inner join dbo.HFit_TrackerCollectionSource TC on TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
		LEFT OUTER JOIN dbo.[HFIT_Tracker] T on T.AggregateTableName = 'HFit_TrackerSleepPlan'
union
SELECT 'HFit_TrackerStrength' as TrackerNameAggregateTable 
	   	  ,TT.[ItemID] ,[EventDate],TT.[IsProfessionallyCollected],TT.[TrackerCollectionSourceID],[Notes],TT.[UserID]
	  ,CollectionSourceName_Internal,CollectionSourceName_External,'MISSING' as EventName, 'Y/N' as UOM
	  ,'HasTrained' as KEY1, cast(HasTrained as float) as VAL1
	  ,'NA' as KEY2, null as VAL2
	  ,'NA' as KEY3, null as VAL3
	  ,'NA' as KEY4, null as VAL4
      ,'NA' as KEY5, null as VAL5
      ,'NA' as KEY6, null as VAL6
	  ,'NA' as KEY7, null as VAL7
	  ,'NA' as KEY8, null as VAL8
	  ,'NA' as KEY9, null as VAL9
	  ,'NA' as KEY10, null as VAL10
	  ,TT.[ItemCreatedBy],TT.[ItemCreatedWhen],TT.[ItemModifiedBy],TT.[ItemModifiedWhen]
      ,null as [IsProcessedForHa]
	  ,'Activity' as TXTKEY1
	  ,Activity as TXTVAL1
	  ,'NA' as TXTKEY2
	  ,null as TXTVAL2
	  ,'NA' as TXTKEY3
	  ,null as TXTVAL3
	  ,null as ItemOrder
	  ,null as ItemGuid
	  ,C.UserGuid, PP.MPI, PP.ClientCode 
	  ,S.SiteGUID, ACCT.AccountID, ACCT.AccountCD, T.IsAvailable, T.IsCustom, T.[UniqueName]
	  , T.[UniqueName] as ColDesc
  FROM [dbo].HFit_TrackerStrength TT
    inner join dbo.CMS_User C on C.UserID = TT.UserID
	inner join dbo.hfit_ppteligibility PP on TT.UserID = PP.userID
	inner join dbo.HFit_Account [ACCT] on PP.ClientCode = ACCT.AccountCD
	inner join dbo.CMS_Site S on ACCT.SiteID = S.SiteID
		inner join dbo.HFit_TrackerCollectionSource TC on TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
		LEFT OUTER JOIN dbo.[HFIT_Tracker] T on T.AggregateTableName = 'HFit_TrackerStrength'
union
SELECT 'HFit_TrackerStress' as TrackerNameAggregateTable 
	   	  ,TT.[ItemID] ,[EventDate],TT.[IsProfessionallyCollected],TT.[TrackerCollectionSourceID],[Notes],TT.[UserID]
	  ,CollectionSourceName_Internal,CollectionSourceName_External,'MISSING' as EventName, 'gradient' as UOM
	  ,'Intensity' as KEY1, cast(Intensity  as float) as VAL1
	  ,'NA' as KEY2, null as VAL2
	  ,'NA' as KEY3, null as VAL3
	  ,'NA' as KEY4, null as VAL4
      ,'NA' as KEY5, null as VAL5
      ,'NA' as KEY6, null as VAL6
	  ,'NA' as KEY7, null as VAL7
	  ,'NA' as KEY8, null as VAL8
	  ,'NA' as KEY9, null as VAL9
	  ,'NA' as KEY10, null as VAL10
	  ,TT.[ItemCreatedBy],TT.[ItemCreatedWhen],TT.[ItemModifiedBy],TT.[ItemModifiedWhen]
      ,null as [IsProcessedForHa]
	  ,'Awareness' as TXTKEY1
	  ,Awareness as TXTVAL1
	  ,'NA' as TXTKEY2
	  ,null as TXTVAL2
	  ,'NA' as TXTKEY3
	  ,null as TXTVAL3
	  ,null as ItemOrder
	  ,null as ItemGuid
	  ,C.UserGuid, PP.MPI, PP.ClientCode 
	  ,S.SiteGUID, ACCT.AccountID, ACCT.AccountCD, T.IsAvailable, T.IsCustom, T.[UniqueName]
	  , T.[UniqueName] as ColDesc
  FROM [dbo].HFit_TrackerStress TT
    inner join dbo.CMS_User C on C.UserID = TT.UserID
	inner join dbo.hfit_ppteligibility PP on TT.UserID = PP.userID
	inner join dbo.HFit_Account [ACCT] on PP.ClientCode = ACCT.AccountCD
	inner join dbo.CMS_Site S on ACCT.SiteID = S.SiteID
		inner join dbo.HFit_TrackerCollectionSource TC on TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
		LEFT OUTER JOIN dbo.[HFIT_Tracker] T on T.AggregateTableName = 'HFit_TrackerStress'
union
SELECT 'HFit_TrackerStressManagement' as TrackerNameAggregateTable 
	   	  ,TT.[ItemID] ,[EventDate],TT.[IsProfessionallyCollected],TT.[TrackerCollectionSourceID],[Notes],TT.[UserID]
	  ,CollectionSourceName_Internal,CollectionSourceName_External,'MISSING' as EventName, 'gradient' as UOM
	  ,'HasPracticed' as KEY1, cast(HasPracticed  as float) as VAL1
	  ,'Effectiveness' as KEY2, cast(Effectiveness  as float) as VAL2
	  ,'NA' as KEY3, null as VAL3
	  ,'NA' as KEY4, null as VAL4
      ,'NA' as KEY5, null as VAL5
      ,'NA' as KEY6, null as VAL6
	  ,'NA' as KEY7, null as VAL7
	  ,'NA' as KEY8, null as VAL8
	  ,'NA' as KEY9, null as VAL9
	  ,'NA' as KEY10, null as VAL10
	  ,TT.[ItemCreatedBy],TT.[ItemCreatedWhen],TT.[ItemModifiedBy],TT.[ItemModifiedWhen]
      ,null as [IsProcessedForHa]
	  ,'Activity' as TXTKEY1
	  ,Activity as TXTVAL1
	  ,'NA' as TXTKEY2
	  ,null as TXTVAL2
	  ,'NA' as TXTKEY3
	  ,null as TXTVAL3
	  ,null as ItemOrder
	  ,null as ItemGuid
	  ,C.UserGuid, PP.MPI, PP.ClientCode 
	  ,S.SiteGUID, ACCT.AccountID, ACCT.AccountCD, T.IsAvailable, T.IsCustom, T.[UniqueName]
	  , T.[UniqueName] as ColDesc
  FROM [dbo].HFit_TrackerStressManagement TT
    inner join dbo.CMS_User C on C.UserID = TT.UserID
	inner join dbo.hfit_ppteligibility PP on TT.UserID = PP.userID
	inner join dbo.HFit_Account [ACCT] on PP.ClientCode = ACCT.AccountCD
	inner join dbo.CMS_Site S on ACCT.SiteID = S.SiteID
		inner join dbo.HFit_TrackerCollectionSource TC on TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
		LEFT OUTER JOIN dbo.[HFIT_Tracker] T on T.AggregateTableName = 'HFit_TrackerStressManagement'
union
SELECT 'HFit_TrackerSugaryDrinks' as TrackerNameAggregateTable 
	  ,TT.[ItemID] ,[EventDate],TT.[IsProfessionallyCollected],TT.[TrackerCollectionSourceID],[Notes],TT.[UserID]
	  ,CollectionSourceName_Internal,CollectionSourceName_External,'MISSING' as EventName, 'OZ' as UOM
	  ,'Ounces' as KEY1, cast(Ounces  as float) as VAL1
	  ,'NA' as KEY2, null as VAL2
	  ,'NA' as KEY3, null as VAL3
	  ,'NA' as KEY4, null as VAL4
      ,'NA' as KEY5, null as VAL5
      ,'NA' as KEY6, null as VAL6
	  ,'NA' as KEY7, null as VAL7
	  ,'NA' as KEY8, null as VAL8
	  ,'NA' as KEY9, null as VAL9
	  ,'NA' as KEY10, null as VAL10
	  ,TT.[ItemCreatedBy],TT.[ItemCreatedWhen],TT.[ItemModifiedBy],TT.[ItemModifiedWhen]
      ,null as [IsProcessedForHa]
	  ,'NA' as TXTKEY1
	  ,null as TXTVAL1
	  ,'NA' as TXTKEY2
	  ,null as TXTVAL2
	  ,'NA' as TXTKEY3
	  ,null as TXTVAL3
	  ,null as ItemOrder
	  ,null as ItemGuid
	  ,C.UserGuid, PP.MPI, PP.ClientCode 
	  ,S.SiteGUID, ACCT.AccountID, ACCT.AccountCD, T.IsAvailable, T.IsCustom, T.[UniqueName]
	  , T.[UniqueName] as ColDesc
  FROM [dbo].HFit_TrackerSugaryDrinks TT
    inner join dbo.CMS_User C on C.UserID = TT.UserID
	inner join dbo.hfit_ppteligibility PP on TT.UserID = PP.userID
	inner join dbo.HFit_Account [ACCT] on PP.ClientCode = ACCT.AccountCD
	inner join dbo.CMS_Site S on ACCT.SiteID = S.SiteID
		inner join dbo.HFit_TrackerCollectionSource TC on TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
		LEFT OUTER JOIN dbo.[HFIT_Tracker] T on T.AggregateTableName = 'HFit_TrackerSugaryDrinks'
union
SELECT 'HFit_TrackerSugaryFoods' as TrackerNameAggregateTable 
	  ,TT.[ItemID] ,[EventDate],TT.[IsProfessionallyCollected],TT.[TrackerCollectionSourceID],[Notes],TT.[UserID]
	  ,CollectionSourceName_Internal,CollectionSourceName_External,'MISSING' as EventName, 'NA-portion' as UOM
	  ,'Portions' as KEY1, cast(Portions  as float) as VAL1
	  ,'NA' as KEY2, null as VAL2
	  ,'NA' as KEY3, null as VAL3
	  ,'NA' as KEY4, null as VAL4
      ,'NA' as KEY5, null as VAL5
      ,'NA' as KEY6, null as VAL6
	  ,'NA' as KEY7, null as VAL7
	  ,'NA' as KEY8, null as VAL8
	  ,'NA' as KEY9, null as VAL9
	  ,'NA' as KEY10, null as VAL10
	  ,TT.[ItemCreatedBy],TT.[ItemCreatedWhen],TT.[ItemModifiedBy],TT.[ItemModifiedWhen]
      ,null as [IsProcessedForHa]
	  ,'NA' as TXTKEY1
	  ,null as TXTVAL1
	  ,'NA' as TXTKEY2
	  ,null as TXTVAL2
	  ,'NA' as TXTKEY3
	  ,null as TXTVAL3
	  ,null as ItemOrder
	  ,null as ItemGuid
	  ,C.UserGuid, PP.MPI, PP.ClientCode 
	  ,S.SiteGUID, ACCT.AccountID, ACCT.AccountCD, T.IsAvailable, T.IsCustom, T.[UniqueName]
	  , T.[UniqueName] as ColDesc
  FROM [dbo].HFit_TrackerSugaryFoods TT
    inner join dbo.CMS_User C on C.UserID = TT.UserID
	inner join dbo.hfit_ppteligibility PP on TT.UserID = PP.userID
	inner join dbo.HFit_Account [ACCT] on PP.ClientCode = ACCT.AccountCD
	inner join dbo.CMS_Site S on ACCT.SiteID = S.SiteID
		inner join dbo.HFit_TrackerCollectionSource TC on TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
		LEFT OUTER JOIN dbo.[HFIT_Tracker] T on T.AggregateTableName = 'HFit_TrackerSugaryFoods'
union
SELECT 'HFit_TrackerTests' as TrackerNameAggregateTable 
	  ,TT.[ItemID] ,[EventDate],TT.[IsProfessionallyCollected],TT.[TrackerCollectionSourceID],[Notes],TT.[UserID]
	  ,CollectionSourceName_Internal,CollectionSourceName_External,'MISSING' as EventName, 'NA' as UOM
	  ,'PSATest' as KEY1, cast(PSATest  as float) as VAL1
	  ,'OtherExam' as KEY1, cast(OtherExam as float) as VAL2
	  ,'TScore' as KEY3, cast(TScore  as float) as VAL3
	  ,'DRA' as KEY4, cast(DRA  as float) as VAL4
      ,'CotinineTest' as KEY5, cast(CotinineTest as float) as VAL5
      ,'ColoCareKit' as KEY6, cast(ColoCareKit as float) as VAL6
	  ,'CustomTest' as KEY7, cast(CustomTest as float) as VAL7
	  ,'TSH' as KEY8, cast(TSH as float) as VAL8
	  ,'NA' as KEY9, null as VAL9
	  ,'NA' as KEY10, null as VAL10
	  ,TT.[ItemCreatedBy],TT.[ItemCreatedWhen],TT.[ItemModifiedBy],TT.[ItemModifiedWhen]
      ,null as [IsProcessedForHa]
	  ,'CustomDesc' as TXTKEY1, CustomDesc as TXTVAL1
	  ,'NA' as TXTKEY2, null as TXTVAL2
	  ,'NA' as TXTKEY3, null as TXTVAL3
	  ,TT.ItemOrder
	  ,TT.ItemGuid
	  ,C.UserGuid, PP.MPI, PP.ClientCode 
	  ,S.SiteGUID, ACCT.AccountID, ACCT.AccountCD, T.IsAvailable, T.IsCustom, T.[UniqueName]
	  , T.[UniqueName] as ColDesc
  FROM [dbo].HFit_TrackerTests TT
    inner join dbo.CMS_User C on C.UserID = TT.UserID
	inner join dbo.hfit_ppteligibility PP on TT.UserID = PP.userID
	inner join dbo.HFit_Account [ACCT] on PP.ClientCode = ACCT.AccountCD
	inner join dbo.CMS_Site S on ACCT.SiteID = S.SiteID
		inner join dbo.HFit_TrackerCollectionSource TC on TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
		LEFT OUTER JOIN dbo.[HFIT_Tracker] T on T.AggregateTableName = 'HFit_TrackerTests'
union
SELECT 'HFit_TrackerTobaccoFree' as TrackerNameAggregateTable 
	  ,TT.[ItemID] ,[EventDate],TT.[IsProfessionallyCollected],TT.[TrackerCollectionSourceID],[Notes],TT.[UserID]
	  ,CollectionSourceName_Internal,CollectionSourceName_External,'MISSING' as EventName, 'Y/N' as UOM
	  ,'WasTobaccoFree' as KEY1, cast(WasTobaccoFree as float) as VAL1
	   ,'NA' as KEY2, null as VAL2
	  ,'NA' as KEY3, null as VAL3
	  ,'NA' as KEY4, null as VAL4
      ,'NA' as KEY5, null as VAL5
      ,'NA' as KEY6, null as VAL6
	  ,'NA' as KEY7, null as VAL7
	  ,'NA' as KEY8, null as VAL8
	  ,'NA' as KEY9, null as VAL9
	  ,'NA' as KEY10, null as VAL10
	  ,TT.[ItemCreatedBy],TT.[ItemCreatedWhen],TT.[ItemModifiedBy],TT.[ItemModifiedWhen]
      ,null as [IsProcessedForHa]
	  ,'QuitAids' as TXTKEY1
	  ,QuitAids as TXTVAL1
	  ,'QuitMeds' as TXTKEY2
	  ,QuitMeds as TXTVAL2
	  ,'NA' as TXTKEY3
	  ,null as TXTVAL3
	  ,null as ItemOrder
	  ,null as ItemGuid
	  ,C.UserGuid, PP.MPI, PP.ClientCode 
	  ,S.SiteGUID, ACCT.AccountID, ACCT.AccountCD, T.IsAvailable, T.IsCustom, T.[UniqueName]
	  , T.[UniqueName] as ColDesc
  FROM [dbo].HFit_TrackerTobaccoFree TT
    inner join dbo.CMS_User C on C.UserID = TT.UserID
	inner join dbo.hfit_ppteligibility PP on TT.UserID = PP.userID
	inner join dbo.HFit_Account [ACCT] on PP.ClientCode = ACCT.AccountCD
	inner join dbo.CMS_Site S on ACCT.SiteID = S.SiteID
		inner join dbo.HFit_TrackerCollectionSource TC on TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
		LEFT OUTER JOIN dbo.[HFIT_Tracker] T on T.AggregateTableName = 'HFit_TrackerTobaccoFree'
union
SELECT 'HFit_TrackerVegetables' as TrackerNameAggregateTable 
	   	  ,TT.[ItemID] ,[EventDate],TT.[IsProfessionallyCollected],TT.[TrackerCollectionSourceID],[Notes],TT.[UserID]
	  ,CollectionSourceName_Internal,CollectionSourceName_External,'MISSING' as EventName, 'CUP(8oz)' as UOM
	  ,'Cups' as KEY1, cast(Cups  as float) as VAL1
	   ,'NA' as KEY2, null as VAL2
	  ,'NA' as KEY3, null as VAL3
	  ,'NA' as KEY4, null as VAL4
      ,'NA' as KEY5, null as VAL5
      ,'NA' as KEY6, null as VAL6
	  ,'NA' as KEY7, null as VAL7
	  ,'NA' as KEY8, null as VAL8
	  ,'NA' as KEY9, null as VAL9
	  ,'NA' as KEY10, null as VAL10
	  ,TT.[ItemCreatedBy],TT.[ItemCreatedWhen],TT.[ItemModifiedBy],TT.[ItemModifiedWhen]
      ,null as [IsProcessedForHa]
	  ,'NA' as TXTKEY1
	  ,null as TXTVAL1
	  ,'NA' as TXTKEY2
	  ,null as TXTVAL2
	  ,'NA' as TXTKEY3
	  ,null as TXTVAL3
	  ,null as ItemOrder
	  ,null as ItemGuid
	  ,C.UserGuid, PP.MPI, PP.ClientCode 
	  ,S.SiteGUID, ACCT.AccountID, ACCT.AccountCD, T.IsAvailable, T.IsCustom, T.[UniqueName]
	  , T.[UniqueName] as ColDesc
  FROM [dbo].HFit_TrackerVegetables TT
    inner join dbo.CMS_User C on C.UserID = TT.UserID
	inner join dbo.hfit_ppteligibility PP on TT.UserID = PP.userID
	inner join dbo.HFit_Account [ACCT] on PP.ClientCode = ACCT.AccountCD
	inner join dbo.CMS_Site S on ACCT.SiteID = S.SiteID
		inner join dbo.HFit_TrackerCollectionSource TC on TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
		LEFT OUTER JOIN dbo.[HFIT_Tracker] T on T.AggregateTableName = 'HFit_TrackerVegetables'
union
SELECT 'HFit_TrackerWater' as TrackerNameAggregateTable 
	  ,TT.[ItemID] ,[EventDate],TT.[IsProfessionallyCollected],TT.[TrackerCollectionSourceID],[Notes],TT.[UserID]
	  ,CollectionSourceName_Internal,CollectionSourceName_External,'MISSING' as EventName, 'OZ' as UOM
	  ,'Ounces' as KEY1, cast(Ounces  as float) as VAL1
	  ,'NA' as KEY2, null as VAL2
	  ,'NA' as KEY3, null as VAL3
	  ,'NA' as KEY4, null as VAL4
      ,'NA' as KEY5, null as VAL5
      ,'NA' as KEY6, null as VAL6
	  ,'NA' as KEY7, null as VAL7
	  ,'NA' as KEY8, null as VAL8
	  ,'NA' as KEY9, null as VAL9
	  ,'NA' as KEY10, null as VAL10
	  ,TT.[ItemCreatedBy],TT.[ItemCreatedWhen],TT.[ItemModifiedBy],TT.[ItemModifiedWhen]
      ,null as [IsProcessedForHa]
	  ,'NA' as TXTKEY1
	  ,null as TXTVAL1
	  ,'NA' as TXTKEY2
	  ,null as TXTVAL2
	  ,'NA' as TXTKEY3
	  ,null as TXTVAL3
	  ,null as ItemOrder
	  ,null as ItemGuid
	  ,C.UserGuid, PP.MPI, PP.ClientCode 
	  ,S.SiteGUID, ACCT.AccountID, ACCT.AccountCD, T.IsAvailable, T.IsCustom, T.[UniqueName]
	  , T.[UniqueName] as ColDesc
  FROM [dbo].HFit_TrackerWater TT
    inner join dbo.CMS_User C on C.UserID = TT.UserID
	inner join dbo.hfit_ppteligibility PP on TT.UserID = PP.userID
	inner join dbo.HFit_Account [ACCT] on PP.ClientCode = ACCT.AccountCD
	inner join dbo.CMS_Site S on ACCT.SiteID = S.SiteID
		inner join dbo.HFit_TrackerCollectionSource TC on TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
		LEFT OUTER JOIN dbo.[HFIT_Tracker] T on T.AggregateTableName = 'HFit_TrackerWater'
union
SELECT 'HFit_TrackerWeight' as TrackerNameAggregateTable 
	  ,TT.[ItemID] ,[EventDate],TT.[IsProfessionallyCollected],TT.[TrackerCollectionSourceID],[Notes],TT.[UserID]
	  ,CollectionSourceName_Internal,CollectionSourceName_External,'MISSING' as EventName, 'LBS' as UOM
	  ,'Value' as KEY1, [Value] as VAL1
	   ,'NA' as KEY2, null as VAL2
	  ,'NA' as KEY3, null as VAL3
	  ,'NA' as KEY4, null as VAL4
      ,'NA' as KEY5, null as VAL5
      ,'NA' as KEY6, null as VAL6
	  ,'NA' as KEY7, null as VAL7
	  ,'NA' as KEY8, null as VAL8
	  ,'NA' as KEY9, null as VAL9
	  ,'NA' as KEY10, null as VAL10
	  ,TT.[ItemCreatedBy],TT.[ItemCreatedWhen],TT.[ItemModifiedBy],TT.[ItemModifiedWhen]
      ,[IsProcessedForHa]
	  ,'NA' as TXTKEY1
	  ,null as TXTVAL1
	  ,'NA' as TXTKEY2
	  ,null as TXTVAL2
	  ,'NA' as TXTKEY3
	  ,null as TXTVAL3
	  ,null as ItemOrder
	  ,null as ItemGuid
	  ,C.UserGuid, PP.MPI, PP.ClientCode 
	  ,S.SiteGUID, ACCT.AccountID, ACCT.AccountCD, T.IsAvailable, T.IsCustom, T.[UniqueName]
	  , T.[UniqueName] as ColDesc
  FROM [dbo].HFit_TrackerWeight TT
    inner join dbo.CMS_User C on C.UserID = TT.UserID
	inner join dbo.hfit_ppteligibility PP on TT.UserID = PP.userID
	inner join dbo.HFit_Account [ACCT] on PP.ClientCode = ACCT.AccountCD
	inner join dbo.CMS_Site S on ACCT.SiteID = S.SiteID
		inner join dbo.HFit_TrackerCollectionSource TC on TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
		LEFT OUTER JOIN dbo.[HFIT_Tracker] T on T.AggregateTableName = 'HFit_TrackerWeight'
union
SELECT 'HFit_TrackerWholeGrains' as TrackerNameAggregateTable 
	  ,TT.[ItemID] ,[EventDate],TT.[IsProfessionallyCollected],TT.[TrackerCollectionSourceID],[Notes],TT.[UserID]
	  ,CollectionSourceName_Internal,CollectionSourceName_External,'MISSING' as EventName, 'NA-serving' as UOM
	  ,'Servings' as KEY1, cast(Servings  as float) as VAL1
	   ,'NA' as KEY2, null as VAL2
	  ,'NA' as KEY3, null as VAL3
	  ,'NA' as KEY4, null as VAL4
      ,'NA' as KEY5, null as VAL5
      ,'NA' as KEY6, null as VAL6
	  ,'NA' as KEY7, null as VAL7
	  ,'NA' as KEY8, null as VAL8
	  ,'NA' as KEY9, null as VAL9
	  ,'NA' as KEY10, null as VAL10
	  ,TT.[ItemCreatedBy],TT.[ItemCreatedWhen],TT.[ItemModifiedBy],TT.[ItemModifiedWhen]
      ,null as [IsProcessedForHa]
	  ,'NA' as TXTKEY1
	  ,null as TXTVAL1
	  ,'NA' as TXTKEY2
	  ,null as TXTVAL2
	  ,'NA' as TXTKEY3
	  ,null as TXTVAL3
	  ,null as ItemOrder
	  ,null as ItemGuid
	  ,C.UserGuid, PP.MPI, PP.ClientCode 
	  ,S.SiteGUID, ACCT.AccountID, ACCT.AccountCD, T.IsAvailable, T.IsCustom, T.[UniqueName]
	  , T.[UniqueName] as ColDesc
  FROM [dbo].HFit_TrackerWholeGrains TT
    inner join dbo.CMS_User C on C.UserID = TT.UserID
	inner join dbo.hfit_ppteligibility PP on TT.UserID = PP.userID
	inner join dbo.HFit_Account [ACCT] on PP.ClientCode = ACCT.AccountCD
	inner join dbo.CMS_Site S on ACCT.SiteID = S.SiteID
		inner join dbo.HFit_TrackerCollectionSource TC on TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
		LEFT OUTER JOIN dbo.[HFIT_Tracker] T on T.AggregateTableName = 'HFit_TrackerWholeGrains'
union
SELECT 'HFit_TrackerShots' as TrackerNameAggregateTable 
	  ,TT.[ItemID] ,[EventDate],TT.[IsProfessionallyCollected],TT.[TrackerCollectionSourceID],[Notes],TT.[UserID]
	  ,NULL as CollectionSourceName_Internal
	  ,NULL as CollectionSourceName_External
	  ,'MISSING' as EventName
	  ,'NA' as UOM
	  ,'FluShot' as KEY1, cast(FluShot as float) as VAL1
	   ,'PneumoniaShot' as KEY2, cast(PneumoniaShot as float) as VAL2
	  ,'NA' as KEY3, null as VAL3
	  ,'NA' as KEY4, null as VAL4
      ,'NA' as KEY5, null as VAL5
      ,'NA' as KEY6, null as VAL6
	  ,'NA' as KEY7, null as VAL7
	  ,'NA' as KEY8, null as VAL8
	  ,'NA' as KEY9, null as VAL9
	  ,'NA' as KEY10, null as VAL10
	  ,TT.[ItemCreatedBy],TT.[ItemCreatedWhen],TT.[ItemModifiedBy],TT.[ItemModifiedWhen]
      ,null as [IsProcessedForHa]
	  ,'NA' as TXTKEY1
	  ,null as TXTVAL1
	  ,'NA' as TXTKEY2
	  ,null as TXTVAL2
	  ,'NA' as TXTKEY3
	  ,null as TXTVAL3
	  ,null as ItemOrder
	  ,null as ItemGuid
	  ,C.UserGuid, PP.MPI, PP.ClientCode 
	  ,S.SiteGUID, ACCT.AccountID, ACCT.AccountCD, T.IsAvailable, T.IsCustom, T.[UniqueName]
	  , T.[UniqueName] as ColDesc
  FROM [dbo].HFit_TrackerShots TT
    inner join dbo.CMS_User C on C.UserID = TT.UserID
	inner join dbo.hfit_ppteligibility PP on TT.UserID = PP.userID
	inner join dbo.HFit_Account [ACCT] on PP.ClientCode = ACCT.AccountCD
	inner join dbo.CMS_Site S on ACCT.SiteID = S.SiteID
		inner join dbo.HFit_TrackerCollectionSource TC on TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
		LEFT OUTER JOIN dbo.[HFIT_Tracker] T on T.AggregateTableName = 'HFit_TrackerShots'
union
SELECT 'HFit_TrackerTests' as TrackerNameAggregateTable 
	  ,TT.[ItemID] ,[EventDate],TT.[IsProfessionallyCollected],TT.[TrackerCollectionSourceID],[Notes],TT.[UserID]
	  ,NULL as CollectionSourceName_Internal
	  ,NULL as CollectionSourceName_External
	  ,'MISSING' as EventName
	  ,'NA' as UOM
	  ,'PSATest' as KEY1, cast(PSATest as float) as VAL1
	   ,'OtherExam' as KEY2, cast(OtherExam as float) as VAL2
	  ,'TScore' as KEY3, cast(TScore as float)  as VAL3
	  ,'DRA' as KEY4, cast(DRA as float)  as VAL4
      ,'CotinineTest' as KEY5, cast(CotinineTest as float)  as VAL5
      ,'ColoCareKit' as KEY6, cast(ColoCareKit as float)  as VAL6
	  ,'CustomTest' as KEY7,  cast(CustomTest as float) as VAL7
	  ,'NA' as KEY8, null as VAL8
	  ,'NA' as KEY9, null as VAL9
	  ,'NA' as KEY10, null as VAL10
	  ,TT.[ItemCreatedBy],TT.[ItemCreatedWhen],TT.[ItemModifiedBy],TT.[ItemModifiedWhen]
      ,null as [IsProcessedForHa]
	  ,'CustomDesc' as TXTKEY1
	  ,CustomDesc as TXTVAL1
	  ,'NA' as TXTKEY2
	  ,null as TXTVAL2
	  ,'NA' as TXTKEY3
	  ,null as TXTVAL3
	  ,null as ItemOrder
	  ,null as ItemGuid
	  ,C.UserGuid, PP.MPI, PP.ClientCode 
	  ,S.SiteGUID, ACCT.AccountID, ACCT.AccountCD, T.IsAvailable, T.IsCustom, T.[UniqueName]
	  , T.[UniqueName] as ColDesc
  FROM [dbo].HFit_TrackerTests TT
    inner join dbo.CMS_User C on C.UserID = TT.UserID
	inner join dbo.hfit_ppteligibility PP on TT.UserID = PP.userID
	inner join dbo.HFit_Account [ACCT] on PP.ClientCode = ACCT.AccountCD
	inner join dbo.CMS_Site S on ACCT.SiteID = S.SiteID
		inner join dbo.HFit_TrackerCollectionSource TC on TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
		LEFT OUTER JOIN dbo.[HFIT_Tracker] T on T.AggregateTableName = 'HFit_TrackerTests'
		
GO


if exists(select TABLE_NAME from INFORMATION_SCHEMA.VIEWS where TABLE_NAME = 'view_EDW_TrackerMetadata')
BEGIN
	drop view view_EDW_TrackerMetadata ;
END
GO


CREATE View [dbo].[view_EDW_TrackerMetadata]
as
--******************************************************************************************************
--TableName - this is the CMS_CLASS ClassName and is used to identify the needed metadata. 
--ColumnName - Each Class has a set of columns. This is the name of the column as contained
--				within the CLASS.
--AttrName - The name of the attribute as it applies to the column (e.g. column type 
--				describes the datatype of the column (ColName) within the CLASS (ClassName).
--AttrVal - the value assigned to the AttrName.
--CreatedDate - the date this row of metadata was created.
--LastModifiedDate - the date this row of metadata was last changed in the Tracker_EDW_Metadata table.
--ID - An identity field within the Tracker_EDW_Metadata table.
--ClassLastModified - The last date the CLASS within CMS_CLASS was changed.
--09.11.2014 : (wdm) Verified last mod date available to EDW 
--******************************************************************************************************
SELECT TableName, ColName, AttrName, AttrVal, CreatedDate, LastModifiedDate, ID, CMS_CLASS.ClassLastModified
FROM     Tracker_EDW_Metadata
join CMS_CLASS on CMS_CLASS.ClassName = TableName


GO




if exists(select TABLE_NAME from INFORMATION_SCHEMA.VIEWS where TABLE_NAME = 'view_EDW_TrackerShots')
BEGIN
	drop view view_EDW_TrackerShots ;
END
go

/****** Object:  View [dbo].[view_EDW_TrackerShots]    Script Date: 9/11/2014 11:14:43 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
--********************************************************************************************************
--09.11.2014 : (wdm) Verified last mod date available to EDW 
--********************************************************************************************************
CREATE VIEW [dbo].[view_EDW_TrackerShots]
AS
	SELECT
		HFTS.UserID
		, cus.UserSettingsUserGUID
		, CUS.HFitUserMpiNumber
		, CS.SiteID
		, cs.SiteGUID
		, HFTS.ItemID
		, HFTS.EventDate
		, HFTS.IsProfessionallyCollected
		, HFTS.TrackerCollectionSourceID
		, HFTS.Notes
		, HFTS.FluShot
		, HFTS.PneumoniaShot
		, HFTS.ItemCreatedWhen
		, HFTS.ItemModifiedWhen
		, HFTS.ItemGUID
	FROM
		dbo.HFit_TrackerShots AS HFTS
	INNER JOIN dbo.HFit_PPTEligibility AS HFPE WITH ( NOLOCK ) ON HFTS.UserID = HFPE.UserID
	INNER JOIN dbo.CMS_UserSettings AS CUS WITH ( NOLOCK ) ON HFTS.UserID = cus.UserSettingsUserID
	INNER JOIN dbo.CMS_UserSite AS CUS2 WITH ( NOLOCK ) ON cus.UserSettingsUserID = cus2.UserID
	INNER JOIN dbo.CMS_Site AS CS WITH ( NOLOCK ) ON cus2.SiteID = CS.SiteID
	INNER JOIN dbo.HFit_Account AS HFA WITH ( NOLOCK ) ON CS.SiteID = HFA.SiteID

GO



GO

if exists(select TABLE_NAME from INFORMATION_SCHEMA.VIEWS where TABLE_NAME = 'view_EDW_TrackerTests')
BEGIN
	drop view view_EDW_TrackerTests ;
END

GO


--********************************************************************************************************
--09.11.2014 : (wdm) Verified last mod date available to EDW 
--********************************************************************************************************
CREATE VIEW [dbo].[view_EDW_TrackerTests]
AS
	SELECT
		HFTT.UserID
		, cus.UserSettingsUserGUID
		, CUS.HFitUserMpiNumber
		, CS.SiteID
		, cs.SiteGUID
		, HFTT.EventDate
		, HFTT.IsProfessionallyCollected
		, HFTT.TrackerCollectionSourceID
		, HFTT.Notes
		, HFTT.PSATest
		, HFTT.OtherExam
		, HFTT.TScore
		, HFTT.DRA
		, HFTT.CotinineTest
		, HFTT.ColoCareKit
		, HFTT.CustomTest
		, HFTT.CustomDesc
		, HFTT.TSH
		, HFTT.ItemCreatedWhen
		, HFTT.ItemModifiedWhen
		, HFTT.ItemGUID
	FROM
		dbo.HFit_TrackerTests AS HFTT
	INNER JOIN dbo.HFit_PPTEligibility AS HFPE WITH ( NOLOCK ) ON HFTT.UserID = HFPE.UserID
	INNER JOIN dbo.CMS_UserSettings AS CUS WITH ( NOLOCK ) ON HFTT.UserID = cus.UserSettingsUserID
	INNER JOIN dbo.CMS_UserSite AS CUS2 WITH ( NOLOCK ) ON cus.UserSettingsUserID = cus2.UserID
	INNER JOIN dbo.CMS_Site AS CS WITH ( NOLOCK ) ON cus2.SiteID = CS.SiteID
	INNER JOIN dbo.HFit_Account AS HFA WITH ( NOLOCK ) ON CS.SiteID = HFA.SiteID
GO



if exists (select * from sysobjects where name = 'Proc_EDW_GenerateMetadata' and Xtype = 'P')
BEGIN
	drop procedure Proc_EDW_GenerateMetadata ;
END 
go

--select * from view_EDW_TrackerMetadata where TableName = 'HFit.CustomTrackerInstances'
--select * from Tracker_EDW_Metadata
--delete from Tracker_EDW_Metadata where TableName = 'HFit.TrackerWholeGrains'

--exec Proc_EDW_GenerateMetadata
--2014-07-30 20:59:10.940

CREATE procedure [dbo].[Proc_EDW_GenerateMetadata]
as 
BEGIN
	--truncate table Tracker_EDW_Metadata;
	BEGIN TRAN T1;
	EXEC Proc_EDW_TrackerMetadataExtract 'HFIT.Tracker';	
	COMMIT TRAN T1;
	BEGIN TRAN T2;
	EXEC Proc_EDW_TrackerMetadataExtract 'HFit.TrackerCategory';
	COMMIT TRAN T2;
	BEGIN TRAN T3;
	EXEC Proc_EDW_TrackerMetadataExtract 'HFit.TrackerDocument';
	COMMIT TRAN T3;
	BEGIN TRAN T4;
	EXEC Proc_EDW_TrackerMetadataExtract 'HFit.UserTracker';
	COMMIT TRAN T4;
	BEGIN TRAN T5;
	EXEC Proc_EDW_TrackerMetadataExtract 'HFit.UserTrackerCategory';
	COMMIT TRAN T5;
	BEGIN TRAN T6;	
	EXEC Proc_EDW_TrackerMetadataExtract 'HFit.TrackerCollectionSource';
	COMMIT TRAN T6;
	BEGIN TRAN T7;
	EXEC Proc_EDW_TrackerMetadataExtract 'HFit.TrackerVegetables';	
	COMMIT TRAN T7;
	BEGIN TRAN T8;
	EXEC Proc_EDW_TrackerMetadataExtract 'HFit.LKP_TrackerTobaccoQuitAids';
	COMMIT TRAN T8;
	BEGIN TRAN T9;
	EXEC Proc_EDW_TrackerMetadataExtract 'HFit.TrackerTobaccoFree';
	COMMIT TRAN T9;
	BEGIN TRAN T10;
	EXEC Proc_EDW_TrackerMetadataExtract 'HFit.TrackerWholeGrains';
	COMMIT TRAN T10;
	BEGIN TRAN T11;
	EXEC Proc_EDW_TrackerMetadataExtract 'HFit.TrackerFruits';
	COMMIT TRAN T11;
	BEGIN TRAN T12;
	EXEC Proc_EDW_TrackerMetadataExtract 'HFit.TrackerSugaryDrinks';
	COMMIT TRAN T12;
	BEGIN  TRAN T13;
	EXEC Proc_EDW_TrackerMetadataExtract 'HFit.TrackerWater';
	COMMIT TRAN T13;
	BEGIN  TRAN T14;
	EXEC Proc_EDW_TrackerMetadataExtract 'HFit.TrackerHighSodiumFoods';
	COMMIT TRAN T15;
	BEGIN  TRAN T16;
	EXEC Proc_EDW_TrackerMetadataExtract 'HFit.TrackerHighFatFoods';
	COMMIT TRAN T16;
	BEGIN  TRAN T17;
	EXEC Proc_EDW_TrackerMetadataExtract 'HFit.TrackerSleepPlan';
	COMMIT TRAN T17;
	BEGIN  TRAN T18;
	EXEC Proc_EDW_TrackerMetadataExtract 'HFit.LKP_TrackerSleepPlanTechniques';
	COMMIT TRAN T18;
	BEGIN  TRAN T19;
	EXEC Proc_EDW_TrackerMetadataExtract 'HFit.TrackerMedicalCarePlan';
	COMMIT TRAN T19;
	BEGIN  TRAN T20;
	EXEC Proc_EDW_TrackerMetadataExtract 'HFit.TrackerSummary';
	COMMIT TRAN T20;
	BEGIN  TRAN T21;
	EXEC Proc_EDW_TrackerMetadataExtract 'HFit.TrackerRegularMeals';
	COMMIT TRAN T21;
	BEGIN  TRAN T22;
	EXEC Proc_EDW_TrackerMetadataExtract 'HFit.TrackerBodyFat';
	COMMIT TRAN T22;
	BEGIN  TRAN T23;
	EXEC Proc_EDW_TrackerMetadataExtract 'HFit.TrackerWeight';
	COMMIT TRAN T23;
	BEGIN  TRAN T24;
	EXEC Proc_EDW_TrackerMetadataExtract 'HFit.TrackerBloodSugarGlucose';
	COMMIT TRAN T24;
	BEGIN  TRAN T25;
	EXEC Proc_EDW_TrackerMetadataExtract 'HFit.TrackerHbA1c';
	COMMIT TRAN T25;
	BEGIN  TRAN T26;
	EXEC Proc_EDW_TrackerMetadataExtract 'HFit.TrackerMealPortions';
	COMMIT TRAN T26;
	BEGIN  TRAN T27;
	EXEC Proc_EDW_TrackerMetadataExtract 'HFit.TrackerSugaryFoods';
	COMMIT TRAN T27;
	BEGIN  TRAN T28;
	EXEC Proc_EDW_TrackerMetadataExtract 'HFit.LKP_TrackerStrengthActivity';
	COMMIT TRAN T29;
	BEGIN  TRAN T30;
	EXEC Proc_EDW_TrackerMetadataExtract 'HFit.TrackerRestingHeartRate';
	COMMIT TRAN T30;
	BEGIN  TRAN T31;
	EXEC Proc_EDW_TrackerMetadataExtract 'HFit.TrackerCholesterol';
	COMMIT TRAN T31;
	BEGIN  TRAN T32;
	EXEC Proc_EDW_TrackerMetadataExtract 'HFit.TrackerBodyMeasurements';
	COMMIT TRAN T32;
	BEGIN  TRAN T33;
	EXEC Proc_EDW_TrackerMetadataExtract 'HFit.TrackerBloodPressure';
	COMMIT TRAN T33;
	BEGIN  TRAN T34;
	EXEC Proc_EDW_TrackerMetadataExtract 'HFit.LKP_TrackerFlexibilityActivity';
	COMMIT TRAN T34;
	BEGIN  TRAN T35;
	EXEC Proc_EDW_TrackerMetadataExtract 'HFit.TrackerStressManagement';
	COMMIT TRAN T35;
	BEGIN  TRAN T36;
	EXEC Proc_EDW_TrackerMetadataExtract 'HFit.TrackerFlexibility';
	COMMIT TRAN T36;
	BEGIN  TRAN T37;
	EXEC Proc_EDW_TrackerMetadataExtract 'HFit.TrackerStress';
	COMMIT TRAN T37;
	BEGIN  TRAN T38;
	EXEC Proc_EDW_TrackerMetadataExtract 'HFit.TrackerCardio';
	COMMIT TRAN T39;
	BEGIN  TRAN T40;
	EXEC Proc_EDW_TrackerMetadataExtract 'HFit.TrackerSitLess';
	COMMIT TRAN T40;
	BEGIN  TRAN T41;
	EXEC Proc_EDW_TrackerMetadataExtract 'HFit.TrackerStrength';
	COMMIT TRAN T41;
	BEGIN  TRAN T42;
	EXEC Proc_EDW_TrackerMetadataExtract 'HFit.LKP_TrackerCardioActivity';
	COMMIT TRAN T42;
	BEGIN  TRAN T43;
	EXEC Proc_EDW_TrackerMetadataExtract 'HFit.TrackerBMI';
	COMMIT TRAN T43;
	BEGIN  TRAN T44;
	EXEC Proc_EDW_TrackerMetadataExtract 'HFit.Ref_RewardTrackerValidation';
	COMMIT TRAN T45;
	BEGIN  TRAN T46;
	EXEC Proc_EDW_TrackerMetadataExtract 'HFit.HFit_TrackerHeight';
	COMMIT TRAN T46;
	BEGIN  TRAN T47;
	EXEC Proc_EDW_TrackerMetadataExtract 'HFit.HFit_TrackerShots';
	COMMIT TRAN T47;
	BEGIN  TRAN T48;
	EXEC Proc_EDW_TrackerMetadataExtract 'HFit.HFit_TrackerTests';
	COMMIT TRAN T48;
	--BEGIN  TRAN T49;
	--EXEC Proc_EDW_TrackerMetadataExtract 'HFit.HealthAssessmentCodeNamesToTrackerMapping';
	--COMMIT TRAN T49;
	BEGIN  TRAN T50;
	EXEC Proc_EDW_TrackerMetadataExtract 'HFit.CustomTrackerInstances';
	COMMIT TRAN T50;
	BEGIN  TRAN T51;
	EXEC Proc_EDW_TrackerMetadataExtract 'HFit.TrackerDailySteps';
	COMMIT TRAN T51;
END

GO



if exists (select * from sysobjects where name = 'Proc_EDW_HealthAssessment' and Xtype = 'P')
BEGIN
	drop procedure Proc_EDW_HealthAssessment ;
END 
go

CREATE procedure [dbo].[Proc_EDW_HealthAssessment] (@StartDate as datetime, @EndDate as datetime, @TrackPerf as nvarchar(1))
--WITH EXECUTE AS OWNER
as

--***********************************************************************************************
--NOTE: This proc is currently set up to enter records into a staging table "EDW_HealthAssessment".
--		It runs in about the same time as the non-staging query, This allows the EDW instant access
--		to the HA records once this proc has completed. No changes would be required to the EDW
--		processing as the column names and ordinals are the same. A job can be set up to run this 
--		procedure on a scheduled basis.

--7/15/2014 17:19 min. 46,750 Rows DEV
--7/15/2014 per Mark Turner:
--	HAModuleDocumentID is on its way out, so is Module, RiskCategory, RiskArea, Question, Answer 
--	all the "DocumentID" fields are deprecated and replaced by corresponding NodeGUID fields
--08/08/2014 - Executed in DEV with GUID changes, new views
--08/08/2014 - Generated corrected view in DEV
--08/08/2014 - 18:06 min. 51,282 Rows DEV
--08/08/2014 - 00:35 sec. 51,282 Rows DEV after conversion to SP (wdm)
--08/08/2014 - 00:35 sec. 51,282 Rows QA after conversion to SP (wdm)
--08/19/2014 - Found this proc missing some of the views created yesterday - recreated the 2 missing views and all works well
--08/29/2014 - 00:35 sec. 51,282 Rows LAB/Prod1 (wdm)
--(52480 row(s) affected)  @EndTime: Sep  2 2014  3:24PM / 1:41 exec time (not using insert into staging table)
--(52480 row(s) affected)  @EndTime: Sep  2 2014  3:24PM / 1:40 exec time (using insert into staging table)
--USE: exec Proc_EDW_HealthAssessment '2014-05-22', '2014-09-23', 'Y'	--This causes between dates to be pulled
--     exec Proc_EDW_HealthAssessment NULL, NULL, 'Y'					--This causes one day's previous data to be pulled

--Auth:	GRANT EXECUTE ON dbo.Proc_EDW_HealthAssessment TO <UserID>;
--Action: This proc creates table EDW_HealthAssessment and a view to access the table view_EDW_HAassessment.
--			Select on the view is granted to PUBLIC. This provides EDW with instant access to data.


-- 09.11.2014 : (wdm) Verified DATES to resolve EDW last mod date issue
--***********************************************************************************************
begin

	--declare @StartDate as datetime ;
	--declare @EndDate as datetime ;
	--declare @TrackPerf as char(1);
	--set @TrackPerf = 'Y' ;
	--set @StartDate = '2001-04-08';
	--set @EndDate = '2015-07-02';

	declare @P0Start as datetime ;
	declare @P0End as datetime ;
	declare @P1Start as datetime ;
	declare @P1End as datetime ;
	
	set @P0Start = getdate() ;
	set @P1Start = getdate() ;
	
--select * from EDW_HealthAssessment	
if exists(select name from sys.tables where name = 'EDW_HealthAssessment')
BEGIN	
	truncate table EDW_HealthAssessment ;
END
ELSE
BEGIN
	CREATE TABLE [dbo].[EDW_HealthAssessment]
	(		
		UserStartedItemID  int,
        HealthAssesmentUserStartedNodeGUID  uniqueidentifier,
        UserID  bigint,
        UserGUID  uniqueidentifier,
        HFitUserMpiNumber  bigint,
        SiteGUID  uniqueidentifier,
        AccountID  int,
        AccountCD  nvarchar (8),
        HAStartedDt  datetime,
        HACompletedDt  datetime,
        UserModuleItemId  int,
        UserModuleCodeName  nvarchar(100),
        HAModuleNodeGUID  uniqueidentifier,
        HAModuleVersionID  int,
        UserRiskCategoryItemID  int,
        UserRiskCategoryCodeName  nvarchar(100),
        HARiskCategoryNodeGUID  uniqueidentifier,
        HARiskCategoryVersionID  int,
        UserRiskAreaItemID  int,
        UserRiskAreaCodeName  nvarchar(100),
        HARiskAreaNodeGUID  uniqueidentifier,
        HARiskAreaVersionID  int,
        UserQuestionItemID  int,
        Title  nvarchar(4000),
        HAQuestionGuid  uniqueidentifier,
        UserQuestionCodeName  nvarchar(100),
        HAQuestionDocumentID  int,
        HAQuestionVersionID  bigint,
        HAQuestionNodeGUID  uniqueidentifier,
        UserAnswerItemID  int,
        HAAnswerNodeGUID  uniqueidentifier,
        HAAnswerVersionID  bigint,
        UserAnswerCodeName  nvarchar(100),
        HAAnswerValue  nvarchar(255),
        HAModuleScore  float,
        HARiskCategoryScore  float,
        HARiskAreaScore  float,
        HAQuestionScore  float,
        HAAnswerPoints  int,
        PointResults  int,
        UOMCode  nvarchar(10),
        HAScore  int,
        ModulePreWeightedScore  float,
        RiskCategoryPreWeightedScore  float,
        RiskAreaPreWeightedScore  float,
        QuestionPreWeightedScore  float,
        QuestionGroupCodeName  nvarchar(100),
        ChangeType  varchar(1)
       
	   ,ItemCreatedWhen datetime
       ,ItemModifiedWhen  datetime
	   ,IsProfessionallyCollected bit
	   ,HARiskCategory_ItemModifiedWhen datetime
	   ,HAUserRiskArea_ItemModifiedWhen datetime
	   ,HAUserQuestion_ItemModifiedWhen datetime
	   ,HAUserAnswers_ItemModifiedWhen datetime
	)
END

declare @SQL as varchar(2000) ;

if not exists(select name from sys.views where name = 'view_EDW_HAassessment')
BEGIN
set @SQL = 
	'create view view_EDW_HAassessment
		as
		SELECT [UserStartedItemID]
			,[HealthAssesmentUserStartedNodeGUID]
			,[UserID]
			,[UserGUID]
			,[HFitUserMpiNumber]
			,[SiteGUID]
			,[AccountID]
			,[AccountCD]
			,[HAStartedDt]
			,[HACompletedDt]
			,[UserModuleItemId]
			,[UserModuleCodeName]
			,[HAModuleNodeGUID]
			,[HAModuleVersionID]
			,[UserRiskCategoryItemID]
			,[UserRiskCategoryCodeName]
			,[HARiskCategoryNodeGUID]
			,[HARiskCategoryVersionID]
			,[UserRiskAreaItemID]
			,[UserRiskAreaCodeName]
			,[HARiskAreaNodeGUID]
			,[HARiskAreaVersionID]
			,[UserQuestionItemID]
			,[Title]
			,[HAQuestionGuid]
			,[UserQuestionCodeName]
			,[HAQuestionDocumentID]
			,[HAQuestionVersionID]
			,[HAQuestionNodeGUID]
			,[UserAnswerItemID]
			,[HAAnswerNodeGUID]
			,[HAAnswerVersionID]
			,[UserAnswerCodeName]
			,[HAAnswerValue]
			,[HAModuleScore]
			,[HARiskCategoryScore]
			,[HARiskAreaScore]
			,[HAQuestionScore]
			,[HAAnswerPoints]
			,[PointResults]
			,[UOMCode]
			,[HAScore]
			,[ModulePreWeightedScore]
			,[RiskCategoryPreWeightedScore]
			,[RiskAreaPreWeightedScore]
			,[QuestionPreWeightedScore]
			,[QuestionGroupCodeName]
			,[ChangeType]
			,ItemCreatedWhen 
			,ItemModifiedWhen  
			,IsProfessionallyCollected 
			,HARiskCategory_ItemModifiedWhen 
			,HAUserRiskArea_ItemModifiedWhen 
			,HAUserQuestion_ItemModifiedWhen 
			,HAUserAnswers_ItemModifiedWhen 
		FROM [dbo].[EDW_HealthAssessment]'; 
			  
	  exec (@SQL) ;

	  GRANT SELECT ON view_EDW_HAassessment TO public;

END

	IF @StartDate is null 
		BEGIN
			--set @StartDate = getdate() - 1 ;
			set @StartDate  =DATEADD(Day, 0, DATEDIFF(Day, 0, GetDate())) -1 ;	--Midnight yesterday;	
			set @StartDate = @StartDate  -1 ;	
		END
		IF @EndDate is null 
		BEGIN
			set @EndDate = getdate();
			--set @StartDate  =DATEADD(Day, 0, DATEDIFF(Day, 0, GetDate())) ;	--Midnight today;		
		END

	INSERT into EDW_HealthAssessment
	([UserStartedItemID]
           ,[HealthAssesmentUserStartedNodeGUID]
           ,[UserID]
           ,[UserGUID]
           ,[HFitUserMpiNumber]
           ,[SiteGUID]
           ,[AccountID]
           ,[AccountCD]
           ,[HAStartedDt]
           ,[HACompletedDt]
           ,[UserModuleItemId]
           ,[UserModuleCodeName]
           ,[HAModuleNodeGUID]
           ,[HAModuleVersionID]
           ,[UserRiskCategoryItemID]
           ,[UserRiskCategoryCodeName]
           ,[HARiskCategoryNodeGUID]
           ,[HARiskCategoryVersionID]
           ,[UserRiskAreaItemID]
           ,[UserRiskAreaCodeName]
           ,[HARiskAreaNodeGUID]
           ,[HARiskAreaVersionID]
           ,[UserQuestionItemID]
           ,[Title]
           ,[HAQuestionGuid]
           ,[UserQuestionCodeName]
           ,[HAQuestionDocumentID]
           ,[HAQuestionVersionID]
           ,[HAQuestionNodeGUID]
           ,[UserAnswerItemID]
           ,[HAAnswerNodeGUID]
           ,[HAAnswerVersionID]
           ,[UserAnswerCodeName]
           ,[HAAnswerValue]
           ,[HAModuleScore]
           ,[HARiskCategoryScore]
           ,[HARiskAreaScore]
           ,[HAQuestionScore]
           ,[HAAnswerPoints]
           ,[PointResults]
           ,[UOMCode]
           ,[HAScore]
           ,[ModulePreWeightedScore]
           ,[RiskCategoryPreWeightedScore]
           ,[RiskAreaPreWeightedScore]
           ,[QuestionPreWeightedScore]
           ,[QuestionGroupCodeName]
           ,[ChangeType]
           ,ItemCreatedWhen
		   ,ItemModifiedWhen
		   ,IsProfessionallyCollected
		   ,HARiskCategory_ItemModifiedWhen
		   ,HAUserRiskArea_ItemModifiedWhen
		   ,HAUserQuestion_ItemModifiedWhen
		   ,HAUserAnswers_ItemModifiedWhen)
	
	SELECT  
				HAUserStarted.ItemID AS UserStartedItemID		
				, HAUserStarted.HALastQuestionNodeGUID as  HealthAssesmentUserStartedNodeGUID		--WDM 8/7/2014  as HADocumentID
				, HAUserStarted.UserID
				, CMSUser.UserGUID
				, UserSettings.HFitUserMpiNumber
				, CMSSite.SiteGUID
				, ACCT.AccountID
				, ACCT.AccountCD
				, HAUserStarted.HAStartedDt
				, HAUserStarted.HACompletedDt
				, HAUserModule.ItemID AS UserModuleItemId
				, HAUserModule.CodeName AS UserModuleCodeName
				, HAUserModule.HAModuleNodeGUID							--WDM 8/7/2014 as HAModuleDocumentID
				, NULL as HAModuleVersionID
				, HARiskCategory.ItemID AS UserRiskCategoryItemID
				, HARiskCategory.CodeName AS UserRiskCategoryCodeName
				, HARiskCategory.HARiskCategoryNodeGUID						--WDM 8/7/2014 as HARiskCategoryDocumentID
				, NULL as HARiskCategoryVersionID
				, HAUserRiskArea.ItemID AS UserRiskAreaItemID
				, HAUserRiskArea.CodeName AS UserRiskAreaCodeName
				, HAUserRiskArea.HARiskAreaNodeGUID								--WDM 8/7/2014 as HARiskAreaDocumentID
				, NULL as HARiskAreaVersionID
				, HAUserQuestion.ItemID AS UserQuestionItemID
				, HAQuestionsView.Title
				, HAUserQuestion.HAQuestionNodeGUID	as HAQuestionGuid			--WDM 9.2.2014
				, HAUserQuestion.CodeName AS UserQuestionCodeName
				, HAUserQuestion.HAQuestionDocumentID_old as HAQuestionDocumentID	--WDM 9.2.2014
		
				, HAUserQuestion.HAQuestionVersionID_old as HAQuestionVersionID		
		
				, HAUserQuestion.HAQuestionNodeGUID		
						
				, HAUserAnswers.ItemID AS UserAnswerItemID
				, HAUserAnswers.HAAnswerNodeGUID								--WDM 8/7/2014 as HAAnswerDocumentID

				, HAUserAnswers.HAAnswerVersionID_old as HAAnswerVersionID		--WDM 9.2.2014
				, HAUserAnswers.CodeName AS UserAnswerCodeName
				, HAUserAnswers.HAAnswerValue
				, HAUserModule.HAModuleScore
				, HARiskCategory.HARiskCategoryScore
				, HAUserRiskArea.HARiskAreaScore
				, HAUserQuestion.HAQuestionScore
				, HAUserAnswers.HAAnswerPoints
				, HAUserQuestionGroupResults.PointResults
				, HAUserAnswers.UOMCode
				, HAUserStarted.HAScore
				, HAUserModule.PreWeightedScore AS ModulePreWeightedScore
				, HARiskCategory.PreWeightedScore AS RiskCategoryPreWeightedScore
				, HAUserRiskArea.PreWeightedScore AS RiskAreaPreWeightedScore
				, HAUserQuestion.PreWeightedScore AS QuestionPreWeightedScore
				, HAUserQuestionGroupResults.CodeName AS QuestionGroupCodeName       
			   ,CASE WHEN HAUserAnswers.ItemCreatedWhen = HAUserAnswers.ItemModifiedWhen THEN 'I'
					 ELSE 'U'
				END AS ChangeType
				,HAUserAnswers.ItemCreatedWhen
				,HAUserAnswers.ItemModifiedWhen
				,HAUserQuestion.IsProfessionallyCollected

				,HARiskCategory.ItemModifiedWhen as HARiskCategory_ItemModifiedWhen
				,HAUserRiskArea.ItemModifiedWhen as HAUserRiskArea_ItemModifiedWhen
				,HAUserQuestion.ItemModifiedWhen as HAUserQuestion_ItemModifiedWhen
				,HAUserAnswers.ItemModifiedWhen as HAUserAnswers_ItemModifiedWhen

			FROM
			dbo.HFit_HealthAssesmentUserStarted AS HAUserStarted
			INNER JOIN dbo.CMS_User AS CMSUser ON HAUserStarted.UserID = CMSUser.UserID
			INNER JOIN dbo.CMS_UserSettings AS UserSettings ON UserSettings.UserSettingsUserID = CMSUser.UserID
			INNER JOIN dbo.CMS_UserSite AS UserSite ON CMSUser.UserID = UserSite.UserID
			INNER JOIN dbo.CMS_Site AS CMSSite ON UserSite.SiteID = CMSSite.SiteID
			INNER JOIN dbo.HFit_Account AS ACCT ON ACCT.SiteID = CMSSite.SiteID
	
			--The following JOIN can be put back in place once the DEV columns are added to the TABLES and SYNC'D
			--AND THE second JOIN can be removed.
			INNER JOIN dbo.HFit_HealthAssesmentUserModule AS HAUserModule ON HAUserStarted.ItemID = HAUserModule.HAStartedItemID
			--INNER JOIN dbo.view_EDW_HFit_HealthAssesmentUserModule AS HAUserModule ON HAUserStarted.ItemID = HAUserModule.HAStartedItemID

			--The following JOIN can be put back in place once the DEV columns are added to the TABLES and SYNC'D
			--AND THE second JOIN can be removed.
			INNER JOIN dbo.HFit_HealthAssesmentUserRiskCategory AS HARiskCategory ON HAUserModule.ItemID = HARiskCategory.HAModuleItemID
			--INNER JOIN dbo.view_EDW_HFit_HealthAssesmentUserRiskCategory AS HARiskCategory ON HAUserModule.ItemID = HARiskCategory.HAModuleItemID

			--The following JOIN can be put back in place once the DEV columns are added to the TABLES and SYNC'D
			--AND THE second JOIN can be removed.
			INNER JOIN dbo.HFit_HealthAssesmentUserRiskArea AS HAUserRiskArea ON HARiskCategory.ItemID = HAUserRiskArea.HARiskCategoryItemID
			--INNER JOIN dbo.view_EDW_HFit_HealthAssesmentUserRiskArea AS HAUserRiskArea ON HARiskCategory.ItemID = HAUserRiskArea.HARiskCategoryItemID
	
			--The following JOIN can be put back in place once the DEV columns are added to the TABLES and SYNC'D
			--AND THE second JOIN can be removed.
			INNER JOIN dbo.HFit_HealthAssesmentUserQuestion AS HAUserQuestion ON HAUserRiskArea.ItemID = HAUserQuestion.HARiskAreaItemID
			--INNER JOIN dbo.view_EDW_HFit_HealthAssesmentUserQuestion AS HAUserQuestion ON HAUserRiskArea.ItemID = HAUserQuestion.HARiskAreaItemID

			--The following JOIN can be put back in place once the DEV columns are added to the TABLES and SYNC'D
			--AND THE second JOIN can be removed.
			INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS HAQuestionsView ON HAUserQuestion.HAQuestionNodeGUID = HAQuestionsView.NodeGUID
			--INNER JOIN dbo.view_EDW_HFit_HealthAssesmentUserQuestion AS HAQuestionsView ON HAUserQuestion.HAQuestionNodeGUID = HAQuestionsView.NodeGUID

			LEFT OUTER JOIN dbo.HFit_HealthAssesmentUserQuestionGroupResults AS HAUserQuestionGroupResults ON HAUserQuestion.ItemID = HAUserQuestionGroupResults.HARiskAreaItemID
			INNER JOIN dbo.HFit_HealthAssesmentUserAnswers AS HAUserAnswers ON HAUserQuestion.ItemID = HAUserAnswers.HAQuestionItemID


		WHERE HAUserAnswers.ItemModifiedWhen BETWEEN @StartDate AND @EndDate
		
if @TrackPerf is not null 
BEGIN
	set @P1End = getdate() ;
	exec proc_EDW_MeasurePerf 'ElapsedTime','HealthAssessment-P1',0, @P1Start, @P1End;
	print ('Perf Details Recorded') ;
END
ELSE
	print ('No Perf Details Requested') ;
	
END	--END of PROC



GO



if exists (select * from sysobjects where name = 'Proc_EDW_HealthAssessmentDefinition' and Xtype = 'P')
BEGIN
	drop procedure Proc_EDW_HealthAssessmentDefinition ;
END 
go

create proc [dbo].[Proc_EDW_HealthAssessmentDefinition] (@StartDate as datetime, @EndDate as datetime, @TrackPerf as nvarchar(1))
as
BEGIN
--*********************************************************************************************************************
--Action: This proc creates table EDW_HealthAssessmentDefinition and a view to access the table view_EDW_HADefinition.
--			Select on the view is granted to PUBLIC. This provides EDW with instant access to data.
--		Creates a staging table EDW_HealthAssessmentDefinition.
--USE:	exec Proc_EDW_HealthAssessmentDefinition NULL, NULL
--		exec Proc_EDW_HealthAssessmentDefinition '2013-11-14', '2013-11-15', 'Y'
--exec Proc_EDW_HealthAssessmentDefinition NULL, NULL, 'Y'
--exec Proc_EDW_HealthAssessmentDefinition '2010-11-14', '2014-11-15', 'Y'
--exec Proc_EDW_HealthAssessmentDefinition '2014-06-10', '2014-08-30', NULL
--*********************************************************************************************************************
--exec Proc_EDW_HealthAssessmentDefinition '2010-11-14', '2014-11-15', 'Y'
--08/12/2014 - ProdStaging 00:00:12 @ 2442
--*********************************************************************************************************************

--USE: exec Proc_EDW_HealthAssessmentDefinition '2001-04-08', '2015-07-02'	--This causes one between dates to be pulled
--     exec Proc_EDW_HealthAssessmentDefinition NULL, NULL					--This causes one day's previous data to be pulled
--Auth:	GRANT EXECUTE ON dbo.Proc_EDW_HealthAssessmentDefinition TO <UserID>;


-- ----FOR DEBUG PURPOSES, UNCOMMENT
--declare @TrackPerf as nvarchar(1);
--declare @StartDate as datetime;
--declare @EndDate as datetime;
--set @StartDate = '2010-11-14';
--set @EndDate = '2014-11-15';
----set @StartDate = NULL ;
----set @EndDate = NULL ;
--set @TrackPerf = 'Y' ;

if exists(select name from sys.tables where name = 'EDW_HealthAssessmentDefinition')
BEGIN	
	truncate table EDW_HealthAssessmentDefinition ;
END
ELSE
BEGIN
	CREATE TABLE [dbo].[EDW_HealthAssessmentDefinition](
		[SiteGuid] [int] NULL,
		[AccountCD] [int] NULL,
		[HANodeID] [int] NOT NULL,
		[HANodeName] [nvarchar](100) NOT NULL,
		[HADocumentID] [int] NOT NULL,
		[HANodeSiteID] [int] NOT NULL,
		[HADocPubVerID] [int] NULL,
		[ModTitle] [nvarchar](150) NOT NULL,
		[IntroText] [varchar](4000) NULL,
		[ModDocGuid] [uniqueidentifier] NULL,
		[ModWeight] [int] NOT NULL,
		[ModIsEnabled] [bit] NOT NULL,
		[ModCodeName] [nvarchar](100) NOT NULL,
		[ModDocPubVerID] [int] NULL,
		[RCTitle] [nvarchar](150) NOT NULL,
		[RCWeight] [int] NOT NULL,
		[RCDocumentGUID] [uniqueidentifier] NULL,
		[RCIsEnabled] [bit] NOT NULL,
		[RCCodeName] [nvarchar](100) NOT NULL,
		[RCDocPubVerID] [int] NULL,
		[RATytle] [nvarchar](150) NOT NULL,
		[RAWeight] [int] NOT NULL,
		[RADocumentGuid] [uniqueidentifier] NULL,
		[RAIsEnabled] [bit] NOT NULL,
		[RACodeName] [nvarchar](100) NOT NULL,
		[RAScoringStrategyID] [int] NOT NULL,
		[RADocPubVerID] [int] NULL,
		[QuestionType] [nvarchar](100) NOT NULL,
		[QuesTitle] [varchar](max) NULL,
		[QuesWeight] [int] NOT NULL,
		[QuesIsRequired] [bit] NOT NULL,
		[QuesDocumentGuid] [uniqueidentifier] NULL,
		[QuesIsEnabled] [bit] NOT NULL,
		[QuesIsVisible] [nvarchar](max) NULL,
		[QuesIsSTaging] [bit] NOT NULL,
		[QuestionCodeName] [nvarchar](100) NOT NULL,
		[QuesDocPubVerID] [int] NULL,
		[AnsValue] [nvarchar](150) NULL,
		[AnsPoints] [int] NULL,
		[AnsDocumentGuid] [uniqueidentifier] NULL,
		[AnsIsEnabled] [bit] NULL,
		[AnsCodeName] [nvarchar](100) NULL,
		[AnsUOM] [nvarchar](5) NULL,
		[AnsDocPUbVerID] [int] NULL,
		[ChangeType] [varchar](1) NOT NULL,
		[DocumentCreatedWhen] [datetime] NULL,
		[DocumentModifiedWhen] [datetime] NULL,
		[CmsTreeNodeGuid] [uniqueidentifier] NOT NULL,
		[HANodeGUID] [uniqueidentifier] NOT NULL
	)
END

declare @SQL as varchar(2000) ;

if not exists(select name from sys.views where name = 'view_EDW_HADefinition')
BEGIN
set @SQL = 
	'create view [view_EDW_HADefinition]
	as
	SELECT [SiteGuid]
		  ,[AccountCD]
		  ,[HANodeID]
		  ,[HANodeName]
		  ,[HADocumentID]
		  ,[HANodeSiteID]
		  ,[HADocPubVerID]
		  ,[ModTitle]
		  ,[IntroText]
		  ,[ModDocGuid]
		  ,[ModWeight]
		  ,[ModIsEnabled]
		  ,[ModCodeName]
		  ,[ModDocPubVerID]
		  ,[RCTitle]
		  ,[RCWeight]
		  ,[RCDocumentGUID]
		  ,[RCIsEnabled]
		  ,[RCCodeName]
		  ,[RCDocPubVerID]
		  ,[RATytle]
		  ,[RAWeight]
		  ,[RADocumentGuid]
		  ,[RAIsEnabled]
		  ,[RACodeName]
		  ,[RAScoringStrategyID]
		  ,[RADocPubVerID]
		  ,[QuestionType]
		  ,[QuesTitle]
		  ,[QuesWeight]
		  ,[QuesIsRequired]
		  ,[QuesDocumentGuid]
		  ,[QuesIsEnabled]
		  ,[QuesIsVisible]
		  ,[QuesIsSTaging]
		  ,[QuestionCodeName]
		  ,[QuesDocPubVerID]
		  ,[AnsValue]
		  ,[AnsPoints]
		  ,[AnsDocumentGuid]
		  ,[AnsIsEnabled]
		  ,[AnsCodeName]
		  ,[AnsUOM]
		  ,[AnsDocPUbVerID]
		  ,[ChangeType]
		  ,[DocumentCreatedWhen]
		  ,[DocumentModifiedWhen]
		  ,[CmsTreeNodeGuid]
		  ,[HANodeGUID]
	  FROM [dbo].[EDW_HealthAssessmentDefinition]' ; 
	  exec (@SQL) ;

	  GRANT SELECT ON view_EDW_HADefinition TO public;

END

declare @P0Start as datetime ;
declare @P0End as datetime ;
declare @P1Start as datetime ;
declare @P1End as datetime ;
declare @P2Start as datetime ;
declare @P2End as datetime ;
declare @P3Start as datetime ;
declare @P3End as datetime ;
declare @P4Start as datetime ;
declare @P4End as datetime ;
declare @P5Start as datetime ;
declare @P5End as datetime ;
declare @P6Start as datetime ;
declare @P6End as datetime ;
declare @P7Start as datetime ;
declare @P7End as datetime ;
declare @P8Start as datetime ;
declare @P8End as datetime ;

set @P0Start = getdate() ;

	IF @StartDate is null 
	BEGIN
		set @StartDate  =DATEADD(Day, 0, DATEDIFF(Day, 0, GetDate()));	--Midnight yesterday;	
		set @StartDate = @StartDate  -1 ;
	END
	
	IF @EndDate is null 
	BEGIN
		set @EndDate = cast (getdate() as date);
	END
	print ('Start Date: ' + cast(@StartDate as nvarchar(50)))
	print ('End Date: ' + cast(@EndDate as nvarchar(50))) 
	/****************************************************************************************/
	--Build the temporary tables. This should take under 10 seconds as a general rule.
	/****************************************************************************************/
	IF EXISTS
		(
			SELECT name
			FROM tempdb.dbo.sysobjects
			WHERE ID = OBJECT_ID(N'tempdb..#Temp_View_HFit_HealthAssessment_Joined')
		)
	BEGIN
		drop table #Temp_View_HFit_HealthAssessment_Joined ;
	END
	--GO
	select DocumentGUID, NodeGuid, NodeID, DocumentID, NodeName, NodeSiteID, DocumentPublishedVersionHistoryID
	into #Temp_View_HFit_HealthAssessment_Joined 
	from View_HFit_HealthAssessment_Joined 
	where View_HFit_HealthAssessment_Joined .DocumentCulture = 'en-us' ;
	--GO

	create clustered index PI_Temp_View_HFit_HealthAssessment_Joined on #Temp_View_HFit_HealthAssessment_Joined 
	(
	DocumentGUID, NodeGuid
	)
	--GO 

	IF EXISTS
		(
			SELECT name
			FROM tempdb.dbo.sysobjects
			WHERE ID = OBJECT_ID(N'tempdb..#Temp_View_HFit_HACampaign_Joined')
		)
	BEGIN
		drop table #Temp_View_HFit_HACampaign_Joined ;
	END
	--GO
	select DISTINCT NodeParentID, HealthAssessmentID
	into #Temp_View_HFit_HACampaign_Joined
	from 
	View_HFit_HACampaign_Joined
	--GO

	CREATE CLUSTERED INDEX [PI_Temp_View_HFit_HACampaign_Joined] ON #Temp_View_HFit_HACampaign_Joined 
	(
	[NodeParentID] ASC,
	HealthAssessmentID )
	--GO

	IF EXISTS
		(
			SELECT name
			FROM tempdb.dbo.sysobjects
			WHERE ID = OBJECT_ID(N'tempdb..#Temp_View_CMS_Tree_Joined')
		)
	BEGIN
		drop table #Temp_View_CMS_Tree_Joined ;
	END
	--GO
		SELECT DISTINCT
			VCTJ.NodeGuid
			, VCTJ.NodeID
			, VCTJ.NodeName
			, VCTJ.DocumentGUID
			, VCTJ.NodeSiteID 
			, VCTJ.DocumentPublishedVersionHistoryID
			, CASE	WHEN CAST(VCTJ.DocumentCreatedWhen AS DATE) = CAST(vctj.DocumentModifiedWhen AS DATE)
					THEN 'I'
					ELSE 'U'
				END AS ChangeType
			, VCTJ.DocumentCreatedWhen
			, VCTJ.DocumentModifiedWhen
			, VCTJ.DocumentCulture
		INTO #Temp_View_CMS_Tree_Joined
		FROM
		View_CMS_Tree_Joined AS VCTJ
		--where VCTJ.DocumentCulture = 'en-us'

		--GO 
		CREATE CLUSTERED INDEX PI_Temp_View_CMS_Tree_Joined
		ON [dbo].#Temp_View_CMS_Tree_Joined (
			[NodeID], 
			NodeSiteID,
			[NodeName],
			[DocumentGUID], 
			[DocumentPublishedVersionHistoryID],
			[DocumentCreatedWhen],
			[DocumentModifiedWhen]
		)
		--GO 

	IF EXISTS
		(
			SELECT name
			FROM tempdb.dbo.sysobjects
			WHERE ID = OBJECT_ID(N'tempdb..#Temp_View_HFit_HealthAssesmentModule_Joined')
		)
	BEGIN
		drop table #Temp_View_HFit_HealthAssesmentModule_Joined ;
	END
		--GO
		SELECT 
			VHFHAMJ.Title AS ModTitle
			, dbo.udf_StripHTML(left(VHFHAMJ.IntroText,4000)) AS IntroText
			, VHFHAMJ.DocumentGUID
			, VHFHAMJ.Weight
			, VHFHAMJ.IsEnabled
			, VHFHAMJ.CodeName AS ModCodeName
			, VHFHAMJ.DocumentPublishedVersionHistoryID AS ModDocPubVerID
			, VHFHAMJ.NodeParentID
			, VHFHAMJ.DocumentNodeID
			, VHFHAMJ.Title
			, VHFHAMJ.CodeName
			, VHFHAMJ.DocumentPublishedVersionHistoryID
			,VHFHAMJ.DocumentCulture
		INTO #Temp_View_HFit_HealthAssesmentModule_Joined
		FROM
		View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ
		--where VHFHAMJ.DocumentCulture = 'en-us'
		--GO
		Create clustered index PI_Temp_View_HFit_HealthAssesmentModule_Joined on #Temp_View_HFit_HealthAssesmentModule_Joined
		(
			NodeParentID, DocumentNodeID	,
			DocumentGUID, 
			Weight, 
			IsEnabled, 
			Title, 
			CodeName, 
			DocumentPublishedVersionHistoryID	
		)
		--GO
 
	 IF EXISTS
		(
			SELECT name
			FROM tempdb.dbo.sysobjects
			WHERE ID = OBJECT_ID(N'tempdb..#Temp_View_HFit_HealthAssesmentRiskCategory_Joined')
		)
	BEGIN
		drop table #Temp_View_HFit_HealthAssesmentRiskCategory_Joined ;
	END

	 --GO
		SELECT VHFHARCJ.Title
			, VHFHARCJ.Weight
			, VHFHARCJ.DocumentGUID
			, VHFHARCJ.IsEnabled
			, VHFHARCJ.CodeName
			, VHFHARCJ.DocumentPublishedVersionHistoryID
			, VHFHARCJ.NodeParentID
			, VHFHARCJ.DocumentNodeID
			, VHFHARCJ.DocumentCulture
		INTO #Temp_View_HFit_HealthAssesmentRiskCategory_Joined
		FROM
		View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ
		--where VHFHARCJ.DocumentCulture = 'en-us'	
		--GO

		create clustered index PI_Temp_View_HFit_HealthAssesmentRiskCategory_Joined on #Temp_View_HFit_HealthAssesmentRiskCategory_Joined
		(
			NodeParentID, DocumentGUID, DocumentNodeID
		)

	
	IF EXISTS
		(
			SELECT name
			FROM tempdb.dbo.sysobjects
			WHERE ID = OBJECT_ID(N'tempdb..#Temp_View_HFit_HealthAssesmentRiskArea_Joined')
		)
	BEGIN
		drop table #Temp_View_HFit_HealthAssesmentRiskArea_Joined ;
	END

		--GO
		SELECT 
			VHFHARAJ.Title
			, VHFHARAJ.Weight 
			, VHFHARAJ.DocumentGUID
			, VHFHARAJ.IsEnabled
			, VHFHARAJ.CodeName
			, VHFHARAJ.ScoringStrategyID
			, VHFHARAJ.DocumentPublishedVersionHistoryID
			, VHFHARAJ.NodeParentID
			, VHFHARAJ.DocumentNodeID
			, VHFHARAJ.DocumentCulture
		INTO #Temp_View_HFit_HealthAssesmentRiskArea_Joined
		FROM
		View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ
		--where VHFHARAJ.DocumentCulture = 'en-us'
 
	 --GO
	 Create clustered index PI_Temp_View_HFit_HealthAssesmentRiskArea_Joined on #Temp_View_HFit_HealthAssesmentRiskArea_Joined
	 (
		DocumentNodeID, NodeParentID, DocumentGUID
	 )
  	
	IF EXISTS
		(
			SELECT name
			FROM tempdb.dbo.sysobjects
			WHERE ID = OBJECT_ID(N'tempdb..#Temp_View_EDW_HealthAssesmentQuestions')
		)
	BEGIN
		drop table #Temp_View_EDW_HealthAssesmentQuestions ;
	END

	 --GO
	 SELECT 
			VHFHAQ.QuestionType
			, dbo.udf_StripHTML(left(VHFHAQ.Title,4000)) AS Title
			, VHFHAQ.[Weight]
			, VHFHAQ.IsRequired
			, VHFHAQ.DocumentGUID
			, VHFHAQ.IsEnabled
			--, VHFHAQ.IsVisible
			, left(VHFHAQ.IsVisible,4000) AS IsVisible
			, VHFHAQ.IsStaging
			, VHFHAQ.CodeName
			, VHFHAQ.DocumentPublishedVersionHistoryID
			, VHFHAQ.NodeParentID
			, VHFHAQ.NodeGuid
			, VHFHAQ.NodeID
			, VHFHAQ.DocumentCulture
		INTO #Temp_View_EDW_HealthAssesmentQuestions
		FROM
		View_EDW_HealthAssesmentQuestions AS VHFHAQ
		--where VHFHAQ.DocumentCulture = 'en-us'

		--GO
		Create clustered index  PI_Temp_View_HFit_HealthAssesmentQuestions on #Temp_View_EDW_HealthAssesmentQuestions
		(
			NodeGuid, NodeParentID
		)

		--GO
	IF EXISTS
		(
			SELECT name
			FROM tempdb.dbo.sysobjects
			WHERE ID = OBJECT_ID(N'tempdb..#Temp_View_EDW_HealthAssesmentAnswers')
		)
	BEGIN
		drop table #Temp_View_EDW_HealthAssesmentAnswers ;
	END

		--GO
		SELECT 
			VHFHAA.Value
			, VHFHAA.Points
			, VHFHAA.DocumentGUID
			, VHFHAA.IsEnabled 
			, VHFHAA.CodeName 
			, VHFHAA.UOM 
			, VHFHAA.DocumentPublishedVersionHistoryID 
			, VHFHAA.NodeParentID
			, VHFHAA.NodeGuid
			, VHFHAA.NodeID
			, VHFHAA.DocumentCulture
		INTO #Temp_View_EDW_HealthAssesmentAnswers
		FROM
		View_EDW_HealthAssesmentAnswers AS VHFHAA 
		--where VHFHAA.DocumentCulture = 'en-us'
		--GO 

		create clustered index PI_Temp_View_HFit_HealthAssesmentAnswers on #Temp_View_EDW_HealthAssesmentAnswers
		(
			NodeParentID, DocumentGUID, DocumentPublishedVersionHistoryID,
			Value, Points, IsEnabled, CodeName, UOM
		)

	--GO  

	IF NOT EXISTS
	(
		SELECT name
		FROM sys.indexes
		WHERE name = N'PI04_View_CMS_Tree_Joined_Linked'
	)
	BEGIN
		CREATE NONCLUSTERED INDEX PI04_View_CMS_Tree_Joined_Linked
		ON [dbo].[View_CMS_Tree_Joined_Linked] ([ClassName])
		INCLUDE ([NodeParentID],[DocumentGUID],[DocumentForeignKeyValue],[DocumentPublishedVersionHistoryID],[DocumentNodeID])
		--GO 
	END

	IF NOT EXISTS
	(
		SELECT name
		FROM sys.indexes
		WHERE name = N'PI_Temp_View_HFit_HealthAssesmentModule_Joined'
	)
	BEGIN
		drop index #Temp_View_HFit_HealthAssesmentModule_Joined.PI_Temp_View_HFit_HealthAssesmentModule_Joined ;
	END
	IF NOT EXISTS
	(
		SELECT name
		FROM sys.indexes
		WHERE name = N'PI_Temp_View_HFit_HealthAssesmentModule_Joined'
	)
	BEGIN
		create clustered index PI_Temp_View_HFit_HealthAssesmentModule_Joined 
		on #Temp_View_HFit_HealthAssesmentModule_Joined
		(
			DocumentGUID, 
			Weight, 
			IsEnabled, 
			Title, 
			CodeName, 
			DocumentPublishedVersionHistoryID	
		)
	END

	IF NOT EXISTS
		(
			SELECT name
			FROM sys.indexes
			WHERE name = N'PI01_HFit_Account'
		)
	BEGIN
			CREATE index PI01_HFit_Account on HFit_Account
			(
				SiteID
			)
	END

	IF NOT EXISTS
		(
			SELECT name
			FROM sys.indexes
			where name = N'CI01_View_CMS_Tree_Joined_Linked'
		)
	BEGIN
		CREATE NONCLUSTERED INDEX [CI01_View_CMS_Tree_Joined_Linked]
		ON [dbo].[View_CMS_Tree_Joined_Linked] 
		([ClassName]) INCLUDE ([NodeGuid],[DocumentGUID],[DocumentForeignKeyValue])
	END
	--GO 

if @TrackPerf is not null 
BEGIN
	set @P0End = getdate() ;
	exec proc_EDW_MeasurePerf 'ElapsedTime','HADef-P0',0, @P0Start, @P0End;
END

set @P1Start = getdate() ;


	/****************************************************************************************/
	--Begin the view using the TEMP tables
	/****************************************************************************************/

insert into EDW_HealthAssessmentDefinition
	(
	[SiteGuid],
		[AccountCD],
		[HANodeID],
		[HANodeName],
		[HADocumentID],
		[HANodeSiteID],
		[HADocPubVerID],
		[ModTitle],
		[IntroText],
		[ModDocGuid],
		[ModWeight],
		[ModIsEnabled],
		[ModCodeName],
		[ModDocPubVerID],
		[RCTitle],
		[RCWeight],
		[RCDocumentGUID],
		[RCIsEnabled],
		[RCCodeName],
		[RCDocPubVerID],
		[RATytle],
		[RAWeight],
		[RADocumentGuid],
		[RAIsEnabled],
		[RACodeName],
		[RAScoringStrategyID],
		[RADocPubVerID],
		[QuestionType],
		[QuesTitle],
		[QuesWeight],
		[QuesIsRequired],
		[QuesDocumentGuid],
		[QuesIsEnabled],
		[QuesIsVisible],
		[QuesIsSTaging],
		[QuestionCodeName],
		[QuesDocPubVerID],
		[AnsValue],
		[AnsPoints],
		[AnsDocumentGuid],
		[AnsIsEnabled],
		[AnsCodeName],
		[AnsUOM],
		[AnsDocPUbVerID],
		[ChangeType],
		[DocumentCreatedWhen],
		[DocumentModifiedWhen],
		[CmsTreeNodeGuid],
		[HANodeGUID]
	)

		SELECT Distinct 
		NULL as SiteGuid --cs.SiteGUID		--WDM 08.07.2014 per conversation with John Croft
		, NULL as AccountCD     --, HFA.AccountCD		--WDM 08.07.2014 per conversation with John Croft
		, HA.NodeID AS HANodeID		--WDM 08.07.2014
		, HA.NodeName AS HANodeName		--WDM 08.07.2014
		, HA.DocumentID AS HADocumentID		--WDM 08.07.2014
		, HA.NodeSiteID AS HANodeSiteID		--WDM 08.07.2014
		, HA.DocumentPublishedVersionHistoryID AS HADocPubVerID		--WDM 08.07.2014
		, VHFHAMJ.Title AS ModTitle
		--Per EDW Team, HTML text is truncated to 4000 bytes - we'll just do it here
		--, dbo.udf_StripHTML(left(left(VHFHAMJ.IntroText,4000),4000)) AS IntroText
		, VHFHAMJ.IntroText 
		, VHFHAMJ.DocumentGuid AS ModDocGuid	--, VHFHAMJ.DocumentID AS ModDocID	--WDM 08.07.2014
		, VHFHAMJ.Weight AS ModWeight
		, VHFHAMJ.IsEnabled AS ModIsEnabled
		, VHFHAMJ.CodeName AS ModCodeName
		, VHFHAMJ.DocumentPublishedVersionHistoryID AS ModDocPubVerID
		, VHFHARCJ.Title AS RCTitle
		, VHFHARCJ.Weight AS RCWeight
		, VHFHARCJ.DocumentGuid AS RCDocumentGUID	--, VHFHARCJ.DocumentID AS RCDocumentID	--WDM 08.07.2014
		, VHFHARCJ.IsEnabled AS RCIsEnabled
		, VHFHARCJ.CodeName AS RCCodeName
		, VHFHARCJ.DocumentPublishedVersionHistoryID AS RCDocPubVerID
		, VHFHARAJ.Title AS RATytle
		, VHFHARAJ.Weight AS RAWeight
		, VHFHARAJ.DocumentGuid AS RADocumentGuid	--, VHFHARAJ.DocumentID AS RADocumentID	--WDM 08.07.2014
		, VHFHARAJ.IsEnabled AS RAIsEnabled
		, VHFHARAJ.CodeName AS RACodeName
		, VHFHARAJ.ScoringStrategyID AS RAScoringStrategyID
		, VHFHARAJ.DocumentPublishedVersionHistoryID AS RADocPubVerID
		, VHFHAQ.QuestionType
		--, dbo.udf_StripHTML(left(VHFHAQ.Title,4000)) AS QuesTitle
		, VHFHAQ.Title AS QuesTitle
		, VHFHAQ.Weight AS QuesWeight
		, VHFHAQ.IsRequired AS QuesIsRequired

		, VHFHAQ.DocumentGuid AS QuesDocumentGuid	--, VHFHAQ.DocumentID AS QuesDocumentID	--WDM 08.07.2014
		
		, VHFHAQ.IsEnabled AS QuesIsEnabled
		, left(VHFHAQ.IsVisible,4000) AS QuesIsVisible
		, VHFHAQ.IsStaging AS QuesIsSTaging
		, VHFHAQ.CodeName AS QuestionCodeName
		, VHFHAQ.DocumentPublishedVersionHistoryID AS QuesDocPubVerID
		, VHFHAA.Value AS AnsValue
		, VHFHAA.Points AS AnsPoints
		
		, VHFHAA.DocumentGuid AS AnsDocumentGuid	--, VHFHAA.DocumentID AS AnsDocumentID	--WDM 08.07.2014
		
		, VHFHAA.IsEnabled AS AnsIsEnabled
		, VHFHAA.CodeName AS AnsCodeName
		, VHFHAA.UOM AS AnsUOM
		, VHFHAA.DocumentPublishedVersionHistoryID AS AnsDocPUbVerID
		, CASE	WHEN CAST(VCTJ.DocumentCreatedWhen AS DATE) = CAST(vctj.DocumentModifiedWhen AS DATE)
			THEN 'I'
			ELSE 'U'
		END AS ChangeType
		, VCTJ.DocumentCreatedWhen
		, VCTJ.DocumentModifiedWhen
		, VCTJ.NodeGuid as CmsTreeNodeGuid	--WDM 08.07.2014 ADDED TO the returned Columns
		, HA.NodeGUID as HANodeGUID
	 FROM
		dbo.#Temp_View_CMS_Tree_Joined AS VCTJ
		INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
		INNER JOIN HFit_Account hfa WITH(NOLOCK) ON cs.SiteID = hfa.SiteID
 
		--Campaign links Client which links to Assessment
		INNER JOIN dbo.#Temp_View_HFit_HACampaign_Joined as c WITH(NOLOCK) ON VCTJ.NodeID = c.NodeParentID
 
		INNER JOIN #Temp_View_HFit_HealthAssessment_Joined as HA WITH (NOLOCK) ON c.HealthAssessmentID = HA.DocumentID
		--WDM 08.07.2014
		INNER JOIN dbo.#Temp_View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ ON HA.NodeID = VHFHAMJ.NodeParentID		
		INNER JOIN dbo.#Temp_View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
		INNER JOIN dbo.#Temp_View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
		INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentQuestions AS VHFHAQ ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
		LEFT OUTER JOIN dbo.#Temp_View_EDW_HealthAssesmentAnswers AS VHFHAA ON VHFHAQ.NodeID = VHFHAA.NodeParentID
	where VCTJ.DocumentCulture = 'en-us'	--WDM 08.07.2014
		and VHFHAQ.DocumentCulture = 'en-us'	--WDM 08.12.2014	
		and (VHFHAA.DocumentCulture = 'en-us' OR VHFHAA.DocumentCulture is null)	--WDM 08.12.2014		
		and VHFHARCJ.DocumentCulture = 'en-us'	--WDM 08.12.2014		
		and VHFHARAJ.DocumentCulture = 'en-us'	--WDM 08.12.2014	
		and VHFHAMJ.DocumentCulture = 'en-us'	--WDM 08.12.2014		
		AND (VCTJ.DocumentCreatedWhen between @StartDate and @EndDate OR VCTJ.DocumentModifiedWhen between @StartDate and @EndDate)

UNION ALL
--WDM Retrieve Matrix Level 1 Question Group
	SELECT Distinct
		NULL as SiteGuid --cs.SiteGUID
		, NULL as AccountCD     --, HFA.AccountCD
		, HA.NodeID		--WDM 08.07.2014
		, HA.NodeName		--WDM 08.07.2014
		, HA.DocumentID		--WDM 08.07.2014
		, HA.NodeSiteID		--WDM 08.07.2014
       --,VCTJ.NodeAliasPath
		, HA.DocumentPublishedVersionHistoryID		--WDM 08.07.2014
		, VHFHAMJ.Title
		--, dbo.udf_StripHTML(left(left(VHFHAMJ.IntroText,4000),4000)) AS IntroText
		, VHFHAMJ.IntroText
		, VHFHAMJ.DocumentGUID
		, VHFHAMJ.Weight
		, VHFHAMJ.IsEnabled
		, VHFHAMJ.CodeName
       --,VHFHAMJ.NodeAliasPath
		, VHFHAMJ.DocumentPublishedVersionHistoryID
		, VHFHARCJ.Title
		, VHFHARCJ.Weight
		, VHFHARCJ.DocumentGUID
		, VHFHARCJ.IsEnabled
		, VHFHARCJ.CodeName
       --,VHFHARCJ.NodeAliasPath
		, VHFHARCJ.DocumentPublishedVersionHistoryID
		, VHFHARAJ.Title
		, VHFHARAJ.Weight
		, VHFHARAJ.DocumentGUID
		, VHFHARAJ.IsEnabled
		, VHFHARAJ.CodeName
       --,VHFHARAJ.NodeAliasPath
		, VHFHARAJ.ScoringStrategyID
		, VHFHARAJ.DocumentPublishedVersionHistoryID
		, VHFHAQ2.QuestionType
		--, dbo.udf_StripHTML(left(VHFHAQ2.Title,4000)) AS QuesTitle
		, VHFHAQ2.Title AS QuesTitle
		, VHFHAQ2.Weight
		, VHFHAQ2.IsRequired
		, VHFHAQ2.DocumentGUID
		, VHFHAQ2.IsEnabled
		, left(VHFHAQ2.IsVisible,4000)
		, VHFHAQ2.IsStaging
		, VHFHAQ2.CodeName AS QuestionCodeName
       --,VHFHAQ2.NodeAliasPath
		, VHFHAQ2.DocumentPublishedVersionHistoryID
		, VHFHAA2.Value
		, VHFHAA2.Points
		, VHFHAA2.DocumentGUID
		, VHFHAA2.IsEnabled
		, VHFHAA2.CodeName
		, VHFHAA2.UOM
       --,VHFHAA2.NodeAliasPath
		, VHFHAA2.DocumentPublishedVersionHistoryID
		, CASE	WHEN CAST(VCTJ.DocumentCreatedWhen AS DATE) = CAST(vctj.DocumentModifiedWhen AS DATE)
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		, VCTJ.DocumentCreatedWhen
		, VCTJ.DocumentModifiedWhen
		, VCTJ.NodeGuid as CmsTreeNodeGuid	--WDM 08.07.2014
		, HA.NodeGUID as HANodeGUID
	 FROM
		dbo.#Temp_View_CMS_Tree_Joined AS VCTJ

		INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
		INNER JOIN HFit_Account hfa WITH(NOLOCK) ON cs.SiteID = hfa.SiteID
		INNER JOIN dbo.#Temp_View_HFit_HACampaign_Joined c WITH(NOLOCK) ON VCTJ.NodeID = c.NodeParentID
		INNER JOIN #Temp_View_HFit_HealthAssessment_Joined HA WITH (NOLOCK) ON c.HealthAssessmentID = HA.DocumentID
		INNER JOIN dbo.#Temp_View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ ON HA.NodeID = VHFHAMJ.NodeParentID
		INNER JOIN dbo.#Temp_View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
		INNER JOIN dbo.#Temp_View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
		INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentQuestions AS VHFHAQ ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
		LEFT OUTER JOIN dbo.#Temp_View_EDW_HealthAssesmentAnswers AS VHFHAA ON VHFHAQ.NodeID = VHFHAA.NodeParentID
		--matrix level 1 questiongroup
		INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentQuestions AS VHFHAQ2 ON VHFHAQ.NodeID = VHFHAQ2.NodeParentID
		INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentAnswers AS VHFHAA2 ON VHFHAQ2.NodeID = VHFHAA2.NodeParentID
	where VCTJ.DocumentCulture = 'en-us'	--WDM 08.07.2014
		and VHFHAQ.DocumentCulture = 'en-us'	--WDM 08.12.2014	
		and (VHFHAA.DocumentCulture = 'en-us' OR VHFHAA.DocumentCulture is null)	--WDM 08.12.2014		
		and VHFHARCJ.DocumentCulture = 'en-us'	--WDM 08.12.2014		
		and VHFHARAJ.DocumentCulture = 'en-us'	--WDM 08.12.2014		
		and VHFHAMJ.DocumentCulture = 'en-us'	--WDM 08.12.2014		
		AND (VCTJ.DocumentCreatedWhen between @StartDate and @EndDate OR VCTJ.DocumentModifiedWhen between @StartDate and @EndDate)

UNION ALL
--WDM Retrieve Branching Level 1 Question and Matrix Level 1 Question Group
	SELECT Distinct
		NULL as SiteGuid --cs.SiteGUID
		, NULL as AccountCD     --, HFA.AccountCD
		, HA.NodeID		--WDM 08.07.2014
		, HA.NodeName		--WDM 08.07.2014
		, HA.DocumentID		--WDM 08.07.2014
		, HA.NodeSiteID		--WDM 08.07.2014
       --,VCTJ.NodeAliasPath
		, HA.DocumentPublishedVersionHistoryID		--WDM 08.07.2014
		, VHFHAMJ.Title
		--, dbo.udf_StripHTML(left(VHFHAMJ.IntroText,4000)) AS IntroText
		, VHFHAMJ.IntroText 
		, VHFHAMJ.DocumentGUID
		, VHFHAMJ.Weight
		, VHFHAMJ.IsEnabled
		, VHFHAMJ.CodeName
       --,VHFHAMJ.NodeAliasPath
		, VHFHAMJ.DocumentPublishedVersionHistoryID
		, VHFHARCJ.Title
		, VHFHARCJ.Weight
		, VHFHARCJ.DocumentGUID
		, VHFHARCJ.IsEnabled
		, VHFHARCJ.CodeName
       --,VHFHARCJ.NodeAliasPath
		, VHFHARCJ.DocumentPublishedVersionHistoryID
		, VHFHARAJ.Title
		, VHFHARAJ.Weight
		, VHFHARAJ.DocumentGUID
		, VHFHARAJ.IsEnabled
		, VHFHARAJ.CodeName
       --,VHFHARAJ.NodeAliasPath
		, VHFHARAJ.ScoringStrategyID
		, VHFHARAJ.DocumentPublishedVersionHistoryID
		, VHFHAQ3.QuestionType
		--, dbo.udf_StripHTML(left(VHFHAQ3.Title,4000)) AS QuesTitle
		, VHFHAQ3.Title AS QuesTitle
		, VHFHAQ3.Weight
		, VHFHAQ3.IsRequired
		, VHFHAQ3.DocumentGUID
		, VHFHAQ3.IsEnabled
		, left(VHFHAQ3.IsVisible,4000)
		, VHFHAQ3.IsStaging
		, VHFHAQ3.CodeName AS QuestionCodeName
       --,VHFHAQ3.NodeAliasPath
		, VHFHAQ3.DocumentPublishedVersionHistoryID
		, VHFHAA3.Value
		, VHFHAA3.Points
		, VHFHAA3.DocumentGUID
		, VHFHAA3.IsEnabled
		, VHFHAA3.CodeName
		, VHFHAA3.UOM
       --,VHFHAA3.NodeAliasPath
		, VHFHAA3.DocumentPublishedVersionHistoryID
		, CASE	WHEN CAST(VCTJ.DocumentCreatedWhen AS DATE) = CAST(vctj.DocumentModifiedWhen AS DATE)
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		, VCTJ.DocumentCreatedWhen
		, VCTJ.DocumentModifiedWhen
		, VCTJ.NodeGuid as CmsTreeNodeGuid	--WDM 08.07.2014
		, HA.NodeGUID as HANodeGUID
 FROM
  dbo.#Temp_View_CMS_Tree_Joined AS VCTJ

 INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
 INNER JOIN HFit_Account hfa WITH(NOLOCK) ON cs.SiteID = hfa.SiteID
 INNER JOIN dbo.#Temp_View_HFit_HACampaign_Joined c WITH(NOLOCK) ON VCTJ.NodeID = c.NodeParentID
 INNER JOIN #Temp_View_HFit_HealthAssessment_Joined HA WITH (NOLOCK) ON c.HealthAssessmentID = HA.DocumentID
 INNER JOIN dbo.#Temp_View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ ON HA.NodeID = VHFHAMJ.NodeParentID
 INNER JOIN dbo.#Temp_View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
 INNER JOIN dbo.#Temp_View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
 INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentQuestions AS VHFHAQ ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
 LEFT OUTER JOIN dbo.#Temp_View_EDW_HealthAssesmentAnswers AS VHFHAA ON VHFHAQ.NodeID = VHFHAA.NodeParentID

--matrix level 1 questiongroup
--INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentQuestions AS VHFHAQ2 ON VHFHAQ.NodeID = VHFHAQ2.NodeParentID
--INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentAnswers AS VHFHAA2 ON VHFHAQ2.NodeID = VHFHAA2.NodeParentID

--Branching Level 1 Question 
	INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentQuestions AS VHFHAQ3 ON VHFHAA.NodeID = VHFHAQ3.NodeParentID
	LEFT OUTER JOIN dbo.#Temp_View_EDW_HealthAssesmentAnswers AS VHFHAA3 ON VHFHAQ3.NodeID = VHFHAA3.NodeParentID
where VCTJ.DocumentCulture = 'en-us'	--WDM 08.07.2014
		and VHFHAQ.DocumentCulture = 'en-us'	--WDM 08.12.2014	
		and (VHFHAA.DocumentCulture = 'en-us' OR VHFHAA.DocumentCulture is null)	--WDM 08.12.2014		
		and VHFHARCJ.DocumentCulture = 'en-us'	--WDM 08.12.2014		
		and VHFHARAJ.DocumentCulture = 'en-us'	--WDM 08.12.2014		
		and VHFHAMJ.DocumentCulture = 'en-us'	--WDM 08.12.2014		
AND (VCTJ.DocumentCreatedWhen between @StartDate and @EndDate OR VCTJ.DocumentModifiedWhen between @StartDate and @EndDate)

UNION ALL
--WDM Retrieve Branching Level 1 Question and Matrix Level 2 Question Group
	SELECT Distinct
		NULL as SiteGuid --cs.SiteGUID
		, NULL as AccountCD     --, HFA.AccountCD
		, HA.NodeID		--WDM 08.07.2014
		, HA.NodeName		--WDM 08.07.2014
		, HA.DocumentID		--WDM 08.07.2014
		, HA.NodeSiteID		--WDM 08.07.2014
       --,VCTJ.NodeAliasPath
		, HA.DocumentPublishedVersionHistoryID		--WDM 08.07.2014
		, VHFHAMJ.Title
		--, dbo.udf_StripHTML(left(VHFHAMJ.IntroText,4000)) AS IntroText
		, VHFHAMJ.IntroText
		, VHFHAMJ.DocumentGUID
		, VHFHAMJ.Weight
		, VHFHAMJ.IsEnabled
		, VHFHAMJ.CodeName
       --,VHFHAMJ.NodeAliasPath
		, VHFHAMJ.DocumentPublishedVersionHistoryID
		, VHFHARCJ.Title
		, VHFHARCJ.Weight
		, VHFHARCJ.DocumentGUID
		, VHFHARCJ.IsEnabled
		, VHFHARCJ.CodeName
       --,VHFHARCJ.NodeAliasPath
		, VHFHARCJ.DocumentPublishedVersionHistoryID
		, VHFHARAJ.Title
		, VHFHARAJ.Weight
		, VHFHARAJ.DocumentGUID
		, VHFHARAJ.IsEnabled
		, VHFHARAJ.CodeName
       --,VHFHARAJ.NodeAliasPath
		, VHFHARAJ.ScoringStrategyID
		, VHFHARAJ.DocumentPublishedVersionHistoryID
		, VHFHAQ7.QuestionType
		--, dbo.udf_StripHTML(left(VHFHAQ7.Title,4000)) AS QuesTitle
		, VHFHAQ7.Title AS QuesTitle
		, VHFHAQ7.Weight
		, VHFHAQ7.IsRequired
		, VHFHAQ7.DocumentGUID
		, VHFHAQ7.IsEnabled
		, left(VHFHAQ7.IsVisible,4000)
		, VHFHAQ7.IsStaging
		, VHFHAQ7.CodeName AS QuestionCodeName
       --,VHFHAQ7.NodeAliasPath
		, VHFHAQ7.DocumentPublishedVersionHistoryID
		, VHFHAA7.Value
		, VHFHAA7.Points
		, VHFHAA7.DocumentGUID
		, VHFHAA7.IsEnabled
		, VHFHAA7.CodeName
		, VHFHAA7.UOM
       --,VHFHAA7.NodeAliasPath
		, VHFHAA7.DocumentPublishedVersionHistoryID
		, CASE	WHEN CAST(VCTJ.DocumentCreatedWhen AS DATE) = CAST(vctj.DocumentModifiedWhen AS DATE)
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		, VCTJ.DocumentCreatedWhen
		, VCTJ.DocumentModifiedWhen
		, VCTJ.NodeGuid as CmsTreeNodeGuid	--WDM 08.07.2014
		, HA.NodeGUID as HANodeGUID
 FROM
 dbo.#Temp_View_CMS_Tree_Joined AS VCTJ
 INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
 INNER JOIN HFit_Account hfa WITH(NOLOCK) ON cs.SiteID = hfa.SiteID
 INNER JOIN dbo.#Temp_View_HFit_HACampaign_Joined c WITH(NOLOCK) ON VCTJ.NodeID = c.NodeParentID
 INNER JOIN #Temp_View_HFit_HealthAssessment_Joined HA WITH (NOLOCK) ON c.HealthAssessmentID = HA.DocumentID
 INNER JOIN dbo.#Temp_View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ ON HA.NodeID = VHFHAMJ.NodeParentID
 INNER JOIN dbo.#Temp_View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
 INNER JOIN dbo.#Temp_View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
 INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentQuestions AS VHFHAQ ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
 LEFT OUTER JOIN dbo.#Temp_View_EDW_HealthAssesmentAnswers AS VHFHAA ON VHFHAQ.NodeID = VHFHAA.NodeParentID

--matrix level 1 questiongroup
--INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentQuestions AS VHFHAQ2 ON VHFHAQ.NodeID = VHFHAQ2.NodeParentID
--INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentAnswers AS VHFHAA2 ON VHFHAQ2.NodeID = VHFHAA2.NodeParentID

--Branching Level 1 Question 
	INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentQuestions AS VHFHAQ3 ON VHFHAA.NodeID = VHFHAQ3.NodeParentID
--LEFT OUTER JOIN dbo.#Temp_View_EDW_HealthAssesmentAnswers AS VHFHAA3 ON VHFHAQ3.NodeID = VHFHAA3.NodeParentID

--Matrix Level 2 Question Group
	INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentQuestions AS VHFHAQ7 ON VHFHAQ3.NodeID = VHFHAQ7.NodeParentID
	INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentAnswers AS VHFHAA7 ON VHFHAQ7.NodeID = VHFHAA7.NodeParentID
where VCTJ.DocumentCulture = 'en-us'	--WDM 08.07.2014
		and VHFHAQ.DocumentCulture = 'en-us'	--WDM 08.12.2014	
		and (VHFHAA.DocumentCulture = 'en-us' OR VHFHAA.DocumentCulture is null)	--WDM 08.12.2014		
		and VHFHARCJ.DocumentCulture = 'en-us'	--WDM 08.12.2014		
		and VHFHARAJ.DocumentCulture = 'en-us'	--WDM 08.12.2014		
		and VHFHAMJ.DocumentCulture = 'en-us'	--WDM 08.12.2014		
AND (VCTJ.DocumentCreatedWhen between @StartDate and @EndDate OR VCTJ.DocumentModifiedWhen between @StartDate and @EndDate)

UNION ALL
	--****************************************************
	--WDM 6/25/2014 Retrieve the Branching level 1 Question Group
	--THE PROBLEM LIES HERE in this part of query : 1:40 minute
	-- Added two perf indexes to the first query: 25 Sec
	--****************************************************
	SELECT Distinct
		NULL as SiteGuid --cs.SiteGUID
		, NULL as AccountCD     --, HFA.AccountCD
		, HA.NodeID		--WDM 08.07.2014
		, HA.NodeName		--WDM 08.07.2014
		, HA.DocumentID		--WDM 08.07.2014
		, HA.NodeSiteID		--WDM 08.07.2014
       --,VCTJ.NodeAliasPath
		, HA.DocumentPublishedVersionHistoryID		--WDM 08.07.2014
		, VHFHAMJ.Title
		--, dbo.udf_StripHTML(left(VHFHAMJ.IntroText,4000)) AS IntroText
		, VHFHAMJ.IntroText 
		, VHFHAMJ.DocumentGUID
		, VHFHAMJ.Weight
		, VHFHAMJ.IsEnabled
		, VHFHAMJ.CodeName
       --,VHFHAMJ.NodeAliasPath
		, VHFHAMJ.DocumentPublishedVersionHistoryID
		, VHFHARCJ.Title
		, VHFHARCJ.Weight
		, VHFHARCJ.DocumentGUID
		, VHFHARCJ.IsEnabled
		, VHFHARCJ.CodeName
       --,VHFHARCJ.NodeAliasPath
		, VHFHARCJ.DocumentPublishedVersionHistoryID
		, VHFHARAJ.Title
		, VHFHARAJ.Weight
		, VHFHARAJ.DocumentGUID
		, VHFHARAJ.IsEnabled
		, VHFHARAJ.CodeName
       --,VHFHARAJ.NodeAliasPath
		, VHFHARAJ.ScoringStrategyID
		, VHFHARAJ.DocumentPublishedVersionHistoryID
		, VHFHAQ8.QuestionType
		--, dbo.udf_StripHTML(left(VHFHAQ8.Title,4000)) AS QuesTitle
		, VHFHAQ8.Title AS QuesTitle
		, VHFHAQ8.Weight
		, VHFHAQ8.IsRequired
		, VHFHAQ8.DocumentGUID
		, VHFHAQ8.IsEnabled
		, left(VHFHAQ8.IsVisible,4000)
		, VHFHAQ8.IsStaging
		, VHFHAQ8.CodeName AS QuestionCodeName
       --,VHFHAQ8.NodeAliasPath
		, VHFHAQ8.DocumentPublishedVersionHistoryID
		, VHFHAA8.Value
		, VHFHAA8.Points
		, VHFHAA8.DocumentGUID
		, VHFHAA8.IsEnabled
		, VHFHAA8.CodeName
		, VHFHAA8.UOM
       --,VHFHAA8.NodeAliasPath
		, VHFHAA8.DocumentPublishedVersionHistoryID
		, CASE	WHEN CAST(VCTJ.DocumentCreatedWhen AS DATE) = CAST(vctj.DocumentModifiedWhen AS DATE)
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		, VCTJ.DocumentCreatedWhen
		, VCTJ.DocumentModifiedWhen
		, VCTJ.NodeGuid as CmsTreeNodeGuid	--WDM 08.07.2014
		, HA.NodeGUID as HANodeGUID
	FROM
  dbo.#Temp_View_CMS_Tree_Joined AS VCTJ

 INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
 INNER JOIN HFit_Account hfa WITH(NOLOCK) ON cs.SiteID = hfa.SiteID
 INNER JOIN dbo.#Temp_View_HFit_HACampaign_Joined c WITH(NOLOCK) ON VCTJ.NodeID = c.NodeParentID
 INNER JOIN #Temp_View_HFit_HealthAssessment_Joined HA WITH (NOLOCK) ON c.HealthAssessmentID = HA.DocumentID
 INNER JOIN dbo.#Temp_View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ ON HA.NodeID = VHFHAMJ.NodeParentID
 INNER JOIN dbo.#Temp_View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
 INNER JOIN dbo.#Temp_View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
 INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentQuestions AS VHFHAQ ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
 LEFT OUTER JOIN dbo.#Temp_View_EDW_HealthAssesmentAnswers AS VHFHAA ON VHFHAQ.NodeID = VHFHAA.NodeParentID

			--matrix level 1 questiongroup
			--INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentQuestions AS VHFHAQ2 ON VHFHAQ.NodeID = VHFHAQ2.NodeParentID
			--INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentAnswers AS VHFHAA2 ON VHFHAQ2.NodeID = VHFHAA2.NodeParentID

			--Branching Level 1 Question 
			INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentQuestions AS VHFHAQ3 ON VHFHAA.NodeID = VHFHAQ3.NodeParentID
			--LEFT OUTER JOIN dbo.#Temp_View_EDW_HealthAssesmentAnswers AS VHFHAA3 ON VHFHAQ3.NodeID = VHFHAA3.NodeParentID

			--Matrix Level 2 Question Group
			INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentQuestions AS VHFHAQ7 ON VHFHAQ3.NodeID = VHFHAQ7.NodeParentID
			INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentAnswers AS VHFHAA7 ON VHFHAQ7.NodeID = VHFHAA7.NodeParentID

			--Matrix branching level 1 question group
			INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentQuestions AS VHFHAQ8 ON VHFHAA7.NodeID = VHFHAQ8.NodeParentID
			INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentAnswers AS VHFHAA8 ON VHFHAQ8.NodeID = VHFHAA8.NodeParentID
where VCTJ.DocumentCulture = 'en-us'	--WDM 08.07.2014
		and VHFHAQ.DocumentCulture = 'en-us'	--WDM 08.12.2014	
		and (VHFHAA.DocumentCulture = 'en-us' OR VHFHAA.DocumentCulture is null)	--WDM 08.12.2014		
		and VHFHARCJ.DocumentCulture = 'en-us'	--WDM 08.12.2014		
		and VHFHARAJ.DocumentCulture = 'en-us'	--WDM 08.12.2014		
		and VHFHAMJ.DocumentCulture = 'en-us'	--WDM 08.12.2014		
AND (VCTJ.DocumentCreatedWhen between @StartDate and @EndDate OR VCTJ.DocumentModifiedWhen between @StartDate and @EndDate)

UNION ALL
	--****************************************************
	--WDM 6/25/2014 Retrieve the Branching level 2 Question Group
	--THE PROBLEM LIES HERE in this part of query : 1:48  minutes
	--With the new indexes: 29 Secs
	--****************************************************
	SELECT Distinct
		NULL as SiteGuid --cs.SiteGUID
		, NULL as AccountCD     --, HFA.AccountCD
		, HA.NodeID		--WDM 08.07.2014
		, HA.NodeName		--WDM 08.07.2014
		, HA.DocumentID		--WDM 08.07.2014
		, HA.NodeSiteID		--WDM 08.07.2014
       --,VCTJ.NodeAliasPath
		, HA.DocumentPublishedVersionHistoryID		--WDM 08.07.2014
		, VHFHAMJ.Title
		--, dbo.udf_StripHTML(left(VHFHAMJ.IntroText,4000)) AS IntroText
		, VHFHAMJ.IntroText
		, VHFHAMJ.DocumentGUID
		, VHFHAMJ.Weight
		, VHFHAMJ.IsEnabled
		, VHFHAMJ.CodeName
       --,VHFHAMJ.NodeAliasPath
		, VHFHAMJ.DocumentPublishedVersionHistoryID
		, VHFHARCJ.Title
		, VHFHARCJ.Weight
		, VHFHARCJ.DocumentGUID
		, VHFHARCJ.IsEnabled
		, VHFHARCJ.CodeName
       --,VHFHARCJ.NodeAliasPath
		, VHFHARCJ.DocumentPublishedVersionHistoryID
		, VHFHARAJ.Title
		, VHFHARAJ.Weight
		, VHFHARAJ.DocumentGUID
		, VHFHARAJ.IsEnabled
		, VHFHARAJ.CodeName
       --,VHFHARAJ.NodeAliasPath
		, VHFHARAJ.ScoringStrategyID
		, VHFHARAJ.DocumentPublishedVersionHistoryID
		, VHFHAQ4.QuestionType
		--, dbo.udf_StripHTML(left(VHFHAQ4.Title,4000)) AS QuesTitle
		, VHFHAQ4.Title AS QuesTitle
		, VHFHAQ4.Weight
		, VHFHAQ4.IsRequired
		, VHFHAQ4.DocumentGUID
		, VHFHAQ4.IsEnabled
		, left(VHFHAQ4.IsVisible,4000)
		, VHFHAQ4.IsStaging
		, VHFHAQ4.CodeName AS QuestionCodeName
       --,VHFHAQ4.NodeAliasPath
		, VHFHAQ4.DocumentPublishedVersionHistoryID
		, VHFHAA4.Value
		, VHFHAA4.Points
		, VHFHAA4.DocumentGUID
		, VHFHAA4.IsEnabled
		, VHFHAA4.CodeName
		, VHFHAA4.UOM
       --,VHFHAA4.NodeAliasPath
		, VHFHAA4.DocumentPublishedVersionHistoryID
		, CASE	WHEN CAST(VCTJ.DocumentCreatedWhen AS DATE) = CAST(vctj.DocumentModifiedWhen AS DATE)
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		, VCTJ.DocumentCreatedWhen
		, VCTJ.DocumentModifiedWhen
		, VCTJ.NodeGuid as CmsTreeNodeGuid	--WDM 08.07.2014
		, HA.NodeGUID as HANodeGUID
 FROM
  dbo.#Temp_View_CMS_Tree_Joined AS VCTJ

 INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
 INNER JOIN HFit_Account hfa WITH(NOLOCK) ON cs.SiteID = hfa.SiteID
 INNER JOIN dbo.#Temp_View_HFit_HACampaign_Joined c WITH(NOLOCK) ON VCTJ.NodeID = c.NodeParentID
 INNER JOIN #Temp_View_HFit_HealthAssessment_Joined HA WITH (NOLOCK) ON c.HealthAssessmentID = HA.DocumentID
 INNER JOIN dbo.#Temp_View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ ON HA.NodeID = VHFHAMJ.NodeParentID
 INNER JOIN dbo.#Temp_View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
 INNER JOIN dbo.#Temp_View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
 INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentQuestions AS VHFHAQ ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
 LEFT OUTER JOIN dbo.#Temp_View_EDW_HealthAssesmentAnswers AS VHFHAA ON VHFHAQ.NodeID = VHFHAA.NodeParentID

			--matrix level 1 questiongroup
			--INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentQuestions AS VHFHAQ2 ON VHFHAQ.NodeID = VHFHAQ2.NodeParentID
			--INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentAnswers AS VHFHAA2 ON VHFHAQ2.NodeID = VHFHAA2.NodeParentID

			--Branching Level 1 Question 
			INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentQuestions AS VHFHAQ3 ON VHFHAA.NodeID = VHFHAQ3.NodeParentID
			LEFT OUTER JOIN dbo.#Temp_View_EDW_HealthAssesmentAnswers AS VHFHAA3 ON VHFHAQ3.NodeID = VHFHAA3.NodeParentID

			--Matrix Level 2 Question Group
			--INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentQuestions AS VHFHAQ7 ON VHFHAQ3.NodeID = VHFHAQ7.NodeParentID
			--INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentAnswers AS VHFHAA7 ON VHFHAQ7.NodeID = VHFHAA7.NodeParentID

			--Matrix branching level 1 question group
			--INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentQuestions AS VHFHAQ8 ON VHFHAA7.NodeID = VHFHAQ8.NodeParentID
			--INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentAnswers AS VHFHAA8 ON VHFHAQ8.NodeID = VHFHAA8.NodeParentID

			--Branching level 2 Question Group
			INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentQuestions AS VHFHAQ4 ON VHFHAA3.NodeID = VHFHAQ4.NodeParentID
			INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentAnswers AS VHFHAA4 ON VHFHAQ4.NodeID = VHFHAA4.NodeParentID
where VCTJ.DocumentCulture = 'en-us'	--WDM 08.07.2014
		and VHFHAQ.DocumentCulture = 'en-us'	--WDM 08.12.2014	
		and (VHFHAA.DocumentCulture = 'en-us'  OR VHFHAA.DocumentCulture is null)	--WDM 08.12.2014		
		and VHFHARCJ.DocumentCulture = 'en-us'	--WDM 08.12.2014		
		and VHFHARAJ.DocumentCulture = 'en-us'	--WDM 08.12.2014		
		and VHFHAMJ.DocumentCulture = 'en-us'	--WDM 08.12.2014		
AND (VCTJ.DocumentCreatedWhen between @StartDate and @EndDate OR VCTJ.DocumentModifiedWhen between @StartDate and @EndDate)

UNION ALL
--WDM 6/25/2014 Retrieve the Branching level 3 Question Group
	SELECT Distinct
		NULL as SiteGuid --cs.SiteGUID
		, NULL as AccountCD     --, HFA.AccountCD
		, HA.NodeID		--WDM 08.07.2014
		, HA.NodeName		--WDM 08.07.2014
		, HA.DocumentID		--WDM 08.07.2014
		, HA.NodeSiteID		--WDM 08.07.2014
       --,VCTJ.NodeAliasPath
		, HA.DocumentPublishedVersionHistoryID		--WDM 08.07.2014
		, VHFHAMJ.Title
		--, dbo.udf_StripHTML(left(VHFHAMJ.IntroText,4000)) AS IntroText
		, VHFHAMJ.IntroText
		, VHFHAMJ.DocumentGUID
		, VHFHAMJ.Weight
		, VHFHAMJ.IsEnabled
		, VHFHAMJ.CodeName
       --,VHFHAMJ.NodeAliasPath
		, VHFHAMJ.DocumentPublishedVersionHistoryID
		, VHFHARCJ.Title
		, VHFHARCJ.Weight
		, VHFHARCJ.DocumentGUID
		, VHFHARCJ.IsEnabled
		, VHFHARCJ.CodeName
       --,VHFHARCJ.NodeAliasPath
		, VHFHARCJ.DocumentPublishedVersionHistoryID
		, VHFHARAJ.Title
		, VHFHARAJ.Weight
		, VHFHARAJ.DocumentGUID
		, VHFHARAJ.IsEnabled
		, VHFHARAJ.CodeName
       --,VHFHARAJ.NodeAliasPath
		, VHFHARAJ.ScoringStrategyID
		, VHFHARAJ.DocumentPublishedVersionHistoryID
		, VHFHAQ5.QuestionType
		, VHFHAQ5.Title AS QuesTitle
		, VHFHAQ5.Weight
		, VHFHAQ5.IsRequired
		, VHFHAQ5.DocumentGUID
		, VHFHAQ5.IsEnabled
		, left(VHFHAQ5.IsVisible,4000)
		, VHFHAQ5.IsStaging
		, VHFHAQ5.CodeName AS QuestionCodeName
       --,VHFHAQ5.NodeAliasPath
		, VHFHAQ5.DocumentPublishedVersionHistoryID
		, VHFHAA5.Value
		, VHFHAA5.Points
		, VHFHAA5.DocumentGUID
		, VHFHAA5.IsEnabled
		, VHFHAA5.CodeName
		, VHFHAA5.UOM
       --,VHFHAA5.NodeAliasPath
		, VHFHAA5.DocumentPublishedVersionHistoryID
		, CASE	WHEN CAST(VCTJ.DocumentCreatedWhen AS DATE) = CAST(vctj.DocumentModifiedWhen AS DATE)
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		, VCTJ.DocumentCreatedWhen
		, VCTJ.DocumentModifiedWhen
		, VCTJ.NodeGuid as CmsTreeNodeGuid	--WDM 08.07.2014
		, HA.NodeGUID as HANodeGUID
 FROM
  dbo.#Temp_View_CMS_Tree_Joined AS VCTJ

 INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
 INNER JOIN HFit_Account hfa WITH(NOLOCK) ON cs.SiteID = hfa.SiteID
 INNER JOIN dbo.#Temp_View_HFit_HACampaign_Joined c WITH(NOLOCK) ON VCTJ.NodeID = c.NodeParentID
 INNER JOIN #Temp_View_HFit_HealthAssessment_Joined HA WITH (NOLOCK) ON c.HealthAssessmentID = HA.DocumentID
 INNER JOIN dbo.#Temp_View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ ON HA.NodeID = VHFHAMJ.NodeParentID
 INNER JOIN dbo.#Temp_View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
 INNER JOIN dbo.#Temp_View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
 INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentQuestions AS VHFHAQ ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
 LEFT OUTER JOIN dbo.#Temp_View_EDW_HealthAssesmentAnswers AS VHFHAA ON VHFHAQ.NodeID = VHFHAA.NodeParentID

		--matrix level 1 questiongroup
		--INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentQuestions AS VHFHAQ2 ON VHFHAQ.NodeID = VHFHAQ2.NodeParentID
		--INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentAnswers AS VHFHAA2 ON VHFHAQ2.NodeID = VHFHAA2.NodeParentID

		--Branching Level 1 Question 
		INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentQuestions AS VHFHAQ3 ON VHFHAA.NodeID = VHFHAQ3.NodeParentID
		LEFT OUTER JOIN dbo.#Temp_View_EDW_HealthAssesmentAnswers AS VHFHAA3 ON VHFHAQ3.NodeID = VHFHAA3.NodeParentID

		--Matrix Level 2 Question Group
		--INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentQuestions AS VHFHAQ7 ON VHFHAQ3.NodeID = VHFHAQ7.NodeParentID
		--INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentAnswers AS VHFHAA7 ON VHFHAQ7.NodeID = VHFHAA7.NodeParentID

		--Matrix branching level 1 question group
		--INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentQuestions AS VHFHAQ8 ON VHFHAA7.NodeID = VHFHAQ8.NodeParentID
		--INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentAnswers AS VHFHAA8 ON VHFHAQ8.NodeID = VHFHAA8.NodeParentID

		--Branching level 2 Question Group
		INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentQuestions AS VHFHAQ4 ON VHFHAA3.NodeID = VHFHAQ4.NodeParentID
		INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentAnswers AS VHFHAA4 ON VHFHAQ4.NodeID = VHFHAA4.NodeParentID

		--Branching level 3 Question Group
		INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentQuestions AS VHFHAQ5 ON VHFHAA4.NodeID = VHFHAQ5.NodeParentID
		INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentAnswers AS VHFHAA5 ON VHFHAQ5.NodeID = VHFHAA5.NodeParentID
where VCTJ.DocumentCulture = 'en-us'	--WDM 08.07.2014
		and VHFHAQ.DocumentCulture = 'en-us'	--WDM 08.12.2014	
		and (VHFHAA.DocumentCulture = 'en-us'  OR VHFHAA.DocumentCulture is null)	--WDM 08.12.2014		
		and VHFHARCJ.DocumentCulture = 'en-us'	--WDM 08.12.2014		
		and VHFHARAJ.DocumentCulture = 'en-us'	--WDM 08.12.2014		
		and VHFHAMJ.DocumentCulture = 'en-us'	--WDM 08.12.2014		
AND (VCTJ.DocumentCreatedWhen between @StartDate and @EndDate OR VCTJ.DocumentModifiedWhen between @StartDate and @EndDate)

UNION ALL
--WDM 6/25/2014 Retrieve the Branching level 4 Question Group
	SELECT Distinct
		NULL as SiteGuid --cs.SiteGUID
		, NULL as AccountCD     --, HFA.AccountCD
		, HA.NodeID		--WDM 08.07.2014
		, HA.NodeName		--WDM 08.07.2014
		, HA.DocumentID		--WDM 08.07.2014
		, HA.NodeSiteID		--WDM 08.07.2014
       --,VCTJ.NodeAliasPath
		, HA.DocumentPublishedVersionHistoryID		--WDM 08.07.2014
		, VHFHAMJ.Title
		--, dbo.udf_StripHTML(left(VHFHAMJ.IntroText,4000)) AS IntroText
		, VHFHAMJ.IntroText
		, VHFHAMJ.DocumentGUID
		, VHFHAMJ.Weight
		, VHFHAMJ.IsEnabled
		, VHFHAMJ.CodeName
       --,VHFHAMJ.NodeAliasPath
		, VHFHAMJ.DocumentPublishedVersionHistoryID
		, VHFHARCJ.Title
		, VHFHARCJ.Weight
		, VHFHARCJ.DocumentGUID
		, VHFHARCJ.IsEnabled
		, VHFHARCJ.CodeName
       --,VHFHARCJ.NodeAliasPath
		, VHFHARCJ.DocumentPublishedVersionHistoryID
		, VHFHARAJ.Title
		, VHFHARAJ.Weight
		, VHFHARAJ.DocumentGUID
		, VHFHARAJ.IsEnabled
		, VHFHARAJ.CodeName
       --,VHFHARAJ.NodeAliasPath
		, VHFHARAJ.ScoringStrategyID
		, VHFHARAJ.DocumentPublishedVersionHistoryID
		, VHFHAQ6.QuestionType
		--, dbo.udf_StripHTML(left(VHFHAQ6.Title,4000)) AS QuesTitle
		, VHFHAQ6.Title AS QuesTitle
		, VHFHAQ6.Weight
		, VHFHAQ6.IsRequired
		, VHFHAQ6.DocumentGUID
		, VHFHAQ6.IsEnabled
		, left(VHFHAQ6.IsVisible,4000)
		, VHFHAQ6.IsStaging
		, VHFHAQ6.CodeName AS QuestionCodeName
       --,VHFHAQ6.NodeAliasPath
		, VHFHAQ6.DocumentPublishedVersionHistoryID
		, VHFHAA6.Value
		, VHFHAA6.Points
		, VHFHAA6.DocumentGUID
		, VHFHAA6.IsEnabled
		, VHFHAA6.CodeName
		, VHFHAA6.UOM
       --,VHFHAA6.NodeAliasPath
		, VHFHAA6.DocumentPublishedVersionHistoryID
		, CASE	WHEN CAST(VCTJ.DocumentCreatedWhen AS DATE) = CAST(vctj.DocumentModifiedWhen AS DATE)
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		, VCTJ.DocumentCreatedWhen
		, VCTJ.DocumentModifiedWhen
		, VCTJ.NodeGuid as CmsTreeNodeGuid	--WDM 08.07.2014
		, HA.NodeGUID as HANodeGUID
 FROM
	  dbo.#Temp_View_CMS_Tree_Joined AS VCTJ

	 INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
	 INNER JOIN HFit_Account hfa WITH(NOLOCK) ON cs.SiteID = hfa.SiteID
	 INNER JOIN dbo.#Temp_View_HFit_HACampaign_Joined c WITH(NOLOCK) ON VCTJ.NodeID = c.NodeParentID
	 INNER JOIN #Temp_View_HFit_HealthAssessment_Joined HA WITH (NOLOCK) ON c.HealthAssessmentID = HA.DocumentID
	 INNER JOIN dbo.#Temp_View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ ON HA.NodeID = VHFHAMJ.NodeParentID
	 INNER JOIN dbo.#Temp_View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
	 INNER JOIN dbo.#Temp_View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
	 INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentQuestions AS VHFHAQ ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
	 LEFT OUTER JOIN dbo.#Temp_View_EDW_HealthAssesmentAnswers AS VHFHAA ON VHFHAQ.NodeID = VHFHAA.NodeParentID

		--matrix level 1 questiongroup
		--INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentQuestions AS VHFHAQ2 ON VHFHAQ.NodeID = VHFHAQ2.NodeParentID
		--INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentAnswers AS VHFHAA2 ON VHFHAQ2.NodeID = VHFHAA2.NodeParentID

		--Branching Level 1 Question 
		INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentQuestions AS VHFHAQ3 ON VHFHAA.NodeID = VHFHAQ3.NodeParentID
		LEFT OUTER JOIN dbo.#Temp_View_EDW_HealthAssesmentAnswers AS VHFHAA3 ON VHFHAQ3.NodeID = VHFHAA3.NodeParentID

		--Matrix Level 2 Question Group
		--INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentQuestions AS VHFHAQ7 ON VHFHAQ3.NodeID = VHFHAQ7.NodeParentID
		--INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentAnswers AS VHFHAA7 ON VHFHAQ7.NodeID = VHFHAA7.NodeParentID

		--Matrix branching level 1 question group
		--INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentQuestions AS VHFHAQ8 ON VHFHAA7.NodeID = VHFHAQ8.NodeParentID
		--INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentAnswers AS VHFHAA8 ON VHFHAQ8.NodeID = VHFHAA8.NodeParentID

		--Branching level 2 Question Group
		INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentQuestions AS VHFHAQ4 ON VHFHAA3.NodeID = VHFHAQ4.NodeParentID
		INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentAnswers AS VHFHAA4 ON VHFHAQ4.NodeID = VHFHAA4.NodeParentID

		--Branching level 3 Question Group
		--select count(*) from dbo.#Temp_View_EDW_HealthAssesmentAnswers AS VHFHAA4
		INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentQuestions AS VHFHAQ5 ON VHFHAA4.NodeID = VHFHAQ5.NodeParentID
		INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentAnswers AS VHFHAA5 ON VHFHAQ5.NodeID = VHFHAA5.NodeParentID

		--Branching level 4 Question Group
		INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentQuestions AS VHFHAQ6 ON VHFHAA5.NodeID = VHFHAQ6.NodeParentID
		INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentAnswers AS VHFHAA6 ON VHFHAQ6.NodeID = VHFHAA6.NodeParentID
where VCTJ.DocumentCulture = 'en-us'	--WDM 08.07.2014
		and VHFHAQ.DocumentCulture = 'en-us'	--WDM 08.12.2014	
		and (VHFHAA.DocumentCulture = 'en-us'  OR VHFHAA.DocumentCulture is null)	--WDM 08.12.2014		
		and VHFHARCJ.DocumentCulture = 'en-us'	--WDM 08.12.2014		
		and VHFHARAJ.DocumentCulture = 'en-us'	--WDM 08.12.2014		
		and VHFHAMJ.DocumentCulture = 'en-us'	--WDM 08.12.2014		
AND (VCTJ.DocumentCreatedWhen between @StartDate and @EndDate OR VCTJ.DocumentModifiedWhen between @StartDate and @EndDate)

UNION ALL
	--WDM 6/25/2014 Retrieve the Branching level 5 Question Group
	SELECT Distinct
		NULL as SiteGuid --cs.SiteGUID
		, NULL as AccountCD     --, HFA.AccountCD
		, HA.NodeID		--WDM 08.07.2014
		, HA.NodeName		--WDM 08.07.2014
		, HA.DocumentID		--WDM 08.07.2014
		, HA.NodeSiteID		--WDM 08.07.2014
       --,VCTJ.NodeAliasPath
		, HA.DocumentPublishedVersionHistoryID		--WDM 08.07.2014
		, VHFHAMJ.Title
		--, dbo.udf_StripHTML(left(VHFHAMJ.IntroText,4000)) AS IntroText
		, VHFHAMJ.IntroText
		, VHFHAMJ.DocumentGUID
		, VHFHAMJ.Weight
		, VHFHAMJ.IsEnabled
		, VHFHAMJ.CodeName
       --,VHFHAMJ.NodeAliasPath
		, VHFHAMJ.DocumentPublishedVersionHistoryID
		, VHFHARCJ.Title
		, VHFHARCJ.Weight
		, VHFHARCJ.DocumentGUID
		, VHFHARCJ.IsEnabled
		, VHFHARCJ.CodeName
       --,VHFHARCJ.NodeAliasPath
		, VHFHARCJ.DocumentPublishedVersionHistoryID
		, VHFHARAJ.Title
		, VHFHARAJ.Weight
		, VHFHARAJ.DocumentGUID
		, VHFHARAJ.IsEnabled
		, VHFHARAJ.CodeName
       --,VHFHARAJ.NodeAliasPath
		, VHFHARAJ.ScoringStrategyID
		, VHFHARAJ.DocumentPublishedVersionHistoryID
		, VHFHAQ9.QuestionType
		--, dbo.udf_StripHTML(left(VHFHAQ9.Title,4000)) AS QuesTitle
		, VHFHAQ9.Title AS QuesTitle
		, VHFHAQ9.Weight
		, VHFHAQ9.IsRequired
		, VHFHAQ9.DocumentGUID
		, VHFHAQ9.IsEnabled
		, left(VHFHAQ9.IsVisible,4000)
		, VHFHAQ9.IsStaging
		, VHFHAQ9.CodeName AS QuestionCodeName
       --,VHFHAQ9.NodeAliasPath
		, VHFHAQ9.DocumentPublishedVersionHistoryID
		, VHFHAA9.Value
		, VHFHAA9.Points
		, VHFHAA9.DocumentGUID
		, VHFHAA9.IsEnabled
		, VHFHAA9.CodeName
		, VHFHAA9.UOM
       --,VHFHAA9.NodeAliasPath
		, VHFHAA9.DocumentPublishedVersionHistoryID
		, CASE	WHEN CAST(VCTJ.DocumentCreatedWhen AS DATE) = CAST(vctj.DocumentModifiedWhen AS DATE)
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		, VCTJ.DocumentCreatedWhen
		, VCTJ.DocumentModifiedWhen
		, VCTJ.NodeGuid as CmsTreeNodeGuid	--WDM 08.07.2014
		, HA.NodeGUID as HANodeGUID
 FROM
  dbo.#Temp_View_CMS_Tree_Joined AS VCTJ

 INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
 INNER JOIN HFit_Account hfa WITH(NOLOCK) ON cs.SiteID = hfa.SiteID
 INNER JOIN dbo.#Temp_View_HFit_HACampaign_Joined c WITH(NOLOCK) ON VCTJ.NodeID = c.NodeParentID
 INNER JOIN #Temp_View_HFit_HealthAssessment_Joined HA WITH (NOLOCK) ON c.HealthAssessmentID = HA.DocumentID
 INNER JOIN dbo.#Temp_View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ ON HA.NodeID = VHFHAMJ.NodeParentID
 INNER JOIN dbo.#Temp_View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
 INNER JOIN dbo.#Temp_View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
 INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentQuestions AS VHFHAQ ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
 LEFT OUTER JOIN dbo.#Temp_View_EDW_HealthAssesmentAnswers AS VHFHAA ON VHFHAQ.NodeID = VHFHAA.NodeParentID

		--matrix level 1 questiongroup
		--INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentQuestions AS VHFHAQ2 ON VHFHAQ.NodeID = VHFHAQ2.NodeParentID
		--INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentAnswers AS VHFHAA2 ON VHFHAQ2.NodeID = VHFHAA2.NodeParentID

		--Branching Level 1 Question 
		INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentQuestions AS VHFHAQ3 ON VHFHAA.NodeID = VHFHAQ3.NodeParentID
		LEFT OUTER JOIN dbo.#Temp_View_EDW_HealthAssesmentAnswers AS VHFHAA3 ON VHFHAQ3.NodeID = VHFHAA3.NodeParentID

		--Matrix Level 2 Question Group
		--INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentQuestions AS VHFHAQ7 ON VHFHAQ3.NodeID = VHFHAQ7.NodeParentID
		--INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentAnswers AS VHFHAA7 ON VHFHAQ7.NodeID = VHFHAA7.NodeParentID

		--Matrix branching level 1 question group
		--INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentQuestions AS VHFHAQ8 ON VHFHAA7.NodeID = VHFHAQ8.NodeParentID
		--INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentAnswers AS VHFHAA8 ON VHFHAQ8.NodeID = VHFHAA8.NodeParentID

		--Branching level 2 Question Group
		INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentQuestions AS VHFHAQ4 ON VHFHAA3.NodeID = VHFHAQ4.NodeParentID
		INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentAnswers AS VHFHAA4 ON VHFHAQ4.NodeID = VHFHAA4.NodeParentID

		--Branching level 3 Question Group
		--select count(*) from dbo.#Temp_View_EDW_HealthAssesmentAnswers AS VHFHAA4
		INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentQuestions AS VHFHAQ5 ON VHFHAA4.NodeID = VHFHAQ5.NodeParentID
		INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentAnswers AS VHFHAA5 ON VHFHAQ5.NodeID = VHFHAA5.NodeParentID

		--Branching level 4 Question Group
		INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentQuestions AS VHFHAQ6 ON VHFHAA5.NodeID = VHFHAQ6.NodeParentID
		INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentAnswers AS VHFHAA6 ON VHFHAQ6.NodeID = VHFHAA6.NodeParentID

		--Branching level 5 Question Group
		INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentQuestions AS VHFHAQ9 ON VHFHAA6.NodeID = VHFHAQ9.NodeParentID
		INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentAnswers AS VHFHAA9 ON VHFHAQ9.NodeID = VHFHAA9.NodeParentID
where VCTJ.DocumentCulture = 'en-us'	--WDM 08.07.2014
		and VHFHAQ.DocumentCulture = 'en-us'	--WDM 08.12.2014	
		and (VHFHAA.DocumentCulture = 'en-us'  OR VHFHAA.DocumentCulture is null)	--WDM 08.12.2014		
		and VHFHARCJ.DocumentCulture = 'en-us'	--WDM 08.12.2014		
		and VHFHARAJ.DocumentCulture = 'en-us'	--WDM 08.12.2014		
		and VHFHAMJ.DocumentCulture = 'en-us'	--WDM 08.12.2014		
AND (VCTJ.DocumentCreatedWhen between @StartDate and @EndDate OR VCTJ.DocumentModifiedWhen between @StartDate and @EndDate)

		--GO 
	
		drop index [View_CMS_Tree_Joined_Linked].PI04_View_CMS_Tree_Joined_Linked
		--GO

		drop index HFit_Account.PI01_HFit_Account
		--GO

		drop index [View_CMS_Tree_Joined_Linked].[CI01_View_CMS_Tree_Joined_Linked]

declare @cnt as int = (select count(*) from EDW_HealthAssessmentDefinition) ;
print('Processed Recs: ' + cast(@cnt as nvarchar(50)));
if @TrackPerf is not null 
BEGIN
	set @P1End = getdate() ;
	exec proc_EDW_MeasurePerf 'ElapsedTime','HADef-P1',0, @P1Start, @P1End;
END
ELSE
	print('No Perf details requested');


END	

GO
print ('Creating proc_EDW_MeasurePerf');

if exists (select * from sysobjects where name = 'proc_EDW_MeasurePerf' and Xtype = 'P')
BEGIN
	drop procedure proc_EDW_MeasurePerf ;
END 
go


Create procedure [dbo].[proc_EDW_MeasurePerf] (@TypeTest as nvarchar(50),@ObjectName as nvarchar(50),@RecCount as int, @StartTime as datetime,@EndTime as datetime)
as
Begin

	declare @T int ;
	declare @eSecs int ;
	declare @hrs int ;
	declare @mins int ;
	declare @secs int ;
	declare @ms int ;

	if (@EndTime is null)
	BEGIN
		set @EndTime = getdate() ;
	END
	
	print ('@EndTime: ' + cast(@EndTime as nvarchar(20)));

	set @ms = datediff(ms, @StartTime,@EndTime) ;
	set @secs = datediff(ss, @StartTime,@EndTime) ;
	set @mins = datediff(mi, @StartTime,@EndTime) ;
	set @hrs = datediff(hh, @StartTime,@EndTime) ;

	--set @hrs = @T / 1000000 % 100 ;
	--set @mins = @T / 10000 % 100 ;
	--set @secs = @T / 100 % 100 ;
	--set @ms = @T % 1000 % 10 ;

	--set @EndTime = (select dateadd(hour, (@T / 1000000) % 100,
	--	   dateadd(minute, (@T / 10000) % 100,
	--	   dateadd(second, (@T / 100) % 100,
	--	   dateadd(millisecond, (@T % 100) * 10, cast('00:00:00' as time(2))))))  );
		INSERT INTO [dbo].[EDW_PerformanceMeasure]
           ([TypeTest],[ObjectName],[RecCount],[StartTime],[EndTime],hrs,mins,secs,ms)
     VALUES
           (@TypeTest,@ObjectName,@RecCount,@StartTime,@EndTime,@hrs,@mins,@secs,@ms)
End

GO

print ('Created proc_EDW_MeasurePerf') ;

GO



 
 
 
 G O 
 
 - - B E G I N N I N G   O F   P r o c _ E D W _ R e w a r d U s e r D e t a i l 
 
 i f   e x i s t s   ( s e l e c t   *   f r o m   s y s o b j e c t s   w h e r e   n a m e   =   ' P r o c _ E D W _ R e w a r d U s e r D e t a i l '   a n d   X t y p e   =   ' P ' ) 
 
 B E G I N 
 
 	 d r o p   p r o c e d u r e   P r o c _ E D W _ R e w a r d U s e r D e t a i l   ; 
 
 E N D   
 
 g o 
 
 
 
 C r e a t e     p r o c   [ d b o ] . [ P r o c _ E D W _ R e w a r d U s e r D e t a i l ]   ( @ S t a r t D a t e   a s   d a t e t i m e ,   @ E n d D a t e   a s   d a t e t i m e ,   @ T r a c k P e r f   a s   n v a r c h a r ( 1 ) ) 
 
 a s 
 
 B E G I N 
 
 
 
 
 
 - - * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * 
 
 - - s e l e c t   *   f r o m   [ v i e w _ E D W _ R e w a r d U s e r D e t a i l ]   w h e r e   I t e m M o d i f i e d W h e n   b e t w e e n   ' 2 0 0 0 - 1 1 - 1 4 '   a n d   ' 2 0 1 4 - 1 1 - 1 5 ' 
 
 - - s e l e c t   *   f r o m   [ v i e w _ E D W _ R e w a r d U s e r D e t a i l ]   w h e r e   I t e m M o d i f i e d W h e n   b e t w e e n   ' 2 0 1 4 - 0 5 - 1 2 '   a n d   ' 2 0 1 4 - 0 5 - 1 3 '   
 
 - - 8 / 7 / 2 0 1 4   -   a d d e d   a n d   c o m m e n t e d   o u t   D o c u m e n t G u i d   a n d   N o d e G u i d   i n   c a s e   n e e d e d   l a t e r 
 
 - - 8 / 0 8 / 2 0 1 4   -   G e n e r a t e d   c o r r e c t e d   v i e w   i n   D E V   ( W D M ) 
 
 - - 8 / 1 2 / 2 0 1 4   -   P e r f o r m a n c e   I s s u e   -   0 0 : 0 6 : 4 9   @   2 5 8 5 0 2 
 
 - - 8 / 1 2 / 2 0 1 4   -   P e r f o r m a n c e   I s s u e   -   A d d   P I 0 1 _ v i e w _ E D W _ R e w a r d U s e r D e t a i l 
 
 - - 8 / 1 2 / 2 0 1 4   -   P e r f o r m a n c e   I s s u e   -   0 0 : 0 3 : 4 6   @   2 5 8 5 0 2 
 
 - - 8 / 1 2 / 2 0 1 4   -   P e r f o r m a n c e   I s s u e   -   A d d   P I 0 2 _ v i e w _ E D W _ R e w a r d U s e r D e t a i l 
 
 - - 8 / 1 2 / 2 0 1 4   -   P e r f o r m a n c e   I s s u e   -   0 0 : 0 3 : 4 5   @   2 5 8 5 0 2 
 
 - - * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * 
 
 
 
 - - * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * 
 
 - - E X E C U T I O N : 
 
 - - 	 @ S t a r t D a t e :   T h e   d a t e   f r o m   w h i c h   t o   b e g i n   s e l e c t i o n   o f   d a t a 
 
 - - 	 @ E n d D a t e     :   T h e   d a t e   f r o m   w h i c h   t o   s t o p   s e l e c t i o n   o f   d a t a 
 
 - - 	 @ T r a c k P e r f :   A n y t h i n g   o t h e r   t h a n   a   N U L L   c h a r   t o   t r a c k   p e r f o r m a n c e . 
 
 - - 	 e x e c   P r o c _ E D W _ R e w a r d U s e r D e t a i l   N U L L ,   N U L L ,   ' Y ' 
 
 - - 	 e x e c   P r o c _ E D W _ R e w a r d U s e r D e t a i l   ' 2 0 1 0 - 1 1 - 1 4 ' ,   ' 2 0 1 4 - 1 1 - 1 5 ' ,   ' Y ' 
 
 - - 	 e x e c   P r o c _ E D W _ R e w a r d U s e r D e t a i l   ' 2 0 1 0 - 0 6 - 1 0 ' ,   ' 2 0 1 4 - 0 6 - 1 1 ' ,   N U L L 
 
 - - * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * 
 
 
 
 	 d e c l a r e   @ P 0 S t a r t   a s   d a t e t i m e   ; 
 
 	 d e c l a r e   @ P 0 E n d   a s   d a t e t i m e   ; 
 
 
 
 	 s e t   @ P 0 S t a r t   =   g e t d a t e ( )   ; 
 
 	 
 
 	 I F   @ S t a r t D a t e   i s   n u l l   
 
 	 B E G I N 
 
 	 	 s e t   @ S t a r t D a t e     = D A T E A D D ( D a y ,   0 ,   D A T E D I F F ( D a y ,   0 ,   G e t D a t e ( ) ) ) ; 	 - - M i d n i g h t   y e s t e r d a y ; 	 
 
 	 	 s e t   @ S t a r t D a t e   =   @ S t a r t D a t e     - 1   ; 
 
 	 E N D 
 
 	 
 
 	 I F   @ E n d D a t e   i s   n u l l   
 
 	 B E G I N 
 
 	 	 s e t   @ E n d D a t e   =   c a s t   ( g e t d a t e ( )   a s   d a t e ) ; 
 
 	 E N D 
 
 
 
 	 - - * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * 
 
 i f   e x i s t s   ( s e l e c t   n a m e   f r o m   s y s . t a b l e s   w h e r e   n a m e   =   ' E D W _ R e w a r d U s e r D e t a i l ' ) 
 
 B E G I N 
 
 	 d r o p   t a b l e   E D W _ R e w a r d U s e r D e t a i l   ; 
 
 E N D 
 
 
 
 I F   n o t   E X I S T S 
 
 	 	 ( 
 
 	 	 	 S E L E C T   n a m e 
 
 	 	 	 F R O M   S Y S . I N D E X E S 
 
 	 	 	 W H E R E   N A M E   =   ' p i _ C M S _ U s e r S e t t i n g s _ I D M P I ' 
 
 	 	 ) 
 
 	 B E G I N 
 
 	 	 C R E A T E   n o n C L U S T E R E D     I N D E X   p i _ C M S _ U s e r S e t t i n g s _ I D M P I 
 
 	 	 O N   C M S _ U s e r S e t t i n g s 
 
 	 	 ( 	 	 [ U s e r S e t t i n g s I D ]   A S C   
 
 	 	 	 	 ,   [ H F i t U s e r M p i N u m b e r ] 
 
 	 	 ) 
 
 	 E N D 
 
 
 
 
 
 	 I F   n o t   E X I S T S 
 
 	 	 ( 
 
 	 	 	 S E L E C T   n a m e 
 
 	 	 	 F R O M   S Y S . I N D E X E S 
 
 	 	 	 W H E R E   N A M E   =   ' p i _ C M S _ U s e r S e t t i n g s _ I D M P I ' 
 
 	 	 ) 
 
 	 B E G I N 
 
 	 	 C R E A T E   n o n C L U S T E R E D     I N D E X   p i _ C M S _ U s e r S e t t i n g s _ I D M P I 
 
 	 	 O N   C M S _ U s e r S e t t i n g s 
 
 	 	 ( 	 	 [ U s e r S e t t i n g s I D ]   A S C   
 
 	 	 	 	 ,   [ H F i t U s e r M p i N u m b e r ] 
 
 	 	 ) 
 
 	 E N D 
 
 	 - - G O 	 
 
 
 
 I F   n o t   E X I S T S 
 
 	 	 ( 
 
 	 	 	 S E L E C T   n a m e 
 
 	 	 	 F R O M   S Y S . I N D E X E S 
 
 	 	 	 W H E R E   N A M E   =   ' P I _ C M S _ U s e r S i t e _ S i t e I D ' 
 
 	 	 ) 
 
 	 B E G I N 
 
 	 C R E A T E   N O N C L U S T E R E D   I N D E X   P I _ C M S _ U s e r S i t e _ S i t e I D 
 
 	 	 O N   [ d b o ] . [ C M S _ U s e r S i t e ]   ( [ S i t e I D ] ) 
 
 	 	 I N C L U D E   ( [ U s e r I D ] ) 
 
 	 E N D 
 
 
 
 	 I F   E X I S T S 
 
 	 	 ( 
 
 	 	 	 S E L E C T   n a m e 
 
 	 	 	 F R O M   t e m p d b . d b o . s y s o b j e c t s 	 	 	 
 
 	 	 	 W H E R E   I D   =   O B J E C T _ I D ( N ' t e m p d b . . # T e m p _ V i e w _ H F i t _ R e w a r d P r o g r a m _ J o i n e d ' ) 
 
 	 	 ) 
 
 	 B E G I N 
 
 	 	 d r o p   t a b l e   # T e m p _ V i e w _ H F i t _ R e w a r d P r o g r a m _ J o i n e d ; 
 
 	 E N D 
 
 	 - - G O 	 	 	 
 
 	 s e l e c t   N o d e I D ,   R e w a r d P r o g r a m N a m e ,   R e w a r d P r o g r a m I D ,   
 
 	 	 R e w a r d P r o g r a m P e r i o d S t a r t ,   R e w a r d P r o g r a m P e r i o d E n d ,   D o c u m e n t M o d i f i e d W h e n , 
 
 	 	 N o d e G U I D ,   D o c u m e n t G U I D 
 
 	 i n t o   # T e m p _ V i e w _ H F i t _ R e w a r d P r o g r a m _ J o i n e d   
 
 	 f r o m   V i e w _ H F i t _ R e w a r d P r o g r a m _ J o i n e d   
 
 	 w h e r e   V i e w _ H F i t _ R e w a r d P r o g r a m _ J o i n e d . D o c u m e n t C u l t u r e   =   ' e n - u s '   ; 
 
 	 
 
 	 c r e a t e   c l u s t e r e d   i n d e x   P I _ T e m p _ V i e w _ H F i t _ R e w a r d P r o g r a m _ J o i n e d   o n   # T e m p _ V i e w _ H F i t _ R e w a r d P r o g r a m _ J o i n e d   
 
 	 ( 
 
 	 	 N o d e I D 
 
 	 ) 
 
 	 - - * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * 
 
 	 
 
 	 I F   E X I S T S 
 
 	 	 ( 
 
 	 	 	 S E L E C T   n a m e 
 
 	 	 	 F R O M   t e m p d b . d b o . s y s o b j e c t s 	 	 	 
 
 	 	 	 W H E R E   I D   =   O B J E C T _ I D ( N ' t e m p d b . . # T E M P _ V i e w _ H F i t _ R e w a r d G r o u p _ J o i n e d ' ) 
 
 	 	 ) 
 
 	 B E G I N 
 
 	 	 d r o p   t a b l e   # T E M P _ V i e w _ H F i t _ R e w a r d G r o u p _ J o i n e d ; 
 
 	 E N D 
 
 	 - - G O 	 	 	 
 
 	 	 s e l e c t   N o d e I D ,   N o d e P a r e n t I D ,   G r o u p N a m e ,   R e w a r d G r o u p I D ,   R e w a r d G r o u p P e r i o d S t a r t   , R e w a r d G r o u p P e r i o d E n d   , D o c u m e n t M o d i f i e d W h e n   
 
 	 i n t o   # T E M P _ V i e w _ H F i t _ R e w a r d G r o u p _ J o i n e d 
 
 	 f r o m   V i e w _ H F i t _ R e w a r d G r o u p _ J o i n e d 
 
 	 w h e r e   V i e w _ H F i t _ R e w a r d G r o u p _ J o i n e d . D o c u m e n t C u l t u r e   =   ' e n - u s '   ; 
 
 	 
 
 	 c r e a t e   c l u s t e r e d   i n d e x   P I _ T E M P _ V i e w _ H F i t _ R e w a r d G r o u p _ J o i n e d 
 
 	   o n   # T E M P _ V i e w _ H F i t _ R e w a r d G r o u p _ J o i n e d 
 
 	 ( 
 
 	 	 N o d e I D ,   N o d e P a r e n t I D ,   G r o u p N a m e ,   R e w a r d G r o u p I D ,   R e w a r d G r o u p P e r i o d S t a r t   , R e w a r d G r o u p P e r i o d E n d   , D o c u m e n t M o d i f i e d W h e n   
 
 	 ) 
 
 	 - - * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * 
 
 	 - - * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * 
 
 	 
 
 	 I F   E X I S T S 
 
 	 	 ( 
 
 	 	 	 S E L E C T   n a m e 
 
 	 	 	 F R O M   t e m p d b . d b o . s y s o b j e c t s 	 	 	 
 
 	 	 	 W H E R E   I D   =   O B J E C T _ I D ( N ' t e m p d b . . # T E M P _ V i e w _ H F i t _ R e w a r d L e v e l _ J o i n e d ' ) 
 
 	 	 ) 
 
 	 B E G I N 
 
 	 	 d r o p   t a b l e   # T E M P _ V i e w _ H F i t _ R e w a r d L e v e l _ J o i n e d ; 
 
 	 E N D 
 
 	 - - G O 	 	 	 
 
 	 	 s e l e c t   N o d e I D ,   N o d e P a r e n t I D ,   A w a r d T y p e ,   L e v e l T y p e ,   L e v e l ,   D o c u m e n t M o d i f i e d W h e n ,   R e w a r d L e v e l P e r i o d S t a r t ,   R e w a r d L e v e l P e r i o d E n d 
 
 	 i n t o   # T E M P _ V i e w _ H F i t _ R e w a r d L e v e l _ J o i n e d 
 
 	 f r o m   V i e w _ H F i t _ R e w a r d L e v e l _ J o i n e d 
 
 	 w h e r e   V i e w _ H F i t _ R e w a r d L e v e l _ J o i n e d . D o c u m e n t C u l t u r e   =   ' e n - u s '   ; 
 
 	 
 
 	 c r e a t e   c l u s t e r e d   i n d e x   P I _ T E M P _ V i e w _ H F i t _ R e w a r d L e v e l _ J o i n e d 
 
 	   o n   # T E M P _ V i e w _ H F i t _ R e w a r d L e v e l _ J o i n e d 
 
 	 ( 
 
 	 	 N o d e I D ,   N o d e P a r e n t I D ,   A w a r d T y p e ,   L e v e l T y p e ,   L e v e l ,   D o c u m e n t M o d i f i e d W h e n ,   R e w a r d L e v e l P e r i o d S t a r t ,   R e w a r d L e v e l P e r i o d E n d 
 
 	 ) 
 
 	 - - * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * 
 
 	 - - * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * 
 
 	 
 
 	 I F   E X I S T S 
 
 	 	 ( 
 
 	 	 	 S E L E C T   n a m e 
 
 	 	 	 F R O M   t e m p d b . d b o . s y s o b j e c t s 	 	 	 
 
 	 	 	 W H E R E   I D   =   O B J E C T _ I D ( N ' t e m p d b . . # T E M P _ V i e w _ H F i t _ R e w a r d A c t i v i t y _ J o i n e d ' ) 
 
 	 	 ) 
 
 	 B E G I N 
 
 	 	 d r o p   t a b l e   # T E M P _ V i e w _ H F i t _ R e w a r d A c t i v i t y _ J o i n e d ; 
 
 	 E N D 
 
 	 - - G O 	 	 	 
 
 	 	 s e l e c t   N o d e I D ,   N o d e P a r e n t I D ,   R e w a r d A c t i v i t y I D ,   A c t i v i t y N a m e ,   R e w a r d A c t i v i t y P e r i o d S t a r t ,   R e w a r d A c t i v i t y P e r i o d E n d ,   A c t i v i t y P o i n t s 
 
 	 i n t o   # T E M P _ V i e w _ H F i t _ R e w a r d A c t i v i t y _ J o i n e d 
 
 	 f r o m   V i e w _ H F i t _ R e w a r d A c t i v i t y _ J o i n e d 
 
 	 w h e r e   V i e w _ H F i t _ R e w a r d A c t i v i t y _ J o i n e d . D o c u m e n t C u l t u r e   =   ' e n - u s '   ; 
 
 	 
 
 	 c r e a t e   c l u s t e r e d   i n d e x   P I _ T E M P _ V i e w _ H F i t _ R e w a r d A c t i v i t y _ J o i n e d 
 
 	   o n   # T E M P _ V i e w _ H F i t _ R e w a r d A c t i v i t y _ J o i n e d 
 
 	 ( 
 
 	 	 N o d e I D ,   N o d e P a r e n t I D ,   R e w a r d A c t i v i t y I D ,   A c t i v i t y N a m e ,   R e w a r d A c t i v i t y P e r i o d S t a r t ,   R e w a r d A c t i v i t y P e r i o d E n d ,   A c t i v i t y P o i n t s 
 
 	 ) 
 
 	 - - * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * 
 
 	 - - * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * 	 
 
 	 I F   E X I S T S 
 
 	 	 ( 
 
 	 	 	 S E L E C T   n a m e 
 
 	 	 	 F R O M   t e m p d b . d b o . s y s o b j e c t s 	 	 	 
 
 	 	 	 W H E R E   I D   =   O B J E C T _ I D ( N ' t e m p d b . . # T E M P _ V i e w _ H F i t _ R e w a r d T r i g g e r _ J o i n e d ' ) 
 
 	 	 ) 
 
 	 B E G I N 
 
 	 	 d r o p   t a b l e   # T E M P _ V i e w _ H F i t _ R e w a r d T r i g g e r _ J o i n e d ; 
 
 	 E N D 
 
 	 - - G O 	 	 	 
 
 	 	 s e l e c t   N o d e P a r e n t I D ,   R e w a r d T r i g g e r L K P I D ,   T r i g g e r N a m e ,   R e w a r d T r i g g e r I D 
 
 	 i n t o   # T E M P _ V i e w _ H F i t _ R e w a r d T r i g g e r _ J o i n e d 
 
 	 f r o m   V i e w _ H F i t _ R e w a r d T r i g g e r _ J o i n e d 
 
 	 w h e r e   V i e w _ H F i t _ R e w a r d T r i g g e r _ J o i n e d . D o c u m e n t C u l t u r e   =   ' e n - u s '   ; 
 
 	 
 
 	 c r e a t e   c l u s t e r e d   i n d e x   P I _ T E M P _ V i e w _ H F i t _ R e w a r d T r i g g e r _ J o i n e d 
 
 	   o n   # T E M P _ V i e w _ H F i t _ R e w a r d T r i g g e r _ J o i n e d 
 
 	 ( 
 
 	 	 N o d e P a r e n t I D ,   R e w a r d T r i g g e r L K P I D ,   T r i g g e r N a m e ,   R e w a r d T r i g g e r I D 
 
 	 ) 
 
 	 - - * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * 
 
 	 - - * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * 	 
 
 	 I F   E X I S T S 
 
 	 	 ( 
 
 	 	 	 S E L E C T   n a m e 
 
 	 	 	 F R O M   t e m p d b . d b o . s y s o b j e c t s 	 	 	 
 
 	 	 	 W H E R E   I D   =   O B J E C T _ I D ( N ' t e m p d b . . # T E M P _ C M S _ U s e r S e t t i n g s ' ) 
 
 	 	 ) 
 
 	 B E G I N 
 
 	 	 d r o p   t a b l e   # T E M P _ C M S _ U s e r S e t t i n g s ; 
 
 	 E N D 
 
 	 - - G O 	 	 	 
 
 	 	 s e l e c t   H F i t U s e r M p i N u m b e r ,   U s e r S e t t i n g s U s e r I D 
 
 	 i n t o   # T E M P _ C M S _ U s e r S e t t i n g s 
 
 	 f r o m   C M S _ U s e r S e t t i n g s 	 
 
 	 
 
 	 c r e a t e   c l u s t e r e d   i n d e x   P I _ T E M P _ C M S _ U s e r S e t t i n g s 
 
 	   o n   # T E M P _ C M S _ U s e r S e t t i n g s 
 
 	 ( 
 
 	 	 H F i t U s e r M p i N u m b e r ,   U s e r S e t t i n g s U s e r I D 
 
 	 ) 
 
 
 
 	 C R E A T E   N O N C L U S T E R E D   I N D E X   P I _ T E M P _ C M S _ U s e r S e t t i n g s 2 
 
 	 	 O N   [ d b o ] . [ # T E M P _ C M S _ U s e r S e t t i n g s ]   
 
 	 	 ( [ U s e r S e t t i n g s U s e r I D ] ) 
 
 	 	 I N C L U D E   ( [ H F i t U s e r M p i N u m b e r ] ) 
 
 	 
 
 	 - - * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * 
 
 	 - - * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * 
 
 	 - -   T h i s   i s   t h e   d a t a   e x t r a c t i o n   Q U E R Y 
 
 	 - - * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * 
 
 	 S E L E C T   
 
 	 	 c u . U s e r G U I D 
 
 	 	 ,   C S 2 . S i t e G U I D 
 
 	 	 ,   c u s 2 . H F i t U s e r M p i N u m b e r 
 
 	 	 ,   V H F R A J . R e w a r d A c t i v i t y I D 
 
 	 	 ,   V H F R P J . R e w a r d P r o g r a m N a m e 
 
 	 	 ,   V H F R P J . R e w a r d P r o g r a m I D 
 
 	 	 ,   V H F R P J . R e w a r d P r o g r a m P e r i o d S t a r t 
 
 	 	 ,   V H F R P J . R e w a r d P r o g r a m P e r i o d E n d 
 
 	 	 ,   V H F R P J . D o c u m e n t M o d i f i e d W h e n   A S   R e w a r d M o d i f i e d D a t e 
 
 	 	 ,   V H F R G J . G r o u p N a m e 
 
 	 	 ,   V H F R G J . R e w a r d G r o u p I D 
 
 	 	 ,   V H F R G J . R e w a r d G r o u p P e r i o d S t a r t 
 
 	 	 ,   V H F R G J . R e w a r d G r o u p P e r i o d E n d 
 
 	 	 ,   V H F R G J . D o c u m e n t M o d i f i e d W h e n   A S   R e w a r d G r o u p M o d i f i e D a t e 
 
 	 	 ,   V H F R L J . L e v e l 
 
 	 	 ,   H F L R L T . R e w a r d L e v e l T y p e L K P N a m e 
 
 	 	 ,   V H F R L J . D o c u m e n t M o d i f i e d W h e n   A S   R e w a r d L e v e l M o d i f i e d D a t e 
 
 	 	 ,   H F R U L D . L e v e l C o m p l e t e d D t 
 
 	 	 ,   H F R U L D . L e v e l V e r s i o n H i s t o r y I D 
 
 	 	 ,   V H F R L J . R e w a r d L e v e l P e r i o d S t a r t 
 
 	 	 ,   V H F R L J . R e w a r d L e v e l P e r i o d E n d 
 
 	 	 ,   V H F R A J . A c t i v i t y N a m e 
 
 	 	 ,   H F R U A D . A c t i v i t y P o i n t s E a r n e d 
 
 	 	 ,   H F R U A D . A c t i v i t y C o m p l e t e d D t 
 
 	 	 ,   H F R U A D . A c t i v i t y V e r s i o n I D 
 
 	 	 ,   H F R U A D . I t e m M o d i f i e d W h e n   A S   R e w a r d A c t i v i t y M o d i f i e d D a t e 
 
 	 	 ,   V H F R A J . R e w a r d A c t i v i t y P e r i o d S t a r t 
 
 	 	 ,   V H F R A J . R e w a r d A c t i v i t y P e r i o d E n d 
 
 	 	 ,   V H F R A J . A c t i v i t y P o i n t s 
 
 	 	 ,   H F R E . U s e r A c c e p t e d 
 
 	 	 ,   H F R E . U s e r E x c e p t i o n A p p l i e d T o 
 
 	 	 - - ,   H F R E . I t e m M o d i f i e d W h e n   A S   R e w a r d E x c e p t i o n M o d i f i e d D a t e 
 
 	 	 ,   V H F R T J . T r i g g e r N a m e 
 
 	 	 ,   V H F R T J . R e w a r d T r i g g e r I D 
 
 	 	 ,   H F L R T 2 . R e w a r d T r i g g e r L K P D i s p l a y N a m e 
 
 	 	 ,   H F L R T 2 . R e w a r d T r i g g e r D y n a m i c V a l u e 
 
 	 	 ,   H F L R T 2 . I t e m M o d i f i e d W h e n   A S   R e w a r d T r i g g e r M o d i f i e d D a t e 
 
 	 	 ,   H F L R T . R e w a r d T y p e L K P N a m e 
 
 	 	 ,   H F A . A c c o u n t I D 
 
 	 	 ,   H F A . A c c o u n t C D 
 
 	 	 ,   C A S E 	 W H E N   C A S T ( H F R U L D . I t e m C r e a t e d W h e n   A S   D A T E )   =   C A S T ( H F R U L D . I t e m M o d i f i e d W h e n   A S   D A T E ) 
 
 	 	 	 	 T H E N   ' I ' 
 
 	 	 	 	 E L S E   ' U ' 
 
 	 	 	 E N D   A S   C h a n g e T y p e 
 
 	 	 ,   H F R U L D . I t e m C r e a t e d W h e n 
 
 	 	 ,   H F R U L D . I t e m M o d i f i e d W h e n 
 
 	 	 
 
 	 	 ,   H F R E . I t e m M o d i f i e d W h e n   A S   R e w a r d E x c e p t i o n M o d i f i e d D a t e 
 
 	 	 ,   H F R U A D . I t e m M o d i f i e d W h e n   a s   R e w a r d s U s e r A c t i v i t y _ I t e m M o d i f i e d W h e n 	 - - 0 9 . 1 1 . 2 0 1 4   ( w d m )   a d d e d   f o r   E D W 
 
 	 	 ,   V H F R T J . D o c u m e n t M o d i f i e d W h e n   a s     R e w a r d T r i g g e r _ D o c u m e n t M o d i f i e d W h e n 
 
 	 	 ,   V H F R P J . D o c u m e n t G u i d 	 	 - - W D M   a d d e d   8 / 7 / 2 0 1 4   i n   c a s e   n e e d e d 
 
 	 	 ,   V H F R P J . N o d e G u i d 	 	 - - W D M   a d d e d   8 / 7 / 2 0 1 4   i n   c a s e   n e e d e d 	 	 
 
 i n t o   E D W _ R e w a r d U s e r D e t a i l 
 
 	 F R O M 
 
 	 	 # T e m p _ V i e w _ H F i t _ R e w a r d P r o g r a m _ J o i n e d   A S   V H F R P J   W I T H   (   N O L O C K   ) 
 
 	 	 L E F T   O U T E R   J O I N   # T E M P _ V i e w _ H F i t _ R e w a r d G r o u p _ J o i n e d   A S   V H F R G J   W I T H   (   N O L O C K   )   O N   V H F R P J . N o d e I D   =   V H F R G J . N o d e P a r e n t I D 
 
 	 	 L E F T   O U T E R   J O I N   # T E M P _ V i e w _ H F i t _ R e w a r d L e v e l _ J o i n e d   A S   V H F R L J   W I T H   (   N O L O C K   )   O N   V H F R G J . N o d e I D   =   V H F R L J . N o d e P a r e n t I D 
 
 	 	 L E F T   O U T E R   J O I N   d b o . H F i t _ L K P _ R e w a r d T y p e   A S   H F L R T   W I T H   (   N O L O C K   )   O N   V H F R L J . A w a r d T y p e   =   H F L R T . R e w a r d T y p e L K P I D 
 
 	 	 L E F T   O U T E R   J O I N   d b o . H F i t _ L K P _ R e w a r d L e v e l T y p e   A S   H F L R L T   W I T H   (   N O L O C K   )   O N   v h f r l j . L e v e l T y p e   =   H F L R L T . R e w a r d L e v e l T y p e L K P I D 
 
 	 	 I N N E R   J O I N   d b o . H F i t _ R e w a r d s U s e r L e v e l D e t a i l   A S   H F R U L D   W I T H   (   N O L O C K   )   O N   V H F R L J . N o d e I D   =   H F R U L D . L e v e l N o d e I D 
 
 	 	 I N N E R   J O I N   d b o . C M S _ U s e r   A S   C U   W I T H   (   N O L O C K   )   O N   h f r u l d . U s e r I D   =   c u . U s e r I D 
 
 	 	 I N N E R   J O I N   d b o . C M S _ U s e r S i t e   A S   C U S   W I T H   (   N O L O C K   )   O N   C U . U s e r I D   =   C U S . U s e r I D 
 
 	 	 I N N E R   J O I N   d b o . C M S _ S i t e   A S   C S 2   W I T H   (   N O L O C K   )   O N   C U S . S i t e I D   =   C S 2 . S i t e I D 
 
 	 	 I N N E R   J O I N   d b o . H F i t _ A c c o u n t   A S   H F A   W I T H   (   N O L O C K   )   O N   c s 2 . S i t e I D   =   H F A . S i t e I D 
 
 
 
 	 	 I N N E R   J O I N   # T E M P _ C M S _ U s e r S e t t i n g s   A S   C U S 2   O N   c u . U s e r I D   =   c u s 2 . U s e r S e t t i n g s U s e r I D 	 	 
 
 	 	 L E F T   O U T E R   J O I N   # T E M P _ V i e w _ H F i t _ R e w a r d A c t i v i t y _ J o i n e d   A S   V H F R A J   W I T H   (   N O L O C K   )   O N   V H F R L J . N o d e I D   =   V H F R A J . N o d e P a r e n t I D 
 
 	 	 
 
 	 	 I N N E R   J O I N   d b o . H F i t _ R e w a r d s U s e r A c t i v i t y D e t a i l   A S   H F R U A D   W I T H   (   N O L O C K   )   O N   V H F R A J . N o d e I D   =   H F R U A D . A c t i v i t y N o d e I D 
 
 	 	 L E F T   O U T E R   J O I N   d b o . V i e w _ H F i t _ R e w a r d T r i g g e r _ J o i n e d   A S   V H F R T J   W I T H   (   N O L O C K   )   O N   V H F R A J . N o d e I D   =   V H F R T J . N o d e P a r e n t I D 
 
 	 	 L E F T   O U T E R   J O I N   d b o . H F i t _ L K P _ R e w a r d T r i g g e r   A S   H F L R T 2   W I T H   (   N O L O C K   )   O N   V H F R T J . R e w a r d T r i g g e r L K P I D   =   H F L R T 2 . R e w a r d T r i g g e r L K P I D 
 
 	 	 L E F T   O U T E R   J O I N   d b o . H F i t _ R e w a r d E x c e p t i o n   A S   H F R E   W I T H   (   N O L O C K   )   O N   H F R E . R e w a r d A c t i v i t y I D   =   V H F R A J . R e w a r d A c t i v i t y I D 
 
 	 	 	 	 A N D   H F R E . U s e r I D   =   c u . U s e r I D 
 
 	 
 
 	 	 W h e r e   H F R U L D . I t e m M o d i f i e d W h e n   > =   @ S t a r t D a t e   A N D   H F R U L D . I t e m M o d i f i e d W h e n   < =   @ E n d D a t e 
 
 	 	 - - O P T I O N   ( T A B L E   H I N T ( C U S 2   ,   i n d e x   ( p i _ C M S _ U s e r S e t t i n g s _ I D M P I ) ) ) 
 
 
 
 	 i f   @ T r a c k P e r f   i s   n o t   n u l l   
 
 	 B E G I N 
 
 	 	 s e t   @ P 0 E n d   =   g e t d a t e ( )   ; 
 
 	 	 e x e c   p r o c _ E D W _ M e a s u r e P e r f   ' E l a p s e d T i m e ' , ' H A R e w a r d U S e r - P 0 ' , 0 ,   @ P 0 S t a r t ,   @ P 0 E n d ; 
 
 	 E N D 
 
 
 
 E N D   - - E n d   o f   P r o c 
 
 
 
 G O 
 
 
 
 - - E N D   O F   P r o c _ E D W _ R e w a r d U s e r D e t a i l 
 
 
 
 
if exists (select * from sysobjects where name = 'Proc_EDW_TrackerMetadataExtract' and Xtype = 'P')
BEGIN
	drop procedure Proc_EDW_TrackerMetadataExtract ;
END 
go

--exec Proc_EDW_TrackerMetadataExtract 'HFit.TrackerWater'
--select * from #Temp_TrackerMetaData
--select * from Tracker_EDW_Metadata
--truncate table Tracker_EDW_Metadata
create procedure [dbo].[Proc_EDW_TrackerMetadataExtract] (@TrackerClassName as nvarchar(250))
as
IF EXISTS
	(
		SELECT name
		FROM tempdb.dbo.sysobjects
		WHERE ID = OBJECT_ID(N'tempdb..#Temp_TrackerMetaData')
	)
	BEGIN
		DROP TABLE #Temp_TrackerMetaData
	END

DECLARE @MetaDataLastLoadDate datetime ;
DECLARE @ClassLastModified datetime ;


DECLARE @Xml XML
DECLARE @docHandle int;
DECLARE @form nvarchar(250);

declare @dbForm nvarchar(250) ;
declare @id int ;
declare @parent int;
declare @nodetype int;
declare @localname nvarchar(250);
declare @prefix nvarchar(250);
declare @namespaceuri nvarchar(250);
declare @datatype nvarchar(250);
declare @prev nvarchar(250);
declare @dbText nvarchar(250);

declare @ParentName nvarchar(250);

--declare @xdbForm nvarchar(250) ;
--declare @xid int ;
--declare @xparent int;
--declare @xnodetype int;
--declare @xlocalname nvarchar(250);
--declare @xprefix nvarchar(250);
--declare @xnamespaceuri nvarchar(250);
--declare @xdatatype nvarchar(250);
--declare @xprev nvarchar(250);
--declare @xdbText nvarchar(250);

declare @TableName nvarchar(100);
declare @ColName nvarchar(100);
declare @AttrName nvarchar(100);
declare @AttrVal nvarchar(250);

declare @CurrName nvarchar(250);
declare @SkipIfNoChange bit;

--select @form = 'HFit.TrackerWater' ;
select @form = @TrackerClassName ;

select @MetaDataLastLoadDate = (Select top 1 ClassLastModified from Tracker_EDW_Metadata where TableName = @form) ;
select @ClassLastModified = (Select top 1 ClassLastModified from CMS_CLASS where ClassName = @form) ;

set @SkipIfNoChange = 1 ;
if @SkipIfNoChange = 1 BEGIN
	if @MetaDataLastLoadDate = @ClassLastModified BEGIN
		Print ('No Change in ' + @form +', no updates needed.');
		RETURN;
	END
	ELSE BEGIN
		Print ('Changes found in ' + @form +', processing.');
	END
END


print ('@MetaDataLastLoadDate: ' + cast(@MetaDataLastLoadDate as varchar(50))) ;
print ('@ClassLastModified: ' + cast(@ClassLastModified as varchar(50))) ;

SELECT @Xml = (select ClassFormDefinition from CMS_Class where ClassName like @form);
--print (cast( @Xml as varchar(max)));

EXEC sp_xml_preparedocument @docHandle OUTPUT, @Xml;
--alter table [Tracker_EDW_Metadata] add ClassLastModified datetime null
IF NOT EXISTS (SELECT name
		FROM sysobjects
		WHERE ID = OBJECT_ID(N'Tracker_EDW_Metadata'))
	begin
		CREATE TABLE [dbo].[Tracker_EDW_Metadata](
			[TableName] [nvarchar](100) NOT NULL,
			[ColName] [nvarchar](100) NOT NULL,
			[AttrName] [nvarchar](100) NOT NULL,
			[AttrVal] [nvarchar](250) NULL,
			[CreatedDate] [datetime] NULL,
			[LastModifiedDate] [datetime] NULL,
			[ID] [int] IDENTITY(1,1) NOT NULL,
			[ClassLastModified] [datetime] NULL
		)

		ALTER TABLE [dbo].[Tracker_EDW_Metadata] ADD  CONSTRAINT [DF_Tracker_EDW_Metadata_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
		ALTER TABLE [dbo].[Tracker_EDW_Metadata] ADD  CONSTRAINT [DF_Tracker_EDW_Metadata_LastModifiedDate]  DEFAULT (getdate()) FOR [LastModifiedDate]
		
		CREATE UNIQUE CLUSTERED INDEX [PK_Tracker_EDW_Metadata] ON [dbo].[Tracker_EDW_Metadata]
		(
			[TableName] ASC,
			[ColName] ASC,
			[AttrName] ASC
		)
	end

IF NOT EXISTS (SELECT name
		FROM tempdb.dbo.sysobjects
		WHERE ID = OBJECT_ID(N'tempdb..#Temp_TrackerMetaData'))
	begin
	SELECT @form as form,id,parentid,nodetype,localname,prefix,namespaceuri,datatype,prev,[text] 	
	INTO #Temp_TrackerMetaData 
	FROM OPENXML(@docHandle, N'/form/field') as XMLDATA;
	--WHERE localname not in ('isPK');		
	CREATE INDEX TMPPI_HealthAssesmentUserQuestion 
		ON #Temp_TrackerMetaData (parentid);
	CREATE INDEX TMPPI2_HealthAssesmentUserQuestion 
		ON #Temp_TrackerMetaData (id);
	end
	else
	begin
		truncate table #Temp_TrackerMetaData;
		INSERT INTO #Temp_TrackerMetaData
		SELECT @form as form,id,parentid,nodetype,localname,prefix,namespaceuri,datatype,prev,[text]
			FROM OPENXML(@docHandle, N'/form/field') as XMLDATA;	
	end

delete from Tracker_EDW_Metadata where TableName = @form ;

set @ClassLastModified = (Select ClassLastModified from CMS_CLASS where ClassName = @Form);
print ('@ClassLastModified: ' + cast(@ClassLastModified as varchar(250))) ;

declare C cursor FOR 
SELECT @form as form,id,parentid,nodetype,localname,prefix,namespaceuri,datatype,prev,[text] 	
	FROM #Temp_TrackerMetaData as XMLDATA

OPEN C
FETCH NEXT from C 
INTO @dbForm, @id, @parent, @nodetype, @localname, @prefix, @namespaceuri, @datatype, @prev, @dbText ;

WHILE @@FETCH_STATUS = 0   
BEGIN   
	--print ('* @localname :' + @localname) ;
	--print ('* @ColName :' + isnull(@ColName, 'XX') + ':') ;
	--print ('* @dbText :' + @dbText + ':') ;
	
	if @localname = 'column'
	BEGIN
		--print ('** START COLUMN DEF: ') ;
		set @ColName = (select [text] from #Temp_TrackerMetaData where parentid = @id);
		--print ('** COLUMN DEF: ' + @form + ' : ' + @colname) ;
	END

    if @dbText is not null 
	BEGIN	   
	
			--print ('* ENTER @dbText :' + @dbText + ':' + cast(@parent as varchar(10))) ;
			set @AttrName = (select [localname] FROM #Temp_TrackerMetaData where id = @parent) ;
			--set @ParentName = (select [localname] FROM OPENXML(@docHandle, N'/form/field') where id = @parent);	
			--print ('1 - @AttrName: ' + @form +' : ' + isnull(@ColName, 'NA') + ' : ' + @AttrName + ' : ' + @dbText) ;	
			if exists(Select TableName from Tracker_EDW_Metadata Where Tablename = @form and ColName = @ColName and AttrName = @dbText)
			BEGIN				
				--print('Update Tracker_EDW_Metadata set AttrVal = ' + @dbText + ' Where Tablename = ' + @form + ' and ColName = ' + @ColName + ' and AttrName = ' + @AttrName + ';');
				Update Tracker_EDW_Metadata set AttrVal = @dbText, ClassLastModified = @ClassLastModified Where Tablename = @form and ColName = @ColName and AttrName = @dbText;				
			END
			ELSE
			BEGIN
				--print ('insert into Tracker_EDW_Metadata (TableName, ColName, AttrName, AttrVal, ClassLastModified) values ('+@form+', '+@ColName+', '+@AttrName+', '+@dbText +', ' + cast(@ClassLastModified as varchar(50))+ ') ') ;
				insert into Tracker_EDW_Metadata (TableName, ColName, AttrName, AttrVal, ClassLastModified) values (@form, @ColName, @AttrName, @dbText, @ClassLastModified) ;
				Update Tracker_EDW_Metadata set ClassLastModified = @ClassLastModified Where Tablename = @form and ColName = @ColName and AttrName = @dbText;
			END		
	END
	
	   if @localname = 'columntype' and @ColName is not null
	   BEGIN
			print ('---- COLUMN TYPE DEF: ' + @form + ' : ' + @colname + ' : ' + @dbText) ;
	   END
	   if @localname = 'field'
	   BEGIN
			set @ParentName = null ;
			set @ColName = null ;
			--print ('***** field @ParentName: ' + @ParentName) ;
	   END
       FETCH NEXT FROM C INTO @dbForm, @id, @parent, @nodetype, @localname, @prefix, @namespaceuri, @datatype, @prev, @dbText ;   
END   

CLOSE C   
DEALLOCATE C 

--Clean up the EDW Tracker MetaData
--delete from Tracker_EDW_Metadata where colname in ('ItemID','ItemCreatedBy','ItemCreatedWhen','ItemModifiedBy','ItemModifiedWhen','EventDate','IsProfessionally Collected','TrackerCollectionSourceId','UserID','Notes','IsProcessedForHA');


GO



GO

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

GO
--END OF proc_GetRecordCount

 if not exists(select name from sys.indexes where name = 'PI_HFIT_Tracker_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFIT_Tracker_LastUpdate ON [HFit_TrackerFlexibility] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerBloodPressure_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerBloodPressure_LastUpdate ON [HFit_TrackerFlexibility] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerBloodSugarAndGlucose_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerBloodSugarAndGlucose_LastUpdate ON [HFit_TrackerFlexibility] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerBMI_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerBMI_LastUpdate ON [HFit_TrackerFlexibility] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerBodyFat_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerBodyFat_LastUpdate ON [HFit_TrackerFlexibility] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerBodyMeasurements_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerBodyMeasurements_LastUpdate ON [HFit_TrackerFlexibility] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerCardio_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerCardio_LastUpdate ON [HFit_TrackerFlexibility] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerCategory_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerCategory_LastUpdate ON [HFit_TrackerFlexibility] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerCholesterol_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerCholesterol_LastUpdate ON [HFit_TrackerFlexibility] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerCollectionSource_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerCollectionSource_LastUpdate ON [HFit_TrackerFlexibility] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerDailySteps_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerDailySteps_LastUpdate ON [HFit_TrackerFlexibility] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerDef_Item_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerDef_Item_LastUpdate ON [HFit_TrackerFlexibility] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerDef_Tracker_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerDef_Tracker_LastUpdate ON [HFit_TrackerFlexibility] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerDocument_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerDocument_LastUpdate ON [HFit_TrackerFlexibility] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerFlexibility_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerFlexibility_LastUpdate ON [HFit_TrackerFlexibility] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerFruits_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerFruits_LastUpdate ON [HFit_TrackerFlexibility] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerHbA1c_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerHbA1c_LastUpdate ON [HFit_TrackerFlexibility] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerHeight_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerHeight_LastUpdate ON [HFit_TrackerFlexibility] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerHighFatFoods_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerHighFatFoods_LastUpdate ON [HFit_TrackerFlexibility] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerHighSodiumFoods_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerHighSodiumFoods_LastUpdate ON [HFit_TrackerFlexibility] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerInstance_Item_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerInstance_Item_LastUpdate ON [HFit_TrackerFlexibility] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerInstance_Tracker_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerInstance_Tracker_LastUpdate ON [HFit_TrackerFlexibility] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerMealPortions_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerMealPortions_LastUpdate ON [HFit_TrackerFlexibility] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerMedicalCarePlan_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerMedicalCarePlan_LastUpdate ON [HFit_TrackerFlexibility] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerRegularMeals_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerRegularMeals_LastUpdate ON [HFit_TrackerFlexibility] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerRestingHeartRate_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerRestingHeartRate_LastUpdate ON [HFit_TrackerFlexibility] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerShots_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerShots_LastUpdate ON [HFit_TrackerFlexibility] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerSitLess_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerSitLess_LastUpdate ON [HFit_TrackerFlexibility] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerSleepPlan_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerSleepPlan_LastUpdate ON [HFit_TrackerFlexibility] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerStrength_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerStrength_LastUpdate ON [HFit_TrackerFlexibility] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerStress_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerStress_LastUpdate ON [HFit_TrackerFlexibility] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerStressManagement_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerStressManagement_LastUpdate ON [HFit_TrackerFlexibility] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerSugaryDrinks_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerSugaryDrinks_LastUpdate ON [HFit_TrackerFlexibility] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerSugaryFoods_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerSugaryFoods_LastUpdate ON [HFit_TrackerFlexibility] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerSummary_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerSummary_LastUpdate ON [HFit_TrackerFlexibility] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerTests_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerTests_LastUpdate ON [HFit_TrackerFlexibility] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerTobaccoFree_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerTobaccoFree_LastUpdate ON [HFit_TrackerFlexibility] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerVegetables_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerVegetables_LastUpdate ON [HFit_TrackerFlexibility] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerWater_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerWater_LastUpdate ON [HFit_TrackerFlexibility] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerWeight_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerWeight_LastUpdate ON [HFit_TrackerFlexibility] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerWholeGrains_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerWholeGrains_LastUpdate ON [HFit_TrackerFlexibility] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
GO


IF not EXISTS (SELECT job_id FROM msdb.dbo.sysjobs_view WHERE name = N'job_EDW_GenerateMetadata')
BEGIN
	USE [msdb]

	/****** Object:  Job [job_EDW_GenerateMetadata]    Script Date: 8/20/2014 3:10:41 PM ******/
	BEGIN TRANSACTION
	DECLARE @DBNAME nvarchar(100)
	DECLARE @ReturnCode INT
	SELECT @ReturnCode = 0

	--********************************************************************************
	set @DBNAME = 'KenticoCMS_DEV'
	--********************************************************************************

	/****** Object:  JobCategory [[Uncategorized (Local)]]]    Script Date: 8/20/2014 3:10:41 PM ******/
	IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
	BEGIN
	EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
	IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

	END

	DECLARE @jobId BINARY(16)
	EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'job_EDW_GenerateMetadata', 
			@enabled=1, 
			@notify_level_eventlog=0, 
			@notify_level_email=0, 
			@notify_level_netsend=0, 
			@notify_level_page=0, 
			@delete_level=0, 
			@description=N'Generate the metadata for the EDW team for Tracker Data', 
			@category_name=N'[Uncategorized (Local)]', 
			@owner_login_name=N'DMiller', @job_id = @jobId OUTPUT
	IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
	/****** Object:  Step [Extract Kentico Metadata]    Script Date: 8/20/2014 3:10:42 PM ******/
	EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Extract Kentico Metadata', 
			@step_id=1, 
			@cmdexec_success_code=0, 
			@on_success_action=1, 
			@on_success_step_id=0, 
			@on_fail_action=2, 
			@on_fail_step_id=0, 
			@retry_attempts=0, 
			@retry_interval=0, 
			@os_run_priority=0, @subsystem=N'TSQL', 
			@command=N'exec Proc_EDW_GenerateMetadata', 
			@database_name= @DBNAME,
			@flags=0
	IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
	EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
	IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
	EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Extract Metadata Schedule', 
			@enabled=1, 
			@freq_type=4, 
			@freq_interval=1, 
			@freq_subday_type=1, 
			@freq_subday_interval=0, 
			@freq_relative_interval=0, 
			@freq_recurrence_factor=0, 
			@active_start_date=20140820, 
			@active_end_date=99991231, 
			@active_start_time=230000, 
			@active_end_time=235959, 
			@schedule_uid=N'ccba070c-ad61-4dec-8f4c-1e33722b43f6'
	IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
	EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
	IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
	COMMIT TRANSACTION
	GOTO EndSave
	QuitWithRollback:
		IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
	EndSave:

	use KenticoCMS_DEV

END


GO
--select top 100 * from View_EDW_HealthAssesmentQuestions; 
--GO 
--select top 100 * from view_EDW_Participant; 
--GO 
--select top 100 * from view_EDW_HealthAssesmentDeffinitionCustom; 
--GO 
--select top 100 * from view_EDW_RewardsDefinition; 
--GO 
--select top 100 * from view_EDW_ScreeningsFromTrackers; 
--GO 
--select top 100 * from view_EDW_TrackerTests; 
--GO 
--select top 100 * from view_EDW_TrackerShots; 
--GO 
--select top 100 * from view_EDW_CoachingDefinition; 
--GO 
--select top 100 * from view_EDW_HealthAssesmentDeffinition; 
--GO 
--select top 100 * from view_EDW_CoachingDetail; 
--GO 
--select top 100 * from view_EDW_TrackerMetadata; 
--GO 
--select top 100 * from view_EDW_Coaches; 
--GO 
--select top 100 * from view_EDW_ClientCompany; 
--GO 
--select top 100 * from view_EDW_RewardTriggerParameters; 
--GO 
--select top 100 * from view_EDW_HealthAssesmentClientView; 
--GO 
--select top 100 * from view_EDW_RewardAwardDetail; 
--GO 
--select top 100 * from view_EDW_RewardUserDetail; 
--GO 
--select top 100 * from View_EDW_HealthAssesmentAnswers; 
--GO 
--select top 100 * from view_EDW_TrackerCompositeDetails; 
--GO 
--select top 100 * from view_EDW_HealthAssesment; 
--GO 