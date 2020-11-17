--**************
print('END: ' + cast(getdate() as nvarchar(50)));
print('@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-');
print'***************************************************************' ;
print('START: ' + cast(getdate() as nvarchar(50)));
--**************

--SET ANSI_NULLS ON;
--SET ANSI_PADDING ON;
--SET ANSI_WARNINGS ON;
--SET ARITHABORT ON;
--SET CONCAT_NULL_YIELDS_NULL ON;
--SET NUMERIC_ROUNDABORT OFF;
--SET QUOTED_IDENTIFIER ON;




--**************
print('END: ' + cast(getdate() as nvarchar(50)));
print('@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-');
print'***************************************************************' ;
print('START: ' + cast(getdate() as nvarchar(50)));
--**************

--SET ANSI_NULLS ON;
--SET ANSI_PADDING ON;
--SET ANSI_WARNINGS ON;
--SET ARITHABORT ON;
--SET CONCAT_NULL_YIELDS_NULL ON;
--SET NUMERIC_ROUNDABORT OFF;
--SET QUOTED_IDENTIFIER ON;







GO
PRINT 'Creating proc_QuickRowCount.sql';

GO
IF EXISTS ( SELECT
                   name
              FROM sys.procedures
              WHERE name = 'proc_QuickRowCount' )
    BEGIN
        DROP PROCEDURE
             proc_QuickRowCount
    END;
GO

/*
declare @i as bigint = 0 ;
EXEC @i = proc_QuickRowCount 'Device_RawNotification' ;
print @i ;

    DECLARE
       @iTotal AS bigint = 0;

    EXEC @iTotal = proc_QuickRowCount 'DIM_EDW_RewardUserDetail';

    IF @iTotal = 1
        BEGIN
            SET @Reloadall = 1;
        END;

*/

CREATE PROCEDURE proc_QuickRowCount ( @TblName AS nvarchar( 254 ))
AS
BEGIN

    /*********************************************
    Author:	  Dale Miller
    Date:	  02.02.2008
    Copyright:  DMA, Ltd., Chicago, IL
    **********************************************/

    DECLARE
   @i AS bigint = 0;

    SET @i = ( SELECT
                      SUM ( row_count )
                 FROM sys.dm_db_partition_stats
                 WHERE
                      object_id = OBJECT_ID( @TblName )
                  AND (
                      index_id = 0
                   OR index_id = 1));
    if @i is null
	   set @i = 0 ;
    PRINT @i;
    return @i ;
END;

GO
PRINT 'Created proc_QuickRowCount.sql';
GO
--**************
print('END: ' + cast(getdate() as nvarchar(50)));
print('@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-');
print'***************************************************************' ;
print('START: ' + cast(getdate() as nvarchar(50)));
--**************

--SET ANSI_NULLS ON;
--SET ANSI_PADDING ON;
--SET ANSI_WARNINGS ON;
--SET ARITHABORT ON;
--SET CONCAT_NULL_YIELDS_NULL ON;
--SET NUMERIC_ROUNDABORT OFF;
--SET QUOTED_IDENTIFIER ON;





go
print 'FROM ckChangeTrackingTurnedON.sql';
print 'Installing Change Tracking';
go


DECLARE @DB AS NVarChar (200) = DB_NAME () ;
DECLARE @DBID AS Int = 0;
DECLARE @s AS NVarChar (2000) = '';

IF NOT EXISTS (SELECT
				  [database_id]
			   FROM [sys].[change_tracking_databases]
			   WHERE [database_id] = DB_ID (@DB)) 
    BEGIN
	   SET @s =
			'ALTER DATABASE ' + @DB + ' SET CHANGE_TRACKING = ON (CHANGE_RETENTION = 5 DAYS, AUTO_CLEANUP = ON) ';
	   EXEC (@s) ;
	   PRINT 'Turned Change Tracking On';
    END;

GO
print 'FROM ckChangeTrackingTurnedON.sql';
print 'Installed Change Tracking';
go
--**************
print('END: ' + cast(getdate() as nvarchar(50)));
print('@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-');
print'***************************************************************' ;
print('START: ' + cast(getdate() as nvarchar(50)));
--**************

--SET ANSI_NULLS ON;
--SET ANSI_PADDING ON;
--SET ANSI_WARNINGS ON;
--SET ARITHABORT ON;
--SET CONCAT_NULL_YIELDS_NULL ON;
--SET NUMERIC_ROUNDABORT OFF;
--SET QUOTED_IDENTIFIER ON;






GO
PRINT 'Executing proc_ChangeTracking.sql';
GO

IF EXISTS (SELECT
                  name
                  FROM sys.procedures
                  WHERE name = 'proc_ChangeTracking') 
    BEGIN
        PRINT 'replacing proc_ChangeTracking';
        DROP PROCEDURE
             proc_ChangeTracking;
    END;
GO

-- exec proc_ChangeTracking @InstanceName = 'KenticoCMS_1', @TblName = 'COM_SKU', @Enable = 1
-- exec proc_ChangeTracking 'KenticoCMS_1', 'CMS_USER', 1
CREATE PROCEDURE proc_ChangeTracking (
     @InstanceName AS nvarchar (100) 
   , @TblName AS nvarchar (100) 
   , @Enable AS bit) 
AS
BEGIN
    --DECLARE @InstanceName AS nvarchar (100) = 'KenticoCMS_2';
    --DECLARE @TblName AS nvarchar (100)  = 'CMS_Class';
    --DECLARE @Enable AS bit = 1;
    DECLARE @S AS nvarchar (2000) = '';
    DECLARE @iCnt AS integer = 0;
    DECLARE @TEMPVAR AS TABLE (
                              iCNT integer) ;
PRINT 'INSIDE proc_ChangeTracking: ' + @InstanceName + ' / ' +  @TblName;
    IF @Enable = 1
        BEGIN

            SET @S = 'SELECT count(*) as iCNT FROM ' + CHAR (10) ;
            SET @S = @S + '    ' + @InstanceName + '.sys.change_tracking_tables ' + CHAR (10) ;
            SET @S = @S + '        JOIN ' + @InstanceName + '.sys.tables ' + CHAR (10) ;
            SET @S = @S + '           ON ' + @InstanceName + '.sys.tables.object_id = ' + @InstanceName + '.sys.change_tracking_tables.object_id ' + CHAR (10) ;
            SET @S = @S + '               JOIN ' + @InstanceName + '.sys.schemas ' + CHAR (10) ;
            SET @S = @S + '			    ON ' + @InstanceName + '.sys.schemas.schema_id = ' + @InstanceName + '.sys.tables.schema_id ' + CHAR (10) ;
            SET @S = @S + '           WHERE ' + @InstanceName + '.sys.tables.name = ''' + @TblName + '''';

            INSERT INTO @TEMPVAR
            EXEC (@S) ;
            SET @iCnt = (SELECT TOP 1
                                iCNT
                                FROM @TEMPVAR);

            IF @iCnt = 0
                BEGIN
                    PRINT 'ENABLING Change Tracking on ' + @InstanceName + '.dbo.' + @TblName;
                    SET @S = 'ALTER TABLE ' + @InstanceName + '.dbo.' + @TblName + ' ENABLE CHANGE_TRACKING WITH (TRACK_COLUMNS_UPDATED = ON) ';
    print @S ;
                    EXEC (@S) ;
                END;
            ELSE
                BEGIN
                    PRINT 'Change Tracking ENABLED for: ' + + @InstanceName + '.dbo.' + @TblName;
                END;
        END;
    IF @Enable = 0
        BEGIN
            SET @S = 'SELECT count(*) as iCNT FROM ' + CHAR (10) ;
            SET @S = @S + '    ' + @InstanceName + '.sys.change_tracking_tables ' + CHAR (10) ;
            SET @S = @S + '        JOIN ' + @InstanceName + '.sys.tables ' + CHAR (10) ;
            SET @S = @S + '           ON ' + @InstanceName + '.sys.tables.object_id = ' + @InstanceName + '.sys.change_tracking_tables.object_id ' + CHAR (10) ;
            SET @S = @S + '               JOIN ' + @InstanceName + '.sys.schemas ' + CHAR (10) ;
            SET @S = @S + '			    ON ' + @InstanceName + '.sys.schemas.schema_id = ' + @InstanceName + '.sys.tables.schema_id ' + CHAR (10) ;
            SET @S = @S + '           WHERE ' + @InstanceName + '.sys.tables.name = ''' + @TblName + '''';

            INSERT INTO @TEMPVAR
            EXEC (@S) ;
            SET @iCnt = (SELECT TOP 1
                                iCNT
                                FROM @TEMPVAR);

            IF @iCnt > 0
                BEGIN
                    PRINT 'DISABLED Change Tracking on ' + @InstanceName + '.dbo.' + @TblName;
                    SET @S = 'ALTER TABLE ' + @InstanceName + '.dbo.' + @TblName + ' DISABLE CHANGE_TRACKING ';
                    EXEC (@S) ;
                END;
            ELSE
                BEGIN
                    PRINT 'Change Tracking is NOT applied to ' + + @InstanceName + '.dbo.' + @TblName + '.';
                END;
        END;
END;

GO
PRINT 'Executed proc_ChangeTracking.sql';
GO

--**************
print('END: ' + cast(getdate() as nvarchar(50)));
print('@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-');
print'***************************************************************' ;
print('START: ' + cast(getdate() as nvarchar(50)));
--**************

--SET ANSI_NULLS ON;
--SET ANSI_PADDING ON;
--SET ANSI_WARNINGS ON;
--SET ARITHABORT ON;
--SET CONCAT_NULL_YIELDS_NULL ON;
--SET NUMERIC_ROUNDABORT OFF;
--SET QUOTED_IDENTIFIER ON;





GO
PRINT 'EXECUTING SetCtHA.sql';
GO

IF EXISTS (SELECT
                  name
                  FROM sys.procedures
                  WHERE name = 'proc_EnableChangeTracking') 
    BEGIN
        DROP PROCEDURE
             proc_EnableChangeTracking;
    END;

GO
-- exec proc_EnableChangeTracking 'KenticoCMS_1'
-- exec proc_EnableChangeTracking 'KenticoCMS_2'
-- exec proc_EnableChangeTracking 'KenticoCMS_3'
CREATE PROCEDURE proc_EnableChangeTracking ( @DatabaseName AS nvarchar (100) )
AS
BEGIN
    DECLARE @DB AS nvarchar (100) = DB_NAME () ;
    DECLARE @MySql AS nvarchar (1000) = '';
    --DECLARE @DatabaseName AS nvarchar (2000) = 'KenticoCMS_2';

    IF NOT EXISTS (SELECT
                          database_id
                          FROM sys.change_tracking_databases
                          WHERE database_id = DB_ID (@DatabaseName)) 
        BEGIN
		  PRINT ('ENABLED CHANGE TRACKING ON: ' + @DatabaseName);
            SET @MySql = 'ALTER DATABASE ' + @DatabaseName + ' SET CHANGE_TRACKING = ON (CHANGE_RETENTION = 2 DAYS, AUTO_CLEANUP = ON) ';
            EXEC (@MySql) ;
        END;

    DECLARE @DBID AS int = 0;
    DECLARE @s AS nvarchar (2000) = '';
    
    EXEC proc_ChangeTracking  @DatabaseName, 'CMS_Class', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'CMS_Document', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'CMS_Site', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'CMS_Tree', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'cms_user', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'cms_usersettings', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'cms_usersite', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'COM_SKU', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'HFit_Account', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'HFit_CoachingHealthArea', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'HFit_CoachingHealthInterest', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'HFit_HACampaign', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'HFit_HealthAssesmentMatrixQuestion', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'HFit_HealthAssesmentModule', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'HFit_HealthAssesmentMultipleChoiceQuestion', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'HFit_HealthAssesmentRiskArea', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'HFit_HealthAssesmentRiskCategory', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'HFit_HealthAssesmentUserAnswers', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'HFit_HealthAssesmentUserModule', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'HFit_HealthAssesmentUserQuestion', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'HFit_HealthAssesmentUserQuestionGroupResults', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'HFit_HealthAssesmentUserRiskArea', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'HFit_HealthAssesmentUserRiskCategory', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'HFit_HealthAssesmentUserStarted', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'HFit_HealthAssessment', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'HFit_HealthAssessmentFreeForm', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'HFit_LKP_EDW_RejectMPI', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'HFit_LKP_RewardActivity', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'HFit_LKP_RewardLevelType', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'HFit_LKP_RewardTrigger', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'HFit_LKP_RewardType', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'HFit_LKP_TrackerVendor', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'HFit_OutComeMessages', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'hfit_PPTEligibility', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'HFit_RewardActivity', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'HFit_RewardException', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'HFit_RewardGroup', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'HFit_RewardLevel', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'HFit_RewardProgram', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'HFit_RewardsUserActivityDetail', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'HFit_RewardsUserLevelDetail', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'HFit_RewardTrigger', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'HFit_RewardTriggerParameter', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'Hfit_SmallStepResponses', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'HFit_ToDoSmallSteps', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'HFIT_Tracker', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'HFit_TrackerBloodPressure', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'HFit_TrackerBloodSugarAndGlucose', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'HFit_TrackerBMI', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'HFit_TrackerBodyFat', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'HFit_TrackerBodyMeasurements', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'HFit_TrackerCardio', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'HFit_TrackerCholesterol', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'HFit_TrackerCollectionSource', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'HFit_TrackerCotinine', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'HFit_TrackerDailySteps', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'HFit_TrackerDef_Tracker', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'HFit_TrackerFlexibility', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'HFit_TrackerFruits', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'HFit_TrackerHbA1c', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'HFit_TrackerHeight', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'HFit_TrackerHighFatFoods', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'HFit_TrackerHighSodiumFoods', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'HFit_TrackerInstance_Tracker', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'HFit_TrackerMealPortions', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'HFit_TrackerMedicalCarePlan', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'HFit_TrackerPreventiveCare', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'HFit_TrackerRegularMeals', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'HFit_TrackerRestingHeartRate', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'HFit_TrackerShots', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'HFit_TrackerSitLess', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'HFit_TrackerSleepPlan', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'HFit_TrackerStrength', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'HFit_TrackerStress', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'HFit_TrackerStressManagement', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'HFit_TrackerSugaryDrinks', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'HFit_TrackerSugaryFoods', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'HFit_TrackerTests', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'HFit_TrackerTobaccoAttestation', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'HFit_TrackerTobaccoFree', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'HFit_TrackerVegetables', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'HFit_TrackerWater', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'HFit_TrackerWeight', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'HFit_TrackerWholeGrains', 1;
    EXEC proc_ChangeTracking  @DatabaseName, 'HFit_UserTracker', 1;


    IF EXISTS (SELECT
                      job_id
                      FROM msdb.dbo.sysjobs_view
                      WHERE name = 'job_EDW_CT_HA_MarkDeletedRecords_KenticoCMS_PRD_1') 
        BEGIN
            EXEC msdb.dbo.sp_update_job @job_name = 'job_EDW_CT_HA_MarkDeletedRecords_KenticoCMS_PRD_1', @enabled = 1;
        END;

    IF EXISTS (SELECT
                      job_id
                      FROM msdb.dbo.sysjobs_view
                      WHERE name = 'job_EDW_CT_HA_MarkNewRecords_KenticoCMS_PRD_1') 
        BEGIN
            EXEC msdb.dbo.sp_update_job @job_name = 'job_EDW_CT_HA_MarkNewRecords_KenticoCMS_PRD_1', @enabled = 1;
        END;

    IF EXISTS (SELECT
                      job_id
                      FROM msdb.dbo.sysjobs_view
                      WHERE name = 'job_EDW_CT_HA_MarkUpdatedRecords_KenticoCMS_PRD_1') 
        BEGIN
            EXEC msdb.dbo.sp_update_job @job_name = 'job_EDW_CT_HA_MarkUpdatedRecords_KenticoCMS_PRD_1', @enabled = 1;
        END;

    IF EXISTS (SELECT
                      job_id
                      FROM msdb.dbo.sysjobs_view
                      WHERE name = 'job_EDW_Generate_BMI_Staging_Data_KenticoCMS_PRD_1') 
        BEGIN
            EXEC msdb.dbo.sp_update_job @job_name = 'job_EDW_Generate_BMI_Staging_Data_KenticoCMS_PRD_1', @enabled = 1;
        END;

    IF EXISTS (SELECT
                      job_id
                      FROM msdb.dbo.sysjobs_view
                      WHERE name = 'job_EDW_GetStagingData_BioMetrics_KenticoCMS_PRD_1') 
        BEGIN
            EXEC msdb.dbo.sp_update_job @job_name = 'job_EDW_GetStagingData_BioMetrics_KenticoCMS_PRD_1', @enabled = 1;
        END;

    IF EXISTS (SELECT
                      job_id
                      FROM msdb.dbo.sysjobs_view
                      WHERE name = 'job_EDW_GetStagingData_CMS_UserSettings_KenticoCMS_PRD_1') 
        BEGIN
            EXEC msdb.dbo.sp_update_job @job_name = 'job_EDW_GetStagingData_CMS_UserSettings_KenticoCMS_PRD_1', @enabled = 1;
        END;

    IF EXISTS (SELECT
                      job_id
                      FROM msdb.dbo.sysjobs_view
                      WHERE name = 'job_EDW_GetStagingData_CMS_UserSite_KenticoCMS_PRD_1') 
        BEGIN
            EXEC msdb.dbo.sp_update_job @job_name = 'job_EDW_GetStagingData_CMS_UserSite_KenticoCMS_PRD_1', @enabled = 1;
        END;

    IF EXISTS (SELECT
                      job_id
                      FROM msdb.dbo.sysjobs_view
                      WHERE name = 'job_EDW_GetStagingData_CoachingDetail_KenticoCMS_PRD_1') 
        BEGIN
            EXEC msdb.dbo.sp_update_job @job_name = 'job_EDW_GetStagingData_CoachingDetail_KenticoCMS_PRD_1', @enabled = 1;
        END;

    IF EXISTS (SELECT
                      job_id
                      FROM msdb.dbo.sysjobs_view
                      WHERE name = 'job_EDW_GetStagingData_CT_USER_KenticoCMS_PRD_1') 
        BEGIN
            EXEC msdb.dbo.sp_update_job @job_name = 'job_EDW_GetStagingData_CT_USER_KenticoCMS_PRD_1', @enabled = 1;
        END;

    IF EXISTS (SELECT
                      job_id
                      FROM msdb.dbo.sysjobs_view
                      WHERE name = 'job_EDW_GetStagingData_HA_KenticoCMS_PRD_1') 
        BEGIN
            EXEC msdb.dbo.sp_update_job @job_name = 'job_EDW_GetStagingData_HA_KenticoCMS_PRD_1', @enabled = 1;
        END;

    IF EXISTS (SELECT
                      job_id
                      FROM msdb.dbo.sysjobs_view
                      WHERE name = 'job_EDW_GetStagingData_HADefinition_KenticoCMS_PRD_1') 
        BEGIN
            EXEC msdb.dbo.sp_update_job @job_name = 'job_EDW_GetStagingData_HADefinition_KenticoCMS_PRD_1', @enabled = 1;
        END;

    IF EXISTS (SELECT
                      job_id
                      FROM msdb.dbo.sysjobs_view
                      WHERE name = 'job_EDW_GetStagingData_HFIT_PPTEligibility_KenticoCMS_PRD_1') 
        BEGIN
            EXEC msdb.dbo.sp_update_job @job_name = 'job_EDW_GetStagingData_HFIT_PPTEligibility_KenticoCMS_PRD_1', @enabled = 1;
        END;

    IF EXISTS (SELECT
                      job_id
                      FROM msdb.dbo.sysjobs_view
                      WHERE name = 'job_EDW_GetStagingData_RewardAwardDetail_KenticoCMS_PRD_1') 
        BEGIN
            EXEC msdb.dbo.sp_update_job @job_name = 'job_EDW_GetStagingData_RewardAwardDetail_KenticoCMS_PRD_1', @enabled = 1;
        END;

    IF EXISTS (SELECT
                      job_id
                      FROM msdb.dbo.sysjobs_view
                      WHERE name = 'job_EDW_GetStagingData_RewardsDefinition_KenticoCMS_PRD_1') 
        BEGIN
            EXEC msdb.dbo.sp_update_job @job_name = 'job_EDW_GetStagingData_RewardsDefinition_KenticoCMS_PRD_1', @enabled = 1;
        END;

    IF EXISTS (SELECT
                      job_id
                      FROM msdb.dbo.sysjobs_view
                      WHERE name = 'job_EDW_GetStagingData_RewardTriggerParameters_KenticoCMS_PRD_1') 
        BEGIN
            EXEC msdb.dbo.sp_update_job @job_name = 'job_EDW_GetStagingData_RewardTriggerParameters_KenticoCMS_PRD_1', @enabled = 1;
        END;

    IF EXISTS (SELECT
                      job_id
                      FROM msdb.dbo.sysjobs_view
                      WHERE name = 'job_EDW_GetStagingData_RewardUserDetail_KenticoCMS_PRD_1') 
        BEGIN
            EXEC msdb.dbo.sp_update_job @job_name = 'job_EDW_GetStagingData_RewardUserDetail_KenticoCMS_PRD_1', @enabled = 1;
        END;

    IF EXISTS (SELECT
                      job_id
                      FROM msdb.dbo.sysjobs_view
                      WHERE name = 'job_EDW_GetStagingData_RewardUserLevel_KenticoCMS_PRD_1') 
        BEGIN
            EXEC msdb.dbo.sp_update_job @job_name = 'job_EDW_GetStagingData_RewardUserLevel_KenticoCMS_PRD_1', @enabled = 1;
        END;

    IF EXISTS (SELECT
                      job_id
                      FROM msdb.dbo.sysjobs_view
                      WHERE name = 'job_EDW_GetStagingData_Trackers_KenticoCMS_PRD_1') 
        BEGIN
            EXEC msdb.dbo.sp_update_job @job_name = 'job_EDW_GetStagingData_Trackers_KenticoCMS_PRD_1', @enabled = 1;
        END;

    IF EXISTS (SELECT
                      job_id
                      FROM msdb.dbo.sysjobs_view
                      WHERE name = 'job_EDW_HA_Master_KenticoCMS_PRD_1') 
        BEGIN
            EXEC msdb.dbo.sp_update_job @job_name = 'job_EDW_HA_Master_KenticoCMS_PRD_1', @enabled = 1;
        END;
    PRINT 'Activated Change Tracking for EDW Views and tables';
END;

GO
PRINT 'EXECUTED SetCtHA.sql';

GO--**************
print('END: ' + cast(getdate() as nvarchar(50)));
print('@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-');
print'***************************************************************' ;
print('START: ' + cast(getdate() as nvarchar(50)));
--**************

--SET ANSI_NULLS ON;
--SET ANSI_PADDING ON;
--SET ANSI_WARNINGS ON;
--SET ARITHABORT ON;
--SET CONCAT_NULL_YIELDS_NULL ON;
--SET NUMERIC_ROUNDABORT OFF;
--SET QUOTED_IDENTIFIER ON;





GO
PRINT 'Executing DisableCT_EDW.sql';
GO

if exists (select name from sys.procedures where name = 'proc_DisableChangeTracking')
drop procedure proc_DisableChangeTracking

go
-- exec proc_DisableChangeTracking 'KenticoCMS_1' ;
CREATE PROCEDURE proc_DisableChangeTracking (@DatabaseName as nvarchar(100))
AS
BEGIN
    DECLARE @DB AS nvarchar (100) = @DatabaseName ;
    DECLARE @MySql AS nvarchar (1000) = '';
    DECLARE @DBID AS int = 0;
    DECLARE @s AS nvarchar (2000) = '';

    --declare @DatabaseName as nvarchar(100) = 'KenticoCMS_1' ;
    EXEC proc_ChangeTracking @DatabaseName, 'Hfit_SmallStepResponses', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'CMS_Class', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'CMS_Document', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'CMS_Site', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'CMS_Tree', 0;
    -- The below tables are used in Audit Tracking and cannot be removed from Change TRacking
    --EXEC proc_ChangeTracking @DatabaseName, 'cms_user', 0;
    --EXEC proc_ChangeTracking @DatabaseName, 'cms_usersettings', 0;
    --EXEC proc_ChangeTracking @DatabaseName, 'cms_usersite', 0;
    --EXEC proc_ChangeTracking @DatabaseName, 'hfit_ppteligibility', 0;    
    EXEC proc_ChangeTracking @DatabaseName, 'COM_SKU', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'HFit_Account', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'HFit_CoachingHealthArea', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'HFit_CoachingHealthInterest', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'HFit_HACampaign', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'HFit_HealthAssesmentMatrixQuestion', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'HFit_HealthAssesmentModule', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'HFit_HealthAssesmentMultipleChoiceQuestion', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'HFit_HealthAssesmentRiskArea', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'HFit_HealthAssesmentRiskCategory', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'HFit_HealthAssesmentUserAnswers', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'HFit_HealthAssesmentUserModule', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'HFit_HealthAssesmentUserQuestion', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'HFit_HealthAssesmentUserQuestionGroupResults', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'HFit_HealthAssesmentUserRiskArea', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'HFit_HealthAssesmentUserRiskCategory', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'HFit_HealthAssesmentUserStarted', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'HFit_HealthAssessment', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'HFit_HealthAssessmentFreeForm', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'HFit_LKP_EDW_RejectMPI', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'HFit_LKP_RewardActivity', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'HFit_LKP_RewardLevelType', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'HFit_LKP_RewardTrigger', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'HFit_LKP_RewardType', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'HFit_LKP_TrackerVendor', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'HFit_OutComeMessages', 0;    
    EXEC proc_ChangeTracking @DatabaseName, 'HFit_RewardActivity', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'HFit_RewardException', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'HFit_RewardGroup', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'HFit_RewardLevel', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'HFit_RewardProgram', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'HFit_RewardsUserActivityDetail', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'HFit_RewardsUserLevelDetail', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'HFit_RewardTrigger', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'HFit_RewardTriggerParameter', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'HFit_ToDoSmallSteps', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'HFIT_Tracker', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'HFit_TrackerBloodPressure', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'HFit_TrackerBloodSugarAndGlucose', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'HFit_TrackerBMI', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'HFit_TrackerBodyFat', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'HFit_TrackerBodyMeasurements', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'HFit_TrackerCardio', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'HFit_TrackerCholesterol', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'HFit_TrackerCollectionSource', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'HFit_TrackerCotinine', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'HFit_TrackerCotinine', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'HFit_TrackerDailySteps', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'HFit_TrackerDef_Tracker', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'HFit_TrackerFlexibility', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'HFit_TrackerFruits', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'HFit_TrackerHbA1c', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'HFit_TrackerHeight', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'HFit_TrackerHighFatFoods', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'HFit_TrackerHighSodiumFoods', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'HFit_TrackerInstance_Tracker', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'HFit_TrackerMealPortions', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'HFit_TrackerMedicalCarePlan', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'HFit_TrackerPreventiveCare', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'HFit_TrackerPreventiveCare', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'HFit_TrackerRegularMeals', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'HFit_TrackerRestingHeartRate', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'HFit_TrackerShots', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'HFit_TrackerSitLess', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'HFit_TrackerSleepPlan', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'HFit_TrackerStrength', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'HFit_TrackerStress', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'HFit_TrackerStressManagement', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'HFit_TrackerSugaryDrinks', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'HFit_TrackerSugaryFoods', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'HFit_TrackerTests', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'HFit_TrackerTobaccoAttestation', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'HFit_TrackerTobaccoFree', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'HFit_TrackerVegetables', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'HFit_TrackerWater', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'HFit_TrackerWeight', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'HFit_TrackerWholeGrains', 0;
    EXEC proc_ChangeTracking @DatabaseName, 'HFit_UserTracker', 0;

    IF NOT EXISTS (SELECT
                          database_id
                          FROM sys.change_tracking_databases
                          WHERE database_id = DB_ID (@DB)) 
        BEGIN
            SET @MySql = 'ALTER DATABASE ' + @DB + ' SET CHANGE_TRACKING = OFF ';
            EXEC (@MySql) ;
        END;

    SELECT
           OBJECT_NAME (object_id) AS TABLE_NAME
           FROM sys.change_tracking_tables;

    IF EXISTS (SELECT
                      job_id
                      FROM msdb.dbo.sysjobs_view
                      WHERE name = 'job_EDW_CT_HA_MarkDeletedRecords_KenticoCMS_PRD_1') 
        BEGIN
            EXEC msdb.dbo.sp_update_job @job_name = 'job_EDW_CT_HA_MarkDeletedRecords_KenticoCMS_PRD_1', @enabled = 0;
        END;

    IF EXISTS (SELECT
                      job_id
                      FROM msdb.dbo.sysjobs_view
                      WHERE name = 'job_EDW_CT_HA_MarkNewRecords_KenticoCMS_PRD_1') 
        BEGIN
            EXEC msdb.dbo.sp_update_job @job_name = 'job_EDW_CT_HA_MarkNewRecords_KenticoCMS_PRD_1', @enabled = 0;
        END;

    IF EXISTS (SELECT
                      job_id
                      FROM msdb.dbo.sysjobs_view
                      WHERE name = 'job_EDW_CT_HA_MarkUpdatedRecords_KenticoCMS_PRD_1') 
        BEGIN
            EXEC msdb.dbo.sp_update_job @job_name = 'job_EDW_CT_HA_MarkUpdatedRecords_KenticoCMS_PRD_1', @enabled = 0;
        END;

    IF EXISTS (SELECT
                      job_id
                      FROM msdb.dbo.sysjobs_view
                      WHERE name = 'job_EDW_Generate_BMI_Staging_Data_KenticoCMS_PRD_1') 
        BEGIN
            EXEC msdb.dbo.sp_update_job @job_name = 'job_EDW_Generate_BMI_Staging_Data_KenticoCMS_PRD_1', @enabled = 0;
        END;

    IF EXISTS (SELECT
                      job_id
                      FROM msdb.dbo.sysjobs_view
                      WHERE name = 'job_EDW_GetStagingData_BioMetrics_KenticoCMS_PRD_1') 
        BEGIN
            EXEC msdb.dbo.sp_update_job @job_name = 'job_EDW_GetStagingData_BioMetrics_KenticoCMS_PRD_1', @enabled = 0;
        END;

    IF EXISTS (SELECT
                      job_id
                      FROM msdb.dbo.sysjobs_view
                      WHERE name = 'job_EDW_GetStagingData_CMS_UserSettings_KenticoCMS_PRD_1') 
        BEGIN
            EXEC msdb.dbo.sp_update_job @job_name = 'job_EDW_GetStagingData_CMS_UserSettings_KenticoCMS_PRD_1', @enabled = 0;
        END;

    IF EXISTS (SELECT
                      job_id
                      FROM msdb.dbo.sysjobs_view
                      WHERE name = 'job_EDW_GetStagingData_CMS_UserSite_KenticoCMS_PRD_1') 
        BEGIN
            EXEC msdb.dbo.sp_update_job @job_name = 'job_EDW_GetStagingData_CMS_UserSite_KenticoCMS_PRD_1', @enabled = 0;
        END;

    IF EXISTS (SELECT
                      job_id
                      FROM msdb.dbo.sysjobs_view
                      WHERE name = 'job_EDW_GetStagingData_CoachingDetail_KenticoCMS_PRD_1') 
        BEGIN
            EXEC msdb.dbo.sp_update_job @job_name = 'job_EDW_GetStagingData_CoachingDetail_KenticoCMS_PRD_1', @enabled = 0;
        END;

    IF EXISTS (SELECT
                      job_id
                      FROM msdb.dbo.sysjobs_view
                      WHERE name = 'job_EDW_GetStagingData_CT_USER_KenticoCMS_PRD_1') 
        BEGIN
            EXEC msdb.dbo.sp_update_job @job_name = 'job_EDW_GetStagingData_CT_USER_KenticoCMS_PRD_1', @enabled = 0;
        END;

    IF EXISTS (SELECT
                      job_id
                      FROM msdb.dbo.sysjobs_view
                      WHERE name = 'job_EDW_GetStagingData_HA_KenticoCMS_PRD_1') 
        BEGIN
            EXEC msdb.dbo.sp_update_job @job_name = 'job_EDW_GetStagingData_HA_KenticoCMS_PRD_1', @enabled = 0;
        END;

    IF EXISTS (SELECT
                      job_id
                      FROM msdb.dbo.sysjobs_view
                      WHERE name = 'job_EDW_GetStagingData_HADefinition_KenticoCMS_PRD_1') 
        BEGIN
            EXEC msdb.dbo.sp_update_job @job_name = 'job_EDW_GetStagingData_HADefinition_KenticoCMS_PRD_1', @enabled = 0;
        END;

    IF EXISTS (SELECT
                      job_id
                      FROM msdb.dbo.sysjobs_view
                      WHERE name = 'job_EDW_GetStagingData_HFIT_PPTEligibility_KenticoCMS_PRD_1') 
        BEGIN
            EXEC msdb.dbo.sp_update_job @job_name = 'job_EDW_GetStagingData_HFIT_PPTEligibility_KenticoCMS_PRD_1', @enabled = 0;
        END;

    IF EXISTS (SELECT
                      job_id
                      FROM msdb.dbo.sysjobs_view
                      WHERE name = 'job_EDW_GetStagingData_RewardAwardDetail_KenticoCMS_PRD_1') 
        BEGIN
            EXEC msdb.dbo.sp_update_job @job_name = 'job_EDW_GetStagingData_RewardAwardDetail_KenticoCMS_PRD_1', @enabled = 0;
        END;

    IF EXISTS (SELECT
                      job_id
                      FROM msdb.dbo.sysjobs_view
                      WHERE name = 'job_EDW_GetStagingData_RewardsDefinition_KenticoCMS_PRD_1') 
        BEGIN
            EXEC msdb.dbo.sp_update_job @job_name = 'job_EDW_GetStagingData_RewardsDefinition_KenticoCMS_PRD_1', @enabled = 0;
        END;

    IF EXISTS (SELECT
                      job_id
                      FROM msdb.dbo.sysjobs_view
                      WHERE name = 'job_EDW_GetStagingData_RewardTriggerParameters_KenticoCMS_PRD_1') 
        BEGIN
            EXEC msdb.dbo.sp_update_job @job_name = 'job_EDW_GetStagingData_RewardTriggerParameters_KenticoCMS_PRD_1', @enabled = 0;
        END;

    IF EXISTS (SELECT
                      job_id
                      FROM msdb.dbo.sysjobs_view
                      WHERE name = 'job_EDW_GetStagingData_RewardUserDetail_KenticoCMS_PRD_1') 
        BEGIN
            EXEC msdb.dbo.sp_update_job @job_name = 'job_EDW_GetStagingData_RewardUserDetail_KenticoCMS_PRD_1', @enabled = 0;
        END;

    IF EXISTS (SELECT
                      job_id
                      FROM msdb.dbo.sysjobs_view
                      WHERE name = 'job_EDW_GetStagingData_RewardUserLevel_KenticoCMS_PRD_1') 
        BEGIN
            EXEC msdb.dbo.sp_update_job @job_name = 'job_EDW_GetStagingData_RewardUserLevel_KenticoCMS_PRD_1', @enabled = 0;
        END;

    IF EXISTS (SELECT
                      job_id
                      FROM msdb.dbo.sysjobs_view
                      WHERE name = 'job_EDW_GetStagingData_Trackers_KenticoCMS_PRD_1') 
        BEGIN
            EXEC msdb.dbo.sp_update_job @job_name = 'job_EDW_GetStagingData_Trackers_KenticoCMS_PRD_1', @enabled = 0;
        END;

    IF EXISTS (SELECT
                      job_id
                      FROM msdb.dbo.sysjobs_view
                      WHERE name = 'job_EDW_HA_Master_KenticoCMS_PRD_1') 
        BEGIN
            EXEC msdb.dbo.sp_update_job @job_name = 'job_EDW_HA_Master_KenticoCMS_PRD_1', @enabled = 0;
        END;

END;

GO
PRINT 'Executed DisableCT_EDW.sql';
GO--**************
print('END: ' + cast(getdate() as nvarchar(50)));
print('@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-');
print'***************************************************************' ;
print('START: ' + cast(getdate() as nvarchar(50)));
--**************

--SET ANSI_NULLS ON;
--SET ANSI_PADDING ON;
--SET ANSI_WARNINGS ON;
--SET ARITHABORT ON;
--SET CONCAT_NULL_YIELDS_NULL ON;
--SET NUMERIC_ROUNDABORT OFF;
--SET QUOTED_IDENTIFIER ON;





GO
PRINT 'executing proc_EnableAuditControl.sql;';
GO
IF EXISTS (SELECT
                  name
                  FROM sys.procedures
                  WHERE name = 'proc_EnableAuditControl') 
    BEGIN
        DROP PROCEDURE
             proc_EnableAuditControl;
    END;

GO
CREATE PROCEDURE proc_EnableAuditControl
AS
BEGIN

    DECLARE @DB nvarchar (100) = DB_NAME () ;
    DECLARE @S nvarchar (2000) = '';
    DECLARE @TrgName  nvarchar (100) = '';
    DECLARE @TBL  nvarchar (100) = '';

    IF NOT EXISTS (SELECT
                          database_id
                          FROM sys.change_tracking_databases
                          WHERE database_id = DB_ID (@DB)) 
        BEGIN
            SET @S = 'ALTER DATABASE ' + @DB + ' SET CHANGE_TRACKING = ON (CHANGE_RETENTION = 2 DAYS, AUTO_CLEANUP = ON) ';
            EXEC (@S) ;
            PRINT 'TURNED ON CHANGE TRACKING FOR: ' + @@ServerName + ' and Database ' + DB_NAME () ;
        END;
    ELSE
        BEGIN
            PRINT 'CHANGE TRACKING IS ACTIVE FOR: ' + @@ServerName + ' and Database ' + DB_NAME () ;
        END;

    EXEC proc_ChangeTracking 'hfit_ppteligibility', 1;
    EXEC proc_ChangeTracking 'CMS_Class', 1;
    EXEC proc_ChangeTracking 'CMS_Document', 1;
    EXEC proc_ChangeTracking 'CMS_Site', 1;
    EXEC proc_ChangeTracking 'CMS_Tree', 1;
    EXEC proc_ChangeTracking 'cms_user', 1;
    EXEC proc_ChangeTracking 'cms_usersettings', 1;
    EXEC proc_ChangeTracking 'cms_usersite', 1;
    --EXEC proc_ChangeTracking 'COM_SKU', 1;

    PRINT 'Enabeling Audit Control Triggers on server ' + @@ServerName + ' and Database ' + DB_NAME () ;

    SET @TBL = 'CMS_User';
    SET @TrgName = 'trig_INS_CMS_User_Audit';
    IF EXISTS (SELECT
                      name
                      FROM sys.triggers
                      WHERE name = @TrgName) 
        BEGIN
            PRINT 'Enabled Trigger: ' + @TrgName;
            SET @S = 'ENABLE TRIGGER ' + @TrgName + ' ON ' + @TBL;
            EXEC (@S) ;
        END;
    ELSE
        BEGIN
            PRINT @TrgName + ' does not exist.';
        END;

    SET @TBL = 'CMS_UserSettings';
    SET @TrgName = 'trig_INS_CMS_UserSettings_Audit';
    IF EXISTS (SELECT
                      name
                      FROM sys.triggers
                      WHERE name = @TrgName) 
        BEGIN
            PRINT 'Enabled Trigger: ' + @TrgName;
            SET @S = 'ENABLE TRIGGER ' + @TrgName + ' ON ' + @TBL;
            EXEC (@S) ;
        END;
    ELSE
        BEGIN
            PRINT @TrgName + ' does not exist.';
        END;

    SET @TBL = 'CMS_UserSite';
    SET @TrgName = 'trig_INS_CMS_UserSite_Audit';
    IF EXISTS (SELECT
                      name
                      FROM sys.triggers
                      WHERE name = @TrgName) 
        BEGIN
            PRINT 'Enabled Trigger: ' + @TrgName;
            SET @S = 'ENABLE TRIGGER ' + @TrgName + ' ON ' + @TBL;
            EXEC (@S) ;
        END;
    ELSE
        BEGIN
            PRINT @TrgName + ' does not exist.';
        END;

    SET @TBL = 'HFIT_PPTEligibility';
    SET @TrgName = 'trig_UPDT_HFIT_PPTEligibility_Audit';
    IF EXISTS (SELECT
                      name
                      FROM sys.triggers
                      WHERE name = @TrgName) 
        BEGIN
            PRINT 'Enabled Trigger: ' + @TrgName;
            SET @S = 'ENABLE TRIGGER ' + @TrgName + ' ON ' + @TBL;
            EXEC (@S) ;
        END;
    ELSE
        BEGIN
            PRINT @TrgName + ' does not exist.';
        END;

END;
GO
EXEC proc_EnableAuditControl;
GO
PRINT 'executing proc_EnableAuditControl.sq;';
GO--**************
print('END: ' + cast(getdate() as nvarchar(50)));
print('@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-');
print'***************************************************************' ;
print('START: ' + cast(getdate() as nvarchar(50)));
--**************

--SET ANSI_NULLS ON;
--SET ANSI_PADDING ON;
--SET ANSI_WARNINGS ON;
--SET ARITHABORT ON;
--SET CONCAT_NULL_YIELDS_NULL ON;
--SET NUMERIC_ROUNDABORT OFF;
--SET QUOTED_IDENTIFIER ON;






GO
PRINT 'Executing proc_DisableAuditControl.sql';
GO
IF EXISTS (SELECT
                  name
                  FROM sys.procedures
                  WHERE name = 'proc_DisableAuditControl') 
    BEGIN
        DROP PROCEDURE
             proc_DisableAuditControl;
    END;
GO

-- exec proc_DisableAuditControl
CREATE PROCEDURE proc_DisableAuditControl
AS
BEGIN
    DECLARE @DB nvarchar (100) = DB_NAME () ;
    DECLARE @S nvarchar (2000) = '';
    DECLARE @TrgName  nvarchar (100) = '';
    DECLARE @TBL  nvarchar (100) = '';

    PRINT 'ONLY TRIIGERS WIL BE DISABLED for Audit Control, no Change Tracking Tables will be modified.';

    SET @TBL = 'CMS_User';
    SET @TrgName = 'trig_INS_CMS_User_Audit';
    IF EXISTS (SELECT
                      name
                      FROM sys.triggers
                      WHERE name = @TrgName) 
        BEGIN
            SET @S = 'DISABLE TRIGGER ' + @TrgName + ' ON ' + @TBL;
            EXEC (@S) ;
            PRINT 'TRIGGER ' + @TrgName + ' ON ' + @TBL + ', DISABLED';
        END;

    SET @TBL = 'CMS_UserSettings';
    SET @TrgName = 'trig_INS_CMS_UserSettings_Audit';
    IF EXISTS (SELECT
                      name
                      FROM sys.triggers
                      WHERE name = @TrgName) 
        BEGIN
            SET @S = 'DISABLE TRIGGER ' + @TrgName + ' ON ' + @TBL;
            EXEC (@S) ;
            PRINT 'TRIGGER ' + @TrgName + ' ON ' + @TBL + ', DISABLED';
        END;

    SET @TBL = 'CMS_UserSite';
    SET @TrgName = 'trig_INS_CMS_UserSite_Audit';
    IF EXISTS (SELECT
                      name
                      FROM sys.triggers
                      WHERE name = @TrgName) 
        BEGIN
            SET @S = 'DISABLE TRIGGER ' + @TrgName + ' ON ' + @TBL;
            EXEC (@S) ;
            PRINT 'TRIGGER ' + @TrgName + ' ON ' + @TBL + ', DISABLED';
        END;

    SET @TBL = 'HFIT_PPTEligibility';
    SET @TrgName = 'trig_UPDT_HFIT_PPTEligibility_Audit';
    IF EXISTS (SELECT
                      name
                      FROM sys.triggers
                      WHERE name = @TrgName) 
        BEGIN
            SET @S = 'DISABLE TRIGGER ' + @TrgName + ' ON ' + @TBL;
            EXEC (@S) ;
            PRINT 'TRIGGER ' + @TrgName + ' ON ' + @TBL + ', DISABLED';
        END;

END;
GO
PRINT 'Executed proc_DisableAuditControl.sql';
GO
--**************
print('END: ' + cast(getdate() as nvarchar(50)));
print('@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-');
print'***************************************************************' ;
print('START: ' + cast(getdate() as nvarchar(50)));
--**************

--SET ANSI_NULLS ON;
--SET ANSI_PADDING ON;
--SET ANSI_WARNINGS ON;
--SET ARITHABORT ON;
--SET CONCAT_NULL_YIELDS_NULL ON;
--SET NUMERIC_ROUNDABORT OFF;
--SET QUOTED_IDENTIFIER ON;





GO
PRINT 'Creating Table EDW_CT_ExecutionLog';
PRINT 'FROM: createTable_EDW_CT_ExecutionLog.sql';
GO
--drop table EDW_CT_ExecutionLog

/*
alter table EDW_CT_ExecutionLog add CT_Inserts bigint NULL
alter table EDW_CT_ExecutionLog add CT_Updates bigint NULL
alter table EDW_CT_ExecutionLog add CT_Deletes bigint NULL	
*/

SET QUOTED_IDENTIFIER ON;

IF NOT EXISTS ( SELECT
                       name
                       FROM sys.tables
                       WHERE name = 'EDW_CT_ExecutionLog') 
    BEGIN

        CREATE TABLE dbo.EDW_CT_ExecutionLog (
                     CT_NAME nvarchar ( 80) NOT NULL
                   , CT_Start datetime NOT NULL
                   , CT_End datetime NULL
                   , CT_TotalMinutes int NULL
                   , CT_RecordsProcessed bigint NULL
                   , CT_Inserts bigint NULL
                   , CT_Updates bigint NULL
                   , CT_Deletes bigint NULL
                   , RecordID uniqueidentifier NOT NULL
                   , CONSTRAINT PK_EDW_CT_ExecutionLog PRIMARY KEY CLUSTERED ( RecordID ASC)) ;

        ALTER TABLE dbo.EDW_CT_ExecutionLog
        ADD
                    CONSTRAINT DF_EDW_CT_ExecutionLog_RecordID DEFAULT NEWID () FOR RecordID;

    END;
ELSE
    BEGIN
        IF NOT EXISTS ( SELECT
                               column_name
                               FROM information_schema.columns
                               WHERE
                               column_name = 'CT_Inserts'
                           AND table_name = 'EDW_CT_ExecutionLog') 
            BEGIN
                ALTER TABLE EDW_CT_ExecutionLog
                ADD
                            CT_Inserts bigint NULL;
            END;
        IF NOT EXISTS ( SELECT
                               column_name
                               FROM information_schema.columns
                               WHERE
                               column_name = 'CT_Updates'
                           AND table_name = 'EDW_CT_ExecutionLog') 
            BEGIN
                ALTER TABLE EDW_CT_ExecutionLog
                ADD
                            CT_Updates bigint NULL;
            END;
        IF NOT EXISTS ( SELECT
                               column_name
                               FROM information_schema.columns
                               WHERE
                               column_name = 'CT_Deletes'
                           AND table_name = 'EDW_CT_ExecutionLog') 
            BEGIN
                ALTER TABLE EDW_CT_ExecutionLog
                ADD
                            CT_Deletes bigint NULL;
            END;
    END;
GO

PRINT 'CREATED Table EDW_CT_ExecutionLog';
GO

PRINT 'CREATING PROC proc_EDW_CT_ExecutionLog_Update';
GO

IF EXISTS ( SELECT
                   name
                   FROM sys.procedures
                   WHERE name = 'proc_EDW_CT_ExecutionLog_Update') 
    BEGIN
        DROP PROCEDURE
             proc_EDW_CT_ExecutionLog_Update;
    END;

GO

IF EXISTS ( SELECT
                   name
                   FROM sys.procedures
                   WHERE name = 'proc_EDW_CT_ExecutionLog_Update_Counts') 
    BEGIN
        DROP PROCEDURE
             proc_EDW_CT_ExecutionLog_Update_Counts;
    END;

GO

CREATE PROCEDURE proc_EDW_CT_ExecutionLog_Update_Counts (
       @RecordID AS uniqueidentifier
     , @TypeAction AS char (1) 
     , @iCnt AS bigint = 0) 
AS
BEGIN

/*
    @TypeAction:
    T = Total of processed records.
    I = Update the count of inserted records
    U = Update the count of updated records
    D = Update the count of flaged as deleted records
    */

    IF @TypeAction = 'T'
        BEGIN
            DECLARE
                   @TotRecs AS bigint = (SELECT
                                                ISNULL (CT_INSERTs, 0) + ISNULL (CT_Updates, 0) + ISNULL (CT_Deletes, 0) 
                                                FROM EDW_CT_ExecutionLog
                                                WHERE RecordID = @RecordID);

            IF @iCnt > 0
                BEGIN
                    PRINT 'Executing Log Update T0 on ' + CAST (@iCnt AS nvarchar (50)) + ' records.';
                    UPDATE dbo.EDW_CT_ExecutionLog
                           SET
                               CT_RecordsProcessed = @iCnt
                    WHERE
                          RecordID = @RecordID;
                END;
            ELSE
                BEGIN
                    PRINT 'Executing Log Update T1 on ' + CAST (@TotRecs AS nvarchar (50)) + ' records.';
                    UPDATE dbo.EDW_CT_ExecutionLog
                           SET
                               CT_RecordsProcessed = @TotRecs
                    WHERE
                          RecordID = @RecordID;
                END;
        END;
    IF @TypeAction = 'I'
        BEGIN
            UPDATE dbo.EDW_CT_ExecutionLog
                   SET
                       CT_Inserts = @iCnt
            WHERE
                  RecordID = @RecordID;
        END;
    IF @TypeAction = 'U'
        BEGIN
            UPDATE dbo.EDW_CT_ExecutionLog
                   SET
                       CT_Updates = @iCnt
            WHERE
                  RecordID = @RecordID;
        END;
    IF @TypeAction = 'D'
        BEGIN
            UPDATE dbo.EDW_CT_ExecutionLog
                   SET
                       CT_Deletes = @iCnt
            WHERE
                  RecordID = @RecordID;
        END;
END;
GO
CREATE PROCEDURE proc_EDW_CT_ExecutionLog_Update (
       @RecordID AS uniqueidentifier
     , @CT_NAME AS nvarchar (80) 
     , @CT_DateTimeNow AS datetime
     , @CT_RecordsProcessed AS bigint = 0
     , @Action AS nvarchar (5)) 
AS
BEGIN
    IF @Action = 'I'
        BEGIN
            INSERT INTO dbo.EDW_CT_ExecutionLog (
                   CT_NAME
                 , CT_Start
                 , CT_End
                 , CT_TotalMinutes
                 , CT_RecordsProcessed
                 , RecordID) 
            VALUES
                   (
                   @CT_NAME , @CT_DateTimeNow , NULL , NULL , NULL , @RecordID) ;
        END;
    IF @Action = 'U'
        BEGIN
            --declare @STime as datetime = getdate() -1 ;
            --declare @CT_DateTimeNow as datetime = getdate();
            --select DATEDIFF (MINUTE, @STime , @CT_DateTimeNow);
            DECLARE
                   @STime AS datetime = ( SELECT
                                                 CT_Start
                                                 FROM EDW_CT_ExecutionLog
                                                 WHERE RecordID = @RecordID );

            PRINT '@Stime = ' + CAST ( @Stime AS nvarchar ( 50)) ;
            DECLARE
                   @Mins AS int = DATEDIFF ( MINUTE , @STime , @CT_DateTimeNow) ;
            PRINT '@Mins = ' + CAST ( @Mins AS nvarchar ( 50)) ;
            UPDATE dbo.EDW_CT_ExecutionLog
                   SET
                       CT_End = @CT_DateTimeNow
                     ,CT_TotalMinutes = DATEDIFF ( MINUTE , @STime , @CT_DateTimeNow) 
                     ,CT_RecordsProcessed = @CT_RecordsProcessed
            WHERE
                  RecordID = @RecordID;

        END;

END;

GO
PRINT 'CREATED PROC proc_EDW_CT_ExecutionLog_Update';
GO

--Test the PROC

/*
declare @RecordID AS uniqueidentifier = newid();
declare @CT_NAME as nvarchar(50) = 'TESTRUN' ;
declare @CT_DateTimeNow as datetime = getdate() -1 ;
declare @CT_RecordsProcessed as bigint = 0 ; 
declare @Action AS nvarchar (5) = 'I';

exec proc_EDW_CT_ExecutionLog_Update @RecordID, @CT_NAME, @CT_DateTimeNow, @CT_RecordsProcessed, 'I';
select * from EDW_CT_ExecutionLog ;
set @CT_DateTimeNow = getdate() ;
set @CT_RecordsProcessed = 9999;
exec proc_EDW_CT_ExecutionLog_Update @RecordID, @CT_NAME, @CT_DateTimeNow, @CT_RecordsProcessed, 'U';
select * from EDW_CT_ExecutionLog ;
truncate table EDW_CT_ExecutionLog;
*/--**************
print('END: ' + cast(getdate() as nvarchar(50)));
print('@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-');
print'***************************************************************' ;
print('START: ' + cast(getdate() as nvarchar(50)));
--**************

--SET ANSI_NULLS ON;
--SET ANSI_PADDING ON;
--SET ANSI_WARNINGS ON;
--SET ARITHABORT ON;
--SET CONCAT_NULL_YIELDS_NULL ON;
--SET NUMERIC_ROUNDABORT OFF;
--SET QUOTED_IDENTIFIER ON;





/*---------------------------
cms_user	  -> DONE
cms_usersettings	  -> DONE
cms_usersite	  -> DONE
hfit_ppteligibility	  -> DONE
cms_usercontact
*/
GO
PRINT 'Executing create_table_STAGING_cms_user.sql';
GO

IF NOT EXISTS (SELECT
                      sys.tables.name AS Table_name
                      FROM
                          sys.change_tracking_tables
                              JOIN sys.tables
                                  ON sys.tables.object_id = sys.change_tracking_tables.object_id
                              JOIN sys.schemas
                                  ON sys.schemas.schema_id = sys.tables.schema_id
                      WHERE sys.tables.name = 'CMS_User') 
    BEGIN
        PRINT 'ADDING Change Tracking to CMS_User';
        ALTER TABLE dbo.CMS_User
            ENABLE CHANGE_TRACKING
                WITH (TRACK_COLUMNS_UPDATED = ON) ;
    END;
ELSE
    BEGIN
        PRINT 'Change Tracking exists on CMS_User';
    END;
GO
IF EXISTS (SELECT
                  name
                  FROM sys.procedures
                  WHERE name = 'proc_Create_Table_STAGING_cms_user') 
    BEGIN
        DROP PROCEDURE
             proc_Create_Table_STAGING_cms_user;
    END;
GO
-- exec proc_Create_Table_STAGING_cms_user
-- select top 100 * from [STAGING_cms_user]
CREATE PROCEDURE proc_Create_Table_STAGING_cms_user
AS
BEGIN

    IF EXISTS (SELECT
                      name
                      FROM sys.tables
                      WHERE name = 'STAGING_cms_user') 
        BEGIN
            DROP TABLE
                 dbo.STAGING_cms_user;
        END;

    SET ANSI_NULLS ON;
    SET QUOTED_IDENTIFIER ON;

    CREATE TABLE dbo.STAGING_cms_user (
                 UserID int IDENTITY (1, 1) 
                            NOT NULL
               , UserName nvarchar (100) NOT NULL
               , FirstName nvarchar (100) NULL
               , MiddleName nvarchar (100) NULL
               , LastName nvarchar (100) NULL
               , FullName nvarchar (450) NULL
               , Email nvarchar (100) NULL
               , UserPassword nvarchar (100) NOT NULL
               , PreferredCultureCode nvarchar (10) NULL
               , PreferredUICultureCode nvarchar (10) NULL
               , UserEnabled bit NOT NULL
               , UserIsEditor bit NOT NULL
               , UserIsGlobalAdministrator bit NOT NULL
               , UserIsExternal bit NULL
               , UserPasswordFormat nvarchar (10) NULL
               , UserCreated datetime2 (7) NULL
               , LastLogon datetime2 (7) NULL
               , UserStartingAliasPath nvarchar (200) NULL
               , UserGUID uniqueidentifier NOT NULL
               , UserLastModified datetime2 (7) NOT NULL
               , UserLastLogonInfo nvarchar (max) NULL
               , UserIsHidden bit NULL
               , UserVisibility nvarchar (max) NULL
               , UserIsDomain bit NULL
               , UserHasAllowedCultures bit NULL
               , UserSiteManagerDisabled bit NULL
               , UserPasswordBuffer nvarchar (2000) NULL
               , UserTokenID uniqueidentifier NULL
               , UserMFRequired bit NULL
               , UserTokenIteration int NULL
               , LastModifiedDate datetime NULL
               , RowNbr int NULL
               , DeletedFlg bit NULL
               , TimeZone nvarchar (10) NULL
               , ConvertedToCentralTime bit NULL
               , SVR nvarchar (100) NOT NULL
               , DBNAME nvarchar (100) NOT NULL
               , SYS_CHANGE_VERSION int NULL
    ) 
    ON [PRIMARY] TEXTIMAGE_ON [PRIMARY];

    ALTER TABLE dbo.STAGING_cms_user
    ADD
                DEFAULT @@servername FOR SVR;
    ALTER TABLE dbo.STAGING_cms_user
    ADD
                DEFAULT DB_NAME () FOR DBNAME;

    SET IDENTITY_INSERT STAGING_cms_user ON;

    CREATE CLUSTERED INDEX PI_STAGING_CMS_USer ON dbo.STAGING_cms_user
    (
    UserID ASC,
    SVR ASC,
    DBNAME ASC,
    SYS_CHANGE_VERSION ASC
    )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];

    INSERT INTO STAGING_cms_user
    (
           UserID
         , UserName
         , FirstName
         , MiddleName
         , LastName
         , FullName
         , Email
         , UserPassword
         , PreferredCultureCode
         , PreferredUICultureCode
         , UserEnabled
         , UserIsEditor
         , UserIsGlobalAdministrator
         , UserIsExternal
         , UserPasswordFormat
         , UserCreated
         , LastLogon
         , UserStartingAliasPath
         , UserGUID
         , UserLastModified
         , UserLastLogonInfo
         , UserIsHidden
         , UserVisibility
         , UserIsDomain
         , UserHasAllowedCultures
         , UserSiteManagerDisabled
         , UserPasswordBuffer
         , UserTokenID
         , UserMFRequired
         , UserTokenIteration) 
    SELECT
           UserID
         , UserName
         , FirstName
         , MiddleName
         , LastName
         , FullName
         , Email
         , UserPassword
         , PreferredCultureCode
         , PreferredUICultureCode
         , UserEnabled
         , UserIsEditor
         , UserIsGlobalAdministrator
         , UserIsExternal
         , UserPasswordFormat
         , UserCreated
         , LastLogon
         , UserStartingAliasPath
         , UserGUID
         , UserLastModified
         , UserLastLogonInfo
         , UserIsHidden
         , UserVisibility
         , UserIsDomain
         , UserHasAllowedCultures
         , UserSiteManagerDisabled
         , UserPasswordBuffer
         , UserTokenID
         , UserMFRequired
         , UserTokenIteration
           FROM cms_user;

    SET IDENTITY_INSERT STAGING_cms_user OFF;

    IF EXISTS (SELECT
                      name
                      FROM sys.tables
                      WHERE name = 'STAGING_cms_user_Update_History') 
        BEGIN
            DROP TABLE
                 STAGING_cms_user_Update_History;
        END;

CREATE TABLE [dbo].[STAGING_CMS_USER_Update_History](
	[Userid] [int] NOT NULL,
	[SYS_CHANGE_VERSION] [bigint] NULL,
	[SYS_CHANGE_OPERATION] [nchar](1) NULL,
	[SYS_CHANGE_COLUMNS] [varbinary](4100) NULL,
	[CurrUser] [varchar](60) NOT NULL,
	[SysUser] [varchar](60) NOT NULL,
	[IPADDR] [varchar](60) NOT NULL,
	[commit_time] [datetime] NOT NULL,
	[LastModifiedDate] [datetime] NOT NULL,
	[SVR] [nvarchar](128) NULL,
	[DBNAME] [nvarchar](128) NULL,
	[Email_cg] [int] NULL,
	[FirstName_cg] [int] NULL,
	[FullName_cg] [int] NULL,
	[LastLogon_cg] [int] NULL,
	[LastName_cg] [int] NULL,
	[MiddleName_cg] [int] NULL,
	[PreferredCultureCode_cg] [int] NULL,
	[PreferredUICultureCode_cg] [int] NULL,
	[UserCreated_cg] [int] NULL,
	[UserEnabled_cg] [int] NULL,
	[UserGUID_cg] [int] NULL,
	[UserHasAllowedCultures_cg] [int] NULL,
	[UserID_cg] [int] NULL,
	[UserIsDomain_cg] [int] NULL,
	[UserIsEditor_cg] [int] NULL,
	[UserIsExternal_cg] [int] NULL,
	[UserIsGlobalAdministrator_cg] [int] NULL,
	[UserIsHidden_cg] [int] NULL,
	[UserLastLogonInfo_cg] [int] NULL,
	[UserLastModified_cg] [int] NULL,
	[UserMFRequired_cg] [int] NULL,
	[UserName_cg] [int] NULL,
	[UserPassword_cg] [int] NULL,
	[UserPasswordBuffer_cg] [int] NULL,
	[UserPasswordFormat_cg] [int] NULL,
	[UserSiteManagerDisabled_cg] [int] NULL,
	[UserStartingAliasPath_cg] [int] NULL,
	[UserTokenID_cg] [int] NULL,
	[UserTokenIteration_cg] [int] NULL,
	[UserVisibility_cg] [int] NULL
)


ALTER TABLE [dbo].[STAGING_CMS_USER_Update_History] ADD  CONSTRAINT [DF_STAGING_cms_user_Update_History_CurrUser]  DEFAULT (user_name()) FOR [CurrUser]

ALTER TABLE [dbo].[STAGING_CMS_USER_Update_History] ADD  CONSTRAINT [DF_STAGING_cms_user_Update_History_SysUser]  DEFAULT (suser_sname()) FOR [SysUser]

ALTER TABLE [dbo].[STAGING_CMS_USER_Update_History] ADD  CONSTRAINT [DF_STAGING_cms_user_Update_History_IPADDR]  DEFAULT (CONVERT([nvarchar](50),connectionproperty('client_net_address'))) FOR [IPADDR]
    
    CREATE CLUSTERED INDEX PI_STAGING_cms_user_Update_History ON dbo.STAGING_cms_user_Update_History
    (
    UserID ASC,
    SVR ASC,
    SYS_CHANGE_VERSION ASC
    )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];


END;

GO
PRINT 'Executed create_table_STAGING_cms_user.sql';
GO
EXEC proc_Create_Table_STAGING_cms_user;
GO
--**************
print('END: ' + cast(getdate() as nvarchar(50)));
print('@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-');
print'***************************************************************' ;
print('START: ' + cast(getdate() as nvarchar(50)));
--**************

--SET ANSI_NULLS ON;
--SET ANSI_PADDING ON;
--SET ANSI_WARNINGS ON;
--SET ARITHABORT ON;
--SET CONCAT_NULL_YIELDS_NULL ON;
--SET NUMERIC_ROUNDABORT OFF;
--SET QUOTED_IDENTIFIER ON;






GO
PRINT 'Executing proc_CMS_User_AddDeletedRecs.sql';
GO
IF EXISTS ( SELECT
                   name
                   FROM sys.procedures
                   WHERE name = 'proc_CMS_User_AddDeletedRecs') 
    BEGIN
        DROP PROCEDURE
             proc_CMS_User_AddDeletedRecs;
    END;
GO
CREATE PROCEDURE proc_CMS_User_AddDeletedRecs
AS
BEGIN

    UPDATE STAGING_cms_user
           SET
               DeletedFlg = 1
             ,LastModifiedDate = GETDATE () 
    WHERE
          UserID IN
          (SELECT
                  UserID
                  FROM CHANGETABLE (CHANGES CMS_USER, NULL) AS CT
                  WHERE SYS_CHANGE_OPERATION = 'D') 
      AND DeletedFlg IS NULL;

    DECLARE
    @iCnt AS int = @@ROWCOUNT;
    PRINT 'Deleted Count: ' + CAST ( @iCnt AS nvarchar (50)) ;

    exec proc_CT_CMS_USER_History 'D'

    RETURN @iCnt;
END;

GO
PRINT 'Executed proc_CMS_User_AddDeletedRecs.sql';
GO
--**************
print('END: ' + cast(getdate() as nvarchar(50)));
print('@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-');
print'***************************************************************' ;
print('START: ' + cast(getdate() as nvarchar(50)));
--**************

--SET ANSI_NULLS ON;
--SET ANSI_PADDING ON;
--SET ANSI_WARNINGS ON;
--SET ARITHABORT ON;
--SET CONCAT_NULL_YIELDS_NULL ON;
--SET NUMERIC_ROUNDABORT OFF;
--SET QUOTED_IDENTIFIER ON;





GO
-- USe KenticoCMS_Prod1

PRINT 'Executing proc_CT_CMS_User_AddNewRecs.sql';
GO
IF EXISTS ( SELECT
                   name
                   FROM sys.procedures
                   WHERE name = 'proc_CT_CMS_User_AddNewRecs') 
    BEGIN
        DROP PROCEDURE
             proc_CT_CMS_User_AddNewRecs;
    END;
GO
-- proc_CT_CMS_User_AddNewRecs
CREATE PROCEDURE proc_CT_CMS_User_AddNewRecs
AS
BEGIN

    SET IDENTITY_INSERT STAGING_cms_user ON;

    WITH CTE (
         UserID) 
        AS ( SELECT
                    UserID
                    FROM cms_user
             EXCEPT
             SELECT
                    UserID
                    FROM STAGING_cms_user
                    WHERE DeletedFlg IS NULL) 
        INSERT INTO STAGING_cms_user
        (
               UserID
             , UserName
             , FirstName
             , MiddleName
             , LastName
             , FullName
             , Email
             , UserPassword
             , PreferredCultureCode
             , PreferredUICultureCode
             , UserEnabled
             , UserIsEditor
             , UserIsGlobalAdministrator
             , UserIsExternal
             , UserPasswordFormat
             , UserCreated
             , LastLogon
             , UserStartingAliasPath
             , UserGUID
             , UserLastModified
             , UserLastLogonInfo
             , UserIsHidden
             , UserVisibility
             , UserIsDomain
             , UserHasAllowedCultures
             , UserSiteManagerDisabled
             , UserPasswordBuffer
             , UserTokenID
             , UserMFRequired
             , UserTokenIteration
             , LastModifiedDate
               --,[RowNbr]
             , DeletedFlg
             , TimeZone
             , ConvertedToCentralTime
             , SVR
             , DBNAME
             , SYS_CHANGE_VERSION) 
        SELECT
               T.UserID
             , T.UserName
             , T.FirstName
             , T.MiddleName
             , T.LastName
             , T.FullName
             , T.Email
             , T.UserPassword
             , T.PreferredCultureCode
             , T.PreferredUICultureCode
             , T.UserEnabled
             , T.UserIsEditor
             , T.UserIsGlobalAdministrator
             , T.UserIsExternal
             , T.UserPasswordFormat
             , T.UserCreated
             , T.LastLogon
             , T.UserStartingAliasPath
             , T.UserGUID
             , T.UserLastModified
             , T.UserLastLogonInfo
             , T.UserIsHidden
             , T.UserVisibility
             , T.UserIsDomain
             , T.UserHasAllowedCultures
             , T.UserSiteManagerDisabled
             , T.UserPasswordBuffer
             , T.UserTokenID
             , T.UserMFRequired
             , T.UserTokenIteration
             , GETDATE () AS LastModifiedDate
             , NULL AS DeletedFlg
             , NULL AS TimeZone
             , NULL AS ConvertedToCentralTime
             , @@SERVERNAME AS SVR
             , DB_NAME () AS DBNAME
             , NULL AS SYS_CHANGE_VERSION
               FROM
                   cms_user AS T
                       JOIN CTE AS S
                           ON S.UserID = T.UserID;
    DECLARE
    @iInserts AS int = @@ROWCOUNT;
    SET IDENTITY_INSERT STAGING_cms_user OFF;
    PRINT 'NEW Insert Count: ' + CAST ( @iInserts AS nvarchar (50)) ;

    exec proc_CT_CMS_USER_History 'I'

    RETURN @iInserts;
END;

GO
PRINT 'Executed proc_CT_CMS_User_AddNewRecs.sql';
GO
--**************
print('END: ' + cast(getdate() as nvarchar(50)));
print('@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-');
print'***************************************************************' ;
print('START: ' + cast(getdate() as nvarchar(50)));
--**************

--SET ANSI_NULLS ON;
--SET ANSI_PADDING ON;
--SET ANSI_WARNINGS ON;
--SET ARITHABORT ON;
--SET CONCAT_NULL_YIELDS_NULL ON;
--SET NUMERIC_ROUNDABORT OFF;
--SET QUOTED_IDENTIFIER ON;





GO
PRINT 'Executing proc_CT_CMS_USER_AddUpdatedRecs.sql';
GO
IF EXISTS ( SELECT
                   name
                   FROM sys.procedures
                   WHERE name = 'proc_CT_CMS_USER_AddUpdatedRecs') 
    BEGIN
        DROP PROCEDURE
             proc_CT_CMS_USER_AddUpdatedRecs;
    END;
GO
/*----------------------------------------------------------------------------------------------------------------------------------------------------------
    select top 100 * from CMS_USER
    update CMS_USER set LastName = LastName where UserID in (select top 50 UserID from CMS_USER order by UserID )
    update CMS_USER set UserName = UserName where UserID in (select top 50 UserID from CMS_USER order by UserID desc)
    update CMS_USER set MiddleName = MiddleName where UserID in (select top 100 UserID from CMS_USER order by UserID desc)
    update CMS_USER set Email = Email,PreferredCultureCode = PreferredCultureCode where UserID in (select top 100 UserID from CMS_USER order by UserID desc)

    exec proc_CT_CMS_USER_AddUpdatedRecs

    select * from STAGING_CMS_USER where SYS_CHANGE_VERSION is not null
    select * from STAGING_CMS_USER_Update_History
*/

CREATE PROCEDURE proc_CT_CMS_USER_AddUpdatedRecs
AS
BEGIN
    WITH CTE (
         UserID
       , SYS_CHANGE_VERSION
       , SYS_CHANGE_OPERATION
       , SYS_CHANGE_COLUMNS) 
        AS ( SELECT
                    CT.UserID
                  , CT.SYS_CHANGE_VERSION
                  , CT.SYS_CHANGE_OPERATION
                  , SYS_CHANGE_COLUMNS
                    FROM CHANGETABLE (CHANGES CMS_USER, NULL) AS CT
                    WHERE SYS_CHANGE_OPERATION = 'U') 
        UPDATE S
               SET
                   S.UserName = T.UserName
                 ,S.FirstName = T.FirstName
                 ,S.MiddleName = T.MiddleName
                 ,S.LastName = T.LastName
                 ,S.FullName = T.FullName
                 ,S.Email = T.Email
                 ,S.UserPassword = T.UserPassword
                 ,S.PreferredCultureCode = T.PreferredCultureCode
                 ,S.PreferredUICultureCode = T.PreferredUICultureCode
                 ,S.UserEnabled = T.UserEnabled
                 ,S.UserIsEditor = T.UserIsEditor
                 ,S.UserIsGlobalAdministrator = T.UserIsGlobalAdministrator
                 ,S.UserIsExternal = T.UserIsExternal
                 ,S.UserPasswordFormat = T.UserPasswordFormat
                 ,S.UserCreated = T.UserCreated
                 ,S.LastLogon = T.LastLogon
                 ,S.UserStartingAliasPath = T.UserStartingAliasPath
                 ,S.UserGUID = T.UserGUID
                 ,S.UserLastModified = T.UserLastModified
                 ,S.UserLastLogonInfo = T.UserLastLogonInfo
                 ,S.UserIsHidden = T.UserIsHidden
                 ,S.UserVisibility = T.UserVisibility
                 ,S.UserIsDomain = T.UserIsDomain
                 ,S.UserHasAllowedCultures = T.UserHasAllowedCultures
                 ,S.UserSiteManagerDisabled = T.UserSiteManagerDisabled
                 ,S.UserPasswordBuffer = T.UserPasswordBuffer
                 ,S.UserTokenID = T.UserTokenID
                 ,S.UserMFRequired = T.UserMFRequired
                 ,S.UserTokenIteration = T.UserTokenIteration
                 ,S.LastModifiedDate = GETDATE () 
                 ,S.DeletedFlg = NULL
                 ,S.ConvertedToCentralTime = NULL
                 ,S.SYS_CHANGE_VERSION = CTE.SYS_CHANGE_VERSION
                   FROM STAGING_CMS_USER AS S
                            JOIN
                            CMS_USER AS T
                                ON
                                S.UserID = T.UserID
                            AND S.DeletedFlg IS NULL
                            JOIN CTE
                                ON CTE.Userid = T.UserID
                               AND (CTE.SYS_CHANGE_VERSION != S.SYS_CHANGE_VERSION
                                 OR S.SYS_CHANGE_VERSION IS NULL);

    DECLARE
    @iCnt AS int = @@ROWCOUNT;

    PRINT 'Updated Count: ' + CAST ( @iCnt AS nvarchar (50)) ;

    exec proc_CT_CMS_USER_History 'U'

    --WITH CTE (
    --     UserID
    --   , SYS_CHANGE_VERSION
    --   , SYS_CHANGE_COLUMNS) 
    --    AS ( SELECT
    --                CT.UserID
    --              , CT.SYS_CHANGE_VERSION
    --              , SYS_CHANGE_COLUMNS
    --                FROM CHANGETABLE (CHANGES CMS_USER, NULL) AS CT
    --                WHERE SYS_CHANGE_OPERATION = 'U'
    --         EXCEPT
    --         SELECT
    --                UserID
    --              , SYS_CHANGE_VERSION
    --              , SYS_CHANGE_COLUMNS
    --                FROM STAGING_CMS_USER_Update_History
    --    ) 
    --    INSERT INTO STAGING_CMS_USER_Update_History
    --    (
    --           UserID
    --         , LastModifiedDate
    --         , SVR
    --         , DBNAME
    --         , SYS_CHANGE_VERSION
    --         , SYS_CHANGE_COLUMNS
    --         , commit_time) 
    --    SELECT
    --           CTE.UserID
    --         , GETDATE () AS LastModifiedDate
    --         , @@SERVERNAME AS SVR
    --         , DB_NAME () AS DBNAME
    --         , CTE.SYS_CHANGE_VERSION
    --         , CTE.SYS_CHANGE_COLUMNS
    --         , isnull(tc.commit_time, getdate())
    --           FROM
    --               CTE
    --                   JOIN sys.dm_tran_commit_table AS tc
    --                       ON CTE.sys_change_version = tc.commit_ts;

    RETURN @iCnt;
END;

GO
PRINT 'Executed proc_CT_CMS_USER_AddUpdatedRecs.sql';
GO
 --**************
print('END: ' + cast(getdate() as nvarchar(50)));
print('@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-');
print'***************************************************************' ;
print('START: ' + cast(getdate() as nvarchar(50)));
--**************

--SET ANSI_NULLS ON;
--SET ANSI_PADDING ON;
--SET ANSI_WARNINGS ON;
--SET ARITHABORT ON;
--SET CONCAT_NULL_YIELDS_NULL ON;
--SET NUMERIC_ROUNDABORT OFF;
--SET QUOTED_IDENTIFIER ON;





/*---------------------------
cms_user	  -> DONE
cms_usersettings	  -> DONE
cms_usersite	  -> DONE
hfit_ppteligibility	  -> DONE
cms_usercontact
*/
GO
PRINT 'Executing create_table_STAGING_cms_user.sql';
GO

IF NOT EXISTS (SELECT
                      sys.tables.name AS Table_name
                      FROM
                          sys.change_tracking_tables
                              JOIN sys.tables
                                  ON sys.tables.object_id = sys.change_tracking_tables.object_id
                              JOIN sys.schemas
                                  ON sys.schemas.schema_id = sys.tables.schema_id
                      WHERE sys.tables.name = 'CMS_User') 
    BEGIN
        PRINT 'ADDING Change Tracking to CMS_User';
        ALTER TABLE dbo.CMS_User
            ENABLE CHANGE_TRACKING
                WITH (TRACK_COLUMNS_UPDATED = ON) ;
    END;
ELSE
    BEGIN
        PRINT 'Change Tracking exists on CMS_User';
    END;
GO
IF EXISTS (SELECT
                  name
                  FROM sys.procedures
                  WHERE name = 'proc_Create_Table_STAGING_cms_user') 
    BEGIN
        DROP PROCEDURE
             proc_Create_Table_STAGING_cms_user;
    END;
GO
-- exec proc_Create_Table_STAGING_cms_user
-- select top 100 * from [STAGING_cms_user]
CREATE PROCEDURE proc_Create_Table_STAGING_cms_user
AS
BEGIN

    IF EXISTS (SELECT
                      name
                      FROM sys.tables
                      WHERE name = 'STAGING_cms_user') 
        BEGIN
            DROP TABLE
                 dbo.STAGING_cms_user;
        END;

    SET ANSI_NULLS ON;
    SET QUOTED_IDENTIFIER ON;

    CREATE TABLE dbo.STAGING_cms_user (
                 UserID int IDENTITY (1, 1) 
                            NOT NULL
               , UserName nvarchar (100) NOT NULL
               , FirstName nvarchar (100) NULL
               , MiddleName nvarchar (100) NULL
               , LastName nvarchar (100) NULL
               , FullName nvarchar (450) NULL
               , Email nvarchar (100) NULL
               , UserPassword nvarchar (100) NOT NULL
               , PreferredCultureCode nvarchar (10) NULL
               , PreferredUICultureCode nvarchar (10) NULL
               , UserEnabled bit NOT NULL
               , UserIsEditor bit NOT NULL
               , UserIsGlobalAdministrator bit NOT NULL
               , UserIsExternal bit NULL
               , UserPasswordFormat nvarchar (10) NULL
               , UserCreated datetime2 (7) NULL
               , LastLogon datetime2 (7) NULL
               , UserStartingAliasPath nvarchar (200) NULL
               , UserGUID uniqueidentifier NOT NULL
               , UserLastModified datetime2 (7) NOT NULL
               , UserLastLogonInfo nvarchar (max) NULL
               , UserIsHidden bit NULL
               , UserVisibility nvarchar (max) NULL
               , UserIsDomain bit NULL
               , UserHasAllowedCultures bit NULL
               , UserSiteManagerDisabled bit NULL
               , UserPasswordBuffer nvarchar (2000) NULL
               , UserTokenID uniqueidentifier NULL
               , UserMFRequired bit NULL
               , UserTokenIteration int NULL
               , LastModifiedDate datetime NULL
               , RowNbr int NULL
               , DeletedFlg bit NULL
               , TimeZone nvarchar (10) NULL
               , ConvertedToCentralTime bit NULL
               , SVR nvarchar (100) NOT NULL
               , DBNAME nvarchar (100) NOT NULL
               , SYS_CHANGE_VERSION int NULL
    ) 
    ON [PRIMARY] TEXTIMAGE_ON [PRIMARY];

    ALTER TABLE dbo.STAGING_cms_user
    ADD
                DEFAULT @@servername FOR SVR;
    ALTER TABLE dbo.STAGING_cms_user
    ADD
                DEFAULT DB_NAME () FOR DBNAME;

    SET IDENTITY_INSERT STAGING_cms_user ON;

    CREATE CLUSTERED INDEX PI_STAGING_CMS_USer ON dbo.STAGING_cms_user
    (
    UserID ASC,
    SVR ASC,
    DBNAME ASC,
    SYS_CHANGE_VERSION ASC
    )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];

    INSERT INTO STAGING_cms_user
    (
           UserID
         , UserName
         , FirstName
         , MiddleName
         , LastName
         , FullName
         , Email
         , UserPassword
         , PreferredCultureCode
         , PreferredUICultureCode
         , UserEnabled
         , UserIsEditor
         , UserIsGlobalAdministrator
         , UserIsExternal
         , UserPasswordFormat
         , UserCreated
         , LastLogon
         , UserStartingAliasPath
         , UserGUID
         , UserLastModified
         , UserLastLogonInfo
         , UserIsHidden
         , UserVisibility
         , UserIsDomain
         , UserHasAllowedCultures
         , UserSiteManagerDisabled
         , UserPasswordBuffer
         , UserTokenID
         , UserMFRequired
         , UserTokenIteration) 
    SELECT
           UserID
         , UserName
         , FirstName
         , MiddleName
         , LastName
         , FullName
         , Email
         , UserPassword
         , PreferredCultureCode
         , PreferredUICultureCode
         , UserEnabled
         , UserIsEditor
         , UserIsGlobalAdministrator
         , UserIsExternal
         , UserPasswordFormat
         , UserCreated
         , LastLogon
         , UserStartingAliasPath
         , UserGUID
         , UserLastModified
         , UserLastLogonInfo
         , UserIsHidden
         , UserVisibility
         , UserIsDomain
         , UserHasAllowedCultures
         , UserSiteManagerDisabled
         , UserPasswordBuffer
         , UserTokenID
         , UserMFRequired
         , UserTokenIteration
           FROM cms_user;

    SET IDENTITY_INSERT STAGING_cms_user OFF;

    IF EXISTS (SELECT
                      name
                      FROM sys.tables
                      WHERE name = 'STAGING_cms_user_Update_History') 
        BEGIN
            DROP TABLE
                 STAGING_cms_user_Update_History;
        END;

CREATE TABLE [dbo].[STAGING_CMS_USER_Update_History](
	[Userid] [int] NOT NULL,
	[SYS_CHANGE_VERSION] [bigint] NULL,
	[SYS_CHANGE_OPERATION] [nchar](1) NULL,
	[SYS_CHANGE_COLUMNS] [varbinary](4100) NULL,
	[CurrUser] [varchar](60) NOT NULL,
	[SysUser] [varchar](60) NOT NULL,
	[IPADDR] [varchar](60) NOT NULL,
	[commit_time] [datetime] NOT NULL,
	[LastModifiedDate] [datetime] NOT NULL,
	[SVR] [nvarchar](128) NULL,
	[DBNAME] [nvarchar](128) NULL,
	[Email_cg] [int] NULL,
	[FirstName_cg] [int] NULL,
	[FullName_cg] [int] NULL,
	[LastLogon_cg] [int] NULL,
	[LastName_cg] [int] NULL,
	[MiddleName_cg] [int] NULL,
	[PreferredCultureCode_cg] [int] NULL,
	[PreferredUICultureCode_cg] [int] NULL,
	[UserCreated_cg] [int] NULL,
	[UserEnabled_cg] [int] NULL,
	[UserGUID_cg] [int] NULL,
	[UserHasAllowedCultures_cg] [int] NULL,
	[UserID_cg] [int] NULL,
	[UserIsDomain_cg] [int] NULL,
	[UserIsEditor_cg] [int] NULL,
	[UserIsExternal_cg] [int] NULL,
	[UserIsGlobalAdministrator_cg] [int] NULL,
	[UserIsHidden_cg] [int] NULL,
	[UserLastLogonInfo_cg] [int] NULL,
	[UserLastModified_cg] [int] NULL,
	[UserMFRequired_cg] [int] NULL,
	[UserName_cg] [int] NULL,
	[UserPassword_cg] [int] NULL,
	[UserPasswordBuffer_cg] [int] NULL,
	[UserPasswordFormat_cg] [int] NULL,
	[UserSiteManagerDisabled_cg] [int] NULL,
	[UserStartingAliasPath_cg] [int] NULL,
	[UserTokenID_cg] [int] NULL,
	[UserTokenIteration_cg] [int] NULL,
	[UserVisibility_cg] [int] NULL
)


ALTER TABLE [dbo].[STAGING_CMS_USER_Update_History] ADD  CONSTRAINT [DF_STAGING_cms_user_Update_History_CurrUser]  DEFAULT (user_name()) FOR [CurrUser]

ALTER TABLE [dbo].[STAGING_CMS_USER_Update_History] ADD  CONSTRAINT [DF_STAGING_cms_user_Update_History_SysUser]  DEFAULT (suser_sname()) FOR [SysUser]

ALTER TABLE [dbo].[STAGING_CMS_USER_Update_History] ADD  CONSTRAINT [DF_STAGING_cms_user_Update_History_IPADDR]  DEFAULT (CONVERT([nvarchar](50),connectionproperty('client_net_address'))) FOR [IPADDR]
    
    CREATE CLUSTERED INDEX PI_STAGING_cms_user_Update_History ON dbo.STAGING_cms_user_Update_History
    (
    UserID ASC,
    SVR ASC,
    SYS_CHANGE_VERSION ASC
    )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];


END;

GO
PRINT 'Executed create_table_STAGING_cms_user.sql';
GO
EXEC proc_Create_Table_STAGING_cms_user;
GO
--**************
print('END: ' + cast(getdate() as nvarchar(50)));
print('@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-');
print'***************************************************************' ;
print('START: ' + cast(getdate() as nvarchar(50)));
--**************

--SET ANSI_NULLS ON;
--SET ANSI_PADDING ON;
--SET ANSI_WARNINGS ON;
--SET ARITHABORT ON;
--SET CONCAT_NULL_YIELDS_NULL ON;
--SET NUMERIC_ROUNDABORT OFF;
--SET QUOTED_IDENTIFIER ON;






GO
-- use KenticoCMS_Prod1

/*---------------------------------------
Developer  : W. Dale Miller
05.28.2015 : WDM - completed unit testing
*/

GO
PRINT 'creating proc_STAGING_EDW_CT_USER';
PRINT GETDATE () ;
GO

IF EXISTS ( SELECT
                   name
                   FROM sys.procedures
                   WHERE name = 'proc_STAGING_EDW_CT_USER') 
    BEGIN
        PRINT 'UPDATING proc_STAGING_EDW_CT_USER';
        DROP PROCEDURE
             proc_STAGING_EDW_CT_USER;
    END;

GO

-- exec proc_STAGING_EDW_CT_USER

CREATE PROCEDURE proc_STAGING_EDW_CT_USER (
     @ReloadAll AS int = 0) 
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE
    @iTotal AS bigint = 0;

    EXEC @iTotal = proc_QuickRowCount 'STAGING_cms_user';

    IF @iTotal <= 1
        BEGIN
            SET @Reloadall = 1;
        END;

    --******************************************************************************************************************************
    -- This procedure is added to the job job_EDW_GetStagingData_RewardUserDetail and set to run automatically on a schedule.
    --******************************************************************************************************************************

    BEGIN

        IF @ReloadAll IS NULL
            BEGIN
                SET @ReloadAll = 0;
            END;

        DECLARE
        @RecordID AS uniqueidentifier = NEWID () ;
        DECLARE
        @CT_DateTimeNow AS datetime = GETDATE () ;
        DECLARE
        @CT_NAME AS nvarchar ( 50) = 'proc_STAGING_EDW_CT_USER';
        EXEC proc_EDW_CT_ExecutionLog_Update @RecordID , @CT_NAME , @CT_DateTimeNow , 0 , 'I';

        IF @ReloadAll = 1
            BEGIN
                PRINT 'RELOADING ALL Change Tracking CT_USER records';
                EXEC proc_Create_Table_STAGING_cms_user ;
                PRINT 'RELOAD COMPLETE';
            END;
        ELSE
            BEGIN
                EXEC proc_CT_CMS_User_AddNewRecs ;
                EXEC proc_CT_CMS_USER_AddUpdatedRecs ;
                EXEC proc_CMS_User_AddDeletedRecs ;
            END;

    END;
END;

GO
PRINT 'CREATED proc_STAGING_EDW_CT_USER';
PRINT GETDATE () ;
GO--**************
print('END: ' + cast(getdate() as nvarchar(50)));
print('@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-');
print'***************************************************************' ;
print('START: ' + cast(getdate() as nvarchar(50)));
--**************

--SET ANSI_NULLS ON;
--SET ANSI_PADDING ON;
--SET ANSI_WARNINGS ON;
--SET ARITHABORT ON;
--SET CONCAT_NULL_YIELDS_NULL ON;
--SET NUMERIC_ROUNDABORT OFF;
--SET QUOTED_IDENTIFIER ON;





GO
PRINT 'Creating JOB job_EDW_GetStagingData_CT_USER';
GO

BEGIN TRANSACTION;
DECLARE
@ReturnCode int;
SELECT
       @ReturnCode = 0;

IF NOT EXISTS ( SELECT
                       name
                       FROM msdb.dbo.syscategories
                       WHERE
                       name = N'[Uncategorized (Local)]'
                   AND category_class = 1) 
    BEGIN EXEC @ReturnCode = msdb.dbo.sp_add_category @class = N'JOB' , @type = N'LOCAL' , @name = N'[Uncategorized (Local)]';
        IF
        @@ERROR <> 0
     OR @ReturnCode <> 0
            BEGIN
                GOTO QuitWithRollback;
            END;

    END;

DECLARE
@TGTDB AS nvarchar ( 50) = DB_NAME () ;

DECLARE
@JNAME AS nvarchar ( 100) = 'job_EDW_GetStagingData_CT_USER_' + @TGTDB;

IF EXISTS ( SELECT
                   job_id
                   FROM msdb.dbo.sysjobs_view
                   WHERE name = @JNAME) 
    BEGIN EXEC msdb.dbo.sp_delete_job @job_name = @JNAME , @delete_unused_schedule = 1;
    END;

DECLARE
@jobId binary ( 16) ;
EXEC @ReturnCode = msdb.dbo.sp_add_job @job_name = @JNAME , @enabled = 1 , @notify_level_eventlog = 2 , @notify_level_email = 2 , @notify_level_netsend = 0 , @notify_level_page = 0 , @delete_level = 0 , @description = N'No description available.' , @category_name = N'[Uncategorized (Local)]' , @owner_login_name = N'sa' , @notify_email_operator_name = N'DBA_Notify' , @job_id = @jobId OUTPUT;
IF
@@ERROR <> 0
OR @ReturnCode <> 0
    BEGIN
        GOTO QuitWithRollback;
    END;

/*---------------------------------------------------------------------------------------
***** Object:  Step [Load_STAGING_EDW_CT_USER]    Script Date: 4/12/2015 9:59:37 AM *****
*/

EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id = @jobId , @step_name = N'Load_STAGING_EDW_CT_USER' , @step_id = 1 , @cmdexec_success_code = 0 , @on_success_action = 1 , @on_success_step_id = 0 , @on_fail_action = 2 , @on_fail_step_id = 0 , @retry_attempts = 0 , @retry_interval = 0 , @os_run_priority = 0 , @subsystem = N'TSQL' , @command = N'exec proc_STAGING_EDW_CT_USER;' , @database_name = @TGTDB , @flags = 0;
IF
@@ERROR <> 0
OR @ReturnCode <> 0
    BEGIN
        GOTO QuitWithRollback;
    END;
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId , @start_step_id = 1;
IF
@@ERROR <> 0
OR @ReturnCode <> 0
    BEGIN
        GOTO QuitWithRollback;
    END;
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id = @jobId , @name = N'Schedule_STAGING_EDW_CT_USER' , @enabled = 1 , @freq_type = 4 , @freq_interval = 1 , @freq_subday_type = 8 , @freq_subday_interval = 8 , @freq_relative_interval = 0 , @freq_recurrence_factor = 0 , @active_start_date = 20150412 , @active_end_date = 99991231 , @active_start_time = 10000 ,
@active_end_time = 235959;
--@schedule_uid = N'afcb6980-89fe-4a08-ad03-6598bd55454a';
IF
@@ERROR <> 0
OR @ReturnCode <> 0
    BEGIN
        GOTO QuitWithRollback;
    END;
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId , @server_name = N'(local)';
IF
@@ERROR <> 0
OR @ReturnCode <> 0
    BEGIN
        GOTO QuitWithRollback;
    END;
COMMIT TRANSACTION;
GOTO EndSave;
QuitWithRollback:
IF @@TRANCOUNT > 0
    BEGIN
        ROLLBACK TRANSACTION;
    END;
EndSave:

PRINT 'CREATED JOB ' + @JNAME;

GO



--**************
print('END: ' + cast(getdate() as nvarchar(50)));
print('@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-');
print'***************************************************************' ;
print('START: ' + cast(getdate() as nvarchar(50)));
--**************

--SET ANSI_NULLS ON;
--SET ANSI_PADDING ON;
--SET ANSI_WARNINGS ON;
--SET ARITHABORT ON;
--SET CONCAT_NULL_YIELDS_NULL ON;
--SET NUMERIC_ROUNDABORT OFF;
--SET QUOTED_IDENTIFIER ON;






GO
PRINT 'Executing TRIG_CMS_User_Audit.SQL';
GO
-- select count(*) from STAGING_CMS_User_Audit
-- select * from STAGING_CMS_User_Audit
-- truncate table STAGING_CMS_User_Audit

IF EXISTS (SELECT
                  name
                  FROM sys.tables
                  WHERE name = 'STAGING_CMS_User_Audit') 
    BEGIN
        DROP TABLE
             STAGING_CMS_User_Audit;
    END;
GO

CREATE TABLE dbo.STAGING_CMS_User_Audit (
             UserID int NOT NULL
           , SVR nvarchar (100) NOT NULL
           , DBNAME nvarchar (100) NOT NULL
           , SYS_CHANGE_VERSION int NULL
           , SYS_CHANGE_OPERATION nvarchar (10) NULL
           , SchemaName nvarchar (100) NULL
           , SysUser nvarchar (100) NULL
           , IPADDR  nvarchar (50) NULL
           , Processed integer NULL
           , TBL nvarchar (100) NULL
           , CreateDate datetime NULL
           , commit_time datetime NULL
);
GO
ALTER TABLE dbo.STAGING_CMS_User_Audit
ADD
            CONSTRAINT DF_STAGING_CMS_User_Audit_CreateDate  DEFAULT GETDATE () FOR CreateDate;
GO
CREATE CLUSTERED INDEX PK_CMS_User_Audit ON dbo.STAGING_CMS_User_Audit
(
UserID ASC,
SVR ASC,
SYS_CHANGE_VERSION ASC,
SYS_CHANGE_OPERATION ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];

GO

/*---------------------------------------------------------------------------------------------------------------
-- TROUBLESHOOTING AND TESTING QRYS
	select count(*) from CMS_User where UserID = 53 and SiteID = 36
	INSERT INTO CMS_User (UserID, SiteID) VALUES (53, 36) ;
	delete from CMS_User where UserID = 53 and SiteID = 36
	select top 1000 * from CMS_User
	select top 1000 * from CMS_User
	update CMS_User set FirstName = FirstName where UserID in (Select top 100 UserID from CMS_User order by UserID )
	select * from STAGING_CMS_User_Audit
	truncate table  STAGING_CMS_User_Audit
*/

IF EXISTS (SELECT
                  name
                  FROM sys.triggers
                  WHERE name = 'trig_INS_CMS_User_Audit') 
    BEGIN
        DROP TRIGGER
             trig_INS_CMS_User_Audit;
    END;
GO

CREATE TRIGGER trig_INS_CMS_User_Audit ON CMS_User
    AFTER INSERT
AS
BEGIN

    DECLARE @svr nvarchar (100) = (SELECT
                                          @@SERVERNAME);
    DECLARE @db nvarchar (100) = (SELECT
                                         DB_NAME ());
    DECLARE @CHG_VER int = (SELECT
                                   MAX (CT.SYS_CHANGE_VERSION) 
                                   FROM CHANGETABLE (CHANGES CMS_User, NULL) AS CT);
    DECLARE @ipaddr nvarchar (50) = (SELECT
                                            CAST (CONNECTIONPROPERTY ('client_net_address') AS nvarchar (50)) );
    DECLARE @userid nvarchar (50) = (SELECT
                                            USER_NAME () );
    DECLARE @sysuser nvarchar (50) = (SELECT
                                             SYSTEM_USER);
    IF @CHG_VER IS NULL
        BEGIN
            SET @CHG_VER = 1
        END;

    SET @CHG_VER = @CHG_VER - 1;
    DECLARE @Commit_Time datetime = (SELECT TOP 1
                                            tc.commit_time
                                            FROM
                                                CHANGETABLE (CHANGES CMS_User, @Chg_Ver) c
                                                    JOIN sys.dm_tran_commit_table AS tc
                                                        ON c.sys_change_version = tc.commit_ts);

    INSERT INTO STAGING_CMS_User_Audit
    (
           UserID
         , SVR
         , DBNAME
         , SYS_CHANGE_VERSION
         , SYS_CHANGE_OPERATION
         , SchemaName
         , SysUser
         , IPADDR
         , Processed
         , TBL
         , commit_time
    ) 
    SELECT
           UserID
         , @svr
         , @db
         , @CHG_VER
         , 'I'
         , @userid
         , @sysuser
         , @ipaddr
         , 0 AS Processed
         , 'CMS_User'
         , @Commit_Time
           FROM Inserted;
END;

GO

IF EXISTS (SELECT
                  name
                  FROM sys.triggers
                  WHERE name = 'trig_UPDT_CMS_User_Audit') 
    BEGIN
        DROP TRIGGER
             trig_UPDT_CMS_User_Audit;
    END;
GO

CREATE TRIGGER trig_UPDT_CMS_User_Audit ON CMS_User
    AFTER UPDATE
AS
BEGIN

    DECLARE @svr nvarchar (100) = (SELECT
                                          @@SERVERNAME);
    DECLARE @db nvarchar (100) = (SELECT
                                         DB_NAME ());
    DECLARE @CHG_VER int = (SELECT
                                   MAX (CT.SYS_CHANGE_VERSION) 
                                   FROM CHANGETABLE (CHANGES CMS_User, NULL) AS CT);
    DECLARE @ipaddr nvarchar (50) = (SELECT
                                            CAST (CONNECTIONPROPERTY ('client_net_address') AS nvarchar (50)) );
    DECLARE @userid nvarchar (50) = (SELECT
                                            USER_NAME () );
    DECLARE @sysuser nvarchar (50) = (SELECT
                                             SYSTEM_USER);

    IF @CHG_VER IS NULL
        BEGIN
            SET @CHG_VER = 1
        END;

    SET @CHG_VER = @CHG_VER - 1;
    DECLARE @Commit_Time datetime = (SELECT TOP 1
                                            tc.commit_time
                                            FROM
                                                CHANGETABLE (CHANGES CMS_User, @Chg_Ver) c
                                                    JOIN sys.dm_tran_commit_table AS tc
                                                        ON c.sys_change_version = tc.commit_ts);

    INSERT INTO STAGING_CMS_User_Audit
    (
           UserID
         , SVR
         , DBNAME
         , SYS_CHANGE_VERSION
         , SYS_CHANGE_OPERATION
         , SchemaName
         , SysUser
         , IPADDR
         , Processed
         , TBL
         , commit_time
    ) 
    SELECT
           UserID
         , @svr
         , @db
         , @CHG_VER
         , 'U'
         , @userid
         , @sysuser
         , @ipaddr
         , 0 AS Processed
         , 'CMS_User'
         , @Commit_Time
           FROM Inserted;
END;

GO

IF EXISTS (SELECT
                  name
                  FROM sys.triggers
                  WHERE name = 'trig_DEL_CMS_User_Audit') 
    BEGIN
        DROP TRIGGER
             trig_DEL_CMS_User_Audit;
    END;
GO

CREATE TRIGGER trig_DEL_CMS_User_Audit ON CMS_User
    AFTER DELETE
AS
BEGIN

    DECLARE @svr nvarchar (100) = (SELECT
                                          @@SERVERNAME);
    DECLARE @db nvarchar (100) = (SELECT
                                         DB_NAME ());
    DECLARE @CHG_VER int = (SELECT
                                   MAX (CT.SYS_CHANGE_VERSION) 
                                   FROM CHANGETABLE (CHANGES CMS_User, NULL) AS CT);
    DECLARE @ipaddr nvarchar (50) = (SELECT
                                            CAST (CONNECTIONPROPERTY ('client_net_address') AS nvarchar (50)) );
    DECLARE @userid nvarchar (50) = (SELECT
                                            USER_NAME () );
    DECLARE @sysuser nvarchar (50) = (SELECT
                                             SYSTEM_USER);

    IF @CHG_VER IS NULL
        BEGIN
            SET @CHG_VER = 1
        END;

    SET @CHG_VER = @CHG_VER - 1;
    DECLARE @Commit_Time datetime = (SELECT TOP 1
                                            tc.commit_time
                                            FROM
                                                CHANGETABLE (CHANGES CMS_User, @Chg_Ver) c
                                                    JOIN sys.dm_tran_commit_table AS tc
                                                        ON c.sys_change_version = tc.commit_ts);

    INSERT INTO STAGING_CMS_User_Audit
    (
           UserID
         , SVR
         , DBNAME
         , SYS_CHANGE_VERSION
         , SYS_CHANGE_OPERATION
         , SchemaName
         , SysUser
         , IPADDR
         , Processed
         , TBL
         , commit_time
    ) 
    SELECT
           UserID
         , @svr
         , @db
         , @CHG_VER
         , 'D'
         , @userid
         , @sysuser
         , @ipaddr
         , 0 AS Processed
         , 'CMS_User'
         , @Commit_Time
           FROM DELETED;
END;

GO
PRINT 'EXECUTED TRIG_CMS_User_Audit.SQL';
GO
--**************
print('END: ' + cast(getdate() as nvarchar(50)));
print('@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-');
print'***************************************************************' ;
print('START: ' + cast(getdate() as nvarchar(50)));
--**************

--SET ANSI_NULLS ON;
--SET ANSI_PADDING ON;
--SET ANSI_WARNINGS ON;
--SET ARITHABORT ON;
--SET CONCAT_NULL_YIELDS_NULL ON;
--SET NUMERIC_ROUNDABORT OFF;
--SET QUOTED_IDENTIFIER ON;





GO
PRINT 'Executing proc_CT_CMS_USER_History.sql';
GO
IF EXISTS (SELECT
                  name
                  FROM sys.procedures
                  WHERE name = 'proc_CT_CMS_USER_History') 
    BEGIN
        DROP PROCEDURE
             proc_CT_CMS_USER_History;
    END;
GO

/*-------------------------------------------------------------------------
*************************************************************************

select tc.commit_time, *
from
    changetable(changes CMS_USER, 0) c
    join sys.dm_tran_commit_table tc on c.sys_change_version = tc.commit_ts


exec proc_CT_CMS_USER_History 'I'
exec proc_CT_CMS_USER_History 'D'
exec proc_CT_CMS_USER_History 'U'

truncate table STAGING_CMS_USER_Update_History
select * from STAGING_CMS_USER_Update_History

SELECT CHANGE_TRACKING_MIN_VALID_VERSION(OBJECT_ID('CMS_USER'))
*************************************************************************
*/

CREATE PROCEDURE proc_CT_CMS_USER_History (
     @Typesave AS nchar (1)) 
AS
BEGIN
    WITH CTE (
         UserID
       , SYS_CHANGE_VERSION
       , SYS_CHANGE_COLUMNS) 
        AS (SELECT
                   CT.UserID
                 , CT.SYS_CHANGE_VERSION
                 , SYS_CHANGE_COLUMNS
                   FROM CHANGETABLE (CHANGES CMS_USER, NULL) AS CT
                   WHERE SYS_CHANGE_OPERATION = @Typesave
            EXCEPT
            SELECT
                   UserID
                 , SYS_CHANGE_VERSION
                 , SYS_CHANGE_COLUMNS
                   FROM STAGING_CMS_USER_Update_History) 
        INSERT INTO STAGING_CMS_USER_Update_History
        (
               Userid
             , SYS_CHANGE_VERSION
             , SYS_CHANGE_OPERATION
             , SYS_CHANGE_COLUMNS
             --, CurrUser
             --, SysUser
             --, IPADDR
             , commit_time
             , LastModifiedDate
             , SVR
             , DBNAME
             , Email_cg
             , FirstName_cg
             , FullName_cg
             , LastLogon_cg
             , LastName_cg
             , MiddleName_cg
             , PreferredCultureCode_cg
             , PreferredUICultureCode_cg
             , UserCreated_cg
             , UserEnabled_cg
             , UserGUID_cg
             , UserHasAllowedCultures_cg
             , UserID_cg
             , UserIsDomain_cg
             , UserIsEditor_cg
             , UserIsExternal_cg
             , UserIsGlobalAdministrator_cg
             , UserIsHidden_cg
             , UserLastLogonInfo_cg
             , UserLastModified_cg
             , UserMFRequired_cg
             , UserName_cg
             , UserPassword_cg
             , UserPasswordBuffer_cg
             , UserPasswordFormat_cg
             , UserSiteManagerDisabled_cg
             , UserStartingAliasPath_cg
             , UserTokenID_cg
             , UserTokenIteration_cg
             , UserVisibility_cg) 
        SELECT
               CTE.Userid
             , CTE.SYS_CHANGE_VERSION
             , @Typesave as SYS_CHANGE_OPERATION
             , CTE.SYS_CHANGE_COLUMNS
             --, CurrUser
             --, SysUser
             --, IPADDR
             , isnull(tc.commit_time, getdate())
             , GETDATE () AS LastModifiedDate
             , @@Servername AS SVR
             , DB_NAME () AS DBNAME
               --********************************************     
             , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_User') , 'Email', 'columnid') , CTE.sys_change_columns) AS Email_cg
             , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_User') , 'FirstName', 'columnid') , CTE.sys_change_columns) AS FirstName_cg
             , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_User') , 'FullName', 'columnid') , CTE.sys_change_columns) AS FullName_cg
             , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_User') , 'LastLogon', 'columnid') , CTE.sys_change_columns) AS LastLogon_cg
             , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_User') , 'LastName', 'columnid') , CTE.sys_change_columns) AS LastName_cg
             , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_User') , 'MiddleName', 'columnid') , CTE.sys_change_columns) AS MiddleName_cg
             , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_User') , 'PreferredCultureCode', 'columnid') , CTE.sys_change_columns) AS PreferredCultureCode_cg
             , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_User') , 'PreferredUICultureCode', 'columnid') , CTE.sys_change_columns) AS PreferredUICultureCode_cg
             , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_User') , 'UserCreated', 'columnid') , CTE.sys_change_columns) AS UserCreated_cg
             , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_User') , 'UserEnabled', 'columnid') , CTE.sys_change_columns) AS UserEnabled_cg
             , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_User') , 'UserGUID', 'columnid') , CTE.sys_change_columns) AS UserGUID_cg
             , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_User') , 'UserHasAllowedCultures', 'columnid') , CTE.sys_change_columns) AS UserHasAllowedCultures_cg
             , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_User') , 'UserID', 'columnid') , CTE.sys_change_columns) AS UserID_cg
             , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_User') , 'UserIsDomain', 'columnid') , CTE.sys_change_columns) AS UserIsDomain_cg
             , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_User') , 'UserIsEditor', 'columnid') , CTE.sys_change_columns) AS UserIsEditor_cg
             , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_User') , 'UserIsExternal', 'columnid') , CTE.sys_change_columns) AS UserIsExternal_cg
             , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_User') , 'UserIsGlobalAdministrator', 'columnid') , CTE.sys_change_columns) AS UserIsGlobalAdministrator_cg
             , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_User') , 'UserIsHidden', 'columnid') , CTE.sys_change_columns) AS UserIsHidden_cg
             , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_User') , 'UserLastLogonInfo', 'columnid') , CTE.sys_change_columns) AS UserLastLogonInfo_cg
             , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_User') , 'UserLastModified', 'columnid') , CTE.sys_change_columns) AS UserLastModified_cg
             , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_User') , 'UserMFRequired', 'columnid') , CTE.sys_change_columns) AS UserMFRequired_cg
             , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_User') , 'UserName', 'columnid') , CTE.sys_change_columns) AS UserName_cg
             , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_User') , 'UserPassword', 'columnid') , CTE.sys_change_columns) AS UserPassword_cg
             , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_User') , 'UserPasswordBuffer', 'columnid') , CTE.sys_change_columns) AS UserPasswordBuffer_cg
             , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_User') , 'UserPasswordFormat', 'columnid') , CTE.sys_change_columns) AS UserPasswordFormat_cg
             , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_User') , 'UserSiteManagerDisabled', 'columnid') , CTE.sys_change_columns) AS UserSiteManagerDisabled_cg
             , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_User') , 'UserStartingAliasPath', 'columnid') , CTE.sys_change_columns) AS UserStartingAliasPath_cg
             , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_User') , 'UserTokenID', 'columnid') , CTE.sys_change_columns) AS UserTokenID_cg
             , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_User') , 'UserTokenIteration', 'columnid') , CTE.sys_change_columns) AS UserTokenIteration_cg
             , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_User') , 'UserVisibility', 'columnid') , CTE.sys_change_columns) AS UserVisibility_cg
        --********************************************    				  
               FROM
                   CTE
                       JOIN sys.dm_tran_commit_table AS tc
                           ON CTE.sys_change_version = tc.commit_ts;

END;

GO
PRINT 'Executed proc_CT_CMS_USER_History.sql';
GO
--**************
print('END: ' + cast(getdate() as nvarchar(50)));
print('@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-');
print'***************************************************************' ;
print('START: ' + cast(getdate() as nvarchar(50)));
--**************

--SET ANSI_NULLS ON;
--SET ANSI_PADDING ON;
--SET ANSI_WARNINGS ON;
--SET ARITHABORT ON;
--SET CONCAT_NULL_YIELDS_NULL ON;
--SET NUMERIC_ROUNDABORT OFF;
--SET QUOTED_IDENTIFIER ON;






GO
PRINT 'Executing view_AUDIT_CMS_User.sql';
GO
IF EXISTS (SELECT
                  name
                  FROM sys.views
                  WHERE name = 'view_AUDIT_CMS_User') 
    BEGIN
        DROP VIEW
             view_AUDIT_CMS_User
    END;

GO

/*-------------------------------------------------
select * from STAGING_CMS_User
select * from STAGING_CMS_User_Update_History
select * from STAGING_CMS_User_Audit
*/
-- select * from view_AUDIT_CMS_User order by UserID desc
/*------------------------------------------------------------------------------
HOW TO USE:
    select * from view_AUDIT_CMS_User
	   where CreateDate between '2015-09-18 14:55:33.000' and '2015-09-18 14:55:34'

    select * from view_AUDIT_CMS_User
	   where SysUser = 'dmiller'
*/

CREATE VIEW view_AUDIT_CMS_User
AS SELECT DISTINCT
          A.SysUser
        , A.IPADDR
        , A.CreateDate
        , A.SYS_CHANGE_OPERATION
        , A.SYS_CHANGE_VERSION as SysChangeVersion
        , S.*
          FROM
              STAGING_CMS_User_Audit AS A
                  JOIN STAGING_CMS_User AS S
                      ON S.UserID = A.UserID;
GO
PRINT 'Executed view_AUDIT_CMS_User.sql';
GO
--**************
print('END: ' + cast(getdate() as nvarchar(50)));
print('@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-');
print'***************************************************************' ;
print('START: ' + cast(getdate() as nvarchar(50)));
--**************

--SET ANSI_NULLS ON;
--SET ANSI_PADDING ON;
--SET ANSI_WARNINGS ON;
--SET ARITHABORT ON;
--SET CONCAT_NULL_YIELDS_NULL ON;
--SET NUMERIC_ROUNDABORT OFF;
--SET QUOTED_IDENTIFIER ON;





/*------------------------
-----------------
cms_user			    -> DONE
cms_usersettings	  -> DONE
cms_usersite
hfit_ppteligibility
cms_usercontact
*/
GO
PRINT 'Executing create_table_STAGING_CMS_UserSettings.sql';
GO

IF NOT EXISTS (SELECT
                      sys.tables.name AS Table_name
                      FROM
                          sys.change_tracking_tables
                              JOIN sys.tables
                                  ON sys.tables.object_id = sys.change_tracking_tables.object_id
                              JOIN sys.schemas
                                  ON sys.schemas.schema_id = sys.tables.schema_id
                      WHERE sys.tables.name = 'CMS_UserSettings') 
    BEGIN
        PRINT 'ADDING Change Tracking to CMS_UserSettings';
        ALTER TABLE dbo.CMS_UserSettings
            ENABLE CHANGE_TRACKING
                WITH (TRACK_COLUMNS_UPDATED = ON) ;
    END;
ELSE
    BEGIN
        PRINT 'Change Tracking exists on CMS_UserSettings';
    END;
GO
IF EXISTS (SELECT
                  name
                  FROM sys.procedures
                  WHERE name = 'proc_Create_Table_STAGING_CMS_UserSettings') 
    BEGIN
        DROP PROCEDURE
             proc_Create_Table_STAGING_CMS_UserSettings;
    END;
GO
-- exec proc_Create_Table_STAGING_CMS_UserSettings
-- select top 100 * from [STAGING_CMS_UserSettings]
CREATE PROCEDURE proc_Create_Table_STAGING_CMS_UserSettings
AS
BEGIN

    IF EXISTS (SELECT
                      name
                      FROM sys.tables
                      WHERE name = 'STAGING_CMS_UserSettings') 
        BEGIN
            DROP TABLE
                 dbo.STAGING_CMS_UserSettings;
        END;

    SET ANSI_NULLS ON;
    SET QUOTED_IDENTIFIER ON;

    CREATE TABLE dbo.STAGING_CMS_UserSettings (
                 UserSettingsID int NOT NULL
               , UserNickName nvarchar (200) NULL
               , UserPicture nvarchar (200) NULL
               , UserSignature nvarchar (max) NULL
               , UserURLReferrer nvarchar (450) NULL
               , UserCampaign nvarchar (200) NULL
               , UserMessagingNotificationEmail nvarchar (200) NULL
               , UserCustomData nvarchar (max) NULL
               , UserRegistrationInfo nvarchar (max) NULL
               , UserPreferences nvarchar (max) NULL
               , UserActivationDate datetime2 (7) NULL
               , UserActivatedByUserID int NULL
               , UserTimeZoneID int NULL
               , UserAvatarID int NULL
               , UserBadgeID int NULL
               , UserActivityPoints int NULL
               , UserForumPosts int NULL
               , UserBlogComments int NULL
               , UserGender int NULL
               , UserDateOfBirth datetime2 (7) NULL
               , UserMessageBoardPosts int NULL
               , UserSettingsUserGUID uniqueidentifier NOT NULL
               , UserSettingsUserID int NOT NULL
               , WindowsLiveID nvarchar (50) NULL
               , UserBlogPosts int NULL
               , UserWaitingForApproval bit NULL
               , UserDialogsConfiguration nvarchar (max) NULL
               , UserDescription nvarchar (max) NULL
               , UserUsedWebParts nvarchar (1000) NULL
               , UserUsedWidgets nvarchar (1000) NULL
               , UserFacebookID nvarchar (100) NULL
               , UserAuthenticationGUID uniqueidentifier NULL
               , UserSkype nvarchar (100) NULL
               , UserIM nvarchar (100) NULL
               , UserPhone nvarchar (26) NULL
               , UserPosition nvarchar (200) NULL
               , UserBounces int NULL
               , UserLinkedInID nvarchar (100) NULL
               , UserLogActivities bit NULL
               , UserPasswordRequestHash nvarchar (100) NULL
               , UserInvalidLogOnAttempts int NULL
               , UserInvalidLogOnAttemptsHash nvarchar (100) NULL
               , UserAvatarType nvarchar (200) NULL
               , UserAccountLockReason int NULL
               , UserPasswordLastChanged datetime2 (7) NULL
               , UserSecurityQuestionAnswer1 nvarchar (100) NULL
               , UserSecurityQuestionAnswer2 nvarchar (100) NULL
               , UserSecurityQuestionAnswer3 nvarchar (100) NULL
               , HfitUserSsoId nvarchar (250) NULL
               , HFitIsPlatformEnabled bit NULL
               , HFitIsHraEnabled bit NULL
               , HFitIsIncentivesEnabled bit NULL
               , HFitUserMpiNumber bigint NULL
               , SocialSecurity nvarchar (100) NULL
               , HFitUserMobilePhone nvarchar (15) NULL
               , HFitUserPhoneType nvarchar (10) NULL
               , HFitUserAgreesToTerms bit NULL
               , HFitUserPreferredEmail nvarchar (100) NULL
               , HFitUserPreferredPhone nvarchar (15) NULL
               , HFitUserPreferredFirstName nvarchar (50) NULL
               , HFitUserPhoneExt nvarchar (16) NULL
               , HFitComInboxNotifyByEmail bit NULL
               , HFitComInboxNotifyByText bit NULL
               , HFitComActivitiesNotifyEmail bit NULL
               , HFitComActivitiesNotifyText bit NULL
               , HFitComTipOfTheDayNotifyByEmail bit NULL
               , HFitComTipOfTheDayNotifyByText bit NULL
               , HFitComCoachingTrackingEmail bit NULL
               , HFitComCoachingTrackingText bit NULL
               , HfitUserPreferredMailingAddress nvarchar (100) NULL
               , HfitUserPreferredMailingCity nvarchar (50) NULL
               , HfitUserPreferredMailingState nvarchar (2) NULL
               , HfitUserPreferredMailingPostalCode nvarchar (10) NULL
               , HFitCoachingEnrollDate datetime2 (7) NULL
               , HFitUserAltPreferredPhone nvarchar (15) NULL
               , HFitUserAltPreferredPhoneType int NULL
               , HFitUserAltPreferredPhoneExt nvarchar (16) NULL
               , HFitHealthVision nvarchar (max) NULL
               , HFitCoachId int NULL
               , HFitUserTypeID int NULL
               , HFitCoachSystemLastActivity datetime2 (7) NULL
               , HFitIsConditionManagement bit NULL
               , HFitCoachSystemNextActivity datetime2 (7) NULL
               , HFitCoachWebLastActivity datetime2 (7) NULL
               , HFitUserPreferredCallTime int NULL
               , HFitCoachSession1Date datetime2 (7) NULL
               , HFitCoachSystemCoachID int NULL
               , HFitUserPreferredMailingAddress2 nvarchar (100) NULL
               , HFitCoachingOptOutDate datetime2 (7) NULL
               , HFitCoachingOptOutItemID int NULL
               , HFitComScreeningSchedulersEmail bit NULL
               , HFitCoachingOptOutSentDate datetime2 (7) NULL
               , HFitComScreeningSchedulersText bit NULL
               , WellnessGoalGuid uniqueidentifier NULL
               , UserSecurityQuestionGuid1 uniqueidentifier NULL
               , UserSecurityQuestionGuid2 uniqueidentifier NULL
               , UserSecurityQuestionGuid3 uniqueidentifier NULL
               , HFitUserRegistrationDate datetime2 (7) NULL
               , HFitCoachingServiceLevel int NULL
               , HealthAdvisingEvaluationDate datetime2 (7) NULL
               , HFitCallLogStatus int NULL
               , HFitCallLogStatusDate datetime2 (7) NULL
               , HFitCoachingDeliveryMethod int NULL
               , HFitTrackerReminderDisplayed datetime2 (7) NULL
               , HFitPrimaryContactID int NULL
               , HFitPrimaryContactGuid uniqueidentifier NULL
               , HFitUserIsRegistered bit NULL
               , UserDataComUser nvarchar (200) NULL
               , UserDataComPassword nvarchar (200) NULL
               , UserShowIntroductionTile bit NULL
               , UserDashboardApplications nvarchar (max) NULL
               , LastModifiedDate datetime NULL
               , RowNbr int NULL
               , DeletedFlg bit NULL
               , TimeZone nvarchar (10) NULL
               , ConvertedToCentralTime bit NULL
               , SVR nvarchar (100) NOT NULL
               , DBNAME nvarchar (100) NOT NULL
               , SYS_CHANGE_VERSION int NULL
    ) 
    ON [PRIMARY] TEXTIMAGE_ON [PRIMARY];

    ALTER TABLE dbo.STAGING_CMS_UserSettings
    ADD
                DEFAULT @@servername FOR SVR;
    ALTER TABLE dbo.STAGING_CMS_UserSettings
    ADD
                DEFAULT DB_NAME () FOR DBNAME;

    CREATE CLUSTERED INDEX PI_STAGING_CMS_UserSettings ON dbo.STAGING_CMS_UserSettings
    (
    UserSettingsID ASC,
    SVR ASC,
    DBNAME ASC,
    SYS_CHANGE_VERSION ASC
    )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];

    --SET IDENTITY_INSERT STAGING_CMS_UserSettings ON;

    INSERT INTO STAGING_CMS_UserSettings
    (
           UserSettingsID
         , UserNickName
         , UserPicture
         , UserSignature
         , UserURLReferrer
         , UserCampaign
         , UserMessagingNotificationEmail
         , UserCustomData
         , UserRegistrationInfo
         , UserPreferences
         , UserActivationDate
         , UserActivatedByUserID
         , UserTimeZoneID
         , UserAvatarID
         , UserBadgeID
         , UserActivityPoints
         , UserForumPosts
         , UserBlogComments
         , UserGender
         , UserDateOfBirth
         , UserMessageBoardPosts
         , UserSettingsUserGUID
         , UserSettingsUserID
         , WindowsLiveID
         , UserBlogPosts
         , UserWaitingForApproval
         , UserDialogsConfiguration
         , UserDescription
         , UserUsedWebParts
         , UserUsedWidgets
         , UserFacebookID
         , UserAuthenticationGUID
         , UserSkype
         , UserIM
         , UserPhone
         , UserPosition
         , UserBounces
         , UserLinkedInID
         , UserLogActivities
         , UserPasswordRequestHash
         , UserInvalidLogOnAttempts
         , UserInvalidLogOnAttemptsHash
         , UserAvatarType
         , UserAccountLockReason
         , UserPasswordLastChanged
         , UserSecurityQuestionAnswer1
         , UserSecurityQuestionAnswer2
         , UserSecurityQuestionAnswer3
         , HfitUserSsoId
         , HFitIsPlatformEnabled
         , HFitIsHraEnabled
         , HFitIsIncentivesEnabled
         , HFitUserMpiNumber
         , SocialSecurity
         , HFitUserMobilePhone
         , HFitUserPhoneType
         , HFitUserAgreesToTerms
         , HFitUserPreferredEmail
         , HFitUserPreferredPhone
         , HFitUserPreferredFirstName
         , HFitUserPhoneExt
         , HFitComInboxNotifyByEmail
         , HFitComInboxNotifyByText
         , HFitComActivitiesNotifyEmail
         , HFitComActivitiesNotifyText
         , HFitComTipOfTheDayNotifyByEmail
         , HFitComTipOfTheDayNotifyByText
         , HFitComCoachingTrackingEmail
         , HFitComCoachingTrackingText
         , HfitUserPreferredMailingAddress
         , HfitUserPreferredMailingCity
         , HfitUserPreferredMailingState
         , HfitUserPreferredMailingPostalCode
         , HFitCoachingEnrollDate
         , HFitUserAltPreferredPhone
         , HFitUserAltPreferredPhoneType
         , HFitUserAltPreferredPhoneExt
         , HFitHealthVision
         , HFitCoachId
         , HFitUserTypeID
         , HFitCoachSystemLastActivity
         , HFitIsConditionManagement
         , HFitCoachSystemNextActivity
         , HFitCoachWebLastActivity
         , HFitUserPreferredCallTime
         , HFitCoachSession1Date
         , HFitCoachSystemCoachID
         , HFitUserPreferredMailingAddress2
         , HFitCoachingOptOutDate
         , HFitCoachingOptOutItemID
         , HFitComScreeningSchedulersEmail
         , HFitCoachingOptOutSentDate
         , HFitComScreeningSchedulersText
         , WellnessGoalGuid
         , UserSecurityQuestionGuid1
         , UserSecurityQuestionGuid2
         , UserSecurityQuestionGuid3
         , HFitUserRegistrationDate
         , HFitCoachingServiceLevel
         , HealthAdvisingEvaluationDate
         , HFitCallLogStatus
         , HFitCallLogStatusDate
         , HFitCoachingDeliveryMethod
         , HFitTrackerReminderDisplayed
         , HFitPrimaryContactID
         , HFitPrimaryContactGuid
         , HFitUserIsRegistered
         , UserDataComUser
         , UserDataComPassword
         , UserShowIntroductionTile
         , UserDashboardApplications) 
    SELECT
           UserSettingsID
         , UserNickName
         , UserPicture
         , UserSignature
         , UserURLReferrer
         , UserCampaign
         , UserMessagingNotificationEmail
         , UserCustomData
         , UserRegistrationInfo
         , UserPreferences
         , UserActivationDate
         , UserActivatedByUserID
         , UserTimeZoneID
         , UserAvatarID
         , UserBadgeID
         , UserActivityPoints
         , UserForumPosts
         , UserBlogComments
         , UserGender
         , UserDateOfBirth
         , UserMessageBoardPosts
         , UserSettingsUserGUID
         , UserSettingsUserID
         , WindowsLiveID
         , UserBlogPosts
         , UserWaitingForApproval
         , UserDialogsConfiguration
         , UserDescription
         , UserUsedWebParts
         , UserUsedWidgets
         , UserFacebookID
         , UserAuthenticationGUID
         , UserSkype
         , UserIM
         , UserPhone
         , UserPosition
         , UserBounces
         , UserLinkedInID
         , UserLogActivities
         , UserPasswordRequestHash
         , UserInvalidLogOnAttempts
         , UserInvalidLogOnAttemptsHash
         , UserAvatarType
         , UserAccountLockReason
         , UserPasswordLastChanged
         , UserSecurityQuestionAnswer1
         , UserSecurityQuestionAnswer2
         , UserSecurityQuestionAnswer3
         , HfitUserSsoId
         , HFitIsPlatformEnabled
         , HFitIsHraEnabled
         , HFitIsIncentivesEnabled
         , HFitUserMpiNumber
         , SocialSecurity
         , HFitUserMobilePhone
         , HFitUserPhoneType
         , HFitUserAgreesToTerms
         , HFitUserPreferredEmail
         , HFitUserPreferredPhone
         , HFitUserPreferredFirstName
         , HFitUserPhoneExt
         , HFitComInboxNotifyByEmail
         , HFitComInboxNotifyByText
         , HFitComActivitiesNotifyEmail
         , HFitComActivitiesNotifyText
         , HFitComTipOfTheDayNotifyByEmail
         , HFitComTipOfTheDayNotifyByText
         , HFitComCoachingTrackingEmail
         , HFitComCoachingTrackingText
         , HfitUserPreferredMailingAddress
         , HfitUserPreferredMailingCity
         , HfitUserPreferredMailingState
         , HfitUserPreferredMailingPostalCode
         , HFitCoachingEnrollDate
         , HFitUserAltPreferredPhone
         , HFitUserAltPreferredPhoneType
         , HFitUserAltPreferredPhoneExt
         , HFitHealthVision
         , HFitCoachId
         , HFitUserTypeID
         , HFitCoachSystemLastActivity
         , HFitIsConditionManagement
         , HFitCoachSystemNextActivity
         , HFitCoachWebLastActivity
         , HFitUserPreferredCallTime
         , HFitCoachSession1Date
         , HFitCoachSystemCoachID
         , HFitUserPreferredMailingAddress2
         , HFitCoachingOptOutDate
         , HFitCoachingOptOutItemID
         , HFitComScreeningSchedulersEmail
         , HFitCoachingOptOutSentDate
         , HFitComScreeningSchedulersText
         , WellnessGoalGuid
         , UserSecurityQuestionGuid1
         , UserSecurityQuestionGuid2
         , UserSecurityQuestionGuid3
         , HFitUserRegistrationDate
         , HFitCoachingServiceLevel
         , HealthAdvisingEvaluationDate
         , HFitCallLogStatus
         , HFitCallLogStatusDate
         , HFitCoachingDeliveryMethod
         , HFitTrackerReminderDisplayed
         , HFitPrimaryContactID
         , HFitPrimaryContactGuid
         , HFitUserIsRegistered
         , UserDataComUser
         , UserDataComPassword
         , UserShowIntroductionTile
         , UserDashboardApplications
           FROM CMS_UserSettings;

    --SET IDENTITY_INSERT STAGING_CMS_UserSettings OFF;

    IF EXISTS (SELECT
                      name
                      FROM sys.tables
                      WHERE name = 'STAGING_CMS_UserSettings_Update_History') 
        BEGIN
            DROP TABLE
                 STAGING_CMS_UserSettings_Update_History;
        END;

    CREATE TABLE dbo.STAGING_CMS_UserSettings_Update_History (
                 UserSettingsid int NOT NULL
               ,SYS_CHANGE_VERSION bigint NULL
               ,SYS_CHANGE_OPERATION nchar (1) NULL
               ,SYS_CHANGE_COLUMNS varbinary (4100) NULL
               ,CurrUser varchar (60) NOT NULL
               ,SysUser varchar (60) NOT NULL
               ,IPADDR varchar (60) NOT NULL
               ,commit_time datetime NOT NULL
               ,LastModifiedDate datetime NOT NULL
               ,SVR nvarchar (128) NULL
               ,DBNAME nvarchar (128) NULL
               ,UserSettingsID_cg int NULL
               ,UserNickName_cg int NULL
               ,UserPicture_cg int NULL
               ,UserSignature_cg int NULL
               ,UserURLReferrer_cg int NULL
               ,UserCampaign_cg int NULL
               ,UserMessagingNotificationEmail_cg int NULL
               ,UserCustomData_cg int NULL
               ,UserRegistrationInfo_cg int NULL
               ,UserPreferences_cg int NULL
               ,UserActivationDate_cg int NULL
               ,UserActivatedByUserID_cg int NULL
               ,UserTimeZoneID_cg int NULL
               ,UserAvatarID_cg int NULL
               ,UserBadgeID_cg int NULL
               ,UserActivityPoints_cg int NULL
               ,UserForumPosts_cg int NULL
               ,UserBlogComments_cg int NULL
               ,UserGender_cg int NULL
               ,UserDateOfBirth_cg int NULL
               ,UserMessageBoardPosts_cg int NULL
               ,UserSettingsUserGUID_cg int NULL
               ,UserSettingsUserID_cg int NULL
               ,WindowsLiveID_cg int NULL
               ,UserBlogPosts_cg int NULL
               ,UserWaitingForApproval_cg int NULL
               ,UserDialogsConfiguration_cg int NULL
               ,UserDescription_cg int NULL
               ,UserUsedWebParts_cg int NULL
               ,UserUsedWidgets_cg int NULL
               ,UserFacebookID_cg int NULL
               ,UserAuthenticationGUID_cg int NULL
               ,UserSkype_cg int NULL
               ,UserIM_cg int NULL
               ,UserPhone_cg int NULL
               ,UserPosition_cg int NULL
               ,UserBounces_cg int NULL
               ,UserLinkedInID_cg int NULL
               ,UserLogActivities_cg int NULL
               ,UserPasswordRequestHash_cg int NULL
               ,UserInvalidLogOnAttempts_cg int NULL
               ,UserInvalidLogOnAttemptsHash_cg int NULL
               ,UserAvatarType_cg int NULL
               ,UserAccountLockReason_cg int NULL
               ,UserPasswordLastChanged_cg int NULL
               ,UserSecurityQuestionAnswer1_cg int NULL
               ,UserSecurityQuestionAnswer2_cg int NULL
               ,UserSecurityQuestionAnswer3_cg int NULL
               ,HfitUserSsoId_cg int NULL
               ,HFitIsPlatformEnabled_cg int NULL
               ,HFitIsHraEnabled_cg int NULL
               ,HFitIsIncentivesEnabled_cg int NULL
               ,HFitUserMpiNumber_cg int NULL
               ,SocialSecurity_cg int NULL
               ,HFitUserMobilePhone_cg int NULL
               ,HFitUserPhoneType_cg int NULL
               ,HFitUserAgreesToTerms_cg int NULL
               ,HFitUserPreferredEmail_cg int NULL
               ,HFitUserPreferredPhone_cg int NULL
               ,HFitUserPreferredFirstName_cg int NULL
               ,HFitUserPhoneExt_cg int NULL
               ,HFitComInboxNotifyByEmail_cg int NULL
               ,HFitComInboxNotifyByText_cg int NULL
               ,HFitComActivitiesNotifyEmail_cg int NULL
               ,HFitComActivitiesNotifyText_cg int NULL
               ,HFitComTipOfTheDayNotifyByEmail_cg int NULL
               ,HFitComTipOfTheDayNotifyByText_cg int NULL
               ,HFitComCoachingTrackingEmail_cg int NULL
               ,HFitComCoachingTrackingText_cg int NULL
               ,HfitUserPreferredMailingAddress_cg int NULL
               ,HfitUserPreferredMailingCity_cg int NULL
               ,HfitUserPreferredMailingState_cg int NULL
               ,HfitUserPreferredMailingPostalCode_cg int NULL
               ,HFitCoachingEnrollDate_cg int NULL
               ,HFitUserAltPreferredPhone_cg int NULL
               ,HFitUserAltPreferredPhoneType_cg int NULL
               ,HFitUserAltPreferredPhoneExt_cg int NULL
               ,HFitHealthVision_cg int NULL
               ,HFitCoachId_cg int NULL
               ,HFitUserTypeID_cg int NULL
               ,HFitCoachSystemLastActivity_cg int NULL
               ,HFitIsConditionManagement_cg int NULL
               ,HFitCoachSystemNextActivity_cg int NULL
               ,HFitCoachWebLastActivity_cg int NULL
               ,HFitUserPreferredCallTime_cg int NULL
               ,HFitCoachSession1Date_cg int NULL
               ,HFitCoachSystemCoachID_cg int NULL
               ,HFitUserPreferredMailingAddress2_cg int NULL
               ,HFitCoachingOptOutDate_cg int NULL
               ,HFitCoachingOptOutItemID_cg int NULL
               ,HFitComScreeningSchedulersEmail_cg int NULL
               ,HFitCoachingOptOutSentDate_cg int NULL
               ,HFitComScreeningSchedulersText_cg int NULL
               ,WellnessGoalGuid_cg int NULL
               ,UserSecurityQuestionGuid1_cg int NULL
               ,UserSecurityQuestionGuid2_cg int NULL
               ,UserSecurityQuestionGuid3_cg int NULL
               ,HFitUserRegistrationDate_cg int NULL
               ,HFitCoachingServiceLevel_cg int NULL
               ,HealthAdvisingEvaluationDate_cg int NULL
               ,HFitCallLogStatus_cg int NULL
               ,HFitCallLogStatusDate_cg int NULL
               ,HFitCoachingDeliveryMethod_cg int NULL
               ,HFitTrackerReminderDisplayed_cg int NULL
               ,HFitPrimaryContactID_cg int NULL
               ,HFitPrimaryContactGuid_cg int NULL
               ,HFitUserIsRegistered_cg int NULL
               ,UserDataComUser_cg int NULL
               ,UserDataComPassword_cg int NULL
               ,UserShowIntroductionTile_cg int NULL
               ,UserDashboardApplications_cg int NULL
               ,HFitForgotPasswordAttempts_cg int NULL
               ,HFitForgotPasswordStarted_cg int NULL
    ) 
    ON [PRIMARY];

    ALTER TABLE dbo.STAGING_CMS_UserSettings_Update_History
    ADD
                CONSTRAINT DF_STAGING_CMS_UserSettings_Update_History_CurrUser  DEFAULT USER_NAME () FOR CurrUser;
    ALTER TABLE dbo.STAGING_CMS_UserSettings_Update_History
    ADD
                CONSTRAINT DF_STAGING_CMS_UserSettings_Update_History_SysUser  DEFAULT SUSER_SNAME () FOR SysUser;
    ALTER TABLE dbo.STAGING_CMS_UserSettings_Update_History
    ADD
                CONSTRAINT DF_STAGING_CMS_UserSettings_Update_History_IPADDR  DEFAULT CONVERT (nvarchar (50) , CONNECTIONPROPERTY ('client_net_address')) FOR IPADDR;

    CREATE CLUSTERED INDEX PI_STAGING_CMS_UserSettings_Update_History ON dbo.STAGING_CMS_UserSettings_Update_History
    (
    UserSettingsID ASC,
    SVR ASC,
    SYS_CHANGE_VERSION ASC
    )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];

    --CREATE CLUSTERED INDEX [PI_STAGING_CMS_UserSettings_Update_History] ON [dbo].[STAGING_CMS_UserSettings_Update_History]
    --(
	   -- [UserSettingsid] ASC
    --)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

END;

GO
PRINT 'Executed create_table_STAGING_CMS_UserSettings.sql';
GO
EXEC proc_Create_Table_STAGING_CMS_UserSettings;
GO

--**************
print('END: ' + cast(getdate() as nvarchar(50)));
print('@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-');
print'***************************************************************' ;
print('START: ' + cast(getdate() as nvarchar(50)));
--**************

--SET ANSI_NULLS ON;
--SET ANSI_PADDING ON;
--SET ANSI_WARNINGS ON;
--SET ARITHABORT ON;
--SET CONCAT_NULL_YIELDS_NULL ON;
--SET NUMERIC_ROUNDABORT OFF;
--SET QUOTED_IDENTIFIER ON;






GO
PRINT 'Executing proc_CMS_UserSettings_AddDeletedRecs.sql';
GO
IF EXISTS ( SELECT
                   name
                   FROM sys.procedures
                   WHERE name = 'proc_CMS_UserSettings_AddDeletedRecs') 
    BEGIN
        DROP PROCEDURE
             proc_CMS_UserSettings_AddDeletedRecs;
    END;
GO
/*
    SELECT TOP 100 * FROM CMS_UserSettings
    DELETE FROM CMS_UserSettings where UserSettingsID = 20174
    EXEC proc_CMS_UserSettings_AddDeletedRecs
*/
CREATE PROCEDURE proc_CMS_UserSettings_AddDeletedRecs 
AS
BEGIN

    UPDATE STAGING_CMS_UserSettings
           SET
               DeletedFlg = 1
             ,LastModifiedDate = GETDATE () 
    WHERE
          UserSettingsID IN
          (SELECT
                  UserSettingsID
                  FROM CHANGETABLE (CHANGES CMS_UserSettings, NULL) AS CT
                  WHERE SYS_CHANGE_OPERATION = 'D') 
      AND DeletedFlg IS NULL;

    DECLARE
    @iCnt AS int = @@ROWCOUNT;
    PRINT 'Deleted Count: ' + CAST ( @iCnt AS nvarchar (50)) ;
    RETURN @iCnt;
END;

GO
PRINT 'Executed proc_CMS_UserSettings_AddDeletedRecs.sql';
GO
--**************
print('END: ' + cast(getdate() as nvarchar(50)));
print('@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-');
print'***************************************************************' ;
print('START: ' + cast(getdate() as nvarchar(50)));
--**************

--SET ANSI_NULLS ON;
--SET ANSI_PADDING ON;
--SET ANSI_WARNINGS ON;
--SET ARITHABORT ON;
--SET CONCAT_NULL_YIELDS_NULL ON;
--SET NUMERIC_ROUNDABORT OFF;
--SET QUOTED_IDENTIFIER ON;





GO
-- USe KenticoCMS_Prod1

PRINT 'Executing proc_CT_CMS_UserSettings_AddNewRecs.sql';
GO
IF EXISTS ( SELECT
                   name
                   FROM sys.procedures
                   WHERE name = 'proc_CT_CMS_UserSettings_AddNewRecs') 
    BEGIN
        DROP PROCEDURE
             proc_CT_CMS_UserSettings_AddNewRecs;
    END;
GO

/*
    SELECT TOP 100 * FROM STAGING_CMS_UserSettings
    DELETE FROM STAGING_CMS_UserSettings where UserSettingsID = 20210
    exec proc_CT_CMS_UserSettings_AddNewRecs
*/
CREATE PROCEDURE proc_CT_CMS_UserSettings_AddNewRecs
AS
BEGIN

    --SET IDENTITY_INSERT STAGING_CMS_UserSettings ON;

    WITH CTE (
         UserSettingsID) 
        AS ( SELECT
                    UserSettingsID
                    FROM CMS_UserSettings
             EXCEPT
             SELECT
                    UserSettingsID
                    FROM STAGING_CMS_UserSettings
                    WHERE DeletedFlg IS NULL) 
        INSERT INTO STAGING_CMS_UserSettings
        (
               UserSettingsID
             , UserNickName
             , UserPicture
             , UserSignature
             , UserURLReferrer
             , UserCampaign
             , UserMessagingNotificationEmail
             , UserCustomData
             , UserRegistrationInfo
             , UserPreferences
             , UserActivationDate
             , UserActivatedByUserID
             , UserTimeZoneID
             , UserAvatarID
             , UserBadgeID
             , UserActivityPoints
             , UserForumPosts
             , UserBlogComments
             , UserGender
             , UserDateOfBirth
             , UserMessageBoardPosts
             , UserSettingsUserGUID
             , UserSettingsUserID
             , WindowsLiveID
             , UserBlogPosts
             , UserWaitingForApproval
             , UserDialogsConfiguration
             , UserDescription
             , UserUsedWebParts
             , UserUsedWidgets
             , UserFacebookID
             , UserAuthenticationGUID
             , UserSkype
             , UserIM
             , UserPhone
             , UserPosition
             , UserBounces
             , UserLinkedInID
             , UserLogActivities
             , UserPasswordRequestHash
             , UserInvalidLogOnAttempts
             , UserInvalidLogOnAttemptsHash
             , UserAvatarType
             , UserAccountLockReason
             , UserPasswordLastChanged
             , UserSecurityQuestionAnswer1
             , UserSecurityQuestionAnswer2
             , UserSecurityQuestionAnswer3
             , HfitUserSsoId
             , HFitIsPlatformEnabled
             , HFitIsHraEnabled
             , HFitIsIncentivesEnabled
             , HFitUserMpiNumber
             , SocialSecurity
             , HFitUserMobilePhone
             , HFitUserPhoneType
             , HFitUserAgreesToTerms
             , HFitUserPreferredEmail
             , HFitUserPreferredPhone
             , HFitUserPreferredFirstName
             , HFitUserPhoneExt
             , HFitComInboxNotifyByEmail
             , HFitComInboxNotifyByText
             , HFitComActivitiesNotifyEmail
             , HFitComActivitiesNotifyText
             , HFitComTipOfTheDayNotifyByEmail
             , HFitComTipOfTheDayNotifyByText
             , HFitComCoachingTrackingEmail
             , HFitComCoachingTrackingText
             , HfitUserPreferredMailingAddress
             , HfitUserPreferredMailingCity
             , HfitUserPreferredMailingState
             , HfitUserPreferredMailingPostalCode
             , HFitCoachingEnrollDate
             , HFitUserAltPreferredPhone
             , HFitUserAltPreferredPhoneType
             , HFitUserAltPreferredPhoneExt
             , HFitHealthVision
             , HFitCoachId
             , HFitUserTypeID
             , HFitCoachSystemLastActivity
             , HFitIsConditionManagement
             , HFitCoachSystemNextActivity
             , HFitCoachWebLastActivity
             , HFitUserPreferredCallTime
             , HFitCoachSession1Date
             , HFitCoachSystemCoachID
             , HFitUserPreferredMailingAddress2
             , HFitCoachingOptOutDate
             , HFitCoachingOptOutItemID
             , HFitComScreeningSchedulersEmail
             , HFitCoachingOptOutSentDate
             , HFitComScreeningSchedulersText
             , WellnessGoalGuid
             , UserSecurityQuestionGuid1
             , UserSecurityQuestionGuid2
             , UserSecurityQuestionGuid3
             , HFitUserRegistrationDate
             , HFitCoachingServiceLevel
             , HealthAdvisingEvaluationDate
             , HFitCallLogStatus
             , HFitCallLogStatusDate
             , HFitCoachingDeliveryMethod
             , HFitTrackerReminderDisplayed
             , HFitPrimaryContactID
             , HFitPrimaryContactGuid
             , HFitUserIsRegistered
             , UserDataComUser
             , UserDataComPassword
             , UserShowIntroductionTile
             , UserDashboardApplications

             , LastModifiedDate
               --,[RowNbr]
             , DeletedFlg
             , TimeZone
             , ConvertedToCentralTime
             , SVR
             , DBNAME
             , SYS_CHANGE_VERSION) 
        SELECT
               T.UserSettingsID
             , T.UserNickName
             , T.UserPicture
             , T.UserSignature
             , T.UserURLReferrer
             , T.UserCampaign
             , T.UserMessagingNotificationEmail
             , T.UserCustomData
             , T.UserRegistrationInfo
             , T.UserPreferences
             , T.UserActivationDate
             , T.UserActivatedByUserID
             , T.UserTimeZoneID
             , T.UserAvatarID
             , T.UserBadgeID
             , T.UserActivityPoints
             , T.UserForumPosts
             , T.UserBlogComments
             , T.UserGender
             , T.UserDateOfBirth
             , T.UserMessageBoardPosts
             , T.UserSettingsUserGUID
             , T.UserSettingsUserID
             , T.WindowsLiveID
             , T.UserBlogPosts
             , T.UserWaitingForApproval
             , T.UserDialogsConfiguration
             , T.UserDescription
             , T.UserUsedWebParts
             , T.UserUsedWidgets
             , T.UserFacebookID
             , T.UserAuthenticationGUID
             , T.UserSkype
             , T.UserIM
             , T.UserPhone
             , T.UserPosition
             , T.UserBounces
             , T.UserLinkedInID
             , T.UserLogActivities
             , T.UserPasswordRequestHash
             , T.UserInvalidLogOnAttempts
             , T.UserInvalidLogOnAttemptsHash
             , T.UserAvatarType
             , T.UserAccountLockReason
             , T.UserPasswordLastChanged
             , T.UserSecurityQuestionAnswer1
             , T.UserSecurityQuestionAnswer2
             , T.UserSecurityQuestionAnswer3
             , T.HfitUserSsoId
             , T.HFitIsPlatformEnabled
             , T.HFitIsHraEnabled
             , T.HFitIsIncentivesEnabled
             , T.HFitUserMpiNumber
             , T.SocialSecurity
             , T.HFitUserMobilePhone
             , T.HFitUserPhoneType
             , T.HFitUserAgreesToTerms
             , T.HFitUserPreferredEmail
             , T.HFitUserPreferredPhone
             , T.HFitUserPreferredFirstName
             , T.HFitUserPhoneExt
             , T.HFitComInboxNotifyByEmail
             , T.HFitComInboxNotifyByText
             , T.HFitComActivitiesNotifyEmail
             , T.HFitComActivitiesNotifyText
             , T.HFitComTipOfTheDayNotifyByEmail
             , T.HFitComTipOfTheDayNotifyByText
             , T.HFitComCoachingTrackingEmail
             , T.HFitComCoachingTrackingText
             , T.HfitUserPreferredMailingAddress
             , T.HfitUserPreferredMailingCity
             , T.HfitUserPreferredMailingState
             , T.HfitUserPreferredMailingPostalCode
             , T.HFitCoachingEnrollDate
             , T.HFitUserAltPreferredPhone
             , T.HFitUserAltPreferredPhoneType
             , T.HFitUserAltPreferredPhoneExt
             , T.HFitHealthVision
             , T.HFitCoachId
             , T.HFitUserTypeID
             , T.HFitCoachSystemLastActivity
             , T.HFitIsConditionManagement
             , T.HFitCoachSystemNextActivity
             , T.HFitCoachWebLastActivity
             , T.HFitUserPreferredCallTime
             , T.HFitCoachSession1Date
             , T.HFitCoachSystemCoachID
             , T.HFitUserPreferredMailingAddress2
             , T.HFitCoachingOptOutDate
             , T.HFitCoachingOptOutItemID
             , T.HFitComScreeningSchedulersEmail
             , T.HFitCoachingOptOutSentDate
             , T.HFitComScreeningSchedulersText
             , T.WellnessGoalGuid
             , T.UserSecurityQuestionGuid1
             , T.UserSecurityQuestionGuid2
             , T.UserSecurityQuestionGuid3
             , T.HFitUserRegistrationDate
             , T.HFitCoachingServiceLevel
             , T.HealthAdvisingEvaluationDate
             , T.HFitCallLogStatus
             , T.HFitCallLogStatusDate
             , T.HFitCoachingDeliveryMethod
             , T.HFitTrackerReminderDisplayed
             , T.HFitPrimaryContactID
             , T.HFitPrimaryContactGuid
             , T.HFitUserIsRegistered
             , T.UserDataComUser
             , T.UserDataComPassword
             , T.UserShowIntroductionTile
             , T.UserDashboardApplications

             , GETDATE () AS LastModifiedDate
             , NULL AS DeletedFlg
             , NULL AS TimeZone
             , NULL AS ConvertedToCentralTime
             , @@SERVERNAME AS SVR
             , DB_NAME () AS DBNAME
             , null as SYS_CHANGE_VERSION
               FROM
                   CMS_UserSettings AS T
                       JOIN CTE AS S
                           ON S.UserSettingsID = T.UserSettingsID;
                        
    DECLARE
    @iInserts AS int = @@ROWCOUNT;
    --SET IDENTITY_INSERT STAGING_CMS_UserSettings OFF;
    PRINT 'NEW Insert Count: ' + CAST ( @iInserts AS nvarchar (50)) ;
    RETURN @iInserts;
END;

GO
PRINT 'Executed proc_CT_CMS_UserSettings_AddNewRecs.sql';
GO
--**************
print('END: ' + cast(getdate() as nvarchar(50)));
print('@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-');
print'***************************************************************' ;
print('START: ' + cast(getdate() as nvarchar(50)));
--**************

--SET ANSI_NULLS ON;
--SET ANSI_PADDING ON;
--SET ANSI_WARNINGS ON;
--SET ARITHABORT ON;
--SET CONCAT_NULL_YIELDS_NULL ON;
--SET NUMERIC_ROUNDABORT OFF;
--SET QUOTED_IDENTIFIER ON;





GO
PRINT 'Executing proc_CT_CMS_UserSettings_AddUpdatedRecs.sql';
GO
IF EXISTS ( SELECT
                   name
                   FROM sys.procedures
                   WHERE name = 'proc_CT_CMS_UserSettings_AddUpdatedRecs') 
    BEGIN
        DROP PROCEDURE
             proc_CT_CMS_UserSettings_AddUpdatedRecs;
    END;
GO
/*----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
select top 100 * from CMS_UserSettings
update CMS_UserSettings set UserNickName = UserNickName where UserSettingsID in (select top 50 UserSettingsID from CMS_UserSettings order by UserSettingsID desc )

 exec proc_CT_CMS_UserSettings_AddUpdatedRecs
 select * from STAGING_CMS_UserSettings where SYS_CHANGE_VERSION is not null

*/

CREATE PROCEDURE proc_CT_CMS_UserSettings_AddUpdatedRecs
AS
BEGIN
    WITH CTE (
         UserSettingsID
       , SYS_CHANGE_VERSION
       , SYS_CHANGE_OPERATION
       , SYS_CHANGE_COLUMNS) 
        AS ( SELECT
                    CT.UserSettingsID
                  , CT.SYS_CHANGE_VERSION
                  , CT.SYS_CHANGE_OPERATION
                  , SYS_CHANGE_COLUMNS
                    FROM CHANGETABLE (CHANGES CMS_UserSettings, NULL) AS CT
                    WHERE SYS_CHANGE_OPERATION = 'U') 
        UPDATE S
               SET
                   S.UserSettingsID = T.UserSettingsID
                 ,S.UserNickName = T.UserNickName
                 ,S.UserPicture = T.UserPicture
                 ,S.UserSignature = T.UserSignature
                 ,S.UserURLReferrer = T.UserURLReferrer
                 ,S.UserCampaign = T.UserCampaign
                 ,S.UserMessagingNotificationEmail = T.UserMessagingNotificationEmail
                 ,S.UserCustomData = T.UserCustomData
                 ,S.UserRegistrationInfo = T.UserRegistrationInfo
                 ,S.UserPreferences = T.UserPreferences
                 ,S.UserActivationDate = T.UserActivationDate
                 ,S.UserActivatedByUserID = T.UserActivatedByUserID
                 ,S.UserTimeZoneID = T.UserTimeZoneID
                 ,S.UserAvatarID = T.UserAvatarID
                 ,S.UserBadgeID = T.UserBadgeID
                 ,S.UserActivityPoints = T.UserActivityPoints
                 ,S.UserForumPosts = T.UserForumPosts
                 ,S.UserBlogComments = T.UserBlogComments
                 ,S.UserGender = T.UserGender
                 ,S.UserDateOfBirth = T.UserDateOfBirth
                 ,S.UserMessageBoardPosts = T.UserMessageBoardPosts
                 ,S.UserSettingsUserGUID = T.UserSettingsUserGUID
                 ,S.UserSettingsUserID = T.UserSettingsUserID
                 ,S.WindowsLiveID = T.WindowsLiveID
                 ,S.UserBlogPosts = T.UserBlogPosts
                 ,S.UserWaitingForApproval = T.UserWaitingForApproval
                 ,S.UserDialogsConfiguration = T.UserDialogsConfiguration
                 ,S.UserDescription = T.UserDescription
                 ,S.UserUsedWebParts = T.UserUsedWebParts
                 ,S.UserUsedWidgets = T.UserUsedWidgets
                 ,S.UserFacebookID = T.UserFacebookID
                 ,S.UserAuthenticationGUID = T.UserAuthenticationGUID
                 ,S.UserSkype = T.UserSkype
                 ,S.UserIM = T.UserIM
                 ,S.UserPhone = T.UserPhone
                 ,S.UserPosition = T.UserPosition
                 ,S.UserBounces = T.UserBounces
                 ,S.UserLinkedInID = T.UserLinkedInID
                 ,S.UserLogActivities = T.UserLogActivities
                 ,S.UserPasswordRequestHash = T.UserPasswordRequestHash
                 ,S.UserInvalidLogOnAttempts = T.UserInvalidLogOnAttempts
                 ,S.UserInvalidLogOnAttemptsHash = T.UserInvalidLogOnAttemptsHash
                 ,S.UserAvatarType = T.UserAvatarType
                 ,S.UserAccountLockReason = T.UserAccountLockReason
                 ,S.UserPasswordLastChanged = T.UserPasswordLastChanged
                 ,S.UserSecurityQuestionAnswer1 = T.UserSecurityQuestionAnswer1
                 ,S.UserSecurityQuestionAnswer2 = T.UserSecurityQuestionAnswer2
                 ,S.UserSecurityQuestionAnswer3 = T.UserSecurityQuestionAnswer3
                 ,S.HfitUserSsoId = T.HfitUserSsoId
                 ,S.HFitIsPlatformEnabled = T.HFitIsPlatformEnabled
                 ,S.HFitIsHraEnabled = T.HFitIsHraEnabled
                 ,S.HFitIsIncentivesEnabled = T.HFitIsIncentivesEnabled
                 ,S.HFitUserMpiNumber = T.HFitUserMpiNumber
                 ,S.SocialSecurity = T.SocialSecurity
                 ,S.HFitUserMobilePhone = T.HFitUserMobilePhone
                 ,S.HFitUserPhoneType = T.HFitUserPhoneType
                 ,S.HFitUserAgreesToTerms = T.HFitUserAgreesToTerms
                 ,S.HFitUserPreferredEmail = T.HFitUserPreferredEmail
                 ,S.HFitUserPreferredPhone = T.HFitUserPreferredPhone
                 ,S.HFitUserPreferredFirstName = T.HFitUserPreferredFirstName
                 ,S.HFitUserPhoneExt = T.HFitUserPhoneExt
                 ,S.HFitComInboxNotifyByEmail = T.HFitComInboxNotifyByEmail
                 ,S.HFitComInboxNotifyByText = T.HFitComInboxNotifyByText
                 ,S.HFitComActivitiesNotifyEmail = T.HFitComActivitiesNotifyEmail
                 ,S.HFitComActivitiesNotifyText = T.HFitComActivitiesNotifyText
                 ,S.HFitComTipOfTheDayNotifyByEmail = T.HFitComTipOfTheDayNotifyByEmail
                 ,S.HFitComTipOfTheDayNotifyByText = T.HFitComTipOfTheDayNotifyByText
                 ,S.HFitComCoachingTrackingEmail = T.HFitComCoachingTrackingEmail
                 ,S.HFitComCoachingTrackingText = T.HFitComCoachingTrackingText
                 ,S.HfitUserPreferredMailingAddress = T.HfitUserPreferredMailingAddress
                 ,S.HfitUserPreferredMailingCity = T.HfitUserPreferredMailingCity
                 ,S.HfitUserPreferredMailingState = T.HfitUserPreferredMailingState
                 ,S.HfitUserPreferredMailingPostalCode = T.HfitUserPreferredMailingPostalCode
                 ,S.HFitCoachingEnrollDate = T.HFitCoachingEnrollDate
                 ,S.HFitUserAltPreferredPhone = T.HFitUserAltPreferredPhone
                 ,S.HFitUserAltPreferredPhoneType = T.HFitUserAltPreferredPhoneType
                 ,S.HFitUserAltPreferredPhoneExt = T.HFitUserAltPreferredPhoneExt
                 ,S.HFitHealthVision = T.HFitHealthVision
                 ,S.HFitCoachId = T.HFitCoachId
                 ,S.HFitUserTypeID = T.HFitUserTypeID
                 ,S.HFitCoachSystemLastActivity = T.HFitCoachSystemLastActivity
                 ,S.HFitIsConditionManagement = T.HFitIsConditionManagement
                 ,S.HFitCoachSystemNextActivity = T.HFitCoachSystemNextActivity
                 ,S.HFitCoachWebLastActivity = T.HFitCoachWebLastActivity
                 ,S.HFitUserPreferredCallTime = T.HFitUserPreferredCallTime
                 ,S.HFitCoachSession1Date = T.HFitCoachSession1Date
                 ,S.HFitCoachSystemCoachID = T.HFitCoachSystemCoachID
                 ,S.HFitUserPreferredMailingAddress2 = T.HFitUserPreferredMailingAddress2
                 ,S.HFitCoachingOptOutDate = T.HFitCoachingOptOutDate
                 ,S.HFitCoachingOptOutItemID = T.HFitCoachingOptOutItemID
                 ,S.HFitComScreeningSchedulersEmail = T.HFitComScreeningSchedulersEmail
                 ,S.HFitCoachingOptOutSentDate = T.HFitCoachingOptOutSentDate
                 ,S.HFitComScreeningSchedulersText = T.HFitComScreeningSchedulersText
                 ,S.WellnessGoalGuid = T.WellnessGoalGuid
                 ,S.UserSecurityQuestionGuid1 = T.UserSecurityQuestionGuid1
                 ,S.UserSecurityQuestionGuid2 = T.UserSecurityQuestionGuid2
                 ,S.UserSecurityQuestionGuid3 = T.UserSecurityQuestionGuid3
                 ,S.HFitUserRegistrationDate = T.HFitUserRegistrationDate
                 ,S.HFitCoachingServiceLevel = T.HFitCoachingServiceLevel
                 ,S.HealthAdvisingEvaluationDate = T.HealthAdvisingEvaluationDate
                 ,S.HFitCallLogStatus = T.HFitCallLogStatus
                 ,S.HFitCallLogStatusDate = T.HFitCallLogStatusDate
                 ,S.HFitCoachingDeliveryMethod = T.HFitCoachingDeliveryMethod
                 ,S.HFitTrackerReminderDisplayed = T.HFitTrackerReminderDisplayed
                 ,S.HFitPrimaryContactID = T.HFitPrimaryContactID
                 ,S.HFitPrimaryContactGuid = T.HFitPrimaryContactGuid
                 ,S.HFitUserIsRegistered = T.HFitUserIsRegistered
                 ,S.UserDataComUser = T.UserDataComUser
                 ,S.UserDataComPassword = T.UserDataComPassword
                 ,S.UserShowIntroductionTile = T.UserShowIntroductionTile
                 ,S.UserDashboardApplications = T.UserDashboardApplications

                 ,S.LastModifiedDate = GETDATE () 
                 ,S.DeletedFlg = NULL
                 ,S.ConvertedToCentralTime = NULL
                 ,S.SYS_CHANGE_VERSION = CTE.SYS_CHANGE_VERSION
                   FROM STAGING_CMS_UserSettings AS S
                            JOIN
                            CMS_UserSettings AS T
                                ON
                                S.UserSettingsID = T.UserSettingsID
                            AND S.DeletedFlg IS NULL
                            JOIN CTE
                                ON CTE.UserSettingsID = T.UserSettingsID
                               AND (CTE.SYS_CHANGE_VERSION != S.SYS_CHANGE_VERSION
                                 OR S.SYS_CHANGE_VERSION IS NULL);

    DECLARE
    @iCnt AS int = @@ROWCOUNT;
    PRINT 'Updated Count: ' + CAST ( @iCnt AS nvarchar (50)) ;

    exec proc_CT_CMS_UserSettings_History 'U';

    --WITH CTE (
    --     UserSettingsID
    --   , SYS_CHANGE_VERSION
    --   , SYS_CHANGE_COLUMNS) 
    --    AS ( SELECT
    --                CT.UserSettingsID
    --              , CT.SYS_CHANGE_VERSION
    --              , SYS_CHANGE_COLUMNS
    --                FROM CHANGETABLE (CHANGES CMS_UserSettings, NULL) AS CT
    --                WHERE SYS_CHANGE_OPERATION = 'U'
    --         EXCEPT
    --         SELECT
    --                UserSettingsID
    --              , SYS_CHANGE_VERSION
    --              , SYS_CHANGE_COLUMNS
    --                FROM STAGING_CMS_UserSettings_Update_History
    --    ) 
    --    INSERT INTO STAGING_CMS_UserSettings_Update_History
    --    (
    --           UserSettingsID
    --         , LastModifiedDate
    --         , SVR
    --         , DBNAME
    --         , SYS_CHANGE_VERSION
    --         , SYS_CHANGE_COLUMNS, commit_time) 
    --    SELECT
    --           CTE.UserSettingsID
    --         , GETDATE () AS LastModifiedDate
    --         , @@SERVERNAME AS SVR
    --         , DB_NAME () AS DBNAME
    --         , CTE.SYS_CHANGE_VERSION
    --         , CTE.SYS_CHANGE_COLUMNS, tc.commit_time
    --           FROM CTE JOIN sys.dm_tran_commit_table AS tc
    --                       ON CTE.sys_change_version = tc.commit_ts;

    RETURN @iCnt;
END;

GO
PRINT 'Executed proc_CT_CMS_UserSettings_AddUpdatedRecs.sql';
GO
 --**************
print('END: ' + cast(getdate() as nvarchar(50)));
print('@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-');
print'***************************************************************' ;
print('START: ' + cast(getdate() as nvarchar(50)));
--**************

--SET ANSI_NULLS ON;
--SET ANSI_PADDING ON;
--SET ANSI_WARNINGS ON;
--SET ARITHABORT ON;
--SET CONCAT_NULL_YIELDS_NULL ON;
--SET NUMERIC_ROUNDABORT OFF;
--SET QUOTED_IDENTIFIER ON;





/*------------------------
-----------------
cms_user			    -> DONE
cms_usersettings	  -> DONE
cms_usersite
hfit_ppteligibility
cms_usercontact
*/
GO
PRINT 'Executing create_table_STAGING_CMS_UserSettings.sql';
GO

IF NOT EXISTS (SELECT
                      sys.tables.name AS Table_name
                      FROM
                          sys.change_tracking_tables
                              JOIN sys.tables
                                  ON sys.tables.object_id = sys.change_tracking_tables.object_id
                              JOIN sys.schemas
                                  ON sys.schemas.schema_id = sys.tables.schema_id
                      WHERE sys.tables.name = 'CMS_UserSettings') 
    BEGIN
        PRINT 'ADDING Change Tracking to CMS_UserSettings';
        ALTER TABLE dbo.CMS_UserSettings
            ENABLE CHANGE_TRACKING
                WITH (TRACK_COLUMNS_UPDATED = ON) ;
    END;
ELSE
    BEGIN
        PRINT 'Change Tracking exists on CMS_UserSettings';
    END;
GO
IF EXISTS (SELECT
                  name
                  FROM sys.procedures
                  WHERE name = 'proc_Create_Table_STAGING_CMS_UserSettings') 
    BEGIN
        DROP PROCEDURE
             proc_Create_Table_STAGING_CMS_UserSettings;
    END;
GO
-- exec proc_Create_Table_STAGING_CMS_UserSettings
-- select top 100 * from [STAGING_CMS_UserSettings]
CREATE PROCEDURE proc_Create_Table_STAGING_CMS_UserSettings
AS
BEGIN

    IF EXISTS (SELECT
                      name
                      FROM sys.tables
                      WHERE name = 'STAGING_CMS_UserSettings') 
        BEGIN
            DROP TABLE
                 dbo.STAGING_CMS_UserSettings;
        END;

    SET ANSI_NULLS ON;
    SET QUOTED_IDENTIFIER ON;

    CREATE TABLE dbo.STAGING_CMS_UserSettings (
                 UserSettingsID int NOT NULL
               , UserNickName nvarchar (200) NULL
               , UserPicture nvarchar (200) NULL
               , UserSignature nvarchar (max) NULL
               , UserURLReferrer nvarchar (450) NULL
               , UserCampaign nvarchar (200) NULL
               , UserMessagingNotificationEmail nvarchar (200) NULL
               , UserCustomData nvarchar (max) NULL
               , UserRegistrationInfo nvarchar (max) NULL
               , UserPreferences nvarchar (max) NULL
               , UserActivationDate datetime2 (7) NULL
               , UserActivatedByUserID int NULL
               , UserTimeZoneID int NULL
               , UserAvatarID int NULL
               , UserBadgeID int NULL
               , UserActivityPoints int NULL
               , UserForumPosts int NULL
               , UserBlogComments int NULL
               , UserGender int NULL
               , UserDateOfBirth datetime2 (7) NULL
               , UserMessageBoardPosts int NULL
               , UserSettingsUserGUID uniqueidentifier NOT NULL
               , UserSettingsUserID int NOT NULL
               , WindowsLiveID nvarchar (50) NULL
               , UserBlogPosts int NULL
               , UserWaitingForApproval bit NULL
               , UserDialogsConfiguration nvarchar (max) NULL
               , UserDescription nvarchar (max) NULL
               , UserUsedWebParts nvarchar (1000) NULL
               , UserUsedWidgets nvarchar (1000) NULL
               , UserFacebookID nvarchar (100) NULL
               , UserAuthenticationGUID uniqueidentifier NULL
               , UserSkype nvarchar (100) NULL
               , UserIM nvarchar (100) NULL
               , UserPhone nvarchar (26) NULL
               , UserPosition nvarchar (200) NULL
               , UserBounces int NULL
               , UserLinkedInID nvarchar (100) NULL
               , UserLogActivities bit NULL
               , UserPasswordRequestHash nvarchar (100) NULL
               , UserInvalidLogOnAttempts int NULL
               , UserInvalidLogOnAttemptsHash nvarchar (100) NULL
               , UserAvatarType nvarchar (200) NULL
               , UserAccountLockReason int NULL
               , UserPasswordLastChanged datetime2 (7) NULL
               , UserSecurityQuestionAnswer1 nvarchar (100) NULL
               , UserSecurityQuestionAnswer2 nvarchar (100) NULL
               , UserSecurityQuestionAnswer3 nvarchar (100) NULL
               , HfitUserSsoId nvarchar (250) NULL
               , HFitIsPlatformEnabled bit NULL
               , HFitIsHraEnabled bit NULL
               , HFitIsIncentivesEnabled bit NULL
               , HFitUserMpiNumber bigint NULL
               , SocialSecurity nvarchar (100) NULL
               , HFitUserMobilePhone nvarchar (15) NULL
               , HFitUserPhoneType nvarchar (10) NULL
               , HFitUserAgreesToTerms bit NULL
               , HFitUserPreferredEmail nvarchar (100) NULL
               , HFitUserPreferredPhone nvarchar (15) NULL
               , HFitUserPreferredFirstName nvarchar (50) NULL
               , HFitUserPhoneExt nvarchar (16) NULL
               , HFitComInboxNotifyByEmail bit NULL
               , HFitComInboxNotifyByText bit NULL
               , HFitComActivitiesNotifyEmail bit NULL
               , HFitComActivitiesNotifyText bit NULL
               , HFitComTipOfTheDayNotifyByEmail bit NULL
               , HFitComTipOfTheDayNotifyByText bit NULL
               , HFitComCoachingTrackingEmail bit NULL
               , HFitComCoachingTrackingText bit NULL
               , HfitUserPreferredMailingAddress nvarchar (100) NULL
               , HfitUserPreferredMailingCity nvarchar (50) NULL
               , HfitUserPreferredMailingState nvarchar (2) NULL
               , HfitUserPreferredMailingPostalCode nvarchar (10) NULL
               , HFitCoachingEnrollDate datetime2 (7) NULL
               , HFitUserAltPreferredPhone nvarchar (15) NULL
               , HFitUserAltPreferredPhoneType int NULL
               , HFitUserAltPreferredPhoneExt nvarchar (16) NULL
               , HFitHealthVision nvarchar (max) NULL
               , HFitCoachId int NULL
               , HFitUserTypeID int NULL
               , HFitCoachSystemLastActivity datetime2 (7) NULL
               , HFitIsConditionManagement bit NULL
               , HFitCoachSystemNextActivity datetime2 (7) NULL
               , HFitCoachWebLastActivity datetime2 (7) NULL
               , HFitUserPreferredCallTime int NULL
               , HFitCoachSession1Date datetime2 (7) NULL
               , HFitCoachSystemCoachID int NULL
               , HFitUserPreferredMailingAddress2 nvarchar (100) NULL
               , HFitCoachingOptOutDate datetime2 (7) NULL
               , HFitCoachingOptOutItemID int NULL
               , HFitComScreeningSchedulersEmail bit NULL
               , HFitCoachingOptOutSentDate datetime2 (7) NULL
               , HFitComScreeningSchedulersText bit NULL
               , WellnessGoalGuid uniqueidentifier NULL
               , UserSecurityQuestionGuid1 uniqueidentifier NULL
               , UserSecurityQuestionGuid2 uniqueidentifier NULL
               , UserSecurityQuestionGuid3 uniqueidentifier NULL
               , HFitUserRegistrationDate datetime2 (7) NULL
               , HFitCoachingServiceLevel int NULL
               , HealthAdvisingEvaluationDate datetime2 (7) NULL
               , HFitCallLogStatus int NULL
               , HFitCallLogStatusDate datetime2 (7) NULL
               , HFitCoachingDeliveryMethod int NULL
               , HFitTrackerReminderDisplayed datetime2 (7) NULL
               , HFitPrimaryContactID int NULL
               , HFitPrimaryContactGuid uniqueidentifier NULL
               , HFitUserIsRegistered bit NULL
               , UserDataComUser nvarchar (200) NULL
               , UserDataComPassword nvarchar (200) NULL
               , UserShowIntroductionTile bit NULL
               , UserDashboardApplications nvarchar (max) NULL
               , LastModifiedDate datetime NULL
               , RowNbr int NULL
               , DeletedFlg bit NULL
               , TimeZone nvarchar (10) NULL
               , ConvertedToCentralTime bit NULL
               , SVR nvarchar (100) NOT NULL
               , DBNAME nvarchar (100) NOT NULL
               , SYS_CHANGE_VERSION int NULL
    ) 
    ON [PRIMARY] TEXTIMAGE_ON [PRIMARY];

    ALTER TABLE dbo.STAGING_CMS_UserSettings
    ADD
                DEFAULT @@servername FOR SVR;
    ALTER TABLE dbo.STAGING_CMS_UserSettings
    ADD
                DEFAULT DB_NAME () FOR DBNAME;

    CREATE CLUSTERED INDEX PI_STAGING_CMS_UserSettings ON dbo.STAGING_CMS_UserSettings
    (
    UserSettingsID ASC,
    SVR ASC,
    DBNAME ASC,
    SYS_CHANGE_VERSION ASC
    )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];

    --SET IDENTITY_INSERT STAGING_CMS_UserSettings ON;

    INSERT INTO STAGING_CMS_UserSettings
    (
           UserSettingsID
         , UserNickName
         , UserPicture
         , UserSignature
         , UserURLReferrer
         , UserCampaign
         , UserMessagingNotificationEmail
         , UserCustomData
         , UserRegistrationInfo
         , UserPreferences
         , UserActivationDate
         , UserActivatedByUserID
         , UserTimeZoneID
         , UserAvatarID
         , UserBadgeID
         , UserActivityPoints
         , UserForumPosts
         , UserBlogComments
         , UserGender
         , UserDateOfBirth
         , UserMessageBoardPosts
         , UserSettingsUserGUID
         , UserSettingsUserID
         , WindowsLiveID
         , UserBlogPosts
         , UserWaitingForApproval
         , UserDialogsConfiguration
         , UserDescription
         , UserUsedWebParts
         , UserUsedWidgets
         , UserFacebookID
         , UserAuthenticationGUID
         , UserSkype
         , UserIM
         , UserPhone
         , UserPosition
         , UserBounces
         , UserLinkedInID
         , UserLogActivities
         , UserPasswordRequestHash
         , UserInvalidLogOnAttempts
         , UserInvalidLogOnAttemptsHash
         , UserAvatarType
         , UserAccountLockReason
         , UserPasswordLastChanged
         , UserSecurityQuestionAnswer1
         , UserSecurityQuestionAnswer2
         , UserSecurityQuestionAnswer3
         , HfitUserSsoId
         , HFitIsPlatformEnabled
         , HFitIsHraEnabled
         , HFitIsIncentivesEnabled
         , HFitUserMpiNumber
         , SocialSecurity
         , HFitUserMobilePhone
         , HFitUserPhoneType
         , HFitUserAgreesToTerms
         , HFitUserPreferredEmail
         , HFitUserPreferredPhone
         , HFitUserPreferredFirstName
         , HFitUserPhoneExt
         , HFitComInboxNotifyByEmail
         , HFitComInboxNotifyByText
         , HFitComActivitiesNotifyEmail
         , HFitComActivitiesNotifyText
         , HFitComTipOfTheDayNotifyByEmail
         , HFitComTipOfTheDayNotifyByText
         , HFitComCoachingTrackingEmail
         , HFitComCoachingTrackingText
         , HfitUserPreferredMailingAddress
         , HfitUserPreferredMailingCity
         , HfitUserPreferredMailingState
         , HfitUserPreferredMailingPostalCode
         , HFitCoachingEnrollDate
         , HFitUserAltPreferredPhone
         , HFitUserAltPreferredPhoneType
         , HFitUserAltPreferredPhoneExt
         , HFitHealthVision
         , HFitCoachId
         , HFitUserTypeID
         , HFitCoachSystemLastActivity
         , HFitIsConditionManagement
         , HFitCoachSystemNextActivity
         , HFitCoachWebLastActivity
         , HFitUserPreferredCallTime
         , HFitCoachSession1Date
         , HFitCoachSystemCoachID
         , HFitUserPreferredMailingAddress2
         , HFitCoachingOptOutDate
         , HFitCoachingOptOutItemID
         , HFitComScreeningSchedulersEmail
         , HFitCoachingOptOutSentDate
         , HFitComScreeningSchedulersText
         , WellnessGoalGuid
         , UserSecurityQuestionGuid1
         , UserSecurityQuestionGuid2
         , UserSecurityQuestionGuid3
         , HFitUserRegistrationDate
         , HFitCoachingServiceLevel
         , HealthAdvisingEvaluationDate
         , HFitCallLogStatus
         , HFitCallLogStatusDate
         , HFitCoachingDeliveryMethod
         , HFitTrackerReminderDisplayed
         , HFitPrimaryContactID
         , HFitPrimaryContactGuid
         , HFitUserIsRegistered
         , UserDataComUser
         , UserDataComPassword
         , UserShowIntroductionTile
         , UserDashboardApplications) 
    SELECT
           UserSettingsID
         , UserNickName
         , UserPicture
         , UserSignature
         , UserURLReferrer
         , UserCampaign
         , UserMessagingNotificationEmail
         , UserCustomData
         , UserRegistrationInfo
         , UserPreferences
         , UserActivationDate
         , UserActivatedByUserID
         , UserTimeZoneID
         , UserAvatarID
         , UserBadgeID
         , UserActivityPoints
         , UserForumPosts
         , UserBlogComments
         , UserGender
         , UserDateOfBirth
         , UserMessageBoardPosts
         , UserSettingsUserGUID
         , UserSettingsUserID
         , WindowsLiveID
         , UserBlogPosts
         , UserWaitingForApproval
         , UserDialogsConfiguration
         , UserDescription
         , UserUsedWebParts
         , UserUsedWidgets
         , UserFacebookID
         , UserAuthenticationGUID
         , UserSkype
         , UserIM
         , UserPhone
         , UserPosition
         , UserBounces
         , UserLinkedInID
         , UserLogActivities
         , UserPasswordRequestHash
         , UserInvalidLogOnAttempts
         , UserInvalidLogOnAttemptsHash
         , UserAvatarType
         , UserAccountLockReason
         , UserPasswordLastChanged
         , UserSecurityQuestionAnswer1
         , UserSecurityQuestionAnswer2
         , UserSecurityQuestionAnswer3
         , HfitUserSsoId
         , HFitIsPlatformEnabled
         , HFitIsHraEnabled
         , HFitIsIncentivesEnabled
         , HFitUserMpiNumber
         , SocialSecurity
         , HFitUserMobilePhone
         , HFitUserPhoneType
         , HFitUserAgreesToTerms
         , HFitUserPreferredEmail
         , HFitUserPreferredPhone
         , HFitUserPreferredFirstName
         , HFitUserPhoneExt
         , HFitComInboxNotifyByEmail
         , HFitComInboxNotifyByText
         , HFitComActivitiesNotifyEmail
         , HFitComActivitiesNotifyText
         , HFitComTipOfTheDayNotifyByEmail
         , HFitComTipOfTheDayNotifyByText
         , HFitComCoachingTrackingEmail
         , HFitComCoachingTrackingText
         , HfitUserPreferredMailingAddress
         , HfitUserPreferredMailingCity
         , HfitUserPreferredMailingState
         , HfitUserPreferredMailingPostalCode
         , HFitCoachingEnrollDate
         , HFitUserAltPreferredPhone
         , HFitUserAltPreferredPhoneType
         , HFitUserAltPreferredPhoneExt
         , HFitHealthVision
         , HFitCoachId
         , HFitUserTypeID
         , HFitCoachSystemLastActivity
         , HFitIsConditionManagement
         , HFitCoachSystemNextActivity
         , HFitCoachWebLastActivity
         , HFitUserPreferredCallTime
         , HFitCoachSession1Date
         , HFitCoachSystemCoachID
         , HFitUserPreferredMailingAddress2
         , HFitCoachingOptOutDate
         , HFitCoachingOptOutItemID
         , HFitComScreeningSchedulersEmail
         , HFitCoachingOptOutSentDate
         , HFitComScreeningSchedulersText
         , WellnessGoalGuid
         , UserSecurityQuestionGuid1
         , UserSecurityQuestionGuid2
         , UserSecurityQuestionGuid3
         , HFitUserRegistrationDate
         , HFitCoachingServiceLevel
         , HealthAdvisingEvaluationDate
         , HFitCallLogStatus
         , HFitCallLogStatusDate
         , HFitCoachingDeliveryMethod
         , HFitTrackerReminderDisplayed
         , HFitPrimaryContactID
         , HFitPrimaryContactGuid
         , HFitUserIsRegistered
         , UserDataComUser
         , UserDataComPassword
         , UserShowIntroductionTile
         , UserDashboardApplications
           FROM CMS_UserSettings;

    --SET IDENTITY_INSERT STAGING_CMS_UserSettings OFF;

    IF EXISTS (SELECT
                      name
                      FROM sys.tables
                      WHERE name = 'STAGING_CMS_UserSettings_Update_History') 
        BEGIN
            DROP TABLE
                 STAGING_CMS_UserSettings_Update_History;
        END;

    CREATE TABLE dbo.STAGING_CMS_UserSettings_Update_History (
                 UserSettingsid int NOT NULL
               ,SYS_CHANGE_VERSION bigint NULL
               ,SYS_CHANGE_OPERATION nchar (1) NULL
               ,SYS_CHANGE_COLUMNS varbinary (4100) NULL
               ,CurrUser varchar (60) NOT NULL
               ,SysUser varchar (60) NOT NULL
               ,IPADDR varchar (60) NOT NULL
               ,commit_time datetime NOT NULL
               ,LastModifiedDate datetime NOT NULL
               ,SVR nvarchar (128) NULL
               ,DBNAME nvarchar (128) NULL
               ,UserSettingsID_cg int NULL
               ,UserNickName_cg int NULL
               ,UserPicture_cg int NULL
               ,UserSignature_cg int NULL
               ,UserURLReferrer_cg int NULL
               ,UserCampaign_cg int NULL
               ,UserMessagingNotificationEmail_cg int NULL
               ,UserCustomData_cg int NULL
               ,UserRegistrationInfo_cg int NULL
               ,UserPreferences_cg int NULL
               ,UserActivationDate_cg int NULL
               ,UserActivatedByUserID_cg int NULL
               ,UserTimeZoneID_cg int NULL
               ,UserAvatarID_cg int NULL
               ,UserBadgeID_cg int NULL
               ,UserActivityPoints_cg int NULL
               ,UserForumPosts_cg int NULL
               ,UserBlogComments_cg int NULL
               ,UserGender_cg int NULL
               ,UserDateOfBirth_cg int NULL
               ,UserMessageBoardPosts_cg int NULL
               ,UserSettingsUserGUID_cg int NULL
               ,UserSettingsUserID_cg int NULL
               ,WindowsLiveID_cg int NULL
               ,UserBlogPosts_cg int NULL
               ,UserWaitingForApproval_cg int NULL
               ,UserDialogsConfiguration_cg int NULL
               ,UserDescription_cg int NULL
               ,UserUsedWebParts_cg int NULL
               ,UserUsedWidgets_cg int NULL
               ,UserFacebookID_cg int NULL
               ,UserAuthenticationGUID_cg int NULL
               ,UserSkype_cg int NULL
               ,UserIM_cg int NULL
               ,UserPhone_cg int NULL
               ,UserPosition_cg int NULL
               ,UserBounces_cg int NULL
               ,UserLinkedInID_cg int NULL
               ,UserLogActivities_cg int NULL
               ,UserPasswordRequestHash_cg int NULL
               ,UserInvalidLogOnAttempts_cg int NULL
               ,UserInvalidLogOnAttemptsHash_cg int NULL
               ,UserAvatarType_cg int NULL
               ,UserAccountLockReason_cg int NULL
               ,UserPasswordLastChanged_cg int NULL
               ,UserSecurityQuestionAnswer1_cg int NULL
               ,UserSecurityQuestionAnswer2_cg int NULL
               ,UserSecurityQuestionAnswer3_cg int NULL
               ,HfitUserSsoId_cg int NULL
               ,HFitIsPlatformEnabled_cg int NULL
               ,HFitIsHraEnabled_cg int NULL
               ,HFitIsIncentivesEnabled_cg int NULL
               ,HFitUserMpiNumber_cg int NULL
               ,SocialSecurity_cg int NULL
               ,HFitUserMobilePhone_cg int NULL
               ,HFitUserPhoneType_cg int NULL
               ,HFitUserAgreesToTerms_cg int NULL
               ,HFitUserPreferredEmail_cg int NULL
               ,HFitUserPreferredPhone_cg int NULL
               ,HFitUserPreferredFirstName_cg int NULL
               ,HFitUserPhoneExt_cg int NULL
               ,HFitComInboxNotifyByEmail_cg int NULL
               ,HFitComInboxNotifyByText_cg int NULL
               ,HFitComActivitiesNotifyEmail_cg int NULL
               ,HFitComActivitiesNotifyText_cg int NULL
               ,HFitComTipOfTheDayNotifyByEmail_cg int NULL
               ,HFitComTipOfTheDayNotifyByText_cg int NULL
               ,HFitComCoachingTrackingEmail_cg int NULL
               ,HFitComCoachingTrackingText_cg int NULL
               ,HfitUserPreferredMailingAddress_cg int NULL
               ,HfitUserPreferredMailingCity_cg int NULL
               ,HfitUserPreferredMailingState_cg int NULL
               ,HfitUserPreferredMailingPostalCode_cg int NULL
               ,HFitCoachingEnrollDate_cg int NULL
               ,HFitUserAltPreferredPhone_cg int NULL
               ,HFitUserAltPreferredPhoneType_cg int NULL
               ,HFitUserAltPreferredPhoneExt_cg int NULL
               ,HFitHealthVision_cg int NULL
               ,HFitCoachId_cg int NULL
               ,HFitUserTypeID_cg int NULL
               ,HFitCoachSystemLastActivity_cg int NULL
               ,HFitIsConditionManagement_cg int NULL
               ,HFitCoachSystemNextActivity_cg int NULL
               ,HFitCoachWebLastActivity_cg int NULL
               ,HFitUserPreferredCallTime_cg int NULL
               ,HFitCoachSession1Date_cg int NULL
               ,HFitCoachSystemCoachID_cg int NULL
               ,HFitUserPreferredMailingAddress2_cg int NULL
               ,HFitCoachingOptOutDate_cg int NULL
               ,HFitCoachingOptOutItemID_cg int NULL
               ,HFitComScreeningSchedulersEmail_cg int NULL
               ,HFitCoachingOptOutSentDate_cg int NULL
               ,HFitComScreeningSchedulersText_cg int NULL
               ,WellnessGoalGuid_cg int NULL
               ,UserSecurityQuestionGuid1_cg int NULL
               ,UserSecurityQuestionGuid2_cg int NULL
               ,UserSecurityQuestionGuid3_cg int NULL
               ,HFitUserRegistrationDate_cg int NULL
               ,HFitCoachingServiceLevel_cg int NULL
               ,HealthAdvisingEvaluationDate_cg int NULL
               ,HFitCallLogStatus_cg int NULL
               ,HFitCallLogStatusDate_cg int NULL
               ,HFitCoachingDeliveryMethod_cg int NULL
               ,HFitTrackerReminderDisplayed_cg int NULL
               ,HFitPrimaryContactID_cg int NULL
               ,HFitPrimaryContactGuid_cg int NULL
               ,HFitUserIsRegistered_cg int NULL
               ,UserDataComUser_cg int NULL
               ,UserDataComPassword_cg int NULL
               ,UserShowIntroductionTile_cg int NULL
               ,UserDashboardApplications_cg int NULL
               ,HFitForgotPasswordAttempts_cg int NULL
               ,HFitForgotPasswordStarted_cg int NULL
    ) 
    ON [PRIMARY];

    ALTER TABLE dbo.STAGING_CMS_UserSettings_Update_History
    ADD
                CONSTRAINT DF_STAGING_CMS_UserSettings_Update_History_CurrUser  DEFAULT USER_NAME () FOR CurrUser;
    ALTER TABLE dbo.STAGING_CMS_UserSettings_Update_History
    ADD
                CONSTRAINT DF_STAGING_CMS_UserSettings_Update_History_SysUser  DEFAULT SUSER_SNAME () FOR SysUser;
    ALTER TABLE dbo.STAGING_CMS_UserSettings_Update_History
    ADD
                CONSTRAINT DF_STAGING_CMS_UserSettings_Update_History_IPADDR  DEFAULT CONVERT (nvarchar (50) , CONNECTIONPROPERTY ('client_net_address')) FOR IPADDR;

    CREATE CLUSTERED INDEX PI_STAGING_CMS_UserSettings_Update_History ON dbo.STAGING_CMS_UserSettings_Update_History
    (
    UserSettingsID ASC,
    SVR ASC,
    SYS_CHANGE_VERSION ASC
    )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];

    --CREATE CLUSTERED INDEX [PI_STAGING_CMS_UserSettings_Update_History] ON [dbo].[STAGING_CMS_UserSettings_Update_History]
    --(
	   -- [UserSettingsid] ASC
    --)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

END;

GO
PRINT 'Executed create_table_STAGING_CMS_UserSettings.sql';
GO
EXEC proc_Create_Table_STAGING_CMS_UserSettings;
GO

--**************
print('END: ' + cast(getdate() as nvarchar(50)));
print('@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-');
print'***************************************************************' ;
print('START: ' + cast(getdate() as nvarchar(50)));
--**************

--SET ANSI_NULLS ON;
--SET ANSI_PADDING ON;
--SET ANSI_WARNINGS ON;
--SET ARITHABORT ON;
--SET CONCAT_NULL_YIELDS_NULL ON;
--SET NUMERIC_ROUNDABORT OFF;
--SET QUOTED_IDENTIFIER ON;





GO
PRINT 'Executing proc_CT_CMS_UserSettings_History.sql';
GO
IF EXISTS ( SELECT
                   name
                   FROM sys.procedures
                   WHERE name = 'proc_CT_CMS_UserSettings_History') 
    BEGIN
        DROP PROCEDURE
             proc_CT_CMS_UserSettings_History;
    END;
GO

/*-------------------------------------------------------------------------
*************************************************************************

select tc.commit_time, *
from
    changetable(changes CMS_UserSettings, 0) c
    join sys.dm_tran_commit_table tc on c.sys_change_version = tc.commit_ts


exec proc_CT_CMS_UserSettings_History 'I'
exec proc_CT_CMS_UserSettings_History 'D'
exec proc_CT_CMS_UserSettings_History 'U'

truncate table STAGING_CMS_UserSettings_Update_History
select * from STAGING_CMS_UserSettings_Update_History

SELECT CHANGE_TRACKING_MIN_VALID_VERSION(OBJECT_ID('CMS_UserSettings'))
*************************************************************************
*/

CREATE PROCEDURE proc_CT_CMS_UserSettings_History (
     @Typesave AS nchar (1)) 
AS
BEGIN
    WITH CTE (
         UserSettingsID
       , SYS_CHANGE_VERSION
       , SYS_CHANGE_COLUMNS) 
        AS ( SELECT
                    CT.UserSettingsID
                  , CT.SYS_CHANGE_VERSION
                  , SYS_CHANGE_COLUMNS
                    FROM CHANGETABLE (CHANGES CMS_UserSettings, NULL) AS CT
                    WHERE SYS_CHANGE_OPERATION = 'U' --@Typesave
             EXCEPT
             SELECT
                    UserSettingsID
                  , SYS_CHANGE_VERSION
                  , SYS_CHANGE_COLUMNS
                    FROM STAGING_CMS_UserSettings_Update_History) 
        INSERT INTO STAGING_CMS_UserSettings_Update_History
        (
               UserSettingsid
             , SYS_CHANGE_VERSION
             , SYS_CHANGE_OPERATION
             , SYS_CHANGE_COLUMNS

               --, CurrUser 
               --, SysUser 
               --, IPADDR 

             , commit_time
             , LastModifiedDate
             , SVR
             , DBNAME
             , HealthAdvisingEvaluationDate_cg
             , HFitCallLogStatus_cg
             , HFitCallLogStatusDate_cg
             , HFitCoachId_cg
             , HFitCoachingDeliveryMethod_cg
             , HFitCoachingEnrollDate_cg
             , HFitCoachingOptOutDate_cg
             , HFitCoachingOptOutItemID_cg
             , HFitCoachingOptOutSentDate_cg
             , HFitCoachingServiceLevel_cg
             , HFitCoachSession1Date_cg
             , HFitCoachSystemCoachID_cg
             , HFitCoachSystemLastActivity_cg
             , HFitCoachSystemNextActivity_cg
             , HFitCoachWebLastActivity_cg
             , HFitComActivitiesNotifyEmail_cg
             , HFitComActivitiesNotifyText_cg
             , HFitComCoachingTrackingEmail_cg
             , HFitComCoachingTrackingText_cg
             , HFitComInboxNotifyByEmail_cg
             , HFitComInboxNotifyByText_cg
             , HFitComScreeningSchedulersEmail_cg
             , HFitComScreeningSchedulersText_cg
             , HFitComTipOfTheDayNotifyByEmail_cg
             , HFitComTipOfTheDayNotifyByText_cg
             , HFitHealthVision_cg
             , HFitIsConditionManagement_cg
             , HFitIsHraEnabled_cg
             , HFitIsIncentivesEnabled_cg
             , HFitIsPlatformEnabled_cg
             , HFitPrimaryContactGuid_cg
             , HFitPrimaryContactID_cg
             , HFitTrackerReminderDisplayed_cg
             , HFitUserAgreesToTerms_cg
             , HFitUserAltPreferredPhone_cg
             , HFitUserAltPreferredPhoneExt_cg
             , HFitUserAltPreferredPhoneType_cg
             , HFitUserIsRegistered_cg
             , HFitUserMobilePhone_cg
             , HFitUserMpiNumber_cg
             , HFitUserPhoneExt_cg
             , HFitUserPhoneType_cg
             , HFitUserPreferredCallTime_cg
             , HFitUserPreferredEmail_cg
             , HFitUserPreferredFirstName_cg
             , HfitUserPreferredMailingAddress_cg
             , HFitUserPreferredMailingAddress2_cg
             , HfitUserPreferredMailingCity_cg
             , HfitUserPreferredMailingPostalCode_cg
             , HfitUserPreferredMailingState_cg
             , HFitUserPreferredPhone_cg
             , HFitUserRegistrationDate_cg
             , HfitUserSsoId_cg
             , HFitUserTypeID_cg
             , SocialSecurity_cg
             , UserAccountLockReason_cg
             , UserActivatedByUserID_cg
             , UserActivationDate_cg
             , UserActivityPoints_cg
             , UserAuthenticationGUID_cg
             , UserAvatarID_cg
             , UserAvatarType_cg
             , UserBadgeID_cg
             , UserBlogComments_cg
             , UserBlogPosts_cg
             , UserBounces_cg
             , UserCampaign_cg
             , UserCustomData_cg
             , UserDashboardApplications_cg
             , UserDataComPassword_cg
             , UserDataComUser_cg
             , UserDateOfBirth_cg
             , UserDescription_cg
             , UserDialogsConfiguration_cg
             , UserFacebookID_cg
             , UserForumPosts_cg
             , UserGender_cg
             , UserIM_cg
             , UserInvalidLogOnAttempts_cg
             , UserInvalidLogOnAttemptsHash_cg
             , UserLinkedInID_cg
             , UserLogActivities_cg
             , UserMessageBoardPosts_cg
             , UserMessagingNotificationEmail_cg
             , UserNickName_cg
             , UserPasswordLastChanged_cg
             , UserPasswordRequestHash_cg
             , UserPhone_cg
             , UserPicture_cg
             , UserPosition_cg
             , UserPreferences_cg
             , UserRegistrationInfo_cg
             , UserSecurityQuestionAnswer1_cg
             , UserSecurityQuestionAnswer2_cg
             , UserSecurityQuestionAnswer3_cg
             , UserSecurityQuestionGuid1_cg
             , UserSecurityQuestionGuid2_cg
             , UserSecurityQuestionGuid3_cg
             , UserSettingsID_cg
             , UserSettingsUserGUID_cg
             , UserSettingsUserID_cg
             , UserShowIntroductionTile_cg
             , UserSignature_cg
             , UserSkype_cg
             , UserTimeZoneID_cg
             , UserURLReferrer_cg
             , UserUsedWebParts_cg
             , UserUsedWidgets_cg
             , UserWaitingForApproval_cg
             , WellnessGoalGuid_cg
             , WindowsLiveID_cg) 
        SELECT
               CTE.UserSettingsID
             , CTE.SYS_CHANGE_VERSION
             --, @Typesave AS SYS_CHANGE_OPERATION
		   , 'U' AS SYS_CHANGE_OPERATION
             , CTE.SYS_CHANGE_COLUMNS

               --, CurrUser
               --, SysUser
               --, IPADDR

             , ISNULL ( tc.commit_time , GETDATE ()) 
             , GETDATE () AS LastModifiedDate
             , @@Servername AS SVR
             , DB_NAME () AS DBNAME

               --********************************************     

             , change_tracking_is_column_in_mask ( COLUMNPROPERTY ( OBJECT_ID ( 'CMS_UserSettings') , 'HealthAdvisingEvaluationDate' , 'columnid') , CTE.sys_change_columns) AS HealthAdvisingEvaluationDate_cg
             , change_tracking_is_column_in_mask ( COLUMNPROPERTY ( OBJECT_ID ( 'CMS_UserSettings') , 'HFitCallLogStatus' , 'columnid') , CTE.sys_change_columns) AS HFitCallLogStatus_cg
             , change_tracking_is_column_in_mask ( COLUMNPROPERTY ( OBJECT_ID ( 'CMS_UserSettings') , 'HFitCallLogStatusDate' , 'columnid') , CTE.sys_change_columns) AS HFitCallLogStatusDate_cg
             , change_tracking_is_column_in_mask ( COLUMNPROPERTY ( OBJECT_ID ( 'CMS_UserSettings') , 'HFitCoachId' , 'columnid') , CTE.sys_change_columns) AS HFitCoachId_cg
             , change_tracking_is_column_in_mask ( COLUMNPROPERTY ( OBJECT_ID ( 'CMS_UserSettings') , 'HFitCoachingDeliveryMethod' , 'columnid') , CTE.sys_change_columns) AS HFitCoachingDeliveryMethod_cg
             , change_tracking_is_column_in_mask ( COLUMNPROPERTY ( OBJECT_ID ( 'CMS_UserSettings') , 'HFitCoachingEnrollDate' , 'columnid') , CTE.sys_change_columns) AS HFitCoachingEnrollDate_cg
             , change_tracking_is_column_in_mask ( COLUMNPROPERTY ( OBJECT_ID ( 'CMS_UserSettings') , 'HFitCoachingOptOutDate' , 'columnid') , CTE.sys_change_columns) AS HFitCoachingOptOutDate_cg
             , change_tracking_is_column_in_mask ( COLUMNPROPERTY ( OBJECT_ID ( 'CMS_UserSettings') , 'HFitCoachingOptOutItemID' , 'columnid') , CTE.sys_change_columns) AS HFitCoachingOptOutItemID_cg
             , change_tracking_is_column_in_mask ( COLUMNPROPERTY ( OBJECT_ID ( 'CMS_UserSettings') , 'HFitCoachingOptOutSentDate' , 'columnid') , CTE.sys_change_columns) AS HFitCoachingOptOutSentDate_cg
             , change_tracking_is_column_in_mask ( COLUMNPROPERTY ( OBJECT_ID ( 'CMS_UserSettings') , 'HFitCoachingServiceLevel' , 'columnid') , CTE.sys_change_columns) AS HFitCoachingServiceLevel_cg
             , change_tracking_is_column_in_mask ( COLUMNPROPERTY ( OBJECT_ID ( 'CMS_UserSettings') , 'HFitCoachSession1Date' , 'columnid') , CTE.sys_change_columns) AS HFitCoachSession1Date_cg
             , change_tracking_is_column_in_mask ( COLUMNPROPERTY ( OBJECT_ID ( 'CMS_UserSettings') , 'HFitCoachSystemCoachID' , 'columnid') , CTE.sys_change_columns) AS HFitCoachSystemCoachID_cg
             , change_tracking_is_column_in_mask ( COLUMNPROPERTY ( OBJECT_ID ( 'CMS_UserSettings') , 'HFitCoachSystemLastActivity' , 'columnid') , CTE.sys_change_columns) AS HFitCoachSystemLastActivity_cg
             , change_tracking_is_column_in_mask ( COLUMNPROPERTY ( OBJECT_ID ( 'CMS_UserSettings') , 'HFitCoachSystemNextActivity' , 'columnid') , CTE.sys_change_columns) AS HFitCoachSystemNextActivity_cg
             , change_tracking_is_column_in_mask ( COLUMNPROPERTY ( OBJECT_ID ( 'CMS_UserSettings') , 'HFitCoachWebLastActivity' , 'columnid') , CTE.sys_change_columns) AS HFitCoachWebLastActivity_cg
             , change_tracking_is_column_in_mask ( COLUMNPROPERTY ( OBJECT_ID ( 'CMS_UserSettings') , 'HFitComActivitiesNotifyEmail' , 'columnid') , CTE.sys_change_columns) AS HFitComActivitiesNotifyEmail_cg
             , change_tracking_is_column_in_mask ( COLUMNPROPERTY ( OBJECT_ID ( 'CMS_UserSettings') , 'HFitComActivitiesNotifyText' , 'columnid') , CTE.sys_change_columns) AS HFitComActivitiesNotifyText_cg
             , change_tracking_is_column_in_mask ( COLUMNPROPERTY ( OBJECT_ID ( 'CMS_UserSettings') , 'HFitComCoachingTrackingEmail' , 'columnid') , CTE.sys_change_columns) AS HFitComCoachingTrackingEmail_cg
             , change_tracking_is_column_in_mask ( COLUMNPROPERTY ( OBJECT_ID ( 'CMS_UserSettings') , 'HFitComCoachingTrackingText' , 'columnid') , CTE.sys_change_columns) AS HFitComCoachingTrackingText_cg
             , change_tracking_is_column_in_mask ( COLUMNPROPERTY ( OBJECT_ID ( 'CMS_UserSettings') , 'HFitComInboxNotifyByEmail' , 'columnid') , CTE.sys_change_columns) AS HFitComInboxNotifyByEmail_cg
             , change_tracking_is_column_in_mask ( COLUMNPROPERTY ( OBJECT_ID ( 'CMS_UserSettings') , 'HFitComInboxNotifyByText' , 'columnid') , CTE.sys_change_columns) AS HFitComInboxNotifyByText_cg
             , change_tracking_is_column_in_mask ( COLUMNPROPERTY ( OBJECT_ID ( 'CMS_UserSettings') , 'HFitComScreeningSchedulersEmail' , 'columnid') , CTE.sys_change_columns) AS HFitComScreeningSchedulersEmail_cg
             , change_tracking_is_column_in_mask ( COLUMNPROPERTY ( OBJECT_ID ( 'CMS_UserSettings') , 'HFitComScreeningSchedulersText' , 'columnid') , CTE.sys_change_columns) AS HFitComScreeningSchedulersText_cg
             , change_tracking_is_column_in_mask ( COLUMNPROPERTY ( OBJECT_ID ( 'CMS_UserSettings') , 'HFitComTipOfTheDayNotifyByEmail' , 'columnid') , CTE.sys_change_columns) AS HFitComTipOfTheDayNotifyByEmail_cg
             , change_tracking_is_column_in_mask ( COLUMNPROPERTY ( OBJECT_ID ( 'CMS_UserSettings') , 'HFitComTipOfTheDayNotifyByText' , 'columnid') , CTE.sys_change_columns) AS HFitComTipOfTheDayNotifyByText_cg
             , change_tracking_is_column_in_mask ( COLUMNPROPERTY ( OBJECT_ID ( 'CMS_UserSettings') , 'HFitHealthVision' , 'columnid') , CTE.sys_change_columns) AS HFitHealthVision_cg
             , change_tracking_is_column_in_mask ( COLUMNPROPERTY ( OBJECT_ID ( 'CMS_UserSettings') , 'HFitIsConditionManagement' , 'columnid') , CTE.sys_change_columns) AS HFitIsConditionManagement_cg
             , change_tracking_is_column_in_mask ( COLUMNPROPERTY ( OBJECT_ID ( 'CMS_UserSettings') , 'HFitIsHraEnabled' , 'columnid') , CTE.sys_change_columns) AS HFitIsHraEnabled_cg
             , change_tracking_is_column_in_mask ( COLUMNPROPERTY ( OBJECT_ID ( 'CMS_UserSettings') , 'HFitIsIncentivesEnabled' , 'columnid') , CTE.sys_change_columns) AS HFitIsIncentivesEnabled_cg
             , change_tracking_is_column_in_mask ( COLUMNPROPERTY ( OBJECT_ID ( 'CMS_UserSettings') , 'HFitIsPlatformEnabled' , 'columnid') , CTE.sys_change_columns) AS HFitIsPlatformEnabled_cg
             , change_tracking_is_column_in_mask ( COLUMNPROPERTY ( OBJECT_ID ( 'CMS_UserSettings') , 'HFitPrimaryContactGuid' , 'columnid') , CTE.sys_change_columns) AS HFitPrimaryContactGuid_cg
             , change_tracking_is_column_in_mask ( COLUMNPROPERTY ( OBJECT_ID ( 'CMS_UserSettings') , 'HFitPrimaryContactID' , 'columnid') , CTE.sys_change_columns) AS HFitPrimaryContactID_cg
             , change_tracking_is_column_in_mask ( COLUMNPROPERTY ( OBJECT_ID ( 'CMS_UserSettings') , 'HFitTrackerReminderDisplayed' , 'columnid') , CTE.sys_change_columns) AS HFitTrackerReminderDisplayed_cg
             , change_tracking_is_column_in_mask ( COLUMNPROPERTY ( OBJECT_ID ( 'CMS_UserSettings') , 'HFitUserAgreesToTerms' , 'columnid') , CTE.sys_change_columns) AS HFitUserAgreesToTerms_cg
             , change_tracking_is_column_in_mask ( COLUMNPROPERTY ( OBJECT_ID ( 'CMS_UserSettings') , 'HFitUserAltPreferredPhone' , 'columnid') , CTE.sys_change_columns) AS HFitUserAltPreferredPhone_cg
             , change_tracking_is_column_in_mask ( COLUMNPROPERTY ( OBJECT_ID ( 'CMS_UserSettings') , 'HFitUserAltPreferredPhoneExt' , 'columnid') , CTE.sys_change_columns) AS HFitUserAltPreferredPhoneExt_cg
             , change_tracking_is_column_in_mask ( COLUMNPROPERTY ( OBJECT_ID ( 'CMS_UserSettings') , 'HFitUserAltPreferredPhoneType' , 'columnid') , CTE.sys_change_columns) AS HFitUserAltPreferredPhoneType_cg
             , change_tracking_is_column_in_mask ( COLUMNPROPERTY ( OBJECT_ID ( 'CMS_UserSettings') , 'HFitUserIsRegistered' , 'columnid') , CTE.sys_change_columns) AS HFitUserIsRegistered_cg
             , change_tracking_is_column_in_mask ( COLUMNPROPERTY ( OBJECT_ID ( 'CMS_UserSettings') , 'HFitUserMobilePhone' , 'columnid') , CTE.sys_change_columns) AS HFitUserMobilePhone_cg
             , change_tracking_is_column_in_mask ( COLUMNPROPERTY ( OBJECT_ID ( 'CMS_UserSettings') , 'HFitUserMpiNumber' , 'columnid') , CTE.sys_change_columns) AS HFitUserMpiNumber_cg
             , change_tracking_is_column_in_mask ( COLUMNPROPERTY ( OBJECT_ID ( 'CMS_UserSettings') , 'HFitUserPhoneExt' , 'columnid') , CTE.sys_change_columns) AS HFitUserPhoneExt_cg
             , change_tracking_is_column_in_mask ( COLUMNPROPERTY ( OBJECT_ID ( 'CMS_UserSettings') , 'HFitUserPhoneType' , 'columnid') , CTE.sys_change_columns) AS HFitUserPhoneType_cg
             , change_tracking_is_column_in_mask ( COLUMNPROPERTY ( OBJECT_ID ( 'CMS_UserSettings') , 'HFitUserPreferredCallTime' , 'columnid') , CTE.sys_change_columns) AS HFitUserPreferredCallTime_cg
             , change_tracking_is_column_in_mask ( COLUMNPROPERTY ( OBJECT_ID ( 'CMS_UserSettings') , 'HFitUserPreferredEmail' , 'columnid') , CTE.sys_change_columns) AS HFitUserPreferredEmail_cg
             , change_tracking_is_column_in_mask ( COLUMNPROPERTY ( OBJECT_ID ( 'CMS_UserSettings') , 'HFitUserPreferredFirstName' , 'columnid') , CTE.sys_change_columns) AS HFitUserPreferredFirstName_cg
             , change_tracking_is_column_in_mask ( COLUMNPROPERTY ( OBJECT_ID ( 'CMS_UserSettings') , 'HfitUserPreferredMailingAddress' , 'columnid') , CTE.sys_change_columns) AS HfitUserPreferredMailingAddress_cg
             , change_tracking_is_column_in_mask ( COLUMNPROPERTY ( OBJECT_ID ( 'CMS_UserSettings') , 'HFitUserPreferredMailingAddress2' , 'columnid') , CTE.sys_change_columns) AS HFitUserPreferredMailingAddress2_cg
             , change_tracking_is_column_in_mask ( COLUMNPROPERTY ( OBJECT_ID ( 'CMS_UserSettings') , 'HfitUserPreferredMailingCity' , 'columnid') , CTE.sys_change_columns) AS HfitUserPreferredMailingCity_cg
             , change_tracking_is_column_in_mask ( COLUMNPROPERTY ( OBJECT_ID ( 'CMS_UserSettings') , 'HfitUserPreferredMailingPostalCode' , 'columnid') , CTE.sys_change_columns) AS HfitUserPreferredMailingPostalCode_cg
             , change_tracking_is_column_in_mask ( COLUMNPROPERTY ( OBJECT_ID ( 'CMS_UserSettings') , 'HfitUserPreferredMailingState' , 'columnid') , CTE.sys_change_columns) AS HfitUserPreferredMailingState_cg
             , change_tracking_is_column_in_mask ( COLUMNPROPERTY ( OBJECT_ID ( 'CMS_UserSettings') , 'HFitUserPreferredPhone' , 'columnid') , CTE.sys_change_columns) AS HFitUserPreferredPhone_cg
             , change_tracking_is_column_in_mask ( COLUMNPROPERTY ( OBJECT_ID ( 'CMS_UserSettings') , 'HFitUserRegistrationDate' , 'columnid') , CTE.sys_change_columns) AS HFitUserRegistrationDate_cg
             , change_tracking_is_column_in_mask ( COLUMNPROPERTY ( OBJECT_ID ( 'CMS_UserSettings') , 'HfitUserSsoId' , 'columnid') , CTE.sys_change_columns) AS HfitUserSsoId_cg
             , change_tracking_is_column_in_mask ( COLUMNPROPERTY ( OBJECT_ID ( 'CMS_UserSettings') , 'HFitUserTypeID' , 'columnid') , CTE.sys_change_columns) AS HFitUserTypeID_cg
             , change_tracking_is_column_in_mask ( COLUMNPROPERTY ( OBJECT_ID ( 'CMS_UserSettings') , 'SocialSecurity' , 'columnid') , CTE.sys_change_columns) AS SocialSecurity_cg
             , change_tracking_is_column_in_mask ( COLUMNPROPERTY ( OBJECT_ID ( 'CMS_UserSettings') , 'UserAccountLockReason' , 'columnid') , CTE.sys_change_columns) AS UserAccountLockReason_cg
             , change_tracking_is_column_in_mask ( COLUMNPROPERTY ( OBJECT_ID ( 'CMS_UserSettings') , 'UserActivatedByUserID' , 'columnid') , CTE.sys_change_columns) AS UserActivatedByUserID_cg
             , change_tracking_is_column_in_mask ( COLUMNPROPERTY ( OBJECT_ID ( 'CMS_UserSettings') , 'UserActivationDate' , 'columnid') , CTE.sys_change_columns) AS UserActivationDate_cg
             , change_tracking_is_column_in_mask ( COLUMNPROPERTY ( OBJECT_ID ( 'CMS_UserSettings') , 'UserActivityPoints' , 'columnid') , CTE.sys_change_columns) AS UserActivityPoints_cg
             , change_tracking_is_column_in_mask ( COLUMNPROPERTY ( OBJECT_ID ( 'CMS_UserSettings') , 'UserAuthenticationGUID' , 'columnid') , CTE.sys_change_columns) AS UserAuthenticationGUID_cg
             , change_tracking_is_column_in_mask ( COLUMNPROPERTY ( OBJECT_ID ( 'CMS_UserSettings') , 'UserAvatarID' , 'columnid') , CTE.sys_change_columns) AS UserAvatarID_cg
             , change_tracking_is_column_in_mask ( COLUMNPROPERTY ( OBJECT_ID ( 'CMS_UserSettings') , 'UserAvatarType' , 'columnid') , CTE.sys_change_columns) AS UserAvatarType_cg
             , change_tracking_is_column_in_mask ( COLUMNPROPERTY ( OBJECT_ID ( 'CMS_UserSettings') , 'UserBadgeID' , 'columnid') , CTE.sys_change_columns) AS UserBadgeID_cg
             , change_tracking_is_column_in_mask ( COLUMNPROPERTY ( OBJECT_ID ( 'CMS_UserSettings') , 'UserBlogComments' , 'columnid') , CTE.sys_change_columns) AS UserBlogComments_cg
             , change_tracking_is_column_in_mask ( COLUMNPROPERTY ( OBJECT_ID ( 'CMS_UserSettings') , 'UserBlogPosts' , 'columnid') , CTE.sys_change_columns) AS UserBlogPosts_cg
             , change_tracking_is_column_in_mask ( COLUMNPROPERTY ( OBJECT_ID ( 'CMS_UserSettings') , 'UserBounces' , 'columnid') , CTE.sys_change_columns) AS UserBounces_cg
             , change_tracking_is_column_in_mask ( COLUMNPROPERTY ( OBJECT_ID ( 'CMS_UserSettings') , 'UserCampaign' , 'columnid') , CTE.sys_change_columns) AS UserCampaign_cg
             , change_tracking_is_column_in_mask ( COLUMNPROPERTY ( OBJECT_ID ( 'CMS_UserSettings') , 'UserCustomData' , 'columnid') , CTE.sys_change_columns) AS UserCustomData_cg
             , change_tracking_is_column_in_mask ( COLUMNPROPERTY ( OBJECT_ID ( 'CMS_UserSettings') , 'UserDashboardApplications' , 'columnid') , CTE.sys_change_columns) AS UserDashboardApplications_cg
             , change_tracking_is_column_in_mask ( COLUMNPROPERTY ( OBJECT_ID ( 'CMS_UserSettings') , 'UserDataComPassword' , 'columnid') , CTE.sys_change_columns) AS UserDataComPassword_cg
             , change_tracking_is_column_in_mask ( COLUMNPROPERTY ( OBJECT_ID ( 'CMS_UserSettings') , 'UserDataComUser' , 'columnid') , CTE.sys_change_columns) AS UserDataComUser_cg
             , change_tracking_is_column_in_mask ( COLUMNPROPERTY ( OBJECT_ID ( 'CMS_UserSettings') , 'UserDateOfBirth' , 'columnid') , CTE.sys_change_columns) AS UserDateOfBirth_cg
             , change_tracking_is_column_in_mask ( COLUMNPROPERTY ( OBJECT_ID ( 'CMS_UserSettings') , 'UserDescription' , 'columnid') , CTE.sys_change_columns) AS UserDescription_cg
             , change_tracking_is_column_in_mask ( COLUMNPROPERTY ( OBJECT_ID ( 'CMS_UserSettings') , 'UserDialogsConfiguration' , 'columnid') , CTE.sys_change_columns) AS UserDialogsConfiguration_cg
             , change_tracking_is_column_in_mask ( COLUMNPROPERTY ( OBJECT_ID ( 'CMS_UserSettings') , 'UserFacebookID' , 'columnid') , CTE.sys_change_columns) AS UserFacebookID_cg
             , change_tracking_is_column_in_mask ( COLUMNPROPERTY ( OBJECT_ID ( 'CMS_UserSettings') , 'UserForumPosts' , 'columnid') , CTE.sys_change_columns) AS UserForumPosts_cg
             , change_tracking_is_column_in_mask ( COLUMNPROPERTY ( OBJECT_ID ( 'CMS_UserSettings') , 'UserGender' , 'columnid') , CTE.sys_change_columns) AS UserGender_cg
             , change_tracking_is_column_in_mask ( COLUMNPROPERTY ( OBJECT_ID ( 'CMS_UserSettings') , 'UserIM' , 'columnid') , CTE.sys_change_columns) AS UserIM_cg
             , change_tracking_is_column_in_mask ( COLUMNPROPERTY ( OBJECT_ID ( 'CMS_UserSettings') , 'UserInvalidLogOnAttempts' , 'columnid') , CTE.sys_change_columns) AS UserInvalidLogOnAttempts_cg
             , change_tracking_is_column_in_mask ( COLUMNPROPERTY ( OBJECT_ID ( 'CMS_UserSettings') , 'UserInvalidLogOnAttemptsHash' , 'columnid') , CTE.sys_change_columns) AS UserInvalidLogOnAttemptsHash_cg
             , change_tracking_is_column_in_mask ( COLUMNPROPERTY ( OBJECT_ID ( 'CMS_UserSettings') , 'UserLinkedInID' , 'columnid') , CTE.sys_change_columns) AS UserLinkedInID_cg
             , change_tracking_is_column_in_mask ( COLUMNPROPERTY ( OBJECT_ID ( 'CMS_UserSettings') , 'UserLogActivities' , 'columnid') , CTE.sys_change_columns) AS UserLogActivities_cg
             , change_tracking_is_column_in_mask ( COLUMNPROPERTY ( OBJECT_ID ( 'CMS_UserSettings') , 'UserMessageBoardPosts' , 'columnid') , CTE.sys_change_columns) AS UserMessageBoardPosts_cg
             , change_tracking_is_column_in_mask ( COLUMNPROPERTY ( OBJECT_ID ( 'CMS_UserSettings') , 'UserMessagingNotificationEmail' , 'columnid') , CTE.sys_change_columns) AS UserMessagingNotificationEmail_cg
             , change_tracking_is_column_in_mask ( COLUMNPROPERTY ( OBJECT_ID ( 'CMS_UserSettings') , 'UserNickName' , 'columnid') , CTE.sys_change_columns) AS UserNickName_cg
             , change_tracking_is_column_in_mask ( COLUMNPROPERTY ( OBJECT_ID ( 'CMS_UserSettings') , 'UserPasswordLastChanged' , 'columnid') , CTE.sys_change_columns) AS UserPasswordLastChanged_cg
             , change_tracking_is_column_in_mask ( COLUMNPROPERTY ( OBJECT_ID ( 'CMS_UserSettings') , 'UserPasswordRequestHash' , 'columnid') , CTE.sys_change_columns) AS UserPasswordRequestHash_cg
             , change_tracking_is_column_in_mask ( COLUMNPROPERTY ( OBJECT_ID ( 'CMS_UserSettings') , 'UserPhone' , 'columnid') , CTE.sys_change_columns) AS UserPhone_cg
             , change_tracking_is_column_in_mask ( COLUMNPROPERTY ( OBJECT_ID ( 'CMS_UserSettings') , 'UserPicture' , 'columnid') , CTE.sys_change_columns) AS UserPicture_cg
             , change_tracking_is_column_in_mask ( COLUMNPROPERTY ( OBJECT_ID ( 'CMS_UserSettings') , 'UserPosition' , 'columnid') , CTE.sys_change_columns) AS UserPosition_cg
             , change_tracking_is_column_in_mask ( COLUMNPROPERTY ( OBJECT_ID ( 'CMS_UserSettings') , 'UserPreferences' , 'columnid') , CTE.sys_change_columns) AS UserPreferences_cg
             , change_tracking_is_column_in_mask ( COLUMNPROPERTY ( OBJECT_ID ( 'CMS_UserSettings') , 'UserRegistrationInfo' , 'columnid') , CTE.sys_change_columns) AS UserRegistrationInfo_cg
             , change_tracking_is_column_in_mask ( COLUMNPROPERTY ( OBJECT_ID ( 'CMS_UserSettings') , 'UserSecurityQuestionAnswer1' , 'columnid') , CTE.sys_change_columns) AS UserSecurityQuestionAnswer1_cg
             , change_tracking_is_column_in_mask ( COLUMNPROPERTY ( OBJECT_ID ( 'CMS_UserSettings') , 'UserSecurityQuestionAnswer2' , 'columnid') , CTE.sys_change_columns) AS UserSecurityQuestionAnswer2_cg
             , change_tracking_is_column_in_mask ( COLUMNPROPERTY ( OBJECT_ID ( 'CMS_UserSettings') , 'UserSecurityQuestionAnswer3' , 'columnid') , CTE.sys_change_columns) AS UserSecurityQuestionAnswer3_cg
             , change_tracking_is_column_in_mask ( COLUMNPROPERTY ( OBJECT_ID ( 'CMS_UserSettings') , 'UserSecurityQuestionGuid1' , 'columnid') , CTE.sys_change_columns) AS UserSecurityQuestionGuid1_cg
             , change_tracking_is_column_in_mask ( COLUMNPROPERTY ( OBJECT_ID ( 'CMS_UserSettings') , 'UserSecurityQuestionGuid2' , 'columnid') , CTE.sys_change_columns) AS UserSecurityQuestionGuid2_cg
             , change_tracking_is_column_in_mask ( COLUMNPROPERTY ( OBJECT_ID ( 'CMS_UserSettings') , 'UserSecurityQuestionGuid3' , 'columnid') , CTE.sys_change_columns) AS UserSecurityQuestionGuid3_cg
             , change_tracking_is_column_in_mask ( COLUMNPROPERTY ( OBJECT_ID ( 'CMS_UserSettings') , 'UserSettingsID' , 'columnid') , CTE.sys_change_columns) AS UserSettingsID_cg
             , change_tracking_is_column_in_mask ( COLUMNPROPERTY ( OBJECT_ID ( 'CMS_UserSettings') , 'UserSettingsUserGUID' , 'columnid') , CTE.sys_change_columns) AS UserSettingsUserGUID_cg
             , change_tracking_is_column_in_mask ( COLUMNPROPERTY ( OBJECT_ID ( 'CMS_UserSettings') , 'UserSettingsUserID' , 'columnid') , CTE.sys_change_columns) AS UserSettingsUserID_cg
             , change_tracking_is_column_in_mask ( COLUMNPROPERTY ( OBJECT_ID ( 'CMS_UserSettings') , 'UserShowIntroductionTile' , 'columnid') , CTE.sys_change_columns) AS UserShowIntroductionTile_cg
             , change_tracking_is_column_in_mask ( COLUMNPROPERTY ( OBJECT_ID ( 'CMS_UserSettings') , 'UserSignature' , 'columnid') , CTE.sys_change_columns) AS UserSignature_cg
             , change_tracking_is_column_in_mask ( COLUMNPROPERTY ( OBJECT_ID ( 'CMS_UserSettings') , 'UserSkype' , 'columnid') , CTE.sys_change_columns) AS UserSkype_cg
             , change_tracking_is_column_in_mask ( COLUMNPROPERTY ( OBJECT_ID ( 'CMS_UserSettings') , 'UserTimeZoneID' , 'columnid') , CTE.sys_change_columns) AS UserTimeZoneID_cg
             , change_tracking_is_column_in_mask ( COLUMNPROPERTY ( OBJECT_ID ( 'CMS_UserSettings') , 'UserURLReferrer' , 'columnid') , CTE.sys_change_columns) AS UserURLReferrer_cg
             , change_tracking_is_column_in_mask ( COLUMNPROPERTY ( OBJECT_ID ( 'CMS_UserSettings') , 'UserUsedWebParts' , 'columnid') , CTE.sys_change_columns) AS UserUsedWebParts_cg
             , change_tracking_is_column_in_mask ( COLUMNPROPERTY ( OBJECT_ID ( 'CMS_UserSettings') , 'UserUsedWidgets' , 'columnid') , CTE.sys_change_columns) AS UserUsedWidgets_cg
             , change_tracking_is_column_in_mask ( COLUMNPROPERTY ( OBJECT_ID ( 'CMS_UserSettings') , 'UserWaitingForApproval' , 'columnid') , CTE.sys_change_columns) AS UserWaitingForApproval_cg
             , change_tracking_is_column_in_mask ( COLUMNPROPERTY ( OBJECT_ID ( 'CMS_UserSettings') , 'WellnessGoalGuid' , 'columnid') , CTE.sys_change_columns) AS WellnessGoalGuid_cg
             , change_tracking_is_column_in_mask ( COLUMNPROPERTY ( OBJECT_ID ( 'CMS_UserSettings') , 'WindowsLiveID' , 'columnid') , CTE.sys_change_columns) AS WindowsLiveID_cg

        --********************************************    				  

               FROM
                   CTE
                       JOIN sys.dm_tran_commit_table AS tc
                           ON CTE.sys_change_version = tc.commit_ts;
END;
GO
PRINT 'Executed proc_CT_CMS_UserSettings_History.sql';
GO
--**************
print('END: ' + cast(getdate() as nvarchar(50)));
print('@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-');
print'***************************************************************' ;
print('START: ' + cast(getdate() as nvarchar(50)));
--**************

--SET ANSI_NULLS ON;
--SET ANSI_PADDING ON;
--SET ANSI_WARNINGS ON;
--SET ARITHABORT ON;
--SET CONCAT_NULL_YIELDS_NULL ON;
--SET NUMERIC_ROUNDABORT OFF;
--SET QUOTED_IDENTIFIER ON;





/*
select top 100 * from CMS_UserSettings
update CMS_UserSettings set UserNickNAme = null where UserSettingsID in (select top 100 UserSettingsID from CMS_UserSettings order by UserSettingsID desc) and UserNickName is null
*/

GO
-- use KenticoCMS_Prod1

/*---------------------------------------
Developer  : W. Dale Miller
05.28.2015 : WDM - completed unit testing
*/

GO
PRINT 'creating proc_STAGING_EDW_CMS_UserSettings';
PRINT GETDATE () ;
GO

IF EXISTS ( SELECT
                   name
                   FROM sys.procedures
                   WHERE name = 'proc_STAGING_EDW_CMS_UserSettings') 
    BEGIN
        PRINT 'UPDATING proc_STAGING_EDW_CMS_UserSettings';
        DROP PROCEDURE
             proc_STAGING_EDW_CMS_UserSettings;
    END;

GO

-- exec proc_STAGING_EDW_CMS_UserSettings

CREATE PROCEDURE proc_STAGING_EDW_CMS_UserSettings (
     @ReloadAll AS int = 0) 
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE
    @iTotal AS bigint = 0;

    EXEC @iTotal = proc_QuickRowCount 'STAGING_CMS_UserSettings';

    IF @iTotal <= 1
        BEGIN
            SET @Reloadall = 1;
        END;

    --******************************************************************************************************************************
    -- This procedure is added to the job job_EDW_GetStagingData_RewardUserDetail and set to run automatically on a schedule.
    --******************************************************************************************************************************

    BEGIN

        IF @ReloadAll IS NULL
            BEGIN
                SET @ReloadAll = 0;
            END;

        DECLARE
        @RecordID AS uniqueidentifier = NEWID () ;
        DECLARE
        @CT_DateTimeNow AS datetime = GETDATE () ;
        DECLARE
        @CT_NAME AS nvarchar ( 50) = 'proc_STAGING_EDW_CMS_UserSettings';
        EXEC proc_EDW_CT_ExecutionLog_Update @RecordID , @CT_NAME , @CT_DateTimeNow , 0 , 'I';

        IF @ReloadAll = 1
            BEGIN
                PRINT 'RELOADING ALL Change Tracking CMS_UserSettings records';
                EXEC proc_Create_Table_STAGING_CMS_UserSettings ;
                PRINT 'RELOAD COMPLETE';
            END;
        ELSE
            BEGIN
                EXEC proc_CT_CMS_UserSettings_AddNewRecs ;
                EXEC proc_CT_CMS_UserSettings_AddUpdatedRecs ;
                EXEC proc_CMS_UserSettings_AddDeletedRecs ;
            END;

    END;
END;

GO
PRINT 'CREATED proc_STAGING_EDW_CMS_UserSettings';
PRINT GETDATE () ;
GO--**************
print('END: ' + cast(getdate() as nvarchar(50)));
print('@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-');
print'***************************************************************' ;
print('START: ' + cast(getdate() as nvarchar(50)));
--**************

--SET ANSI_NULLS ON;
--SET ANSI_PADDING ON;
--SET ANSI_WARNINGS ON;
--SET ARITHABORT ON;
--SET CONCAT_NULL_YIELDS_NULL ON;
--SET NUMERIC_ROUNDABORT OFF;
--SET QUOTED_IDENTIFIER ON;




--**************
print('END: ' + cast(getdate() as nvarchar(50)));
print('@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-');
print'***************************************************************' ;
print('START: ' + cast(getdate() as nvarchar(50)));
--**************

--SET ANSI_NULLS ON;
--SET ANSI_PADDING ON;
--SET ANSI_WARNINGS ON;
--SET ARITHABORT ON;
--SET CONCAT_NULL_YIELDS_NULL ON;
--SET NUMERIC_ROUNDABORT OFF;
--SET QUOTED_IDENTIFIER ON;




--**************
print('END: ' + cast(getdate() as nvarchar(50)));
print('@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-');
print'***************************************************************' ;
print('START: ' + cast(getdate() as nvarchar(50)));
--**************

--SET ANSI_NULLS ON;
--SET ANSI_PADDING ON;
--SET ANSI_WARNINGS ON;
--SET ARITHABORT ON;
--SET CONCAT_NULL_YIELDS_NULL ON;
--SET NUMERIC_ROUNDABORT OFF;
--SET QUOTED_IDENTIFIER ON;






GO
PRINT 'Executing TRIG_CMS_UserSettings_Audit.SQL';
GO
-- select count(*) from STAGING_CMS_UserSettings_Audit
-- select * from STAGING_CMS_UserSettings_Audit
-- truncate table STAGING_CMS_UserSettings_Audit

IF EXISTS (SELECT
                  name
                  FROM sys.tables
                  WHERE name = 'STAGING_CMS_UserSettings_Audit') 
    BEGIN
        DROP TABLE
             STAGING_CMS_UserSettings_Audit;
    END;
GO

-- select * from [STAGING_CMS_UserSettings_Audit]
CREATE TABLE dbo.STAGING_CMS_UserSettings_Audit (
             UserSettingsID int NOT NULL
           ,SVR nvarchar (100) NOT NULL
           ,DBNAME nvarchar (100) NOT NULL
           ,SYS_CHANGE_VERSION int NULL
           ,SYS_CHANGE_OPERATION nvarchar (10) NULL
           ,SchemaName nvarchar (100) NULL
           ,SysUser nvarchar (100) NULL
           ,IPADDR nvarchar (50) NULL
           ,Processed int NULL
           ,TBL nvarchar (100) NULL
           ,CreateDate datetime NULL
	   ,commit_time datetime NULL
) 
ON [PRIMARY];

GO

ALTER TABLE dbo.STAGING_CMS_UserSettings_Audit
ADD
            CONSTRAINT DF_STAGING_CMS_UserSettings_Audit_CreateDate  DEFAULT GETDATE () FOR CreateDate;
GO

GO
CREATE CLUSTERED INDEX PK_CMS_UserSettings_Audit ON dbo.STAGING_CMS_UserSettings_Audit
(
UserSettingsID ASC,
SVR ASC,
SYS_CHANGE_VERSION ASC,
SYS_CHANGE_OPERATION ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];
GO

/*-------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TROUBLESHOOTING AND TESTING QRYS
	select count(*) from CMS_UserSettings where UserSettingsID = 53 and SiteID = 36
	INSERT INTO CMS_UserSettings (UserSettingsID, SiteID) VALUES (53, 36) ;
	delete from CMS_UserSettings where UserSettingsID = 53 and SiteID = 36
	select top 1000 * from CMS_UserSettings
	select top 1000 * from CMS_UserSettings
	update CMS_UserSettings set UserNickName = UserNickName where UserSettingsID in (Select top 100 UserSettingsID from CMS_UserSettings order by UserSettingsID )
	select * from STAGING_CMS_UserSettings_Audit
	truncate table  STAGING_CMS_UserSettings_Audit
*/

IF EXISTS (SELECT
                  name
                  FROM sys.triggers
                  WHERE name = 'trig_INS_CMS_UserSettings_Audit') 
    BEGIN
        DROP TRIGGER
             trig_INS_CMS_UserSettings_Audit;
    END;
GO

CREATE TRIGGER trig_INS_CMS_UserSettings_Audit ON CMS_UserSettings
    AFTER INSERT
AS
BEGIN

    DECLARE @svr nvarchar (100) = (SELECT
                                          @@SERVERNAME);
    DECLARE @db nvarchar (100) = (SELECT
                                         DB_NAME ());
    DECLARE @CHG_VER int = (SELECT
                                   MAX (CT.SYS_CHANGE_VERSION) 
                                   FROM CHANGETABLE (CHANGES CMS_UserSettings, NULL) AS CT);
    DECLARE @ipaddr nvarchar (50) = (SELECT
                                            CAST (CONNECTIONPROPERTY ('client_net_address') AS nvarchar (50)) );
    DECLARE @UserSettingsID nvarchar (50) = (SELECT
                                                    USER_NAME () );
    DECLARE @sysuser nvarchar (50) = (SELECT
                                             SYSTEM_USER);

    IF @CHG_VER IS NULL
        BEGIN
            SET @CHG_VER = 1;
        END;

    SET @CHG_VER = @CHG_VER - 1;
    DECLARE @Commit_Time datetime = (SELECT TOP 1
                                            tc.commit_time
                                            FROM
                                                CHANGETABLE (CHANGES CMS_UserSettings, @Chg_Ver) c
                                                    JOIN sys.dm_tran_commit_table AS tc
                                                        ON c.sys_change_version = tc.commit_ts);

    INSERT INTO STAGING_CMS_UserSettings_Audit
    (
           UserSettingsID
         , SVR
         , DBNAME
         , SYS_CHANGE_VERSION
         , SYS_CHANGE_OPERATION
         , SchemaName
         , SysUser
         , IPADDR
         , Processed
         , TBL
    , commit_time
    ) 
    SELECT
           UserSettingsID
         , @svr
         , @db
         , @CHG_VER
         , 'I'
         , @UserSettingsID
         , @sysuser
         , @ipaddr
         , 0 AS Processed
         , 'CMS_UserSettings'
     , @Commit_Time
           FROM Inserted;
END;

GO

IF EXISTS (SELECT
                  name
                  FROM sys.triggers
                  WHERE name = 'trig_UPDT_CMS_UserSettings_Audit') 
    BEGIN
        DROP TRIGGER
             trig_UPDT_CMS_UserSettings_Audit;
    END;
GO

CREATE TRIGGER trig_UPDT_CMS_UserSettings_Audit ON CMS_UserSettings
    AFTER UPDATE
AS
BEGIN

    DECLARE @svr nvarchar (100) = (SELECT
                                          @@SERVERNAME);
    DECLARE @db nvarchar (100) = (SELECT
                                         DB_NAME ());
    DECLARE @CHG_VER int = (SELECT
                                   MAX (CT.SYS_CHANGE_VERSION) 
                                   FROM CHANGETABLE (CHANGES CMS_UserSettings, NULL) AS CT);
    DECLARE @ipaddr nvarchar (50) = (SELECT
                                            CAST (CONNECTIONPROPERTY ('client_net_address') AS nvarchar (50)) );
    DECLARE @UserSettingsID nvarchar (50) = (SELECT
                                                    USER_NAME () );
    DECLARE @sysuser nvarchar (50) = (SELECT
                                             SYSTEM_USER);
    IF @CHG_VER IS NULL
        BEGIN
            SET @CHG_VER = 1;
        END;

    SET @CHG_VER = @CHG_VER - 1;
    DECLARE @Commit_Time datetime = (SELECT TOP 1
                                            tc.commit_time
                                            FROM
                                                CHANGETABLE (CHANGES CMS_UserSettings, @Chg_Ver) c
                                                    JOIN sys.dm_tran_commit_table AS tc
                                                        ON c.sys_change_version = tc.commit_ts);
    INSERT INTO STAGING_CMS_UserSettings_Audit
    (
           UserSettingsID
         , SVR
         , DBNAME
         , SYS_CHANGE_VERSION
         , SYS_CHANGE_OPERATION
         , SchemaName
         , SysUser
         , IPADDR
         , Processed
         , TBL, commit_time
    ) 
    SELECT
           UserSettingsID
         , @svr
         , @db
         , @CHG_VER
         , 'U'
         , @UserSettingsID
         , @sysuser
         , @ipaddr
         , 0 AS Processed
         , 'CMS_UserSettings' , @Commit_Time
           FROM Inserted;
END;

GO

IF EXISTS (SELECT
                  name
                  FROM sys.triggers
                  WHERE name = 'trig_DEL_CMS_UserSettings_Audit') 
    BEGIN
        DROP TRIGGER
             trig_DEL_CMS_UserSettings_Audit;
    END;
GO

CREATE TRIGGER trig_DEL_CMS_UserSettings_Audit ON CMS_UserSettings
    AFTER DELETE
AS
BEGIN

    DECLARE @svr nvarchar (100) = (SELECT
                                          @@SERVERNAME);
    DECLARE @db nvarchar (100) = (SELECT
                                         DB_NAME ());
    DECLARE @CHG_VER int = (SELECT
                                   MAX (CT.SYS_CHANGE_VERSION) 
                                   FROM CHANGETABLE (CHANGES CMS_UserSettings, NULL) AS CT);
    DECLARE @ipaddr nvarchar (50) = (SELECT
                                            CAST (CONNECTIONPROPERTY ('client_net_address') AS nvarchar (50)) );
    DECLARE @UserSettingsID nvarchar (50) = (SELECT
                                                    USER_NAME () );
    DECLARE @sysuser nvarchar (50) = (SELECT
                                             SYSTEM_USER);
    IF @CHG_VER IS NULL
        BEGIN
            SET @CHG_VER = 1;
        END;

    SET @CHG_VER = @CHG_VER - 1;
    DECLARE @Commit_Time datetime = (SELECT TOP 1
                                            tc.commit_time
                                            FROM
                                                CHANGETABLE (CHANGES CMS_UserSettings, @Chg_Ver) c
                                                    JOIN sys.dm_tran_commit_table AS tc
                                                        ON c.sys_change_version = tc.commit_ts);
    INSERT INTO STAGING_CMS_UserSettings_Audit
    (
           UserSettingsID
         , SVR
         , DBNAME
         , SYS_CHANGE_VERSION
         , SYS_CHANGE_OPERATION
         , SchemaName
         , SysUser
         , IPADDR
         , Processed
         , TBL , commit_time
    ) 
    SELECT
           UserSettingsID
         , @svr
         , @db
         , @CHG_VER
         , 'D'
         , @UserSettingsID
         , @sysuser
         , @ipaddr
         , 0 AS Processed
         , 'CMS_UserSettings' , @Commit_Time
           FROM DELETED;
END;

GO
PRINT 'EXECUTED TRIG_CMS_UserSettings_Audit.SQL';
GO
--**************
print('END: ' + cast(getdate() as nvarchar(50)));
print('@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-');
print'***************************************************************' ;
print('START: ' + cast(getdate() as nvarchar(50)));
--**************

--SET ANSI_NULLS ON;
--SET ANSI_PADDING ON;
--SET ANSI_WARNINGS ON;
--SET ARITHABORT ON;
--SET CONCAT_NULL_YIELDS_NULL ON;
--SET NUMERIC_ROUNDABORT OFF;
--SET QUOTED_IDENTIFIER ON;






GO
PRINT 'EXECUTING view_AUDIT_CMS_UserSettings.SQL';
GO

IF EXISTS (SELECT
                  name
                  FROM sys.views
                  WHERE name = 'view_AUDIT_CMS_UserSettings') 
    BEGIN
        DROP VIEW
             view_AUDIT_CMS_UserSettings
    END;

GO

/*---------------------------------------------------
select * from STAGING_CMS_UserSettings
select * from STAGING_CMS_UserSettings_Update_History
select * from STAGING_CMS_UserSettings_Audit
*/
-- select * from view_AUDIT_CMS_UserSettings order by UserSettingsID
CREATE VIEW view_AUDIT_CMS_UserSettings
AS 
    SELECT DISTINCT
          A.SysUser
        , A.IPADDR
        , A.CreateDate
        , A.SYS_CHANGE_OPERATION
        , A.SYS_CHANGE_VERSION AS SysChangeVersion
        , S.*
          FROM
              STAGING_CMS_UserSettings_Audit AS A
                  JOIN STAGING_CMS_UserSettings AS S
                      ON S.UserSettingsID = A.UserSettingsID;

GO
PRINT 'EXECUTED view_AUDIT_CMS_UserSettings.SQL';
GO
--**************
print('END: ' + cast(getdate() as nvarchar(50)));
print('@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-');
print'***************************************************************' ;
print('START: ' + cast(getdate() as nvarchar(50)));
--**************

--SET ANSI_NULLS ON;
--SET ANSI_PADDING ON;
--SET ANSI_WARNINGS ON;
--SET ARITHABORT ON;
--SET CONCAT_NULL_YIELDS_NULL ON;
--SET NUMERIC_ROUNDABORT OFF;
--SET QUOTED_IDENTIFIER ON;





GO
PRINT 'Creating JOB job_EDW_GetStagingData_CMS_UserSettings';
GO

BEGIN TRANSACTION;
DECLARE
@ReturnCode int;
SELECT
       @ReturnCode = 0;

IF NOT EXISTS ( SELECT
                       name
                       FROM msdb.dbo.syscategories
                       WHERE
                       name = N'[Uncategorized (Local)]'
                   AND category_class = 1) 
    BEGIN EXEC @ReturnCode = msdb.dbo.sp_add_category @class = N'JOB' , @type = N'LOCAL' , @name = N'[Uncategorized (Local)]';
        IF
        @@ERROR <> 0
     OR @ReturnCode <> 0
            BEGIN
                GOTO QuitWithRollback;
            END;

    END;

DECLARE
@TGTDB AS nvarchar ( 50) = DB_NAME () ;

DECLARE
@JNAME AS nvarchar ( 100) = 'job_EDW_GetStagingData_CMS_UserSettings_' + @TGTDB;

IF EXISTS ( SELECT
                   job_id
                   FROM msdb.dbo.sysjobs_view
                   WHERE name = @JNAME) 
    BEGIN EXEC msdb.dbo.sp_delete_job @job_name = @JNAME , @delete_unused_schedule = 1;
    END;

DECLARE
@jobId binary ( 16) ;
EXEC @ReturnCode = msdb.dbo.sp_add_job @job_name = @JNAME , @enabled = 1 , @notify_level_eventlog = 2 , @notify_level_email = 2 , @notify_level_netsend = 0 , @notify_level_page = 0 , @delete_level = 0 , @description = N'No description available.' , @category_name = N'[Uncategorized (Local)]' , @owner_login_name = N'sa' , @notify_email_operator_name = N'DBA_Notify' , @job_id = @jobId OUTPUT;
IF
@@ERROR <> 0
OR @ReturnCode <> 0
    BEGIN
        GOTO QuitWithRollback;
    END;

/*---------------------------------------------------------------------------------------
***** Object:  Step [Load_STAGING_EDW_CMS_UserSettings]    Script Date: 4/12/2015 9:59:37 AM *****
*/

EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id = @jobId , @step_name = N'Load_STAGING_EDW_CMS_UserSettings' , @step_id = 1 , @cmdexec_success_code = 0 , @on_success_action = 1 , @on_success_step_id = 0 , @on_fail_action = 2 , @on_fail_step_id = 0 , @retry_attempts = 0 , @retry_interval = 0 , @os_run_priority = 0 , @subsystem = N'TSQL' , @command = N'exec proc_STAGING_EDW_CMS_UserSettings;' , @database_name = @TGTDB , @flags = 0;
IF
@@ERROR <> 0
OR @ReturnCode <> 0
    BEGIN
        GOTO QuitWithRollback;
    END;
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId , @start_step_id = 1;
IF
@@ERROR <> 0
OR @ReturnCode <> 0
    BEGIN
        GOTO QuitWithRollback;
    END;
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id = @jobId , @name = N'Schedule_STAGING_EDW_CMS_UserSettings' , @enabled = 1 , @freq_type = 4 , @freq_interval = 1 , @freq_subday_type = 8 , @freq_subday_interval = 8 , @freq_relative_interval = 0 , @freq_recurrence_factor = 0 , @active_start_date = 20150412 , @active_end_date = 99991231 , @active_start_time = 10000 ,
@active_end_time = 235959;
--@schedule_uid = N'afcb6980-89fe-4a08-ad03-6598bd55454a';
IF
@@ERROR <> 0
OR @ReturnCode <> 0
    BEGIN
        GOTO QuitWithRollback;
    END;
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId , @server_name = N'(local)';
IF
@@ERROR <> 0
OR @ReturnCode <> 0
    BEGIN
        GOTO QuitWithRollback;
    END;
COMMIT TRANSACTION;
GOTO EndSave;
QuitWithRollback:
IF @@TRANCOUNT > 0
    BEGIN
        ROLLBACK TRANSACTION;
    END;
EndSave:

PRINT 'CREATED JOB ' + @JNAME;

GO



--**************
print('END: ' + cast(getdate() as nvarchar(50)));
print('@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-');
print'***************************************************************' ;
print('START: ' + cast(getdate() as nvarchar(50)));
--**************

--SET ANSI_NULLS ON;
--SET ANSI_PADDING ON;
--SET ANSI_WARNINGS ON;
--SET ARITHABORT ON;
--SET CONCAT_NULL_YIELDS_NULL ON;
--SET NUMERIC_ROUNDABORT OFF;
--SET QUOTED_IDENTIFIER ON;





/*------------------------
cms_user			    -> DONE
cms_usersettings	  -> DONE
CMS_UserSite	  -> DONE
hfit_ppteligibility
cms_usercontact
*/
GO
PRINT 'Executing create_table_STAGING_CMS_UserSite.sql';
GO

IF NOT EXISTS (SELECT
                      sys.tables.name AS Table_name
                      FROM
                          sys.change_tracking_tables
                              JOIN sys.tables
                                  ON sys.tables.object_id = sys.change_tracking_tables.object_id
                              JOIN sys.schemas
                                  ON sys.schemas.schema_id = sys.tables.schema_id
                      WHERE sys.tables.name = 'CMS_UserSite') 
    BEGIN
        PRINT 'ADDING Change Tracking to CMS_UserSite';
        ALTER TABLE dbo.CMS_UserSite
            ENABLE CHANGE_TRACKING
                WITH (TRACK_COLUMNS_UPDATED = ON) ;
    END;
ELSE
    BEGIN
        PRINT 'Change Tracking exists on CMS_UserSite';
    END;
GO

IF EXISTS (SELECT
                  name
                  FROM sys.procedures
                  WHERE name = 'proc_Create_Table_STAGING_CMS_UserSite') 
    BEGIN
        DROP PROCEDURE
             proc_Create_Table_STAGING_CMS_UserSite;
    END;
GO
-- exec proc_Create_Table_STAGING_CMS_UserSite
-- select top 100 * from [STAGING_CMS_UserSite]
CREATE PROCEDURE proc_Create_Table_STAGING_CMS_UserSite
AS
BEGIN

    IF EXISTS (SELECT
                      name
                      FROM sys.tables
                      WHERE name = 'STAGING_CMS_UserSite') 
        BEGIN
            DROP TABLE
                 dbo.STAGING_CMS_UserSite;
        END;

    SET ANSI_NULLS ON;
    SET QUOTED_IDENTIFIER ON;

    CREATE TABLE dbo.STAGING_CMS_UserSite (
                 UserSiteID int NOT NULL
               , UserID int NOT NULL
               , SiteID int NOT NULL
               , UserPreferredCurrencyID int NULL
               , UserPreferredShippingOptionID int NULL
               , UserPreferredPaymentOptionID int NULL

               , LastModifiedDate datetime NULL
               , RowNbr int NULL
               , DeletedFlg bit NULL
               , TimeZone nvarchar (10) NULL
               , ConvertedToCentralTime bit NULL
               , SVR nvarchar (100) NOT NULL
               , DBNAME nvarchar (100) NOT NULL
               , SYS_CHANGE_VERSION int NULL
    ) 
    ON [PRIMARY];

    ALTER TABLE dbo.STAGING_CMS_UserSite
    ADD
                DEFAULT @@servername FOR SVR;
    ALTER TABLE dbo.STAGING_CMS_UserSite
    ADD
                DEFAULT DB_NAME () FOR DBNAME;

    CREATE CLUSTERED INDEX PI_STAGING_CMS_UserSite ON dbo.STAGING_CMS_UserSite
    (
    UserSiteID ASC,
    SVR ASC,
    DBNAME ASC,
    SYS_CHANGE_VERSION ASC
    )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];

    --SET IDENTITY_INSERT STAGING_CMS_UserSite ON;

    INSERT INTO STAGING_CMS_UserSite
    (
           UserSiteID
         , UserID
         , SiteID
         , UserPreferredCurrencyID
         , UserPreferredShippingOptionID
         , UserPreferredPaymentOptionID) 
    SELECT
           UserSiteID
         , UserID
         , SiteID
         , UserPreferredCurrencyID
         , UserPreferredShippingOptionID
         , UserPreferredPaymentOptionID
           FROM CMS_UserSite;

    --SET IDENTITY_INSERT STAGING_CMS_UserSite OFF;

    IF EXISTS (SELECT
                      name
                      FROM sys.tables
                      WHERE name = 'STAGING_CMS_UserSite_Update_History') 
        BEGIN
            DROP TABLE
                 STAGING_CMS_UserSite_Update_History;
        END;

    -- select * from STAGING_CMS_UserSite_Update_History
   
CREATE TABLE [dbo].[STAGING_CMS_UserSite_Update_History](
	[UserSiteid] [int] NOT NULL,
	[SYS_CHANGE_VERSION] [bigint] NULL,
	[SYS_CHANGE_OPERATION] [nchar](1) NULL,
	[SYS_CHANGE_COLUMNS] [varbinary](4100) NULL,
	[CurrUser] [varchar](60) NOT NULL,
	[SysUser] [varchar](60) NOT NULL,
	[IPADDR] [varchar](60) NOT NULL,
	[commit_time] [datetime] NOT NULL,
	[LastModifiedDate] [datetime] NOT NULL,
	[SVR] [nvarchar](128) NULL,
	[DBNAME] [nvarchar](128) NULL,
	[UserSiteID_cg] [int] NULL,
	[UserID_cg] [int] NULL,
	[SiteID_cg] [int] NULL,
	[UserPreferredCurrencyID_cg] [int] NULL,
	[UserPreferredShippingOptionID_cg] [int] NULL,
	[UserPreferredPaymentOptionID_cg] [int] NULL
) ON [PRIMARY]

ALTER TABLE [dbo].[STAGING_CMS_UserSite_Update_History] ADD  CONSTRAINT [DF_STAGING_CMS_UserSite_Update_History_CurrUser]  DEFAULT (user_name()) FOR [CurrUser]
ALTER TABLE [dbo].[STAGING_CMS_UserSite_Update_History] ADD  CONSTRAINT [DF_STAGING_CMS_UserSite_Update_History_SysUser]  DEFAULT (suser_sname()) FOR [SysUser]
ALTER TABLE [dbo].[STAGING_CMS_UserSite_Update_History] ADD  CONSTRAINT [DF_STAGING_CMS_UserSite_Update_History_IPADDR]  DEFAULT (CONVERT([nvarchar](50),connectionproperty('client_net_address'))) FOR [IPADDR]


    CREATE CLUSTERED INDEX PI_STAGING_CMS_UserSite_Update_History ON dbo.STAGING_CMS_UserSite_Update_History
    (
    UserSiteID ASC,
    SVR ASC,
    SYS_CHANGE_VERSION ASC
    )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];


END;

GO
PRINT 'Executed create_table_STAGING_CMS_UserSite.sql';
GO
-- select * from STAGING_CMS_UserSite_Update_History
EXEC proc_Create_Table_STAGING_CMS_UserSite;
GO
--**************
print('END: ' + cast(getdate() as nvarchar(50)));
print('@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-');
print'***************************************************************' ;
print('START: ' + cast(getdate() as nvarchar(50)));
--**************

--SET ANSI_NULLS ON;
--SET ANSI_PADDING ON;
--SET ANSI_WARNINGS ON;
--SET ARITHABORT ON;
--SET CONCAT_NULL_YIELDS_NULL ON;
--SET NUMERIC_ROUNDABORT OFF;
--SET QUOTED_IDENTIFIER ON;





/*-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
select top 100 * from CMS_UserSite
update CMS_UserSite set UserNickNAme = null where UserSettingsID in (select top 100 UserSettingsID from CMS_UserSite order by UserSettingsID desc) and UserNickName is null
*/

GO
-- use KenticoCMS_Prod1

/*---------------------------------------
Developer  : W. Dale Miller
05.28.2015 : WDM - completed unit testing
*/

GO
PRINT 'creating proc_STAGING_EDW_CMS_UserSite';
PRINT GETDATE () ;
GO

IF EXISTS ( SELECT
                   name
                   FROM sys.procedures
                   WHERE name = 'proc_STAGING_EDW_CMS_UserSite') 
    BEGIN
        PRINT 'UPDATING proc_STAGING_EDW_CMS_UserSite';
        DROP PROCEDURE
             proc_STAGING_EDW_CMS_UserSite;
    END;

GO

-- exec proc_STAGING_EDW_CMS_UserSite

CREATE PROCEDURE proc_STAGING_EDW_CMS_UserSite (
     @ReloadAll AS int = 0) 
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE
    @iTotal AS bigint = 0;

    EXEC @iTotal = proc_QuickRowCount 'STAGING_CMS_UserSite';

    IF @iTotal <= 1
        BEGIN
            SET @Reloadall = 1;
        END;

    BEGIN

        IF @ReloadAll IS NULL
            BEGIN
                SET @ReloadAll = 0;
            END;

        DECLARE
        @RecordID AS uniqueidentifier = NEWID () ;
        DECLARE
        @CT_DateTimeNow AS datetime = GETDATE () ;
        DECLARE
        @CT_NAME AS nvarchar ( 50) = 'proc_STAGING_EDW_CMS_UserSite';
        EXEC proc_EDW_CT_ExecutionLog_Update @RecordID , @CT_NAME , @CT_DateTimeNow , 0 , 'I';

        IF @ReloadAll = 1
            BEGIN
                PRINT 'RELOADING ALL Change Tracking CMS_UserSite records';
                EXEC proc_Create_Table_STAGING_CMS_UserSite ;
                PRINT 'RELOAD COMPLETE';
            END;
        ELSE
            BEGIN
                EXEC proc_CT_CMS_UserSite_AddNewRecs ;
                EXEC proc_CT_CMS_UserSite_AddUpdatedRecs ;
                EXEC proc_CMS_UserSite_AddDeletedRecs ;
            END;

    END;
END;

GO
PRINT 'CREATED proc_STAGING_EDW_CMS_UserSite';
PRINT GETDATE () ;
GO--**************
print('END: ' + cast(getdate() as nvarchar(50)));
print('@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-');
print'***************************************************************' ;
print('START: ' + cast(getdate() as nvarchar(50)));
--**************

--SET ANSI_NULLS ON;
--SET ANSI_PADDING ON;
--SET ANSI_WARNINGS ON;
--SET ARITHABORT ON;
--SET CONCAT_NULL_YIELDS_NULL ON;
--SET NUMERIC_ROUNDABORT OFF;
--SET QUOTED_IDENTIFIER ON;





GO
PRINT 'Executing proc_CT_CMS_UserSite_History.sql';
GO
IF EXISTS (SELECT
                  name
                  FROM sys.procedures
                  WHERE name = 'proc_CT_CMS_UserSite_History') 
    BEGIN
        DROP PROCEDURE
             proc_CT_CMS_UserSite_History;
    END;
GO

/*-------------------------------------------------------------------------
*************************************************************************

select tc.commit_time, *
from
    changetable(changes CMS_UserSite, 0) c
    join sys.dm_tran_commit_table tc on c.sys_change_version = tc.commit_ts


exec proc_CT_CMS_UserSite_History 'I'
exec proc_CT_CMS_UserSite_History 'D'
exec proc_CT_CMS_UserSite_History 'U'

truncate table STAGING_CMS_UserSite_Update_History
select * from STAGING_CMS_UserSite_Update_History

SELECT CHANGE_TRACKING_MIN_VALID_VERSION(OBJECT_ID('CMS_UserSite'))

SELECT * FROM CHANGETABLE (CHANGES CMS_UserSite, NULL) AS CT WHERE SYS_CHANGE_OPERATION = 'U'
SELECT * FROM STAGING_CMS_UserSite_Update_History
*************************************************************************
*/


CREATE PROCEDURE proc_CT_CMS_UserSite_History (
     @Typesave AS nchar (1)) 
AS
BEGIN
    WITH CTE (
         UserSiteID
       , SYS_CHANGE_VERSION
       , SYS_CHANGE_COLUMNS) 
        AS (SELECT
                   CT.UserSiteID
                 , CT.SYS_CHANGE_VERSION
                 , SYS_CHANGE_COLUMNS
                   FROM CHANGETABLE (CHANGES CMS_UserSite, NULL) AS CT
                   WHERE SYS_CHANGE_OPERATION = @Typesave
            EXCEPT
            SELECT
                   UserSiteID
                 , SYS_CHANGE_VERSION
                 , SYS_CHANGE_COLUMNS
                   FROM STAGING_CMS_UserSite_Update_History) 
        INSERT INTO STAGING_CMS_UserSite_Update_History
        (
		  UserSiteid
		  , SYS_CHANGE_VERSION 
		  , SYS_CHANGE_OPERATION 
		  , SYS_CHANGE_COLUMNS 
		  --, CurrUser 
		  --, SysUser 
		  --, IPADDR 
		  , commit_time 
		  , LastModifiedDate 
		  , SVR 
		  , DBNAME 
		  , UserSiteID_cg 
		  , UserID_cg 
		  , SiteID_cg 
		  , UserPreferredCurrencyID_cg 
		  , UserPreferredShippingOptionID_cg 
		  , UserPreferredPaymentOptionID_cg ) 
        SELECT
               CTE.UserSiteID
             , CTE.SYS_CHANGE_VERSION
             , @Typesave as SYS_CHANGE_OPERATION
             , CTE.SYS_CHANGE_COLUMNS
             --, CurrUser
             --, SysUser
             --, IPADDR
             , tc.commit_time
             , GETDATE () AS LastModifiedDate
             , @@Servername AS SVR
             , DB_NAME () AS DBNAME
               --********************************************     
			 , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_UserSite') , 'SiteID', 'columnid') , CTE.sys_change_columns) AS [SiteID_cg] 
			 , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_UserSite') , 'UserID', 'columnid') , CTE.sys_change_columns) AS [UserID_cg] 
			 , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_UserSite') , 'UserPreferredCurrencyID', 'columnid') , CTE.sys_change_columns) AS [UserPreferredCurrencyID_cg] 
			 , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_UserSite') , 'UserPreferredPaymentOptionID', 'columnid') , CTE.sys_change_columns) AS [UserPreferredPaymentOptionID_cg] 
			 , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_UserSite') , 'UserPreferredShippingOptionID', 'columnid') , CTE.sys_change_columns) AS [UserPreferredShippingOptionID_cg] 
			 , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_UserSite') , 'UserSiteID', 'columnid') , CTE.sys_change_columns) AS [UserSiteID_cg] 

        --********************************************    				  
               FROM
                   CTE
                       JOIN sys.dm_tran_commit_table AS tc
                           ON CTE.sys_change_version = tc.commit_ts;

END;

GO
PRINT 'Executed proc_CT_CMS_UserSite_History.sql';
GO
--**************
print('END: ' + cast(getdate() as nvarchar(50)));
print('@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-');
print'***************************************************************' ;
print('START: ' + cast(getdate() as nvarchar(50)));
--**************

--SET ANSI_NULLS ON;
--SET ANSI_PADDING ON;
--SET ANSI_WARNINGS ON;
--SET ARITHABORT ON;
--SET CONCAT_NULL_YIELDS_NULL ON;
--SET NUMERIC_ROUNDABORT OFF;
--SET QUOTED_IDENTIFIER ON;






GO
PRINT 'Executing proc_CMS_UserSite_AddDeletedRecs.sql';
GO
IF EXISTS ( SELECT
                   name
                   FROM sys.procedures
                   WHERE name = 'proc_CMS_UserSite_AddDeletedRecs') 
    BEGIN
        DROP PROCEDURE
             proc_CMS_UserSite_AddDeletedRecs;
    END;
GO
CREATE PROCEDURE proc_CMS_UserSite_AddDeletedRecs
AS
BEGIN

    UPDATE STAGING_CMS_UserSite
           SET
               DeletedFlg = 1
             ,LastModifiedDate = GETDATE () 
    WHERE
          UserSiteID IN
          (SELECT
                  UserSiteID
                  FROM CHANGETABLE (CHANGES CMS_UserSite, NULL) AS CT
                  WHERE SYS_CHANGE_OPERATION = 'D') 
      AND DeletedFlg IS NULL;

    DECLARE
    @iCnt AS int = @@ROWCOUNT;
    PRINT 'Deleted Count: ' + CAST ( @iCnt AS nvarchar (50)) ;

    if @iCnt > 0
	   exec proc_CT_CMS_UserSite_History 'D' ;
    
    RETURN @iCnt;
END;

GO
PRINT 'Executed proc_CMS_UserSite_AddDeletedRecs.sql';
GO
--**************
print('END: ' + cast(getdate() as nvarchar(50)));
print('@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-');
print'***************************************************************' ;
print('START: ' + cast(getdate() as nvarchar(50)));
--**************

--SET ANSI_NULLS ON;
--SET ANSI_PADDING ON;
--SET ANSI_WARNINGS ON;
--SET ARITHABORT ON;
--SET CONCAT_NULL_YIELDS_NULL ON;
--SET NUMERIC_ROUNDABORT OFF;
--SET QUOTED_IDENTIFIER ON;





GO
-- USe KenticoCMS_Prod1

PRINT 'Executing proc_CT_CMS_UserSite_AddNewRecs.sql';
GO
IF EXISTS ( SELECT
                   name
                   FROM sys.procedures
                   WHERE name = 'proc_CT_CMS_UserSite_AddNewRecs') 
    BEGIN
        DROP PROCEDURE
             proc_CT_CMS_UserSite_AddNewRecs;
    END;
GO
-- exec proc_CT_CMS_UserSite_AddNewRecs
CREATE PROCEDURE proc_CT_CMS_UserSite_AddNewRecs
AS
BEGIN

    -- SET IDENTITY_INSERT STAGING_CMS_UserSite ON;
 
    WITH CTE (
         UserSiteID
       ) 
        AS ( SELECT
                    UserSiteID
                    FROM CMS_UserSite
             EXCEPT
             SELECT
                    UserSiteID
                    FROM STAGING_CMS_UserSite
                    WHERE DeletedFlg IS NULL) 
        INSERT INTO STAGING_CMS_UserSite
        (
               UserSiteID
             , UserID
             , SiteID
             , UserPreferredCurrencyID
             , UserPreferredShippingOptionID
             , UserPreferredPaymentOptionID

             , LastModifiedDate
               --,[RowNbr]
             , DeletedFlg
             , TimeZone
             , ConvertedToCentralTime
             , SVR
             , DBNAME
             , SYS_CHANGE_VERSION) 
        SELECT
               T.UserSiteID
             , T.UserID
             , T.SiteID
             , T.UserPreferredCurrencyID
             , T.UserPreferredShippingOptionID
             , T.UserPreferredPaymentOptionID

             , GETDATE () AS LastModifiedDate
             , NULL AS DeletedFlg
             , NULL AS TimeZone
             , NULL AS ConvertedToCentralTime
             , @@SERVERNAME AS SVR
             , DB_NAME () AS DBNAME
             , null as SYS_CHANGE_VERSION
               FROM
                   CMS_UserSite AS T
                       JOIN CTE AS S
                           ON S.UserSiteID = T.UserSiteID;
    DECLARE
    @iInserts AS int = @@ROWCOUNT;
    --SET IDENTITY_INSERT STAGING_CMS_UserSite OFF;
    PRINT 'NEW Insert Count: ' + CAST ( @iInserts AS nvarchar (50)) ;

    if @iInserts > 0
	   exec proc_CT_CMS_UserSite_History 'I';

    RETURN @iInserts;
END;

GO
PRINT 'Executed proc_CT_CMS_UserSite_AddNewRecs.sql';
GO
--**************
print('END: ' + cast(getdate() as nvarchar(50)));
print('@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-');
print'***************************************************************' ;
print('START: ' + cast(getdate() as nvarchar(50)));
--**************

--SET ANSI_NULLS ON;
--SET ANSI_PADDING ON;
--SET ANSI_WARNINGS ON;
--SET ARITHABORT ON;
--SET CONCAT_NULL_YIELDS_NULL ON;
--SET NUMERIC_ROUNDABORT OFF;
--SET QUOTED_IDENTIFIER ON;





GO
PRINT 'Executing proc_CT_CMS_UserSite_AddUpdatedRecs.sql';
GO
IF EXISTS ( SELECT
                   name
                   FROM sys.procedures
                   WHERE name = 'proc_CT_CMS_UserSite_AddUpdatedRecs') 
    BEGIN
        DROP PROCEDURE
             proc_CT_CMS_UserSite_AddUpdatedRecs;
    END;
GO
/*--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
select * from COM_Currency
select top 1000 * from CMS_UserSite

update CMS_UserSite set UserPreferredCurrencyID = NULL where UserSiteID in (select top 50 UserSiteID from CMS_UserSite order by UserSiteID ) and UserPreferredCurrencyID is null

 exec proc_CT_CMS_UserSite_AddUpdatedRecs
 select * from STAGING_CMS_UserSite where SYS_CHANGE_VERSION is not null
*/

CREATE PROCEDURE proc_CT_CMS_UserSite_AddUpdatedRecs
AS
BEGIN
    WITH CTE (
         UserSiteID
       , SYS_CHANGE_VERSION
       , SYS_CHANGE_OPERATION
       , SYS_CHANGE_COLUMNS) 
        AS ( SELECT
                    CT.UserSiteID
                  , CT.SYS_CHANGE_VERSION
                  , CT.SYS_CHANGE_OPERATION
                  , SYS_CHANGE_COLUMNS
                    FROM CHANGETABLE (CHANGES CMS_UserSite, NULL) AS CT
                    WHERE SYS_CHANGE_OPERATION = 'U') 
        UPDATE S
               SET
                   S.UserSiteID = T.UserSiteID
                 ,S.UserID = T.UserID
                 ,S.SiteID = T.SiteID
                 ,S.UserPreferredCurrencyID = T.UserPreferredCurrencyID
                 ,S.UserPreferredShippingOptionID = T.UserPreferredShippingOptionID
                 ,S.UserPreferredPaymentOptionID = T.UserPreferredPaymentOptionID

                 ,S.LastModifiedDate = GETDATE () 
                 ,S.DeletedFlg = NULL
                 ,S.ConvertedToCentralTime = NULL
                 ,S.SYS_CHANGE_VERSION = CTE.SYS_CHANGE_VERSION
                   FROM STAGING_CMS_UserSite AS S
                            JOIN
                            CMS_UserSite AS T
                                ON
                                S.UserSiteID = T.UserSiteID
                            AND S.DeletedFlg IS NULL
                            JOIN CTE
                                ON CTE.UserSiteID = T.UserSiteID
                               AND (CTE.SYS_CHANGE_VERSION != S.SYS_CHANGE_VERSION
                                 OR S.SYS_CHANGE_VERSION IS NULL);

    DECLARE
    @iCnt AS int = @@ROWCOUNT;
    PRINT 'Updated Count: ' + CAST ( @iCnt AS nvarchar (50)) ;

    exec proc_CT_CMS_UserSite_History 'U';

    --WITH CTE (
    --     UserSiteID
    --   , SYS_CHANGE_VERSION
    --   , SYS_CHANGE_COLUMNS) 
    --    AS ( SELECT
    --                CT.UserSiteID
    --              , CT.SYS_CHANGE_VERSION
    --              , SYS_CHANGE_COLUMNS
    --                FROM CHANGETABLE (CHANGES CMS_UserSite, NULL) AS CT
    --                WHERE SYS_CHANGE_OPERATION = 'U'
    --         EXCEPT
    --         SELECT
    --                UserSiteID
    --              , SYS_CHANGE_VERSION
    --              , SYS_CHANGE_COLUMNS
    --                FROM STAGING_CMS_UserSite_Update_History
    --    ) 
    --    INSERT INTO STAGING_CMS_UserSite_Update_History
    --    (
    --           UserSiteID
    --         , LastModifiedDate
    --         , SVR
    --         , DBNAME
    --         , SYS_CHANGE_VERSION
    --         , SYS_CHANGE_COLUMNS
    --         , commit_time) 
    --    SELECT
    --           CTE.UserSiteID
    --         , GETDATE () AS LastModifiedDate
    --         , @@SERVERNAME AS SVR
    --         , DB_NAME () AS DBNAME
    --         , CTE.SYS_CHANGE_VERSION
    --         , CTE.SYS_CHANGE_COLUMNS
    --         , tc.commit_time
    --           FROM
    --               CTE
    --                   JOIN sys.dm_tran_commit_table AS tc
    --                       ON CTE.sys_change_version = tc.commit_ts;

    RETURN @iCnt;
END;

GO
PRINT 'Executed proc_CT_CMS_UserSite_AddUpdatedRecs.sql';
GO
 --**************
print('END: ' + cast(getdate() as nvarchar(50)));
print('@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-');
print'***************************************************************' ;
print('START: ' + cast(getdate() as nvarchar(50)));
--**************

--SET ANSI_NULLS ON;
--SET ANSI_PADDING ON;
--SET ANSI_WARNINGS ON;
--SET ARITHABORT ON;
--SET CONCAT_NULL_YIELDS_NULL ON;
--SET NUMERIC_ROUNDABORT OFF;
--SET QUOTED_IDENTIFIER ON;





/*------------------------
cms_user			    -> DONE
cms_usersettings	  -> DONE
CMS_UserSite	  -> DONE
hfit_ppteligibility
cms_usercontact
*/
GO
PRINT 'Executing create_table_STAGING_CMS_UserSite.sql';
GO

IF NOT EXISTS (SELECT
                      sys.tables.name AS Table_name
                      FROM
                          sys.change_tracking_tables
                              JOIN sys.tables
                                  ON sys.tables.object_id = sys.change_tracking_tables.object_id
                              JOIN sys.schemas
                                  ON sys.schemas.schema_id = sys.tables.schema_id
                      WHERE sys.tables.name = 'CMS_UserSite') 
    BEGIN
        PRINT 'ADDING Change Tracking to CMS_UserSite';
        ALTER TABLE dbo.CMS_UserSite
            ENABLE CHANGE_TRACKING
                WITH (TRACK_COLUMNS_UPDATED = ON) ;
    END;
ELSE
    BEGIN
        PRINT 'Change Tracking exists on CMS_UserSite';
    END;
GO

IF EXISTS (SELECT
                  name
                  FROM sys.procedures
                  WHERE name = 'proc_Create_Table_STAGING_CMS_UserSite') 
    BEGIN
        DROP PROCEDURE
             proc_Create_Table_STAGING_CMS_UserSite;
    END;
GO
-- exec proc_Create_Table_STAGING_CMS_UserSite
-- select top 100 * from [STAGING_CMS_UserSite]
CREATE PROCEDURE proc_Create_Table_STAGING_CMS_UserSite
AS
BEGIN

    IF EXISTS (SELECT
                      name
                      FROM sys.tables
                      WHERE name = 'STAGING_CMS_UserSite') 
        BEGIN
            DROP TABLE
                 dbo.STAGING_CMS_UserSite;
        END;

    SET ANSI_NULLS ON;
    SET QUOTED_IDENTIFIER ON;

    CREATE TABLE dbo.STAGING_CMS_UserSite (
                 UserSiteID int NOT NULL
               , UserID int NOT NULL
               , SiteID int NOT NULL
               , UserPreferredCurrencyID int NULL
               , UserPreferredShippingOptionID int NULL
               , UserPreferredPaymentOptionID int NULL

               , LastModifiedDate datetime NULL
               , RowNbr int NULL
               , DeletedFlg bit NULL
               , TimeZone nvarchar (10) NULL
               , ConvertedToCentralTime bit NULL
               , SVR nvarchar (100) NOT NULL
               , DBNAME nvarchar (100) NOT NULL
               , SYS_CHANGE_VERSION int NULL
    ) 
    ON [PRIMARY];

    ALTER TABLE dbo.STAGING_CMS_UserSite
    ADD
                DEFAULT @@servername FOR SVR;
    ALTER TABLE dbo.STAGING_CMS_UserSite
    ADD
                DEFAULT DB_NAME () FOR DBNAME;

    CREATE CLUSTERED INDEX PI_STAGING_CMS_UserSite ON dbo.STAGING_CMS_UserSite
    (
    UserSiteID ASC,
    SVR ASC,
    DBNAME ASC,
    SYS_CHANGE_VERSION ASC
    )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];

    --SET IDENTITY_INSERT STAGING_CMS_UserSite ON;

    INSERT INTO STAGING_CMS_UserSite
    (
           UserSiteID
         , UserID
         , SiteID
         , UserPreferredCurrencyID
         , UserPreferredShippingOptionID
         , UserPreferredPaymentOptionID) 
    SELECT
           UserSiteID
         , UserID
         , SiteID
         , UserPreferredCurrencyID
         , UserPreferredShippingOptionID
         , UserPreferredPaymentOptionID
           FROM CMS_UserSite;

    --SET IDENTITY_INSERT STAGING_CMS_UserSite OFF;

    IF EXISTS (SELECT
                      name
                      FROM sys.tables
                      WHERE name = 'STAGING_CMS_UserSite_Update_History') 
        BEGIN
            DROP TABLE
                 STAGING_CMS_UserSite_Update_History;
        END;

    -- select * from STAGING_CMS_UserSite_Update_History
   
CREATE TABLE [dbo].[STAGING_CMS_UserSite_Update_History](
	[UserSiteid] [int] NOT NULL,
	[SYS_CHANGE_VERSION] [bigint] NULL,
	[SYS_CHANGE_OPERATION] [nchar](1) NULL,
	[SYS_CHANGE_COLUMNS] [varbinary](4100) NULL,
	[CurrUser] [varchar](60) NOT NULL,
	[SysUser] [varchar](60) NOT NULL,
	[IPADDR] [varchar](60) NOT NULL,
	[commit_time] [datetime] NOT NULL,
	[LastModifiedDate] [datetime] NOT NULL,
	[SVR] [nvarchar](128) NULL,
	[DBNAME] [nvarchar](128) NULL,
	[UserSiteID_cg] [int] NULL,
	[UserID_cg] [int] NULL,
	[SiteID_cg] [int] NULL,
	[UserPreferredCurrencyID_cg] [int] NULL,
	[UserPreferredShippingOptionID_cg] [int] NULL,
	[UserPreferredPaymentOptionID_cg] [int] NULL
) ON [PRIMARY]

ALTER TABLE [dbo].[STAGING_CMS_UserSite_Update_History] ADD  CONSTRAINT [DF_STAGING_CMS_UserSite_Update_History_CurrUser]  DEFAULT (user_name()) FOR [CurrUser]
ALTER TABLE [dbo].[STAGING_CMS_UserSite_Update_History] ADD  CONSTRAINT [DF_STAGING_CMS_UserSite_Update_History_SysUser]  DEFAULT (suser_sname()) FOR [SysUser]
ALTER TABLE [dbo].[STAGING_CMS_UserSite_Update_History] ADD  CONSTRAINT [DF_STAGING_CMS_UserSite_Update_History_IPADDR]  DEFAULT (CONVERT([nvarchar](50),connectionproperty('client_net_address'))) FOR [IPADDR]


    CREATE CLUSTERED INDEX PI_STAGING_CMS_UserSite_Update_History ON dbo.STAGING_CMS_UserSite_Update_History
    (
    UserSiteID ASC,
    SVR ASC,
    SYS_CHANGE_VERSION ASC
    )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];


END;

GO
PRINT 'Executed create_table_STAGING_CMS_UserSite.sql';
GO
-- select * from STAGING_CMS_UserSite_Update_History
EXEC proc_Create_Table_STAGING_CMS_UserSite;
GO
--**************
print('END: ' + cast(getdate() as nvarchar(50)));
print('@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-');
print'***************************************************************' ;
print('START: ' + cast(getdate() as nvarchar(50)));
--**************

--SET ANSI_NULLS ON;
--SET ANSI_PADDING ON;
--SET ANSI_WARNINGS ON;
--SET ARITHABORT ON;
--SET CONCAT_NULL_YIELDS_NULL ON;
--SET NUMERIC_ROUNDABORT OFF;
--SET QUOTED_IDENTIFIER ON;




--**************
print('END: ' + cast(getdate() as nvarchar(50)));
print('@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-');
print'***************************************************************' ;
print('START: ' + cast(getdate() as nvarchar(50)));
--**************

--SET ANSI_NULLS ON;
--SET ANSI_PADDING ON;
--SET ANSI_WARNINGS ON;
--SET ARITHABORT ON;
--SET CONCAT_NULL_YIELDS_NULL ON;
--SET NUMERIC_ROUNDABORT OFF;
--SET QUOTED_IDENTIFIER ON;




--**************
print('END: ' + cast(getdate() as nvarchar(50)));
print('@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-');
print'***************************************************************' ;
print('START: ' + cast(getdate() as nvarchar(50)));
--**************

--SET ANSI_NULLS ON;
--SET ANSI_PADDING ON;
--SET ANSI_WARNINGS ON;
--SET ARITHABORT ON;
--SET CONCAT_NULL_YIELDS_NULL ON;
--SET NUMERIC_ROUNDABORT OFF;
--SET QUOTED_IDENTIFIER ON;






GO
PRINT 'Executing TRIG_CMS_UserSite_Audit.SQL';
GO
-- select count(*) from STAGING_CMS_UserSite_Audit
-- select * from STAGING_CMS_UserSite_Audit
-- truncate table STAGING_CMS_UserSite_Audit

IF EXISTS (SELECT
                  name
                  FROM sys.tables
                  WHERE name = 'STAGING_CMS_UserSite_Audit') 
    BEGIN
        DROP TABLE
             STAGING_CMS_UserSite_Audit;
    END;
GO

CREATE TABLE dbo.STAGING_CMS_UserSite_Audit (
             UserSiteID int NOT NULL
           , SVR nvarchar (100) NOT NULL
           , DBNAME nvarchar (100) NOT NULL
           , SYS_CHANGE_VERSION int NULL
           , SYS_CHANGE_OPERATION nvarchar (10) NULL
           , SchemaName nvarchar (100) NULL
           , SysUser nvarchar (100) NULL
           , IPADDR  nvarchar (50) NULL
           , Processed integer NULL
           , TBL nvarchar (100) NULL
           , CreateDate datetime NULL
           , commit_time datetime NULL
);
GO
ALTER TABLE dbo.STAGING_CMS_UserSite_Audit
ADD
            CONSTRAINT DF_STAGING_CMS_UserSite_Audit_CreateDate  DEFAULT GETDATE () FOR CreateDate;
GO
CREATE CLUSTERED INDEX PK_CMS_UserSite_Audit ON dbo.STAGING_CMS_UserSite_Audit
(
    UserSiteID ASC,
    SVR ASC,
    SYS_CHANGE_VERSION ASC,
    SYS_CHANGE_OPERATION ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];

GO

/*---------------------------------------------------------------------------------------------------------------------------------
-- TROUBLESHOOTING AND TESTING QRYS
	select count(*) from CMS_UserSite where UserID = 53 and SiteID = 36
	INSERT INTO CMS_UserSite (UserID, SiteID) VALUES (53, 36) ;
	delete from CMS_UserSite where UserID = 13593 and SiteID = 9
	select top 1000 * from CMS_User
	select top 1000 * from CMS_UserSite
	update CMS_UserSite set SiteID = SiteID where UserSiteID in (Select top 100 UserSiteID from CMS_UserSite order by UserSiteID desc)
	select * from STAGING_CMS_UserSite_Audit
	truncate table  STAGING_CMS_UserSite_Audit
*/

IF EXISTS (SELECT
                  name
                  FROM sys.triggers
                  WHERE name = 'trig_INS_CMS_UserSite_Audit') 
    BEGIN
        DROP TRIGGER
             trig_INS_CMS_UserSite_Audit;
    END;
GO

CREATE TRIGGER trig_INS_CMS_UserSite_Audit ON CMS_UserSite
    AFTER INSERT
AS
BEGIN

    DECLARE @svr nvarchar (100) = (SELECT
                                          @@SERVERNAME);
    DECLARE @db nvarchar (100) = (SELECT
                                         DB_NAME ());
    DECLARE @CHG_VER int = (SELECT
                                   MAX (CT.SYS_CHANGE_VERSION) 
                                   FROM CHANGETABLE (CHANGES CMS_UserSite, NULL) AS CT);
    DECLARE @ipaddr nvarchar (50) = (SELECT
                                            CAST (CONNECTIONPROPERTY ('client_net_address') AS nvarchar (50)) );
    DECLARE @userid nvarchar (50) = (SELECT
                                            USER_NAME () );
    DECLARE @sysuser nvarchar (50) = (SELECT
                                             SYSTEM_USER);

    SET @CHG_VER = @CHG_VER - 1;
    DECLARE @Commit_Time datetime = (SELECT TOP 1
                                            tc.commit_time
                                            FROM
                                                CHANGETABLE (CHANGES CMS_User, @Chg_Ver) c
                                                    JOIN sys.dm_tran_commit_table AS tc
                                                        ON c.sys_change_version = tc.commit_ts);

    INSERT INTO STAGING_CMS_UserSite_Audit
    (
           UserSiteID
         , SVR
         , DBNAME
         , SYS_CHANGE_VERSION
         , SYS_CHANGE_OPERATION
         , SchemaName
         , SysUser
         , IPADDR
         , Processed
         , TBL
         , commit_time
    ) 
    SELECT
           UserSiteID
         , @svr
         , @db
         , @CHG_VER
         , 'I'
         , @userid
         , @sysuser
         , @ipaddr
         , 0 AS Processed
         , 'CMS_UserSite'
         , @Commit_Time
           FROM Inserted;
END;

GO

IF EXISTS (SELECT
                  name
                  FROM sys.triggers
                  WHERE name = 'trig_UPDT_CMS_UserSite_Audit') 
    BEGIN
        DROP TRIGGER
             trig_UPDT_CMS_UserSite_Audit;
    END;
GO

CREATE TRIGGER trig_UPDT_CMS_UserSite_Audit ON CMS_UserSite
    AFTER UPDATE
AS
BEGIN

    DECLARE @svr nvarchar (100) = (SELECT
                                          @@SERVERNAME);
    DECLARE @db nvarchar (100) = (SELECT
                                         DB_NAME ());
    DECLARE @CHG_VER int = (SELECT
                                   MAX (CT.SYS_CHANGE_VERSION) 
                                   FROM CHANGETABLE (CHANGES CMS_UserSite, NULL) AS CT);
    DECLARE @ipaddr nvarchar (50) = (SELECT
                                            CAST (CONNECTIONPROPERTY ('client_net_address') AS nvarchar (50)) );
    DECLARE @userid nvarchar (50) = (SELECT
                                            USER_NAME () );
    DECLARE @sysuser nvarchar (50) = (SELECT
                                             SYSTEM_USER);
    SET @CHG_VER = @CHG_VER - 1;
    DECLARE @Commit_Time datetime = (SELECT TOP 1
                                            tc.commit_time
                                            FROM
                                                CHANGETABLE (CHANGES CMS_User, @Chg_Ver) c
                                                    JOIN sys.dm_tran_commit_table AS tc
                                                        ON c.sys_change_version = tc.commit_ts);
    INSERT INTO STAGING_CMS_UserSite_Audit
    (
           UserSiteID
         , SVR
         , DBNAME
         , SYS_CHANGE_VERSION
         , SYS_CHANGE_OPERATION
         , SchemaName
         , SysUser
         , IPADDR
         , Processed
         , TBL
         , commit_time
    ) 
    SELECT
           UserSiteID
         , @svr
         , @db
         , @CHG_VER
         , 'U'
         , @userid
         , @sysuser
         , @ipaddr
         , 0 AS Processed
         , 'CMS_UserSite'
         , @Commit_Time
           FROM Inserted;
END;

GO

IF EXISTS (SELECT
                  name
                  FROM sys.triggers
                  WHERE name = 'trig_DEL_CMS_UserSite_Audit') 
    BEGIN
        DROP TRIGGER
             trig_DEL_CMS_UserSite_Audit;
    END;
GO

CREATE TRIGGER trig_DEL_CMS_UserSite_Audit ON CMS_UserSite
    AFTER DELETE
AS
BEGIN

    DECLARE @svr nvarchar (100) = (SELECT
                                          @@SERVERNAME);
    DECLARE @db nvarchar (100) = (SELECT
                                         DB_NAME ());
    DECLARE @CHG_VER int = (SELECT
                                   MAX (CT.SYS_CHANGE_VERSION) 
                                   FROM CHANGETABLE (CHANGES CMS_UserSite, NULL) AS CT);
    DECLARE @ipaddr nvarchar (50) = (SELECT
                                            CAST (CONNECTIONPROPERTY ('client_net_address') AS nvarchar (50)) );
    DECLARE @userid nvarchar (50) = (SELECT
                                            USER_NAME () );
    DECLARE @sysuser nvarchar (50) = (SELECT
                                             SYSTEM_USER);
    SET @CHG_VER = @CHG_VER - 1;
    DECLARE @Commit_Time datetime = (SELECT TOP 1
                                            tc.commit_time
                                            FROM
                                                CHANGETABLE (CHANGES CMS_User, @Chg_Ver) c
                                                    JOIN sys.dm_tran_commit_table AS tc
                                                        ON c.sys_change_version = tc.commit_ts);
    INSERT INTO STAGING_CMS_UserSite_Audit
    (
           UserSiteID
         , SVR
         , DBNAME
         , SYS_CHANGE_VERSION
         , SYS_CHANGE_OPERATION
         , SchemaName
         , SysUser
         , IPADDR
         , Processed
         , TBL
         , commit_time
    ) 
    SELECT
           UserSiteID
         , @svr
         , @db
         , @CHG_VER
         , 'D'
         , @userid
         , @sysuser
         , @ipaddr
         , 0 AS Processed
         , 'CMS_UserSite'
         , @Commit_Time
           FROM DELETED;
END;

GO
PRINT 'EXECUTED _TriggerToUpdateAuditRecordForCT.SQL';
GO
--**************
print('END: ' + cast(getdate() as nvarchar(50)));
print('@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-');
print'***************************************************************' ;
print('START: ' + cast(getdate() as nvarchar(50)));
--**************

--SET ANSI_NULLS ON;
--SET ANSI_PADDING ON;
--SET ANSI_WARNINGS ON;
--SET ARITHABORT ON;
--SET CONCAT_NULL_YIELDS_NULL ON;
--SET NUMERIC_ROUNDABORT OFF;
--SET QUOTED_IDENTIFIER ON;






go
print 'Executing view_AUDIT_CMS_UserSite.sql'
go
if exists (select name from sys.views where name = 'view_AUDIT_CMS_UserSite')
    drop view view_AUDIT_CMS_UserSite;

go

/*---------------------------------------------------
select * from STAGING_CMS_UserSite
select * from STAGING_CMS_UserSite_Update_History
select * from STAGING_CMS_UserSite_Audit
*/
-- select * from view_AUDIT_CMS_UserSite order by UserSiteID
/*
HOW TO USE:
    select * from view_AUDIT_CMS_UserSite order by UserSiteID
	   where CreateDate between '2015-09-18 14:55:33.000' and '2015-09-18 14:55:34'

    select * from view_AUDIT_CMS_UserSite
	   where SysUser = 'dmiller'
*/

CREATE VIEW view_AUDIT_CMS_UserSite
AS 
SELECT distinct
          A.SysUser
        , A.IPADDR
        , A.CreateDate
        , A.SYS_CHANGE_OPERATION
        , A.SYS_CHANGE_VERSION as SysChangeVersion
        , S.*
          FROM
		  STAGING_CMS_UserSite_Audit	as A
		  join STAGING_CMS_UserSite AS S
                      ON S.UserSiteID = A.UserSiteID ;
go
print 'Executed view_AUDIT_CMS_UserSite.sql'
go
--**************
print('END: ' + cast(getdate() as nvarchar(50)));
print('@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-');
print'***************************************************************' ;
print('START: ' + cast(getdate() as nvarchar(50)));
--**************

--SET ANSI_NULLS ON;
--SET ANSI_PADDING ON;
--SET ANSI_WARNINGS ON;
--SET ARITHABORT ON;
--SET CONCAT_NULL_YIELDS_NULL ON;
--SET NUMERIC_ROUNDABORT OFF;
--SET QUOTED_IDENTIFIER ON;





GO
PRINT 'Creating JOB Create_job_EDW_GetStagingData_CMS_UserSite';
GO

BEGIN TRANSACTION;
DECLARE
@ReturnCode int;
SELECT
       @ReturnCode = 0;

IF NOT EXISTS ( SELECT
                       name
                       FROM msdb.dbo.syscategories
                       WHERE
                       name = N'[Uncategorized (Local)]'
                   AND category_class = 1) 
    BEGIN EXEC @ReturnCode = msdb.dbo.sp_add_category @class = N'JOB' , @type = N'LOCAL' , @name = N'[Uncategorized (Local)]';
        IF
        @@ERROR <> 0
     OR @ReturnCode <> 0
            BEGIN
                GOTO QuitWithRollback;
            END;

    END;

DECLARE
@TGTDB AS nvarchar ( 50) = DB_NAME () ;

DECLARE
@JNAME AS nvarchar ( 100) = 'job_EDW_GetStagingData_CMS_UserSite_' + @TGTDB;

IF EXISTS ( SELECT
                   job_id
                   FROM msdb.dbo.sysjobs_view
                   WHERE name = @JNAME) 
    BEGIN EXEC msdb.dbo.sp_delete_job @job_name = @JNAME , @delete_unused_schedule = 1;
    END;

DECLARE
@jobId binary ( 16) ;
EXEC @ReturnCode = msdb.dbo.sp_add_job @job_name = @JNAME , @enabled = 1 , @notify_level_eventlog = 2 , @notify_level_email = 2 , @notify_level_netsend = 0 , @notify_level_page = 0 , @delete_level = 0 , @description = N'No description available.' , @category_name = N'[Uncategorized (Local)]' , @owner_login_name = N'sa' , @notify_email_operator_name = N'DBA_Notify' , @job_id = @jobId OUTPUT;
IF
@@ERROR <> 0
OR @ReturnCode <> 0
    BEGIN
        GOTO QuitWithRollback;
    END;

/*--------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
***** Object:  Step [Load_STAGING_EDW_CMS_UserSite]    Script Date: 4/12/2015 9:59:37 AM *****
*/

EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id = @jobId , @step_name = N'Load_STAGING_EDW_CMS_UserSite' , @step_id = 1 , @cmdexec_success_code = 0 , @on_success_action = 1 , @on_success_step_id = 0 , @on_fail_action = 2 , @on_fail_step_id = 0 , @retry_attempts = 0 , @retry_interval = 0 , @os_run_priority = 0 , @subsystem = N'TSQL' , @command = N'exec proc_STAGING_EDW_CMS_UserSite;' , @database_name = @TGTDB , @flags = 0;
IF
@@ERROR <> 0
OR @ReturnCode <> 0
    BEGIN
        GOTO QuitWithRollback;
    END;
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId , @start_step_id = 1;
IF
@@ERROR <> 0
OR @ReturnCode <> 0
    BEGIN
        GOTO QuitWithRollback;
    END;
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id = @jobId , @name = N'Schedule_STAGING_EDW_CMS_UserSite' , @enabled = 1 , @freq_type = 4 , @freq_interval = 1 , @freq_subday_type = 8 , @freq_subday_interval = 8 , @freq_relative_interval = 0 , @freq_recurrence_factor = 0 , @active_start_date = 20150412 , @active_end_date = 99991231 , @active_start_time = 10000 ,
@active_end_time = 235959;
--@schedule_uid = N'afcb6980-89fe-4a08-ad03-6598bd55454a';
IF
@@ERROR <> 0
OR @ReturnCode <> 0
    BEGIN
        GOTO QuitWithRollback;
    END;
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId , @server_name = N'(local)';
IF
@@ERROR <> 0
OR @ReturnCode <> 0
    BEGIN
        GOTO QuitWithRollback;
    END;
COMMIT TRANSACTION;
GOTO EndSave;
QuitWithRollback:
IF @@TRANCOUNT > 0
    BEGIN
        ROLLBACK TRANSACTION;
    END;
EndSave:

PRINT 'CREATED JOB ' + @JNAME;

GO



--**************
print('END: ' + cast(getdate() as nvarchar(50)));
print('@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-');
print'***************************************************************' ;
print('START: ' + cast(getdate() as nvarchar(50)));
--**************

--SET ANSI_NULLS ON;
--SET ANSI_PADDING ON;
--SET ANSI_WARNINGS ON;
--SET ARITHABORT ON;
--SET CONCAT_NULL_YIELDS_NULL ON;
--SET NUMERIC_ROUNDABORT OFF;
--SET QUOTED_IDENTIFIER ON;





GO
PRINT 'Executing proc_CT_getPrevVer.sql';
GO

IF EXISTS (SELECT
				  name
				  FROM sys.procedures
				  WHERE name = 'proc_CT_getPrevVer') 
	BEGIN
		DROP PROCEDURE
			 proc_CT_getPrevVer
	END;

GO
-- exec proc_CT_getPrevVer "hfit_PPtEligibility"
CREATE PROCEDURE proc_CT_getPrevVer (
	   @Tblname nvarchar (100)) 
AS
	 BEGIN
		 DECLARE @Ct TABLE (
						   ver bigint) ;
		 INSERT INTO @Ct
		 SELECT DISTINCT TOP 2
				CT.SYS_CHANGE_VERSION
				FROM CHANGETABLE (CHANGES HFIT_PPTEligibility, NULL) AS CT
				ORDER BY
						 CT.SYS_CHANGE_VERSION DESC;

		 DECLARE @Tgtver bigint = (SELECT TOP 1
										  ver
										  FROM @Ct
										  ORDER BY
												   ver) ;

		 RETURN @Tgtver;
	 END;

GO
PRINT 'Executed proc_CT_getPrevVer.sql';
GO--**************
print('END: ' + cast(getdate() as nvarchar(50)));
print('@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-');
print'***************************************************************' ;
print('START: ' + cast(getdate() as nvarchar(50)));
--**************

--SET ANSI_NULLS ON;
--SET ANSI_PADDING ON;
--SET ANSI_WARNINGS ON;
--SET ARITHABORT ON;
--SET CONCAT_NULL_YIELDS_NULL ON;
--SET NUMERIC_ROUNDABORT OFF;
--SET QUOTED_IDENTIFIER ON;





go
print 'Executing udf_CT_GetCommitTime.sql'
go

IF OBJECT_ID (N'dbo.udf_CT_GetCommitTime', N'FN') IS NOT NULL
	BEGIN
		DROP FUNCTION
			 udf_CT_GetCommitTime
	END;
GO
CREATE FUNCTION dbo.udf_CT_GetCommitTime (
				@Verno bigint) 
RETURNS datetime
AS
	 BEGIN
		 DECLARE @Dt datetime;
		 SET @Dt = (SELECT
						   tc.commit_time
						   FROM
								CHANGETABLE (CHANGES HFIT_PPTEligibility, 0) c
									JOIN sys.dm_tran_commit_table AS tc
										ON c.sys_change_version = tc.commit_ts) ;

		 RETURN @Dt;
	 END;
GO

print 'Executed udf_CT_GetCommitTime.sql'
go
--**************
print('END: ' + cast(getdate() as nvarchar(50)));
print('@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-');
print'***************************************************************' ;
print('START: ' + cast(getdate() as nvarchar(50)));
--**************

--SET ANSI_NULLS ON;
--SET ANSI_PADDING ON;
--SET ANSI_WARNINGS ON;
--SET ARITHABORT ON;
--SET CONCAT_NULL_YIELDS_NULL ON;
--SET NUMERIC_ROUNDABORT OFF;
--SET QUOTED_IDENTIFIER ON;




-- USE KenticoCMS_PRD_1

/*************************
------------------------
cms_user			    -> DONE
cms_usersettings	  -> DONE
CMS_UserSite	  -> DONE
HFIT_PPTEligibility
cms_usercontact
*************************/
GO
PRINT 'Executing create_table_STAGING_HFIT_PPTEligibility.sql';
GO

IF EXISTS (SELECT
                  name
                  FROM sys.tables
                  WHERE name = 'STAGING_HFIT_PPTEligibility_Audit') 
    BEGIN
        DROP TABLE
             STAGING_HFIT_PPTEligibility_Audit;
    END;
GO

CREATE TABLE dbo.STAGING_HFIT_PPTEligibility_Audit (
             PPTID int NOT NULL
           , SVR nvarchar (100) NOT NULL
           , DBNAME nvarchar (100) NOT NULL
           , SYS_CHANGE_VERSION int NULL
           , SYS_CHANGE_OPERATION nvarchar (10) NULL
           , SchemaName nvarchar (100) NULL
           , SysUser nvarchar (100) NULL
           , IPADDR nvarchar (50) NULL
           , Processed integer NULL
           , TBL nvarchar (100) NULL
           , CreateDate datetime NULL
           , commit_time datetime NULL) ;
GO
ALTER TABLE dbo.STAGING_HFIT_PPTEligibility_Audit
ADD
            CONSTRAINT DF_STAGING_HFIT_PPTEligibility_Audit_CreateDate DEFAULT GETDATE () FOR CreateDate;
GO

CREATE CLUSTERED INDEX PK_HFIT_PPTEligibility_Audit ON dbo.STAGING_HFIT_PPTEligibility_Audit (PPTID ASC, SVR ASC, SYS_CHANGE_VERSION ASC, SYS_CHANGE_OPERATION ASC) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];

GO

IF NOT EXISTS (SELECT
					  sys.tables.name AS Table_name
					  FROM
						   sys.change_tracking_tables
							   JOIN sys.tables
								   ON sys.tables.object_id = sys.change_tracking_tables.object_id
							   JOIN sys.schemas
								   ON sys.schemas.schema_id = sys.tables.schema_id
					  WHERE sys.tables.name = 'HFIT_PPTEligibility') 
	BEGIN
		PRINT 'ADDING Change Tracking to HFIT_PPTEligibility';
		ALTER TABLE dbo.HFIT_PPTEligibility ENABLE CHANGE_TRACKING
				WITH (TRACK_COLUMNS_UPDATED = ON) ;
	END;
ELSE
	BEGIN
		PRINT 'Change Tracking exists on HFIT_PPTEligibility';
	END;
GO
IF EXISTS (SELECT
				  name
				  FROM sys.procedures
				  WHERE name = 'proc_Create_Table_STAGING_HFIT_PPTEligibility') 
	BEGIN
		DROP PROCEDURE
			 proc_Create_Table_STAGING_HFIT_PPTEligibility;
	END;
GO
-- exec proc_Create_Table_STAGING_HFIT_PPTEligibility
-- select top 100 * from [STAGING_HFIT_PPTEligibility]
CREATE PROCEDURE proc_Create_Table_STAGING_HFIT_PPTEligibility
AS
	 BEGIN

		 IF EXISTS (SELECT
						   name
						   FROM sys.tables
						   WHERE name = 'STAGING_HFIT_PPTEligibility') 
			 BEGIN
				 DROP TABLE
					  dbo.STAGING_HFIT_PPTEligibility;
			 END;

		 SET ANSI_NULLS ON;
		 SET QUOTED_IDENTIFIER ON;

		 CREATE TABLE dbo.STAGING_HFIT_PPTEligibility (
					  PPTID int NOT NULL
					, ClientID varchar (27) NULL
					, ClientCode varchar (12) NULL
					, UserID int NULL
					, IDCard nvarchar (25) NULL
					, FirstName varchar (50) NOT NULL
					, LastName varchar (50) NOT NULL
					, MiddleInit varchar (2) NULL
					, BirthDate datetime2 (7) NULL
					, Gender nvarchar (1) NULL
					, AddressLine1 varchar (50) NULL
					, AddressLine2 varchar (50) NULL
					, City varchar (30) NULL
					, State varchar (2) NULL
					, PostalCode varchar (10) NULL
					, HomePhoneNum varchar (12) NULL
					, WorkPhoneNum varchar (12) NULL
					, MobilePhoneNum varchar (12) NULL
					, EmailAddress varchar (50) NULL
					, MPI varchar (50) NOT NULL
					, MatchMethodCode nvarchar (25) NULL
					, SSN varchar (11) NULL
					, PrimarySSN varchar (11) NULL
					, HireDate datetime2 (7) NULL
					, TermDate datetime2 (7) NULL
					, RetireeDate datetime2 (7) NULL
					, PlanName varchar (50) NULL
					, PlanDescription varchar (50) NULL
					, PlanID varchar (25) NULL
					, PlanStartDate datetime2 (7) NULL
					, PlanEndDate datetime2 (7) NULL
					, Company varchar (50) NULL
					, CompanyCd varchar (20) NULL
					, LocationName varchar (50) NULL
					, LocationCd varchar (20) NULL
					, DepartmentName varchar (50) NULL
					, DepartmentCd varchar (20) NULL
					, UnionCd varchar (30) NULL
					, BenefitGrp varchar (20) NULL
					, PayGrp varchar (20) NULL
					, Division varchar (30) NULL
					, JobTitle varchar (50) NULL
					, JobCd varchar (20) NULL
					, TeamName varchar (30) NULL
					, MaritalStatus varchar (30) NULL
					, PersonType varchar (30) NULL
					, PersonStatus varchar (30) NULL
					, EmployeeType varchar (30) NULL
					, CoverageType varchar (30) NULL
					, EmployeeStatus varchar (30) NULL
					, PayCd varchar (30) NULL
					, BenefitStatus varchar (30) NULL
					, PlanType varchar (20) NULL
					, ClientPlatformElig bit NULL
					, ClientHRAElig bit NULL
					, ClientLMElig bit NULL
					, ClientIncentiveElig bit NULL
					, ClientCMElig bit NULL
					, ClientScreeningElig bit NULL
					, Custom1 varchar (50) NULL
					, Custom2 varchar (50) NULL
					, Custom3 varchar (50) NULL
					, Custom4 varchar (50) NULL
					, Custom5 varchar (50) NULL
					, Custom6 varchar (50) NULL
					, Custom7 varchar (50) NULL
					, Custom8 varchar (50) NULL
					, Custom9 varchar (50) NULL
					, Custom10 varchar (50) NULL
					, Custom11 varchar (50) NULL
					, Custom12 varchar (50) NULL
					, Custom13 varchar (50) NULL
					, Custom14 varchar (50) NULL
					, Custom15 varchar (50) NULL
					, ChangeStatusFlag nvarchar (1) NULL
					, Last_Update_Dt datetime2 (7) NULL
					, FlatFileName nvarchar (500) NULL
					, ItemGUID uniqueidentifier NOT NULL
					, Hashbyte_Checksum varchar (32) NULL
					, Primary_MPI nvarchar (50) NULL
					, MPI_Relationship_Type varchar (50) NULL
					, WorkInd bit NULL
					, LastModifiedDate datetime NULL
					, RowNbr int NULL
					, DeletedFlg bit NULL
					, TimeZone nvarchar (10) NULL
					, ConvertedToCentralTime bit NULL
					, SVR nvarchar (100) NOT NULL
					, DBNAME nvarchar (100) NOT NULL
					, SYS_CHANGE_VERSION int NULL) 
		 ON [PRIMARY];

		 ALTER TABLE dbo.STAGING_HFIT_PPTEligibility
		 ADD
					 DEFAULT @@Servername FOR SVR;
		 ALTER TABLE dbo.STAGING_HFIT_PPTEligibility
		 ADD
					 DEFAULT DB_NAME () FOR DBNAME;

		 CREATE CLUSTERED INDEX PI_STAGING_HFIT_PPTEligibility ON dbo.STAGING_HFIT_PPTEligibility (PPTID ASC, SVR ASC, DBNAME ASC, SYS_CHANGE_VERSION ASC) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];

		 --SET IDENTITY_INSERT STAGING_HFIT_PPTEligibility ON;

		 INSERT INTO STAGING_HFIT_PPTEligibility (
					 PPTID
				   , ClientID
				   , ClientCode
				   , UserID
				   , IDCard
				   , FirstName
				   , LastName
				   , MiddleInit
				   , BirthDate
				   , Gender
				   , AddressLine1
				   , AddressLine2
				   , City
				   , State
				   , PostalCode
				   , HomePhoneNum
				   , WorkPhoneNum
				   , MobilePhoneNum
				   , EmailAddress
				   , MPI
				   , MatchMethodCode
				   , SSN
				   , PrimarySSN
				   , HireDate
				   , TermDate
				   , RetireeDate
				   , PlanName
				   , PlanDescription
				   , PlanID
				   , PlanStartDate
				   , PlanEndDate
				   , Company
				   , CompanyCd
				   , LocationName
				   , LocationCd
				   , DepartmentName
				   , DepartmentCd
				   , UnionCd
				   , BenefitGrp
				   , PayGrp
				   , Division
				   , JobTitle
				   , JobCd
				   , TeamName
				   , MaritalStatus
				   , PersonType
				   , PersonStatus
				   , EmployeeType
				   , CoverageType
				   , EmployeeStatus
				   , PayCd
				   , BenefitStatus
				   , PlanType
				   , ClientPlatformElig
				   , ClientHRAElig
				   , ClientLMElig
				   , ClientIncentiveElig
				   , ClientCMElig
				   , ClientScreeningElig
				   , Custom1
				   , Custom2
				   , Custom3
				   , Custom4
				   , Custom5
				   , Custom6
				   , Custom7
				   , Custom8
				   , Custom9
				   , Custom10
				   , Custom11
				   , Custom12
				   , Custom13
				   , Custom14
				   , Custom15
				   , ChangeStatusFlag
				   , Last_Update_Dt
				   , FlatFileName
				   , ItemGUID
				   , Hashbyte_Checksum
				   , Primary_MPI
				   , MPI_Relationship_Type
				   , WorkInd) 
		 SELECT
				PPTID
			  , ClientID
			  , ClientCode
			  , UserID
			  , IDCard
			  , FirstName
			  , LastName
			  , MiddleInit
			  , BirthDate
			  , Gender
			  , AddressLine1
			  , AddressLine2
			  , City
			  , State
			  , PostalCode
			  , HomePhoneNum
			  , WorkPhoneNum
			  , MobilePhoneNum
			  , EmailAddress
			  , MPI
			  , MatchMethodCode
			  , SSN
			  , PrimarySSN
			  , HireDate
			  , TermDate
			  , RetireeDate
			  , PlanName
			  , PlanDescription
			  , PlanID
			  , PlanStartDate
			  , PlanEndDate
			  , Company
			  , CompanyCd
			  , LocationName
			  , LocationCd
			  , DepartmentName
			  , DepartmentCd
			  , UnionCd
			  , BenefitGrp
			  , PayGrp
			  , Division
			  , JobTitle
			  , JobCd
			  , TeamName
			  , MaritalStatus
			  , PersonType
			  , PersonStatus
			  , EmployeeType
			  , CoverageType
			  , EmployeeStatus
			  , PayCd
			  , BenefitStatus
			  , PlanType
			  , ClientPlatformElig
			  , ClientHRAElig
			  , ClientLMElig
			  , ClientIncentiveElig
			  , ClientCMElig
			  , ClientScreeningElig
			  , Custom1
			  , Custom2
			  , Custom3
			  , Custom4
			  , Custom5
			  , Custom6
			  , Custom7
			  , Custom8
			  , Custom9
			  , Custom10
			  , Custom11
			  , Custom12
			  , Custom13
			  , Custom14
			  , Custom15
			  , ChangeStatusFlag
			  , Last_Update_Dt
			  , FlatFileName
			  , ItemGUID
			  , Hashbyte_Checksum
			  , Primary_MPI
			  , MPI_Relationship_Type
			  , WorkInd
				FROM HFIT_PPTEligibility;

		 --SET IDENTITY_INSERT STAGING_HFIT_PPTEligibility OFF;

		 IF EXISTS (SELECT
						   name
						   FROM sys.tables
						   WHERE name = 'STAGING_HFIT_PPTEligibility_Update_History') 
			 BEGIN
				 PRINT 'dropping and recreating STAGING_HFIT_PPTEligibility_Update_History';
				 DROP TABLE
					  STAGING_HFIT_PPTEligibility_Update_History;
			 END;

		 CREATE TABLE dbo.STAGING_HFIT_PPTEligibility_Update_History (
					  PPTID int NOT NULL
					, AddressLine1_cg int NULL
					, AddressLine2_cg int NULL
					, BenefitGrp_cg int NULL
					, BenefitStatus_cg int NULL
					, BirthDate_cg int NULL
					, ChangeStatusFlag_cg int NULL
					, City_cg int NULL
					, ClientCMElig_cg int NULL
					, ClientCode_cg int NULL
					, ClientHRAElig_cg int NULL
					, ClientID_cg int NULL
					, ClientIncentiveElig_cg int NULL
					, ClientLMElig_cg int NULL
					, ClientPlatformElig_cg int NULL
					, ClientScreeningElig_cg int NULL
					, Company_cg int NULL
					, CompanyCd_cg int NULL
					, CoverageType_cg int NULL
					, Custom1_cg int NULL
					, Custom10_cg int NULL
					, Custom11_cg int NULL
					, Custom12_cg int NULL
					, Custom13_cg int NULL
					, Custom14_cg int NULL
					, Custom15_cg int NULL
					, Custom2_cg int NULL
					, Custom3_cg int NULL
					, Custom4_cg int NULL
					, Custom5_cg int NULL
					, Custom6_cg int NULL
					, Custom7_cg int NULL
					, Custom8_cg int NULL
					, Custom9_cg int NULL
					, DepartmentCd_cg int NULL
					, DepartmentName_cg int NULL
					, Division_cg int NULL
					, EmailAddress_cg int NULL
					, EmployeeStatus_cg int NULL
					, EmployeeType_cg int NULL
					, FirstName_cg int NULL
					, FlatFileName_cg int NULL
					, Gender_cg int NULL
					, Hashbyte_Checksum_cg int NULL
					, HireDate_cg int NULL
					, HomePhoneNum_cg int NULL
					, IDCard_cg int NULL
					, ItemGUID_cg int NULL
					, JobCd_cg int NULL
					, JobTitle_cg int NULL
					, Last_Update_Dt_cg int NULL
					, LastName_cg int NULL
					, LocationCd_cg int NULL
					, LocationName_cg int NULL
					, MaritalStatus_cg int NULL
					, MatchMethodCode_cg int NULL
					, MiddleInit_cg int NULL
					, MobilePhoneNum_cg int NULL
					, MPI_cg int NULL
					, MPI_Relationship_Type_cg int NULL
					, PayCd_cg int NULL
					, PayGrp_cg int NULL
					, PersonStatus_cg int NULL
					, PersonType_cg int NULL
					, PlanDescription_cg int NULL
					, PlanEndDate_cg int NULL
					, PlanID_cg int NULL
					, PlanName_cg int NULL
					, PlanStartDate_cg int NULL
					, PlanType_cg int NULL
					, PostalCode_cg int NULL
					, PPTID_cg int NULL
					, Primary_MPI_cg int NULL
					, PrimarySSN_cg int NULL
					, RetireeDate_cg int NULL
					, SSN_cg int NULL
					, State_cg int NULL
					, TeamName_cg int NULL
					, TermDate_cg int NULL
					, UnionCd_cg int NULL
					, UserID_cg int NULL
					, WorkInd_cg int NULL
					, WorkPhoneNum_cg int NULL
					, LastModifiedDate datetime DEFAULT GETDATE () 
					, SVR nvarchar (100) NOT NULL
										 DEFAULT @@Servername
					, DBNAME nvarchar (100) NOT NULL
											DEFAULT DB_NAME () 
					, SYS_CHANGE_VERSION int NULL
					, SYS_CHANGE_COLUMNS varbinary (4000) NULL
					, SYS_CHANGE_OPERATION nchar (1) NULL
					, CurrUser nvarchar (100) NULL
											  CONSTRAINT DF_STAGING_HFIT_PPTEligibility_Update_History_CurrUser DEFAULT USER_NAME () 
					, SysUser nvarchar (100) NULL
											 CONSTRAINT DF_STAGING_HFIT_PPTEligibility_Update_History_SysUser DEFAULT SUSER_SNAME () 
					, IPADDR nvarchar (50) NULL
										   CONSTRAINT DF_STAGING_HFIT_PPTEligibility_Update_History_IPADDR DEFAULT CAST (CONNECTIONPROPERTY ('client_net_address') AS nvarchar (50))
					,commit_time datetime)
		 ON [PRIMARY];

		 CREATE CLUSTERED INDEX PI_STAGING_HFIT_PPTEligibility_Update_History ON dbo.STAGING_HFIT_PPTEligibility_Update_History (PPTID ASC, SVR ASC, SYS_CHANGE_VERSION ASC) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];

	 -- select * from STAGING_HFIT_PPTEligibility_Update_History
	 --ALTER TABLE dbo.STAGING_HFIT_PPTEligibility_Update_History
	 --ADD
	 --            DEFAULT @@servername FOR SVR;
	 --ALTER TABLE dbo.STAGING_HFIT_PPTEligibility_Update_History
	 --ADD
	 --            DEFAULT DB_NAME () FOR DBNAME;

	 END;

GO
PRINT 'Executed create_table_STAGING_HFIT_PPTEligibility.sql';
GO
EXEC proc_Create_Table_STAGING_HFIT_PPTEligibility;
GO
--SELECT * FROM STAGING_HFIT_PPTEligibility_Update_History;
--**************
print('END: ' + cast(getdate() as nvarchar(50)));
print('@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-');
print'***************************************************************' ;
print('START: ' + cast(getdate() as nvarchar(50)));
--**************

--SET ANSI_NULLS ON;
--SET ANSI_PADDING ON;
--SET ANSI_WARNINGS ON;
--SET ARITHABORT ON;
--SET CONCAT_NULL_YIELDS_NULL ON;
--SET NUMERIC_ROUNDABORT OFF;
--SET QUOTED_IDENTIFIER ON;





-- use KenticoCMS_PRD_1
GO
PRINT 'Executing proc_HFIT_PPTEligibility_AddDeletedRecs.sql';
GO
IF EXISTS ( SELECT
                   name
                   FROM sys.procedures
                   WHERE name = 'proc_HFIT_PPTEligibility_AddDeletedRecs') 
    BEGIN
        DROP PROCEDURE
             proc_HFIT_PPTEligibility_AddDeletedRecs;
    END;
GO
-- delete from HFIT_PPTEligibility where PPTID = 1 
-- EXEC proc_HFIT_PPTEligibility_AddDeletedRecs
CREATE PROCEDURE proc_HFIT_PPTEligibility_AddDeletedRecs
AS
BEGIN

    UPDATE STAGING_HFIT_PPTEligibility
           SET
               DeletedFlg = 1
             ,LastModifiedDate = GETDATE () 
    WHERE
          PPTID IN
          (SELECT
                  PPTID
                  FROM CHANGETABLE (CHANGES HFIT_PPTEligibility, NULL) AS CT
                  WHERE SYS_CHANGE_OPERATION = 'D') 
      AND DeletedFlg IS NULL;

    DECLARE
    @iCnt AS int = @@ROWCOUNT;
    PRINT 'Deleted Count: ' + CAST ( @iCnt AS nvarchar (50)) ;

	exec proc_CT_HFIT_PPTEligibility_History 'D' ;

    RETURN @iCnt;
END;

GO
PRINT 'Executed proc_HFIT_PPTEligibility_AddDeletedRecs.sql';
GO
--**************
print('END: ' + cast(getdate() as nvarchar(50)));
print('@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-');
print'***************************************************************' ;
print('START: ' + cast(getdate() as nvarchar(50)));
--**************

--SET ANSI_NULLS ON;
--SET ANSI_PADDING ON;
--SET ANSI_WARNINGS ON;
--SET ARITHABORT ON;
--SET CONCAT_NULL_YIELDS_NULL ON;
--SET NUMERIC_ROUNDABORT OFF;
--SET QUOTED_IDENTIFIER ON;





GO
-- use KenticoCMS_PRD_1

PRINT 'Executing proc_CT_HFIT_PPTEligibility_AddNewRecs.sql';
GO
IF EXISTS (SELECT
                  name
                  FROM sys.procedures
                  WHERE name = 'proc_CT_HFIT_PPTEligibility_AddNewRecs') 
    BEGIN
        DROP PROCEDURE
             proc_CT_HFIT_PPTEligibility_AddNewRecs;
    END;
GO
-- exec proc_CT_HFIT_PPTEligibility_AddNewRecs
CREATE PROCEDURE proc_CT_HFIT_PPTEligibility_AddNewRecs
AS
BEGIN

    --SET IDENTITY_INSERT STAGING_HFIT_PPTEligibility ON;

    WITH CTE (
         PPTID) 
        AS (SELECT
                   PPTID
                   FROM HFIT_PPTEligibility
            EXCEPT
            SELECT
                   PPTID
                   FROM STAGING_HFIT_PPTEligibility
                   WHERE DeletedFlg IS NULL) 
        INSERT INTO STAGING_HFIT_PPTEligibility (
               PPTID
             , ClientID
             , ClientCode
             , UserID
             , IDCard
             , FirstName
             , LastName
             , MiddleInit
             , BirthDate
             , Gender
             , AddressLine1
             , AddressLine2
             , City
             , State
             , PostalCode
             , HomePhoneNum
             , WorkPhoneNum
             , MobilePhoneNum
             , EmailAddress
             , MPI
             , MatchMethodCode
             , SSN
             , PrimarySSN
             , HireDate
             , TermDate
             , RetireeDate
             , PlanName
             , PlanDescription
             , PlanID
             , PlanStartDate
             , PlanEndDate
             , Company
             , CompanyCd
             , LocationName
             , LocationCd
             , DepartmentName
             , DepartmentCd
             , UnionCd
             , BenefitGrp
             , PayGrp
             , Division
             , JobTitle
             , JobCd
             , TeamName
             , MaritalStatus
             , PersonType
             , PersonStatus
             , EmployeeType
             , CoverageType
             , EmployeeStatus
             , PayCd
             , BenefitStatus
             , PlanType
             , ClientPlatformElig
             , ClientHRAElig
             , ClientLMElig
             , ClientIncentiveElig
             , ClientCMElig
             , ClientScreeningElig
             , Custom1
             , Custom2
             , Custom3
             , Custom4
             , Custom5
             , Custom6
             , Custom7
             , Custom8
             , Custom9
             , Custom10
             , Custom11
             , Custom12
             , Custom13
             , Custom14
             , Custom15
             , ChangeStatusFlag
             , Last_Update_Dt
             , FlatFileName
             , ItemGUID
             , Hashbyte_Checksum
             , Primary_MPI
             , MPI_Relationship_Type
             , WorkInd
             , LastModifiedDate
               --,[RowNbr]
             , DeletedFlg
             , TimeZone
             , ConvertedToCentralTime
             , SVR
             , DBNAME
             , SYS_CHANGE_VERSION) 
        SELECT
               T.PPTID
             , T.ClientID
             , T.ClientCode
             , T.UserID
             , T.IDCard
             , T.FirstName
             , T.LastName
             , T.MiddleInit
             , T.BirthDate
             , T.Gender
             , T.AddressLine1
             , T.AddressLine2
             , T.City
             , T.State
             , T.PostalCode
             , T.HomePhoneNum
             , T.WorkPhoneNum
             , T.MobilePhoneNum
             , T.EmailAddress
             , T.MPI
             , T.MatchMethodCode
             , T.SSN
             , T.PrimarySSN
             , T.HireDate
             , T.TermDate
             , T.RetireeDate
             , T.PlanName
             , T.PlanDescription
             , T.PlanID
             , T.PlanStartDate
             , T.PlanEndDate
             , T.Company
             , T.CompanyCd
             , T.LocationName
             , T.LocationCd
             , T.DepartmentName
             , T.DepartmentCd
             , T.UnionCd
             , T.BenefitGrp
             , T.PayGrp
             , T.Division
             , T.JobTitle
             , T.JobCd
             , T.TeamName
             , T.MaritalStatus
             , T.PersonType
             , T.PersonStatus
             , T.EmployeeType
             , T.CoverageType
             , T.EmployeeStatus
             , T.PayCd
             , T.BenefitStatus
             , T.PlanType
             , T.ClientPlatformElig
             , T.ClientHRAElig
             , T.ClientLMElig
             , T.ClientIncentiveElig
             , T.ClientCMElig
             , T.ClientScreeningElig
             , T.Custom1
             , T.Custom2
             , T.Custom3
             , T.Custom4
             , T.Custom5
             , T.Custom6
             , T.Custom7
             , T.Custom8
             , T.Custom9
             , T.Custom10
             , T.Custom11
             , T.Custom12
             , T.Custom13
             , T.Custom14
             , T.Custom15
             , T.ChangeStatusFlag
             , T.Last_Update_Dt
             , T.FlatFileName
             , T.ItemGUID
             , T.Hashbyte_Checksum
             , T.Primary_MPI
             , T.MPI_Relationship_Type
             , T.WorkInd
             , GETDATE () AS LastModifiedDate
             , NULL AS DeletedFlg
             , NULL AS TimeZone
             , NULL AS ConvertedToCentralTime
             , @@SERVERNAME AS SVR
             , DB_NAME () AS DBNAME
             , NULL AS SYS_CHANGE_VERSION
               FROM
                   HFIT_PPTEligibility AS T
                       JOIN CTE AS S
                           ON S.PPTID = T.PPTID;
    DECLARE @iInserts AS int = @@ROWCOUNT;
    --SET IDENTITY_INSERT STAGING_HFIT_PPTEligibility OFF;
    PRINT 'NEW Insert Count: ' + CAST (@iInserts AS nvarchar (50)) ;
    EXEC proc_CT_HFIT_PPTEligibility_History 'I';

    RETURN @iInserts;
END;

GO
PRINT 'Executed proc_CT_HFIT_PPTEligibility_AddNewRecs.sql';
GO
--**************
print('END: ' + cast(getdate() as nvarchar(50)));
print('@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-');
print'***************************************************************' ;
print('START: ' + cast(getdate() as nvarchar(50)));
--**************

--SET ANSI_NULLS ON;
--SET ANSI_PADDING ON;
--SET ANSI_WARNINGS ON;
--SET ARITHABORT ON;
--SET CONCAT_NULL_YIELDS_NULL ON;
--SET NUMERIC_ROUNDABORT OFF;
--SET QUOTED_IDENTIFIER ON;





-- use KenticoCMS_PRD_1

GO
PRINT 'Executing proc_CT_HFIT_PPTEligibility_AddUpdatedRecs.sql';
GO
IF EXISTS ( SELECT
                   name
                   FROM sys.procedures
                   WHERE name = 'proc_CT_HFIT_PPTEligibility_AddUpdatedRecs') 
    BEGIN
        DROP PROCEDURE
             proc_CT_HFIT_PPTEligibility_AddUpdatedRecs;
    END;
GO

/*----------------------------------------------------------
    exec proc_CT_HFIT_PPTEligibility_AddUpdatedRecs
    select * from STAGING_HFIT_PPTEligibility where SYS_CHANGE_VERSION is not null
*/

CREATE PROCEDURE proc_CT_HFIT_PPTEligibility_AddUpdatedRecs
AS
BEGIN
    WITH CTE (
         PPTID
       , SYS_CHANGE_VERSION
       , SYS_CHANGE_OPERATION
       , SYS_CHANGE_COLUMNS) 
        AS ( SELECT
                    CT.PPTID
                  , CT.SYS_CHANGE_VERSION
                  , CT.SYS_CHANGE_OPERATION
                  , SYS_CHANGE_COLUMNS
                    FROM CHANGETABLE (CHANGES HFIT_PPTEligibility, NULL) AS CT
                    WHERE SYS_CHANGE_OPERATION = 'U') 
        UPDATE S
               SET
                   S.PPTID = T.PPTID
                 ,S.ClientID = T.ClientID
                 ,S.ClientCode = T.ClientCode
                 ,S.UserID = T.UserID
                 ,S.IDCard = T.IDCard
                 ,S.FirstName = T.FirstName
                 ,S.LastName = T.LastName
                 ,S.MiddleInit = T.MiddleInit
                 ,S.BirthDate = T.BirthDate
                 ,S.Gender = T.Gender
                 ,S.AddressLine1 = T.AddressLine1
                 ,S.AddressLine2 = T.AddressLine2
                 ,S.City = T.City
                 ,S.State = T.State
                 ,S.PostalCode = T.PostalCode
                 ,S.HomePhoneNum = T.HomePhoneNum
                 ,S.WorkPhoneNum = T.WorkPhoneNum
                 ,S.MobilePhoneNum = T.MobilePhoneNum
                 ,S.EmailAddress = T.EmailAddress
                 ,S.MPI = T.MPI
                 ,S.MatchMethodCode = T.MatchMethodCode
                 ,S.SSN = T.SSN
                 ,S.PrimarySSN = T.PrimarySSN
                 ,S.HireDate = T.HireDate
                 ,S.TermDate = T.TermDate
                 ,S.RetireeDate = T.RetireeDate
                 ,S.PlanName = T.PlanName
                 ,S.PlanDescription = T.PlanDescription
                 ,S.PlanID = T.PlanID
                 ,S.PlanStartDate = T.PlanStartDate
                 ,S.PlanEndDate = T.PlanEndDate
                 ,S.Company = T.Company
                 ,S.CompanyCd = T.CompanyCd
                 ,S.LocationName = T.LocationName
                 ,S.LocationCd = T.LocationCd
                 ,S.DepartmentName = T.DepartmentName
                 ,S.DepartmentCd = T.DepartmentCd
                 ,S.UnionCd = T.UnionCd
                 ,S.BenefitGrp = T.BenefitGrp
                 ,S.PayGrp = T.PayGrp
                 ,S.Division = T.Division
                 ,S.JobTitle = T.JobTitle
                 ,S.JobCd = T.JobCd
                 ,S.TeamName = T.TeamName
                 ,S.MaritalStatus = T.MaritalStatus
                 ,S.PersonType = T.PersonType
                 ,S.PersonStatus = T.PersonStatus
                 ,S.EmployeeType = T.EmployeeType
                 ,S.CoverageType = T.CoverageType
                 ,S.EmployeeStatus = T.EmployeeStatus
                 ,S.PayCd = T.PayCd
                 ,S.BenefitStatus = T.BenefitStatus
                 ,S.PlanType = T.PlanType
                 ,S.ClientPlatformElig = T.ClientPlatformElig
                 ,S.ClientHRAElig = T.ClientHRAElig
                 ,S.ClientLMElig = T.ClientLMElig
                 ,S.ClientIncentiveElig = T.ClientIncentiveElig
                 ,S.ClientCMElig = T.ClientCMElig
                 ,S.ClientScreeningElig = T.ClientScreeningElig
                 ,S.Custom1 = T.Custom1
                 ,S.Custom2 = T.Custom2
                 ,S.Custom3 = T.Custom3
                 ,S.Custom4 = T.Custom4
                 ,S.Custom5 = T.Custom5
                 ,S.Custom6 = T.Custom6
                 ,S.Custom7 = T.Custom7
                 ,S.Custom8 = T.Custom8
                 ,S.Custom9 = T.Custom9
                 ,S.Custom10 = T.Custom10
                 ,S.Custom11 = T.Custom11
                 ,S.Custom12 = T.Custom12
                 ,S.Custom13 = T.Custom13
                 ,S.Custom14 = T.Custom14
                 ,S.Custom15 = T.Custom15
                 ,S.ChangeStatusFlag = T.ChangeStatusFlag
                 ,S.Last_Update_Dt = T.Last_Update_Dt
                 ,S.FlatFileName = T.FlatFileName
                 ,S.ItemGUID = T.ItemGUID
                 ,S.Hashbyte_Checksum = T.Hashbyte_Checksum
                 ,S.Primary_MPI = T.Primary_MPI
                 ,S.MPI_Relationship_Type = T.MPI_Relationship_Type
                 ,S.WorkInd = T.WorkInd

                 ,S.LastModifiedDate = GETDATE () 
                 ,S.DeletedFlg = NULL
                 ,S.ConvertedToCentralTime = NULL
                 ,S.SYS_CHANGE_VERSION = CTE.SYS_CHANGE_VERSION

                   FROM STAGING_HFIT_PPTEligibility AS S
                            JOIN
                            HFIT_PPTEligibility AS T
                                ON
                                S.PPTID = T.PPTID
                            AND S.DeletedFlg IS NULL
                            JOIN CTE
                                ON CTE.PPTID = T.PPTID
                               AND (CTE.SYS_CHANGE_VERSION != S.SYS_CHANGE_VERSION
                                 OR S.SYS_CHANGE_VERSION IS NULL);

    DECLARE
    @iCnt AS int = @@ROWCOUNT;
    PRINT 'Updated Count: ' + CAST ( @iCnt AS nvarchar (50)) ;

	exec proc_CT_HFIT_PPTEligibility_History 'U' ;
    
    RETURN @iCnt;
END;

GO
PRINT 'Executed proc_CT_HFIT_PPTEligibility_AddUpdatedRecs.sql';
GO
 --**************
print('END: ' + cast(getdate() as nvarchar(50)));
print('@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-');
print'***************************************************************' ;
print('START: ' + cast(getdate() as nvarchar(50)));
--**************

--SET ANSI_NULLS ON;
--SET ANSI_PADDING ON;
--SET ANSI_WARNINGS ON;
--SET ARITHABORT ON;
--SET CONCAT_NULL_YIELDS_NULL ON;
--SET NUMERIC_ROUNDABORT OFF;
--SET QUOTED_IDENTIFIER ON;





GO
PRINT 'Executing proc_CT_HFIT_PPTEligibility_History.sql';
GO
IF EXISTS (SELECT
				  name
				  FROM sys.procedures
				  WHERE name = 'proc_CT_HFIT_PPTEligibility_History') 
	BEGIN
		DROP PROCEDURE
			 proc_CT_HFIT_PPTEligibility_History;
	END;
GO

/**************************************************************************

select tc.commit_time, *
from
    changetable(changes HFIT_PPTEligibility, 0) c
    join sys.dm_tran_commit_table tc on c.sys_change_version = tc.commit_ts


exec proc_CT_HFIT_PPTEligibility_History 'I'
exec proc_CT_HFIT_PPTEligibility_History 'D'
exec proc_CT_HFIT_PPTEligibility_History 'U'

truncate table STAGING_HFIT_PPTEligibility_Update_History
select * from STAGING_HFIT_PPTEligibility_Update_History

SELECT CHANGE_TRACKING_MIN_VALID_VERSION(OBJECT_ID('HFIT_PPTEligibility'))
**************************************************************************/

CREATE PROCEDURE proc_CT_HFIT_PPTEligibility_History (@Typesave AS nchar (1)) 
AS
	 BEGIN
		 WITH CTE (
			  PPTID
			, SYS_CHANGE_VERSION
			, SYS_CHANGE_COLUMNS) 
			 AS (SELECT
						CT.PPTID
					  , CT.SYS_CHANGE_VERSION
					  , SYS_CHANGE_COLUMNS
						FROM CHANGETABLE (CHANGES HFIT_PPTEligibility, NULL) AS CT
						WHERE SYS_CHANGE_OPERATION = @Typesave
				 EXCEPT
				 SELECT
						PPTID
					  , SYS_CHANGE_VERSION
					  , SYS_CHANGE_COLUMNS
						FROM STAGING_HFIT_PPTEligibility_Update_History) 
			 INSERT INTO STAGING_HFIT_PPTEligibility_Update_History (
						 PPTID
					   , LastModifiedDate
					   , SVR
					   , DBNAME
					   , SYS_CHANGE_VERSION
					   , SYS_CHANGE_COLUMNS
					   , SYS_CHANGE_OPERATION
					   , AddressLine1_cg
					   , AddressLine2_cg
					   , BenefitGrp_cg
					   , BenefitStatus_cg
					   , BirthDate_cg
					   , ChangeStatusFlag_cg
					   , City_cg
					   , ClientCMElig_cg
					   , ClientCode_cg
					   , ClientHRAElig_cg
					   , ClientID_cg
					   , ClientIncentiveElig_cg
					   , ClientLMElig_cg
					   , ClientPlatformElig_cg
					   , ClientScreeningElig_cg
					   , Company_cg
					   , CompanyCd_cg
					   , CoverageType_cg
					   , Custom1_cg
					   , Custom10_cg
					   , Custom11_cg
					   , Custom12_cg
					   , Custom13_cg
					   , Custom14_cg
					   , Custom15_cg
					   , Custom2_cg
					   , Custom3_cg
					   , Custom4_cg
					   , Custom5_cg
					   , Custom6_cg
					   , Custom7_cg
					   , Custom8_cg
					   , Custom9_cg
					   , DepartmentCd_cg
					   , DepartmentName_cg
					   , Division_cg
					   , EmailAddress_cg
					   , EmployeeStatus_cg
					   , EmployeeType_cg
					   , FirstName_cg
					   , FlatFileName_cg
					   , Gender_cg
					   , Hashbyte_Checksum_cg
					   , HireDate_cg
					   , HomePhoneNum_cg
					   , IDCard_cg
					   , ItemGUID_cg
					   , JobCd_cg
					   , JobTitle_cg
					   , Last_Update_Dt_cg
					   , LastName_cg
					   , LocationCd_cg
					   , LocationName_cg
					   , MaritalStatus_cg
					   , MatchMethodCode_cg
					   , MiddleInit_cg
					   , MobilePhoneNum_cg
					   , MPI_cg
					   , MPI_Relationship_Type_cg
					   , PayCd_cg
					   , PayGrp_cg
					   , PersonStatus_cg
					   , PersonType_cg
					   , PlanDescription_cg
					   , PlanEndDate_cg
					   , PlanID_cg
					   , PlanName_cg
					   , PlanStartDate_cg
					   , PlanType_cg
					   , PostalCode_cg
					   , PPTID_cg
					   , Primary_MPI_cg
					   , PrimarySSN_cg
					   , RetireeDate_cg
					   , SSN_cg
					   , State_cg
					   , TeamName_cg
					   , TermDate_cg
					   , UnionCd_cg
					   , UserID_cg
					   , WorkInd_cg
					   , WorkPhoneNum_cg,commit_time) 
			 SELECT
					CTE.PPTID
				  , GETDATE () AS LastModifiedDate
				  , @@Servername AS SVR
				  , DB_NAME () AS DBNAME
				  , CTE.SYS_CHANGE_VERSION
				  , CTE.SYS_CHANGE_COLUMNS
				  , @Typesave AS SYS_CHANGE_OPERATION
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'AddressLine1', 'columnid') , CTE.sys_change_columns) AS AddressLine1_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'AddressLine2', 'columnid') , CTE.sys_change_columns) AS AddressLine2_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'BenefitGrp', 'columnid') , CTE.sys_change_columns) AS BenefitGrp_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'BenefitStatus', 'columnid') , CTE.sys_change_columns) AS BenefitStatus_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'BirthDate', 'columnid') , CTE.sys_change_columns) AS BirthDate_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'ChangeStatusFlag', 'columnid') , CTE.sys_change_columns) AS ChangeStatusFlag_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'City', 'columnid') , CTE.sys_change_columns) AS City_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'ClientCMElig', 'columnid') , CTE.sys_change_columns) AS ClientCMElig_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'ClientCode', 'columnid') , CTE.sys_change_columns) AS ClientCode_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'ClientHRAElig', 'columnid') , CTE.sys_change_columns) AS ClientHRAElig_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'ClientID', 'columnid') , CTE.sys_change_columns) AS ClientID_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'ClientIncentiveElig', 'columnid') , CTE.sys_change_columns) AS ClientIncentiveElig_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'ClientLMElig', 'columnid') , CTE.sys_change_columns) AS ClientLMElig_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'ClientPlatformElig', 'columnid') , CTE.sys_change_columns) AS ClientPlatformElig_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'ClientScreeningElig', 'columnid') , CTE.sys_change_columns) AS ClientScreeningElig_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'Company', 'columnid') , CTE.sys_change_columns) AS Company_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'CompanyCd', 'columnid') , CTE.sys_change_columns) AS CompanyCd_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'CoverageType', 'columnid') , CTE.sys_change_columns) AS CoverageType_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'Custom1', 'columnid') , CTE.sys_change_columns) AS Custom1_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'Custom10', 'columnid') , CTE.sys_change_columns) AS Custom10_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'Custom11', 'columnid') , CTE.sys_change_columns) AS Custom11_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'Custom12', 'columnid') , CTE.sys_change_columns) AS Custom12_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'Custom13', 'columnid') , CTE.sys_change_columns) AS Custom13_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'Custom14', 'columnid') , CTE.sys_change_columns) AS Custom14_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'Custom15', 'columnid') , CTE.sys_change_columns) AS Custom15_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'Custom2', 'columnid') , CTE.sys_change_columns) AS Custom2_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'Custom3', 'columnid') , CTE.sys_change_columns) AS Custom3_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'Custom4', 'columnid') , CTE.sys_change_columns) AS Custom4_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'Custom5', 'columnid') , CTE.sys_change_columns) AS Custom5_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'Custom6', 'columnid') , CTE.sys_change_columns) AS Custom6_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'Custom7', 'columnid') , CTE.sys_change_columns) AS Custom7_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'Custom8', 'columnid') , CTE.sys_change_columns) AS Custom8_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'Custom9', 'columnid') , CTE.sys_change_columns) AS Custom9_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'DepartmentCd', 'columnid') , CTE.sys_change_columns) AS DepartmentCd_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'DepartmentName', 'columnid') , CTE.sys_change_columns) AS DepartmentName_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'Division', 'columnid') , CTE.sys_change_columns) AS Division_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'EmailAddress', 'columnid') , CTE.sys_change_columns) AS EmailAddress_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'EmployeeStatus', 'columnid') , CTE.sys_change_columns) AS EmployeeStatus_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'EmployeeType', 'columnid') , CTE.sys_change_columns) AS EmployeeType_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'FirstName', 'columnid') , CTE.sys_change_columns) AS FirstName_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'FlatFileName', 'columnid') , CTE.sys_change_columns) AS FlatFileName_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'Gender', 'columnid') , CTE.sys_change_columns) AS Gender_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'Hashbyte_Checksum', 'columnid') , CTE.sys_change_columns) AS Hashbyte_Checksum_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'HireDate', 'columnid') , CTE.sys_change_columns) AS HireDate_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'HomePhoneNum', 'columnid') , CTE.sys_change_columns) AS HomePhoneNum_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'IDCard', 'columnid') , CTE.sys_change_columns) AS IDCard_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'ItemGUID', 'columnid') , CTE.sys_change_columns) AS ItemGUID_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'JobCd', 'columnid') , CTE.sys_change_columns) AS JobCd_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'JobTitle', 'columnid') , CTE.sys_change_columns) AS JobTitle_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'Last_Update_Dt', 'columnid') , CTE.sys_change_columns) AS Last_Update_Dt_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'LastName', 'columnid') , CTE.sys_change_columns) AS LastName_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'LocationCd', 'columnid') , CTE.sys_change_columns) AS LocationCd_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'LocationName', 'columnid') , CTE.sys_change_columns) AS LocationName_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'MaritalStatus', 'columnid') , CTE.sys_change_columns) AS MaritalStatus_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'MatchMethodCode', 'columnid') , CTE.sys_change_columns) AS MatchMethodCode_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'MiddleInit', 'columnid') , CTE.sys_change_columns) AS MiddleInit_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'MobilePhoneNum', 'columnid') , CTE.sys_change_columns) AS MobilePhoneNum_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'MPI', 'columnid') , CTE.sys_change_columns) AS MPI_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'MPI_Relationship_Type', 'columnid') , CTE.sys_change_columns) AS MPI_Relationship_Type_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'PayCd', 'columnid') , CTE.sys_change_columns) AS PayCd_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'PayGrp', 'columnid') , CTE.sys_change_columns) AS PayGrp_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'PersonStatus', 'columnid') , CTE.sys_change_columns) AS PersonStatus_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'PersonType', 'columnid') , CTE.sys_change_columns) AS PersonType_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'PlanDescription', 'columnid') , CTE.sys_change_columns) AS PlanDescription_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'PlanEndDate', 'columnid') , CTE.sys_change_columns) AS PlanEndDate_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'PlanID', 'columnid') , CTE.sys_change_columns) AS PlanID_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'PlanName', 'columnid') , CTE.sys_change_columns) AS PlanName_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'PlanStartDate', 'columnid') , CTE.sys_change_columns) AS PlanStartDate_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'PlanType', 'columnid') , CTE.sys_change_columns) AS PlanType_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'PostalCode', 'columnid') , CTE.sys_change_columns) AS PostalCode_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'PPTID', 'columnid') , CTE.sys_change_columns) AS PPTID_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'Primary_MPI', 'columnid') , CTE.sys_change_columns) AS Primary_MPI_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'PrimarySSN', 'columnid') , CTE.sys_change_columns) AS PrimarySSN_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'RetireeDate', 'columnid') , CTE.sys_change_columns) AS RetireeDate_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'SSN', 'columnid') , CTE.sys_change_columns) AS SSN_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'State', 'columnid') , CTE.sys_change_columns) AS State_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'TeamName', 'columnid') , CTE.sys_change_columns) AS TeamName_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'TermDate', 'columnid') , CTE.sys_change_columns) AS TermDate_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'UnionCd', 'columnid') , CTE.sys_change_columns) AS UnionCd_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'UserID', 'columnid') , CTE.sys_change_columns) AS UserID_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'WorkInd', 'columnid') , CTE.sys_change_columns) AS WorkInd_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'WorkPhoneNum', 'columnid') , CTE.sys_change_columns) AS WorkPhoneNum_cg
				  ,tc.commit_time
					FROM
						 CTE
							 JOIN sys.dm_tran_commit_table AS tc
								 ON CTE.sys_change_version = tc.commit_ts;

	 END;

GO
PRINT 'Executed proc_CT_HFIT_PPTEligibility_History.sql';
GO
--**************
print('END: ' + cast(getdate() as nvarchar(50)));
print('@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-');
print'***************************************************************' ;
print('START: ' + cast(getdate() as nvarchar(50)));
--**************

--SET ANSI_NULLS ON;
--SET ANSI_PADDING ON;
--SET ANSI_WARNINGS ON;
--SET ARITHABORT ON;
--SET CONCAT_NULL_YIELDS_NULL ON;
--SET NUMERIC_ROUNDABORT OFF;
--SET QUOTED_IDENTIFIER ON;




-- USE KenticoCMS_PRD_1

/*************************
------------------------
cms_user			    -> DONE
cms_usersettings	  -> DONE
CMS_UserSite	  -> DONE
HFIT_PPTEligibility
cms_usercontact
*************************/
GO
PRINT 'Executing create_table_STAGING_HFIT_PPTEligibility.sql';
GO

IF EXISTS (SELECT
                  name
                  FROM sys.tables
                  WHERE name = 'STAGING_HFIT_PPTEligibility_Audit') 
    BEGIN
        DROP TABLE
             STAGING_HFIT_PPTEligibility_Audit;
    END;
GO

CREATE TABLE dbo.STAGING_HFIT_PPTEligibility_Audit (
             PPTID int NOT NULL
           , SVR nvarchar (100) NOT NULL
           , DBNAME nvarchar (100) NOT NULL
           , SYS_CHANGE_VERSION int NULL
           , SYS_CHANGE_OPERATION nvarchar (10) NULL
           , SchemaName nvarchar (100) NULL
           , SysUser nvarchar (100) NULL
           , IPADDR nvarchar (50) NULL
           , Processed integer NULL
           , TBL nvarchar (100) NULL
           , CreateDate datetime NULL
           , commit_time datetime NULL) ;
GO
ALTER TABLE dbo.STAGING_HFIT_PPTEligibility_Audit
ADD
            CONSTRAINT DF_STAGING_HFIT_PPTEligibility_Audit_CreateDate DEFAULT GETDATE () FOR CreateDate;
GO

CREATE CLUSTERED INDEX PK_HFIT_PPTEligibility_Audit ON dbo.STAGING_HFIT_PPTEligibility_Audit (PPTID ASC, SVR ASC, SYS_CHANGE_VERSION ASC, SYS_CHANGE_OPERATION ASC) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];

GO

IF NOT EXISTS (SELECT
					  sys.tables.name AS Table_name
					  FROM
						   sys.change_tracking_tables
							   JOIN sys.tables
								   ON sys.tables.object_id = sys.change_tracking_tables.object_id
							   JOIN sys.schemas
								   ON sys.schemas.schema_id = sys.tables.schema_id
					  WHERE sys.tables.name = 'HFIT_PPTEligibility') 
	BEGIN
		PRINT 'ADDING Change Tracking to HFIT_PPTEligibility';
		ALTER TABLE dbo.HFIT_PPTEligibility ENABLE CHANGE_TRACKING
				WITH (TRACK_COLUMNS_UPDATED = ON) ;
	END;
ELSE
	BEGIN
		PRINT 'Change Tracking exists on HFIT_PPTEligibility';
	END;
GO
IF EXISTS (SELECT
				  name
				  FROM sys.procedures
				  WHERE name = 'proc_Create_Table_STAGING_HFIT_PPTEligibility') 
	BEGIN
		DROP PROCEDURE
			 proc_Create_Table_STAGING_HFIT_PPTEligibility;
	END;
GO
-- exec proc_Create_Table_STAGING_HFIT_PPTEligibility
-- select top 100 * from [STAGING_HFIT_PPTEligibility]
CREATE PROCEDURE proc_Create_Table_STAGING_HFIT_PPTEligibility
AS
	 BEGIN

		 IF EXISTS (SELECT
						   name
						   FROM sys.tables
						   WHERE name = 'STAGING_HFIT_PPTEligibility') 
			 BEGIN
				 DROP TABLE
					  dbo.STAGING_HFIT_PPTEligibility;
			 END;

		 SET ANSI_NULLS ON;
		 SET QUOTED_IDENTIFIER ON;

		 CREATE TABLE dbo.STAGING_HFIT_PPTEligibility (
					  PPTID int NOT NULL
					, ClientID varchar (27) NULL
					, ClientCode varchar (12) NULL
					, UserID int NULL
					, IDCard nvarchar (25) NULL
					, FirstName varchar (50) NOT NULL
					, LastName varchar (50) NOT NULL
					, MiddleInit varchar (2) NULL
					, BirthDate datetime2 (7) NULL
					, Gender nvarchar (1) NULL
					, AddressLine1 varchar (50) NULL
					, AddressLine2 varchar (50) NULL
					, City varchar (30) NULL
					, State varchar (2) NULL
					, PostalCode varchar (10) NULL
					, HomePhoneNum varchar (12) NULL
					, WorkPhoneNum varchar (12) NULL
					, MobilePhoneNum varchar (12) NULL
					, EmailAddress varchar (50) NULL
					, MPI varchar (50) NOT NULL
					, MatchMethodCode nvarchar (25) NULL
					, SSN varchar (11) NULL
					, PrimarySSN varchar (11) NULL
					, HireDate datetime2 (7) NULL
					, TermDate datetime2 (7) NULL
					, RetireeDate datetime2 (7) NULL
					, PlanName varchar (50) NULL
					, PlanDescription varchar (50) NULL
					, PlanID varchar (25) NULL
					, PlanStartDate datetime2 (7) NULL
					, PlanEndDate datetime2 (7) NULL
					, Company varchar (50) NULL
					, CompanyCd varchar (20) NULL
					, LocationName varchar (50) NULL
					, LocationCd varchar (20) NULL
					, DepartmentName varchar (50) NULL
					, DepartmentCd varchar (20) NULL
					, UnionCd varchar (30) NULL
					, BenefitGrp varchar (20) NULL
					, PayGrp varchar (20) NULL
					, Division varchar (30) NULL
					, JobTitle varchar (50) NULL
					, JobCd varchar (20) NULL
					, TeamName varchar (30) NULL
					, MaritalStatus varchar (30) NULL
					, PersonType varchar (30) NULL
					, PersonStatus varchar (30) NULL
					, EmployeeType varchar (30) NULL
					, CoverageType varchar (30) NULL
					, EmployeeStatus varchar (30) NULL
					, PayCd varchar (30) NULL
					, BenefitStatus varchar (30) NULL
					, PlanType varchar (20) NULL
					, ClientPlatformElig bit NULL
					, ClientHRAElig bit NULL
					, ClientLMElig bit NULL
					, ClientIncentiveElig bit NULL
					, ClientCMElig bit NULL
					, ClientScreeningElig bit NULL
					, Custom1 varchar (50) NULL
					, Custom2 varchar (50) NULL
					, Custom3 varchar (50) NULL
					, Custom4 varchar (50) NULL
					, Custom5 varchar (50) NULL
					, Custom6 varchar (50) NULL
					, Custom7 varchar (50) NULL
					, Custom8 varchar (50) NULL
					, Custom9 varchar (50) NULL
					, Custom10 varchar (50) NULL
					, Custom11 varchar (50) NULL
					, Custom12 varchar (50) NULL
					, Custom13 varchar (50) NULL
					, Custom14 varchar (50) NULL
					, Custom15 varchar (50) NULL
					, ChangeStatusFlag nvarchar (1) NULL
					, Last_Update_Dt datetime2 (7) NULL
					, FlatFileName nvarchar (500) NULL
					, ItemGUID uniqueidentifier NOT NULL
					, Hashbyte_Checksum varchar (32) NULL
					, Primary_MPI nvarchar (50) NULL
					, MPI_Relationship_Type varchar (50) NULL
					, WorkInd bit NULL
					, LastModifiedDate datetime NULL
					, RowNbr int NULL
					, DeletedFlg bit NULL
					, TimeZone nvarchar (10) NULL
					, ConvertedToCentralTime bit NULL
					, SVR nvarchar (100) NOT NULL
					, DBNAME nvarchar (100) NOT NULL
					, SYS_CHANGE_VERSION int NULL) 
		 ON [PRIMARY];

		 ALTER TABLE dbo.STAGING_HFIT_PPTEligibility
		 ADD
					 DEFAULT @@Servername FOR SVR;
		 ALTER TABLE dbo.STAGING_HFIT_PPTEligibility
		 ADD
					 DEFAULT DB_NAME () FOR DBNAME;

		 CREATE CLUSTERED INDEX PI_STAGING_HFIT_PPTEligibility ON dbo.STAGING_HFIT_PPTEligibility (PPTID ASC, SVR ASC, DBNAME ASC, SYS_CHANGE_VERSION ASC) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];

		 --SET IDENTITY_INSERT STAGING_HFIT_PPTEligibility ON;

		 INSERT INTO STAGING_HFIT_PPTEligibility (
					 PPTID
				   , ClientID
				   , ClientCode
				   , UserID
				   , IDCard
				   , FirstName
				   , LastName
				   , MiddleInit
				   , BirthDate
				   , Gender
				   , AddressLine1
				   , AddressLine2
				   , City
				   , State
				   , PostalCode
				   , HomePhoneNum
				   , WorkPhoneNum
				   , MobilePhoneNum
				   , EmailAddress
				   , MPI
				   , MatchMethodCode
				   , SSN
				   , PrimarySSN
				   , HireDate
				   , TermDate
				   , RetireeDate
				   , PlanName
				   , PlanDescription
				   , PlanID
				   , PlanStartDate
				   , PlanEndDate
				   , Company
				   , CompanyCd
				   , LocationName
				   , LocationCd
				   , DepartmentName
				   , DepartmentCd
				   , UnionCd
				   , BenefitGrp
				   , PayGrp
				   , Division
				   , JobTitle
				   , JobCd
				   , TeamName
				   , MaritalStatus
				   , PersonType
				   , PersonStatus
				   , EmployeeType
				   , CoverageType
				   , EmployeeStatus
				   , PayCd
				   , BenefitStatus
				   , PlanType
				   , ClientPlatformElig
				   , ClientHRAElig
				   , ClientLMElig
				   , ClientIncentiveElig
				   , ClientCMElig
				   , ClientScreeningElig
				   , Custom1
				   , Custom2
				   , Custom3
				   , Custom4
				   , Custom5
				   , Custom6
				   , Custom7
				   , Custom8
				   , Custom9
				   , Custom10
				   , Custom11
				   , Custom12
				   , Custom13
				   , Custom14
				   , Custom15
				   , ChangeStatusFlag
				   , Last_Update_Dt
				   , FlatFileName
				   , ItemGUID
				   , Hashbyte_Checksum
				   , Primary_MPI
				   , MPI_Relationship_Type
				   , WorkInd) 
		 SELECT
				PPTID
			  , ClientID
			  , ClientCode
			  , UserID
			  , IDCard
			  , FirstName
			  , LastName
			  , MiddleInit
			  , BirthDate
			  , Gender
			  , AddressLine1
			  , AddressLine2
			  , City
			  , State
			  , PostalCode
			  , HomePhoneNum
			  , WorkPhoneNum
			  , MobilePhoneNum
			  , EmailAddress
			  , MPI
			  , MatchMethodCode
			  , SSN
			  , PrimarySSN
			  , HireDate
			  , TermDate
			  , RetireeDate
			  , PlanName
			  , PlanDescription
			  , PlanID
			  , PlanStartDate
			  , PlanEndDate
			  , Company
			  , CompanyCd
			  , LocationName
			  , LocationCd
			  , DepartmentName
			  , DepartmentCd
			  , UnionCd
			  , BenefitGrp
			  , PayGrp
			  , Division
			  , JobTitle
			  , JobCd
			  , TeamName
			  , MaritalStatus
			  , PersonType
			  , PersonStatus
			  , EmployeeType
			  , CoverageType
			  , EmployeeStatus
			  , PayCd
			  , BenefitStatus
			  , PlanType
			  , ClientPlatformElig
			  , ClientHRAElig
			  , ClientLMElig
			  , ClientIncentiveElig
			  , ClientCMElig
			  , ClientScreeningElig
			  , Custom1
			  , Custom2
			  , Custom3
			  , Custom4
			  , Custom5
			  , Custom6
			  , Custom7
			  , Custom8
			  , Custom9
			  , Custom10
			  , Custom11
			  , Custom12
			  , Custom13
			  , Custom14
			  , Custom15
			  , ChangeStatusFlag
			  , Last_Update_Dt
			  , FlatFileName
			  , ItemGUID
			  , Hashbyte_Checksum
			  , Primary_MPI
			  , MPI_Relationship_Type
			  , WorkInd
				FROM HFIT_PPTEligibility;

		 --SET IDENTITY_INSERT STAGING_HFIT_PPTEligibility OFF;

		 IF EXISTS (SELECT
						   name
						   FROM sys.tables
						   WHERE name = 'STAGING_HFIT_PPTEligibility_Update_History') 
			 BEGIN
				 PRINT 'dropping and recreating STAGING_HFIT_PPTEligibility_Update_History';
				 DROP TABLE
					  STAGING_HFIT_PPTEligibility_Update_History;
			 END;

		 CREATE TABLE dbo.STAGING_HFIT_PPTEligibility_Update_History (
					  PPTID int NOT NULL
					, AddressLine1_cg int NULL
					, AddressLine2_cg int NULL
					, BenefitGrp_cg int NULL
					, BenefitStatus_cg int NULL
					, BirthDate_cg int NULL
					, ChangeStatusFlag_cg int NULL
					, City_cg int NULL
					, ClientCMElig_cg int NULL
					, ClientCode_cg int NULL
					, ClientHRAElig_cg int NULL
					, ClientID_cg int NULL
					, ClientIncentiveElig_cg int NULL
					, ClientLMElig_cg int NULL
					, ClientPlatformElig_cg int NULL
					, ClientScreeningElig_cg int NULL
					, Company_cg int NULL
					, CompanyCd_cg int NULL
					, CoverageType_cg int NULL
					, Custom1_cg int NULL
					, Custom10_cg int NULL
					, Custom11_cg int NULL
					, Custom12_cg int NULL
					, Custom13_cg int NULL
					, Custom14_cg int NULL
					, Custom15_cg int NULL
					, Custom2_cg int NULL
					, Custom3_cg int NULL
					, Custom4_cg int NULL
					, Custom5_cg int NULL
					, Custom6_cg int NULL
					, Custom7_cg int NULL
					, Custom8_cg int NULL
					, Custom9_cg int NULL
					, DepartmentCd_cg int NULL
					, DepartmentName_cg int NULL
					, Division_cg int NULL
					, EmailAddress_cg int NULL
					, EmployeeStatus_cg int NULL
					, EmployeeType_cg int NULL
					, FirstName_cg int NULL
					, FlatFileName_cg int NULL
					, Gender_cg int NULL
					, Hashbyte_Checksum_cg int NULL
					, HireDate_cg int NULL
					, HomePhoneNum_cg int NULL
					, IDCard_cg int NULL
					, ItemGUID_cg int NULL
					, JobCd_cg int NULL
					, JobTitle_cg int NULL
					, Last_Update_Dt_cg int NULL
					, LastName_cg int NULL
					, LocationCd_cg int NULL
					, LocationName_cg int NULL
					, MaritalStatus_cg int NULL
					, MatchMethodCode_cg int NULL
					, MiddleInit_cg int NULL
					, MobilePhoneNum_cg int NULL
					, MPI_cg int NULL
					, MPI_Relationship_Type_cg int NULL
					, PayCd_cg int NULL
					, PayGrp_cg int NULL
					, PersonStatus_cg int NULL
					, PersonType_cg int NULL
					, PlanDescription_cg int NULL
					, PlanEndDate_cg int NULL
					, PlanID_cg int NULL
					, PlanName_cg int NULL
					, PlanStartDate_cg int NULL
					, PlanType_cg int NULL
					, PostalCode_cg int NULL
					, PPTID_cg int NULL
					, Primary_MPI_cg int NULL
					, PrimarySSN_cg int NULL
					, RetireeDate_cg int NULL
					, SSN_cg int NULL
					, State_cg int NULL
					, TeamName_cg int NULL
					, TermDate_cg int NULL
					, UnionCd_cg int NULL
					, UserID_cg int NULL
					, WorkInd_cg int NULL
					, WorkPhoneNum_cg int NULL
					, LastModifiedDate datetime DEFAULT GETDATE () 
					, SVR nvarchar (100) NOT NULL
										 DEFAULT @@Servername
					, DBNAME nvarchar (100) NOT NULL
											DEFAULT DB_NAME () 
					, SYS_CHANGE_VERSION int NULL
					, SYS_CHANGE_COLUMNS varbinary (4000) NULL
					, SYS_CHANGE_OPERATION nchar (1) NULL
					, CurrUser nvarchar (100) NULL
											  CONSTRAINT DF_STAGING_HFIT_PPTEligibility_Update_History_CurrUser DEFAULT USER_NAME () 
					, SysUser nvarchar (100) NULL
											 CONSTRAINT DF_STAGING_HFIT_PPTEligibility_Update_History_SysUser DEFAULT SUSER_SNAME () 
					, IPADDR nvarchar (50) NULL
										   CONSTRAINT DF_STAGING_HFIT_PPTEligibility_Update_History_IPADDR DEFAULT CAST (CONNECTIONPROPERTY ('client_net_address') AS nvarchar (50))
					,commit_time datetime)
		 ON [PRIMARY];

		 CREATE CLUSTERED INDEX PI_STAGING_HFIT_PPTEligibility_Update_History ON dbo.STAGING_HFIT_PPTEligibility_Update_History (PPTID ASC, SVR ASC, SYS_CHANGE_VERSION ASC) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];

	 -- select * from STAGING_HFIT_PPTEligibility_Update_History
	 --ALTER TABLE dbo.STAGING_HFIT_PPTEligibility_Update_History
	 --ADD
	 --            DEFAULT @@servername FOR SVR;
	 --ALTER TABLE dbo.STAGING_HFIT_PPTEligibility_Update_History
	 --ADD
	 --            DEFAULT DB_NAME () FOR DBNAME;

	 END;

GO
PRINT 'Executed create_table_STAGING_HFIT_PPTEligibility.sql';
GO
EXEC proc_Create_Table_STAGING_HFIT_PPTEligibility;
GO
--SELECT * FROM STAGING_HFIT_PPTEligibility_Update_History;
--**************
print('END: ' + cast(getdate() as nvarchar(50)));
print('@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-');
print'***************************************************************' ;
print('START: ' + cast(getdate() as nvarchar(50)));
--**************

--SET ANSI_NULLS ON;
--SET ANSI_PADDING ON;
--SET ANSI_WARNINGS ON;
--SET ARITHABORT ON;
--SET CONCAT_NULL_YIELDS_NULL ON;
--SET NUMERIC_ROUNDABORT OFF;
--SET QUOTED_IDENTIFIER ON;




-- USE KenticoCMS_PRD_1
/*-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
select top 100 * from HFIT_PPTEligibility
update HFIT_PPTEligibility set UserNickNAme = null where UserSettingsID in (select top 100 UserSettingsID from HFIT_PPTEligibility order by UserSettingsID desc) and UserNickName is null
*/

GO
-- use KenticoCMS_Prod1

/*---------------------------------------
Developer  : W. Dale Miller
05.28.2015 : WDM - completed unit testing
*/

GO
PRINT 'creating proc_STAGING_EDW_HFIT_PPTEligibility';
PRINT GETDATE () ;
GO

IF EXISTS ( SELECT
                   name
                   FROM sys.procedures
                   WHERE name = 'proc_STAGING_EDW_HFIT_PPTEligibility') 
    BEGIN
        PRINT 'UPDATING proc_STAGING_EDW_HFIT_PPTEligibility';
        DROP PROCEDURE
             proc_STAGING_EDW_HFIT_PPTEligibility;
    END;

GO

-- exec proc_STAGING_EDW_HFIT_PPTEligibility

CREATE PROCEDURE proc_STAGING_EDW_HFIT_PPTEligibility (
     @ReloadAll AS int = 0) 
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE
    @iTotal AS bigint = 0;

    EXEC @iTotal = proc_QuickRowCount 'STAGING_HFIT_PPTEligibility';

    IF @iTotal <= 1
        BEGIN
            SET @Reloadall = 1;
        END;

    BEGIN

        IF @ReloadAll IS NULL
            BEGIN
                SET @ReloadAll = 0;
            END;

        DECLARE
        @RecordID AS uniqueidentifier = NEWID () ;
        DECLARE
        @CT_DateTimeNow AS datetime = GETDATE () ;
        DECLARE
        @CT_NAME AS nvarchar ( 50) = 'proc_STAGING_EDW_HFIT_PPTEligibility';
        EXEC proc_EDW_CT_ExecutionLog_Update @RecordID , @CT_NAME , @CT_DateTimeNow , 0 , 'I';

        IF @ReloadAll = 1
            BEGIN
                PRINT 'RELOADING ALL Change Tracking HFIT_PPTEligibility records';
                EXEC proc_Create_Table_STAGING_HFIT_PPTEligibility ;
                PRINT 'RELOAD COMPLETE';
            END;
        ELSE
            BEGIN
                EXEC proc_CT_HFIT_PPTEligibility_AddNewRecs ;
                EXEC proc_CT_HFIT_PPTEligibility_AddUpdatedRecs ;
                EXEC proc_HFIT_PPTEligibility_AddDeletedRecs ;
            END;

    END;
END;

GO
PRINT 'CREATED proc_STAGING_EDW_HFIT_PPTEligibility';
PRINT GETDATE () ;
GO--**************
print('END: ' + cast(getdate() as nvarchar(50)));
print('@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-');
print'***************************************************************' ;
print('START: ' + cast(getdate() as nvarchar(50)));
--**************

--SET ANSI_NULLS ON;
--SET ANSI_PADDING ON;
--SET ANSI_WARNINGS ON;
--SET ARITHABORT ON;
--SET CONCAT_NULL_YIELDS_NULL ON;
--SET NUMERIC_ROUNDABORT OFF;
--SET QUOTED_IDENTIFIER ON;





GO
PRINT 'Creating JOB Create_job_EDW_GetStagingData_HFIT_PPTEligibility';
GO

BEGIN TRANSACTION;
DECLARE
@ReturnCode int;
SELECT
       @ReturnCode = 0;

IF NOT EXISTS ( SELECT
                       name
                       FROM msdb.dbo.syscategories
                       WHERE
                       name = N'[Uncategorized (Local)]'
                   AND category_class = 1) 
    BEGIN EXEC @ReturnCode = msdb.dbo.sp_add_category @class = N'JOB' , @type = N'LOCAL' , @name = N'[Uncategorized (Local)]';
        IF
        @@ERROR <> 0
     OR @ReturnCode <> 0
            BEGIN
                GOTO QuitWithRollback;
            END;

    END;

DECLARE
@TGTDB AS nvarchar ( 50) = DB_NAME () ;

DECLARE
@JNAME AS nvarchar ( 100) = 'job_EDW_GetStagingData_HFIT_PPTEligibility_' + @TGTDB;

IF EXISTS ( SELECT
                   job_id
                   FROM msdb.dbo.sysjobs_view
                   WHERE name = @JNAME) 
    BEGIN EXEC msdb.dbo.sp_delete_job @job_name = @JNAME , @delete_unused_schedule = 1;
    END;

DECLARE
@jobId binary ( 16) ;
EXEC @ReturnCode = msdb.dbo.sp_add_job @job_name = @JNAME , @enabled = 1 , @notify_level_eventlog = 2 , @notify_level_email = 2 , @notify_level_netsend = 0 , @notify_level_page = 0 , @delete_level = 0 , @description = N'No description available.' , @category_name = N'[Uncategorized (Local)]' , @owner_login_name = N'sa' , @notify_email_operator_name = N'DBA_Notify' , @job_id = @jobId OUTPUT;
IF
@@ERROR <> 0
OR @ReturnCode <> 0
    BEGIN
        GOTO QuitWithRollback;
    END;

/*--------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
***** Object:  Step [Load_STAGING_EDW_HFIT_PPTEligibility]    Script Date: 4/12/2015 9:59:37 AM *****
*/

EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id = @jobId , @step_name = N'Load_STAGING_EDW_HFIT_PPTEligibility' , @step_id = 1 , @cmdexec_success_code = 0 , @on_success_action = 1 , @on_success_step_id = 0 , @on_fail_action = 2 , @on_fail_step_id = 0 , @retry_attempts = 0 , @retry_interval = 0 , @os_run_priority = 0 , @subsystem = N'TSQL' , @command = N'exec proc_STAGING_EDW_HFIT_PPTEligibility;' , @database_name = @TGTDB , @flags = 0;
IF
@@ERROR <> 0
OR @ReturnCode <> 0
    BEGIN
        GOTO QuitWithRollback;
    END;
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId , @start_step_id = 1;
IF
@@ERROR <> 0
OR @ReturnCode <> 0
    BEGIN
        GOTO QuitWithRollback;
    END;
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id = @jobId , @name = N'Schedule_STAGING_EDW_HFIT_PPTEligibility' , @enabled = 1 , @freq_type = 4 , @freq_interval = 1 , @freq_subday_type = 8 , @freq_subday_interval = 8 , @freq_relative_interval = 0 , @freq_recurrence_factor = 0 , @active_start_date = 20150412 , @active_end_date = 99991231 , @active_start_time = 10000 ,
@active_end_time = 235959;
--@schedule_uid = N'afcb6980-89fe-4a08-ad03-6598bd55454a';
IF
@@ERROR <> 0
OR @ReturnCode <> 0
    BEGIN
        GOTO QuitWithRollback;
    END;
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId , @server_name = N'(local)';
IF
@@ERROR <> 0
OR @ReturnCode <> 0
    BEGIN
        GOTO QuitWithRollback;
    END;
COMMIT TRANSACTION;
GOTO EndSave;
QuitWithRollback:
IF @@TRANCOUNT > 0
    BEGIN
        ROLLBACK TRANSACTION;
    END;
EndSave:

PRINT 'CREATED JOB ' + @JNAME;

GO



--**************
print('END: ' + cast(getdate() as nvarchar(50)));
print('@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-');
print'***************************************************************' ;
print('START: ' + cast(getdate() as nvarchar(50)));
--**************

--SET ANSI_NULLS ON;
--SET ANSI_PADDING ON;
--SET ANSI_WARNINGS ON;
--SET ARITHABORT ON;
--SET CONCAT_NULL_YIELDS_NULL ON;
--SET NUMERIC_ROUNDABORT OFF;
--SET QUOTED_IDENTIFIER ON;





GO
PRINT 'Executing proc_CT_HFIT_PPTEligibility_History.sql';
GO
IF EXISTS (SELECT
				  name
				  FROM sys.procedures
				  WHERE name = 'proc_CT_HFIT_PPTEligibility_History') 
	BEGIN
		DROP PROCEDURE
			 proc_CT_HFIT_PPTEligibility_History;
	END;
GO

/**************************************************************************

select tc.commit_time, *
from
    changetable(changes HFIT_PPTEligibility, 0) c
    join sys.dm_tran_commit_table tc on c.sys_change_version = tc.commit_ts


exec proc_CT_HFIT_PPTEligibility_History 'I'
exec proc_CT_HFIT_PPTEligibility_History 'D'
exec proc_CT_HFIT_PPTEligibility_History 'U'

truncate table STAGING_HFIT_PPTEligibility_Update_History
select * from STAGING_HFIT_PPTEligibility_Update_History

SELECT CHANGE_TRACKING_MIN_VALID_VERSION(OBJECT_ID('HFIT_PPTEligibility'))
**************************************************************************/

CREATE PROCEDURE proc_CT_HFIT_PPTEligibility_History (@Typesave AS nchar (1)) 
AS
	 BEGIN
		 WITH CTE (
			  PPTID
			, SYS_CHANGE_VERSION
			, SYS_CHANGE_COLUMNS) 
			 AS (SELECT
						CT.PPTID
					  , CT.SYS_CHANGE_VERSION
					  , SYS_CHANGE_COLUMNS
						FROM CHANGETABLE (CHANGES HFIT_PPTEligibility, NULL) AS CT
						WHERE SYS_CHANGE_OPERATION = @Typesave
				 EXCEPT
				 SELECT
						PPTID
					  , SYS_CHANGE_VERSION
					  , SYS_CHANGE_COLUMNS
						FROM STAGING_HFIT_PPTEligibility_Update_History) 
			 INSERT INTO STAGING_HFIT_PPTEligibility_Update_History (
						 PPTID
					   , LastModifiedDate
					   , SVR
					   , DBNAME
					   , SYS_CHANGE_VERSION
					   , SYS_CHANGE_COLUMNS
					   , SYS_CHANGE_OPERATION
					   , AddressLine1_cg
					   , AddressLine2_cg
					   , BenefitGrp_cg
					   , BenefitStatus_cg
					   , BirthDate_cg
					   , ChangeStatusFlag_cg
					   , City_cg
					   , ClientCMElig_cg
					   , ClientCode_cg
					   , ClientHRAElig_cg
					   , ClientID_cg
					   , ClientIncentiveElig_cg
					   , ClientLMElig_cg
					   , ClientPlatformElig_cg
					   , ClientScreeningElig_cg
					   , Company_cg
					   , CompanyCd_cg
					   , CoverageType_cg
					   , Custom1_cg
					   , Custom10_cg
					   , Custom11_cg
					   , Custom12_cg
					   , Custom13_cg
					   , Custom14_cg
					   , Custom15_cg
					   , Custom2_cg
					   , Custom3_cg
					   , Custom4_cg
					   , Custom5_cg
					   , Custom6_cg
					   , Custom7_cg
					   , Custom8_cg
					   , Custom9_cg
					   , DepartmentCd_cg
					   , DepartmentName_cg
					   , Division_cg
					   , EmailAddress_cg
					   , EmployeeStatus_cg
					   , EmployeeType_cg
					   , FirstName_cg
					   , FlatFileName_cg
					   , Gender_cg
					   , Hashbyte_Checksum_cg
					   , HireDate_cg
					   , HomePhoneNum_cg
					   , IDCard_cg
					   , ItemGUID_cg
					   , JobCd_cg
					   , JobTitle_cg
					   , Last_Update_Dt_cg
					   , LastName_cg
					   , LocationCd_cg
					   , LocationName_cg
					   , MaritalStatus_cg
					   , MatchMethodCode_cg
					   , MiddleInit_cg
					   , MobilePhoneNum_cg
					   , MPI_cg
					   , MPI_Relationship_Type_cg
					   , PayCd_cg
					   , PayGrp_cg
					   , PersonStatus_cg
					   , PersonType_cg
					   , PlanDescription_cg
					   , PlanEndDate_cg
					   , PlanID_cg
					   , PlanName_cg
					   , PlanStartDate_cg
					   , PlanType_cg
					   , PostalCode_cg
					   , PPTID_cg
					   , Primary_MPI_cg
					   , PrimarySSN_cg
					   , RetireeDate_cg
					   , SSN_cg
					   , State_cg
					   , TeamName_cg
					   , TermDate_cg
					   , UnionCd_cg
					   , UserID_cg
					   , WorkInd_cg
					   , WorkPhoneNum_cg,commit_time) 
			 SELECT
					CTE.PPTID
				  , GETDATE () AS LastModifiedDate
				  , @@Servername AS SVR
				  , DB_NAME () AS DBNAME
				  , CTE.SYS_CHANGE_VERSION
				  , CTE.SYS_CHANGE_COLUMNS
				  , @Typesave AS SYS_CHANGE_OPERATION
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'AddressLine1', 'columnid') , CTE.sys_change_columns) AS AddressLine1_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'AddressLine2', 'columnid') , CTE.sys_change_columns) AS AddressLine2_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'BenefitGrp', 'columnid') , CTE.sys_change_columns) AS BenefitGrp_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'BenefitStatus', 'columnid') , CTE.sys_change_columns) AS BenefitStatus_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'BirthDate', 'columnid') , CTE.sys_change_columns) AS BirthDate_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'ChangeStatusFlag', 'columnid') , CTE.sys_change_columns) AS ChangeStatusFlag_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'City', 'columnid') , CTE.sys_change_columns) AS City_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'ClientCMElig', 'columnid') , CTE.sys_change_columns) AS ClientCMElig_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'ClientCode', 'columnid') , CTE.sys_change_columns) AS ClientCode_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'ClientHRAElig', 'columnid') , CTE.sys_change_columns) AS ClientHRAElig_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'ClientID', 'columnid') , CTE.sys_change_columns) AS ClientID_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'ClientIncentiveElig', 'columnid') , CTE.sys_change_columns) AS ClientIncentiveElig_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'ClientLMElig', 'columnid') , CTE.sys_change_columns) AS ClientLMElig_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'ClientPlatformElig', 'columnid') , CTE.sys_change_columns) AS ClientPlatformElig_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'ClientScreeningElig', 'columnid') , CTE.sys_change_columns) AS ClientScreeningElig_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'Company', 'columnid') , CTE.sys_change_columns) AS Company_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'CompanyCd', 'columnid') , CTE.sys_change_columns) AS CompanyCd_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'CoverageType', 'columnid') , CTE.sys_change_columns) AS CoverageType_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'Custom1', 'columnid') , CTE.sys_change_columns) AS Custom1_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'Custom10', 'columnid') , CTE.sys_change_columns) AS Custom10_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'Custom11', 'columnid') , CTE.sys_change_columns) AS Custom11_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'Custom12', 'columnid') , CTE.sys_change_columns) AS Custom12_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'Custom13', 'columnid') , CTE.sys_change_columns) AS Custom13_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'Custom14', 'columnid') , CTE.sys_change_columns) AS Custom14_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'Custom15', 'columnid') , CTE.sys_change_columns) AS Custom15_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'Custom2', 'columnid') , CTE.sys_change_columns) AS Custom2_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'Custom3', 'columnid') , CTE.sys_change_columns) AS Custom3_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'Custom4', 'columnid') , CTE.sys_change_columns) AS Custom4_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'Custom5', 'columnid') , CTE.sys_change_columns) AS Custom5_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'Custom6', 'columnid') , CTE.sys_change_columns) AS Custom6_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'Custom7', 'columnid') , CTE.sys_change_columns) AS Custom7_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'Custom8', 'columnid') , CTE.sys_change_columns) AS Custom8_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'Custom9', 'columnid') , CTE.sys_change_columns) AS Custom9_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'DepartmentCd', 'columnid') , CTE.sys_change_columns) AS DepartmentCd_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'DepartmentName', 'columnid') , CTE.sys_change_columns) AS DepartmentName_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'Division', 'columnid') , CTE.sys_change_columns) AS Division_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'EmailAddress', 'columnid') , CTE.sys_change_columns) AS EmailAddress_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'EmployeeStatus', 'columnid') , CTE.sys_change_columns) AS EmployeeStatus_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'EmployeeType', 'columnid') , CTE.sys_change_columns) AS EmployeeType_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'FirstName', 'columnid') , CTE.sys_change_columns) AS FirstName_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'FlatFileName', 'columnid') , CTE.sys_change_columns) AS FlatFileName_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'Gender', 'columnid') , CTE.sys_change_columns) AS Gender_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'Hashbyte_Checksum', 'columnid') , CTE.sys_change_columns) AS Hashbyte_Checksum_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'HireDate', 'columnid') , CTE.sys_change_columns) AS HireDate_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'HomePhoneNum', 'columnid') , CTE.sys_change_columns) AS HomePhoneNum_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'IDCard', 'columnid') , CTE.sys_change_columns) AS IDCard_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'ItemGUID', 'columnid') , CTE.sys_change_columns) AS ItemGUID_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'JobCd', 'columnid') , CTE.sys_change_columns) AS JobCd_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'JobTitle', 'columnid') , CTE.sys_change_columns) AS JobTitle_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'Last_Update_Dt', 'columnid') , CTE.sys_change_columns) AS Last_Update_Dt_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'LastName', 'columnid') , CTE.sys_change_columns) AS LastName_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'LocationCd', 'columnid') , CTE.sys_change_columns) AS LocationCd_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'LocationName', 'columnid') , CTE.sys_change_columns) AS LocationName_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'MaritalStatus', 'columnid') , CTE.sys_change_columns) AS MaritalStatus_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'MatchMethodCode', 'columnid') , CTE.sys_change_columns) AS MatchMethodCode_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'MiddleInit', 'columnid') , CTE.sys_change_columns) AS MiddleInit_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'MobilePhoneNum', 'columnid') , CTE.sys_change_columns) AS MobilePhoneNum_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'MPI', 'columnid') , CTE.sys_change_columns) AS MPI_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'MPI_Relationship_Type', 'columnid') , CTE.sys_change_columns) AS MPI_Relationship_Type_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'PayCd', 'columnid') , CTE.sys_change_columns) AS PayCd_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'PayGrp', 'columnid') , CTE.sys_change_columns) AS PayGrp_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'PersonStatus', 'columnid') , CTE.sys_change_columns) AS PersonStatus_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'PersonType', 'columnid') , CTE.sys_change_columns) AS PersonType_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'PlanDescription', 'columnid') , CTE.sys_change_columns) AS PlanDescription_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'PlanEndDate', 'columnid') , CTE.sys_change_columns) AS PlanEndDate_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'PlanID', 'columnid') , CTE.sys_change_columns) AS PlanID_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'PlanName', 'columnid') , CTE.sys_change_columns) AS PlanName_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'PlanStartDate', 'columnid') , CTE.sys_change_columns) AS PlanStartDate_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'PlanType', 'columnid') , CTE.sys_change_columns) AS PlanType_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'PostalCode', 'columnid') , CTE.sys_change_columns) AS PostalCode_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'PPTID', 'columnid') , CTE.sys_change_columns) AS PPTID_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'Primary_MPI', 'columnid') , CTE.sys_change_columns) AS Primary_MPI_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'PrimarySSN', 'columnid') , CTE.sys_change_columns) AS PrimarySSN_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'RetireeDate', 'columnid') , CTE.sys_change_columns) AS RetireeDate_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'SSN', 'columnid') , CTE.sys_change_columns) AS SSN_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'State', 'columnid') , CTE.sys_change_columns) AS State_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'TeamName', 'columnid') , CTE.sys_change_columns) AS TeamName_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'TermDate', 'columnid') , CTE.sys_change_columns) AS TermDate_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'UnionCd', 'columnid') , CTE.sys_change_columns) AS UnionCd_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'UserID', 'columnid') , CTE.sys_change_columns) AS UserID_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'WorkInd', 'columnid') , CTE.sys_change_columns) AS WorkInd_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'WorkPhoneNum', 'columnid') , CTE.sys_change_columns) AS WorkPhoneNum_cg
				  ,tc.commit_time
					FROM
						 CTE
							 JOIN sys.dm_tran_commit_table AS tc
								 ON CTE.sys_change_version = tc.commit_ts;

	 END;

GO
PRINT 'Executed proc_CT_HFIT_PPTEligibility_History.sql';
GO
--**************
print('END: ' + cast(getdate() as nvarchar(50)));
print('@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-');
print'***************************************************************' ;
print('START: ' + cast(getdate() as nvarchar(50)));
--**************

--SET ANSI_NULLS ON;
--SET ANSI_PADDING ON;
--SET ANSI_WARNINGS ON;
--SET ARITHABORT ON;
--SET CONCAT_NULL_YIELDS_NULL ON;
--SET NUMERIC_ROUNDABORT OFF;
--SET QUOTED_IDENTIFIER ON;






GO
PRINT 'Executing TRIG_HFIT_PPTEligibility_Audit.SQL';
GO
-- select count(*) from STAGING_HFIT_PPTEligibility_Audit
-- select * from STAGING_HFIT_PPTEligibility_Audit
-- truncate table STAGING_HFIT_PPTEligibility_Audit

IF EXISTS (SELECT
                  name
                  FROM sys.tables
                  WHERE name = 'STAGING_HFIT_PPTEligibility_Audit') 
    BEGIN
        DROP TABLE
             STAGING_HFIT_PPTEligibility_Audit;
    END;
GO

CREATE TABLE dbo.STAGING_HFIT_PPTEligibility_Audit (
             PPTID int NOT NULL
           , SVR nvarchar (100) NOT NULL
           , DBNAME nvarchar (100) NOT NULL
           , SYS_CHANGE_VERSION int NULL
           , SYS_CHANGE_OPERATION nvarchar (10) NULL
           , SchemaName nvarchar (100) NULL
           , SysUser nvarchar (100) NULL
           , IPADDR nvarchar (50) NULL
           , Processed integer NULL
           , TBL nvarchar (100) NULL
           , CreateDate datetime NULL
           , commit_time datetime NULL) ;
GO
ALTER TABLE dbo.STAGING_HFIT_PPTEligibility_Audit
ADD
            CONSTRAINT DF_STAGING_HFIT_PPTEligibility_Audit_CreateDate DEFAULT GETDATE () FOR CreateDate;
GO

CREATE CLUSTERED INDEX PK_HFIT_PPTEligibility_Audit ON dbo.STAGING_HFIT_PPTEligibility_Audit (PPTID ASC, SVR ASC, SYS_CHANGE_VERSION ASC, SYS_CHANGE_OPERATION ASC) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];

GO

/*----------------------------------------------------------------------------------------------------------------------------------
**********************************************************************************************************************************
-- TROUBLESHOOTING AND TESTING QRYS
	select count(*) from HFIT_PPTEligibility where UserID = 53 and SiteID = 36
	INSERT INTO HFIT_PPTEligibility (UserID, SiteID) VALUES (53, 36) ;
	delete from HFIT_PPTEligibility where UserID = 53 and SiteID = 36
	select top 1000 * from CMS_User
	select top 1000 * from HFIT_PPTEligibility
	update HFIT_PPTEligibility set FirstName = FirstName where PPTID in (Select top 100 PPTID from HFIT_PPTEligibility order by PPTID )
	select * from STAGING_HFIT_PPTEligibility_Audit
	truncate table  STAGING_HFIT_PPTEligibility_Audit
**********************************************************************************************************************************
*/

IF EXISTS (SELECT
                  name
                  FROM sys.triggers
                  WHERE name = 'trig_INS_HFIT_PPTEligibility_Audit') 
    BEGIN
        DROP TRIGGER
             trig_INS_HFIT_PPTEligibility_Audit;
    END;
GO

CREATE TRIGGER trig_INS_HFIT_PPTEligibility_Audit ON HFIT_PPTEligibility
    AFTER INSERT
AS
BEGIN

    DECLARE @Svr nvarchar (100) = (SELECT
                                          @@Servername);
    DECLARE @Db nvarchar (100) = (SELECT
                                         DB_NAME ());
    DECLARE @CurrChg_Ver int = (SELECT
                                       MAX (CT.SYS_CHANGE_VERSION) 
                                       FROM CHANGETABLE (CHANGES HFIT_PPTEligibility, NULL) AS CT);

    DECLARE @Chg_Ver int = @CurrChg_Ver - 1;

    DECLARE @Ipaddr nvarchar (50) = (SELECT
                                            CAST (CONNECTIONPROPERTY ('client_net_address') AS nvarchar (50)));
    DECLARE @Userid nvarchar (50) = (SELECT
                                            USER_NAME ());
    DECLARE @Sysuser nvarchar (50) = (SELECT
                                             SYSTEM_USER);

    DECLARE @Commit_Time datetime = (SELECT TOP 1
                                            tc.commit_time
                                            FROM
                                                CHANGETABLE (CHANGES HFIT_PPTEligibility, @Chg_Ver) c
                                                    JOIN sys.dm_tran_commit_table AS tc
                                                        ON c.sys_change_version = tc.commit_ts);

    INSERT INTO STAGING_HFIT_PPTEligibility_Audit (
           PPTID
         , SVR
         , DBNAME
         , SYS_CHANGE_VERSION
         , SYS_CHANGE_OPERATION
         , SchemaName
         , SysUser
         , IPADDR
         , Processed
         , TBL
         , commit_time) 
    SELECT
           PPTID
         , @Svr
         , @Db
         , @Chg_Ver
         , 'I'
         , @Userid
         , @Sysuser
         , @Ipaddr
         , 0 AS Processed
         , 'HFIT_PPTEligibility'
         , @Commit_Time
           FROM Inserted;
END;

GO

IF EXISTS (SELECT
                  name
                  FROM sys.triggers
                  WHERE name = 'trig_UPDT_HFIT_PPTEligibility_Audit') 
    BEGIN
        DROP TRIGGER
             trig_UPDT_HFIT_PPTEligibility_Audit;
    END;
GO

CREATE TRIGGER trig_UPDT_HFIT_PPTEligibility_Audit ON HFIT_PPTEligibility
    AFTER UPDATE
AS
BEGIN
    DECLARE @Next_Baseline bigint;
    SET @Next_Baseline = CHANGE_TRACKING_CURRENT_VERSION () ;
    DECLARE @Svr nvarchar (100) = (SELECT
                                          @@Servername);
    DECLARE @Db nvarchar (100) = (SELECT
                                         DB_NAME ());
    DECLARE @CurrChg_Ver int = (SELECT
                                       MAX (CT.SYS_CHANGE_VERSION) 
                                       FROM CHANGETABLE (CHANGES HFIT_PPTEligibility, NULL) AS CT);

    DECLARE @Chg_Ver int = @CurrChg_Ver - 1;
    DECLARE @Ipaddr nvarchar (50) = (SELECT
                                            CAST (CONNECTIONPROPERTY ('client_net_address') AS nvarchar (50)));
    DECLARE @Userid nvarchar (50) = (SELECT
                                            USER_NAME ());
    DECLARE @Sysuser nvarchar (50) = (SELECT
                                             SYSTEM_USER);

    --exec @Chg_Ver = proc_CT_getPrevVer 'HFIT_PPTEligibility' ;
    --print @Chg_Ver ;

    DECLARE @Commit_Time datetime = (SELECT TOP 1
                                            tc.commit_time
                                            FROM
                                                CHANGETABLE (CHANGES HFIT_PPTEligibility, @Chg_Ver) c
                                                    JOIN sys.dm_tran_commit_table AS tc
                                                        ON c.sys_change_version = tc.commit_ts);
    SET @Chg_Ver = @Chg_Ver - 1;

    INSERT INTO STAGING_HFIT_PPTEligibility_Audit (
           PPTID
         , SVR
         , DBNAME
         , SYS_CHANGE_VERSION
         , SYS_CHANGE_OPERATION
         , SchemaName
         , SysUser
         , IPADDR
         , Processed
         , TBL
         , commit_time) 
    SELECT
           PPTID
         , @Svr
         , @Db
         , @Chg_Ver
         , 'U'
         , @Userid
         , @Sysuser
         , @Ipaddr
         , 0 AS Processed
         , 'HFIT_PPTEligibility'
         , @Commit_Time
           FROM Inserted;
END;

GO

IF EXISTS (SELECT
                  name
                  FROM sys.triggers
                  WHERE name = 'trig_DEL_HFIT_PPTEligibility_Audit') 
    BEGIN
        DROP TRIGGER
             trig_DEL_HFIT_PPTEligibility_Audit;
    END;
GO

CREATE TRIGGER trig_DEL_HFIT_PPTEligibility_Audit ON HFIT_PPTEligibility
    AFTER DELETE
AS
BEGIN

    DECLARE @Svr nvarchar (100) = (SELECT
                                          @@Servername);
    DECLARE @Db nvarchar (100) = (SELECT
                                         DB_NAME ());
    DECLARE @CurrChg_Ver int = (SELECT
                                       MAX (CT.SYS_CHANGE_VERSION) 
                                       FROM CHANGETABLE (CHANGES HFIT_PPTEligibility, NULL) AS CT);

    DECLARE @Chg_Ver int = @CurrChg_Ver - 1;

    DECLARE @Ipaddr nvarchar (50) = (SELECT
                                            CAST (CONNECTIONPROPERTY ('client_net_address') AS nvarchar (50)));
    DECLARE @Userid nvarchar (50) = (SELECT
                                            USER_NAME ());
    DECLARE @Sysuser nvarchar (50) = (SELECT
                                             SYSTEM_USER);
    EXEC @Chg_Ver = proc_CT_getPrevVer 'HFIT_PPTEligibility';
    PRINT @Chg_Ver;

    DECLARE @Commit_Time datetime = (SELECT TOP 1
                                            tc.commit_time
                                            FROM
                                                CHANGETABLE (CHANGES HFIT_PPTEligibility, @Chg_Ver) c
                                                    JOIN sys.dm_tran_commit_table AS tc
                                                        ON c.sys_change_version = tc.commit_ts);

    SET @Chg_Ver = @Chg_Ver - 1;

    INSERT INTO STAGING_HFIT_PPTEligibility_Audit (
           PPTID
         , SVR
         , DBNAME
         , SYS_CHANGE_VERSION
         , SYS_CHANGE_OPERATION
         , SchemaName
         , SysUser
         , IPADDR
         , Processed
         , TBL
         , commit_time) 
    SELECT
           PPTID
         , @Svr
         , @Db
         , @Chg_Ver
         , 'D'
         , @Userid
         , @Sysuser
         , @Ipaddr
         , 0 AS Processed
         , 'HFIT_PPTEligibility'
         , @Commit_Time
           FROM DELETED;
END;

GO
PRINT 'EXECUTED TRIG_HFIT_PPTEligibility_Audit.SQL';
GO
--**************
print('END: ' + cast(getdate() as nvarchar(50)));
print('@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-');
print'***************************************************************' ;
print('START: ' + cast(getdate() as nvarchar(50)));
--**************

--SET ANSI_NULLS ON;
--SET ANSI_PADDING ON;
--SET ANSI_WARNINGS ON;
--SET ARITHABORT ON;
--SET CONCAT_NULL_YIELDS_NULL ON;
--SET NUMERIC_ROUNDABORT OFF;
--SET QUOTED_IDENTIFIER ON;






GO
PRINT 'Executing view_AUDIT_HFit_PPTEligibility.sql';
GO
IF EXISTS (SELECT
                  name
                  FROM sys.views
                  WHERE name = 'view_AUDIT_HFit_PPTEligibility') 
    BEGIN
        DROP VIEW
             view_AUDIT_HFit_PPTEligibility;
    END;

GO

/*------------------------------------------------------
    select top 100 * from STAGING_HFit_PPTEligibility
    select top 1000 * from STAGING_HFit_PPTEligibility_Update_History
    select top 1000 * from STAGING_HFit_PPTEligibility_Audit
*/

-- select top 1000 * from view_AUDIT_HFit_PPTEligibility order by PPTID
/*------------------------------------------------------------------------------
HOW TO USE:
    select * from view_AUDIT_HFit_PPTEligibility
	   where CreateDate between '2015-09-18 14:55:33.000' and '2015-09-18 14:55:34'

    select * from view_AUDIT_HFit_PPTEligibility
	   where SysUser = 'dmiller'
*/

CREATE VIEW view_AUDIT_HFit_PPTEligibility
AS SELECT
          A.SysUser
        , A.IPADDR
        , A.CreateDate as DateModified
        , A.SYS_CHANGE_OPERATION
        , A.SYS_CHANGE_VERSION as SysChangeVersion
        , S.*
          FROM
              STAGING_HFit_PPTEligibility_Audit AS A
                  JOIN STAGING_HFit_PPTEligibility AS S
                      ON S.PPTID = A.PPTID;
GO
PRINT 'Executed view_AUDIT_HFit_PPTEligibility.sql';
GO
