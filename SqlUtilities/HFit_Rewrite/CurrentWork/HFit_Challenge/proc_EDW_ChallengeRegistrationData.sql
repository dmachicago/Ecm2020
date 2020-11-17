


GO
--exec proc_EDW_ChallengeRegistrationData
alter proc proc_EDW_ChallengeRegistrationData
as
--*************************************************************************
--Create the temporary Challenge Registration data table
--*************************************************************************
IF OBJECT_ID('tempdb..#EDW_ChallengeRegistrationData') IS NOT NULL 
BEGIN
	print ('Dropped tempdb..#EDW_ChallengeRegistrationData') ;
	drop table #EDW_ChallengeRegistrationData ;
--	CREATE TABLE #EDW_ChallengeRegistrationData (
--	[HFit_ChallengeID] [int] NOT NULL,
--	[HFit_Title] [nvarchar](128) NOT NULL,
--	[HFit_Description] [nvarchar](4000) NULL,
--	[HFit_Enabled] [bit] NULL,
--	[HFit_RegistrationStart] [datetime] NULL,
--	[HFit_RegistrationEnd] [datetime] NULL,
--	[HFit_ChallengeStart] [datetime] NULL,
--	[HFit_ChallengeEnd] [datetime] NULL,
--	[HFit_PostSurveyEnd] [datetime] NULL,
--	[HFit_ChallengeType] [nvarchar](128) NULL,
--	[HFit_RegistrationClosedImage] [nvarchar](255) NULL,
--	[HFit_ChallengeTallyEndDate] [datetime] NULL,
--	[HFit_PreSurveySelector] [nvarchar](128) NOT NULL,
--	[HFit_PostSurveySelector] [nvarchar](128) NOT NULL,
--	[HFit_EnableContactGroups] [bit] NOT NULL,
--	[HFit_ContactGroup] [nvarchar](128) NULL,
--	[HFit_ChallengeCompanyGoal] [int] NOT NULL,
--	[HFit_EnableComments] [bit] NOT NULL,
--	[HFit_PostChallengeEnd] [datetime] NULL,
--	[HFit_ShowCompanyGoal] [bit] NOT NULL,
--	[HFit_ShowUserSteps] [bit] NOT NULL,
--	[HFit_RegistrationClosedMessage] [nvarchar](4000) NULL,
--	[HFit_TeamsEnabled] [bit] NOT NULL,
--	[HFit_AboutChallengeImage] [nvarchar](1024) NULL,
--	[HFit_RegistrationButtonText] [nvarchar](25) NOT NULL,
--	[HFit_RegistrationPageUrl] [nvarchar](2000) NOT NULL,
--	[HFit_ChallengeStartedText] [nvarchar](4000) NULL,
--	[HFit_ChallengeStartedImage] [nvarchar](1024) NULL,
--	[HFit_MaxDailySteps] [int] NULL,
--	[HFit_ChallengeEndedText] [nvarchar](4000) NOT NULL,
--	[HFit_ChallengeEndedImage] [nvarchar](1024) NULL,
--	[HFit_emailFromAddress] [nvarchar](128) NOT NULL,
--	[HFit_emailFromName] [nvarchar](128) NOT NULL,
--	[HFit_PostSurveyFeedbackText] [nvarchar](4000) NULL,
--	[HFit_PostSurveyConfirmationPageText] [nvarchar](4000) NULL,
--	[HFit_ChallengeName] [nvarchar](255) NOT NULL,

--	[CTREE_NodeGUID] [uniqueidentifier] NOT NULL,
--	[CTREE_NodeID] [int] NOT NULL,
--	[CTREE_NodeParentID] [int] NOT NULL,
--	[CTREE_NodeClassID] [int] NOT NULL,

--	[CTREE_DocumentGUID] [uniqueidentifier] NULL,
--	[CTREE_DocumentID] [int] NOT NULL,
--	[CTREE_DocumentNodeID] [int] NOT NULL,
--	[CTREE_DocumentWorkflowCycleGUID] [uniqueidentifier] NULL,
	
--	[CTREE_SKUGUID] [uniqueidentifier] NULL,
--	[CTREE_SKUMembershipGUID] [uniqueidentifier] NULL,
--	[CTREE_NodeSiteID] [int] NOT NULL,
--	[CTREE_Published] [int] NOT NULL,
--	[CTREE_SiteName] [nvarchar](100) NOT NULL,
--	[CTREE_ClassName] [nvarchar](100) NOT NULL,
--	[CTREE_ClassDisplayName] [nvarchar](100) NOT NULL,
--	[CTREE_NodeAliasPath] [nvarchar](450) NOT NULL,
--	[CTREE_NodeName] [nvarchar](100) NOT NULL,
--	[CTREE_NodeAlias] [nvarchar](50) NOT NULL,
--	[CTREE_NodeLevel] [int] NOT NULL,
--	[CTREE_NodeACLID] [int] NULL,
--	[CTREE_NodeOrder] [int] NULL,
--	[CTREE_IsSecuredNode] [bit] NULL,
--	[CTREE_NodeCacheMinutes] [int] NULL,
--	[CTREE_NodeSKUID] [int] NULL,
--	[CTREE_NodeDocType] [nvarchar](4000) NULL,
--	[CTREE_NodeHeadTags] [nvarchar](4000) NULL,
--	[CTREE_NodeBodyElementAttributes] [nvarchar](4000) NULL,
--	[CTREE_NodeInheritPageLevels] [nvarchar](200) NULL,
--	[CTREE_NodeChildNodesCount] [int] NULL,
--	[CTREE_RequiresSSL] [int] NULL,
--	[CTREE_NodeLinkedNodeID] [int] NULL,
--	[CTREE_NodeOwner] [int] NULL,
--	[CTREE_NodeCustomData] [nvarchar](4000) NULL,
--	[CTREE_NodeGroupID] [int] NULL,
--	[CTREE_NodeLinkedNodeSiteID] [int] NULL,
--	[CTREE_NodeTemplateID] [int] NULL,
--	[CTREE_NodeWireframeTemplateID] [int] NULL,
--	[CTREE_NodeWireframeComment] [nvarchar](4000) NULL,
--	[CTREE_NodeTemplateForAllCultures] [bit] NULL,
--	[CTREE_NodeInheritPageTemplate] [bit] NULL,
--	[CTREE_NodeWireframeInheritPageLevels] [nvarchar](450) NULL,
--	[CTREE_NodeAllowCacheInFileSystem] [bit] NULL,
--	[CTREE_DocumentName] [nvarchar](100) NOT NULL,
--	[CTREE_DocumentNamePath] [nvarchar](1500) NULL,
--	[CTREE_DocumentModifiedWhen] [datetime] NULL,
--	[CTREE_DocumentModifiedByUserID] [int] NULL,
--	[CTREE_DocumentForeignKeyValue] [int] NULL,
--	[CTREE_DocumentCreatedByUserID] [int] NULL,
--	[CTREE_DocumentCreatedWhen] [datetime] NULL,
--	[CTREE_DocumentCheckedOutByUserID] [int] NULL,
--	[CTREE_DocumentCheckedOutWhen] [datetime] NULL,
--	[CTREE_DocumentCheckedOutVersionHistoryID] [int] NULL,
--	[CTREE_DocumentPublishedVersionHistoryID] [int] NULL,
--	[CTREE_DocumentWorkflowStepID] [int] NULL,
--	[CTREE_DocumentPublishFrom] [datetime] NULL,
--	[CTREE_DocumentPublishTo] [datetime] NULL,
--	[CTREE_DocumentUrlPath] [nvarchar](450) NULL,
--	[CTREE_DocumentCulture] [nvarchar](10) NOT NULL,
--	[CTREE_DocumentPageTitle] [nvarchar](4000) NULL,
--	[CTREE_DocumentPageKeyWords] [nvarchar](4000) NULL,
--	[CTREE_DocumentPageDescription] [nvarchar](4000) NULL,
--	[CTREE_DocumentShowInSiteMap] [bit] NOT NULL,
--	[CTREE_DocumentMenuItemHideInNavigation] [bit] NOT NULL,
--	[CTREE_DocumentMenuCaption] [nvarchar](200) NULL,
--	[CTREE_DocumentMenuStyle] [nvarchar](100) NULL,
--	[CTREE_DocumentMenuItemImage] [nvarchar](200) NULL,
--	[CTREE_DocumentMenuItemLeftImage] [nvarchar](200) NULL,
--	[CTREE_DocumentMenuItemRightImage] [nvarchar](200) NULL,
--	[CTREE_DocumentPageTemplateID] [int] NULL,
--	[CTREE_DocumentMenuJavascript] [nvarchar](450) NULL,
--	[CTREE_DocumentMenuRedirectUrl] [nvarchar](450) NULL,
--	[CTREE_DocumentUseNamePathForUrlPath] [bit] NULL,
--	[CTREE_DocumentStylesheetID] [int] NULL,
--	[CTREE_DocumentContent] [nvarchar](4000) NULL,
--	[CTREE_DocumentMenuClass] [nvarchar](100) NULL,
--	[CTREE_DocumentMenuStyleOver] [nvarchar](200) NULL,
--	[CTREE_DocumentMenuClassOver] [nvarchar](100) NULL,
--	[CTREE_DocumentMenuItemImageOver] [nvarchar](200) NULL,
--	[CTREE_DocumentMenuItemLeftImageOver] [nvarchar](200) NULL,
--	[CTREE_DocumentMenuItemRightImageOver] [nvarchar](200) NULL,
--	[CTREE_DocumentMenuStyleHighlighted] [nvarchar](200) NULL,
--	[CTREE_DocumentMenuClassHighlighted] [nvarchar](100) NULL,
--	[CTREE_DocumentMenuItemImageHighlighted] [nvarchar](200) NULL,
--	[CTREE_DocumentMenuItemLeftImageHighlighted] [nvarchar](200) NULL,
--	[CTREE_DocumentMenuItemRightImageHighlighted] [nvarchar](200) NULL,
--	[CTREE_DocumentMenuItemInactive] [bit] NULL,
--	[CTREE_DocumentCustomData] [nvarchar](4000) NULL,
--	[CTREE_DocumentExtensions] [nvarchar](100) NULL,
--	[CTREE_DocumentCampaign] [nvarchar](100) NULL,
--	[CTREE_DocumentTags] [nvarchar](4000) NULL,
--	[CTREE_DocumentTagGroupID] [int] NULL,
--	[CTREE_DocumentWildcardRule] [nvarchar](440) NULL,
--	[CTREE_DocumentWebParts] [nvarchar](4000) NULL,
--	[CTREE_DocumentRatingValue] [float] NULL,
--	[CTREE_DocumentRatings] [int] NULL,
--	[CTREE_DocumentPriority] [int] NULL,
--	[CTREE_DocumentType] [nvarchar](50) NULL,
--	[CTREE_DocumentLastPublished] [datetime] NULL,
--	[CTREE_DocumentUseCustomExtensions] [bit] NULL,
--	[CTREE_DocumentGroupWebParts] [nvarchar](4000) NULL,
--	[CTREE_DocumentCheckedOutAutomatically] [bit] NULL,
--	[CTREE_DocumentTrackConversionName] [nvarchar](200) NULL,
--	[CTREE_DocumentConversionValue] [nvarchar](100) NULL,
--	[CTREE_DocumentSearchExcluded] [bit] NULL,
--	[CTREE_DocumentLastVersionName] [nvarchar](100) NULL,
--	[CTREE_DocumentLastVersionNumber] [nvarchar](50) NULL,
--	[CTREE_DocumentIsArchived] [bit] NULL,
--	[CTREE_DocumentLastVersionType] [nvarchar](50) NULL,
--	[CTREE_DocumentLastVersionMenuRedirectUrl] [nvarchar](450) NULL,
--	[CTREE_DocumentHash] [nvarchar](32) NULL,
--	[CTREE_DocumentLogVisitActivity] [bit] NULL,
--	[CTREE_DocumentSitemapSettings] [nvarchar](100) NULL,
--	[CTREE_DocumentIsWaitingForTranslation] [bit] NULL,
--	[CTREE_DocumentSKUName] [nvarchar](440) NULL,
--	[CTREE_DocumentSKUDescription] [nvarchar](4000) NULL,
--	[CTREE_DocumentSKUShortDescription] [nvarchar](4000) NULL,
--	[CTREE_DocumentWorkflowActionStatus] [nvarchar](450) NULL,
--	[CTREE_SKUID] [int] NULL,
--	[CTREE_SKUNumber] [nvarchar](200) NULL,
--	[CTREE_SKUName] [nvarchar](440) NULL,
--	[CTREE_SKUDescription] [nvarchar](4000) NULL,
--	[CTREE_SKUPrice] [float] NULL,
--	[CTREE_SKUEnabled] [bit] NULL,
--	[CTREE_SKUDepartmentID] [int] NULL,
--	[CTREE_SKUManufacturerID] [int] NULL,
--	[CTREE_SKUInternalStatusID] [int] NULL,
--	[CTREE_SKUPublicStatusID] [int] NULL,
--	[CTREE_SKUSupplierID] [int] NULL,
--	[CTREE_SKUAvailableInDays] [int] NULL,
--	[CTREE_SKUImagePath] [nvarchar](450) NULL,
--	[CTREE_SKUWeight] [float] NULL,
--	[CTREE_SKUWidth] [float] NULL,
--	[CTREE_SKUDepth] [float] NULL,
--	[CTREE_SKUHeight] [float] NULL,
--	[CTREE_SKUAvailableItems] [int] NULL,
--	[CTREE_SKUSellOnlyAvailable] [bit] NULL,
--	[CTREE_SKUCustomData] [nvarchar](4000) NULL,
--	[CTREE_SKUOptionCategoryID] [int] NULL,
--	[CTREE_SKUOrder] [int] NULL,
--	[CTREE_SKULastModified] [datetime] NULL,
--	[CTREE_SKUCreated] [datetime] NULL,
--	[CTREE_SKUSiteID] [int] NULL,
--	[CTREE_SKUPrivateDonation] [bit] NULL,
--	[CTREE_SKUNeedsShipping] [bit] NULL,
--	[CTREE_SKUMaxDownloads] [int] NULL,
--	[CTREE_SKUValidUntil] [datetime] NULL,
--	[CTREE_SKUProductType] [nvarchar](50) NULL,
--	[CTREE_SKUMaxItemsInOrder] [int] NULL,
--	[CTREE_SKUMaxPrice] [float] NULL,
--	[CTREE_SKUValidity] [nvarchar](50) NULL,
--	[CTREE_SKUValidFor] [int] NULL,
--	[CTREE_SKUMinPrice] [float] NULL,
--	[CTREE_SKUConversionName] [nvarchar](100) NULL,
--	[CTREE_SKUConversionValue] [nvarchar](200) NULL,
--	[CTREE_SKUBundleInventoryType] [nvarchar](50) NULL,
--	[CTREE_SKUMinItemsInOrder] [int] NULL,
--	[CTREE_SKURetailPrice] [float] NULL,
--	[CTREE_SKUParentSKUID] [int] NULL,
--	[CTREE_SKUAllowAllVariants] [bit] NULL,
--	[CTREE_SKUInheritsTaxClasses] [bit] NULL,
--	[CTREE_SKUInheritsDiscounts] [bit] NULL,
--	[CTREE_SKUTrackInventory] [bit] NULL,
--	[CTREE_SKUShortDescription] [nvarchar](4000) NULL,
--	[CTREE_SKUEproductFilesCount] [int] NULL,
--	[CTREE_SKUBundleItemsCount] [int] NULL,
--	[CTREE_SKUInStoreFrom] [datetime] NULL,
--	[CTREE_SKUReorderAt] [int] NULL,
--	[CTREE_NodeOwnerFullName] [nvarchar](450) NULL,
--	[CTREE_NodeOwnerUserName] [nvarchar](100) NULL,
--	[CTREE_NodeOwnerEmail] [nvarchar](100) NULL
--) 
print ('EDW_ChallengeRegistrationData Created temp table') ;
print (getdate()) ;
END
ELSE
BEGIN
	--truncate table #EDW_ChallengeRegistrationData;
	print ('EDW_ChallengeRegistrationData existing data removed') ;
	print (getdate()) ;
END
--insert into #EDW_ChallengeRegistrationData
SELECT 
	hfit_challenge.ChallengeID as HFit_ChallengeID
	, hfit_challenge.Title as HFit_Title
	, dbo.udf_StripHTML(LEFT(hfit_challenge.[Description],4000)) as HFit_Description
	, hfit_challenge.[Enabled] as HFit_Enabled
	, hfit_challenge.RegistrationStart as HFit_RegistrationStart
	, hfit_challenge.RegistrationEnd as HFit_RegistrationEnd
	, hfit_challenge.ChallengeStart as HFit_ChallengeStart
	, hfit_challenge.ChallengeEnd as HFit_ChallengeEnd
	, hfit_challenge.PostSurveyEnd as HFit_PostSurveyEnd
	, hfit_challenge.ChallengeType as HFit_ChallengeType
	, hfit_challenge.RegistrationClosedImage as HFit_RegistrationClosedImage
	, hfit_challenge.ChallengeTallyEndDate as HFit_ChallengeTallyEndDate
	, hfit_challenge.PreSurveySelector as HFit_PreSurveySelector
	, hfit_challenge.PostSurveySelector as HFit_PostSurveySelector
	, hfit_challenge.EnableContactGroups as HFit_EnableContactGroups
	, hfit_challenge.ContactGroup as HFit_ContactGroup
	, hfit_challenge.ChallengeCompanyGoal as HFit_ChallengeCompanyGoal
	, hfit_challenge.EnableComments as HFit_EnableComments
	, hfit_challenge.PostChallengeEnd as HFit_PostChallengeEnd
	, hfit_challenge.ShowCompanyGoal as HFit_ShowCompanyGoal
	, hfit_challenge.ShowUserSteps as HFit_ShowUserSteps

	, dbo.udf_StripHTML(left(hfit_challenge.RegistrationClosedMessage,4000))  as HFit_RegistrationClosedMessage
	
	, hfit_challenge.TeamsEnabled as HFit_TeamsEnabled
	, hfit_challenge.AboutChallengeImage as HFit_AboutChallengeImage
	, hfit_challenge.RegistrationButtonText as HFit_RegistrationButtonText
	, hfit_challenge.RegistrationPageUrl as HFit_RegistrationPageUrl

	, dbo.udf_StripHTML(left(hfit_challenge.ChallengeStartedText,4000))  as HFit_ChallengeStartedText
	
	, hfit_challenge.ChallengeStartedImage as HFit_ChallengeStartedImage
	, hfit_challenge.MaxDailySteps as HFit_MaxDailySteps
	
	, dbo.udf_StripHTML(left(hfit_challenge.ChallengeEndedText,4000))  as HFit_ChallengeEndedText

	, hfit_challenge.ChallengeEndedImage as HFit_ChallengeEndedImage
	, hfit_challenge.emailFromAddress as HFit_emailFromAddress
	, hfit_challenge.emailFromName as HFit_emailFromName
	, left(hfit_challenge.PostSurveyFeedbackText,4000) as HFit_PostSurveyFeedbackText
	, left(hfit_challenge.PostSurveyConfirmationPageText ,4000) as HFit_PostSurveyConfirmationPageText
	, hfit_challenge.ChallengeName as HFit_ChallengeName

	, View_CMS_TREE_Joined.NodeGUID as CTREE_NodeGUID
	, View_CMS_TREE_Joined.NodeID as CTREE_NodeID
	, View_CMS_TREE_Joined.NodeParentID as CTREE_NodeParentID
	, View_CMS_TREE_Joined.NodeClassID as CTREE_NodeClassID
	, View_CMS_TREE_Joined.DocumentGUID as CTREE_DocumentGUID
	, View_CMS_TREE_Joined.DocumentID as CTREE_DocumentID
	, View_CMS_TREE_Joined.DocumentNodeID as CTREE_DocumentNodeID
	, View_CMS_TREE_Joined.DocumentWorkflowCycleGUID	 as CTREE_DocumentWorkflowCycleGUID	
	, View_CMS_TREE_Joined.SKUGUID	 as CTREE_SKUGUID	
	, View_CMS_TREE_Joined.SKUMembershipGUID as CTREE_SKUMembershipGUID
	, View_CMS_TREE_Joined.NodeSiteID as CTREE_NodeSiteID

	, View_CMS_TREE_Joined.Published as CTREE_Published
	, View_CMS_TREE_Joined.SiteName as CTREE_SiteName
	, View_CMS_TREE_Joined.ClassName as CTREE_ClassName
	, View_CMS_TREE_Joined.ClassDisplayName as CTREE_ClassDisplayName
	, View_CMS_TREE_Joined.NodeAliasPath as CTREE_NodeAliasPath
	, View_CMS_TREE_Joined.NodeName as CTREE_NodeName
	, View_CMS_TREE_Joined.NodeAlias as CTREE_NodeAlias
	
	, View_CMS_TREE_Joined.NodeLevel as CTREE_NodeLevel
	, View_CMS_TREE_Joined.NodeACLID as CTREE_NodeACLID
	
	, View_CMS_TREE_Joined.NodeOrder as CTREE_NodeOrder
	, View_CMS_TREE_Joined.IsSecuredNode as CTREE_IsSecuredNode
	, View_CMS_TREE_Joined.NodeCacheMinutes as CTREE_NodeCacheMinutes
	, View_CMS_TREE_Joined.NodeSKUID as CTREE_NodeSKUID
	, left(View_CMS_TREE_Joined.NodeDocType ,4000) as CTREE_NodeDocType
	, left(View_CMS_TREE_Joined.NodeHeadTags ,4000) as CTREE_NodeHeadTags
	, left(View_CMS_TREE_Joined.NodeBodyElementAttributes ,4000) as CTREE_NodeBodyElementAttributes
	, View_CMS_TREE_Joined.NodeInheritPageLevels as CTREE_NodeInheritPageLevels
	, View_CMS_TREE_Joined.NodeChildNodesCount as CTREE_NodeChildNodesCount
	, View_CMS_TREE_Joined.RequiresSSL as CTREE_RequiresSSL
	, View_CMS_TREE_Joined.NodeLinkedNodeID as CTREE_NodeLinkedNodeID
	, View_CMS_TREE_Joined.NodeOwner as CTREE_NodeOwner
	, left(View_CMS_TREE_Joined.NodeCustomData ,4000) as CTREE_NodeCustomData
	, View_CMS_TREE_Joined.NodeGroupID as CTREE_NodeGroupID
	, View_CMS_TREE_Joined.NodeLinkedNodeSiteID as CTREE_NodeLinkedNodeSiteID
	, View_CMS_TREE_Joined.NodeTemplateID as CTREE_NodeTemplateID
	, View_CMS_TREE_Joined.NodeWireframeTemplateID as CTREE_NodeWireframeTemplateID
	, left(View_CMS_TREE_Joined.NodeWireframeComment,4000)  as CTREE_NodeWireframeComment
	, View_CMS_TREE_Joined.NodeTemplateForAllCultures as CTREE_NodeTemplateForAllCultures
	, View_CMS_TREE_Joined.NodeInheritPageTemplate as CTREE_NodeInheritPageTemplate
	, View_CMS_TREE_Joined.NodeWireframeInheritPageLevels as CTREE_NodeWireframeInheritPageLevels
	, View_CMS_TREE_Joined.NodeAllowCacheInFileSystem as CTREE_NodeAllowCacheInFileSystem
	
	, View_CMS_TREE_Joined.DocumentName as CTREE_DocumentName
	, View_CMS_TREE_Joined.DocumentNamePath as CTREE_DocumentNamePath
	, View_CMS_TREE_Joined.DocumentModifiedWhen as CTREE_DocumentModifiedWhen
	, View_CMS_TREE_Joined.DocumentModifiedByUserID as CTREE_DocumentModifiedByUserID
	, View_CMS_TREE_Joined.DocumentForeignKeyValue as CTREE_DocumentForeignKeyValue
	, View_CMS_TREE_Joined.DocumentCreatedByUserID as CTREE_DocumentCreatedByUserID
	, View_CMS_TREE_Joined.DocumentCreatedWhen as CTREE_DocumentCreatedWhen
	, View_CMS_TREE_Joined.DocumentCheckedOutByUserID as CTREE_DocumentCheckedOutByUserID
	, View_CMS_TREE_Joined.DocumentCheckedOutWhen as CTREE_DocumentCheckedOutWhen
	, View_CMS_TREE_Joined.DocumentCheckedOutVersionHistoryID as CTREE_DocumentCheckedOutVersionHistoryID
	, View_CMS_TREE_Joined.DocumentPublishedVersionHistoryID as CTREE_DocumentPublishedVersionHistoryID
	, View_CMS_TREE_Joined.DocumentWorkflowStepID as CTREE_DocumentWorkflowStepID
	, View_CMS_TREE_Joined.DocumentPublishFrom as CTREE_DocumentPublishFrom
	, View_CMS_TREE_Joined.DocumentPublishTo as CTREE_DocumentPublishTo
	, View_CMS_TREE_Joined.DocumentUrlPath as CTREE_DocumentUrlPath
	, View_CMS_TREE_Joined.DocumentCulture as CTREE_DocumentCulture	
	, left(View_CMS_TREE_Joined.DocumentPageTitle,4000)  as CTREE_DocumentPageTitle
	, left(View_CMS_TREE_Joined.DocumentPageKeyWords ,4000) as CTREE_DocumentPageKeyWords
	, left(View_CMS_TREE_Joined.DocumentPageDescription ,4000) as CTREE_DocumentPageDescription
	, View_CMS_TREE_Joined.DocumentShowInSiteMap as CTREE_DocumentShowInSiteMap
	, View_CMS_TREE_Joined.DocumentMenuItemHideInNavigation as CTREE_DocumentMenuItemHideInNavigation
	, View_CMS_TREE_Joined.DocumentMenuCaption as CTREE_DocumentMenuCaption
	, View_CMS_TREE_Joined.DocumentMenuStyle as CTREE_DocumentMenuStyle
	, View_CMS_TREE_Joined.DocumentMenuItemImage as CTREE_DocumentMenuItemImage
	, View_CMS_TREE_Joined.DocumentMenuItemLeftImage as CTREE_DocumentMenuItemLeftImage
	, View_CMS_TREE_Joined.DocumentMenuItemRightImage as CTREE_DocumentMenuItemRightImage
	, View_CMS_TREE_Joined.DocumentPageTemplateID as CTREE_DocumentPageTemplateID
	, View_CMS_TREE_Joined.DocumentMenuJavascript as CTREE_DocumentMenuJavascript
	, View_CMS_TREE_Joined.DocumentMenuRedirectUrl as CTREE_DocumentMenuRedirectUrl
	, View_CMS_TREE_Joined.DocumentUseNamePathForUrlPath as CTREE_DocumentUseNamePathForUrlPath
	, View_CMS_TREE_Joined.DocumentStylesheetID as CTREE_DocumentStylesheetID
	, left(View_CMS_TREE_Joined.DocumentContent ,4000) as CTREE_DocumentContent
	, View_CMS_TREE_Joined.DocumentMenuClass as CTREE_DocumentMenuClass
	, View_CMS_TREE_Joined.DocumentMenuStyleOver as CTREE_DocumentMenuStyleOver
	, View_CMS_TREE_Joined.DocumentMenuClassOver as CTREE_DocumentMenuClassOver
	, View_CMS_TREE_Joined.DocumentMenuItemImageOver as CTREE_DocumentMenuItemImageOver
	, View_CMS_TREE_Joined.DocumentMenuItemLeftImageOver as CTREE_DocumentMenuItemLeftImageOver
	, View_CMS_TREE_Joined.DocumentMenuItemRightImageOver as CTREE_DocumentMenuItemRightImageOver
	, View_CMS_TREE_Joined.DocumentMenuStyleHighlighted as CTREE_DocumentMenuStyleHighlighted
	, View_CMS_TREE_Joined.DocumentMenuClassHighlighted as CTREE_DocumentMenuClassHighlighted
	, View_CMS_TREE_Joined.DocumentMenuItemImageHighlighted as CTREE_DocumentMenuItemImageHighlighted
	, View_CMS_TREE_Joined.DocumentMenuItemLeftImageHighlighted as CTREE_DocumentMenuItemLeftImageHighlighted
	, View_CMS_TREE_Joined.DocumentMenuItemRightImageHighlighted as CTREE_DocumentMenuItemRightImageHighlighted
	, View_CMS_TREE_Joined.DocumentMenuItemInactive as CTREE_DocumentMenuItemInactive
	, left(View_CMS_TREE_Joined.DocumentCustomData ,4000) as CTREE_DocumentCustomData
	, View_CMS_TREE_Joined.DocumentExtensions as CTREE_DocumentExtensions
	, View_CMS_TREE_Joined.DocumentCampaign as CTREE_DocumentCampaign
	, left(View_CMS_TREE_Joined.DocumentTags ,4000) as CTREE_DocumentTags
	, View_CMS_TREE_Joined.DocumentTagGroupID as CTREE_DocumentTagGroupID
	, View_CMS_TREE_Joined.DocumentWildcardRule as CTREE_DocumentWildcardRule
	, left(View_CMS_TREE_Joined.DocumentWebParts ,4000) as CTREE_DocumentWebParts
	, View_CMS_TREE_Joined.DocumentRatingValue as CTREE_DocumentRatingValue
	, View_CMS_TREE_Joined.DocumentRatings as CTREE_DocumentRatings
	, View_CMS_TREE_Joined.DocumentPriority as CTREE_DocumentPriority
	, View_CMS_TREE_Joined.DocumentType as CTREE_DocumentType
	, View_CMS_TREE_Joined.DocumentLastPublished as CTREE_DocumentLastPublished
	, View_CMS_TREE_Joined.DocumentUseCustomExtensions as CTREE_DocumentUseCustomExtensions
	, left(View_CMS_TREE_Joined.DocumentGroupWebParts ,4000) as CTREE_DocumentGroupWebParts
	, View_CMS_TREE_Joined.DocumentCheckedOutAutomatically as CTREE_DocumentCheckedOutAutomatically
	, View_CMS_TREE_Joined.DocumentTrackConversionName as CTREE_DocumentTrackConversionName
	, View_CMS_TREE_Joined.DocumentConversionValue as CTREE_DocumentConversionValue
	, View_CMS_TREE_Joined.DocumentSearchExcluded as CTREE_DocumentSearchExcluded
	, View_CMS_TREE_Joined.DocumentLastVersionName as CTREE_DocumentLastVersionName
	, View_CMS_TREE_Joined.DocumentLastVersionNumber as CTREE_DocumentLastVersionNumber
	, View_CMS_TREE_Joined.DocumentIsArchived as CTREE_DocumentIsArchived
	, View_CMS_TREE_Joined.DocumentLastVersionType as CTREE_DocumentLastVersionType
	, View_CMS_TREE_Joined.DocumentLastVersionMenuRedirectUrl as CTREE_DocumentLastVersionMenuRedirectUrl
	, View_CMS_TREE_Joined.DocumentHash as CTREE_DocumentHash
	, View_CMS_TREE_Joined.DocumentLogVisitActivity	 as CTREE_DocumentLogVisitActivity	
	, View_CMS_TREE_Joined.DocumentSitemapSettings as CTREE_DocumentSitemapSettings
	, View_CMS_TREE_Joined.DocumentIsWaitingForTranslation as CTREE_DocumentIsWaitingForTranslation
	, View_CMS_TREE_Joined.DocumentSKUName as CTREE_DocumentSKUName
	, left(View_CMS_TREE_Joined.DocumentSKUDescription,4000)  as CTREE_DocumentSKUDescription
	, left(View_CMS_TREE_Joined.DocumentSKUShortDescription ,4000) as CTREE_DocumentSKUShortDescription
	, View_CMS_TREE_Joined.DocumentWorkflowActionStatus as CTREE_DocumentWorkflowActionStatus
	, View_CMS_TREE_Joined.SKUID as CTREE_SKUID
	, View_CMS_TREE_Joined.SKUNumber as CTREE_SKUNumber
	, View_CMS_TREE_Joined.SKUName as CTREE_SKUName
	, left(View_CMS_TREE_Joined.SKUDescription ,4000) as CTREE_SKUDescription
	, View_CMS_TREE_Joined.SKUPrice as CTREE_SKUPrice
	, View_CMS_TREE_Joined.SKUEnabled as CTREE_SKUEnabled
	, View_CMS_TREE_Joined.SKUDepartmentID as CTREE_SKUDepartmentID
	, View_CMS_TREE_Joined.SKUManufacturerID as CTREE_SKUManufacturerID
	, View_CMS_TREE_Joined.SKUInternalStatusID as CTREE_SKUInternalStatusID
	, View_CMS_TREE_Joined.SKUPublicStatusID as CTREE_SKUPublicStatusID
	, View_CMS_TREE_Joined.SKUSupplierID as CTREE_SKUSupplierID
	, View_CMS_TREE_Joined.SKUAvailableInDays as CTREE_SKUAvailableInDays
	, View_CMS_TREE_Joined.SKUImagePath as CTREE_SKUImagePath
	, View_CMS_TREE_Joined.SKUWeight as CTREE_SKUWeight
	, View_CMS_TREE_Joined.SKUWidth as CTREE_SKUWidth
	, View_CMS_TREE_Joined.SKUDepth as CTREE_SKUDepth
	, View_CMS_TREE_Joined.SKUHeight as CTREE_SKUHeight
	, View_CMS_TREE_Joined.SKUAvailableItems as CTREE_SKUAvailableItems
	, View_CMS_TREE_Joined.SKUSellOnlyAvailable as CTREE_SKUSellOnlyAvailable
	, left(View_CMS_TREE_Joined.SKUCustomData ,4000) as CTREE_SKUCustomData
	, View_CMS_TREE_Joined.SKUOptionCategoryID as CTREE_SKUOptionCategoryID
	, View_CMS_TREE_Joined.SKUOrder as CTREE_SKUOrder
	, View_CMS_TREE_Joined.SKULastModified as CTREE_SKULastModified
	, View_CMS_TREE_Joined.SKUCreated as CTREE_SKUCreated
	, View_CMS_TREE_Joined.SKUSiteID as CTREE_SKUSiteID
	, View_CMS_TREE_Joined.SKUPrivateDonation as CTREE_SKUPrivateDonation
	, View_CMS_TREE_Joined.SKUNeedsShipping as CTREE_SKUNeedsShipping
	, View_CMS_TREE_Joined.SKUMaxDownloads as CTREE_SKUMaxDownloads
	, View_CMS_TREE_Joined.SKUValidUntil as CTREE_SKUValidUntil
	, View_CMS_TREE_Joined.SKUProductType as CTREE_SKUProductType
	, View_CMS_TREE_Joined.SKUMaxItemsInOrder as CTREE_SKUMaxItemsInOrder
	, View_CMS_TREE_Joined.SKUMaxPrice as CTREE_SKUMaxPrice
	, View_CMS_TREE_Joined.SKUValidity as CTREE_SKUValidity
	, View_CMS_TREE_Joined.SKUValidFor as CTREE_SKUValidFor
	, View_CMS_TREE_Joined.SKUMinPrice	 as CTREE_SKUMinPrice	
	, View_CMS_TREE_Joined.SKUConversionName as CTREE_SKUConversionName
	, View_CMS_TREE_Joined.SKUConversionValue as CTREE_SKUConversionValue
	, View_CMS_TREE_Joined.SKUBundleInventoryType as CTREE_SKUBundleInventoryType
	, View_CMS_TREE_Joined.SKUMinItemsInOrder as CTREE_SKUMinItemsInOrder
	, View_CMS_TREE_Joined.SKURetailPrice as CTREE_SKURetailPrice
	, View_CMS_TREE_Joined.SKUParentSKUID as CTREE_SKUParentSKUID
	, View_CMS_TREE_Joined.SKUAllowAllVariants as CTREE_SKUAllowAllVariants
	, View_CMS_TREE_Joined.SKUInheritsTaxClasses as CTREE_SKUInheritsTaxClasses
	, View_CMS_TREE_Joined.SKUInheritsDiscounts as CTREE_SKUInheritsDiscounts
	, View_CMS_TREE_Joined.SKUTrackInventory as CTREE_SKUTrackInventory
	, left(View_CMS_TREE_Joined.SKUShortDescription ,4000) as CTREE_SKUShortDescription
	, View_CMS_TREE_Joined.SKUEproductFilesCount as CTREE_SKUEproductFilesCount
	, View_CMS_TREE_Joined.SKUBundleItemsCount as CTREE_SKUBundleItemsCount
	, View_CMS_TREE_Joined.SKUInStoreFrom as CTREE_SKUInStoreFrom
	, View_CMS_TREE_Joined.SKUReorderAt as CTREE_SKUReorderAt
	, View_CMS_TREE_Joined.NodeOwnerFullName as CTREE_NodeOwnerFullName
	, View_CMS_TREE_Joined.NodeOwnerUserName as CTREE_NodeOwnerUserName
	, View_CMS_TREE_Joined.NodeOwnerEmail as CTREE_NodeOwnerEmail

	,CMS_Document.DocumentID as CDOC_DocumentID
	,CMS_Document.DocumentGUID as CDOC_DocumentGUID
INTO #EDW_ChallengeRegistrationData
select * 
FROM View_CMS_TREE_Joined 
		INNER JOIN hfit_challenge 
			ON View_CMS_TREE_Joined.DocumentForeignKeyValue = hfit_challenge.ChallengeID
		INNER JOIN CMS_Document on CMS_Document.DocumentNodeID = View_CMS_TREE_Joined.NodeID
WHERE  (View_CMS_TREE_Joined.ClassName = 'HFit.ChallengeProduct')
and CMS_Document.DocumentCulture = 'en-us'	--WDM 08.07.2014 

print ('EDW_ChallengeRegistrationData NEW data added') ;
print (getdate()) ;

select * from #EDW_ChallengeRegistrationData
