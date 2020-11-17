IF EXISTS (SELECT
                  name
                  FROM sys.indexes
                  WHERE name = ' idx_HFit_TrackerFlexibility_CreateDate') 
    BEGIN
        DROP INDEX idx_HFit_TrackerFlexibility_CreateDate ON dbo.HFit_TrackerFlexibility
    END; -- ([ItemCreatedWhen], [ItemModifiedWhen])
GO
IF EXISTS (SELECT
                  name
                  FROM sys.indexes
                  WHERE name = ' PI_HFit_TrackerFlexibility_LastUpdate') 
    BEGIN
        DROP INDEX PI_HFit_TrackerFlexibility_LastUpdate ON dbo.HFit_TrackerFlexibility
    END; -- ([ItemCreatedWhen], [ItemModifiedWhen])
GO
IF EXISTS (SELECT
                  name
                  FROM sys.indexes
                  WHERE name = ' PI_HFit_TrackerMedicalCarePlan_LastUpdate') 
    BEGIN
        DROP INDEX PI_HFit_TrackerMedicalCarePlan_LastUpdate ON dbo.HFit_TrackerFlexibility
    END; -- ([ItemCreatedWhen], [ItemModifiedWhen])
GO
IF EXISTS (SELECT
                  name
                  FROM sys.indexes
                  WHERE name = ' PI_HFit_TrackerRegularMeals_LastUpdate') 
    BEGIN
        DROP INDEX PI_HFit_TrackerRegularMeals_LastUpdate ON dbo.HFit_TrackerFlexibility
    END; -- ([ItemCreatedWhen], [ItemModifiedWhen])
GO
IF EXISTS (SELECT
                  name
                  FROM sys.indexes
                  WHERE name = ' PI_HFit_TrackerRestingHeartRate_LastUpdate') 
    BEGIN
        DROP INDEX PI_HFit_TrackerRestingHeartRate_LastUpdate ON dbo.HFit_TrackerFlexibility
    END; -- ([ItemCreatedWhen], [ItemModifiedWhen])
GO
IF EXISTS (SELECT
                  name
                  FROM sys.indexes
                  WHERE name = ' PI_HFit_TrackerShots_LastUpdate') 
    BEGIN
        DROP INDEX PI_HFit_TrackerShots_LastUpdate ON dbo.HFit_TrackerFlexibility
    END; -- ([ItemCreatedWhen], [ItemModifiedWhen])
GO
IF EXISTS (SELECT
                  name
                  FROM sys.indexes
                  WHERE name = ' PI_HFit_TrackerSitLess_LastUpdate') 
    BEGIN
        DROP INDEX PI_HFit_TrackerSitLess_LastUpdate ON dbo.HFit_TrackerFlexibility
    END; -- ([ItemCreatedWhen], [ItemModifiedWhen])
GO
IF EXISTS (SELECT
                  name
                  FROM sys.indexes
                  WHERE name = ' PI_HFit_TrackerSleepPlan_LastUpdate') 
    BEGIN
        DROP INDEX PI_HFit_TrackerSleepPlan_LastUpdate ON dbo.HFit_TrackerFlexibility
    END; -- ([ItemCreatedWhen], [ItemModifiedWhen])
GO
IF EXISTS (SELECT
                  name
                  FROM sys.indexes
                  WHERE name = ' PI_HFit_TrackerStrength_LastUpdate') 
    BEGIN
        DROP INDEX PI_HFit_TrackerStrength_LastUpdate ON dbo.HFit_TrackerFlexibility
    END; -- ([ItemCreatedWhen], [ItemModifiedWhen])
GO
IF EXISTS (SELECT
                  name
                  FROM sys.indexes
                  WHERE name = ' PI_HFit_TrackerStress_LastUpdate') 
    BEGIN
        DROP INDEX PI_HFit_TrackerStress_LastUpdate ON dbo.HFit_TrackerFlexibility
    END; -- ([ItemCreatedWhen], [ItemModifiedWhen])
GO
IF EXISTS (SELECT
                  name
                  FROM sys.indexes
                  WHERE name = ' PI_HFit_TrackerStressManagement_LastUpdate') 
    BEGIN
        DROP INDEX PI_HFit_TrackerStressManagement_LastUpdate ON dbo.HFit_TrackerFlexibility
    END; -- ([ItemCreatedWhen], [ItemModifiedWhen])
GO
IF EXISTS (SELECT
                  name
                  FROM sys.indexes
                  WHERE name = ' PI_HFit_TrackerSugaryDrinks_LastUpdate') 
    BEGIN
        DROP INDEX PI_HFit_TrackerSugaryDrinks_LastUpdate ON dbo.HFit_TrackerFlexibility
    END; -- ([ItemCreatedWhen], [ItemModifiedWhen])
GO
IF EXISTS (SELECT
                  name
                  FROM sys.indexes
                  WHERE name = ' PI_HFit_TrackerSugaryFoods_LastUpdate') 
    BEGIN
        DROP INDEX PI_HFit_TrackerSugaryFoods_LastUpdate ON dbo.HFit_TrackerFlexibility
    END; -- ([ItemCreatedWhen], [ItemModifiedWhen])
GO
IF EXISTS (SELECT
                  name
                  FROM sys.indexes
                  WHERE name = ' PI_HFit_TrackerSummary_LastUpdate') 
    BEGIN
        DROP INDEX PI_HFit_TrackerSummary_LastUpdate ON dbo.HFit_TrackerFlexibility
    END; -- ([ItemCreatedWhen], [ItemModifiedWhen])
GO
IF EXISTS (SELECT
                  name
                  FROM sys.indexes
                  WHERE name = ' PI_HFit_TrackerTests_LastUpdate') 
    BEGIN
        DROP INDEX PI_HFit_TrackerTests_LastUpdate ON dbo.HFit_TrackerFlexibility
    END; -- ([ItemCreatedWhen], [ItemModifiedWhen])
GO
IF EXISTS (SELECT
                  name
                  FROM sys.indexes
                  WHERE name = ' PI_HFit_TrackerTobaccoFree_LastUpdate') 
    BEGIN
        DROP INDEX PI_HFit_TrackerTobaccoFree_LastUpdate ON dbo.HFit_TrackerFlexibility
    END; -- ([ItemCreatedWhen], [ItemModifiedWhen])
GO
IF EXISTS (SELECT
                  name
                  FROM sys.indexes
                  WHERE name = ' PI_HFit_TrackerVegetables_LastUpdate') 
    BEGIN
        DROP INDEX PI_HFit_TrackerVegetables_LastUpdate ON dbo.HFit_TrackerFlexibility
    END; -- ([ItemCreatedWhen], [ItemModifiedWhen])
GO
IF EXISTS (SELECT
                  name
                  FROM sys.indexes
                  WHERE name = ' PI_HFit_TrackerWater_LastUpdate') 
    BEGIN
        DROP INDEX PI_HFit_TrackerWater_LastUpdate ON dbo.HFit_TrackerFlexibility
    END; -- ([ItemCreatedWhen], [ItemModifiedWhen])
GO
IF EXISTS (SELECT
                  name
                  FROM sys.indexes
                  WHERE name = ' PI_HFit_TrackerWeight_LastUpdate') 
    BEGIN
        DROP INDEX PI_HFit_TrackerWeight_LastUpdate ON dbo.HFit_TrackerFlexibility
    END; -- ([ItemCreatedWhen], [ItemModifiedWhen])
GO
IF EXISTS (SELECT
                  name
                  FROM sys.indexes
                  WHERE name = ' PI_HFit_TrackerWholeGrains_LastUpdate') 
    BEGIN
        DROP INDEX PI_HFit_TrackerWholeGrains_LastUpdate ON dbo.HFit_TrackerFlexibility -- ([ItemCreatedWhen], [ItemModifiedWhen])Nixon, Yesterday 7:09 PM

    END;