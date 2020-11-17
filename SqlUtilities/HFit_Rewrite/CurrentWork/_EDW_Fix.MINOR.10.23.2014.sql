--****************************************************************
-- NOTE: This database name must be changed in MANY places in 
--	this script. Please search and change.
--****************************************************************
use KenticoCMS_DEV
go


--***************************************************************
--***************************************************************

--use KenticoCMS_Prod1
--go 

GO

if NOT exists(select name from sys.indexes where name = 'PI_HAUserStart')
BEGIN
	CREATE NONCLUSTERED INDEX PI_HAUserStart
	ON [dbo].[HFit_HealthAssesmentUserStarted] ([HACampaignNodeGUID])
	INCLUDE ([ItemID],[UserID])
END

if NOT exists(select name from sys.indexes where name = 'PI_CMSTREE_ClassDocID')
BEGIN
	CREATE NONCLUSTERED INDEX PI_CMSTR_ClassCulture
	ON [dbo].[View_CMS_Tree_Joined_Regular] ([ClassName],[DocumentCulture])
	INCLUDE ([NodeGUID],[DocumentForeignKeyValue])
END
GO

if NOT exists(select name from sys.indexes where name = 'PI_CMSTREE_ClassDocID')
BEGIN
	CREATE NONCLUSTERED INDEX PI_CMSTREE_ClassDocID
	ON [dbo].[View_CMS_Tree_Joined_Regular] ([ClassName],[DocumentID])
END
go

if NOT exists(select name from sys.indexes where name = 'CI_CMSTree_ClassLang')
BEGIN
	CREATE NONCLUSTERED INDEX CI_CMSTree_ClassLang
	ON [dbo].[View_CMS_Tree_Joined_Regular] ([ClassName],[DocumentCulture])
	INCLUDE ([NodeID],[NodeAliasPath],[NodeParentID],[NodeLevel],[NodeGUID],[NodeOrder],[NodeLinkedNodeID],[DocumentModifiedWhen],[DocumentForeignKeyValue],[DocumentPublishedVersionHistoryID],[DocumentGUID])
END


if NOT exists(select name from sys.indexes where name = 'CI_HFit_HealthAssesmentUserQuestion_NodeGUID')
BEGIN
	CREATE NONCLUSTERED INDEX [ci_HFit_HealthAssesmentUserQuestion_NodeGUID]
	ON [dbo].[HFit_HealthAssesmentUserQuestion] ([HAQuestionNodeGUID])
	INCLUDE ([ItemID],[HAQuestionScore],[ItemModifiedWhen],[HARiskAreaItemID],[CodeName],[PreWeightedScore],[IsProfessionallyCollected])
END
GO

if NOT exists(select name from sys.indexes where name = 'PI_GuidLang')
BEGIN
	CREATE NONCLUSTERED INDEX [PI_GuidLang]
	ON [dbo].[View_CMS_Tree_Joined_Regular] ([NodeGUID],[DocumentCulture])
END
Go

if NOT exists(select name from sys.indexes where name = 'PI_ClassLang')
BEGIN
	CREATE NONCLUSTERED INDEX PI_ClassLang
	ON [dbo].[View_CMS_Tree_Joined_Regular] ([ClassName],[DocumentCulture])
	INCLUDE ([NodeGUID],[DocumentForeignKeyValue])
END
GO

if NOT exists(select name from sys.indexes where name = 'PI_Linked_ClassLang')
BEGIN
CREATE NONCLUSTERED INDEX PI_Linked_ClassLang
	ON [dbo].[View_CMS_Tree_Joined_Linked] ([ClassName],[DocumentCulture])
	INCLUDE ([NodeGUID],[DocumentForeignKeyValue])
END
GO        

--drop index [dbo].[View_CMS_Tree_Joined_Regular].[IX_View_CMS_Tree_Joined_Regular_NodeSiteID_DocumentCulture_NodeID]
--go

--CREATE UNIQUE CLUSTERED INDEX [IX_View_CMS_Tree_Joined_Regular_NodeSiteID_DocumentCulture_NodeID] 
--ON [dbo].[View_CMS_Tree_Joined_Regular]
--(
-- [NodeSiteID] ASC,
-- [DocumentCulture] ASC,
-- [NodeID] ASC,
-- [NodeParentID] ASC,
-- [DocumentID] ASC,
-- [DocumentPublishedVersionHistoryID] ASC,
-- [DocumentGUID] ASC
--)

GO

PRINT('Processing view_EDW_HealthAssesment');
GO


if exists(select name from sys.views where name = 'view_EDW_HealthAssesmentV2')
BEGIN
	drop view view_EDW_HealthAssesmentV2 
END
go

CREATE VIEW [dbo].[view_EDW_HealthAssesmentV2]
AS
--********************************************************************************************************
--7/15/2014 17:19 min. 46,750 Rows DEV
--7/15/2014 per Mark Turner
--HAModuleDocumentID is on its way out, so is - 
--Module - RiskCategory - RiskArea - Question - Answer 
--all the "DocumentID" fields are deprecated and replaced by corresponding NodeGUID fields
--8/7/2014 - Executed in DEV with GUID changes and returned 51K Rows in 00:43:10.
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

-- 10.23.2014 - (WDM) added two columns for the EDW HAPaperFlg / HATelephonicFlg
--			HAPaperFlg is whether the question was reveived electronically or on paper
--			HATelephonicFlg is whether the question was reveived by telephone or not

-- FIVE Pieces needed per John C. 10.16.2014
--	Document GUID -> HealthAssesmentUserStartedNodeGUID
--	Module GUID -> Module -> HAUserModule.HAModuleNodeGUID
--	Category GUID -> Category
--	RiskArea Node Guid -> RiskArea 
--	Question Node Guid -> Question
--	Answer Node Guid -> Answer 

 --   10.30.2014 : Sowmiya 
 --   The following are the possible values allowed in the HAStartedMode and HACompletedMode columns of the Hfit_HealthAssesmentUserStarted table
 --      Unknown = 0, 
 --       Paper = 1,  // Paper HA
 --       Telephonic = 2, // Telephonic HA
 --       Online = 3, // Online HA
 --       Ipad = 4 // iPAD
--********************************************************************************************************

	--11.05.2014 - removed the Distinct - may find it necessary to put it back as duplicates may be there.
	SELECT  --distinct
		HAUserStarted.ItemID AS UserStartedItemID				
		, VHAJ.NodeGUID as  HealthAssesmentUserStartedNodeGUID	--Per John C. 10.16.2014 requested that this be put back into the view.	
																--11.05.2014 - Changed from CMS_TREE Joined to View_HFit_HealthAssessment_Joined Mark T. / Dale M.
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
		
		--, VCTJ.DocumentGUID as HAModuleNodeGUID	--WDM 8/7/2014 as HAModuleDocumentID
		--, VCTJ.NodeGUID as HAModuleNodeGUID		--WDM 9/30/2014 as HAModuleDocumentID	--Mark and Dale use NodeGUID instead of Doc GUID
		--, VCTJ.NodeGUID as CMSNodeGuid			--WDM 8/7/2014 as HAModuleDocumentID	--Left this and the above to kepp existing column structure

		, HAUserModule.HAModuleNodeGUID				--WDM 9/30/2014 as HAModuleDocumentID	--Mark and Dale use NodeGUID instead of Doc GUID
		
		--, NULL as CMSNodeGuid						--WDM 8/7/2014 as HAModuleDocumentID	--WDM 10.02.2014 place holder for EDW ETL
		, VHAJ.NodeGUID as CMSNodeGuid				--WDM 8/7/2014 as HAModuleDocumentID	--WDM 10.02.2014 place holder for EDW ETL per John C., Added back per John C. 10.16.2014

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
		, NULL as HAQuestionDocumentID	--WDM 10.1.2014 - this is GOING AWAY 		--WDM 10.02.2014 place holder for EDW ETL
		, NULL as HAQuestionVersionID			--WDM 10.1.2014 - this is GOING AWAY - no versions across environments 		--WDM 10.02.2014 place holder for EDW ETL
		, HAUserQuestion.HAQuestionNodeGUID		--WDM 10.01.2014	Left this in place to preserve column structure.		
		, HAUserAnswers.ItemID AS UserAnswerItemID
		, HAUserAnswers.HAAnswerNodeGUID								--WDM 8/7/2014 as HAAnswerDocumentID
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
	   ,HAUserStarted.HAPaperFlg
	   ,HAUserStarted.HATelephonicFlg
	   ,HAUserStarted.HAStartedMode
	   ,HAUserStarted.HACompletedMode
	FROM
	dbo.HFit_HealthAssesmentUserStarted AS HAUserStarted
	INNER JOIN dbo.CMS_User AS CMSUser ON HAUserStarted.UserID = CMSUser.UserID
	INNER JOIN dbo.CMS_UserSettings AS UserSettings ON UserSettings.UserSettingsUserID = CMSUser.UserID
	INNER JOIN dbo.CMS_UserSite AS UserSite ON CMSUser.UserID = UserSite.UserID
	INNER JOIN dbo.CMS_Site AS CMSSite ON UserSite.SiteID = CMSSite.SiteID
	INNER JOIN dbo.HFit_Account AS ACCT ON ACCT.SiteID = CMSSite.SiteID	
	INNER JOIN dbo.HFit_HealthAssesmentUserModule AS HAUserModule ON HAUserStarted.ItemID = HAUserModule.HAStartedItemID
		
	inner join View_HFit_HACampaign_Joined VHCJ on VHCJ.NodeGUID = HAUserStarted.HACampaignNodeGUID 
		AND VHCJ.NodeSiteID = UserSite.SiteID AND VHCJ.DocumentCulture = 'en-US'	--11.05.2014 - Mark T. / Dale M. - 
	
	--11.05.2014 - Mark T. / Dale M. needed to get the Document for the user
	inner join View_HFit_HealthAssessment_Joined VHAJ on VHAJ.DocumentID = VHCJ.HealthAssessmentID
	
	--11.05.2014 - Mark T. / Dale M. removed the link to View_CMS_Tree_Joined and replaced with View_HFit_HealthAssessment_Joined
	--inner join View_CMS_Tree_Joined as VCTJ on VCTJ.NodeGUID = HAUserModule.HAModuleNodeGUID
	--	and VCTJ.DocumentCulture = 'en-US'	--10.01.2014 put here to match John C. req. for language agnostic.

	INNER JOIN dbo.HFit_HealthAssesmentUserRiskCategory AS HARiskCategory ON HAUserModule.ItemID = HARiskCategory.HAModuleItemID
	INNER JOIN dbo.HFit_HealthAssesmentUserRiskArea AS HAUserRiskArea ON HARiskCategory.ItemID = HAUserRiskArea.HARiskCategoryItemID
	INNER JOIN dbo.HFit_HealthAssesmentUserQuestion AS HAUserQuestion ON HAUserRiskArea.ItemID = HAUserQuestion.HARiskAreaItemID
	INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS HAQuestionsView ON HAUserQuestion.HAQuestionNodeGUID = HAQuestionsView.NodeGUID
		AND HAQuestionsView.DocumentCulture = 'en-US'
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
	where VHFHAPAJ.DocumentCulture = 'en-US'

GO

print ('Processed: View_EDW_HealthAssesmentAnswers ') ;
go





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



  --  
  --  
GO 
print('***** FROM: _EDW_Fix.MINOR.10.23.2014.sql'); 
GO 
