Imports System.Data.SqlClient
Imports System.Collections
Imports System.IO
Imports System.Data.Sql

Public Class clsListener
    Inherits clsDatabaseARCH

    Dim LOG As New clsLogging
    Dim DMA As New clsDma

    Dim PauseOn As Boolean = True
    Dim PauseOff As Boolean = False

    'Static gActiveListeners As New LinkedList(Of String)

    Function AddDirListener(ByVal DirGuid As String,
                            ByVal AdminDisabled As Boolean,
                            ByVal ListenerLoaded As Boolean,
                            ByVal ListenerActive As Boolean,
                            ByVal ListenerPaused As Boolean,
                            ByVal ListenDirectory As Boolean,
                            ByVal ListenSubDirectory As Boolean,
                            ByVal MachineName As String) As Boolean

        Dim tGuid As Guid = New Guid(DirGuid)
        Dim B As Boolean = True
        Dim S As String = ""
        Dim iCnt As Integer = iCount("Select count(*) from DirectoryListener where DirGuid = '" + DirGuid + "'")

        If iCnt > 0 Then
            S = "Update DirectoryListener set AdminDisabled = 0 where DirGuid = '" + DirGuid + "' "
            B = ExecuteSqlNewConn(S, False)

            S = "Update DirectoryListener set ListenerLoaded = 0 where DirGuid = '" + DirGuid + "' "
            B = ExecuteSqlNewConn(S, False)

            S = "Update DirectoryListener set ListenerActive = 0 where DirGuid = '" + DirGuid + "' "
            B = ExecuteSqlNewConn(S, False)

            S = "Update DirectoryListener set ListenerPaused = 0 where DirGuid = '" + DirGuid + "' "
            B = ExecuteSqlNewConn(S, False)

            If ListenDirectory = True Then
                S = "Update DirectoryListener set ListenDirectory = 1 where DirGuid = '" + DirGuid + "' "
                B = ExecuteSqlNewConn(S, False)
            Else
                S = "Update DirectoryListener set ListenDirectory = 0 where DirGuid = '" + DirGuid + "' "
                B = ExecuteSqlNewConn(S, False)
            End If
            If ListenSubDirectory = True Then
                S = "Update DirectoryListener set ListenSubDirectory = 1 where DirGuid = '" + DirGuid + "' "
                B = ExecuteSqlNewConn(S, False)
            Else
                S = "Update DirectoryListener set ListenSubDirectory = 0 where DirGuid = '" + DirGuid + "' "
                B = ExecuteSqlNewConn(S, False)
            End If

        Else
            S = S + " INSERT INTO [DirectoryListener]" + vbCrLf
            S = S + "            ([UserID]" + vbCrLf
            S = S + "            ,[AdminDisabled]" + vbCrLf
            S = S + "            ,[ListenerLoaded]" + vbCrLf
            S = S + "            ,[ListenerActive]" + vbCrLf
            S = S + "            ,[ListenerPaused]" + vbCrLf
            S = S + "            ,[ListenDirectory]" + vbCrLf
            S = S + "            ,[ListenSubDirectory]" + vbCrLf
            S = S + "            ,[DirGuid]" + vbCrLf
            S = S + "            ,[MachineName])"
            S = S + "      VALUES"
            S = S + "            ('" + gCurrUserGuidID + "'" + vbCrLf
            S = S + "            ," & Val(AdminDisabled) & vbCrLf
            S = S + "            ," & Val(ListenerLoaded) & vbCrLf
            S = S + "            ," & Val(ListenerActive) & vbCrLf
            S = S + "            ," & Val(ListenerPaused) & vbCrLf
            S = S + "            ," & Val(ListenDirectory) & vbCrLf
            S = S + "            ," & Val(ListenSubDirectory) & vbCrLf
            S = S + "            ,'" & tGuid.ToString & "'" + vbCrLf
            S = S + "            ,'" + MachineName + "')"

            B = ExecuteSqlNewConn(S, False)
        End If



        Return B
    End Function

    Function deleteDirListener(ByVal DirGuid As String) As Boolean

        Dim B As Boolean = True
        Dim S As String = ""
        S = S + " delete from [DirectoryListener] where DirGuid = '" + DirGuid + "'"
        B = ExecuteSqlNewConn(S, False)

        Return B
    End Function

    Function TurnOffSubDirListener(ByVal DirGuid As String) As Boolean

        Dim B As Boolean = True
        Dim S As String = ""

        S = S + " update [DirectoryListener] set ListenSubDirectory = 0 where DirGuid = '" + DirGuid + "' "

        B = ExecuteSqlNewConn(S, False)

        If B Then
            PauseDirListener(DirGuid, PauseOn)
        End If

        Return B
    End Function

    Function TurnOffListener(ByVal DirGuid As String) As Boolean

        Dim B As Boolean = True
        Dim S As String = ""

        S = S + " update [DirectoryListener] set ListenDirectory = 0 where DirGuid = '" + DirGuid + "' "

        B = ExecuteSqlNewConn(S, False)

        If B Then
            PauseDirListener(DirGuid, PauseOn)
        End If

        Return B
    End Function

    Function PauseDirListener(ByVal DirGuid As String, ByVal bPause As Boolean) As Boolean

        Dim B As Boolean = True
        Dim S As String = ""
        If bPause = True Then
            S = S + " update [DirectoryListener] set ListenerPaused = 1 where DirGuid = '" + DirGuid + "' "
            Dim I As Integer = gActiveListeners.IndexOfKey(DirGuid)
            If I >= 0 Then
                gActiveListeners.Item(DirGuid) = PauseOn
            End If
        Else
            S = S + " update [DirectoryListener] set ListenerPaused = 0 where DirGuid = '" + DirGuid + "' "
            Dim I As Integer = gActiveListeners.IndexOfKey(DirGuid)
            If I >= 0 Then
                gActiveListeners.Item(DirGuid) = PauseOff
            End If
        End If

        B = ExecuteSqlNewConn(S, False)

        Return B
    End Function

    Function DisableDirListenerActive(ByVal DirGuid As String) As Boolean

        Dim B As Boolean = True
        Dim S As String = ""

        S = S + " update [DirectoryListener] set ListenerActive = 0, ListenerPaused = 1 where DirGuid = '" + DirGuid + "' "

        B = ExecuteSqlNewConn(S, False)

        If B Then
            Dim I As Integer = gActiveListeners.IndexOfKey(DirGuid)
            If I >= 0 Then
                gActiveListeners.Values(I) = PauseOn
            End If
        End If

        Return B
    End Function
    Function EnableDirListenerActive(ByVal DirGuid As String) As Boolean

        Dim B As Boolean = True
        Dim S As String = ""

        S = S + " update [DirectoryListener] set ListenerActive = 1, ListenerPaused = 0 where DirGuid = '" + DirGuid + "' "

        B = ExecuteSqlNewConn(S, False)

        If B Then
            Dim I As Integer = gActiveListeners.IndexOfKey(DirGuid)
            If I >= 0 Then
                gActiveListeners.Values(I) = PauseOff
            End If
        End If

        Return B
    End Function

    Function DisableDirListenerAdmin(ByVal DirGuid As String) As Boolean

        Dim B As Boolean = True
        Dim S As String = ""

        S = S + " update [DirectoryListener] set AdminDisabled = 1 where DirGuid = '" + DirGuid + "' "

        B = ExecuteSqlNewConn(S, False)

        Return B
    End Function

    Function EnableDirListenerAdmin(ByVal DirGuid As String) As Boolean

        Dim B As Boolean = True
        Dim S As String = ""

        S = S + " update [DirectoryListener] set AdminDisabled = 0 where DirGuid = '" + DirGuid + "' "

        B = ExecuteSqlNewConn(S, False)

        Return B
    End Function

    Function AddListenerFile(ByVal DirGuid As String, ByVal SourceFile As String, ByVal MachineName As String) As Boolean
        Dim B As Boolean = True
        Dim S As String = ""
        S = S + " INSERT INTO [DirectoryListenerFiles]"
        S = S + "            ([DirGuid]"
        S = S + "            ,[SourceFile]"
        S = S + "            ,[Archived]"
        S = S + "            ,[EntryDate]"
        S = S + "            ,[UserID]"
        S = S + "            ,[MachineName])"
        S = S + "      VALUES"
        S = S + "            ('" + DirGuid + "'"
        S = S + "            ,'" + SourceFile + "'"
        S = S + "            ,0"
        S = S + "            ,'" + Now.ToString + "'"
        S = S + "            ,'" + gCurrUserGuidID + "'"
        S = S + "            ,'" + MachineName + "'"

        B = ExecuteSqlNewConn(S, False)

        Return B
    End Function

    Function setDirListernerON(ByVal DirGuid As String) As Boolean
        Dim B As Boolean = True
        Dim S As String = ""
        S = S + " Update Directory set ListenForChanges = 1, ListenDirectory = 1 where DirGuid = '" + DirGuid + "' "
        B = ExecuteSqlNewConn(S, False)
        If B Then
            PauseDirListener(DirGuid, PauseOff)
        End If
        Return B
    End Function

    Function setSubDirListernerON(ByVal DirGuid As String) As Boolean
        Dim B As Boolean = True
        Dim S As String = ""
        S = S + " Update Directory set ListenSubDirectory = 1 where DirGuid = '" + DirGuid + "' "
        B = ExecuteSqlNewConn(S, False)
        If B Then
            PauseDirListener(DirGuid, PauseOff)
        End If
        Return B
    End Function

    Function setDirListernerOFF(ByVal DirGuid As String) As Boolean
        Dim B As Boolean = True
        Dim S As String = ""
        S = S + " Update Directory set ListenForChanges = 0, ListenDirectory = 0, ListenSubDirectory = 0 where DirGuid = '" + DirGuid + "' "
        B = ExecuteSqlNewConn(S, False)

        If B Then
            PauseDirListener(DirGuid, PauseOn)
        End If

        Return B
    End Function

    Function LoadListeners(ByVal TgtMachineName As String) As Integer

        Dim NbrListeners As Integer = 0

        Dim S As String = ""
        S = S + " SELECT     DirectoryListener.UserID, DirectoryListener.AdminDisabled, DirectoryListener.ListenerLoaded, DirectoryListener.ListenerActive, DirectoryListener.ListenerPaused, "
        S = S + " DirectoryListener.ListenDirectory, DirectoryListener.ListenSubDirectory, DirectoryListener.DirGuid, DirectoryListener.MachineName, Directory.FQN"
        S = S + " FROM         DirectoryListener INNER JOIN"
        S = S + " Directory ON DirectoryListener.DirGuid = Directory.DirGuid"
        S = S + " WHERE     (DirectoryListener.MachineName = '" + TgtMachineName + "') AND (DirectoryListener.ListenerActive = 1)"

        Dim UserID As String = ""
        Dim AdminDisabled As Boolean = False
        Dim ListenerLoaded As Boolean = False
        Dim ListenerActive As Boolean = False
        Dim ListenerPaused As Boolean = False
        Dim ListenDirectory As Boolean = False
        Dim ListenSubDirectory As Boolean = False
        Dim DirGuid As String = ""
        Dim MachineName As String = ""
        Dim FQN As String = ""

        Dim RSData As SqlDataReader = Nothing
        Dim CS As String = getRepoConnStr()
        Dim CONN As New SqlConnection(CS)
        CONN.Open()
        Dim command As New SqlCommand(S, CONN)
        RSData = command.ExecuteReader()
        If RSData.HasRows Then
            Do While RSData.Read()
                NbrListeners += 1
                UserID = RSData.GetValue(0).ToString
                AdminDisabled = RSData.GetValue(1).ToString
                ListenerLoaded = RSData.GetBoolean(2)
                ListenerActive = RSData.GetBoolean(3)
                ListenerPaused = RSData.GetBoolean(4)
                ListenDirectory = RSData.GetBoolean(5)
                ListenSubDirectory = RSData.GetBoolean(6)
                DirGuid = RSData.GetValue(7).ToString
                MachineName = RSData.GetValue(8).ToString
                FQN = RSData.GetValue(9).ToString

                If gActiveListeners.IndexOfKey(DirGuid) >= 0 Then
                Else
                    Dim DL As New clsDirListener
                    DL.WatchDirectory = FQN
                    DL.DirGuid = DirGuid
                    DL.Machinename = MachineName
                    DL.StartListening(ListenSubDirectory)
                    Try
                        gActiveListeners.Add(DirGuid, ListenerPaused)
                    Catch ex As Exception
                        Console.WriteLine(ex.Message)
                    End Try

                End If

            Loop
        Else
            LOG.WriteToArchiveLog("Notification: No directory listeners found for machine " + TgtMachineName + ".")
        End If

        If Not RSData.IsClosed Then
            RSData.Close()
        End If
        RSData = Nothing
        command.Dispose()
        command = Nothing

        If CONN.State = ConnectionState.Open Then
            CONN.Close()
        End If
        CONN.Dispose()
        Return NbrListeners
    End Function

    Sub PauseListeners(ByVal TgtMachineName As String, ByVal bPause As Boolean)

        Dim S As String = ""
        If bPause = True Then
            S = S + " Update [DirectoryListener] set ListenerPaused = 1 "
        Else
            S = S + " Update [DirectoryListener] set ListenerPaused = 0 "
        End If
        S = S + " WHERE  DirectoryListener.MachineName = '" + TgtMachineName + "'"

        Dim B As Boolean = ExecuteSqlNewConn(90400, S)

        For I As Integer = 0 To gActiveListeners.Count - 1
            S = gActiveListeners.Keys(I).ToString
            gActiveListeners.Item(S) = bPause
        Next

    End Sub

End Class
