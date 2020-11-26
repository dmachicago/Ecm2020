Imports System.IO
Imports System.Diagnostics
Imports System.Data.SqlClient
Imports System.Threading

Public Class clsDirListener
    'Inherits clsArchiver
    Public BUSY As Boolean = False
    Dim ThreadCnt As Integer = 0
    Dim SCONN As SqlConnection = Nothing
    Dim LOG As New clsLogging
    Dim UTIL As New clsUtility

    Dim CS As String = My.Settings.UserDefaultConnString.ToString
    Private watchfolder As FileSystemWatcher
    Private _Directory As String = ""
    Private _DirGuid As String = ""
    Private _SourceFile As String = ""

    'Dim gFilesToArchive As New List(Of String)
    Dim CopyOfFilesToArchive As New List(Of String)
    Private _Machinename As String = ""

    Public Property SourceFile() As String
        Get
            Return _SourceFile
        End Get
        Set(ByVal Value As String)
            _SourceFile = Value
        End Set
    End Property
    Public Property DirGuid() As String
        Get
            Return _DirGuid
        End Get
        Set(ByVal Value As String)
            _DirGuid = Value
        End Set
    End Property
    Public Property WatchDirectory() As String
        Get
            Return _Directory
        End Get
        Set(ByVal Value As String)
            _Directory = Value
        End Set
    End Property
    Public Property Machinename() As String
        Get
            Return _Machinename
        End Get
        Set(ByVal Value As String)
            _Machinename = Value
        End Set
    End Property

    Public Function ExecuteSqlNewConn(ByVal sql As String) As Boolean
        Dim rc As Boolean = False
        Dim CN As New SqlConnection(CS)
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
                    If gRunUnattended = False Then MessageBox.Show("It appears this user has DATA within the repository associated to them and cannot be deleted." + Environment.NewLine + Environment.NewLine + ex.Message)
                    LOG.WriteToArchiveLog("It appears this user has DATA within the repository associated to them and cannot be deleted." + Environment.NewLine + Environment.NewLine + ex.Message)
                ElseIf InStr(ex.Message, "HelpText", CompareMethod.Text) > 0 Then
                    BB = True
                ElseIf InStr(ex.Message, "duplicate key row", CompareMethod.Text) > 0 Then
                    'log.WriteToArchiveLog("clsDirListener : ExecuteSqlNewConn : 1464c1 : " + ex.Message)
                    'log.WriteToArchiveLog("clsDirListener : ExecuteSqlNewConn : 1464c1 : " + sql)
                    BB = True
                ElseIf InStr(ex.Message, "duplicate key", CompareMethod.Text) > 0 Then
                    'log.WriteToArchiveLog("clsDirListener : ExecuteSqlNewConn : 1465c2 : " + ex.Message)
                    'log.WriteToArchiveLog("clsDirListener : ExecuteSqlNewConn : 1464c2 : " + sql)
                    BB = True
                ElseIf InStr(ex.Message, "duplicate", CompareMethod.Text) > 0 Then
                    'log.WriteToArchiveLog("clsDirListener : ExecuteSqlNewConn : 1466c3 : " + ex.Message)
                    'log.WriteToArchiveLog("clsDirListener : ExecuteSqlNewConn : 1464c3 : " + sql)
                    BB = True
                Else
                    'messagebox.show("Execute SQL: " + ex.Message + environment.NewLine + "Please review the trace log." + environment.NewLine + sql)
                    BB = False
                    xTrace(885121, "ExecuteSqlNewConn 10: ", ex.Message.ToString)
                    xTrace(885122, "ExecuteSqlNewConn 10: ", ex.StackTrace.ToString)
                    xTrace(885123, "ExecuteSqlNewConn 10: ", Mid(sql, 1, 2000))
                    LOG.WriteToArchiveLog("clsDirListener : ExecuteSqlNewConn : 89442a1p1: " + ex.Message)
                    LOG.WriteToArchiveLog("clsDirListener : ExecuteSqlNewConn : 8442a1p1: " + ex.StackTrace)
                    LOG.WriteToArchiveLog("clsDirListener : ExecuteSqlNewConn : 8442a1p2: " + Environment.NewLine + sql + Environment.NewLine)
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
    Public Sub CloseConn()
        If SCONN Is Nothing Then
        Else
            If SCONN.State = ConnectionState.Open Then
                SCONN.Close()
            End If
            SCONN.Dispose()
        End If
        GC.Collect()
    End Sub

    Public Sub CkConn()
        If SCONN Is Nothing Then
            Try
                SCONN = New SqlConnection
                SCONN.ConnectionString = CS
                SCONN.Open()
            Catch ex As Exception
                LOG.WriteToArchiveLog("clsDirListener : CkConn : 338 : " + ex.Message)
            End Try
        End If
        If SCONN.State = Data.ConnectionState.Closed Then
            Try
                SCONN.ConnectionString = CS
                SCONN.Open()
            Catch ex As Exception

                LOG.WriteToArchiveLog("clsDirListener : CkConn : 348 : " + ex.Message)
            End Try
        End If
    End Sub

    Public Function iCount(ByVal S As String) As Integer
        Try
            CloseConn()
            CkConn()
            Dim Cnt As Integer
            Dim rsData As SqlDataReader = Nothing
            Dim b As Boolean = False
            Dim CONN As New SqlConnection(CS) : CONN.Open() : Dim command As New SqlCommand(S, CONN) : rsData = command.ExecuteReader()
            rsData.Read()
            Cnt = rsData.GetInt32(0)
            rsData.Close()
            rsData = Nothing
            Return Cnt
        Catch ex As Exception
            xTrace(12306, "clsDirListener:iCount", ex.Message)
            LOG.WriteToArchiveLog("ERROR 1993.21: " + ex.Message)
            LOG.WriteToArchiveLog("clsDirListener : iCount : 2054 : " + ex.Message)
            Return -1
        End Try
    End Function

    Public Function SqlQry(ByVal sql As String) As SqlDataReader
        Try
            ''Session("ActiveError") = False
            Dim ddebug As Boolean = True
            Dim queryString As String = sql
            Dim rc As Boolean = False
            Dim rsDataQry As SqlDataReader = Nothing

            CloseConn()
            CkConn()

            If SCONN.State = Data.ConnectionState.Open Then
                SCONN.Close()
            End If

            CloseConn()
            CkConn()

            Dim command As New SqlCommand(sql, SCONN)

            Try
                rsDataQry = command.ExecuteReader()
            Catch ex As Exception
                LOG.WriteToArchiveLog("clsDatabaseARCH : SqlQry : 1319 : " + ex.Message)
                LOG.WriteToArchiveLog("clsDatabaseARCH : SqlQry : 1319 Server too Busy : " + Environment.NewLine + sql)
            End Try

            command.Dispose()
            command = Nothing

            Return rsDataQry
        Catch ex As Exception
            LOG.WriteToArchiveLog("ERROR: SqlQry 100 - Server too busy: " + ex.Message)
        End Try

        Return Nothing

    End Function

    Public Sub xTrace(ByVal StmtID As Integer, ByVal PgmName As String, ByVal Stmt As String)

        If Stmt.Contains("Failed to save search results") Then
            Return
        End If
        If Stmt.Contains("Column names in each table must be unique") Then
            Return
        End If
        If Stmt.Contains("clsArchiver:ArchiveQuickRefItems") Then
            Return
        End If

        Try
            FixSingleQuotes(Stmt)
            Dim mySql As String = ""
            PgmName = UTIL.RemoveSingleQuotes(PgmName)
            mySql = "INSERT INTO PgmTrace (StmtID ,PgmName, Stmt) VALUES(" & StmtID & ", '" & PgmName & "','" & Stmt & "')"
            Dim b As Boolean = Me.ExecuteSqlNewConn(mySql)
            If b = False Then
                ''Session("ErrMsg") = "StmtId Call: " + 'Session("ErrMsg")
                ''Session("ErrStack") = "StmtId Call Stack: " + ''Session("ErrStack")
            End If
        Catch ex As Exception
            LOG.WriteToArchiveLog("clsDirListener : xTrace : 1907 : " + ex.Message)
        End Try

    End Sub

    Sub FixSingleQuotes(ByRef Stmt As String)
        Dim I As Integer = 0
        Dim CH As String = ""
        For I = 1 To Stmt.Length
            CH = Mid(Stmt, I, 1)
            If CH = "'" Then
                Mid(Stmt, I, 1) = "`"
            End If
        Next
    End Sub

    '** Start the Listeners listening
    Sub StartListening(ByVal IncludeSubDirs As Boolean)
        Try
            watchfolder = New System.IO.FileSystemWatcher
            'Add a list of Filters we want to specify, making sure
            'you use OR for each Filter as we need to all of those
            watchfolder.NotifyFilter = IO.NotifyFilters.DirectoryName
            watchfolder.NotifyFilter = watchfolder.NotifyFilter Or IO.NotifyFilters.FileName
            watchfolder.NotifyFilter = watchfolder.NotifyFilter Or IO.NotifyFilters.Attributes
            watchfolder.NotifyFilter = watchfolder.NotifyFilter Or IO.NotifyFilters.Security

            watchfolder.IncludeSubdirectories = IncludeSubDirs

            'this is the path we want to monitor
            watchfolder.Path = _Directory
            watchfolder.Filter = "*.*"

            ' add the handler to each event
            AddHandler watchfolder.Changed, AddressOf DirectoryChange
            AddHandler watchfolder.Created, AddressOf DirectoryChange
            AddHandler watchfolder.Deleted, AddressOf DirectoryChange

            ' add the rename handler as the signature is different AddHandler watchfolder.Renamed, AddressOf logrename

            'Set this property to true to start watching
            watchfolder.EnableRaisingEvents = True
        Catch ex As Exception
            LOG.WriteToArchiveLog("ATTENTION: Listener NOT started for: " + _Directory + Environment.NewLine + ex.Message + Environment.NewLine + ex.StackTrace.ToString)
        End Try

    End Sub

    Sub StopListening()

        ' Stop watching the folder
        watchfolder.EnableRaisingEvents = False

    End Sub
    Sub PauseListening(ByVal bPause As Boolean)

        If bPause = True Then
            ' Stop watching the folder
            watchfolder.EnableRaisingEvents = False
        Else
            ' start watching the folder
            watchfolder.EnableRaisingEvents = True
        End If

    End Sub

    'Sub UploadAwaitingFiles()

    '    If gFilesToArchive.Count > 0 Then
    '        CopyOfFilesToArchive.Clear()
    '        SyncLock Me
    '            For IX As Integer = 0 To gFilesToArchive.Count - 1
    '                CopyOfFilesToArchive.Add(gFilesToArchive(IX))
    '            Next
    '            gFilesToArchive.Clear()
    '        End SyncLock
    '    End If

    '    If CopyOfFilesToArchive.Count > 0 Then
    '        '** OK _ process the waiting files
    '        Application.DoEvents()
    '        Dim t As Thread
    '        t = New Thread(AddressOf RegisterArchiveFileList)
    '        t.Name = "Update: gFilesToArchive " & ThreadCnt.ToString
    '        t.Start(CopyOfFilesToArchive)
    '        Application.DoEvents()

    '    End If

    'End Sub

    '** This is the heart of the listener -
    '** One will launch for each listened to directory
    '** The listener detects a change or addition or deletion to a file
    '** within a directory or subdirectory
    Private Function DirectoryChange(ByVal source As Object, ByVal e As System.IO.FileSystemEventArgs) As Boolean

        If isListenerPaused() = True Then
            gListenerActivityStart = Now
            LOG.WriteToArchiveLog("Listener for Dir: " + WatchDirectory + " is disabled.")
            Return False
        End If

        BUSY = True

        Dim FQN As String = ""
        Dim InstantArchive As Boolean = True
        Dim Description As String = ""
        Dim Keywords As String = ""
        Dim isEmailAttachment As Boolean = False

        If e.ChangeType = IO.WatcherChangeTypes.Changed Then
            gListenerActivityStart = Now
            LOG.WriteListenerLog("CHG" + Chr(254) + e.FullPath)
            LOG.WriteToArchiveLog("File " & e.FullPath & " has been changed.")
            frmMain.TimerUploadFiles.Enabled = True
            If Not gFilesToArchive.ContainsKey(e.FullPath) Then
                gFilesToArchive.Add(e.FullPath, gFilesToArchive.Count)
            End If
        ElseIf e.ChangeType = IO.WatcherChangeTypes.Renamed Then
            gListenerActivityStart = Now
            LOG.WriteListenerLog("NEW" + Chr(254) + e.FullPath)
            LOG.WriteToArchiveLog("File " & e.FullPath & " has been renamed.")
            frmMain.TimerUploadFiles.Enabled = True
            If Not gFilesToArchive.ContainsKey(e.FullPath) Then
                gFilesToArchive.Add(e.FullPath, gFilesToArchive.Count)
            End If
        ElseIf e.ChangeType = IO.WatcherChangeTypes.Created Then
            gListenerActivityStart = Now
            LOG.WriteListenerLog("NEW" + Chr(254) + e.FullPath)
            LOG.WriteToArchiveLog("File " & e.FullPath & " has been created.")
            frmMain.TimerUploadFiles.Enabled = True
            If Not gFilesToArchive.ContainsKey(e.FullPath) Then
                gFilesToArchive.Add(e.FullPath, gFilesToArchive.Count)
            End If

        ElseIf e.ChangeType = IO.WatcherChangeTypes.Deleted Then
            gListenerActivityStart = Now
            LOG.WriteToArchiveLog("File " & e.FullPath & " has been deleted by " & gCurrUserGuidID)
            LOG.WriteListenerLog("DEL" + Chr(254) & e.FullPath)
        End If
        BUSY = False
        Return True
    End Function

    Sub RegisterArchiveFileList(ByVal L As SortedList(Of String, String))
        Dim DBARCH As New clsDatabaseARCH
        Dim SourceFile As String = ""
        Dim DirFQN As String = ""
        Try
            Dim B As Boolean = False
            For Each S As String In L.Keys
                Dim sKey As String = S
                Application.DoEvents()
                SourceFile = S
                Dim IDX As Integer = L.IndexOfValue(S)
                DirFQN = L.Values(IDX)
                B = DBARCH.RegisterArchiveFile(SourceFile, DirFQN)
                gListenerActivityStart = Now
            Next
        Catch ex As Exception
            LOG.WriteToArchiveLog("ERROR: RegisterArchiveFileList 100 - " + ex.Message)
        Finally
            DBARCH = Nothing
        End Try

    End Sub

    Function isListenerPaused() As Boolean
        Dim B As Boolean = False
        If gActiveListeners.IndexOfKey(DirGuid) >= 0 Then
            B = gActiveListeners.Item(DirGuid)
        End If

        Return B
    End Function

End Class