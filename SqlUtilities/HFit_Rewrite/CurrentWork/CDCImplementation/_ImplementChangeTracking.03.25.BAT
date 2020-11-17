
cd \
cd C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\CDCImplementation

del @IVP.ChangeTracking.sql
del @ERROR_CT.TXT

copy /B /Y @IVP.ChangeTracking.sql + spacer.txt
copy spacer.txt @IVP.ChangeTracking.sql

rem ********************************************************
call ckFileCT ckChangeTrackingTurnedON.sql
call ckFileCT "proc_ChangeTracking.sql"
call ckFileCT "SetCtHA.sql"
call ckFileCT "DisableCT_EDW.sql"
rem ********************************************************

call ckFileCT "proc_QuickRowCount.sql"


call ckFileCT "createOperators.sql"

call ckFileCT "proc_SaveCTVerHist.sql" ;

call ckFileCT "proc_EDW_Create_HFIT_LKP_EDW_ALLOWED_MPI.SQL"
call ckFileCT "proc_trace.sql"
call ckFileCT "proc_CT_HA_MarkDeletedRecords.sql"

call ckFileCT "PROC_CREATE_FACT_Tables.SQL"

call ckFileCT "View_EDW_STAGED_HFIT_HEALTHASSESMENTUSERRISKAREA_Joined.sql"
call ckFileCT "proc_EDW_UpdateDIMTables.sql"
call ckFileCT "proc_EDW_Create_HA_TempTable.SQL"
call ckFileCT "proc_CT_HealthInterestDetail_AddNewRecs.sql"

call ckFileCT "proc_CT_HealthInterestDetail_AddUpdatedRecs.sql"

call ckFileCT "proc_CT_HealthInterestDetail_AddDeletedRecs.sql"


call ckFileCT "proc_CT_HealthInterestList_AddNewRecs.sql"

call ckFileCT "proc_CT_HealthInterestList_AddUpdatedRecs.sql"

call ckFileCT "proc_CT_HealthInterestList_AddDeletedRecs.sql"


call ckFileCT "view_EDW_Participant.sql"

call ckFileCT "view_EDW_Participant_CT.sql"


call ckFileCT "proc_CT_RewardTriggerParameters_AddUpdatedRecs.sql"

call ckFileCT "proc_CT_RewardTriggerParameters_AddDeletedRecs.sql"

call ckFileCT "proc_CT_RewardTriggerParameters_AddNewRecs.sql"



call ckFileCT "proc_CT_HA_Definition_AddUpdatedRecs.sql"

call ckFileCT "proc_CT_HA_Definition_AddNewRecs.sql"

call ckFileCT "proc_CT_HA_Definition_AddDeletedRecs.sql"



call ckFileCT "proc_CT_RewardsDefinition_AddNewRecs.sql"

call ckFileCT "proc_CT_RewardsDefinition_AddDeletedRecs.sql"

call ckFileCT "proc_CT_RewardsDefinition_AddUpdatedRecs.sql"


call ckFileCT "proc_CT_TrackerComposite_AddNewRecs.sql"

call ckFileCT "proc_CT_TrackerComposite_AddDeletedRecs.sql"

call ckFileCT "proc_CT_TrackerComposite_AddUpdatedRecs.sql"


call ckFileCT "view_EDW_RewardTriggerParameters_CT.sql"


call ckFileCT "PrintImmediate.sql"


call ckFileCT "C:\Users\wmiller\Documents\SQL Server Management Studio\QuickCount.sql"



call ckFileCT "proc_CREATE_STAGING_EDW_HealthAssessment_TABLE.sql"


call ckFileCT "C:\Users\wmiller\Documents\SQL Server Management Studio\createDayLightSavingsTimeFunctions.sql"


call ckFileCT "proc_EDW_Procedure_Performance_Monitor.sql"



call ckFileCT "create_TEMP_Staging_EDW_HealthAssessment_DATA.sql"


call ckFileCT "proc_EDW_ChangeGmtToCentralTime.sql"


call ckFileCT "proc_CkHaDataChanged.sql"


call ckFileCT "proc_Add_EDW_CT_StdCols.sql"


call ckFileCT "C:\Users\wmiller\Documents\SQL Server Management Studio\PrintNow.sql"


call ckFileCT "Create_CT_Performance_History.sql"


call ckFileCT "proc_CT_Performance_History.sql"


call ckFileCT "isJobRunning.sql"


call ckFileCT "View_EDW_STAGED_HFIT_HEALTHASSESMENTUSERRISKAREA_Joined.SQL"


call ckFileCT "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_CoachingDefinition_CT.sql"


call ckFileCT "Create_STAGING_EDW_RewardTriggerParameters.SQL"


call ckFileCT "create_StagingTables.sql"


call ckFileCT CreateTable_CT_VersionTracking.Sql


call ckFileCT createTable_EDW_CT_ExecutionLog.sql



call _CkFileExists "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_HealthAssesment_CT.sql"


call _CkFileExists "view_EDW_HealthAssesment\proc_EDW_CountDeletedHA.sql"


call _CkFileExists "proc_CkUserTrackerHasChanged.SQL"


call _CkFileExists "proc_STAGING_EDW_HA_Changes.sql"


call ckFileCT "proc_STAGING_EDW_HA_Definition.sql"


call ckFileCT "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_HealthAssessment_Staged.sql"


call ckFileCT proc_STAGING_EDW_CompositeTracker.sql


call ckFileCT "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_TrackerCompositeDetails.sql"


call _CkFileExists "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_TrackerCompositeDetails_CT.sql"


call _CkFileExists "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_TrackerCompositeDetails_CT_ONLY.SQL"


call ckFileCT CreateJobPullEdwData.sql


call _CkFileExists "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_HealthAssesmentClientView.sql"


call _CkFileExists "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_RewardUserDetail.sql"


call _CkFileExists "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_RewardUserDetail_CT.sql"

rem 
rem call ckFileCT create_STAGING_EDW_RewardUserDetail.sql


call ckFileCT proc_STAGING_EDW_RewardUserDetail.sql


call ckFileCT "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_HealthAssesment_CT.sql"


call ckFileCT "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_HealthAssesmentDefinition_CT.sql"



call ckFileCT "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_HealthInterestDetail_CT.sql"


call ckFileCT "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_HealthInterestDetail_STAGED.sql"



call ckFileCT proc_STAGING_EDW_HealthInterestDetail.sql


call ckFileCT "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_HealthInterestList_CT.sql"


call ckFileCT proc_STAGING_EDW_HealthInterestList.sql


call ckFileCT C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_HealthInterestList_STAGED.sql"



call ckFileCT create_job_EDW_getStaging_RewardUserDetail.sql


call ckFileCT job_EDW_GetStagingData_RewardUserDetail.sql


call ckFileCT "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_SmallStepResponses.sql"


call ckFileCT proc_STAGING_EDW_SmallSteps.sql


call ckFileCT "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_HealthAssesmentDefinition_CT.sql"


call ckFileCT create_job_PullEdwHaDefinition.sql


call ckFileCT "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_RewardUserLevel.sql"


call ckFileCT "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_HealthAssessmentDefinition_Staged.sql"


call ckFileCT "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_RewardTriggerParameters_STAGED.sql"


call ckFileCT "proc_STAGING_EDW_RewardTriggerParameters.sql"


call ckFileCT "create_job_EDW_GetStagingData_RewardTriggerParameters.sql"


call ckFileCT "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_RewardAwardDetail_CT.sql"


call ckFileCT "proc_STAGING_EDW_RewardAwardDetail.sql"


call ckFileCT "create_job_EDW_GetStagingData_RewardAwardDetail.sql"


call ckFileCT "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_RewardAwardDetail_STAGED.sql"


call ckFileCT "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_RewardUserLevel_CT.SQL"


call ckFileCT "proc_STAGING_EDW_RewardUserLevel.SQL"


call ckFileCT "create_job_EDW_GetStagingData_RewardUserLevel.SQL"


call ckFileCT "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_RewardUserLevel_STAGED.sql"


call ckFileCT "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_Coaches_CT.sql"


call ckFileCT "proc_STAGING_EDW_Coaches.sql"


call ckFileCT "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_Coaches_STAGED.sql"


call ckFileCT "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_CoachingDetail.sql"


call ckFileCT "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_CoachingDetail_CT.sql"


call ckFileCT "proc_STAGING_EDW_CoachingDetail.sql"


call ckFileCT "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_CoachingDetail_STAGE.sql"


call ckFileCT "create_job_EDW_GetStagingData_CoachingDetail.sql"


call ckFileCT "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_CT_ExecutionLog.sql"


call ckFileCT "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_RewardsDefinition_CT.sql"


call ckFileCT "proc_STAGING_EDW_RewardsDefinition.sql"


call ckFileCT "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_RewardsDefinition_STAGE.sql"


call ckFileCT "create_job_EDW_GetStagingData_RewardsDefinition.sql"


call ckFileCT "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_TrackerTests.sql"


call ckFileCT "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_TrackerShots.sql"


call ckFileCT "create_job_EDW_GetStagingData_Trackers.sql"


call ckFileCT "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_SmallStepResponses.sql"


call ckFileCT "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_SmallStepResponses_CT.sql"


call ckFileCT "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_BioMetrics.sql"


call ckFileCT "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_BioMetrics_CT.sql"


call ckFileCT "PROC_view_EDW_HealthAssesment_CT.sql"


call ckFileCT "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_HealthAssesmentClientView_CT.sql"


call ckFileCT "udf_CkHaChanged.sql"


call ckFileCT "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\EDW_Proc_Performance_Monitor.sql"


call ckFileCT "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_BioMetrics_STAGE.sql"


call ckFileCT "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_SmallStepResponses_STAGED.sql"


call ckFileCT "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_TrackersComposite_STAGED.sql"


call ckFileCT "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_HealthAssesmentClientView_STAGED.sql"


call ckFileCT "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_RewardUserDetail_STAGED.sql"


call ckFileCT "PROC_Staging_Pull_EDW_HealthAssesment_TEMPDATA.sql"



call ckFileCT "C:\Users\wmiller\Documents\SQL Server Management Studio\proc_genTableVar.sql"


call ckFileCT "C:\Users\wmiller\Documents\SQL Server Management Studio\proc_genTempTable.sql"

rem **************************************************************************************************************************************************************************************
rem 
rem call ckFileCT "proc_EDW_HA_Staging_Table_Reload.sql"
rem **************************************************************************************************************************************************************************************


call ckFileCT "proc_EDW_HA_TempTable_Load_All_Data.sql"


call ckFileCT "proc_EDW_HA_TempTable_Load_Changed_Data.sql"

rem **************************************************************************************************************************************************************************************
rem 
rem call ckFileCT "proc_Load_HA_CT_TempTable.sql"
rem **************************************************************************************************************************************************************************************


call ckFileCT "proc_CT_GetHaDeletedDataIDS.SQL"


call ckFileCT "proc_clean_EDW_Staging.sql"


call ckFileCT "C:\Users\wmiller\Documents\SQL Server Management Studio\proc_MonitorLogStats.sql"


call ckFileCT "proc_Denormalize_EDW_Views.sql"


call ckFileCT "proc_Stage_EDW_Views.sql"


call ckFileCT "CI_ItemID_HealthAssesmentUserAnswers.sql"


call ckFileCT "proc_CkSmallStepsHasChanged.sql"


call ckFileCT "proc_CT_SmallSteps_AddDeletedRecods.sql"


call ckFileCT "proc_CT_SmallSteps_AddUpdatedRecods.sql"


call ckFileCT "proc_CT_SmallSteps_AddNewRecods.sql"


call ckFileCT "proc_CT_Coaching_AddNewRecs.sql


call ckFileCT "proc_CT_Coaching_AddUpdatedRecs.sql


call ckFileCT "proc_CT_Coaching_AddDeletedRecs.sql


call ckFileCT "proc_CT_STAGING_EDW_CoachingDetail_NoDups.sql"


call ckFileCT "proc_CT_CoachingDetail_AddUpdatedRecs.sql"


call ckFileCT "proc_CT_CoachingDetail_AddDeletedRecs.sql"


call ckFileCT "proc_CT_CoachingDetail_AddNewRecs.sql"


call ckFileCT "proc_CT_CoachingDefinition_AddUpdatedRecs.sql"


call ckFileCT "proc_CkParticipantHasChanged.sql"


call ckFileCT "proc_CT_STAGING_EDW_SmallSteps_NoDups.sql"


call ckFileCT "proc_CT_SmallSteps_AddDeletedRecs.sql"


call ckFileCT "proc_CT_SmallSteps_AddUpdatedRecs.sql"


call ckFileCT "proc_CT_SmallSteps_AddUpdatedRecods.sql"


call ckFileCT "proc_CT_SmallSteps_AddNewRecods.sql"


call ckFileCT "proc_CkTrackerDataChanged.sql"


call ckFileCT "proc_CT_RewardAwardDetail_AddNewRecs.sql"


call ckFileCT "proc_CT_RewardAwardDetail_AddUpdatedRecs.sql"


call ckFileCT "proc_CT_RewardAwardDetail_AddDeletedRecs.sql"


call ckFileCT "proc_CT_RewardUserDetail_AddNewRecs.SQL"


call ckFileCT "proc_CT_RewardUserDetail_AddDeletedRecs.SQL"


call ckFileCT "proc_CT_RewardUserDetail_AddUpdatedRecs.SQL"


call ckFileCT "proc_CkRewardUserDetailHasChanged.SQL"



call ckFileCT "create_job_EDW_GetStagingData_BioMetrics.sql"

call ckFileCT "proc_CkBioMetricChanges.sql"

call ckFileCT "proc_CT_BioMetrics_AddNewRecs.sql"

call ckFileCT "proc_CT_BioMetrics_AddDeletedRecs.sql"

call ckFileCT "proc_CT_BioMetrics_AddUpdatedRecs.sql"


call ckFileCT "proc_CT_STAGING_EDW_CoachingDetail_NoDups.sql"


call ckFileCT "proc_STAGING_EDW_BioMetrics.sql"


call ckFileCT "proc_CT_HA_AddNewRecs.sql"


call ckFileCT "proc_CT_HA_AddUpdatedRecs.sql"


call ckFileCT "proc_CT_HA_AddDeletedRecs.sql"


call ckFileCT "view_EDW_PullHAData.sql"


call ckFileCT "proc_EDW_PullHA_Temp_Data.sql"


call ckFileCT "proc_EDW_Populate_Staging_Tables.sql"


call ckFileCT "proc_EDW_Reload_STAGING_EDW_HealthAssessment.sql"



call ckFileCT "proc_Create_STAGED_EDW_PkHashkey_TBL.sql"


call ckFileCT "view_EDW_PullHAData_NoCT.sql"


call ckFileCT "view_EDW_PullHAData_NoCT_Inserts.sql"


call ckFileCT "view_EDW_PullHAData_NoCT_Updates.sql"


call ckFileCT "view_EDW_PullHAData_NoCT_Deletes.sql"


call ckFileCT "proc_EDW_Gen_Temp_PkHashKeys.sql"


call ckFileCT "proc_CT_HA_MarkDeletedRecords.sql"


call ckFileCT "proc_CT_HA_MarkNewRecords.sql"



call ckFileCT "proc_CT_HA_MarkUpdatedRecords.sql"


call ckFileCT "proc_EDW_HA_Master.sql"



call ckFileCT "Create_job_Proc_EDW_HA_Master.sql"


call ckFileCT "Create_job_EDW_CT_HA_MarkNewRecords.sql"


call ckFileCT "Create_job_EDW_CT_HA_MarkDeletedRecords.sql"


call ckFileCT "Create_job_EDW_CT_HA_MarkUpdatedRecords.sql"


call ckFileCT "view_EDW_CT_VersionTracking.SQL"

call ckFileCT "View_HFit_RewardTrigger_Joined.sql"

call ckFileCT "View_HFit_RewardTriggerParameter_Joined.sql"

rem ******************************************************************************

call _ImplementAuditTracking.03.25.bat

call ckFileCT "IVP.AuditTracking.sql"

rem ******************************************************************************


call ckFileCT "proc_Create_BMI_StagingData.sql"


call ckFileCT "job_Gen_BMI_Staging_Data.SQL"
rem ******************************************************************************


call ckFileCT "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\TheEnd.SQL"
