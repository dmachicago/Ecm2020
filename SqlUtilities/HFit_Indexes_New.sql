
 idxHfitRewardsAwardUserDetail_CreateDate_PI

CREATE NONCLUSTERED INDEX [HFit_Account_ClientCode_PI] ON [dbo].[HFit_Account]
(
	[AccountCD] ASC
)
GO


CREATE NONCLUSTERED INDEX [HFit_Account_SiteID_PI] ON [dbo].[HFit_Account]
(
	[SiteID] ASC
)
GO


CREATE NONCLUSTERED INDEX [ix_CmsUserSite_Userid_PI] ON [dbo].[CMS_UserSite]
(
	[UserID] ASC
)
INCLUDE ( 	[UserSiteID]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX [idxHfitRewardsAwardUserDetail_CreateDate_PI] ON [dbo].[HFit_RewardsAwardUserDetail]
(
	[ItemCreatedWhen] DESC, 	[ItemModifiedWhen] DESC
)
GO


--This would help a great deal in EDW HA querries
CREATE NONCLUSTERED INDEX [idxHfitRewardsAwardUserDetail_CreateDate_PI] ON [cdc].[dbo_HFit_HealthAssesmentUserAnswers_CT]
(
	[ItemCreatedWhen] desc, [ItemModifiedWhen] desc
)

GO


-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
