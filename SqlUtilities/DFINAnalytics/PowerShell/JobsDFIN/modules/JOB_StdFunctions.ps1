
$global:MstrSvr = 'ALIEN15';
$global:MstrDB = 'DFINAnalytics';
$global:MstrUID = 'sa';
$global:MstrPW = 'Junebug1';

function ckOncePerServer($SvrName, $Array){

    $Exists = $Array.Contains($SvrName);
    return $Exists;

}


function setLastRunDate($SvrName, $JobName){
    
    $d = date;

    Add-Content "D:\temp\_LOG_JobSteps.txt" "$d -------------> STARTED setLastRunDate <-------------";
    Add-Content "D:\temp\_LOG_JobSteps.txt" "$d -------------> setLastRunDate($Global:MstrSvr, $Global:MstrDB, $RowNbr, $SvrName, $JobName)  <-------------";

    $sql = "exec UTIL_ActiveJobSetLastRunDate '$JobName' ";
    
    WRITE-HOST "setLastRunDate sql : $sql";
    Add-Content "D:\temp\_LOG_JobSteps.txt" "$d $sql";

    try{
        if ($Global:MstrUID){
            $rc = Invoke-Sqlcmd -ServerInstance $Global:MstrSvr -Database $Global:MstrDB -Username $Global:MstrUID -Password $Global:MstrPW -Query $sql -QueryTimeout 1200;
        }
        else {
            $rc = Invoke-Sqlcmd -ServerInstance $Global:MstrSvr -Database $Global:MstrDB -Query $sql -QueryTimeout 1200;
        }

        $sql = "exec UTIL_ActiveJobScheduleSetLastRunDate '$SvrName', '$JobName' ";
        
        if ($Global:MstrUID){
            $rc = Invoke-Sqlcmd -ServerInstance $Global:MstrSvr -Database $Global:MstrDB -Username $Global:MstrUID -Password $Global:MstrPW -Query $sql -QueryTimeout 1200;
        }
        else {
            $rc = Invoke-Sqlcmd -ServerInstance $Global:MstrSvr -Database $Global:MstrDB -Query $sql -QueryTimeout 1200;
        }
        Add-Content "D:\temp\_LOG_JobSteps.txt" "$d -------------> COMPLETED setLastRunDate <-------------";
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
        Add-Content "D:\temp\_LOG_JobSteps.txt" "$d ERR244: -------------> ERROR: $msg <-------------";
    }
}

function setTimer($Action, $JobName, $StepName, $svr, $tgtdb, $DB_UID){


    $sql = "exec UTIL_ActiveJobExecutions '$Action', '$JobName', '$StepName', '$svr', '$tgtdb', '$DB_UID' ";
    $sql ;
    $d = date;
    Add-Content "D:\temp\_LOG_JobSteps.txt" "$d *************>  STARTED setTimer **********************";
    #Add-Content "D:\temp\_LOG_JobSteps.txt" "$d setTimer SQL >> $sql <<";
    Add-Content "D:\temp\_LOG_JobSteps.txt" "$d GLOBALS >.>.>.>.>.> $global:MstrSvr, $global:MstrDB, $global:MstrUID, $global:MstrPW <<";

    try{
    if ($Global:MstrUID){
            $rc = Invoke-Sqlcmd -ServerInstance $Global:MstrSvr -Database $Global:MstrDB -Username $Global:MstrUID -Password $Global:MstrPW -Query $sql -QueryTimeout 1200;
        }
        else {
            $rc = Invoke-Sqlcmd -ServerInstance $Global:MstrSvr -Database $Global:MstrDB -Query $sql -QueryTimeout 1200;
        }
        Add-Content "D:\temp\_LOG_JobSteps.txt" "$d *************>  COMPLETED setTimer **********************";
    }
    catch{
        write-host "*** ERROR 01: $_" ;
        $e = $_.Exception
        $msg = $e.Message
        while ($e.InnerException) {
          $e = $e.InnerExceptionfunction
          $msg += "`n" + $e.Message
        }
        $msg
        Add-Content "D:\temp\_LOG_JobSteps.txt" "$d *************>  ERROR: $msg **********************";
    }
}


workflow workflow_speed{
    param ([string]$MstrSvr, [string]$MstrDB, [string]$MstrUID, [string]$MstrPW, [string]$DelimitedJobs)
    #param ([string]$DelimitedJobs)
    <#
    $GroupName = '' ; 
    $SvrName = '' ; 
    $DBName = '' ; 
    $JName = '' ; 
    $UserID = '' ; 
    $pwd = '' ; 
    $isAzure = '' ; 
    $DBUID = '' ; 
    $JobUID = '' ; 
    $ScheduleUnit = '' ; 
    $ScheduleVal = '' ; 
    $LastRunDate = '' ; 
    $NextRunDate = '' ; 
    $StepName = '' ; 
    $StepSQL = '' ; 
    $RunIdReq = '' ; 
    $AzureOK = '' ; 
    $JobRowNbr = '' ; 
    $StepRowNbr = '' ;
    #>

    $ROWS=$DelimitedJobs.split(";")
    $RowCnt = $ROWS.count;
    "ROWCNT $RowCnt";
    $row = '' ;
    
    ForEach -Parallel -ThrottleLimit 10 ($row in $ROWS) {
        
        $items = $row.split("|")
        #$items.count;
        $GroupName=$items[0];
        $SvrName=$items[1];
        $DBName=$items[2];
        $JName=$items[3];
        $UserID=$items[4];
        $pwd=$items[5];
        $isAzure=$items[6];
        $DBUID=$items[7];
        $JobUID=$items[8];
        $ScheduleUnit=$items[9];
        $ScheduleVal=$items[10];
        $LastRunDate=$items[11];
        $NextRunDate=$items[12];
        $StepName=$items[13];
        $StepSQL=$items[14];
        $RunIdReq=$items[15];
        $AzureOK=$items[16];
        $JobRowNbr=$items[17];
        $StepRowNbr=$items[18];

        #$i += 1;
        #"$i of $RowCnt ";
        "$SvrName, $DBName, $JName,$StepName "
        if($StepSQL -like '*@RunID*') {
                      "@RunID found"
                      #$StepSQL.Replace("\@RunID", $runid);
                      $i = $StepSQL.IndexOf("@RunID") ;
                      $j = $StepSQL.IndexOf(" ", $i + 1) ;
                      $s1 = $StepSQL.Substring(0,$i-1) ;
                      $s2 = $StepSQL.Substring($j) ;
                      $s3 = $s1 + " " + $runid + "," +  $s2 ;
                      $StepSQL = $s3 ;
                      $RunIdReq = 'N';
                } 

       $rightnow = Get-Date ;
       if ($RunIdReq -eq 'N'){
                    if ($isAzureDB -eq 'Y' -and $AzureCompatibleSP -eq 'Y'){
                        $qry = "EXEC $StepSQL";
                        $RunProc = 1 ;
                    }
                    if ($isAzureDB -eq 'Y' -and $AzureCompatibleSP -eq 'N'){
                        #write-host "The server $svr is Azure the JobName: $JobName and Step $StepName IS NOT Azure Compatible. "  -ForegroundColor Red;;
                        $RunProc = 0 ;
                        #write-host ("") -ForegroundColor White;
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
                        #write-host "The server $svr is Azure the JobName: $JobName and Step $StepName IS NOT Azure Compatible. "  -ForegroundColor Red;;
                        $RunProc = 0 ;
                        #write-host ("") -ForegroundColor White;
                    }
                    if ($isAzureDB -eq 'N'){
                        $qry = "EXEC $StepSQL $runid";
                        $RunProc = 1 ;
                    }

                }
                
                $setBeforeExecution = 1 ;

                    try{                        
                            "EXECUTING $JobName, STEP $StepName ON $svr IN db $tgtdb";
                            if ($uid){
                                if ($setBeforeExecution -eq 1){
                                    setTimer "S" $Global:MstrSvr $Global:MstrDB $Global:MstrUID $Global:MstrPW $DBUID $StepRownbr $JobRownbr;
                                }

                                if ($setBeforeExecution -eq 1){
                                    setTimer "S" $Global:MstrSvr $Global:MstrDB $Global:MstrUID $Global:MstrPW $DBUID $StepRownbr $JobRownbr;
                                }
                                
                                $rc = Invoke-Sqlcmd -ServerInstance $SvrName -Database $DBName -Username $uid -Password $pw -Query $qry -QueryTimeout 1200;
                                
                                if ($setBeforeExecution -eq 1){
                                    setTimer "E" $Global:MstrSvr $Global:MstrDB $Global:MstrUID $Global:MstrPW $DB_UID $StepRownbr $JobRownbr;
                                    setLastRunDate $Global:MstrSvr $Global:MstrDB $Global:MstrUID $Global:MstrPW $JobRownbr, $svr,$JobName;
                                }

                            }
                            else {
                                if ($setBeforeExecution -eq 1){
                                    setTimer "S" $Global:MstrSvr $Global:MstrDB $Global:MstrUID $Global:MstrPW $DBUID $StepRownbr $JobRownbr;
                                }
                        
                                $rc = Invoke-Sqlcmd -ServerInstance $SvrName -Database $DBName -Query $qry  -QueryTimeout 1200;
                                
                                if ($setBeforeExecution -eq 1){
                                    setTimer "E" $Global:MstrSvr $Global:MstrDB $Global:MstrUID $Global:MstrPW $DB_UID $StepRownbr $JobRownbr;
                                    setLastRunDate $Global:MstrSvr $Global:MstrDB $Global:MstrUID $Global:MstrPW $JobRownbr, $svr,$JobName;
                                }
                            }
                            "Completed... $JobName, STEP $StepName ON $svr IN db $tgtdb";
                        
                        
                    } 
                    catch {
                        $string_err = $_ | Out-String
                        "ERROR: $string_err " ;
                    } 
    }
}

function showRunning($JobName){
    Write-Output "***************************************";
    Write-Output "---> EXECUTING: $JobName <---";
    Write-Output "***************************************";
}

function showDone($JobName){
    Write-Output "***************************************";
    Write-Output "---> $JobName DONE <---";
    Write-Output "***************************************";
}

function getRunID (){
        $EndDate=(GET-DATE)
        $StartDate=[datetime]”01/01/2019 00:00”
        $timediff = NEW-TIMESPAN –Start $StartDate –End $EndDate;
        $decimal =  [Math]::Truncate($timediff.TotalMinutes)     
        $i = $integer = [int]$decimal         
        return $i
}

function getModulePath(){
    #D:\dev\SQL\DFINAnalytics\PowerShell\JobsDFIN
    $MyInvocation.InvocationName 
    $path = $MyInvocation.InvocationName 
    return $path 
}

function recordError ($Instance, $db, $JobName, $ErrMsg, $fqn){
    $date = Get-Date -format "yyyyMMdd"
    $dt = Get-Date -Format g
    $msg = "$dt | ERROR: | $Instance | $db | $JobName | $ErrMsg |;";
    $fqn += 'ToolBelt.' + $date + ".error.txt";
    $fqn 
    #$fqn = "D:\dev\SQL\DFINAnalytics\PowerShell\ERRORS\" + 'ToolBelt.' + $date + ".error.txt";
    #Write-Host "FQN: $fqn";
    Out-File -Append $fqn -InputObject $msg -Encoding ASCII -Width 80
    Write-Host "ERROR RECORDED: "-ForegroundColor yellow -BackgroundColor red
    Write-Host "REVIEW $fqn "-ForegroundColor yellow -BackgroundColor red
    Write-Host "$msg"-ForegroundColor yellow -BackgroundColor red
}

function recordStopwatch ($JobName, $Instance, $db, $stopwatch){

    $uid = [guid]::NewGuid();
    $loc = $JobName.LastIndexOf('\') # Returns 9 ;
    $JobName = $JobName.substring($loc+1);

    $StopWatch.stop();
    $TS = $StopWatch.Elapsed.TotalSeconds;
    $TM = $StopWatch.Elapsed.TotalMinutes;

    #Write-Output " $JobName, TotalMinutes, $Instance, $db, $TM, $uid " ; 
    #Write-Output " $JobName, TotalSeconds, $Instance, $db, $TS, $uid " ; 

    $date = Get-Date -format "yyyyMMdd"
    $dt = Get-Date -Format g
    $fqn = 'ToolBelt.' + $date + ".StopWatch.txt";
    $msg = " $JobName, TotalMinutes, $Instance, $db, $TM, $uid" ;
    Out-File -Append $fqn -InputObject $msg -Encoding ASCII 

    $fqn = "D:/temp/$fqn";
    $fqn 
    $uid = [guid]::NewGuid();
    $msg = " $JobName, TotalSeconds, $Instance, $db, $TS, $uid" ;
    Out-File -Append $fqn -InputObject $msg -Encoding ASCII 
}

# Executes a Stored Procedure from Powershell and returns the first output DataTable
function Exec-Sproc{
    param($Conn, $Sproc, $Parameters=@{})
	#param($Conn, $Sproc, $Parameters)
    
	$SqlCmd = New-Object System.Data.SqlClient.SqlCommand
	$SqlCmd.CommandType = [System.Data.CommandType]::StoredProcedure
	$SqlCmd.Connection = $Conn
	$SqlCmd.CommandText = $Sproc
	foreach($p in $Parameters.Keys){
 		[Void] $SqlCmd.Parameters.AddWithValue("@$p",$Parameters[$p]);
        #write-host "Parameters $Parameters";
        #write-host "p = $p";
 	}
	$SqlAdapter = New-Object System.Data.SqlClient.SqlDataAdapter($SqlCmd)
	$DataSet = New-Object System.Data.DataSet
	[Void] $SqlAdapter.Fill($DataSet)
	$SqlConnection.Close()
	return $DataSet.Tables[0]
}
