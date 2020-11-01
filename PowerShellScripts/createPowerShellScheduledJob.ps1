# Change these three variables to whatever you want
$jobname = "ECMOCR"
$script =  "C:\ECMOCR\ServerSideOcr.bat"
$repeat = (New-TimeSpan -Minutes 5)

if (!(test-Path -path "C:\ECMOCR"))
{
    New-Item "C:\ECMOCR" -type directory    
} 
else 
{
    Write-Host "Directory C:\ECMOCR exists."
}
if (!(test-Path -path $script))
{
    Add-Content -Path $script "cd\"
    Add-Content -Path $script "cd\" -Append
    Add-Content -Path $script 'cd "ECM Library"' -Append
    Add-Content -Path $script "cd ServerSideOCR" -Append
    Add-Content -Path $script "ServerSideOCR -i  23 -i  33" -Append
} 
else 
{
    Write-Host "File $script exists."
}
 
# The script below will run as the specified user (you will be prompted for credentials)
# and is set to be elevated to use the highest privileges.
# In addition, the task will run every 5 minutes or however long specified in $repeat.
$scriptblock = [scriptblock]::Create($script)
$trigger = New-JobTrigger -Once -At (Get-Date).Date -RepeatIndefinitely -RepetitionInterval $repeat
$msg = "Enter the username and password that will run the task"; 
$credential = $Host.UI.PromptForCredential("Task username and password",$msg,"$env:userdomain\$env:username",$env:userdomain)
 
$options = New-ScheduledJobOption -RunElevated -ContinueIfGoingOnBattery -StartIfOnBattery
Register-ScheduledJob -Name $jobname -ScriptBlock $scriptblock -Trigger $trigger -ScheduledJobOption $options -Credential $credential