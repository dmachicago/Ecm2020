#   References used
Imports Microsoft.SqlServer.Management.Smo
Imports Microsoft.SqlServer.Management.Common
 
'    Holds the script for creating tables in database.
Dim tableText As String
 
'   Path of table creation script in the project folder.
 
Dim tableFileName As String = My.Application.Info.DirectoryPath &
"\ScriptFile\TablesScripts.sql"

Dim srvMgmtServer As Server = New Server()
Dim srvConn As ServerConnection
Dim objDB As Database = srvMgmtServer.Databases("DatabaseName")
 
srvConn = srvMgmtServer.ConnectionContext
srvConn.ServerInstance = "ServerName"
srvConn.LoginSecure = False
 
If srvConn.LoginSecure = False Then
            
           srvConn.Login = "UserName"
           srvConn.Password = "Password"
 
End If
 
Using FileReader As New _
                Microsoft.VisualBasic.FileIO.TextFieldParser(tableFileName)
                tableText = FileReader.ReadToEnd
End Using
 
If tableText <> "" Then
                
  objDB.ExecuteNonQuery(tableText)
          
End If