EXEC msdb.dbo.sp_send_dbmail
@profile_name = 'SBSProfile',
@recipients = 'email@email.com',
@body = 'Email test from Step-By-Step Book.',
@subject = 'Test From SQL Server' ;