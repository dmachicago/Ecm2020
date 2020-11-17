sysmail_help_profileaccount_sp
EXECUTE msdb.dbo.sysmail_help_profileaccount_sp;
SELECT top 100 * FROM msdb.dbo.sysmail_event_log;

 USE msdb
    EXEC sp_send_dbmail
      @profile_name = 'databaseBot',
      @recipients = 'wdalemiller@gmail.com;',
      @subject = 'T-SQL Query Result',
      @body = 'The result from SELECT is appended below.',
      @execute_query_database = 'msdb',
      @query = 'SELECT subsystem_id,subsystem FROM syssubsystems'  --  
  --  
GO 
print('***** FROM: sp_send_dbmail.sql'); 
GO 
