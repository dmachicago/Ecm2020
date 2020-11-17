
print ('Processing: Proc_EDW_HealthAssessment') ;
go

if exists (select * from sysobjects where name = 'Proc_EDW_HealthAssessment' and Xtype = 'P')
BEGIN
	drop procedure Proc_EDW_HealthAssessment ;
END 
go

CREATE procedure [dbo].[Proc_EDW_HealthAssessment] (@StartDate as datetime, @EndDate as datetime, @TrackPerf as nvarchar(1))
--WITH EXECUTE AS OWNER
as

--***********************************************************************************************
--NOTE: This proc is currently set up to enter records into a staging table "EDW_HealthAssessment".
--		It runs in about the same time as the non-staging query, This allows the EDW instant access
--		to the HA records once this proc has completed. No changes would be required to the EDW
--		processing as the column names and ordinals are the same. A job can be set up to run this 
--		procedure on a scheduled basis. IT IS NOT IN PRODUCTION YET.

--7/15/2014 17:19 min. 46,750 Rows DEV
--7/15/2014 per Mark Turner:
--	HAModuleDocumentID is on its way out, so is Module, RiskCategory, RiskArea, Question, Answer 
--	all the "DocumentID" fields are deprecated and replaced by corresponding NodeGUID fields
--08/08/2014 - Executed in DEV with GUID changes, new views
--08/08/2014 - Generated corrected view in DEV
--08/08/2014 - 18:06 min. 51,282 Rows DEV
--08/08/2014 - 00:35 sec. 51,282 Rows DEV after conversion to SP (wdm)
--08/08/2014 - 00:35 sec. 51,282 Rows QA after conversion to SP (wdm)
--08/19/2014 - Found this proc missing some of the views created yesterday - recreated the 2 missing views and all works well
--08/29/2014 - 00:35 sec. 51,282 Rows LAB/Prod1 (wdm)
--(52480 row(s) affected)  @EndTime: Sep  2 2014  3:24PM / 1:41 exec time (not using insert into staging table)
--(52480 row(s) affected)  @EndTime: Sep  2 2014  3:24PM / 1:40 exec time (using insert into staging table)
--USE: exec Proc_EDW_HealthAssessment '2013-05-22', '2014-09-23', 'Y'	--This causes between dates to be pulled
--     exec Proc_EDW_HealthAssessment NULL, NULL, 'Y'					--This causes one day's previous data to be pulled

--Auth:	GRANT EXECUTE ON dbo.Proc_EDW_HealthAssessment TO <UserID>;
--Action: This proc creates table EDW_HealthAssessment and a view to access the table view_EDW_HAassessment.
--			Select on the view is granted to PUBLIC. This provides EDW with instant access to data.


-- 09.11.2014 : (wdm) Verified DATES to resolve EDW last mod date issue
--***********************************************************************************************
begin

	IF OBJECT_ID('tempdb..#View_EDW_HealthAssesmentQuestions') IS NULL 
	BEGIN
		create TABLE #View_EDW_HealthAssesmentQuestions
		(
			Title nvarchar(4000),
			NodeGUID uniqueidentifier,
			DocumentGUID uniqueidentifier,
			DocumentCulture nvarchar(50)
		);
		INSERT INTO #View_EDW_HealthAssesmentQuestions (Title, NodeGUID, DocumentGUID, DocumentCulture)
			SELECT Title, NodeGUID, DocumentGUID, DocumentCulture
		FROM View_EDW_HealthAssesmentQuestions ;

		CREATE CLUSTERED INDEX [TEMPIX_View_EDW_HealthAssesmentQuestions] ON #View_EDW_HealthAssesmentQuestions
		(
			DocumentGUID ASC,
			NodeGUID ASC,
			DocumentCulture
		)
	END

	IF OBJECT_ID('tempdb..#View_CMS_Tree_Joined') IS NULL 
	BEGIN
		create TABLE #View_CMS_Tree_Joined
		(
			DocumentGUID uniqueidentifier,
			NodeGUID uniqueidentifier,
			DocumentCulture nvarchar(50)
		);
		INSERT INTO #View_CMS_Tree_Joined (DocumentGUID, NodeGUID, DocumentCulture)
			SELECT DocumentGUID, NodeGUID, DocumentCulture
		FROM View_CMS_Tree_Joined ;

		CREATE CLUSTERED INDEX [TEMPIX_View_CMS_Tree_Joined] ON #View_CMS_Tree_Joined
		(
			DocumentGUID ASC,
			NodeGUID ASC,
			DocumentCulture
		)
	END
	

	set @TrackPerf = 'Y' ;
	set @StartDate = '2001-04-08';
	set @EndDate = '2015-07-02';

	declare @P0Start as datetime2 ;
	declare @P0End as datetime2 ;
	declare @P1Start as datetime2 ;
	declare @P1End as datetime2 ;
	
	set @P0Start = getdate() ;
	set @P1Start = getdate() ;
	
--select * from EDW_HealthAssessment	

if exists(select name from sys.tables where name = 'EDW_HealthAssessment')
BEGIN	
	drop table EDW_HealthAssessment ;
END


CREATE TABLE [dbo].[EDW_HealthAssessment](
	[UserStartedItemID] [int] NOT NULL,
	[HealthAssesmentUserStartedNodeGUID] [uniqueidentifier] NULL,
	[UserID] [bigint] NOT NULL,
	[UserGUID] [uniqueidentifier] NOT NULL,
	[HFitUserMpiNumber] [bigint] NULL,
	[SiteGUID] [uniqueidentifier] NOT NULL,
	[AccountID] [int] NOT NULL,
	[AccountCD] [nvarchar](8) NULL,
	[HAStartedDt] [datetime2] (7)  NOT NULL,
	[HACompletedDt] [datetime2] (7)  NULL,
	[UserModuleItemId] [int] NOT NULL,
	[UserModuleCodeName] [nvarchar](100) NOT NULL,
	[HAModuleNodeGUID] [uniqueidentifier] NOT NULL,
	[CMSNodeGuid] [uniqueidentifier] NOT NULL,
	[HAModuleVersionID] [int] NULL,
	[UserRiskCategoryItemID] [int] NOT NULL,
	[UserRiskCategoryCodeName] [nvarchar](100) NOT NULL,
	[HARiskCategoryNodeGUID] [uniqueidentifier] NOT NULL,
	[HARiskCategoryVersionID] [int] NULL,
	[UserRiskAreaItemID] [int] NOT NULL,
	[UserRiskAreaCodeName] [nvarchar](100) NOT NULL,
	[HARiskAreaNodeGUID] [uniqueidentifier] NOT NULL,
	[HARiskAreaVersionID] [int] NULL,
	[UserQuestionItemID] [int] NOT NULL,
	[Title] [nvarchar](max) NOT NULL,
	[HAQuestionGuid] [uniqueidentifier] NOT NULL,
	[UserQuestionCodeName] [nvarchar](100) NOT NULL,
	[HAQuestionDocumentID] [int] NULL,
	[HAQuestionVersionID] [int] NULL,
	[HAQuestionNodeGUID] [uniqueidentifier] NOT NULL,
	[UserAnswerItemID] [int] NOT NULL,
	[HAAnswerNodeGUID] [uniqueidentifier] NOT NULL,
	[HAAnswerVersionID] [int] NULL,
	[UserAnswerCodeName] [nvarchar](100) NOT NULL,
	[HAAnswerValue] [nvarchar](255) NULL,
	[HAModuleScore] [float] NOT NULL,
	[HARiskCategoryScore] [float] NULL,
	[HARiskAreaScore] [float] NULL,
	[HAQuestionScore] [float] NULL,
	[HAAnswerPoints] [int] NULL,
	[PointResults] [int] NULL,
	[UOMCode] [nvarchar](10) NULL,
	[HAScore] [int] NULL,
	[ModulePreWeightedScore] [float] NULL,
	[RiskCategoryPreWeightedScore] [float] NULL,
	[RiskAreaPreWeightedScore] [float] NULL,
	[QuestionPreWeightedScore] [float] NULL,
	[QuestionGroupCodeName] [nvarchar](100) NULL,
	[ChangeType] [varchar](1) NOT NULL,
	[ItemCreatedWhen] [datetime2] (7)  NULL,
	[ItemModifiedWhen] [datetime2] (7)  NULL,
	[IsProfessionallyCollected] [bit] NOT NULL,
	[HARiskCategory_ItemModifiedWhen] [datetime2] (7)  NULL,
	[HAUserRiskArea_ItemModifiedWhen] [datetime2] (7)  NULL,
	[HAUserQuestion_ItemModifiedWhen] [datetime2] (7)  NULL,
	[HAUserAnswers_ItemModifiedWhen] [datetime2] (7)  NULL,
	[HAPaperFlg] [bit] NOT NULL,
	[HATelephonicFlg] [bit] NOT NULL
	--[HAStartedMode] [int] NOT NULL,
	--[HACompletedMode] [int] NOT NULL
) ;


declare @SQL as varchar(2000) ;

if not exists(select name from sys.views where name = 'view_EDW_HAassessment')
BEGIN
	set @SQL = 
		'create view view_EDW_HAassessment
			as
			SELECT [UserStartedItemID]
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
		  --,[HAStartedMode]
		  --,[HACompletedMode]
	  FROM [dbo].[EDW_HealthAssessment]'; 
			  
	  exec (@SQL) ;

	  GRANT SELECT ON view_EDW_HAassessment TO public;

END

	IF @StartDate is null 
		BEGIN
			--set @StartDate = getdate() - 1 ;
			set @StartDate  =DATEADD(Day, 0, DATEDIFF(Day, 0, GetDate())) -1 ;	--Midnight yesterday;	
			set @StartDate = @StartDate  -1 ;	
		END
		IF @EndDate is null 
		BEGIN
			set @EndDate = getdate();
			--set @StartDate  =DATEADD(Day, 0, DATEDIFF(Day, 0, GetDate())) ;	--Midnight today;		
		END

--select top 10 * from view_EDW_HealthAssesment
	INSERT INTO [dbo].[EDW_HealthAssessment]
           ([UserStartedItemID]
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
           --,[HAStartedMode]
           --,[HACompletedMode]
		   )
	
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
		   --,HAUserStarted.HAStartedMode
		   --,HAUserStarted.HACompletedMode
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

		WHERE HAUserAnswers.ItemModifiedWhen BETWEEN @StartDate AND @EndDate
		OR HARiskCategory.ItemModifiedWhen BETWEEN @StartDate AND @EndDate
		OR HAUserRiskArea.ItemModifiedWhen BETWEEN @StartDate AND @EndDate
		OR HAUserQuestion.ItemModifiedWhen BETWEEN @StartDate AND @EndDate
		
if @TrackPerf is not null 
BEGIN
	set @P1End = getdate() ;
	exec proc_EDW_MeasurePerf 'ElapsedTime','HealthAssessment-P1',0, @P1Start, @P1End;
	print ('Perf Details Recorded') ;
END
ELSE
	print ('No Perf Details Requested') ;
	
END	--END of PROC

GO

print ('Processed: Proc_EDW_HealthAssessment') ;
go

  --  
  --  
GO 
print('***** FROM: Proc_EDW_HealthAssessment.sql'); 
GO 
