

#Import-Module SqlServer;
#Install-Module -Name Az -AllowClobber
#Import-Module D:\dev\SQL\DFINAnalytics\PowerShell\JobsDFIN\modules\JOB_StdFunctions.ps1 ;

clear
#Connect-AzAccount
#add-AzureAccount

<#
$User = "wdalemiller@gmail.com"
$PWord = ConvertTo-SecureString -String "Junebug1" -AsPlainText -Force
$Credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $User, $PWord
Connect-AzAccount -Credential $Credential
#>

$env:AzureRmContextAutoSave="true" 
$JobName = $MyInvocation.MyCommand.Definition


foreach ($RegisteredServer in Get-Content D:\dev\SQL\DFINAnalytics\ControlFiles\AllInstances.txt)
{
    
    $results = '';
    $isAzure, $svr, $db, $user, $pwd = $RegisteredServer.split('|');
    $svr = $svr.trim();
    $db = $db.trim();
    $rc = 0;

    if ($user) {
        $user = $user.trim();
    }

    if ($pwd) {
        $pwd = $pwd.trim();
    }
    
    Write-Output "APPLYING IVP TO: $svr, $db";

    try{
        $qry = "" ;
        #exec UTIL_UpdateQryPlansAndText 'DFS_IO_BoundQry2000' ;
        
        $qry = "exec UTIL_UpdateQryPlansAndText 'DFS_CPU_BoundQry2000' ;
                exec UTIL_UpdateQryPlansAndText 'DFS_IO_BoundQry2000' ;
                exec UTIL_UpdateQryPlansAndText 'DFS_IO_BoundQry' ;
                exec UTIL_UpdateQryPlansAndText 'DFS_CPU_BoundQry' ;"

        Write-Output "--------------------------------------------------------------------------";
        Write-Output "EXECUTING CMD : $qry";
        Write-Output "AGAINST       : $svr :: $db";
        Write-Output "--------------------------------------------------------------------------";
        if ($user){
            $rc = Invoke-Sqlcmd -ServerInstance $svr -Database $db -Username $user -Password $pwd -Query $qry -QueryTimeout 0 ;
        }
        else {
            $rc = Invoke-Sqlcmd -ServerInstance $svr -Database $db -Query $qry -QueryTimeout 0 ;
        }

        Write-Output "PROCESSED : $svr, $db";
    }
    catch {
            $ErrorMessage = $_.Exception.Message;
            $FailedItem = $_;
            Write-Output "ErrorMessage: $ErrorMessage";
            Write-Output "FailedItem: $FailedItem";
            #Echo the current object
            $_
    }
}
Write-Output "*************";
Write-Output "--->DONE <---";
Write-Output "*************";