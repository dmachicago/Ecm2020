create procedure [dbo].[Proc_EDW_HealthAssessment] (@StartDate as datetime, @EndDate as datetime)
as
begin
	--Set statistics IO ON
	--SET STATISTICS TIME ON
	
	--declare @StartDate as datetime ;
	--declare @EndDate as datetime ;
	--set @StartDate = '2014-05-28';
	--set @EndDate = '2014-05-29';
	--USE: exec Proc_EDW_HealthAssessment '2001-04-08', '2014-07-02'
	--	   exec Proc_EDW_HealthAssessment null, null	--Get previous day
	
	--This procedure will fetch the EDW_HealthAssessment. Because nested views are used, a
	--temporary table is constructed first and then it is used for the join to get the TITLE.
	--This took the view from running between 9 and 35 minutes to just under 20 seconds.
	--NOTE: If the StartDate is left NULL , it will grab the previous day's data.
	--WDM 6/16/2014
	IF @StartDate is null 
	BEGIN
		--set @StartDate = getdate() - 1 ;
		set @StartDate  =DATEADD(Day, 0, DATEDIFF(Day, 0, GetDate()));	--Midnight yesterday;		
	END
	IF @EndDate is null 
	BEGIN
		set @EndDate = getdate();
	END
	IF EXISTS
	(
		SELECT name
		FROM tempdb.dbo.sysobjects
		WHERE ID = OBJECT_ID(N'tempdb..#Temp_HealthAssesmentUserQuestion')
	)
	BEGIN
		DROP TABLE #Temp_HealthAssesmentUserQuestion
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
			cdc.dbo_HFit_HealthAssesmentUserAnswers_CT AS DHFHAUAC
			INNER JOIN cdc.lsn_time_mapping AS LTM ON DHFHAUAC.[__$start_lsn] = LTM.start_lsn
			WHERE
				DHFHAUAC.[__$operation] IN ( 2, 4 )
				--*****************************************************
				and (DHFHAUAC.ItemCreatedWhen between @StartDate and @EndDate
				OR DHFHAUAC.ItemModifiedWhen between @StartDate and @EndDate)
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
				cdc.dbo_HFit_HealthAssesmentUserAnswers_CT AS DHFHAUAC
				INNER JOIN cdc.lsn_time_mapping AS LTM ON DHFHAUAC.[__$start_lsn] = LTM.start_lsn
				WHERE
					DHFHAUAC.[__$operation] IN ( 2, 4 )
					--*****************************************************
					and (DHFHAUAC.ItemCreatedWhen between @StartDate and @EndDate
					OR DHFHAUAC.ItemModifiedWhen between @StartDate and @EndDate)
					--*****************************************************
				GROUP BY
				DHFHAUAC.ItemID	
	end	

	IF NOT EXISTS (SELECT name
		FROM tempdb.dbo.sysobjects
		WHERE ID = OBJECT_ID(N'tempdb..#Temp_HealthAssesmentUserQuestion'))
	begin
		--drop table [#Temp_HealthAssesmentUserQuestion]
		--print ('PATH 1') ;		
		select distinct hauq.HAQuestionDocumentID, VHFHAQ.Title
			INTO #Temp_HealthAssesmentUserQuestion 
			from HFit_HealthAssesmentUserQuestion hauq
			INNER JOIN dbo.View_HFit_HealthAssesmentQuestions AS VHFHAQ 
				ON hauq.HAQuestionDocumentID = VHFHAQ.DocumentID;
			CREATE INDEX TMPPK_HealthAssesmentUserQuestion 
				ON #Temp_HealthAssesmentUserQuestion (HAQuestionDocumentID);
	end
	else
	begin
		--print ('PATH 2') ;
		truncate table #Temp_HealthAssesmentUserQuestion;
			INSERT INTO #Temp_HealthAssesmentUserQuestion
			select distinct hauq.HAQuestionDocumentID, VHFHAQ.Title
				from HFit_HealthAssesmentUserQuestion hauq
				INNER JOIN dbo.View_HFit_HealthAssesmentQuestions AS VHFHAQ 
					ON hauq.HAQuestionDocumentID = VHFHAQ.DocumentID			
	end	
	
	SELECT
		haus.ItemID AS UserStartedItemID
		, haus.HADocumentID
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
		, haum.HAModuleDocumentID
		, haum.HAModuleVersionID
		, haurc.ItemID AS UserRiskCategoryItemID
		, haurc.CodeName AS UserRiskCategoryCodeName
		, haurc.HARiskCategoryDocumentID
		, haurc.HARiskCategoryVersionID
		, haura.ItemID AS UserRiskAreaItemID
		, haura.CodeName AS UserRiskAreaCodeName
		, haura.HARiskAreaDocumentID
		, haura.HARiskAreaVersionID
		, hauq.ItemID AS UserQuestionItemID
		, VHFHAQ.Title
		, hauq.CodeName AS UserQuestionCodeName
		, hauq.HAQuestionDocumentID
		, hauq.HAQuestionVersionID
		, haua.ItemID AS UserAnswerItemID
		, haua.HAAnswerDocumentID
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
		, CASE cdc.Operation
			WHEN 2 THEN 'I'
			WHEN 4 THEN 'U'
			END AS ChangeType
		, cdc.InsertUpdateDate
		, CASE cdc.Operation
			WHEN 2 THEN cdc.InsertUpdateDate
			END AS InsertDate
		, CASE cdc.Operation
			WHEN 4 THEN cdc.InsertUpdateDate
			END AS UpdateDate
	FROM
		dbo.HFit_HealthAssesmentUserStarted AS haus
	INNER JOIN dbo.CMS_User AS CU ON haus.UserID = cu.UserID
	INNER JOIN dbo.CMS_UserSettings AS CUS2 ON CUS2.UserSettingsUserID = CU.UserID
	INNER JOIN dbo.CMS_UserSite AS CUS ON CU.UserID = CUS.UserID
	INNER JOIN dbo.CMS_Site AS CS ON CUS.SiteID = CS.SiteID
	INNER JOIN dbo.HFit_Account AS HFA ON hfa.SiteID = cs.SiteID
	INNER JOIN dbo.HFit_HealthAssesmentUserModule AS haum ON haus.ItemID = haum.HAStartedItemID
	INNER JOIN dbo.HFit_HealthAssesmentUserRiskCategory AS haurc ON haum.ItemID = haurc.HAModuleItemID
	INNER JOIN dbo.HFit_HealthAssesmentUserRiskArea AS haura ON haurc.ItemID = haura.HARiskCategoryItemID
	INNER JOIN dbo.HFit_HealthAssesmentUserQuestion AS hauq ON haura.ItemID = hauq.HARiskAreaItemID
	INNER JOIN #Temp_HealthAssesmentUserQuestion AS VHFHAQ ON hauq.HAQuestionDocumentID = VHFHAQ.HAQuestionDocumentID
	LEFT OUTER JOIN dbo.HFit_HealthAssesmentUserQuestionGroupResults AS HFHAUQGR ON hauq.ItemID = HFHAUQGR.HARiskAreaItemID
	INNER JOIN dbo.HFit_HealthAssesmentUserAnswers AS haua ON hauq.ItemID = haua.HAQuestionItemID
	INNER JOIN #TEMP_UPDTDATE AS CDC ON haua.ItemID = CDC.ItemID
where cdc.InsertUpdateDate between @StartDate and @EndDate
--OR tUpdateDate between @StartDate and @EndDate

end


-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016