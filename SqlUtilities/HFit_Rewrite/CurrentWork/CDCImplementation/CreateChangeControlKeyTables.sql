-- PROCESSING: CMS_Class

if exists (select name from sys.tables where name = 'CT_CMS_Class') 
BEGIN 
    drop table CT_CMS_Class; 
END 
--SELECT distinct CT.ClassID into CT_CMS_Class FROM CHANGETABLE(CHANGES [CMS_Class], NULL) AS CT; 
--ALTER TABLE [CT_CMS_Class] ADD  CONSTRAINT [PK_CT_CMS_Class] PRIMARY KEY CLUSTERED (	[ClassID] ASC ); 

-- PROCESSING: CMS_Document

if exists (select name from sys.tables where name = 'CT_CMS_Document') 
BEGIN 
    drop table CT_CMS_Document; 
END 
--SELECT distinct CT.DocumentID into CT_CMS_Document FROM CHANGETABLE(CHANGES [CMS_Document], NULL) AS CT; 
--ALTER TABLE [CT_CMS_Document] ADD  CONSTRAINT [PK_CT_CMS_Document] PRIMARY KEY CLUSTERED (	[DocumentID] ASC ); 

-- PROCESSING: CMS_Site

if exists (select name from sys.tables where name = 'CT_CMS_Site') 
BEGIN 
    drop table CT_CMS_Site; 
END 
--SELECT distinct CT.SiteID into CT_CMS_Site FROM CHANGETABLE(CHANGES [CMS_Site], NULL) AS CT; 
--ALTER TABLE [CT_CMS_Site] ADD  CONSTRAINT [PK_CT_CMS_Site] PRIMARY KEY CLUSTERED (	[SiteID] ASC ); 

-- PROCESSING: CMS_Tree

if exists (select name from sys.tables where name = 'CT_CMS_Tree') 
BEGIN 
    drop table CT_CMS_Tree; 
END 
--SELECT distinct CT.NodeID into CT_CMS_Tree FROM CHANGETABLE(CHANGES [CMS_Tree], NULL) AS CT; 
--ALTER TABLE [CT_CMS_Tree] ADD  CONSTRAINT [PK_CT_CMS_Tree] PRIMARY KEY CLUSTERED (	[NodeID] ASC ); 

-- PROCESSING: CMS_User

if exists (select name from sys.tables where name = 'CT_CMS_User') 
BEGIN 
    drop table CT_CMS_User; 
END 
--SELECT distinct CT.UserID into CT_CMS_User FROM CHANGETABLE(CHANGES [CMS_User], NULL) AS CT; 
--ALTER TABLE [CT_CMS_User] ADD  CONSTRAINT [PK_CT_CMS_User] PRIMARY KEY CLUSTERED (	[UserID] ASC ); 

-- PROCESSING: CMS_UserSettings

if exists (select name from sys.tables where name = 'CT_CMS_UserSettings') 
BEGIN 
    drop table CT_CMS_UserSettings; 
END 
--SELECT distinct CT.UserSettingsID into CT_CMS_UserSettings FROM CHANGETABLE(CHANGES [CMS_UserSettings], NULL) AS CT; 
--ALTER TABLE [CT_CMS_UserSettings] ADD  CONSTRAINT [PK_CT_CMS_UserSettings] PRIMARY KEY CLUSTERED (	[UserSettingsID] ASC ); 

-- PROCESSING: CMS_UserSite

if exists (select name from sys.tables where name = 'CT_CMS_UserSite') 
BEGIN 
    drop table CT_CMS_UserSite; 
END 
--SELECT distinct CT.UserSiteID into CT_CMS_UserSite FROM CHANGETABLE(CHANGES [CMS_UserSite], NULL) AS CT; 
--ALTER TABLE [CT_CMS_UserSite] ADD  CONSTRAINT [PK_CT_CMS_UserSite] PRIMARY KEY CLUSTERED (	[UserSiteID] ASC ); 

-- PROCESSING: COM_SKU

if exists (select name from sys.tables where name = 'CT_COM_SKU') 
BEGIN 
    drop table CT_COM_SKU; 
END 
--SELECT distinct CT.SKUID into CT_COM_SKU FROM CHANGETABLE(CHANGES [COM_SKU], NULL) AS CT; 
--ALTER TABLE [CT_COM_SKU] ADD  CONSTRAINT [PK_CT_COM_SKU] PRIMARY KEY CLUSTERED (	[SKUID] ASC ); 

-- PROCESSING: HFit_Account

if exists (select name from sys.tables where name = 'CT_HFit_Account') 
BEGIN 
    drop table CT_HFit_Account; 
END 
--SELECT distinct CT.AccountID into CT_HFit_Account FROM CHANGETABLE(CHANGES [HFit_Account], NULL) AS CT; 
--ALTER TABLE [CT_HFit_Account] ADD  CONSTRAINT [PK_CT_HFit_Account] PRIMARY KEY CLUSTERED (	[AccountID] ASC ); 

-- PROCESSING: HFit_HACampaign

if exists (select name from sys.tables where name = 'CT_HFit_HACampaign') 
BEGIN 
    drop table CT_HFit_HACampaign; 
END 
--SELECT distinct CT.HACampaignID into CT_HFit_HACampaign FROM CHANGETABLE(CHANGES [HFit_HACampaign], NULL) AS CT; 
--ALTER TABLE [CT_HFit_HACampaign] ADD  CONSTRAINT [PK_CT_HFit_HACampaign] PRIMARY KEY CLUSTERED (	[HACampaignID] ASC ); 

-- PROCESSING: HFit_HealthAssesmentMatrixQuestion

if exists (select name from sys.tables where name = 'CT_HFit_HealthAssesmentMatrixQuestion') 
BEGIN 
    drop table CT_HFit_HealthAssesmentMatrixQuestion; 
END 
--SELECT distinct CT.HealthAssesmentMultipleChoiceQuestionID into CT_HFit_HealthAssesmentMatrixQuestion FROM CHANGETABLE(CHANGES [HFit_HealthAssesmentMatrixQuestion], NULL) AS CT; 
--ALTER TABLE [CT_HFit_HealthAssesmentMatrixQuestion] ADD  CONSTRAINT [PK_CT_HFit_HealthAssesmentMatrixQuestion] PRIMARY KEY CLUSTERED (	[HealthAssesmentMultipleChoiceQuestionID] ASC ); 

-- PROCESSING: HFit_HealthAssesmentMultipleChoiceQuestion

if exists (select name from sys.tables where name = 'CT_HFit_HealthAssesmentMultipleChoiceQuestion') 
BEGIN 
    drop table CT_HFit_HealthAssesmentMultipleChoiceQuestion; 
END 
--SELECT distinct CT.HealthAssesmentMultipleChoiceQuestionID into CT_HFit_HealthAssesmentMultipleChoiceQuestion FROM CHANGETABLE(CHANGES [HFit_HealthAssesmentMultipleChoiceQuestion], NULL) AS CT; 
--ALTER TABLE [CT_HFit_HealthAssesmentMultipleChoiceQuestion] ADD  CONSTRAINT [PK_CT_HFit_HealthAssesmentMultipleChoiceQuestion] PRIMARY KEY CLUSTERED (	[HealthAssesmentMultipleChoiceQuestionID] ASC ); 

-- PROCESSING: HFit_HealthAssesmentUserAnswers

if exists (select name from sys.tables where name = 'CT_HFit_HealthAssesmentUserAnswers') 
BEGIN 
    drop table CT_HFit_HealthAssesmentUserAnswers; 
END 
--SELECT distinct CT.ItemID into CT_HFit_HealthAssesmentUserAnswers FROM CHANGETABLE(CHANGES [HFit_HealthAssesmentUserAnswers], NULL) AS CT; 
--ALTER TABLE [CT_HFit_HealthAssesmentUserAnswers] ADD  CONSTRAINT [PK_CT_HFit_HealthAssesmentUserAnswers] PRIMARY KEY CLUSTERED (	[ItemID] ASC ); 

-- PROCESSING: HFit_HealthAssesmentUserModule

if exists (select name from sys.tables where name = 'CT_HFit_HealthAssesmentUserModule') 
BEGIN 
    drop table CT_HFit_HealthAssesmentUserModule; 
END 
--SELECT distinct CT.ItemID 
--into CT_HFit_HealthAssesmentUserModule 
--FROM CHANGETABLE(CHANGES [HFit_HealthAssesmentUserModule], NULL) AS CT; 
--ALTER TABLE [CT_HFit_HealthAssesmentUserModule] ADD  CONSTRAINT [PK_CT_HFit_HealthAssesmentUserModule] PRIMARY KEY CLUSTERED (	[ItemID] ASC ); 

-- PROCESSING: HFit_HealthAssesmentUserQuestion

if exists (select name from sys.tables where name = 'CT_HFit_HealthAssesmentUserQuestion') 
BEGIN 
    drop table CT_HFit_HealthAssesmentUserQuestion; 
END 
--SELECT distinct CT.ItemID into CT_HFit_HealthAssesmentUserQuestion FROM CHANGETABLE(CHANGES [HFit_HealthAssesmentUserQuestion], NULL) AS CT; 
--ALTER TABLE [CT_HFit_HealthAssesmentUserQuestion] ADD  CONSTRAINT [PK_CT_HFit_HealthAssesmentUserQuestion] PRIMARY KEY CLUSTERED (	[ItemID] ASC ); 

-- PROCESSING: HFit_HealthAssesmentUserQuestionGroupResults

if exists (select name from sys.tables where name = 'CT_HFit_HealthAssesmentUserQuestionGroupResults') 
BEGIN 
    drop table CT_HFit_HealthAssesmentUserQuestionGroupResults; 
END 
--SELECT distinct CT.ItemID into CT_HFit_HealthAssesmentUserQuestionGroupResults FROM CHANGETABLE(CHANGES [HFit_HealthAssesmentUserQuestionGroupResults], NULL) AS CT; 
--ALTER TABLE [CT_HFit_HealthAssesmentUserQuestionGroupResults] ADD  CONSTRAINT [PK_CT_HFit_HealthAssesmentUserQuestionGroupResults] PRIMARY KEY CLUSTERED (	[ItemID] ASC ); 

-- PROCESSING: HFit_HealthAssesmentUserRiskArea

if exists (select name from sys.tables where name = 'CT_HFit_HealthAssesmentUserRiskArea') 
BEGIN 
    drop table CT_HFit_HealthAssesmentUserRiskArea; 
END 
--SELECT distinct CT.ItemID into CT_HFit_HealthAssesmentUserRiskArea FROM CHANGETABLE(CHANGES [HFit_HealthAssesmentUserRiskArea], NULL) AS CT; 
--ALTER TABLE [CT_HFit_HealthAssesmentUserRiskArea] ADD  CONSTRAINT [PK_CT_HFit_HealthAssesmentUserRiskArea] PRIMARY KEY CLUSTERED (	[ItemID] ASC ); 

-- PROCESSING: HFit_HealthAssesmentUserRiskCategory

if exists (select name from sys.tables where name = 'CT_HFit_HealthAssesmentUserRiskCategory') 
BEGIN 
    drop table CT_HFit_HealthAssesmentUserRiskCategory; 
END 
--SELECT distinct CT.ItemID into CT_HFit_HealthAssesmentUserRiskCategory FROM CHANGETABLE(CHANGES [HFit_HealthAssesmentUserRiskCategory], NULL) AS CT; 
--ALTER TABLE [CT_HFit_HealthAssesmentUserRiskCategory] ADD  CONSTRAINT [PK_CT_HFit_HealthAssesmentUserRiskCategory] PRIMARY KEY CLUSTERED (	[ItemID] ASC ); 

-- PROCESSING: HFit_HealthAssesmentUserStarted

if exists (select name from sys.tables where name = 'CT_HFit_HealthAssesmentUserStarted') 
BEGIN 
    drop table CT_HFit_HealthAssesmentUserStarted; 
END 
--SELECT distinct CT.ItemID into CT_HFit_HealthAssesmentUserStarted FROM CHANGETABLE(CHANGES [HFit_HealthAssesmentUserStarted], NULL) AS CT; 
--ALTER TABLE [CT_HFit_HealthAssesmentUserStarted] ADD  CONSTRAINT [PK_CT_HFit_HealthAssesmentUserStarted] PRIMARY KEY CLUSTERED (	[ItemID] ASC ); 

-- PROCESSING: HFit_HealthAssessment

if exists (select name from sys.tables where name = 'CT_HFit_HealthAssessment') 
BEGIN 
    drop table CT_HFit_HealthAssessment; 
END 
--SELECT distinct CT.HealthAssessmentID into CT_HFit_HealthAssessment FROM CHANGETABLE(CHANGES [HFit_HealthAssessment], NULL) AS CT; 
--ALTER TABLE [CT_HFit_HealthAssessment] ADD  CONSTRAINT [PK_CT_HFit_HealthAssessment] PRIMARY KEY CLUSTERED (	[HealthAssessmentID] ASC ); 

-- PROCESSING: HFit_HealthAssessmentFreeForm

if exists (select name from sys.tables where name = 'CT_HFit_HealthAssessmentFreeForm') 
BEGIN 
    drop table CT_HFit_HealthAssessmentFreeForm; 
END 
--SELECT distinct CT.HealthAssesmentMultipleChoiceQuestionID into CT_HFit_HealthAssessmentFreeForm FROM CHANGETABLE(CHANGES [HFit_HealthAssessmentFreeForm], NULL) AS CT; 
--ALTER TABLE [CT_HFit_HealthAssessmentFreeForm] ADD  CONSTRAINT [PK_CT_HFit_HealthAssessmentFreeForm] PRIMARY KEY CLUSTERED (	[HealthAssesmentMultipleChoiceQuestionID] ASC ); 

-- PROCESSING: HFit_LKP_EDW_RejectMPI

if exists (select name from sys.tables where name = 'CT_HFit_LKP_EDW_RejectMPI') 
BEGIN 
    drop table CT_HFit_LKP_EDW_RejectMPI; 
END 
--SELECT distinct CT.ItemID into CT_HFit_LKP_EDW_RejectMPI FROM CHANGETABLE(CHANGES [HFit_LKP_EDW_RejectMPI], NULL) AS CT; 
--ALTER TABLE [CT_HFit_LKP_EDW_RejectMPI] ADD  CONSTRAINT [PK_CT_HFit_LKP_EDW_RejectMPI] PRIMARY KEY CLUSTERED (	[ItemID] ASC ); 

