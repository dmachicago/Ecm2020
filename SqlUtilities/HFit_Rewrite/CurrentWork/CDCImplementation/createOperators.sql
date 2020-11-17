
go

print 'Executing createOperators.SQL'
go

if not exists (select name FROM MSDB.dbo.sysoperators where name = 'DBA_Email')
begin
EXEC msdb.dbo.sp_add_operator @name=N'DBA_Email', 
		@enabled=1, 
		@weekday_pager_start_time=60000, 
		@weekday_pager_end_time=220000, 
		@saturday_pager_start_time=80000, 
		@saturday_pager_end_time=220000, 
		@sunday_pager_start_time=80000, 
		@sunday_pager_end_time=220000, 
		@pager_days=127, 
		@email_address=N'Scott.Montgomery@hfit.com', 
		@category_name=N'[Uncategorized]'
end 

if not exists (select name  FROM MSDB.dbo.sysoperators where name = 'DBA_Mail')
begin
EXEC msdb.dbo.sp_add_operator @name=N'DBA_Mail', 
		@enabled=1, 
		@weekday_pager_start_time=60000, 
		@weekday_pager_end_time=220000, 
		@saturday_pager_start_time=80000, 
		@saturday_pager_end_time=220000, 
		@sunday_pager_start_time=80000, 
		@sunday_pager_end_time=220000, 
		@pager_days=127, 
		@email_address=N'Scott.Montgomery@hfit.com', 
		@category_name=N'[Uncategorized]'
end 

if not exists (select name  FROM MSDB.dbo.sysoperators where name = 'DBA_Notify')
begin
EXEC msdb.dbo.sp_add_operator @name=N'DBA_Notify', 
		@enabled=1, 
		@weekday_pager_start_time=60000, 
		@weekday_pager_end_time=220000, 
		@saturday_pager_start_time=80000, 
		@saturday_pager_end_time=220000, 
		@sunday_pager_start_time=80000, 
		@sunday_pager_end_time=220000, 
		@pager_days=127, 
		@email_address=N'Scott.Montgomery@hfit.com', 
		@category_name=N'[Uncategorized]'
end 

go
print 'Executed createOperators.SQL'
go
