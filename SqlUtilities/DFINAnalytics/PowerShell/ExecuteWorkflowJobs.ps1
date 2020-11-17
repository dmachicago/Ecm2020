param([string]$tgtgroup='dfintest')

#param([string]$tgtgroup='dfintest')
#$tgtgroup=$args[0]

function setTimer($Action, $MstrSvr, $MstrDB, $MstrUID, $MstrPW, $DB_UID, $JobRowNbr, $StepRowNbr ){
    $sql = "exec UTIL_ActiveJobExecutions '$Action', '$JobName', '$StepName', '$svr', '$db', '$DB_UID', $JobRowNbr, $StepRowNbr ";
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
function setLastRunDate($MstrSvr, $MstrDB, $MstrUID, $MstrPW, $RowNbr){
    $sql = "exec UTIL_ActiveJobSetLastRunDate $RowNbr ";
    $sql
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
clear

Install-Module -Name Az -AllowClobber

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
$ScriptPath += "\JobsDFIN\modules\JOB_StdFunctions.ps1"
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

$ActiveServers = Exec-Sproc -Conn $SqlConnection -Sproc "DFINAnalytics.dbo.UTIL_getActiveDatabases"  -Parameters $Parameters ; 

$Jobs = Exec-Sproc -Conn $SqlConnection -Sproc "DFINAnalytics.dbo.UTIL_ActiveJobFetch" 


workflow pbatch {
    param ([string[]] $ActiveServers, [string[]] $JOBS)

    $MstrSvr = 'ALIEN15';
    $MstrDB = 'DFINAnalytics';
    $MstrUID = 'sa';
    $MstrPW = 'Junebug1';

    $i = 0 ;
    $j = 0 ;

    $JOBS;
    
    while ($i -lt $ActiveServers.Count){
        $s = $ActiveServers[$i] ;
        $items = $s.split(':');
        if ($items.count -ge 2){
            $key = $items[0].trim();
            $val = $items[1].trim();
            $ProcessNow = 0 ;
            if ($key -eq 'SvrName'){
                $svr = $val;
            }
            elseif ($key -eq 'DBName'){
                $db = $val;
            }
            elseif ($key -eq 'UserID'){
                $uid = $val;
            }
            elseif ($key -eq 'pwd'){
                $pw = $val;
            }
            elseif ($key -eq 'isAzure'){
                $isAzureDB = $val;
            }
            elseif ($key -eq 'UID'){
                $DB_UID = $val;
                $ProcessNow = 1 ;
                "*********** PROCESS NOW $svr.$db ***********";
            }
            else {
                $ProcessNow = 1 ;
            }
            $RunIdReq = '';
            if ($ProcessNow -eq 1){
                while ($j -lt $JOBS.Count){
                    $s = $JOBS[$j] ;
                    $items = $s.split(':');
                    
                    if ($items.count -ge 2) {
                            $key = $items[0].trim();
                            $val = $items[1].trim();
                            $ExecuteNow = 0 ;

                            if ($key -eq 'JobName'){
                                $JName = $val;
                            }
                            elseif ($key -eq 'JobDisabled'){
                                $JobDisabled  = $val;
                            }
                            elseif ($key -eq 'ScheduleUnit'){
                                $ScheduleUnit  = $val;
                            }
                            elseif ($key -eq 'ScheduleVal'){
                                $ScheduleVal  = $val;
                            }
                            elseif ($key -eq 'LastRunDate'){
                                if ($items.count -eq 4){
                                    $LastRunDate = $items[1] + ':' + $ITEMS[2] + ':' + $ITEMS[3] ;
                                }
                                else {
                                    $LastRunDate   = $val;
                                }
                                $LastRunDate = [datetime]$LastRunDate ;
                            }
                            elseif ($key -eq 'LastRunDate'){
                                if ($items.count -eq 4){
                                    $LastRunDate = $items[1] + ':' + $ITEMS[2] + ':' + $ITEMS[3] ;
                                }
                                else {
                                    $LastRunDate   = $val;
                                }
                                $LastRunDate = [datetime]$LastRunDate ;
                            }
                            elseif ($key -eq 'NextRunDate'){
                                $NextRunDate = $val;
                                if ($items.count -eq 4){
                                    $NextRunDate = $items[1] + ':' + $ITEMS[2] + ':' + $ITEMS[3] ;
                                }
                                else {
                                    $NextRunDate   = $val;
                                }
                                $NextRunDate = [datetime]$NextRunDate ;
                            }
                            elseif ($key -eq 'StepName'){
                                $StepName = $val;
                            }
                            elseif ($key -eq 'StepSQL'){
                                $StepSQL = $val;
                            }
                            elseif ($key -eq 'StepDisabled'){
                                $StepDisabled = $val;
                            }
                            elseif ($key -eq 'RunIdReq'){
                                $RunIdReq = $val;
                            }
                            elseif ($key -eq 'AzureOK'){
                                $AzureOK = $val;
                                $AzureCompatibleSP = $val;
                            }
                            elseif ($key -eq 'StepRownbr'){
                                $StepRownbr = $val;
                            }
                            elseif ($key -eq 'JobRownbr'){
                                $JobRownbr = $val;
                                $ExecuteNow = 1 ;
                            }
                            else {
                                $ExecuteNow = 0 ;
                            }

                            if ($ExecuteNow -eq 1){
                                "--------------  EXECUTE NOW: $JName @ $StepSQL -------------";
                                if($StepSQL -like '*@RunID*') {
                                      "RunID found";
                                      #$StepSQL.Replace("\@RunID", $runid);
                                      $i = $StepSQL.IndexOf("@RunID") ;
                                      $j = $StepSQL.IndexOf(" ", $i + 1) ;
                                      $s1 = $StepSQL.Substring(0,$i-1) ;
                                      $s2 = $StepSQL.Substring($j) ;
                                      #$s2.Trim();
                                      $s3 = $s1 + " " + $runid + "," +  $s2 ;
                                      $StepSQL = $s3 ;
                                      $RunIdReq = 'N';
                                }
                                $rightnow = Get-Date ;
                                $DURATION = $rightnow - $LastRunDate;
                                $SecsSinceLastRun = $DURATION.TotalSeconds;
                                $SecsSinceLastRun

                                $SecondsToWait = 0 ;
                                if ($ScheduleUnit -eq 'min'){
                                    $ts = New-TimeSpan -Minutes $ScheduleVal
                                    $NextRunDate = $LastRunDate + $ts
                                }
                                elseif ($ScheduleUnit -eq 'day'){
                                    $ts = New-TimeSpan -Days $ScheduleVal
                                    $NextRunDate = $LastRunDate + $ts
                                }
                                else {
                                    $ts = New-TimeSpan -Minutes $ScheduleVal
                                    $NextRunDate = $LastRunDate + $ts
                                }
                                
                                $RunNow = 0 ;
                                "Job: $JName is set to run every $ScheduleVal $ScheduleUnit and Last Run Date was: '$LastRunDate'  and Next Run Date is : '$NextRunDate'" ;

                                if ($rightnow -gt $NextRunDate){
                                    "Job: $JName is DUE to run NOW..";
                                    $RunNow = 1 ;
                                    "";
                                }
                                else {
                                    "Job: $JName is NOT DUE to run NOW..";
                                    $RunNow = 0 ;
                                    "";
                                }

                                if ($RunIdReq -eq 'N'){
                                    if ($isAzureDB -eq 'Y' -and $AzureCompatibleSP -eq 'Y'){
                                        $qry = "EXEC $StepSQL";
                                        $RunProc = 1 ;
                                    }
                                    if ($isAzureDB -eq 'Y' -and $AzureCompatibleSP -eq 'N'){
                                        "The server $svr is Azure the JobName: $JName and Step $StepName IS NOT Azure Compatible. ";
                                        $RunProc = 0 ;
                                        "";
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
                                        "The server $svr is Azure the JobName: $JName and Step $StepName IS NOT Azure Compatible. "  
                                        $RunProc = 0 ;
                                        "";
                                    }
                                    if ($isAzureDB -eq 'N'){
                                        $qry = "EXEC $StepSQL $runid";
                                        $RunProc = 1 ;
                                    }

                                }
                
                                if ($JobDisabled -eq 'N') {
                                    try{
                                        if ($StepDisabled -eq 'N' -and $RunProc -eq 1 -and $RunNow -eq 1 ){
                                            "EXECUTING $JName, STEP $StepName ON $svr IN db $DB";
                                            if ($uid){
                                                setTimer "S" $MstrSvr $MstrDB $MstrUID $MstrPW $DB_UID $StepRownbr $JobRownbr;

                                                $rc = Invoke-Sqlcmd -ServerInstance $svr -Database $db -Username $uid -Password $pw -Query $qry -QueryTimeout 1200;

                                                setTimer "E" $MstrSvr $MstrDB $MstrUID $MstrPW $DB_UID $StepRownbr $JobRownbr;
                                                setLastRunDate $MstrSvr $MstrDB $MstrUID $MstrPW $JobRownbr;

                                            }
                                            else {
                                                setTimer "S" $MstrSvr $MstrDB $MstrUID $MstrPW $DB_UID $StepRownbr $JobRownbr;
                        
                                                $rc = Invoke-Sqlcmd -ServerInstance $svr -Database $db -Query $qry  -QueryTimeout 1200;

                                                setTimer "E" $MstrSvr $MstrDB $MstrUID $MstrPW $DB_UID $StepRownbr $JobRownbr;
                                                setLastRunDate $MstrSvr $MstrDB $MstrUID $MstrPW $JobRownbr;
                                            }
                                            "Completed... $JName, STEP $StepName ON $svr IN db $DB";
                                        }
                                        else {
                                            if ($RunNow -eq 0){
                                                "NOTICE: Job: $JName is not due to execute now, but will run on $NextRunDate.";
                                            }
                                            else {
                                                "NOTICE: The server $svr is Azure the JobName: $JName and Step $StepName IS NOT Azure Compatible. ";
                                            }
                                        }
                                    } 
                                    catch {
                                        $string_err = $_ | Out-String
                                        "ERROR @ $string_err";
                                    }
                                }
                                "---------------------------------------------------------------------------------------------"; 
                            }
                    }
                    $j += 1 ;
                }
            }

        }
        $i += 1;
    }

    while ($i -lt $StrSVRS.Count){

        

        $runid = getRunID;
        $svr = $ActiveServers[$i];
        $svr 
        $svr = $ActiveServers['SvrName'];
        
        $db = $ActiveServers[$i+1];
        $db
        $db = $ActiveServers['DBName'];
        $uid = $ActiveServers['UserID'];
        $pw = $ActiveServers['pwd'];
        $isAzureDB = $ActiveServers['isAzure'];
        $DB_UID  = $ActiveServers['UID'];
        if ($DB_UID){
            $DB_UID = $DB_UID.ToString();
            $DB_UID ;
        }

        #check schedule
        #execute job if it is time
    }
}
$i = 0 ; 
$StrSVRS = Out-String -InputObject $ActiveServers -Width 1000 -Stream
$StrJOBS = Out-String -InputObject $Jobs -Width 1000  -Stream


$StrSVRS.Count;
$StrJOBS.Count;


$StrSVRS = $StrSVRS | ? {$_}      ;
$StrJOBS = $StrJOBS | ? {$_}      ;

$StrSVRS.Count;
$StrJOBS.Count;

pbatch -ActiveServers $StrSVRS -JOBS $StrJOBS
