
GO

-- drop procedure proc_SyncData
-- exec proc_SyncData hfit_PPTEligibility
ALTER PROCEDURE proc_SyncData (@BaseTable nvarchar (250)) 
AS
BEGIN

    DECLARE
          @msg nvarchar (max) = '' , 
          @MySql nvarchar (max) = '',
		@BaseTableName nvarchar(254) = '',
		@isView bit = 0,
		@tblExists bit = 0 ;


    set @BaseTableName  = substring(@BaseTable,6,9999) ;

    if not exists (select table_name from KenticoCMS_1.information_schema.tables where table_name = @BaseTableName)
    begin 
	   
    end 


    EXEC printImmediate 'Regenerating pull routines on KenticoCMS_1';
    EXEC proc_genPullChangesProc 'KenticoCMS_1' , @BaseTableName , 0 , 1;

    EXEC printImmediate 'Regenerating pull routines on KenticoCMS_2';
    EXEC proc_genPullChangesProc 'KenticoCMS_2' , @BaseTableName , 0 , 1;
    
    EXEC printImmediate 'Regenerating pull routines on KenticoCMS_3';
    EXEC proc_genPullChangesProc 'KenticoCMS_3' , @BaseTableName , 0 , 1;

    SET @msg = 'Synchronizing ' + @BaseTableName + ' from KenticoCMS_1.';
    EXEC PrintImmediate @msg;
    SET @MySql = 'exec proc_BASE_' + @BaseTableName + '_KenticoCMS_1_SYNC ';
    EXEC (@MySql) ;

    SET @msg = 'Synchronizing ' + @BaseTableName + ' from KenticoCMS_1.';
    EXEC PrintImmediate @msg;
    SET @MySql = 'exec proc_BASE_' + @BaseTableName + '_KenticoCMS_2_SYNC ';
    EXEC (@MySql) ;

    SET @msg = 'Synchronizing ' + @BaseTableName + ' from KenticoCMS_1.';
    EXEC PrintImmediate @msg;
    SET @MySql = 'exec proc_BASE_' + @BaseTableName + '_KenticoCMS_3_SYNC ';
    EXEC (@MySql) ;

    declare @JNAME nvarchar(254) = 'job_proc_' + @BaseTableName + '_KenticoCMS_1' ;
    exec combine_Job_Steps_Into_Single_Job 'job_proc_view_EDW_BioMetrics_KenticoCMS_1'

    SET @msg = 'Data verified on: ' + @BaseTableName;
    EXEC PrintImmediate @msg;

END; 