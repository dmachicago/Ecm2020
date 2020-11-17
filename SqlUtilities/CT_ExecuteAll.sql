

create PROCEDURE CT_RUN_ALL
AS
BEGIN
    -- exec FindAllRunningJobs
    -- exec dbo.FindFailedJobs
    
    BEGIN TRY
        EXEC msdb..sp_update_job @job_name = N'DBAPlatform - Daily Snapshot of Databases', @enabled = 0;
	   PRINT 'NOTICE DBAPlatform - Daily Snapshot of Databases disabled...';
    END TRY
    BEGIN CATCH
        PRINT 'NOTICE DBAPlatform - Daily Snapshot of Databases may already be disabled...';
    END CATCH;
    --BEGIN TRY
    --    EXEC msdb..sp_update_job @job_name = N'NightlyBackups', @enabled = 0;
    --END TRY
    --BEGIN CATCH
    --    PRINT 'NOTICE NightlyBackups may already be disabled...';
    --END CATCH;
    BEGIN TRY
        EXEC msdb..sp_update_job @job_name = N'DBAPlatform - RefreshKenticoCMS_1', @enabled = 0;
	   PRINT 'NOTICE DBAPlatform - RefreshKenticoCMS_1 disabled...';
    END TRY
    BEGIN CATCH
        PRINT 'NOTICE DBAPlatform - RefreshKenticoCMS_1 may already be disabled...';
    END CATCH;
    BEGIN TRY
        EXEC msdb..sp_update_job @job_name = N'DBAPlatform - RefreshKenticoCMS_2', @enabled = 0;
	   PRINT 'NOTICE DBAPlatform - RefreshKenticoCMS_2 disabled...';
    END TRY
    BEGIN CATCH
        PRINT 'NOTICE DBAPlatform - RefreshKenticoCMS_2 may already be disabled...';
    END CATCH;
    BEGIN TRY
        EXEC msdb..sp_update_job @job_name = N'DBAPlatform - RefreshKenticoCMS_3', @enabled = 0;
	   PRINT 'NOTICE DBAPlatform - RefreshKenticoCMS_3 disabled...';
    END TRY
    BEGIN CATCH
        PRINT 'NOTICE DBAPlatform - RefreshKenticoCMS_3 may already be disabled...';
    END CATCH;
    BEGIN TRY
        EXEC msdb..sp_update_job @job_name = N'instrument_disasterRecovery - backup_database_local_daily_full', @enabled = 0;
	   PRINT 'NOTICE instrument_disasterRecovery - backup_database_local_daily_full disabled...';
    END TRY
    BEGIN CATCH
        PRINT 'NOTICE instrument_disasterRecovery - backup_database_local_daily_full may already be disabled...';
    END CATCH;
    BEGIN TRY
        EXEC msdb..sp_update_job @job_name = N'instrument_disasterRecovery - backup_database_local_hourly_tran', @enabled = 0;
	   PRINT 'NOTICE instrument_disasterRecovery - backup_database_local_hourly_tran disabled...';
    END TRY
    BEGIN CATCH
        PRINT 'NOTICE instrument_disasterRecovery - backup_database_local_hourly_tran may already be disabled...';
    END CATCH;
    
    EXEC KillAllOrphans 'KenticoCMS_1', 'HFit_TrackerSugaryDrinks', 'N';
    EXEC KillAllOrphans 'KenticoCMS_1', 'HFit_TrackerSugaryFoods', 'N';
    EXEC KillAllOrphans 'KenticoCMS_1', 'HFit_TrackerSummary', 'N';
    EXEC KillAllOrphans 'KenticoCMS_1', 'HFit_TrackerTests', 'N';
    EXEC KillAllOrphans 'KenticoCMS_1', 'HFit_TrackerTobaccoAttestation', 'N';
    EXEC KillAllOrphans 'KenticoCMS_1', 'HFit_TrackerTobaccoFree', 'N';
    EXEC KillAllOrphans 'KenticoCMS_1', 'HFit_TrackerVegetables', 'N';
    EXEC KillAllOrphans 'KenticoCMS_1', 'HFit_TrackerWater', 'N';
    EXEC KillAllOrphans 'KenticoCMS_1', 'HFit_TrackerWeight', 'N';
    EXEC KillAllOrphans 'KenticoCMS_1', 'HFit_TrackerWholeGrains', 'N';
    EXEC KillAllOrphans 'KenticoCMS_1', 'HFit_TrackerBloodSugarAndGlucose', 'N';
    EXEC KillAllOrphans 'KenticoCMS_1', 'HFit_TrackerBMI', 'N';
    EXEC KillAllOrphans 'KenticoCMS_1', 'HFit_TrackerBodyFat', 'N';
    EXEC KillAllOrphans 'KenticoCMS_1', 'HFit_TrackerBodyMeasurements', 'N';
    EXEC KillAllOrphans 'KenticoCMS_1', 'HFit_TrackerCardio', 'N';
    EXEC KillAllOrphans 'KenticoCMS_1', 'HFit_TrackerCholesterol', 'N';
    EXEC KillAllOrphans 'KenticoCMS_1', 'HFit_TrackerCotinine', 'N';
    EXEC KillAllOrphans 'KenticoCMS_1', 'HFit_TrackerDailySteps', 'N';
    EXEC KillAllOrphans 'KenticoCMS_1', 'HFit_TrackerFlexibility', 'N';
    EXEC KillAllOrphans 'KenticoCMS_1', 'HFit_TrackerFruits', 'N';
    EXEC KillAllOrphans 'KenticoCMS_1', 'HFit_TrackerHbA1c', 'N';
    EXEC KillAllOrphans 'KenticoCMS_1', 'HFit_TrackerHeight', 'N';
    EXEC KillAllOrphans 'KenticoCMS_1', 'HFit_TrackerHighFatFoods', 'N';
    EXEC KillAllOrphans 'KenticoCMS_1', 'HFit_TrackerHighSodiumFoods', 'N';
    EXEC KillAllOrphans 'KenticoCMS_2', 'HFit_TrackerSugaryDrinks', 'N';
    EXEC KillAllOrphans 'KenticoCMS_2', 'HFit_TrackerSugaryFoods', 'N';
    EXEC KillAllOrphans 'KenticoCMS_2', 'HFit_TrackerSummary', 'N';
    EXEC KillAllOrphans 'KenticoCMS_2', 'HFit_TrackerTests', 'N';
    EXEC KillAllOrphans 'KenticoCMS_2', 'HFit_TrackerTobaccoAttestation', 'N';
    EXEC KillAllOrphans 'KenticoCMS_2', 'HFit_TrackerTobaccoFree', 'N';
    EXEC KillAllOrphans 'KenticoCMS_2', 'HFit_TrackerVegetables', 'N';
    EXEC KillAllOrphans 'KenticoCMS_2', 'HFit_TrackerWater', 'N';
    EXEC KillAllOrphans 'KenticoCMS_2', 'HFit_TrackerWeight', 'N';
    EXEC KillAllOrphans 'KenticoCMS_2', 'HFit_TrackerWholeGrains', 'N';
    EXEC KillAllOrphans 'KenticoCMS_2', 'HFit_TrackerBloodSugarAndGlucose', 'N';
    EXEC KillAllOrphans 'KenticoCMS_2', 'HFit_TrackerBMI', 'N';
    EXEC KillAllOrphans 'KenticoCMS_2', 'HFit_TrackerBodyFat', 'N';
    EXEC KillAllOrphans 'KenticoCMS_2', 'HFit_TrackerBodyMeasurements', 'N';
    EXEC KillAllOrphans 'KenticoCMS_2', 'HFit_TrackerCardio', 'N';
    EXEC KillAllOrphans 'KenticoCMS_2', 'HFit_TrackerCholesterol', 'N';
    EXEC KillAllOrphans 'KenticoCMS_2', 'HFit_TrackerCotinine', 'N';
    EXEC KillAllOrphans 'KenticoCMS_2', 'HFit_TrackerDailySteps', 'N';
    EXEC KillAllOrphans 'KenticoCMS_2', 'HFit_TrackerFlexibility', 'N';
    EXEC KillAllOrphans 'KenticoCMS_2', 'HFit_TrackerFruits', 'N';
    EXEC KillAllOrphans 'KenticoCMS_2', 'HFit_TrackerHbA1c', 'N';
    EXEC KillAllOrphans 'KenticoCMS_2', 'HFit_TrackerHeight', 'N';
    EXEC KillAllOrphans 'KenticoCMS_2', 'HFit_TrackerHighFatFoods', 'N';
    EXEC KillAllOrphans 'KenticoCMS_2', 'HFit_TrackerHighSodiumFoods', 'N';
    -- go
    DELETE i
      FROM KenticoCMS_2.dbo.HFit_TrackerInstance_Item i
      WHERE NOT EXISTS (SELECT 1
                          FROM KenticoCMS_2.dbo.HFit_TrackerInstance_Tracker t
                          WHERE t.ItemID = i.TrackerInstanceID) ;
    -- go
    ALTER TABLE KenticoCMS_2.dbo.HFit_TrackerInstance_Item NOCHECK CONSTRAINT ALL;
    -- go
    EXEC KillAllOrphans 'KenticoCMS_2', 'HFit_TrackerInstance_Tracker', 'N';
    -- go
    ALTER TABLE KenticoCMS_2.dbo.HFit_TrackerInstance_Item
            WITH CHECK CHECK CONSTRAINT ALL;
    -- go
    EXEC KillAllOrphans 'KenticoCMS_2', 'HFit_TrackerMealPortions', 'N';
    EXEC KillAllOrphans 'KenticoCMS_2', 'HFit_TrackerMedicalCarePlan', 'N';
    EXEC KillAllOrphans 'KenticoCMS_2', 'HFit_TrackerPreventiveCare', 'N';
    EXEC KillAllOrphans 'KenticoCMS_2', 'HFit_TrackerRegularMeals', 'N';
    EXEC KillAllOrphans 'KenticoCMS_2', 'HFit_TrackerRestingHeartRate', 'N';
    EXEC KillAllOrphans 'KenticoCMS_2', 'HFit_TrackerShots', 'N';
    EXEC KillAllOrphans 'KenticoCMS_2', 'HFit_TrackerSitLess', 'N';
    EXEC KillAllOrphans 'KenticoCMS_2', 'HFit_TrackerSleepPlan', 'N';
    EXEC KillAllOrphans 'KenticoCMS_2', 'HFit_TrackerStrength', 'N';
    EXEC KillAllOrphans 'KenticoCMS_2', 'HFit_TrackerStress', 'N';
    EXEC KillAllOrphans 'KenticoCMS_2', 'HFit_TrackerStressManagement', 'N';
    EXEC KillAllOrphans 'KenticoCMS_3', 'HFit_TrackerSugaryDrinks', 'N';
    EXEC KillAllOrphans 'KenticoCMS_3', 'HFit_TrackerSugaryFoods', 'N';
    EXEC KillAllOrphans 'KenticoCMS_3', 'HFit_TrackerSummary', 'N';
    EXEC KillAllOrphans 'KenticoCMS_3', 'HFit_TrackerTests', 'N';
    EXEC KillAllOrphans 'KenticoCMS_3', 'HFit_TrackerTobaccoAttestation', 'N';
    EXEC KillAllOrphans 'KenticoCMS_3', 'HFit_TrackerTobaccoFree', 'N';
    EXEC KillAllOrphans 'KenticoCMS_3', 'HFit_TrackerVegetables', 'N';
    EXEC KillAllOrphans 'KenticoCMS_3', 'HFit_TrackerWater', 'N';
    EXEC KillAllOrphans 'KenticoCMS_3', 'HFit_TrackerWeight', 'N';
    EXEC KillAllOrphans 'KenticoCMS_3', 'HFit_TrackerWholeGrains', 'N';
    EXEC KillAllOrphans 'KenticoCMS_3', 'HFit_TrackerBloodSugarAndGlucose', 'N';
    EXEC KillAllOrphans 'KenticoCMS_3', 'HFit_TrackerBMI', 'N';
    EXEC KillAllOrphans 'KenticoCMS_3', 'HFit_TrackerBodyFat', 'N';
    EXEC KillAllOrphans 'KenticoCMS_3', 'HFit_TrackerBodyMeasurements', 'N';
    EXEC KillAllOrphans 'KenticoCMS_3', 'HFit_TrackerCardio', 'N';
    EXEC KillAllOrphans 'KenticoCMS_3', 'HFit_TrackerCholesterol', 'N';
    EXEC KillAllOrphans 'KenticoCMS_3', 'HFit_TrackerCotinine', 'N';
    EXEC KillAllOrphans 'KenticoCMS_3', 'HFit_TrackerDailySteps', 'N';
    EXEC KillAllOrphans 'KenticoCMS_3', 'HFit_TrackerFlexibility', 'N';
    EXEC KillAllOrphans 'KenticoCMS_3', 'HFit_TrackerFruits', 'N';
    EXEC KillAllOrphans 'KenticoCMS_3', 'HFit_TrackerHbA1c', 'N';
    EXEC KillAllOrphans 'KenticoCMS_3', 'HFit_TrackerHeight', 'N';
    EXEC KillAllOrphans 'KenticoCMS_3', 'HFit_TrackerHighFatFoods', 'N';
    EXEC KillAllOrphans 'KenticoCMS_3', 'HFit_TrackerHighSodiumFoods', 'N';
    -- go
    DELETE i
      FROM KenticoCMS_3.dbo.HFit_TrackerInstance_Item i
      WHERE NOT EXISTS (SELECT 1
                          FROM KenticoCMS_3.dbo.HFit_TrackerInstance_Tracker t
                          WHERE t.ItemID = i.TrackerInstanceID) ;
    -- go
    ALTER TABLE KenticoCMS_3.dbo.HFit_TrackerInstance_Item NOCHECK CONSTRAINT ALL;
    -- go
    EXEC KillAllOrphans 'KenticoCMS_3', 'HFit_TrackerInstance_Tracker', 'N';
    -- go
    ALTER TABLE KenticoCMS_3.dbo.HFit_TrackerInstance_Item
            WITH CHECK CHECK CONSTRAINT ALL;
    -- go
    EXEC KillAllOrphans 'KenticoCMS_3', 'HFit_TrackerMealPortions', 'N';
    EXEC KillAllOrphans 'KenticoCMS_3', 'HFit_TrackerMedicalCarePlan', 'N';
    EXEC KillAllOrphans 'KenticoCMS_3', 'HFit_TrackerPreventiveCare', 'N';
    EXEC KillAllOrphans 'KenticoCMS_3', 'HFit_TrackerRegularMeals', 'N';
    EXEC KillAllOrphans 'KenticoCMS_3', 'HFit_TrackerRestingHeartRate', 'N';
    EXEC KillAllOrphans 'KenticoCMS_3', 'HFit_TrackerShots', 'N';
    EXEC KillAllOrphans 'KenticoCMS_3', 'HFit_TrackerSitLess', 'N';
    EXEC KillAllOrphans 'KenticoCMS_3', 'HFit_TrackerSleepPlan', 'N';
    EXEC KillAllOrphans 'KenticoCMS_3', 'HFit_TrackerStrength', 'N';
    EXEC KillAllOrphans 'KenticoCMS_3', 'HFit_TrackerStress', 'N';
    EXEC KillAllOrphans 'KenticoCMS_3', 'HFit_TrackerStressManagement', 'N';


    -- go
    DELETE i
      FROM KenticoCMS_1.dbo.HFit_TrackerInstance_Item i
      WHERE NOT EXISTS (SELECT 1
                          FROM KenticoCMS_1.dbo.HFit_TrackerInstance_Tracker t
                          WHERE t.ItemID = i.TrackerInstanceID) ;
    -- go
    ALTER TABLE KenticoCMS_1.dbo.HFit_TrackerInstance_Item NOCHECK CONSTRAINT ALL;
    -- go
    EXEC KillAllOrphans 'KenticoCMS_1', 'HFit_TrackerInstance_Tracker', 'N';
    -- go
    ALTER TABLE KenticoCMS_1.dbo.HFit_TrackerInstance_Item
            WITH CHECK CHECK CONSTRAINT ALL;
    -- go
    EXEC KillAllOrphans 'KenticoCMS_1', 'HFit_TrackerMealPortions', 'N';
    EXEC KillAllOrphans 'KenticoCMS_1', 'HFit_TrackerMedicalCarePlan', 'N';
    EXEC KillAllOrphans 'KenticoCMS_1', 'HFit_TrackerPreventiveCare', 'N';
    EXEC KillAllOrphans 'KenticoCMS_1', 'HFit_TrackerRegularMeals', 'N';
    EXEC KillAllOrphans 'KenticoCMS_1', 'HFit_TrackerRestingHeartRate', 'N';
    EXEC KillAllOrphans 'KenticoCMS_1', 'HFit_TrackerShots', 'N';
    EXEC KillAllOrphans 'KenticoCMS_1', 'HFit_TrackerSitLess', 'N';
    EXEC KillAllOrphans 'KenticoCMS_1', 'HFit_TrackerSleepPlan', 'N';
    EXEC KillAllOrphans 'KenticoCMS_1', 'HFit_TrackerStrength', 'N';
    EXEC KillAllOrphans 'KenticoCMS_1', 'HFit_TrackerStress', 'N';
    EXEC KillAllOrphans 'KenticoCMS_1', 'HFit_TrackerStressManagement', 'N';
    EXEC RunAllMARTJobs;
    -- go

    --WAITFOR DELAY '00:15'   --Wait 15 minutes

    BEGIN TRY
        EXEC msdb..sp_stop_job @job_name = 'instrument_disasterRecovery - backup_database_local_daily_full';
    END TRY
    BEGIN CATCH
        PRINT 'instrument_disasterRecovery not running at this time - ALL ok.';
    END CATCH;


END;
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
