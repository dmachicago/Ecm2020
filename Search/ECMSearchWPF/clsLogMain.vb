Imports System.IO
Imports System.Collections
Imports ECMEncryption

Public Class clsLogMain

    Private proxy As New SVCSearch.Service1Client
    Dim ENC2 As New ECMEncrypt()
    Private gDebug As Boolean = False
    Private gSecureID As String = -1

    'Public Function getEnvApplicationExecutablePath() As String
    '    Return Application.ExecutablePath
    'End Function
    Public Function getEnvVarSpecialFolderMyDocuments() As String
        Return Environment.GetFolderPath(Environment.SpecialFolder.MyDocuments)
    End Function
    Public Function getEnvVarSpecialFolderLocalApplicationData() As String
        Return Environment.GetFolderPath(Environment.SpecialFolder.LocalApplicationData)
    End Function
    Public Function getEnvVarSpecialFolderCommonApplicationData() As String
        Return Environment.GetFolderPath(Environment.SpecialFolder.CommonApplicationData)
    End Function
    Public Function getEnvVarSpecialFolderApplicationData() As String
        Return Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData)
    End Function
    Public Function getEnvVarVersion() As String
        Return Environment.Version.ToString
    End Function
    'Public Function getEnvVarUserDomainName() As String
    '    Return Environment.UserDomainName.ToString
    'End Function
    Public Function getEnvVarProcessorCount() As String
        Return Environment.ProcessorCount.ToString
    End Function
    Public Function getEnvVarOperatingSystem() As String
        Return Environment.OSVersion.ToString()
    End Function
    Public Function getEnvVarMachineName() As String
        Return Environment.MachineName
    End Function

    Public Function getEnvVarUserID() As String
        Return Environment.UserName
    End Function

    Public Sub WriteToArchiveFileTraceLog(ByVal Msg As String, ByVal Zeroize As Boolean)
        Try
            'Dim cPath As String = GetCurrDir()        
            Dim cPath As String = getTempEnvironDir()
            'Dim tFQN$ = cPath + "\ECMLibrary.Trace.EMCQry.Log.txt"
            Dim TempFolder$ = getEnvVarSpecialFolderApplicationData()
            Dim M$ = Now.Month.ToString.Trim
            Dim D$ = Now.Day.ToString.Trim
            Dim Y$ = Now.Year.ToString.Trim

            Dim SerialNo$ = M + "." + D + "." + Y + "."

            Dim tFQN$ = TempFolder$ + "\ECMLibrary.Archive.FileTrace.Log." + SerialNo$ + "txt"
            If Zeroize Then
                If File.Exists(tFQN) Then
                    File.Delete(tFQN)
                    Return
                End If
            End If
            ' Create an instance of StreamWriter to write text to a file.
            Using sw As StreamWriter = New StreamWriter(tFQN, True)
                ' Add some text to the file.                                    
                sw.WriteLine(Now.ToString + ": " + Msg + vbCrLf)
                sw.Close()
            End Using
        Catch ex As Exception
            If gDebug Then Console.WriteLine("clsDma : WriteToSqlLog : 688 : " + ex.Message)
        End Try
    End Sub
    Public Sub WriteToSaveSql(ByVal Msg As String)
        Try
            'Dim cPath As String = GetCurrDir()        
            Dim cPath As String = getTempEnvironDir()
            'Dim tFQN$ = cPath + "\ECMLibrary.Trace.EMCQry.Log.txt"
            Dim TempFolder$ = getEnvVarSpecialFolderApplicationData()

            Dim tFQN$ = TempFolder$ + "\$SQL.Generator.txt"
            ' Create an instance of StreamWriter to write text to a file.
            Using sw As StreamWriter = New StreamWriter(tFQN, True)
                ' Add some text to the file.                                    
                sw.WriteLine(Now.ToString + "___________________________________________________________________________________" + vbCrLf)
                sw.WriteLine(Now.ToString + ": " + Msg + vbCrLf)
                sw.Close()
            End Using
        Catch ex As Exception
            If gDebug Then Console.WriteLine("clsDma : WriteToSqlLog : 688 : " + ex.Message)
        End Try
    End Sub

    Function getTempEnvironDir() As String
        Dim path As String = getEnvVarSpecialFolderApplicationData()
        Return path
    End Function
    Public Sub WriteToSqlApplyLog(ByVal tFqn As String, ByVal Msg As String)
        Try
            'Dim cPath As String = getTempEnvironDir()
            'Dim TempFolder$ = getEnvVarSpecialFolderApplicationData()
            'Dim tFQN$ = TempFolder$ + "\ECMLibrary.SQL.Application.Log.txt"
            Using sw As StreamWriter = New StreamWriter(tFqn, True)
                sw.WriteLine(Now.ToString + ": " + Msg + vbCrLf)
                sw.Close()
            End Using
        Catch ex As Exception
            If gDebug Then Console.WriteLine("clsDma : WriteToSqlLog : 688 : " + ex.Message)
        End Try
    End Sub
    Public Sub WriteToTempSqlApplyFile(ByVal Msg As String)
        Try
            Dim cPath As String = getTempEnvironDir()
            Dim TempFolder$ = getEnvVarSpecialFolderApplicationData()
            Dim tFQN$ = TempFolder$ + "\ECMLibrary.SQL.Statements.txt"
            Using sw As StreamWriter = New StreamWriter(tFQN, True)
                sw.WriteLine(Now.ToString + ": " + Msg + vbCrLf)
                sw.Close()
            End Using
        Catch ex As Exception
            If gDebug Then Console.WriteLine("clsDma : WriteToSqlLog : 688 : " + ex.Message)
        End Try
    End Sub
    Public Sub WriteToNewFile(ByVal FileText As String, ByVal FQN As String)
        Try
            Dim cPath As String = getTempEnvironDir()
            Dim TempFolder$ = getEnvVarSpecialFolderApplicationData()
            Dim tFQN$ = FQN
            Using sw As StreamWriter = New StreamWriter(tFQN, False)
                sw.WriteLine(FileText + vbCrLf)
                sw.Close()
            End Using
        Catch ex As Exception
            If gDebug Then Console.WriteLine("clsDma : WriteToSqlLog : 688 : " + ex.Message)
        End Try
    End Sub

    Public Sub WriteToOcrLog(ByVal Msg As String)
        Dim LogName As String = "OCR"
        Dim Severity As String = "UKN"
        If InStr(Msg.ToUpper, "ERROR") > 0 Then
            Severity = "Error"
        ElseIf InStr(Msg.ToUpper, "NOTIF") > 0 Then
            Severity = "Notice"
        Else
            Severity = "-"
        End If

        WriteToLog(LogName, Msg, Severity)
    End Sub
    Public Sub WriteToSqlLog(ByVal Msg As String)
        Dim LogName As String = "SQL"
        Dim Severity As String = "UKN"
        If InStr(Msg.ToUpper, "ERROR") > 0 Then
            Severity = "Error"
        ElseIf InStr(Msg.ToUpper, "NOTIF") > 0 Then
            Severity = "Notice"
        Else
            Severity = "-"
        End If

        WriteToLog(LogName, Msg, Severity)
    End Sub
    Public Sub WriteToContentDuplicateLog(ByVal TypeRec As String, ByVal RecGuid As String, ByVal RecIdentifier As String)
        Try
            Dim cPath As String = getTempEnvironDir()
            Dim TempFolder$ = getEnvVarSpecialFolderApplicationData()
            Dim tFQN$ = TempFolder$ + "\ECMLibrary.Duplicate.Content.Analysis.Log." + "txt"
            ' Create an instance of StreamWriter to write text to a file.
            Using sw As StreamWriter = New StreamWriter(tFQN, True)
                ' Add some text to the file.                                    
                sw.WriteLine(Now.ToString + ": " + TypeRec + ChrW(254) + RecGuid + ChrW(254) + RecIdentifier + vbCrLf)
                sw.Close()
            End Using
            If gRunUnattended = True Then
                gUnattendedErrors += 1
            End If
        Catch ex As Exception
            If gDebug Then Console.WriteLine("clsDma : WriteToSqlLog : 688 : " + ex.Message)
        End Try
    End Sub

    Public Sub WriteToEmailDuplicateLog(ByVal TypeRec As String, ByVal RecGuid As String, ByVal RecIdentifier As String)
        Try
            Dim cPath As String = getTempEnvironDir()
            Dim TempFolder$ = getEnvVarSpecialFolderApplicationData()
            Dim tFQN$ = TempFolder$ + "\ECMLibrary.Duplicate.Email.Analysis.Log." + "txt"
            ' Create an instance of StreamWriter to write text to a file.
            Using sw As StreamWriter = New StreamWriter(tFQN, True)
                ' Add some text to the file.                                    
                sw.WriteLine(Now.ToString + ": " + TypeRec + ChrW(254) + RecGuid + ChrW(254) + RecIdentifier + vbCrLf)
                sw.Close()
            End Using
        Catch ex As Exception
            If gDebug Then Console.WriteLine("clsDma : WriteToSqlLog : 688 : " + ex.Message)
        End Try
    End Sub
    Public Sub LoadEmailDupLog(ByRef L As Dictionary(Of String, String))
        Dim cPath As String = getTempEnvironDir()
        Dim TempFolder$ = getEnvVarSpecialFolderApplicationData()
        Dim tFQN$ = TempFolder$ + "\ECMLibrary.Duplicate.Email.Analysis.Log." + "txt"
        Dim tGuid As String = ""
        Dim tHashKey As String = ""

        Dim srFileReader As System.IO.StreamReader
        Dim sInputLine As String
        Dim I As Integer = 0
        '10/1/2010 8:32:12 AM: EÃ¾00002995-49b2-4306-ac83-440e3fa37f16Ã¾5f08a162d39aa43aec2c09f31458d3da

        srFileReader = System.IO.File.OpenText(tFQN)
        sInputLine = srFileReader.ReadLine()
        'FrmMDIMain.SB4.Text = "Loading Hash Keys"
        'FrmMDIMain.Refresh()
        Do Until sInputLine Is Nothing
            I += 1
            sInputLine = sInputLine.Trim
            If sInputLine.Length = 0 Then
                GoTo GetNextLine
            End If
            Dim A() As String
            A = sInputLine.Split(ChrW(254))
            tGuid = A(1)
            tHashKey = A(2)
            Try
                If L.ContainsKey(tGuid) Then
                    'Console.WriteLine("Key Already Exists: " + tGuid)
                Else
                    L.Add(tGuid, tHashKey)
                End If
            Catch ex As Exception
                Console.WriteLine("Key Exists Error: " + ex.Message)
            End Try
GetNextLine:
            sInputLine = srFileReader.ReadLine()
        Loop

    End Sub

    Public Sub LoadContentDupLog(ByRef L As Dictionary(Of String, String))
        Dim cPath As String = getTempEnvironDir()
        Dim TempFolder$ = getEnvVarSpecialFolderApplicationData()
        Dim tFQN$ = TempFolder$ + "\ECMLibrary.Duplicate.Content.Analysis.Log." + "txt"
        Dim tGuid As String = ""
        Dim tHashKey As String = ""

        Dim srFileReader As System.IO.StreamReader
        Dim sInputLine As String
        Dim I As Integer = 0
        '10/1/2010 8:32:12 AM: EÃ¾00002995-49b2-4306-ac83-440e3fa37f16Ã¾5f08a162d39aa43aec2c09f31458d3da

        srFileReader = System.IO.File.OpenText(tFQN)
        sInputLine = srFileReader.ReadLine()

        Do Until sInputLine Is Nothing
            I += 1
            sInputLine = sInputLine.Trim
            If sInputLine.Length = 0 Then
                GoTo GetNextLine
            End If

            Dim A() As String
            A = sInputLine.Split(ChrW(254))
            tGuid = A(1)
            tHashKey = A(2)
            Try
                If L.ContainsKey(tGuid) Then
                    'Console.WriteLine("Key Already Exists: " + tGuid)
                Else
                    L.Add(tGuid, tHashKey)
                End If
            Catch ex As Exception
                Console.WriteLine("Key Exists Error: " + ex.Message)
            End Try
GetNextLine:
            sInputLine = srFileReader.ReadLine()
        Loop

    End Sub

    Public Sub WriteToNoticeLog(ByVal Msg As String)
        Dim LogName As String = "NOTICE"
        Dim Severity As String = "UKN"
        If InStr(Msg.ToUpper, "ERROR") > 0 Then
            Severity = "Error"
        ElseIf InStr(Msg.ToUpper, "NOTIF") > 0 Then
            Severity = "Notice"
        Else
            Severity = "-"
        End If

        WriteToLog(LogName, Msg, Severity)
    End Sub

    Public Sub WriteToPDFLog(ByVal Msg As String)
        Dim LogName As String = "PDF"
        Dim Severity As String = "UKN"
        If InStr(Msg.ToUpper, "ERROR") > 0 Then
            Severity = "Error"
        ElseIf InStr(Msg.ToUpper, "NOTIF") > 0 Then
            Severity = "Notice"
        Else
            Severity = "-"
        End If

        WriteToLog(LogName, Msg, Severity)
    End Sub

    Public Sub WriteToInstallLog(ByVal Msg As String)
        Dim LogName As String = "INSTALL"
        Dim Severity As String = "UKN"
        If InStr(Msg.ToUpper, "ERROR") > 0 Then
            Severity = "Error"
        ElseIf InStr(Msg.ToUpper, "NOTIF") > 0 Then
            Severity = "Notice"
        Else
            Severity = "-"
        End If

        WriteToLog(LogName, Msg, Severity)
    End Sub

    Public Sub WriteToListenLog(ByVal Msg As String)
        Dim LogName As String = "LISTENER"
        Dim Severity As String = "UKN"
        If InStr(Msg.ToUpper, "ERROR") > 0 Then
            Severity = "Error"
        ElseIf InStr(Msg.ToUpper, "NOTIF") > 0 Then
            Severity = "Notice"
        Else
            Severity = "-"
        End If

        WriteToLog(LogName, Msg, Severity)
    End Sub
    Public Sub WriteFilesLog(ByVal Msg As String)
        Dim LogName As String = "FILES"
        Dim Severity As String = "UKN"
        If InStr(Msg.ToUpper, "ERROR") > 0 Then
            Severity = "Error"
        ElseIf InStr(Msg.ToUpper, "NOTIF") > 0 Then
            Severity = "Notice"
        Else
            Severity = "-"
        End If

        WriteToLog(LogName, Msg, Severity)
    End Sub

    Public Sub WriteToAttachLog(ByVal Msg As String)
        Dim LogName As String = "ATTACH"
        Dim Severity As String = "UKN"
        If InStr(Msg.ToUpper, "ERROR") > 0 Then
            Severity = "Error"
        ElseIf InStr(Msg.ToUpper, "NOTIF") > 0 Then
            Severity = "Notice"
        Else
            Severity = "-"
        End If

        WriteToLog(LogName, Msg, Severity)
    End Sub
    Public Sub WriteToEbExecLog(ByVal Msg As String)
        Dim LogName As String = "DBEXEC"
        Dim Severity As String = "UKN"
        If InStr(Msg.ToUpper, "ERROR") > 0 Then
            Severity = "Error"
        ElseIf InStr(Msg.ToUpper, "NOTIF") > 0 Then
            Severity = "Notice"
        Else
            Severity = "-"
        End If

        WriteToLog(LogName, Msg, Severity)
    End Sub
    Public Sub WriteToErrorLog(ByVal Msg As String)
        Dim LogName As String = "SEVERE_ERR"
        Dim Severity As String = "UKN"
        If InStr(Msg.ToUpper, "ERROR") > 0 Then
            Severity = "Error"
        ElseIf InStr(Msg.ToUpper, "NOTIF") > 0 Then
            Severity = "Notice"
        Else
            Severity = "-"
        End If

        WriteToLog(LogName, Msg, Severity)
    End Sub
    Public Sub WriteToTraceLog(ByVal Msg As String)
        Dim LogName As String = "TRACE"
        Dim Severity As String = ""
        If InStr(Msg.ToUpper, "ERROR") > 0 Then
            Severity = "Error"
        ElseIf InStr(Msg.ToUpper, "NOTIF") > 0 Then
            Severity = "Notice"
        Else
            Severity = "-"
        End If

        WriteToLog(LogName, Msg, Severity)
    End Sub

    Public Sub WriteToCrawlerLog(ByVal Msg As String)
        Dim LogName As String = "CRAWLER"
        Dim Severity As String = "UKN"
        If InStr(Msg.ToUpper, "ERROR") > 0 Then
            Severity = "Error"
        ElseIf InStr(Msg.ToUpper, "NOTIF") > 0 Then
            Severity = "Notice"
        Else
            Severity = "-"
        End If

        WriteToLog(LogName, Msg, Severity)
    End Sub
    Public Sub WriteToArchiveLog(ByVal Msg As String)
        Dim LogName As String = "Archive"
        Dim Severity As String = "UKN"
        If InStr(Msg.ToUpper, "ERROR") > 0 Then
            Severity = "Error"
        ElseIf InStr(Msg.ToUpper, "NOTIF") > 0 Then
            Severity = "Notice"
        Else
            Severity = "-"
        End If

        WriteToLog(LogName, Msg, Severity)
    End Sub

    Public Sub WriteToAttachmentSearchyLog(ByVal Msg As String)
        Dim LogName As String = "ATTACH_SEARCH"
        Dim Severity As String = "UKN"
        If InStr(Msg.ToUpper, "ERROR") > 0 Then
            Severity = "Error"
        ElseIf InStr(Msg.ToUpper, "NOTIF") > 0 Then
            Severity = "Notice"
        Else
            Severity = "-"
        End If

        WriteToLog(LogName, Msg, Severity)
    End Sub

    Public Sub ZeroizeSaveSql()
        Try
            'Dim cPath As String = GetCurrDir()        
            Dim cPath As String = getTempEnvironDir()
            'Dim tFQN$ = cPath + "\ECMLibrary.Trace.EMCQry.Log.txt"
            Dim TempFolder$ = getEnvVarSpecialFolderApplicationData()

            Dim tFQN$ = TempFolder$ + "\$SQL.Generator.txt"
            If File.Exists(tFQN) Then
                File.Delete(tFQN)
            End If
            GC.Collect()
            GC.WaitForPendingFinalizers()
        Catch ex As Exception
            If gDebug Then Console.WriteLine("clsDma : WriteToSqlLog : 688 : " + ex.Message)
        End Try
    End Sub

    'Sub CleanOutTempDirectoryImmediate()

    '    Try
    '        Dim TempFolder$ = getEnvVarSpecialFolderApplicationData()
    '        Dim storefile as clsDirectory
    '        Dim directory As String
    '        Dim files As String()
    '        Dim FQN As String

    '        files = storefile.GetFiles(TempFolder$, "ECM*.*")
    '        Dim T As TimeSpan

    '        For Each FQN In files
    '            Try
    '                Kill(FQN)
    '            Catch ex As Exception
    '                MsgBox("Delete Notice: " + FQN + vbCrLf + ex.Message)
    '            End Try
    '        Next

    '    Catch ex As Exception
    '        Me.WriteToSqlLog("NOTICE CleanOutTempDirectory: " + ex.Message)
    '    End Try

    'End Sub

    'Sub CleanOutTempDirectory()

    '    Try
    '        Dim TempFolder$ = getEnvVarSpecialFolderApplicationData()
    '        Dim storefile as clsDirectory
    '        Dim directory As String
    '        Dim files As String()
    '        Dim FQN As String

    '        files = storefile.GetFiles(TempFolder$, "ECM*.*")
    '        Dim T As TimeSpan

    '        For Each FQN In files
    '            Dim FileDate As Date = GetFileCreateDate(FQN)

    '            'Dim objFileInfo As New FileInfo(FQN)
    '            'Dim dtCreationDate As DateTime = objFileInfo.CreationTime

    '            Dim tsTimeSpan As TimeSpan
    '            Dim iNumberOfDays As Integer
    '            Dim strMsgText As String

    '            tsTimeSpan = Now.Subtract(FileDate)

    '            iNumberOfDays = tsTimeSpan.Days
    '            If iNumberOfDays > gDaysToKeepTraceLogs Then
    '                Kill(FQN)
    '            End If
    '        Next

    '    Catch ex As Exception
    '        Me.WriteToSqlLog("NOTICE CleanOutTempDirectory: " + ex.Message)
    '    End Try

    'End Sub

    'Sub CleanOutErrorDirectoryImmediate()

    '    Try
    '        Dim UTIL As New clsUtility

    '        Dim TempFolder$ = UTIL.getTempPdfWorkingErrorDir

    '        UTIL = Nothing

    '        Dim storefile as clsDirectory
    '        Dim directory As String
    '        Dim files As String()
    '        Dim FQN As String

    '        files = storefile.GetFiles(TempFolder$, "*.*")
    '        Dim T As TimeSpan

    '        For Each FQN In files
    '            Try
    '                Kill(FQN)
    '            Catch ex As Exception
    '                MsgBox("Delete Notice: " + FQN + vbCrLf + ex.Message)
    '            End Try
    '        Next

    '    Catch ex As Exception
    '        Me.WriteToSqlLog("NOTICE CleanOutTempDirectory: " + ex.Message)
    '    End Try

    'End Sub

    'Sub CleanOutErrorDirectory()

    '    Try
    '        Dim UTIL As New clsUtility

    '        Dim TempFolder$ = UTIL.getTempPdfWorkingErrorDir

    '        UTIL = Nothing

    '        Dim storefile as clsDirectory
    '        Dim directory As String
    '        Dim files As String()
    '        Dim FQN As String

    '        files = storefile.GetFiles(TempFolder$, "*.*")
    '        Dim T As TimeSpan

    '        For Each FQN In files
    '            Dim FileDate As Date = GetFileCreateDate(FQN)

    '            'Dim objFileInfo As New FileInfo(FQN)
    '            'Dim dtCreationDate As DateTime = objFileInfo.CreationTime

    '            Dim tsTimeSpan As TimeSpan
    '            Dim iNumberOfDays As Integer
    '            Dim strMsgText As String

    '            tsTimeSpan = Now.Subtract(FileDate)

    '            iNumberOfDays = tsTimeSpan.Days
    '            If iNumberOfDays > gDaysToKeepTraceLogs Then
    '                Kill(FQN)
    '            End If
    '        Next

    '    Catch ex As Exception
    '        Me.WriteToSqlLog("NOTICE CleanOutTempDirectory: " + ex.Message)
    '    End Try

    'End Sub

    Public Function GetFileSize(ByVal MyFilePath As String) As Integer
        Dim MyFile As New FileInfo(MyFilePath)
        Dim FileSize As Integer = MyFile.Length
        MyFile = Nothing
        Return FileSize
    End Function
    Public Function GetFileCreateDate(ByVal MyFilePath As String) As Date
        Dim MyFile As New FileInfo(MyFilePath)
        Dim FileDate As Date = MyFile.CreationTime
        MyFile = Nothing
        Return FileDate
    End Function
    Public Sub WriteToTempFile(ByVal FQN As String, ByVal Msg As String)
        Try
            Using sw As StreamWriter = New StreamWriter(FQN, True)
                sw.WriteLine(Msg + vbCrLf)
                sw.Close()
            End Using
        Catch ex As Exception
            If gDebug Then Console.WriteLine("clsDma : WriteToTempFile : 688 : " + ex.Message)
        End Try
    End Sub

    'Sub PurgeDirectory(ByVal DirectoryName As String, ByVal Pattern As String)

    '    Try
    '        Dim TempFolder$ = getEnvVarSpecialFolderApplicationData()
    '        Dim storefile as clsDirectory = Nothing
    '        'Dim directory As String = ""
    '        Dim files As String()
    '        Dim FQN As String

    '        files = storefile.GetFiles(DirectoryName, Pattern)
    '        Dim T As TimeSpan

    '        For Each FQN In files
    '            Dim FileDate As Date = GetFileCreateDate(FQN)
    '            Dim tsTimeSpan As TimeSpan
    '            Dim iNumberOfMin As Integer

    '            tsTimeSpan = Now.Subtract(FileDate)

    '            iNumberOfMin = tsTimeSpan.Minutes
    '            If iNumberOfMin > 1 Then
    '                Kill(FQN)
    '            End If
    '        Next

    '    Catch ex As Exception
    '        Me.WriteToSqlLog("NOTICE CleanOutTempDirectory: " + ex.Message)
    '    End Try

    'End Sub

    Public Sub WriteToProcessLog(ByVal Msg As String)
        Dim LogName As String = "PROCESS"
        Dim Severity As String = "UKN"
        If InStr(Msg.ToUpper, "ERROR") > 0 Then
            Severity = "Error"
        ElseIf InStr(Msg.ToUpper, "NOTIF") > 0 Then
            Severity = "Notice"
        Else
            Severity = "-"
        End If

        WriteToLog(LogName, Msg, Severity)
    End Sub


    Public Sub WriteToFileProcessLog(ByVal MSG As String)

        Dim LogName As String = "FILE_PROCESS"
        Dim Severity As String = "UKN"
        If InStr(MSG.ToUpper, "ERROR") > 0 Then
            Severity = "Error"
        ElseIf InStr(MSG.ToUpper, "NOTIF") > 0 Then
            Severity = "Notice"
        Else
            Severity = "-"
        End If

        WriteToLog(LogName, MSG, Severity)
    End Sub

    Sub WriteToLog(ByVal LogName As String, ByVal Msg As String, ByVal Severity As String)
        If Severity.Length = 0 Then
            Severity = "ERROR"
        End If
        Dim MsgCopy As String = Msg
        MsgCopy = MsgCopy.Replace("'", "`")
        MsgCopy = MsgCopy.Replace(ChrW(9), " ")
        'MsgCopy = MsgCopy.Replace(vbCrLf + vbCrLf, vbCrLf)
        Do While MsgCopy.Contains("  ")
            MsgCopy = MsgCopy.Replace(" ", "")
        Loop
        Dim S As String = ""
        S += " INSERT INTO [ErrorLogs]" + vbCrLf
        S += " ([LogName]" + vbCrLf
        S += " ,[LoggedMessage]" + vbCrLf
        S += " ,[EntryDate]" + vbCrLf
        S += " ,[EntryUserID]" + vbCrLf
        S += " ,[Severity])" + vbCrLf
        S += " VALUES( " + vbCrLf
        S += "'" + LogName + "'" + vbCrLf
        S += " ,'" + MsgCopy + "'" + vbCrLf
        S += " ,getdate()" + vbCrLf
        S += " ,'" + gCurrLoginID + "'" + vbCrLf
        S += " ,'" + Severity + "')" + vbCrLf
        ExecuteLogWriteSql(gSecureID, S)
    End Sub

    Sub ExecuteLogWriteSql(ByRef gSecureID As String, ByVal Mysql As String)

        'AddHandler ProxySearch.ExecuteSqlNewConnSecureCompleted, AddressOf client_ExecuteLogWriteSql
        'EP.setSearchSvcEndPoint(proxy)
        bExecSqlHAndler = True

        Mysql = ENC2.AES256EncryptString(Mysql)
        Dim BB As Boolean = ProxySearch.ExecuteSqlNewConnSecure(gSecureID, Mysql, _UserID, ContractID)
        gLogSQL(BB, ENC2.AES256EncryptString(Mysql))
    End Sub

    Private Sub setXXSearchSvcEndPoint()

        Dim CurrEndPoint As String = ProxySearch.Endpoint.Address.ToString
        If (SearchEndPoint.Length = 0) Then
            Return
        End If

        Dim ServiceUri As New Uri(SearchEndPoint)
        Dim EPA As New System.ServiceModel.EndpointAddress(ServiceUri)

        ProxySearch.Endpoint.Address = EPA
        GC.Collect()
        GC.WaitForPendingFinalizers()
    End Sub

End Class
