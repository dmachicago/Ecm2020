USE msdb ;
GO
SELECT
profiles.name ProfileName,
accounts.name AccountName,
faileditems.recipients Recipients,
faileditems.subject MailSubject,
faileditems.body EmailBody,
faileditems.sent_status SentStatus,
maillog.description EventMessage,
faileditems.sent_date SentDate
FROM dbo.sysmail_faileditems faileditems
INNER JOIN dbo.sysmail_allitems allitems
ON faileditems.mailitem_id = allitems.mailitem_id
INNER JOIN dbo.sysmail_profile profiles
ON faileditems.profile_id = profiles.profile_id
INNER JOIN dbo.sysmail_profileaccount profileaccounts
ON profiles.profile_id = profileaccounts.profile_id
INNER JOIN dbo.sysmail_account accounts
ON profileaccounts.account_id = accounts.account_id
INNER JOIN dbo.sysmail_event_log maillog
ON faileditems.mailitem_id = maillog.mailitem_id