#Start PowerShell and execute the following commands to create a credential file for Azure auto-login later.
######################################################################
# interactive login to Azure Resource Manager with your Azure Account
Login-AzureRmAccount 
# print the list of subscriptions you have access to
Get-AzureRmSubscription
# save your credential to a JSON file for auto-login later on
Save-AzureRmContext  -Path "C:\azure-credential.json"
######################################################################


#Modify the following PowerShell script to fit your need, and save 
#it to a .ps file. 
#Next time you just need to execute the PS file in PowerShell
######################################################################
# auto-login with the saved credential file
Import-AzureRmContext  -Path "C:\azure-credential.json"
# select the "Sunrise Strong" subscription
Select-AzureRmSubscription -SubscriptionName "Sunrise Strong"
# select the sunrisestrong_dw data warehouse
$database = Get-AzureRmSqlDatabase –ResourceGroupName "sunrisestrong" –ServerName "sunrisestrong" –DatabaseName "sunrisestrong_dw"
# resume data warehouse. the command won't fail if database warehouse is already online
$resultDatabase = $database | Resume-AzureRmSqlDatabase
# scale to DW600
$database | Set-AzureRmSqlDatabase -RequestedServiceObjectiveName "DW600"
# exeucte stored procedure dbo.your_procedure without parameters
$SqlConnection = New-Object System.Data.SqlClient.SqlConnection
$SqlConnection.ConnectionString = "Server=sunrisestrong.database.windows.net;Database=sunrisestrong_dw;UID=your_user_name;Password=your_password"
$SqlCmd = New-Object System.Data.SqlClient.SqlCommand
$SqlCmd.CommandText = "dbo.your_procedure"
$SqlCmd.Connection = $SqlConnection
# depending on whether the SQL command returns data, --* USEone of the two code blocks, not both
# if (the stored procedure returns data) {
$SqlAdapter = New-Object System.Data.SqlClient.SqlDataAdapter
$SqlAdapter.SelectCommand = $SqlCmd
$DataSet = New-Object System.Data.DataSet
$SqlAdapter.Fill($DataSet)
# } else {
$SqlConnection.Open()
$SqlCmd.ExecuteNonQuery()
# } 
$SqlConnection.Close()
$DataSet.Tables[0]
######################################################################