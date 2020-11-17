SELECT JOB.NAME AS JOB_NAME,
STEP.STEP_ID AS STEP_NUMBER,
STEP.STEP_NAME AS STEP_NAME,
STEP.COMMAND AS STEP_QUERY,
DATABASE_NAME
FROM Msdb.dbo.SysJobs JOB
INNER JOIN Msdb.dbo.SysJobSteps STEP ON STEP.Job_Id = JOB.Job_Id
WHERE JOB.Enabled = 1
AND (JOB.Name = '%_applyCT%' OR STEP.COMMAND LIKE '%Exec proc%')
ORDER BY JOB.NAME, STEP.STEP_ID
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
