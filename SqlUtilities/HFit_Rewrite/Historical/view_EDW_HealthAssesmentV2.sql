
/****** Object:  View [dbo].[view_EDW_HealthAssesment]    Script Date: 8/6/2014 10:28:22 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[view_EDW_HealthAssesment]
AS
--7/15/2014 17:19 min. 46,750 Rows DEV
--7/15/2014 per Mark Turner
--HAModuleDocumentID is on its way out, so is - 
--Module - RiskCategory - RiskArea - Question - Answer 
--all the "DocumentID" fields are deprecated and replaced by corresponding NodeGUID fields
	SELECT 
		haus.ItemID AS UserStartedItemID
		, hauq.HAQuestionNodeGUID	-- as HADocumentID
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
		, haum.HAModuleNodeGUID		--as HAModuleDocumentID
		, NULL as HAModuleVersionID
		, haurc.ItemID AS UserRiskCategoryItemID
		, haurc.CodeName AS UserRiskCategoryCodeName
		, haurc.HARiskCategoryNodeGUID		--as HARiskCategoryDocumentID
		, NULL as HARiskCategoryVersionID
		, haura.ItemID AS UserRiskAreaItemID
		, haura.CodeName AS UserRiskAreaCodeName
		, haura.HARiskAreaNodeGUID		--as HARiskAreaDocumentID
		, NULL as HARiskAreaVersionID
		, hauq.ItemID AS UserQuestionItemID
		, VHFHAQ.Title
		, hauq.CodeName AS UserQuestionCodeName
		, hauq.HAQuestionNodeGUID		--as HAQuestionDocumentID
		, NULL as HAQuestionVersionID
		, haua.ItemID AS UserAnswerItemID
		, haua.HAAnswerNodeGUID			--as HAAnswerDocumentID
		, NULL as HAAnswerVersionID
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
	INNER JOIN dbo.View_HFit_HealthAssesmentQuestions AS VHFHAQ 
		ON hauq.HAQuestionNodeGUID = VHFHAQ.NodeGUID
	LEFT OUTER JOIN dbo.HFit_HealthAssesmentUserQuestionGroupResults AS HFHAUQGR ON hauq.ItemID = HFHAUQGR.HARiskAreaItemID
	INNER JOIN dbo.HFit_HealthAssesmentUserAnswers AS haua ON hauq.ItemID = haua.HAQuestionItemID
	INNER JOIN (
					SELECT
						MAX(ltm.tran_begin_time) InsertUpdateDate
						, DHFHAUAC.ItemID
						, MAX(DHFHAUAC.[__$operation]) Operation
					FROM
						cdc.dbo_HFit_HealthAssesmentUserAnswers_CT AS DHFHAUAC
					INNER JOIN cdc.lsn_time_mapping AS LTM ON DHFHAUAC.[__$start_lsn] = LTM.start_lsn
					WHERE
						DHFHAUAC.[__$operation] IN ( 2, 4 )
					GROUP BY
						DHFHAUAC.ItemID
				) AS CDC ON haua.ItemID = CDC.ItemID




GO


