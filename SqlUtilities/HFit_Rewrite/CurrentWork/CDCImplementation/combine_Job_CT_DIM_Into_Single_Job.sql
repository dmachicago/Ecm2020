
GO
PRINT 'Executing combine_Job_CT_DIM_Into_Single_Job.sql';
GO
IF EXISTS (SELECT name
             FROM sys.procedures
             WHERE name = 'combine_Job_CT_DIM_Into_Single_Job') 
    BEGIN
        DROP PROCEDURE combine_Job_CT_DIM_Into_Single_Job;
    END;
GO
-- exec combine_Job_CT_DIM_Into_Single_Job
CREATE PROCEDURE combine_Job_CT_DIM_Into_Single_Job (@OverRide AS bit = 0) 
AS
BEGIN

    -- declare @OverRide as bit = 0 ;
    DECLARE
		  @MasterJob AS nvarchar (250) = 'job_proc_CT_DIM_$Master' , 
          @job2 AS nvarchar (250) = '' , 
          @job3 AS nvarchar (250) = '' , 
          @StepCnt AS int = 0 ,
		@StepName AS nvarchar (250) = '' ,
          @MySql AS nvarchar (max) , 
		@Msg AS nvarchar (max) , 
          @DBNAME AS nvarchar (250) = DB_NAME(), 
          @StepID AS int = 0 , 
          @CMD AS nvarchar (250) = '' , 
          @Name AS nvarchar (250) = '';
-- drop table #TempCT_Jobs
    print '*************************** BEGIN *******************************';

            SELECT sJob.Name , sJStp.step_name as StepName ,
                   sJStp.step_id , 
                   sJStp.command 			    
		  into #TempCT_Jobs
              FROM
                   MSDB.dbo.SysJobSteps AS sJStp
                   INNER JOIN MSDB.dbo.SysJobs AS sJob
                   ON sJStp.Job_ID = sJob.Job_ID
                   LEFT JOIN MSDB.dbo.SysJobSteps AS sOSSTP
                   ON sJStp.Job_ID = sOSSTP.Job_ID
                  AND sJStp.On_Success_Step_ID = sOSSTP.Step_ID
                   LEFT JOIN MSDB.dbo.SysJobSteps AS sOFSTP
                   ON sJStp.Job_ID = sOFSTP.Job_ID
                  AND sJStp.On_Fail_Step_ID = sOFSTP.Step_ID
                   INNER JOIN MSDB..SysCategories AS sCat
                   ON sJob.Category_ID = sCat.Category_ID
              WHERE sJob.Name = @MasterJob ;
              --order BY sJob.Name
		--select * from #TempCT_Jobs ;
    DECLARE MasterStepsCursor CURSOR
	   for 
	   select Name , StepName ,step_id , command 	
		  from #TempCT_Jobs order by step_id desc ;
 OPEN MasterStepsCursor;

    FETCH NEXT FROM MasterStepsCursor INTO @Name ,@StepName, @StepID , @CMD;
        WHILE @@FETCH_STATUS = 0
        BEGIN
		  if @StepName != 'StartUp' --and @StepName != 'LAST-STEP'
		  begin
			 set @Msg = 'Removing step: ' + @StepName + ' : ' + cast(@StepID as nvarchar(50)) ;
			 exec PrintImmediate @msg ;
			 EXEC msdb..sp_delete_jobstep
				@job_name = @Name,
				@step_id = @StepID ;
		  end 
		  FETCH NEXT FROM MasterStepsCursor INTO @Name ,@StepName, @StepID , @CMD;
	   end 

    close MasterStepsCursor ;
    deallocate  MasterStepsCursor ;

    DECLARE JobStepCursor CURSOR
        FOR 
	   SELECT sJob.Name , 
                   sJStp.step_id , 
                   sJStp.command
              FROM
                   MSDB.dbo.SysJobSteps AS sJStp
                   INNER JOIN MSDB.dbo.SysJobs AS sJob
                   ON sJStp.Job_ID = sJob.Job_ID
                   LEFT JOIN MSDB.dbo.SysJobSteps AS sOSSTP
                   ON sJStp.Job_ID = sOSSTP.Job_ID
                  AND sJStp.On_Success_Step_ID = sOSSTP.Step_ID
                   LEFT JOIN MSDB.dbo.SysJobSteps AS sOFSTP
                   ON sJStp.Job_ID = sOFSTP.Job_ID
                  AND sJStp.On_Fail_Step_ID = sOFSTP.Step_ID
                   INNER JOIN MSDB..SysCategories AS sCat
                   ON sJob.Category_ID = sCat.Category_ID
              WHERE sJob.Name != @MasterJob
                 and sJob.Name like 'job_proc_CT_DIM%'
                 
    OPEN JobStepCursor;
    FETCH NEXT FROM JobStepCursor INTO @Name , @StepID , @CMD;

    set @StepCnt = 0 ;

    WHILE @@FETCH_STATUS = 0
        BEGIN
			        DECLARE
                          @SNAME AS nvarchar (500) = 'STEP_' + @CMD;
                    --Add the current step top Job1
					set @Msg = 'Add step ' + @CMD + ' to job: ' + @MasterJob;
					exec PrintImmediate @msg ;
                    SET @StepCnt =2;
                    EXEC msdb..sp_add_jobstep @job_name = @MasterJob , @step_name = @SNAME , @subsystem = N'TSQL' , @command = @CMD , @on_success_action = 3 , @retry_attempts = 2 , @retry_interval = 15 ; -- , @step_id = 2;

            FETCH NEXT FROM JobStepCursor INTO @Name , @StepID , @CMD;
        END;
                
    CLOSE JobStepCursor;
    DEALLOCATE JobStepCursor;

     DECLARE JobDisableCursor CURSOR
        FOR 
	   SELECT sJob.Name , 
                   sJStp.step_id , 
                   sJStp.command
              FROM
                   MSDB.dbo.SysJobSteps AS sJStp
                   INNER JOIN MSDB.dbo.SysJobs AS sJob
                   ON sJStp.Job_ID = sJob.Job_ID
                   LEFT JOIN MSDB.dbo.SysJobSteps AS sOSSTP
                   ON sJStp.Job_ID = sOSSTP.Job_ID
                  AND sJStp.On_Success_Step_ID = sOSSTP.Step_ID
                   LEFT JOIN MSDB.dbo.SysJobSteps AS sOFSTP
                   ON sJStp.Job_ID = sOFSTP.Job_ID
                  AND sJStp.On_Fail_Step_ID = sOFSTP.Step_ID
                   INNER JOIN MSDB..SysCategories AS sCat
                   ON sJob.Category_ID = sCat.Category_ID
              WHERE sJob.Name != @MasterJob
                 and sJob.Name like 'job_proc_CT_DIM%'
				 and sJob.enabled = 1 ;

      OPEN JobDisableCursor;

    FETCH NEXT FROM JobDisableCursor INTO @Name , @StepID , @CMD;
        WHILE @@FETCH_STATUS = 0
        BEGIN
		  set @msg = 'DISABLE JOB: ' + @Name;
		  exec PrintImmediate @msg ;
		  EXEC msdb..sp_update_job @job_name = @Name , @enabled = 0;
		  FETCH NEXT FROM JobDisableCursor INTO @Name , @StepID , @CMD;
	   end

    CLOSE JobDisableCursor;
    DEALLOCATE JobDisableCursor;

	 SELECT sJob.Name , sJStp.step_name as StepName ,
                   sJStp.step_id , 
                   sJStp.command 			    
		  into #Temp_Jobs_Steps
              FROM
                   MSDB.dbo.SysJobSteps AS sJStp
                   INNER JOIN MSDB.dbo.SysJobs AS sJob
                   ON sJStp.Job_ID = sJob.Job_ID
                   LEFT JOIN MSDB.dbo.SysJobSteps AS sOSSTP
                   ON sJStp.Job_ID = sOSSTP.Job_ID
                  AND sJStp.On_Success_Step_ID = sOSSTP.Step_ID
                   LEFT JOIN MSDB.dbo.SysJobSteps AS sOFSTP
                   ON sJStp.Job_ID = sOFSTP.Job_ID
                  AND sJStp.On_Fail_Step_ID = sOFSTP.Step_ID
                   INNER JOIN MSDB..SysCategories AS sCat
                   ON sJob.Category_ID = sCat.Category_ID
              WHERE sJob.Name = @MasterJob ;
		--select * from #Temp_Jobs_Steps ;
	declare @MaxStepId as int = (Select max (step_id) from #TempCT_Jobs	) ;		   
	print '@MaxStepId: ' + cast(@MaxStepId as nvarcHaR(50)) ;
	DECLARE RenumCursor CURSOR
	   for 
	   select Name , StepName ,step_id , command 	
		  from #Temp_Jobs_Steps ;

 OPEN RenumCursor;
 
    FETCH NEXT FROM RenumCursor INTO @Name ,@StepName, @StepID , @CMD;
        WHILE @@FETCH_STATUS = 0
        BEGIN
			set @msg = 'Altering Job Step: ' + @StepName + ' : ' + cast(@StepID as nvarchar(50)) ;
			exec PrintImmediate @msg ;
			if @StepID <@MaxStepId
			EXEC msdb..sp_update_jobstep
				@job_name = @Name,
				@step_id = @StepID,
				@on_fail_action  = 3 ;
				else 
				begin
				set @msg = 'LAST Job Step: ' + @StepName + ' : ' + cast(@StepID as nvarchar(50)) ;
					exec PrintImmediate @msg ;
				EXEC msdb..sp_update_jobstep
				@job_name = @Name,
				@step_id = @StepID,
				@on_success_action   = 1 ;
				end 
				FETCH NEXT FROM RenumCursor INTO @Name ,@StepName, @StepID , @CMD;
		end 

		
    CLOSE RenumCursor;
    DEALLOCATE RenumCursor;

    print '*************************** END **********************************';
END;
GO
PRINT 'Executing combine_Job_CT_DIM_Into_Single_Job.sql';
GO
