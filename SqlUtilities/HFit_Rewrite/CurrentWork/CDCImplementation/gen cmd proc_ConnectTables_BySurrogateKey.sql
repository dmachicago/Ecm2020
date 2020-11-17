

/*
use KenticoCMS_Datamart_x

select table_name, 'GO' +char(10) + 'Print ''Adding User RELS: '+table_name+'''' + char(10) + 'GO' +char(10)+ 'exec proc_ConnectTables_BySurrogateKey @SurrogateKey = "SurrogateKey_cms_user", @ParentTable = "BASE_CMS_User", @ChildTable  = "'+table_name+'", @PreviewOnly = 0 ' + char(10) + 'GO' +char(10) +
'update '+table_name+' set SurrogateKey_cms_user = (select SurrogateKey_cms_user from BASE_CMS_User B 
    where '+table_name+'.Userid = B.UserID and '+table_name+'.DBNAME = B.DBNAME) '  as UPDT_CMD
from information_schema.tables 
where table_name like '%_TRACKER%'
and table_name not like '%_DEL'
and table_name not like '%_CTVerHIST'
and table_name not like '%_NoNulls'
and table_name not like '%_CT'
and table_name not like '%_ONLY'
and table_name not like '%_TEMP_%'
and table_name not like '%_view_%'
and table_name not like '%_LKP_%'
and table_name not like 'view_%'
and table_name not like 'base_view_%'
and table_name not like 'FACT_TrackerData'
and table_name not like '%TestData'

CREATE PROCEDURE proc_ConnectTables_BySurrogateKey (
       @SurrogateKey AS NVARCHAR (250) 
     , @ParentTable  AS NVARCHAR (250) 
     , @ChildTable  AS NVARCHAR (250) 
     , @PreviewOnly AS BIT = 0

*/
GO

Print 'Adding User RELS: BASE_HFit_TrackerFruits'
GO
exec proc_ConnectTables_BySurrogateKey @SurrogateKey = "SurrogateKey_cms_user", @ParentTable = "BASE_CMS_User", @ChildTable  = "BASE_HFit_TrackerFruits", @PreviewOnly = 0 
GO
update BASE_HFit_TrackerFruits set SurrogateKey_cms_user = (select SurrogateKey_cms_user from BASE_CMS_User B 
    where BASE_HFit_TrackerFruits.Userid = B.UserID and BASE_HFit_TrackerFruits.DBNAME = B.DBNAME) 
GO
Print 'Adding User RELS: BASE_HFit_TrackerTobaccoFree'
GO
exec proc_ConnectTables_BySurrogateKey @SurrogateKey = "SurrogateKey_cms_user", @ParentTable = "BASE_CMS_User", @ChildTable  = "BASE_HFit_TrackerTobaccoFree", @PreviewOnly = 0 
GO
update BASE_HFit_TrackerTobaccoFree set SurrogateKey_cms_user = (select SurrogateKey_cms_user from BASE_CMS_User B 
    where BASE_HFit_TrackerTobaccoFree.Userid = B.UserID and BASE_HFit_TrackerTobaccoFree.DBNAME = B.DBNAME) 
GO
Print 'Adding User RELS: TEMP_EDW_Tracker_DATA'
GO
exec proc_ConnectTables_BySurrogateKey @SurrogateKey = "SurrogateKey_cms_user", @ParentTable = "BASE_CMS_User", @ChildTable  = "TEMP_EDW_Tracker_DATA", @PreviewOnly = 0 
GO
update TEMP_EDW_Tracker_DATA set SurrogateKey_cms_user = (select SurrogateKey_cms_user from BASE_CMS_User B 
    where TEMP_EDW_Tracker_DATA.Userid = B.UserID and TEMP_EDW_Tracker_DATA.DBNAME = B.DBNAME) 
GO
Print 'Adding User RELS: BASE_HFit_TrackerStress'
GO
exec proc_ConnectTables_BySurrogateKey @SurrogateKey = "SurrogateKey_cms_user", @ParentTable = "BASE_CMS_User", @ChildTable  = "BASE_HFit_TrackerStress", @PreviewOnly = 0 
GO
update BASE_HFit_TrackerStress set SurrogateKey_cms_user = (select SurrogateKey_cms_user from BASE_CMS_User B 
    where BASE_HFit_TrackerStress.Userid = B.UserID and BASE_HFit_TrackerStress.DBNAME = B.DBNAME) 
GO
Print 'Adding User RELS: BASE_HFit_TrackerBloodPressure'
GO
exec proc_ConnectTables_BySurrogateKey @SurrogateKey = "SurrogateKey_cms_user", @ParentTable = "BASE_CMS_User", @ChildTable  = "BASE_HFit_TrackerBloodPressure", @PreviewOnly = 0 
GO
update BASE_HFit_TrackerBloodPressure set SurrogateKey_cms_user = (select SurrogateKey_cms_user from BASE_CMS_User B 
    where BASE_HFit_TrackerBloodPressure.Userid = B.UserID and BASE_HFit_TrackerBloodPressure.DBNAME = B.DBNAME) 
GO
Print 'Adding User RELS: BASE_HFit_TrackerCollectionSource'
GO
exec proc_ConnectTables_BySurrogateKey @SurrogateKey = "SurrogateKey_cms_user", @ParentTable = "BASE_CMS_User", @ChildTable  = "BASE_HFit_TrackerCollectionSource", @PreviewOnly = 0 
GO
update BASE_HFit_TrackerCollectionSource set SurrogateKey_cms_user = (select SurrogateKey_cms_user from BASE_CMS_User B 
    where BASE_HFit_TrackerCollectionSource.Userid = B.UserID and BASE_HFit_TrackerCollectionSource.DBNAME = B.DBNAME) 
GO
Print 'Adding User RELS: BASE_HFit_TrackerPreventiveCare'
GO
exec proc_ConnectTables_BySurrogateKey @SurrogateKey = "SurrogateKey_cms_user", @ParentTable = "BASE_CMS_User", @ChildTable  = "BASE_HFit_TrackerPreventiveCare", @PreviewOnly = 0 
GO
update BASE_HFit_TrackerPreventiveCare set SurrogateKey_cms_user = (select SurrogateKey_cms_user from BASE_CMS_User B 
    where BASE_HFit_TrackerPreventiveCare.Userid = B.UserID and BASE_HFit_TrackerPreventiveCare.DBNAME = B.DBNAME) 
GO
Print 'Adding User RELS: BASE_HFit_TrackerHbA1c'
GO
exec proc_ConnectTables_BySurrogateKey @SurrogateKey = "SurrogateKey_cms_user", @ParentTable = "BASE_CMS_User", @ChildTable  = "BASE_HFit_TrackerHbA1c", @PreviewOnly = 0 
GO
update BASE_HFit_TrackerHbA1c set SurrogateKey_cms_user = (select SurrogateKey_cms_user from BASE_CMS_User B 
    where BASE_HFit_TrackerHbA1c.Userid = B.UserID and BASE_HFit_TrackerHbA1c.DBNAME = B.DBNAME) 
GO
Print 'Adding User RELS: BASE_HFit_TrackerVegetables'
GO
exec proc_ConnectTables_BySurrogateKey @SurrogateKey = "SurrogateKey_cms_user", @ParentTable = "BASE_CMS_User", @ChildTable  = "BASE_HFit_TrackerVegetables", @PreviewOnly = 0 
GO
update BASE_HFit_TrackerVegetables set SurrogateKey_cms_user = (select SurrogateKey_cms_user from BASE_CMS_User B 
    where BASE_HFit_TrackerVegetables.Userid = B.UserID and BASE_HFit_TrackerVegetables.DBNAME = B.DBNAME) 
GO
Print 'Adding User RELS: BASE_HFit_TrackerStressManagement'
GO
exec proc_ConnectTables_BySurrogateKey @SurrogateKey = "SurrogateKey_cms_user", @ParentTable = "BASE_CMS_User", @ChildTable  = "BASE_HFit_TrackerStressManagement", @PreviewOnly = 0 
GO
update BASE_HFit_TrackerStressManagement set SurrogateKey_cms_user = (select SurrogateKey_cms_user from BASE_CMS_User B 
    where BASE_HFit_TrackerStressManagement.Userid = B.UserID and BASE_HFit_TrackerStressManagement.DBNAME = B.DBNAME) 
GO
Print 'Adding User RELS: BASE_HFit_TrackerBloodSugarAndGlucose'
GO
exec proc_ConnectTables_BySurrogateKey @SurrogateKey = "SurrogateKey_cms_user", @ParentTable = "BASE_CMS_User", @ChildTable  = "BASE_HFit_TrackerBloodSugarAndGlucose", @PreviewOnly = 0 
GO
update BASE_HFit_TrackerBloodSugarAndGlucose set SurrogateKey_cms_user = (select SurrogateKey_cms_user from BASE_CMS_User B 
    where BASE_HFit_TrackerBloodSugarAndGlucose.Userid = B.UserID and BASE_HFit_TrackerBloodSugarAndGlucose.DBNAME = B.DBNAME) 
GO
Print 'Adding User RELS: BASE_HFit_TrackerCotinine'
GO
exec proc_ConnectTables_BySurrogateKey @SurrogateKey = "SurrogateKey_cms_user", @ParentTable = "BASE_CMS_User", @ChildTable  = "BASE_HFit_TrackerCotinine", @PreviewOnly = 0 
GO
update BASE_HFit_TrackerCotinine set SurrogateKey_cms_user = (select SurrogateKey_cms_user from BASE_CMS_User B 
    where BASE_HFit_TrackerCotinine.Userid = B.UserID and BASE_HFit_TrackerCotinine.DBNAME = B.DBNAME) 
GO
Print 'Adding User RELS: BASE_HFit_TrackerHeight'
GO
exec proc_ConnectTables_BySurrogateKey @SurrogateKey = "SurrogateKey_cms_user", @ParentTable = "BASE_CMS_User", @ChildTable  = "BASE_HFit_TrackerHeight", @PreviewOnly = 0 
GO
update BASE_HFit_TrackerHeight set SurrogateKey_cms_user = (select SurrogateKey_cms_user from BASE_CMS_User B 
    where BASE_HFit_TrackerHeight.Userid = B.UserID and BASE_HFit_TrackerHeight.DBNAME = B.DBNAME) 
GO
Print 'Adding User RELS: BASE_HFit_TrackerRegularMeals'
GO
exec proc_ConnectTables_BySurrogateKey @SurrogateKey = "SurrogateKey_cms_user", @ParentTable = "BASE_CMS_User", @ChildTable  = "BASE_HFit_TrackerRegularMeals", @PreviewOnly = 0 
GO
update BASE_HFit_TrackerRegularMeals set SurrogateKey_cms_user = (select SurrogateKey_cms_user from BASE_CMS_User B 
    where BASE_HFit_TrackerRegularMeals.Userid = B.UserID and BASE_HFit_TrackerRegularMeals.DBNAME = B.DBNAME) 
GO
Print 'Adding User RELS: BASE_HFit_TrackerBMI'
GO
exec proc_ConnectTables_BySurrogateKey @SurrogateKey = "SurrogateKey_cms_user", @ParentTable = "BASE_CMS_User", @ChildTable  = "BASE_HFit_TrackerBMI", @PreviewOnly = 0 
GO
update BASE_HFit_TrackerBMI set SurrogateKey_cms_user = (select SurrogateKey_cms_user from BASE_CMS_User B 
    where BASE_HFit_TrackerBMI.Userid = B.UserID and BASE_HFit_TrackerBMI.DBNAME = B.DBNAME) 
GO
Print 'Adding User RELS: BASE_HFit_TrackerWater'
GO
exec proc_ConnectTables_BySurrogateKey @SurrogateKey = "SurrogateKey_cms_user", @ParentTable = "BASE_CMS_User", @ChildTable  = "BASE_HFit_TrackerWater", @PreviewOnly = 0 
GO
update BASE_HFit_TrackerWater set SurrogateKey_cms_user = (select SurrogateKey_cms_user from BASE_CMS_User B 
    where BASE_HFit_TrackerWater.Userid = B.UserID and BASE_HFit_TrackerWater.DBNAME = B.DBNAME) 
GO
Print 'Adding User RELS: BASE_HFit_UserTracker'
GO
exec proc_ConnectTables_BySurrogateKey @SurrogateKey = "SurrogateKey_cms_user", @ParentTable = "BASE_CMS_User", @ChildTable  = "BASE_HFit_UserTracker", @PreviewOnly = 0 
GO
update BASE_HFit_UserTracker set SurrogateKey_cms_user = (select SurrogateKey_cms_user from BASE_CMS_User B 
    where BASE_HFit_UserTracker.Userid = B.UserID and BASE_HFit_UserTracker.DBNAME = B.DBNAME) 
GO
Print 'Adding User RELS: BASE_HFit_TrackerSugaryDrinks'
GO
exec proc_ConnectTables_BySurrogateKey @SurrogateKey = "SurrogateKey_cms_user", @ParentTable = "BASE_CMS_User", @ChildTable  = "BASE_HFit_TrackerSugaryDrinks", @PreviewOnly = 0 
GO
update BASE_HFit_TrackerSugaryDrinks set SurrogateKey_cms_user = (select SurrogateKey_cms_user from BASE_CMS_User B 
    where BASE_HFit_TrackerSugaryDrinks.Userid = B.UserID and BASE_HFit_TrackerSugaryDrinks.DBNAME = B.DBNAME) 
GO
Print 'Adding User RELS: BASE_HFit_TrackerDailySteps'
GO
exec proc_ConnectTables_BySurrogateKey @SurrogateKey = "SurrogateKey_cms_user", @ParentTable = "BASE_CMS_User", @ChildTable  = "BASE_HFit_TrackerDailySteps", @PreviewOnly = 0 
GO
update BASE_HFit_TrackerDailySteps set SurrogateKey_cms_user = (select SurrogateKey_cms_user from BASE_CMS_User B 
    where BASE_HFit_TrackerDailySteps.Userid = B.UserID and BASE_HFit_TrackerDailySteps.DBNAME = B.DBNAME) 
GO
Print 'Adding User RELS: BASE_HFit_TrackerRestingHeartRate'
GO
exec proc_ConnectTables_BySurrogateKey @SurrogateKey = "SurrogateKey_cms_user", @ParentTable = "BASE_CMS_User", @ChildTable  = "BASE_HFit_TrackerRestingHeartRate", @PreviewOnly = 0 
GO
update BASE_HFit_TrackerRestingHeartRate set SurrogateKey_cms_user = (select SurrogateKey_cms_user from BASE_CMS_User B 
    where BASE_HFit_TrackerRestingHeartRate.Userid = B.UserID and BASE_HFit_TrackerRestingHeartRate.DBNAME = B.DBNAME) 
GO
Print 'Adding User RELS: BASE_HFit_TrackerHighFatFoods'
GO
exec proc_ConnectTables_BySurrogateKey @SurrogateKey = "SurrogateKey_cms_user", @ParentTable = "BASE_CMS_User", @ChildTable  = "BASE_HFit_TrackerHighFatFoods", @PreviewOnly = 0 
GO
update BASE_HFit_TrackerHighFatFoods set SurrogateKey_cms_user = (select SurrogateKey_cms_user from BASE_CMS_User B 
    where BASE_HFit_TrackerHighFatFoods.Userid = B.UserID and BASE_HFit_TrackerHighFatFoods.DBNAME = B.DBNAME) 
GO
Print 'Adding User RELS: BASE_HFit_Join_ClinicalSourceTracker'
GO
exec proc_ConnectTables_BySurrogateKey @SurrogateKey = "SurrogateKey_cms_user", @ParentTable = "BASE_CMS_User", @ChildTable  = "BASE_HFit_Join_ClinicalSourceTracker", @PreviewOnly = 0 
GO
update BASE_HFit_Join_ClinicalSourceTracker set SurrogateKey_cms_user = (select SurrogateKey_cms_user from BASE_CMS_User B 
    where BASE_HFit_Join_ClinicalSourceTracker.Userid = B.UserID and BASE_HFit_Join_ClinicalSourceTracker.DBNAME = B.DBNAME) 
GO
Print 'Adding User RELS: DIM_EDW_Trackers'
GO
exec proc_ConnectTables_BySurrogateKey @SurrogateKey = "SurrogateKey_cms_user", @ParentTable = "BASE_CMS_User", @ChildTable  = "DIM_EDW_Trackers", @PreviewOnly = 0 
GO
update DIM_EDW_Trackers set SurrogateKey_cms_user = (select SurrogateKey_cms_user from BASE_CMS_User B 
    where DIM_EDW_Trackers.Userid = B.UserID and DIM_EDW_Trackers.DBNAME = B.DBNAME) 
GO
Print 'Adding User RELS: BASE_HFit_TrackerBodyFat'
GO
exec proc_ConnectTables_BySurrogateKey @SurrogateKey = "SurrogateKey_cms_user", @ParentTable = "BASE_CMS_User", @ChildTable  = "BASE_HFit_TrackerBodyFat", @PreviewOnly = 0 
GO
update BASE_HFit_TrackerBodyFat set SurrogateKey_cms_user = (select SurrogateKey_cms_user from BASE_CMS_User B 
    where BASE_HFit_TrackerBodyFat.Userid = B.UserID and BASE_HFit_TrackerBodyFat.DBNAME = B.DBNAME) 
GO
Print 'Adding User RELS: BASE_HFit_TrackerWeight'
GO
exec proc_ConnectTables_BySurrogateKey @SurrogateKey = "SurrogateKey_cms_user", @ParentTable = "BASE_CMS_User", @ChildTable  = "BASE_HFit_TrackerWeight", @PreviewOnly = 0 
GO
update BASE_HFit_TrackerWeight set SurrogateKey_cms_user = (select SurrogateKey_cms_user from BASE_CMS_User B 
    where BASE_HFit_TrackerWeight.Userid = B.UserID and BASE_HFit_TrackerWeight.DBNAME = B.DBNAME) 
GO
Print 'Adding User RELS: BASE_HFit_TrackerShots'
GO
exec proc_ConnectTables_BySurrogateKey @SurrogateKey = "SurrogateKey_cms_user", @ParentTable = "BASE_CMS_User", @ChildTable  = "BASE_HFit_TrackerShots", @PreviewOnly = 0 
GO
update BASE_HFit_TrackerShots set SurrogateKey_cms_user = (select SurrogateKey_cms_user from BASE_CMS_User B 
    where BASE_HFit_TrackerShots.Userid = B.UserID and BASE_HFit_TrackerShots.DBNAME = B.DBNAME) 
GO
Print 'Adding User RELS: BASE_HFit_TrackerHighSodiumFoods'
GO
exec proc_ConnectTables_BySurrogateKey @SurrogateKey = "SurrogateKey_cms_user", @ParentTable = "BASE_CMS_User", @ChildTable  = "BASE_HFit_TrackerHighSodiumFoods", @PreviewOnly = 0 
GO
update BASE_HFit_TrackerHighSodiumFoods set SurrogateKey_cms_user = (select SurrogateKey_cms_user from BASE_CMS_User B 
    where BASE_HFit_TrackerHighSodiumFoods.Userid = B.UserID and BASE_HFit_TrackerHighSodiumFoods.DBNAME = B.DBNAME) 
GO
Print 'Adding User RELS: BASE_HFit_UserTrackerCategory'
GO
exec proc_ConnectTables_BySurrogateKey @SurrogateKey = "SurrogateKey_cms_user", @ParentTable = "BASE_CMS_User", @ChildTable  = "BASE_HFit_UserTrackerCategory", @PreviewOnly = 0 
GO
update BASE_HFit_UserTrackerCategory set SurrogateKey_cms_user = (select SurrogateKey_cms_user from BASE_CMS_User B 
    where BASE_HFit_UserTrackerCategory.Userid = B.UserID and BASE_HFit_UserTrackerCategory.DBNAME = B.DBNAME) 
GO
Print 'Adding User RELS: BASE_HFit_TrackerSugaryFoods'
GO
exec proc_ConnectTables_BySurrogateKey @SurrogateKey = "SurrogateKey_cms_user", @ParentTable = "BASE_CMS_User", @ChildTable  = "BASE_HFit_TrackerSugaryFoods", @PreviewOnly = 0 
GO
update BASE_HFit_TrackerSugaryFoods set SurrogateKey_cms_user = (select SurrogateKey_cms_user from BASE_CMS_User B 
    where BASE_HFit_TrackerSugaryFoods.Userid = B.UserID and BASE_HFit_TrackerSugaryFoods.DBNAME = B.DBNAME) 
GO
Print 'Adding User RELS: BASE_HFit_join_ClinicalTrackers'
GO
exec proc_ConnectTables_BySurrogateKey @SurrogateKey = "SurrogateKey_cms_user", @ParentTable = "BASE_CMS_User", @ChildTable  = "BASE_HFit_join_ClinicalTrackers", @PreviewOnly = 0 
GO
update BASE_HFit_join_ClinicalTrackers set SurrogateKey_cms_user = (select SurrogateKey_cms_user from BASE_CMS_User B 
    where BASE_HFit_join_ClinicalTrackers.Userid = B.UserID and BASE_HFit_join_ClinicalTrackers.DBNAME = B.DBNAME) 
GO
Print 'Adding User RELS: BASE_HFit_TrackerDef_Item'
GO
exec proc_ConnectTables_BySurrogateKey @SurrogateKey = "SurrogateKey_cms_user", @ParentTable = "BASE_CMS_User", @ChildTable  = "BASE_HFit_TrackerDef_Item", @PreviewOnly = 0 
GO
update BASE_HFit_TrackerDef_Item set SurrogateKey_cms_user = (select SurrogateKey_cms_user from BASE_CMS_User B 
    where BASE_HFit_TrackerDef_Item.Userid = B.UserID and BASE_HFit_TrackerDef_Item.DBNAME = B.DBNAME) 
GO
Print 'Adding User RELS: BASE_HFit_TrackerBodyMeasurements'
GO
exec proc_ConnectTables_BySurrogateKey @SurrogateKey = "SurrogateKey_cms_user", @ParentTable = "BASE_CMS_User", @ChildTable  = "BASE_HFit_TrackerBodyMeasurements", @PreviewOnly = 0 
GO
update BASE_HFit_TrackerBodyMeasurements set SurrogateKey_cms_user = (select SurrogateKey_cms_user from BASE_CMS_User B 
    where BASE_HFit_TrackerBodyMeasurements.Userid = B.UserID and BASE_HFit_TrackerBodyMeasurements.DBNAME = B.DBNAME) 
GO
Print 'Adding User RELS: BASE_HFit_TrackerInstance_Item'
GO
exec proc_ConnectTables_BySurrogateKey @SurrogateKey = "SurrogateKey_cms_user", @ParentTable = "BASE_CMS_User", @ChildTable  = "BASE_HFit_TrackerInstance_Item", @PreviewOnly = 0 
GO
update BASE_HFit_TrackerInstance_Item set SurrogateKey_cms_user = (select SurrogateKey_cms_user from BASE_CMS_User B 
    where BASE_HFit_TrackerInstance_Item.Userid = B.UserID and BASE_HFit_TrackerInstance_Item.DBNAME = B.DBNAME) 
GO
Print 'Adding User RELS: BASE_HFit_Ref_RewardTrackerValidation'
GO
exec proc_ConnectTables_BySurrogateKey @SurrogateKey = "SurrogateKey_cms_user", @ParentTable = "BASE_CMS_User", @ChildTable  = "BASE_HFit_Ref_RewardTrackerValidation", @PreviewOnly = 0 
GO
update BASE_HFit_Ref_RewardTrackerValidation set SurrogateKey_cms_user = (select SurrogateKey_cms_user from BASE_CMS_User B 
    where BASE_HFit_Ref_RewardTrackerValidation.Userid = B.UserID and BASE_HFit_Ref_RewardTrackerValidation.DBNAME = B.DBNAME) 
GO
Print 'Adding User RELS: BASE_HFit_TrackerDef_Tracker'
GO
exec proc_ConnectTables_BySurrogateKey @SurrogateKey = "SurrogateKey_cms_user", @ParentTable = "BASE_CMS_User", @ChildTable  = "BASE_HFit_TrackerDef_Tracker", @PreviewOnly = 0 
GO
update BASE_HFit_TrackerDef_Tracker set SurrogateKey_cms_user = (select SurrogateKey_cms_user from BASE_CMS_User B 
    where BASE_HFit_TrackerDef_Tracker.Userid = B.UserID and BASE_HFit_TrackerDef_Tracker.DBNAME = B.DBNAME) 
GO
Print 'Adding User RELS: BASE_HFit_TrackerCardio'
GO
exec proc_ConnectTables_BySurrogateKey @SurrogateKey = "SurrogateKey_cms_user", @ParentTable = "BASE_CMS_User", @ChildTable  = "BASE_HFit_TrackerCardio", @PreviewOnly = 0 
GO
update BASE_HFit_TrackerCardio set SurrogateKey_cms_user = (select SurrogateKey_cms_user from BASE_CMS_User B 
    where BASE_HFit_TrackerCardio.Userid = B.UserID and BASE_HFit_TrackerCardio.DBNAME = B.DBNAME) 
GO
Print 'Adding User RELS: BASE_HFit_TrackerWholeGrains'
GO
exec proc_ConnectTables_BySurrogateKey @SurrogateKey = "SurrogateKey_cms_user", @ParentTable = "BASE_CMS_User", @ChildTable  = "BASE_HFit_TrackerWholeGrains", @PreviewOnly = 0 
GO
update BASE_HFit_TrackerWholeGrains set SurrogateKey_cms_user = (select SurrogateKey_cms_user from BASE_CMS_User B 
    where BASE_HFit_TrackerWholeGrains.Userid = B.UserID and BASE_HFit_TrackerWholeGrains.DBNAME = B.DBNAME) 
GO
Print 'Adding User RELS: BASE_HFit_TrackerInstance_Tracker'
GO
exec proc_ConnectTables_BySurrogateKey @SurrogateKey = "SurrogateKey_cms_user", @ParentTable = "BASE_CMS_User", @ChildTable  = "BASE_HFit_TrackerInstance_Tracker", @PreviewOnly = 0 
GO
update BASE_HFit_TrackerInstance_Tracker set SurrogateKey_cms_user = (select SurrogateKey_cms_user from BASE_CMS_User B 
    where BASE_HFit_TrackerInstance_Tracker.Userid = B.UserID and BASE_HFit_TrackerInstance_Tracker.DBNAME = B.DBNAME) 
GO
Print 'Adding User RELS: BASE_HFit_TrackerSummary'
GO
exec proc_ConnectTables_BySurrogateKey @SurrogateKey = "SurrogateKey_cms_user", @ParentTable = "BASE_CMS_User", @ChildTable  = "BASE_HFit_TrackerSummary", @PreviewOnly = 0 
GO
update BASE_HFit_TrackerSummary set SurrogateKey_cms_user = (select SurrogateKey_cms_user from BASE_CMS_User B 
    where BASE_HFit_TrackerSummary.Userid = B.UserID and BASE_HFit_TrackerSummary.DBNAME = B.DBNAME) 
GO
Print 'Adding User RELS: BASE_HFit_TrackerSitLess'
GO
exec proc_ConnectTables_BySurrogateKey @SurrogateKey = "SurrogateKey_cms_user", @ParentTable = "BASE_CMS_User", @ChildTable  = "BASE_HFit_TrackerSitLess", @PreviewOnly = 0 
GO
update BASE_HFit_TrackerSitLess set SurrogateKey_cms_user = (select SurrogateKey_cms_user from BASE_CMS_User B 
    where BASE_HFit_TrackerSitLess.Userid = B.UserID and BASE_HFit_TrackerSitLess.DBNAME = B.DBNAME) 
GO
Print 'Adding User RELS: BASE_HFit_TrackerTests'
GO
exec proc_ConnectTables_BySurrogateKey @SurrogateKey = "SurrogateKey_cms_user", @ParentTable = "BASE_CMS_User", @ChildTable  = "BASE_HFit_TrackerTests", @PreviewOnly = 0 
GO
update BASE_HFit_TrackerTests set SurrogateKey_cms_user = (select SurrogateKey_cms_user from BASE_CMS_User B 
    where BASE_HFit_TrackerTests.Userid = B.UserID and BASE_HFit_TrackerTests.DBNAME = B.DBNAME) 
GO
Print 'Adding User RELS: BASE_HFit_TrackerDocument'
GO
exec proc_ConnectTables_BySurrogateKey @SurrogateKey = "SurrogateKey_cms_user", @ParentTable = "BASE_CMS_User", @ChildTable  = "BASE_HFit_TrackerDocument", @PreviewOnly = 0 
GO
update BASE_HFit_TrackerDocument set SurrogateKey_cms_user = (select SurrogateKey_cms_user from BASE_CMS_User B 
    where BASE_HFit_TrackerDocument.Userid = B.UserID and BASE_HFit_TrackerDocument.DBNAME = B.DBNAME) 
GO
Print 'Adding User RELS: BASE_HFit_TrackerMealPortions'
GO
exec proc_ConnectTables_BySurrogateKey @SurrogateKey = "SurrogateKey_cms_user", @ParentTable = "BASE_CMS_User", @ChildTable  = "BASE_HFit_TrackerMealPortions", @PreviewOnly = 0 
GO
update BASE_HFit_TrackerMealPortions set SurrogateKey_cms_user = (select SurrogateKey_cms_user from BASE_CMS_User B 
    where BASE_HFit_TrackerMealPortions.Userid = B.UserID and BASE_HFit_TrackerMealPortions.DBNAME = B.DBNAME) 
GO
Print 'Adding User RELS: BASE_HFit_TrackerCategory'
GO
exec proc_ConnectTables_BySurrogateKey @SurrogateKey = "SurrogateKey_cms_user", @ParentTable = "BASE_CMS_User", @ChildTable  = "BASE_HFit_TrackerCategory", @PreviewOnly = 0 
GO
update BASE_HFit_TrackerCategory set SurrogateKey_cms_user = (select SurrogateKey_cms_user from BASE_CMS_User B 
    where BASE_HFit_TrackerCategory.Userid = B.UserID and BASE_HFit_TrackerCategory.DBNAME = B.DBNAME) 
GO
Print 'Adding User RELS: BASE_HFit_TrackerSleepPlan'
GO
exec proc_ConnectTables_BySurrogateKey @SurrogateKey = "SurrogateKey_cms_user", @ParentTable = "BASE_CMS_User", @ChildTable  = "BASE_HFit_TrackerSleepPlan", @PreviewOnly = 0 
GO
update BASE_HFit_TrackerSleepPlan set SurrogateKey_cms_user = (select SurrogateKey_cms_user from BASE_CMS_User B 
    where BASE_HFit_TrackerSleepPlan.Userid = B.UserID and BASE_HFit_TrackerSleepPlan.DBNAME = B.DBNAME) 
GO
Print 'Adding User RELS: BASE_HFit_TrackerFlexibility'
GO
exec proc_ConnectTables_BySurrogateKey @SurrogateKey = "SurrogateKey_cms_user", @ParentTable = "BASE_CMS_User", @ChildTable  = "BASE_HFit_TrackerFlexibility", @PreviewOnly = 0 
GO
update BASE_HFit_TrackerFlexibility set SurrogateKey_cms_user = (select SurrogateKey_cms_user from BASE_CMS_User B 
    where BASE_HFit_TrackerFlexibility.Userid = B.UserID and BASE_HFit_TrackerFlexibility.DBNAME = B.DBNAME) 
GO
Print 'Adding User RELS: BASE_HFIT_Tracker'
GO
exec proc_ConnectTables_BySurrogateKey @SurrogateKey = "SurrogateKey_cms_user", @ParentTable = "BASE_CMS_User", @ChildTable  = "BASE_HFIT_Tracker", @PreviewOnly = 0 
GO
update BASE_HFIT_Tracker set SurrogateKey_cms_user = (select SurrogateKey_cms_user from BASE_CMS_User B 
    where BASE_HFIT_Tracker.Userid = B.UserID and BASE_HFIT_Tracker.DBNAME = B.DBNAME) 
GO
Print 'Adding User RELS: BASE_HFit_TrackerCholesterol'
GO
exec proc_ConnectTables_BySurrogateKey @SurrogateKey = "SurrogateKey_cms_user", @ParentTable = "BASE_CMS_User", @ChildTable  = "BASE_HFit_TrackerCholesterol", @PreviewOnly = 0 
GO
update BASE_HFit_TrackerCholesterol set SurrogateKey_cms_user = (select SurrogateKey_cms_user from BASE_CMS_User B 
    where BASE_HFit_TrackerCholesterol.Userid = B.UserID and BASE_HFit_TrackerCholesterol.DBNAME = B.DBNAME) 
GO
Print 'Adding User RELS: BASE_HFit_TrackerMedicalCarePlan'
GO
exec proc_ConnectTables_BySurrogateKey @SurrogateKey = "SurrogateKey_cms_user", @ParentTable = "BASE_CMS_User", @ChildTable  = "BASE_HFit_TrackerMedicalCarePlan", @PreviewOnly = 0 
GO
update BASE_HFit_TrackerMedicalCarePlan set SurrogateKey_cms_user = (select SurrogateKey_cms_user from BASE_CMS_User B 
    where BASE_HFit_TrackerMedicalCarePlan.Userid = B.UserID and BASE_HFit_TrackerMedicalCarePlan.DBNAME = B.DBNAME) 
GO
Print 'Adding User RELS: BASE_HFit_HealthAssessmentCodeNamesToTrackerMapping'
GO
exec proc_ConnectTables_BySurrogateKey @SurrogateKey = "SurrogateKey_cms_user", @ParentTable = "BASE_CMS_User", @ChildTable  = "BASE_HFit_HealthAssessmentCodeNamesToTrackerMapping", @PreviewOnly = 0 
GO
update BASE_HFit_HealthAssessmentCodeNamesToTrackerMapping set SurrogateKey_cms_user = (select SurrogateKey_cms_user from BASE_CMS_User B 
    where BASE_HFit_HealthAssessmentCodeNamesToTrackerMapping.Userid = B.UserID and BASE_HFit_HealthAssessmentCodeNamesToTrackerMapping.DBNAME = B.DBNAME) 
GO
Print 'Adding User RELS: BASE_HFit_TrackerTobaccoAttestation'
GO
exec proc_ConnectTables_BySurrogateKey @SurrogateKey = "SurrogateKey_cms_user", @ParentTable = "BASE_CMS_User", @ChildTable  = "BASE_HFit_TrackerTobaccoAttestation", @PreviewOnly = 0 
GO
update BASE_HFit_TrackerTobaccoAttestation set SurrogateKey_cms_user = (select SurrogateKey_cms_user from BASE_CMS_User B 
    where BASE_HFit_TrackerTobaccoAttestation.Userid = B.UserID and BASE_HFit_TrackerTobaccoAttestation.DBNAME = B.DBNAME) 
GO
Print 'Adding User RELS: BASE_HFit_TrackerStrength'
GO
exec proc_ConnectTables_BySurrogateKey @SurrogateKey = "SurrogateKey_cms_user", @ParentTable = "BASE_CMS_User", @ChildTable  = "BASE_HFit_TrackerStrength", @PreviewOnly = 0 
GO
update BASE_HFit_TrackerStrength set SurrogateKey_cms_user = (select SurrogateKey_cms_user from BASE_CMS_User B 
    where BASE_HFit_TrackerStrength.Userid = B.UserID and BASE_HFit_TrackerStrength.DBNAME = B.DBNAME) 