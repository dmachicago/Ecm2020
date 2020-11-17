use msdb

-- SET ALL JOBS TO STORE JOB OUTPUT IN TABLE AND WITH HISTORY
USE [msdb]
GO
--Set LOGS to overwrite
--EXEC msdb.dbo.sp_update_jobstep @job_id=N'0218cb4e-6f73-477d-ae09-8b95121d3baa', @step_id=1 , @flags=12, @database_name=N'DataMartPlatform'
--Set LOGS to append
EXEC msdb.dbo.sp_update_jobstep @job_name='job_proc_BASE_Board_Message_KenticoCMS_1_ApplyCT', @step_id=2 , @flags=20, @database_name=N'DataMartPlatform'
GO

--READ THE LOG
EXEC msdb..sp_help_jobsteplog @job_name = N'job_proc_BASE_CMS_WorkflowStepRoles_KenticoCMS_1_ApplyCT';
go

SELECT 'EXEC msdb.dbo.sp_update_jobstep @job_name='''+JOB.NAME+''', @step_id='+cast(STEP.STEP_ID as nvarchar(10))+' , @flags=20, @database_name=N''DataMartPlatform'' ' + char(10) + 'GO' as CMD,
    JOB.NAME AS JOB_NAME,
    STEP.STEP_ID AS STEP_NUMBER,
    STEP.STEP_NAME AS STEP_NAME,
    STEP.COMMAND AS STEP_QUERY,
    DATABASE_NAME
FROM Msdb.dbo.SysJobs JOB
INNER JOIN Msdb.dbo.SysJobSteps STEP ON STEP.Job_Id = JOB.Job_Id
WHERE JOB.Enabled = 1
AND JOB.Name like 'job_proc%'
ORDER BY JOB.NAME, STEP.STEP_ID

GO