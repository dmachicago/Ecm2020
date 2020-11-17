

GO
PRINT 'Executing proc_SetTrackerPrimaryKey.sql';
GO
IF EXISTS (SELECT
              name
                  FROM sys.procedures
                  WHERE
                  name = 'proc_SetTrackerPrimaryKey') 
    BEGIN
        DROP PROCEDURE
           proc_SetTrackerPrimaryKey;
    END;
GO

CREATE PROCEDURE proc_SetTrackerPrimaryKey (@TblName AS NVARCHAR (100)) 
AS
BEGIN
    DECLARE
           @MySql AS NVARCHAR (MAX) = '';

    SET @MySql = 'ALTER TABLE [dbo].' + @TblName + ' drop CONSTRAINT ' + @TblName + '_PKID';

    BEGIN TRY
        EXEC (@MySql) ;
        PRINT 'Successfully DROPPED PKEY for ' + @TblName;
    END TRY
    BEGIN CATCH
        PRINT 'ERROR: Failed to DROP PKEY for ' + @TblName;
    END CATCH;

    SET @MySql = 'ALTER TABLE [dbo].' + @TblName + ' ADD  CONSTRAINT ' + @TblName + '_PKID PRIMARY KEY CLUSTERED ' + CHAR (10) ;
    SET @MySql = @MySql + '( ' + CHAR (10) ;
    SET @MySql = @MySql + '	TrackerNameAggregateTable,  ' + CHAR (10) ;
    SET @MySql = @MySql + '     [SVR] ASC, ' + CHAR (10) ;
    SET @MySql = @MySql + '	[DBNAME] ASC, ' + CHAR (10) ;
    SET @MySql = @MySql + '	[UserID] ASC, ' + CHAR (10) ;
    SET @MySql = @MySql + '	[ItemID] ASC ' + CHAR (10) ;
    SET @MySql = @MySql + ') ' + CHAR (10) ;

    BEGIN TRY
        EXEC (@MySql) ;
        PRINT 'Successfully modified PKEY for ' + @TblName;
    END TRY
    BEGIN CATCH
        PRINT 'ERROR: Failed to modify PKEY for ' + @TblName;
    END CATCH;

END;

GO
PRINT 'Executed proc_SetTrackerPrimaryKey.sql';
GO


--exec proc_SetTrackerPrimaryKey FACT_HFit_TrackerSitLess
--exec proc_SetTrackerPrimaryKey FACT_HFit_TrackerSleepPlan
--exec proc_SetTrackerPrimaryKey FACT_HFit_TrackerStrength
--exec proc_SetTrackerPrimaryKey FACT_HFit_TrackerStress
--exec proc_SetTrackerPrimaryKey FACT_HFit_TrackerStressManagement
--exec proc_SetTrackerPrimaryKey FACT_HFit_TrackerSugaryDrinks
--exec proc_SetTrackerPrimaryKey FACT_HFit_TrackerSugaryFoods
--exec proc_SetTrackerPrimaryKey FACT_HFit_TrackerTobaccoFree
--exec proc_SetTrackerPrimaryKey FACT_HFit_TrackerVegetables
--exec proc_SetTrackerPrimaryKey FACT_HFit_TrackerHeight
--exec proc_SetTrackerPrimaryKey FACT_HFit_TrackerWater
--exec proc_SetTrackerPrimaryKey FACT_HFit_TrackerWeight
--exec proc_SetTrackerPrimaryKey FACT_HFit_TrackerWholeGrains
--exec proc_SetTrackerPrimaryKey FACT_HFit_TrackerCotinine
--exec proc_SetTrackerPrimaryKey FACT_HFit_TrackerPreventiveCare
--exec proc_SetTrackerPrimaryKey FACT_HFit_TrackerCardio
--exec proc_SetTrackerPrimaryKey FACT_HFit_TrackerTobaccoAttestation
--exec proc_SetTrackerPrimaryKey FACT_HFit_TrackerMedicalCarePlan
--exec proc_SetTrackerPrimaryKey FACT_HFit_TrackerRegularMeals
--exec proc_SetTrackerPrimaryKey FACT_HFit_TrackerRestingHeartRate
--exec proc_SetTrackerPrimaryKey FACT_HFit_TrackerBloodSugarAndGlucose
--exec proc_SetTrackerPrimaryKey FACT_HFit_TrackerBloodPressure

--exec proc_SetTrackerPrimaryKey FACT_HFit_TrackerBMI

--exec proc_SetTrackerPrimaryKey FACT_HFit_TrackerBodyFat
--exec proc_SetTrackerPrimaryKey FACT_HFit_TrackerBodyMeasurements
--exec proc_SetTrackerPrimaryKey FACT_HFit_TrackerDailySteps
--exec proc_SetTrackerPrimaryKey FACT_HFit_TrackerHbA1c
--exec proc_SetTrackerPrimaryKey FACT_HFit_TrackerHighFatFoods
--exec proc_SetTrackerPrimaryKey FACT_HFit_TrackerHighSodiumFoods

--exec proc_SetTrackerPrimaryKey FACT_HFit_TrackerInstance_Tracker

--exec proc_SetTrackerPrimaryKey FACT_HFit_TrackerCholesterol
--exec proc_SetTrackerPrimaryKey FACT_HFit_TrackerMealPortions
--exec proc_SetTrackerPrimaryKey FACT_HFit_TrackerFlexibility
--exec proc_SetTrackerPrimaryKey FACT_HFit_TrackerFruits
--exec proc_SetTrackerPrimaryKey FACT_HFit_TrackerSho
