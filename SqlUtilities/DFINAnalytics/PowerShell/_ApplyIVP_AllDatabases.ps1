

Import-Module SqlServer;
Install-Module -Nam\e Az -AllowClobber

clear
#Connect-AzAccount
#add-AzureAccount

<#
$User = "wdalemiller@gmail.com"
$PWord = ConvertTo-SecureString -String "Junebug1" -AsPlainText -Force
$Credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $User, $PWord
Connect-AzAccount -Credential $Credential
#>

clear;   
$env:AzureRmContextAutoSave="true" 

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
    
    Write-Output "CALLING IVP ON : $svr, $db";

    try{
        if ($user){
           #$rc = Invoke-Sqlcmd -ServerInstance $svr -Database $db -Username $user -Password $pwd -Query $qry ;
           $rc = Invoke-Sqlcmd -ServerInstance $svr -Database $db -Username $user -Password $pwd -InputFile 'D:\dev\SQL\DFINAnalytics\BATCH_FILES\IVP_DFINAnalytics.sql' | Out-File -FilePath "C:\TEMP\_output.XXX"
        }
        else {
            #$rc = Invoke-Sqlcmd -ServerInstance $svr -Database $db -Query $qry ;
            $rc = Invoke-Sqlcmd -ServerInstance $svr -Database $db -InputFile 'D:\dev\SQL\DFINAnalytics\BATCH_FILES\IVP_DFINAnalytics.sql' | Out-File -FilePath "C:\TEMP\_output.XXX"
        }
        Write-Output "PROCESSED IVP ON : $svr, $db";
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