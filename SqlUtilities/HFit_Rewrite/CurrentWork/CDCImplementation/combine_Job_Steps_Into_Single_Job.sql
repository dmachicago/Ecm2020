
GO
PRINT 'Executing combine_Job_Steps_Into_Single_Job.sql';
GO
IF EXISTS (SELECT name
             FROM sys.procedures
             WHERE name = 'combine_Job_Steps_Into_Single_Job') 
    BEGIN
        DROP PROCEDURE combine_Job_Steps_Into_Single_Job;
    END;
GO
-- exec combine_Job_Steps_Into_Single_Job 'job_proc_BASE_COM_PublicStatus_KenticoCMS_1_ApplyCT'
-- exec combine_Job_Steps_Into_Single_Job 'job_proc_view_EDW_BioMetrics_KenticoCMS_1'
CREATE PROCEDURE combine_Job_Steps_Into_Single_Job (@job1 AS nvarchar (250) , 
                                                    @OverRide AS bit = 0) 
AS
BEGIN
    DECLARE
          @job2 AS nvarchar (250) = '' , 
          @job3 AS nvarchar (250) = '' , 
          @StepCnt AS int = 0;
    print '*************************** BEGIN *******************************';
    SET @Job2 = REPLACE (@Job1 , 'KenticoCMS_1' , 'KenticoCMS_2') ;
    SET @Job3 = REPLACE (@Job1 , 'KenticoCMS_1' , 'KenticoCMS_3') ;

    SET @StepCnt = (SELECT COUNT (*)
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
                      WHERE sJob.Name = @Job1) ;

    IF @StepCnt >= 3
        BEGIN
            PRINT 'It appears that this procedure, ' + @Job1 + ', may have already been processed. ';
            PRINT 'If not, set @OverRide to 1 and resubmit.';
            IF @OverRide = 0
                BEGIN
                    RETURN
                END;
        END;

    PRINT 'PROCESSING:';
    PRINT @Job1;
    PRINT @Job2;
    PRINT @Job3;

    --Select distinct sJStp.command

    DECLARE
          @MySql AS nvarchar (max) , 
          @DBNAME AS nvarchar (250) = 'KenticoCMS_2' , 
		@TgtDBNAME AS nvarchar (250) = 'KenticoCMS_2' , 
          @StepID AS int = 0 , 
          @CMD AS nvarchar (250) = '' , 
          @Name AS nvarchar (250) = '';

    DECLARE JobStepCursor CURSOR
        FOR SELECT sJob.Name , 
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
              WHERE sJob.Name = @Job1
                 OR sJob.Name = @Job2
                 OR sJob.Name = @Job3
              GROUP BY sJob.Name , 
                       sJStp.step_id , 
                       sJStp.command;

    OPEN JobStepCursor;

    FETCH NEXT FROM JobStepCursor INTO @Name , @StepID , @CMD;

    DECLARE
          @FinalStep AS nvarchar (500) = NULL ;

    set @StepCnt = 0 ;

    WHILE @@FETCH_STATUS = 0
        BEGIN
            PRINT CAST (@StepID AS nvarchar (50)) + ' : ' + @CMD;
            IF CHARINDEX ('proc_RemoveHashCodeDuplicateRows' , @CMD) > 0
                BEGIN
                    IF @job1 = @Name
                        BEGIN EXEC msdb..sp_delete_jobstep @job_name = @Job1 , @step_id = @StepID;
                        END;
                    SET @FinalStep = @CMD;
                END;
            ELSE
                BEGIN
                    DECLARE
                          @SNAME AS nvarchar (500) = 'STEP_' + @CMD;
                    --Add the current step top Job1
                    IF @job1 = @Name
                        BEGIN EXEC msdb..sp_delete_jobstep @job_name = @Job1 , @step_id = @StepID;
                        END;
                    PRINT 'NAME: ' + @Name + ' : ' + @Job1;
                    PRINT 'Add step ' + @CMD + ' to job: ' + @Job1;
                    SET @StepCnt = @StepCnt + 1;
                    EXEC msdb..sp_add_jobstep @job_name = @Job1 , @step_name = @SNAME , @subsystem = N'TSQL' , @command = @CMD , @on_success_action = 3 , @retry_attempts = 2 , @retry_interval = 15 , @step_id = @StepCnt, @database_name = @TgtDBNAME;
                END;
            FETCH NEXT FROM JobStepCursor INTO @Name , @StepID , @CMD;
        END;

    IF @FinalStep IS NOT NULL
        BEGIN
            PRINT 'Add FINAL step ' + @FinalStep + ' to job: ' + @Job1;
            SET @StepCnt = @StepCnt + 1;
            EXEC msdb..sp_add_jobstep @job_name = @Job1 , @step_name = N'Step4_RemoveHashCodeDuplicateRows' , @subsystem = N'TSQL' , @command = @CMD , @on_success_action = 1 , @retry_attempts = 2 , @retry_interval = 15 , @step_id = @StepCnt, @database_name = @TgtDBNAME;
        END;
    ELSE
        BEGIN 
		  EXEC msdb..sp_update_jobstep @job_name = @Job1 , @on_success_action = 1 , @step_id = @StepCnt, @database_name = @TgtDBNAME;
        END;
    PRINT 'DISABLE JOB: ' + @Job2;
    EXEC msdb..sp_update_job @job_name = @Job2 , @enabled = 0;
    PRINT 'DISABLE JOB: ' + @Job3;
    EXEC msdb..sp_update_job @job_name = @Job3 , @enabled = 0;
    CLOSE JobStepCursor;
    DEALLOCATE JobStepCursor;
    print '*************************** END **********************************';
END;
GO
PRINT 'Executing combine_Job_Steps_Into_Single_Job.sql';
GO
