
GO
-- Use KenticoCMS_Datamart_2
PRINT 'Executing RegenerateTrackerCTProcs.sql';
GO

/*
SELECT
       'EXEC proc_GenTrackerCTProc ' + table_name + ',0' + CHAR (10) + 'GO'
FROM INFORMATION_SCHEMA.tables
WHERE
      table_name LIKE 'BASE_HFit_Tracker%' 
	 AND table_name NOT LIKE '%_TrackerCategory' 
	 AND table_name NOT LIKE '%_TrackerDef_Item' 
	 AND table_name NOT LIKE '%_TrackerDocument' 
	 AND table_name NOT LIKE '%_TrackerSummary' 
	 AND table_name NOT LIKE '%_UserTracker';
*/

EXEC proc_GenTrackerCTProc BASE_HFIT_Tracker, 0;
GO
EXEC proc_GenTrackerCTProc BASE_HFit_TrackerBloodPressure, 0;
GO
EXEC proc_GenTrackerCTProc BASE_HFit_TrackerBloodSugarAndGlucose, 0;
GO
EXEC proc_GenTrackerCTProc BASE_HFit_TrackerBMI, 0;
GO
EXEC proc_GenTrackerCTProc BASE_HFit_TrackerBodyFat, 0;
GO
EXEC proc_GenTrackerCTProc BASE_HFit_TrackerBodyMeasurements, 0;
GO
EXEC proc_GenTrackerCTProc BASE_HFit_TrackerCardio, 0;
GO
--EXEC proc_GenTrackerCTProc BASE_HFit_TrackerCategory,0
--GO
EXEC proc_GenTrackerCTProc BASE_HFit_TrackerCholesterol, 0;
GO
EXEC proc_GenTrackerCTProc BASE_HFit_TrackerCollectionSource, 0;
GO
EXEC proc_GenTrackerCTProc BASE_HFit_TrackerCotinine, 0;
GO
EXEC proc_GenTrackerCTProc BASE_HFit_TrackerDailySteps, 0;
GO
--EXEC proc_GenTrackerCTProc BASE_HFit_TrackerDef_Item,0
--GO
EXEC proc_GenTrackerCTProc BASE_HFit_TrackerDef_Tracker, 0;
GO
--EXEC proc_GenTrackerCTProc BASE_HFit_TrackerDocument,0
--GO
EXEC proc_GenTrackerCTProc BASE_HFit_TrackerFlexibility, 0;
GO
EXEC proc_GenTrackerCTProc BASE_HFit_TrackerFruits, 0;
GO
EXEC proc_GenTrackerCTProc BASE_HFit_TrackerHbA1c, 0;
GO
EXEC proc_GenTrackerCTProc BASE_HFit_TrackerHeight, 0;
GO
EXEC proc_GenTrackerCTProc BASE_HFit_TrackerHighFatFoods, 0;
GO
EXEC proc_GenTrackerCTProc BASE_HFit_TrackerHighSodiumFoods, 0;
GO
EXEC proc_GenTrackerCTProc BASE_HFit_TrackerMealPortions, 0;
GO
EXEC proc_GenTrackerCTProc BASE_HFit_TrackerMedicalCarePlan, 0;
GO
EXEC proc_GenTrackerCTProc BASE_HFit_TrackerPreventiveCare, 0;
GO
EXEC proc_GenTrackerCTProc BASE_HFit_TrackerRegularMeals, 0;
GO
EXEC proc_GenTrackerCTProc BASE_HFit_TrackerRestingHeartRate, 0;
GO
EXEC proc_GenTrackerCTProc BASE_HFit_TrackerShots, 0;
GO
EXEC proc_GenTrackerCTProc BASE_HFit_TrackerSitLess, 0;
GO
EXEC proc_GenTrackerCTProc BASE_HFit_TrackerSleepPlan, 0;
GO
EXEC proc_GenTrackerCTProc BASE_HFit_TrackerStrength, 0;
GO
EXEC proc_GenTrackerCTProc BASE_HFit_TrackerStress, 0;
GO
EXEC proc_GenTrackerCTProc BASE_HFit_TrackerStressManagement, 0;
GO
EXEC proc_GenTrackerCTProc BASE_HFit_TrackerSugaryDrinks, 0;
GO
EXEC proc_GenTrackerCTProc BASE_HFit_TrackerSugaryFoods, 0;
GO
--EXEC proc_GenTrackerCTProc BASE_HFit_TrackerSummary,0
--GO
EXEC proc_GenTrackerCTProc BASE_HFit_TrackerTests, 0;
GO
EXEC proc_GenTrackerCTProc BASE_HFit_TrackerTobaccoAttestation, 0;
GO
EXEC proc_GenTrackerCTProc BASE_HFit_TrackerTobaccoFree, 0;
GO
EXEC proc_GenTrackerCTProc BASE_HFit_TrackerVegetables, 0;
GO
EXEC proc_GenTrackerCTProc BASE_HFit_TrackerWater, 0;
GO
EXEC proc_GenTrackerCTProc BASE_HFit_TrackerWeight, 0;
GO
EXEC proc_GenTrackerCTProc BASE_HFit_TrackerWholeGrains, 0;
GO
--EXEC proc_GenTrackerCTProc BASE_HFit_UserTracker,0
--GO

GO
PRINT 'Completed RegenerateTrackerCTProcs.sql';
GO
