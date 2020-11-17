echo off

cd "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\CDCImplementation"

call _CkFileExists "XVP.ChangeTracking.sql"

call _CkFileExists "IVP.ChangeTracking.sql"
call _CkFileExists ckChangeTrackingTurnedON.sql

call _CkFileExists "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\CDCImplementation\proc_EDW_Create_HA_TempTable.SQL"

call _CkFileExists "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\CDCImplementation\SetCtHA.sql"

call _CkFileExists "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\CDCImplementation\proc_CREATE_STAGING_EDW_HealthAssessment_TABLE.sql"

call _CkFileExists "C:\Users\wmiller\Documents\SQL Server Management Studio\createDayLightSavingsTimeFunctions.sql"

call _CkFileExists "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\proc_EDW_Procedure_Performance_Monitor.sql"

call _CkFileExists "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\CDCImplementation\create_TEMP_Staging_EDW_HealthAssessment_DATA.sql"

call _CkFileExists "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\CDCImplementation\proc_EDW_ChangeGmtToCentralTime.sql"

call _CkFileExists "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\CDCImplementation\proc_CkHaDataChanged.sql"

call _CkFileExists "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\CDCImplementation\proc_Add_EDW_CT_StdCols.sql"

call _CkFileExists "C:\Users\wmiller\Documents\SQL Server Management Studio\PrintNow.sql"

call _CkFileExists "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\CDCImplementation\Create_CT_Performance_History.sql"

call _CkFileExists "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\CDCImplementation\proc_CT_Performance_History.sql"

call _CkFileExists "C:\Users\wmiller\Documents\SQL Server Management Studio\isJobRunning.sql"

call _CkFileExists "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_CoachingDefinition_CT.sql"

call _CkFileExists "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\CDCImplementation\Create_STAGING_EDW_RewardTriggerParameters"

call _CkFileExists "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\CDCImplementation\create_StagingTables.sql"

call _CkFileExists CreateTable_CT_VersionTracking.Sql

call _CkFileExists createTable_EDW_CT_ExecutionLog.sql

call _CkFileExists "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_HealthAssesment_CT.sql"

call _CkFileExists "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\CDCImplementation\view_EDW_HealthAssesment\proc_EDW_CountDeletedHA.sql"

call _CkFileExists "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\CDCImplementation\proc_CkUserTrackerHasChanged.SQL"

call _CkFileExists "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\CDCImplementation\proc_STAGING_EDW_HA_Changes.sql"

call _CkFileExists "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\CDCImplementation\proc_STAGING_EDW_HA_Definition.sql"

call _CkFileExists "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_HealthAssessment_Staged.sql"

call _CkFileExists proc_STAGING_EDW_CompositeTracker.sql

call _CkFileExists "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_TrackerCompositeDetails.sql"

call _CkFileExists "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_TrackerCompositeDetails_CT.sql"

call _CkFileExists "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_TrackerCompositeDetails_CT_ONLY.SQL"

call _CkFileExists CreateJobPullEdwData.sql

call _CkFileExists "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_HealthAssesmentClientView.sql"

call _CkFileExists "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_RewardUserDetail.sql"

call _CkFileExists "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_RewardUserDetail_CT.sql"
rem 
rem call _CkFileExists create_STAGING_EDW_RewardUserDetail.sql

call _CkFileExists proc_STAGING_EDW_RewardUserDetail.sql

call _CkFileExists "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_HealthAssesment_CT.sql"

call _CkFileExists "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_HealthAssesmentDefinition_CT.sql"

call _CkFileExists "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_HealthInterestDetail_CT.sql"

call _CkFileExists "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_HealthInterestDetail_STAGED.sql"

call _CkFileExists proc_STAGING_EDW_HealthInterestDetail.sql

call _CkFileExists "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_HealthInterestList_CT.sql"

call _CkFileExists proc_STAGING_EDW_HealthInterestList.sql

call _CkFileExists C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_HealthInterestList_STAGED.sql"

call _CkFileExists create_job_EDW_getStaging_RewardUserDetail.sql

call _CkFileExists job_EDW_GetStagingData_RewardUserDetail.sql

call _CkFileExists "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_SmallStepResponses.sql"

call _CkFileExists proc_STAGING_EDW_SmallSteps.sql

call _CkFileExists "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_HealthAssesmentDefinition_CT.sql"

call _CkFileExists create_job_PullEdwHaDefinition.sql

call _CkFileExists "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_RewardUserLevel.sql"

call _CkFileExists "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_HealthAssessmentDefinition_Staged.sql"

call _CkFileExists "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_RewardTriggerParameters_STAGED.sql"

call _CkFileExists "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\CDCImplementation\proc_STAGING_EDW_RewardTriggerParameters.sql"

call _CkFileExists "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\CDCImplementation\create_job_EDW_GetStagingData_RewardTriggerParameters.sql"

call _CkFileExists "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_RewardAwardDetail_CT.sql"

call _CkFileExists "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\CDCImplementation\proc_STAGING_EDW_RewardAwardDetail.sql"

call _CkFileExists "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\CDCImplementation\create_job_EDW_GetStagingData_RewardAwardDetail.sql"

call _CkFileExists "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_RewardAwardDetail_STAGED.sql"

call _CkFileExists "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_RewardUserLevel_CT.SQL"

call _CkFileExists "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\CDCImplementation\proc_STAGING_EDW_RewardUserLevel.SQL"

call _CkFileExists "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\CDCImplementation\create_job_EDW_GetStagingData_RewardUserLevel.SQL"

call _CkFileExists "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_RewardUserLevel_STAGED.sql"

call _CkFileExists "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_Coaches_CT.sql"

call _CkFileExists "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\CDCImplementation\proc_STAGING_EDW_Coaches.sql"

call _CkFileExists "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_Coaches_STAGED.sql"

call _CkFileExists "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_CoachingDetail.sql"

call _CkFileExists "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_CoachingDetail_CT.sql"

call _CkFileExists "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\CDCImplementation\proc_STAGING_EDW_CoachingDetail.sql"

call _CkFileExists "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_CoachingDetail_STAGE.sql"

call _CkFileExists "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\CDCImplementation\create_job_EDW_GetStagingData_CoachingDetail.sql"

call _CkFileExists "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_CT_ExecutionLog.sql"

call _CkFileExists "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_RewardsDefinition_CT.sql"

call _CkFileExists "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\CDCImplementation\proc_STAGING_EDW_RewardsDefinition.sql"

call _CkFileExists "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_RewardsDefinition_STAGE.sql"

call _CkFileExists "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\CDCImplementation\create_job_EDW_GetStagingData_RewardsDefinition.sql"

call _CkFileExists "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_TrackerTests.sql"

call _CkFileExists "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_TrackerShots.sql"

call _CkFileExists "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\CDCImplementation\create_job_EDW_GetStagingData_Trackers.sql"

call _CkFileExists "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_SmallStepResponses.sql"

call _CkFileExists "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_SmallStepResponses_CT.sql"

call _CkFileExists "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_BioMetrics.sql"

call _CkFileExists "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_BioMetrics_CT.sql"

call _CkFileExists "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\CDCImplementation\PROC_view_EDW_HealthAssesment_CT.sql"

call _CkFileExists "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_HealthAssesmentClientView_CT.sql"

call _CkFileExists "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\CDCImplementation\udf_CkHaChanged.sql"

call _CkFileExists "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\EDW_Proc_Performance_Monitor.sql"

call _CkFileExists "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_BioMetrics_STAGE.sql"

call _CkFileExists "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_SmallStepResponses_STAGED.sql"

call _CkFileExists "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_TrackersComposite_STAGED.sql"

call _CkFileExists "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_HealthAssesmentClientView_STAGED.sql"

call _CkFileExists "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_RewardUserDetail_STAGED.sql"

call _CkFileExists "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\CDCImplementation\PROC_Staging_Pull_EDW_HealthAssesment_TEMPDATA.sql"

call _CkFileExists "C:\Users\wmiller\Documents\SQL Server Management Studio\proc_QuickRowCount.sql"

call _CkFileExists "C:\Users\wmiller\Documents\SQL Server Management Studio\proc_genTableVar.sql"

call _CkFileExists "C:\Users\wmiller\Documents\SQL Server Management Studio\proc_genTempTable.sql"

call _CkFileExists "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\CDCImplementation\proc_EDW_HA_Staging_Table_Reload.sql"

call _CkFileExists "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\CDCImplementation\proc_EDW_HA_TempTable_Load_All_Data.sql"

call _CkFileExists "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\CDCImplementation\proc_EDW_HA_TempTable_Load_Changed_Data.sql"

call _CkFileExists "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\CDCImplementation\proc_Load_HA_CT_TempTable.sql"

call _CkFileExists "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\CDCImplementation\proc_CT_GetHaDeletedDataIDS.SQL"

call _CkFileExists "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\CDCImplementation\proc_clean_EDW_Staging.sql"

call _CkFileExists "C:\Users\wmiller\Documents\SQL Server Management Studio\proc_MonitorLogStats.sql"

call _CkFileExists "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\CDCImplementation\proc_Denormalize_EDW_Views.sql"

call _CkFileExists "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\CDCImplementation\proc_Stage_EDW_Views.sql"

call _CkFileExists "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\CDCImplementation\CI_ItemID_HealthAssesmentUserAnswers.sql"

call _CkFileExists "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\CDCImplementation\proc_CkSmallStepsHasChanged.sql"

call _CkFileExists "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\CDCImplementation\proc_CT_SmallSteps_AddDeletedRecods.sql"

call _CkFileExists "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\CDCImplementation\proc_CT_SmallSteps_AddUpdatedRecods.sql"

call _CkFileExists "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\CDCImplementation\proc_CT_SmallSteps_AddNewRecods.sql"

call _CkFileExists "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\CDCImplementation\proc_CT_Coaching_AddNewRecs.sql

call _CkFileExists "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\CDCImplementation\proc_CT_Coaching_AddUpdatedRecs.sql

call _CkFileExists "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\CDCImplementation\proc_CT_Coaching_AddDeletedRecs.sql

call _CkFileExists "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\CDCImplementation\proc_CT_STAGING_EDW_CoachingDetail_NoDups.sql"

call _CkFileExists "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\CDCImplementation\proc_CT_CoachingDetail_AddUpdatedRecs.sql"

call _CkFileExists "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\CDCImplementation\proc_CT_CoachingDetail_AddDeletedRecs.sql"

call _CkFileExists "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\CDCImplementation\proc_CT_CoachingDetail_AddNewRecs.sql"

call _CkFileExists "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\CDCImplementation\proc_CT_CoachingDefinition_AddUpdatedRecs.sql"

call _CkFileExists "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\CDCImplementation\proc_CkParticipantHasChanged.sql"

call _CkFileExists "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\CDCImplementation\proc_CT_STAGING_EDW_SmallSteps_NoDups.sql"

call _CkFileExists "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\CDCImplementation\proc_CT_SmallSteps_AddDeletedRecs.sql"

call _CkFileExists "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\CDCImplementation\proc_CT_SmallSteps_AddUpdatedRecs.sql"

call _CkFileExists "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\CDCImplementation\proc_CT_SmallSteps_AddUpdatedRecods.sql"

call _CkFileExists "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\CDCImplementation\proc_CT_SmallSteps_AddNewRecods.sql"

call _CkFileExists "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\CDCImplementation\proc_CkTrackerDataChanged.sql"

call _CkFileExists "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\CDCImplementation\TEST_EDW_RewardAwardDetail.sql"

call _CkFileExists "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\CDCImplementation\proc_CT_RewardAwardDetail_AddNewRecs.sql"

call _CkFileExists "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\CDCImplementation\proc_CT_RewardAwardDetail_AddUpdatedRecs.sql"

call _CkFileExists "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\CDCImplementation\proc_CT_RewardAwardDetail_AddDeletedRecs.sql"

call _CkFileExists "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\CDCImplementation\proc_CT_RewardUserDetail_AddNewRecs.SQL"

call _CkFileExists "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\CDCImplementation\proc_CT_RewardUserDetail_AddDeletedRecs.SQL"

call _CkFileExists "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\CDCImplementation\proc_CT_RewardUserDetail_AddUpdatedRecs.SQL"

call _CkFileExists "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\CDCImplementation\proc_CkRewardUserDetailHasChanged.SQL"
call _CkFileExists "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\TheEnd.SQL"

pause