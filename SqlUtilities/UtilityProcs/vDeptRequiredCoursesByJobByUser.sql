Alter view vDeptRequiredCoursesByJobByUser as 
SELECT     ptms_Department.DeptID, ptms_DeptJob.JobID, ptms_UserDepartment.UserLoginID, ptms_JobCourse.requiredForJob, ptms_Course.CourseID, 
                      ptms_Course.CourseTitle, ptms_CourseClassification.Classification, ptms_Course.CPE, ptms_CourseStat.CompletedSuccessfully, 
                      ptms_CourseStat.CompletedDate
FROM         ptms_UserDepartment INNER JOIN
                      ptms_UserJob ON ptms_UserDepartment.UserLoginID = ptms_UserJob.UserLoginID INNER JOIN
                      ptms_DeptJob INNER JOIN
                      ptms_Department ON ptms_DeptJob.DeptID = ptms_Department.DeptID ON ptms_UserDepartment.DeptID = ptms_DeptJob.DeptID AND 
                      ptms_UserJob.JobID = ptms_DeptJob.JobID INNER JOIN
                      ptms_Course INNER JOIN
                      ptms_JobCourse ON ptms_Course.CourseID = ptms_JobCourse.CourseID ON ptms_UserJob.JobID = ptms_JobCourse.JobID INNER JOIN
                      ptms_CourseClassification ON ptms_Course.CourseID = ptms_CourseClassification.CourseID LEFT OUTER JOIN
                      ptms_CourseStat ON ptms_UserJob.UserLoginID = ptms_CourseStat.UserLoginID AND ptms_JobCourse.CourseID = ptms_CourseStat.CourseID
ORDER BY ptms_Department.DeptID,ptms_DeptJob.JobID, ptms_Course.CourseTitle, ptms_Course.CourseID

select DeptID, sum(cpe) as vDeptRequiredCoursesByJobByUser
from vDeptRequiredCoursesByJob
group by DeptID