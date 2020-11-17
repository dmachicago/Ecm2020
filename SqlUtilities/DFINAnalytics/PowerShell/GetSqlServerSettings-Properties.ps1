#Connect and run a command using SMO 
[reflection.assembly]::LoadWithPartialName("Microsoft.SqlServer.Smo")


#Now you need to connect to your server (replace all the proper bits with your server names and so on here) - note that I'm using integrated authentication (this should all be on one line):
$sqlServer = new-object ("Microsoft.SqlServer.Management.Smo.Server") "Alien15"


#Now you have a $sqlServer object you can play with. Here's a way to loop through all those and show the names (this should all be on one line):
foreach($sqlDatabase in $sqlServer.databases) {$sqlDatabase.name}

#Do you see the .name part? You can show way more than that. To find out what you could put there instead, try this:


$sqlServer | get-member | more