
--CREATE VIEW dbo.View_CMS_Tree_Joined_Regular
   
SELECT S.SiteName
        , C.ClassName
        , C.ClassDisplayName
        , T.NodeID
        , T.NodeAliasPath
        , T.NodeName
        , T.NodeAlias
        , T.NodeClassID
        , T.NodeParentID
        , T.NodeLevel
        , T.NodeACLID
        , T.NodeSiteID
        , T.NodeGUID
        , T.NodeOrder
        , T.IsSecuredNode
        , T.NodeCacheMinutes
        , T.NodeSKUID
        , T.NodeDocType
        , T.NodeHeadTags
        , T.NodeBodyElementAttributes
        , T.NodeInheritPageLevels
        , T.RequiresSSL
        , T.NodeLinkedNodeID
        , T.NodeOwner
        , T.NodeCustomData
        , T.NodeGroupID
        , T.NodeLinkedNodeSiteID
        , T.NodeTemplateID
        , T.NodeWireframeTemplateID
        , T.NodeWireframeComment
        , T.NodeTemplateForAllCultures
        , T.NodeInheritPageTemplate
        , T.NodeWireframeInheritPageLevels
        , T.NodeAllowCacheInFileSystem
        , T.NodeHasChildren
        , T.NodeHasLinks
        , D.DocumentID
        , D.DocumentName
        , D.DocumentNamePath
        , D.DocumentModifiedWhen
        , D.DocumentModifiedByUserID
        , D.DocumentForeignKeyValue
        , D.DocumentCreatedByUserID
        , D.DocumentCreatedWhen
        , D.DocumentCheckedOutByUserID
        , D.DocumentCheckedOutWhen
        , D.DocumentCheckedOutVersionHistoryID
        , D.DocumentPublishedVersionHistoryID
        , D.DocumentWorkflowStepID
        , D.DocumentPublishFrom
        , D.DocumentPublishTo
        , D.DocumentUrlPath
        , D.DocumentCulture
        , D.DocumentNodeID
        , D.DocumentPageTitle
        , D.DocumentPageKeyWords
        , D.DocumentPageDescription
        , D.DocumentShowInSiteMap
        , D.DocumentMenuItemHideInNavigation
        , D.DocumentMenuCaption
        , D.DocumentMenuStyle
        , D.DocumentMenuItemImage
        , D.DocumentMenuItemLeftImage
        , D.DocumentMenuItemRightImage
        , D.DocumentPageTemplateID
        , D.DocumentMenuJavascript
        , D.DocumentMenuRedirectUrl
        , D.DocumentUseNamePathForUrlPath
        , D.DocumentStylesheetID
        , D.DocumentContent
        , D.DocumentMenuClass
        , D.DocumentMenuStyleOver
        , D.DocumentMenuClassOver
        , D.DocumentMenuItemImageOver
        , D.DocumentMenuItemLeftImageOver
        , D.DocumentMenuItemRightImageOver
        , D.DocumentMenuStyleHighlighted
        , D.DocumentMenuClassHighlighted
        , D.DocumentMenuItemImageHighlighted
        , D.DocumentMenuItemLeftImageHighlighted
        , D.DocumentMenuItemRightImageHighlighted
        , D.DocumentMenuItemInactive
        , D.DocumentCustomData
        , D.DocumentExtensions
        , D.DocumentCampaign
        , D.DocumentTags
        , D.DocumentTagGroupID
        , D.DocumentWildcardRule
        , D.DocumentWebParts
        , D.DocumentRatingValue
        , D.DocumentRatings
        , D.DocumentPriority
        , D.DocumentType
        , D.DocumentLastPublished
        , D.DocumentUseCustomExtensions
        , D.DocumentGroupWebParts
        , D.DocumentCheckedOutAutomatically
        , D.DocumentTrackConversionName
        , D.DocumentConversionValue
        , D.DocumentSearchExcluded
        , D.DocumentLastVersionName
        , D.DocumentLastVersionNumber
        , D.DocumentIsArchived
        , D.DocumentLastVersionType
        , D.DocumentLastVersionMenuRedirectUrl
        , D.DocumentHash
        , D.DocumentLogVisitActivity
        , D.DocumentGUID
        , D.DocumentWorkflowCycleGUID
        , D.DocumentSitemapSettings
        , D.DocumentIsWaitingForTranslation
        , D.DocumentSKUName
        , D.DocumentSKUDescription
        , D.DocumentSKUShortDescription
        , D.DocumentWorkflowActionStatus
        , D.DocumentMenuRedirectToFirstChild
        , D.SVR
        , D.DBNAME
        , D.LastModifiedDate AS Document_LastModifiedDate
        , S.LastModifiedDate AS SITE_LastModifiedDate
        , C.LastModifiedDate AS CLASS_LastModifiedDate
        , T.LastModifiedDate AS Tree_LastModifiedDate

--View_CMS_Tree_Joined_Regular
select count(*)
          FROM dbo.FACT_CMS_Tree AS T
                   INNER JOIN dbo.FACT_CMS_Document AS D
                       ON T.NodeID = D.DocumentNodeID
                      AND T.SVR = D.SVR
                      AND T.DBNAME = D.DBNAME
                   INNER JOIN dbo.FACT_CMS_Site AS S
                       ON T.NodeSiteID = S.SiteID
                      AND T.SVR = s.SVR
                      AND T.DBNAME = s.DBNAME
                   INNER JOIN dbo.FACT_CMS_Class AS C
                       ON T.NodeClassID = C.ClassID
                      AND T.SVR = c.SVR
                      AND T.DBNAME = c.DBNAME;

GO


