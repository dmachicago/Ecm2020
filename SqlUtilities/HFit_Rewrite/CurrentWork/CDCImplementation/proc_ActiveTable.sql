
GO

-- drop procedure proc_ActivateTable
-- exec proc_ActivateTable base_hfit_PPTEligibility
-- exec proc_ActivateTable BASE_HFit_CoachingUserServiceLevel
-- exec proc_ActivateTable BASE_CMS_MembershipRole
-- exec proc_ActivateTable BASE_CMS_MembershipUser

alter  PROCEDURE proc_ActivateTable (@BaseTable nvarchar (250), @KeepHistory bit  ) 
AS
BEGIN
    -- declare @BaseTable nvarchar (250) = 'BASE_HFit_RewardTriggerTobaccoParameter' ; 
    DECLARE
          @msg nvarchar (max) = '' , 
          @MySql nvarchar (max) = '' , 
          @ServerTableName nvarchar (254) = '' , 
          @isView bit = 0 , 
          @tblExists bit = 0,
          @JNAME nvarchar (254) = '' ;


    SET @ServerTableName = SUBSTRING (@BaseTable , 6 , 9999) ;

    IF NOT EXISTS (SELECT table_name
                     FROM information_schema.tables
                     WHERE table_name = @BaseTable) 
        BEGIN
            PRINT 'ERROR: Table/View not found on server - aborting.';
            RETURN;
        END;

    if charindex('_view_',@BaseTable) > 0 
        BEGIN
            SET @isView = 1;
        END;
    else 
        BEGIN
            SET @isView = 0;
        END;

    IF @isView = 0
        BEGIN
		  EXEC printImmediate 'Regenerating pull routines on KenticoCMS_1';
            EXEC proc_genPullChangesProc 'KenticoCMS_1' , @ServerTableName , 0 , 1;
            EXEC printImmediate 'Regenerating pull routines on KenticoCMS_2';
            EXEC proc_genPullChangesProc 'KenticoCMS_2' , @ServerTableName , 0 , 1;
            EXEC printImmediate 'Regenerating pull routines on KenticoCMS_3';
            EXEC proc_genPullChangesProc 'KenticoCMS_3' , @ServerTableName , 0 , 1;

		  if @KeepHistory = 0 
		  begin
			 Set @MySql = 'TRUNCATE TABLE ' + @BaseTable + '_DEL' ;
			 EXEC (@MySql) ;
		  end

		  Set @MySql = 'TRUNCATE TABLE ' + @BaseTable  ;
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

		  set @JNAME = 'job_proc_' + @BaseTable + '_KenticoCMS_1_ApplyCT';
		  print @JNAME ;
		  SET @msg = 'Combining ' + @JNAME ;
            EXEC PrintImmediate @msg;
            EXEC combine_Job_Steps_Into_Single_Job @JNAME;

		  SET @msg = 'Enabling ' + @JNAME ;
            EXEC PrintImmediate @msg;
		  declare @s1 as nvarchar(500) = '' ;
		  set @s1 ='@job_name = ''' + @JNAME + ''' @enabled = 1 ' ;
		  EXEC msdb..sp_update_job @s1 ;

            SET @msg = 'Data verified on: ' + @ServerTableName;
            EXEC PrintImmediate @msg;
        END;
    ELSE
	   BEGIN 
		  EXEC printImmediate 'Regenerating pull routines on KenticoCMS_1';
            EXEC proc_RegenBaseTableFromView @ServerTableName ;
            
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
            set @JNAME = 'job_proc_' + @ServerTableName + '_KenticoCMS_1';
            EXEC combine_Job_Steps_Into_Single_Job @JNAME;

		  declare @s2 as nvarchar(500) = '' ;
		  set @s2 ='@job_name = ''' + @JNAME + ''' @enabled = 1 ' ;
		  EXEC msdb..sp_update_job @s1 ;

		  exec proc_ChangeJobRunSetting @JobName = @JNAME , @StatusON = 1, @PreviewOnly = 0

            SET @msg = 'Data verified on: ' + @ServerTableName;
            EXEC PrintImmediate @msg;
        END;
END; 