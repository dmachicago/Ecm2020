-- use KenticoCMS_Datamart_2
-- exec proc_GenTrackerCTProc BASE_HFit_TrackerDailySteps  ,0
/*
select 'EXEC proc_GenTrackerCTProc ' + table_name + ',0' +char(10) + 'GO'
from information_schema.tables where table_type = 'BASE TABLE'
and table_name like 'BASE_%' 
and table_name like '%tracker%' 
and table_name not like '%VerHist' 
and table_name not like '%_DEL' 
and table_name not like '%TestData' 
and table_name not like '%_view_%' 
and table_name not like '%_lkp_%' 
and table_name not like '%_REF_%' 
and table_name not like '%_JOIN_%' 
and table_name not like '%_Joined' 

*/

EXEC proc_GenTrackerCTProc BASE_HFit_HealthAssessmentCodeNamesToTrackerMapping,0
GO
EXEC proc_GenTrackerCTProc BASE_HFit_Join_ClinicalSourceTracker,0
GO
EXEC proc_GenTrackerCTProc BASE_HFit_join_ClinicalTrackers,0
GO
EXEC proc_GenTrackerCTProc BASE_Hfit_LKP_CustomTrackerDefaultMetadata,0
GO
EXEC proc_GenTrackerCTProc BASE_HFit_LKP_TrackerCardioActivity,0
GO
EXEC proc_GenTrackerCTProc BASE_HFit_LKP_TrackerFlexibilityActivity,0
GO
EXEC proc_GenTrackerCTProc BASE_HFit_LKP_TrackerSleepPlanTechniques,0
GO
EXEC proc_GenTrackerCTProc BASE_HFit_LKP_TrackerStrengthActivity,0
GO
EXEC proc_GenTrackerCTProc BASE_HFit_LKP_TrackerTable,0
GO
EXEC proc_GenTrackerCTProc BASE_HFit_LKP_TrackerTobaccoQuitAids,0
GO
EXEC proc_GenTrackerCTProc BASE_HFit_LKP_TrackerVendor,0
GO
EXEC proc_GenTrackerCTProc BASE_HFit_Ref_RewardTrackerValidation,0
GO
EXEC proc_GenTrackerCTProc BASE_HFIT_Tracker,0
GO
EXEC proc_GenTrackerCTProc BASE_HFit_TrackerBloodPressure,0
GO
EXEC proc_GenTrackerCTProc BASE_HFit_TrackerBloodSugarAndGlucose,0
GO
EXEC proc_GenTrackerCTProc BASE_HFit_TrackerBMI,0
GO
EXEC proc_GenTrackerCTProc BASE_HFit_TrackerBodyFat,0
GO
EXEC proc_GenTrackerCTProc BASE_HFit_TrackerBodyMeasurements,0
GO
EXEC proc_GenTrackerCTProc BASE_HFit_TrackerCardio,0
GO
EXEC proc_GenTrackerCTProc BASE_HFit_TrackerCategory,0
GO
EXEC proc_GenTrackerCTProc BASE_HFit_TrackerCholesterol,0
GO
EXEC proc_GenTrackerCTProc BASE_HFit_TrackerCollectionSource,0
GO
EXEC proc_GenTrackerCTProc BASE_HFit_TrackerCotinine,0
GO
EXEC proc_GenTrackerCTProc BASE_HFit_TrackerDailySteps,0
GO
EXEC proc_GenTrackerCTProc BASE_HFit_TrackerDef_Item,0
GO
EXEC proc_GenTrackerCTProc BASE_HFit_TrackerDef_Tracker,0
GO
EXEC proc_GenTrackerCTProc BASE_HFit_TrackerDocument,0
GO
EXEC proc_GenTrackerCTProc BASE_HFit_TrackerFlexibility,0
GO
EXEC proc_GenTrackerCTProc BASE_HFit_TrackerFruits,0
GO
EXEC proc_GenTrackerCTProc BASE_HFit_TrackerHbA1c,0
GO
EXEC proc_GenTrackerCTProc BASE_HFit_TrackerHeight,0
GO
EXEC proc_GenTrackerCTProc BASE_HFit_TrackerHighFatFoods,0
GO
EXEC proc_GenTrackerCTProc BASE_HFit_TrackerHighSodiumFoods,0
GO
EXEC proc_GenTrackerCTProc BASE_HFit_TrackerInstance_Item,0
GO
EXEC proc_GenTrackerCTProc BASE_HFit_TrackerInstance_Tracker,0
GO
EXEC proc_GenTrackerCTProc BASE_HFit_TrackerMealPortions,0
GO
EXEC proc_GenTrackerCTProc BASE_HFit_TrackerMedicalCarePlan,0
GO
EXEC proc_GenTrackerCTProc BASE_HFit_TrackerPreventiveCare,0
GO
EXEC proc_GenTrackerCTProc BASE_HFit_TrackerRegularMeals,0
GO
EXEC proc_GenTrackerCTProc BASE_HFit_TrackerRestingHeartRate,0
GO
EXEC proc_GenTrackerCTProc BASE_HFit_TrackerShots,0
GO
EXEC proc_GenTrackerCTProc BASE_HFit_TrackerSitLess,0
GO
EXEC proc_GenTrackerCTProc BASE_HFit_TrackerSleepPlan,0
GO
EXEC proc_GenTrackerCTProc BASE_HFit_TrackerStrength,0
GO
EXEC proc_GenTrackerCTProc BASE_HFit_TrackerStress,0
GO
EXEC proc_GenTrackerCTProc BASE_HFit_TrackerStressManagement,0
GO
EXEC proc_GenTrackerCTProc BASE_HFit_TrackerSugaryDrinks,0
GO
EXEC proc_GenTrackerCTProc BASE_HFit_TrackerSugaryFoods,0
GO
EXEC proc_GenTrackerCTProc BASE_HFit_TrackerSummary,0
GO
EXEC proc_GenTrackerCTProc BASE_HFit_TrackerTests,0
GO
EXEC proc_GenTrackerCTProc BASE_HFit_TrackerTobaccoAttestation,0
GO
EXEC proc_GenTrackerCTProc BASE_HFit_TrackerTobaccoFree,0
GO
EXEC proc_GenTrackerCTProc BASE_HFit_TrackerVegetables,0
GO
EXEC proc_GenTrackerCTProc BASE_HFit_TrackerWater,0
GO
EXEC proc_GenTrackerCTProc BASE_HFit_TrackerWeight,0
GO
EXEC proc_GenTrackerCTProc BASE_HFit_TrackerWholeGrains,0
GO
EXEC proc_GenTrackerCTProc BASE_HFit_UserTracker,0
GO
EXEC proc_GenTrackerCTProc BASE_HFit_UserTrackerCategory,0
GO
EXEC proc_GenTrackerCTProc BASE_view_EDW_ScreeningsFromTrackers,0
GO
EXEC proc_GenTrackerCTProc BASE_view_EDW_TrackerCompositeDetails,0
GO
EXEC proc_GenTrackerCTProc BASE_view_EDW_TrackerMetadata,0
GO
EXEC proc_GenTrackerCTProc BASE_view_EDW_TrackerShots,0
GO
EXEC proc_GenTrackerCTProc BASE_view_EDW_TrackerTests,0
GO
EXEC proc_GenTrackerCTProc BASE_View_HFit_TrackerCategory_Joined,0
GO
EXEC proc_GenTrackerCTProc BASE_View_HFit_TrackerDocument_Joined,0
GO