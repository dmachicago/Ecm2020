#*************************************************************************************************************
#Last Modification Date: Aug, 12, 2015
#Developed by W. Dale Miller
#Search for "Enter Execution Variables Here" and fill in the execution variables and execute the program.
#Changes:
#2/1/2013 -  None to date
#*************************************************************************************************************

#Set-ExecutionPolicy unrestricted –Force

function processFile($filename, $SearchText)
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
        if($line.Contains($SearchText)){
            Write-Host $line
            if ($FOUND -eq 0) {
                 Add-Content c:\temp\GrepFound.txt "`n "
                 Add-Content c:\temp\GrepFound.txt "`n$filename"
                 $FOUND = 1 
            }
            Add-Content c:\temp\GrepFound.txt "`n`t$line"
        }      
        
    }

    Write-Host "Total Lines: $i" 
    Write-Host "Total Hits: $hits" 
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

#***************************************************************************************
#***************************************************************************************

$dir = "c:\" 
$path = $dir + "EcmSite"

$SearchText = "108.60.211.157" ;
$TgtFQN = ".deploy"

$logFileName = "c:\temp\GrepFound.txt"
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
            processFile $tempname $SearchText ;            
        }                   
            
 }

 If (Test-Path $logFileName){
	start-process notepad  $logFileName 
}
else {
        Write-Host "Text NOT found." 
}

#processFile "c:\PrepublishedWebSites\ECMSaaS\Archiver\Application Files\EcmArchiveClcSetup_3_2_1_3\EcmArchiveClcSetup.exe.config.deploy" ;
#Copy this modified file to the original


