cls
try{
    Set-ExecutionPolicy RemoteSigned
}
catch {
    echo ("Caught the exception")
    echo ($Error[0].Exception)
    echo "Continuing..."
}

Add-Type -AssemblyName PresentationCore,PresentationFramework

$global:SSVer
$global:SSVer = ""
$global:tokens = ""
$global:token = ""
$global:tVal= ""
$global:REPOSVR = "" 
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

$global:slVars = new-object system.collections.SortedList


#**************************************************************************
# IT IS CRITICAL TO SET THESE VARIABLES CORRECTLY
#**************************************************************************
$MasterDir = "C:\inetpub\wwwroot\ECMSaaS\_PSscripts"    #This is where the PowerShell Scripts are uploaded
Import-Module -Name "C:\inetpub\wwwroot\ECMSaaS\_PSscripts\PS_ECM_FunctionsV2.ps1"
Import-Module -Name "C:\inetpub\wwwroot\ECMSaaS\_PSscripts\LoadExecutionVars.ps1"
$data = Get-Content "C:\inetpub\wwwroot\ECMSaaS\_PSscripts\ECM.PS.VARS.txt"
$slVars = LoadSetupVars

 Write-Host $slVars 

#Version 2.1.1.446

#cls
#echo off
echo "Author: W. Dale Miller"
echo "Copyright @ March, 2017, all rights reserved."
$Logfile = "C:\temp\_ECM.Install.Step1.LOG.txt"                

$TARGETDIR = 'C:\temp'
if(!(Test-Path -Path $TARGETDIR )){
    New-Item -ItemType directory -Path $TARGETDIR
}

$currdate = get-date
Set-Content -Path $Logfile -Value "New Logfile - Created: $currdate."

if (!(test-Path -path "C:\inetpub\wwwroot\ECMSaaS\_PSscripts"))
{
    New-Item "C:\inetpub\wwwroot\ECMSaaS\_PSscripts" -type directory     
} 
else 
{
    Write-Host "Directory C:\inetpub\wwwroot\ECMSaaS\_PSscripts exists."
}

if (!(test-Path -path "C:\inetpub\wwwroot\ECMSaaS\_PSscripts"))
{
    Write-Host "Directory C:\inetpub\wwwroot\ECMSaaS\_PSscripts DOES NOT exist, aborting install."
    exit
} 

cd C:\inetpub\wwwroot\ECMSaaS\_PSscripts
#***************************************************************************************
#**** Set the execution policy to allow this machine to run scripts. *******************
#***************************************************************************************
#Set-ExecutionPolicy unrestricted –Force
#Enable-PSRemoting -Force

$slVars = new-object system.collections.SortedList
$MasterDir = "C:\inetpub\wwwroot\ECMSaaS\_PSscripts"
#Import-Module -Name "C:\inetpub\wwwroot\ECMSaaS\_PSscripts\PS_ECM_Functions.ps1"
$data = Get-Content "C:\inetpub\wwwroot\ECMSaaS\_PSscripts\ECM.PS.VARS.txt"

# Reviev by Peter and Dale
   if ($global:SSVer -eq "2012")
{
Import-Module sqlps -DisableNameChecking
}
else 
{
}
#***************************************************************************************
$v1 = $psversiontable.psversion
$v = getPowerShellVersion
if ($v -lt 3)
{
    Write-Host ("Powershell Version $v is NOT a usable version of PowerSHell, continuing, aborting.")
#    MessageBox("Powershell Version $v is NOT a usable version of PowerSHell, continuing, aborting.")
    exit
}
else 
{
    Write-Host ("Powershell Version $v is a usable version of PowerSHell, continuing.")
}


if (test-Path -path "C:\temp\7ZipExists")
 {
     Write-Host "7Zip installed, proceeding."  
 } 
 else 
 {
    Write-Host "Verifying 7-Zip installed, this can take a few minutes, please stand by..."
    $i = isAppInstalled “7-Zip”
    if ($i -lt 1)
    {
        write-host ("7-ZIP Not installed")        
        $uPrompt = PromptUser "7ZIP MISSING" "7-Zip must be installed to run this script, would you like to install now?"
        if ($uPrompt -eq 0)
        {
            Write-Host "Installing 7-ZIP."  
            Install7Zip
            Write-Host "7-Zip installed"  
            cd C:\inetpub\wwwroot\ECMSaaS\_PSscripts
        }        
        else 
        {
            MessageBox("7-Zip must be installed to run this script, aborint install")
            exit
        }
        
    }
    else 
    {
     New-Item "C:\temp\7ZipExists" -type directory        
    }
 }


Write-Host "Loading WEB Management modules, standby please..."
Load-Web-Administration

Write-Host "current user:"
Write-Host $(whoami)
Write-Host $(get-date)

$CurrUser = [System.Security.Principal.WindowsIdentity]::GetCurrent().Name
$StartDate = Get-Date
$msg = "*** Run initiated by: $CurrUser"

#********************************************************************************************
#**** START BY LOADING THE VARIABLES SO ALL THE REST OF THE SCRIPTS CAN PROCESS USING THEM.
#**** INITIALIZE THE VARIABLES AND REFER TO THE VAR FILE FOR DESCRIPTIONS OF THE VARS
#********************************************************************************************
$tokens = ""
$token = ""
$tVal= ""
$RSVR = "" 
$SSVR = "" 
$UNAME = ""
$FSFG = "" 
$FSDIR = "" 
$TDIR = "" 
$PWD = "" 
$PW = "" 
$HIVESVR = "" 

$REPODBNAME = "" 
$SSVRDBNAME = ""
$THESAURUSDBNAME = ""  
$GATEWAYDBNAME = ""  
$SECURELOGINDBNAME = ""  
$LANGUAGEDBNAME = ""  
$HIVEDBNAME = ""  
$TDRDBNAME = ""  

$ArchiveSVCDIR = "" 
$SearchSVCDIR = "" 
$GateWaySVCDIR = "" 

$invsvr = ""

$THESAURUSSVR = "" 
$GATEWAYSVR = "" 
$SECURELOGINSVR = "" 
$LANGUAGESVR = "" 
$HIVESVR = "" 
$TDRSVR = ""  

$EndPointArchiver = "" 
$EndPointArchive = "" 
$EndPointGateway = "" 
$EndPointSearch = "" 

$NewEndPointArchiver = "" 
$NewEndPointArchive = "" 
$NewEndPointGateway = "" 
$NewEndPointSearch = "" 

$ADMINUSER = "" 
$ADMINPASSWORD = ""


$StartDate = Get-Date
$Msg = "Please standby, inventorying the Server Software, this can take a few minutes: $StartDate"
Write-Host $msg
Add-Content -Path $Logfile -Value "* $msg"
Add-Content -Path $Logfile -Value get-date
$XDIR = $TDIR + "\_InstalledSoftware.csv"

$StartDate = Get-Date

$Msg = "Beginning Inventory: $StartDate - This can take a few minutes."
Write-Host -ForegroundColor Yellow  $msg
Get-WmiObject win32_Product  | Select Name, Version, PackageName, Installdate, Vendor | Sort Name -Descending| Export-Csv $XDIR 
Write-Host -ForegroundColor green ("Server Inventory in file: $XDIR")


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

MessageBox("Testing the installation of the SQLServer interface")
# Review by Peter and Dale 


if (get-command -module sqlps -ErrorAction "SilentlyContinue")
{
    #throw "SQL Server Powershell is not installed."
    write-host "SQL Server powershell interface is installed."
}
else
{
    MessageBox("SQL Server powershell interface is NOT installed.")
}

Write-Host -ForegroundColor Yellow 'sqlpsPath' $sqlpsPath

#
# Preload the assemblies. Note that most assemblies will be loaded when the provider
# is used. if you work only within the provider this may not be needed. It will reduce
# the shell's footprint if you leave these out.
#

MessageBox("Testing the Preload of the SQL Server modules.")

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
##Add-PSSnapin SqlServerCmdletSnapin110
##Add-PSSnapin SqlServerProviderSnapin110
##Update-TypeData -PrependPath SQLProvider.Types.ps1xml 
##update-FormatData -prependpath SQLProvider.Format.ps1xml 
#Pop-Location
 
Write-Host -ForegroundColor Yellow 'SQL Server Powershell extensions are loaded.'

Write-Host -ForegroundColor White 'Testing SQL Server Snapins.'
# Reviev by Peter and Dale
#Add-PSSnapin SqlServerCmdletSnapin110
#Add-PSSnapin SqlServerProviderSnapin110


#********************************************************************
Write-Host -ForegroundColor Yellow  "____________________________________________________________________"
Write-Host -ForegroundColor cyan    "                         Script Complete"
Write-Host -ForegroundColor Yellow  "____________________________________________________________________"

$Msg = "COMPLETED the Prereq Software @ $StartDate"
Write-Host -ForegroundColor red  $msg
Add-Content -Path $Logfile -Value $msg

$Msg = "The script is done, please review the installation log '$Logfile' for possible errors."
Write-Host -ForegroundColor green  $msg

$uPrompt = PromptUser "Script COMPLETE" "Installation finished, would you like to open the logfile now?"
if ($uPrompt -eq 0)
{
    $Logfile = "C:\temp\_ECM.Install.Step1.LOG.txt" 
    Start-Process notepad $Logfile
}

    
