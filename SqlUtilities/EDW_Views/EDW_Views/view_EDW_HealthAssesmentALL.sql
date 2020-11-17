
PRINT 'Processing view_EDW_HealthAssesmentALL';
GO

IF NOT EXISTS (SELECT
				  [name]
			  FROM [sys].[indexes]
			  WHERE [name] = 'CI_HFit_HealthAssesmentUserRiskArea_HARiskCategoryItemID') 
    BEGIN
	   CREATE NONCLUSTERED INDEX [CI_HFit_HealthAssesmentUserRiskArea_HARiskCategoryItemID]
	   ON [dbo].[HFit_HealthAssesmentUserRiskArea] ([HARiskCategoryItemID]) 
	   INCLUDE ([ItemID] , [HARiskAreaScore] , [ItemModifiedWhen] , [CodeName] , [PreWeightedScore] , [HARiskAreaNodeGUID]) ;
    END;
go

--if exists (select name from sys.indexes where name = 'HFit_HealthAssesmentUserRiskArea_HARiskCategoryItemID_PI')
--BEGIN
--    DROP INDEX [HFit_HealthAssesmentUserRiskArea_HARiskCategoryItemID_PI] ON [dbo].[HFit_HealthAssesmentUserRiskArea];
--END;
--GO
--CREATE NONCLUSTERED INDEX [HFit_HealthAssesmentUserRiskArea_HARiskCategoryItemID_PI] ON [dbo].[HFit_HealthAssesmentUserRiskArea]
--(
--    [ItemID] ,
--    [HARiskAreaScore] ,
--    [ItemModifiedWhen] ,
--    [CodeName] ,
--    [PreWeightedScore] ,
--    [HARiskAreaNodeGUID]
--)WITH (PAD_INDEX = OFF , STATISTICS_NORECOMPUTE = OFF , SORT_IN_TEMPDB = OFF , DROP_EXISTING = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];
--GO

IF EXISTS (SELECT
			   [name]
		   FROM [sys].[views]
		   WHERE [name] = 'view_EDW_HealthAssesmentALL') 
    BEGIN
	   DROP VIEW
		   [view_EDW_HealthAssesmentALL];
    END;
GO

/*************************************************
select top 100 * from [view_EDW_HealthAssesmentALL]
*/

CREATE VIEW [dbo].[view_EDW_HealthAssesmentALL]
AS

/*******************************************************************************************************
7/15/2014 17:19 min. 46,750 Rows DEV
7/15/2014 per Mark Turner
HAModuleDocumentID is on its way out, so is - 
Module - RiskCategory - RiskArea - Question - Answer 
all the "DocumentID" fields are deprecated and replaced by corresponding NodeGUID fields
8/7/2014 - Executed in DEV with GUID changes and returned 51K Rows in 00:43:10.
8/8/2014 - Generated corrected view in DEV
 Verified last mod date available to EDW 9.10.2014

09.08.2014: John Croft and I working together, realized there is a deficit in the ability 
of the EDW to recognize changes to database records based on the last modified date of a row. 
The views that we are currently using in the database or deeply nested. This means that 
several base tables are involved in building a single view of data.

09.30.2014: Verified with John Croft that he does want this view to return multi-languages.

The views were initially designed to recognize a date change based on a record change very 
high in the data hierarchy, the CMS Tree level which is the top most level. However, John 
and I recognize that data can change at any level in the hierarchy and those changes must be 
recognized as well. Currently, that is not the case. With the new modification to the views, 
changes in CMS documents and base tables will filter up through the hierarchy and the EDW load 
process will be able to realize that a change in this row’s data may affect and intrude into 
the warehouse.

10.01.2014 - Reviewed by Mark and Dale for use of the GUIDS
10.01.2014 - Reviewed by Mark and Dale for use of Joins and fixed two that were incorrect (Thanks to Mark)

10.23.2014 - (WDM) added two columns for the EDW HAPaperFlg / HATelephonicFlg
			HAPaperFlg is whether the question was reveived electronically or on paper
			HATelephonicFlg is whether the question was reveived by telephone or not

 FIVE Pieces needed per John C. 10.16.2014
	Document GUID -> HealthAssesmentUserStartedNodeGUID
	Module GUID -> Module -> HAUserModule.HAModuleNodeGUID
	Category GUID -> Category
	RiskArea Node Guid -> RiskArea 
	Question Node Guid -> Question
	Answer Node Guid -> Answer 

10.30.2014 : Sowmiya 
   The following are the possible values allowed in the HAStartedMode and HACompletedMode columns of the Hfit_HealthAssesmentUserStarted table
      Unknown = 0, 
       Paper = 1,  // Paper HA
       Telephonic = 2, // Telephonic HA
       Online = 3, // Online HA
       Ipad = 4 // iPAD
08/07/2014 - (WDM) as HAModuleDocumentID	--WDM 10.02.2014 place holder for EDW ETL per John C., Added back per John C. 10.16.2014
09/30/2014 - (WDM) as HAModuleDocumentID	--Mark and Dale use NodeGUID instead of Doc GUID
WDM 10.02.2014 place holder for EDW ETL
Per John C. 10.16.2014 requested that this be put back into the view.	
11.05.2014 - Changed from CMS_TREE Joined to View_HFit_HealthAssessment_Joined Mark T. / Dale M.
 11.05.2014 - Mark T. / Dale M. needed to get the Document for the user : ADDED inner join View_HFit_HealthAssessment_Joined as VHAJ on VHAJ.DocumentID = VHCJ.HealthAssessmentID
 11.05.2014 - removed the Distinct - may find it necessary to put it back as duplicates may be there. But the server resources required to do this may not be avail on P5.
11.05.2014 - Mark T. / Dale M. removed the link to View_CMS_Tree_Joined and replaced with View_HFit_HealthAssessment_Joined
inner join View_CMS_Tree_Joined as VCTJ on VCTJ.NodeGUID = HAUserModule.HAModuleNodeGUID
	and VCTJ.DocumentCulture = 'en-US'	--10.01.2014 put here to match John C. req. for language agnostic.
12.02.2014 - (wdm)Found that the view was being overwritten between Prod 1 and the copy of Prod 5 / Prod 1. Found a script inside a job on PRod 5 that reverted the view to a previous 
	   state. Removed the script and the view migrates correctly (d. miller and m. kimenski)
12.02.2014 - (wdm) Found DUPS in Prod 1 and Prod 2, none in Prod 3. 
12.17.2014 - Added two columns requested by the EDW team as noted by comments next to each column.
12.29.2014 - Stripped HTML out of Title #47619
12.31.2014 - Eliminated negative MPI's in response to CR47516 
01.02.2014 - Tested the removal of negative MPI's in response to CR47516 
01.27.2015 (WDM) #48941 - Add Client Identifier to View_EDW_Eligibility
	   In analyzing this requirement, found that the PPT.ClientID is nvarchar (alphanumeric)
	   and Hfit_Client.ClientID is integer. A bit of a domain/naming issue.
	   This is NOT needed as the data is already contained in columns [AccountID] and [AccountCD]
	   NOTE: Added the column [AccountName], just in case it were to be needed later.
02.04.2015 (WDM) #48828 added:
	    [HAUserStarted].[HACampaignNodeGUID], VCJ.BiometricCampaignStartDate
	   , VCJ.BiometricCampaignEndDate, VCJ.CampaignStartDate
	   , VCJ.CampaignEndDate, VCJ.Name as CampaignName, HACampaignID
02.05.2015 Ashwin and I reviewed and approved
 PER John C. 3.15.2015 - Please comment out all columns except the GUID in the Assesment view.  It will reduce the amount of data coming through the delta process.  Thank you
		  , [VHCJ].BiometricCampaignStartDate
		  , [VHCJ].BiometricCampaignEndDate
		  , [VHCJ].CampaignStartDate
		  , [VHCJ].CampaignEndDate
		  , [VHCJ].Name as CampaignName 
		  , [VHCJ].HACampaignID

***************************************
--the below are need in this view
, HACampaign.BiometricCampaignStartDate
, HACampaign.BiometricCampaignEndDate
, HACampaign.CampaignStartDate
, HACampaign.CampaignEndDate
, HACampaign.Name
***************************************
HAUserStarted.ItemID AS UserStartedItemID			HFit_HealthAssesmentUserStarted
HAUserModule.ItemID AS UserModuleItemId				HFit_HealthAssesmentUserModule
HARiskCategory.ItemID AS UserRiskCategoryItemID		HFit_HealthAssesmentUserRiskCategory
HAUserRiskArea.ItemID AS UserRiskAreaItemID			HFit_HealthAssesmentUserRiskArea
HAUserQuestion.ItemID AS UserQuestionItemID			HFit_HealthAssesmentUserQuestion
HAUserAnswers.ItemID AS UserAnswerItemID			HFit_HealthAssesmentUserAnswers
ACCT.AccountID										HFit_Account
CMSUser.UserGUID									CMS_User
UserSettings.HFitUserMpiNumber						CMS_UserSettings
********************************************************************************************************
*/

SELECT 
	  [HAUserStarted].[ItemID] AS [UserStartedItemID]
	, [VHAJ].[NodeGUID] AS [HealthAssesmentUserStartedNodeGUID]
	, [HAUserStarted].[UserID]
	, [CMSUser].[UserGUID]
	, [UserSettings].[HFitUserMpiNumber]
	, [CMSSite].[SiteGUID]
	, [ACCT].[AccountID]
	, [ACCT].[AccountCD]
	, [ACCT].[AccountName]
	, [HAUserStarted].[HAStartedDt]
	, [HAUserStarted].[HACompletedDt]
	, [HAUserModule].[ItemID] AS [UserModuleItemId]
	, [HAUserModule].[CodeName] AS [UserModuleCodeName]
	, [HAUserModule].[HAModuleNodeGUID]
	, [VHAJ].[NodeGUID] AS [CMSNodeGuid]
	, NULL AS [HAModuleVersionID]
	, [HARiskCategory].[ItemID] AS [UserRiskCategoryItemID]
	, [HARiskCategory].[CodeName] AS [UserRiskCategoryCodeName]
	, [HARiskCategory].[HARiskCategoryNodeGUID]
	, NULL AS [HARiskCategoryVersionID]
	, [HAUserRiskArea].[ItemID] AS [UserRiskAreaItemID]
	, [HAUserRiskArea].[CodeName] AS [UserRiskAreaCodeName]
	, [HAUserRiskArea].[HARiskAreaNodeGUID]
	, NULL AS [HARiskAreaVersionID]
	, [HAUserQuestion].[ItemID] AS [UserQuestionItemID]
	, [dbo].[udf_StripHTML] ([HAQuestionsView].[Title]) AS [Title]
	, [HAUserQuestion].[HAQuestionNodeGUID] AS [HAQuestionGuid]
	, [HAUserQuestion].[CodeName] AS [UserQuestionCodeName]
	, NULL AS [HAQuestionDocumentID]
	, NULL AS [HAQuestionVersionID]
	, [HAUserQuestion].[HAQuestionNodeGUID]
	, [HAUserAnswers].[ItemID] AS [UserAnswerItemID]
	, [HAUserAnswers].[HAAnswerNodeGUID]
	, NULL AS [HAAnswerVersionID]
	, [HAUserAnswers].[CodeName] AS [UserAnswerCodeName]
	, [HAUserAnswers].[HAAnswerValue]
	, [HAUserModule].[HAModuleScore]
	, [HARiskCategory].[HARiskCategoryScore]
	, [HAUserRiskArea].[HARiskAreaScore]
	, [HAUserQuestion].[HAQuestionScore]
	, [HAUserAnswers].[HAAnswerPoints]
	, [HAUserQuestionGroupResults].[PointResults]
	, [HAUserAnswers].[UOMCode]
	, [HAUserStarted].[HAScore]
	, [HAUserModule].[PreWeightedScore] AS [ModulePreWeightedScore]
	, [HARiskCategory].[PreWeightedScore] AS [RiskCategoryPreWeightedScore]
	, [HAUserRiskArea].[PreWeightedScore] AS [RiskAreaPreWeightedScore]
	, [HAUserQuestion].[PreWeightedScore] AS [QuestionPreWeightedScore]
	, [HAUserQuestionGroupResults].[CodeName] AS [QuestionGroupCodeName]
	, CASE
		 WHEN [HAUserAnswers].[ItemCreatedWhen] = [HAUserAnswers].[ItemModifiedWhen]
		 THEN 'I'
		 ELSE 'U'
	  END AS [ChangeType]
	, [HAUserAnswers].[ItemCreatedWhen]
	, [HAUserAnswers].[ItemModifiedWhen]
	, [HAUserQuestion].[IsProfessionallyCollected]
	, [HARiskCategory].[ItemModifiedWhen] AS [HARiskCategory_ItemModifiedWhen]
	, [HAUserRiskArea].[ItemModifiedWhen] AS [HAUserRiskArea_ItemModifiedWhen]
	, [HAUserQuestion].[ItemModifiedWhen] AS [HAUserQuestion_ItemModifiedWhen]
	, [HAUserAnswers].[ItemModifiedWhen] AS [HAUserAnswers_ItemModifiedWhen]
	, [HAUserStarted].[HAPaperFlg]
	, [HAUserStarted].[HATelephonicFlg]
	, [HAUserStarted].[HAStartedMode]
	, [HAUserStarted].[HACompletedMode]
	, [VHCJ].[DocumentCulture] AS [DocumentCulture_VHCJ]
	, [HAQuestionsView].[DocumentCulture] AS [DocumentCulture_HAQuestionsView]
	, [HAUserStarted].[HACampaignNodeGUID] AS [CampaignNodeGUID]
	, [VHCJ].[HACampaignID]
	, HASHBYTES ('sha1' , ISNULL (LEFT ([Title] , 2000) , 'X') + ISNULL (CAST ([HAUserStarted].[HACompletedMode] AS nvarchar (50)) , 'X') + ISNULL (CAST ([HAUserStarted].[HAStartedMode] AS nvarchar (50)) , 'X') + ISNULL (CAST ([HAUserStarted].[HATelephonicFlg] AS nvarchar (50)) , 'X') + ISNULL (CAST ([HAUserStarted].[HAPaperFlg] AS nvarchar (50)) , 'X') + ISNULL (CAST ([HAUserAnswers].[ItemModifiedWhen] AS nvarchar (50)) , 'X') + ISNULL (CAST ([HAUserQuestion].[ItemModifiedWhen] AS nvarchar (50)) , 'X') + ISNULL (CAST ([HAUserRiskArea].[ItemModifiedWhen] AS nvarchar (50)) , 'X') + ISNULL (CAST ([HARiskCategory].[ItemModifiedWhen] AS nvarchar (50)) , 'X') + ISNULL (CAST ([HAUserQuestion].[IsProfessionallyCollected] AS nvarchar (50)) , 'X') + ISNULL (CAST ([HAUserAnswers].[ItemModifiedWhen] AS nvarchar (50)) , 'X') + ISNULL (CAST ([HAUserAnswers].[ItemCreatedWhen] AS nvarchar (50)) , 'X') + ISNULL (CAST ([HAUserStarted].[HAStartedDt] AS nvarchar (50)) , 'X') + ISNULL (CAST ( [HAUserStarted].[HACompletedDt] AS nvarchar (50)) , 'X') + ISNULL (CAST ( [AccountCD] AS nvarchar (50)) , 'X') + ISNULL ([HAUserModule].[CodeName] , 'X') + ISNULL ([HARiskCategory].[CodeName] , 'X') + ISNULL ([HAUserRiskArea].[CodeName] , 'X') + ISNULL ([HAUserAnswers].[CodeName] , 'X') + ISNULL ([HAUserAnswers].[HAAnswerValue] , 'X') + ISNULL (CAST ([HAModuleScore] AS nvarchar (20)) , 'X') + ISNULL (CAST ([HARiskCategoryScore] AS nvarchar (20)) , 'X') + ISNULL (CAST ([HAAnswerPoints] AS nvarchar (20)) , 'X') + ISNULL (CAST ([PointResults] AS nvarchar (20)) , 'X') + ISNULL ([UOMCode] , 'X') + ISNULL (CAST ([HAScore] AS nvarchar (20)) , 'X') + ISNULL (CAST ([HAUserModule].[PreWeightedScore] AS nvarchar (20)) , 'X') + ISNULL (CAST ([HARiskCategory].[PreWeightedScore] AS nvarchar (20)) , 'X') + ISNULL (CAST ([HAUserRiskArea].[PreWeightedScore] AS nvarchar (20)) , 'X') + ISNULL (CAST ([HAUserQuestion].[PreWeightedScore] AS nvarchar (20)) , 'X') + ISNULL ([QuestionGroupCodeName] , 'X')) AS [HashCode]
	, [HAUserAnswers].[ItemModifiedWhen] AS [LastModifiedDate]
	, 0 AS [DeleteFlg]
,COALESCE
(
    [CT_CMS_User].[UserID]
	, [CT_CMS_UserSettings].[UserSettingsID]
	, [CT_CMS_Site].[SiteID]
	, [CT_CMS_UserSite].[UserSiteID]
	, [CT_HFit_Account].[AccountID]
	, [CT_HFit_HealthAssesmentUserAnswers].[ItemID]
	, [CT_HFit_HealthAssesmentUserModule].[ItemID]
	, [CT_HFit_HealthAssesmentUserQuestion].[ItemID]
	, [CT_HFit_HealthAssesmentUserQuestionGroupResults].[ItemID]
	, [CT_HFit_HealthAssesmentUserRiskArea].[ItemID]
	, [CT_HFit_HealthAssesmentUserRiskCategory].[ItemID]
	, [CT_HFit_HealthAssesmentUserStarted].[ItemID]
) as CHANGED_FLG
	   --The below attach changes to the records 
	, [CT_CMS_User].[UserID] as CT_CMS_User_UserID
	, [CT_CMS_User].[SYS_CHANGE_OPERATION] AS [CT_CMS_User_CHANGE_OPERATION]
	, [CT_CMS_UserSettings].[UserSettingsID] AS [CT_UserSettingsID]
	, [CT_CMS_UserSettings].[SYS_CHANGE_OPERATION]  AS [CT_UserSettingsID_CHANGE_OPERATION]
	, [CT_CMS_Site].[SiteID] AS [SiteID_CtID]
	, [CT_CMS_Site].[SYS_CHANGE_OPERATION]  AS [SiteID_CHANGE_OPERATION]
	, [CT_CMS_UserSite].[UserSiteID] AS [UserSiteID_CtID]
	, [CT_CMS_UserSite].[SYS_CHANGE_OPERATION] AS [UserSiteID_CHANGE_OPERATION]
	, [CT_HFit_Account].[AccountID] AS [AccountID_CtID]
	, [CT_HFit_Account].[SYS_CHANGE_OPERATION] AS [AccountID__CHANGE_OPERATION]
	, [CT_HFit_HealthAssesmentUserAnswers].[ItemID] AS [HAUserAnswers_CtID]
	, [CT_HFit_HealthAssesmentUserAnswers].[SYS_CHANGE_OPERATION] AS [HAUserAnswers_CHANGE_OPERATION]
	, [CT_HFit_HealthAssesmentUserModule].[ItemID] AS [HFit_HealthAssesmentUserModule_CtID]
	, [CT_HFit_HealthAssesmentUserModule].[SYS_CHANGE_OPERATION] AS [HFit_HealthAssesmentUserModule_CHANGE_OPERATION]
	, [CT_HFit_HealthAssesmentUserQuestion].[ItemID] AS [HFit_HealthAssesmentUserQuestion_CtID]
	, [CT_HFit_HealthAssesmentUserQuestion].[SYS_CHANGE_OPERATION] AS [HFit_HealthAssesmentUserQuestion_CHANGE_OPERATION]
	, [CT_HFit_HealthAssesmentUserQuestionGroupResults].[ItemID] AS [HFit_HealthAssesmentUserQuestionGroupResults_CtID]
	, [CT_HFit_HealthAssesmentUserQuestionGroupResults].[SYS_CHANGE_OPERATION]  AS [HFit_HealthAssesmentUserQuestionGroupResults_CHANGE_OPERATION]
	, [CT_HFit_HealthAssesmentUserRiskArea].[ItemID] AS [HFit_HealthAssesmentUserRiskArea_CtID]
	, [CT_HFit_HealthAssesmentUserRiskArea].[SYS_CHANGE_OPERATION] AS [HFit_HealthAssesmentUserRiskArea_CHANGE_OPERATION]
	, [CT_HFit_HealthAssesmentUserRiskCategory].[ItemID] AS [HFit_HealthAssesmentUserRiskCategory_CtID]
	, [CT_HFit_HealthAssesmentUserRiskCategory].[SYS_CHANGE_OPERATION] AS [HFit_HealthAssesmentUserRiskCategory_CHANGE_OPERATION]
	, [CT_HFit_HealthAssesmentUserStarted].[ItemID] AS [HFit_HealthAssesmentUserStarted_CtID]
	, [CT_HFit_HealthAssesmentUserStarted].[SYS_CHANGE_OPERATION] AS [HFit_HealthAssesmentUserStarted_CHANGE_OPERATION]

--select count(*) --00:40:08	  --148 rows
--select *					  --01:25"35
  FROM
	  [dbo].[HFit_HealthAssesmentUserStarted] AS [HAUserStarted]
		 INNER JOIN [dbo].[CMS_User] AS [CMSUser]
			ON [HAUserStarted].[UserID] = [CMSUser].[UserID]
		 INNER JOIN [dbo].[CMS_UserSettings] AS [UserSettings]
			ON [UserSettings].[UserSettingsUserID] = [CMSUser].[UserID]
		    AND [HFitUserMpiNumber] >= 0
		    AND [HFitUserMpiNumber] IS NOT NULL		
		 INNER JOIN [dbo].[CMS_UserSite] AS [UserSite]
			ON [CMSUser].[UserID] = [UserSite].[UserID]
		 INNER JOIN [dbo].[CMS_Site] AS [CMSSite]
			ON [UserSite].[SiteID] = [CMSSite].[SiteID]
		 INNER JOIN [dbo].[HFit_Account] AS [ACCT]
			ON [ACCT].[SiteID] = [CMSSite].[SiteID]
		 INNER JOIN [dbo].[HFit_HealthAssesmentUserModule] AS [HAUserModule]
			ON [HAUserStarted].[ItemID] = [HAUserModule].[HAStartedItemID]
		 INNER JOIN [View_HFit_HACampaign_Joined] AS [VHCJ]
			ON [VHCJ].[NodeGUID] = [HAUserStarted].[HACampaignNodeGUID]
		    AND [VHCJ].[NodeSiteID] = [UserSite].[SiteID]
		    AND [VHCJ].[DocumentCulture] = 'en-US'
		 INNER JOIN [View_HFit_HealthAssessment_Joined] AS [VHAJ]
			ON [VHAJ].[DocumentID] = [VHCJ].[HealthAssessmentID]
		 INNER JOIN [dbo].[HFit_HealthAssesmentUserRiskCategory] AS [HARiskCategory]
			ON [HAUserModule].[ItemID] = [HARiskCategory].[HAModuleItemID]
		 INNER JOIN [dbo].[HFit_HealthAssesmentUserRiskArea] AS [HAUserRiskArea]
			ON [HARiskCategory].[ItemID] = [HAUserRiskArea].[HARiskCategoryItemID]
		 INNER JOIN [dbo].[HFit_HealthAssesmentUserQuestion] AS [HAUserQuestion]
			ON [HAUserRiskArea].[ItemID] = [HAUserQuestion].[HARiskAreaItemID]
		 INNER JOIN [dbo].[View_EDW_HealthAssesmentQuestions] AS [HAQuestionsView]
			ON [HAUserQuestion].[HAQuestionNodeGUID] = [HAQuestionsView].[NodeGUID]
		    AND [HAQuestionsView].[DocumentCulture] = 'en-US'
		 LEFT OUTER JOIN [dbo].[HFit_HealthAssesmentUserQuestionGroupResults] AS [HAUserQuestionGroupResults]
			ON [HAUserRiskArea].[ItemID] = [HAUserQuestionGroupResults].[HARiskAreaItemID]
		 INNER JOIN [dbo].[HFit_HealthAssesmentUserAnswers] AS [HAUserAnswers]
			ON [HAUserQuestion].[ItemID] = [HAUserAnswers].[HAQuestionItemID]		  
/****************************************************************************************************/
--*******************************************************************************************************
		 LEFT JOIN CHANGETABLE (CHANGES [CMS_UserSettings] , NULL) AS [CT_CMS_UserSettings]
			ON [UserSettings].[UserSettingsID] = [CT_CMS_UserSettings].[UserSettingsID]
		 LEFT JOIN CHANGETABLE (CHANGES [CMS_User] , NULL) AS [CT_CMS_User]
			ON [CMSUser].[UserID] = [CT_CMS_User].[UserID]
		 Left OUTER JOIN CHANGETABLE (CHANGES [CMS_Site] , NULL) AS [CT_CMS_Site]
			ON [CMSSite].[SiteID] = [CT_CMS_Site].[SiteID]
		 Left OUTER JOIN CHANGETABLE (CHANGES [CMS_UserSite] , NULL) AS [CT_CMS_UserSite]
			ON [UserSite].[UserSiteID] = [CT_CMS_UserSite].[UserSiteID]
		 Left OUTER JOIN CHANGETABLE (CHANGES [HFit_Account] , NULL) AS [CT_HFit_Account]
			ON [ACCT].[AccountID] = [CT_HFit_Account].[AccountID]
		 Left OUTER JOIN CHANGETABLE (CHANGES [HFit_HACampaign] , NULL) AS [CT_HFit_HACampaign]
			ON [VHCJ].[HACampaignID] = [CT_HFit_HACampaign].[HACampaignID]
		 Left OUTER JOIN CHANGETABLE (CHANGES [HFit_HealthAssesmentUserAnswers] , NULL) AS [CT_HFit_HealthAssesmentUserAnswers]
			ON [HAUserAnswers].[ItemID] = [CT_HFit_HealthAssesmentUserAnswers].[ItemID]
		 Left OUTER JOIN CHANGETABLE (CHANGES [HFit_HealthAssesmentUserModule] , NULL) AS [CT_HFit_HealthAssesmentUserModule]
			ON [HAUserModule].[ItemID] = [CT_HFit_HealthAssesmentUserModule].[ItemID]
		 Left OUTER JOIN CHANGETABLE (CHANGES [HFit_HealthAssesmentUserQuestion] , NULL) AS [CT_HFit_HealthAssesmentUserQuestion]
			ON [HAUserQuestion].[ItemID] = [CT_HFit_HealthAssesmentUserQuestion].[ItemID]
		 Left OUTER JOIN CHANGETABLE (CHANGES [HFit_HealthAssesmentUserQuestionGroupResults] , NULL) AS [CT_HFit_HealthAssesmentUserQuestionGroupResults]
			ON [HAUserQuestionGroupResults].[ItemID] = [CT_HFit_HealthAssesmentUserQuestionGroupResults].[ItemID]
		 Left OUTER JOIN CHANGETABLE (CHANGES [HFit_HealthAssesmentUserRiskArea] , NULL) AS [CT_HFit_HealthAssesmentUserRiskArea]
			ON [HAUserRiskArea].[ItemID] = [CT_HFit_HealthAssesmentUserRiskArea].[ItemID]
		 Left OUTER JOIN CHANGETABLE (CHANGES [HFit_HealthAssesmentUserRiskCategory] , NULL) AS [CT_HFit_HealthAssesmentUserRiskCategory]
			ON [HARiskCategory].[ItemID] = [CT_HFit_HealthAssesmentUserRiskCategory].[ItemID]
		 Left OUTER JOIN CHANGETABLE (CHANGES [HFit_HealthAssesmentUserStarted] , NULL) AS [CT_HFit_HealthAssesmentUserStarted]
			ON [HAUserStarted].[ItemID] = [CT_HFit_HealthAssesmentUserStarted].[ItemID]

 WHERE [UserSettings].[HFitUserMpiNumber] NOT IN (
	   SELECT
			[RejectMPICode]
		FROM [HFit_LKP_EDW_RejectMPI]) 
 --   AND (
	--   [CT_CMS_User].[UserID] IS NOT NULL
	--OR [CT_CMS_UserSettings].[UserSettingsID] IS NOT NULL
	--OR [CT_CMS_Site].[SiteID] IS NOT NULL
	--OR [CT_CMS_UserSite].[UserSiteID] IS NOT NULL
	--OR [CT_HFit_Account].[AccountID] IS NOT NULL
	--OR [CT_HFit_HealthAssesmentUserModule].[ItemID] IS NOT NULL
	--OR [CT_HFit_HealthAssesmentUserModule].[ItemID] IS NOT NULL
	--OR [CT_HFit_HealthAssesmentUserQuestion].[ItemID] IS NOT NULL
	--OR [CT_HFit_HealthAssesmentUserQuestionGroupResults].[ItemID] IS NOT NULL
	--OR [CT_HFit_HealthAssesmentUserRiskArea].[ItemID] IS NOT NULL
	--OR [CT_HFit_HealthAssesmentUserRiskCategory].[ItemID] IS NOT NULL
	--OR [CT_HFit_HealthAssesmentUserStarted].[ItemID] IS NOT NULL
	--OR [CT_CMS_User].[UserID] IS NOT NULL
	--OR [CT_CMS_UserSettings].[UserSettingsID] IS NOT NULL
	--OR [CT_CMS_Site].[SiteID] IS NOT NULL
	--OR [CT_CMS_UserSite].[UserSiteID] IS NOT NULL
	--OR [CT_HFit_Account].[AccountID] IS NOT NULL
	--OR [CT_HFit_HealthAssesmentUserAnswers].[ItemID] IS NOT NULL
	--OR [CT_HFit_HealthAssesmentUserModule].[ItemID] IS NOT NULL
	--OR [CT_HFit_HealthAssesmentUserQuestion].[ItemID] IS NOT NULL
	--OR [CT_HFit_HealthAssesmentUserQuestionGroupResults].[ItemID] IS NOT NULL
	--OR [CT_HFit_HealthAssesmentUserRiskArea].[ItemID] IS NOT NULL
	--OR [CT_HFit_HealthAssesmentUserRiskCategory].[ItemID] IS NOT NULL
	--OR [CT_HFit_HealthAssesmentUserStarted].[ItemID] IS NOT NULL
 --   );
GO

PRINT 'Processed view_EDW_HealthAssesmentALL';
GO

/*
*/

GO
PRINT '***** FROM: view_EDW_HealthAssesmentALL.sql';
GO

