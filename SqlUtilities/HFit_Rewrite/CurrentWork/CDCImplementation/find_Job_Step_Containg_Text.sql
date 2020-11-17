USE [msdb]
GO
SELECT	j.job_id,
	s.srvname,
	j.name,
	js.step_id,
	js.command,
	j.enabled 
FROM	dbo.sysjobs j
JOIN	dbo.sysjobsteps js
	ON	js.job_id = j.job_id 
JOIN	DFINAnalytics.dbo.sysservers s
	ON	s.srvid = j.originating_server_id
WHERE	js.command LIKE N'%TrackerCompositeDetails%'

USE msdb ;
GO

EXEC dbo.sp_update_job
    @job_name = N'NightlyBackups',
    @new_name = N'NightlyBackups -- Disabled',
    @description = N'Nightly backups disabled during server migration.',
    @enabled = 1 ;
GO