del MasterBuildDev.sql

copy /B SetDB.sql MasterBuildDev.sql

copy /B /Y MasterBuildDev.sql + spacer.txt

copy /B /Y MasterBuildDev.sql + createTableEDW_PerformanceMeasure.sql

copy /B /Y MasterBuildDev.sql + spacer.txt
copy /B /Y MasterBuildDev.sql + proc_GetRecordCount.sql 

copy /B /Y MasterBuildDev.sql + spacer.txt
copy /B /Y MasterBuildDev.sql + CreateTableEDW_HealthAssessment.sql

copy /B /Y MasterBuildDev.sql + spacer.txt
copy /B /Y MasterBuildDev.sql + CreateEDW_HealthAssessmentDefinition.sql



copy /B /Y MasterBuildDev.sql + spacer.txt
copy /B /Y MasterBuildDev.sql + CreateTrackerPerfIndexes.sql
copy /B /Y MasterBuildDev.sql + spacer.txt

copy /B /Y MasterBuildDev.sql + createProc_GetRecordCount.sql
copy /B /Y MasterBuildDev.sql + CreateTracker_EDW_Metadata.sql
copy /B /Y MasterBuildDev.sql + udfElapsedTime.sql
copy /B /Y MasterBuildDev.sql + udfTimeSpanFromMilliSeconds.sql

copy /B /Y MasterBuildDev.sql + UTIL_getUsageCount.sql
copy /B /Y MasterBuildDev.sql + UTIL_SearchAllTables.sql
copy /B /Y MasterBuildDev.sql + UTIL_ViewAnalysis.sql
copy /B /Y MasterBuildDev.sql + UTIL_DisplayBlockingQry.sql
copy /B /Y MasterBuildDev.sql + UTIL_CorrectMispelling.sql

copy /B /Y MasterBuildDev.sql + View_EDW_HealthAssesmentQuestions.sql

copy /Y MasterBuildProd.sql + view_EDW_HAassessment.sql

copy /B /Y MasterBuildDev.sql + view_EDW_ClientCompany.sql
copy /B /Y MasterBuildDev.sql + view_EDW_Coaches.sql
copy /B /Y MasterBuildDev.sql + view_EDW_CoachingDefinition.sql
copy /B /Y MasterBuildDev.sql + view_EDW_CoachingDetail.sql
copy /B /Y MasterBuildDev.sql + view_EDW_HealthAssesment.sql
copy /B /Y MasterBuildDev.sql + View_EDW_HealthAssesmentAnswers.sql
copy /B /Y MasterBuildDev.sql + view_EDW_HealthAssesmentClientView.sql
copy /B /Y MasterBuildDev.sql + view_EDW_HealthAssesmentDeffinition.sql
copy /B /Y MasterBuildDev.sql + view_EDW_HealthAssesmentDeffinitionCustom.sql

copy /B /Y MasterBuildDev.sql + view_EDW_HealthAssessmentDefinition_Staged.sql
copy /B /Y MasterBuildDev.sql + view_EDW_HealthAssessment_Staged.sql
copy /B /Y MasterBuildDev.sql + view_EDW_Participant.sql
copy /B /Y MasterBuildDev.sql + view_EDW_RewardAwardDetail.sql
copy /B /Y MasterBuildDev.sql + view_EDW_RewardsDefinition.sql
copy /B /Y MasterBuildDev.sql + view_EDW_RewardsDefinition_TEST.sql
copy /B /Y MasterBuildDev.sql + view_EDW_RewardTriggerParameters.sql

copy /B /Y MasterBuildDev.sql + view_EDW_ScreeningsFromTrackers.sql
copy /B /Y MasterBuildDev.sql + view_EDW_TrackerCompositeDetails.sql
copy /B /Y MasterBuildDev.sql + view_EDW_TrackerMetadata.sql
copy /B /Y MasterBuildDev.sql + view_EDW_TrackerShots.sql
copy /B /Y MasterBuildDev.sql + view_EDW_TrackerTests.sql

copy /B /Y MasterBuildDev.sql + view_EDW_HADefinition.sql

copy /B /Y MasterBuildDev.sql + Proc_EDW_GenerateMetadata.sql
copy /B /Y MasterBuildDev.sql + Proc_EDW_HealthAssessment.sql
copy /B /Y MasterBuildDev.sql + Proc_EDW_HealthAssessmentDefinition.sql
copy /B /Y MasterBuildDev.sql + proc_EDW_MeasurePerf.sql

copy /B /Y MasterBuildDev.sql + spacer.txt

copy /B /Y MasterBuildDev.sql + CleanUp.sql

copy /B /Y MasterBuildDev.sql + spacer.txt
rem copy /B /Y Proc_EDW_RewardUserDetail.sql Proc_EDW_RewardUserDetailTEMP.sql
copy /B /Y MasterBuildDev.sql + Proc_EDW_RewardUserDetail.sql
copy /B /Y MasterBuildDev.sql + spacer.txt

copy /B /Y MasterBuildDev.sql + Proc_EDW_TrackerMetadataExtract.sql
copy /B /Y MasterBuildDev.sql + proc_GetRecordCount.sql

copy /B /Y MasterBuildDev.sql + spacer.txt

copy /B /Y view_EDW_RewardUserDetail.sql view_EDW_RewardUserDetail_temp.sql
copy /B /Y MasterBuildDev.sql + view_EDW_RewardUserDetail_temp.sql

copy /B /Y MasterBuildDev.sql + spacer.txt

copy /B /Y MasterBuildDev.sql + CreateTrackerPerfIndexes.sql

copy /B /Y MasterBuildDev.sql + Job_EDW_GenerateKenticoMetadata.sql

copy /B /Y MasterBuildDev.sql + TheEnd.sql

rem copy /B /Y MasterBuildDev.sql + TestViewsExecution.sql



