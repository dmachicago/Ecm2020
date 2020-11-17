
GO

if not exists (select name from sys.indexes where name = 'PI_CMS_UserSite_SiteID')
BEGIN 
CREATE NONCLUSTERED INDEX PI_CMS_UserSite_SiteID
ON [dbo].[CMS_UserSite] ([SiteID])
INCLUDE ([UserSiteID],[UserID],[UserPreferredCurrencyID],[UserPreferredShippingOptionID],[UserPreferredPaymentOptionID],[UserDiscountLevelID])
END

GO


if not exists (select name from sys.indexes where name = 'PI_CMS_User_UserIsGlobalAdministrator')
BEGIN 

CREATE NONCLUSTERED INDEX [PI_CMS_User_UserIsGlobalAdministrator] ON [dbo].[CMS_User]
(
	[UserIsGlobalAdministrator] ASC,
	UserID
)
END 

GO


if not exists (select name from sys.indexes where name = 'PI_HealthAssesmentUserAnswers_QID')
BEGIN 

CREATE NONCLUSTERED INDEX [PI_HealthAssesmentUserAnswers_QID] ON [dbo].[HFit_HealthAssesmentUserAnswers]
(
	[ItemID],
	[ItemCreatedWhen],
	[ItemModifiedWhen],
	[HAQuestionItemID]
)
END 
GO



