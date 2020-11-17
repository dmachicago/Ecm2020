
GO
PRINT 'create_TEMP_EDW_HealthAssessment_DATA.sql';
GO

IF EXISTS (SELECT
                  name
                  FROM sys.tables
                  WHERE name = 'TEMP_EDW_HealthAssessment_DATA') 
    BEGIN
        DROP TABLE
             dbo.TEMP_EDW_HealthAssessment_DATA
    END;

GO

CREATE TABLE dbo.TEMP_EDW_HealthAssessment_DATA (
		  SVR NVARCHAR (100) NULL
		  ,DBNAME NVARCHAR (100) NULL
           ,UserStartedItemID INT NULL
           ,HealthAssesmentUserStartedNodeGUID UNIQUEIDENTIFIER NULL
           ,UserID BIGINT NULL
           ,UserGUID UNIQUEIDENTIFIER NULL
           ,HFitUserMpiNumber BIGINT NULL
           ,SiteGUID UNIQUEIDENTIFIER NULL
           ,AccountID INT NULL
           ,AccountCD NVARCHAR (8) NULL
           ,AccountName NVARCHAR (200) NULL
           ,HAStartedDt DATETIME NULL
           ,HACompletedDt DATETIME NULL
           ,UserModuleItemId INT NULL
           ,UserModuleCodeName NVARCHAR (100) NULL
           ,HAModuleNodeGUID UNIQUEIDENTIFIER NULL
           ,CMSNodeGuid UNIQUEIDENTIFIER NULL
           ,HAModuleVersionID INT NULL
           ,UserRiskCategoryItemID INT NULL
           ,UserRiskCategoryCodeName NVARCHAR (100) NULL
           ,HARiskCategoryNodeGUID UNIQUEIDENTIFIER NULL
           ,HARiskCategoryVersionID INT NULL
           ,UserRiskAreaItemID INT NULL
           ,UserRiskAreaCodeName NVARCHAR (100) NULL
           ,HARiskAreaNodeGUID UNIQUEIDENTIFIER NULL
           ,HARiskAreaVersionID INT NULL
           ,UserQuestionItemID INT NULL
           ,Title VARCHAR (MAX) NULL
           ,HAQuestionGuid UNIQUEIDENTIFIER NULL
           ,UserQuestionCodeName NVARCHAR (100) NULL
           ,HAQuestionDocumentID INT NULL
           ,HAQuestionVersionID INT NULL
           ,HAQuestionNodeGUID UNIQUEIDENTIFIER NULL
           ,UserAnswerItemID INT NULL
           ,HAAnswerNodeGUID UNIQUEIDENTIFIER NULL
           ,HAAnswerVersionID INT NULL
           ,UserAnswerCodeName NVARCHAR (100) NULL
           ,HAAnswerValue NVARCHAR (255) NULL
           ,HAModuleScore FLOAT NULL
           ,HARiskCategoryScore FLOAT NULL
           ,HARiskAreaScore FLOAT NULL
           ,HAQuestionScore FLOAT NULL
           ,HAAnswerPoints INT NULL
           ,PointResults INT NULL
           ,UOMCode NVARCHAR (10) NULL
           ,HAScore INT NULL
           ,ModulePreWeightedScore FLOAT NULL
           ,RiskCategoryPreWeightedScore FLOAT NULL
           ,RiskAreaPreWeightedScore FLOAT NULL
           ,QuestionPreWeightedScore FLOAT NULL
           ,QuestionGroupCodeName NVARCHAR (100) NULL
           ,ItemCreatedWhen DATETIME NULL
           ,ItemModifiedWhen DATETIME NULL
           ,IsProfessionallyCollected BIT NULL
           ,HARiskCategory_ItemModifiedWhen DATETIME NULL
           ,HAUserRiskArea_ItemModifiedWhen DATETIME NULL
           ,HAUserQuestion_ItemModifiedWhen DATETIME NULL
           ,HAUserAnswers_ItemModifiedWhen DATETIME NULL
           ,HAPaperFlg BIT NULL
           ,HATelephonicFlg BIT NULL
           ,HAStartedMode INT NULL
           ,HACompletedMode INT NULL
           ,DocumentCulture_VHCJ NVARCHAR (10) NULL
           ,DocumentCulture_HAQuestionsView NVARCHAR (10) NULL
           ,CampaignNodeGUID UNIQUEIDENTIFIER NULL
           ,HACampaignID INT NULL
           ,HashCode VARCHAR (100) NULL
           ,ChangeType NCHAR (1) NULL
           ,CHANGED_FLG INT NULL
           ,DeleteFlg INT NULL
           ,CT_CMS_User_UserID INT NULL
           ,CT_CMS_User_CHANGE_OPERATION NCHAR (1) NULL
           ,CT_UserSettingsID INT NULL
           ,CT_UserSettingsID_CHANGE_OPERATION NCHAR (1) NULL
           ,SiteID_CtID INT NULL
           ,SiteID_CHANGE_OPERATION NCHAR (1) NULL
           ,UserSiteID_CtID INT NULL
           ,UserSiteID_CHANGE_OPERATION NCHAR (1) NULL
           ,AccountID_CtID INT NULL
           ,AccountID__CHANGE_OPERATION NCHAR (1) NULL
           ,HAUserAnswers_CtID INT NULL
           ,HAUserAnswers_CHANGE_OPERATION NCHAR (1) NULL
           ,HFit_HealthAssesmentUserModule_CtID INT NULL
           ,HFit_HealthAssesmentUserModule_CHANGE_OPERATION NCHAR (1) NULL
           ,HFit_HealthAssesmentUserQuestion_CtID INT NULL
           ,HFit_HealthAssesmentUserQuestion_CHANGE_OPERATION NCHAR (1) NULL
           ,HFit_HealthAssesmentUserQuestionGroupResults_CtID INT NULL
           ,HFit_HealthAssesmentUserQuestionGroupResults_CHANGE_OPERATION NCHAR (1) NULL
           ,HFit_HealthAssesmentUserRiskArea_CtID INT NULL
           ,HFit_HealthAssesmentUserRiskArea_CHANGE_OPERATION NCHAR (1) NULL
           ,HFit_HealthAssesmentUserRiskCategory_CtID INT NULL
           ,HFit_HealthAssesmentUserRiskCategory_CHANGE_OPERATION NCHAR (1) NULL
           ,HFit_HealthAssesmentUserStarted_CtID INT NULL
           ,HFit_HealthAssesmentUserStarted_CHANGE_OPERATION NCHAR (1) NULL
           ,CT_CMS_User_SCV BIGINT NULL
           ,CT_CMS_UserSettings_SCV BIGINT NULL
           ,CT_CMS_Site_SCV BIGINT NULL
           ,CT_CMS_UserSite_SCV BIGINT NULL
           ,CT_HFit_Account_SCV BIGINT NULL
           ,CT_HFit_HealthAssesmentUserAnswers_SCV BIGINT NULL
           ,CT_HFit_HealthAssesmentUserModule_SCV BIGINT NULL
           ,CT_HFit_HealthAssesmentUserQuestionGroupResults_SCV BIGINT NULL
           ,CT_HFit_HealthAssesmentUserRiskArea_SCV BIGINT NULL
           ,CT_HFit_HealthAssesmentUserRiskCategory_SCV BIGINT NULL
           ,CT_HFit_HealthAssesmentUserStarted_SCV BIGINT NULL
           ,CT_HFit_HealthAssesmentUserQuestion_SCV BIGINT NULL
           ,ConvertedToCentralTime BIT NULL
           ,LastModifiedDate DATETIME NULL
           ,RowNbr INT NULL
           ,DeletedFlg BIT NULL
           ,TimeZone NVARCHAR (10) NULL
           ,PKHashCode VARCHAR (100) NULL
) 
ON [PRIMARY] TEXTIMAGE_ON [PRIMARY];

GO

IF NOT EXISTS ( SELECT
                       name
                       FROM sys.indexes
                       WHERE name = 'Temp_PI_EDW_HealthAssessment_Dates') 
    BEGIN
        PRINT 'Adding INDEX Temp_PI_EDW_HealthAssessment_Dates at: ' + CAST ( GETDATE () AS NVARCHAR ( 50)) ;

        CREATE NONCLUSTERED INDEX Temp_PI_EDW_HealthAssessment_Dates ON dbo.TEMP_EDW_HealthAssessment_DATA (
	   SVR, DBNAME, ItemCreatedWhen ASC ,
        ItemModifiedWhen ASC) WITH ( PAD_INDEX = OFF , STATISTICS_NORECOMPUTE = OFF , SORT_IN_TEMPDB = OFF ,
        DROP_EXISTING = OFF , ONLINE = OFF ,
        ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ;
    END;

IF NOT EXISTS
( SELECT
         name
         FROM sys.indexes
         WHERE name = 'Temp_CI_EDW_HealthAssessment_NATKEY') 
    BEGIN
        PRINT 'Adding INDEX Temp_CI_EDW_HealthAssessment_NATKEY at: ' + CAST ( GETDATE () AS NVARCHAR ( 50)) ;
        CREATE nonclustered INDEX Temp_CI_EDW_HealthAssessment_NATKEY ON dbo.TEMP_EDW_HealthAssessment_DATA (
        SVR, DBNAME, UserStartedItemID
        , UserGUID)
        include( PKHashCode, DeletedFlg, LastModifiedDate);
    END;

--IF NOT EXISTS ( SELECT
--                       name
--                  FROM sys.indexes
--                  WHERE name = 'Temp_PI_EDW_HealthAssessment_IDs' )
--    BEGIN
--        EXEC PrintNow 'Adding INDEX Temp_PI_EDW_HealthAssessment_IDs';
--        CREATE INDEX Temp_PI_EDW_HealthAssessment_IDs ON dbo.[TEMP_EDW_HealthAssessment_DATA] (
--        UserStartedItemID
--        , HealthAssesmentUserStartedNodeGUID
--        , UserGUID
--        , SiteGUID
--        , AccountCD
--        , HAModuleNodeGUID
--        , CMSNodeGuid
--        , HARiskCategoryNodeGUID
--        , UserRiskAreaItemID
--        , HARiskAreaNodeGUID
--        , UserQuestionItemID
--        , HAQuestionGuid
--        , HAQuestionNodeGUID
--        , UserAnswerItemID
--        , HAAnswerNodeGUID
--        , CampaignNodeGUID
--        )
--        INCLUDE ( AccountID , UserModuleItemId , UserRiskCategoryItemID , DeletedFlg , HASHCODE , LastModifiedDate )
--        WITH ( PAD_INDEX = OFF , STATISTICS_NORECOMPUTE = OFF , SORT_IN_TEMPDB = OFF , DROP_EXISTING = OFF , ONLINE = OFF ,
--        ALLOW_ROW_LOCKS = ON ,
--        ALLOW_PAGE_LOCKS = ON );
--    END;
GO

GO
PRINT 'Created TEMP_EDW_HealthAssessment_DATA.sql';
GO
