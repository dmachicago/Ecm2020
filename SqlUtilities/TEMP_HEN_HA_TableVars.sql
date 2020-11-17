DECLARE
@HFit_HealthAssesmentUserAnswers
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

DECLARE
@HFit_HealthAssesmentUserRiskArea
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
, CodeName nvarchar  (100) NOT NULL 
, PreWeightedScore float  NULL 
, HARiskCategoryDocumentID_old int  NOT NULL 
, HARiskAreaNodeGUID uniqueidentifier  NOT NULL 
, HARiskAreaDocumentID_old int  NOT NULL 
, HARiskAreaVersionID_old bigint  NULL 
 PRIMARY KEY ( ItemID, HARiskCategoryItemID )
)


DECLARE
@HFit_HealthAssesmentUserQuestionGroupResults
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
, CodeName nvarchar  (100) NOT NULL 
 PRIMARY KEY (  ItemID, PointResults , CodeName , HARiskAreaItemID )
)

DECLARE
@HFit_HealthAssesmentUserQuestion
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
, CodeName nvarchar  (100) NOT NULL 
, PreWeightedScore float  NULL 
, IsProfessionallyCollected bit  NOT NULL 
, ProfessionallyCollectedEventDate datetime  NULL 
, HARiskAreaDocumentID_old int  NOT NULL 
, HAQuestionNodeGUID uniqueidentifier  NOT NULL 
, HAQuestionDocumentID_old int  NOT NULL 
, HAQuestionVersionID_old bigint  NULL 
 PRIMARY KEY ( ItemID, UserID )
)

DECLARE
@View_HFit_HACampaign_Joined
TABLE
(
Published int  NOT NULL 
, SiteName nvarchar  (100) NOT NULL 
, ClassName nvarchar  (100) NOT NULL 
, ClassDisplayName nvarchar  (100) NOT NULL 
, NodeID int  NOT NULL 
, NodeAliasPath nvarchar  (450) NOT NULL 
, NodeName nvarchar  (100) NOT NULL 
, NodeAlias nvarchar  (50) NOT NULL 
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
, NodeInheritPageLevels nvarchar  (200) NULL 
, NodeChildNodesCount int  NULL 
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
, NodeWireframeInheritPageLevels nvarchar  (450) NULL 
, NodeAllowCacheInFileSystem bit  NULL 
, DocumentID int  NOT NULL 
, DocumentName nvarchar  (100) NOT NULL 
, DocumentNamePath nvarchar  (1500) NULL 
, DocumentModifiedWhen datetime  NULL 
, DocumentModifiedByUserID int  NULL 
, DocumentForeignKeyValue int  NULL 
, DocumentCreatedByUserID int  NULL 
, DocumentCreatedWhen datetime  NULL 
, DocumentCheckedOutByUserID int  NULL 
, DocumentCheckedOutWhen datetime  NULL 
, DocumentCheckedOutVersionHistoryID int  NULL 
, DocumentPublishedVersionHistoryID int  NULL 
, DocumentWorkflowStepID int  NULL 
, DocumentPublishFrom datetime  NULL 
, DocumentPublishTo datetime  NULL 
, DocumentUrlPath nvarchar  (450) NULL 
, DocumentCulture nvarchar  (10) NOT NULL 
, DocumentNodeID int  NOT NULL 
, DocumentPageTitle nvarchar (max) NULL 
, DocumentPageKeyWords nvarchar (max) NULL 
, DocumentPageDescription nvarchar (max) NULL 
, DocumentShowInSiteMap bit  NOT NULL 
, DocumentMenuItemHideInNavigation bit  NOT NULL 
, DocumentMenuCaption nvarchar  (200) NULL 
, DocumentMenuStyle nvarchar  (100) NULL 
, DocumentMenuItemImage nvarchar  (200) NULL 
, DocumentMenuItemLeftImage nvarchar  (200) NULL 
, DocumentMenuItemRightImage nvarchar  (200) NULL 
, DocumentPageTemplateID int  NULL 
, DocumentMenuJavascript nvarchar  (450) NULL 
, DocumentMenuRedirectUrl nvarchar  (450) NULL 
, DocumentUseNamePathForUrlPath bit  NULL 
, DocumentStylesheetID int  NULL 
, DocumentContent nvarchar (max) NULL 
, DocumentMenuClass nvarchar  (100) NULL 
, DocumentMenuStyleOver nvarchar  (200) NULL 
, DocumentMenuClassOver nvarchar  (100) NULL 
, DocumentMenuItemImageOver nvarchar  (200) NULL 
, DocumentMenuItemLeftImageOver nvarchar  (200) NULL 
, DocumentMenuItemRightImageOver nvarchar  (200) NULL 
, DocumentMenuStyleHighlighted nvarchar  (200) NULL 
, DocumentMenuClassHighlighted nvarchar  (100) NULL 
, DocumentMenuItemImageHighlighted nvarchar  (200) NULL 
, DocumentMenuItemLeftImageHighlighted nvarchar  (200) NULL 
, DocumentMenuItemRightImageHighlighted nvarchar  (200) NULL 
, DocumentMenuItemInactive bit  NULL 
, DocumentCustomData nvarchar (max) NULL 
, DocumentExtensions nvarchar  (100) NULL 
, DocumentCampaign nvarchar  (100) NULL 
, DocumentTags nvarchar (max) NULL 
, DocumentTagGroupID int  NULL 
, DocumentWildcardRule nvarchar  (440) NULL 
, DocumentWebParts nvarchar (max) NULL 
, DocumentRatingValue float  NULL 
, DocumentRatings int  NULL 
, DocumentPriority int  NULL 
, DocumentType nvarchar  (50) NULL 
, DocumentLastPublished datetime  NULL 
, DocumentUseCustomExtensions bit  NULL 
, DocumentGroupWebParts nvarchar (max) NULL 
, DocumentCheckedOutAutomatically bit  NULL 
, DocumentTrackConversionName nvarchar  (200) NULL 
, DocumentConversionValue nvarchar  (100) NULL 
, DocumentSearchExcluded bit  NULL 
, DocumentLastVersionName nvarchar  (100) NULL 
, DocumentLastVersionNumber nvarchar  (50) NULL 
, DocumentIsArchived bit  NULL 
, DocumentLastVersionType nvarchar  (50) NULL 
, DocumentLastVersionMenuRedirectUrl nvarchar  (450) NULL 
, DocumentHash nvarchar  (32) NULL 
, DocumentLogVisitActivity bit  NULL 
, DocumentGUID uniqueidentifier  NULL 
, DocumentWorkflowCycleGUID uniqueidentifier  NULL 
, DocumentSitemapSettings nvarchar  (100) NULL 
, DocumentIsWaitingForTranslation bit  NULL 
, DocumentSKUName nvarchar  (440) NULL 
, DocumentSKUDescription nvarchar (max) NULL 
, DocumentSKUShortDescription nvarchar (max) NULL 
, DocumentWorkflowActionStatus nvarchar  (450) NULL 
, SKUID int  NULL 
, SKUNumber nvarchar  (200) NULL 
, SKUName nvarchar  (440) NULL 
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
, SKUImagePath nvarchar  (450) NULL 
, SKUWeight float  NULL 
, SKUWidth float  NULL 
, SKUDepth float  NULL 
, SKUHeight float  NULL 
, SKUAvailableItems int  NULL 
, SKUSellOnlyAvailable bit  NULL 
, SKUCustomData nvarchar (max) NULL 
, SKUOptionCategoryID int  NULL 
, SKUOrder int  NULL 
, SKULastModified datetime  NULL 
, SKUCreated datetime  NULL 
, SKUSiteID int  NULL 
, SKUPrivateDonation bit  NULL 
, SKUNeedsShipping bit  NULL 
, SKUMaxDownloads int  NULL 
, SKUValidUntil datetime  NULL 
, SKUProductType nvarchar  (50) NULL 
, SKUMaxItemsInOrder int  NULL 
, SKUMaxPrice float  NULL 
, SKUValidity nvarchar  (50) NULL 
, SKUValidFor int  NULL 
, SKUMinPrice float  NULL 
, SKUMembershipGUID uniqueidentifier  NULL 
, SKUConversionName nvarchar  (100) NULL 
, SKUConversionValue nvarchar  (200) NULL 
, SKUBundleInventoryType nvarchar  (50) NULL 
, SKUMinItemsInOrder int  NULL 
, SKURetailPrice float  NULL 
, SKUParentSKUID int  NULL 
, SKUAllowAllVariants bit  NULL 
, SKUInheritsTaxClasses bit  NULL 
, SKUInheritsDiscounts bit  NULL 
, SKUTrackInventory bit  NULL 
, SKUShortDescription nvarchar (max) NULL 
, SKUEproductFilesCount int  NULL 
, SKUBundleItemsCount int  NULL 
, SKUInStoreFrom datetime  NULL 
, SKUReorderAt int  NULL 
, NodeOwnerFullName nvarchar  (450) NULL 
, NodeOwnerUserName nvarchar  (100) NULL 
, NodeOwnerEmail nvarchar  (100) NULL 
, HACampaignID int  NOT NULL 
, Name nvarchar  (200) NOT NULL 
, Description nvarchar  (512) NULL 
, Enabled bit  NOT NULL 
, SocialProofID int  NULL 
, HealthAssessmentID int  NOT NULL 
, DisplayThreshold int  NOT NULL 
, ProofText nvarchar  (255) NOT NULL 
, SocialProofEndDate datetime  NULL 
, EnableSocialProof bit  NOT NULL 
, HealthAssessmentConfigurationID int  NOT NULL 
, BiometricCampaignStartDate datetime  NULL 
, BiometricCampaignEndDate datetime  NULL 
, ShowProfileConfirmation bit  NOT NULL 
, CampaignStartDate datetime  NOT NULL 
, CampaignEndDate datetime  NOT NULL 
  PRIMARY KEY (DocumentCulture,HACampaignID,NodeGUID,HealthAssessmentID)
)

DECLARE
@View_HFit_HealthAssessment_Joined
TABLE
(
Published int  NOT NULL 
, SiteName nvarchar  (100) NOT NULL 
, ClassName nvarchar  (100) NOT NULL 
, ClassDisplayName nvarchar  (100) NOT NULL 
, NodeID int  NOT NULL 
, NodeAliasPath nvarchar  (450) NOT NULL 
, NodeName nvarchar  (100) NOT NULL 
, NodeAlias nvarchar  (50) NOT NULL 
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
, NodeInheritPageLevels nvarchar  (200) NULL 
, NodeChildNodesCount int  NULL 
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
, NodeWireframeInheritPageLevels nvarchar  (450) NULL 
, NodeAllowCacheInFileSystem bit  NULL 
, DocumentID int  NOT NULL 
, DocumentName nvarchar  (100) NOT NULL 
, DocumentNamePath nvarchar  (1500) NULL 
, DocumentModifiedWhen datetime  NULL 
, DocumentModifiedByUserID int  NULL 
, DocumentForeignKeyValue int  NULL 
, DocumentCreatedByUserID int  NULL 
, DocumentCreatedWhen datetime  NULL 
, DocumentCheckedOutByUserID int  NULL 
, DocumentCheckedOutWhen datetime  NULL 
, DocumentCheckedOutVersionHistoryID int  NULL 
, DocumentPublishedVersionHistoryID int  NULL 
, DocumentWorkflowStepID int  NULL 
, DocumentPublishFrom datetime  NULL 
, DocumentPublishTo datetime  NULL 
, DocumentUrlPath nvarchar  (450) NULL 
, DocumentCulture nvarchar  (10) NOT NULL 
, DocumentNodeID int  NOT NULL 
, DocumentPageTitle nvarchar (max) NULL 
, DocumentPageKeyWords nvarchar (max) NULL 
, DocumentPageDescription nvarchar (max) NULL 
, DocumentShowInSiteMap bit  NOT NULL 
, DocumentMenuItemHideInNavigation bit  NOT NULL 
, DocumentMenuCaption nvarchar  (200) NULL 
, DocumentMenuStyle nvarchar  (100) NULL 
, DocumentMenuItemImage nvarchar  (200) NULL 
, DocumentMenuItemLeftImage nvarchar  (200) NULL 
, DocumentMenuItemRightImage nvarchar  (200) NULL 
, DocumentPageTemplateID int  NULL 
, DocumentMenuJavascript nvarchar  (450) NULL 
, DocumentMenuRedirectUrl nvarchar  (450) NULL 
, DocumentUseNamePathForUrlPath bit  NULL 
, DocumentStylesheetID int  NULL 
, DocumentContent nvarchar (max) NULL 
, DocumentMenuClass nvarchar  (100) NULL 
, DocumentMenuStyleOver nvarchar  (200) NULL 
, DocumentMenuClassOver nvarchar  (100) NULL 
, DocumentMenuItemImageOver nvarchar  (200) NULL 
, DocumentMenuItemLeftImageOver nvarchar  (200) NULL 
, DocumentMenuItemRightImageOver nvarchar  (200) NULL 
, DocumentMenuStyleHighlighted nvarchar  (200) NULL 
, DocumentMenuClassHighlighted nvarchar  (100) NULL 
, DocumentMenuItemImageHighlighted nvarchar  (200) NULL 
, DocumentMenuItemLeftImageHighlighted nvarchar  (200) NULL 
, DocumentMenuItemRightImageHighlighted nvarchar  (200) NULL 
, DocumentMenuItemInactive bit  NULL 
, DocumentCustomData nvarchar (max) NULL 
, DocumentExtensions nvarchar  (100) NULL 
, DocumentCampaign nvarchar  (100) NULL 
, DocumentTags nvarchar (max) NULL 
, DocumentTagGroupID int  NULL 
, DocumentWildcardRule nvarchar  (440) NULL 
, DocumentWebParts nvarchar (max) NULL 
, DocumentRatingValue float  NULL 
, DocumentRatings int  NULL 
, DocumentPriority int  NULL 
, DocumentType nvarchar  (50) NULL 
, DocumentLastPublished datetime  NULL 
, DocumentUseCustomExtensions bit  NULL 
, DocumentGroupWebParts nvarchar (max) NULL 
, DocumentCheckedOutAutomatically bit  NULL 
, DocumentTrackConversionName nvarchar  (200) NULL 
, DocumentConversionValue nvarchar  (100) NULL 
, DocumentSearchExcluded bit  NULL 
, DocumentLastVersionName nvarchar  (100) NULL 
, DocumentLastVersionNumber nvarchar  (50) NULL 
, DocumentIsArchived bit  NULL 
, DocumentLastVersionType nvarchar  (50) NULL 
, DocumentLastVersionMenuRedirectUrl nvarchar  (450) NULL 
, DocumentHash nvarchar  (32) NULL 
, DocumentLogVisitActivity bit  NULL 
, DocumentGUID uniqueidentifier  NULL 
, DocumentWorkflowCycleGUID uniqueidentifier  NULL 
, DocumentSitemapSettings nvarchar  (100) NULL 
, DocumentIsWaitingForTranslation bit  NULL 
, DocumentSKUName nvarchar  (440) NULL 
, DocumentSKUDescription nvarchar (max) NULL 
, DocumentSKUShortDescription nvarchar (max) NULL 
, DocumentWorkflowActionStatus nvarchar  (450) NULL 
, SKUID int  NULL 
, SKUNumber nvarchar  (200) NULL 
, SKUName nvarchar  (440) NULL 
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
, SKUImagePath nvarchar  (450) NULL 
, SKUWeight float  NULL 
, SKUWidth float  NULL 
, SKUDepth float  NULL 
, SKUHeight float  NULL 
, SKUAvailableItems int  NULL 
, SKUSellOnlyAvailable bit  NULL 
, SKUCustomData nvarchar (max) NULL 
, SKUOptionCategoryID int  NULL 
, SKUOrder int  NULL 
, SKULastModified datetime  NULL 
, SKUCreated datetime  NULL 
, SKUSiteID int  NULL 
, SKUPrivateDonation bit  NULL 
, SKUNeedsShipping bit  NULL 
, SKUMaxDownloads int  NULL 
, SKUValidUntil datetime  NULL 
, SKUProductType nvarchar  (50) NULL 
, SKUMaxItemsInOrder int  NULL 
, SKUMaxPrice float  NULL 
, SKUValidity nvarchar  (50) NULL 
, SKUValidFor int  NULL 
, SKUMinPrice float  NULL 
, SKUMembershipGUID uniqueidentifier  NULL 
, SKUConversionName nvarchar  (100) NULL 
, SKUConversionValue nvarchar  (200) NULL 
, SKUBundleInventoryType nvarchar  (50) NULL 
, SKUMinItemsInOrder int  NULL 
, SKURetailPrice float  NULL 
, SKUParentSKUID int  NULL 
, SKUAllowAllVariants bit  NULL 
, SKUInheritsTaxClasses bit  NULL 
, SKUInheritsDiscounts bit  NULL 
, SKUTrackInventory bit  NULL 
, SKUShortDescription nvarchar (max) NULL 
, SKUEproductFilesCount int  NULL 
, SKUBundleItemsCount int  NULL 
, SKUInStoreFrom datetime  NULL 
, SKUReorderAt int  NULL 
, NodeOwnerFullName nvarchar  (450) NULL 
, NodeOwnerUserName nvarchar  (100) NULL 
, NodeOwnerEmail nvarchar  (100) NULL 
, HealthAssessmentID int  NOT NULL 
, QuestionTransformUrl nvarchar  (256) NOT NULL 
, ReviewText nvarchar (max) NULL 
, SubmitButtonText nvarchar  (35) NOT NULL 
, ReviewTitle nvarchar  (100) NOT NULL 
, SubmitRedirectUrl nvarchar  (2000) NOT NULL 
, ReviewUrl nvarchar  (2000) NOT NULL 
, ConfirmationTitle nvarchar  (100) NOT NULL 
, ConfirmationText nvarchar (max) NULL 
, ConfirmationUrl nvarchar  (2000) NOT NULL 
, ConfirmationSubTitle nvarchar  (100) NULL 
, ConfirmationEditButtonText nvarchar  (35) NULL 
, SmallStepTitle nvarchar  (512) NOT NULL 
, SmallStepText nvarchar (max) NOT NULL 
, SmallStepUrl nvarchar  (1024) NOT NULL 
, MinimumOptOut int  NOT NULL 
, MinimumSteps int  NOT NULL 
, MaximumSteps int  NOT NULL 
, IntroText nvarchar (max) NULL 
, Revision int  NOT NULL 
, MyProfileConfirmationUrl nvarchar  (2000) NULL 
, MyProfileConfirmationTitle nvarchar  (100) NULL 
, MyProfileConfirmationText nvarchar (max) NULL 
, HealthAssessmentConfigurationID int  NULL 
, DisplayName nvarchar  (200) NULL 
, ReviewEditButtonText nvarchar  (512) NULL 
, SmallStepOptoutText nvarchar  (512) NULL 
, MinimumStepsError nvarchar  (512) NULL 
, MaximumStepsError nvarchar  (512) NULL 
, WaitMessage nvarchar  (200) NOT NULL 
PRIMARY KEY (NodeGUID ,DocumentID )
)


DECLARE
@View_EDW_HealthAssesmentQuestions
TABLE
(
QuestionType nvarchar  (100) NOT NULL 
, Title nvarchar (max) NOT NULL 
, Weight int  NOT NULL 
, IsRequired bit  NOT NULL 
, QuestionImageLeft nvarchar  (256) NULL 
, QuestionImageRight nvarchar  (256) NULL 
, NodeGUID uniqueidentifier  NOT NULL 
, DocumentCulture nvarchar  (10) NOT NULL 
, IsEnabled bit  NOT NULL 
, IsVisible nvarchar (max) NULL 
, IsStaging bit  NOT NULL 
, CodeName nvarchar  (100) NOT NULL 
, QuestionGroupCodeName nvarchar  (100) NULL 
, NodeAliasPath nvarchar  (450) NOT NULL 
, DocumentPublishedVersionHistoryID int  NULL 
, NodeLevel int  NOT NULL 
, NodeOrder int  NULL 
, NodeID int  NOT NULL 
, NodeParentID int  NOT NULL 
, NodeLinkedNodeID int  NULL 
, DontKnowEnabled int  NULL 
, DontKnowLabel nvarchar  (50) NOT NULL 
, ParentNodeOrder int  NULL 
, DocumentGuid uniqueidentifier  NULL 
, DocumentModifiedWhen datetime  NULL 
  PRIMARY KEY (DocumentCulture ,NodeGUID )
)

 
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
