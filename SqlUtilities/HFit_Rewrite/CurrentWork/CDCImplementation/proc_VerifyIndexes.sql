
GO
PRINT 'Creating proc_VerifyIndexes';
GO
IF EXISTS (SELECT name
             FROM sys.procedures
             WHERE name = 'proc_VerifyIndexes') 
    BEGIN
        DROP PROCEDURE proc_VerifyIndexes;
    END;
GO

CREATE PROCEDURE proc_VerifyIndexes
AS
BEGIN
    EXEC PrintImmediate 'PI_BASE_hfit_PPTEligibility_ModDate';
    IF NOT EXISTS (SELECT name
                     FROM sys.indexes
                     WHERE name = 'PI_BASE_hfit_PPTEligibility_ModDate') 
        BEGIN
            CREATE NONCLUSTERED INDEX PI_BASE_hfit_PPTEligibility_ModDate ON dbo.BASE_hfit_PPTEligibility (DBNAME) INCLUDE (PPTID , ItemModifiedWhen) ;
        END;
    EXEC PrintImmediate 'PI_BASE_EDW_RoleMemberToday_LAstMod';
    IF NOT EXISTS (SELECT name
                     FROM sys.indexes
                     WHERE name = 'PI_BASE_EDW_RoleMemberToday_LAstMod') 
        BEGIN
            CREATE NONCLUSTERED INDEX PI_BASE_EDW_RoleMemberToday_LAstMod ON dbo.BASE_EDW_RoleMemberToday (DBNAME) INCLUDE (CTKey_EDW_RoleMemberToday) ;
        END;
    EXEC PrintImmediate 'PI_BASE_view_EDW_CoachingPPTAvailable_AcctID';
    IF NOT EXISTS (SELECT name
                     FROM sys.indexes
                     WHERE name = 'PI_BASE_view_EDW_CoachingPPTAvailable_AcctID') 
        BEGIN
            CREATE NONCLUSTERED INDEX PI_BASE_view_EDW_CoachingPPTAvailable_AcctID ON dbo.BASE_view_EDW_CoachingPPTAvailable (SurrogateKey_HFit_Account) INCLUDE (UserID , HashCode , DBNAME) ;
        END;

    --THIS IS EXECUTED BY job_proc_VerifyIndexes
    EXEC PrintImmediate 'KenticoCMS_1: CI_HFit_TrackerHeight';
    IF NOT EXISTS (SELECT name
                     FROM KenticoCMS_1.sys.indexes
                     WHERE name = 'CI_HFit_TrackerHeight') 
        BEGIN
            CREATE NONCLUSTERED INDEX CI_HFit_TrackerHeight ON KenticoCMS_1.dbo.HFit_TrackerHeight (ItemModifiedWhen) INCLUDE (EventDate , IsProfessionallyCollected , TrackerCollectionSourceID , Notes , UserID , Height , ItemCreatedBy , ItemCreatedWhen , ItemModifiedBy , ItemOrder , ItemGUID , IsProcessedForHa , VendorID) ;
        END;
    EXEC PrintImmediate 'KenticoCMS_2: CI_HFit_TrackerHeight';
    IF NOT EXISTS (SELECT name
                     FROM KenticoCMS_2.sys.indexes
                     WHERE name = 'CI_HFit_TrackerHeight') 
        BEGIN
            CREATE NONCLUSTERED INDEX CI_HFit_TrackerHeight ON KenticoCMS_2.dbo.HFit_TrackerHeight (ItemModifiedWhen) INCLUDE (EventDate , IsProfessionallyCollected , TrackerCollectionSourceID , Notes , UserID , Height , ItemCreatedBy , ItemCreatedWhen , ItemModifiedBy , ItemOrder , ItemGUID , IsProcessedForHa , VendorID) ;
        END;
    EXEC PrintImmediate 'KenticoCMS_3: CI_HFit_TrackerHeight';
    IF NOT EXISTS (SELECT name
                     FROM KenticoCMS_3.sys.indexes
                     WHERE name = 'CI_HFit_TrackerHeight') 
        BEGIN
            CREATE NONCLUSTERED INDEX CI_HFit_TrackerHeight ON KenticoCMS_3.dbo.HFit_TrackerHeight (ItemModifiedWhen) INCLUDE (EventDate , IsProfessionallyCollected , TrackerCollectionSourceID , Notes , UserID , Height , ItemCreatedBy , ItemCreatedWhen , ItemModifiedBy , ItemOrder , ItemGUID , IsProcessedForHa , VendorID) ;
        END;

    IF NOT EXISTS (SELECT name
                     FROM sys.indexes
                     WHERE name = 'PI_EligStartEndDate') 
        BEGIN

            CREATE NONCLUSTERED INDEX PI_EligStartEndDate ON dbo.BASE_EDW_GroupMemberHistory (StartedDate ASC , EndedDate ASC) INCLUDE (UserMpiNumber) WITH (PAD_INDEX = OFF , STATISTICS_NORECOMPUTE = OFF , SORT_IN_TEMPDB = OFF , DROP_EXISTING = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ;
        END;
    EXEC PrintImmediate 'SurrogateKey_CMS_user';
    --GO
    IF NOT EXISTS (SELECT name
                     FROM sys.indexes
                     WHERE name = 'IDX_DBNAME_SurrogateKey_CMS_user') 
        BEGIN
            CREATE NONCLUSTERED INDEX IDX_DBNAME_SurrogateKey_CMS_user ON dbo.FACT_TrackerData (TrackerName) INCLUDE (DBNAME , SurrogateKey_CMS_user) ;
        END;
    --GO
    EXEC PrintImmediate 'SurrogateKey_HFIT_Tracker';
    --GO
    IF NOT EXISTS (SELECT name
                     FROM sys.indexes
                     WHERE name = 'IDX_DBNAME_SurrogateKey_HFIT_Tracker') 
        BEGIN
            CREATE NONCLUSTERED INDEX IDX_DBNAME_SurrogateKey_HFIT_Tracker ON dbo.FACT_TrackerData (TrackerName) INCLUDE (DBNAME , SurrogateKey_HFIT_Tracker) ;
        END;
    --GO
    EXEC PrintImmediate 'SurrogateKey_HFit_TrackerBloodPressure';
    --GO
    IF NOT EXISTS (SELECT name
                     FROM sys.indexes
                     WHERE name = 'IDX_DBNAME_SurrogateKey_HFit_TrackerBloodPressure') 
        BEGIN
            CREATE NONCLUSTERED INDEX IDX_DBNAME_SurrogateKey_HFit_TrackerBloodPressure ON dbo.FACT_TrackerData (TrackerName) INCLUDE (DBNAME , SurrogateKey_HFit_TrackerBloodPressure) ;
        END;
    --GO
    EXEC PrintImmediate 'SurrogateKey_HFit_TrackerBloodSugarAndGlucose';
    --GO
    IF NOT EXISTS (SELECT name
                     FROM sys.indexes
                     WHERE name = 'IDX_DBNAME_SurrogateKey_HFit_TrackerBloodSugarAndGlucose') 
        BEGIN
            CREATE NONCLUSTERED INDEX IDX_DBNAME_SurrogateKey_HFit_TrackerBloodSugarAndGlucose ON dbo.FACT_TrackerData (TrackerName) INCLUDE (DBNAME , SurrogateKey_HFit_TrackerBloodSugarAndGlucose) ;
        END;
    --GO
    EXEC PrintImmediate 'SurrogateKey_HFit_TrackerBMI';
    --GO
    IF NOT EXISTS (SELECT name
                     FROM sys.indexes
                     WHERE name = 'IDX_DBNAME_SurrogateKey_HFit_TrackerBMI') 
        BEGIN
            CREATE NONCLUSTERED INDEX IDX_DBNAME_SurrogateKey_HFit_TrackerBMI ON dbo.FACT_TrackerData (TrackerName) INCLUDE (DBNAME , SurrogateKey_HFit_TrackerBMI) ;
        END;
    --GO
    EXEC PrintImmediate 'SurrogateKey_HFit_TrackerBodyFat';
    --GO
    IF NOT EXISTS (SELECT name
                     FROM sys.indexes
                     WHERE name = 'IDX_DBNAME_SurrogateKey_HFit_TrackerBodyFat') 
        BEGIN
            CREATE NONCLUSTERED INDEX IDX_DBNAME_SurrogateKey_HFit_TrackerBodyFat ON dbo.FACT_TrackerData (TrackerName) INCLUDE (DBNAME , SurrogateKey_HFit_TrackerBodyFat) ;
        END;
    --GO
    EXEC PrintImmediate 'SurrogateKey_HFit_TrackerBodyMeasurements';
    --GO
    IF NOT EXISTS (SELECT name
                     FROM sys.indexes
                     WHERE name = 'IDX_DBNAME_SurrogateKey_HFit_TrackerBodyMeasurements') 
        BEGIN
            CREATE NONCLUSTERED INDEX IDX_DBNAME_SurrogateKey_HFit_TrackerBodyMeasurements ON dbo.FACT_TrackerData (TrackerName) INCLUDE (DBNAME , SurrogateKey_HFit_TrackerBodyMeasurements) ;
        END;
    --GO
    EXEC PrintImmediate 'SurrogateKey_HFit_TrackerCardio';
    --GO
    IF NOT EXISTS (SELECT name
                     FROM sys.indexes
                     WHERE name = 'IDX_DBNAME_SurrogateKey_HFit_TrackerCardio') 
        BEGIN
            CREATE NONCLUSTERED INDEX IDX_DBNAME_SurrogateKey_HFit_TrackerCardio ON dbo.FACT_TrackerData (TrackerName) INCLUDE (DBNAME , SurrogateKey_HFit_TrackerCardio) ;
        END;
    --GO
    EXEC PrintImmediate 'SurrogateKey_HFit_TrackerCholesterol';
    --GO
    IF NOT EXISTS (SELECT name
                     FROM sys.indexes
                     WHERE name = 'IDX_DBNAME_SurrogateKey_HFit_TrackerCholesterol') 
        BEGIN
            CREATE NONCLUSTERED INDEX IDX_DBNAME_SurrogateKey_HFit_TrackerCholesterol ON dbo.FACT_TrackerData (TrackerName) INCLUDE (DBNAME , SurrogateKey_HFit_TrackerCholesterol) ;
        END;
    --GO
    EXEC PrintImmediate 'SurrogateKey_HFit_TrackerCollectionSource';
    --GO
    IF NOT EXISTS (SELECT name
                     FROM sys.indexes
                     WHERE name = 'IDX_DBNAME_SurrogateKey_HFit_TrackerCollectionSource') 
        BEGIN
            CREATE NONCLUSTERED INDEX IDX_DBNAME_SurrogateKey_HFit_TrackerCollectionSource ON dbo.FACT_TrackerData (TrackerName) INCLUDE (DBNAME , SurrogateKey_HFit_TrackerCollectionSource) ;
        END;
    --GO
    EXEC PrintImmediate 'SurrogateKey_HFit_TrackerCotinine';
    --GO
    IF NOT EXISTS (SELECT name
                     FROM sys.indexes
                     WHERE name = 'IDX_DBNAME_SurrogateKey_HFit_TrackerCotinine') 
        BEGIN
            CREATE NONCLUSTERED INDEX IDX_DBNAME_SurrogateKey_HFit_TrackerCotinine ON dbo.FACT_TrackerData (TrackerName) INCLUDE (DBNAME , SurrogateKey_HFit_TrackerCotinine) ;
        END;
    --GO
    EXEC PrintImmediate 'SurrogateKey_HFit_TrackerDailySteps';
    --GO
    IF NOT EXISTS (SELECT name
                     FROM sys.indexes
                     WHERE name = 'IDX_DBNAME_SurrogateKey_HFit_TrackerDailySteps') 
        BEGIN
            CREATE NONCLUSTERED INDEX IDX_DBNAME_SurrogateKey_HFit_TrackerDailySteps ON dbo.FACT_TrackerData (TrackerName) INCLUDE (DBNAME , SurrogateKey_HFit_TrackerDailySteps) ;
        END;
    --GO
    EXEC PrintImmediate 'SurrogateKey_HFit_TrackerDef_Tracker';
    --GO
    IF NOT EXISTS (SELECT name
                     FROM sys.indexes
                     WHERE name = 'IDX_DBNAME_SurrogateKey_HFit_TrackerDef_Tracker') 
        BEGIN
            CREATE NONCLUSTERED INDEX IDX_DBNAME_SurrogateKey_HFit_TrackerDef_Tracker ON dbo.FACT_TrackerData (TrackerName) INCLUDE (DBNAME , SurrogateKey_HFit_TrackerDef_Tracker) ;
        END;
    --GO
    EXEC PrintImmediate 'SurrogateKey_HFit_TrackerFlexibility';
    --GO
    IF NOT EXISTS (SELECT name
                     FROM sys.indexes
                     WHERE name = 'IDX_DBNAME_SurrogateKey_HFit_TrackerFlexibility') 
        BEGIN
            CREATE NONCLUSTERED INDEX IDX_DBNAME_SurrogateKey_HFit_TrackerFlexibility ON dbo.FACT_TrackerData (TrackerName) INCLUDE (DBNAME , SurrogateKey_HFit_TrackerFlexibility) ;
        END;
    --GO
    EXEC PrintImmediate 'SurrogateKey_HFit_TrackerFruits';
    --GO
    IF NOT EXISTS (SELECT name
                     FROM sys.indexes
                     WHERE name = 'IDX_DBNAME_SurrogateKey_HFit_TrackerFruits') 
        BEGIN
            CREATE NONCLUSTERED INDEX IDX_DBNAME_SurrogateKey_HFit_TrackerFruits ON dbo.FACT_TrackerData (TrackerName) INCLUDE (DBNAME , SurrogateKey_HFit_TrackerFruits) ;
        END;
    --GO
    EXEC PrintImmediate 'SurrogateKey_HFit_TrackerHbA1c';
    --GO
    IF NOT EXISTS (SELECT name
                     FROM sys.indexes
                     WHERE name = 'IDX_DBNAME_SurrogateKey_HFit_TrackerHbA1c') 
        BEGIN
            CREATE NONCLUSTERED INDEX IDX_DBNAME_SurrogateKey_HFit_TrackerHbA1c ON dbo.FACT_TrackerData (TrackerName) INCLUDE (DBNAME , SurrogateKey_HFit_TrackerHbA1c) ;
        END;
    --GO
    EXEC PrintImmediate 'SurrogateKey_HFit_TrackerHeight';
    --GO
    IF NOT EXISTS (SELECT name
                     FROM sys.indexes
                     WHERE name = 'IDX_DBNAME_SurrogateKey_HFit_TrackerHeight') 
        BEGIN
            CREATE NONCLUSTERED INDEX IDX_DBNAME_SurrogateKey_HFit_TrackerHeight ON dbo.FACT_TrackerData (TrackerName) INCLUDE (DBNAME , SurrogateKey_HFit_TrackerHeight) ;
        END;
    --GO
    EXEC PrintImmediate 'SurrogateKey_HFit_TrackerHighFatFoods';
    --GO
    IF NOT EXISTS (SELECT name
                     FROM sys.indexes
                     WHERE name = 'IDX_DBNAME_SurrogateKey_HFit_TrackerHighFatFoods') 
        BEGIN
            CREATE NONCLUSTERED INDEX IDX_DBNAME_SurrogateKey_HFit_TrackerHighFatFoods ON dbo.FACT_TrackerData (TrackerName) INCLUDE (DBNAME , SurrogateKey_HFit_TrackerHighFatFoods) ;
        END;
    --GO
    EXEC PrintImmediate 'SurrogateKey_HFit_TrackerHighSodiumFoods';
    --GO
    IF NOT EXISTS (SELECT name
                     FROM sys.indexes
                     WHERE name = 'IDX_DBNAME_SurrogateKey_HFit_TrackerHighSodiumFoods') 
        BEGIN
            CREATE NONCLUSTERED INDEX IDX_DBNAME_SurrogateKey_HFit_TrackerHighSodiumFoods ON dbo.FACT_TrackerData (TrackerName) INCLUDE (DBNAME , SurrogateKey_HFit_TrackerHighSodiumFoods) ;
        END;
    --GO
    EXEC PrintImmediate 'SurrogateKey_HFit_TrackerInstance_Tracker';
    --GO
    IF NOT EXISTS (SELECT name
                     FROM sys.indexes
                     WHERE name = 'IDX_DBNAME_SurrogateKey_HFit_TrackerInstance_Tracker') 
        BEGIN
            CREATE NONCLUSTERED INDEX IDX_DBNAME_SurrogateKey_HFit_TrackerInstance_Tracker ON dbo.FACT_TrackerData (TrackerName) INCLUDE (DBNAME , SurrogateKey_HFit_TrackerInstance_Tracker) ;
        END;
    --GO
    EXEC PrintImmediate 'SurrogateKey_HFit_TrackerMealPortions';
    --GO
    IF NOT EXISTS (SELECT name
                     FROM sys.indexes
                     WHERE name = 'IDX_DBNAME_SurrogateKey_HFit_TrackerMealPortions') 
        BEGIN
            CREATE NONCLUSTERED INDEX IDX_DBNAME_SurrogateKey_HFit_TrackerMealPortions ON dbo.FACT_TrackerData (TrackerName) INCLUDE (DBNAME , SurrogateKey_HFit_TrackerMealPortions) ;
        END;
    --GO
    EXEC PrintImmediate 'SurrogateKey_HFit_TrackerMedicalCarePlan';
    --GO
    IF NOT EXISTS (SELECT name
                     FROM sys.indexes
                     WHERE name = 'IDX_DBNAME_SurrogateKey_HFit_TrackerMedicalCarePlan') 
        BEGIN
            CREATE NONCLUSTERED INDEX IDX_DBNAME_SurrogateKey_HFit_TrackerMedicalCarePlan ON dbo.FACT_TrackerData (TrackerName) INCLUDE (DBNAME , SurrogateKey_HFit_TrackerMedicalCarePlan) ;
        END;
    --GO
    EXEC PrintImmediate 'SurrogateKey_HFit_TrackerPreventiveCare';
    --GO
    IF NOT EXISTS (SELECT name
                     FROM sys.indexes
                     WHERE name = 'IDX_DBNAME_SurrogateKey_HFit_TrackerPreventiveCare') 
        BEGIN
            CREATE NONCLUSTERED INDEX IDX_DBNAME_SurrogateKey_HFit_TrackerPreventiveCare ON dbo.FACT_TrackerData (TrackerName) INCLUDE (DBNAME , SurrogateKey_HFit_TrackerPreventiveCare) ;
        END;
    --GO
    EXEC PrintImmediate 'SurrogateKey_HFit_TrackerRegularMeals';
    --GO
    IF NOT EXISTS (SELECT name
                     FROM sys.indexes
                     WHERE name = 'IDX_DBNAME_SurrogateKey_HFit_TrackerRegularMeals') 
        BEGIN
            CREATE NONCLUSTERED INDEX IDX_DBNAME_SurrogateKey_HFit_TrackerRegularMeals ON dbo.FACT_TrackerData (TrackerName) INCLUDE (DBNAME , SurrogateKey_HFit_TrackerRegularMeals) ;
        END;
    --GO
    EXEC PrintImmediate 'SurrogateKey_HFit_TrackerRestingHeartRate';
    --GO
    IF NOT EXISTS (SELECT name
                     FROM sys.indexes
                     WHERE name = 'IDX_DBNAME_SurrogateKey_HFit_TrackerRestingHeartRate') 
        BEGIN
            CREATE NONCLUSTERED INDEX IDX_DBNAME_SurrogateKey_HFit_TrackerRestingHeartRate ON dbo.FACT_TrackerData (TrackerName) INCLUDE (DBNAME , SurrogateKey_HFit_TrackerRestingHeartRate) ;
        END;
    --GO
    EXEC PrintImmediate 'SurrogateKey_HFit_TrackerShots';
    --GO
    IF NOT EXISTS (SELECT name
                     FROM sys.indexes
                     WHERE name = 'IDX_DBNAME_SurrogateKey_HFit_TrackerShots') 
        BEGIN
            CREATE NONCLUSTERED INDEX IDX_DBNAME_SurrogateKey_HFit_TrackerShots ON dbo.FACT_TrackerData (TrackerName) INCLUDE (DBNAME , SurrogateKey_HFit_TrackerShots) ;
        END;
    --GO
    EXEC PrintImmediate 'SurrogateKey_HFit_TrackerSitLess';
    --GO
    IF NOT EXISTS (SELECT name
                     FROM sys.indexes
                     WHERE name = 'IDX_DBNAME_SurrogateKey_HFit_TrackerSitLess') 
        BEGIN
            CREATE NONCLUSTERED INDEX IDX_DBNAME_SurrogateKey_HFit_TrackerSitLess ON dbo.FACT_TrackerData (TrackerName) INCLUDE (DBNAME , SurrogateKey_HFit_TrackerSitLess) ;
        END;
    --GO
    EXEC PrintImmediate 'SurrogateKey_HFit_TrackerSleepPlan';
    --GO
    IF NOT EXISTS (SELECT name
                     FROM sys.indexes
                     WHERE name = 'IDX_DBNAME_SurrogateKey_HFit_TrackerSleepPlan') 
        BEGIN
            CREATE NONCLUSTERED INDEX IDX_DBNAME_SurrogateKey_HFit_TrackerSleepPlan ON dbo.FACT_TrackerData (TrackerName) INCLUDE (DBNAME , SurrogateKey_HFit_TrackerSleepPlan) ;
        END;
    --GO
    EXEC PrintImmediate 'SurrogateKey_HFit_TrackerStrength';
    --GO
    IF NOT EXISTS (SELECT name
                     FROM sys.indexes
                     WHERE name = 'IDX_DBNAME_SurrogateKey_HFit_TrackerStrength') 
        BEGIN
            CREATE NONCLUSTERED INDEX IDX_DBNAME_SurrogateKey_HFit_TrackerStrength ON dbo.FACT_TrackerData (TrackerName) INCLUDE (DBNAME , SurrogateKey_HFit_TrackerStrength) ;
        END;
    --GO
    EXEC PrintImmediate 'SurrogateKey_HFit_TrackerStress';
    --GO
    IF NOT EXISTS (SELECT name
                     FROM sys.indexes
                     WHERE name = 'IDX_DBNAME_SurrogateKey_HFit_TrackerStress') 
        BEGIN
            CREATE NONCLUSTERED INDEX IDX_DBNAME_SurrogateKey_HFit_TrackerStress ON dbo.FACT_TrackerData (TrackerName) INCLUDE (DBNAME , SurrogateKey_HFit_TrackerStress) ;
        END;
    --GO
    EXEC PrintImmediate 'SurrogateKey_HFit_TrackerStressManagement';
    --GO
    IF NOT EXISTS (SELECT name
                     FROM sys.indexes
                     WHERE name = 'IDX_DBNAME_SurrogateKey_HFit_TrackerStressManagement') 
        BEGIN
            CREATE NONCLUSTERED INDEX IDX_DBNAME_SurrogateKey_HFit_TrackerStressManagement ON dbo.FACT_TrackerData (TrackerName) INCLUDE (DBNAME , SurrogateKey_HFit_TrackerStressManagement) ;
        END;
    --GO
    EXEC PrintImmediate 'SurrogateKey_HFit_TrackerSugaryDrinks';
    --GO
    IF NOT EXISTS (SELECT name
                     FROM sys.indexes
                     WHERE name = 'IDX_DBNAME_SurrogateKey_HFit_TrackerSugaryDrinks') 
        BEGIN
            CREATE NONCLUSTERED INDEX IDX_DBNAME_SurrogateKey_HFit_TrackerSugaryDrinks ON dbo.FACT_TrackerData (TrackerName) INCLUDE (DBNAME , SurrogateKey_HFit_TrackerSugaryDrinks) ;
        END;
    --GO
    EXEC PrintImmediate 'SurrogateKey_HFit_TrackerSugaryFoods';
    --GO
    IF NOT EXISTS (SELECT name
                     FROM sys.indexes
                     WHERE name = 'IDX_DBNAME_SurrogateKey_HFit_TrackerSugaryFoods') 
        BEGIN
            CREATE NONCLUSTERED INDEX IDX_DBNAME_SurrogateKey_HFit_TrackerSugaryFoods ON dbo.FACT_TrackerData (TrackerName) INCLUDE (DBNAME , SurrogateKey_HFit_TrackerSugaryFoods) ;
        END;
    --GO
    EXEC PrintImmediate 'SurrogateKey_HFit_TrackerTests';
    --GO
    IF NOT EXISTS (SELECT name
                     FROM sys.indexes
                     WHERE name = 'IDX_DBNAME_SurrogateKey_HFit_TrackerTests') 
        BEGIN
            CREATE NONCLUSTERED INDEX IDX_DBNAME_SurrogateKey_HFit_TrackerTests ON dbo.FACT_TrackerData (TrackerName) INCLUDE (DBNAME , SurrogateKey_HFit_TrackerTests) ;
        END;
    --GO
    EXEC PrintImmediate 'SurrogateKey_HFit_TrackerTobaccoAttestation';
    --GO
    IF NOT EXISTS (SELECT name
                     FROM sys.indexes
                     WHERE name = 'IDX_DBNAME_SurrogateKey_HFit_TrackerTobaccoAttestation') 
        BEGIN
            CREATE NONCLUSTERED INDEX IDX_DBNAME_SurrogateKey_HFit_TrackerTobaccoAttestation ON dbo.FACT_TrackerData (TrackerName) INCLUDE (DBNAME , SurrogateKey_HFit_TrackerTobaccoAttestation) ;
        END;
    --GO
    EXEC PrintImmediate 'SurrogateKey_HFit_TrackerTobaccoFree';
    --GO
    IF NOT EXISTS (SELECT name
                     FROM sys.indexes
                     WHERE name = 'IDX_DBNAME_SurrogateKey_HFit_TrackerTobaccoFree') 
        BEGIN
            CREATE NONCLUSTERED INDEX IDX_DBNAME_SurrogateKey_HFit_TrackerTobaccoFree ON dbo.FACT_TrackerData (TrackerName) INCLUDE (DBNAME , SurrogateKey_HFit_TrackerTobaccoFree) ;
        END;
    --GO
    EXEC PrintImmediate 'SurrogateKey_HFit_TrackerVegetables';
    --GO
    IF NOT EXISTS (SELECT name
                     FROM sys.indexes
                     WHERE name = 'IDX_DBNAME_SurrogateKey_HFit_TrackerVegetables') 
        BEGIN
            CREATE NONCLUSTERED INDEX IDX_DBNAME_SurrogateKey_HFit_TrackerVegetables ON dbo.FACT_TrackerData (TrackerName) INCLUDE (DBNAME , SurrogateKey_HFit_TrackerVegetables) ;
        END;
    --GO
    EXEC PrintImmediate 'SurrogateKey_HFit_TrackerWater';
    --GO
    IF NOT EXISTS (SELECT name
                     FROM sys.indexes
                     WHERE name = 'IDX_DBNAME_SurrogateKey_HFit_TrackerWater') 
        BEGIN
            CREATE NONCLUSTERED INDEX IDX_DBNAME_SurrogateKey_HFit_TrackerWater ON dbo.FACT_TrackerData (TrackerName) INCLUDE (DBNAME , SurrogateKey_HFit_TrackerWater) ;
        END;
    --GO
    EXEC PrintImmediate 'SurrogateKey_HFit_TrackerWeight';
    --GO
    IF NOT EXISTS (SELECT name
                     FROM sys.indexes
                     WHERE name = 'IDX_DBNAME_SurrogateKey_HFit_TrackerWeight') 
        BEGIN
            CREATE NONCLUSTERED INDEX IDX_DBNAME_SurrogateKey_HFit_TrackerWeight ON dbo.FACT_TrackerData (TrackerName) INCLUDE (DBNAME , SurrogateKey_HFit_TrackerWeight) ;
        END;
    --GO
    EXEC PrintImmediate 'SurrogateKey_HFit_TrackerWholeGrains';
    --GO
    IF NOT EXISTS (SELECT name
                     FROM sys.indexes
                     WHERE name = 'IDX_DBNAME_SurrogateKey_HFit_TrackerWholeGrains') 
        BEGIN
            CREATE NONCLUSTERED INDEX IDX_DBNAME_SurrogateKey_HFit_TrackerWholeGrains ON dbo.FACT_TrackerData (TrackerName) INCLUDE (DBNAME , SurrogateKey_HFit_TrackerWholeGrains) ;
        END;
END;
--GO

GO
PRINT 'Created proc_VerifyIndexes';
GO