

if exists (select * from sysobjects where name = 'Proc_EDW_HealthAssessment' and Xtype = 'P')
BEGIN
	drop procedure Proc_EDW_HealthAssessment ;
END 
go

create procedure [dbo].[Proc_EDW_HealthAssessment] (@StartDate as datetime, @EndDate as datetime, @TrackPerf as nvarchar(1))
--WITH EXECUTE AS OWNER
as
--7/15/2014 17:19 min. 46,750 Rows DEV
--7/15/2014 per Mark Turner
--HAModuleDocumentID is on its way out, so is - 
--Module - RiskCategory - RiskArea - Question - Answer 
--all the "DocumentID" fields are deprecated and replaced by corresponding NodeGUID fields
--08/08/2014 - Executed in DEV with GUID changes, new views
--08/08/2014 - Generated corrected view in DEV
--08/08/2014 - 18:06 min. 51,282 Rows DEV
--08/08/2014 - 00:35 sec. 51,282 Rows DEV after conversion to SP (wdm)
--08/08/2014 - 00:35 sec. 51,282 Rows QA after conversion to SP (wdm)
--08/19/2014 - Found this proc missing some of the views created yesterday - recreated the 2 missing views and all works well
--08/29/2014 - 00:35 sec. 51,282 Rows LAB/Prod1 (wdm)
--USE: exec Proc_EDW_HealthAssessment '2014-05-22', '2014-05-23', 'Y'	--This causes between dates to be pulled
--     exec Proc_EDW_HealthAssessment NULL, NULL, 'Y'					--This causes one day's previous data to be pulled

--Auth:	GRANT EXECUTE ON dbo.Proc_EDW_HealthAssessment TO <UserID>;
--Action: This proc creates table EDW_HealthAssessment and a view to access the table view_EDW_HAassessment.
--			Select on the view is granted to PUBLIC. This provides EDW with instant access to data.

begin

	--declare @StartDate as datetime ;
	--declare @EndDate as datetime ;
	--declare @TrackPerf as char(1);
	--set @TrackPerf = 'Y' ;
	--set @StartDate = '2001-04-08';
	--set @EndDate = '2015-07-02';

	declare @P0Start as datetime ;
	declare @P0End as datetime ;
	declare @P1Start as datetime ;
	declare @P1End as datetime ;
	
	set @P0Start = getdate() ;
	set @P1Start = getdate() ;

--select * from EDW_HealthAssessment	

if exists(select name from sys.tables where name = 'EDW_HealthAssessment')
BEGIN	
	truncate table EDW_HealthAssessment ;
END
ELSE
BEGIN
	CREATE TABLE [dbo].[EDW_HealthAssessment]
	(
		[UserStartedItemID] [int] NOT NULL,
		[HAQuestionNodeGUID] [uniqueidentifier] NOT NULL,
		[UserID] [bigint] NOT NULL,
		[UserGUID] [uniqueidentifier] NOT NULL,
		[HFitUserMpiNumber] [bigint] NULL,
		[SiteGUID] [uniqueidentifier] NOT NULL,
		[AccountID] [int] NOT NULL,
		[AccountCD] [nvarchar](8) NULL,
		[HAStartedDt] [datetime] NOT NULL,
		[HACompletedDt] [datetime] NULL,
		[UserModuleItemId] [int] NOT NULL,
		[UserModuleCodeName] [nvarchar](100) NOT NULL,
		  
		 HAModuleNodeGUID uniqueidentifier	--WDM 8/7/2014 as HAModuleDocumentID
		, CMSNodeGuid uniqueidentifier						--WDM 8/7/2014 as HAModuleDocumentID

		,[HAModuleVersionID] [int] NULL,
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
		[UserQuestionCodeName] [nvarchar](100) NOT NULL,
		[HAQuestionVersionID] [int] NULL,
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
		[IsProfessionallyCollected] bit NULL
				 
	   ,ItemCreatedWhen datetime
       ,ItemModifiedWhen  datetime
	   ,HARiskCategory_ItemModifiedWhen datetime
	   ,HAUserRiskArea_ItemModifiedWhen datetime
	   ,HAUserQuestion_ItemModifiedWhen datetime
	   ,HAUserAnswers_ItemModifiedWhen datetime
	)
END

declare @SQL as varchar(2000) ;

if not exists(select name from sys.views where name = 'view_EDW_HAassessment')
BEGIN
set @SQL = 
	'create view view_EDW_HAassessment
		as
		SELECT [UserStartedItemID]
				,[HAQuestionNodeGUID]
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
				
			    , HAModuleNodeGUID				--WDM 8/7/2014 as HAModuleDocumentID
			    , CMSNodeGuid						--WDM 8/7/2014 as HAModuleDocumentID

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
				,[UserQuestionCodeName]
				,[HAQuestionVersionID]
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
				,[IsProfessionallyCollected]
				,[ItemCreatedWhen]
				,[ItemModifiedWhen]
				,HARiskCategory_ItemModifiedWhen 
				,HAUserRiskArea_ItemModifiedWhen 
				,HAUserQuestion_ItemModifiedWhen 
				,HAUserAnswers_ItemModifiedWhen 
			FROM [dbo].[EDW_HealthAssessment]' ; 
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

	INSERT into EDW_HealthAssessment
	(
		[UserStartedItemID]
		,[HAQuestionNodeGUID]
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
		 
		, HAModuleNodeGUID				--WDM 8/7/2014 as HAModuleDocumentID
		, CMSNodeGuid						--WDM 8/7/2014 as HAModuleDocumentID

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
		,[UserQuestionCodeName]
		,[HAQuestionVersionID]
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
		,[IsProfessionallyCollected]

		,[ItemCreatedWhen]
		,[ItemModifiedWhen]
		,HARiskCategory_ItemModifiedWhen
		,HAUserRiskArea_ItemModifiedWhen
		,HAUserQuestion_ItemModifiedWhen
		,HAUserAnswers_ItemModifiedWhen
	)
	SELECT  
			haus.ItemID AS UserStartedItemID
			, hauq.HAQuestionNodeGUID 
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
			
			, VCTJ.DocumentGUID as HAModuleNodeGUID				--WDM 8/7/2014 as HAModuleDocumentID
			, VCTJ.NodeGUID as CMSNodeGuid						--WDM 8/7/2014 as HAModuleDocumentID

			, NULL as HAModuleVersionID
			, haurc.ItemID AS UserRiskCategoryItemID
			, haurc.CodeName AS UserRiskCategoryCodeName
			, haurc.HARiskCategoryNodeGUID 
			, NULL as HARiskCategoryVersionID
			, haura.ItemID AS UserRiskAreaItemID
			, haura.CodeName AS UserRiskAreaCodeName
			, haura.HARiskAreaNodeGUID 
			, NULL as HARiskAreaVersionID
			, hauq.ItemID AS UserQuestionItemID
			, VHFHAQ.Title
			, hauq.CodeName AS UserQuestionCodeName
			--, hauq.HAQuestionNodeGUID
			, NULL as HAQuestionVersionID	--Exist as HAQuestionVersionID_old in the TABLE, ignoring
			, haua.ItemID AS UserAnswerItemID
			, haua.HAAnswerNodeGUID
			, NULL as HAAnswerVersionID	--Exist as HAAnswerVersionID_old in the TABLE, ignoring
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
		dbo.HFit_HealthAssesmentUserStarted AS haus
		INNER JOIN dbo.CMS_User AS CU ON haus.UserID = cu.UserID
		INNER JOIN dbo.CMS_UserSettings AS CUS2 ON CUS2.UserSettingsUserID = CU.UserID
		INNER JOIN dbo.CMS_UserSite AS CUS ON CU.UserID = CUS.UserID
		INNER JOIN dbo.CMS_Site AS CS ON CUS.SiteID = CS.SiteID
		INNER JOIN dbo.HFit_Account AS HFA ON hfa.SiteID = cs.SiteID
		INNER JOIN dbo.view_EDW_HFit_HealthAssesmentUserModule AS haum ON haus.ItemID = haum.HAStartedItemID
		
		--inner join View_CMS_Tree_Joined as VCTJ on VCTJ.NodeGUID = haum.HAModuleNodeGUID
		inner join View_CMS_Tree_Joined as VCTJ on VCTJ.DocumentID = haum.HAModuleDocumentID	--WDM 09.16.2014

		INNER JOIN dbo.view_EDW_HFit_HealthAssesmentUserRiskCategory AS haurc ON haum.ItemID = haurc.HAModuleItemID
		INNER JOIN dbo.view_EDW_HFit_HealthAssesmentUserRiskArea AS haura ON haurc.ItemID = haura.HARiskCategoryItemID
		INNER JOIN dbo.view_EDW_HFit_HealthAssesmentUserQuestion AS hauq ON haura.ItemID = hauq.HARiskAreaItemID
		                   
		--INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ ON hauq.HAQuestionNodeGUID = VHFHAQ.NodeGUID
		INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ ON hauq.HAQuestionDocumentID = VHFHAQ.DocumentID		--WDM 8/7/2014
	
		LEFT OUTER JOIN dbo.HFit_HealthAssesmentUserQuestionGroupResults AS HFHAUQGR ON hauq.ItemID = HFHAUQGR.HARiskAreaItemID
		INNER JOIN dbo.HFit_HealthAssesmentUserAnswers AS haua ON hauq.ItemID = haua.HAQuestionItemID
		--inner join #TEMP_UPDTDATE AS CDC ON haua.ItemID = CDC.ItemID
		WHERE haua.ItemModifiedWhen BETWEEN @StartDate AND @EndDate
		OR    haurc.ItemModifiedWhen BETWEEN @StartDate AND @EndDate
		OR	  haura.ItemModifiedWhen BETWEEN @StartDate AND @EndDate
		OR	  hauq.ItemModifiedWhen BETWEEN @StartDate AND @EndDate
		OR	  haua.ItemModifiedWhen BETWEEN @StartDate AND @EndDate

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


