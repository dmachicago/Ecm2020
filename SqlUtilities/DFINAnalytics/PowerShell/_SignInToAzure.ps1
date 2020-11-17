Install-Module -Name Az -AllowClobber

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

    $Instance, $db, $user, $pwd = $RegisteredServer.split('|');
    $Instance = $Instance.trim();
    $db = $db.trim();

    $qry = "SELECT @@ServerName as SVR, db_name() as DB, name from sys.tables";

    if ($user ){
        $user = $user.trim();
    }
    if ($pwd){
        $pwd = $pwd.trim();
    }

    "-$Instance / $db / $user / $pwd-" ;
    try{
        if ($user){        
            Invoke-Sqlcmd -ServerInstance $Instance -Database $db -Username $user -Password $pwd -Query $qry ;
        }
        else {
            Invoke-Sqlcmd -ServerInstance $Instance -Database $db -Query $qry ;
        }
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