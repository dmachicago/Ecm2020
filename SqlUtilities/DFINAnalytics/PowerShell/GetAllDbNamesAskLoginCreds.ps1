
[System.Reflection.Assembly]::LoadWithPartialName('Microsoft.SqlServer.SMO') | out-null 
$srv = new-object ('Microsoft.SqlServer.Management.Smo.Server') "LOCALHOST"  

#This sets the connection to mixed-mode authentication 
$srv.ConnectionContext.LoginSecure=$false; 
#Prompt for user credentials 
$credential = Get-Credential  

#Deal with the extra backslash character 
$loginName = $credential.UserName -replace("\\","")  

#This sets the login name  
$srv.ConnectionContext.set_Login($loginName);  

#This sets the password  
$srv.ConnectionContext.set_SecurePassword($credential.Password)  

$srv.ConnectionContext.ApplicationName="MySQLAuthenticationPowerShell"   


$srv.Databases | Select name 



#Taking it deeper, we can look at the tables of a particular  database.

#$sqlServer = New-Object Microsoft.SqlServer.Management.Smo.Server -ArgumentList 'vsql'
#$db = $sqlServer.Databases['ServerInventory']
#$db.tables  | Format-Table  Name,  Owner,  CreateDate,  DateLastModified,  RowCount,  DataSpaceUsed
#$db.EnumDatabasePermissions()  | Format-Table  Grantee,GranteeType,PermissionType,PermissionState,Grantor -AutoSize