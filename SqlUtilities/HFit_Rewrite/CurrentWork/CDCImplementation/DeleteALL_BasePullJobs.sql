USE msdb ;
GO
SELECT          
    'EXEC sp_delete_job @Job_name = ' + name + ';'
FROM
    msdb.dbo.sysjobs job
INNER JOIN 
    msdb.dbo.sysjobsteps steps        
ON
    job.job_id = steps.job_id
where name like 'job_EDW_GetStagingData%' or name like 'job_proc_BASE_%' or name like 'job_BASE_%'

GO

EXEC sp_delete_job @Job_name = job_proc_BASE_HFit_TrackerBloodSugarAndGlucose_KenticoCMS_3_ApplyCT;
EXEC sp_delete_job @Job_name = job_proc_BASE_HFit_HealthAssesmentUserRiskArea_KenticoCMS_1_ApplyCT;
