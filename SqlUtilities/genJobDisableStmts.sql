SELECT [name], 'IF EXISTS (SELECT job_id FROM msdb.dbo.sysjobs_view WHERE name = ''' + [name] +''')' + char(10) + 'EXEC msdb.dbo.sp_update_job @job_name='''+ [name] + ''',@enabled = 0' + char(10) + '; -- GO' + char(10) FROM msdb.dbo.sysjobs
where name like '%[_]delete'


-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
