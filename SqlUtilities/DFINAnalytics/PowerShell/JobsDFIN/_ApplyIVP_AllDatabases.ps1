

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

#$IVPFile = "D:\dev\SQL\DFINAnalytics\Batch_Files\ToolBelt_IVP.sql" ;
$IVPFile = 'D:\dev\SQL\DFINAnalytics\BATCH_FILES\IVP_DFINAnalytics.sql';

$env:AzureRmContextAutoSave="true" 
$JobName = $MyInvocation.MyCommand.Definition

function testConnection ($svr, $db, $uid, $pwd){

    $success = 0 ;
    $SqlConnection = New-Object System.Data.SqlClient.SqlConnection
    IF ($UID){
        $SqlConnection.ConnectionString = "Server = $svr; Database = $db; User ID = $uid; Password = $pwd;"
    }
    else {
        $SqlConnection.ConnectionString = "Server = $svr; Database = $db; Integrated Security = True;"
    }

    try{

        $SqlQuery = "SELECT count(*) from sys.tables;"
        $SqlCmd = New-Object System.Data.SqlClient.SqlCommand
        $SqlCmd.CommandText = $SqlQuery
        $SqlCmd.Connection = $SqlConnection
        $SqlCmd.CommandTimeout = 0;
        #$SqlAdapter = New-Object System.Data.SqlClient.SqlDataAdapter
        #$SqlAdapter.SelectCommand = $SqlCmd
        #$DataSet = New-Object System.Data.DataSet
        #$SqlAdapter.Fill($DataSet)

        $SqlAdapter = New-Object System.Data.SqlClient.SqlDataAdapter
        $SqlAdapter.SelectCommand = $SqlCmd 
        $DataSet = New-Object System.Data.DataSet
        $SqlAdapter.Fill($DataSet) 
        $SqlConnection.Close() 

        $success = 1 ;
    }
    catch{
        $success = 0 ;
    }
    return $success ;
}

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
    
    $rc = testConnection $svr $db $user $pwd
    if ($rc -eq 1){
        Write-Output "APPLYING IVP TO: {$svr}, {$db}, {$user}, {$pwd}";
    }
    else {
        Write-Output "ERROR OPENING: {$svr}, {$db}, {$user}, {$pwd}";
        Write-Output "SKIPPING THIS DATABASE on THIS SERVER...  returning";        
    }
    if ($rc -eq 1)
    {
        try{
            if ($user){
               #$rc = Invoke-Sqlcmd -ServerInstance $svr -Database $db -Username $user -Password $pwd -Query $qry ;
               $rc = Invoke-Sqlcmd -ServerInstance $svr -Database $db -Username $user -Password $pwd -InputFile $IVPFile  -QueryTimeout 1200 | Out-File -FilePath "C:\TEMP\_output.XXX"
            }
            else {
                #$rc = Invoke-Sqlcmd -ServerInstance $svr -Database $db -Query $qry ;
                $rc = Invoke-Sqlcmd -ServerInstance $svr -Database $db -InputFile $IVPFile -QueryTimeout 1200 | Out-File -FilePath "C:\TEMP\_output.XXX"
            }
            Write-Output "COMPLETED IVP ON : $svr, $db";
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
}
Write-Output "**************************";
Write-Output "--->       DONE       <---";
Write-Output "**************************";