#Must be the first statement in your script
#param([string]$tgtgroup='dfintest')

#To bring ALL jobs in all groups back, pass in '*'
#powershell.exe -file "D:\dev\SQL\DFINAnalytics\PowerShell\execJobsInActiveDatabase.ps1" -tgtgroup 'dfintest' ;

#Install-Module -Name Az -AllowClobber

$script = "D:\dev\SQL\DFINAnalytics\PowerShell\execJobsInActiveDatabase.ps1";
powershell.exe -file $script "dfintest" -tgtgroup 'dfintest' ;