/*
Test Perfomed by:  Corina Pensado
Test Date:			4/21/2015
Purpose:		    To compare the view count of records to the counts in the physical tables
*/
/*******************************************************************************************************/
/*TEST OUT DIFFERENCES BETWEEN VIEW AND PHYSICAL TABLE*/
/*******************************************************************************************************/

/*VIEW RESULTS BY TRACKER in VIEW*/
select trackernameaggregatetable view_EDW_TrackerCompositeDetails, count(0) as CNT 
from KenticoCMS_Prod1.dbo.view_EDW_TrackerCompositeDetails 
group by trackernameaggregatetable order by trackernameaggregatetable

/*VIEW RESULTS BY TRACKER in PHYSICAL TABLE*/
select * from (
select 'HFit_TrackerBloodPressure' SOURCE_TBL, Count(0) CNT from KenticoCMS_Prod1.dbo.HFit_TrackerBloodPressure
where userid in ( select userid from KenticoCMS_Prod1.dbo.hfit_ppteligibility)
UNION
select 'HFit_TrackerBloodSugarAndGlucose' src, Count(0) from KenticoCMS_Prod1.dbo.HFit_TrackerBloodSugarAndGlucose
where userid in ( select userid from KenticoCMS_Prod1.dbo.hfit_ppteligibility)
UNION
select 'HFit_TrackerBMI' src, Count(0) from KenticoCMS_Prod1.dbo.HFit_TrackerBMI
where userid in ( select userid from KenticoCMS_Prod1.dbo.hfit_ppteligibility)
UNION
select 'HFit_TrackerBodyFat' src, Count(0) from KenticoCMS_Prod1.dbo.HFit_TrackerBodyFat
where userid in ( select userid from KenticoCMS_Prod1.dbo.hfit_ppteligibility)
UNION
select 'HFit_TrackerBodyMeasurements' src, Count(0) from KenticoCMS_Prod1.dbo.HFit_TrackerBodyMeasurements
where userid in ( select userid from KenticoCMS_Prod1.dbo.hfit_ppteligibility)
UNION
select 'HFit_TrackerCardio' src, Count(0) from KenticoCMS_Prod1.dbo.HFit_TrackerCardio
where userid in ( select userid from KenticoCMS_Prod1.dbo.hfit_ppteligibility)
UNION
select 'HFit_TrackerCholesterol' src, Count(0) from KenticoCMS_Prod1.dbo.HFit_TrackerCholesterol
where userid in ( select userid from KenticoCMS_Prod1.dbo.hfit_ppteligibility)
UNION
select 'HFit_TrackerCotinine' src, Count(0) from KenticoCMS_Prod1.dbo.HFit_TrackerCotinine
where userid in ( select userid from KenticoCMS_Prod1.dbo.hfit_ppteligibility)
UNION
select 'HFit_TrackerDailySteps' src, Count(0) from KenticoCMS_Prod1.dbo.HFit_TrackerDailySteps
where userid in ( select userid from KenticoCMS_Prod1.dbo.hfit_ppteligibility)
UNION
select 'HFit_TrackerFlexibility' src, Count(0) from KenticoCMS_Prod1.dbo.HFit_TrackerFlexibility
where userid in ( select userid from KenticoCMS_Prod1.dbo.hfit_ppteligibility)
UNION
select 'HFit_TrackerFruits' src, Count(0) from KenticoCMS_Prod1.dbo.HFit_TrackerFruits
where userid in ( select userid from KenticoCMS_Prod1.dbo.hfit_ppteligibility)
UNION
select 'HFit_TrackerHbA1c' src, Count(0) from KenticoCMS_Prod1.dbo.HFit_TrackerHbA1c
where userid in ( select userid from KenticoCMS_Prod1.dbo.hfit_ppteligibility)
UNION
select 'HFit_TrackerHeight' src, Count(0) from KenticoCMS_Prod1.dbo.HFit_TrackerHeight
where userid in ( select userid from KenticoCMS_Prod1.dbo.hfit_ppteligibility)
UNION
select 'HFit_TrackerHighFatFoods' src, Count(0) from KenticoCMS_Prod1.dbo.HFit_TrackerHighFatFoods
where userid in ( select userid from KenticoCMS_Prod1.dbo.hfit_ppteligibility)
UNION
select 'HFit_TrackerHighSodiumFoods' src, Count(0) from KenticoCMS_Prod1.dbo.HFit_TrackerHighSodiumFoods
where userid in ( select userid from KenticoCMS_Prod1.dbo.hfit_ppteligibility)
UNION
select 'HFit_TrackerInstance_Tracker' src, Count(0) from KenticoCMS_Prod1.dbo.HFit_TrackerInstance_Tracker 
where userid in ( select userid from KenticoCMS_Prod1.dbo.hfit_ppteligibility)
UNION
select 'HFit_TrackerMealPortions' src, Count(0) from KenticoCMS_Prod1.dbo.HFit_TrackerMealPortions
where userid in ( select userid from KenticoCMS_Prod1.dbo.hfit_ppteligibility)
UNION
select 'HFit_TrackerMedicalCarePlan' src, Count(0) from KenticoCMS_Prod1.dbo.HFit_TrackerMedicalCarePlan
where userid in ( select userid from KenticoCMS_Prod1.dbo.hfit_ppteligibility)
UNION
select 'HFit_TrackerPreventiveCare' src, Count(0) from KenticoCMS_Prod1.dbo.HFit_TrackerPreventiveCare
where userid in ( select userid from KenticoCMS_Prod1.dbo.hfit_ppteligibility)
UNION
select 'HFit_TrackerRegularMeals' src, Count(0) from KenticoCMS_Prod1.dbo.HFit_TrackerRegularMeals
where userid in ( select userid from KenticoCMS_Prod1.dbo.hfit_ppteligibility)
UNION
select 'HFit_TrackerRestingHeartRate' src, Count(0) from KenticoCMS_Prod1.dbo.HFit_TrackerRestingHeartRate
where userid in ( select userid from KenticoCMS_Prod1.dbo.hfit_ppteligibility)
UNION
select 'HFit_TrackerShots' src, Count(0) from KenticoCMS_Prod1.dbo.HFit_TrackerShots
where userid in ( select userid from KenticoCMS_Prod1.dbo.hfit_ppteligibility)
UNION
select 'HFit_TrackerSitLess' src, Count(0) from KenticoCMS_Prod1.dbo.HFit_TrackerSitLess
where userid in ( select userid from KenticoCMS_Prod1.dbo.hfit_ppteligibility)
UNION
select 'HFit_TrackerSleepPlan' src, Count(0) from KenticoCMS_Prod1.dbo.HFit_TrackerSleepPlan
where userid in ( select userid from KenticoCMS_Prod1.dbo.hfit_ppteligibility)
UNION
select 'HFit_TrackerStrength' src, Count(0) from KenticoCMS_Prod1.dbo.HFit_TrackerStrength
where userid in ( select userid from KenticoCMS_Prod1.dbo.hfit_ppteligibility)
UNION
select 'HFit_TrackerStress' src, Count(0) from KenticoCMS_Prod1.dbo.HFit_TrackerStress
where userid in ( select userid from KenticoCMS_Prod1.dbo.hfit_ppteligibility)
UNION
select 'HFit_TrackerStressManagement' src, Count(0) from KenticoCMS_Prod1.dbo.HFit_TrackerStressManagement
where userid in ( select userid from KenticoCMS_Prod1.dbo.hfit_ppteligibility)
UNION
select 'HFit_TrackerSugaryDrinks' src, Count(0) from KenticoCMS_Prod1.dbo.HFit_TrackerSugaryDrinks
where userid in ( select userid from KenticoCMS_Prod1.dbo.hfit_ppteligibility)
UNION
select 'HFit_TrackerSugaryFoods' src, Count(0) from KenticoCMS_Prod1.dbo.HFit_TrackerSugaryFoods
where userid in ( select userid from KenticoCMS_Prod1.dbo.hfit_ppteligibility)
UNION
select 'HFit_TrackerTests' src, Count(0) from KenticoCMS_Prod1.dbo.HFit_TrackerTests
where userid in ( select userid from KenticoCMS_Prod1.dbo.hfit_ppteligibility)
UNION
select 'HFit_TrackerTobaccoFree' src, Count(0) from KenticoCMS_Prod1.dbo.HFit_TrackerTobaccoFree
where userid in ( select userid from KenticoCMS_Prod1.dbo.hfit_ppteligibility)
UNION
select 'HFit_TrackerVegetables' src, Count(0) from KenticoCMS_Prod1.dbo.HFit_TrackerVegetables
where userid in ( select userid from KenticoCMS_Prod1.dbo.hfit_ppteligibility)
UNION
select 'HFit_TrackerWater' src, Count(0) from KenticoCMS_Prod1.dbo.HFit_TrackerWater
where userid in ( select userid from KenticoCMS_Prod1.dbo.hfit_ppteligibility)
UNION
select 'HFit_TrackerWeight' src, Count(0) from KenticoCMS_Prod1.dbo.HFit_TrackerWeight
where userid in ( select userid from KenticoCMS_Prod1.dbo.hfit_ppteligibility)
UNION
select 'HFit_TrackerWholeGrains' src, Count(0) from KenticoCMS_Prod1.dbo.HFit_TrackerWholeGrains
where userid in ( select userid from KenticoCMS_Prod1.dbo.hfit_ppteligibility)
) x order by SOURCE_TBL

--*************************************************************************************************
--  TEST OUT PPTS NOT IN CMSUSER
--*************************************************************************************************

/*

select * from HFit_TrackerBloodPressure where itemid =20554 

select distinct trackernameaggregatetable,UOM  
from  dbo.view_EDW_TrackerCompositeDetails 
order by trackernameaggregatetable

select* from  dbo.view_EDW_TrackerCompositeDetails 

USE KenticoCMS_PRD;
GO
select *
from sys.objects     o
join sys.sql_modules m on m.object_id = o.object_id
where o.object_id = object_id( 'dbo.view_EDW_TrackerCompositeDetails')
  and o.type      = 'V'
  
  select *
from sys.sysobjects     o
join sys.syscomments    c on c.id = o.id
where o.name = '<dbo.view_EDW_TrackerCompositeDetails>'
  and o.type      = 'V'
  
  
USE KenticoCMS_PRD;
GO
SELECT *
FROM sys.sql_modules
WHERE object_id = OBJECT_ID('dbo.view_EDW_Coaches'); 
GO

*/


-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
