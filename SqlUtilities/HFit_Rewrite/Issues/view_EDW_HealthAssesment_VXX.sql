

GO

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


if exists(select name from sys.views where name = 'view_EDW_HealthAssesment')
BEGIN
	drop view view_EDW_HealthAssesment 
END
go

CREATE VIEW [dbo].[view_EDW_HealthAssesment_VXX]
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
 -- 11.05.2014 - Mark T. / Dale M. needed to get the Document for the user : ADDED inner join View_HFit_HealthAssessment_Joined as VHAJ on VHAJ.DocumentID = VHCJ.HealthAssessmentID
--********************************************************************************************************

	--11.05.2014 - removed the Distinct - may find it necessary to put it back as duplicates may be there. But the server resources required to do this may not be avail on P5.
	SELECT  --distinct		--12.02.2014 (wdm) Added the distinct back becuase dups surfaced.
		HAUserStarted.ItemID AS UserStartedItemID				
		,VHAJ.NodeGUID as  HealthAssesmentUserStartedNodeGUID	--Per John C. 10.16.2014 requested that this be put back into the view.	
														--11.05.2014 - Changed from CMS_TREE Joined to View_HFit_HealthAssessment_Joined Mark T. / Dale M.
		,HAUserStarted.UserID
		,CMSUser.UserGUID
		,UserSettings.HFitUserMpiNumber
		,CMSSite.SiteGUID
		,ACCT.AccountID
		,ACCT.AccountCD
		,HAUserStarted.HAStartedDt
		,HAUserStarted.HACompletedDt
		,HAUserModule.ItemID AS UserModuleItemId
		,HAUserModule.CodeName AS UserModuleCodeName
		
		--,VCTJ.DocumentGUID as HAModuleNodeGUID	--WDM 8/7/2014 as HAModuleDocumentID
		--,VCTJ.NodeGUID as HAModuleNodeGUID		--WDM 9/30/2014 as HAModuleDocumentID	--Mark and Dale use NodeGUID instead of Doc GUID
		--,VCTJ.NodeGUID as CMSNodeGuid			--WDM 8/7/2014 as HAModuleDocumentID	--Left this and the above to kepp existing column structure

		,HAUserModule.HAModuleNodeGUID				--WDM 9/30/2014 as HAModuleDocumentID	--Mark and Dale use NodeGUID instead of Doc GUID
		
		--,NULL as CMSNodeGuid						--WDM 8/7/2014 as HAModuleDocumentID	--WDM 10.02.2014 place holder for EDW ETL
		,VHAJ.NodeGUID as CMSNodeGuid				--WDM 8/7/2014 as HAModuleDocumentID	--WDM 10.02.2014 place holder for EDW ETL per John C.,Added back per John C. 10.16.2014

		,NULL as HAModuleVersionID		--WDM 10.02.2014 place holder for EDW ETL
		,HARiskCategory.ItemID AS UserRiskCategoryItemID
		,HARiskCategory.CodeName AS UserRiskCategoryCodeName
		,HARiskCategory.HARiskCategoryNodeGUID						--WDM 8/7/2014 as HARiskCategoryDocumentID
		,NULL as HARiskCategoryVersionID			--WDM 10.02.2014 place holder for EDW ETL
		,HAUserRiskArea.ItemID AS UserRiskAreaItemID
		,HAUserRiskArea.CodeName AS UserRiskAreaCodeName
		,HAUserRiskArea.HARiskAreaNodeGUID							--WDM 8/7/2014 as HARiskAreaDocumentID
		,NULL as HARiskAreaVersionID			--WDM 10.02.2014 place holder for EDW ETL
		,HAUserQuestion.ItemID AS UserQuestionItemID
		,HAQuestionsView.Title
		,HAUserQuestion.HAQuestionNodeGUID	as HAQuestionGuid		--WDM 9.2.2014	This is a repeat field but had to stay to match the previous view - this is the NODE GUID 
		--															and matches to the definition file to get the question. This tells you the question,language agnostic.
		,HAUserQuestion.CodeName AS UserQuestionCodeName
		,NULL as HAQuestionDocumentID	--WDM 10.1.2014 - this is GOING AWAY 		--WDM 10.02.2014 place holder for EDW ETL
		,NULL as HAQuestionVersionID			--WDM 10.1.2014 - this is GOING AWAY - no versions across environments 		--WDM 10.02.2014 place holder for EDW ETL
		,HAUserQuestion.HAQuestionNodeGUID		--WDM 10.01.2014	Left this in place to preserve column structure.		
		,HAUserAnswers.ItemID AS UserAnswerItemID
		,HAUserAnswers.HAAnswerNodeGUID								--WDM 8/7/2014 as HAAnswerDocumentID
		,NULL as HAAnswerVersionID		--WDM 10.1.2014 - this is GOING AWAY - no versions across environments		--WDM 10.02.2014 place holder for EDW ETL
		,HAUserAnswers.CodeName AS UserAnswerCodeName
		,HAUserAnswers.HAAnswerValue
		,HAUserModule.HAModuleScore
		,HARiskCategory.HARiskCategoryScore
		,HAUserRiskArea.HARiskAreaScore
		,HAUserQuestion.HAQuestionScore
		,HAUserAnswers.HAAnswerPoints
		,HAUserQuestionGroupResults.PointResults
		,HAUserAnswers.UOMCode
		,HAUserStarted.HAScore
		,HAUserModule.PreWeightedScore AS ModulePreWeightedScore
		,HARiskCategory.PreWeightedScore AS RiskCategoryPreWeightedScore
		,HAUserRiskArea.PreWeightedScore AS RiskAreaPreWeightedScore
		,HAUserQuestion.PreWeightedScore AS QuestionPreWeightedScore
		,HAUserQuestionGroupResults.CodeName AS QuestionGroupCodeName       
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
		--,HAUserStarted.HAStartedMode
		--,HAUserStarted.HACompletedMode

		,VHCJ.DocumentCulture as DocumentCulture_VHCJ
		,HAQuestionsView.DocumentCulture as DocumentCulture_HAQuestionsView

select count(*) as CNT
		,HAUserStarted.[ItemID]
		,HAUserStarted.[UserID]
		,HAUserStarted.[HAPaperFlg]
		,HAUserStarted.[HAIPadFlg]
		,HAUserStarted.[HAStartedDt]
		,HAUserStarted.[HACompletedDt]
		,UserGUID
		,UserSettings.HFitUserMpiNumber
		,UserSettings.HFitUserMpiNumber
		,CMSSite.SiteGUID
		,ACCT.AccountID
		,ACCT.AccountCD
		,HAUserModule.ItemID AS UserModuleItemId
		,HAUserModule.CodeName AS UserModuleCodeName
		,HAUserModule.HAModuleNodeGUID	
		,HAUserModule.HAModuleScore
		,HAUserModule.PreWeightedScore AS ModulePreWeightedScore
		,VHCJ.DocumentCulture as DocumentCulture_VHCJ
		,VHAJ.NodeGUID as  HealthAssesmentUserStartedNodeGUID
		,VHAJ.NodeGUID as CMSNodeGuid		
		,HARiskCategory.ItemID AS UserRiskCategoryItemID
		,HARiskCategory.CodeName AS UserRiskCategoryCodeName
		,HARiskCategory.HARiskCategoryNodeGUID		
		,HARiskCategory.HARiskCategoryScore			
		,HARiskCategory.PreWeightedScore AS RiskCategoryPreWeightedScore	
		,HARiskCategory.ItemModifiedWhen as HARiskCategory_ItemModifiedWhen		
		,HAUserRiskArea.ItemID AS UserRiskAreaItemID
		,HAUserRiskArea.CodeName AS UserRiskAreaCodeName
		,HAUserRiskArea.HARiskAreaNodeGUID							--WDM 8/7/2014 as HARiskAreaDocumentID
		,HAUserRiskArea.HARiskAreaScore
		,HAUserRiskArea.PreWeightedScore AS RiskAreaPreWeightedScore
		,HAUserRiskArea.ItemModifiedWhen as HAUserRiskArea_ItemModifiedWhen
		,HAUserQuestion.ItemID AS UserQuestionItemID
		,HAUserQuestion.HAQuestionNodeGUID	as HAQuestionGuid	
		,HAUserQuestion.CodeName AS UserQuestionCodeName	
		,HAUserQuestion.HAQuestionNodeGUID
		,HAUserQuestion.HAQuestionScore		
		,HAUserQuestion.PreWeightedScore AS QuestionPreWeightedScore
		,HAUserQuestion.IsProfessionallyCollected
		,HAUserQuestion.ItemModifiedWhen as HAUserQuestion_ItemModifiedWhen
		,HAQuestionsView.Title
		,HAQuestionsView.DocumentCulture as DocumentCulture_HAQuestionsView
		
		,HAUserQuestionGroupResults.PointResults
		,HAUserQuestionGroupResults.CodeName AS QuestionGroupCodeName      
		
		,HAUserAnswers.ItemID AS UserAnswerItemID
		,HAUserAnswers.HAAnswerNodeGUID
		--,NULL as HAAnswerVersionID
		,HAUserAnswers.CodeName AS UserAnswerCodeName
		,HAUserAnswers.HAAnswerValue
		,HAUserAnswers.HAAnswerPoints
		,HAUserAnswers.UOMCode
		,HAUserAnswers.ItemCreatedWhen
		,HAUserAnswers.ItemModifiedWhen
		,HAUserAnswers.ItemModifiedWhen as HAUserAnswers_ItemModifiedWhen
		,HAUserAnswers.ItemCreatedWhen 
		,HAUserAnswers.ItemModifiedWhen
		,HAUserQuestionGroupResults.ItemCreatedWhen		--This is causing DUPS
		,HAUserQuestionGroupResults.ItemModifiedWhen	--This is causing DUPS
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
	inner join View_HFit_HealthAssessment_Joined as VHAJ on VHAJ.DocumentID = VHCJ.HealthAssessmentID									--This caused a slow down in response 12.3.2014 0505
	INNER JOIN dbo.HFit_HealthAssesmentUserRiskCategory AS HARiskCategory ON HAUserModule.ItemID = HARiskCategory.HAModuleItemID		--This caused an increased slow down in response 12.3.2014 0515
	INNER JOIN dbo.HFit_HealthAssesmentUserRiskArea AS HAUserRiskArea ON HARiskCategory.ItemID = HAUserRiskArea.HARiskCategoryItemID	--This caused an increased  slow down in response 12.3.2014 0521
	INNER JOIN dbo.HFit_HealthAssesmentUserQuestion AS HAUserQuestion ON HAUserRiskArea.ItemID = HAUserQuestion.HARiskAreaItemID		--This caused an increased  slow down in response 12.3.2014 0612
	INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS HAQuestionsView ON HAUserQuestion.HAQuestionNodeGUID = HAQuestionsView.NodeGUID	--Greater slow down
		AND HAQuestionsView.DocumentCulture = 'en-US'

	--This is the problem area causing DUPS 12.3.2014 (wdm)
	Left Outer JOIN dbo.HFit_HealthAssesmentUserQuestionGroupResults AS HAUserQuestionGroupResults ON HAUserRiskArea.ItemID = HAUserQuestionGroupResults.HARiskAreaItemID
		AND HAUserQuestionGroupResults.UserID = HAUserStarted.[UserID]	--(wdm) added 12.02.2014 to see if it made a diff and it did not
	INNER JOIN dbo.HFit_HealthAssesmentUserAnswers AS HAUserAnswers ON HAUserQuestion.ItemID = HAUserAnswers.HAQuestionItemID
--where HAUserStarted.[ItemID] in (45140,62242,38586,32462,59436,45853,65790,31892,73134,65798,69954,33617,56152,65774,35337,33572,44886,35496,45893,38556,34996,51920,39235,60323,36364,36330,35911,59250,34592,74059,34953,16977,39391,35881,34910,37343,65800,63331,33499,33565,74131,30862,45126,63419,36953,36813,30811,35250,31954,74051,49466,54126,62758,32437,37005,39577,39324,62950,41532,56168,41378,57067,59278,45298,31950,40752,62954,63593,34976,6205,44884,31976,62218,55651,34878,37285,35870,32558,38771,32288,47277,34516,44325,33699,47909,34021,66015,58058,31924,35715,41070,35013,35628,35701,50555,32136,31998,59407)	   
--where HAUserStarted.[ItemID] in (45140,62242,38586,32462,59436)	--Prod 1 IDs
--where HAUserStarted.[ItemID] in (47682,19442,28575)	--Prod 2 IDs
	group by
		HAUserStarted.[ItemID]
		,HAUserStarted.[UserID]
		,HAUserStarted.[HAPaperFlg]
		,HAUserStarted.[HAIPadFlg]
		,HAUserStarted.[HAStartedDt]
		,HAUserStarted.[HACompletedDt]
		,UserGUID
		,UserSettings.HFitUserMpiNumber
		,UserSettings.HFitUserMpiNumber
		,CMSSite.SiteGUID
		,ACCT.AccountID
		,ACCT.AccountCD
		,HAUserModule.ItemID 
		,HAUserModule.CodeName
		,HAUserModule.HAModuleNodeGUID	
		,HAUserModule.HAModuleScore
		,HAUserModule.PreWeightedScore
		,VHCJ.DocumentCulture
		,VHAJ.NodeGUID
		,VHAJ.NodeGUID
		,HARiskCategory.ItemID 
		,HARiskCategory.CodeName 
		,HARiskCategory.HARiskCategoryNodeGUID		
		,HARiskCategory.HARiskCategoryScore	
		,HARiskCategory.PreWeightedScore	
		,HARiskCategory.ItemModifiedWhen		
		,HAUserRiskArea.ItemID 
		,HAUserRiskArea.CodeName 
		,HAUserRiskArea.HARiskAreaNodeGUID 
		,HAUserRiskArea.HARiskAreaScore
		,HAUserRiskArea.PreWeightedScore
		,HAUserRiskArea.ItemModifiedWhen
		,HAUserQuestion.ItemID 
		,HAUserQuestion.HAQuestionNodeGUID	
		,HAUserQuestion.CodeName 
		,HAUserQuestion.HAQuestionNodeGUID
		,HAUserQuestion.HAQuestionScore
		,HAUserQuestion.PreWeightedScore
		,HAUserQuestion.IsProfessionallyCollected
		,HAUserQuestion.ItemModifiedWhen
		,HAQuestionsView.Title
		,HAQuestionsView.DocumentCulture 
		
		,HAUserQuestionGroupResults.PointResults
		,HAUserQuestionGroupResults.CodeName 	

		,HAUserAnswers.ItemID
		,HAUserAnswers.HAAnswerNodeGUID
		--,NULL as HAAnswerVersionID
		,HAUserAnswers.CodeName 
		,HAUserAnswers.HAAnswerValue
		,HAUserAnswers.HAAnswerPoints
		,HAUserAnswers.UOMCode
		,HAUserAnswers.ItemCreatedWhen
		,HAUserAnswers.ItemModifiedWhen
		,HAUserAnswers.ItemModifiedWhen 
		,HAUserAnswers.ItemCreatedWhen 
		,HAUserAnswers.ItemModifiedWhen

		,HAUserQuestionGroupResults.ItemCreatedWhen		--This is causing DUPS
		,HAUserQuestionGroupResults.ItemModifiedWhen	--This is causing DUPS
having count(*) > 1



select * from view_EDW_HealthAssesment	
where HAUserStarted.ItemID = 45893 and HAUserQuestion.ItemID = 2443691
GO

SELECT count(*) as CNT, *  
  FROM [view_EDW_HealthAssesment]
group by 
[UserStartedItemID]
      ,[HealthAssesmentUserStartedNodeGUID]
      ,[UserID]
      ,[UserGUID]
      ,[HFitUserMpiNumber]
      ,[SiteGUID]
      ,[AccountID]
      ,[AccountCD]
      ,[HAStartedDt]
      ,[HACompletedDt]
      ,[UserModuleItemId]
      ,[UserModuleCodeName]
      ,[HAModuleNodeGUID]
      ,[CMSNodeGuid]
      ,[HAModuleVersionID]
      ,[UserRiskCategoryItemID]
      ,[UserRiskCategoryCodeName]
      ,[HARiskCategoryNodeGUID]
      ,[HARiskCategoryVersionID]
      ,[UserRiskAreaItemID]
      ,[UserRiskAreaCodeName]
      ,[HARiskAreaNodeGUID]
      ,[HARiskAreaVersionID]
      ,[UserQuestionItemID]
      ,[Title]
      ,[HAQuestionGuid]
      ,[UserQuestionCodeName]
      ,[HAQuestionDocumentID]
      ,[HAQuestionVersionID]
      ,[HAQuestionNodeGUID]
      ,[UserAnswerItemID]
      ,[HAAnswerNodeGUID]
      ,[HAAnswerVersionID]
      ,[UserAnswerCodeName]
      ,[HAAnswerValue]
      ,[HAModuleScore]
      ,[HARiskCategoryScore]
      ,[HARiskAreaScore]
      ,[HAQuestionScore]
      ,[HAAnswerPoints]
      ,[PointResults]
      ,[UOMCode]
      ,[HAScore]
      ,[ModulePreWeightedScore]
      ,[RiskCategoryPreWeightedScore]
      ,[RiskAreaPreWeightedScore]
      ,[QuestionPreWeightedScore]
      ,[QuestionGroupCodeName]
      ,[ChangeType]
      ,[ItemCreatedWhen]
      ,[ItemModifiedWhen]
      ,[IsProfessionallyCollected]
      ,[HARiskCategory_ItemModifiedWhen]
      ,[HAUserRiskArea_ItemModifiedWhen]
      ,[HAUserQuestion_ItemModifiedWhen]
      ,[HAUserAnswers_ItemModifiedWhen]
      ,[HAPaperFlg]
      ,[HATelephonicFlg]
having count(*) > 1 

