Invoke-Sqlcmd -Query "SELECT @@VERSION;" -QueryTimeout 3

   if ($global:SSVer -eq "2012")
{
    write-host 'SQL SERVER 2012 installed'
	$sqlpsreg="HKLM:\SOFTWARE\Microsoft\PowerShell\1\ShellIds\Microsoft.SqlServer.Management.PowerShell.sqlps110"
}
else 
{
    write-host 'SQL SERVER ' $global:SSVer ' installed'
}