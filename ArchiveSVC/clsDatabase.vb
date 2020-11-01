Imports System.Data
Imports System.Data.Sql
Imports System.Data.SqlClient
Imports ECMEncryption

Public Class clsDatabase

    Dim sUseEncrypted As String = System.Configuration.ConfigurationManager.AppSettings("UseEncrypted")
    Dim ENC As New ECMEncrypt

    Dim GCS As String = ""

    Private Function setConnStr() As String
        Dim S As String = ""
        Dim pw As String = ""
        If sUseEncrypted.Equals("1") Then
            S = System.Configuration.ConfigurationManager.AppSettings("ENC.ECMREPO")
            pw = System.Configuration.ConfigurationManager.AppSettings("EncPW")
            pw = ENC.AES256DecryptString(S)
            S.Replace("@@PW@@", pw)
        Else
            S = System.Configuration.ConfigurationManager.AppSettings("ECMREPO")
            pw = System.Configuration.ConfigurationManager.AppSettings("EncPW")
            pw = ENC.AES256DecryptString(S)
            S.Replace("@@PW@@", pw)
        End If

        GCS = S
        Return S
    End Function
    Public Function getConnStr() As String
        If GCS.Length > 0 Then
            Return GCS
        Else
            Return setConnStr()
        End If
    End Function
    Public Function ExecuteSqlNewConn(ByVal ID As Integer, ByVal UserGuidID As String, ByVal sql As String, ByRef RetMsg As String) As Boolean
        RetMsg = ""
        Dim txStartTime As Date = Now
        Dim rc As Boolean = False
        Dim CN As New SqlConnection(Me.getConnStr)
        CN.Open()
        Dim dbCmd As SqlCommand = CN.CreateCommand()
        Dim BB As Boolean = True
        Using CN
            dbCmd.Connection = CN
            Try
                dbCmd.CommandText = sql
                dbCmd.ExecuteNonQuery()
                BB = True
            Catch ex As Exception
                rc = False
                Dim ErrMsg As String = "ID: " & ID & " UID: " & UserGuidID
                If InStr(ex.Message, "The DELETE statement conflicted with the REFERENCE", CompareMethod.Text) > 0 Then
                    xTrace(ID, UserGuidID, "ExecuteSqlNewConn", "It appears this user has DATA within the repository associated to them and cannot be deleted." + ErrMsg)
                ElseIf InStr(ex.Message, "HelpText", CompareMethod.Text) > 0 Then
                    BB = True
                ElseIf InStr(ex.Message, "duplicate key row", CompareMethod.Text) > 0 Then
                    BB = True
                ElseIf InStr(ex.Message, "duplicate key", CompareMethod.Text) > 0 Then
                    BB = True
                ElseIf InStr(ex.Message, "duplicate", CompareMethod.Text) > 0 Then
                    BB = True
                Else
                    BB = False
                    xTrace(ID, UserGuidID, "ExecuteSqlNewConn", sql)
                    RetMsg = ex.Message
                End If
            End Try
        End Using

        If CN.State = ConnectionState.Open Then
            CN.Close()
        End If

        CN = Nothing
        dbCmd = Nothing

        RecordSqlExecTime(ID, txStartTime, Now)

        GC.Collect()

        Return BB
    End Function
    Public Sub xTrace(ByVal ID As Integer, ByVal UserGuidID As String, ByVal PgmName As String, ByVal Stmt As String)

        If Stmt.Contains("Failed to save search results") Then
            Return
        End If
        If Stmt.Contains("Column names in each table must be unique") Then
            Return
        End If
        If Stmt.Contains("clsArchiver:ArchiveQuickRefItems") Then
            Return
        End If

        Dim RetStr As String = ""
        Try
            Stmt = Stmt.Replace("'", "`")
            Stmt = Stmt.Replace("'", "`")
            Dim S As String = ""
            PgmName = PgmName.Replace("'", "`")
            S = "INSERT INTO PgmTrace (StmtID ,PgmName, Stmt) VALUES(" & ID & ", '" & PgmName & "','" & Stmt & "')"
            Dim b As Boolean = ExecuteSqlNewConn(ID, UserGuidID, S, RetStr)
        Catch ex As Exception
            Console.WriteLine("clsDatabase:XTRACE-01 - " + ex.Message.ToString)
        End Try

    End Sub
    Sub RecordSqlExecTime(ByVal ID As Integer, ByVal txStartTime As Date, ByVal txEndTime As Date)
        Dim bRunThis As Boolean = False

        If Not bRunThis Then
            Return
        End If

        Dim retMsg As String = ""
        Dim elapsed_time As TimeSpan = Nothing
        elapsed_time = txEndTime.Subtract(txStartTime)
        Dim txTotalTime As Double = elapsed_time.Milliseconds
        Dim RowID As Integer = -1
        Dim S As String = ""

        S = "INSERT INTO [txTimes]([StmtID],[txTime]) VALUES (" & ID & "," & txTotalTime & ")"

        Dim B As Boolean = ExecuteSqlNewConn(9600, "SYSTEM", S, retMsg)

    End Sub



End Class
