
alter procedure [dbo].[Proc_EDW_HealthAssessment] (@StartDate as datetime, @EndDate as datetime, @TrackPerf as nvarchar(1))
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
--08/19/2014 - Found this proc missing some of the views created yesterday - recreated the 2 missing views and all works well
--USE: exec Proc_EDW_HealthAssessment '2001-04-08', '2015-07-02', 'Y'	--This causes between dates to be pulled
--     exec Proc_EDW_HealthAssessment NULL, NULL, 'Y'					--This causes one day's previous data to be pulled
--Auth:	GRANT EXECUTE ON dbo.Proc_EDW_HealthAssessment TO <UserID>;
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

	IF @StartDate is null 
		BEGIN
			--set @StartDate = getdate() - 1 ;
			set @StartDate  =DATEADD(Day, 0, DATEDIFF(Day, 0, GetDate())) -1 ;	--Midnight yesterday;		
		END
		IF @EndDate is null 
		BEGIN
			set @EndDate = getdate();
			--set @StartDate  =DATEADD(Day, 0, DATEDIFF(Day, 0, GetDate())) ;	--Midnight today;		
		END

	IF EXISTS
		(
			SELECT name
			FROM tempdb.dbo.sysobjects
			WHERE ID = OBJECT_ID(N'tempdb..#TEMP_UPDTDATE')
		)
		BEGIN
			DROP TABLE #TEMP_UPDTDATE
		END

		IF NOT EXISTS (SELECT name
			FROM tempdb.dbo.sysobjects
			WHERE ID = OBJECT_ID(N'tempdb..#TEMP_UPDTDATE'))
		begin
			--drop table [#TEMP_UPDTDATE]
			--print ('PATH 1') ;		
			Select MAX(ltm.tran_begin_time) InsertUpdateDate, DHFHAUAC.ItemID, MAX(DHFHAUAC.[__$operation]) Operation
				INTO #TEMP_UPDTDATE 
				FROM
				CDC.dbo_HFit_HealthAssesmentUserAnswers_CT AS DHFHAUAC
				INNER JOIN CDC.lsn_time_mapping AS LTM ON DHFHAUAC.[__$start_lsn] = LTM.start_lsn
				WHERE
					DHFHAUAC.[__$operation] IN ( 2, 4 )
					--*****************************************************
					--and (DHFHAUAC.ItemCreatedWhen between @StartDate and @EndDate
					--OR DHFHAUAC.ItemModifiedWhen between @StartDate and @EndDate)
					--*****************************************************
				GROUP BY
				DHFHAUAC.ItemID
				CREATE INDEX PKI_TEMP_UPDTDATE ON #TEMP_UPDTDATE (ItemID);
		end
		else
		begin
			--print ('PATH 2') ;
			truncate table #TEMP_UPDTDATE;
				INSERT INTO #TEMP_UPDTDATE
				SELECT
					MAX(ltm.tran_begin_time) InsertUpdateDate, DHFHAUAC.ItemID, MAX(DHFHAUAC.[__$operation]) Operation
					FROM
					CDC.dbo_HFit_HealthAssesmentUserAnswers_CT AS DHFHAUAC
					INNER JOIN CDC.lsn_time_mapping AS LTM ON DHFHAUAC.[__$start_lsn] = LTM.start_lsn
					WHERE
						DHFHAUAC.[__$operation] IN ( 2, 4 )
						--*****************************************************
						--and (DHFHAUAC.ItemCreatedWhen between @StartDate and @EndDate
						--OR DHFHAUAC.ItemModifiedWhen between @StartDate and @EndDate)
						--*****************************************************
					GROUP BY
					DHFHAUAC.ItemID	
		end	

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
			, haum.HAModuleNodeGUID 
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
			, hauq.HAQuestionNodeGUID
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
		   --,CASE WHEN haua.ItemCreatedWhen = haua.ItemModifiedWhen THEN 'I'
		   --      ELSE 'U'
		   -- END AS ChangeType
		   --,haua.ItemCreatedWhen
		   --,haua.ItemModifiedWhen
			, CASE CDC.Operation
				WHEN 2 THEN 'I'
				WHEN 4 THEN 'U'
				END AS ChangeType
			, CDC.InsertUpdateDate
			, CASE CDC.Operation
				WHEN 2 THEN CDC.InsertUpdateDate
				END AS InsertDate
			, CASE CDC.Operation
				WHEN 4 THEN CDC.InsertUpdateDate
				END AS UpdateDate
		FROM
			dbo.HFit_HealthAssesmentUserStarted AS haus
		INNER JOIN dbo.CMS_User AS CU ON haus.UserID = cu.UserID
		INNER JOIN dbo.CMS_UserSettings AS CUS2 ON CUS2.UserSettingsUserID = CU.UserID
		INNER JOIN dbo.CMS_UserSite AS CUS ON CU.UserID = CUS.UserID
		INNER JOIN dbo.CMS_Site AS CS ON CUS.SiteID = CS.SiteID
		INNER JOIN dbo.HFit_Account AS HFA ON hfa.SiteID = cs.SiteID
		INNER JOIN dbo.view_EDW_HFit_HealthAssesmentUserModule AS haum ON haus.ItemID = haum.HAStartedItemID
		INNER JOIN dbo.view_EDW_HFit_HealthAssesmentUserRiskCategory AS haurc ON haum.ItemID = haurc.HAModuleItemID
		INNER JOIN dbo.view_EDW_HFit_HealthAssesmentUserRiskArea AS haura ON haurc.ItemID = haura.HARiskCategoryItemID
		INNER JOIN dbo.view_EDW_HFit_HealthAssesmentUserQuestion AS hauq ON haura.ItemID = hauq.HARiskAreaItemID
		                   
		INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ 
			ON hauq.HAQuestionNodeGUID = VHFHAQ.NodeGUID
	
		LEFT OUTER JOIN dbo.HFit_HealthAssesmentUserQuestionGroupResults AS HFHAUQGR ON hauq.ItemID = HFHAUQGR.HARiskAreaItemID
		INNER JOIN dbo.HFit_HealthAssesmentUserAnswers AS haua ON hauq.ItemID = haua.HAQuestionItemID
		inner join #TEMP_UPDTDATE AS CDC ON haua.ItemID = CDC.ItemID
		WHERE CDC.InsertUpdateDate BETWEEN @StartDate AND @EndDate

if @TrackPerf is not null 
BEGIN
	set @P1End = getdate() ;
	exec proc_EDW_MeasurePerf 'ElapsedTime','HealthAssessment-P1',0, @P1Start, @P1End;
	print ('Perf Details Recorded') ;
END
ELSE
	print ('No Perf Details Requested') ;
	
END	--ENd of PROC