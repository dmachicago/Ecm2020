drop view dbo.View_EDW_CDC_HealthAssesmentUserAnswers
go
Create View 
dbo.View_EDW_CDC_HealthAssesmentUserAnswers
as
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
go


/****** Object:  Index [dbo_HFit_HealthAssesmentUserAnswers_CT_PI_StartLsn]    Script Date: 6/12/2014 2:17:34 PM ******/
DROP INDEX [dbo_HFit_HealthAssesmentUserAnswers_CT_PI_StartLsn] ON [cdc].[dbo_HFit_HealthAssesmentUserAnswers_CT]
GO

/****** Object:  Index [dbo_HFit_HealthAssesmentUserAnswers_CT_PI_StartLsn]    Script Date: 6/12/2014 2:17:34 PM ******/
CREATE NONCLUSTERED INDEX [dbo_HFit_HealthAssesmentUserAnswers_CT_PI_StartLsn] ON [cdc].[dbo_HFit_HealthAssesmentUserAnswers_CT]
(
	[__$start_lsn] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

--USE [KenticoCMS_DEV]

GO

CREATE NONCLUSTERED INDEX [View_EDW_CDC_HealthAssesmentUserAnswers_PI_tran_begin_time] ON [cdc].[lsn_time_mapping]
(
	[tran_begin_time] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)

GO

CREATE NONCLUSTERED INDEX [dbo_HFit_HealthAssesmentUserAnswers_CT_ItemID_PI] ON [cdc].[dbo_HFit_HealthAssesmentUserAnswers_CT]
(
	[ItemID] ASC
)

CREATE NONCLUSTERED INDEX [HFit_HealthAssesmentUserQuestion_HARiskAreaItemID_PI] ON [dbo].[HFit_HealthAssesmentUserQuestion]
(
	[HARiskAreaItemID] ASC
)

CREATE NONCLUSTERED INDEX [HFit_HealthAssesmentUserRiskArea_HARiskCategoryItemID_PI] ON [dbo].[HFit_HealthAssesmentUserRiskArea]
(
	[HARiskCategoryItemID] ASC
)  --  
  --  
GO 
print('***** FROM: View_EDW_CDC_HealthAssesmentUserAnswers.sql'); 
GO 
