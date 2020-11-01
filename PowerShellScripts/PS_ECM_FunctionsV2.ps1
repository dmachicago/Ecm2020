#Version 2.1.1.446

Import-Module sqlps -DisableNameChecking

Function global:ADD-PATH()
{
    [Cmdletbinding()]
    param
    ( 
        [parameter(Mandatory=$True,
        ValueFromPipeline=$True,
        Position=0)]
        [String[]]$AddedFolder
    )

    # Get the current search path from the environment keys in the registry.

    $OldPath=(Get-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINESystemCurrentControlSetControlSession ManagerEnvironment' -Name PATH).Path

    # See if a new folder has been supplied.

    IF (!$AddedFolder)
    { 
        Return ‘No Folder Supplied. $ENV:PATH Unchanged’
    }

    # See if the new folder exists on the file system.

    IF (!(TEST-PATH $AddedFolder))
    { 
        Return ‘Folder Does not Exist, Cannot be added to $ENV:PATH’ 
    }

    # See if the new Folder is already in the path.

    IF ($ENV:PATH | Select-String -SimpleMatch $AddedFolder)
    { 
        Return ‘Folder already within $ENV:PATH' 
    }

    # Set the New Path

    $NewPath=$OldPath+’;’+$AddedFolder

    Set-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINESystemCurrentControlSetControlSession ManagerEnvironment' -Name PATH –Value $newPath

    # Show our results back to the world

    Return $NewPath
}

Function global:REMOVE-PATH()
{
    [Cmdletbinding()]
    param
    ( 
        [parameter(Mandatory=$True,
        ValueFromPipeline=$True,
        Position=0)]
        [String[]]$RemovedFolder
    )

    # Get the Current Search Path from the environment keys in the registry

    $NewPath=(Get-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINESystemCurrentControlSetControlSession ManagerEnvironment' -Name PATH).Path

    # Find the value to remove, replace it with $NULL. If it’s not found, nothing will change.

    $NewPath=$NewPath –replace $RemovedFolder,$NULL

    # Update the Environment Path

    Set-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINESystemCurrentControlSetControlSession ManagerEnvironment' -Name PATH –Value $newPath

    # Show what we just did

    Return $NewPath

}

Function CreateDB ($DbExists, $SVR, $DbName)
{
    $rc = -1 
    if ($DbExists -eq 1){
        Write-Host -ForegroundColor Yellow "$DbName EXIST." 
        return 10
      }
    Else
    {
        $Srvr = New-Object -TypeName Microsoft.SqlServer.Management.Smo.Server -ArgumentList $SVR
        $db = New-Object -TypeName Microsoft.SqlServer.Management.Smo.Database($Srvr, $DbName)
        $db.Create()
        #Confirm, list databases in your current instance
        $Srvr.Databases |
        Select Name, Status, Owner, CreateDate
        return 1
    }
    return $rc 
}

Function getPowerShellVersion()
{
	$ver = $psversiontable.psversion.Major.ToInt32()
	return $ver
}


#This would be used like
#downloadFile "http://somesite/largefile.zip" "c:\temp\largefile.zip"
Function downloadFile($url, $targetFile)
{ 

if (Test-Path  ($i.fullname + $targetFile))
    {
    Write-Host "DOWN LOAD File Exists, skipping..."
    return
    }
    else 
        {
        Write-Host "File DOES NOT Exist, proceeding with download."
        }

    Write-Host "Downloading $url to location $targetFile." 
    $uri = New-Object "System.Uri" "$url" 
    $request = [System.Net.HttpWebRequest]::Create($uri) 
    $request.set_Timeout(60000) #15 second timeout 
    $response = $request.GetResponse() 
    $totalLength = [System.Math]::Floor($response.get_ContentLength()/1024) 
    $totalBytes = [System.Math]::Floor($response.get_ContentLength()) 
    $responseStream = $response.GetResponseStream() 

    $targetStream = New-Object -TypeName System.IO.FileStream -ArgumentList $targetFile, Create 
    #$targetStream = New-Object -TypeName System.IO.FileStream $targetFile, Create 

    Write-Host $targetStream

    $buffer = new-object byte[] 10KB 
    $count = $responseStream.Read($buffer,0,$buffer.length) 
    $downloadedBytes = $count 
    $iCnt = 0 ; 
    $xCnt = 0 ; 
    while ($count -gt 0) 
    { 
        $iCnt = $iCnt + 1
#        [System.Console]::CursorLeft = 0         
        if ($iCnt % 200 -eq 0)
        {
            $xCnt = $xCnt + 1
            if ($xCnt % 15 -eq 0)
            {
                cls
                Write-Host "Downloading $url" 
                $xCnt = 0
            }
#            [System.Console]::CursorLeft = 0 
#            [System.Console]::CursorTop = 0 
            $PctComplete =  [System.Math]::Round( ($downloadedBytes / $totalBytes) * 100, 2)
            #[System.Console]::Write("{0}K of {1}K, ", [System.Math]::Floor($downloadedBytes/1024), $totalLength) 
            [System.Console]::Write("{0}% ", $PctComplete) 
        }        
        $targetStream.Write($buffer, 0, $count) 
        $count = $responseStream.Read($buffer,0,$buffer.length) 
        $downloadedBytes = $downloadedBytes + $count 
    } 
    "`nFinished Download" 
    $targetStream.Flush()
    $targetStream.Close() 
    $targetStream.Dispose() 
    $responseStream.Dispose() 
} 

Function CountDirFiles ($DirFQN)
{
    #
    # Get a count of files in a directory.
    #    
    $directory_file_count = "0"
    $server_directory_string = $DirFQN

    # check that the directory exists.
    $does_directory_exist = (Test-Path $server_directory_string)

    # if it does, then continue
    if ($does_directory_exist)
    {
        # file count does include directories but not a count of their contents.
        $directory_file_count = (get-childitem $server_directory_string -name).count
        Write-Host "Directory file count: $directory_file_count"
    }
    else
    {
        # directory does not exist
        Write-Host "Directory $server_directory_string - DOES NOT EXIST"
    }
    return $directory_file_count
}

Function RemoveDups($FQN)
{
    $hash = @{}      # define a new empty hash table
    
    get-content $FQN | %{if($hash.$_ -eq $null) { $_ }; $hash.$_ = 1} > C:\temp\DeDup.txt
    
    copy-item -Path C:\temp\DeDup.txt -Destination $FQN -force
}

Function FileExists ($FQN)
{
    return Test-Path $FQN
}

Function ckIIS($ServerName, $UserName)
{
    $RC = 0
    $vm = $ServerName
    $iis = get-wmiobject Win32_Service -ComputerName  $vm -Credential $UserName  -Filter "name='IISADMIN'"
    if($iis.State -eq "Running")
	{
        Write-Host "IIS is running on $vm"
        $RC = "Y"
    }
    else
	{
        Write-Host "IIS is not running on $vm"
        $RC = "N"
    }
    return $RC
}

Function CreateIIS_Objects ($Logfile)
{
    #Author: W. Dale Miller
    #Copyright @ March, 2010, all rights reserved.
    #Step 1: Create New ECM Directories
    #We use the New-Item cmdlet to create the required file system directories. 
    #Execute the following commands (use 'md' instead of New-Item if you 
    #don't want to specify the -type parameter):


    #Load the WEB Assembly
    [System.Reflection.Assembly]::LoadWithPartialName("Microsoft.Web.Administration") 

    #Create a new IIS object
    $iis = new-object Microsoft.Web.Administration.ServerManager
    
    Add-Content -Path $Logfile -Value "Checking the IIS Configuration"

    $UID = "NetworkService"
    #$WebSiteDir = $global:WebSiteDir + ""
    $WebSiteDir = $global:WebSiteDir 
    
    $cDir = $WebSiteDir 
    PS_ckDirectory $cDir $Logfile
    SetAccessFull $cDir $UID $LogFile

    $cDir = $WebSiteDir + "AdminSetup"
    PS_ckDirectory $cDir $Logfile
    SetAccessFull $cDir $UID $LogFile
    
    $cDir = $WebSiteDir + "Archive"
    PS_ckDirectory $cDir $Logfile
    SetAccessFull $cDir $UID $LogFile
    
    $cDir = $WebSiteDir + "ArchiveFS"
    PS_ckDirectory $cDir $Logfile
    SetAccessFull $cDir $UID $LogFile
    
    $cDir = $WebSiteDir + "ArchiverCLC"
    PS_ckDirectory $cDir $Logfile
    SetAccessFull $cDir $UID $LogFile
    
    $cDir = $WebSiteDir + "AuthenticationSVC"
    PS_ckDirectory $cDir $Logfile
    SetAccessFull $cDir $UID $LogFile
    
    $cDir = $WebSiteDir + "CLC"
    PS_ckDirectory $cDir $Logfile
    SetAccessFull $cDir $UID $LogFile
    
    $cDir = $WebSiteDir + "ECMWebServices"
    PS_ckDirectory $cDir $Logfile
    SetAccessFull $cDir $UID $LogFile
    
    $cDir = $WebSiteDir + "SVCclcDownload"
    PS_ckDirectory $cDir $Logfile
    SetAccessFull $cDir $UID $LogFile
    
    $cDir = $WebSiteDir + "ClcDownloader"
    PS_ckDirectory $cDir $Logfile
    SetAccessFull $cDir $UID $LogFile
    
    $cDir = $WebSiteDir + "EcmAuthenticationApp"
    PS_ckDirectory $cDir $Logfile
    SetAccessFull $cDir $UID $LogFile
    
    $cDir = $WebSiteDir + "EcmEncryptor"
    PS_ckDirectory $cDir $Logfile
    SetAccessFull $cDir $UID $LogFile
    
    $cDir = $WebSiteDir + "Search"
    PS_ckDirectory $cDir $Logfile
    SetAccessFull $cDir $UID $LogFile
    
    $cDir = $WebSiteDir + "SecureAttachAdmin"
    PS_ckDirectory $cDir $Logfile
    SetAccessFull $cDir $UID $LogFile
    
    $cDir = $WebSiteDir + "SecureAttachAdminSVC"
    PS_ckDirectory $cDir $Logfile
    SetAccessFull $cDir $UID $LogFile
    
    $cDir = $WebSiteDir + "DemoApp"
    PS_ckDirectory $cDir $Logfile
    SetAccessFull $cDir $UID $LogFile
    
    $cDir = $WebSiteDir + "DemoVirtualDir1"
    PS_ckDirectory $cDir $Logfile
    SetAccessFull $cDir $UID $LogFile
    
    $cDir = $WebSiteDir + "DemoVirtualDir2"
    PS_ckDirectory $cDir $Logfile
    SetAccessFull $cDir $UID $LogFile

    
    $cDir = $WebSiteDir + "ECMWebServices\SVCclcDownload"
    PS_ckDirectory $cDir $Logfile
    SetAccessFull $cDir $UID $LogFile

        
    $cDir = $WebSiteDir + "ECMWebServices\SecureAttachAdminSVC"
    PS_ckDirectory $cDir $Logfile
    SetAccessFull $cDir $UID $LogFile

    $cDir = $WebSiteDir + "ECMWebServices\SecureLogin"
    PS_ckDirectory $cDir $Logfile
    SetAccessFull $cDir $UID $LogFile
        
    #Step 2: Copy Content
    #Now let's write a simple html file to these directories:

    write-host "global:WebSiteDir: $global:WebSiteDir"

    Set-Content "$global:WebSiteDir\Identify.htm" $global:WebSiteDir 
    Set-Content "$global:WebSiteDir\DemoApp\Identify.htm" "$global:WebSiteDir DemoApp Default Page"
    Set-Content "$global:WebSiteDir\DemoVirtualDir1\Identify.htm" "DemoVirtualDir1 Default Page"
    Set-Content "$global:WebSiteDir\DemoVirtualDir2\Identify.htm" "DemoVirtualDir2 Default Page"

    Set-Content "$global:WebSiteDir\AdminSetup\Identify.htm" "$global:WebSiteDir AdminSetup Default Page"
    Set-Content "$global:WebSiteDir\Archive\Identify.htm" "$global:WebSiteDir Archive Default Page"
    Set-Content "$global:WebSiteDir\ArchiveFS\Identify.htm" "$global:WebSiteDir ArchiveFS Default Page"
    Set-Content "$global:WebSiteDir\ArchiverCLC\Identify.htm" "$global:WebSiteDir ArchiverCLC Default Page"
    Set-Content "$global:WebSiteDir\AuthenticationSVC\Identify.htm" "$global:WebSiteDir AuthenticationSVC Default Page"
    Set-Content "$global:WebSiteDir\CLC\Identify.htm" "$global:WebSiteDir CLC Default Page"
    Set-Content "$global:WebSiteDir\ECMWebServices\Identify.htm" "$global:WebSiteDir ECMWebServices Default Page"
    Set-Content "$global:WebSiteDir\ECMWebServices\SVCclcDownload\Identify.htm" "$global:WebSiteDir ECMWebServices\SVCclcDownload Default Page"
    Set-Content "$global:WebSiteDir\ClcDownloader\Identify.htm" "$global:WebSiteDir ClcDownloader Default Page"
    Set-Content "$global:WebSiteDir\EcmAuthenticationApp\Identify.htm" "$global:WebSiteDir EcmAuthenticationApp Default Page"
    Set-Content "$global:WebSiteDir\EcmEncryptor\Identify.htm" "$global:WebSiteDir EcmEncryptor Default Page"
    Set-Content "$global:WebSiteDir\Search\Identify.htm" "$global:WebSiteDir Search Default Page"
    Set-Content "$global:WebSiteDir\SecureAttachAdmin\Identify.htm" "$global:WebSiteDir Search Default Page"
    Set-Content "$global:WebSiteDir\ECMWebServices\SecureAttachAdminSVC\Identify.htm" "$global:WebSiteDir ECMWebServices\SecureAttachAdminSVC Default Page"
    Set-Content "$global:WebSiteDir\ECMWebServices\SecureLogin\Identify.htm" "$global:WebSiteDir ECMWebServices\SecureLogin Default Page"


    #Step 2A - Create the requried temp directories and set the needed authority
    #********************************************************
    $DirName = "C:\TempUploads"
    PS_ckDirectory $DirName $Logfile

    $computerName = (Get-WmiObject win32_computersystem).name   

    #This determines which user is the guest user for IIS.  Windows Vista and 08 use the IIS_USRS group, Previous version use   #IUSR_[MachineName]   
    if ([environment]::osversion.Version.Major -eq 6) 
    {
        $webUser="IIS_IUSRS"
    } 
    else 
    {
        $webUser="IUSR_" + $computerName
        $webUser="IIS_IUSR"
    }
    
    $directory = "c:\Web"
    PS_ckDirectory $directory $Logfile
    
    #$acl = Get-Acl $directory   
    
    SetAccessFull $directory $UID $Logfile
    SetAccessFull $directory $webUser $Logfile

    #Step 3: Create New Application Pool
    #Create the new Application Pool 'DemoAppPool' for the new site if you deleted the one we created in the previous sample.  

    if (!(IIS.AppPool-Exists "EcmAppPool"))
    {
        New-Item IIS:\AppPools\EcmAppPool
    }
    if (!(IIS.AppPool-Exists "ECM"))
    {
        New-Item IIS:\AppPools\ECM
    }
    

    #Step 4: Create New Sites, Web Applications and Virtual Directories and Assign to Application Pool
    #Here comes the beef. We create EcmSite, DemoApp and two Virtual Directories - DemoVirtualDir1 is 
    #directly underneath EcmSite and DemoVirtualDir2 is underneath DemoApp. We are assigning EcmSite 
    #and DemoApp to DemoAppPool created in the previous step. EcmSite is assigned to port 8080 to not 
    #conflict with the 'Default Web Site'
    #[string]$TgtSite = “MyFileServer01"
    
    $site = "Default Web Site"
    $webapp = "EcmTestApp"
    $PPath = "c:\temp"
    $appPool = "ECM"
    $tgtpath = "" 
    
    $tgtpath = "c:\temp"
    AddWebApp  "Default Web Site" "EcmTestApp" $tgtpath "Ecm" $Logfile
    
    $tgtpath = "$global:WebSiteDir" + "AdminSetup"
    AddWebApp  "Default Web Site" "AdminSetup" $tgtpath $appPool $Logfile
    
    $tgtpath = "$global:WebSiteDir" + "Archive"
    AddWebApp  "Default Web Site" "Archive" $tgtpath $appPool $Logfile

    $tgtpath = "$global:WebSiteDir" + "ArchiveFS"
    AddWebApp  "Default Web Site" "ArchiveFS" $tgtpath $appPool $Logfile
    
    $tgtpath = "$global:WebSiteDir" + "ArchiverCLC"
    AddWebApp  "Default Web Site" "ArchiverCLC" $tgtpath $appPool $Logfile

    $tgtpath = "$global:WebSiteDir" + "AuthenticationSVC"
    AddWebApp  "Default Web Site" "AuthenticationSVC" $tgtpath $appPool $Logfile

    $tgtpath = "$global:WebSiteDir" + "CLC"
    AddWebApp  "Default Web Site" "CLC" $tgtpath $appPool $Logfile

    $tgtpath = "$global:WebSiteDir" + "ECMWebServices\SVCclcDownLoad"
    AddWebApp  "Default Web Site" "clcDownload" $tgtpath $appPool $Logfile

    $tgtpath = "$global:WebSiteDir" + "ClcDownloader"
    AddWebApp  "Default Web Site" "clcDownloader" $tgtpath $appPool $Logfile

    $tgtpath = "$global:WebSiteDir" + "EcmAuthenticationApp"
    AddWebApp  "Default Web Site" "EcmAuthenticationApp" $tgtpath $appPool $Logfile

    $tgtpath = "$global:WebSiteDir" + "EcmEncryptor"
    AddWebApp  "Default Web Site" "EcmEncryptor" $tgtpath  $appPool $Logfile

    $tgtpath = "$global:WebSiteDir" + "Search" 
    AddWebApp  "Default Web Site" "Search" $tgtpath $appPool $Logfile

    $tgtpath = "$global:WebSiteDir" + "SecureAttachAdmin"
    AddWebApp  "Default Web Site" "SecureAttachAdmin" $tgtpath $appPool $Logfile

    $tgtpath = "$global:WebSiteDir" + "EcmWebServices\SecureAttachAdminSVC"
    AddWebApp  "Default Web Site" "SecureAttachAdminSVC" $tgtpath $appPool $Logfile

    $tgtpath = "$global:WebSiteDir" + "EcmWebServices\SecureLogin"
    AddWebApp  "Default Web Site" "SecureLogin" $tgtpath $appPool $Logfile

    $tgtpath = "$global:WebSiteDir" + "SVCclcDownload"
    AddWebApp  "Default Web Site" "SVCclcDownload" $tgtpath $appPool $Logfile    

}

Function SetAccessFull($DirFQN, $UserID, $Logfile)
{

    $acl = Get-Acl $DirFQN
    $permission = $UserID,"FullControl","Allow"
    $accessRule = New-Object System.Security.AccessControl.FileSystemAccessRule $permission
    $acl.SetAccessRule($accessRule)
    $acl | Set-Acl $DirFQN
    Add-Content -Path $Logfile -Value "ID-200: Added full control to directory $DirFQN for user $UserID"
}

Function SetAccessFullOld($DirFQN, $UserID)
{
    $colRights = [System.Security.AccessControl.FileSystemRights]"FullControl" 
    $InheritanceFlag = [System.Security.AccessControl.InheritanceFlags]::None 
    $PropagationFlag = [System.Security.AccessControl.PropagationFlags]::None 

    $objType =[System.Security.AccessControl.AccessControlType]::Allow 
    $objUser = New-Object System.Security.Principal.NTAccount($UserID) 

    #$accessRule = New-Object System.Security.AccessControl.FileSystemAccessRule ($UserID, $colRights, $inherit, $propagation, "Allow")  
    $accessRule = New-Object System.Security.AccessControl.FileSystemAccessRule ($UserID, $colRights, $objType)  

    $objACL = Get-ACL $DirFQN
    $objACL.AddAccessRule($accessRule)  
    
    Set-Acl -aclobject $directory $objACL
}

#*******************************************************************
#* This allows a preexisting SQL script to be processed in a batch
#*******************************************************************
Function runSqlScript($SqlScriptFileFQN , $serverinstance, $database, $Username, $Password)
{ 
    # Reviev by Peter and Dale
    #Add-PSSnapin SqlServerCmdletSnapin100 
    #Add-PSSnapin SqlServerProviderSnapin100
    if (!$database){
        Write-Host "ERROR: Database name NULL for $SqlScriptFileFQN"
    }

    Write-Host "Executing $SqlScriptFileFQN" 
    ("Processing $SqlScriptFileFQN , $serverinstance, $database, $Username, $Password")
    invoke-sqlcmd -inputfile $SqlScriptFileFQN  -serverinstance $serverinstance -database $database -Username $Username -Password $Password -ConnectionTimeout 0
}

#****************************************************************************************************************
#* This allows a preexisting SQL script Designed to Specifically Create a new SQL DB to be processed in a batch
#****************************************************************************************************************
Function CreateNewDatabase($SqlScriptFileFQN , $LogFqn, $SqlSvrDataDir, $ServerInstanceName, $DataBaseName, $Username, $Password, $SqlScriptDIR, $TextToFind, $ReplaceText)
{

    $b =  DbExists $ServerInstanceName $DataBaseName $Username $Password

    if ($b)
    {
        return
    }

    $DirFQN = $SqlSvrDataDir    
    PS_ckDirectory $DirFQN  $LogFqn 

    $DataBaseName = "MASTER"

    GrepReplace $SqlScriptDIR $TextToFind $ReplaceText $SqlScriptFileFQN
    RemoveDups $SqlScriptFileFQN
    runSqlScript $SqlScriptFileFQN  $ServerInstanceName $DataBaseName $Username $Password    
}

Function GrepReplace($InputDirFQN, $TextToFind, $ReplaceText, $FQN)
{
    ##Finds all the occurrences in the dirname directory##
    # Set the name of the directory to be processed
    #$InputDirFQN = "C:\dev\EcmMasterSingleSource\PowerShellScripts\Idera\Idera_SQLServerScripts\SQL Server 2008"

    Get-Content $FQN

    Write-Host "InputDirFQN: $InputDirFQN"
    Write-Host "TextToFind: $TextToFind"
    Write-Host "ReplaceText: $ReplaceText"
    Write-Host "Filter: $FQN"

    #(Get-Content $FQN) | Foreach-Object {$_ -replace $TextToFind, $ReplaceText; $_} | Set-Content $FQN 
    #(Get-Content $FQN) | Foreach-Object {$_ -replace $TextToFind, $ReplaceText; $_}  | Set-Content c:\temp\Grepped.txt 

    (Get-Content $FQN) | Foreach { $_ -Replace $TextToFind, $ReplaceText } | Set-Content c:\temp\Grepped.txt ;

    if (Test-Path  ($i.fullname + "c:\temp\Grepped.txt"))
    {
        Write-Host "File Grepped.txt EXists"
        Get-Content c:\temp\Grepped.txt 

         Write-Host "Updating File: " + $FQN  
        copy-item -Path c:\temp\Grepped.txt -Destination $FQN  -Force  
        xcopy "c:\temp\Grepped.txt" "$FQN" /Y
    }
    else 
        {
        Write-Host "File c:\temp\Grepped.txt DOES NOT EXist"
        }
    

}

Function PromptUser($caption, $message)
{
    $yes = New-Object System.Management.Automation.Host.ChoiceDescription "&Yes",""
    $no = New-Object System.Management.Automation.Host.ChoiceDescription "&No",""
    $choices = [System.Management.Automation.Host.ChoiceDescription[]]($yes,$no)
    if ($caption)
    {
    }
    else 
    {
        $caption = "Warning!"
    }
    if ($message) 
    {
    }
    else
    {
        $message = "Do you want to proceed"
    }    
    $ans = "N"
    [int]$defaultChoice = 0
    $result = $Host.UI.PromptForChoice($caption,$message,$choices,$defaultChoice)
    if($result -eq 0) { Write-Host "You answered YES" }
    if($result -eq 1) { Write-Host "You answered NO" }
    return $result
}

Function PS_ckDirectory([string]$DirFQN, [string]$LogFqn)
{
    if (!$DirFQN)
    {
        Write-Host "ERROR IN DORECTORY LOOKUP NULL Direcotry " $DirFQN
    }
    $LogFile = $LogFqn 
    if (!(test-Path -path $DirFQN))
    {
        Write-Host "Created Directory " $DirFQN
        New-Item $DirFQN -type directory        
        Add-Content -Path $Logfile -Value "ID-100: Created Directory: $DirFQN"
    }
    else
    {
    Write-Host "Directory Exists, Skipping: " $DirFQN
        Add-Content -Path $Logfile -Value "ID-101: Found Directory.: $DirFQN"
    }
}

#**********************************************************************************************
#* Check a SQL database and determine whether or not the FileStream attribute is set on or off
#**********************************************************************************************
Function PS_ckFileStreamInstalled([string]$SVR, [string]$User, [string]$PWD, [string]$DB, [string]$TempDir)
{
# Reviev by Peter and Dale
    #add-pssnapin sqlserverprovidersnapin100
    #add-pssnapin sqlservercmdletsnapin100
    
    $TempDirFQN = $TempDir + "\_FSInstalled.csv"
    $ConfigValue = "" 
    $FSAccess = "" 

     Write-Host "FS SVR $SVR"
     Write-Host "FS User $User"
     Write-Host "FS PWD $PWD"
     Write-Host "FS DB $DB"

    $FSAccess  = invoke-sqlcmd -query "exec sp_configure 'filestream access level'" -Database $DB -ServerInstance $SVR -Username $User -Password $PWD | export-csv -path $TempDirFQN

    #import-csv .\customers.csv -header iCnt

    $FSList =Import-Csv $TempDirFQN
    foreach ($fs in $FSList ) 
    {
        write-host $fs
        $RunValue = $fs.run_value
        $ConfigValue = $fs.config_value
        write-host "FS RunValue: is $RunValue"
        write-host "FS ConfigValue: is $ConfigValue"
    }

    return $ConfigValue 

    #End of Function
}

#*****************************************************************************************************
#* Check a SQL database and determine whether or not the FullText indexing attribute is set on or off
#*****************************************************************************************************
Function PS_ckFullTextInstalled([string]$SVR, [string]$User, [string]$PWD, [string]$DB, [string]$TempDir)
{
# Reviev by Peter and Dale
    #add-pssnapin sqlserverprovidersnapin100
    #add-pssnapin sqlservercmdletsnapin100
    $TempDirFQN = $TempDir + "\_FTInstalled.csv"
    $FTValue = "" 
    $FSAccess = "" 
    
     Write-Host "FT SVR $SVR"
     Write-Host "FT User $User"
     Write-Host "FT PWD $PWD"
     Write-Host "FT DB $DB"

    $FTInstalled  = invoke-sqlcmd -query "select FULLTEXTSERVICEPROPERTY('IsFullTextInstalled')" -Database $DB -ServerInstance $SVR -Username $User -Password $PWD | export-csv -path $TempDirFQN

    $FTINSTALL =Import-Csv $TempDirFQN
    foreach ($FT in $FTINSTALL ) 
    {
        write-host $FT
        $FTValue = $FT.column1    
        write-host "FULL Text Value: is $FTValue"    
    }


    return $FTValue 
    #End of Function
}

#*******************************************************************
#* Check to see if SQL database currently exists on a server or not 
#*******************************************************************
Function ckDbExists([string]$SVR, [string]$User, [string]$PWD, [string]$DB, [string]$TempDir)
{

    Write-Host "ckDbExists SVR $SVR"
    Write-Host "ckDbExists User $User"
    Write-Host "ckDbExists DB $DB"

    #$DB = 'Ecm.library.fs'
    $SVR = $global:SSVR
    $U = $global:UNAME
    $P = $global:SVRPW
    $ConnStr = "Server="+$SVR+";Database=master;Integrated Security=false; User = '"+$U+"'; Password = '"+$P+"' ;"
    #Write-output $ConnStr

    $SqlConnection = New-Object System.Data.SqlClient.SqlConnection
    $SqlConnection.ConnectionString = $ConnStr
    $SqlConnection.Open()
    $SqlCmd = New-Object System.Data.SqlClient.SqlCommand
    $SqlCmd.CommandText = "SELECT count(*) as iCnt FROM master.dbo.sysdatabases where name = '" + $DB + "'"

    Write-Host "SQL: $SqlCmd.CommandText"

    $SqlCmd.Connection = $SqlConnection
    $dbcnt = $SqlCmd.ExecuteScalar()
    #$i = 0
    #while ($i -le $dbcnt.Length)
    #{
    #   Write-Host $dbcnt[$i]
    #   $i++
    #}

    #$Reader = $SqlCmd.ExecuteReader()
    #while ($Reader.Read()) {
    #     $dbcnt  = $Reader.GetValue($1)
    #     Write-output "dbcnt is " $dbcnt 
    #}
    $SqlConnection.Close()
    #Write-output "dbcnt is " $dbcnt 
    return $dbcnt 

}

#*******************************************************************
Function cntTables([string]$SVR, [string]$User, [string]$PWD, [string]$DB, [string]$TempDir)
{

    Write-Host "ckDbExists SVR $SVR"
    Write-Host "ckDbExists User $User"
    Write-Host "ckDbExists DB $DB"

    $DB = 'Ecm.library.fs'
    $SVR = $global:SSVR
    $U = $global:UNAME
    $P = $global:SVRPW
    $ConnStr = "Server="+$SVR+";Database="+$DB+";Integrated Security=false; User = '"+$U+"'; Password = '"+$P+"' ;"
    $SqlConnection = New-Object System.Data.SqlClient.SqlConnection
    $SqlConnection.ConnectionString = $ConnStr
    $SqlConnection.Open()
    $SqlCmd = New-Object System.Data.SqlClient.SqlCommand
    $SqlCmd.CommandText = "SELECT count(*) FROM sys.tables where type = 'U' "
    $SqlCmd.Connection = $SqlConnection
    $dbcnt = $SqlCmd.ExecuteScalar()
    $SqlConnection.Close()
    return $dbcnt 

}

Function ckDbExistsV1([string]$SVR, [string]$User, [string]$PWD, [string]$DB, [string]$TempDir)
{
# Reviev by Peter and Dale
    #add-pssnapin sqlserverprovidersnapin100
    #add-pssnapin sqlservercmdletsnapin100
    $TempDirFQN = $TempDir + "\_dbexists_" + $DB + ".csv"
    $FTValue = "" 
    $FSAccess = "" 
    
    Write-Host "ckDbExists SVR $SVR"
    Write-Host "ckDbExists User $User"
    #Write-Host "FT PWD $PWD"
    Write-Host "ckDbExists DB $DB"
    $MySql = "SELECT count(*) as iCnt FROM master.dbo.sysdatabases where name = '" + $DB + "'"
    $FTInstalled  = invoke-sqlcmd -query $MySql -Database "master" -ServerInstance $SVR -Username $User -Password $PWD | export-csv -path $TempDirFQN

    $FTINSTALL = Import-Csv $TempDirFQN 
    foreach ($FT in $FTINSTALL ) 
    {
        write-host "DBX: $FT"
        $FTValue = $FT.iCnt
        write-host "DB COL 0: $FT.iCnt"    
        write-host "DB COL 1: $FT.column1"    
    }

    if ($FTValue-eq "1")
    {
        Write-Host "Database $DB exists on Server $SVR"
    }
    else 
    {
        Write-Host "Database $DB DOES NOT exist on Server $SVR"
    }

    return $FTValue 
    #End of Function
}

#**********************************************************************************************
#* Execute a SQL script line by line if commands separated by the GO statement
#**********************************************************************************************
Function ProcessSqlScript($SqlScript, $SrvName, $DbName, $UserID, $PW, $MySql)
{
    $reader = [System.IO.File]::OpenText($SqlScript)
    $PrevLine = "" 
    try {
        for(;;) {
            $line = $reader.ReadLine()
            if ($line -eq $null) { break }
            # process the line
            if ($line.Trim().ToUpper().Equals("GO"))
            {
                ExecuteSql $SrvName $DbName $UserID $PW $PrevLine ;
                $PrevLine = "" ;
            }
            else 
            {
                $PrevLine = $PrevLine + " " + $line ;
            }
        }
    }
    finally {
        $reader.Close()
    }

}

#**********************************************************************************************
#* Execute a SQL query that does not return a value or rows
#**********************************************************************************************
Function ExecNonQuery($SrvName, $DbName, $UserID, $PW, $MySql)
{
    
    $con = New-Object Data.SqlClient.SqlConnection;
    try
    {
        $con.ConnectionString = "Data Source=$SrvName;Initial Catalog=$DbName;Integrated Security=false; User = '$UserID'; Password = '$PW' ;"
        $con.Open();

        # Create the database.
        $cmd = New-Object Data.SqlClient.SqlCommand $MySql, $con; 
        $cmd.connection = $con ;
        $cmd.CommandText = $MySql ;
        $cmd.ExecuteNonQuery();		
        Write-Host "Command was executed!";
    }
    catch
        {
            Write-host "`t`t$($MyInvocation.InvocationName): $_"
            Write-Error "`t`t$($MyInvocation.InvocationName): $_"
            
        }
    finally { 
        # Close & Clear all objects.
        $cmd.Dispose();
        $con.Close();
        $con.Dispose();
        }    
}


Function ExecuteSqlScriptSMOv1($SqlScript, $SrvName, $DbName, $UserID, $PW)
{
    $sr = New-Object System.IO.StreamReader($SqlScript)
    $SQL = $sr.ReadToEnd()

    #[String]$dbname = "MyNewDatabase";
    # Open ADO.NET Connection with Windows authentification to local SQLEXPRESS.
    $con = New-Object Data.SqlClient.SqlConnection;
    $con.ConnectionString = "Data Source=$SrvName;Initial Catalog=$DbName;Integrated Security=false; User = '$UserID'; Password = '$PW' ;"
    $con.Open();

    # Create the database.
    $cmd = New-Object Data.SqlClient.SqlCommand $sql, $con;
    $cmd.ExecuteNonQuery();		
    Write-Host "Database $SqlScript was executed!";


    # Close & Clear all objects.
    $cmd.Dispose();
    $con.Close();
    $con.Dispose();
}

Function ExecuteSqlScriptSMO($SqlScript, $SrvName, $DbName, $UserID, $PW)
{

    #Invoke-Sqlcmd -ServerInstance $SrvName -Dfatabase $DbName  -InputFile $SqlScript -SuppressProviderContextWarning -ErrorAction stop

    #$SqlScript = "C:\temp\TestSql.sql"
    $sr = New-Object System.IO.StreamReader($SqlScript)
    $script2 = $sr.ReadToEnd()
    #Write-Host ("script2 lines = $script2.count()")
    $null = [reflection.assembly]::LoadWithPartialName("Microsoft.SqlServer.Connect ionInfo")
    $null = [reflection.assembly]::LoadWithPartialName("Microsoft.SqlServer.SmoEnum ")
    $null = [reflection.assembly]::LoadWithPartialName("Microsoft.SqlServer.Smo")

    #$srvname="T410A\GINA"
    #$dbname="ECM.Library.FS"
    $mySrvConn = new-object Microsoft.SqlServer.Management.Common.ServerConnection
    $mySrvConn.ServerInstance=$srvname
    $mySrvConn.LoginSecure = $false
    $mySrvConn.Login = $UserID 
    $mySrvConn.Password = $PW

    $Server = new-object Microsoft.SqlServer.Management.Smo.Server($mySrvConn)
    
    $db = $server.Databases[$dbname]
    $extype = [Microsoft.SqlServer.Management.Common.ExecutionTypes]::Default

    Write-Host  "Applying: $SqlScript" 

    $RC = $db.ExecuteNonQuery( $script2, 0)
    #$RC = $db.ExecuteNonQuery( $script2)

    Write-Host "RC: $RC completed $SqlScript "
}

#***********************************************
#* Print a sorted list of items to the log file
#***********************************************
Function PrintSortedList( $myList, $LogFile ) 
{ 
    "`t-KEY-`t-VALUE-" 
    for ( [int] $i = 0; $i -lt $myList.Count; $i++ ) 
    { 
        "`t{0}:`t{1}" -F $myList.GetKey($i), $myList.GetByIndex($i) 
        $msg = "`t{0}:`t{1}" -F $myList.GetKey($i), $myList.GetByIndex($i) 
        Add-Content -Path $Logfile -Value $msg
    } 
    "" 
} 

Function CreateDbSMO ($SvrInstance, $DBNAME, $UID, $PW)
{
    #[String]$dbname = "MyNewDatabase";
    # Open ADO.NET Connection with Windows authentification to local SQLEXPRESS.
    $con = New-Object Data.SqlClient.SqlConnection;
    $con.ConnectionString = "Data Source=$SvrInstance;Initial Catalog=master;Integrated Security=false; User = '$UID'; Password = '$PW' ;"
    $con.Open();

    # Select-Statement for AD group logins
    $sql = "SELECT name
            FROM sys.databases
            WHERE name = '$dbname';";

    # New command and reader.
    $cmd = New-Object Data.SqlClient.SqlCommand $sql, $con;
    $rd = $cmd.ExecuteReader();
    if ($rd.Read())
    {	
	    Write-Host "Database $dbname already exists";
	    Return;
    }

    $rd.Close();
    $rd.Dispose();

    # Create the database.
    $sql = "CREATE DATABASE [$dbname];"
    $cmd = New-Object Data.SqlClient.SqlCommand $sql, $con;
    $cmd.ExecuteNonQuery();		
    Write-Host "Database $dbname is created!";


    # Close & Clear all objects.
    $cmd.Dispose();
    $con.Close();
    $con.Dispose();
}

Function DownLoadZipFile
{
    Param(
      [string]$DownLoadURL,
      [string]$DownLoadFQN,
      [string]$LogFile
    )
    Process
    {
        Write-Host "Downloading From: " $DownLoadURL
        Write-Host "Downloading TO  :  $DownLoadFQN , this can take several minutes, standby..."
        Write-Host "Starting @ " get-date
        #$DownLoadURL = "http://www.dmachicago.com//EcmUploadZip//SecureAttachAdmin//SecureAttachAdmin.zip"
        $wc = New-Object System.Net.WebClient
        $wc.DownloadFile($DownLoadURL, $DownLoadFQN)
        Write-Host "DOWNLOAD COMPLETE FOR: " $DownLoadFQN  
        Add-Content -Path $Logfile -Value "Downloaded ZIPFILE $DownLoadURL into $DownLoadFQN"      
        Write-Host "Ending @ " get-date
    }
}

Function UnZipFilePW ($pathToZipExe, $ZipFQN, $UnzipToDir, $Password, $LogFile)
{
        $PW = "-p" + $Password
        $UZIPDIR = "-o" + $UnzipToDir
        #[Array]$arguments = "e", "-y", "-oC:\TEMP\_UnzipTest", "-pEcm2013", "C:\PrePublishedWebSites\ECMSAAS\EcmUploadZip\EcmDBScripts\EcmDBScripts.zip"
        [Array]$arguments = "x", "-y", $UZIPDIR, $PW, $ZipFQN
        $exe = $pathToZipExe 
        & $exe $arguments;    
}

Function ZipFilePW ($pathToZipExe, $ZipThisDir, $ZipNAME, $Password, $Recurse, $LogFile)
{
    #7z u -r c:\temp\_xDbArch.zip C:\inetpub\wwwroot\Software\PowerShellInstallScripts_Bulova\DatabaseGenerationScripts
    $ZipToDir = "-o"+$ZipToDir
    $PW = "-p" + $Password
    #[Array]$arguments = "u", "-y", "-oC:\TEMP\_UnzipTest", $PW, "C:\PrePublishedWebSites\ECMSAAS\EcmUploadZip\EcmDBScripts\EcmDBScripts.zip"    
    if ($Recurse == "1")
    {
        [Array]$arguments = "u", "-r", $PW, $ZipNAME, $ZipThisDir
        $exe = $pathToZipExe + "\7z.exe "
        & $exe $arguments;    
    }
    else
    {
        [Array]$arguments = "u", $PW, $ZipNAME, $ZipThisDir
        $exe = $pathToZipExe + "\7z.exe "
        & $exe $arguments;    
    }    
}

Function fileExists ($FQN)
{
    $b = test-path $FQN
    "b = $b"
    reutrn b$
}

#**********************************************************************************************
#* Check a SQL database and determine whether or not it exists within the specifed instance
#**********************************************************************************************
Function DbExists ($SvrInstance, $DBNAME, $UID, $PW)
{
    Write-Host "Verify DB exists: $SvrInstance, $DBNAME"
    $b = 0
    
    $con = New-Object Data.SqlClient.SqlConnection;
    $con.ConnectionString = "Data Source=$SvrInstance;Initial Catalog=master;Integrated Security=false; User = '$UID'; Password = '$PW' ;"
    $con.Open();

    # Select-Statement for AD group logins
    $sql = "SELECT name
            FROM sys.databases
            WHERE name = '$dbname';";

    # New command and reader.
    $cmd = New-Object Data.SqlClient.SqlCommand $sql, $con;
    $rd = $cmd.ExecuteReader();
    if ($rd.Read())
    {	
	    Write-Host "Database $dbname already exists";
	    $B = 1
    }
    else 
    {
        $B = 0
    }

    $rd.Close();
    $rd.Dispose();
    $cmd.Dispose();
    $con.Close();
    $con.Dispose();

    return $b
}

Function ExecSQL([string]$SVR, [string]$User, [string]$PWD, [string]$DB, [string]$TempDir)
{
# Reviev by Peter and Dale
    #add-pssnapin sqlserverprovidersnapin100
    #add-pssnapin sqlservercmdletsnapin100
    $TempDirFQN = $TempDir + "\_dbexists_" + $DB + ".csv"
    $FTValue = "" 
    $FSAccess = "" 
    
    Write-Host "FT SVR $SVR"
    Write-Host "FT User $User"
    Write-Host "FT PWD $PWD"
    Write-Host "FT DB $DB"
    $MySql = "SELECT count(*) as iCnt FROM master.dbo.sysdatabases where name = '" + $DB + "'"
    $FTInstalled  = invoke-sqlcmd -query $MySql -Database "master" -ServerInstance $SVR -Username $User -Password $PWD | export-csv -path $TempDirFQN

    $FTINSTALL = Import-Csv $TempDirFQN 
    foreach ($FT in $FTINSTALL ) 
    {
        write-host "DBX: $FT"
        $FTValue = $FT.iCnt
        write-host "DB COL 0: $FT.iCnt"    
        write-host "DB COL 1: $FT.column1"    
    }


    return $FTValue 
    #End of Function
}

Function IIS.AppPool-Exists{
 
    <# .DESCRIPTION This Function will test to see if an AppPool exists and 
        return true uponsuccessful validation. 
        EXAMPLE IIS.AppPool-Exists -AppPoolName "MyNewAppPool" .EXTERNALHELP None. .FORWARDHELPTARGETNAME None. 
        INPUTS System.String 
        LINK None 
        NOTES 
        OUTPUTS Bool 
        PARAMETER AppPoolName A string representng the AppPool. 
        SYNOPSIS Test to see if AppPool exists. #>
 
    param(
        [parameter(Mandatory=$true)]
        [String]
        $AppPoolName
     )
 
    # Test is AppPool exists
     if(Test-Path IIS:\AppPools\$AppPoolName)
     {
        return $true;
     }
     else
     {
        return $false;
     }
 }

#**********************************************************************************************
#* Check an IIS installation to see if a WEB SITE is defined or not
#**********************************************************************************************
 Function ckWebExists ($SiteName)
 {
    $b = 0
    $alias = $SiteName
    $IISPath = "IIS:\Sites\Default Web Site\$alias"

    if (Test-Path $IISPath) 
    { 
        Write-Host "$alias exists." 
        $b = 1 
    }
    return $b
 }

 Function Load-Web-Administration
{
    $ModuleName = "WebAdministration"
    $ModuleLoaded = $false
    $LoadAsSnapin = $false

    if ($PSVersionTable.PSVersion.Major -ge 2)
    {
        if ((Get-Module -ListAvailable | ForEach-Object {$_.Name}) -contains $ModuleName)
        {
            Import-Module $ModuleName

            if ((Get-Module | ForEach-Object {$_.Name}) -contains $ModuleName)
                { $ModuleLoaded = $true } else { $LoadAsSnapin = $true }
        }
        elseif ((Get-Module | ForEach-Object {$_.Name}) -contains $ModuleName)
            { $ModuleLoaded = $true } else { $LoadAsSnapin = $true }
    }
    else
    { $LoadAsSnapin = $true }

    if ($LoadAsSnapin)
    {
        try
        {
            if ((Get-PSSnapin -Registered | ForEach-Object {$_.Name}) -contains $ModuleName)
            {
                if ((Get-PSSnapin -Name $ModuleName -ErrorAction SilentlyContinue) -eq $null) 
                    { Add-PSSnapin $ModuleName }

                if ((Get-PSSnapin | ForEach-Object {$_.Name}) -contains $ModuleName)
                    { $ModuleLoaded = $true }
            }
            elseif ((Get-PSSnapin | ForEach-Object {$_.Name}) -contains $ModuleName)
                { $ModuleLoaded = $true }
        }

        catch
        {
            Write-host "`t`t$($MyInvocation.InvocationName): $_"
            Write-Error "`t`t$($MyInvocation.InvocationName): $_"            
        }
    }
}

#**********************************************************************************************
#* Add a new web application to an instance of IIS
#**********************************************************************************************

Function AddWebApp($site, $webapp, $PPath, $AppPool, $Logfile)
{
#    $webapp = "EcmTestApp"
    if (ckWebExists $webapp)
    {
        echo "IIS $webapp already exists"
        Add-Content -Path $Logfile -Value "IIS $webapp already exists"
    }
    else
    {
        New-Webapplication -Site $site -Name $webapp -PhysicalPath $PPath -ApplicationPool $AppPool
        echo "Created IIS application, $webapp."
        Add-Content -Path $Logfile -Value "Created IIS application, $webapp."
    }
}

#**********************************************************************************************
#* Check the machine to see if a specific application is installed or not
#**********************************************************************************************
Function isAppInstalled ($TgtApp){
    $b= 0 
    #Get-WmiObject -Class Win32_Product | sort-object Name | select Name | where { $_.Name -match “Office”}
    $colItems = Get-WmiObject -Class Win32_Product | sort-object Name | select Name | where { $_.Name -match $TgtApp}
    foreach ($objItem in $colItems) {
        write-host "Name: " $objItem.name
        $b = $b + 1
    }
    return $b
}

#**********************************************************************
# Performs an ExecuteNonQuery command against the database connection. 
#**********************************************************************
Function ExecuteSql ($SrvName, $DbName, $UserID, $PW, $cmdText)
{ 
    $conStr = "Data Source=$SrvName;Initial Catalog=$DbName;Integrated Security=false; User = '$UserID'; Password = '$PW' ;"
    # Determine if parameters were correctly populated. 
    if (!$cmdText) 
    { 
        # One or more parameters didn't contain values. 
        write-Host "ExecNonQuery Function called with no connection string and/or command text." 
    } 
    else 
    { 
        write-Host "Creating SQL Connection..." 
        # Instantiate new SqlConnection object. 
        $Connection = New-Object System.Data.SQLClient.SQLConnection 
         
        # Set the SqlConnection object's connection string to the passed value. 
        $Connection.ConnectionString = $conStr 
         
        # Perform database operations in try-catch-finally block since database operations often fail. 
        try 
        { 
            write-Host "Opening SQL Connection..." 
            # Open the connection to the database. 
            $Connection.Open() 
             
            write-Host "Creating SQL Command..." 
            # Instantiate a SqlCommand object. 
            $Command = New-Object System.Data.SQLClient.SQLCommand 
            # Set the SqlCommand's connection to the SqlConnection object above. 
            $Command.Connection = $Connection 
            # Set the SqlCommand's command text to the query value passed in. 
            $Command.CommandText = $cmdText 
             
            write-Host "Executing SQL Command..." 
            # Execute the command against the database without returning results (NonQuery). 
            $Command.ExecuteNonQuery() 
        } 
        catch [System.Data.SqlClient.SqlException] 
        { 
            # A SqlException occurred. According to documentation, this happens when a command is executed against a locked row. 
            write-Host "One or more of the rows being affected were locked. Please check your query and data then try again." 
            write-Host System.Data.SqlClient.SqlException.message 
        } 
        catch 
        { 
            # An generic error occurred somewhere in the try area. 
            write-Host "An error occurred while attempting to open the database connection and execute a command." 
        } 
        finally { 
            # Determine if the connection was opened. 
            if ($Connection.State -eq "Open") 
            { 
                write-Host "Closing Connection..." 
                # Close the currently open connection. 
                $Connection.Close() 
            } 
        } 
    } 
} 

#**********************************************************************************************
#* Takes directory and backs up specified files to a backup directory and keeps a file history
#**********************************************************************************************
Function ExpandWebServices()
{
    $IISDIR = $global:WebSiteDir + "" ;

    if (!(test-Path -path "c:\ECM_Back"))
    {
        New-Item "c:\ECM_Back" -type directory    
        Write-Host "Directory ECM_Back created." 
    } 
    else 
    {
        Write-Host "Directory ECM_Back exists."
    }

    $DateStamp = get-date -uformat "%Y-%m-%d@%H-%M-%S"

    #********************************************************************************************************
    $path = $global:WebSiteDir + "Search\web.config"
    If(-not(Test-Path -path $path))
      {
        Write-Host "Search Web Config does not exist, cannot back it up." 
      }
    Else
     { 
        Copy-Item  $path "C:\ECM_Back\web.config" -Force
        Rename-Item "C:\ECM_Back\web.config" "C:\ECM_Back\web.config.search.$DateStamp.bak"

        Write-Host "Search Web Config Backed Up." 
     }

     #********************************************************************************************************
    $path = $global:WebSiteDir + "ECMWebServices\SecureAttachAdminSVC\web.config"
    If(-not(Test-Path -path $path))
      {
        Write-Host "SecureAttachAdmin Web Config does not exist, cannot back it up." 
      }
    Else
     { 
        Copy-Item  $path "C:\ECM_Back\web.config" -Force
        Rename-Item "C:\ECM_Back\web.config" "C:\ECM_Back\web.config.SecureAttachAdminSVC.$DateStamp.bak"

        Write-Host "SecureAttachAdmin Web Config Backed Up." 
     }

    $path = $global:WebSiteDir + "ECMWebServices\SecureLogin\web.config"
    If(-not(Test-Path -path $path))
      {
        Write-Host "SecureLogin Web Config does not exist, cannot back it up." 
      }
    Else
     { 
        Copy-Item  $path "C:\ECM_Back\web.config" -Force
        Rename-Item "C:\ECM_Back\web.config" "C:\ECM_Back\web.config.SecureLogin.$DateStamp.bak"

        Write-Host "SecureLogin Web Config Backed Up." 
     }

     #********************************************************************************************************
        $path = "C:\_ECMTEMP\_Archiver\setup.exe"
        If(-not(Test-Path -path $path))
        {
            Write-Host "_Archiver does not exist, cannot back it up." 
        }
        Else
        { 
            $path = $global:WebSiteDir + 'Archive'
            #Copy-Item "C:\_ECMTEMP\_Archiver" $path -Recurse -Force
            robocopy C:\_ECMTEMP\_Archiver $path /e /r:2 /w:2 /XO

            Write-Host "$path copied into the IIS folder" 
        }

        #********************************************************************************************************
        $path = "C:\_ECMTEMP\_ArchiveFS\setup.exe"
        If(-not(Test-Path -path $path))
        {
            Write-Host "ArchiveFS does not exist, cannot back it up." 
        }
        Else
        { 
            $path = $global:WebSiteDir + 'ArchiveFS'
            #Copy-Item "C:\_ECMTEMP\_ArchiveFS" $global:WebSiteDir + "ArchiveFS" -Recurse -Force
            robocopy C:\_ECMTEMP\_ArchiveFS $path /e /r:2 /w:2 /XO

            Write-Host "$path copied into the IIS folder" 
        }

        #********************************************************************************************************
        $path = "C:\_ECMTEMP\_ClcDownloader\publish.htm"
        If(-not(Test-Path -path $path))
        {
            Write-Host "CLC does not exist, cannot back it up." 
        }
        Else
        { 
            $path = $global:WebSiteDir + 'ArchiverCLC'
            #Copy-Item "C:\_ECMTEMP\_ClcDownloader" $global:WebSiteDir + "ArchiverCLC" -Recurse -Force
            robocopy C:\_ECMTEMP\_ClcDownloader $path /e /r:2 /w:2 /XO

            Write-Host "$path copied into the IIS folder" 
        }

        #********************************************************************************************************
        $path = "C:\_ECMTEMP\_ClcDownloader\publish.htm"
        If(-not(Test-Path -path $path))
        {
            Write-Host "CLC does not exist, cannot back it up." 
        }
        Else
        { 
            $path = $global:WebSiteDir + "ClcDownloader"
            #Copy-Item "C:\_ECMTEMP\_ClcDownloader\*.*" $path -Recurse -Force
            robocopy C:\_ECMTEMP\_ClcDownloader $path /e /r:2 /w:2 /XO

            Write-Host "$path copied into the IIS folder" 
        }

        $path = "C:\_ECMTEMP\_SecureAttachAdminSVC\SVCGateway.svc"
        If(-not(Test-Path -path $path))
         {
            Write-Host $path " does not exist, cannot back it up." 
        }
        Else
        { 
            $tpath = $global:WebSiteDir + 'Search' 
            robocopy C:\_ECMTEMP\_Search $tpath  /e /r:2 /w:2 /xf *.zip 
            #Copy-Item -Path "C:\_ECMTEMP\_Search" -Destination $tpath -recurse -Force
        }

        $path = "C:\_ECMTEMP\_SecureAttachAdminSVC\SVCGateway.svc"
        If(-not(Test-Path -path $path))
         {
            Write-Host $path " does not exist, cannot back it up." 
        }
        Else
        { 
            $tpath = $global:WebSiteDir + 'EcmWebServices\SecureAttachAdminSVC'
            robocopy C:\_ECMTEMP\_SecureAttachAdminSVC $tpath  /e /r:2 /w:2 /xf *.zip 
            #Copy-Item -Path "C:\_ECMTEMP\_SecureAttachAdminSVC"  -Destination $tpath -recurse -Force
        }

        $path = "C:\_ECMTEMP\_SecureLogin"
        If(-not(Test-Path -path $path))
         {
            Write-Host $path " does not exist, cannot back it up." 
        }
        Else
        { 
            $tpath = $global:WebSiteDir + 'EcmWebServices\SecureLogin'
            robocopy C:\_ECMTEMP\_SecureLogin $tpath  /e /r:2 /w:2 /xf *.zip 
            #Copy-Item -Path "C:\_ECMTEMP\_SecureLogin" -Destination $tpath -recurse -Force
        }

    #Now, fix the endpoints in the WEB Configs
}

function InventorySoftware
{
    $folder = 'C:\temp' 
    if ( -not (Test-Path $folder) ) {New-Item $folder  -Type Directory  | Out-Null}
    #Get-WmiObject -Class Win32_Product | Select-Object -Property Name > C:\temp\SoftwareInventory.txt
    Get-WmiObject -Class Win32_Product > C:\temp\SoftwareInventory.txt
}

Function FileExistsInInventory ($SearchString)
{
    #WDMXX
    $FileName = "C:\temp\SoftwareInventory.txt"
    if ( -not (Test-Path $FileName) ) 
    {
        InventorySoftware
    }
    #$SearchString = "Adobe PDF iFilter 9" 
    $Sel = select-string -pattern $SearchString -path $FileName 
    If ($Sel -eq $null) 
    {         
        return 0
    } 
    Else 
    { 
        return 1
    }
}

Function InstallSharePointMODI
{
wdmxx
    #************************************************************
    #* Install the Server Side OCR utility thru Office2007
    #$O2007Download = $global:TDIR +"\_Office2007\"
    $O2007Download = "C:\inetpub\wwwroot\ECMSaaS\_Software\SharePointDesignerMODI"

    $msifile = $O2007Download + 'SharePointDesigner.exe'
    $iFnd = IsSharePointInstalled $XDIR

    if ($iFnd -eq 0)
    {
        Write-Host -ForegroundColor red "SharePointDesigner MODI NOT installed, aborting."
    }
    else 
    {
        Write-Host "MODI 2007 installed, continuing."
    }

    #$iFnd = FileExistsInInventory 'Microsoft Office Enterprise 2007'
    if ($iFnd -eq 0)
    {
        Write-Host '00 - Installing: ' + $msifile
        $arguments= ' ' 
        Start-Process `
            -filepath  $O2007Download $msifile `
            -arg $arguments `
        -passthru | wait-process
    }
}

Function InstallServerSideOFFICE2007
{
    #************************************************************
    #* Install the Server Side OCR utility thru Office2007
    $O2007Download = 'C:\inetpub\wwwroot\ECMSaaS\_Software\Office2007\'
    
    $msifile = $O2007Download + 'setup.exe'
    
    $iFnd = Is2007Installed $XDIR
    if ($iFnd -eq 0)
    {
        Write-Host -ForegroundColor red "MODI 2007 NOT installed, aborting."
    }
    else 
    {
        Write-Host "MODI 2007 installed, continuing."
    }

    #$iFnd = FileExistsInInventory 'Microsoft Office Enterprise 2007'
    if ($iFnd -eq 0)
    {
        Write-Host '00 - Installing: ' + $msifile
        $arguments= ' ' 
        Start-Process `
            -filepath  $O2007Download $msifile `
            -arg $arguments `
        -passthru | wait-process
    }
}

Function Install7Zip
{
    #************************************************************
    #* Install the Server Side OCR utility
    $7ZPath = 'C:\inetpub\wwwroot\ECMSaaS\_Software\7z\'
 
    $msifile = $7ZPath + '7ZIP.7z913-x64.msi'
    $iFnd = FileExistsInInventory '7-zip'
    if ($iFnd -eq 0)
    {
    Write-Host '01 - Installing: ' + $msifile
    $arguments= ' ' 
    Start-Process `
        -filepath $msifile `
        -arg $arguments `
        -passthru | wait-process
    }
}

Function InstallServerSideOCR
{
#WDMXX
    #************************************************************
    #* Install the Server Side OCR utility
    $uPrompt = PromptUser "SERVER SIDE OCR" "Would you like to INSTALL the ServerSide OCR Functionality?"
    if ($uPrompt -eq 0)
    {
        #$PathConsoleArchiver = $global:TDIR +"\_ServerSideOCR\Setup\"
        $PathConsoleArchiver = "C:\inetpub\wwwroot\ECMSaaS\ServerSideOCR\"
        $msifile = $PathConsoleArchiver + 'Setup.exe'
        
        $iFnd = FileExistsInInventory 'ECM Serverside Ocr'
        if ($iFnd -eq 0)
        {
        Write-Host '02 - Installing: ' + $msifile
        $arguments= ' ' 
            Start-Process `
                -file  $msifile `
                -arg $arguments `
                -passthru | wait-process
                }
    }
}


#**********************************************************************************************
#* Insalls iFilters on the system.
#**********************************************************************************************
Function SetupiFilters
{   

    #$tpath = $global:TDIR +"\_IFilters\"
    #$tpath = 'C:\inetpub\wwwroot\ECMSaaS\_Software\iFilters\'
    $tpath  = 'C:\_ECMTEMP\_SoftWare\iFilters\'
    
    $msifile = $tpath + 'MsgFilt.msi'
     if (!(Test-Path $msifile))
    {
        Write-Host -ForegroundColor red $msifile + "IS MISSING - 011" 
        MessageBox($msifile + "IS MISSING!")
    }

    $iFnd = FileExistsInInventory  'Windows Desktop Search: Add-in for Outlook'
    if ($iFnd -eq 0)
    {
    Write-Host '13 - Installing: ' + $msifile
    $arguments= ' ' 
    Start-Process `
         -file  $msifile `
         -arg $arguments `
         -passthru | wait-process
         }


    $msifile = $tpath + 'Citeknet.ZIP.IFilter.x64.Setup-2.1.msi'
    $iFnd = 1 
    Write-Host  $msifile
    if (!(Test-Path $msifile))
    {
        Write-Host -ForegroundColor red $msifile + "IS MISSING - 000" 
        MessageBox($msifile + "IS MISSING!")
    }
    Write-Host  'From within PS_ECM_FunctionsV2::SetupiFilters, the iFilters directory is set to ' + $tpath + '.'
    $iFnd = FileExistsInInventory 'Citeknet ZIP IFilter'
    if ($iFnd -eq 0)
    {
    Write-Host '03 - Installing: ' + $msifile
    $arguments= ' ' 
    Start-Process `
         -file  $msifile `
         -arg $arguments `
         -passthru | wait-process
    }
    
    $msifile = $tpath + 'Citeknet.WDS.Mail.Addin.Setup-0.7.msi'
     if (!(Test-Path $msifile))
    {
        Write-Host -ForegroundColor red $msifile + "IS MISSING - 001" 
        MessageBox($msifile + "IS MISSING!")
    }
    
    $iFnd = FileExistsInInventory 'Citeknet WDS'
    if ($iFnd -eq 0)
    {
    Write-Host '04 - Installing: ' + $msifile
    $arguments= ' ' 
    Start-Process `
         -file  $msifile `
         -arg $arguments `
         -passthru | wait-process
    }

    $msifile = $tpath + 'Citeknet.RAR.IFilter.Setup-1.5.3.msi'
    if (!(Test-Path $msifile))
    {
        Write-Host -ForegroundColor red $msifile + "IS MISSING - 002" 
        MessageBox($msifile + "IS MISSING!")
    }

    $iFnd = FileExistsInInventory 'Citeknet RAR IFilter'
    if ($iFnd -eq 0)
    {
    Write-Host '05 - Installing: ' + $msifile
    $arguments= ' ' 
    Start-Process `
         -file  $msifile `
         -arg $arguments `
         -passthru | wait-process
    }
    
    $msifile = $tpath + 'Citeknet.IFilterExplorer.x64.Setup-2.0.msi'
     if (!(Test-Path $msifile))
    {
        Write-Host -ForegroundColor red $msifile + "IS MISSING - 003" 
        MessageBox($msifile + "IS MISSING!")
    }
    
    $iFnd = FileExistsInInventory 'Citeknet IFilter Explorer'
    if ($iFnd -eq 0)
    {
    Write-Host '06 - Installing: ' + $msifile
    $arguments= ' ' 
    Start-Process `
         -file  $msifile `
         -arg $arguments `
         -passthru | wait-process
         }

    $msifile = $tpath + 'Citeknet.HLP.IFilter.Setup-1.5.3.msi'
     if (!(Test-Path $msifile))
    {
        Write-Host -ForegroundColor red $msifile + "IS MISSING - 004" 
        MessageBox($msifile + "IS MISSING!")
    }
    
    $iFnd = FileExistsInInventory 'Citeknet HLP IFilter'
    if ($iFnd -eq 0)
    {
    Write-Host '07 - Installing: ' + $msifile
    $arguments= ' ' 
    Start-Process `
         -file  $msifile `
         -arg $arguments `
         -passthru | wait-process
         }

    $msifile = $tpath + 'Citeknet.EXE.IFilter.Setup-1.5.3.msi'
     if (!(Test-Path $msifile))
    {
        Write-Host -ForegroundColor red $msifile + "IS MISSING - 005" 
        MessageBox($msifile + "IS MISSING!")
    }
    
    $iFnd = FileExistsInInventory 'Citeknet EXE IFilter'
    if ($iFnd -eq 0)
    {
    Write-Host '08 - Installing: ' + $msifile
    $arguments= ' ' 
    Start-Process `
         -file  $msifile `
         -arg $arguments `
         -passthru | wait-process
         }

    $msifile = $tpath + 'Citeknet.CHM.IFilter.x86.Setup-2.1.msi'
     if (!(Test-Path $msifile))
    {
        Write-Host -ForegroundColor red $msifile + "IS MISSING - 006" 
        MessageBox($msifile + "IS MISSING!")
    }
    
    $iFnd = FileExistsInInventory 'Citeknet CHM IFilter'
    if ($iFnd -eq 0)
    {
    Write-Host '09 - Installing: ' + $msifile
    $arguments= ' ' 
    Start-Process `
         -file  $msifile `
         -arg $arguments `
         -passthru | wait-process
         }

    $msifile = $tpath + 'Citeknet.CAB.IFilter.Setup-1.5.3.msi'
    if (!(Test-Path $msifile))
    {
        Write-Host -ForegroundColor red $msifile + "IS MISSING - 007" 
        MessageBox($msifile + "IS MISSING!")
    }
    
    $iFnd = FileExistsInInventory 'Citeknet CAB IFilter'
    if ($iFnd -eq 0)
    {
    Write-Host '10 - Installing: ' + $msifile
    $arguments= ' ' 
    Start-Process `
         -file  $msifile `
         -arg $arguments `
         -passthru | wait-process
         }


    $msifile = $tpath + 'FilterPack64bit.exe'
     if (!(Test-Path $msifile))
    {
        Write-Host -ForegroundColor red $msifile + "IS MISSING - 008" 
        MessageBox($msifile + "IS MISSING!")
    }
    $iFnd = FileExistsInInventory 'Microsoft Filter Pack 1.0'
    $iFnd2 = FileExistsInInventory 'Microsoft Filter Pack 2.0'
    if ($iFnd -eq 0 -or $iFnd2 -eq 0)
    {
    $arguments= '/norestart' 
    Start-Process `
         -file  $msifile `
         -arg $arguments `
         -passthru | wait-process
         }

    $msifile = $tpath + 'ifilterexplorersetup-1.6.msi'
     if (!(Test-Path $msifile))
    {
        Write-Host -ForegroundColor red $msifile + "IS MISSING - 009" 
        MessageBox($msifile + "IS MISSING!")
    }
    
    $iFnd = FileExistsInInventory 'IFilter Explorer'
    if ($iFnd -eq 0)
    {
    Write-Host '11 - Installing: ' + $msifile
    $arguments= ' ' 
    Start-Process `
         -file  $msifile `
         -arg $arguments `
         -passthru | wait-process
         }

    $msifile = $tpath + 'Microsoft.iFilterPackx64.exe'
     if (!(Test-Path $msifile))
    {
        Write-Host -ForegroundColor red $msifile + "IS MISSING - 010" 
        MessageBox($msifile + "IS MISSING!")
    }
    
    $iFnd = FileExistsInInventory 'Microsoft Filter Pack 1.0'
    $iFnd2 = FileExistsInInventory 'Microsoft Filter Pack 2.0'
    if ($iFnd -eq 0 -or $iFnd2 -eq 0)
    {
    Write-Host '12 - Installing: ' + $msifile
    $arguments= ' ' 
    Start-Process `
         -file  $msifile `
         -arg $arguments `
         -passthru | wait-process
         }
    

    $msifile = $tpath + 'PDFFilter64installer.msi'
     if (!(Test-Path $msifile))
    {
        Write-Host -ForegroundColor red $msifile + "IS MISSING - 012" 
        MessageBox($msifile + "IS MISSING!")
    }
    
    $iFnd = FileExistsInInventory 'Adobe PDF iFilter 9'
    if ($iFnd -eq 0)
    {
    Write-Host '14 - Installing: ' + $msifile
    $arguments= ' ' 
    Start-Process `
         -file  $msifile `
         -arg $arguments `
         -passthru | wait-process
         }

    $Win = get-childitem -path env:windir
    $tdir = "$win\PDFFilter.dll"
    If(-not(Test-Path -path $tdir))
    {        
        xcopy "C:\Program Files\Adobe\Adobe PDF iFilter 9 for 64-bit platforms\bin\PDFFilter.dll" "$win\*.*" /Y
    }     
}

#**********************************************************************************************
#* Run grep and replace on a directory and its sub-directories
#**********************************************************************************************
Function GrepDirectory($InputDirFQN, $TextToFind, $ReplaceText, $Filter)
{
    $SL = new-object system.collections.SortedList
    cd $InputDirFQN
    $files = Get-ChildItem -Filter $Filter -Recurse | Select-String $TextToFind
    $i = 0 
     foreach($file in $files) 
    {    
        Write-Host $file.Path
        $fqn = $file.Path
        if ($file.Path)
        {
            if ($SL.Contains(($file.Path)))
            {
                Write-Host "SKIPPING - VALUE $token already loaded."
            }
            else
            {
                $i = $i+ 1
                $SL.Add($fqn, $i)
                Write-Host $fqn
                #((Get-Content $fqn) -creplace $match,$replacement) | set-content $filename 
            }               
        }                    
    } 

    foreach($key in $SL.Keys) 
    {
        $FQN = $key      
        Write-Host "Processing file: $FQN" 
        GrepReplace $InputDirFQN $TextToFind $ReplaceText $FQN
    }
     Write-Host "Done..."

}

Function SetupOcrTask ($ADMINUSER, $ADMINPASSWORD, $EcmOcrFQN)
{
    $da = Get-date
    $SDate = $da.Month.ToString() + "/" +$da.Day.ToString() + "/" + $da.Year.ToString()
    $hr = $da.Hour
    $mn = $da.Minute
    if ($mn -gt 57)
    {
    $hr= $hr + 1
    $mn = 5
    }
    $CurrentHour = $hr.ToString() + $mn.ToString()
    $ArchiceParms = " /Create /SC MINUTE /MO 5 /TN ECMOCR /TR $EcmOcrFQN /ST 12:00 /ET 14:00 /SD 06/06/2006 /ED 06/06/2006 /RU '$ADMINUSER' /RP '$ADMINPASSWORD'"

    $app ="SCHTASKS"    
    try 
    {
        invoke-expression "$app $ArchiceParms"
    }
    catch [system.exception]
    {
        $err = system.exception ;
        MessageBox("Failed to SCHEDULE the OCR task, please do it manually. $err")
    }
    
}

Function MessageBox($message)
{
    $caption = "Notify"
    $ok = New-Object System.Management.Automation.Host.ChoiceDescription "&OK",""
    $choices = [System.Management.Automation.Host.ChoiceDescription[]]($ok)
    
    [int]$defaultChoice = 0
    $Host.UI.PromptForChoice($caption,$message,$choices,$defaultChoice)
    
}

Function getPowerShellVersion()
{
    $v =$Host.Version.Major
    #$v =$Host.Version.Major.ToInt32()
    return $v
}


Function IsSharePointInstalled ($InventoryFileFqn){
    # Open files for reading/writing line by line
    $reader = New-Object System.IO.StreamReader($InventoryFileFqn)

    $rc= 0 
    # Process lines until in.csv ends
    while (($line = $reader.ReadLine()) -ne $null) {
        if ($line.Contains("Microsoft Office"))
        {
            if ($line.Contains("2007"))
            {
                $rc = 1 
                break
            }
        }
        if ($line.Contains("Microsoft Office SharePoint"))
        {
            if ($line.Contains("2007"))
            {
                $rc = 1 
                break
            }
        }
    }

    # Close the file handles
    $reader.Close()
    Write-Host ("RC = $rc")

}

Function Is2007Installed ($InventoryFileFqn){
    # Open files for reading/writing line by line
    $reader = New-Object System.IO.StreamReader($InventoryFileFqn)

    $rc= 0 
    # Process lines until in.csv ends
    while (($line = $reader.ReadLine()) -ne $null) {
        if ($line.Contains("Microsoft Office"))
        {
            if ($line.Contains("2007"))
            {
                $rc = 1 
                break
            }
        }
        if ($line.Contains("Microsoft Office SharePoint"))
        {
            if ($line.Contains("2007"))
            {
                $rc = 1 
                break
            }
        }
    }

    # Close the file handles
    $reader.Close()
    Write-Host ("RC = $rc")

}


Function isInstallServerSideOCR ($InventoryFileFqn){
    # Open files for reading/writing line by line
    $reader = New-Object System.IO.StreamReader($InventoryFileFqn)

    $rc= 0 
    # Process lines until in.csv ends
    while (($line = $reader.ReadLine()) -ne $null) {
        if ($line.Contains("Microsoft Office"))
        {
            if ($line.Contains("2007"))
            {
                $rc = 1 
                break
            }
        }
    }

    # Close the file handles
    $reader.Close()
    Write-Host ("RC = $rc")

}

function getComputerName
{
    $ComputerName = [System.Net.Dns]::GetHostName()
    Write-Output "@1 -> $ComputerName"
    return $ComputerName
}
function getIpAddress
{
    $c = [System.Net.Dns]::GetHostName()
    $ipV4 = Test-Connection -ComputerName ($c ) -Count 1  | Select -ExpandProperty IPV4Address
    $ip = $ipV4.IPAddressToString
    #Write-Output "IPV4Address -> $ip" 
    return $ip
}

