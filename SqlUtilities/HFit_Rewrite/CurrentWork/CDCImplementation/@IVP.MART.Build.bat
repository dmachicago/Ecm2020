

echo off
cd\
cd C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\CDCImplementation

rem call _CkFileExists "@IVP.MART_Build.sql"
del @IVP.MART_Build.sql

copy spacer.txt @IVP.MART_Build.sql

call CheckFile PrintImmediate.sql 
call CheckFile FindNestedViews.sql
call CheckFile createOperators.sql
call CheckFile proc_GenTrackerFactTable.sql
call CheckFile proc_genTrackerPrimaryKeys.sql
call CheckFile proc_GetColumnID.sql 
call CheckFile mart_AddMissingColumns.sql
call CheckFile proc_SetDefaultTrackerName.sql
call CheckFile proc_SetDefaultRowDataUpdated.sql
call CheckFile isChangeTrackingON.sql
call CheckFile isPrimaryKeyExists.sql 
call CheckFile proc_AddBaseBitColsIndexes.sql
call CheckFile proc_TrackTableRowCounts.sql

call CheckFile validateChangeTrackingOnEachTable.sql

call CheckFile proc_SetPrimaryKeyToSurrogateKey.sql

call CheckFile proc_ConnectTables_BySurrogateKey.sql

call CheckFile proc_EnableChangeTracking.sql
call CheckFile proc_GenJobBaseTableSync.sql
call CheckFile proc_genPullChangesProc.sql
call CheckFile create_EmailProfileAndUser.sql
call CheckFile create_HFITUSERMPINUMBER.sql
call CheckFile proc_Create_StagingTables_INIT.sql
call CheckFile proc_genBaseDelTrigger.sql
call CheckFile proc_genBaseUpdtTrigger.sql
call CheckFile proc_EnableBaseEmailNotifications.sql

call CheckFile proc_GenTrackerCTProcMASTER.sql
call CheckFile proc_AllTblConstraintsDrop.sql
call CheckFile proc_TableFKeysDrop.sql
call CheckFile proc_AddMissingTableFKeys.sql
call CheckFile proc_AllTblConstraintsReGen.sql
call CheckFile proc_GetTableForeignKeys.sql
call CheckFile proc_MasterBigintToInt.sql
call CheckFile proc_GenBaseTableDefaults.sql
call CheckFile proc_GenHistoryTrigger.sql
call CheckFile proc_GetTableColumnsAsVars.sql
call CheckFile proc_GenTableColumnsVariables.sql
call CheckFile proc_GenJobTrackerTableSync.sql
call CheckFile proc_GenTrackerCTProc.sql
call CheckFile proc_ConvertBigintToInt.sql
call CheckFile proc_GenBaseViewNoNulls.sql
call CheckFile proc_SetBaseTableNoNulls.sql

rem ----------------------------
call CheckFile proc_ChangeTracking.sql
call CheckFile proc_genBaseDelTrigger.sql
call CheckFile proc_genBaseUpdtTrigger.sql
call CheckFile proc_GenCT_HistProcedure.sql
call CheckFile proc_genPullChangesProc.sql
call CheckFile proc_RemoveIdentityCols.sql
call CheckFile procGetTablePK.sql

call CheckFile proc_CreateBaseTable.sql
rem ----------------------------

call CheckFile combine_Job_Steps_Into_Single_Job.sql 

call CheckFile proc_EnableBaseEmailNotifications.sql

call CheckFile create_StagingTables.sql

rem call CheckFile findFailedJobs.sql

call CheckFile proc_SendEmailNotice.SQL

call CheckFile proc_CreateBaseTable.sql

call CheckFile proc_BASE_GetMaxCTVersionNbr.sql

call CheckFile proc_PERFMON_PullTime_HIST.sql

call CheckFile proc_BASE_GetMaxCTVersionNbr.sql

call CheckFile proc_BASE_SaveCurrCTVersionNbr.sql

call CheckFile proc_GetTableColumnsCT.sql

call CheckFile proc_GetTableColumnsNoIdentity.sql

call CheckFile proc_GetTableColumnsNoPK.sql

call CheckFile proc_ifExistCurrVersionNbr.sql

call CheckFile proc_IsColIdentity.sql

call CheckFile proc_IsColPrimaryKey.sql

call CheckFile SetCtHA.sql

call CheckFile udfGetTableColumns.sql

call CheckFile udfSplitString.sql

call CheckFile usp_GetErrorInfo.sql

call CheckFile _generate_Base_Tables.sql

call CheckFile fix_Tracker_Null_PKeys.sql

call CheckFile view_MART_HealthAssesment.SQL
call CheckFile view_MART_HealthAssesment_CT.sql

call CheckFile proc_RemoveHashCodeDuplicateRows.sql

call CheckFile proc_UpdateSurrogateKeyDataBetweenParentAndChild.sql

call CheckFile view_CoachEnrolledPPTCondition.sql
call CheckFile view_ConditionManagement.sql
call CheckFile VIEW_DIM_HA.sql
call CheckFile view_HealthAssesment_MART.sql
call CheckFile View_HFit_HealthAssessment_Joined_MART.sql
call CheckFile view_MART_HealthAssesment_CT.sql
call CheckFile view_UserExcludedCondition.sql
call CheckFile view_EDW_HealthAssesment_MART.sql

call CheckFile proc_HA_Update_CMS_Site.sql
call CheckFile proc_HA_Update_HFit_Account.sql
call CheckFile proc_HA_Update_HFit_HealthAssesmentUserAnswers.sql
call CheckFile proc_HA_Update_HFit_HealthAssesmentUserRiskArea.sql
call CheckFile proc_HA_Update_HFit_HealthAssesmentUserRiskCategory.sql
call CheckFile proc_HA_Update_View_EDW_HealthAssesmentQuestions.sql
call CheckFile proc_HA_Update_HFit_HealthAssesmentUserQuestion.sql
call CheckFile proc_HA_Update_HFit_HealthAssesmentUserModule.sql

call CheckFile view_EDW_HealthAssessment_MART_Pull_CMS1.sql
call CheckFile view_EDW_HealthAssessment_MART_Pull_CMS2.sql
call CheckFile view_EDW_HealthAssessment_MART_Pull_CMS3.sql
call CheckFile proc_HA_MasterUpdate.sql

call CheckFile JOB_proc_HA_MasterUpdate.sql

call CheckFile proc_UpdateSurrogateKeyDataBetweenParentAndChild.sql

call CheckFile proc_Track_MART_Job_History.sql
call CheckFile JOB_proc_Track_MART_Job_History.sql

call CheckFile JobDDL.SQL
call CheckFile create_job_proc_CT_DIM_$Master.sql

call CheckFile add_Missing_Indexes.sql

rem ************************************
rem **** THIS MUST BE LAST in the list
call CheckFile InventoryBaseObjects.sql

Echo IVP GEN Complete - please review for errors.
Echo For assistance call Dale Miller 847-274-6622