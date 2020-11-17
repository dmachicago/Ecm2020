
GO
PRINT 'Executing proc_CT_MASTER_HealthAssessment.sql';
GO

IF EXISTS (SELECT name
             FROM sys.procedures
             WHERE name = 'proc_CT_MASTER_HealthAssessment') 
    BEGIN
        PRINT 'UPDATING proc_CT_MASTER_HealthAssessment.sql';
        DROP PROCEDURE proc_CT_MASTER_HealthAssessment;
    END;
GO

/*-------------------------------------------------------------------------------------------------------------------------------------------------
delete from BASE_MART_EDW_HealthAssesment where  
select count(*) from BASE_MART_EDW_HealthAssesment  
select count(*) from BASE_HFit_HealthAssesmentUserStarted
DBCC FREEPROCCACHE

update BASE_HFit_HealthAssesmentUserStarted set HAshCode = 'X' where ItemID in (select top 35000 ItemID from BASE_HFit_HealthAssesmentUserStarted)
exec proc_CT_MASTER_HealthAssessment ;

select top 100 * from BASE_HFit_HealthAssesmentUserStarted
*/

CREATE PROCEDURE proc_CT_MASTER_HealthAssessment
AS
BEGIN

    --SET TRANSACTION ISOLATION LEVEL SNAPSHOT;
    --truncate table BASE_MART_EDW_HealthAssesment

    DECLARE
          @msg AS nvarchar (1000) = ''
         , @StepSecs AS bigint = 0
         , @TotalSecs AS bigint = 0
         , @StartTime AS datetime = GETDATE () 
         , @Step1Time AS datetime = GETDATE () 
         , @Step2Time AS datetime = GETDATE () 
         , @Step3Time AS datetime = GETDATE () 
         , @Step4Time AS datetime = GETDATE () 
         , @Step5Time AS datetime = GETDATE () 
         , @Step6Time AS datetime = GETDATE () 
	    , @StepStartTime AS datetime = GETDATE () 
         , @synchronization_version AS bigint = NULL
         , @LastVersionCMS1 AS bigint = 0
         , @LastVersionCMS2 AS bigint = 0
         , @LastVersionCMS3 AS bigint = 0
         , @CurrVersionCMS1 AS bigint = 0
         , @CurrVersionCMS2 AS bigint = 0
         , @CurrVersionCMS3 AS bigint = 0
         , @iCnt AS bigint = 0
         , @iChanges AS bigint = 0
         , @RunStartTime datetime
         , @LastFullUpdateDate datetime;
    
    DECLARE @T AS TABLE (DBNAME varchar (254) , VersionID bigint) ;

    SET @RunStartTime = GETDATE () ;
    SET @LastFullUpdateDate = (SELECT MAX (LastUpdate)
                                 FROM CT_MASTER_HA_UpdateHistory) ;
    IF @LastFullUpdateDate IS NULL
        BEGIN
            SET @LastFullUpdateDate = CAST ('01-01-1800' AS datetime) ;
            INSERT INTO CT_MASTER_HA_UpdateHistory (LastUpdate) 
            VALUES
                   (@LastFullUpdateDate) ;
        END;

    SET @synchronization_version = CHANGE_TRACKING_CURRENT_VERSION () ;


    INSERT INTO @T
    SELECT 'KenticoCMS_1' AS DBNAME
         , MAX (Ct.SYS_CHANGE_CREATION_VERSION)
      FROM CHANGETABLE (CHANGES KenticoCMS_1.dbo.HFit_HealthAssesmentUserStarted, 0) AS CT
    UNION ALL
    SELECT 'KenticoCMS_2' AS DBNAME
         , MAX (Ct.SYS_CHANGE_CREATION_VERSION)
      FROM CHANGETABLE (CHANGES KenticoCMS_2.dbo.HFit_HealthAssesmentUserStarted, 0) AS CT
    UNION ALL
    SELECT 'KenticoCMS_3' AS DBNAME
         , MAX (Ct.SYS_CHANGE_CREATION_VERSION)
      FROM CHANGETABLE (CHANGES KenticoCMS_3.dbo.HFit_HealthAssesmentUserStarted, 0) AS CT;

    SET @CurrVersionCMS1 = (SELECT VersionID
                              FROM @T
                              WHERE DBNAME = 'KenticoCMS_1') ;
    SET @CurrVersionCMS2 = (SELECT VersionID
                              FROM @T
                              WHERE DBNAME = 'KenticoCMS_2') ;
    SET @CurrVersionCMS3 = (SELECT VersionID
                              FROM @T
                              WHERE DBNAME = 'KenticoCMS_3') ;

    SET @LastVersionCMS1 = (SELECT MAX (VerNo)
                              FROM BASE_MART_EDW_HealthAssesment_VerHist
                              WHERE DBNAME = 'KenticoCMS_1') - 1;
    SET @LastVersionCMS2 = (SELECT MAX (VerNo)
                              FROM BASE_MART_EDW_HealthAssesment_VerHist
                              WHERE DBNAME = 'VerNo') - 1;
    SET @LastVersionCMS3 = (SELECT MAX (VerNo)
                              FROM BASE_MART_EDW_HealthAssesment_VerHist
                              WHERE DBNAME = 'KenticoCMS_3') - 1;

    IF @LastVersionCMS1 IS NULL
        BEGIN
            SET @LastVersionCMS1 = 0;
        END;
    IF @LastVersionCMS2 IS NULL
        BEGIN
            SET @LastVersionCMS2 = 0;
        END;
    IF @LastVersionCMS3 IS NULL
        BEGIN
            SET @LastVersionCMS3 = 0;
        END;

    EXEC @iCnt = proc_QuickRowCount BASE_HFit_HealthAssesmentUserStarted;
    SET @msg = 'Total rows in BASE_HFit_HealthAssesmentUserStarted: ' + CAST (@iCnt AS nvarchar (50)) ;
    EXEC PrintImmediate @msg;

    --******************************************************
    --CHECKPOINT;
    IF EXISTS (SELECT name
                 FROM sys.tables
                 WHERE name = 'TEMP_HA_Changes') 
        BEGIN
            DROP TABLE TEMP_HA_Changes
        END;
    SELECT ITEMID
         , SYS_CHANGE_VERSION
         , SYS_CHANGE_OPERATION
         , SYS_CHANGE_COLUMNS
         , 'KenticoCMS_1' AS SVR
         , 'KenticoCMS_1' AS DBNAME INTO TEMP_HA_Changes
      FROM CHANGETABLE (CHANGES KenticoCMS_1.dbo.HFit_HealthAssesmentUserStarted, @LastVersionCMS1) AS CT
    UNION ALL
    SELECT ITEMID
         , SYS_CHANGE_VERSION
         , SYS_CHANGE_OPERATION
         , SYS_CHANGE_COLUMNS
         , 'KenticoCMS_2' AS SVR
         , 'KenticoCMS_2' AS DBNAME -- INTO TEMP_HA_Changes
      FROM CHANGETABLE (CHANGES KenticoCMS_2.dbo.HFit_HealthAssesmentUserStarted, @LastVersionCMS2) AS CT
    UNION ALL
    SELECT ITEMID
         , SYS_CHANGE_VERSION
         , SYS_CHANGE_OPERATION
         , SYS_CHANGE_COLUMNS
         , 'KenticoCMS_3' AS SVR
         , 'KenticoCMS_3' AS DBNAME -- INTO TEMP_HA_Changes
      FROM CHANGETABLE (CHANGES KenticoCMS_3.dbo.HFit_HealthAssesmentUserStarted, @LastVersionCMS3) AS CT;

    CREATE INDEX PK_TT ON TEMP_HA_Changes (SVR, DBNAME) INCLUDE (ItemID, SYS_CHANGE_OPERATION) ;

    SET @iChanges = (SELECT COUNT (*)
                       FROM TEMP_HA_Changes) ;

    SET @msg = '#Changes to BASE HA: ' + CAST (@iChanges AS nvarchar (50)) ;
    EXEC printImmediate @msg;

    SET @msg = 'Starting Time: ' + CAST (GETDATE () AS nvarchar (50)) ;
    EXEC printImmediate @msg;

    SET @iCnt = (SELECT COUNT (*)
                   FROM BASE_MART_EDW_HealthAssesment) ;


    --If no records exists in the 
    IF @iCnt = 0
        BEGIN EXEC PrintImmediate 'RELOADING ALL RECORDS...';
            truncate TABLE TEMP_HA_Changes;
            INSERT INTO TEMP_HA_Changes (ITEMID
                                       , SYS_CHANGE_VERSION
                                       , SYS_CHANGE_OPERATION
                                       , SYS_CHANGE_COLUMNS
                                       , SVR
                                       , DBNAME) 
            SELECT ITEMID
                 , 0 AS SYS_CHANGE_VERSION
                 , 'I' AS SYS_CHANGE_OPERATION
                 , NULL AS SYS_CHANGE_COLUMNS
                 , SVR
                 , DBNAME
              FROM BASE_HFit_HealthAssesmentUserStarted;
        END;

    SET @iCnt = (SELECT COUNT (*)
                   FROM TEMP_HA_Changes) ;
    SET @msg = 'Total Records to Process: ' + CAST (@iCnt AS nvarchar (50)) ;
    EXEC printImmediate @msg;

    --truncate table BASE_MART_EDW_HealthAssesment
    SET @msg = 'STARTING Step 1 of 12: Adding new HAs';
    EXEC printImmediate @msg;

    --************************************************************************************
    -- REMOVE ALREADY EXISTING ITEMS FROM THE LIST OF INSERTS
    --************************************************************************************        
    DELETE H
      FROM TEMP_HA_Changes H
           JOIN
           BASE_HFit_HealthAssesmentUserStarted B
           ON B.DBNAME = H.DBNAME
          AND B.ItemID = H.ItemID;
    --AND B.SYS_CHANGE_OPERATION = 'I';
    SET @iCnt = @@ROWCOUNT;
    SET @msg = 'PREVIOUSLY INSERTED RECORDS: ' + CAST (@iCnt AS nvarchar (50)) + ' ignored.';
    EXEC printImmediate @msg;

    --************************************************************************************
    --Check for delted records and remove them from the MASTER HA table
    --************************************************************************************        
    exec proc_CT_MASTER_HA_VerifyDeletes; 

    --************************************************************************************
    --ADD/Insert the NEW records from the topmost table of Health Assessments
    --************************************************************************************        
    INSERT INTO BASE_MART_EDW_HealthAssesment (UserStartedItemID
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
    SELECT DISTINCT HAUserStarted.ItemID AS UserStartedItemID
                  , HAUserStarted.UserID
                  , CAST (HAUserStarted.HAStartedDt AS datetime) AS HAStartedDt
                  , CAST (HAUserStarted.HACompletedDt AS datetime) AS HACompletedDt
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
           INNER JOIN
           TEMP_HA_Changes AS TD
           ON HAUserStarted.SVR = TD.SVR
          AND HAUserStarted.DBNAME = TD.DBNAME
          AND HAUserStarted.ItemID = TD.ItemID
          AND TD.SYS_CHANGE_OPERATION = 'I';
    SET @iCnt = @@ROWCOUNT;

    SET @StepSecs = DATEDIFF (second, @StepStartTime, GETDATE ()) ;
    SET @msg = 'Step1 seconds: ' + CAST (@StepSecs AS nvarchar (50)) + ' and INSERTED ' + CAST (@iCnt AS nvarchar (50)) + ' new records.';
    EXEC printImmediate @msg;
    SET @Step2Time = GETDATE () ;
    --********************************************************************
    -- NOW, Step-by-step, update each row that has changed.
    --********************************************************************
    SET @StepStartTime = getdate() ;
    SET @msg = 'STARTING Step 2 of 12: update each row that has changed';
    EXEC printImmediate @msg;
    --*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
    exec @iCnt = proc_CT_MASTER_HA_UserSettingsUpdate @RunStartTime ;
    --*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
    SET @StepSecs = DATEDIFF (second, @StepStartTime, getdate()) ;
    SET @msg = 'Step2 seconds: ' + CAST (@StepSecs AS nvarchar (50)) + ' and Updated ' + CAST (@iCnt AS nvarchar (50)) + ' associated User Settings.';
    EXEC printImmediate @msg;
    SET @Step3Time = GETDATE () ;

    --******************************************************
    SET @StepStartTime = getdate() ;
    SET @msg = 'STARTING Step 3 of 12: Site Data';
    EXEC printImmediate @msg;
    -- -------------------------------------------------------
    exec @iCnt = proc_CT_MASTER_HA_UpdateSite @RunStartTime ;
    -- -------------------------------------------------------
    SET @StepSecs = DATEDIFF (second, @StepStartTime, getdate()) ;
    SET @msg = 'Step3 seconds: ' + CAST (@StepSecs AS nvarchar (50)) + ' and Updated ' + CAST (@iCnt AS nvarchar (50)) + ' associated User Settings.';
    EXEC printImmediate @msg;
    SET @Step4Time = GETDATE () ;
    
    --******************************************************
    SET @StepStartTime = getdate() ;
    SET @msg = 'STARTING Step 4 of 12: AccountUpdate';
    EXEC printImmediate @msg;
    -- -------------------------------------------------------
    EXEC @iCnt = proc_CT_MASTER_HA_AccountUpdate @RunStartTime ;
    -- -------------------------------------------------------  
    SET @StepSecs = DATEDIFF (second, @StepStartTime, getdate()) ;
    SET @msg = 'Step4 seconds: ' + CAST (@StepSecs AS nvarchar (50)) + ' and Updated ' + CAST (@iCnt AS nvarchar (50)) + ' associated ACCT items.';
    EXEC printImmediate @msg;

    SET @Step5Time = GETDATE () ;
    
    --******************************************************
    SET @StepStartTime = getdate() ;
    SET @msg = 'STARTING Step 5 of 12: UpdateHealthAssesmentUserModule ';
    EXEC printImmediate @msg;
    -- --------------------------------------------------------------------
    EXEC @iCnt = proc_CT_MASTER_HA_UpdateHealthAssesmentUserModule @RunStartTime ;
    -- --------------------------------------------------------------------
    SET @StepSecs = DATEDIFF (second, @StepStartTime, getdate()) ;
    SET @msg = 'Step5 seconds: ' + CAST (@StepSecs AS nvarchar (50)) + ' and Updated ' + CAST (@iCnt AS nvarchar (50)) + ' ROWS.';
    EXEC printImmediate @msg;
    SET @Step6Time = GETDATE () ;

    --******************************************************
    SET @StepStartTime = getdate() ;
    SET @msg = 'STARTING Step 6 of 12: UpdateDocumentCulture ';
    EXEC printImmediate @msg;
    -- --------------------------------------------------------------------
    exec @iCnt = proc_CT_MASTER_HA_UpdateDocumentCulture @RunStartTime ;
    -- --------------------------------------------------------------------
    SET @StepSecs = DATEDIFF (second, @StepStartTime, getdate()) ;
    SET @msg = 'Step6 seconds: ' + CAST (@StepSecs AS nvarchar (50)) ;
    EXEC printImmediate @msg;

    --****************************************************************************************************************
    SET @StepStartTime = getdate() ;
    SET @msg = 'STARTING Step 7 of 12: UpdateHARiskCategory ';
    EXEC printImmediate @msg;
    -- --------------------------------------------------------------------
    exec @iCnt = proc_CT_MASTER_HA_UpdateHARiskCategory @RunStartTime ;
    -- --------------------------------------------------------------------
    SET @StepSecs = DATEDIFF (second, @StepStartTime, getdate()) ;
    SET @msg = 'Step7 seconds: ' + CAST (@StepSecs AS nvarchar (50)) + ' and Updated ' + CAST (@iCnt AS nvarchar (50)) + ' ROWS.';
    EXEC printImmediate @msg;
    
    --**************************************************************************************************
    SET @StepStartTime = getdate() ;
    SET @msg = 'STARTING Step 8 of 12: HAUserRiskAreaUpdate';
    EXEC printImmediate @msg;
    -- ---------------------------------------------------------------------------
    exec @iCnt = proc_CT_MASTER_HA_HAUserRiskAreaUpdate @RunStartTime ;
    -- ---------------------------------------------------------------------------
    SET @StepSecs = DATEDIFF (second, @StepStartTime, getdate()) ;
    SET @msg = 'Step8 seconds: ' + CAST (@StepSecs AS nvarchar (50)) + ' and Updated ' + CAST (@iCnt AS nvarchar (50)) + ' ROWS.';
    EXEC printImmediate @msg;

    --**************************************************************************************************
    SET @StepStartTime = getdate() ;
    SET @msg = 'STARTING Step 9 of 12: HFit_HealthAssesmentUserQuestion';
    EXEC printImmediate @msg;
    -- ---------------------------------------------------------------------------
    exec @iCnt = proc_CT_MASTER_HA_HealthAssesmentUserQuestionUpdate @RunStartTime ;
    -- ---------------------------------------------------------------------------
    SET @StepSecs = DATEDIFF (second, @StepStartTime, getdate()) ;
    SET @msg = 'Step9 seconds: ' + CAST (@StepSecs AS nvarchar (50)) + ' and Updated ' + CAST (@iCnt AS nvarchar (50)) + ' ROWS.';
    EXEC printImmediate @msg;
    
    --**************************************************************************************************
    SET @StepStartTime = getdate() ;
    SET @msg = 'STARTING Step 10 of 12: HealthAssesmentQuestions';
    EXEC printImmediate @msg;
    -- ---------------------------------------------------------------------------
    exec @iCnt = proc_CT_MASTER_HA_HealthAssesmentQuestionsUpdate @RunStartTime ;
    -- ---------------------------------------------------------------------------
    SET @StepSecs = DATEDIFF (second, @StepStartTime, getdate()) ;
    SET @msg = 'Step10 seconds: ' + CAST (@StepSecs AS nvarchar (50)) + ' and Updated ' + CAST (@iCnt AS nvarchar (50)) + ' ROWS.';
    EXEC printImmediate @msg;

    --**************************************************************************************************
    SET @StepStartTime = getdate() ;
    SET @msg = 'STARTING Step 11 of 12: HFit_HealthAssesmentUserQuestionGroupResults';
    EXEC printImmediate @msg;
    -- ---------------------------------------------------------------------------------------
    exec @iCnt = proc_CT_MASTER_HA_HealthAssesmentUserQuestionGroupResultsUpdate @RunStartTime ;
    -- ---------------------------------------------------------------------------------------
    SET @StepSecs = DATEDIFF (second, @StepStartTime, getdate()) ;
    SET @msg = 'Step11 seconds: ' + CAST (@StepSecs AS nvarchar (50)) + ' and Updated ' + CAST (@iCnt AS nvarchar (50)) + ' rows.';
    EXEC printImmediate @msg;
    
    --**************************************************************************************************
    SET @StepStartTime = getdate() ;
    EXEC printImmediate 'Starting STEP 12: HFit_HealthAssesmentUserAnswers';
    -- ---------------------------------------------------------------------------------------
    exec @iCnt = proc_CT_MASTER_HA_HealthAssesmentUserAnswersUpdate @RunStartTime ;
    -- ---------------------------------------------------------------------------------------
    SET @StepSecs = DATEDIFF (second, @StepStartTime, getdate()) ;
    SET @msg = 'Step12 seconds: ' + CAST (@StepSecs AS nvarchar (50)) + ' and Updated ' + CAST (@iCnt AS nvarchar (50)) + ' rows.';
    EXEC printImmediate @msg;
    
    --**************************************************************************************************
    -- Add the NEW version number
    SET @StepStartTime = getdate() ;
    EXEC proc_ADD_EDW_HealthAssesment_VerHist 'KenticoCMS_1', @CurrVersionCMS1;
    EXEC proc_ADD_EDW_HealthAssesment_VerHist 'KenticoCMS_2', @CurrVersionCMS2;
    EXEC proc_ADD_EDW_HealthAssesment_VerHist 'KenticoCMS_3', @CurrVersionCMS3;
    INSERT INTO CT_MASTER_HA_UpdateHistory (LastUpdate)  VALUES (@RunStartTime) ;   
    EXEC proc_CT_MASTER_HA_RemoveDups ;
    SET @StepSecs = DATEDIFF (second, @StepStartTime, GETDATE ()) ;
    SET @msg = 'RemoveDups Time in seconds: ' + CAST (@StepSecs AS nvarchar (50)) ;
    EXEC printImmediate @msg;
    --**************************************************************************************************    

    SET @StepSecs = DATEDIFF (second, @StartTime, GETDATE ()) ;
    SET @msg = 'Total Time in seconds: ' + CAST (@StepSecs AS nvarchar (50)) ;
    EXEC printImmediate @msg;
    EXEC proc_MASTER_LKP_CTVersion_Update 'BASE_HFit_HealthAssesmentUserStarted', 'proc_CT_MASTER_HealthAssessment', @synchronization_version;
    
    
    EXEC printImmediate 'Ending Time: ';
    PRINT GETDATE () ;
END;
GO
PRINT 'Executed proc_CT_MASTER_HealthAssessment.sql';
GO
