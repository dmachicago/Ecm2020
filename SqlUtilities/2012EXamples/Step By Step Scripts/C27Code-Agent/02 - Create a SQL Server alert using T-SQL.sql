USE [msdb]
GO
EXEC msdb.dbo.sp_add_alert @name=N'Deprecated Usage',
@enabled=1,
@delay_between_responses=0,
@include_event_description_in=0,
@performance_condition=N'Deprecated Features|Usage|SET ROWCOUNT|>|0',
@job_id=N'00000000-0000-0000-0000-000000000000'
GO
EXEC msdb.dbo.sp_add_notification
@alert_name=N'Deprecated Usage', @operator_name=N'WeekdayDBA', @notification_method = 1
GO