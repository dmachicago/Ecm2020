USE [KenticoCMS_Datamart_2]
GO
ALTER TABLE [dbo].[BASE_HFit_HealthAssesmentUserRiskCategory]
DISABLE CHANGE_TRACKING;
go

/****** Object:  Index [PKEY_BASE_HFit_HealthAssesmentUserRiskCategory]    Script Date: 3/3/2016 5:25:59 PM ******/
ALTER TABLE [dbo].[BASE_HFit_HealthAssesmentUserRiskCategory] DROP CONSTRAINT [PKEY_BASE_HFit_HealthAssesmentUserRiskCategory]
GO

--alter table BASE_HFit_HealthAssesmentUserRiskCategory drop column SurrogateKey_HFit_HealthAssesmentUserAnswers 
--alter table BASE_HFit_HealthAssesmentUserRiskCategory add SurrogateKey_HFit_HealthAssesmentUserAnswers bigint null

/****** Object:  Index [PKEY_BASE_HFit_HealthAssesmentUserRiskCategory]    Script Date: 3/3/2016 5:25:59 PM ******/
ALTER TABLE [dbo].[BASE_HFit_HealthAssesmentUserRiskCategory] ADD  CONSTRAINT [PKEY_BASE_HFit_HealthAssesmentUserRiskCategory] PRIMARY KEY CLUSTERED 
(
    SurrogateKey_HFit_HealthAssesmentUserRiskCategory
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO


ALTER TABLE [dbo].[BASE_HFit_HealthAssesmentUserRiskCategory]
ENABLE CHANGE_TRACKING
WITH (TRACK_COLUMNS_UPDATED = ON)