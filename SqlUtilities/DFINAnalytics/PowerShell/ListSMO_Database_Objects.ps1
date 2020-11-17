#Connect and run a command using SMO 
[reflection.assembly]::LoadWithPartialName("Microsoft.SqlServer.Smo")

<#
Now you need to connect to your server (replace all the proper bits 
with your server names and so on here) - note that I'm using integrated 
authentication (this should all be on one line):
#>

$sqlServer = new-object ("Microsoft.SqlServer.Management.Smo.Server") "ALIEN15"

<#
Now you have a $sqlServer object you can play with. Here's a way to 
loop through all those and show the names (this should all be on one line):
#>

foreach($sqlDatabase in $sqlServer.databases) {$sqlDatabase.name}

<#
Do you see the .name part? You can show way more than that. To find out 
what you could put there instead:
#>

$sqlServer | get-member | more

foreach($sqlDatabase in $sqlServer.databases) {
    "DN: $sqlDatabase.name";
    foreach($table in $sqlDatabase.Tables) {
        $table.schema + '.' + $table.name;
        foreach($col in $table.Columns) {
            "COL: $col.name";
        }
    }
}
'*****************************'
$sqlServer.State.ToString();
$sqlServer.SystemDataTypes.Count;
foreach($type in $sqlServer.SystemDataTypes) {
    $type.Name
}

$sqlServer.Logins.Count;
foreach($Login in $sqlServer.Logins) {
    $Login.name
}


<#
Take a look at all of the items marked with "Property". Replace that .name part 
with one of those and you'll see all of the databases properties for that object.
#>