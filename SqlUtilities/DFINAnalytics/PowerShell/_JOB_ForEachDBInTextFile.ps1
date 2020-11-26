﻿
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
function getRunID (){
        $rc = 0;
        $EndDate=(GET-DATE)
        $StartDate=[datetime]”01/01/2017 00:00”

        $timediff = NEW-TIMESPAN –Start $StartDate –End $EndDate;
        $timediff.TotalSeconds;
        #$rc = [math]::floor($timediff.TotalSeconds);
        $rc = [Math]::Truncate($timediff.TotalSeconds)
        return $rc;
}

clear;   
$env:AzureRmContextAutoSave="true" 

foreach ($RegisteredServer in Get-Content D:\temp\AllInstances.txt)
{
    
    $results = '';
    $isAzure, $Instance, $db, $user, $pwd = $RegisteredServer.split('|');
    $Instance = $Instance.trim();
    $db = $db.trim();
    $RunID = 0 ;

    $rc = 0;
    $EndDate=(GET-DATE)
    $StartDate=[datetime]”01/01/2017 00:00”

    $timediff = NEW-TIMESPAN –Start $StartDate –End $EndDate;
    $timediff.TotalSeconds;
    #$rc = [math]::floor($timediff.TotalSeconds);
    $RunID = [Math]::Truncate($timediff.TotalSeconds)
    if ($user) {
        $user = $user.trim();
    }

    if ($pwd) {
        $pwd = $pwd.trim();
    }
    
    Write-Output "PROCESSING: $Instance, $db";

    try{
        $qry = "" ;
        $qry = "exec sp_UTIL_TxMonitorIDX " +  $RunID ;
        if ($user){
            $rc = Invoke-Sqlcmd -ServerInstance $Instance -Database $db -Username $user -Password $pwd -Query $qry ;
        }
        else {
            $rc = Invoke-Sqlcmd -ServerInstance $Instance -Database $db -Query $qry ;
        }

        $qry = "exec sp_UTIL_TxMonitorTableStats $RunID;";
        if ($user){
            $rc = Invoke-Sqlcmd -ServerInstance $Instance -Database $db -Username $user -Password $pwd -Query $qry ;
        }
        else {
            $rc = Invoke-Sqlcmd -ServerInstance $Instance -Database $db -Query $qry ;
        }
        Write-Output "PROCESSED : $Instance, $db";
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