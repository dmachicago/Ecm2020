--****************************************************************
-- NOTE: THis database name must be changed in THREE places in 
--	this script. Please search and change.
--****************************************************************
use KenticoCMS_ProdStaging
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

		END
GO


--create proc CreateTracker_EDW_Metadata
--as
GO 
print('Creating Tracker_EDW_Metadata');
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
print('Created Tracker_EDW_Metadata');
GO




print ('Creating EDW_HealthAssessment');
GO

if exists (select * from sysobjects where name = 'EDW_HealthAssessment' and Xtype = 'U')
BEGIN
	drop table EDW_HealthAssessment
END

go

if exists(select name from sys.tables where name = 'EDW_HealthAssessment')
BEGIN	
	truncate table EDW_HealthAssessment ;
END
ELSE
BEGIN
	CREATE TABLE [dbo].[EDW_HealthAssessment]
	(
		[UserStartedItemID] [int] NOT NULL,
		[HAQuestionNodeGUID] [uniqueidentifier] NOT NULL,
		[UserID] [bigint] NOT NULL,
		[UserGUID] [uniqueidentifier] NOT NULL,
		[HFitUserMpiNumber] [bigint] NULL,
		[SiteGUID] [uniqueidentifier] NOT NULL,
		[AccountID] [int] NOT NULL,
		[AccountCD] [nvarchar](8) NULL,
		[HAStartedDt] [datetime] NOT NULL,
		[HACompletedDt] [datetime] NULL,
		[UserModuleItemId] [int] NOT NULL,
		[UserModuleCodeName] [nvarchar](100) NOT NULL,
		[HAModuleNodeGUID] [uniqueidentifier] NOT NULL,
		[HAModuleVersionID] [int] NULL,
		[UserRiskCategoryItemID] [int] NOT NULL,
		[UserRiskCategoryCodeName] [nvarchar](100) NOT NULL,
		[HARiskCategoryNodeGUID] [uniqueidentifier] NOT NULL,
		[HARiskCategoryVersionID] [int] NULL,
		[UserRiskAreaItemID] [int] NOT NULL,
		[UserRiskAreaCodeName] [nvarchar](100) NOT NULL,
		[HARiskAreaNodeGUID] [uniqueidentifier] NOT NULL,
		[HARiskAreaVersionID] [int] NULL,
		[UserQuestionItemID] [int] NOT NULL,
		[Title] [nvarchar](max) NOT NULL,
		[UserQuestionCodeName] [nvarchar](100) NOT NULL,
		[HAQuestionVersionID] [int] NULL,
		[UserAnswerItemID] [int] NOT NULL,
		[HAAnswerNodeGUID] [uniqueidentifier] NOT NULL,
		[HAAnswerVersionID] [int] NULL,
		[UserAnswerCodeName] [nvarchar](100) NOT NULL,
		[HAAnswerValue] [nvarchar](255) NULL,
		[HAModuleScore] [float] NOT NULL,
		[HARiskCategoryScore] [float] NULL,
		[HARiskAreaScore] [float] NULL,
		[HAQuestionScore] [float] NULL,
		[HAAnswerPoints] [int] NULL,
		[PointResults] [int] NULL,
		[UOMCode] [nvarchar](10) NULL,
		[HAScore] [int] NULL,
		[ModulePreWeightedScore] [float] NULL,
		[RiskCategoryPreWeightedScore] [float] NULL,
		[RiskAreaPreWeightedScore] [float] NULL,
		[QuestionPreWeightedScore] [float] NULL,
		[QuestionGroupCodeName] [nvarchar](100) NULL,
		[ChangeType] [varchar](1) NOT NULL,
		[IsProfessionallyCollected] bit NULL
				 
	   ,ItemCreatedWhen datetime
       ,ItemModifiedWhen  datetime
	   ,HARiskCategory_ItemModifiedWhen datetime
	   ,HAUserRiskArea_ItemModifiedWhen datetime
	   ,HAUserQuestion_ItemModifiedWhen datetime
	   ,HAUserAnswers_ItemModifiedWhen datetime
	)
END
GO
print ('Created EDW_HealthAssessment');
GO
GO

print ('Creating EDW_HealthAssessmentDefinition');

go 

if exists(select name from sys.tables where name = 'EDW_HealthAssessmentDefinition')
BEGIN	
	drop table EDW_HealthAssessmentDefinition ;
END

go

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

GO

print ('Created EDW_HealthAssessmentDefinition');

GO--DECLARE @ElapsedS INT
--declare @start_date datetime = getdate() ;
--declare @end_date  datetime = getdate() ;
--SET @ElapsedS = DATEDIFF(ms, @start_date, @end_date)
--SELECT TimeSpan = dbo.udfTimeSpanFromMilliSeconds(@ElapsedS)
--go

print ('Creating udfElapsedTime');

if exists (select * from sysobjects where name = 'udfElapsedTime' and type = 'FN')
BEGIN
	drop function udfElapsedTime ;
END 
go

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

print ('Created udfElapsedTime');

GO
--DECLARE @ElapsedS INT
--declare @start_date datetime = getdate() ;
--declare @end_date  datetime = getdate() ;
--SET @ElapsedS = DATEDIFF(ms, @start_date, @end_date)
--SELECT TimeSpan = dbo.udfTimeSpanFromMilliSeconds(@ElapsedS)
--go

print ('Creating udfTimeSpanFromMilliSeconds');
go

if exists (select * from sysobjects where name = 'udfTimeSpanFromMilliSeconds' and type = 'FN')
BEGIN
	drop function udfTimeSpanFromMilliSeconds ;
END 
go

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

print ('Created udfTimeSpanFromMilliSeconds');
go
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




if exists (select * from sysobjects where name = 'UTIL_SearchAllTables' and Xtype = 'P')
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



if exists (select * from sysobjects where name = 'UTIL_ViewAnalysis' and Xtype = 'P')
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
GO

if exists(select name from sys.objects where name = 'UTIL_DisplayBlockingQry' and type = 'P')
BEGIN
	drop procedure UTIL_DisplayBlockingQry ;
END
GO



--*******************************************
--W. Dale Miller
--July 26, 2010
--*******************************************
create proc [dbo].[UTIL_DisplayBlockingQry]
as
SELECT
SYSDB.name DBName,
TLOCK.request_session_id,
TWAIT.blocking_session_id,
OBJECT_NAME(p.OBJECT_ID) BlockedObjectName,
TLOCK.resource_type,
h1.TEXT AS RequestingText,
h2.TEXT AS BlockingTest,
TLOCK.request_mode
FROM sys.dm_tran_locks AS TLOCK
INNER JOIN sys.databases SYSDB ON SYSDB.database_id = TLOCK.resource_database_id
INNER JOIN sys.dm_os_waiting_tasks AS TWAIT ON TLOCK.lock_owner_address = TWAIT.resource_address
INNER JOIN sys.partitions AS p ON p.hobt_id = TLOCK.resource_associated_entity_id
INNER JOIN sys.dm_exec_connections ec1 ON ec1.session_id = TLOCK.request_session_id
INNER JOIN sys.dm_exec_connections ec2 ON ec2.session_id = TWAIT.blocking_session_id
CROSS APPLY sys.dm_exec_sql_text(ec1.most_recent_sql_handle) AS h1
CROSS APPLY sys.dm_exec_sql_text(ec2.most_recent_sql_handle) AS h2

GO



if exists(select TABLE_NAME from INFORMATION_SCHEMA.VIEWS where TABLE_NAME = 'View_EDW_HealthAssesmentQuestions')
BEGIN
	drop view View_EDW_HealthAssesmentQuestions ;
END

GO

CREATE VIEW [dbo].[View_EDW_HealthAssesmentQuestions]

AS 
--WDM 8.8.2014 - Created this view in order to add the DocumentGUID as 
--			required by the EDW team. Was having a bit of push-back
--			from the developers, so created this one in order to 
--			expedite filling the need for runnable views for the EDW.
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
	,VHFHAMCQJ.DocumentID
	,VHFHAMCQJ.DocumentModifiedWhen	--(WDM) 09.11.2014 added to facilitate determining document last mod date 
FROM dbo.View_HFit_HealthAssesmentMultipleChoiceQuestion_Joined AS VHFHAMCQJ WITH(NOLOCK)

UNION ALL SELECT 
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
	,VHFHAMQJ.DocumentID
	,VHFHAMQJ.DocumentModifiedWhen
FROM dbo.View_HFit_HealthAssesmentMatrixQuestion_Joined AS VHFHAMQJ WITH(NOLOCK)

UNION ALL SELECT 
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
	,VHFHAFFJ.DocumentID
	,VHFHAFFJ.DocumentModifiedWhen
FROM dbo.View_HFit_HealthAssessmentFreeForm_Joined AS VHFHAFFJ WITH(NOLOCK)




GO



print ('Creating view_EDW_HFit_HealthAssesmentUserRiskArea') ;
go

if exists (select * from sysobjects where name = 'view_EDW_HFit_HealthAssesmentUserRiskArea' and Xtype = 'V')
BEGIN
	drop view view_EDW_HFit_HealthAssesmentUserRiskArea ;
END 
go

--GRANT SELECT
--	ON [dbo].[view_EDW_HFit_HealthAssesmentUserRiskArea]
--	TO [EDWReader_PRD]
--GO

create view [dbo].[view_EDW_HFit_HealthAssesmentUserRiskArea]
as
--*****************************************************************************
--8.16.2014 (wdm) - This view was created as a stopgap methofd until the 
--			required GUID fields are contained within all tables and 
--			populated correctly. Once those fields are accessable,
--			this view should go awway and the base table use in its place.
--*****************************************************************************
SELECT RISKAREA.[ItemID]
      ,RISKAREA.[UserID]
      ,RISKAREA.[HARiskAreaDocumentID]
      ,RISKAREA.[HARiskAreaVersionID]
      ,RISKAREA.[HARiskAreaWeight]
      ,RISKAREA.[HARiskAreaScore]
      ,RISKAREA.[ItemCreatedBy]
      ,RISKAREA.[ItemCreatedWhen]
      ,RISKAREA.[ItemModifiedBy]
      ,RISKAREA.[ItemModifiedWhen]
      ,RISKAREA.[ItemOrder]
      ,RISKAREA.[ItemGUID]
      ,RISKAREA.[HARiskCategoryDocumentID]
      ,RISKAREA.[HARiskCategoryItemID]
      ,RISKAREA.[CodeName]
      ,RISKAREA.[PreWeightedScore]
    --,CMSTREE2.DocumentGUID AS HARiskAreaNodeGUID	--Mark and Dale USE NODE GUID HERE
	,CMSTREE2.NodeGUID AS HARiskAreaNodeGUID	--Mark and Dale USE NODE GUID HERE
	,CMSTREE2.NodeGUID AS CMSNodeGUID
FROM [dbo].HFit_HealthAssesmentUserRiskArea as RISKAREA
		inner join HFit_HealthAssesmentUserRiskCategory as CAT ON RISKAREA.HARiskCategoryItemID = CAT.[ItemID]
		INNER JOIN CMS_Document AS CMSDOC2 ON RISKAREA.HARiskAreaDocumentID = CMSDOC2.DocumentID 
		INNER JOIN View_CMS_Tree_Joined AS CMSTREE2 ON CMSDOC2.DocumentNodeID = CMSTREE2.NodeID

GO
print ('Creating view_EDW_HFit_HealthAssesmentUserRiskArea') ;
go

if exists(select TABLE_NAME from INFORMATION_SCHEMA.VIEWS where TABLE_NAME = 'view_EDW_ClientCompany')
BEGIN
	drop view view_EDW_ClientCompany ;
END

GO

CREATE VIEW [dbo].[view_EDW_ClientCompany]

AS 
--***********************************************************************************************
-- 09.11.2014 : (wdm) Verified DATES to resolve EDW last mod date issue
--		There is an issue with HFit_Company. There are no insert/update tracking dates.
--***********************************************************************************************
SELECT
    hfa.AccountID
   ,HFA.AccountCD
   ,HFA.AccountName
   ,HFA.ItemGUID AccountGUID
   ,CS.SiteID
   ,CS.SiteGUID
   ,CS.SiteLastModified
   ,HFC.CompanyID
   ,HFC.ParentID
   ,HFC.CompanyName
   ,HFC.CompanyShortName
   ,HFC.CompanyStartDate
   ,HFC.CompanyEndDate
   ,HFC.CompanyStatus
   ,CASE WHEN CAST(hfa.ItemCreatedWhen AS DATE) = CAST(HFA.ItemModifiedWhen AS DATE) THEN 'I' ELSE 'U' END AS ChangeType
   ,HFA.ItemCreatedWhen AccountCreated
   ,HFA.ItemModifiedWhen AccountModified
   ,NULL AS CompanyCreated
   ,NULL AS CompanyModified
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

--***********************************************************************************************
-- 09.11.2014 : (wdm) Verified DATES to resolve EDW last mod date issue
--***********************************************************************************************
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

CREATE VIEW [dbo].[view_EDW_CoachingDefinition]
AS
--***********************************************************************************************
--8/7/2014 - added DocumentGuid 
--8/8/2014 - Generated corrected view in DEV (WDM)
-- 09.11.2014 : (wdm) Verified DATES to resolve EDW last mod date issue
--***********************************************************************************************
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

CREATE VIEW [dbo].[view_EDW_CoachingDetail]
AS
--***********************************************************************************************
-- 08/07/2014 - added and commented out DocumentGuid in case needed later
-- 08/08/2014 - Generated corrected view in DEV (WDM)
-- 09.11.2014 : (wdm) Verified DATES to resolve EDW last mod date issue
--***********************************************************************************************
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
		, GJ.NodeGUID
		, GJ.DocumentGUID	--WDM 8/7/2014 Added in case needed
		, HFUG.ItemCreatedWhen
		, HFUG.ItemModifiedWhen
		, GJ.DocumentModifiedWhen as Goal_DocumentModifiedWhen
	FROM
		dbo.HFit_UserGoal AS HFUG WITH ( NOLOCK )
	INNER JOIN (
					SELECT
						VHFGJ.GoalID
						, VHFGJ.NodeID
						, VHFGJ.NodeGUID
						, VHFGJ.DocumentCulture
						, VHFGJ.DocumentGuid
						, VHFGJ.DocumentModifiedWhen
					FROM
						dbo.View_HFit_Goal_Joined AS VHFGJ WITH ( NOLOCK )
					UNION ALL
					SELECT
						VHFTGJ.GoalID
						, VHFTGJ.NodeID
						, VHFTGJ.NodeGUID
						, VHFTGJ.DocumentCulture
						, VHFTGJ.DocumentGuid
						, VHFTGJ.DocumentModifiedWhen
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
	   ,VHFHAPAJ.DocumentID
	   ,VHFHAPAJ.DocumentModifiedWhen
      FROM
        dbo.View_HFit_HealthAssesmentPredefinedAnswer_Joined AS VHFHAPAJ WITH(NOLOCK)



GO



if exists(select TABLE_NAME from INFORMATION_SCHEMA.VIEWS where TABLE_NAME = 'view_EDW_HealthAssesmentClientView')
BEGIN
	drop view view_EDW_HealthAssesmentClientView ;
END

GO

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
									--END ) = HAJoined.DocumentID
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


--select top 100 * from [view_EDW_HealthAssesmentDeffinition] where DocumentModifiedWhen between '2013-11-14 00:00:00.000' and '2013-11-15 00:00:00.000'

CREATE VIEW [dbo].[view_EDW_HealthAssesmentDeffinition] 
AS
--**************************************************************************************************************
--NOTE: The column DocumentModifiedWhen comes from the CMS_TREE join - it was left 
--		unchanged when other dates added for the Last Mod Date additions. 
--		Therefore, the 'ChangeType' was left dependent upon this date only. 09.12.2014 (wdm)
--**************************************************************************************************************
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
--				Had to add a DISTINCT to all the queries - .
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
--08/12/2014 - Removed the DocumentID by direction of going to GUIDS - (commented them out just in case) 
--08/12/2014 - DEV 00:00:58 @ 3792
--09/10/2014 - John and I put the Document IDs back in the view. We need GUID and DocumentID for this load.
--09.11.2014 - (wdm) added the needed date fields to help EDW in determining the last mod date of a row.
--*********************************************************************************************************************

	SELECT distinct
		NULL as SiteGUID --cs.SiteGUID		--WDM 08.12.2014
		, NULL as AccountCD	 --, HFA.AccountCD												--WDM 08.07.2014
		, HA.NodeID AS HANodeID										--WDM 08.07.2014
		, HA.NodeName AS HANodeName									--WDM 08.07.2014
		, HA.DocumentID AS HADocumentID								--WDM 08.07.2014
		, HA.NodeSiteID AS HANodeSiteID								--WDM 08.07.2014
		, HA.DocumentPublishedVersionHistoryID AS HADocPubVerID		--WDM 08.07.2014
		, VHFHAMJ.Title AS ModTitle
		--Per EDW Team, HTML text is truncated to 4000 bytes - we'll just do it here
		, dbo.udf_StripHTML(left(VHFHAMJ.IntroText,4000)) AS IntroText
		, VHFHAMJ.DocumentGuid AS ModDocGuid	
		, VHFHAMJ.DocumentID AS ModDocID	--WDM 08.07.2014
		
		, VHFHAMJ.Weight AS ModWeight
		, VHFHAMJ.IsEnabled AS ModIsEnabled
		, VHFHAMJ.CodeName AS ModCodeName
		, VHFHAMJ.DocumentPublishedVersionHistoryID AS ModDocPubVerID
		, VHFHARCJ.Title AS RCTitle
		, VHFHARCJ.Weight AS RCWeight
		, VHFHARCJ.DocumentGuid AS RCDocumentGUID	
		, VHFHARCJ.DocumentID AS RCDocumentID	--WDM 08.07.2014
		
		, VHFHARCJ.IsEnabled AS RCIsEnabled
		, VHFHARCJ.CodeName AS RCCodeName
		, VHFHARCJ.DocumentPublishedVersionHistoryID AS RCDocPubVerID
		, VHFHARAJ.Title AS RATytle
		, VHFHARAJ.Weight AS RAWeight
		, VHFHARAJ.DocumentGuid AS RADocumentGuid	
		, VHFHARAJ.DocumentID AS RADocumentID	--WDM 08.07.2014
		
		, VHFHARAJ.IsEnabled AS RAIsEnabled
		, VHFHARAJ.CodeName AS RACodeName
		, VHFHARAJ.ScoringStrategyID AS RAScoringStrategyID
		, VHFHARAJ.DocumentPublishedVersionHistoryID AS RADocPubVerID
		, VHFHAQ.QuestionType
		, dbo.udf_StripHTML(left(VHFHAQ.Title,4000)) AS QuesTitle
		, VHFHAQ.Weight AS QuesWeight
		, VHFHAQ.IsRequired AS QuesIsRequired

		, VHFHAQ.DocumentGuid AS QuesDocumentGuid	
		, VHFHAQ.DocumentID AS QuesDocumentID	--WDM 08.07.2014
		
		, VHFHAQ.IsEnabled AS QuesIsEnabled
		, left(VHFHAQ.IsVisible,4000) AS QuesIsVisible
		, VHFHAQ.IsStaging AS QuesIsSTaging
		, VHFHAQ.CodeName AS QuestionCodeName
		, VHFHAQ.DocumentPublishedVersionHistoryID AS QuesDocPubVerID
		, VHFHAA.Value AS AnsValue
		, VHFHAA.Points AS AnsPoints
		
		, VHFHAA.DocumentGuid AS AnsDocumentGuid	
		, VHFHAA.DocumentID AS AnsDocumentID	--WDM 08.07.2014
		
		, VHFHAA.IsEnabled AS AnsIsEnabled
		, VHFHAA.CodeName AS AnsCodeName
		, VHFHAA.UOM AS AnsUOM
		, VHFHAA.DocumentPublishedVersionHistoryID AS AnsDocPUbVerID
		, CASE	
			WHEN CAST(VCTJ.DocumentCreatedWhen AS DATE) = CAST(vctj.DocumentModifiedWhen AS DATE)
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
		NULL as SiteGUID		--cs.SiteGUID		--WDM 08.12.2014 (see note above)
		, NULL as AccountCD		--, HFA.AccountCD	--WDM 08.07.2014 (see note above)
		, HA.NodeID				--WDM 08.07.2014
		, HA.NodeName			--WDM 08.07.2014
		, HA.DocumentID			--WDM 08.07.2014
		, HA.NodeSiteID			--WDM 08.07.2014
       --,VCTJ.NodeAliasPath
		, HA.DocumentPublishedVersionHistoryID		--WDM 08.07.2014
		, VHFHAMJ.Title
		, dbo.udf_StripHTML(left(left(VHFHAMJ.IntroText,4000),4000)) AS IntroText
		, VHFHAMJ.DocumentGUID
		, VHFHAA.DocumentID AS ModuleDocumentID	--WDM 08.07.2014

		, VHFHAMJ.Weight
		, VHFHAMJ.IsEnabled
		, VHFHAMJ.CodeName
       --,VHFHAMJ.NodeAliasPath
		, VHFHAMJ.DocumentPublishedVersionHistoryID
		, VHFHARCJ.Title
		, VHFHARCJ.Weight
		, VHFHARCJ.DocumentGUID
		, VHFHAA.DocumentID AS RiskCategoryDocumentID	--WDM 08.07.2014

		, VHFHARCJ.IsEnabled
		, VHFHARCJ.CodeName
       --,VHFHARCJ.NodeAliasPath
		, VHFHARCJ.DocumentPublishedVersionHistoryID
		, VHFHARAJ.Title
		, VHFHARAJ.Weight
		, VHFHARAJ.DocumentGUID
		, VHFHAA.DocumentID AS RiskAreaDocumentID	--WDM 08.07.2014

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
		, VHFHAQ2.DocumentID AS VHFHAQ2DocumentID	--WDM 08.07.2014

		, VHFHAQ2.IsEnabled
		, left(VHFHAQ2.IsVisible,4000)
		, VHFHAQ2.IsStaging
		, VHFHAQ2.CodeName AS QuestionCodeName
       --,VHFHAQ2.NodeAliasPath
		, VHFHAQ2.DocumentPublishedVersionHistoryID
		, VHFHAA2.Value
		, VHFHAA2.Points
		, VHFHAA2.DocumentGUID
		, VHFHAA2.DocumentID AS VHFHAA2DocumentID	--WDM 08.07.2014

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
		, VHFHAMJ.DocumentID AS VHFHAMJDocumentID	--WDM 08.07.2014

		, VHFHAMJ.Weight
		, VHFHAMJ.IsEnabled
		, VHFHAMJ.CodeName
       --,VHFHAMJ.NodeAliasPath
		, VHFHAMJ.DocumentPublishedVersionHistoryID
		, VHFHARCJ.Title
		, VHFHARCJ.Weight
		, VHFHARCJ.DocumentGUID
		, VHFHARCJ.DocumentID AS VHFHARCJDocumentID	--WDM 08.07.2014

		, VHFHARCJ.IsEnabled
		, VHFHARCJ.CodeName
       --,VHFHARCJ.NodeAliasPath
		, VHFHARCJ.DocumentPublishedVersionHistoryID
		, VHFHARAJ.Title
		, VHFHARAJ.Weight
		, VHFHARAJ.DocumentGUID
		, VHFHARAJ.DocumentID AS VHFHARAJDocumentID	--WDM 08.07.2014

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
		, VHFHAQ3.DocumentID AS VHFHAQ3DocumentID	--WDM 08.07.2014

		, VHFHAQ3.IsEnabled
		, left(VHFHAQ3.IsVisible,4000)
		, VHFHAQ3.IsStaging
		, VHFHAQ3.CodeName AS QuestionCodeName
       --,VHFHAQ3.NodeAliasPath
		, VHFHAQ3.DocumentPublishedVersionHistoryID
		, VHFHAA3.Value
		, VHFHAA3.Points
		, VHFHAA3.DocumentGUID
		, VHFHAA3.DocumentID AS VHFHAA3DocumentID	--WDM 08.07.2014

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
		, VHFHAMJ.DocumentID AS VHFHAMJDocumentID	--WDM 08.07.2014

		, VHFHAMJ.Weight
		, VHFHAMJ.IsEnabled
		, VHFHAMJ.CodeName
       --,VHFHAMJ.NodeAliasPath
		, VHFHAMJ.DocumentPublishedVersionHistoryID
		, VHFHARCJ.Title
		, VHFHARCJ.Weight
		, VHFHARCJ.DocumentGUID
		, VHFHARCJ.DocumentID AS VHFHARCJDocumentID	--WDM 08.07.2014

		, VHFHARCJ.IsEnabled
		, VHFHARCJ.CodeName
       --,VHFHARCJ.NodeAliasPath
		, VHFHARCJ.DocumentPublishedVersionHistoryID
		, VHFHARAJ.Title
		, VHFHARAJ.Weight
		, VHFHARAJ.DocumentGUID
		, VHFHARAJ.DocumentID AS VHFHARAJDocumentID	--WDM 08.07.2014

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
		, VHFHAQ7.DocumentID AS VHFHAQ7DocumentID	--WDM 08.07.2014

		, VHFHAQ7.IsEnabled
		, left(VHFHAQ7.IsVisible,4000)
		, VHFHAQ7.IsStaging
		, VHFHAQ7.CodeName AS QuestionCodeName
       --,VHFHAQ7.NodeAliasPath
		, VHFHAQ7.DocumentPublishedVersionHistoryID
		, VHFHAA7.Value
		, VHFHAA7.Points
		, VHFHAA7.DocumentGUID
		, VHFHAA7.DocumentID AS VHFHAA7DocumentID	--WDM 08.07.2014

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
		, VHFHAMJ.DocumentID AS VHFHAMJDocumentID	--WDM 08.07.2014

		, VHFHAMJ.Weight
		, VHFHAMJ.IsEnabled
		, VHFHAMJ.CodeName
       --,VHFHAMJ.NodeAliasPath
		, VHFHAMJ.DocumentPublishedVersionHistoryID
		, VHFHARCJ.Title
		, VHFHARCJ.Weight
		, VHFHARCJ.DocumentGUID
		, VHFHARCJ.DocumentID AS VHFHARCJDocumentID	--WDM 08.07.2014

		, VHFHARCJ.IsEnabled
		, VHFHARCJ.CodeName
       --,VHFHARCJ.NodeAliasPath
		, VHFHARCJ.DocumentPublishedVersionHistoryID
		, VHFHARAJ.Title
		, VHFHARAJ.Weight
		, VHFHARAJ.DocumentGUID
		, VHFHARAJ.DocumentID AS VHFHARAJDocumentID	--WDM 08.07.2014

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
		, VHFHAQ8.DocumentID AS VHFHAQ8DocumentID	--WDM 08.07.2014

		, VHFHAQ8.IsEnabled
		, left(VHFHAQ8.IsVisible,4000)
		, VHFHAQ8.IsStaging
		, VHFHAQ8.CodeName AS QuestionCodeName
       --,VHFHAQ8.NodeAliasPath
		, VHFHAQ8.DocumentPublishedVersionHistoryID
		, VHFHAA8.Value
		, VHFHAA8.Points
		, VHFHAA8.DocumentGUID
		, VHFHAA8.DocumentID AS VHFHAA8DocumentID	--WDM 08.07.2014

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
		, VHFHAMJ.DocumentID AS VHFHAMJDocumentID	--WDM 08.07.2014

		, VHFHAMJ.Weight
		, VHFHAMJ.IsEnabled
		, VHFHAMJ.CodeName
       --,VHFHAMJ.NodeAliasPath
		, VHFHAMJ.DocumentPublishedVersionHistoryID
		, VHFHARCJ.Title
		, VHFHARCJ.Weight
		, VHFHARCJ.DocumentGUID
		, VHFHARCJ.DocumentID AS VHFHARCJDocumentID	--WDM 08.07.2014

		, VHFHARCJ.IsEnabled
		, VHFHARCJ.CodeName
       --,VHFHARCJ.NodeAliasPath
		, VHFHARCJ.DocumentPublishedVersionHistoryID
		, VHFHARAJ.Title
		, VHFHARAJ.Weight
		, VHFHARAJ.DocumentGUID
		, VHFHARAJ.DocumentID AS VHFHARAJDocumentID	--WDM 08.07.2014

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
		, VHFHAQ4.DocumentID AS VHFHAQ4DocumentID	--WDM 08.07.2014

		, VHFHAQ4.IsEnabled
		, left(VHFHAQ4.IsVisible,4000)
		, VHFHAQ4.IsStaging
		, VHFHAQ4.CodeName AS QuestionCodeName
       --,VHFHAQ4.NodeAliasPath
		, VHFHAQ4.DocumentPublishedVersionHistoryID
		, VHFHAA4.Value
		, VHFHAA4.Points
		, VHFHAA4.DocumentGUID
		, VHFHAA4.DocumentID AS VHFHAA4DocumentID	--WDM 08.07.2014

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
		, VHFHAMJ.DocumentID AS VHFHAMJDocumentID	--WDM 08.07.2014

		, VHFHAMJ.Weight
		, VHFHAMJ.IsEnabled
		, VHFHAMJ.CodeName
       --,VHFHAMJ.NodeAliasPath
		, VHFHAMJ.DocumentPublishedVersionHistoryID
		, VHFHARCJ.Title
		, VHFHARCJ.Weight
		, VHFHARCJ.DocumentGUID
		, VHFHARCJ.DocumentID AS VHFHARCJDocumentID	--WDM 08.07.2014

		, VHFHARCJ.IsEnabled
		, VHFHARCJ.CodeName
       --,VHFHARCJ.NodeAliasPath
		, VHFHARCJ.DocumentPublishedVersionHistoryID
		, VHFHARAJ.Title
		, VHFHARAJ.Weight
		, VHFHARAJ.DocumentGUID
		, VHFHARAJ.DocumentID AS VHFHARAJDocumentID	--WDM 08.07.2014

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
		, VHFHAQ5.DocumentID AS VHFHAQ5DocumentID	--WDM 08.07.2014

		, VHFHAQ5.IsEnabled
		, left(VHFHAQ5.IsVisible,4000)
		, VHFHAQ5.IsStaging
		, VHFHAQ5.CodeName AS QuestionCodeName
       --,VHFHAQ5.NodeAliasPath
		, VHFHAQ5.DocumentPublishedVersionHistoryID
		, VHFHAA5.Value
		, VHFHAA5.Points
		, VHFHAA5.DocumentGUID
		, VHFHAA5.DocumentID AS VHFHAA5DocumentID	--WDM 08.07.2014

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
		, VHFHAMJ.DocumentID AS VHFHAMJDocumentID	--WDM 08.07.2014

		, VHFHAMJ.Weight
		, VHFHAMJ.IsEnabled
		, VHFHAMJ.CodeName
       --,VHFHAMJ.NodeAliasPath
		, VHFHAMJ.DocumentPublishedVersionHistoryID
		, VHFHARCJ.Title
		, VHFHARCJ.Weight
		, VHFHARCJ.DocumentGUID
		, VHFHARCJ.DocumentID AS VHFHARCJDocumentID	--WDM 08.07.2014

		, VHFHARCJ.IsEnabled
		, VHFHARCJ.CodeName
       --,VHFHARCJ.NodeAliasPath
		, VHFHARCJ.DocumentPublishedVersionHistoryID
		, VHFHARAJ.Title
		, VHFHARAJ.Weight
		, VHFHARAJ.DocumentGUID
		, VHFHARAJ.DocumentID AS VHFHARAJDocumentID	--WDM 08.07.2014

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
		, VHFHAQ6.DocumentID AS VHFHAQ6DocumentID	--WDM 08.07.2014

		, VHFHAQ6.IsEnabled
		, left(VHFHAQ6.IsVisible,4000)
		, VHFHAQ6.IsStaging
		, VHFHAQ6.CodeName AS QuestionCodeName
       --,VHFHAQ6.NodeAliasPath
		, VHFHAQ6.DocumentPublishedVersionHistoryID
		, VHFHAA6.Value
		, VHFHAA6.Points
		, VHFHAA6.DocumentGUID
		, VHFHAA6.DocumentID AS VHFHAA6DocumentID	--WDM 08.07.2014

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
		, VHFHAMJ.DocumentID AS VHFHAMJDocumentID	--WDM 08.07.2014

		, VHFHAMJ.Weight
		, VHFHAMJ.IsEnabled
		, VHFHAMJ.CodeName
       --,VHFHAMJ.NodeAliasPath
		, VHFHAMJ.DocumentPublishedVersionHistoryID
		, VHFHARCJ.Title
		, VHFHARCJ.Weight
		, VHFHARCJ.DocumentGUID
		, VHFHARCJ.DocumentID AS VHFHARCJDocumentID	--WDM 08.07.2014

		, VHFHARCJ.IsEnabled
		, VHFHARCJ.CodeName
       --,VHFHARCJ.NodeAliasPath
		, VHFHARCJ.DocumentPublishedVersionHistoryID
		, VHFHARAJ.Title
		, VHFHARAJ.Weight
		, VHFHARAJ.DocumentGUID
		, VHFHARAJ.DocumentID AS VHFHARAJDocumentID	--WDM 08.07.2014

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
		, VHFHAQ9.DocumentID AS VHFHAQ9DocumentID	--WDM 08.07.2014

		, VHFHAQ9.IsEnabled
		, left(VHFHAQ9.IsVisible,4000)
		, VHFHAQ9.IsStaging
		, VHFHAQ9.CodeName AS QuestionCodeName
       --,VHFHAQ9.NodeAliasPath
		, VHFHAQ9.DocumentPublishedVersionHistoryID
		, VHFHAA9.Value
		, VHFHAA9.Points
		, VHFHAA9.DocumentGUID
		, VHFHAA9.DocumentID AS VHFHAA9DocumentID	--WDM 08.07.2014

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

--***********************************************************************************************
-- 09.11.2014 : (wdm) Verified DATES to resolve EDW last mod date issue
--***********************************************************************************************

CREATE VIEW [dbo].[view_EDW_HealthAssesmentDeffinitionCustom]
AS
	--8/8/2014 - DocGUID changes, NodeGuid
	--8/8/2014 - Generated corrected view in DEV
	--8/10/2014 - added WHERE to limit to English language
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
print ('Creating view_EDW_HFit_HealthAssesmentUserAnswers');
go

if exists (select * from sysobjects where name = 'view_EDW_HFit_HealthAssesmentUserAnswers' and Xtype = 'V')
BEGIN
	drop view view_EDW_HFit_HealthAssesmentUserAnswers ;
END 
go

--GRANT SELECT
--	ON [dbo].[view_EDW_HFit_HealthAssesmentUserAnswers]
--	TO [EDWReader_PRD]
--GO


create view view_EDW_HFit_HealthAssesmentUserAnswers
as
--*****************************************************************************
--8.16.2014 (wdm) - This view was created as a stopgap methofd until the 
--			required GUID fields are contained within all tables and 
--			populated correctly. Once those fields are accessable,
--			this view should go awway and the base table use in its place.
--*****************************************************************************
SELECT [ItemID]
      ,[UserID]
      ,[HAAnswerDocumentID]
      ,[HAAnswerVersionID]
      ,[HAAnswerPoints]
      ,[ItemCreatedBy]
      ,[ItemCreatedWhen]
      ,[ItemModifiedBy]
      ,[ItemModifiedWhen]
      ,[ItemOrder]
      ,[ItemGUID]
      ,[HAAnswerValue]
      ,[HAQuestionDocumentID]
      ,[HAQuestionItemID]
      ,[UOMCode]
      ,[CodeName]
	  --,CMSTREE2.DocumentGUID as HAAnswerNodeGUID	--Mark and Dale USE NODE GUID HERE
	  ,CMSTREE2.NodeGuid as HAAnswerNodeGUID	--Mark and Dale USE NODE GUID HERE
	  ,CMSTREE2.NodeGuid as CMSNodeGUID
FROM [dbo].[HFit_HealthAssesmentUserAnswers] as UserAnswers
inner join cms_document CMSDOC3 on UserAnswers.HAAnswerDocumentID = CMSDOC3.DocumentID
inner join View_CMS_Tree_Joined CMSTREE2 on CMSDOC3.DocumentNodeID = CMSTREE2.NodeID

GO
print ('Created view_EDW_HFit_HealthAssesmentUserAnswers');
go

print ('Creating view_EDW_HFit_HealthAssesmentUserModule');
go

if exists (select * from sysobjects where name = 'view_EDW_HFit_HealthAssesmentUserModule' and Xtype = 'V')
BEGIN
	drop view view_EDW_HFit_HealthAssesmentUserModule ;
END 
go

--GRANT SELECT
--	ON [dbo].[view_EDW_HFit_HealthAssesmentUserModule]
--	TO [EDWReader_PRD]
--GO
create view [dbo].[view_EDW_HFit_HealthAssesmentUserModule]
as
--*****************************************************************************
--8.16.2014 (wdm) - This view was created as a stopgap methofd until the 
--			required GUID fields are contained within all tables and 
--			populated correctly. Once those fields are accessable,
--			this view should go awway and the base table use in its place.
--*****************************************************************************
SELECT [ItemID]
      ,[UserID]
      ,[HAModuleDocumentID]
      ,[HAModuleVersionID]
      ,[HAModuleWeight]
      ,[ItemCreatedBy]
      ,[ItemCreatedWhen]
      ,[ItemModifiedBy]
      ,[ItemModifiedWhen]
      ,[ItemOrder]
      ,[ItemGUID]
      ,[HAModuleScore]
      ,[HADocumentID]
      ,[HAStartedItemID]
      ,[CodeName]
      ,[PreWeightedScore]	  
	  --,CMSTREE2.DocumentGUID as HAModuleNodeGUID	--WDM 09.16.2014	--MARK and DALE use NodeGUID here  
	  ,CMSTREE2.NodeGuid as HAModuleNodeGUID		--WDM 09.16.2014	--MARK and DALE use NodeGUID here  
	  ,CMSTREE2.NodeGuid as CMSNodeGUID				--WDM 09.16.2014	
from	HFit_HealthAssesmentUserModule USERMOD
inner join cms_document CMSDOC3 on USERMOD.HAModuleDocumentID = CMSDOC3.DocumentID
inner join View_CMS_Tree_Joined CMSTREE2 on CMSDOC3.DocumentNodeID = CMSTREE2.NodeID
GO

print ('Created view_EDW_HFit_HealthAssesmentUserModule');
go


if exists (select * from sysobjects where name = 'view_EDW_HFit_HealthAssesmentUserQuestion' and Xtype = 'V')
BEGIN
	drop view view_EDW_HFit_HealthAssesmentUserQuestion ;
END 
go

--GRANT SELECT
--	ON [dbo].[view_EDW_HFit_HealthAssesmentUserQuestion]
--	TO [EDWReader_PRD]
--GO

--select * from HFit_HealthAssesmentUserQuestion
--select * from view_EDW_HFit_HealthAssesmentUserQuestion
create view view_EDW_HFit_HealthAssesmentUserQuestion
as
--*********************************************************************************
--8/18/2014 (WDM)
--This VIEW was created to overcome the table GUID columns that are presemt in DEV 
--and missing in the other environments. It will not be needed when DEV is promoted
--to the other environments.
--*********************************************************************************
SELECT [ItemID]
      ,[UserID]
      ,[HAQuestionDocumentID]
      ,[HAQuestionVersionID]
      ,[HAQuestionWeight]
      ,[HAQuestionScore]
      ,[ItemCreatedBy]
      ,[ItemCreatedWhen]
      ,[ItemModifiedBy]
      ,[ItemModifiedWhen]
      ,[ItemOrder]
      ,[ItemGUID]
      ,[HARiskAreaDocumentID]
      ,[HARiskAreaItemID]
      ,[CodeName]
      ,[PreWeightedScore]
      ,[IsProfessionallyCollected]
      ,[ProfessionallyCollectedEventDate]
	  --,CMSTREE1.DocumentGUID AS HAQuestionNodeGUID	--MARK and DALE use NodeGUID here  
	  ,CMSTREE1.NodeGUID AS HAQuestionNodeGUID	--MARK and DALE use NodeGUID here  
	  ,CMSTREE1.NodeGUID AS CMSNodeGUID
  FROM [dbo].[HFit_HealthAssesmentUserQuestion] AS USERQUES 
  --SELECT distinct CMSTREE1.NodeGUID AS HAQuestionNodeGUID, CMSDOC1.DocumentID, CMSDOC1.DocumentNodeID
--FROM     HFit_HealthAssesmentUserQuestion AS USERQUES 
		INNER JOIN CMS_Document AS CMSDOC1 ON USERQUES.HAQuestionDocumentID = CMSDOC1.DocumentID 
		INNER JOIN View_CMS_Tree_Joined AS CMSTREE1 ON CMSDOC1.DocumentNodeID = CMSTREE1.NodeID 
GO



if exists (select * from sysobjects where name = 'view_EDW_HFit_HealthAssesmentUserRiskCategory' and Xtype = 'V')
BEGIN
	drop view view_EDW_HFit_HealthAssesmentUserRiskCategory ;
END 
go

--GRANT SELECT
--	ON [dbo].[view_EDW_HFit_HealthAssesmentUserRiskCategory]
--	TO [EDWReader_PRD]
--GO

create view [dbo].[view_EDW_HFit_HealthAssesmentUserRiskCategory]
as
SELECT [ItemID]
      ,[ItemCreatedBy]
      ,[ItemCreatedWhen]
      ,[ItemModifiedBy]
      ,[ItemModifiedWhen]
      ,[ItemOrder]
      ,[ItemGUID]
      ,[UserID]
      ,[HARiskCategoryDocumentID]
      ,[HARiskCategoryVersionID]
      ,[HARiskCategoryWeight]
      ,[HARiskCategoryScore]
      ,[HAModuleDocumentID]
      ,[HAModuleItemID]
      ,[CodeName]
      ,[PreWeightedScore]
	  --,CMSTREE2.DocumentGuid as HARiskCategoryNodeGUID	--MARK and DALE use NodeGUID here  
	  ,CMSTREE2.NodeGuid as HARiskCategoryNodeGUID	--MARK and DALE use NodeGUID here  
	  ,CMSTREE2.NodeGuid as CMSNodeGUID
from	HFit_HealthAssesmentUserRiskCategory RISKCAT
inner join cms_document CMSDOC3 on RISKCAT.HARiskCategoryDocumentID = CMSDOC3.DocumentID
inner join View_CMS_Tree_Joined CMSTREE2 on CMSDOC3.DocumentNodeID = CMSTREE2.NodeID


GO


/*
alter table HFit_HealthAssesmentUserStarted add HADateReceived datetime null 
go
alter table HFit_HealthAssesmentUserStarted add HSFulfillmentCulture nvarchar(10) null 
GO
alter table HFit_HealthAssesmentUserStarted add HATelephonicFlg bit not null default 1
GO

alter table HFit_HealthAssesmentUserStarted drop column HADateReceived 
go
alter table HFit_HealthAssesmentUserStarted drop column HSFulfillmentCulture 
GO
alter table HFit_HealthAssesmentUserStarted drop column HATelephonicFlg
GO
*/



--GRANT SELECT
--	ON [dbo].[view_EDW_HFit_HealthAssesmentUserStarted]
--	TO [EDWReader_PRD]
--GO


if exists (select * from sysobjects where name = 'view_EDW_HFit_HealthAssesmentUserStarted' and Xtype = 'V')
BEGIN
	drop view view_EDW_HFit_HealthAssesmentUserStarted ;
END 
go


create view view_EDW_HFit_HealthAssesmentUserStarted
as
--*****************************************************************************
--8.16.2014 (wdm) - This view was created as a stopgap method until the 
--			required GUID fields are contained within all tables and 
--			populated correctly. Once those fields are accessable,
--			this view should go awway and the base table use in its place.
--*****************************************************************************
SELECT [ItemID]
      ,[UserID]
      ,[HADocumentID]
      ,[HAVersionID]
      ,[HAPaperFlg]
      ,[ItemCreatedBy]
      ,[ItemCreatedWhen]
      ,[ItemModifiedBy]
      ,[ItemModifiedWhen]
      ,[ItemOrder]
      ,[ItemGUID]
      ,[HAIPadFlg]
      ,[HAStartedDt]
      ,[HACompletedDt]
      ,[HALastDocumentID]
      ,[HALastVersionID]
      ,[HAScore]
      ,[HALastSectionCompleted]
      ,[HADocumentConfigID]
      ,[HACampaignNodeGUID]
      ,[HADateReceived]
      ,[HSFulfillmentCulture]
      ,[HATelephonicFlg]	  
	  ,CMS_DOCUMENT.DocumentGUID as HealthAssesmentUserStartedDocGUID	--MARK and DALE chose not to use NodeGUID here  
	  ,CMSTREE2.NodeGUID as HealthAssesmentUserStartedNodeGUID
  FROM [dbo].[HFit_HealthAssesmentUserStarted] 
  join CMS_DOCUMENT on CMS_DOCUMENT.DocumentID = [HFit_HealthAssesmentUserStarted].[HADocumentID]
  INNER JOIN View_CMS_Tree_Joined AS CMSTREE2 ON CMS_DOCUMENT.DocumentNodeID = CMSTREE2.NodeID
GO

if exists(select TABLE_NAME from INFORMATION_SCHEMA.VIEWS where TABLE_NAME = 'view_EDW_Participant')
BEGIN
	drop view view_EDW_Participant ;
END

GO


--***********************************************************************************************
-- 09.11.2014 : (wdm) Verified DATES to resolve EDW last mod date issue
--***********************************************************************************************
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

--***********************************************************************************************
-- 09.11.2014 : (wdm) Verified DATES to resolve EDW last mod date issue
--***********************************************************************************************
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


create VIEW [dbo].[view_EDW_RewardsDefinition]
AS
--***********************************************************************************************
-- 09.11.2014 : (wdm) Verified DATES to resolve EDW last mod date issue
--***********************************************************************************************
--WDM Reviewed 8/6/2014 for needed updates, may be needed
--	My question - Is NodeGUID going to be passed onto the children
--8/7/2014 - added and commented out DocumentGuid in case needed later
--8/8/2014 - Generated corrected view in DEV (WDM)
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
		, VHFRPJ.DocumentCreatedWhen
		, VHFRPJ.DocumentModifiedWhen
		, VHFRPJ.DocumentGuid	--WDM Added 8/7/2014 in case needed

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
if exists(select TABLE_NAME from INFORMATION_SCHEMA.VIEWS where TABLE_NAME = 'view_EDW_RewardTriggerParameters')
BEGIN
	drop view view_EDW_RewardTriggerParameters ;
END

GO

create VIEW [dbo].[view_EDW_RewardTriggerParameters]
AS
--***********************************************************************************************
--8/7/2014 - added and commented out DocumentGuid and NodeGuid in case needed later
--8/8/2014 - Generated corrected view in DEV (WDM)
-- 09.11.2014 : (wdm) Verified DATES to resolve EDW last mod date issue
--***********************************************************************************************
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


--exec proc_EDW_RewardUserDetail '08/08/2000','08/08/2014', 'Y'
CREATE VIEW [dbo].[view_EDW_RewardUserDetail]
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
	--*** ALTERNATIVE: exec proc_EDW_RewardUserDetail '08/08/2000','08/08/2014', 'Y'
	--		Runs in 1:19 @ 236,913 rows in PS
	--********************************************************************************************************************
	--*** Performance Tunes
	--ALTER TABLE [dbo].[CMS_UserSettings] DROP CONSTRAINT [PK_CMS_UserSettings]
	--GO
	--ALTER TABLE [dbo].[CMS_UserSettings] ADD  CONSTRAINT [PK_CMS_UserSettings] PRIMARY KEY CLUSTERED 
	--([UserSettingsID] ASC, HFitUserMpiNumber ASC)
	--GO
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
		--, HFRE.ItemModifiedWhen AS RewardExceptionModifiedDate
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
		, VHFRPJ.NodeGuid		--WDM added 8/7/2014 in case needed

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

--***********************************************************************************************
-- 09.11.2014 : (wdm) Verified DATES to resolve EDW last mod date issue
--***********************************************************************************************
CREATE View [dbo].[view_EDW_ScreeningsFromTrackers]

AS

SELECT DISTINCT
	t.userid
	, t.EventDate
	, t.TrackerCollectionSourceID
	, t.ItemCreatedBy
	, t.ItemCreatedWhen
	, t.ItemModifiedBy
	, t.ItemModifiedWhen
FROM
	(
		SELECT DISTINCT
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
		SELECT DISTINCT
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
		SELECT DISTINCT
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
		SELECT DISTINCT
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
		SELECT DISTINCT
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
		SELECT DISTINCT
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
		SELECT DISTINCT
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
		SELECT DISTINCT
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
		SELECT DISTINCT
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
		SELECT DISTINCT
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
		SELECT DISTINCT
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
		sELECT  DISTINCT
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
		sELECT  DISTINCT
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
		sELECT  DISTINCT
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
		sELECT  DISTINCT
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
		sELECT  DISTINCT
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
		sELECT  DISTINCT
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
		sELECT  DISTINCT
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
		sELECT  DISTINCT
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
		sELECT  DISTINCT
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
		sELECT  DISTINCT
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
		sELECT  DISTINCT
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
		sELECT  DISTINCT
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
		sELECT  DISTINCT
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
		sELECT  DISTINCT
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
		sELECT  DISTINCT
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
		sELECT  DISTINCT
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
		sELECT  DISTINCT
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
		sELECT  DISTINCT
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
		sELECT  DISTINCT
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
		sELECT  DISTINCT
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
		sELECT  DISTINCT
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
		sELECT  DISTINCT
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


if exists(select TABLE_NAME from INFORMATION_SCHEMA.VIEWS where TABLE_NAME = 'view_EDW_TrackerCompositeDetails')
BEGIN
	drop view view_EDW_TrackerCompositeDetails ;
END

GO

CREATE view [dbo].[view_EDW_TrackerCompositeDetails]
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
--Tracker Column Data Type (e.g. Character, Numeric, Date, Bit or Yes/No) � so that we can set up the answer type
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

-- 09.11.2014 : (wdm) Verified DATES to resolve EDW last mod date issue
--***********************************************************************************************
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

-- 09.11.2014 : (wdm) Verified DATES to resolve EDW last mod date issue
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

GO
--***********************************************************************************************
-- 09.11.2014 : (wdm) Verified DATES to resolve EDW last mod date issue
--***********************************************************************************************
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
if exists(select TABLE_NAME from INFORMATION_SCHEMA.VIEWS where TABLE_NAME = 'view_EDW_TrackerTests')
BEGIN
	drop view view_EDW_TrackerTests ;
END

GO

--***********************************************************************************************
-- 09.11.2014 : (wdm) Verified DATES to resolve EDW last mod date issue
--***********************************************************************************************
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
if exists(select TABLE_NAME from INFORMATION_SCHEMA.VIEWS where TABLE_NAME = 'view_EDW_HealthAssesment')
BEGIN
	drop view view_EDW_HealthAssesment ;
END

GO

--USAGE:
--Select * from view_EDW_HealthAssesment where 
--ItemModifiedWhen between '2014-08-02 00:00:00.001' and '2014-08-03 00:00:00.000'
--OR HARiskCategory_ItemModifiedWhen between '2014-08-02 00:00:00.001' and '2014-08-03 00:00:00.000'
--OR HAUserRiskArea_ItemModifiedWhen between '2014-08-02 00:00:00.001' and '2014-08-03 00:00:00.000'
--OR HAUserQuestion_ItemModifiedWhen between '2014-08-02 00:00:00.001' and '2014-08-03 00:00:00.000'
--OR HAUserAnswers_ItemModifiedWhen between '2014-08-02 00:00:00.001' and '2014-08-03 00:00:00.000'

Create VIEW [dbo].[view_EDW_HealthAssesment]
AS
--***********************************************************************************************

--select top 1000 * from view_EDW_HealthAssesment Where QuestionGroupCodeName is not NULL
--7/15/2014 17:19 min. 46,750 Rows DEV
--7/15/2014 per Mark Turner
--HAModuleDocumentID is on its way out, so is - 
--Module - RiskCategory - RiskArea - Question - Answer 
--all the "DocumentID" fields are deprecated and replaced by corresponding NodeGUID/DocumentGUID fields
--8/7/2014 - Executed in DEV with GUID changes and returned 51K Rows in 43:10.
--			Had a conversation with Matt and Mark to determine best way to join HealthAssesmentQuestions.
--			Per Matt, the join needs to executed on the HAQuestionDocumentID and replaced with the GUID
--			when it becomes available. And, CMS TREE Joind needes to be joined on HAModuleDocumentID
--			until the GUID is made available.
--8/8/2014 - Generated corrected view in DEV
--8/13/2014 - This view is NOT the same view that is required in the DEV environment.
--				At this time, two different views are required as the environments
--				are not the same, that is DEV & Prod Staging. Two sets of source code needed.
--8/14/2014 - Found that the table columns are different across environments
--8/18/2014 - John C. found that all QuestionGroupCodeName were NULL
--8/21/2014 - Uncommented the line "VHFHAQ.[DocumentGuid] as HAQuestionGuid" as I did not 
--				know if it would be used as well as The User Question GUID. I guess both are needed.
-- 09.11.2014 : (wdm) Verified DATES to resolve EDW last mod date issue
--********************************************************************************************************
-- 09.08.2014: John Croft and I working together, realized there is a deficit in the ability 
--of the EDW to recognize changes to database records based on the last modified date of a row. 
--The views that we are currently using in the database or deeply nested. This means that 
--several base tables are involved in building a single view of data.
--
--The views were initially designed to recognize a date change based on a record change very 
--high in the data hierarchy, the CMS Tree level which is the top most level. However, John 
--and I recognize that data can change at any level in the hierarchy and those changes must be 
--recognized as well. Currently, that is not the case. With the new modification to the views, 
--changes in CMS documents and base tables will filter up through the hierarchy and the EDW load 
--process will be able to realize that a change in this row�s data may affect and intrude into 
--the warehouse.
--***********************************************************************************************
	SELECT DISTINCT
		HAUserStarted.ItemID AS UserStartedItemID
		, HAUserStarted.HealthAssesmentUserStartedNodeGUID
		, HAUserStarted.UserID
		, HAUserStarted.HAStartedDt
		, HAUserStarted.HACompletedDt
		
		, cu.UserGUID
		, cus2.HFitUserMpiNumber
		, cs.SiteGUID
		
		, VCTJ.NodeGUID as HAModuleNodeGUID					--WDM 8/7/2014 as HAModuleDocumentID
		, VCTJ.NodeGUID as CMSNodeGuid						--WDM 8/7/2014 as CMSNodeGuid

		, HFA.AccountID
		, HFA.AccountCD		
		
		, haum.ItemID AS UserModuleItemId
		, haum.CodeName AS UserModuleCodeName
		, haum.HAModuleVersionID
		, haurc.ItemID AS UserRiskCategoryItemID
		, haurc.CodeName AS UserRiskCategoryCodeName
		, haurc.HARiskCategoryNodeGUID		--HARiskCategoryDocumentID
		, haurc.HARiskCategoryVersionID
		
		, haura.ItemID AS UserRiskAreaItemID
		, haura.CodeName AS UserRiskAreaCodeName
		, haura.HARiskAreaNodeGUID		--HARiskAreaDocumentID
		, haura.HARiskAreaVersionID
		
		, VHFHAQ.Title 
		, VHFHAQ.DocumentGuid as HAQuestionGuid
		
		, hauq.ItemID AS UserQuestionItemID
		, hauq.CodeName AS UserQuestionCodeName
		, hauq.HAQuestionDocumentID
		, hauq.HAQuestionVersionID
		, hauq.HAQuestionNodeGUID
		, haua.ItemID AS UserAnswerItemID
		, haua.HAAnswerNodeGUID									--WDM 8/7/2014 as HAAnswerDocumentID
		, haua.HAAnswerVersionID
		, haua.CodeName AS UserAnswerCodeName
		, haua.HAAnswerValue
		, haum.HAModuleScore
		, haurc.HARiskCategoryScore
		, haura.HARiskAreaScore
		, hauq.HAQuestionScore
		, haua.HAAnswerPoints
		, HFHAUQGR.PointResults
		, haua.UOMCode

		, HAUserStarted.HAScore		
		, haum.PreWeightedScore AS ModulePreWeightedScore
		, haurc.PreWeightedScore AS RiskCategoryPreWeightedScore
		, haura.PreWeightedScore AS RiskAreaPreWeightedScore
		, hauq.PreWeightedScore AS QuestionPreWeightedScore
		
		, HFHAUQGR.CodeName AS QuestionGroupCodeName
       ,CASE WHEN haua.ItemCreatedWhen = haua.ItemModifiedWhen THEN 'I'
             ELSE 'U'
        END AS ChangeType
       ,hauq.IsProfessionallyCollected		
	
	   ,haua.ItemCreatedWhen
       ,haua.ItemModifiedWhen	   
	   ,haurc.ItemModifiedWhen as HARiskCategory_ItemModifiedWhen
	   ,haura.ItemModifiedWhen as HAUserRiskArea_ItemModifiedWhen
	   ,hauq.ItemModifiedWhen as HAUserQuestion_ItemModifiedWhen
	   ,haua.ItemModifiedWhen as HAUserAnswers_ItemModifiedWhen
FROM
	view_EDW_HFit_HealthAssesmentUserStarted AS HAUserStarted
	INNER JOIN dbo.CMS_User AS CU ON HAUserStarted.UserID = cu.UserID
	INNER JOIN dbo.CMS_UserSettings AS CUS2 ON CUS2.UserSettingsUserID = CU.UserID
	INNER JOIN dbo.CMS_UserSite AS CUS ON CU.UserID = CUS.UserID
	INNER JOIN dbo.CMS_Site AS CS ON CUS.SiteID = CS.SiteID
	
	INNER JOIN dbo.HFit_Account AS HFA ON hfa.SiteID = cs.SiteID
	--INNER JOIN dbo.HFit_HealthAssesmentUserModule AS haum ON HAUserStarted.ItemID = haum.HAStartedItemID
	
	INNER JOIN dbo.view_EDW_HFit_HealthAssesmentUserModule AS haum ON HAUserStarted.ItemID = haum.HAStartedItemID
	--INNER JOIN dbo.HFit_HealthAssesmentUserRiskCategory AS haurc ON haum.ItemID = haurc.HAModuleItemID

	--inner join View_CMS_Tree_Joined as VCTJ on VCTJ.NodeGUID = haum.HAModuleNodeGUID		--WDM 09.16.2014
	--inner join View_CMS_Tree_Joined as VCTJ on VCTJ.DocumentID = haum.HADocumentID		--WDM 09.16.2014
	inner join View_CMS_Tree_Joined as VCTJ on VCTJ.DocumentID = haum.HAModuleDocumentID	--WDM 09.16.2014
	
	INNER JOIN dbo.view_EDW_HFit_HealthAssesmentUserRiskCategory AS haurc ON haum.ItemID = haurc.HAModuleItemID
	--INNER JOIN dbo.HFit_HealthAssesmentUserRiskArea AS haura ON haurc.ItemID = haura.HARiskCategoryItemID
	
	INNER JOIN dbo.view_EDW_HFit_HealthAssesmentUserRiskArea AS haura ON haurc.ItemID = haura.HARiskCategoryItemID
	--INNER JOIN dbo.view_EDW_HFit_HealthAssesmentUserRiskArea AS haura ON haurc.ItemID = haura.HARiskCategoryItemID
	
	--INNER JOIN dbo.HFit_HealthAssesmentUserQuestion AS hauq ON haura.ItemID = hauq.HARiskAreaItemID
	INNER JOIN view_EDW_HFit_HealthAssesmentUserQuestion AS hauq ON haura.ItemID = hauq.HARiskAreaItemID
		
	--INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ ON hauq.HAQuestionNodeGUID = VHFHAQ.NodeGUID		--WDM 8/7/2014
	INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ ON hauq.HAQuestionDocumentID = VHFHAQ.DocumentID		--WDM 8/7/2014
	--INNER JOIN dbo.View_HFit_HealthAssesmentQuestions AS VHFHAQ ON hauq.HAQuestionDocumentID = VHFHAQ.DocumentID	--WDM 8/7/2014

	LEFT OUTER JOIN dbo.HFit_HealthAssesmentUserQuestionGroupResults AS HFHAUQGR ON hauq.ItemID = HFHAUQGR.HARiskAreaItemID
	INNER JOIN dbo.view_EDW_HFit_HealthAssesmentUserAnswers AS haua ON hauq.ItemID = haua.HAQuestionItemID

GO


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

create procedure [dbo].[Proc_EDW_GenerateMetadata]
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

create procedure [dbo].[Proc_EDW_HealthAssessment] (@StartDate as datetime, @EndDate as datetime, @TrackPerf as nvarchar(1))
--WITH EXECUTE AS OWNER
as
--7/15/2014 17:19 min. 46,750 Rows DEV
--7/15/2014 per Mark Turner
--HAModuleDocumentID is on its way out, so is - 
--Module - RiskCategory - RiskArea - Question - Answer 
--all the "DocumentID" fields are deprecated and replaced by corresponding NodeGUID fields
--08/08/2014 - Executed in DEV with GUID changes, new views
--08/08/2014 - Generated corrected view in DEV
--08/08/2014 - 18:06 min. 51,282 Rows DEV
--08/08/2014 - 00:35 sec. 51,282 Rows DEV after conversion to SP (wdm)
--08/08/2014 - 00:35 sec. 51,282 Rows QA after conversion to SP (wdm)
--08/19/2014 - Found this proc missing some of the views created yesterday - recreated the 2 missing views and all works well
--08/29/2014 - 00:35 sec. 51,282 Rows LAB/Prod1 (wdm)
--USE: exec Proc_EDW_HealthAssessment '2014-05-22', '2014-05-23', 'Y'	--This causes between dates to be pulled
--     exec Proc_EDW_HealthAssessment NULL, NULL, 'Y'					--This causes one day's previous data to be pulled

--Auth:	GRANT EXECUTE ON dbo.Proc_EDW_HealthAssessment TO <UserID>;
--Action: This proc creates table EDW_HealthAssessment and a view to access the table view_EDW_HAassessment.
--			Select on the view is granted to PUBLIC. This provides EDW with instant access to data.

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
		[UserStartedItemID] [int] NOT NULL,
		[HAQuestionNodeGUID] [uniqueidentifier] NOT NULL,
		[UserID] [bigint] NOT NULL,
		[UserGUID] [uniqueidentifier] NOT NULL,
		[HFitUserMpiNumber] [bigint] NULL,
		[SiteGUID] [uniqueidentifier] NOT NULL,
		[AccountID] [int] NOT NULL,
		[AccountCD] [nvarchar](8) NULL,
		[HAStartedDt] [datetime] NOT NULL,
		[HACompletedDt] [datetime] NULL,
		[UserModuleItemId] [int] NOT NULL,
		[UserModuleCodeName] [nvarchar](100) NOT NULL,
		  
		 HAModuleNodeGUID uniqueidentifier	--WDM 8/7/2014 as HAModuleDocumentID
		, CMSNodeGuid uniqueidentifier						--WDM 8/7/2014 as HAModuleDocumentID

		,[HAModuleVersionID] [int] NULL,
		[UserRiskCategoryItemID] [int] NOT NULL,
		[UserRiskCategoryCodeName] [nvarchar](100) NOT NULL,
		[HARiskCategoryNodeGUID] [uniqueidentifier] NOT NULL,
		[HARiskCategoryVersionID] [int] NULL,
		[UserRiskAreaItemID] [int] NOT NULL,
		[UserRiskAreaCodeName] [nvarchar](100) NOT NULL,
		[HARiskAreaNodeGUID] [uniqueidentifier] NOT NULL,
		[HARiskAreaVersionID] [int] NULL,
		[UserQuestionItemID] [int] NOT NULL,
		[Title] [nvarchar](max) NOT NULL,
		[UserQuestionCodeName] [nvarchar](100) NOT NULL,
		[HAQuestionVersionID] [int] NULL,
		[UserAnswerItemID] [int] NOT NULL,
		[HAAnswerNodeGUID] [uniqueidentifier] NOT NULL,
		[HAAnswerVersionID] [int] NULL,
		[UserAnswerCodeName] [nvarchar](100) NOT NULL,
		[HAAnswerValue] [nvarchar](255) NULL,
		[HAModuleScore] [float] NOT NULL,
		[HARiskCategoryScore] [float] NULL,
		[HARiskAreaScore] [float] NULL,
		[HAQuestionScore] [float] NULL,
		[HAAnswerPoints] [int] NULL,
		[PointResults] [int] NULL,
		[UOMCode] [nvarchar](10) NULL,
		[HAScore] [int] NULL,
		[ModulePreWeightedScore] [float] NULL,
		[RiskCategoryPreWeightedScore] [float] NULL,
		[RiskAreaPreWeightedScore] [float] NULL,
		[QuestionPreWeightedScore] [float] NULL,
		[QuestionGroupCodeName] [nvarchar](100) NULL,
		[ChangeType] [varchar](1) NOT NULL,
		[IsProfessionallyCollected] bit NULL
				 
	   ,ItemCreatedWhen datetime
       ,ItemModifiedWhen  datetime
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
				,[HAQuestionNodeGUID]
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
				
			    , HAModuleNodeGUID				--WDM 8/7/2014 as HAModuleDocumentID
			    , CMSNodeGuid						--WDM 8/7/2014 as HAModuleDocumentID

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
				,[UserQuestionCodeName]
				,[HAQuestionVersionID]
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
				,[IsProfessionallyCollected]
				,[ItemCreatedWhen]
				,[ItemModifiedWhen]
				,HARiskCategory_ItemModifiedWhen 
				,HAUserRiskArea_ItemModifiedWhen 
				,HAUserQuestion_ItemModifiedWhen 
				,HAUserAnswers_ItemModifiedWhen 
			FROM [dbo].[EDW_HealthAssessment]' ; 
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
	(
		[UserStartedItemID]
		,[HAQuestionNodeGUID]
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
		 
		, HAModuleNodeGUID				--WDM 8/7/2014 as HAModuleDocumentID
		, CMSNodeGuid						--WDM 8/7/2014 as HAModuleDocumentID

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
		,[UserQuestionCodeName]
		,[HAQuestionVersionID]
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
		,[IsProfessionallyCollected]

		,[ItemCreatedWhen]
		,[ItemModifiedWhen]
		,HARiskCategory_ItemModifiedWhen
		,HAUserRiskArea_ItemModifiedWhen
		,HAUserQuestion_ItemModifiedWhen
		,HAUserAnswers_ItemModifiedWhen
	)
	SELECT  
			haus.ItemID AS UserStartedItemID
			, hauq.HAQuestionNodeGUID 
			, haus.UserID
			, cu.UserGUID
			, cus2.HFitUserMpiNumber
			, cs.SiteGUID
			, HFA.AccountID
			, HFA.AccountCD
			, haus.HAStartedDt
			, haus.HACompletedDt
			, haum.ItemID AS UserModuleItemId
			, haum.CodeName AS UserModuleCodeName
			
			, VCTJ.DocumentGUID as HAModuleNodeGUID				--WDM 8/7/2014 as HAModuleDocumentID
			, VCTJ.NodeGUID as CMSNodeGuid						--WDM 8/7/2014 as HAModuleDocumentID

			, NULL as HAModuleVersionID
			, haurc.ItemID AS UserRiskCategoryItemID
			, haurc.CodeName AS UserRiskCategoryCodeName
			, haurc.HARiskCategoryNodeGUID 
			, NULL as HARiskCategoryVersionID
			, haura.ItemID AS UserRiskAreaItemID
			, haura.CodeName AS UserRiskAreaCodeName
			, haura.HARiskAreaNodeGUID 
			, NULL as HARiskAreaVersionID
			, hauq.ItemID AS UserQuestionItemID
			, VHFHAQ.Title
			, hauq.CodeName AS UserQuestionCodeName
			--, hauq.HAQuestionNodeGUID
			, NULL as HAQuestionVersionID	--Exist as HAQuestionVersionID_old in the TABLE, ignoring
			, haua.ItemID AS UserAnswerItemID
			, haua.HAAnswerNodeGUID
			, NULL as HAAnswerVersionID	--Exist as HAAnswerVersionID_old in the TABLE, ignoring
			, haua.CodeName AS UserAnswerCodeName
			, haua.HAAnswerValue
			, haum.HAModuleScore
			, haurc.HARiskCategoryScore
			, haura.HARiskAreaScore
			, hauq.HAQuestionScore
			, haua.HAAnswerPoints
			, HFHAUQGR.PointResults
			, haua.UOMCode
			, haus.HAScore
			, haum.PreWeightedScore AS ModulePreWeightedScore
			, haurc.PreWeightedScore AS RiskCategoryPreWeightedScore
			, haura.PreWeightedScore AS RiskAreaPreWeightedScore
			, hauq.PreWeightedScore AS QuestionPreWeightedScore
			, HFHAUQGR.CodeName AS QuestionGroupCodeName
		   ,CASE WHEN haua.ItemCreatedWhen = haua.ItemModifiedWhen THEN 'I'
		         ELSE 'U'
		    END AS ChangeType		   
		   ,hauq.IsProfessionallyCollected

		   ,haua.ItemCreatedWhen
		   ,haua.ItemModifiedWhen
			,haurc.ItemModifiedWhen as HARiskCategory_ItemModifiedWhen
			,haura.ItemModifiedWhen as HAUserRiskArea_ItemModifiedWhen
			,hauq.ItemModifiedWhen as HAUserQuestion_ItemModifiedWhen
			,haua.ItemModifiedWhen as HAUserAnswers_ItemModifiedWhen
		FROM
		dbo.HFit_HealthAssesmentUserStarted AS haus
		INNER JOIN dbo.CMS_User AS CU ON haus.UserID = cu.UserID
		INNER JOIN dbo.CMS_UserSettings AS CUS2 ON CUS2.UserSettingsUserID = CU.UserID
		INNER JOIN dbo.CMS_UserSite AS CUS ON CU.UserID = CUS.UserID
		INNER JOIN dbo.CMS_Site AS CS ON CUS.SiteID = CS.SiteID
		INNER JOIN dbo.HFit_Account AS HFA ON hfa.SiteID = cs.SiteID
		INNER JOIN dbo.view_EDW_HFit_HealthAssesmentUserModule AS haum ON haus.ItemID = haum.HAStartedItemID
		
		--inner join View_CMS_Tree_Joined as VCTJ on VCTJ.NodeGUID = haum.HAModuleNodeGUID
		inner join View_CMS_Tree_Joined as VCTJ on VCTJ.DocumentID = haum.HAModuleDocumentID	--WDM 09.16.2014

		INNER JOIN dbo.view_EDW_HFit_HealthAssesmentUserRiskCategory AS haurc ON haum.ItemID = haurc.HAModuleItemID
		INNER JOIN dbo.view_EDW_HFit_HealthAssesmentUserRiskArea AS haura ON haurc.ItemID = haura.HARiskCategoryItemID
		INNER JOIN dbo.view_EDW_HFit_HealthAssesmentUserQuestion AS hauq ON haura.ItemID = hauq.HARiskAreaItemID
		                   
		--INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ ON hauq.HAQuestionNodeGUID = VHFHAQ.NodeGUID
		INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ ON hauq.HAQuestionDocumentID = VHFHAQ.DocumentID		--WDM 8/7/2014
	
		LEFT OUTER JOIN dbo.HFit_HealthAssesmentUserQuestionGroupResults AS HFHAUQGR ON hauq.ItemID = HFHAUQGR.HARiskAreaItemID
		INNER JOIN dbo.HFit_HealthAssesmentUserAnswers AS haua ON hauq.ItemID = haua.HAQuestionItemID
		--inner join #TEMP_UPDTDATE AS CDC ON haua.ItemID = CDC.ItemID
		WHERE haua.ItemModifiedWhen BETWEEN @StartDate AND @EndDate
		OR    haurc.ItemModifiedWhen BETWEEN @StartDate AND @EndDate
		OR	  haura.ItemModifiedWhen BETWEEN @StartDate AND @EndDate
		OR	  hauq.ItemModifiedWhen BETWEEN @StartDate AND @EndDate
		OR	  haua.ItemModifiedWhen BETWEEN @StartDate AND @EndDate

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

GO


if exists (select * from sysobjects where name = 'proc_EDW_MeasurePerf' and Xtype = 'P')
BEGIN
	drop procedure proc_EDW_MeasurePerf ;
END 
go

create procedure [dbo].[proc_EDW_MeasurePerf] (@TypeTest as nvarchar(50),@ObjectName as nvarchar(50),@RecCount as int, @StartTime as datetime,@EndTime as datetime)
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



GO 

if exists (select * from sysobjects where name = 'Proc_EDW_RewardUserDetail' and Xtype = 'P')
BEGIN
	drop procedure Proc_EDW_RewardUserDetail ;
END 
go

create proc [dbo].[Proc_EDW_RewardUserDetail] (@StartDate as datetime, @EndDate as datetime, @TrackPerf as nvarchar(1))
as
BEGIN


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
--********************************************************************************************************************

--********************************************************************************************************************
--EXECUTION:
--	@StartDate: The date from which to begin selection of data
--	@EndDate  : The date from which to stop selection of data
--	@TrackPerf: Anything other than a NULL char to track performance.
--	exec Proc_EDW_RewardUserDetail NULL, NULL, 'Y'
--	exec Proc_EDW_RewardUserDetail '2010-11-14', '2014-11-15', 'Y'
--	exec Proc_EDW_RewardUserDetail '2014-06-10', '2014-06-11', NULL
--********************************************************************************************************************

	declare @P0Start as datetime ;
	declare @P0End as datetime ;

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

	--*************************************************************************
if exists (select name from sys.tables where name = 'EDW_RewardUserDetail')
BEGIN
	drop table EDW_RewardUserDetail ;
END

IF not EXISTS
		(
			SELECT name
			FROM SYS.INDEXES
			WHERE NAME = 'pi_CMS_UserSettings_IDMPI'
		)
	BEGIN
		CREATE nonCLUSTERED  INDEX pi_CMS_UserSettings_IDMPI
		ON CMS_UserSettings
		(		[UserSettingsID] ASC 
				, [HFitUserMpiNumber]
		)
	END


	IF not EXISTS
		(
			SELECT name
			FROM SYS.INDEXES
			WHERE NAME = 'pi_CMS_UserSettings_IDMPI'
		)
	BEGIN
		CREATE nonCLUSTERED  INDEX pi_CMS_UserSettings_IDMPI
		ON CMS_UserSettings
		(		[UserSettingsID] ASC 
				, [HFitUserMpiNumber]
		)
	END
	--GO	

IF not EXISTS
		(
			SELECT name
			FROM SYS.INDEXES
			WHERE NAME = 'PI_CMS_UserSite_SiteID'
		)
	BEGIN
	CREATE NONCLUSTERED INDEX PI_CMS_UserSite_SiteID
		ON [dbo].[CMS_UserSite] ([SiteID])
		INCLUDE ([UserID])
	END

	IF EXISTS
		(
			SELECT name
			FROM tempdb.dbo.sysobjects			
			WHERE ID = OBJECT_ID(N'tempdb..#Temp_View_HFit_RewardProgram_Joined')
		)
	BEGIN
		drop table #Temp_View_HFit_RewardProgram_Joined;
	END
	--GO			
	select NodeID, RewardProgramName, RewardProgramID, RewardProgramPeriodStart, RewardProgramPeriodEnd, DocumentModifiedWhen 
	into #Temp_View_HFit_RewardProgram_Joined 
	from View_HFit_RewardProgram_Joined 
	where View_HFit_RewardProgram_Joined.DocumentCulture = 'en-us' ;
	
	create clustered index PI_Temp_View_HFit_RewardProgram_Joined on #Temp_View_HFit_RewardProgram_Joined 
	(
		NodeID
	)
	--*************************************************************************
	
	IF EXISTS
		(
			SELECT name
			FROM tempdb.dbo.sysobjects			
			WHERE ID = OBJECT_ID(N'tempdb..#TEMP_View_HFit_RewardGroup_Joined')
		)
	BEGIN
		drop table #TEMP_View_HFit_RewardGroup_Joined;
	END
	--GO			
		select NodeID, NodeParentID, GroupName, RewardGroupID, RewardGroupPeriodStart ,RewardGroupPeriodEnd ,DocumentModifiedWhen 
	into #TEMP_View_HFit_RewardGroup_Joined
	from View_HFit_RewardGroup_Joined
	where View_HFit_RewardGroup_Joined.DocumentCulture = 'en-us' ;
	
	create clustered index PI_TEMP_View_HFit_RewardGroup_Joined
	 on #TEMP_View_HFit_RewardGroup_Joined
	(
		NodeID, NodeParentID, GroupName, RewardGroupID, RewardGroupPeriodStart ,RewardGroupPeriodEnd ,DocumentModifiedWhen 
	)
	--*************************************************************************
	--*************************************************************************
	
	IF EXISTS
		(
			SELECT name
			FROM tempdb.dbo.sysobjects			
			WHERE ID = OBJECT_ID(N'tempdb..#TEMP_View_HFit_RewardLevel_Joined')
		)
	BEGIN
		drop table #TEMP_View_HFit_RewardLevel_Joined;
	END
	--GO			
		select NodeID, NodeParentID, AwardType, LevelType, Level, DocumentModifiedWhen, RewardLevelPeriodStart, RewardLevelPeriodEnd
	into #TEMP_View_HFit_RewardLevel_Joined
	from View_HFit_RewardLevel_Joined
	where View_HFit_RewardLevel_Joined.DocumentCulture = 'en-us' ;
	
	create clustered index PI_TEMP_View_HFit_RewardLevel_Joined
	 on #TEMP_View_HFit_RewardLevel_Joined
	(
		NodeID, NodeParentID, AwardType, LevelType, Level, DocumentModifiedWhen, RewardLevelPeriodStart, RewardLevelPeriodEnd
	)
	--*************************************************************************
	--*************************************************************************
	
	IF EXISTS
		(
			SELECT name
			FROM tempdb.dbo.sysobjects			
			WHERE ID = OBJECT_ID(N'tempdb..#TEMP_View_HFit_RewardActivity_Joined')
		)
	BEGIN
		drop table #TEMP_View_HFit_RewardActivity_Joined;
	END
	--GO			
		select NodeID, NodeParentID, RewardActivityID, ActivityName, RewardActivityPeriodStart, RewardActivityPeriodEnd, ActivityPoints
	into #TEMP_View_HFit_RewardActivity_Joined
	from View_HFit_RewardActivity_Joined
	where View_HFit_RewardActivity_Joined.DocumentCulture = 'en-us' ;
	
	create clustered index PI_TEMP_View_HFit_RewardActivity_Joined
	 on #TEMP_View_HFit_RewardActivity_Joined
	(
		NodeID, NodeParentID, RewardActivityID, ActivityName, RewardActivityPeriodStart, RewardActivityPeriodEnd, ActivityPoints
	)
	--*************************************************************************
	--*************************************************************************	
	IF EXISTS
		(
			SELECT name
			FROM tempdb.dbo.sysobjects			
			WHERE ID = OBJECT_ID(N'tempdb..#TEMP_View_HFit_RewardTrigger_Joined')
		)
	BEGIN
		drop table #TEMP_View_HFit_RewardTrigger_Joined;
	END
	--GO			
		select NodeParentID, RewardTriggerLKPID, TriggerName, RewardTriggerID
	into #TEMP_View_HFit_RewardTrigger_Joined
	from View_HFit_RewardTrigger_Joined
	where View_HFit_RewardTrigger_Joined.DocumentCulture = 'en-us' ;
	
	create clustered index PI_TEMP_View_HFit_RewardTrigger_Joined
	 on #TEMP_View_HFit_RewardTrigger_Joined
	(
		NodeParentID, RewardTriggerLKPID, TriggerName, RewardTriggerID
	)
	--*************************************************************************
	--*************************************************************************	
	IF EXISTS
		(
			SELECT name
			FROM tempdb.dbo.sysobjects			
			WHERE ID = OBJECT_ID(N'tempdb..#TEMP_CMS_UserSettings')
		)
	BEGIN
		drop table #TEMP_CMS_UserSettings;
	END
	--GO			
		select HFitUserMpiNumber, UserSettingsUserID
	into #TEMP_CMS_UserSettings
	from CMS_UserSettings	
	
	create clustered index PI_TEMP_CMS_UserSettings
	 on #TEMP_CMS_UserSettings
	(
		HFitUserMpiNumber, UserSettingsUserID
	)

	CREATE NONCLUSTERED INDEX PI_TEMP_CMS_UserSettings2
		ON [dbo].[#TEMP_CMS_UserSettings] 
		([UserSettingsUserID])
		INCLUDE ([HFitUserMpiNumber])
	
	--*************************************************************************
	--***********************************************************************************************
	-- This is the data extraction QUERY
	--***********************************************************************************************
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
		, HFRE.ItemModifiedWhen AS RewardExceptionModifiedDate
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
		, HFRULD.ItemCreatedWhen
		, HFRULD.ItemModifiedWhen
		, VHFRPJ.DocumentGuid		--WDM added 8/7/2014 in case needed
		, VHFRPJ.NodeGuid		--WDM added 8/7/2014 in case needed	
	into EDW_RewardUserDetail			
	FROM
		#Temp_View_HFit_RewardProgram_Joined AS VHFRPJ WITH ( NOLOCK )
		LEFT OUTER JOIN #TEMP_View_HFit_RewardGroup_Joined AS VHFRGJ WITH ( NOLOCK ) ON VHFRPJ.NodeID = VHFRGJ.NodeParentID
		LEFT OUTER JOIN #TEMP_View_HFit_RewardLevel_Joined AS VHFRLJ WITH ( NOLOCK ) ON VHFRGJ.NodeID = VHFRLJ.NodeParentID
		LEFT OUTER JOIN dbo.HFit_LKP_RewardType AS HFLRT WITH ( NOLOCK ) ON VHFRLJ.AwardType = HFLRT.RewardTypeLKPID
		LEFT OUTER JOIN dbo.HFit_LKP_RewardLevelType AS HFLRLT WITH ( NOLOCK ) ON vhfrlj.LevelType = HFLRLT.RewardLevelTypeLKPID
		INNER JOIN dbo.HFit_RewardsUserLevelDetail AS HFRULD WITH ( NOLOCK ) ON VHFRLJ.NodeID = HFRULD.LevelNodeID
		INNER JOIN dbo.CMS_User AS CU WITH ( NOLOCK ) ON hfruld.UserID = cu.UserID
		INNER JOIN dbo.CMS_UserSite AS CUS WITH ( NOLOCK ) ON CU.UserID = CUS.UserID
		INNER JOIN dbo.CMS_Site AS CS2 WITH ( NOLOCK ) ON CUS.SiteID = CS2.SiteID
		INNER JOIN dbo.HFit_Account AS HFA WITH ( NOLOCK ) ON cs2.SiteID = HFA.SiteID

		INNER JOIN #TEMP_CMS_UserSettings AS CUS2 ON cu.UserID = cus2.UserSettingsUserID		
		LEFT OUTER JOIN #TEMP_View_HFit_RewardActivity_Joined AS VHFRAJ WITH ( NOLOCK ) ON VHFRLJ.NodeID = VHFRAJ.NodeParentID
		
		INNER JOIN dbo.HFit_RewardsUserActivityDetail AS HFRUAD WITH ( NOLOCK ) ON VHFRAJ.NodeID = HFRUAD.ActivityNodeID
		LEFT OUTER JOIN dbo.View_HFit_RewardTrigger_Joined AS VHFRTJ WITH ( NOLOCK ) ON VHFRAJ.NodeID = VHFRTJ.NodeParentID
		LEFT OUTER JOIN dbo.HFit_LKP_RewardTrigger AS HFLRT2 WITH ( NOLOCK ) ON VHFRTJ.RewardTriggerLKPID = HFLRT2.RewardTriggerLKPID
		LEFT OUTER JOIN dbo.HFit_RewardException AS HFRE WITH ( NOLOCK ) ON HFRE.RewardActivityID = VHFRAJ.RewardActivityID
				AND HFRE.UserID = cu.UserID
	
		Where HFRULD.ItemModifiedWhen >= @StartDate AND HFRULD.ItemModifiedWhen <= @EndDate
		--OPTION (TABLE HINT(CUS2 , index (pi_CMS_UserSettings_IDMPI)))

	if @TrackPerf is not null 
	BEGIN
		set @P0End = getdate() ;
		exec proc_EDW_MeasurePerf 'ElapsedTime','HARewardUSer-P0',0, @P0Start, @P0End;
	END

END --End of Proc

GO 




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

if not exists(select name from sys.indexes where name = 'PI_HFIT_Tracker_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFIT_Tracker_LastUpdate ON [HFIT_Tracker] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerBloodPressure_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerBloodPressure_LastUpdate ON [HFit_TrackerBloodPressure] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerBloodSugarAndGlucose_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerBloodSugarAndGlucose_LastUpdate ON [HFit_TrackerBloodSugarAndGlucose] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerBMI_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerBMI_LastUpdate ON [HFit_TrackerBMI] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerBodyFat_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerBodyFat_LastUpdate ON [HFit_TrackerBodyFat] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerBodyMeasurements_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerBodyMeasurements_LastUpdate ON [HFit_TrackerBodyMeasurements] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerCardio_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerCardio_LastUpdate ON [HFit_TrackerCardio] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerCategory_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerCategory_LastUpdate ON [HFit_TrackerCategory] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerCholesterol_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerCholesterol_LastUpdate ON [HFit_TrackerCholesterol] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerCollectionSource_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerCollectionSource_LastUpdate ON [HFit_TrackerCollectionSource] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerDailySteps_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerDailySteps_LastUpdate ON [HFit_TrackerDailySteps] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerDef_Item_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerDef_Item_LastUpdate ON [HFit_TrackerDef_Item] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerDef_Tracker_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerDef_Tracker_LastUpdate ON [HFit_TrackerDef_Tracker] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerDocument_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerDocument_LastUpdate ON [HFit_TrackerDocument] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerFlexibility_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerFlexibility_LastUpdate ON [HFit_TrackerFlexibility] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerFruits_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerFruits_LastUpdate ON [HFit_TrackerFruits] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerHbA1c_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerHbA1c_LastUpdate ON [HFit_TrackerHbA1c] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerHeight_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerHeight_LastUpdate ON [HFit_TrackerHeight] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerHighFatFoods_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerHighFatFoods_LastUpdate ON [HFit_TrackerHighFatFoods] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerHighSodiumFoods_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerHighSodiumFoods_LastUpdate ON [HFit_TrackerHighSodiumFoods] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerInstance_Item_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerInstance_Item_LastUpdate ON [HFit_TrackerInstance_Item] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerInstance_Tracker_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerInstance_Tracker_LastUpdate ON [HFit_TrackerInstance_Tracker] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerMealPortions_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerMealPortions_LastUpdate ON [HFit_TrackerMealPortions] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerMedicalCarePlan_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerMedicalCarePlan_LastUpdate ON [HFit_TrackerMedicalCarePlan] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerRegularMeals_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerRegularMeals_LastUpdate ON [HFit_TrackerRegularMeals] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerRestingHeartRate_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerRestingHeartRate_LastUpdate ON [HFit_TrackerRestingHeartRate] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerShots_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerShots_LastUpdate ON [HFit_TrackerShots] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerSitLess_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerSitLess_LastUpdate ON [HFit_TrackerSitLess] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerSleepPlan_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerSleepPlan_LastUpdate ON [HFit_TrackerSleepPlan] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerStrength_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerStrength_LastUpdate ON [HFit_TrackerStrength] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerStress_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerStress_LastUpdate ON [HFit_TrackerStress] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerStressManagement_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerStressManagement_LastUpdate ON [HFit_TrackerStressManagement] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerSugaryDrinks_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerSugaryDrinks_LastUpdate ON [HFit_TrackerSugaryDrinks] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerSugaryFoods_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerSugaryFoods_LastUpdate ON [HFit_TrackerSugaryFoods] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerSummary_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerSummary_LastUpdate ON [HFit_TrackerSummary] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerTests_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerTests_LastUpdate ON [HFit_TrackerTests] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerTobaccoFree_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerTobaccoFree_LastUpdate ON [HFit_TrackerTobaccoFree] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerVegetables_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerVegetables_LastUpdate ON [HFit_TrackerVegetables] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerWater_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerWater_LastUpdate ON [HFit_TrackerWater] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerWeight_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerWeight_LastUpdate ON [HFit_TrackerWeight] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerWholeGrains_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerWholeGrains_LastUpdate ON [HFit_TrackerWholeGrains] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go



GO

if not exists (select name from sys.indexes where name = 'PI_CMS_UserSite_SiteID')
BEGIN 
CREATE NONCLUSTERED INDEX PI_CMS_UserSite_SiteID
ON [dbo].[CMS_UserSite] ([SiteID])
INCLUDE ([UserSiteID],[UserID],[UserPreferredCurrencyID],[UserPreferredShippingOptionID],[UserPreferredPaymentOptionID],[UserDiscountLevelID])
END

GO


if not exists (select name from sys.indexes where name = 'PI_CMS_User_UserIsGlobalAdministrator')
BEGIN 

CREATE NONCLUSTERED INDEX [PI_CMS_User_UserIsGlobalAdministrator] ON [dbo].[CMS_User]
(
	[UserIsGlobalAdministrator] ASC,
	UserID
)
END 

GO


if not exists (select name from sys.indexes where name = 'PI_HealthAssesmentUserAnswers_QID')
BEGIN 

CREATE NONCLUSTERED INDEX [PI_HealthAssesmentUserAnswers_QID] ON [dbo].[HFit_HealthAssesmentUserAnswers]
(
	[ItemID],
	[ItemCreatedWhen],
	[ItemModifiedWhen],
	[HAQuestionItemID]
)
END 
GO



print ('Creating job_EDW_GenerateMetadata');
GO

IF not EXISTS (SELECT job_id FROM msdb.dbo.sysjobs_view WHERE name = N'job_EDW_GenerateMetadata')
BEGIN
	drop procedure job_EDW_GenerateMetadata ;
END
GO

IF not EXISTS (SELECT job_id FROM msdb.dbo.sysjobs_view WHERE name = N'job_EDW_GenerateMetadata')
BEGIN


	/****** Object:  Job [job_EDW_GenerateMetadata]    Script Date: 8/20/2014 3:10:41 PM ******/
	BEGIN TRANSACTION
	DECLARE @DBNAME nvarchar(100)
	DECLARE @ReturnCode INT
	SELECT @ReturnCode = 0

	--********************************************************************************
	set @DBNAME = 'KenticoCMS_ProdStaging'
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

END

use KenticoCMS_ProdStaging

print ('Creating job_EDW_GenerateMetadata');
GO

