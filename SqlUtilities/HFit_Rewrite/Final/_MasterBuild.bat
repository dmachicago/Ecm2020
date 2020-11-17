del MasterBuildProc.sql


copy /A SetDB.sql MasterBuildProd.sql

copy /Y MasterBuildProd.sql + proc_GetRecordCount.sql

copy /Y MasterBuildProd.sql + CreateTracker_EDW_Metadata.sql

copy /Y MasterBuildProd.sql + CreateTableEDW_HealthAssessment.sql

copy /Y MasterBuildProd.sql + CreateEDW_HealthAssessmentDefinition.sql


copy /Y MasterBuildProd.sql + udfElapsedTime.sql
copy /Y MasterBuildProd.sql + udfTimeSpanFromMilliSeconds.sql
copy /Y MasterBuildProd.sql + UTIL_getUsageCount.sql
copy /Y MasterBuildProd.sql + UTIL_SearchAllTables.sql
copy /Y MasterBuildProd.sql + UTIL_ViewAnalysis.sql
copy /Y MasterBuildProd.sql + UTIL_DisplayBlockingQry.sql

rem rem copy /Y MasterBuildProd.sql + view_EDW_CDC_HealthAssesmentUserAnswers.sql

copy /Y MasterBuildProd.sql + view_EDW_HealthAssesmentQuestions.sql

copy /Y MasterBuildProd.sql + view_EDW_HFit_HealthAssesmentUserRiskArea.sql
copy /Y MasterBuildProd.sql + view_EDW_ClientCompany.sql
copy /Y MasterBuildProd.sql + view_EDW_Coaches.sql
copy /Y MasterBuildProd.sql + view_EDW_CoachingDefinition.sql
copy /Y MasterBuildProd.sql + view_EDW_CoachingDetail.sql
copy /Y MasterBuildProd.sql + view_EDW_HealthAssesmentAnswers.sql
copy /Y MasterBuildProd.sql + view_EDW_HealthAssesmentClientView.sql
copy /Y MasterBuildProd.sql + view_EDW_HealthAssesmentDeffinition.sql
copy /Y MasterBuildProd.sql + view_EDW_HealthAssesmentDeffinitionCustom.sql



copy /Y MasterBuildProd.sql + view_EDW_HFit_HealthAssesmentUserAnswers.sql
copy /Y MasterBuildProd.sql + view_EDW_HFit_HealthAssesmentUserModule.sql
copy /Y MasterBuildProd.sql + view_EDW_HFit_HealthAssesmentUserQuestion.sql

copy /Y MasterBuildProd.sql + view_EDW_HFit_HealthAssesmentUserRiskCategory.sql
copy /Y MasterBuildProd.sql + view_EDW_HFit_HealthAssesmentUserStarted.sql
copy /Y MasterBuildProd.sql + view_EDW_Participant.sql
copy /Y MasterBuildProd.sql + view_EDW_RewardAwardDetail.sql
copy /Y MasterBuildProd.sql + view_EDW_RewardsDefinition.sql
copy /Y MasterBuildProd.sql + view_EDW_RewardTriggerParameters.sql
copy /Y MasterBuildProd.sql + view_EDW_RewardUserDetail.sql
copy /Y MasterBuildProd.sql + view_EDW_ScreeningsFromTrackers.sql
copy /Y MasterBuildProd.sql + view_EDW_TrackerCompositeDetails.sql
copy /Y MasterBuildProd.sql + view_EDW_TrackerMetadata.sql
copy /Y MasterBuildProd.sql + view_EDW_TrackerShots.sql
copy /Y MasterBuildProd.sql + view_EDW_TrackerTests.sql

copy /Y MasterBuildProd.sql + view_EDW_HealthAssesment.sql

copy /Y MasterBuildProd.sql + view_EDW_HAassessment

copy /Y MasterBuildProd.sql + Proc_EDW_GenerateMetadata.sql
copy /Y MasterBuildProd.sql + Proc_EDW_HealthAssessment.sql
copy /Y MasterBuildProd.sql + Proc_EDW_HealthAssessmentDefinition.sql
copy /Y MasterBuildProd.sql + proc_EDW_MeasurePerf.sql
copy /Y MasterBuildProd.sql + Proc_EDW_RewardUserDetail.sql
copy /Y MasterBuildProd.sql + Proc_EDW_TrackerMetadataExtract.sql
copy /Y MasterBuildProd.sql + proc_GetRecordCount.sql

copy /Y MasterBuildProd.sql + CreateTrackerPerfIndexes.sql
copy /Y MasterBuildProd.sql + AddNeededIndexes.sql

copy /Y MasterBuildProd.sql + Job_EDW_GenerateKenticoMetadata.sql

