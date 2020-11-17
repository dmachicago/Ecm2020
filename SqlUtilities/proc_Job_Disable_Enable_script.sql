
USE msdb ;
GO

--List all jobs
SELECT job_id, [name] FROM msdb.dbo.sysjobs
where NAme like 'JOB_EDW%' and NAme like '%stag%'  ;

--Disable ALL jobs

insert into MIGRATE_DataMart_Commands
SELECT 'exec dbo.sp_update_job @job_name = ''' +  [name] + '''' + ', @enabled = 0 ;' + char(10) + 'GO'  FROM msdb.dbo.sysjobs
where (NAme like '%Tracker%' or NAme like 'JOB_EDW%' or NAme like '%_CT_DIM_%' or NAme like '%_proc_BASE_%')  and NAme not like '%stag%'  ;


--Enable ALL jobs

insert into MIGRATE_DataMart_Commands
SELECT 'exec dbo.sp_update_job @job_name = ''' +  [name] + '''' + ', @enabled = 1 ;' + char(10) + 'GO'  FROM msdb.dbo.sysjobs
where (NAme like '%Tracker%' or NAme like 'JOB_EDW%' or NAme like '%_CT_DIM_%' or NAme like '%_proc_BASE_%')  and NAme not like '%stag%'  ;

EXEC dbo.sp_update_job
    @job_name = N'NightlyBackups',
    @new_name = N'NightlyBackups -- Disabled',
    @description = N'Nightly backups disabled during server migration.',
    @enabled = 1 ;
GO

exec dbo.sp_update_job @job_name = 'job_EDW_GetStagingData_BioMetrics_KenticoCMS_Prod1', @enabled = 0 ;
exec dbo.sp_update_job @job_name = 'job_EDW_GetStagingData_BioMetrics_KenticoCMS_Prod2', @enabled = 0 ;
exec dbo.sp_update_job @job_name = 'job_EDW_GetStagingData_BioMetrics_KenticoCMS_Prod3', @enabled = 0 ;
exec dbo.sp_update_job @job_name = 'job_EDW_GetStagingData_BioMetrics_KenticoCMS_QA', @enabled = 0 ;
exec dbo.sp_update_job @job_name = 'job_EDW_GetStagingData_Coaches_KenticoCMS_Prod1', @enabled = 0 ;
exec dbo.sp_update_job @job_name = 'job_EDW_GetStagingData_CoachingDefinition_KenticoCMS_Prod1', @enabled = 0 ;
exec dbo.sp_update_job @job_name = 'job_EDW_GetStagingData_CoachingDetail_KenticoCMS_Prod1', @enabled = 0 ;
exec dbo.sp_update_job @job_name = 'job_EDW_GetStagingData_CoachingDetail_KenticoCMS_Prod2', @enabled = 0 ;
exec dbo.sp_update_job @job_name = 'job_EDW_GetStagingData_CoachingDetail_KenticoCMS_Prod3', @enabled = 0 ;
exec dbo.sp_update_job @job_name = 'job_EDW_GetStagingData_CoachingDetail_KenticoCMS_QA', @enabled = 0 ;
exec dbo.sp_update_job @job_name = 'job_EDW_GetStagingData_HA_KenticoCMS_Prod1', @enabled = 0 ;
exec dbo.sp_update_job @job_name = 'job_EDW_GetStagingData_HA_KenticoCMS_Prod2', @enabled = 0 ;
exec dbo.sp_update_job @job_name = 'job_EDW_GetStagingData_HA_KenticoCMS_Prod3', @enabled = 0 ;
exec dbo.sp_update_job @job_name = 'job_EDW_GetStagingData_HA_KenticoCMS_QA', @enabled = 0 ;
exec dbo.sp_update_job @job_name = 'job_EDW_GetStagingData_HADefinition_KenticoCMS_Prod1', @enabled = 0 ;
exec dbo.sp_update_job @job_name = 'job_EDW_GetStagingData_HADefinition_KenticoCMS_Prod2', @enabled = 0 ;
exec dbo.sp_update_job @job_name = 'job_EDW_GetStagingData_HADefinition_KenticoCMS_Prod3', @enabled = 0 ;
exec dbo.sp_update_job @job_name = 'job_EDW_GetStagingData_HADefinition_KenticoCMS_QA', @enabled = 0 ;
exec dbo.sp_update_job @job_name = 'job_EDW_GetStagingData_RewardAwardDetail_KenticoCMS_Prod1', @enabled = 0 ;
exec dbo.sp_update_job @job_name = 'job_EDW_GetStagingData_RewardAwardDetail_KenticoCMS_Prod2', @enabled = 0 ;
exec dbo.sp_update_job @job_name = 'job_EDW_GetStagingData_RewardAwardDetail_KenticoCMS_Prod3', @enabled = 0 ;
exec dbo.sp_update_job @job_name = 'job_EDW_GetStagingData_RewardAwardDetail_KenticoCMS_QA', @enabled = 0 ;
exec dbo.sp_update_job @job_name = 'job_EDW_GetStagingData_RewardsDefinition_KenticoCMS_Prod1', @enabled = 0 ;
exec dbo.sp_update_job @job_name = 'job_EDW_GetStagingData_RewardsDefinition_KenticoCMS_Prod2', @enabled = 0 ;
exec dbo.sp_update_job @job_name = 'job_EDW_GetStagingData_RewardsDefinition_KenticoCMS_Prod3', @enabled = 0 ;
exec dbo.sp_update_job @job_name = 'job_EDW_GetStagingData_RewardsDefinition_KenticoCMS_QA', @enabled = 0 ;
exec dbo.sp_update_job @job_name = 'job_EDW_GetStagingData_RewardTriggerParameters_KenticoCMS_Prod1', @enabled = 0 ;
exec dbo.sp_update_job @job_name = 'job_EDW_GetStagingData_RewardTriggerParameters_KenticoCMS_Prod2', @enabled = 0 ;
exec dbo.sp_update_job @job_name = 'job_EDW_GetStagingData_RewardTriggerParameters_KenticoCMS_Prod3', @enabled = 0 ;
exec dbo.sp_update_job @job_name = 'job_EDW_GetStagingData_RewardTriggerParameters_KenticoCMS_QA', @enabled = 0 ;
exec dbo.sp_update_job @job_name = 'job_EDW_GetStagingData_RewardUserDetail_KenticoCMS_Prod1', @enabled = 0 ;
exec dbo.sp_update_job @job_name = 'job_EDW_GetStagingData_RewardUserDetail_KenticoCMS_Prod2', @enabled = 0 ;
exec dbo.sp_update_job @job_name = 'job_EDW_GetStagingData_RewardUserDetail_KenticoCMS_Prod3', @enabled = 0 ;
exec dbo.sp_update_job @job_name = 'job_EDW_GetStagingData_RewardUserDetail_KenticoCMS_QA', @enabled = 0 ;
exec dbo.sp_update_job @job_name = 'job_EDW_GetStagingData_RewardUserLevel_KenticoCMS_Prod1', @enabled = 0 ;
exec dbo.sp_update_job @job_name = 'job_EDW_GetStagingData_RewardUserLevel_KenticoCMS_Prod2', @enabled = 0 ;
exec dbo.sp_update_job @job_name = 'job_EDW_GetStagingData_RewardUserLevel_KenticoCMS_Prod3', @enabled = 0 ;
exec dbo.sp_update_job @job_name = 'job_EDW_GetStagingData_RewardUserLevel_KenticoCMS_QA', @enabled = 0 ;
exec dbo.sp_update_job @job_name = 'job_EDW_GetStagingData_SmallSteps_KenticoCMS_Prod1', @enabled = 0 ;
exec dbo.sp_update_job @job_name = 'job_EDW_GetStagingData_Trackers_KenticoCMS_Prod1', @enabled = 0 ;
exec dbo.sp_update_job @job_name = 'job_EDW_GetStagingData_Trackers_KenticoCMS_Prod2', @enabled = 0 ;
exec dbo.sp_update_job @job_name = 'job_EDW_GetStagingData_Trackers_KenticoCMS_Prod3', @enabled = 0 ;
exec dbo.sp_update_job @job_name = 'job_EDW_GetStagingData_Trackers_KenticoCMS_QA', @enabled = 0 ;
 


-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
