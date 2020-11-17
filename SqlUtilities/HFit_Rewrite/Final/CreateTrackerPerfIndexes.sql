if not exists(select name from sys.indexes where name = 'PI_HFIT_Tracker_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFIT_Tracker_LastUpdate ON [HFIT_Tracker] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerBloodPressure_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerBloodPressure_LastUpdate ON [HFit_TrackerBloodPressure] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerBloodSugarAndGlucose_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerBloodSugarAndGlucose_LastUpdate ON [HFit_TrackerBloodSugarAndGlucose] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerBMI_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerBMI_LastUpdate ON [HFit_TrackerBMI] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerBodyFat_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerBodyFat_LastUpdate ON [HFit_TrackerBodyFat] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerBodyMeasurements_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerBodyMeasurements_LastUpdate ON [HFit_TrackerBodyMeasurements] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerCardio_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerCardio_LastUpdate ON [HFit_TrackerCardio] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerCategory_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerCategory_LastUpdate ON [HFit_TrackerCategory] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerCholesterol_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerCholesterol_LastUpdate ON [HFit_TrackerCholesterol] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerCollectionSource_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerCollectionSource_LastUpdate ON [HFit_TrackerCollectionSource] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerDailySteps_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerDailySteps_LastUpdate ON [HFit_TrackerDailySteps] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerDef_Item_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerDef_Item_LastUpdate ON [HFit_TrackerDef_Item] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerDef_Tracker_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerDef_Tracker_LastUpdate ON [HFit_TrackerDef_Tracker] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerDocument_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerDocument_LastUpdate ON [HFit_TrackerDocument] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerFlexibility_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerFlexibility_LastUpdate ON [HFit_TrackerFlexibility] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerFruits_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerFruits_LastUpdate ON [HFit_TrackerFruits] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerHbA1c_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerHbA1c_LastUpdate ON [HFit_TrackerHbA1c] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerHeight_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerHeight_LastUpdate ON [HFit_TrackerHeight] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerHighFatFoods_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerHighFatFoods_LastUpdate ON [HFit_TrackerHighFatFoods] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerHighSodiumFoods_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerHighSodiumFoods_LastUpdate ON [HFit_TrackerHighSodiumFoods] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerInstance_Item_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerInstance_Item_LastUpdate ON [HFit_TrackerInstance_Item] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerInstance_Tracker_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerInstance_Tracker_LastUpdate ON [HFit_TrackerInstance_Tracker] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerMealPortions_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerMealPortions_LastUpdate ON [HFit_TrackerMealPortions] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerMedicalCarePlan_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerMedicalCarePlan_LastUpdate ON [HFit_TrackerMedicalCarePlan] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerRegularMeals_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerRegularMeals_LastUpdate ON [HFit_TrackerRegularMeals] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerRestingHeartRate_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerRestingHeartRate_LastUpdate ON [HFit_TrackerRestingHeartRate] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerShots_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerShots_LastUpdate ON [HFit_TrackerShots] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerSitLess_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerSitLess_LastUpdate ON [HFit_TrackerSitLess] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerSleepPlan_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerSleepPlan_LastUpdate ON [HFit_TrackerSleepPlan] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerStrength_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerStrength_LastUpdate ON [HFit_TrackerStrength] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerStress_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerStress_LastUpdate ON [HFit_TrackerStress] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerStressManagement_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerStressManagement_LastUpdate ON [HFit_TrackerStressManagement] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerSugaryDrinks_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerSugaryDrinks_LastUpdate ON [HFit_TrackerSugaryDrinks] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerSugaryFoods_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerSugaryFoods_LastUpdate ON [HFit_TrackerSugaryFoods] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerSummary_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerSummary_LastUpdate ON [HFit_TrackerSummary] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerTests_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerTests_LastUpdate ON [HFit_TrackerTests] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerTobaccoFree_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerTobaccoFree_LastUpdate ON [HFit_TrackerTobaccoFree] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerVegetables_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerVegetables_LastUpdate ON [HFit_TrackerVegetables] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerWater_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerWater_LastUpdate ON [HFit_TrackerWater] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerWeight_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerWeight_LastUpdate ON [HFit_TrackerWeight] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerWholeGrains_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerWholeGrains_LastUpdate ON [HFit_TrackerWholeGrains] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go


