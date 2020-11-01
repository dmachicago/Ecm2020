Import-Module WebAdministration

$SiteName = "EcmSearch"
$HostName = "ECM2016"
$SiteFolder = Join-Path -Path 'C:\inetpub\wwwroot' -ChildPath $SiteName

New-WebSite -Name $SiteName -PhysicalPath $SiteFolder -Force
$IISSite = "IIS:\Sites\$SiteName"
Set-ItemProperty $IISSite -name  Bindings -value @{protocol="https";bindingInformation="*:443:$HostName"}

#Then start the Website:
Start-WebSite -Name $SiteName