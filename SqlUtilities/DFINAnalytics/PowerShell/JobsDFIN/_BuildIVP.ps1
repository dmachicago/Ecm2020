#JOB_UTIL_DFS_DbSize
#exec UTIL_DFS_DbFileSizing;

Install-Module -Name Az -AllowClobber

$ScriptPath = Split-Path $MyInvocation.InvocationName 
#$ScriptPath = $MyInvocation.InvocationName 
$ScriptPath += "\modules\JOB_StdFunctions.ps1"
Import-Module "$ScriptPath" ;
#Import-Module "D:\dev\SQL\DFINAnalytics\PowerShell\JobsDFIN\modules\JOB_StdFunctions.ps1" ;

clear

$env:AzureRmContextAutoSave="true" 
$JobName = $MyInvocation.MyCommand.Definition
showRunning($JobName)

$EditIvp = 1 ;
$IVPFile = "D:\dev\SQL\DFINAnalytics\Batch_Files\ToolBelt_IVP.sql" ;

foreach ($RegisteredServer in Get-Content D:\dev\SQL\DFINAnalytics\ControlFiles\ToolBeltFiles.txt)
{
   
    $cmd, $file = $RegisteredServer.split('-');
    if ($cmd)
    {
        $cmd = $cmd.trim();
        $file = $file.trim();
        try{
            if ($cmd -eq 'load'){
                Write-Output "LOADING: $cmd, $file ";
                $content = [IO.File]::ReadAllText($file);
                Add-Content $IVPFile "-- ***********************************************";
                Add-Content $IVPFile "-- FQN: $file" ;
                Add-Content $IVPFile "-- ***********************************************";
                Add-Content $IVPFile "PRINT 'LOADING: $file'";
                Add-Content $IVPFile "GO";
                Add-Content $IVPFile $content ;
                Add-Content $IVPFile "-- *** EOF ***************************************";
                Add-Content $IVPFile "GO";
            }
            if ($cmd -eq 'echo'){
                Write-Output "ECHOING: $cmd, $file ";
                Add-Content $IVPFile "-- ******************* ECHO **********************";
                Add-Content $IVPFile $file ;
            }
            if ($cmd -eq 'del'){
                Write-Output "DELETING: $cmd, $file ";
                rm $IVPFile -ErrorAction Ignore
            }
        }
        catch {
                $ErrorMessage = $_.Exception.Message;
                $FailedItem = $_;
            
                $ErrPath = Split-Path $MyInvocation.InvocationName 
                $ErrPath += "\ERRORS\"
                #recordError $Instance $db $JobName $ErrorMessage $ErrPath;
                #recordError $Instance $db $JobName $FailedItem $ErrPath;

                Write-Output "ErrorMessage: $ErrorMessage";
                Write-Output "FailedItem: $FailedItem";
                #Echo the current object
                $_
        }
    }
}
if ($EditIvp -eq 1){
    Start-Process notepad $IVPFile
}
Write-Output "*************";
Write-Output "--->DONE <---";
Write-Output "*************";