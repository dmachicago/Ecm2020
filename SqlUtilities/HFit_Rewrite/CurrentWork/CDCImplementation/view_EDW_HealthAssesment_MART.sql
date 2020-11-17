

-- use KenticoCMS_Datamart_2

GO
PRINT 'Processing view_EDW_HealthAssesment_MART';
GO

IF EXISTS (SELECT
                  name
           FROM sys.views
           WHERE
                  name = 'view_EDW_HealthAssesment_MART') 
    BEGIN
        DROP VIEW
             view_EDW_HealthAssesment_MART;
    END;
GO
-- use KenticoCMS_Datamart_2
-- select top 100 * from [view_EDW_HealthAssesment_MART] where CT_HATelephonicFlg !=0 or CT_CodeName != 0
-- select * from [view_EDW_HealthAssesment_MART] where CT_CodeName != 0
-- select * from information_schema.columns where table_name = 'view_EDW_HealthAssesment_MART' order by column_name 
CREATE VIEW dbo.view_EDW_HealthAssesment_MART
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

--02.29.2016 (WDM) - Modified to run using the MART data.
--03.02.2016 (WDM) - Removed the CAST from DT2 to DT, causing errors.
--03.02.2016 (WDM) - Added needed performance indexes.
--********************************************************************************************************

SELECT
       HAUserStarted.ItemID AS UserStartedItemID
     , VHAJ.NodeGUID AS HealthAssesmentUserStartedNodeGUID
     , HAUserStarted.UserID
     , CMSUser.UserGUID
     , UserSettings.HFitUserMpiNumber
     , CMSSite.SiteGUID
     , ACCT.AccountID
     , ACCT.AccountCD
     , ACCT.AccountName
       --, CAST (HAUserStarted.HAStartedDt AS datetime) AS HAStartedDt
       --, CAST (HAUserStarted.HACompletedDt AS datetime) AS HACompletedDt
     , HAUserStarted.HAStartedDt
     , HAUserStarted.HACompletedDt
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
       WHEN
       HAUserAnswers.ItemCreatedWhen = HAUserAnswers.ItemModifiedWhen
           THEN 'I'
       ELSE 'U'
       END AS ChangeType
       --, CAST (HAUserAnswers.ItemCreatedWhen AS datetime) AS ItemCreatedWhen
       --, CAST (HAUserAnswers.ItemModifiedWhen AS datetime) AS ItemModifiedWhen
     , HAUserAnswers.ItemCreatedWhen
     , HAUserAnswers.ItemModifiedWhen
     , HAUserQuestion.IsProfessionallyCollected
       --, CAST (HARiskCategory.ItemModifiedWhen AS datetime) AS HARiskCategory_ItemModifiedWhen
       --, CAST (HAUserRiskArea.ItemModifiedWhen AS datetime) AS HAUserRiskArea_ItemModifiedWhen
       --, CAST (HAUserQuestion.ItemModifiedWhen AS datetime) AS HAUserQuestion_ItemModifiedWhen
       --, CAST (HAUserAnswers.ItemModifiedWhen AS datetime) AS HAUserAnswers_ItemModifiedWhen
     , HARiskCategory.ItemModifiedWhen AS HARiskCategory_ItemModifiedWhen
     , HAUserRiskArea.ItemModifiedWhen AS HAUserRiskArea_ItemModifiedWhen
     , HAUserQuestion.ItemModifiedWhen AS HAUserQuestion_ItemModifiedWhen
     , HAUserAnswers.ItemModifiedWhen AS HAUserAnswers_ItemModifiedWhen
     , HAUserStarted.HAPaperFlg
     , HAUserStarted.HATelephonicFlg
     , HAUserStarted.HAStartedMode		--12.11.2014 WDM Sowmiya and dale talked and decided to implement this column 12.17.2014 - Added 
     , HAUserStarted.HACompletedMode	--12.11.2014 WDM Sowmiya and dale talked and decided to implement this column 12.17.2014 - Added 

     , VHCJ.DocumentCulture AS DocumentCulture_VHCJ
     , HAQuestionsView.DocumentCulture AS DocumentCulture_HAQuestionsView
     , HAUserStarted.HACampaignNodeGUID AS CampaignNodeGUID
     , CASE
       WHEN HAUserStarted.HADocumentConfigID IS NULL
           THEN 'SHORT_VER'
       WHEN HAUserStarted.HADocumentConfigID IS NOT NULL
           THEN 'LONG_VER'
       ELSE 'UNKNOWN'
       END AS HealthAssessmentType

    /*
    select top 100 hastartedmode from HFit_HealthAssesmentUserStarted where ItemID between 100 and 110
    update HFit_HealthAssesmentUserStarted -1 where ItemID between 100 and 110
    update HFit_HealthAssesmentUserStarted 3 where ItemID between 100 and 110

    select top 100 HATelephonicFlg from HFit_HealthAssesmentUserStarted where ItemID between 200 and 210
    update HFit_HealthAssesmentUserStarted set HATelephonicFlg = 1 where ItemID between  200 and 210
    update HFit_HealthAssesmentUserStarted set HATelephonicFlg = 0 where ItemID between  200 and 210

    update HFit_HealthAssesmentUserQuestion set IsProfessionallyCollected = 1 where ItemID in (15047,15048,15049,15050,15051)
    update HFit_HealthAssesmentUserQuestion set IsProfessionallyCollected = 0 where ItemID in (15047,15048,15049,15050,15051)

    select top 100 ItemID,CodeName from HFit_HealthAssesmentUserAnswers where ItemID in (15422,15423,15424)
    update HFit_HealthAssesmentUserAnswers set CodeName = 'Maybe' where ItemID  in (15422,15423,15424)
    update HFit_HealthAssesmentUserAnswers set CodeName = 'No' where ItemID  in (15422,15423,15424)

    */
    ,CHANGE_TRACKING_IS_COLUMN_IN_MASK (COLUMNPROPERTY (OBJECT_ID ('HFit_HealthAssesmentUserStarted') , 'HAStartedMode' , 'ColumnId') , CT_HAUserStarted.SYS_CHANGE_COLUMNS) as CT_HAUserStarted
    ,CHANGE_TRACKING_IS_COLUMN_IN_MASK (COLUMNPROPERTY (OBJECT_ID ('HFit_HealthAssesmentUserStarted') , 'HATelephonicFlg' , 'ColumnId') , CT_HAUserStarted.SYS_CHANGE_COLUMNS) as CT_HATelephonicFlg
    ,CHANGE_TRACKING_IS_COLUMN_IN_MASK (COLUMNPROPERTY (OBJECT_ID ('HFit_HealthAssesmentUserStarted') , 'HADocumentConfigID' , 'ColumnId') , CT_HAUserStarted.SYS_CHANGE_COLUMNS) as CT_HADocumentConfigID
    ,CHANGE_TRACKING_IS_COLUMN_IN_MASK (COLUMNPROPERTY (OBJECT_ID ('CMS_UserSettings') , 'HFitUserMpiNumber' , 'ColumnId') , CTBL_UserSettings.SYS_CHANGE_COLUMNS) as CT_HFitUserMpiNumber
    ,CHANGE_TRACKING_IS_COLUMN_IN_MASK (COLUMNPROPERTY (OBJECT_ID ('HFit_HealthAssesmentUserQuestion') , 'IsProfessionallyCollected' , 'ColumnId') , CTBL_HAUserQuestion.SYS_CHANGE_COLUMNS) as CT_IsProfessionallyCollected
    ,CHANGE_TRACKING_IS_COLUMN_IN_MASK (COLUMNPROPERTY (OBJECT_ID ('HFit_HealthAssesmentUserAnswers') , 'CodeName' , 'ColumnId') , CTBL_HAUserAnswers.SYS_CHANGE_COLUMNS) as CT_CodeName
     , CASE
       WHEN
       CHANGE_TRACKING_IS_COLUMN_IN_MASK (COLUMNPROPERTY (OBJECT_ID ('HFit_HealthAssesmentUserStarted') , 'HAStartedMode' , 'ColumnId') , CT_HAUserStarted.SYS_CHANGE_COLUMNS) = 1
           THEN 40
       WHEN
       CHANGE_TRACKING_IS_COLUMN_IN_MASK (COLUMNPROPERTY (OBJECT_ID ('HFit_HealthAssesmentUserStarted') , 'HATelephonicFlg' , 'ColumnId') , CT_HAUserStarted.SYS_CHANGE_COLUMNS) = 1
           THEN 41
       WHEN
       CHANGE_TRACKING_IS_COLUMN_IN_MASK (COLUMNPROPERTY (OBJECT_ID ('HFit_HealthAssesmentUserAnswers') , 'ItemModifiedWhen', 'ColumnId') , SYS_CHANGE_COLUMNS) = 1
               THEN 42
       WHEN
       CHANGE_TRACKING_IS_COLUMN_IN_MASK (COLUMNPROPERTY (OBJECT_ID ('HFit_HealthAssesmentUserQuestion') , 'ItemModifiedWhen', 'ColumnId') , SYS_CHANGE_COLUMNS) = 1
               THEN 43
           WHEN
       CHANGE_TRACKING_IS_COLUMN_IN_MASK (COLUMNPROPERTY (OBJECT_ID ('HFit_HealthAssesmentUserRiskArea') , 'ItemModifiedWhen', 'ColumnId') , SYS_CHANGE_COLUMNS) = 1
               THEN 44
       WHEN
       CHANGE_TRACKING_IS_COLUMN_IN_MASK (COLUMNPROPERTY (OBJECT_ID ('HFit_HealthAssesmentUserStarted') , 'HADocumentConfigID' , 'ColumnId') , CT_HAUserStarted.SYS_CHANGE_COLUMNS) = 1
           THEN 52
       WHEN
       CHANGE_TRACKING_IS_COLUMN_IN_MASK (COLUMNPROPERTY (OBJECT_ID ('CMS_UserSettings') , 'HFitUserMpiNumber' , 'ColumnId') , CTBL_UserSettings.SYS_CHANGE_COLUMNS) = 1
           THEN 53
       WHEN     
       CHANGE_TRACKING_IS_COLUMN_IN_MASK (COLUMNPROPERTY (OBJECT_ID ('HFit_HealthAssesmentUserQuestion') , 'IsProfessionallyCollected' , 'ColumnId') , CTBL_HAUserQuestion.SYS_CHANGE_COLUMNS) = 1
           THEN 54
       WHEN
       CHANGE_TRACKING_IS_COLUMN_IN_MASK (COLUMNPROPERTY (OBJECT_ID ('HFit_HealthAssesmentUserAnswers') , 'ItemCreatedWhen' , 'ColumnId') , CTBL_HAUserAnswers.SYS_CHANGE_COLUMNS) = 1
           THEN 55
           WHEN
       CHANGE_TRACKING_IS_COLUMN_IN_MASK (COLUMNPROPERTY (OBJECT_ID ('HFit_HealthAssesmentUserAnswers') , 'ItemModifiedWhen', 'ColumnId') , SYS_CHANGE_COLUMNS) = 1
               THEN 56
       WHEN
       CHANGE_TRACKING_IS_COLUMN_IN_MASK (COLUMNPROPERTY (OBJECT_ID ('HFit_HealthAssesmentUserModule') , 'PreWeightedScore' , 'ColumnId') , CT_HAUserModule.SYS_CHANGE_COLUMNS) = 1
           THEN 57
       WHEN
       CHANGE_TRACKING_IS_COLUMN_IN_MASK (COLUMNPROPERTY (OBJECT_ID ('HFit_HealthAssesmentUserQuestionGroupResults') , 'PointResults' , 'ColumnId') , CTBL_HAUserQuestionGroupResults.SYS_CHANGE_COLUMNS) = 1
           THEN 50
       WHEN
       CHANGE_TRACKING_IS_COLUMN_IN_MASK (COLUMNPROPERTY (OBJECT_ID ('HFit_HealthAssesmentUserQuestionGroupResults') , 'CodeName' , 'ColumnId') , CTBL_HAUserQuestionGroupResults.SYS_CHANGE_COLUMNS) = 1
           THEN 59
       WHEN
       CHANGE_TRACKING_IS_COLUMN_IN_MASK (COLUMNPROPERTY (OBJECT_ID ('HFit_HealthAssesmentUserQuestion') , 'PreWeightedScore' , 'ColumnId') , CTBL_HAUserQuestion.SYS_CHANGE_COLUMNS) = 1
           THEN 60
       WHEN
       CHANGE_TRACKING_IS_COLUMN_IN_MASK (COLUMNPROPERTY (OBJECT_ID ('HFit_HealthAssesmentUserRiskArea') , 'PreWeightedScore' , 'ColumnId') , CTBL_HAUserRiskArea.SYS_CHANGE_COLUMNS) = 1
           THEN 61
       WHEN
       CHANGE_TRACKING_IS_COLUMN_IN_MASK (COLUMNPROPERTY (OBJECT_ID ('HFit_HealthAssesmentUserRiskCategory') , 'PreWeightedScore' , 'ColumnId') , CTBL_HARiskCategory.SYS_CHANGE_COLUMNS) = 1
           THEN 62
           WHEN
       WHEN
       CHANGE_TRACKING_IS_COLUMN_IN_MASK (COLUMNPROPERTY (OBJECT_ID ('View_EDW_HealthAssesmentQuestions') , 'Title' , 'ColumnId') , CTBL_HAQuestionsView.SYS_CHANGE_COLUMNS) = 1
           THEN 64
       WHEN
       CHANGE_TRACKING_IS_COLUMN_IN_MASK (COLUMNPROPERTY (OBJECT_ID ('HFit_HealthAssesmentUserAnswers') , 'UOMCode' , 'ColumnId') , CTBL_HAUserAnswers.SYS_CHANGE_COLUMNS) = 1
           THEN 65
       WHEN
       CHANGE_TRACKING_IS_COLUMN_IN_MASK (COLUMNPROPERTY (OBJECT_ID ('HFit_HealthAssesmentUserAnswers') , 'CodeName' , 'ColumnId') , CTBL_HAUserAnswers.SYS_CHANGE_COLUMNS) = 1
           THEN 66
           WHEN
       ELSE 0
       END AS RowDataChanged
FROM
     dbo.HFit_HealthAssesmentUserStarted AS HAUserStarted
     INNER JOIN
     dbo.CMS_User AS CMSUser
     ON
       HAUserStarted.UserID = CMSUser.UserID AND --HAUserStarted.SVR = CMSUser.SVR AND
       HAUserStarted.DBNAME = CMSUser.DBNAME
     left JOIN
     CHANGETABLE (CHANGES HFit_HealthAssesmentUserStarted , NULL) AS CT_HAUserStarted
     ON
       HAUserStarted.SurrogateKey_HFit_HealthAssesmentUserStarted = CT_HAUserStarted.SurrogateKey_HFit_HealthAssesmentUserStarted
     INNER JOIN
     dbo.CMS_UserSettings AS UserSettings
     ON
       UserSettings.UserSettingsUserID = CMSUser.UserID AND --UserSettings.SVR = CMSUser.SVR AND
       UserSettings.DBNAME = CMSUser.DBNAME AND
       HFitUserMpiNumber >= 0 AND
       HFitUserMpiNumber IS NOT NULL -- (WDM) CR47516 
     LEFT JOIN
     CHANGETABLE (CHANGES CMS_UserSettings , NULL) AS CTBL_UserSettings
     ON
       UserSettings.SurrogateKey_CMS_UserSettings = CTBL_UserSettings.SurrogateKey_CMS_UserSettings
     INNER JOIN
     dbo.CMS_UserSite AS UserSite
     ON
       CMSUser.UserID = UserSite.UserID AND --CMSUser.SVR = UserSite.SVR AND
       CMSUser.DBNAME = UserSite.DBNAME
     INNER JOIN
     dbo.CMS_Site AS CMSSite
     ON
       UserSite.SiteID = CMSSite.SiteID AND --UserSite.SVR = CMSSite.SVR AND
       UserSite.DBNAME = CMSSite.DBNAME
     INNER JOIN
     dbo.HFit_Account AS ACCT
     ON
       ACCT.SiteID = CMSSite.SiteID AND --ACCT.svr = CMSSite.SVR AND
       ACCT.DBNAME = CMSSite.DBNAME
     INNER JOIN
     dbo.HFit_HealthAssesmentUserModule AS HAUserModule
     ON
       HAUserStarted.ItemID = HAUserModule.HAStartedItemID AND --HAUserStarted.SVR = HAUserModule.SVR AND
       HAUserStarted.DBNAME = HAUserModule.DBNAME
     LEFT JOIN
     CHANGETABLE (CHANGES HFit_HealthAssesmentUserModule , NULL) AS CT_HAUserModule
     ON
       HAUserModule.SurrogateKey_HFit_HealthAssesmentUserModule = HAUserModule.SurrogateKey_HFit_HealthAssesmentUserModule
     INNER JOIN
     View_HFit_HACampaign_Joined AS VHCJ
     ON
       VHCJ.NodeGUID = HAUserStarted.HACampaignNodeGUID AND --VHCJ.SVR = HAUserStarted.SVR AND
       VHCJ.DBNAME = HAUserStarted.DBNAME AND
       VHCJ.NodeSiteID = UserSite.SiteID AND
       VHCJ.DocumentCulture = 'en-US'
     INNER JOIN
     View_HFit_HealthAssessment_Joined AS VHAJ
     ON
       VHAJ.DocumentID = VHCJ.HealthAssessmentID AND --VHAJ.SVR = VHCJ.SVR AND
       VHAJ.DBNAME = VHCJ.DBNAME
     INNER JOIN
     dbo.HFit_HealthAssesmentUserRiskCategory AS HARiskCategory
     ON
       HAUserModule.ItemID = HARiskCategory.HAModuleItemID AND --HAUserModule.SVR = HARiskCategory.SVR AND
       HAUserModule.DBNAME = HARiskCategory.DBNAME
     LEFT JOIN
     CHANGETABLE (CHANGES HFit_HealthAssesmentUserRiskCategory , NULL) AS CTBL_HARiskCategory
     ON
       HARiskCategory.SurrogateKey_HFit_HealthAssesmentUserRiskCategory = CTBL_HARiskCategory.SurrogateKey_HFit_HealthAssesmentUserRiskCategory
     INNER JOIN
     dbo.HFit_HealthAssesmentUserRiskArea AS HAUserRiskArea
     ON
       HARiskCategory.ItemID = HAUserRiskArea.HARiskCategoryItemID AND --HARiskCategory.SVR = HAUserRiskArea.SVR AND
       HARiskCategory.DBNAME = HAUserRiskArea.DBNAME
     LEFT JOIN
     CHANGETABLE (CHANGES HFit_HealthAssesmentUserRiskArea , NULL) AS CTBL_HAUserRiskArea
     ON
       HAUserRiskArea.SurrogateKey_HFit_HealthAssesmentUserRiskArea = CTBL_HAUserRiskArea.SurrogateKey_HFit_HealthAssesmentUserRiskArea
     INNER JOIN
     dbo.HFit_HealthAssesmentUserQuestion AS HAUserQuestion
     ON
       HAUserRiskArea.ItemID = HAUserQuestion.HARiskAreaItemID AND --HAUserRiskArea.SVR = HAUserQuestion.SVR AND
       HAUserRiskArea.DBNAME = HAUserQuestion.DBNAME --**********************
     LEFT JOIN
     CHANGETABLE (CHANGES HFit_HealthAssesmentUserQuestion , NULL) AS CTBL_HAUserQuestion
     ON
       HAUserQuestion.SurrogateKey_HFit_HealthAssesmentUserQuestion = CTBL_HAUserQuestion.SurrogateKey_HFit_HealthAssesmentUserQuestion
     INNER JOIN
     dbo.View_EDW_HealthAssesmentQuestions AS HAQuestionsView
     ON
       HAUserQuestion.HAQuestionNodeGUID = HAQuestionsView.NodeGUID AND --HAUserQuestion.SVR = HAQuestionsView.SVR AND
       HAUserQuestion.DBNAME = HAQuestionsView.DBNAME AND
       HAQuestionsView.DocumentCulture = 'en-US'
     LEFT JOIN
     CHANGETABLE (CHANGES View_EDW_HealthAssesmentQuestions , NULL) AS CTBL_HAQuestionsView
     ON
       HAQuestionsView.SurrogateKey_View_EDW_HealthAssesmentQuestions = CTBL_HAQuestionsView.SurrogateKey_View_EDW_HealthAssesmentQuestions
     LEFT OUTER JOIN
     dbo.HFit_HealthAssesmentUserQuestionGroupResults AS HAUserQuestionGroupResults
     ON
       HAUserRiskArea.ItemID = HAUserQuestionGroupResults.HARiskAreaItemID AND --HAUserRiskArea.SVR = HAUserQuestionGroupResults.SVR AND
       HAUserRiskArea.DBNAME = HAUserQuestionGroupResults.DBNAME
    --WDMXX
     LEFT JOIN
     CHANGETABLE (CHANGES HFit_HealthAssesmentUserQuestionGroupResults , NULL) AS CTBL_HAUserQuestionGroupResults
     ON
       HAUserQuestionGroupResults.SurrogateKey_HFit_HealthAssesmentUserQuestionGroupResults = CTBL_HAUserQuestionGroupResults.SurrogateKey_HFit_HealthAssesmentUserQuestionGroupResults
     INNER JOIN
     dbo.HFit_HealthAssesmentUserAnswers AS HAUserAnswers
     ON
       HAUserQuestion.ItemID = HAUserAnswers.HAQuestionItemID AND --HAUserQuestion.SVR = HAUserAnswers.SVR AND
       HAUserQuestion.DBNAME = HAUserAnswers.DBNAME
     LEFT JOIN
     CHANGETABLE (CHANGES HFit_HealthAssesmentUserAnswers , NULL) AS CTBL_HAUserAnswers
     ON
       HAUserAnswers.SurrogateKey_HFit_HealthAssesmentUserAnswers = CTBL_HAUserAnswers.SurrogateKey_HFit_HealthAssesmentUserAnswers
WHERE UserSettings.HFitUserMpiNumber NOT IN (
SELECT
       RejectMPICode
FROM HFit_LKP_EDW_RejectMPI) ;
GO

PRINT 'Processed view_EDW_HealthAssesment_MART';
GO
--  
IF NOT EXISTS (SELECT
                      name
               FROM sys.indexes
               WHERE
                      name = 'PI_CMS_Document_DocumentCulture') 
    BEGIN
        CREATE NONCLUSTERED INDEX PI_CMS_Document_DocumentCulture
        ON dbo.CMS_Document (DocumentCulture) 
        INCLUDE (DocumentForeignKeyValue , DocumentNodeID , SVR , DBNAME) ;
    END;

GO
IF NOT EXISTS (SELECT
                      name
               FROM sys.indexes
               WHERE
                      name = 'PI_CMS_Document_NodeClassID_SVR') 
    BEGIN
        CREATE NONCLUSTERED INDEX PI_CMS_Document_NodeClassID_SVR
        ON dbo.CMS_Tree (NodeClassID , SVR) 
        INCLUDE (NodeSiteID , NodeGUID , NodeLinkedNodeID) ;
    END;

GO
IF NOT EXISTS (SELECT
                      name
               FROM sys.indexes
               WHERE
                      name = 'PI_CMS_Document_ClassName') 
    BEGIN
        CREATE NONCLUSTERED INDEX PI_CMS_Document_ClassName
        ON dbo.CMS_Class (ClassName) ;
    END;

GO
IF NOT EXISTS (SELECT
                      name
               FROM sys.indexes
               WHERE
                      name = 'CI_CMS_Document_Culture_NodeID_SVR') 
    BEGIN
        CREATE NONCLUSTERED INDEX CI_CMS_Document_Culture_NodeID_SVR
        ON dbo.CMS_Document (DocumentCulture , DocumentNodeID , SVR) 
        INCLUDE (DocumentForeignKeyValue , DBNAME) ;
    END;
--  
GO
PRINT '***** Executed: view_EDW_HealthAssesment_MART.sql';
GO 


If not exists (select name from sys.indexes where name = 'PI_MART_HA_HAUserStarted_LastModifiedDate')
create nonclustered index PI_MART_HA_HAUserStarted_LastModifiedDate on BASE_MART_EDW_HealthAssesment (HAUserStarted_LastModifiedDate)
GO
If not exists (select name from sys.indexes where name = 'PI_MART_HA_CMSUser_LastModifiedDate')
create nonclustered index PI_MART_HA_CMSUser_LastModifiedDate on BASE_MART_EDW_HealthAssesment (CMSUser_LastModifiedDate)
GO
If not exists (select name from sys.indexes where name = 'PI_MART_HA_UserSettings_LastModifiedDate')
create nonclustered index PI_MART_HA_UserSettings_LastModifiedDate on BASE_MART_EDW_HealthAssesment (UserSettings_LastModifiedDate)
GO
If not exists (select name from sys.indexes where name = 'PI_MART_HA_UserSite_LastModifiedDate')
create nonclustered index PI_MART_HA_UserSite_LastModifiedDate on BASE_MART_EDW_HealthAssesment (UserSite_LastModifiedDate)
GO
If not exists (select name from sys.indexes where name = 'PI_MART_HA_ACCT_LastModifiedDate')
create nonclustered index PI_MART_HA_ACCT_LastModifiedDate on BASE_MART_EDW_HealthAssesment (ACCT_LastModifiedDate)
GO
If not exists (select name from sys.indexes where name = 'PI_MART_HA_HAUserModule_LastModifiedDate')
create nonclustered index PI_MART_HA_HAUserModule_LastModifiedDate on BASE_MART_EDW_HealthAssesment (HAUserModule_LastModifiedDate)
GO
If not exists (select name from sys.indexes where name = 'PI_MART_HA_HARiskCategory_LastModifiedDate')
create nonclustered index PI_MART_HA_HARiskCategory_LastModifiedDate on BASE_MART_EDW_HealthAssesment (HARiskCategory_LastModifiedDate)
GO
If not exists (select name from sys.indexes where name = 'PI_MART_HA_HAUserRiskArea_LastModifiedDate')
create nonclustered index PI_MART_HA_HAUserRiskArea_LastModifiedDate on BASE_MART_EDW_HealthAssesment (HAUserRiskArea_LastModifiedDate)
GO
If not exists (select name from sys.indexes where name = 'PI_MART_HA_HAUserQuestion_LastModifiedDate')
create nonclustered index PI_MART_HA_HAUserQuestion_LastModifiedDate on BASE_MART_EDW_HealthAssesment (HAUserQuestion_LastModifiedDate)
GO
If not exists (select name from sys.indexes where name = 'PI_MART_HA_HAUserAnswers_LastModifiedDate')
create nonclustered index PI_MART_HA_HAUserAnswers_LastModifiedDate on BASE_MART_EDW_HealthAssesment (HAUserAnswers_LastModifiedDate)
GO
If not exists (select name from sys.indexes where name = 'PI_MART_HA_LastModifiedDate')
create nonclustered index PI_MART_HA_LastModifiedDate on BASE_MART_EDW_HealthAssesment (LastModifiedDate)
GO