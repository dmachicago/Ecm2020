try{
    Set-ExecutionPolicy RemoteSigned
}
catch {
    echo ("Caught the exception")
    echo ($Error[0].Exception)
    echo "Continuing..."
}

#Version 2.1.1.446

    #********************************************************************************************
    #**** START BY LOADING THE VARIABLES SO ALL THE REST OF THE SCRIPTS CAN PROCESS USING THEM.
    #**** INITIALIZE THE VARIABLES AND REFER TO THE VAR FILE FOR DESCRIPTIONS OF THE VARS
    #********************************************************************************************
    $global:SSVer = ""
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
    $global:SECURELOGINDBNAME = ""  
    $global:LANGUAGEDBNAME = ""  
    $global:HIVEDBNAME = ""  
    $global:HIVEDBNAME = ""  

    $global:HIVEDBNAME = "" 
    $global:SearchSVCDIR = "" 
    $global:SearchSVCDIR = "" 

    $global:invsvr = ""

    $global:THESAURUSSVR = "" 
    $global:SECURELOGINSVR = "" 
    $global:LANGUAGESVR = "" 
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
    $global:PASSWORD = ""

    $global:slVars = new-object system.collections.SortedList
    #**********************************************************************************************************
    # IT IS CRITICAL TO SET ALL OF THESE VARIABLES CORRECTLY IN EACH STEP.
    #**********************************************************************************************************
    $ScriptDir = "C:\inetpub\wwwroot\ECMSaaS\_PSscripts"
    Import-Module -Name "$ScriptDir\PS_ECM_FunctionsV2.ps1"
    Import-Module -Name "$ScriptDir\LoadExecutionVars.ps1"

 
    $data = Get-Content "$ScriptDir\ECM.PS.VARS.txt"
    $global:slVars = LoadSetupVars
    $currdate = get-date

    $Notify = 1 ;

# Reviev by Peter and Dale
if ($global:SSVer -eq "2012")
{
   Import-Module sqlps -DisableNameChecking
}
        

echo off
echo "Author: W. Dale Miller"
echo "Copyright @ March, 2017, all rights reserved."
$Logfile = "C:\temp\_ECM.Install.Step3.LOG.txt"                

Write-Host "Step 3 - beginning the download of the installation files "
Add-Content -Path $Logfile -Value "Start of STEP:3 - DOWNLOAD - $currdate"
Set-Content -Path $Logfile -Value "New Logfile - Created: $currdate."


#cd C:\inetpub\wwwroot\Software\PowerShellInstallScripts
#***************************************************************************************
#**** Set the execution policy to allow this machine to run scripts. *******************
#***************************************************************************************
Set-ExecutionPolicy unrestricted –Force
Enable-PSRemoting -Force

Write-Host "Loading WEB Management modules, standby please..."
Load-Web-Administration

$CurrUser = [System.Security.Principal.WindowsIdentity]::GetCurrent().Name
$StartDate = Get-Date
$msg = "*** Run initiated by: $CurrUser"


$uPrompt = PromptUser "IIS Creation" "Does IIS need to be setup or reconfigured at this time?"
if ($uPrompt -eq 0)
{
    Write-Host "Validating IIS applications."  
    CreateIIS_Objects $Logfile
    Write-Host "IIS applications validation complete"  
}

write-host $data.count total lines read from file

$7ZIPPATH = $global:7ZIPPATH
Write-Host "7ZIPPATH - '$7ZIPPATH'"

$ADMINUSER = $global:ADMINUSER
Write-Host "ADMINUSER - '$ADMINUSER'"

$ADMINPASSWORD = $global:ADMINPASSWORD
Write-Host "ADMINPASSWORD - '$ADMINPASSWORD'"

$OcrSVR = $global:OCRSVR
Write-Host "OcrSVR - '$OcrSVR'"

$SqlSvrDataDir = $global:SQLSVRDATADIR
Write-Host "SqlSvrDataDir - '$SqlSvrDataDir'"

$HIVESVR = $global:HIVESVR
Write-Host "$HIVESVR - '$HIVESVR'"

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
# Reviev by Peter and Dale

#if ($global:SSVer -eq "2012")
#{
#$sqlpsreg="HKLM:\SOFTWARE\Microsoft\PowerShell\1\ShellIds\Microsoft.SqlServer.Management.PowerShell.sqlps110"
# }
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

#Push-Location
#cd $sqlpsPath
## Reviev by Peter and Dale
##Add-PSSnapin SqlServerCmdletSnapin100
##Add-PSSnapin SqlServerProviderSnapin100
##Update-TypeData -PrependPath SQLProvider.Types.ps1xml 
##update-FormatData -prependpath SQLProvider.Format.ps1xml 
#Pop-Location
 
Write-Host -ForegroundColor Yellow 'SQL Server Powershell extensions successfully loaded.'
Write-Host

#*******************************************************************
#***** DEFINE THE REQUIRED VARIABLES  ******************************
#*******************************************************************

#Define the servers to be used
#$RepositoryServer = $global:slVars["RSVR"]
$RepositoryServer = $global:RSVR

$ServicesServer = $global:SSVR
$GatewayServer = $global:GATEWAYSVR
$OCRServer = $global:OCRSVR
$global:HIVESVR = $global:HIVESVR

#Create the required Directories
$DirArchiveFS = $global:TDIR +"\_ArchiveFS\"
Write-Host -ForegroundColor Yellow "Creating $DirArchiveFS"
PS_ckDirectory $DirArchiveFS $Logfile 

$DirIFilterDownLoad = $global:TDIR +"\_IFilters\"
Write-Host -ForegroundColor Yellow "IFILTER URL: $DirIFilterDownLoad"

$O2007Download = $global:TDIR +"\_Office2007\"
$ServerSideOCRDownload = $global:TDIR +"\_ServerSideOCR\"

$DirArchive = $global:TDIR +"\_Archiver\"
Write-Host -ForegroundColor Yellow "Creating $DirArchive"
PS_ckDirectory $DirArchive $Logfile 

$DirReqSoftware = $global:TDIR +"\_ReqSoftware\"
Write-Host -ForegroundColor Yellow "Creating $DirReqSoftware"
PS_ckDirectory $DirReqSoftware $Logfile 

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
        Write-Host "Creating Directory $FSDIR exists."
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
PS_ckDirectory $DirIFilterDownLoad $Logfile 
PS_ckDirectory $O2007Download $Logfile 
PS_ckDirectory $ServerSideOCRDownload $Logfile

#******************************************************************************************************** 
$Password = $global:PASSWORD
#******************************************************************************************************** 

#******************************************************************************************************** 
#******************************************************************************************************** 
#***** HERE IS WHERE THE DOWNLOAD OF FILES BEGINS  
#******************************************************************************************************** 
#******************************************************************************************************** 

$DownLoadURL = "HTTP://www.EcmLibrary.com/ECMSAAS/EcmUploadZip/ArchiveFS/ArchiveFS.zip"
$DownLoadFQN = $DirArchiveFS + "ArchiveFS.zip"
#DownLoadZipFile -DownLoadURL $DownLoadURL -DownLoadFQN $DownLoadFQN -LogFile $LogFile

if ($Notify.Equals("1"))
{
    MessageBox("Downloading the installation ZIP Files")
}


if (Test-Path $DownLoadFQN)
{
    Write-Host "$DownLoadFQN already exists, skipping download"
    Add-Content -Path $Logfile -Value "$DownLoadFQN already exists, skipping download"    
}
else 
{
    Write-Host "Pulling $DownLoadFQN from $DownLoadURL..."
    downloadFile $DownLoadURL $DownLoadFQN
    #DownLoadZipFile $DownLoadURL $DownLoadFQN  $LogFile
    UnZipFilePW $7ZIPPATH $DownLoadFQN $DirArchiveFS $Password $LogFile
}


#******************************************************************************************************** 
#CHECK DATE: 7/15/2017 - WDM
$DownLoadURL = "HTTP://www.EcmLibrary.com/ECMSAAS/EcmUploadZip/Archiver/Archiver.zip"
$DownLoadFQN = $DirArchive + "Archiver.zip"
#DownLoadZipFile -DownLoadURL $DownLoadURL -DownLoadFQN $DownLoadFQN -LogFile $LogFile
#$FileCnt = CountDirFiles ($DirArchive)
if (Test-Path $DownLoadFQN)
{
    Write-Host "$DownLoadFQN already exists, skipping download"
    Add-Content -Path $Logfile -Value "$DownLoadFQN already exists, skipping download"    
}
else 
{
    Write-Host "Pulling $DownLoadFQN from $DownLoadURL..."
    downloadFile $DownLoadURL $DownLoadFQN
    UnZipFilePW $7ZIPPATH $DownLoadFQN $DirArchive $Password $LogFile
}

#******************************************************************************************************** 
#CHECK DATE: 7/15/2017 - WDM
$DownLoadURL = "HTTP://www.EcmLibrary.com/ECMSAAS/_Software/7z.zip"
$DownLoadFQN = $DirReqSoftware + "7z.zip"
$DownLoadDIR = $DirReqSoftware + "7z"
$UnzipToDir = $global:TDIR + "\_SoftWare\7z\"
Write-Host "UnzipToDir: $UnzipToDir"

if (Test-Path $DownLoadFQN)
{
    Write-Host "$DownLoadFQN already exists, skipping download"
    Add-Content -Path $Logfile -Value "$DownLoadFQN already exists, skipping download"
}
else 
{
    Write-Host "Pulling $DownLoadFQN from $DownLoadURL..."
    downloadFile $DownLoadURL $DownLoadFQN
    UnZipFilePW $7ZIPPATH $DownLoadFQN $UnzipToDir $Password $LogFile
}


if ($Notify.Equals("1"))
{
    MessageBox("Installing the Server Side OCR")
}
#******************************************************************************************************** 
#CHECK DATE: 7/15/2017 - WDM
$DownLoadURL = "HTTP://www.EcmLibrary.com/ECMSAAS/_Software/iFilters.zip"
$DownLoadFQN = $DirReqSoftware + "iFilters.zip"
$UnzipToDir = $global:TDIR + "\_SoftWare\iFilters\"

$icnt = ( Get-ChildItem $UnzipToDir | Measure-Object ).Count;

Write-Host "UnzipToDir: $UnzipToDir"

#if (Test-Path $DownLoadFQN)
if ($icnt -gt 0)
{
    Write-Host "$DownLoadFQN already exists, skipping download"
    Add-Content -Path $Logfile -Value "$DownLoadFQN already exists, skipping download"
}
else 
{
    Write-Host "Pulling $DownLoadFQN from $DownLoadURL..."
    downloadFile $DownLoadURL $DownLoadFQN
    UnZipFilePW $7ZIPPATH $DownLoadFQN $UnzipToDir $Password $LogFile
}


if ($Notify.Equals("1"))
{
    MessageBox("Installing the Server Side OCR")
}

#******************************************************************************************************** 
#CHECK DATE: 7/15/2017 - WDM
$DownLoadURL = "HTTP://www.EcmLibrary.com/ECMSAAS/_Software/Office2007.zip"
$DownLoadFQN = $DirReqSoftware + "Office2007.zip"
$UnzipToDir = $global:TDIR + "\_SoftWare\Office2007\"
Write-Host "UnzipToDir: $UnzipToDir"

if (Test-Path $DownLoadFQN)
{
    Write-Host "$DownLoadFQN already exists, skipping download"
    Add-Content -Path $Logfile -Value "$DownLoadFQN already exists, skipping download"
}
else 
{
    Write-Host "Pulling $DownLoadFQN from $DownLoadURL..."
    downloadFile $DownLoadURL $DownLoadFQN
    UnZipFilePW $7ZIPPATH $DownLoadFQN $UnzipToDir $Password $LogFile
}


if ($Notify.Equals("1"))
{
    MessageBox("Installing the Server Side OCR")
}

#******************************************************************************************************** 
#CHECK DATE: 7/15/2017 - WDM
$DownLoadURL = "HTTP://www.EcmLibrary.com/ECMSAAS/_Software/Cygwin.zip"
$DownLoadFQN = $DirReqSoftware + "Cygwin.zip"
$UnzipToDir = $global:TDIR + "\_SoftWare\Cygwin\"
Write-Host "UnzipToDir: $UnzipToDir"

if (Test-Path $DownLoadFQN)
{
    Write-Host "$DownLoadFQN already exists, skipping download"
    Add-Content -Path $Logfile -Value "$DownLoadFQN already exists, skipping download"
}
else 
{
    Write-Host "Pulling $DownLoadFQN from $DownLoadURL..."
    downloadFile $DownLoadURL $DownLoadFQN
    UnZipFilePW $7ZIPPATH $DownLoadFQN $UnzipToDir $Password $LogFile
}


if ($Notify.Equals("1"))
{
    MessageBox("Installing the Server Side OCR")
}
#******************************************************************************************************** 
#CHECK DATE: 7/15/2017 - WDM
$DownLoadURL = "HTTP://www.EcmLibrary.com/ECMSAAS/_Software/PowerShell_5.0.zip"
$DownLoadFQN = $DirReqSoftware + "PowerShell_5.0.zip"
$UnzipToDir = $global:TDIR + "\_SoftWare\PowerShell_5\"
Write-Host "UnzipToDir: $UnzipToDir"

if (Test-Path $DownLoadFQN)
{
    Write-Host "$DownLoadFQN already exists, skipping download"
    Add-Content -Path $Logfile -Value "$DownLoadFQN already exists, skipping download"
}
else 
{
    Write-Host "Pulling $DownLoadFQN from $DownLoadURL..."
    downloadFile $DownLoadURL $DownLoadFQN
    UnZipFilePW $7ZIPPATH $DownLoadFQN $UnzipToDir $Password $LogFile
}


if ($Notify.Equals("1"))
{
    MessageBox("Installing the Server Side OCR")
}
#******************************************************************************************************** 
#CHECK DATE: 7/15/2017 - WDM
$DownLoadURL = "HTTP://www.EcmLibrary.com/ECMSAAS/_Software/SharePointDesignerMODI.zip"
$DownLoadFQN = $DirReqSoftware + "SharePointDesignerMODI.zip"
$UnzipToDir = $global:TDIR + "\_SoftWare\SharePointDesignerMODI\"
Write-Host "UnzipToDir: $UnzipToDir"

if (Test-Path $DownLoadFQN)
{
    Write-Host "$DownLoadFQN already exists, skipping download"
    Add-Content -Path $Logfile -Value "$DownLoadFQN already exists, skipping download"
}
else 
{
    Write-Host "Pulling $DownLoadFQN from $DownLoadURL..."
    downloadFile $DownLoadURL $DownLoadFQN
    UnZipFilePW $7ZIPPATH $DownLoadFQN $UnzipToDir $Password $LogFile
}


if ($Notify.Equals("1"))
{
    MessageBox("Installing the Server Side OCR")
}

#******************************************************************************************************** 
#CHECK DATE: 7/15/2017 - WDM
#$DownLoadURL = "HTTP://www.EcmLibrary.com/ECMSAAS/EcmUploadZip/ReqSoftware/ReqSoftware.zip"
#$DownLoadFQN = $DirReqSoftware + "ReqSoftware.zip"
##DownLoadZipFile -DownLoadURL $DownLoadURL -DownLoadFQN $DownLoadFQN -LogFile $LogFile
#
##$FileCnt = CountDirFiles ($DirArchive)
#if (Test-Path $DownLoadFQN)
#{
#    Write-Host "$DownLoadFQN already exists, skipping download"
#    Add-Content -Path $Logfile -Value "$DownLoadFQN already exists, skipping download"
#}
#else 
#{
#    Write-Host "Pulling $DownLoadFQN from $DownLoadURL..."
#    downloadFile $DownLoadURL $DownLoadFQN
#    UnZipFilePW $7ZIPPATH $DownLoadFQN $DirClcDownloader $Password $LogFile
#}
#
#
#if ($Notify.Equals("1"))
#{
#    MessageBox("Installing the Server Side OCR")
#}

#******************************************************************************************************** 
#CHECK DATE: 7/15/2017 - WDM
$DownLoadURL = "HTTP://www.EcmLibrary.com/ECMSAAS/EcmUploadZip/ClcDownloader/ClcDownloader.zip"
$DownLoadFQN = $DirClcDownloader + "ClcDownloader.zip"
#DownLoadZipFile -DownLoadURL $DownLoadURL -DownLoadFQN $DownLoadFQN -LogFile $LogFile

#$FileCnt = CountDirFiles ($DirArchive)
if (Test-Path $DownLoadFQN)
{
    Write-Host "$DownLoadFQN already exists, skipping download"
    Add-Content -Path $Logfile -Value "$DownLoadFQN already exists, skipping download"
}
else 
{
    Write-Host "Pulling $DownLoadFQN from $DownLoadURL..."
    downloadFile $DownLoadURL $DownLoadFQN
    UnZipFilePW $7ZIPPATH $DownLoadFQN $DirClcDownloader $Password $LogFile
}


if ($Notify.Equals("1"))
{
    MessageBox("Installing the Server Side OCR")
}

#******************************************************************************************************** 
#CHECK DATE: 7/15/2017 - WDM
#WDMXX
$ServerSideOCRDownload = $global:TDIR +"\_ServerSideOCR\"
$DownLoadURL = "http://www.ecmlibrary.com/ECMSAAS/EcmUploadZip/ServerSideOCR/ServerSideOCR.ZIP"
$DownLoadFQN = $ServerSideOCRDownload + "ServerSideOcr.zip"
$UnzipToDir = $global:TDIR +"\_ServerSideOCR\Setup\"

if(!(Test-Path -Path $UnzipToDir)){
    New-Item -ItemType directory -Path $UnzipToDir
}

$FileCnt = CountDirFiles ($DownLoadFQN)
if ($FileCnt -lt 3)
{
    if (Test-Path $DownLoadFQN)
    {
        Write-Host "$DownLoadFQN already exists, skipping download"
        Add-Content -Path $Logfile -Value "$DownLoadFQN already exists, skipping download"
    }
    else 
    {
        Write-Host "Pulling $DownLoadFQN from $DownLoadURL..."
        downloadFile $DownLoadURL $DownLoadFQN
        UnZipFilePW $7ZIPPATH $DownLoadFQN $UnzipToDir $Password $LogFile
    }
}
else 
{
    if ($Notify.Equals("1"))
    {
        MessageBox("Server Side OCR already installed, continuing...")
    }
    Write-Host "$DownLoadFQN already exists, skipping download"
    Add-Content -Path $Logfile -Value "$DownLoadFQN already exists, skipping download"
}

#******************************************************************************************************** 
$ServerSideOCRDownload = $global:TDIR +"\_ServerSideOCR\"
$DownLoadURL = "http://www.ecmlibrary.com/ECMSAAS/EcmUploadZip/ServerSideOCR/ServerSideOcrBAT.ZIP"
$DownLoadFQN = $ServerSideOCRDownload + "ServerSideOcrBAT.zip"
$UnzipToDir = $global:TDIR +"\_ServerSideOCR\SetupBAT\"
#WDMXX
if(!(Test-Path -Path $UnzipToDir)){
    New-Item -ItemType directory -Path $UnzipToDir
}

$FileCnt = CountDirFiles ($DownLoadFQN)
if ($FileCnt -lt 3)
{
    if (Test-Path $DownLoadFQN)
    {
        Write-Host "$DownLoadFQN already exists, skipping download"
        Add-Content -Path $Logfile -Value "$DownLoadFQN already exists, skipping download"
    }
    else 
    {
        Write-Host "Pulling $DownLoadFQN from $DownLoadURL..."
        downloadFile $DownLoadURL $DownLoadFQN
        UnZipFilePW $7ZIPPATH $DownLoadFQN $UnzipToDir $Password $LogFile
    }
}
else 
{
    if ($Notify.Equals("1"))
    {
        MessageBox("Server Side OCR already installed, continuing...")
    }
    Write-Host "$DownLoadFQN already exists, skipping download"
    Add-Content -Path $Logfile -Value "$DownLoadFQN already exists, skipping download"
}

#******************************************************************************************************** 
#CHECK DATE: 7/15/2017 - WDM
$DownLoadURL = "HTTP://www.EcmLibrary.com/ECMSAAS/EcmUploadZip/EcmDBScripts/EcmDBScripts.zip"
$DownLoadFQN = $DirDBScripts + "DatabaseGenerationScripts.zip"
#DownLoadZipFile -DownLoadURL $DownLoadURL -DownLoadFQN $DownLoadFQN -LogFile $LogFile
if (Test-Path $DownLoadFQN)
{
    Write-Host "$DownLoadFQN already exists, skipping download"
    Add-Content -Path $Logfile -Value "$DownLoadFQN already exists, skipping download"
}
else 
{
    Write-Host "Pulling $DownLoadFQN from $DownLoadURL..."
    downloadFile $DownLoadURL $DownLoadFQN
    UnZipFilePW $7ZIPPATH $DownLoadFQN $DirDBScripts $Password $LogFile
}
#UnZipFilePW $7ZIPPATH $DownLoadFQN $DirSecureAttachAdmin $Password $LogFile

#******************************************************************************************************** 
#CHECK DATE: 7/15/2017 - WDM
$DownLoadURL = "HTTP://www.EcmLibrary.com/ECMSAAS/EcmUploadZip/Search/Search.zip"
$DownLoadFQN = $DirSearch + "Search.zip"
"DownLoadFQN = $DownLoadFQN"
#DownLoadZipFile -DownLoadURL $DownLoadURL -DownLoadFQN $DownLoadFQN -LogFile $LogFile
if (Test-Path $DownLoadFQN)
{
    Write-Host "$DownLoadFQN already exists, skipping download"
    Add-Content -Path $Logfile -Value "$DownLoadFQN already exists, skipping download"
}
else 
{
    Write-Host "Pulling $DownLoadFQN from $DownLoadURL..."
    downloadFile $DownLoadURL $DownLoadFQN
    UnZipFilePW $7ZIPPATH $DownLoadFQN $DirSearch $Password $LogFile
}
#UnZipFilePW $7ZIPPATH $DownLoadFQN $DirSearch $Password $LogFile

#******************************************************************************************************** 
#CHECK DATE: 7/15/2017 - WDM
$DownLoadURL = "HTTP://www.EcmLibrary.com/ECMSAAS/EcmUploadZip/SecureAttachAdmin/SecureAttachAdmin.zip"
$DownLoadFQN = $DirSecureAttachAdmin + "SecureAttachAdmin.zip"
#DownLoadZipFile -DownLoadURL $DownLoadURL -DownLoadFQN $DownLoadFQN -LogFile $LogFile
if (Test-Path $DownLoadFQN)
{
    Write-Host "$DownLoadFQN already exists, skipping download"
    Add-Content -Path $Logfile -Value "$DownLoadFQN already exists, skipping download"
}
else 
{
    Write-Host "Pulling $DownLoadFQN from $DownLoadURL..."
    downloadFile $DownLoadURL $DownLoadFQN
    UnZipFilePW $7ZIPPATH $DownLoadFQN $DirSecureAttachAdmin $Password $LogFile
}
#UnZipFilePW $7ZIPPATH $DownLoadFQN $DirSecureAttachAdmin $Password $LogFile

#******************************************************************************************************** 
$DownLoadURL = "HTTP://www.EcmLibrary.com/ECMSAAS/EcmUploadZip/SecureAttachAdminSvc/SecureAttachAdminSVC.zip"
$DownLoadFQN = $DirSecureAttachAdminSVC + "SecureAttachAdmin.zip"
#DownLoadZipFile -DownLoadURL $DownLoadURL -DownLoadFQN $DownLoadFQN -LogFile $LogFile
if (Test-Path $DownLoadFQN)
{
    Write-Host "$DownLoadFQN already exists, skipping download"
    Add-Content -Path $Logfile -Value "$DownLoadFQN already exists, skipping download"
}
else 
{
    Write-Host "Pulling $DownLoadFQN from $DownLoadURL..."
    downloadFile $DownLoadURL $DownLoadFQN
    UnZipFilePW $7ZIPPATH $DownLoadFQN $DirSecureAttachAdminSVC $Password $LogFile
}
#UnZipFilePW $7ZIPPATH $DownLoadFQN $DirSecureAttachAdminSVC $Password $LogFile

#******************************************************************************************************** 
#ERROR
$DownLoadURL = "HTTP://www.EcmLibrary.com/ECMSAAS/EcmUploadZip/ClcDownloader/ClcDownloader.zip"
$DownLoadFQN = $DirSVCclcDownload + "ClcDownloader.zip"
#DownLoadZipFile -DownLoadURL $DownLoadURL -DownLoadFQN $DownLoadFQN -LogFile $LogFile
if (Test-Path $DownLoadFQN)
{
    Write-Host "$DownLoadFQN already exists, skipping download"
    Add-Content -Path $Logfile -Value "$DownLoadFQN already exists, skipping download"
}
else 
{
    Write-Host "Pulling $DownLoadFQN from $DownLoadURL..."
    downloadFile $DownLoadURL $DownLoadFQN
    UnZipFilePW $7ZIPPATH $DownLoadFQN $DirSVCclcDownload $Password $LogFile
}
#UnZipFilePW $7ZIPPATH $DownLoadFQN $DirSVCclcDownload $Password $LogFile

#******************************************************************************************************** 
#******************************************************************************************************** 
#******************************************************************************************************** 
Write-Host -ForegroundColor Yellow  "____________________________________________________________________"
Write-Host -ForegroundColor cyan    "                         Script Complete"
Write-Host -ForegroundColor Yellow  "____________________________________________________________________"

$Msg = "COMPLETED installing the Server Software on $StartDate"
Write-Host -ForegroundColor Yellow  $msg
Add-Content -Path $Logfile -Value $msg

$Msg = "The script is done, please review the installation log '$Logfile' for possible errors."
Write-Host -ForegroundColor green  $msg

$uPrompt = PromptUser "OPEN LOG FILE" "Installation COMPLETE, would you like to open the logfile now?"
if ($uPrompt -eq 0)
{
    Start-Process notepad $Logfile
}

#******************************************************************************************************** 