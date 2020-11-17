use KenticoCMS_DataMart
go

--GENERATE DROP STATEMENTS
SELECT 'msdb.dbo.sp_delete_job @job_name=N'''+name+'''' + ', @delete_unused_schedule=1 '
            FROM msdb.dbo.sysjobs_view 
		  where name like '%CT_DIM_%'
--GENERATE DISABLE STATEMENTS
SELECT 'msdb.dbo.sp_update_job @job_name=N'''+name+'''' + ', @enabled=0; ' + char(10) + 'GO'
            FROM msdb.dbo.sysjobs_view 
		  where name like '%CT_DIM_%'

--DROP IF EXISTS
IF EXISTS (SELECT job_id 
            FROM msdb.dbo.sysjobs_view 
            WHERE name = N'Your Job Name')
EXEC msdb.dbo.sp_delete_job @job_name=N'Your Job Name'
                            , @delete_unused_schedule=1

--GENERATE ADD STEPS 
select 'EXEC sp_add_jobstep ' + char(10)
    + '@job_name = ''job_CT_TrackerMergeMaster'','  + char(10)
    + '@step_name = '''+name+''','  + char(10)
    + '@subsystem = ''TSQL'','  + char(10)
    + '@command = ''EXEC ' + name + ''','  + char(10)
    + '@on_fail_action = 3,' + char(10)
    + '@retry_attempts = 2,' + char(10)
    + '@retry_interval = 5;' + char(10)

from sys.procedures where name like '%track%' and name like '%_CT_DIM%' and name not like '%_BASE_%'

USE msdb;
go
EXEC sp_add_jobstep 
@job_name = 'job_CT_TrackerMergeMaster',
@step_name = 'proc_CT_DIM_HFIT_Tracker',
@subsystem = 'TSQL',
@command = 'EXEC proc_CT_DIM_HFIT_Tracker',
@on_fail_action = 3,
@retry_attempts = 2,
@retry_interval = 5;
go

EXEC sp_add_jobstep 
@job_name = 'job_CT_TrackerMergeMaster',
@step_name = 'proc_CT_DIM_HFit_TrackerBloodPressure',
@subsystem = 'TSQL',
@command = 'EXEC proc_CT_DIM_HFit_TrackerBloodPressure',
@on_fail_action = 3,
@retry_attempts = 2,
@retry_interval = 5;

EXEC sp_add_jobstep 
@job_name = 'job_CT_TrackerMergeMaster',
@step_name = 'proc_CT_DIM_HFit_TrackerBloodSugarAndGlucose',
@subsystem = 'TSQL',
@command = 'EXEC proc_CT_DIM_HFit_TrackerBloodSugarAndGlucose',
@on_fail_action = 3,
@retry_attempts = 2,
@retry_interval = 5;

EXEC sp_add_jobstep 
@job_name = 'job_CT_TrackerMergeMaster',
@step_name = 'proc_CT_DIM_HFit_TrackerBMI',
@subsystem = 'TSQL',
@command = 'EXEC proc_CT_DIM_HFit_TrackerBMI',
@on_fail_action = 3,
@retry_attempts = 2,
@retry_interval = 5;

EXEC sp_add_jobstep 
@job_name = 'job_CT_TrackerMergeMaster',
@step_name = 'proc_CT_DIM_HFit_TrackerBodyFat',
@subsystem = 'TSQL',
@command = 'EXEC proc_CT_DIM_HFit_TrackerBodyFat',
@on_fail_action = 3,
@retry_attempts = 2,
@retry_interval = 5;

EXEC sp_add_jobstep 
@job_name = 'job_CT_TrackerMergeMaster',
@step_name = 'proc_CT_DIM_HFit_TrackerBodyMeasurements',
@subsystem = 'TSQL',
@command = 'EXEC proc_CT_DIM_HFit_TrackerBodyMeasurements',
@on_fail_action = 3,
@retry_attempts = 2,
@retry_interval = 5;

EXEC sp_add_jobstep 
@job_name = 'job_CT_TrackerMergeMaster',
@step_name = 'proc_CT_DIM_HFit_TrackerCardio',
@subsystem = 'TSQL',
@command = 'EXEC proc_CT_DIM_HFit_TrackerCardio',
@on_fail_action = 3,
@retry_attempts = 2,
@retry_interval = 5;

EXEC sp_add_jobstep 
@job_name = 'job_CT_TrackerMergeMaster',
@step_name = 'proc_CT_DIM_HFit_TrackerCholesterol',
@subsystem = 'TSQL',
@command = 'EXEC proc_CT_DIM_HFit_TrackerCholesterol',
@on_fail_action = 3,
@retry_attempts = 2,
@retry_interval = 5;

EXEC sp_add_jobstep 
@job_name = 'job_CT_TrackerMergeMaster',
@step_name = 'proc_CT_DIM_HFit_TrackerCollectionSource',
@subsystem = 'TSQL',
@command = 'EXEC proc_CT_DIM_HFit_TrackerCollectionSource',
@on_fail_action = 3,
@retry_attempts = 2,
@retry_interval = 5;

EXEC sp_add_jobstep 
@job_name = 'job_CT_TrackerMergeMaster',
@step_name = 'proc_CT_DIM_HFit_TrackerCotinine',
@subsystem = 'TSQL',
@command = 'EXEC proc_CT_DIM_HFit_TrackerCotinine',
@on_fail_action = 3,
@retry_attempts = 2,
@retry_interval = 5;

EXEC sp_add_jobstep 
@job_name = 'job_CT_TrackerMergeMaster',
@step_name = 'proc_CT_DIM_HFit_TrackerDailySteps',
@subsystem = 'TSQL',
@command = 'EXEC proc_CT_DIM_HFit_TrackerDailySteps',
@on_fail_action = 3,
@retry_attempts = 2,
@retry_interval = 5;

EXEC sp_add_jobstep 
@job_name = 'job_CT_TrackerMergeMaster',
@step_name = 'proc_CT_DIM_HFit_TrackerFlexibility',
@subsystem = 'TSQL',
@command = 'EXEC proc_CT_DIM_HFit_TrackerFlexibility',
@on_fail_action = 3,
@retry_attempts = 2,
@retry_interval = 5;

EXEC sp_add_jobstep 
@job_name = 'job_CT_TrackerMergeMaster',
@step_name = 'proc_CT_DIM_HFit_TrackerFruits',
@subsystem = 'TSQL',
@command = 'EXEC proc_CT_DIM_HFit_TrackerFruits',
@on_fail_action = 3,
@retry_attempts = 2,
@retry_interval = 5;

EXEC sp_add_jobstep 
@job_name = 'job_CT_TrackerMergeMaster',
@step_name = 'proc_CT_DIM_HFit_TrackerHbA1c',
@subsystem = 'TSQL',
@command = 'EXEC proc_CT_DIM_HFit_TrackerHbA1c',
@on_fail_action = 3,
@retry_attempts = 2,
@retry_interval = 5;

EXEC sp_add_jobstep 
@job_name = 'job_CT_TrackerMergeMaster',
@step_name = 'proc_CT_DIM_HFit_TrackerHeight',
@subsystem = 'TSQL',
@command = 'EXEC proc_CT_DIM_HFit_TrackerHeight',
@on_fail_action = 3,
@retry_attempts = 2,
@retry_interval = 5;

EXEC sp_add_jobstep 
@job_name = 'job_CT_TrackerMergeMaster',
@step_name = 'proc_CT_DIM_HFit_TrackerHighFatFoods',
@subsystem = 'TSQL',
@command = 'EXEC proc_CT_DIM_HFit_TrackerHighFatFoods',
@on_fail_action = 3,
@retry_attempts = 2,
@retry_interval = 5;

EXEC sp_add_jobstep 
@job_name = 'job_CT_TrackerMergeMaster',
@step_name = 'proc_CT_DIM_HFit_TrackerHighSodiumFoods',
@subsystem = 'TSQL',
@command = 'EXEC proc_CT_DIM_HFit_TrackerHighSodiumFoods',
@on_fail_action = 3,
@retry_attempts = 2,
@retry_interval = 5;

EXEC sp_add_jobstep 
@job_name = 'job_CT_TrackerMergeMaster',
@step_name = 'proc_CT_DIM_HFit_TrackerInstance_Tracker',
@subsystem = 'TSQL',
@command = 'EXEC proc_CT_DIM_HFit_TrackerInstance_Tracker',
@on_fail_action = 3,
@retry_attempts = 2,
@retry_interval = 5;

EXEC sp_add_jobstep 
@job_name = 'job_CT_TrackerMergeMaster',
@step_name = 'proc_CT_DIM_HFit_TrackerMealPortions',
@subsystem = 'TSQL',
@command = 'EXEC proc_CT_DIM_HFit_TrackerMealPortions',
@on_fail_action = 3,
@retry_attempts = 2,
@retry_interval = 5;

EXEC sp_add_jobstep 
@job_name = 'job_CT_TrackerMergeMaster',
@step_name = 'proc_CT_DIM_HFit_TrackerMedicalCarePlan',
@subsystem = 'TSQL',
@command = 'EXEC proc_CT_DIM_HFit_TrackerMedicalCarePlan',
@on_fail_action = 3,
@retry_attempts = 2,
@retry_interval = 5;

EXEC sp_add_jobstep 
@job_name = 'job_CT_TrackerMergeMaster',
@step_name = 'proc_CT_DIM_HFit_TrackerPreventiveCare',
@subsystem = 'TSQL',
@command = 'EXEC proc_CT_DIM_HFit_TrackerPreventiveCare',
@on_fail_action = 3,
@retry_attempts = 2,
@retry_interval = 5;

EXEC sp_add_jobstep 
@job_name = 'job_CT_TrackerMergeMaster',
@step_name = 'proc_CT_DIM_HFit_TrackerRegularMeals',
@subsystem = 'TSQL',
@command = 'EXEC proc_CT_DIM_HFit_TrackerRegularMeals',
@on_fail_action = 3,
@retry_attempts = 2,
@retry_interval = 5;

EXEC sp_add_jobstep 
@job_name = 'job_CT_TrackerMergeMaster',
@step_name = 'proc_CT_DIM_HFit_TrackerRestingHeartRate',
@subsystem = 'TSQL',
@command = 'EXEC proc_CT_DIM_HFit_TrackerRestingHeartRate',
@on_fail_action = 3,
@retry_attempts = 2,
@retry_interval = 5;

EXEC sp_add_jobstep 
@job_name = 'job_CT_TrackerMergeMaster',
@step_name = 'proc_CT_DIM_HFit_TrackerShots',
@subsystem = 'TSQL',
@command = 'EXEC proc_CT_DIM_HFit_TrackerShots',
@on_fail_action = 3,
@retry_attempts = 2,
@retry_interval = 5;

EXEC sp_add_jobstep 
@job_name = 'job_CT_TrackerMergeMaster',
@step_name = 'proc_CT_DIM_HFit_TrackerSitLess',
@subsystem = 'TSQL',
@command = 'EXEC proc_CT_DIM_HFit_TrackerSitLess',
@on_fail_action = 3,
@retry_attempts = 2,
@retry_interval = 5;

EXEC sp_add_jobstep 
@job_name = 'job_CT_TrackerMergeMaster',
@step_name = 'proc_CT_DIM_HFit_TrackerSleepPlan',
@subsystem = 'TSQL',
@command = 'EXEC proc_CT_DIM_HFit_TrackerSleepPlan',
@on_fail_action = 3,
@retry_attempts = 2,
@retry_interval = 5;

EXEC sp_add_jobstep 
@job_name = 'job_CT_TrackerMergeMaster',
@step_name = 'proc_CT_DIM_HFit_TrackerStrength',
@subsystem = 'TSQL',
@command = 'EXEC proc_CT_DIM_HFit_TrackerStrength',
@on_fail_action = 3,
@retry_attempts = 2,
@retry_interval = 5;

EXEC sp_add_jobstep 
@job_name = 'job_CT_TrackerMergeMaster',
@step_name = 'proc_CT_DIM_HFit_TrackerStress',
@subsystem = 'TSQL',
@command = 'EXEC proc_CT_DIM_HFit_TrackerStress',
@on_fail_action = 3,
@retry_attempts = 2,
@retry_interval = 5;

EXEC sp_add_jobstep 
@job_name = 'job_CT_TrackerMergeMaster',
@step_name = 'proc_CT_DIM_HFit_TrackerStressManagement',
@subsystem = 'TSQL',
@command = 'EXEC proc_CT_DIM_HFit_TrackerStressManagement',
@on_fail_action = 3,
@retry_attempts = 2,
@retry_interval = 5;

EXEC sp_add_jobstep 
@job_name = 'job_CT_TrackerMergeMaster',
@step_name = 'proc_CT_DIM_HFit_TrackerSugaryDrinks',
@subsystem = 'TSQL',
@command = 'EXEC proc_CT_DIM_HFit_TrackerSugaryDrinks',
@on_fail_action = 3,
@retry_attempts = 2,
@retry_interval = 5;

EXEC sp_add_jobstep 
@job_name = 'job_CT_TrackerMergeMaster',
@step_name = 'proc_CT_DIM_HFit_TrackerSugaryFoods',
@subsystem = 'TSQL',
@command = 'EXEC proc_CT_DIM_HFit_TrackerSugaryFoods',
@on_fail_action = 3,
@retry_attempts = 2,
@retry_interval = 5;

EXEC sp_add_jobstep 
@job_name = 'job_CT_TrackerMergeMaster',
@step_name = 'proc_CT_DIM_HFit_TrackerTests',
@subsystem = 'TSQL',
@command = 'EXEC proc_CT_DIM_HFit_TrackerTests',
@on_fail_action = 3,
@retry_attempts = 2,
@retry_interval = 5;

EXEC sp_add_jobstep 
@job_name = 'job_CT_TrackerMergeMaster',
@step_name = 'proc_CT_DIM_HFit_TrackerTobaccoAttestation',
@subsystem = 'TSQL',
@command = 'EXEC proc_CT_DIM_HFit_TrackerTobaccoAttestation',
@on_fail_action = 3,
@retry_attempts = 2,
@retry_interval = 5;

EXEC sp_add_jobstep 
@job_name = 'job_CT_TrackerMergeMaster',
@step_name = 'proc_CT_DIM_HFit_TrackerTobaccoFree',
@subsystem = 'TSQL',
@command = 'EXEC proc_CT_DIM_HFit_TrackerTobaccoFree',
@on_fail_action = 3,
@retry_attempts = 2,
@retry_interval = 5;

EXEC sp_add_jobstep 
@job_name = 'job_CT_TrackerMergeMaster',
@step_name = 'proc_CT_DIM_HFit_TrackerVegetables',
@subsystem = 'TSQL',
@command = 'EXEC proc_CT_DIM_HFit_TrackerVegetables',
@on_fail_action = 3,
@retry_attempts = 2,
@retry_interval = 5;

EXEC sp_add_jobstep 
@job_name = 'job_CT_TrackerMergeMaster',
@step_name = 'proc_CT_DIM_HFit_TrackerWater',
@subsystem = 'TSQL',
@command = 'EXEC proc_CT_DIM_HFit_TrackerWater',
@on_fail_action = 3,
@retry_attempts = 2,
@retry_interval = 5;

EXEC sp_add_jobstep 
@job_name = 'job_CT_TrackerMergeMaster',
@step_name = 'proc_CT_DIM_HFit_TrackerWeight',
@subsystem = 'TSQL',
@command = 'EXEC proc_CT_DIM_HFit_TrackerWeight',
@on_fail_action = 3,
@retry_attempts = 2,
@retry_interval = 5;

EXEC sp_add_jobstep 
@job_name = 'job_CT_TrackerMergeMaster',
@step_name = 'proc_CT_DIM_HFit_TrackerWholeGrains',
@subsystem = 'TSQL',
@command = 'EXEC proc_CT_DIM_HFit_TrackerWholeGrains',
@on_fail_action = 3,
@retry_attempts = 2,
@retry_interval = 5;
