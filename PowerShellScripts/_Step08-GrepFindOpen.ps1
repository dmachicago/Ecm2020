#*************************************************************************************************************
#Last Modification Date: Aug, 12, 2017
#Developed by W. Dale Miller
#Search for "Enter Execution Variables Here" and fill in the execution variables and execute the program.
#Changes:
#2/1/2013 -  None to date
#*************************************************************************************************************

try{
    Set-ExecutionPolicy RemoteSigned
}
catch {
    echo ("Caught the exception")
    echo ($Error[0].Exception)
    echo "Continuing..."
}


function getCnt($fqn, $tgt)
{
    #$tgt = '-pSVR2016$1'
    #$fqn = 'D:\dev\EcmMasterSingleSource\ECM\_ECMInstall\_PowerShellInstallScripts_Parsenal\_CreateInstallationZipFiles.bat'
    $cnt = @(Get-Content $fqn | Where-Object { $_.Contains($tgt) }).Count
    return $cnt 
}

function processFile($filename, $TgtText, $ReplacementText, $ReplaceALL,$logFileName   )
{
   
    #Now, we need to get the file name from the full path name
    $file = split-path $filename -leaf -resolve
    $OFile = $global:TempDir + $file
    
    $i = 0 ; 
    $hits = 0 ; 
    $b = 0;
    $FOUND = 0 
    
    Write-Host "Processing $filename"

    foreach ($line in [System.IO.File]::ReadLines($filename))
    {
        $i = $i + 1 ;
        $b = 0 ;
        if($line.Contains($TgtText)){
            #Write-Host $line
            if ($FOUND -eq 0) {
                 Add-Content $logFileName  "`n$TgtText Found in $filename "
                 $FOUND = 1 
            }
            Add-Content $logFileName   "`n`t$line"
        }
      
        
    }
    $GoAheadAndReplace = $ReplaceALL ;
    if ($GoAheadAndReplace -eq 1 -and $FOUND -eq 1){
        $OldTest = $TgtText ;
        $NewTest = $ReplacementText;
        (get-content $filename) | foreach-object {$_ -replace $OldTest, $NewTest} | set-content $filename
    }
    
    if ($hits -gt 0) {
        Write-Host "Total Hits: $hits FOUND IN $filename" 
        Write-Host "Total Lines: $i "     
    }

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

function grepFile($drive, $tgtdir, $TgtFQN, $TgtText, $ReplacementText, $ReplaceALL, $logFileName  )
{
    $dir = $drive
    $path = $dir + $tgtdir

    
    If (Test-Path $logFileName){
	    Remove-Item $logFileName 
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

            if ($tempname.Contains($TgtFQN)){
                processFile $tempname $TgtText  $ReplacementText $ReplaceALL $logFileName  ;            
            }                   
            
     }

     If (Test-Path $logFileName){
	    start-process notepad  $logFileName 
    }

    #processFile "c:\PrepublishedWebSites\ECMSaaS\Archiver\Application Files\EcmArchiveClcSetup_3_2_1_3\EcmArchiveClcSetup.exe.config.deploy" ;
    #Copy this modified file to the original

}


Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
Set-ExecutionPolicy Unrestricted -Scope CurrentUser
Get-ExecutionPolicy -List

cls

#***************************************************************************************
$inc = 0 ; 
$drive = "C:\";
$dir = "ecmsite";
$TgtText = "108.61.17.163" ;
$ReplacementText = "SVR2016" ;
$TgtFQN = ".deploy" ;
$ReplaceALL = 1 ; 
$logFileName = "c:\temp\GrepFound_" + $inc + ".txt"
grepFile $drive  $dir $TgtFQN $TgtText $ReplacementText $ReplaceALL $logFileName ;
#***************************************************************************************
$inc =$inc + 1 ;
$drive = "C:\";
$dir = "ecmsite";
$TgtText = "108.61.17.163" ;
$ReplacementText = "SVR2016" ;
$TgtFQN = ".config" ;
$ReplaceALL = 1 ; 
$logFileName = "c:\temp\GrepFound_" + $inc + ".txt"
grepFile $drive  $dir $TgtFQN $TgtText $ReplacementText $ReplaceALL $logFileName ;
#***************************************************************************************
$inc =$inc + 1 ;
$drive = "C:\";
$dir = "ecmsite";
$TgtText = "9VSReT4CWp9dGK9J5kGi0Q==" ;  #pclJunebug1'
$ReplacementText = "9VSReT4CWp9V8qWCSH64vA==" ;  #pclJunebug1
$TgtFQN = ".config" ;
$ReplaceALL = 0 ; 
$logFileName = "c:\temp\GrepFound_" + $inc + ".txt"
grepFile $drive  $dir $TgtFQN $TgtText $ReplacementText $ReplaceALL $logFileName ;
$inc =$inc + 1 ;
$TgtFQN = ".deploy" ;
grepFile $drive  $dir $TgtFQN $TgtText $ReplacementText $ReplaceALL $logFileName ;
#***************************************************************************************
$inc =$inc + 1 ;
$drive = "C:\";
$dir = "ecmsite";
$TgtText = "9VSReT4CWp9dGK9J5kGi0Q==" ;  #pclJunebug1'
$ReplacementText = "9VSReT4CWp9V8qWCSH64vA==" ;  #pclJunebug1
$TgtFQN = ".deploy" ;
$ReplaceALL = 0 ; 
$logFileName = "c:\temp\GrepFound_" + $inc + ".txt"
grepFile $drive  $dir $TgtFQN $TgtText $ReplacementText $ReplaceALL $logFileName ;
#***************************************************************************************
$inc =$inc + 1 ;
$drive = "C:\";
$dir = "ecmsite";
$TgtText = '59757' ;
$ReplacementText = "SVR2016" ;
$TgtFQN = ".config" ;
$ReplaceALL = 0 ; 
$logFileName = "c:\temp\GrepFound_" + $inc + ".txt"
grepFile $drive  $dir $TgtFQN $TgtText $ReplacementText $ReplaceALL $logFileName ;
#***************************************************************************************
$inc =$inc + 1 ;
$drive = "C:\";
$dir = "ecmsite";
$TgtText = '11.8.18.1' ;
$ReplacementText = "3.8.18.5" ;
$TgtFQN = ".config" ;
$ReplaceALL = 1 ; 
$logFileName = "c:\temp\GrepFound_" + $inc + ".txt"
grepFile $drive  $dir $TgtFQN $TgtText $ReplacementText $ReplaceALL $logFileName ;
#***************************************************************************************
$inc =$inc + 1 ;
$drive = "C:\";
$dir = "ecmsite";
$TgtText = 'http://localhost:59757' ;
$ReplacementText = "http://SVR2016" ;
$TgtFQN = ".config" ;
$ReplaceALL = 1 ; 
$logFileName = "c:\temp\GrepFound_" + $inc + ".txt"
grepFile $drive  $dir $TgtFQN $TgtText $ReplacementText $ReplaceALL $logFileName ;
#***************************************************************************************
$inc =$inc + 1 ;
$drive = "C:\";
$dir = "ecmsite";
$TgtText = 'http://localhost:59757' ;
$ReplacementText = "http://SVR2016" ;
$TgtFQN = ".deploy" ;
$ReplaceALL = 1 ; 
$logFileName = "c:\temp\GrepFound_" + $inc + ".txt"
grepFile $drive  $dir $TgtFQN $TgtText $ReplacementText $ReplaceALL $logFileName ;
#***************************************************************************************
$inc =$inc + 1 ;
$drive = "C:\";
$dir = "ecmsite";
$TgtText = '59757' ;
$ReplacementText = "SVR2016" ;
$TgtFQN = ".config" ;
$ReplaceALL = 1 ; 
$logFileName = "c:\temp\GrepFound_" + $inc + ".txt"
grepFile $drive  $dir $TgtFQN $TgtText $ReplacementText $ReplaceALL $logFileName ;
$TgtFQN = ".deploy" ;
$inc =$inc + 1 ;
grepFile $drive  $dir $TgtFQN $TgtText $ReplacementText $ReplaceALL $logFileName ;
#***************************************************************************************
