/*
select 'Update ' + table_name +  ' set HashCode = ''NA'' where ItemID in (Select top 10000 ItemID from ' + table_name  + ' order by ItemID desc )' + char(10 order by ItemID desc ) + 'GO'
from INFORMATION_SCHEMA.TABLES where table_name like '%BASE_%'
and table_name like '%Tracker%'
and table_name not like '%HIST'
and table_name not like '%_DEL'
and table_name not like '%ONLY'
*/
Update BASE_HFit_TrackerDailySteps set HashCode = 'NA' where ItemID in (Select top 10000 ItemID from BASE_HFit_TrackerDailySteps order by ItemID desc )
GO
Update BASE_HFit_TrackerWeight set HashCode = 'NA' where ItemID in (Select top 10000 ItemID from BASE_HFit_TrackerWeight order by ItemID desc )
GO
Update BASE_HFit_TrackerHighSodiumFoods set HashCode = 'NA' where ItemID in (Select top 10000 ItemID from BASE_HFit_TrackerHighSodiumFoods order by ItemID desc )
GO
Update BASE_HFit_TrackerShots set HashCode = 'NA' where ItemID in (Select top 10000 ItemID from BASE_HFit_TrackerShots order by ItemID desc )
GO
Update BASE_HFit_TrackerBodyFat set HashCode = 'NA' where ItemID in (Select top 10000 ItemID from BASE_HFit_TrackerBodyFat order by ItemID desc )
GO
Update BASE_HFit_TrackerSugaryFoods set HashCode = 'NA' where ItemID in (Select top 10000 ItemID from BASE_HFit_TrackerSugaryFoods order by ItemID desc )
GO
Update BASE_HFit_TrackerDef_Tracker set HashCode = 'NA' where ItemID in (Select top 10000 ItemID from BASE_HFit_TrackerDef_Tracker order by ItemID desc )
GO
Update BASE_HFit_TrackerWholeGrains set HashCode = 'NA' where ItemID in (Select top 10000 ItemID from BASE_HFit_TrackerWholeGrains order by ItemID desc )
GO
Update BASE_HFit_TrackerInstance_Tracker set HashCode = 'NA' where ItemID in (Select top 10000 ItemID from BASE_HFit_TrackerInstance_Tracker order by ItemID desc )
GO
Update BASE_HFit_TrackerSitLess set HashCode = 'NA' where ItemID in (Select top 10000 ItemID from BASE_HFit_TrackerSitLess order by ItemID desc )
GO
Update BASE_HFit_TrackerBodyMeasurements set HashCode = 'NA' where ItemID in (Select top 10000 ItemID from BASE_HFit_TrackerBodyMeasurements order by ItemID desc )
GO
Update BASE_HFit_TrackerTests set HashCode = 'NA' where ItemID in (Select top 10000 ItemID from BASE_HFit_TrackerTests order by ItemID desc )
GO
Update BASE_HFit_TrackerFlexibility set HashCode = 'NA' where ItemID in (Select top 10000 ItemID from BASE_HFit_TrackerFlexibility order by ItemID desc )
GO
Update BASE_HFit_UserTracker set HashCode = 'NA' where ItemID in (Select top 10000 ItemID from BASE_HFit_UserTracker order by ItemID desc )
GO
Update BASE_HFit_TrackerMealPortions set HashCode = 'NA' where ItemID in (Select top 10000 ItemID from BASE_HFit_TrackerMealPortions order by ItemID desc )
GO
Update BASE_HFit_TrackerSleepPlan set HashCode = 'NA' where ItemID in (Select top 10000 ItemID from BASE_HFit_TrackerSleepPlan order by ItemID desc )
GO
Update BASE_HFit_TrackerCardio set HashCode = 'NA' where ItemID in (Select top 10000 ItemID from BASE_HFit_TrackerCardio order by ItemID desc )
GO
Update BASE_HFit_TrackerTobaccoAttestation set HashCode = 'NA' where ItemID in (Select top 10000 ItemID from BASE_HFit_TrackerTobaccoAttestation order by ItemID desc )
GO
Update BASE_HFit_TrackerFruits set HashCode = 'NA' where ItemID in (Select top 10000 ItemID from BASE_HFit_TrackerFruits order by ItemID desc )
GO
Update BASE_HFit_TrackerMedicalCarePlan set HashCode = 'NA' where ItemID in (Select top 10000 ItemID from BASE_HFit_TrackerMedicalCarePlan order by ItemID desc )
GO
Update BASE_HFit_TrackerStrength set HashCode = 'NA' where ItemID in (Select top 10000 ItemID from BASE_HFit_TrackerStrength order by ItemID desc )
GO
Update BASE_HFIT_Tracker set HashCode = 'NA' where ItemID in (Select top 10000 ItemID from BASE_HFIT_Tracker order by ItemID desc )
GO
Update BASE_HFit_TrackerCholesterol set HashCode = 'NA' where ItemID in (Select top 10000 ItemID from BASE_HFit_TrackerCholesterol order by ItemID desc )
GO
Update BASE_HFit_LKP_TrackerVendor set HashCode = 'NA' where ItemID in (Select top 10000 ItemID from BASE_HFit_LKP_TrackerVendor order by ItemID desc )
GO
Update BASE_HFit_TrackerTobaccoFree set HashCode = 'NA' where ItemID in (Select top 10000 ItemID from BASE_HFit_TrackerTobaccoFree order by ItemID desc )
GO
Update BASE_HFit_TrackerHbA1c set HashCode = 'NA' where ItemID in (Select top 10000 ItemID from BASE_HFit_TrackerHbA1c order by ItemID desc )
GO
Update BASE_HFit_TrackerPreventiveCare set HashCode = 'NA' where ItemID in (Select top 10000 ItemID from BASE_HFit_TrackerPreventiveCare order by ItemID desc )
GO
Update BASE_HFit_TrackerBloodPressure set HashCode = 'NA' where ItemID in (Select top 10000 ItemID from BASE_HFit_TrackerBloodPressure order by ItemID desc )
GO
Update BASE_HFit_TrackerStress set HashCode = 'NA' where ItemID in (Select top 10000 ItemID from BASE_HFit_TrackerStress order by ItemID desc )
GO
Update BASE_HFit_TrackerCollectionSource set HashCode = 'NA' where ItemID in (Select top 10000 ItemID from BASE_HFit_TrackerCollectionSource order by ItemID desc )
GO
Update BASE_HFit_TrackerVegetables set HashCode = 'NA' where ItemID in (Select top 10000 ItemID from BASE_HFit_TrackerVegetables order by ItemID desc )
GO
Update BASE_HFit_TrackerHeight set HashCode = 'NA' where ItemID in (Select top 10000 ItemID from BASE_HFit_TrackerHeight order by ItemID desc )
GO
Update BASE_HFit_TrackerRegularMeals set HashCode = 'NA' where ItemID in (Select top 10000 ItemID from BASE_HFit_TrackerRegularMeals order by ItemID desc )
GO
Update BASE_HFit_TrackerBloodSugarAndGlucose set HashCode = 'NA' where ItemID in (Select top 10000 ItemID from BASE_HFit_TrackerBloodSugarAndGlucose order by ItemID desc )
GO
Update BASE_HFit_TrackerStressManagement set HashCode = 'NA' where ItemID in (Select top 10000 ItemID from BASE_HFit_TrackerStressManagement order by ItemID desc )
GO
Update BASE_HFit_TrackerCotinine set HashCode = 'NA' where ItemID in (Select top 10000 ItemID from BASE_HFit_TrackerCotinine order by ItemID desc )
GO
Update BASE_HFit_TrackerWater set HashCode = 'NA' where ItemID in (Select top 10000 ItemID from BASE_HFit_TrackerWater order by ItemID desc )
GO
Update BASE_HFit_TrackerHighFatFoods set HashCode = 'NA' where ItemID in (Select top 10000 ItemID from BASE_HFit_TrackerHighFatFoods order by ItemID desc )
GO
Update BASE_HFit_TrackerRestingHeartRate set HashCode = 'NA' where ItemID in (Select top 10000 ItemID from BASE_HFit_TrackerRestingHeartRate order by ItemID desc )
GO
Update BASE_HFit_TrackerBMI set HashCode = 'NA' where ItemID in (Select top 10000 ItemID from BASE_HFit_TrackerBMI order by ItemID desc )
GO
Update BASE_HFit_TrackerSugaryDrinks set HashCode = 'NA' where ItemID in (Select top 10000 ItemID from BASE_HFit_TrackerSugaryDrinks order by ItemID desc )
GO