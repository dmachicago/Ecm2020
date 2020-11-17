print ('Processing: UTIL_getUsageCount ') ;
go

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

