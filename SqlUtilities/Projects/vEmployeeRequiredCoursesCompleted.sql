Create view vEmployeeRequiredCoursesCompleted as                       
SELECT     ptms_Participant.LastName + ', ' + ptms_Participant.FirstName + ' ' + ptms_Participant.MiddleName AS EmplName, ptms_Course.CourseID, ptms_Course.CourseTitle, 
                      ptms_Job.JobID, ptms_Job.JobTitle, ptms_JobCourse.requiredForJob, ptms_Participant.UserLoginID, ptms_Department.DeptID, 
                      ptms_CourseStat.CompletedSuccessfully, ptms_CourseStat.CPE_Credits, ptms_CourseStat.CompletedDate
FROM         ptms_CourseStat RIGHT OUTER JOIN
                      ptms_Participant INNER JOIN
                      ptms_UserJob ON ptms_Participant.UserLoginID = ptms_UserJob.UserLoginID INNER JOIN
                      ptms_Job INNER JOIN
                      ptms_JobCourse ON ptms_Job.JobID = ptms_JobCourse.JobID INNER JOIN
                      ptms_Course ON ptms_JobCourse.CourseID = ptms_Course.CourseID ON ptms_UserJob.JobID = ptms_JobCourse.JobID ON 
                      ptms_CourseStat.CourseID = ptms_Course.CourseID AND ptms_CourseStat.UserLoginID = ptms_Participant.UserLoginID LEFT OUTER JOIN
                      ptms_DeptJob INNER JOIN
                      ptms_Department ON ptms_DeptJob.DeptID = ptms_Department.DeptID ON ptms_Job.JobID = ptms_DeptJob.JobID              
                      
--select * from  vEmployeeRequiredCourses                      