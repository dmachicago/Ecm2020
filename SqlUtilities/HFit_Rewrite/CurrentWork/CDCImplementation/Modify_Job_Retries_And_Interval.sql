
exec combine_Job_Steps_Into_Single_Job job_proc_BASE_CMS_DocumentTypeScope_KenticoCMS_1_ApplyCT

SELECT 'exec combine_Job_Steps_Into_Single_Job ''' + j.name + '''' + char(10) + 'GO' as cmd
  FROM
       msdb.dbo.sysjobs AS j
where j.name like 'job[_]proc[_]%'
and (j.name like '%[_]1' or j.name like '%1[_]ApplyCT')
order by  j.name

SELECT 'EXEC msdb..sp_update_jobstep @job_name = ''' + j.name + ''' , @Step_id = ' + 
       cast(js.step_id as nvarchar(50)) + ',@retry_attempts = 7,@retry_interval = 59' + char(10) + 'GO' as cmd
  FROM
       msdb.dbo.sysjobs AS j
	         INNER JOIN msdb.dbo.sysjobsteps AS js
       ON js.job_id = j.job_id
where j.name like 'job[_]proc[_]%'
and j.name like '%[_]1'
order by  j.name , j.job_id desc

SELECT 'EXEC msdb..sp_update_jobstep @job_name = ''' + j.name + ''' , @Step_id = ' + 
       cast(js.step_id as nvarchar(50)) + ',@database_name = ''DataMartPlatform'' ' + char(10) + 'GO' as cmd
  FROM
       msdb.dbo.sysjobs AS j
	         INNER JOIN msdb.dbo.sysjobsteps AS js
       ON js.job_id = j.job_id
where 
j.name in 
(
'job_proc_BASE_CMS_DeviceProfile_DEL_KenticoCMS_1_ApplyCT',
'job_proc_BASE_CMS_DocumentCategory_CTVerHIST_KenticoCMS_1_ApplyCT',
'job_proc_BASE_view_EDW_HAassessment_KenticoCMS_1_ApplyCT',
'job_proc_EDW_HealthAssessment_KenticoCMS_1',
'job_proc_EDW_RoleMembership_KenticoCMS_1',
'job_proc_HFit_Coaches_KenticoCMS_1',
'job_proc_HFit_CoachingAuditLog_KenticoCMS_1',
'job_proc_HFit_CoachingCallLogTemporalContainer_KenticoCMS_1',
'job_proc_hfit_CoachingCMTemporalContainer_KenticoCMS_1',
'job_proc_HFit_CoachingCommitToQuit_KenticoCMS_1',
'job_proc_HFit_CoachingEnrollmentReport_KenticoCMS_1',
'job_proc_HFit_CoachingEnrollmentSettings_KenticoCMS_1',
'job_proc_HFit_CoachingEnrollmentSyncStaging_KenticoCMS_1',
'job_proc_HFit_CoachingEvalHAOverall_KenticoCMS_1',
'job_proc_HFit_CoachingEvalHAQA_KenticoCMS_1',
'job_proc_HFit_CoachingEvalHARiskArea_KenticoCMS_1',
'job_proc_HFit_CoachingEvalHARiskCategory_KenticoCMS_1',
'job_proc_HFit_CoachingEvalHARiskModule_KenticoCMS_1',
'job_proc_HFit_CoachingGetStarted_KenticoCMS_1',
'job_proc_HFit_CoachingHATemporalContainer_KenticoCMS_1',
'job_proc_HFit_CoachingHealthActionPlan_KenticoCMS_1',
'job_proc_HFit_CoachingHealthArea_KenticoCMS_1',
'job_proc_HFit_CoachingHealthInterest_KenticoCMS_1',
'job_proc_HFit_CoachingLibraryHealthArea_KenticoCMS_1',
'job_proc_HFit_CoachingLibraryResource_KenticoCMS_1',
'job_proc_HFit_CoachingLibraryResources_KenticoCMS_1',
'job_proc_HFit_CoachingLibrarySettings_KenticoCMS_1',
'job_proc_HFit_CoachingLMTemporalContainer_KenticoCMS_1',
'job_proc_HFit_CoachingMyGoalsSettings_KenticoCMS_1',
'job_proc_HFit_CoachingMyHealthInterestsSettings_KenticoCMS_1',
'job_proc_HFit_CoachingNotAssignedSettings_KenticoCMS_1',
'job_proc_HFit_CoachingPrivacyPolicy_KenticoCMS_1',
'job_proc_HFit_CoachingSessionCompleted_KenticoCMS_1',
'job_proc_Hfit_CoachingSystemSettings_KenticoCMS_1',
'job_proc_HFit_CoachingTermsAndConditionsSettings_KenticoCMS_1',
'job_proc_Hfit_CoachingUserCMCondition_KenticoCMS_1',
'job_proc_Hfit_CoachingUserCMExclusion_KenticoCMS_1',
'job_proc_HFit_CoachingUserServiceLevel_KenticoCMS_1',
'job_proc_HFit_CoachingWelcomeSettings_KenticoCMS_1',
'job_proc_HFit_Configuration_CallLogCoaching_KenticoCMS_1',
'job_proc_HFIT_Configuration_CMCoaching_KenticoCMS_1',
'job_proc_HFIT_Configuration_HACoaching_KenticoCMS_1',
'job_proc_HFit_Configuration_LMCoaching_KenticoCMS_1',
'job_proc_Hfit_HAHealthCheckLog_KenticoCMS_1',
'job_proc_HFit_LKP_CoachingAuditLogType_KenticoCMS_1',
'job_proc_HFit_LKP_CoachingCMConditions_KenticoCMS_1',
'job_proc_HFit_LKP_CoachingCMExclusions_KenticoCMS_1',
'job_proc_HFit_LKP_CoachingOptOutReason_KenticoCMS_1',
'job_proc_HFit_LKP_CoachingServiceLevel_KenticoCMS_1',
'job_proc_HFit_LKP_CoachingServiceLevelStatus_KenticoCMS_1',
'job_proc_HFit_LKP_CoachViewTimeZone_KenticoCMS_1',
'job_proc_HFit_PPTStatus_CR27070_KenticoCMS_1',
'job_proc_HFit_Staging_Coach_KenticoCMS_1',
'job_proc_HFit_UserCoachingAlert_MeetNotModify_KenticoCMS_1',
'job_proc_HFit_UserCoachingAlert_NotMet_KenticoCMS_1',
'job_proc_HFit_UserCoachingAlert_NotMet_Step2_KenticoCMS_1',
'job_proc_HFit_UserCoachingAlert_NotMet_Step3_KenticoCMS_1',
'job_proc_HFit_UserCoachingAlert_NotMet_Step4_KenticoCMS_1',
'job_proc_HFit_UserCoachingAlert_NotMet_Step5_KenticoCMS_1',
'job_proc_RPT_CoachingFromPortal_KenticoCMS_1',
'job_proc_view_CMS_USER_KenticoCMS_1',
'job_proc_view_EDW_BioMetrics_KenticoCMS_1',
'job_proc_view_EDW_Eligibility_KenticoCMS_1',
'job_proc_view_hfit_challengeOffering_Joined_KenticoCMS_1',
'job_proc_view_HFit_CoachingGetUserDaysSinceActivity_KenticoCMS_1',
'job_proc_view_HFit_CoachingReadyForNotification_KenticoCMS_1',
'job_proc_view_HFit_HealthSummarySettings_Joined_KenticoCMS_1'
)
order by  j.name , j.job_id desc
