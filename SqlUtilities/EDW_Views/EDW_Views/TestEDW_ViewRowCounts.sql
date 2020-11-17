--USE [DEV]
--GO

/****** Object:  Table [dbo].[EDW_PerformanceMeasure]    Script Date: 8/11/2014 2:27:05 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS
		(
			SELECT name
			FROM sys.tables
			WHERE NAME = 'EDW_PerformanceMeasure'
		)
	BEGIN
		CREATE TABLE [dbo].[EDW_PerformanceMeasure](
			[TypeTest] [nvarchar](50) NULL,
			[ObjectName] [nvarchar](80) NULL,
			[RecCount] [int] NULL,
			[StartTime] [datetime] NULL,
			[EndTime] [datetime] NULL,
			[hrs] [int] NULL,
			[mins] [int] NULL,
			[secs] [int] NULL,
			[ms] [nchar](10) NULL
		) 
END
GO

IF NOT EXISTS
		(
			SELECT name
			FROM sys.procedures
			WHERE NAME = 'proc_GetRecordCount'
		)
	BEGIN
		print ('proc_GetRecordCount MISSING, aborting.') ;
		THROW 51000, 'proc_GetRecordCount MISSING, aborting.', 1;
	END
go
--select * from [EDW_PerformanceMeasure]
exec Proc_EDW_GenerateMetadata
go

declare @STime datetime ;
declare @ETime datetime ;
declare @RecCount int = 56 ;
declare @TotREcs int = 0 ;
declare @TypeTest nvarchar(50) = 'Data Read' ;

set @RecCount = 56 ;
set @TypeTest = 'Data Read' ;
set @STime = getdate() ;

print ('Select: view_EDW_ClientCompany');
select top 56 * from view_EDW_ClientCompany ;

set @ETime = getdate() ;
exec proc_EDW_MeasurePerf @TypeTest,'view_EDW_ClientCompany',@RecCount , @STime,@ETime ;
set @STime = getdate() ;

print ('Select: view_EDW_Coaches');
select top 56 * from view_EDW_Coaches
set @ETime = getdate() ;
exec proc_EDW_MeasurePerf @TypeTest,'view_EDW_Coaches',@RecCount , @STime,@ETime ;
set @STime = getdate() ;
--Go

print ('Select: view_EDW_CoachingDefinition');
Select top 56 * from view_EDW_CoachingDefinition
--Go
set @ETime = getdate() ;
exec proc_EDW_MeasurePerf @TypeTest,'view_EDW_CoachingDefinition',@RecCount , @STime,@ETime ;
set @STime = getdate() ;
--Go

print ('Select: view_EDW_CoachingDetail');
select top 56 * from view_EDW_CoachingDetail
--Go
set @ETime = getdate() ;
exec proc_EDW_MeasurePerf @TypeTest,'view_EDW_CoachingDetail',@RecCount , @STime,@ETime ;
set @STime = getdate() ;
--Go

print ('Select: View_EDW_HealthAssesmentAnswers');
Select top 56 * from View_EDW_HealthAssesmentAnswers
set @ETime = getdate() ;
exec proc_EDW_MeasurePerf @TypeTest,'View_EDW_HealthAssesmentAnswers',@RecCount , @STime,@ETime ;
set @STime = getdate() ;
--Go

print ('Select: view_EDW_HealthAssesmentClientView');
Select top 56 * from view_EDW_HealthAssesmentClientView
set @ETime = getdate() ;
exec proc_EDW_MeasurePerf @TypeTest,'view_EDW_HealthAssesmentClientView',@RecCount , @STime,@ETime ;
set @STime = getdate() ;
--Go

set @STime = getdate() ;
print ('Select: view_EDW_HealthAssesment');
select top 56 * from view_EDW_HealthAssesment
set @ETime = getdate() ;
exec proc_EDW_MeasurePerf @TypeTest,'view_EDW_HealthAssesment',@RecCount , @STime,@ETime ;
set @STime = getdate() ;
--Go

set @STime = getdate() ;
print ('Select: view_EDW_HealthAssesmentDeffinition');
select top 56 * from view_EDW_HealthAssesmentDeffinition
--GO
set @ETime = getdate() ;
exec proc_EDW_MeasurePerf @TypeTest,'view_EDW_HealthAssesmentDeffinition',@RecCount , @STime,@ETime ;
set @STime = getdate() ;
--Go

set @STime = getdate() ;
print ('Select: view_EDW_HealthAssesmentDeffinitionCustom');
Select top 56 * from view_EDW_HealthAssesmentDeffinitionCustom
--GO
set @ETime = getdate() ;
exec proc_EDW_MeasurePerf @TypeTest,'view_EDW_HealthAssesmentDeffinitionCustom',@RecCount , @STime,@ETime ;
set @STime = getdate() ;
--Go

set @STime = getdate() ;
print ('Select: View_EDW_HealthAssesmentQuestions');
select top 56 * from View_EDW_HealthAssesmentQuestions
--Go
set @ETime = getdate() ;
exec proc_EDW_MeasurePerf @TypeTest,'View_EDW_HealthAssesmentQuestions',@RecCount , @STime,@ETime ;
set @STime = getdate() ;
--Go

--Select top 56 * from View_EDW_CDC_HealthAssesmentUserAnswers
----Go
--set @ETime = getdate() ;
--exec proc_EDW_MeasurePerf @TypeTest,'View_EDW_CDC_HealthAssesmentUserAnswers',@RecCount , @STime,@ETime ;
--set @STime = getdate() ;
----Go

set @STime = getdate() ;
print ('Select: view_EDW_Participant');
select top 56 * from view_EDW_Participant
--Go
set @ETime = getdate() ;
exec proc_EDW_MeasurePerf @TypeTest,'view_EDW_Participant',@RecCount , @STime,@ETime ;
set @STime = getdate() ;
--Go

set @STime = getdate() ;
print ('Select: view_EDW_RewardAwardDetail');
Select top 56 * from view_EDW_RewardAwardDetail
--Go
set @ETime = getdate() ;
exec proc_EDW_MeasurePerf @TypeTest,'view_EDW_RewardAwardDetail',@RecCount , @STime,@ETime ;
set @STime = getdate() ;
--Go

set @STime = getdate() ;
print ('Select: view_EDW_RewardsDefinition');
select top 56 * from view_EDW_RewardsDefinition
--Go
set @ETime = getdate() ;
exec proc_EDW_MeasurePerf @TypeTest,'view_EDW_RewardsDefinition',@RecCount , @STime,@ETime ;
set @STime = getdate() ;
--Go

set @STime = getdate() ;
print ('Select: view_EDW_RewardTriggerParameters');
Select top 56 * from view_EDW_RewardTriggerParameters
--Go
set @ETime = getdate() ;
exec proc_EDW_MeasurePerf @TypeTest,'view_EDW_RewardTriggerParameters',@RecCount , @STime,@ETime ;
set @STime = getdate() ;
--Go

set @STime = getdate() ;
print ('Select: view_EDW_RewardUserDetail');
Select top 56 * from view_EDW_RewardUserDetail
--Go
set @ETime = getdate() ;
exec proc_EDW_MeasurePerf @TypeTest,'view_EDW_RewardUserDetail',@RecCount , @STime,@ETime ;
set @STime = getdate() ;
--Go

set @STime = getdate() ;
print ('Select: view_EDW_ScreeningsFromTrackers');
Select top 56 * from view_EDW_ScreeningsFromTrackers
--Go
set @ETime = getdate() ;
exec proc_EDW_MeasurePerf @TypeTest,'view_EDW_ScreeningsFromTrackers',@RecCount , @STime,@ETime ;
set @STime = getdate() ;
--Go

print ('Select: view_EDW_TrackerMetadata');
select top 56 * from view_EDW_TrackerMetadata
--Go
set @ETime = getdate() ;
exec proc_EDW_MeasurePerf @TypeTest,'view_EDW_TrackerMetadata',@RecCount , @STime,@ETime ;
set @STime = getdate() ;
--Go

print ('Select: view_EDW_TrackerShots');
Select top 56 * from view_EDW_TrackerShots
--Go
set @ETime = getdate() ;
exec proc_EDW_MeasurePerf @TypeTest,'view_EDW_TrackerShots',@RecCount , @STime,@ETime ;
set @STime = getdate() ;
--Go

print ('Select: view_EDW_TrackerTests');
Select top 56 * from view_EDW_TrackerTests
--Go
set @ETime = getdate() ;
exec proc_EDW_MeasurePerf @TypeTest,'view_EDW_TrackerTests',@RecCount , @STime,@ETime ;
set @STime = getdate() ;

print ('Select: [Tracker_EDW_Metadata]');
Select top 56 * from [Tracker_EDW_Metadata]
set @ETime = getdate() ;
exec proc_EDW_MeasurePerf @TypeTest,'Tracker_EDW_Metadata',@RecCount , @STime,@ETime ;
set @STime = getdate() ;

GO

print ('Starting RECORD Counts...');
--Select * from [EDW_PerformanceMeasure] order by ObjectName, TypeTest, StartTime
--truncate table EDW_PerformanceMeasure
exec proc_GetRecordCount 'view_EDW_ClientCompany'
exec proc_GetRecordCount 'view_EDW_Coaches'
exec proc_GetRecordCount 'view_EDW_CoachingDefinition'

exec proc_GetRecordCount 'view_EDW_CoachingDetail'
exec proc_GetRecordCount 'View_EDW_HealthAssesmentAnswers'
exec proc_GetRecordCount 'view_EDW_HealthAssesmentClientView'

exec proc_GetRecordCount 'view_EDW_HealthAssesment'

exec proc_GetRecordCount 'view_EDW_HealthAssesmentDeffinition'
exec proc_GetRecordCount 'view_EDW_HealthAssesmentDeffinitionCustom'

exec proc_GetRecordCount 'View_EDW_HealthAssesmentQuestions'
--exec proc_GetRecordCount 'View_EDW_CDC_HealthAssesmentUserAnswers'

exec proc_GetRecordCount 'view_EDW_Participant'
exec proc_GetRecordCount 'view_EDW_RewardAwardDetail'

exec proc_GetRecordCount 'view_EDW_RewardsDefinition'
exec proc_GetRecordCount 'view_EDW_RewardTriggerParameters'
exec proc_GetRecordCount 'view_EDW_RewardUserDetail'
exec proc_GetRecordCount 'view_EDW_ScreeningsFromTrackers'

exec proc_GetRecordCount 'view_EDW_TrackerMetadata'
exec proc_GetRecordCount 'view_EDW_TrackerShots'
exec proc_GetRecordCount 'view_EDW_TrackerTests'

--******************************************************************************************************
print ('Proc_EDW_GenerateMetadata: Start Time: ' + cast(getdate() as nvarchar(50)));
exec Proc_EDW_GenerateMetadata ;
print ('Proc_EDW_GenerateMetadata: End Time: ' + cast(getdate() as nvarchar(50)));
--******************************************************************************************************
print ('Proc_EDW_HealthAssessment: Start Time: ' + cast(getdate() as nvarchar(50)));
exec Proc_EDW_HealthAssessment '01/01/1970', '08/15/2014', 'Y'
print ('Proc_EDW_HealthAssessment: End Time: ' + cast(getdate() as nvarchar(50)));
--******************************************************************************************************
print ('Proc_EDW_TrackerMetadataExtract: Start Time: ' + cast(getdate() as nvarchar(50)));
exec Proc_EDW_TrackerMetadataExtract 'view_EDW_HealthAssesmentDeffinition'
print ('Proc_EDW_TrackerMetadataExtract: End Time: ' + cast(getdate() as nvarchar(50)));
--******************************************************************************************************
print ('Proc_EDW_HealthAssessmentDefinition: Start Time: ' + cast(getdate() as nvarchar(50)));
exec Proc_EDW_HealthAssessmentDefinition '01/01/1970', '08/15/2014', 'Y'
print ('Proc_EDW_HealthAssessmentDefinition: End Time: ' + cast(getdate() as nvarchar(50)));
--******************************************************************************************************

select * from EDW_PerformanceMeasure
  --  
  --  
GO 
print('***** FROM: TestEDW_ViewRowCounts.sql'); 
GO 
