
-- proc_genPullSyncProcTests
-- exec proc_genPullSyncProcTests 1
-- exec proc_genPullLaunchMArtJobsTestsTests 1

go
print 'Executing CREATE PROCEDURE proc_genPullSyncProcTests.sql'
go
if exists (select name from sys.procedures where name = 'proc_genPullSyncProcTests')
    drop procedure proc_genPullSyncProcTests;
go
CREATE PROCEDURE proc_genPullSyncProcTests (@PreviewOnly as bit = 0)
AS
BEGIN

    if @PreviewOnly = 1 
    begin
    		  select 'EXEC ' +  name + char(10) + 'GO' 
			 from sys.procedures 
			 where name like '%_Sync'
			 and name not like '%TBL_DIFF%'
			 and name not like '%TEMP_FK%'
			 and name not like '%tmp_HealthAssessmentData%'
			 and name not like '%proc_GenJobBaseTableSync%'
			 and name not like '%TEMP_FK_Constraints%'
			 and name not like '%sysdiagrams%'
			 and name not like 'proc_GenJob%'			 
			 order by NAME;
			 return ;
    end 

    declare @MSG as nvarchar(max) = '' ;
    declare @i as integer = 0 ;
    declare @iCnt as integer = (select count(*)
			 from sys.procedures where name like '%_Sync')

    DECLARE @MySql AS NVARCHAR (MAX) ;
    DECLARE @DBNAME AS NVARCHAR (250) = 'KenticoCMS_2';
    DECLARE @CMD AS NVARCHAR (250) = '';
    DECLARE CProcTest CURSOR
        FOR
		  select 'EXEC ' +  name  
			 from sys.procedures 
			 			 where name like '%_Sync'
			 and name not like '%TBL_DIFF%'
			 and name not like '%TEMP_FK%'
			 and name not like '%tmp_HealthAssessmentData%'
			 and name not like '%proc_GenJobBaseTableSync%'
			 and name not like '%TEMP_FK_Constraints%'
			 and name not like '%sysdiagrams%'
			 and name not like 'proc_GenJob%'			 
			 order by NAME;

    OPEN CProcTest;

    FETCH NEXT FROM CProcTest INTO @CMD;

    WHILE
           @@FETCH_STATUS = 0
        BEGIN
		  set @i = @i + 1 
		  set @MSG = 'Processing ' + cast(@i as nvarchar(50)) + ' OF ' + cast(@iCnt  as nvarchar(50)) ;
		  exec PrintImmediate @Msg ;
            exec (@CMD) ;
            FETCH NEXT FROM CProcTest INTO @CMD;
        END;

    CLOSE CProcTest;
    DEALLOCATE CProcTest;

END; 

go
print 'Executed CREATE PROCEDURE proc_genPullSyncProcTests.sql'
go

--****************************************************************************************

go
print 'Executing CREATE PROCEDURE proc_genPullLaunchMArtJobsTestsTests.sql'
go
if exists (select name from sys.procedures where name = 'proc_genPullLaunchMArtJobsTestsTests')
    drop procedure proc_genPullLaunchMArtJobsTestsTests;
go
CREATE PROCEDURE proc_genPullLaunchMArtJobsTestsTests (@PreviewOnly as bit = 0)
AS
BEGIN

 if @PreviewOnly = 1 
    begin
    select 'EXEC msdb.dbo.sp_start_job ''' +  name + ''''+ char(10) + 'GO' 
			 from msdb.dbo.sysjobs 
			 where name like '%_ApplyCT'			 
			 or name like 'job_CT_DIM%'
			 or name like 'job_proc_view%'
			 and name not like '%CR27070%'
			 and name not like '%mosbrun%'
			 order by NAME;
			 return ;
    end 

    declare @MSG as nvarchar(max) = '' ;
    declare @i as integer = 0 ;
    declare @iCnt as integer = (select count(*)
			 from sys.procedures where name like '%_Sync')

    DECLARE @MySql AS NVARCHAR (MAX) 
    ,@DBNAME AS NVARCHAR (250) = 'KenticoCMS_2'
    ,@CMD AS NVARCHAR (1000) = ''
    ,@JOB_NAME AS NVARCHAR (250) = '';
    DECLARE CJobTest CURSOR
        FOR
		  select name, 'EXEC msdb.dbo.sp_start_job ''' +  name  + '''' 
			 from msdb.dbo.sysjobs 
			 where name like '%_ApplyCT'			 
			 or name like 'job_CT_DIM%'
			 or name like 'job_proc_view%'
			 and name not like '%CR27070%'
			 and name not like '%mosbrun%'
			 order by NAME;
   
    OPEN CJobTest;

    FETCH NEXT FROM CJobTest INTO @JOB_NAME, @CMD;

    WHILE
           @@FETCH_STATUS = 0
        BEGIN
		  set @i = @i + 1 
		  if @i > 10 goto EXITOUT ;
		  IF NOT EXISTS(     
			 select 1 
			 from msdb.dbo.sysjobs_view job  
			 inner join msdb.dbo.sysjobactivity activity on job.job_id = activity.job_id 
			 where  
				activity.run_Requested_date is not null  
			 and activity.stop_execution_date is null  
			 and job.name = @JOB_NAME 
			 ) 
			 BEGIN      
				set @MSG = 'Launching ' + cast(@i as nvarchar(50)) + ' OF ' + cast(@iCnt  as nvarchar(50)) ;
				exec PrintImmediate @Msg ;
				exec (@CMD) ;
			 END 
			 ELSE 
			 BEGIN 
				set @MSG = 'Job ''' + @JOB_NAME + ''' is already running, skipping. '; 
				exec PrintImmediate @Msg ;
			 END 
		  
            FETCH NEXT FROM CJobTest INTO @JOB_NAME, @CMD;
        END;
EXITOUT:
    CLOSE CJobTest;
    DEALLOCATE CJobTest;

END; 

go
print 'Executed CREATE PROCEDURE proc_genPullLaunchMArtJobsTestsTests.sql'
go