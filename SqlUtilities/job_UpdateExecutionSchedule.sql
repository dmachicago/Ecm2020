/*
SELECT top 10 
    JOB.NAME AS JOB_NAME,
    STEP.STEP_ID AS STEP_NUMBER,
    STEP.STEP_NAME AS STEP_NAME,
    STEP.COMMAND AS STEP_QUERY,
    DATABASE_NAME,
    JOB.JOB_ID,
    SCH.schedule_id,
    SCH.name as ScheduleName
*/
SELECT 'EXEC msdb.dbo.sp_update_jobschedule ' + char(10)
	   + '@job_name = "'+JOB.NAME+'"' + char(10)
	   + ',@name = "'+SCH.name+'"' + char(10)
	   + ',@enabled = 1' + char(10)
	   + ',@active_start_date = 20160213' + char(10) + 'GO' + char(10)
	   + ',@active_start_time = 210500; ' + char(10) as CMD
FROM Msdb.dbo.SysJobs JOB
INNER JOIN Msdb.dbo.SysJobSteps STEP ON STEP.Job_Id = JOB.Job_Id
INNER JOIN Msdb.dbo.SysJobSchedules JSCH ON JSCH.Job_Id = JOB.Job_Id    
INNER JOIN Msdb.dbo.SysSchedules SCH ON SCH.Schedule_ID = JSCH.Schedule_ID
WHERE JOB.Enabled = 1
AND (JOB.Name like '%_applyCT' OR STEP.COMMAND LIKE '%Exec proc%')
-- AND (JOB.Name like '%CMS_AttachmentHistory%' )
ORDER BY JOB.Job_Id , STEP.STEP_ID


-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
