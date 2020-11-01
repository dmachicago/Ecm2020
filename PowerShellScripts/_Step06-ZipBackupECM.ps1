
cls
echo off

try{
    Set-ExecutionPolicy RemoteSigned
}
catch {
    echo ("Caught the exception")
    echo ($Error[0].Exception)
    echo "Continuing..."
}

$global:dirlist = new-object system.collections.SortedList

#The directory that holds a backup of the ECM SERVICES and config/deploy files before they are updated for fallback purposes
$global:BACKUPDIR = "C:\EcmServicesBackup\" ;

#The directories to backup separated by a semicolon
$global:DIRLIST = "C:\EcmSite\Search;C:\EcmSite\EcmWebServices\SecureAttachAdminSVC" ;

$DateStr = $([DateTime]::Now.ToString("MM.dd.yyyy.hh.mm.sss"));

if (Test-Path $global:BACKUPDIR) {
    write-host "$global:BACKUPDIR exists"
}
else {
    New-Item $global:BACKUPDIR -type directory ; 
}

$DIRS = $global:DIRLIST.Split(";")

$count = $DIRS.Count;

Add-Type -AssemblyName "system.io.compression.filesystem";

foreach ($source in $DIRS)
{
    $fqn = $source.Replace(" ",".") + $DateStr + ".zip" ;
    $fqn = $fqn -Replace ":", "~"  ;
    $fqn = $fqn -Replace "\\", "_" ;
    $fqn = $global:BACKUPDIR + $fqn ;
    write-host "DIR: $fqn" ;
    [io.compression.zipfile]::CreateFromDirectory($source, $fqn) ;
}
 write-host "BACKUP Compete" ;