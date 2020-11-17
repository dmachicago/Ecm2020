
GO
PRINT 'Executing proc_isJobEnvironmentReady.sql';
GO
IF EXISTS (SELECT name
             FROM sys.procedures
             WHERE name = 'proc_isJobEnvironmentReady') 
    BEGIN
        DROP PROCEDURE proc_isJobEnvironmentReady;
    END;
GO

-- exec proc_isJobEnvironmentReady 'job_proc_BASE_HFit_HealthAssesmentUserAnswers_KenticoCMS_1_ApplyCT'
CREATE PROCEDURE proc_isJobEnvironmentReady (@JOB_NAME nvarchar (250) , 
                                             @StartJobNow bit = 0) 
AS
BEGIN
    IF (SELECT DATABASEPROPERTYEX ('KenticoCMS_1' , 'Status')) != 'ONLINE'
        BEGIN
            PRINT 'Database KenticoCMS_1 is NOT online, aborting...';
            RETURN 0;
        END;
    IF (SELECT DATABASEPROPERTYEX ('KenticoCMS_2' , 'Status')) != 'ONLINE'
        BEGIN
            PRINT 'Database KenticoCMS_2 is NOT online, aborting...';
            RETURN 0;
        END;
    IF (SELECT DATABASEPROPERTYEX ('KenticoCMS_3' , 'Status')) != 'ONLINE'
        BEGIN
            PRINT 'Database KenticoCMS_3 is NOT online, aborting...';
            RETURN 0;
        END;

    IF NOT EXISTS (SELECT 1
                     FROM
                          msdb.dbo.sysjobs_view AS job
                          INNER JOIN msdb.dbo.sysjobactivity AS activity
                          ON job.job_id = activity.job_id
                     WHERE activity.run_Requested_date IS NOT NULL
                       AND activity.stop_execution_date IS NULL
                       AND job.name = @JOB_NAME) 
        BEGIN
            IF @StartJobNow = 0
                BEGIN
                    PRINT 'OK to start job ''' + @JOB_NAME + '''';
                END;
            ELSE
                BEGIN
                    IF @StartJobNow = 1
                        BEGIN
                            PRINT 'Starting job ''' + @JOB_NAME + '''';
                            EXEC msdb.dbo.sp_start_job @JOB_NAME;
                        END;
                END;
            RETURN 0;
        END;
    ELSE
        BEGIN
            PRINT 'Job ''' + @JOB_NAME + ''' is already started ';
            RETURN 0;
        END;
END;

GO
PRINT 'Executing proc_isJobEnvironmentReady.sql';
GO