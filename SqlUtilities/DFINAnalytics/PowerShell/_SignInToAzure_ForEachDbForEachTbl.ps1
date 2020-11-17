function _genConnStr ([string]$svr, [string] $db, [string]$uid, [string]$pw) {
    [string]$cs1 = '';
    $cs1 = 'NA';
    if (! $uid) {
        Write-Host ("Trusted CONNECTION")
        if (IsNullOrEmpty($db)) {
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

Install-Module -Name Az -AllowClobber
clear
#Connect-AzAccount
#add-AzureAccount

$User = "wdalemiller@gmail.com"
$PWord = ConvertTo-SecureString -String "Junebug1" -AsPlainText -Force
$Credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $User, $PWord
#$Credential = Get-Credential
Connect-AzAccount -Credential $Credential


$env:AzureRmContextAutoSave="true" 

foreach ($RegisteredServer in Get-Content D:\temp\AllInstances.txt)
{
    
    $results = '';
    $Instance, $db, $user, $pwd = $RegisteredServer.split('|');
    $Instance = $Instance.trim();
    $db = $db.trim();

    if ($user) {
        $user = $user.trim();
    }

    if ($pwd) {
        $pwd = $pwd.trim();
    }
    #$cs= _genConnStr $Instance $db $user $pwd ;

    $qry = "select  S.name as [SchemaName], T.name as TblName from sys.tables T join sys.schemas S on T.schema_id = S.schema_id";
    
    
    try{
        if ($user){ 
            $tables = Invoke-Sqlcmd -ServerInstance $Instance -Database $db -Username $user -Password $pwd -Query $qry ;
        }
        else {
            $tables = Invoke-Sqlcmd -ServerInstance $Instance -Database $db -Query $qry ;
        }

        #write-host ($tables | Format-Table | Out-String) 

        foreach ($row in $tables )
        {
            $sname = $row.SchemaName;
            $tname = $row.Tblname;
            #write-host "$Instance $DB sname.$tname";
            $qry = "Select count(*) as CNT from $sname.$tname ";
            if ($user){ 
                $RowCount = Invoke-Sqlcmd -ServerInstance $Instance -Database $db -Username $user -Password $pwd -Query $qry ;
                }
            else {
                $RowCount = Invoke-Sqlcmd -ServerInstance $Instance -Database $db -Query $qry ;
            }
            $cnt = $RowCount.CNT;
            write-host "$Instance $DB $sname.$tname :: RowCount = $cnt";
        } 
        #$results | Get-Member;
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