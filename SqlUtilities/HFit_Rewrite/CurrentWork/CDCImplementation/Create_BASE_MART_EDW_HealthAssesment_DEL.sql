
GO
PRINT 'Executing Create_BASE_MART_EDW_HealthAssesment_DEL.sql';
GO
IF EXISTS (SELECT
                  name
           FROM sys.tables
           WHERE
                  name = 'BASE_MART_EDW_HealthAssesment_DEL') 
    BEGIN
        PRINT 'Table BASE_MART_EDW_HealthAssesment_DEL already exists, skipping.';
        GOTO OUTOFHERE_DEL;
    END;
CREATE TABLE dbo.BASE_MART_EDW_HealthAssesment_DEL (
             UserStartedItemID INT NOT NULL
           ,UserID INT NOT NULL
           ,UserGUID UNIQUEIDENTIFIER NOT NULL
           ,HFitUserMpiNumber INT NULL
           ,SiteGUID UNIQUEIDENTIFIER NOT NULL
           ,AccountID INT NOT NULL
           ,AccountCD NVARCHAR (8) NULL
           ,AccountName NVARCHAR (200) NULL
           ,HAStartedDt DATETIME2 (7) NOT NULL
           ,HACompletedDt DATETIME2 (7) NULL
           ,UserModuleItemId INT NOT NULL
           ,UserModuleCodeName NVARCHAR (100) NOT NULL
           ,HAModuleNodeGUID UNIQUEIDENTIFIER NOT NULL
           ,CMSNodeGuid UNIQUEIDENTIFIER NULL
           ,HAModuleVersionID INT NULL
           ,UserRiskCategoryItemID INT NOT NULL
           ,UserRiskCategoryCodeName NVARCHAR (100) NOT NULL
           ,HARiskCategoryNodeGUID UNIQUEIDENTIFIER NOT NULL
           ,HARiskCategoryVersionID INT NULL
           ,UserRiskAreaItemID INT NOT NULL
           ,UserRiskAreaCodeName NVARCHAR (100) NOT NULL
           ,HARiskAreaNodeGUID UNIQUEIDENTIFIER NOT NULL
           ,HARiskAreaVersionID INT NULL
           ,UserQuestionItemID INT NOT NULL
           ,Title NVARCHAR (MAX) NULL
           ,HAQuestionGuid UNIQUEIDENTIFIER NOT NULL
           ,UserQuestionCodeName NVARCHAR (100) NOT NULL
           ,HAQuestionDocumentID INT NULL
           ,HAQuestionVersionID INT NULL
           ,HAQuestionNodeGUID UNIQUEIDENTIFIER NOT NULL
           ,UserAnswerItemID INT NOT NULL
           ,HAAnswerNodeGUID UNIQUEIDENTIFIER NOT NULL
           ,HAAnswerVersionID INT NULL
           ,UserAnswerCodeName NVARCHAR (100) NOT NULL
           ,HAAnswerValue NVARCHAR (255) NULL
           ,HAModuleScore FLOAT NOT NULL
           ,HARiskCategoryScore FLOAT NULL
           ,HARiskAreaScore FLOAT NULL
           ,HAQuestionScore FLOAT NULL
           ,HAAnswerPoints INT NULL
           ,UOMCode NVARCHAR (10) NULL
           ,HAScore INT NULL
           ,ModulePreWeightedScore FLOAT NULL
           ,RiskCategoryPreWeightedScore FLOAT NULL
           ,RiskAreaPreWeightedScore FLOAT NULL
           ,QuestionPreWeightedScore FLOAT NULL
           ,ChangeType VARCHAR (1) NOT NULL
           ,ItemCreatedWhen DATETIME2 (7) NULL
           ,ItemModifiedWhen DATETIME2 (7) NULL
           ,IsProfessionallyCollected BIT NOT NULL
           ,HAPaperFlg BIT NOT NULL
           ,HATelephonicFlg BIT NOT NULL
           ,HAStartedMode INT NOT NULL
           ,HACompletedMode INT NOT NULL
           ,DocumentCulture_VHCJ NVARCHAR (10) NULL
           ,DocumentCulture_HAQuestionsView NVARCHAR (10) NULL
           ,CampaignNodeGUID UNIQUEIDENTIFIER NOT NULL
           ,HealthAssessmentType VARCHAR (9) NOT NULL
           ,HAUserStarted_LastModifiedDate DATETIME2 (7) NULL
           ,CMSUser_LastModifiedDate DATETIME2 (7) NULL
           ,UserSettings_LastModifiedDate DATETIME2 (7) NULL
           ,UserSite_LastModifiedDate DATETIME2 (7) NULL
           ,ACCT_LastModifiedDate DATETIME2 (7) NULL
           ,HAUserModule_LastModifiedDate DATETIME2 (7) NULL
           ,HARiskCategory_LastModifiedDate DATETIME2 (7) NULL
           ,HAUserRiskArea_LastModifiedDate DATETIME2 (7) NULL
           ,HAUserQuestion_LastModifiedDate DATETIME2 (7) NULL
           ,HAUserAnswers_LastModifiedDate DATETIME2 (7) NULL
           ,HealthAssesmentUserStartedNodeGUID UNIQUEIDENTIFIER NULL
           ,PointResults INT NULL
           ,QuestionGroupCodeName NVARCHAR (100) NULL
           ,CT_HAStartedMode BIT NULL
           ,CT_HATelephonicFlg BIT NULL
           ,CT_HADocumentConfigID BIT NULL
           ,CT_HFitUserMpiNumber BIT NULL
           ,CT_IsProfessionallyCollected BIT NULL
           ,CT_CodeName BIT NULL
           ,SurrogateKey_HFit_HealthAssesmentUserStarted BIGINT NOT NULL
           ,SurrogateKey_CMS_User BIGINT NOT NULL
           ,SurrogateKey_CMS_UserSettings BIGINT NOT NULL
           ,SurrogateKey_CMS_UserSite BIGINT NOT NULL
           ,SurrogateKey_CMS_Site BIGINT NOT NULL
           ,SurrogateKey_HFit_Account BIGINT NOT NULL
           ,SurrogateKey_HFit_HealthAssesmentUserModule BIGINT NOT NULL
           ,SurrogateKey_View_HFit_HACampaign_Joined BIGINT NOT NULL
           ,SurrogateKey_View_HFit_HealthAssessment_Joined BIGINT NOT NULL
           ,SurrogateKey_HFit_HealthAssesmentUserRiskCategory BIGINT NOT NULL
           ,SurrogateKey_HFit_HealthAssesmentUserRiskArea BIGINT NOT NULL
           ,SurrogateKey_HFit_HealthAssesmentUserQuestion BIGINT NOT NULL
           ,SurrogateKey_View_EDW_HealthAssesmentQuestions BIGINT NOT NULL
           ,SurrogateKey_HFit_HealthAssesmentUserAnswers BIGINT NOT NULL
           ,HARiskCategory_ItemModifiedWhen DATETIME2 (7) NULL
           ,HAUserRiskArea_ItemModifiedWhen DATETIME2 (7) NULL
           ,HAUserQuestion_ItemModifiedWhen DATETIME2 (7) NULL
           ,HAUserAnswers_ItemModifiedWhen DATETIME2 (7) NULL
           ,LastModifiedDate DATETIME2 (7) NULL
           ,RowDataChanged INT NOT NULL
           ,SVR NVARCHAR (100) NOT NULL
           ,DBNAME NVARCHAR (100) NOT NULL) 
ON [PRIMARY] TEXTIMAGE_ON [PRIMARY];

PRINT 'Created Table BASE_MART_EDW_HealthAssesment_DEL.';

OUTOFHERE_DEL:

GO
PRINT 'Executed Create_BASE_MART_EDW_HealthAssesment_DEL.sql';
GO
