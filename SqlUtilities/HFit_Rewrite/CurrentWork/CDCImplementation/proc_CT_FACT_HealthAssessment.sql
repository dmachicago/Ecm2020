
GO
PRINT 'Executing proc_CT_FACT_HealthAssessment.sql';
GO

IF EXISTS (SELECT
                  name
                  FROM sys.procedures
                  WHERE
                  name = 'proc_CT_FACT_HealthAssessment') 
    BEGIN
        PRINT 'UPDATING proc_CT_FACT_HealthAssessment.sql';
        DROP PROCEDURE
             proc_CT_FACT_HealthAssessment;
    END;
GO

/*--------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------
delete from FACT_EDW_HealthAssesment where  
select count(*) from FACT_EDW_HealthAssesment  
select count(*) from BASE_HFit_HealthAssesmentUserStarted
DBCC FREEPROCCACHE

update BASE_HFit_HealthAssesmentUserStarted set HAshCode = 'X' where ItemID in (select top 35000 ItemID from BASE_HFit_HealthAssesmentUserStarted)
exec proc_CT_FACT_HealthAssessment ;

select top 100 * from BASE_HFit_HealthAssesmentUserStarted
*/
CREATE PROCEDURE proc_CT_FACT_HealthAssessment
AS
BEGIN

    --SET TRANSACTION ISOLATION LEVEL SNAPSHOT;
    --truncate table FACT_EDW_HealthAssesment

    DECLARE
    @msg AS NVARCHAR (1000) = ''
  , @StepSecs AS BIGINT = 0
  , @TotalSecs AS BIGINT = 0
  , @StartTime AS DATETIME = GETDATE () 
  , @Step1Time AS DATETIME = GETDATE () 
  , @Step2Time AS DATETIME = GETDATE () 
  , @Step3Time AS DATETIME = GETDATE () 
  , @Step4Time AS DATETIME = GETDATE () 
  , @Step5Time AS DATETIME = GETDATE () 
  , @Step6Time AS DATETIME = GETDATE () 
  , @synchronization_version AS BIGINT = NULL
  , @LastVersion AS BIGINT = 0
  , @iCnt AS BIGINT = 0
  , @iChanges AS BIGINT = 0;

    SET @synchronization_version = CHANGE_TRACKING_CURRENT_VERSION () ;

    EXEC @LastVersion = proc_MASTER_LKP_CTVersion_Fetch 'BASE_HFit_HealthAssesmentUserStarted' , 'proc_CT_FACT_HealthAssessment';

    EXEC PrintImmediate 'Processing BASE_HFit_HealthAssesmentUserStarted';
    SET @msg = 'Pulling CT Version: ' + CAST (@LastVersion AS NVARCHAR (50)) ;
    EXEC PrintImmediate @msg;
    -- select * from information_schema.tables where table_name like '%small%'
    EXEC @iCnt = proc_QuickRowCount BASE_HFit_HealthAssesmentUserStarted;
    SET @msg = 'Total rows in Base Table: ' + CAST (@iCnt AS NVARCHAR (50)) ;
    EXEC PrintImmediate @msg;

    --******************************************************
    --CHECKPOINT;
    BEGIN TRY
        DROP TABLE
             #HAData;
    END TRY
    BEGIN CATCH
        EXEC printImmediate 'Loading temp table';
    END CATCH;
    SELECT
           ITEMID
         , SYS_CHANGE_VERSION
         , SYS_CHANGE_OPERATION
         , SYS_CHANGE_COLUMNS
         , SVR
         , DBNAME INTO
                       #HAData
           FROM CHANGETABLE (CHANGES BASE_HFit_HealthAssesmentUserStarted, @LastVersion) AS CT;

    CREATE CLUSTERED INDEX PK_TT ON #HAData (SVR , DBNAME , ItemID , SYS_CHANGE_OPERATION) ;
    -- select top 1000 * from #HAData where SYS_CHANGE_OPERATION != 'U'
    -- select distinct SYS_CHANGE_VERSION from CHANGETABLE (CHANGES BASE_HFit_HealthAssesmentUserStarted, 0) AS CT;

    SET @iChanges = (SELECT
                            COUNT (*) 
                            FROM #HAData);

    IF @iChanges < 10
        BEGIN
            --EXEC proc_MASTER_LKP_CTVersion_Update  'BASE_HFit_HealthAssesmentUserStarted', 'proc_CT_FACT_HealthAssessment' , @synchronization_version;
            PRINT 'No changes registered to process.';
        END;

    SET @msg = 'Starting Time: ' + CAST (GETDATE () AS NVARCHAR (50)) ;
    EXEC printImmediate @msg;

    SET @iCnt = (SELECT
                        COUNT (*) 
                        FROM FACT_EDW_HealthAssesment);

    IF
    @iChanges < 10
AND @iCnt > 0
        BEGIN
            --No changes found and RELOAD NOT needed. If reload needed, delete all entries for this table in the FACT table.
            EXEC proc_MASTER_LKP_CTVersion_Update  'BASE_HFit_HealthAssesmentUserStarted' , 'proc_CT_FACT_HealthAssessment' , @synchronization_version;
            PRINT 'No changes found to process, returning.';
            SET @msg = 'END Time: ' + CAST (GETDATE () AS NVARCHAR (50)) ;
            EXEC printImmediate @msg;
            RETURN;
        END;

    --If no records exists in the 
    IF @iCnt = 0
        BEGIN
            EXEC PrintImmediate 'RELOADING ALL RECORDS...';
            truncate TABLE #HAData;
            INSERT INTO #HAData (
                   ITEMID
                 , SYS_CHANGE_VERSION
                 , SYS_CHANGE_OPERATION
                 , SYS_CHANGE_COLUMNS
                 , SVR
                 , DBNAME) 
            SELECT
            --  'HFit_TrackerShots' AS AggregateTableName
                   ITEMID
          , 0 AS SYS_CHANGE_VERSION
          , 'I' AS SYS_CHANGE_OPERATION
          , NULL AS SYS_CHANGE_COLUMNS
          , SVR
          , DBNAME
                   FROM BASE_HFit_HealthAssesmentUserStarted;
        END;

    SET @iCnt = (SELECT
                        COUNT (*) 
                        FROM #HAData);
    SET @msg = 'Total Records to Process: ' + CAST (@iCnt AS NVARCHAR (50)) ;
    EXEC printImmediate @msg;

    --truncate table FACT_EDW_HealthAssesment
    SET @msg = 'STARTING Step 1 of 12: ';
    EXEC printImmediate @msg;
    --ADD/Insert the NEW records from the topmost table of Health Assessments
    INSERT INTO FACT_EDW_HealthAssesment
    (
           UserStartedItemID
         , UserID
         , HAStartedDt
         , HACompletedDt
         , HAScore
         , HAPaperFlg
         , HATelephonicFlg
         , HAStartedMode
         , HACompletedMode
         , CampaignNodeGUID
         , HealthAssessmentType
         , SVR
         , DBNAME
         , LastModifiedDate) 
    SELECT DISTINCT
           HAUserStarted.ItemID AS UserStartedItemID
         , HAUserStarted.UserID
         , CAST (HAUserStarted.HAStartedDt AS DATETIME) AS HAStartedDt
         , CAST (HAUserStarted.HACompletedDt AS DATETIME) AS HACompletedDt
         , HAUserStarted.HAScore
         , HAUserStarted.HAPaperFlg
         , HAUserStarted.HATelephonicFlg
         , HAUserStarted.HAStartedMode
         , HAUserStarted.HACompletedMode
         , HAUserStarted.HACampaignNodeGUID AS CampaignNodeGUID
         , CASE
           WHEN HAUserStarted.HADocumentConfigID IS NULL
                   THEN 'SHORT_VER'
           WHEN HAUserStarted.HADocumentConfigID IS NOT NULL
                   THEN 'LONG_VER'
               ELSE 'UNKNOWN'
           END AS HealthAssessmentType
         , HAUserStarted.SVR
         , HAUserStarted.DBNAME
         , HAUserStarted.LASTMODIFIEDDATE
           FROM BASE_HFit_HealthAssesmentUserStarted AS HAUserStarted
                    INNER JOIN #HAData AS TD
                        ON HAUserStarted.SVR = TD.SVR
                       AND HAUserStarted.DBNAME = TD.DBNAME
                       AND HAUserStarted.ItemID = TD.ItemID
                       AND TD.SYS_CHANGE_OPERATION = 'I';
    SET @iCnt = @@ROWCOUNT;

    SET @StepSecs = DATEDIFF (second , @StartTime , GETDATE ()) ;
    SET @msg = 'Step1 seconds: ' + CAST (@StepSecs as nvarchar (50)) + ' and INSERTED ' + CAST (@iCnt as nvarchar(50)) + ' new records.';
    EXEC printImmediate @msg;
    SET @Step2Time = GETDATE () ;
    --********************************************************************
    -- NOW, Step-by-step, update each row that has changed.
    --********************************************************************
SET @msg = 'STARTING Step 2 of 12: ';
    EXEC printImmediate @msg;
    --CHECKPOINT;
    UPDATE FT
           SET
               FT.UserGUID = CMSUser.UserGUID
             ,FT.HFitUserMpiNumber = UserSettings.HFitUserMpiNumber
               FROM FACT_EDW_HealthAssesment AS FT
                        INNER JOIN #HAData AS TD
                            ON
                            FT.SVR = TD.SVR
                        AND FT.DBNAME = TD.DBNAME
                        AND FT.UserStartedItemID = TD.ItemID
                        INNER JOIN dbo.BASE_CMS_User AS CMSUser
                            ON
                            FT.UserID = CMSUser.UserID
                        AND FT.SVR = CMSUser.SVR
                        AND FT.DBNAME = CMSUser.DBNAME
                        INNER JOIN dbo.BASE_CMS_UserSettings AS UserSettings
                            ON
                            UserSettings.SVR = CMSUser.SVR
                        AND UserSettings.DBNAME = CMSUser.DBNAME
                        AND UserSettings.UserSettingsUserID = CMSUser.UserID
                        AND UserSettings.HFitUserMpiNumber >= 0
                        AND UserSettings.HFitUserMpiNumber IS NOT NULL;
    SET @iCnt = @@ROWCOUNT;

    SET @StepSecs = DATEDIFF (second , @Step1Time , @Step2Time) ;
    SET @msg = 'Step2 seconds: ' + CAST (@StepSecs AS NVARCHAR (50)) + ' and Updated ' + CAST (@iCnt AS NVARCHAR (50)) + ' associated User Settings.';
    EXEC printImmediate @msg;
    SET @Step3Time = GETDATE () ;
    --******************************************************
SET @msg = 'STARTING Step 3 of 12: ';
    EXEC printImmediate @msg;
    --CHECKPOINT;
    BEGIN TRY
        DROP TABLE
             #SiteData;
    END TRY
    BEGIN CATCH
        EXEC printImmediate 'Loading Temp Site Data';
    END CATCH;
    -- select top 100 * from #SiteData order by UserID
    SELECT
           U.SVR
         , U.DBNAME
         , U.UserID
         , SiteGuid
         , U.SiteID
    INTO
         #SiteData
           FROM dbo.BASE_CMS_UserSite AS U
                    INNER JOIN dbo.BASE_CMS_Site AS CMSSite
                        ON U.SiteID = CMSSite.SiteID
                       AND U.SVR = CMSSite.SVR
                       AND U.DBNAME = CMSSite.DBNAME;

    CREATE INDEX PI_TempSiteData ON #SiteData (SVR , DBNAME , SiteID , UserID) INCLUDE (SiteGuid) ;

    UPDATE FT
           SET
               FT.SiteGUID = S.SiteGUID
             ,FT.SiteID = S.SiteID
               FROM FACT_EDW_HealthAssesment AS FT
                        INNER JOIN #HAData AS TD
                            ON
                            FT.SVR = TD.SVR
                        AND FT.DBNAME = TD.DBNAME
                        AND FT.UserStartedItemID = TD.ItemID
                        INNER JOIN #SiteData AS S
                            ON
                            FT.UserID = S.UserID
                        AND FT.SVR = S.SVR
                        AND FT.DBNAME = S.DBNAME;
    SET @iCnt = @@ROWCOUNT;

    SET @StepSecs = DATEDIFF (second , @Step2Time , @Step3Time) ;
    SET @msg = 'Step3 seconds: ' + CAST (@StepSecs AS NVARCHAR (50)) + ' and Updated ' + CAST (@iCnt AS NVARCHAR (50)) + ' associated User Settings.';
    EXEC printImmediate @msg;
    SET @Step4Time = GETDATE () ;
    --******************************************************
    SET @msg = 'STARTING Step 4 of 12: ';
    EXEC printImmediate @msg;
    UPDATE FT
           SET
               FT.AccountID = ACCT.AccountID
             ,FT.AccountCD = ACCT.AccountCD
             ,FT.AccountName = ACCT.AccountName
               FROM FACT_EDW_HealthAssesment AS FT
                        INNER JOIN #HAData AS TD
                            ON
                            FT.SVR = TD.SVR
                        AND FT.DBNAME = TD.DBNAME
                        AND FT.UserStartedItemID = TD.ItemID
                        INNER JOIN #SiteData AS S
                            ON
                            FT.UserID = S.UserID
                        AND Ft.SiteID = S.SiteID
                        AND FT.SVR = S.SVR
                        AND FT.DBNAME = S.DBNAME
                        INNER JOIN dbo.BASE_HFit_Account AS ACCT
                            ON
                            S.SiteID = ACCT.SiteID
                        AND FT.SVR = ACCT.SVR
                        AND FT.DBNAME = ACCT.DBNAME;
    SET @iCnt = @@ROWCOUNT;

    SET @StepSecs = DATEDIFF (second , @Step3Time , @Step4Time) ;
    SET @msg = 'Step4 seconds: ' + CAST (@StepSecs AS NVARCHAR (50)) + ' and Updated ' + CAST (@iCnt AS NVARCHAR (50)) + ' associated ACCT items.';

    EXEC printImmediate @msg;

    SET @Step5Time = GETDATE () ;
    --******************************************************
    SET @msg = 'STARTING Step 5 of 12: ';
    EXEC printImmediate @msg;    

    UPDATE FT
           SET
               FT.UserModuleItemId = HAUserModule.ItemID
             ,FT.UserModuleCodeName = HAUserModule.CodeName
             ,FT.HAModuleNodeGUID = HAUserModule.HAModuleNodeGUID
             ,FT.HAModuleScore = HAUserModule.HAModuleScore
             ,FT.ModulePreWeightedScore = HAUserModule.PreWeightedScore
               FROM FACT_EDW_HealthAssesment AS FT
                        INNER JOIN #HAData AS TD
                            ON
                            FT.SVR = TD.SVR
                        AND FT.DBNAME = TD.DBNAME
                        AND FT.UserStartedItemID = TD.ItemID
                        INNER JOIN dbo.BASE_HFit_HealthAssesmentUserModule AS HAUserModule
                            ON FT.UserStartedItemID = HAUserModule.HAStartedItemID
                           AND FT.SVR = HAUserModule.SVR
                           AND FT.DBNAME = HAUserModule.DBNAME;

    SET @StepSecs = DATEDIFF (second , @Step4Time , @Step5Time) ;
    SET @msg = 'Step5 seconds: ' + CAST (@StepSecs AS NVARCHAR (50)) ;
    SET @msg = 'Step5 seconds: ' + CAST (@StepSecs AS NVARCHAR (50)) + ' and Updated ' + CAST (@iCnt AS NVARCHAR (50)) + ' ROWS.';
    EXEC printImmediate @msg;

    SET @Step6Time = GETDATE () ;
    --******************************************************
SET @msg = 'STARTING Step 6 of 12: ';
    EXEC printImmediate @msg;
    BEGIN TRY
        DROP TABLE
             #VHCJ;
    END TRY
    BEGIN CATCH
        PRINT 'dropped #VHCJ ';
    END CATCH;
    SELECT
           NodeGUID
         , SVR
         , DBNAME
         , NodeSiteID
         , DocumentCulture
         , HealthAssessmentID  INTO
                                    #VHCJ
           FROM View_HFit_HACampaign_Joined;
    CREATE CLUSTERED INDEX PI_VHCJ ON #VHCJ (NodeGUID, SVR, DBNAME, NodeSiteID, DocumentCulture, HealthAssessmentID) ;

    -- select * from #VHAJ 
    BEGIN TRY
        DROP TABLE
             #VHAJ;
    END TRY
    BEGIN CATCH
        PRINT 'dropped #VHAJ ';
    END CATCH;
    SELECT
           NodeGUID
         , DocumentID
         , SVR
         , DBNAME
    INTO
         #VHAJ
           FROM View_HFit_HACampaign_Joined;
    CREATE CLUSTERED INDEX PI_VHAJ ON #VHAJ (NodeGUID , DocumentID, SVR, DBNAME) ;

    UPDATE FT
           SET
               FT.DocumentCulture_VHCJ = VHCJ.DocumentCulture
               FROM FACT_EDW_HealthAssesment AS FT
                        INNER JOIN #HAData AS TD
                            ON
                            FT.SVR = TD.SVR
                        AND FT.DBNAME = TD.DBNAME
                        AND FT.UserStartedItemID = TD.ItemID
                        INNER JOIN #VHCJ AS VHCJ
                            --View_HFit_HACampaign_Joined 
                            ON VHCJ.NodeGUID = FT.CampaignNodeGUID
                           AND VHCJ.SVR = FT.SVR
                           AND VHCJ.DBNAME = FT.DBNAME
                           AND VHCJ.NodeSiteID = FT.SiteID
                           AND VHCJ.DocumentCulture = 'en-US';

    SET @StepSecs = DATEDIFF (second , @Step5Time , @Step6Time) ;
    SET @msg = 'Step6 seconds: ' + CAST (@StepSecs AS NVARCHAR (50)) ;
    EXEC printImmediate @msg;
SET @msg = 'STARTING Step 7 of 12: ';
    EXEC printImmediate @msg;


    UPDATE FT
           SET
               ft.UserRiskCategoryItemID = HARiskCategory.ItemID
             ,fT.UserRiskCategoryCodeName = HARiskCategory.CodeName
             ,ft.HARiskCategoryNodeGUID = HARiskCategory.HARiskCategoryNodeGUID
             ,fT.HARiskCategoryScore = HARiskCategory.HARiskCategoryScore
             ,ft.RiskCategoryPreWeightedScore = HARiskCategory.PreWeightedScore
             ,FT.HARiskCategory_ItemModifiedWhen = HARiskCategory.ItemModifiedWhen
               FROM FACT_EDW_HealthAssesment AS FT
                        INNER JOIN #HAData AS TD
                            ON
                            FT.SVR = TD.SVR
                        AND FT.DBNAME = TD.DBNAME
                        AND FT.UserStartedItemID = TD.ItemID
                        INNER JOIN dbo.BASE_HFit_HealthAssesmentUserRiskCategory AS HARiskCategory
                            ON FT.UserModuleItemId = HARiskCategory.HAModuleItemID
                           AND FT.SVR = HARiskCategory.SVR
                           AND FT.DBNAME = HARiskCategory.DBNAME;
    SET @iCnt = @@ROWCOUNT;
    SET @StepSecs = DATEDIFF (second , @Step4Time , @Step5Time) ;
    SET @msg = 'Step7 seconds: ' + CAST (@StepSecs AS NVARCHAR (50)) + ' and Updated ' + CAST (@iCnt AS NVARCHAR (50)) + ' ROWS.';
    EXEC printImmediate @msg;
    --**************************************************************************************************
    SET @StepSecs = DATEDIFF (second , @Step5Time , @Step6Time) ;
    SET @msg = 'Step7 seconds: ' + CAST (@StepSecs AS NVARCHAR (50)) ;
    EXEC printImmediate @msg;
    SET @msg = 'STARTING Step 8 of 12: ';
    EXEC printImmediate @msg;

    UPDATE FT
           SET
               FT.UserRiskAreaItemID = HAUserRiskArea.ItemID
             ,FT.UserRiskAreaCodeName = HAUserRiskArea.CodeName
             ,FT.HARiskAreaNodeGUID = HAUserRiskArea.HARiskAreaNodeGUID
             ,FT.HARiskAreaScore = HAUserRiskArea.HARiskAreaScore
             ,FT.RiskAreaPreWeightedScore = HAUserRiskArea.PreWeightedScore
             ,FT.HAUserRiskArea_ItemModifiedWhen = CAST (HAUserRiskArea.ItemModifiedWhen AS DATETIME) 
               FROM FACT_EDW_HealthAssesment AS FT
                        INNER JOIN #HAData AS TD
                            ON FT.SVR = TD.SVR
                           AND FT.DBNAME = TD.DBNAME
                           AND FT.UserStartedItemID = TD.ItemID
                        INNER JOIN dbo.BASE_HFit_HealthAssesmentUserRiskArea AS HAUserRiskArea
                            ON FT.UserRiskCategoryItemID = HAUserRiskArea.HARiskCategoryItemID
                           AND FT.SVR = HAUserRiskArea.SVR
                           AND FT.DBNAME = HAUserRiskArea.DBNAME;

    SET @iCnt = @@ROWCOUNT;
    SET @StepSecs = DATEDIFF (second , @Step4Time , @Step5Time) ;
    SET @msg = 'Step8 seconds: ' + CAST (@StepSecs AS NVARCHAR (50)) + ' and Updated ' + CAST (@iCnt AS NVARCHAR (50)) + ' ROWS.';
    EXEC printImmediate @msg;
    --**************************************************************************************************
    SET @StepSecs = DATEDIFF (second , @Step5Time , @Step6Time) ;
    SET @msg = 'Step8 seconds: ' + CAST (@StepSecs AS NVARCHAR (50)) ;
    EXEC printImmediate @msg;
    SET @msg = 'STARTING Step 9 of 12: ';
    EXEC printImmediate @msg;

    UPDATE FT
           SET
               FT.UserQuestionItemID = HAUserQuestion.ItemID
             ,FT.HAQuestionGuid = HAUserQuestion.HAQuestionNodeGUID
             ,FT.UserQuestionCodeName = HAUserQuestion.CodeName
             ,FT.HAQuestionNodeGUID = HAUserQuestion.HAQuestionNodeGUID
             ,FT.HAQuestionScore = HAUserQuestion.HAQuestionScore
             ,FT.QuestionPreWeightedScore = HAUserQuestion.PreWeightedScore
             ,FT.IsProfessionallyCollected = HAUserQuestion.IsProfessionallyCollected
             ,FT.HAUserQuestion_ItemModifiedWhen = CAST (HAUserQuestion.ItemModifiedWhen AS DATETIME) 
               FROM FACT_EDW_HealthAssesment AS FT
                        INNER JOIN #HAData AS TD
                            ON FT.SVR = TD.SVR
                           AND FT.DBNAME = TD.DBNAME
                           AND FT.UserStartedItemID = TD.ItemID
                        INNER JOIN dbo.BASE_HFit_HealthAssesmentUserQuestion AS HAUserQuestion
                            ON FT.UserRiskAreaItemID = HAUserQuestion.HARiskAreaItemID
                           AND FT.SVR = HAUserQuestion.SVR
                           AND FT.DBNAME = HAUserQuestion.DBNAME;

    SET @iCnt = @@ROWCOUNT;
    SET @StepSecs = DATEDIFF (second , @Step4Time , @Step5Time) ;
    SET @msg = 'Step9 seconds: ' + CAST (@StepSecs AS NVARCHAR (50)) + ' and Updated ' + CAST (@iCnt AS NVARCHAR (50)) + ' ROWS.';
    EXEC printImmediate @msg;
    --**************************************************************************************************
    SET @StepSecs = DATEDIFF (second , @Step5Time , @Step6Time) ;
    SET @msg = 'Step9 seconds: ' + CAST (@StepSecs AS NVARCHAR (50)) ;
    EXEC printImmediate @msg;
SET @msg = 'STARTING Step 10 of 12: ';
    EXEC printImmediate @msg;
    

    UPDATE FT
           SET
               FT.Title = HAQuestionsView.Title
             ,FT.DocumentCulture_HAQuestionsView = HAQuestionsView.DocumentCulture
               FROM FACT_EDW_HealthAssesment AS FT
                        INNER JOIN #HAData AS TD
                            ON FT.SVR = TD.SVR
                           AND FT.DBNAME = TD.DBNAME
                           AND FT.UserStartedItemID = TD.ItemID
                        INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS HAQuestionsView
                            ON FT.HAQuestionNodeGUID = HAQuestionsView.NodeGUID
                           AND FT.SVR = HAQuestionsView.SVR
                           AND FT.DBNAME = HAQuestionsView.DBNAME
                           AND HAQuestionsView.DocumentCulture = 'en-US';

    SET @iCnt = @@ROWCOUNT;
    SET @StepSecs = DATEDIFF (second , @Step4Time , @Step5Time) ;
    SET @msg = 'Step10 seconds: ' + CAST (@StepSecs AS NVARCHAR (50)) + ' and Updated ' + CAST (@iCnt AS NVARCHAR (50)) + ' ROWS.';
    EXEC printImmediate @msg;
    --**************************************************************************************************
    
SET @msg = 'STARTING Step 11 of 12: ';
    EXEC printImmediate @msg;


    UPDATE FT
           SET
               FT.PointResults = HAUserQuestionGroupResults.PointResults
             ,FT.QuestionGroupCodeName = HAUserQuestionGroupResults.CodeName
               FROM FACT_EDW_HealthAssesment AS FT
                        INNER JOIN #HAData AS TD
                            ON FT.SVR = TD.SVR
                           AND FT.DBNAME = TD.DBNAME
                           AND FT.UserStartedItemID = TD.ItemID
                        LEFT OUTER JOIN dbo.FACT_EDW_HFit_HealthAssesmentUserQuestionGroupResults AS HAUserQuestionGroupResults
                            ON FT.UserRiskAreaItemID = HAUserQuestionGroupResults.HARiskAreaItemID
                           AND FT.SVR = HAUserQuestionGroupResults.SVR
                           AND FT.DBNAME = HAUserQuestionGroupResults.DBNAME;

    SET @iCnt = @@ROWCOUNT;
    SET @StepSecs = DATEDIFF (second , @Step4Time , @Step5Time) ;
    SET @msg = 'Step11 seconds: ' + CAST (@StepSecs AS NVARCHAR (50)) + ' and Updated ' + CAST (@iCnt AS NVARCHAR (50)) + ' rows.';
    EXEC printImmediate @msg;
    --**************************************************************************************************
    EXEC printImmediate 'Starting STEP 12';

    UPDATE FT
           SET
               FT.UserAnswerItemID = HAUserAnswers.ItemID
             ,FT.HAAnswerNodeGUID = HAUserAnswers.HAAnswerNodeGUID
             ,FT.HAAnswerVersionID = NULL
             ,FT.UserAnswerCodeName = HAUserAnswers.CodeName
             ,FT.HAAnswerValue = HAUserAnswers.HAAnswerValue
             ,FT.HAAnswerPoints = HAUserAnswers.HAAnswerPoints
             ,FT.UOMCode = HAUserAnswers.UOMCode
             ,FT.ChangeType = TD.SYS_CHANGE_OPERATION
             ,FT.ItemCreatedWhen = CAST (HAUserAnswers.ItemCreatedWhen AS DATETIME) 
             ,FT.ItemModifiedWhen = GETDATE () 
             ,FT.HAUserAnswers_ItemModifiedWhen = CAST (HAUserAnswers.ItemModifiedWhen AS DATETIME) 
               FROM FACT_EDW_HealthAssesment AS FT
                        INNER JOIN #HAData AS TD
                            ON FT.SVR = TD.SVR
                           AND FT.DBNAME = TD.DBNAME
                           AND FT.UserStartedItemID = TD.ItemID
                        INNER JOIN dbo.BASE_HFit_HealthAssesmentUserAnswers AS HAUserAnswers
                            ON FT.UserQuestionItemID = HAUserAnswers.HAQuestionItemID
                           AND FT.SVR = HAUserAnswers.SVR
                           AND FT.DBNAME = HAUserAnswers.DBNAME;

    SET @iCnt = @@ROWCOUNT;
    SET @StepSecs = DATEDIFF (second , @Step4Time , @Step5Time) ;
    SET @msg = 'Step12 seconds: ' + CAST (@StepSecs AS NVARCHAR (50)) + ' and Updated ' + CAST (@iCnt AS NVARCHAR (50)) + ' rows.';
    EXEC printImmediate @msg;
    --**************************************************************************************************
    SET @StepSecs = DATEDIFF (second , @StartTime , GETDATE ()) ;
    SET @msg = 'Total Time in seconds: ' + CAST (@StepSecs AS NVARCHAR (50)) ;
    EXEC printImmediate @msg;

    EXEC proc_MASTER_LKP_CTVersion_Update  'BASE_HFit_HealthAssesmentUserStarted' , 'proc_CT_FACT_HealthAssessment' , @synchronization_version;

    EXEC printImmediate 'Ending Time: ';
    PRINT GETDATE () ;
END;
GO
PRINT 'Executed proc_CT_FACT_HealthAssessment.sql';
GO
