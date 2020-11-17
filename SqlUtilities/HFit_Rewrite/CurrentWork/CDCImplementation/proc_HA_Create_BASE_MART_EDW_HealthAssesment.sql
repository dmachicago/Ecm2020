

GO
PRINT 'Executing proc_HA_Create_BASE_MART_EDW_HealthAssesment.sql';
GO

IF EXISTS (SELECT name
             FROM sys.procedures
             WHERE name = 'proc_HA_Create_BASE_MART_EDW_HealthAssesment') 
    BEGIN
        DROP PROCEDURE proc_HA_Create_BASE_MART_EDW_HealthAssesment
    END;

GO
-- exec proc_HA_Create_BASE_MART_EDW_HealthAssesment
CREATE PROCEDURE proc_HA_Create_BASE_MART_EDW_HealthAssesment
AS
BEGIN

    IF EXISTS (SELECT name
                 FROM sys.tables
                 WHERE name = 'BASE_MART_EDW_HealthAssesment') 
        BEGIN
            PRINT 'NOTICE: BASE_MART_EDW_HealthAssesment already exists, aborting.';
            RETURN;
        END;

    CREATE TABLE dbo.BASE_MART_EDW_HealthAssesment (UserStartedItemID int NOT NULL , 
                                                    UserID int NOT NULL , 
                                                    UserGUID uniqueidentifier NOT NULL , 
                                                    HFitUserMpiNumber int NULL , 
                                                    SiteGUID uniqueidentifier NOT NULL , 
                                                    AccountID int NOT NULL , 
                                                    AccountCD nvarchar (8) NULL , 
                                                    AccountName nvarchar (200) NULL , 
                                                    HAStartedDt datetime2 (7) NOT NULL , 
                                                    HACompletedDt datetime2 (7) NULL , 
                                                    UserModuleItemId int NOT NULL , 
                                                    UserModuleCodeName nvarchar (100) NOT NULL , 
                                                    HAModuleNodeGUID uniqueidentifier NOT NULL , 
                                                    CMSNodeGuid uniqueidentifier NULL , 
                                                    HAModuleVersionID int NULL , 
                                                    UserRiskCategoryItemID int NOT NULL , 
                                                    UserRiskCategoryCodeName nvarchar (100) NOT NULL , 
                                                    HARiskCategoryNodeGUID uniqueidentifier NOT NULL , 
                                                    HARiskCategoryVersionID int NULL , 
                                                    UserRiskAreaItemID int NOT NULL , 
                                                    UserRiskAreaCodeName nvarchar (100) NOT NULL , 
                                                    HARiskAreaNodeGUID uniqueidentifier NOT NULL , 
                                                    HARiskAreaVersionID int NULL , 
                                                    UserQuestionItemID int NOT NULL , 
                                                    Title nvarchar (max) NULL , 
                                                    HAQuestionGuid uniqueidentifier NOT NULL , 
                                                    UserQuestionCodeName nvarchar (100) NOT NULL , 
                                                    HAQuestionDocumentID int NULL , 
                                                    HAQuestionVersionID int NULL , 
                                                    HAQuestionNodeGUID uniqueidentifier NOT NULL , 
                                                    UserAnswerItemID int NOT NULL , 
                                                    HAAnswerNodeGUID uniqueidentifier NOT NULL , 
                                                    HAAnswerVersionID int NULL , 
                                                    UserAnswerCodeName nvarchar (100) NOT NULL , 
                                                    HAAnswerValue nvarchar (255) NULL , 
                                                    HAModuleScore float NOT NULL , 
                                                    HARiskCategoryScore float NULL , 
                                                    HARiskAreaScore float NULL , 
                                                    HAQuestionScore float NULL , 
                                                    HAAnswerPoints int NULL , 
                                                    UOMCode nvarchar (10) NULL , 
                                                    HAScore int NULL , 
                                                    ModulePreWeightedScore float NULL , 
                                                    RiskCategoryPreWeightedScore float NULL , 
                                                    RiskAreaPreWeightedScore float NULL , 
                                                    QuestionPreWeightedScore float NULL , 
                                                    ChangeType varchar (1) NOT NULL , 
                                                    ItemCreatedWhen datetime2 (7) NULL , 
                                                    ItemModifiedWhen datetime2 (7) NULL , 
                                                    IsProfessionallyCollected bit NOT NULL , 
                                                    HAPaperFlg bit NOT NULL , 
                                                    HATelephonicFlg bit NOT NULL , 
                                                    HAStartedMode int NOT NULL , 
                                                    HACompletedMode int NOT NULL , 
                                                    DocumentCulture_VHCJ nvarchar (10) NULL , 
                                                    DocumentCulture_HAQuestionsView nvarchar (10) NULL , 
                                                    CampaignNodeGUID uniqueidentifier NOT NULL , 
                                                    HealthAssessmentType varchar (9) NOT NULL , 
                                                    HAUserStarted_LastModifiedDate datetime2 (7) NULL , 
                                                    CMSUser_LastModifiedDate datetime2 (7) NULL , 
                                                    UserSettings_LastModifiedDate datetime2 (7) NULL , 
                                                    UserSite_LastModifiedDate datetime2 (7) NULL , 
                                                    ACCT_LastModifiedDate datetime2 (7) NULL , 
                                                    HAUserModule_LastModifiedDate datetime2 (7) NULL , 
                                                    HARiskCategory_LastModifiedDate datetime2 (7) NULL , 
                                                    HAUserRiskArea_LastModifiedDate datetime2 (7) NULL , 
                                                    HAUserQuestion_LastModifiedDate datetime2 (7) NULL , 
                                                    HAUserAnswers_LastModifiedDate datetime2 (7) NULL , 
                                                    HealthAssesmentUserStartedNodeGUID uniqueidentifier NULL , 
                                                    PointResults int NULL , 
                                                    QuestionGroupCodeName nvarchar (100) NULL , 
                                                    CT_HAStartedMode bit NULL , 
                                                    CT_HATelephonicFlg bit NULL , 
                                                    CT_HADocumentConfigID bit NULL , 
                                                    CT_HFitUserMpiNumber bit NULL , 
                                                    CT_IsProfessionallyCollected bit NULL , 
                                                    CT_CodeName bit NULL , 
                                                    SurrogateKey_HFit_HealthAssesmentUserStarted bigint NOT NULL , 
                                                    SurrogateKey_CMS_User bigint NOT NULL , 
                                                    SurrogateKey_CMS_UserSettings bigint NOT NULL , 
                                                    SurrogateKey_CMS_UserSite bigint NOT NULL , 
                                                    SurrogateKey_CMS_Site bigint NOT NULL , 
                                                    SurrogateKey_HFit_Account bigint NOT NULL , 
                                                    SurrogateKey_HFit_HealthAssesmentUserModule bigint NOT NULL , 
                                                    SurrogateKey_View_HFit_HACampaign_Joined bigint NOT NULL , 
                                                    SurrogateKey_View_HFit_HealthAssessment_Joined bigint NOT NULL , 
                                                    SurrogateKey_HFit_HealthAssesmentUserRiskCategory bigint NOT NULL , 
                                                    SurrogateKey_HFit_HealthAssesmentUserRiskArea bigint NOT NULL , 
                                                    SurrogateKey_HFit_HealthAssesmentUserQuestion bigint NOT NULL , 
                                                    SurrogateKey_View_EDW_HealthAssesmentQuestions bigint NOT NULL , 
                                                    SurrogateKey_HFit_HealthAssesmentUserAnswers bigint NOT NULL , 
                                                    HARiskCategory_ItemModifiedWhen datetime2 (7) NULL , 
                                                    HAUserRiskArea_ItemModifiedWhen datetime2 (7) NULL , 
                                                    HAUserQuestion_ItemModifiedWhen datetime2 (7) NULL , 
                                                    HAUserAnswers_ItemModifiedWhen datetime2 (7) NULL , 
                                                    LastModifiedDate datetime2 (7) NULL , 
                                                    RowDataChanged int NOT NULL , 
                                                    SVR nvarchar (100) NOT NULL , 
                                                    DBNAME nvarchar (100) NOT NULL) 
    ON [PRIMARY] TEXTIMAGE_ON [PRIMARY];
END;
GO
PRINT 'Executed proc_HA_Create_BASE_MART_EDW_HealthAssesment.sql';
GO

/*
	select 'If not exists (select name from sys.indexes where name = ''SK_MART_HA_' + column_name +''')' +char(10)+ 
	'create nonclustered index SK_MART_HA_' + column_name + ' on ' + TABLE_NAME + ' (' + column_name +')' +char(10)+ 'GO'
	from INFORMATION_SCHEMA.COLUMNS 
	where table_name = 'BASE_MART_EDW_HealthAssesment'
	and column_name like 'SurrogateKey_%'

		select 'If not exists (select name from sys.indexes where name = ''PI_MART_HA_' + column_name +''')' +char(10)+ 
	'create nonclustered index PI_MART_HA_' + column_name + ' on ' + TABLE_NAME + ' (' + column_name +')' +char(10)+ 'GO'
	from INFORMATION_SCHEMA.COLUMNS 
	where table_name = 'BASE_MART_EDW_HealthAssesment'
	and column_name like '%LastMod%'
*/

IF NOT EXISTS (SELECT name
                 FROM sys.indexes
                 WHERE name = 'SK_MART_HA_SurrogateKey_CMS_Site') 
    BEGIN
        CREATE NONCLUSTERED INDEX SK_MART_HA_SurrogateKey_CMS_Site ON BASE_MART_EDW_HealthAssesment (SurrogateKey_CMS_Site) 
    END;
GO
IF NOT EXISTS (SELECT name
                 FROM sys.indexes
                 WHERE name = 'SK_MART_HA_SurrogateKey_CMS_User') 
    BEGIN
        CREATE NONCLUSTERED INDEX SK_MART_HA_SurrogateKey_CMS_User ON BASE_MART_EDW_HealthAssesment (SurrogateKey_CMS_User) 
    END;
GO
IF NOT EXISTS (SELECT name
                 FROM sys.indexes
                 WHERE name = 'SK_MART_HA_SurrogateKey_CMS_UserSettings') 
    BEGIN
        CREATE NONCLUSTERED INDEX SK_MART_HA_SurrogateKey_CMS_UserSettings ON BASE_MART_EDW_HealthAssesment (SurrogateKey_CMS_UserSettings) 
    END;
GO
IF NOT EXISTS (SELECT name
                 FROM sys.indexes
                 WHERE name = 'SK_MART_HA_SurrogateKey_CMS_UserSite') 
    BEGIN
        CREATE NONCLUSTERED INDEX SK_MART_HA_SurrogateKey_CMS_UserSite ON BASE_MART_EDW_HealthAssesment (SurrogateKey_CMS_UserSite) 
    END;
GO
IF NOT EXISTS (SELECT name
                 FROM sys.indexes
                 WHERE name = 'SK_MART_HA_SurrogateKey_HFit_Account') 
    BEGIN
        CREATE NONCLUSTERED INDEX SK_MART_HA_SurrogateKey_HFit_Account ON BASE_MART_EDW_HealthAssesment (SurrogateKey_HFit_Account) 
    END;
GO
IF NOT EXISTS (SELECT name
                 FROM sys.indexes
                 WHERE name = 'SK_MART_HA_SurrogateKey_HFit_HealthAssesmentUserAnswers') 
    BEGIN
        CREATE NONCLUSTERED INDEX SK_MART_HA_SurrogateKey_HFit_HealthAssesmentUserAnswers ON BASE_MART_EDW_HealthAssesment (SurrogateKey_HFit_HealthAssesmentUserAnswers) 
    END;
GO
IF NOT EXISTS (SELECT name
                 FROM sys.indexes
                 WHERE name = 'SK_MART_HA_SurrogateKey_HFit_HealthAssesmentUserModule') 
    BEGIN
        CREATE NONCLUSTERED INDEX SK_MART_HA_SurrogateKey_HFit_HealthAssesmentUserModule ON BASE_MART_EDW_HealthAssesment (SurrogateKey_HFit_HealthAssesmentUserModule) 
    END;
GO
IF NOT EXISTS (SELECT name
                 FROM sys.indexes
                 WHERE name = 'SK_MART_HA_SurrogateKey_HFit_HealthAssesmentUserQuestion') 
    BEGIN
        CREATE NONCLUSTERED INDEX SK_MART_HA_SurrogateKey_HFit_HealthAssesmentUserQuestion ON BASE_MART_EDW_HealthAssesment (SurrogateKey_HFit_HealthAssesmentUserQuestion) 
    END;
GO
IF NOT EXISTS (SELECT name
                 FROM sys.indexes
                 WHERE name = 'SK_MART_HA_SurrogateKey_HFit_HealthAssesmentUserRiskArea') 
    BEGIN
        CREATE NONCLUSTERED INDEX SK_MART_HA_SurrogateKey_HFit_HealthAssesmentUserRiskArea ON BASE_MART_EDW_HealthAssesment (SurrogateKey_HFit_HealthAssesmentUserRiskArea) 
    END;
GO
IF NOT EXISTS (SELECT name
                 FROM sys.indexes
                 WHERE name = 'SK_MART_HA_SurrogateKey_HFit_HealthAssesmentUserRiskCategory') 
    BEGIN
        CREATE NONCLUSTERED INDEX SK_MART_HA_SurrogateKey_HFit_HealthAssesmentUserRiskCategory ON BASE_MART_EDW_HealthAssesment (SurrogateKey_HFit_HealthAssesmentUserRiskCategory) 
    END;
GO
IF NOT EXISTS (SELECT name
                 FROM sys.indexes
                 WHERE name = 'SK_MART_HA_SurrogateKey_HFit_HealthAssesmentUserStarted') 
    BEGIN
        CREATE NONCLUSTERED INDEX SK_MART_HA_SurrogateKey_HFit_HealthAssesmentUserStarted ON BASE_MART_EDW_HealthAssesment (SurrogateKey_HFit_HealthAssesmentUserStarted) 
    END;
GO
IF NOT EXISTS (SELECT name
                 FROM sys.indexes
                 WHERE name = 'SK_MART_HA_SurrogateKey_View_EDW_HealthAssesmentQuestions') 
    BEGIN
        CREATE NONCLUSTERED INDEX SK_MART_HA_SurrogateKey_View_EDW_HealthAssesmentQuestions ON BASE_MART_EDW_HealthAssesment (SurrogateKey_View_EDW_HealthAssesmentQuestions) 
    END;
GO
IF NOT EXISTS (SELECT name
                 FROM sys.indexes
                 WHERE name = 'SK_MART_HA_SurrogateKey_View_HFit_HACampaign_Joined') 
    BEGIN
        CREATE NONCLUSTERED INDEX SK_MART_HA_SurrogateKey_View_HFit_HACampaign_Joined ON BASE_MART_EDW_HealthAssesment (SurrogateKey_View_HFit_HACampaign_Joined) 
    END;
GO
IF NOT EXISTS (SELECT name
                 FROM sys.indexes
                 WHERE name = 'SK_MART_HA_SurrogateKey_View_HFit_HealthAssessment_Joined') 
    BEGIN
        CREATE NONCLUSTERED INDEX SK_MART_HA_SurrogateKey_View_HFit_HealthAssessment_Joined ON BASE_MART_EDW_HealthAssesment (SurrogateKey_View_HFit_HealthAssessment_Joined) 
    END;
GO

--***********************************************************
If not exists (select name from sys.indexes where name = 'PI_MART_HA_HAUserStarted_LastModifiedDate')
create nonclustered index PI_MART_HA_HAUserStarted_LastModifiedDate on BASE_MART_EDW_HealthAssesment (HAUserStarted_LastModifiedDate)
GO
If not exists (select name from sys.indexes where name = 'PI_MART_HA_CMSUser_LastModifiedDate')
create nonclustered index PI_MART_HA_CMSUser_LastModifiedDate on BASE_MART_EDW_HealthAssesment (CMSUser_LastModifiedDate)
GO
If not exists (select name from sys.indexes where name = 'PI_MART_HA_UserSettings_LastModifiedDate')
create nonclustered index PI_MART_HA_UserSettings_LastModifiedDate on BASE_MART_EDW_HealthAssesment (UserSettings_LastModifiedDate)
GO
If not exists (select name from sys.indexes where name = 'PI_MART_HA_UserSite_LastModifiedDate')
create nonclustered index PI_MART_HA_UserSite_LastModifiedDate on BASE_MART_EDW_HealthAssesment (UserSite_LastModifiedDate)
GO
If not exists (select name from sys.indexes where name = 'PI_MART_HA_ACCT_LastModifiedDate')
create nonclustered index PI_MART_HA_ACCT_LastModifiedDate on BASE_MART_EDW_HealthAssesment (ACCT_LastModifiedDate)
GO
If not exists (select name from sys.indexes where name = 'PI_MART_HA_HAUserModule_LastModifiedDate')
create nonclustered index PI_MART_HA_HAUserModule_LastModifiedDate on BASE_MART_EDW_HealthAssesment (HAUserModule_LastModifiedDate)
GO
If not exists (select name from sys.indexes where name = 'PI_MART_HA_HARiskCategory_LastModifiedDate')
create nonclustered index PI_MART_HA_HARiskCategory_LastModifiedDate on BASE_MART_EDW_HealthAssesment (HARiskCategory_LastModifiedDate)
GO
If not exists (select name from sys.indexes where name = 'PI_MART_HA_HAUserRiskArea_LastModifiedDate')
create nonclustered index PI_MART_HA_HAUserRiskArea_LastModifiedDate on BASE_MART_EDW_HealthAssesment (HAUserRiskArea_LastModifiedDate)
GO
If not exists (select name from sys.indexes where name = 'PI_MART_HA_HAUserQuestion_LastModifiedDate')
create nonclustered index PI_MART_HA_HAUserQuestion_LastModifiedDate on BASE_MART_EDW_HealthAssesment (HAUserQuestion_LastModifiedDate)
GO
If not exists (select name from sys.indexes where name = 'PI_MART_HA_HAUserAnswers_LastModifiedDate')
create nonclustered index PI_MART_HA_HAUserAnswers_LastModifiedDate on BASE_MART_EDW_HealthAssesment (HAUserAnswers_LastModifiedDate)
GO
If not exists (select name from sys.indexes where name = 'PI_MART_HA_LastModifiedDate')
create nonclustered index PI_MART_HA_LastModifiedDate on BASE_MART_EDW_HealthAssesment (LastModifiedDate)
GO