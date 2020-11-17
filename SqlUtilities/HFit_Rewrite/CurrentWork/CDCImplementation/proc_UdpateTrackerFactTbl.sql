
SET TRANSACTION ISOLATION LEVEL SNAPSHOT;

-- select count(*) from FACT_TrackerData
USE KenticoCMS_DataMart;
GO

SET NOCOUNT ON;
PRINT GETDATE () ;
GO
PrintImmediate '*****    proc_CT_DIM_HFit_TrackerBloodSugarAndGlucose';
CHECKPOINT;
EXEC proc_QuickRowCOunt BASE_HFit_TrackerBloodSugarAndGlucose;
EXEC proc_CT_DIM_HFit_TrackerBloodSugarAndGlucose;
GO
PRINT GETDATE () ;
GO

PrintImmediate '*****    proc_CT_DIM_HFit_TrackerBMI';
CHECKPOINT;
EXEC proc_QuickRowCOunt BASE_HFit_TrackerBMI;
EXEC proc_CT_DIM_HFit_TrackerBMI;
GO
PRINT GETDATE () ;
GO

PrintImmediate '*****    proc_CT_DIM_HFit_TrackerBodyFat';
CHECKPOINT;
EXEC proc_QuickRowCount BASE_HFit_TrackerBodyFat;
GO
EXEC proc_CT_DIM_HFit_TrackerBodyFat;
GO
PRINT GETDATE () ;
GO

PrintImmediate '*****    proc_CT_DIM_HFit_TrackerBodyMeasurements';
CHECKPOINT;
EXEC proc_QuickRowCount BASE_HFit_TrackerBodyMeasurements;
GO
EXEC proc_CT_DIM_HFit_TrackerBodyMeasurements;
GO
PRINT GETDATE () ;
GO

EXEC proc_QuickRowCount BASE_HFit_TrackerCardio;
GO
PrintImmediate '*****    proc_CT_DIM_HFit_TrackerCardio';
CHECKPOINT;
EXEC proc_CT_DIM_HFit_TrackerCardio;
GO
PRINT GETDATE () ;
GO

EXEC proc_QuickRowCount BASE_HFit_TrackerCholesterol;
GO
PrintImmediate '*****    proc_CT_DIM_HFit_TrackerCholesterol';
CHECKPOINT;
EXEC proc_CT_DIM_HFit_TrackerCholesterol;
GO
PRINT GETDATE () ;
GO

EXEC proc_QuickRowCount BASE_HFit_TrackerCollectionSource;
GO
PrintImmediate '*****    proc_CT_DIM_HFit_TrackerCollectionSource';
CHECKPOINT;
EXEC proc_CT_DIM_HFit_TrackerCollectionSource;
GO
PRINT GETDATE () ;
GO

EXEC proc_QuickRowCount BASE_HFit_TrackerCotinine;
GO
PrintImmediate '*****    proc_CT_DIM_HFit_TrackerCotinine';
CHECKPOINT;
EXEC proc_CT_DIM_HFit_TrackerCotinine;
GO
PRINT GETDATE () ;
GO

EXEC proc_QuickRowCount BASE_HFit_TrackerDailySteps;
GO
PrintImmediate '*****    proc_CT_DIM_HFit_TrackerDailySteps';
CHECKPOINT;
EXEC proc_CT_DIM_HFit_TrackerDailySteps;
GO
PRINT GETDATE () ;
GO

EXEC proc_QuickRowCount BASE_HFit_TrackerFlexibility;
GO
PrintImmediate '*****    proc_CT_DIM_HFit_TrackerFlexibility';
CHECKPOINT;
EXEC proc_CT_DIM_HFit_TrackerFlexibility;
GO
PRINT GETDATE () ;
GO

EXEC proc_QuickRowCount BASE_HFit_TrackerFruits;
GO
PrintImmediate '*****    proc_CT_DIM_HFit_TrackerFruits';
CHECKPOINT;
EXEC proc_CT_DIM_HFit_TrackerFruits;
GO
PRINT GETDATE () ;
GO

EXEC proc_QuickRowCount BASE_HFit_TrackerHbA1c;
GO
PrintImmediate '*****    proc_CT_DIM_HFit_TrackerHbA1c';
CHECKPOINT;
EXEC proc_CT_DIM_HFit_TrackerHbA1c;
GO
PRINT GETDATE () ;
GO

EXEC proc_QuickRowCount BASE_HFit_TrackerHeight;
GO
PrintImmediate '*****    proc_CT_DIM_HFit_TrackerHeight';
CHECKPOINT;
EXEC proc_CT_DIM_HFit_TrackerHeight;
GO
PRINT GETDATE () ;
GO

EXEC proc_QuickRowCount BASE_HFit_TrackerHighFatFoods;
GO
PrintImmediate '*****    proc_CT_DIM_HFit_TrackerHighFatFoods';
CHECKPOINT;
EXEC proc_CT_DIM_HFit_TrackerHighFatFoods;
GO
PRINT GETDATE () ;
GO

EXEC proc_QuickRowCount BASE_HFit_TrackerHighSodiumFoods;
GO
PrintImmediate '*****    proc_CT_DIM_HFit_TrackerHighSodiumFoods';
CHECKPOINT;
EXEC proc_CT_DIM_HFit_TrackerHighSodiumFoods;
GO
PRINT GETDATE () ;
GO

EXEC proc_QuickRowCount BASE_HFit_TrackerInstance_Tracker;
GO
PrintImmediate '*****    proc_CT_DIM_HFit_TrackerInstance_Tracker';
CHECKPOINT;
EXEC proc_CT_DIM_HFit_TrackerInstance_Tracker;
GO
PRINT GETDATE () ;
GO

EXEC proc_QuickRowCount BASE_HFit_TrackerMealPortions;
GO
PrintImmediate '*****    proc_CT_DIM_HFit_TrackerMealPortions';
CHECKPOINT;
EXEC proc_CT_DIM_HFit_TrackerMealPortions;
GO
PRINT GETDATE () ;
GO

EXEC proc_QuickRowCount BASE_HFit_TrackerMedicalCarePlan;
GO
PrintImmediate '*****    proc_CT_DIM_HFit_TrackerMedicalCarePlan';
CHECKPOINT;
EXEC proc_CT_DIM_HFit_TrackerMedicalCarePlan;
GO
PRINT GETDATE () ;
GO

EXEC proc_QuickRowCount BASE_HFit_TrackerPreventiveCare;
GO
PrintImmediate '*****    proc_CT_DIM_HFit_TrackerPreventiveCare';
CHECKPOINT;
EXEC proc_CT_DIM_HFit_TrackerPreventiveCare;
GO
PRINT GETDATE () ;
GO

EXEC proc_QuickRowCount BASE_HFit_TrackerRegularMeals;
GO
PrintImmediate '*****    proc_CT_DIM_HFit_TrackerRegularMeals';
CHECKPOINT;
EXEC proc_CT_DIM_HFit_TrackerRegularMeals;
GO
PRINT GETDATE () ;
GO

EXEC proc_QuickRowCount BASE_HFit_TrackerRestingHeartRate;
GO
PrintImmediate '*****    proc_CT_DIM_HFit_TrackerRestingHeartRate';
CHECKPOINT;
EXEC proc_CT_DIM_HFit_TrackerRestingHeartRate;
GO
PRINT GETDATE () ;
GO

EXEC proc_QuickRowCount BASE_HFit_TrackerShots;
GO
PrintImmediate '*****    proc_CT_DIM_HFit_TrackerShots';
CHECKPOINT;
EXEC proc_CT_DIM_HFit_TrackerShots;
GO
PRINT GETDATE () ;
GO

EXEC proc_QuickRowCount BASE_HFit_TrackerSitLess;
GO
PrintImmediate '*****    proc_CT_DIM_HFit_TrackerSitLess';
CHECKPOINT;
EXEC proc_CT_DIM_HFit_TrackerSitLess;
GO
PRINT GETDATE () ;
GO

EXEC proc_QuickRowCount BASE_HFit_TrackerSleepPlan;
GO
PrintImmediate '*****    proc_CT_DIM_HFit_TrackerSleepPlan';
CHECKPOINT;
EXEC proc_CT_DIM_HFit_TrackerSleepPlan;
GO
PRINT GETDATE () ;
GO

EXEC proc_QuickRowCount BASE_HFit_TrackerStrength;
GO
PrintImmediate '*****    proc_CT_DIM_HFit_TrackerStrength';
CHECKPOINT;
EXEC proc_CT_DIM_HFit_TrackerStrength;
GO
PRINT GETDATE () ;
GO

EXEC proc_QuickRowCount BASE_HFit_TrackerStress;
GO
PrintImmediate '*****    proc_CT_DIM_HFit_TrackerStress';
CHECKPOINT;
EXEC proc_CT_DIM_HFit_TrackerStress;
GO
PRINT GETDATE () ;
GO

EXEC proc_QuickRowCount BASE_HFit_TrackerStressManagement;
GO
PrintImmediate '*****    proc_CT_DIM_HFit_TrackerStressManagement';
CHECKPOINT;
EXEC proc_CT_DIM_HFit_TrackerStressManagement;
GO
PRINT GETDATE () ;
GO

EXEC proc_QuickRowCount BASE_HFit_TrackerSugaryDrinks;
GO
PrintImmediate '*****    proc_CT_DIM_HFit_TrackerSugaryDrinks';
CHECKPOINT;
EXEC proc_CT_DIM_HFit_TrackerSugaryDrinks;
GO
PRINT GETDATE () ;
GO

EXEC proc_QuickRowCount BASE_HFit_TrackerSugaryFoods;
GO
PrintImmediate '*****    proc_CT_DIM_HFit_TrackerSugaryFoods';
CHECKPOINT;
EXEC proc_CT_DIM_HFit_TrackerSugaryFoods;
GO
PRINT GETDATE () ;
GO

EXEC proc_QuickRowCount BASE_HFit_TrackerTests;
GO
PrintImmediate '*****    proc_CT_DIM_HFit_TrackerTests';
CHECKPOINT;
EXEC proc_CT_DIM_HFit_TrackerTests;
GO
PRINT GETDATE () ;
GO

EXEC proc_QuickRowCount BASE_HFit_TrackerTobaccoAttestation;
GO
PrintImmediate '*****    proc_CT_DIM_HFit_TrackerTobaccoAttestation';
CHECKPOINT;
EXEC proc_CT_DIM_HFit_TrackerTobaccoAttestation;
GO
PRINT GETDATE () ;
GO

EXEC proc_QuickRowCount BASE_HFit_TrackerTobaccoFree;
GO
PrintImmediate '*****    proc_CT_DIM_HFit_TrackerTobaccoFree';
CHECKPOINT;
EXEC proc_CT_DIM_HFit_TrackerTobaccoFree;
GO
PRINT GETDATE () ;
GO

EXEC proc_QuickRowCount BASE_HFit_TrackerVegetables;
GO
PrintImmediate '*****    proc_CT_DIM_HFit_TrackerVegetables';
CHECKPOINT;
EXEC proc_CT_DIM_HFit_TrackerVegetables;
GO
PRINT GETDATE () ;
GO

EXEC proc_QuickRowCount BASE_HFit_TrackerWater;
GO
PrintImmediate '*****    proc_CT_DIM_HFit_TrackerWater';
CHECKPOINT;
EXEC proc_CT_DIM_HFit_TrackerWater;
GO
PRINT GETDATE () ;
GO

EXEC proc_QuickRowCount BASE_HFit_TrackerWeight;
GO
PrintImmediate '*****    proc_CT_DIM_HFit_TrackerWeight';
CHECKPOINT;
EXEC proc_CT_DIM_HFit_TrackerWeight;
GO
PRINT GETDATE () ;
GO

EXEC proc_QuickRowCount BASE_HFit_TrackerWholeGrains;
GO
PrintImmediate '*****    proc_CT_DIM_HFit_TrackerWholeGrains';
CHECKPOINT;
EXEC proc_CT_DIM_HFit_TrackerWholeGrains;
GO
PRINT GETDATE () ;
GO

EXEC proc_QuickRowCount BASE_HFit_TrackerBloodPressure;
GO
PrintImmediate '*****    proc_CT_DIM_HFit_TrackerBloodPressure';
CHECKPOINT;
EXEC proc_CT_DIM_HFit_TrackerBloodPressure;
GO
CHECKPOINT;
GO
PRINT GETDATE () ;
GO
SET NOCOUNT OFF;

