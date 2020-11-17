
/*
SELECT
	   step.*
	 , JOB.NAME AS JOB_NAME
	 , STEP.STEP_ID AS STEP_NUMBER
	 , STEP.STEP_NAME AS STEP_NAME
	 , STEP.COMMAND AS STEP_QUERY
	 , DATABASE_NAME
  FROM Msdb.dbo.SysJobs AS JOB
	   INNER JOIN Msdb.dbo.SysJobSteps AS STEP
		   ON STEP.Job_Id = JOB.Job_Id
	   WHERE JOB.Enabled = 1
		 AND JOB.Name = 'job_proc_View_HFit_EmailTemplate_Joined_KenticoCMS_1'
	   ORDER BY
				JOB.NAME, STEP.STEP_ID;
*/

GO
IF EXISTS (SELECT name
             FROM sys.procedures
             WHERE name = 'addJobStepFKeySync') 
    BEGIN
        DROP PROCEDURE addJobStepFKeySync
    END;
GO
CREATE PROCEDURE addJobStepFKeySync (@JobName nvarchar (250) , 
                                     @StepName nvarchar (250) , 
                                     @Cmd nvarchar (4000)) 
AS
--1 (default)	Quit with success
--2	Quit with failure
--3	Go to next step
--4	Go to step on_success_step_id

BEGIN
    DECLARE
          @MySql AS nvarchar (max) , 
          @JName AS nvarchar (250) = '' , 
          @SName AS nvarchar (250) = '' , 
          @StepID AS nvarchar (250) = '' , 
          @RetCode AS int = 1;

    BEGIN TRY

        DECLARE
              @ix AS int = 0;
        EXEC @ix = ckJobStepExists @JobName , @StepName;
        IF @ix > 0
            BEGIN
                PRINT '@JobName: ' + @JobName + ' / @StepName: ' + @StepName + ', already exists, skipping.';
                RETURN;
            END;
        DECLARE
              @DBN AS nvarchar (250) = DB_NAME () ;
        EXEC msdb.dbo.sp_add_jobstep @job_name = @JobName , @step_name = @StepName , @on_success_action = 1 , @subsystem = N'TSQL' , @command = @Cmd , @retry_attempts = 5 , @retry_interval = 10 , @database_name = @DBN;
        BEGIN TRY
            DROP TABLE #Steps;
        END TRY
        BEGIN CATCH
            PRINT '**';
        END CATCH;
        CREATE TABLE #Steps (JOB_NAME nvarchar (250) , 
                             STEP_NUMBER int , 
                             STEP_NAME nvarchar (250)) ;

        INSERT INTO #Steps
        SELECT JOB.NAME AS JOB_NAME , 
               STEP.STEP_ID AS STEP_NUMBER , 
               STEP.STEP_NAME AS STEP_NAME
          FROM
               Msdb.dbo.SysJobs AS JOB
               INNER JOIN Msdb.dbo.SysJobSteps AS STEP
               ON STEP.Job_Id = JOB.Job_Id
          WHERE JOB.Enabled = 1
            AND JOB.Name = @JobName
          ORDER BY JOB.NAME , STEP.STEP_ID;

        DECLARE
              @iCnt int = 0 , 
              @ii int = 0 , 
              @iLoc int = 0;
        SET @iCnt = (SELECT COUNT (*) FROM #Steps) ;

        DECLARE C CURSOR
            FOR SELECT JOB.NAME AS JOB_NAME , 
                       STEP.STEP_ID AS STEP_NUMBER , 
                       STEP.STEP_NAME AS STEP_NAME
                  FROM
                       Msdb.dbo.SysJobs AS JOB
                       INNER JOIN Msdb.dbo.SysJobSteps AS STEP
                       ON STEP.Job_Id = JOB.Job_Id
                  WHERE JOB.Enabled = 1
                    AND JOB.Name = @JobName
                  ORDER BY JOB.NAME , STEP.STEP_ID;

        OPEN C;

        FETCH NEXT FROM C INTO @JName , @StepID , @SName;

        WHILE @@FETCH_STATUS = 0
            BEGIN
                SET @ii = @ii + 1;

                IF @ii < @iCnt
                    BEGIN
                        SET @MySql = 'EXEC msdb.dbo.sp_update_jobstep @job_name = ''' + @JobName + ''', @step_id = ' + CAST (@StepID AS nvarchar (10)) + ', @on_success_action = 3, @database_name = ''' + DB_NAME () + ''' ';
                        EXEC (@MySql) ;
                    END;
                ELSE
                    BEGIN
                        SET @MySql = 'EXEC msdb.dbo.sp_update_jobstep @job_name = ''' + @JobName + ''', @step_id = ' + CAST (@StepID AS nvarchar (10)) + ', @on_success_action = 1, @database_name = ''' + DB_NAME () + ''' ';
                        EXEC (@MySql) ;
                    END;

                FETCH NEXT FROM C INTO @JobName , @StepID , @StepName;
            END;

        CLOSE C;
        DEALLOCATE C;
    END TRY
    BEGIN CATCH
        PRINT 'ERROR: Failed to add SYNC JOB STEP.';
        SET @RetCode = -1;
    END CATCH;
    RETURN @RetCode;
END;

GO

IF EXISTS (SELECT name
             FROM sys.procedures
             WHERE name = 'ckJobStepExists') 
    BEGIN
        DROP PROCEDURE ckJobStepExists
    END;
GO
CREATE PROCEDURE ckJobStepExists (@JobName nvarchar (250) , 
                                  @StepName nvarchar (250)) 
AS
BEGIN
    DECLARE
          @i int = 0;
    SET @i = (SELECT COUNT (*)
                FROM
                     Msdb.dbo.SysJobs AS JOB
                     INNER JOIN Msdb.dbo.SysJobSteps AS STEP
                     ON STEP.Job_Id = JOB.Job_Id
                WHERE JOB.Name = @JobName
                  AND STEP.step_name = @StepName) ;
    RETURN @i;
END;

GO
IF EXISTS (SELECT name
             FROM sys.procedures
             WHERE name = 'ckJobExists') 
    BEGIN
        DROP PROCEDURE ckJobExists
    END;
GO

-- SELECT count(*) FROM Msdb.dbo.SysJobs WHERE Name = 'job_proc_BASE_Board_Message_KenticoCMS_1_ApplyCT'
-- exec ckJobExists 'job_proc_BASE_Board_Message_KenticoCMS_1_ApplyCT'
--                   job_proc_BASE_Board_Message_KenticoCMS_1_ApplyCT
CREATE PROCEDURE ckJobExists (@JobName nvarchar (250)) 
AS
BEGIN
    DECLARE
          @i int = 0;
    SET @i = (SELECT COUNT (*)
                FROM Msdb.dbo.SysJobs
                WHERE Name = @JobName) ;
    RETURN @i;
END;