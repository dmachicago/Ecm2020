
/*
exec isJobRunning 'job_EDW_GetStagingData_HA_KenticoCMS_Prod1'
exec isJobRunning 'job_EDW_GetStagingData_HA_KenticoCMS_Prod3'
exec isJobRunning 'job_EDW_GetStagingData_HADefinition_KenticoCMS_QA'

declare @b as int = 0 ;
exec @b = isJobRunning 'job_EDW_GetStagingData_HA_KenticoCMS_Prod1' ;
print @b

*/

IF EXISTS (SELECT
    name
    FROM sys.procedures
    WHERE name = 'isJobRunning') 
    BEGIN
 DROP PROCEDURE
 isJobRunning;
    END;
GO

CREATE PROCEDURE isJobRunning (
  @jobname AS nvarchar (100)) 
AS
BEGIN
    --DECLARE @jobname sysname  ='job_EDW_GetStagingData_HA_KenticoCMS_Prod1' -- Enter the job name here
    SET NOCOUNT ON;
    IF NOT EXISTS (SELECT
     *
     FROM msdb..sysjobs
     WHERE Name = @jobname) 
 BEGIN
     PRINT @jobname + ' Job does not exists';
 END;
    ELSE
 BEGIN
     DECLARE
     @State AS int = 0;
     CREATE TABLE #xp_results
     (
    job_id  uniqueidentifier NOT NULL
    ,last_run_date  int  NOT NULL
    ,last_run_time  int  NOT NULL
    ,next_run_date  int  NOT NULL
    ,next_run_time  int  NOT NULL
    ,next_run_schedule_id  int  NOT NULL
    ,requested_to_run int  NOT NULL
    , -- BOOL
    request_source int  NOT NULL
    ,request_source_id     sysname   COLLATE database_default
    NULL
    ,running   int  NOT NULL
    , -- BOOL
    current_step   int  NOT NULL
    ,current_retry_attempt int  NOT NULL
    ,job_state int  NOT NULL
     );
     INSERT INTO  #xp_results
     EXECUTE dbo.xp_sqlagent_enum_jobs 1, 'sa';
     IF EXISTS (
     SELECT
     1
     FROM
   #xp_results AS X
  INNER JOIN
  msdb..sysjobs AS J
  ON X.job_id = J.job_id
     WHERE
     x.running = 1
   AND j.name = @jobname) 
  BEGIN
 PRINT @jobname + ' : Job is Running';
 SET @State = 1;
  END;
     ELSE
  BEGIN
 PRINT @jobname + 'Job is NOT Running';
 SET @State = 0;
  END;
     DROP TABLE
   #xp_results;
     RETURN @State;
 END;
END;
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
