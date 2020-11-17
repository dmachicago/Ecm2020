
-- 1998630163	Media_Library	1	IX_Media_Library_LibraryDisplayName	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Media_Library_LibraryDisplayName') 
 BEGIN 
	Create Clustered Index [IX_Media_Library_LibraryDisplayName] On [dbo].[Media_Library] ([LibrarySiteID] Asc,[LibraryDisplayName] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Media_Library_LibraryDisplayName') 
 BEGIN 
	DROP INDEX [IX_Media_Library_LibraryDisplayName] On [dbo].[Media_Library];
END
-- 1998630163	Media_Library	4	IX_Media_Library_LibraryGroupID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Media_Library_LibraryGroupID') 
 BEGIN 
	Create NonClustered Index [IX_Media_Library_LibraryGroupID] On [dbo].[Media_Library] ([LibraryGroupID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Media_Library_LibraryGroupID') 
 BEGIN 
	DROP INDEX [IX_Media_Library_LibraryGroupID] On [dbo].[Media_Library];
END
-- 2016726237	CMS_WorkflowHistory	3	IX_CMS_WorkflowHistory_StepID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_WorkflowHistory_StepID') 
 BEGIN 
	Create NonClustered Index [IX_CMS_WorkflowHistory_StepID] On [dbo].[CMS_WorkflowHistory] ([StepID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_WorkflowHistory_StepID') 
 BEGIN 
	DROP INDEX [IX_CMS_WorkflowHistory_StepID] On [dbo].[CMS_WorkflowHistory];
END
-- 903674267	CMS_Tree	3	IX_CMS_Tree_NodeID_NodeSiteID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_Tree_NodeID_NodeSiteID') 
 BEGIN 
	Create NonClustered Index [IX_CMS_Tree_NodeID_NodeSiteID] On [dbo].[CMS_Tree] ([NodeID] Asc,[NodeSiteID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_Tree_NodeID_NodeSiteID') 
 BEGIN 
	DROP INDEX [IX_CMS_Tree_NodeID_NodeSiteID] On [dbo].[CMS_Tree];
END
-- 903674267	CMS_Tree	5	CMS_Tree_NodeSiteID_NodeID_NodeClassID_NodeLinkedNodeID	
IF NOT Exists (Select name from sys.indexes where name = 'CMS_Tree_NodeSiteID_NodeID_NodeClassID_NodeLinkedNodeID') 
 BEGIN 
	Create NonClustered Index [CMS_Tree_NodeSiteID_NodeID_NodeClassID_NodeLinkedNodeID] On [dbo].[CMS_Tree] ([NodeSiteID] Asc) Include ([NodeClassID],[NodeID],[NodeLinkedNodeID])  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'CMS_Tree_NodeSiteID_NodeID_NodeClassID_NodeLinkedNodeID') 
 BEGIN 
	DROP INDEX [CMS_Tree_NodeSiteID_NodeID_NodeClassID_NodeLinkedNodeID] On [dbo].[CMS_Tree];
END
-- 903674267	CMS_Tree	6	IX_CMS_Tree_NodeSiteID_NodeGUID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_Tree_NodeSiteID_NodeGUID') 
 BEGIN 
	Create Unique NonClustered Index [IX_CMS_Tree_NodeSiteID_NodeGUID] On [dbo].[CMS_Tree] ([NodeSiteID] Asc,[NodeGUID] Asc) Include ([NodeID])  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_Tree_NodeSiteID_NodeGUID') 
 BEGIN 
	DROP INDEX [IX_CMS_Tree_NodeSiteID_NodeGUID] On [dbo].[CMS_Tree];
END
-- 903674267	CMS_Tree	8	IX_CMS_Tree_NodeParentID_NodeAlias_NodeName	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_Tree_NodeParentID_NodeAlias_NodeName') 
 BEGIN 
	Create NonClustered Index [IX_CMS_Tree_NodeParentID_NodeAlias_NodeName] On [dbo].[CMS_Tree] ([NodeParentID] Asc,[NodeAlias] Asc,[NodeName] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_Tree_NodeParentID_NodeAlias_NodeName') 
 BEGIN 
	DROP INDEX [IX_CMS_Tree_NodeParentID_NodeAlias_NodeName] On [dbo].[CMS_Tree];
END
-- 903674267	CMS_Tree	9	IX_CMS_Tree_NodeClassID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_Tree_NodeClassID') 
 BEGIN 
	Create NonClustered Index [IX_CMS_Tree_NodeClassID] On [dbo].[CMS_Tree] ([NodeClassID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_Tree_NodeClassID') 
 BEGIN 
	DROP INDEX [IX_CMS_Tree_NodeClassID] On [dbo].[CMS_Tree];
END
-- 903674267	CMS_Tree	11	IX_CMS_Tree_NodeACLID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_Tree_NodeACLID') 
 BEGIN 
	Create NonClustered Index [IX_CMS_Tree_NodeACLID] On [dbo].[CMS_Tree] ([NodeACLID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_Tree_NodeACLID') 
 BEGIN 
	DROP INDEX [IX_CMS_Tree_NodeACLID] On [dbo].[CMS_Tree];
END
-- 903674267	CMS_Tree	14	IX_CMS_Tree_NodeOwner	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_Tree_NodeOwner') 
 BEGIN 
	Create NonClustered Index [IX_CMS_Tree_NodeOwner] On [dbo].[CMS_Tree] ([NodeOwner] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_Tree_NodeOwner') 
 BEGIN 
	DROP INDEX [IX_CMS_Tree_NodeOwner] On [dbo].[CMS_Tree];
END
-- 914102297	CMS_WorkflowStepUser	1	IX_CMS_WorkflowStepUser_StepID_StepSourcePointGUID_UserID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_WorkflowStepUser_StepID_StepSourcePointGUID_UserID') 
 BEGIN 
	Create Unique Clustered Index [IX_CMS_WorkflowStepUser_StepID_StepSourcePointGUID_UserID] On [dbo].[CMS_WorkflowStepUser] ([StepID] Asc,[StepSourcePointGUID] Asc,[UserID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_WorkflowStepUser_StepID_StepSourcePointGUID_UserID') 
 BEGIN 
	DROP INDEX [IX_CMS_WorkflowStepUser_StepID_StepSourcePointGUID_UserID] On [dbo].[CMS_WorkflowStepUser];
END
-- 923150334	Forums_ForumPost	1	IX_Forums_ForumPost_PostIDPath	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Forums_ForumPost_PostIDPath') 
 BEGIN 
	Create Unique Clustered Index [IX_Forums_ForumPost_PostIDPath] On [dbo].[Forums_ForumPost] ([PostIDPath] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Forums_ForumPost_PostIDPath') 
 BEGIN 
	DROP INDEX [IX_Forums_ForumPost_PostIDPath] On [dbo].[Forums_ForumPost];
END
-- 923150334	Forums_ForumPost	4	IX_Forums_ForumPost_PostParentID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Forums_ForumPost_PostParentID') 
 BEGIN 
	Create NonClustered Index [IX_Forums_ForumPost_PostParentID] On [dbo].[Forums_ForumPost] ([PostParentID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Forums_ForumPost_PostParentID') 
 BEGIN 
	DROP INDEX [IX_Forums_ForumPost_PostParentID] On [dbo].[Forums_ForumPost];
END
-- 923150334	Forums_ForumPost	7	IX_Forums_ForumPost_PostApprovedByUserID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Forums_ForumPost_PostApprovedByUserID') 
 BEGIN 
	Create NonClustered Index [IX_Forums_ForumPost_PostApprovedByUserID] On [dbo].[Forums_ForumPost] ([PostApprovedByUserID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Forums_ForumPost_PostApprovedByUserID') 
 BEGIN 
	DROP INDEX [IX_Forums_ForumPost_PostApprovedByUserID] On [dbo].[Forums_ForumPost];
END
-- 926626344	OM_ScoreContactRule	2	IX_OM_ScoreContactRule_ScoreID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_OM_ScoreContactRule_ScoreID') 
 BEGIN 
	Create NonClustered Index [IX_OM_ScoreContactRule_ScoreID] On [dbo].[OM_ScoreContactRule] ([ScoreID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 100, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_OM_ScoreContactRule_ScoreID') 
 BEGIN 
	DROP INDEX [IX_OM_ScoreContactRule_ScoreID] On [dbo].[OM_ScoreContactRule];
END
-- 245575913	Forums_ForumSubscription	4	IX_Forums_ForumSubscription_SubscriptionPostID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Forums_ForumSubscription_SubscriptionPostID') 
 BEGIN 
	Create NonClustered Index [IX_Forums_ForumSubscription_SubscriptionPostID] On [dbo].[Forums_ForumSubscription] ([SubscriptionPostID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Forums_ForumSubscription_SubscriptionPostID') 
 BEGIN 
	DROP INDEX [IX_Forums_ForumSubscription_SubscriptionPostID] On [dbo].[Forums_ForumSubscription];
END
-- 249767947	CMS_TemplateDeviceLayout	3	IX_CMS_TemplateDeviceLayout_LayoutID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_TemplateDeviceLayout_LayoutID') 
 BEGIN 
	Create NonClustered Index [IX_CMS_TemplateDeviceLayout_LayoutID] On [dbo].[CMS_TemplateDeviceLayout] ([LayoutID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_TemplateDeviceLayout_LayoutID') 
 BEGIN 
	DROP INDEX [IX_CMS_TemplateDeviceLayout_LayoutID] On [dbo].[CMS_TemplateDeviceLayout];
END
-- 256719967	CMS_UIElement	1	IX_CMS_UIElement_ElementResourceID_ElementLevel_ElementParentID_ElementOrder_ElementCaption	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_UIElement_ElementResourceID_ElementLevel_ElementParentID_ElementOrder_ElementCaption') 
 BEGIN 
	Create Clustered Index [IX_CMS_UIElement_ElementResourceID_ElementLevel_ElementParentID_ElementOrder_ElementCaption] On [dbo].[CMS_UIElement] ([ElementResourceID] Asc,[ElementLevel] Asc,[ElementParentID] Asc,[ElementOrder] Asc,[ElementCaption] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_UIElement_ElementResourceID_ElementLevel_ElementParentID_ElementOrder_ElementCaption') 
 BEGIN 
	DROP INDEX [IX_CMS_UIElement_ElementResourceID_ElementLevel_ElementParentID_ElementOrder_ElementCaption] On [dbo].[CMS_UIElement];
END
-- 941246408	CMS_Widget	3	IX_CMS_Widget_WidgetWebPartID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_Widget_WidgetWebPartID') 
 BEGIN 
	Create NonClustered Index [IX_CMS_Widget_WidgetWebPartID] On [dbo].[CMS_Widget] ([WidgetWebPartID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_Widget_WidgetWebPartID') 
 BEGIN 
	DROP INDEX [IX_CMS_Widget_WidgetWebPartID] On [dbo].[CMS_Widget];
END
-- 946102411	CMS_MembershipUser	2	IX_CMS_MembershipUser_MembershipID_UserID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_MembershipUser_MembershipID_UserID') 
 BEGIN 
	Create Unique NonClustered Index [IX_CMS_MembershipUser_MembershipID_UserID] On [dbo].[CMS_MembershipUser] ([MembershipID] Asc,[UserID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_MembershipUser_MembershipID_UserID') 
 BEGIN 
	DROP INDEX [IX_CMS_MembershipUser_MembershipID_UserID] On [dbo].[CMS_MembershipUser];
END
-- 958626458	OM_Rule	2	IX_OM_Rule_RuleScoreID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_OM_Rule_RuleScoreID') 
 BEGIN 
	Create NonClustered Index [IX_OM_Rule_RuleScoreID] On [dbo].[OM_Rule] ([RuleScoreID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_OM_Rule_RuleScoreID') 
 BEGIN 
	DROP INDEX [IX_OM_Rule_RuleScoreID] On [dbo].[OM_Rule];
END
-- 1029578706	CMS_Role	3	IX_CMS_Role_SiteID_RoleName	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_Role_SiteID_RoleName') 
 BEGIN 
	Create Unique NonClustered Index [IX_CMS_Role_SiteID_RoleName] On [dbo].[CMS_Role] ([RoleName] Asc,[SiteID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_Role_SiteID_RoleName') 
 BEGIN 
	DROP INDEX [IX_CMS_Role_SiteID_RoleName] On [dbo].[CMS_Role];
END
-- 1029578706	CMS_Role	5	IX_CMS_Role_RoleGroupID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_Role_RoleGroupID') 
 BEGIN 
	Create NonClustered Index [IX_CMS_Role_RoleGroupID] On [dbo].[CMS_Role] ([RoleGroupID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_Role_RoleGroupID') 
 BEGIN 
	DROP INDEX [IX_CMS_Role_RoleGroupID] On [dbo].[CMS_Role];
END
-- 1029578706	CMS_Role	9	idx_HFit_CMS_Role_SiteIDRoleID	
IF NOT Exists (Select name from sys.indexes where name = 'idx_HFit_CMS_Role_SiteIDRoleID') 
 BEGIN 
	Create NonClustered Index [idx_HFit_CMS_Role_SiteIDRoleID] On [dbo].[CMS_Role] ([SiteID] Asc,[RoleID] Asc,[RoleDisplayName] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'idx_HFit_CMS_Role_SiteIDRoleID') 
 BEGIN 
	DROP INDEX [idx_HFit_CMS_Role_SiteIDRoleID] On [dbo].[CMS_Role];
END
-- 1042818777	CMS_Transformation	1	IX_CMS_Transformation_TransformationClassID_TransformationName	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_Transformation_TransformationClassID_TransformationName') 
 BEGIN 
	Create Clustered Index [IX_CMS_Transformation_TransformationClassID_TransformationName] On [dbo].[CMS_Transformation] ([TransformationClassID] Asc,[TransformationName] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_Transformation_TransformationClassID_TransformationName') 
 BEGIN 
	DROP INDEX [IX_CMS_Transformation_TransformationClassID_TransformationName] On [dbo].[CMS_Transformation];
END
-- 1046659172	Staging_SynchronizationArchive	1	cdx_StagingSyncTaskID	
--IF NOT Exists (Select name from sys.indexes where name = 'cdx_StagingSyncTaskID') 
-- BEGIN 
--	Create Clustered Index [cdx_StagingSyncTaskID] On [dbo].[Staging_SynchronizationArchive] ([SynchronizationTaskID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
-- END 
	 	
IF Exists (Select name from sys.indexes where name = 'cdx_StagingSyncTaskID') 
 BEGIN 
	DROP INDEX [cdx_StagingSyncTaskID] On [dbo].[Staging_SynchronizationArchive];
END
-- 1061578820	Board_Subscription	3	IX_Board_Subscription_SubscriptionUserID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Board_Subscription_SubscriptionUserID') 
 BEGIN 
	Create NonClustered Index [IX_Board_Subscription_SubscriptionUserID] On [dbo].[Board_Subscription] ([SubscriptionUserID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Board_Subscription_SubscriptionUserID') 
 BEGIN 
	DROP INDEX [IX_Board_Subscription_SubscriptionUserID] On [dbo].[Board_Subscription];
END
-- 1062294844	OM_ContactGroupMember	2	IX_OM_ContactGroupMember_ContactGroupMemberContactGroupID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_OM_ContactGroupMember_ContactGroupMemberContactGroupID') 
 BEGIN 
	Create NonClustered Index [IX_OM_ContactGroupMember_ContactGroupMemberContactGroupID] On [dbo].[OM_ContactGroupMember] ([ContactGroupMemberContactGroupID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 100, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_OM_ContactGroupMember_ContactGroupMemberContactGroupID') 
 BEGIN 
	DROP INDEX [IX_OM_ContactGroupMember_ContactGroupMemberContactGroupID] On [dbo].[OM_ContactGroupMember];
END
-- 1062294844	OM_ContactGroupMember	8	idx_HFit_ContactGroupMember_RelatedID	
IF NOT Exists (Select name from sys.indexes where name = 'idx_HFit_ContactGroupMember_RelatedID') 
 BEGIN 
	Create NonClustered Index [idx_HFit_ContactGroupMember_RelatedID] On [dbo].[OM_ContactGroupMember] ([ContactGroupMemberContactGroupID] Asc,[ContactGroupMemberID] Asc,[ContactGroupMemberRelatedID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 100, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'idx_HFit_ContactGroupMember_RelatedID') 
 BEGIN 
	DROP INDEX [idx_HFit_ContactGroupMember_RelatedID] On [dbo].[OM_ContactGroupMember];
END
-- 1294627655	OM_IP	3	IX_OM_IP_IPOriginalContactID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_OM_IP_IPOriginalContactID') 
 BEGIN 
	Create NonClustered Index [IX_OM_IP_IPOriginalContactID] On [dbo].[OM_IP] ([IPOriginalContactID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_OM_IP_IPOriginalContactID') 
 BEGIN 
	DROP INDEX [IX_OM_IP_IPOriginalContactID] On [dbo].[OM_IP];
END
-- 1750297295	COM_ShoppingCart	4	IX_COM_ShoppingCart_ShoppingCartLastUpdate	
IF NOT Exists (Select name from sys.indexes where name = 'IX_COM_ShoppingCart_ShoppingCartLastUpdate') 
 BEGIN 
	Create NonClustered Index [IX_COM_ShoppingCart_ShoppingCartLastUpdate] On [dbo].[COM_ShoppingCart] ([ShoppingCartLastUpdate] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_COM_ShoppingCart_ShoppingCartLastUpdate') 
 BEGIN 
	DROP INDEX [IX_COM_ShoppingCart_ShoppingCartLastUpdate] On [dbo].[COM_ShoppingCart];
END
-- 1750297295	COM_ShoppingCart	6	IX_COM_ShoppingCart_ShoppingCartPaymentOptionID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_COM_ShoppingCart_ShoppingCartPaymentOptionID') 
 BEGIN 
	Create NonClustered Index [IX_COM_ShoppingCart_ShoppingCartPaymentOptionID] On [dbo].[COM_ShoppingCart] ([ShoppingCartPaymentOptionID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_COM_ShoppingCart_ShoppingCartPaymentOptionID') 
 BEGIN 
	DROP INDEX [IX_COM_ShoppingCart_ShoppingCartPaymentOptionID] On [dbo].[COM_ShoppingCart];
END
-- 1750297295	COM_ShoppingCart	7	IX_COM_ShoppingCart_ShoppingCartShippingOptionID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_COM_ShoppingCart_ShoppingCartShippingOptionID') 
 BEGIN 
	Create NonClustered Index [IX_COM_ShoppingCart_ShoppingCartShippingOptionID] On [dbo].[COM_ShoppingCart] ([ShoppingCartShippingOptionID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_COM_ShoppingCart_ShoppingCartShippingOptionID') 
 BEGIN 
	DROP INDEX [IX_COM_ShoppingCart_ShoppingCartShippingOptionID] On [dbo].[COM_ShoppingCart];
END
-- 1750297295	COM_ShoppingCart	9	IX_COM_ShoppingCart_ShoppingCartBillingAddressID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_COM_ShoppingCart_ShoppingCartBillingAddressID') 
 BEGIN 
	Create NonClustered Index [IX_COM_ShoppingCart_ShoppingCartBillingAddressID] On [dbo].[COM_ShoppingCart] ([ShoppingCartBillingAddressID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_COM_ShoppingCart_ShoppingCartBillingAddressID') 
 BEGIN 
	DROP INDEX [IX_COM_ShoppingCart_ShoppingCartBillingAddressID] On [dbo].[COM_ShoppingCart];
END
-- 1750297295	COM_ShoppingCart	10	IX_COM_ShoppingCart_ShoppingCartShippingAddressID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_COM_ShoppingCart_ShoppingCartShippingAddressID') 
 BEGIN 
	Create NonClustered Index [IX_COM_ShoppingCart_ShoppingCartShippingAddressID] On [dbo].[COM_ShoppingCart] ([ShoppingCartShippingAddressID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_COM_ShoppingCart_ShoppingCartShippingAddressID') 
 BEGIN 
	DROP INDEX [IX_COM_ShoppingCart_ShoppingCartShippingAddressID] On [dbo].[COM_ShoppingCart];
END
-- 1750297295	COM_ShoppingCart	12	IX_COM_ShoppingCart_ShoppingCartCompanyAddressID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_COM_ShoppingCart_ShoppingCartCompanyAddressID') 
 BEGIN 
	Create NonClustered Index [IX_COM_ShoppingCart_ShoppingCartCompanyAddressID] On [dbo].[COM_ShoppingCart] ([ShoppingCartCompanyAddressID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_COM_ShoppingCart_ShoppingCartCompanyAddressID') 
 BEGIN 
	DROP INDEX [IX_COM_ShoppingCart_ShoppingCartCompanyAddressID] On [dbo].[COM_ShoppingCart];
END
-- 1771153355	OM_ABVariant	2	IX_OM_ABVariant_ABVariantTestID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_OM_ABVariant_ABVariantTestID') 
 BEGIN 
	Create NonClustered Index [IX_OM_ABVariant_ABVariantTestID] On [dbo].[OM_ABVariant] ([ABVariantTestID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_OM_ABVariant_ABVariantTestID') 
 BEGIN 
	DROP INDEX [IX_OM_ABVariant_ABVariantTestID] On [dbo].[OM_ABVariant];
END
-- 1771153355	OM_ABVariant	3	IX_OM_ABVariant_ABVariantSiteID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_OM_ABVariant_ABVariantSiteID') 
 BEGIN 
	Create NonClustered Index [IX_OM_ABVariant_ABVariantSiteID] On [dbo].[OM_ABVariant] ([ABVariantSiteID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_OM_ABVariant_ABVariantSiteID') 
 BEGIN 
	DROP INDEX [IX_OM_ABVariant_ABVariantSiteID] On [dbo].[OM_ABVariant];
END
-- 11863109	OM_ContactRole	2	IX_OM_ContactRole_ContactRoleSiteID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_OM_ContactRole_ContactRoleSiteID') 
 BEGIN 
	Create NonClustered Index [IX_OM_ContactRole_ContactRoleSiteID] On [dbo].[OM_ContactRole] ([ContactRoleSiteID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 100, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_OM_ContactRole_ContactRoleSiteID') 
 BEGIN 
	DROP INDEX [IX_OM_ContactRole_ContactRoleSiteID] On [dbo].[OM_ContactRole];
END
-- 13243102	CMS_AutomationHistory	3	IX_CMS_AutomationHistory_HistoryApprovedByUserID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_AutomationHistory_HistoryApprovedByUserID') 
 BEGIN 
	Create NonClustered Index [IX_CMS_AutomationHistory_HistoryApprovedByUserID] On [dbo].[CMS_AutomationHistory] ([HistoryApprovedByUserID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_AutomationHistory_HistoryApprovedByUserID') 
 BEGIN 
	DROP INDEX [IX_CMS_AutomationHistory_HistoryApprovedByUserID] On [dbo].[CMS_AutomationHistory];
END
-- 13243102	CMS_AutomationHistory	4	IX_CMS_AutomationHistory_HistoryApprovedWhen	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_AutomationHistory_HistoryApprovedWhen') 
 BEGIN 
	Create NonClustered Index [IX_CMS_AutomationHistory_HistoryApprovedWhen] On [dbo].[CMS_AutomationHistory] ([HistoryApprovedWhen] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_AutomationHistory_HistoryApprovedWhen') 
 BEGIN 
	DROP INDEX [IX_CMS_AutomationHistory_HistoryApprovedWhen] On [dbo].[CMS_AutomationHistory];
END
-- 773577794	PM_ProjectTask	3	IX_PM_ProjectTask_ProjectTaskStatusID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_PM_ProjectTask_ProjectTaskStatusID') 
 BEGIN 
	Create NonClustered Index [IX_PM_ProjectTask_ProjectTaskStatusID] On [dbo].[PM_ProjectTask] ([ProjectTaskStatusID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 100, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_PM_ProjectTask_ProjectTaskStatusID') 
 BEGIN 
	DROP INDEX [IX_PM_ProjectTask_ProjectTaskStatusID] On [dbo].[PM_ProjectTask];
END
-- 773577794	PM_ProjectTask	6	IX_PM_ProjectTask_ProjectTaskAssignedToUserID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_PM_ProjectTask_ProjectTaskAssignedToUserID') 
 BEGIN 
	Create NonClustered Index [IX_PM_ProjectTask_ProjectTaskAssignedToUserID] On [dbo].[PM_ProjectTask] ([ProjectTaskAssignedToUserID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 100, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_PM_ProjectTask_ProjectTaskAssignedToUserID') 
 BEGIN 
	DROP INDEX [IX_PM_ProjectTask_ProjectTaskAssignedToUserID] On [dbo].[PM_ProjectTask];
END
-- 1538104520	Reporting_ReportValue	2	IX_Reporting_ReportValue_ValueName_ValueReportID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Reporting_ReportValue_ValueName_ValueReportID') 
 BEGIN 
	Create NonClustered Index [IX_Reporting_ReportValue_ValueName_ValueReportID] On [dbo].[Reporting_ReportValue] ([ValueName] Asc,[ValueReportID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Reporting_ReportValue_ValueName_ValueReportID') 
 BEGIN 
	DROP INDEX [IX_Reporting_ReportValue_ValueName_ValueReportID] On [dbo].[Reporting_ReportValue];
END
-- 1573580644	COM_ShoppingCartSKU	3	IX_COM_ShoppingCartSKU_SKUID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_COM_ShoppingCartSKU_SKUID') 
 BEGIN 
	Create NonClustered Index [IX_COM_ShoppingCartSKU_SKUID] On [dbo].[COM_ShoppingCartSKU] ([SKUID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_COM_ShoppingCartSKU_SKUID') 
 BEGIN 
	DROP INDEX [IX_COM_ShoppingCartSKU_SKUID] On [dbo].[COM_ShoppingCartSKU];
END
-- 1574296668	Notification_Subscription	2	IX_Notification_Subscription_SubscriptionGatewayID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Notification_Subscription_SubscriptionGatewayID') 
 BEGIN 
	Create NonClustered Index [IX_Notification_Subscription_SubscriptionGatewayID] On [dbo].[Notification_Subscription] ([SubscriptionGatewayID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Notification_Subscription_SubscriptionGatewayID') 
 BEGIN 
	DROP INDEX [IX_Notification_Subscription_SubscriptionGatewayID] On [dbo].[Notification_Subscription];
END
-- 1574296668	Notification_Subscription	4	IX_Notification_Subscription_SubscriptionEventSource_SubscriptionEventCode_SubscriptionEventObjectID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Notification_Subscription_SubscriptionEventSource_SubscriptionEventCode_SubscriptionEventObjectID') 
 BEGIN 
	Create NonClustered Index [IX_Notification_Subscription_SubscriptionEventSource_SubscriptionEventCode_SubscriptionEventObjectID] On [dbo].[Notification_Subscription] ([SubscriptionEventSource] Asc,[SubscriptionEventCode] Asc,[SubscriptionEventObjectID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Notification_Subscription_SubscriptionEventSource_SubscriptionEventCode_SubscriptionEventObjectID') 
 BEGIN 
	DROP INDEX [IX_Notification_Subscription_SubscriptionEventSource_SubscriptionEventCode_SubscriptionEventObjectID] On [dbo].[Notification_Subscription];
END
-- 1574296668	Notification_Subscription	5	IX_Notification_Subscription_SubscriptionUserID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Notification_Subscription_SubscriptionUserID') 
 BEGIN 
	Create NonClustered Index [IX_Notification_Subscription_SubscriptionUserID] On [dbo].[Notification_Subscription] ([SubscriptionUserID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Notification_Subscription_SubscriptionUserID') 
 BEGIN 
	DROP INDEX [IX_Notification_Subscription_SubscriptionUserID] On [dbo].[Notification_Subscription];
END
-- 754101727	COM_CurrencyExchangeRate	2	IX_COM_CurrencyExchangeRate_ExchangeRateToCurrencyID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_COM_CurrencyExchangeRate_ExchangeRateToCurrencyID') 
 BEGIN 
	Create NonClustered Index [IX_COM_CurrencyExchangeRate_ExchangeRateToCurrencyID] On [dbo].[COM_CurrencyExchangeRate] ([ExchangeRateToCurrencyID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_COM_CurrencyExchangeRate_ExchangeRateToCurrencyID') 
 BEGIN 
	DROP INDEX [IX_COM_CurrencyExchangeRate_ExchangeRateToCurrencyID] On [dbo].[COM_CurrencyExchangeRate];
END
-- 754101727	COM_CurrencyExchangeRate	3	IX_COM_CurrencyExchangeRate_ExchangeTableID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_COM_CurrencyExchangeRate_ExchangeTableID') 
 BEGIN 
	Create NonClustered Index [IX_COM_CurrencyExchangeRate_ExchangeTableID] On [dbo].[COM_CurrencyExchangeRate] ([ExchangeTableID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_COM_CurrencyExchangeRate_ExchangeTableID') 
 BEGIN 
	DROP INDEX [IX_COM_CurrencyExchangeRate_ExchangeTableID] On [dbo].[COM_CurrencyExchangeRate];
END
-- 768721791	Reporting_ReportCategory	1	IX_Reporting_ReportCategory_CategoryPath	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Reporting_ReportCategory_CategoryPath') 
 BEGIN 
	Create Unique Clustered Index [IX_Reporting_ReportCategory_CategoryPath] On [dbo].[Reporting_ReportCategory] ([CategoryPath] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Reporting_ReportCategory_CategoryPath') 
 BEGIN 
	DROP INDEX [IX_Reporting_ReportCategory_CategoryPath] On [dbo].[Reporting_ReportCategory];
END
-- 768721791	Reporting_ReportCategory	3	IX_Reporting_ReportCategory_CategoryParentID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Reporting_ReportCategory_CategoryParentID') 
 BEGIN 
	Create NonClustered Index [IX_Reporting_ReportCategory_CategoryParentID] On [dbo].[Reporting_ReportCategory] ([CategoryParentID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Reporting_ReportCategory_CategoryParentID') 
 BEGIN 
	DROP INDEX [IX_Reporting_ReportCategory_CategoryParentID] On [dbo].[Reporting_ReportCategory];
END
-- 1934629935	Notification_Template	1	IX_Notification_Template_TemplateSiteID_TemplateDisplayName	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Notification_Template_TemplateSiteID_TemplateDisplayName') 
 BEGIN 
	Create Clustered Index [IX_Notification_Template_TemplateSiteID_TemplateDisplayName] On [dbo].[Notification_Template] ([TemplateSiteID] Asc,[TemplateDisplayName] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Notification_Template_TemplateSiteID_TemplateDisplayName') 
 BEGIN 
	DROP INDEX [IX_Notification_Template_TemplateSiteID_TemplateDisplayName] On [dbo].[Notification_Template];
END
-- 195531780	Analytics_ConversionCampaign	1	IX_Analytics_ConversionCampaign	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Analytics_ConversionCampaign') 
 BEGIN 
	Create Unique Clustered Index [IX_Analytics_ConversionCampaign] On [dbo].[Analytics_ConversionCampaign] ([CampaignID] Asc,[ConversionID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Analytics_ConversionCampaign') 
 BEGIN 
	DROP INDEX [IX_Analytics_ConversionCampaign] On [dbo].[Analytics_ConversionCampaign];
END
-- 198343821	HFit_TrackerCardio	5	IX_HFit_TrackerCardio_UserID_EventDate	
IF NOT Exists (Select name from sys.indexes where name = 'IX_HFit_TrackerCardio_UserID_EventDate') 
 BEGIN 
	Create NonClustered Index [IX_HFit_TrackerCardio_UserID_EventDate] On [dbo].[HFit_TrackerCardio] ([UserID] Asc,[EventDate] Asc) Include ([Minutes])  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_HFit_TrackerCardio_UserID_EventDate') 
 BEGIN 
	DROP INDEX [IX_HFit_TrackerCardio_UserID_EventDate] On [dbo].[HFit_TrackerCardio];
END
-- 203863793	COM_Manufacturer	1	IX_COM_Manufacturer_ManufacturerDisplayName_ManufacturerEnabled	
IF NOT Exists (Select name from sys.indexes where name = 'IX_COM_Manufacturer_ManufacturerDisplayName_ManufacturerEnabled') 
 BEGIN 
	Create Clustered Index [IX_COM_Manufacturer_ManufacturerDisplayName_ManufacturerEnabled] On [dbo].[COM_Manufacturer] ([ManufacturerDisplayName] Asc,[ManufacturerEnabled] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 100, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_COM_Manufacturer_ManufacturerDisplayName_ManufacturerEnabled') 
 BEGIN 
	DROP INDEX [IX_COM_Manufacturer_ManufacturerDisplayName_ManufacturerEnabled] On [dbo].[COM_Manufacturer];
END
-- 204332288	HFit_PostSubscriber	9	IX_Hfit_PostSubscriber_ContactID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Hfit_PostSubscriber_ContactID') 
 BEGIN 
	Create NonClustered Index [IX_Hfit_PostSubscriber_ContactID] On [dbo].[HFit_PostSubscriber] ([ContactID] Asc) Include ([DocumentID],[Pinned],[PublishDate])  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Hfit_PostSubscriber_ContactID') 
 BEGIN 
	DROP INDEX [IX_Hfit_PostSubscriber_ContactID] On [dbo].[HFit_PostSubscriber];
END
-- 204332288	HFit_PostSubscriber	10	IX_PostSubscriber_NodeID_ContactGroupID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_PostSubscriber_NodeID_ContactGroupID') 
 BEGIN 
	Create NonClustered Index [IX_PostSubscriber_NodeID_ContactGroupID] On [dbo].[HFit_PostSubscriber] ([NodeID] Asc,[ContactGroupID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_PostSubscriber_NodeID_ContactGroupID') 
 BEGIN 
	DROP INDEX [IX_PostSubscriber_NodeID_ContactGroupID] On [dbo].[HFit_PostSubscriber];
END
-- 204332288	HFit_PostSubscriber	15	IX_Hfit_PostSubscriber_DocumentID_PublishDate	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Hfit_PostSubscriber_DocumentID_PublishDate') 
 BEGIN 
	Create NonClustered Index [IX_Hfit_PostSubscriber_DocumentID_PublishDate] On [dbo].[HFit_PostSubscriber] ([DocumentID] Asc,[PublishDate] Asc) Include ([ContactGroupID],[ContactID],[Pinned])  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Hfit_PostSubscriber_DocumentID_PublishDate') 
 BEGIN 
	DROP INDEX [IX_Hfit_PostSubscriber_DocumentID_PublishDate] On [dbo].[HFit_PostSubscriber];
END
-- 208719796	CMS_WebPart	1	IX_CMS_WebPart_WebPartLoadGeneration	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_WebPart_WebPartLoadGeneration') 
 BEGIN 
	Create Clustered Index [IX_CMS_WebPart_WebPartLoadGeneration] On [dbo].[CMS_WebPart] ([WebPartLoadGeneration] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_WebPart_WebPartLoadGeneration') 
 BEGIN 
	DROP INDEX [IX_CMS_WebPart_WebPartLoadGeneration] On [dbo].[CMS_WebPart];
END
-- 208719796	CMS_WebPart	3	IX_CMS_WebPart_WebPartName	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_WebPart_WebPartName') 
 BEGIN 
	Create NonClustered Index [IX_CMS_WebPart_WebPartName] On [dbo].[CMS_WebPart] ([WebPartName] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_WebPart_WebPartName') 
 BEGIN 
	DROP INDEX [IX_CMS_WebPart_WebPartName] On [dbo].[CMS_WebPart];
END
-- 208719796	CMS_WebPart	6	IX_CMS_WebPart_WebPartLastSelection	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_WebPart_WebPartLastSelection') 
 BEGIN 
	Create NonClustered Index [IX_CMS_WebPart_WebPartLastSelection] On [dbo].[CMS_WebPart] ([WebPartLastSelection] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_WebPart_WebPartLastSelection') 
 BEGIN 
	DROP INDEX [IX_CMS_WebPart_WebPartLastSelection] On [dbo].[CMS_WebPart];
END
-- 449436675	HFit_TrackerHighFatFoods	5	idx_HFit_TrackerHighFatFoods_CreateDate	
IF NOT Exists (Select name from sys.indexes where name = 'idx_HFit_TrackerHighFatFoods_CreateDate') 
 BEGIN 
	Create NonClustered Index [idx_HFit_TrackerHighFatFoods_CreateDate] On [dbo].[HFit_TrackerHighFatFoods] ([ItemCreatedWhen] Asc,[ItemModifiedWhen] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'idx_HFit_TrackerHighFatFoods_CreateDate') 
 BEGIN 
	DROP INDEX [idx_HFit_TrackerHighFatFoods_CreateDate] On [dbo].[HFit_TrackerHighFatFoods];
END
-- 468196718	Newsletter_Emails	2	IX_Newsletter_Emails_EmailNewsletterIssueID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Newsletter_Emails_EmailNewsletterIssueID') 
 BEGIN 
	Create NonClustered Index [IX_Newsletter_Emails_EmailNewsletterIssueID] On [dbo].[Newsletter_Emails] ([EmailNewsletterIssueID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Newsletter_Emails_EmailNewsletterIssueID') 
 BEGIN 
	DROP INDEX [IX_Newsletter_Emails_EmailNewsletterIssueID] On [dbo].[Newsletter_Emails];
END
-- 468196718	Newsletter_Emails	3	IX_Newsletter_Emails_EmailSubscriberID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Newsletter_Emails_EmailSubscriberID') 
 BEGIN 
	Create NonClustered Index [IX_Newsletter_Emails_EmailSubscriberID] On [dbo].[Newsletter_Emails] ([EmailSubscriberID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Newsletter_Emails_EmailSubscriberID') 
 BEGIN 
	DROP INDEX [IX_Newsletter_Emails_EmailSubscriberID] On [dbo].[Newsletter_Emails];
END
-- 468196718	Newsletter_Emails	5	IX_Newsletter_Emails_EmailSending	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Newsletter_Emails_EmailSending') 
 BEGIN 
	Create NonClustered Index [IX_Newsletter_Emails_EmailSending] On [dbo].[Newsletter_Emails] ([EmailSending] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Newsletter_Emails_EmailSending') 
 BEGIN 
	DROP INDEX [IX_Newsletter_Emails_EmailSending] On [dbo].[Newsletter_Emails];
END
-- 471672728	Forums_ForumGroup	3	IX_Forums_ForumGroup_GroupSiteID_GroupName	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Forums_ForumGroup_GroupSiteID_GroupName') 
 BEGIN 
	Create NonClustered Index [IX_Forums_ForumGroup_GroupSiteID_GroupName] On [dbo].[Forums_ForumGroup] ([GroupSiteID] Asc,[GroupName] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Forums_ForumGroup_GroupSiteID_GroupName') 
 BEGIN 
	DROP INDEX [IX_Forums_ForumGroup_GroupSiteID_GroupName] On [dbo].[Forums_ForumGroup];
END
-- 574585781	Tracker_EDW_Metadata	1	PK_Tracker_EDW_Metadata	
IF NOT Exists (Select name from sys.indexes where name = 'PK_Tracker_EDW_Metadata') 
 BEGIN 
	Create Unique Clustered Index [PK_Tracker_EDW_Metadata] On [dbo].[Tracker_EDW_Metadata] ([TableName] Asc,[ColName] Asc,[AttrName] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 100, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'PK_Tracker_EDW_Metadata') 
 BEGIN 
	DROP INDEX [PK_Tracker_EDW_Metadata] On [dbo].[Tracker_EDW_Metadata];
END
-- 587149137	CMS_SearchIndex	1	IX_CMS_SearchIndex_IndexDisplayName	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_SearchIndex_IndexDisplayName') 
 BEGIN 
	Create Clustered Index [IX_CMS_SearchIndex_IndexDisplayName] On [dbo].[CMS_SearchIndex] ([IndexDisplayName] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_SearchIndex_IndexDisplayName') 
 BEGIN 
	DROP INDEX [IX_CMS_SearchIndex_IndexDisplayName] On [dbo].[CMS_SearchIndex];
END
-- 611025458	HFit_Account	12	HFit_Account_ClientCode_PI	
IF NOT Exists (Select name from sys.indexes where name = 'HFit_Account_ClientCode_PI') 
 BEGIN 
	Create NonClustered Index [HFit_Account_ClientCode_PI] On [dbo].[HFit_Account] ([AccountCD] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'HFit_Account_ClientCode_PI') 
 BEGIN 
	DROP INDEX [HFit_Account_ClientCode_PI] On [dbo].[HFit_Account];
END
-- 617769258	CMS_ObjectSettings	2	IX_CMS_ObjectSettings_ObjectSettingsObjectType_ObjectSettingsObjectID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_ObjectSettings_ObjectSettingsObjectType_ObjectSettingsObjectID') 
 BEGIN 
	Create Unique NonClustered Index [IX_CMS_ObjectSettings_ObjectSettingsObjectType_ObjectSettingsObjectID] On [dbo].[CMS_ObjectSettings] ([ObjectSettingsObjectID] Asc,[ObjectSettingsObjectType] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_ObjectSettings_ObjectSettingsObjectType_ObjectSettingsObjectID') 
 BEGIN 
	DROP INDEX [IX_CMS_ObjectSettings_ObjectSettingsObjectType_ObjectSettingsObjectID] On [dbo].[CMS_ObjectSettings];
END
-- 171147655	CMS_EmailTemplate	1	IX_CMS_EmailTemplate_EmailTemplateDisplayName	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_EmailTemplate_EmailTemplateDisplayName') 
 BEGIN 
	Create Clustered Index [IX_CMS_EmailTemplate_EmailTemplateDisplayName] On [dbo].[CMS_EmailTemplate] ([EmailTemplateDisplayName] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_EmailTemplate_EmailTemplateDisplayName') 
 BEGIN 
	DROP INDEX [IX_CMS_EmailTemplate_EmailTemplateDisplayName] On [dbo].[CMS_EmailTemplate];
END
-- 180195692	CMS_SettingsKey	3	IX_CMS_SettingsKey_SiteID_KeyName	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_SettingsKey_SiteID_KeyName') 
 BEGIN 
	Create NonClustered Index [IX_CMS_SettingsKey_SiteID_KeyName] On [dbo].[CMS_SettingsKey] ([SiteID] Asc,[KeyName] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_SettingsKey_SiteID_KeyName') 
 BEGIN 
	DROP INDEX [IX_CMS_SettingsKey_SiteID_KeyName] On [dbo].[CMS_SettingsKey];
END
-- 180195692	CMS_SettingsKey	14	IX_CMS_SettingsKey_KeyName	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_SettingsKey_KeyName') 
 BEGIN 
	Create NonClustered Index [IX_CMS_SettingsKey_KeyName] On [dbo].[CMS_SettingsKey] ([KeyName] Asc) Include ([KeyValue],[SiteID])  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_SettingsKey_KeyName') 
 BEGIN 
	DROP INDEX [IX_CMS_SettingsKey_KeyName] On [dbo].[CMS_SettingsKey];
END
-- 1876917758	BadWords_Word	1	IX_BadWords_Word_WordExpression	
IF NOT Exists (Select name from sys.indexes where name = 'IX_BadWords_Word_WordExpression') 
 BEGIN 
	Create Clustered Index [IX_BadWords_Word_WordExpression] On [dbo].[BadWords_Word] ([WordExpression] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_BadWords_Word_WordExpression') 
 BEGIN 
	DROP INDEX [IX_BadWords_Word_WordExpression] On [dbo].[BadWords_Word];
END
-- 1890105774	Integration_Synchronization	3	IX_Integration_Synchronization_SynchronizationConnectorID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Integration_Synchronization_SynchronizationConnectorID') 
 BEGIN 
	Create NonClustered Index [IX_Integration_Synchronization_SynchronizationConnectorID] On [dbo].[Integration_Synchronization] ([SynchronizationConnectorID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Integration_Synchronization_SynchronizationConnectorID') 
 BEGIN 
	DROP INDEX [IX_Integration_Synchronization_SynchronizationConnectorID] On [dbo].[Integration_Synchronization];
END
-- 2073774445	Newsletter_Newsletter	1	IX_Newsletter_Newsletter_NewsletterSiteID_NewsletterDisplayName	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Newsletter_Newsletter_NewsletterSiteID_NewsletterDisplayName') 
 BEGIN 
	Create Clustered Index [IX_Newsletter_Newsletter_NewsletterSiteID_NewsletterDisplayName] On [dbo].[Newsletter_Newsletter] ([NewsletterSiteID] Asc,[NewsletterDisplayName] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Newsletter_Newsletter_NewsletterSiteID_NewsletterDisplayName') 
 BEGIN 
	DROP INDEX [IX_Newsletter_Newsletter_NewsletterSiteID_NewsletterDisplayName] On [dbo].[Newsletter_Newsletter];
END
-- 2073774445	Newsletter_Newsletter	4	IX_Newsletter_Newsletter_NewsletterSubscriptionTemplateID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Newsletter_Newsletter_NewsletterSubscriptionTemplateID') 
 BEGIN 
	Create NonClustered Index [IX_Newsletter_Newsletter_NewsletterSubscriptionTemplateID] On [dbo].[Newsletter_Newsletter] ([NewsletterSubscriptionTemplateID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Newsletter_Newsletter_NewsletterSubscriptionTemplateID') 
 BEGIN 
	DROP INDEX [IX_Newsletter_Newsletter_NewsletterSubscriptionTemplateID] On [dbo].[Newsletter_Newsletter];
END
-- 2073774445	Newsletter_Newsletter	5	IX_Newsletter_Newsletter_NewsletterUnsubscriptionTemplateID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Newsletter_Newsletter_NewsletterUnsubscriptionTemplateID') 
 BEGIN 
	Create NonClustered Index [IX_Newsletter_Newsletter_NewsletterUnsubscriptionTemplateID] On [dbo].[Newsletter_Newsletter] ([NewsletterUnsubscriptionTemplateID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Newsletter_Newsletter_NewsletterUnsubscriptionTemplateID') 
 BEGIN 
	DROP INDEX [IX_Newsletter_Newsletter_NewsletterUnsubscriptionTemplateID] On [dbo].[Newsletter_Newsletter];
END
-- 2073774445	Newsletter_Newsletter	7	IX_Newsletter_Newsletter_NewsletterOptInTemplateID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Newsletter_Newsletter_NewsletterOptInTemplateID') 
 BEGIN 
	Create NonClustered Index [IX_Newsletter_Newsletter_NewsletterOptInTemplateID] On [dbo].[Newsletter_Newsletter] ([NewsletterOptInTemplateID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Newsletter_Newsletter_NewsletterOptInTemplateID') 
 BEGIN 
	DROP INDEX [IX_Newsletter_Newsletter_NewsletterOptInTemplateID] On [dbo].[Newsletter_Newsletter];
END
-- 80719340	CMS_Class	1	IX_CMS_Class_ClassID_ClassName_ClassDisplayName	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_Class_ClassID_ClassName_ClassDisplayName') 
 BEGIN 
	Create Clustered Index [IX_CMS_Class_ClassID_ClassName_ClassDisplayName] On [dbo].[CMS_Class] ([ClassID] Asc,[ClassName] Asc,[ClassDisplayName] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_Class_ClassID_ClassName_ClassDisplayName') 
 BEGIN 
	DROP INDEX [IX_CMS_Class_ClassID_ClassName_ClassDisplayName] On [dbo].[CMS_Class];
END
-- 80719340	CMS_Class	4	IX_CMS_Class_ClassName_ClassGUID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_Class_ClassName_ClassGUID') 
 BEGIN 
	Create NonClustered Index [IX_CMS_Class_ClassName_ClassGUID] On [dbo].[CMS_Class] ([ClassName] Asc,[ClassGUID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_Class_ClassName_ClassGUID') 
 BEGIN 
	DROP INDEX [IX_CMS_Class_ClassName_ClassGUID] On [dbo].[CMS_Class];
END
-- 80719340	CMS_Class	5	IX_CMS_Class_ClassShowAsSystemTable_ClassIsCustomTable_ClassIsCoupledClass_ClassIsDocumentType	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_Class_ClassShowAsSystemTable_ClassIsCustomTable_ClassIsCoupledClass_ClassIsDocumentType') 
 BEGIN 
	Create NonClustered Index [IX_CMS_Class_ClassShowAsSystemTable_ClassIsCustomTable_ClassIsCoupledClass_ClassIsDocumentType] On [dbo].[CMS_Class] ([ClassShowAsSystemTable] Asc,[ClassIsCustomTable] Asc,[ClassIsCoupledClass] Asc,[ClassIsDocumentType] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_Class_ClassShowAsSystemTable_ClassIsCustomTable_ClassIsCoupledClass_ClassIsDocumentType') 
 BEGIN 
	DROP INDEX [IX_CMS_Class_ClassShowAsSystemTable_ClassIsCustomTable_ClassIsCoupledClass_ClassIsDocumentType] On [dbo].[CMS_Class];
END
-- 80719340	CMS_Class	7	IX_CMS_Class_ClassLoadGeneration	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_Class_ClassLoadGeneration') 
 BEGIN 
	Create NonClustered Index [IX_CMS_Class_ClassLoadGeneration] On [dbo].[CMS_Class] ([ClassLoadGeneration] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_Class_ClassLoadGeneration') 
 BEGIN 
	DROP INDEX [IX_CMS_Class_ClassLoadGeneration] On [dbo].[CMS_Class];
END
-- 81435364	HFit_RewardsUserActivityDetail	12	PI01_view_EDW_RewardUserDetail	
IF NOT Exists (Select name from sys.indexes where name = 'PI01_view_EDW_RewardUserDetail') 
 BEGIN 
	Create NonClustered Index [PI01_view_EDW_RewardUserDetail] On [dbo].[HFit_RewardsUserActivityDetail] ([ItemID] Asc,[ItemModifiedWhen] Asc,[ActivityVersionID] Asc,[ActivityCompletedDt] Asc,[ActivityPointsEarned] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 100, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'PI01_view_EDW_RewardUserDetail') 
 BEGIN 
	DROP INDEX [PI01_view_EDW_RewardUserDetail] On [dbo].[HFit_RewardsUserActivityDetail];
END
-- 81435364	HFit_RewardsUserActivityDetail	14	IDX_RewardsUserActivity_UserID	
IF NOT Exists (Select name from sys.indexes where name = 'IDX_RewardsUserActivity_UserID') 
 BEGIN 
	Create NonClustered Index [IDX_RewardsUserActivity_UserID] On [dbo].[HFit_RewardsUserActivityDetail] ([UserID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IDX_RewardsUserActivity_UserID') 
 BEGIN 
	DROP INDEX [IDX_RewardsUserActivity_UserID] On [dbo].[HFit_RewardsUserActivityDetail];
END
-- 1591676718	COM_OrderItem	3	IX_COM_OrderItem_OrderItemSKUID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_COM_OrderItem_OrderItemSKUID') 
 BEGIN 
	Create NonClustered Index [IX_COM_OrderItem_OrderItemSKUID] On [dbo].[COM_OrderItem] ([OrderItemSKUID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_COM_OrderItem_OrderItemSKUID') 
 BEGIN 
	DROP INDEX [IX_COM_OrderItem_OrderItemSKUID] On [dbo].[COM_OrderItem];
END
-- 1601544889	HFit_RewardsAwardUserDetail	14	idxHfitRewardsAwardUserDetail_CreateDate_PI	
IF NOT Exists (Select name from sys.indexes where name = 'idxHfitRewardsAwardUserDetail_CreateDate_PI') 
 BEGIN 
	Create NonClustered Index [idxHfitRewardsAwardUserDetail_CreateDate_PI] On [dbo].[HFit_RewardsAwardUserDetail] ([ItemCreatedWhen] Asc,[ItemModifiedWhen] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'idxHfitRewardsAwardUserDetail_CreateDate_PI') 
 BEGIN 
	DROP INDEX [idxHfitRewardsAwardUserDetail_CreateDate_PI] On [dbo].[HFit_RewardsAwardUserDetail];
END
-- 1781581385	CMS_UserSite	2	IX_CMS_UserSite_UserID_SiteID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_UserSite_UserID_SiteID') 
 BEGIN 
	Create Unique NonClustered Index [IX_CMS_UserSite_UserID_SiteID] On [dbo].[CMS_UserSite] ([UserID] Asc,[SiteID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_UserSite_UserID_SiteID') 
 BEGIN 
	DROP INDEX [IX_CMS_UserSite_UserID_SiteID] On [dbo].[CMS_UserSite];
END
-- 1781581385	CMS_UserSite	8	PI_CMS_UserSite_SiteID	
IF NOT Exists (Select name from sys.indexes where name = 'PI_CMS_UserSite_SiteID') 
 BEGIN 
	Create NonClustered Index [PI_CMS_UserSite_SiteID] On [dbo].[CMS_UserSite] ([SiteID] Asc) Include ([UserID])  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 100, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'PI_CMS_UserSite_SiteID') 
 BEGIN 
	DROP INDEX [PI_CMS_UserSite_SiteID] On [dbo].[CMS_UserSite];
END
-- 1783677402	COM_Customer	3	IX_COM_Customer_CustomerEmail	
IF NOT Exists (Select name from sys.indexes where name = 'IX_COM_Customer_CustomerEmail') 
 BEGIN 
	Create NonClustered Index [IX_COM_Customer_CustomerEmail] On [dbo].[COM_Customer] ([CustomerEmail] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_COM_Customer_CustomerEmail') 
 BEGIN 
	DROP INDEX [IX_COM_Customer_CustomerEmail] On [dbo].[COM_Customer];
END
-- 1783677402	COM_Customer	6	IX_COM_Customer_CustomerPreferredCurrencyID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_COM_Customer_CustomerPreferredCurrencyID') 
 BEGIN 
	Create NonClustered Index [IX_COM_Customer_CustomerPreferredCurrencyID] On [dbo].[COM_Customer] ([CustomerPreferredCurrencyID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_COM_Customer_CustomerPreferredCurrencyID') 
 BEGIN 
	DROP INDEX [IX_COM_Customer_CustomerPreferredCurrencyID] On [dbo].[COM_Customer];
END
-- 1783677402	COM_Customer	8	IX_COM_Customer_CustomerCountryID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_COM_Customer_CustomerCountryID') 
 BEGIN 
	Create NonClustered Index [IX_COM_Customer_CustomerCountryID] On [dbo].[COM_Customer] ([CustomerCountryID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_COM_Customer_CustomerCountryID') 
 BEGIN 
	DROP INDEX [IX_COM_Customer_CustomerCountryID] On [dbo].[COM_Customer];
END
-- 1783677402	COM_Customer	9	IX_COM_Customer_CustomerPrefferedPaymentOptionID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_COM_Customer_CustomerPrefferedPaymentOptionID') 
 BEGIN 
	Create NonClustered Index [IX_COM_Customer_CustomerPrefferedPaymentOptionID] On [dbo].[COM_Customer] ([CustomerPrefferedPaymentOptionID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_COM_Customer_CustomerPrefferedPaymentOptionID') 
 BEGIN 
	DROP INDEX [IX_COM_Customer_CustomerPrefferedPaymentOptionID] On [dbo].[COM_Customer];
END
-- 1783677402	COM_Customer	11	IX_COM_Customer_CustomerDiscountLevelID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_COM_Customer_CustomerDiscountLevelID') 
 BEGIN 
	Create NonClustered Index [IX_COM_Customer_CustomerDiscountLevelID] On [dbo].[COM_Customer] ([CustomerDiscountLevelID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_COM_Customer_CustomerDiscountLevelID') 
 BEGIN 
	DROP INDEX [IX_COM_Customer_CustomerDiscountLevelID] On [dbo].[COM_Customer];
END
-- 1794105432	CMS_AttachmentHistory	3	IX_CMS_AttachmentHistory_AttachmentGUID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_AttachmentHistory_AttachmentGUID') 
 BEGIN 
	Create NonClustered Index [IX_CMS_AttachmentHistory_AttachmentGUID] On [dbo].[CMS_AttachmentHistory] ([AttachmentGUID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_AttachmentHistory_AttachmentGUID') 
 BEGIN 
	DROP INDEX [IX_CMS_AttachmentHistory_AttachmentGUID] On [dbo].[CMS_AttachmentHistory];
END
-- 1798297466	CMS_Personalization	1	IX_CMS_Personalization_PersonalizationUserID_PersonalizationDocumentID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_Personalization_PersonalizationUserID_PersonalizationDocumentID') 
 BEGIN 
	Create Clustered Index [IX_CMS_Personalization_PersonalizationUserID_PersonalizationDocumentID] On [dbo].[CMS_Personalization] ([PersonalizationDocumentID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_Personalization_PersonalizationUserID_PersonalizationDocumentID') 
 BEGIN 
	DROP INDEX [IX_CMS_Personalization_PersonalizationUserID_PersonalizationDocumentID] On [dbo].[CMS_Personalization];
END
-- 1798297466	CMS_Personalization	4	IX_CMS_Personalization_PersonalizationSiteID_SiteID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_Personalization_PersonalizationSiteID_SiteID') 
 BEGIN 
	Create NonClustered Index [IX_CMS_Personalization_PersonalizationSiteID_SiteID] On [dbo].[CMS_Personalization] ([PersonalizationSiteID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_Personalization_PersonalizationSiteID_SiteID') 
 BEGIN 
	DROP INDEX [IX_CMS_Personalization_PersonalizationSiteID_SiteID] On [dbo].[CMS_Personalization];
END
-- 373576369	Analytics_WeekHits	1	IX_Analytics_WeekHits_HitsStartTime_HitsEndTime	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Analytics_WeekHits_HitsStartTime_HitsEndTime') 
 BEGIN 
	Create Clustered Index [IX_Analytics_WeekHits_HitsStartTime_HitsEndTime] On [dbo].[Analytics_WeekHits] ([HitsStartTime] Desc,[HitsEndTime] Desc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Analytics_WeekHits_HitsStartTime_HitsEndTime') 
 BEGIN 
	DROP INDEX [IX_Analytics_WeekHits_HitsStartTime_HitsEndTime] On [dbo].[Analytics_WeekHits];
END
-- 373576369	Analytics_WeekHits	3	IX_Analytics_WeekHits_HitsStatisticsID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Analytics_WeekHits_HitsStatisticsID') 
 BEGIN 
	Create NonClustered Index [IX_Analytics_WeekHits_HitsStatisticsID] On [dbo].[Analytics_WeekHits] ([HitsStatisticsID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Analytics_WeekHits_HitsStatisticsID') 
 BEGIN 
	DROP INDEX [IX_Analytics_WeekHits_HitsStatisticsID] On [dbo].[Analytics_WeekHits];
END
-- 400720480	CMS_FormUserControl	1	IX_CMS_FormUserControl_UserControlDisplayName	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_FormUserControl_UserControlDisplayName') 
 BEGIN 
	Create Clustered Index [IX_CMS_FormUserControl_UserControlDisplayName] On [dbo].[CMS_FormUserControl] ([UserControlDisplayName] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_FormUserControl_UserControlDisplayName') 
 BEGIN 
	DROP INDEX [IX_CMS_FormUserControl_UserControlDisplayName] On [dbo].[CMS_FormUserControl];
END
-- 400720480	CMS_FormUserControl	4	IX_CMS_FormUserControl_UserControlParentID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_FormUserControl_UserControlParentID') 
 BEGIN 
	Create NonClustered Index [IX_CMS_FormUserControl_UserControlParentID] On [dbo].[CMS_FormUserControl] ([UserControlParentID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_FormUserControl_UserControlParentID') 
 BEGIN 
	DROP INDEX [IX_CMS_FormUserControl_UserControlParentID] On [dbo].[CMS_FormUserControl];
END
-- 402100473	CMS_EventLog	1	IX_CMS_EventLog_EventTime	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_EventLog_EventTime') 
 BEGIN 
	Create Clustered Index [IX_CMS_EventLog_EventTime] On [dbo].[CMS_EventLog] ([EventTime] Desc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [pfDaily](EventTime);	
 END 
	pfDaily	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_EventLog_EventTime') 
 BEGIN 
	DROP INDEX [IX_CMS_EventLog_EventTime] On [dbo].[CMS_EventLog];
END
-- 405576483	Analytics_MonthHits	1	IX_Analytics_MonthHits_HitsStartTime_HitsEndTime	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Analytics_MonthHits_HitsStartTime_HitsEndTime') 
 BEGIN 
	Create Clustered Index [IX_Analytics_MonthHits_HitsStartTime_HitsEndTime] On [dbo].[Analytics_MonthHits] ([HitsStartTime] Desc,[HitsEndTime] Desc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Analytics_MonthHits_HitsStartTime_HitsEndTime') 
 BEGIN 
	DROP INDEX [IX_Analytics_MonthHits_HitsStartTime_HitsEndTime] On [dbo].[Analytics_MonthHits];
END
-- 1401772051	CMS_WebFarmTask	2	IX_CMS_WebFarmTask_TaskEnabled	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_WebFarmTask_TaskEnabled') 
 BEGIN 
	Create NonClustered Index [IX_CMS_WebFarmTask_TaskEnabled] On [dbo].[CMS_WebFarmTask] ([TaskEnabled] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_WebFarmTask_TaskEnabled') 
 BEGIN 
	DROP INDEX [IX_CMS_WebFarmTask_TaskEnabled] On [dbo].[CMS_WebFarmTask];
END
-- 884914224	CMS_WebPartContainer	1	IX_CMS_WebPartContainer_ContainerDisplayName	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_WebPartContainer_ContainerDisplayName') 
 BEGIN 
	Create Clustered Index [IX_CMS_WebPartContainer_ContainerDisplayName] On [dbo].[CMS_WebPartContainer] ([ContainerDisplayName] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_WebPartContainer_ContainerDisplayName') 
 BEGIN 
	DROP INDEX [IX_CMS_WebPartContainer_ContainerDisplayName] On [dbo].[CMS_WebPartContainer];
END
-- 884914224	CMS_WebPartContainer	3	IX_CMS_WebPartContainer_ContainerName	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_WebPartContainer_ContainerName') 
 BEGIN 
	Create NonClustered Index [IX_CMS_WebPartContainer_ContainerName] On [dbo].[CMS_WebPartContainer] ([ContainerName] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_WebPartContainer_ContainerName') 
 BEGIN 
	DROP INDEX [IX_CMS_WebPartContainer_ContainerName] On [dbo].[CMS_WebPartContainer];
END
-- 893962261	CMS_SearchTask	1	IX_CMS_SearchTask_SearchTaskPriority_SearchTaskStatus_SearchTaskServerName	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_SearchTask_SearchTaskPriority_SearchTaskStatus_SearchTaskServerName') 
 BEGIN 
	Create Clustered Index [IX_CMS_SearchTask_SearchTaskPriority_SearchTaskStatus_SearchTaskServerName] On [dbo].[CMS_SearchTask] ([SearchTaskPriority] Desc,[SearchTaskStatus] Asc,[SearchTaskServerName] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_SearchTask_SearchTaskPriority_SearchTaskStatus_SearchTaskServerName') 
 BEGIN 
	DROP INDEX [IX_CMS_SearchTask_SearchTaskPriority_SearchTaskStatus_SearchTaskServerName] On [dbo].[CMS_SearchTask];
END
-- 1654296953	Media_File	5	IX_Media_File_FileCreatedByUserID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Media_File_FileCreatedByUserID') 
 BEGIN 
	Create NonClustered Index [IX_Media_File_FileCreatedByUserID] On [dbo].[Media_File] ([FileCreatedByUserID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Media_File_FileCreatedByUserID') 
 BEGIN 
	DROP INDEX [IX_Media_File_FileCreatedByUserID] On [dbo].[Media_File];
END
-- 1662628966	CMS_SiteDomainAlias	2	IX_CMS_SiteDomainAlias_SiteDomainAliasName	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_SiteDomainAlias_SiteDomainAliasName') 
 BEGIN 
	Create NonClustered Index [IX_CMS_SiteDomainAlias_SiteDomainAliasName] On [dbo].[CMS_SiteDomainAlias] ([SiteDomainAliasName] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_SiteDomainAlias_SiteDomainAliasName') 
 BEGIN 
	DROP INDEX [IX_CMS_SiteDomainAlias_SiteDomainAliasName] On [dbo].[CMS_SiteDomainAlias];
END
-- 1662837186	HFit_TrackerHeight	15	idx_HFit_TrackerHeight_CreateDate	
IF NOT Exists (Select name from sys.indexes where name = 'idx_HFit_TrackerHeight_CreateDate') 
 BEGIN 
	Create NonClustered Index [idx_HFit_TrackerHeight_CreateDate] On [dbo].[HFit_TrackerHeight] ([ItemCreatedWhen] Asc,[ItemModifiedWhen] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'idx_HFit_TrackerHeight_CreateDate') 
 BEGIN 
	DROP INDEX [idx_HFit_TrackerHeight_CreateDate] On [dbo].[HFit_TrackerHeight];
END
-- 1663553210	CMS_EventLogArchive	5	CMS_EventLogArchive_idx_01	
IF NOT Exists (Select name from sys.indexes where name = 'CMS_EventLogArchive_idx_01') 
 BEGIN 
	Create NonClustered Index [CMS_EventLogArchive_idx_01] On [dbo].[CMS_EventLogArchive] ([EventTime] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'CMS_EventLogArchive_idx_01') 
 BEGIN 
	DROP INDEX [CMS_EventLogArchive_idx_01] On [dbo].[CMS_EventLogArchive];
END
-- 1669580986	OM_Account	3	IX_OM_Account_AccountCountryID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_OM_Account_AccountCountryID') 
 BEGIN 
	Create NonClustered Index [IX_OM_Account_AccountCountryID] On [dbo].[OM_Account] ([AccountCountryID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_OM_Account_AccountCountryID') 
 BEGIN 
	DROP INDEX [IX_OM_Account_AccountCountryID] On [dbo].[OM_Account];
END
-- 1669580986	OM_Account	4	IX_OM_Account_AccountPrimaryContactID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_OM_Account_AccountPrimaryContactID') 
 BEGIN 
	Create NonClustered Index [IX_OM_Account_AccountPrimaryContactID] On [dbo].[OM_Account] ([AccountPrimaryContactID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_OM_Account_AccountPrimaryContactID') 
 BEGIN 
	DROP INDEX [IX_OM_Account_AccountPrimaryContactID] On [dbo].[OM_Account];
END
-- 1669580986	OM_Account	6	IX_OM_Account_AccountStatusID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_OM_Account_AccountStatusID') 
 BEGIN 
	Create NonClustered Index [IX_OM_Account_AccountStatusID] On [dbo].[OM_Account] ([AccountStatusID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_OM_Account_AccountStatusID') 
 BEGIN 
	DROP INDEX [IX_OM_Account_AccountStatusID] On [dbo].[OM_Account];
END
-- 1669580986	OM_Account	7	IX_OM_Account_AccountOwnerUserID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_OM_Account_AccountOwnerUserID') 
 BEGIN 
	Create NonClustered Index [IX_OM_Account_AccountOwnerUserID] On [dbo].[OM_Account] ([AccountOwnerUserID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_OM_Account_AccountOwnerUserID') 
 BEGIN 
	DROP INDEX [IX_OM_Account_AccountOwnerUserID] On [dbo].[OM_Account];
END
-- 1669580986	OM_Account	9	IX_OM_Account_AccountMergedWithAccountID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_OM_Account_AccountMergedWithAccountID') 
 BEGIN 
	Create NonClustered Index [IX_OM_Account_AccountMergedWithAccountID] On [dbo].[OM_Account] ([AccountMergedWithAccountID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_OM_Account_AccountMergedWithAccountID') 
 BEGIN 
	DROP INDEX [IX_OM_Account_AccountMergedWithAccountID] On [dbo].[OM_Account];
END
-- 626101271	CMS_UICulture	1	IX_CMS_UICulture_UICultureName	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_UICulture_UICultureName') 
 BEGIN 
	Create Clustered Index [IX_CMS_UICulture_UICultureName] On [dbo].[CMS_UICulture] ([UICultureName] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_UICulture_UICultureName') 
 BEGIN 
	DROP INDEX [IX_CMS_UICulture_UICultureName] On [dbo].[CMS_UICulture];
END
-- 629577281	Events_Attendee	3	IX_Events_Attendee_AttendeeEventNodeID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Events_Attendee_AttendeeEventNodeID') 
 BEGIN 
	Create NonClustered Index [IX_Events_Attendee_AttendeeEventNodeID] On [dbo].[Events_Attendee] ([AttendeeEventNodeID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Events_Attendee_AttendeeEventNodeID') 
 BEGIN 
	DROP INDEX [IX_Events_Attendee_AttendeeEventNodeID] On [dbo].[Events_Attendee];
END
-- 631673298	Polls_PollAnswer	1	IX_Polls_PollAnswer_AnswerPollID_AnswerOrder_AnswerEnabled	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Polls_PollAnswer_AnswerPollID_AnswerOrder_AnswerEnabled') 
 BEGIN 
	Create Clustered Index [IX_Polls_PollAnswer_AnswerPollID_AnswerOrder_AnswerEnabled] On [dbo].[Polls_PollAnswer] ([AnswerOrder] Asc,[AnswerPollID] Asc,[AnswerEnabled] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Polls_PollAnswer_AnswerPollID_AnswerOrder_AnswerEnabled') 
 BEGIN 
	DROP INDEX [IX_Polls_PollAnswer_AnswerPollID_AnswerOrder_AnswerEnabled] On [dbo].[Polls_PollAnswer];
END
-- 1085246921	CMS_WorkflowScope	1	IX_CMS_WorkflowScope_ScopeStartingPath	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_WorkflowScope_ScopeStartingPath') 
 BEGIN 
	Create Clustered Index [IX_CMS_WorkflowScope_ScopeStartingPath] On [dbo].[CMS_WorkflowScope] ([ScopeStartingPath] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_WorkflowScope_ScopeStartingPath') 
 BEGIN 
	DROP INDEX [IX_CMS_WorkflowScope_ScopeStartingPath] On [dbo].[CMS_WorkflowScope];
END
-- 1085246921	CMS_WorkflowScope	4	IX_CMS_WorkflowScope_ScopeClassID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_WorkflowScope_ScopeClassID') 
 BEGIN 
	Create NonClustered Index [IX_CMS_WorkflowScope_ScopeClassID] On [dbo].[CMS_WorkflowScope] ([ScopeClassID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_WorkflowScope_ScopeClassID') 
 BEGIN 
	DROP INDEX [IX_CMS_WorkflowScope_ScopeClassID] On [dbo].[CMS_WorkflowScope];
END
-- 1090818948	CMS_Form	1	IX_CMS_Form_FormDisplayName	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_Form_FormDisplayName') 
 BEGIN 
	Create Clustered Index [IX_CMS_Form_FormDisplayName] On [dbo].[CMS_Form] ([FormDisplayName] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_Form_FormDisplayName') 
 BEGIN 
	DROP INDEX [IX_CMS_Form_FormDisplayName] On [dbo].[CMS_Form];
END
-- 1090818948	CMS_Form	4	IX_CMS_Form_FormSiteID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_Form_FormSiteID') 
 BEGIN 
	Create NonClustered Index [IX_CMS_Form_FormSiteID] On [dbo].[CMS_Form] ([FormSiteID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_Form_FormSiteID') 
 BEGIN 
	DROP INDEX [IX_CMS_Form_FormSiteID] On [dbo].[CMS_Form];
END
-- 1095635642	SchemaMonitorObjectNotify	1	PCI_SchemaMonitorObjectNotify	
IF NOT Exists (Select name from sys.indexes where name = 'PCI_SchemaMonitorObjectNotify') 
 BEGIN 
	Create Unique Clustered Index [PCI_SchemaMonitorObjectNotify] On [dbo].[SchemaMonitorObjectNotify] ([EmailAddr] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 100, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'PCI_SchemaMonitorObjectNotify') 
 BEGIN 
	DROP INDEX [PCI_SchemaMonitorObjectNotify] On [dbo].[SchemaMonitorObjectNotify];
END
-- 1102626971	CMS_Culture	1	IX_CMS_Culture_CultureName	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_Culture_CultureName') 
 BEGIN 
	Create Clustered Index [IX_CMS_Culture_CultureName] On [dbo].[CMS_Culture] ([CultureName] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_Culture_CultureName') 
 BEGIN 
	DROP INDEX [IX_CMS_Culture_CultureName] On [dbo].[CMS_Culture];
END
-- 1102626971	CMS_Culture	4	IX_CMS_CulturAlias	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_CulturAlias') 
 BEGIN 
	Create NonClustered Index [IX_CMS_CulturAlias] On [dbo].[CMS_Culture] ([CultureAlias] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_CulturAlias') 
 BEGIN 
	DROP INDEX [IX_CMS_CulturAlias] On [dbo].[CMS_Culture];
END
-- 1106102981	CMS_WidgetCategory	1	IX_CMS_WidgetCategory_CategoryPath	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_WidgetCategory_CategoryPath') 
 BEGIN 
	Create Unique Clustered Index [IX_CMS_WidgetCategory_CategoryPath] On [dbo].[CMS_WidgetCategory] ([WidgetCategoryPath] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_WidgetCategory_CategoryPath') 
 BEGIN 
	DROP INDEX [IX_CMS_WidgetCategory_CategoryPath] On [dbo].[CMS_WidgetCategory];
END
-- 881438214	HFit_TrackerBodyFat	9	idx_HFit_TrackerBodyFat_CreateDate	
IF NOT Exists (Select name from sys.indexes where name = 'idx_HFit_TrackerBodyFat_CreateDate') 
 BEGIN 
	Create NonClustered Index [idx_HFit_TrackerBodyFat_CreateDate] On [dbo].[HFit_TrackerBodyFat] ([ItemCreatedWhen] Asc,[ItemModifiedWhen] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'idx_HFit_TrackerBodyFat_CreateDate') 
 BEGIN 
	DROP INDEX [idx_HFit_TrackerBodyFat_CreateDate] On [dbo].[HFit_TrackerBodyFat];
END
-- 121767491	Staging_Task	4	IX_Staging_Task_TaskDocumentID_TaskNodeID_TaskRunning	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Staging_Task_TaskDocumentID_TaskNodeID_TaskRunning') 
 BEGIN 
	Create NonClustered Index [IX_Staging_Task_TaskDocumentID_TaskNodeID_TaskRunning] On [dbo].[Staging_Task] ([TaskDocumentID] Asc,[TaskNodeID] Asc,[TaskRunning] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Staging_Task_TaskDocumentID_TaskNodeID_TaskRunning') 
 BEGIN 
	DROP INDEX [IX_Staging_Task_TaskDocumentID_TaskNodeID_TaskRunning] On [dbo].[Staging_Task];
END
-- 121767491	Staging_Task	5	IX_Staging_Task_TaskType	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Staging_Task_TaskType') 
 BEGIN 
	Create NonClustered Index [IX_Staging_Task_TaskType] On [dbo].[Staging_Task] ([TaskType] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Staging_Task_TaskType') 
 BEGIN 
	DROP INDEX [IX_Staging_Task_TaskType] On [dbo].[Staging_Task];
END
-- 125243501	OM_AccountContact	2	IX_OM_AccountContact_ContactRoleID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_OM_AccountContact_ContactRoleID') 
 BEGIN 
	Create NonClustered Index [IX_OM_AccountContact_ContactRoleID] On [dbo].[OM_AccountContact] ([ContactRoleID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 100, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_OM_AccountContact_ContactRoleID') 
 BEGIN 
	DROP INDEX [IX_OM_AccountContact_ContactRoleID] On [dbo].[OM_AccountContact];
END
-- 139863565	COM_OptionCategory	1	IX_COM_OptionCategory_CategoryDisplayName_CategoryEnabled	
IF NOT Exists (Select name from sys.indexes where name = 'IX_COM_OptionCategory_CategoryDisplayName_CategoryEnabled') 
 BEGIN 
	Create Clustered Index [IX_COM_OptionCategory_CategoryDisplayName_CategoryEnabled] On [dbo].[COM_OptionCategory] ([CategoryDisplayName] Asc,[CategoryEnabled] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_COM_OptionCategory_CategoryDisplayName_CategoryEnabled') 
 BEGIN 
	DROP INDEX [IX_COM_OptionCategory_CategoryDisplayName_CategoryEnabled] On [dbo].[COM_OptionCategory];
END
-- 142623551	CMS_Tag	1	IX_CMS_Tag_TagName	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_Tag_TagName') 
 BEGIN 
	Create Clustered Index [IX_CMS_Tag_TagName] On [dbo].[CMS_Tag] ([TagName] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_Tag_TagName') 
 BEGIN 
	DROP INDEX [IX_CMS_Tag_TagName] On [dbo].[CMS_Tag];
END
-- 143339575	HFit_HealthAssesmentUserQuestion	15	HFit_HealthAssesmentUserQuestion_HARiskAreaItemID_PI	
IF NOT Exists (Select name from sys.indexes where name = 'HFit_HealthAssesmentUserQuestion_HARiskAreaItemID_PI') 
 BEGIN 
	Create NonClustered Index [HFit_HealthAssesmentUserQuestion_HARiskAreaItemID_PI] On [dbo].[HFit_HealthAssesmentUserQuestion] ([HARiskAreaItemID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 100, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'HFit_HealthAssesmentUserQuestion_HARiskAreaItemID_PI') 
 BEGIN 
	DROP INDEX [HFit_HealthAssesmentUserQuestion_HARiskAreaItemID_PI] On [dbo].[HFit_HealthAssesmentUserQuestion];
END
-- 143339575	HFit_HealthAssesmentUserQuestion	17	nonItemIDHARiskAreaItemID	
IF NOT Exists (Select name from sys.indexes where name = 'nonItemIDHARiskAreaItemID') 
 BEGIN 
	Create NonClustered Index [nonItemIDHARiskAreaItemID] On [dbo].[HFit_HealthAssesmentUserQuestion] ([ItemID] Asc,[HARiskAreaItemID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 100, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'nonItemIDHARiskAreaItemID') 
 BEGIN 
	DROP INDEX [nonItemIDHARiskAreaItemID] On [dbo].[HFit_HealthAssesmentUserQuestion];
END
-- 146099561	CMS_ResourceTranslation	2	IX_CMS_ResourceTranslation_TranslationStringID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_ResourceTranslation_TranslationStringID') 
 BEGIN 
	Create NonClustered Index [IX_CMS_ResourceTranslation_TranslationStringID] On [dbo].[CMS_ResourceTranslation] ([TranslationStringID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_ResourceTranslation_TranslationStringID') 
 BEGIN 
	DROP INDEX [IX_CMS_ResourceTranslation_TranslationStringID] On [dbo].[CMS_ResourceTranslation];
END
-- 1858105660	Integration_Task	3	IX_Integration_Task_TaskType	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Integration_Task_TaskType') 
 BEGIN 
	Create NonClustered Index [IX_Integration_Task_TaskType] On [dbo].[Integration_Task] ([TaskType] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Integration_Task_TaskType') 
 BEGIN 
	DROP INDEX [IX_Integration_Task_TaskType] On [dbo].[Integration_Task];
END
-- 1862297694	CMS_OpenIDUser	2	IX_CMS_OpenIDUser_OpenID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_OpenIDUser_OpenID') 
 BEGIN 
	Create NonClustered Index [IX_CMS_OpenIDUser_OpenID] On [dbo].[CMS_OpenIDUser] ([OpenID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_OpenIDUser_OpenID') 
 BEGIN 
	DROP INDEX [IX_CMS_OpenIDUser_OpenID] On [dbo].[CMS_OpenIDUser];
END
-- 1872725724	CMS_WorkflowTransition	2	IX_CMS_WorkflowTransition_TransitionStartStepID_TransitionSourcePointGUID_TransitionEndStepID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_WorkflowTransition_TransitionStartStepID_TransitionSourcePointGUID_TransitionEndStepID') 
 BEGIN 
	Create Unique NonClustered Index [IX_CMS_WorkflowTransition_TransitionStartStepID_TransitionSourcePointGUID_TransitionEndStepID] On [dbo].[CMS_WorkflowTransition] ([TransitionStartStepID] Asc,[TransitionSourcePointGUID] Asc,[TransitionEndStepID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_WorkflowTransition_TransitionStartStepID_TransitionSourcePointGUID_TransitionEndStepID') 
 BEGIN 
	DROP INDEX [IX_CMS_WorkflowTransition_TransitionStartStepID_TransitionSourcePointGUID_TransitionEndStepID] On [dbo].[CMS_WorkflowTransition];
END
-- 70291310	View_CMS_Tree_Joined_Regular	122	pi_CMS_Tree_Joined_Regular_NodeGUID	
IF NOT Exists (Select name from sys.indexes where name = 'pi_CMS_Tree_Joined_Regular_NodeGUID') 
 BEGIN 
	Create NonClustered Index [pi_CMS_Tree_Joined_Regular_NodeGUID] On [dbo].[View_CMS_Tree_Joined_Regular] ([NodeGUID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 100, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'pi_CMS_Tree_Joined_Regular_NodeGUID') 
 BEGIN 
	DROP INDEX [pi_CMS_Tree_Joined_Regular_NodeGUID] On [dbo].[View_CMS_Tree_Joined_Regular];
END
-- 791673868	Community_Group	1	IX_Community_Group_GroupDisplayName	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Community_Group_GroupDisplayName') 
 BEGIN 
	Create Clustered Index [IX_Community_Group_GroupDisplayName] On [dbo].[Community_Group] ([GroupSiteID] Asc,[GroupDisplayName] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Community_Group_GroupDisplayName') 
 BEGIN 
	DROP INDEX [IX_Community_Group_GroupDisplayName] On [dbo].[Community_Group];
END
-- 791673868	Community_Group	4	IX_Community_Group_GroupCreatedByUserID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Community_Group_GroupCreatedByUserID') 
 BEGIN 
	Create NonClustered Index [IX_Community_Group_GroupCreatedByUserID] On [dbo].[Community_Group] ([GroupCreatedByUserID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Community_Group_GroupCreatedByUserID') 
 BEGIN 
	DROP INDEX [IX_Community_Group_GroupCreatedByUserID] On [dbo].[Community_Group];
END
-- 791673868	Community_Group	6	IX_Community_Group_GroupAvatarID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Community_Group_GroupAvatarID') 
 BEGIN 
	Create NonClustered Index [IX_Community_Group_GroupAvatarID] On [dbo].[Community_Group] ([GroupAvatarID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Community_Group_GroupAvatarID') 
 BEGIN 
	DROP INDEX [IX_Community_Group_GroupAvatarID] On [dbo].[Community_Group];
END
-- 791673868	Community_Group	7	IX_Community_Group_GroupApproved	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Community_Group_GroupApproved') 
 BEGIN 
	Create NonClustered Index [IX_Community_Group_GroupApproved] On [dbo].[Community_Group] ([GroupApproved] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Community_Group_GroupApproved') 
 BEGIN 
	DROP INDEX [IX_Community_Group_GroupApproved] On [dbo].[Community_Group];
END
-- 793769885	Reporting_ReportSubscription	2	IX_Reporting_ReportSubscription_ReportSubscriptionReportID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Reporting_ReportSubscription_ReportSubscriptionReportID') 
 BEGIN 
	Create NonClustered Index [IX_Reporting_ReportSubscription_ReportSubscriptionReportID] On [dbo].[Reporting_ReportSubscription] ([ReportSubscriptionReportID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Reporting_ReportSubscription_ReportSubscriptionReportID') 
 BEGIN 
	DROP INDEX [IX_Reporting_ReportSubscription_ReportSubscriptionReportID] On [dbo].[Reporting_ReportSubscription];
END
-- 793769885	Reporting_ReportSubscription	4	IX_Reporting_ReportSubscription_ReportSubscriptionTableID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Reporting_ReportSubscription_ReportSubscriptionTableID') 
 BEGIN 
	Create NonClustered Index [IX_Reporting_ReportSubscription_ReportSubscriptionTableID] On [dbo].[Reporting_ReportSubscription] ([ReportSubscriptionTableID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Reporting_ReportSubscription_ReportSubscriptionTableID') 
 BEGIN 
	DROP INDEX [IX_Reporting_ReportSubscription_ReportSubscriptionTableID] On [dbo].[Reporting_ReportSubscription];
END
-- 2095346529	OM_ContactStatus	2	IX_OM_ContactStatus_ContactStatusSiteID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_OM_ContactStatus_ContactStatusSiteID') 
 BEGIN 
	Create NonClustered Index [IX_OM_ContactStatus_ContactStatusSiteID] On [dbo].[OM_ContactStatus] ([ContactStatusSiteID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 100, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_OM_ContactStatus_ContactStatusSiteID') 
 BEGIN 
	DROP INDEX [IX_OM_ContactStatus_ContactStatusSiteID] On [dbo].[OM_ContactStatus];
END
-- 2103678542	CMS_User	3	IX_CMS_User_FullName	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_User_FullName') 
 BEGIN 
	Create NonClustered Index [IX_CMS_User_FullName] On [dbo].[CMS_User] ([FullName] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_User_FullName') 
 BEGIN 
	DROP INDEX [IX_CMS_User_FullName] On [dbo].[CMS_User];
END
-- 2103678542	CMS_User	5	IX_CMS_User_UserEnabled_UserIsHidden	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_User_UserEnabled_UserIsHidden') 
 BEGIN 
	Create NonClustered Index [IX_CMS_User_UserEnabled_UserIsHidden] On [dbo].[CMS_User] ([UserEnabled] Asc,[UserIsHidden] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_User_UserEnabled_UserIsHidden') 
 BEGIN 
	DROP INDEX [IX_CMS_User_UserEnabled_UserIsHidden] On [dbo].[CMS_User];
END
-- 2103678542	CMS_User	6	IX_CMS_User_UserIsEditor	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_User_UserIsEditor') 
 BEGIN 
	Create NonClustered Index [IX_CMS_User_UserIsEditor] On [dbo].[CMS_User] ([UserIsEditor] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_User_UserIsEditor') 
 BEGIN 
	DROP INDEX [IX_CMS_User_UserIsEditor] On [dbo].[CMS_User];
END
-- 2103678542	CMS_User	8	IX_CMS_User_UserGUID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_User_UserGUID') 
 BEGIN 
	Create Unique NonClustered Index [IX_CMS_User_UserGUID] On [dbo].[CMS_User] ([UserGUID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_User_UserGUID') 
 BEGIN 
	DROP INDEX [IX_CMS_User_UserGUID] On [dbo].[CMS_User];
END
-- 1143675122	Board_Message	4	IX_Board_Message_MessageBoardID_MessageGUID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Board_Message_MessageBoardID_MessageGUID') 
 BEGIN 
	Create Unique NonClustered Index [IX_Board_Message_MessageBoardID_MessageGUID] On [dbo].[Board_Message] ([MessageBoardID] Asc,[MessageGUID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Board_Message_MessageBoardID_MessageGUID') 
 BEGIN 
	DROP INDEX [IX_Board_Message_MessageBoardID_MessageGUID] On [dbo].[Board_Message];
END
-- 1157579162	COM_TaxClassState	2	IX_COM_TaxClassState_TaxClassID_StateID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_COM_TaxClassState_TaxClassID_StateID') 
 BEGIN 
	Create Unique NonClustered Index [IX_COM_TaxClassState_TaxClassID_StateID] On [dbo].[COM_TaxClassState] ([TaxClassID] Asc,[StateID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_COM_TaxClassState_TaxClassID_StateID') 
 BEGIN 
	DROP INDEX [IX_COM_TaxClassState_TaxClassID_StateID] On [dbo].[COM_TaxClassState];
END
-- 1170819233	CMS_AlternativeForm	3	IX_CMS_AlternativeForm_FormCoupledClassID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_AlternativeForm_FormCoupledClassID') 
 BEGIN 
	Create NonClustered Index [IX_CMS_AlternativeForm_FormCoupledClassID] On [dbo].[CMS_AlternativeForm] ([FormCoupledClassID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_AlternativeForm_FormCoupledClassID') 
 BEGIN 
	DROP INDEX [IX_CMS_AlternativeForm_FormCoupledClassID] On [dbo].[CMS_AlternativeForm];
END
-- 690257664	HFit_TrackerBMI	14	idx_HFit_TrackerBMI_CreateDate	
IF NOT Exists (Select name from sys.indexes where name = 'idx_HFit_TrackerBMI_CreateDate') 
 BEGIN 
	Create NonClustered Index [idx_HFit_TrackerBMI_CreateDate] On [dbo].[HFit_TrackerBMI] ([ItemCreatedWhen] Asc,[ItemModifiedWhen] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'idx_HFit_TrackerBMI_CreateDate') 
 BEGIN 
	DROP INDEX [idx_HFit_TrackerBMI_CreateDate] On [dbo].[HFit_TrackerBMI];
END
-- 699865560	Chat_Message	3	IX_Chat_Message_ChatMessageLastModified	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Chat_Message_ChatMessageLastModified') 
 BEGIN 
	Create NonClustered Index [IX_Chat_Message_ChatMessageLastModified] On [dbo].[Chat_Message] ([ChatMessageLastModified] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Chat_Message_ChatMessageLastModified') 
 BEGIN 
	DROP INDEX [IX_Chat_Message_ChatMessageLastModified] On [dbo].[Chat_Message];
END
-- 699865560	Chat_Message	4	IX_Chat_Message_ChatMessageSystemMessageType	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Chat_Message_ChatMessageSystemMessageType') 
 BEGIN 
	Create NonClustered Index [IX_Chat_Message_ChatMessageSystemMessageType] On [dbo].[Chat_Message] ([ChatMessageSystemMessageType] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Chat_Message_ChatMessageSystemMessageType') 
 BEGIN 
	DROP INDEX [IX_Chat_Message_ChatMessageSystemMessageType] On [dbo].[Chat_Message];
END
-- 702625546	Messaging_Message	1	IX_Messaging_Message_MessageRecipientUserID_MessageSent_MessageRecipientDeleted	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Messaging_Message_MessageRecipientUserID_MessageSent_MessageRecipientDeleted') 
 BEGIN 
	Create Clustered Index [IX_Messaging_Message_MessageRecipientUserID_MessageSent_MessageRecipientDeleted] On [dbo].[Messaging_Message] ([MessageRecipientUserID] Asc,[MessageSent] Desc,[MessageRecipientDeleted] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Messaging_Message_MessageRecipientUserID_MessageSent_MessageRecipientDeleted') 
 BEGIN 
	DROP INDEX [IX_Messaging_Message_MessageRecipientUserID_MessageSent_MessageRecipientDeleted] On [dbo].[Messaging_Message];
END
-- 1355151873	CMS_SettingsCategory	1	IX_CMS_SettingsCategory_CategoryOrder	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_SettingsCategory_CategoryOrder') 
 BEGIN 
	Create Clustered Index [IX_CMS_SettingsCategory_CategoryOrder] On [dbo].[CMS_SettingsCategory] ([CategoryOrder] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_SettingsCategory_CategoryOrder') 
 BEGIN 
	DROP INDEX [IX_CMS_SettingsCategory_CategoryOrder] On [dbo].[CMS_SettingsCategory];
END
-- 1002798980	HFit_HealthAssessmentImportStagingDetail	10	IX_HFit_HealthAssessmentImportStagingDetail_1	
IF NOT Exists (Select name from sys.indexes where name = 'IX_HFit_HealthAssessmentImportStagingDetail_1') 
 BEGIN 
	Create NonClustered Index [IX_HFit_HealthAssessmentImportStagingDetail_1] On [dbo].[HFit_HealthAssessmentImportStagingDetail] ([MasterID] Asc,[CodeNameType] Asc) Include ([QuestionCodeName],[AnswerValue],[AnswerCodeName],[IsProfessionallyCollected],[Timestamp])  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 100, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_HFit_HealthAssessmentImportStagingDetail_1') 
 BEGIN 
	DROP INDEX [IX_HFit_HealthAssessmentImportStagingDetail_1] On [dbo].[HFit_HealthAssessmentImportStagingDetail];
END
-- 1492200366	CMS_ResourceString	3	IX_CMS_ResourceString_StringKey	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_ResourceString_StringKey') 
 BEGIN 
	Create NonClustered Index [IX_CMS_ResourceString_StringKey] On [dbo].[CMS_ResourceString] ([StringKey] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_ResourceString_StringKey') 
 BEGIN 
	DROP INDEX [IX_CMS_ResourceString_StringKey] On [dbo].[CMS_ResourceString];
END
-- 1492916390	HFit_TrackerCholesterol	19	idx_HFit_TrackerCholesterol_CreateDate	
IF NOT Exists (Select name from sys.indexes where name = 'idx_HFit_TrackerCholesterol_CreateDate') 
 BEGIN 
	Create NonClustered Index [idx_HFit_TrackerCholesterol_CreateDate] On [dbo].[HFit_TrackerCholesterol] ([ItemCreatedWhen] Asc,[ItemModifiedWhen] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'idx_HFit_TrackerCholesterol_CreateDate') 
 BEGIN 
	DROP INDEX [idx_HFit_TrackerCholesterol_CreateDate] On [dbo].[HFit_TrackerCholesterol];
END
-- 1803869493	HFit_TipOfTheDay	7	nonActiveTip	
IF NOT Exists (Select name from sys.indexes where name = 'nonActiveTip') 
 BEGIN 
	Create NonClustered Index [nonActiveTip] On [dbo].[HFit_TipOfTheDay] ([Active] Asc,[TipOfTheDayCategoryID] Asc,[TipOfTheDayID] Asc) Include ([Details],[Source],[Title])  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'nonActiveTip') 
 BEGIN 
	DROP INDEX [nonActiveTip] On [dbo].[HFit_TipOfTheDay];
END
-- 1826105546	CMS_Attachment	3	IX_CMS_Attachment_AttachmentGUID_AttachmentSiteID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_Attachment_AttachmentGUID_AttachmentSiteID') 
 BEGIN 
	Create NonClustered Index [IX_CMS_Attachment_AttachmentGUID_AttachmentSiteID] On [dbo].[CMS_Attachment] ([AttachmentGUID] Asc,[AttachmentSiteID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_Attachment_AttachmentGUID_AttachmentSiteID') 
 BEGIN 
	DROP INDEX [IX_CMS_Attachment_AttachmentGUID_AttachmentSiteID] On [dbo].[CMS_Attachment];
END
-- 103671417	CMS_Session	4	IX_CMS_Session_SessionSiteID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_Session_SessionSiteID') 
 BEGIN 
	Create NonClustered Index [IX_CMS_Session_SessionSiteID] On [dbo].[CMS_Session] ([SessionSiteID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_Session_SessionSiteID') 
 BEGIN 
	DROP INDEX [IX_CMS_Session_SessionSiteID] On [dbo].[CMS_Session];
END
-- 103671417	CMS_Session	5	IX_CMS_Session_SessionUserIsHidden	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_Session_SessionUserIsHidden') 
 BEGIN 
	Create NonClustered Index [IX_CMS_Session_SessionUserIsHidden] On [dbo].[CMS_Session] ([SessionUserIsHidden] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_Session_SessionUserIsHidden') 
 BEGIN 
	DROP INDEX [IX_CMS_Session_SessionUserIsHidden] On [dbo].[CMS_Session];
END
-- 107147427	CMS_TagGroup	1	IX_CMS_TagGroup_TagGroupDisplayName	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_TagGroup_TagGroupDisplayName') 
 BEGIN 
	Create Clustered Index [IX_CMS_TagGroup_TagGroupDisplayName] On [dbo].[CMS_TagGroup] ([TagGroupDisplayName] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_TagGroup_TagGroupDisplayName') 
 BEGIN 
	DROP INDEX [IX_CMS_TagGroup_TagGroupDisplayName] On [dbo].[CMS_TagGroup];
END
-- 113747808	lsn_time_mapping	2	lsn_time_mapping_nonunique_idx	
IF NOT Exists (Select name from sys.indexes where name = 'lsn_time_mapping_nonunique_idx') 
 BEGIN 
	Create NonClustered Index [lsn_time_mapping_nonunique_idx] On [cdc].[lsn_time_mapping] ([tran_end_time] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'lsn_time_mapping_nonunique_idx') 
 BEGIN 
	DROP INDEX [lsn_time_mapping_nonunique_idx] On [cdc].[lsn_time_mapping];
END
-- 114099447	COM_OrderStatusUser	1	IX_COM_OrderStatusUser_OrderID_Date	
IF NOT Exists (Select name from sys.indexes where name = 'IX_COM_OrderStatusUser_OrderID_Date') 
 BEGIN 
	Create Clustered Index [IX_COM_OrderStatusUser_OrderID_Date] On [dbo].[COM_OrderStatusUser] ([OrderID] Asc,[Date] Desc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_COM_OrderStatusUser_OrderID_Date') 
 BEGIN 
	DROP INDEX [IX_COM_OrderStatusUser_OrderID_Date] On [dbo].[COM_OrderStatusUser];
END
-- 114099447	COM_OrderStatusUser	3	IX_COM_OrderStatusUser_FromStatusID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_COM_OrderStatusUser_FromStatusID') 
 BEGIN 
	Create NonClustered Index [IX_COM_OrderStatusUser_FromStatusID] On [dbo].[COM_OrderStatusUser] ([FromStatusID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_COM_OrderStatusUser_FromStatusID') 
 BEGIN 
	DROP INDEX [IX_COM_OrderStatusUser_FromStatusID] On [dbo].[COM_OrderStatusUser];
END
-- 114099447	COM_OrderStatusUser	4	IX_COM_OrderStatusUser_ToStatusID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_COM_OrderStatusUser_ToStatusID') 
 BEGIN 
	Create NonClustered Index [IX_COM_OrderStatusUser_ToStatusID] On [dbo].[COM_OrderStatusUser] ([ToStatusID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_COM_OrderStatusUser_ToStatusID') 
 BEGIN 
	DROP INDEX [IX_COM_OrderStatusUser_ToStatusID] On [dbo].[COM_OrderStatusUser];
END
-- 116195464	CMS_State	1	IX_CMS_State_CountryID_StateDisplayName	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_State_CountryID_StateDisplayName') 
 BEGIN 
	Create Clustered Index [IX_CMS_State_CountryID_StateDisplayName] On [dbo].[CMS_State] ([StateDisplayName] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_State_CountryID_StateDisplayName') 
 BEGIN 
	DROP INDEX [IX_CMS_State_CountryID_StateDisplayName] On [dbo].[CMS_State];
END
-- 121767491	Staging_Task	1	IX_Staging_Task_TaskNodeAliasPath	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Staging_Task_TaskNodeAliasPath') 
 BEGIN 
	Create Clustered Index [IX_Staging_Task_TaskNodeAliasPath] On [dbo].[Staging_Task] ([TaskNodeAliasPath] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Staging_Task_TaskNodeAliasPath') 
 BEGIN 
	DROP INDEX [IX_Staging_Task_TaskNodeAliasPath] On [dbo].[Staging_Task];
END
-- 265820059	HFit_TrackerStressManagement	5	idx_HFit_TrackerStressManagement_CreateDate	
IF NOT Exists (Select name from sys.indexes where name = 'idx_HFit_TrackerStressManagement_CreateDate') 
 BEGIN 
	Create NonClustered Index [idx_HFit_TrackerStressManagement_CreateDate] On [dbo].[HFit_TrackerStressManagement] ([ItemCreatedWhen] Asc,[ItemModifiedWhen] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'idx_HFit_TrackerStressManagement_CreateDate') 
 BEGIN 
	DROP INDEX [idx_HFit_TrackerStressManagement_CreateDate] On [dbo].[HFit_TrackerStressManagement];
END
-- 276196034	CMS_Country	1	IX_CMS_Country_CountryDisplayName	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_Country_CountryDisplayName') 
 BEGIN 
	Create Clustered Index [IX_CMS_Country_CountryDisplayName] On [dbo].[CMS_Country] ([CountryDisplayName] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_Country_CountryDisplayName') 
 BEGIN 
	DROP INDEX [IX_CMS_Country_CountryDisplayName] On [dbo].[CMS_Country];
END
-- 1296723672	HFit_PostHealthEducation	13	nonPostHealth	
IF NOT Exists (Select name from sys.indexes where name = 'nonPostHealth') 
 BEGIN 
	Create NonClustered Index [nonPostHealth] On [dbo].[HFit_PostHealthEducation] ([PostHealthEducationID] Asc,[PostName] Asc,[PostTitle] Asc,[PostImage] Asc,[Pinned] Asc,[PinnedExpireDate] Asc,[PillarID] Asc,[PersonaID] Asc) Include ([PostBody])  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 100, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'nonPostHealth') 
 BEGIN 
	DROP INDEX [nonPostHealth] On [dbo].[HFit_PostHealthEducation];
END
-- 837578022	PM_Project	3	IX_PM_Project_ProjectGroupID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_PM_Project_ProjectGroupID') 
 BEGIN 
	Create NonClustered Index [IX_PM_Project_ProjectGroupID] On [dbo].[PM_Project] ([ProjectGroupID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 100, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_PM_Project_ProjectGroupID') 
 BEGIN 
	DROP INDEX [IX_PM_Project_ProjectGroupID] On [dbo].[PM_Project];
END
-- 837578022	PM_Project	4	IX_PM_Project_ProjectOwner	
IF NOT Exists (Select name from sys.indexes where name = 'IX_PM_Project_ProjectOwner') 
 BEGIN 
	Create NonClustered Index [IX_PM_Project_ProjectOwner] On [dbo].[PM_Project] ([ProjectOwner] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 100, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_PM_Project_ProjectOwner') 
 BEGIN 
	DROP INDEX [IX_PM_Project_ProjectOwner] On [dbo].[PM_Project];
END
-- 837578022	PM_Project	6	IX_PM_Project_ProjectSiteID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_PM_Project_ProjectSiteID') 
 BEGIN 
	Create NonClustered Index [IX_PM_Project_ProjectSiteID] On [dbo].[PM_Project] ([ProjectSiteID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 100, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_PM_Project_ProjectSiteID') 
 BEGIN 
	DROP INDEX [IX_PM_Project_ProjectSiteID] On [dbo].[PM_Project];
END
-- 838294046	Blog_Comment	3	IX_Blog_Comment_CommentUserID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Blog_Comment_CommentUserID') 
 BEGIN 
	Create NonClustered Index [IX_Blog_Comment_CommentUserID] On [dbo].[Blog_Comment] ([CommentUserID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Blog_Comment_CommentUserID') 
 BEGIN 
	DROP INDEX [IX_Blog_Comment_CommentUserID] On [dbo].[Blog_Comment];
END
-- 838294046	Blog_Comment	5	IX_Blog_Comment_CommentPostDocumentID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Blog_Comment_CommentPostDocumentID') 
 BEGIN 
	Create NonClustered Index [IX_Blog_Comment_CommentPostDocumentID] On [dbo].[Blog_Comment] ([CommentPostDocumentID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Blog_Comment_CommentPostDocumentID') 
 BEGIN 
	DROP INDEX [IX_Blog_Comment_CommentPostDocumentID] On [dbo].[Blog_Comment];
END
-- 843150049	Forums_UserFavorites	3	IX_Forums_UserFavorites_UserID_PostID_ForumID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Forums_UserFavorites_UserID_PostID_ForumID') 
 BEGIN 
	Create Unique NonClustered Index [IX_Forums_UserFavorites_UserID_PostID_ForumID] On [dbo].[Forums_UserFavorites] ([UserID] Asc,[PostID] Asc,[ForumID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Forums_UserFavorites_UserID_PostID_ForumID') 
 BEGIN 
	DROP INDEX [IX_Forums_UserFavorites_UserID_PostID_ForumID] On [dbo].[Forums_UserFavorites];
END
-- 843150049	Forums_UserFavorites	4	IX_Forums_UserFavorites_PostID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Forums_UserFavorites_PostID') 
 BEGIN 
	Create NonClustered Index [IX_Forums_UserFavorites_PostID] On [dbo].[Forums_UserFavorites] ([PostID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Forums_UserFavorites_PostID') 
 BEGIN 
	DROP INDEX [IX_Forums_UserFavorites_PostID] On [dbo].[Forums_UserFavorites];
END
-- 843150049	Forums_UserFavorites	6	IX_Forums_UserFavorites_SiteID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Forums_UserFavorites_SiteID') 
 BEGIN 
	Create NonClustered Index [IX_Forums_UserFavorites_SiteID] On [dbo].[Forums_UserFavorites] ([SiteID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Forums_UserFavorites_SiteID') 
 BEGIN 
	DROP INDEX [IX_Forums_UserFavorites_SiteID] On [dbo].[Forums_UserFavorites];
END
-- 862626116	CMS_Category	1	IX_CMS_Category_CategoryDisplayName_CategoryEnabled	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_Category_CategoryDisplayName_CategoryEnabled') 
 BEGIN 
	Create Clustered Index [IX_CMS_Category_CategoryDisplayName_CategoryEnabled] On [dbo].[CMS_Category] ([CategoryDisplayName] Asc,[CategoryEnabled] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_Category_CategoryDisplayName_CategoryEnabled') 
 BEGIN 
	DROP INDEX [IX_CMS_Category_CategoryDisplayName_CategoryEnabled] On [dbo].[CMS_Category];
END
-- 862626116	CMS_Category	3	IX_CMS_Category_CategoryUserID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_Category_CategoryUserID') 
 BEGIN 
	Create NonClustered Index [IX_CMS_Category_CategoryUserID] On [dbo].[CMS_Category] ([CategoryUserID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_Category_CategoryUserID') 
 BEGIN 
	DROP INDEX [IX_CMS_Category_CategoryUserID] On [dbo].[CMS_Category];
END
-- 2030630277	Integration_SyncLog	2	IX_Integration_SyncLog_SyncLogTaskID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Integration_SyncLog_SyncLogTaskID') 
 BEGIN 
	Create NonClustered Index [IX_Integration_SyncLog_SyncLogTaskID] On [dbo].[Integration_SyncLog] ([SyncLogSynchronizationID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Integration_SyncLog_SyncLogTaskID') 
 BEGIN 
	DROP INDEX [IX_Integration_SyncLog_SyncLogTaskID] On [dbo].[Integration_SyncLog];
END
-- 2034822311	HFit_HealthAssesmentUserRiskArea	12	nonHARiskCategoryItemID	
IF NOT Exists (Select name from sys.indexes where name = 'nonHARiskCategoryItemID') 
 BEGIN 
	Create NonClustered Index [nonHARiskCategoryItemID] On [dbo].[HFit_HealthAssesmentUserRiskArea] ([ItemID] Asc,[HARiskCategoryItemID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 100, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'nonHARiskCategoryItemID') 
 BEGIN 
	DROP INDEX [nonHARiskCategoryItemID] On [dbo].[HFit_HealthAssesmentUserRiskArea];
END
-- 2050106344	CMS_Membership	2	IX_CMS_Membership_MembershipSiteID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_Membership_MembershipSiteID') 
 BEGIN 
	Create NonClustered Index [IX_CMS_Membership_MembershipSiteID] On [dbo].[CMS_Membership] ([MembershipSiteID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_Membership_MembershipSiteID') 
 BEGIN 
	DROP INDEX [IX_CMS_Membership_MembershipSiteID] On [dbo].[CMS_Membership];
END
-- 2050783059	SchemaChangeMonitor	2	PI_SchemaChangeMonitor	
IF NOT Exists (Select name from sys.indexes where name = 'PI_SchemaChangeMonitor') 
 BEGIN 
	Create NonClustered Index [PI_SchemaChangeMonitor] On [dbo].[SchemaChangeMonitor] ([OBJ] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 100, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'PI_SchemaChangeMonitor') 
 BEGIN 
	DROP INDEX [PI_SchemaChangeMonitor] On [dbo].[SchemaChangeMonitor];
END
-- 2052202361	CMS_PageTemplate	3	IX_CMS_PageTemplate_PageTemplateCodeName_PageTemplateDisplayName	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_PageTemplate_PageTemplateCodeName_PageTemplateDisplayName') 
 BEGIN 
	Create NonClustered Index [IX_CMS_PageTemplate_PageTemplateCodeName_PageTemplateDisplayName] On [dbo].[CMS_PageTemplate] ([PageTemplateCodeName] Asc,[PageTemplateDisplayName] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_PageTemplate_PageTemplateCodeName_PageTemplateDisplayName') 
 BEGIN 
	DROP INDEX [IX_CMS_PageTemplate_PageTemplateCodeName_PageTemplateDisplayName] On [dbo].[CMS_PageTemplate];
END
-- 564197060	CMS_UserSettings	64	nonUserIDSetIDDate	
IF NOT Exists (Select name from sys.indexes where name = 'nonUserIDSetIDDate') 
 BEGIN 
	Create NonClustered Index [nonUserIDSetIDDate] On [dbo].[CMS_UserSettings] ([UserSettingsUserID] Asc,[UserSettingsID] Asc,[HFitCoachingEnrollDate] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 100, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'nonUserIDSetIDDate') 
 BEGIN 
	DROP INDEX [nonUserIDSetIDDate] On [dbo].[CMS_UserSettings];
END
-- 564197060	CMS_UserSettings	67	IX_UserSettingsUserID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_UserSettingsUserID') 
 BEGIN 
	Create NonClustered Index [IX_UserSettingsUserID] On [dbo].[CMS_UserSettings] ([UserSettingsUserID] Asc,[UserSettingsID] Asc) Include ([UserNickName])  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 100, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_UserSettingsUserID') 
 BEGIN 
	DROP INDEX [IX_UserSettingsUserID] On [dbo].[CMS_UserSettings];
END
-- 564197060	CMS_UserSettings	70	pi_CMS_UserSettings_IDMPI	
IF NOT Exists (Select name from sys.indexes where name = 'pi_CMS_UserSettings_IDMPI') 
 BEGIN 
	Create NonClustered Index [pi_CMS_UserSettings_IDMPI] On [dbo].[CMS_UserSettings] ([UserSettingsID] Asc,[HFitUserMpiNumber] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 100, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'pi_CMS_UserSettings_IDMPI') 
 BEGIN 
	DROP INDEX [pi_CMS_UserSettings_IDMPI] On [dbo].[CMS_UserSettings];
END
-- 564197060	CMS_UserSettings	73	IDX_UserSettings_SettingsUserID	
IF NOT Exists (Select name from sys.indexes where name = 'IDX_UserSettings_SettingsUserID') 
 BEGIN 
	Create NonClustered Index [IDX_UserSettings_SettingsUserID] On [dbo].[CMS_UserSettings] ([UserSettingsUserID] Asc) Include ([UserNickName],[UserGender],[UserDateOfBirth],[HFitUserMpiNumber])  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IDX_UserSettings_SettingsUserID') 
 BEGIN 
	DROP INDEX [IDX_UserSettings_SettingsUserID] On [dbo].[CMS_UserSettings];
END
-- 1250103494	Staging_Synchronization	2	IX_Staging_Synchronization_SynchronizationTaskID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Staging_Synchronization_SynchronizationTaskID') 
 BEGIN 
	Create NonClustered Index [IX_Staging_Synchronization_SynchronizationTaskID] On [dbo].[Staging_Synchronization] ([SynchronizationTaskID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Staging_Synchronization_SynchronizationTaskID') 
 BEGIN 
	DROP INDEX [IX_Staging_Synchronization_SynchronizationTaskID] On [dbo].[Staging_Synchronization];
END
-- 1919345902	Newsletter_NewsletterIssue	5	IX_Newsletter_NewsletterIssue_IssueSiteID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Newsletter_NewsletterIssue_IssueSiteID') 
 BEGIN 
	Create NonClustered Index [IX_Newsletter_NewsletterIssue_IssueSiteID] On [dbo].[Newsletter_NewsletterIssue] ([IssueSiteID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Newsletter_NewsletterIssue_IssueSiteID') 
 BEGIN 
	DROP INDEX [IX_Newsletter_NewsletterIssue_IssueSiteID] On [dbo].[Newsletter_NewsletterIssue];
END
-- 1922105888	Integration_Connector	1	IX_Integration_Connector_ConnectorDisplayName	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Integration_Connector_ConnectorDisplayName') 
 BEGIN 
	Create Clustered Index [IX_Integration_Connector_ConnectorDisplayName] On [dbo].[Integration_Connector] ([ConnectorDisplayName] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 100, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Integration_Connector_ConnectorDisplayName') 
 BEGIN 
	DROP INDEX [IX_Integration_Connector_ConnectorDisplayName] On [dbo].[Integration_Connector];
END
-- 1922105888	Integration_Connector	3	IX_Integration_Connector_ConnectorEnabled	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Integration_Connector_ConnectorEnabled') 
 BEGIN 
	Create NonClustered Index [IX_Integration_Connector_ConnectorEnabled] On [dbo].[Integration_Connector] ([ConnectorEnabled] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 100, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Integration_Connector_ConnectorEnabled') 
 BEGIN 
	DROP INDEX [IX_Integration_Connector_ConnectorEnabled] On [dbo].[Integration_Connector];
END
-- 1925581898	COM_PaymentOption	3	IX_COM_PaymentOption_PaymentOptionSucceededOrderStatusID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_COM_PaymentOption_PaymentOptionSucceededOrderStatusID') 
 BEGIN 
	Create NonClustered Index [IX_COM_PaymentOption_PaymentOptionSucceededOrderStatusID] On [dbo].[COM_PaymentOption] ([PaymentOptionSucceededOrderStatusID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_COM_PaymentOption_PaymentOptionSucceededOrderStatusID') 
 BEGIN 
	DROP INDEX [IX_COM_PaymentOption_PaymentOptionSucceededOrderStatusID] On [dbo].[COM_PaymentOption];
END
-- 1926297922	CMS_AbuseReport	3	IX_CMS_AbuseReport_ReportUserID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_AbuseReport_ReportUserID') 
 BEGIN 
	Create NonClustered Index [IX_CMS_AbuseReport_ReportUserID] On [dbo].[CMS_AbuseReport] ([ReportUserID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_AbuseReport_ReportUserID') 
 BEGIN 
	DROP INDEX [IX_CMS_AbuseReport_ReportUserID] On [dbo].[CMS_AbuseReport];
END
-- 1927677915	COM_SKU	1	IX_COM_SKU_SKUName	
IF NOT Exists (Select name from sys.indexes where name = 'IX_COM_SKU_SKUName') 
 BEGIN 
	Create Clustered Index [IX_COM_SKU_SKUName] On [dbo].[COM_SKU] ([SKUName] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_COM_SKU_SKUName') 
 BEGIN 
	DROP INDEX [IX_COM_SKU_SKUName] On [dbo].[COM_SKU];
END
-- 1927677915	COM_SKU	3	IX_COM_SKU_SKUPrice	
IF NOT Exists (Select name from sys.indexes where name = 'IX_COM_SKU_SKUPrice') 
 BEGIN 
	Create NonClustered Index [IX_COM_SKU_SKUPrice] On [dbo].[COM_SKU] ([SKUPrice] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_COM_SKU_SKUPrice') 
 BEGIN 
	DROP INDEX [IX_COM_SKU_SKUPrice] On [dbo].[COM_SKU];
END
-- 1927677915	COM_SKU	4	IX_COM_SKU_SKUEnabled_SKUAvailableItems	
IF NOT Exists (Select name from sys.indexes where name = 'IX_COM_SKU_SKUEnabled_SKUAvailableItems') 
 BEGIN 
	Create NonClustered Index [IX_COM_SKU_SKUEnabled_SKUAvailableItems] On [dbo].[COM_SKU] ([SKUEnabled] Asc,[SKUAvailableItems] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_COM_SKU_SKUEnabled_SKUAvailableItems') 
 BEGIN 
	DROP INDEX [IX_COM_SKU_SKUEnabled_SKUAvailableItems] On [dbo].[COM_SKU];
END
-- 1927677915	COM_SKU	7	IX_COM_SKU_SKUManufacturerID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_COM_SKU_SKUManufacturerID') 
 BEGIN 
	Create NonClustered Index [IX_COM_SKU_SKUManufacturerID] On [dbo].[COM_SKU] ([SKUManufacturerID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_COM_SKU_SKUManufacturerID') 
 BEGIN 
	DROP INDEX [IX_COM_SKU_SKUManufacturerID] On [dbo].[COM_SKU];
END
-- 1927677915	COM_SKU	9	IX_COM_SKU_SKUPublicStatusID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_COM_SKU_SKUPublicStatusID') 
 BEGIN 
	Create NonClustered Index [IX_COM_SKU_SKUPublicStatusID] On [dbo].[COM_SKU] ([SKUPublicStatusID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_COM_SKU_SKUPublicStatusID') 
 BEGIN 
	DROP INDEX [IX_COM_SKU_SKUPublicStatusID] On [dbo].[COM_SKU];
END
-- 1927677915	COM_SKU	10	IX_COM_SKU_SKUSupplierID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_COM_SKU_SKUSupplierID') 
 BEGIN 
	Create NonClustered Index [IX_COM_SKU_SKUSupplierID] On [dbo].[COM_SKU] ([SKUSupplierID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_COM_SKU_SKUSupplierID') 
 BEGIN 
	DROP INDEX [IX_COM_SKU_SKUSupplierID] On [dbo].[COM_SKU];
END
-- 793769885	Reporting_ReportSubscription	5	IX_Reporting_ReportSubscription_ReportSubscriptionValueID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Reporting_ReportSubscription_ReportSubscriptionValueID') 
 BEGIN 
	Create NonClustered Index [IX_Reporting_ReportSubscription_ReportSubscriptionValueID] On [dbo].[Reporting_ReportSubscription] ([ReportSubscriptionValueID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Reporting_ReportSubscription_ReportSubscriptionValueID') 
 BEGIN 
	DROP INDEX [IX_Reporting_ReportSubscription_ReportSubscriptionValueID] On [dbo].[Reporting_ReportSubscription];
END
-- 811149935	CMS_TimeZone	1	IX_CMS_TimeZone_TimeZoneDisplayName	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_TimeZone_TimeZoneDisplayName') 
 BEGIN 
	Create Clustered Index [IX_CMS_TimeZone_TimeZoneDisplayName] On [dbo].[CMS_TimeZone] ([TimeZoneDisplayName] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_TimeZone_TimeZoneDisplayName') 
 BEGIN 
	DROP INDEX [IX_CMS_TimeZone_TimeZoneDisplayName] On [dbo].[CMS_TimeZone];
END
-- 813245952	CMS_WebPartCategory	1	IX_CMS_WebPartCategory_CategoryPath	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_WebPartCategory_CategoryPath') 
 BEGIN 
	Create Unique Clustered Index [IX_CMS_WebPartCategory_CategoryPath] On [dbo].[CMS_WebPartCategory] ([CategoryPath] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_WebPartCategory_CategoryPath') 
 BEGIN 
	DROP INDEX [IX_CMS_WebPartCategory_CategoryPath] On [dbo].[CMS_WebPartCategory];
END
-- 1421248118	HFit_TrackerSummary	5	idx_HFitTrackerSummary_WeekendDate	
IF NOT Exists (Select name from sys.indexes where name = 'idx_HFitTrackerSummary_WeekendDate') 
 BEGIN 
	Create NonClustered Index [idx_HFitTrackerSummary_WeekendDate] On [dbo].[HFit_TrackerSummary] ([WeekendDate] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'idx_HFitTrackerSummary_WeekendDate') 
 BEGIN 
	DROP INDEX [idx_HFitTrackerSummary_WeekendDate] On [dbo].[HFit_TrackerSummary];
END
-- 33747523	change_tables	2	change_tables_unique_idx	
IF NOT Exists (Select name from sys.indexes where name = 'change_tables_unique_idx') 
 BEGIN 
	Create Unique NonClustered Index [change_tables_unique_idx] On [cdc].[change_tables] ([capture_instance] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 100, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'change_tables_unique_idx') 
 BEGIN 
	DROP INDEX [change_tables_unique_idx] On [cdc].[change_tables];
END
-- 43147199	COM_ExchangeTable	1	IX_COM_ExchangeTable_ExchangeTableValidFrom_ExchangeTableValidTo	
IF NOT Exists (Select name from sys.indexes where name = 'IX_COM_ExchangeTable_ExchangeTableValidFrom_ExchangeTableValidTo') 
 BEGIN 
	Create Clustered Index [IX_COM_ExchangeTable_ExchangeTableValidFrom_ExchangeTableValidTo] On [dbo].[COM_ExchangeTable] ([ExchangeTableValidFrom] Desc,[ExchangeTableValidTo] Desc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_COM_ExchangeTable_ExchangeTableValidFrom_ExchangeTableValidTo') 
 BEGIN 
	DROP INDEX [IX_COM_ExchangeTable_ExchangeTableValidFrom_ExchangeTableValidTo] On [dbo].[COM_ExchangeTable];
END
-- 1106102981	CMS_WidgetCategory	3	IX_CMS_WidgetCategory_WidgetCategoryID_WidgetCategoryOrder	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_WidgetCategory_WidgetCategoryID_WidgetCategoryOrder') 
 BEGIN 
	Create NonClustered Index [IX_CMS_WidgetCategory_WidgetCategoryID_WidgetCategoryOrder] On [dbo].[CMS_WidgetCategory] ([WidgetCategoryParentID] Asc,[WidgetCategoryOrder] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_WidgetCategory_WidgetCategoryID_WidgetCategoryOrder') 
 BEGIN 
	DROP INDEX [IX_CMS_WidgetCategory_WidgetCategoryID_WidgetCategoryOrder] On [dbo].[CMS_WidgetCategory];
END
-- 1124199055	HFit_Goal	19	IX_Goal_CodeName	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Goal_CodeName') 
 BEGIN 
	Create NonClustered Index [IX_Goal_CodeName] On [dbo].[HFit_Goal] ([CodeName] Asc,[TrackerNodeGUID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Goal_CodeName') 
 BEGIN 
	DROP INDEX [IX_Goal_CodeName] On [dbo].[HFit_Goal];
END
-- 1129771082	CMS_Email	3	IX_CMS_Email_EmailSiteID_EmailStatus_EmailLastSendAttempt	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_Email_EmailSiteID_EmailStatus_EmailLastSendAttempt') 
 BEGIN 
	Create NonClustered Index [IX_CMS_Email_EmailSiteID_EmailStatus_EmailLastSendAttempt] On [dbo].[CMS_Email] ([EmailSiteID] Asc,[EmailStatus] Asc,[EmailLastSendAttempt] Asc) Include ([EmailID])  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_Email_EmailSiteID_EmailStatus_EmailLastSendAttempt') 
 BEGIN 
	DROP INDEX [IX_CMS_Email_EmailSiteID_EmailStatus_EmailLastSendAttempt] On [dbo].[CMS_Email];
END
-- 287340088	HFit_HealthAssesmentUserModule	8	IX_HAModule_StartedItemID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_HAModule_StartedItemID') 
 BEGIN 
	Create NonClustered Index [IX_HAModule_StartedItemID] On [dbo].[HFit_HealthAssesmentUserModule] ([HAStartedItemID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_HAModule_StartedItemID') 
 BEGIN 
	DROP INDEX [IX_HAModule_StartedItemID] On [dbo].[HFit_HealthAssesmentUserModule];
END
-- 291532122	CMS_LicenseKey	1	IX_CMS_LicenseKey_LicenseDomain	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_LicenseKey_LicenseDomain') 
 BEGIN 
	Create Clustered Index [IX_CMS_LicenseKey_LicenseDomain] On [dbo].[CMS_LicenseKey] ([LicenseDomain] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_LicenseKey_LicenseDomain') 
 BEGIN 
	DROP INDEX [IX_CMS_LicenseKey_LicenseDomain] On [dbo].[CMS_LicenseKey];
END
-- 302624121	Blog_PostSubscription	3	IX_Blog_PostSubscription_SubscriptionUserID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Blog_PostSubscription_SubscriptionUserID') 
 BEGIN 
	Create NonClustered Index [IX_Blog_PostSubscription_SubscriptionUserID] On [dbo].[Blog_PostSubscription] ([SubscriptionUserID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Blog_PostSubscription_SubscriptionUserID') 
 BEGIN 
	DROP INDEX [IX_Blog_PostSubscription_SubscriptionUserID] On [dbo].[Blog_PostSubscription];
END
-- 304720138	CMS_Permission	4	IX_CMS_Permission_ClassID_PermissionName	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_Permission_ClassID_PermissionName') 
 BEGIN 
	Create NonClustered Index [IX_CMS_Permission_ClassID_PermissionName] On [dbo].[CMS_Permission] ([ClassID] Asc,[PermissionName] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_Permission_ClassID_PermissionName') 
 BEGIN 
	DROP INDEX [IX_CMS_Permission_ClassID_PermissionName] On [dbo].[CMS_Permission];
END
-- 313768175	CMS_PageTemplateScope	4	IX_CMS_PageTemplateScope_PageTemplateScopeCultureID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_PageTemplateScope_PageTemplateScopeCultureID') 
 BEGIN 
	Create NonClustered Index [IX_CMS_PageTemplateScope_PageTemplateScopeCultureID] On [dbo].[CMS_PageTemplateScope] ([PageTemplateScopeCultureID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_PageTemplateScope_PageTemplateScopeCultureID') 
 BEGIN 
	DROP INDEX [IX_CMS_PageTemplateScope_PageTemplateScopeCultureID] On [dbo].[CMS_PageTemplateScope];
END
-- 313768175	CMS_PageTemplateScope	5	IX_CMS_PageTemplateScope_PageTemplateScopeClassID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_PageTemplateScope_PageTemplateScopeClassID') 
 BEGIN 
	Create NonClustered Index [IX_CMS_PageTemplateScope_PageTemplateScopeClassID] On [dbo].[CMS_PageTemplateScope] ([PageTemplateScopeClassID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_PageTemplateScope_PageTemplateScopeClassID') 
 BEGIN 
	DROP INDEX [IX_CMS_PageTemplateScope_PageTemplateScopeClassID] On [dbo].[CMS_PageTemplateScope];
END
-- 313768175	CMS_PageTemplateScope	7	IX_CMS_PageTemplateScope_PageTemplateScopeSiteID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_PageTemplateScope_PageTemplateScopeSiteID') 
 BEGIN 
	Create NonClustered Index [IX_CMS_PageTemplateScope_PageTemplateScopeSiteID] On [dbo].[CMS_PageTemplateScope] ([PageTemplateScopeSiteID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_PageTemplateScope_PageTemplateScopeSiteID') 
 BEGIN 
	DROP INDEX [IX_CMS_PageTemplateScope_PageTemplateScopeSiteID] On [dbo].[CMS_PageTemplateScope];
END
-- 320368556	HFit_PPTEligibility	3	HFit_PPTEligibililty_idx_02	
IF NOT Exists (Select name from sys.indexes where name = 'HFit_PPTEligibililty_idx_02') 
 BEGIN 
	Create NonClustered Index [HFit_PPTEligibililty_idx_02] On [dbo].[HFit_PPTEligibility] ([ClientCode] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'HFit_PPTEligibililty_idx_02') 
 BEGIN 
	DROP INDEX [HFit_PPTEligibililty_idx_02] On [dbo].[HFit_PPTEligibility];
END
-- 320368556	HFit_PPTEligibility	6	HFit_PPTEligibility_idx_03	
IF NOT Exists (Select name from sys.indexes where name = 'HFit_PPTEligibility_idx_03') 
 BEGIN 
	Create NonClustered Index [HFit_PPTEligibility_idx_03] On [dbo].[HFit_PPTEligibility] ([LastName] Asc,[FirstName] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'HFit_PPTEligibility_idx_03') 
 BEGIN 
	DROP INDEX [HFit_PPTEligibility_idx_03] On [dbo].[HFit_PPTEligibility];
END
-- 1066486878	CMS_CssStylesheet	3	IX_CMS_CssStylesheet_StylesheetName	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_CssStylesheet_StylesheetName') 
 BEGIN 
	Create NonClustered Index [IX_CMS_CssStylesheet_StylesheetName] On [dbo].[CMS_CssStylesheet] ([StylesheetName] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_CssStylesheet_StylesheetName') 
 BEGIN 
	DROP INDEX [IX_CMS_CssStylesheet_StylesheetName] On [dbo].[CMS_CssStylesheet];
END
-- 1069962888	HFit_TrackerSugaryDrinks	5	idx_HFit_TrackerSugaryDrinks_CreateDate	
IF NOT Exists (Select name from sys.indexes where name = 'idx_HFit_TrackerSugaryDrinks_CreateDate') 
 BEGIN 
	Create NonClustered Index [idx_HFit_TrackerSugaryDrinks_CreateDate] On [dbo].[HFit_TrackerSugaryDrinks] ([ItemCreatedWhen] Asc,[ItemModifiedWhen] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'idx_HFit_TrackerSugaryDrinks_CreateDate') 
 BEGIN 
	DROP INDEX [idx_HFit_TrackerSugaryDrinks_CreateDate] On [dbo].[HFit_TrackerSugaryDrinks];
END
-- 1078659286	Staging_TaskArchive	1	cdx_StagingTaskTaskID	
IF NOT Exists (Select name from sys.indexes where name = 'cdx_StagingTaskTaskID') 
 BEGIN 
	Create Clustered Index [cdx_StagingTaskTaskID] On [dbo].[Staging_TaskArchive] ([TaskID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'cdx_StagingTaskTaskID') 
 BEGIN 
	DROP INDEX [cdx_StagingTaskTaskID] On [dbo].[Staging_TaskArchive];
END
-- 1079635585	SchemaMonitorObjectName	1	PKI_SchemaMonitorObjectName	
IF NOT Exists (Select name from sys.indexes where name = 'PKI_SchemaMonitorObjectName') 
 BEGIN 
	Create Unique Clustered Index [PKI_SchemaMonitorObjectName] On [dbo].[SchemaMonitorObjectName] ([ObjectName] Asc,[ObjectType] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 100, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'PKI_SchemaMonitorObjectName') 
 BEGIN 
	DROP INDEX [PKI_SchemaMonitorObjectName] On [dbo].[SchemaMonitorObjectName];
END
-- 1615344819	Newsletter_Link	2	IX_Newsletter_Link_LinkIssueID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Newsletter_Link_LinkIssueID') 
 BEGIN 
	Create NonClustered Index [IX_Newsletter_Link_LinkIssueID] On [dbo].[Newsletter_Link] ([LinkIssueID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Newsletter_Link_LinkIssueID') 
 BEGIN 
	DROP INDEX [IX_Newsletter_Link_LinkIssueID] On [dbo].[Newsletter_Link];
END
-- 1637580872	CMS_MetaFile	1	IX_CMS_Metafile_MetaFileObjectType_MetaFileObjectID_MetaFileGroupName	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_Metafile_MetaFileObjectType_MetaFileObjectID_MetaFileGroupName') 
 BEGIN 
	Create Clustered Index [IX_CMS_Metafile_MetaFileObjectType_MetaFileObjectID_MetaFileGroupName] On [dbo].[CMS_MetaFile] ([MetaFileObjectType] Asc,[MetaFileObjectID] Asc,[MetaFileGroupName] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_Metafile_MetaFileObjectType_MetaFileObjectID_MetaFileGroupName') 
 BEGIN 
	DROP INDEX [IX_CMS_Metafile_MetaFileObjectType_MetaFileObjectID_MetaFileGroupName] On [dbo].[CMS_MetaFile];
END
-- 1637580872	CMS_MetaFile	3	IX_CMS_MetaFile_MetaFileGUID_MetaFileSiteID_MetaFileObjectType_MetaFileObjectID_MetaFileGroupName	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_MetaFile_MetaFileGUID_MetaFileSiteID_MetaFileObjectType_MetaFileObjectID_MetaFileGroupName') 
 BEGIN 
	Create NonClustered Index [IX_CMS_MetaFile_MetaFileGUID_MetaFileSiteID_MetaFileObjectType_MetaFileObjectID_MetaFileGroupName] On [dbo].[CMS_MetaFile] ([MetaFileGUID] Asc,[MetaFileSiteID] Asc,[MetaFileObjectType] Asc,[MetaFileObjectID] Asc,[MetaFileGroupName] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_MetaFile_MetaFileGUID_MetaFileSiteID_MetaFileObjectType_MetaFileObjectID_MetaFileGroupName') 
 BEGIN 
	DROP INDEX [IX_CMS_MetaFile_MetaFileGUID_MetaFileSiteID_MetaFileObjectType_MetaFileObjectID_MetaFileGroupName] On [dbo].[CMS_MetaFile];
END
-- 1639676889	CMS_Site	5	IX_CMS_Site_SiteDefaultStylesheetID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_Site_SiteDefaultStylesheetID') 
 BEGIN 
	Create NonClustered Index [IX_CMS_Site_SiteDefaultStylesheetID] On [dbo].[CMS_Site] ([SiteDefaultStylesheetID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_Site_SiteDefaultStylesheetID') 
 BEGIN 
	DROP INDEX [IX_CMS_Site_SiteDefaultStylesheetID] On [dbo].[CMS_Site];
END
-- 1893581784	COM_ShippingOption	1	IX_COM_ShippingOptionDisplayName	
IF NOT Exists (Select name from sys.indexes where name = 'IX_COM_ShippingOptionDisplayName') 
 BEGIN 
	Create Clustered Index [IX_COM_ShippingOptionDisplayName] On [dbo].[COM_ShippingOption] ([ShippingOptionDisplayName] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_COM_ShippingOptionDisplayName') 
 BEGIN 
	DROP INDEX [IX_COM_ShippingOptionDisplayName] On [dbo].[COM_ShippingOption];
END
-- 1917249885	Chat_OnlineUser	2	IX_Chat_OnlineUser_SiteID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Chat_OnlineUser_SiteID') 
 BEGIN 
	Create NonClustered Index [IX_Chat_OnlineUser_SiteID] On [dbo].[Chat_OnlineUser] ([ChatOnlineUserSiteID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Chat_OnlineUser_SiteID') 
 BEGIN 
	DROP INDEX [IX_Chat_OnlineUser_SiteID] On [dbo].[Chat_OnlineUser];
END
-- 1919345902	Newsletter_NewsletterIssue	3	IX_Newsletter_NewsletterIssue_IssueTemplateID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Newsletter_NewsletterIssue_IssueTemplateID') 
 BEGIN 
	Create NonClustered Index [IX_Newsletter_NewsletterIssue_IssueTemplateID] On [dbo].[Newsletter_NewsletterIssue] ([IssueTemplateID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Newsletter_NewsletterIssue_IssueTemplateID') 
 BEGIN 
	DROP INDEX [IX_Newsletter_NewsletterIssue_IssueTemplateID] On [dbo].[Newsletter_NewsletterIssue];
END
-- 1723153184	OM_MVTCombination	2	IX_OM_MVTCombination_MVTCombinationPageTemplateID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_OM_MVTCombination_MVTCombinationPageTemplateID') 
 BEGIN 
	Create NonClustered Index [IX_OM_MVTCombination_MVTCombinationPageTemplateID] On [dbo].[OM_MVTCombination] ([MVTCombinationPageTemplateID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_OM_MVTCombination_MVTCombinationPageTemplateID') 
 BEGIN 
	DROP INDEX [IX_OM_MVTCombination_MVTCombinationPageTemplateID] On [dbo].[OM_MVTCombination];
END
-- 1735169427	HFit_configGroupToFeature	8	IDX_ConfigGroupToFeatures_ConfigFeatureID	
IF NOT Exists (Select name from sys.indexes where name = 'IDX_ConfigGroupToFeatures_ConfigFeatureID') 
 BEGIN 
	Create NonClustered Index [IDX_ConfigGroupToFeatures_ConfigFeatureID] On [dbo].[HFit_configGroupToFeature] ([configFeatureID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IDX_ConfigGroupToFeatures_ConfigFeatureID') 
 BEGIN 
	DROP INDEX [IDX_ConfigGroupToFeatures_ConfigFeatureID] On [dbo].[HFit_configGroupToFeature];
END
-- 1735169427	HFit_configGroupToFeature	14	nonFeatureIDItemID	
IF NOT Exists (Select name from sys.indexes where name = 'nonFeatureIDItemID') 
 BEGIN 
	Create NonClustered Index [nonFeatureIDItemID] On [dbo].[HFit_configGroupToFeature] ([configFeatureID] Asc,[ItemID] Asc,[ContactGroupMembershipID] Asc,[ValidFromDate] Asc,[ValidToDate] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'nonFeatureIDItemID') 
 BEGIN 
	DROP INDEX [nonFeatureIDItemID] On [dbo].[HFit_configGroupToFeature];
END
-- 1735677231	CMS_ScheduledTask	3	IX_CMS_ScheduledTask_TaskSiteID_TaskDisplayName	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_ScheduledTask_TaskSiteID_TaskDisplayName') 
 BEGIN 
	Create NonClustered Index [IX_CMS_ScheduledTask_TaskSiteID_TaskDisplayName] On [dbo].[CMS_ScheduledTask] ([TaskSiteID] Asc,[TaskDisplayName] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_ScheduledTask_TaskSiteID_TaskDisplayName') 
 BEGIN 
	DROP INDEX [IX_CMS_ScheduledTask_TaskSiteID_TaskDisplayName] On [dbo].[CMS_ScheduledTask];
END
-- 212911830	HFit_TrackerBloodPressure	16	idx_HFit_TrackerBloodPressure_CreateDate	
IF NOT Exists (Select name from sys.indexes where name = 'idx_HFit_TrackerBloodPressure_CreateDate') 
 BEGIN 
	Create NonClustered Index [idx_HFit_TrackerBloodPressure_CreateDate] On [dbo].[HFit_TrackerBloodPressure] ([ItemCreatedWhen] Asc,[ItemModifiedWhen] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'idx_HFit_TrackerBloodPressure_CreateDate') 
 BEGIN 
	DROP INDEX [idx_HFit_TrackerBloodPressure_CreateDate] On [dbo].[HFit_TrackerBloodPressure];
END
-- 215671816	OM_Contact	3	IX_OM_Contact_ContactStateID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_OM_Contact_ContactStateID') 
 BEGIN 
	Create NonClustered Index [IX_OM_Contact_ContactStateID] On [dbo].[OM_Contact] ([ContactStateID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 100, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_OM_Contact_ContactStateID') 
 BEGIN 
	DROP INDEX [IX_OM_Contact_ContactStateID] On [dbo].[OM_Contact];
END
-- 215671816	OM_Contact	4	IX_OM_Contact_ContactCountryID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_OM_Contact_ContactCountryID') 
 BEGIN 
	Create NonClustered Index [IX_OM_Contact_ContactCountryID] On [dbo].[OM_Contact] ([ContactCountryID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 100, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_OM_Contact_ContactCountryID') 
 BEGIN 
	DROP INDEX [IX_OM_Contact_ContactCountryID] On [dbo].[OM_Contact];
END
-- 215671816	OM_Contact	6	IX_OM_Contact_ContactOwnerUserID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_OM_Contact_ContactOwnerUserID') 
 BEGIN 
	Create NonClustered Index [IX_OM_Contact_ContactOwnerUserID] On [dbo].[OM_Contact] ([ContactOwnerUserID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 100, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_OM_Contact_ContactOwnerUserID') 
 BEGIN 
	DROP INDEX [IX_OM_Contact_ContactOwnerUserID] On [dbo].[OM_Contact];
END
-- 215671816	OM_Contact	9	IX_OM_Contact_ContactSiteID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_OM_Contact_ContactSiteID') 
 BEGIN 
	Create NonClustered Index [IX_OM_Contact_ContactSiteID] On [dbo].[OM_Contact] ([ContactSiteID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 100, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_OM_Contact_ContactSiteID') 
 BEGIN 
	DROP INDEX [IX_OM_Contact_ContactSiteID] On [dbo].[OM_Contact];
END
-- 215671816	OM_Contact	18	IX_ContactContactSiteID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_ContactContactSiteID') 
 BEGIN 
	Create NonClustered Index [IX_ContactContactSiteID] On [dbo].[OM_Contact] ([ContactSiteID] Asc,[ContactGUID] Asc) Include ([ContactCountryID],[ContactCreated],[ContactEmail],[ContactFirstName],[ContactGlobalContactID],[ContactID],[ContactLastName],[ContactMergedWithContactID],[ContactStatusID])  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 100, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_ContactContactSiteID') 
 BEGIN 
	DROP INDEX [IX_ContactContactSiteID] On [dbo].[OM_Contact];
END
-- 1957582012	COM_OrderStatus	1	IX_COM_OrderStatus_StatusOrder_StatusDisplayName_StatusEnabled	
IF NOT Exists (Select name from sys.indexes where name = 'IX_COM_OrderStatus_StatusOrder_StatusDisplayName_StatusEnabled') 
 BEGIN 
	Create Clustered Index [IX_COM_OrderStatus_StatusOrder_StatusDisplayName_StatusEnabled] On [dbo].[COM_OrderStatus] ([StatusOrder] Asc,[StatusDisplayName] Asc,[StatusEnabled] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_COM_OrderStatus_StatusOrder_StatusDisplayName_StatusEnabled') 
 BEGIN 
	DROP INDEX [IX_COM_OrderStatus_StatusOrder_StatusDisplayName_StatusEnabled] On [dbo].[COM_OrderStatus];
END
-- 1204915364	CMS_WebPartLayout	1	IX_CMS_WebPartLayout_WebPartLayoutWebPartID_WebPartLayoutCodeName	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_WebPartLayout_WebPartLayoutWebPartID_WebPartLayoutCodeName') 
 BEGIN 
	Create Clustered Index [IX_CMS_WebPartLayout_WebPartLayoutWebPartID_WebPartLayoutCodeName] On [dbo].[CMS_WebPartLayout] ([WebPartLayoutWebPartID] Asc,[WebPartLayoutCodeName] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_WebPartLayout_WebPartLayoutWebPartID_WebPartLayoutCodeName') 
 BEGIN 
	DROP INDEX [IX_CMS_WebPartLayout_WebPartLayoutWebPartID_WebPartLayoutCodeName] On [dbo].[CMS_WebPartLayout];
END
-- 1218103380	Staging_SyncLog	2	IX_Staging_SyncLog_SyncLogTaskID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Staging_SyncLog_SyncLogTaskID') 
 BEGIN 
	Create NonClustered Index [IX_Staging_SyncLog_SyncLogTaskID] On [dbo].[Staging_SyncLog] ([SyncLogTaskID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Staging_SyncLog_SyncLogTaskID') 
 BEGIN 
	DROP INDEX [IX_Staging_SyncLog_SyncLogTaskID] On [dbo].[Staging_SyncLog];
END
-- 869578136	Community_Invitation	3	IX_Community_Invitation_InvitedByUserID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Community_Invitation_InvitedByUserID') 
 BEGIN 
	Create NonClustered Index [IX_Community_Invitation_InvitedByUserID] On [dbo].[Community_Invitation] ([InvitedByUserID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Community_Invitation_InvitedByUserID') 
 BEGIN 
	DROP INDEX [IX_Community_Invitation_InvitedByUserID] On [dbo].[Community_Invitation];
END
-- 869578136	Community_Invitation	4	IX_Community_Invitation_InvitationGroupID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Community_Invitation_InvitationGroupID') 
 BEGIN 
	Create NonClustered Index [IX_Community_Invitation_InvitationGroupID] On [dbo].[Community_Invitation] ([InvitationGroupID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Community_Invitation_InvitationGroupID') 
 BEGIN 
	DROP INDEX [IX_Community_Invitation_InvitationGroupID] On [dbo].[Community_Invitation];
END
-- 870658545	HFit_HealthAssesmentRecomendationClientConfig	2	idx_RecomendationID	
IF NOT Exists (Select name from sys.indexes where name = 'idx_RecomendationID') 
 BEGIN 
	Create NonClustered Index [idx_RecomendationID] On [dbo].[HFit_HealthAssesmentRecomendationClientConfig] ([RecomdationID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'idx_RecomendationID') 
 BEGIN 
	DROP INDEX [idx_RecomendationID] On [dbo].[HFit_HealthAssesmentRecomendationClientConfig];
END
-- 734625660	Export_History	3	IX_Export_History_ExportSiteID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Export_History_ExportSiteID') 
 BEGIN 
	Create NonClustered Index [IX_Export_History_ExportSiteID] On [dbo].[Export_History] ([ExportSiteID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Export_History_ExportSiteID') 
 BEGIN 
	DROP INDEX [IX_Export_History_ExportSiteID] On [dbo].[Export_History];
END
-- 341576255	Analytics_YearHits	1	IX_Analytics_YearHits_HitsStartTime_HitsEndTime	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Analytics_YearHits_HitsStartTime_HitsEndTime') 
 BEGIN 
	Create Clustered Index [IX_Analytics_YearHits_HitsStartTime_HitsEndTime] On [dbo].[Analytics_YearHits] ([HitsStartTime] Desc,[HitsEndTime] Desc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Analytics_YearHits_HitsStartTime_HitsEndTime') 
 BEGIN 
	DROP INDEX [IX_Analytics_YearHits_HitsStartTime_HitsEndTime] On [dbo].[Analytics_YearHits];
END
-- 341576255	Analytics_YearHits	3	IX_Analytics_WeekYearHits_HitsStatisticsID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Analytics_WeekYearHits_HitsStatisticsID') 
 BEGIN 
	Create NonClustered Index [IX_Analytics_WeekYearHits_HitsStatisticsID] On [dbo].[Analytics_YearHits] ([HitsStatisticsID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Analytics_WeekYearHits_HitsStatisticsID') 
 BEGIN 
	DROP INDEX [IX_Analytics_WeekYearHits_HitsStatisticsID] On [dbo].[Analytics_YearHits];
END
-- 350624292	OM_Activity	3	IX_OM_Activity_ActivityOriginalContactID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_OM_Activity_ActivityOriginalContactID') 
 BEGIN 
	Create NonClustered Index [IX_OM_Activity_ActivityOriginalContactID] On [dbo].[OM_Activity] ([ActivityOriginalContactID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 100, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_OM_Activity_ActivityOriginalContactID') 
 BEGIN 
	DROP INDEX [IX_OM_Activity_ActivityOriginalContactID] On [dbo].[OM_Activity];
END
-- 350624292	OM_Activity	6	IX_OM_Activity_ActivityItemDetailID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_OM_Activity_ActivityItemDetailID') 
 BEGIN 
	Create NonClustered Index [IX_OM_Activity_ActivityItemDetailID] On [dbo].[OM_Activity] ([ActivityItemDetailID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 100, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_OM_Activity_ActivityItemDetailID') 
 BEGIN 
	DROP INDEX [IX_OM_Activity_ActivityItemDetailID] On [dbo].[OM_Activity];
END
-- 352720309	CMS_InlineControl	1	IX_CMS_InlineControl_ControlDisplayName	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_InlineControl_ControlDisplayName') 
 BEGIN 
	Create Clustered Index [IX_CMS_InlineControl_ControlDisplayName] On [dbo].[CMS_InlineControl] ([ControlDisplayName] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_InlineControl_ControlDisplayName') 
 BEGIN 
	DROP INDEX [IX_CMS_InlineControl_ControlDisplayName] On [dbo].[CMS_InlineControl];
END
-- 75147313	COM_DiscountCoupon	1	IX_COM_DiscountCoupon_DiscoutCouponDisplayName	
IF NOT Exists (Select name from sys.indexes where name = 'IX_COM_DiscountCoupon_DiscoutCouponDisplayName') 
 BEGIN 
	Create Clustered Index [IX_COM_DiscountCoupon_DiscoutCouponDisplayName] On [dbo].[COM_DiscountCoupon] ([DiscountCouponDisplayName] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_COM_DiscountCoupon_DiscoutCouponDisplayName') 
 BEGIN 
	DROP INDEX [IX_COM_DiscountCoupon_DiscoutCouponDisplayName] On [dbo].[COM_DiscountCoupon];
END
-- 431340601	HFit_HealthAssesmentUserAnswers	3	IDX_Hfit_HealthAssesmentUserAnswers_HAAnswerNodeGUID	
IF NOT Exists (Select name from sys.indexes where name = 'IDX_Hfit_HealthAssesmentUserAnswers_HAAnswerNodeGUID') 
 BEGIN 
	Create NonClustered Index [IDX_Hfit_HealthAssesmentUserAnswers_HAAnswerNodeGUID] On [dbo].[HFit_HealthAssesmentUserAnswers] ([ItemID] Asc,[HAQuestionItemID] Asc,[HAAnswerPoints] Asc,[HAAnswerValue] Asc,[CodeName] Asc,[UOMCode] Asc,[HAAnswerNodeGUID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 100, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IDX_Hfit_HealthAssesmentUserAnswers_HAAnswerNodeGUID') 
 BEGIN 
	DROP INDEX [IDX_Hfit_HealthAssesmentUserAnswers_HAAnswerNodeGUID] On [dbo].[HFit_HealthAssesmentUserAnswers];
END
-- 431340601	HFit_HealthAssesmentUserAnswers	9	nonHAQuestionItemID	
IF NOT Exists (Select name from sys.indexes where name = 'nonHAQuestionItemID') 
 BEGIN 
	Create NonClustered Index [nonHAQuestionItemID] On [dbo].[HFit_HealthAssesmentUserAnswers] ([HAQuestionItemID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'nonHAQuestionItemID') 
 BEGIN 
	DROP INDEX [nonHAQuestionItemID] On [dbo].[HFit_HealthAssesmentUserAnswers];
END
-- 16719112	CMS_Query	1	IX_CMS_Query_QueryLoadGeneration	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_Query_QueryLoadGeneration') 
 BEGIN 
	Create Clustered Index [IX_CMS_Query_QueryLoadGeneration] On [dbo].[CMS_Query] ([QueryLoadGeneration] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_Query_QueryLoadGeneration') 
 BEGIN 
	DROP INDEX [IX_CMS_Query_QueryLoadGeneration] On [dbo].[CMS_Query];
END
-- 20911146	HFit_UserTracker	2	HFit_UserTracker_idx_01	
IF NOT Exists (Select name from sys.indexes where name = 'HFit_UserTracker_idx_01') 
 BEGIN 
	Create NonClustered Index [HFit_UserTracker_idx_01] On [dbo].[HFit_UserTracker] ([UserID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'HFit_UserTracker_idx_01') 
 BEGIN 
	DROP INDEX [HFit_UserTracker_idx_01] On [dbo].[HFit_UserTracker];
END
-- 713769600	Community_Friend	3	IX_Community_Friend_FriendRequestedUserID_FriendUserID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Community_Friend_FriendRequestedUserID_FriendUserID') 
 BEGIN 
	Create Unique NonClustered Index [IX_Community_Friend_FriendRequestedUserID_FriendUserID] On [dbo].[Community_Friend] ([FriendRequestedUserID] Asc,[FriendUserID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Community_Friend_FriendRequestedUserID_FriendUserID') 
 BEGIN 
	DROP INDEX [IX_Community_Friend_FriendRequestedUserID_FriendUserID] On [dbo].[Community_Friend];
END
-- 713769600	Community_Friend	6	IX_Community_Friend_FriendRejectedBy	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Community_Friend_FriendRejectedBy') 
 BEGIN 
	Create NonClustered Index [IX_Community_Friend_FriendRejectedBy] On [dbo].[Community_Friend] ([FriendRejectedBy] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Community_Friend_FriendRejectedBy') 
 BEGIN 
	DROP INDEX [IX_Community_Friend_FriendRejectedBy] On [dbo].[Community_Friend];
END
-- 2052202361	CMS_PageTemplate	6	IX_CMS_PageTemplate_PageTemplateIsReusable_PageTemplateForAllPages_PageTemplateShowAsMasterTemplate	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_PageTemplate_PageTemplateIsReusable_PageTemplateForAllPages_PageTemplateShowAsMasterTemplate') 
 BEGIN 
	Create NonClustered Index [IX_CMS_PageTemplate_PageTemplateIsReusable_PageTemplateForAllPages_PageTemplateShowAsMasterTemplate] On [dbo].[CMS_PageTemplate] ([PageTemplateIsReusable] Asc,[PageTemplateForAllPages] Asc,[PageTemplateShowAsMasterTemplate] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_PageTemplate_PageTemplateIsReusable_PageTemplateForAllPages_PageTemplateShowAsMasterTemplate') 
 BEGIN 
	DROP INDEX [IX_CMS_PageTemplate_PageTemplateIsReusable_PageTemplateForAllPages_PageTemplateShowAsMasterTemplate] On [dbo].[CMS_PageTemplate];
END
-- 2055678371	COM_Order	3	IX_COM_Order_OrderBillingAddressID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_COM_Order_OrderBillingAddressID') 
 BEGIN 
	Create NonClustered Index [IX_COM_Order_OrderBillingAddressID] On [dbo].[COM_Order] ([OrderBillingAddressID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_COM_Order_OrderBillingAddressID') 
 BEGIN 
	DROP INDEX [IX_COM_Order_OrderBillingAddressID] On [dbo].[COM_Order];
END
-- 2055678371	COM_Order	5	IX_COM_Order_OrderShippingOptionID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_COM_Order_OrderShippingOptionID') 
 BEGIN 
	Create NonClustered Index [IX_COM_Order_OrderShippingOptionID] On [dbo].[COM_Order] ([OrderShippingOptionID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_COM_Order_OrderShippingOptionID') 
 BEGIN 
	DROP INDEX [IX_COM_Order_OrderShippingOptionID] On [dbo].[COM_Order];
END
-- 2055678371	COM_Order	6	IX_COM_Order_OrderStatusID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_COM_Order_OrderStatusID') 
 BEGIN 
	Create NonClustered Index [IX_COM_Order_OrderStatusID] On [dbo].[COM_Order] ([OrderStatusID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_COM_Order_OrderStatusID') 
 BEGIN 
	DROP INDEX [IX_COM_Order_OrderStatusID] On [dbo].[COM_Order];
END
-- 2055678371	COM_Order	8	IX_COM_Order_OrderCustomerID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_COM_Order_OrderCustomerID') 
 BEGIN 
	Create NonClustered Index [IX_COM_Order_OrderCustomerID] On [dbo].[COM_Order] ([OrderCustomerID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_COM_Order_OrderCustomerID') 
 BEGIN 
	DROP INDEX [IX_COM_Order_OrderCustomerID] On [dbo].[COM_Order];
END
-- 2055678371	COM_Order	11	IX_COM_Order_OrderCompanyAddressID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_COM_Order_OrderCompanyAddressID') 
 BEGIN 
	Create NonClustered Index [IX_COM_Order_OrderCompanyAddressID] On [dbo].[COM_Order] ([OrderCompanyAddressID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_COM_Order_OrderCompanyAddressID') 
 BEGIN 
	DROP INDEX [IX_COM_Order_OrderCompanyAddressID] On [dbo].[COM_Order];
END
-- 2064726408	CMS_VersionHistory	1	IX_CMS_VersionHistory_DocumentID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_VersionHistory_DocumentID') 
 BEGIN 
	Create Clustered Index [IX_CMS_VersionHistory_DocumentID] On [dbo].[CMS_VersionHistory] ([DocumentID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_VersionHistory_DocumentID') 
 BEGIN 
	DROP INDEX [IX_CMS_VersionHistory_DocumentID] On [dbo].[CMS_VersionHistory];
END
-- 2064726408	CMS_VersionHistory	3	IX_CMS_VersionHistory_NodeSiteID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_VersionHistory_NodeSiteID') 
 BEGIN 
	Create NonClustered Index [IX_CMS_VersionHistory_NodeSiteID] On [dbo].[CMS_VersionHistory] ([NodeSiteID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_VersionHistory_NodeSiteID') 
 BEGIN 
	DROP INDEX [IX_CMS_VersionHistory_NodeSiteID] On [dbo].[CMS_VersionHistory];
END
-- 2064726408	CMS_VersionHistory	4	IX_VersionHistoryDocID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_VersionHistoryDocID') 
 BEGIN 
	Create NonClustered Index [IX_VersionHistoryDocID] On [dbo].[CMS_VersionHistory] ([DocumentID] Asc,[VersionHistoryID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_VersionHistoryDocID') 
 BEGIN 
	DROP INDEX [IX_VersionHistoryDocID] On [dbo].[CMS_VersionHistory];
END
-- 2064726408	CMS_VersionHistory	6	IX_CMS_VersionHistory_VersionDeletedByUserID_VersionDeletedWhen	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_VersionHistory_VersionDeletedByUserID_VersionDeletedWhen') 
 BEGIN 
	Create NonClustered Index [IX_CMS_VersionHistory_VersionDeletedByUserID_VersionDeletedWhen] On [dbo].[CMS_VersionHistory] ([VersionDeletedByUserID] Asc,[VersionDeletedWhen] Desc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_VersionHistory_VersionDeletedByUserID_VersionDeletedWhen') 
 BEGIN 
	DROP INDEX [IX_CMS_VersionHistory_VersionDeletedByUserID_VersionDeletedWhen] On [dbo].[CMS_VersionHistory];
END
-- 2112726579	CMS_Document	3	IX_CMS_Document_WorkflowColumns	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_Document_WorkflowColumns') 
 BEGIN 
	Create NonClustered Index [IX_CMS_Document_WorkflowColumns] On [dbo].[CMS_Document] ([DocumentID] Asc,[DocumentNodeID] Asc,[DocumentCulture] Asc,[DocumentCheckedOutVersionHistoryID] Asc,[DocumentPublishedVersionHistoryID] Asc,[DocumentPublishFrom] Asc,[DocumentPublishTo] Asc,[DocumentWorkflowStepID] Asc,[DocumentIsArchived] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_Document_WorkflowColumns') 
 BEGIN 
	DROP INDEX [IX_CMS_Document_WorkflowColumns] On [dbo].[CMS_Document];
END
-- 2112726579	CMS_Document	4	IX_CMS_Document_DocumentNodeID_DocumentID_DocumentCulture	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_Document_DocumentNodeID_DocumentID_DocumentCulture') 
 BEGIN 
	Create Unique NonClustered Index [IX_CMS_Document_DocumentNodeID_DocumentID_DocumentCulture] On [dbo].[CMS_Document] ([DocumentNodeID] Asc,[DocumentID] Asc,[DocumentCulture] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_Document_DocumentNodeID_DocumentID_DocumentCulture') 
 BEGIN 
	DROP INDEX [IX_CMS_Document_DocumentNodeID_DocumentID_DocumentCulture] On [dbo].[CMS_Document];
END
-- 2112726579	CMS_Document	6	IX_CMS_Document_DocumentModifiedByUserID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_Document_DocumentModifiedByUserID') 
 BEGIN 
	Create NonClustered Index [IX_CMS_Document_DocumentModifiedByUserID] On [dbo].[CMS_Document] ([DocumentModifiedByUserID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_Document_DocumentModifiedByUserID') 
 BEGIN 
	DROP INDEX [IX_CMS_Document_DocumentModifiedByUserID] On [dbo].[CMS_Document];
END
-- 2112726579	CMS_Document	7	IX_CMS_Document_DocumentCulture_DocumentForeignKeyValue_Workflow	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_Document_DocumentCulture_DocumentForeignKeyValue_Workflow') 
 BEGIN 
	Create NonClustered Index [IX_CMS_Document_DocumentCulture_DocumentForeignKeyValue_Workflow] On [dbo].[CMS_Document] ([DocumentCulture] Asc) Include ([DocumentCheckedOutVersionHistoryID],[DocumentForeignKeyValue],[DocumentIsArchived],[DocumentNodeID],[DocumentPublishedVersionHistoryID],[DocumentPublishFrom],[DocumentPublishTo])  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_Document_DocumentCulture_DocumentForeignKeyValue_Workflow') 
 BEGIN 
	DROP INDEX [IX_CMS_Document_DocumentCulture_DocumentForeignKeyValue_Workflow] On [dbo].[CMS_Document];
END
-- 2112726579	CMS_Document	9	IX_CMS_Document_DocumentCheckedOutByUserID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_Document_DocumentCheckedOutByUserID') 
 BEGIN 
	Create NonClustered Index [IX_CMS_Document_DocumentCheckedOutByUserID] On [dbo].[CMS_Document] ([DocumentCheckedOutByUserID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_Document_DocumentCheckedOutByUserID') 
 BEGIN 
	DROP INDEX [IX_CMS_Document_DocumentCheckedOutByUserID] On [dbo].[CMS_Document];
END
-- 2112726579	CMS_Document	10	IX_CMS_Document_DocumentCulture	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_Document_DocumentCulture') 
 BEGIN 
	Create NonClustered Index [IX_CMS_Document_DocumentCulture] On [dbo].[CMS_Document] ([DocumentCulture] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_Document_DocumentCulture') 
 BEGIN 
	DROP INDEX [IX_CMS_Document_DocumentCulture] On [dbo].[CMS_Document];
END
-- 2112726579	CMS_Document	12	IX_CMS_Document_DocumentMenuItemHideInNavigation	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_Document_DocumentMenuItemHideInNavigation') 
 BEGIN 
	Create NonClustered Index [IX_CMS_Document_DocumentMenuItemHideInNavigation] On [dbo].[CMS_Document] ([DocumentMenuItemHideInNavigation] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_Document_DocumentMenuItemHideInNavigation') 
 BEGIN 
	DROP INDEX [IX_CMS_Document_DocumentMenuItemHideInNavigation] On [dbo].[CMS_Document];
END
-- 2112726579	CMS_Document	15	IX_CMS_Document_DocumentWildcardRule_DocumentPriority	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_Document_DocumentWildcardRule_DocumentPriority') 
 BEGIN 
	Create NonClustered Index [IX_CMS_Document_DocumentWildcardRule_DocumentPriority] On [dbo].[CMS_Document] ([DocumentWildcardRule] Asc,[DocumentPriority] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_Document_DocumentWildcardRule_DocumentPriority') 
 BEGIN 
	DROP INDEX [IX_CMS_Document_DocumentWildcardRule_DocumentPriority] On [dbo].[CMS_Document];
END
-- 1316199739	CMS_ACL	3	IX_CMS_ACL_ACLOwnerNodeID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_ACL_ACLOwnerNodeID') 
 BEGIN 
	Create NonClustered Index [IX_CMS_ACL_ACLOwnerNodeID] On [dbo].[CMS_ACL] ([ACLOwnerNodeID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_ACL_ACLOwnerNodeID') 
 BEGIN 
	DROP INDEX [IX_CMS_ACL_ACLOwnerNodeID] On [dbo].[CMS_ACL];
END
-- 1317579732	COM_Department	3	IX_COM_Department_DepartmentDefaultTaxClassID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_COM_Department_DepartmentDefaultTaxClassID') 
 BEGIN 
	Create NonClustered Index [IX_COM_Department_DepartmentDefaultTaxClassID] On [dbo].[COM_Department] ([DepartmentDefaultTaxClassID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_COM_Department_DepartmentDefaultTaxClassID') 
 BEGIN 
	DROP INDEX [IX_COM_Department_DepartmentDefaultTaxClassID] On [dbo].[COM_Department];
END
-- 166291652	CMS_WebFarmServer	1	IX_CMS_WebFarmServer_ServerDisplayName	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_WebFarmServer_ServerDisplayName') 
 BEGIN 
	Create Clustered Index [IX_CMS_WebFarmServer_ServerDisplayName] On [dbo].[CMS_WebFarmServer] ([ServerDisplayName] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_WebFarmServer_ServerDisplayName') 
 BEGIN 
	DROP INDEX [IX_CMS_WebFarmServer_ServerDisplayName] On [dbo].[CMS_WebFarmServer];
END
-- 166291652	CMS_WebFarmServer	3	IX_CMS_WebFarmServer_ServerName	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_WebFarmServer_ServerName') 
 BEGIN 
	Create NonClustered Index [IX_CMS_WebFarmServer_ServerName] On [dbo].[CMS_WebFarmServer] ([ServerName] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_WebFarmServer_ServerName') 
 BEGIN 
	DROP INDEX [IX_CMS_WebFarmServer_ServerName] On [dbo].[CMS_WebFarmServer];
END
-- 1458104235	Reporting_SavedGraph	2	IX_Reporting_SavedGraph_SavedGraphSavedReportID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Reporting_SavedGraph_SavedGraphSavedReportID') 
 BEGIN 
	Create NonClustered Index [IX_Reporting_SavedGraph_SavedGraphSavedReportID] On [dbo].[Reporting_SavedGraph] ([SavedGraphSavedReportID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Reporting_SavedGraph_SavedGraphSavedReportID') 
 BEGIN 
	DROP INDEX [IX_Reporting_SavedGraph_SavedGraphSavedReportID] On [dbo].[Reporting_SavedGraph];
END
-- 1465772279	CMS_DocumentAlias	1	IX_CMS_DocumentAlias_AliasURLPath	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_DocumentAlias_AliasURLPath') 
 BEGIN 
	Create Clustered Index [IX_CMS_DocumentAlias_AliasURLPath] On [dbo].[CMS_DocumentAlias] ([AliasURLPath] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_DocumentAlias_AliasURLPath') 
 BEGIN 
	DROP INDEX [IX_CMS_DocumentAlias_AliasURLPath] On [dbo].[CMS_DocumentAlias];
END
-- 1465772279	CMS_DocumentAlias	3	IX_CMS_DocumentAlias_AliasNodeID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_DocumentAlias_AliasNodeID') 
 BEGIN 
	Create NonClustered Index [IX_CMS_DocumentAlias_AliasNodeID] On [dbo].[CMS_DocumentAlias] ([AliasNodeID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_DocumentAlias_AliasNodeID') 
 BEGIN 
	DROP INDEX [IX_CMS_DocumentAlias_AliasNodeID] On [dbo].[CMS_DocumentAlias];
END
-- 1465772279	CMS_DocumentAlias	4	IX_CMS_Document_AliasCulture	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_Document_AliasCulture') 
 BEGIN 
	Create NonClustered Index [IX_CMS_Document_AliasCulture] On [dbo].[CMS_DocumentAlias] ([AliasCulture] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_Document_AliasCulture') 
 BEGIN 
	DROP INDEX [IX_CMS_Document_AliasCulture] On [dbo].[CMS_DocumentAlias];
END
-- 1465772279	CMS_DocumentAlias	6	IX_CMS_DocumentAlias_AliasSiteID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_DocumentAlias_AliasSiteID') 
 BEGIN 
	Create NonClustered Index [IX_CMS_DocumentAlias_AliasSiteID] On [dbo].[CMS_DocumentAlias] ([AliasSiteID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_DocumentAlias_AliasSiteID') 
 BEGIN 
	DROP INDEX [IX_CMS_DocumentAlias_AliasSiteID] On [dbo].[CMS_DocumentAlias];
END
-- 1687169256	HFit_configFeatures	7	IDX_ConfigFeatures_ParentRoleID	
IF NOT Exists (Select name from sys.indexes where name = 'IDX_ConfigFeatures_ParentRoleID') 
 BEGIN 
	Create NonClustered Index [IDX_ConfigFeatures_ParentRoleID] On [dbo].[HFit_configFeatures] ([ParentRoleID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IDX_ConfigFeatures_ParentRoleID') 
 BEGIN 
	DROP INDEX [IDX_ConfigFeatures_ParentRoleID] On [dbo].[HFit_configFeatures];
END
-- 1687169256	HFit_configFeatures	11	IDX_ConfigFeatures_RoleID	
IF NOT Exists (Select name from sys.indexes where name = 'IDX_ConfigFeatures_RoleID') 
 BEGIN 
	Create NonClustered Index [IDX_ConfigFeatures_RoleID] On [dbo].[HFit_configFeatures] ([RoleID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IDX_ConfigFeatures_RoleID') 
 BEGIN 
	DROP INDEX [IDX_ConfigFeatures_RoleID] On [dbo].[HFit_configFeatures];
END
-- 1700917131	CMS_Workflow	1	IX_CMS_Workflow_WorkflowDisplayName	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_Workflow_WorkflowDisplayName') 
 BEGIN 
	Create Clustered Index [IX_CMS_Workflow_WorkflowDisplayName] On [dbo].[CMS_Workflow] ([WorkflowDisplayName] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_Workflow_WorkflowDisplayName') 
 BEGIN 
	DROP INDEX [IX_CMS_Workflow_WorkflowDisplayName] On [dbo].[CMS_Workflow];
END
-- 1181963287	HFit_TrackerMedicalCarePlan	5	idx_HFit_TrackerMedicalCarePlan_CreateDate	
IF NOT Exists (Select name from sys.indexes where name = 'idx_HFit_TrackerMedicalCarePlan_CreateDate') 
 BEGIN 
	Create NonClustered Index [idx_HFit_TrackerMedicalCarePlan_CreateDate] On [dbo].[HFit_TrackerMedicalCarePlan] ([ItemCreatedWhen] Asc,[ItemModifiedWhen] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'idx_HFit_TrackerMedicalCarePlan_CreateDate') 
 BEGIN 
	DROP INDEX [idx_HFit_TrackerMedicalCarePlan_CreateDate] On [dbo].[HFit_TrackerMedicalCarePlan];
END
-- 743673697	Community_GroupMember	3	IX_Community_GroupMember_MemberUserID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Community_GroupMember_MemberUserID') 
 BEGIN 
	Create NonClustered Index [IX_Community_GroupMember_MemberUserID] On [dbo].[Community_GroupMember] ([MemberUserID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Community_GroupMember_MemberUserID') 
 BEGIN 
	DROP INDEX [IX_Community_GroupMember_MemberUserID] On [dbo].[Community_GroupMember];
END
-- 743673697	Community_GroupMember	5	IX_Community_GroupMember_MemberApprovedByUserID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Community_GroupMember_MemberApprovedByUserID') 
 BEGIN 
	Create NonClustered Index [IX_Community_GroupMember_MemberApprovedByUserID] On [dbo].[Community_GroupMember] ([MemberApprovedByUserID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Community_GroupMember_MemberApprovedByUserID') 
 BEGIN 
	DROP INDEX [IX_Community_GroupMember_MemberApprovedByUserID] On [dbo].[Community_GroupMember];
END
-- 743673697	Community_GroupMember	6	IX_Community_GroupMember_MemberInvitedByUserID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Community_GroupMember_MemberInvitedByUserID') 
 BEGIN 
	Create NonClustered Index [IX_Community_GroupMember_MemberInvitedByUserID] On [dbo].[Community_GroupMember] ([MemberInvitedByUserID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Community_GroupMember_MemberInvitedByUserID') 
 BEGIN 
	DROP INDEX [IX_Community_GroupMember_MemberInvitedByUserID] On [dbo].[Community_GroupMember];
END
-- 70291310	View_CMS_Tree_Joined_Regular	1	IX_View_CMS_Tree_Joined_Regular_NodeSiteID_DocumentCulture_NodeID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_View_CMS_Tree_Joined_Regular_NodeSiteID_DocumentCulture_NodeID') 
 BEGIN 
	Create Unique Clustered Index [IX_View_CMS_Tree_Joined_Regular_NodeSiteID_DocumentCulture_NodeID] On [dbo].[View_CMS_Tree_Joined_Regular] ([NodeSiteID] Asc,[DocumentCulture] Asc,[NodeID] Asc,[NodeParentID] Asc,[DocumentID] Asc,[DocumentPublishedVersionHistoryID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 100, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_View_CMS_Tree_Joined_Regular_NodeSiteID_DocumentCulture_NodeID') 
 BEGIN 
	DROP INDEX [IX_View_CMS_Tree_Joined_Regular_NodeSiteID_DocumentCulture_NodeID] On [dbo].[View_CMS_Tree_Joined_Regular];
END
-- 70291310	View_CMS_Tree_Joined_Regular	2	PI_ClassLang	
IF NOT Exists (Select name from sys.indexes where name = 'PI_ClassLang') 
 BEGIN 
	Create NonClustered Index [PI_ClassLang] On [dbo].[View_CMS_Tree_Joined_Regular] ([ClassName] Asc,[DocumentCulture] Asc) Include ([DocumentForeignKeyValue],[NodeGUID])  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 100, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'PI_ClassLang') 
 BEGIN 
	DROP INDEX [PI_ClassLang] On [dbo].[View_CMS_Tree_Joined_Regular];
END
-- 70291310	View_CMS_Tree_Joined_Regular	4	PI_GuidLang	
IF NOT Exists (Select name from sys.indexes where name = 'PI_GuidLang') 
 BEGIN 
	Create NonClustered Index [PI_GuidLang] On [dbo].[View_CMS_Tree_Joined_Regular] ([NodeGUID] Asc,[DocumentCulture] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 100, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'PI_GuidLang') 
 BEGIN 
	DROP INDEX [PI_GuidLang] On [dbo].[View_CMS_Tree_Joined_Regular];
END
-- 70291310	View_CMS_Tree_Joined_Regular	5	IDX_View_CMS_Tree_Joined_Regular_NodeID_DocGuid	
IF NOT Exists (Select name from sys.indexes where name = 'IDX_View_CMS_Tree_Joined_Regular_NodeID_DocGuid') 
 BEGIN 
	Create NonClustered Index [IDX_View_CMS_Tree_Joined_Regular_NodeID_DocGuid] On [dbo].[View_CMS_Tree_Joined_Regular] ([ClassName] Asc) Include ([DocumentForeignKeyValue],[DocumentGUID],[DocumentPublishedVersionHistoryID],[NodeID],[NodeParentID])  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 100, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IDX_View_CMS_Tree_Joined_Regular_NodeID_DocGuid') 
 BEGIN 
	DROP INDEX [IDX_View_CMS_Tree_Joined_Regular_NodeID_DocGuid] On [dbo].[View_CMS_Tree_Joined_Regular];
END
-- 70291310	View_CMS_Tree_Joined_Regular	7	PI_View_CMS_Tree_Joined_Regular_DocumentCulture	
IF NOT Exists (Select name from sys.indexes where name = 'PI_View_CMS_Tree_Joined_Regular_DocumentCulture') 
 BEGIN 
	Create NonClustered Index [PI_View_CMS_Tree_Joined_Regular_DocumentCulture] On [dbo].[View_CMS_Tree_Joined_Regular] ([NodeID] Asc,[DocumentCulture] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 100, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'PI_View_CMS_Tree_Joined_Regular_DocumentCulture') 
 BEGIN 
	DROP INDEX [PI_View_CMS_Tree_Joined_Regular_DocumentCulture] On [dbo].[View_CMS_Tree_Joined_Regular];
END
-- 70291310	View_CMS_Tree_Joined_Regular	8	IX_View_CMS_Tree_Joined_Regular_DocumentCulture_NodeID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_View_CMS_Tree_Joined_Regular_DocumentCulture_NodeID') 
 BEGIN 
	Create NonClustered Index [IX_View_CMS_Tree_Joined_Regular_DocumentCulture_NodeID] On [dbo].[View_CMS_Tree_Joined_Regular] ([NodeID] Asc,[DocumentCulture] Asc,[DocumentGUID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 100, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_View_CMS_Tree_Joined_Regular_DocumentCulture_NodeID') 
 BEGIN 
	DROP INDEX [IX_View_CMS_Tree_Joined_Regular_DocumentCulture_NodeID] On [dbo].[View_CMS_Tree_Joined_Regular];
END
-- 1143675122	Board_Message	1	IX_Board_Message_MessageInserted	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Board_Message_MessageInserted') 
 BEGIN 
	Create Clustered Index [IX_Board_Message_MessageInserted] On [dbo].[Board_Message] ([MessageInserted] Desc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Board_Message_MessageInserted') 
 BEGIN 
	DROP INDEX [IX_Board_Message_MessageInserted] On [dbo].[Board_Message];
END
-- 555865047	Chat_Room	2	IX_Chat_Room_SiteID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Chat_Room_SiteID') 
 BEGIN 
	Create NonClustered Index [IX_Chat_Room_SiteID] On [dbo].[Chat_Room] ([ChatRoomSiteID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Chat_Room_SiteID') 
 BEGIN 
	DROP INDEX [IX_Chat_Room_SiteID] On [dbo].[Chat_Room];
END
-- 562101043	CMS_RelationshipName	3	IX_CMS_RelationshipName_RelationshipAllowedObjects	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_RelationshipName_RelationshipAllowedObjects') 
 BEGIN 
	Create NonClustered Index [IX_CMS_RelationshipName_RelationshipAllowedObjects] On [dbo].[CMS_RelationshipName] ([RelationshipAllowedObjects] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_RelationshipName_RelationshipAllowedObjects') 
 BEGIN 
	DROP INDEX [IX_CMS_RelationshipName_RelationshipAllowedObjects] On [dbo].[CMS_RelationshipName];
END
-- 564197060	CMS_UserSettings	4	IX_CMS_UserSettings_UserTimeZoneID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_UserSettings_UserTimeZoneID') 
 BEGIN 
	Create NonClustered Index [IX_CMS_UserSettings_UserTimeZoneID] On [dbo].[CMS_UserSettings] ([UserTimeZoneID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 100, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_UserSettings_UserTimeZoneID') 
 BEGIN 
	DROP INDEX [IX_CMS_UserSettings_UserTimeZoneID] On [dbo].[CMS_UserSettings];
END
-- 564197060	CMS_UserSettings	6	IX_CMS_UserSettings_UserBadgeID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_UserSettings_UserBadgeID') 
 BEGIN 
	Create NonClustered Index [IX_CMS_UserSettings_UserBadgeID] On [dbo].[CMS_UserSettings] ([UserBadgeID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_UserSettings_UserBadgeID') 
 BEGIN 
	DROP INDEX [IX_CMS_UserSettings_UserBadgeID] On [dbo].[CMS_UserSettings];
END
-- 564197060	CMS_UserSettings	7	IX_CMS_UserSettings_UserGender	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_UserSettings_UserGender') 
 BEGIN 
	Create NonClustered Index [IX_CMS_UserSettings_UserGender] On [dbo].[CMS_UserSettings] ([UserGender] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_UserSettings_UserGender') 
 BEGIN 
	DROP INDEX [IX_CMS_UserSettings_UserGender] On [dbo].[CMS_UserSettings];
END
-- 564197060	CMS_UserSettings	9	IX_CMS_UserSettings_UserSettingsUserID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_UserSettings_UserSettingsUserID') 
 BEGIN 
	Create Unique NonClustered Index [IX_CMS_UserSettings_UserSettingsUserID] On [dbo].[CMS_UserSettings] ([UserSettingsUserID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 100, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_UserSettings_UserSettingsUserID') 
 BEGIN 
	DROP INDEX [IX_CMS_UserSettings_UserSettingsUserID] On [dbo].[CMS_UserSettings];
END
-- 564197060	CMS_UserSettings	10	IX_CMS_UserSettings_WindowsLiveID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_UserSettings_WindowsLiveID') 
 BEGIN 
	Create NonClustered Index [IX_CMS_UserSettings_WindowsLiveID] On [dbo].[CMS_UserSettings] ([WindowsLiveID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_UserSettings_WindowsLiveID') 
 BEGIN 
	DROP INDEX [IX_CMS_UserSettings_WindowsLiveID] On [dbo].[CMS_UserSettings];
END
-- 564197060	CMS_UserSettings	12	IX_CMS_UserSettings_UserFacebookID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_UserSettings_UserFacebookID') 
 BEGIN 
	Create NonClustered Index [IX_CMS_UserSettings_UserFacebookID] On [dbo].[CMS_UserSettings] ([UserFacebookID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_UserSettings_UserFacebookID') 
 BEGIN 
	DROP INDEX [IX_CMS_UserSettings_UserFacebookID] On [dbo].[CMS_UserSettings];
END
-- 564197060	CMS_UserSettings	13	IX_CMS_UserSettings_UserAuthenticationGUID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_UserSettings_UserAuthenticationGUID') 
 BEGIN 
	Create NonClustered Index [IX_CMS_UserSettings_UserAuthenticationGUID] On [dbo].[CMS_UserSettings] ([UserAuthenticationGUID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_UserSettings_UserAuthenticationGUID') 
 BEGIN 
	DROP INDEX [IX_CMS_UserSettings_UserAuthenticationGUID] On [dbo].[CMS_UserSettings];
END
-- 1837249600	HFit_GoalOutcome	7	IX_GoalOutcome_WeekendGoalItem	
IF NOT Exists (Select name from sys.indexes where name = 'IX_GoalOutcome_WeekendGoalItem') 
 BEGIN 
	Create NonClustered Index [IX_GoalOutcome_WeekendGoalItem] On [dbo].[HFit_GoalOutcome] ([WeekendDate] Asc,[UserGoalItemID] Asc) Include ([IsCoachCreated],[Passed])  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_GoalOutcome_WeekendGoalItem') 
 BEGIN 
	DROP INDEX [IX_GoalOutcome_WeekendGoalItem] On [dbo].[HFit_GoalOutcome];
END
-- 1837249600	HFit_GoalOutcome	9	IX_GoalOutcome_ItemidPassed	
IF NOT Exists (Select name from sys.indexes where name = 'IX_GoalOutcome_ItemidPassed') 
 BEGIN 
	Create NonClustered Index [IX_GoalOutcome_ItemidPassed] On [dbo].[HFit_GoalOutcome] ([UserGoalItemID] Asc,[Passed] Asc,[Tracked] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 100, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_GoalOutcome_ItemidPassed') 
 BEGIN 
	DROP INDEX [IX_GoalOutcome_ItemidPassed] On [dbo].[HFit_GoalOutcome];
END
-- 1849773647	OM_Membership	4	IX_OM_Membership_ActiveContactID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_OM_Membership_ActiveContactID') 
 BEGIN 
	Create NonClustered Index [IX_OM_Membership_ActiveContactID] On [dbo].[OM_Membership] ([ActiveContactID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_OM_Membership_ActiveContactID') 
 BEGIN 
	DROP INDEX [IX_OM_Membership_ActiveContactID] On [dbo].[OM_Membership];
END
-- 1849773647	OM_Membership	7	nonActiveContactID	
IF NOT Exists (Select name from sys.indexes where name = 'nonActiveContactID') 
 BEGIN 
	Create NonClustered Index [nonActiveContactID] On [dbo].[OM_Membership] ([ActiveContactID] Asc,[RelatedID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'nonActiveContactID') 
 BEGIN 
	DROP INDEX [nonActiveContactID] On [dbo].[OM_Membership];
END
-- 1849773647	OM_Membership	9	nonRelatedID	
IF NOT Exists (Select name from sys.indexes where name = 'nonRelatedID') 
 BEGIN 
	Create NonClustered Index [nonRelatedID] On [dbo].[OM_Membership] ([RelatedID] Asc,[MemberType] Asc) Include ([OriginalContactID])  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'nonRelatedID') 
 BEGIN 
	DROP INDEX [nonRelatedID] On [dbo].[OM_Membership];
END
-- 1849773647	OM_Membership	13	nonMemIDActiveContID	
IF NOT Exists (Select name from sys.indexes where name = 'nonMemIDActiveContID') 
 BEGIN 
	Create NonClustered Index [nonMemIDActiveContID] On [dbo].[OM_Membership] ([MembershipID] Asc) Include ([ActiveContactID])  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 100, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'nonMemIDActiveContID') 
 BEGIN 
	DROP INDEX [nonMemIDActiveContID] On [dbo].[OM_Membership];
END
-- 1849773647	OM_Membership	16	nonRelMemTypeActContID	
IF NOT Exists (Select name from sys.indexes where name = 'nonRelMemTypeActContID') 
 BEGIN 
	Create NonClustered Index [nonRelMemTypeActContID] On [dbo].[OM_Membership] ([RelatedID] Asc,[MemberType] Asc,[ActiveContactID] Asc) Include ([MembershipID])  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'nonRelMemTypeActContID') 
 BEGIN 
	DROP INDEX [nonRelMemTypeActContID] On [dbo].[OM_Membership];
END
-- 1853965681	HFit_TrackerBloodSugarAndGlucose	14	idx_HFit_TrackerBloodSugarAndGlucose_UserIDEventDate	
IF NOT Exists (Select name from sys.indexes where name = 'idx_HFit_TrackerBloodSugarAndGlucose_UserIDEventDate') 
 BEGIN 
	Create NonClustered Index [idx_HFit_TrackerBloodSugarAndGlucose_UserIDEventDate] On [dbo].[HFit_TrackerBloodSugarAndGlucose] ([EventDate] Asc,[UserID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'idx_HFit_TrackerBloodSugarAndGlucose_UserIDEventDate') 
 BEGIN 
	DROP INDEX [idx_HFit_TrackerBloodSugarAndGlucose_UserIDEventDate] On [dbo].[HFit_TrackerBloodSugarAndGlucose];
END
-- 1853965681	HFit_TrackerBloodSugarAndGlucose	17	idx_HFit_TrackerBloodSugarAndGlucose_CreateDate	
IF NOT Exists (Select name from sys.indexes where name = 'idx_HFit_TrackerBloodSugarAndGlucose_CreateDate') 
 BEGIN 
	Create NonClustered Index [idx_HFit_TrackerBloodSugarAndGlucose_CreateDate] On [dbo].[HFit_TrackerBloodSugarAndGlucose] ([ItemCreatedWhen] Asc,[ItemModifiedWhen] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'idx_HFit_TrackerBloodSugarAndGlucose_CreateDate') 
 BEGIN 
	DROP INDEX [idx_HFit_TrackerBloodSugarAndGlucose_CreateDate] On [dbo].[HFit_TrackerBloodSugarAndGlucose];
END
-- 150291595	View_CMS_Tree_Joined_Linked	3	IX_View_CMS_Tree_Joined_Linked_ClassName	
IF NOT Exists (Select name from sys.indexes where name = 'IX_View_CMS_Tree_Joined_Linked_ClassName') 
 BEGIN 
	Create NonClustered Index [IX_View_CMS_Tree_Joined_Linked_ClassName] On [dbo].[View_CMS_Tree_Joined_Linked] ([ClassName] Asc) Include ([DocumentCheckedOutVersionHistoryID],[DocumentCreatedByUserID],[DocumentCreatedWhen],[DocumentCulture],[DocumentForeignKeyValue],[DocumentID],[DocumentIsArchived],[DocumentPublishedVersionHistoryID],[DocumentPublishFrom],[DocumentPublishTo],[NodeID],[NodeLevel])  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 100, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_View_CMS_Tree_Joined_Linked_ClassName') 
 BEGIN 
	DROP INDEX [IX_View_CMS_Tree_Joined_Linked_ClassName] On [dbo].[View_CMS_Tree_Joined_Linked];
END
-- 150291595	View_CMS_Tree_Joined_Linked	6	IX_View_CMS_Tree_Joined_Linked_ClassName_NodeSiteID_DocumentForeignKeyValue_DocumentCulture	
IF NOT Exists (Select name from sys.indexes where name = 'IX_View_CMS_Tree_Joined_Linked_ClassName_NodeSiteID_DocumentForeignKeyValue_DocumentCulture') 
 BEGIN 
	Create NonClustered Index [IX_View_CMS_Tree_Joined_Linked_ClassName_NodeSiteID_DocumentForeignKeyValue_DocumentCulture] On [dbo].[View_CMS_Tree_Joined_Linked] ([ClassName] Asc,[NodeSiteID] Asc,[DocumentForeignKeyValue] Asc,[DocumentCulture] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 100, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_View_CMS_Tree_Joined_Linked_ClassName_NodeSiteID_DocumentForeignKeyValue_DocumentCulture') 
 BEGIN 
	DROP INDEX [IX_View_CMS_Tree_Joined_Linked_ClassName_NodeSiteID_DocumentForeignKeyValue_DocumentCulture] On [dbo].[View_CMS_Tree_Joined_Linked];
END
-- 1739061877	HFit_TrackerDailySteps	12	idx_HFit_TrackerDailySteps_CreateDate	
IF NOT Exists (Select name from sys.indexes where name = 'idx_HFit_TrackerDailySteps_CreateDate') 
 BEGIN 
	Create NonClustered Index [idx_HFit_TrackerDailySteps_CreateDate] On [dbo].[HFit_TrackerDailySteps] ([ItemCreatedWhen] Asc,[ItemModifiedWhen] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'idx_HFit_TrackerDailySteps_CreateDate') 
 BEGIN 
	DROP INDEX [idx_HFit_TrackerDailySteps_CreateDate] On [dbo].[HFit_TrackerDailySteps];
END
-- 1325963800	HFit_TrackerSugaryFoods	5	idx_HFit_TrackerSugaryFoods_CreateDate	
IF NOT Exists (Select name from sys.indexes where name = 'idx_HFit_TrackerSugaryFoods_CreateDate') 
 BEGIN 
	Create NonClustered Index [idx_HFit_TrackerSugaryFoods_CreateDate] On [dbo].[HFit_TrackerSugaryFoods] ([ItemCreatedWhen] Asc,[ItemModifiedWhen] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'idx_HFit_TrackerSugaryFoods_CreateDate') 
 BEGIN 
	DROP INDEX [idx_HFit_TrackerSugaryFoods_CreateDate] On [dbo].[HFit_TrackerSugaryFoods];
END
-- 1330819803	OM_UserAgent	2	IX_OM_UserAgent_UserAgentActiveContactID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_OM_UserAgent_UserAgentActiveContactID') 
 BEGIN 
	Create NonClustered Index [IX_OM_UserAgent_UserAgentActiveContactID] On [dbo].[OM_UserAgent] ([UserAgentActiveContactID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_OM_UserAgent_UserAgentActiveContactID') 
 BEGIN 
	DROP INDEX [IX_OM_UserAgent_UserAgentActiveContactID] On [dbo].[OM_UserAgent];
END
-- 1351675863	Board_Board	2	IX_Board_Board_BoardDocumentID_BoardName	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Board_Board_BoardDocumentID_BoardName') 
 BEGIN 
	Create Unique NonClustered Index [IX_Board_Board_BoardDocumentID_BoardName] On [dbo].[Board_Board] ([BoardDocumentID] Asc,[BoardName] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Board_Board_BoardDocumentID_BoardName') 
 BEGIN 
	DROP INDEX [IX_Board_Board_BoardDocumentID_BoardName] On [dbo].[Board_Board];
END
-- 1351675863	Board_Board	4	IX_Board_Board_BoardUserID_BoardName	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Board_Board_BoardUserID_BoardName') 
 BEGIN 
	Create NonClustered Index [IX_Board_Board_BoardUserID_BoardName] On [dbo].[Board_Board] ([BoardUserID] Asc,[BoardName] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Board_Board_BoardUserID_BoardName') 
 BEGIN 
	DROP INDEX [IX_Board_Board_BoardUserID_BoardName] On [dbo].[Board_Board];
END
-- 1229247434	CMS_AutomationState	3	IX_CMS_AutomationState_StateObjectID_StateObjectType	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_AutomationState_StateObjectID_StateObjectType') 
 BEGIN 
	Create NonClustered Index [IX_CMS_AutomationState_StateObjectID_StateObjectType] On [dbo].[CMS_AutomationState] ([StateObjectID] Asc,[StateObjectType] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_AutomationState_StateObjectID_StateObjectType') 
 BEGIN 
	DROP INDEX [IX_CMS_AutomationState_StateObjectID_StateObjectType] On [dbo].[CMS_AutomationState];
END
-- 1242487505	HFit_TrackerHbA1c	13	idx_HFit_TrackerHbA1c_CreateDate	
IF NOT Exists (Select name from sys.indexes where name = 'idx_HFit_TrackerHbA1c_CreateDate') 
 BEGIN 
	Create NonClustered Index [idx_HFit_TrackerHbA1c_CreateDate] On [dbo].[HFit_TrackerHbA1c] ([ItemCreatedWhen] Asc,[ItemModifiedWhen] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'idx_HFit_TrackerHbA1c_CreateDate') 
 BEGIN 
	DROP INDEX [idx_HFit_TrackerHbA1c_CreateDate] On [dbo].[HFit_TrackerHbA1c];
END
-- 1019150676	Forums_Attachment	3	IX_Forums_Attachment_AttachmentPostID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Forums_Attachment_AttachmentPostID') 
 BEGIN 
	Create NonClustered Index [IX_Forums_Attachment_AttachmentPostID] On [dbo].[Forums_Attachment] ([AttachmentPostID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Forums_Attachment_AttachmentPostID') 
 BEGIN 
	DROP INDEX [IX_Forums_Attachment_AttachmentPostID] On [dbo].[Forums_Attachment];
END
-- 1426104121	Reporting_SavedReport	1	IX_Reporting_SavedReport_SavedReportReportID_SavedReportDate	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Reporting_SavedReport_SavedReportReportID_SavedReportDate') 
 BEGIN 
	Create Clustered Index [IX_Reporting_SavedReport_SavedReportReportID_SavedReportDate] On [dbo].[Reporting_SavedReport] ([SavedReportReportID] Asc,[SavedReportDate] Desc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Reporting_SavedReport_SavedReportReportID_SavedReportDate') 
 BEGIN 
	DROP INDEX [IX_Reporting_SavedReport_SavedReportReportID_SavedReportDate] On [dbo].[Reporting_SavedReport];
END
-- 1426104121	Reporting_SavedReport	3	IX_Reporting_SavedReport_SavedReportCreatedByUserID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Reporting_SavedReport_SavedReportCreatedByUserID') 
 BEGIN 
	Create NonClustered Index [IX_Reporting_SavedReport_SavedReportCreatedByUserID] On [dbo].[Reporting_SavedReport] ([SavedReportCreatedByUserID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Reporting_SavedReport_SavedReportCreatedByUserID') 
 BEGIN 
	DROP INDEX [IX_Reporting_SavedReport_SavedReportCreatedByUserID] On [dbo].[Reporting_SavedReport];
END
-- 1602104748	Reporting_ReportGraph	3	IX_Reporting_ReportGraph_GraphGUID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Reporting_ReportGraph_GraphGUID') 
 BEGIN 
	Create Unique NonClustered Index [IX_Reporting_ReportGraph_GraphGUID] On [dbo].[Reporting_ReportGraph] ([GraphGUID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Reporting_ReportGraph_GraphGUID') 
 BEGIN 
	DROP INDEX [IX_Reporting_ReportGraph_GraphGUID] On [dbo].[Reporting_ReportGraph];
END
-- 1604200765	CMS_ObjectVersionHistory	1	PK_CMS_ObjectVersionHistory	
IF NOT Exists (Select name from sys.indexes where name = 'PK_CMS_ObjectVersionHistory') 
 BEGIN 
	Create Unique Clustered Index [PK_CMS_ObjectVersionHistory] On [dbo].[CMS_ObjectVersionHistory] ([VersionObjectType] Asc,[VersionObjectID] Asc,[VersionID] Desc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 100, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'PK_CMS_ObjectVersionHistory') 
 BEGIN 
	DROP INDEX [PK_CMS_ObjectVersionHistory] On [dbo].[CMS_ObjectVersionHistory];
END
-- 1604200765	CMS_ObjectVersionHistory	4	IX_CMS_ObjectVersionHistory_VersionObjectSiteID_VersionDeletedWhen	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_ObjectVersionHistory_VersionObjectSiteID_VersionDeletedWhen') 
 BEGIN 
	Create NonClustered Index [IX_CMS_ObjectVersionHistory_VersionObjectSiteID_VersionDeletedWhen] On [dbo].[CMS_ObjectVersionHistory] ([VersionObjectSiteID] Asc,[VersionDeletedWhen] Desc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 100, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_ObjectVersionHistory_VersionObjectSiteID_VersionDeletedWhen') 
 BEGIN 
	DROP INDEX [IX_CMS_ObjectVersionHistory_VersionObjectSiteID_VersionDeletedWhen] On [dbo].[CMS_ObjectVersionHistory];
END
-- 1969754420	dbo_HFit_HealthAssesmentUserAnswers_CT	2	dbo_HFit_HealthAssesmentUserAnswers_CT_idx	
IF NOT Exists (Select name from sys.indexes where name = 'dbo_HFit_HealthAssesmentUserAnswers_CT_idx') 
 BEGIN 
	Create Unique NonClustered Index [dbo_HFit_HealthAssesmentUserAnswers_CT_idx] On [cdc].[dbo_HFit_HealthAssesmentUserAnswers_CT] ([ItemID] Asc,[__$seqval] Asc,[__$operation] Asc) Include ([__$start_lsn],[__$update_mask])  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'dbo_HFit_HealthAssesmentUserAnswers_CT_idx') 
 BEGIN 
	DROP INDEX [dbo_HFit_HealthAssesmentUserAnswers_CT_idx] On [cdc].[dbo_HFit_HealthAssesmentUserAnswers_CT];
END
-- 1981966137	CMS_Badge	1	IX_CMS_Badge_BadgeTopLimit	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_Badge_BadgeTopLimit') 
 BEGIN 
	Create Clustered Index [IX_CMS_Badge_BadgeTopLimit] On [dbo].[CMS_Badge] ([BadgeTopLimit] Desc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_Badge_BadgeTopLimit') 
 BEGIN 
	DROP INDEX [IX_CMS_Badge_BadgeTopLimit] On [dbo].[CMS_Badge];
END
-- 1988202133	CMS_PageTemplateCategory	1	IX_CMS_PageTemplateCategory_CategoryPath	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_PageTemplateCategory_CategoryPath') 
 BEGIN 
	Create Unique Clustered Index [IX_CMS_PageTemplateCategory_CategoryPath] On [dbo].[CMS_PageTemplateCategory] ([CategoryPath] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_PageTemplateCategory_CategoryPath') 
 BEGIN 
	DROP INDEX [IX_CMS_PageTemplateCategory_CategoryPath] On [dbo].[CMS_PageTemplateCategory];
END
-- 1988202133	CMS_PageTemplateCategory	4	IX_CMS_PageTemplateCategory_CategoryLevel	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_PageTemplateCategory_CategoryLevel') 
 BEGIN 
	Create NonClustered Index [IX_CMS_PageTemplateCategory_CategoryLevel] On [dbo].[CMS_PageTemplateCategory] ([CategoryLevel] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_PageTemplateCategory_CategoryLevel') 
 BEGIN 
	DROP INDEX [IX_CMS_PageTemplateCategory_CategoryLevel] On [dbo].[CMS_PageTemplateCategory];
END
-- 1989582126	COM_DiscountLevel	1	IX_COM_DiscountLevel_DiscountLevelDisplayName_DiscountLevelEnabled	
IF NOT Exists (Select name from sys.indexes where name = 'IX_COM_DiscountLevel_DiscountLevelDisplayName_DiscountLevelEnabled') 
 BEGIN 
	Create Clustered Index [IX_COM_DiscountLevel_DiscountLevelDisplayName_DiscountLevelEnabled] On [dbo].[COM_DiscountLevel] ([DiscountLevelDisplayName] Asc,[DiscountLevelEnabled] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_COM_DiscountLevel_DiscountLevelDisplayName_DiscountLevelEnabled') 
 BEGIN 
	DROP INDEX [IX_COM_DiscountLevel_DiscountLevelDisplayName_DiscountLevelEnabled] On [dbo].[COM_DiscountLevel];
END
-- 2081442489	HFit_TrackerSleepPlan	5	idx_HFit_TrackerSleepPlan_CreateDate	
IF NOT Exists (Select name from sys.indexes where name = 'idx_HFit_TrackerSleepPlan_CreateDate') 
 BEGIN 
	Create NonClustered Index [idx_HFit_TrackerSleepPlan_CreateDate] On [dbo].[HFit_TrackerSleepPlan] ([ItemCreatedWhen] Asc,[ItemModifiedWhen] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'idx_HFit_TrackerSleepPlan_CreateDate') 
 BEGIN 
	DROP INDEX [idx_HFit_TrackerSleepPlan_CreateDate] On [dbo].[HFit_TrackerSleepPlan];
END
-- 2085582468	COM_Address	3	IX_COM_Address_AddressCountryID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_COM_Address_AddressCountryID') 
 BEGIN 
	Create NonClustered Index [IX_COM_Address_AddressCountryID] On [dbo].[COM_Address] ([AddressCountryID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_COM_Address_AddressCountryID') 
 BEGIN 
	DROP INDEX [IX_COM_Address_AddressCountryID] On [dbo].[COM_Address];
END
-- 2086298492	Chat_User	2	IX_Chat_User_UserID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Chat_User_UserID') 
 BEGIN 
	Create NonClustered Index [IX_Chat_User_UserID] On [dbo].[Chat_User] ([ChatUserUserID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Chat_User_UserID') 
 BEGIN 
	DROP INDEX [IX_Chat_User_UserID] On [dbo].[Chat_User];
END
-- 2114106572	CMS_WebFarmServerTask	5	CMS_WebFarmServerTask_idx_01	
IF NOT Exists (Select name from sys.indexes where name = 'CMS_WebFarmServerTask_idx_01') 
 BEGIN 
	Create NonClustered Index [CMS_WebFarmServerTask_idx_01] On [dbo].[CMS_WebFarmServerTask] ([TaskID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'CMS_WebFarmServerTask_idx_01') 
 BEGIN 
	DROP INDEX [CMS_WebFarmServerTask_idx_01] On [dbo].[CMS_WebFarmServerTask];
END
-- 2132918670	HFit_RewardsUserLevelDetail	11	PI_HFit_RewardsUserLevelDetail_LevelNodeID	
IF NOT Exists (Select name from sys.indexes where name = 'PI_HFit_RewardsUserLevelDetail_LevelNodeID') 
 BEGIN 
	Create NonClustered Index [PI_HFit_RewardsUserLevelDetail_LevelNodeID] On [dbo].[HFit_RewardsUserLevelDetail] ([LevelNodeID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 100, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'PI_HFit_RewardsUserLevelDetail_LevelNodeID') 
 BEGIN 
	DROP INDEX [PI_HFit_RewardsUserLevelDetail_LevelNodeID] On [dbo].[HFit_RewardsUserLevelDetail];
END
-- 2141250683	Staging_Server	1	IX_Staging_Server_ServerSiteID_ServerDisplayName	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Staging_Server_ServerSiteID_ServerDisplayName') 
 BEGIN 
	Create Clustered Index [IX_Staging_Server_ServerSiteID_ServerDisplayName] On [dbo].[Staging_Server] ([ServerSiteID] Asc,[ServerDisplayName] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Staging_Server_ServerSiteID_ServerDisplayName') 
 BEGIN 
	DROP INDEX [IX_Staging_Server_ServerSiteID_ServerDisplayName] On [dbo].[Staging_Server];
END
-- 889770227	Reporting_Report	3	IX_Reporting_Report_ReportGUID_ReportName	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Reporting_Report_ReportGUID_ReportName') 
 BEGIN 
	Create NonClustered Index [IX_Reporting_Report_ReportGUID_ReportName] On [dbo].[Reporting_Report] ([ReportGUID] Asc,[ReportName] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Reporting_Report_ReportGUID_ReportName') 
 BEGIN 
	DROP INDEX [IX_Reporting_Report_ReportGUID_ReportName] On [dbo].[Reporting_Report];
END
-- 1654296953	Media_File	3	IX_Media_File_FileSiteID_FileGUID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Media_File_FileSiteID_FileGUID') 
 BEGIN 
	Create NonClustered Index [IX_Media_File_FileSiteID_FileGUID] On [dbo].[Media_File] ([FileSiteID] Asc,[FileGUID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Media_File_FileSiteID_FileGUID') 
 BEGIN 
	DROP INDEX [IX_Media_File_FileSiteID_FileGUID] On [dbo].[Media_File];
END
-- 1654296953	Media_File	6	IX_Media_File_FileModifiedByUserID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Media_File_FileModifiedByUserID') 
 BEGIN 
	Create NonClustered Index [IX_Media_File_FileModifiedByUserID] On [dbo].[Media_File] ([FileModifiedByUserID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Media_File_FileModifiedByUserID') 
 BEGIN 
	DROP INDEX [IX_Media_File_FileModifiedByUserID] On [dbo].[Media_File];
END
-- 1662628966	CMS_SiteDomainAlias	3	IX_CMS_SiteDomainAlias_SiteID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_SiteDomainAlias_SiteID') 
 BEGIN 
	Create NonClustered Index [IX_CMS_SiteDomainAlias_SiteID] On [dbo].[CMS_SiteDomainAlias] ([SiteID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_SiteDomainAlias_SiteID') 
 BEGIN 
	DROP INDEX [IX_CMS_SiteDomainAlias_SiteID] On [dbo].[CMS_SiteDomainAlias];
END
-- 1669580986	OM_Account	2	IX_OM_Account_AccountStateID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_OM_Account_AccountStateID') 
 BEGIN 
	Create NonClustered Index [IX_OM_Account_AccountStateID] On [dbo].[OM_Account] ([AccountStateID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_OM_Account_AccountStateID') 
 BEGIN 
	DROP INDEX [IX_OM_Account_AccountStateID] On [dbo].[OM_Account];
END
-- 1669580986	OM_Account	5	IX_OM_Account_AccountSecondaryContactID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_OM_Account_AccountSecondaryContactID') 
 BEGIN 
	Create NonClustered Index [IX_OM_Account_AccountSecondaryContactID] On [dbo].[OM_Account] ([AccountSecondaryContactID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_OM_Account_AccountSecondaryContactID') 
 BEGIN 
	DROP INDEX [IX_OM_Account_AccountSecondaryContactID] On [dbo].[OM_Account];
END
-- 1669580986	OM_Account	8	IX_OM_Account_AccountSubsidiaryOfID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_OM_Account_AccountSubsidiaryOfID') 
 BEGIN 
	Create NonClustered Index [IX_OM_Account_AccountSubsidiaryOfID] On [dbo].[OM_Account] ([AccountSubsidiaryOfID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_OM_Account_AccountSubsidiaryOfID') 
 BEGIN 
	DROP INDEX [IX_OM_Account_AccountSubsidiaryOfID] On [dbo].[OM_Account];
END
-- 1669580986	OM_Account	11	IX_OM_Account_AccountGlobalAccountID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_OM_Account_AccountGlobalAccountID') 
 BEGIN 
	Create NonClustered Index [IX_OM_Account_AccountGlobalAccountID] On [dbo].[OM_Account] ([AccountGlobalAccountID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_OM_Account_AccountGlobalAccountID') 
 BEGIN 
	DROP INDEX [IX_OM_Account_AccountGlobalAccountID] On [dbo].[OM_Account];
END
-- 1085246921	CMS_WorkflowScope	3	IX_CMS_WorkflowScope_ScopeWorkflowID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_WorkflowScope_ScopeWorkflowID') 
 BEGIN 
	Create NonClustered Index [IX_CMS_WorkflowScope_ScopeWorkflowID] On [dbo].[CMS_WorkflowScope] ([ScopeWorkflowID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_WorkflowScope_ScopeWorkflowID') 
 BEGIN 
	DROP INDEX [IX_CMS_WorkflowScope_ScopeWorkflowID] On [dbo].[CMS_WorkflowScope];
END
-- 1085246921	CMS_WorkflowScope	6	IX_CMS_WorkflowScope_ScopeCultureID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_WorkflowScope_ScopeCultureID') 
 BEGIN 
	Create NonClustered Index [IX_CMS_WorkflowScope_ScopeCultureID] On [dbo].[CMS_WorkflowScope] ([ScopeCultureID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_WorkflowScope_ScopeCultureID') 
 BEGIN 
	DROP INDEX [IX_CMS_WorkflowScope_ScopeCultureID] On [dbo].[CMS_WorkflowScope];
END
-- 1090818948	CMS_Form	3	IX_CMS_Form_FormClassID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_Form_FormClassID') 
 BEGIN 
	Create NonClustered Index [IX_CMS_Form_FormClassID] On [dbo].[CMS_Form] ([FormClassID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_Form_FormClassID') 
 BEGIN 
	DROP INDEX [IX_CMS_Form_FormClassID] On [dbo].[CMS_Form];
END
-- 1102626971	CMS_Culture	3	IX_CMS_Culture_CultureCode	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_Culture_CultureCode') 
 BEGIN 
	Create NonClustered Index [IX_CMS_Culture_CultureCode] On [dbo].[CMS_Culture] ([CultureCode] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_Culture_CultureCode') 
 BEGIN 
	DROP INDEX [IX_CMS_Culture_CultureCode] On [dbo].[CMS_Culture];
END
-- 813245952	CMS_WebPartCategory	3	IX_CMS_WebPartCategory_CategoryParentID_CategoryOrder	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_WebPartCategory_CategoryParentID_CategoryOrder') 
 BEGIN 
	Create NonClustered Index [IX_CMS_WebPartCategory_CategoryParentID_CategoryOrder] On [dbo].[CMS_WebPartCategory] ([CategoryParentID] Asc,[CategoryOrder] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_WebPartCategory_CategoryParentID_CategoryOrder') 
 BEGIN 
	DROP INDEX [IX_CMS_WebPartCategory_CategoryParentID_CategoryOrder] On [dbo].[CMS_WebPartCategory];
END
-- 121767491	Staging_Task	3	IX_Staging_Task_TaskSiteID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Staging_Task_TaskSiteID') 
 BEGIN 
	Create NonClustered Index [IX_Staging_Task_TaskSiteID] On [dbo].[Staging_Task] ([TaskSiteID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Staging_Task_TaskSiteID') 
 BEGIN 
	DROP INDEX [IX_Staging_Task_TaskSiteID] On [dbo].[Staging_Task];
END
-- 121767491	Staging_Task	6	IX_Staging_Task_TaskObjectType_TaskObjectID_TaskRunning	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Staging_Task_TaskObjectType_TaskObjectID_TaskRunning') 
 BEGIN 
	Create NonClustered Index [IX_Staging_Task_TaskObjectType_TaskObjectID_TaskRunning] On [dbo].[Staging_Task] ([TaskObjectType] Asc,[TaskObjectID] Asc,[TaskRunning] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Staging_Task_TaskObjectType_TaskObjectID_TaskRunning') 
 BEGIN 
	DROP INDEX [IX_Staging_Task_TaskObjectType_TaskObjectID_TaskRunning] On [dbo].[Staging_Task];
END
-- 125243501	OM_AccountContact	3	IX_OM_AccountContact_AccountID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_OM_AccountContact_AccountID') 
 BEGIN 
	Create NonClustered Index [IX_OM_AccountContact_AccountID] On [dbo].[OM_AccountContact] ([AccountID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 100, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_OM_AccountContact_AccountID') 
 BEGIN 
	DROP INDEX [IX_OM_AccountContact_AccountID] On [dbo].[OM_AccountContact];
END
-- 142623551	CMS_Tag	3	IX_CMS_Tag_TagGroupID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_Tag_TagGroupID') 
 BEGIN 
	Create NonClustered Index [IX_CMS_Tag_TagGroupID] On [dbo].[CMS_Tag] ([TagGroupID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_Tag_TagGroupID') 
 BEGIN 
	DROP INDEX [IX_CMS_Tag_TagGroupID] On [dbo].[CMS_Tag];
END
-- 143339575	HFit_HealthAssesmentUserQuestion	4	IX_HFit_HealthAssesmentUserQuestion_1	
IF NOT Exists (Select name from sys.indexes where name = 'IX_HFit_HealthAssesmentUserQuestion_1') 
 BEGIN 
	Create NonClustered Index [IX_HFit_HealthAssesmentUserQuestion_1] On [dbo].[HFit_HealthAssesmentUserQuestion] ([UserID] Asc) Include ([HAQuestionNodeGUID])  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 100, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_HFit_HealthAssesmentUserQuestion_1') 
 BEGIN 
	DROP INDEX [IX_HFit_HealthAssesmentUserQuestion_1] On [dbo].[HFit_HealthAssesmentUserQuestion];
END
-- 143339575	HFit_HealthAssesmentUserQuestion	10	idx_UserQuestionCodeName	
IF NOT Exists (Select name from sys.indexes where name = 'idx_UserQuestionCodeName') 
 BEGIN 
	Create NonClustered Index [idx_UserQuestionCodeName] On [dbo].[HFit_HealthAssesmentUserQuestion] ([CodeName] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'idx_UserQuestionCodeName') 
 BEGIN 
	DROP INDEX [idx_UserQuestionCodeName] On [dbo].[HFit_HealthAssesmentUserQuestion];
END
-- 1858105660	Integration_Task	1	IX_Integration_Task_TaskNodeAliasPath	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Integration_Task_TaskNodeAliasPath') 
 BEGIN 
	Create Clustered Index [IX_Integration_Task_TaskNodeAliasPath] On [dbo].[Integration_Task] ([TaskNodeAliasPath] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Integration_Task_TaskNodeAliasPath') 
 BEGIN 
	DROP INDEX [IX_Integration_Task_TaskNodeAliasPath] On [dbo].[Integration_Task];
END
-- 1858105660	Integration_Task	4	IX_Integration_Task_TaskSiteID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Integration_Task_TaskSiteID') 
 BEGIN 
	Create NonClustered Index [IX_Integration_Task_TaskSiteID] On [dbo].[Integration_Task] ([TaskSiteID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Integration_Task_TaskSiteID') 
 BEGIN 
	DROP INDEX [IX_Integration_Task_TaskSiteID] On [dbo].[Integration_Task];
END
-- 1867153697	OM_ABTest	2	IX_OM_ABTest_SiteID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_OM_ABTest_SiteID') 
 BEGIN 
	Create NonClustered Index [IX_OM_ABTest_SiteID] On [dbo].[OM_ABTest] ([ABTestSiteID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_OM_ABTest_SiteID') 
 BEGIN 
	DROP INDEX [IX_OM_ABTest_SiteID] On [dbo].[OM_ABTest];
END
-- 70291310	View_CMS_Tree_Joined_Regular	121	PI_CMS_Tree_Joined_Regular_NODE_FK	
IF NOT Exists (Select name from sys.indexes where name = 'PI_CMS_Tree_Joined_Regular_NODE_FK') 
 BEGIN 
	Create NonClustered Index [PI_CMS_Tree_Joined_Regular_NODE_FK] On [dbo].[View_CMS_Tree_Joined_Regular] ([ClassName] Asc) Include ([NodeGUID],[DocumentForeignKeyValue])  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 100, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'PI_CMS_Tree_Joined_Regular_NODE_FK') 
 BEGIN 
	DROP INDEX [PI_CMS_Tree_Joined_Regular_NODE_FK] On [dbo].[View_CMS_Tree_Joined_Regular];
END
-- 70291310	View_CMS_Tree_Joined_Regular	124	PI_CMSTREE_ClassDocID	
IF NOT Exists (Select name from sys.indexes where name = 'PI_CMSTREE_ClassDocID') 
 BEGIN 
	Create NonClustered Index [PI_CMSTREE_ClassDocID] On [dbo].[View_CMS_Tree_Joined_Regular] ([ClassName] Asc,[DocumentID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 100, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'PI_CMSTREE_ClassDocID') 
 BEGIN 
	DROP INDEX [PI_CMSTREE_ClassDocID] On [dbo].[View_CMS_Tree_Joined_Regular];
END
-- 791673868	Community_Group	3	IX_Community_Group_GroupSiteID_GroupName	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Community_Group_GroupSiteID_GroupName') 
 BEGIN 
	Create NonClustered Index [IX_Community_Group_GroupSiteID_GroupName] On [dbo].[Community_Group] ([GroupSiteID] Asc,[GroupName] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Community_Group_GroupSiteID_GroupName') 
 BEGIN 
	DROP INDEX [IX_Community_Group_GroupSiteID_GroupName] On [dbo].[Community_Group];
END
-- 2103678542	CMS_User	2	IX_CMS_User_UserName	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_User_UserName') 
 BEGIN 
	Create Unique NonClustered Index [IX_CMS_User_UserName] On [dbo].[CMS_User] ([UserName] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_User_UserName') 
 BEGIN 
	DROP INDEX [IX_CMS_User_UserName] On [dbo].[CMS_User];
END
-- 1143675122	Board_Message	3	IX_Board_Message_MessageApproved_MessageIsSpam	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Board_Message_MessageApproved_MessageIsSpam') 
 BEGIN 
	Create NonClustered Index [IX_Board_Message_MessageApproved_MessageIsSpam] On [dbo].[Board_Message] ([MessageApproved] Asc,[MessageIsSpam] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Board_Message_MessageApproved_MessageIsSpam') 
 BEGIN 
	DROP INDEX [IX_Board_Message_MessageApproved_MessageIsSpam] On [dbo].[Board_Message];
END
-- 1143675122	Board_Message	6	IX_Board_Message_MessageUserID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Board_Message_MessageUserID') 
 BEGIN 
	Create NonClustered Index [IX_Board_Message_MessageUserID] On [dbo].[Board_Message] ([MessageUserID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Board_Message_MessageUserID') 
 BEGIN 
	DROP INDEX [IX_Board_Message_MessageUserID] On [dbo].[Board_Message];
END
-- 690101499	CMS_ObjectRelationship	3	IX_CMS_ObjectRelationship_RelationshipRightObjectType_RelationshipRightObjectID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_ObjectRelationship_RelationshipRightObjectType_RelationshipRightObjectID') 
 BEGIN 
	Create NonClustered Index [IX_CMS_ObjectRelationship_RelationshipRightObjectType_RelationshipRightObjectID] On [dbo].[CMS_ObjectRelationship] ([RelationshipRightObjectType] Asc,[RelationshipRightObjectID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 100, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_ObjectRelationship_RelationshipRightObjectType_RelationshipRightObjectID') 
 BEGIN 
	DROP INDEX [IX_CMS_ObjectRelationship_RelationshipRightObjectType_RelationshipRightObjectID] On [dbo].[CMS_ObjectRelationship];
END
-- 690257664	HFit_TrackerBMI	13	idx_HFit_TrackerBMI_UserIDEventDate	
IF NOT Exists (Select name from sys.indexes where name = 'idx_HFit_TrackerBMI_UserIDEventDate') 
 BEGIN 
	Create NonClustered Index [idx_HFit_TrackerBMI_UserIDEventDate] On [dbo].[HFit_TrackerBMI] ([UserID] Asc) Include ([EventDate])  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'idx_HFit_TrackerBMI_UserIDEventDate') 
 BEGIN 
	DROP INDEX [idx_HFit_TrackerBMI_UserIDEventDate] On [dbo].[HFit_TrackerBMI];
END
-- 699865560	Chat_Message	2	IX_Chat_Message_ChatMessageRoomID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Chat_Message_ChatMessageRoomID') 
 BEGIN 
	Create NonClustered Index [IX_Chat_Message_ChatMessageRoomID] On [dbo].[Chat_Message] ([ChatMessageRoomID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Chat_Message_ChatMessageRoomID') 
 BEGIN 
	DROP INDEX [IX_Chat_Message_ChatMessageRoomID] On [dbo].[Chat_Message];
END
-- 983674552	CMS_Avatar	4	IX_CMS_Avatar_AvatarGUID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_Avatar_AvatarGUID') 
 BEGIN 
	Create NonClustered Index [IX_CMS_Avatar_AvatarGUID] On [dbo].[CMS_Avatar] ([AvatarGUID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_Avatar_AvatarGUID') 
 BEGIN 
	DROP INDEX [IX_CMS_Avatar_AvatarGUID] On [dbo].[CMS_Avatar];
END
-- 1492200366	CMS_ResourceString	1	IX_CMS_ResourceString_StringLoadGeneration	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_ResourceString_StringLoadGeneration') 
 BEGIN 
	Create Clustered Index [IX_CMS_ResourceString_StringLoadGeneration] On [dbo].[CMS_ResourceString] ([StringLoadGeneration] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_ResourceString_StringLoadGeneration') 
 BEGIN 
	DROP INDEX [IX_CMS_ResourceString_StringLoadGeneration] On [dbo].[CMS_ResourceString];
END
-- 1531152500	Forums_Forum	1	IX_Forums_Forum_ForumGroupID_ForumOrder	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Forums_Forum_ForumGroupID_ForumOrder') 
 BEGIN 
	Create Clustered Index [IX_Forums_Forum_ForumGroupID_ForumOrder] On [dbo].[Forums_Forum] ([ForumGroupID] Asc,[ForumOrder] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Forums_Forum_ForumGroupID_ForumOrder') 
 BEGIN 
	DROP INDEX [IX_Forums_Forum_ForumGroupID_ForumOrder] On [dbo].[Forums_Forum];
END
-- 1531152500	Forums_Forum	4	IX_Forums_Forum_ForumDocumentID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Forums_Forum_ForumDocumentID') 
 BEGIN 
	Create NonClustered Index [IX_Forums_Forum_ForumDocumentID] On [dbo].[Forums_Forum] ([ForumDocumentID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Forums_Forum_ForumDocumentID') 
 BEGIN 
	DROP INDEX [IX_Forums_Forum_ForumDocumentID] On [dbo].[Forums_Forum];
END
-- 103671417	CMS_Session	1	IX_CMS_Session_SessionLocation	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_Session_SessionLocation') 
 BEGIN 
	Create Clustered Index [IX_CMS_Session_SessionLocation] On [dbo].[CMS_Session] ([SessionLocation] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_Session_SessionLocation') 
 BEGIN 
	DROP INDEX [IX_CMS_Session_SessionLocation] On [dbo].[CMS_Session];
END
-- 114099447	COM_OrderStatusUser	5	IX_COM_OrderStatusUser_ChangedByUserID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_COM_OrderStatusUser_ChangedByUserID') 
 BEGIN 
	Create NonClustered Index [IX_COM_OrderStatusUser_ChangedByUserID] On [dbo].[COM_OrderStatusUser] ([ChangedByUserID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_COM_OrderStatusUser_ChangedByUserID') 
 BEGIN 
	DROP INDEX [IX_COM_OrderStatusUser_ChangedByUserID] On [dbo].[COM_OrderStatusUser];
END
-- 1303779802	HFit_RewardException	7	HFit_RewardException_PiDate	
IF NOT Exists (Select name from sys.indexes where name = 'HFit_RewardException_PiDate') 
 BEGIN 
	Create NonClustered Index [HFit_RewardException_PiDate] On [dbo].[HFit_RewardException] ([ItemModifiedWhen] Asc) Include ([ItemCreatedWhen])  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 100, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'HFit_RewardException_PiDate') 
 BEGIN 
	DROP INDEX [HFit_RewardException_PiDate] On [dbo].[HFit_RewardException];
END
-- 1316199739	CMS_ACL	2	IX_CMS_ACL_ACLInheritedACLs	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_ACL_ACLInheritedACLs') 
 BEGIN 
	Create NonClustered Index [IX_CMS_ACL_ACLInheritedACLs] On [dbo].[CMS_ACL] ([ACLInheritedACLs] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_ACL_ACLInheritedACLs') 
 BEGIN 
	DROP INDEX [IX_CMS_ACL_ACLInheritedACLs] On [dbo].[CMS_ACL];
END
-- 837578022	PM_Project	2	IX_PM_Project_ProjectNodeID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_PM_Project_ProjectNodeID') 
 BEGIN 
	Create NonClustered Index [IX_PM_Project_ProjectNodeID] On [dbo].[PM_Project] ([ProjectNodeID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 100, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_PM_Project_ProjectNodeID') 
 BEGIN 
	DROP INDEX [IX_PM_Project_ProjectNodeID] On [dbo].[PM_Project];
END
-- 837578022	PM_Project	5	IX_PM_Project_ProjectStatusID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_PM_Project_ProjectStatusID') 
 BEGIN 
	Create NonClustered Index [IX_PM_Project_ProjectStatusID] On [dbo].[PM_Project] ([ProjectStatusID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 100, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_PM_Project_ProjectStatusID') 
 BEGIN 
	DROP INDEX [IX_PM_Project_ProjectStatusID] On [dbo].[PM_Project];
END
-- 838294046	Blog_Comment	1	IX_Blog_Comment_CommentDate	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Blog_Comment_CommentDate') 
 BEGIN 
	Create Clustered Index [IX_Blog_Comment_CommentDate] On [dbo].[Blog_Comment] ([CommentDate] Desc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Blog_Comment_CommentDate') 
 BEGIN 
	DROP INDEX [IX_Blog_Comment_CommentDate] On [dbo].[Blog_Comment];
END
-- 838294046	Blog_Comment	4	IX_Blog_Comment_CommentApprovedByUserID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Blog_Comment_CommentApprovedByUserID') 
 BEGIN 
	Create NonClustered Index [IX_Blog_Comment_CommentApprovedByUserID] On [dbo].[Blog_Comment] ([CommentApprovedByUserID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Blog_Comment_CommentApprovedByUserID') 
 BEGIN 
	DROP INDEX [IX_Blog_Comment_CommentApprovedByUserID] On [dbo].[Blog_Comment];
END
-- 843150049	Forums_UserFavorites	2	IX_Forums_UserFavorites_UserID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Forums_UserFavorites_UserID') 
 BEGIN 
	Create NonClustered Index [IX_Forums_UserFavorites_UserID] On [dbo].[Forums_UserFavorites] ([UserID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Forums_UserFavorites_UserID') 
 BEGIN 
	DROP INDEX [IX_Forums_UserFavorites_UserID] On [dbo].[Forums_UserFavorites];
END
-- 843150049	Forums_UserFavorites	5	IX_Forums_UserFavorites_ForumID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Forums_UserFavorites_ForumID') 
 BEGIN 
	Create NonClustered Index [IX_Forums_UserFavorites_ForumID] On [dbo].[Forums_UserFavorites] ([ForumID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Forums_UserFavorites_ForumID') 
 BEGIN 
	DROP INDEX [IX_Forums_UserFavorites_ForumID] On [dbo].[Forums_UserFavorites];
END
-- 2034822311	HFit_HealthAssesmentUserRiskArea	3	IX_HFit_HealthAssesmentUserRiskArea_1	
IF NOT Exists (Select name from sys.indexes where name = 'IX_HFit_HealthAssesmentUserRiskArea_1') 
 BEGIN 
	Create NonClustered Index [IX_HFit_HealthAssesmentUserRiskArea_1] On [dbo].[HFit_HealthAssesmentUserRiskArea] ([UserID] Asc) Include ([HARiskAreaNodeGUID])  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_HFit_HealthAssesmentUserRiskArea_1') 
 BEGIN 
	DROP INDEX [IX_HFit_HealthAssesmentUserRiskArea_1] On [dbo].[HFit_HealthAssesmentUserRiskArea];
END
-- 2050874423	HFit_TrackerSitLess	5	idx_HFit_TrackerSitLess_CreateDate	
IF NOT Exists (Select name from sys.indexes where name = 'idx_HFit_TrackerSitLess_CreateDate') 
 BEGIN 
	Create NonClustered Index [idx_HFit_TrackerSitLess_CreateDate] On [dbo].[HFit_TrackerSitLess] ([ItemCreatedWhen] Asc,[ItemModifiedWhen] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'idx_HFit_TrackerSitLess_CreateDate') 
 BEGIN 
	DROP INDEX [idx_HFit_TrackerSitLess_CreateDate] On [dbo].[HFit_TrackerSitLess];
END
-- 2052202361	CMS_PageTemplate	1	IX_CMS_PageTemplate_PageTemplateCategoryID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_PageTemplate_PageTemplateCategoryID') 
 BEGIN 
	Create Clustered Index [IX_CMS_PageTemplate_PageTemplateCategoryID] On [dbo].[CMS_PageTemplate] ([PageTemplateCategoryID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_PageTemplate_PageTemplateCategoryID') 
 BEGIN 
	DROP INDEX [IX_CMS_PageTemplate_PageTemplateCategoryID] On [dbo].[CMS_PageTemplate];
END
-- 2052202361	CMS_PageTemplate	4	IX_CMS_PageTemplate_PageTemplateSiteID_PageTemplateCodeName_PageTemplateGUID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_PageTemplate_PageTemplateSiteID_PageTemplateCodeName_PageTemplateGUID') 
 BEGIN 
	Create NonClustered Index [IX_CMS_PageTemplate_PageTemplateSiteID_PageTemplateCodeName_PageTemplateGUID] On [dbo].[CMS_PageTemplate] ([PageTemplateSiteID] Asc,[PageTemplateCodeName] Asc,[PageTemplateGUID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_PageTemplate_PageTemplateSiteID_PageTemplateCodeName_PageTemplateGUID') 
 BEGIN 
	DROP INDEX [IX_CMS_PageTemplate_PageTemplateSiteID_PageTemplateCodeName_PageTemplateGUID] On [dbo].[CMS_PageTemplate];
END
-- 245575913	Forums_ForumSubscription	1	IX_Forums_ForumSubscription_SubscriptionForumID_SubscriptionEmail	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Forums_ForumSubscription_SubscriptionForumID_SubscriptionEmail') 
 BEGIN 
	Create Clustered Index [IX_Forums_ForumSubscription_SubscriptionForumID_SubscriptionEmail] On [dbo].[Forums_ForumSubscription] ([SubscriptionEmail] Asc,[SubscriptionForumID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Forums_ForumSubscription_SubscriptionForumID_SubscriptionEmail') 
 BEGIN 
	DROP INDEX [IX_Forums_ForumSubscription_SubscriptionForumID_SubscriptionEmail] On [dbo].[Forums_ForumSubscription];
END
-- 249767947	CMS_TemplateDeviceLayout	2	IX_CMS_TemplateDeviceLayout_PageTemplateID_ProfileID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_TemplateDeviceLayout_PageTemplateID_ProfileID') 
 BEGIN 
	Create Unique NonClustered Index [IX_CMS_TemplateDeviceLayout_PageTemplateID_ProfileID] On [dbo].[CMS_TemplateDeviceLayout] ([PageTemplateID] Asc,[ProfileID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_TemplateDeviceLayout_PageTemplateID_ProfileID') 
 BEGIN 
	DROP INDEX [IX_CMS_TemplateDeviceLayout_PageTemplateID_ProfileID] On [dbo].[CMS_TemplateDeviceLayout];
END
-- 256719967	CMS_UIElement	10	CMS_UIElement_idx_01	
IF NOT Exists (Select name from sys.indexes where name = 'CMS_UIElement_idx_01') 
 BEGIN 
	Create NonClustered Index [CMS_UIElement_idx_01] On [dbo].[CMS_UIElement] ([ElementParentID] Asc,[ElementLevel] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'CMS_UIElement_idx_01') 
 BEGIN 
	DROP INDEX [CMS_UIElement_idx_01] On [dbo].[CMS_UIElement];
END
-- 933578364	CMS_UserRole	3	IX_CMS_UserRole_UserID_RoleID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_UserRole_UserID_RoleID') 
 BEGIN 
	Create Unique NonClustered Index [IX_CMS_UserRole_UserID_RoleID] On [dbo].[CMS_UserRole] ([UserID] Asc,[RoleID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_UserRole_UserID_RoleID') 
 BEGIN 
	DROP INDEX [IX_CMS_UserRole_UserID_RoleID] On [dbo].[CMS_UserRole];
END
-- 951635129	HFit_EventLogMaintenance	1	IX_CMS_EventLog_EventTime	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_EventLog_EventTime') 
 BEGIN 
	Create Clustered Index [IX_CMS_EventLog_EventTime] On [dbo].[HFit_EventLogMaintenance] ([EventTime] Desc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [pfDaily_Maintenance](EventTime);	
 END 
	pfDaily_Maintenance	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_EventLog_EventTime') 
 BEGIN 
	DROP INDEX [IX_CMS_EventLog_EventTime] On [dbo].[HFit_EventLogMaintenance];
END
-- 983674552	CMS_Avatar	1	IX_CMS_Avatar_AvatarName	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_Avatar_AvatarName') 
 BEGIN 
	Create Clustered Index [IX_CMS_Avatar_AvatarName] On [dbo].[CMS_Avatar] ([AvatarName] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_Avatar_AvatarName') 
 BEGIN 
	DROP INDEX [IX_CMS_Avatar_AvatarName] On [dbo].[CMS_Avatar];
END
-- 1029578706	CMS_Role	10	nonRoleNameID	
IF NOT Exists (Select name from sys.indexes where name = 'nonRoleNameID') 
 BEGIN 
	Create NonClustered Index [nonRoleNameID] On [dbo].[CMS_Role] ([RoleName] Asc,[RoleID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'nonRoleNameID') 
 BEGIN 
	DROP INDEX [nonRoleNameID] On [dbo].[CMS_Role];
END
-- 1061578820	Board_Subscription	2	IX_Board_Subscription_SubscriptionBoardID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Board_Subscription_SubscriptionBoardID') 
 BEGIN 
	Create NonClustered Index [IX_Board_Subscription_SubscriptionBoardID] On [dbo].[Board_Subscription] ([SubscriptionBoardID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Board_Subscription_SubscriptionBoardID') 
 BEGIN 
	DROP INDEX [IX_Board_Subscription_SubscriptionBoardID] On [dbo].[Board_Subscription];
END
-- 1294627655	OM_IP	2	IX_OM_IP_IPActiveContactID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_OM_IP_IPActiveContactID') 
 BEGIN 
	Create NonClustered Index [IX_OM_IP_IPActiveContactID] On [dbo].[OM_IP] ([IPActiveContactID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_OM_IP_IPActiveContactID') 
 BEGIN 
	DROP INDEX [IX_OM_IP_IPActiveContactID] On [dbo].[OM_IP];
END
-- 1750297295	COM_ShoppingCart	3	IX_COM_ShoppingCart_ShoppingCartUserID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_COM_ShoppingCart_ShoppingCartUserID') 
 BEGIN 
	Create NonClustered Index [IX_COM_ShoppingCart_ShoppingCartUserID] On [dbo].[COM_ShoppingCart] ([ShoppingCartUserID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_COM_ShoppingCart_ShoppingCartUserID') 
 BEGIN 
	DROP INDEX [IX_COM_ShoppingCart_ShoppingCartUserID] On [dbo].[COM_ShoppingCart];
END
-- 1750297295	COM_ShoppingCart	11	IX_COM_ShoppingCart_ShoppingCartCustomerID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_COM_ShoppingCart_ShoppingCartCustomerID') 
 BEGIN 
	Create NonClustered Index [IX_COM_ShoppingCart_ShoppingCartCustomerID] On [dbo].[COM_ShoppingCart] ([ShoppingCartCustomerID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_COM_ShoppingCart_ShoppingCartCustomerID') 
 BEGIN 
	DROP INDEX [IX_COM_ShoppingCart_ShoppingCartCustomerID] On [dbo].[COM_ShoppingCart];
END
-- 13203793	HFit_CentralConfig	3	IX_HFit_CentralConfigKey	
IF NOT Exists (Select name from sys.indexes where name = 'IX_HFit_CentralConfigKey') 
 BEGIN 
	Create NonClustered Index [IX_HFit_CentralConfigKey] On [dbo].[HFit_CentralConfig] ([ConfigKey] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_HFit_CentralConfigKey') 
 BEGIN 
	DROP INDEX [IX_HFit_CentralConfigKey] On [dbo].[HFit_CentralConfig];
END
-- 13243102	CMS_AutomationHistory	2	IX_CMS_AutomationHistory_HistoryStepID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_AutomationHistory_HistoryStepID') 
 BEGIN 
	Create NonClustered Index [IX_CMS_AutomationHistory_HistoryStepID] On [dbo].[CMS_AutomationHistory] ([HistoryStepID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_AutomationHistory_HistoryStepID') 
 BEGIN 
	DROP INDEX [IX_CMS_AutomationHistory_HistoryStepID] On [dbo].[CMS_AutomationHistory];
END
-- 773577794	PM_ProjectTask	2	IX_PM_ProjectTask_ProjectTaskProjectID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_PM_ProjectTask_ProjectTaskProjectID') 
 BEGIN 
	Create NonClustered Index [IX_PM_ProjectTask_ProjectTaskProjectID] On [dbo].[PM_ProjectTask] ([ProjectTaskProjectID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 100, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_PM_ProjectTask_ProjectTaskProjectID') 
 BEGIN 
	DROP INDEX [IX_PM_ProjectTask_ProjectTaskProjectID] On [dbo].[PM_ProjectTask];
END
-- 773577794	PM_ProjectTask	5	IX_PM_ProjectTask_ProjectTaskOwnerID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_PM_ProjectTask_ProjectTaskOwnerID') 
 BEGIN 
	Create NonClustered Index [IX_PM_ProjectTask_ProjectTaskOwnerID] On [dbo].[PM_ProjectTask] ([ProjectTaskOwnerID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 100, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_PM_ProjectTask_ProjectTaskOwnerID') 
 BEGIN 
	DROP INDEX [IX_PM_ProjectTask_ProjectTaskOwnerID] On [dbo].[PM_ProjectTask];
END
-- 1570104634	Reporting_ReportTable	2	IX_Reporting_ReportTable_TableReportID_TableName	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Reporting_ReportTable_TableReportID_TableName') 
 BEGIN 
	Create Unique NonClustered Index [IX_Reporting_ReportTable_TableReportID_TableName] On [dbo].[Reporting_ReportTable] ([TableName] Asc,[TableReportID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Reporting_ReportTable_TableReportID_TableName') 
 BEGIN 
	DROP INDEX [IX_Reporting_ReportTable_TableReportID_TableName] On [dbo].[Reporting_ReportTable];
END
-- 1573580644	COM_ShoppingCartSKU	2	IX_COM_ShoppingCartSKU_ShoppingCartID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_COM_ShoppingCartSKU_ShoppingCartID') 
 BEGIN 
	Create NonClustered Index [IX_COM_ShoppingCartSKU_ShoppingCartID] On [dbo].[COM_ShoppingCartSKU] ([ShoppingCartID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_COM_ShoppingCartSKU_ShoppingCartID') 
 BEGIN 
	DROP INDEX [IX_COM_ShoppingCartSKU_ShoppingCartID] On [dbo].[COM_ShoppingCartSKU];
END
-- 1578488702	HFit_TrackerBodyMeasurements	11	idx_HFit_TrackerBodyMeasurements_CreateDate	
IF NOT Exists (Select name from sys.indexes where name = 'idx_HFit_TrackerBodyMeasurements_CreateDate') 
 BEGIN 
	Create NonClustered Index [idx_HFit_TrackerBodyMeasurements_CreateDate] On [dbo].[HFit_TrackerBodyMeasurements] ([ItemCreatedWhen] Asc,[ItemModifiedWhen] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'idx_HFit_TrackerBodyMeasurements_CreateDate') 
 BEGIN 
	DROP INDEX [idx_HFit_TrackerBodyMeasurements_CreateDate] On [dbo].[HFit_TrackerBodyMeasurements];
END
-- 198343821	HFit_TrackerCardio	7	idx_HFit_TrackerCardio_CreateDate	
IF NOT Exists (Select name from sys.indexes where name = 'idx_HFit_TrackerCardio_CreateDate') 
 BEGIN 
	Create NonClustered Index [idx_HFit_TrackerCardio_CreateDate] On [dbo].[HFit_TrackerCardio] ([ItemCreatedWhen] Asc,[ItemModifiedWhen] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'idx_HFit_TrackerCardio_CreateDate') 
 BEGIN 
	DROP INDEX [idx_HFit_TrackerCardio_CreateDate] On [dbo].[HFit_TrackerCardio];
END
-- 203147769	Chat_OnlineSupport	2	IX_Chat_OnlineSupport_SiteID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Chat_OnlineSupport_SiteID') 
 BEGIN 
	Create NonClustered Index [IX_Chat_OnlineSupport_SiteID] On [dbo].[Chat_OnlineSupport] ([ChatOnlineSupportSiteID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Chat_OnlineSupport_SiteID') 
 BEGIN 
	DROP INDEX [IX_Chat_OnlineSupport_SiteID] On [dbo].[Chat_OnlineSupport];
END
-- 204332288	HFit_PostSubscriber	8	IX_Hfit_PostSubscriber_ContactGroupID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Hfit_PostSubscriber_ContactGroupID') 
 BEGIN 
	Create NonClustered Index [IX_Hfit_PostSubscriber_ContactGroupID] On [dbo].[HFit_PostSubscriber] ([ContactGroupID] Asc) Include ([ContactID],[DocumentID],[Pinned],[PublishDate])  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Hfit_PostSubscriber_ContactGroupID') 
 BEGIN 
	DROP INDEX [IX_Hfit_PostSubscriber_ContactGroupID] On [dbo].[HFit_PostSubscriber];
END
-- 204332288	HFit_PostSubscriber	11	IX_Hfit_PostSubscriber_NodeID_PublishDate	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Hfit_PostSubscriber_NodeID_PublishDate') 
 BEGIN 
	Create NonClustered Index [IX_Hfit_PostSubscriber_NodeID_PublishDate] On [dbo].[HFit_PostSubscriber] ([NodeID] Asc,[PublishDate] Asc) Include ([ContactGroupID],[ContactID],[Pinned])  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Hfit_PostSubscriber_NodeID_PublishDate') 
 BEGIN 
	DROP INDEX [IX_Hfit_PostSubscriber_NodeID_PublishDate] On [dbo].[HFit_PostSubscriber];
END
-- 204332288	HFit_PostSubscriber	14	IX_Hfit_PostSubscriber_1	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Hfit_PostSubscriber_1') 
 BEGIN 
	Create NonClustered Index [IX_Hfit_PostSubscriber_1] On [dbo].[HFit_PostSubscriber] ([DocumentID] Asc) Include ([ContactID],[Pinned],[PublishDate])  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Hfit_PostSubscriber_1') 
 BEGIN 
	DROP INDEX [IX_Hfit_PostSubscriber_1] On [dbo].[HFit_PostSubscriber];
END
-- 208719796	CMS_WebPart	5	IX_CMS_WebPart_WebPartParentID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_WebPart_WebPartParentID') 
 BEGIN 
	Create NonClustered Index [IX_CMS_WebPart_WebPartParentID] On [dbo].[CMS_WebPart] ([WebPartParentID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_WebPart_WebPartParentID') 
 BEGIN 
	DROP INDEX [IX_CMS_WebPart_WebPartParentID] On [dbo].[CMS_WebPart];
END
-- 437576597	Analytics_HourHits	1	IX_Analytics_HourHits_HitsStartTime_HitsEndTime	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Analytics_HourHits_HitsStartTime_HitsEndTime') 
 BEGIN 
	Create Clustered Index [IX_Analytics_HourHits_HitsStartTime_HitsEndTime] On [dbo].[Analytics_HourHits] ([HitsStartTime] Desc,[HitsEndTime] Desc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Analytics_HourHits_HitsStartTime_HitsEndTime') 
 BEGIN 
	DROP INDEX [IX_Analytics_HourHits_HitsStartTime_HitsEndTime] On [dbo].[Analytics_HourHits];
END
-- 468196718	Newsletter_Emails	4	IX_Newsletter_Emails_EmailSiteID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Newsletter_Emails_EmailSiteID') 
 BEGIN 
	Create NonClustered Index [IX_Newsletter_Emails_EmailSiteID] On [dbo].[Newsletter_Emails] ([EmailSiteID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Newsletter_Emails_EmailSiteID') 
 BEGIN 
	DROP INDEX [IX_Newsletter_Emails_EmailSiteID] On [dbo].[Newsletter_Emails];
END
-- 469576711	Analytics_DayHits	1	IX_Analytics_DayHits_HitsStartTime_HitsEndTime	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Analytics_DayHits_HitsStartTime_HitsEndTime') 
 BEGIN 
	Create Clustered Index [IX_Analytics_DayHits_HitsStartTime_HitsEndTime] On [dbo].[Analytics_DayHits] ([HitsStartTime] Desc,[HitsEndTime] Desc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Analytics_DayHits_HitsStartTime_HitsEndTime') 
 BEGIN 
	DROP INDEX [IX_Analytics_DayHits_HitsStartTime_HitsEndTime] On [dbo].[Analytics_DayHits];
END
-- 602485225	HFit_TrackerVegetables	5	idx_HFit_TrackerVegetables_CreateDate	
IF NOT Exists (Select name from sys.indexes where name = 'idx_HFit_TrackerVegetables_CreateDate') 
 BEGIN 
	Create NonClustered Index [idx_HFit_TrackerVegetables_CreateDate] On [dbo].[HFit_TrackerVegetables] ([ItemCreatedWhen] Asc,[ItemModifiedWhen] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 100, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'idx_HFit_TrackerVegetables_CreateDate') 
 BEGIN 
	DROP INDEX [idx_HFit_TrackerVegetables_CreateDate] On [dbo].[HFit_TrackerVegetables];
END
-- 611025458	HFit_Account	14	HFit_Account_SiteID_PI	
IF NOT Exists (Select name from sys.indexes where name = 'HFit_Account_SiteID_PI') 
 BEGIN 
	Create NonClustered Index [HFit_Account_SiteID_PI] On [dbo].[HFit_Account] ([SiteID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'HFit_Account_SiteID_PI') 
 BEGIN 
	DROP INDEX [HFit_Account_SiteID_PI] On [dbo].[HFit_Account];
END
-- 180195692	CMS_SettingsKey	16	nonKeyNameLocSiteID	
IF NOT Exists (Select name from sys.indexes where name = 'nonKeyNameLocSiteID') 
 BEGIN 
	Create NonClustered Index [nonKeyNameLocSiteID] On [dbo].[CMS_SettingsKey] ([KeyName] Asc,[KeyLoadGeneration] Asc,[SiteID] Asc) Include ([KeyValue])  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'nonKeyNameLocSiteID') 
 BEGIN 
	DROP INDEX [nonKeyNameLocSiteID] On [dbo].[CMS_SettingsKey];
END
-- 1886629764	OM_AccountStatus	2	IX_OM_AccountStatus_AccountStatusSiteID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_OM_AccountStatus_AccountStatusSiteID') 
 BEGIN 
	Create NonClustered Index [IX_OM_AccountStatus_AccountStatusSiteID] On [dbo].[OM_AccountStatus] ([AccountStatusSiteID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_OM_AccountStatus_AccountStatusSiteID') 
 BEGIN 
	DROP INDEX [IX_OM_AccountStatus_AccountStatusSiteID] On [dbo].[OM_AccountStatus];
END
-- 1890821798	HFit_HealthAssesmentUserRiskCategory	3	IX_HFit_HealthAssesmentUserRiskCategory_1	
IF NOT Exists (Select name from sys.indexes where name = 'IX_HFit_HealthAssesmentUserRiskCategory_1') 
 BEGIN 
	Create NonClustered Index [IX_HFit_HealthAssesmentUserRiskCategory_1] On [dbo].[HFit_HealthAssesmentUserRiskCategory] ([UserID] Asc) Include ([HARiskCategoryNodeGUID])  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_HFit_HealthAssesmentUserRiskCategory_1') 
 BEGIN 
	DROP INDEX [IX_HFit_HealthAssesmentUserRiskCategory_1] On [dbo].[HFit_HealthAssesmentUserRiskCategory];
END
-- 2073774445	Newsletter_Newsletter	3	IX_Newsletter_Newsletter_NewsletterSiteID_NewsletterName	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Newsletter_Newsletter_NewsletterSiteID_NewsletterName') 
 BEGIN 
	Create Unique NonClustered Index [IX_Newsletter_Newsletter_NewsletterSiteID_NewsletterName] On [dbo].[Newsletter_Newsletter] ([NewsletterSiteID] Asc,[NewsletterName] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Newsletter_Newsletter_NewsletterSiteID_NewsletterName') 
 BEGIN 
	DROP INDEX [IX_Newsletter_Newsletter_NewsletterSiteID_NewsletterName] On [dbo].[Newsletter_Newsletter];
END
-- 2073774445	Newsletter_Newsletter	6	IX_Newsletter_Newsletter_NewsletterTemplateID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Newsletter_Newsletter_NewsletterTemplateID') 
 BEGIN 
	Create NonClustered Index [IX_Newsletter_Newsletter_NewsletterTemplateID] On [dbo].[Newsletter_Newsletter] ([NewsletterTemplateID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Newsletter_Newsletter_NewsletterTemplateID') 
 BEGIN 
	DROP INDEX [IX_Newsletter_Newsletter_NewsletterTemplateID] On [dbo].[Newsletter_Newsletter];
END
-- 75147313	COM_DiscountCoupon	3	IX_COM_DiscountCoupon_DiscountCouponCode	
IF NOT Exists (Select name from sys.indexes where name = 'IX_COM_DiscountCoupon_DiscountCouponCode') 
 BEGIN 
	Create NonClustered Index [IX_COM_DiscountCoupon_DiscountCouponCode] On [dbo].[COM_DiscountCoupon] ([DiscountCouponCode] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_COM_DiscountCoupon_DiscountCouponCode') 
 BEGIN 
	DROP INDEX [IX_COM_DiscountCoupon_DiscountCouponCode] On [dbo].[COM_DiscountCoupon];
END
-- 1783677402	COM_Customer	5	IX_COM_Customer_CustomerUserID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_COM_Customer_CustomerUserID') 
 BEGIN 
	Create NonClustered Index [IX_COM_Customer_CustomerUserID] On [dbo].[COM_Customer] ([CustomerUserID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_COM_Customer_CustomerUserID') 
 BEGIN 
	DROP INDEX [IX_COM_Customer_CustomerUserID] On [dbo].[COM_Customer];
END
-- 1798297466	CMS_Personalization	3	IX_CMS_Personalization_PersonalizationID_PersonalizationUserID_PersonalizationDocumentID_PersonalizationDashboardName	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_Personalization_PersonalizationID_PersonalizationUserID_PersonalizationDocumentID_PersonalizationDashboardName') 
 BEGIN 
	Create Unique NonClustered Index [IX_CMS_Personalization_PersonalizationID_PersonalizationUserID_PersonalizationDocumentID_PersonalizationDashboardName] On [dbo].[CMS_Personalization] ([PersonalizationID] Asc,[PersonalizationUserID] Asc,[PersonalizationDocumentID] Asc,[PersonalizationDashboardName] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_Personalization_PersonalizationID_PersonalizationUserID_PersonalizationDocumentID_PersonalizationDashboardName') 
 BEGIN 
	DROP INDEX [IX_CMS_Personalization_PersonalizationID_PersonalizationUserID_PersonalizationDocumentID_PersonalizationDashboardName] On [dbo].[CMS_Personalization];
END
-- 387532464	temp_CMS_PageTemplate	1	idxpagetemplatetemp	
IF NOT Exists (Select name from sys.indexes where name = 'idxpagetemplatetemp') 
 BEGIN 
	Create Unique Clustered Index [idxpagetemplatetemp] On [dbo].[temp_CMS_PageTemplate] ([PageTemplateID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'idxpagetemplatetemp') 
 BEGIN 
	DROP INDEX [idxpagetemplatetemp] On [dbo].[temp_CMS_PageTemplate];
END
-- 400720480	CMS_FormUserControl	3	IX_CMS_FormUserControl_UserControlResourceID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_FormUserControl_UserControlResourceID') 
 BEGIN 
	Create NonClustered Index [IX_CMS_FormUserControl_UserControlResourceID] On [dbo].[CMS_FormUserControl] ([UserControlResourceID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_FormUserControl_UserControlResourceID') 
 BEGIN 
	DROP INDEX [IX_CMS_FormUserControl_UserControlResourceID] On [dbo].[CMS_FormUserControl];
END
-- 1317579732	COM_Department	1	IX_COM_Department_DepartmentDisplayName	
IF NOT Exists (Select name from sys.indexes where name = 'IX_COM_Department_DepartmentDisplayName') 
 BEGIN 
	Create Clustered Index [IX_COM_Department_DepartmentDisplayName] On [dbo].[COM_Department] ([DepartmentDisplayName] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_COM_Department_DepartmentDisplayName') 
 BEGIN 
	DROP INDEX [IX_COM_Department_DepartmentDisplayName] On [dbo].[COM_Department];
END
-- 1445580188	COM_VolumeDiscount	2	IX_COM_VolumeDiscount_VolumeDiscountSKUID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_COM_VolumeDiscount_VolumeDiscountSKUID') 
 BEGIN 
	Create NonClustered Index [IX_COM_VolumeDiscount_VolumeDiscountSKUID] On [dbo].[COM_VolumeDiscount] ([VolumeDiscountSKUID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_COM_VolumeDiscount_VolumeDiscountSKUID') 
 BEGIN 
	DROP INDEX [IX_COM_VolumeDiscount_VolumeDiscountSKUID] On [dbo].[COM_VolumeDiscount];
END
-- 1465772279	CMS_DocumentAlias	5	IX_CMS_DocumentAlias_AliasWildcardRule_AliasPriority	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_DocumentAlias_AliasWildcardRule_AliasPriority') 
 BEGIN 
	Create NonClustered Index [IX_CMS_DocumentAlias_AliasWildcardRule_AliasPriority] On [dbo].[CMS_DocumentAlias] ([AliasWildcardRule] Asc,[AliasPriority] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_DocumentAlias_AliasWildcardRule_AliasPriority') 
 BEGIN 
	DROP INDEX [IX_CMS_DocumentAlias_AliasWildcardRule_AliasPriority] On [dbo].[CMS_DocumentAlias];
END
-- 743673697	Community_GroupMember	1	IX_Community_GroupMember_MemberJoined	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Community_GroupMember_MemberJoined') 
 BEGIN 
	Create Clustered Index [IX_Community_GroupMember_MemberJoined] On [dbo].[Community_GroupMember] ([MemberJoined] Desc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Community_GroupMember_MemberJoined') 
 BEGIN 
	DROP INDEX [IX_Community_GroupMember_MemberJoined] On [dbo].[Community_GroupMember];
END
-- 70291310	View_CMS_Tree_Joined_Regular	6	IX_View_CMS_Tree_Joined_Regular_ClassName_NodeSiteID_DocumentForeignKeyValue_DocumentCulture	
IF NOT Exists (Select name from sys.indexes where name = 'IX_View_CMS_Tree_Joined_Regular_ClassName_NodeSiteID_DocumentForeignKeyValue_DocumentCulture') 
 BEGIN 
	Create NonClustered Index [IX_View_CMS_Tree_Joined_Regular_ClassName_NodeSiteID_DocumentForeignKeyValue_DocumentCulture] On [dbo].[View_CMS_Tree_Joined_Regular] ([ClassName] Asc,[NodeSiteID] Asc,[DocumentForeignKeyValue] Asc,[DocumentCulture] Asc) Include ([NodeParentID])  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 100, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_View_CMS_Tree_Joined_Regular_ClassName_NodeSiteID_DocumentForeignKeyValue_DocumentCulture') 
 BEGIN 
	DROP INDEX [IX_View_CMS_Tree_Joined_Regular_ClassName_NodeSiteID_DocumentForeignKeyValue_DocumentCulture] On [dbo].[View_CMS_Tree_Joined_Regular];
END
-- 70291310	View_CMS_Tree_Joined_Regular	9	PI_View_CMS_Tree_Joined_Regular_NodeSiteID_DocumentCulture_NodeID	
IF NOT Exists (Select name from sys.indexes where name = 'PI_View_CMS_Tree_Joined_Regular_NodeSiteID_DocumentCulture_NodeID') 
 BEGIN 
	Create NonClustered Index [PI_View_CMS_Tree_Joined_Regular_NodeSiteID_DocumentCulture_NodeID] On [dbo].[View_CMS_Tree_Joined_Regular] ([NodeSiteID] Asc,[NodeID] Asc,[NodeGUID] Asc,[NodeParentID] Asc,[DocumentCulture] Asc,[DocumentID] Asc,[DocumentPublishedVersionHistoryID] Asc,[DocumentGUID] Asc,[DocumentModifiedWhen] Asc,[DocumentCreatedWhen] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 100, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'PI_View_CMS_Tree_Joined_Regular_NodeSiteID_DocumentCulture_NodeID') 
 BEGIN 
	DROP INDEX [PI_View_CMS_Tree_Joined_Regular_NodeSiteID_DocumentCulture_NodeID] On [dbo].[View_CMS_Tree_Joined_Regular];
END
-- 555865047	Chat_Room	4	IX_Chat_Room_IsSupport	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Chat_Room_IsSupport') 
 BEGIN 
	Create NonClustered Index [IX_Chat_Room_IsSupport] On [dbo].[Chat_Room] ([ChatRoomIsSupport] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Chat_Room_IsSupport') 
 BEGIN 
	DROP INDEX [IX_Chat_Room_IsSupport] On [dbo].[Chat_Room];
END
-- 561437074	HFit_TrackerFruits	5	idx_HFit_TrackerFruits_CreateDate	
IF NOT Exists (Select name from sys.indexes where name = 'idx_HFit_TrackerFruits_CreateDate') 
 BEGIN 
	Create NonClustered Index [idx_HFit_TrackerFruits_CreateDate] On [dbo].[HFit_TrackerFruits] ([ItemCreatedWhen] Asc,[ItemModifiedWhen] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'idx_HFit_TrackerFruits_CreateDate') 
 BEGIN 
	DROP INDEX [idx_HFit_TrackerFruits_CreateDate] On [dbo].[HFit_TrackerFruits];
END
-- 564197060	CMS_UserSettings	2	IX_CMS_UserSettings_UserNickName	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_UserSettings_UserNickName') 
 BEGIN 
	Create NonClustered Index [IX_CMS_UserSettings_UserNickName] On [dbo].[CMS_UserSettings] ([UserNickName] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_UserSettings_UserNickName') 
 BEGIN 
	DROP INDEX [IX_CMS_UserSettings_UserNickName] On [dbo].[CMS_UserSettings];
END
-- 564197060	CMS_UserSettings	5	IX_CMS_UserSettings_UserAvatarID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_UserSettings_UserAvatarID') 
 BEGIN 
	Create NonClustered Index [IX_CMS_UserSettings_UserAvatarID] On [dbo].[CMS_UserSettings] ([UserAvatarID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_UserSettings_UserAvatarID') 
 BEGIN 
	DROP INDEX [IX_CMS_UserSettings_UserAvatarID] On [dbo].[CMS_UserSettings];
END
-- 564197060	CMS_UserSettings	8	IX_CMS_UserSettings_UserSettingsUserGUID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_UserSettings_UserSettingsUserGUID') 
 BEGIN 
	Create NonClustered Index [IX_CMS_UserSettings_UserSettingsUserGUID] On [dbo].[CMS_UserSettings] ([UserSettingsUserGUID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_UserSettings_UserSettingsUserGUID') 
 BEGIN 
	DROP INDEX [IX_CMS_UserSettings_UserSettingsUserGUID] On [dbo].[CMS_UserSettings];
END
-- 1849773647	OM_Membership	3	IX_OM_Membership_OriginalContactID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_OM_Membership_OriginalContactID') 
 BEGIN 
	Create NonClustered Index [IX_OM_Membership_OriginalContactID] On [dbo].[OM_Membership] ([OriginalContactID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_OM_Membership_OriginalContactID') 
 BEGIN 
	DROP INDEX [IX_OM_Membership_OriginalContactID] On [dbo].[OM_Membership];
END
-- 1853965681	HFit_TrackerBloodSugarAndGlucose	16	IX_TrackerBloodSugar_UserID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_TrackerBloodSugar_UserID') 
 BEGIN 
	Create NonClustered Index [IX_TrackerBloodSugar_UserID] On [dbo].[HFit_TrackerBloodSugarAndGlucose] ([UserID] Asc,[EventDate] Desc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_TrackerBloodSugar_UserID') 
 BEGIN 
	DROP INDEX [IX_TrackerBloodSugar_UserID] On [dbo].[HFit_TrackerBloodSugarAndGlucose];
END
-- 150291595	View_CMS_Tree_Joined_Linked	2	PI_Linked_ClassLang	
IF NOT Exists (Select name from sys.indexes where name = 'PI_Linked_ClassLang') 
 BEGIN 
	Create NonClustered Index [PI_Linked_ClassLang] On [dbo].[View_CMS_Tree_Joined_Linked] ([ClassName] Asc,[DocumentCulture] Asc) Include ([DocumentForeignKeyValue],[NodeGUID])  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 100, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'PI_Linked_ClassLang') 
 BEGIN 
	DROP INDEX [PI_Linked_ClassLang] On [dbo].[View_CMS_Tree_Joined_Linked];
END
-- 150291595	View_CMS_Tree_Joined_Linked	5	IDX_View_CMS_Tree_Joined_Linked_NodeID_DocGuid	
IF NOT Exists (Select name from sys.indexes where name = 'IDX_View_CMS_Tree_Joined_Linked_NodeID_DocGuid') 
 BEGIN 
	Create NonClustered Index [IDX_View_CMS_Tree_Joined_Linked_NodeID_DocGuid] On [dbo].[View_CMS_Tree_Joined_Linked] ([ClassName] Asc) Include ([DocumentForeignKeyValue],[DocumentGUID],[DocumentPublishedVersionHistoryID],[NodeID],[NodeParentID])  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 100, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IDX_View_CMS_Tree_Joined_Linked_NodeID_DocGuid') 
 BEGIN 
	DROP INDEX [IDX_View_CMS_Tree_Joined_Linked_NodeID_DocGuid] On [dbo].[View_CMS_Tree_Joined_Linked];
END
-- 150291595	View_CMS_Tree_Joined_Linked	8	PI_View_CMS_Tree_Joined_Linked_NodeSiteID_DocumentCulture_NodeID	
IF NOT Exists (Select name from sys.indexes where name = 'PI_View_CMS_Tree_Joined_Linked_NodeSiteID_DocumentCulture_NodeID') 
 BEGIN 
	Create NonClustered Index [PI_View_CMS_Tree_Joined_Linked_NodeSiteID_DocumentCulture_NodeID] On [dbo].[View_CMS_Tree_Joined_Linked] ([NodeSiteID] Asc,[DocumentCulture] Asc,[NodeID] Asc,[NodeGUID] Asc,[DocumentModifiedWhen] Asc,[DocumentCreatedWhen] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 100, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'PI_View_CMS_Tree_Joined_Linked_NodeSiteID_DocumentCulture_NodeID') 
 BEGIN 
	DROP INDEX [PI_View_CMS_Tree_Joined_Linked_NodeSiteID_DocumentCulture_NodeID] On [dbo].[View_CMS_Tree_Joined_Linked];
END
-- 1735677231	CMS_ScheduledTask	30	IX_ScheduledTaskEnabled	
IF NOT Exists (Select name from sys.indexes where name = 'IX_ScheduledTaskEnabled') 
 BEGIN 
	Create NonClustered Index [IX_ScheduledTaskEnabled] On [dbo].[CMS_ScheduledTask] ([TaskEnabled] Asc,[TaskNextRunTime] Asc,[TaskSiteID] Asc,[TaskServerName] Asc,[TaskUseExternalService] Asc) Include ([TaskID])  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_ScheduledTaskEnabled') 
 BEGIN 
	DROP INDEX [IX_ScheduledTaskEnabled] On [dbo].[CMS_ScheduledTask];
END
-- 1739061877	HFit_TrackerDailySteps	11	IX_TrackerDailySteps_SourceID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_TrackerDailySteps_SourceID') 
 BEGIN 
	Create NonClustered Index [IX_TrackerDailySteps_SourceID] On [dbo].[HFit_TrackerDailySteps] ([TrackerCollectionSourceID] Asc,[IsProfessionallyCollected] Asc,[UserID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_TrackerDailySteps_SourceID') 
 BEGIN 
	DROP INDEX [IX_TrackerDailySteps_SourceID] On [dbo].[HFit_TrackerDailySteps];
END
-- 1927677915	COM_SKU	11	IX_COM_SKU_SKUOptionCategoryID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_COM_SKU_SKUOptionCategoryID') 
 BEGIN 
	Create NonClustered Index [IX_COM_SKU_SKUOptionCategoryID] On [dbo].[COM_SKU] ([SKUOptionCategoryID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_COM_SKU_SKUOptionCategoryID') 
 BEGIN 
	DROP INDEX [IX_COM_SKU_SKUOptionCategoryID] On [dbo].[COM_SKU];
END
-- 1326627769	OM_Search	2	IX_OM_Search_SearchActivityID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_OM_Search_SearchActivityID') 
 BEGIN 
	Create NonClustered Index [IX_OM_Search_SearchActivityID] On [dbo].[OM_Search] ([SearchActivityID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_OM_Search_SearchActivityID') 
 BEGIN 
	DROP INDEX [IX_OM_Search_SearchActivityID] On [dbo].[OM_Search];
END
-- 1330819803	OM_UserAgent	3	IX_OM_UserAgent_UserAgentOriginalContactID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_OM_UserAgent_UserAgentOriginalContactID') 
 BEGIN 
	Create NonClustered Index [IX_OM_UserAgent_UserAgentOriginalContactID] On [dbo].[OM_UserAgent] ([UserAgentOriginalContactID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_OM_UserAgent_UserAgentOriginalContactID') 
 BEGIN 
	DROP INDEX [IX_OM_UserAgent_UserAgentOriginalContactID] On [dbo].[OM_UserAgent];
END
-- 1351675863	Board_Board	3	IX_Board_Board_BoardGroupID_BoardName	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Board_Board_BoardGroupID_BoardName') 
 BEGIN 
	Create NonClustered Index [IX_Board_Board_BoardGroupID_BoardName] On [dbo].[Board_Board] ([BoardGroupID] Asc,[BoardName] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Board_Board_BoardGroupID_BoardName') 
 BEGIN 
	DROP INDEX [IX_Board_Board_BoardGroupID_BoardName] On [dbo].[Board_Board];
END
-- 1026102696	CMS_WorkflowStep	1	IX_CMS_WorkflowStep_StepID_StepName	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_WorkflowStep_StepID_StepName') 
 BEGIN 
	Create Clustered Index [IX_CMS_WorkflowStep_StepID_StepName] On [dbo].[CMS_WorkflowStep] ([StepID] Asc,[StepName] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_WorkflowStep_StepID_StepName') 
 BEGIN 
	DROP INDEX [IX_CMS_WorkflowStep_StepID_StepName] On [dbo].[CMS_WorkflowStep];
END
-- 1026102696	CMS_WorkflowStep	4	IX_CMS_WorkflowStep_StepWorkflowID_StepOrder	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_WorkflowStep_StepWorkflowID_StepOrder') 
 BEGIN 
	Create NonClustered Index [IX_CMS_WorkflowStep_StepWorkflowID_StepOrder] On [dbo].[CMS_WorkflowStep] ([StepWorkflowID] Asc,[StepOrder] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_WorkflowStep_StepWorkflowID_StepOrder') 
 BEGIN 
	DROP INDEX [IX_CMS_WorkflowStep_StepWorkflowID_StepOrder] On [dbo].[CMS_WorkflowStep];
END
-- 1425348788	HFit_HealthAssessmentImportStagingMaster	6	IX_HFit_HealthAssessmentImportStagingMaster_2	
IF NOT Exists (Select name from sys.indexes where name = 'IX_HFit_HealthAssessmentImportStagingMaster_2') 
 BEGIN 
	Create NonClustered Index [IX_HFit_HealthAssessmentImportStagingMaster_2] On [dbo].[HFit_HealthAssessmentImportStagingMaster] ([IsProcessed] Asc) Include ([MasterID],[UserID],[SiteID])  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_HFit_HealthAssessmentImportStagingMaster_2') 
 BEGIN 
	DROP INDEX [IX_HFit_HealthAssessmentImportStagingMaster_2] On [dbo].[HFit_HealthAssessmentImportStagingMaster];
END
-- 1604200765	CMS_ObjectVersionHistory	3	IX_CMS_ObjectVersionHistory_VersionObjectType_VersionObjectID_VersionModifiedWhen	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_ObjectVersionHistory_VersionObjectType_VersionObjectID_VersionModifiedWhen') 
 BEGIN 
	Create NonClustered Index [IX_CMS_ObjectVersionHistory_VersionObjectType_VersionObjectID_VersionModifiedWhen] On [dbo].[CMS_ObjectVersionHistory] ([VersionObjectType] Asc,[VersionObjectID] Asc,[VersionModifiedWhen] Desc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 100, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_ObjectVersionHistory_VersionObjectType_VersionObjectID_VersionModifiedWhen') 
 BEGIN 
	DROP INDEX [IX_CMS_ObjectVersionHistory_VersionObjectType_VersionObjectID_VersionModifiedWhen] On [dbo].[CMS_ObjectVersionHistory];
END
-- 1604200765	CMS_ObjectVersionHistory	6	IX_CMS_ObjectVersionHistory_VersionDeletedByUserID_VersionDeletedWhen	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_ObjectVersionHistory_VersionDeletedByUserID_VersionDeletedWhen') 
 BEGIN 
	Create NonClustered Index [IX_CMS_ObjectVersionHistory_VersionDeletedByUserID_VersionDeletedWhen] On [dbo].[CMS_ObjectVersionHistory] ([VersionDeletedByUserID] Asc,[VersionDeletedWhen] Desc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 100, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_ObjectVersionHistory_VersionDeletedByUserID_VersionDeletedWhen') 
 BEGIN 
	DROP INDEX [IX_CMS_ObjectVersionHistory_VersionDeletedByUserID_VersionDeletedWhen] On [dbo].[CMS_ObjectVersionHistory];
END
-- 1969754420	dbo_HFit_HealthAssesmentUserAnswers_CT	1	dbo_HFit_HealthAssesmentUserAnswers_CT_clustered_idx	
IF NOT Exists (Select name from sys.indexes where name = 'dbo_HFit_HealthAssesmentUserAnswers_CT_clustered_idx') 
 BEGIN 
	Create Unique Clustered Index [dbo_HFit_HealthAssesmentUserAnswers_CT_clustered_idx] On [cdc].[dbo_HFit_HealthAssesmentUserAnswers_CT] ([__$start_lsn] Asc,[__$seqval] Asc,[__$operation] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 100, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'dbo_HFit_HealthAssesmentUserAnswers_CT_clustered_idx') 
 BEGIN 
	DROP INDEX [dbo_HFit_HealthAssesmentUserAnswers_CT_clustered_idx] On [cdc].[dbo_HFit_HealthAssesmentUserAnswers_CT];
END
-- 1983346130	Newsletter_ABTest	3	IX_Newsletter_ABTest_TestWinnerIssueID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Newsletter_ABTest_TestWinnerIssueID') 
 BEGIN 
	Create NonClustered Index [IX_Newsletter_ABTest_TestWinnerIssueID] On [dbo].[Newsletter_ABTest] ([TestWinnerIssueID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Newsletter_ABTest_TestWinnerIssueID') 
 BEGIN 
	DROP INDEX [IX_Newsletter_ABTest_TestWinnerIssueID] On [dbo].[Newsletter_ABTest];
END
-- 2085582468	COM_Address	2	IX_COM_Address_AddressCustomerID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_COM_Address_AddressCustomerID') 
 BEGIN 
	Create NonClustered Index [IX_COM_Address_AddressCustomerID] On [dbo].[COM_Address] ([AddressCustomerID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_COM_Address_AddressCustomerID') 
 BEGIN 
	DROP INDEX [IX_COM_Address_AddressCustomerID] On [dbo].[COM_Address];
END
-- 2085582468	COM_Address	5	IX_COM_Address_AddressEnabled_AddressIsBilling_AddressIsShipping_AddressIsCompany	
IF NOT Exists (Select name from sys.indexes where name = 'IX_COM_Address_AddressEnabled_AddressIsBilling_AddressIsShipping_AddressIsCompany') 
 BEGIN 
	Create NonClustered Index [IX_COM_Address_AddressEnabled_AddressIsBilling_AddressIsShipping_AddressIsCompany] On [dbo].[COM_Address] ([AddressEnabled] Asc,[AddressIsBilling] Asc,[AddressIsShipping] Asc,[AddressIsCompany] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_COM_Address_AddressEnabled_AddressIsBilling_AddressIsShipping_AddressIsCompany') 
 BEGIN 
	DROP INDEX [IX_COM_Address_AddressEnabled_AddressIsBilling_AddressIsShipping_AddressIsCompany] On [dbo].[COM_Address];
END
-- 2094630505	COM_TaxClass	1	IX_COM_TaxClass_TaxClassDisplayName	
IF NOT Exists (Select name from sys.indexes where name = 'IX_COM_TaxClass_TaxClassDisplayName') 
 BEGIN 
	Create Clustered Index [IX_COM_TaxClass_TaxClassDisplayName] On [dbo].[COM_TaxClass] ([TaxClassDisplayName] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_COM_TaxClass_TaxClassDisplayName') 
 BEGIN 
	DROP INDEX [IX_COM_TaxClass_TaxClassDisplayName] On [dbo].[COM_TaxClass];
END
-- 2132918670	HFit_RewardsUserLevelDetail	10	PI_HFit_RewardsUserLevelDetail_Date	
IF NOT Exists (Select name from sys.indexes where name = 'PI_HFit_RewardsUserLevelDetail_Date') 
 BEGIN 
	Create NonClustered Index [PI_HFit_RewardsUserLevelDetail_Date] On [dbo].[HFit_RewardsUserLevelDetail] ([ItemModifiedWhen] Asc) Include ([ItemCreatedWhen])  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 100, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'PI_HFit_RewardsUserLevelDetail_Date') 
 BEGIN 
	DROP INDEX [PI_HFit_RewardsUserLevelDetail_Date] On [dbo].[HFit_RewardsUserLevelDetail];
END
-- 1998630163	Media_Library	3	IX_Media_Library_LibrarySiteID_LibraryName_LibraryGUID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Media_Library_LibrarySiteID_LibraryName_LibraryGUID') 
 BEGIN 
	Create Unique NonClustered Index [IX_Media_Library_LibrarySiteID_LibraryName_LibraryGUID] On [dbo].[Media_Library] ([LibrarySiteID] Asc,[LibraryName] Asc,[LibraryGUID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Media_Library_LibrarySiteID_LibraryName_LibraryGUID') 
 BEGIN 
	DROP INDEX [IX_Media_Library_LibrarySiteID_LibraryName_LibraryGUID] On [dbo].[Media_Library];
END
-- 2016726237	CMS_WorkflowHistory	2	IX_CMS_WorkflowHistory_VersionHistoryID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_WorkflowHistory_VersionHistoryID') 
 BEGIN 
	Create NonClustered Index [IX_CMS_WorkflowHistory_VersionHistoryID] On [dbo].[CMS_WorkflowHistory] ([VersionHistoryID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_WorkflowHistory_VersionHistoryID') 
 BEGIN 
	DROP INDEX [IX_CMS_WorkflowHistory_VersionHistoryID] On [dbo].[CMS_WorkflowHistory];
END
-- 2016726237	CMS_WorkflowHistory	5	IX_CMS_WorkflowHistory_ApprovedWhen	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_WorkflowHistory_ApprovedWhen') 
 BEGIN 
	Create NonClustered Index [IX_CMS_WorkflowHistory_ApprovedWhen] On [dbo].[CMS_WorkflowHistory] ([ApprovedWhen] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_WorkflowHistory_ApprovedWhen') 
 BEGIN 
	DROP INDEX [IX_CMS_WorkflowHistory_ApprovedWhen] On [dbo].[CMS_WorkflowHistory];
END
-- 2021582240	COM_CustomerCreditHistory	1	IX_COM_CustomerCreditHistory_EventCustomerID_EventDate	
IF NOT Exists (Select name from sys.indexes where name = 'IX_COM_CustomerCreditHistory_EventCustomerID_EventDate') 
 BEGIN 
	Create Clustered Index [IX_COM_CustomerCreditHistory_EventCustomerID_EventDate] On [dbo].[COM_CustomerCreditHistory] ([EventCustomerID] Asc,[EventDate] Desc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_COM_CustomerCreditHistory_EventCustomerID_EventDate') 
 BEGIN 
	DROP INDEX [IX_COM_CustomerCreditHistory_EventCustomerID_EventDate] On [dbo].[COM_CustomerCreditHistory];
END
-- 405576483	Analytics_MonthHits	3	IX_Analytics_MonthHits_HitsStatisticsID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Analytics_MonthHits_HitsStatisticsID') 
 BEGIN 
	Create NonClustered Index [IX_Analytics_MonthHits_HitsStatisticsID] On [dbo].[Analytics_MonthHits] ([HitsStatisticsID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Analytics_MonthHits_HitsStatisticsID') 
 BEGIN 
	DROP INDEX [IX_Analytics_MonthHits_HitsStatisticsID] On [dbo].[Analytics_MonthHits];
END
-- 420196547	Newsletter_Subscriber	3	IX_Newsletter_Subscriber_SubscriberType_SubscriberRelatedID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Newsletter_Subscriber_SubscriberType_SubscriberRelatedID') 
 BEGIN 
	Create NonClustered Index [IX_Newsletter_Subscriber_SubscriberType_SubscriberRelatedID] On [dbo].[Newsletter_Subscriber] ([SubscriberType] Asc,[SubscriberRelatedID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Newsletter_Subscriber_SubscriberType_SubscriberRelatedID') 
 BEGIN 
	DROP INDEX [IX_Newsletter_Subscriber_SubscriberType_SubscriberRelatedID] On [dbo].[Newsletter_Subscriber];
END
-- 903674267	CMS_Tree	1	IX_CMS_Tree_NodeID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_Tree_NodeID') 
 BEGIN 
	Create Unique Clustered Index [IX_CMS_Tree_NodeID] On [dbo].[CMS_Tree] ([NodeID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_Tree_NodeID') 
 BEGIN 
	DROP INDEX [IX_CMS_Tree_NodeID] On [dbo].[CMS_Tree];
END
-- 903674267	CMS_Tree	4	IX_CMS_Tree_NodeLinkedNodeID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_Tree_NodeLinkedNodeID') 
 BEGIN 
	Create NonClustered Index [IX_CMS_Tree_NodeLinkedNodeID] On [dbo].[CMS_Tree] ([NodeLinkedNodeID] Asc) Include ([NodeClassID],[NodeID])  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_Tree_NodeLinkedNodeID') 
 BEGIN 
	DROP INDEX [IX_CMS_Tree_NodeLinkedNodeID] On [dbo].[CMS_Tree];
END
-- 903674267	CMS_Tree	12	IX_CMS_Tree_IsSecuredNode_RequiresSSL_NodeCacheMinutes	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_Tree_IsSecuredNode_RequiresSSL_NodeCacheMinutes') 
 BEGIN 
	Create NonClustered Index [IX_CMS_Tree_IsSecuredNode_RequiresSSL_NodeCacheMinutes] On [dbo].[CMS_Tree] ([IsSecuredNode] Asc,[RequiresSSL] Asc,[NodeCacheMinutes] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_Tree_IsSecuredNode_RequiresSSL_NodeCacheMinutes') 
 BEGIN 
	DROP INDEX [IX_CMS_Tree_IsSecuredNode_RequiresSSL_NodeCacheMinutes] On [dbo].[CMS_Tree];
END
-- 903674267	CMS_Tree	15	IX_CMS_Tree_NodeGroupID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_Tree_NodeGroupID') 
 BEGIN 
	Create NonClustered Index [IX_CMS_Tree_NodeGroupID] On [dbo].[CMS_Tree] ([NodeGroupID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_Tree_NodeGroupID') 
 BEGIN 
	DROP INDEX [IX_CMS_Tree_NodeGroupID] On [dbo].[CMS_Tree];
END
-- 923150334	Forums_ForumPost	3	IX_Forums_ForumPost_PostForumID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Forums_ForumPost_PostForumID') 
 BEGIN 
	Create NonClustered Index [IX_Forums_ForumPost_PostForumID] On [dbo].[Forums_ForumPost] ([PostForumID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Forums_ForumPost_PostForumID') 
 BEGIN 
	DROP INDEX [IX_Forums_ForumPost_PostForumID] On [dbo].[Forums_ForumPost];
END
-- 923150334	Forums_ForumPost	6	IX_Forums_ForumPost_PostUserID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Forums_ForumPost_PostUserID') 
 BEGIN 
	Create NonClustered Index [IX_Forums_ForumPost_PostUserID] On [dbo].[Forums_ForumPost] ([PostUserID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Forums_ForumPost_PostUserID') 
 BEGIN 
	DROP INDEX [IX_Forums_ForumPost_PostUserID] On [dbo].[Forums_ForumPost];
END
-- 926626344	OM_ScoreContactRule	4	IX_OM_ScoreContactRule_RuleID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_OM_ScoreContactRule_RuleID') 
 BEGIN 
	Create NonClustered Index [IX_OM_ScoreContactRule_RuleID] On [dbo].[OM_ScoreContactRule] ([RuleID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 100, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_OM_ScoreContactRule_RuleID') 
 BEGIN 
	DROP INDEX [IX_OM_ScoreContactRule_RuleID] On [dbo].[OM_ScoreContactRule];
END
-- 1250103494	Staging_Synchronization	3	IX_Staging_Synchronization_SynchronizationServerID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Staging_Synchronization_SynchronizationServerID') 
 BEGIN 
	Create NonClustered Index [IX_Staging_Synchronization_SynchronizationServerID] On [dbo].[Staging_Synchronization] ([SynchronizationServerID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Staging_Synchronization_SynchronizationServerID') 
 BEGIN 
	DROP INDEX [IX_Staging_Synchronization_SynchronizationServerID] On [dbo].[Staging_Synchronization];
END
-- 1926297922	CMS_AbuseReport	5	IX_CMS_AbuseReport_ReportSiteID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_AbuseReport_ReportSiteID') 
 BEGIN 
	Create NonClustered Index [IX_CMS_AbuseReport_ReportSiteID] On [dbo].[CMS_AbuseReport] ([ReportSiteID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_AbuseReport_ReportSiteID') 
 BEGIN 
	DROP INDEX [IX_CMS_AbuseReport_ReportSiteID] On [dbo].[CMS_AbuseReport];
END
-- 1927677915	COM_SKU	8	IX_COM_SKU_SKUInternalStatusID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_COM_SKU_SKUInternalStatusID') 
 BEGIN 
	Create NonClustered Index [IX_COM_SKU_SKUInternalStatusID] On [dbo].[COM_SKU] ([SKUInternalStatusID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_COM_SKU_SKUInternalStatusID') 
 BEGIN 
	DROP INDEX [IX_COM_SKU_SKUInternalStatusID] On [dbo].[COM_SKU];
END
-- 793769885	Reporting_ReportSubscription	6	IX_Reporting_ReportSubscription_ReportSubscriptionSiteID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Reporting_ReportSubscription_ReportSubscriptionSiteID') 
 BEGIN 
	Create NonClustered Index [IX_Reporting_ReportSubscription_ReportSubscriptionSiteID] On [dbo].[Reporting_ReportSubscription] ([ReportSubscriptionSiteID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Reporting_ReportSubscription_ReportSubscriptionSiteID') 
 BEGIN 
	DROP INDEX [IX_Reporting_ReportSubscription_ReportSubscriptionSiteID] On [dbo].[Reporting_ReportSubscription];
END
-- 1409440095	HFit_LKP_RewardTrigger	7	HFit_LKP_RewardTrigger_PiDate	
IF NOT Exists (Select name from sys.indexes where name = 'HFit_LKP_RewardTrigger_PiDate') 
 BEGIN 
	Create NonClustered Index [HFit_LKP_RewardTrigger_PiDate] On [dbo].[HFit_LKP_RewardTrigger] ([ItemModifiedWhen] Asc) Include ([ItemCreatedWhen])  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 100, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'HFit_LKP_RewardTrigger_PiDate') 
 BEGIN 
	DROP INDEX [HFit_LKP_RewardTrigger_PiDate] On [dbo].[HFit_LKP_RewardTrigger];
END
-- 1421248118	HFit_TrackerSummary	6	idx_HFitTrackerSummary_UserID	
IF NOT Exists (Select name from sys.indexes where name = 'idx_HFitTrackerSummary_UserID') 
 BEGIN 
	Create NonClustered Index [idx_HFitTrackerSummary_UserID] On [dbo].[HFit_TrackerSummary] ([UserId] Asc) Include ([TrackerNodeGUID],[WeekendDate])  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 100, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'idx_HFitTrackerSummary_UserID') 
 BEGIN 
	DROP INDEX [idx_HFitTrackerSummary_UserID] On [dbo].[HFit_TrackerSummary];
END
-- 31339176	HFit_HealthAssesmentUserQuestionGroupResults	7	IX_HFit_HealthAssesmentUserQuestionGroupResult_1	
IF NOT Exists (Select name from sys.indexes where name = 'IX_HFit_HealthAssesmentUserQuestionGroupResult_1') 
 BEGIN 
	Create NonClustered Index [IX_HFit_HealthAssesmentUserQuestionGroupResult_1] On [dbo].[HFit_HealthAssesmentUserQuestionGroupResults] ([HARiskAreaItemID] Asc) Include ([CodeName])  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 100, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_HFit_HealthAssesmentUserQuestionGroupResult_1') 
 BEGIN 
	DROP INDEX [IX_HFit_HealthAssesmentUserQuestionGroupResult_1] On [dbo].[HFit_HealthAssesmentUserQuestionGroupResults];
END
-- 287340088	HFit_HealthAssesmentUserModule	3	IX_HFit_HealthAssesmentUserModule_1	
IF NOT Exists (Select name from sys.indexes where name = 'IX_HFit_HealthAssesmentUserModule_1') 
 BEGIN 
	Create NonClustered Index [IX_HFit_HealthAssesmentUserModule_1] On [dbo].[HFit_HealthAssesmentUserModule] ([UserID] Asc) Include ([HAModuleNodeGUID])  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_HFit_HealthAssesmentUserModule_1') 
 BEGIN 
	DROP INDEX [IX_HFit_HealthAssesmentUserModule_1] On [dbo].[HFit_HealthAssesmentUserModule];
END
-- 302624121	Blog_PostSubscription	2	IX_Blog_PostSubscription_SubscriptionPostDocumentID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Blog_PostSubscription_SubscriptionPostDocumentID') 
 BEGIN 
	Create NonClustered Index [IX_Blog_PostSubscription_SubscriptionPostDocumentID] On [dbo].[Blog_PostSubscription] ([SubscriptionPostDocumentID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Blog_PostSubscription_SubscriptionPostDocumentID') 
 BEGIN 
	DROP INDEX [IX_Blog_PostSubscription_SubscriptionPostDocumentID] On [dbo].[Blog_PostSubscription];
END
-- 313768175	CMS_PageTemplateScope	1	IX_CMS_PageTemplateScope_PageTemplateScopePath	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_PageTemplateScope_PageTemplateScopePath') 
 BEGIN 
	Create Clustered Index [IX_CMS_PageTemplateScope_PageTemplateScopePath] On [dbo].[CMS_PageTemplateScope] ([PageTemplateScopePath] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_PageTemplateScope_PageTemplateScopePath') 
 BEGIN 
	DROP INDEX [IX_CMS_PageTemplateScope_PageTemplateScopePath] On [dbo].[CMS_PageTemplateScope];
END
-- 1062659229	Staging_SyncLogArchive	1	cdx_StagingSyncLogTaskID	
IF NOT Exists (Select name from sys.indexes where name = 'cdx_StagingSyncLogTaskID') 
 BEGIN 
	Create Clustered Index [cdx_StagingSyncLogTaskID] On [dbo].[Staging_SyncLogArchive] ([SyncLogTaskID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'cdx_StagingSyncLogTaskID') 
 BEGIN 
	DROP INDEX [cdx_StagingSyncLogTaskID] On [dbo].[Staging_SyncLogArchive];
END
-- 1074206977	HFit_HealthAssesmentRecomendations	7	Ref76	
IF NOT Exists (Select name from sys.indexes where name = 'Ref76') 
 BEGIN 
	Create NonClustered Index [Ref76] On [dbo].[HFit_HealthAssesmentRecomendations] ([RecomendationTypeID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'Ref76') 
 BEGIN 
	DROP INDEX [Ref76] On [dbo].[HFit_HealthAssesmentRecomendations];
END
-- 1630628852	Notification_TemplateText	3	IX_Notification_TemplateText_GatewayID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Notification_TemplateText_GatewayID') 
 BEGIN 
	Create NonClustered Index [IX_Notification_TemplateText_GatewayID] On [dbo].[Notification_TemplateText] ([GatewayID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Notification_TemplateText_GatewayID') 
 BEGIN 
	DROP INDEX [IX_Notification_TemplateText_GatewayID] On [dbo].[Notification_TemplateText];
END
-- 1639676889	CMS_Site	3	IX_CMS_Site_SiteName	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_Site_SiteName') 
 BEGIN 
	Create NonClustered Index [IX_CMS_Site_SiteName] On [dbo].[CMS_Site] ([SiteName] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_Site_SiteName') 
 BEGIN 
	DROP INDEX [IX_CMS_Site_SiteName] On [dbo].[CMS_Site];
END
-- 1639676889	CMS_Site	6	IX_CMS_Site_SiteDefaultEditorStylesheet	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_Site_SiteDefaultEditorStylesheet') 
 BEGIN 
	Create NonClustered Index [IX_CMS_Site_SiteDefaultEditorStylesheet] On [dbo].[CMS_Site] ([SiteDefaultEditorStylesheet] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_Site_SiteDefaultEditorStylesheet') 
 BEGIN 
	DROP INDEX [IX_CMS_Site_SiteDefaultEditorStylesheet] On [dbo].[CMS_Site];
END
-- 1893581784	COM_ShippingOption	3	IX_COM_ShippingOption_ShippingOptionSiteID_ShippingOptionDisplayName_ShippingOptionEnabled	
IF NOT Exists (Select name from sys.indexes where name = 'IX_COM_ShippingOption_ShippingOptionSiteID_ShippingOptionDisplayName_ShippingOptionEnabled') 
 BEGIN 
	Create NonClustered Index [IX_COM_ShippingOption_ShippingOptionSiteID_ShippingOptionDisplayName_ShippingOptionEnabled] On [dbo].[COM_ShippingOption] ([ShippingOptionSiteID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_COM_ShippingOption_ShippingOptionSiteID_ShippingOptionDisplayName_ShippingOptionEnabled') 
 BEGIN 
	DROP INDEX [IX_COM_ShippingOption_ShippingOptionSiteID_ShippingOptionDisplayName_ShippingOptionEnabled] On [dbo].[COM_ShippingOption];
END
-- 1898489842	HFit_TrackerMealPortions	5	idx_HFit_TrackerMealPortions_CreateDate	
IF NOT Exists (Select name from sys.indexes where name = 'idx_HFit_TrackerMealPortions_CreateDate') 
 BEGIN 
	Create NonClustered Index [idx_HFit_TrackerMealPortions_CreateDate] On [dbo].[HFit_TrackerMealPortions] ([ItemCreatedWhen] Asc,[ItemModifiedWhen] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 100, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'idx_HFit_TrackerMealPortions_CreateDate') 
 BEGIN 
	DROP INDEX [idx_HFit_TrackerMealPortions_CreateDate] On [dbo].[HFit_TrackerMealPortions];
END
-- 1906782546	EDW_GroupMemberHistory	1	PKI_EDW_GroupMemberHistory	
IF NOT Exists (Select name from sys.indexes where name = 'PKI_EDW_GroupMemberHistory') 
 BEGIN 
	Create Unique Clustered Index [PKI_EDW_GroupMemberHistory] On [dbo].[EDW_GroupMemberHistory] ([GroupName] Asc,[UserMpiNumber] Asc,[StartedDate] Asc,[EndedDate] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 100, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'PKI_EDW_GroupMemberHistory') 
 BEGIN 
	DROP INDEX [PKI_EDW_GroupMemberHistory] On [dbo].[EDW_GroupMemberHistory];
END
-- 1919345902	Newsletter_NewsletterIssue	2	IX_Newsletter_NewsletterIssue_IssueNewsletterID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Newsletter_NewsletterIssue_IssueNewsletterID') 
 BEGIN 
	Create NonClustered Index [IX_Newsletter_NewsletterIssue_IssueNewsletterID] On [dbo].[Newsletter_NewsletterIssue] ([IssueNewsletterID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Newsletter_NewsletterIssue_IssueNewsletterID') 
 BEGIN 
	DROP INDEX [IX_Newsletter_NewsletterIssue_IssueNewsletterID] On [dbo].[Newsletter_NewsletterIssue];
END
-- 1735169427	HFit_configGroupToFeature	10	IDX_ConfigGroupToFeatures_SiteID	
IF NOT Exists (Select name from sys.indexes where name = 'IDX_ConfigGroupToFeatures_SiteID') 
 BEGIN 
	Create NonClustered Index [IDX_ConfigGroupToFeatures_SiteID] On [dbo].[HFit_configGroupToFeature] ([SiteID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IDX_ConfigGroupToFeatures_SiteID') 
 BEGIN 
	DROP INDEX [IDX_ConfigGroupToFeatures_SiteID] On [dbo].[HFit_configGroupToFeature];
END
-- 212911830	HFit_TrackerBloodPressure	15	IX_Hfit_TrackerBloodPressure_1	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Hfit_TrackerBloodPressure_1') 
 BEGIN 
	Create NonClustered Index [IX_Hfit_TrackerBloodPressure_1] On [dbo].[HFit_TrackerBloodPressure] ([UserID] Asc,[EventDate] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Hfit_TrackerBloodPressure_1') 
 BEGIN 
	DROP INDEX [IX_Hfit_TrackerBloodPressure_1] On [dbo].[HFit_TrackerBloodPressure];
END
-- 215671816	OM_Contact	2	IX_OM_Contact_ContactLastName	
IF NOT Exists (Select name from sys.indexes where name = 'IX_OM_Contact_ContactLastName') 
 BEGIN 
	Create NonClustered Index [IX_OM_Contact_ContactLastName] On [dbo].[OM_Contact] ([ContactLastName] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 100, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_OM_Contact_ContactLastName') 
 BEGIN 
	DROP INDEX [IX_OM_Contact_ContactLastName] On [dbo].[OM_Contact];
END
-- 215671816	OM_Contact	5	IX_OM_Contact_ContactStatusID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_OM_Contact_ContactStatusID') 
 BEGIN 
	Create NonClustered Index [IX_OM_Contact_ContactStatusID] On [dbo].[OM_Contact] ([ContactStatusID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 100, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_OM_Contact_ContactStatusID') 
 BEGIN 
	DROP INDEX [IX_OM_Contact_ContactStatusID] On [dbo].[OM_Contact];
END
-- 215671816	OM_Contact	8	IX_OM_Contact_ContactMergedWithContactID_ContactSiteID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_OM_Contact_ContactMergedWithContactID_ContactSiteID') 
 BEGIN 
	Create NonClustered Index [IX_OM_Contact_ContactMergedWithContactID_ContactSiteID] On [dbo].[OM_Contact] ([ContactMergedWithContactID] Asc,[ContactSiteID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 100, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_OM_Contact_ContactMergedWithContactID_ContactSiteID') 
 BEGIN 
	DROP INDEX [IX_OM_Contact_ContactMergedWithContactID_ContactSiteID] On [dbo].[OM_Contact];
END
-- 215671816	OM_Contact	11	IX_OM_Contact_SalesForce	
IF NOT Exists (Select name from sys.indexes where name = 'IX_OM_Contact_SalesForce') 
 BEGIN 
	Create NonClustered Index [IX_OM_Contact_SalesForce] On [dbo].[OM_Contact] ([ContactSalesForceLeadID] Asc,[ContactSalesForceLeadReplicationDisabled] Asc,[ContactSalesForceLeadReplicationSuspensionDateTime] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 100, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_OM_Contact_SalesForce') 
 BEGIN 
	DROP INDEX [IX_OM_Contact_SalesForce] On [dbo].[OM_Contact];
END
-- 1966630049	Newsletter_EmailTemplate	1	IX_Newsletter_EmailTemplate_TemplateSiteID_TemplateDisplayName	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Newsletter_EmailTemplate_TemplateSiteID_TemplateDisplayName') 
 BEGIN 
	Create Clustered Index [IX_Newsletter_EmailTemplate_TemplateSiteID_TemplateDisplayName] On [dbo].[Newsletter_EmailTemplate] ([TemplateSiteID] Asc,[TemplateDisplayName] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Newsletter_EmailTemplate_TemplateSiteID_TemplateDisplayName') 
 BEGIN 
	DROP INDEX [IX_Newsletter_EmailTemplate_TemplateSiteID_TemplateDisplayName] On [dbo].[Newsletter_EmailTemplate];
END
-- 1193823365	HFit_TrackerStress	5	idx_HFit_TrackerStress_CreateDate	
IF NOT Exists (Select name from sys.indexes where name = 'idx_HFit_TrackerStress_CreateDate') 
 BEGIN 
	Create NonClustered Index [idx_HFit_TrackerStress_CreateDate] On [dbo].[HFit_TrackerStress] ([ItemCreatedWhen] Asc,[ItemModifiedWhen] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'idx_HFit_TrackerStress_CreateDate') 
 BEGIN 
	DROP INDEX [idx_HFit_TrackerStress_CreateDate] On [dbo].[HFit_TrackerStress];
END
-- 722101613	CMS_Resource	1	IX_CMS_Resource_ResourceDisplayName	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_Resource_ResourceDisplayName') 
 BEGIN 
	Create Clustered Index [IX_CMS_Resource_ResourceDisplayName] On [dbo].[CMS_Resource] ([ResourceDisplayName] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_Resource_ResourceDisplayName') 
 BEGIN 
	DROP INDEX [IX_CMS_Resource_ResourceDisplayName] On [dbo].[CMS_Resource];
END
-- 741577680	Polls_Poll	3	IX_Polls_Poll_PollSiteID_PollCodeName	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Polls_Poll_PollSiteID_PollCodeName') 
 BEGIN 
	Create NonClustered Index [IX_Polls_Poll_PollSiteID_PollCodeName] On [dbo].[Polls_Poll] ([PollSiteID] Asc,[PollCodeName] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Polls_Poll_PollSiteID_PollCodeName') 
 BEGIN 
	DROP INDEX [IX_Polls_Poll_PollSiteID_PollCodeName] On [dbo].[Polls_Poll];
END
-- 742866309	HFit_TrackerInstance_Tracker	7	idx_HFit_TrackerInstance_Tracker_CreateDate	
IF NOT Exists (Select name from sys.indexes where name = 'idx_HFit_TrackerInstance_Tracker_CreateDate') 
 BEGIN 
	Create NonClustered Index [idx_HFit_TrackerInstance_Tracker_CreateDate] On [dbo].[HFit_TrackerInstance_Tracker] ([ItemCreatedWhen] Asc,[ItemModifiedWhen] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 100, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'idx_HFit_TrackerInstance_Tracker_CreateDate') 
 BEGIN 
	DROP INDEX [idx_HFit_TrackerInstance_Tracker_CreateDate] On [dbo].[HFit_TrackerInstance_Tracker];
END
-- 340912286	HFit_TrackerWholeGrains	5	idx_HFit_TrackerWholeGrains_CreateDate	
IF NOT Exists (Select name from sys.indexes where name = 'idx_HFit_TrackerWholeGrains_CreateDate') 
 BEGIN 
	Create NonClustered Index [idx_HFit_TrackerWholeGrains_CreateDate] On [dbo].[HFit_TrackerWholeGrains] ([ItemCreatedWhen] Asc,[ItemModifiedWhen] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'idx_HFit_TrackerWholeGrains_CreateDate') 
 BEGIN 
	DROP INDEX [idx_HFit_TrackerWholeGrains_CreateDate] On [dbo].[HFit_TrackerWholeGrains];
END
-- 350624292	OM_Activity	2	IX_OM_Activity_ActivityActiveContactID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_OM_Activity_ActivityActiveContactID') 
 BEGIN 
	Create NonClustered Index [IX_OM_Activity_ActivityActiveContactID] On [dbo].[OM_Activity] ([ActivityActiveContactID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 100, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_OM_Activity_ActivityActiveContactID') 
 BEGIN 
	DROP INDEX [IX_OM_Activity_ActivityActiveContactID] On [dbo].[OM_Activity];
END
-- 350624292	OM_Activity	5	IX_OM_Activity_ActivityType	
IF NOT Exists (Select name from sys.indexes where name = 'IX_OM_Activity_ActivityType') 
 BEGIN 
	Create NonClustered Index [IX_OM_Activity_ActivityType] On [dbo].[OM_Activity] ([ActivityType] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 100, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_OM_Activity_ActivityType') 
 BEGIN 
	DROP INDEX [IX_OM_Activity_ActivityType] On [dbo].[OM_Activity];
END
-- 363864363	CMS_BannedIP	1	IX_CMS_BannedIP_IPAddressSiteID_IPAddress	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_BannedIP_IPAddressSiteID_IPAddress') 
 BEGIN 
	Create Clustered Index [IX_CMS_BannedIP_IPAddressSiteID_IPAddress] On [dbo].[CMS_BannedIP] ([IPAddress] Asc,[IPAddressSiteID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_BannedIP_IPAddressSiteID_IPAddress') 
 BEGIN 
	DROP INDEX [IX_CMS_BannedIP_IPAddressSiteID_IPAddress] On [dbo].[CMS_BannedIP];
END
-- 432108680	HFit_HealthAssesmentThresholds	10	idx_ThresholdTypeID	
IF NOT Exists (Select name from sys.indexes where name = 'idx_ThresholdTypeID') 
 BEGIN 
	Create NonClustered Index [idx_ThresholdTypeID] On [dbo].[HFit_HealthAssesmentThresholds] ([ThresholdTypeID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'idx_ThresholdTypeID') 
 BEGIN 
	DROP INDEX [idx_ThresholdTypeID] On [dbo].[HFit_HealthAssesmentThresholds];
END
-- 432108680	HFit_HealthAssesmentThresholds	13	Ref65	
IF NOT Exists (Select name from sys.indexes where name = 'Ref65') 
 BEGIN 
	Create NonClustered Index [Ref65] On [dbo].[HFit_HealthAssesmentThresholds] ([ThresholdTypeID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'Ref65') 
 BEGIN 
	DROP INDEX [Ref65] On [dbo].[HFit_HealthAssesmentThresholds];
END
-- 13243102	CMS_AutomationHistory	8	nonHistStateID	
IF NOT Exists (Select name from sys.indexes where name = 'nonHistStateID') 
 BEGIN 
	Create NonClustered Index [nonHistStateID] On [dbo].[CMS_AutomationHistory] ([HistoryStateID] Asc) Include ([HistoryID],[HistoryStepID],[HistoryStepName],[HistoryStepDisplayName],[HistoryStepType],[HistoryTargetStepID],[HistoryTargetStepName],[HistoryTargetStepDisplayName],[HistoryTargetStepType],[HistoryApprovedByUserID],[HistoryApprovedWhen],[HistoryComment],[HistoryTransitionType],[HistoryWorkflowID],[HistoryRejected],[HistoryWasRejected])  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'nonHistStateID') 
 BEGIN 
	DROP INDEX [nonHistStateID] On [dbo].[CMS_AutomationHistory];
END
-- 16719112	CMS_Query	3	IX_CMS_Query_QueryClassID_QueryName	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_Query_QueryClassID_QueryName') 
 BEGIN 
	Create NonClustered Index [IX_CMS_Query_QueryClassID_QueryName] On [dbo].[CMS_Query] ([ClassID] Asc,[QueryName] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_Query_QueryClassID_QueryName') 
 BEGIN 
	DROP INDEX [IX_CMS_Query_QueryClassID_QueryName] On [dbo].[CMS_Query];
END
-- 702625546	Messaging_Message	3	IX_Messaging_Message_MessageSenderUserID_MessageSent_MessageSenderDeleted	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Messaging_Message_MessageSenderUserID_MessageSent_MessageSenderDeleted') 
 BEGIN 
	Create NonClustered Index [IX_Messaging_Message_MessageSenderUserID_MessageSent_MessageSenderDeleted] On [dbo].[Messaging_Message] ([MessageSenderUserID] Asc,[MessageSent] Asc,[MessageSenderDeleted] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Messaging_Message_MessageSenderUserID_MessageSent_MessageSenderDeleted') 
 BEGIN 
	DROP INDEX [IX_Messaging_Message_MessageSenderUserID_MessageSent_MessageSenderDeleted] On [dbo].[Messaging_Message];
END
-- 713769600	Community_Friend	4	IX_Community_Friend_FriendUserID_FriendStatus	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Community_Friend_FriendUserID_FriendStatus') 
 BEGIN 
	Create NonClustered Index [IX_Community_Friend_FriendUserID_FriendStatus] On [dbo].[Community_Friend] ([FriendUserID] Asc,[FriendStatus] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Community_Friend_FriendUserID_FriendStatus') 
 BEGIN 
	DROP INDEX [IX_Community_Friend_FriendUserID_FriendStatus] On [dbo].[Community_Friend];
END
-- 2053582354	COM_Currency	1	IX_COM_Currency_CurrencyDisplayName	
IF NOT Exists (Select name from sys.indexes where name = 'IX_COM_Currency_CurrencyDisplayName') 
 BEGIN 
	Create Clustered Index [IX_COM_Currency_CurrencyDisplayName] On [dbo].[COM_Currency] ([CurrencyDisplayName] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_COM_Currency_CurrencyDisplayName') 
 BEGIN 
	DROP INDEX [IX_COM_Currency_CurrencyDisplayName] On [dbo].[COM_Currency];
END
-- 2055678371	COM_Order	4	IX_COM_Order_OrderShippingAddressID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_COM_Order_OrderShippingAddressID') 
 BEGIN 
	Create NonClustered Index [IX_COM_Order_OrderShippingAddressID] On [dbo].[COM_Order] ([OrderShippingAddressID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_COM_Order_OrderShippingAddressID') 
 BEGIN 
	DROP INDEX [IX_COM_Order_OrderShippingAddressID] On [dbo].[COM_Order];
END
-- 2055678371	COM_Order	7	IX_COM_Order_OrderCurrencyID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_COM_Order_OrderCurrencyID') 
 BEGIN 
	Create NonClustered Index [IX_COM_Order_OrderCurrencyID] On [dbo].[COM_Order] ([OrderCurrencyID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_COM_Order_OrderCurrencyID') 
 BEGIN 
	DROP INDEX [IX_COM_Order_OrderCurrencyID] On [dbo].[COM_Order];
END
-- 2055678371	COM_Order	10	IX_COM_Order_OrderDiscountCouponID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_COM_Order_OrderDiscountCouponID') 
 BEGIN 
	Create NonClustered Index [IX_COM_Order_OrderDiscountCouponID] On [dbo].[COM_Order] ([OrderDiscountCouponID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_COM_Order_OrderDiscountCouponID') 
 BEGIN 
	DROP INDEX [IX_COM_Order_OrderDiscountCouponID] On [dbo].[COM_Order];
END
-- 2062630391	Export_Task	2	IX_Export_Task_TaskSiteID_TaskObjectType	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Export_Task_TaskSiteID_TaskObjectType') 
 BEGIN 
	Create NonClustered Index [IX_Export_Task_TaskSiteID_TaskObjectType] On [dbo].[Export_Task] ([TaskSiteID] Asc,[TaskObjectType] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Export_Task_TaskSiteID_TaskObjectType') 
 BEGIN 
	DROP INDEX [IX_Export_Task_TaskSiteID_TaskObjectType] On [dbo].[Export_Task];
END
-- 2112726579	CMS_Document	2	IX_CMS_Document_DocumentForeignKeyValue_DocumentID_DocumentNodeID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_Document_DocumentForeignKeyValue_DocumentID_DocumentNodeID') 
 BEGIN 
	Create NonClustered Index [IX_CMS_Document_DocumentForeignKeyValue_DocumentID_DocumentNodeID] On [dbo].[CMS_Document] ([DocumentForeignKeyValue] Asc,[DocumentID] Asc,[DocumentNodeID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_Document_DocumentForeignKeyValue_DocumentID_DocumentNodeID') 
 BEGIN 
	DROP INDEX [IX_CMS_Document_DocumentForeignKeyValue_DocumentID_DocumentNodeID] On [dbo].[CMS_Document];
END
-- 2112726579	CMS_Document	5	IX_CMS_Document_DocumentUrlPath_DocumentID_DocumentNodeID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_Document_DocumentUrlPath_DocumentID_DocumentNodeID') 
 BEGIN 
	Create NonClustered Index [IX_CMS_Document_DocumentUrlPath_DocumentID_DocumentNodeID] On [dbo].[CMS_Document] ([DocumentUrlPath] Asc) Include ([DocumentID],[DocumentNodeID])  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_Document_DocumentUrlPath_DocumentID_DocumentNodeID') 
 BEGIN 
	DROP INDEX [IX_CMS_Document_DocumentUrlPath_DocumentID_DocumentNodeID] On [dbo].[CMS_Document];
END
-- 2112726579	CMS_Document	13	IX_CMS_Document_DocumentPageTemplateID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_Document_DocumentPageTemplateID') 
 BEGIN 
	Create NonClustered Index [IX_CMS_Document_DocumentPageTemplateID] On [dbo].[CMS_Document] ([DocumentPageTemplateID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_Document_DocumentPageTemplateID') 
 BEGIN 
	DROP INDEX [IX_CMS_Document_DocumentPageTemplateID] On [dbo].[CMS_Document];
END
-- 2112726579	CMS_Document	36	IX_CMS_Document_CreateDate	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_Document_CreateDate') 
 BEGIN 
	Create NonClustered Index [IX_CMS_Document_CreateDate] On [dbo].[CMS_Document] ([DocumentCreatedWhen] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_Document_CreateDate') 
 BEGIN 
	DROP INDEX [IX_CMS_Document_CreateDate] On [dbo].[CMS_Document];
END
-- 2064726408	CMS_VersionHistory	17	IX_CMS_VersionHistory_ModifiedByUserID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_VersionHistory_ModifiedByUserID') 
 BEGIN 
	Create NonClustered Index [IX_CMS_VersionHistory_ModifiedByUserID] On [dbo].[CMS_VersionHistory] ([ModifiedByUserID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_VersionHistory_ModifiedByUserID') 
 BEGIN 
	DROP INDEX [IX_CMS_VersionHistory_ModifiedByUserID] On [dbo].[CMS_VersionHistory];
END
-- 2112726579	CMS_Document	8	IX_CMS_Document_DocumentCreatedByUserID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_Document_DocumentCreatedByUserID') 
 BEGIN 
	Create NonClustered Index [IX_CMS_Document_DocumentCreatedByUserID] On [dbo].[CMS_Document] ([DocumentCreatedByUserID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_Document_DocumentCreatedByUserID') 
 BEGIN 
	DROP INDEX [IX_CMS_Document_DocumentCreatedByUserID] On [dbo].[CMS_Document];
END
-- 2112726579	CMS_Document	11	IX_CMS_Document_DocumentShowInSiteMap	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_Document_DocumentShowInSiteMap') 
 BEGIN 
	Create NonClustered Index [IX_CMS_Document_DocumentShowInSiteMap] On [dbo].[CMS_Document] ([DocumentShowInSiteMap] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_Document_DocumentShowInSiteMap') 
 BEGIN 
	DROP INDEX [IX_CMS_Document_DocumentShowInSiteMap] On [dbo].[CMS_Document];
END
-- 2112726579	CMS_Document	14	IX_CMS_Document_DocumentTagGroupID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_Document_DocumentTagGroupID') 
 BEGIN 
	Create NonClustered Index [IX_CMS_Document_DocumentTagGroupID] On [dbo].[CMS_Document] ([DocumentTagGroupID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_Document_DocumentTagGroupID') 
 BEGIN 
	DROP INDEX [IX_CMS_Document_DocumentTagGroupID] On [dbo].[CMS_Document];
END
-- 2112726579	CMS_Document	37	IX_CMS_Document_ModifiedDate	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_Document_ModifiedDate') 
 BEGIN 
	Create NonClustered Index [IX_CMS_Document_ModifiedDate] On [dbo].[CMS_Document] ([DocumentModifiedWhen] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_Document_ModifiedDate') 
 BEGIN 
	DROP INDEX [IX_CMS_Document_ModifiedDate] On [dbo].[CMS_Document];
END
-- 166291652	CMS_WebFarmServer	4	IX_CMS_WebFarmServer_ServerNameServerLastUpdated	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_WebFarmServer_ServerNameServerLastUpdated') 
 BEGIN 
	Create NonClustered Index [IX_CMS_WebFarmServer_ServerNameServerLastUpdated] On [dbo].[CMS_WebFarmServer] ([ServerName] Asc,[ServerLastUpdated] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_WebFarmServer_ServerNameServerLastUpdated') 
 BEGIN 
	DROP INDEX [IX_CMS_WebFarmServer_ServerNameServerLastUpdated] On [dbo].[CMS_WebFarmServer];
END
-- 1458104235	Reporting_SavedGraph	3	IX_Reporting_SavedGraph_SavedGraphGUID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Reporting_SavedGraph_SavedGraphGUID') 
 BEGIN 
	Create NonClustered Index [IX_Reporting_SavedGraph_SavedGraphGUID] On [dbo].[Reporting_SavedGraph] ([SavedGraphGUID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Reporting_SavedGraph_SavedGraphGUID') 
 BEGIN 
	DROP INDEX [IX_Reporting_SavedGraph_SavedGraphGUID] On [dbo].[Reporting_SavedGraph];
END
-- 1687169256	HFit_configFeatures	12	IDX_ConfigFeatures_SiteID	
IF NOT Exists (Select name from sys.indexes where name = 'IDX_ConfigFeatures_SiteID') 
 BEGIN 
	Create NonClustered Index [IDX_ConfigFeatures_SiteID] On [dbo].[HFit_configFeatures] ([SiteID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IDX_ConfigFeatures_SiteID') 
 BEGIN 
	DROP INDEX [IDX_ConfigFeatures_SiteID] On [dbo].[HFit_configFeatures];
END
-- 1704393141	HFit_TrackerTobaccoFree	5	idx_HFit_TrackerTobaccoFree_CreateDate	
IF NOT Exists (Select name from sys.indexes where name = 'idx_HFit_TrackerTobaccoFree_CreateDate') 
 BEGIN 
	Create NonClustered Index [idx_HFit_TrackerTobaccoFree_CreateDate] On [dbo].[HFit_TrackerTobaccoFree] ([ItemCreatedWhen] Asc,[ItemModifiedWhen] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'idx_HFit_TrackerTobaccoFree_CreateDate') 
 BEGIN 
	DROP INDEX [idx_HFit_TrackerTobaccoFree_CreateDate] On [dbo].[HFit_TrackerTobaccoFree];
END
-- 743673697	Community_GroupMember	4	IX_Community_GroupMember_MemberGroupID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Community_GroupMember_MemberGroupID') 
 BEGIN 
	Create NonClustered Index [IX_Community_GroupMember_MemberGroupID] On [dbo].[Community_GroupMember] ([MemberGroupID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Community_GroupMember_MemberGroupID') 
 BEGIN 
	DROP INDEX [IX_Community_GroupMember_MemberGroupID] On [dbo].[Community_GroupMember];
END
-- 1129771082	CMS_Email	4	IX_CMS_Email_EmailStatus_EmailID_EmailPriority_EmailLastModified	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_Email_EmailStatus_EmailID_EmailPriority_EmailLastModified') 
 BEGIN 
	Create NonClustered Index [IX_CMS_Email_EmailStatus_EmailID_EmailPriority_EmailLastModified] On [dbo].[CMS_Email] ([EmailStatus] Asc,[EmailID] Asc) Include ([EmailLastModified],[EmailPriority])  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_Email_EmailStatus_EmailID_EmailPriority_EmailLastModified') 
 BEGIN 
	DROP INDEX [IX_CMS_Email_EmailStatus_EmailID_EmailPriority_EmailLastModified] On [dbo].[CMS_Email];
END
-- 1130487106	HFit_TrackerWater	5	idx_HFit_TrackerWater_CreateDate	
IF NOT Exists (Select name from sys.indexes where name = 'idx_HFit_TrackerWater_CreateDate') 
 BEGIN 
	Create NonClustered Index [idx_HFit_TrackerWater_CreateDate] On [dbo].[HFit_TrackerWater] ([ItemCreatedWhen] Asc,[ItemModifiedWhen] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'idx_HFit_TrackerWater_CreateDate') 
 BEGIN 
	DROP INDEX [idx_HFit_TrackerWater_CreateDate] On [dbo].[HFit_TrackerWater];
END
-- 1133663532	HFit_Screening_QST	7	IX_HFit_Screening_QST_1	
IF NOT Exists (Select name from sys.indexes where name = 'IX_HFit_Screening_QST_1') 
 BEGIN 
	Create NonClustered Index [IX_HFit_Screening_QST_1] On [dbo].[HFit_Screening_QST] ([SSISLoadID] Asc,[SBL_Participant_ID] Asc) Include ([Timestamp])  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_HFit_Screening_QST_1') 
 BEGIN 
	DROP INDEX [IX_HFit_Screening_QST_1] On [dbo].[HFit_Screening_QST];
END
-- 555865047	Chat_Room	3	IX_Chat_Room_Enabled	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Chat_Room_Enabled') 
 BEGIN 
	Create NonClustered Index [IX_Chat_Room_Enabled] On [dbo].[Chat_Room] ([ChatRoomEnabled] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Chat_Room_Enabled') 
 BEGIN 
	DROP INDEX [IX_Chat_Room_Enabled] On [dbo].[Chat_Room];
END
-- 562101043	CMS_RelationshipName	2	IX_CMS_RelationshipName_RelationshipName_RelationshipDisplayName	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_RelationshipName_RelationshipName_RelationshipDisplayName') 
 BEGIN 
	Create NonClustered Index [IX_CMS_RelationshipName_RelationshipName_RelationshipDisplayName] On [dbo].[CMS_RelationshipName] ([RelationshipName] Asc,[RelationshipDisplayName] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_RelationshipName_RelationshipName_RelationshipDisplayName') 
 BEGIN 
	DROP INDEX [IX_CMS_RelationshipName_RelationshipName_RelationshipDisplayName] On [dbo].[CMS_RelationshipName];
END
-- 564197060	CMS_UserSettings	3	IX_CMS_UserSettings_UserActivatedByUserID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_UserSettings_UserActivatedByUserID') 
 BEGIN 
	Create NonClustered Index [IX_CMS_UserSettings_UserActivatedByUserID] On [dbo].[CMS_UserSettings] ([UserActivatedByUserID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_UserSettings_UserActivatedByUserID') 
 BEGIN 
	DROP INDEX [IX_CMS_UserSettings_UserActivatedByUserID] On [dbo].[CMS_UserSettings];
END
-- 564197060	CMS_UserSettings	11	IX_CMS_UserSettings_UserWaitingForApproval	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_UserSettings_UserWaitingForApproval') 
 BEGIN 
	Create NonClustered Index [IX_CMS_UserSettings_UserWaitingForApproval] On [dbo].[CMS_UserSettings] ([UserWaitingForApproval] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_UserSettings_UserWaitingForApproval') 
 BEGIN 
	DROP INDEX [IX_CMS_UserSettings_UserWaitingForApproval] On [dbo].[CMS_UserSettings];
END
-- 564197060	CMS_UserSettings	14	IX_CMS_UserSettings_UserPasswordRequestHash	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_UserSettings_UserPasswordRequestHash') 
 BEGIN 
	Create NonClustered Index [IX_CMS_UserSettings_UserPasswordRequestHash] On [dbo].[CMS_UserSettings] ([UserPasswordRequestHash] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_UserSettings_UserPasswordRequestHash') 
 BEGIN 
	DROP INDEX [IX_CMS_UserSettings_UserPasswordRequestHash] On [dbo].[CMS_UserSettings];
END
-- 1849773647	OM_Membership	2	IX_OM_Membership_RelatedID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_OM_Membership_RelatedID') 
 BEGIN 
	Create NonClustered Index [IX_OM_Membership_RelatedID] On [dbo].[OM_Membership] ([RelatedID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_OM_Membership_RelatedID') 
 BEGIN 
	DROP INDEX [IX_OM_Membership_RelatedID] On [dbo].[OM_Membership];
END
-- 1849773647	OM_Membership	8	idx_HFit_OM_Membership_ActiveContactIDRelatedid	
IF NOT Exists (Select name from sys.indexes where name = 'idx_HFit_OM_Membership_ActiveContactIDRelatedid') 
 BEGIN 
	Create NonClustered Index [idx_HFit_OM_Membership_ActiveContactIDRelatedid] On [dbo].[OM_Membership] ([OriginalContactID] Asc,[ActiveContactID] Asc,[RelatedID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'idx_HFit_OM_Membership_ActiveContactIDRelatedid') 
 BEGIN 
	DROP INDEX [idx_HFit_OM_Membership_ActiveContactIDRelatedid] On [dbo].[OM_Membership];
END
-- 1849773647	OM_Membership	11	IX_OM_MembershipMember	
IF NOT Exists (Select name from sys.indexes where name = 'IX_OM_MembershipMember') 
 BEGIN 
	Create NonClustered Index [IX_OM_MembershipMember] On [dbo].[OM_Membership] ([MemberType] Asc) Include ([ActiveContactID],[RelatedID])  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_OM_MembershipMember') 
 BEGIN 
	DROP INDEX [IX_OM_MembershipMember] On [dbo].[OM_Membership];
END
-- 1853965681	HFit_TrackerBloodSugarAndGlucose	15	IX_TrackerBloodSugar_ProfCollecUserID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_TrackerBloodSugar_ProfCollecUserID') 
 BEGIN 
	Create NonClustered Index [IX_TrackerBloodSugar_ProfCollecUserID] On [dbo].[HFit_TrackerBloodSugarAndGlucose] ([IsProfessionallyCollected] Asc,[UserID] Asc,[EventDate] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_TrackerBloodSugar_ProfCollecUserID') 
 BEGIN 
	DROP INDEX [IX_TrackerBloodSugar_ProfCollecUserID] On [dbo].[HFit_TrackerBloodSugarAndGlucose];
END
-- 150291595	View_CMS_Tree_Joined_Linked	1	IX_View_CMS_Tree_Joined_Linked_NodeSiteID_DocumentCulture_NodeID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_View_CMS_Tree_Joined_Linked_NodeSiteID_DocumentCulture_NodeID') 
 BEGIN 
	Create Unique Clustered Index [IX_View_CMS_Tree_Joined_Linked_NodeSiteID_DocumentCulture_NodeID] On [dbo].[View_CMS_Tree_Joined_Linked] ([NodeSiteID] Asc,[DocumentCulture] Asc,[NodeID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 100, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_View_CMS_Tree_Joined_Linked_NodeSiteID_DocumentCulture_NodeID') 
 BEGIN 
	DROP INDEX [IX_View_CMS_Tree_Joined_Linked_NodeSiteID_DocumentCulture_NodeID] On [dbo].[View_CMS_Tree_Joined_Linked];
END
-- 150291595	View_CMS_Tree_Joined_Linked	4	IX_View_CMS_Tree_Joined_Linked_ClassName_NodeID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_View_CMS_Tree_Joined_Linked_ClassName_NodeID') 
 BEGIN 
	Create NonClustered Index [IX_View_CMS_Tree_Joined_Linked_ClassName_NodeID] On [dbo].[View_CMS_Tree_Joined_Linked] ([ClassName] Asc) Include ([DocumentCheckedOutVersionHistoryID],[DocumentCreatedByUserID],[DocumentCreatedWhen],[DocumentCulture],[DocumentForeignKeyValue],[DocumentID],[DocumentIsArchived],[DocumentModifiedWhen],[DocumentNodeID],[DocumentPublishedVersionHistoryID],[DocumentPublishFrom],[DocumentPublishTo],[NodeID],[NodeLevel],[NodeName])  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 100, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_View_CMS_Tree_Joined_Linked_ClassName_NodeID') 
 BEGIN 
	DROP INDEX [IX_View_CMS_Tree_Joined_Linked_ClassName_NodeID] On [dbo].[View_CMS_Tree_Joined_Linked];
END
-- 150291595	View_CMS_Tree_Joined_Linked	7	IDX_View_CMS_Tree_Joined_Linked_NodeID_DocCulture	
IF NOT Exists (Select name from sys.indexes where name = 'IDX_View_CMS_Tree_Joined_Linked_NodeID_DocCulture') 
 BEGIN 
	Create NonClustered Index [IDX_View_CMS_Tree_Joined_Linked_NodeID_DocCulture] On [dbo].[View_CMS_Tree_Joined_Linked] ([NodeID] Asc,[DocumentCulture] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 100, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IDX_View_CMS_Tree_Joined_Linked_NodeID_DocCulture') 
 BEGIN 
	DROP INDEX [IDX_View_CMS_Tree_Joined_Linked_NodeID_DocCulture] On [dbo].[View_CMS_Tree_Joined_Linked];
END
-- 1351675863	Board_Board	5	IX_Board_Board_BoardSiteID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Board_Board_BoardSiteID') 
 BEGIN 
	Create NonClustered Index [IX_Board_Board_BoardSiteID] On [dbo].[Board_Board] ([BoardSiteID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Board_Board_BoardSiteID') 
 BEGIN 
	DROP INDEX [IX_Board_Board_BoardSiteID] On [dbo].[Board_Board];
END
-- 1218103380	Staging_SyncLog	3	IX_Staging_SyncLog_SyncLogServerID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Staging_SyncLog_SyncLogServerID') 
 BEGIN 
	Create NonClustered Index [IX_Staging_SyncLog_SyncLogServerID] On [dbo].[Staging_SyncLog] ([SyncLogServerID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Staging_SyncLog_SyncLogServerID') 
 BEGIN 
	DROP INDEX [IX_Staging_SyncLog_SyncLogServerID] On [dbo].[Staging_SyncLog];
END
-- 1229247434	CMS_AutomationState	2	IX_CMS_AutomationState_StateStepID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_AutomationState_StateStepID') 
 BEGIN 
	Create NonClustered Index [IX_CMS_AutomationState_StateStepID] On [dbo].[CMS_AutomationState] ([StateStepID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_AutomationState_StateStepID') 
 BEGIN 
	DROP INDEX [IX_CMS_AutomationState_StateStepID] On [dbo].[CMS_AutomationState];
END
-- 1019150676	Forums_Attachment	2	IX_Forums_Attachment_AttachmentGUID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Forums_Attachment_AttachmentGUID') 
 BEGIN 
	Create Unique NonClustered Index [IX_Forums_Attachment_AttachmentGUID] On [dbo].[Forums_Attachment] ([AttachmentSiteID] Asc,[AttachmentGUID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Forums_Attachment_AttachmentGUID') 
 BEGIN 
	DROP INDEX [IX_Forums_Attachment_AttachmentGUID] On [dbo].[Forums_Attachment];
END
-- 1026102696	CMS_WorkflowStep	3	IX_CMS_WorkflowStep_StepWorkflowID_StepName	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_WorkflowStep_StepWorkflowID_StepName') 
 BEGIN 
	Create Unique NonClustered Index [IX_CMS_WorkflowStep_StepWorkflowID_StepName] On [dbo].[CMS_WorkflowStep] ([StepWorkflowID] Asc,[StepName] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_WorkflowStep_StepWorkflowID_StepName') 
 BEGIN 
	DROP INDEX [IX_CMS_WorkflowStep_StepWorkflowID_StepName] On [dbo].[CMS_WorkflowStep];
END
-- 1443028422	HFit_UserGoal	21	IX_UserGoal_UserID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_UserGoal_UserID') 
 BEGIN 
	Create NonClustered Index [IX_UserGoal_UserID] On [dbo].[HFit_UserGoal] ([UserID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_UserGoal_UserID') 
 BEGIN 
	DROP INDEX [IX_UserGoal_UserID] On [dbo].[HFit_UserGoal];
END
-- 1602104748	Reporting_ReportGraph	2	IX_Reporting_ReportGraph_GraphReportID_GraphName	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Reporting_ReportGraph_GraphReportID_GraphName') 
 BEGIN 
	Create Unique NonClustered Index [IX_Reporting_ReportGraph_GraphReportID_GraphName] On [dbo].[Reporting_ReportGraph] ([GraphReportID] Asc,[GraphName] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Reporting_ReportGraph_GraphReportID_GraphName') 
 BEGIN 
	DROP INDEX [IX_Reporting_ReportGraph_GraphReportID_GraphName] On [dbo].[Reporting_ReportGraph];
END
-- 1604200765	CMS_ObjectVersionHistory	5	IX_CMS_ObjectVersionHistory_VersionModifiedByUserID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_ObjectVersionHistory_VersionModifiedByUserID') 
 BEGIN 
	Create NonClustered Index [IX_CMS_ObjectVersionHistory_VersionModifiedByUserID] On [dbo].[CMS_ObjectVersionHistory] ([VersionModifiedByUserID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 100, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_ObjectVersionHistory_VersionModifiedByUserID') 
 BEGIN 
	DROP INDEX [IX_CMS_ObjectVersionHistory_VersionModifiedByUserID] On [dbo].[CMS_ObjectVersionHistory];
END
-- 1969442090	HFit_TrackerWeight	13	idx_HFit_TrackerWeight_CreateDate	
IF NOT Exists (Select name from sys.indexes where name = 'idx_HFit_TrackerWeight_CreateDate') 
 BEGIN 
	Create NonClustered Index [idx_HFit_TrackerWeight_CreateDate] On [dbo].[HFit_TrackerWeight] ([ItemCreatedWhen] Asc,[ItemModifiedWhen] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'idx_HFit_TrackerWeight_CreateDate') 
 BEGIN 
	DROP INDEX [idx_HFit_TrackerWeight_CreateDate] On [dbo].[HFit_TrackerWeight];
END
-- 1983346130	Newsletter_ABTest	2	IX_Newsletter_ABTest_TestIssueID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Newsletter_ABTest_TestIssueID') 
 BEGIN 
	Create Unique NonClustered Index [IX_Newsletter_ABTest_TestIssueID] On [dbo].[Newsletter_ABTest] ([TestIssueID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Newsletter_ABTest_TestIssueID') 
 BEGIN 
	DROP INDEX [IX_Newsletter_ABTest_TestIssueID] On [dbo].[Newsletter_ABTest];
END
-- 1988202133	CMS_PageTemplateCategory	3	IX_CMS_PageTemplateCategory_CategoryParentID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_PageTemplateCategory_CategoryParentID') 
 BEGIN 
	Create NonClustered Index [IX_CMS_PageTemplateCategory_CategoryParentID] On [dbo].[CMS_PageTemplateCategory] ([CategoryParentID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_PageTemplateCategory_CategoryParentID') 
 BEGIN 
	DROP INDEX [IX_CMS_PageTemplateCategory_CategoryParentID] On [dbo].[CMS_PageTemplateCategory];
END
-- 2085582468	COM_Address	4	IX_COM_Address_AddressStateID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_COM_Address_AddressStateID') 
 BEGIN 
	Create NonClustered Index [IX_COM_Address_AddressStateID] On [dbo].[COM_Address] ([AddressStateID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_COM_Address_AddressStateID') 
 BEGIN 
	DROP INDEX [IX_COM_Address_AddressStateID] On [dbo].[COM_Address];
END
-- 2126630619	COM_PublicStatus	1	IX_COM_PublicStatus_PublicStatusDisplayName_PublicStatusEnabled	
IF NOT Exists (Select name from sys.indexes where name = 'IX_COM_PublicStatus_PublicStatusDisplayName_PublicStatusEnabled') 
 BEGIN 
	Create Clustered Index [IX_COM_PublicStatus_PublicStatusDisplayName_PublicStatusEnabled] On [dbo].[COM_PublicStatus] ([PublicStatusDisplayName] Asc,[PublicStatusEnabled] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_COM_PublicStatus_PublicStatusDisplayName_PublicStatusEnabled') 
 BEGIN 
	DROP INDEX [IX_COM_PublicStatus_PublicStatusDisplayName_PublicStatusEnabled] On [dbo].[COM_PublicStatus];
END
-- 2141250683	Staging_Server	3	IX_Staging_Server_ServerEnabled	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Staging_Server_ServerEnabled') 
 BEGIN 
	Create NonClustered Index [IX_Staging_Server_ServerEnabled] On [dbo].[Staging_Server] ([ServerEnabled] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Staging_Server_ServerEnabled') 
 BEGIN 
	DROP INDEX [IX_Staging_Server_ServerEnabled] On [dbo].[Staging_Server];
END
-- 2016726237	CMS_WorkflowHistory	4	IX_CMS_WorkflowHistory_ApprovedByUserID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_WorkflowHistory_ApprovedByUserID') 
 BEGIN 
	Create NonClustered Index [IX_CMS_WorkflowHistory_ApprovedByUserID] On [dbo].[CMS_WorkflowHistory] ([ApprovedByUserID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_WorkflowHistory_ApprovedByUserID') 
 BEGIN 
	DROP INDEX [IX_CMS_WorkflowHistory_ApprovedByUserID] On [dbo].[CMS_WorkflowHistory];
END
-- 420196547	Newsletter_Subscriber	1	IX_Newsletter_Subscriber_SubscriberSiteID_SubscriberFullName	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Newsletter_Subscriber_SubscriberSiteID_SubscriberFullName') 
 BEGIN 
	Create Clustered Index [IX_Newsletter_Subscriber_SubscriberSiteID_SubscriberFullName] On [dbo].[Newsletter_Subscriber] ([SubscriberSiteID] Asc,[SubscriberFullName] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Newsletter_Subscriber_SubscriberSiteID_SubscriberFullName') 
 BEGIN 
	DROP INDEX [IX_Newsletter_Subscriber_SubscriberSiteID_SubscriberFullName] On [dbo].[Newsletter_Subscriber];
END
-- 901578250	CMS_WorkflowStepRoles	1	IX_CMS_WorkflowStepRoles_StepID_StepSourcePointGUID_RoleID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_WorkflowStepRoles_StepID_StepSourcePointGUID_RoleID') 
 BEGIN 
	Create Unique Clustered Index [IX_CMS_WorkflowStepRoles_StepID_StepSourcePointGUID_RoleID] On [dbo].[CMS_WorkflowStepRoles] ([StepID] Asc,[StepSourcePointGUID] Asc,[RoleID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_WorkflowStepRoles_StepID_StepSourcePointGUID_RoleID') 
 BEGIN 
	DROP INDEX [IX_CMS_WorkflowStepRoles_StepID_StepSourcePointGUID_RoleID] On [dbo].[CMS_WorkflowStepRoles];
END
-- 903674267	CMS_Tree	7	IX_CMS_Tree_NodeAliasPath	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_Tree_NodeAliasPath') 
 BEGIN 
	Create NonClustered Index [IX_CMS_Tree_NodeAliasPath] On [dbo].[CMS_Tree] ([NodeAliasPath] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_Tree_NodeAliasPath') 
 BEGIN 
	DROP INDEX [IX_CMS_Tree_NodeAliasPath] On [dbo].[CMS_Tree];
END
-- 903674267	CMS_Tree	10	IX_CMS_Tree_NodeLevel	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_Tree_NodeLevel') 
 BEGIN 
	Create NonClustered Index [IX_CMS_Tree_NodeLevel] On [dbo].[CMS_Tree] ([NodeLevel] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_Tree_NodeLevel') 
 BEGIN 
	DROP INDEX [IX_CMS_Tree_NodeLevel] On [dbo].[CMS_Tree];
END
-- 903674267	CMS_Tree	13	IX_CMS_Tree_NodeSKUID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_Tree_NodeSKUID') 
 BEGIN 
	Create NonClustered Index [IX_CMS_Tree_NodeSKUID] On [dbo].[CMS_Tree] ([NodeSKUID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_Tree_NodeSKUID') 
 BEGIN 
	DROP INDEX [IX_CMS_Tree_NodeSKUID] On [dbo].[CMS_Tree];
END
-- 923150334	Forums_ForumPost	5	IX_Forums_ForumPost_PostLevel	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Forums_ForumPost_PostLevel') 
 BEGIN 
	Create NonClustered Index [IX_Forums_ForumPost_PostLevel] On [dbo].[Forums_ForumPost] ([PostLevel] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Forums_ForumPost_PostLevel') 
 BEGIN 
	DROP INDEX [IX_Forums_ForumPost_PostLevel] On [dbo].[Forums_ForumPost];
END
-- 923150334	Forums_ForumPost	8	IX_Forums_ForumPost_PostApproved	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Forums_ForumPost_PostApproved') 
 BEGIN 
	Create NonClustered Index [IX_Forums_ForumPost_PostApproved] On [dbo].[Forums_ForumPost] ([PostApproved] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Forums_ForumPost_PostApproved') 
 BEGIN 
	DROP INDEX [IX_Forums_ForumPost_PostApproved] On [dbo].[Forums_ForumPost];
END
-- 926626344	OM_ScoreContactRule	3	IX_OM_ScoreContactRule_ScoreID_Expiration_ContactID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_OM_ScoreContactRule_ScoreID_Expiration_ContactID') 
 BEGIN 
	Create NonClustered Index [IX_OM_ScoreContactRule_ScoreID_Expiration_ContactID] On [dbo].[OM_ScoreContactRule] ([ScoreID] Asc,[Expiration] Asc) Include ([ContactID])  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 100, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_OM_ScoreContactRule_ScoreID_Expiration_ContactID') 
 BEGIN 
	DROP INDEX [IX_OM_ScoreContactRule_ScoreID_Expiration_ContactID] On [dbo].[OM_ScoreContactRule];
END
-- 1189579276	COM_TaxClassCountry	2	IX_COM_TaxClassCountry_TaxClassID_CountryID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_COM_TaxClassCountry_TaxClassID_CountryID') 
 BEGIN 
	Create Unique NonClustered Index [IX_COM_TaxClassCountry_TaxClassID_CountryID] On [dbo].[COM_TaxClassCountry] ([TaxClassID] Asc,[CountryID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_COM_TaxClassCountry_TaxClassID_CountryID') 
 BEGIN 
	DROP INDEX [IX_COM_TaxClassCountry_TaxClassID_CountryID] On [dbo].[COM_TaxClassCountry];
END
-- 1781581385	CMS_UserSite	9	ix_CmsUserSite_Userid_PI	
IF NOT Exists (Select name from sys.indexes where name = 'ix_CmsUserSite_Userid_PI') 
 BEGIN 
	Create NonClustered Index [ix_CmsUserSite_Userid_PI] On [dbo].[CMS_UserSite] ([UserID] Asc) Include ([UserSiteID])  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 100, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'ix_CmsUserSite_Userid_PI') 
 BEGIN 
	DROP INDEX [ix_CmsUserSite_Userid_PI] On [dbo].[CMS_UserSite];
END
-- 1783677402	COM_Customer	1	IX_COM_Customer_CustomerLastName_CustomerFirstName_CustomerEnabled	
IF NOT Exists (Select name from sys.indexes where name = 'IX_COM_Customer_CustomerLastName_CustomerFirstName_CustomerEnabled') 
 BEGIN 
	Create Clustered Index [IX_COM_Customer_CustomerLastName_CustomerFirstName_CustomerEnabled] On [dbo].[COM_Customer] ([CustomerLastName] Asc,[CustomerFirstName] Asc,[CustomerEnabled] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_COM_Customer_CustomerLastName_CustomerFirstName_CustomerEnabled') 
 BEGIN 
	DROP INDEX [IX_COM_Customer_CustomerLastName_CustomerFirstName_CustomerEnabled] On [dbo].[COM_Customer];
END
-- 1783677402	COM_Customer	4	IX_COM_Customer_CustomerCompany	
IF NOT Exists (Select name from sys.indexes where name = 'IX_COM_Customer_CustomerCompany') 
 BEGIN 
	Create NonClustered Index [IX_COM_Customer_CustomerCompany] On [dbo].[COM_Customer] ([CustomerCompany] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_COM_Customer_CustomerCompany') 
 BEGIN 
	DROP INDEX [IX_COM_Customer_CustomerCompany] On [dbo].[COM_Customer];
END
-- 1783677402	COM_Customer	7	IX_COM_Customer_CustomerPreferredShippingOptionID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_COM_Customer_CustomerPreferredShippingOptionID') 
 BEGIN 
	Create NonClustered Index [IX_COM_Customer_CustomerPreferredShippingOptionID] On [dbo].[COM_Customer] ([CustomerPreferredShippingOptionID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_COM_Customer_CustomerPreferredShippingOptionID') 
 BEGIN 
	DROP INDEX [IX_COM_Customer_CustomerPreferredShippingOptionID] On [dbo].[COM_Customer];
END
-- 1783677402	COM_Customer	10	IX_COM_Customer_CustomerStateID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_COM_Customer_CustomerStateID') 
 BEGIN 
	Create NonClustered Index [IX_COM_Customer_CustomerStateID] On [dbo].[COM_Customer] ([CustomerStateID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_COM_Customer_CustomerStateID') 
 BEGIN 
	DROP INDEX [IX_COM_Customer_CustomerStateID] On [dbo].[COM_Customer];
END
-- 1790837642	HFit_TrackerShots	9	idx_HFit_TrackerShots_CreateDate	
IF NOT Exists (Select name from sys.indexes where name = 'idx_HFit_TrackerShots_CreateDate') 
 BEGIN 
	Create NonClustered Index [idx_HFit_TrackerShots_CreateDate] On [dbo].[HFit_TrackerShots] ([ItemCreatedWhen] Asc,[ItemModifiedWhen] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 100, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'idx_HFit_TrackerShots_CreateDate') 
 BEGIN 
	DROP INDEX [idx_HFit_TrackerShots_CreateDate] On [dbo].[HFit_TrackerShots];
END
-- 1794105432	CMS_AttachmentHistory	1	IX_CMS_AttachmentHistory_AttachmentDocumentID_AttachmentName	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_AttachmentHistory_AttachmentDocumentID_AttachmentName') 
 BEGIN 
	Create Clustered Index [IX_CMS_AttachmentHistory_AttachmentDocumentID_AttachmentName] On [dbo].[CMS_AttachmentHistory] ([AttachmentDocumentID] Asc,[AttachmentName] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_AttachmentHistory_AttachmentDocumentID_AttachmentName') 
 BEGIN 
	DROP INDEX [IX_CMS_AttachmentHistory_AttachmentDocumentID_AttachmentName] On [dbo].[CMS_AttachmentHistory];
END
-- 1794105432	CMS_AttachmentHistory	4	IX_CMS_AttachmentHistory_AttachmentIsUnsorted_AttachmentGroupGUID_AttachmentOrder	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_AttachmentHistory_AttachmentIsUnsorted_AttachmentGroupGUID_AttachmentOrder') 
 BEGIN 
	Create NonClustered Index [IX_CMS_AttachmentHistory_AttachmentIsUnsorted_AttachmentGroupGUID_AttachmentOrder] On [dbo].[CMS_AttachmentHistory] ([AttachmentIsUnsorted] Asc,[AttachmentGroupGUID] Asc,[AttachmentOrder] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_AttachmentHistory_AttachmentIsUnsorted_AttachmentGroupGUID_AttachmentOrder') 
 BEGIN 
	DROP INDEX [IX_CMS_AttachmentHistory_AttachmentIsUnsorted_AttachmentGroupGUID_AttachmentOrder] On [dbo].[CMS_AttachmentHistory];
END
-- 889770227	Reporting_Report	1	IX_Reporting_Report_ReportCategoryID_ReportDisplayName	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Reporting_Report_ReportCategoryID_ReportDisplayName') 
 BEGIN 
	Create Clustered Index [IX_Reporting_Report_ReportCategoryID_ReportDisplayName] On [dbo].[Reporting_Report] ([ReportDisplayName] Asc,[ReportCategoryID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Reporting_Report_ReportCategoryID_ReportDisplayName') 
 BEGIN 
	DROP INDEX [IX_Reporting_Report_ReportCategoryID_ReportDisplayName] On [dbo].[Reporting_Report];
END
-- 889770227	Reporting_Report	4	IX_Reporting_Report_ReportName	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Reporting_Report_ReportName') 
 BEGIN 
	Create Unique NonClustered Index [IX_Reporting_Report_ReportName] On [dbo].[Reporting_Report] ([ReportName] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Reporting_Report_ReportName') 
 BEGIN 
	DROP INDEX [IX_Reporting_Report_ReportName] On [dbo].[Reporting_Report];
END
-- 1654296953	Media_File	1	IX_Media_File_FilePath	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Media_File_FilePath') 
 BEGIN 
	Create Clustered Index [IX_Media_File_FilePath] On [dbo].[Media_File] ([FilePath] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Media_File_FilePath') 
 BEGIN 
	DROP INDEX [IX_Media_File_FilePath] On [dbo].[Media_File];
END
-- 1654296953	Media_File	4	IX_Media_File_FileLibraryID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Media_File_FileLibraryID') 
 BEGIN 
	Create NonClustered Index [IX_Media_File_FileLibraryID] On [dbo].[Media_File] ([FileLibraryID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Media_File_FileLibraryID') 
 BEGIN 
	DROP INDEX [IX_Media_File_FileLibraryID] On [dbo].[Media_File];
END
-- 1659152956	OM_MVTest	2	IX_OM_MVTest_MVTestSiteID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_OM_MVTest_MVTestSiteID') 
 BEGIN 
	Create NonClustered Index [IX_OM_MVTest_MVTestSiteID] On [dbo].[OM_MVTest] ([MVTestSiteID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_OM_MVTest_MVTestSiteID') 
 BEGIN 
	DROP INDEX [IX_OM_MVTest_MVTestSiteID] On [dbo].[OM_MVTest];
END
-- 1669580986	OM_Account	10	IX_OM_Account_AccountSiteID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_OM_Account_AccountSiteID') 
 BEGIN 
	Create NonClustered Index [IX_OM_Account_AccountSiteID] On [dbo].[OM_Account] ([AccountSiteID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_OM_Account_AccountSiteID') 
 BEGIN 
	DROP INDEX [IX_OM_Account_AccountSiteID] On [dbo].[OM_Account];
END
-- 629577281	Events_Attendee	1	IX_Events_Attendee_AttendeeEmail_AttendeeFirstName_AttendeeLastName	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Events_Attendee_AttendeeEmail_AttendeeFirstName_AttendeeLastName') 
 BEGIN 
	Create Clustered Index [IX_Events_Attendee_AttendeeEmail_AttendeeFirstName_AttendeeLastName] On [dbo].[Events_Attendee] ([AttendeeEmail] Asc,[AttendeeFirstName] Asc,[AttendeeLastName] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Events_Attendee_AttendeeEmail_AttendeeFirstName_AttendeeLastName') 
 BEGIN 
	DROP INDEX [IX_Events_Attendee_AttendeeEmail_AttendeeFirstName_AttendeeLastName] On [dbo].[Events_Attendee];
END
-- 1085246921	CMS_WorkflowScope	5	IX_CMS_WorkflowScope_ScopeSiteID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_WorkflowScope_ScopeSiteID') 
 BEGIN 
	Create NonClustered Index [IX_CMS_WorkflowScope_ScopeSiteID] On [dbo].[CMS_WorkflowScope] ([ScopeSiteID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_WorkflowScope_ScopeSiteID') 
 BEGIN 
	DROP INDEX [IX_CMS_WorkflowScope_ScopeSiteID] On [dbo].[CMS_WorkflowScope];
END
-- 125243501	OM_AccountContact	4	IX_OM_AccountContact_ContactID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_OM_AccountContact_ContactID') 
 BEGIN 
	Create NonClustered Index [IX_OM_AccountContact_ContactID] On [dbo].[OM_AccountContact] ([ContactID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 100, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_OM_AccountContact_ContactID') 
 BEGIN 
	DROP INDEX [IX_OM_AccountContact_ContactID] On [dbo].[OM_AccountContact];
END
-- 146099561	CMS_ResourceTranslation	3	IX_CMS_ResourceTranslation_TranslationUICultureID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_ResourceTranslation_TranslationUICultureID') 
 BEGIN 
	Create NonClustered Index [IX_CMS_ResourceTranslation_TranslationUICultureID] On [dbo].[CMS_ResourceTranslation] ([TranslationUICultureID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_ResourceTranslation_TranslationUICultureID') 
 BEGIN 
	DROP INDEX [IX_CMS_ResourceTranslation_TranslationUICultureID] On [dbo].[CMS_ResourceTranslation];
END
-- 1854629650	OM_Score	2	IX_OM_Score_ScoreSiteID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_OM_Score_ScoreSiteID') 
 BEGIN 
	Create NonClustered Index [IX_OM_Score_ScoreSiteID] On [dbo].[OM_Score] ([ScoreSiteID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_OM_Score_ScoreSiteID') 
 BEGIN 
	DROP INDEX [IX_OM_Score_ScoreSiteID] On [dbo].[OM_Score];
END
-- 1862297694	CMS_OpenIDUser	3	IX_CMS_OpenIDUser_UserID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_OpenIDUser_UserID') 
 BEGIN 
	Create NonClustered Index [IX_CMS_OpenIDUser_UserID] On [dbo].[CMS_OpenIDUser] ([UserID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_OpenIDUser_UserID') 
 BEGIN 
	DROP INDEX [IX_CMS_OpenIDUser_UserID] On [dbo].[CMS_OpenIDUser];
END
-- 91863394	COM_Supplier	1	IX_COM_Supplier_SupplierDisplayName_SupplierEnabled	
IF NOT Exists (Select name from sys.indexes where name = 'IX_COM_Supplier_SupplierDisplayName_SupplierEnabled') 
 BEGIN 
	Create Clustered Index [IX_COM_Supplier_SupplierDisplayName_SupplierEnabled] On [dbo].[COM_Supplier] ([SupplierDisplayName] Asc,[SupplierEnabled] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_COM_Supplier_SupplierDisplayName_SupplierEnabled') 
 BEGIN 
	DROP INDEX [IX_COM_Supplier_SupplierDisplayName_SupplierEnabled] On [dbo].[COM_Supplier];
END
-- 70291310	View_CMS_Tree_Joined_Regular	120	PI_View_CMS_Tree_Joined_Regular_NodeGUID	
IF NOT Exists (Select name from sys.indexes where name = 'PI_View_CMS_Tree_Joined_Regular_NodeGUID') 
 BEGIN 
	Create NonClustered Index [PI_View_CMS_Tree_Joined_Regular_NodeGUID] On [dbo].[View_CMS_Tree_Joined_Regular] ([NodeGUID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 100, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'PI_View_CMS_Tree_Joined_Regular_NodeGUID') 
 BEGIN 
	DROP INDEX [PI_View_CMS_Tree_Joined_Regular_NodeGUID] On [dbo].[View_CMS_Tree_Joined_Regular];
END
-- 70291310	View_CMS_Tree_Joined_Regular	123	PI_CMSTR_ClassCulture	
IF NOT Exists (Select name from sys.indexes where name = 'PI_CMSTR_ClassCulture') 
 BEGIN 
	Create NonClustered Index [PI_CMSTR_ClassCulture] On [dbo].[View_CMS_Tree_Joined_Regular] ([ClassName] Asc,[DocumentCulture] Asc) Include ([NodeGUID],[DocumentForeignKeyValue])  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 100, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'PI_CMSTR_ClassCulture') 
 BEGIN 
	DROP INDEX [PI_CMSTR_ClassCulture] On [dbo].[View_CMS_Tree_Joined_Regular];
END
-- 791673868	Community_Group	5	IX_Community_Group_GroupApprovedByUserID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Community_Group_GroupApprovedByUserID') 
 BEGIN 
	Create NonClustered Index [IX_Community_Group_GroupApprovedByUserID] On [dbo].[Community_Group] ([GroupApprovedByUserID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Community_Group_GroupApprovedByUserID') 
 BEGIN 
	DROP INDEX [IX_Community_Group_GroupApprovedByUserID] On [dbo].[Community_Group];
END
-- 793769885	Reporting_ReportSubscription	3	IX_Reporting_ReportSubscription_ReportSubscriptionGraphID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Reporting_ReportSubscription_ReportSubscriptionGraphID') 
 BEGIN 
	Create NonClustered Index [IX_Reporting_ReportSubscription_ReportSubscriptionGraphID] On [dbo].[Reporting_ReportSubscription] ([ReportSubscriptionGraphID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Reporting_ReportSubscription_ReportSubscriptionGraphID') 
 BEGIN 
	DROP INDEX [IX_Reporting_ReportSubscription_ReportSubscriptionGraphID] On [dbo].[Reporting_ReportSubscription];
END
-- 2103678542	CMS_User	4	IX_CMS_User_Email	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_User_Email') 
 BEGIN 
	Create NonClustered Index [IX_CMS_User_Email] On [dbo].[CMS_User] ([Email] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_User_Email') 
 BEGIN 
	DROP INDEX [IX_CMS_User_Email] On [dbo].[CMS_User];
END
-- 2103678542	CMS_User	7	IX_CMS_User_UserIsGlobalAdministrator	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_User_UserIsGlobalAdministrator') 
 BEGIN 
	Create NonClustered Index [IX_CMS_User_UserIsGlobalAdministrator] On [dbo].[CMS_User] ([UserIsGlobalAdministrator] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_User_UserIsGlobalAdministrator') 
 BEGIN 
	DROP INDEX [IX_CMS_User_UserIsGlobalAdministrator] On [dbo].[CMS_User];
END
-- 2103678542	CMS_User	21	PI_CMS_User_UserIsGlobalAdministrator	
IF NOT Exists (Select name from sys.indexes where name = 'PI_CMS_User_UserIsGlobalAdministrator') 
 BEGIN 
	Create NonClustered Index [PI_CMS_User_UserIsGlobalAdministrator] On [dbo].[CMS_User] ([UserIsGlobalAdministrator] Asc,[UserID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 100, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'PI_CMS_User_UserIsGlobalAdministrator') 
 BEGIN 
	DROP INDEX [PI_CMS_User_UserIsGlobalAdministrator] On [dbo].[CMS_User];
END
-- 2105058535	filetable_updates_2105058535	1	FFtUpdateIdx	
IF NOT Exists (Select name from sys.indexes where name = 'FFtUpdateIdx') 
 BEGIN 
	Create Unique Clustered Index [FFtUpdateIdx] On [sys].[filetable_updates_2105058535] ([table_id] Asc,[oplsn_fseqno] Asc,[oplsn_bOffset] Asc,[oplsn_slotid] Asc,[item_guid] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 100, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'FFtUpdateIdx') 
 BEGIN 
	DROP INDEX [FFtUpdateIdx] On [sys].[filetable_updates_2105058535];
END
-- 2106138944	HFit_SSISLoadDetail	2	IX_HFit_SSISLoadDetail_1	
IF NOT Exists (Select name from sys.indexes where name = 'IX_HFit_SSISLoadDetail_1') 
 BEGIN 
	Create NonClustered Index [IX_HFit_SSISLoadDetail_1] On [dbo].[HFit_SSISLoadDetail] ([SSISLoadID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_HFit_SSISLoadDetail_1') 
 BEGIN 
	DROP INDEX [IX_HFit_SSISLoadDetail_1] On [dbo].[HFit_SSISLoadDetail];
END
-- 1143675122	Board_Message	5	IX_Board_Message_MessageApprovedByUserID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Board_Message_MessageApprovedByUserID') 
 BEGIN 
	Create NonClustered Index [IX_Board_Message_MessageApprovedByUserID] On [dbo].[Board_Message] ([MessageApprovedByUserID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Board_Message_MessageApprovedByUserID') 
 BEGIN 
	DROP INDEX [IX_Board_Message_MessageApprovedByUserID] On [dbo].[Board_Message];
END
-- 1170819233	CMS_AlternativeForm	2	IX_CMS_AlternativeForm_FormClassID_FormName	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_AlternativeForm_FormClassID_FormName') 
 BEGIN 
	Create NonClustered Index [IX_CMS_AlternativeForm_FormClassID_FormName] On [dbo].[CMS_AlternativeForm] ([FormClassID] Asc,[FormName] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_AlternativeForm_FormClassID_FormName') 
 BEGIN 
	DROP INDEX [IX_CMS_AlternativeForm_FormClassID_FormName] On [dbo].[CMS_AlternativeForm];
END
-- 690101499	CMS_ObjectRelationship	2	IX_CMS_ObjectRelationship_RelationshipLeftObjectType_RelationshipLeftObjectID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_ObjectRelationship_RelationshipLeftObjectType_RelationshipLeftObjectID') 
 BEGIN 
	Create NonClustered Index [IX_CMS_ObjectRelationship_RelationshipLeftObjectType_RelationshipLeftObjectID] On [dbo].[CMS_ObjectRelationship] ([RelationshipLeftObjectType] Asc,[RelationshipLeftObjectID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 100, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_ObjectRelationship_RelationshipLeftObjectType_RelationshipLeftObjectID') 
 BEGIN 
	DROP INDEX [IX_CMS_ObjectRelationship_RelationshipLeftObjectType_RelationshipLeftObjectID] On [dbo].[CMS_ObjectRelationship];
END
-- 1358627883	OM_PageVisit	2	IX_OM_PageVisit_PageVisitActivityID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_OM_PageVisit_PageVisitActivityID') 
 BEGIN 
	Create NonClustered Index [IX_OM_PageVisit_PageVisitActivityID] On [dbo].[OM_PageVisit] ([PageVisitActivityID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_OM_PageVisit_PageVisitActivityID') 
 BEGIN 
	DROP INDEX [IX_OM_PageVisit_PageVisitActivityID] On [dbo].[OM_PageVisit];
END
-- 1378103950	CMS_WebTemplate	1	IX_CMS_WebTemplate_WebTemplateOrder	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_WebTemplate_WebTemplateOrder') 
 BEGIN 
	Create Clustered Index [IX_CMS_WebTemplate_WebTemplateOrder] On [dbo].[CMS_WebTemplate] ([WebTemplateOrder] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_WebTemplate_WebTemplateOrder') 
 BEGIN 
	DROP INDEX [IX_CMS_WebTemplate_WebTemplateOrder] On [dbo].[CMS_WebTemplate];
END
-- 1489440380	HFit_TrackerHighSodiumFoods	5	idx_HFit_TrackerHighSodiumFoods_CreateDate	
IF NOT Exists (Select name from sys.indexes where name = 'idx_HFit_TrackerHighSodiumFoods_CreateDate') 
 BEGIN 
	Create NonClustered Index [idx_HFit_TrackerHighSodiumFoods_CreateDate] On [dbo].[HFit_TrackerHighSodiumFoods] ([ItemCreatedWhen] Asc,[ItemModifiedWhen] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 100, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'idx_HFit_TrackerHighSodiumFoods_CreateDate') 
 BEGIN 
	DROP INDEX [idx_HFit_TrackerHighSodiumFoods_CreateDate] On [dbo].[HFit_TrackerHighSodiumFoods];
END
-- 1531152500	Forums_Forum	3	IX_Forums_Forum_ForumSiteID_ForumName	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Forums_Forum_ForumSiteID_ForumName') 
 BEGIN 
	Create NonClustered Index [IX_Forums_Forum_ForumSiteID_ForumName] On [dbo].[Forums_Forum] ([ForumSiteID] Asc,[ForumName] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Forums_Forum_ForumSiteID_ForumName') 
 BEGIN 
	DROP INDEX [IX_Forums_Forum_ForumSiteID_ForumName] On [dbo].[Forums_Forum];
END
-- 1826105546	CMS_Attachment	1	IX_CMS_Attachment_AttachmentDocumentID_AttachmentIsUnsorted_AttachmentName_AttachmentOrder	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_Attachment_AttachmentDocumentID_AttachmentIsUnsorted_AttachmentName_AttachmentOrder') 
 BEGIN 
	Create Clustered Index [IX_CMS_Attachment_AttachmentDocumentID_AttachmentIsUnsorted_AttachmentName_AttachmentOrder] On [dbo].[CMS_Attachment] ([AttachmentDocumentID] Asc,[AttachmentName] Asc,[AttachmentIsUnsorted] Asc,[AttachmentOrder] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_Attachment_AttachmentDocumentID_AttachmentIsUnsorted_AttachmentName_AttachmentOrder') 
 BEGIN 
	DROP INDEX [IX_CMS_Attachment_AttachmentDocumentID_AttachmentIsUnsorted_AttachmentName_AttachmentOrder] On [dbo].[CMS_Attachment];
END
-- 1826105546	CMS_Attachment	4	IX_CMS_Attachment_AttachmentIsUnsorted_AttachmentGroupGUID_AttachmentFormGUID_AttachmentOrder	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_Attachment_AttachmentIsUnsorted_AttachmentGroupGUID_AttachmentFormGUID_AttachmentOrder') 
 BEGIN 
	Create NonClustered Index [IX_CMS_Attachment_AttachmentIsUnsorted_AttachmentGroupGUID_AttachmentFormGUID_AttachmentOrder] On [dbo].[CMS_Attachment] ([AttachmentIsUnsorted] Asc,[AttachmentGroupGUID] Asc,[AttachmentFormGUID] Asc,[AttachmentOrder] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_Attachment_AttachmentIsUnsorted_AttachmentGroupGUID_AttachmentFormGUID_AttachmentOrder') 
 BEGIN 
	DROP INDEX [IX_CMS_Attachment_AttachmentIsUnsorted_AttachmentGroupGUID_AttachmentFormGUID_AttachmentOrder] On [dbo].[CMS_Attachment];
END
-- 103671417	CMS_Session	3	IX_CMS_Session_SessionUserID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_Session_SessionUserID') 
 BEGIN 
	Create NonClustered Index [IX_CMS_Session_SessionUserID] On [dbo].[CMS_Session] ([SessionUserID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_Session_SessionUserID') 
 BEGIN 
	DROP INDEX [IX_CMS_Session_SessionUserID] On [dbo].[CMS_Session];
END
-- 107147427	CMS_TagGroup	3	IX_CMS_TagGroup_TagGroupSiteID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_TagGroup_TagGroupSiteID') 
 BEGIN 
	Create NonClustered Index [IX_CMS_TagGroup_TagGroupSiteID] On [dbo].[CMS_TagGroup] ([TagGroupSiteID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_TagGroup_TagGroupSiteID') 
 BEGIN 
	DROP INDEX [IX_CMS_TagGroup_TagGroupSiteID] On [dbo].[CMS_TagGroup];
END
-- 838294046	Blog_Comment	6	IX_Blog_Comment_CommentIsSpam_CommentIsApproved_CommentIsTrackback	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Blog_Comment_CommentIsSpam_CommentIsApproved_CommentIsTrackback') 
 BEGIN 
	Create NonClustered Index [IX_Blog_Comment_CommentIsSpam_CommentIsApproved_CommentIsTrackback] On [dbo].[Blog_Comment] ([CommentIsSpam] Asc,[CommentApproved] Asc,[CommentIsTrackBack] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Blog_Comment_CommentIsSpam_CommentIsApproved_CommentIsTrackback') 
 BEGIN 
	DROP INDEX [IX_Blog_Comment_CommentIsSpam_CommentIsApproved_CommentIsTrackback] On [dbo].[Blog_Comment];
END
-- 2034822311	HFit_HealthAssesmentUserRiskArea	8	idx_UserRiskAreaCodeName	
IF NOT Exists (Select name from sys.indexes where name = 'idx_UserRiskAreaCodeName') 
 BEGIN 
	Create NonClustered Index [idx_UserRiskAreaCodeName] On [dbo].[HFit_HealthAssesmentUserRiskArea] ([CodeName] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'idx_UserRiskAreaCodeName') 
 BEGIN 
	DROP INDEX [idx_UserRiskAreaCodeName] On [dbo].[HFit_HealthAssesmentUserRiskArea];
END
-- 2034822311	HFit_HealthAssesmentUserRiskArea	11	HFit_HealthAssesmentUserRiskArea_HARiskCategoryItemID_PI	
IF NOT Exists (Select name from sys.indexes where name = 'HFit_HealthAssesmentUserRiskArea_HARiskCategoryItemID_PI') 
 BEGIN 
	Create NonClustered Index [HFit_HealthAssesmentUserRiskArea_HARiskCategoryItemID_PI] On [dbo].[HFit_HealthAssesmentUserRiskArea] ([HARiskCategoryItemID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 100, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'HFit_HealthAssesmentUserRiskArea_HARiskCategoryItemID_PI') 
 BEGIN 
	DROP INDEX [HFit_HealthAssesmentUserRiskArea_HARiskCategoryItemID_PI] On [dbo].[HFit_HealthAssesmentUserRiskArea];
END
-- 1927677915	COM_SKU	5	IX_COM_SKU_SKUDepartmentID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_COM_SKU_SKUDepartmentID') 
 BEGIN 
	Create NonClustered Index [IX_COM_SKU_SKUDepartmentID] On [dbo].[COM_SKU] ([SKUDepartmentID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_COM_SKU_SKUDepartmentID') 
 BEGIN 
	DROP INDEX [IX_COM_SKU_SKUDepartmentID] On [dbo].[COM_SKU];
END
-- 798625888	CMS_TranslationSubmission	2	IX_CMS_TranslationSubmission	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_TranslationSubmission') 
 BEGIN 
	Create NonClustered Index [IX_CMS_TranslationSubmission] On [dbo].[CMS_TranslationSubmission] ([SubmissionID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_TranslationSubmission') 
 BEGIN 
	DROP INDEX [IX_CMS_TranslationSubmission] On [dbo].[CMS_TranslationSubmission];
END
-- 337436276	HFit_TrackerRegularMeals	5	idx_HFit_TrackerRegularMeals_CreateDate	
IF NOT Exists (Select name from sys.indexes where name = 'idx_HFit_TrackerRegularMeals_CreateDate') 
 BEGIN 
	Create NonClustered Index [idx_HFit_TrackerRegularMeals_CreateDate] On [dbo].[HFit_TrackerRegularMeals] ([ItemCreatedWhen] Asc,[ItemModifiedWhen] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'idx_HFit_TrackerRegularMeals_CreateDate') 
 BEGIN 
	DROP INDEX [idx_HFit_TrackerRegularMeals_CreateDate] On [dbo].[HFit_TrackerRegularMeals];
END
-- 31339176	HFit_HealthAssesmentUserQuestionGroupResults	6	IX_HAUQGroupResults_ItemID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_HAUQGroupResults_ItemID') 
 BEGIN 
	Create NonClustered Index [IX_HAUQGroupResults_ItemID] On [dbo].[HFit_HealthAssesmentUserQuestionGroupResults] ([HARiskAreaItemID] Asc) Include ([PointResults],[FormulaResult],[CodeName])  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_HAUQGroupResults_ItemID') 
 BEGIN 
	DROP INDEX [IX_HAUQGroupResults_ItemID] On [dbo].[HFit_HealthAssesmentUserQuestionGroupResults];
END
-- 33747523	change_tables	3	source_object_id_idx	
IF NOT Exists (Select name from sys.indexes where name = 'source_object_id_idx') 
 BEGIN 
	Create NonClustered Index [source_object_id_idx] On [cdc].[change_tables] ([source_object_id] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 100, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'source_object_id_idx') 
 BEGIN 
	DROP INDEX [source_object_id_idx] On [cdc].[change_tables];
END
-- 1129771082	CMS_Email	1	IX_CMS_Email_EmailPriority_EmailStatus	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_Email_EmailPriority_EmailStatus') 
 BEGIN 
	Create Clustered Index [IX_CMS_Email_EmailPriority_EmailStatus] On [dbo].[CMS_Email] ([EmailPriority] Asc,[EmailStatus] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_Email_EmailPriority_EmailStatus') 
 BEGIN 
	DROP INDEX [IX_CMS_Email_EmailPriority_EmailStatus] On [dbo].[CMS_Email];
END
-- 304720138	CMS_Permission	5	IX_CMS_Permission_ResourceID_PermissionName	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_Permission_ResourceID_PermissionName') 
 BEGIN 
	Create NonClustered Index [IX_CMS_Permission_ResourceID_PermissionName] On [dbo].[CMS_Permission] ([ResourceID] Asc,[PermissionName] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_Permission_ResourceID_PermissionName') 
 BEGIN 
	DROP INDEX [IX_CMS_Permission_ResourceID_PermissionName] On [dbo].[CMS_Permission];
END
-- 1380915991	HFit_TrackerRestingHeartRate	7	idx_HFit_TrackerRestingHeartRate_CreateDate	
IF NOT Exists (Select name from sys.indexes where name = 'idx_HFit_TrackerRestingHeartRate_CreateDate') 
 BEGIN 
	Create NonClustered Index [idx_HFit_TrackerRestingHeartRate_CreateDate] On [dbo].[HFit_TrackerRestingHeartRate] ([ItemCreatedWhen] Asc,[ItemModifiedWhen] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'idx_HFit_TrackerRestingHeartRate_CreateDate') 
 BEGIN 
	DROP INDEX [idx_HFit_TrackerRestingHeartRate_CreateDate] On [dbo].[HFit_TrackerRestingHeartRate];
END
-- 313768175	CMS_PageTemplateScope	3	IX_CMS_PageTemplateScope_PageTemplateScopeLevels	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_PageTemplateScope_PageTemplateScopeLevels') 
 BEGIN 
	Create NonClustered Index [IX_CMS_PageTemplateScope_PageTemplateScopeLevels] On [dbo].[CMS_PageTemplateScope] ([PageTemplateScopeLevels] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_PageTemplateScope_PageTemplateScopeLevels') 
 BEGIN 
	DROP INDEX [IX_CMS_PageTemplateScope_PageTemplateScopeLevels] On [dbo].[CMS_PageTemplateScope];
END
-- 313768175	CMS_PageTemplateScope	6	IX_CMS_PageTemplateScope_PageTemplateScopeTemplateID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_PageTemplateScope_PageTemplateScopeTemplateID') 
 BEGIN 
	Create NonClustered Index [IX_CMS_PageTemplateScope_PageTemplateScopeTemplateID] On [dbo].[CMS_PageTemplateScope] ([PageTemplateScopeTemplateID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_PageTemplateScope_PageTemplateScopeTemplateID') 
 BEGIN 
	DROP INDEX [IX_CMS_PageTemplateScope_PageTemplateScopeTemplateID] On [dbo].[CMS_PageTemplateScope];
END
-- 320368556	HFit_PPTEligibility	4	HFit_PPTEligiblity_idx_01	
IF NOT Exists (Select name from sys.indexes where name = 'HFit_PPTEligiblity_idx_01') 
 BEGIN 
	Create NonClustered Index [HFit_PPTEligiblity_idx_01] On [dbo].[HFit_PPTEligibility] ([TeamName] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'HFit_PPTEligiblity_idx_01') 
 BEGIN 
	DROP INDEX [HFit_PPTEligiblity_idx_01] On [dbo].[HFit_PPTEligibility];
END
-- 320368556	HFit_PPTEligibility	10	HFit_PPTEligibililty_idx_04	
IF NOT Exists (Select name from sys.indexes where name = 'HFit_PPTEligibililty_idx_04') 
 BEGIN 
	Create NonClustered Index [HFit_PPTEligibililty_idx_04] On [dbo].[HFit_PPTEligibility] ([UserID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'HFit_PPTEligibililty_idx_04') 
 BEGIN 
	DROP INDEX [HFit_PPTEligibililty_idx_04] On [dbo].[HFit_PPTEligibility];
END
-- 1066486878	CMS_CssStylesheet	1	IX_CMS_CssStylesheet_StylesheetDisplayName	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_CssStylesheet_StylesheetDisplayName') 
 BEGIN 
	Create Clustered Index [IX_CMS_CssStylesheet_StylesheetDisplayName] On [dbo].[CMS_CssStylesheet] ([StylesheetDisplayName] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_CssStylesheet_StylesheetDisplayName') 
 BEGIN 
	DROP INDEX [IX_CMS_CssStylesheet_StylesheetDisplayName] On [dbo].[CMS_CssStylesheet];
END
-- 1630628852	Notification_TemplateText	2	IX_Notification_TemplateText_TemplateID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Notification_TemplateText_TemplateID') 
 BEGIN 
	Create NonClustered Index [IX_Notification_TemplateText_TemplateID] On [dbo].[Notification_TemplateText] ([TemplateID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Notification_TemplateText_TemplateID') 
 BEGIN 
	DROP INDEX [IX_Notification_TemplateText_TemplateID] On [dbo].[Notification_TemplateText];
END
-- 1639676889	CMS_Site	1	IX_CMS_Site_SiteDisplayName	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_Site_SiteDisplayName') 
 BEGIN 
	Create Clustered Index [IX_CMS_Site_SiteDisplayName] On [dbo].[CMS_Site] ([SiteDisplayName] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_Site_SiteDisplayName') 
 BEGIN 
	DROP INDEX [IX_CMS_Site_SiteDisplayName] On [dbo].[CMS_Site];
END
-- 1639676889	CMS_Site	4	IX_CMS_Site_SiteDomainName_SiteStatus	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_Site_SiteDomainName_SiteStatus') 
 BEGIN 
	Create NonClustered Index [IX_CMS_Site_SiteDomainName_SiteStatus] On [dbo].[CMS_Site] ([SiteDomainName] Asc,[SiteStatus] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_Site_SiteDomainName_SiteStatus') 
 BEGIN 
	DROP INDEX [IX_CMS_Site_SiteDomainName_SiteStatus] On [dbo].[CMS_Site];
END
-- 1902838041	HFit_TrackerTests	12	idx_HFit_TrackerTests_CreateDate	
IF NOT Exists (Select name from sys.indexes where name = 'idx_HFit_TrackerTests_CreateDate') 
 BEGIN 
	Create NonClustered Index [idx_HFit_TrackerTests_CreateDate] On [dbo].[HFit_TrackerTests] ([ItemCreatedWhen] Asc,[ItemModifiedWhen] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 100, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'idx_HFit_TrackerTests_CreateDate') 
 BEGIN 
	DROP INDEX [idx_HFit_TrackerTests_CreateDate] On [dbo].[HFit_TrackerTests];
END
-- 1735169427	HFit_configGroupToFeature	9	IDX_FeaturesToGroups_ContactGroupMembershipID	
IF NOT Exists (Select name from sys.indexes where name = 'IDX_FeaturesToGroups_ContactGroupMembershipID') 
 BEGIN 
	Create NonClustered Index [IDX_FeaturesToGroups_ContactGroupMembershipID] On [dbo].[HFit_configGroupToFeature] ([ContactGroupMembershipID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IDX_FeaturesToGroups_ContactGroupMembershipID') 
 BEGIN 
	DROP INDEX [IDX_FeaturesToGroups_ContactGroupMembershipID] On [dbo].[HFit_configGroupToFeature];
END
-- 1735677231	CMS_ScheduledTask	1	IX_CMS_ScheduledTask_TaskNextRunTime_TaskEnabled_TaskServerName	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_ScheduledTask_TaskNextRunTime_TaskEnabled_TaskServerName') 
 BEGIN 
	Create Clustered Index [IX_CMS_ScheduledTask_TaskNextRunTime_TaskEnabled_TaskServerName] On [dbo].[CMS_ScheduledTask] ([TaskNextRunTime] Asc,[TaskEnabled] Asc,[TaskServerName] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_ScheduledTask_TaskNextRunTime_TaskEnabled_TaskServerName') 
 BEGIN 
	DROP INDEX [IX_CMS_ScheduledTask_TaskNextRunTime_TaskEnabled_TaskServerName] On [dbo].[CMS_ScheduledTask];
END
-- 212911830	HFit_TrackerBloodPressure	14	idx_HFit_TrackerBloodPressure_UserIDEventDate	
IF NOT Exists (Select name from sys.indexes where name = 'idx_HFit_TrackerBloodPressure_UserIDEventDate') 
 BEGIN 
	Create NonClustered Index [idx_HFit_TrackerBloodPressure_UserIDEventDate] On [dbo].[HFit_TrackerBloodPressure] ([EventDate] Asc,[UserID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'idx_HFit_TrackerBloodPressure_UserIDEventDate') 
 BEGIN 
	DROP INDEX [idx_HFit_TrackerBloodPressure_UserIDEventDate] On [dbo].[HFit_TrackerBloodPressure];
END
-- 215671816	OM_Contact	7	IX_OM_Contact_ContactMergedWithContactID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_OM_Contact_ContactMergedWithContactID') 
 BEGIN 
	Create NonClustered Index [IX_OM_Contact_ContactMergedWithContactID] On [dbo].[OM_Contact] ([ContactMergedWithContactID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 100, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_OM_Contact_ContactMergedWithContactID') 
 BEGIN 
	DROP INDEX [IX_OM_Contact_ContactMergedWithContactID] On [dbo].[OM_Contact];
END
-- 215671816	OM_Contact	10	IX_OM_Contact_ContactGlobalContactID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_OM_Contact_ContactGlobalContactID') 
 BEGIN 
	Create NonClustered Index [IX_OM_Contact_ContactGlobalContactID] On [dbo].[OM_Contact] ([ContactGlobalContactID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 100, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_OM_Contact_ContactGlobalContactID') 
 BEGIN 
	DROP INDEX [IX_OM_Contact_ContactGlobalContactID] On [dbo].[OM_Contact];
END
-- 1966630049	Newsletter_EmailTemplate	3	IX_Newsletter_EmailTemplate_TemplateSiteID_TemplateName	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Newsletter_EmailTemplate_TemplateSiteID_TemplateName') 
 BEGIN 
	Create Unique NonClustered Index [IX_Newsletter_EmailTemplate_TemplateSiteID_TemplateName] On [dbo].[Newsletter_EmailTemplate] ([TemplateSiteID] Asc,[TemplateName] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Newsletter_EmailTemplate_TemplateSiteID_TemplateName') 
 BEGIN 
	DROP INDEX [IX_Newsletter_EmailTemplate_TemplateSiteID_TemplateName] On [dbo].[Newsletter_EmailTemplate];
END
-- 1211151360	Analytics_Statistics	1	IX_Analytics_Statistics_StatisticsCode_StatisticsSiteID_StatisticsObjectID_StatisticsObjectCulture	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Analytics_Statistics_StatisticsCode_StatisticsSiteID_StatisticsObjectID_StatisticsObjectCulture') 
 BEGIN 
	Create Clustered Index [IX_Analytics_Statistics_StatisticsCode_StatisticsSiteID_StatisticsObjectID_StatisticsObjectCulture] On [dbo].[Analytics_Statistics] ([StatisticsCode] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Analytics_Statistics_StatisticsCode_StatisticsSiteID_StatisticsObjectID_StatisticsObjectCulture') 
 BEGIN 
	DROP INDEX [IX_Analytics_Statistics_StatisticsCode_StatisticsSiteID_StatisticsObjectID_StatisticsObjectCulture] On [dbo].[Analytics_Statistics];
END
-- 869578136	Community_Invitation	2	IX_Community_Invitation_InvitedUserID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Community_Invitation_InvitedUserID') 
 BEGIN 
	Create NonClustered Index [IX_Community_Invitation_InvitedUserID] On [dbo].[Community_Invitation] ([InvitedUserID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Community_Invitation_InvitedUserID') 
 BEGIN 
	DROP INDEX [IX_Community_Invitation_InvitedUserID] On [dbo].[Community_Invitation];
END
-- 722101613	CMS_Resource	3	IX_CMS_Resource_ResourceName	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_Resource_ResourceName') 
 BEGIN 
	Create NonClustered Index [IX_CMS_Resource_ResourceName] On [dbo].[CMS_Resource] ([ResourceName] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_Resource_ResourceName') 
 BEGIN 
	DROP INDEX [IX_CMS_Resource_ResourceName] On [dbo].[CMS_Resource];
END
-- 731149650	Notification_Gateway	1	IX_Notification_Gateway_GatewayDisplayName	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Notification_Gateway_GatewayDisplayName') 
 BEGIN 
	Create Clustered Index [IX_Notification_Gateway_GatewayDisplayName] On [dbo].[Notification_Gateway] ([GatewayDisplayName] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Notification_Gateway_GatewayDisplayName') 
 BEGIN 
	DROP INDEX [IX_Notification_Gateway_GatewayDisplayName] On [dbo].[Notification_Gateway];
END
-- 734625660	Export_History	1	IX_Export_History_ExportDateTime	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Export_History_ExportDateTime') 
 BEGIN 
	Create Clustered Index [IX_Export_History_ExportDateTime] On [dbo].[Export_History] ([ExportDateTime] Desc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Export_History_ExportDateTime') 
 BEGIN 
	DROP INDEX [IX_Export_History_ExportDateTime] On [dbo].[Export_History];
END
-- 734625660	Export_History	4	IX_Export_History_ExportUserID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Export_History_ExportUserID') 
 BEGIN 
	Create NonClustered Index [IX_Export_History_ExportUserID] On [dbo].[Export_History] ([ExportUserID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Export_History_ExportUserID') 
 BEGIN 
	DROP INDEX [IX_Export_History_ExportUserID] On [dbo].[Export_History];
END
-- 741577680	Polls_Poll	1	IX_Polls_Poll_PollSiteID_PollDisplayName	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Polls_Poll_PollSiteID_PollDisplayName') 
 BEGIN 
	Create Clustered Index [IX_Polls_Poll_PollSiteID_PollDisplayName] On [dbo].[Polls_Poll] ([PollSiteID] Asc,[PollDisplayName] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Polls_Poll_PollSiteID_PollDisplayName') 
 BEGIN 
	DROP INDEX [IX_Polls_Poll_PollSiteID_PollDisplayName] On [dbo].[Polls_Poll];
END
-- 741577680	Polls_Poll	4	IX_Polls_Poll_PollGroupID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Polls_Poll_PollGroupID') 
 BEGIN 
	Create NonClustered Index [IX_Polls_Poll_PollGroupID] On [dbo].[Polls_Poll] ([PollGroupID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Polls_Poll_PollGroupID') 
 BEGIN 
	DROP INDEX [IX_Polls_Poll_PollGroupID] On [dbo].[Polls_Poll];
END
-- 350624292	OM_Activity	4	IX_OM_Activity_ActivityCreated	
IF NOT Exists (Select name from sys.indexes where name = 'IX_OM_Activity_ActivityCreated') 
 BEGIN 
	Create NonClustered Index [IX_OM_Activity_ActivityCreated] On [dbo].[OM_Activity] ([ActivityCreated] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 100, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_OM_Activity_ActivityCreated') 
 BEGIN 
	DROP INDEX [IX_OM_Activity_ActivityCreated] On [dbo].[OM_Activity];
END
-- 350624292	OM_Activity	7	IX_OM_Activity_ActivitySiteID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_OM_Activity_ActivitySiteID') 
 BEGIN 
	Create NonClustered Index [IX_OM_Activity_ActivitySiteID] On [dbo].[OM_Activity] ([ActivitySiteID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 100, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_OM_Activity_ActivitySiteID') 
 BEGIN 
	DROP INDEX [IX_OM_Activity_ActivitySiteID] On [dbo].[OM_Activity];
END
-- 431392656	HFit_TrackerStrength	6	idx_HFit_TrackerStrength_CreateDate	
IF NOT Exists (Select name from sys.indexes where name = 'idx_HFit_TrackerStrength_CreateDate') 
 BEGIN 
	Create NonClustered Index [idx_HFit_TrackerStrength_CreateDate] On [dbo].[HFit_TrackerStrength] ([ItemCreatedWhen] Asc,[ItemModifiedWhen] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'idx_HFit_TrackerStrength_CreateDate') 
 BEGIN 
	DROP INDEX [idx_HFit_TrackerStrength_CreateDate] On [dbo].[HFit_TrackerStrength];
END
-- 702625546	Messaging_Message	11	IX_Messaging_Message_MessageRecipientUserID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Messaging_Message_MessageRecipientUserID') 
 BEGIN 
	Create NonClustered Index [IX_Messaging_Message_MessageRecipientUserID] On [dbo].[Messaging_Message] ([MessageRecipientUserID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Messaging_Message_MessageRecipientUserID') 
 BEGIN 
	DROP INDEX [IX_Messaging_Message_MessageRecipientUserID] On [dbo].[Messaging_Message];
END
-- 713769600	Community_Friend	2	IX_Community_Friend_FriendRequestedUserID_FriendStatus	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Community_Friend_FriendRequestedUserID_FriendStatus') 
 BEGIN 
	Create NonClustered Index [IX_Community_Friend_FriendRequestedUserID_FriendStatus] On [dbo].[Community_Friend] ([FriendRequestedUserID] Asc,[FriendStatus] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Community_Friend_FriendRequestedUserID_FriendStatus') 
 BEGIN 
	DROP INDEX [IX_Community_Friend_FriendRequestedUserID_FriendStatus] On [dbo].[Community_Friend];
END
-- 713769600	Community_Friend	5	IX_Community_Friend_FriendApprovedBy	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Community_Friend_FriendApprovedBy') 
 BEGIN 
	Create NonClustered Index [IX_Community_Friend_FriendApprovedBy] On [dbo].[Community_Friend] ([FriendApprovedBy] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Community_Friend_FriendApprovedBy') 
 BEGIN 
	DROP INDEX [IX_Community_Friend_FriendApprovedBy] On [dbo].[Community_Friend];
END
-- 2052202361	CMS_PageTemplate	5	IX_CMS_PageTemplate_PageTemplateLayoutID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_PageTemplate_PageTemplateLayoutID') 
 BEGIN 
	Create NonClustered Index [IX_CMS_PageTemplate_PageTemplateLayoutID] On [dbo].[CMS_PageTemplate] ([PageTemplateLayoutID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_PageTemplate_PageTemplateLayoutID') 
 BEGIN 
	DROP INDEX [IX_CMS_PageTemplate_PageTemplateLayoutID] On [dbo].[CMS_PageTemplate];
END
-- 2053582354	COM_Currency	3	IX_COM_Currency_CurrencyEnabled_CurrencyIsMain	
IF NOT Exists (Select name from sys.indexes where name = 'IX_COM_Currency_CurrencyEnabled_CurrencyIsMain') 
 BEGIN 
	Create NonClustered Index [IX_COM_Currency_CurrencyEnabled_CurrencyIsMain] On [dbo].[COM_Currency] ([CurrencyEnabled] Asc,[CurrencyIsMain] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_COM_Currency_CurrencyEnabled_CurrencyIsMain') 
 BEGIN 
	DROP INDEX [IX_COM_Currency_CurrencyEnabled_CurrencyIsMain] On [dbo].[COM_Currency];
END
-- 2055678371	COM_Order	1	IX_COM_Order_OrderSiteID_OrderDate	
IF NOT Exists (Select name from sys.indexes where name = 'IX_COM_Order_OrderSiteID_OrderDate') 
 BEGIN 
	Create Clustered Index [IX_COM_Order_OrderSiteID_OrderDate] On [dbo].[COM_Order] ([OrderSiteID] Asc,[OrderDate] Desc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_COM_Order_OrderSiteID_OrderDate') 
 BEGIN 
	DROP INDEX [IX_COM_Order_OrderSiteID_OrderDate] On [dbo].[COM_Order];
END
-- 2055678371	COM_Order	9	IX_COM_Order_OrderPaymentOptionID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_COM_Order_OrderPaymentOptionID') 
 BEGIN 
	Create NonClustered Index [IX_COM_Order_OrderPaymentOptionID] On [dbo].[COM_Order] ([OrderPaymentOptionID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_COM_Order_OrderPaymentOptionID') 
 BEGIN 
	DROP INDEX [IX_COM_Order_OrderPaymentOptionID] On [dbo].[COM_Order];
END
-- 2064726408	CMS_VersionHistory	5	IX_CMS_VersionHistory_ToBePublished_PublishFrom_PublishTo	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_VersionHistory_ToBePublished_PublishFrom_PublishTo') 
 BEGIN 
	Create NonClustered Index [IX_CMS_VersionHistory_ToBePublished_PublishFrom_PublishTo] On [dbo].[CMS_VersionHistory] ([ToBePublished] Asc,[PublishFrom] Asc,[PublishTo] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_VersionHistory_ToBePublished_PublishFrom_PublishTo') 
 BEGIN 
	DROP INDEX [IX_CMS_VersionHistory_ToBePublished_PublishFrom_PublishTo] On [dbo].[CMS_VersionHistory];
END
-- 81435364	HFit_RewardsUserActivityDetail	10	PI_HFit_RewardsUserActivityDetail_ActivityNodeID	
IF NOT Exists (Select name from sys.indexes where name = 'PI_HFit_RewardsUserActivityDetail_ActivityNodeID') 
 BEGIN 
	Create NonClustered Index [PI_HFit_RewardsUserActivityDetail_ActivityNodeID] On [dbo].[HFit_RewardsUserActivityDetail] ([ActivityNodeID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 100, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'PI_HFit_RewardsUserActivityDetail_ActivityNodeID') 
 BEGIN 
	DROP INDEX [PI_HFit_RewardsUserActivityDetail_ActivityNodeID] On [dbo].[HFit_RewardsUserActivityDetail];
END
-- 81435364	HFit_RewardsUserActivityDetail	13	PI_HFit_RewardsUserActivityDetail_Date	
IF NOT Exists (Select name from sys.indexes where name = 'PI_HFit_RewardsUserActivityDetail_Date') 
 BEGIN 
	Create NonClustered Index [PI_HFit_RewardsUserActivityDetail_Date] On [dbo].[HFit_RewardsUserActivityDetail] ([ItemModifiedWhen] Asc) Include ([ItemCreatedWhen])  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 100, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'PI_HFit_RewardsUserActivityDetail_Date') 
 BEGIN 
	DROP INDEX [PI_HFit_RewardsUserActivityDetail_Date] On [dbo].[HFit_RewardsUserActivityDetail];
END
-- 87632051	Hfit_HealthAssessmentDataForImport	2	IX_NC_Hfit_HealthAssessmentDataForImport	
IF NOT Exists (Select name from sys.indexes where name = 'IX_NC_Hfit_HealthAssessmentDataForImport') 
 BEGIN 
	Create NonClustered Index [IX_NC_Hfit_HealthAssessmentDataForImport] On [dbo].[Hfit_HealthAssessmentDataForImport] ([QuestionCodeName] Asc) Include ([AnswerCodeName])  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_NC_Hfit_HealthAssessmentDataForImport') 
 BEGIN 
	DROP INDEX [IX_NC_Hfit_HealthAssessmentDataForImport] On [dbo].[Hfit_HealthAssessmentDataForImport];
END
-- 1591676718	COM_OrderItem	2	IX_COM_OrderItem_OrderItemOrderID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_COM_OrderItem_OrderItemOrderID') 
 BEGIN 
	Create NonClustered Index [IX_COM_OrderItem_OrderItemOrderID] On [dbo].[COM_OrderItem] ([OrderItemOrderID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_COM_OrderItem_OrderItemOrderID') 
 BEGIN 
	DROP INDEX [IX_COM_OrderItem_OrderItemOrderID] On [dbo].[COM_OrderItem];
END
-- 1597248745	HFIT_Tracker	29	idx_HFIT_Tracker_CreateDate	
IF NOT Exists (Select name from sys.indexes where name = 'idx_HFIT_Tracker_CreateDate') 
 BEGIN 
	Create NonClustered Index [idx_HFIT_Tracker_CreateDate] On [dbo].[HFIT_Tracker] ([ItemCreatedWhen] Desc,[ItemModifiedWhen] Desc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'idx_HFIT_Tracker_CreateDate') 
 BEGIN 
	DROP INDEX [idx_HFIT_Tracker_CreateDate] On [dbo].[HFIT_Tracker];
END
-- 245575913	Forums_ForumSubscription	3	IX_Forums_ForumSubscription_SubscriptionUserID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Forums_ForumSubscription_SubscriptionUserID') 
 BEGIN 
	Create NonClustered Index [IX_Forums_ForumSubscription_SubscriptionUserID] On [dbo].[Forums_ForumSubscription] ([SubscriptionUserID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Forums_ForumSubscription_SubscriptionUserID') 
 BEGIN 
	DROP INDEX [IX_Forums_ForumSubscription_SubscriptionUserID] On [dbo].[Forums_ForumSubscription];
END
-- 251863964	CMS_BannerCategory	2	IX_CMS_BannerCategory_BannerCategoryName_BannerCategorySiteID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_BannerCategory_BannerCategoryName_BannerCategorySiteID') 
 BEGIN 
	Create Unique NonClustered Index [IX_CMS_BannerCategory_BannerCategoryName_BannerCategorySiteID] On [dbo].[CMS_BannerCategory] ([BannerCategoryName] Asc,[BannerCategorySiteID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_BannerCategory_BannerCategoryName_BannerCategorySiteID') 
 BEGIN 
	DROP INDEX [IX_CMS_BannerCategory_BannerCategoryName_BannerCategorySiteID] On [dbo].[CMS_BannerCategory];
END
-- 259532008	Analytics_Index	1	IX_Analytics_Index_All	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Analytics_Index_All') 
 BEGIN 
	Create Clustered Index [IX_Analytics_Index_All] On [dbo].[Analytics_Index] ([IndexID] Asc,[IndexZero] Asc,[IndexMonthName] Asc,[IndexDayName] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Analytics_Index_All') 
 BEGIN 
	DROP INDEX [IX_Analytics_Index_All] On [dbo].[Analytics_Index];
END
-- 933578364	CMS_UserRole	2	IX_CMS_UserRole_UserID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_UserRole_UserID') 
 BEGIN 
	Create NonClustered Index [IX_CMS_UserRole_UserID] On [dbo].[CMS_UserRole] ([UserID] Asc) Include ([RoleID],[ValidTo])  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_UserRole_UserID') 
 BEGIN 
	DROP INDEX [IX_CMS_UserRole_UserID] On [dbo].[CMS_UserRole];
END
-- 941246408	CMS_Widget	1	IX_CMS_Widget_WidgetCategoryID_WidgetDisplayName	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_Widget_WidgetCategoryID_WidgetDisplayName') 
 BEGIN 
	Create Clustered Index [IX_CMS_Widget_WidgetCategoryID_WidgetDisplayName] On [dbo].[CMS_Widget] ([WidgetCategoryID] Asc,[WidgetDisplayName] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_Widget_WidgetCategoryID_WidgetDisplayName') 
 BEGIN 
	DROP INDEX [IX_CMS_Widget_WidgetCategoryID_WidgetDisplayName] On [dbo].[CMS_Widget];
END
-- 941246408	CMS_Widget	4	IX_CMS_Widget_WidgetIsEnabled_WidgetForGroup_WidgetForEditor_WidgetForUser	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_Widget_WidgetIsEnabled_WidgetForGroup_WidgetForEditor_WidgetForUser') 
 BEGIN 
	Create NonClustered Index [IX_CMS_Widget_WidgetIsEnabled_WidgetForGroup_WidgetForEditor_WidgetForUser] On [dbo].[CMS_Widget] ([WidgetIsEnabled] Asc,[WidgetForGroup] Asc,[WidgetForEditor] Asc,[WidgetForUser] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_Widget_WidgetIsEnabled_WidgetForGroup_WidgetForEditor_WidgetForUser') 
 BEGIN 
	DROP INDEX [IX_CMS_Widget_WidgetIsEnabled_WidgetForGroup_WidgetForEditor_WidgetForUser] On [dbo].[CMS_Widget];
END
-- 946102411	CMS_MembershipUser	6	IX_CMS_MembershipUser_UserIDValidTo	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_MembershipUser_UserIDValidTo') 
 BEGIN 
	Create NonClustered Index [IX_CMS_MembershipUser_UserIDValidTo] On [dbo].[CMS_MembershipUser] ([UserID] Asc,[ValidTo] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_MembershipUser_UserIDValidTo') 
 BEGIN 
	DROP INDEX [IX_CMS_MembershipUser_UserIDValidTo] On [dbo].[CMS_MembershipUser];
END
-- 948914452	CMS_Layout	2	IX_CMS_Layout_LayoutDisplayName	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_Layout_LayoutDisplayName') 
 BEGIN 
	Create NonClustered Index [IX_CMS_Layout_LayoutDisplayName] On [dbo].[CMS_Layout] ([LayoutDisplayName] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_Layout_LayoutDisplayName') 
 BEGIN 
	DROP INDEX [IX_CMS_Layout_LayoutDisplayName] On [dbo].[CMS_Layout];
END
-- 958626458	OM_Rule	3	IX_OM_Rule_RuleSiteID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_OM_Rule_RuleSiteID') 
 BEGIN 
	Create NonClustered Index [IX_OM_Rule_RuleSiteID] On [dbo].[OM_Rule] ([RuleSiteID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_OM_Rule_RuleSiteID') 
 BEGIN 
	DROP INDEX [IX_OM_Rule_RuleSiteID] On [dbo].[OM_Rule];
END
-- 983674552	CMS_Avatar	3	IX_CMS_Avatar_AvatarType_AvatarIsCustom	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_Avatar_AvatarType_AvatarIsCustom') 
 BEGIN 
	Create NonClustered Index [IX_CMS_Avatar_AvatarType_AvatarIsCustom] On [dbo].[CMS_Avatar] ([AvatarType] Asc,[AvatarIsCustom] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_Avatar_AvatarType_AvatarIsCustom') 
 BEGIN 
	DROP INDEX [IX_CMS_Avatar_AvatarType_AvatarIsCustom] On [dbo].[CMS_Avatar];
END
-- 1029578706	CMS_Role	1	IX_CMS_Role_SiteID_RoleName_RoleDisplayName	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_Role_SiteID_RoleName_RoleDisplayName') 
 BEGIN 
	Create Clustered Index [IX_CMS_Role_SiteID_RoleName_RoleDisplayName] On [dbo].[CMS_Role] ([SiteID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_Role_SiteID_RoleName_RoleDisplayName') 
 BEGIN 
	DROP INDEX [IX_CMS_Role_SiteID_RoleName_RoleDisplayName] On [dbo].[CMS_Role];
END
-- 1033770740	CMS_EmailUser	2	IX_CMS_EmailUser_Status	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_EmailUser_Status') 
 BEGIN 
	Create NonClustered Index [IX_CMS_EmailUser_Status] On [dbo].[CMS_EmailUser] ([Status] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_EmailUser_Status') 
 BEGIN 
	DROP INDEX [IX_CMS_EmailUser_Status] On [dbo].[CMS_EmailUser];
END
-- 1062294844	OM_ContactGroupMember	3	IX_OM_ContactGroupMember_ContactGroupMemberRelatedID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_OM_ContactGroupMember_ContactGroupMemberRelatedID') 
 BEGIN 
	Create NonClustered Index [IX_OM_ContactGroupMember_ContactGroupMemberRelatedID] On [dbo].[OM_ContactGroupMember] ([ContactGroupMemberRelatedID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_OM_ContactGroupMember_ContactGroupMemberRelatedID') 
 BEGIN 
	DROP INDEX [IX_OM_ContactGroupMember_ContactGroupMemberRelatedID] On [dbo].[OM_ContactGroupMember];
END
-- 1750297295	COM_ShoppingCart	2	IX_COM_ShoppingCart_ShoppingCartSiteID_ShoppingCartGUID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_COM_ShoppingCart_ShoppingCartSiteID_ShoppingCartGUID') 
 BEGIN 
	Create NonClustered Index [IX_COM_ShoppingCart_ShoppingCartSiteID_ShoppingCartGUID] On [dbo].[COM_ShoppingCart] ([ShoppingCartGUID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_COM_ShoppingCart_ShoppingCartSiteID_ShoppingCartGUID') 
 BEGIN 
	DROP INDEX [IX_COM_ShoppingCart_ShoppingCartSiteID_ShoppingCartGUID] On [dbo].[COM_ShoppingCart];
END
-- 1750297295	COM_ShoppingCart	5	IX_COM_ShoppingCart_ShoppingCartCurrencyID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_COM_ShoppingCart_ShoppingCartCurrencyID') 
 BEGIN 
	Create NonClustered Index [IX_COM_ShoppingCart_ShoppingCartCurrencyID] On [dbo].[COM_ShoppingCart] ([ShoppingCartCurrencyID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_COM_ShoppingCart_ShoppingCartCurrencyID') 
 BEGIN 
	DROP INDEX [IX_COM_ShoppingCart_ShoppingCartCurrencyID] On [dbo].[COM_ShoppingCart];
END
-- 1750297295	COM_ShoppingCart	8	IX_COM_ShoppingCart_ShoppingCartDiscountCouponID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_COM_ShoppingCart_ShoppingCartDiscountCouponID') 
 BEGIN 
	Create NonClustered Index [IX_COM_ShoppingCart_ShoppingCartDiscountCouponID] On [dbo].[COM_ShoppingCart] ([ShoppingCartDiscountCouponID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_COM_ShoppingCart_ShoppingCartDiscountCouponID') 
 BEGIN 
	DROP INDEX [IX_COM_ShoppingCart_ShoppingCartDiscountCouponID] On [dbo].[COM_ShoppingCart];
END
-- 1778821399	HFit_HealthAssesmentUserStarted	19	idx_UserID	
IF NOT Exists (Select name from sys.indexes where name = 'idx_UserID') 
 BEGIN 
	Create NonClustered Index [idx_UserID] On [dbo].[HFit_HealthAssesmentUserStarted] ([UserID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'idx_UserID') 
 BEGIN 
	DROP INDEX [idx_UserID] On [dbo].[HFit_HealthAssesmentUserStarted];
END
-- 11147085	COM_InternalStatus	1	IX_COM_InternalStatus_InternalStatusDisplayName_InternalStatusEnabled	
IF NOT Exists (Select name from sys.indexes where name = 'IX_COM_InternalStatus_InternalStatusDisplayName_InternalStatusEnabled') 
 BEGIN 
	Create Clustered Index [IX_COM_InternalStatus_InternalStatusDisplayName_InternalStatusEnabled] On [dbo].[COM_InternalStatus] ([InternalStatusDisplayName] Asc,[InternalStatusEnabled] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_COM_InternalStatus_InternalStatusDisplayName_InternalStatusEnabled') 
 BEGIN 
	DROP INDEX [IX_COM_InternalStatus_InternalStatusDisplayName_InternalStatusEnabled] On [dbo].[COM_InternalStatus];
END
-- 13203793	HFit_CentralConfig	2	IX_HFit_CentralConfigSiteClientCulture	
IF NOT Exists (Select name from sys.indexes where name = 'IX_HFit_CentralConfigSiteClientCulture') 
 BEGIN 
	Create NonClustered Index [IX_HFit_CentralConfigSiteClientCulture] On [dbo].[HFit_CentralConfig] ([ConfigSiteName] Asc,[ConfigClientName] Asc,[ConfigCultureCode] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_HFit_CentralConfigSiteClientCulture') 
 BEGIN 
	DROP INDEX [IX_HFit_CentralConfigSiteClientCulture] On [dbo].[HFit_CentralConfig];
END
-- 773577794	PM_ProjectTask	4	IX_PM_ProjectTask_ProjectTaskPriorityID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_PM_ProjectTask_ProjectTaskPriorityID') 
 BEGIN 
	Create NonClustered Index [IX_PM_ProjectTask_ProjectTaskPriorityID] On [dbo].[PM_ProjectTask] ([ProjectTaskPriorityID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 100, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_PM_ProjectTask_ProjectTaskPriorityID') 
 BEGIN 
	DROP INDEX [IX_PM_ProjectTask_ProjectTaskPriorityID] On [dbo].[PM_ProjectTask];
END
-- 777821883	HFit_TrackerFlexibility	6	idx_HFit_TrackerFlexibility_CreateDate	
IF NOT Exists (Select name from sys.indexes where name = 'idx_HFit_TrackerFlexibility_CreateDate') 
 BEGIN 
	Create NonClustered Index [idx_HFit_TrackerFlexibility_CreateDate] On [dbo].[HFit_TrackerFlexibility] ([ItemCreatedWhen] Asc,[ItemModifiedWhen] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'idx_HFit_TrackerFlexibility_CreateDate') 
 BEGIN 
	DROP INDEX [idx_HFit_TrackerFlexibility_CreateDate] On [dbo].[HFit_TrackerFlexibility];
END
-- 1574296668	Notification_Subscription	3	IX_Notification_Subscription_SubscriptionTemplateID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Notification_Subscription_SubscriptionTemplateID') 
 BEGIN 
	Create NonClustered Index [IX_Notification_Subscription_SubscriptionTemplateID] On [dbo].[Notification_Subscription] ([SubscriptionTemplateID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Notification_Subscription_SubscriptionTemplateID') 
 BEGIN 
	DROP INDEX [IX_Notification_Subscription_SubscriptionTemplateID] On [dbo].[Notification_Subscription];
END
-- 1574296668	Notification_Subscription	6	IX_Notification_Subscription_SubscriptionSiteID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Notification_Subscription_SubscriptionSiteID') 
 BEGIN 
	Create NonClustered Index [IX_Notification_Subscription_SubscriptionSiteID] On [dbo].[Notification_Subscription] ([SubscriptionSiteID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Notification_Subscription_SubscriptionSiteID') 
 BEGIN 
	DROP INDEX [IX_Notification_Subscription_SubscriptionSiteID] On [dbo].[Notification_Subscription];
END
-- 743673697	Community_GroupMember	7	IX_Community_GroupMember_MemberStatus	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Community_GroupMember_MemberStatus') 
 BEGIN 
	Create NonClustered Index [IX_Community_GroupMember_MemberStatus] On [dbo].[Community_GroupMember] ([MemberStatus] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Community_GroupMember_MemberStatus') 
 BEGIN 
	DROP INDEX [IX_Community_GroupMember_MemberStatus] On [dbo].[Community_GroupMember];
END
-- 204332288	HFit_PostSubscriber	13	IX_HFit_PostSubscriber_PublishDate_ItemModifiedWhen_ContactID_GroupID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_HFit_PostSubscriber_PublishDate_ItemModifiedWhen_ContactID_GroupID') 
 BEGIN 
	Create NonClustered Index [IX_HFit_PostSubscriber_PublishDate_ItemModifiedWhen_ContactID_GroupID] On [dbo].[HFit_PostSubscriber] ([ItemModifiedWhen] Asc,[PublishDate] Asc,[ContactID] Asc,[ContactGroupID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_HFit_PostSubscriber_PublishDate_ItemModifiedWhen_ContactID_GroupID') 
 BEGIN 
	DROP INDEX [IX_HFit_PostSubscriber_PublishDate_ItemModifiedWhen_ContactID_GroupID] On [dbo].[HFit_PostSubscriber];
END
-- 204332288	HFit_PostSubscriber	16	IX_PostSubscriber_PublishDate	
IF NOT Exists (Select name from sys.indexes where name = 'IX_PostSubscriber_PublishDate') 
 BEGIN 
	Create NonClustered Index [IX_PostSubscriber_PublishDate] On [dbo].[HFit_PostSubscriber] ([PublishDate] Asc) Include ([ContactGroupID],[ContactID],[ItemModifiedWhen])  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_PostSubscriber_PublishDate') 
 BEGIN 
	DROP INDEX [IX_PostSubscriber_PublishDate] On [dbo].[HFit_PostSubscriber];
END
-- 208719796	CMS_WebPart	4	IX_CMS_WebPart_WebPartCategoryID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_WebPart_WebPartCategoryID') 
 BEGIN 
	Create NonClustered Index [IX_CMS_WebPart_WebPartCategoryID] On [dbo].[CMS_WebPart] ([WebPartCategoryID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_WebPart_WebPartCategoryID') 
 BEGIN 
	DROP INDEX [IX_CMS_WebPart_WebPartCategoryID] On [dbo].[CMS_WebPart];
END
-- 437576597	Analytics_HourHits	3	IX_Analytics_HourHits_HitsStatisticsID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Analytics_HourHits_HitsStatisticsID') 
 BEGIN 
	Create NonClustered Index [IX_Analytics_HourHits_HitsStatisticsID] On [dbo].[Analytics_HourHits] ([HitsStatisticsID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Analytics_HourHits_HitsStatisticsID') 
 BEGIN 
	DROP INDEX [IX_Analytics_HourHits_HitsStatisticsID] On [dbo].[Analytics_HourHits];
END
-- 446624634	OM_ContactGroup	2	IX_OM_ContactGroup_ContactGroupSiteID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_OM_ContactGroup_ContactGroupSiteID') 
 BEGIN 
	Create NonClustered Index [IX_OM_ContactGroup_ContactGroupSiteID] On [dbo].[OM_ContactGroup] ([ContactGroupSiteID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 100, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_OM_ContactGroup_ContactGroupSiteID') 
 BEGIN 
	DROP INDEX [IX_OM_ContactGroup_ContactGroupSiteID] On [dbo].[OM_ContactGroup];
END
-- 468196718	Newsletter_Emails	6	IX_Newsletter_Emails_EmailGUID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Newsletter_Emails_EmailGUID') 
 BEGIN 
	Create Unique NonClustered Index [IX_Newsletter_Emails_EmailGUID] On [dbo].[Newsletter_Emails] ([EmailGUID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Newsletter_Emails_EmailGUID') 
 BEGIN 
	DROP INDEX [IX_Newsletter_Emails_EmailGUID] On [dbo].[Newsletter_Emails];
END
-- 469576711	Analytics_DayHits	3	IX_Analytics_DayHits_HitsStatisticsID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Analytics_DayHits_HitsStatisticsID') 
 BEGIN 
	Create NonClustered Index [IX_Analytics_DayHits_HitsStatisticsID] On [dbo].[Analytics_DayHits] ([HitsStatisticsID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Analytics_DayHits_HitsStatisticsID') 
 BEGIN 
	DROP INDEX [IX_Analytics_DayHits_HitsStatisticsID] On [dbo].[Analytics_DayHits];
END
-- 471672728	Forums_ForumGroup	1	IX_Forums_ForumGroup_GroupSiteID_GroupOrder	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Forums_ForumGroup_GroupSiteID_GroupOrder') 
 BEGIN 
	Create Clustered Index [IX_Forums_ForumGroup_GroupSiteID_GroupOrder] On [dbo].[Forums_ForumGroup] ([GroupSiteID] Asc,[GroupOrder] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Forums_ForumGroup_GroupSiteID_GroupOrder') 
 BEGIN 
	DROP INDEX [IX_Forums_ForumGroup_GroupSiteID_GroupOrder] On [dbo].[Forums_ForumGroup];
END
-- 471672728	Forums_ForumGroup	4	IX_Forums_ForumGroup_GroupGroupID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Forums_ForumGroup_GroupGroupID') 
 BEGIN 
	Create NonClustered Index [IX_Forums_ForumGroup_GroupGroupID] On [dbo].[Forums_ForumGroup] ([GroupGroupID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Forums_ForumGroup_GroupGroupID') 
 BEGIN 
	DROP INDEX [IX_Forums_ForumGroup_GroupGroupID] On [dbo].[Forums_ForumGroup];
END
-- 171147655	CMS_EmailTemplate	3	IX_CMS_EmailTemplate_EmailTemplateName_EmailTemplateSiteID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_EmailTemplate_EmailTemplateName_EmailTemplateSiteID') 
 BEGIN 
	Create NonClustered Index [IX_CMS_EmailTemplate_EmailTemplateName_EmailTemplateSiteID] On [dbo].[CMS_EmailTemplate] ([EmailTemplateName] Asc,[EmailTemplateSiteID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_EmailTemplate_EmailTemplateName_EmailTemplateSiteID') 
 BEGIN 
	DROP INDEX [IX_CMS_EmailTemplate_EmailTemplateName_EmailTemplateSiteID] On [dbo].[CMS_EmailTemplate];
END
-- 180195692	CMS_SettingsKey	1	IX_CMS_SettingsKey_KeyLoadGeneration_SiteID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_SettingsKey_KeyLoadGeneration_SiteID') 
 BEGIN 
	Create Clustered Index [IX_CMS_SettingsKey_KeyLoadGeneration_SiteID] On [dbo].[CMS_SettingsKey] ([KeyLoadGeneration] Asc,[SiteID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_SettingsKey_KeyLoadGeneration_SiteID') 
 BEGIN 
	DROP INDEX [IX_CMS_SettingsKey_KeyLoadGeneration_SiteID] On [dbo].[CMS_SettingsKey];
END
-- 180195692	CMS_SettingsKey	4	IX_CMS_SettingsKey_KeyCategoryID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_SettingsKey_KeyCategoryID') 
 BEGIN 
	Create NonClustered Index [IX_CMS_SettingsKey_KeyCategoryID] On [dbo].[CMS_SettingsKey] ([KeyCategoryID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_SettingsKey_KeyCategoryID') 
 BEGIN 
	DROP INDEX [IX_CMS_SettingsKey_KeyCategoryID] On [dbo].[CMS_SettingsKey];
END
-- 180195692	CMS_SettingsKey	15	nonKeyName	
IF NOT Exists (Select name from sys.indexes where name = 'nonKeyName') 
 BEGIN 
	Create NonClustered Index [nonKeyName] On [dbo].[CMS_SettingsKey] ([KeyName] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'nonKeyName') 
 BEGIN 
	DROP INDEX [nonKeyName] On [dbo].[CMS_SettingsKey];
END
-- 185767719	OM_MVTVariant	2	IX_OM_MVTVariant_MVTVariantPageTemplateID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_OM_MVTVariant_MVTVariantPageTemplateID') 
 BEGIN 
	Create NonClustered Index [IX_OM_MVTVariant_MVTVariantPageTemplateID] On [dbo].[OM_MVTVariant] ([MVTVariantPageTemplateID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_OM_MVTVariant_MVTVariantPageTemplateID') 
 BEGIN 
	DROP INDEX [IX_OM_MVTVariant_MVTVariantPageTemplateID] On [dbo].[OM_MVTVariant];
END
-- 1876917758	BadWords_Word	3	IX_BadWords_Word_WordIsGlobal	
IF NOT Exists (Select name from sys.indexes where name = 'IX_BadWords_Word_WordIsGlobal') 
 BEGIN 
	Create NonClustered Index [IX_BadWords_Word_WordIsGlobal] On [dbo].[BadWords_Word] ([WordIsGlobal] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_BadWords_Word_WordIsGlobal') 
 BEGIN 
	DROP INDEX [IX_BadWords_Word_WordIsGlobal] On [dbo].[BadWords_Word];
END
-- 1890105774	Integration_Synchronization	2	IX_Integration_Synchronization_SynchronizationTaskID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Integration_Synchronization_SynchronizationTaskID') 
 BEGIN 
	Create NonClustered Index [IX_Integration_Synchronization_SynchronizationTaskID] On [dbo].[Integration_Synchronization] ([SynchronizationTaskID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Integration_Synchronization_SynchronizationTaskID') 
 BEGIN 
	DROP INDEX [IX_Integration_Synchronization_SynchronizationTaskID] On [dbo].[Integration_Synchronization];
END
-- 80719340	CMS_Class	6	IX_CMS_Class_ClassDefaultPageTemplateID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_Class_ClassDefaultPageTemplateID') 
 BEGIN 
	Create NonClustered Index [IX_CMS_Class_ClassDefaultPageTemplateID] On [dbo].[CMS_Class] ([ClassDefaultPageTemplateID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_Class_ClassDefaultPageTemplateID') 
 BEGIN 
	DROP INDEX [IX_CMS_Class_ClassDefaultPageTemplateID] On [dbo].[CMS_Class];
END
-- 564197060	CMS_UserSettings	74	IDX_UserSettings_CoachID	
IF NOT Exists (Select name from sys.indexes where name = 'IDX_UserSettings_CoachID') 
 BEGIN 
	Create NonClustered Index [IDX_UserSettings_CoachID] On [dbo].[CMS_UserSettings] ([HFitCoachId] Asc) Include ([UserSettingsUserID],[HFitCoachingEnrollDate])  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IDX_UserSettings_CoachID') 
 BEGIN 
	DROP INDEX [IDX_UserSettings_CoachID] On [dbo].[CMS_UserSettings];
END
-- 1919345902	Newsletter_NewsletterIssue	4	IX_Newslettes_NewsletterIssue_IssueShowInNewsletterArchive	
IF NOT Exists (Select name from sys.indexes where name = 'IX_Newslettes_NewsletterIssue_IssueShowInNewsletterArchive') 
 BEGIN 
	Create NonClustered Index [IX_Newslettes_NewsletterIssue_IssueShowInNewsletterArchive] On [dbo].[Newsletter_NewsletterIssue] ([IssueShowInNewsletterArchive] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_Newslettes_NewsletterIssue_IssueShowInNewsletterArchive') 
 BEGIN 
	DROP INDEX [IX_Newslettes_NewsletterIssue_IssueShowInNewsletterArchive] On [dbo].[Newsletter_NewsletterIssue];
END
-- 1922782603	EDW_GroupMemberToday	1	PKI_EDW_GroupMemberToday	
IF NOT Exists (Select name from sys.indexes where name = 'PKI_EDW_GroupMemberToday') 
 BEGIN 
	Create Clustered Index [PKI_EDW_GroupMemberToday] On [dbo].[EDW_GroupMemberToday] ([ContactGroupMemberRelatedID] Asc,[GroupName] Asc,[HFitUserMpiNumber] Asc,[Today] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 100, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'PKI_EDW_GroupMemberToday') 
 BEGIN 
	DROP INDEX [PKI_EDW_GroupMemberToday] On [dbo].[EDW_GroupMemberToday];
END
-- 1925581898	COM_PaymentOption	1	IX_COM_PaymentOption_PaymentOptionSiteID_PaymentOptionDisplayName_PaymentOptionEnabled	
IF NOT Exists (Select name from sys.indexes where name = 'IX_COM_PaymentOption_PaymentOptionSiteID_PaymentOptionDisplayName_PaymentOptionEnabled') 
 BEGIN 
	Create Clustered Index [IX_COM_PaymentOption_PaymentOptionSiteID_PaymentOptionDisplayName_PaymentOptionEnabled] On [dbo].[COM_PaymentOption] ([PaymentOptionSiteID] Asc,[PaymentOptionDisplayName] Asc,[PaymentOptionEnabled] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_COM_PaymentOption_PaymentOptionSiteID_PaymentOptionDisplayName_PaymentOptionEnabled') 
 BEGIN 
	DROP INDEX [IX_COM_PaymentOption_PaymentOptionSiteID_PaymentOptionDisplayName_PaymentOptionEnabled] On [dbo].[COM_PaymentOption];
END
-- 1925581898	COM_PaymentOption	4	IX_COM_PaymentOption_PaymentOptionFailedOrderStatusID	
IF NOT Exists (Select name from sys.indexes where name = 'IX_COM_PaymentOption_PaymentOptionFailedOrderStatusID') 
 BEGIN 
	Create NonClustered Index [IX_COM_PaymentOption_PaymentOptionFailedOrderStatusID] On [dbo].[COM_PaymentOption] ([PaymentOptionFailedOrderStatusID] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_COM_PaymentOption_PaymentOptionFailedOrderStatusID') 
 BEGIN 
	DROP INDEX [IX_COM_PaymentOption_PaymentOptionFailedOrderStatusID] On [dbo].[COM_PaymentOption];
END
-- 1926297922	CMS_AbuseReport	1	IX_CMS_AbuseReport_ReportWhen	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_AbuseReport_ReportWhen') 
 BEGIN 
	Create Clustered Index [IX_CMS_AbuseReport_ReportWhen] On [dbo].[CMS_AbuseReport] ([ReportWhen] Desc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_AbuseReport_ReportWhen') 
 BEGIN 
	DROP INDEX [IX_CMS_AbuseReport_ReportWhen] On [dbo].[CMS_AbuseReport];
END
-- 1926297922	CMS_AbuseReport	4	IX_CMS_AbuseReport_ReportStatus	
IF NOT Exists (Select name from sys.indexes where name = 'IX_CMS_AbuseReport_ReportStatus') 
 BEGIN 
	Create NonClustered Index [IX_CMS_AbuseReport_ReportStatus] On [dbo].[CMS_AbuseReport] ([ReportStatus] Asc)  With (Drop_Existing = OFF, SORT_IN_TEMPDB = ON, Fillfactor = 80, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = NONE) On [ ];	
 END 
	 	
IF Exists (Select name from sys.indexes where name = 'IX_CMS_AbuseReport_ReportStatus') 
 BEGIN 
	DROP INDEX [IX_CMS_AbuseReport_ReportStatus] On [dbo].[CMS_AbuseReport];
END
-- 
