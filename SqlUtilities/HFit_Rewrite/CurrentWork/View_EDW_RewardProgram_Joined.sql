
print ('Creating View_EDW_RewardProgram_Joined: ' +  cast(getdate() as nvarchar(50)));
go
if exists (select name from sys.views where name = 'View_EDW_RewardProgram_Joined')
BEGIN
	print ('Re-creating View_EDW_RewardProgram_Joined' +  cast(getdate() as nvarchar(50)));
	drop view View_EDW_RewardProgram_Joined ;
END
go

--This view is created in place of View_Hfit_RewardProgram_Joined so that 
--Document Culture can be taken into consideration. 
CREATE VIEW [dbo].[View_EDW_RewardProgram_Joined] AS 

--03.03.2015 : Reviewed by NAthan and Dale, no change required.

SELECT CT.[Published]
      ,CT.[SiteName]
      ,CT.[ClassName]
      ,CT.[ClassDisplayName]
      ,CT.[NodeID]
      ,CT.[NodeAliasPath]
      ,CT.[NodeName]
      ,CT.[NodeAlias]
      ,CT.[NodeClassID]
      ,CT.[NodeParentID]
      ,CT.[NodeLevel]
      ,CT.[NodeACLID]
      ,CT.[NodeSiteID]
      ,CT.[NodeGUID]
      ,CT.[NodeOrder]
      ,CT.[IsSecuredNode]
      ,CT.[NodeCacheMinutes]
      ,CT.[NodeSKUID]
      ,CT.[NodeDocType]
      ,CT.[NodeHeadTags]
      ,CT.[NodeBodyElementAttributes]
      ,CT.[NodeInheritPageLevels]
      ,CT.[RequiresSSL]
      ,CT.[NodeLinkedNodeID]
      ,CT.[NodeOwner]
      ,CT.[NodeCustomData]
      ,CT.[NodeGroupID]
      ,CT.[NodeLinkedNodeSiteID]
      ,CT.[NodeTemplateID]
      ,CT.[NodeWireframeTemplateID]
      ,CT.[NodeWireframeComment]
      ,CT.[NodeTemplateForAllCultures]
      ,CT.[NodeInheritPageTemplate]
      ,CT.[NodeWireframeInheritPageLevels]
      ,CT.[NodeAllowCacheInFileSystem]
      --,CT.[NodeHasChildren]
      --,CT.[NodeHasLinks]
      ,CT.[DocumentID]
      ,CT.[DocumentName]
      ,CT.[DocumentNamePath]
      ,cast(CT.[DocumentModifiedWhen] as datetime) as [DocumentModifiedWhen]
      ,CT.[DocumentModifiedByUserID]
      ,CT.[DocumentForeignKeyValue]
      ,CT.[DocumentCreatedByUserID]
      ,cast(CT.[DocumentCreatedWhen] as datetime) as [DocumentCreatedWhen]
      ,CT.[DocumentCheckedOutByUserID]
      ,cast(CT.[DocumentCheckedOutWhen] as datetime) as [DocumentCheckedOutWhen]
      ,CT.[DocumentCheckedOutVersionHistoryID]
      ,CT.[DocumentPublishedVersionHistoryID]
      ,CT.[DocumentWorkflowStepID]
      ,cast(CT.[DocumentPublishFrom] as datetime) as [DocumentPublishFrom]
      ,cast(CT.[DocumentPublishTo] as datetime) as [DocumentPublishTo]
      ,CT.[DocumentUrlPath]
      ,CT.[DocumentCulture]
      ,CT.[DocumentNodeID]
      ,CT.[DocumentPageTitle]
      ,CT.[DocumentPageKeyWords]
      ,CT.[DocumentPageDescription]
      ,CT.[DocumentShowInSiteMap]
      ,CT.[DocumentMenuItemHideInNavigation]
      ,CT.[DocumentMenuCaption]
      ,CT.[DocumentMenuStyle]
      ,CT.[DocumentMenuItemImage]
      ,CT.[DocumentMenuItemLeftImage]
      ,CT.[DocumentMenuItemRightImage]
      ,CT.[DocumentPageTemplateID]
      ,CT.[DocumentMenuJavascript]
      ,CT.[DocumentMenuRedirectUrl]
      ,CT.[DocumentUseNamePathForUrlPath]
      ,CT.[DocumentStylesheetID]
      ,CT.[DocumentContent]
      ,CT.[DocumentMenuClass]
      ,CT.[DocumentMenuStyleOver]
      ,CT.[DocumentMenuClassOver]
      ,CT.[DocumentMenuItemImageOver]
      ,CT.[DocumentMenuItemLeftImageOver]
      ,CT.[DocumentMenuItemRightImageOver]
      ,CT.[DocumentMenuStyleHighlighted]
      ,CT.[DocumentMenuClassHighlighted]
      ,CT.[DocumentMenuItemImageHighlighted]
      ,CT.[DocumentMenuItemLeftImageHighlighted]
      ,CT.[DocumentMenuItemRightImageHighlighted]
      ,CT.[DocumentMenuItemInactive]
      ,CT.[DocumentCustomData]
      ,CT.[DocumentExtensions]
      ,CT.[DocumentCampaign]
      ,CT.[DocumentTags]
      ,CT.[DocumentTagGroupID]
      ,CT.[DocumentWildcardRule]
      ,CT.[DocumentWebParts]
      ,CT.[DocumentRatingValue]
      ,CT.[DocumentRatings]
      ,CT.[DocumentPriority]
      ,CT.[DocumentType]
      ,cast(CT.[DocumentLastPublished] as datetime) as [DocumentLastPublished]
      ,CT.[DocumentUseCustomExtensions]
      ,CT.[DocumentGroupWebParts]
      ,CT.[DocumentCheckedOutAutomatically]
      ,CT.[DocumentTrackConversionName]
      ,CT.[DocumentConversionValue]
      ,CT.[DocumentSearchExcluded]
      ,CT.[DocumentLastVersionName]
      ,CT.[DocumentLastVersionNumber]
      ,CT.[DocumentIsArchived]
      ,CT.[DocumentLastVersionType]
      ,CT.[DocumentLastVersionMenuRedirectUrl]
      ,CT.[DocumentHash]
      ,CT.[DocumentLogVisitActivity]
      ,CT.[DocumentGUID]
      ,CT.[DocumentWorkflowCycleGUID]
      ,CT.[DocumentSitemapSettings]
      ,CT.[DocumentIsWaitingForTranslation]
      ,CT.[DocumentSKUName]
      ,CT.[DocumentSKUDescription]
      ,CT.[DocumentSKUShortDescription]
      ,CT.[DocumentWorkflowActionStatus]
      --,CT.[DocumentMenuRedirectToFirstChild]
      ,CT.[SKUID]
      ,CT.[SKUNumber]
      ,CT.[SKUName]
      ,CT.[SKUDescription]
      ,CT.[SKUPrice]
      ,CT.[SKUEnabled]
      ,CT.[SKUDepartmentID]
      ,CT.[SKUManufacturerID]
      ,CT.[SKUInternalStatusID]
      ,CT.[SKUPublicStatusID]
      ,CT.[SKUSupplierID]
      ,CT.[SKUAvailableInDays]
      ,CT.[SKUGUID]
      ,CT.[SKUImagePath]
      ,CT.[SKUWeight]
      ,CT.[SKUWidth]
      ,CT.[SKUDepth]
      ,CT.[SKUHeight]
      ,CT.[SKUAvailableItems]
      ,CT.[SKUSellOnlyAvailable]
      ,CT.[SKUCustomData]
      ,CT.[SKUOptionCategoryID]
      ,CT.[SKUOrder]
      ,cast(CT.[SKULastModified] as datetime ) as [SKULastModified] 
      ,cast(CT.[SKUCreated] as datetime ) as [SKUCreated]
      ,CT.[SKUSiteID]
      ,CT.[SKUPrivateDonation]
      ,CT.[SKUNeedsShipping]
      ,CT.[SKUMaxDownloads]
      ,cast(CT.[SKUValidUntil] as datetime ) as [SKUValidUntil] 
      ,CT.[SKUProductType]
      ,CT.[SKUMaxItemsInOrder]
      ,CT.[SKUMaxPrice]
      ,CT.[SKUValidity]
      ,CT.[SKUValidFor]
      ,CT.[SKUMinPrice]
      ,CT.[SKUMembershipGUID]
      ,CT.[SKUConversionName]
      ,CT.[SKUConversionValue]
      ,CT.[SKUBundleInventoryType]
      ,CT.[SKUMinItemsInOrder]
      ,CT.[SKURetailPrice]
      ,CT.[SKUParentSKUID]
      ,CT.[SKUAllowAllVariants]
      ,CT.[SKUInheritsTaxClasses]
      ,CT.[SKUInheritsDiscounts]
      ,CT.[SKUTrackInventory]
      ,CT.[SKUShortDescription]
      ,CT.[SKUEproductFilesCount]
      ,CT.[SKUBundleItemsCount]
      ,cast(CT.[SKUInStoreFrom] as datetime) as [SKUInStoreFrom]
      ,CT.[SKUReorderAt]
      ,CT.[NodeOwnerFullName]
      ,CT.[NodeOwnerUserName]
      ,CT.[NodeOwnerEmail]

    ,  RP.[RewardProgramID]
      ,RP.[RewardProgramName]
      ,cast(RP.[RewardProgramPeriodEnd] as datetime) as [RewardProgramPeriodEnd]
      ,RP.[ProgramDescription]
      ,cast(RP.[RewardProgramPeriodStart] as datetime) as [RewardProgramPeriodStart]
	FROM View_CMS_Tree_Joined as CT
	INNER JOIN HFit_RewardProgram RP
		ON CT.DocumentForeignKeyValue = RP.[RewardProgramID] 
WHERE ClassName = 'HFit.RewardProgram'
AND CT.documentculture = 'en-US'
GO

print ('Created View_EDW_RewardProgram_Joined: ' + cast(getdate() as nvarchar(50)));
go  --  
  --  
GO 
print('***** FROM: View_EDW_RewardProgram_Joined.sql'); 
GO 