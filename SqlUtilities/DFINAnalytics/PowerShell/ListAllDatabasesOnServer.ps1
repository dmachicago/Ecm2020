clear 
[System.Reflection.Assembly]::LoadWithPartialName('Microsoft.SqlServer.SMO') | out-null
$s = New-Object ('Microsoft.SqlServer.Management.Smo.Server') "ARCDEVREPLN1.fincocloud.com,2720"
$dbs=$s.Databases
$cnt = 0 ;
foreach ($db in $dbs){
    $cnt += 1;
    $db.name;

}
$cnt
#$dbs
#$dbs | Get-Member -MemberType Property
