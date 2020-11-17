exec sp_CalcEmployeeJobHrsCompleted 'dale@ecmlibrary.com','2000-11-01','2012-11-30'

select * from vDepartmentEmployeeJobCourseStatus

SELECT * FROM [dmaptms].[dbo].[TEMP_EmployeeJobHrsCompleted]
order by EmplLoginID, CourseID

alter procedure sp_CalcEmployeeJobHrsCompleted  @UID nvarchar(80), @StartDate datetime
   , @EndDate datetime
as
begin
delete from TEMP_EmployeeJobHrsCompleted where [UserLoginID] = @UID

INSERT INTO TEMP_EmployeeJobHrsCompleted ([UserLoginID],
	[DeptID],
	[CourseTitle],
	[Classification],
	[CourseID],
	[EmplLoginID],
	[EmployeeName],
	[AvgHrTrngCpe],
	[AvgNbrSaftyCnt],
	[PctCompleteReq])	
 SELECT @UID, DeptID, [CourseTitle], [Classification], [CourseID],
		[UserLoginID], 'Employee Name', -1, -1, -1
 FROM vDepartmentEmployeeJobCourseStatus
 WHERE
 vDepartmentEmployeeJobCourseStatus.CompletedDate BETWEEN @StartDate AND @EndDate

 /* Add the current number of required Safety Courses */
 update [dbo].[TEMP_EmployeeJobHrsCompleted]
set NbrReqSafetyCourses =
(
SELECT     COUNT(*) AS CNT
FROM         ptms_Course INNER JOIN
                      ptms_CourseClassification ON ptms_Course.CourseID = ptms_CourseClassification.CourseID
where ptms_CourseClassification.Classification = 'Safety'                      
GROUP BY ptms_CourseClassification.Classification
)

 /* Add the Employee's Name to the record */
 update [TEMP_EmployeeJobHrsCompleted] 
 set [EmployeeName] = (select LastName + ', ' + FirstName + ' ' + MiddleName 
						from ptms_Participant where ptms_Participant.UserLoginId = [TEMP_EmployeeJobHrsCompleted].EmplLoginID)

/* Add the Employee's count of safety courses completed */
update [TEMP_EmployeeJobHrsCompleted] 
 set AvgNbrSaftyCnt =
 (
 SELECT  count(*)
FROM         ptms_Course INNER JOIN
                      ptms_CourseStat ON ptms_Course.CourseID = ptms_CourseStat.CourseID INNER JOIN
                      ptms_Participant ON ptms_CourseStat.UserLoginID = ptms_Participant.UserLoginID INNER JOIN
                      ptms_CourseClassification ON ptms_Course.CourseID = ptms_CourseClassification.CourseID
Where ptms_CourseClassification.Classification = 'Safety'
and ptms_Participant.UserLoginID = TEMP_EmployeeJobHrsCompleted.EmplLoginID
and ptms_CourseStat.CompletedDate BETWEEN @StartDate AND @EndDate
)

/* Calculate the number of courses successfully completed by each user */
update [TEMP_EmployeeJobHrsCompleted] 
 set NbrCompletedSAfetyCourses =
 (
 SELECT  distinct count(*)
FROM         ptms_Course INNER JOIN
                      ptms_CourseStat ON ptms_Course.CourseID = ptms_CourseStat.CourseID INNER JOIN
                      ptms_Participant ON ptms_CourseStat.UserLoginID = ptms_Participant.UserLoginID INNER JOIN
                      ptms_CourseClassification ON ptms_Course.CourseID = ptms_CourseClassification.CourseID
Where ptms_CourseClassification.Classification = 'Safety'
and ptms_Participant.UserLoginID = TEMP_EmployeeJobHrsCompleted.EmplLoginID
and ptms_CourseStat.CompletedDate BETWEEN @StartDate AND @EndDate
)

/* Calculate the pct of safety courses successfully completed by each user */
UPDATE    TEMP_EmployeeJobHrsCompleted
SET       PctCompleteReq = NbrCompletedSAfetyCourses / TEMP_EmployeeJobHrsCompleted.NbrReqSafetyCourses * 100 
where NbrCompletedSAfetyCourses > 0

UPDATE    TEMP_EmployeeJobHrsCompleted
SET       PctCompleteReq = 0
where NbrCompletedSAfetyCourses = 0 or NbrCompletedSAfetyCourses is null

/* Calculate the "TOTAL" CPEs of an employee */
update TEMP_EmployeeJobHrsCompleted 
set TotalCpeForPeriod = (
SELECT      sum(CPE) as TotalCpeForPeriod
FROM        ptms_Course INNER JOIN
            ptms_CourseStat ON ptms_Course.CourseID = ptms_CourseStat.CourseID
where TEMP_EmployeeJobHrsCompleted.EmplLoginID = ptms_CourseStat.UserLoginID
and ptms_CourseStat.CompletedDate BETWEEN @StartDate AND @EndDate
)

/* Calculate the "AVERAGE" CPEs of an employee */            
update TEMP_EmployeeJobHrsCompleted 
set AvgCpeForPeriod = (
SELECT      Avg(CPE) as AvgCpeForPeriod
FROM        ptms_Course INNER JOIN
            ptms_CourseStat ON ptms_Course.CourseID = ptms_CourseStat.CourseID
where TEMP_EmployeeJobHrsCompleted.EmplLoginID = ptms_CourseStat.UserLoginID
and ptms_CourseStat.CompletedDate BETWEEN @StartDate AND @EndDate
)


/* Calculate the number of courses completed this period */
update TEMP_EmployeeJobHrsCompleted 
set NbrCompletedCoursesForPeriod = (
SELECT     Count(*) as CNT
FROM         ptms_CourseStat
where TEMP_EmployeeJobHrsCompleted.EmplLoginID = ptms_CourseStat.UserLoginID
and ptms_CourseStat.CompletedDate BETWEEN @StartDate AND @EndDate
group by UserLoginID
)

update TEMP_EmployeeJobHrsCompleted set AvgCpeForPeriod = TotalCpeForPeriod / NbrCompletedCoursesForPeriod

update TEMP_EmployeeJobHrsCompleted set AvgHrTrngCpe = TotalCpeForPeriod / NbrCompletedCoursesForPeriod 

END

/* Prove the couts are correct */
--select * from TEMP_EmployeeJobHrsCompleted where EmplLoginID = 'Abraham.Philip@clydebergemann.com'
--select * from ptms_CourseStat where UserLoginID = 'Abraham.Philip@clydebergemann.com'
--SELECT    UserLoginID, Count(*) as CNT
--FROM         ptms_CourseStat
--where --TEMP_EmployeeJobHrsCompleted.EmplLoginID = ptms_CourseStat.UserLoginID and
--ptms_CourseStat.CompletedDate BETWEEN '2000-01-01' AND '2012-11-11'
--group by UserLoginID

--alter table TEMP_EmployeeJobHrsCompleted add NbrCompletedCoursesForPeriod decimal (10,2) null

update TEMP_EmployeeJobHrsCompleted set AvgHrTrngCpe = TotalCpeForPeriod / NbrCompletedCoursesForPeriod 


select * from TEMP_EmployeeJobHrsCompleted
order by EmplLoginID 

SELECT      UserLoginId,
			sum(CPE) as TotalCpeForPeriod,
			AVG(cpe) as AvgCpeForPeriod
FROM        ptms_Course INNER JOIN
            ptms_CourseStat ON ptms_Course.CourseID = ptms_CourseStat.CourseID
group by UserLoginId            
order by ptms_CourseStat.UserLoginID          

/* The query to get the SAFETY Data needed to report */
select distinct EmployeeName, EmplLoginID, NbrCompletedSAfetyCourses, PctCompleteReq, NbrReqSafetyCourses
from TEMP_EmployeeJobHrsCompleted
order by EmployeeName

select EmployeeName, Classification, CourseTitle, CourseID, EmplLoginID, NbrCompletedCoursesForPeriod, TotalCpeForPeriod
from TEMP_EmployeeJobHrsCompleted
order by EmployeeName, Classification, CourseTitle


select * from TEMP_EmployeeJobHrsCompleted
select * from vEmployeeCompletedCourses

Create View vEmployeeCompletedCourses 
as
SELECT     ptms_Participant.UserLoginID, ptms_Participant.FirstName, ptms_Participant.MiddleName, ptms_Participant.LastName, ptms_Course.CourseTitle, 
                      ptms_Course.CourseID, ptms_CourseClassification.Classification, ptms_CourseStat.CompletedSuccessfully, ptms_CourseStat.CompletedDate, 
                      ptms_Course.CPE
FROM         ptms_Course INNER JOIN
                      ptms_CourseClassification ON ptms_Course.CourseID = ptms_CourseClassification.CourseID INNER JOIN
                      ptms_CourseStat ON ptms_Course.CourseID = ptms_CourseStat.CourseID INNER JOIN
                      ptms_Participant ON ptms_CourseStat.UserLoginID = ptms_Participant.UserLoginID
                      
                      

SELECT  count(*)
FROM         ptms_Course INNER JOIN
                      ptms_CourseStat ON ptms_Course.CourseID = ptms_CourseStat.CourseID INNER JOIN
                      ptms_Participant ON ptms_CourseStat.UserLoginID = ptms_Participant.UserLoginID INNER JOIN
                      ptms_CourseClassification ON ptms_Course.CourseID = ptms_CourseClassification.CourseID
Where ptms_CourseClassification.Classification = 'Safety'
and CompletedDate between '2011-11-01' and '2011-11-30'
and ptms_Participant.UserLoginID = 'spencer.schwab@clydebergemann.com'

/* Get Successfully completed safety courses count */						
SELECT DISTINCT ptms_CourseStat.UserLoginID, ptms_CourseClassification.Classification, COUNT(*) AS CNT
FROM         ptms_CourseStat LEFT OUTER JOIN
                      ptms_CourseClassification ON ptms_CourseStat.CourseID = ptms_CourseClassification.CourseID
WHERE     (ptms_CourseStat.CompletedDate BETWEEN '2011-11-15' AND '2011-11-30') AND (ptms_CourseClassification.Classification = 'Safety')
GROUP BY ptms_CourseStat.UserLoginID, ptms_CourseClassification.Classification, ptms_CourseStat.CompletedSuccessfully
/*************************************************************************/                      
 
 delete from TEMP_DeptSummaryHrs where [UserLoginID] = @UID
 
 INSERT INTO TEMP_DeptSummaryHrs (
	[UserLoginID],
	[DeptID],
	[AvgHrTrngCpe],
	[AvgNbrSaftyCnt],
	[PctCompleteReq],
	[TotalCpeRequired],
	[TotalCpeCompleted])	
 SELECT @UID, DeptID, -1, -1, -1,-1, -1
 FROM vDepartmentEmployeeJobCourseStatus
 
 select * from TEMP_DeptSummaryHrs
 
/*****************************************************************************/
delete from TEMP_DeptEmployeeHrs where [UserLoginID] = @UID
 
 INSERT INTO TEMP_DeptEmployeeHrs (
	[UserLoginID],
	[DeptID],
	[EmplLoginID],
	[EmployeeName],
	[AvgHrTrngCpe],
	[AvgNbrSaftyCnt],
	[PctCompleteReq]
	)
 SELECT @UID, DeptID, -1, -1, -1,-1, -1
 FROM vDepartmentEmployeeJobCourseStatus
 
 select * from TEMP_DeptSummaryHrs
 
 select * from vDepartmentEmployeeJobCourseStatus
 select distinct DeptID, UserLoginID, sum(CPE) as CPE, COUNT(*) as CNT 
 from vDepartmentEmployeeJobCourseStatus
 group by DeptID, UserLoginID
 order by DeptID, UserLoginID
 
 
 /**************************************************************************/
 --INSERT INTO [dmaptms].[dbo].[TEMP_DeptEmployeeHrs]
delete from TEMP_DeptEmployeeHrs where [UserLoginID] = @UID
 
 INSERT INTO TEMP_DeptEmployeeHrs (
	[UserLoginID],
	[DeptID],
	[EmplLoginID],
	[EmployeeName],
	[AvgHrTrngCpe],
	[AvgNbrSaftyCnt],
	[PctCompleteReq],
	[TotalCpeCompleted],
	[TotalCpeRequired]
	)
 SELECT distinct @UID, DeptID, [UserLoginID], 'EMP NAME',  -1, -1, -1,-1, -1
 FROM vDepartmentEmployeeJobCourseStatus
 
 update TEMP_DeptEmployeeHrs 
 set [EmployeeName] = (select LastName + ', ' + FirstName + ' ' + MiddleName 
						from ptms_Participant where ptms_Participant.UserLoginId = TEMP_DeptEmployeeHrs.EmplLoginID)
 
update TEMP_DeptEmployeeHrs set TotalCpeCompleted =
(
select sum(ptms_Course.CPE) as CPE
FROM         ptms_CourseStat INNER JOIN
                      ptms_Course ON ptms_CourseStat.CourseID = ptms_Course.CourseID INNER JOIN
                      ptms_CourseClassification ON ptms_Course.CourseID = ptms_CourseClassification.CourseID
 where ptms_CourseStat.CompletedSuccessfully = 1
 and TEMP_DeptEmployeeHrs.EmplLoginID = ptms_CourseStat.UserLoginID
 and ptms_CourseStat.CompletedDate between '2011-11-15' and '2011-11-30'
  group by ptms_CourseStat.UserLoginID
 )
 
 update TEMP_DeptEmployeeHrs set TotalCpeRequired =
(
SELECT     sum(ptms_Course.CPE)
FROM         ptms_JobCourse INNER JOIN
                      ptms_Course ON ptms_JobCourse.CourseID = ptms_Course.CourseID INNER JOIN
                      ptms_CourseStat ON ptms_JobCourse.CourseID = ptms_CourseStat.CourseID
WHERE     (TEMP_DeptEmployeeHrs.EmplLoginID = ptms_CourseStat.UserLoginID) AND (ptms_CourseStat.CompletedDate BETWEEN '2011-11-15' AND '2011-11-30')
GROUP BY ptms_CourseStat.UserLoginID
)

update TEMP_DeptEmployeeHrs set PctCompleteReq = TotalCpeCompleted / TotalCpeRequired * 100
where UserLoginID = @UID

update TEMP_DeptEmployeeHrs set AvgHrTrngCpe =
(
SELECT     avg(ptms_Course.CPE)
FROM         ptms_JobCourse INNER JOIN
                      ptms_Course ON ptms_JobCourse.CourseID = ptms_Course.CourseID INNER JOIN
                      ptms_CourseStat ON ptms_JobCourse.CourseID = ptms_CourseStat.CourseID
WHERE     (TEMP_DeptEmployeeHrs.EmplLoginID = ptms_CourseStat.UserLoginID) AND (ptms_CourseStat.CompletedDate BETWEEN '2011-11-15' AND '2011-11-30')
GROUP BY ptms_CourseStat.UserLoginID
)



--Get Number of Courses Completed successfully by an employee.
SELECT     count(*)
FROM         ptms_CourseStat
WHERE completedSuccessfully = 1 
and UserLoginID = 'Abraham.Philip@clydebergemann.com'
and CompletedDate between '2010-11-21' and '2011-11-21' 


--Get Number of Courses required by a department.
select * from TEMP_EmployeeJobHrsCompleted
