

if not exists (select name from sys.indexes where name = 'CI_BASE_CMS_UserSettings_Mstr')
CREATE NONCLUSTERED INDEX CI_BASE_CMS_UserSettings_Mstr
ON [dbo].[BASE_CMS_UserSettings] ([HFitUserMpiNumber])
INCLUDE ([UserNickName],[UserGender],[UserDateOfBirth],[UserSettingsUserID],[HFitPrimaryContactID],[LASTMODIFIEDDATE],[CT_UserNickName],[CT_UserGender],[CT_UserDateOfBirth],[CT_HFitUserMpiNumber])

if not exists (select name from sys.indexes where name = 'CI_BASE_CMS_MembershipUser_UsrID')
CREATE NONCLUSTERED INDEX CI_BASE_CMS_MembershipUser_UsrID
ON [dbo].[BASE_CMS_MembershipUser] ([UserID])
INCLUDE ([MembershipID],[ValidTo],[CT_UserID],[CT_ValidTo])


if not exists (select name from sys.indexes where name = 'CI_BASE_CMS_MembershipUser_MbrID')
CREATE NONCLUSTERED INDEX CI_BASE_CMS_MembershipUser_MbrID
ON [dbo].[BASE_CMS_MembershipUser] ([MembershipID])
INCLUDE ([UserID])