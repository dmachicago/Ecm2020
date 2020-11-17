param([string]$tgtgroup='dfintest')


workflow WF_Job2 {
    param ([string]$MstrSvr, [string]$MstrDB,[string]$MstrUID,[string]$MstrPW,[string]$DB_UID,[string]$StepRownbr,[string]$JobRownbr,[string]$svr,[string]$JName,[string]$tgtdb,[string]$uid,[string]$pw,[string]$qry  )
    if ($uid){
                setTimer "S" $MstrSvr $MstrDB $MstrUID $MstrPW $DB_UID $StepRownbr $JobRownbr;
                Invoke-Sqlcmd -ServerInstance $svr -Database $tgtdb -Username $uid -Password $pw -Query $qry -QueryTimeout 1200;
                setTimer "E" $MstrSvr $MstrDB $MstrUID $MstrPW $DB_UID $StepRownbr $JobRownbr;
                setLastRunDate $MstrSvr $MstrDB $MstrUID $MstrPW $JobRownbr $svr $JName;
         
    }
    else {
        Sequence
        {
            setTimer "S" $MstrSvr $MstrDB $MstrUID $MstrPW $DB_UID $StepRownbr $JobRownbr;
            $rc = Invoke-Sqlcmd -ServerInstance $svr -Database $tgtdb -Query $qry  -QueryTimeout 1200;
            setTimer "E" $MstrSvr $MstrDB $MstrUID $MstrPW $DB_UID $StepRownbr $JobRownbr;
            setLastRunDate $MstrSvr $MstrDB $MstrUID $MstrPW $JobRownbr $svr $JName;
        }
    }

}

function setTimer($Action, $MstrSvr, $MstrDB, $MstrUID, $MstrPW, $DB_UID, $JobRowNbr, $StepRowNbr ){
    $sql = "exec UTIL_ActiveJobExecutions '$Action', '$JobName', '$StepName', '$svr', '$tgtdb', '$DB_UID', $JobRowNbr, $StepRowNbr ";
    try{
    if ($MstrUID){
            $rc = Invoke-Sqlcmd -ServerInstance $MstrSvr -Database $MstrDB -Username $MstrUID -Password $MstrPW -Query $sql -QueryTimeout 1200;
        }
        else {
            $rc = Invoke-Sqlcmd -ServerInstance $MstrSvr -Database $MstrDB -Query $sql -QueryTimeout 1200;
        }
    }
    catch{
        write-host "*** ERROR 01: $_" ;
        $e = $_.Exception
        $msg = $e.Message
        while ($e.InnerException) {
          $e = $e.InnerException
          $msg += "`n" + $e.Message
        }
        $msg
    }
}
function setLastRunDate($MstrSvr, $MstrDB, $MstrUID, $MstrPW, $RowNbr, $SvrName, $JobName){
    
    $sql = "exec UTIL_ActiveJobSetLastRunDate $RowNbr ";
    
    try{
        if ($MstrUID){
            $rc = Invoke-Sqlcmd -ServerInstance $MstrSvr -Database $MstrDB -Username $MstrUID -Password $MstrPW -Query $sql -QueryTimeout 1200;
        }
        else {
            $rc = Invoke-Sqlcmd -ServerInstance $MstrSvr -Database $MstrDB -Query $sql -QueryTimeout 1200;
        }

        $sql = "exec UTIL_ActiveJobScheduleSetLastRunDate '$SvrName', '$JobName' ";
        
        if ($MstrUID){
            $rc = Invoke-Sqlcmd -ServerInstance $MstrSvr -Database $MstrDB -Username $MstrUID -Password $MstrPW -Query $sql -QueryTimeout 1200;
        }
        else {
            $rc = Invoke-Sqlcmd -ServerInstance $MstrSvr -Database $MstrDB -Query $sql -QueryTimeout 1200;
        }
    }
    catch{
        write-host "*** ERROR 01: $_" ;
        $e = $_.Exception
        $msg = $e.Message
        while ($e.InnerException) {
          $e = $e.InnerException
          $msg += "`n" + $e.Message
        }
        $msg
    }
}
clear

Install-Module -Name Az -AllowClobber
$starttime = date;
write-host "Processing Group: $tgtgroup";
$MstrSvr = 'ALIEN15';
$MstrDB = 'DFINAnalytics';
$MstrUID = 'sa';
$MstrPW = 'Junebug1';

$date = Get-Date -format "yyyyMMdd"
$dt = Get-Date -Format g
$fqn = $ScriptPath + "\ERRORS\_JobRunErrors.txt";

$ErrFileName = $fqn;

#recordError "INIT-INSTANCE" "INIT-DB" "RunAllJobs" "Initialize the error file" $fqn ;

#if (Test-Path $ErrFileName) 
#{
#  Remove-Item $ErrFileName
#}

$ErrorActionPreference="SilentlyContinue"
Stop-Transcript | out-null
$ErrorActionPreference = "Continue"
Start-Transcript -path $ErrFileName -append
# Do some stuff

$ScriptPath = Split-Path $MyInvocation.InvocationName 
Write-Host  "EXECUTING: $ScriptPath ";
#D:\dev\SQL\DFINAnalytics\PowerShell\JobsDFIN\modules
$ScriptPath += "\modules\JOB_StdFunctions.ps1"
Import-Module "$ScriptPath" ;

clear;   
$env:AzureRmContextAutoSave="true" ;
$JobName = $MyInvocation.MyCommand.Definition;
showRunning $JobName ;

$SqlConnection = New-Object System.Data.SqlClient.SqlConnection
$SqlConnection.ConnectionString = “Server=Alien15;Integrated Security=true;Initial Catalog=DFINAnalytics”

$Parameters= @{
  tgtgroup = "$tgtgroup"
}

foreach($p in $Parameters.Keys){
 		write-host "Parameters $Parameters";
        write-host "p = $p";
 	}


#$ActiveServers = Exec-Sproc -Conn $SqlConnection -Sproc "DFINAnalytics.dbo.UTIL_getActiveDatabases"  -Parameters $Parameters ; 
$ActiveServers = Exec-Sproc -Conn $SqlConnection -Sproc "DFINAnalytics.dbo.UTIL_getActiveSvrJobs"  -Parameters $Parameters ; 

$RowsOfJobs = Exec-Sproc -Conn $SqlConnection -Sproc "DFINAnalytics.dbo.UTIL_getActiveSvrJobsDelimited"  -Parameters $Parameters ; 
$RowsOfJobs.count;
$DelimitedJobs = Out-String -InputObject $RowsOfJobs ;

#$Jobs = Exec-Sproc -Conn $SqlConnection -Sproc "DFINAnalytics.dbo.UTIL_ActiveJobFetch" 

$icnt = 1 ;
$SvrCnt = $ActiveServers.count;

foreach ($Server in $ActiveServers)
{ 
    $runid = getRunID;

    $GroupName = $($Server['GroupName']);
    $SvrName = $($Server['SvrName']);
    $DBName = $($Server['DBName']);
    $JobName = $($Server['JobName']);
    $UserID = $($Server['UserID']);
    $pwd =  $($Server['pwd']);
    $isAzure =  $($Server['isAzure']);
    $DBUID = $($Server['DBUID']);
    $JobUID = $($Server['JobUID']);
    $ScheduleUnit = $($Server['ScheduleUnit']);
    $ScheduleVal = $($Server['ScheduleVal']);
    $LastRunDate = $($Server['LastRunDate']);
    $NextRunDate = $($Server['NextRunDate']);
    $StepName = $($Server['StepName']);
    $StepSQL = $($Server['StepSQL']);
    $RunIdReq = $($Server['RunIdReq']);
    $AzureOK = $($Server['AzureOK']);
    $JobRowNbr = $($Server['JobRowNbr']);
    $StepRowNbr = $($Server['StepRowNbr']);
	  
    $svr = $SvrName;
    $tgtdb = $DBName ;
    $uid = $UserID;
    $pw = $pwd;
    $isAzureDB = $isAzure;
    $DB_UID  = $DBUID;
    if ($DB_UID){
        $DB_UID = $DB_UID.ToString();
        $DB_UID ;
    }

    if ($svr) {
            #write-host ("--------------------------------------------------------");
            #write-host ("$svr @ $tgtdb @ $uid @ $pw");
            #write-host ("--------------------------------------------------------");
            
                $RunProc = 1 ;
                $AzureCompatibleSP  = $AzureOK ;                
                

                if($StepSQL -like '*@RunID*') {
                      Write-Host '@RunID found'
                      #$StepSQL.Replace("\@RunID", $runid);
                      $i = $StepSQL.IndexOf("@RunID") ;
                      $j = $StepSQL.IndexOf(" ", $i + 1) ;
                      $s1 = $StepSQL.Substring(0,$i-1) ;
                      $s2 = $StepSQL.Substring($j) ;
                      $s2.Trim();
                      $s3 = $s1 + " " + $runid + "," +  $s2 ;
                      $StepSQL = $s3 ;
                      $RunIdReq = 'N';
                } 

                $rightnow = Get-Date ;

                write-host ("Job: $JobName is set to run every $ScheduleVal $ScheduleUnit and Last Run Date was: '$LastRunDate'  and Next Run Date is : '$NextRunDate'" );
                write-host (">>PROCESSING : $icnt of $SvrCnt " );
                $icnt += 1 ;

                if ($RunIdReq -eq 'N'){
                    if ($isAzureDB -eq 'Y' -and $AzureCompatibleSP -eq 'Y'){
                        $qry = "EXEC $StepSQL";
                        $RunProc = 1 ;
                    }
                    if ($isAzureDB -eq 'Y' -and $AzureCompatibleSP -eq 'N'){
                        write-host "The server $svr is Azure the JobName: $JobName and Step $StepName IS NOT Azure Compatible. "  -ForegroundColor Red;;
                        $RunProc = 0 ;
                        write-host ("") -ForegroundColor White;
                    }
                    if ($isAzureDB -eq 'N'){
                        $qry = "EXEC $StepSQL";
                        $RunProc = 1 ;
                    }
                }
                else {
                    if ($isAzureDB -eq 'Y' -and $AzureCompatibleSP -eq 'Y'){
                        $qry = "EXEC $StepSQL $runid";
                        $RunProc = 1 ;
                    }
                    if ($isAzureDB -eq 'Y' -and $AzureCompatibleSP -eq 'N'){
                        write-host "The server $svr is Azure the JobName: $JobName and Step $StepName IS NOT Azure Compatible. "  -ForegroundColor Red;;
                        $RunProc = 0 ;
                        write-host ("") -ForegroundColor White;
                    }
                    if ($isAzureDB -eq 'N'){
                        $qry = "EXEC $StepSQL $runid";
                        $RunProc = 1 ;
                    }

                }
                
                $setBeforeExecution = 0 ;

                    try{                        
                            write-host ("EXECUTING $JobName, STEP $StepName ON $svr IN db $tgtdb");
                            if ($uid){
                                if ($setBeforeExecution -eq 1){
                                    setTimer "S" $MstrSvr $MstrDB $MstrUID $MstrPW $DB_UID $StepRownbr $JobRownbr;
                                }

                                if ($setBeforeExecution -eq 1){
                                    setTimer "S" $MstrSvr $MstrDB $MstrUID $MstrPW $DB_UID $StepRownbr $JobRownbr;
                                }

                                #$rc = Invoke-Sqlcmd -ServerInstance $SvrName -Database $DBName -Username $uid -Password $pw -Query $qry -QueryTimeout 1200;
                                WF_Job2  -MstrSvr $MstrSvr -MstrDB $MstrDB -MstrUID $MstrUID -MstrPW $MstrPW -DB_UID $DB_UID -StepRownbr $StepRownbr  -JobRownbr $JobRownbr -svr $svr  -JName $JobName -tgtdb $tgtdb -uid $uid -pw $pw -qry $qry;

                                if ($setBeforeExecution -eq 1){
                                    setTimer "E" $MstrSvr $MstrDB $MstrUID $MstrPW $DB_UID $StepRownbr $JobRownbr;
                                    setLastRunDate $MstrSvr $MstrDB $MstrUID $MstrPW $JobRownbr, $svr,$JobName;
                                }

                            }
                            else {
                                if ($setBeforeExecution -eq 1){
                                    setTimer "S" $MstrSvr $MstrDB $MstrUID $MstrPW $DB_UID $StepRownbr $JobRownbr;
                                }
                        
                                #$rc = Invoke-Sqlcmd -ServerInstance $svr -Database $tgtdb -Query $qry  -QueryTimeout 1200;
                                WF_Job2  -MstrSvr $MstrSvr -MstrDB $MstrDB -MstrUID $MstrUID -MstrPW $MstrPW -DB_UID $DB_UID -StepRownbr $StepRownbr  -JobRownbr $JobRownbr -svr $svr  -JName $JobName -tgtdb $tgtdb -uid $uid -pw $pw -qry $qry;

                                if ($setBeforeExecution -eq 1){
                                    setTimer "E" $MstrSvr $MstrDB $MstrUID $MstrPW $DB_UID $StepRownbr $JobRownbr;
                                    setLastRunDate $MstrSvr $MstrDB $MstrUID $MstrPW $JobRownbr, $svr,$JobName;
                                }
                            }
                            write-host ("Completed... $JobName, STEP $StepName ON $svr IN db $tgtdb");
                        
                        
                    } 
                    catch {
                        $string_err = $_ | Out-String
                        write-host $string_err
                    }
                
                write-host ("---------------------------------------------------------------------------------------------");
        
            
    }
}
    Stop-Transcript | out-null

    $ReviewErrors = 0 ;
    if ($ReviewErrors -eq 1) {
        if (Test-Path $ErrFileName) {
          Start-Process notepad.exe $ErrFileName
        }
    }
    else {
        write-host "*****************************************"
        write-host "**** ERROR REVIEW OFF *******************"
        write-host "*****************************************"
    }

    $stoptime = date;
    #$DURATION = $starttime - $stoptime
    $DURATION = $stoptime - $starttime 
    $t = $DURATION.TotalMinutes
    write-host "*****************************************"
    write-host "**** Started: $starttime  **************"
    write-host "**** Ended  : $stoptime   **************"
    write-host "**** Tot Min: $t   **************"
    write-host "*****************************************"
    