cls
try{
    Set-ExecutionPolicy RemoteSigned
}
catch {
    echo ("Caught the exception")
    echo ($Error[0].Exception)
    echo "Continuing..."
}

    $global:SSVer
    $global:tokens = ""
    $global:token = ""
    $global:tVal= ""
    $global:RSVR = "" 
    $global:SSVR = "" 
    $global:UNAME = ""
    $global:FSFG = "" 
    $global:FSDIR = "" 
    $global:TDIR = "" 
    $global:PWD = "" 
    $global:PW = "" 
    $global:HIVESVR = "" 

    $global:REPODBNAME = "" 
    $global:SSVRDBNAME = ""
    $global:THESAURUSDBNAME = ""  
    $global:GATEWAYDBNAME = ""  
    $SECURELOGINDBNAME = ""  
    $global:LANGUAGEDBNAME = ""  
    $global:HIVEDBNAME = ""  
    $global:HIVEDBNAME = ""  

    $global:HIVEDBNAME = "" 
    $global:SearchSVCDIR = "" 
    $global:SearchSVCDIR = "" 

    $global:invsvr = ""

    $global:THESAURUSSVR = "" 
    $global:THESAURUSSVR = "" 
    $global:SECURELOGINSVR = "" 
    $LANGUAGESVR = "" 
    $global:HIVESVR = "" 
    $global:TDRSVR = ""  

    $global:EndPointArchiver = "" 
    $global:EndPointArchive = "" 
    $global:EndPointGateway = "" 
    $global:EndPointSearch = "" 

    $global:NewEndPointArchiver = "" 
    $global:NewEndPointArchive = "" 
    $global:NewEndPointGateway = "" 
    $global:NewEndPointSearch = "" 

    $global:ADMINUSER = "" 
    $global:ADMINPASSWORD = ""

$Notify = 1 ;

$global:slVars = new-object system.collections.SortedList
#**********************************************************************************
# IT IS CRITICAL TO SET THESE VARIABES CORRECTLY IN EACH STEP
#**********************************************************************************
$PSScriptDir = "C:\inetpub\wwwroot\ECMSaaS\_PSscripts"
$SoftwareDir  = "C:\inetpub\wwwroot\ECMSaaS\_Software"
Import-Module -Name "$PSScriptDir\PS_ECM_FunctionsV2.ps1"
Import-Module -Name "$PSScriptDir\LoadExecutionVars.ps1"

$data = Get-Content "$PSScriptDir\ECM.PS.VARS.txt"
$global:slVars = LoadSetupVars
# Reviev by Peter and Dale
if ($global:SSVer -eq "2012")
{
	Import-Module sqlps -DisableNameChecking
}
else 
{
}

#$SqlSvrDataDir = "C:\Program Files\Microsoft SQL Server\MSSQL10_50.GINA\MSSQL\DATA"
#***************************************************************************************
#Version 2.1.1.446
#***************************************************************************************
#***** CREATE REQUIRED DIRECTORIES IF MISSING
#***************************************************************************************        

cls
echo off
echo "Author: W. Dale Miller"
echo "Copyright @ August, 2017, all rights reserved."

$currdate = get-date
$Logfile = "C:\temp\_ECM.Step02.LOG.txt"                

cd\

if (!(test-Path -path "C:\temp"))
{
    New-Item "C:\temp" -type directory    
    Add-Content -Path $Logfile -Value "OcrSVR - '$OcrSVR'" 
} 
else 
{
    Write-Host "Directory C:\temp exists."
}

# Reviev by Peter and Dale
#if (!(test-Path -path "c:\ECM.Library.FS_2.SqlSvrFS"))
#{
#    New-Item "c:\ECM.Library.FS_2.SqlSvrFS" -type directory     
#} 
#else 
#{
#    Write-Host "Directory c:\ECM.Library.FS_2.SqlSvrFS exists."
#}


if (!(test-Path -path $global:WebSiteDir))
{
    New-Item "$global:WebSiteDir" -type directory     
} 
else 
{
    Write-Host "Directory $global:WebSiteDir exists."
}

if (!(test-Path -path $PSScriptDir))
{
    New-Item "$PSScriptDir" -type directory     
} 
else 
{
    Write-Host "Directory $PSScriptDir exists."
}

if (!(test-Path -path "$SoftwareDir\iFilters"))
{
    New-Item "$SoftwareDir\iFilters" -type directory     
} 
else 
{
    Write-Host "Directory $SoftwareDir\iFilters exists."
}

if (!(test-Path -path "C:\ECMOCR"))
 {
     New-Item "C:\ECMOCR" -type directory   
     Write-Host "Directory C:\ECMOCR DID NOT exist, created new directory."  
 } 
 else 
 {
    Write-Host "Directory C:\ECMOCR exists."
 }
if (!(test-Path -path "C:\temp"))
 {
     New-Item "C:\temp" -type directory   
     Write-Host "Directory C:\temp DID NOT exist, created new directory."  
 } 
 else 
 {
    Write-Host "Directory C:\temp exists."
 }

if (!(test-Path -path "C:\temp"))
{
     Write-Host "Directory C:\temp DOES NOT exist, aborting install."
     exit
} 

if (!(test-Path -path $SqlSvrDataDir))
{  
    New-Item -Path $SqlSvrDataDir -ItemType directory 
    Write-Host "Directory C:\$SqlSvrDataDir DID NOT exist, created new directory."  
} 
else 
{
    Write-Host "Directory C:\$SqlSvrDataDir exists."
}

Write-Host "OcrSVR - '$OcrSVR'"
Add-Content -Path $Logfile -Value "OcrSVR - '$OcrSVR'"


#**********************************************************************************************
#**** IMMMEDIATELY CREATE THE WORKING DIRECTORY
Add-Content -Path $Logfile -Value "IMMMEDIATELY CREATE THE WORKING DIRECTORY: $global:TDIR"            
PS_ckDirectory $global:TDIR $Logfile 
#**********************************************************************************************

$StartDate = Get-Date
$Msg = "Please standby, inventorying the Server Software, this can take a few minutes: $StartDate"
Write-Host $msg
Add-Content -Path $Logfile -Value "* $msg"
Add-Content -Path $Logfile -Value get-date
$XDIR = $global:TDIR + "\_InstalledSoftware.csv"

$StartDate = Get-Date

if ($invsvr -eq 1)
{    
    $Msg = "Beginning Inventory: $StartDate - This can take a few minutes."
    Write-Host -ForegroundColor Yellow  $msg
    Get-WmiObject win32_Product  | Select Name, Version, PackageName, Installdate, Vendor | Sort Name -Descending| Export-Csv $XDIR 
    Write-Host -ForegroundColor green ("Server Inventory in file: $XDIR")
}

$XDIR
$retc = Is2007Installed $XDIR
if ($retc -eq 0)
{
    Write-Host -ForegroundColor red "MODI 2007 NOT installed, aborting."
    Write-Host -ForegroundColor red "A temporary installation ISO is in the software directory."
    exit
}
else 
{
    Write-Host "MODI 2007 installed, continuing."
}
#*******************************************************************
#***** BUILD THE REQUIRED WORKING DIRECTORY SET
#***** LOAD THE SQL PS ENVIRONMENT 
#*******************************************************************
#
# Initialize-SqlpsEnvironment.ps1
#
# Loads the SQL Server provider extensions
#
# Usage: Powershell -NoExit -Command "& '.\Initialize-SqlPsEnvironment.ps1'"
#
 
$ErrorActionPreference = "Stop"

if ($Notify.Equals("1"))
{
    MessageBox("Loading the SQLServer interface")
}

## Reviev by Peter and Dale 
#    if ($global:SSVer -eq "2012")
#{
#$sqlpsreg="HKLM:\SOFTWARE\Microsoft\PowerShell\1\ShellIds\Microsoft.SqlServer.Management.PowerShell.sqlps110"
#}
# 
#if (Get-ChildItem $sqlpsreg -ErrorAction "SilentlyContinue")
#{
#    throw "SQL Server Powershell is not installed."
#}
#else
#{
#    $item = Get-ItemProperty $sqlpsreg
#    $sqlpsPath = [System.IO.Path]::GetDirectoryName($item.Path)
#}
 
#Write-Host -ForegroundColor Yellow 'sqlpsPath' $sqlpsPath

#
# Preload the assemblies. Note that most assemblies will be loaded when the provider
# is used. if you work only within the provider this may not be needed. It will reduce
# the shell's footprint if you leave these out.
#
$assemblylist = 
"Microsoft.SqlServer.Smo",
"Microsoft.SqlServer.Dmf ",
"Microsoft.SqlServer.SqlWmiManagement ",
"Microsoft.SqlServer.ConnectionInfo ",
"Microsoft.SqlServer.SmoExtended ",
"Microsoft.SqlServer.Management.RegisteredServers ",
"Microsoft.SqlServer.Management.Sdk.Sfc ",
"Microsoft.SqlServer.SqlEnum ",
"Microsoft.SqlServer.RegSvrEnum ",
"Microsoft.SqlServer.WmiEnum ",
"Microsoft.SqlServer.ServiceBrokerEnum ",
"Microsoft.SqlServer.ConnectionInfoExtended ",
"Microsoft.SqlServer.Management.Collector ",
"Microsoft.SqlServer.Management.CollectorEnum"
 

foreach ($asm in $assemblylist)
{
    $asm = [Reflection.Assembly]::LoadWithPartialName($asm)
}
 
#
# Set variables that the provider expects (mandatory for the SQL provider)
#
Set-Variable -scope Global -name SqlServerMaximumChildItems -Value 0
Set-Variable -scope Global -name SqlServerConnectionTimeout -Value 30
Set-Variable -scope Global -name SqlServerIncludeSystemObjects -Value $false
Set-Variable -scope Global -name SqlServerMaximumTabCompletion -Value 1000
 
#
# Load the snapins, type data, format data
#
#Push-Location
#cd $sqlpsPath
## Reviev by Peter and Dale
##Add-PSSnapin SqlServerCmdletSnapin100
##Add-PSSnapin SqlServerProviderSnapin100
##Update-TypeData -PrependPath SQLProvider.Types.ps1xml 
##update-FormatData -prependpath SQLProvider.Format.ps1xml 
#Pop-Location
 
Write-Host -ForegroundColor Yellow 'SQL Server Powershell extensions are loaded.'
Write-Host
Write-Host -ForegroundColor Yellow 'Type "cd SQLSERVER:\" to step into the provider.'
Write-Host
Write-Host -ForegroundColor Yellow 'For more information, type "help SQLServer".'

#*******************************************************************
#***** DEFINE THE REQUIRED VARIABLES  ******************************
#*******************************************************************

#Define the servers to be used
$RepositoryServer = $global:slVars["RSVR"]
$ServicesServer = $global:slVars["SSVR"]
$GatewayServer = $global:slVars["GATEWAYSVR"]
$OCRServer = $global:slVars["OCRSVR"]
$HiveSvr = $global:slVars["HIVESVR"]


#Create the required Directories
$DirArchiveFS = $global:TDIR +"\_ArchiveFS\"
Write-Host -ForegroundColor Yellow "Creating $DirArchiveFS"
PS_ckDirectory $DirArchiveFS $Logfile 

$DirArchive = $global:TDIR +"\_Archiver\"
Write-Host -ForegroundColor Yellow "Creating $DirArchive"
PS_ckDirectory $DirArchive $Logfile 

$DirClcDownloader = $global:TDIR +"\_ClcDownloader\"
Write-Host -ForegroundColor Yellow "Creating $DirClcDownloader"
PS_ckDirectory $DirClcDownloader $Logfile 

$DirConsoleArchiver = $global:TDIR +"\_ConsoleArchiver\"
Write-Host -ForegroundColor Yellow "Creating $DirConsoleArchiver"
PS_ckDirectory $DirConsoleArchiver $Logfile 

$DirDBScripts = $global:TDIR +"\_DBScripts\"
Write-Host -ForegroundColor Yellow "Creating $DirDBScripts"
PS_ckDirectory $DirDBScripts $Logfile 

$DirSearch = $global:TDIR +"\_Search\"
Write-Host -ForegroundColor Yellow "Creating $DirSearch"
PS_ckDirectory $DirSearch $Logfile 

$DirSecureAttachAdmin = $global:TDIR +"\_SecureAttachAdmin\"
Write-Host -ForegroundColor Yellow "Creating $DirSecureAttachAdmin"
PS_ckDirectory $DirSecureAttachAdmin $Logfile 

$DirSecureAttachAdminSVC = $global:TDIR +"\_SecureAttachAdminSVC\"
Write-Host -ForegroundColor Yellow "Creating $DirSecureAttachAdminSVC"
PS_ckDirectory $DirSecureAttachAdminSVC $Logfile 

$DirSVCclcDownload = $global:TDIR +"\_SVCclcDownload\"
Write-Host -ForegroundColor Yellow "Creating $DirSVCclcDownload"
PS_ckDirectory $DirSVCclcDownload $Logfile 

# Reviev by Peter and Dale
#Add-PSSnapin SqlServerCmdletSnapin100
#Add-PSSnapin SqlServerProviderSnapin100

#import-module sqlps 

#*******************************************************************
#**** REMOVE EXISTING TEMPORARY FILES IF THEY EXIST ****************
#*******************************************************************
#Remove the files from the directory

$RemoveExistingDbScripts = 0

IF ($RemoveExistingDbScripts.Equals(1))
{
    if (Test-Path $DirSecureAttachAdmin) {
      Remove-Item -r $DirSecureAttachAdmin
    }

    $RemoveExistingDbScripts = 1
    if (Test-Path $DirDBScripts) {
        "Removing $DirDBScripts"
        Remove-Item -r -Force $DirDBScripts    
    }

}


#************************************************************************************
if (!(test-Path -path $FSDIR))
{
    New-Item $FSDIR -type directory     
} 
else 
{
    Write-Host "Directory $FSDIR exists."
}

if (!(test-Path -path $FSDIR))
{
    Write-Host -ForegroundColor red "Directory $FSDIR DOES NOT exist, aborting install."
    exit
} 

if (Test-Path $FSDIR) {
    $files = Get-ChildItem $FSDIR -Recurse | Where-Object {!$_.PSIsContainer} | Measure-Object
    $xcnt = $files.Count
    if ($xcnt -gt 0)
    {
        Remove-Item -Path $FSDIR
    }  
}
#************************************************************************************


# $EcmSearchDir = "C:\inetpub\wwwroot\SecureAttachAdmin\"
# $EcmSearchDir = "C:\inetpub\wwwroot\ECMSearch\"

#Create directory if does not exist
#ckDir($DirSecureAttachAdmin)

#********************************************************************************************************
#***** CREATE THE REQUIRED TEMPORARY DIRECTORIES  *******************************************************
#********************************************************************************************************    
# Create directory if does not exist
PS_ckDirectory $FSFG $Logfile 
PS_ckDirectory $DirConsoleArchiver $Logfile 
PS_ckDirectory $DirDBScripts $Logfile 
PS_ckDirectory $DirSecureAttachAdmin $Logfile 
PS_ckDirectory $DirSecureAttachAdminSVC $Logfile 
PS_ckDirectory $DirArchiveFS $Logfile 
PS_ckDirectory $DirClcDownloader $Logfile 
PS_ckDirectory $DirArchive $Logfile 
PS_ckDirectory $DirSecureAttachAdmin $Logfile 
#******************************************************************************************************** 
