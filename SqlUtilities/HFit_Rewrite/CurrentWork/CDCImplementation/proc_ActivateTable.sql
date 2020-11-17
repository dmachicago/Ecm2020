
GO

/*
select 'exec proc_ActivateTable ' + table_name + ', 1,1' + char(10) + 'GO' as CMD from information_schema.tables 
where table_name like 'BASE_Hfit_tracker%'
and table_name not like '%[_]DEL%'
and table_name not like '%[_]testdata'
and table_name not like '%[_]CTVerHist'
and table_name not like '%[_]NoNulls'
*/
-- drop procedure proc_ActivateTable
-- exec proc_ActivateTable BASE_HFit_HealthAssesmentUserQuestionGroupResults, 0,1
-- exec proc_ActivateTable BASE_HFit_CoachingUserServiceLevel
-- exec proc_ActivateTable BASE_CMS_MembershipRole
-- exec proc_ActivateTable BASE_CMS_MembershipUser, 1

ALTER PROCEDURE proc_ActivateTable (@BaseTable nvarchar (250) 
                                  , @KeepHistory bit
                                  , @ReactivateIfOn bit = 0) 
AS
BEGIN
    -- declare @BaseTable nvarchar (250) = 'BASE_CMS_UserSettings' ; 
    DECLARE
           @msg nvarchar (max) = ''
         , @MySql nvarchar (max) = ''
         , @ServerTableName nvarchar (254) = ''
         , @isView bit = 0
         , @tblExists bit = 0
         , @JNAME nvarchar (254) = ''
         , @isEnabled AS int = 0;

    SET @JNAME = 'job_proc_' + @BaseTable + '_KenticoCMS_1_ApplyCT';


    SET @isEnabled = (SELECT enabled
                        FROM msdb.dbo.sysjobs
                        WHERE Name = @JNAME) ;
    PRINT @JNAME + ' ENABLED = ' + CAST (@isEnabled AS nvarchar (10)) ;

    IF @isEnabled = 1
   AND @ReactivateIfOn = 1
        BEGIN
            PRINT 'JOB : ' + @JNAME + ' is already activated and you did NOT @ReactivateIfOn to 0, returning.';
            RETURN;
        END;
    IF @isEnabled = 1
   AND @ReactivateIfOn = 0
        BEGIN
            PRINT 'JOB : ' + @JNAME + ' is already activated and @ReactivateIfOn is 0, proceeding.';
        END;
    IF @isEnabled = 0
   AND @ReactivateIfOn = 1
        BEGIN
            PRINT 'JOB : ' + @JNAME + ' is NOT activated and @ReactivateIfOn is 1, activating job';
        END;

    SET @ServerTableName = SUBSTRING (@BaseTable, 6, 9999) ;

    IF NOT EXISTS (SELECT table_name
                     FROM information_schema.tables
                     WHERE table_name = @BaseTable) 
        BEGIN
            PRINT 'ERROR: Table/View not found on server - aborting.';
            RETURN;
        END;

    IF CHARINDEX ('_view_', @BaseTable) > 0
        BEGIN
            SET @isView = 1;
        END;
    ELSE
        BEGIN
            SET @isView = 0;
        END;

    IF @isView = 0
        BEGIN EXEC printImmediate 'Regenerating pull routines on KenticoCMS_1';
            EXEC proc_genPullChangesProc 'KenticoCMS_1', @ServerTableName, 0, 1;
            EXEC printImmediate 'Regenerating pull routines on KenticoCMS_2';
            EXEC proc_genPullChangesProc 'KenticoCMS_2', @ServerTableName, 0, 1;
            EXEC printImmediate 'Regenerating pull routines on KenticoCMS_3';
            EXEC proc_genPullChangesProc 'KenticoCMS_3', @ServerTableName, 0, 1;

            IF @KeepHistory = 0
                BEGIN
                    SET @MySql = 'TRUNCATE TABLE ' + @BaseTable + '_DEL';
                    EXEC (@MySql) ;
                END;

            SET @MySql = 'TRUNCATE TABLE ' + @BaseTable;
            EXEC (@MySql) ;

            SET @msg = 'Synchronizing ' + @ServerTableName + ' from KenticoCMS_1.';
            EXEC PrintImmediate @msg;
            SET @MySql = 'exec proc_BASE_' + @ServerTableName + '_KenticoCMS_1_SYNC null, 1 ';
            EXEC (@MySql) ;

            SET @msg = 'Synchronizing ' + @ServerTableName + ' from KenticoCMS_2.';
            EXEC PrintImmediate @msg;
            SET @MySql = 'exec proc_BASE_' + @ServerTableName + '_KenticoCMS_2_SYNC null, 1 ';
            EXEC (@MySql) ;

            SET @msg = 'Synchronizing ' + @ServerTableName + ' from KenticoCMS_3.';
            EXEC PrintImmediate @msg;
            SET @MySql = 'exec proc_BASE_' + @ServerTableName + '_KenticoCMS_3_SYNC null, 1 ';
            EXEC (@MySql) ;

            --exec proc_BASE_CMS_MembershipUser_KenticoCMS_3_SYNC null, 1 


            SET @msg = 'Combining ' + @JNAME;
            EXEC PrintImmediate @msg;
            EXEC combine_Job_Steps_Into_Single_Job @JNAME;

            SET @msg = 'Enabling ' + @JNAME;
            EXEC PrintImmediate @msg;
            DECLARE
                   @s1 AS nvarchar (500) = '';
            SET @s1 = '@job_name = ''' + @JNAME + ''' , @enabled = 1 ';
            SET @MySql = 'exec msdb..sp_update_job ' + @s1;
            PRINT @MySql;
            EXEC (@MySql) ;

            SET @MySql = REPLACE (@MySql, 'ApplyCT', 'Delete') ;
            SET @MySql = REPLACE (@MySql, '@enabled = 1', '@enabled = 0') ;
            PRINT @MySql;
            EXEC (@MySql) ;
            SET @MySql = REPLACE (@MySql, 'KenticoCMS_1', 'KenticoCMS_2') ;
            SET @MySql = REPLACE (@MySql, '@enabled = 1', '@enabled = 0') ;
            PRINT @MySql;
            EXEC (@MySql) ;
            SET @MySql = REPLACE (@MySql, 'KenticoCMS_2', 'KenticoCMS_3') ;
            SET @MySql = REPLACE (@MySql, '@enabled = 1', '@enabled = 0') ;
            PRINT @MySql;
            EXEC (@MySql) ;

            SET @msg = 'Data verified on: ' + @ServerTableName;
            EXEC PrintImmediate @msg;
        END;
    ELSE
        BEGIN EXEC printImmediate 'Regenerating VIEW pull routines on KenticoCMS_1';
            EXEC proc_RegenBaseTableFromView @ServerTableName;
            
            -- exec proc_view_EDW_HAassessment_KenticoCMS_1

            SET @msg = 'Synchronizing VIEW ' + @ServerTableName + ' from KenticoCMS_1.';
            EXEC PrintImmediate @msg;
            SET @MySql = 'exec proc_' + @ServerTableName + '_KenticoCMS_1 1';
            EXEC (@MySql) ;

            SET @msg = 'Synchronizing VIEW ' + @ServerTableName + ' from KenticoCMS_2.';
            EXEC PrintImmediate @msg;
            SET @MySql = 'exec proc_' + @ServerTableName + '_KenticoCMS_2 1';
            EXEC (@MySql) ;

            SET @msg = 'Synchronizing VIEW ' + @ServerTableName + ' from KenticoCMS_3.';
            EXEC PrintImmediate @msg;
            SET @MySql = 'exec proc_' + @ServerTableName + '_KenticoCMS_3 1';
            EXEC (@MySql) ;

            -- 'job_proc_view_EDW_BioMetrics_KenticoCMS_1'
            SET @JNAME = 'job_proc_' + @ServerTableName + '_KenticoCMS_1';
            EXEC combine_Job_Steps_Into_Single_Job @JNAME;

            DECLARE
                   @s2 AS nvarchar (500) = '';
            SET @s2 = '@job_name = ''' + @JNAME + ''' , @enabled = 1 ';
            SET @MySql = 'exec msdb..sp_update_job ' + @s2;
            PRINT @MySql;
            EXEC (@MySql) ;

            SET @MySql = REPLACE (@MySql, 'ApplyCT', 'Delete') ;
            SET @MySql = REPLACE (@MySql, '@enabled = 1', '@enabled = 0') ;
            PRINT @MySql;
            EXEC (@MySql) ;
            SET @MySql = REPLACE (@MySql, 'KenticoCMS_1', 'KenticoCMS_2') ;
            SET @MySql = REPLACE (@MySql, '@enabled = 1', '@enabled = 0') ;
            PRINT @MySql;
            EXEC (@MySql) ;
            SET @MySql = REPLACE (@MySql, 'KenticoCMS_2', 'KenticoCMS_3') ;
            SET @MySql = REPLACE (@MySql, '@enabled = 1', '@enabled = 0') ;
            PRINT @MySql;
            EXEC (@MySql) ;
            EXEC proc_ChangeJobRunSetting @JobName = @JNAME, @StatusON = 1, @PreviewOnly = 0;

            SET @msg = 'Data verified on: ' + @ServerTableName;
            EXEC PrintImmediate @msg;
        END;
END; 