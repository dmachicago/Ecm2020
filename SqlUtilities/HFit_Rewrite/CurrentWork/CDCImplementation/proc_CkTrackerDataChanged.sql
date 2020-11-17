

GO
-- USE KENTICOCMS_DATAMART_2
PRINT 'Creating proc_CkTrackerDataChanged';
PRINT 'FROM proc_CkTrackerDataChanged.sql';

IF EXISTS ( SELECT
                   name
            FROM sys.procedures
            WHERE
                   name = 'proc_CkTrackerDataChanged') 
    BEGIN
        DROP PROCEDURE
             proc_CkTrackerDataChanged;
    END;
GO

-- exec proc_CkTrackerDataChanged

/*
ALTER TABLE dbo.BASE_hfit_ppteligibility
ENABLE CHANGE_TRACKING
WITH (TRACK_COLUMNS_UPDATED = ON)
*/

CREATE PROC proc_CkTrackerDataChanged
AS
BEGIN
    --Returns a 0 if no changes were found
    --Returns a 1 of changes were found and no deletes
    --Returns a 2 of changes were found including deletes
    SET NOCOUNT ON;
    IF OBJECT_ID ('tempdb..##TempCompositeData') IS NOT NULL
        BEGIN DROP TABLE
                   ##TempCompositeData;
        END;

    CREATE TABLE ##TempCompositeData (
                 TGTTBL VARCHAR (50) NOT NULL
               , SYS_CHANGE_VERSION BIGINT NULL
               --, SYS_CHANGE_CREATION_VERSION BIGINT NULL
               , SYS_CHANGE_OPERATION NVARCHAR (10) NULL
               --, SYS_CHANGE_COLUMNS VARBINARY (MAX) NULL
               --, SYS_CHANGE_CONTEXT VARBINARY (MAX) NULL
               --, SVR NVARCHAR (100) NULL
               --, DBNAME NVARCHAR (100) NULL
               ----, CHANGE_VERSION BIGINT NULL
               --, ItemID INT NOT NULL
    );

    --CREATE CLUSTERED INDEX PK_TempCompositeData ON ##TempCompositeData
    --(
    --SVR ASC ,
    --DBNAME ASC ,
    --TGTTBL ASC ,
    --ItemID ASC
    --);

    DECLARE
           @b AS BIT = 0;

    INSERT INTO ##TempCompositeData
    SELECT
           'CMS_Site' AS TGTTBL
         , SYS_CHANGE_VERSION, SYS_CHANGE_OPERATION
    FROM CHANGETABLE (CHANGES BASE_CMS_Class , NULL) AS CT;
    INSERT INTO ##TempCompositeData
    SELECT
           'CMS_User' AS TGTTBL
        , SYS_CHANGE_VERSION, SYS_CHANGE_OPERATION
	   --, *
    FROM CHANGETABLE (CHANGES BASE_CMS_User , NULL) AS CT;

    INSERT INTO ##TempCompositeData
    SELECT
           'HFit_Account' AS TGTTBL
         , SYS_CHANGE_VERSION, SYS_CHANGE_OPERATION
    FROM CHANGETABLE (CHANGES BASE_HFit_Account , NULL) AS CT;

    INSERT INTO ##TempCompositeData
    SELECT
           'HFit_LKP_TrackerVendor' AS TGTTBL
         , SYS_CHANGE_VERSION, SYS_CHANGE_OPERATION
    FROM CHANGETABLE (CHANGES BASE_HFit_LKP_TrackerVendor , NULL) AS CT;

    INSERT INTO ##TempCompositeData
    SELECT
           'hfit_ppteligibility' AS TGTTBL
         , SYS_CHANGE_VERSION, SYS_CHANGE_OPERATION
    FROM CHANGETABLE (CHANGES BASE_hfit_ppteligibility , NULL) AS CT;

    INSERT INTO ##TempCompositeData
    SELECT
           'HFIT_Tracker' AS TGTTBL
         , SYS_CHANGE_VERSION, SYS_CHANGE_OPERATION
    FROM CHANGETABLE (CHANGES BASE_HFIT_Tracker , NULL) AS CT;

    INSERT INTO ##TempCompositeData
    SELECT
           'HFit_TrackerBloodPressure' AS TGTTBL
         , SYS_CHANGE_VERSION, SYS_CHANGE_OPERATION
    FROM CHANGETABLE (CHANGES BASE_HFit_TrackerBloodPressure , NULL) AS CT;

    INSERT INTO ##TempCompositeData
    SELECT
           'HFit_TrackerBloodSugarAndGlucose' AS TGTTBL
         , SYS_CHANGE_VERSION, SYS_CHANGE_OPERATION
    FROM CHANGETABLE (CHANGES BASE_HFit_TrackerBloodSugarAndGlucose , NULL) AS CT;

    INSERT INTO ##TempCompositeData
    SELECT
           'HFit_TrackerBMI' AS TGTTBL
         , SYS_CHANGE_VERSION, SYS_CHANGE_OPERATION
    FROM CHANGETABLE (CHANGES BASE_HFit_TrackerBMI , NULL) AS CT;

    INSERT INTO ##TempCompositeData
    SELECT
           'HFit_TrackerBodyFat' AS TGTTBL
         , SYS_CHANGE_VERSION, SYS_CHANGE_OPERATION
    FROM CHANGETABLE (CHANGES BASE_HFit_TrackerBodyFat , NULL) AS CT;

    INSERT INTO ##TempCompositeData
    SELECT
           'HFit_TrackerBodyMeasurements' AS TGTTBL
         , SYS_CHANGE_VERSION, SYS_CHANGE_OPERATION
    FROM CHANGETABLE (CHANGES BASE_HFit_TrackerBodyMeasurements , NULL) AS CT;

    INSERT INTO ##TempCompositeData
    SELECT
           'HFit_TrackerCardio' AS TGTTBL
         , SYS_CHANGE_VERSION, SYS_CHANGE_OPERATION
    FROM CHANGETABLE (CHANGES BASE_HFit_TrackerCardio , NULL) AS CT;

    INSERT INTO ##TempCompositeData
    SELECT
           'HFit_TrackerCholesterol' AS TGTTBL
         , SYS_CHANGE_VERSION, SYS_CHANGE_OPERATION
    FROM CHANGETABLE (CHANGES BASE_HFit_TrackerCholesterol , NULL) AS CT;

    INSERT INTO ##TempCompositeData
    SELECT
           'HFit_TrackerCollectionSource' AS TGTTBL
         , SYS_CHANGE_VERSION, SYS_CHANGE_OPERATION
    FROM CHANGETABLE (CHANGES BASE_HFit_TrackerCollectionSource , NULL) AS CT;

    INSERT INTO ##TempCompositeData
    SELECT
           'HFit_TrackerCotinine' AS TGTTBL
         , SYS_CHANGE_VERSION, SYS_CHANGE_OPERATION
    FROM CHANGETABLE (CHANGES BASE_HFit_TrackerCotinine , NULL) AS CT;

    INSERT INTO ##TempCompositeData
    SELECT
           'HFit_TrackerDailySteps' AS TGTTBL
         , SYS_CHANGE_VERSION, SYS_CHANGE_OPERATION
    FROM CHANGETABLE (CHANGES BASE_HFit_TrackerDailySteps , NULL) AS CT;

    INSERT INTO ##TempCompositeData
    SELECT
           'HFit_TrackerDef_Tracker' AS TGTTBL
         , SYS_CHANGE_VERSION, SYS_CHANGE_OPERATION
    FROM CHANGETABLE (CHANGES BASE_HFit_TrackerDef_Tracker , NULL) AS CT;

    INSERT INTO ##TempCompositeData
    SELECT
           'HFit_TrackerFlexibility' AS TGTTBL
         , SYS_CHANGE_VERSION, SYS_CHANGE_OPERATION
    FROM CHANGETABLE (CHANGES BASE_HFit_TrackerFlexibility , NULL) AS CT;

    INSERT INTO ##TempCompositeData
    SELECT
           'HFit_TrackerFruits' AS TGTTBL
         , SYS_CHANGE_VERSION, SYS_CHANGE_OPERATION
    FROM CHANGETABLE (CHANGES BASE_HFit_TrackerFruits , NULL) AS CT;

    INSERT INTO ##TempCompositeData
    SELECT
           'HFit_TrackerHbA1c' AS TGTTBL
         , SYS_CHANGE_VERSION, SYS_CHANGE_OPERATION
    FROM CHANGETABLE (CHANGES BASE_HFit_TrackerHbA1c , NULL) AS CT;

    INSERT INTO ##TempCompositeData
    SELECT
           'HFit_TrackerHeight' AS TGTTBL
         , SYS_CHANGE_VERSION, SYS_CHANGE_OPERATION
    FROM CHANGETABLE (CHANGES BASE_HFit_TrackerHeight , NULL) AS CT;

    INSERT INTO ##TempCompositeData
    SELECT
           'HFit_TrackerHighFatFoods' AS TGTTBL
         , SYS_CHANGE_VERSION, SYS_CHANGE_OPERATION
    FROM CHANGETABLE (CHANGES BASE_HFit_TrackerHighFatFoods , NULL) AS CT;

    INSERT INTO ##TempCompositeData
    SELECT
           'HFit_TrackerHighSodiumFoods' AS TGTTBL
         , SYS_CHANGE_VERSION, SYS_CHANGE_OPERATION
    FROM CHANGETABLE (CHANGES BASE_HFit_TrackerHighSodiumFoods , NULL) AS CT;

    INSERT INTO ##TempCompositeData
    SELECT
           'HFit_TrackerInstance_Tracker' AS TGTTBL
         , SYS_CHANGE_VERSION, SYS_CHANGE_OPERATION
    FROM CHANGETABLE (CHANGES BASE_HFit_TrackerInstance_Tracker , NULL) AS CT;

    INSERT INTO ##TempCompositeData
    SELECT
           'HFit_TrackerMealPortions' AS TGTTBL
         , SYS_CHANGE_VERSION, SYS_CHANGE_OPERATION
    FROM CHANGETABLE (CHANGES BASE_HFit_TrackerMealPortions , NULL) AS CT;

    INSERT INTO ##TempCompositeData
    SELECT
           'HFit_TrackerMedicalCarePlan' AS TGTTBL
         , SYS_CHANGE_VERSION, SYS_CHANGE_OPERATION
    FROM CHANGETABLE (CHANGES BASE_HFit_TrackerMedicalCarePlan , NULL) AS CT;

    INSERT INTO ##TempCompositeData
    SELECT
           'HFit_TrackerPreventiveCare' AS TGTTBL
         , SYS_CHANGE_VERSION, SYS_CHANGE_OPERATION
    FROM CHANGETABLE (CHANGES BASE_HFit_TrackerPreventiveCare , NULL) AS CT;

    INSERT INTO ##TempCompositeData
    SELECT
           'HFit_TrackerRegularMeals' AS TGTTBL
         , SYS_CHANGE_VERSION, SYS_CHANGE_OPERATION
    FROM CHANGETABLE (CHANGES BASE_HFit_TrackerRegularMeals , NULL) AS CT;

    INSERT INTO ##TempCompositeData
    SELECT
           'HFit_TrackerRestingHeartRate' AS TGTTBL
         , SYS_CHANGE_VERSION, SYS_CHANGE_OPERATION
    FROM CHANGETABLE (CHANGES BASE_HFit_TrackerRestingHeartRate , NULL) AS CT;
    INSERT INTO ##TempCompositeData
    SELECT
           'HFit_TrackerShots' AS TGTTBL
         , SYS_CHANGE_VERSION, SYS_CHANGE_OPERATION
    FROM CHANGETABLE (CHANGES BASE_HFit_TrackerShots , NULL) AS CT;

    INSERT INTO ##TempCompositeData
    SELECT
           'HFit_TrackerSitLess' AS TGTTBL
         , SYS_CHANGE_VERSION, SYS_CHANGE_OPERATION
    FROM CHANGETABLE (CHANGES BASE_HFit_TrackerSitLess , NULL) AS CT;

    INSERT INTO ##TempCompositeData
    SELECT
           'HFit_TrackerSleepPlan' AS TGTTBL
         , SYS_CHANGE_VERSION, SYS_CHANGE_OPERATION
    FROM CHANGETABLE (CHANGES BASE_HFit_TrackerSleepPlan , NULL) AS CT;

    INSERT INTO ##TempCompositeData
    SELECT
           'HFit_TrackerStrength' AS TGTTBL
         , SYS_CHANGE_VERSION, SYS_CHANGE_OPERATION
    FROM CHANGETABLE (CHANGES BASE_HFit_TrackerStrength , NULL) AS CT;

    INSERT INTO ##TempCompositeData
    SELECT
           'HFit_TrackerStress' AS TGTTBL
         , SYS_CHANGE_VERSION, SYS_CHANGE_OPERATION
    FROM CHANGETABLE (CHANGES BASE_HFit_TrackerStress , NULL) AS CT;

    INSERT INTO ##TempCompositeData
    SELECT
           'HFit_TrackerStressManagement' AS TGTTBL
         , SYS_CHANGE_VERSION, SYS_CHANGE_OPERATION
    FROM CHANGETABLE (CHANGES BASE_HFit_TrackerStressManagement , NULL) AS CT;

    INSERT INTO ##TempCompositeData
    SELECT
           'HFit_TrackerSugaryDrinks' AS TGTTBL
         , SYS_CHANGE_VERSION, SYS_CHANGE_OPERATION
    FROM CHANGETABLE (CHANGES BASE_HFit_TrackerSugaryDrinks , NULL) AS CT;

    INSERT INTO ##TempCompositeData
    SELECT
           'HFit_TrackerSugaryFoods' AS TGTTBL
         , SYS_CHANGE_VERSION, SYS_CHANGE_OPERATION
    FROM CHANGETABLE (CHANGES BASE_HFit_TrackerSugaryFoods , NULL) AS CT;

    INSERT INTO ##TempCompositeData
    SELECT
           'HFit_TrackerTests' AS TGTTBL
         , SYS_CHANGE_VERSION, SYS_CHANGE_OPERATION
    FROM CHANGETABLE (CHANGES BASE_HFit_TrackerTests , NULL) AS CT;

    INSERT INTO ##TempCompositeData
    SELECT
           'HFit_TrackerTobaccoAttestation' AS TGTTBL
         , SYS_CHANGE_VERSION, SYS_CHANGE_OPERATION
    FROM CHANGETABLE (CHANGES BASE_HFit_TrackerTobaccoAttestation , NULL) AS CT;

    INSERT INTO ##TempCompositeData
    SELECT
           'HFit_TrackerTobaccoFree' AS TGTTBL
         , SYS_CHANGE_VERSION, SYS_CHANGE_OPERATION
    FROM CHANGETABLE (CHANGES BASE_HFit_TrackerTobaccoFree , NULL) AS CT;

    INSERT INTO ##TempCompositeData
    SELECT
           'HFit_TrackerVegetables' AS TGTTBL
         , SYS_CHANGE_VERSION, SYS_CHANGE_OPERATION
    FROM CHANGETABLE (CHANGES BASE_HFit_TrackerVegetables , NULL) AS CT;

    INSERT INTO ##TempCompositeData
    SELECT
           'HFit_TrackerWater' AS TGTTBL
         , SYS_CHANGE_VERSION, SYS_CHANGE_OPERATION
    FROM CHANGETABLE (CHANGES BASE_HFit_TrackerWater , NULL) AS CT;

    INSERT INTO ##TempCompositeData
    SELECT
           'HFit_TrackerWeight' AS TGTTBL
         , SYS_CHANGE_VERSION, SYS_CHANGE_OPERATION
    FROM CHANGETABLE (CHANGES BASE_HFit_TrackerWeight , NULL) AS CT;

    INSERT INTO ##TempCompositeData
    SELECT
           'HFit_TrackerWholeGrains' AS TGTTBL
         , SYS_CHANGE_VERSION, SYS_CHANGE_OPERATION
    FROM CHANGETABLE (CHANGES BASE_HFit_TrackerWholeGrains , NULL) AS CT;

    --select * from ##TempCompositeData ;

    DECLARE
           @NbrUpdates AS INT = (SELECT
                                        COUNT (*) 
                                 FROM ##TempCompositeData) ;
    DECLARE
           @iInsert AS INT = 0;
    DECLARE
           @iUpdate AS INT = 0;
    DECLARE
           @iDel AS INT = 0;

    IF @NbrUpdates = 0
        BEGIN
            PRINT 'No changes found';
            SET @b = 0;
        END;
    ELSE
        BEGIN
            SET @iInsert = ( SELECT
                                    COUNT ( *) 
                             FROM ##TempCompositeData
                             WHERE
                                    SYS_CHANGE_OPERATION = 'I') ;
            SET @iUpdate = ( SELECT
                                    COUNT ( *) 
                             FROM ##TempCompositeData
                             WHERE
                                    SYS_CHANGE_OPERATION = 'U') ;
            SET @iDel = ( SELECT
                                 COUNT ( *) 
                          FROM ##TempCompositeData
                          WHERE
                                 SYS_CHANGE_OPERATION = 'D') ;
            PRINT CAST ( @NbrUpdates AS NVARCHAR ( 50)) + ' Changes found: proc_CkTrackerDataChanged';
            PRINT CAST ( @iInsert AS NVARCHAR ( 50)) + ' Inserts found: proc_CkTrackerDataChanged';
            PRINT CAST ( @iUpdate AS NVARCHAR ( 50)) + ' Updates found: proc_CkTrackerDataChanged';
            PRINT CAST ( @iDel AS NVARCHAR ( 50)) + ' Deletes found: proc_CkTrackerDataChanged';
            SET @b = 1;
            IF @iDel > 0
                BEGIN
                    SET @b = 2;
                END;
            SET NOCOUNT OFF;
            RETURN @b;
        END;
END;
GO
PRINT 'Created proc_CkTrackerDataChanged';
GO