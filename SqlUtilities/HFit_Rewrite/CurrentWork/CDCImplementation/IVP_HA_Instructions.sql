

go
print '********************************************************************************' ;
print 'The IVP has completed:' ;
print '    1 - Please check for errors' ;
print '    2 - Contact Dale Miller or Scott Montgomery for any assistance.' ;
print '    3 - Execute proc_HA_MasterUpdate if needed.' ;
print '********************************************************************************' ;
    DECLARE
      @iRecs AS bigint = 0 , 
      @Msg AS nvarchar (max) = '';


    exec @iRecs = proc_QuickRowCount BASE_MART_EDW_HealthAssesment ;
    
    if @iRecs = 0 
    begin
	   print '***** WARNING ****** WARNING ****** WARNING ****** WARNING ****** WARNING ****** WARNING ******' ;
	   print 'BASE_MART_EDW_HealthAssesment has no rows, the procedure proc_HA_MasterUpdate should be executed or wait for the job to run.';	   
    end

go