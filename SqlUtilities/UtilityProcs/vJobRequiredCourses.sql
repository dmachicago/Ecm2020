create view vDeptJobRequiredCourses as                       
SELECT     ptms_Course.CourseID, ptms_Course.CourseTitle, ptms_Course.CourseDescription, ptms_Job.JobID, ptms_Job.JobTitle, ptms_Department.DeptID, 
                      ptms_Department.DeptDesc, ptms_JobCourse.requiredForJob
FROM         ptms_Job INNER JOIN
                      ptms_DeptJob ON ptms_Job.JobID = ptms_DeptJob.JobID INNER JOIN
                      ptms_JobCourse ON ptms_Job.JobID = ptms_JobCourse.JobID INNER JOIN
                      ptms_Course ON ptms_JobCourse.CourseID = ptms_Course.CourseID INNER JOIN
                      ptms_Department ON ptms_DeptJob.DeptID = ptms_Department.DeptID                  
                      
select * from  vDeptJobRequiredCourses                      