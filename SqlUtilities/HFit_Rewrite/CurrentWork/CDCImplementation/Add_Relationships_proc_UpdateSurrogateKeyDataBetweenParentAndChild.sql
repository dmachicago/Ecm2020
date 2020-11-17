--delete from MART_SYNC_Table_FKRels
go
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 'base_CMS_User', 'SurrogateKey_CMS_User', 'base_view_EDW_CoachingPPTEligible', 'UserID', 'UserID', 0
go
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 'base_CMS_User', 'SurrogateKey_CMS_User', 'base_view_EDW_CoachingPPTEnrolled', 'UserID', 'UserID', 0
go
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 'BASE_HFIT_Account', 'SurrogateKey_HFit_Account', 'base_view_EDW_CoachingPPTEligible', 'AccountID', 'AccountID', 0
go
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 'BASE_HFIT_Account', 'SurrogateKey_HFit_Account', 'base_view_EDW_CoachingPPTEnrolled', 'AccountID', 'AccountID', 0
go
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 'BASE_CMS_User', 'SurrogateKey_CMS_User', 'base_view_EDW_CoachingPPTEligible', 'UserID', 'UserID', 0 ;
go
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_Board_Board',@ParentSurrogateKeyName = 'SurrogateKey_Board_Board',@ChildTable = 'BASE_CMS_Document',@ParentColumn = 'BoardDocumentID',@ChildColumn = 'DocumentID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_Board_Board',@ParentSurrogateKeyName = 'SurrogateKey_Board_Board',@ChildTable = 'BASE_CMS_Site',@ParentColumn = 'BoardSiteID',@ChildColumn = 'SiteID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_Board_Board',@ParentSurrogateKeyName = 'SurrogateKey_Board_Board',@ChildTable = 'BASE_CMS_User',@ParentColumn = 'BoardUserID',@ChildColumn = 'UserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_Board_Board',@ParentSurrogateKeyName = 'SurrogateKey_Board_Board',@ChildTable = 'BASE_Community_Group',@ParentColumn = 'BoardGroupID',@ChildColumn = 'GroupID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_Board_Message',@ParentSurrogateKeyName = 'SurrogateKey_Board_Message',@ChildTable = 'BASE_Board_Board',@ParentColumn = 'MessageBoardID',@ChildColumn = 'BoardID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_Board_Message',@ParentSurrogateKeyName = 'SurrogateKey_Board_Message',@ChildTable = 'BASE_CMS_User',@ParentColumn = 'MessageApprovedByUserID',@ChildColumn = 'UserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_Board_Message',@ParentSurrogateKeyName = 'SurrogateKey_Board_Message',@ChildTable = 'BASE_CMS_User',@ParentColumn = 'MessageUserID',@ChildColumn = 'UserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_Chat_Message',@ParentSurrogateKeyName = 'SurrogateKey_Chat_Message',@ChildTable = 'BASE_Chat_Room',@ParentColumn = 'ChatMessageRoomID',@ChildColumn = 'ChatRoomID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_Chat_Message',@ParentSurrogateKeyName = 'SurrogateKey_Chat_Message',@ChildTable = 'BASE_Chat_User',@ParentColumn = 'ChatMessageRecipientID',@ChildColumn = 'ChatUserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_Chat_Message',@ParentSurrogateKeyName = 'SurrogateKey_Chat_Message',@ChildTable = 'BASE_Chat_User',@ParentColumn = 'ChatMessageUserID',@ChildColumn = 'ChatUserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_Chat_Room',@ParentSurrogateKeyName = 'SurrogateKey_Chat_Room',@ChildTable = 'BASE_Chat_User',@ParentColumn = 'ChatRoomCreatedByChatUserID',@ChildColumn = 'ChatUserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_Chat_Room',@ParentSurrogateKeyName = 'SurrogateKey_Chat_Room',@ChildTable = 'BASE_CMS_Site',@ParentColumn = 'ChatRoomSiteID',@ChildColumn = 'SiteID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_Chat_User',@ParentSurrogateKeyName = 'SurrogateKey_Chat_User',@ChildTable = 'BASE_CMS_User',@ParentColumn = 'ChatUserUserID',@ChildColumn = 'UserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_AbuseReport',@ParentSurrogateKeyName = 'SurrogateKey_CMS_AbuseReport',@ChildTable = 'BASE_CMS_Site',@ParentColumn = 'ReportSiteID',@ChildColumn = 'SiteID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_AbuseReport',@ParentSurrogateKeyName = 'SurrogateKey_CMS_AbuseReport',@ChildTable = 'BASE_CMS_User',@ParentColumn = 'ReportUserID',@ChildColumn = 'UserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_ACL',@ParentSurrogateKeyName = 'SurrogateKey_CMS_ACL',@ChildTable = 'BASE_CMS_Site',@ParentColumn = 'ACLSiteID',@ChildColumn = 'SiteID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_ACLItem',@ParentSurrogateKeyName = 'SurrogateKey_CMS_ACLItem',@ChildTable = 'BASE_CMS_ACL',@ParentColumn = 'ACLID',@ChildColumn = 'ACLID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_ACLItem',@ParentSurrogateKeyName = 'SurrogateKey_CMS_ACLItem',@ChildTable = 'BASE_CMS_Role',@ParentColumn = 'RoleID',@ChildColumn = 'RoleID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_ACLItem',@ParentSurrogateKeyName = 'SurrogateKey_CMS_ACLItem',@ChildTable = 'BASE_CMS_User',@ParentColumn = 'LastModifiedByUserID',@ChildColumn = 'UserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_ACLItem',@ParentSurrogateKeyName = 'SurrogateKey_CMS_ACLItem',@ChildTable = 'BASE_CMS_User',@ParentColumn = 'UserID',@ChildColumn = 'UserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_AllowedChildClasses',@ParentSurrogateKeyName = 'SurrogateKey_CMS_AllowedChildClasses',@ChildTable = 'BASE_CMS_Class',@ParentColumn = 'ChildClassID',@ChildColumn = 'ClassID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_AllowedChildClasses',@ParentSurrogateKeyName = 'SurrogateKey_CMS_AllowedChildClasses',@ChildTable = 'BASE_CMS_Class',@ParentColumn = 'ParentClassID',@ChildColumn = 'ClassID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_AlternativeForm',@ParentSurrogateKeyName = 'SurrogateKey_CMS_AlternativeForm',@ChildTable = 'BASE_CMS_Class',@ParentColumn = 'FormClassID',@ChildColumn = 'ClassID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_AlternativeForm',@ParentSurrogateKeyName = 'SurrogateKey_CMS_AlternativeForm',@ChildTable = 'BASE_CMS_Class',@ParentColumn = 'FormCoupledClassID',@ChildColumn = 'ClassID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_Attachment',@ParentSurrogateKeyName = 'SurrogateKey_CMS_Attachment',@ChildTable = 'BASE_CMS_Document',@ParentColumn = 'AttachmentDocumentID',@ChildColumn = 'DocumentID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_Attachment',@ParentSurrogateKeyName = 'SurrogateKey_CMS_Attachment',@ChildTable = 'BASE_CMS_Site',@ParentColumn = 'AttachmentSiteID',@ChildColumn = 'SiteID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_AttachmentForEmail',@ParentSurrogateKeyName = 'SurrogateKey_CMS_AttachmentForEmail',@ChildTable = 'BASE_CMS_Email',@ParentColumn = 'EmailID',@ChildColumn = 'EmailID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_AttachmentForEmail',@ParentSurrogateKeyName = 'SurrogateKey_CMS_AttachmentForEmail',@ChildTable = 'BASE_CMS_EmailAttachment',@ParentColumn = 'AttachmentID',@ChildColumn = 'AttachmentID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_AttachmentHistory',@ParentSurrogateKeyName = 'SurrogateKey_CMS_AttachmentHistory',@ChildTable = 'BASE_CMS_Site',@ParentColumn = 'AttachmentSiteID',@ChildColumn = 'SiteID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_AutomationHistory',@ParentSurrogateKeyName = 'SurrogateKey_CMS_AutomationHistory',@ChildTable = 'BASE_CMS_AutomationState',@ParentColumn = 'HistoryStateID',@ChildColumn = 'StateID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_AutomationHistory',@ParentSurrogateKeyName = 'SurrogateKey_CMS_AutomationHistory',@ChildTable = 'BASE_CMS_User',@ParentColumn = 'HistoryApprovedByUserID',@ChildColumn = 'UserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_AutomationHistory',@ParentSurrogateKeyName = 'SurrogateKey_CMS_AutomationHistory',@ChildTable = 'BASE_CMS_Workflow',@ParentColumn = 'HistoryWorkflowID',@ChildColumn = 'WorkflowID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_AutomationHistory',@ParentSurrogateKeyName = 'SurrogateKey_CMS_AutomationHistory',@ChildTable = 'BASE_CMS_WorkflowStep',@ParentColumn = 'HistoryStepID',@ChildColumn = 'StepID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_AutomationHistory',@ParentSurrogateKeyName = 'SurrogateKey_CMS_AutomationHistory',@ChildTable = 'BASE_CMS_WorkflowStep',@ParentColumn = 'HistoryTargetStepID',@ChildColumn = 'StepID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_AutomationState',@ParentSurrogateKeyName = 'SurrogateKey_CMS_AutomationState',@ChildTable = 'BASE_CMS_Site',@ParentColumn = 'StateSiteID',@ChildColumn = 'SiteID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_AutomationState',@ParentSurrogateKeyName = 'SurrogateKey_CMS_AutomationState',@ChildTable = 'BASE_CMS_User',@ParentColumn = 'StateUserID',@ChildColumn = 'UserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_AutomationState',@ParentSurrogateKeyName = 'SurrogateKey_CMS_AutomationState',@ChildTable = 'BASE_CMS_Workflow',@ParentColumn = 'StateWorkflowID',@ChildColumn = 'WorkflowID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_AutomationState',@ParentSurrogateKeyName = 'SurrogateKey_CMS_AutomationState',@ChildTable = 'BASE_CMS_WorkflowStep',@ParentColumn = 'StateStepID',@ChildColumn = 'StepID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_BannedIP',@ParentSurrogateKeyName = 'SurrogateKey_CMS_BannedIP',@ChildTable = 'BASE_CMS_Site',@ParentColumn = 'IPAddressSiteID',@ChildColumn = 'SiteID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_Banner',@ParentSurrogateKeyName = 'SurrogateKey_CMS_Banner',@ChildTable = 'BASE_CMS_BannerCategory',@ParentColumn = 'BannerCategoryID',@ChildColumn = 'BannerCategoryID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_Banner',@ParentSurrogateKeyName = 'SurrogateKey_CMS_Banner',@ChildTable = 'BASE_CMS_Site',@ParentColumn = 'BannerSiteID',@ChildColumn = 'SiteID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_BannerCategory',@ParentSurrogateKeyName = 'SurrogateKey_CMS_BannerCategory',@ChildTable = 'BASE_CMS_Site',@ParentColumn = 'BannerCategorySiteID',@ChildColumn = 'SiteID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_Category',@ParentSurrogateKeyName = 'SurrogateKey_CMS_Category',@ChildTable = 'BASE_CMS_Site',@ParentColumn = 'CategorySiteID',@ChildColumn = 'SiteID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_Category',@ParentSurrogateKeyName = 'SurrogateKey_CMS_Category',@ChildTable = 'BASE_CMS_User',@ParentColumn = 'CategoryUserID',@ChildColumn = 'UserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_Class',@ParentSurrogateKeyName = 'SurrogateKey_CMS_Class',@ChildTable = 'BASE_CMS_PageTemplate',@ParentColumn = 'ClassDefaultPageTemplateID',@ChildColumn = 'PageTemplateID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_Class',@ParentSurrogateKeyName = 'SurrogateKey_CMS_Class',@ChildTable = 'BASE_CMS_PageTemplateCategory',@ParentColumn = 'ClassPageTemplateCategoryID',@ChildColumn = 'CategoryID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_Class',@ParentSurrogateKeyName = 'SurrogateKey_CMS_Class',@ChildTable = 'BASE_CMS_Resource',@ParentColumn = 'ClassResourceID',@ChildColumn = 'ResourceID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_ClassSite',@ParentSurrogateKeyName = 'SurrogateKey_CMS_ClassSite',@ChildTable = 'BASE_CMS_Class',@ParentColumn = 'ClassID',@ChildColumn = 'ClassID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_ClassSite',@ParentSurrogateKeyName = 'SurrogateKey_CMS_ClassSite',@ChildTable = 'BASE_CMS_Site',@ParentColumn = 'SiteID',@ChildColumn = 'SiteID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_CssStylesheetSite',@ParentSurrogateKeyName = 'SurrogateKey_CMS_CssStylesheetSite',@ChildTable = 'BASE_CMS_CssStylesheet',@ParentColumn = 'StylesheetID',@ChildColumn = 'StylesheetID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_CssStylesheetSite',@ParentSurrogateKeyName = 'SurrogateKey_CMS_CssStylesheetSite',@ChildTable = 'BASE_CMS_Site',@ParentColumn = 'SiteID',@ChildColumn = 'SiteID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_Document',@ParentSurrogateKeyName = 'SurrogateKey_CMS_Document',@ChildTable = 'BASE_CMS_PageTemplate',@ParentColumn = 'DocumentPageTemplateID',@ChildColumn = 'PageTemplateID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_Document',@ParentSurrogateKeyName = 'SurrogateKey_CMS_Document',@ChildTable = 'BASE_CMS_TagGroup',@ParentColumn = 'DocumentTagGroupID',@ChildColumn = 'TagGroupID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_Document',@ParentSurrogateKeyName = 'SurrogateKey_CMS_Document',@ChildTable = 'BASE_CMS_Tree',@ParentColumn = 'DocumentNodeID',@ChildColumn = 'NodeID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_Document',@ParentSurrogateKeyName = 'SurrogateKey_CMS_Document',@ChildTable = 'BASE_CMS_User',@ParentColumn = 'DocumentCheckedOutByUserID',@ChildColumn = 'UserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_Document',@ParentSurrogateKeyName = 'SurrogateKey_CMS_Document',@ChildTable = 'BASE_CMS_User',@ParentColumn = 'DocumentCreatedByUserID',@ChildColumn = 'UserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_Document',@ParentSurrogateKeyName = 'SurrogateKey_CMS_Document',@ChildTable = 'BASE_CMS_User',@ParentColumn = 'DocumentModifiedByUserID',@ChildColumn = 'UserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_Document',@ParentSurrogateKeyName = 'SurrogateKey_CMS_Document',@ChildTable = 'BASE_CMS_VersionHistory',@ParentColumn = 'DocumentCheckedOutVersionHistoryID',@ChildColumn = 'VersionHistoryID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_Document',@ParentSurrogateKeyName = 'SurrogateKey_CMS_Document',@ChildTable = 'BASE_CMS_VersionHistory',@ParentColumn = 'DocumentPublishedVersionHistoryID',@ChildColumn = 'VersionHistoryID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_Document',@ParentSurrogateKeyName = 'SurrogateKey_CMS_Document',@ChildTable = 'BASE_CMS_WorkflowStep',@ParentColumn = 'DocumentWorkflowStepID',@ChildColumn = 'StepID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_DocumentAlias',@ParentSurrogateKeyName = 'SurrogateKey_CMS_DocumentAlias',@ChildTable = 'BASE_CMS_Site',@ParentColumn = 'AliasSiteID',@ChildColumn = 'SiteID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_DocumentAlias',@ParentSurrogateKeyName = 'SurrogateKey_CMS_DocumentAlias',@ChildTable = 'BASE_CMS_Tree',@ParentColumn = 'AliasNodeID',@ChildColumn = 'NodeID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_DocumentCategory',@ParentSurrogateKeyName = 'SurrogateKey_CMS_DocumentCategory',@ChildTable = 'BASE_CMS_Category',@ParentColumn = 'CategoryID',@ChildColumn = 'CategoryID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_DocumentCategory',@ParentSurrogateKeyName = 'SurrogateKey_CMS_DocumentCategory',@ChildTable = 'BASE_CMS_Document',@ParentColumn = 'DocumentID',@ChildColumn = 'DocumentID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_DocumentTag',@ParentSurrogateKeyName = 'SurrogateKey_CMS_DocumentTag',@ChildTable = 'BASE_CMS_Document',@ParentColumn = 'DocumentID',@ChildColumn = 'DocumentID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_DocumentTag',@ParentSurrogateKeyName = 'SurrogateKey_CMS_DocumentTag',@ChildTable = 'BASE_CMS_Tag',@ParentColumn = 'TagID',@ChildColumn = 'TagID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_DocumentTypeScope',@ParentSurrogateKeyName = 'SurrogateKey_CMS_DocumentTypeScope',@ChildTable = 'BASE_CMS_Site',@ParentColumn = 'ScopeSiteID',@ChildColumn = 'SiteID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_DocumentTypeScopeClass',@ParentSurrogateKeyName = 'SurrogateKey_CMS_DocumentTypeScopeClass',@ChildTable = 'BASE_CMS_Class',@ParentColumn = 'ClassID',@ChildColumn = 'ClassID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_DocumentTypeScopeClass',@ParentSurrogateKeyName = 'SurrogateKey_CMS_DocumentTypeScopeClass',@ChildTable = 'BASE_CMS_DocumentTypeScope',@ParentColumn = 'ScopeID',@ChildColumn = 'ScopeID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_EmailTemplate',@ParentSurrogateKeyName = 'SurrogateKey_CMS_EmailTemplate',@ChildTable = 'BASE_CMS_Site',@ParentColumn = 'EmailTemplateSiteID',@ChildColumn = 'SiteID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_EmailUser',@ParentSurrogateKeyName = 'SurrogateKey_CMS_EmailUser',@ChildTable = 'BASE_CMS_Email',@ParentColumn = 'EmailID',@ChildColumn = 'EmailID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_EmailUser',@ParentSurrogateKeyName = 'SurrogateKey_CMS_EmailUser',@ChildTable = 'BASE_CMS_User',@ParentColumn = 'UserID',@ChildColumn = 'UserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_EventLog',@ParentSurrogateKeyName = 'SurrogateKey_CMS_EventLog',@ChildTable = 'BASE_CMS_Site',@ParentColumn = 'SiteID',@ChildColumn = 'SiteID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_Form',@ParentSurrogateKeyName = 'SurrogateKey_CMS_Form',@ChildTable = 'BASE_CMS_Class',@ParentColumn = 'FormClassID',@ChildColumn = 'ClassID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_Form',@ParentSurrogateKeyName = 'SurrogateKey_CMS_Form',@ChildTable = 'BASE_CMS_Site',@ParentColumn = 'FormSiteID',@ChildColumn = 'SiteID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_FormRole',@ParentSurrogateKeyName = 'SurrogateKey_CMS_FormRole',@ChildTable = 'BASE_CMS_Form',@ParentColumn = 'FormID',@ChildColumn = 'FormID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_FormRole',@ParentSurrogateKeyName = 'SurrogateKey_CMS_FormRole',@ChildTable = 'BASE_CMS_Role',@ParentColumn = 'RoleID',@ChildColumn = 'RoleID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_FormUserControl',@ParentSurrogateKeyName = 'SurrogateKey_CMS_FormUserControl',@ChildTable = 'BASE_CMS_Resource',@ParentColumn = 'UserControlResourceID',@ChildColumn = 'ResourceID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_InlineControl',@ParentSurrogateKeyName = 'SurrogateKey_CMS_InlineControl',@ChildTable = 'BASE_CMS_Resource',@ParentColumn = 'ControlResourceID',@ChildColumn = 'ResourceID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_InlineControlSite',@ParentSurrogateKeyName = 'SurrogateKey_CMS_InlineControlSite',@ChildTable = 'BASE_CMS_InlineControl',@ParentColumn = 'ControlID',@ChildColumn = 'ControlID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_InlineControlSite',@ParentSurrogateKeyName = 'SurrogateKey_CMS_InlineControlSite',@ChildTable = 'BASE_CMS_Site',@ParentColumn = 'SiteID',@ChildColumn = 'SiteID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_Membership',@ParentSurrogateKeyName = 'SurrogateKey_CMS_Membership',@ChildTable = 'BASE_CMS_Site',@ParentColumn = 'MembershipSiteID',@ChildColumn = 'SiteID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_MembershipRole',@ParentSurrogateKeyName = 'SurrogateKey_CMS_MembershipRole',@ChildTable = 'BASE_CMS_Membership',@ParentColumn = 'MembershipID',@ChildColumn = 'MembershipID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_MembershipRole',@ParentSurrogateKeyName = 'SurrogateKey_CMS_MembershipRole',@ChildTable = 'BASE_CMS_Role',@ParentColumn = 'RoleID',@ChildColumn = 'RoleID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_MembershipUser',@ParentSurrogateKeyName = 'SurrogateKey_CMS_MembershipUser',@ChildTable = 'BASE_CMS_Membership',@ParentColumn = 'MembershipID',@ChildColumn = 'MembershipID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_MembershipUser',@ParentSurrogateKeyName = 'SurrogateKey_CMS_MembershipUser',@ChildTable = 'BASE_CMS_User',@ParentColumn = 'UserID',@ChildColumn = 'UserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_MetaFile',@ParentSurrogateKeyName = 'SurrogateKey_CMS_MetaFile',@ChildTable = 'BASE_CMS_Site',@ParentColumn = 'MetaFileSiteID',@ChildColumn = 'SiteID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_ObjectRelationship',@ParentSurrogateKeyName = 'SurrogateKey_CMS_ObjectRelationship',@ChildTable = 'BASE_CMS_RelationshipName',@ParentColumn = 'RelationshipNameID',@ChildColumn = 'RelationshipNameID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_ObjectSettings',@ParentSurrogateKeyName = 'SurrogateKey_CMS_ObjectSettings',@ChildTable = 'BASE_CMS_ObjectVersionHistory',@ParentColumn = 'ObjectCheckedOutVersionHistoryID',@ChildColumn = 'VersionID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_ObjectSettings',@ParentSurrogateKeyName = 'SurrogateKey_CMS_ObjectSettings',@ChildTable = 'BASE_CMS_ObjectVersionHistory',@ParentColumn = 'ObjectPublishedVersionHistoryID',@ChildColumn = 'VersionID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_ObjectSettings',@ParentSurrogateKeyName = 'SurrogateKey_CMS_ObjectSettings',@ChildTable = 'BASE_CMS_User',@ParentColumn = 'ObjectCheckedOutByUserID',@ChildColumn = 'UserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_ObjectSettings',@ParentSurrogateKeyName = 'SurrogateKey_CMS_ObjectSettings',@ChildTable = 'BASE_CMS_WorkflowStep',@ParentColumn = 'ObjectWorkflowStepID',@ChildColumn = 'StepID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_ObjectVersionHistory',@ParentSurrogateKeyName = 'SurrogateKey_CMS_ObjectVersionHistory',@ChildTable = 'BASE_CMS_Site',@ParentColumn = 'VersionObjectSiteID',@ChildColumn = 'SiteID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_ObjectVersionHistory',@ParentSurrogateKeyName = 'SurrogateKey_CMS_ObjectVersionHistory',@ChildTable = 'BASE_CMS_User',@ParentColumn = 'VersionDeletedByUserID',@ChildColumn = 'UserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_ObjectVersionHistory',@ParentSurrogateKeyName = 'SurrogateKey_CMS_ObjectVersionHistory',@ChildTable = 'BASE_CMS_User',@ParentColumn = 'VersionModifiedByUserID',@ChildColumn = 'UserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_ObjectWorkflowTrigger',@ParentSurrogateKeyName = 'SurrogateKey_CMS_ObjectWorkflowTrigger',@ChildTable = 'BASE_CMS_Site',@ParentColumn = 'TriggerSiteID',@ChildColumn = 'SiteID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_ObjectWorkflowTrigger',@ParentSurrogateKeyName = 'SurrogateKey_CMS_ObjectWorkflowTrigger',@ChildTable = 'BASE_CMS_Workflow',@ParentColumn = 'TriggerWorkflowID',@ChildColumn = 'WorkflowID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_OpenIDUser',@ParentSurrogateKeyName = 'SurrogateKey_CMS_OpenIDUser',@ChildTable = 'BASE_CMS_User',@ParentColumn = 'UserID',@ChildColumn = 'UserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_PageTemplate',@ParentSurrogateKeyName = 'SurrogateKey_CMS_PageTemplate',@ChildTable = 'BASE_CMS_Layout',@ParentColumn = 'PageTemplateLayoutID',@ChildColumn = 'LayoutID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_PageTemplate',@ParentSurrogateKeyName = 'SurrogateKey_CMS_PageTemplate',@ChildTable = 'BASE_CMS_PageTemplateCategory',@ParentColumn = 'PageTemplateCategoryID',@ChildColumn = 'CategoryID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_PageTemplate',@ParentSurrogateKeyName = 'SurrogateKey_CMS_PageTemplate',@ChildTable = 'BASE_CMS_Site',@ParentColumn = 'PageTemplateSiteID',@ChildColumn = 'SiteID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_PageTemplateScope',@ParentSurrogateKeyName = 'SurrogateKey_CMS_PageTemplateScope',@ChildTable = 'BASE_CMS_Class',@ParentColumn = 'PageTemplateScopeClassID',@ChildColumn = 'ClassID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_PageTemplateScope',@ParentSurrogateKeyName = 'SurrogateKey_CMS_PageTemplateScope',@ChildTable = 'BASE_CMS_Culture',@ParentColumn = 'PageTemplateScopeCultureID',@ChildColumn = 'CultureID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_PageTemplateScope',@ParentSurrogateKeyName = 'SurrogateKey_CMS_PageTemplateScope',@ChildTable = 'BASE_CMS_PageTemplate',@ParentColumn = 'PageTemplateScopeTemplateID',@ChildColumn = 'PageTemplateID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_PageTemplateScope',@ParentSurrogateKeyName = 'SurrogateKey_CMS_PageTemplateScope',@ChildTable = 'BASE_CMS_Site',@ParentColumn = 'PageTemplateScopeSiteID',@ChildColumn = 'SiteID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_PageTemplateSite',@ParentSurrogateKeyName = 'SurrogateKey_CMS_PageTemplateSite',@ChildTable = 'BASE_CMS_PageTemplate',@ParentColumn = 'PageTemplateID',@ChildColumn = 'PageTemplateID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_PageTemplateSite',@ParentSurrogateKeyName = 'SurrogateKey_CMS_PageTemplateSite',@ChildTable = 'BASE_CMS_Site',@ParentColumn = 'SiteID',@ChildColumn = 'SiteID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_Permission',@ParentSurrogateKeyName = 'SurrogateKey_CMS_Permission',@ChildTable = 'BASE_CMS_Class',@ParentColumn = 'ClassID',@ChildColumn = 'ClassID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_Permission',@ParentSurrogateKeyName = 'SurrogateKey_CMS_Permission',@ChildTable = 'BASE_CMS_Resource',@ParentColumn = 'ResourceID',@ChildColumn = 'ResourceID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_Personalization',@ParentSurrogateKeyName = 'SurrogateKey_CMS_Personalization',@ChildTable = 'BASE_CMS_Document',@ParentColumn = 'PersonalizationDocumentID',@ChildColumn = 'DocumentID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_Personalization',@ParentSurrogateKeyName = 'SurrogateKey_CMS_Personalization',@ChildTable = 'BASE_CMS_Site',@ParentColumn = 'PersonalizationSiteID',@ChildColumn = 'SiteID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_Personalization',@ParentSurrogateKeyName = 'SurrogateKey_CMS_Personalization',@ChildTable = 'BASE_CMS_User',@ParentColumn = 'PersonalizationUserID',@ChildColumn = 'UserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_Query',@ParentSurrogateKeyName = 'SurrogateKey_CMS_Query',@ChildTable = 'BASE_CMS_Class',@ParentColumn = 'ClassID',@ChildColumn = 'ClassID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_Relationship',@ParentSurrogateKeyName = 'SurrogateKey_CMS_Relationship',@ChildTable = 'BASE_CMS_RelationshipName',@ParentColumn = 'RelationshipNameID',@ChildColumn = 'RelationshipNameID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_Relationship',@ParentSurrogateKeyName = 'SurrogateKey_CMS_Relationship',@ChildTable = 'BASE_CMS_Tree',@ParentColumn = 'LeftNodeID',@ChildColumn = 'NodeID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_Relationship',@ParentSurrogateKeyName = 'SurrogateKey_CMS_Relationship',@ChildTable = 'BASE_CMS_Tree',@ParentColumn = 'RightNodeID',@ChildColumn = 'NodeID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_RelationshipNameSite',@ParentSurrogateKeyName = 'SurrogateKey_CMS_RelationshipNameSite',@ChildTable = 'BASE_CMS_RelationshipName',@ParentColumn = 'RelationshipNameID',@ChildColumn = 'RelationshipNameID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_RelationshipNameSite',@ParentSurrogateKeyName = 'SurrogateKey_CMS_RelationshipNameSite',@ChildTable = 'BASE_CMS_Site',@ParentColumn = 'SiteID',@ChildColumn = 'SiteID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_ResourceLibrary',@ParentSurrogateKeyName = 'SurrogateKey_CMS_ResourceLibrary',@ChildTable = 'BASE_CMS_Resource',@ParentColumn = 'ResourceLibraryResourceID',@ChildColumn = 'ResourceID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_ResourceSite',@ParentSurrogateKeyName = 'SurrogateKey_CMS_ResourceSite',@ChildTable = 'BASE_CMS_Resource',@ParentColumn = 'ResourceID',@ChildColumn = 'ResourceID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_ResourceSite',@ParentSurrogateKeyName = 'SurrogateKey_CMS_ResourceSite',@ChildTable = 'BASE_CMS_Site',@ParentColumn = 'SiteID',@ChildColumn = 'SiteID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_ResourceTranslation',@ParentSurrogateKeyName = 'SurrogateKey_CMS_ResourceTranslation',@ChildTable = 'BASE_CMS_Culture',@ParentColumn = 'TranslationCultureID',@ChildColumn = 'CultureID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_ResourceTranslation',@ParentSurrogateKeyName = 'SurrogateKey_CMS_ResourceTranslation',@ChildTable = 'BASE_CMS_ResourceString',@ParentColumn = 'TranslationStringID',@ChildColumn = 'StringID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_Role',@ParentSurrogateKeyName = 'SurrogateKey_CMS_Role',@ChildTable = 'BASE_CMS_Site',@ParentColumn = 'SiteID',@ChildColumn = 'SiteID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_Role',@ParentSurrogateKeyName = 'SurrogateKey_CMS_Role',@ChildTable = 'BASE_Community_Group',@ParentColumn = 'RoleGroupID',@ChildColumn = 'GroupID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_RoleApplication',@ParentSurrogateKeyName = 'SurrogateKey_CMS_RoleApplication',@ChildTable = 'BASE_CMS_Role',@ParentColumn = 'RoleID',@ChildColumn = 'RoleID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_RoleApplication',@ParentSurrogateKeyName = 'SurrogateKey_CMS_RoleApplication',@ChildTable = 'BASE_CMS_UIElement',@ParentColumn = 'ElementID',@ChildColumn = 'ElementID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_RolePermission',@ParentSurrogateKeyName = 'SurrogateKey_CMS_RolePermission',@ChildTable = 'BASE_CMS_Permission',@ParentColumn = 'PermissionID',@ChildColumn = 'PermissionID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_RolePermission',@ParentSurrogateKeyName = 'SurrogateKey_CMS_RolePermission',@ChildTable = 'BASE_CMS_Role',@ParentColumn = 'RoleID',@ChildColumn = 'RoleID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_RoleUIElement',@ParentSurrogateKeyName = 'SurrogateKey_CMS_RoleUIElement',@ChildTable = 'BASE_CMS_Role',@ParentColumn = 'RoleID',@ChildColumn = 'RoleID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_RoleUIElement',@ParentSurrogateKeyName = 'SurrogateKey_CMS_RoleUIElement',@ChildTable = 'BASE_CMS_UIElement',@ParentColumn = 'ElementID',@ChildColumn = 'ElementID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_ScheduledTask',@ParentSurrogateKeyName = 'SurrogateKey_CMS_ScheduledTask',@ChildTable = 'BASE_CMS_Resource',@ParentColumn = 'TaskResourceID',@ChildColumn = 'ResourceID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_ScheduledTask',@ParentSurrogateKeyName = 'SurrogateKey_CMS_ScheduledTask',@ChildTable = 'BASE_CMS_Site',@ParentColumn = 'TaskSiteID',@ChildColumn = 'SiteID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_ScheduledTask',@ParentSurrogateKeyName = 'SurrogateKey_CMS_ScheduledTask',@ChildTable = 'BASE_CMS_User',@ParentColumn = 'TaskUserID',@ChildColumn = 'UserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_SearchIndexCulture',@ParentSurrogateKeyName = 'SurrogateKey_CMS_SearchIndexCulture',@ChildTable = 'BASE_CMS_Culture',@ParentColumn = 'IndexCultureID',@ChildColumn = 'CultureID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_SearchIndexCulture',@ParentSurrogateKeyName = 'SurrogateKey_CMS_SearchIndexCulture',@ChildTable = 'BASE_CMS_SearchIndex',@ParentColumn = 'IndexID',@ChildColumn = 'IndexID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_SearchIndexSite',@ParentSurrogateKeyName = 'SurrogateKey_CMS_SearchIndexSite',@ChildTable = 'BASE_CMS_SearchIndex',@ParentColumn = 'IndexID',@ChildColumn = 'IndexID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_SearchIndexSite',@ParentSurrogateKeyName = 'SurrogateKey_CMS_SearchIndexSite',@ChildTable = 'BASE_CMS_Site',@ParentColumn = 'IndexSiteID',@ChildColumn = 'SiteID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_Session',@ParentSurrogateKeyName = 'SurrogateKey_CMS_Session',@ChildTable = 'BASE_CMS_Site',@ParentColumn = 'SessionSiteID',@ChildColumn = 'SiteID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_Session',@ParentSurrogateKeyName = 'SurrogateKey_CMS_Session',@ChildTable = 'BASE_CMS_User',@ParentColumn = 'SessionUserID',@ChildColumn = 'UserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_SettingsCategory',@ParentSurrogateKeyName = 'SurrogateKey_CMS_SettingsCategory',@ChildTable = 'BASE_CMS_Resource',@ParentColumn = 'CategoryResourceID',@ChildColumn = 'ResourceID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_SettingsKey',@ParentSurrogateKeyName = 'SurrogateKey_CMS_SettingsKey',@ChildTable = 'BASE_CMS_SettingsCategory',@ParentColumn = 'KeyCategoryID',@ChildColumn = 'CategoryID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_SettingsKey',@ParentSurrogateKeyName = 'SurrogateKey_CMS_SettingsKey',@ChildTable = 'BASE_CMS_Site',@ParentColumn = 'SiteID',@ChildColumn = 'SiteID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_Site',@ParentSurrogateKeyName = 'SurrogateKey_CMS_Site',@ChildTable = 'BASE_CMS_CssStylesheet',@ParentColumn = 'SiteDefaultEditorStylesheet',@ChildColumn = 'StylesheetID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_Site',@ParentSurrogateKeyName = 'SurrogateKey_CMS_Site',@ChildTable = 'BASE_CMS_CssStylesheet',@ParentColumn = 'SiteDefaultStylesheetID',@ChildColumn = 'StylesheetID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_SiteCulture',@ParentSurrogateKeyName = 'SurrogateKey_CMS_SiteCulture',@ChildTable = 'BASE_CMS_Culture',@ParentColumn = 'CultureID',@ChildColumn = 'CultureID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_SiteCulture',@ParentSurrogateKeyName = 'SurrogateKey_CMS_SiteCulture',@ChildTable = 'BASE_CMS_Site',@ParentColumn = 'SiteID',@ChildColumn = 'SiteID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_SiteDomainAlias',@ParentSurrogateKeyName = 'SurrogateKey_CMS_SiteDomainAlias',@ChildTable = 'BASE_CMS_Site',@ParentColumn = 'SiteID',@ChildColumn = 'SiteID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_SMTPServerSite',@ParentSurrogateKeyName = 'SurrogateKey_CMS_SMTPServerSite',@ChildTable = 'BASE_CMS_Site',@ParentColumn = 'SiteID',@ChildColumn = 'SiteID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_SMTPServerSite',@ParentSurrogateKeyName = 'SurrogateKey_CMS_SMTPServerSite',@ChildTable = 'BASE_CMS_SMTPServer',@ParentColumn = 'ServerID',@ChildColumn = 'ServerID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_State',@ParentSurrogateKeyName = 'SurrogateKey_CMS_State',@ChildTable = 'BASE_CMS_Country',@ParentColumn = 'CountryID',@ChildColumn = 'CountryID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_Tag',@ParentSurrogateKeyName = 'SurrogateKey_CMS_Tag',@ChildTable = 'BASE_CMS_TagGroup',@ParentColumn = 'TagGroupID',@ChildColumn = 'TagGroupID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_TagGroup',@ParentSurrogateKeyName = 'SurrogateKey_CMS_TagGroup',@ChildTable = 'BASE_CMS_Site',@ParentColumn = 'TagGroupSiteID',@ChildColumn = 'SiteID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_TemplateDeviceLayout',@ParentSurrogateKeyName = 'SurrogateKey_CMS_TemplateDeviceLayout',@ChildTable = 'BASE_CMS_DeviceProfile',@ParentColumn = 'ProfileID',@ChildColumn = 'ProfileID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_TemplateDeviceLayout',@ParentSurrogateKeyName = 'SurrogateKey_CMS_TemplateDeviceLayout',@ChildTable = 'BASE_CMS_Layout',@ParentColumn = 'LayoutID',@ChildColumn = 'LayoutID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_TemplateDeviceLayout',@ParentSurrogateKeyName = 'SurrogateKey_CMS_TemplateDeviceLayout',@ChildTable = 'BASE_CMS_PageTemplate',@ParentColumn = 'PageTemplateID',@ChildColumn = 'PageTemplateID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_Transformation',@ParentSurrogateKeyName = 'SurrogateKey_CMS_Transformation',@ChildTable = 'BASE_CMS_Class',@ParentColumn = 'TransformationClassID',@ChildColumn = 'ClassID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_TranslationSubmission',@ParentSurrogateKeyName = 'SurrogateKey_CMS_TranslationSubmission',@ChildTable = 'BASE_CMS_TranslationService',@ParentColumn = 'SubmissionServiceID',@ChildColumn = 'TranslationServiceID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_TranslationSubmission',@ParentSurrogateKeyName = 'SurrogateKey_CMS_TranslationSubmission',@ChildTable = 'BASE_CMS_User',@ParentColumn = 'SubmissionSubmittedByUserID',@ChildColumn = 'UserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_TranslationSubmissionItem',@ParentSurrogateKeyName = 'SurrogateKey_CMS_TranslationSubmissionItem',@ChildTable = 'BASE_CMS_TranslationSubmission',@ParentColumn = 'SubmissionItemSubmissionID',@ChildColumn = 'SubmissionID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_Tree',@ParentSurrogateKeyName = 'SurrogateKey_CMS_Tree',@ChildTable = 'BASE_CMS_ACL',@ParentColumn = 'NodeACLID',@ChildColumn = 'ACLID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_Tree',@ParentSurrogateKeyName = 'SurrogateKey_CMS_Tree',@ChildTable = 'BASE_CMS_Class',@ParentColumn = 'NodeClassID',@ChildColumn = 'ClassID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_Tree',@ParentSurrogateKeyName = 'SurrogateKey_CMS_Tree',@ChildTable = 'BASE_CMS_PageTemplate',@ParentColumn = 'NodeTemplateID',@ChildColumn = 'PageTemplateID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_Tree',@ParentSurrogateKeyName = 'SurrogateKey_CMS_Tree',@ChildTable = 'BASE_CMS_PageTemplate',@ParentColumn = 'NodeWireframeTemplateID',@ChildColumn = 'PageTemplateID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_Tree',@ParentSurrogateKeyName = 'SurrogateKey_CMS_Tree',@ChildTable = 'BASE_CMS_Site',@ParentColumn = 'NodeLinkedNodeSiteID',@ChildColumn = 'SiteID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_Tree',@ParentSurrogateKeyName = 'SurrogateKey_CMS_Tree',@ChildTable = 'BASE_CMS_Site',@ParentColumn = 'NodeSiteID',@ChildColumn = 'SiteID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_Tree',@ParentSurrogateKeyName = 'SurrogateKey_CMS_Tree',@ChildTable = 'BASE_CMS_User',@ParentColumn = 'NodeOwner',@ChildColumn = 'UserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_Tree',@ParentSurrogateKeyName = 'SurrogateKey_CMS_Tree',@ChildTable = 'BASE_COM_SKU',@ParentColumn = 'NodeSKUID',@ChildColumn = 'SKUID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_Tree',@ParentSurrogateKeyName = 'SurrogateKey_CMS_Tree',@ChildTable = 'BASE_Community_Group',@ParentColumn = 'NodeGroupID',@ChildColumn = 'GroupID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_UIElement',@ParentSurrogateKeyName = 'SurrogateKey_CMS_UIElement',@ChildTable = 'BASE_CMS_Resource',@ParentColumn = 'ElementResourceID',@ChildColumn = 'ResourceID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_User',@ParentSurrogateKeyName = 'SurrogateKey_cms_user',@ChildTable = 'BASE_Board_Board',@ParentColumn = 'UserID',@ChildColumn = 'BoardUserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_User',@ParentSurrogateKeyName = 'SurrogateKey_cms_user',@ChildTable = 'BASE_Chat_Message',@ParentColumn = 'UserID',@ChildColumn = 'ChatMessageUserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_User',@ParentSurrogateKeyName = 'SurrogateKey_cms_user',@ChildTable = 'BASE_CMS_Document',@ParentColumn = 'UserID',@ChildColumn = 'DocumentCheckedOutByUserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_User',@ParentSurrogateKeyName = 'SurrogateKey_cms_user',@ChildTable = 'BASE_CMS_EmailUser',@ParentColumn = 'UserID',@ChildColumn = 'UserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_User',@ParentSurrogateKeyName = 'SurrogateKey_cms_user',@ChildTable = 'BASE_CMS_MembershipUser',@ParentColumn = 'UserID',@ChildColumn = 'MembershipUserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_User',@ParentSurrogateKeyName = 'SurrogateKey_cms_user',@ChildTable = 'BASE_CMS_ObjectVersionHistory',@ParentColumn = 'UserID',@ChildColumn = 'VersionDeletedByUserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_User',@ParentSurrogateKeyName = 'SurrogateKey_cms_user',@ChildTable = 'BASE_CMS_OpenIDUser',@ParentColumn = 'UserID',@ChildColumn = 'OpenIDUserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_User',@ParentSurrogateKeyName = 'SurrogateKey_cms_user',@ChildTable = 'BASE_CMS_Personalization',@ParentColumn = 'UserID',@ChildColumn = 'PersonalizationUserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_User',@ParentSurrogateKeyName = 'SurrogateKey_cms_user',@ChildTable = 'BASE_CMS_ScheduledTask',@ParentColumn = 'UserID',@ChildColumn = 'TaskUserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_User',@ParentSurrogateKeyName = 'SurrogateKey_cms_user',@ChildTable = 'BASE_CMS_Session',@ParentColumn = 'UserID',@ChildColumn = 'SessionUserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_User',@ParentSurrogateKeyName = 'SurrogateKey_cms_user',@ChildTable = 'BASE_CMS_UserCulture',@ParentColumn = 'UserID',@ChildColumn = 'UserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_User',@ParentSurrogateKeyName = 'SurrogateKey_cms_user',@ChildTable = 'BASE_CMS_WorkflowHistory',@ParentColumn = 'UserID',@ChildColumn = 'ApprovedByUserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_User',@ParentSurrogateKeyName = 'SurrogateKey_cms_user',@ChildTable = 'BASE_CMS_WorkflowUser',@ParentColumn = 'UserID',@ChildColumn = 'UserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_User',@ParentSurrogateKeyName = 'SurrogateKey_cms_user',@ChildTable = 'BASE_Community_Group',@ParentColumn = 'UserID',@ChildColumn = 'GroupApprovedByUserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_User',@ParentSurrogateKeyName = 'SurrogateKey_cms_user',@ChildTable = 'BASE_HFit_CoachingAuditLog',@ParentColumn = 'UserID',@ChildColumn = 'UserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_User',@ParentSurrogateKeyName = 'SurrogateKey_cms_user',@ChildTable = 'BASE_HFit_CoachingHealthInterest',@ParentColumn = 'UserID',@ChildColumn = 'UserId',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_User',@ParentSurrogateKeyName = 'SurrogateKey_CMS_User',@ChildTable = 'base_Hfit_CoachingUserCMExclusion',@ParentColumn = 'UserID',@ChildColumn = 'UserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_User',@ParentSurrogateKeyName = 'SurrogateKey_cms_user',@ChildTable = 'BASE_HFit_HAAgreement',@ParentColumn = 'UserID',@ChildColumn = 'HAAcceptanceUserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_User',@ParentSurrogateKeyName = 'SurrogateKey_cms_user',@ChildTable = 'BASE_Hfit_HAHealthCheckLog',@ParentColumn = 'UserID',@ChildColumn = 'UserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_User',@ParentSurrogateKeyName = 'SurrogateKey_cms_user',@ChildTable = 'BASE_HFit_HealthAssesmentStarted',@ParentColumn = 'UserID',@ChildColumn = 'UserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_User',@ParentSurrogateKeyName = 'SurrogateKey_cms_user',@ChildTable = 'BASE_HFit_HealthAssesmentUserQuestionImport',@ParentColumn = 'UserID',@ChildColumn = 'UserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_User',@ParentSurrogateKeyName = 'SurrogateKey_cms_user',@ChildTable = 'BASE_HFit_HealthAssesmentUserQuestionStaging',@ParentColumn = 'UserID',@ChildColumn = 'UserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_User',@ParentSurrogateKeyName = 'SurrogateKey_cms_user',@ChildTable = 'BASE_HFit_HealthAssessmentImportStagingMaster',@ParentColumn = 'UserID',@ChildColumn = 'UserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_User',@ParentSurrogateKeyName = 'SurrogateKey_cms_user',@ChildTable = 'BASE_HFit_HealthAssessmentImportStagingMaster_Archive',@ParentColumn = 'UserID',@ChildColumn = 'UserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_User',@ParentSurrogateKeyName = 'SurrogateKey_CMS_User',@ChildTable = 'BASE_HFit_LKP_CoachingCMExclusions',@ParentColumn = 'UserID',@ChildColumn = 'UserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_User',@ParentSurrogateKeyName = 'SurrogateKey_cms_user',@ChildTable = 'BASE_HFit_RewardOverrideLog',@ParentColumn = 'UserID',@ChildColumn = 'ForUserId',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_User',@ParentSurrogateKeyName = 'SurrogateKey_cms_user',@ChildTable = 'BASE_HFit_RewardsUserInterfaceState',@ParentColumn = 'UserID',@ChildColumn = 'UserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_User',@ParentSurrogateKeyName = 'SurrogateKey_cms_user',@ChildTable = 'BASE_HFit_RewardsUserSummaryArchive',@ParentColumn = 'UserID',@ChildColumn = 'UserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_User',@ParentSurrogateKeyName = 'SurrogateKey_cms_user',@ChildTable = 'BASE_HFit_RewardsUserTrigger',@ParentColumn = 'UserID',@ChildColumn = 'UserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_User',@ParentSurrogateKeyName = 'SurrogateKey_cms_user',@ChildTable = 'BASE_HFit_Screening_PPT_Archive',@ParentColumn = 'UserID',@ChildColumn = 'UserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_User',@ParentSurrogateKeyName = 'SurrogateKey_cms_user',@ChildTable = 'BASE_HFit_TrackerSugaryDrinks',@ParentColumn = 'UserID',@ChildColumn = 'UserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_User',@ParentSurrogateKeyName = 'SurrogateKey_cms_user',@ChildTable = 'BASE_HFit_UserCoachingAlert_MeetNotModify',@ParentColumn = 'UserID',@ChildColumn = 'UserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_User',@ParentSurrogateKeyName = 'SurrogateKey_cms_user',@ChildTable = 'BASE_HFit_UserCoachingAlert_NotMet',@ParentColumn = 'UserID',@ChildColumn = 'UserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_cms_user',@ParentSurrogateKeyName = 'SurrogateKey_cms_user',@ChildTable = 'base_HFit_UserGoal',@ParentColumn = 'UserID',@ChildColumn = 'UserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_User',@ParentSurrogateKeyName = 'SurrogateKey_cms_user',@ChildTable = 'BASE_HFit_UserRewardPoints',@ParentColumn = 'UserID',@ChildColumn = 'UserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_User',@ParentSurrogateKeyName = 'SurrogateKey_cms_user',@ChildTable = 'BASE_Messaging_Message',@ParentColumn = 'UserID',@ChildColumn = 'MessageRecipientUserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_User',@ParentSurrogateKeyName = 'SurrogateKey_cms_user',@ChildTable = 'BASE_View_CMS_Tree_Joined_Linked',@ParentColumn = 'UserID',@ChildColumn = 'DocumentCheckedOutByUserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_User',@ParentSurrogateKeyName = 'SurrogateKey_cms_user',@ChildTable = 'BASE_View_CMS_Tree_Joined_Versions',@ParentColumn = 'UserID',@ChildColumn = 'DocumentCheckedOutByUserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_User',@ParentSurrogateKeyName = 'SurrogateKey_cms_user',@ChildTable = 'BASE_View_CMS_Tree_Joined_Versions_Attachments',@ParentColumn = 'UserID',@ChildColumn = 'DocumentCheckedOutByUserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_User',@ParentSurrogateKeyName = 'SurrogateKey_cms_user',@ChildTable = 'BASE_View_CMS_User_With_HFitCoachingSettings',@ParentColumn = 'UserID',@ChildColumn = 'UserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_User',@ParentSurrogateKeyName = 'SurrogateKey_cms_user',@ChildTable = 'BASE_View_CMS_UserRole_MembershipRole_ValidOnly_Joined',@ParentColumn = 'UserID',@ChildColumn = 'UserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_User',@ParentSurrogateKeyName = 'SurrogateKey_cms_user',@ChildTable = 'BASE_View_CONTENT_BookingEvent_Joined',@ParentColumn = 'UserID',@ChildColumn = 'DocumentCheckedOutByUserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_User',@ParentSurrogateKeyName = 'SurrogateKey_cms_user',@ChildTable = 'BASE_View_CONTENT_Cellphone_Joined',@ParentColumn = 'UserID',@ChildColumn = 'DocumentCheckedOutByUserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_User',@ParentSurrogateKeyName = 'SurrogateKey_cms_user',@ChildTable = 'BASE_View_CONTENT_Event_Joined',@ParentColumn = 'UserID',@ChildColumn = 'DocumentCheckedOutByUserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_User',@ParentSurrogateKeyName = 'SurrogateKey_cms_user',@ChildTable = 'BASE_View_CONTENT_FAQ_Joined',@ParentColumn = 'UserID',@ChildColumn = 'DocumentCheckedOutByUserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_User',@ParentSurrogateKeyName = 'SurrogateKey_cms_user',@ChildTable = 'BASE_View_CONTENT_File_Joined',@ParentColumn = 'UserID',@ChildColumn = 'DocumentCheckedOutByUserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_User',@ParentSurrogateKeyName = 'SurrogateKey_cms_user',@ChildTable = 'BASE_View_CONTENT_ImageGallery_Joined',@ParentColumn = 'UserID',@ChildColumn = 'DocumentCheckedOutByUserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_User',@ParentSurrogateKeyName = 'SurrogateKey_cms_user',@ChildTable = 'BASE_View_CONTENT_Job_Joined',@ParentColumn = 'UserID',@ChildColumn = 'DocumentCheckedOutByUserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_User',@ParentSurrogateKeyName = 'SurrogateKey_cms_user',@ChildTable = 'BASE_View_CONTENT_KBArticle_Joined',@ParentColumn = 'UserID',@ChildColumn = 'DocumentCheckedOutByUserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_User',@ParentSurrogateKeyName = 'SurrogateKey_cms_user',@ChildTable = 'BASE_View_CONTENT_Laptop_Joined',@ParentColumn = 'UserID',@ChildColumn = 'DocumentCheckedOutByUserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_User',@ParentSurrogateKeyName = 'SurrogateKey_cms_user',@ChildTable = 'BASE_View_CONTENT_MenuItem_Joined',@ParentColumn = 'UserID',@ChildColumn = 'DocumentCheckedOutByUserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_User',@ParentSurrogateKeyName = 'SurrogateKey_cms_user',@ChildTable = 'BASE_View_CONTENT_News_Joined',@ParentColumn = 'UserID',@ChildColumn = 'DocumentCheckedOutByUserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_User',@ParentSurrogateKeyName = 'SurrogateKey_cms_user',@ChildTable = 'BASE_view_EDW_HAassessment',@ParentColumn = 'UserID',@ChildColumn = 'UserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_User',@ParentSurrogateKeyName = 'SurrogateKey_cms_user',@ChildTable = 'BASE_view_EDW_HealthAssesment',@ParentColumn = 'UserID',@ChildColumn = 'UserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_User',@ParentSurrogateKeyName = 'SurrogateKey_cms_user',@ChildTable = 'BASE_view_EDW_HealthInterestDetail',@ParentColumn = 'UserID',@ChildColumn = 'UserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_User',@ParentSurrogateKeyName = 'SurrogateKey_cms_user',@ChildTable = 'BASE_view_EDW_Participant',@ParentColumn = 'UserID',@ChildColumn = 'UserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_User',@ParentSurrogateKeyName = 'SurrogateKey_cms_user',@ChildTable = 'BASE_View_EDW_RewardProgram_Joined',@ParentColumn = 'UserID',@ChildColumn = 'DocumentCheckedOutByUserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_User',@ParentSurrogateKeyName = 'SurrogateKey_cms_user',@ChildTable = 'BASE_View_hfit_ChallengeAbout_Joined',@ParentColumn = 'UserID',@ChildColumn = 'DocumentCheckedOutByUserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_User',@ParentSurrogateKeyName = 'SurrogateKey_cms_user',@ChildTable = 'BASE_View_hfit_challengeBase_Joined',@ParentColumn = 'UserID',@ChildColumn = 'DocumentCheckedOutByUserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_User',@ParentSurrogateKeyName = 'SurrogateKey_cms_user',@ChildTable = 'BASE_View_hfit_ChallengeFAQ_Joined',@ParentColumn = 'UserID',@ChildColumn = 'DocumentCheckedOutByUserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_User',@ParentSurrogateKeyName = 'SurrogateKey_cms_user',@ChildTable = 'BASE_View_hfit_challengeGeneralSettings_Joined',@ParentColumn = 'UserID',@ChildColumn = 'DocumentCheckedOutByUserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_User',@ParentSurrogateKeyName = 'SurrogateKey_cms_user',@ChildTable = 'BASE_View_HFit_ChallengeNewsletter_Joined',@ParentColumn = 'UserID',@ChildColumn = 'DocumentCheckedOutByUserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_User',@ParentSurrogateKeyName = 'SurrogateKey_cms_user',@ChildTable = 'BASE_View_hfit_challengeOffering_Joined',@ParentColumn = 'UserID',@ChildColumn = 'DocumentCheckedOutByUserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_User',@ParentSurrogateKeyName = 'SurrogateKey_cms_user',@ChildTable = 'BASE_View_HFit_ChallengePostTemplate_Joined',@ParentColumn = 'UserID',@ChildColumn = 'DocumentCheckedOutByUserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_User',@ParentSurrogateKeyName = 'SurrogateKey_cms_user',@ChildTable = 'BASE_View_HFit_ChallengeRegistrationEmail_Joined',@ParentColumn = 'UserID',@ChildColumn = 'DocumentCheckedOutByUserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_User',@ParentSurrogateKeyName = 'SurrogateKey_cms_user',@ChildTable = 'BASE_View_HFit_Class_Joined',@ParentColumn = 'UserID',@ChildColumn = 'DocumentCheckedOutByUserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_User',@ParentSurrogateKeyName = 'SurrogateKey_cms_user',@ChildTable = 'BASE_View_Hfit_Client_Joined',@ParentColumn = 'UserID',@ChildColumn = 'DocumentCheckedOutByUserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_User',@ParentSurrogateKeyName = 'SurrogateKey_cms_user',@ChildTable = 'BASE_View_HFit_Coach_Bio',@ParentColumn = 'UserID',@ChildColumn = 'CoachUserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_User',@ParentSurrogateKeyName = 'SurrogateKey_cms_user',@ChildTable = 'BASE_View_HFit_Coach_Bio_HISTORY',@ParentColumn = 'UserID',@ChildColumn = 'CoachUserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_User',@ParentSurrogateKeyName = 'SurrogateKey_cms_user',@ChildTable = 'BASE_View_HFit_CoachingAuditLog',@ParentColumn = 'UserID',@ChildColumn = 'UserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_User',@ParentSurrogateKeyName = 'SurrogateKey_cms_user',@ChildTable = 'BASE_View_HFit_CoachingEnrollmentSettings_Joined',@ParentColumn = 'UserID',@ChildColumn = 'DocumentCheckedOutByUserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_User',@ParentSurrogateKeyName = 'SurrogateKey_cms_user',@ChildTable = 'BASE_View_HFit_CoachingEvalHAQA_Joined',@ParentColumn = 'UserID',@ChildColumn = 'DocumentCheckedOutByUserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_User',@ParentSurrogateKeyName = 'SurrogateKey_cms_user',@ChildTable = 'BASE_View_HFit_CoachingEvalHAQA_Joined',@ParentColumn = 'UserID',@ChildColumn = 'DocumentCreatedByUserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_User',@ParentSurrogateKeyName = 'SurrogateKey_cms_user',@ChildTable = 'BASE_View_HFit_CoachingEvalHAQA_Joined',@ParentColumn = 'UserID',@ChildColumn = 'DocumentModifiedByUserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_User',@ParentSurrogateKeyName = 'SurrogateKey_cms_user',@ChildTable = 'BASE_View_HFit_CoachingEvalHARiskArea_Joined',@ParentColumn = 'UserID',@ChildColumn = 'DocumentCheckedOutByUserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_User',@ParentSurrogateKeyName = 'SurrogateKey_cms_user',@ChildTable = 'BASE_View_HFit_CoachingEvalHARiskCategory_Joined',@ParentColumn = 'UserID',@ChildColumn = 'DocumentCheckedOutByUserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_User',@ParentSurrogateKeyName = 'SurrogateKey_cms_user',@ChildTable = 'BASE_View_HFit_CoachingEvalHARiskModule_Joined',@ParentColumn = 'UserID',@ChildColumn = 'DocumentCheckedOutByUserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_User',@ParentSurrogateKeyName = 'SurrogateKey_cms_user',@ChildTable = 'BASE_View_HFit_CoachingGetStarted_Joined',@ParentColumn = 'UserID',@ChildColumn = 'DocumentCheckedOutByUserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_User',@ParentSurrogateKeyName = 'SurrogateKey_cms_user',@ChildTable = 'BASE_View_HFit_CoachingGetUserDaysSinceActivity',@ParentColumn = 'UserID',@ChildColumn = 'UserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_User',@ParentSurrogateKeyName = 'SurrogateKey_cms_user',@ChildTable = 'BASE_View_HFit_CoachingHATemporalContainer_Joined',@ParentColumn = 'UserID',@ChildColumn = 'DocumentCheckedOutByUserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_User',@ParentSurrogateKeyName = 'SurrogateKey_cms_user',@ChildTable = 'BASE_View_HFit_CoachingHealthActionPlan_Joined',@ParentColumn = 'UserID',@ChildColumn = 'DocumentCheckedOutByUserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_User',@ParentSurrogateKeyName = 'SurrogateKey_cms_user',@ChildTable = 'BASE_View_HFit_CoachingHealthArea_Joined',@ParentColumn = 'UserID',@ChildColumn = 'DocumentCheckedOutByUserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_User',@ParentSurrogateKeyName = 'SurrogateKey_cms_user',@ChildTable = 'BASE_View_HFit_CoachingNotAssignedSettings_Joined',@ParentColumn = 'UserID',@ChildColumn = 'DocumentCheckedOutByUserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_User',@ParentSurrogateKeyName = 'SurrogateKey_cms_user',@ChildTable = 'BASE_View_HFit_CoachingNotAssignedSettings_Joined',@ParentColumn = 'UserID',@ChildColumn = 'DocumentCreatedByUserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_User',@ParentSurrogateKeyName = 'SurrogateKey_cms_user',@ChildTable = 'BASE_View_HFit_CoachingNotAssignedSettings_Joined',@ParentColumn = 'UserID',@ChildColumn = 'DocumentModifiedByUserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_User',@ParentSurrogateKeyName = 'SurrogateKey_cms_user',@ChildTable = 'BASE_View_HFit_CoachingPrivacyPolicy_Joined',@ParentColumn = 'UserID',@ChildColumn = 'DocumentCheckedOutByUserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_User',@ParentSurrogateKeyName = 'SurrogateKey_cms_user',@ChildTable = 'BASE_View_HFit_CoachingReadyForNotification',@ParentColumn = 'UserID',@ChildColumn = 'UserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_User',@ParentSurrogateKeyName = 'SurrogateKey_cms_user',@ChildTable = 'BASE_View_Hfit_CoachingSystemSettings_Joined',@ParentColumn = 'UserID',@ChildColumn = 'DocumentCheckedOutByUserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_User',@ParentSurrogateKeyName = 'SurrogateKey_cms_user',@ChildTable = 'BASE_View_HFit_CoachingTermsAndConditionsSettings_Joined',@ParentColumn = 'UserID',@ChildColumn = 'DocumentCheckedOutByUserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_User',@ParentSurrogateKeyName = 'SurrogateKey_cms_user',@ChildTable = 'BASE_View_HFit_CoachingWelcomeSettings_Joined',@ParentColumn = 'UserID',@ChildColumn = 'DocumentCheckedOutByUserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_User',@ParentSurrogateKeyName = 'SurrogateKey_cms_user',@ChildTable = 'BASE_View_HFit_Configuration_CallLogCoaching_Joined',@ParentColumn = 'UserID',@ChildColumn = 'DocumentCheckedOutByUserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_User',@ParentSurrogateKeyName = 'SurrogateKey_cms_user',@ChildTable = 'BASE_View_HFIT_Configuration_CMCoaching_Joined',@ParentColumn = 'UserID',@ChildColumn = 'DocumentCheckedOutByUserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_User',@ParentSurrogateKeyName = 'SurrogateKey_cms_user',@ChildTable = 'BASE_View_HFit_Event_Joined',@ParentColumn = 'UserID',@ChildColumn = 'DocumentCheckedOutByUserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_User',@ParentSurrogateKeyName = 'SurrogateKey_cms_user',@ChildTable = 'BASE_View_HFit_Event_Joined',@ParentColumn = 'UserID',@ChildColumn = 'DocumentCreatedByUserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_User',@ParentSurrogateKeyName = 'SurrogateKey_cms_user',@ChildTable = 'BASE_View_HFit_Event_Joined',@ParentColumn = 'UserID',@ChildColumn = 'DocumentModifiedByUserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_User',@ParentSurrogateKeyName = 'SurrogateKey_cms_user',@ChildTable = 'BASE_View_HFit_Goal_Joined',@ParentColumn = 'UserID',@ChildColumn = 'DocumentCheckedOutByUserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_User',@ParentSurrogateKeyName = 'SurrogateKey_cms_user',@ChildTable = 'BASE_View_HFit_GoalCategory_Joined',@ParentColumn = 'UserID',@ChildColumn = 'DocumentCheckedOutByUserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_User',@ParentSurrogateKeyName = 'SurrogateKey_cms_user',@ChildTable = 'BASE_View_HFit_GoalSubCategory_Joined',@ParentColumn = 'UserID',@ChildColumn = 'DocumentCheckedOutByUserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_User',@ParentSurrogateKeyName = 'SurrogateKey_cms_user',@ChildTable = 'BASE_View_HFit_HA_UseAndDisclosure_Joined',@ParentColumn = 'UserID',@ChildColumn = 'DocumentCheckedOutByUserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_User',@ParentSurrogateKeyName = 'SurrogateKey_cms_user',@ChildTable = 'BASE_View_HFit_HACampaign_Joined',@ParentColumn = 'UserID',@ChildColumn = 'DocumentCheckedOutByUserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_User',@ParentSurrogateKeyName = 'SurrogateKey_cms_user',@ChildTable = 'BASE_View_Hfit_HACampaigns_Joined',@ParentColumn = 'UserID',@ChildColumn = 'DocumentCheckedOutByUserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_User',@ParentSurrogateKeyName = 'SurrogateKey_cms_user',@ChildTable = 'BASE_View_HFit_HealthAssessmentFreeForm_Joined',@ParentColumn = 'UserID',@ChildColumn = 'DocumentCheckedOutByUserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_User',@ParentSurrogateKeyName = 'SurrogateKey_cms_user',@ChildTable = 'BASE_View_HFit_HealthAssessmentModuleConfiguration_Joined',@ParentColumn = 'UserID',@ChildColumn = 'DocumentCheckedOutByUserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_User',@ParentSurrogateKeyName = 'SurrogateKey_cms_user',@ChildTable = 'BASE_View_HFit_HealthSummarySettings_Joined',@ParentColumn = 'UserID',@ChildColumn = 'DocumentCheckedOutByUserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_User',@ParentSurrogateKeyName = 'SurrogateKey_cms_user',@ChildTable = 'BASE_View_HFit_HRA_Joined',@ParentColumn = 'UserID',@ChildColumn = 'DocumentCheckedOutByUserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_User',@ParentSurrogateKeyName = 'SurrogateKey_cms_user',@ChildTable = 'BASE_View_HFit_HSAbout_Joined',@ParentColumn = 'UserID',@ChildColumn = 'DocumentCheckedOutByUserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_User',@ParentSurrogateKeyName = 'SurrogateKey_cms_user',@ChildTable = 'BASE_View_HFit_HSBiometricChart_Joined',@ParentColumn = 'UserID',@ChildColumn = 'DocumentCheckedOutByUserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_User',@ParentSurrogateKeyName = 'SurrogateKey_cms_user',@ChildTable = 'BASE_View_HFit_HSGraphRangeSetting_Joined',@ParentColumn = 'UserID',@ChildColumn = 'DocumentCheckedOutByUserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_User',@ParentSurrogateKeyName = 'SurrogateKey_cms_user',@ChildTable = 'BASE_View_hfit_Post_Joined',@ParentColumn = 'UserID',@ChildColumn = 'DocumentCheckedOutByUserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_User',@ParentSurrogateKeyName = 'SurrogateKey_cms_user',@ChildTable = 'BASE_View_hfit_Post_Joined',@ParentColumn = 'UserID',@ChildColumn = 'DocumentCreatedByUserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_User',@ParentSurrogateKeyName = 'SurrogateKey_cms_user',@ChildTable = 'BASE_View_hfit_Post_Joined',@ParentColumn = 'UserID',@ChildColumn = 'DocumentModifiedByUserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_User',@ParentSurrogateKeyName = 'SurrogateKey_cms_user',@ChildTable = 'BASE_View_HFit_PostChallenge_Joined',@ParentColumn = 'UserID',@ChildColumn = 'DocumentCheckedOutByUserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_User',@ParentSurrogateKeyName = 'SurrogateKey_cms_user',@ChildTable = 'BASE_View_HFit_PostEmptyFeed_Joined',@ParentColumn = 'UserID',@ChildColumn = 'DocumentCheckedOutByUserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_User',@ParentSurrogateKeyName = 'SurrogateKey_cms_user',@ChildTable = 'BASE_View_HFit_PostHealthEducation_Joined',@ParentColumn = 'UserID',@ChildColumn = 'DocumentCheckedOutByUserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_User',@ParentSurrogateKeyName = 'SurrogateKey_cms_user',@ChildTable = 'BASE_View_HFit_PostMessage_Joined',@ParentColumn = 'UserID',@ChildColumn = 'DocumentCheckedOutByUserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_User',@ParentSurrogateKeyName = 'SurrogateKey_cms_user',@ChildTable = 'BASE_View_HFit_PostQuote_Joined',@ParentColumn = 'UserID',@ChildColumn = 'DocumentCheckedOutByUserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_User',@ParentSurrogateKeyName = 'SurrogateKey_cms_user',@ChildTable = 'BASE_View_HFit_PostReminder_Joined',@ParentColumn = 'UserID',@ChildColumn = 'DocumentCheckedOutByUserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_User',@ParentSurrogateKeyName = 'SurrogateKey_cms_user',@ChildTable = 'BASE_View_HFit_RewardProgram_Joined',@ParentColumn = 'UserID',@ChildColumn = 'DocumentCheckedOutByUserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_User',@ParentSurrogateKeyName = 'SurrogateKey_cms_user',@ChildTable = 'BASE_View_HFit_RewardsAboutInfoItem_Joined',@ParentColumn = 'UserID',@ChildColumn = 'DocumentCheckedOutByUserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_User',@ParentSurrogateKeyName = 'SurrogateKey_cms_user',@ChildTable = 'BASE_View_HFit_RewardTrigger_Joined',@ParentColumn = 'UserID',@ChildColumn = 'DocumentCheckedOutByUserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_User',@ParentSurrogateKeyName = 'SurrogateKey_cms_user',@ChildTable = 'BASE_View_HFit_RewardTriggerParameter_Joined',@ParentColumn = 'UserID',@ChildColumn = 'DocumentCheckedOutByUserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_User',@ParentSurrogateKeyName = 'SurrogateKey_cms_user',@ChildTable = 'BASE_View_HFit_RewardTriggerTobaccoParameter_Joined',@ParentColumn = 'UserID',@ChildColumn = 'DocumentCheckedOutByUserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_User',@ParentSurrogateKeyName = 'SurrogateKey_cms_user',@ChildTable = 'BASE_View_HFit_RightsResponsibilities_Joined',@ParentColumn = 'UserID',@ChildColumn = 'DocumentCheckedOutByUserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_User',@ParentSurrogateKeyName = 'SurrogateKey_cms_user',@ChildTable = 'BASE_View_HFit_ScheduledNotification_Joined',@ParentColumn = 'UserID',@ChildColumn = 'DocumentCheckedOutByUserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_User',@ParentSurrogateKeyName = 'SurrogateKey_cms_user',@ChildTable = 'BASE_View_HFIT_SsoConfiguration_Joined',@ParentColumn = 'UserID',@ChildColumn = 'DocumentCheckedOutByUserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_User',@ParentSurrogateKeyName = 'SurrogateKey_cms_user',@ChildTable = 'BASE_View_HFit_SsoRequest_Joined',@ParentColumn = 'UserID',@ChildColumn = 'DocumentCheckedOutByUserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_User',@ParentSurrogateKeyName = 'SurrogateKey_cms_user',@ChildTable = 'BASE_View_HFit_SsoRequestAttributes_Joined',@ParentColumn = 'UserID',@ChildColumn = 'DocumentCheckedOutByUserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_User',@ParentSurrogateKeyName = 'SurrogateKey_cms_user',@ChildTable = 'BASE_View_hfit_TemporalConfigurationContainer_Joined',@ParentColumn = 'UserID',@ChildColumn = 'DocumentCheckedOutByUserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_User',@ParentSurrogateKeyName = 'SurrogateKey_cms_user',@ChildTable = 'BASE_View_HFit_TermsConditions_Joined',@ParentColumn = 'UserID',@ChildColumn = 'DocumentCheckedOutByUserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_User',@ParentSurrogateKeyName = 'SurrogateKey_cms_user',@ChildTable = 'BASE_View_Hfit_TimezoneConfiguration_Joined',@ParentColumn = 'UserID',@ChildColumn = 'DocumentCheckedOutByUserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_User',@ParentSurrogateKeyName = 'SurrogateKey_cms_user',@ChildTable = 'BASE_View_HFit_TipOfTheDay_Joined',@ParentColumn = 'UserID',@ChildColumn = 'DocumentCheckedOutByUserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_User',@ParentSurrogateKeyName = 'SurrogateKey_cms_user',@ChildTable = 'BASE_View_Membership_MembershipUser_Joined',@ParentColumn = 'UserID',@ChildColumn = 'UserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_User',@ParentSurrogateKeyName = 'SurrogateKey_cms_user',@ChildTable = 'BASE_View_NewsletterSubscriberUserRole_Joined',@ParentColumn = 'UserID',@ChildColumn = 'UserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_User',@ParentSurrogateKeyName = 'SurrogateKey_cms_user',@ChildTable = 'BASE_View_OM_Account_Joined',@ParentColumn = 'UserID',@ChildColumn = 'AccountOwnerUserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_User',@ParentSurrogateKeyName = 'SurrogateKey_cms_user',@ChildTable = 'BASE_View_OM_Account_MembershipJoined',@ParentColumn = 'UserID',@ChildColumn = 'AccountOwnerUserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_User',@ParentSurrogateKeyName = 'SurrogateKey_cms_user',@ChildTable = 'BASE_View_ToDoHealthAssesment',@ParentColumn = 'UserID',@ChildColumn = 'UserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_User',@ParentSurrogateKeyName = 'SurrogateKey_cms_user',@ChildTable = 'STAGED_EDW_CMS_USERSETTINGS',@ParentColumn = 'UserID',@ChildColumn = 'USERSETTINGSUSERID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_UserCulture',@ParentSurrogateKeyName = 'SurrogateKey_CMS_UserCulture',@ChildTable = 'BASE_CMS_Culture',@ParentColumn = 'CultureID',@ChildColumn = 'CultureID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_UserCulture',@ParentSurrogateKeyName = 'SurrogateKey_CMS_UserCulture',@ChildTable = 'BASE_CMS_Site',@ParentColumn = 'SiteID',@ChildColumn = 'SiteID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_UserCulture',@ParentSurrogateKeyName = 'SurrogateKey_CMS_UserCulture',@ChildTable = 'BASE_CMS_User',@ParentColumn = 'UserID',@ChildColumn = 'UserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_UserRole',@ParentSurrogateKeyName = 'SurrogateKey_CMS_UserRole',@ChildTable = 'BASE_CMS_Role',@ParentColumn = 'RoleID',@ChildColumn = 'RoleID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_UserRole',@ParentSurrogateKeyName = 'SurrogateKey_CMS_UserRole',@ChildTable = 'BASE_CMS_User',@ParentColumn = 'UserID',@ChildColumn = 'UserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_UserSettings',@ParentSurrogateKeyName = 'SurrogateKey_CMS_UserSettings',@ChildTable = 'BASE_CMS_Avatar',@ParentColumn = 'UserAvatarID',@ChildColumn = 'AvatarID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_UserSettings',@ParentSurrogateKeyName = 'SurrogateKey_CMS_UserSettings',@ChildTable = 'BASE_CMS_Badge',@ParentColumn = 'UserBadgeID',@ChildColumn = 'BadgeID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_UserSettings',@ParentSurrogateKeyName = 'SurrogateKey_CMS_UserSettings',@ChildTable = 'BASE_CMS_TimeZone',@ParentColumn = 'UserTimeZoneID',@ChildColumn = 'TimeZoneID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_UserSettings',@ParentSurrogateKeyName = 'SurrogateKey_CMS_UserSettings',@ChildTable = 'BASE_CMS_User',@ParentColumn = 'UserActivatedByUserID',@ChildColumn = 'UserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_UserSettings',@ParentSurrogateKeyName = 'SurrogateKey_CMS_UserSettings',@ChildTable = 'BASE_CMS_User',@ParentColumn = 'UserSettingsUserGUID',@ChildColumn = 'UserGUID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_UserSettings',@ParentSurrogateKeyName = 'SurrogateKey_CMS_UserSettings',@ChildTable = 'BASE_CMS_User',@ParentColumn = 'UserSettingsUserID',@ChildColumn = 'UserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_UserSite',@ParentSurrogateKeyName = 'SurrogateKey_CMS_UserSite',@ChildTable = 'BASE_CMS_Site',@ParentColumn = 'SiteID',@ChildColumn = 'SiteID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_UserSite',@ParentSurrogateKeyName = 'SurrogateKey_CMS_UserSite',@ChildTable = 'BASE_CMS_User',@ParentColumn = 'UserID',@ChildColumn = 'UserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_UserSite',@ParentSurrogateKeyName = 'SurrogateKey_CMS_UserSite',@ChildTable = 'BASE_COM_Currency',@ParentColumn = 'UserPreferredCurrencyID',@ChildColumn = 'CurrencyID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_UserSite',@ParentSurrogateKeyName = 'SurrogateKey_CMS_UserSite',@ChildTable = 'BASE_COM_PaymentOption',@ParentColumn = 'UserPreferredPaymentOptionID',@ChildColumn = 'PaymentOptionID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_UserSite',@ParentSurrogateKeyName = 'SurrogateKey_CMS_UserSite',@ChildTable = 'BASE_COM_ShippingOption',@ParentColumn = 'UserPreferredShippingOptionID',@ChildColumn = 'ShippingOptionID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_VersionAttachment',@ParentSurrogateKeyName = 'SurrogateKey_CMS_VersionAttachment',@ChildTable = 'BASE_CMS_AttachmentHistory',@ParentColumn = 'AttachmentHistoryID',@ChildColumn = 'AttachmentHistoryID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_VersionAttachment',@ParentSurrogateKeyName = 'SurrogateKey_CMS_VersionAttachment',@ChildTable = 'BASE_CMS_VersionHistory',@ParentColumn = 'VersionHistoryID',@ChildColumn = 'VersionHistoryID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_VersionHistory',@ParentSurrogateKeyName = 'SurrogateKey_CMS_VersionHistory',@ChildTable = 'BASE_CMS_Class',@ParentColumn = 'VersionClassID',@ChildColumn = 'ClassID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_VersionHistory',@ParentSurrogateKeyName = 'SurrogateKey_CMS_VersionHistory',@ChildTable = 'BASE_CMS_Site',@ParentColumn = 'NodeSiteID',@ChildColumn = 'SiteID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_VersionHistory',@ParentSurrogateKeyName = 'SurrogateKey_CMS_VersionHistory',@ChildTable = 'BASE_CMS_User',@ParentColumn = 'ModifiedByUserID',@ChildColumn = 'UserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_VersionHistory',@ParentSurrogateKeyName = 'SurrogateKey_CMS_VersionHistory',@ChildTable = 'BASE_CMS_User',@ParentColumn = 'VersionDeletedByUserID',@ChildColumn = 'UserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_VersionHistory',@ParentSurrogateKeyName = 'SurrogateKey_CMS_VersionHistory',@ChildTable = 'BASE_CMS_Workflow',@ParentColumn = 'VersionWorkflowID',@ChildColumn = 'WorkflowID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_VersionHistory',@ParentSurrogateKeyName = 'SurrogateKey_CMS_VersionHistory',@ChildTable = 'BASE_CMS_WorkflowStep',@ParentColumn = 'VersionWorkflowStepID',@ChildColumn = 'StepID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_WebFarmServerTask',@ParentSurrogateKeyName = 'SurrogateKey_CMS_WebFarmServerTask',@ChildTable = 'BASE_CMS_WebFarmServer',@ParentColumn = 'ServerID',@ChildColumn = 'ServerID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_WebFarmServerTask',@ParentSurrogateKeyName = 'SurrogateKey_CMS_WebFarmServerTask',@ChildTable = 'BASE_CMS_WebFarmTask',@ParentColumn = 'TaskID',@ChildColumn = 'TaskID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_WebPart',@ParentSurrogateKeyName = 'SurrogateKey_CMS_WebPart',@ChildTable = 'BASE_CMS_Resource',@ParentColumn = 'WebPartResourceID',@ChildColumn = 'ResourceID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_WebPart',@ParentSurrogateKeyName = 'SurrogateKey_CMS_WebPart',@ChildTable = 'BASE_CMS_WebPartCategory',@ParentColumn = 'WebPartCategoryID',@ChildColumn = 'CategoryID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_WebPartContainerSite',@ParentSurrogateKeyName = 'SurrogateKey_CMS_WebPartContainerSite',@ChildTable = 'BASE_CMS_Site',@ParentColumn = 'SiteID',@ChildColumn = 'SiteID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_WebPartContainerSite',@ParentSurrogateKeyName = 'SurrogateKey_CMS_WebPartContainerSite',@ChildTable = 'BASE_CMS_WebPartContainer',@ParentColumn = 'ContainerID',@ChildColumn = 'ContainerID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_WebPartLayout',@ParentSurrogateKeyName = 'SurrogateKey_CMS_WebPartLayout',@ChildTable = 'BASE_CMS_WebPart',@ParentColumn = 'WebPartLayoutWebPartID',@ChildColumn = 'WebPartID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_Widget',@ParentSurrogateKeyName = 'SurrogateKey_CMS_Widget',@ChildTable = 'BASE_CMS_WebPart',@ParentColumn = 'WidgetWebPartID',@ChildColumn = 'WebPartID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_Widget',@ParentSurrogateKeyName = 'SurrogateKey_CMS_Widget',@ChildTable = 'BASE_CMS_WebPartLayout',@ParentColumn = 'WidgetLayoutID',@ChildColumn = 'WebPartLayoutID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_Widget',@ParentSurrogateKeyName = 'SurrogateKey_CMS_Widget',@ChildTable = 'BASE_CMS_WidgetCategory',@ParentColumn = 'WidgetCategoryID',@ChildColumn = 'WidgetCategoryID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_WidgetRole',@ParentSurrogateKeyName = 'SurrogateKey_CMS_WidgetRole',@ChildTable = 'BASE_CMS_Permission',@ParentColumn = 'PermissionID',@ChildColumn = 'PermissionID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_WidgetRole',@ParentSurrogateKeyName = 'SurrogateKey_CMS_WidgetRole',@ChildTable = 'BASE_CMS_Role',@ParentColumn = 'RoleID',@ChildColumn = 'RoleID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_WidgetRole',@ParentSurrogateKeyName = 'SurrogateKey_CMS_WidgetRole',@ChildTable = 'BASE_CMS_Widget',@ParentColumn = 'WidgetID',@ChildColumn = 'WidgetID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_WorkflowAction',@ParentSurrogateKeyName = 'SurrogateKey_CMS_WorkflowAction',@ChildTable = 'BASE_CMS_Resource',@ParentColumn = 'ActionResourceID',@ChildColumn = 'ResourceID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_WorkflowHistory',@ParentSurrogateKeyName = 'SurrogateKey_CMS_WorkflowHistory',@ChildTable = 'BASE_CMS_User',@ParentColumn = 'ApprovedByUserID',@ChildColumn = 'UserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_WorkflowHistory',@ParentSurrogateKeyName = 'SurrogateKey_CMS_WorkflowHistory',@ChildTable = 'BASE_CMS_VersionHistory',@ParentColumn = 'VersionHistoryID',@ChildColumn = 'VersionHistoryID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_WorkflowHistory',@ParentSurrogateKeyName = 'SurrogateKey_CMS_WorkflowHistory',@ChildTable = 'BASE_CMS_Workflow',@ParentColumn = 'HistoryWorkflowID',@ChildColumn = 'WorkflowID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_WorkflowHistory',@ParentSurrogateKeyName = 'SurrogateKey_CMS_WorkflowHistory',@ChildTable = 'BASE_CMS_WorkflowStep',@ParentColumn = 'StepID',@ChildColumn = 'StepID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_WorkflowHistory',@ParentSurrogateKeyName = 'SurrogateKey_CMS_WorkflowHistory',@ChildTable = 'BASE_CMS_WorkflowStep',@ParentColumn = 'TargetStepID',@ChildColumn = 'StepID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_WorkflowScope',@ParentSurrogateKeyName = 'SurrogateKey_CMS_WorkflowScope',@ChildTable = 'BASE_CMS_Class',@ParentColumn = 'ScopeClassID',@ChildColumn = 'ClassID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_WorkflowScope',@ParentSurrogateKeyName = 'SurrogateKey_CMS_WorkflowScope',@ChildTable = 'BASE_CMS_Culture',@ParentColumn = 'ScopeCultureID',@ChildColumn = 'CultureID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_WorkflowScope',@ParentSurrogateKeyName = 'SurrogateKey_CMS_WorkflowScope',@ChildTable = 'BASE_CMS_Site',@ParentColumn = 'ScopeSiteID',@ChildColumn = 'SiteID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_WorkflowScope',@ParentSurrogateKeyName = 'SurrogateKey_CMS_WorkflowScope',@ChildTable = 'BASE_CMS_Workflow',@ParentColumn = 'ScopeWorkflowID',@ChildColumn = 'WorkflowID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_WorkflowStep',@ParentSurrogateKeyName = 'SurrogateKey_CMS_WorkflowStep',@ChildTable = 'BASE_CMS_Workflow',@ParentColumn = 'StepWorkflowID',@ChildColumn = 'WorkflowID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_WorkflowStep',@ParentSurrogateKeyName = 'SurrogateKey_CMS_WorkflowStep',@ChildTable = 'BASE_CMS_WorkflowAction',@ParentColumn = 'StepActionID',@ChildColumn = 'ActionID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_WorkflowStepRoles',@ParentSurrogateKeyName = 'SurrogateKey_CMS_WorkflowStepRoles',@ChildTable = 'BASE_CMS_Role',@ParentColumn = 'RoleID',@ChildColumn = 'RoleID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_WorkflowStepRoles',@ParentSurrogateKeyName = 'SurrogateKey_CMS_WorkflowStepRoles',@ChildTable = 'BASE_CMS_WorkflowStep',@ParentColumn = 'StepID',@ChildColumn = 'StepID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_WorkflowStepUser',@ParentSurrogateKeyName = 'SurrogateKey_CMS_WorkflowStepUser',@ChildTable = 'BASE_CMS_User',@ParentColumn = 'UserID',@ChildColumn = 'UserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_WorkflowStepUser',@ParentSurrogateKeyName = 'SurrogateKey_CMS_WorkflowStepUser',@ChildTable = 'BASE_CMS_WorkflowStep',@ParentColumn = 'StepID',@ChildColumn = 'StepID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_WorkflowTransition',@ParentSurrogateKeyName = 'SurrogateKey_CMS_WorkflowTransition',@ChildTable = 'BASE_CMS_Workflow',@ParentColumn = 'TransitionWorkflowID',@ChildColumn = 'WorkflowID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_WorkflowTransition',@ParentSurrogateKeyName = 'SurrogateKey_CMS_WorkflowTransition',@ChildTable = 'BASE_CMS_WorkflowStep',@ParentColumn = 'TransitionEndStepID',@ChildColumn = 'StepID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_WorkflowTransition',@ParentSurrogateKeyName = 'SurrogateKey_CMS_WorkflowTransition',@ChildTable = 'BASE_CMS_WorkflowStep',@ParentColumn = 'TransitionStartStepID',@ChildColumn = 'StepID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_WorkflowUser',@ParentSurrogateKeyName = 'SurrogateKey_CMS_WorkflowUser',@ChildTable = 'BASE_CMS_User',@ParentColumn = 'UserID',@ChildColumn = 'UserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_CMS_WorkflowUser',@ParentSurrogateKeyName = 'SurrogateKey_CMS_WorkflowUser',@ChildTable = 'BASE_CMS_Workflow',@ParentColumn = 'WorkflowID',@ChildColumn = 'WorkflowID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_COM_Carrier',@ParentSurrogateKeyName = 'SurrogateKey_COM_Carrier',@ChildTable = 'BASE_CMS_Site',@ParentColumn = 'CarrierSiteID',@ChildColumn = 'SiteID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_COM_Currency',@ParentSurrogateKeyName = 'SurrogateKey_COM_Currency',@ChildTable = 'BASE_CMS_Site',@ParentColumn = 'CurrencySiteID',@ChildColumn = 'SiteID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_COM_Department',@ParentSurrogateKeyName = 'SurrogateKey_COM_Department',@ChildTable = 'BASE_CMS_Site',@ParentColumn = 'DepartmentSiteID',@ChildColumn = 'SiteID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_COM_Department',@ParentSurrogateKeyName = 'SurrogateKey_COM_Department',@ChildTable = 'BASE_COM_TaxClass',@ParentColumn = 'DepartmentDefaultTaxClassID',@ChildColumn = 'TaxClassID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_COM_InternalStatus',@ParentSurrogateKeyName = 'SurrogateKey_COM_InternalStatus',@ChildTable = 'BASE_CMS_Site',@ParentColumn = 'InternalStatusSiteID',@ChildColumn = 'SiteID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_COM_Manufacturer',@ParentSurrogateKeyName = 'SurrogateKey_COM_Manufacturer',@ChildTable = 'BASE_CMS_Site',@ParentColumn = 'ManufacturerSiteID',@ChildColumn = 'SiteID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_COM_OptionCategory',@ParentSurrogateKeyName = 'SurrogateKey_COM_OptionCategory',@ChildTable = 'BASE_CMS_Site',@ParentColumn = 'CategorySiteID',@ChildColumn = 'SiteID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_COM_OrderStatus',@ParentSurrogateKeyName = 'SurrogateKey_COM_OrderStatus',@ChildTable = 'BASE_CMS_Site',@ParentColumn = 'StatusSiteID',@ChildColumn = 'SiteID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_COM_PaymentOption',@ParentSurrogateKeyName = 'SurrogateKey_COM_PaymentOption',@ChildTable = 'BASE_CMS_Site',@ParentColumn = 'PaymentOptionSiteID',@ChildColumn = 'SiteID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_COM_PaymentOption',@ParentSurrogateKeyName = 'SurrogateKey_COM_PaymentOption',@ChildTable = 'BASE_COM_OrderStatus',@ParentColumn = 'PaymentOptionFailedOrderStatusID',@ChildColumn = 'StatusID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_COM_PaymentOption',@ParentSurrogateKeyName = 'SurrogateKey_COM_PaymentOption',@ChildTable = 'BASE_COM_OrderStatus',@ParentColumn = 'PaymentOptionSucceededOrderStatusID',@ChildColumn = 'StatusID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_COM_PublicStatus',@ParentSurrogateKeyName = 'SurrogateKey_COM_PublicStatus',@ChildTable = 'BASE_CMS_Site',@ParentColumn = 'PublicStatusSiteID',@ChildColumn = 'SiteID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_COM_ShippingOption',@ParentSurrogateKeyName = 'SurrogateKey_COM_ShippingOption',@ChildTable = 'BASE_CMS_Site',@ParentColumn = 'ShippingOptionSiteID',@ChildColumn = 'SiteID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_COM_ShippingOption',@ParentSurrogateKeyName = 'SurrogateKey_COM_ShippingOption',@ChildTable = 'BASE_COM_Carrier',@ParentColumn = 'ShippingOptionCarrierID',@ChildColumn = 'CarrierID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_COM_SKU',@ParentSurrogateKeyName = 'SurrogateKey_COM_SKU',@ChildTable = 'BASE_CMS_Site',@ParentColumn = 'SKUSiteID',@ChildColumn = 'SiteID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_COM_SKU',@ParentSurrogateKeyName = 'SurrogateKey_COM_SKU',@ChildTable = 'BASE_COM_Department',@ParentColumn = 'SKUDepartmentID',@ChildColumn = 'DepartmentID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_COM_SKU',@ParentSurrogateKeyName = 'SurrogateKey_COM_SKU',@ChildTable = 'BASE_COM_InternalStatus',@ParentColumn = 'SKUInternalStatusID',@ChildColumn = 'InternalStatusID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_COM_SKU',@ParentSurrogateKeyName = 'SurrogateKey_COM_SKU',@ChildTable = 'BASE_COM_Manufacturer',@ParentColumn = 'SKUManufacturerID',@ChildColumn = 'ManufacturerID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_COM_SKU',@ParentSurrogateKeyName = 'SurrogateKey_COM_SKU',@ChildTable = 'BASE_COM_OptionCategory',@ParentColumn = 'SKUOptionCategoryID',@ChildColumn = 'CategoryID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_COM_SKU',@ParentSurrogateKeyName = 'SurrogateKey_COM_SKU',@ChildTable = 'BASE_COM_PublicStatus',@ParentColumn = 'SKUPublicStatusID',@ChildColumn = 'PublicStatusID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_COM_SKU',@ParentSurrogateKeyName = 'SurrogateKey_COM_SKU',@ChildTable = 'BASE_COM_Supplier',@ParentColumn = 'SKUSupplierID',@ChildColumn = 'SupplierID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_COM_Supplier',@ParentSurrogateKeyName = 'SurrogateKey_COM_Supplier',@ChildTable = 'BASE_CMS_Site',@ParentColumn = 'SupplierSiteID',@ChildColumn = 'SiteID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_COM_TaxClass',@ParentSurrogateKeyName = 'SurrogateKey_COM_TaxClass',@ChildTable = 'BASE_CMS_Site',@ParentColumn = 'TaxClassSiteID',@ChildColumn = 'SiteID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_Community_Group',@ParentSurrogateKeyName = 'SurrogateKey_Community_Group',@ChildTable = 'BASE_CMS_Avatar',@ParentColumn = 'GroupAvatarID',@ChildColumn = 'AvatarID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_Community_Group',@ParentSurrogateKeyName = 'SurrogateKey_Community_Group',@ChildTable = 'BASE_CMS_Site',@ParentColumn = 'GroupSiteID',@ChildColumn = 'SiteID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_Community_Group',@ParentSurrogateKeyName = 'SurrogateKey_Community_Group',@ChildTable = 'BASE_CMS_User',@ParentColumn = 'GroupApprovedByUserID',@ChildColumn = 'UserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_Community_Group',@ParentSurrogateKeyName = 'SurrogateKey_Community_Group',@ChildTable = 'BASE_CMS_User',@ParentColumn = 'GroupCreatedByUserID',@ChildColumn = 'UserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_Hfit_HAHealthCheckLog',@ParentSurrogateKeyName = 'SurrogateKey_Hfit_HAHealthCheckLog',@ChildTable = 'BASE_Hfit_HAHealthCheckCodes',@ParentColumn = 'HAHealthCheckCodeID',@ChildColumn = 'HAHealthCheckCodeID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_HFit_HealthAssesmentRecomendations',@ParentSurrogateKeyName = 'SurrogateKey_HFit_HealthAssesmentRecomendations',@ChildTable = 'BASE_HFit_HealthAssesmentRecomendationTypes',@ParentColumn = 'RecomendationTypeID',@ChildColumn = 'RecomendationTypeID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_HFit_HealthAssesmentThresholdGrouping',@ParentSurrogateKeyName = 'SurrogateKey_HFit_HealthAssesmentThresholdGrouping',@ChildTable = 'BASE_HFit_HealthAssesmentThresholds',@ParentColumn = 'ThresholdID',@ChildColumn = 'ThresholdID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_HFit_HealthAssesmentThresholds',@ParentSurrogateKeyName = 'SurrogateKey_HFit_HealthAssesmentThresholds',@ChildTable = 'BASE_HFit_HealthAssesmentThresholdTypes',@ParentColumn = 'ThresholdTypeID',@ChildColumn = 'ThresholdTypeID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_HFit_HealthAssesmentUserAnswers',@ParentSurrogateKeyName = 'SurrogateKey_HFit_HealthAssesmentUserAnswers',@ChildTable = 'BASE_HFit_HealthAssesmentUserQuestion',@ParentColumn = 'HAQuestionItemID',@ChildColumn = 'ItemID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_HFit_HealthAssesmentUserModule',@ParentSurrogateKeyName = 'SurrogateKey_HFit_HealthAssesmentUserModule',@ChildTable = 'BASE_HFit_HealthAssesmentUserStarted',@ParentColumn = 'HAStartedItemID',@ChildColumn = 'ItemID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_HFit_HealthAssesmentUserQuestion',@ParentSurrogateKeyName = 'SurrogateKey_HFit_HealthAssesmentUserQuestion',@ChildTable = 'BASE_HFit_HealthAssesmentUserRiskArea',@ParentColumn = 'HARiskAreaItemID',@ChildColumn = 'ItemID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_HFit_HealthAssesmentUserQuestionGroupResults',@ParentSurrogateKeyName = 'SurrogateKey_HFit_HealthAssesmentUserQuestionGroupResults',@ChildTable = 'BASE_HFit_HealthAssesmentUserRiskArea',@ParentColumn = 'HARiskAreaItemID',@ChildColumn = 'ItemID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_HFit_HealthAssesmentUserRiskArea',@ParentSurrogateKeyName = 'SurrogateKey_HFit_HealthAssesmentUserRiskArea',@ChildTable = 'BASE_HFit_HealthAssesmentUserRiskCategory',@ParentColumn = 'HARiskCategoryItemID',@ChildColumn = 'ItemID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_HFit_HealthAssesmentUserRiskCategory',@ParentSurrogateKeyName = 'SurrogateKey_HFit_HealthAssesmentUserRiskCategory',@ChildTable = 'BASE_HFit_HealthAssesmentUserModule',@ParentColumn = 'HAModuleItemID',@ChildColumn = 'ItemID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_HFit_HealthAssessmentImportStagingDetail',@ParentSurrogateKeyName = 'SurrogateKey_HFit_HealthAssessmentImportStagingDetail',@ChildTable = 'BASE_HFit_HealthAssessmentImportStagingMaster',@ParentColumn = 'MasterID',@ChildColumn = 'MasterID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_HFit_HealthAssessmentImportStagingException',@ParentSurrogateKeyName = 'SurrogateKey_HFit_HealthAssessmentImportStagingException',@ChildTable = 'BASE_HFit_HealthAssessmentImportStagingDetail',@ParentColumn = 'DetailID',@ChildColumn = 'DetailID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_HFit_HealthAssessmentImportStagingMaster',@ParentSurrogateKeyName = 'SurrogateKey_HFit_HealthAssessmentImportStagingMaster',@ChildTable = 'BASE_HFit_LKP_HealthAssessmentImportStatus',@ParentColumn = 'StatusFlagID',@ChildColumn = 'StatusFlagID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_HFit_RewardException',@ParentSurrogateKeyName = 'SurrogateKey_HFit_RewardException',@ChildTable = 'BASE_HFit_RewardActivity',@ParentColumn = 'RewardActivityID',@ChildColumn = 'RewardActivityID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_HFit_RewardLevel',@ParentSurrogateKeyName = 'SurrogateKey_HFit_RewardLevel',@ChildTable = 'BASE_HFit_LKP_RewardFrequency',@ParentColumn = 'FrequencyMenu',@ChildColumn = 'RewardFrequencyLKPID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_HFit_RewardLevel',@ParentSurrogateKeyName = 'SurrogateKey_HFit_RewardLevel',@ChildTable = 'BASE_HFit_LKP_RewardType',@ParentColumn = 'AwardType',@ChildColumn = 'RewardTypeLKPID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_HFit_RewardsUserActivityDetail',@ParentSurrogateKeyName = 'SurrogateKey_HFit_RewardsUserActivityDetail',@ChildTable = 'BASE_HFit_LKP_RewardCompleted',@ParentColumn = 'ActivityCompletedID',@ChildColumn = 'RewardsCompletedID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'base_HFit_UserGoal',@ParentSurrogateKeyName = 'SurrogateKey_HFit_UserGoal',@ChildTable = 'base_HFit_GoalOutcome',@ParentColumn = 'ItemID',@ChildColumn = 'UserGoalItemID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_Messaging_Message',@ParentSurrogateKeyName = 'SurrogateKey_Messaging_Message',@ChildTable = 'BASE_CMS_User',@ParentColumn = 'MessageRecipientUserID',@ChildColumn = 'UserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_Messaging_Message',@ParentSurrogateKeyName = 'SurrogateKey_Messaging_Message',@ChildTable = 'BASE_CMS_User',@ParentColumn = 'MessageSenderUserID',@ChildColumn = 'UserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_OM_Account',@ParentSurrogateKeyName = 'SurrogateKey_OM_Account',@ChildTable = 'BASE_CMS_Country',@ParentColumn = 'AccountCountryID',@ChildColumn = 'CountryID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_OM_Account',@ParentSurrogateKeyName = 'SurrogateKey_OM_Account',@ChildTable = 'BASE_CMS_Site',@ParentColumn = 'AccountSiteID',@ChildColumn = 'SiteID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_OM_Account',@ParentSurrogateKeyName = 'SurrogateKey_OM_Account',@ChildTable = 'BASE_CMS_State',@ParentColumn = 'AccountStateID',@ChildColumn = 'StateID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_OM_Account',@ParentSurrogateKeyName = 'SurrogateKey_OM_Account',@ChildTable = 'BASE_CMS_User',@ParentColumn = 'AccountOwnerUserID',@ChildColumn = 'UserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_OM_Account',@ParentSurrogateKeyName = 'SurrogateKey_OM_Account',@ChildTable = 'BASE_OM_AccountStatus',@ParentColumn = 'AccountStatusID',@ChildColumn = 'AccountStatusID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_OM_Account',@ParentSurrogateKeyName = 'SurrogateKey_OM_Account',@ChildTable = 'BASE_OM_Contact',@ParentColumn = 'AccountPrimaryContactID',@ChildColumn = 'ContactID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_OM_Account',@ParentSurrogateKeyName = 'SurrogateKey_OM_Account',@ChildTable = 'BASE_OM_Contact',@ParentColumn = 'AccountSecondaryContactID',@ChildColumn = 'ContactID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_OM_AccountContact',@ParentSurrogateKeyName = 'SurrogateKey_OM_AccountContact',@ChildTable = 'BASE_OM_Account',@ParentColumn = 'AccountID',@ChildColumn = 'AccountID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_OM_AccountContact',@ParentSurrogateKeyName = 'SurrogateKey_OM_AccountContact',@ChildTable = 'BASE_OM_Contact',@ParentColumn = 'ContactID',@ChildColumn = 'ContactID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_OM_AccountContact',@ParentSurrogateKeyName = 'SurrogateKey_OM_AccountContact',@ChildTable = 'BASE_OM_ContactRole',@ParentColumn = 'ContactRoleID',@ChildColumn = 'ContactRoleID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_OM_AccountStatus',@ParentSurrogateKeyName = 'SurrogateKey_OM_AccountStatus',@ChildTable = 'BASE_CMS_Site',@ParentColumn = 'AccountStatusSiteID',@ChildColumn = 'SiteID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_OM_Contact',@ParentSurrogateKeyName = 'SurrogateKey_OM_Contact',@ChildTable = 'BASE_CMS_Country',@ParentColumn = 'ContactCountryID',@ChildColumn = 'CountryID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_OM_Contact',@ParentSurrogateKeyName = 'SurrogateKey_OM_Contact',@ChildTable = 'BASE_CMS_Site',@ParentColumn = 'ContactSiteID',@ChildColumn = 'SiteID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_OM_Contact',@ParentSurrogateKeyName = 'SurrogateKey_OM_Contact',@ChildTable = 'BASE_CMS_State',@ParentColumn = 'ContactStateID',@ChildColumn = 'StateID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_OM_Contact',@ParentSurrogateKeyName = 'SurrogateKey_OM_Contact',@ChildTable = 'BASE_CMS_User',@ParentColumn = 'ContactOwnerUserID',@ChildColumn = 'UserID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_OM_Contact',@ParentSurrogateKeyName = 'SurrogateKey_OM_Contact',@ChildTable = 'BASE_OM_ContactStatus',@ParentColumn = 'ContactStatusID',@ChildColumn = 'ContactStatusID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_OM_ContactRole',@ParentSurrogateKeyName = 'SurrogateKey_OM_ContactRole',@ChildTable = 'BASE_CMS_Site',@ParentColumn = 'ContactRoleSiteID',@ChildColumn = 'SiteID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_OM_ContactStatus',@ParentSurrogateKeyName = 'SurrogateKey_OM_ContactStatus',@ChildTable = 'BASE_CMS_Site',@ParentColumn = 'ContactStatusSiteID',@ChildColumn = 'SiteID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_SM_FacebookAccount',@ParentSurrogateKeyName = 'SurrogateKey_SM_FacebookAccount',@ChildTable = 'BASE_CMS_Site',@ParentColumn = 'FacebookAccountSiteID',@ChildColumn = 'SiteID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_SM_FacebookAccount',@ParentSurrogateKeyName = 'SurrogateKey_SM_FacebookAccount',@ChildTable = 'BASE_SM_FacebookApplication',@ParentColumn = 'FacebookAccountFacebookApplicationID',@ChildColumn = 'FacebookApplicationID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_SM_FacebookApplication',@ParentSurrogateKeyName = 'SurrogateKey_SM_FacebookApplication',@ChildTable = 'BASE_CMS_Site',@ParentColumn = 'FacebookApplicationSiteID',@ChildColumn = 'SiteID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_SM_TwitterAccount',@ParentSurrogateKeyName = 'SurrogateKey_SM_TwitterAccount',@ChildTable = 'BASE_CMS_Site',@ParentColumn = 'TwitterAccountSiteID',@ChildColumn = 'SiteID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_SM_TwitterAccount',@ParentSurrogateKeyName = 'SurrogateKey_SM_TwitterAccount',@ChildTable = 'BASE_SM_TwitterApplication',@ParentColumn = 'TwitterAccountTwitterApplicationID',@ChildColumn = 'TwitterApplicationID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_SM_TwitterApplication',@ParentSurrogateKeyName = 'SurrogateKey_SM_TwitterApplication',@ChildTable = 'BASE_CMS_Site',@ParentColumn = 'TwitterApplicationSiteID',@ChildColumn = 'SiteID',@PreviewOnly = 0
GO
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'base_View_HFit_Goal_Joined',@ParentSurrogateKeyName = 'SurrogateKey_View_HFit_Goal_Joined',@ChildTable = 'base_HFit_UserGoal',@ParentColumn = 'NodeID',@ChildColumn = 'NodeID',@PreviewOnly = 0
GO