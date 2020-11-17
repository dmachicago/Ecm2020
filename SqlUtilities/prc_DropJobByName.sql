
create PROCEDURE prc_DropJobByName (
       @JobName AS NVARCHAR (25)) 
AS
BEGIN
    DECLARE
           @jobId BINARY (16) ;
    SELECT
           @jobId = job_id
    FROM msdb.dbo.sysjobs
    WHERE name = @JobName;
    IF @jobId IS NOT NULL
        BEGIN
            EXEC msdb.dbo.sp_delete_job @jobId;
        END;
    else 
	   print @JobName + 'NOT FOUND.';
END;

GO
SELECT
       sJSTP.database_name AS [Database]
     , sJOB.job_id AS JobID
     , sJOB.name AS JobName
     , sDBP.name AS JobOwner
     , sCAT.name AS JobCategory
     , sJOB.description AS JobDescription
     , CASE sJOB.enabled
           WHEN 1
               THEN 'Yes'
           WHEN 0
               THEN 'No'
       END AS IsEnabled
     , sJOB.date_created AS JobCreatedOn
     , sJOB.date_modified AS JobLastModifiedOn
     , sSVR.name AS OriginatingServerName
     , sJSTP.step_id AS JobStartStepNo
     , sJSTP.step_name AS JobStartStepName
     , CASE
           WHEN sSCH.schedule_uid IS NULL
               THEN 'No'
           ELSE 'Yes'
       END AS IsScheduled
     , sSCH.schedule_uid AS JobScheduleID
     , sSCH.name AS JobScheduleName
     , CASE sJOB.delete_level
           WHEN 0
               THEN 'Never'
           WHEN 1
               THEN 'On Success'
           WHEN 2
               THEN 'On Failure'
           WHEN 3
               THEN 'On Completion'
       END AS JobDeletionCriterion
     , ' EXEC msdb.dbo.prc_DropJobByName ' + sJOB.name AS DropDDL
     , ' EXEC msdb.dbo.sp_delete_job ''' + cast(sJOB.job_id as nvarchar(50)) + '''' AS DropByID 
FROM msdb.dbo.sysjobs AS sJOB
     LEFT JOIN msdb.sys.servers AS sSVR
     ON
       sJOB.originating_server_id = sSVR.server_id
     LEFT JOIN msdb.dbo.syscategories AS sCAT
     ON
       sJOB.category_id = sCAT.category_id
     LEFT JOIN msdb.dbo.sysjobsteps AS sJSTP
     ON
       sJOB.job_id = sJSTP.job_id AND
       sJOB.start_step_id = sJSTP.step_id
     LEFT JOIN msdb.sys.database_principals AS sDBP
     ON
       sJOB.owner_sid = sDBP.sid
     LEFT JOIN msdb.dbo.sysjobschedules AS sJOBSCH
     ON
       sJOB.job_id = sJOBSCH.job_id
     LEFT JOIN msdb.dbo.sysschedules AS sSCH
     ON
       sJOBSCH.schedule_id = sSCH.schedule_id
WHERE
       sJSTP.database_name != 'KenticoCMS_DataMart_2' AND
       (
       sJOB.name LIKE 'job_edw%' OR
       sJOB.name LIKE 'job_proc%') 
ORDER BY
         JobName;


-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
