

/****************************************************************************************************************************

exec proc_genPullChangesProc 'KenticoCMS_1', 'HFit_UserCoachingAlert_NotMet', @DeBug=0, @GenProcOnlyDoNotPullData=1 

-- OR

exec proc_GenBaseTableFromView 'KenticoCMS_1', 'view_EDW_CoachingPPTAvailable', 'no', @GenJobToExecute = 1, @SkipIfExists = 0
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'view_EDW_CoachingPPTAvailable', 'no', @GenJobToExecute = 1, @SkipIfExists = 1
exec proc_GenBaseTableFromView 'KenticoCMS_3', 'view_EDW_CoachingPPTAvailable', 'no', @GenJobToExecute = 1, @SkipIfExists = 1

exec regen_CT_Triggers BASE_view_EDW_CoachingPPTAvailable
****************************************************************************************************************************/

-- DROP ALL THE SKEY INDEXES
SELECT
       TableName = t.name
     ,IndexName = ind.name
     ,+'Print ''Processing ' + t.name + ' / ' + ind.name + '''' + CHAR (10) 
	+ 'GO' + CHAR (10) 
	+ 'If exists (select name from sys.indexes where name = ''' + ind.name + ''')' + CHAR (10) 
	+ '     Drop index [' + ind.name + '] on ' + t.name + ';' + CHAR (10) 
	+ 'GO'
FROM
     sys.indexes AS ind
          INNER JOIN sys.index_columns AS ic
          ON
       ind.object_id = ic.object_id AND
       ind.index_id = ic.index_id
          INNER JOIN sys.columns AS col
          ON
       ic.object_id = col.object_id AND
       ic.column_id = col.column_id
          INNER JOIN sys.tables AS t
          ON
       ind.object_id = t.object_id
WHERE
      ind.name LIKE 'SKI[_]%' OR ind.name LIKE '%[_]SurrogateKey[_]%'
ORDER BY
         t.name , ind.name , ind.index_id , ic.index_column_id;

-- DROP ALL THE INDEXES using SurrogateKey columns
SELECT
       TableName = t.name
     ,IndexName = ind.name
     ,IndexId = ind.index_id
     ,ColumnId = ic.index_column_id
     ,ColumnName = col.name
     ,+'Print ''Processing ' + t.name + ' / ' + ind.name + '''' + CHAR (10) + 'GO' + CHAR (10) + 'If exists (select name from sys.indexes where name = ''' + ind.name + ''')' + CHAR (10) + 'Drop index [' + ind.name + '] on ' + t.name + ';' + CHAR (10) + 'GO'
FROM
     sys.indexes AS ind
          INNER JOIN sys.index_columns AS ic
          ON
       ind.object_id = ic.object_id AND
       ind.index_id = ic.index_id
          INNER JOIN sys.columns AS col
          ON
       ic.object_id = col.object_id AND
       ic.column_id = col.column_id
          INNER JOIN sys.tables AS t
          ON
       ind.object_id = t.object_id
WHERE
       ind.is_primary_key = 0 AND
       ind.is_unique = 0 AND
       ind.is_unique_constraint = 0 AND
       t.is_ms_shipped = 0 AND col.name LIKE 'SurrogateKey%'
ORDER BY
         t.name , ind.name , ind.index_id , ic.index_column_id;

-- DROP ALL THE SURROGATE KEY Constraints
SELECT
       TableName = t.Name
     ,ColumnName = c.Name
     ,dc.Name
     ,'ALTER TABLE dbo.' + t.name + ' DROP ' + dc.Name + CHAR (10) + 'GO'
FROM
     sys.tables AS t
          INNER JOIN sys.default_constraints AS dc
          ON
       t.object_id = dc.parent_object_id
          INNER JOIN sys.columns AS c
          ON
       dc.parent_object_id = c.object_id AND
       c.column_id = dc.parent_column_id
WHERE c.Name LIKE '%SurrogateKey%';

-- DROP ALL THE EMBEDDED SURROGATE KEYS OTHER THAN THE PRIMARY KEY
SELECT
       C.Table_name
     ,column_name
     ,'Print ''Dropping col: ' + C.Table_name + ' / ' + column_name + '''' + CHAR (10) + 'GO' + CHAR (10) + 'If exists (select column_name from information_schema.columns where column_name = ''' + column_name + ''' and table_name = ''' + C.Table_name + ''')' + CHAR (10) + '     Alter table ' + C.table_name + ' drop column ' + column_name + ';' + CHAR (10) + 'GO' AS cmd
FROM
     INFORMATION_SCHEMA.COLUMNS AS C
          JOIN INFORMATION_SCHEMA.tables AS T
          ON
       T.TABLE_NAME = C.TABLE_NAME AND
       T.TABLE_TYPE = 'BASE _TABLE'
WHERE
      column_name LIKE 'SurrogateKey%' AND
       CHARINDEX (SUBSTRING (C.table_name , 6 , 9999) , column_name) <= 0;

-- REMOVE ALL THE SYNC FOREIGN KEY FUNCTIONS FROM JOBS
SELECT
       JOB.NAME AS JOB_NAME
     ,STEP.STEP_ID AS STEP_NUMBER
     ,STEP.STEP_NAME AS STEP_NAME
     ,STEP.COMMAND AS STEP_QUERY
     ,'EXEC sp_delete_jobstep @job_name = ''' + JOB.NAME + ''', @step_id = ' + CAST (STEP_ID AS NVARCHAR (50)) + ';' + CHAR (10) + 'GO' AS CMD
FROM
     Msdb.dbo.SysJobs AS JOB
          INNER JOIN Msdb.dbo.SysJobSteps AS STEP
          ON
       STEP.Job_Id = JOB.Job_Id
WHERE STEP.STEP_NAME LIKE '%SyncFKey%'
ORDER BY
         JOB.NAME , STEP.STEP_ID DESC;

-- RESET THE LAST STEP OF THE JOB TO REPORT WITH END REPORTING SUCCESS
-- drop table #XX
SELECT
       JOB.NAME AS JOB_NAME
       --,CMD = 'EXEC msdb..sp_delete_jobstep @job_name = '''+JOB.NAME+''', @step_id = ' + cast(STEP_ID as nvarchar(50)) + ';' +char(10) + 'GO' 
     ,
       MAX (STEP.STEP_ID) AS STEP_ID INTO
                                          #XX
FROM
     Msdb.dbo.SysJobs AS JOB
          INNER JOIN Msdb.dbo.SysJobSteps AS STEP
          ON
       STEP.Job_Id = JOB.Job_Id
WHERE
     (
     JOB.NAME LIKE 'JOB_PROC_BASE[_]%' OR JOB.NAME LIKE 'JOB_PROC_VIEW[_]%') AND JOB.NAME NOT LIKE '%[_]delete'
GROUP BY
         JOB.NAME;

SELECT
       'EXEC sp_update_jobstep @job_name = ''' + JOB_NAME + ''', @step_id = ' + CAST (STEP_ID AS NVARCHAR (50)) + ', @on_success_action = 1;' + CHAR (10) + 'GO'
FROM #XX;

EXEC sp_update_jobstep @job_name = 'job_proc_BASE_CMS_Document_KenticoCMS_1_ApplyCT' , @step_id = 14 , @on_success_action = 1;
GO