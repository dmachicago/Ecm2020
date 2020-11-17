Import-Module D:\dev\SQL\DFINAnalytics\PowerShell\JobsDFIN\modules\JOB_StdFunctions.ps1 ;

$RunID = GetRunID;

# Change these three variables to whatever you want
$jobname = "JOB_UTIL_MonitorDeadlocks"
$script =  "D:\dev\SQL\DFINAnalytics\PowerShell\JobsDFIN\JOB_UTIL_MonitorDeadlocks.ps1"
$repeat = (New-TimeSpan -Minutes 5)
 
# The script below will run as the specified user (you will be prompted for credentials)
# and is set to be elevated to use the highest privileges.
# In addition, the task will run every 5 minutes or however long specified in $repeat.

$dt= ([DateTime]::Now)
$timespan = $dt.AddYears(5) -$dt;

$action = New-ScheduledTaskAction –Execute "$pshome\powershell.exe" -Argument  "$script; quit"
$duration = ($timespan )
$trigger = New-ScheduledTaskTrigger -Once -At (Get-Date).Date -RepetitionInterval $repeat -RepetitionDuration $duration
 
$msg = "Enter the username and password that will run the task"; 
$credential = $Host.UI.PromptForCredential("Task username and password",$msg,"$env:userdomain\$env:username",$env:userdomain)
$username = $credential.UserName
$password = $credential.GetNetworkCredential().Password
$settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries -StartWhenAvailable -RunOnlyIfNetworkAvailable -DontStopOnIdleEnd
 
Register-ScheduledTask -TaskName $jobname -Action $action -Trigger $trigger -RunLevel Highest -User $username -Password $password -Settings $settings