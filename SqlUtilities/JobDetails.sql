/*
The following is a brief description of each of the fields returned from the above query:

[JobID]: A unique identifier for the SQL Server Agent job (GUID).
[JobName]: Name of the SQL Server Agent job.
[JobOwner]: Owner of the job.
[JobCategory]: Category to which the job belongs like Replication Snapshot, Database Maintenance, Log Shipping, etc.
[JobDescription]: Description of the job.
[IsEnabled]: Indicator representing whether the job is enabled or disabled.
[JobCreatedOn]: Date and time when the job was created.
[JobLastModifiedOn]: Date and time when the job was last modified.
[OriginatingServerName]: Server from which the job executed.
[JobStartStepNo]: Step number from which the job is set to start. SQL Server allows us to have multiple steps within a job and the job can be set to start from whichever step the user wants it to start from.
[JobStartStepName]: Name of the step from which the job is set to start.
[IsScheduled]: Indicator representing whether the job is scheduled or not. The jobs can be either scheduled to run on specified day(s) at a specified time or can be invoked through code like T-SQL, etc.
[JobScheduleID]: Unique identifier of the schedule associated with the job (GUID).
[JobScheduleName]: Name of the schedule associated with the job. SQL Server allows us to associate multiple schedules with one job, in which case, the above query would return one row for each schedule associated with each job.
[JobDeletionCriterion]: The criterion for deleting the job. SQL Server Agent has a feature which allows us to delete/drop the job based on a certain criterion so that there is no need to manually delete/cleanup the jobs.
*/

SELECT 
    [sJOB].[job_id] AS [JobID]
    , [sJOB].[name] AS [JobName]
    , [sDBP].[name] AS [JobOwner]
    , [sCAT].[name] AS [JobCategory]
    , [sJOB].[description] AS [JobDescription]
    , CASE [sJOB].[enabled]
        WHEN 1 THEN 'Yes'
        WHEN 0 THEN 'No'
      END AS [IsEnabled]
    , [sJOB].[date_created] AS [JobCreatedOn]
    , [sJOB].[date_modified] AS [JobLastModifiedOn]
    , [sSVR].[name] AS [OriginatingServerName]
    , [sJSTP].[step_id] AS [JobStartStepNo]
    , [sJSTP].[step_name] AS [JobStartStepName]
    , CASE
        WHEN [sSCH].[schedule_uid] IS NULL THEN 'No'
        ELSE 'Yes'
      END AS [IsScheduled]
    , [sSCH].[schedule_uid] AS [JobScheduleID]
    , [sSCH].[name] AS [JobScheduleName]
    , CASE [sJOB].[delete_level]
        WHEN 0 THEN 'Never'
        WHEN 1 THEN 'On Success'
        WHEN 2 THEN 'On Failure'
        WHEN 3 THEN 'On Completion'
      END AS [JobDeletionCriterion]
FROM
    [msdb].[dbo].[sysjobs] AS [sJOB]
    LEFT JOIN [msdb].[sys].[servers] AS [sSVR]
        ON [sJOB].[originating_server_id] = [sSVR].[server_id]
    LEFT JOIN [msdb].[dbo].[syscategories] AS [sCAT]
        ON [sJOB].[category_id] = [sCAT].[category_id]
    LEFT JOIN [msdb].[dbo].[sysjobsteps] AS [sJSTP]
        ON [sJOB].[job_id] = [sJSTP].[job_id]
        AND [sJOB].[start_step_id] = [sJSTP].[step_id]
    LEFT JOIN [msdb].[sys].[database_principals] AS [sDBP]
        ON [sJOB].[owner_sid] = [sDBP].[sid]
    LEFT JOIN [msdb].[dbo].[sysjobschedules] AS [sJOBSCH]
        ON [sJOB].[job_id] = [sJOBSCH].[job_id]
    LEFT JOIN [msdb].[dbo].[sysschedules] AS [sSCH]
        ON [sJOBSCH].[schedule_id] = [sSCH].[schedule_id]
ORDER BY [JobName]
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
