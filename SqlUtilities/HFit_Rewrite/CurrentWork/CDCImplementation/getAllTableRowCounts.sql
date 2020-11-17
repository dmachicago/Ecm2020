drop table #TMPX
go
SELECT T.name AS [TABLE NAME], 
       I.rows AS [ROWCOUNT] 
into #TMPX
FROM   sys.tables AS T 
       INNER JOIN sys.sysindexes AS I 
               ON T.object_id = I.id 
                  AND I.indid < 2 
where t.name not like '%DEL'
and t.name not like '%testdata'
and t.name not like '%VerHist'
and t.name like 'BASE%'
ORDER  BY I.rows DESC

select count(*) from #TMPX where [ROWCOUNT] > 0 
select * from #TMPX order by [ROWCOUNT] desc
select 'select ''' + [table name] + ''' count(*) from ' + [table name] + char(10) + 'GO' from #TMPX where [ROWCOUNT] > 0 
select 'print ''' + [table name] + '''' + char(10) + 
'EXEC proc_QuickRowCount '+ [table name] +',1' + char(10) + 'GO' from #TMPX where [ROWCOUNT] > 0 