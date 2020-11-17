alter view vDeptJobs as 
SELECT     ptms_Department.DeptID, ptms_Job.JobID, ptms_Job.JobTitle, ptms_Job.JobDesc,  ptms_Department.DeptDesc
FROM         ptms_Department INNER JOIN
                      ptms_DeptJob ON ptms_Department.DeptID = ptms_DeptJob.DeptID RIGHT OUTER JOIN
                      ptms_Job ON ptms_DeptJob.JobID = ptms_Job.JobID
                      
select * from vDeptJobs
order by DeptID, JobID