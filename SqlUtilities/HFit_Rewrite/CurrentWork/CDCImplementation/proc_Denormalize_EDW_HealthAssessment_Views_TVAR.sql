
go
use KenticoCMS_DataMart

GO
PRINT 'Creating proc_Denormalize_EDW_HealthAssessment_Views_TVAR.sql';
GO

-- select count(*) from BASE_HFit_HealthAssesmentUserAnswers

IF EXISTS ( SELECT
                   name
                   FROM sys.procedures
                   WHERE name = 'proc_Denormalize_EDW_HealthAssessment_Views_TVAR') 
    BEGIN
        DROP PROCEDURE
             proc_Denormalize_EDW_HealthAssessment_Views_TVAR;
    END;

-- exec proc_Denormalize_EDW_HealthAssessment_Views_TVAR

GO
CREATE PROCEDURE proc_Denormalize_EDW_HealthAssessment_Views_TVAR
AS
BEGIN

/*-----------------------------------------------------------
******************************************************
------------------------------------------------------
Author:	  W. Dale Miller
Created:	  06.15.2015
USE:		  exec proc_Denormalize_EDW_HealthAssessment_Views_TVAR
******************************************************
*/

    DECLARE
    @ST AS datetime = GETDATE () ;
    PRINT 'TempData Started: ';
    PRINT CHAR ( 10) ;
    PRINT GETDATE () ;
    PRINT CHAR ( 10) ;
    SET NOCOUNT ON;

    --**************** TEMP TABLES Start*************************************    
    DECLARE
    @BASE_HFit_HealthAssesmentUserAnswers
    TABLE
    (
          ItemID int  NOT NULL
        , UserID bigint  NOT NULL
        , HAAnswerPoints int  NULL
        , ItemCreatedBy int  NULL
        , ItemCreatedWhen datetime  NULL
        , ItemModifiedBy int  NULL
        , ItemModifiedWhen datetime  NULL
        , ItemOrder int  NULL
        , ItemGUID uniqueidentifier  NOT NULL
        , HAAnswerValue nvarchar (255) NULL
        , HAQuestionItemID int  NOT NULL
        , UOMCode nvarchar (10) NULL
        , CodeName nvarchar (100) NOT NULL
        , HAAnswerNodeGUID uniqueidentifier  NOT NULL
        , HAQuestionDocumentID_old int  NOT NULL
        , HAAnswerDocumentID_old int  NOT NULL
        , HAAnswerVersionID_old bigint  NULL
          PRIMARY KEY ( ItemID , HAQuestionItemID) 
    );

    INSERT INTO @BASE_HFit_HealthAssesmentUserAnswers
    (
           ItemID
         , UserID
         , HAAnswerPoints
         , ItemCreatedBy
         , ItemCreatedWhen
         , ItemModifiedBy
         , ItemModifiedWhen
         , ItemOrder
         , ItemGUID
         , HAAnswerValue
         , HAQuestionItemID
         , UOMCode
         , CodeName
         , HAAnswerNodeGUID
         , HAQuestionDocumentID_old
         , HAAnswerDocumentID_old
         , HAAnswerVersionID_old) 
    SELECT
           BASE_HFit_HealthAssesmentUserAnswers.ItemID
         , BASE_HFit_HealthAssesmentUserAnswers.UserID
         , BASE_HFit_HealthAssesmentUserAnswers.HAAnswerPoints
         , BASE_HFit_HealthAssesmentUserAnswers.ItemCreatedBy
         , BASE_HFit_HealthAssesmentUserAnswers.ItemCreatedWhen
         , BASE_HFit_HealthAssesmentUserAnswers.ItemModifiedBy
         , BASE_HFit_HealthAssesmentUserAnswers.ItemModifiedWhen
         , BASE_HFit_HealthAssesmentUserAnswers.ItemOrder
         , BASE_HFit_HealthAssesmentUserAnswers.ItemGUID
         , BASE_HFit_HealthAssesmentUserAnswers.HAAnswerValue
         , BASE_HFit_HealthAssesmentUserAnswers.HAQuestionItemID
         , BASE_HFit_HealthAssesmentUserAnswers.UOMCode
         , BASE_HFit_HealthAssesmentUserAnswers.CodeName
         , BASE_HFit_HealthAssesmentUserAnswers.HAAnswerNodeGUID
         , BASE_HFit_HealthAssesmentUserAnswers.HAQuestionDocumentID_old
         , BASE_HFit_HealthAssesmentUserAnswers.HAAnswerDocumentID_old
         , BASE_HFit_HealthAssesmentUserAnswers.HAAnswerVersionID_old
           FROM dbo.BASE_HFit_HealthAssesmentUserAnswers;

    DECLARE
    @BASE_HFIT_HEALTHASSESMENTUSERRISKAREA
    TABLE
    (
          ItemID int  NOT NULL
        , UserID bigint  NOT NULL
        , HARiskAreaWeight int  NOT NULL
        , HARiskAreaScore float  NULL
        , ItemCreatedBy int  NULL
        , ItemCreatedWhen datetime  NULL
        , ItemModifiedBy int  NULL
        , ItemModifiedWhen datetime  NULL
        , ItemOrder int  NULL
        , ItemGUID uniqueidentifier  NOT NULL
        , HARiskCategoryItemID int  NOT NULL
        , CodeName nvarchar (100) NOT NULL
        , PreWeightedScore float  NULL
        , HARiskCategoryDocumentID_old int  NOT NULL
        , HARiskAreaNodeGUID uniqueidentifier  NOT NULL
        , HARiskAreaDocumentID_old int  NOT NULL
        , HARiskAreaVersionID_old bigint  NULL
          PRIMARY KEY ( ItemID , HARiskCategoryItemID) 
    );
    INSERT INTO @BASE_HFIT_HEALTHASSESMENTUSERRISKAREA
    (
           ItemID
         , UserID
         , HARiskAreaWeight
         , HARiskAreaScore
         , ItemCreatedBy
         , ItemCreatedWhen
         , ItemModifiedBy
         , ItemModifiedWhen
         , ItemOrder
         , ItemGUID
         , HARiskCategoryItemID
         , CodeName
         , PreWeightedScore
         , HARiskCategoryDocumentID_old
         , HARiskAreaNodeGUID
         , HARiskAreaDocumentID_old
         , HARiskAreaVersionID_old) 
    SELECT
           BASE_HFIT_HEALTHASSESMENTUSERRISKAREA.ItemID
         , BASE_HFIT_HEALTHASSESMENTUSERRISKAREA.UserID
         , BASE_HFIT_HEALTHASSESMENTUSERRISKAREA.HARiskAreaWeight
         , BASE_HFIT_HEALTHASSESMENTUSERRISKAREA.HARiskAreaScore
         , BASE_HFIT_HEALTHASSESMENTUSERRISKAREA.ItemCreatedBy
         , BASE_HFIT_HEALTHASSESMENTUSERRISKAREA.ItemCreatedWhen
         , BASE_HFIT_HEALTHASSESMENTUSERRISKAREA.ItemModifiedBy
         , BASE_HFIT_HEALTHASSESMENTUSERRISKAREA.ItemModifiedWhen
         , BASE_HFIT_HEALTHASSESMENTUSERRISKAREA.ItemOrder
         , BASE_HFIT_HEALTHASSESMENTUSERRISKAREA.ItemGUID
         , BASE_HFIT_HEALTHASSESMENTUSERRISKAREA.HARiskCategoryItemID
         , BASE_HFIT_HEALTHASSESMENTUSERRISKAREA.CodeName
         , BASE_HFIT_HEALTHASSESMENTUSERRISKAREA.PreWeightedScore
         , BASE_HFIT_HEALTHASSESMENTUSERRISKAREA.HARiskCategoryDocumentID_old
         , BASE_HFIT_HEALTHASSESMENTUSERRISKAREA.HARiskAreaNodeGUID
         , BASE_HFIT_HEALTHASSESMENTUSERRISKAREA.HARiskAreaDocumentID_old
         , BASE_HFIT_HEALTHASSESMENTUSERRISKAREA.HARiskAreaVersionID_old
           FROM dbo.BASE_HFIT_HEALTHASSESMENTUSERRISKAREA;

    DECLARE
    @FACT_EDW_HFit_HealthAssesmentUserQuestionGroupResults
    TABLE
    (
          ItemID int  NOT NULL
        , UserID int  NOT NULL
        , PointResults int  NOT NULL
        , ItemCreatedBy int  NULL
        , ItemCreatedWhen datetime  NULL
        , ItemModifiedBy int  NULL
        , ItemModifiedWhen datetime  NULL
        , ItemGUID uniqueidentifier  NOT NULL
        , HARiskAreaItemID int  NOT NULL
        , FormulaResult float  NULL
        , CodeName nvarchar (100) NOT NULL
          PRIMARY KEY (  ItemID , PointResults , CodeName , HARiskAreaItemID) 
    );
    INSERT INTO @FACT_EDW_HFit_HealthAssesmentUserQuestionGroupResults
    (
           ItemID
         , UserID
         , PointResults
         , ItemCreatedBy
         , ItemCreatedWhen
         , ItemModifiedBy
         , ItemModifiedWhen
         , ItemGUID
         , HARiskAreaItemID
         , FormulaResult
         , CodeName) 
    SELECT
           FACT_EDW_HFit_HealthAssesmentUserQuestionGroupResults.ItemID
         , FACT_EDW_HFit_HealthAssesmentUserQuestionGroupResults.UserID
         , FACT_EDW_HFit_HealthAssesmentUserQuestionGroupResults.PointResults
         , FACT_EDW_HFit_HealthAssesmentUserQuestionGroupResults.ItemCreatedBy
         , FACT_EDW_HFit_HealthAssesmentUserQuestionGroupResults.ItemCreatedWhen
         , FACT_EDW_HFit_HealthAssesmentUserQuestionGroupResults.ItemModifiedBy
         , FACT_EDW_HFit_HealthAssesmentUserQuestionGroupResults.ItemModifiedWhen
         , FACT_EDW_HFit_HealthAssesmentUserQuestionGroupResults.ItemGUID
         , FACT_EDW_HFit_HealthAssesmentUserQuestionGroupResults.HARiskAreaItemID
         , FACT_EDW_HFit_HealthAssesmentUserQuestionGroupResults.FormulaResult
         , FACT_EDW_HFit_HealthAssesmentUserQuestionGroupResults.CodeName
           FROM dbo.FACT_EDW_HFit_HealthAssesmentUserQuestionGroupResults;

    DECLARE
    @BASE_HFIT_HEALTHASSESMENTUSERQUESTION
    TABLE
    (
          ItemID int  NOT NULL
        , UserID bigint  NOT NULL
        , HAQuestionWeight int  NOT NULL
        , HAQuestionScore float  NULL
        , ItemCreatedBy int  NULL
        , ItemCreatedWhen datetime  NULL
        , ItemModifiedBy int  NULL
        , ItemModifiedWhen datetime  NULL
        , ItemOrder int  NULL
        , ItemGUID uniqueidentifier  NOT NULL
        , HARiskAreaItemID int  NOT NULL
        , CodeName nvarchar (100) NOT NULL
        , PreWeightedScore float  NULL
        , IsProfessionallyCollected bit  NOT NULL
        , ProfessionallyCollectedEventDate datetime  NULL
        , HARiskAreaDocumentID_old int  NOT NULL
        , HAQuestionNodeGUID uniqueidentifier  NOT NULL
        , HAQuestionDocumentID_old int  NOT NULL
        , HAQuestionVersionID_old bigint  NULL
          PRIMARY KEY ( ItemID , UserID) 
    );
    INSERT INTO @BASE_HFIT_HEALTHASSESMENTUSERQUESTION
    (
           ItemID
         , UserID
         , HAQuestionWeight
         , HAQuestionScore
         , ItemCreatedBy
         , ItemCreatedWhen
         , ItemModifiedBy
         , ItemModifiedWhen
         , ItemOrder
         , ItemGUID
         , HARiskAreaItemID
         , CodeName
         , PreWeightedScore
         , IsProfessionallyCollected
         , ProfessionallyCollectedEventDate
         , HARiskAreaDocumentID_old
         , HAQuestionNodeGUID
         , HAQuestionDocumentID_old
         , HAQuestionVersionID_old) 
    SELECT
           BASE_HFIT_HEALTHASSESMENTUSERQUESTION.ItemID
         , BASE_HFIT_HEALTHASSESMENTUSERQUESTION.UserID
         , BASE_HFIT_HEALTHASSESMENTUSERQUESTION.HAQuestionWeight
         , BASE_HFIT_HEALTHASSESMENTUSERQUESTION.HAQuestionScore
         , BASE_HFIT_HEALTHASSESMENTUSERQUESTION.ItemCreatedBy
         , BASE_HFIT_HEALTHASSESMENTUSERQUESTION.ItemCreatedWhen
         , BASE_HFIT_HEALTHASSESMENTUSERQUESTION.ItemModifiedBy
         , BASE_HFIT_HEALTHASSESMENTUSERQUESTION.ItemModifiedWhen
         , BASE_HFIT_HEALTHASSESMENTUSERQUESTION.ItemOrder
         , BASE_HFIT_HEALTHASSESMENTUSERQUESTION.ItemGUID
         , BASE_HFIT_HEALTHASSESMENTUSERQUESTION.HARiskAreaItemID
         , BASE_HFIT_HEALTHASSESMENTUSERQUESTION.CodeName
         , BASE_HFIT_HEALTHASSESMENTUSERQUESTION.PreWeightedScore
         , BASE_HFIT_HEALTHASSESMENTUSERQUESTION.IsProfessionallyCollected
         , BASE_HFIT_HEALTHASSESMENTUSERQUESTION.ProfessionallyCollectedEventDate
         , BASE_HFIT_HEALTHASSESMENTUSERQUESTION.HARiskAreaDocumentID_old
         , BASE_HFIT_HEALTHASSESMENTUSERQUESTION.HAQuestionNodeGUID
         , BASE_HFIT_HEALTHASSESMENTUSERQUESTION.HAQuestionDocumentID_old
         , BASE_HFIT_HEALTHASSESMENTUSERQUESTION.HAQuestionVersionID_old
           FROM dbo.BASE_HFIT_HEALTHASSESMENTUSERQUESTION;

    DECLARE
    @View_HFit_HACampaign_Joined
    TABLE
    (
          Published int  NOT NULL
        , SiteName nvarchar (100) NOT NULL
        , ClassName nvarchar (100) NOT NULL
        , ClassDisplayName nvarchar (100) NOT NULL
        , NodeID int  NOT NULL
        , NodeAliasPath nvarchar (450) NOT NULL
        , NodeName nvarchar (100) NOT NULL
        , NodeAlias nvarchar (50) NOT NULL
        , NodeClassID int  NOT NULL
        , NodeParentID int  NOT NULL
        , NodeLevel int  NOT NULL
        , NodeACLID int  NULL
        , NodeSiteID int  NOT NULL
        , NodeGUID uniqueidentifier  NOT NULL
        , NodeOrder int  NULL
        , IsSecuredNode bit  NULL
        , NodeCacheMinutes int  NULL
        , NodeSKUID int  NULL
        , NodeDocType nvarchar (max) NULL
        , NodeHeadTags nvarchar (max) NULL
        , NodeBodyElementAttributes nvarchar (max) NULL
        , NodeInheritPageLevels nvarchar (200) NULL
        , RequiresSSL int  NULL
        , NodeLinkedNodeID int  NULL
        , NodeOwner int  NULL
        , NodeCustomData nvarchar (max) NULL
        , NodeGroupID int  NULL
        , NodeLinkedNodeSiteID int  NULL
        , NodeTemplateID int  NULL
        , NodeWireframeTemplateID int  NULL
        , NodeWireframeComment nvarchar (max) NULL
        , NodeTemplateForAllCultures bit  NULL
        , NodeInheritPageTemplate bit  NULL
        , NodeWireframeInheritPageLevels nvarchar (450) NULL
        , NodeAllowCacheInFileSystem bit  NULL
        , NodeHasChildren bit  NULL
        , NodeHasLinks bit  NULL
        , DocumentID int  NOT NULL
        , DocumentName nvarchar (100) NOT NULL
        , DocumentNamePath nvarchar (1500) NULL
        , DocumentModifiedWhen datetime2 (7) NULL
        , DocumentModifiedByUserID int  NULL
        , DocumentForeignKeyValue int  NULL
        , DocumentCreatedByUserID int  NULL
        , DocumentCreatedWhen datetime2 (7) NULL
        , DocumentCheckedOutByUserID int  NULL
        , DocumentCheckedOutWhen datetime2 (7) NULL
        , DocumentCheckedOutVersionHistoryID int  NULL
        , DocumentPublishedVersionHistoryID int  NULL
        , DocumentWorkflowStepID int  NULL
        , DocumentPublishFrom datetime2 (7) NULL
        , DocumentPublishTo datetime2 (7) NULL
        , DocumentUrlPath nvarchar (450) NULL
        , DocumentCulture nvarchar (10) NOT NULL
        , DocumentNodeID int  NOT NULL
        , DocumentPageTitle nvarchar (max) NULL
        , DocumentPageKeyWords nvarchar (max) NULL
        , DocumentPageDescription nvarchar (max) NULL
        , DocumentShowInSiteMap bit  NOT NULL
        , DocumentMenuItemHideInNavigation bit  NOT NULL
        , DocumentMenuCaption nvarchar (200) NULL
        , DocumentMenuStyle nvarchar (100) NULL
        , DocumentMenuItemImage nvarchar (200) NULL
        , DocumentMenuItemLeftImage nvarchar (200) NULL
        , DocumentMenuItemRightImage nvarchar (200) NULL
        , DocumentPageTemplateID int  NULL
        , DocumentMenuJavascript nvarchar (450) NULL
        , DocumentMenuRedirectUrl nvarchar (450) NULL
        , DocumentUseNamePathForUrlPath bit  NULL
        , DocumentStylesheetID int  NULL
        , DocumentContent nvarchar (max) NULL
        , DocumentMenuClass nvarchar (100) NULL
        , DocumentMenuStyleOver nvarchar (200) NULL
        , DocumentMenuClassOver nvarchar (100) NULL
        , DocumentMenuItemImageOver nvarchar (200) NULL
        , DocumentMenuItemLeftImageOver nvarchar (200) NULL
        , DocumentMenuItemRightImageOver nvarchar (200) NULL
        , DocumentMenuStyleHighlighted nvarchar (200) NULL
        , DocumentMenuClassHighlighted nvarchar (100) NULL
        , DocumentMenuItemImageHighlighted nvarchar (200) NULL
        , DocumentMenuItemLeftImageHighlighted nvarchar (200) NULL
        , DocumentMenuItemRightImageHighlighted nvarchar (200) NULL
        , DocumentMenuItemInactive bit  NULL
        , DocumentCustomData nvarchar (max) NULL
        , DocumentExtensions nvarchar (100) NULL
        , DocumentCampaign nvarchar (100) NULL
        , DocumentTags nvarchar (max) NULL
        , DocumentTagGroupID int  NULL
        , DocumentWildcardRule nvarchar (440) NULL
        , DocumentWebParts nvarchar (max) NULL
        , DocumentRatingValue float  NULL
        , DocumentRatings int  NULL
        , DocumentPriority int  NULL
        , DocumentType nvarchar (50) NULL
        , DocumentLastPublished datetime2 (7) NULL
        , DocumentUseCustomExtensions bit  NULL
        , DocumentGroupWebParts nvarchar (max) NULL
        , DocumentCheckedOutAutomatically bit  NULL
        , DocumentTrackConversionName nvarchar (200) NULL
        , DocumentConversionValue nvarchar (100) NULL
        , DocumentSearchExcluded bit  NULL
        , DocumentLastVersionName nvarchar (100) NULL
        , DocumentLastVersionNumber nvarchar (50) NULL
        , DocumentIsArchived bit  NULL
        , DocumentLastVersionType nvarchar (50) NULL
        , DocumentLastVersionMenuRedirectUrl nvarchar (450) NULL
        , DocumentHash nvarchar (32) NULL
        , DocumentLogVisitActivity bit  NULL
        , DocumentGUID uniqueidentifier  NULL
        , DocumentWorkflowCycleGUID uniqueidentifier  NULL
        , DocumentSitemapSettings nvarchar (100) NULL
        , DocumentIsWaitingForTranslation bit  NULL
        , DocumentSKUName nvarchar (440) NULL
        , DocumentSKUDescription nvarchar (max) NULL
        , DocumentSKUShortDescription nvarchar (max) NULL
        , DocumentWorkflowActionStatus nvarchar (450) NULL
        , DocumentMenuRedirectToFirstChild bit  NULL
        , SKUID int  NULL
        , SKUNumber nvarchar (200) NULL
        , SKUName nvarchar (440) NULL
        , SKUDescription nvarchar (max) NULL
        , SKUPrice float  NULL
        , SKUEnabled bit  NULL
        , SKUDepartmentID int  NULL
        , SKUManufacturerID int  NULL
        , SKUInternalStatusID int  NULL
        , SKUPublicStatusID int  NULL
        , SKUSupplierID int  NULL
        , SKUAvailableInDays int  NULL
        , SKUGUID uniqueidentifier  NULL
        , SKUImagePath nvarchar (450) NULL
        , SKUWeight float  NULL
        , SKUWidth float  NULL
        , SKUDepth float  NULL
        , SKUHeight float  NULL
        , SKUAvailableItems int  NULL
        , SKUSellOnlyAvailable bit  NULL
        , SKUCustomData nvarchar (max) NULL
        , SKUOptionCategoryID int  NULL
        , SKUOrder int  NULL
        , SKULastModified datetime2 (7) NULL
        , SKUCreated datetime2 (7) NULL
        , SKUSiteID int  NULL
        , SKUPrivateDonation bit  NULL
        , SKUNeedsShipping bit  NULL
        , SKUMaxDownloads int  NULL
        , SKUValidUntil datetime2 (7) NULL
        , SKUProductType nvarchar (50) NULL
        , SKUMaxItemsInOrder int  NULL
        , SKUMaxPrice float  NULL
        , SKUValidity nvarchar (50) NULL
        , SKUValidFor int  NULL
        , SKUMinPrice float  NULL
        , SKUMembershipGUID uniqueidentifier  NULL
        , SKUConversionName nvarchar (100) NULL
        , SKUConversionValue nvarchar (200) NULL
        , SKUBundleInventoryType nvarchar (50) NULL
        , SKUMinItemsInOrder int  NULL
        , SKURetailPrice float  NULL
        , SKUParentSKUID int  NULL
        , SKUAllowAllVariants bit  NULL
        , SKUInheritsTaxClasses bit  NULL
        , SKUInheritsDiscounts bit  NULL
        , SKUTrackInventory nvarchar (50) NULL
        , SKUShortDescription nvarchar (max) NULL
        , SKUEproductFilesCount int  NULL
        , SKUBundleItemsCount int  NULL
        , SKUInStoreFrom datetime2 (7) NULL
        , SKUReorderAt int  NULL
        , NodeOwnerFullName nvarchar (450) NULL
        , NodeOwnerUserName nvarchar (100) NULL
        , NodeOwnerEmail nvarchar (100) NULL
        , HACampaignID int  NOT NULL
        , Name nvarchar (200) NOT NULL
        , Description nvarchar (512) NULL
        , Enabled bit  NOT NULL
        , SocialProofID int  NULL
        , HealthAssessmentID int  NOT NULL
        , DisplayThreshold int  NOT NULL
        , ProofText nvarchar (255) NOT NULL
        , SocialProofEndDate datetime2 (7) NULL
        , EnableSocialProof bit  NOT NULL
        , HealthAssessmentConfigurationID int  NOT NULL
        , BiometricCampaignStartDate datetime2 (7) NULL
        , BiometricCampaignEndDate datetime2 (7) NULL
        , ShowProfileConfirmation bit  NOT NULL
        , CampaignStartDate datetime2 (7) NOT NULL
        , CampaignEndDate datetime2 (7) NOT NULL
          PRIMARY KEY (DocumentCulture , HACampaignID , NodeGUID , HealthAssessmentID) 
    );
    INSERT INTO @View_HFit_HACampaign_Joined
    (
           Published
         , SiteName
         , ClassName
         , ClassDisplayName
         , NodeID
         , NodeAliasPath
         , NodeName
         , NodeAlias
         , NodeClassID
         , NodeParentID
         , NodeLevel
         , NodeACLID
         , NodeSiteID
         , NodeGUID
         , NodeOrder
         , IsSecuredNode
         , NodeCacheMinutes
         , NodeSKUID
         , NodeDocType
         , NodeHeadTags
         , NodeBodyElementAttributes
         , NodeInheritPageLevels
         , RequiresSSL
         , NodeLinkedNodeID
         , NodeOwner
         , NodeCustomData
         , NodeGroupID
         , NodeLinkedNodeSiteID
         , NodeTemplateID
         , NodeWireframeTemplateID
         , NodeWireframeComment
         , NodeTemplateForAllCultures
         , NodeInheritPageTemplate
         , NodeWireframeInheritPageLevels
         , NodeAllowCacheInFileSystem
         , NodeHasChildren
         , NodeHasLinks
         , DocumentID
         , DocumentName
         , DocumentNamePath
         , DocumentModifiedWhen
         , DocumentModifiedByUserID
         , DocumentForeignKeyValue
         , DocumentCreatedByUserID
         , DocumentCreatedWhen
         , DocumentCheckedOutByUserID
         , DocumentCheckedOutWhen
         , DocumentCheckedOutVersionHistoryID
         , DocumentPublishedVersionHistoryID
         , DocumentWorkflowStepID
         , DocumentPublishFrom
         , DocumentPublishTo
         , DocumentUrlPath
         , DocumentCulture
         , DocumentNodeID
         , DocumentPageTitle
         , DocumentPageKeyWords
         , DocumentPageDescription
         , DocumentShowInSiteMap
         , DocumentMenuItemHideInNavigation
         , DocumentMenuCaption
         , DocumentMenuStyle
         , DocumentMenuItemImage
         , DocumentMenuItemLeftImage
         , DocumentMenuItemRightImage
         , DocumentPageTemplateID
         , DocumentMenuJavascript
         , DocumentMenuRedirectUrl
         , DocumentUseNamePathForUrlPath
         , DocumentStylesheetID
         , DocumentContent
         , DocumentMenuClass
         , DocumentMenuStyleOver
         , DocumentMenuClassOver
         , DocumentMenuItemImageOver
         , DocumentMenuItemLeftImageOver
         , DocumentMenuItemRightImageOver
         , DocumentMenuStyleHighlighted
         , DocumentMenuClassHighlighted
         , DocumentMenuItemImageHighlighted
         , DocumentMenuItemLeftImageHighlighted
         , DocumentMenuItemRightImageHighlighted
         , DocumentMenuItemInactive
         , DocumentCustomData
         , DocumentExtensions
         , DocumentCampaign
         , DocumentTags
         , DocumentTagGroupID
         , DocumentWildcardRule
         , DocumentWebParts
         , DocumentRatingValue
         , DocumentRatings
         , DocumentPriority
         , DocumentType
         , DocumentLastPublished
         , DocumentUseCustomExtensions
         , DocumentGroupWebParts
         , DocumentCheckedOutAutomatically
         , DocumentTrackConversionName
         , DocumentConversionValue
         , DocumentSearchExcluded
         , DocumentLastVersionName
         , DocumentLastVersionNumber
         , DocumentIsArchived
         , DocumentLastVersionType
         , DocumentLastVersionMenuRedirectUrl
         , DocumentHash
         , DocumentLogVisitActivity
         , DocumentGUID
         , DocumentWorkflowCycleGUID
         , DocumentSitemapSettings
         , DocumentIsWaitingForTranslation
         , DocumentSKUName
         , DocumentSKUDescription
         , DocumentSKUShortDescription
         , DocumentWorkflowActionStatus
         , DocumentMenuRedirectToFirstChild
         , SKUID
         , SKUNumber
         , SKUName
         , SKUDescription
         , SKUPrice
         , SKUEnabled
         , SKUDepartmentID
         , SKUManufacturerID
         , SKUInternalStatusID
         , SKUPublicStatusID
         , SKUSupplierID
         , SKUAvailableInDays
         , SKUGUID
         , SKUImagePath
         , SKUWeight
         , SKUWidth
         , SKUDepth
         , SKUHeight
         , SKUAvailableItems
         , SKUSellOnlyAvailable
         , SKUCustomData
         , SKUOptionCategoryID
         , SKUOrder
         , SKULastModified
         , SKUCreated
         , SKUSiteID
         , SKUPrivateDonation
         , SKUNeedsShipping
         , SKUMaxDownloads
         , SKUValidUntil
         , SKUProductType
         , SKUMaxItemsInOrder
         , SKUMaxPrice
         , SKUValidity
         , SKUValidFor
         , SKUMinPrice
         , SKUMembershipGUID
         , SKUConversionName
         , SKUConversionValue
         , SKUBundleInventoryType
         , SKUMinItemsInOrder
         , SKURetailPrice
         , SKUParentSKUID
         , SKUAllowAllVariants
         , SKUInheritsTaxClasses
         , SKUInheritsDiscounts
         , SKUTrackInventory
         , SKUShortDescription
         , SKUEproductFilesCount
         , SKUBundleItemsCount
         , SKUInStoreFrom
         , SKUReorderAt
         , NodeOwnerFullName
         , NodeOwnerUserName
         , NodeOwnerEmail
         , HACampaignID
         , Name
         , Description
         , Enabled
         , SocialProofID
         , HealthAssessmentID
         , DisplayThreshold
         , ProofText
         , SocialProofEndDate
         , EnableSocialProof
         , HealthAssessmentConfigurationID
         , BiometricCampaignStartDate
         , BiometricCampaignEndDate
         , ShowProfileConfirmation
         , CampaignStartDate
         , CampaignEndDate) 
    SELECT
           Published
         , SiteName
         , ClassName
         , ClassDisplayName
         , NodeID
         , NodeAliasPath
         , NodeName
         , NodeAlias
         , NodeClassID
         , NodeParentID
         , NodeLevel
         , NodeACLID
         , NodeSiteID
         , NodeGUID
         , NodeOrder
         , IsSecuredNode
         , NodeCacheMinutes
         , NodeSKUID
         , NodeDocType
         , NodeHeadTags
         , NodeBodyElementAttributes
         , NodeInheritPageLevels
         , RequiresSSL
         , NodeLinkedNodeID
         , NodeOwner
         , NodeCustomData
         , NodeGroupID
         , NodeLinkedNodeSiteID
         , NodeTemplateID
         , NodeWireframeTemplateID
         , NodeWireframeComment
         , NodeTemplateForAllCultures
         , NodeInheritPageTemplate
         , NodeWireframeInheritPageLevels
         , NodeAllowCacheInFileSystem
         , NodeHasChildren
         , NodeHasLinks
         , DocumentID
         , DocumentName
         , DocumentNamePath
         , DocumentModifiedWhen
         , DocumentModifiedByUserID
         , DocumentForeignKeyValue
         , DocumentCreatedByUserID
         , DocumentCreatedWhen
         , DocumentCheckedOutByUserID
         , DocumentCheckedOutWhen
         , DocumentCheckedOutVersionHistoryID
         , DocumentPublishedVersionHistoryID
         , DocumentWorkflowStepID
         , DocumentPublishFrom
         , DocumentPublishTo
         , DocumentUrlPath
         , DocumentCulture
         , DocumentNodeID
         , DocumentPageTitle
         , DocumentPageKeyWords
         , DocumentPageDescription
         , DocumentShowInSiteMap
         , DocumentMenuItemHideInNavigation
         , DocumentMenuCaption
         , DocumentMenuStyle
         , DocumentMenuItemImage
         , DocumentMenuItemLeftImage
         , DocumentMenuItemRightImage
         , DocumentPageTemplateID
         , DocumentMenuJavascript
         , DocumentMenuRedirectUrl
         , DocumentUseNamePathForUrlPath
         , DocumentStylesheetID
         , DocumentContent
         , DocumentMenuClass
         , DocumentMenuStyleOver
         , DocumentMenuClassOver
         , DocumentMenuItemImageOver
         , DocumentMenuItemLeftImageOver
         , DocumentMenuItemRightImageOver
         , DocumentMenuStyleHighlighted
         , DocumentMenuClassHighlighted
         , DocumentMenuItemImageHighlighted
         , DocumentMenuItemLeftImageHighlighted
         , DocumentMenuItemRightImageHighlighted
         , DocumentMenuItemInactive
         , DocumentCustomData
         , DocumentExtensions
         , DocumentCampaign
         , DocumentTags
         , DocumentTagGroupID
         , DocumentWildcardRule
         , DocumentWebParts
         , DocumentRatingValue
         , DocumentRatings
         , DocumentPriority
         , DocumentType
         , DocumentLastPublished
         , DocumentUseCustomExtensions
         , DocumentGroupWebParts
         , DocumentCheckedOutAutomatically
         , DocumentTrackConversionName
         , DocumentConversionValue
         , DocumentSearchExcluded
         , DocumentLastVersionName
         , DocumentLastVersionNumber
         , DocumentIsArchived
         , DocumentLastVersionType
         , DocumentLastVersionMenuRedirectUrl
         , DocumentHash
         , DocumentLogVisitActivity
         , DocumentGUID
         , DocumentWorkflowCycleGUID
         , DocumentSitemapSettings
         , DocumentIsWaitingForTranslation
         , DocumentSKUName
         , DocumentSKUDescription
         , DocumentSKUShortDescription
         , DocumentWorkflowActionStatus
         , DocumentMenuRedirectToFirstChild
         , SKUID
         , SKUNumber
         , SKUName
         , SKUDescription
         , SKUPrice
         , SKUEnabled
         , SKUDepartmentID
         , SKUManufacturerID
         , SKUInternalStatusID
         , SKUPublicStatusID
         , SKUSupplierID
         , SKUAvailableInDays
         , SKUGUID
         , SKUImagePath
         , SKUWeight
         , SKUWidth
         , SKUDepth
         , SKUHeight
         , SKUAvailableItems
         , SKUSellOnlyAvailable
         , SKUCustomData
         , SKUOptionCategoryID
         , SKUOrder
         , SKULastModified
         , SKUCreated
         , SKUSiteID
         , SKUPrivateDonation
         , SKUNeedsShipping
         , SKUMaxDownloads
         , SKUValidUntil
         , SKUProductType
         , SKUMaxItemsInOrder
         , SKUMaxPrice
         , SKUValidity
         , SKUValidFor
         , SKUMinPrice
         , SKUMembershipGUID
         , SKUConversionName
         , SKUConversionValue
         , SKUBundleInventoryType
         , SKUMinItemsInOrder
         , SKURetailPrice
         , SKUParentSKUID
         , SKUAllowAllVariants
         , SKUInheritsTaxClasses
         , SKUInheritsDiscounts
         , SKUTrackInventory
         , SKUShortDescription
         , SKUEproductFilesCount
         , SKUBundleItemsCount
         , SKUInStoreFrom
         , SKUReorderAt
         , NodeOwnerFullName
         , NodeOwnerUserName
         , NodeOwnerEmail
         , HACampaignID
         , Name
         , Description
         , Enabled
         , SocialProofID
         , HealthAssessmentID
         , DisplayThreshold
         , ProofText
         , SocialProofEndDate
         , EnableSocialProof
         , HealthAssessmentConfigurationID
         , BiometricCampaignStartDate
         , BiometricCampaignEndDate
         , ShowProfileConfirmation
         , CampaignStartDate
         , CampaignEndDate
           FROM dbo.View_HFit_HACampaign_Joined;

    -- select top 10 * into xxx from View_HFit_HACampaign_Joined
    -- drop table XXX

    DECLARE
    @View_HFit_HealthAssessment_Joined
    TABLE
    (
          Published int  NOT NULL
        , SiteName nvarchar (100) NOT NULL
        , ClassName nvarchar (100) NOT NULL
        , ClassDisplayName nvarchar (100) NOT NULL
        , NodeID int  NOT NULL
        , NodeAliasPath nvarchar (450) NOT NULL
        , NodeName nvarchar (100) NOT NULL
        , NodeAlias nvarchar (50) NOT NULL
        , NodeClassID int  NOT NULL
        , NodeParentID int  NOT NULL
        , NodeLevel int  NOT NULL
        , NodeACLID int  NULL
        , NodeSiteID int  NOT NULL
        , NodeGUID uniqueidentifier  NOT NULL
        , NodeOrder int  NULL
        , IsSecuredNode bit  NULL
        , NodeCacheMinutes int  NULL
        , NodeSKUID int  NULL
        , NodeDocType nvarchar (max) NULL
        , NodeHeadTags nvarchar (max) NULL
        , NodeBodyElementAttributes nvarchar (max) NULL
        , NodeInheritPageLevels nvarchar (200) NULL
        , RequiresSSL int  NULL
        , NodeLinkedNodeID int  NULL
        , NodeOwner int  NULL
        , NodeCustomData nvarchar (max) NULL
        , NodeGroupID int  NULL
        , NodeLinkedNodeSiteID int  NULL
        , NodeTemplateID int  NULL
        , NodeWireframeTemplateID int  NULL
        , NodeWireframeComment nvarchar (max) NULL
        , NodeTemplateForAllCultures bit  NULL
        , NodeInheritPageTemplate bit  NULL
        , NodeWireframeInheritPageLevels nvarchar (450) NULL
        , NodeAllowCacheInFileSystem bit  NULL
        , NodeHasChildren bit  NULL
        , NodeHasLinks bit  NULL
        , DocumentID int  NOT NULL
        , DocumentName nvarchar (100) NOT NULL
        , DocumentNamePath nvarchar (1500) NULL
        , DocumentModifiedWhen datetime2 (7) NULL
        , DocumentModifiedByUserID int  NULL
        , DocumentForeignKeyValue int  NULL
        , DocumentCreatedByUserID int  NULL
        , DocumentCreatedWhen datetime2 (7) NULL
        , DocumentCheckedOutByUserID int  NULL
        , DocumentCheckedOutWhen datetime2 (7) NULL
        , DocumentCheckedOutVersionHistoryID int  NULL
        , DocumentPublishedVersionHistoryID int  NULL
        , DocumentWorkflowStepID int  NULL
        , DocumentPublishFrom datetime2 (7) NULL
        , DocumentPublishTo datetime2 (7) NULL
        , DocumentUrlPath nvarchar (450) NULL
        , DocumentCulture nvarchar (10) NOT NULL
        , DocumentNodeID int  NOT NULL
        , DocumentPageTitle nvarchar (max) NULL
        , DocumentPageKeyWords nvarchar (max) NULL
        , DocumentPageDescription nvarchar (max) NULL
        , DocumentShowInSiteMap bit  NOT NULL
        , DocumentMenuItemHideInNavigation bit  NOT NULL
        , DocumentMenuCaption nvarchar (200) NULL
        , DocumentMenuStyle nvarchar (100) NULL
        , DocumentMenuItemImage nvarchar (200) NULL
        , DocumentMenuItemLeftImage nvarchar (200) NULL
        , DocumentMenuItemRightImage nvarchar (200) NULL
        , DocumentPageTemplateID int  NULL
        , DocumentMenuJavascript nvarchar (450) NULL
        , DocumentMenuRedirectUrl nvarchar (450) NULL
        , DocumentUseNamePathForUrlPath bit  NULL
        , DocumentStylesheetID int  NULL
        , DocumentContent nvarchar (max) NULL
        , DocumentMenuClass nvarchar (100) NULL
        , DocumentMenuStyleOver nvarchar (200) NULL
        , DocumentMenuClassOver nvarchar (100) NULL
        , DocumentMenuItemImageOver nvarchar (200) NULL
        , DocumentMenuItemLeftImageOver nvarchar (200) NULL
        , DocumentMenuItemRightImageOver nvarchar (200) NULL
        , DocumentMenuStyleHighlighted nvarchar (200) NULL
        , DocumentMenuClassHighlighted nvarchar (100) NULL
        , DocumentMenuItemImageHighlighted nvarchar (200) NULL
        , DocumentMenuItemLeftImageHighlighted nvarchar (200) NULL
        , DocumentMenuItemRightImageHighlighted nvarchar (200) NULL
        , DocumentMenuItemInactive bit  NULL
        , DocumentCustomData nvarchar (max) NULL
        , DocumentExtensions nvarchar (100) NULL
        , DocumentCampaign nvarchar (100) NULL
        , DocumentTags nvarchar (max) NULL
        , DocumentTagGroupID int  NULL
        , DocumentWildcardRule nvarchar (440) NULL
        , DocumentWebParts nvarchar (max) NULL
        , DocumentRatingValue float  NULL
        , DocumentRatings int  NULL
        , DocumentPriority int  NULL
        , DocumentType nvarchar (50) NULL
        , DocumentLastPublished datetime2 (7) NULL
        , DocumentUseCustomExtensions bit  NULL
        , DocumentGroupWebParts nvarchar (max) NULL
        , DocumentCheckedOutAutomatically bit  NULL
        , DocumentTrackConversionName nvarchar (200) NULL
        , DocumentConversionValue nvarchar (100) NULL
        , DocumentSearchExcluded bit  NULL
        , DocumentLastVersionName nvarchar (100) NULL
        , DocumentLastVersionNumber nvarchar (50) NULL
        , DocumentIsArchived bit  NULL
        , DocumentLastVersionType nvarchar (50) NULL
        , DocumentLastVersionMenuRedirectUrl nvarchar (450) NULL
        , DocumentHash nvarchar (32) NULL
        , DocumentLogVisitActivity bit  NULL
        , DocumentGUID uniqueidentifier  NULL
        , DocumentWorkflowCycleGUID uniqueidentifier  NULL
        , DocumentSitemapSettings nvarchar (100) NULL
        , DocumentIsWaitingForTranslation bit  NULL
        , DocumentSKUName nvarchar (440) NULL
        , DocumentSKUDescription nvarchar (max) NULL
        , DocumentSKUShortDescription nvarchar (max) NULL
        , DocumentWorkflowActionStatus nvarchar (450) NULL
        , DocumentMenuRedirectToFirstChild bit  NULL
        , SKUID int  NULL
        , SKUNumber nvarchar (200) NULL
        , SKUName nvarchar (440) NULL
        , SKUDescription nvarchar (max) NULL
        , SKUPrice float  NULL
        , SKUEnabled bit  NULL
        , SKUDepartmentID int  NULL
        , SKUManufacturerID int  NULL
        , SKUInternalStatusID int  NULL
        , SKUPublicStatusID int  NULL
        , SKUSupplierID int  NULL
        , SKUAvailableInDays int  NULL
        , SKUGUID uniqueidentifier  NULL
        , SKUImagePath nvarchar (450) NULL
        , SKUWeight float  NULL
        , SKUWidth float  NULL
        , SKUDepth float  NULL
        , SKUHeight float  NULL
        , SKUAvailableItems int  NULL
        , SKUSellOnlyAvailable bit  NULL
        , SKUCustomData nvarchar (max) NULL
        , SKUOptionCategoryID int  NULL
        , SKUOrder int  NULL
        , SKULastModified datetime2 (7) NULL
        , SKUCreated datetime2 (7) NULL
        , SKUSiteID int  NULL
        , SKUPrivateDonation bit  NULL
        , SKUNeedsShipping bit  NULL
        , SKUMaxDownloads int  NULL
        , SKUValidUntil datetime2 (7) NULL
        , SKUProductType nvarchar (50) NULL
        , SKUMaxItemsInOrder int  NULL
        , SKUMaxPrice float  NULL
        , SKUValidity nvarchar (50) NULL
        , SKUValidFor int  NULL
        , SKUMinPrice float  NULL
        , SKUMembershipGUID uniqueidentifier  NULL
        , SKUConversionName nvarchar (100) NULL
        , SKUConversionValue nvarchar (200) NULL
        , SKUBundleInventoryType nvarchar (50) NULL
        , SKUMinItemsInOrder int  NULL
        , SKURetailPrice float  NULL
        , SKUParentSKUID int  NULL
        , SKUAllowAllVariants bit  NULL
        , SKUInheritsTaxClasses bit  NULL
        , SKUInheritsDiscounts bit  NULL
        , SKUTrackInventory nvarchar (50) NULL
        , SKUShortDescription nvarchar (max) NULL
        , SKUEproductFilesCount int  NULL
        , SKUBundleItemsCount int  NULL
        , SKUInStoreFrom datetime2 (7) NULL
        , SKUReorderAt int  NULL
        , NodeOwnerFullName nvarchar (450) NULL
        , NodeOwnerUserName nvarchar (100) NULL
        , NodeOwnerEmail nvarchar (100) NULL
        , HealthAssessmentID int  NOT NULL
        , QuestionTransformUrl nvarchar (256) NOT NULL
        , ReviewText nvarchar (max) NULL
        , SubmitButtonText nvarchar (35) NOT NULL
        , ReviewTitle nvarchar (100) NOT NULL
        , SubmitRedirectUrl nvarchar (2000) NOT NULL
        , ReviewUrl nvarchar (2000) NOT NULL
        , ConfirmationTitle nvarchar (100) NOT NULL
        , ConfirmationText nvarchar (max) NULL
        , ConfirmationUrl nvarchar (2000) NOT NULL
        , ConfirmationSubTitle nvarchar (100) NULL
        , ConfirmationEditButtonText nvarchar (35) NULL
        , SmallStepTitle nvarchar (512) NOT NULL
        , SmallStepText nvarchar (max) NOT NULL
        , SmallStepUrl nvarchar (1024) NOT NULL
        , MinimumOptOut int  NOT NULL
        , MinimumSteps int  NOT NULL
        , MaximumSteps int  NOT NULL
        , IntroText nvarchar (max) NULL
        , Revision int  NOT NULL
        , MyProfileConfirmationUrl nvarchar (2000) NULL
        , MyProfileConfirmationTitle nvarchar (100) NULL
        , MyProfileConfirmationText nvarchar (max) NULL
        , HealthAssessmentConfigurationID int  NULL
        , DisplayName nvarchar (200) NULL
        , ReviewEditButtonText nvarchar (512) NULL
        , SmallStepOptoutText nvarchar (512) NULL
        , MinimumStepsError nvarchar (512) NULL
        , MaximumStepsError nvarchar (512) NULL
        , WaitMessage nvarchar (200) NOT NULL
        , ErrorMessage nvarchar (2000) NOT NULL
        , ErrorTitle nvarchar (200) NULL
          PRIMARY KEY (NodeGUID , DocumentID) 
    );
    INSERT INTO @View_HFit_HealthAssessment_Joined
    (
           Published
         , SiteName
         , ClassName
         , ClassDisplayName
         , NodeID
         , NodeAliasPath
         , NodeName
         , NodeAlias
         , NodeClassID
         , NodeParentID
         , NodeLevel
         , NodeACLID
         , NodeSiteID
         , NodeGUID
         , NodeOrder
         , IsSecuredNode
         , NodeCacheMinutes
         , NodeSKUID
         , NodeDocType
         , NodeHeadTags
         , NodeBodyElementAttributes
         , NodeInheritPageLevels
         , RequiresSSL
         , NodeLinkedNodeID
         , NodeOwner
         , NodeCustomData
         , NodeGroupID
         , NodeLinkedNodeSiteID
         , NodeTemplateID
         , NodeWireframeTemplateID
         , NodeWireframeComment
         , NodeTemplateForAllCultures
         , NodeInheritPageTemplate
         , NodeWireframeInheritPageLevels
         , NodeAllowCacheInFileSystem
         , NodeHasChildren
         , NodeHasLinks
         , DocumentID
         , DocumentName
         , DocumentNamePath
         , DocumentModifiedWhen
         , DocumentModifiedByUserID
         , DocumentForeignKeyValue
         , DocumentCreatedByUserID
         , DocumentCreatedWhen
         , DocumentCheckedOutByUserID
         , DocumentCheckedOutWhen
         , DocumentCheckedOutVersionHistoryID
         , DocumentPublishedVersionHistoryID
         , DocumentWorkflowStepID
         , DocumentPublishFrom
         , DocumentPublishTo
         , DocumentUrlPath
         , DocumentCulture
         , DocumentNodeID
         , DocumentPageTitle
         , DocumentPageKeyWords
         , DocumentPageDescription
         , DocumentShowInSiteMap
         , DocumentMenuItemHideInNavigation
         , DocumentMenuCaption
         , DocumentMenuStyle
         , DocumentMenuItemImage
         , DocumentMenuItemLeftImage
         , DocumentMenuItemRightImage
         , DocumentPageTemplateID
         , DocumentMenuJavascript
         , DocumentMenuRedirectUrl
         , DocumentUseNamePathForUrlPath
         , DocumentStylesheetID
         , DocumentContent
         , DocumentMenuClass
         , DocumentMenuStyleOver
         , DocumentMenuClassOver
         , DocumentMenuItemImageOver
         , DocumentMenuItemLeftImageOver
         , DocumentMenuItemRightImageOver
         , DocumentMenuStyleHighlighted
         , DocumentMenuClassHighlighted
         , DocumentMenuItemImageHighlighted
         , DocumentMenuItemLeftImageHighlighted
         , DocumentMenuItemRightImageHighlighted
         , DocumentMenuItemInactive
         , DocumentCustomData
         , DocumentExtensions
         , DocumentCampaign
         , DocumentTags
         , DocumentTagGroupID
         , DocumentWildcardRule
         , DocumentWebParts
         , DocumentRatingValue
         , DocumentRatings
         , DocumentPriority
         , DocumentType
         , DocumentLastPublished
         , DocumentUseCustomExtensions
         , DocumentGroupWebParts
         , DocumentCheckedOutAutomatically
         , DocumentTrackConversionName
         , DocumentConversionValue
         , DocumentSearchExcluded
         , DocumentLastVersionName
         , DocumentLastVersionNumber
         , DocumentIsArchived
         , DocumentLastVersionType
         , DocumentLastVersionMenuRedirectUrl
         , DocumentHash
         , DocumentLogVisitActivity
         , DocumentGUID
         , DocumentWorkflowCycleGUID
         , DocumentSitemapSettings
         , DocumentIsWaitingForTranslation
         , DocumentSKUName
         , DocumentSKUDescription
         , DocumentSKUShortDescription
         , DocumentWorkflowActionStatus
         , DocumentMenuRedirectToFirstChild
         , SKUID
         , SKUNumber
         , SKUName
         , SKUDescription
         , SKUPrice
         , SKUEnabled
         , SKUDepartmentID
         , SKUManufacturerID
         , SKUInternalStatusID
         , SKUPublicStatusID
         , SKUSupplierID
         , SKUAvailableInDays
         , SKUGUID
         , SKUImagePath
         , SKUWeight
         , SKUWidth
         , SKUDepth
         , SKUHeight
         , SKUAvailableItems
         , SKUSellOnlyAvailable
         , SKUCustomData
         , SKUOptionCategoryID
         , SKUOrder
         , SKULastModified
         , SKUCreated
         , SKUSiteID
         , SKUPrivateDonation
         , SKUNeedsShipping
         , SKUMaxDownloads
         , SKUValidUntil
         , SKUProductType
         , SKUMaxItemsInOrder
         , SKUMaxPrice
         , SKUValidity
         , SKUValidFor
         , SKUMinPrice
         , SKUMembershipGUID
         , SKUConversionName
         , SKUConversionValue
         , SKUBundleInventoryType
         , SKUMinItemsInOrder
         , SKURetailPrice
         , SKUParentSKUID
         , SKUAllowAllVariants
         , SKUInheritsTaxClasses
         , SKUInheritsDiscounts
         , SKUTrackInventory
         , SKUShortDescription
         , SKUEproductFilesCount
         , SKUBundleItemsCount
         , SKUInStoreFrom
         , SKUReorderAt
         , NodeOwnerFullName
         , NodeOwnerUserName
         , NodeOwnerEmail
         , HealthAssessmentID
         , QuestionTransformUrl
         , ReviewText
         , SubmitButtonText
         , ReviewTitle
         , SubmitRedirectUrl
         , ReviewUrl
         , ConfirmationTitle
         , ConfirmationText
         , ConfirmationUrl
         , ConfirmationSubTitle
         , ConfirmationEditButtonText
         , SmallStepTitle
         , SmallStepText
         , SmallStepUrl
         , MinimumOptOut
         , MinimumSteps
         , MaximumSteps
         , IntroText
         , Revision
         , MyProfileConfirmationUrl
         , MyProfileConfirmationTitle
         , MyProfileConfirmationText
         , HealthAssessmentConfigurationID
         , DisplayName
         , ReviewEditButtonText
         , SmallStepOptoutText
         , MinimumStepsError
         , MaximumStepsError
         , WaitMessage
         , ErrorMessage
         , ErrorTitle) 
    SELECT
           View_HFit_HealthAssessment_Joined.Published
         , View_HFit_HealthAssessment_Joined.SiteName
         , View_HFit_HealthAssessment_Joined.ClassName
         , View_HFit_HealthAssessment_Joined.ClassDisplayName
         , View_HFit_HealthAssessment_Joined.NodeID
         , View_HFit_HealthAssessment_Joined.NodeAliasPath
         , View_HFit_HealthAssessment_Joined.NodeName
         , View_HFit_HealthAssessment_Joined.NodeAlias
         , View_HFit_HealthAssessment_Joined.NodeClassID
         , View_HFit_HealthAssessment_Joined.NodeParentID
         , View_HFit_HealthAssessment_Joined.NodeLevel
         , View_HFit_HealthAssessment_Joined.NodeACLID
         , View_HFit_HealthAssessment_Joined.NodeSiteID
         , View_HFit_HealthAssessment_Joined.NodeGUID
         , View_HFit_HealthAssessment_Joined.NodeOrder
         , View_HFit_HealthAssessment_Joined.IsSecuredNode
         , View_HFit_HealthAssessment_Joined.NodeCacheMinutes
         , View_HFit_HealthAssessment_Joined.NodeSKUID
         , View_HFit_HealthAssessment_Joined.NodeDocType
         , View_HFit_HealthAssessment_Joined.NodeHeadTags
         , View_HFit_HealthAssessment_Joined.NodeBodyElementAttributes
         , View_HFit_HealthAssessment_Joined.NodeInheritPageLevels
         , View_HFit_HealthAssessment_Joined.RequiresSSL
         , View_HFit_HealthAssessment_Joined.NodeLinkedNodeID
         , View_HFit_HealthAssessment_Joined.NodeOwner
         , View_HFit_HealthAssessment_Joined.NodeCustomData
         , View_HFit_HealthAssessment_Joined.NodeGroupID
         , View_HFit_HealthAssessment_Joined.NodeLinkedNodeSiteID
         , View_HFit_HealthAssessment_Joined.NodeTemplateID
         , View_HFit_HealthAssessment_Joined.NodeWireframeTemplateID
         , View_HFit_HealthAssessment_Joined.NodeWireframeComment
         , View_HFit_HealthAssessment_Joined.NodeTemplateForAllCultures
         , View_HFit_HealthAssessment_Joined.NodeInheritPageTemplate
         , View_HFit_HealthAssessment_Joined.NodeWireframeInheritPageLevels
         , View_HFit_HealthAssessment_Joined.NodeAllowCacheInFileSystem
         , View_HFit_HealthAssessment_Joined.NodeHasChildren
         , View_HFit_HealthAssessment_Joined.NodeHasLinks
         , View_HFit_HealthAssessment_Joined.DocumentID
         , View_HFit_HealthAssessment_Joined.DocumentName
         , View_HFit_HealthAssessment_Joined.DocumentNamePath
         , View_HFit_HealthAssessment_Joined.DocumentModifiedWhen
         , View_HFit_HealthAssessment_Joined.DocumentModifiedByUserID
         , View_HFit_HealthAssessment_Joined.DocumentForeignKeyValue
         , View_HFit_HealthAssessment_Joined.DocumentCreatedByUserID
         , View_HFit_HealthAssessment_Joined.DocumentCreatedWhen
         , View_HFit_HealthAssessment_Joined.DocumentCheckedOutByUserID
         , View_HFit_HealthAssessment_Joined.DocumentCheckedOutWhen
         , View_HFit_HealthAssessment_Joined.DocumentCheckedOutVersionHistoryID
         , View_HFit_HealthAssessment_Joined.DocumentPublishedVersionHistoryID
         , View_HFit_HealthAssessment_Joined.DocumentWorkflowStepID
         , View_HFit_HealthAssessment_Joined.DocumentPublishFrom
         , View_HFit_HealthAssessment_Joined.DocumentPublishTo
         , View_HFit_HealthAssessment_Joined.DocumentUrlPath
         , View_HFit_HealthAssessment_Joined.DocumentCulture
         , View_HFit_HealthAssessment_Joined.DocumentNodeID
         , View_HFit_HealthAssessment_Joined.DocumentPageTitle
         , View_HFit_HealthAssessment_Joined.DocumentPageKeyWords
         , View_HFit_HealthAssessment_Joined.DocumentPageDescription
         , View_HFit_HealthAssessment_Joined.DocumentShowInSiteMap
         , View_HFit_HealthAssessment_Joined.DocumentMenuItemHideInNavigation
         , View_HFit_HealthAssessment_Joined.DocumentMenuCaption
         , View_HFit_HealthAssessment_Joined.DocumentMenuStyle
         , View_HFit_HealthAssessment_Joined.DocumentMenuItemImage
         , View_HFit_HealthAssessment_Joined.DocumentMenuItemLeftImage
         , View_HFit_HealthAssessment_Joined.DocumentMenuItemRightImage
         , View_HFit_HealthAssessment_Joined.DocumentPageTemplateID
         , View_HFit_HealthAssessment_Joined.DocumentMenuJavascript
         , View_HFit_HealthAssessment_Joined.DocumentMenuRedirectUrl
         , View_HFit_HealthAssessment_Joined.DocumentUseNamePathForUrlPath
         , View_HFit_HealthAssessment_Joined.DocumentStylesheetID
         , View_HFit_HealthAssessment_Joined.DocumentContent
         , View_HFit_HealthAssessment_Joined.DocumentMenuClass
         , View_HFit_HealthAssessment_Joined.DocumentMenuStyleOver
         , View_HFit_HealthAssessment_Joined.DocumentMenuClassOver
         , View_HFit_HealthAssessment_Joined.DocumentMenuItemImageOver
         , View_HFit_HealthAssessment_Joined.DocumentMenuItemLeftImageOver
         , View_HFit_HealthAssessment_Joined.DocumentMenuItemRightImageOver
         , View_HFit_HealthAssessment_Joined.DocumentMenuStyleHighlighted
         , View_HFit_HealthAssessment_Joined.DocumentMenuClassHighlighted
         , View_HFit_HealthAssessment_Joined.DocumentMenuItemImageHighlighted
         , View_HFit_HealthAssessment_Joined.DocumentMenuItemLeftImageHighlighted
         , View_HFit_HealthAssessment_Joined.DocumentMenuItemRightImageHighlighted
         , View_HFit_HealthAssessment_Joined.DocumentMenuItemInactive
         , View_HFit_HealthAssessment_Joined.DocumentCustomData
         , View_HFit_HealthAssessment_Joined.DocumentExtensions
         , View_HFit_HealthAssessment_Joined.DocumentCampaign
         , View_HFit_HealthAssessment_Joined.DocumentTags
         , View_HFit_HealthAssessment_Joined.DocumentTagGroupID
         , View_HFit_HealthAssessment_Joined.DocumentWildcardRule
         , View_HFit_HealthAssessment_Joined.DocumentWebParts
         , View_HFit_HealthAssessment_Joined.DocumentRatingValue
         , View_HFit_HealthAssessment_Joined.DocumentRatings
         , View_HFit_HealthAssessment_Joined.DocumentPriority
         , View_HFit_HealthAssessment_Joined.DocumentType
         , View_HFit_HealthAssessment_Joined.DocumentLastPublished
         , View_HFit_HealthAssessment_Joined.DocumentUseCustomExtensions
         , View_HFit_HealthAssessment_Joined.DocumentGroupWebParts
         , View_HFit_HealthAssessment_Joined.DocumentCheckedOutAutomatically
         , View_HFit_HealthAssessment_Joined.DocumentTrackConversionName
         , View_HFit_HealthAssessment_Joined.DocumentConversionValue
         , View_HFit_HealthAssessment_Joined.DocumentSearchExcluded
         , View_HFit_HealthAssessment_Joined.DocumentLastVersionName
         , View_HFit_HealthAssessment_Joined.DocumentLastVersionNumber
         , View_HFit_HealthAssessment_Joined.DocumentIsArchived
         , View_HFit_HealthAssessment_Joined.DocumentLastVersionType
         , View_HFit_HealthAssessment_Joined.DocumentLastVersionMenuRedirectUrl
         , View_HFit_HealthAssessment_Joined.DocumentHash
         , View_HFit_HealthAssessment_Joined.DocumentLogVisitActivity
         , View_HFit_HealthAssessment_Joined.DocumentGUID
         , View_HFit_HealthAssessment_Joined.DocumentWorkflowCycleGUID
         , View_HFit_HealthAssessment_Joined.DocumentSitemapSettings
         , View_HFit_HealthAssessment_Joined.DocumentIsWaitingForTranslation
         , View_HFit_HealthAssessment_Joined.DocumentSKUName
         , View_HFit_HealthAssessment_Joined.DocumentSKUDescription
         , View_HFit_HealthAssessment_Joined.DocumentSKUShortDescription
         , View_HFit_HealthAssessment_Joined.DocumentWorkflowActionStatus
         , View_HFit_HealthAssessment_Joined.DocumentMenuRedirectToFirstChild
         , View_HFit_HealthAssessment_Joined.SKUID
         , View_HFit_HealthAssessment_Joined.SKUNumber
         , View_HFit_HealthAssessment_Joined.SKUName
         , View_HFit_HealthAssessment_Joined.SKUDescription
         , View_HFit_HealthAssessment_Joined.SKUPrice
         , View_HFit_HealthAssessment_Joined.SKUEnabled
         , View_HFit_HealthAssessment_Joined.SKUDepartmentID
         , View_HFit_HealthAssessment_Joined.SKUManufacturerID
         , View_HFit_HealthAssessment_Joined.SKUInternalStatusID
         , View_HFit_HealthAssessment_Joined.SKUPublicStatusID
         , View_HFit_HealthAssessment_Joined.SKUSupplierID
         , View_HFit_HealthAssessment_Joined.SKUAvailableInDays
         , View_HFit_HealthAssessment_Joined.SKUGUID
         , View_HFit_HealthAssessment_Joined.SKUImagePath
         , View_HFit_HealthAssessment_Joined.SKUWeight
         , View_HFit_HealthAssessment_Joined.SKUWidth
         , View_HFit_HealthAssessment_Joined.SKUDepth
         , View_HFit_HealthAssessment_Joined.SKUHeight
         , View_HFit_HealthAssessment_Joined.SKUAvailableItems
         , View_HFit_HealthAssessment_Joined.SKUSellOnlyAvailable
         , View_HFit_HealthAssessment_Joined.SKUCustomData
         , View_HFit_HealthAssessment_Joined.SKUOptionCategoryID
         , View_HFit_HealthAssessment_Joined.SKUOrder
         , View_HFit_HealthAssessment_Joined.SKULastModified
         , View_HFit_HealthAssessment_Joined.SKUCreated
         , View_HFit_HealthAssessment_Joined.SKUSiteID
         , View_HFit_HealthAssessment_Joined.SKUPrivateDonation
         , View_HFit_HealthAssessment_Joined.SKUNeedsShipping
         , View_HFit_HealthAssessment_Joined.SKUMaxDownloads
         , View_HFit_HealthAssessment_Joined.SKUValidUntil
         , View_HFit_HealthAssessment_Joined.SKUProductType
         , View_HFit_HealthAssessment_Joined.SKUMaxItemsInOrder
         , View_HFit_HealthAssessment_Joined.SKUMaxPrice
         , View_HFit_HealthAssessment_Joined.SKUValidity
         , View_HFit_HealthAssessment_Joined.SKUValidFor
         , View_HFit_HealthAssessment_Joined.SKUMinPrice
         , View_HFit_HealthAssessment_Joined.SKUMembershipGUID
         , View_HFit_HealthAssessment_Joined.SKUConversionName
         , View_HFit_HealthAssessment_Joined.SKUConversionValue
         , View_HFit_HealthAssessment_Joined.SKUBundleInventoryType
         , View_HFit_HealthAssessment_Joined.SKUMinItemsInOrder
         , View_HFit_HealthAssessment_Joined.SKURetailPrice
         , View_HFit_HealthAssessment_Joined.SKUParentSKUID
         , View_HFit_HealthAssessment_Joined.SKUAllowAllVariants
         , View_HFit_HealthAssessment_Joined.SKUInheritsTaxClasses
         , View_HFit_HealthAssessment_Joined.SKUInheritsDiscounts
         , View_HFit_HealthAssessment_Joined.SKUTrackInventory
         , View_HFit_HealthAssessment_Joined.SKUShortDescription
         , View_HFit_HealthAssessment_Joined.SKUEproductFilesCount
         , View_HFit_HealthAssessment_Joined.SKUBundleItemsCount
         , View_HFit_HealthAssessment_Joined.SKUInStoreFrom
         , View_HFit_HealthAssessment_Joined.SKUReorderAt
         , View_HFit_HealthAssessment_Joined.NodeOwnerFullName
         , View_HFit_HealthAssessment_Joined.NodeOwnerUserName
         , View_HFit_HealthAssessment_Joined.NodeOwnerEmail
         , View_HFit_HealthAssessment_Joined.HealthAssessmentID
         , View_HFit_HealthAssessment_Joined.QuestionTransformUrl
         , View_HFit_HealthAssessment_Joined.ReviewText
         , View_HFit_HealthAssessment_Joined.SubmitButtonText
         , View_HFit_HealthAssessment_Joined.ReviewTitle
         , View_HFit_HealthAssessment_Joined.SubmitRedirectUrl
         , View_HFit_HealthAssessment_Joined.ReviewUrl
         , View_HFit_HealthAssessment_Joined.ConfirmationTitle
         , View_HFit_HealthAssessment_Joined.ConfirmationText
         , View_HFit_HealthAssessment_Joined.ConfirmationUrl
         , View_HFit_HealthAssessment_Joined.ConfirmationSubTitle
         , View_HFit_HealthAssessment_Joined.ConfirmationEditButtonText
         , View_HFit_HealthAssessment_Joined.SmallStepTitle
         , View_HFit_HealthAssessment_Joined.SmallStepText
         , View_HFit_HealthAssessment_Joined.SmallStepUrl
         , View_HFit_HealthAssessment_Joined.MinimumOptOut
         , View_HFit_HealthAssessment_Joined.MinimumSteps
         , View_HFit_HealthAssessment_Joined.MaximumSteps
         , View_HFit_HealthAssessment_Joined.IntroText
         , View_HFit_HealthAssessment_Joined.Revision
         , View_HFit_HealthAssessment_Joined.MyProfileConfirmationUrl
         , View_HFit_HealthAssessment_Joined.MyProfileConfirmationTitle
         , View_HFit_HealthAssessment_Joined.MyProfileConfirmationText
         , View_HFit_HealthAssessment_Joined.HealthAssessmentConfigurationID
         , View_HFit_HealthAssessment_Joined.DisplayName
         , View_HFit_HealthAssessment_Joined.ReviewEditButtonText
         , View_HFit_HealthAssessment_Joined.SmallStepOptoutText
         , View_HFit_HealthAssessment_Joined.MinimumStepsError
         , View_HFit_HealthAssessment_Joined.MaximumStepsError
         , View_HFit_HealthAssessment_Joined.WaitMessage
         , View_HFit_HealthAssessment_Joined.ErrorMessage
         , View_HFit_HealthAssessment_Joined.ErrorTitle
           FROM dbo.View_HFit_HealthAssessment_Joined;

    DECLARE
    @View_EDW_HealthAssesmentQuestions
    TABLE
    (
          QuestionType nvarchar (100) NOT NULL
        , Title nvarchar (max) NOT NULL
        , Weight int  NOT NULL
        , IsRequired bit  NOT NULL
        , QuestionImageLeft nvarchar (256) NULL
        , QuestionImageRight nvarchar (256) NULL
        , NodeGUID uniqueidentifier  NOT NULL
        , DocumentCulture nvarchar (10) NOT NULL
        , IsEnabled bit  NOT NULL
        , IsVisible nvarchar (max) NULL
        , IsStaging bit  NOT NULL
        , CodeName nvarchar (100) NOT NULL
        , QuestionGroupCodeName nvarchar (100) NULL
        , NodeAliasPath nvarchar (450) NOT NULL
        , DocumentPublishedVersionHistoryID int  NULL
        , NodeLevel int  NOT NULL
        , NodeOrder int  NULL
        , NodeID int  NOT NULL
        , NodeParentID int  NOT NULL
        , NodeLinkedNodeID int  NULL
        , DontKnowEnabled int  NULL
        , DontKnowLabel nvarchar (50) NOT NULL
        , ParentNodeOrder int  NULL
        , DocumentGuid uniqueidentifier  NULL
        , DocumentModifiedWhen datetime  NULL
          PRIMARY KEY (DocumentCulture , NodeGUID) 
    );

    INSERT INTO @View_EDW_HealthAssesmentQuestions
    (
           QuestionType
         , Title
         , Weight
         , IsRequired
         , QuestionImageLeft
         , QuestionImageRight
         , NodeGUID
         , DocumentCulture
         , IsEnabled
         , IsVisible
         , IsStaging
         , CodeName
         , QuestionGroupCodeName
         , NodeAliasPath
         , DocumentPublishedVersionHistoryID
         , NodeLevel
         , NodeOrder
         , NodeID
         , NodeParentID
         , NodeLinkedNodeID
         , DontKnowEnabled
         , DontKnowLabel
         , ParentNodeOrder
         , DocumentGuid
         , DocumentModifiedWhen) 
    SELECT
           QuestionType
         , Title
         , Weight
         , IsRequired
         , QuestionImageLeft
         , QuestionImageRight
         , NodeGUID
         , DocumentCulture
         , IsEnabled
         , IsVisible
         , IsStaging
         , CodeName
         , QuestionGroupCodeName
         , NodeAliasPath
         , DocumentPublishedVersionHistoryID
         , NodeLevel
         , NodeOrder
         , NodeID
         , NodeParentID
         , NodeLinkedNodeID
         , DontKnowEnabled
         , DontKnowLabel
         , ParentNodeOrder
         , DocumentGuid
         , DocumentModifiedWhen
           FROM dbo.View_EDW_HealthAssesmentQuestions;
    --**************** TEMP TABLES end  *************************************

    PRINT 'TempData Loaded: ';
    PRINT CHAR ( 10) ;
    PRINT GETDATE () ;
    PRINT CHAR ( 10) ;
    PRINT 'Seconds: ' + CAST ( DATEDIFF ( second , @ST , GETDATE ()) AS nvarchar (50)) ;
    PRINT CHAR ( 10) ;

    --************************************************************
    --TO THIS POINT: Averages around 3 minutes. WDM 06.01.2015
    --TO THIS POINT: Averages around 5 minutes, now - more temp tables. WDM 06.01.2015

    DECLARE
    @StDataLoad AS datetime = GETDATE () ;
    SELECT
           HAUserStarted.ItemID AS UserStartedItemID
         , VHAJ.NodeGUID AS HealthAssesmentUserStartedNodeGUID
         , HAUserStarted.UserID
         , CMSUser.UserGUID
         , UserSettings.HFitUserMpiNumber
         , CMSSite.SiteGUID
         , ACCT.AccountID
         , ACCT.AccountCD
         , ACCT.AccountName
         , HAUserStarted.HAStartedDt
         , HAUserStarted.HACompletedDt
         , HAUserModule.ItemID AS UserModuleItemId
         , HAUserModule.CodeName AS UserModuleCodeName
         , HAUserModule.HAModuleNodeGUID
         , VHAJ.NodeGUID AS CMSNodeGuid
         , NULL AS HAModuleVersionID
         , HARiskCategory.ItemID AS UserRiskCategoryItemID
         , HARiskCategory.CodeName AS UserRiskCategoryCodeName
         , HARiskCategory.HARiskCategoryNodeGUID
         , NULL AS HARiskCategoryVersionID
         , HAUserRiskArea.ItemID AS UserRiskAreaItemID
         , HAUserRiskArea.CodeName AS UserRiskAreaCodeName
         , HAUserRiskArea.HARiskAreaNodeGUID
         , NULL AS HARiskAreaVersionID
         , HAUserQuestion.ItemID AS UserQuestionItemID
         , dbo.udf_StripHTML ( HAQuestionsView.Title) AS Title
         , HAUserQuestion.HAQuestionNodeGUID AS HAQuestionGuid
         , HAUserQuestion.CodeName AS UserQuestionCodeName
         , NULL AS HAQuestionDocumentID
         , NULL AS HAQuestionVersionID
         , HAUserQuestion.HAQuestionNodeGUID
         , HAUserAnswers.ItemID AS UserAnswerItemID
         , HAUserAnswers.HAAnswerNodeGUID
         , NULL AS HAAnswerVersionID
         , HAUserAnswers.CodeName AS UserAnswerCodeName
         , HAUserAnswers.HAAnswerValue
         , HAUserModule.HAModuleScore
         , HARiskCategory.HARiskCategoryScore
         , HAUserRiskArea.HARiskAreaScore
         , HAUserQuestion.HAQuestionScore
         , HAUserAnswers.HAAnswerPoints
         , HAUserQuestionGroupResults.PointResults
         , HAUserAnswers.UOMCode
         , HAUserStarted.HAScore
         , HAUserModule.PreWeightedScore AS ModulePreWeightedScore
         , HARiskCategory.PreWeightedScore AS RiskCategoryPreWeightedScore
         , HAUserRiskArea.PreWeightedScore AS RiskAreaPreWeightedScore
         , HAUserQuestion.PreWeightedScore AS QuestionPreWeightedScore
         , HAUserQuestionGroupResults.CodeName AS QuestionGroupCodeName
         , COALESCE ( CT_CMS_User.SYS_CHANGE_OPERATION , CT_CMS_UserSettings.SYS_CHANGE_OPERATION , CT_CMS_Site.SYS_CHANGE_OPERATION , CT_CMS_UserSite.SYS_CHANGE_OPERATION , CT_HFit_Account.SYS_CHANGE_OPERATION , CT_HFit_HealthAssesmentUserAnswers.SYS_CHANGE_OPERATION ,
           CT_HFit_HealthAssesmentUserModule.SYS_CHANGE_OPERATION , CT_HFit_HealthAssesmentUserQuestion.SYS_CHANGE_OPERATION ,
           CT_HFit_HealthAssesmentUserQuestionGroupResults.SYS_CHANGE_OPERATION , CT_HFit_HealthAssesmentUserRiskArea.SYS_CHANGE_OPERATION ,
           CT_HFit_HealthAssesmentUserRiskCategory.SYS_CHANGE_OPERATION , CT_HFit_HealthAssesmentUserStarted.SYS_CHANGE_OPERATION) AS ChangeType
         , HAUserAnswers.ItemCreatedWhen
         , HAUserAnswers.ItemModifiedWhen
         , HAUserQuestion.IsProfessionallyCollected
         , HARiskCategory.ItemModifiedWhen AS HARiskCategory_ItemModifiedWhen
         , HAUserRiskArea.ItemModifiedWhen AS HAUserRiskArea_ItemModifiedWhen
         , HAUserQuestion.ItemModifiedWhen AS HAUserQuestion_ItemModifiedWhen
         , HAUserAnswers.ItemModifiedWhen AS HAUserAnswers_ItemModifiedWhen
         , HAUserStarted.HAPaperFlg
         , HAUserStarted.HATelephonicFlg
         , HAUserStarted.HAStartedMode
         , HAUserStarted.HACompletedMode
         , VHCJ.DocumentCulture AS DocumentCulture_VHCJ
         , HAQuestionsView.DocumentCulture AS DocumentCulture_HAQuestionsView
         , HAUserStarted.HACampaignNodeGUID AS CampaignNodeGUID
         , VHCJ.HACampaignID
         , CAST ( HASHBYTES ( 'sha1' ,
           ISNULL ( CAST ( HAUserStarted.ItemID AS nvarchar (100)) , '-') + ISNULL ( CAST ( VHAJ.NodeGUID  AS nvarchar (100)) , '-') + ISNULL ( CAST (
           HAUserStarted.UserID AS nvarchar (100)) , '-') + ISNULL ( CAST ( CMSUser.UserGUID AS nvarchar (100)) , '-') + ISNULL ( CAST ( UserSettings.HFitUserMpiNumber AS nvarchar (100)) , '-') + ISNULL ( CAST ( CMSSite.SiteGUID AS nvarchar (100)) , '-') + ISNULL ( CAST ( ACCT.AccountID AS nvarchar (100)) , '-') + ISNULL ( CAST ( ACCT.AccountCD AS nvarchar (100)) , '-') + ISNULL ( CAST ( ACCT.AccountName AS nvarchar (100)) , '-') + ISNULL ( CAST (
           HAUserStarted.HAStartedDt AS nvarchar (100)) , '-') + ISNULL ( CAST ( HAUserStarted.HACompletedDt AS nvarchar (100)) , '-') + ISNULL ( CAST (
           HAUserModule.ItemID  AS nvarchar (100)) , '-') + ISNULL ( CAST ( HAUserModule.CodeName  AS nvarchar (100)) , '-') + ISNULL ( CAST ( HAUserModule.HAModuleNodeGUID AS nvarchar (100)) , '-') + ISNULL ( CAST ( VHAJ.NodeGUID  AS nvarchar (100)) , '-') + ISNULL ( CAST ( HARiskCategory.ItemID AS nvarchar (100)) , '-') + ISNULL ( CAST ( HARiskCategory.CodeName AS nvarchar (100)) , '-') + ISNULL ( CAST ( HARiskCategory.HARiskCategoryNodeGUID AS nvarchar (100)) , '-') + ISNULL ( CAST ( HAUserRiskArea.ItemID AS nvarchar (100)) , '-') + ISNULL ( CAST ( HAUserRiskArea.CodeName AS nvarchar (100)) ,
           '-') + ISNULL ( CAST ( HAUserRiskArea.HARiskAreaNodeGUID AS nvarchar (100)) , '-') + ISNULL ( CAST ( HAUserQuestion.ItemID AS nvarchar (100)) , '-') + ISNULL ( LEFT ( HAQuestionsView.Title , 1000) , '-') + ISNULL ( CAST ( HAUserQuestion.HAQuestionNodeGUID  AS nvarchar (100)) , '-') + ISNULL ( CAST (
           HAUserQuestion.CodeName  AS nvarchar (100)) , '-') + ISNULL ( CAST ( HAUserQuestion.HAQuestionNodeGUID AS nvarchar (100)) , '-') + ISNULL ( CAST (
           HAUserAnswers.ItemID AS nvarchar (100)) , '-') + ISNULL ( CAST ( HAUserAnswers.HAAnswerNodeGUID AS nvarchar (100)) , '-') + ISNULL ( CAST (
           HAUserAnswers.CodeName AS nvarchar (100)) , '-') + ISNULL ( CAST ( HAUserAnswers.HAAnswerValue AS nvarchar (100)) , '-') + ISNULL ( CAST ( HAUserModule.HAModuleScore AS nvarchar (100)) , '-') + ISNULL ( CAST ( HARiskCategory.HARiskCategoryScore AS nvarchar (100)) , '-') + ISNULL ( CAST (
           HAUserRiskArea.HARiskAreaScore AS nvarchar (100)) , '-') + ISNULL ( CAST ( HAUserQuestion.HAQuestionScore AS nvarchar (100)) , '-') + ISNULL ( CAST (
           HAUserAnswers.HAAnswerPoints AS nvarchar (100)) , '-') + ISNULL ( CAST ( HAUserQuestionGroupResults.PointResults AS nvarchar (100)) , '-') + ISNULL (
           CAST ( HAUserAnswers.UOMCode AS nvarchar (100)) , '-') + ISNULL ( CAST ( HAUserStarted.HAScore AS nvarchar (100)) , '-') + ISNULL ( CAST ( HAUserModule.PreWeightedScore AS nvarchar (100)) , '-') + ISNULL ( CAST ( HARiskCategory.PreWeightedScore  AS nvarchar (100)) , '-') + ISNULL ( CAST (
           HAUserRiskArea.PreWeightedScore  AS nvarchar (100)) , '-') + ISNULL ( CAST ( HAUserQuestion.PreWeightedScore  AS nvarchar (100)) , '-') + ISNULL ( CAST
           ( HAUserQuestionGroupResults.CodeName AS nvarchar (100)) , '-') + ISNULL ( CAST ( HAUserAnswers.ItemCreatedWhen AS nvarchar (100)) , '-') + ISNULL (
           CAST ( HAUserAnswers.ItemModifiedWhen AS nvarchar (100)) , '-') + ISNULL ( CAST ( HAUserQuestion.IsProfessionallyCollected AS nvarchar (100)) , '-') + ISNULL ( CAST ( HARiskCategory.ItemModifiedWhen AS nvarchar (100)) , '-') + ISNULL ( CAST ( HAUserRiskArea.ItemModifiedWhen AS nvarchar (100)) , '-') + ISNULL ( CAST ( HAUserQuestion.ItemModifiedWhen AS nvarchar (100)) , '-') + ISNULL ( CAST ( HAUserAnswers.ItemModifiedWhen AS nvarchar (100)) , '-') + ISNULL ( CAST ( HAUserStarted.HAPaperFlg AS nvarchar (100)) , '-') + ISNULL ( CAST ( HAUserStarted.HATelephonicFlg AS nvarchar (100)) , '-') + ISNULL (
           CAST ( HAUserStarted.HAStartedMode AS nvarchar (100)) , '-') + ISNULL ( CAST ( HAUserStarted.HACompletedMode AS nvarchar (100)) , '-') + ISNULL ( CAST
           ( HAUserStarted.HACampaignNodeGUID AS nvarchar (100)) , '-') + ISNULL ( CAST ( VHCJ.HACampaignID AS nvarchar (100)) , '-') + ISNULL ( CAST (
           HAUserAnswers.ItemModifiedWhen AS nvarchar (100)) , '-')) AS varchar (100)) AS HashCode
         , CAST ( HASHBYTES ( 'sha1' , ISNULL ( CAST ( HAUserStarted.ItemID AS varchar (50)) , '-') + ISNULL ( CAST ( VHAJ.NodeGUID  AS varchar (50)) , '-') + ISNULL ( CAST ( UserGUID AS varchar (50)) , '-') + ISNULL ( CAST ( SiteGUID AS varchar (50)) , '-') + ISNULL ( CAST ( ACCT.AccountID AS varchar (50)) , '-') + ISNULL ( CAST ( AccountCD AS varchar (50)) , '-') + ISNULL ( CAST ( HAUserModule.ItemID AS varchar (50)) , '-') + ISNULL ( CAST ( HAModuleNodeGUID AS varchar (50)) , '-') + ISNULL ( CAST ( VHAJ.NodeGUID AS varchar (50)) , '-') + ISNULL ( CAST ( HARiskCategory.ItemID AS varchar (50)) , '-') + ISNULL ( CAST ( HARiskCategoryNodeGUID AS varchar (50)) , '-') + ISNULL ( CAST ( HARiskCategory.CodeName AS varchar (100)) , '-') + ISNULL ( CAST ( HARiskCategory.HARiskCategoryNodeGUID AS varchar (50)) , '-') + ISNULL ( CAST ( HAUserRiskArea.ItemID AS varchar (50)) , '-') + ISNULL ( CAST ( HARiskAreaNodeGUID AS varchar (50)) , '-') + ISNULL ( CAST ( HAUserRiskArea.CodeName AS varchar (50)) , '-') + ISNULL ( CAST ( HAUserQuestion.ItemID AS varchar (50)) , '-') + ISNULL ( CAST ( HAUserQuestion.HAQuestionNodeGUID AS varchar (50)) , '-') + ISNULL ( CAST ( HAUserQuestion.CodeName AS varchar (50)) , '-') + ISNULL ( CAST ( HAQuestionNodeGUID AS varchar (50)) , '-') + ISNULL ( CAST ( HAUserAnswers.ItemID AS varchar (50)) , '-') + ISNULL ( CAST ( HAAnswerNodeGUID   AS varchar (50)) , '-') + ISNULL ( CAST ( HAUserStarted.HACampaignNodeGUID AS varchar (50)) , '-')) AS varchar (100)) AS PKHashCode
         , COALESCE ( CT_CMS_User.UserID , CT_CMS_UserSettings.UserSettingsID , CT_CMS_Site.SiteID , CT_CMS_UserSite.UserSiteID , CT_HFit_Account.AccountID , CT_HFit_HealthAssesmentUserAnswers.ItemID , CT_HFit_HealthAssesmentUserModule.ItemID , CT_HFit_HealthAssesmentUserQuestion.ItemID , CT_HFit_HealthAssesmentUserQuestionGroupResults.ItemID , CT_HFit_HealthAssesmentUserRiskArea.ItemID , CT_HFit_HealthAssesmentUserRiskCategory.ItemID , CT_HFit_HealthAssesmentUserStarted.ItemID) AS CHANGED_FLG

           --*************************************
           --join changes to the records 

         , CT_CMS_User.UserID AS CT_CMS_User_UserID
         , CT_CMS_User.SYS_CHANGE_OPERATION AS CT_CMS_User_CHANGE_OPERATION
         , CT_CMS_UserSettings.UserSettingsID AS CT_UserSettingsID
         , CT_CMS_UserSettings.SYS_CHANGE_OPERATION AS CT_UserSettingsID_CHANGE_OPERATION
         , CT_CMS_Site.SiteID AS SiteID_CtID
         , CT_CMS_Site.SYS_CHANGE_OPERATION AS SiteID_CHANGE_OPERATION
         , CT_CMS_UserSite.UserSiteID AS UserSiteID_CtID
         , CT_CMS_UserSite.SYS_CHANGE_OPERATION AS UserSiteID_CHANGE_OPERATION
         , CT_HFit_Account.AccountID AS AccountID_CtID
         , CT_HFit_Account.SYS_CHANGE_OPERATION AS AccountID__CHANGE_OPERATION
         , CT_HFit_HealthAssesmentUserAnswers.ItemID AS HAUserAnswers_CtID
         , CT_HFit_HealthAssesmentUserAnswers.SYS_CHANGE_OPERATION AS HAUserAnswers_CHANGE_OPERATION
         , CT_HFit_HealthAssesmentUserModule.ItemID AS HFit_HealthAssesmentUserModule_CtID
         , CT_HFit_HealthAssesmentUserModule.SYS_CHANGE_OPERATION AS HFit_HealthAssesmentUserModule_CHANGE_OPERATION
         , CT_HFit_HealthAssesmentUserQuestion.ItemID AS HFit_HealthAssesmentUserQuestion_CtID
         , CT_HFit_HealthAssesmentUserQuestion.SYS_CHANGE_OPERATION AS HFit_HealthAssesmentUserQuestion_CHANGE_OPERATION
         , CT_HFit_HealthAssesmentUserQuestionGroupResults.ItemID AS HFit_HealthAssesmentUserQuestionGroupResults_CtID
         , CT_HFit_HealthAssesmentUserQuestionGroupResults.SYS_CHANGE_OPERATION AS HFit_HealthAssesmentUserQuestionGroupResults_CHANGE_OPERATION
         , CT_HFit_HealthAssesmentUserRiskArea.ItemID AS HFit_HealthAssesmentUserRiskArea_CtID
         , CT_HFit_HealthAssesmentUserRiskArea.SYS_CHANGE_OPERATION AS HFit_HealthAssesmentUserRiskArea_CHANGE_OPERATION
         , CT_HFit_HealthAssesmentUserRiskCategory.ItemID AS HFit_HealthAssesmentUserRiskCategory_CtID
         , CT_HFit_HealthAssesmentUserRiskCategory.SYS_CHANGE_OPERATION AS HFit_HealthAssesmentUserRiskCategory_CHANGE_OPERATION
         , CT_HFit_HealthAssesmentUserStarted.ItemID AS HFit_HealthAssesmentUserStarted_CtID
         , CT_HFit_HealthAssesmentUserStarted.SYS_CHANGE_OPERATION AS HFit_HealthAssesmentUserStarted_CHANGE_OPERATION

           --Get the TYPE of change ID NUMBER

         , CT_CMS_User.SYS_CHANGE_VERSION AS CT_CMS_User_SCV
         , CT_CMS_UserSettings.SYS_CHANGE_VERSION AS CT_CMS_UserSettings_SCV
         , CT_CMS_Site.SYS_CHANGE_VERSION AS CT_CMS_Site_SCV
         , CT_CMS_UserSite.SYS_CHANGE_VERSION AS CT_CMS_UserSite_SCV
         , CT_HFit_Account.SYS_CHANGE_VERSION AS CT_HFit_Account_SCV
         , CT_HFit_HealthAssesmentUserAnswers.SYS_CHANGE_VERSION AS CT_HFit_HealthAssesmentUserAnswers_SCV
         , CT_HFit_HealthAssesmentUserModule.SYS_CHANGE_VERSION AS CT_HFit_HealthAssesmentUserModule_SCV
         , CT_HFit_HealthAssesmentUserQuestion.SYS_CHANGE_VERSION AS CT_HFit_HealthAssesmentUserQuestion_SCV
         , CT_HFit_HealthAssesmentUserQuestionGroupResults.SYS_CHANGE_VERSION AS CT_HFit_HealthAssesmentUserQuestionGroupResults_SCV
         , CT_HFit_HealthAssesmentUserRiskArea.SYS_CHANGE_VERSION AS CT_HFit_HealthAssesmentUserRiskArea_SCV
         , CT_HFit_HealthAssesmentUserRiskCategory.SYS_CHANGE_VERSION AS CT_HFit_HealthAssesmentUserRiskCategory_SCV
         , CT_HFit_HealthAssesmentUserStarted.SYS_CHANGE_VERSION AS CT_HFit_HealthAssesmentUserStarted_SCV
         , HAUserAnswers.ItemModifiedWhen AS LastModifiedDate
         , 0 AS DeleteFlg
         , GETDATE () AS LastLoadedDate
    INTO
         ##TEMP_HealthAssessmentData_TVAR
           FROM
                dbo.HFit_HealthAssesmentUserStarted AS HAUserStarted
                     INNER JOIN dbo.CMS_User AS CMSUser
                     ON HAUserStarted.UserID = CMSUser.UserID
                     INNER JOIN dbo.CMS_UserSettings AS UserSettings
                     ON
                        UserSettings.UserSettingsUserID = CMSUser.UserID AND
                        HFitUserMpiNumber >= 0 AND
                        HFitUserMpiNumber IS NOT NULL
                     INNER JOIN dbo.CMS_UserSite AS UserSite
                     ON CMSUser.UserID = UserSite.UserID
                     INNER JOIN dbo.CMS_Site AS CMSSite
                     ON UserSite.SiteID = CMSSite.SiteID
                     INNER JOIN dbo.HFit_Account AS ACCT
                     ON ACCT.SiteID = CMSSite.SiteID
                     INNER JOIN dbo.HFit_HealthAssesmentUserModule AS HAUserModule
                     ON HAUserStarted.ItemID = HAUserModule.HAStartedItemID
                     INNER JOIN @View_HFit_HACampaign_Joined AS VHCJ
                     ON
                        VHCJ.NodeGUID = HAUserStarted.HACampaignNodeGUID AND
                        VHCJ.NodeSiteID = UserSite.SiteID AND
                        VHCJ.DocumentCulture = 'en-US'
                     INNER JOIN @View_HFit_HealthAssessment_Joined AS VHAJ
                     ON VHAJ.DocumentID = VHCJ.HealthAssessmentID
                     INNER JOIN dbo.HFit_HealthAssesmentUserRiskCategory AS HARiskCategory
                     ON HAUserModule.ItemID = HARiskCategory.HAModuleItemID
                     INNER JOIN @BASE_HFIT_HEALTHASSESMENTUSERRISKAREA AS HAUserRiskArea
                     ON HARiskCategory.ItemID = HAUserRiskArea.HARiskCategoryItemID
                     INNER JOIN @BASE_HFIT_HEALTHASSESMENTUSERQUESTION AS HAUserQuestion
                     ON HAUserRiskArea.ItemID = HAUserQuestion.HARiskAreaItemID
                     INNER JOIN @View_EDW_HealthAssesmentQuestions AS HAQuestionsView
                     ON HAUserQuestion.HAQuestionNodeGUID = HAQuestionsView.NodeGUID
                     LEFT OUTER JOIN @FACT_EDW_HFit_HealthAssesmentUserQuestionGroupResults AS HAUserQuestionGroupResults
                     ON HAUserRiskArea.ItemID = HAUserQuestionGroupResults.HARiskAreaItemID
                     INNER JOIN @BASE_HFit_HealthAssesmentUserAnswers AS HAUserAnswers
                     ON HAUserQuestion.ItemID = HAUserAnswers.HAQuestionItemID --**********************************
                --Add in the change tracking data
                     LEFT JOIN CHANGETABLE (CHANGES CMS_UserSettings , NULL) AS CT_CMS_UserSettings
                     ON UserSettings.UserSettingsID = CT_CMS_UserSettings.UserSettingsID
                     LEFT JOIN CHANGETABLE (CHANGES CMS_User , NULL) AS CT_CMS_User
                     ON CMSUser.UserID = CT_CMS_User.UserID
                     LEFT OUTER JOIN CHANGETABLE (CHANGES CMS_Site , NULL) AS CT_CMS_Site
                     ON CMSSite.SiteID = CT_CMS_Site.SiteID
                     LEFT OUTER JOIN CHANGETABLE (CHANGES CMS_UserSite , NULL) AS CT_CMS_UserSite
                     ON UserSite.UserSiteID = CT_CMS_UserSite.UserSiteID
                     LEFT OUTER JOIN CHANGETABLE (CHANGES HFit_Account , NULL) AS CT_HFit_Account
                     ON ACCT.AccountID = CT_HFit_Account.AccountID
                     LEFT OUTER JOIN CHANGETABLE (CHANGES HFit_HACampaign , NULL) AS CT_HFit_HACampaign
                     ON VHCJ.HACampaignID = CT_HFit_HACampaign.HACampaignID
                     LEFT OUTER JOIN CHANGETABLE (CHANGES BASE_HFit_HealthAssesmentUserAnswers , NULL) AS CT_HFit_HealthAssesmentUserAnswers
                     ON HAUserAnswers.ItemID = CT_HFit_HealthAssesmentUserAnswers.ItemID
                     LEFT OUTER JOIN CHANGETABLE (CHANGES HFit_HealthAssesmentUserModule , NULL) AS CT_HFit_HealthAssesmentUserModule
                     ON HAUserModule.ItemID = CT_HFit_HealthAssesmentUserModule.ItemID
                     LEFT OUTER JOIN CHANGETABLE (CHANGES BASE_HFIT_HEALTHASSESMENTUSERQUESTION , NULL) AS CT_HFit_HealthAssesmentUserQuestion
                     ON HAUserQuestion.ItemID = CT_HFit_HealthAssesmentUserQuestion.ItemID
                     LEFT OUTER JOIN CHANGETABLE (CHANGES FACT_EDW_HFit_HealthAssesmentUserQuestionGroupResults , NULL) AS CT_HFit_HealthAssesmentUserQuestionGroupResults
                     ON HAUserQuestionGroupResults.ItemID = CT_HFit_HealthAssesmentUserQuestionGroupResults.ItemID
                     LEFT OUTER JOIN CHANGETABLE (CHANGES BASE_HFIT_HEALTHASSESMENTUSERRISKAREA , NULL) AS CT_HFit_HealthAssesmentUserRiskArea
                     ON HAUserRiskArea.ItemID = CT_HFit_HealthAssesmentUserRiskArea.ItemID
                     LEFT OUTER JOIN CHANGETABLE (CHANGES HFit_HealthAssesmentUserRiskCategory , NULL) AS CT_HFit_HealthAssesmentUserRiskCategory
                     ON HARiskCategory.ItemID = CT_HFit_HealthAssesmentUserRiskCategory.ItemID
                     LEFT OUTER JOIN CHANGETABLE (CHANGES HFit_HealthAssesmentUserStarted , NULL) AS CT_HFit_HealthAssesmentUserStarted
                     ON HAUserStarted.ItemID = CT_HFit_HealthAssesmentUserStarted.ItemID
           WHERE UserSettings.HFitUserMpiNumber NOT IN (
           SELECT
                  RejectMPICode
                  FROM BASE_HFIT_LKP_EDW_REJECTMPI) ;

    DECLARE
    @recs AS int = @@ROWCOUNT;
    DECLARE
    @LoadTimeHA AS float = 0;
    DECLARE
    @secs AS float = 0;
    SET @secs = DATEDIFF ( second , @StDataLoad , GETDATE ()) ;
    SET @LoadTimeHA = @secs / 60 / 60;
    PRINT 'HA DAta Loaded: ';
    PRINT CHAR ( 10) ;
    PRINT GETDATE () ;
    PRINT CHAR ( 10) ;
    PRINT 'Total Records Loaded : ' + CAST ( @recs AS nvarchar (50)) ;
    PRINT CHAR ( 10) ;
    PRINT 'Pull Time in Hours : ' + CAST ( @LoadTimeHA AS nvarchar (50)) ;
    PRINT CHAR ( 10) ;
    DECLARE
    @StIndexing AS datetime = GETDATE () ;
    IF NOT EXISTS ( SELECT
                           name
                           FROM sys.indexes
                           WHERE name = 'temp_PI_EDW_HealthAssessment_ChangeType') 
        BEGIN
            CREATE INDEX temp_PI_EDW_HealthAssessment_ChangeType ON ##HealthAssessmentData ( ChangeType) 
            WITH ( PAD_INDEX = OFF , STATISTICS_NORECOMPUTE = OFF , SORT_IN_TEMPDB = OFF , DROP_EXISTING = OFF , ONLINE = OFF ,
            ALLOW_ROW_LOCKS = ON ,
            ALLOW_PAGE_LOCKS = ON) ;
        END;
    IF NOT EXISTS ( SELECT
                           name
                           FROM sys.indexes
                           WHERE name = 'temp_PI_EDW_HealthAssessment_NATKEY') 
        BEGIN
            CREATE INDEX temp_PI_EDW_HealthAssessment_NATKEY ON dbo.##HealthAssessmentData ( UserStartedItemID , UserGUID , PKHashCode , HashCode , LastModifiedDate
            );
        END;
    DECLARE
    @IdxTime AS float = 0;
    DECLARE
    @IdxSecs AS float = 0;
    SET @IdxSecs = DATEDIFF ( second , @StIndexing , GETDATE ()) ;
    SET @IdxTime = @secs / 60 / 60;
    PRINT 'Indexes Created: ';
    PRINT CHAR ( 10) ;
    PRINT GETDATE () ;
    PRINT CHAR ( 10) ;
    PRINT 'Index Time in Hours : ' + CAST ( @IdxTime AS nvarchar (50)) ;
    PRINT CHAR ( 10) ;
    DECLARE
    @ET AS datetime = GETDATE () ;
    DECLARE
    @T AS float = DATEDIFF ( minute , @ST , @ET) 
  , @H AS float = 0;
    SET @H = @T / 60;
    PRINT 'Process Started:';
    PRINT CHAR ( 10) ;
    PRINT @ST;
    PRINT CHAR ( 10) ;
    PRINT 'Process Ended:';
    PRINT CHAR ( 10) ;
    PRINT @ET;
    PRINT CHAR ( 10) ;
    PRINT CHAR ( 10) ;
    PRINT 'TOTAL ROWS: ' + CAST ( @recs AS nvarchar (50)) ;
    PRINT CHAR ( 10) ;
    PRINT 'TOTAL Hours: ' + CAST ( @H AS nvarchar (50)) ;
END;
GO
PRINT 'Created proc_Denormalize_EDW_HealthAssessment_Views_TVAR.sql';
GO
