alter view vDeptRequiredCoursesByJob as 
SELECT     ptms_Department.DeptID, ptms_Job.JobTitle, ptms_Course.CourseTitle, ptms_Course.CourseID,  ptms_Job.JobID, ptms_JobCourse.requiredForJob, 
                      ptms_CourseClassification.Classification, ptms_Course.CPE
FROM         ptms_Job INNER JOIN
                      ptms_DeptJob ON ptms_Job.JobID = ptms_DeptJob.JobID INNER JOIN
                      ptms_JobCourse ON ptms_Job.JobID = ptms_JobCourse.JobID INNER JOIN
                      ptms_Course ON ptms_JobCourse.CourseID = ptms_Course.CourseID INNER JOIN
                      ptms_Department ON ptms_DeptJob.DeptID = ptms_Department.DeptID INNER JOIN
                      ptms_CourseClassification ON ptms_Course.CourseID = ptms_CourseClassification.CourseID
ORDER BY ptms_Department.DeptID, ptms_Job.JobTitle, ptms_Course.CourseTitle, ptms_Course.CourseID

select DeptID, sum(cpe) as TotalHoursOffered
from vDeptRequiredCoursesByJob
group by DeptID