-- USE KenticoCMS_DataMart_2;
GO

--DROP VIEW dbo.View_HFit_HealthAssessment_Joined_MART;
GO


SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO
-- select top 100 * from View_HFit_HealthAssessment_Joined_MART
CREATE VIEW dbo.View_HFit_HealthAssessment_Joined_MART
AS SELECT
          VJ.Published
        , VJ.SiteName
        , VJ.ClassName
        , VJ.ClassDisplayName
        , VJ.NodeID
        , VJ.NodeAliasPath
        , VJ.NodeName
        , VJ.NodeAlias
        , VJ.NodeClassID
        , VJ.NodeParentID
        , VJ.NodeLevel
        , VJ.NodeACLID
        , VJ.NodeSiteID
        , VJ.NodeGUID
        , VJ.NodeOrder
        , VJ.IsSecuredNode
        , VJ.NodeCacheMinutes
        , VJ.NodeSKUID
        , VJ.NodeDocType
        , VJ.NodeHeadTags
        , VJ.NodeBodyElementAttributes
        , VJ.NodeInheritPageLevels
        , VJ.RequiresSSL
        , VJ.NodeLinkedNodeID
        , VJ.NodeOwner
        , VJ.NodeCustomData
        , VJ.NodeGroupID
        , VJ.NodeLinkedNodeSiteID
        , VJ.NodeTemplateID
        , VJ.NodeWireframeTemplateID
        , VJ.NodeWireframeComment
        , VJ.NodeTemplateForAllCultures
        , VJ.NodeInheritPageTemplate
        , VJ.NodeWireframeInheritPageLevels
        , VJ.NodeAllowCacheInFileSystem
        , VJ.NodeHasChildren
        , VJ.NodeHasLinks
        , VJ.DocumentID
        , VJ.DocumentName
        , VJ.DocumentNamePath
        , VJ.DocumentModifiedWhen
        , VJ.DocumentModifiedByUserID
        , VJ.DocumentForeignKeyValue
        , VJ.DocumentCreatedByUserID
        , VJ.DocumentCreatedWhen
        , VJ.DocumentCheckedOutByUserID
        , VJ.DocumentCheckedOutWhen
        , VJ.DocumentCheckedOutVersionHistoryID
        , VJ.DocumentPublishedVersionHistoryID
        , VJ.DocumentWorkflowStepID
        , VJ.DocumentPublishFrom
        , VJ.DocumentPublishTo
        , VJ.DocumentUrlPath
        , VJ.DocumentCulture
        , VJ.DocumentNodeID
        , VJ.DocumentPageTitle
        , VJ.DocumentPageKeyWords
        , VJ.DocumentPageDescription
        , VJ.DocumentShowInSiteMap
        , VJ.DocumentMenuItemHideInNavigation
        , VJ.DocumentMenuCaption
        , VJ.DocumentMenuStyle
        , VJ.DocumentMenuItemImage
        , VJ.DocumentMenuItemLeftImage
        , VJ.DocumentMenuItemRightImage
        , VJ.DocumentPageTemplateID
        , VJ.DocumentMenuJavascript
        , VJ.DocumentMenuRedirectUrl
        , VJ.DocumentUseNamePathForUrlPath
        , VJ.DocumentStylesheetID
        , VJ.DocumentContent
        , VJ.DocumentMenuClass
        , VJ.DocumentMenuStyleOver
        , VJ.DocumentMenuClassOver
        , VJ.DocumentMenuItemImageOver
        , VJ.DocumentMenuItemLeftImageOver
        , VJ.DocumentMenuItemRightImageOver
        , VJ.DocumentMenuStyleHighlighted
        , VJ.DocumentMenuClassHighlighted
        , VJ.DocumentMenuItemImageHighlighted
        , VJ.DocumentMenuItemLeftImageHighlighted
        , VJ.DocumentMenuItemRightImageHighlighted
        , VJ.DocumentMenuItemInactive
        , VJ.DocumentCustomData
        , VJ.DocumentExtensions
        , VJ.DocumentCampaign
        , VJ.DocumentTags
        , VJ.DocumentTagGroupID
        , VJ.DocumentWildcardRule
        , VJ.DocumentWebParts
        , VJ.DocumentRatingValue
        , VJ.DocumentRatings
        , VJ.DocumentPriority
        , VJ.DocumentType
        , VJ.DocumentLastPublished
        , VJ.DocumentUseCustomExtensions
        , VJ.DocumentGroupWebParts
        , VJ.DocumentCheckedOutAutomatically
        , VJ.DocumentTrackConversionName
        , VJ.DocumentConversionValue
        , VJ.DocumentSearchExcluded
        , VJ.DocumentLastVersionName
        , VJ.DocumentLastVersionNumber
        , VJ.DocumentIsArchived
        , VJ.DocumentLastVersionType
        , VJ.DocumentLastVersionMenuRedirectUrl
        , VJ.DocumentHash
        , VJ.DocumentLogVisitActivity
        , VJ.DocumentGUID
        , VJ.DocumentWorkflowCycleGUID
        , VJ.DocumentSitemapSettings
        , VJ.DocumentIsWaitingForTranslation
        , VJ.DocumentSKUName
        , VJ.DocumentSKUDescription
        , VJ.DocumentSKUShortDescription
        , VJ.DocumentWorkflowActionStatus
        , VJ.DocumentMenuRedirectToFirstChild
          --,VJ.[SVR]
          --,VJ.[DBNAME]
        --, VJ.Document_LastModifiedDate
        --, VJ.SITE_LastModifiedDate
        --, VJ.CLASS_LastModifiedDate
        --, VJ.Tree_LastModifiedDate
        , VJ.SKUID
        , VJ.SKUNumber
        , VJ.SKUName
        , VJ.SKUDescription
        , VJ.SKUPrice
        , VJ.SKUEnabled
        , VJ.SKUDepartmentID
        , VJ.SKUManufacturerID
        , VJ.SKUInternalStatusID
        , VJ.SKUPublicStatusID
        , VJ.SKUSupplierID
        , VJ.SKUAvailableInDays
        , VJ.SKUGUID
        , VJ.SKUImagePath
        , VJ.SKUWeight
        , VJ.SKUWidth
        , VJ.SKUDepth
        , VJ.SKUHeight
        , VJ.SKUAvailableItems
        , VJ.SKUSellOnlyAvailable
        , VJ.SKUCustomData
        , VJ.SKUOptionCategoryID
        , VJ.SKUOrder
        , VJ.SKULastModified
        , VJ.SKUCreated
        , VJ.SKUSiteID
        , VJ.SKUPrivateDonation
        , VJ.SKUNeedsShipping
        , VJ.SKUMaxDownloads
        , VJ.SKUValidUntil
        , VJ.SKUProductType
        , VJ.SKUMaxItemsInOrder
        , VJ.SKUMaxPrice
        , VJ.SKUValidity
        , VJ.SKUValidFor
        , VJ.SKUMinPrice
        , VJ.SKUMembershipGUID
        , VJ.SKUConversionName
        , VJ.SKUConversionValue
        , VJ.SKUBundleInventoryType
        , VJ.SKUMinItemsInOrder
        , VJ.SKURetailPrice
        , VJ.SKUParentSKUID
        , VJ.SKUAllowAllVariants
        , VJ.SKUInheritsTaxClasses
        , VJ.SKUInheritsDiscounts
        , VJ.SKUTrackInventory
        , VJ.SKUShortDescription
        , VJ.SKUEproductFilesCount
        , VJ.SKUBundleItemsCount
        , VJ.SKUInStoreFrom
        , VJ.SKUReorderAt
        , VJ.NodeOwnerFullName
        , VJ.NodeOwnerUserName
        , VJ.NodeOwnerEmail
        , FT.QuestionTransformUrl
        , FT.ReviewText
        , FT.SubmitButtonText
        , FT.ReviewTitle
        , FT.SubmitRedirectUrl
        , FT.ReviewUrl
        , FT.ConfirmationTitle
        , FT.ConfirmationText
        , FT.ConfirmationUrl
        , FT.ConfirmationSubTitle
        , FT.ConfirmationEditButtonText
        , FT.SmallStepTitle
        , FT.SmallStepText
        , FT.SmallStepUrl
        , FT.MinimumOptOut
        , FT.MinimumSteps
        , FT.MaximumSteps
        , FT.IntroText
        , FT.Revision
        , FT.MyProfileConfirmationUrl
        , FT.MyProfileConfirmationTitle
        , FT.MyProfileConfirmationText
        , FT.HealthAssessmentConfigurationID
        , FT.DisplayName
        , FT.ReviewEditButtonText
        , FT.SmallStepOptoutText
        , FT.MinimumStepsError
        , FT.MaximumStepsError
        , FT.WaitMessage
        , FT.ErrorMessage
        , FT.ErrorTitle
        , FT.HealthAssessmentID
        , FT.SYS_CHANGE_VERSION
        , FT.LASTMODIFIEDDATE
        , FT.HashCode
        , FT.SVR
        , FT.DBNAME
   FROM BASE_View_CMS_Tree_Joined AS VJ
        INNER JOIN dbo.BASE_HFit_HealthAssessment AS FT
        ON
          VJ.DocumentForeignKeyValue = FT.HealthAssessmentID AND
          VJ.SVR = FT.SVR AND
          VJ.DBNAME = FT.DBNAME
   WHERE
          ClassName = 'HFit.HealthAssessment';
GO


