--RESTART FAILED JOBS
SELECT   'EXEC msdb..sp_start_job '''+SysJobs.name+'''' + char(10) + 'GO' as CMD,
		Job.instance_id
        ,SysJobs.job_id
        ,SysJobs.name as 'JOB_NAME'
        ,SysJobSteps.step_name as 'STEP_NAME'
        ,Job.run_status
        ,Job.sql_message_id
        ,Job.sql_severity
        ,Job.message
        ,Job.exec_date
        ,Job.run_duration
        ,Job.server
        ,SysJobSteps.output_file_name
    FROM    (SELECT Instance.instance_id
        ,DBSysJobHistory.job_id
        ,DBSysJobHistory.step_id
        ,DBSysJobHistory.sql_message_id
        ,DBSysJobHistory.sql_severity
        ,DBSysJobHistory.message
        ,(CASE DBSysJobHistory.run_status
            WHEN 0 THEN 'Failed'
            WHEN 1 THEN 'Succeeded'
            WHEN 2 THEN 'Retry'
            WHEN 3 THEN 'Canceled'
            WHEN 4 THEN 'In progress'
        END) as run_status
        ,((SUBSTRING(CAST(DBSysJobHistory.run_date AS VARCHAR(8)), 5, 2) + '/'
        + SUBSTRING(CAST(DBSysJobHistory.run_date AS VARCHAR(8)), 7, 2) + '/'
        + SUBSTRING(CAST(DBSysJobHistory.run_date AS VARCHAR(8)), 1, 4) + ' '
        + SUBSTRING((REPLICATE('0',6-LEN(CAST(DBSysJobHistory.run_time AS varchar)))
        + CAST(DBSysJobHistory.run_time AS VARCHAR)), 1, 2) + ':'
        + SUBSTRING((REPLICATE('0',6-LEN(CAST(DBSysJobHistory.run_time AS VARCHAR)))
        + CAST(DBSysJobHistory.run_time AS VARCHAR)), 3, 2) + ':'
        + SUBSTRING((REPLICATE('0',6-LEN(CAST(DBSysJobHistory.run_time as varchar)))
        + CAST(DBSysJobHistory.run_time AS VARCHAR)), 5, 2))) AS 'exec_date'
        ,DBSysJobHistory.run_duration
        ,DBSysJobHistory.retries_attempted
        ,DBSysJobHistory.server
        FROM msdb.dbo.sysjobhistory DBSysJobHistory
        JOIN (SELECT DBSysJobHistory.job_id
            ,DBSysJobHistory.step_id
            ,MAX(DBSysJobHistory.instance_id) as instance_id
            FROM msdb.dbo.sysjobhistory DBSysJobHistory
            GROUP BY DBSysJobHistory.job_id
            ,DBSysJobHistory.step_id
            ) AS Instance ON DBSysJobHistory.instance_id = Instance.instance_id
        WHERE DBSysJobHistory.run_status <> 1
        ) AS Job
    JOIN msdb.dbo.sysjobs SysJobs
       ON (Job.job_id = SysJobs.job_id)
    JOIN msdb.dbo.sysjobsteps SysJobSteps
       ON (Job.job_id = SysJobSteps.job_id AND Job.step_id = SysJobSteps.step_id)
where exec_date > getdate() -1


EXEC msdb..sp_start_job 'job_proc_BASE_EDW_RoleMemberToday_KenticoCMS_1_Delete' 
GO
EXEC msdb..sp_start_job 'job_proc_BASE_EDW_RoleMemberToday_KenticoCMS_2_Delete' 
GO
EXEC msdb..sp_start_job 'job_proc_BASE_HFit_HealthAssesmentUserRiskArea_KenticoCMS_1_ApplyCT'
 GO
EXEC msdb..sp_start_job 'job_proc_BASE_EDW_RoleMemberToday_KenticoCMS_1_ApplyCT' 
GO
EXEC msdb..sp_start_job 'job_proc_view_hfit_challenge_Joined_KenticoCMS_1' 
GO
EXEC msdb..sp_start_job 'job_proc_Hfit_HealthAssessmentDataForImport_KenticoCMS_1' 
GO
EXEC msdb..sp_start_job 'job_proc_HFit_HealthAssessmentDataForMissingResponses_KenticoCMS_1' 
GO
EXEC msdb..sp_start_job 'DBAPlatform - RefreshKenticoCMS_1' 
GO
EXEC msdb..sp_start_job 'instrument_disasterRecovery - backup_database_local_hourly_tran' 
GO
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
