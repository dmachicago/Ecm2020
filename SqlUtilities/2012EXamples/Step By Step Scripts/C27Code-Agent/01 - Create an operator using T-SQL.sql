USE [msdb]
GO
EXEC msdb.dbo.sp_update_operator @name=N'WeekdayDBA',
@enabled=1,
@weekday_pager_start_time=70000,
@weekday_pager_end_time=180000,
@pager_days=62,
@email_address=N'jdoe@email.com',
@pager_address=N'',
@netsend_address=N''
GO