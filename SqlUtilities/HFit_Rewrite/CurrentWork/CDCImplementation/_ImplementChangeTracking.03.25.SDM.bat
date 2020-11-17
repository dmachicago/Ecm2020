
cd "C:\DEV\HFitSQL\HFit_Rewrite\CurrentWork\CDCImplementation"
dir  

del IVP.ChangeTracking.sql

copy spacer.txt IVP.ChangeTracking.sql

copy /B /Y IVP.ChangeTracking.sql + ckChangeTrackingTurnedON.sql

copy /B /Y IVP.ChangeTracking.sql + spacer.txt
copy /B /Y IVP.ChangeTracking.sql + "C:\DEV\HFitSQL\HFit_Rewrite\CurrentWork\CDCImplementation\Create_STAGING_EDW_RewardTriggerParameters"

copy /B /Y IVP.ChangeTracking.sql + spacer.txt
copy /B /Y IVP.ChangeTracking.sql + "C:\DEV\HFitSQL\HFit_Rewrite\CurrentWork\CDCImplementation\create_StagingTables.sql"

copy /B /Y IVP.ChangeTracking.sql + spacer.txt
copy /B /Y IVP.ChangeTracking.sql + CreateTable_CT_VersionTracking.Sql

copy /B /Y IVP.ChangeTracking.sql + spacer.txt
copy /B /Y IVP.ChangeTracking.sql + createTable_EDW_CT_ExecutionLog.sql

copy /B /Y IVP.ChangeTracking.sql + spacer.txt
copy /B /Y IVP.ChangeTracking.sql + SetCtHA.sql

copy /B /Y IVP.ChangeTracking.sql + spacer.txt
copy /B /Y IVP.ChangeTracking.sql +"C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_HealthAssesment_CT.sql"

copy /B /Y IVP.ChangeTracking.sql + spacer.txt
copy /B /Y IVP.ChangeTracking.sql +"C:\DEV\HFitSQL\HFit_Rewrite\CurrentWork\CDCImplementation\view_EDW_HealthAssesment\proc_EDW_CountDeletedHA.sql"

copy /B /Y IVP.ChangeTracking.sql + spacer.txt
copy /B /Y IVP.ChangeTracking.sql +"C:\DEV\HFitSQL\HFit_Rewrite\CurrentWork\CDCImplementation\proc_STAGING_EDW_HA_Changes.sql"

copy /B /Y IVP.ChangeTracking.sql + spacer.txt
copy /B /Y IVP.ChangeTracking.sql + "C:\DEV\HFitSQL\HFit_Rewrite\CurrentWork\CDCImplementation\view_EDW_HealthAssesment\proc_STAGING_EDW_HA_Definition.sql"

copy /B /Y IVP.ChangeTracking.sql + spacer.txt
copy /B /Y IVP.ChangeTracking.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_HealthAssessment_Staged.sql"

copy /B /Y IVP.ChangeTracking.sql + spacer.txt
copy /B /Y IVP.ChangeTracking.sql + proc_STAGING_EDW_CompositeTracker.sql

copy /B /Y IVP.ChangeTracking.sql + spacer.txt
copy /B /Y IVP.ChangeTracking.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_TrackerCompositeDetails.sql"

copy /B /Y IVP.ChangeTracking.sql + spacer.txt
copy /B /Y IVP.ChangeTracking.sql +"C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_TrackerCompositeDetails_CT.sql"

copy /B /Y IVP.ChangeTracking.sql + spacer.txt
copy /B /Y IVP.ChangeTracking.sql +"C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_TrackerCompositeDetails_CT_ONLY.SQL"

copy /B /Y IVP.ChangeTracking.sql + spacer.txt
copy /B /Y IVP.ChangeTracking.sql + CreateJobPullEdwData.sql

copy /B /Y IVP.ChangeTracking.sql + spacer.txt
copy /B /Y IVP.ChangeTracking.sql +"C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_HealthAssesmentClientView.sql"

copy /B /Y IVP.ChangeTracking.sql + spacer.txt
copy /B /Y IVP.ChangeTracking.sql +"C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_RewardUserDetail.sql"

copy /B /Y IVP.ChangeTracking.sql + spacer.txt
copy /B /Y IVP.ChangeTracking.sql +"C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_RewardUserDetail_CT.sql"

rem copy /B /Y IVP.ChangeTracking.sql + spacer.txt
rem copy /B /Y IVP.ChangeTracking.sql + create_STAGING_EDW_RewardUserDetail.sql

copy /B /Y IVP.ChangeTracking.sql + spacer.txt
copy /B /Y IVP.ChangeTracking.sql + proc_STAGING_EDW_RewardUserDetail.sql

copy /B /Y IVP.ChangeTracking.sql + spacer.txt
copy /B /Y IVP.ChangeTracking.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_HealthAssesment_CT.sql"

copy /B /Y IVP.ChangeTracking.sql + spacer.txt
copy /B /Y IVP.ChangeTracking.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_HealthAssesmentDefinition_CT.sql"


copy /B /Y IVP.ChangeTracking.sql + spacer.txt
copy /B /Y IVP.ChangeTracking.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_HealthInterestDetail_CT.sql"

copy /B /Y IVP.ChangeTracking.sql + spacer.txt
copy /B /Y IVP.ChangeTracking.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_HealthInterestDetail_STAGED.sql"


copy /B /Y IVP.ChangeTracking.sql + spacer.txt
copy /B /Y IVP.ChangeTracking.sql + proc_STAGING_EDW_HealthInterestDetail.sql

copy /B /Y IVP.ChangeTracking.sql + spacer.txt
copy /B /Y IVP.ChangeTracking.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_HealthInterestList_CT.sql"

copy /B /Y IVP.ChangeTracking.sql + spacer.txt
copy /B /Y IVP.ChangeTracking.sql + proc_STAGING_EDW_HealthInterestList.sql

copy /B /Y IVP.ChangeTracking.sql + spacer.txt
copy /B /Y IVP.ChangeTracking.sql + C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_HealthInterestList_STAGED.sql"


copy /B /Y IVP.ChangeTracking.sql + spacer.txt
copy /B /Y IVP.ChangeTracking.sql + create_job_EDW_getStaging_RewardUserDetail.sql

copy /B /Y IVP.ChangeTracking.sql + spacer.txt
copy /B /Y IVP.ChangeTracking.sql + job_EDW_GetStagingData_RewardUserDetail.sql

copy /B /Y IVP.ChangeTracking.sql + spacer.txt
copy /B /Y IVP.ChangeTracking.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_SmallStepResponses.sql"

copy /B /Y IVP.ChangeTracking.sql + spacer.txt
copy /B /Y IVP.ChangeTracking.sql + proc_STAGING_EDW_SmallSteps.sql

copy /B /Y IVP.ChangeTracking.sql + spacer.txt
copy /B /Y IVP.ChangeTracking.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_HealthAssesmentDefinition_CT.sql"

copy /B /Y IVP.ChangeTracking.sql + spacer.txt
copy /B /Y IVP.ChangeTracking.sql + create_job_PullEdwHaDefinition.sql

copy /B /Y IVP.ChangeTracking.sql + spacer.txt
copy /B /Y IVP.ChangeTracking.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_RewardUserLevel.sql"

copy /B /Y IVP.ChangeTracking.sql + spacer.txt
copy /B /Y IVP.ChangeTracking.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_HealthAssessmentDefinition_Staged.sql"

copy /B /Y IVP.ChangeTracking.sql + spacer.txt
copy /B /Y IVP.ChangeTracking.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_RewardTriggerParameters_STAGED.sql"

copy /B /Y IVP.ChangeTracking.sql + spacer.txt
copy /B /Y IVP.ChangeTracking.sql + "C:\DEV\HFitSQL\HFit_Rewrite\CurrentWork\CDCImplementation\proc_STAGING_EDW_RewardTriggerParameters.sql"

copy /B /Y IVP.ChangeTracking.sql + spacer.txt
copy /B /Y IVP.ChangeTracking.sql + "C:\DEV\HFitSQL\HFit_Rewrite\CurrentWork\CDCImplementation\create_job_EDW_GetStagingData_RewardTriggerParameters.sql"

copy /B /Y IVP.ChangeTracking.sql + spacer.txt
copy /B /Y IVP.ChangeTracking.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_RewardAwardDetail_CT.sql"

copy /B /Y IVP.ChangeTracking.sql + spacer.txt
copy /B /Y IVP.ChangeTracking.sql + "C:\DEV\HFitSQL\HFit_Rewrite\CurrentWork\CDCImplementation\proc_STAGING_EDW_RewardAwardDetail.sql"

copy /B /Y IVP.ChangeTracking.sql + spacer.txt
copy /B /Y IVP.ChangeTracking.sql + "C:\DEV\HFitSQL\HFit_Rewrite\CurrentWork\CDCImplementation\create_job_EDW_GetStagingData_RewardAwardDetail.sql"

copy /B /Y IVP.ChangeTracking.sql + spacer.txt
copy /B /Y IVP.ChangeTracking.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_RewardAwardDetail_STAGED.sql"

copy /B /Y IVP.ChangeTracking.sql + spacer.txt
copy /B /Y IVP.ChangeTracking.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_RewardUserLevel_CT.SQL"

copy /B /Y IVP.ChangeTracking.sql + spacer.txt
copy /B /Y IVP.ChangeTracking.sql + "C:\DEV\HFitSQL\HFit_Rewrite\CurrentWork\CDCImplementation\proc_STAGING_EDW_RewardUserLevel.SQL"

copy /B /Y IVP.ChangeTracking.sql + spacer.txt
copy /B /Y IVP.ChangeTracking.sql + "C:\DEV\HFitSQL\HFit_Rewrite\CurrentWork\CDCImplementation\create_job_EDW_GetStagingData_RewardUserLevel.SQL"

copy /B /Y IVP.ChangeTracking.sql + spacer.txt
copy /B /Y IVP.ChangeTracking.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_RewardUserLevel_STAGED.sql"

copy /B /Y IVP.ChangeTracking.sql + spacer.txt
copy /B /Y IVP.ChangeTracking.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_Coaches_CT.sql"

copy /B /Y IVP.ChangeTracking.sql + spacer.txt
copy /B /Y IVP.ChangeTracking.sql + "C:\DEV\HFitSQL\HFit_Rewrite\CurrentWork\CDCImplementation\proc_STAGING_EDW_Coaches.sql"

copy /B /Y IVP.ChangeTracking.sql + spacer.txt
copy /B /Y IVP.ChangeTracking.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_Coaches_STAGED.sql"

copy /B /Y IVP.ChangeTracking.sql + spacer.txt
copy /B /Y IVP.ChangeTracking.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_CoachingDetail.sql"

copy /B /Y IVP.ChangeTracking.sql + spacer.txt
copy /B /Y IVP.ChangeTracking.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_CoachingDetail_CT.sql"

copy /B /Y IVP.ChangeTracking.sql + spacer.txt
copy /B /Y IVP.ChangeTracking.sql + "C:\DEV\HFitSQL\HFit_Rewrite\CurrentWork\CDCImplementation\proc_STAGING_EDW_CoachingDetail.sql"

copy /B /Y IVP.ChangeTracking.sql + spacer.txt
copy /B /Y IVP.ChangeTracking.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_CoachingDetail_STAGE.sql"

copy /B /Y IVP.ChangeTracking.sql + spacer.txt
copy /B /Y IVP.ChangeTracking.sql + "C:\DEV\HFitSQL\HFit_Rewrite\CurrentWork\CDCImplementation\create_job_EDW_GetStagingData_CoachingDetail.sql"

copy /B /Y IVP.ChangeTracking.sql + spacer.txt
copy /B /Y IVP.ChangeTracking.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_CT_ExecutionLog.sql"

copy /B /Y IVP.ChangeTracking.sql + spacer.txt
copy /B /Y IVP.ChangeTracking.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_RewardsDefinition_CT.sql"

copy /B /Y IVP.ChangeTracking.sql + spacer.txt
copy /B /Y IVP.ChangeTracking.sql + "C:\DEV\HFitSQL\HFit_Rewrite\CurrentWork\CDCImplementation\proc_STAGING_EDW_RewardsDefinition.sql"

copy /B /Y IVP.ChangeTracking.sql + spacer.txt
copy /B /Y IVP.ChangeTracking.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_RewardsDefinition_STAGE.sql"

copy /B /Y IVP.ChangeTracking.sql + spacer.txt
copy /B /Y IVP.ChangeTracking.sql + "C:\DEV\HFitSQL\HFit_Rewrite\CurrentWork\CDCImplementation\create_job_EDW_GetStagingData_RewardsDefinition.sql"

copy /B /Y IVP.ChangeTracking.sql + spacer.txt
copy /B /Y IVP.ChangeTracking.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_TrackerTests.sql"

copy /B /Y IVP.ChangeTracking.sql + spacer.txt
copy /B /Y IVP.ChangeTracking.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_TrackerShots.sql"

copy /B /Y IVP.ChangeTracking.sql + spacer.txt
copy /B /Y IVP.ChangeTracking.sql + "C:\DEV\HFitSQL\HFit_Rewrite\CurrentWork\CDCImplementation\create_job_EDW_GetStagingData_Trackers.sql"

copy /B /Y IVP.ChangeTracking.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\TheEnd.SQL"
