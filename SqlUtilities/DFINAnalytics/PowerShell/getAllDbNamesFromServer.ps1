﻿

$SqlConnection = New-Object System.Data.SqlClient.SqlConnection
$SqlConnection.ConnectionString = “Server=Alien15;Integrated Security=true;Initial Catalog=master”
$SqlConnection.Open()
$SqlCmd = New-Object System.Data.SqlClient.SqlCommand


#$SqlCmd.CommandText = "sp_helpdb"
$SqlCmd.CommandText = "select name from sys.databases"
$SqlCmd.Connection = $SqlConnection
$SqlAdapter = New-Object System.Data.SqlClient.SqlDataAdapter
$SqlAdapter.SelectCommand = $SqlCmd
$DataSet = New-Object System.Data.DataSet
$SqlAdapter.Fill($DataSet)
$SqlConnection.Close()
$DataSet.Tables[0]