use [KenticoCMS_Datamart_2]
go

SET ANSI_PADDING ON

go

CREATE NONCLUSTERED INDEX [PI_index_BASE_HFit_HealthAssesmentUserAns_8_1042896324__K25_K11_3_5_7_10_12_13_14_18] ON [dbo].[BASE_HFit_HealthAssesmentUserAnswers]
(
	[DBNAME] ASC,
	[HAQuestionItemID] ASC
)
INCLUDE ( 	[HAAnswerPoints],
	[ItemCreatedWhen],
	[ItemModifiedWhen],
	[HAAnswerValue],
	[UOMCode],
	[CodeName],
	[HAAnswerNodeGUID],
	[ItemID]) WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF) ON [PRIMARY]
go

SET ANSI_PADDING ON

go

CREATE NONCLUSTERED INDEX [PI_index_BASE_HFit_HealthAssesmentUserRis_8_1423421682__K11_K25_K18_5_10_12_13_15] ON [dbo].[BASE_HFit_HealthAssesmentUserRiskCategory]
(
	[HAModuleItemID] ASC,
	[DBNAME] ASC,
	[ItemID] ASC
)
INCLUDE ( 	[ItemModifiedWhen],
	[HARiskCategoryScore],
	[CodeName],
	[PreWeightedScore],
	[HARiskCategoryNodeGUID]) WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF) ON [PRIMARY]
go

CREATE STATISTICS [PI_stat_1423421682_18_11] ON [dbo].[BASE_HFit_HealthAssesmentUserRiskCategory]([ItemID], [HAModuleItemID])
go

CREATE STATISTICS [PI_stat_1423421682_5_11_25] ON [dbo].[BASE_HFit_HealthAssesmentUserRiskCategory]([ItemModifiedWhen], [HAModuleItemID], [DBNAME])
go

CREATE STATISTICS [PI_stat_1423421682_25_11_18] ON [dbo].[BASE_HFit_HealthAssesmentUserRiskCategory]([DBNAME], [HAModuleItemID], [ItemID])
go

SET ANSI_PADDING ON

go

CREATE NONCLUSTERED INDEX [PI_index_BASE_HFit_HealthAssesmentUserMod_8_1570898205__K25_K11_K18_10_12_13_15] ON [dbo].[BASE_HFit_HealthAssesmentUserModule]
(
	[DBNAME] ASC,
	[HAStartedItemID] ASC,
	[ItemID] ASC
)
INCLUDE ( 	[HAModuleScore],
	[CodeName],
	[PreWeightedScore],
	[HAModuleNodeGUID]) WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF) ON [PRIMARY]
go

CREATE STATISTICS [PI_stat_1570898205_18_11] ON [dbo].[BASE_HFit_HealthAssesmentUserModule]([ItemID], [HAStartedItemID])
go

CREATE STATISTICS [PI_stat_1570898205_10_11_25] ON [dbo].[BASE_HFit_HealthAssesmentUserModule]([HAModuleScore], [HAStartedItemID], [DBNAME])
go

CREATE STATISTICS [PI_stat_1570898205_11_25_18] ON [dbo].[BASE_HFit_HealthAssesmentUserModule]([HAStartedItemID], [DBNAME], [ItemID])
go

SET ANSI_PADDING ON

go

CREATE NONCLUSTERED INDEX [PI_index_BASE_HFit_HealthAssesmentUserSta_8_1935423506__K16_K34_K33_K27_K2_3_11_12_13_15_19_25_26] ON [dbo].[BASE_HFit_HealthAssesmentUserStarted]
(
	[HACampaignNodeGUID] ASC,
	[DBNAME] ASC,
	[SVR] ASC,
	[ItemID] ASC,
	[UserID] ASC
)
INCLUDE ( 	[HAPaperFlg],
	[HAStartedDt],
	[HACompletedDt],
	[HAScore],
	[HADocumentConfigID],
	[HATelephonicFlg],
	[HAStartedMode],
	[HACompletedMode]) WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF) ON [PRIMARY]
go

CREATE STATISTICS [PI_stat_1935423506_2_34_33_27] ON [dbo].[BASE_HFit_HealthAssesmentUserStarted]([UserID], [DBNAME], [SVR], [ItemID])
go

SET ANSI_PADDING ON

go

CREATE NONCLUSTERED INDEX [PI_index_BASE_cms_user_8_1104800535__K31_K38_K33_19] ON [dbo].[BASE_cms_user]
(
	[UserID] ASC,
	[DBNAME] ASC,
	[SurrogateKey_cms_user] ASC
)
INCLUDE ( 	[UserGUID]) WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF) ON [PRIMARY]
go

CREATE STATISTICS [PI_stat_1104800535_38_33] ON [dbo].[BASE_cms_user]([DBNAME], [SurrogateKey_cms_user])
go

CREATE STATISTICS [PI_stat_1104800535_31_33_38] ON [dbo].[BASE_cms_user]([UserID], [SurrogateKey_cms_user], [DBNAME])
go

CREATE STATISTICS [PI_stat_1104800535_19_31_38] ON [dbo].[BASE_cms_user]([UserGUID], [UserID], [DBNAME])
go

SET ANSI_PADDING ON

go

CREATE NONCLUSTERED INDEX [PI_index_BASE_HFit_HealthAssesmentUserQue_8_447418205__K19_K9_3_11] ON [dbo].[BASE_HFit_HealthAssesmentUserQuestionGroupResults]
(
	[DBNAME] ASC,
	[HARiskAreaItemID] ASC
)
INCLUDE ( 	[PointResults],
	[CodeName]) WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF) ON [PRIMARY]
go

CREATE STATISTICS [PI_stat_447418205_3] ON [dbo].[BASE_HFit_HealthAssesmentUserQuestionGroupResults]([PointResults])
go

CREATE STATISTICS [PI_stat_447418205_9_19] ON [dbo].[BASE_HFit_HealthAssesmentUserQuestionGroupResults]([HARiskAreaItemID], [DBNAME])
go

SET ANSI_PADDING ON

go

CREATE NONCLUSTERED INDEX [PI_index_BASE_cms_usersite_8_1837327147__K14_K3_K2] ON [dbo].[BASE_cms_usersite]
(
	[DBNAME] ASC,
	[SiteID] ASC,
	[UserID] ASC
)WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF) ON [PRIMARY]
go

CREATE STATISTICS [PI_stat_1837327147_2_14_3] ON [dbo].[BASE_cms_usersite]([UserID], [DBNAME], [SiteID])
go

CREATE STATISTICS [PI_stat_1837327147_8_14_3_2] ON [dbo].[BASE_cms_usersite]([Action], [DBNAME], [SiteID], [UserID])
go

SET ANSI_PADDING ON

go

CREATE NONCLUSTERED INDEX [PI_index_BASE_cms_usersettings_8_1840803157__K23_K53_K121] ON [dbo].[BASE_cms_usersettings]
(
	[UserSettingsUserID] ASC,
	[HFitUserMpiNumber] ASC,
	[DBNAME] ASC
)WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF) ON [PRIMARY]
go

CREATE STATISTICS [PI_stat_1840803157_121_53] ON [dbo].[BASE_cms_usersettings]([DBNAME], [HFitUserMpiNumber])
go

SET ANSI_PADDING ON

go

CREATE NONCLUSTERED INDEX [PI_index_BASE_View_HFit_HACampaign_Joined_8_770387551__K191_K54_K178_K13_K14] ON [dbo].[BASE_View_HFit_HACampaign_Joined]
(
	[DBNAME] ASC,
	[DocumentCulture] ASC,
	[HealthAssessmentID] ASC,
	[NodeSiteID] ASC,
	[NodeGUID] ASC
)WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF) ON [PRIMARY]
go

CREATE STATISTICS [PI_stat_770387551_54_13_191] ON [dbo].[BASE_View_HFit_HACampaign_Joined]([DocumentCulture], [NodeSiteID], [DBNAME])
go

CREATE STATISTICS [PI_stat_770387551_191_13_14] ON [dbo].[BASE_View_HFit_HACampaign_Joined]([DBNAME], [NodeSiteID], [NodeGUID])
go

CREATE STATISTICS [PI_stat_770387551_54_14_191_178] ON [dbo].[BASE_View_HFit_HACampaign_Joined]([DocumentCulture], [NodeGUID], [DBNAME], [HealthAssessmentID])
go

CREATE STATISTICS [PI_stat_770387551_191_178_13_14] ON [dbo].[BASE_View_HFit_HACampaign_Joined]([DBNAME], [HealthAssessmentID], [NodeSiteID], [NodeGUID])
go

CREATE STATISTICS [PI_stat_770387551_54_191_13_14] ON [dbo].[BASE_View_HFit_HACampaign_Joined]([DocumentCulture], [DBNAME], [NodeSiteID], [NodeGUID])
go

CREATE STATISTICS [PI_stat_770387551_54_191_178_13_14] ON [dbo].[BASE_View_HFit_HACampaign_Joined]([DocumentCulture], [DBNAME], [HealthAssessmentID], [NodeSiteID], [NodeGUID])
go

SET ANSI_PADDING ON

go

CREATE NONCLUSTERED INDEX [PI_index_BASE_View_EDW_HealthAssesmentQue_8_7292873__K8_K28_K7_2] ON [dbo].[BASE_View_EDW_HealthAssesmentQuestions]
(
	[DocumentCulture] ASC,
	[DBNAME] ASC,
	[NodeGUID] ASC
)
INCLUDE ( 	[Title]) WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF) ON [PRIMARY]
go

CREATE STATISTICS [PI_stat_7292873_8_7] ON [dbo].[BASE_View_EDW_HealthAssesmentQuestions]([DocumentCulture], [NodeGUID])
go

CREATE STATISTICS [PI_stat_7292873_7_28] ON [dbo].[BASE_View_EDW_HealthAssesmentQuestions]([NodeGUID], [DBNAME])
go

SET ANSI_PADDING ON

go

CREATE NONCLUSTERED INDEX [PI_index_BASE_CMS_Site_8_1988279680__K15_K22_10] ON [dbo].[BASE_CMS_Site]
(
	[SiteID] ASC,
	[DBNAME] ASC
)
INCLUDE ( 	[SiteGUID]) WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF) ON [PRIMARY]
go

CREATE STATISTICS [PI_stat_911419858_25_18] ON [dbo].[BASE_HFit_HealthAssesmentUserRiskArea]([DBNAME], [ItemID])
go

CREATE STATISTICS [PI_stat_911419858_11_18_25] ON [dbo].[BASE_HFit_HealthAssesmentUserRiskArea]([HARiskCategoryItemID], [ItemID], [DBNAME])
go

CREATE STATISTICS [PI_stat_2066899972_27_20_11] ON [dbo].[BASE_HFit_HealthAssesmentUserQuestion]([DBNAME], [ItemID], [HARiskAreaItemID])
go

CREATE STATISTICS [PI_stat_2066899972_4_11_27] ON [dbo].[BASE_HFit_HealthAssesmentUserQuestion]([HAQuestionScore], [HARiskAreaItemID], [DBNAME])
go

CREATE STATISTICS [PI_stat_2066899972_17_27_20] ON [dbo].[BASE_HFit_HealthAssesmentUserQuestion]([HAQuestionNodeGUID], [DBNAME], [ItemID])
go

CREATE STATISTICS [PI_stat_2066899972_20_11_17_27] ON [dbo].[BASE_HFit_HealthAssesmentUserQuestion]([ItemID], [HARiskAreaItemID], [HAQuestionNodeGUID], [DBNAME])
go

