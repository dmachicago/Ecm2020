$User = "wmiller"
$PWord = ConvertTo-SecureString -String "Junebug1" -AsPlainText -Force
$Credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $User, $PWord

Enable-AzContextAutosave

$JobToRun = "D:\dev\SQL\DFINAnalytics\PowerShell\JobsDFIN\JOB_UTIL_QryPlanStats.ps1"
#$job = Start-Job -ScriptBlock {"D:\dev\SQL\DFINAnalytics\PowerShell\JobsDFIN\JOB_DFS_BoundQry_ProcessAllTables.ps1"}
$job = Start-Job -ScriptBlock {$JobToRun}

$results = Receive-Job -Job $job

$results 