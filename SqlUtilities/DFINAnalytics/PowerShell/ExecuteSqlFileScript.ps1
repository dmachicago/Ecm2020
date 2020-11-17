
$YourServerName = 'ALIEN15';
$YourDatabaseName = 'AW2016';
$YourUserName = 'sa';
$YourDbPassword = 'Junebug1';


$SQLConnection = New-Object System.Data.SqlClient.SqlConnection 
$SQLConnection.ConnectionString = "Server=" + $YourServerName + ";Database="  + $YourDatabaseName + ";User ID= "  + $YourUserName + ";Password="  + $YourDbPassword + ";" 


$DirectoryPath = "C:\temp"
$Dep_SqlFiles = get-childitem -Recurse   $DirectoryPath -Include "*.sql"

$Dep_Info_DataEntry = @(Get-Content $Dep_SqlFiles.FullName) #Get all info of each file and put it in array



foreach($SQLString in  $Dep_Info_DataEntry)
{
   if($SQLString -ne "go") 
      { 
      #Preparation of SQL packet 
      $SQLToDeploy += $SQLString + "`n" 
      }
  Else
      {
        try{
            $SQLCommand = New-Object System.Data.SqlClient.SqlCommand($SQLToDeploy, $SQLConnection) 
            $SQLCommand.ExecuteNonQuery()
            #use this if you want to log the output
            #$SQLCommand.ExecuteScalar() | Out-File YourLogFile  -Append 

        }
        Catch
        {

        }
    
$SQLToDeploy = ""
      }

}