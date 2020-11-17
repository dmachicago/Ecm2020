create view vJobCourses as
SELECT     ptms_Course.CourseID, ptms_Course.CourseTitle, ptms_Course.CourseDescription, ptms_Job.JobID, ptms_Job.JobTitle, ptms_JobCourse.requiredForJob
FROM         ptms_Job INNER JOIN
                      ptms_JobCourse ON ptms_Job.JobID = ptms_JobCourse.JobID INNER JOIN
                      ptms_Course ON ptms_JobCourse.CourseID = ptms_Course.CourseID


SELECT *
FROM       vJobCourses
order by JobID                      

SELECT *
FROM       vJobCourses
where JobID = 'Assembly Supervisor'
order by JobID                      

SELECT     COUNT(*)
FROM       vJobCourses
where JobID = 'Assembly Supervisor'