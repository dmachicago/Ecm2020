
$ScriptPath = Split-Path $MyInvocation.InvocationName 

Install-Module -Name Az -AllowClobber

#$ScriptPath = Split-Path $MyInvocation.InvocationName 
#$ScriptPath = $MyInvocation.InvocationName 
Write-Host  'EXECUTING: $ScriptPath ';
$ScriptPath += "\modules\JOB_StdFunctions.ps1"

Import-Module "$ScriptPath" ;

clear
showRunning($JobName)

$global:message=””

write-host "Processing Group: $tgtgroup";
$global:MstrSvr = 'ALIEN15';
$global:MstrDB = 'DFINAnalytics';
$global:MstrUID = 'sa';
$global:MstrPW = 'Junebug1';

$global:MstrSvr;
$global:MstrDB;
$global:MstrUID;
$global:MstrPW;

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

$ActiveServers = Exec-Sproc -Conn $SqlConnection -Sproc "DFINAnalytics.dbo.UTIL_getActiveSvrJobs"  -Parameters $Parameters ; 

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
                            $svr = $SvrName ;                                 
                            if ($RunProc = 1 ){
                                write-host ("EXECUTING $JobName, STEP $StepName ON $svr IN db $tgtdb");
                                & "D:\dev\SQL\DFINAnalytics\PowerShell\JobsDFIN\JOB_ProcessAllJobSteps.ps1" -MstrSvr $global:MstrSvr -MstrDB global:MstrDB -MstrUID global:MstrUID -MstrPW global:MstrPW -svr $svr -db $tgtdb -uid $uid -pwd $pwd -qry$qry;
                                write-host ("Completed... $JobName, STEP $StepName ON $svr IN db $tgtdb");
                            }
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