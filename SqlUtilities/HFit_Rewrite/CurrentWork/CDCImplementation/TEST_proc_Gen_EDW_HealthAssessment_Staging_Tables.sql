declare @ST0 as datetime = getdate();
declare @NbrOfDetectedChanges  as int = 0 ;
declare @ms as float = 0 
declare @secs as float = 0 
declare @mins as float = 0 
declare @hrs as float = 0 

EXEC @NbrOfDetectedChanges = proc_EDW_Populate_Staging_Tables 0;
set @ms = datediff(MILLISECOND, @st0, getdate()) ;
set @hrs = @ms / 1000 / 60 / 60 ;
print ('HRS @ FIRST STEP: ' + cast(@hrs as nvarchar(50))) ;
print ('------------------------------------------------------------------------------------------');
--Time in Hours to load TEMP TABLE: 1.89
--HRS @ 0: 2.05163

declare @ST2 as datetime = getdate();

EXEC @NbrOfDetectedChanges = proc_EDW_Populate_Staging_Tables 2;
set @ms = datediff(MILLISECOND, @ST2, getdate()) ;
set @hrs = @ms / 1000 / 60 / 60 ;
print ('HRS @ SECOND STEP: ' + cast(@hrs as nvarchar(50))) ;
print ('------------------------------------------------------------------------------------------');
--Time in Hours to load TEMP TABLE: 0.91
--HRS @ 2: 1.03678


declare @ST1 as datetime = getdate();
EXEC @NbrOfDetectedChanges = proc_EDW_Populate_Staging_Tables 1;
set @ms = datediff(MILLISECOND, @ST1, getdate()) ;
set @hrs = @ms / 1000 / 60 / 60 ;
print ('HRS @ THIRD STEP: ' + cast(@hrs as nvarchar(50))) ;
print ('------------------------------------------------------------------------------------------');
--Time in Hours to load TEMP TABLE: 3.44
--HRS @ 1: 3.49629


/*
TempData Started: 
Jul 21 2015  7:04PM
TIME TO BUILD STAGING TABLE DATA
Elapsed Seconds: 410.266
Elapsed Minutes: 6.83777
Elapsed Hour: 0.113963
TempData Loaded: 
Jul 21 2015  7:11PM
Seconds: 410
Temp HA Data Loaded: 
Jul 21 2015  9:04PM
HA Data Load Seconds: 6796
##HealthAssessmentData rows: 7615651
HA Data Loaded: 
Jul 21 2015  9:04PM
Total Records Loaded : 7615651
Time in Hours to load TEMP TABLE: 1.89
TIME TO COMPLETE proc_EDW_Populate_Staging_Tables:
Elapsed Minutes: 1201.09
Elapsed Hour: 20.0182
TOTAL ROWS: 7615651
Process Started:
Jul 21 2015  7:04PM
Process Ended:
Jul 21 2015  9:04PM
HRS @ 0: 2.05163
TempData Started: 
Jul 21 2015  9:04PM
TIME TO BUILD STAGING TABLE DATA
Elapsed Seconds: 458.196
Elapsed Minutes: 7.6366
Elapsed Hour: 0.127277
TempData Loaded: 
Jul 21 2015  9:12PM
Seconds: 458
Temp HA Data Loaded: 
Jul 21 2015 10:06PM
HA Data Load Seconds: 3274
##HealthAssessmentData rows: 509156
HA Data Loaded: 
Jul 21 2015 10:06PM
 
Time in Hours to load TEMP TABLE: 0.91
TIME TO COMPLETE proc_EDW_Populate_Staging_Tables:
Elapsed Minutes: 622.068
Elapsed Hour: 10.3678
 
Process Started:
Jul 21 2015  9:04PM
Process Ended:
Jul 21 2015 10:06PM
The 'proc_EDW_Populate_Staging_Tables' procedure attempted to return a status of NULL, which is not allowed. A status of 0 will be returned instead.
HRS @ 2: 1.03678
TempData Started: 
Jul 21 2015 10:06PM
TIME TO BUILD STAGING TABLE DATA
Elapsed Seconds: 185.416
Elapsed Minutes: 3.09027
Elapsed Hour: 0.0515044
TempData Loaded: 
Jul 21 2015 10:09PM
Seconds: 185
RELOAD ALL SELECTED - 7615651 records moved into FACT_MART_EDW_HealthAssesment in3.44 hours.
HA Data Loaded: 
Jul 22 2015  1:36AM
 
Time in Hours to load TEMP TABLE: 3.44
TIME TO COMPLETE proc_EDW_Populate_Staging_Tables:
Elapsed Minutes: 2097.75
Elapsed Hour: 34.9626
 
Process Started:
Jul 21 2015 10:06PM
Process Ended:
Jul 22 2015  1:36AM
The 'proc_EDW_Populate_Staging_Tables' procedure attempted to return a status of NULL, which is not allowed. A status of 0 will be returned instead.
HRS @ 1: 3.49629

*/
