Imports System.Data.SqlClient
Imports ECMEncryption

Public Class clsUserMgt

    Dim ENC As New ECMEncrypt

    Public Sub setGuids()

        Dim Sql As String = "update [Users] set RowGuid = newid() where RowGuid Is null"

        Using gwayconn As New SqlConnection(gRepoCS)
            Using cmdCommand As SqlCommand = gwayconn.CreateCommand()
                cmdCommand.CommandText = Sql
                cmdCommand.CommandType = CommandType.Text
                cmdCommand.Connection.Open()
                cmdCommand.ExecuteNonQuery()
            End Using
        End Using

    End Sub

    Public Sub SyncPW()
        Dim RepoUsers As Dictionary(Of String, String) = New Dictionary(Of String, String)
        Dim UserID As String = ""
        Dim PW As String = ""

        Dim sql As String = ""

        RepoUsers = getRepoUsers()

        For Each UserID In RepoUsers.Keys
            PW = RepoUsers(UserID)
            sql = "update [User] set UserPW = '" + PW + "' where UserID = '" + UserID + "' "

            Using gwayconn As New SqlConnection(gGatewayCS)
                Using cmdCommand As SqlCommand = gwayconn.CreateCommand()
                    cmdCommand.CommandText = sql
                    cmdCommand.CommandType = CommandType.Text
                    cmdCommand.Connection.Open()
                    cmdCommand.ExecuteNonQuery()
                End Using
            End Using

        Next

    End Sub

    Public Function getRepoUsers() As Dictionary(Of String, String)
        Dim ListOfUsers As Dictionary(Of String, String) = New Dictionary(Of String, String)
        Dim MySql As String = "Select [UserID], UserPassword FROM [Users] where isActive = 'Y'"
        Dim UserID As String = ""
        Dim UserPassword As String = ""
        Dim S As String = ""
        Dim RSData As SqlDataReader = Nothing
        Dim CONN As New SqlConnection(gRepoCS)
        CONN.Open()
        Dim command As New SqlCommand(MySql, CONN)

        RSData = command.ExecuteReader()

        Try
            If RSData.HasRows Then
                While RSData.Read()
                    UserID = RSData.GetValue(0).ToString
                    UserPassword = RSData.GetValue(1).ToString
                    If Not ListOfUsers.ContainsKey(UserID) Then
                        ListOfUsers.Add(UserID, UserPassword)
                    End If
                End While
            End If
        Catch ex As Exception
            MessageBox.Show("ERROR X1: " + ex.Message)
        Finally
            If RSData.IsClosed Then
            Else
                RSData.Close()
            End If
            RSData = Nothing
            If CONN.State = ConnectionState.Open Then
                CONN.Close()
            End If
            CONN.Dispose()
            command.Dispose()
        End Try

        GC.Collect()
        GC.WaitForPendingFinalizers()

        Return ListOfUsers

    End Function

    Public Function getGatewayUsers() As List(Of String)
        Dim ListOfUsers As List(Of String) = New List(Of String)()
        Dim MySql As String = "Select distinct [UserID] FROM [User] "
        Dim UserID As String = ""
        Dim S As String = ""

        Dim RSData As SqlDataReader = Nothing
        Dim CONN As New SqlConnection(gGatewayCS)
        CONN.Open()
        Dim command As New SqlCommand(MySql, CONN)

        RSData = command.ExecuteReader()

        Try
            If RSData.HasRows Then
                While RSData.Read()
                    UserID = RSData.GetValue(0).ToString
                    If Not ListOfUsers.Contains(UserID) Then
                        ListOfUsers.Add(UserID)
                    End If
                End While
            End If
        Catch ex As Exception
            MessageBox.Show("ERROR X1: " + ex.Message)
        Finally
            If RSData.IsClosed Then
            Else
                RSData.Close()
            End If
            RSData = Nothing
            If CONN.State = ConnectionState.Open Then
                CONN.Close()
            End If
            CONN.Dispose()
            command.Dispose()
        End Try

        GC.Collect()
        GC.WaitForPendingFinalizers()

        Return ListOfUsers

    End Function

    Public Function getGatewayRepoUsers() As List(Of String)

        If gInstanceName.Length.Equals(0) Then
            gInstanceName = ""
        End If
        Dim ListOfUsers As List(Of String) = New List(Of String)()
        Dim MySql As String = "select distinct UserID
            from UserRepo
            where CompanyID = '" + gCompanyID + "'
            and SvrName = '" + gSvrName + "'
            and DBNAme = '" + gDBName + "'"
        If gInstanceName.Length.Equals(0) Then
            MySql += vbCrLf + "and (InstanceName = '' or InstanceName = 'NA' or InstanceName is null) "
        Else
            MySql += " And InstanceName = '" + gInstanceName + "'"
        End If
        MySql += " order by UserID"

        Dim UserID As String = ""
        Dim S As String = ""

        Dim RSData As SqlDataReader = Nothing
        Dim CONN As New SqlConnection(gGatewayCS)
        CONN.Open()
        Dim command As New SqlCommand(MySql, CONN)

        RSData = command.ExecuteReader()

        Try
            If RSData.HasRows Then
                While RSData.Read()
                    UserID = RSData.GetValue(0).ToString
                    If Not ListOfUsers.Contains(UserID) Then
                        ListOfUsers.Add(UserID)
                    End If
                End While
            End If
        Catch ex As Exception
            MessageBox.Show("Error X1: " + ex.Message)
        Finally
            If RSData.IsClosed Then
            Else
                RSData.Close()
            End If
            RSData = Nothing
            If CONN.State = ConnectionState.Open Then
                CONN.Close()
            End If
            CONN.Dispose()
            command.Dispose()
        End Try

        GC.Collect()
        GC.WaitForPendingFinalizers()

        Return ListOfUsers

    End Function

    Public Sub getActiveUsers()
        If (gRepoID.Trim.Length = 0) Then
            MessageBox.Show("A Company ID must be supplied, returning...")
            Return
        End If

        Dim RepoUsers As Dictionary(Of String, String) = New Dictionary(Of String, String)
        Dim GatewayUsers As List(Of String) = New List(Of String)()
        Dim GateWayRepoUsers As List(Of String) = New List(Of String)

        RepoUsers = getRepoUsers()
        GatewayUsers = getGatewayUsers()
        GateWayRepoUsers = getGatewayRepoUsers()

        Dim ListOfUsers As List(Of String) = New List(Of String)()
        Dim ListOfUserPW As Dictionary(Of String, String) = New Dictionary(Of String, String)()
        Dim UserID As String = ""
        Dim UserPassword As String = ""

        Try
            For Each sUser As String In RepoUsers.Keys
                UserID = sUser
                UserPassword = RepoUsers(UserID)
                If Not GatewayUsers.Contains(UserID) Then
                    ListOfUsers.Add(UserID)
                    Dim TSQL = "Insert into [User] ([UserID],[UserPW])"
                    TSQL += " VALUES ('" + UserID + "', '" + UserPassword + "')"
                    Using gwayconn As New SqlConnection(gGatewayCS)
                        Using cmdCommand As SqlCommand = gwayconn.CreateCommand()
                            cmdCommand.CommandText = TSQL
                            cmdCommand.CommandType = CommandType.Text
                            cmdCommand.Connection.Open()
                            cmdCommand.ExecuteNonQuery()
                        End Using
                    End Using
                End If
            Next

            For Each UserID In RepoUsers.Keys
                If Not GateWayRepoUsers.Contains(UserID) Then
                    UserPassword = RepoUsers(UserID)
                    ListOfUserPW.Add(UserID, UserPassword)
                    Dim TSQL As String = "Insert into UserRepo (RepoID, [CompanyID],[UserID],[SvrName],[DBName],[InstanceName])"
                    TSQL += " VALUES ('" + gRepoID + "', '" + gCompanyID + "', '" + UserID + "', '" + gSvrName + "', '" + gDBName + "', '" + gInstanceName + "')"
                    Using gwayconn As New SqlConnection(gGatewayCS)
                        Using cmd3 As SqlCommand = gwayconn.CreateCommand()
                            cmd3.CommandText = TSQL
                            cmd3.CommandType = CommandType.Text
                            cmd3.Connection.Open()
                            cmd3.ExecuteNonQuery()
                        End Using
                    End Using
                End If
            Next

            Dim CurrRepoUsers As String = Join(RepoUsers.Keys.ToArray, "','")
            CurrRepoUsers = "('" + CurrRepoUsers + "')"

            Dim S As String = "Delete from [UserRepo] where UserID not in " + CurrRepoUsers
            Using gwayconn As New SqlConnection(gGatewayCS)
                Using cmd2 As SqlCommand = gwayconn.CreateCommand()
                    cmd2.CommandText = S
                    cmd2.CommandType = CommandType.Text
                    cmd2.Connection.Open()
                    cmd2.ExecuteNonQuery()
                End Using
            End Using
        Catch ex As Exception
            MessageBox.Show("ERROR X1: " + ex.Message)
        End Try

        GC.Collect()
        GC.WaitForPendingFinalizers()

    End Sub


End Class
