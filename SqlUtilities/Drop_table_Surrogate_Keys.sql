

-- DROP ALL THE SKEY INDEXES
SELECT 
     TableName = t.name,
     IndexName = ind.name,
	+ 'Print ''Processing ' + t.name + ' / ' + ind.name + ''''+ char(10) + 'GO'+ char(10) 
	+'If exists (select name from sys.indexes where name = ''' + ind.name +''')' + char(10)
	+'Drop index [' + ind.name +'] on ' + t.name + ';' + char(10) + 'GO'
FROM 
     sys.indexes ind 
INNER JOIN 
     sys.index_columns ic ON  ind.object_id = ic.object_id and ind.index_id = ic.index_id 
INNER JOIN 
     sys.columns col ON ic.object_id = col.object_id and ic.column_id = col.column_id 
INNER JOIN 
     sys.tables t ON ind.object_id = t.object_id 
WHERE 
     ind.name like 'SKI[_]%' or ind.name like '%[_]SurrogateKey[_]%'
ORDER BY 
     t.name, ind.name, ind.index_id, ic.index_column_id 

-- DROP ALL THE INDEXES using SurrogateKey columns
SELECT 
     TableName = t.name,
     IndexName = ind.name,
     IndexId = ind.index_id,
     ColumnId = ic.index_column_id,
     ColumnName = col.name,
	+ 'Print ''Processing ' + t.name + ' / ' + ind.name + ''''+ char(10) + 'GO'+ char(10) 
	+'If exists (select name from sys.indexes where name = ''' + ind.name +''')' + char(10)
	+'Drop index [' + ind.name +'] on ' + t.name + ';' + char(10) + 'GO'
FROM 
     sys.indexes ind 
INNER JOIN 
     sys.index_columns ic ON  ind.object_id = ic.object_id and ind.index_id = ic.index_id 
INNER JOIN 
     sys.columns col ON ic.object_id = col.object_id and ic.column_id = col.column_id 
INNER JOIN 
     sys.tables t ON ind.object_id = t.object_id 
WHERE 
     ind.is_primary_key = 0 
     AND ind.is_unique = 0 
     AND ind.is_unique_constraint = 0 
     AND t.is_ms_shipped = 0 
	 and col.name like 'SurrogateKey%'
ORDER BY 
     t.name, ind.name, ind.index_id, ic.index_column_id 




-- DROP ALL THE SURROGATE KEY Constraints
SELECT 
    TableName = t.Name,
    ColumnName = c.Name,
    dc.Name,
	'ALTER TABLE dbo.' + t.name + ' DROP ' +dc.Name + char(10) + 'GO' 
FROM sys.tables t
INNER JOIN sys.default_constraints dc ON t.object_id = dc.parent_object_id
INNER JOIN sys.columns c ON dc.parent_object_id = c.object_id AND c.column_id = dc.parent_column_id
where c.Name like '%SurrogateKey%'

-- DROP ALL THE EMBEDDED SURROGATE KEYS OTHER THAN THE PRIMARY KEY
select C.Table_name, column_name
,'Print ''Dropping col: ' + C.Table_name + ' / ' + column_name + ''''+ char(10) + 'GO'+ char(10) 
+'If exists (select column_name from information_schema.columns where column_name = ''' + column_name +''' and table_name = '''+C.Table_name+''')' + char(10)
+'     Alter table '+C.table_name+ ' drop column ' + column_name + ';' + char(10) + 'GO' as cmd
from INFORMATION_SCHEMA.COLUMNS C
join INFORMATION_SCHEMA.tables T 
	on T.TABLE_NAME = C.TABLE_NAME
	and T.TABLE_TYPE = 'BASE _TABLE' 
where column_name like 'SurrogateKey%'
and charindex(substring(C.table_name,6,9999),column_name) <=0 


-- REMOVE ALL THE SYNC FOREIGN KEY FUNCTIONS FROM JOBS
SELECT JOB.NAME AS JOB_NAME,
STEP.STEP_ID AS STEP_NUMBER,
STEP.STEP_NAME AS STEP_NAME,
STEP.COMMAND AS STEP_QUERY,
'EXEC sp_delete_jobstep @job_name = '''+JOB.NAME+''', @step_id = ' + cast(STEP_ID as nvarchar(50)) + ';' +char(10) + 'GO' as CMD
FROM Msdb.dbo.SysJobs JOB
INNER JOIN Msdb.dbo.SysJobSteps STEP ON STEP.Job_Id = JOB.Job_Id
WHERE STEP.STEP_NAME LIKE '%SyncFKey%'
ORDER BY JOB.NAME, STEP.STEP_ID desc

-- RESET THE LAST STEP OF THE JOB TO REPORT WITH END REPORTING SUCCESS
-- drop table #XX
SELECT JOB.NAME AS JOB_NAME
--,CMD = 'EXEC sp_delete_jobstep @job_name = '''+JOB.NAME+''', @step_id = ' + cast(STEP_ID as nvarchar(50)) + ';' +char(10) + 'GO' 
,max(STEP.STEP_ID) as STEP_ID
into #XX
FROM Msdb.dbo.SysJobs JOB
INNER JOIN Msdb.dbo.SysJobSteps STEP 
    ON STEP.Job_Id = JOB.Job_Id
WHERE JOB.NAME LIKE 'PROC_JOB[_]%'
group by JOB.NAME 

select 'EXEC sp_update_jobstep @job_name = '''+JOB_NAME+''', @step_id = ' + cast(STEP_ID as nvarchar(50)) + ', @on_success_action = 1;' +char(10) + 'GO' 
from #XX


-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
