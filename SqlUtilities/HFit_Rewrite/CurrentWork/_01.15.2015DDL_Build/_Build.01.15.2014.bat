
cd "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\_01.15.2015DDL_Build"

del IVP.Master.03.01.2014.sql

copy "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\spacer.txt" IVP.Master.03.01.2014.sql
rem pause

copy /B /Y IVP.Master.03.01.2014.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\spacer.txt"
copy /B /Y IVP.Master.03.01.2014.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\_ChangeTracking\ChangeTrackingBuild.sql"

copy /B /Y IVP.Master.03.01.2014.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\spacer.txt"
copy /B /Y IVP.Master.03.01.2014.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\proc_GetViewBaseTables.sql"

rem copy /B /Y IVP.Master.03.01.2014.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\spacer.txt"
copy /B /Y IVP.Master.03.01.2014.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\HFit_LKP_GoalCloseReason_Create_Table.SQL"

copy /B /Y IVP.Master.03.01.2014.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\spacer.txt"
copy /B /Y IVP.Master.03.01.2014.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\Create_HFit_LKP_TrackerVendor_Table.sql"

copy /B /Y IVP.Master.03.01.2014.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\spacer.txt"
copy /B /Y IVP.Master.03.01.2014.sql + "SynchronizeTrackerTables.sql"

copy /B /Y IVP.Master.03.01.2014.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\spacer.txt"
copy /B /Y IVP.Master.03.01.2014.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\Create_HFit_LKP_EDW_RejectMPI_Table.sql"


copy /B /Y IVP.Master.03.01.2014.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\spacer.txt"
copy /B /Y IVP.Master.03.01.2014.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\_AuditDeletes\proc_CreateDeleteAudit.SQL"

copy /B /Y IVP.Master.03.01.2014.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\spacer.txt"
copy /B /Y IVP.Master.03.01.2014.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_HealthAssesment.SQL"

copy /B /Y IVP.Master.03.01.2014.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\spacer.txt"
copy /B /Y IVP.Master.03.01.2014.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_CoachingDetail.SQL"

copy /B /Y IVP.Master.03.01.2014.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\spacer.txt"
copy /B /Y IVP.Master.03.01.2014.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_HealthAssesmentDeffinition.SQL"

copy /B /Y IVP.Master.03.01.2014.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\spacer.txt"
copy /B /Y IVP.Master.03.01.2014.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_RewardUserDetail.SQL"

copy /B /Y IVP.Master.03.01.2014.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\spacer.txt"
copy /B /Y IVP.Master.03.01.2014.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_RewardsDefinition.SQL"

copy /B /Y IVP.Master.03.01.2014.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\spacer.txt"
copy /B /Y IVP.Master.03.01.2014.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_BioMetrics.SQL"

copy /B /Y IVP.Master.03.01.2014.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\spacer.txt"
copy /B /Y IVP.Master.03.01.2014.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_TrackerCompositeDetails.SQL"

copy /B /Y IVP.Master.03.01.2014.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\spacer.txt"
copy /B /Y IVP.Master.03.01.2014.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\_Eligibility\EligibilityImplementationScript.SQL"

copy /B /Y IVP.Master.03.01.2014.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\spacer.txt"
copy /B /Y IVP.Master.03.01.2014.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\IndexTuning\HAProdIndexTuning.sql"



rem copy /B /Y IVP.Master.03.01.2014.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\spacer.txt"
rem copy /B /Y IVP.Master.03.01.2014.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\Issues\HA_IndexCleanUP.SQL"

copy /B /Y IVP.Master.03.01.2014.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\spacer.txt"
copy /B /Y IVP.Master.03.01.2014.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_RewardUserLevel.sql"

copy /B /Y IVP.Master.03.01.2014.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\spacer.txt"
copy /B /Y IVP.Master.03.01.2014.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\createTableEDW_PerformanceMeasure.sql"

copy /B /Y IVP.Master.03.01.2014.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\spacer.txt"
copy /B /Y IVP.Master.03.01.2014.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\CreateTableEDW_HealthAssessment.sql"

copy /B /Y IVP.Master.03.01.2014.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\spacer.txt"
copy /B /Y IVP.Master.03.01.2014.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\_01.15.2015DDL_Build\dropViews.sql"

copy /B /Y IVP.Master.03.01.2014.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\spacer.txt"
copy /B /Y IVP.Master.03.01.2014.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_HealthAssesmentClientView.sql"

copy /B /Y IVP.Master.03.01.2014.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\spacer.txt"
copy /B /Y IVP.Master.03.01.2014.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_RewardAwardDetail.sql"

copy /B /Y IVP.Master.03.01.2014.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\spacer.txt"
copy /B /Y IVP.Master.03.01.2014.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_RewardTriggerParameters.sql"



copy /B /Y IVP.Master.03.01.2014.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\spacer.txt"
copy /B /Y IVP.Master.03.01.2014.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\_01.15.2015DDL_Build\dropViews.sql"

copy /B /Y IVP.Master.03.01.2014.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\spacer.txt"
copy /B /Y IVP.Master.03.01.2014.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_RewardUserLevel.sql"


copy /B /Y IVP.Master.03.01.2014.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\spacer.txt"
copy /B /Y IVP.Master.03.01.2014.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_RewardUserLevel.sql"


copy /B /Y IVP.Master.03.01.2014.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\spacer.txt"
copy /B /Y IVP.Master.03.01.2014.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\view_EDW_RewardUserDetail.sql"


copy /B /Y IVP.Master.03.01.2014.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\spacer.txt"
copy /B /Y IVP.Master.03.01.2014.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\view_EDW_RewardsDefinition.sql"

copy /B /Y IVP.Master.03.01.2014.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\spacer.txt"
copy /B /Y IVP.Master.03.01.2014.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_HealthAssesmentClientView.sql"

copy /B /Y IVP.Master.03.01.2014.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\spacer.txt"
copy /B /Y IVP.Master.03.01.2014.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\DropViewCleanUp.sql"


copy /B /Y IVP.Master.03.01.2014.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\spacer.txt"
copy /B /Y IVP.Master.03.01.2014.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_Awards.sql"

copy /B /Y IVP.Master.03.01.2014.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\spacer.txt"
copy /B /Y IVP.Master.03.01.2014.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\_Eligibility\Create_Job_update_EDW_Eligibility.sql" 

copy /B /Y IVP.Master.03.01.2014.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\spacer.txt"
copy /B /Y IVP.Master.03.01.2014.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\DataUpdates\RejectList.sql"

copy /B /Y IVP.Master.03.01.2014.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\spacer.txt"
copy /B /Y IVP.Master.03.01.2014.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\CreateEDW_HealthAssessmentDefinition.sql"

copy /B /Y IVP.Master.03.01.2014.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\spacer.txt"
copy /B /Y IVP.Master.03.01.2014.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\CreateTracker_EDW_Metadata.sql"

copy /B /Y IVP.Master.03.01.2014.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\spacer.txt"
copy /B /Y IVP.Master.03.01.2014.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\HFIT_Build_Tracker_Metadata_Environment.sql"

copy /B /Y IVP.Master.03.01.2014.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\spacer.txt"
copy /B /Y IVP.Master.03.01.2014.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\Proc_EDW_HealthAssessment.sql"

copy /B /Y IVP.Master.03.01.2014.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\spacer.txt"
copy /B /Y IVP.Master.03.01.2014.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\Proc_EDW_HealthAssessmentDefinition.sql"

copy /B /Y IVP.Master.03.01.2014.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\spacer.txt"
copy /B /Y IVP.Master.03.01.2014.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\Proc_EDW_TrackerMetadataExtract.sql"

copy /B /Y IVP.Master.03.01.2014.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\spacer.txt"
copy /B /Y IVP.Master.03.01.2014.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\_ChangeTracking\trgSchemaMonitor.sql"

copy /B /Y IVP.Master.03.01.2014.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\spacer.txt"
copy /B /Y IVP.Master.03.01.2014.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\_ChangeTracking\Proc_EDW_Compare_Views.sql"

copy /B /Y IVP.Master.03.01.2014.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\spacer.txt"
copy /B /Y IVP.Master.03.01.2014.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\_ChangeTracking\Proc_EDW_Compare_Tables.sql"

copy /B /Y IVP.Master.03.01.2014.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\spacer.txt"
copy /B /Y IVP.Master.03.01.2014.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\_ChangeTracking\CreateDdlAuditTables.sql"

copy /B /Y IVP.Master.03.01.2014.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\spacer.txt"
copy /B /Y IVP.Master.03.01.2014.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\_ChangeTracking\SchemaChangeMonitor.sql"

copy /B /Y IVP.Master.03.01.2014.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\spacer.txt"
copy /B /Y IVP.Master.03.01.2014.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_CoachingDefinition.sql"

copy /B /Y IVP.Master.03.01.2014.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\spacer.txt"
copy /B /Y IVP.Master.03.01.2014.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\View_EDW_HealthAssesmentQuestions.sql"

copy /B /Y IVP.Master.03.01.2014.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\spacer.txt"
copy /B /Y IVP.Master.03.01.2014.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_HealthAssessment_Staged.sql"

copy /B /Y IVP.Master.03.01.2014.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\spacer.txt"
copy /B /Y IVP.Master.03.01.2014.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_HealthInterestDetail.sql"

copy /B /Y IVP.Master.03.01.2014.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\spacer.txt"
copy /B /Y IVP.Master.03.01.2014.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_HealthInterestList.sql"

copy /B /Y IVP.Master.03.01.2014.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\spacer.txt"
copy /B /Y IVP.Master.03.01.2014.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_RewardTriggerParameters.sql"

copy /B /Y IVP.Master.03.01.2014.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\spacer.txt"
copy /B /Y IVP.Master.03.01.2014.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\_03.01.2015_IVP\IVP.03.01.2015.sql"

copy /B /Y IVP.Master.03.01.2014.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\spacer.txt"
copy /B /Y IVP.Master.03.01.2014.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\_03.01.2015_IVP\IVP.VIEWS.Validate.Exist.02.26.2015.sql"

copy /B /Y IVP.Master.03.01.2014.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\spacer.txt"
copy /B /Y IVP.Master.03.01.2014.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\IVP_Views.sql"

copy /B /Y IVP.Master.03.01.2014.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\spacer.txt"
copy /B /Y IVP.Master.03.01.2014.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\IVP_EDW_DATA_VIEWS.sql"

copy /B /Y IVP.Master.03.01.2014.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\TheEnd.SQL"
rem pause

REM *********************************************************************************************************
cd C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\_03.01.2015_IVP
call _Build.03.01.2015.bat
rem pause
REM *********************************************************************************************************

cd "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\_01.15.2015DDL_Build"