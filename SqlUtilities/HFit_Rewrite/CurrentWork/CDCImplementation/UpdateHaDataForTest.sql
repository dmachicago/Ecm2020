--select top 100 * from CMS_UserSettings
--select top 100 * FROM HFit_HealthAssesmentUserModule

update CMS_UserSettings
set UserRegistrationInfo = 'NA:'+cast(getdate() as nvarchar (50))
where UserSettingsID in (Select distinct top 50 UserSettingsID from CMS_UserSettings)

update HFit_HealthAssesmentUserModule
set ItemModifiedWhen = getdate()
where UserID in (Select distinct top 50 USERID from HFit_HealthAssesmentUserModule)

update HFit_HealthAssesmentUserModule
set ItemModifiedWhen = getdate()
where [HAStartedItemID] in (select distinct top 50 [HAStartedItemID] from HFit_HealthAssesmentUserModule)
