
print ('Processing: Proc_EDW_HealthAssessment') ;
go

if exists (select * from sysobjects where name = 'Proc_EDW_HealthAssessment' and Xtype = 'P')
BEGIN
	drop procedure Proc_EDW_HealthAssessment ;
END 
go

create procedure [dbo].[Proc_EDW_HealthAssessment] (@StartDate as datetime, @EndDate as datetime, @TrackPerf as nvarchar(1))
--WITH EXECUTE AS OWNER
as

--***********************************************************************************************
--NOTE: This proc is currently set up to enter records into a staging table "EDW_HealthAssessment".
--		It runs in about the same time as the non-staging query, This allows the EDW instant access
--		to the HA records once this proc has completed. No changes would be required to the EDW
--		processing as the column names and ordinals are the same. A job can be set up to run this 
--		procedure on a scheduled basis.

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
			DocumentGUID uniqueidentifier
		);
		INSERT INTO #View_EDW_HealthAssesmentQuestions (Title, NodeGUID, DocumentGUID)
			SELECT Title, NodeGUID, DocumentGUID
		FROM View_EDW_HealthAssesmentQuestions ;

		CREATE CLUSTERED INDEX [TEMPIX_View_EDW_HealthAssesmentQuestions] ON #View_EDW_HealthAssesmentQuestions
		(
			DocumentGUID ASC,
			NodeGUID ASC
		)
	END

	IF OBJECT_ID('tempdb..#View_CMS_Tree_Joined') IS NULL 
	BEGIN
		create TABLE #View_CMS_Tree_Joined
		(
			DocumentGUID uniqueidentifier,
			NodeGUID uniqueidentifier
		);
		INSERT INTO #View_CMS_Tree_Joined (DocumentGUID, NodeGUID)
			SELECT DocumentGUID, NodeGUID
		FROM View_CMS_Tree_Joined ;

		CREATE CLUSTERED INDEX [TEMPIX_View_CMS_Tree_Joined] ON #View_CMS_Tree_Joined
		(
			DocumentGUID ASC,
			NodeGUID ASC
		)
	END
	

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
		UserStartedItemID  int,
        HealthAssesmentUserStartedNodeGUID  uniqueidentifier,
        UserID  bigint,
        UserGUID  uniqueidentifier,
        HFitUserMpiNumber  bigint,
        SiteGUID  uniqueidentifier,
        AccountID  int,
        AccountCD  nvarchar (8),
        HAStartedDt  datetime,
        HACompletedDt  datetime,
        UserModuleItemId  int,
        UserModuleCodeName  nvarchar(100)
        
		, HAModuleNodeGUID uniqueidentifier	--WDM 8/7/2014 as HAModuleDocumentID
		, CMSNodeGuid uniqueidentifier						--WDM 8/7/2014 as HAModuleDocumentID

        ,HAModuleVersionID  int,
        UserRiskCategoryItemID  int,
        UserRiskCategoryCodeName  nvarchar(100),
        HARiskCategoryNodeGUID  uniqueidentifier,
        HARiskCategoryVersionID  int,
        UserRiskAreaItemID  int,
        UserRiskAreaCodeName  nvarchar(100),
        HARiskAreaNodeGUID  uniqueidentifier,
        HARiskAreaVersionID  int,
        UserQuestionItemID  int,
        Title  nvarchar(4000),
        HAQuestionGuid  uniqueidentifier,
        UserQuestionCodeName  nvarchar(100),
        HAQuestionDocumentID  int,
        HAQuestionVersionID  bigint,
        HAQuestionNodeGUID  uniqueidentifier,
        UserAnswerItemID  int,
        HAAnswerNodeGUID  uniqueidentifier,
        HAAnswerVersionID  bigint,
        UserAnswerCodeName  nvarchar(100),
        HAAnswerValue  nvarchar(255),
        HAModuleScore  float,
        HARiskCategoryScore  float,
        HARiskAreaScore  float,
        HAQuestionScore  float,
        HAAnswerPoints  int,
        PointResults  int,
        UOMCode  nvarchar(10),
        HAScore  int,
        ModulePreWeightedScore  float,
        RiskCategoryPreWeightedScore  float,
        RiskAreaPreWeightedScore  float,
        QuestionPreWeightedScore  float,
        QuestionGroupCodeName  nvarchar(100),
        ChangeType  varchar(1)
       
	   ,IsProfessionallyCollected bit

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
			,IsProfessionallyCollected 
			,ItemCreatedWhen 
			,ItemModifiedWhen  
			,HARiskCategory_ItemModifiedWhen 
			,HAUserRiskArea_ItemModifiedWhen 
			,HAUserQuestion_ItemModifiedWhen 
			,HAUserAnswers_ItemModifiedWhen 
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

	INSERT into EDW_HealthAssessment
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
           
		   ,IsProfessionallyCollected
		   
		   ,ItemCreatedWhen
		   ,ItemModifiedWhen		   
		   ,HARiskCategory_ItemModifiedWhen
		   ,HAUserRiskArea_ItemModifiedWhen
		   ,HAUserQuestion_ItemModifiedWhen
		   ,HAUserAnswers_ItemModifiedWhen)
	
	SELECT  
				HAUserStarted.ItemID AS UserStartedItemID		
				, HAUserStarted.HALastQuestionNodeGUID as  HealthAssesmentUserStartedNodeGUID		--WDM 8/7/2014  as HADocumentID
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
				
				, VCTJ.DocumentGUID as HAModuleNodeGUID				--WDM 8/7/2014 as HAModuleDocumentID
				, VCTJ.NodeGUID as CMSNodeGuid						--WDM 8/7/2014 as HAModuleDocumentID

				, NULL as HAModuleVersionID
				, HARiskCategory.ItemID AS UserRiskCategoryItemID
				, HARiskCategory.CodeName AS UserRiskCategoryCodeName
				, HARiskCategory.HARiskCategoryNodeGUID						--WDM 8/7/2014 as HARiskCategoryDocumentID
				, NULL as HARiskCategoryVersionID
				, HAUserRiskArea.ItemID AS UserRiskAreaItemID
				, HAUserRiskArea.CodeName AS UserRiskAreaCodeName
				, HAUserRiskArea.HARiskAreaNodeGUID								--WDM 8/7/2014 as HARiskAreaDocumentID
				, NULL as HARiskAreaVersionID
				, HAUserQuestion.ItemID AS UserQuestionItemID
				, HAQuestionsView.Title
				, HAUserQuestion.HAQuestionNodeGUID	as HAQuestionGuid			--WDM 9.2.2014
				, HAUserQuestion.CodeName AS UserQuestionCodeName
				, HAUserQuestion.HAQuestionDocumentID_old as HAQuestionDocumentID	--WDM 9.2.2014
		
				, HAUserQuestion.HAQuestionVersionID_old as HAQuestionVersionID		
		
				, HAUserQuestion.HAQuestionNodeGUID		
						
				, HAUserAnswers.ItemID AS UserAnswerItemID
				, HAUserAnswers.HAAnswerNodeGUID								--WDM 8/7/2014 as HAAnswerDocumentID

				, HAUserAnswers.HAAnswerVersionID_old as HAAnswerVersionID		--WDM 9.2.2014
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

				, HAUserQuestion.IsProfessionallyCollected

				, HAUserAnswers.ItemCreatedWhen
				, HAUserAnswers.ItemModifiedWhen				
				, HARiskCategory.ItemModifiedWhen as HARiskCategory_ItemModifiedWhen
				, HAUserRiskArea.ItemModifiedWhen as HAUserRiskArea_ItemModifiedWhen
				, HAUserQuestion.ItemModifiedWhen as HAUserQuestion_ItemModifiedWhen
				, HAUserAnswers.ItemModifiedWhen as HAUserAnswers_ItemModifiedWhen				

			FROM
			dbo.HFit_HealthAssesmentUserStarted AS HAUserStarted
			INNER JOIN dbo.CMS_User AS CMSUser ON HAUserStarted.UserID = CMSUser.UserID
			INNER JOIN dbo.CMS_UserSettings AS UserSettings ON UserSettings.UserSettingsUserID = CMSUser.UserID
			INNER JOIN dbo.CMS_UserSite AS UserSite ON CMSUser.UserID = UserSite.UserID
			INNER JOIN dbo.CMS_Site AS CMSSite ON UserSite.SiteID = CMSSite.SiteID
			INNER JOIN dbo.HFit_Account AS ACCT ON ACCT.SiteID = CMSSite.SiteID
			INNER JOIN dbo.HFit_HealthAssesmentUserModule AS HAUserModule ON HAUserStarted.ItemID = HAUserModule.HAStartedItemID
	
			inner join #View_CMS_Tree_Joined as VCTJ on VCTJ.NodeGUID = HAUserModule.HAModuleNodeGUID
			
			INNER JOIN dbo.HFit_HealthAssesmentUserRiskCategory AS HARiskCategory ON HAUserModule.ItemID = HARiskCategory.HAModuleItemID
			INNER JOIN dbo.HFit_HealthAssesmentUserRiskArea AS HAUserRiskArea ON HARiskCategory.ItemID = HAUserRiskArea.HARiskCategoryItemID
			INNER JOIN dbo.HFit_HealthAssesmentUserQuestion AS HAUserQuestion ON HAUserRiskArea.ItemID = HAUserQuestion.HARiskAreaItemID
			INNER JOIN dbo.#View_EDW_HealthAssesmentQuestions AS HAQuestionsView ON HAUserQuestion.HAQuestionNodeGUID = HAQuestionsView.NodeGUID
			--INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS HAQuestionsView ON HAUserQuestion.HAQuestionNodeGUID = HAQuestionsView.NodeGUID
			LEFT OUTER JOIN dbo.HFit_HealthAssesmentUserQuestionGroupResults AS HAUserQuestionGroupResults ON HAUserQuestion.ItemID = HAUserQuestionGroupResults.HARiskAreaItemID
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


