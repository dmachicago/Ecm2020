
SELECT 'EXEC dbo.sp_start_job ''' + name + '''' + char(10) + 'GO'
FROM
msdb.dbo.sysjobs WITH (NOLOCK)
WHERE
enabled = 1
and (name like '%_ApplyCT'
or  name like 'job_proc_%')

