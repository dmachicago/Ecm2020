#*************************************************************************************************************
#Last Modification Date: Feb, 1, 2014
#Developed by W. Dale Miller
#Tested by Peter Asplund
#Search for "Enter Execution Variables Here" and fill in the execution variables and execute the program.
#Search for "SET CONNECTION STRINGS" and complete each one - CRITICAL Step
#Changes:
#2/1/2013 -  None to date
#*************************************************************************************************************

try{
    Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
}
catch {
    echo ("Caught the exception")
    echo ($Error[0].Exception)
    echo "Continuing..."
}
try{
    Set-ExecutionPolicy Unrestricted -Scope CurrentUser
}
catch {
    echo ("Caught the exception")
    echo ($Error[0].Exception)
    echo "Continuing..."
}

Get-ExecutionPolicy -List


$global:slVars = new-object system.collections.SortedList
#**********************************************************************************
# IT IS CRITICAL TO SET THESE VARIABES CORRECTLY IN EACH STEP
#**********************************************************************************
#Enter the Repository SQL Server and Instance name here
#$Global:DBDNS = "SVR2016" ;
$Global:DBDNS = "192.168.0.13" ;

#Enter the Services server here
#$Global:SVCDNS = "SVR2016" ;
$Global:SVCDNS = "192.168.0.13" ;
#**********************************************************************************
$global:UserID = "ecmuser" ;
$global:UserPW = "Junebug1" ;
#**********************************************************************************
#The directory that will hold the time-date backups
$global:BackupDir = "c:\temp\EcmBackup" ;
#The working directory 
$global:TempDir = "c:\temp\Configs\" ;
#The temp file that will hold the GREP and Replaced Data
$global:TestFile = "c:\temp\Test.Config" ;
#**********************************************************************************
#** When needed, turn on to review each file
$global:OpenNotepad = "N" ;
#**********************************************************************************
$PSScriptDir = "C:\inetpub\wwwroot\ECMSaaS\_PSscripts"
$SoftwareDir  = "C:\inetpub\wwwroot\ECMSaaS\_Software"
Import-Module -Name "$PSScriptDir\PS_ECM_FunctionsV2.ps1"
Import-Module -Name "$PSScriptDir\LoadExecutionVars.ps1"
#**********************************************************************************
$data = Get-Content "$PSScriptDir\ECM.PS.VARS.txt"
$global:slVars = LoadSetupVars;

#**********************************************************************************
#* Set these variables in LoadExecutionVars.ps1 @ function setConnectionStrings
setConnectionStrings;
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
#*********************************************************************************************

   
#**********************************************************************************
$CmdEncPath = $global:slVars["CMDENCRYPTPATH"];
$CmdEncExe = $global:slVars["CMDENCRYPTEXE"];
$CS_ECMGATEWAY = $global:slVars["CS_ECMGATEWAY"];
$CS_ENCECMREPO = $global:slVars["CS_ENCECMREPO"];
$CS_HELPDB = $global:slVars["CS_HELPDB"];
$Exepath = $global:slVars["CMDENCRYPTEXE"];

#********************************************************************************
#* The execution path to CmdEncrypt could be in different 
#* places on depending upon installation. We use the default path here.
$global:CmdEncryptPATH = "C:\Program Files (x86)\ECM Library\CmdEncrypt\" ;
$global:CmdEncryptEXE = "C:\Program Files (x86)\ECM Library\CmdEncrypt\_EncryptString.exe" ;

##*********************************************************************************************
##* Required passwords needed to be encrypted
#$global:GPW = "pclJunebug1";
#$global:globalPWFS = "pclJunebug1";
#*********************************************************************************************
##* SET CONNECTION STRINGS#*Connection Strings
##*The following WILL NOT be encrypted as the @@PW@@ will be used.
#$global:CSECMSecureLogin= "192.168.0.13;Initial Catalog=ECM.SecureLogin;Persist Security Info=True;User ID=ecmlibrary;Password=@@PW@@; Timeout=30;";
#$global:CSECMREPO = "192.168.0.13;Initial Catalog=ECM.Library.FS;Persist Security Info=True;User ID=ecmlibrary;Password=@@PW@@; Timeout=30;" ;

##The following will BE encrypted
#$global:gECMGATEWAY = "Data Source=192.168.0.13;Initial Catalog=ECM.SecureLogin;Persist Security Info=True;User ID=ecmlibrary;Password=pclJunebug1; Connect Timeout = 30;" ;
#$global:gENCECMREPO = "Data Source=192.168.0.13;Initial Catalog=ECM.Library.FS;Persist Security Info=True;User ID=ecmlibrary;Password=pclJunebug1; Connect Timeout = 30;";
#$global:gHELPDB = "Data Source=ecmadmin.db.3591434.hostedresource.com; Initial Catalog=ecmadmin; User ID=ecmadmin; Password='Junebug1';" ;
#$Global:gECMFSENC = "Data Source=192.168.0.13;Initial Catalog=Ecm.Library.FS;Persist Security Info=True;User ID=ecmlibrary;Password=pclJunebug1;  Connect Timeout =  30;" ;
#$Global:gThesaurus = "Data Source=192.168.0.13;Initial Catalog=ECM.Thesaurus;Persist Security Info=True;User ID=ecmlibrary;Password=pclJunebug1;  Connect Timeout =  30;" ;
#$Global:gECMGWAY = "Data Source=192.168.0.13;Initial Catalog=ECM.SecureLogin;Persist Security Info=True;User ID=ecmlibrary;Password=pclJunebug1;  Connect Timeout =  30;" ;
#$Global:gECMFS = "Data Source=192.168.0.13;Initial Catalog=Ecm.Library.FS;Persist Security Info=True;User ID=ecmlibrary;Password=pclJunebug1;  Connect Timeout =  30;" ;
#$global:gECMREPO = "Data Source=192.168.0.13;Initial Catalog=Ecm.Library.FS;Persist Security Info=True;User ID=ecmlibrary;Password=pclJunebug1;  Connect Timeout =  30;" ;
#$global:gHIVEDB = "Data Source=192.168.0.13;Initial Catalog=ECM.Hive;Persist Security Info=True;User ID=ecmlibrary;Password=pclMySister1;  Connect Timeout =  30; " ;
#*********************************************************************************************

$global:EncVal= "" ;

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
        #write-host $data;
        if ($i = 1){
            $global:EncVal= $data ;
            $EncVal = $data;
        }
        $i = $i +1;
    }

    return $EncVal;

}

function processConfigFile($filename)
{
    if($filename.Contains("Search")){
            Write-Host "Search found" ;            
           
        }


    if($filename.Contains("ClcDownloader")){
            Write-Host "ClcDownloader found" ;            
            return;
        }
    if($filename.Contains("Archiver")){
            Write-Host "Archiver found" ;    
            return;        
        }

    #Now, we need to get the file name from the full path name
    $file = split-path $filename -leaf -resolve
    $OFile = $global:TempDir + $file
    
    $i = 0 ; 
    $hits = 0 ; 
    $b = 0;
    foreach ($line in [System.IO.File]::ReadLines($filename))
    {
        $i = $i + 1 ;
        $b = 0 ;

#       ****************************************************************************************************************************************************************
#       Work through each config file and find all substitutions that have to be done.
#       The below is a connection string to a CE database that does not need to be updated - so skip these
#       <add name="EcmArchiveClcSetup.My.MySettings.OutlookContactsConnectionString" connectionString="Data Source=|DataDirectory|\CE\OutlookContacts.sdf"
#       b = 10 -> a normal connection string that needs to be updated
#       b = 20 -> a known encrypted string
#       b = 1  -> a connection string, but not encrypted
#       b = 3  -> an ENDPOINT address
#       ****************************************************************************************************************************************************************
        if($line.Contains("@@PW@@")){
            Write-Host "@@PW@@ found" ;            
        }
        if($line.Contains("RepoNAME") -and $line.Contains("ENC.ECMREPO")){
            #Skip, do not modify
            $b = -1 ;
        }   
        elseif($line.Contains("add key") -and $line.Contains("DownloadClcUrl") ) {
            #Peter and Dale review
            #It is a known encrypted string
            $b = 15 ;
        }            
        elseif($line.Contains("add key") -and $line.Contains("DownloadArchiverURL") ) {
            #Peter and Dale review
            #It is a known encrypted string
            $b = 15 ;
        }                             
        elseif($line.Contains("add name") -and $line.Contains("EcmArchiveClcSetup.My.MySettings.ECMHive") -and $line.Contains("connectionString") -and -not $line.Contains(".sdf") ){
            #The below is a normal connection string that needs to be updated
            $b = 10 ;
        }
        elseif($line.Contains("key") -and $line.Contains("ECMFS") -and $line.Contains("connectionString") -and -not $line.Contains(".sdf") ){
            #The below is a normal connection string that needs to be updated
            #<add name="ECMFS" connectionString="Data Source=192.168.0.13;Initial Catalog=ECM.Library.FS;Persist Security Info=True;User ID=ecmuser;Password=Junebug1" providerName="System.Data.SqlClient" />
            $b = 10 ;
        }
        elseif($line.Contains("key") -and $line.Contains("HIVEDB") -and -not $line.Contains("value=") -and -not $line.Contains(".sdf") ){
            #It is a known encrypted string
            $b = 20 ;
        }                
        elseif($line.Contains("key") -and $line.Contains("CONN_DMADB") -and -not $line.Contains("value=") -and -not $line.Contains(".sdf") ){
            #It is a known encrypted string
            $b = 20 ;
        }                
        elseif($line.Contains("key") -and $line.Contains("ECMREPO") -and -not $line.Contains("value=") -and -not $line.Contains(".sdf") ){
            #It is a known encrypted string
            $b = 20 ;
        }                
        elseif($line.Contains("key") -and $line.Contains("ECM.Library") -and -not $line.Contains("value=") -and -not $line.Contains(".sdf") ){
            #It is a known encrypted string
            $b = 20 ;
        }                
        elseif($line.Contains("key") -and $line.Contains("ECMFS") -and -not $line.Contains("value=") -and -not $line.Contains(".sdf") ){
            #It is a known encrypted string
            $b = 20 ;
        }                
        elseif($line.Contains("key") -and $line.Contains("ECMGATEWAY") -and -not $line.Contains("value=") -and -not $line.Contains(".sdf") ){
            #It is a known encrypted string
            $b = 20 ;
        }        
        elseif($line.Contains("key") -and $line.Contains("ECMGWAY") -and -not $line.Contains("value=") -and -not $line.Contains(".sdf") ){
            #It is a known encrypted string
            $b = 20 ;
        }        
        elseif($line.Contains("key") -and $line.Contains("ENCECMREPO") -and -not $line.Contains("value=") -and -not $line.Contains(".sdf") ){
            #It is a known encrypted string
            $b = 20 ;
        }                
        elseif($line.Contains("key") -and $line.Contains("ENC.ECM_ThesaurusConnectionString") -and -not $line.Contains("value=") -and -not $line.Contains(".sdf") ){
            #It is a known encrypted string
            $b = 20 ;
        }        
        elseif($line.Contains("key") -and $line.Contains("ENC.ECMREPO") -and -not $line.Contains("value=") -and -not $line.Contains(".sdf") ){
            #It is a known encrypted string
            $b = 20 ;
        }        
        elseif($line.Contains("key") -and $line.Contains("ECMFSENC") -and -not $line.Contains("value=") -and -not $line.Contains(".sdf") ){
            #It is a known encrypted string
            $b = 20 ;
        }        
        elseif($line.Contains("key") -and $line.Contains("ECMFSENC") -and $line.Contains("connectionString") -and -not $line.Contains(".sdf") ){
            #It is a connection string, but not encrypted
            $b = 10 ;
        }                
        elseif($line.Contains("key") -and $line.Contains("ECMGWAY") -and $line.Contains("connectionString") -and -not $line.Contains(".sdf") ){
            #It is a connection string, but not encrypted
            $b = 10 ;
        }        
        elseif($line.Contains("key") -and $line.Contains("ECMFS") -and $line.Contains("Data Source=")){
            #It is a connection string, but not encrypted
            $b = 1 ;
        }
        elseif($line.Contains("key") -and $line.Contains("ECMFS") -and -not $line.Contains("Data Source=")){
            #It is an encrypted connection string
            $b = 5 ;
        }        
        elseif($line.Contains("key") -and $line.Contains("ECMSecureLogin") -and $line.Contains("Data Source=")){
            $b = 1 ;
        }
        elseif($line.Contains("key") -and $line.Contains("ECMSecureLogin") -and -not $line.Contains("Data Source=")){
            #It is an encrypted connection string
            $b = 5 ;
        }        
        elseif($line.Contains("key") -and $line.Contains("ENC.ECMREPO") -and $line.Contains("Data Source=")){
            $b = 1 ;
        }
        elseif($line.Contains("key") -and $line.Contains("ENC.ECMREPO") -and -not $line.Contains("Data Source=")){
            #It is an encrypted connection string
            $b = 5 ;
        }
        elseif($line.Contains("key") -and $line.Contains("ECMREPO") -and $line.Contains("Data Source=")){
            $b = 1 ;
        }
        elseif($line.Contains("key") -and $line.Contains("ECMREPO") -and -not $line.Contains("Data Source=")){
            #It is an encrypted connection string
            $b = 5 ;
        }
        elseif($line.Contains("key") -and $line.Contains("ECM_ThesaurusConnectionString") -and $line.Contains("Data Source=")){            
            $b = 1 ;
        }
        elseif($line.Contains("key") -and $line.Contains("ECM_ThesaurusConnectionString") -and -not $line.Contains("Data Source=")){
            $b = 5 ;
        }
        elseif($line.Contains("key") -and $line.Contains("CONN_DMA.DB") -and $line.Contains("Data Source=")){
            $b = 1 ;
        }
        elseif($line.Contains("key") -and $line.Contains("CONN_DMA.DB") -and $line.Contains("Data Source=")){
            $b = 1 ;
        }
        elseif($line.Contains("key") -and $line.Contains("HIVE.DB") -and -not $line.Contains("Data Source=")){
            $b = 5 ;
        }
        elseif($line.Contains("key") -and $line.Contains("HIVE.DB") -and $line.Contains("Data Source=")){
            $b = 1 ;
        }
        elseif($line.Contains("<endpoint address")){
            #It is an ENDPOINT address
            $b = 3 ;
        }
        elseif($line.Contains("add key=") -and $line.Contains("EncPW") -and $line.Contains("value=")){
            #It is a KEY value pair - change the value
            $b = 20 ;
        }
        elseif($line.Contains("add key=") -and $line.Contains("ExplodeContentZip") -and $line.Contains("value=")){
            #It is a KEY value pair - change the value
            $b = 20 ;
        }
        elseif($line.Contains("add key=") -and $line.Contains("ExplodeEmailZip") -and $line.Contains("value=")){
            #It is a KEY value pair - change the value
            $b = 20 ;
        }
        elseif($line.Contains("add key=") -and $line.Contains("ExplodeEmailAttachment") -and $line.Contains("value=")){
            #It is a KEY value pair - change the value
            $b = 20 ;
        }
        elseif($line.Contains("add key=") -and $line.Contains("FacilityName") -and $line.Contains("value=")){
            #It is a KEY value pair - change the value
            $b = 20 ;
        }
        elseif($line.Contains("add key=") -and $line.Contains("PdfProcessingDir") -and $line.Contains("value=")){
            #It is a KEY value pair - change the value
            $b = 20 ;
        }
        elseif($line.Contains("add key=") -and $line.Contains("TempProcessingDir") -and $line.Contains("value=")){
            #It is a KEY value pair - change the value
            $b = 20 ;
        }
        elseif($line.Contains("add key=") -and $line.Contains("ProcessJpgAsTIF") -and $line.Contains("value=")){
            #It is a KEY value pair - change the value
            $b = 20 ;
        }
        elseif($line.Contains("add key=") -and $line.Contains("UploadPath") -and $line.Contains("value=")){
            #It is a KEY value pair - change the value
            $b = 20 ;
        }        
        elseif($line.Contains("add key=") -and $line.Contains("LogPath") -and $line.Contains("value=")){
            #It is a KEY value pair - change the value
            $b = 20 ;
        }
        elseif($line.Contains("add key=") -and $line.Contains("ConsoleOcrPath") -and $line.Contains("value=")){
            #It is a KEY value pair - change the value
            $b = 20 ;
        }
        
        if($b -eq 20){
            #<add key="ECMSecureLogin" value="bNk5A9GOZlbQeBTQaD26Km1SnW2zi/EElpR/ag3AeNBAmD2bZY+L32IEoPCk12R4ek8dQIhUN1T59eAAZwOsElJo/mQti5bHSAKfnUcuAuV3MEbOr5qqffybwSbDmRIMuDBxQNVhvbHrwdVRFwt62ZnFOOOiDdKuzoTzZM2aSyw="/>
            $line = ReplaceUser($line);
            $line = ReplaceUserPW($line);
            $hits = $hits + 1 ;
            $i1 = $line.IndexOf("value=",0) ;
            $i2 = $line.IndexOf("`"",$i1 + 2) ;
            $i3 = $line.IndexOf("`"",$i2 + 2) ;
            $s1 = $line.Substring(0,$i2+1) ;
            $s2 = $line.Substring($i2+1, $i3-$i2-1) ;
            $s2 = $s2.Trim();
            $s3 = $line.Substring($i3) ;
            if ($line.Contains("ECMFSENC")){
                $s4 = $s1 + $Global:CS_ECMFSENC + $s3 ;
            }            
            elseif ($line.Contains("ConsoleOcrPath")){
                $s4 = $s1 + $Global:ConsoleOcrPath + $s3 ;
            }            
            elseif ($line.Contains("LogPath")){
                $s4 = $s1 + $Global:LogPath + $s3 ;
            }            
            elseif ($line.Contains("UploadPath")){
                $s4 = $s1 + $Global:UploadPath + $s3 ;
            }            
            elseif ($line.Contains("ProcessJpgAsTIF")){
                $s4 = $s1 + $Global:ProcessJpgAsTIF + $s3 ;
            }            
            elseif ($line.Contains("TempProcessingDir")){
                $s4 = $s1 + $Global:TempProcessingDir + $s3 ;
            }            
            elseif ($line.Contains("PdfProcessingDir")){
                $s4 = $s1 + $Global:PdfProcessingDir + $s3 ;
            }            
            elseif ($line.Contains("FacilityName")){
                $s4 = $s1 + $Global:FacilityName + $s3 ;
            }            
            elseif ($line.Contains("ExplodeEmailAttachment")){
                $s4 = $s1 + $Global:ExplodeEmailAttachment + $s3 ;
            }            
            elseif ($line.Contains("ExplodeEmailZip")){
                $s4 = $s1 + $Global:ExplodeEmailZip + $s3 ;
            }
            elseif ($line.Contains("ExplodeContentZip")){
                $s4 = $s1 + $Global:ExplodeContentZip + $s3 ;
            }
            elseif ($line.Contains("ENC.ECMREPO")){
                $s4 = $s1 + $Global:CS_ENCECMREPO + $s3 ;
            }
            elseif ($line.Contains("ECMGATEWAY")){
                $s4 = $s1 + $Global:CS_ECMGATEWAY + $s3 ;
            }            
            elseif ($line.Contains("ECMSecureLogin")){
                #$s4 = $s1 + $Global:CS_ECMSecureLogin + $s3 ;
                $s4 = $s1 + $Global:CSECMSecureLogin + $s3 ;
            }            
            elseif ($line.Contains("ENC.ECM_ThesaurusConnectionString")){
                $s4 = $s1 + $Global:CS_ECM_ThesaurusConnectionString + $s3 ;
            }   
            elseif ($line.Contains("EncPW")){
                $s4 = $s1 + $Global:EncPW + $s3 ;
            }   
            else {
                #Ignore and use 
            }         
            
            #Write-Host "S1 $s1" ;
            #Write-Host "S2 $s2" ;
            #Write-Host "S3 $s3" ;
            Write-Host "S4 $s4" ;
            #Write-Host $line ;
            #Add-Content -Path $global:TestFile -Value "$s4`r`n"
            Add-Content -Path $global:TestFile -Value "$s4";
        }
        elseif($b -eq 15){
            #Peter and Dale review
            #<add key="DownloadClcUrl" value="http://192.168.0.13/ClcDownloader/publish.htm"/>
            #<add key="DownloadArchiverURL" value="http://192.168.0.13/Archiver/publish.htm"/>
            #$global:DOWNLOADERURL
            #$global:ARCHIVERURL
            
            $newline = "" ;
            if ($line.Contains("DownloadClcUrl")){
                $newline = '<add key="DownloadClcUrl" value="' + $global:DOWNLOADERURL + '"/>' ;
            }

            if ($line.Contains("DownloadArchiverURL") ){
                $newline = '<add key="DownloadArchiverURL" value="' + $global:ARCHIVERURL +  '"/>' ;
            }

            $hits = $hits + 1 ;
            Write-Host $newline ;
            #Write-Host $line ;
            Add-Content -Path $global:TestFile -Value "$newline";
        }
        
        elseif($b -eq 10){
            #<add name="ECMFS" connectionString="Data Source=192.168.0.13;Initial Catalog=ECM.Library.FS;Persist Security Info=True;User ID=ecmuser;Password=Junebug1" providerName="System.Data.SqlClient" />
            $line = ReplaceUser($line);
            if($line.Contains("@@PW@@")){
                Write-Host "@@PW@@ found" ;            
            }
            else{
                $line = ReplaceUserPW($line);
            }            
            $hits = $hits + 1 ;
            $i1 = $line.IndexOf("Data Source=",0) ;
            $i2 = $line.IndexOf("=",$i1 + 2) ;
            $i2 = $i2 + 1 ;
            $i3 = $line.IndexOf(";",$i2 + 1) ;
            $s1 = $line.Substring(0,$i2) ;
            $s2 = $line.Substring($i2+1, $i3-$i2-1) ;
            $s2 = $s2.Trim();
            $s3 = $line.Substring($i3) ;
            $s4 = $s1 + $Global:DBDNS + $s3 ;
            #Write-Host "S1 $s1" ;
            #Write-Host "S2 $s2" ;
            #Write-Host "S3 $s3" ;
            Write-Host "S4 $s4" ;
            #Write-Host $line ;
            Add-Content -Path $global:TestFile -Value "$s4";
        }
        elseif($b -eq 5){
            $line = ReplaceUser($line);
            $line = ReplaceUserPW($line);
            $hits = $hits + 1 ;
            $i1 = $line.IndexOf("value=",0) ;
            $i2 = $line.IndexOf("=",$i1 + 1) ;
            $i2 = $i2 + 2 ;
            $i3 = $line.IndexOf("`"",$i2 + 1) ;
            $s1 = $line.Substring(0,$i2) ;
            $s2 = $line.Substring($i2+1, $i3-$i2-1) ;
            $s2 = $s2.Trim();
            $s3 = $line.Substring($i3) ;

            if ($line.Contains("HIVE.DB")){            
                $s4 = $s1 + $Global:CS_HIVEDB + $s3 ;
            }
            elseif ($line.Contains("ECMFSENC")){            
                $s4 = $s1 + $Global:CS_ECMFSENC + $s3 ;
            }
            elseif ($line.Contains("ECMSecureLogin")){            
                #$s4 = $s1 + $Global:CS_ECMSecureLogin + $s3 ;
                $s4 = $s1 + $Global:CSECMSecureLogin + $s3 ;                
            }
            elseif ($line.Contains("ENCECMREPO")){            
                $s4 = $s1 + $Global:CS_ENCECMREPO + $s3 ;
            }
            elseif ($line.Contains("ENC.ECMREPO")){            
                $s4 = $s1 + $Global:CS_ENCECMREPO + $s3 ;
            }
            elseif ($line.Contains("ECMGWAY")){            
                $s4 = $s1 + $Global:CS_ECMGWAY + $s3 ;
            }
            elseif ($line.Contains("ECMFS")){            
                $s4 = $s1 + $Global:CS_ECMFS + $s3 ;
            }
            elseif ($line.Contains("ECMREPO")){            
                $s4 = $s1 + $Global:CSECMREPO + $s3 ;
            }
            elseif ($line.Contains("CONN_DMADB")){            
                $s4 = $s1 + $Global:CS_CONN_DMADB + $s3 ;
            }
            elseif ($line.Contains("HIVEDB")){            
                $s4 = $s1 + $Global:CS_HIVEDB + $s3 ;
            }
            elseif ($line.Contains("ENC.ECM_ThesaurusConnectionString")){
                $s4 = $s1 + $Global:CS_ENCECM_ThesaurusConnectionString + $s3 ;  
            }          
            else { 
                  write-host $line }
            
            #Write-Host "S1 $s1" ;
            #Write-Host "S2 $s2" ;
            #Write-Host "S3 $s3" ;
            Write-Host "S4 $s4" ;
            Add-Content -Path $global:TestFile -Value "$s4";
        }        
        elseif($b -eq 3){
            $hits = $hits + 1 ;
            $i1 = $line.IndexOf("<endpoint address",0) ;
            $i2 = $line.IndexOf(":",$i1 + 1) ;
            $i2 = $i2 + 2 ;
            $i3 = $line.IndexOf("/",$i2 + 1) ;
            $s1 = $line.Substring(0,$i2+1) ;
            $s2 = $line.Substring($i2+1, $i3-$i2-1) ;
            $s2 = $s2.Trim();
            $s3 = $line.Substring($i3) ;
            $s4 = $s1 + $Global:SVCDNS + $s3 ;
            #Write-Host "S1 $s1" ;
            #Write-Host "S2 $s2" ;
            #Write-Host "S3 $s3" ;
            Write-Host "S4 $s4" ;
            Add-Content -Path $global:TestFile -Value "$s4";
        }        
        elseif($b -eq 1 -and $line.Contains("Data Source")){
            $line = ReplaceUser($line);
            $line = ReplaceUserPW($line);
            $hits = $hits + 1 ;
            $i1 = $line.IndexOf("Data Source",0) ;
            $i2 = $line.IndexOf("=",$i1 + 1) ;
            $i3 = $line.IndexOf(";",$i1 + 1) ;
            $s1 = $line.Substring(0,$i1) ;
            $s2 = $line.Substring($i2+1, $i3-$i2-1) ;
            $s2 = $s2.Trim();
            $s3 = $line.Substring($i3) ;
            $s4 = $s1 + $Global:DBDNS + $s3 ;
            #Write-Host "S1 $s1" ;
            #Write-Host "S2 $s2" ;
            #Write-Host "S3 $s3" ;
            Write-Host "S4 $s4" ;
            Add-Content -Path $global:TestFile -Value "$s4";
        }   
        else{
            Add-Content -Path $global:TestFile -Value "$line";     
        }
    }
    Write-Host "Total Lines: $i" 
    Write-Host "Total Hits: $hits" 
}

#**************************************************************************************************
function BackupFile($fqn){
    #Copy this file to the backup directory and use a DateTime to make it unique
    $dirName  = $global:BackupDir ;
    $DirNewName = $dirName.replace("`\",".") ;
    $DirNewName = $DirNewName.replace(":", "_") ;
    $filename = [io.path]::GetFileNameWithoutExtension($fqn);
    $ext      = [io.path]::GetExtension($fqn);
    #$newPath  = "$dirName\$DirNewName$filename$(get-date -f yyyy-MM-dd-hh-mm-ss)$ext" ;
    $newPath  = "$dirName\$DirNewName$filename$(get-date -f yyyy-MM-dd-hh-mm-ss)$ext" ;

    Copy-Item $fqn -Destination $newPath ;
}
#**************************************************************************************************


#**********************************************************************
#Put the corrected and modified file back in the place of the original
function ReplaceFile($TempFqn, $OrigFqn){
    Copy-Item $TempFqn -Destination $OrigFqn
    # Peter+Dale: Remove .back when debug is ok
    #$tback=$OrigFqn + ".back";
    #Copy-Item $TempFqn -Destination $tback ;
}
#**********************************************************************

function ReplaceUser($line){
    if($line.contains("User ID=")){
        $i1 = $line.IndexOf("User ID=",0) ;
        $i2 = $line.IndexOf("=",$i1 + 1) ;
        $i3 = $line.IndexOf(";",$i1 + 1) ;
        $s1 = $line.Substring(0,$i2+1) ;
        $s2 = $line.Substring($i2+1, $i3-$i2-1) ;
        $s2 = $s2.Trim();
        $s3 = $line.Substring($i3) ;
        $line = $s1 + $Global:UserID + $s3 ;        
    }
    return $line
}
function ReplaceUserPW($line){
    if($line.contains("Password=")){
        $i1 = $line.IndexOf("Password=",0) ;
        $i2 = $line.IndexOf("=",$i1 + 1) ;
        $i3 = $line.IndexOf(";",$i1 + 1) ;
        if ($i3 -lt 0) {
           $i3 = $line.IndexOf("`"",$i1 + 1) ;
        }
        $s1 = $line.Substring(0,$i2+1) ;
        $s2 = $line.Substring($i2+1, $i3-$i2-1) ;
        $s2 = $s2.Trim();
        $s3 = $line.Substring($i3) ;
        $line = $s1 + $Global:UserPW + $s3 ;        
    }
    return $line
}

#***************************************************************************************************************
#** The following will be part of the inspection and update.
#C:\EcmSite\Archive\Web.config
#C:\EcmSite\ArchiveFS\Application Files\EcmArchiveClcSetup_2_8_16_147\EcmArchiveClcSetup.exe.config.deploy
#C:\EcmSite\ArchiverCLC\Application Files\EcmDownloader_2_0_0_87\EcmDownloader.exe.config.deploy
#C:\EcmSite\ECMWebServices\SecureAttachAdminSVC\Web.config
#C:\EcmSite\Search\Web.config
#C:\EcmSite\Software\SvrSideOcr\DISK1\program files\ECM Library\ECM Serverside Ocr\ServerSideOCR.exe.config
#***************************************************************************************************************

Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
Set-ExecutionPolicy Unrestricted -Scope CurrentUser
Get-ExecutionPolicy -List

cls
#Enter Execution Variables Here:
#***********************************************************************************
#It is necessary to supply the dir and the path separately.
#The following code will recursively process all files in the parent directory
#This is where the downloaded and installed files are stored.
#***********************************************************************************

#This is the DISK where the ECM WebSite will reside
$dir = "c:\" ;

#This is the DIRECTORY where the ECM WebSite will reside
$path = $dir + "EcmSite"

$global:ENC_ECMGATEWAY = encryptConnStrings($global:gECMGATEWAY);
$global:ENC_ECMGATEWAY = $global:EncVal;

$global:ENC_ENCECMREPO  = encryptConnStrings($global:CS_ENCECMREPO);
$global:ENC_ENCECMREPO = $global:EncVal;

$global:ENC_HELPDB = encryptConnStrings($global:CS_HELPDB);
$global:ENC_HELPDB = $global:EncVal;

echo "CmdEncryptPATH $global:CmdEncryptPATH"
echo "CS_HELPDB $global:CmdEncPath"
echo "CmdEncryptEXE $global:CmdEncryptEXE"
echo "CS_ECMGATEWAY $global:gECMGATEWAY"
echo "CS_ENCECMREPO $global:CS_ENCECMREPO"
echo "CS_HELPDB $global:CS_HELPDB"

#<!-- *********   Use ExplodeContentZip to expand and explode ZIP files, otherwise a ZIP file will be indexed intact. ************** -->
#Downloader clickonce installation
$Global:DOWNLOADERURL = "http://www.ecmlibrary.com/EcmSaas/ClcDownloader/publish.htm"
#Archiever clickonce installation
$Global:ARCHIVERURL = "http://www.ecmlibrary.com/EcmSaas/Archiver/publish.htm"

#<add key="ExplodeContentZip" value="N"/>
$Global:ExplodeContentZip = "N"

#<add key="ExplodeEmailZip" value="N"/>
$Global:ExplodeEmailZip = "N"

#<add key="ExplodeEmailAttachment" value="N"/>
$Global:ExplodeEmailAttachment = "N"

#<add key="FacilityName" value="Highland Park"/>
$Global:FacilityName = "Picatinny"

#<!--CHANGE AS NEEDED-->
#<add key="PdfProcessingDir" value="C:\TempUploads\"/>
$Global:PdfProcessingDir = "C:\TempUploads\"

#<add key="TempProcessingDir" value="C:\TempUploads\"/>
$Global:TempProcessingDir = "C:\TempUploads\"

#<add key="ProcessJpgAsTIF" value="0"/>
$Global:ProcessJpgAsTIF = "0"

#<add key="UploadPath" value="C:\TempUploads"/>
$Global:UploadPath = "C:\TempUploads"

#<add key="LogPath" value="C:\Logs"/>
$Global:LogPath = "C:\Logs"

#<add key="ConsoleOcrPath" value="C:\Program Files (x86)\ECM Library\ConsoleArchiver\ConsoleArchiver.exe"/>
$Global:ConsoleOcrPath = "C:\Program Files (x86)\ECM Library\ConsoleArchiver\ConsoleArchiver.exe"

#*************************************************************************************************************************************************************************************************************************
#UPDATE THESE VARIABLES HERE AND THEY ARE CRITICAL TO CONNECTIVITY
#<add key="EncPW" value="GkXH52Yhh038Remo1wUdMQ=="  />
#EncPW - This is required - the below represents the PW Junebug1
#$Global:EncPW = "GkXH52Yhh038Remo1wUdMQ==" ;
$global:EncPW = encryptConnStrings($global:GPW);
$global:EncPW = $global:EncVal;

#========================================================
# SET CONNECTION STRINGS
# The following are required CONNECTION STRINGS
#========================================================
#ECMGATEWAY
#Data Source=192.168.0.13;Initial Catalog=EcmGateway;Persist Security Info=True;User ID=ecmlibrary;Password=pclMySister1;  Connect Timeout =  30;
#$Global:CS_ECMGATEWAY = "bNk5A9GOZlbxfeCeH/LgjPhVjniOWwagfPsKGxQrMzKxCBMd3TMJB1ut1C+JZPGEZJO5I94A7Csxob2ntlA4zF5V82o/1mcE1bzmh7tfBia0sfSLuEYOkENiiNfSh7kadGpPk28uWOGFMEOWmFwSrxcQdF8Y1mLCfywKbDGOlht3nbLyEU7M4Eq8irdkH/wJ" ;
$global:CS_ECMGATEWAY = encryptConnStrings($global:gECMGATEWAY);
$global:CS_ECMGATEWAY = $global:EncVal;

#ECMFSENC
#Data Source=192.168.0.13;Initial Catalog=Ecm.Library.FS;Persist Security Info=True;User ID=ecmlibrary;Password=pclMySister1;  Connect Timeout =  30;
#$Global:CS_ECMFSENC = "bNk5A9GOZlbxfeCeH/LgjPhVjniOWwagfPsKGxQrMzKxCBMd3TMJB4WactBPTgX84MeqW0IVbujB14HKuZWyRV23CpqKLZcVGsyVGNfGZoRQrbPzavd2HywnRNyw4gcPxkvSk2a4JmhWJbpaJaTRuoIa2BI6rzZMZAMxeei1MLEh1lsFfEe9VK65YhbZqQZ3RlJWX46y24A=" ;
$global:CS_ECMFSENC = encryptConnStrings($global:gECMFSENC);
$global:CS_ECMFSENC = $global:EncVal;

#ECMSecureLogin
#Data Source=192.168.0.13;Initial Catalog=ECM.SecureLogin;Persist Security Info=True;User ID=ecmlibrary;Password=pclMySister1; Connect Timeout = 15;
#$Global:CS_ECMSecureLogin = "bNk5A9GOZlbxfeCeH/LgjPhVjniOWwagfPsKGxQrMzKU7XqdaqhRBtx4/qp7MP99NGgzz2t5TvBXJJrCzqn2976EuHWrOl3fWiQ/Cweuo5mHN3jZZE7Ly9txr0QAynDA6pB8mh+7rRtD8zAUskCfoJLTZ8RA5n1wc7+CaKItq08h1lsFfEe9VOm8vVkA0PH3/EXpqNcFHTE=" ;
#$global:CS_ECMSecureLogin = encryptConnStrings($global:gECMSecureLogin);
$global:CS_ECMSecureLogin = $global:CSECMSecureLogin

#ENC.ECMREPO
#Data Source=192.168.0.13;Initial Catalog=Ecm.Library.FS;Persist Security Info=True;User ID=ecmlibrary;Password=pclMySister1;  Connect Timeout =  30;
#$Global:CS_ENCECMREPO = "bNk5A9GOZlbxfeCeH/LgjPhVjniOWwagfPsKGxQrMzKxCBMd3TMJB4WactBPTgX84MeqW0IVbujB14HKuZWyRV23CpqKLZcVGsyVGNfGZoRQrbPzavd2HywnRNyw4gcPxkvSk2a4JmhWJbpaJaTRuoIa2BI6rzZMZAMxeei1MLEh1lsFfEe9VK65YhbZqQZ3RlJWX46y24A=" ;
$global:CS_ENCECMREPO = encryptConnStrings($global:gENCECMREPO);
$global:CS_ENCECMREPO = $global:EncVal;

#ENC.ECM_ThesaurusConnectionString
#Data Source=192.168.0.13;Initial Catalog=ECM.Thesaurus;Persist Security Info=True;User ID=ecmlibrary;Password=pclMySister1;  Connect Timeout =  30;
#$Global:CS_ENCECM_ThesaurusConnectionString = "bNk5A9GOZlbxfeCeH/LgjPhVjniOWwagfPsKGxQrMzKU7XqdaqhRBhnQFE9z20q6h0i+4savctkhzzPEfJx4UwME/OqFA7OWQoHGwgPwax6Np/5a03N1xyNA4aQrAfNfDn5S3uGnAoajmMq0rz9s+6EEhL9Awrsc3uvfvoCfpC2PPFd1SgyeOTZW7cKCGxp4/EXpqNcFHTE=" ;
$Global:CS_ENCECM_ThesaurusConnectionString = encryptConnStrings($Global:gThesaurus);
$global:CS_ENCECM_ThesaurusConnectionString = $global:EncVal;

#HELPDB
#Data Source=ecmadmin.db.3591434.hostedresource.com; Initial Catalog=ecmadmin; User ID=ecmadmin; Password='Junebug1';
$Global:CS_HELPDB = encryptConnStrings($Global:gHELPDB);
$global:CS_HELPDB = $global:EncVal;

#====================================================================
# The following are optional but should be supplied if available
#====================================================================
#ECMGATEWAY
#Data Source=192.168.0.13;Initial Catalog=ECM.SecureLogin;Persist Security Info=True;User ID=ecmlibrary;Password=pclMySister1;  Connect Timeout =  30;
#$Global:CS_ECMGWAY = "bNk5A9GOZlbxfeCeH/LgjPhVjniOWwagfPsKGxQrMzKU7XqdaqhRBtx4/qp7MP99NGgzz2t5TvBXJJrCzqn2976EuHWrOl3fWiQ/Cweuo5mHN3jZZE7Ly9txr0QAynDA6pB8mh+7rRtD8zAUskCfoJLTZ8RA5n1wkZ7gmObNKrUGb9lBG+EEUyopTOrIFn31/MafBtjRYsw=" ;
$Global:CS_ECMGWAY = encryptConnStrings($Global:gECMGWAY);
$global:CS_ECMGWAY = $global:EncVal;

#ECMFS
#Data Source=192.168.0.13;Initial Catalog=Ecm.Library.FS;Persist Security Info=True;User ID=ecmlibrary;Password=pclMySister1;  Connect Timeout =  30;
#$Global:CS_ECMFS = "bNk5A9GOZlbxfeCeH/LgjPhVjniOWwagfPsKGxQrMzKxCBMd3TMJB4WactBPTgX84MeqW0IVbujB14HKuZWyRV23CpqKLZcVGsyVGNfGZoRQrbPzavd2HywnRNyw4gcPxkvSk2a4JmhWJbpaJaTRuoIa2BI6rzZMZAMxeei1MLEh1lsFfEe9VK65YhbZqQZ3RlJWX46y24A=" ;
$Global:CS_ECMFS = encryptConnStrings($Global:gECMFS);
$global:CS_ECMFS = $global:EncVal;

#ENC.ECMREPO
#Data Source=192.168.0.13;Initial Catalog=Ecm.Library.FS;Persist Security Info=True;User ID=ecmlibrary;Password=pclMySister1;  Connect Timeout =  30;
#$Global:CS_ECMREPO = "bNk5A9GOZlbxfeCeH/LgjPhVjniOWwagfPsKGxQrMzKxCBMd3TMJB4WactBPTgX84MeqW0IVbujB14HKuZWyRV23CpqKLZcVGsyVGNfGZoRQrbPzavd2HywnRNyw4gcPxkvSk2a4JmhWJbpaJaTRuoIa2BI6rzZMZAMxeei1MLEh1lsFfEe9VK65YhbZqQZ3RlJWX46y24A=" ;
#NOTE: $Global:CSECMREPO is NOT encrypted
$Global:CS_ECMREPO = encryptConnStrings($Global:gECMREPO);
$global:CS_ECMREPO = $global:EncVal;


$Global:CS_CONN_DMADB = $Global:CS_ECMREPO;

#Data Source=192.168.0.13;Initial Catalog=ECM.Hive;Persist Security Info=True;User ID=ecmlibrary;Password=pclMySister1;  Connect Timeout =  30;
#$Global:CS_HIVEDB = "bNk5A9GOZlbxfeCeH/LgjPhVjniOWwagfPsKGxQrMzKU7XqdaqhRBklj3TVsglkdSt57Cz/4uvvTJzBYHuOz3pwYxkLuerSEtHiq5oqVUflWZDgq/bV6pq7p8uhJfUL0/1x23rseVCOl6mXhXkAl5bw7nBKYeTlweYNq/a+Y2nggHI5tZINpE3S/wR4aA2kq" ;
$Global:CS_HIVEDB = encryptConnStrings($Global:gHIVEDB);
$global:CS_HIVEDB = $global:EncVal;

#***************************************************************************************
#Create the processing directories - generates an error if a directory already exists
if (Test-Path $global:BackupDir) {
    write-host "$global:BackupDir exists"
}
else {
    New-Item $global:BackupDir -type directory ; 
}

if (Test-Path $global:TempDir) {
    write-host "$global:TempDir exists"
}
else {
    New-Item $global:TempDir -type directory ;
}

if (Test-Path $global:ConsoleOcrPath) {
    write-host "$global:ConsoleOcrPath exists"
}
else {
    New-Item $global:ConsoleOcrPath -type directory ;
}

if (Test-Path $global:LogPath) {
    write-host "$global:LogPath exists"
}
else {
    New-Item $global:LogPath -type directory ;
}

if (Test-Path $global:UploadPath) {
    write-host "$global:UploadPath exists"
}
else {
    New-Item $global:UploadPath -type directory ;
}

if (Test-Path $global:TempProcessingDir) {
    write-host "$global:TempProcessingDir exists"
}
else {
    New-Item $global:TempProcessingDir -type directory ;
}

if (Test-Path $global:PdfProcessingDir) {
    write-host "$global:PdfProcessingDir exists"
}
else {
    New-Item $global:PdfProcessingDir -type directory ;
}
#***************************************************************************************
#***************************************************************************************

#Peter and dale - make sure this works
Remove-Item $global:TestFile;
if (Test-Path $global:TestFile) {
    write-host "$global:TestFile REMOVED"
    Remove-Item $global:TestFile;    
}
else {
    write-host "$global:TestFile exists"
}

DIR $path -Recurse | % { 
        $d = "\"     
        "$_.fullname" ;
        $o = $_.fullname -replace [regex]::escape($path), (split-path $path -leaf)    
        if ( -not $_.psiscontainer)    
        {   
            $d = [string]::Empty ;
        } 
        $tempname = $dir + $o + $d ;
        $OrigFqn = $dir + $o + $d ;

        if ($tempname.Contains("EcmArchiveClcSetup.exe.config.deploy")){
            #"TempName: $tempname" ;
            #BackupFile $tempname ;
            #processConFigFile $tempname;
            ##We have to make sure this is correct 
            #ReplaceFile $global:TestFile $OrigFqn
            #if ($global:OpenNotepad -eq "Y") {
            #    start-process notepad $global:TestFile
            #}            
            #Remove-Item $global:TestFile;
        }
        elseif ($tempname.Contains("Web.config")){
            "TempName: $tempname" ;
            BackupFile $tempname ;
            processConFigFile $tempname;
            #We have to make sure this is correct 
            ReplaceFile $global:TestFile $OrigFqn

            if ($global:OpenNotepad -eq "Y") {
                start-process notepad $global:TestFile
            }            
            Remove-Item $global:TestFile;
        }
        elseif ($tempname.Contains("EcmDownloader.exe.config.deploy"))
        {
            #"TempName: $tempname" ;
            #BackupFile $tempname ;
            #processConFigFile $tempname;
            ##We have to make sure this is correct 
            #ReplaceFile $global:TestFile $OrigFqn

            #if ($global:OpenNotepad -eq "Y") {
            #    start-process notepad $global:TestFile
            #}            
            #Remove-Item $global:TestFile;
        }
        elseif ($tempname.Contains("ServerSideOCR.exe.config")){
            "TempName: $tempname" ;
            BackupFile $tempname ;
            processConFigFile $tempname;
            #We have to make sure this is correct 
            ReplaceFile $global:TestFile $OrigFqn

            if ($global:OpenNotepad -eq "Y") {
                start-process notepad $global:TestFile
            }            
            Remove-Item $global:TestFile;
        }    
 }


#processConFigFile "c:\PrepublishedWebSites\ECMSaaS\Archiver\Application Files\EcmArchiveClcSetup_3_2_1_3\EcmArchiveClcSetup.exe.config.deploy" ;
#Copy this modified file to the original


