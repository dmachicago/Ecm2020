-- POSSIBLE SOLUTION TO RETRIEVING THE BMI CALCULATION
--****************************************************************************************************************

GO
PRINT 'Executing proc_Create_BMI_StagingData.sql';
GO

IF NOT EXISTS (SELECT
                      name
                      FROM sys.indexes
                      WHERE name = 'PI_55552_BmiXover') 
    BEGIN
        CREATE NONCLUSTERED INDEX PI_55552_BmiXover
        ON dbo.HFit_HealthAssesmentUserQuestion (CodeName) 
        INCLUDE (ItemID, UserID, HARiskAreaItemID) ;
    END;

IF NOT EXISTS (SELECT
                      name
                      FROM sys.indexes
                      WHERE name = 'PI_55552_BmiXover_Results') 
    BEGIN
        CREATE NONCLUSTERED INDEX PI_55552_BmiXover_Results
        ON dbo.HFit_HealthAssesmentUserQuestionGroupResults (CodeName) 
        INCLUDE (UserID, HARiskAreaItemID) ;
    END;

IF NOT EXISTS (SELECT
                      name
                      FROM sys.tables
                      WHERE name = 'BASE_BMI_DATA') 
    BEGIN
        CREATE TABLE dbo.BASE_BMI_DATA (
                     UserID bigint NOT NULL
                   , HFitUserMpiNumber bigint NULL
                   , Height nvarchar (255) NULL
                   , Weight nvarchar (255) NULL
                   , BMI float NULL
                   , HAStartedDT datetime NULL
                   , HACompetedDT datetime NULL
        );
    END;

IF NOT EXISTS (SELECT
                      name
                      FROM sys.indexes
                      WHERE name = 'PK_StagedBmiData') 
    BEGIN
        CREATE CLUSTERED INDEX PK_StagedBmiData ON dbo.BASE_BMI_DATA
        (
        UserID ASC,
        HFitUserMpiNumber ASC,
        BMI ASC
        )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];
    END;

truncate TABLE BASE_BMI_DATA;
-- select top 100 * from view_hfit_healthassesmentuserresponses
INSERT INTO BASE_BMI_DATA
SELECT  DISTINCT
       t1.UserID
     , US.HFitUserMpiNumber
     , t1.HAAnswerValue AS Height
     , t2.HAAnswerValue AS Weight
     , ROUND ( CAST (t2.HAAnswerValue AS float) * 703 / CAST (t1.HAAnswerValue AS float) * CAST (t1.HAAnswerValue AS float) , 1) AS BMI
     , t1.HAStartedDT
     , t1.HACompletedDT
       FROM
           CMS_USER AS U
               JOIN CMS_UserSettings AS US
                   ON U.UserID = US.UserSettingsID
               JOIN view_hfit_healthassesmentuserresponses AS t1
                   ON t1.UserID = U.UserID
               INNER JOIN view_hfit_healthassesmentuserresponses AS t2
                   ON t1.UserID = t2.UserID
                  AND t1.UserModuleItemID = t2.UserModuleItemID
       WHERE   t1.QuestionGroupCodeName = 'BMI'
           AND t1.UserQuestionCodeName = 'Height'
           AND t2.UserQuestionCodeName = 'Weight';
--****************************************************************************************************************
PRINT 'CREATING proc_Create_BMI_StagingData.sql';
GO

IF EXISTS (SELECT
                  name
                  FROM sys.procedures
                  WHERE name = 'proc_Create_BMI_StagingData') 
    BEGIN
        DROP PROCEDURE
             proc_Create_BMI_StagingData;
    END;
GO

-- exec proc_Create_BMI_StagingData
CREATE PROCEDURE proc_Create_BMI_StagingData
AS
BEGIN
    IF NOT EXISTS (SELECT
                          name
                          FROM sys.indexes
                          WHERE name = 'PI_55552_BmiXover') 
        BEGIN
            CREATE NONCLUSTERED INDEX PI_55552_BmiXover
            ON dbo.HFit_HealthAssesmentUserQuestion (CodeName) 
            INCLUDE (ItemID, UserID, HARiskAreaItemID) ;
        END;

    IF NOT EXISTS (SELECT
                          name
                          FROM sys.indexes
                          WHERE name = 'PI_55552_BmiXover_Results') 
        BEGIN
            CREATE NONCLUSTERED INDEX PI_55552_BmiXover_Results
            ON dbo.HFit_HealthAssesmentUserQuestionGroupResults (CodeName) 
            INCLUDE (UserID, HARiskAreaItemID) ;
        END;

    IF NOT EXISTS (SELECT
                          name
                          FROM sys.tables
                          WHERE name = 'BASE_BMI_DATA') 
        BEGIN
            CREATE TABLE dbo.BASE_BMI_DATA (
                         UserID bigint NOT NULL
                       , HFitUserMpiNumber bigint NULL
                       , Height nvarchar (255) NULL
                       , Weight nvarchar (255) NULL
                       , BMI float NULL
                       , HAStartedDT datetime NULL
                       , HACompetedDT datetime NULL
            );
        END;

    IF NOT EXISTS (SELECT
                          name
                          FROM sys.indexes
                          WHERE name = 'PK_StagedBmiData') 
        BEGIN
            CREATE CLUSTERED INDEX PK_StagedBmiData ON dbo.BASE_BMI_DATA
            (
            UserID ASC,
            HFitUserMpiNumber ASC,
            BMI ASC
            )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];
        END;

    truncate TABLE BASE_BMI_DATA;
    -- select top 1000 * from BASE_BMI_DATA
    INSERT INTO BASE_BMI_DATA
    SELECT  DISTINCT
           t1.UserID
         , US.HFitUserMpiNumber
         , t1.HAAnswerValue AS Height
         , t2.HAAnswerValue AS Weight
         , ROUND ( CAST (t2.HAAnswerValue AS float) * 703 / CAST (t1.HAAnswerValue AS float) * CAST (t1.HAAnswerValue AS float) , 1) AS BMI
         , t1.HAStartedDT
         , t1.HACompletedDT
           FROM
               CMS_USER AS U
                   JOIN CMS_UserSettings AS US
                       ON U.UserID = US.UserSettingsID
                   JOIN view_hfit_healthassesmentuserresponses AS t1
                       ON t1.UserID = U.UserID
                   INNER JOIN view_hfit_healthassesmentuserresponses AS t2
                       ON t1.UserID = t2.UserID
                      AND t1.UserModuleItemID = t2.UserModuleItemID
           WHERE   t1.QuestionGroupCodeName = 'BMI'
               AND t1.UserQuestionCodeName = 'Height'
               AND t2.UserQuestionCodeName = 'Weight';
END;
GO
PRINT 'Executed proc_Create_BMI_StagingData.sql';
GO
