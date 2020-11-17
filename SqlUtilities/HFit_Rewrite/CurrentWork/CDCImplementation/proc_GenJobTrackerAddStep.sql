

GO
PRINT 'Executing proc_GenJobTrackerAddStep.sql';
GO
IF EXISTS (SELECT
              name
                  FROM sys.procedures
                  WHERE
                  name = 'proc_GenJobTrackerAddStep') 
    BEGIN
        DROP PROCEDURE
           proc_GenJobTrackerAddStep
    END;
GO
-- proc_GenJobTrackerAddStep.sql
CREATE PROCEDURE proc_GenJobTrackerAddStep (
       @JobName AS NVARCHAR (500) 
     , @StepName AS NVARCHAR (500) 
     , @CMD AS NVARCHAR (MAX)) 
AS
BEGIN
--***************************************************************
-- In generated code, it is needed at times to add a step to
-- an already generated job. This proc allows you to add a new
-- step to an existing job. Very useful in adding the dozens
-- of steps needed to complete a MART update to tables, 
-- dimensions, or fact tables.
--***************************************************************
    IF NOT EXISTS (SELECT
                      b.step_name
                          FROM msdb.dbo.sysjobs AS a WITH (NOLOCK) 
                               INNER JOIN msdb.dbo.sysjobsteps AS b WITH (NOLOCK) ON
                          a.job_id = b.job_id
                          WHERE
                          a.Name = @JobName AND
                          b.step_name = @StepName) 
        BEGIN

            EXEC msdb..sp_add_jobstep
            @job_name = @JobName ,
            @step_name = @StepName ,
            @subsystem = N'TSQL' ,
            @command = @CMD ,
            @retry_attempts = 5 ,
            @retry_interval = 5;

        END;
    ELSE
        BEGIN
            PRINT 'FAILED TO ADD Step: ' + @StepName + ' to Job: ' + @JobName;
        END;

END;
GO
PRINT 'Executed proc_GenJobTrackerAddStep.sql';
GO
