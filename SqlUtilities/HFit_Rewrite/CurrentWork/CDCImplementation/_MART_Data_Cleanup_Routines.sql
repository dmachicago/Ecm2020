

--drop table #TEMPFK
--go
-- SELECT *
---- into #TEMPFK
--              FROM MART_SYNC_Table_FKRels
--		    --where ParentTable != 'BASE_Cms_user'
--              ORDER BY ParentTable, ChildTable ;

--update #TEMPFK
--set ParentTable = ChildTable, 
--ParentSurrogateKeyName  = 'SurrogateKey_' + substring(ChildTable,6,9999),
--ChildTable = ParentTable,
--ParentColumn = ChildColumn,
--ChildColumn = ParentColumn ;

--select * from #TEMPFK

--insert into MART_SYNC_Table_FKRels (ParentTable,ParentSurrogateKeyName,ChildTable,ParentColumn,ChildColumn)
--select ParentTable,ParentSurrogateKeyName,ChildTable,ParentColumn,ChildColumn
--from #TEMPFK

/*********************************************************************************************************************************************************
SELECT 'EXEC msdb.dbo.sp_delete_jobstep @job_name = ''' + JOB.NAME + ''', @step_id = ' + cast(STEP.STEP_ID as nvarchar(10)) + ';' + char(10) + 'GO' as CMD
FROM Msdb.dbo.SysJobs JOB
INNER JOIN Msdb.dbo.SysJobSteps STEP ON STEP.Job_Id = JOB.Job_Id
WHERE JOB.Enabled = 1
AND STEP.STEP_NAME like 'SyncFkey[_]%'
ORDER BY JOB.NAME, STEP.STEP_ID desc ;
*********************************************************************************************************************************************************/

/*********************************************************************************************************
SELECT 'ALTER TABLE ' + OBJECT_NAME(f.parent_object_id) + ' DROP CONSTRAINT ' + f.name + + char(10) + 'GO'
FROM sys.foreign_keys AS f
INNER JOIN sys.foreign_key_columns AS fc
ON f.OBJECT_ID = fc.constraint_object_id
where f.name like 'FK[_]BASE[_]%'
*********************************************************************************************************/
/********************************************************************************************************
SELECT 'DROP INDEX ' + ind.name + ' ON ' + t.name + ';' + char(10) + 'go'
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
	and (ind.name like 'PIFK[_]%' or ind.name like 'SKI[_]%')
ORDER BY 
     t.name, ind.name, ind.index_id, ic.index_column_id 
*********************************************************************************************************/

/*
       SELECT 'ALTER TABLE ' + table_name + ' DROP COLUMN ' + column_name + ';'
          FROM information_schema.COLUMNS
          WHERE column_name LIKE 'SurrogateKey%'
            AND column_name <> 'SurrogateKey_' + SUBSTRING (TABLE_NAME , 6 , LEN (TABLE_NAME) - 5) 
		  and table_name not like '%[_]DEL'
*/


--*****************************************************************************
DECLARE
      @DropIndex varchar (max) = '' , 
      @DropColumn varchar (max) = '' , 
      @TableName varchar (255) ;

DECLARE table_cursor CURSOR
    FOR SELECT DISTINCT ParentTable
          FROM MART_SYNC_Table_FKRels
          WHERE ParentTable <> 'BASE_CMS_User';

OPEN table_cursor;

FETCH NEXT FROM table_cursor INTO @TableName;

WHILE @@FETCH_STATUS = 0
    BEGIN
        SET @DropIndex = '';
        SET @DropColumn = '';

        SELECT @DropIndex = @DropIndex + 'DROP INDEX ' + si.name + ' ON ' + so.name + ';'
          FROM
               sys.indexes AS si
               JOIN sys.objects AS so
               ON si.object_id = so.object_id
          WHERE so.type = 'U'    --Only get indexes for User Created Tables
            AND si.name IS NOT NULL
            AND (si.name LIKE 'SKI%'
              OR si.name LIKE 'PIFK%')
            AND so.name = @TableName;

        PRINT @DropIndex;

        SELECT @DropColumn = @DropColumn + 'ALTER TABLE ' + table_name + ' DROP COLUMN ' + column_name + ';'
          FROM information_schema.COLUMNS
          WHERE table_name = @TableName
            AND column_name LIKE 'SurrogateKey%'
            AND column_name <> 'SurrogateKey_' + SUBSTRING (@TableName , 6 , LEN (@TableName) - 5) ;

        SET @DropColumn = REPLACE (@DropColumn , CHAR (10) + CHAR (10) , CHAR (10)) ;
        PRINT @DropColumn;

        FETCH NEXT FROM table_cursor INTO @TableName;
    END;

CLOSE table_cursor;
DEALLOCATE table_cursor;