Install-Module -Name Az -AllowClobber
Import-Module D:\dev\SQL\DFINAnalytics\PowerShell\JobsDFIN\modules\JOB_StdFunctions.ps1 ;
<#
#JOB_ UTIL_DefragAllIndexes
#exec DFINAnalytics.dbo.UTIL_DefragAllIndexes null, null, 30, 0, 1, -1;
#Weekly Saturday Minight Eastern Time
# @StartingDB   NVARCHAR(100), 
# @EndingDB     NVARCHAR(100), 
# @MaxPct       DECIMAL(6, 2)  = 30, 
# @PreviewOnly  INT           = 1, 
# @ReorgIndexes INT           = 0, 
# @RunID        VARCHAR(60)   = NULL
#
#IF @EndingDB IS NULL and @StartingDB is null ALL databases are processed
#IF @EndingDB IS NULL and @StartingDB is NOT null only database @StartingDB is processed
#
#>

<#
Server=tcp:dfin.database.windows.net,1433;Initial Catalog=AZ2016;Persist Security Info=False;User ID={your_username};Password={your_password};MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;
#>
function _genConnStr ($isAzure, [string]$svr, [string] $db, [string]$uid, [string]$pw) {
    [string]$cs1 = '';
    $cs1 = 'NA';

    if ($isAzure = 'Y'){
        $cs1 = "Server=$svr;Initial Catalog=$db;Persist Security Info=False;User ID=$uid;Password=$pw;MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;"
        return $cs1 ;
    }

    if (! $uid) {
        Write-Host ("Trusted CONNECTION")
        if (!$db) {
            $cs1 = "Server = $svr; Integrated Security = True;"
        }
        else {
        $cs1 = "Server = $svr; database=$db; Integrated Security = True;"
        }
        
    }
    else {
        Write-Host ("SQL Authentication CONNECTION")
        if (! $uid) {
            $cs1 = "Server = $svr; User ID = $uid; Password = $pw;"
        }
        else {
            $cs1 = "Server = $svr;database=$db; User ID = $uid; Password = $pw;"
        }
        
    }
    return $cs1 ;
}

clear

$RunID = getRunID ;
$UserID = "wdalemiller@gmail.com"
$PWord = ConvertTo-SecureString -String "Junebug1" -AsPlainText -Force
$Credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $UserID, $PWord
#$Credential = Get-Credential
Connect-AzAccount -Credential $Credential


$env:AzureRmContextAutoSave="true" 
foreach ($RegisteredServer in Get-Content D:\dev\SQL\DFINAnalytics\ControlFiles\AllInstances.txt)
{

    $StartingDB = $null;
    $EndingDB = $null;
    $MaxPct = 32;
    $PreviewOnly  = 1;
    $ReorgIndexes = 0;
    $RunID  = [math]::floor($timediff.TotalMinutes);
    $RunID 
    
    $isAzure = '';
    $results = '';
    $isAzure, $svr, $db, $UserID, $pwd = $RegisteredServer.split('|');
    $svr = $svr.trim();
    $db = $db.trim();

    if ($UserID) {
        $UserID = $UserID.trim();
    }

    if ($pwd) {
        $pwd = $pwd.trim();
    }
        
    try{
        cls
        $RunID = getRunID;

        $connString = _genConnStr $isAzure $svr $db $UserID $pwd ;
        $connString    

        $connection = new-object System.Data.SqlClient.SqlConnection $connString
        $connection.Open()

        $SQLCmdString = "UTIL_DefragAllIndexes"
        
        # Add parameters to pass values to the stored procedure
        
        $SqlCommand.Parameters.AddWithValue("@StartingDB", $StartingDB) | Out-Null
        $SqlCommand.Parameters.AddWithValue("@EndingDB", $EndingDB) | Out-Null
        $SqlCommand.Parameters.AddWithValue("@MaxPct", $MaxPct) | Out-Null
        $SqlCommand.Parameters.AddWithValue("@PreviewOnly", $PreviewOnly) | Out-Null
        $SqlCommand.Parameters.AddWithValue("@ReorgIndexes", $ReorgIndexes) | Out-Null
        $SqlCommand.Parameters.AddWithValue("@RunID", $RunID) | Out-Null
        
        $connection = new-object System.Data.SqlClient.SqlConnection $connString
        $connection.Open()
 
        $results = $Command.ExecuteNonQuery() | Out-Null
        $results

        $connection.Close() | Out-Null
        $Command.Dispose() | Out-Null
        $connection.Dispose() | Out-Null

        Write-Output "SUCCESSFULLY PROCESSED: $svr @ $db";


    }
    catch {
           $ErrorMessage = $_.Exception.Message;
            $FailedItem = $_;
            $ErrPath = Split-Path $MyInvocation.InvocationName 
            $ErrPath += "\ERRORS\"
            recordError $Instance $db $JobName $ErrorMessage $ErrPath;
            recordError $Instance $db $JobName $FailedItem $ErrPath;

            Write-Output "ErrorMessage: $ErrorMessage";
            Write-Output "FailedItem: $FailedItem";
            #Echo the current object
            Write-Output "FAILED: $svr @ $db";
            $_
    }
}
Write-Output "--->DONE <---";