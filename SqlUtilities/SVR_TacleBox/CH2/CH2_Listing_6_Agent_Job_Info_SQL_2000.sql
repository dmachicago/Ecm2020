SELECT  CONVERT(nvarchar(128), SERVERPROPERTY('Servername')) AS Server,
        msdb.dbo.sysjobs.job_id,
        msdb.dbo.sysjobs.name,
        msdb.dbo.sysjobs.enabled AS Job_Enabled,
        msdb.dbo.sysjobs.description,
        msdb.dbo.sysjobs.notify_level_eventlog,
        msdb.dbo.sysjobs.notify_level_email,
        msdb.dbo.sysjobs.notify_level_netsend,
        msdb.dbo.sysjobs.notify_level_page,
        msdb.dbo.sysjobs.notify_email_operator_id,
        msdb.dbo.sysjobs.date_created,
        msdb.dbo.syscategories.name AS Category_Name,
        msdb.dbo.sysjobschedules.next_run_date,
        msdb.dbo.sysjobschedules.next_run_time,
        msdb.dbo.sysjobservers.last_run_outcome,
        msdb.dbo.sysjobservers.last_outcome_message,
        msdb.dbo.sysjobservers.last_run_date,
        msdb.dbo.sysjobservers.last_run_time,
        msdb.dbo.sysjobservers.last_run_duration,
        msdb.dbo.sysoperators.name AS Notify_Operator,
        msdb.dbo.sysoperators.email_address,
        msdb.dbo.sysjobs.date_modified,
        GETDATE() AS Package_run_date,
        msdb.dbo.sysjobs.version_number AS Job_Version,
        msdb.dbo.sysjobschedules.name AS Schedule_Name,
        msdb.dbo.sysjobschedules.enabled,
        msdb.dbo.sysjobschedules.freq_type,
        msdb.dbo.sysjobschedules.freq_interval,
        msdb.dbo.sysjobschedules.freq_subday_type,
        msdb.dbo.sysjobschedules.freq_subday_interval,
        msdb.dbo.sysjobschedules.freq_relative_interval,
        msdb.dbo.sysjobschedules.freq_recurrence_factor,
        msdb.dbo.sysjobschedules.active_start_date,
        msdb.dbo.sysjobschedules.active_end_date,
        msdb.dbo.sysjobschedules.active_start_time
FROM    msdb.dbo.sysjobs
        INNER JOIN msdb.dbo.syscategories ON msdb.dbo.sysjobs.category_id = msdb.dbo.syscategories.category_id
        LEFT OUTER JOIN msdb.dbo.sysoperators ON msdb.dbo.sysjobs.notify_page_operator_id = msdb.dbo.sysoperators.id
        LEFT OUTER JOIN msdb.dbo.sysjobservers ON msdb.dbo.sysjobs.job_id = msdb.dbo.sysjobservers.job_id
        LEFT OUTER JOIN msdb.dbo.sysjobschedules ON msdb.dbo.sysjobschedules.job_id = msdb.dbo.sysjobs.job_id