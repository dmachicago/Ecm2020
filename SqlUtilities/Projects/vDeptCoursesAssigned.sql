alter view vDeptCoursesAssigned as 
SELECT   distinct  ptms_DeptJob.DeptID, ptms_Course.CourseTitle, ptms_Course.CPE, ptms_CourseClassification.Classification, ptms_Course.CourseID
FROM         ptms_CourseClassification INNER JOIN
                      ptms_JobCourse INNER JOIN
                      ptms_DeptJob INNER JOIN
                      ptms_Department ON ptms_DeptJob.DeptID = ptms_Department.DeptID ON ptms_JobCourse.JobID = ptms_DeptJob.JobID INNER JOIN
                      ptms_Course ON ptms_JobCourse.CourseID = ptms_Course.CourseID ON ptms_CourseClassification.CourseID = ptms_Course.CourseID     
order by ptms_DeptJob.DeptID, ptms_Course.CourseTitle