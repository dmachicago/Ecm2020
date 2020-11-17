
--CREATE VIEW [dbo].[View_CMS_Tree_Joined] AS 
SELECT 
    CASE WHEN (DocumentIsArchived IS NULL OR DocumentIsArchived = 0) 
    AND ((DocumentCheckedOutVersionHistoryID IS NULL 
    AND DocumentPublishedVersionHistoryID IS NULL) 
    OR (DocumentCheckedOutVersionHistoryID IS NOT NULL 
    AND DocumentPublishedVersionHistoryID IS NOT NULL)) 
    AND (DocumentPublishFrom IS NULL 
    OR (DocumentPublishFrom IS NOT NULL 
    AND DocumentPublishFrom <= getdate())) 
    AND (DocumentPublishTo IS NULL 
    OR (DocumentPublishTo IS NOT NULL 
    AND DocumentPublishTo >= getdate())) 
    THEN 1 
    ELSE 0 
    END AS Published
    , T.*, SKU.[SKUID], SKU.[SKUNumber], SKU.[SKUName], SKU.[SKUDescription], SKU.[SKUPrice], SKU.[SKUEnabled], SKU.[SKUDepartmentID], SKU.[SKUManufacturerID], SKU.[SKUInternalStatusID], SKU.[SKUPublicStatusID], SKU.[SKUSupplierID], SKU.[SKUAvailableInDays], SKU.[SKUGUID], SKU.[SKUImagePath], SKU.[SKUWeight], SKU.[SKUWidth], SKU.[SKUDepth], SKU.[SKUHeight], SKU.[SKUAvailableItems], SKU.[SKUSellOnlyAvailable], SKU.[SKUCustomData], SKU.[SKUOptionCategoryID], SKU.[SKUOrder], SKU.[SKULastModified], SKU.[SKUCreated], SKU.[SKUSiteID], SKU.[SKUPrivateDonation], SKU.[SKUNeedsShipping], SKU.[SKUMaxDownloads], SKU.[SKUValidUntil], SKU.[SKUProductType], SKU.[SKUMaxItemsInOrder], SKU.[SKUMaxPrice], SKU.[SKUValidity], SKU.[SKUValidFor], SKU.[SKUMinPrice], SKU.[SKUMembershipGUID], SKU.[SKUConversionName], SKU.[SKUConversionValue], SKU.[SKUBundleInventoryType], SKU.[SKUMinItemsInOrder], SKU.[SKURetailPrice], SKU.[SKUParentSKUID], SKU.[SKUAllowAllVariants], SKU.[SKUInheritsTaxClasses], SKU.[SKUInheritsDiscounts], SKU.[SKUTrackInventory], SKU.[SKUShortDescription], SKU.[SKUEproductFilesCount], SKU.[SKUBundleItemsCount], SKU.[SKUInStoreFrom], SKU.[SKUReorderAt], U.FullName AS NodeOwnerFullName, U.UserName AS NodeOwnerUserName, U.Email AS NodeOwnerEmail 
--***************************************************************
--View_CMS_Tree_Joined_Regular V  WITH (NOEXPAND) 
--CREATE VIEW [dbo].[View_CMS_Tree_Joined_Regular] WITH SCHEMABINDING AS 
FROM dbo.CMS_Tree T 
INNER JOIN dbo.CMS_Document D ON T.NodeID = D.DocumentNodeID 
INNER JOIN dbo.CMS_Site S ON T.NodeSiteID = S.SiteID 
INNER JOIN dbo.CMS_Class C ON T.NodeClassID = C.ClassID
--***************************************************************
--LEFT OUTER JOIN dbo.View_COM_SKU AS SKU ON V.NodeSKUID = SKU.SKUID 
LEFT OUTER JOIN COM_SKU AS SKU ON T.NodeSKUID = SKU.SKUID 
--CREATE VIEW [dbo].[View_COM_SKU]
--AS
--SELECT * FROM COM_SKU
--***************************************************************
LEFT OUTER JOIN dbo.CMS_User U ON T.NodeOwner = U.UserID
UNION ALL
SELECT CASE WHEN (DocumentIsArchived IS NULL OR DocumentIsArchived = 0) 
AND ((DocumentCheckedOutVersionHistoryID IS NULL 
AND DocumentPublishedVersionHistoryID IS NULL) 
OR (DocumentCheckedOutVersionHistoryID IS NOT NULL 
AND DocumentPublishedVersionHistoryID IS NOT NULL)) 
AND (DocumentPublishFrom IS NULL 
OR (DocumentPublishFrom IS NOT NULL 
AND DocumentPublishFrom <= getdate())) 
AND (DocumentPublishTo IS NULL 
OR (DocumentPublishTo IS NOT NULL 
AND DocumentPublishTo >= getdate())) 
THEN 1 
ELSE 0 
END AS Published, T.*, SKU.[SKUID], SKU.[SKUNumber], SKU.[SKUName], SKU.[SKUDescription], SKU.[SKUPrice], SKU.[SKUEnabled], SKU.[SKUDepartmentID], SKU.[SKUManufacturerID], SKU.[SKUInternalStatusID], SKU.[SKUPublicStatusID], SKU.[SKUSupplierID], SKU.[SKUAvailableInDays], SKU.[SKUGUID], SKU.[SKUImagePath], SKU.[SKUWeight], SKU.[SKUWidth], SKU.[SKUDepth], SKU.[SKUHeight], SKU.[SKUAvailableItems], SKU.[SKUSellOnlyAvailable], SKU.[SKUCustomData], SKU.[SKUOptionCategoryID], SKU.[SKUOrder], SKU.[SKULastModified], SKU.[SKUCreated], SKU.[SKUSiteID], SKU.[SKUPrivateDonation], SKU.[SKUNeedsShipping], SKU.[SKUMaxDownloads], SKU.[SKUValidUntil], SKU.[SKUProductType], SKU.[SKUMaxItemsInOrder], SKU.[SKUMaxPrice], SKU.[SKUValidity], SKU.[SKUValidFor], SKU.[SKUMinPrice], SKU.[SKUMembershipGUID], SKU.[SKUConversionName], SKU.[SKUConversionValue], SKU.[SKUBundleInventoryType], SKU.[SKUMinItemsInOrder], SKU.[SKURetailPrice], SKU.[SKUParentSKUID], SKU.[SKUAllowAllVariants], SKU.[SKUInheritsTaxClasses], SKU.[SKUInheritsDiscounts], SKU.[SKUTrackInventory], SKU.[SKUShortDescription], SKU.[SKUEproductFilesCount], SKU.[SKUBundleItemsCount], SKU.[SKUInStoreFrom], SKU.[SKUReorderAt], U.FullName AS NodeOwnerFullName, U.UserName AS NodeOwnerUserName, U.Email AS NodeOwnerEmail 
--***************************************************************
--FROM View_CMS_Tree_Joined_Linked V  WITH (NOEXPAND) 
--CREATE VIEW [dbo].[View_CMS_Tree_Joined_Linked] WITH SCHEMABINDING AS 
--SELECT S.SiteName, C.ClassName, C.ClassDisplayName, T.[NodeID], T.[NodeAliasPath], T.[NodeName], T.[NodeAlias], T.[NodeClassID], T.[NodeParentID], T.[NodeLevel], T.[NodeACLID], T.[NodeSiteID], T.[NodeGUID], T.[NodeOrder], T.[IsSecuredNode], T.[NodeCacheMinutes], T.[NodeSKUID], T.[NodeDocType], T.[NodeHeadTags], T.[NodeBodyElementAttributes], T.[NodeInheritPageLevels], T.[NodeChildNodesCount], T.[RequiresSSL], T.[NodeLinkedNodeID], T.[NodeOwner], T.[NodeCustomData], T.[NodeGroupID], T.[NodeLinkedNodeSiteID], T.[NodeTemplateID], T.[NodeWireframeTemplateID], T.[NodeWireframeComment], T.[NodeTemplateForAllCultures], T.[NodeInheritPageTemplate], T.[NodeWireframeInheritPageLevels], T.[NodeAllowCacheInFileSystem], D.[DocumentID], D.[DocumentName], D.[DocumentNamePath], D.[DocumentModifiedWhen], D.[DocumentModifiedByUserID], D.[DocumentForeignKeyValue], D.[DocumentCreatedByUserID], D.[DocumentCreatedWhen], D.[DocumentCheckedOutByUserID], D.[DocumentCheckedOutWhen], D.[DocumentCheckedOutVersionHistoryID], D.[DocumentPublishedVersionHistoryID], D.[DocumentWorkflowStepID], D.[DocumentPublishFrom], D.[DocumentPublishTo], D.[DocumentUrlPath], D.[DocumentCulture], D.[DocumentNodeID], D.[DocumentPageTitle], D.[DocumentPageKeyWords], D.[DocumentPageDescription], D.[DocumentShowInSiteMap], D.[DocumentMenuItemHideInNavigation], D.[DocumentMenuCaption], D.[DocumentMenuStyle], D.[DocumentMenuItemImage], D.[DocumentMenuItemLeftImage], D.[DocumentMenuItemRightImage], D.[DocumentPageTemplateID], D.[DocumentMenuJavascript], D.[DocumentMenuRedirectUrl], D.[DocumentUseNamePathForUrlPath], D.[DocumentStylesheetID], D.[DocumentContent], D.[DocumentMenuClass], D.[DocumentMenuStyleOver], D.[DocumentMenuClassOver], D.[DocumentMenuItemImageOver], D.[DocumentMenuItemLeftImageOver], D.[DocumentMenuItemRightImageOver], D.[DocumentMenuStyleHighlighted], D.[DocumentMenuClassHighlighted], D.[DocumentMenuItemImageHighlighted], D.[DocumentMenuItemLeftImageHighlighted], D.[DocumentMenuItemRightImageHighlighted], D.[DocumentMenuItemInactive], D.[DocumentCustomData], D.[DocumentExtensions], D.[DocumentCampaign], D.[DocumentTags], D.[DocumentTagGroupID], D.[DocumentWildcardRule], D.[DocumentWebParts], D.[DocumentRatingValue], D.[DocumentRatings], D.[DocumentPriority], D.[DocumentType], D.[DocumentLastPublished], D.[DocumentUseCustomExtensions], D.[DocumentGroupWebParts], D.[DocumentCheckedOutAutomatically], D.[DocumentTrackConversionName], D.[DocumentConversionValue], D.[DocumentSearchExcluded], D.[DocumentLastVersionName], D.[DocumentLastVersionNumber], D.[DocumentIsArchived], D.[DocumentLastVersionType], D.[DocumentLastVersionMenuRedirectUrl], D.[DocumentHash], D.[DocumentLogVisitActivity], D.[DocumentGUID], D.[DocumentWorkflowCycleGUID], D.[DocumentSitemapSettings], D.[DocumentIsWaitingForTranslation], D.[DocumentSKUName], D.[DocumentSKUDescription], D.[DocumentSKUShortDescription], D.[DocumentWorkflowActionStatus]
FROM 
dbo.CMS_Tree T 
INNER JOIN dbo.CMS_Document D ON T.NodeLinkedNodeID = D.DocumentNodeID 
INNER JOIN dbo.CMS_Site S ON T.NodeSiteID = S.SiteID 
INNER JOIN dbo.CMS_Class C ON T.NodeClassID = C.ClassID
--***************************************************************
--LEFT OUTER JOIN dbo.View_COM_SKU AS SKU ON V.NodeSKUID = SKU.SKUID 
LEFT OUTER JOIN COM_SKU AS SKU ON T.NodeSKUID = SKU.SKUID 
--***************************************************************
LEFT OUTER JOIN dbo.CMS_User U ON T.NodeOwner = U.UserID
GO


