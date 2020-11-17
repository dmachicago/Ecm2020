
/*
-- Starts a job call zzzDBATest
--declare  @RetStatus int = 0 ;
DECLARE @RetStatus int  
exec sp_sp_start_job_wait    
@job_name = 'job_proc_View_CMS_UserRole_MembershipRole_ValidOnly_Joined_KenticoCMS_1',   
@WaitTime = '00:00:05',    
@JobCompletionStatus = @RetStatus 
OUTPUT  select @RetStatus
*/

alter PROCEDURE dbo.sp_sp_start_job_wait (@job_name sysname , 
                                           @WaitTime datetime = '00:00:05' , 
                                           -- this is parameter for check frequency
                                           @JobCompletionStatus int = NULL OUTPUT) 
AS
BEGIN

    SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
    SET NOCOUNT ON;

    -- DECLARE @job_name sysname
    DECLARE
          @job_id uniqueidentifier;
    DECLARE
          @job_owner sysname;

    --Createing TEMP TABLE
    CREATE TABLE #xp_results (job_id uniqueidentifier NOT NULL , 
                              last_run_date int NOT NULL , 
                              last_run_time int NOT NULL , 
                              next_run_date int NOT NULL , 
                              next_run_time int NOT NULL , 
                              next_run_schedule_id int NOT NULL , 
                              requested_to_run int NOT NULL , 
                              -- BOOL
                              request_source int NOT NULL , 
                              request_source_id sysname COLLATE database_default
                                                        NULL , 
                              running int NOT NULL , 
                              -- BOOL
                              current_step int NOT NULL , 
                              current_retry_attempt int NOT NULL , 
                              job_state int NOT NULL) ;

    SELECT @job_id = job_id
      FROM msdb.dbo.sysjobs
      WHERE name = @job_name;

    SELECT @job_owner = SUSER_SNAME () ;

    INSERT INTO #xp_results
    EXECUTE DFINAnalytics.dbo.xp_sqlagent_enum_jobs 1 , @job_owner , @job_id; 

    -- Start the job if the job is not running
    IF NOT EXISTS (SELECT TOP 1 *
                     FROM #xp_results
                     WHERE running = 1) 
        BEGIN EXEC msdb.dbo.sp_start_job @job_name = @job_name
        END;

    -- Give 2 sec for think time.
    WAITFOR DELAY '00:00:02';

    DELETE FROM #xp_results;
    INSERT INTO #xp_results
    EXECUTE DFINAnalytics.dbo.xp_sqlagent_enum_jobs 1 , @job_owner , @job_id;

    WHILE EXISTS (SELECT TOP 1 *
                    FROM #xp_results
                    WHERE running = 1) 
        BEGIN

            WAITFOR DELAY @WaitTime;

            -- Information 
            RAISERROR ('JOB IS RUNNING' , 0 , 1) WITH NOWAIT;

            DELETE FROM #xp_results;

            INSERT INTO #xp_results
            EXECUTE DFINAnalytics.dbo.xp_sqlagent_enum_jobs 1 , @job_owner , @job_id;

        END;

    SELECT TOP 1 @JobCompletionStatus = run_status
      FROM msdb.dbo.sysjobhistory
      WHERE job_id = @job_id
        AND step_id = 0
      ORDER BY run_date DESC , run_time DESC;

    IF @JobCompletionStatus = 1
        BEGIN
            PRINT 'The job ran Successful';
        END
    ELSE
        BEGIN
            IF @JobCompletionStatus = 3
                BEGIN
                    exec PrintImmediate 'The job is Cancelled';
                END
            ELSE
                BEGIN
                    RAISERROR ('[ERROR]:%s job is either failed or not in good state. Please check' , 16 , 1 , @job_name) WITH LOG;
                END;;
        END;

    RETURN @JobCompletionStatus;
END;

GO