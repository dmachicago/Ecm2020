
Install-Module -Name Az -AllowClobber
#Install-Module -Name Az -AllowClobber -Scope CurrentUser

$User = "wmiller"
$PWord = ConvertTo-SecureString -String "Junebug1" -AsPlainText -Force
$Credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $User, $PWord

Enable-AzContextAutosave

$JobToRun = "D:\dev\SQL\DFINAnalytics\PowerShell\JobsDFIN\JOB_UTIL_QryPlanStats.ps1"
#$JobToRun = "D:\dev\SQL\DFINAnalytics\PowerShell\JobsDFIN\JOB_DFS_BoundQry_ProcessAllTables.ps1";

#$creds = Get-Credential
$creds = $Credential
$job = New-AzVM -Name "D:\dev\SQL\DFINAnalytics\PowerShell\JobsDFIN\JOB_DFS_BoundQry_ProcessAllTables.ps1" -Credential $creds -AsJob
$job.Finished


$jobx = Start-Job -ScriptBlock {$JobToRun}
$results = Receive-Job -Job $jobx
$results

