$RunTheJobs = 1 ;
$RunInParallel = 1 ;

$ScriptPath = Split-Path $MyInvocation.InvocationName 
$ScriptPath

$FileName = "D:\temp\_LOG_JobSteps.txt"
if (Test-Path $FileName) 
{
  Remove-Item $FileName
}

Install-Module -Name Az -AllowClobber

#$ScriptPath = Split-Path $MyInvocation.InvocationName 
#$ScriptPath = $MyInvocation.InvocationName 
Write-Host  'EXECUTING: $ScriptPath ';
$ScriptPath += "\modules\JOB_StdFunctions.ps1"

Import-Module "$ScriptPath" ;

clear
#showRunning($JobName)

$global:message=””

write-host "Processing Group: $tgtgroup";
$global:MstrSvr = 'ALIEN15';
$global:MstrDB = 'DFINAnalytics';
$global:MstrUID = 'sa';
$global:MstrPW = 'Junebug1';

<#
$global:MstrSvr;
$global:MstrDB;
$global:MstrUID;
$global:MstrPW;
#>
$SleepTimer = 1000;
$MaxThreads = 10;

$RunStartTime = Get-Date ;

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

"ScriptPath $ScriptPath ";

$JobPath = Split-Path $MyInvocation.InvocationName ;
"JobPath $JobPath ";

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

$sql = "DFINAnalytics.dbo.UTIL_getActiveSvrJobs" ;
<#
foreach($p in $Parameters.Keys){
 		write-host "Parameters $Parameters";
        write-host "p = $p";
 	}
#>

if ($global:MstrUID){
            $ActiveServers = Invoke-Sqlcmd -ServerInstance $global:MstrSvr -Database $global:MstrDB -Username $global:MstrUID -Password $global:MstrPW -Query $sql -QueryTimeout 1200;
}
else {
            $ActiveServers = Invoke-Sqlcmd -ServerInstance $global:MstrSvr -Database $global:MstrDB -Query $global:sql -QueryTimeout 1200;
}

$xcnt = $ActiveServers.count ;

write-host "***************************************************";
write-host "  Number of Jobs/Steps to Execute: $xcnt ";
write-host "***************************************************";

$Array = @() ;
$icnt = 0 ;
$SvrCnt = $ActiveServers.count;

$executedcnt = 0 ;

foreach ($Server in $ActiveServers)
{ 
    $executedcnt += 1;
    $icnt += 1;
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
    $ExecutionOrder = $($Server['ExecutionOrder']);
    $StepSQL = $($Server['StepSQL']);
    $RunIdReq = $($Server['RunIdReq']);
    $AzureOK = $($Server['AzureOK']);
    $OncePerServer = $($Server['OncePerServer']);
      
    $svr = $SvrName;
    $tgtdb = $DBName ;
    $uid = $UserID;
    $pw = $pwd;
    $isAzureDB = $isAzure;
    $DB_UID  = $DBUID;

    $Exists = $Array.Contains($SvrName);
    $SkipThisServer = 0 ;

    if ($JobName -eq "JOB_UTIL_DBUsage"){
        write-host "Running job $JobName";
    }

    if ($OncePerServer -eq "Y"){
        $Exists = $Array.Contains($SvrName);
        if ($Exists){
            $SkipThisServer = 1 ;
        }
        else {
            $SkipThisServer = 0 ;
            $Array += $SvrName;
        }
    }

    if ($SkipThisServer -eq 0){

        if ($DB_UID){
            $DB_UID = $DB_UID.ToString();
            #$DB_UID ;
        }

        if ($RunIdReq -eq "Y" -and $StepSQL -notlike '*@RunID*') {
            $StepSQL = $StepSQL + " @RunID";
         }

        if($StepSQL -like '*@RunID*') {
            $StepSQL = $StepSQL -replace '@RunID',$runid
            $RunIdReq = 'N';
         } 

        $qry = $StepSQL
        $JobID = "$JobName.$StepName"   ;
        $ProcCall = "$JobPath\JOB_ExecuteJobStepPARMS.ps1";

        $jcnt = $(Get-Job -state running).count;
    
        if ($UserID){
            if ($RunTheJobs -eq 1) {
                if ($RunInParallel -eq 0){
                    write-host "Executing $SvrName : $DBName : $JobName : $qry";
                    write-host "# $executedcnt of $SvrCnt";
                
                    &"D:\dev\SQL\DFINAnalytics\PowerShell\JobsDFIN\JOB_ExecuteJobStepPARMS.ps1" -svr $SvrName -db $DBName -uid $UserID -pwd $pwd -isAzure $isAzure -ScriptPath $JobPath -qry $qry -JobName $JobName -ReqRunID $RunIdReq;
                }
                else {
                    Start-Job -name "$JobID" -FilePath "$ProcCall" -ArgumentList "$SvrName", "$DBName", "$UserID", "$pwd", "$isAzure", "$JobPath", "$qry", "$JobName", "$RunIdReq " > out-null ;
                }
            }
            else {
                Write-Host "Start-Job -name '$JobID' -FilePath '$ProcCall' -ArgumentList '$SvrName', '$DBName', '$UserID', '$pwd', '$isAzure', '$JobPath', '$qry', '$JobName', '$RunIdReq' ";
            }
        }
        else {
            if ($RunTheJobs -eq 1) {
                if ($RunInParallel -eq 0){
                    write-host "Executing $SvrName : $DBName : $JobName : $qry";
                    write-host "# $executedcnt of $SvrCnt";
                    &"D:\dev\SQL\DFINAnalytics\PowerShell\JobsDFIN\JOB_ExecuteJobStepPARMS.ps1" -svr $SvrName -db $DBName -uid $null -pwd $null -isAzure $isAzure -ScriptPath $JobPath -qry $qry -JobName $JobName -ReqRunID $RunIdReq;
                }
                else {
                    Start-Job -name "$JobID" -FilePath "$ProcCall" -ArgumentList "$SvrName", "$DBName", $null, $null, "$isAzure", "$JobPath", "$qry", "$JobName", "$RunIdReq" ;
                }
            }
            else {
                write-host "Start-Job -name '$JobID' -FilePath '$ProcCall' -ArgumentList '$SvrName', '$DBName', $null, $null, '$isAzure', '$JobPath', '$qry', '$JobName', '$RunIdReq' ";
            }
        }
        $LoopCnt = 0 ;
        $execCnt = 0 ;
        if ($RunInParallel -eq 1){
            While ($jcnt -ge $MaxThreads){
                #Write-Progress -Activity "Execution Progress" -Status "$i% Complete:" -PercentComplete $i;
                $execCnt += 1 ;
                if ($execCnt -eq 1){
                    Get-Job -state running
                }
                Start-Sleep -Milliseconds $SleepTimer
                $jcnt = $(Get-Job -state running).count;
                write-host -NoNewline ".";
                if ($execCnt % 30 -eq 0){
                    clear 
                    Get-Job -state running
                    write-host "Executing $icnt OF $SvrCnt : $execCnt secs in this run.";
                }
            }  
            $LoopCnt += 1 ;
            if ($LoopCnt % 30 -eq 0){
                clear
                Get-Job -state running
                write-host "Executing $icnt OF $SvrCnt";
            }

            if ($icnt % $MaxThreads -eq 0 -or $icnt -eq 1){
                clear
                Get-Job -state running
                write-host "Executing $icnt OF $SvrCnt";
            }
        }
    }
    #WDM
    #Get-Job -state running
}

write-host "Reading all jobs" ;

If ($OutputType -eq "Text"){
    ForEach($Job in Get-Job){
        "$($Job.Name)"
        "****************************************"
        Receive-Job $Job
        " "
    }
}
ElseIf($OutputType -eq "GridView"){
    Get-Job | Receive-Job | Select-Object * -ExcludeProperty RunspaceId | out-gridview    
}

$RunEndTime = Get-Date ;

$DURATION = $RunEndTime - $RunStartTime;
$DURATION.TotalMinutes
$T = $DURATION.TotalMinutes
$T= [math]::round($T, 2)
write-host "**************************************************";
write-host "Processed $SvrCnt jobs in $T minutes.";
write-host "**************************************************";

#& "D:\dev\SQL\DFINAnalytics\PowerShell\JobsDFIN\JOB_ExecuteJobStepPARMS.ps1" -svr ALIEN15 -db AW2016 -pwd Junebug1 -uid sa -isAzure N -ScriptPath $ScriptPath
#& "D:\dev\SQL\DFINAnalytics\PowerShell\JobsDFIN\JOB_ExecuteJobStepPARMS.ps1" -svr ALIEN15 -db PowerDatabase -pwd Junebug1 -uid sa -isAzure N -ScriptPath $ScriptPath
#& "D:\dev\SQL\DFINAnalytics\PowerShell\JobsDFIN\JOB_ExecuteJobStepPARMS.ps1" -svr ALIEN15 -db TestDB -pwd Junebug1 -uid sa -isAzure N -ScriptPath $ScriptPath
#& "D:\dev\SQL\DFINAnalytics\PowerShell\JobsDFIN\JOB_ExecuteJobStepPARMS.ps1" -svr ALIEN15 -db WDM -pwd Junebug1 -uid sa -isAzure N -ScriptPath $ScriptPath

write-host "****** COMPLETE *************";