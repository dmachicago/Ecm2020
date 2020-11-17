
select 'EXEC msdb.dbo.sp_update_job @job_name =  "' + s.name + '",@enabled = 1 ' + char(10) + 'GO'
 from  msdb..sysjobs s 
 left join master.sys.syslogins l on s.owner_sid = l.sid

