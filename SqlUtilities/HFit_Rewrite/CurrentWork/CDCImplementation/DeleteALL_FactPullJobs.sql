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
where name like 'job_EDW_GetStagingData%' or name like 'job_proc_FACT_%' or name like 'job_FACT_%'

GO

EXEC sp_delete_job @Job_name = job_proc_FACT_CMS_Site_KenticoCMS_2_ApplyCT;
EXEC sp_delete_job @Job_name = job_proc_FACT_CMS_Tree_ApplyCT;
EXEC sp_delete_job @Job_name = job_proc_FACT_cms_user_ApplyCT;
EXEC sp_delete_job @Job_name = job_proc_FACT_CMS_Site_KenticoCMS_3_ApplyCT;
EXEC sp_delete_job @Job_name = job_proc_FACT_CMS_Site_KenticoCMS_1_ApplyCT;