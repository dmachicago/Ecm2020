del MasterBuildDev.sql
rem pause
copy /B SetDB.sql MasterBuildDev.sql
rem pause

copy /B /Y MasterBuildDev.sql + spacer.txt

copy /B /Y MasterBuildDev.sql + createTableEDW_PerformanceMeasure.sql
rem pause

copy /B /Y MasterBuildDev.sql + spacer.txt
copy /B /Y MasterBuildDev.sql + proc_GetRecordCount.sql 

copy /B /Y MasterBuildDev.sql + spacer.txt
copy /B /Y MasterBuildDev.sql + CreateTableEDW_HealthAssessment.sql
rem pause

copy /B /Y MasterBuildDev.sql + spacer.txt
copy /B /Y MasterBuildDev.sql + CreateEDW_HealthAssessmentDefinition.sql
rem pause


copy /B /Y MasterBuildDev.sql + CreateView_EDW_RewardProgram_Joined.sql


copy /B /Y MasterBuildDev.sql + spacer.txt
copy /B /Y MasterBuildDev.sql + CreateTrackerPerfIndexes.sql
rem pause
copy /B /Y MasterBuildDev.sql + spacer.txt

copy /B /Y MasterBuildDev.sql + createProc_GetRecordCount.sql
rem pause
copy /B /Y MasterBuildDev.sql + CreateTracker_EDW_Metadata.sql
rem pause
copy /B /Y MasterBuildDev.sql + udfElapsedTime.sql
rem pause
copy /B /Y MasterBuildDev.sql + udfTimeSpanFromMilliSeconds.sql
rem pause

copy /B /Y MasterBuildDev.sql + UTIL_getUsageCount.sql
rem pause
copy /B /Y MasterBuildDev.sql + UTIL_SearchAllTables.sql
rem pause
copy /B /Y MasterBuildDev.sql + UTIL_ViewAnalysis.sql
rem pause
copy /B /Y MasterBuildDev.sql + UTIL_DisplayBlockingQry.sql
rem pause
copy /B /Y MasterBuildDev.sql + UTIL_CorrectMispelling.sql
rem pause

copy /B /Y MasterBuildDev.sql + View_EDW_RewardProgram_Joined.sql
rem pause
copy /B /Y MasterBuildDev.sql + View_EDW_HealthAssesmentQuestions.sql
rem pause

rem copy /Y MasterBuildProd.sql + view_EDW_HAassessment.sql
rem pause

copy /B /Y MasterBuildDev.sql + view_EDW_ClientCompany.sql
rem pause
copy /B /Y MasterBuildDev.sql + view_EDW_Coaches.sql
rem pause
copy /B /Y MasterBuildDev.sql + view_EDW_CoachingDefinition.sql
rem pause
copy /B /Y MasterBuildDev.sql + view_EDW_CoachingDetail.sql
rem pause
copy /B /Y MasterBuildDev.sql + view_EDW_HealthAssesment.sql
rem pause
copy /B /Y MasterBuildDev.sql + View_EDW_HealthAssesmentAnswers.sql
rem pause
copy /B /Y MasterBuildDev.sql + view_EDW_HealthAssesmentClientView.sql
rem pause
copy /B /Y MasterBuildDev.sql + view_EDW_HealthAssesmentDeffinition.sql
rem pause
copy /B /Y MasterBuildDev.sql + view_EDW_HealthAssesmentDeffinitionCustom.sql
rem pause

rem copy /B /Y MasterBuildDev.sql + view_EDW_HealthAssessmentDefinition_Staged.sql
rem pause
rem copy /B /Y MasterBuildDev.sql + view_EDW_HealthAssessment_Staged.sql
rem pause

copy /B /Y MasterBuildDev.sql + view_EDW_Participant.sql
rem pause
copy /B /Y MasterBuildDev.sql + view_EDW_RewardAwardDetail.sql
rem pause
copy /B /Y MasterBuildDev.sql + view_EDW_RewardsDefinition.sql
rem pause
copy /B /Y MasterBuildDev.sql + view_EDW_RewardTriggerParameters.sql
rem pause

copy /B /Y MasterBuildDev.sql + view_EDW_ScreeningsFromTrackers.sql
rem pause
copy /B /Y MasterBuildDev.sql + view_EDW_TrackerCompositeDetails.sql
rem pause
copy /B /Y MasterBuildDev.sql + view_EDW_TrackerMetadata.sql
rem pause
copy /B /Y MasterBuildDev.sql + view_EDW_TrackerShots.sql
rem pause
copy /B /Y MasterBuildDev.sql + view_EDW_TrackerTests.sql
rem pause

copy /B /Y MasterBuildDev.sql + view_EDW_HADefinition.sql
rem pause

copy /B /Y MasterBuildDev.sql + Proc_EDW_GenerateMetadata.sql
rem pause
copy /B /Y MasterBuildDev.sql + Proc_EDW_HealthAssessment.sql
rem pause
copy /B /Y MasterBuildDev.sql + Proc_EDW_HealthAssessmentDefinition.sql
rem pause
copy /B /Y MasterBuildDev.sql + proc_EDW_MeasurePerf.sql
rem pause


copy /B /Y MasterBuildDev.sql + view_EDW_HealthInterestDetail.sql
copy /B /Y MasterBuildDev.sql + view_EDW_HealthInterestList.sql
rem pause

copy /B /Y MasterBuildDev.sql + spacer.txt

copy /B /Y MasterBuildDev.sql + CleanUp.sql
rem pause

copy /B /Y MasterBuildDev.sql + spacer.txt
rem copy /B /Y Proc_EDW_RewardUserDetail.sql Proc_EDW_RewardUserDetailTEMP.sql
rem pause
copy /B /Y MasterBuildDev.sql + Proc_EDW_RewardUserDetail.sql
rem pause
copy /B /Y MasterBuildDev.sql + spacer.txt

copy /B /Y MasterBuildDev.sql + Proc_EDW_TrackerMetadataExtract.sql
rem pause
copy /B /Y MasterBuildDev.sql + proc_GetRecordCount.sql
rem pause

copy /B /Y MasterBuildDev.sql + spacer.txt

copy /B /Y view_EDW_RewardUserDetail.sql view_EDW_RewardUserDetail_temp.sql
rem pause
copy /B /Y MasterBuildDev.sql + view_EDW_RewardUserDetail_temp.sql
rem pause

copy /B /Y MasterBuildDev.sql + spacer.txt

copy /B /Y MasterBuildDev.sql + CreateTrackerPerfIndexes.sql
rem pause

rem copy /B /Y MasterBuildDev.sql + TheEnd.sql
rem pause

copy /B /Y MasterBuildDev.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWwok\_Eligibility\EligibilityImplementationScript.sql"
rem pause

copy /B /Y MasterBuildDev.sql + view_EDW_BioMetrics.sql
rem pause

rem copy /B /Y MasterBuildDev.sql + TestViewsExecution.sql
rem pause

REM *********************************************************

copy /B /Y MasterBuildDev.SQL + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWwok\_ChangeTracking\spacer.txt"
rem pause
copy /B /Y MasterBuildDev.SQL + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWwok\_ChangeTracking\udfGetCurrentIP.sql"
rem pause
copy /B /Y MasterBuildDev.SQL + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWwok\_ChangeTracking\spacer.txt"
rem pause
copy /B /Y MasterBuildDev.SQL + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWwok\_ChangeTracking\trgSchemaMonitor.sql"
rem pause
copy /B /Y MasterBuildDev.SQL + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWwok\_ChangeTracking\CreateDdlAuditTables.sql" 
rem pause
copy /B /Y MasterBuildDev.SQL + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWwok\_ChangeTracking\sp_SchemaMonitorReport.sql" 
rem pause
copy /B /Y MasterBuildDev.SQL + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWwok\_ChangeTracking\SchemaChangeMonitorEvent.sql" 
rem pause
copy /B /Y MasterBuildDev.SQL + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWwok\_ChangeTracking\SchemaChangeMonitor.sql" 
rem pause

copy /B /Y MasterBuildDev.SQL + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWwok\_ChangeTracking\Proc_EDW_Compare_Tables.sql" 
rem pause
copy /B /Y MasterBuildDev.SQL + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWwok\_ChangeTracking\Proc_EDW_Compare_Views.sql" 
rem pause
copy /B /Y MasterBuildDev.SQL + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWwok\_ChangeTracking\Proc_EDW_Compare_MASTER.sql" 
rem pause
rem copy /B /Y MasterBuildDev.SQL + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWwok\_ChangeTracking\TheEnd.sql"
rem pause
rem copy /B /Y MasterBuildDev.SQL + TestViewsExecution.sql

copy /B /Y MasterBuildDev.sql + Job_EDW_GenerateKenticoMetadata.sql
rem pause

copy /B /Y MasterBuildDev.sql + TheEnd.sql
rem pause