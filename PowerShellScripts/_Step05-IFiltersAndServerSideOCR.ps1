
try{
    Set-ExecutionPolicy RemoteSigned
}
catch {
    echo ("Caught the exception")
    echo ($Error[0].Exception)
    echo "Continuing..."
}

#Version 2.1.1.446
cls
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
    #********************************************************************************************************
    # IT IS CRITICAL TO SET ALL OF THESE VARIABES CORRECTLY IN EACH STEP
    #********************************************************************************************************
    $ScriptDir = "C:\inetpub\wwwroot\ECMSaaS\_PSscripts"
    Import-Module -Name "$ScriptDir\PS_ECM_FunctionsV2.ps1"
    Import-Module -Name "$ScriptDir\LoadExecutionVars.ps1"

    $ServerSideOCRDownload = $global:TDIR +"\_ServerSideOCR\"
    $ServerSideOCRDownloadBAT = $global:TDIR +"\_ServerSideOCR\SetupBAT\"
    $ServerSideOCRDownloadSETUP = $global:TDIR +"\_ServerSideOCR\Setup\"

 
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
echo "Copyright @ March, 2010, all rights reserved."
$Logfile = "C:\temp\_ECM.Install.Step5.LOG.txt"                

Write-Host "Step 5 - Ifilters "
Add-Content -Path $Logfile -Value "Start of STEP:5 - IFilters and ServerSideOCR - $currdate"
Set-Content -Path $Logfile -Value "New Logfile - Created: $currdate."


cd $ScriptDir
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
Write-Host "HIVESVR - '$HIVESVR'"

Add-Content -Path $Logfile -Value "OcrSVR - '$OcrSVR'"


#**********************************************************************************************
#**** IMMMEDIATELY CREATE THE WORKING DIRECTORY
Add-Content -Path $Logfile -Value "IMMMEDIATELY CREATE THE WORKING DIRECTORY: $global:TDIR"            
PS_ckDirectory $global:TDIR $Logfile 
#**********************************************************************************************

$StartDate = Get-Date
$Msg = "Please standby, inventorying the Server Software, this can take a few minutes: $StartDate"
Write-Host $msg

InventorySoftware

Add-Content -Path $Logfile -Value "* $msg"
Add-Content -Path $Logfile -Value get-date

$XDIR = $global:TDIR + "\_InstalledSoftware.csv"
Write-Host "XDIR - '$XDIR'"

$StartDate = Get-Date


#*******************************************************************
#***** DEFINE THE REQUIRED VARIABLES  ******************************
#*******************************************************************

#Define the servers to be used
#$RepositoryServer = $global:slVars["RSVR"]
$RepositoryServer = $global:RSVR
Write-Host "RepositoryServer - '$RepositoryServer'"

$ServicesServer = $global:SSVR
Write-Host "ServicesServer - '$ServicesServer'"

$GatewayServer = $global:GATEWAYSVR
Write-Host "GatewayServer - '$GatewayServer'"

$OCRServer = $global:OCRSVR
Write-Host "OCRServer - '$OCRServer'"

$global:HIVESVR = $global:HIVESVR
Write-Host "global:HIVESVR - '$global:HIVESVR'"

$uPrompt = PromptUser "iFilter Installation" "IMPORTANT: Do the iFilters need to be installed now?"
if ($uPrompt -eq 0)
{
    Write-Host "Validating IIS applications."  
    SetupiFilters
    Write-Host "IIS applications validation complete"  
}

if ($Notify.Equals("1"))
{
    MessageBox("Searching for and setting the service/application endpoints")
}    

$DirConsoleArchiver = $global:TDIR +"\_ConsoleArchiver\"

$EndPointArchiver = $global:EndPointArchiver
$NewEndPointArchiver = $global:NewEndPointArchiver

$EndPointArchive = $global:EndPointArchive
$NewEndPointArchive = $global:NewEndPointArchive

$EndPointGateway = $global:EndPointGateway
$NewEndPointGateway = $global:NewEndPointGateway

$EndPointSearch = $global:EndPointSearch
$NewEndPointSearch = $global:NewEndPointSearch

Write-Host "EndPointArchiver - '$EndPointArchiver'"
Write-Host "EndPointArchive - '$EndPointArchive'"
Write-Host "EndPointGateway - '$EndPointGateway'"
Write-Host "EndPointSearch - '$EndPointSearch'"
Write-Host "NewEndPointArchiver - '$NewEndPointArchiver'"
Write-Host "NewEndPointArchive - '$NewEndPointArchive'"
Write-Host "NewEndPointGateway - '$NewEndPointGateway'"
Write-Host "NewEndPointSearch - '$NewEndPointSearch'"

Add-Content -Path $Logfile -Value "EndPointArchiver - '$EndPointArchiver'"
Add-Content -Path $Logfile -Value "EndPointArchive - '$EndPointArchive'"
Add-Content -Path $Logfile -Value "EndPointGateway - '$EndPointGateway'"
Add-Content -Path $Logfile -Value "EndPointSearch - '$EndPointSearch'"
Add-Content -Path $Logfile -Value "NewEndPointArchiver - '$NewEndPointArchiver'"
Add-Content -Path $Logfile -Value "NewEndPointArchive - '$NewEndPointArchive'"
Add-Content -Path $Logfile -Value "NewEndPointGateway - '$NewEndPointGateway'"
Add-Content -Path $Logfile -Value "NewEndPointSearch - '$NewEndPointSearch'"


$InputDirFQN = "C:\EcmSite"
$TextToFind = "108.61.17.163"
$ReplaceText = $global:RSVR
$Filter = "app.config"
Write-Host "@01 - finding '$TextToFind' -> replaceing with '$ReplaceText' "
GrepDirectory $InputDirFQN $TextToFind $ReplaceText $Filter

$Filter = "web.config"
GrepDirectory $InputDirFQN $TextToFind $ReplaceText $Filter

$Filter = "ServiceReferences.ClientConfig"
GrepDirectory $InputDirFQN $TextToFind $ReplaceText $Filter

$Filter = "MainPage.xaml.vb"
GrepDirectory $InputDirFQN $TextToFind $ReplaceText $Filter

$TextToFind = "Junebug1"
$ReplaceText = "xxxxxxx1"
$Filter = "app.config"
Write-Host "@01 - finding '$TextToFind' -> replaceing with '$ReplaceText' "
GrepDirectory $InputDirFQN $TextToFind $ReplaceText $Filter

$Filter = "web.config"
GrepDirectory $InputDirFQN $TextToFind $ReplaceText $Filter

$Filter = "ServiceReferences.ClientConfig"
GrepDirectory $InputDirFQN $TextToFind $ReplaceText $Filter

$Filter = "MainPage.xaml.vb"
GrepDirectory $InputDirFQN $TextToFind $ReplaceText $Filter

#********************************************************************
#* Schedule the Archive Task, but first install the Server Side OCR
if ($Notify.Equals("1"))
{
    MessageBox("Installing the Server Side OCR utility")
}    
#WDMXX
#*******************************************
InstallServerSideOFFICE2007
InstallServerSideOCR
#*******************************************

#$ServerSideOCRDownload = $global:TDIR +"\_ServerSideOCR\"
#$ServerSideOCRDownloadBAT = $global:TDIR +"\_ServerSideOCR\SetupBAT\"
#$ServerSideOCRDownloadSETUP = $global:TDIR +"\_ServerSideOCR\Setup\"

$DownLoadFQN = $ServerSideOCRDownloadBAT + "ServerSideOcr.bat"
if ((test-Path -path $DownLoadFQN))
 {
     xcopy $DownLoadFQN "C:\ECMOCR\*" /Y
     Write-Host "Created the Server Side OCR Batch file in directory C:\ECMOCR\ "  
 } 
 else 
 {
    xcopy $EcmOcrFQN "C:\ECMOCR\*" /Y
    Write-Host "Directory $DownLoadFQN exists."
 }


if ($Notify.Equals("1"))
{
    MessageBox("Scheduling the Server Side OCR utility to run every 10 minutes")
}    

#**************************************************************************************************
#* verify the existance of the task first.
    $compname = "localhost" 
    $Taskid = "ECMOCR" 
    $EcmOcrFQN = "C:\inetpub\wwwroot\ECMSaaS\_PSscripts\ServerSideOCR.bat"

    $bFlg = 0 
    try { 
        $schedule = new-object -com("Schedule.Service")  
    } catch { 
        Write-Warning "Schedule.Service COM Object not found, this script requires this object" 
        return 
    } 
    $ComputerName = $env:COMPUTERNAME
    $ComputerName = $compname
    $schedule.connect($ComputerName)  
    $tasks = $schedule.getfolder("\").gettasks(0) 
    $results = @() 
    $tasks | Foreach-Object { 
        $PSObject = New-Object PSObject 
        $PSObject | Add-Member -MemberType NoteProperty -Name 'Name' -Value $_.name 
        $PSObject | Add-Member -MemberType NoteProperty -Name 'Path' -Value $_.path 
        $PSObject | Add-Member -MemberType NoteProperty -Name 'State' -Value $_.state 
        $PSObject | Add-Member -MemberType NoteProperty -Name 'Enabled' -Value $_.enabled 
        $PSObject | Add-Member -MemberType NoteProperty -Name 'LastRunTime' -Value $_.lastruntime 
        $PSObject | Add-Member -MemberType NoteProperty -Name 'LastTaskResult' -Value $_.lasttaskresult 
        $PSObject | Add-Member -MemberType NoteProperty -Name 'NumberOfMissedRuns' -Value $_.numberofmissedruns 
        $PSObject | Add-Member -MemberType NoteProperty -Name 'NextRunTime' -Value $_.nextruntime 
        $PSObject | Add-Member -MemberType NoteProperty -Name 'Author' -Value ([regex]::split($_.xml,'<Author>|</Author>'))[1] 
        $PSObject | Add-Member -MemberType NoteProperty -Name 'UserId' -Value ([regex]::split($_.xml,'<UserId>|</UserId>'))[1] 
        $PSObject | Add-Member -MemberType NoteProperty -Name 'Description' -Value ([regex]::split($_.xml,'<Description>|</Description>'))[1] 
        $tName = $_.name 
        if ($tName.ToUpper().equals($Taskid.ToUpper()))
        {
           Write-Host -ForegroundColor Yellow  'OCR Task Scheduler found.'
            $bFlg = 1            
        }
    }

if ($bFlg -eq 0)
    {
    $uPrompt = PromptUser "OCR" "Would you like to implement the OCR schedule into SQL Server now?"
    if ($uPrompt -eq 0)
    {
        SetupOcrTask $ADMINUSER $ADMINPASSWORD $EcmOcrFQN
        Write-Host -ForegroundColor Yellow  "NOTICE: OCR Scheduler created on Local Server..."
    }        
    }
    else
    {
        Write-Host -ForegroundColor Yellow  "SKIPPING OCR Scheduler Install"
    }

#********************************************************************
Write-Host -ForegroundColor Yellow  "____________________________________________________________________"
Write-Host -ForegroundColor cyan    "                         Script Complete"
Write-Host -ForegroundColor Yellow  "____________________________________________________________________"

$Msg = "COMPLETED installing the Server Software @ $StartDate"
Write-Host -ForegroundColor Green  $msg
Add-Content -Path $Logfile -Value $msg

$Msg = "The script is done, please review the installation log '$Logfile' for possible errors."
Write-Host -ForegroundColor green  $msg

$uPrompt = PromptUser "Installation COMPLETE" "Would you like to open the logfile now?"
if ($uPrompt -eq 0)
{
    Start-Process notepad $Logfile
}

    
