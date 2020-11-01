Imports System
Imports System.Data.SqlClient
Imports System.Collections
Imports System.IO
Imports System.Threading

Public Class clsAutoLibRef

    Dim DBARCH As New clsDatabaseARCH
    Dim LEmail As New clsLIBEMAIL
    Dim LDir As New clsLIBDIRECTORY
    Dim LI As New clsLIBRARYITEMS
    Dim DMA As New clsDma
    Dim UTIL As New clsUtility
    Dim LOG As New clsLogging
    Dim tProcessAllRefDirs As Thread
    Dim tProcessAllRefEmails As Thread

    Public Sub ProcessAutoReferences()

        Dim bUSeThreads As Boolean = False

        If bUSeThreads Then
            If Not tProcessAllRefDirs Is Nothing Then
                If tProcessAllRefDirs.IsAlive Then
                    Return
                End If
            End If
            If Not tProcessAllRefEmails Is Nothing Then
                If tProcessAllRefEmails.IsAlive Then
                    Return
                End If
            End If

            tProcessAllRefDirs = New Thread(AddressOf Me.ProcessAllRefDirs)
            tProcessAllRefDirs.Name = "ThreadProcessAllRefDirs"
            tProcessAllRefDirs.Priority = ThreadPriority.Lowest
            tProcessAllRefDirs.Start(bUSeThreads)

            tProcessAllRefEmails = New Thread(AddressOf Me.ProcessAllRefEmails)
            tProcessAllRefEmails.Name = "ThreadProcessAllRefEmails"
            tProcessAllRefEmails.Priority = ThreadPriority.Lowest
            tProcessAllRefEmails.Start(bUSeThreads)
        Else
            ProcessAllRefDirs(bUSeThreads)
            ProcessAllRefEmails(bUSeThreads)
        End If

    End Sub

    Sub ProcessAllRefDirs(ByVal bThreaded As Boolean)

        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Dim A As New ArrayList
        Dim S As String = ""

        S = S + " SELECT     LibDirectory.DirectoryName, LibDirectory.UserID, LibDirectory.LibraryName, Directory.IncludeSubDirs"
        S = S + " FROM         LibDirectory INNER JOIN"
        S = S + " Directory ON LibDirectory.UserID = Directory.UserID AND LibDirectory.DirectoryName = Directory.FQN"
        S = S + " where LibDirectory.UserID = '" + gCurrUserGuidID + "'"

        Dim DirectoryName As String = ""
        Dim UserID As String = ""
        Dim LibraryName As String = ""
        Dim IncludeSubDirs As String = ""

        Dim rsColInfo As SqlDataReader = Nothing
        Dim CS As String = DBARCH.setConnStr()     'DBARCH.getGateWayConnStr(gGateWayID)
        Dim tConn As New SqlConnection(CS)
        If tConn.State = ConnectionState.Closed Then
            tConn.Open()
        End If

        DBARCH.SqlQryNewThread(S, tConn, rsColInfo)

        If rsColInfo.HasRows Then
            Do While rsColInfo.Read()
                DirectoryName = rsColInfo.GetValue(rsColInfo.GetOrdinal("DirectoryName")).ToString
                UserID = rsColInfo.GetValue(rsColInfo.GetOrdinal("UserID")).ToString
                LibraryName = rsColInfo.GetValue(rsColInfo.GetOrdinal("LibraryName")).ToString
                IncludeSubDirs = rsColInfo.GetValue(rsColInfo.GetOrdinal("IncludeSubDirs")).ToString
                A.Add(DirectoryName + "|" + LibraryName + "|" + IncludeSubDirs)
            Loop
        End If

        rsColInfo.Close()
        rsColInfo = Nothing
        tConn.Close()
        tConn = Nothing
        GC.Collect()

        For I As Integer = 0 To A.Count - 1
            Application.DoEvents()
            Dim tArray() = Split(A.Item(I).ToString, "|")
            DirectoryName = tArray(0).ToString
            LibraryName = tArray(1)
            IncludeSubDirs = tArray(2)

            DirectoryName = UTIL.RemoveSingleQuotes(tArray(0).ToString)
            LibraryName = UTIL.RemoveSingleQuotes(tArray(1))
            IncludeSubDirs = UTIL.RemoveSingleQuotes(tArray(2))

            ProcessDirToLibs(DirectoryName, LibraryName, IncludeSubDirs, bThreaded)
        Next
        A.Clear()
        A = Nothing
        GC.Collect()
    End Sub
    Sub ProcessAllRefEmails(ByVal bThreaded As Boolean)

        Dim S As String = ""
        S = S + " SELECT [EmailFolderEntryID]"
        S = S + " ,[UserID]"
        S = S + " ,[LibraryName]"
        S = S + " ,[FolderName]"
        S = S + " FROM  [LibEmail]"
        S = S + " where UserID = '" + gCurrUserGuidID + "'"

        Dim A As New ArrayList
        Dim EmailFolderEntryID As String = ""
        Dim UserID As String = ""
        Dim LibraryName As String = ""
        Dim FolderName As String = ""

        Dim rsColInfo As SqlDataReader = Nothing
        Dim CS As String = DBARCH.setConnStr()     'DBARCH.getGateWayConnStr(gGateWayID)

        Dim tConn As New SqlConnection(CS)
        If tConn.State = ConnectionState.Closed Then
            tConn.Open()
        End If
        DBARCH.SqlQryNewThread(S, tConn, rsColInfo)

        If rsColInfo.HasRows Then
            Do While rsColInfo.Read()

                Try
                    EmailFolderEntryID = rsColInfo.GetValue(rsColInfo.GetOrdinal("EmailFolderEntryID")).ToString
                    UserID = rsColInfo.GetValue(rsColInfo.GetOrdinal("UserID")).ToString
                    LibraryName = rsColInfo.GetValue(rsColInfo.GetOrdinal("LibraryName")).ToString
                    FolderName = rsColInfo.GetValue(rsColInfo.GetOrdinal("FolderName")).ToString
                    A.Add(EmailFolderEntryID + "|" + LibraryName)
                Catch ex As Exception
                    LOG.WriteToArchiveLog("Warning: ProcessAllRefEmails 100 - " + ex.Message)
                End Try
            Loop
        End If

        rsColInfo.Close()
        rsColInfo = Nothing
        tConn.Close()
        tConn = Nothing
        GC.Collect()

        For I As Integer = 0 To A.Count - 1
            Dim tArray() = Split(A.Item(I).ToString, "|")
            EmailFolderEntryID = UTIL.RemoveSingleQuotes(tArray(0))
            LibraryName = UTIL.RemoveSingleQuotes(tArray(1))
            ProcessDirToEmails(EmailFolderEntryID, LibraryName, bThreaded)
        Next
        A.Clear()
        A = Nothing
        GC.Collect()
    End Sub
    Sub ProcessDirToLibs(ByVal DirName As String, ByVal LibName As String, ByVal IncludeSubDirs As String, ByVal bThreaded As Boolean)

        Dim S As String = ""
        S = S + " Select count(*) FROM  [DataSource]"
        If IncludeSubDirs = "Y" Then
            S = S + " where FileDirectory like '" + DirName + "%'"
        Else
            S = S + " where FileDirectory = '" + DirName + "'"
        End If

        S = S + " and SourceGuid not in (Select SourceGuid from LibraryItems where LibraryName = '" + LibName + "')"

        Dim iFileCnt As Integer = DBARCH.iCount(S)

        S = ""
        S = S + " Select [SourceGuid]"
        S = S + " ,[SourceName]"
        S = S + " ,[SourceTypeCode]"
        S = S + " ,[FileDirectory]"
        S = S + " FROM  [DataSource]"

        If IncludeSubDirs = "Y" Then
            S = S + " where FileDirectory like '" + DirName + "%'"
        Else
            S = S + " where FileDirectory = '" + DirName + "'"
        End If

        S = S + " and SourceGuid not in (Select SourceGuid from LibraryItems where LibraryName = '" + LibName + "')"

        If Not bThreaded = False Then
            'FrmMDIMain.TSPB1.Value = 0
            'FrmMDIMain.TSPB1.Maximum = iFileCnt + 1
        End If

        Dim rsColInfo As SqlDataReader = Nothing

        Dim tConn As New SqlConnection
        DBARCH.SqlQryNewThread(S, tConn, rsColInfo)
        Dim ii As Integer = 0
        Try
            If rsColInfo.HasRows Then
                Do While rsColInfo.Read()
                    ii += 1
                    If gTerminateImmediately = True Then
                        Return
                    End If
                    'FrmMDIMain.SB4.Text = "Validate:" & LibName  & ii
                    Application.DoEvents()
                    If Not bThreaded = False Then
                        'FrmMDIMain.TSPB1.Value = ii
                    End If
                    Application.DoEvents()
                    Dim NewGuid As String = System.Guid.NewGuid.ToString()
                    Dim Itemtitle As String = rsColInfo.GetValue(rsColInfo.GetOrdinal("SourceName")).ToString
                    Dim SourceTypeCode As String = rsColInfo.GetValue(rsColInfo.GetOrdinal("SourceTypeCode")).ToString
                    Dim SourceGuid As String = rsColInfo.GetValue(rsColInfo.GetOrdinal("SourceGuid")).ToString
                    LI.setAddedbyuserguidid(gCurrUserGuidID)
                    LI.setDatasourceowneruserid(gCurrUserGuidID)
                    LI.setItemtitle(Itemtitle)
                    LI.setItemtype(SourceTypeCode)
                    LI.setLibraryitemguid(NewGuid)
                    LI.setLibraryname(LibName)
                    LI.setLibraryowneruserid(gCurrUserGuidID)
                    LI.setSourceguid(SourceGuid)
                    Dim B As Boolean = LI.Insert()
                    If Not B Then
                        LOG.WriteToArchiveLog("Error #654.342.1 - Failed to add Auto Ref Directory '" + DirName + ":'" + LibName + "' .")
                    End If

                    If Not bThreaded Then
                        If ii Mod 100 = 0 Then
                            'FrmMDIMain.SB.Text = "Adding to " + LibName  + "# " + ii.ToString + " of " + iFileCnt.ToString
                            Application.DoEvents()
                        End If
                    End If
                Loop
            End If
        Catch ex As Exception
            LOG.WriteToArchiveLog("ERROR: - " + ex.Message)
        Finally
            If Not rsColInfo Is Nothing Then
                If Not rsColInfo.IsClosed Then
                    rsColInfo.Close()
                End If
                rsColInfo = Nothing
            End If
            If Not tConn Is Nothing Then
                tConn.Close()
                tConn = Nothing
            End If
            GC.Collect()
        End Try
        If Not bThreaded Then
            'FrmMDIMain.TSPB1.Value = 0
        End If
        'FrmMDIMain.SB4.Text = ""
    End Sub

    Sub ProcessDirToEmails(ByVal FolderEntryID As String, ByVal LibName As String, ByVal bThreaded As Boolean)
        Dim LL As Integer = 0
        Try
            Dim SqlList As New ArrayList : LL = 1

            Dim S As String = "" : LL = 3
            S = S + " SELECT  [EmailGuid]" : LL = 4
            S = S + " ,[ShortSubj]" : LL = 5
            S = S + " ,[SourceTypeCode]" : LL = 6
            S = S + " ,[CurrMailFolderID]" : LL = 7
            S = S + " FROM  [Email]" : LL = 8
            S = S + " WHERE CurrMailFolderID = '" + FolderEntryID + "' "
            S = S + " AND EmailGuid not in (Select SourceGuid from LibraryItems where LibraryName = '" + LibName + "')" : LL = 9
            LL = 10
            Dim rsColInfo As SqlDataReader = Nothing : LL = 11
            LL = 12
            Dim tConn As New SqlConnection : LL = 13
            DBARCH.SqlQryNewThread(S, tConn, rsColInfo) : LL = 14
            Dim II As Integer = 0 : LL = 15
            LL = 16
            Try : LL = 17
                If rsColInfo.HasRows Then : LL = 18
                    Do While rsColInfo.Read() : LL = 19
                        II += 1 : LL = 20
                        Dim Itemtitle As String = "" : LL = 21
                        Try : LL = 22
                            Dim NewGuid As String = System.Guid.NewGuid.ToString() : LL = 23
                            Itemtitle = rsColInfo.GetValue(1).ToString : LL = 24
                            Dim SourceTypeCode As String = ".msg" : LL = 25
                            Dim SourceGuid As String = rsColInfo.GetValue(0).ToString : LL = 26
                            LI.setAddedbyuserguidid(gCurrUserGuidID) : LL = 27
                            LI.setDatasourceowneruserid(gCurrUserGuidID) : LL = 28
                            LI.setItemtitle(Itemtitle) : LL = 29
                            LI.setItemtype(SourceTypeCode) : LL = 30
                            LI.setLibraryitemguid(NewGuid) : LL = 31
                            LI.setLibraryname(LibName) : LL = 32
                            LI.setLibraryowneruserid(gCurrUserGuidID) : LL = 33
                            LI.setSourceguid(SourceGuid) : LL = 34
                            LL = 35
                            Dim B As Boolean = LI.InsertIntoList(SqlList) : LL = 36
                            If Not B Then
                                Debug.Print("Error #654.342.1 - Failed to add Auto Ref Email.") : LL = 37
                            End If : LL = 38
                            If Not bThreaded Then : LL = 39
                                'FrmMDIMain.SB.Text = "E-Ref# " + II.ToString : LL = 40
                            End If : LL = 41
                        Catch ex As Exception
                            LOG.WriteToArchiveLog("WARNING: ProcessDirToEmails: " + Itemtitle + " did not load." + vbCrLf + "LL = " + LL.ToString)
                        End Try : LL = 43
                        LL = 44
                        Application.DoEvents() : LL = 45
                    Loop : LL = 46
                End If : LL = 47
            Catch ex As Exception
                LOG.WriteToArchiveLog("WARNING: ProcessDirToEmails: 100 " + ex.Message + vbCrLf + "LL = " + LL.ToString)
            Finally : LL = 49
                rsColInfo.Close() : LL = 50
                rsColInfo = Nothing : LL = 51
                tConn.Close() : LL = 52
                tConn = Nothing : LL = 53
                GC.Collect() : LL = 54
            End Try : LL = 55
            LL = 56
            If SqlList.Count > 0 Then : LL = 57
                LL = 58
                'Dim CN As New SqlConnection(DBARCH.setConnStr()     'DBARCH.getGateWayConnStr(gGateWayID)) : LL =  59
                'Try : LL =  60
                '    CN.Open() : LL =  61
                'Catch ex As Exception
                '    log.WriteToArchiveLog("ERROR ProcessDirToEmails - 100 Connection not opened: " + ex.Message) : LL =  62
                '    log.WriteToArchiveLog("ERROR ProcessDirToEmails - 100 Connection not opened: " + ex.StackTrace) : LL =  63
                '    Return : LL =  64
                'End Try : LL =  65
                LL = 66
                For I As Integer = 0 To SqlList.Count - 1 : LL = 67
                    Try : LL = 68
                        If Not bThreaded Then
                            'FrmMDIMain.SB.Text = LibName  + " : AddRef# " + I.ToString + " of " + SqlList.Count.ToString : LL = 69
                        End If : LL = 70
                        LL = 71
                        Application.DoEvents() : LL = 72
                        Dim MySql As String = SqlList(I) : LL = 73
                        'Dim B As Boolean = DBARCH.ExecuteSqlSameConn(MySql, CN) : LL =  74
                        Dim B As Boolean = DBARCH.ExecuteSqlTx(MySql) : LL = 75
                        If Not B Then
                            LOG.WriteToArchiveLog("ERROR ProcessDirToEmails - 200 Connection not opened: " + MySql + vbCrLf + "LL = " + LL.ToString)
                        End If : LL = 77
                    Catch ex As Exception
                        LOG.WriteToArchiveLog("WARNING: ProcessDirToEmails: 200 " + ex.Message + vbCrLf + "LL = " + LL.ToString)
                    End Try : LL = 79
                Next : LL = 80
                : LL = 81
                'If Not CN Is Nothing Then : LL =  82
                '    If CN.State = ConnectionState.Open Then : LL =  83
                '        CN.Close() : LL =  84
                '    End If : LL =  85
                '    CN.Dispose() : LL =  86
                'End If : LL =  87
            End If : LL = 88
        Catch ex As Exception
            LOG.WriteToArchiveLog("ERROR: ProcessDirToEmails: 220 " + ex.Message + vbCrLf + "LL = " + LL.ToString)
        End Try

        GC.Collect() : LL = 89
        GC.WaitForPendingFinalizers()

    End Sub
End Class