
print ('Processing cleanup utility...')
GO

if not exists(Select name from sys.indexes where name =  'HFit_UserTracker_idx_01')
BEGIN
	CREATE NONCLUSTERED INDEX [HFit_UserTracker_idx_01] ON [dbo].[HFit_UserTracker] ([UserID])
END

GO

if not exists(Select name from sys.indexes where name =  'IX_HAUserRisk_ModuleItemID')
BEGIN
	CREATE NONCLUSTERED INDEX [IX_HAUserRisk_ModuleItemID] ON [dbo].[HFit_HealthAssesmentUserRiskCategory] ([HAModuleItemID])
END
GO

if not exists(Select name from sys.indexes where name =  'nonHAModuleItemID')
BEGIN
	CREATE NONCLUSTERED INDEX [nonHAModuleItemID] ON [dbo].[HFit_HealthAssesmentUserRiskCategory] ([HAModuleItemID])
END
GO


if not exists(Select name from sys.indexes where name =  'IX_HAUserRiskArea_ItemID')
BEGIN
	CREATE NONCLUSTERED INDEX [IX_HAUserRiskArea_ItemID] ON [dbo].[HFit_HealthAssesmentUserRiskArea] ([HARiskCategoryItemID])
END
GO

if not exists(Select name from sys.indexes where name =  'IX_HAUserQuestion_ItemProfCollected')
BEGIN
	CREATE NONCLUSTERED INDEX [IX_HAUserQuestion_ItemProfCollected] ON [dbo].[HFit_HealthAssesmentUserQuestion] ([HARiskAreaItemID], [IsProfessionallyCollected])
END
GO

if not exists(Select name from sys.indexes where name =  'IDX_View_CMS_Tree_Joined_Regular_NodeID_DocGuid')
BEGIN
	CREATE NONCLUSTERED INDEX [IDX_View_CMS_Tree_Joined_Regular_NodeID_DocGuid] ON [dbo].[View_CMS_Tree_Joined_Regular] ([ClassName]) INCLUDE ([DocumentForeignKeyValue], [DocumentGUID], [DocumentPublishedVersionHistoryID], [NodeID], [NodeParentID])
END
GO

if not exists(Select name from sys.indexes where name =  'IX_View_CMS_Tree_Joined_Regular_ClassName_NodeSiteID_DocumentForeignKeyValue_DocumentCulture')
BEGIN
	CREATE NONCLUSTERED INDEX [IX_View_CMS_Tree_Joined_Regular_ClassName_NodeSiteID_DocumentForeignKeyValue_DocumentCulture] ON [dbo].[View_CMS_Tree_Joined_Regular] ([ClassName], [NodeSiteID], [DocumentForeignKeyValue], [DocumentCulture]) INCLUDE ([NodeParentID])
END
GO

if not exists(Select name from sys.indexes where name =  'PI_View_CMS_Tree_Joined_Regular_DocumentCulture')
BEGIN
	CREATE NONCLUSTERED INDEX [PI_View_CMS_Tree_Joined_Regular_DocumentCulture] ON [dbo].[View_CMS_Tree_Joined_Regular] ([NodeID], [DocumentCulture])
END
GO

if not exists(Select name from sys.indexes where name =  'IX_View_CMS_Tree_Joined_Regular_DocumentCulture_NodeID')
BEGIN
	CREATE NONCLUSTERED INDEX [IX_View_CMS_Tree_Joined_Regular_DocumentCulture_NodeID] ON [dbo].[View_CMS_Tree_Joined_Regular] ([NodeID], [DocumentCulture], [DocumentGUID])
END
GO

--Diff: [view_EDW_CoachingDetail]
--Diff: [dbo].[view_EDW_HealthAssesment]

if exists (select name from sys.views where name = 'View_EDW_CDC_HealthAssesmentUserAnswers')
BEGIN
	Drop view View_EDW_CDC_HealthAssesmentUserAnswers
END

if exists (select name from sys.views where name = 'View_EDW_CDC_HealthAssesmentUserAnswers')
BEGIN
	Drop view [dbo].[view_HFit_HealthAssesmentUserModule]
END

if exists (select name from sys.views where name = 'View_EDW_CDC_HealthAssesmentUserAnswers')
BEGIN
	Drop view [dbo].[view_HFit_HealthAssesmentUserModule]
END

if exists (select name from sys.views where name = 'View_EDW_CDC_HealthAssesmentUserAnswers')
BEGIN
	Drop view [dbo].[view_EDW_HealthAssesmentV2]
END
	
if exists (select name from sys.views where name = 'View_EDW_CDC_HealthAssesmentUserAnswers')
BEGIN
	Drop view [dbo].[view_HFit_TrackerCompositeDetails]
END

if not exists(Select name from sys.indexes where name =  'IX_HFitTodo_Userid')
BEGIN
	CREATE NONCLUSTERED INDEX [IX_HFitTodo_Userid] ON [dbo].[HFit_ToDoPersonal] ([ToDoUserID], [Active], [CultureCode])
END
GO

if not exists(Select name from sys.indexes where name =  'IX_TrackerTests')
BEGIN
	CREATE NONCLUSTERED INDEX [IX_TrackerTests] ON [dbo].[HFit_TrackerTests] ([UserID]) INCLUDE ([ColoCareKit], [CotinineTest], [CustomDesc], [CustomTest], [DRA], [EventDate], [IsProfessionallyCollected], [ItemCreatedWhen], [ItemModifiedWhen], [Notes], [OtherExam], [PSATest], [TrackerCollectionSourceID], [TScore])
end
GO

IF NOT EXISTS
		(
			SELECT name
			FROM sysindexes
			WHERE NAME = 'IDX_View_CMS_Tree_Joined_Linked_NodeID_DocCulture'
		)
	BEGIN
		CREATE NONCLUSTERED INDEX IDX_View_CMS_Tree_Joined_Linked_NodeID_DocCulture
		ON [dbo].[View_CMS_Tree_Joined_Linked] ([NodeID],[DocumentCulture])
END
GO

IF NOT EXISTS
		(
			SELECT name
			FROM sysindexes
			WHERE NAME = 'IDX_View_CMS_Tree_Joined_Linked_NodeID_DocGuid'
		)
	BEGIN
		CREATE NONCLUSTERED INDEX IDX_View_CMS_Tree_Joined_Linked_NodeID_DocGuid
		ON [dbo].[View_CMS_Tree_Joined_Linked] ([ClassName])
		INCLUDE ([NodeID],[NodeParentID],[DocumentForeignKeyValue],[DocumentPublishedVersionHistoryID],[DocumentGUID])
END
GO

IF NOT EXISTS
		(
			SELECT name
			FROM sysindexes
			WHERE NAME = 'IDX_View_CMS_Tree_Joined_Regular_NodeID_DocGuid'
		)
	BEGIN
		CREATE NONCLUSTERED INDEX IDX_View_CMS_Tree_Joined_Regular_NodeID_DocGuid
		ON [dbo].[View_CMS_Tree_Joined_Regular] ([ClassName])
		INCLUDE ([NodeID],[NodeParentID],[DocumentForeignKeyValue],[DocumentPublishedVersionHistoryID],[DocumentGUID])
END
GO

IF NOT EXISTS
		(
			SELECT name
			FROM sysindexes
			WHERE NAME = 'IX_View_CMS_Tree_Joined_Regular_DocumentCulture_NodeID'
		)
	BEGIN
		CREATE NONCLUSTERED INDEX IX_View_CMS_Tree_Joined_Regular_DocumentCulture_NodeID
		ON [dbo].[View_CMS_Tree_Joined_Regular] ([NodeID],[DocumentCulture],DocumentGUID)
END
GO


IF NOT EXISTS
		(
			SELECT name
			FROM sysindexes
			WHERE NAME = 'PI_View_CMS_Tree_Joined_Regular_NodeSiteID_DocumentCulture_NodeID'
		)
	BEGIN
		CREATE INDEX PI_View_CMS_Tree_Joined_Regular_NodeSiteID_DocumentCulture_NodeID
		ON View_CMS_Tree_Joined_Regular
		(     [NodeSiteID] ASC 
			, [NodeID] ASC 
			, [NodeGUID]
			, [NodeParentID] ASC 
			, [DocumentCulture] ASC             
			--, [DocumentID] ASC 
			, [DocumentPublishedVersionHistoryID] ASC 
		, [DocumentGUID]
		, [DocumentModifiedWhen]
		, [DocumentCreatedWhen]
		)
END
GO


IF NOT EXISTS
		(
			SELECT name
			FROM sysindexes
			WHERE NAME = 'PI_View_CMS_Tree_Joined_Linked_NodeSiteID_DocumentCulture_NodeID'
		)
	BEGIN
		CREATE  INDEX PI_View_CMS_Tree_Joined_Linked_NodeSiteID_DocumentCulture_NodeID
		ON View_CMS_Tree_Joined_Linked
		(     [NodeSiteID] ASC 
		, [DocumentCulture] ASC 
		, [NodeID] ASC 
		, [NodeGUID]
		, [DocumentModifiedWhen]
		, [DocumentCreatedWhen]
		)
 END
GO

IF NOT EXISTS
		(
			SELECT name
			FROM sysindexes
			WHERE NAME = 'PI_View_CMS_Tree_Joined_Regular_DocumentCulture'
		)
	BEGIN
		CREATE NONCLUSTERED INDEX [PI_View_CMS_Tree_Joined_Regular_DocumentCulture]
			ON [dbo].[View_CMS_Tree_Joined_Regular] ([NodeID],[DocumentCulture])
	END


print ('Cleanup utility completed...')
GO
