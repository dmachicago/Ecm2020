

GO
PRINT 'Executing proc_ConvertAllDatetimeToDatetime2.sql';
GO

IF EXISTS (SELECT
                  name
           FROM sys.procedures
           WHERE
                  name = 'proc_ConvertAllDatetimeToDatetime2') 
    BEGIN
        DROP PROCEDURE
             proc_ConvertAllDatetimeToDatetime2;
    END;
GO

/*----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------
SETUP:

use KenticoCMS_DataMart_2

select distinct 'if @ProcessDatetime = 1 truncate table ' + table_name + char(10) + 'GO' 
from information_schema.tables
where table_name like '%_DEL'

select distinct 'if @ProcessDatetime = 1 EXEC proc_ConvertAllDatetimeToDatetime2 ' + table_name + char(10) + 'GO' 
from information_schema.columns 
where table_name like 'BASE_%' and data_type = 'DATETIME'
*/

CREATE PROCEDURE proc_ConvertAllDatetimeToDatetime2 (
       @TblName AS NVARCHAR (250)) 
AS
BEGIN

    -- declare @TblName nvarchar(250) = 'BASE_HFit_TrackerCardio' ;

    BEGIN TRY
        CLOSE C;
        DEALLOCATE C;
    END TRY
    BEGIN CATCH
        PRINT ' ';
    END CATCH;

    BEGIN TRY
        CLOSE CDEFAULTCreate;
        DEALLOCATE CDEFAULTCreate;
    END TRY
    BEGIN CATCH
        PRINT ' ';
    END CATCH;

    BEGIN TRY
        CLOSE CDEFAULTDROP;
        DEALLOCATE CDEFAULTDROP;
    END TRY
    BEGIN CATCH
        PRINT ' ';
    END CATCH;

    BEGIN TRY
        CLOSE CIDXDROP;
        DEALLOCATE CIDXDROP;
    END TRY
    BEGIN CATCH
        PRINT ' ';
    END CATCH;
    BEGIN TRY
        CLOSE CIDXCREATE;
        DEALLOCATE CIDXCREATE;
    END TRY
    BEGIN CATCH
        PRINT ' ';
    END CATCH;

    DECLARE
           @MySql  NVARCHAR (MAX) 
         , @msg NVARCHAR (MAX) 
         , @iCnt INT = 0
         , @CreateIndexScript NVARCHAR (MAX) 
         , @ColumnNAme NVARCHAR (250) 
         , @definition  NVARCHAR (250) ;

    SET @msg = ' ' + char (10) + '*********************************************************' + char (10) + 'Processing: ' + @TblName;
    EXEC PrintImmediate @msg;

    SET  @iCnt = (SELECT
                         count (*) 
                  FROM information_schema.columns
                  WHERE
                         table_name = @TblName AND
                         data_type = 'DATETIME') ;
    IF @iCnt = 0
        BEGIN
            SET @Msg = 'No DATETIME found in ' + @TblName + ', returning.';
            EXEC PrintImmediate @Msg;
            RETURN;
        END;

    BEGIN TRY
        DROP TABLE
             tIndex;
    END TRY
    BEGIN CATCH
        PRINT 'dropped table #tIndex';
    END CATCH;
    CREATE TABLE tIndex
    (
                 CreateIndexScript NVARCHAR (MAX) 
               , INAME NVARCHAR (MAX) 
    );

    INSERT INTO tIndex
    EXEC proc_GetTableIndexes @TblName;
    --  select * from tIndex
    ALTER TABLE tIndex
    ADD
                IndexDropped BIT NULL;

    --set @IndexScript = (Select CreateIndexScript from #tIndex where INAME = @CurrIndexName) ;

    BEGIN TRY
        DROP TABLE
             tIdxColumns;
    END TRY
    BEGIN CATCH
        PRINT 'dropped table #tIdxColumns ';
    END CATCH;

    SELECT
           i.name AS index_name
         , COL_NAME (ic.object_id , ic.column_id) AS column_name
         , ic.index_column_id
         , ic.key_ordinal
         , ic.is_included_column
    INTO
         tIdxColumns
    FROM
         sys.indexes AS i
         INNER JOIN sys.index_columns AS ic
         ON
           i.object_id = ic.object_id AND
           i.index_id = ic.index_id
    WHERE
           i.object_id = OBJECT_ID (@TblName) ;
    --  select * from tIdxColumns

    BEGIN TRY
        DROP TABLE
             TDefaults;
    END TRY
    BEGIN CATCH
        PRINT 'dropped table #TDefaults ';
    END CATCH;

    SELECT
           TableName = t.Name
         , ColumnName = c.Name
         , dc.Name
         , dc.definition
    INTO
         TDefaults
    FROM
         sys.tables AS t
         INNER JOIN sys.default_constraints AS dc
         ON
           t.object_id = dc.parent_object_id
         INNER JOIN sys.columns AS c
         ON
           dc.parent_object_id = c.object_id AND
           c.column_id = dc.parent_column_id
    WHERE
           t.Name = @TblName
    ORDER BY
             t.Name;
    --  select * from TDefaults
    ALTER TABLE TDefaults
    ADD
                DefaultDropped BIT NULL;

    DECLARE
           @table_name AS NVARCHAR (250) = ''
         , @column_name AS NVARCHAR (250) = ''
         , @IndexName AS NVARCHAR (250) = ''
         , @S AS NVARCHAR (MAX) = ''
         , @DefaultName  AS NVARCHAR (250) = ''
         , @i AS INT = 0;

    BEGIN TRANSACTION TX01;

    BEGIN TRY
        DECLARE CIDXDROP CURSOR
            FOR
                SELECT
                       INAME
                FROM tIndex;

        OPEN CIDXDROP;

        FETCH NEXT FROM CIDXDROP INTO @IndexName;
        WHILE
               @@FETCH_STATUS = 0
            BEGIN
                SET @MySql = 'Drop Index ' + @IndexName + ' ON ' + @TblName;
                EXEC PrintImmediate @MySql;
                EXEC (@MySql) ;
                FETCH NEXT FROM CIDXDROP INTO @IndexName;
            END;
        CLOSE CIDXDROP;
        DEALLOCATE CIDXDROP;

        -- select * from TDefaults
        DECLARE CDEFAULTDROP CURSOR
            FOR
                SELECT
                       NAME
                FROM TDefaults;

        OPEN CDEFAULTDROP;

        FETCH NEXT FROM CDEFAULTDROP INTO @IndexName;
        WHILE
               @@FETCH_STATUS = 0
            BEGIN
                --alter table tbloffers drop constraint [ConstraintName]
                SET @MySql = 'Alter Table ' + @TblName + ' drop constraint ' + @IndexName;
                EXEC PrintImmediate @MySql;
                EXEC (@MySql) ;
                FETCH NEXT FROM CDEFAULTDROP INTO @IndexName;
            END;
        CLOSE CDEFAULTDROP;
        DEALLOCATE CDEFAULTDROP;

        DECLARE C CURSOR
            FOR
                SELECT
                       c.table_name
                     , c.column_name
                FROM
                     information_schema.columns AS C
                     JOIN information_schema.tables AS T
                     ON
                       c.table_name = t.table_name AND
                       table_type = 'BASE TABLE' AND
                       c.table_name = @TblName
                WHERE
                       data_type = 'datetime';

        OPEN C;

        FETCH NEXT FROM C
        INTO @table_name , @column_name;

        WHILE
               @@FETCH_STATUS = 0
            BEGIN

                SET @S = '';
                SET @S = 'Alter table ' + @table_name + ' alter column ' + @column_name + ' datetime2 null ';
                EXEC PrintImmediate @S;
                BEGIN TRY
                    EXEC (@S) ;
                END TRY
                BEGIN CATCH
                    PRINT 'ERROR: ' + @S;
                END CATCH;
                FETCH NEXT FROM C
                INTO @table_name , @column_name;
            END;
        CLOSE C;
        DEALLOCATE C;

        DECLARE CIDXCREATE CURSOR
            FOR
                SELECT
                       CreateIndexScript
                     , INAME
                FROM tIndex;
        OPEN CIDXCREATE;
        FETCH NEXT FROM CIDXCREATE
        INTO @CreateIndexScript , @IndexName;
        WHILE
               @@FETCH_STATUS = 0
            BEGIN
                SET @MySql = @CreateIndexScript;
                SET @MySql = replace (@MySql , ' WITH' , ' -- WITH') ;
                EXEC PrintImmediate @MySql;
                EXEC (@MySql) ;
                FETCH NEXT FROM CIDXCREATE
                INTO @CreateIndexScript , @IndexName;
            END;

        CLOSE CIDXCREATE;
        DEALLOCATE CIDXCREATE;

        DECLARE CDEFAULTCreate CURSOR
            FOR
                SELECT
                       ColumnName
                     , Name
                     , definition
                FROM TDefaults;
        OPEN CDEFAULTCreate;
        FETCH NEXT FROM CDEFAULTCreate INTO @ColumnName , @IndexName , @definition;
        WHILE
               @@FETCH_STATUS = 0
            BEGIN
                --ALTER TABLE Employee ADD CONSTRAINT DF_SomeName DEFAULT N'SANDNES' FOR CityBorn;
                SET @MySql = 'Alter Table ' + @TblName + ' ADD CONSTRAINT ' + @IndexName + ' default ' + @definition + ' for ' + @ColumnName;
                EXEC PrintImmediate @MySql;
                EXEC (@MySql) ;
                FETCH NEXT FROM CDEFAULTCreate INTO @ColumnName , @IndexName , @definition;
            END;
        CLOSE CDEFAULTCreate;
        DEALLOCATE CDEFAULTCreate;

        COMMIT TRANSACTION TX01;
    END TRY
    BEGIN CATCH
        PRINT 'ERROR: ROLLBACK Failed on ' + @TblName;
        PRINT '@MySql: ' + @MySql;
        EXECUTE usp_GetErrorInfo;
        ROLLBACK TRANSACTION TX01;
    END CATCH;

    SET @msg = ' -- ------ COMPLETE.' + char (10) + char (10) ;
    EXEC PrintImmediate @msg;

END;

GO
PRINT 'Executed proc_ConvertAllDatetimeToDatetime2.sql';
GO

DECLARE
       @ProcessDatetime AS BIT = 0;

IF
       @ProcessDatetime = 1
    BEGIN
        truncate TABLE BASE_CMS_Class_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        truncate TABLE BASE_CMS_Document_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        truncate TABLE BASE_CMS_Site_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        truncate TABLE BASE_CMS_Tree_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        truncate TABLE BASE_cms_user_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        truncate TABLE BASE_cms_usersettings_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        truncate TABLE BASE_cms_usersite_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        truncate TABLE BASE_COM_SKU_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        truncate TABLE BASE_HFit_Account_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        truncate TABLE BASE_HFit_CoachingHealthArea_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        truncate TABLE BASE_HFit_CoachingHealthInterest_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        truncate TABLE BASE_HFit_HACampaign_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        truncate TABLE BASE_HFit_HealthAssesmentMatrixQuestion_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        truncate TABLE BASE_HFit_HealthAssesmentModule_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        truncate TABLE BASE_HFit_HealthAssesmentMultipleChoiceQuestion_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        truncate TABLE BASE_HFit_HealthAssesmentRiskArea_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        truncate TABLE BASE_HFit_HealthAssesmentRiskCategory_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        truncate TABLE BASE_HFit_HealthAssesmentUserAnswers_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        truncate TABLE BASE_HFit_HealthAssesmentUserModule_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        truncate TABLE BASE_HFit_HealthAssesmentUserQuestion_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        truncate TABLE BASE_HFit_HealthAssesmentUserQuestionGroupResults_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        truncate TABLE BASE_HFit_HealthAssesmentUserRiskArea_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        truncate TABLE BASE_HFit_HealthAssesmentUserRiskCategory_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        truncate TABLE BASE_HFit_HealthAssesmentUserStarted_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        truncate TABLE BASE_HFit_HealthAssessment_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        truncate TABLE BASE_HFit_HealthAssessmentFreeForm_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        truncate TABLE BASE_HFIT_LKP_EDW_REJECTMPI_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        truncate TABLE BASE_HFit_LKP_RewardActivity_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        truncate TABLE BASE_HFit_LKP_RewardLevelType_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        truncate TABLE BASE_HFit_LKP_RewardTrigger_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        truncate TABLE BASE_HFit_LKP_RewardTriggerParameterOperator_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        truncate TABLE BASE_HFit_LKP_RewardType_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        truncate TABLE BASE_HFit_LKP_TrackerVendor_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        truncate TABLE BASE_HFit_OutComeMessages_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        truncate TABLE BASE_hfit_PPTEligibility_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        truncate TABLE BASE_HFit_RewardActivity_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        truncate TABLE BASE_HFit_RewardException_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        truncate TABLE BASE_HFit_RewardGroup_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        truncate TABLE BASE_HFit_RewardLevel_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        truncate TABLE BASE_HFit_RewardProgram_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        truncate TABLE BASE_HFit_RewardsUserActivityDetail_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        truncate TABLE BASE_HFit_RewardsUserLevelDetail_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        truncate TABLE BASE_HFit_RewardTrigger_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        truncate TABLE BASE_HFit_RewardTriggerParameter_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        truncate TABLE BASE_Hfit_SmallStepResponses_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        truncate TABLE BASE_HFit_ToDoSmallSteps_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        truncate TABLE BASE_HFIT_Tracker_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        truncate TABLE BASE_HFit_TrackerBloodPressure_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        truncate TABLE BASE_HFit_TrackerBloodSugarAndGlucose_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        truncate TABLE BASE_HFit_TrackerBMI_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        truncate TABLE BASE_HFit_TrackerBodyFat_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        truncate TABLE BASE_HFit_TrackerBodyMeasurements_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        truncate TABLE BASE_HFit_TrackerCardio_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        truncate TABLE BASE_HFit_TrackerCholesterol_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        truncate TABLE BASE_HFit_TrackerCollectionSource_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        truncate TABLE BASE_HFit_TrackerCotinine_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        truncate TABLE BASE_HFit_TrackerDailySteps_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        truncate TABLE BASE_HFit_TrackerDef_Tracker_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        truncate TABLE BASE_HFit_TrackerFlexibility_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        truncate TABLE BASE_HFit_TrackerFruits_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        truncate TABLE BASE_HFit_TrackerHbA1c_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        truncate TABLE BASE_HFit_TrackerHeight_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        truncate TABLE BASE_HFit_TrackerHighFatFoods_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        truncate TABLE BASE_HFit_TrackerHighSodiumFoods_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        truncate TABLE BASE_HFit_TrackerInstance_Tracker_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        truncate TABLE BASE_HFit_TrackerMealPortions_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        truncate TABLE BASE_HFit_TrackerMedicalCarePlan_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        truncate TABLE BASE_HFit_TrackerPreventiveCare_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        truncate TABLE BASE_HFit_TrackerRegularMeals_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        truncate TABLE BASE_HFit_TrackerRestingHeartRate_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        truncate TABLE BASE_HFit_TrackerShots_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        truncate TABLE BASE_HFit_TrackerSitLess_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        truncate TABLE BASE_HFit_TrackerSleepPlan_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        truncate TABLE BASE_HFit_TrackerStrength_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        truncate TABLE BASE_HFit_TrackerStress_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        truncate TABLE BASE_HFit_TrackerStressManagement_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        truncate TABLE BASE_HFit_TrackerSugaryDrinks_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        truncate TABLE BASE_HFit_TrackerSugaryFoods_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        truncate TABLE BASE_HFit_TrackerTests_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        truncate TABLE BASE_HFit_TrackerTobaccoAttestation_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        truncate TABLE BASE_HFit_TrackerTobaccoFree_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        truncate TABLE BASE_HFit_TrackerVegetables_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        truncate TABLE BASE_HFit_TrackerWater_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        truncate TABLE BASE_HFit_TrackerWeight_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        truncate TABLE BASE_HFit_TrackerWholeGrains_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        truncate TABLE BASE_HFit_UserTracker_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN

        EXEC proc_ConvertAllDatetimeToDatetime2 BASE_CMS_Class;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        EXEC proc_ConvertAllDatetimeToDatetime2 BASE_CMS_Document_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        EXEC proc_ConvertAllDatetimeToDatetime2 BASE_CMS_Site;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        EXEC proc_ConvertAllDatetimeToDatetime2 BASE_CMS_Site_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        EXEC proc_ConvertAllDatetimeToDatetime2 BASE_HFit_CoachingHealthInterest;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        EXEC proc_ConvertAllDatetimeToDatetime2 BASE_HFit_CoachingHealthInterest_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        EXEC proc_ConvertAllDatetimeToDatetime2 BASE_HFit_HACampaign;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        EXEC proc_ConvertAllDatetimeToDatetime2 BASE_HFit_HACampaign_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        EXEC proc_ConvertAllDatetimeToDatetime2 BASE_HFit_HealthAssesmentMatrixQuestion;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        EXEC proc_ConvertAllDatetimeToDatetime2 BASE_HFit_HealthAssesmentMatrixQuestion_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        EXEC proc_ConvertAllDatetimeToDatetime2 BASE_HFit_HealthAssesmentModule;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        EXEC proc_ConvertAllDatetimeToDatetime2 BASE_HFit_HealthAssesmentModule_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        EXEC proc_ConvertAllDatetimeToDatetime2 BASE_HFit_HealthAssesmentMultipleChoiceQuestion;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        EXEC proc_ConvertAllDatetimeToDatetime2 BASE_HFit_HealthAssesmentMultipleChoiceQuestion_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        EXEC proc_ConvertAllDatetimeToDatetime2 BASE_HFit_HealthAssesmentRiskArea;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        EXEC proc_ConvertAllDatetimeToDatetime2 BASE_HFit_HealthAssesmentRiskArea_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        EXEC proc_ConvertAllDatetimeToDatetime2 BASE_HFit_HealthAssesmentRiskCategory;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        EXEC proc_ConvertAllDatetimeToDatetime2 BASE_HFit_HealthAssesmentRiskCategory_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        EXEC proc_ConvertAllDatetimeToDatetime2 BASE_HFit_HealthAssesmentUserAnswers;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        EXEC proc_ConvertAllDatetimeToDatetime2 BASE_HFit_HealthAssesmentUserAnswers_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        EXEC proc_ConvertAllDatetimeToDatetime2 BASE_HFit_HealthAssesmentUserModule;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        EXEC proc_ConvertAllDatetimeToDatetime2 BASE_HFit_HealthAssesmentUserModule_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        EXEC proc_ConvertAllDatetimeToDatetime2 BASE_HFit_HealthAssesmentUserQuestion;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        EXEC proc_ConvertAllDatetimeToDatetime2 BASE_HFit_HealthAssesmentUserQuestion_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        EXEC proc_ConvertAllDatetimeToDatetime2 BASE_HFit_HealthAssesmentUserQuestionGroupResults;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        EXEC proc_ConvertAllDatetimeToDatetime2 BASE_HFit_HealthAssesmentUserQuestionGroupResults_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        EXEC proc_ConvertAllDatetimeToDatetime2 BASE_HFit_HealthAssesmentUserRiskArea;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        EXEC proc_ConvertAllDatetimeToDatetime2 BASE_HFit_HealthAssesmentUserRiskArea_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        EXEC proc_ConvertAllDatetimeToDatetime2 BASE_HFit_HealthAssesmentUserRiskCategory;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        EXEC proc_ConvertAllDatetimeToDatetime2 BASE_HFit_HealthAssesmentUserRiskCategory_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        EXEC proc_ConvertAllDatetimeToDatetime2 BASE_HFit_HealthAssesmentUserStarted;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        EXEC proc_ConvertAllDatetimeToDatetime2 BASE_HFit_HealthAssesmentUserStarted_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        EXEC proc_ConvertAllDatetimeToDatetime2 BASE_HFit_HealthAssessment;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        EXEC proc_ConvertAllDatetimeToDatetime2 BASE_HFit_HealthAssessment_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        EXEC proc_ConvertAllDatetimeToDatetime2 BASE_HFit_HealthAssessmentFreeForm;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        EXEC proc_ConvertAllDatetimeToDatetime2 BASE_HFit_HealthAssessmentFreeForm_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        EXEC proc_ConvertAllDatetimeToDatetime2 BASE_HFIT_LKP_EDW_REJECTMPI;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        EXEC proc_ConvertAllDatetimeToDatetime2 BASE_HFIT_LKP_EDW_REJECTMPI_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        EXEC proc_ConvertAllDatetimeToDatetime2 BASE_HFit_LKP_RewardActivity;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        EXEC proc_ConvertAllDatetimeToDatetime2 BASE_HFit_LKP_RewardActivity_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        EXEC proc_ConvertAllDatetimeToDatetime2 BASE_HFit_LKP_RewardLevelType;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        EXEC proc_ConvertAllDatetimeToDatetime2 BASE_HFit_LKP_RewardLevelType_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        EXEC proc_ConvertAllDatetimeToDatetime2 BASE_HFit_LKP_RewardTrigger;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        EXEC proc_ConvertAllDatetimeToDatetime2 BASE_HFit_LKP_RewardTrigger_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        EXEC proc_ConvertAllDatetimeToDatetime2 BASE_HFit_LKP_RewardTriggerParameterOperator;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        EXEC proc_ConvertAllDatetimeToDatetime2 BASE_HFit_LKP_RewardTriggerParameterOperator_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        EXEC proc_ConvertAllDatetimeToDatetime2 BASE_HFit_LKP_RewardType;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        EXEC proc_ConvertAllDatetimeToDatetime2 BASE_HFit_LKP_RewardType_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        EXEC proc_ConvertAllDatetimeToDatetime2 BASE_HFit_LKP_TrackerVendor;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        EXEC proc_ConvertAllDatetimeToDatetime2 BASE_HFit_LKP_TrackerVendor_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        EXEC proc_ConvertAllDatetimeToDatetime2 BASE_HFit_OutComeMessages;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        EXEC proc_ConvertAllDatetimeToDatetime2 BASE_HFit_OutComeMessages_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        EXEC proc_ConvertAllDatetimeToDatetime2 BASE_hfit_PPTEligibility;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        EXEC proc_ConvertAllDatetimeToDatetime2 BASE_hfit_PPTEligibility_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        EXEC proc_ConvertAllDatetimeToDatetime2 BASE_HFit_RewardActivity;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        EXEC proc_ConvertAllDatetimeToDatetime2 BASE_HFit_RewardActivity_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        EXEC proc_ConvertAllDatetimeToDatetime2 BASE_HFit_RewardException;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        EXEC proc_ConvertAllDatetimeToDatetime2 BASE_HFit_RewardException_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        EXEC proc_ConvertAllDatetimeToDatetime2 BASE_HFit_RewardGroup;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        EXEC proc_ConvertAllDatetimeToDatetime2 BASE_HFit_RewardGroup_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        EXEC proc_ConvertAllDatetimeToDatetime2 BASE_HFit_RewardLevel;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        EXEC proc_ConvertAllDatetimeToDatetime2 BASE_HFit_RewardLevel_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        EXEC proc_ConvertAllDatetimeToDatetime2 BASE_HFit_RewardProgram;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        EXEC proc_ConvertAllDatetimeToDatetime2 BASE_HFit_RewardProgram_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        EXEC proc_ConvertAllDatetimeToDatetime2 BASE_HFit_RewardsUserActivityDetail;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        EXEC proc_ConvertAllDatetimeToDatetime2 BASE_HFit_RewardsUserActivityDetail_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        EXEC proc_ConvertAllDatetimeToDatetime2 BASE_HFit_RewardsUserLevelDetail;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        EXEC proc_ConvertAllDatetimeToDatetime2 BASE_HFit_RewardsUserLevelDetail_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        EXEC proc_ConvertAllDatetimeToDatetime2 BASE_HFit_RewardTrigger;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        EXEC proc_ConvertAllDatetimeToDatetime2 BASE_HFit_RewardTrigger_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        EXEC proc_ConvertAllDatetimeToDatetime2 BASE_HFit_RewardTriggerParameter;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        EXEC proc_ConvertAllDatetimeToDatetime2 BASE_HFit_RewardTriggerParameter_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        EXEC proc_ConvertAllDatetimeToDatetime2 BASE_Hfit_SmallStepResponses;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        EXEC proc_ConvertAllDatetimeToDatetime2 BASE_Hfit_SmallStepResponses_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        EXEC proc_ConvertAllDatetimeToDatetime2 BASE_HFit_ToDoSmallSteps;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        EXEC proc_ConvertAllDatetimeToDatetime2 BASE_HFit_ToDoSmallSteps_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        EXEC proc_ConvertAllDatetimeToDatetime2 BASE_HFIT_Tracker;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        EXEC proc_ConvertAllDatetimeToDatetime2 BASE_HFIT_Tracker_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        EXEC proc_ConvertAllDatetimeToDatetime2 BASE_HFit_TrackerBloodPressure;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        EXEC proc_ConvertAllDatetimeToDatetime2 BASE_HFit_TrackerBloodPressure_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        EXEC proc_ConvertAllDatetimeToDatetime2 BASE_HFit_TrackerBloodSugarAndGlucose;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        EXEC proc_ConvertAllDatetimeToDatetime2 BASE_HFit_TrackerBloodSugarAndGlucose_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        EXEC proc_ConvertAllDatetimeToDatetime2 BASE_HFit_TrackerBMI;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        EXEC proc_ConvertAllDatetimeToDatetime2 BASE_HFit_TrackerBMI_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        EXEC proc_ConvertAllDatetimeToDatetime2 BASE_HFit_TrackerBodyFat;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        EXEC proc_ConvertAllDatetimeToDatetime2 BASE_HFit_TrackerBodyFat_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        EXEC proc_ConvertAllDatetimeToDatetime2 BASE_HFit_TrackerBodyMeasurements;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        EXEC proc_ConvertAllDatetimeToDatetime2 BASE_HFit_TrackerBodyMeasurements_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        EXEC proc_ConvertAllDatetimeToDatetime2 BASE_HFit_TrackerCardio_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        EXEC proc_ConvertAllDatetimeToDatetime2 BASE_HFit_TrackerCholesterol;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        EXEC proc_ConvertAllDatetimeToDatetime2 BASE_HFit_TrackerCholesterol_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        EXEC proc_ConvertAllDatetimeToDatetime2 BASE_HFit_TrackerCollectionSource;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        EXEC proc_ConvertAllDatetimeToDatetime2 BASE_HFit_TrackerCollectionSource_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        EXEC proc_ConvertAllDatetimeToDatetime2 BASE_HFit_TrackerCotinine;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        EXEC proc_ConvertAllDatetimeToDatetime2 BASE_HFit_TrackerCotinine_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        EXEC proc_ConvertAllDatetimeToDatetime2 BASE_HFit_TrackerDailySteps;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        EXEC proc_ConvertAllDatetimeToDatetime2 BASE_HFit_TrackerDailySteps_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        EXEC proc_ConvertAllDatetimeToDatetime2 BASE_HFit_TrackerDef_Tracker;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        EXEC proc_ConvertAllDatetimeToDatetime2 BASE_HFit_TrackerDef_Tracker_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        EXEC proc_ConvertAllDatetimeToDatetime2 BASE_HFit_TrackerFlexibility;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        EXEC proc_ConvertAllDatetimeToDatetime2 BASE_HFit_TrackerFlexibility_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        EXEC proc_ConvertAllDatetimeToDatetime2 BASE_HFit_TrackerFruits;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        EXEC proc_ConvertAllDatetimeToDatetime2 BASE_HFit_TrackerFruits_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        EXEC proc_ConvertAllDatetimeToDatetime2 BASE_HFit_TrackerHbA1c;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        EXEC proc_ConvertAllDatetimeToDatetime2 BASE_HFit_TrackerHbA1c_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        EXEC proc_ConvertAllDatetimeToDatetime2 BASE_HFit_TrackerHeight;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        EXEC proc_ConvertAllDatetimeToDatetime2 BASE_HFit_TrackerHeight_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        EXEC proc_ConvertAllDatetimeToDatetime2 BASE_HFit_TrackerHighFatFoods;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        EXEC proc_ConvertAllDatetimeToDatetime2 BASE_HFit_TrackerHighFatFoods_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        EXEC proc_ConvertAllDatetimeToDatetime2 BASE_HFit_TrackerHighSodiumFoods;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        EXEC proc_ConvertAllDatetimeToDatetime2 BASE_HFit_TrackerHighSodiumFoods_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        EXEC proc_ConvertAllDatetimeToDatetime2 BASE_HFit_TrackerInstance_Tracker;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        EXEC proc_ConvertAllDatetimeToDatetime2 BASE_HFit_TrackerInstance_Tracker_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        EXEC proc_ConvertAllDatetimeToDatetime2 BASE_HFit_TrackerMealPortions;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        EXEC proc_ConvertAllDatetimeToDatetime2 BASE_HFit_TrackerMealPortions_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        EXEC proc_ConvertAllDatetimeToDatetime2 BASE_HFit_TrackerMedicalCarePlan;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        EXEC proc_ConvertAllDatetimeToDatetime2 BASE_HFit_TrackerMedicalCarePlan_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        EXEC proc_ConvertAllDatetimeToDatetime2 BASE_HFit_TrackerPreventiveCare;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        EXEC proc_ConvertAllDatetimeToDatetime2 BASE_HFit_TrackerPreventiveCare_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        EXEC proc_ConvertAllDatetimeToDatetime2 BASE_HFit_TrackerRegularMeals;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        EXEC proc_ConvertAllDatetimeToDatetime2 BASE_HFit_TrackerRegularMeals_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        EXEC proc_ConvertAllDatetimeToDatetime2 BASE_HFit_TrackerRestingHeartRate;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        EXEC proc_ConvertAllDatetimeToDatetime2 BASE_HFit_TrackerRestingHeartRate_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        EXEC proc_ConvertAllDatetimeToDatetime2 BASE_HFit_TrackerShots;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        EXEC proc_ConvertAllDatetimeToDatetime2 BASE_HFit_TrackerShots_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        EXEC proc_ConvertAllDatetimeToDatetime2 BASE_HFit_TrackerSitLess;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        EXEC proc_ConvertAllDatetimeToDatetime2 BASE_HFit_TrackerSitLess_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        EXEC proc_ConvertAllDatetimeToDatetime2 BASE_HFit_TrackerSleepPlan;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        EXEC proc_ConvertAllDatetimeToDatetime2 BASE_HFit_TrackerSleepPlan_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        EXEC proc_ConvertAllDatetimeToDatetime2 BASE_HFit_TrackerStrength;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        EXEC proc_ConvertAllDatetimeToDatetime2 BASE_HFit_TrackerStrength_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        EXEC proc_ConvertAllDatetimeToDatetime2 BASE_HFit_TrackerStress;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        EXEC proc_ConvertAllDatetimeToDatetime2 BASE_HFit_TrackerStress_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        EXEC proc_ConvertAllDatetimeToDatetime2 BASE_HFit_TrackerStressManagement;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        EXEC proc_ConvertAllDatetimeToDatetime2 BASE_HFit_TrackerStressManagement_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        EXEC proc_ConvertAllDatetimeToDatetime2 BASE_HFit_TrackerSugaryDrinks;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        EXEC proc_ConvertAllDatetimeToDatetime2 BASE_HFit_TrackerSugaryDrinks_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        EXEC proc_ConvertAllDatetimeToDatetime2 BASE_HFit_TrackerSugaryFoods;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        EXEC proc_ConvertAllDatetimeToDatetime2 BASE_HFit_TrackerSugaryFoods_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        EXEC proc_ConvertAllDatetimeToDatetime2 BASE_HFit_TrackerTests;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        EXEC proc_ConvertAllDatetimeToDatetime2 BASE_HFit_TrackerTests_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        EXEC proc_ConvertAllDatetimeToDatetime2 BASE_HFit_TrackerTobaccoAttestation;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        EXEC proc_ConvertAllDatetimeToDatetime2 BASE_HFit_TrackerTobaccoAttestation_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        EXEC proc_ConvertAllDatetimeToDatetime2 BASE_HFit_TrackerTobaccoFree;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        EXEC proc_ConvertAllDatetimeToDatetime2 BASE_HFit_TrackerTobaccoFree_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        EXEC proc_ConvertAllDatetimeToDatetime2 BASE_HFit_TrackerVegetables;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        EXEC proc_ConvertAllDatetimeToDatetime2 BASE_HFit_TrackerVegetables_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        EXEC proc_ConvertAllDatetimeToDatetime2 BASE_HFit_TrackerWater;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        EXEC proc_ConvertAllDatetimeToDatetime2 BASE_HFit_TrackerWeight;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        EXEC proc_ConvertAllDatetimeToDatetime2 BASE_HFit_TrackerWeight_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        EXEC proc_ConvertAllDatetimeToDatetime2 BASE_HFit_TrackerWholeGrains;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        EXEC proc_ConvertAllDatetimeToDatetime2 BASE_HFit_TrackerWholeGrains_DEL;
    END;
IF
       @ProcessDatetime = 1
    BEGIN
        EXEC proc_ConvertAllDatetimeToDatetime2 BASE_view_EDW_TrackerCompositeDetails_CT_ONLY;
    END;