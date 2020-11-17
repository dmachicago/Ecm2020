
select 'exec proc_SetStdColsTracker ' + table_name + ';' + char(10) + 'GO' from information_schema.tables 
where table_name like  'FACT_HFit_Tracker%'

/*
 exec proc_SetStdColsTracker FACT_HFit_TrackerBloodPressure;
GO
exec proc_SetStdColsTracker FACT_HFit_TrackerBloodSugarAndGlucose;
GO
exec proc_SetStdColsTracker FACT_HFit_TrackerBMI;
GO
exec proc_SetStdColsTracker FACT_HFit_TrackerBodyFat;
GO
exec proc_SetStdColsTracker FACT_HFit_TrackerBodyMeasurements;
GO
exec proc_SetStdColsTracker FACT_HFit_TrackerCardio;
GO
exec proc_SetStdColsTracker FACT_HFit_TrackerCholesterol;
GO
exec proc_SetStdColsTracker FACT_HFit_TrackerCotinine;
GO
exec proc_SetStdColsTracker FACT_HFit_TrackerDailySteps;
GO
exec proc_SetStdColsTracker FACT_HFit_TrackerFlexibility;
GO
exec proc_SetStdColsTracker FACT_HFit_TrackerFruits;
GO
exec proc_SetStdColsTracker FACT_HFit_TrackerHbA1c;
GO
exec proc_SetStdColsTracker FACT_HFit_TrackerHeight;
GO
exec proc_SetStdColsTracker FACT_HFit_TrackerHighFatFoods;
GO
exec proc_SetStdColsTracker FACT_HFit_TrackerHighSodiumFoods;
GO
exec proc_SetStdColsTracker FACT_HFit_TrackerInstance_Tracker;
GO
exec proc_SetStdColsTracker FACT_HFit_TrackerMealPortions;
GO
exec proc_SetStdColsTracker FACT_HFit_TrackerMedicalCarePlan;
GO
exec proc_SetStdColsTracker FACT_HFit_TrackerPreventiveCare;
GO
exec proc_SetStdColsTracker FACT_HFit_TrackerRegularMeals;
GO
exec proc_SetStdColsTracker FACT_HFit_TrackerRestingHeartRate;
GO
exec proc_SetStdColsTracker FACT_HFit_TrackerShots;
GO
exec proc_SetStdColsTracker FACT_HFit_TrackerSitLess;
GO
exec proc_SetStdColsTracker FACT_HFit_TrackerSleepPlan;
GO
exec proc_SetStdColsTracker FACT_HFit_TrackerStrength;
GO
exec proc_SetStdColsTracker FACT_HFit_TrackerStress;
GO
exec proc_SetStdColsTracker FACT_HFit_TrackerStressManagement;
GO
exec proc_SetStdColsTracker FACT_HFit_TrackerSugaryDrinks;
GO
exec proc_SetStdColsTracker FACT_HFit_TrackerSugaryFoods;
GO
exec proc_SetStdColsTracker FACT_HFit_TrackerTobaccoAttestation;
GO
exec proc_SetStdColsTracker FACT_HFit_TrackerTobaccoFree;
GO
exec proc_SetStdColsTracker FACT_HFit_TrackerVegetables;
GO
exec proc_SetStdColsTracker FACT_HFit_TrackerWater;
GO
exec proc_SetStdColsTracker FACT_HFit_TrackerWeight;
GO
exec proc_SetStdColsTracker FACT_HFit_TrackerWholeGrains;
GO

*/
-- drop procedure proc_SetStdColsTracker 
CREATE PROCEDURE proc_SetStdColsTracker (
       @TblName AS NVARCHAR (100)) 
AS
BEGIN
    DECLARE @MySql AS NVARCHAR (2000) = ' ';
    SET @MySQl = 'alter table ' + @TblName + ' alter column [AggregateTableName] [nvarchar](100) NOT NULL';
    EXEC PrintImmediate @MySql;
    EXEC (@MySql) ;
    SET @MySQl = 'alter table ' + @TblName + ' alter column [CollectionSourceName_Internal] [nvarchar](100) NULL';
    EXEC PrintImmediate @MySql;
    EXEC (@MySql) ;
    SET @MySQl = 'alter table ' + @TblName + ' alter column [CollectionSourceName_External] [nvarchar](100) NULL';
    EXEC PrintImmediate @MySql;
    EXEC (@MySql) ;
    SET @MySQl = 'alter table ' + @TblName + ' alter column [EventName] [nvarchar](100) NULL';
    EXEC PrintImmediate @MySql;
    EXEC (@MySql) ;
    SET @MySQl = 'alter table ' + @TblName + ' alter column [UOM] [nvarchar](100) NULL';
    EXEC PrintImmediate @MySql;
    EXEC (@MySql) ;
    SET @MySQl = 'alter table ' + @TblName + ' alter column [KEY1] [nvarchar](100) NULL';
    EXEC PrintImmediate @MySql;
    EXEC (@MySql) ;
    SET @MySQl = 'alter table ' + @TblName + ' alter column [KEY2] [nvarchar](100) NULL';
    EXEC PrintImmediate @MySql;
    EXEC (@MySql) ;
    SET @MySQl = 'alter table ' + @TblName + ' alter column [KEY3] [nvarchar](100) NULL';
    EXEC PrintImmediate @MySql;
    EXEC (@MySql) ;
    SET @MySQl = 'alter table ' + @TblName + ' alter column [KEY4] [nvarchar](100) NULL';
    EXEC PrintImmediate @MySql;
    EXEC (@MySql) ;
    SET @MySQl = 'alter table ' + @TblName + ' alter column [KEY5] [nvarchar](100) NULL';
    EXEC PrintImmediate @MySql;
    EXEC (@MySql) ;
    SET @MySQl = 'alter table ' + @TblName + ' alter column [KEY6] [nvarchar](100) NULL';
    EXEC PrintImmediate @MySql;
    EXEC (@MySql) ;
    SET @MySQl = 'alter table ' + @TblName + ' alter column [KEY7] [nvarchar](100) NULL';
    EXEC PrintImmediate @MySql;
    EXEC (@MySql) ;
    SET @MySQl = 'alter table ' + @TblName + ' alter column [KEY8] [nvarchar](100) NULL';
    EXEC PrintImmediate @MySql;
    EXEC (@MySql) ;
    SET @MySQl = 'alter table ' + @TblName + ' alter column [KEY9] [nvarchar](100) NULL';
    EXEC PrintImmediate @MySql;
    EXEC (@MySql) ;
    SET @MySQl = 'alter table ' + @TblName + ' alter column [KEY10] [nvarchar](100) NULL';
    EXEC PrintImmediate @MySql;
    EXEC (@MySql) ;
    SET @MySQl = 'alter table ' + @TblName + ' alter column [TXTKEY1] [nvarchar](100) NULL';
    EXEC PrintImmediate @MySql;
    EXEC (@MySql) ;
    SET @MySQl = 'alter table ' + @TblName + ' alter column [TXTKEY2] [nvarchar](100) NULL';
    EXEC PrintImmediate @MySql;
    EXEC (@MySql) ;
    SET @MySQl = 'alter table ' + @TblName + ' alter column [TXTKEY3] [nvarchar](100) NULL';
    EXEC PrintImmediate @MySql;
    EXEC (@MySql) ;
    SET @MySQl = 'alter table ' + @TblName + ' alter column [MPI] [nvarchar](100) NULL';
    EXEC PrintImmediate @MySql;
    EXEC (@MySql) ;
    SET @MySQl = 'alter table ' + @TblName + ' alter column [ClientCode] [nvarchar](100) NULL';
    EXEC PrintImmediate @MySql;
    EXEC (@MySql) ;
    SET @MySQl = 'alter table ' + @TblName + ' alter column [AccountCD] [nvarchar](100) NULL';
    EXEC PrintImmediate @MySql;
    EXEC (@MySql) ;
    SET @MySQl = 'alter table ' + @TblName + ' alter column [UniqueName] [nvarchar](100) NULL';
    EXEC PrintImmediate @MySql;
    EXEC (@MySql) ;
    SET @MySQl = 'alter table ' + @TblName + ' alter column [ColDesc] [nvarchar](100) NULL';
    EXEC PrintImmediate @MySql;
    EXEC (@MySql) ;
    SET @MySQl = 'alter table ' + @TblName + ' alter column [SVR] [nvarchar](100) NOT NULL';
    EXEC PrintImmediate @MySql;
    EXEC (@MySql) ;
    SET @MySQl = 'alter table ' + @TblName + ' alter column [DBNAME] [nvarchar](100) NOT NULL';
    EXEC PrintImmediate @MySql;
    EXEC (@MySql) ;
    SET @MySQl = 'alter table ' + @TblName + ' add [RowNumber] [int] IDENTITY(1,1) NOT NULL';
    EXEC PrintImmediate @MySql;
    EXEC (@MySql) ;
    EXEC PrintImmediate 'DONE....' ;
END;