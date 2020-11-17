print ('Processing: view_EDW_ScreeningsFromTrackers ') ;
go

if exists(select TABLE_NAME from INFORMATION_SCHEMA.VIEWS where TABLE_NAME = 'view_EDW_ScreeningsFromTrackers')
BEGIN
	drop view view_EDW_ScreeningsFromTrackers ;
END
GO

--********************************************************************************************************
--09.11.2014 : (wdm) Verified last mod date available to EDW 
--********************************************************************************************************
CREATE VIEW [dbo].[view_EDW_ScreeningsFromTrackers]

AS

SELECT
	t.userid
	, cast(t.eventdate as datetime) as eventdate
	, t.TrackerCollectionSourceID
	, t.ItemCreatedBy
	, cast(t.ItemCreatedWhen as datetime) as ItemCreatedWhen
	, t.ItemModifiedBy
	, cast(t.ItemModifiedWhen as datetime) as ItemModifiedWhen
FROM
	(
		SELECT
			userid
			, cast(eventdate as datetime) as eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, cast(ItemCreatedWhen as datetime) as ItemCreatedWhen
			, ItemModifiedBy
			, cast(ItemModifiedWhen as datetime) as ItemModifiedWhen
		FROM
			HFit_TrackerBloodPressure
		UNION ALL
		SELECT
			userid
			, cast(eventdate as datetime) as eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, cast(ItemCreatedWhen as datetime) as ItemCreatedWhen
			, ItemModifiedBy
			, cast(ItemModifiedWhen as datetime) as ItemModifiedWhen
		FROM
			HFit_TrackerBloodSugarAndGlucose
		UNION ALL
		SELECT
			userid
			, cast(eventdate as datetime) as eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, cast(ItemCreatedWhen as datetime) as ItemCreatedWhen
			, ItemModifiedBy
			, cast(ItemModifiedWhen as datetime) as ItemModifiedWhen
		FROM
			HFit_TrackerBMI
		UNION ALL
		SELECT
			userid
			, cast(eventdate as datetime) as eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, cast(ItemCreatedWhen as datetime) as ItemCreatedWhen
			, ItemModifiedBy
			, cast(ItemModifiedWhen as datetime) as ItemModifiedWhen
		FROM
			HFit_TrackerBodyFat
		UNION ALL
		SELECT
			userid
			, cast(eventdate as datetime) as eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, cast(ItemCreatedWhen as datetime) as ItemCreatedWhen
			, ItemModifiedBy
			, cast(ItemModifiedWhen as datetime) as ItemModifiedWhen
		FROM
			HFit_TrackerBodyMeasurements
		UNION ALL
		SELECT
			userid
			, cast(eventdate as datetime) as eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, cast(ItemCreatedWhen as datetime) as ItemCreatedWhen
			, ItemModifiedBy
			, cast(ItemModifiedWhen as datetime) as ItemModifiedWhen
		FROM
			HFit_TrackerCardio
		UNION ALL
		SELECT
			userid
			, cast(eventdate as datetime) as eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, cast(ItemCreatedWhen as datetime) as ItemCreatedWhen
			, ItemModifiedBy
			, cast(ItemModifiedWhen as datetime) as ItemModifiedWhen
		FROM
			HFit_TrackerCholesterol
		UNION ALL
		SELECT
			userid
			, cast(eventdate as datetime) as eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, cast(ItemCreatedWhen as datetime) as ItemCreatedWhen
			, ItemModifiedBy
			, cast(ItemModifiedWhen as datetime) as ItemModifiedWhen
		FROM
			HFit_TrackerDailySteps
		UNION ALL
		SELECT
			userid
			, cast(eventdate as datetime) as eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, cast(ItemCreatedWhen as datetime) as ItemCreatedWhen
			, ItemModifiedBy
			, cast(ItemModifiedWhen as datetime) as ItemModifiedWhen
		FROM
			HFit_TrackerFlexibility
		UNION ALL
		SELECT
			userid
			, cast(eventdate as datetime) as eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, cast(ItemCreatedWhen as datetime) as ItemCreatedWhen
			, ItemModifiedBy
			, cast(ItemModifiedWhen as datetime) as ItemModifiedWhen
		FROM
			HFit_TrackerFruits
		UNION ALL
		SELECT
			userid
			, cast(eventdate as datetime) as eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, cast(ItemCreatedWhen as datetime) as ItemCreatedWhen
			, ItemModifiedBy
			, cast(ItemModifiedWhen as datetime) as ItemModifiedWhen
		FROM
			HFit_TrackerHbA1c
		UNION ALL
		SELECT
			userid
			, cast(eventdate as datetime) as eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, cast(ItemCreatedWhen as datetime) as ItemCreatedWhen
			, ItemModifiedBy
			, cast(ItemModifiedWhen as datetime) as ItemModifiedWhen
		FROM
			HFit_TrackerHeight
		UNION ALL
		SELECT
			userid
			, cast(eventdate as datetime) as eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, cast(ItemCreatedWhen as datetime) as ItemCreatedWhen
			, ItemModifiedBy
			, cast(ItemModifiedWhen as datetime) as ItemModifiedWhen
		FROM
			HFit_TrackerHighFatFoods
		UNION ALL
		SELECT
			userid
			, cast(eventdate as datetime) as eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, cast(ItemCreatedWhen as datetime) as ItemCreatedWhen
			, ItemModifiedBy
			, cast(ItemModifiedWhen as datetime) as ItemModifiedWhen
		FROM
			HFit_TrackerHighSodiumFoods
		UNION ALL
		SELECT
			userid
			, cast(eventdate as datetime) as eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, cast(ItemCreatedWhen as datetime) as ItemCreatedWhen
			, ItemModifiedBy
			, cast(ItemModifiedWhen as datetime) as ItemModifiedWhen
		FROM
			HFit_TrackerInstance_Tracker
		UNION ALL
		SELECT
			userid
			, cast(eventdate as datetime) as eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, cast(ItemCreatedWhen as datetime) as ItemCreatedWhen
			, ItemModifiedBy
			, cast(ItemModifiedWhen as datetime) as ItemModifiedWhen
		FROM
			HFit_TrackerMealPortions
		UNION ALL
		SELECT
			userid
			, cast(eventdate as datetime) as eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, cast(ItemCreatedWhen as datetime) as ItemCreatedWhen
			, ItemModifiedBy
			, cast(ItemModifiedWhen as datetime) as ItemModifiedWhen
		FROM
			HFit_TrackerMedicalCarePlan
		UNION ALL
		SELECT
			userid
			, cast(eventdate as datetime) as eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, cast(ItemCreatedWhen as datetime) as ItemCreatedWhen
			, ItemModifiedBy
			, cast(ItemModifiedWhen as datetime) as ItemModifiedWhen
		FROM
			HFit_TrackerRegularMeals
		UNION ALL
		SELECT
			userid
			, cast(eventdate as datetime) as eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, cast(ItemCreatedWhen as datetime) as ItemCreatedWhen
			, ItemModifiedBy
			, cast(ItemModifiedWhen as datetime) as ItemModifiedWhen
		FROM
			HFit_TrackerRestingHeartRate
		UNION ALL
		SELECT
			userid
			, cast(eventdate as datetime) as eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, cast(ItemCreatedWhen as datetime) as ItemCreatedWhen
			, ItemModifiedBy
			, cast(ItemModifiedWhen as datetime) as ItemModifiedWhen
		FROM
			HFit_TrackerShots
		UNION ALL
		SELECT
			userid
			, cast(eventdate as datetime) as eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, cast(ItemCreatedWhen as datetime) as ItemCreatedWhen
			, ItemModifiedBy
			, cast(ItemModifiedWhen as datetime) as ItemModifiedWhen
		FROM
			HFit_TrackerSitLess
		UNION ALL
		SELECT
			userid
			, cast(eventdate as datetime) as eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, cast(ItemCreatedWhen as datetime) as ItemCreatedWhen
			, ItemModifiedBy
			, cast(ItemModifiedWhen as datetime) as ItemModifiedWhen
		FROM
			HFit_TrackerSleepPlan
		UNION ALL
		SELECT
			userid
			, cast(eventdate as datetime) as eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, cast(ItemCreatedWhen as datetime) as ItemCreatedWhen
			, ItemModifiedBy
			, cast(ItemModifiedWhen as datetime) as ItemModifiedWhen
		FROM
			HFit_TrackerStrength
		UNION ALL
		SELECT
			userid
			, cast(eventdate as datetime) as eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, cast(ItemCreatedWhen as datetime) as ItemCreatedWhen
			, ItemModifiedBy
			, cast(ItemModifiedWhen as datetime) as ItemModifiedWhen
		FROM
			HFit_TrackerStress
		UNION ALL
		SELECT
			userid
			, cast(eventdate as datetime) as eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, cast(ItemCreatedWhen as datetime) as ItemCreatedWhen
			, ItemModifiedBy
			, cast(ItemModifiedWhen as datetime) as ItemModifiedWhen
		FROM
			HFit_TrackerStressManagement
		UNION ALL
		SELECT
			userid
			, cast(eventdate as datetime) as eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, cast(ItemCreatedWhen as datetime) as ItemCreatedWhen
			, ItemModifiedBy
			, cast(ItemModifiedWhen as datetime) as ItemModifiedWhen
		FROM
			HFit_TrackerSugaryDrinks
		UNION ALL
		SELECT
			userid
			, cast(eventdate as datetime) as eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, cast(ItemCreatedWhen as datetime) as ItemCreatedWhen
			, ItemModifiedBy
			, cast(ItemModifiedWhen as datetime) as ItemModifiedWhen
		FROM
			HFit_TrackerSugaryFoods
		UNION ALL
		SELECT
			userid
			, cast(eventdate as datetime) as eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, cast(ItemCreatedWhen as datetime) as ItemCreatedWhen
			, ItemModifiedBy
			, cast(ItemModifiedWhen as datetime) as ItemModifiedWhen
		FROM
			HFit_TrackerTests
		UNION ALL
		SELECT
			userid
			, cast(eventdate as datetime) as eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, cast(ItemCreatedWhen as datetime) as ItemCreatedWhen
			, ItemModifiedBy
			, cast(ItemModifiedWhen as datetime) as ItemModifiedWhen
		FROM
			HFit_TrackerTobaccoFree
		UNION ALL
		SELECT
			userid
			, cast(eventdate as datetime) as eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, cast(ItemCreatedWhen as datetime) as ItemCreatedWhen
			, ItemModifiedBy
			, cast(ItemModifiedWhen as datetime) as ItemModifiedWhen
		FROM
			HFit_TrackerVegetables
		UNION ALL
		SELECT
			userid
			, cast(eventdate as datetime) as eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, cast(ItemCreatedWhen as datetime) as ItemCreatedWhen
			, ItemModifiedBy
			, cast(ItemModifiedWhen as datetime) as ItemModifiedWhen
		FROM
			HFit_TrackerWater
		UNION ALL
		SELECT
			userid
			, cast(eventdate as datetime) as eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, cast(ItemCreatedWhen as datetime) as ItemCreatedWhen
			, ItemModifiedBy
			, cast(ItemModifiedWhen as datetime) as ItemModifiedWhen
		FROM
			HFit_TrackerWeight
		UNION ALL
		SELECT
			userid
			, cast(eventdate as datetime) as eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, cast(ItemCreatedWhen as datetime) as ItemCreatedWhen
			, ItemModifiedBy
			, cast(ItemModifiedWhen as datetime) as ItemModifiedWhen
		FROM
			HFit_TrackerWholeGrains
	) as T
INNER JOIN dbo.HFit_TrackerCollectionSource AS HFTCS ON t.TrackerCollectionSourceID = HFTCS.TrackerCollectionSourceID
WHERE HFTCS.isProfessionallyCollected = 1


GO


  --  
  --  
GO 
print('***** FROM: view_EDW_ScreeningsFromTrackers.sql'); 
GO 
