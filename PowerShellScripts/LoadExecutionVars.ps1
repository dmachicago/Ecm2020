Import-Module sqlps -DisableNameChecking

function setConnectionStrings(){
    #*********************************************************************************************
    #* Required passwords needed to be encrypted
    $global:GPW = "pclJunebug1";
    $global:globalPWFS = "pclJunebug1";
    #*********************************************************************************************
    #* SET CONNECTION STRINGS#*Connection Strings
    #*The following WILL NOT be encrypted as the @@PW@@ will be used.
    $global:CSECMSecureLogin= "Data Source=SVR2016;Initial Catalog=ECM.SecureLogin;Persist Security Info=True;User ID=ecmlibrary;Password=@@PW@@; Timeout=30;";
    $global:CSECMREPO = "Data Source=SVR2016;Initial Catalog=ECM.Library.FS;Persist Security Info=True;User ID=ecmlibrary;Password=@@PW@@; Timeout=30;" ;

    #The following will BE encrypted
    $global:gECMGATEWAY = "Data Source=SVR2016;Initial Catalog=ECM.SecureLogin;Persist Security Info=True;User ID=ecmlibrary;Password=pclJunebug1; Connect Timeout = 30;" ;
    $global:gENCECMREPO = "Data Source=SVR2016;Initial Catalog=ECM.Library.FS;Persist Security Info=True;User ID=ecmlibrary;Password=pclJunebug1; Connect Timeout = 30;";
    $global:gHELPDB = "Data Source=ecmadmin.db.3591434.hostedresource.com; Initial Catalog=ecmadmin; User ID=ecmadmin; Password='Junebug1';" ;
    $Global:gECMFSENC = "Data Source=SVR2016;Initial Catalog=Ecm.Library.FS;Persist Security Info=True;User ID=ecmlibrary;Password=pclJunebug1;  Connect Timeout =  30;" ;
    $Global:gThesaurus = "Data Source=SVR2016;Initial Catalog=ECM.Thesaurus;Persist Security Info=True;User ID=ecmlibrary;Password=pclJunebug1;  Connect Timeout =  30;" ;
    $Global:gECMGWAY = "Data Source=SVR2016;Initial Catalog=ECM.SecureLogin;Persist Security Info=True;User ID=ecmlibrary;Password=pclJunebug1;  Connect Timeout =  30;" ;
    $Global:gECMFS = "Data Source=SVR2016;Initial Catalog=Ecm.Library.FS;Persist Security Info=True;User ID=ecmlibrary;Password=pclJunebug1;  Connect Timeout =  30;" ;
    $global:gECMREPO = "Data Source=SVR2016;Initial Catalog=Ecm.Library.FS;Persist Security Info=True;User ID=ecmlibrary;Password=pclJunebug1;  Connect Timeout =  30;" ;
    $global:gHIVEDB = "Data Source=SVR2016;Initial Catalog=ECM.Hive;Persist Security Info=True;User ID=ecmlibrary;Password=pclMySister1;  Connect Timeout =  30; " ;
    #*********************************************************************************************
}

function addListItems($tkey, $tval)
{        
        if ($tkey)
        {
            if ($tval)
            {
                $msg = "$global:token NOT FOUND adding to list..."
                Write-Host $msg
                Add-Content -Path $Logfile -Value "* $msg : $tkey : $tval"
                $tempvar = $global:slVars[$tkey]
                if ($tempvar)
                {
                    $msg = "$tkey already exists..."
                    Write-Host $msg
                }
                elseif (!$tempvar)
                {
                    Write-Host "$tkey : adding to var list" 
                    $global:tVal.Trim($tval)
                    $global:slVars.Add($tkey, $tval)
                }
                else 
                {
                    Write-Host "$tkey : skipping, exists" 
                }                
            }                
        }
            
}

function LoadSetupVars{

    #********************************************************************************************
    #**** START BY LOADING THE VARIABLES SO ALL THE REST OF THE SCRIPTS CAN PROCESS USING THEM.
    #**** INITIALIZE THE VARIABLES AND REFER TO THE VAR FILE FOR DESCRIPTIONS OF THE VARS
    #********************************************************************************************

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
    $global:OCRSVR = "" 
    $global:7ZIPPATH = "" 

    $global:SqlSvrDataDir = "" 
    $global:ECMBACKUPDIR

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
    $global:PASSWORD =""
    $global:WebSiteDir = "" 

    #*The url where the DOWNLOADER will be retrieved
    #DOWNLOADERURL|http://108.61.17.163/ClcDownloader/publish.htm
    #*The url where the ARCHIVER will be retrieved
    #ARCHIVERURL|http://108.61.17.163/Archivefs/SVCFS.svc
    $global:DOWNLOADERURL = "" 
    $global:ARCHIVERURL = "" 


    #*************************************************************************************************************
    # IT IS CRITICAL TO SET THESE VARIABLES
    #*************************************************************************************************************
    $global:slVars = new-object system.collections.SortedList
    $global:MasterDir = "C:\inetpub\wwwroot\ECMSAAS\_PSscripts"
    Import-Module -Name "C:\inetpub\wwwroot\ECMSAAS\_PSscripts\PS_ECM_FunctionsV2.ps1"
    $data = Get-Content "C:\inetpub\wwwroot\ECMSAAS\_PSscripts\ECM.PS.VARS.txt"

    #Write-Host $data

    $v1 = $psversiontable.psversion
    $v = getPowerShellVersion


    if ($global:slVars.contains("PSVER"))
    {
        Write-Host "SKIPPING - VALUE PSVER already loaded."
    }
    else
    {
        $global:slVars.Add("PSVER", $v)
        Write-Host "Adding SortedList: PSVER , $v"
    }  
    if ($v -lt 5)
    {
        Write-Host ("Powershell Version $v is NOT a usable version of PowerShell, continuing, aborting.")
        MessageBox("Powershell Version $v is NOT a usable version of PowerShell, continuing, aborting.")
        exit
    }
    else 
    {
        Write-Host ("Powershell Version $v is a usable version of PowerShell, continuing.")
    }

    write-host $data.count total lines read from file
$i = 0 
foreach ($line in $data)
{
    $i = $i + 1
    $iLen = $line.trim().Length    
    #write-host "Line Len = $iLen"
    
    #The key is $_, which stands for the current variable in the pipeline.
    if ($line.StartsWith("*"))
    {
        Write-Host "$_ is a COMMENT"
    }
    elseif ($iLen = 0)
    {
        write-host "Skipping # $i"
    }    
    else
    {
        $global:tokens = $line.Split("~")
        $global:token = $global:tokens[0].ToUpper()
        $global:tVal= $global:tokens[1]

        
        $global:token.Trim($global:token)
        if ($global:tVal)
        {
            $s = $global:tVal 
            $global:tVal.Trim()
        }
        

                
        if (!$global:token.Length.Equals(0))
        {
            Write-Host "THE LINE: '$global:tokens'"
            Write-Host "The TOKEN:  '$global:token'"
            Write-Host "The VALUE: '$global:tVal'"
            if ($Logfile)
            {
                Add-Content -Path $Logfile -Value "PARM: $global:tokens / Tok[0]: $global:token / tVal: $global:tVal "
                                
                if (!$global:tVal.Length.Equals(0))
                {
                    if ($global:slVars.contains($global:token.ToUpper()))
                    {
                        Write-Host "SKIPPING - VALUE $global:token already loaded."
                    }
                    else
                    {
                        addListItems $global:token.ToUpper() $global:tVal
                        Write-Host "Adding SortedList: $global:token , $global:tVal"
                    }                    
                }
                else 
                {
                    Write-Host "SKIPPING - NULL VALUE FOUND IN: $global:token"
                }
            }     
            else 
            {            
                $Logfile = "C:\temp\_ECM.LoadExecutionVars.LOG.txt"                
                Add-Content -Path $Logfile -Value "PARM: $global:tokens / Tok[0]: $global:token / tVal: $global:tVal "
                Add-Content -Path $Logfile -Value "MISSING LOG: "            
            }       
        }

        if ($global:token.Length.Equals(0))
        {
            Write-Host "Skipping line # $i"
        }
        
        if ($global:token.ToUpper().Equals("WEBSITEDIR"))
        {
            $global:tVal.Trim($global:tVal)
            $global:WebSiteDir = $global:tVal
            addListItems $global:token.ToUpper() $global:tVal
            
            addListItems $global:token.ToUpper() $global:tVal
            $msg = "Web Site Directory: $global:tVal"
            Write-Host $msg
            Add-Content -Path $Logfile -Value "* $msg"
        }                
        elseif ($global:token.ToUpper().Equals("SSVER"))
        {
            $global:tVal.Trim($global:tVal)
            $global:SSVer = $global:tVal
            addListItems $global:token.ToUpper() $global:tVal
            $msg = "EndPointArchiver Server: $global:tVal"
            Write-Host $msg
            Add-Content -Path $Logfile -Value "* $msg"
        }

        if ($global:token.ToUpper().Equals("INVSVR"))
        {
            $global:tVal.Trim($global:tVal)
            $global:invsvr = $global:tVal
            addListItems $global:token.ToUpper() $global:tVal
            
            addListItems $global:token.ToUpper() $global:tVal
            $msg = "Inventory Server: $global:tVal"
            Write-Host $msg
            Add-Content -Path $Logfile -Value "* $msg"
        }        
        elseif ($global:token.ToUpper().Equals("SSVER"))
        {
            $global:tVal.Trim($global:tVal)
            $global:SSVer = $global:tVal
            addListItems $global:token.ToUpper() $global:tVal
            $msg = "EndPointArchiver Server: $global:tVal"
            Write-Host $msg
            Add-Content -Path $Logfile -Value "* $msg"
        }        
        elseif ($global:token.ToUpper().Equals("ECMBACKUPDIR"))
        {
            $global:tVal.Trim($global:tVal)
            $global:7ZIPPATH = $global:tVal
            addListItems $global:token.ToUpper() $global:tVal
            $msg = "EndPointArchiver Server: $global:tVal"
            Write-Host $msg
            Add-Content -Path $Logfile -Value "* $msg"
        }
        elseif ($global:token.ToUpper().Equals("7ZIPPATH"))
        {
            $global:tVal.Trim($global:tVal)
            $global:7ZIPPATH = $global:tVal
            addListItems $global:token.ToUpper() $global:tVal
            $msg = "EndPointArchiver Server: $global:tVal"
            Write-Host $msg
            Add-Content -Path $Logfile -Value "* $msg"
        }
    
    elseif ($global:token.ToUpper().Equals("ADMINPASSWORD"))
        {
            $global:tVal.Trim($global:tVal)
            $global:ADMINPASSWORD = $global:tVal
            addListItems $global:token.ToUpper() $global:tVal
            $msg = "EndPointArchiver Server: $global:tVal"
            Write-Host $msg
            Add-Content -Path $Logfile -Value "* $msg"
        }
    elseif ($global:token.ToUpper().Equals("ADMINUSER"))
        {
            $global:tVal.Trim($global:tVal)
            $global:ADMINUSER = $global:tVal
            addListItems $global:token.ToUpper() $global:tVal
            $msg = "EndPointArchiver Server: $global:tVal"
            Write-Host $msg
            Add-Content -Path $Logfile -Value "* $msg"
        }
    elseif ($global:token.ToUpper().Equals("NEWENDPOINTSEARCH"))
        {
            $global:tVal.Trim($global:tVal)
            $global:NEWENDPOINTSEARCH = $global:tVal
            addListItems $global:token.ToUpper() $global:tVal
            $msg = "EndPointArchiver Server: $global:tVal"
            Write-Host $msg
            Add-Content -Path $Logfile -Value "* $msg"
        }
    elseif ($global:token.ToUpper().Equals("NEWENDPOINTGATEWAY"))
        {
            $global:tVal.Trim($global:tVal)
            $global:NEWENDPOINTGATEWAY = $global:tVal
            addListItems $global:token.ToUpper() $global:tVal
            $msg = "EndPointArchiver Server: $global:tVal"
            Write-Host $msg
            Add-Content -Path $Logfile -Value "* $msg"
        }
    elseif ($global:token.ToUpper().Equals("NEWENDPOINTARCHIVE"))
        {
            $global:tVal.Trim($global:tVal)
            $global:NEWENDPOINTARCHIVE = $global:tVal
            addListItems $global:token.ToUpper() $global:tVal
            $msg = "EndPointArchiver Server: $global:tVal"
            Write-Host $msg
            Add-Content -Path $Logfile -Value "* $msg"
        }
    elseif ($global:token.ToUpper().Equals("NEWENDPOINTARCHIVER"))
        {
            $global:tVal.Trim($global:tVal)
            $global:NEWENDPOINTARCHIVER = $global:tVal
            addListItems $global:token.ToUpper() $global:tVal
            $msg = "EndPointArchiver Server: $global:tVal"
            Write-Host $msg
            Add-Content -Path $Logfile -Value "* $msg"
        }
    elseif ($global:token.ToUpper().Equals("ENDPOINTSEARCH"))
        {
            $global:tVal.Trim($global:tVal)
            $global:ENDPOINTSEARCH = $global:tVal
            addListItems $global:token.ToUpper() $global:tVal
            $msg = "EndPointArchiver Server: $global:tVal"
            Write-Host $msg
            Add-Content -Path $Logfile -Value "* $msg"
        }
    elseif ($global:token.ToUpper().Equals("ENDPOINTGATEWAY"))
        {
            $global:tVal.Trim($global:tVal)
            $global:ENDPOINTGATEWAY = $global:tVal
            addListItems $global:token.ToUpper() $global:tVal
            $msg = "EndPointArchiver Server: $global:tVal"
            Write-Host $msg
            Add-Content -Path $Logfile -Value "* $msg"
        }
        
        elseif ($global:token.ToUpper().Equals("ENDPOINTARCHIVE"))
        {
            $global:tVal.Trim($global:tVal)
            $global:ENDPOINTARCHIVE = $global:tVal
            addListItems $global:token.ToUpper() $global:tVal
            $msg = "EndPointArchiver Server: $global:tVal"
            Write-Host $msg
            Add-Content -Path $Logfile -Value "* $msg"
        }
                    
        elseif ($global:token.ToUpper().Equals("ENDPOINTARCHIVER"))
        {
            $global:tVal.Trim($global:tVal)
            $global:ENDPOINTARCHIVER = $global:tVal
            addListItems $global:token.ToUpper() $global:tVal
            $msg = "EndPointArchiver Server: $global:tVal"
            Write-Host $msg
            Add-Content -Path $Logfile -Value "* $msg"
        }
        
        elseif ($global:token.ToUpper().Equals("GATEWAYSVR"))
        {
            $global:tVal.Trim($global:tVal)
            $global:GATEWAYSVR = $global:tVal
            addListItems $global:token.ToUpper() $global:tVal
            $msg = "GATEWAYSVR Server: $global:tVal"
            Write-Host $msg
            Add-Content -Path $Logfile -Value "* $msg"
        }
        elseif ($global:token.ToUpper().Equals("TDRSVR"))
        {
            $global:tVal.Trim($global:tVal)
            $global:TDRSVR = $global:tVal
            addListItems $global:token.ToUpper() $global:tVal
            $msg = "TDRSVR Server: $global:tVal"
            Write-Host $msg
            Add-Content -Path $Logfile -Value "* $msg"
        }
        elseif ($global:token.ToUpper().Equals("SECURELOGINSVR"))
        {
            $global:tVal.Trim($global:tVal)
            $global:SECURELOGINSVR = $global:tVal
            addListItems $global:token.ToUpper() $global:tVal
            $msg = "SECURELOGINSVR Server: $global:tVal"
            Write-Host $msg
            Add-Content -Path $Logfile -Value "* $msg"
        }
        elseif ($global:token.ToUpper().Equals("LANGUAGESVR"))
        {
            $global:tVal.Trim($global:tVal)
            $global:LANGUAGESVR = $global:tVal
            addListItems $global:token.ToUpper() $global:tVal
            $msg = "LANGUAGESVR Server: $global:tVal"
            Write-Host $msg
            Add-Content -Path $Logfile -Value "* $msg"
        }        
        elseif ($global:token.ToUpper().Equals("SQLSVRDATADIR"))
        {
            $global:tVal.Trim($global:tVal)
            $global:SqlSvrDataDir = $global:tVal
            addListItems $global:token.ToUpper() $global:tVal
            $msg = "SqlSvrDataDir : $global:tVal"
            Write-Host $msg
            Add-Content -Path $Logfile -Value "* $msg"
        }
        elseif ($global:token.ToUpper().Equals("OCRSVR"))
        {
            $global:tVal.Trim($global:tVal)
            $global:OCRSVR = $global:tVal
            addListItems $global:token.ToUpper() $global:tVal
            $msg = "OCRSVR Server: $global:tVal"
            Write-Host $msg
            Add-Content -Path $Logfile -Value "* $msg"
        }
        elseif ($global:token.ToUpper().Equals("HIVESVR"))
        {
            $global:tVal.Trim($global:tVal)
            $global:HIVESVR = $global:tVal
            addListItems $global:token.ToUpper() $global:tVal
            $msg = "HIVESVR Server: $global:tVal"
            Write-Host $msg
            Add-Content -Path $Logfile -Value "* $msg"
        }
        elseif ($global:token.ToUpper().Equals("THESAURUSSVR"))
        {
            $global:tVal.Trim($global:tVal)
            $global:THESAURUSSVR = $global:tVal
            addListItems $global:token.ToUpper() $global:tVal
            $msg = "THESAURUSSVR Server: $global:tVal"
            Write-Host $msg
            Add-Content -Path $Logfile -Value "* $msg"
        }
        elseif ($global:token.ToUpper().Equals("SSVR"))
        {
            $global:tVal.Trim($global:tVal)
            $global:SSVR = $global:tVal
            addListItems $global:token.ToUpper() $global:tVal
            $msg = "Services Server: $global:tVal"
            Write-Host $msg
            Add-Content -Path $Logfile -Value "* $msg"
        }
        elseif ($global:token.ToUpper().Equals("RSVR"))
        {
            $global:tVal.Trim($global:tVal)
            $global:RSVR = $global:tVal
            addListItems $global:token.ToUpper() $global:tVal
            $msg = "Repository Server: $global:tVal"
            Write-Host $msg
            Add-Content -Path $Logfile -Value "* $msg"
        }
        elseif ($global:token.ToUpper().Equals("UNAME"))
        {
            $global:tVal.Trim($global:tVal)
            $global:UNAME = $global:tVal
            addListItems $global:token.ToUpper() $global:tVal
            $msg = "USER NAME: '$global:tVal'"
            Write-Host $msg
            Add-Content -Path $Logfile -Value "* $msg"
        }
        elseif ($global:token.ToUpper().Equals("PWD"))
        {
            $global:tVal.Trim($global:tVal)
            $global:PWD = $global:tVal
            $global:PW = $global:tVal
            $global:SVRPW = $global:tVal
            addListItems $global:token.ToUpper() $global:tVal
            $msg = "PWD: '$global:tVal'"
            Write-Host $msg
            Add-Content -Path $Logfile -Value "* $msg"
        }
        elseif ($global:token.ToUpper().Equals("PASSWORD"))
        {
            $global:tVal.Trim($global:tVal)
            $global:PASSWORD = $global:tVal
            addListItems $global:token.ToUpper() $global:tVal
            $msg = "PASSWORD: '$global:tVal'"
            Write-Host $msg
            Add-Content -Path $Logfile -Value "* $msg"
        }
        elseif ($global:token.ToUpper().Equals("FSFG"))
        {
            $global:tVal.Trim($global:tVal)
            $global:FSFG = $global:tVal
            addListItems $global:token.ToUpper() $global:tVal
            $msg = "SS Filegroup Name: '$global:tVal'"
            Write-Host $msg
            Add-Content -Path $Logfile -Value "* $msg"            
        }
        elseif ($global:token.ToUpper().Equals("FSDIR"))
        {
            $global:tVal.Trim($global:tVal)
            $global:FSDIR = $global:tVal
            addListItems $global:token.ToUpper() $global:tVal
            $msg = "FileStream DIR: '$global:tVal'"
            Write-Host $msg
            Add-Content -Path $Logfile -Value "* $msg"            
        }
        elseif ($global:token.Equals("TDIR"))
        {
            $global:tVal.Trim($global:tVal)
            $global:TDIR = $global:tVal
            addListItems $global:token.ToUpper() $global:tVal
            #$Logfile = $global:TDIR + "\_ECM.Install.LOG.txt"
            $StartDate = Get-Date
            $msg = "*** Run initiated by: $CurrUser"
            $msg | out-file $Logfile
            Add-Content -Path $Logfile -Value "* Execution Date: $StartDate"
            Add-Content -Path $Logfile -Value "*** LOGFILE SET TO: $Logfile"  

            $msg = "Temporary Working DIR: $TVAR"
            Write-Host $msg
            Add-Content -Path $Logfile -Value "* $msg"              
        }
        elseif ($global:token.ToUpper().Equals("REPODBNAME"))
        {
            $global:tVal.Trim($global:tVal)
            $global:REPODBNAME = $global:tVal
            addListItems $global:token.ToUpper() $global:tVal
            $msg = "$global:token : '$global:tVal'"
            Write-Host $msg
            Add-Content -Path $Logfile -Value "* $msg"            
        }
        elseif ($global:token.ToUpper().Equals("SSVRDBNAME"))
        {
            $global:tVal.Trim($global:tVal)
            $global:SSVRDBNAME = $global:tVal
            addListItems $global:token.ToUpper() $global:tVal
            $msg = "$global:token : '$global:tVal'"
            Write-Host $msg
            Add-Content -Path $Logfile -Value "* $msg"            
        }
        elseif ($global:token.ToUpper().Equals("THESAURUSDBNAME"))
        {
            $global:tVal.Trim($global:tVal)
            $global:THESAURUSDBNAME = $global:tVal
            addListItems $global:token.ToUpper() $global:tVal
            $msg = "$global:token : '$global:tVal'"
            Write-Host $msg
            Add-Content -Path $Logfile -Value "* $msg"            
        }
        elseif ($global:token.ToUpper().Equals("GATEWAYDBNAME"))
        {
            $global:tVal.Trim($global:tVal)
            $global:GATEWAYDBNAME = $global:tVal
            addListItems $global:token.ToUpper() $global:tVal
            $msg = "$global:token : '$global:tVal'"
            Write-Host $msg
            Add-Content -Path $Logfile -Value "* $msg"            
        }
        elseif ($global:token.ToUpper().Equals("SECURELOGINDBNAME"))
        {
            $global:tVal.Trim($global:tVal)
            $global:SECURELOGINDBNAME = $global:tVal
            addListItems $global:token.ToUpper() $global:tVal
            $msg = "$global:token : '$global:tVal'"
            Write-Host $msg
            Add-Content -Path $Logfile -Value "* $msg"            
        }
        elseif ($global:token.ToUpper().Equals("LANGUAGEDBNAME"))
        {
            $global:tVal.Trim($global:tVal)
            $global:LANGUAGEDBNAME = $global:tVal
            addListItems $global:token.ToUpper() $global:tVal
            $msg = "$global:token : '$global:tVal'"
            Write-Host $msg
            Add-Content -Path $Logfile -Value "* $msg"            
        }
        elseif ($global:token.ToUpper().Equals("HIVEDBNAME"))
        {
            $global:tVal.Trim($global:tVal)
            $global:HIVEDBNAME = $global:tVal
            addListItems $global:token.ToUpper() $global:tVal
            $msg = "$global:token : '$global:tVal'"
            Write-Host $msg
            Add-Content -Path $Logfile -Value "* $msg"            
        }
        elseif ($global:token.ToUpper().Equals("TDRDBNAME"))
        {
            $global:tVal.Trim($global:tVal)
            $global:TDRDBNAME = $global:tVal
            addListItems $global:token.ToUpper() $global:tVal
            $msg = "$global:token : '$global:tVal'"
            Write-Host $msg
            Add-Content -Path $Logfile -Value "* $msg"            
        }
        else 
        {            
            if ($global:token)
            {
                $msg = "$global:token NOT FOUND..."
                Write-Host $msg
                Add-Content -Path $Logfile -Value "* $msg"                           
                $tempvar = $global:slVars[$global:token]
                if ($tempvar)
                {
                    $msg = "$global:token already exists..."
                    Write-Host $msg
                }
                elseif (!$tempvar)
                {
                    Write-Host "NULL Var - skippping" 
                }
                else 
                {
                    $global:tVal.Trim($global:tVal)
                    addListItems $global:token.ToUpper() $global:tVal
                }                
            }
            $global:token = "" 
            $global:tVal = "" 
        }
    }

    #**********************************************************************************************
    #**** WE HAVE THE VARIABLES INITIALIZED THAT ARE REQUIRED TO INSTALL AND CONFIGURE ECM LIBRARY
    #**********************************************************************************************

} 

PrintSortedList $global:slVars $Logfile

return $global:slVars

}

#***************************************************************************************
