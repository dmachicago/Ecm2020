try{
    Set-ExecutionPolicy RemoteSigned
}
catch {
    echo ("Caught the exception")
    echo ($Error[0].Exception)
    echo "Continuing..."
}

Set-ExecutionPolicy unrestricted –Force
Enable-PSRemoting -Force

$global:EncVal= "" ;
#********************************************************************************
#* The execution path to CmdEncrypt could be in different 
#* places on depending upon installation. We use the default path here.
$global:CmdEncryptPATH = "C:\Program Files (x86)\ECM Library\CmdEncrypt\" ;
$global:CmdEncryptEXE = "C:\Program Files (x86)\ECM Library\CmdEncrypt\_EncryptString.exe" ;


function encryptConnStrings($phrase)
{
    if ($phrase.length -eq 0){
        $global:EncVal= "" ;
        $EncVal = "";
        return "";
    }
    $global:EncVal= "" ;
    $i = 0 ;
    $fqn = "c:\temp\enc.dat";
    $EncVal = "" ;
    if ($phrase.contains(" ")) {
        $arg = '"' + $phrase + '"';
    }
    else {
        $arg = $phrase ;
    }
    & $global:CmdEncryptEXE $arg
    $DB = Get-Content $fqn
    foreach ($Data in $DB) {
        #write-host $phrase;
        write-host $data;
        if ($i = 1){
            $global:EncVal= $data ;
            $EncVal = $data;
        }
        $i = $i +1;
    }

    return $EncVal;
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

    $uPrompt = PromptUser "This will truncate the Secure Server data, are you sure?"
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
$Logfile = "C:\temp\_ECM.Install.Step11.LOG.txt"                

Write-Host "Step 11 - Secuew Server Data update"
Add-Content -Path $Logfile -Value "Start of STEP:11 - Data Update - $currdate"
Set-Content -Path $Logfile -Value "New Logfile - Created: $currdate."

cd $ScriptDir
#***************************************************************************************
#**** Set the execution policy to allow this machine to run scripts. *******************
#***************************************************************************************

Write-Host "Loading Web-Administration module, standby please - this could take several minutes..."
Load-Web-Administration

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

$db = "ECM.SecureLogin"
$uid = "sa"
$pw = "Junebug1"
$svr = "SVR2016"

$qry = "SELECT T.name AS [TABLE NAME], I.rows AS [ROWCOUNT] FROM   sys.tables AS T INNER JOIN sys.sysindexes AS I ON T.object_id = I.id AND I.indid < 2 ORDER  BY I.rows DESC; "
Invoke-Sqlcmd -database $db  -server $svr -Username $uid -password $pw -Query $qry

Invoke-Sqlcmd -database $db  -server $svr -Username $uid -password $pw -Query "Truncate table ActiveLogin;"
Invoke-Sqlcmd -database $db  -server $svr -Username $uid -password $pw -Query "Truncate table ActiveSession;"
Invoke-Sqlcmd -database $db  -server $svr -Username $uid -password $pw -Query "Truncate table SecureAttach;"
Invoke-Sqlcmd -database $db  -server $svr -Username $uid -password $pw -Query "Truncate table SessionID;"
Invoke-Sqlcmd -database $db  -server $svr -Username $uid -password $pw -Query "Truncate table [User];"

$qry = "SELECT T.name AS [TABLE NAME], I.rows AS [ROWCOUNT] FROM   sys.tables AS T INNER JOIN sys.sysindexes AS I ON T.object_id = I.id AND I.indid < 2 ORDER  BY I.rows DESC; "
Invoke-Sqlcmd -database $db  -server $svr -Username $uid -password $pw -Query $qry

#*********************************************************************************************
#** FILL OUT ONE SET OF DATA FOR EACH ENTRY INTO THE SECURE SERVER
#*********************************************************************************************
#* Required passwords needed to be encrypted
$CompanyID = "PA"
$RepoID = "BLDG-1300"
$GPW = 'pclJunebug1';
$PWFS = 'pclJunebug1';
$CSECMSecureLogin= "Data Source=SVR2016;Initial Catalog=ECM.SecureLogin;Persist Security Info=True;User ID=ecmlibrary;Password=@@PW@@; Timeout=30;";
$CSECMREPO = "Data Source=SVR2016;Initial Catalog=ECM.Library.FS;Persist Security Info=True;User ID=ecmlibrary;Password=@@PW@@; Timeout=30;" ;
$ECMGATEWAY = "Data Source=SVR2016;Initial Catalog=ECM.SecureLogin;Persist Security Info=True;User ID=ecmlibrary;Password=pclJunebug1; Connect Timeout = 30;" ;
$ENCECMREPO = "Data Source=SVR2016;Initial Catalog=ECM.Library.FS;Persist Security Info=True;User ID=ecmlibrary;Password=pclJunebug1; Connect Timeout = 30;";
$HELPDB = "Data Source=ecmadmin.db.3591434.hostedresource.com; Initial Catalog=ecmadmin; User ID=ecmadmin; Password='Junebug1';" ;
$ECMFSENC = "Data Source=SVR2016;Initial Catalog=Ecm.Library.FS;Persist Security Info=True;User ID=ecmlibrary;Password=pclJunebug1;  Connect Timeout =  30;" ;
$Thesaurus = "Data Source=SVR2016;Initial Catalog=ECM.Thesaurus;Persist Security Info=True;User ID=ecmlibrary;Password=pclJunebug1;  Connect Timeout =  30;" ;
$HIVEDB = "Data Source=SVR2016;Initial Catalog=ECM.Hive;Persist Security Info=True;User ID=ecmlibrary;Password=pclJunebug1;  Connect Timeout =  30; " ;
$TDRDB = "Data Source=SVR2016;Initial Catalog=TDR;Persist Security Info=True;User ID=ecmlibrary;Password=pclJunebug1;  Connect Timeout =  30; " ;
$K3DB = "Data Source=SVR2016;Initial Catalog=K3;Persist Security Info=True;User ID=ecmlibrary;Password=pclJunebug1;  Connect Timeout =  30; " ;
$SVCFS_Endpoint = "http://SVR2016/Archivefs/SVCFS.svc" 
$SVCGateway_Endpoint = "http://SVR2016/SecureAttachAdminSvc/SVCGateway.svc" 
$SVCCLCArchive_Endpoint = "http://SVR2016/archive/SVCCLCArchive.svc" 
$SVCSearch_Endpoint = "http://SVR2016/Search/SVCSearch.svc" 
$SVCDownload_Endpoint = "http://SVR2016/SVCclcDownload/SVCclcDownload.svc" 
#*********************************************************************************************
$EncECMGATEWAY = encryptConnStrings($ECMGATEWAY);
$EncECMGATEWAY = $global:EncVal ;
$EncK3DB = encryptConnStrings($K3DB);
$EncK3DB = $global:EncVal ;
$EncTDRDB = encryptConnStrings($TDRDB);
$EncTDRDB = $global:EncVal ;
$EncGPW = encryptConnStrings($GPW);
$EncGPW = $global:EncVal ;
$EncPWFS = encryptConnStrings($PWFS);
$EncPWFS = $global:EncVal ;
$EncCSECMSecureLogin = encryptConnStrings($CSECMSecureLogin);
$EncCSECMSecureLogin = $global:EncVal ;
$EncCSECMREPO = encryptConnStrings($ENCECMREPO);
$EncCSECMREPO = $global:EncVal ;
$EncHELPDB = encryptConnStrings($HELPDB);
$EncHELPDB  = $global:EncVal ;
$EncECMFSENC = encryptConnStrings($ECMFSENC);
$EncECMFSENC  = $global:EncVal ;
$EncThesaurus = encryptConnStrings($Thesaurus);
$EncThesaurus  = $global:EncVal ;
$EncHIVEDB = encryptConnStrings($HIVEDB);
$EncHIVEDB  = $global:EncVal ;
#*********************************************************************************************
$qry = "insert into [SecureAttach] (CompanyID, RepoID, EncPW, CS) values ('$CompanyID', '$RepoID', '$EncGPW', '$EncCSECMSecureLogin'); "
echo $qry ;
Invoke-Sqlcmd -database $db  -server $svr -Username $uid -password $pw -Query $qry

$qry = "update [SecureAttach] set CSTDR = '$EncTDRDB' where CompanyID = '$CompanyID' and RepoID = '$RepoID' ;";
echo $qry ;
Invoke-Sqlcmd -database $db  -server $svr -Username $uid -password $pw -Query $qry

$qry = "update [SecureAttach] set CSKbase = '$EncK3DB' where CompanyID = '$CompanyID' and RepoID = '$RepoID' ;";
echo $qry ;
Invoke-Sqlcmd -database $db  -server $svr -Username $uid -password $pw -Query $qry

$qry = "update [SecureAttach] set CS = '$EncECMGATEWAY' where CompanyID = '$CompanyID' and RepoID = '$RepoID' ;";
echo $qry ;
Invoke-Sqlcmd -database $db  -server $svr -Username $uid -password $pw -Query $qry

$qry = "update [SecureAttach] set CSRepo = '$EncCSECMREPO' where CompanyID = '$CompanyID' and RepoID = '$RepoID' ;";
echo $qry ;
Invoke-Sqlcmd -database $db  -server $svr -Username $uid -password $pw -Query $qry

$qry = "update [SecureAttach] set CSThesaurus = '$EncThesaurus' where CompanyID = '$CompanyID' and RepoID = '$RepoID' ;";
echo $qry ;
Invoke-Sqlcmd -database $db  -server $svr -Username $uid -password $pw -Query $qry

$qry = "update [SecureAttach] set CSHive = '$EncHIVEDB' where CompanyID = '$CompanyID' and RepoID = '$RepoID' ;";
echo $qry ;
Invoke-Sqlcmd -database $db  -server $svr -Username $uid -password $pw -Query $qry

$qry = "update [SecureAttach] set CSGateWay = '$EncECMGATEWAY' where CompanyID = '$CompanyID' and RepoID = '$RepoID' ;";
echo $qry ;
Invoke-Sqlcmd -database $db  -server $svr -Username $uid -password $pw -Query $qry

$qry = "update [SecureAttach] set SVCFS_Endpoint = '$SVCFS_Endpoint' where CompanyID = '$CompanyID' and RepoID = '$RepoID' ;";
Invoke-Sqlcmd -database $db  -server $svr -Username $uid -password $pw -Query $qry

$qry = "update [SecureAttach] set SVCGateway_Endpoint = '$SVCGateway_Endpoint' where CompanyID = '$CompanyID' and RepoID = '$RepoID' ;";
Invoke-Sqlcmd -database $db  -server $svr -Username $uid -password $pw -Query $qry

$qry = "update [SecureAttach] set SVCCLCArchive_Endpoint = '$SVCCLCArchive_Endpoint' where CompanyID = '$CompanyID' and RepoID = '$RepoID' ;";
Invoke-Sqlcmd -database $db  -server $svr -Username $uid -password $pw -Query $qry

$qry = "update [SecureAttach] set SVCSearch_Endpoint = '$SVCSearch_Endpoint' where CompanyID = '$CompanyID' and RepoID = '$RepoID' ;";
Invoke-Sqlcmd -database $db  -server $svr -Username $uid -password $pw -Query $qry

$qry = "update [SecureAttach] set SVCDownload_Endpoint = '$SVCDownload_Endpoint' where CompanyID = '$CompanyID' and RepoID = '$RepoID' ;";
Invoke-Sqlcmd -database $db  -server $svr -Username $uid -password $pw -Query $qry

#*********************************************************************************************
#*********************************************************************************************