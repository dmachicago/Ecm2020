--drop table dbo.ptms_EvalR_03182011142027000
--select 'delete from  ' + name from sysobjects where xtype = 'U'
delete from  ptms_Classification
go
delete from  ptms_Course
go
delete from  ptms_CourseAvailLocation
go
delete from  ptms_CourseCert
go
delete from  ptms_CourseClassification
go
delete from  ptms_CourseEvalQuestion
go
delete from  ptms_CourseProvider
go
delete from  ptms_CourseURL
go
delete from  ptms_CourseWaiver
go
delete from  ptms_Department
go
delete from  ptms_DeptJob
go
delete from  ptms_EstExpense
go
delete from  ptms_Job
go
delete from  ptms_JobCourse
go
delete from ptms_Participant
where UserLoginID not like 'dale%'
and UserLoginID not like 'cathy%'
and UserLoginID not like 'spen%'

go
delete from  ptms_PreReq
go
delete from  ptms_CourseSchedule
go
delete from ptms_Provider
go
delete from  ptms_UserGridProfile
go
--delete from  ptms_SecurityAttr
go
delete from  ptms_UserDepartment
go
delete from  ptms_UserJob
go
delete from  ptms_CourseEnrollment
go
delete from  ptms_CourseLocation
go
delete from  ptms_UserScreenState
go
delete from  ptms_CourseStat
go
delete from  ptms_EvalResponse
go
delete from  ptms_CourseEvaluation
go
delete from  PgmTrace
go
delete from  ptms_AllowedExpense

update ptms_SecurityAttr set admin = 1 
where UserLoginID not like 'dale%'
and UserLoginID not like 'cathy%'
and UserLoginID not like 'spen%'


INSERT INTO [dbo].[ptms_SecurityAttr]
           ([Admin]
           ,[EditCourse]
           ,[EditProvider]
           ,[EditSchedule]
           ,[RunReports]
           ,[UserLoginID]
           ,[EditLookupData]
           ,[EditUsers])
     VALUES
           (1,
           1,
           1,
           1,
           1,
           'spencer.schwab@clydebergemann.com',
           1,
           1)
GO