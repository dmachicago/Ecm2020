
if exists(select TABLE_NAME from INFORMATION_SCHEMA.VIEWS where TABLE_NAME = 'view_EDW_HealthAssesment')
BEGIN
	drop view view_EDW_HealthAssesment ;
END

GO

--USAGE:
--Select * from view_EDW_HealthAssesment where 
--ItemModifiedWhen between '2014-08-02 00:00:00.001' and '2014-08-03 00:00:00.000'
--OR HARiskCategory_ItemModifiedWhen between '2014-08-02 00:00:00.001' and '2014-08-03 00:00:00.000'
--OR HAUserRiskArea_ItemModifiedWhen between '2014-08-02 00:00:00.001' and '2014-08-03 00:00:00.000'
--OR HAUserQuestion_ItemModifiedWhen between '2014-08-02 00:00:00.001' and '2014-08-03 00:00:00.000'
--OR HAUserAnswers_ItemModifiedWhen between '2014-08-02 00:00:00.001' and '2014-08-03 00:00:00.000'

Create VIEW [dbo].[view_EDW_HealthAssesment]
AS
--***********************************************************************************************

--select top 1000 * from view_EDW_HealthAssesment Where QuestionGroupCodeName is not NULL
--7/15/2014 17:19 min. 46,750 Rows DEV
--7/15/2014 per Mark Turner
--HAModuleDocumentID is on its way out, so is - 
--Module - RiskCategory - RiskArea - Question - Answer 
--all the "DocumentID" fields are deprecated and replaced by corresponding NodeGUID/DocumentGUID fields
--8/7/2014 - Executed in DEV with GUID changes and returned 51K Rows in 43:10.
--			Had a conversation with Matt and Mark to determine best way to join HealthAssesmentQuestions.
--			Per Matt, the join needs to executed on the HAQuestionDocumentID and replaced with the GUID
--			when it becomes available. And, CMS TREE Joind needes to be joined on HAModuleDocumentID
--			until the GUID is made available.
--8/8/2014 - Generated corrected view in DEV
--8/13/2014 - This view is NOT the same view that is required in the DEV environment.
--				At this time, two different views are required as the environments
--				are not the same, that is DEV & Prod Staging. Two sets of source code needed.
--8/14/2014 - Found that the table columns are different across environments
--8/18/2014 - John C. found that all QuestionGroupCodeName were NULL
--8/21/2014 - Uncommented the line "VHFHAQ.[DocumentGuid] as HAQuestionGuid" as I did not 
--				know if it would be used as well as The User Question GUID. I guess both are needed.
-- 09.11.2014 : (wdm) Verified DATES to resolve EDW last mod date issue
--********************************************************************************************************
-- 09.08.2014: John Croft and I working together, realized there is a deficit in the ability 
--of the EDW to recognize changes to database records based on the last modified date of a row. 
--The views that we are currently using in the database or deeply nested. This means that 
--several base tables are involved in building a single view of data.
--
--The views were initially designed to recognize a date change based on a record change very 
--high in the data hierarchy, the CMS Tree level which is the top most level. However, John 
--and I recognize that data can change at any level in the hierarchy and those changes must be 
--recognized as well. Currently, that is not the case. With the new modification to the views, 
--changes in CMS documents and base tables will filter up through the hierarchy and the EDW load 
--process will be able to realize that a change in this row’s data may affect and intrude into 
--the warehouse.
--***********************************************************************************************
	SELECT DISTINCT
		HAUserStarted.ItemID AS UserStartedItemID
		, HAUserStarted.HealthAssesmentUserStartedNodeGUID
		, HAUserStarted.UserID
		, HAUserStarted.HAStartedDt
		, HAUserStarted.HACompletedDt
		
		, cu.UserGUID
		, cus2.HFitUserMpiNumber
		, cs.SiteGUID
		
		, VCTJ.NodeGUID as HAModuleNodeGUID					--WDM 8/7/2014 as HAModuleDocumentID
		, VCTJ.NodeGUID as CMSNodeGuid						--WDM 8/7/2014 as CMSNodeGuid

		, HFA.AccountID
		, HFA.AccountCD		
		
		, haum.ItemID AS UserModuleItemId
		, haum.CodeName AS UserModuleCodeName
		, haum.HAModuleVersionID
		, haurc.ItemID AS UserRiskCategoryItemID
		, haurc.CodeName AS UserRiskCategoryCodeName
		, haurc.HARiskCategoryNodeGUID		--HARiskCategoryDocumentID
		, haurc.HARiskCategoryVersionID
		
		, haura.ItemID AS UserRiskAreaItemID
		, haura.CodeName AS UserRiskAreaCodeName
		, haura.HARiskAreaNodeGUID		--HARiskAreaDocumentID
		, haura.HARiskAreaVersionID
		
		, VHFHAQ.Title 
		, VHFHAQ.DocumentGuid as HAQuestionGuid
		
		, hauq.ItemID AS UserQuestionItemID
		, hauq.CodeName AS UserQuestionCodeName
		, hauq.HAQuestionDocumentID
		, hauq.HAQuestionVersionID
		, hauq.HAQuestionNodeGUID
		, haua.ItemID AS UserAnswerItemID
		, haua.HAAnswerNodeGUID									--WDM 8/7/2014 as HAAnswerDocumentID
		, haua.HAAnswerVersionID
		, haua.CodeName AS UserAnswerCodeName
		, haua.HAAnswerValue
		, haum.HAModuleScore
		, haurc.HARiskCategoryScore
		, haura.HARiskAreaScore
		, hauq.HAQuestionScore
		, haua.HAAnswerPoints
		, HFHAUQGR.PointResults
		, haua.UOMCode

		, HAUserStarted.HAScore		
		, haum.PreWeightedScore AS ModulePreWeightedScore
		, haurc.PreWeightedScore AS RiskCategoryPreWeightedScore
		, haura.PreWeightedScore AS RiskAreaPreWeightedScore
		, hauq.PreWeightedScore AS QuestionPreWeightedScore
		
		, HFHAUQGR.CodeName AS QuestionGroupCodeName
       ,CASE WHEN haua.ItemCreatedWhen = haua.ItemModifiedWhen THEN 'I'
             ELSE 'U'
        END AS ChangeType
       ,hauq.IsProfessionallyCollected		
	
	   ,haua.ItemCreatedWhen
       ,haua.ItemModifiedWhen	   
	   ,haurc.ItemModifiedWhen as HARiskCategory_ItemModifiedWhen
	   ,haura.ItemModifiedWhen as HAUserRiskArea_ItemModifiedWhen
	   ,hauq.ItemModifiedWhen as HAUserQuestion_ItemModifiedWhen
	   ,haua.ItemModifiedWhen as HAUserAnswers_ItemModifiedWhen
FROM
	view_EDW_HFit_HealthAssesmentUserStarted AS HAUserStarted
	INNER JOIN dbo.CMS_User AS CU ON HAUserStarted.UserID = cu.UserID
	INNER JOIN dbo.CMS_UserSettings AS CUS2 ON CUS2.UserSettingsUserID = CU.UserID
	INNER JOIN dbo.CMS_UserSite AS CUS ON CU.UserID = CUS.UserID
	INNER JOIN dbo.CMS_Site AS CS ON CUS.SiteID = CS.SiteID
	
	INNER JOIN dbo.HFit_Account AS HFA ON hfa.SiteID = cs.SiteID
	--INNER JOIN dbo.HFit_HealthAssesmentUserModule AS haum ON HAUserStarted.ItemID = haum.HAStartedItemID
	
	INNER JOIN dbo.view_EDW_HFit_HealthAssesmentUserModule AS haum ON HAUserStarted.ItemID = haum.HAStartedItemID
	--INNER JOIN dbo.HFit_HealthAssesmentUserRiskCategory AS haurc ON haum.ItemID = haurc.HAModuleItemID

	--inner join View_CMS_Tree_Joined as VCTJ on VCTJ.NodeGUID = haum.HAModuleNodeGUID		--WDM 09.16.2014
	--inner join View_CMS_Tree_Joined as VCTJ on VCTJ.DocumentID = haum.HADocumentID		--WDM 09.16.2014
	inner join View_CMS_Tree_Joined as VCTJ on VCTJ.DocumentID = haum.HAModuleDocumentID	--WDM 09.16.2014
	
	INNER JOIN dbo.view_EDW_HFit_HealthAssesmentUserRiskCategory AS haurc ON haum.ItemID = haurc.HAModuleItemID
	--INNER JOIN dbo.HFit_HealthAssesmentUserRiskArea AS haura ON haurc.ItemID = haura.HARiskCategoryItemID
	
	INNER JOIN dbo.view_EDW_HFit_HealthAssesmentUserRiskArea AS haura ON haurc.ItemID = haura.HARiskCategoryItemID
	--INNER JOIN dbo.view_EDW_HFit_HealthAssesmentUserRiskArea AS haura ON haurc.ItemID = haura.HARiskCategoryItemID
	
	--INNER JOIN dbo.HFit_HealthAssesmentUserQuestion AS hauq ON haura.ItemID = hauq.HARiskAreaItemID
	INNER JOIN view_EDW_HFit_HealthAssesmentUserQuestion AS hauq ON haura.ItemID = hauq.HARiskAreaItemID
		
	--INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ ON hauq.HAQuestionNodeGUID = VHFHAQ.NodeGUID		--WDM 8/7/2014
	INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ ON hauq.HAQuestionDocumentID = VHFHAQ.DocumentID		--WDM 8/7/2014
	--INNER JOIN dbo.View_HFit_HealthAssesmentQuestions AS VHFHAQ ON hauq.HAQuestionDocumentID = VHFHAQ.DocumentID	--WDM 8/7/2014

	LEFT OUTER JOIN dbo.HFit_HealthAssesmentUserQuestionGroupResults AS HFHAUQGR ON hauq.ItemID = HFHAUQGR.HARiskAreaItemID
	INNER JOIN dbo.view_EDW_HFit_HealthAssesmentUserAnswers AS haua ON hauq.ItemID = haua.HAQuestionItemID

GO
