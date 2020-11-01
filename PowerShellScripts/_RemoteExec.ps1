cls
Enable-PSRemoting -Force

try{
    Set-ExecutionPolicy RemoteSigned
}
catch {
    echo ("Caught the exception")
    echo ($Error[0].Exception)
    echo "Continuing..."
}

Invoke-Command -ComputerName ECM2016 -File D:\dev\EcmMasterSingleSource\ECM\_ECMInstall\_PS_Parsenal\_Step02-CreateDirs.ps1