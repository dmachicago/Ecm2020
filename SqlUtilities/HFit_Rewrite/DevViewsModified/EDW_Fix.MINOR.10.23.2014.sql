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



