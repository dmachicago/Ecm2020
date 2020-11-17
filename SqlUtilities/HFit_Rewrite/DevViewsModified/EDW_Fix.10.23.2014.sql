--****************************************************************
-- NOTE: This database name must be changed in MANY places in 
--	this script. Please search and change.
--****************************************************************
use KenticoCMS_DEV
go


--***************************************************************
--***************************************************************


GO
PRINT('Processing view_EDW_HealthAssesment');
GO


if exists(select name from sys.views where name = 'view_EDW_HealthAssesment')
BEGIN
	drop view view_EDW_HealthAssesment 
END
go

create VIEW [dbo].[view_EDW_HealthAssesment]
AS
--********************************************************************************************************
--7/15/2014 17:19 min. 46,750 Rows DEV
--7/15/2014 per Mark Turner
--HAModuleDocumentID is on its way out, so is - 
--Module - RiskCategory - RiskArea - Question - Answer 
--all the "DocumentID" fields are deprecated and replaced by corresponding NodeGUID fields
--8/7/2014 - Executed in DEV with GUID changes and returned 51K Rows in 43:10.
--8/8/2014 - Generated corrected view in DEV
-- Verified last mod date available to EDW 9.10.2014

--09.08.2014: John Croft and I working together, realized there is a deficit in the ability 
--of the EDW to recognize changes to database records based on the last modified date of a row. 
--The views that we are currently using in the database or deeply nested. This means that 
--several base tables are involved in building a single view of data.
--
--09.30.2014: Verified with John Croft that he does want this view to return multi-languages.
--
--The views were initially designed to recognize a date change based on a record change very 
--high in the data hierarchy, the CMS Tree level which is the top most level. However, John 
--and I recognize that data can change at any level in the hierarchy and those changes must be 
--recognized as well. Currently, that is not the case. With the new modification to the views, 
--changes in CMS documents and base tables will filter up through the hierarchy and the EDW load 
--process will be able to realize that a change in this row’s data may affect and intrude into 
--the warehouse.

-- 10.01.2014 - Reviewed by Mark and Dale for use of the GUIDS
-- 10.01.2014 - Reviewed by Mark and Dale for use of Joins and fixed two that were incorrect (Thanks to Mark)

-- FIVE Pieces needed per John C. 10.16.2014
--	Document GUID -> HealthAssesmentUserStartedNodeGUID
--	Module GUID -> Module -> HAUserModule.HAModuleNodeGUID
--	Category GUID -> Category
--	RiskArea Node Guid -> RiskArea 
--	Question Node Guid -> Question
--	Answer Node Guid -> Answer 

--********************************************************************************************************
	SELECT  distinct
		HAUserStarted.ItemID AS UserStartedItemID		
		--, HAUserStarted.HALastQuestionNodeGUID as  HealthAssesmentUserStartedNodeGUID		--WDM 8/7/2014  as HADocumentID
		
		, VCTJ.DocumentGUID as  HealthAssesmentUserStartedNodeGUID	--Per John C. 10.16.2014 requested that this be put back into the view.	
		--, NULL as  HealthAssesmentUserStartedNodeGUID		--WDM 8/7/2014  as HADocumentID -- 10.01.2014 With a conversation with Mark - 
		--		not of any use in the view, WDM will replace with HACampaignNodeGUID if needed. This one has meaning. If TWO are recieved, this is 
		--		how they are differentiated.
		
		, HAUserStarted.UserID
		, CMSUser.UserGUID
		, UserSettings.HFitUserMpiNumber
		, CMSSite.SiteGUID
		, ACCT.AccountID
		, ACCT.AccountCD
		, HAUserStarted.HAStartedDt
		, HAUserStarted.HACompletedDt
		, HAUserModule.ItemID AS UserModuleItemId
		, HAUserModule.CodeName AS UserModuleCodeName
		
		--, VCTJ.DocumentGUID as HAModuleNodeGUID		--WDM 8/7/2014 as HAModuleDocumentID
		--, VCTJ.NodeGUID as HAModuleNodeGUID				--WDM 9/30/2014 as HAModuleDocumentID	--Mark and Dale use NodeGUID instead of Doc GUID
		--, VCTJ.NodeGUID as CMSNodeGuid					--WDM 8/7/2014 as HAModuleDocumentID	--Left this and the above to kepp existing column structure

		, HAUserModule.HAModuleNodeGUID				--WDM 9/30/2014 as HAModuleDocumentID	--Mark and Dale use NodeGUID instead of Doc GUID
		
		--, NULL as CMSNodeGuid					--WDM 8/7/2014 as HAModuleDocumentID			--WDM 10.02.2014 place holder for EDW ETL
		, VCTJ.NodeGUID as CMSNodeGuid					--WDM 8/7/2014 as HAModuleDocumentID			--WDM 10.02.2014 place holder for EDW ETL per John C., Added back per John C. 10.16.2014

		, NULL as HAModuleVersionID		--WDM 10.02.2014 place holder for EDW ETL
		, HARiskCategory.ItemID AS UserRiskCategoryItemID
		, HARiskCategory.CodeName AS UserRiskCategoryCodeName
		, HARiskCategory.HARiskCategoryNodeGUID						--WDM 8/7/2014 as HARiskCategoryDocumentID
		, NULL as HARiskCategoryVersionID			--WDM 10.02.2014 place holder for EDW ETL
		, HAUserRiskArea.ItemID AS UserRiskAreaItemID
		, HAUserRiskArea.CodeName AS UserRiskAreaCodeName
		, HAUserRiskArea.HARiskAreaNodeGUID							--WDM 8/7/2014 as HARiskAreaDocumentID
		, NULL as HARiskAreaVersionID			--WDM 10.02.2014 place holder for EDW ETL
		, HAUserQuestion.ItemID AS UserQuestionItemID
		, HAQuestionsView.Title
		, HAUserQuestion.HAQuestionNodeGUID	as HAQuestionGuid		--WDM 9.2.2014	This is a repeat field but had to stay to match the previous view - this is the NODE GUID 
		--															and matches to the definition file to get the question. This tells you the question, language agnostic.
		, HAUserQuestion.CodeName AS UserQuestionCodeName
		--, HAUserQuestion.HAQuestionDocumentID_old as HAQuestionDocumentID	--WDM 9.2.2014
		, NULL as HAQuestionDocumentID	--WDM 10.1.2014 - this is GOING AWAY 		--WDM 10.02.2014 place holder for EDW ETL
		
		--, HAUserQuestion.HAQuestionVersionID_old as HAQuestionVersionID		
		, NULL as HAQuestionVersionID			--WDM 10.1.2014 - this is GOING AWAY - no versions across environments 		--WDM 10.02.2014 place holder for EDW ETL
		
		, HAUserQuestion.HAQuestionNodeGUID		--WDM 10.01.2014	Left this in place to preserve column structure.		
						
		, HAUserAnswers.ItemID AS UserAnswerItemID
		, HAUserAnswers.HAAnswerNodeGUID								--WDM 8/7/2014 as HAAnswerDocumentID

		--, HAUserAnswers.HAAnswerVersionID_old as HAAnswerVersionID		--WDM 9.2.2014	--WDM 10.1.2014 - this is GOING AWAY - no versions across environments
		, NULL as HAAnswerVersionID		--WDM 10.1.2014 - this is GOING AWAY - no versions across environments		--WDM 10.02.2014 place holder for EDW ETL

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
       ,CASE WHEN HAUserAnswers.ItemCreatedWhen = HAUserAnswers.ItemModifiedWhen THEN 'I'
             ELSE 'U'
        END AS ChangeType
		,HAUserAnswers.ItemCreatedWhen
       ,HAUserAnswers.ItemModifiedWhen
	   ,HAUserQuestion.IsProfessionallyCollected

	   ,HARiskCategory.ItemModifiedWhen as HARiskCategory_ItemModifiedWhen
	   ,HAUserRiskArea.ItemModifiedWhen as HAUserRiskArea_ItemModifiedWhen
	   ,HAUserQuestion.ItemModifiedWhen as HAUserQuestion_ItemModifiedWhen
	   ,HAUserAnswers.ItemModifiedWhen as HAUserAnswers_ItemModifiedWhen

	FROM
	dbo.HFit_HealthAssesmentUserStarted AS HAUserStarted
	INNER JOIN dbo.CMS_User AS CMSUser ON HAUserStarted.UserID = CMSUser.UserID
	INNER JOIN dbo.CMS_UserSettings AS UserSettings ON UserSettings.UserSettingsUserID = CMSUser.UserID
	INNER JOIN dbo.CMS_UserSite AS UserSite ON CMSUser.UserID = UserSite.UserID
	INNER JOIN dbo.CMS_Site AS CMSSite ON UserSite.SiteID = CMSSite.SiteID
	INNER JOIN dbo.HFit_Account AS ACCT ON ACCT.SiteID = CMSSite.SiteID	
	--The following JOIN can be put back in place once the DEV columns are added to the TABLES and SYNC'D
	--AND THE second JOIN can be removed.
	INNER JOIN dbo.HFit_HealthAssesmentUserModule AS HAUserModule ON HAUserStarted.ItemID = HAUserModule.HAStartedItemID
	--INNER JOIN dbo.view_EDW_HFit_HealthAssesmentUserModule AS HAUserModule ON HAUserStarted.ItemID = HAUserModule.HAStartedItemID

	inner join View_CMS_Tree_Joined as VCTJ on VCTJ.NodeGUID = HAUserModule.HAModuleNodeGUID
		and VCTJ.DocumentCulture = 'en-US'	--10.01.2014 put here to match John C. req. for language agnostic.

	--The following JOIN can be put back in place once the DEV columns are added to the TABLES and SYNC'D
	--AND THE second JOIN can be removed.
	INNER JOIN dbo.HFit_HealthAssesmentUserRiskCategory AS HARiskCategory ON HAUserModule.ItemID = HARiskCategory.HAModuleItemID
	--INNER JOIN dbo.view_EDW_HFit_HealthAssesmentUserRiskCategory AS HARiskCategory ON HAUserModule.ItemID = HARiskCategory.HAModuleItemID

	--The following JOIN can be put back in place once the DEV columns are added to the TABLES and SYNC'D
	--AND THE second JOIN can be removed.
	INNER JOIN dbo.HFit_HealthAssesmentUserRiskArea AS HAUserRiskArea ON HARiskCategory.ItemID = HAUserRiskArea.HARiskCategoryItemID
	--INNER JOIN dbo.view_EDW_HFit_HealthAssesmentUserRiskArea AS HAUserRiskArea ON HARiskCategory.ItemID = HAUserRiskArea.HARiskCategoryItemID
	
	--The following JOIN can be put back in place once the DEV columns are added to the TABLES and SYNC'D
	--AND THE second JOIN can be removed.
	INNER JOIN dbo.HFit_HealthAssesmentUserQuestion AS HAUserQuestion ON HAUserRiskArea.ItemID = HAUserQuestion.HARiskAreaItemID
	--INNER JOIN dbo.view_EDW_HFit_HealthAssesmentUserQuestion AS HAUserQuestion ON HAUserRiskArea.ItemID = HAUserQuestion.HARiskAreaItemID

	--The following JOIN can be put back in place once the DEV columns are added to the TABLES and SYNC'D
	--AND THE second JOIN can be removed.
	INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS HAQuestionsView ON HAUserQuestion.HAQuestionNodeGUID = HAQuestionsView.NodeGUID
		AND HAQuestionsView.DocumentCulture = 'en-US'
	--INNER JOIN dbo.view_EDW_HFit_HealthAssesmentUserQuestion AS HAQuestionsView ON HAUserQuestion.HAQuestionNodeGUID = HAQuestionsView.NodeGUID

	--LEFT OUTER JOIN dbo.HFit_HealthAssesmentUserQuestionGroupResults AS HAUserQuestionGroupResults ON HAUserQuestion.ItemID = HAUserQuestionGroupResults.HARiskAreaItemID
	LEFT OUTER JOIN dbo.HFit_HealthAssesmentUserQuestionGroupResults AS HAUserQuestionGroupResults ON HAUserRiskArea.ItemID = HAUserQuestionGroupResults.HARiskAreaItemID
	INNER JOIN dbo.HFit_HealthAssesmentUserAnswers AS HAUserAnswers ON HAUserQuestion.ItemID = HAUserAnswers.HAQuestionItemID


GO


PRINT('Processed view_EDW_HealthAssesment');
GO
print ('Processing: View_EDW_HealthAssesmentAnswers ') ;
go



if exists(select TABLE_NAME from INFORMATION_SCHEMA.VIEWS where TABLE_NAME = 'View_EDW_HealthAssesmentAnswers')
BEGIN
	drop view View_EDW_HealthAssesmentAnswers ;
END
GO


CREATE VIEW [dbo].[View_EDW_HealthAssesmentAnswers]
AS
--********************************************************************************************************
--WDM 8.8.2014 - Created this view in order to add the DocumentGUID as 
--			required by the EDW team. Was having a bit of push-back
--			from the developers, so created this one in order to 
--			expedite filling the need for runnable views for the EDW.
-- Verified last mod date available to EDW 9.10.2014
--********************************************************************************************************
      SELECT
        VHFHAPAJ.ClassName AS AnswerType
       ,VHFHAPAJ.Value
       ,VHFHAPAJ.Points
       ,VHFHAPAJ.NodeGUID
       ,VHFHAPAJ.IsEnabled
       ,VHFHAPAJ.CodeName
	   ,VHFHAPAJ.InputType
       ,VHFHAPAJ.UOM
       ,VHFHAPAJ.NodeAliasPath
       ,VHFHAPAJ.DocumentPublishedVersionHistoryID
       ,VHFHAPAJ.NodeID
       ,VHFHAPAJ.NodeOrder
       ,VHFHAPAJ.NodeLevel
       ,VHFHAPAJ.NodeParentID
       ,VHFHAPAJ.NodeLinkedNodeID
	   ,VHFHAPAJ.DocumentCulture
	   ,VHFHAPAJ.DocumentGuid
	   ,VHFHAPAJ.DocumentModifiedWhen
      FROM
        dbo.View_HFit_HealthAssesmentPredefinedAnswer_Joined AS VHFHAPAJ WITH(NOLOCK)









--GO

--EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
--Begin DesignProperties = 
--   Begin PaneConfigurations = 
--      Begin PaneConfiguration = 0
--         NumPanes = 4
--         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
--      End
--      Begin PaneConfiguration = 1
--         NumPanes = 3
--         Configuration = "(H (1 [50] 4 [25] 3))"
--      End
--      Begin PaneConfiguration = 2
--         NumPanes = 3
--         Configuration = "(H (1 [50] 2 [25] 3))"
--      End
--      Begin PaneConfiguration = 3
--         NumPanes = 3
--         Configuration = "(H (4 [30] 2 [40] 3))"
--      End
--      Begin PaneConfiguration = 4
--         NumPanes = 2
--         Configuration = "(H (1 [56] 3))"
--      End
--      Begin PaneConfiguration = 5
--         NumPanes = 2
--         Configuration = "(H (2 [66] 3))"
--      End
--      Begin PaneConfiguration = 6
--         NumPanes = 2
--         Configuration = "(H (4 [50] 3))"
--      End
--      Begin PaneConfiguration = 7
--         NumPanes = 1
--         Configuration = "(V (3))"
--      End
--      Begin PaneConfiguration = 8
--         NumPanes = 3
--         Configuration = "(H (1[56] 4[18] 2) )"
--      End
--      Begin PaneConfiguration = 9
--         NumPanes = 2
--         Configuration = "(H (1 [75] 4))"
--      End
--      Begin PaneConfiguration = 10
--         NumPanes = 2
--         Configuration = "(H (1[66] 2) )"
--      End
--      Begin PaneConfiguration = 11
--         NumPanes = 2
--         Configuration = "(H (4 [60] 2))"
--      End
--      Begin PaneConfiguration = 12
--         NumPanes = 1
--         Configuration = "(H (1) )"
--      End
--      Begin PaneConfiguration = 13
--         NumPanes = 1
--         Configuration = "(V (4))"
--      End
--      Begin PaneConfiguration = 14
--         NumPanes = 1
--         Configuration = "(V (2))"
--      End
--      ActivePaneConfig = 0
--   End
--   Begin DiagramPane = 
--      Begin Origin = 
--         Top = 0
--         Left = 0
--      End
--      Begin Tables = 
--         Begin Table = "VHFHAPAJ"
--            Begin Extent = 
--               Top = 6
--               Left = 38
--               Bottom = 260
--               Right = 362
--            End
--            DisplayFlags = 280
--            TopColumn = 173
--         End
--      End
--   End
--   Begin SQLPane = 
--   End
--   Begin DataPane = 
--      Begin ParameterDefaults = ""
--      End
--   End
--   Begin CriteriaPane = 
--      Begin ColumnWidths = 11
--         Column = 1440
--         Alias = 900
--         Table = 1170
--         Output = 720
--         Append = 1400
--         NewValue = 1170
--         SortType = 1350
--         SortOrder = 1410
--         GroupBy = 1350
--         Filter = 1350
--         Or = 1350
--         Or = 1350
--         Or = 1350
--      End
--   End
--End
--' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_HFit_HealthAssesmentAnswers'
--GO

--EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_HFit_HealthAssesmentAnswers'
--GO




GO




--***************************************************************
--***************************************************************

print ('Processing: View_EDW_HealthAssesmentQuestions ') ;
go


if exists(select TABLE_NAME from INFORMATION_SCHEMA.VIEWS where TABLE_NAME = 'View_EDW_HealthAssesmentQuestions')
BEGIN
	drop view View_EDW_HealthAssesmentQuestions ;
END
GO

create VIEW [dbo].[View_EDW_HealthAssesmentQuestions]

AS 
--**********************************************************************************
--09.11.2014 (wdm) Added the DocumentModifiedWhen to facilitate the EDW need to 
--		determine the last mod date of a record.
--10.17.2014 (wdm)
-- view_EDW_HealthAssesmentDeffinition calls 
-- View_EDW_HealthAssesmentQuestions which calls
-- View_HFit_HealthAssesmentMultipleChoiceQuestion_Joined
--		and two other JOINED views.
--View view_EDW_HealthAssesmentDeffinition has a filter on document culture of 'EN-US'
--		which limits the retured data to Engoish only.
--Today, John found a number of TITLES in view_EDW_HealthAssesmentDeffinition that were Spanish.
--The problem seems to come from sevel levels of nesting causing intersection data to seep through 
--the EN-US filter if placed at the highest level of a set of nested views.
--I took the filter and applied it to all the joined views within View_EDW_HealthAssesmentQuestions 
--		and the issue seems to have resolved itself.
--10.17.2014 (wdm) Added a filter "DocumentCulture" - the issue appears to be 
--			caused in view view_EDW_HealthAssesmentDeffinition becuase
--			the FILTER at that level on EN-US allows a portion of the intersection 
--			data to be missed for whatever reason. Adding the filter at this level
--			of the nesting seems to omit the non-english titles found by John Croft.
--**********************************************************************************
SELECT 
	VHFHAMCQJ.ClassName AS QuestionType,
	VHFHAMCQJ.Title,
	VHFHAMCQJ.Weight,
	VHFHAMCQJ.IsRequired,
	VHFHAMCQJ.QuestionImageLeft,
	VHFHAMCQJ.QuestionImageRight,
	VHFHAMCQJ.NodeGUID,	
	VHFHAMCQJ.DocumentCulture,
	VHFHAMCQJ.IsEnabled,
	VHFHAMCQJ.IsVisible,
	VHFHAMCQJ.IsStaging,
	VHFHAMCQJ.CodeName,
	VHFHAMCQJ.QuestionGroupCodeName,
	VHFHAMCQJ.NodeAliasPath,
	VHFHAMCQJ.DocumentPublishedVersionHistoryID,
	VHFHAMCQJ.NodeLevel,
	VHFHAMCQJ.NodeOrder,
	VHFHAMCQJ.NodeID,
	VHFHAMCQJ.NodeParentID,
	VHFHAMCQJ.NodeLinkedNodeID, 
	0 AS DontKnowEnabled, 
	'' AS DontKnowLabel,
	(select pp.NodeOrder from dbo.CMS_Tree pp inner join dbo.CMS_Tree p on p.NodeParentID = pp.NodeID where p.NodeID = VHFHAMCQJ.NodeParentID) AS ParentNodeOrder
	,VHFHAMCQJ.DocumentGuid
	,VHFHAMCQJ.DocumentModifiedWhen	--(WDM) 09.11.2014 added to facilitate determining document last mod date 
FROM dbo.View_HFit_HealthAssesmentMultipleChoiceQuestion_Joined AS VHFHAMCQJ WITH(NOLOCK)
where VHFHAMCQJ.DocumentCulture = 'en-US'   --(WDM) 10.19.2014 added to filter at this level of nesting

UNION ALL 
SELECT 
	VHFHAMQJ.ClassName AS QuestionType,
	VHFHAMQJ.Title,
	VHFHAMQJ.Weight,
	VHFHAMQJ.IsRequired,
	VHFHAMQJ.QuestionImageLeft,
	VHFHAMQJ.QuestionImageRight,
	VHFHAMQJ.NodeGUID,
	VHFHAMQJ.DocumentCulture,
	VHFHAMQJ.IsEnabled,
	VHFHAMQJ.IsVisible,
	VHFHAMQJ.IsStaging,
	VHFHAMQJ.CodeName,
	VHFHAMQJ.QuestionGroupCodeName,
	VHFHAMQJ.NodeAliasPath,
	VHFHAMQJ.DocumentPublishedVersionHistoryID,
	VHFHAMQJ.NodeLevel,
	VHFHAMQJ.NodeOrder,
	VHFHAMQJ.NodeID,
	VHFHAMQJ.NodeParentID,
	VHFHAMQJ.NodeLinkedNodeID,
	0 AS DontKnowEnabled, 
	'' AS DontKnowLabel,
		(select pp.NodeOrder from dbo.CMS_Tree pp inner join dbo.CMS_Tree p on p.NodeParentID = pp.NodeID where p.NodeID = VHFHAMQJ.NodeParentID) AS ParentNodeOrder
	,VHFHAMQJ.DocumentGuid
	,VHFHAMQJ.DocumentModifiedWhen	--(WDM) 09.11.2014 added to facilitate determining document last mod date 
FROM dbo.View_HFit_HealthAssesmentMatrixQuestion_Joined AS VHFHAMQJ WITH(NOLOCK)
where VHFHAMQJ.DocumentCulture = 'en-US'   --(WDM) 10.19.2014 added to filter at this level of nesting

UNION ALL 
SELECT 
	VHFHAFFJ.ClassName AS QuestionType,
	VHFHAFFJ.Title,
	VHFHAFFJ.Weight,
	VHFHAFFJ.IsRequired,
	VHFHAFFJ.QuestionImageLeft,
	'' AS QuestionImageRight,
	VHFHAFFJ.NodeGUID,
	VHFHAFFJ.DocumentCulture,
	VHFHAFFJ.IsEnabled,
	VHFHAFFJ.IsVisible,
	VHFHAFFJ.IsStaging,
	VHFHAFFJ.CodeName,
	VHFHAFFJ.QuestionGroupCodeName,
	VHFHAFFJ.NodeAliasPath,
	VHFHAFFJ.DocumentPublishedVersionHistoryID,
	VHFHAFFJ.NodeLevel,
	VHFHAFFJ.NodeOrder,
	VHFHAFFJ.NodeID,
	VHFHAFFJ.NodeParentID,
	VHFHAFFJ.NodeLinkedNodeID,
	VHFHAFFJ.DontKnowEnabled,
	VHFHAFFJ.DontKnowLabel,
	(select pp.NodeOrder from dbo.CMS_Tree pp inner join dbo.CMS_Tree p on p.NodeParentID = pp.NodeID where p.NodeID = VHFHAFFJ.NodeParentID) AS ParentNodeOrder
	,VHFHAFFJ.DocumentGuid
	,VHFHAFFJ.DocumentModifiedWhen	--(WDM) 09.11.2014 added to facilitate determining document last mod date 
FROM dbo.View_HFit_HealthAssessmentFreeForm_Joined AS VHFHAFFJ WITH(NOLOCK)
where VHFHAFFJ.DocumentCulture = 'en-US'   --(WDM) 10.19.2014 added to filter at this level of nesting

GO
print ('Processed: View_EDW_HealthAssesmentQuestions ') ;
go




GO
Print('Creating SchemaChangeMonitor table');
GO
if exists(select name from sys.tables where name = 'SchemaChangeMonitor')
BEGIN
	Print('DROP SchemaChangeMonitor table');
	DROP TABLE [SchemaChangeMonitor] ;
END

if not exists(select name from sys.tables where name = 'SchemaChangeMonitor')
BEGIN
	CREATE TABLE [dbo].[SchemaChangeMonitor](
	[PostTime] [datetime] NULL,
	[DB_User] [nvarchar](100) NULL,
	[IP_Address] [nvarchar](50) NULL,
	[CUR_User] [nvarchar](80) NULL,
	[Event] [nvarchar](100) NULL,
	[TSQL] [nvarchar](2000) NULL,
	[OBJ] [nvarchar](50) NULL,
	RowNbr int identity (1,1)
)
END
go



GO
Print('Created SchemaChangeMonitor table');
GO


GO 
Print('Creating SchemaChangeMonitor_rptData table') ;
Go
if not exists(select name from sys.tables where name = 'SchemaChangeMonitor_rptData')
BEGIN
	CREATE TABLE [dbo].[SchemaChangeMonitor_rptData](
		[label] [nvarchar](50) NOT NULL,
		[sText] [nvarchar](2500) NOT NULL,
		[DisplayOrder] [int] NOT NULL,
		[RowNbr] [int] NOT NULL
	)
END
GO 
Print('Created SchemaChangeMonitor_rptData table') ;
Go


GO 
print ('createing SchemaChangeMonitorEvent table');
Go

if not exists(select name from sys.tables where name = 'SchemaChangeMonitorEvent')
BEGIN
	CREATE TABLE [dbo].[SchemaChangeMonitorEvent](
		[Event] [nvarchar](100) NULL,	
	) ;

	insert [SchemaChangeMonitorEvent] (Event) values ('DROP_VIEW') ; 
	insert [SchemaChangeMonitorEvent] (Event) values ('ALTER_TABLE') ; 
	insert [SchemaChangeMonitorEvent] (Event) values ('CREATE_TABLE') ; 
	insert [SchemaChangeMonitorEvent] (Event) values ('ALTER_VIEW') ; 
	insert [SchemaChangeMonitorEvent] (Event) values ('CREATE_VIEW') ; 
	insert [SchemaChangeMonitorEvent] (Event) values ('DROP_TABLE') ; 
	insert [SchemaChangeMonitorEvent] (Event) values ('RENAME') ; 
	
END
GO



GO 
print ('created SchemaChangeMonitorEvent table');
Go

go
print ('Creating the AUDIT tables.') ;
go
--CreateDdlAuditTables
	IF NOT EXISTS
	(
		SELECT name
		--FROM tempdb.dbo.sysobjects
		FROM sysobjects
		WHERE ID = OBJECT_ID(N'TBL_DIFF1')
	)
	BEGIN
		CREATE TABLE [dbo].[TBL_DIFF1](
		[table_name] [sysname] NOT NULL,
		[COLUMN_NAME] [sysname] NULL,
		[DATA_TYPE] [nvarchar](128) NULL,
		[CHARACTER_MAXIMUM_LENGTH] [nvarchar](50) NULL,
		[table_name2] [sysname] NULL,
		[DATA_TYPE2] [nvarchar](128) NULL,
		[COLUMN_NAME2] [sysname] NULL,
		[CHARACTER_MAXIMUM_LENGTH2] [int] NULL,
		[NOTE] [varchar](500) NULL,
		[CreateDate] [datetime] NULL default getdate(),
		RowNbr int identity
	)

	END

	IF NOT EXISTS
	(
		SELECT name
		--FROM tempdb.dbo.sysobjects
		FROM sysobjects
		WHERE ID = OBJECT_ID(N'TBL_DIFF2')
	)
	BEGIN

		CREATE TABLE [dbo].[TBL_DIFF2](
		[table_name] [sysname] NOT NULL,
		[COLUMN_NAME] [sysname] NULL,
		[DATA_TYPE] [nvarchar](128) NULL,
		[CHARACTER_MAXIMUM_LENGTH] [nvarchar](50) NULL,
		[table_name2] [sysname] NULL,
		[DATA_TYPE2] [nvarchar](128) NULL,
		[COLUMN_NAME2] [sysname] NULL,
		[CHARACTER_MAXIMUM_LENGTH2] [int] NULL,
		[NOTE] [varchar](500) NULL,
		[CreateDate] [datetime] NULL default getdate(),
		RowNbr int identity
	)

	END
	
		IF NOT EXISTS
	(
		SELECT name
		--FROM tempdb.dbo.sysobjects
		FROM sysobjects
		WHERE ID = OBJECT_ID(N'TBL_DIFF3')
	)
	BEGIN

		CREATE TABLE [dbo].[TBL_DIFF3](
		[table_name] [sysname] NOT NULL,
		[COLUMN_NAME] [sysname] NULL,
		[DATA_TYPE] [nvarchar](128) NULL,
		[CHARACTER_MAXIMUM_LENGTH] [nvarchar](50) NULL,
		[table_name2] [sysname] NULL,
		[DATA_TYPE2] [nvarchar](128) NULL,
		[COLUMN_NAME2] [sysname] NULL,
		[CHARACTER_MAXIMUM_LENGTH2] [int] NULL
		,[NOTE] varchar(500)
		,CreateDate datetime default getdate() ,
		RowNbr int identity
	)

	END

	IF NOT EXISTS
	(
		SELECT name
		--FROM tempdb.dbo.sysobjects
		FROM sysobjects
		WHERE ID = OBJECT_ID(N'TBL_DIFF4')
	)
	BEGIN

		CREATE TABLE [dbo].[TBL_DIFF4](
		[table_name] [sysname] NOT NULL,
		[COLUMN_NAME] [sysname] NULL,
		[DATA_TYPE] [nvarchar](128) NULL,
		[CHARACTER_MAXIMUM_LENGTH] [nvarchar](50) NULL,
		[table_name2] [sysname] NULL,
		[DATA_TYPE2] [nvarchar](128) NULL,
		[COLUMN_NAME2] [sysname] NULL,
		[CHARACTER_MAXIMUM_LENGTH2] [int] NULL
		,[NOTE] varchar(500)
		,CreateDate datetime default getdate() ,
		RowNbr int identity
	)

	END

GO
if exists(select name from sys.views where name = 'view_SchemaDiff')
BEGIN
	drop view view_SchemaDiff
	print ('Removed view_SchemaDiff.') ;
END

GO
print ('Created view_SchemaDiff.') ;
GO

Create view view_SchemaDiff AS 
Select * from TBL_DIFF1 
union 
Select * from TBL_DIFF2  
union 
Select * from TBL_DIFF3

go
print ('Created the AUDIT tables.') ;
go

--drop table [TBL_DIFF1] ;
--drop table [TBL_DIFF2] ;
--drop table [TBL_DIFF3] ;
--drop table [TBL_DIFF4] ;

GO
print('Processing Proc_EDW_Compare_Tables');
GO

if exists (Select name from sys.procedures where name = 'Proc_EDW_Compare_Tables')
BEGIN
	print('Updating Proc_EDW_Compare_Tables');
	drop procedure Proc_EDW_Compare_Tables ;
END
GO

Create procedure Proc_EDW_Compare_Tables 
(	@LinkedSVR as nvarchar(254) 
	,@LinkedDB as nvarchar(80), @LinkedTBL as nvarchar(80)
	,@CurrDB as nvarchar(80), @CurrTBL as nvarchar(80)
	,@NewRun as int
)
as
BEGIN
	print('Comparing: ' + @LinkedSVR + ' : ' + @LinkedDB + ' : ' + @LinkedTBL ); 
	print('TO: ' + @CurrDB + ' : ' + @CurrTBL ); 
	--set @LinkedSVR = 'hfit-sqlUAT.cloudapp.net,3' ;
	--set @LinkedDB = 'KenticoCMS_ProdStaging' ;
	--set @LinkedTBL = 'SchemaChangeMonitor' ;
	--set @CurrDB = 'KenticoCMS_DEV' ;
	--set @CurrTBL = 'SchemaChangeMonitor'

	--exec Proc_EDW_Compare_Tables 'hfit-sqlUAT.cloudapp.net,3', 'KenticoCMS_ProdStaging', 'HFit_HealthAssessment', 'KenticoCMS_DEV', 'HFit_HealthAssessment', 0
	--exec Proc_EDW_Compare_Tables 'hfit-sqlUAT.cloudapp.net,3', 'KenticoCMS_ProdStaging', 'SchemaChangeMonitor', 'KenticoCMS_DEV', 'HFit_HealthAssessment', 1
	--exec Proc_EDW_Compare_Tables 'hfit-sqlUAT.cloudapp.net,3', 'KenticoCMS_ProdStaging', 'SchemaChangeMonitor', 'KenticoCMS_DEV', 'SchemaChangeMonitor', 1
	--exec Proc_EDW_Compare_Tables 'hfit-sqlUAT.cloudapp.net,3', 'KenticoCMS_DEV', 'SchemaChangeMonitor', 'instrument', 'HFit_HealthAssessment', 1

	DECLARE @ParmDefinition  as nvarchar(500) ;
	DECLARE @retval int   = 0 ; 
	DECLARE @S  as nvarchar(250) = '' ;
	DECLARE @SVR as varchar(200) = @LinkedSVR ;
	DECLARE @iCnt as int ;
	DECLARE @iRetval as int = 0 ; 
	DECLARE @Note as nvarchar(1000) = '' ;
	
	set @S  = 'SELECT @retval = count(*) FROM sys.servers WHERE name = @TgtSVR ' ;
	set @ParmDefinition  = N'@TgtSVR nvarchar(100), @retval bit OUTPUT' ;
	exec sp_executesql @S, @ParmDefinition, @TgtSVR = @LinkedSVR, @retval = @iRetval OUTPUT ;
	set @iCnt = (select @iRetval) ;
	IF (@iCnt = 1)
		EXEC master.sys.sp_dropserver @LinkedSVR,'droplogins'  ;
			
	EXEC sp_addlinkedserver @LinkedSVR, 'SQL Server' ;
	
	set @S  = 'select @retval = count(*) from ['+@LinkedSVR+'].['+@LinkedDB+'].sys.tables where NAME = @TgtTBL ' ;
	set @ParmDefinition  = N'@TgtTBL nvarchar(100), @retval int OUTPUT' ;
	exec sp_executesql @S, @ParmDefinition, @TgtTBL = @LinkedTBL, @retval = @iRetval OUTPUT ;
	set @iCnt = (select @iRetval) ;
	
	--print ('Step01');
	if (@iCnt = 0)
	BEGIN
		print(@LinkedTBL + ' : Table does not exist on server ' +@LinkedSVR + ' in database ' + @LinkedDB + '.') ;
		declare @SSQL as nvarchar(2000) = '' ;
		declare @msg as nvarchar(500) = '' ;
		set @msg = @LinkedTBL + ' : Table does not exist on server ' +@LinkedSVR + ' in database ' + @LinkedDB + '.' ;
		Set @SSQL = 'INSERT INTO TBL_DIFF1 (table_name, COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH, table_name2, DATA_TYPE2, COLUMN_NAME2, CHARACTER_MAXIMUM_LENGTH2, Note) ' ; 
		Set @SSQL = @SSQL + 'VALUES ( ';
		Set @SSQL = @SSQL + ''''+@CurrTBL+''', null, null , null, null ,null,null, null, '''+@msg+''' ' ;
		Set @SSQL = @SSQL + ')';
		
		exec (@SSQL) ;

		return ;
	END
		
	--set @S  = 'SELECT @retval = count(*) FROM sys.servers WHERE name = @TgtSVR ' ;
	--set @ParmDefinition  = N'@TgtSVR nvarchar(100), @retval bit OUTPUT' ;
	--exec sp_executesql @S, @ParmDefinition, @TgtSVR = @LinkedSVR, @retval = @iRetval OUTPUT ;
	--set @iCnt = (select @iRetval) ;
	--IF (@iCnt = 1)
	--	EXEC master.sys.sp_dropserver @LinkedSVR,'droplogins'  ;
	--print ('Step02');
	IF NOT EXISTS
	(
		SELECT name
		--FROM tempdb.dbo.sysobjects
		FROM sysobjects
		WHERE ID = OBJECT_ID(N'TBL_DIFF1')
	)
	BEGIN
		CREATE TABLE [dbo].[TBL_DIFF1](
		[table_name] [sysname] NOT NULL,
		[COLUMN_NAME] [sysname] NULL,
		[DATA_TYPE] [nvarchar](128) NULL,
		[CHARACTER_MAXIMUM_LENGTH] [nvarchar](50) NULL,
		[table_name2] [sysname] NULL,
		[DATA_TYPE2] [nvarchar](128) NULL,
		[COLUMN_NAME2] [sysname] NULL,
		[CHARACTER_MAXIMUM_LENGTH2] [int] NULL,
		[NOTE] [varchar](500) NULL,
		[CreateDate] [datetime] NULL default getdate(),
		RowNbr int identity
	)

	END

	IF NOT EXISTS
	(
		SELECT name
		--FROM tempdb.dbo.sysobjects
		FROM sysobjects
		WHERE ID = OBJECT_ID(N'TBL_DIFF2')
	)
	BEGIN

		CREATE TABLE [dbo].[TBL_DIFF2](
		[table_name] [sysname] NOT NULL,
		[COLUMN_NAME] [sysname] NULL,
		[DATA_TYPE] [nvarchar](128) NULL,
		[CHARACTER_MAXIMUM_LENGTH] [nvarchar](50) NULL,
		[table_name2] [sysname] NULL,
		[DATA_TYPE2] [nvarchar](128) NULL,
		[COLUMN_NAME2] [sysname] NULL,
		[CHARACTER_MAXIMUM_LENGTH2] [int] NULL,
		[NOTE] [varchar](500) NULL,
		[CreateDate] [datetime] NULL default getdate(),
		RowNbr int identity
	)

	END
	
		IF NOT EXISTS
	(
		SELECT name
		--FROM tempdb.dbo.sysobjects
		FROM sysobjects
		WHERE ID = OBJECT_ID(N'TBL_DIFF3')
	)
	BEGIN

		CREATE TABLE [dbo].[TBL_DIFF3](
		[table_name] [sysname] NOT NULL,
		[COLUMN_NAME] [sysname] NULL,
		[DATA_TYPE] [nvarchar](128) NULL,
		[CHARACTER_MAXIMUM_LENGTH] [nvarchar](50) NULL,
		[table_name2] [sysname] NULL,
		[DATA_TYPE2] [nvarchar](128) NULL,
		[COLUMN_NAME2] [sysname] NULL,
		[CHARACTER_MAXIMUM_LENGTH2] [int] NULL
		,[NOTE] varchar(500)
		,CreateDate datetime default getdate() ,
		RowNbr int identity
	)

	END

	IF NOT EXISTS
	(
		SELECT name
		--FROM tempdb.dbo.sysobjects
		FROM sysobjects
		WHERE ID = OBJECT_ID(N'TBL_DIFF4')
	)
	BEGIN

		CREATE TABLE [dbo].[TBL_DIFF4](
		[table_name] [sysname] NOT NULL,
		[COLUMN_NAME] [sysname] NULL,
		[DATA_TYPE] [nvarchar](128) NULL,
		[CHARACTER_MAXIMUM_LENGTH] [nvarchar](50) NULL,
		[table_name2] [sysname] NULL,
		[DATA_TYPE2] [nvarchar](128) NULL,
		[COLUMN_NAME2] [sysname] NULL,
		[CHARACTER_MAXIMUM_LENGTH2] [int] NULL
		,[NOTE] varchar(500)
		,CreateDate datetime default getdate() ,
		RowNbr int identity
	)

	END

	if (@NewRun = 1)
	BEGIN
		truncate table [TBL_DIFF1] ;
		truncate table [TBL_DIFF2] ;
		truncate table [TBL_DIFF3] ;
	END

	--DECLARE @LinkedDB as nvarchar(80), @LinkedTBL as nvarchar(80),@CurrDB as nvarchar(80), @CurrTBL as nvarchar(80) ;
	DECLARE @MySQL as nvarchar(2000) ;

	--set @LinkedDB = 'instrument' ;
	--set @LinkedTBL = 'SchemaChangeMonitor' ;
	--set @CurrDB = 'KenticoCMS_DEV' ;
	--set @CurrTBL = 'SchemaChangeMonitor'

	--select c1.table_name,c1.COLUMN_NAME,c1.DATA_TYPE , cast (c1.CHARACTER_MAXIMUM_LENGTH as nvarchar(50)) as CHARACTER_MAXIMUM_LENGTH, c2.table_name,c2.DATA_TYPE,c2.COLUMN_NAME, c2.CHARACTER_MAXIMUM_LENGTH
	--from KenticoCMS_DEV.[INFORMATION_SCHEMA].[COLUMNS] c1
	--left join instrument.[INFORMATION_SCHEMA].[COLUMNS] c2 on c1.TABLE_NAME=c2.TABLE_NAME
	--where c1.TABLE_NAME= @LinkedTBL and c2.TABLE_NAME = @CurrTBL
	--and C1.column_name = c2.column_name
	--and ((c1.data_type <> c2.DATA_TYPE) 
	--		OR (c1.data_type = c2.DATA_TYPE AND c1.CHARACTER_MAXIMUM_LENGTH <> c2.CHARACTER_MAXIMUM_LENGTH))
	
	--print ('Step04');

	Set @MySQL = 'INSERT INTO TBL_DIFF1 (table_name, COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH, table_name2, DATA_TYPE2, COLUMN_NAME2, CHARACTER_MAXIMUM_LENGTH2, Note) ' ; 
	Set @MySQL = @MySql + 'select c1.table_name, c1.COLUMN_NAME, c1.DATA_TYPE , cast (c1.CHARACTER_MAXIMUM_LENGTH as nvarchar(50)) as CHARACTER_MAXIMUM_LENGTH, c2.table_name as table_name2 ,c2.DATA_TYPE as DATA_TYPE2 ,c2.COLUMN_NAME as COLUMN_NAME2, c2.CHARACTER_MAXIMUM_LENGTH as CHARACTER_MAXIMUM_LENGTH2, ''Data Types or Data Length Differ'' ' ;
	Set @MySQL = @MySQL + 'from ['+@LinkedSVR+'].['+@LinkedDB+'].[INFORMATION_SCHEMA].[COLUMNS] c1 ' ;
	Set @MySQL = @MySQL + 'left join ' + @CurrDB + '.[INFORMATION_SCHEMA].[COLUMNS] c2 on c1.TABLE_NAME = c2.TABLE_NAME ' ;
	Set @MySQL = @MySQL + 'where c1.TABLE_NAME= ''' + @LinkedTBL + ''' and c2.TABLE_NAME = ''' + @CurrTBL + ''' '  ;
	Set @MySQL = @MySQL + 'and C1.column_name = c2.column_name '; 
	Set @MySQL = @MySQL + 'and ((c1.data_type <> c2.DATA_TYPE) ' ;
	Set @MySQL = @MySQL + '		OR (c1.data_type = c2.DATA_TYPE AND c1.CHARACTER_MAXIMUM_LENGTH <> c2.CHARACTER_MAXIMUM_LENGTH))';
	
	exec (@MySql) ;
	
	--print ('Step05');

	set @MySQL = '' ;

	Set @MySQL = 'INSERT INTO TBL_DIFF2 (table_name, COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH, table_name2, DATA_TYPE2, COLUMN_NAME2, CHARACTER_MAXIMUM_LENGTH2, Note) ' ;
	set @MySQL = @MySQL + 'SELECT c1.TABLE_NAME, c1.COLUMN_NAME, c1.DATA_TYPE, '''+@CurrDB+''' as DBNAME, ''MISSING'' as C1, ''NA'' as C2 , ''NA'' as C3, 0 as I1, ''Column ''+c1.COLUMN_NAME+'' Missing in: '+@CurrDB+ ' / ' + @CurrTBL + ' ''  ';
	set @MySQL = @MySQL + ' FROM  ['+@LinkedSVR+'].[' + @LinkedDB +'].INFORMATION_SCHEMA.COLUMNS AS c1 ' ; 
	set @MySQL = @MySQL + ' WHERE  C1.table_name = '''+@CurrTBL+''' ' ; 
	set @MySQL = @MySQL + ' 	AND c1.column_name not in ' ;
	set @MySQL = @MySQL + ' 	(select column_name from '+@CurrDB+'.INFORMATION_SCHEMA.columns C2 where C2.table_name = '''+@LinkedTBL+''') ' ; 
	
	exec (@MySql) ;

	--print ('Step06');

	Set @MySQL = 'INSERT INTO TBL_DIFF3 (table_name, COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH, table_name2, DATA_TYPE2, COLUMN_NAME2, CHARACTER_MAXIMUM_LENGTH2, Note) ' ; 
	set @MySQL = @MySQL + 'SELECT c1.TABLE_NAME, c1.COLUMN_NAME, c1.DATA_TYPE, '''+@LinkedDB+''' as DBNAME, ''MISSING'' as C1, ''NA'' as C2, ''NA'' as C3, -1 as I1, ''Column ''+c1.COLUMN_NAME+'' Missing in: '+@LinkedDB+ ' / ' + @LinkedTBL + ' ''  ';
	set @MySQL = @MySQL + ' FROM ['+@CurrDB+'].INFORMATION_SCHEMA.COLUMNS as C1 ' ;
	set @MySQL = @MySQL + ' WHERE  C1.table_name = ''' + @CurrTBL + ''' '  ;
	set @MySQL = @MySQL + ' AND c1.column_name not in ' ; 
	set @MySQL = @MySQL + ' (select column_name from ['+@LinkedSVR+'].['+@LinkedDB+'].INFORMATION_SCHEMA.columns C2 where C2.table_name = '''+@LinkedTBL+''') ' ;
	exec (@MySql) ;

	--print ('Step07');

	set @S  = 'SELECT @retval = count(*) FROM sys.servers WHERE name = @TgtSVR ' ;
	set @ParmDefinition  = N'@TgtSVR nvarchar(100), @retval bit OUTPUT' ;
	exec sp_executesql @S, @ParmDefinition, @TgtSVR = @LinkedSVR, @retval = @iRetval OUTPUT ;
	set @iCnt = (select @iRetval) ;
	IF (@iCnt = 1)
		EXEC master.sys.sp_dropserver @LinkedSVR,'droplogins'  ;

	--print ('Step08');
	
	if not exists(Select name from sys.views where name = 'view_SchemaDiff')
	BEGIN
		declare @sTxt as nvarchar(2000) = '' ;
		set @sTxt = @sTxt + 'Create view view_SchemaDiff AS ' ;
		set @sTxt = @sTxt + 'Select * from TBL_DIFF1 ' ;
		set @sTxt = @sTxt + 'union ' ;
		set @sTxt = @sTxt + 'Select * from TBL_DIFF2  ' ;
		set @sTxt = @sTxt + 'union ' ;
		set @sTxt = @sTxt + 'Select * from TBL_DIFF3  ' ;
		exec (@sTxt) ;
		print ('Created view view_SchemaDiff.') ;
	END

	--Select * from TBL_DIFF1 
	--union
	--Select * from TBL_DIFF2 
	--union
	--Select * from TBL_DIFF3 

	print ('To see "deltas" - select * from view_SchemaDiff');
	print ('_________________________________________________');
END

GO

print('Created Proc_EDW_Compare_Tables');

GO

	--drop table [TBL_DIFF1] ;
--drop table [TBL_DIFF2] ;
--drop table [TBL_DIFF3] ;
--drop table [TBL_DIFF4] ;

GO
print('Creating Proc_EDW_Compare_Views') ;
GO


if exists (Select name from sys.procedures where name = 'Proc_EDW_Compare_Views')
BEGIN
	drop procedure Proc_EDW_Compare_Views ;
END
GO

Create procedure Proc_EDW_Compare_Views 
(	@LinkedSVR as nvarchar(254) 
	,@LinkedDB as nvarchar(80), @LinkedVIEW as nvarchar(80)
	,@CurrDB as nvarchar(80), @CurrVIEW as nvarchar(80)
	,@NewRun as int
)
as
BEGIN

	--set @LinkedSVR = 'hfit-sqlUAT.cloudapp.net,3' ;
	--set @LinkedDB = 'KenticoCMS_ProdStaging' ;
	--set @LinkedVIEW = 'SchemaChangeMonitor' ;
	--set @CurrDB = 'KenticoCMS_DEV' ;
	--set @CurrVIEW = 'SchemaChangeMonitor'

	--exec Proc_EDW_Compare_Views 'hfit-sqlUAT.cloudapp.net,3', 'KenticoCMS_ProdStaging', 'HFit_HealthAssessment', 'KenticoCMS_DEV', 'HFit_HealthAssessment', 0
	--exec Proc_EDW_Compare_Views 'hfit-sqlUAT.cloudapp.net,3', 'KenticoCMS_ProdStaging', 'SchemaChangeMonitor', 'KenticoCMS_DEV', 'HFit_HealthAssessment', 1
	--exec Proc_EDW_Compare_Views 'hfit-sqlUAT.cloudapp.net,3', 'KenticoCMS_ProdStaging', 'SchemaChangeMonitor', 'KenticoCMS_DEV', 'SchemaChangeMonitor', 1
	--exec Proc_EDW_Compare_Views 'hfit-sqlUAT.cloudapp.net,3', 'KenticoCMS_ProdStaging', 'view_EDW_HealthAssesment', 'KenticoCMS_DEV', 'view_EDW_HealthAssesment', 1

	DECLARE @ParmDefinition  as nvarchar(500) ;
	DECLARE @retval int   = 0 ; 
	DECLARE @S  as nvarchar(250) = '' ;
	DECLARE @SVR as varchar(200) = @LinkedSVR ;
	DECLARE @iCnt as int ;
	DECLARE @iRetval as int = 0 ; 
	DECLARE @Note as nvarchar(1000) = '' ;
	
	set @S  = 'SELECT @retval = count(*) FROM sys.servers WHERE name = @TgtSVR ' ;
	set @ParmDefinition  = N'@TgtSVR nvarchar(100), @retval bit OUTPUT' ;
	exec sp_executesql @S, @ParmDefinition, @TgtSVR = @LinkedSVR, @retval = @iRetval OUTPUT ;
	set @iCnt = (select @iRetval) ;
	IF (@iCnt = 1)
		EXEC master.sys.sp_dropserver @LinkedSVR,'droplogins'  ;
			
	EXEC sp_addlinkedserver @LinkedSVR, 'SQL Server' ;
	
	set @S  = 'select @retval = count(*) from ['+@LinkedSVR+'].['+@LinkedDB+'].sys.views where NAME = @TgtVIEW ' ;
	set @ParmDefinition  = N'@TgtVIEW nvarchar(100), @retval int OUTPUT' ;
	exec sp_executesql @S, @ParmDefinition, @TgtVIEW = @LinkedVIEW, @retval = @iRetval OUTPUT ;
	set @iCnt = (select @iRetval) ;
	
	--print ('Step01');
	if (@iCnt = 0)
	BEGIN
		print(@LinkedVIEW + ' : VIEW does not exist on server ' +@LinkedSVR + ' in database ' + @LinkedDB + '.') ;

		declare @SSQL as nvarchar(2000) = '' ;
		declare @msg as nvarchar(500) = '' ;
		set @msg = @LinkedVIEW + ' : VIEW does not exist on server ' +@LinkedSVR + ' in database ' + @LinkedDB + '.' ;
		Set @SSQL = 'INSERT INTO TBL_DIFF1 (table_name, COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH, table_name2, DATA_TYPE2, COLUMN_NAME2, CHARACTER_MAXIMUM_LENGTH2, Note) ' ; 
		Set @SSQL = @SSQL + 'VALUES ( ';
		Set @SSQL = @SSQL + '''' + @CurrVIEW + ''', null, null , null, null ,null,null, null, '''+@msg+''' ' ;
		Set @SSQL = @SSQL + ')';
		
		exec (@SSQL) ;

		return ;
	END
		
	IF NOT EXISTS
	(
		SELECT name
		--FROM tempdb.dbo.sysobjects
		FROM sysobjects
		WHERE ID = OBJECT_ID(N'TBL_DIFF1')
	)
	BEGIN

		CREATE TABLE [dbo].[TBL_DIFF1](
		[table_name] [sysname] NOT NULL,
		[COLUMN_NAME] [sysname] NULL,
		[DATA_TYPE] [nvarchar](128) NULL,
		[CHARACTER_MAXIMUM_LENGTH] [nvarchar](50) NULL,
		[table_name2] [sysname] NULL,
		[DATA_TYPE2] [nvarchar](128) NULL,
		[COLUMN_NAME2] [sysname] NULL,
		[CHARACTER_MAXIMUM_LENGTH2] [int] NULL
		,[NOTE] varchar(500)
		,[CreateDate] [datetime] NULL default getdate(),
		RowNbr int identity
	)

	END

	IF NOT EXISTS
	(
		SELECT name
		--FROM tempdb.dbo.sysobjects
		FROM sysobjects
		WHERE ID = OBJECT_ID(N'TBL_DIFF2')
	)
	BEGIN

		CREATE TABLE [dbo].[TBL_DIFF2](
		[table_name] [sysname] NOT NULL,
		[COLUMN_NAME] [sysname] NULL,
		[DATA_TYPE] [nvarchar](128) NULL,
		[CHARACTER_MAXIMUM_LENGTH] [nvarchar](50) NULL,
		[table_name2] [sysname] NULL,
		[DATA_TYPE2] [nvarchar](128) NULL,
		[COLUMN_NAME2] [sysname] NULL,
		[CHARACTER_MAXIMUM_LENGTH2] [int] NULL
		,[NOTE] varchar(500),
		RowNbr int identity
	)

	END
	
		IF NOT EXISTS
	(
		SELECT name
		--FROM tempdb.dbo.sysobjects
		FROM sysobjects
		WHERE ID = OBJECT_ID(N'TBL_DIFF3')
	)
	BEGIN

		CREATE TABLE [dbo].[TBL_DIFF3](
		[table_name] [sysname] NOT NULL,
		[COLUMN_NAME] [sysname] NULL,
		[DATA_TYPE] [nvarchar](128) NULL,
		[CHARACTER_MAXIMUM_LENGTH] [nvarchar](50) NULL,
		[table_name2] [sysname] NULL,
		[DATA_TYPE2] [nvarchar](128) NULL,
		[COLUMN_NAME2] [sysname] NULL,
		[CHARACTER_MAXIMUM_LENGTH2] [int] NULL
		,[NOTE] varchar(500)
		,[CreateDate] [datetime] NULL default getdate(),
		RowNbr int identity
	)

	END

	IF NOT EXISTS
	(
		SELECT name
		--FROM tempdb.dbo.sysobjects
		FROM sysobjects
		WHERE ID = OBJECT_ID(N'TBL_DIFF4')
	)
	BEGIN

		CREATE TABLE [dbo].[TBL_DIFF4](
		[table_name] [sysname] NOT NULL,
		[COLUMN_NAME] [sysname] NULL,
		[DATA_TYPE] [nvarchar](128) NULL,
		[CHARACTER_MAXIMUM_LENGTH] [nvarchar](50) NULL,
		[table_name2] [sysname] NULL,
		[DATA_TYPE2] [nvarchar](128) NULL,
		[COLUMN_NAME2] [sysname] NULL,
		[CHARACTER_MAXIMUM_LENGTH2] [int] NULL
		,[NOTE] varchar(500)
		,[CreateDate] [datetime] NULL default getdate(),
		RowNbr int identity
	)

	END

	if (@NewRun = 1)
	BEGIN
		truncate table [TBL_DIFF1] ;
		truncate table [TBL_DIFF2] ;
		truncate table [TBL_DIFF3] ;
	END

	--DECLARE @LinkedDB as nvarchar(80), @LinkedVIEW as nvarchar(80),@CurrDB as nvarchar(80), @CurrVIEW as nvarchar(80) ;
	DECLARE @MySQL as nvarchar(2000) ;

	--set @LinkedDB = 'instrument' ;
	--set @LinkedVIEW = 'SchemaChangeMonitor' ;
	--set @CurrDB = 'KenticoCMS_DEV' ;
	--set @CurrVIEW = 'SchemaChangeMonitor'

	--select c1.table_name,c1.COLUMN_NAME,c1.DATA_TYPE , cast (c1.CHARACTER_MAXIMUM_LENGTH as nvarchar(50)) as CHARACTER_MAXIMUM_LENGTH, c2.table_name,c2.DATA_TYPE,c2.COLUMN_NAME, c2.CHARACTER_MAXIMUM_LENGTH
	--from KenticoCMS_DEV.[INFORMATION_SCHEMA].[COLUMNS] c1
	--left join instrument.[INFORMATION_SCHEMA].[COLUMNS] c2 on c1.TABLE_NAME=c2.TABLE_NAME
	--where c1.TABLE_NAME= @LinkedVIEW and c2.TABLE_NAME = @CurrVIEW
	--and C1.column_name = c2.column_name
	--and ((c1.data_type <> c2.DATA_TYPE) 
	--		OR (c1.data_type = c2.DATA_TYPE AND c1.CHARACTER_MAXIMUM_LENGTH <> c2.CHARACTER_MAXIMUM_LENGTH))
	
	--print ('Step04');

	Set @MySQL = 'INSERT INTO TBL_DIFF1 (table_name, COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH, table_name2, DATA_TYPE2, COLUMN_NAME2, CHARACTER_MAXIMUM_LENGTH2, Note) ' ; 
	Set @MySQL = @MySql + 'select c1.table_name, c1.COLUMN_NAME, c1.DATA_TYPE , cast (c1.CHARACTER_MAXIMUM_LENGTH as nvarchar(50)) as CHARACTER_MAXIMUM_LENGTH, c2.table_name as table_name2 ,c2.DATA_TYPE as DATA_TYPE2 ,c2.COLUMN_NAME as COLUMN_NAME2, c2.CHARACTER_MAXIMUM_LENGTH as CHARACTER_MAXIMUM_LENGTH2, ''Data Types or Data Length Differ'' ' ;
	Set @MySQL = @MySQL + 'from ['+@LinkedSVR+'].['+@LinkedDB+'].[INFORMATION_SCHEMA].[COLUMNS] c1 ' ;
	Set @MySQL = @MySQL + 'left join ' + @CurrDB + '.[INFORMATION_SCHEMA].[COLUMNS] c2 on c1.TABLE_NAME = c2.TABLE_NAME ' ;
	Set @MySQL = @MySQL + 'where c1.TABLE_NAME= ''' + @LinkedVIEW + ''' and c2.TABLE_NAME = ''' + @CurrVIEW + ''' '  ;
	Set @MySQL = @MySQL + 'and C1.column_name = c2.column_name '; 
	Set @MySQL = @MySQL + 'and ((c1.data_type <> c2.DATA_TYPE) ' ;
	Set @MySQL = @MySQL + '		OR (c1.data_type = c2.DATA_TYPE AND c1.CHARACTER_MAXIMUM_LENGTH <> c2.CHARACTER_MAXIMUM_LENGTH))';
	
	exec (@MySql) ;
	
	--print ('Step05');

	set @MySQL = '' ;

	Set @MySQL = 'INSERT INTO TBL_DIFF2 (table_name, COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH, table_name2, DATA_TYPE2, COLUMN_NAME2, CHARACTER_MAXIMUM_LENGTH2, Note) ' ;
	set @MySQL = @MySQL + 'SELECT c1.TABLE_NAME, c1.COLUMN_NAME, c1.DATA_TYPE, '''+@CurrDB+''' as DBNAME, ''MISSING'' as C1, ''NA'' as C2 , ''NA'' as C3, 0 as I1, ''Column ''+c1.COLUMN_NAME+'' Missing in: '+@CurrDB+'/' + @CurrVIEW +' ''  ';
	set @MySQL = @MySQL + ' FROM  ['+@LinkedSVR+'].[' + @LinkedDB +'].INFORMATION_SCHEMA.COLUMNS AS c1 ' ; 
	set @MySQL = @MySQL + ' WHERE  C1.table_name = '''+@CurrVIEW+''' ' ; 
	set @MySQL = @MySQL + ' 	AND c1.column_name not in ' ;
	set @MySQL = @MySQL + ' 	(select column_name from '+@CurrDB+'.INFORMATION_SCHEMA.columns C2 where C2.table_name = '''+@LinkedVIEW+''') ' ; 
	
	print (@MySql);
	exec (@MySql) ;

	--print ('Step06');

	Set @MySQL = 'INSERT INTO TBL_DIFF3 (table_name, COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH, table_name2, DATA_TYPE2, COLUMN_NAME2, CHARACTER_MAXIMUM_LENGTH2, Note) ' ; 
	set @MySQL = @MySQL + 'SELECT c1.TABLE_NAME, c1.COLUMN_NAME, c1.DATA_TYPE, '''+@LinkedDB+''' as DBNAME, ''MISSING'' as C1, ''NA'' as C2, ''NA'' as C3, -1 as I1, ''Column ''+c1.COLUMN_NAME+'' Missing in: '+@LinkedDB+'/'+@LinkedVIEW +' ''  ';
	set @MySQL = @MySQL + ' FROM ['+@CurrDB+'].INFORMATION_SCHEMA.COLUMNS as C1 ' ;
	set @MySQL = @MySQL + ' WHERE  C1.table_name = ''' + @CurrVIEW + ''' '  ;
	set @MySQL = @MySQL + ' AND c1.column_name not in ' ; 
	set @MySQL = @MySQL + ' (select column_name from ['+@LinkedSVR+'].['+@LinkedDB+'].INFORMATION_SCHEMA.columns C2 where C2.table_name = '''+@LinkedVIEW+''') ' ;
	exec (@MySql) ;

	--print ('Step07');

	set @S  = 'SELECT @retval = count(*) FROM sys.servers WHERE name = @TgtSVR ' ;
	set @ParmDefinition  = N'@TgtSVR nvarchar(100), @retval bit OUTPUT' ;
	exec sp_executesql @S, @ParmDefinition, @TgtSVR = @LinkedSVR, @retval = @iRetval OUTPUT ;
	set @iCnt = (select @iRetval) ;
	IF (@iCnt = 1)
		EXEC master.sys.sp_dropserver @LinkedSVR,'droplogins'  ;

	--print ('Step08');
	if not exists(Select name from sys.views where name = 'view_SchemaDiff')
	BEGIN
		declare @sTxt as nvarchar(2000) = '' ;
		set @sTxt = @sTxt + 'Create view view_SchemaDiff AS ' ;
		set @sTxt = @sTxt + 'Select * from TBL_DIFF1 ' ;
		set @sTxt = @sTxt + 'union ' ;
		set @sTxt = @sTxt + 'Select * from TBL_DIFF2  ' ;
		set @sTxt = @sTxt + 'union ' ;
		set @sTxt = @sTxt + 'Select * from TBL_DIFF3  ' ;
		exec (@sTxt) ;
		print ('Created view view_SchemaDiff.') ;
	END

	--Select * from TBL_DIFF1 
	--union
	--Select * from TBL_DIFF2 
	--union
	--Select * from TBL_DIFF3 

	print ('To see "deltas" - select * from view_SchemaDiff');
	print ('_________________________________________________');

	--print ('Step09');
END


GO
print('Created Proc_EDW_Compare_Views') ;
GO


GO
print('Creating udfGetCurrentIP') ;
GO

if exists(select name from sys.objects where name = 'udfGetCurrentIP')
BEGIN
	drop function udfGetCurrentIP ;
END

GO

CREATE FUNCTION [dbo].[udfGetCurrentIP] ()
RETURNS varchar(255)
AS
BEGIN
	--*********************************************************
	--WDM 03.21.2009 Get the IP address of the current client.
	--Used to track a DBA/Developer IP address when change is 
	--applied to a table or view.
	--*********************************************************
    DECLARE @IP_Address varchar(255);
 
    SELECT @IP_Address = client_net_address
    FROM sys.dm_exec_connections
    WHERE Session_id = @@SPID;
 
    Return @IP_Address;
END

--Same as above
--SELECT CONVERT(char(15), CONNECTIONPROPERTY('client_net_address'))
GO
print('Created udfGetCurrentIP') ;
GO
GO

--print('CHANGING to the instrument DB.');
--GO

--use instrument
--go

print('Processing trgSchemaMonitor.sql');
go

if exists(Select name from sys.tables where name = 'SchemaChangeMonitor')
BEGIN
	print('Table SchemaChangeMonitor found, continuing.');
END

if NOT exists(Select name from sys.tables where name = 'SchemaChangeMonitor')
BEGIN
	print('Creating table SchemaChangeMonitor.');
	--drop TABLE dbo.SchemaChangeMonitor 
	--go
	CREATE TABLE dbo.SchemaChangeMonitor (PostTime datetime, 
		DB_User nvarchar(100), 
		IP_Address nvarchar(50), 
		CUR_User nvarchar(80), 
		OBJ nvarchar(50), 
		Event nvarchar(100), 
		TSQL nvarchar(2000));

	CREATE NONCLUSTERED INDEX [PI_SchemaChangeMonitor] ON [dbo].[SchemaChangeMonitor]
	(
		[OBJ] ASC
	)

	--GRANT SELECT ON [dbo].[SchemaChangeMonitor] TO [platformuser_dev] ;
	--GRANT INSERT ON [dbo].[SchemaChangeMonitor] TO [platformuser_dev] ;
	--GRANT DELETE ON [dbo].[SchemaChangeMonitor] TO [platformuser_dev] ;
	--GRANT UPDATE ON [dbo].[SchemaChangeMonitor] TO [platformuser_dev] ;

END
GO

if NOT exists(Select name from sys.tables where name = 'SchemaMonitorObjectName')
BEGIN
	print('Table SchemaMonitorObjectName FOUND, continuing');
END

if NOT exists(Select name from sys.tables where name = 'SchemaMonitorObjectName')
BEGIN
	print('Creating table SchemaMonitorObjectName');
	--drop TABLE dbo.SchemaMonitorObjectName
	--go
	CREATE TABLE dbo.SchemaMonitorObjectName (ObjectName nvarchar(250), 
		ObjectType nvarchar(25));

	CREATE unique CLUSTERED INDEX [PKI_SchemaMonitorObjectName] ON [dbo].[SchemaMonitorObjectName]
	(
		[ObjectName] ASC,
		[ObjectType] ASC
	)

	--GRANT SELECT ON [dbo].SchemaMonitorObjectName TO [platformuser_dev] ;
	--GRANT INSERT ON [dbo].SchemaMonitorObjectName TO [platformuser_dev] ;
	--GRANT DELETE ON [dbo].SchemaMonitorObjectName TO [platformuser_dev] ;
	--GRANT UPDATE ON [dbo].SchemaMonitorObjectName TO [platformuser_dev] ;
END
GO

if NOT exists(Select name from sys.tables where name = 'SchemaMonitorObjectNotify')
BEGIN
	print('Table SchemaMonitorObjectNotify FOUND, continuing');
END

if NOT exists(Select name from sys.tables where name = 'SchemaMonitorObjectNotify')
BEGIN
	print('Creating table SchemaMonitorObjectNotify');
	--drop TABLE dbo.SchemaMonitorObjectNotify
	--go
	CREATE TABLE dbo.SchemaMonitorObjectNotify (EmailAddr nvarchar(250))

	CREATE unique CLUSTERED INDEX [PCI_SchemaMonitorObjectNotify] ON [dbo].SchemaMonitorObjectNotify
	(
		[EmailAddr] ASC
	)

	--GRANT SELECT ON [dbo].SchemaMonitorObjectNotify TO [platformuser_dev] ;
	--GRANT INSERT ON [dbo].SchemaMonitorObjectNotify TO [platformuser_dev] ;
	--GRANT DELETE ON [dbo].SchemaMonitorObjectNotify TO [platformuser_dev] ;
	--GRANT UPDATE ON [dbo].SchemaMonitorObjectNotify TO [platformuser_dev] ;

	insert into dbo.SchemaMonitorObjectNotify (EmailAddr) values ('wdalemiller@gmail.com') ;
	insert into dbo.SchemaMonitorObjectNotify (EmailAddr) values ('dm@dmachicago.com') ;
	insert into dbo.SchemaMonitorObjectNotify (EmailAddr) values ('wdm@dmachicago.com') ;
END
GO

print('Creating view_SchemaChangeMonitor');
go
--DROP TRIGGER trgSchemaMonitor on DATABASE
--disable TRIGGER trgSchemaMonitor on DATABASE
--enable TRIGGER trgSchemaMonitor on DATABASE

if exists(Select name from sys.views where name = 'view_SchemaChangeMonitor')
BEGIN
	print('Creating view_SchemaChangeMonitor, continuing');
	drop view view_SchemaChangeMonitor ;
END
GO

create view view_SchemaChangeMonitor
	as
		SELECT PostTime, DB_User, IP_Address, CUR_User, Event, TSQL, OBJ
		FROM     SchemaChangeMonitor ;		
GO

	--GRANT SELECT ON  [dbo].view_SchemaChangeMonitor TO [platformuser_dev] ;
	--GRANT INSERT ON  [Schema].[Table] TO [User] ;
	--GRANT DELETE ON  [Schema].[Table] TO [User] ;
	--GRANT UPDATE ON  [Schema].[Table] TO [User] ;


print('Created view_SchemaChangeMonitor');
GO

--USE KenticoCMS_DEV
--GO

if exists(select name from sys.triggers where name = 'trgSchemaMonitor')
Begin 
	print('creating trgSchemaMonitor');
	drop trigger trgSchemaMonitor ;
END
GO
print('Updating trgSchemaMonitor');
GO

CREATE TRIGGER trgSchemaMonitor
ON DATABASE 
FOR DDL_DATABASE_LEVEL_EVENTS 
AS
	DECLARE @data XML ;
	Declare @IPADDR varchar(50) ;
	DECLARE @CUR_User varchar(50);

	SET @CUR_User = SYSTEM_USER;
	set @IPADDR = (SELECT CONVERT(char(15), CONNECTIONPROPERTY('client_net_address')));
	SET @data = EVENTDATA();

	INSERT SchemaChangeMonitor 
	   (PostTime, DB_User, IP_Address , CUR_User, OBJ, Event, TSQL) 
	   VALUES 
	   (
	   GETDATE(), 
	   CONVERT(nvarchar(100), CURRENT_USER), 
	   @IPADDR,
	   @CUR_User,
	   @data.value('(/EVENT_INSTANCE/ObjectName)[1]', 'nvarchar(100)'), 
	   @data.value('(/EVENT_INSTANCE/EventType)[1]', 'nvarchar(100)'), 
	   @data.value('(/EVENT_INSTANCE/TSQLCommand)[1]', 'nvarchar(2000)') 
	   ) ;

	--THIS WILL DELETE records older than 90 days.
	--delete from SchemaChangeMonitor where PostTime < getdate() - 90 ;
GO

--grant execute on trgSchemaMonitor to PUBLIC ;
--go

--grant execute on sp_SchemaMonitorReport to platformuser_dev ; 
--GO

print('Processed trgSchemaMonitor.sql');


--***************************************************************
--***************************************************************


GO
print ('Creating procedure sp_SchemaMonitorReport ') ;
GO

if exists(select name from sys.objects where name = 'sp_SchemaMonitorReport')
BEGIN 
	drop procedure sp_SchemaMonitorReport ;
END
GO

CREATE proc [dbo].[sp_SchemaMonitorReport]
as
BEGIN
	--print('Start') ;

	truncate table SchemaChangeMonitor_rptData ;

	declare deltas cursor for 
		SELECT PostTime, DB_User, IP_Address, CUR_User, Event, TSQL, OBJ, RowNbr
		FROM     SchemaChangeMonitor
		where PostTime between getdate()-1 and getdate()
		and [Event] in (select [Event] from SchemaChangeMonitorEvent)
		ORDER BY OBJ, PostTime ;
	
	declare @PostTime datetime ;
	declare @DB_User nvarchar(50) ;
	declare @IP_Address nvarchar(50) ;
	declare @CUR_User nvarchar(50) ;
	declare @Event nvarchar(50) ;
	declare @TSQL nvarchar(4000) ;
	declare @OBJ nvarchar(50) ;
	declare @DisplayOrder int ;
	declare @RowNbr int ;
	declare @DOrder int ;

	declare @onerecipient varchar(80) ;
	declare @allrecipients varchar(4000) = '' ;
	declare @fromDate varchar(50) = cast(getdate()-1 as varchar(50)) ;
	declare @toDate varchar(50) = cast(getdate() as varchar(50)) ;
	declare @subj varchar(10) = 'Schema Mods between ' + @fromDate + ' and ' + @toDate ;

	open deltas;
	fetch next from deltas into @PostTime, @DB_User, @IP_Address, @CUR_User, @Event, @TSQL, @OBJ, @RowNbr ;
	while (@@fetch_status=0)
	begin
			set @DOrder = 1 ; 
			insert into SchemaChangeMonitor_rptData (label,sText,DisplayOrder,RowNbr) 
				values ('OBJ',@OBJ,@DOrder,@RowNbr);
			set @DOrder = 2  ; 
			insert into SchemaChangeMonitor_rptData (label,sText,DisplayOrder,RowNbr) 
				values ('Event',@Event,@DOrder,@RowNbr);
			set @DOrder = 3  ; 
			insert into SchemaChangeMonitor_rptData (label,sText,DisplayOrder,RowNbr) 
				values ('TSQL',@TSQL,@DOrder,@RowNbr);

			set @DOrder = @DOrder +1  ; 
			insert into SchemaChangeMonitor_rptData (label,sText,DisplayOrder,RowNbr) 
				values ('PostTime',@PostTime,@DOrder,@RowNbr);
			set @DOrder = @DOrder +1  ; 
			insert into SchemaChangeMonitor_rptData (label,sText,DisplayOrder,RowNbr) 
				values ('IP_Address',@IP_Address,@DOrder,@RowNbr);
			set @DOrder = @DOrder +1  ; 
			insert into SchemaChangeMonitor_rptData (label,sText,DisplayOrder,RowNbr) 
				values ('DB_User',@DB_User,@DOrder,@RowNbr);
			set @DOrder = @DOrder +1  ; 
			insert into SchemaChangeMonitor_rptData (label,sText,DisplayOrder,RowNbr) 
				values ('CUR_User',@CUR_User,@DOrder,@RowNbr);
			set @DOrder = @DOrder +1  ; 
			insert into SchemaChangeMonitor_rptData (label,sText,DisplayOrder,RowNbr) 
				values ('END','******************************',@DOrder,@RowNbr);

			fetch next from deltas into @PostTime, @DB_User, @IP_Address, @CUR_User, @Event, @TSQL, @OBJ, @RowNbr ;
	end
	close deltas;
	deallocate deltas;

	declare getemails cursor for 
		select EmailAddr from SchemaMonitorObjectNotify ;

	open getemails;
	fetch next from getemails into @onerecipient;
	while (@@fetch_status=0)
	begin
			set @allrecipients = @allrecipients + @onerecipient+';'
			fetch next from getemails into @onerecipient;
	end
	close getemails;
	deallocate getemails;

	print ('Report Sent To: ' + @allrecipients);

		EXEC msdb..sp_send_dbmail
		  @profile_name = 'databaseBot',
		  @recipients = @allrecipients,
		  @subject = @subj,
		  @body = 'Modified Items Below.',
		  @execute_query_database = 'msdb',
		  --@query = 'SELECT distinct OBJ, Event, CUR_User, IP_Address, TSQL FROM KenticoCMS_DEV..SchemaChangeMonitor where PostTime between getdate()- 1 and getdate()'
		  @query = 'select * from KenticoCMS_DEV..SchemaChangeMonitor_rptData'
		  
END

GO
print ('Created sp_SchemaMonitorReport') ;
GO



GO
print('Processing Job SchemaMonitorReport (wdm)');
GO

USE [msdb]
GO

DECLARE @jobId binary(16)

SELECT @jobId = job_id FROM msdb.dbo.sysjobs WHERE (name = N'SchemaMonitorReport')
IF (@jobId IS NOT NULL)
BEGIN
	print('Updating Job SchemaMonitorReport');
    EXEC msdb.dbo.sp_delete_job @jobId ;
END
GO

/****** Object:  Job [SchemaMonitorReport]    Script Date: 10/17/2014 9:48:45 AM ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Uncategorized (Local)]]]    Script Date: 10/17/2014 9:48:45 AM ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'SchemaMonitorReport', 
		@enabled=1, 
		@notify_level_eventlog=2, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'dmiller', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [execute sp_SchemaMonitorReport]    Script Date: 10/17/2014 9:48:46 AM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'execute sp_SchemaMonitorReport', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'exec sp_SchemaMonitorReport', 
		@database_name=N'KenticoCMS_DEV', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'SchemaMonitorReport Schedule', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20141017, 
		@active_end_date=99991231, 
		@active_start_time=220000, 
		@active_end_time=235959, 
		@schedule_uid=N'd64376a9-39f9-4344-b403-5526b03d70d7'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'SchemaMonitorReport Schedule', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20141017, 
		@active_end_date=99991231, 
		@active_start_time=220000, 
		@active_end_time=235959, 
		@schedule_uid=N'37dd0949-b104-47c6-864c-2df7b166d28f'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:

GO

print('Job SchemaMonitorReport created.');

GO

--***************************************************************
--***************************************************************

--exec Proc_EDW_Compare_MASTER 'hfit-sqlUAT.cloudapp.net,3', 'KenticoCMS_ProdStaging', 'KenticoCMS_DEV' 
GO
print ('Creating Proc_EDW_Compare_MASTER') ;
go 

if exists(select name from sys.procedures where name = 'Proc_EDW_Compare_MASTER')
BEGIN
	drop procedure Proc_EDW_Compare_MASTER ;
END
go

create proc Proc_EDW_Compare_MASTER (@LinkedSVR as nvarchar(100),
			@LinkedDB as nvarchar(100),
			@CurrDB as nvarchar(100))
as
BEGIN
	--DECLARE @LinkedSVR as nvarchar(254) ;
	--DECLARE @LinkedDB as nvarchar(80);
	DECLARE @LinkedVIEW as nvarchar(80);
	--DECLARE @CurrDB as nvarchar(80);
	DECLARE @CurrVIEW as nvarchar(80);
	DECLARE @NewRun as int = 0 ;

	--set @LinkedSVR = 'hfit-sqlUAT.cloudapp.net,3' ;
	--set @LinkedDB = 'KenticoCMS_ProdStaging' ;
	set @LinkedVIEW = 'SchemaChangeMonitor' ;
	--set @CurrDB = 'KenticoCMS_DEV' ;
	set @CurrVIEW = 'SchemaChangeMonitor'

	set @NewRun = 1 ;

	Set @LinkedVIEW = 'CMS_Class' ;
	Set @CurrVIEW = 'CMS_Class' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO

	set @NewRun = 0 ;

	Set @LinkedVIEW = 'CMS_Document' ;
	Set @CurrVIEW = 'CMS_Document' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'CMS_Site' ;
	Set @CurrVIEW = 'CMS_Site' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'CMS_Tree' ;
	Set @CurrVIEW = 'CMS_Tree' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'CMS_User' ;
	Set @CurrVIEW = 'CMS_User' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'CMS_UserSettings' ;
	Set @CurrVIEW = 'CMS_UserSettings' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'CMS_UserSite' ;
	Set @CurrVIEW = 'CMS_UserSite' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'COM_SKU' ;
	Set @CurrVIEW = 'COM_SKU' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'EDW_HealthAssessment' ;
	Set @CurrVIEW = 'EDW_HealthAssessment' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'EDW_HealthAssessmentDefinition' ;
	Set @CurrVIEW = 'EDW_HealthAssessmentDefinition' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'HFit_Account' ;
	Set @CurrVIEW = 'HFit_Account' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'HFit_Coaches' ;
	Set @CurrVIEW = 'HFit_Coaches' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'HFit_Company' ;
	Set @CurrVIEW = 'HFit_Company' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'HFit_Goal' ;
	Set @CurrVIEW = 'HFit_Goal' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'HFit_GoalOutcome' ;
	Set @CurrVIEW = 'HFit_GoalOutcome' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'HFit_HACampaign' ;
	Set @CurrVIEW = 'HFit_HACampaign' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'HFit_HealthAssesmentMatrixQuestion' ;
	Set @CurrVIEW = 'HFit_HealthAssesmentMatrixQuestion' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'HFit_HealthAssesmentModule' ;
	Set @CurrVIEW = 'HFit_HealthAssesmentModule' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'HFit_HealthAssesmentMultipleChoiceQuestion' ;
	Set @CurrVIEW = 'HFit_HealthAssesmentMultipleChoiceQuestion' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'HFit_HealthAssesmentPredefinedAnswer' ;
	Set @CurrVIEW = 'HFit_HealthAssesmentPredefinedAnswer' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'HFit_HealthAssesmentRiskArea' ;
	Set @CurrVIEW = 'HFit_HealthAssesmentRiskArea' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'HFit_HealthAssesmentRiskCategory' ;
	Set @CurrVIEW = 'HFit_HealthAssesmentRiskCategory' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'HFit_HealthAssesmentUserAnswers' ;
	Set @CurrVIEW = 'HFit_HealthAssesmentUserAnswers' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'HFit_HealthAssesmentUserModule' ;
	Set @CurrVIEW = 'HFit_HealthAssesmentUserModule' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'HFit_HealthAssesmentUserQuestion' ;
	Set @CurrVIEW = 'HFit_HealthAssesmentUserQuestion' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'HFit_HealthAssesmentUserQuestionGroupResults' ;
	Set @CurrVIEW = 'HFit_HealthAssesmentUserQuestionGroupResults' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'HFit_HealthAssesmentUserRiskArea' ;
	Set @CurrVIEW = 'HFit_HealthAssesmentUserRiskArea' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'HFit_HealthAssesmentUserRiskCategory' ;
	Set @CurrVIEW = 'HFit_HealthAssesmentUserRiskCategory' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'HFit_HealthAssesmentUserStarted' ;
	Set @CurrVIEW = 'HFit_HealthAssesmentUserStarted' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'HFit_HealthAssessment' ;
	Set @CurrVIEW = 'HFit_HealthAssessment' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'HFit_HealthAssessmentFreeForm' ;
	Set @CurrVIEW = 'HFit_HealthAssessmentFreeForm' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'HFit_LKP_Frequency' ;
	Set @CurrVIEW = 'HFit_LKP_Frequency' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'HFit_LKP_GoalStatus' ;
	Set @CurrVIEW = 'HFit_LKP_GoalStatus' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'HFit_LKP_RewardLevelType' ;
	Set @CurrVIEW = 'HFit_LKP_RewardLevelType' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'HFit_LKP_RewardTrigger' ;
	Set @CurrVIEW = 'HFit_LKP_RewardTrigger' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'HFit_LKP_RewardTriggerParameterOperator' ;
	Set @CurrVIEW = 'HFit_LKP_RewardTriggerParameterOperator' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'HFit_LKP_RewardType' ;
	Set @CurrVIEW = 'HFit_LKP_RewardType' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'HFit_LKP_UnitOfMeasure' ;
	Set @CurrVIEW = 'HFit_LKP_UnitOfMeasure' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'hfit_ppteligibility' ;
	Set @CurrVIEW = 'hfit_ppteligibility' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'HFit_RewardActivity' ;
	Set @CurrVIEW = 'HFit_RewardActivity' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'HFit_RewardException' ;
	Set @CurrVIEW = 'HFit_RewardException' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'HFit_RewardGroup' ;
	Set @CurrVIEW = 'HFit_RewardGroup' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'HFit_RewardLevel' ;
	Set @CurrVIEW = 'HFit_RewardLevel' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'HFit_RewardProgram' ;
	Set @CurrVIEW = 'HFit_RewardProgram' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'HFit_RewardsAwardUserDetail' ;
	Set @CurrVIEW = 'HFit_RewardsAwardUserDetail' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'HFit_RewardsUserActivityDetail' ;
	Set @CurrVIEW = 'HFit_RewardsUserActivityDetail' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'HFit_RewardsUserLevelDetail' ;
	Set @CurrVIEW = 'HFit_RewardsUserLevelDetail' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'HFit_RewardTrigger' ;
	Set @CurrVIEW = 'HFit_RewardTrigger' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'HFit_RewardTriggerParameter' ;
	Set @CurrVIEW = 'HFit_RewardTriggerParameter' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'HFit_Tobacco_Goal' ;
	Set @CurrVIEW = 'HFit_Tobacco_Goal' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'HFIT_Tracker' ;
	Set @CurrVIEW = 'HFIT_Tracker' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'HFit_TrackerBloodPressure' ;
	Set @CurrVIEW = 'HFit_TrackerBloodPressure' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'HFit_TrackerBloodSugarAndGlucose' ;
	Set @CurrVIEW = 'HFit_TrackerBloodSugarAndGlucose' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'HFit_TrackerBMI' ;
	Set @CurrVIEW = 'HFit_TrackerBMI' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'HFit_TrackerBodyFat' ;
	Set @CurrVIEW = 'HFit_TrackerBodyFat' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'HFit_TrackerBodyMeasurements' ;
	Set @CurrVIEW = 'HFit_TrackerBodyMeasurements' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'HFit_TrackerCardio' ;
	Set @CurrVIEW = 'HFit_TrackerCardio' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'HFit_TrackerCholesterol' ;
	Set @CurrVIEW = 'HFit_TrackerCholesterol' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'HFit_TrackerCollectionSource' ;
	Set @CurrVIEW = 'HFit_TrackerCollectionSource' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'HFit_TrackerDailySteps' ;
	Set @CurrVIEW = 'HFit_TrackerDailySteps' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'HFit_TrackerFlexibility' ;
	Set @CurrVIEW = 'HFit_TrackerFlexibility' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'HFit_TrackerFruits' ;
	Set @CurrVIEW = 'HFit_TrackerFruits' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'HFit_TrackerHbA1c' ;
	Set @CurrVIEW = 'HFit_TrackerHbA1c' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'HFit_TrackerHeight' ;
	Set @CurrVIEW = 'HFit_TrackerHeight' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'HFit_TrackerHighFatFoods' ;
	Set @CurrVIEW = 'HFit_TrackerHighFatFoods' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'HFit_TrackerHighSodiumFoods' ;
	Set @CurrVIEW = 'HFit_TrackerHighSodiumFoods' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'HFit_TrackerInstance_Tracker' ;
	Set @CurrVIEW = 'HFit_TrackerInstance_Tracker' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'HFit_TrackerMealPortions' ;
	Set @CurrVIEW = 'HFit_TrackerMealPortions' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'HFit_TrackerMedicalCarePlan' ;
	Set @CurrVIEW = 'HFit_TrackerMedicalCarePlan' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'HFit_TrackerRegularMeals' ;
	Set @CurrVIEW = 'HFit_TrackerRegularMeals' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'HFit_TrackerRestingHeartRate' ;
	Set @CurrVIEW = 'HFit_TrackerRestingHeartRate' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'HFit_TrackerShots' ;
	Set @CurrVIEW = 'HFit_TrackerShots' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'HFit_TrackerSitLess' ;
	Set @CurrVIEW = 'HFit_TrackerSitLess' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'HFit_TrackerSleepPlan' ;
	Set @CurrVIEW = 'HFit_TrackerSleepPlan' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'HFit_TrackerStrength' ;
	Set @CurrVIEW = 'HFit_TrackerStrength' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'HFit_TrackerStress' ;
	Set @CurrVIEW = 'HFit_TrackerStress' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'HFit_TrackerStressManagement' ;
	Set @CurrVIEW = 'HFit_TrackerStressManagement' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'HFit_TrackerSugaryDrinks' ;
	Set @CurrVIEW = 'HFit_TrackerSugaryDrinks' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'HFit_TrackerSugaryFoods' ;
	Set @CurrVIEW = 'HFit_TrackerSugaryFoods' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'HFit_TrackerTests' ;
	Set @CurrVIEW = 'HFit_TrackerTests' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'HFit_TrackerTobaccoFree' ;
	Set @CurrVIEW = 'HFit_TrackerTobaccoFree' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'HFit_TrackerVegetables' ;
	Set @CurrVIEW = 'HFit_TrackerVegetables' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'HFit_TrackerWater' ;
	Set @CurrVIEW = 'HFit_TrackerWater' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'HFit_TrackerWeight' ;
	Set @CurrVIEW = 'HFit_TrackerWeight' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'HFit_TrackerWholeGrains' ;
	Set @CurrVIEW = 'HFit_TrackerWholeGrains' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'HFit_UserGoal' ;
	Set @CurrVIEW = 'HFit_UserGoal' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'Tracker_EDW_Metadata' ;
	Set @CurrVIEW = 'Tracker_EDW_Metadata' ;
	EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO



	Set @LinkedVIEW = 'View_CMS_Tree_Joined' ;
	Set @CurrVIEW = 'View_CMS_Tree_Joined' ;
	EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'VIEW_CMS_Tree_Joined_Linked' ;
	Set @CurrVIEW = 'VIEW_CMS_Tree_Joined_Linked' ;
	EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'VIEW_CMS_Tree_Joined_Regular' ;
	Set @CurrVIEW = 'VIEW_CMS_Tree_Joined_Regular' ;
	EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'VIEW_COM_SKU' ;
	Set @CurrVIEW = 'VIEW_COM_SKU' ;
	EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'VIEW_EDW_ClientCompany' ;
	Set @CurrVIEW = 'VIEW_EDW_ClientCompany' ;
	EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'VIEW_EDW_Coaches' ;
	Set @CurrVIEW = 'VIEW_EDW_Coaches' ;
	EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'VIEW_EDW_CoachingDefinition' ;
	Set @CurrVIEW = 'VIEW_EDW_CoachingDefinition' ;
	EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'VIEW_EDW_CoachingDetail' ;
	Set @CurrVIEW = 'VIEW_EDW_CoachingDetail' ;
	EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'VIEW_EDW_HAassessment' ;
	Set @CurrVIEW = 'VIEW_EDW_HAassessment' ;
	EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'VIEW_EDW_HADefinition' ;
	Set @CurrVIEW = 'VIEW_EDW_HADefinition' ;
	EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'VIEW_EDW_HealthAssesment' ;
	Set @CurrVIEW = 'VIEW_EDW_HealthAssesment' ;
	EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'VIEW_EDW_HealthAssesmentAnswers' ;
	Set @CurrVIEW = 'VIEW_EDW_HealthAssesmentAnswers' ;
	EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'VIEW_EDW_HealthAssesmentClientView' ;
	Set @CurrVIEW = 'VIEW_EDW_HealthAssesmentClientView' ;
	EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'VIEW_EDW_HealthAssesmentDeffinition' ;
	Set @CurrVIEW = 'VIEW_EDW_HealthAssesmentDeffinition' ;
	EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'VIEW_EDW_HealthAssesmentDeffinitionCustom' ;
	Set @CurrVIEW = 'VIEW_EDW_HealthAssesmentDeffinitionCustom' ;
	EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'VIEW_EDW_HealthAssesmentQuestions' ;
	Set @CurrVIEW = 'VIEW_EDW_HealthAssesmentQuestions' ;
	EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'VIEW_EDW_HealthAssessment_Staged' ;
	Set @CurrVIEW = 'VIEW_EDW_HealthAssessment_Staged' ;
	EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'VIEW_EDW_HealthAssessmentDefinition_Staged' ;
	Set @CurrVIEW = 'VIEW_EDW_HealthAssessmentDefinition_Staged' ;
	EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'VIEW_EDW_Participant' ;
	Set @CurrVIEW = 'VIEW_EDW_Participant' ;
	EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'VIEW_EDW_RewardAwardDetail' ;
	Set @CurrVIEW = 'VIEW_EDW_RewardAwardDetail' ;
	EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'VIEW_EDW_RewardsDefinition' ;
	Set @CurrVIEW = 'VIEW_EDW_RewardsDefinition' ;
	EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'VIEW_EDW_RewardTriggerParameters' ;
	Set @CurrVIEW = 'VIEW_EDW_RewardTriggerParameters' ;
	EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'VIEW_EDW_RewardUserDetail' ;
	Set @CurrVIEW = 'VIEW_EDW_RewardUserDetail' ;
	EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'VIEW_EDW_ScreeningsFromTrackers' ;
	Set @CurrVIEW = 'VIEW_EDW_ScreeningsFromTrackers' ;
	EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'VIEW_EDW_TrackerCompositeDetails' ;
	Set @CurrVIEW = 'VIEW_EDW_TrackerCompositeDetails' ;
	EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'VIEW_EDW_TrackerMetadata' ;
	Set @CurrVIEW = 'VIEW_EDW_TrackerMetadata' ;
	EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'VIEW_EDW_TrackerShots' ;
	Set @CurrVIEW = 'VIEW_EDW_TrackerShots' ;
	EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'VIEW_EDW_TrackerTests' ;
	Set @CurrVIEW = 'VIEW_EDW_TrackerTests' ;
	EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'VIEW_HFit_Goal_Joined' ;
	Set @CurrVIEW = 'VIEW_HFit_Goal_Joined' ;
	EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'VIEW_HFit_HACampaign_Joined' ;
	Set @CurrVIEW = 'VIEW_HFit_HACampaign_Joined' ;
	EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'VIEW_HFit_HealthAssesmentMatrixQuestion_Joined' ;
	Set @CurrVIEW = 'VIEW_HFit_HealthAssesmentMatrixQuestion_Joined' ;
	EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'VIEW_HFit_HealthAssesmentModule_Joined' ;
	Set @CurrVIEW = 'VIEW_HFit_HealthAssesmentModule_Joined' ;
	EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'VIEW_HFit_HealthAssesmentMultipleChoiceQuestion_Joined' ;
	Set @CurrVIEW = 'VIEW_HFit_HealthAssesmentMultipleChoiceQuestion_Joined' ;
	EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'VIEW_HFit_HealthAssesmentPredefinedAnswer_Joined' ;
	Set @CurrVIEW = 'VIEW_HFit_HealthAssesmentPredefinedAnswer_Joined' ;
	EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'VIEW_HFit_HealthAssesmentRiskArea_Joined' ;
	Set @CurrVIEW = 'VIEW_HFit_HealthAssesmentRiskArea_Joined' ;
	EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'VIEW_HFit_HealthAssesmentRiskCategory_Joined' ;
	Set @CurrVIEW = 'VIEW_HFit_HealthAssesmentRiskCategory_Joined' ;
	EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'VIEW_HFit_HealthAssessment_Joined' ;
	Set @CurrVIEW = 'VIEW_HFit_HealthAssessment_Joined' ;
	EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'VIEW_HFit_HealthAssessmentFreeForm_Joined' ;
	Set @CurrVIEW = 'VIEW_HFit_HealthAssessmentFreeForm_Joined' ;
	EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'VIEW_HFit_RewardActivity_Joined' ;
	Set @CurrVIEW = 'VIEW_HFit_RewardActivity_Joined' ;
	EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'VIEW_HFit_RewardGroup_Joined' ;
	Set @CurrVIEW = 'VIEW_HFit_RewardGroup_Joined' ;
	EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'VIEW_HFit_RewardLevel_Joined' ;
	Set @CurrVIEW = 'VIEW_HFit_RewardLevel_Joined' ;
	EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'VIEW_HFit_RewardProgram_Joined' ;
	Set @CurrVIEW = 'VIEW_HFit_RewardProgram_Joined' ;
	EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'VIEW_HFit_RewardTrigger_Joined' ;
	Set @CurrVIEW = 'VIEW_HFit_RewardTrigger_Joined' ;
	EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'VIEW_HFit_RewardTriggerParameter_Joined' ;
	Set @CurrVIEW = 'VIEW_HFit_RewardTriggerParameter_Joined' ;
	EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO


	Set @LinkedVIEW = 'VIEW_HFit_Tobacco_Goal_Joined' ;
	Set @CurrVIEW = 'VIEW_HFit_Tobacco_Goal_Joined' ;
	EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun ; 
	--GO

	select * from view_SchemaDiff

END

go
print ('CREATED Proc_EDW_Compare_MASTER') ;
go 



--****************************************************************
-- NOTE: This database name must be changed in MANY places in 
--	this script. Please search and change.
--****************************************************************
use KenticoCMS_DEV
go


--***************************************************************
--***************************************************************

GO

print (' ' );
print ('Processing complete - please check for errors.' );