
/*

--Check status
exec msdb.sysmail_help_queue_sp @queue_type = 'Mail' ;

--To send Database Mail, users must be a member of the DatabaseMailUserRole
EXEC msdb.sys.sp_helprolemember 'DatabaseMailUserRole';
EXEC msdb.sys.sp_helprolemember 'MartEmailAdmin';

--To add users to the DatabaseMailUserRole role
sp_addrolemember @rolename = 'DatabaseMailUserRole',@membername = 'MartEmailAdmin';

--users must have access to at least one Database Mail profile
EXEC msdb.dbo.sysmail_help_principalprofile_sp;

--confirm that the Database Mail is started
EXEC msdb.dbo.sysmail_help_status_sp;

--check the status of the mail queue
EXEC msdb.dbo.sysmail_help_queue_sp @queue_type = 'mail';

*/
--exec proc_SendEmailNotice

GO
PRINT 'FQN: proc_SendEmailNotice.SQL';
PRINT 'Creating procedure proc_SendEmailNotice ';
GO
IF EXISTS (SELECT
                  name
                  FROM sys.objects
                  WHERE name = 'proc_SendEmailNotice') 
    BEGIN
        DROP PROCEDURE
             proc_SendEmailNotice;
    END;
GO
-- exec dbo.proc_SendEmailNotice 'FACT', 'Fact Table Update', 'This is the body of the text'
CREATE PROC dbo.proc_SendEmailNotice (
     @NotificationArea AS nvarchar (100) 
   , @Subj AS nvarchar (250) 
   , @EmailBody AS nvarchar (max)) 
AS
BEGIN

    DECLARE @Allrecipients AS nvarchar (max) = '';
    DECLARE @Onerecipient AS nvarchar (250) = '';
    DECLARE getemails CURSOR
        FOR SELECT
                   Email
                   FROM MART_FactPullNotificationEmails
                   WHERE NotificationArea = @NotificationArea;

    OPEN getemails;
    FETCH NEXT FROM getemails INTO @Onerecipient;
    WHILE @@Fetch_Status = 0
        BEGIN
            SET @Allrecipients = @Allrecipients + @Onerecipient + ';';
		  print 'EMailing ' + @Onerecipient + ' Area: ' + @NotificationArea ;
            FETCH NEXT FROM getemails INTO @Onerecipient;
        END;
    CLOSE getemails;
    DEALLOCATE getemails;
    PRINT 'Report Sent To: ' + @Allrecipients;
    EXEC msdb..sp_send_dbmail @Profile_Name = 'MARTNotify', @Recipients = @Allrecipients, @Subject = @Subj, @Body = @EmailBody, @Execute_Query_Database = 'msdb', @Query = NULL;
END;
GO
PRINT 'Created proc_SendEmailNotice';
GO
