                     
select * from vWeeklySchedule  
where cast (startDate as datetime) between '2012-02-20' and '2012-02-29'
order by CourseTitle
                    
select * from vDeptRequiredCoursesByJobByUser 
order by DeptID, JobID
               
select * from vEmployeeCourseCompletionStats
select * from vDepartmentEmployeeJobCourseStatus
select * from vDepartmentEmployeeJobCourses
select * from vDepartmentEmployees

select * from vJobReqiredCourses

select * from vDepartmentJobCourses
select * from vDepartmentJobs
select * from vDepartments


select * from vDepartmentJobCourses
order by DeptID, CourseID

select distinct DeptID, CourseID, COUNT(*) from vDepartmentJobCourses
group by DeptID, CourseID
order by DeptID, CourseID


