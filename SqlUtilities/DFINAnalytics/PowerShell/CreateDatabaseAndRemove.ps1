# Setting up the subscription info and the certificate 
# to be used when connecting to the subscription 
#  
# This needs to be done once per subscription on each  
# new client machine 
# Enter values for thumbprint and subscription ID 
$thumbprint = "" 
$myCert = Get-Item cert:\\CurrentUser\My\$thumbprint 
$subID = "" 
Set-AzureSubscription -SubscriptionName "msdn" -SubscriptionId $subID -Certificate $myCert 
 
 
 
# Select the active subscription to be used  
# for the rest of the script 
# 
Select-AzureSubscription -SubscriptionName "msdn" 
Get-AzureSubscription 
 
# See all servers in the subscription 
Get-AzureSqlDatabaseServer 
 
# Create a new server in West US region, and check the servers again 
$serverLogin = "mylogin" 
$serverPassword = "Sql@zure" 
$server = New-AzureSqlDatabaseServer -AdministratorLogin $serverLogin -AdministratorLoginPassword $serverPassword -Location "West US" 
Get-AzureSqlDatabaseServer 
 
# Get all firewall rules in all servers in subscription 
Get-AzureSqlDatabaseServer | Get-AzureSqlDatabaseServerFirewallRule 
 
# Add a new firewall rule : This gets all the fireWall rules in the server named c55mtaxs9l and adds them to the new database server 
$fwRules = Get-AzureSqlDatabaseServer -ServerName c55mtaxs9l | Get-AzureSqlDatabaseServerFirewallRule 
foreach ($fwRule in $fwRules) 
    { $server | New-AzureSqlDatabaseServerFirewallRule -RuleName $fwRule.RuleName -StartIpAddress $fwRule.StartIpAddress -EndIpAddress $fwRule.EndIpAddress } 
 
# Check the firewall rules again 
Get-AzureSqlDatabaseServer | Get-AzureSqlDatabaseServerFirewallRule 
 
# Remove all 'CorpNet' rule from all servers in subscription 
Get-AzureSqlDatabaseServer | Get-AzureSqlDatabaseServerFirewallRule -RuleName CorpNet | Remove-AzureSqlDatabaseServerFirewallRule -WhatIf 
Get-AzureSqlDatabaseServer | Get-AzureSqlDatabaseServerFirewallRule 
 
 
# Connect to the server using Sql Authentication 
# 
$servercredential = new-object System.Management.Automation.PSCredential("mylogin", ("Sql@zure"  | ConvertTo-SecureString -asPlainText -Force)) 
$ctx = $server | New-AzureSqlDatabaseServerContext -Credential $serverCredential 
 
# List databases 
# 
Get-AzureSqlDatabase $ctx 
 
# Create a new database 
# 
$db = New-AzureSqlDatabase $ctx -DatabaseName Demo 
Get-AzureSqlDatabase $ctx 
 
# Change database maximum size 
Set-AzureSqlDatabase $ctx $db -MaxSizeGB 10 
Get-AzureSqlDatabase $ctx 
 
# Remove the database 
 
$db | Remove-AzureSqlDatabaseServer 
 
# Remove the server 
# 
$server | Remove-AzureSqlDatabaseServer