
create view vCourseCompletionDeptEmpl as
SELECT     ptms_Course.CourseTitle, ptms_Course.CPE, ptms_CourseStat.UserLoginID, ptms_CourseStat.CourseGrade, ptms_CourseStat.CPE_Credits, 
                      ptms_CourseClassification.Classification, ptms_CourseStat.CompletedSuccessfully, ptms_CourseStat.CompletedDate, ptms_Course.CourseID, 
                      ptms_UserDepartment.DeptID, ptms_UserJob.JobID, ptms_Participant.FirstName, ptms_Participant.MiddleName, ptms_Participant.LastName
FROM         ptms_CourseProvider INNER JOIN
                      ptms_Course INNER JOIN
                      ptms_CourseClassification ON ptms_Course.CourseID = ptms_CourseClassification.CourseID ON ptms_CourseProvider.CourseID = ptms_Course.CourseID INNER JOIN
                      ptms_CourseStat ON ptms_CourseProvider.CourseID = ptms_CourseStat.CourseID AND ptms_CourseProvider.ProviderID = ptms_CourseStat.ProviderID INNER JOIN
                      ptms_Participant ON ptms_CourseStat.UserLoginID = ptms_Participant.UserLoginID LEFT OUTER JOIN
                      ptms_UserDepartment ON ptms_CourseStat.UserLoginID = ptms_UserDepartment.UserLoginID LEFT OUTER JOIN
                      ptms_JobCourse ON ptms_Course.CourseID = ptms_JobCourse.CourseID LEFT OUTER JOIN
                      ptms_UserJob ON ptms_CourseStat.UserLoginID = ptms_UserJob.UserLoginID


select * from vCourseCompletionDeptEmpl
where JobID is not null
order by UserLoginID, CourseID, JobID

update ptms_Course set CPE = 1 where CPE = 0
update ptms_Course set MinWaitMonths = 99 where MinWaitMonths is null