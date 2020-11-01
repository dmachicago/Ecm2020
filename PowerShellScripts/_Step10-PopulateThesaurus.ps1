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

    #**********************************************************************************************************
    setConnectionStrings;
    #**********************************************************************************************************
    echo $global:GPW ;
    echo $global:globalPWFS ;
    echo $global:CSECMSecureLogin ;
    echo $global:CSECMREPO;
    echo $global:gECMGATEWAY;
    echo $global:gENCECMREPO;
    echo $global:gHELPDB;
    echo $Global:gECMFSENC ;
    echo $Global:gThesaurus;
    echo $Global:gECMGWAY ;
    echo $Global:gECMFS;
    echo $global:gECMREPO;
    echo $global:gHIVEDB;

$uPrompt = PromptUser "This will truncate the Thesaurus and all data, are you sure?"
if ($uPrompt -eq 1)
{
    cls
    Write-Host "XXXXX Exiting Script XXXXX"  
    exit
}

write-host $global:slVars

write-host "global:SSVer -> $global:SSVer"

# Reviev by Peter and Dale
if ($global:SSVer -eq "2012")
{
   Import-Module sqlps -DisableNameChecking
}
if ($global:SSVer -eq "2014")
{
   Import-Module sqlps -DisableNameChecking
}
if ($global:SSVer -eq "2017")
{
   Import-Module sqlps -DisableNameChecking
}
        

echo off
echo "Author: W. Dale Miller"
echo "Copyright @ March, 2017, all rights reserved."
$Logfile = "C:\temp\_ECM.Install.Step10.LOG.txt"                

Write-Host "Step 10 - Thesaurus Data update"
Add-Content -Path $Logfile -Value "Start of STEP:10 - DB Installation - $currdate"
Set-Content -Path $Logfile -Value "New Logfile - Created: $currdate."

cd $ScriptDir
#***************************************************************************************
#**** Set the execution policy to allow this machine to run scripts. *******************
#***************************************************************************************
Set-ExecutionPolicy unrestricted –Force
Enable-PSRemoting -Force

Write-Host "Loading Web-Administration module, standby please - this could take several minutes..."
Load-Web-Administration

Write-Host "Loading Thesaursus data, standby please - this could take several minutes..."

$CurrUser = [System.Security.Principal.WindowsIdentity]::GetCurrent().Name
$StartDate = Get-Date
$msg = "*** Run initiated by: $CurrUser"

#**********************************************************************************************
#**** IMMMEDIATELY CREATE THE WORKING DIRECTORY
Add-Content -Path $Logfile -Value "IMMMEDIATELY CREATE THE WORKING DIRECTORY: $global:TDIR"            
PS_ckDirectory $global:TDIR $Logfile 
#**********************************************************************************************

#$db = "ECM.Library.FS"
#$ThesaurusDataFQN = "C:\_ECMTEMP\_DBScripts\_ECM.Library.FS.initial.Data.sql"
#Invoke-Sqlcmd -database $db  -server $svr -Username "sa" -password "Junebug1" -InputFile  $ThesaurusDataFQN 

$db = "ECM.Thesaurus"
$ThesaurusDataFQN = "C:\_ECMTEMP\_DBScripts\_ECM.Thesaurus.Table.And.Data.Creation.sql"
$uid = "sa"
$pw = "Junebug1"
$svr = "SVR2016"

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

#Invoke-Sqlcmd -InputFile "C:\ScriptFolder\TestSqlCmd.sql" | Out-File -FilePath "C:\ScriptFolder\TestSqlCmd.rpt"