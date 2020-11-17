--FIND STEP NAME with Text
SELECT s.step_id,
       j.[name],
       s.database_name,
       s.command
FROM   msdb.dbo.sysjobsteps AS s
INNER JOIN msdb.dbo.sysjobs AS j ON  s.job_id = j.job_id
WHERE  s.command LIKE '%proc_View_CMS_Tree_Joined_KenticoCMS%'


SELECT  'exec msdb..sp_update_job @job_name = ''' + s.name + ''', @enabled = 1 ; '
FROM    msdb..sysjobs s 
where name like '%ApplyCT'
--and name not like 'job_EDW_GetStagingData_CMS_User%'
ORDER BY name

SELECT  'exec msdb..sp_update_job @job_name = ''' + s.name + ''', @enabled = 1 ; '
FROM    msdb..sysjobs s 
where name like '%view%'
--and name not like 'job_EDW_GetStagingData_CMS_User%'
ORDER BY name

--exec proc_EnableAuditControl

SELECT  'exec msdb..sp_update_job @job_name = ''' + s.name + ''', @enabled = 0 ; '
FROM    msdb..sysjobs s 
where name like 'job_EDW%' 
and name not like '%GetStagingData_HFIT_PPTEligibility%'
--and name not like 'job_EDW_GetStagingData_CMS_User%'
ORDER BY name

exec msdb..sp_update_job @job_name = 'job_EDW_CT_HA_MarkDeletedRecords_KenticoCMSStage', @enabled = 0 ; 
exec msdb..sp_update_job @job_name = 'job_EDW_CT_HA_MarkDeletedRecords_KenticoCMSTest', @enabled = 0 ; 
exec msdb..sp_update_job @job_name = 'job_EDW_CT_HA_MarkNewRecords_KenticoCMSStage', @enabled = 0 ; 
exec msdb..sp_update_job @job_name = 'job_EDW_CT_HA_MarkNewRecords_KenticoCMSTest', @enabled = 0 ; 
exec msdb..sp_update_job @job_name = 'job_EDW_CT_HA_MarkUpdatedRecords_KenticoCMSStage', @enabled = 0 ; 
exec msdb..sp_update_job @job_name = 'job_EDW_CT_HA_MarkUpdatedRecords_KenticoCMSTest', @enabled = 0 ; 
exec msdb..sp_update_job @job_name = 'job_EDW_Generate_BMI_Staging_Data_KenticoCMSTest', @enabled = 0 ; 
exec msdb..sp_update_job @job_name = 'job_EDW_GetStagingData_BioMetrics_KenticoCMSStage', @enabled = 0 ; 
exec msdb..sp_update_job @job_name = 'job_EDW_GetStagingData_BioMetrics_KenticoCMSTest', @enabled = 0 ; 
exec msdb..sp_update_job @job_name = 'job_EDW_GetStagingData_CMS_UserSettings_KenticoCMSCloudtst2', @enabled = 0 ; 
exec msdb..sp_update_job @job_name = 'job_EDW_GetStagingData_CMS_UserSettings_KenticoCMSDev', @enabled = 0 ; 
exec msdb..sp_update_job @job_name = 'job_EDW_GetStagingData_CMS_UserSettings_KenticoCMSStage', @enabled = 0 ; 
exec msdb..sp_update_job @job_name = 'job_EDW_GetStagingData_CMS_UserSettings_KenticoCMSTest', @enabled = 0 ; 
exec msdb..sp_update_job @job_name = 'job_EDW_GetStagingData_CMS_UserSite_KenticoCMSCloudtst2', @enabled = 0 ; 
exec msdb..sp_update_job @job_name = 'job_EDW_GetStagingData_CMS_UserSite_KenticoCMSDev', @enabled = 0 ; 
exec msdb..sp_update_job @job_name = 'job_EDW_GetStagingData_CMS_UserSite_KenticoCMSStage', @enabled = 0 ; 
exec msdb..sp_update_job @job_name = 'job_EDW_GetStagingData_CMS_UserSite_KenticoCMSTest', @enabled = 0 ; 
exec msdb..sp_update_job @job_name = 'job_EDW_GetStagingData_CoachingDetail_HFITCRMDev', @enabled = 0 ; 
exec msdb..sp_update_job @job_name = 'job_EDW_GetStagingData_CoachingDetail_KenticoCMSDev', @enabled = 0 ; 
exec msdb..sp_update_job @job_name = 'job_EDW_GetStagingData_CoachingDetail_KenticoCMSStage', @enabled = 0 ; 
exec msdb..sp_update_job @job_name = 'job_EDW_GetStagingData_CoachingDetail_KenticoCMSTest', @enabled = 0 ; 
exec msdb..sp_update_job @job_name = 'job_EDW_GetStagingData_CT_USER_KenticoCMSCloudtst2', @enabled = 0 ; 
exec msdb..sp_update_job @job_name = 'job_EDW_GetStagingData_CT_USER_KenticoCMSDev', @enabled = 0 ; 
exec msdb..sp_update_job @job_name = 'job_EDW_GetStagingData_CT_USER_KenticoCMSStage', @enabled = 0 ; 
exec msdb..sp_update_job @job_name = 'job_EDW_GetStagingData_CT_USER_KenticoCMSTest', @enabled = 0 ; 
exec msdb..sp_update_job @job_name = 'job_EDW_GetStagingData_HA_KenticoCMSDev', @enabled = 0 ; 
exec msdb..sp_update_job @job_name = 'job_EDW_GetStagingData_HA_KenticoCMSStage', @enabled = 0 ; 
exec msdb..sp_update_job @job_name = 'job_EDW_GetStagingData_HA_KenticoCMSTest', @enabled = 0 ; 
exec msdb..sp_update_job @job_name = 'job_EDW_GetStagingData_HADefinition_HFITCRMDev', @enabled = 0 ; 
exec msdb..sp_update_job @job_name = 'job_EDW_GetStagingData_HADefinition_KenticoCMSDev', @enabled = 0 ; 
exec msdb..sp_update_job @job_name = 'job_EDW_GetStagingData_HADefinition_KenticoCMSStage', @enabled = 0 ; 
exec msdb..sp_update_job @job_name = 'job_EDW_GetStagingData_HADefinition_KenticoCMSTest', @enabled = 0 ; 
exec msdb..sp_update_job @job_name = 'job_EDW_GetStagingData_RewardAwardDetail_HFITCRMDev', @enabled = 0 ; 
exec msdb..sp_update_job @job_name = 'job_EDW_GetStagingData_RewardAwardDetail_KenticoCMSDev', @enabled = 0 ; 
exec msdb..sp_update_job @job_name = 'job_EDW_GetStagingData_RewardAwardDetail_KenticoCMSStage', @enabled = 0 ; 
exec msdb..sp_update_job @job_name = 'job_EDW_GetStagingData_RewardAwardDetail_KenticoCMSTest', @enabled = 0 ; 
exec msdb..sp_update_job @job_name = 'job_EDW_GetStagingData_RewardsDefinition_HFITCRMDev', @enabled = 0 ; 
exec msdb..sp_update_job @job_name = 'job_EDW_GetStagingData_RewardsDefinition_KenticoCMSDev', @enabled = 0 ; 
exec msdb..sp_update_job @job_name = 'job_EDW_GetStagingData_RewardsDefinition_KenticoCMSStage', @enabled = 0 ; 
exec msdb..sp_update_job @job_name = 'job_EDW_GetStagingData_RewardsDefinition_KenticoCMSTest', @enabled = 0 ; 
exec msdb..sp_update_job @job_name = 'job_EDW_GetStagingData_RewardTriggerParameters_HFITCRMDev', @enabled = 0 ; 
exec msdb..sp_update_job @job_name = 'job_EDW_GetStagingData_RewardTriggerParameters_KenticoCMSDev', @enabled = 0 ; 
exec msdb..sp_update_job @job_name = 'job_EDW_GetStagingData_RewardTriggerParameters_KenticoCMSStage', @enabled = 0 ; 
exec msdb..sp_update_job @job_name = 'job_EDW_GetStagingData_RewardTriggerParameters_KenticoCMSTest', @enabled = 0 ; 
exec msdb..sp_update_job @job_name = 'job_EDW_GetStagingData_RewardUserDetail_HFITCRMDev', @enabled = 0 ; 
exec msdb..sp_update_job @job_name = 'job_EDW_GetStagingData_RewardUserDetail_KenticoCMSDev', @enabled = 0 ; 
exec msdb..sp_update_job @job_name = 'job_EDW_GetStagingData_RewardUserDetail_KenticoCMSStage', @enabled = 0 ; 
exec msdb..sp_update_job @job_name = 'job_EDW_GetStagingData_RewardUserDetail_KenticoCMSTest', @enabled = 0 ; 
exec msdb..sp_update_job @job_name = 'job_EDW_GetStagingData_RewardUserLevel_HFITCRMDev', @enabled = 0 ; 
exec msdb..sp_update_job @job_name = 'job_EDW_GetStagingData_RewardUserLevel_KenticoCMSDev', @enabled = 0 ; 
exec msdb..sp_update_job @job_name = 'job_EDW_GetStagingData_RewardUserLevel_KenticoCMSStage', @enabled = 0 ; 
exec msdb..sp_update_job @job_name = 'job_EDW_GetStagingData_RewardUserLevel_KenticoCMSTest', @enabled = 0 ; 
exec msdb..sp_update_job @job_name = 'job_EDW_GetStagingData_Trackers_HFITCRMDev', @enabled = 0 ; 
exec msdb..sp_update_job @job_name = 'job_EDW_GetStagingData_Trackers_KenticoCMSDev', @enabled = 0 ; 
exec msdb..sp_update_job @job_name = 'job_EDW_GetStagingData_Trackers_KenticoCMSStage', @enabled = 0 ; 
exec msdb..sp_update_job @job_name = 'job_EDW_GetStagingData_Trackers_KenticoCMSTest', @enabled = 0 ; 
exec msdb..sp_update_job @job_name = 'job_EDW_HA_Master_KenticoCMSStage', @enabled = 0 ; 
exec msdb..sp_update_job @job_name = 'job_EDW_HA_Master_KenticoCMSTest', @enabled = 0 ; 

