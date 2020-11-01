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
    $global:RSVR
    $global:SSVer = ""
    $global:tokens = ""
    $global:token = ""
    $global:tVal= ""
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

    $data = Get-Content "$ScriptDir\\ECM.PS.VARS.txt"
    $global:slVars = LoadSetupVars
    $currdate = get-date
    $Notify = 1 ;

        write-host $global:slVars

# Reviev by Peter and Dale
if ($global:SSVer -eq "2012")
{
   Import-Module sqlps -DisableNameChecking
}
if ($global:SSVer -eq "2014")
{
   Import-Module sqlps -DisableNameChecking
}
if ($global:SSVer -eq "2016")
{
   Import-Module sqlps -DisableNameChecking
}
        

echo off
echo "Author: W. Dale Miller"
echo "Copyright @ March, 2017, all rights reserved."
$Logfile = "C:\temp\_ECM.Install.Step4.LOG.txt"                

Write-Host "Step 4 - DB installation"
Add-Content -Path $Logfile -Value "Start of STEP:4 - DB Installation - $currdate"
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

$ADMINUSER = $global:ADMINUSER
$ADMINPASSWORD = $global:ADMINPASSWORD

$OcrSVR = $global:OCRSVR
$SqlSvrDataDir = $global:SQLSVRDATADIR
$HIVESVR = $global:HIVESVR
$REPOSITORY_SVR = $global:RSVR

Write-Host "REPOSITORY_SVR - '$REPOSITORY_SVR'"

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

#*******************************************************************
#***** DEFINE THE REQUIRED VARIABLES  ******************************
#*******************************************************************

#Define the servers to be used
#$RepositoryServer = $global:slVars["RSVR"]
$RepositoryServer = $global:RSVR
Write-Host "RepositoryServer: $RepositoryServer"

$ServicesServer = $global:SSVR
Write-Host "ServicesServer: $ServicesServer"

$GatewayServer = $global:GATEWAYSVR
Write-Host "GatewayServer: $GatewayServer"

$OCRServer = $global:OCRSVR
Write-Host "OCRServer: $OCRServer"

$global:HIVESVR = $global:HIVESVR
Write-Host "global:HIVESVR: $global:HIVESVR"


#********************************************************************************************************

if ($Notify.Equals("1"))
{
    MessageBox("validating the SQL Server Setup")
}



#********************************************************************************************************
#****** CREATE THE ECM DATABASES ************************************************************************
#********************************************************************************************************
#Execute all SQL files in a Directory with Powershell
#$RSvr = "T410B\GINA"

#$RepoDBNAME = "ECM.Library.FS"
#Invoke-Sqlcmd -Username $global:UNAME -Password $global:PW -Query "SELECT GETDATE() AS TimeOfQuery;" -ServerInstance $global:RSVR -Database $global:REPODBNAME

foreach ($f in Get-ChildItem -path $DirDBScripts -Filter *.sql | sort-object)
{
    Write-Host "Preparing DB Script: " $f.Name 
}
#foreach ($f in Get-ChildItem -path $DirDBScripts -Filter *.sql | sort-object)
#{
#    Write-Host "Processing DB Script: " $f.Name
#    $out = "C:\_DBScripts\" + $f.name.split(".")[0] + ".LOG.txt" ;
#    Invoke-Sqlcmd -InputFile $f.fullname -Username sa -Password Junebug1 -ServerInstance $global:RSVR -Database $global:REPODBNAME | format-table | out-file -filePath $out
#}
#********************************************************************************************************

Write-Host "RSVR = $global:RSVR"
Write-Host "UNAME = $global:UNAME"
Write-Host "PWD = $PWD" , $global:PW
Write-Host "REPODBNAME = $global:REPODBNAME"
Write-Host "TDIR = $global:TDIR"


#Remove-Item $global:TDIR + "\*.csv"

$RSVRExists = ckDbExists $global:RSVR $global:UNAME $global:PW $global:REPODBNAME $global:TDIR
$THESAURUSDBNAMEexist = ckDbExists $global:THESAURUSSVR $global:UNAME $global:PW $global:THESAURUSDBNAME $global:TDIR
$GATEWAYDBNAMEexist = ckDbExists $global:GATEWAYSVR $global:UNAME $global:PW $global:GATEWAYDBNAME $global:TDIR
$SECURELOGINDBNAMEexist = ckDbExists $global:SECURELOGINSVR $global:UNAME $global:PW $global:SECURELOGINDBNAME $global:TDIR
$LANGUAGEDBNAMEexist = ckDbExists $global:LANGUAGESVR $global:UNAME $global:PW $LANGUAGEDBNAME $global:TDIR
$HIVEDBNAMEexist = ckDbExists $global:HIVESVR $global:UNAME $global:PW $global:HIVEDBNAME $global:TDIR
$TDRDBNAMEexist = ckDbExists $global:TDRSVR $global:UNAME $global:PW $global:TDRDBNAME $global:TDIR

Write-Host "THESAURUSDBNAMEexist = $THESAURUSDBNAMEexist"
Write-Host "GATEWAYDBNAMEexist = $GATEWAYDBNAMEexist"
Write-Host "SECURELOGINDBNAMEexist = $SECURELOGINDBNAMEexist"
Write-Host "LANGUAGEDBNAMEexist = $LANGUAGEDBNAMEexist"
Write-Host "HIVEDBNAMEexist = $HIVEDBNAMEexist"
Write-Host "TDRDBNAMEexist = $TDRDBNAMEexist"

#***** CREATE THE DATABASES IF MISSING ******
$DBRC = CreateDB ($THESAURUSDBNAMEexist, $global:THESAURUSSVR, $global:THESAURUSDBNAME)
if ($DBRC -eq 1)
{
    Write-Host "$THESAURUSDBNAME DATABASE Created, building the tables."
    $SQLScript = $global:TDIR + "\_DBScripts\10.0.0.12.ECM.Thesaurus.sql"
    runSqlScript $SQLScript $global:THESAURUSSVR $global:THESAURUSDBNAME $global:UNAME $global:PW  
    
    $db = "ECM.Thesaurus"
    $ThesaurusDataFQN = $global:TDIR + "\_DBScripts\_ECM.Thesaurus.Table.And.Data.Creation.sql"
    $uid = $global:UNAME
    $pw = $global:PW  
    $svr = $global:THESAURUSSVR

    $qry = "SELECT T.name AS [TABLE NAME], I.rows AS [ROWCOUNT] FROM   sys.tables AS T INNER JOIN sys.sysindexes AS I ON T.object_id = I.id AND I.indid < 2 ORDER  BY I.rows DESC; "
    Invoke-Sqlcmd -database $db  -server $svr -Username $uid -password $pw -Query $qry

    Invoke-Sqlcmd -database $db  -server $svr -Username $uid -password $pw -Query "Truncate table Calssonomy;"
    Invoke-Sqlcmd -database $db  -server $svr -Username $uid -password $pw -Query "Truncate table ClassonomyData;"
    Invoke-Sqlcmd -database $db  -server $svr -Username $uid -password $pw -Query "Truncate table KbItem;"
    Invoke-Sqlcmd -database $db  -server $svr -Username $uid -password $pw -Query "Truncate table KbItemGraphic;"
    Invoke-Sqlcmd -database $db  -server $svr -Username $uid -password $pw -Query "Truncate table KbProduct;"
    Invoke-Sqlcmd -database $db  -server $svr -Username $uid -password $pw -Query "Truncate table KbResp;"
    Invoke-Sqlcmd -database $db  -server $svr -Username $uid -password $pw -Query "Truncate table KbRespGraphic;"
    Invoke-Sqlcmd -database $db  -server $svr -Username $uid -password $pw -Query "Truncate table KbToken;"
    Invoke-Sqlcmd -database $db  -server $svr -Username $uid -password $pw -Query "Truncate table kbUser;"
    Invoke-Sqlcmd -database $db  -server $svr -Username $uid -password $pw -Query "Truncate table License;"
    Invoke-Sqlcmd -database $db  -server $svr -Username $uid -password $pw -Query "Truncate table LicenseType;"
    Invoke-Sqlcmd -database $db  -server $svr -Username $uid -password $pw -Query "Truncate table LoadProfile;"
    Invoke-Sqlcmd -database $db  -server $svr -Username $uid -password $pw -Query "Truncate table LoadProfileItem;"
    Invoke-Sqlcmd -database $db  -server $svr -Username $uid -password $pw -Query "Truncate table Machine;"
    Invoke-Sqlcmd -database $db  -server $svr -Username $uid -password $pw -Query "Truncate table RecordedStats;"
    Invoke-Sqlcmd -database $db  -server $svr -Username $uid -password $pw -Query "Truncate table RegisteredUser;"
    Invoke-Sqlcmd -database $db  -server $svr -Username $uid -password $pw -Query "Truncate table Response;"
    Invoke-Sqlcmd -database $db  -server $svr -Username $uid -password $pw -Query "Truncate table RespToken;"
    Invoke-Sqlcmd -database $db  -server $svr -Username $uid -password $pw -Query "Truncate table Retention;"
    Invoke-Sqlcmd -database $db  -server $svr -Username $uid -password $pw -Query "Truncate table RootChildren;"
    Invoke-Sqlcmd -database $db  -server $svr -Username $uid -password $pw -Query "Truncate table Rootword;"
    Invoke-Sqlcmd -database $db  -server $svr -Username $uid -password $pw -Query "Truncate table Search1;"
    Invoke-Sqlcmd -database $db  -server $svr -Username $uid -password $pw -Query "Truncate table Search2;"
    Invoke-Sqlcmd -database $db  -server $svr -Username $uid -password $pw -Query "Truncate table Severity;"
    Invoke-Sqlcmd -database $db  -server $svr -Username $uid -password $pw -Query "Truncate table SkipToken;"
    Invoke-Sqlcmd -database $db  -server $svr -Username $uid -password $pw -Query "Truncate table SourceType;"
    Invoke-Sqlcmd -database $db  -server $svr -Username $uid -password $pw -Query "Truncate table Status;"
    Invoke-Sqlcmd -database $db  -server $svr -Username $uid -password $pw -Query "Truncate table Subject;"
    Invoke-Sqlcmd -database $db  -server $svr -Username $uid -password $pw -Query "Truncate table SupportRequest;"
    Invoke-Sqlcmd -database $db  -server $svr -Username $uid -password $pw -Query "Truncate table SupportResponse;"
    Invoke-Sqlcmd -database $db  -server $svr -Username $uid -password $pw -Query "Truncate table SupportUser;"
    Invoke-Sqlcmd -database $db  -server $svr -Username $uid -password $pw -Query "Truncate table Synonyms;"
    Invoke-Sqlcmd -database $db  -server $svr -Username $uid -password $pw -Query "Truncate table SystemParms;"
    Invoke-Sqlcmd -database $db  -server $svr -Username $uid -password $pw -Query "Truncate table SystemUser;"
    Invoke-Sqlcmd -database $db  -server $svr -Username $uid -password $pw -Query "Truncate table TempGuids;"
    Invoke-Sqlcmd -database $db  -server $svr -Username $uid -password $pw -Query "Truncate table Thesaurus;"
    Invoke-Sqlcmd -database $db  -server $svr -Username $uid -password $pw -Query "Truncate table ThesaurusTokens;"
    Invoke-Sqlcmd -database $db  -server $svr -Username $uid -password $pw -Query "Truncate table Token;"
    Invoke-Sqlcmd -database $db  -server $svr -Username $uid -password $pw -Query "Truncate table Tokens;"
    Invoke-Sqlcmd -database $db  -server $svr -Username $uid -password $pw -Query "Truncate table xLog;"

    Invoke-Sqlcmd -database $db  -server $svr -Username "sa" -password "Junebug1" -InputFile  $ThesaurusDataFQN 

    $qry = "SELECT T.name AS [TABLE NAME], I.rows AS [ROWCOUNT] FROM   sys.tables AS T INNER JOIN sys.sysindexes AS I ON T.object_id = I.id AND I.indid < 2 ORDER  BY I.rows DESC; "
    Invoke-Sqlcmd -database $db  -server $svr -Username $uid -password $pw -Query $qry
     
}

$DBRC = CreateDB ($GATEWAYDBNAMEexist, $global:GATEWAYSVR, $global:GATEWAYDBNAME)
if ($DBRC -eq 1)
{
    Write-Host "$GATEWAYDBNAME DATABASE Created, building the tables."
    $SQLScript = $global:TDIR + "\_DBScripts\10.0.0.12.EcmGateway.sql"
    runSqlScript $SQLScript $global:GATEWAYSVR $global:GATEWAYDBNAME $global:UNAME $global:PW   
}

$DBRC = CreateDB ($SECURELOGINDBNAMEexist, $global:SECURELOGINSVR, $global:SECURELOGINDBNAME)
if ($DBRC -eq 1)
{
    Write-Host "$SECURELOGINDBNAME DATABASE Created, building the tables."
    $SQLScript = $global:TDIR + "\_DBScripts\10.0.0.12.ECM.Language.sql"
    runSqlScript $SQLScript $global:SECURELOGINSVR $global:SECURELOGINDBNAME $global:UNAME $global:PW   
}

$DBRC = CreateDB ($LANGUAGEDBNAMEexist, $global:LANGUAGESVR, $global:LANGUAGEDBNAME)
if ($DBRC -eq 1)
{
    Write-Host "$LANGUAGEDBNAME DATABASE Created, building the tables."
    $SQLScript = $global:TDIR + "\_DBScripts\10.0.0.12.ECM.Language.sql"
    runSqlScript $SQLScript $global:LANGUAGESVR $global:LANGUAGEDBNAME $global:UNAME $global:PW   
}

$DBRC = CreateDB ($TDRDBNAMEexist, $global:TDRSVR, $global:TDRDBNAME)
if ($DBRC -eq 1)
{
    Write-Host "$LANGUAGEDBNAME DATABASE Created, building the tables."
    $SQLScript = $global:TDIR + "\_DBScripts\10.0.0.12.TDR.sql"
    runSqlScript $SQLScript $global:TDRSVR $global:TDRDBNAME $global:UNAME $global:PW   
}

$DBRC = CreateDB ($HIVEDBNAMEexist, $global:HIVESVR, $global:HIVEDBNAME)
if ($DBRC -eq 1)
{
    Write-Host "$HIVEDBNAME DATABASE Created, building the tables."
    $SQLScript = $global:TDIR + "\_DBScripts\10.0.0.12.ECM.Hive.sql"
    runSqlScript $SQLScript $ServerInstanceName $DataBaseName $global:UNAME $global:PW   
}

Write-Host "Creating main repository, standby."
$RSVRExists = ckDbExists $global:RSVR $global:UNAME $global:PW $global:REPODBNAME $global:TDIR

$DBRC = CreateDB ($RSVRExists, $global:RSVR, $global:REPODBNAME)
if ($DBRC -eq 1)
{
    Write-Host "$HIVEDBNAME DATABASE Created, building the tables."
    $SQLScript = $global:TDIR + "\_DBScripts\10.0.0.12.ECM.Library.FS.sql"
    Invoke-Sqlcmd -database $global:REPODBNAME -server $global:RSVR -Username $global:UNAME -password $global:PW -InputFile  $SQLScript

    $SQLScript = $global:TDIR + "\_DBScripts\_ECM.Library.FS.initial.Data.sql"
    Invoke-Sqlcmd -database $global:REPODBNAME -server $global:RSVR -Username $global:UNAME -password $global:PW -InputFile  $SQLScript
}

if ($Notify.Equals("1"))
{
    MessageBox("Verifying $global:RSVR has FULL TEXT and FILE STREAM enabled")
}    
    
$FS = PS_ckFileStreamInstalled $global:RSVR $global:UNAME $global:PW $global:REPODBNAME $global:TDIR
$FT = PS_ckFullTextInstalled $global:RSVR $global:UNAME $global:PW $global:REPODBNAME $global:TDIR

if ($FS.Equals("1") -or  $FS.Equals("2") )
{
    Write-Host -ForegroundColor cyan "FILE Streaming is enabled - continuing."
    Add-Content -Path $Logfile -Value "FILE Streaming is enabled - continuing."
}
Else
{
    Write-Host  -ForegroundColor red "FATAL ERROR: FILE Streaming NOT is enabled - aborting."
    $ans = PromptUser("FATAL ERROR!", "It appears that SQL Server FileStream is not enabled.")
    if ($ans = "N")
    {
        Add-Content -Path $Logfile -Value "File Streaming is NOT enabled - aborting by user choice."
        exit
    }
    else 
    {
        Add-Content -Path $Logfile -Value "File Streaming is NOT enabled - continuing by user choice."
    }
}
if ($FT.Equals("1") ){
    Write-Host  -ForegroundColor cyan "FULL Text is enabled - continuing."
    Add-Content -Path $Logfile -Value "FULL Text is enabled - continuing."
}
Else
{
    Write-Host  -ForegroundColor red "FATAL ERROR: FULL Text is NOT enabled - continuing."
    $ans = PromptUser("FATAL ERROR!", "It appears that SQL Server Full Text is not enabled.")
    if ($ans = "N")
    {
        Add-Content -Path $Logfile -Value "FULL Text is enabled - aborting."
        exit
    }
    else
    {
        Add-Content -Path $Logfile -Value "FULL Text is enabled - continuing by user choice."
    }
}

#$nl = [Environment]::NewLine
#$msg = "THE MOST CRITICAL PORTION OF THE INSTALL IS THE CREATION OF THE REPOSITORY:" + $nl 
#$msg = $msg + " "  + $nl 
#$msg = "Please open SQL Server Management Studio and execute these three scripts in this order: " + $nl 
#$msg = $msg + "  1 - CreateDbECM.Library.FS.sql " + $nl 
#$msg = $msg + "  2 - ECM.Library.FS.sql" + $nl 
#$msg = $msg + "  3 - ECM.Library.FS.initial.Data.sql" + $nl 
#$msg = $msg + " "  + $nl 
#$msg = $msg + "They can be found in the directory C:\_ECMTEMP\_DBScripts "  + $nl 

#PromptUser "NOTICE" $msg

if ($Notify.Equals("1"))
{
    MessageBox("Creating the IIS web services")
}    

#****  ADD THE IIS SERVICES ****
ExpandWebServices


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

    
