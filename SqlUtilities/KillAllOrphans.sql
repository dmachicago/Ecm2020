
-- drop table OrphanUserIds
-- use DataMartPlatform
IF NOT EXISTS (SELECT name
                 FROM sys.tables
                 WHERE name = 'OrphanUserIds') 
    BEGIN
        CREATE TABLE OrphanUserIds (DBNAME nvarchar (100) NOT NULL , 
                                    TableName nvarchar (100) NOT NULL , 
                                    UserID int NOT NULL , 
                                    RowCreateDate datetime DEFAULT GETDATE ()) ;
    END;
IF NOT EXISTS (SELECT name
                 FROM sys.indexes
                 WHERE name = 'PI_OrphanUserIds') 
    BEGIN
        CREATE UNIQUE INDEX PI_OrphanUserIds ON OrphanUserIds (DBNAME , TableName , UserID) ;
    END;

GO
-- truncate table OrphanUserIds
-- select * from OrphanUserIds
IF EXISTS (SELECT name
             FROM sys.procedures
             WHERE name = 'KillAllOrphans') 
    BEGIN
        DROP PROCEDURE KillAllOrphans;
    END;
GO
-- exec KillAllOrphans 'KenticoCMS_1','HFit_TrackerTests', 'Y'
CREATE PROCEDURE KillAllOrphans (@DBNAME nvarchar (100) , 
                                 @TblName nvarchar (100) , 
                                 @PreviewOnly nvarchar (1) = 'Y') 
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE
          @MySql nvarchar (max) = '' , 
          @msg nvarchar (max) = '' , 
          @UserID int;


    SET @msg = 'Processing: ' + @DBNAME + '.dbo' + @TblName;
    EXEC PrintImmediate @msg;

    SET @MySql = @MySql + 'INSERT INTO DataMartPlatform.dbo.OrphanUserIds (DBNAME , ' + CHAR (10) ;
    SET @MySql = @MySql + '                                            TableName , ' + CHAR (10) ;
    SET @MySql = @MySql + '                                                UserID) ' + CHAR (10) ;
    SET @MySql = @MySql + 'SELECT DISTINCT ''' + @DBNAME + ''' , ' + CHAR (10) ;
    SET @MySql = @MySql + '                ''' + @TblName + ''' ,  ' + CHAR (10) ;
    SET @MySql = @MySql + '                UserID ' + CHAR (10) ;
    SET @MySql = @MySql + '  FROM ' + @DBNAME + '.dbo.' + @TblName + ' ' + CHAR (10) ;
    SET @MySql = @MySql + '  WHERE UserID NOT IN ( ' + CHAR (10) ;
    SET @MySql = @MySql + '                       SELECT UserID ' + CHAR (10) ;
    SET @MySql = @MySql + '                         FROM ' + @DBNAME + '.dbo.CMS_User) ' + CHAR (10) ;
    SET @MySql = @MySql + '    AND UserID NOT IN ( ' + CHAR (10) ;
    SET @MySql = @MySql + '                       SELECT UserID ' + CHAR (10) ;
    SET @MySql = @MySql + '                         FROM DataMartPlatform.dbo.OrphanUserIds ' + CHAR (10) ;
    SET @MySql = @MySql + '                         WHERE DBNAME = ''' + @DBNAME + '''' + CHAR (10) ;
    SET @MySql = @MySql + '                           AND TableName = ''' + @TblName + '''' + CHAR (10) ;
    SET @MySql = @MySql + '                           AND UserID = DataMartPlatform.dbo.OrphanUserIds.Userid) ; ' + CHAR (10) ;

    IF @PreviewOnly = 'Y'
        BEGIN
            PRINT @MySql;
        END;
    ELSE
        BEGIN EXEC (@MySql) ;
        END;

    SET @MySql = 'delete from ' + @DBNAME + '.dbo.' + @TblName + ' where UserID not in (Select UserID from ' + @DBNAME + '.dbo.CMS_User) ';
    IF @PreviewOnly = 'Y'
        BEGIN
            PRINT @MySql;
        END;
    ELSE
        BEGIN
            BEGIN TRY 
			 EXEC (@MySql) ;
            END TRY
            BEGIN CATCH
                RAISERROR (2500 , -1 , -1 , @MySql) ;
                PRINT 'ERROR: ' + @MySql;
            END CATCH;
            DECLARE
                  @i int = @@ROWCOUNT;
            IF @i > 0
                BEGIN
                    PRINT @DBNAME + '.dbo.' + @TblName + ': ' + CAST (@i AS nvarchar (50)) + ' orphans revmoved.';
                END;
        END;
    SET NOCOUNT OFF;
END;

GO

DECLARE
      @DBNAME nvarchar (100) = 'KenticoCMS_1';
EXEC KillAllOrphans @DBNAME , 'HFit_TrackerSugaryDrinks' , 'Y';
EXEC KillAllOrphans @DBNAME , 'HFit_TrackerSugaryFoods' , 'N';
EXEC KillAllOrphans @DBNAME , 'HFit_TrackerSummary' , 'N';
EXEC KillAllOrphans @DBNAME , 'HFit_TrackerTests' , 'N';
EXEC KillAllOrphans @DBNAME , 'HFit_TrackerTobaccoAttestation' , 'N';
EXEC KillAllOrphans @DBNAME , 'HFit_TrackerTobaccoFree' , 'N';
EXEC KillAllOrphans @DBNAME , 'HFit_TrackerVegetables' , 'N';
EXEC KillAllOrphans @DBNAME , 'HFit_TrackerWater' , 'N';
EXEC KillAllOrphans @DBNAME , 'HFit_TrackerWeight' , 'N';
EXEC KillAllOrphans @DBNAME , 'HFit_TrackerWholeGrains' , 'N';
EXEC KillAllOrphans @DBNAME , 'HFit_TrackerBloodSugarAndGlucose' , 'N';
EXEC KillAllOrphans @DBNAME , 'HFit_TrackerBMI' , 'N';
EXEC KillAllOrphans @DBNAME , 'HFit_TrackerBodyFat' , 'N';
EXEC KillAllOrphans @DBNAME , 'HFit_TrackerBodyMeasurements' , 'N';
EXEC KillAllOrphans @DBNAME , 'HFit_TrackerCardio' , 'N';
EXEC KillAllOrphans @DBNAME , 'HFit_TrackerCholesterol' , 'N';
EXEC KillAllOrphans @DBNAME , 'HFit_TrackerCotinine' , 'N';
EXEC KillAllOrphans @DBNAME , 'HFit_TrackerDailySteps' , 'N';
EXEC KillAllOrphans @DBNAME , 'HFit_TrackerFlexibility' , 'N';
EXEC KillAllOrphans @DBNAME , 'HFit_TrackerFruits' , 'N';
EXEC KillAllOrphans @DBNAME , 'HFit_TrackerHbA1c' , 'N';
EXEC KillAllOrphans @DBNAME , 'HFit_TrackerHeight' , 'N';
EXEC KillAllOrphans @DBNAME , 'HFit_TrackerHighFatFoods' , 'N';
EXEC KillAllOrphans @DBNAME , 'HFit_TrackerHighSodiumFoods' , 'N';
EXEC KillAllOrphans @DBNAME , 'HFit_TrackerInstance_Tracker' , 'N';
EXEC KillAllOrphans @DBNAME , 'HFit_TrackerMealPortions' , 'N';
EXEC KillAllOrphans @DBNAME , 'HFit_TrackerMedicalCarePlan' , 'N';
EXEC KillAllOrphans @DBNAME , 'HFit_TrackerPreventiveCare' , 'N';
EXEC KillAllOrphans @DBNAME , 'HFit_TrackerRegularMeals' , 'N';
EXEC KillAllOrphans @DBNAME , 'HFit_TrackerRestingHeartRate' , 'N';
EXEC KillAllOrphans @DBNAME , 'HFit_TrackerShots' , 'N';
EXEC KillAllOrphans @DBNAME , 'HFit_TrackerSitLess' , 'N';
EXEC KillAllOrphans @DBNAME , 'HFit_TrackerSleepPlan' , 'N';
EXEC KillAllOrphans @DBNAME , 'HFit_TrackerStrength' , 'N';
EXEC KillAllOrphans @DBNAME , 'HFit_TrackerStress' , 'N';
EXEC KillAllOrphans @DBNAME , 'HFit_TrackerStressManagement' , 'N';


-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
