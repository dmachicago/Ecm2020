$serviceName = "EcmSearch"

if (Get-Service $serviceName -ErrorAction SilentlyContinue)
{
    $serviceToRemove = Get-WmiObject -Class Win32_Service -Filter "name='$serviceName'"
    $serviceToRemove.delete()
    "service removed - restalling service"
}
else
{
    "service does not exists, installing service"
}

$secpasswd = ConvertTo-SecureString "Junebug1" -AsPlainText -Force
$mycreds = New-Object System.Management.Automation.PSCredential (".\wmiller", $secpasswd)

$binaryPath = "c:\servicebinaries\MyService.exe"

New-Service -name $serviceName -binaryPathName $binaryPath -displayName $serviceName -startupType Automatic -credential $mycreds

"installation completed"