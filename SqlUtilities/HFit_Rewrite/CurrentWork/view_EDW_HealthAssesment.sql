

--use KenticoCMS_Prod1

GO
PRINT 'Processing view_EDW_HealthAssesment';
GO

IF EXISTS (SELECT name
                  FROM sys.views
                  WHERE name = 'view_EDW_HealthAssesment') 
    BEGIN
        DROP VIEW view_EDW_HealthAssesment;
    END;
GO
--select top 100 * from [view_EDW_HealthAssesment]
CREATE VIEW dbo.view_EDW_HealthAssesment
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
-- 08/07/2014 - (WDM) as HAModuleDocumentID	--WDM 10.02.2014 place holder for EDW ETL per John C., Added back per John C. 10.16.2014
-- 09/30/2014 - (WDM) as HAModuleDocumentID	--Mark and Dale use NodeGUID instead of Doc GUID
--WDM 10.02.2014 place holder for EDW ETL
--Per John C. 10.16.2014 requested that this be put back into the view.	
--11.05.2014 - Changed from CMS_TREE Joined to View_HFit_HealthAssessment_Joined Mark T. / Dale M.
-- 11.05.2014 - Mark T. / Dale M. needed to get the Document for the user : ADDED inner join View_HFit_HealthAssessment_Joined as VHAJ on VHAJ.DocumentID = VHCJ.HealthAssessmentID
-- 11.05.2014 - removed the Distinct - may find it necessary to put it back as duplicates may be there. But the server resources required to do this may not be avail on P5.
--11.05.2014 - Mark T. / Dale M. removed the link to View_CMS_Tree_Joined and replaced with View_HFit_HealthAssessment_Joined
--inner join View_CMS_Tree_Joined as VCTJ on VCTJ.NodeGUID = HAUserModule.HAModuleNodeGUID
--	and VCTJ.DocumentCulture = 'en-US'	--10.01.2014 put here to match John C. req. for language agnostic.
-- 12.02.2014 - (wdm)Found that the view was being overwritten between Prod 1 and the copy of Prod 5 / Prod 1. Found a script inside a job on PRod 5 that reverted the view to a previous state. Removed the script and the view migrates correctly (d. miller and m. kimenski)
-- 12.02.2014 - (wdm) Found DUPS in Prod 1 and Prod 2, none in Prod 3. 
-- 12.17.2014 - Added two columns requested by the EDW team as noted by comments next to each column.
-- 12.29.2014 - Stripped HTML out of Title #47619
-- 12.31.2014 - Eliminated negative MPI's in response to CR47516 
-- 01.02.2014 - Tested the removal of negative MPI's in response to CR47516 
--01.27.2015 (WDM) #48941 - Add Client Identifier to View_EDW_Eligibility
--	   In analyzing this requirement, found that the PPT.ClientID is nvarchar (alphanumeric)
--	   and Hfit_Client.ClientID is integer. A bit of a domain/naming issue.
--	   This is NOT needed as the data is already contained in columns [AccountID] and [AccountCD]
--	   NOTE: Added the column [AccountName], just in case it were to be needed later.
--02.04.2015 (WDM) #48828 added:
--	    [HAUserStarted].[HACampaignNodeGUID], VCJ.BiometricCampaignStartDate
--	   , VCJ.BiometricCampaignEndDate, VCJ.CampaignStartDate
--	   , VCJ.CampaignEndDate, VCJ.Name as CampaignName, HACampaignID
-- PER John C. 2.6.2015 - Please comment out all columns except the GUID in the Assesment view.  It will reduce the amount of data coming through the delta process.  Thank you
--, [VHCJ].BiometricCampaignStartDate
--, [VHCJ].BiometricCampaignEndDate
--, [VHCJ].CampaignStartDate
--, [VHCJ].CampaignEndDate
--, [VHCJ].Name as CampaignName 
--, [VHCJ].HACampaignID

/*---------------------------------------
--the below are need in this view 
, HACampaign.BiometricCampaignStartDate
, HACampaign.BiometricCampaignEndDate
, HACampaign.CampaignStartDate
, HACampaign.CampaignEndDate
, HACampaign.Name

or only the 
select * from HAUserStarted
, HACampaign.NodeGuid as CampaignNodeGuid
*/

--02.05.2015 Ashwin and I reviewed and approved
--07.09.2015 (WDM) - Dea and I discussed the need to capture and present the Health Assessment Type.
--				Mark and I discussed how best to do this and the data, basically, was already in 
--				the view. I added the field HealthAssessmentType to the view.
--********************************************************************************************************

SELECT HAUserStarted.ItemID AS UserStartedItemID
     , VHAJ.NodeGUID AS HealthAssesmentUserStartedNodeGUID
     , HAUserStarted.UserID
     , CMSUser.UserGUID
     , UserSettings.HFitUserMpiNumber
     , CMSSite.SiteGUID
     , ACCT.AccountID
     , ACCT.AccountCD
     , ACCT.AccountName
     , CAST (HAUserStarted.HAStartedDt AS datetime) AS HAStartedDt
     , CAST (HAUserStarted.HACompletedDt AS datetime) AS HACompletedDt
     , HAUserModule.ItemID AS UserModuleItemId
     , HAUserModule.CodeName AS UserModuleCodeName
     , HAUserModule.HAModuleNodeGUID
     , VHAJ.NodeGUID AS CMSNodeGuid
     , NULL AS HAModuleVersionID
     , HARiskCategory.ItemID AS UserRiskCategoryItemID
     , HARiskCategory.CodeName AS UserRiskCategoryCodeName
     , HARiskCategory.HARiskCategoryNodeGUID						--WDM 8/7/2014 as HARiskCategoryDocumentID
     , NULL AS HARiskCategoryVersionID			--WDM 10.02.2014 place holder for EDW ETL
     , HAUserRiskArea.ItemID AS UserRiskAreaItemID
     , HAUserRiskArea.CodeName AS UserRiskAreaCodeName
     , HAUserRiskArea.HARiskAreaNodeGUID							--WDM 8/7/2014 as HARiskAreaDocumentID
     , NULL AS HARiskAreaVersionID			--WDM 10.02.2014 place holder for EDW ETL
     , HAUserQuestion.ItemID AS UserQuestionItemID
     , dbo.udf_StripHTML (HAQuestionsView.Title) AS Title			--WDM 47619 12.29.2014
     , HAUserQuestion.HAQuestionNodeGUID AS HAQuestionGuid		--WDM 9.2.2014	This is a repeat field but had to stay to match the previous view - this is the NODE GUID and matches to the definition file to get the question. This tells you the question, language agnostic.
     , HAUserQuestion.CodeName AS UserQuestionCodeName
     , NULL AS HAQuestionDocumentID	--WDM 10.1.2014 - this is GOING AWAY 		--WDM 10.02.2014 place holder for EDW ETL
     , NULL AS HAQuestionVersionID			--WDM 10.1.2014 - this is GOING AWAY - no versions across environments 		--WDM 10.02.2014 place holder for EDW ETL
     , HAUserQuestion.HAQuestionNodeGUID		--WDM 10.01.2014	Left this in place to preserve column structure.		
     , HAUserAnswers.ItemID AS UserAnswerItemID
     , HAUserAnswers.HAAnswerNodeGUID								--WDM 8/7/2014 as HAAnswerDocumentID
     , NULL AS HAAnswerVersionID		--WDM 10.1.2014 - this is GOING AWAY - no versions across environments		--WDM 10.02.2014 place holder for EDW ETL
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
     , CASE
       WHEN HAUserAnswers.ItemCreatedWhen = HAUserAnswers.ItemModifiedWhen THEN 'I'
       ELSE 'U'
       END AS ChangeType
     , CAST (HAUserAnswers.ItemCreatedWhen AS datetime) AS ItemCreatedWhen
     , CAST (HAUserAnswers.ItemModifiedWhen AS datetime) AS ItemModifiedWhen
     , HAUserQuestion.IsProfessionallyCollected
     , CAST (HARiskCategory.ItemModifiedWhen AS datetime) AS HARiskCategory_ItemModifiedWhen
     , CAST (HAUserRiskArea.ItemModifiedWhen AS datetime) AS HAUserRiskArea_ItemModifiedWhen
     , CAST (HAUserQuestion.ItemModifiedWhen AS datetime) AS HAUserQuestion_ItemModifiedWhen
     , CAST (HAUserAnswers.ItemModifiedWhen AS datetime) AS HAUserAnswers_ItemModifiedWhen
     , HAUserStarted.HAPaperFlg
     , HAUserStarted.HATelephonicFlg
     , HAUserStarted.HAStartedMode		--12.11.2014 WDM Sowmiya and dale talked and decided to implement this column 12.17.2014 - Added 
     , HAUserStarted.HACompletedMode	--12.11.2014 WDM Sowmiya and dale talked and decided to implement this column 12.17.2014 - Added 

     , VHCJ.DocumentCulture AS DocumentCulture_VHCJ
     , HAQuestionsView.DocumentCulture AS DocumentCulture_HAQuestionsView
     , HAUserStarted.HACampaignNodeGUID AS CampaignNodeGUID
     , CASE
       WHEN HAUserStarted.HADocumentConfigID IS NULL THEN 'SHORT_VER'
       WHEN HAUserStarted.HADocumentConfigID IS NOT NULL THEN 'LONG_VER'
       ELSE 'UNKNOWN'
       END AS HealthAssessmentType
       FROM
            dbo.HFit_HealthAssesmentUserStarted AS HAUserStarted
            INNER JOIN dbo.CMS_User AS CMSUser
                ON HAUserStarted.UserID = CMSUser.UserID
            INNER JOIN dbo.CMS_UserSettings AS UserSettings
                ON UserSettings.UserSettingsUserID = CMSUser.UserID
               AND HFitUserMpiNumber >= 0
               AND HFitUserMpiNumber IS NOT NULL -- (WDM) CR47516 
            INNER JOIN dbo.CMS_UserSite AS UserSite
                ON CMSUser.UserID = UserSite.UserID
            INNER JOIN dbo.CMS_Site AS CMSSite
                ON UserSite.SiteID = CMSSite.SiteID
            INNER JOIN dbo.HFit_Account AS ACCT
                ON ACCT.SiteID = CMSSite.SiteID
            INNER JOIN dbo.HFit_HealthAssesmentUserModule AS HAUserModule
                ON HAUserStarted.ItemID = HAUserModule.HAStartedItemID
            INNER JOIN View_HFit_HACampaign_Joined AS VHCJ
                ON VHCJ.NodeGUID = HAUserStarted.HACampaignNodeGUID
               AND VHCJ.NodeSiteID = UserSite.SiteID
               AND VHCJ.DocumentCulture = 'en-US'
            INNER JOIN View_HFit_HealthAssessment_Joined AS VHAJ
                ON VHAJ.DocumentID = VHCJ.HealthAssessmentID
            INNER JOIN dbo.HFit_HealthAssesmentUserRiskCategory AS HARiskCategory
                ON HAUserModule.ItemID = HARiskCategory.HAModuleItemID
            INNER JOIN dbo.HFit_HealthAssesmentUserRiskArea AS HAUserRiskArea
                ON HARiskCategory.ItemID = HAUserRiskArea.HARiskCategoryItemID
            INNER JOIN dbo.HFit_HealthAssesmentUserQuestion AS HAUserQuestion
                ON HAUserRiskArea.ItemID = HAUserQuestion.HARiskAreaItemID
            INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS HAQuestionsView
                ON HAUserQuestion.HAQuestionNodeGUID = HAQuestionsView.NodeGUID
               AND HAQuestionsView.DocumentCulture = 'en-US'
            LEFT OUTER JOIN dbo.HFit_HealthAssesmentUserQuestionGroupResults AS HAUserQuestionGroupResults
                ON HAUserRiskArea.ItemID = HAUserQuestionGroupResults.HARiskAreaItemID
            INNER JOIN dbo.HFit_HealthAssesmentUserAnswers AS HAUserAnswers
                ON HAUserQuestion.ItemID = HAUserAnswers.HAQuestionItemID
       WHERE UserSettings.HFitUserMpiNumber NOT IN (
             SELECT RejectMPICode
                    FROM HFit_LKP_EDW_RejectMPI) ;
GO

PRINT 'Processed view_EDW_HealthAssesment';
GO
--  
--  
GO
PRINT '***** FROM: view_EDW_HealthAssesment.sql';
GO 


