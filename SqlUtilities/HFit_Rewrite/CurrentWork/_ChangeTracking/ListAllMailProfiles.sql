USE msdb;
GO

DECLARE
@Total int
, @cnt int
, @ProfileName varchar (50) 
, @Server varchar (50) 
, @Sub varchar (400) ;

SET @Total = (SELECT MAX (profile_id) 
                     FROM sysmail_profile);
SET @cnt = 1;

SET @Server = @@SERVERNAME;

WHILE @cnt <= @Total
    BEGIN
        SET @ProfileName = (SELECT name
                                   FROM sysmail_profile
                                   WHERE profile_id = @cnt);

        SET @Sub = 'Testing Email From ' + @Server + ' from profile : ' + @ProfileName;
        IF @ProfileName IS NOT NULL
            BEGIN

                PRINT @ProfileName;
                PRINT @Sub;

                EXEC msdb.dbo.sp_send_dbmail
                @recipients = 'Test@gmail.com'
                , @subject = @Sub
                , @body = @Sub
                , @profile_name = @ProfileName
                , @body_format = 'HTML';
            END;

        SET @cnt = @cnt + 1;
    END;