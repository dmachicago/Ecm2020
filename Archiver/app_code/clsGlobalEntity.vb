Imports System.Data.SqlClient

Public Class clsGlobalEntity

    Dim LOG As New clsLogging
    Dim UTIL As New clsUtility
    Dim KEY As New clsKeyGen

    Dim HashCode As String = ""
    Dim GuidID As Guid = Nothing
    Dim ShortName As String = ""
    Dim LongName As String = ""
    Dim LocatorID As Integer = 0
    Dim gConnStr As String = ""
    Dim gConn As SqlConnection
    Dim ShortNameLength As Integer = 250

    Function XXAddItem(ByVal FQN As String, ByVal TableName As String, ByVal CaseSensitive As Boolean) As Guid

        If CaseSensitive = False Then
            FQN = FQN.ToUpper
        End If

        FQN = UTIL.RemoveSingleQuotes(FQN)

        Dim NameLength As Integer = FQN.Length
        Dim S As String = ""
        Dim NewGuid As Guid = ItemExists(FQN, TableName, CaseSensitive)

        Try
            If NewGuid = Nothing Then
                If NameLength <= ShortNameLength Then
                    ShortName = UTIL.RemoveSingleQuotes(FQN)
                    LongName = ""
                Else
                    LongName = UTIL.RemoveSingleQuotes(FQN)
                    ShortName = ""
                End If

                HashCode = KEY.getMD5HashX(FQN)
                NewGuid = Guid.NewGuid
                S = ""
                If TableName.Equals("GlobalDirectory") Then
                    S = S + " INSERT INTO [GlobalDirectory]"
                ElseIf TableName.Equals("GlobalFile") Then
                    S = S + " INSERT INTO  [GlobalFile] "
                ElseIf TableName.Equals("GlobalLocation") Then
                    S = S + " INSERT INTO  [GlobalLocation] "
                ElseIf TableName.Equals("GlobalMachine") Then
                    S = S + " INSERT INTO  [GlobalMachine] "
                ElseIf TableName.Equals("GlobalEmail") Then
                    S = S + " INSERT INTO  [GlobalEmail] "
                Else
                    LOG.WriteToArchiveLog("ERROR AddEntity - incorrect table name supplied '" + TableName + "'.")
                    Return Nothing
                End If
                S = S + " ([HashCode]"
                S = S + " ,[GuidID]"
                S = S + " ,[ShortName] "
                S = S + " ,[LongName])"
                S = S + " VALUES "
                S = S + " ('" + HashCode + "'"
                S = S + " ,'" + NewGuid.ToString + "'"
                S = S + " ,'" + ShortName + "'"
                S = S + " ,'" + LongName + "')"

                Dim B As Boolean = ExecSql(S)

                If B = False Then
                    LOG.WriteToArchiveLog("ERROR AddEntity - Table name  '" + TableName + "' - " + vbCrLf + S)
                    NewGuid = Nothing
                End If

            End If
        Catch ex As Exception
            LOG.WriteToArchiveLog("ERROR AddEntity - 100: Table name  '" + TableName + "' - " + FQN)
            NewGuid = Nothing
        End Try

        Return NewGuid

    End Function

    Function ItemExists(ByVal FQN As String, ByVal TableName As String, ByVal CaseSensitive As Boolean) As Guid

        If CaseSensitive = False Then
            FQN = FQN.ToUpper
        End If

        Dim B As Boolean = False
        Dim NameLength As Integer = FQN.Length

        GuidID = Nothing

        HashCode = KEY.getMD5HashX(FQN)
Dim S AS String  = "" 

        Try
            S = " Select "
            S = S + "  [GuidID]"
            S = S + " ,[ShortName]"
            S = S + " ,[LongName]"
            S = S + " ,[LocatorID]"
            If TableName.Equals("GlobalDirectory") Then
                S = S + " FROM [GlobalDirectory] "
            ElseIf TableName.Equals("GlobalFile") Then
                S = S + " FROM [GlobalFile] "
            ElseIf TableName.Equals("GlobalLocation") Then
                S = S + " FROM [GlobalLocation] "
            ElseIf TableName.Equals("GlobalMachine") Then
                S = S + " FROM [GlobalMachine] "
            ElseIf TableName.Equals("GlobalEmail") Then
                S = S + " FROM [GlobalEmail] "
            Else
                log.WriteToArchiveLog("ERROR EntityExists - incorrect table name supplied '" + TableName + "'.")
                Return Nothing
            End If

            S = S + " where HashCode = '" + HashCode + "'"

            Dim ddebug As Boolean = False
            Dim rc As Boolean = False
            Dim rsDataQry As SqlDataReader = Nothing
            setConnStr()

            Dim CN As New SqlConnection(gConnStr)

            If CN.State = ConnectionState.Closed Then
                CN.Open()
            End If

            Dim command As New SqlCommand(S, CN)

            Try
                rsDataQry = command.ExecuteReader()
                If rsDataQry.HasRows Then
                    Do While rsDataQry.Read()
                        If NameLength <= ShortNameLength Then
                            GuidID = rsDataQry.GetGuid(0)
                            ShortName = rsDataQry.GetString(1)
                            If FQN.Equals(ShortName) Then
                                Exit Do
                            End If
                        Else
                            GuidID = rsDataQry.GetGuid(0)
                            LongName = rsDataQry.GetString(2)
                            If FQN.Equals(ShortName) Then
                                Exit Do
                            End If
                        End If
                    Loop
                End If
            Catch ex As Exception
                log.WriteToArchiveLog("ItemExists : 1300 : " + ex.Message)
                GuidID = Nothing
            Finally
                command.Dispose()
                command = Nothing
                If CN.State = ConnectionState.Open Then
                    CN.Close()
                End If
                CN.Dispose()

                GC.Collect()
            End Try
        Catch ex As Exception
            log.WriteToArchiveLog("ItemExists : 1301 : " + ex.Message)
            GuidID = Nothing
        End Try

        Return GuidID

    End Function


    Public Sub setConnStr()
Dim S AS String  = "" 
        SyncLock Me
            Try
                'If ddebug Then log.WriteToArchiveLog("010 - gUserConnectionStringConfirmedGood is being initiated.")
                S = My.Settings("UserDefaultConnString")
                If Not S.Equals("?") Then
                    If gUserConnectionStringConfirmedGood = True Then
                        gConnStr = S
                    Else
                        Try
                            If gConn.State = ConnectionState.Open Then
                                'If ddebug Then log.WriteToArchiveLog("400 - gUserConnectionStringConfirmedGood.")
                                gConn.Close()
                            End If
                            'If ddebug Then log.WriteToArchiveLog("500 - gUserConnectionStringConfirmedGood.")
                            gConn.ConnectionString = S
                            gConn.Open()
                            gUserConnectionStringConfirmedGood = True
                            My.Settings("UserDefaultConnString") = S
                            My.Settings.Save()
                            gConnStr = S
                        Catch ex As Exception
                            '** The connection failed use the APP.CONFIG string
                            S = System.Configuration.ConfigurationManager.AppSettings("ECMREPO")
                            My.Settings("UserDefaultConnString") = S
                            My.Settings.Save()
                            gUserConnectionStringConfirmedGood = True
                            gConnStr = S
                        End Try
                    End If
                    GoTo SKIPOUT
                ElseIf S.Equals("?") Then
                    '** First time, set the connection str to the APP.CONFIG.
                    ''If ddebug Then log.WriteToArchiveLog("1001 - gUserConnectionStringConfirmedGood.")
                    S = System.Configuration.ConfigurationManager.AppSettings("ECMREPO")
                    My.Settings("UserDefaultConnString") = S
                    My.Settings.Save()
                    ''If ddebug Then log.WriteToArchiveLog("1002 - gUserConnectionStringConfirmedGood.")
                    gUserConnectionStringConfirmedGood = True
                    gConnStr = S
                    'If ddebug Then log.WriteToArchiveLog("1003 - gUserConnectionStringConfirmedGood.")
                    GoTo SKIPOUT
                End If
            Catch ex As Exception
                'If ddebug Then log.WriteToArchiveLog("1004 - gUserConnectionStringConfirmedGood.")
                S = System.Configuration.ConfigurationManager.AppSettings("ECMREPO")
                log.WriteToArchiveLog("1005 - gUserConnectionStringConfirmedGood: " + S)
            End Try

            Dim bUseConfig As Boolean = True

            'If ddebug Then log.WriteToArchiveLog("1006 - gUserConnectionStringConfirmedGood.")


            S = System.Configuration.ConfigurationManager.AppSettings("ECMREPO")
            UTIL.setConnectionStringTimeout(S)

            gConnStr = S
SKIPOUT:
        End SyncLock
    End Sub

    Public Function ExecSql(ByVal sql As String) As Boolean
        Dim rc As Boolean = False
        setConnStr()
        Dim CN As New SqlConnection(gConnStr)
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
                If InStr(ex.Message, "The DELETE statement conflicted with the REFERENCE", CompareMethod.Text) > 0 Then
                    If gRunUnattended = False Then messagebox.show("It appears this user has DATA within the repository associated to them and cannot be deleted." + vbCrLf + vbCrLf + ex.Message)
                    log.WriteToArchiveLog("It appears this user has DATA within the repository associated to them and cannot be deleted." + vbCrLf + vbCrLf + ex.Message)
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
                    LOG.WriteToArchiveLog("clsDatabaseARCH : ExecuteSqlNewConn : 79442a1p1: " + ex.Message)
                    LOG.WriteToArchiveLog("clsDatabaseARCH : ExecuteSqlNewConn : 7442a1p2: " + vbCrLf + sql + vbCrLf)
                End If

            End Try
        End Using

        If CN.State = ConnectionState.Open Then
            CN.Close()
        End If

        CN = Nothing
        dbCmd = Nothing
        GC.Collect()

        Return BB
    End Function

End Class
