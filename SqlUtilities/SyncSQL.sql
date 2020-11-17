/* ------------------------------------------------------------

   DESCRIPTION:  Schema Synchronization Script for Object(s) 

    views:
        [dbo].[TestAlias], [dbo].[View_CMS_Tree_Joined_Linked], [dbo].[View_CMS_Tree_Joined_Regular], [dbo].[View_Custom_HFit_UserEligibilityData], [dbo].[View_EDW_CDC_HealthAssesmentUserAnswers], [dbo].[view_EDW_HealthAssesment], [dbo].[view_EDW_HealthAssesmentDeffinitionCustom], [dbo].[view_HFit_UserContactDemographics], [dbo].[View_Rewards_CompletedGoals], [dbo].[view_Statbridge_GetAppointments], [dbo].[view_Statbridge_ScreeningEligibility]

     Make ALIEN.KenticoCMS_DEV Equal hfit-sqldevtst.cloudapp.net,1.KenticoCMS_DEV

   AUTHOR:	[Insert Author Name]

   DATE:	7/28/2014 8:57:09 AM

   LEGAL:	2013 [Insert Company Name]

   ------------------------------------------------------------ */

SET NOEXEC OFF
SET ANSI_WARNINGS ON
SET XACT_ABORT ON
SET IMPLICIT_TRANSACTIONS OFF
SET ARITHABORT ON
SET NOCOUNT ON
SET QUOTED_IDENTIFIER ON
SET NUMERIC_ROUNDABORT OFF
SET CONCAT_NULL_YIELDS_NULL ON
SET ANSI_NULLS ON
SET ANSI_PADDING ON
GO
USE [KenticoCMS_DEV]
GO

BEGIN TRAN
GO

-- Drop View [dbo].[TestAlias]
Print 'Drop View [dbo].[TestAlias]'
GO
DROP VIEW [dbo].[TestAlias]
GO

IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
GO
-- Create View [dbo].[View_EDW_CDC_HealthAssesmentUserAnswers]
Print 'Create View [dbo].[View_EDW_CDC_HealthAssesmentUserAnswers]'
GO
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
GO
Create View 
dbo.View_EDW_CDC_HealthAssesmentUserAnswers
as
SELECT
						MAX(ltm.tran_begin_time) InsertUpdateDate
						, DHFHAUAC.ItemID
						, MAX(DHFHAUAC.[__$operation]) Operation
					FROM
						cdc.dbo_HFit_HealthAssesmentUserAnswers_CT AS DHFHAUAC
					INNER JOIN cdc.lsn_time_mapping AS LTM ON DHFHAUAC.[__$start_lsn] = LTM.start_lsn
					WHERE
						DHFHAUAC.[__$operation] IN ( 2, 4 )
					GROUP BY
						DHFHAUAC.ItemID
GO

IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
GO
GRANT SELECT
	ON [dbo].[View_Custom_HFit_UserEligibilityData]
	TO [EDWReader_PRD]
GO

IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
GO
GRANT SELECT
	ON [dbo].[view_HFit_UserContactDemographics]
	TO [EDWReader_PRD]
GO

IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
GO
GRANT SELECT
	ON [dbo].[view_Statbridge_ScreeningEligibility]
	TO [EDWReader_PRD]
GO

IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
GO
-- Create Index [IX_View_CMS_Tree_Joined_Regular_ClassName_NodeSiteID_DocumentForeignKeyValue_DocumentCulture] on [dbo].[View_CMS_Tree_Joined_Regular]
Print 'Create Index [IX_View_CMS_Tree_Joined_Regular_ClassName_NodeSiteID_DocumentForeignKeyValue_DocumentCulture] on [dbo].[View_CMS_Tree_Joined_Regular]'
GO
CREATE NONCLUSTERED INDEX [IX_View_CMS_Tree_Joined_Regular_ClassName_NodeSiteID_DocumentForeignKeyValue_DocumentCulture]
	ON [dbo].[View_CMS_Tree_Joined_Regular] ([ClassName], [NodeSiteID], [DocumentForeignKeyValue], [DocumentCulture])
	INCLUDE ([NodeParentID])
GO

IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
GO
-- Create Index [IX_View_CMS_Tree_Joined_Linked_ClassName_NodeID] on [dbo].[View_CMS_Tree_Joined_Linked]
Print 'Create Index [IX_View_CMS_Tree_Joined_Linked_ClassName_NodeID] on [dbo].[View_CMS_Tree_Joined_Linked]'
GO
CREATE NONCLUSTERED INDEX [IX_View_CMS_Tree_Joined_Linked_ClassName_NodeID]
	ON [dbo].[View_CMS_Tree_Joined_Linked] ([ClassName])
	INCLUDE ([NodeID], [NodeName], [NodeLevel], [DocumentID], [DocumentModifiedWhen], [DocumentForeignKeyValue], [DocumentCreatedByUserID], [DocumentCreatedWhen], [DocumentCheckedOutVersionHistoryID], [DocumentPublishedVersionHistoryID], [DocumentPublishFrom], [DocumentPublishTo], [DocumentCulture], [DocumentNodeID], [DocumentIsArchived])
GO

IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
GO
-- Create View [dbo].[View_Rewards_CompletedGoals]
Print 'Create View [dbo].[View_Rewards_CompletedGoals]'
GO
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
GO

CREATE VIEW [dbo].[View_Rewards_CompletedGoals]
AS
	SELECT TOP ( 100 ) PERCENT
		g.DocumentName AS 'GoalName'
		, dbo.HFit_UserGoal.DocumentID AS GoalDocumentId
		, G1.WeekendDate
		, DATEPART(week, G1.WeekendDate) AS GoalWeek
		, DATEPART(year, G1.WeekendDate) AS Goalyear
		, dbo.HFit_UserGoal.UserID
	FROM
		dbo.HFit_GoalOutcome AS G1
	INNER JOIN dbo.HFit_UserGoal ON dbo.HFit_UserGoal.ItemID = G1.UserGoalItemID
	INNER JOIN dbo.View_HFit_Goal_Joined AS g ON g.DocumentID = dbo.HFit_UserGoal.DocumentID
	ORDER BY
		GoalDocumentId
		, G1.WeekendDate

GO

IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
GO
-- Create Extended Property [MS_DiagramPane1] on [dbo].[View_Rewards_CompletedGoals]
Print 'Create Extended Property [MS_DiagramPane1] on [dbo].[View_Rewards_CompletedGoals]'
GO
EXEC sp_addextendedproperty N'MS_DiagramPane1', N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[21] 4[40] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "G1"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 135
               Right = 212
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "HFit_UserGoal"
            Begin Extent = 
               Top = 6
               Left = 250
               Bottom = 135
               Right = 442
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "g"
            Begin Extent = 
               Top = 6
               Left = 480
               Bottom = 135
               Right = 804
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1995
         Width = 2070
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 4140
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
', 'SCHEMA', N'dbo', 'VIEW', N'View_Rewards_CompletedGoals', NULL, NULL
GO

IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
GO
-- Create Extended Property [MS_DiagramPaneCount] on [dbo].[View_Rewards_CompletedGoals]
Print 'Create Extended Property [MS_DiagramPaneCount] on [dbo].[View_Rewards_CompletedGoals]'
GO
EXEC sp_addextendedproperty N'MS_DiagramPaneCount', 1, 'SCHEMA', N'dbo', 'VIEW', N'View_Rewards_CompletedGoals', NULL, NULL
GO

IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
GO
GRANT SELECT
	ON [dbo].[view_Statbridge_GetAppointments]
	TO [EDWReader_PRD]
GO

IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
GO
-- Create View [dbo].[view_EDW_HealthAssesmentDeffinitionCustom]
Print 'Create View [dbo].[view_EDW_HealthAssesmentDeffinitionCustom]'
GO
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
GO



CREATE VIEW [dbo].[view_EDW_HealthAssesmentDeffinitionCustom]
AS
	SELECT
		cs.SiteGUID
		, HFA.AccountCD
		, VCTJ.NodeID AS HANodeID
		, VCTJ.NodeName AS HANodeName
		, VCTJ.DocumentID AS HADocumentID
		, VCTJ.NodeSiteID AS HANodeSiteID
       --,VCTJ.NodeAliasPath AS HANodeAliasPath
		, VCTJ.DocumentPublishedVersionHistoryID AS HADocPubVerID
		, VHFHAMJ.Title AS ModTitle
		, dbo.udf_StripHTML(VHFHAMJ.IntroText) AS IntroText
		, VHFHAMJ.DocumentID AS ModDocID
		, VHFHAMJ.Weight AS ModWeight
		, VHFHAMJ.IsEnabled AS ModIsEnabled
		, VHFHAMJ.CodeName AS ModCodeName
       --,VHFHAMJ.NodeAliasPath AS ModNodeAliasPath
		, VHFHAMJ.DocumentPublishedVersionHistoryID AS ModDocPubVerID
		, VHFHARCJ.Title AS RCTitle
		, VHFHARCJ.Weight AS RCWeight
		, VHFHARCJ.DocumentID AS RCDocumentID
		, VHFHARCJ.IsEnabled AS RCIsEnabled
		, VHFHARCJ.CodeName AS RCCodeName
       --,VHFHARCJ.NodeAliasPath AS RCNodeAliasPath
		, VHFHARCJ.DocumentPublishedVersionHistoryID AS RCDocPubVerID
		, VHFHARAJ.Title AS RATytle
		, VHFHARAJ.Weight AS RAWeight
		, VHFHARAJ.DocumentID AS RADocumentID
		, VHFHARAJ.IsEnabled AS RAIsEnabled
		, VHFHARAJ.CodeName AS RACodeName
       --,VHFHARAJ.NodeAliasPath AS RANodeAliasPath
		, VHFHARAJ.ScoringStrategyID AS RAScoringStrategyID
		, VHFHARAJ.DocumentPublishedVersionHistoryID AS RADocPubVerID
		, VHFHAQ.QuestionType
		, dbo.udf_StripHTML(VHFHAQ.Title) AS QuesTitle
		, VHFHAQ.Weight AS QuesWeight
		, VHFHAQ.IsRequired AS QuesIsRequired
		, VHFHAQ.DocumentID AS QuesDocumentID
		, VHFHAQ.IsEnabled AS QuesIsEnabled
		, VHFHAQ.IsVisible AS QuesIsVisible
		, VHFHAQ.IsStaging AS QuesIsSTaging
		, VHFHAQ.CodeName AS QuestionCodeName
       --,VHFHAQ.NodeAliasPath AS QuesNodeAliasPath
		, VHFHAQ.DocumentPublishedVersionHistoryID AS QuesDocPubVerID
		, VHFHAA.Value AS AnsValue
		, VHFHAA.Points AS AnsPoints
		, VHFHAA.DocumentID AS AnsDocumentID
		, VHFHAA.IsEnabled AS AnsIsEnabled
		, VHFHAA.CodeName AS AnsCodeName
		, VHFHAA.UOM AS AnsUOM
       --,VHFHAA.NodeAliasPath AS AnsNodeAliasPath
		, VHFHAA.DocumentPublishedVersionHistoryID AS AnsDocPUbVerID
		, CASE	WHEN CAST(VCTJ.DocumentCreatedWhen AS DATE) = CAST(vctj.DocumentModifiedWhen AS DATE)
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		, VCTJ.DocumentCreatedWhen
		, VCTJ.DocumentModifiedWhen
	FROM
		dbo.View_CMS_Tree_Joined AS VCTJ
			INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
			INNER JOIN dbo.HFit_Account AS HFA ON cs.SiteID = hfa.SiteID
			
			--WDM This seems to be the problem child - 7/3/2014
			INNER JOIN dbo.View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ ON VCTJ.NodeID = VHFHAMJ.NodeParentID
			
			INNER JOIN dbo.View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
			INNER JOIN dbo.View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
		--level 1 question
			INNER JOIN dbo.View_HFit_HealthAssesmentQuestions AS VHFHAQ ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
		--Level 1 Answers
			LEFT OUTER JOIN dbo.View_HFit_HealthAssesmentAnswers AS VHFHAA ON VHFHAQ.NodeID = VHFHAA.NodeParentID
			WHERE
				VHFHAMJ.NodeName = 'Custom'
Union ALL
	SELECT
		cs.SiteGUID
		, HFA.AccountCD
		, VCTJ.NodeID
		, VCTJ.NodeName
		, VCTJ.DocumentID
		, VCTJ.NodeSiteID
       --,VCTJ.NodeAliasPath
		, VCTJ.DocumentPublishedVersionHistoryID
		, VHFHAMJ.Title
		, dbo.udf_StripHTML(VHFHAMJ.IntroText) AS IntroText
		, VHFHAMJ.DocumentID
		, VHFHAMJ.Weight
		, VHFHAMJ.IsEnabled
		, VHFHAMJ.CodeName
       --,VHFHAMJ.NodeAliasPath
		, VHFHAMJ.DocumentPublishedVersionHistoryID
		, VHFHARCJ.Title
		, VHFHARCJ.Weight
		, VHFHARCJ.DocumentID
		, VHFHARCJ.IsEnabled
		, VHFHARCJ.CodeName
       --,VHFHARCJ.NodeAliasPath
		, VHFHARCJ.DocumentPublishedVersionHistoryID
		, VHFHARAJ.Title
		, VHFHARAJ.Weight
		, VHFHARAJ.DocumentID
		, VHFHARAJ.IsEnabled
		, VHFHARAJ.CodeName
       --,VHFHARAJ.NodeAliasPath
		, VHFHARAJ.ScoringStrategyID
		, VHFHARAJ.DocumentPublishedVersionHistoryID
		, VHFHAQ2.QuestionType
		, dbo.udf_StripHTML(VHFHAQ2.Title) AS QuesTitle
		, VHFHAQ2.Weight
		, VHFHAQ2.IsRequired
		, VHFHAQ2.DocumentID
		, VHFHAQ2.IsEnabled
		, VHFHAQ2.IsVisible
		, VHFHAQ2.IsStaging
		, VHFHAQ2.CodeName AS QuestionCodeName
       --,VHFHAQ2.NodeAliasPath
		, VHFHAQ2.DocumentPublishedVersionHistoryID
		, VHFHAA2.Value
		, VHFHAA2.Points
		, VHFHAA2.DocumentID
		, VHFHAA2.IsEnabled
		, VHFHAA2.CodeName
		, VHFHAA2.UOM
       --,VHFHAA2.NodeAliasPath
		, VHFHAA2.DocumentPublishedVersionHistoryID
		, CASE	WHEN CAST(VCTJ.DocumentCreatedWhen AS DATE) = CAST(vctj.DocumentModifiedWhen AS DATE)
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		, VCTJ.DocumentCreatedWhen
		, VCTJ.DocumentModifiedWhen
	FROM
		dbo.View_CMS_Tree_Joined AS VCTJ
			INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
			INNER JOIN dbo.HFit_Account AS HFA ON cs.SiteID = hfa.SiteID
			INNER JOIN dbo.View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ ON VCTJ.NodeID = VHFHAMJ.NodeParentID
			INNER JOIN dbo.View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
			INNER JOIN dbo.View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
			--level 1 question
			INNER JOIN dbo.View_HFit_HealthAssesmentQuestions AS VHFHAQ ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
			--Level 1 Answers
			LEFT OUTER JOIN dbo.View_HFit_HealthAssesmentAnswers AS VHFHAA ON VHFHAQ.NodeID = VHFHAA.NodeParentID

			--matrix level 1 questiongroup
			INNER JOIN dbo.View_HFit_HealthAssesmentQuestions AS VHFHAQ2 ON VHFHAQ.NodeID = VHFHAQ2.NodeParentID
			INNER JOIN dbo.View_HFit_HealthAssesmentAnswers AS VHFHAA2 ON VHFHAQ2.NodeID = VHFHAA2.NodeParentID
			WHERE
				VHFHAMJ.NodeName = 'Custom'

Union ALL
	SELECT
		cs.SiteGUID
		, HFA.AccountCD
		, VCTJ.NodeID
		, VCTJ.NodeName
		, VCTJ.DocumentID
		, VCTJ.NodeSiteID
       --,VCTJ.NodeAliasPath
		, VCTJ.DocumentPublishedVersionHistoryID
		, VHFHAMJ.Title
		, dbo.udf_StripHTML(VHFHAMJ.IntroText) AS IntroText
		, VHFHAMJ.DocumentID
		, VHFHAMJ.Weight
		, VHFHAMJ.IsEnabled
		, VHFHAMJ.CodeName
       --,VHFHAMJ.NodeAliasPath
		, VHFHAMJ.DocumentPublishedVersionHistoryID
		, VHFHARCJ.Title
		, VHFHARCJ.Weight
		, VHFHARCJ.DocumentID
		, VHFHARCJ.IsEnabled
		, VHFHARCJ.CodeName
       --,VHFHARCJ.NodeAliasPath
		, VHFHARCJ.DocumentPublishedVersionHistoryID
		, VHFHARAJ.Title
		, VHFHARAJ.Weight
		, VHFHARAJ.DocumentID
		, VHFHARAJ.IsEnabled
		, VHFHARAJ.CodeName
       --,VHFHARAJ.NodeAliasPath
		, VHFHARAJ.ScoringStrategyID
		, VHFHARAJ.DocumentPublishedVersionHistoryID
		, VHFHAQ3.QuestionType
		, dbo.udf_StripHTML(VHFHAQ3.Title) AS QuesTitle
		, VHFHAQ3.Weight
		, VHFHAQ3.IsRequired
		, VHFHAQ3.DocumentID
		, VHFHAQ3.IsEnabled
		, VHFHAQ3.IsVisible
		, VHFHAQ3.IsStaging
		, VHFHAQ3.CodeName AS QuestionCodeName
       --,VHFHAQ3.NodeAliasPath
		, VHFHAQ3.DocumentPublishedVersionHistoryID
		, VHFHAA3.Value
		, VHFHAA3.Points
		, VHFHAA3.DocumentID
		, VHFHAA3.IsEnabled
		, VHFHAA3.CodeName
		, VHFHAA3.UOM
       --,VHFHAA3.NodeAliasPath
		, VHFHAA3.DocumentPublishedVersionHistoryID
		, CASE	WHEN CAST(VCTJ.DocumentCreatedWhen AS DATE) = CAST(vctj.DocumentModifiedWhen AS DATE)
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		, VCTJ.DocumentCreatedWhen
		, VCTJ.DocumentModifiedWhen
	FROM
		dbo.View_CMS_Tree_Joined AS VCTJ
	INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
	INNER JOIN dbo.HFit_Account AS HFA ON cs.SiteID = hfa.SiteID
	INNER JOIN dbo.View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ ON VCTJ.NodeID = VHFHAMJ.NodeParentID
	INNER JOIN dbo.View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
	INNER JOIN dbo.View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
--level 1 question
	INNER JOIN dbo.View_HFit_HealthAssesmentQuestions AS VHFHAQ ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
--Level 1 Answers
	LEFT OUTER JOIN dbo.View_HFit_HealthAssesmentAnswers AS VHFHAA ON VHFHAQ.NodeID = VHFHAA.NodeParentID

--matrix level 1 questiongroup
--INNER JOIN dbo.View_HFit_HealthAssesmentQuestions AS VHFHAQ2 ON VHFHAQ.NodeID = VHFHAQ2.NodeParentID
--INNER JOIN dbo.View_HFit_HealthAssesmentAnswers AS VHFHAA2 ON VHFHAQ2.NodeID = VHFHAA2.NodeParentID

--Branching Level 1 Question 
	INNER JOIN dbo.View_HFit_HealthAssesmentQuestions AS VHFHAQ3 ON VHFHAA.NodeID = VHFHAQ3.NodeParentID
	LEFT OUTER JOIN dbo.View_HFit_HealthAssesmentAnswers AS VHFHAA3 ON VHFHAQ3.NodeID = VHFHAA3.NodeParentID
	WHERE
		VHFHAMJ.NodeName = 'Custom'
Union ALL
	SELECT
		cs.SiteGUID
		, HFA.AccountCD
		, VCTJ.NodeID
		, VCTJ.NodeName
		, VCTJ.DocumentID
		, VCTJ.NodeSiteID
       --,VCTJ.NodeAliasPath
		, VCTJ.DocumentPublishedVersionHistoryID
		, VHFHAMJ.Title
		, dbo.udf_StripHTML(VHFHAMJ.IntroText) AS IntroText
		, VHFHAMJ.DocumentID
		, VHFHAMJ.Weight
		, VHFHAMJ.IsEnabled
		, VHFHAMJ.CodeName
       --,VHFHAMJ.NodeAliasPath
		, VHFHAMJ.DocumentPublishedVersionHistoryID
		, VHFHARCJ.Title
		, VHFHARCJ.Weight
		, VHFHARCJ.DocumentID
		, VHFHARCJ.IsEnabled
		, VHFHARCJ.CodeName
       --,VHFHARCJ.NodeAliasPath
		, VHFHARCJ.DocumentPublishedVersionHistoryID
		, VHFHARAJ.Title
		, VHFHARAJ.Weight
		, VHFHARAJ.DocumentID
		, VHFHARAJ.IsEnabled
		, VHFHARAJ.CodeName
       --,VHFHARAJ.NodeAliasPath
		, VHFHARAJ.ScoringStrategyID
		, VHFHARAJ.DocumentPublishedVersionHistoryID
		, VHFHAQ7.QuestionType
		, dbo.udf_StripHTML(VHFHAQ7.Title) AS QuesTitle
		, VHFHAQ7.Weight
		, VHFHAQ7.IsRequired
		, VHFHAQ7.DocumentID
		, VHFHAQ7.IsEnabled
		, VHFHAQ7.IsVisible
		, VHFHAQ7.IsStaging
		, VHFHAQ7.CodeName AS QuestionCodeName
       --,VHFHAQ7.NodeAliasPath
		, VHFHAQ7.DocumentPublishedVersionHistoryID
		, VHFHAA7.Value
		, VHFHAA7.Points
		, VHFHAA7.DocumentID
		, VHFHAA7.IsEnabled
		, VHFHAA7.CodeName
		, VHFHAA7.UOM
       --,VHFHAA7.NodeAliasPath
		, VHFHAA7.DocumentPublishedVersionHistoryID
		, CASE	WHEN CAST(VCTJ.DocumentCreatedWhen AS DATE) = CAST(vctj.DocumentModifiedWhen AS DATE)
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		, VCTJ.DocumentCreatedWhen
		, VCTJ.DocumentModifiedWhen
	FROM
		dbo.View_CMS_Tree_Joined AS VCTJ
	INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
	INNER JOIN dbo.HFit_Account AS HFA ON cs.SiteID = hfa.SiteID
	INNER JOIN dbo.View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ ON VCTJ.NodeID = VHFHAMJ.NodeParentID
	INNER JOIN dbo.View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
	INNER JOIN dbo.View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
--level 1 question
	INNER JOIN dbo.View_HFit_HealthAssesmentQuestions AS VHFHAQ ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
--Level 1 Answers
	LEFT OUTER JOIN dbo.View_HFit_HealthAssesmentAnswers AS VHFHAA ON VHFHAQ.NodeID = VHFHAA.NodeParentID

--matrix level 1 questiongroup
--INNER JOIN dbo.View_HFit_HealthAssesmentQuestions AS VHFHAQ2 ON VHFHAQ.NodeID = VHFHAQ2.NodeParentID
--INNER JOIN dbo.View_HFit_HealthAssesmentAnswers AS VHFHAA2 ON VHFHAQ2.NodeID = VHFHAA2.NodeParentID

--Branching Level 1 Question 
	INNER JOIN dbo.View_HFit_HealthAssesmentQuestions AS VHFHAQ3 ON VHFHAA.NodeID = VHFHAQ3.NodeParentID
--LEFT OUTER JOIN dbo.View_HFit_HealthAssesmentAnswers AS VHFHAA3 ON VHFHAQ3.NodeID = VHFHAA3.NodeParentID

--Matrix Level 2 Question Group
	INNER JOIN dbo.View_HFit_HealthAssesmentQuestions AS VHFHAQ7 ON VHFHAQ3.NodeID = VHFHAQ7.NodeParentID
	INNER JOIN dbo.View_HFit_HealthAssesmentAnswers AS VHFHAA7 ON VHFHAQ7.NodeID = VHFHAA7.NodeParentID
	WHERE
		VHFHAMJ.NodeName = 'Custom'
Union ALL
	SELECT
		cs.SiteGUID
		, HFA.AccountCD
		, VCTJ.NodeID
		, VCTJ.NodeName
		, VCTJ.DocumentID
		, VCTJ.NodeSiteID
       --,VCTJ.NodeAliasPath
		, VCTJ.DocumentPublishedVersionHistoryID
		, VHFHAMJ.Title
		, dbo.udf_StripHTML(VHFHAMJ.IntroText) AS IntroText
		, VHFHAMJ.DocumentID
		, VHFHAMJ.Weight
		, VHFHAMJ.IsEnabled
		, VHFHAMJ.CodeName
       --,VHFHAMJ.NodeAliasPath
		, VHFHAMJ.DocumentPublishedVersionHistoryID
		, VHFHARCJ.Title
		, VHFHARCJ.Weight
		, VHFHARCJ.DocumentID
		, VHFHARCJ.IsEnabled
		, VHFHARCJ.CodeName
       --,VHFHARCJ.NodeAliasPath
		, VHFHARCJ.DocumentPublishedVersionHistoryID
		, VHFHARAJ.Title
		, VHFHARAJ.Weight
		, VHFHARAJ.DocumentID
		, VHFHARAJ.IsEnabled
		, VHFHARAJ.CodeName
       --,VHFHARAJ.NodeAliasPath
		, VHFHARAJ.ScoringStrategyID
		, VHFHARAJ.DocumentPublishedVersionHistoryID
		, VHFHAQ8.QuestionType
		, dbo.udf_StripHTML(VHFHAQ8.Title) AS QuesTitle
		, VHFHAQ8.Weight
		, VHFHAQ8.IsRequired
		, VHFHAQ8.DocumentID
		, VHFHAQ8.IsEnabled
		, VHFHAQ8.IsVisible
		, VHFHAQ8.IsStaging
		, VHFHAQ8.CodeName AS QuestionCodeName
       --,VHFHAQ8.NodeAliasPath
		, VHFHAQ8.DocumentPublishedVersionHistoryID
		, VHFHAA8.Value
		, VHFHAA8.Points
		, VHFHAA8.DocumentID
		, VHFHAA8.IsEnabled
		, VHFHAA8.CodeName
		, VHFHAA8.UOM
       --,VHFHAA8.NodeAliasPath
		, VHFHAA8.DocumentPublishedVersionHistoryID
		, CASE	WHEN CAST(VCTJ.DocumentCreatedWhen AS DATE) = CAST(vctj.DocumentModifiedWhen AS DATE)
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		, VCTJ.DocumentCreatedWhen
		, VCTJ.DocumentModifiedWhen
	FROM
		dbo.View_CMS_Tree_Joined AS VCTJ
	INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
	INNER JOIN dbo.HFit_Account AS HFA ON cs.SiteID = hfa.SiteID
	INNER JOIN dbo.View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ ON VCTJ.NodeID = VHFHAMJ.NodeParentID
	INNER JOIN dbo.View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
	INNER JOIN dbo.View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
--level 1 question
	INNER JOIN dbo.View_HFit_HealthAssesmentQuestions AS VHFHAQ ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
--Level 1 Answers
	LEFT OUTER JOIN dbo.View_HFit_HealthAssesmentAnswers AS VHFHAA ON VHFHAQ.NodeID = VHFHAA.NodeParentID

--matrix level 1 questiongroup
--INNER JOIN dbo.View_HFit_HealthAssesmentQuestions AS VHFHAQ2 ON VHFHAQ.NodeID = VHFHAQ2.NodeParentID
--INNER JOIN dbo.View_HFit_HealthAssesmentAnswers AS VHFHAA2 ON VHFHAQ2.NodeID = VHFHAA2.NodeParentID

--Branching Level 1 Question 
	INNER JOIN dbo.View_HFit_HealthAssesmentQuestions AS VHFHAQ3 ON VHFHAA.NodeID = VHFHAQ3.NodeParentID
--LEFT OUTER JOIN dbo.View_HFit_HealthAssesmentAnswers AS VHFHAA3 ON VHFHAQ3.NodeID = VHFHAA3.NodeParentID

--Matrix Level 2 Question Group
	INNER JOIN dbo.View_HFit_HealthAssesmentQuestions AS VHFHAQ7 ON VHFHAQ3.NodeID = VHFHAQ7.NodeParentID
	INNER JOIN dbo.View_HFit_HealthAssesmentAnswers AS VHFHAA7 ON VHFHAQ7.NodeID = VHFHAA7.NodeParentID

--Matrix branching level 1 question group
	INNER JOIN dbo.View_HFit_HealthAssesmentQuestions AS VHFHAQ8 ON VHFHAA7.NodeID = VHFHAQ8.NodeParentID
	INNER JOIN dbo.View_HFit_HealthAssesmentAnswers AS VHFHAA8 ON VHFHAQ8.NodeID = VHFHAA8.NodeParentID
	WHERE
		VHFHAMJ.NodeName = 'Custom'
Union ALL
	SELECT
		cs.SiteGUID
		, HFA.AccountCD
		, VCTJ.NodeID
		, VCTJ.NodeName
		, VCTJ.DocumentID
		, VCTJ.NodeSiteID
       --,VCTJ.NodeAliasPath
		, VCTJ.DocumentPublishedVersionHistoryID
		, VHFHAMJ.Title
		, dbo.udf_StripHTML(VHFHAMJ.IntroText) AS IntroText
		, VHFHAMJ.DocumentID
		, VHFHAMJ.Weight
		, VHFHAMJ.IsEnabled
		, VHFHAMJ.CodeName
       --,VHFHAMJ.NodeAliasPath
		, VHFHAMJ.DocumentPublishedVersionHistoryID
		, VHFHARCJ.Title
		, VHFHARCJ.Weight
		, VHFHARCJ.DocumentID
		, VHFHARCJ.IsEnabled
		, VHFHARCJ.CodeName
       --,VHFHARCJ.NodeAliasPath
		, VHFHARCJ.DocumentPublishedVersionHistoryID
		, VHFHARAJ.Title
		, VHFHARAJ.Weight
		, VHFHARAJ.DocumentID
		, VHFHARAJ.IsEnabled
		, VHFHARAJ.CodeName
       --,VHFHARAJ.NodeAliasPath
		, VHFHARAJ.ScoringStrategyID
		, VHFHARAJ.DocumentPublishedVersionHistoryID
		, VHFHAQ4.QuestionType
		, dbo.udf_StripHTML(VHFHAQ4.Title) AS QuesTitle
		, VHFHAQ4.Weight
		, VHFHAQ4.IsRequired
		, VHFHAQ4.DocumentID
		, VHFHAQ4.IsEnabled
		, VHFHAQ4.IsVisible
		, VHFHAQ4.IsStaging
		, VHFHAQ4.CodeName AS QuestionCodeName
       --,VHFHAQ4.NodeAliasPath
		, VHFHAQ4.DocumentPublishedVersionHistoryID
		, VHFHAA4.Value
		, VHFHAA4.Points
		, VHFHAA4.DocumentID
		, VHFHAA4.IsEnabled
		, VHFHAA4.CodeName
		, VHFHAA4.UOM
       --,VHFHAA4.NodeAliasPath
		, VHFHAA4.DocumentPublishedVersionHistoryID
		, CASE	WHEN CAST(VCTJ.DocumentCreatedWhen AS DATE) = CAST(vctj.DocumentModifiedWhen AS DATE)
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		, VCTJ.DocumentCreatedWhen
		, VCTJ.DocumentModifiedWhen
	FROM
		dbo.View_CMS_Tree_Joined AS VCTJ
	INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
	INNER JOIN dbo.HFit_Account AS HFA ON cs.SiteID = hfa.SiteID
	INNER JOIN dbo.View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ ON VCTJ.NodeID = VHFHAMJ.NodeParentID
	INNER JOIN dbo.View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
	INNER JOIN dbo.View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
--level 1 question
	INNER JOIN dbo.View_HFit_HealthAssesmentQuestions AS VHFHAQ ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
--Level 1 Answers
	LEFT OUTER JOIN dbo.View_HFit_HealthAssesmentAnswers AS VHFHAA ON VHFHAQ.NodeID = VHFHAA.NodeParentID

--matrix level 1 questiongroup
--INNER JOIN dbo.View_HFit_HealthAssesmentQuestions AS VHFHAQ2 ON VHFHAQ.NodeID = VHFHAQ2.NodeParentID
--INNER JOIN dbo.View_HFit_HealthAssesmentAnswers AS VHFHAA2 ON VHFHAQ2.NodeID = VHFHAA2.NodeParentID

--Branching Level 1 Question 
	INNER JOIN dbo.View_HFit_HealthAssesmentQuestions AS VHFHAQ3 ON VHFHAA.NodeID = VHFHAQ3.NodeParentID
	LEFT OUTER JOIN dbo.View_HFit_HealthAssesmentAnswers AS VHFHAA3 ON VHFHAQ3.NodeID = VHFHAA3.NodeParentID

--Matrix Level 2 Question Group
--INNER JOIN dbo.View_HFit_HealthAssesmentQuestions AS VHFHAQ7 ON VHFHAQ3.NodeID = VHFHAQ7.NodeParentID
--INNER JOIN dbo.View_HFit_HealthAssesmentAnswers AS VHFHAA7 ON VHFHAQ7.NodeID = VHFHAA7.NodeParentID

--Matrix branching level 1 question group
--INNER JOIN dbo.View_HFit_HealthAssesmentQuestions AS VHFHAQ8 ON VHFHAA7.NodeID = VHFHAQ8.NodeParentID
--INNER JOIN dbo.View_HFit_HealthAssesmentAnswers AS VHFHAA8 ON VHFHAQ8.NodeID = VHFHAA8.NodeParentID

--Branching level 2 Question Group
	INNER JOIN dbo.View_HFit_HealthAssesmentQuestions AS VHFHAQ4 ON VHFHAA3.NodeID = VHFHAQ4.NodeParentID
	INNER JOIN dbo.View_HFit_HealthAssesmentAnswers AS VHFHAA4 ON VHFHAQ4.NodeID = VHFHAA4.NodeParentID
	WHERE
		VHFHAMJ.NodeName = 'Custom'
Union ALL
	SELECT
		cs.SiteGUID
		, HFA.AccountCD
		, VCTJ.NodeID
		, VCTJ.NodeName
		, VCTJ.DocumentID
		, VCTJ.NodeSiteID
       --,VCTJ.NodeAliasPath
		, VCTJ.DocumentPublishedVersionHistoryID
		, VHFHAMJ.Title
		, dbo.udf_StripHTML(VHFHAMJ.IntroText) AS IntroText
		, VHFHAMJ.DocumentID
		, VHFHAMJ.Weight
		, VHFHAMJ.IsEnabled
		, VHFHAMJ.CodeName
       --,VHFHAMJ.NodeAliasPath
		, VHFHAMJ.DocumentPublishedVersionHistoryID
		, VHFHARCJ.Title
		, VHFHARCJ.Weight
		, VHFHARCJ.DocumentID
		, VHFHARCJ.IsEnabled
		, VHFHARCJ.CodeName
       --,VHFHARCJ.NodeAliasPath
		, VHFHARCJ.DocumentPublishedVersionHistoryID
		, VHFHARAJ.Title
		, VHFHARAJ.Weight
		, VHFHARAJ.DocumentID
		, VHFHARAJ.IsEnabled
		, VHFHARAJ.CodeName
       --,VHFHARAJ.NodeAliasPath
		, VHFHARAJ.ScoringStrategyID
		, VHFHARAJ.DocumentPublishedVersionHistoryID
		, VHFHAQ5.QuestionType
		, dbo.udf_StripHTML(VHFHAQ5.Title) AS QuesTitle
		, VHFHAQ5.Weight
		, VHFHAQ5.IsRequired
		, VHFHAQ5.DocumentID
		, VHFHAQ5.IsEnabled
		, VHFHAQ5.IsVisible
		, VHFHAQ5.IsStaging
		, VHFHAQ5.CodeName AS QuestionCodeName
       --,VHFHAQ5.NodeAliasPath
		, VHFHAQ5.DocumentPublishedVersionHistoryID
		, VHFHAA5.Value
		, VHFHAA5.Points
		, VHFHAA5.DocumentID
		, VHFHAA5.IsEnabled
		, VHFHAA5.CodeName
		, VHFHAA5.UOM
       --,VHFHAA5.NodeAliasPath
		, VHFHAA5.DocumentPublishedVersionHistoryID
		, CASE	WHEN CAST(VCTJ.DocumentCreatedWhen AS DATE) = CAST(vctj.DocumentModifiedWhen AS DATE)
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		, VCTJ.DocumentCreatedWhen
		, VCTJ.DocumentModifiedWhen
	FROM
		dbo.View_CMS_Tree_Joined AS VCTJ
	INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
	INNER JOIN dbo.HFit_Account AS HFA ON cs.SiteID = hfa.SiteID
	INNER JOIN dbo.View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ ON VCTJ.NodeID = VHFHAMJ.NodeParentID
	INNER JOIN dbo.View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
	INNER JOIN dbo.View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
--level 1 question
	INNER JOIN dbo.View_HFit_HealthAssesmentQuestions AS VHFHAQ ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
--Level 1 Answers
	LEFT OUTER JOIN dbo.View_HFit_HealthAssesmentAnswers AS VHFHAA ON VHFHAQ.NodeID = VHFHAA.NodeParentID

--matrix level 1 questiongroup
--INNER JOIN dbo.View_HFit_HealthAssesmentQuestions AS VHFHAQ2 ON VHFHAQ.NodeID = VHFHAQ2.NodeParentID
--INNER JOIN dbo.View_HFit_HealthAssesmentAnswers AS VHFHAA2 ON VHFHAQ2.NodeID = VHFHAA2.NodeParentID

--Branching Level 1 Question 
	INNER JOIN dbo.View_HFit_HealthAssesmentQuestions AS VHFHAQ3 ON VHFHAA.NodeID = VHFHAQ3.NodeParentID
	LEFT OUTER JOIN dbo.View_HFit_HealthAssesmentAnswers AS VHFHAA3 ON VHFHAQ3.NodeID = VHFHAA3.NodeParentID

--Matrix Level 2 Question Group
--INNER JOIN dbo.View_HFit_HealthAssesmentQuestions AS VHFHAQ7 ON VHFHAQ3.NodeID = VHFHAQ7.NodeParentID
--INNER JOIN dbo.View_HFit_HealthAssesmentAnswers AS VHFHAA7 ON VHFHAQ7.NodeID = VHFHAA7.NodeParentID

--Matrix branching level 1 question group
--INNER JOIN dbo.View_HFit_HealthAssesmentQuestions AS VHFHAQ8 ON VHFHAA7.NodeID = VHFHAQ8.NodeParentID
--INNER JOIN dbo.View_HFit_HealthAssesmentAnswers AS VHFHAA8 ON VHFHAQ8.NodeID = VHFHAA8.NodeParentID

--Branching level 2 Question Group
	INNER JOIN dbo.View_HFit_HealthAssesmentQuestions AS VHFHAQ4 ON VHFHAA3.NodeID = VHFHAQ4.NodeParentID
	INNER JOIN dbo.View_HFit_HealthAssesmentAnswers AS VHFHAA4 ON VHFHAQ4.NodeID = VHFHAA4.NodeParentID

--Branching level 3 Question Group
	INNER JOIN dbo.View_HFit_HealthAssesmentQuestions AS VHFHAQ5 ON VHFHAA4.NodeID = VHFHAQ5.NodeParentID
	INNER JOIN dbo.View_HFit_HealthAssesmentAnswers AS VHFHAA5 ON VHFHAQ5.NodeID = VHFHAA5.NodeParentID
	WHERE
		VHFHAMJ.NodeName = 'Custom'
Union ALL
	SELECT
		cs.SiteGUID
		, HFA.AccountCD
		, VCTJ.NodeID
		, VCTJ.NodeName
		, VCTJ.DocumentID
		, VCTJ.NodeSiteID
       --,VCTJ.NodeAliasPath
		, VCTJ.DocumentPublishedVersionHistoryID
		, VHFHAMJ.Title
		, dbo.udf_StripHTML(VHFHAMJ.IntroText) AS IntroText
		, VHFHAMJ.DocumentID
		, VHFHAMJ.Weight
		, VHFHAMJ.IsEnabled
		, VHFHAMJ.CodeName
       --,VHFHAMJ.NodeAliasPath
		, VHFHAMJ.DocumentPublishedVersionHistoryID
		, VHFHARCJ.Title
		, VHFHARCJ.Weight
		, VHFHARCJ.DocumentID
		, VHFHARCJ.IsEnabled
		, VHFHARCJ.CodeName
       --,VHFHARCJ.NodeAliasPath
		, VHFHARCJ.DocumentPublishedVersionHistoryID
		, VHFHARAJ.Title
		, VHFHARAJ.Weight
		, VHFHARAJ.DocumentID
		, VHFHARAJ.IsEnabled
		, VHFHARAJ.CodeName
       --,VHFHARAJ.NodeAliasPath
		, VHFHARAJ.ScoringStrategyID
		, VHFHARAJ.DocumentPublishedVersionHistoryID
		, VHFHAQ6.QuestionType
		, dbo.udf_StripHTML(VHFHAQ6.Title) AS QuesTitle
		, VHFHAQ6.Weight
		, VHFHAQ6.IsRequired
		, VHFHAQ6.DocumentID
		, VHFHAQ6.IsEnabled
		, VHFHAQ6.IsVisible
		, VHFHAQ6.IsStaging
		, VHFHAQ6.CodeName AS QuestionCodeName
       --,VHFHAQ6.NodeAliasPath
		, VHFHAQ6.DocumentPublishedVersionHistoryID
		, VHFHAA6.Value
		, VHFHAA6.Points
		, VHFHAA6.DocumentID
		, VHFHAA6.IsEnabled
		, VHFHAA6.CodeName
		, VHFHAA6.UOM
       --,VHFHAA6.NodeAliasPath
		, VHFHAA6.DocumentPublishedVersionHistoryID
		, CASE	WHEN CAST(VCTJ.DocumentCreatedWhen AS DATE) = CAST(vctj.DocumentModifiedWhen AS DATE)
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		, VCTJ.DocumentCreatedWhen
		, VCTJ.DocumentModifiedWhen
	FROM
		dbo.View_CMS_Tree_Joined AS VCTJ
	INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
	INNER JOIN dbo.HFit_Account AS HFA ON cs.SiteID = hfa.SiteID
	INNER JOIN dbo.View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ ON VCTJ.NodeID = VHFHAMJ.NodeParentID
	INNER JOIN dbo.View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
	INNER JOIN dbo.View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
--level 1 question
	INNER JOIN dbo.View_HFit_HealthAssesmentQuestions AS VHFHAQ ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
--Level 1 Answers
	LEFT OUTER JOIN dbo.View_HFit_HealthAssesmentAnswers AS VHFHAA ON VHFHAQ.NodeID = VHFHAA.NodeParentID

--matrix level 1 questiongroup
--INNER JOIN dbo.View_HFit_HealthAssesmentQuestions AS VHFHAQ2 ON VHFHAQ.NodeID = VHFHAQ2.NodeParentID
--INNER JOIN dbo.View_HFit_HealthAssesmentAnswers AS VHFHAA2 ON VHFHAQ2.NodeID = VHFHAA2.NodeParentID

--Branching Level 1 Question 
	INNER JOIN dbo.View_HFit_HealthAssesmentQuestions AS VHFHAQ3 ON VHFHAA.NodeID = VHFHAQ3.NodeParentID
	LEFT OUTER JOIN dbo.View_HFit_HealthAssesmentAnswers AS VHFHAA3 ON VHFHAQ3.NodeID = VHFHAA3.NodeParentID

--Matrix Level 2 Question Group
--INNER JOIN dbo.View_HFit_HealthAssesmentQuestions AS VHFHAQ7 ON VHFHAQ3.NodeID = VHFHAQ7.NodeParentID
--INNER JOIN dbo.View_HFit_HealthAssesmentAnswers AS VHFHAA7 ON VHFHAQ7.NodeID = VHFHAA7.NodeParentID

--Matrix branching level 1 question group
--INNER JOIN dbo.View_HFit_HealthAssesmentQuestions AS VHFHAQ8 ON VHFHAA7.NodeID = VHFHAQ8.NodeParentID
--INNER JOIN dbo.View_HFit_HealthAssesmentAnswers AS VHFHAA8 ON VHFHAQ8.NodeID = VHFHAA8.NodeParentID

--Branching level 2 Question Group
	INNER JOIN dbo.View_HFit_HealthAssesmentQuestions AS VHFHAQ4 ON VHFHAA3.NodeID = VHFHAQ4.NodeParentID
	INNER JOIN dbo.View_HFit_HealthAssesmentAnswers AS VHFHAA4 ON VHFHAQ4.NodeID = VHFHAA4.NodeParentID

--Branching level 3 Question Group
	INNER JOIN dbo.View_HFit_HealthAssesmentQuestions AS VHFHAQ5 ON VHFHAA4.NodeID = VHFHAQ5.NodeParentID
	INNER JOIN dbo.View_HFit_HealthAssesmentAnswers AS VHFHAA5 ON VHFHAQ5.NodeID = VHFHAA5.NodeParentID

--Branching level 4 Question Group
	INNER JOIN dbo.View_HFit_HealthAssesmentQuestions AS VHFHAQ6 ON VHFHAA5.NodeID = VHFHAQ6.NodeParentID
	INNER JOIN dbo.View_HFit_HealthAssesmentAnswers AS VHFHAA6 ON VHFHAQ6.NodeID = VHFHAA6.NodeParentID
	WHERE
		VHFHAMJ.NodeName = 'Custom'
Union ALL
	SELECT
		cs.SiteGUID
		, HFA.AccountCD
		, VCTJ.NodeID
		, VCTJ.NodeName
		, VCTJ.DocumentID
		, VCTJ.NodeSiteID
       --,VCTJ.NodeAliasPath
		, VCTJ.DocumentPublishedVersionHistoryID
		, VHFHAMJ.Title
		, dbo.udf_StripHTML(VHFHAMJ.IntroText) AS IntroText
		, VHFHAMJ.DocumentID
		, VHFHAMJ.Weight
		, VHFHAMJ.IsEnabled
		, VHFHAMJ.CodeName
       --,VHFHAMJ.NodeAliasPath
		, VHFHAMJ.DocumentPublishedVersionHistoryID
		, VHFHARCJ.Title
		, VHFHARCJ.Weight
		, VHFHARCJ.DocumentID
		, VHFHARCJ.IsEnabled
		, VHFHARCJ.CodeName
       --,VHFHARCJ.NodeAliasPath
		, VHFHARCJ.DocumentPublishedVersionHistoryID
		, VHFHARAJ.Title
		, VHFHARAJ.Weight
		, VHFHARAJ.DocumentID
		, VHFHARAJ.IsEnabled
		, VHFHARAJ.CodeName
       --,VHFHARAJ.NodeAliasPath
		, VHFHARAJ.ScoringStrategyID
		, VHFHARAJ.DocumentPublishedVersionHistoryID
		, VHFHAQ9.QuestionType
		, dbo.udf_StripHTML(VHFHAQ9.Title) AS QuesTitle
		, VHFHAQ9.Weight
		, VHFHAQ9.IsRequired
		, VHFHAQ9.DocumentID
		, VHFHAQ9.IsEnabled
		, VHFHAQ9.IsVisible
		, VHFHAQ9.IsStaging
		, VHFHAQ9.CodeName AS QuestionCodeName
       --,VHFHAQ9.NodeAliasPath
		, VHFHAQ9.DocumentPublishedVersionHistoryID
		, VHFHAA9.Value
		, VHFHAA9.Points
		, VHFHAA9.DocumentID
		, VHFHAA9.IsEnabled
		, VHFHAA9.CodeName
		, VHFHAA9.UOM
       --,VHFHAA9.NodeAliasPath
		, VHFHAA9.DocumentPublishedVersionHistoryID
		, CASE	WHEN CAST(VCTJ.DocumentCreatedWhen AS DATE) = CAST(vctj.DocumentModifiedWhen AS DATE)
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		, VCTJ.DocumentCreatedWhen
		, VCTJ.DocumentModifiedWhen
	FROM
		dbo.View_CMS_Tree_Joined AS VCTJ
	INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
	INNER JOIN dbo.HFit_Account AS HFA ON cs.SiteID = hfa.SiteID
	INNER JOIN dbo.View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ ON VCTJ.NodeID = VHFHAMJ.NodeParentID
	INNER JOIN dbo.View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
	INNER JOIN dbo.View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
--level 1 question
	INNER JOIN dbo.View_HFit_HealthAssesmentQuestions AS VHFHAQ ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
--Level 1 Answers
	LEFT OUTER JOIN dbo.View_HFit_HealthAssesmentAnswers AS VHFHAA ON VHFHAQ.NodeID = VHFHAA.NodeParentID

--matrix level 1 questiongroup
--INNER JOIN dbo.View_HFit_HealthAssesmentQuestions AS VHFHAQ2 ON VHFHAQ.NodeID = VHFHAQ2.NodeParentID
--INNER JOIN dbo.View_HFit_HealthAssesmentAnswers AS VHFHAA2 ON VHFHAQ2.NodeID = VHFHAA2.NodeParentID

--Branching Level 1 Question 
	INNER JOIN dbo.View_HFit_HealthAssesmentQuestions AS VHFHAQ3 ON VHFHAA.NodeID = VHFHAQ3.NodeParentID
	LEFT OUTER JOIN dbo.View_HFit_HealthAssesmentAnswers AS VHFHAA3 ON VHFHAQ3.NodeID = VHFHAA3.NodeParentID

--Matrix Level 2 Question Group
--INNER JOIN dbo.View_HFit_HealthAssesmentQuestions AS VHFHAQ7 ON VHFHAQ3.NodeID = VHFHAQ7.NodeParentID
--INNER JOIN dbo.View_HFit_HealthAssesmentAnswers AS VHFHAA7 ON VHFHAQ7.NodeID = VHFHAA7.NodeParentID

--Matrix branching level 1 question group
--INNER JOIN dbo.View_HFit_HealthAssesmentQuestions AS VHFHAQ8 ON VHFHAA7.NodeID = VHFHAQ8.NodeParentID
--INNER JOIN dbo.View_HFit_HealthAssesmentAnswers AS VHFHAA8 ON VHFHAQ8.NodeID = VHFHAA8.NodeParentID

--Branching level 2 Question Group
	INNER JOIN dbo.View_HFit_HealthAssesmentQuestions AS VHFHAQ4 ON VHFHAA3.NodeID = VHFHAQ4.NodeParentID
	INNER JOIN dbo.View_HFit_HealthAssesmentAnswers AS VHFHAA4 ON VHFHAQ4.NodeID = VHFHAA4.NodeParentID

--Branching level 3 Question Group
	INNER JOIN dbo.View_HFit_HealthAssesmentQuestions AS VHFHAQ5 ON VHFHAA4.NodeID = VHFHAQ5.NodeParentID
	INNER JOIN dbo.View_HFit_HealthAssesmentAnswers AS VHFHAA5 ON VHFHAQ5.NodeID = VHFHAA5.NodeParentID

--Branching level 4 Question Group
	INNER JOIN dbo.View_HFit_HealthAssesmentQuestions AS VHFHAQ6 ON VHFHAA5.NodeID = VHFHAQ6.NodeParentID
	INNER JOIN dbo.View_HFit_HealthAssesmentAnswers AS VHFHAA6 ON VHFHAQ6.NodeID = VHFHAA6.NodeParentID

--Branching level 5 Question Group
	INNER JOIN dbo.View_HFit_HealthAssesmentQuestions AS VHFHAQ9 ON VHFHAA6.NodeID = VHFHAQ9.NodeParentID
	INNER JOIN dbo.View_HFit_HealthAssesmentAnswers AS VHFHAA9 ON VHFHAQ9.NodeID = VHFHAA9.NodeParentID
	WHERE
		VHFHAMJ.NodeName = 'Custom' 





GO

IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
GO
-- Create View [dbo].[view_EDW_HealthAssesment]
Print 'Create View [dbo].[view_EDW_HealthAssesment]'
GO
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
GO
CREATE VIEW [dbo].[view_EDW_HealthAssesment]
AS
--7/15/2014 17:19 min. 46,750 Rows DEV
--7/15/2014 per Mark Turner
--HAModuleDocumentID is on its way out, so is - 
--Module - RiskCategory - RiskArea - Question - Answer 
--all the "DocumentID" fields are deprecated and replaced by corresponding NodeGUID fields
	SELECT 
		haus.ItemID AS UserStartedItemID
		, hauq.HAQuestionNodeGUID as HADocumentID
		, haus.UserID
		, cu.UserGUID
		, cus2.HFitUserMpiNumber
		, cs.SiteGUID
		, HFA.AccountID
		, HFA.AccountCD
		, haus.HAStartedDt
		, haus.HACompletedDt
		, haum.ItemID AS UserModuleItemId
		, haum.CodeName AS UserModuleCodeName
		, haum.HAModuleNodeGUID as HAModuleDocumentID
		, NULL as HAModuleVersionID
		, haurc.ItemID AS UserRiskCategoryItemID
		, haurc.CodeName AS UserRiskCategoryCodeName
		, haurc.HARiskCategoryNodeGUID as HARiskCategoryDocumentID
		, NULL as HARiskCategoryVersionID
		, haura.ItemID AS UserRiskAreaItemID
		, haura.CodeName AS UserRiskAreaCodeName
		, haura.HARiskAreaNodeGUID as HARiskAreaDocumentID
		, NULL as HARiskAreaVersionID
		, hauq.ItemID AS UserQuestionItemID
		, VHFHAQ.Title
		, hauq.CodeName AS UserQuestionCodeName
		, hauq.HAQuestionNodeGUID as HAQuestionDocumentID
		, NULL as HAQuestionVersionID
		, haua.ItemID AS UserAnswerItemID
		, haua.HAAnswerNodeGUID as HAAnswerDocumentID
		, NULL as HAAnswerVersionID
		, haua.CodeName AS UserAnswerCodeName
		, haua.HAAnswerValue
		, haum.HAModuleScore
		, haurc.HARiskCategoryScore
		, haura.HARiskAreaScore
		, hauq.HAQuestionScore
		, haua.HAAnswerPoints
		, HFHAUQGR.PointResults
		, haua.UOMCode
		, haus.HAScore
		, haum.PreWeightedScore AS ModulePreWeightedScore
		, haurc.PreWeightedScore AS RiskCategoryPreWeightedScore
		, haura.PreWeightedScore AS RiskAreaPreWeightedScore
		, hauq.PreWeightedScore AS QuestionPreWeightedScore
		, HFHAUQGR.CodeName AS QuestionGroupCodeName
       --,CASE WHEN haua.ItemCreatedWhen = haua.ItemModifiedWhen THEN 'I'
       --      ELSE 'U'
       -- END AS ChangeType
       --,haua.ItemCreatedWhen
       --,haua.ItemModifiedWhen
		, CASE cdc.Operation
			WHEN 2 THEN 'I'
			WHEN 4 THEN 'U'
			END AS ChangeType
		, cdc.InsertUpdateDate
		, CASE cdc.Operation
			WHEN 2 THEN cdc.InsertUpdateDate
			END AS InsertDate
		, CASE cdc.Operation
			WHEN 4 THEN cdc.InsertUpdateDate
			END AS UpdateDate
	FROM
		dbo.HFit_HealthAssesmentUserStarted AS haus
	INNER JOIN dbo.CMS_User AS CU ON haus.UserID = cu.UserID
	INNER JOIN dbo.CMS_UserSettings AS CUS2 ON CUS2.UserSettingsUserID = CU.UserID
	INNER JOIN dbo.CMS_UserSite AS CUS ON CU.UserID = CUS.UserID
	INNER JOIN dbo.CMS_Site AS CS ON CUS.SiteID = CS.SiteID
	INNER JOIN dbo.HFit_Account AS HFA ON hfa.SiteID = cs.SiteID
	INNER JOIN dbo.HFit_HealthAssesmentUserModule AS haum ON haus.ItemID = haum.HAStartedItemID
	INNER JOIN dbo.HFit_HealthAssesmentUserRiskCategory AS haurc ON haum.ItemID = haurc.HAModuleItemID
	INNER JOIN dbo.HFit_HealthAssesmentUserRiskArea AS haura ON haurc.ItemID = haura.HARiskCategoryItemID
	INNER JOIN dbo.HFit_HealthAssesmentUserQuestion AS hauq ON haura.ItemID = hauq.HARiskAreaItemID
	INNER JOIN dbo.View_HFit_HealthAssesmentQuestions AS VHFHAQ 
		ON hauq.HAQuestionNodeGUID = VHFHAQ.NodeGUID
	LEFT OUTER JOIN dbo.HFit_HealthAssesmentUserQuestionGroupResults AS HFHAUQGR ON hauq.ItemID = HFHAUQGR.HARiskAreaItemID
	INNER JOIN dbo.HFit_HealthAssesmentUserAnswers AS haua ON hauq.ItemID = haua.HAQuestionItemID
	INNER JOIN (
					SELECT
						MAX(ltm.tran_begin_time) InsertUpdateDate
						, DHFHAUAC.ItemID
						, MAX(DHFHAUAC.[__$operation]) Operation
					FROM
						cdc.dbo_HFit_HealthAssesmentUserAnswers_CT AS DHFHAUAC
					INNER JOIN cdc.lsn_time_mapping AS LTM ON DHFHAUAC.[__$start_lsn] = LTM.start_lsn
					WHERE
						DHFHAUAC.[__$operation] IN ( 2, 4 )
					GROUP BY
						DHFHAUAC.ItemID
				) AS CDC ON haua.ItemID = CDC.ItemID



GO

IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
GO

IF @@TRANCOUNT>0
	COMMIT

SET NOEXEC OFF


-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
