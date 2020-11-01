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
if ($global:SSVer -eq "2016")
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

Write-Host "Step 9a - Populate Secure Server Logins"
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
#**** HOW TO POPULATE THE USER TABLE
#/****** Script for SelectTopNRows command from SSMS  ******/
#SELECT 'Insert into [User] ([UserID], UserPW) values (''' + [UserName] + ''',''' + UserPassword + ''')' +char(10) + 'go'
#  FROM [ECM.Library.FS].[dbo].[Users]
#
#Insert into [User] ([UserID], UserPW) values ('administrator','GkXH52Yhh038Remo1wUdMQ==')
#go
#Insert into [User] ([UserID], UserPW) values ('SYSOCR Name2','GkXH52Yhh038Remo1wUdMQ==')
#go
#Insert into [User] ([UserID], UserPW) values ('SYSTEM','GkXH52Yhh038Remo1wUdMQ==')
#go
#Insert into [User] ([UserID], UserPW) values ('Dale Miller','GkXH52Yhh038Remo1wUdMQ==')
#go

#**********************************************************************************************
#**** IMMMEDIATELY CREATE THE WORKING DIRECTORY
Add-Content -Path $Logfile -Value "IMMMEDIATELY CREATE THE WORKING DIRECTORY: $global:TDIR"            
PS_ckDirectory $global:TDIR $Logfile 
#**********************************************************************************************

#$db = "ECM.Library.FS"
#$ThesaurusDataFQN = "C:\_ECMTEMP\_DBScripts\_ECM.Library.FS.initial.Data.sql"
#Invoke-Sqlcmd -database $db  -server $svr -Username "sa" -password "Junebug1" -InputFile  $ThesaurusDataFQN 

$db = "ECM.SecureLogin"
$ThesaurusDataFQN = "C:\_ECMTEMP\_DBScripts\_ECM.SecureLogin.Table.And.Data.Creation.sql"
$uid = "sa"
$pw = "Junebug1"
$svr = "SVR2016"

$qry = "SELECT T.name AS [TABLE NAME], I.rows AS [ROWCOUNT] FROM   sys.tables AS T INNER JOIN sys.sysindexes AS I ON T.object_id = I.id AND I.indid < 2 ORDER  BY I.rows DESC; "
Invoke-Sqlcmd -database $db  -server $svr -Username $uid -password $pw -Query $qry

Invoke-Sqlcmd -database $db  -server $svr -Username $uid -password $pw -Query "Truncate table ActiveLogin;"
Invoke-Sqlcmd -database $db  -server $svr -Username $uid -password $pw -Query "Truncate table ActiveSession;"
Invoke-Sqlcmd -database $db  -server $svr -Username $uid -password $pw -Query "Truncate table SecureAttach;"
Invoke-Sqlcmd -database $db  -server $svr -Username $uid -password $pw -Query "Truncate table SessionID;"
Invoke-Sqlcmd -database $db  -server $svr -Username $uid -password $pw -Query "Truncate table User;"

Invoke-Sqlcmd -database $db  -server $svr -Username "sa" -password "Junebug1" -InputFile  $ThesaurusDataFQN 

$qry = "INSERT INTO [dbo].[User]
        ([UserID],[UserPW],[CreateDate]) VALUES ('ecmuser','ecmuserpassword',getdate())"

Invoke-Sqlcmd -database $db  -server $svr -Username $uid -password $pw -Query $qry
