Imports System.IO
Imports System.Drawing
Imports System.Drawing.Imaging
Imports O2S.Components.PDF4NET
Imports O2S.Components.PDF4NET.PDFFile
Imports System.Security.Principal

Public Class clsLogging

    Dim LoggingPath As String = System.Configuration.ConfigurationManager.AppSettings("LoggingPath")
    Dim ddebug As Boolean = False
    'Dim DMA As New clsDma

    Public Function getEnvApplicationExecutablePath() As String
        Return Application.ExecutablePath
    End Function
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
    Public Function getEnvVarUserDomainName() As String
        Return Environment.UserDomainName.ToString
    End Function
    Public Function getEnvVarProcessorCount() As String
        Return Environment.ProcessorCount.ToString
    End Function
    Public Function getEnvVarOperatingSystem() As String
        Return Environment.OSVersion.ToString()
    End Function
    Public Function getEnvVarMachineName() As String
        Return Environment.MachineName
    End Function
    Public Function getEnvVarNetworkID() As String
        Return System.Security.Principal.WindowsIdentity.GetCurrent.Name
        'Return Environment.UserDomainName
    End Function
    Public Function getEnvVarUserID() As String
        Return Environment.UserName
    End Function

    Public Sub WriteToArchiveFileTraceLog(ByVal Msg As String, ByVal Zeroize As Boolean)
        Try
            'Dim cPath As String = GetCurrDir()        
            Dim cPath As String = getTempEnvironDir()
            'Dim tFQN  = cPath + "\ECMLibrary.Trace.EMCQry.Log.txt"
            If Directory.Exists(LoggingPath) Then
                cPath = LoggingPath
            Else
                Try
                    cPath = LoggingPath
                    Directory.CreateDirectory(cPath)
                Catch ex As Exception
                    cPath = getTempEnvironDir()
                End Try
            End If
            Dim M As String = Now.Month.ToString.Trim
            Dim D As String = Now.Day.ToString.Trim
            Dim Y As String = Now.Year.ToString.Trim

            Dim SerialNo As String = M + "." + D + "." + Y + "."

            Dim tFQN As String = cPath + "\ECMLibrary.Archive.FileTrace.Log." + SerialNo + "txt"
            If Zeroize Then
                Dim F As File
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
            If ddebug Then Console.WriteLine("clsDma : WriteToArchiveLog : 688 : " + ex.Message)
        End Try
    End Sub
    Public Sub WriteToSaveSql(ByVal Msg As String)
        Try
            'Dim cPath As String = GetCurrDir()        
            Dim cPath As String = getTempEnvironDir()
            'Dim tFQN  = cPath + "\ECMLibrary.Trace.EMCQry.Log.txt"
            If Directory.Exists(LoggingPath) Then
                cPath = LoggingPath
            Else
                Try
                    cPath = LoggingPath
                    Directory.CreateDirectory(cPath)
                Catch ex As Exception
                    cPath = getTempEnvironDir()
                End Try
            End If

            Dim tFQN As String = cPath + "\SQL.Archive.Generator.txt"
            ' Create an instance of StreamWriter to write text to a file.
            Using sw As StreamWriter = New StreamWriter(tFQN, True)
                ' Add some text to the file.                                    
                sw.WriteLine(Now.ToString + "___________________________________________________________________________________" + vbCrLf)
                sw.WriteLine(Now.ToString + ": " + Msg + vbCrLf)
                sw.Close()
            End Using
        Catch ex As Exception
            If ddebug Then Console.WriteLine("clsDma : WriteToArchiveLog : 688 : " + ex.Message)
        End Try
    End Sub

    Function getTempEnvironDir() As String
        Return getEnvVarSpecialFolderApplicationData()
    End Function
    Public Sub WriteToSqlApplyLog(ByVal tFqn As String, ByVal Msg As String)
        Try
            'Dim cPath As String = getTempEnvironDir()
            'Dim cpath  = getEnvVarSpecialFolderApplicationData()
            'Dim tFQN  = cpath  + "\ECMLibrary.SQL.Application.Log.txt"
            Using sw As StreamWriter = New StreamWriter(tFqn, True)
                sw.WriteLine(Now.ToString + ": " + Msg + vbCrLf)
                sw.Close()
            End Using
        Catch ex As Exception
            If ddebug Then Console.WriteLine("clsDma : WriteToArchiveLog : 688 : " + ex.Message)
        End Try
    End Sub
    Public Sub WriteToTempSqlApplyFile(ByVal Msg As String)
        Try
            Dim cPath As String = getTempEnvironDir()
            If Directory.Exists(LoggingPath) Then
                cPath = LoggingPath
            Else
                Try
                    cPath = LoggingPath
                    Directory.CreateDirectory(cPath)
                Catch ex As Exception
                    cPath = getTempEnvironDir()
                End Try
            End If
            Dim tFQN As String = cPath + "\ECMLibrary.Archive.SQL.Statements.txt"
            Using sw As StreamWriter = New StreamWriter(tFQN, True)
                sw.WriteLine(Now.ToString + ": " + Msg + vbCrLf)
                sw.Close()
            End Using
        Catch ex As Exception
            If ddebug Then Console.WriteLine("clsDma : WriteToArchiveLog : 688 : " + ex.Message)
        End Try
    End Sub
    Public Sub WriteToNewFile(ByVal FileText As String, ByVal FQN As String)
        Try
            Dim cPath As String = getTempEnvironDir()
            If Directory.Exists(LoggingPath) Then
                cPath = LoggingPath
            Else
                Try
                    cPath = LoggingPath
                    Directory.CreateDirectory(cPath)
                Catch ex As Exception
                    cPath = getTempEnvironDir()
                End Try
            End If
            Dim tFQN As String = FQN
            Using sw As StreamWriter = New StreamWriter(tFQN, False)
                sw.WriteLine(FileText + vbCrLf)
                sw.Close()
            End Using
        Catch ex As Exception
            If ddebug Then Console.WriteLine("clsDma : WriteToArchiveLog : 688 : " + ex.Message)
        End Try
    End Sub
    Sub OpenEcmErrorLog()
        Try
            'Dim cPath As String = GetCurrDir()        
            Dim cPath As String = getTempEnvironDir()
            'Dim tFQN  = cPath + "\ECMLibrary.Trace.EMCQry.Log.txt"
            If Directory.Exists(LoggingPath) Then
                cPath = LoggingPath
            Else
                Try
                    cPath = LoggingPath
                    Directory.CreateDirectory(cPath)
                Catch ex As Exception
                    cPath = getTempEnvironDir()
                End Try
            End If
            Dim M As String = Now.Month.ToString.Trim
            Dim D As String = Now.Day.ToString.Trim
            Dim Y As String = Now.Year.ToString.Trim
            Dim SerialNo As String = M + "." + D + "." + Y + "."
            Dim tFQN As String = cPath + "\ECMLibrary.Archive.Trace.ECMQry.Log." + SerialNo + "txt"
            ' Create an instance of StreamWriter to write text to a file.
            System.Diagnostics.Process.Start("notepad.exe", tFQN)
        Catch ex As Exception
            If ddebug Then Console.WriteLine("clsDma : WriteToArchiveLog : 688 : " + ex.Message)
        End Try
    End Sub
    Public Sub WriteToOcrLog(ByVal Msg As String)
        Try
            'Dim cPath As String = GetCurrDir()        
            Dim cPath As String = getTempEnvironDir()
            'Dim tFQN  = cPath + "\ECMLibrary.Trace.EMCQry.Log.txt"

            If Directory.Exists(LoggingPath) Then
                cPath = LoggingPath
            Else
                Try
                    cPath = LoggingPath
                    Directory.CreateDirectory(cPath)
                Catch ex As Exception
                    cPath = getTempEnvironDir()
                End Try
            End If

            Dim M As String = Now.Month.ToString.Trim
            Dim D As String = Now.Day.ToString.Trim
            Dim Y As String = Now.Year.ToString.Trim

            Dim SerialNo As String = M + "." + D + "." + Y + "."

            Dim tFQN As String = cPath + "\ECMLibrary.Archive.OCR.Log." + SerialNo + "txt"
            ' Create an instance of StreamWriter to write text to a file.
            Using sw As StreamWriter = New StreamWriter(tFQN, True)
                ' Add some text to the file.                                    
                sw.WriteLine(Now.ToString + ": " + Msg + vbCrLf)
                sw.Close()
            End Using
            If gRunUnattended = True Then
                gUnattendedErrors += 1
                'FrmMDIMain.SB4.Text = " " + gUnattendedErrors.ToString
                'FrmMDIMain.SB4.BackColor = Color.Silver
            End If
        Catch ex As Exception
            If ddebug Then Console.WriteLine("clsDma : WriteToArchiveLog : 688 : " + ex.Message)
        End Try
    End Sub
    Public Sub WriteToSqlLog(ByVal Msg As String)
        Try
            'Dim cPath As String = GetCurrDir()        
            Dim cPath As String = getTempEnvironDir()
            'Dim tFQN  = cPath + "\ECMLibrary.Trace.EMCQry.Log.txt"

            If Directory.Exists(LoggingPath) Then
                cPath = LoggingPath
            Else
                Try
                    cPath = LoggingPath
                    Directory.CreateDirectory(cPath)
                Catch ex As Exception
                    cPath = getTempEnvironDir()
                End Try
            End If
            Dim M As String = Now.Month.ToString.Trim
            Dim D As String = Now.Day.ToString.Trim
            Dim Y As String = Now.Year.ToString.Trim

            Dim SerialNo As String = M + "." + D + "." + Y + "."

            Dim tFQN As String = cPath + "\ECMLibrary.CLC.Archive.Event.Log." + SerialNo + "txt"
            ' Create an instance of StreamWriter to write text to a file.
            Using sw As StreamWriter = New StreamWriter(tFQN, True)
                ' Add some text to the file.                                    
                sw.WriteLine(Now.ToString + ": " + Msg + vbCrLf)
                sw.Close()
            End Using
            If gRunUnattended = True Then
                gUnattendedErrors += 1
                'FrmMDIMain.SB4.Text = " " + gUnattendedErrors.ToString
                'FrmMDIMain.SB4.BackColor = Color.Silver
            End If
        Catch ex As Exception
            If ddebug Then Console.WriteLine("clsDma : WriteToArchiveLog : 688 : " + ex.Message)
        End Try
    End Sub

    Public Sub WriteToContentDuplicateLog(ByVal TypeRec As String, ByVal RecGuid As String, ByVal RecIdentifier As String)
        Try
            Dim cPath As String = getTempEnvironDir()
            If Directory.Exists(LoggingPath) Then
                cPath = LoggingPath
            Else
                Try
                    cPath = LoggingPath
                    Directory.CreateDirectory(cPath)
                Catch ex As Exception
                    cPath = getTempEnvironDir()
                End Try
            End If
            Dim tFQN As String = cPath + "\ECMLibrary.Archive.Duplicate.Content.Analysis.Log." + "txt"
            ' Create an instance of StreamWriter to write text to a file.
            Using sw As StreamWriter = New StreamWriter(tFQN, True)
                ' Add some text to the file.                                    
                sw.WriteLine(Now.ToString + ": " + TypeRec + Chr(254) + RecGuid + Chr(254) + RecIdentifier + vbCrLf)
                sw.Close()
            End Using
            If gRunUnattended = True Then
                gUnattendedErrors += 1
                'FrmMDIMain.SB4.Text = " " + gUnattendedErrors.ToString
                'FrmMDIMain.SB4.BackColor = Color.Silver
            End If
        Catch ex As Exception
            If ddebug Then Console.WriteLine("clsDma : WriteToArchiveLog : 688 : " + ex.Message)
        End Try
    End Sub

    Public Sub WriteToEmailDuplicateLog(ByVal TypeRec As String, ByVal RecGuid As String, ByVal RecIdentifier As String)
        Try
            Dim cPath As String = getTempEnvironDir()
            If Directory.Exists(LoggingPath) Then
                cPath = LoggingPath
            Else
                Try
                    cPath = LoggingPath
                    Directory.CreateDirectory(cPath)
                Catch ex As Exception
                    cPath = getTempEnvironDir()
                End Try
            End If
            Dim tFQN As String = cPath + "\ECMLibrary.Archive.Duplicate.Email.Analysis.Log." + "txt"
            ' Create an instance of StreamWriter to write text to a file.
            Using sw As StreamWriter = New StreamWriter(tFQN, True)
                ' Add some text to the file.                                    
                sw.WriteLine(Now.ToString + ": " + TypeRec + Chr(254) + RecGuid + Chr(254) + RecIdentifier + vbCrLf)
                sw.Close()
            End Using
            If gRunUnattended = True Then
                gUnattendedErrors += 1
                'FrmMDIMain.SB4.Text = " " + gUnattendedErrors.ToString
                'FrmMDIMain.SB4.BackColor = Color.Silver
            End If
        Catch ex As Exception
            If ddebug Then Console.WriteLine("clsDma : WriteToArchiveLog : 688 : " + ex.Message)
        End Try
    End Sub
    Public Sub LoadEmailDupLog(ByRef L As SortedList(Of String, String))
        Dim cPath As String = getTempEnvironDir()
        If Directory.Exists(LoggingPath) Then
            cPath = LoggingPath
        Else
            Try
                cPath = LoggingPath
                Directory.CreateDirectory(cPath)
            Catch ex As Exception
                cPath = getTempEnvironDir()
            End Try
        End If

        Dim tFQN As String = cPath + "\ECMLibrary.Archive.Duplicate.Email.Analysis.Log." + "txt"
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
        Application.DoEvents()
        Do Until sInputLine Is Nothing
            I += 1
            sInputLine = sInputLine.Trim
            If sInputLine.Length = 0 Then
                GoTo GetNextLine
            End If
            If I Mod 50 = 0 Then
                'FrmMDIMain.SB4.Text = "## " + I.ToString
                'FrmMDIMain.Refresh()
                Application.DoEvents()
            End If
            Dim A() As String
            A = sInputLine.Split(Chr(254))
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
        'FrmMDIMain.SB4.Text = " - "
        Application.DoEvents()
    End Sub

    Public Sub LoadContentDupLog(ByRef L As SortedList(Of String, String))
        Dim cPath As String = getTempEnvironDir()
        If Directory.Exists(LoggingPath) Then
            cPath = LoggingPath
        Else
            Try
                cPath = LoggingPath
                Directory.CreateDirectory(cPath)
            Catch ex As Exception
                cPath = getTempEnvironDir()
            End Try
        End If

        Dim tFQN As String = cPath + "\ECMLibrary.Archive.Duplicate.Content.Analysis.Log." + "txt"
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
        Application.DoEvents()
        Do Until sInputLine Is Nothing
            I += 1
            sInputLine = sInputLine.Trim
            If sInputLine.Length = 0 Then
                GoTo GetNextLine
            End If
            If I Mod 50 = 0 Then
                'FrmMDIMain.SB4.Text = "## " + I.ToString
                'FrmMDIMain.Refresh()
                Application.DoEvents()
            End If
            Dim A() As String
            A = sInputLine.Split(Chr(254))
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
        'FrmMDIMain.SB4.Text = " - "
        Application.DoEvents()
    End Sub

    Public Sub WriteToNoticeLog(ByVal Msg As String)
        Try
            'Dim cPath As String = GetCurrDir()        
            Dim cPath As String = getTempEnvironDir()
            'Dim tFQN  = cPath + "\ECMLibrary.Trace.EMCQry.Log.txt"

            If Directory.Exists(LoggingPath) Then
                cPath = LoggingPath
            Else
                Try
                    cPath = LoggingPath
                    Directory.CreateDirectory(cPath)
                Catch ex As Exception
                    cPath = getTempEnvironDir()
                End Try
            End If

            Dim M As String = Now.Month.ToString.Trim
            Dim D As String = Now.Day.ToString.Trim
            Dim Y As String = Now.Year.ToString.Trim

            Dim SerialNo As String = M + "." + D + "." + Y + "."

            Dim tFQN As String = cPath + "\ECMLibrary.Archive.Notice.Log." + SerialNo + "txt"
            ' Create an instance of StreamWriter to write text to a file.
            Using sw As StreamWriter = New StreamWriter(tFQN, True)
                ' Add some text to the file.                                    
                sw.WriteLine(Now.ToString + ": " + Msg + vbCrLf)
                sw.Close()
            End Using
            If gRunUnattended = True Then
                gUnattendedErrors += 1
                'FrmMDIMain.SB4.Text = " " + gUnattendedErrors.ToString
                'FrmMDIMain.SB4.BackColor = Color.Silver
            End If
        Catch ex As Exception
            If ddebug Then Console.WriteLine("clsDma : WriteToArchiveLog : 688 : " + ex.Message)
        End Try
    End Sub

    Public Sub WriteToPDFLog(ByVal Msg As String)
        Try
            'Dim cPath As String = GetCurrDir()        
            Dim cPath As String = getTempEnvironDir()
            'Dim tFQN  = cPath + "\ECMLibrary.Trace.EMCQry.Log.txt"

            If Directory.Exists(LoggingPath) Then
                cPath = LoggingPath
            Else
                Try
                    cPath = LoggingPath
                    Directory.CreateDirectory(cPath)
                Catch ex As Exception
                    cPath = getTempEnvironDir()
                End Try
            End If

            Dim M As String = Now.Month.ToString.Trim
            Dim D As String = Now.Day.ToString.Trim
            Dim Y As String = Now.Year.ToString.Trim

            Dim SerialNo As String = M + "." + D + "." + Y + "."

            Dim tFQN As String = cPath + "\ECMLibrary.Archive.PDF.Log." + SerialNo + "txt"
            ' Create an instance of StreamWriter to write text to a file.
            Using sw As StreamWriter = New StreamWriter(tFQN, True)
                ' Add some text to the file.                                    
                sw.WriteLine(Now.ToString + ": " + Msg + vbCrLf)
                sw.Close()
            End Using
            If gRunUnattended = True Then
                gUnattendedErrors += 1
                'FrmMDIMain.SB4.Text = " " + gUnattendedErrors.ToString
                'FrmMDIMain.SB4.BackColor = Color.Silver
            End If
        Catch ex As Exception
            If ddebug Then Console.WriteLine("clsDma : WriteToArchiveLog : 688 : " + ex.Message)
        End Try
    End Sub

    Public Sub WriteToParmLog(ByVal Msg As String)
        Try
            Dim cPath As String = getTempEnvironDir()
            If Directory.Exists(LoggingPath) Then
                cPath = LoggingPath
            Else
                Try
                    cPath = LoggingPath
                    Directory.CreateDirectory(cPath)
                Catch ex As Exception
                    cPath = getTempEnvironDir()
                End Try
            End If
            Dim M As String = Now.Month.ToString.Trim
            Dim D As String = Now.Day.ToString.Trim
            Dim Y As String = Now.Year.ToString.Trim

            Dim SerialNo As String = M + "." + D + "." + Y + "."

            Dim tFQN As String = cPath + "\ECMLibrary.Archive.Installation.Parm.Log." + SerialNo + "txt"
            ' Create an instance of StreamWriter to write text to a file.
            Using sw As StreamWriter = New StreamWriter(tFQN, True)
                ' Add some text to the file.                                    
                sw.WriteLine(Now.ToString + ": " + Msg + vbCrLf)
                sw.Close()
            End Using
        Catch ex As Exception
            If ddebug Then Console.WriteLine("clsDma : WriteToArchiveLog : 688 : " + ex.Message)
        End Try

    End Sub
    Public Sub WriteToInstallLog(ByVal Msg As String)
        Try
            'Dim cPath As String = GetCurrDir()        
            Dim cPath As String = getTempEnvironDir()
            If Directory.Exists(LoggingPath) Then
                cPath = LoggingPath
            Else
                Try
                    cPath = LoggingPath
                    Directory.CreateDirectory(cPath)
                Catch ex As Exception
                    cPath = getTempEnvironDir()
                End Try
            End If

            Dim M As String = Now.Month.ToString.Trim
            Dim D As String = Now.Day.ToString.Trim
            Dim Y As String = Now.Year.ToString.Trim

            Dim SerialNo As String = M + "." + D + "." + Y + "."

            Dim tFQN As String = cPath + "\ECMLibrary.Archive.Client.Installation.Log." + SerialNo + "txt"
            ' Create an instance of StreamWriter to write text to a file.
            Using sw As StreamWriter = New StreamWriter(tFQN, True)
                ' Add some text to the file.                                    
                sw.WriteLine(Now.ToString + ": " + Msg + vbCrLf)
                sw.Close()
            End Using
        Catch ex As Exception
            If ddebug Then Console.WriteLine("clsDma : WriteToArchiveLog : 688 : " + ex.Message)
        End Try
    End Sub

    Public Sub WriteToListenLog(ByVal Msg As String)
        Try
            'Dim cPath As String = GetCurrDir()        
            Dim cPath As String = getTempEnvironDir()
            If Directory.Exists(LoggingPath) Then
                cPath = LoggingPath
            Else
                Try
                    cPath = LoggingPath
                    Directory.CreateDirectory(cPath)
                Catch ex As Exception
                    cPath = getTempEnvironDir()
                End Try
            End If

            Dim M As String = Now.Month.ToString.Trim
            Dim D As String = Now.Day.ToString.Trim
            Dim Y As String = Now.Year.ToString.Trim

            Dim SerialNo As String = M + "." + D + "." + Y + "."

            Dim tFQN As String = cPath + "\ECMLibrary.Archive.Client.Listen.Log." + SerialNo + "txt"
            ' Create an instance of StreamWriter to write text to a file.
            Using sw As StreamWriter = New StreamWriter(tFQN, True)
                ' Add some text to the file.                                    
                sw.WriteLine(Now.ToString + ": " + Msg + vbCrLf)
                sw.Close()
            End Using
        Catch ex As Exception
            If ddebug Then Console.WriteLine("clsDma : WriteToArchiveLog : 688 : " + ex.Message)
        End Try
    End Sub

    Public Sub WriteListenerLog(ByVal Msg As String)
        Try
            Dim cPath As String = getTempEnvironDir()
            If Directory.Exists(LoggingPath) Then
                cPath = LoggingPath
            Else
                Try
                    cPath = LoggingPath
                    Directory.CreateDirectory(cPath)
                Catch ex As Exception
                    cPath = getTempEnvironDir()
                End Try
            End If
            Dim tFQN As String = cPath + "\ListenerFilesLog.ECM"
            Using sw As StreamWriter = New StreamWriter(tFQN, True)
                sw.WriteLine(Now.ToString + ": " + Msg + vbCrLf)
                sw.Close()
            End Using
        Catch ex As Exception
            If ddebug Then Console.WriteLine("clsDma : WriteListenerLog : 688 : " + ex.Message)
        End Try
    End Sub

    Public Sub WriteToAttachLog(ByVal Msg As String)
        Try
            Dim cPath As String = getTempEnvironDir()
            If Directory.Exists(LoggingPath) Then
                cPath = LoggingPath
            Else
                Try
                    cPath = LoggingPath
                    Directory.CreateDirectory(cPath)
                Catch ex As Exception
                    cPath = getTempEnvironDir()
                End Try
            End If

            Dim M As String = Now.Month.ToString.Trim
            Dim D As String = Now.Day.ToString.Trim
            Dim Y As String = Now.Year.ToString.Trim

            Dim SerialNo As String = M + "." + D + "." + Y + "."

            Dim tFQN As String = cPath + "\ECMLibrary.Archive.Client.Attach.Log." + SerialNo + "txt"
            ' Create an instance of StreamWriter to write text to a file.
            Using sw As StreamWriter = New StreamWriter(tFQN, True)
                ' Add some text to the file.                                    
                sw.WriteLine(Now.ToString + ": " + Msg + vbCrLf)
                sw.Close()
            End Using
        Catch ex As Exception
            If ddebug Then Console.WriteLine("clsDma : WriteToAttachLog : 688 : " + ex.Message)
        End Try
    End Sub
    Public Sub WriteToEbExecLog(ByVal Msg As String)
        Try
            'Dim cPath As String = GetCurrDir()        
            Dim cPath As String = getTempEnvironDir()
            'Dim tFQN  = cPath + "\ECMLibrary.DBARCH.ExecQry.Log.txt"
            If Directory.Exists(LoggingPath) Then
                cPath = LoggingPath
            Else
                Try
                    cPath = LoggingPath
                    Directory.CreateDirectory(cPath)
                Catch ex As Exception
                    cPath = getTempEnvironDir()
                End Try
            End If

            If Directory.Exists(LoggingPath) Then
                cPath = LoggingPath
            Else
                Try
                    cPath = LoggingPath
                    Directory.CreateDirectory(cPath)
                Catch ex As Exception
                    cPath = getTempEnvironDir()
                End Try
            End If

            Dim M As String = Now.Month.ToString.Trim
            Dim D As String = Now.Day.ToString.Trim
            Dim Y As String = Now.Year.ToString.Trim

            Dim SerialNo As String = M + "." + D + "." + Y + "."

            Dim tFQN As String = cPath + "\ECMLibrary.Archive.DBARCH.ExecQry.Log." + SerialNo + "txt"
            ' Create an instance of StreamWriter to write text to a file.
            Using sw As StreamWriter = New StreamWriter(tFQN, True)
                ' Add some text to the file.                                    
                sw.WriteLine(Now.ToString + ": " + Msg + vbCrLf)
                sw.Close()
            End Using
        Catch ex As Exception
            If ddebug Then Console.WriteLine("clsDma : WriteToArchiveLog : 688 : " + ex.Message)
        End Try
    End Sub
    Public Sub WriteToErrorLog(ByVal Msg As String)
        Try
            'Dim cPath As String = GetCurrDir()        
            Dim cPath As String = getTempEnvironDir()
            'Dim tFQN  = cPath + "\ECMLibrary.Trace.EMCQry.Log.txt"

            If Directory.Exists(LoggingPath) Then
                cPath = LoggingPath
            Else
                Try
                    cPath = LoggingPath
                    Directory.CreateDirectory(cPath)
                Catch ex As Exception
                    cPath = getTempEnvironDir()
                End Try
            End If


            If Directory.Exists(LoggingPath) Then
                cPath = LoggingPath
            Else
                Try
                    cPath = LoggingPath
                    Directory.CreateDirectory(cPath)
                Catch ex As Exception
                    cPath = getTempEnvironDir()
                End Try
            End If

            Dim M As String = Now.Month.ToString.Trim
            Dim D As String = Now.Day.ToString.Trim
            Dim Y As String = Now.Year.ToString.Trim

            Dim SerialNo As String = M + "." + D + "." + Y + "."

            Dim tFQN As String = cPath + "\ECMLibrary.Archive.Error.Log." + SerialNo + "txt"
            ' Create an instance of StreamWriter to write text to a file.
            Using sw As StreamWriter = New StreamWriter(tFQN, True)
                ' Add some text to the file.                                    
                sw.WriteLine(Now.ToString + ": " + Msg + vbCrLf)
                sw.Close()
            End Using
        Catch ex As Exception
            If ddebug Then Console.WriteLine("clsDma : WriteToErrorLog : 688 : " + ex.Message)
        End Try
    End Sub
    Public Sub WriteToTraceLog(ByVal Msg As String)
        Try
            Dim cPath As String = getTempEnvironDir()

            If Directory.Exists(LoggingPath) Then
                cPath = LoggingPath
            Else
                Try
                    cPath = LoggingPath
                    Directory.CreateDirectory(cPath)
                Catch ex As Exception
                    cPath = getTempEnvironDir()
                End Try
            End If

            Dim M As String = Now.Month.ToString.Trim
            Dim D As String = Now.Day.ToString.Trim
            Dim Y As String = Now.Year.ToString.Trim

            Dim SerialNo As String = M + "." + D + "." + Y + "."

            Dim tFQN As String = cPath + "\ECMLibrary.Archive.Trace." + SerialNo + "txt"
            ' Create an instance of StreamWriter to write text to a file.
            Using sw As StreamWriter = New StreamWriter(tFQN, True)
                ' Add some text to the file.                                    
                sw.WriteLine(Now.ToString + ": " + Msg + vbCrLf)
                sw.Close()
            End Using
        Catch ex As Exception
            If ddebug Then Console.WriteLine("clsDma : WriteToArchiveLog : 688 : " + ex.Message)
        End Try
    End Sub

    Public Sub WriteToCrawlerLog(ByVal Msg As String)
        Try
            'Dim cPath As String = GetCurrDir()        
            Dim cPath As String = getTempEnvironDir()
            'Dim tFQN  = cPath + "\ECMLibrary.Trace.EMCQry.Log.txt"


            If Directory.Exists(LoggingPath) Then
                cPath = LoggingPath
            Else
                Try
                    cPath = LoggingPath
                    Directory.CreateDirectory(cPath)
                Catch ex As Exception
                    cPath = getTempEnvironDir()
                End Try
            End If

            Dim M As String = Now.Month.ToString.Trim
            Dim D As String = Now.Day.ToString.Trim
            Dim Y As String = Now.Year.ToString.Trim

            Dim SerialNo As String = M + "." + D + "." + Y + "."

            Dim tFQN As String = cPath + "\ECMLibrary.Archive.WebCrawl." + SerialNo + "txt"
            ' Create an instance of StreamWriter to write text to a file.
            Using sw As StreamWriter = New StreamWriter(tFQN, True)
                ' Add some text to the file.                                    
                sw.WriteLine(Now.ToString + ": " + Msg + vbCrLf)
                sw.Close()
            End Using
        Catch ex As Exception
            If ddebug Then Console.WriteLine("clsDma : WriteToArchiveLog : 688 : " + ex.Message)
        End Try
    End Sub
    Public Function getArchiveLogPath() As String
        Dim cpath As String = ""
        Try
            cpath = getEnvVarSpecialFolderApplicationData()
        Catch ex As Exception
            If ddebug Then Console.WriteLine("clsDma : WriteToArchiveLog : 688 : " + ex.Message)
        End Try
        Return cpath
    End Function

    Public Sub WriteToArchiveLog(ByVal Msg As String, ex1 As Exception)
        Try
            Dim errmsg As String = "eRRmSG: " & ex1.Message
            If errmsg.Contains("Access to the path") Then
                Dim wi As WindowsIdentity = System.Security.Principal.WindowsIdentity.GetCurrent()
                Dim userIdentity As String = wi.Name
                Dim AuthenticationType As String = wi.AuthenticationType
                errmsg = errmsg + vbCrLf + "userIdentity: " + userIdentity
                errmsg = errmsg + vbCrLf + "AuthenticationType: " + AuthenticationType
                errmsg = errmsg + vbCrLf + "IsAuthenticated: " + wi.IsAuthenticated.ToString
                wi.Dispose()
            End If

            WriteToArchiveLog(errmsg)

        Catch ex As Exception
            If ddebug Then Console.WriteLine("clsDma : WriteToArchiveLog : 688 : " + ex.Message)
            Dim st As New StackTrace(True)
            st = New StackTrace(ex, True)
        End Try
    End Sub

    Public Sub WriteToArchiveLog(ByVal Msg As String)

        Try
            Dim cPath As String = getTempEnvironDir()

            If Directory.Exists(LoggingPath) Then
                cPath = LoggingPath
            Else
                Try
                    cPath = LoggingPath
                    Directory.CreateDirectory(cPath)
                Catch ex As Exception
                    cPath = getTempEnvironDir()
                End Try
            End If

            Dim M As String = Now.Month.ToString.Trim
            Dim D As String = Now.Day.ToString.Trim
            Dim Y As String = Now.Year.ToString.Trim

            Dim SerialNo As String = M + "." + D + "." + Y + "."

            Dim tFQN As String = cPath + "\ECMLibrary.Archive.Log." + SerialNo + "txt"
            ' Create an instance of StreamWriter to write text to a file.
            Using sw As StreamWriter = New StreamWriter(tFQN, True)
                sw.WriteLine(Now.ToString + ": " + Msg + vbCrLf)
            End Using
        Catch ex As Exception
            If ddebug Then Console.WriteLine("clsDma : WriteToArchiveLog : 688 : " + ex.Message)
        End Try
    End Sub

    Public Sub WriteToDBUpdatesLog(ByVal Msg As String)

        Try
            Dim cPath As String = getTempEnvironDir()

            If Directory.Exists(LoggingPath) Then
                cPath = LoggingPath
            Else
                Try
                    cPath = LoggingPath
                    Directory.CreateDirectory(cPath)
                Catch ex As Exception
                    cPath = getTempEnvironDir()
                End Try
            End If

            Dim M As String = Now.Month.ToString.Trim
            Dim D As String = Now.Day.ToString.Trim
            Dim Y As String = Now.Year.ToString.Trim

            Dim SerialNo As String = M + "." + D + "." + Y + "."

            Dim tFQN As String = cPath + "\ECMLibrary.DBUpdates.Log." + SerialNo + "txt"
            ' Create an instance of StreamWriter to write text to a file.
            Using sw As StreamWriter = New StreamWriter(tFQN, True)
                sw.WriteLine("-- " + Now.ToString)
                sw.WriteLine(Msg + vbCrLf)
            End Using
        Catch ex As Exception
            If ddebug Then Console.WriteLine("clsDma : WriteToArchiveLog : 688 : " + ex.Message)
        End Try
    End Sub


    Public Sub WriteToDeleteLog(ByVal Msg As String)

        Try
            Dim cPath As String = getTempEnvironDir()

            If Directory.Exists(LoggingPath) Then
                cPath = LoggingPath
            Else
                Try
                    cPath = LoggingPath
                    Directory.CreateDirectory(cPath)
                Catch ex As Exception
                    cPath = getTempEnvironDir()
                End Try
            End If

            Dim M As String = Now.Month.ToString.Trim
            Dim D As String = Now.Day.ToString.Trim
            Dim Y As String = Now.Year.ToString.Trim

            Dim SerialNo As String = M + "." + D + "." + Y + "."

            Dim tFQN As String = cPath + "\ECMLibrary.Delete.Log." + SerialNo + "txt"
            Using sw As StreamWriter = New StreamWriter(tFQN, True)
                sw.WriteLine(Now.ToString + "|" + Msg)
            End Using
        Catch ex As Exception
            If ddebug Then Console.WriteLine("clsDma : WriteToArchiveLog : 688 : " + ex.Message)
        End Try
    End Sub

    Public Sub WriteToDirAnalysisLog(ByVal Msg As String, ZeroizeFile As Boolean)

        Try
            Dim cPath As String = getTempEnvironDir()

            If Directory.Exists(LoggingPath) Then
                cPath = LoggingPath
            Else
                Try
                    cPath = LoggingPath
                    Directory.CreateDirectory(cPath)
                Catch ex As Exception
                    cPath = getTempEnvironDir()
                End Try
            End If

            Dim M As String = Now.Month.ToString.Trim
            Dim D As String = Now.Day.ToString.Trim
            Dim Y As String = Now.Year.ToString.Trim

            Dim SerialNo As String = M + "." + D + "." + Y + "."

            Dim tFQN As String = cPath + "\ECMLibrary.DIrAnalysis.Log." + SerialNo + "txt"

            If ZeroizeFile.Equals(True) And File.Exists(tFQN) Then
                File.Delete(tFQN)
                Return
            End If

            ' Create an instance of StreamWriter to write text to a file.
            Using sw As StreamWriter = New StreamWriter(tFQN, True)
                sw.WriteLine(Now.ToString + ": " + Msg)
                'sw.Close()
            End Using
        Catch ex As Exception
            If ddebug Then Console.WriteLine("clsDma : WriteToArchiveLog : 688 : " + ex.Message)
        End Try
    End Sub

    Public Sub WriteToDirFileLog(ByVal Msg As String)

        Try
            Dim cPath As String = getTempEnvironDir()

            If Directory.Exists(LoggingPath) Then
                cPath = LoggingPath
            Else
                Try
                    cPath = LoggingPath
                    Directory.CreateDirectory(cPath)
                Catch ex As Exception
                    cPath = getTempEnvironDir()
                End Try
            End If

            Dim M As String = Now.Month.ToString.Trim
            Dim D As String = Now.Day.ToString.Trim
            Dim Y As String = Now.Year.ToString.Trim

            Dim SerialNo As String = M + "." + D + "." + Y + "."

            Dim tFQN As String = cPath + "\ECMLibrary.DirectoryFile.Error.Log." + SerialNo + "txt"
            ' Create an instance of StreamWriter to write text to a file.
            Using sw As StreamWriter = New StreamWriter(tFQN, True)
                ' Add some text to the file.                                    
                sw.WriteLine(Now.ToString + ": " + Msg + vbCrLf)
                sw.Close()
            End Using
        Catch ex As Exception
            If ddebug Then Console.WriteLine("clsDma : WriteToArchiveLog : 688 : " + ex.Message)
        End Try
    End Sub

    Public Sub WriteToInventoryLog(xexists As Boolean, ByVal FQN As String)

        Try
            Dim cPath As String = getTempEnvironDir()

            If Directory.Exists(LoggingPath) Then
                cPath = LoggingPath
            Else
                Try
                    cPath = LoggingPath
                    Directory.CreateDirectory(cPath)
                Catch ex As Exception
                    cPath = getTempEnvironDir()
                End Try
            End If

            Dim M As String = Now.Month.ToString.Trim
            Dim D As String = Now.Day.ToString.Trim
            Dim Y As String = Now.Year.ToString.Trim

            Dim SerialNo As String = M + "." + D + "." + Y + "."
            Dim Msg As String = ""

            Dim tFQN As String = cPath + "\ECMLibrary.Inventory.Log." + SerialNo + "txt"
            'If File.Exists(tFQN) Then
            '    File.Delete(tFQN)
            'End If
            ' Create an instance of StreamWriter to write text to a file.
            Using sw As StreamWriter = New StreamWriter(tFQN, True)
                ' Add some text to the file.                                    
                If xexists Then
                    Msg = "FOUND: " + FQN
                Else
                    Msg = "MISSING: " + FQN
                End If
                sw.WriteLine(Msg)
                'sw.Close()
            End Using
        Catch ex As Exception
            Console.WriteLine("clsDma : WriteToArchiveLog : 688 : " + ex.Message)
        End Try
    End Sub

    Public Sub WriteToUploadLog(ByVal Msg As String)

        Try
            Dim cPath As String = getTempEnvironDir()

            If Directory.Exists(LoggingPath) Then
                cPath = LoggingPath
            Else
                Try
                    cPath = LoggingPath
                    Directory.CreateDirectory(cPath)
                Catch ex As Exception
                    cPath = getTempEnvironDir()
                End Try
            End If

            Dim M As String = Now.Month.ToString.Trim
            Dim D As String = Now.Day.ToString.Trim
            Dim Y As String = Now.Year.ToString.Trim

            Dim SerialNo As String = M + "." + D + "." + Y + "."

            Dim tFQN As String = cPath + "\ECMLibrary.Upload.Log." + SerialNo + "txt"
            ' Create an instance of StreamWriter to write text to a file.
            Using sw As StreamWriter = New StreamWriter(tFQN, True)
                ' Add some text to the file.                                    
                sw.WriteLine(Now.ToString + ": " + Msg + vbCrLf)
                sw.Close()
            End Using
        Catch ex As Exception
            If ddebug Then Console.WriteLine("clsDma : WriteToArchiveLog : 688 : " + ex.Message)
        End Try
    End Sub


    Public Sub WriteToAttachmentSearchyLog(ByVal Msg As String)
        Try
            'Dim cPath As String = GetCurrDir()        
            Dim cPath As String = getTempEnvironDir()
            'Dim tFQN  = cPath + "\ECMLibrary.Trace.EMCQry.Log.txt"

            If Directory.Exists(LoggingPath) Then
                cPath = LoggingPath
            Else
                Try
                    cPath = LoggingPath
                    Directory.CreateDirectory(cPath)
                Catch ex As Exception
                    cPath = getTempEnvironDir()
                End Try
            End If

            Dim M As String = Now.Month.ToString.Trim
            Dim D As String = Now.Day.ToString.Trim
            Dim Y As String = Now.Year.ToString.Trim

            Dim SerialNo As String = M + "." + D + "." + Y + "."

            Dim tFQN As String = cPath + "\ECMLibrary.Archive.AttachSearch.Trace.Log." + SerialNo + "txt"
            ' Create an instance of StreamWriter to write text to a file.
            Using sw As StreamWriter = New StreamWriter(tFQN, True)
                ' Add some text to the file.                                    
                sw.WriteLine(Now.ToString + ": " + Msg + vbCrLf)
                sw.Close()
            End Using
        Catch ex As Exception
            If ddebug Then Console.WriteLine("clsDma : WriteToArchiveLog : 688 : " + ex.Message)
        End Try
    End Sub

    Public Sub ZeroizeSaveSql()
        Try
            'Dim cPath As String = GetCurrDir()        
            Dim cPath As String = getTempEnvironDir()
            'Dim tFQN  = cPath + "\ECMLibrary.Trace.EMCQry.Log.txt"

            If Directory.Exists(LoggingPath) Then
                cPath = LoggingPath
            Else
                Try
                    cPath = LoggingPath
                    Directory.CreateDirectory(cPath)
                Catch ex As Exception
                    cPath = getTempEnvironDir()
                End Try
            End If


            Dim tFQN As String = cPath + "\ SQL.Archive.Generator.txt"
            Dim F As File
            If F.Exists(tFQN) Then
                F.Delete(tFQN)
            End If
            F = Nothing
            GC.Collect()
            GC.WaitForPendingFinalizers()
        Catch ex As Exception
            If ddebug Then Console.WriteLine("clsDma : WriteToArchiveLog : 688 : " + ex.Message)
        End Try
    End Sub
    Sub CleanOutTempDirectoryImmediate()

        Try
            Dim cpath As String = getEnvVarSpecialFolderApplicationData()
            Dim storefile As Directory
            Dim directory As String
            Dim files As String()
            Dim FQN As String

            files = storefile.GetFiles(cpath, "ECM*.*")
            Dim T As TimeSpan

            For Each FQN In files
                Try
                    Kill(FQN)
                Catch ex As Exception
                    MessageBox.Show("Delete Notice: " + FQN + vbCrLf + ex.Message)
                End Try
            Next

        Catch ex As Exception
            Me.WriteToArchiveLog("NOTICE CleanOutTempDirectory: " + ex.Message)
        End Try

    End Sub
    Sub CleanOutTempDirectory()

        Try
            Dim cpath As String = getEnvVarSpecialFolderApplicationData()
            Dim storefile As Directory
            Dim directory As String
            Dim files As String()
            Dim FQN As String

            files = storefile.GetFiles(cpath, "ECM*.*")
            Dim T As TimeSpan

            For Each FQN In files
                Dim FileDate As Date = GetFileCreateDate(FQN)

                'Dim objFileInfo As New FileInfo(FQN)
                'Dim dtCreationDate As DateTime = objFileInfo.CreationTime

                Dim tsTimeSpan As TimeSpan
                Dim iNumberOfDays As Integer
                Dim strMsgText As String

                tsTimeSpan = Now.Subtract(FileDate)

                iNumberOfDays = tsTimeSpan.Days
                If iNumberOfDays > gDaysToKeepTraceLogs Then
                    Kill(FQN)
                End If
            Next

        Catch ex As Exception
            Me.WriteToArchiveLog("NOTICE CleanOutTempDirectory: " + ex.Message)
        End Try

    End Sub

    Sub CleanOutErrorDirectoryImmediate()

        Try
            Dim UTIL As New clsUtility

            Dim cpath As String = UTIL.getTempPdfWorkingErrorDir

            UTIL = Nothing

            Dim storefile As Directory
            Dim directory As String
            Dim files As String()
            Dim FQN As String

            files = storefile.GetFiles(cpath, "*.*")
            Dim T As TimeSpan

            For Each FQN In files
                Try
                    Kill(FQN)
                Catch ex As Exception
                    MessageBox.Show("Delete Notice: " + FQN + vbCrLf + ex.Message)
                End Try
            Next

        Catch ex As Exception
            Me.WriteToArchiveLog("NOTICE CleanOutTempDirectory: " + ex.Message)
        End Try

    End Sub

    Sub CleanOutErrorDirectory()

        Try
            Dim UTIL As New clsUtility

            Dim cpath As String = UTIL.getTempPdfWorkingErrorDir

            UTIL = Nothing

            Dim storefile As Directory
            Dim directory As String
            Dim files As String()
            Dim FQN As String

            files = storefile.GetFiles(cpath, "*.*")
            Dim T As TimeSpan

            For Each FQN In files
                Dim FileDate As Date = GetFileCreateDate(FQN)

                'Dim objFileInfo As New FileInfo(FQN)
                'Dim dtCreationDate As DateTime = objFileInfo.CreationTime

                Dim tsTimeSpan As TimeSpan
                Dim iNumberOfDays As Integer
                Dim strMsgText As String

                tsTimeSpan = Now.Subtract(FileDate)

                iNumberOfDays = tsTimeSpan.Days
                If iNumberOfDays > gDaysToKeepTraceLogs Then
                    Kill(FQN)
                End If
            Next

        Catch ex As Exception
            Me.WriteToArchiveLog("NOTICE CleanOutTempDirectory: " + ex.Message)
        End Try

    End Sub

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
            If ddebug Then Console.WriteLine("clsDma : WriteToTempFile : 688 : " + ex.Message)
        End Try
    End Sub
    Sub PurgeDirectory(ByVal DirectoryName As String, ByVal Pattern As String)

        Try
            Dim cpath As String = getEnvVarSpecialFolderApplicationData()
            Dim storefile As Directory = Nothing
            'Dim directory As String = ""
            Dim files As String()
            Dim FQN As String

            files = storefile.GetFiles(DirectoryName, Pattern)
            'Dim T As TimeSpan

            For Each FQN In files
                Dim FileDate As Date = GetFileCreateDate(FQN)
                Dim tsTimeSpan As TimeSpan
                Dim iNumberOfMin As Integer

                tsTimeSpan = Now.Subtract(FileDate)

                iNumberOfMin = tsTimeSpan.Minutes
                If iNumberOfMin > 1 Then
                    Kill(FQN)
                End If
            Next

        Catch ex As Exception
            Me.WriteToArchiveLog("NOTICE CleanOutTempDirectory: " + ex.Message)
        End Try

    End Sub

    Public Sub WriteToProcessLog(ByVal Msg As String)
        Try
            'Dim cPath As String = GetCurrDir()        
            Dim cPath As String = getTempEnvironDir()
            'Dim tFQN  = cPath + "\ECMLibrary.Trace.EMCQry.Log.txt"


            If Directory.Exists(LoggingPath) Then
                cPath = LoggingPath
            Else
                Try
                    cPath = LoggingPath
                    Directory.CreateDirectory(cPath)
                Catch ex As Exception
                    cPath = getTempEnvironDir()
                End Try
            End If

            Dim M As String = Now.Month.ToString.Trim
            Dim D As String = Now.Day.ToString.Trim
            Dim Y As String = Now.Year.ToString.Trim

            Dim SerialNo As String = M + "." + D + "." + Y + "."

            Dim tFQN As String = cPath + "\ECMLibrary.Archive.Memory.Process.Log." + SerialNo + "txt"
            ' Create an instance of StreamWriter to write text to a file.
            Using sw As StreamWriter = New StreamWriter(tFQN, True)
                ' Add some text to the file.                                    
                sw.WriteLine(Now.ToString + ": " + Msg + vbCrLf)
                sw.Close()
            End Using
            If gRunUnattended = True Then
                gUnattendedErrors += 1
                'FrmMDIMain.SB4.Text = " " + gUnattendedErrors.ToString
                'FrmMDIMain.SB4.BackColor = Color.Silver
            End If
        Catch ex As Exception
            If ddebug Then Console.WriteLine("clsDma : WriteToArchiveLog : 688 : " + ex.Message)
        End Try
    End Sub

    Public Sub WriteToTimerLog(ByVal LocaterID As String, ByVal TimerName As String, ByVal StartStop As String, Optional ByVal StartTime As Date = Nothing)

        Dim ExecutionTime As TimeSpan
        Dim sExecutionTime As String = ""
        If StartTime = Nothing Then
        Else
            Dim stop_time As Date = Now
            ExecutionTime = stop_time.Subtract(StartTime)
            sExecutionTime = ExecutionTime.TotalSeconds.ToString("0.000000")
        End If
        Try
            'Dim cPath As String = GetCurrDir()        
            Dim cPath As String = getTempEnvironDir()
            'Dim tFQN  = cPath + "\ECMLibrary.Trace.EMCQry.Log.txt"


            If Directory.Exists(LoggingPath) Then
                cPath = LoggingPath
            Else
                Try
                    cPath = LoggingPath
                    Directory.CreateDirectory(cPath)
                Catch ex As Exception
                    cPath = getTempEnvironDir()
                End Try
            End If

            Dim M As String = Now.Month.ToString.Trim
            Dim D As String = Now.Day.ToString.Trim
            Dim Y As String = Now.Year.ToString.Trim

            Dim SerialNo As String = M + "." + D + "." + Y + "."

            Dim tFQN As String = cPath + "\ECMLibrary.Archive.Timer.Log." + SerialNo + "txt"
            ' Create an instance of StreamWriter to write text to a file.
            Using sw As StreamWriter = New StreamWriter(tFQN, True)
                ' Add some text to the file.   
                If sExecutionTime.Length > 0 Then
                    sw.WriteLine(TimerName + " : " + StartStop + " : " + TimerName + " : Elapsed Time: " + sExecutionTime + " : " + Now.ToString)
                Else
                    sw.WriteLine(TimerName + " : " + StartStop + " : " + TimerName + " : " + Now.ToString)
                End If

                sw.Close()
            End Using
            If gRunUnattended = True Then
                gUnattendedErrors += 1
                'FrmMDIMain.SB4.Text = " " + gUnattendedErrors.ToString
                'FrmMDIMain.SB4.BackColor = Color.Silver
            End If
        Catch ex As Exception
            If ddebug Then Console.WriteLine("clsDma : WriteToArchiveLog : 688 : " + ex.Message)
        End Try
    End Sub
    Public Sub WriteToFileProcessLog(ByVal FQN As String)

        Try
            Dim cPath As String = getTempEnvironDir()

            If Directory.Exists(LoggingPath) Then
                cPath = LoggingPath
            Else
                Try
                    cPath = LoggingPath
                    Directory.CreateDirectory(cPath)
                Catch ex As Exception
                    cPath = getTempEnvironDir()
                End Try
            End If

            Dim M As String = Now.Month.ToString.Trim
            Dim D As String = Now.Day.ToString.Trim
            Dim Y As String = Now.Year.ToString.Trim

            Dim SerialNo As String = M + "." + D + "." + Y + "."

            Dim tFQN As String = cPath + "\ECMLibrary.Archive.FilesProcessed.Log." + SerialNo + "txt"
            ' Create an instance of StreamWriter to write text to a file.
            Using sw As StreamWriter = New StreamWriter(tFQN, True)
                ' Add some text to the file.   
                sw.WriteLine(Now.ToString + " : " + FQN)
                sw.Close()
            End Using
            If gRunUnattended = True Then
                gUnattendedErrors += 1
                'FrmMDIMain.SB4.Text = " " + gUnattendedErrors.ToString
                'FrmMDIMain.SB4.BackColor = Color.Silver
            End If
        Catch ex As Exception
            If ddebug Then Console.WriteLine("clsDma : WriteToArchiveLog : 688 : " + ex.Message)
        End Try
    End Sub
    Sub WriteMemoryTrack()
        Dim p As Process

        For Each p In p.GetProcesses
            Dim S As String = ""
            Dim D As Double = CDbl(p.WorkingSet64).ToString
            Dim P1 As String = p.ToString.Remove(0, 27)
            Dim P2 As String = (D / 1000000) & " MB"

            If InStr(P1, "ECM", CompareMethod.Text) > 0 Then
                WriteToProcessLog(P1 + " : " + P2)
            End If
        Next
    End Sub

    Public Function PullOutSingleQuotes(ByVal tVal As String) As String

        If InStr(tVal, "'") = 0 Then
            Return (tVal)
        End If

        If InStr(tVal, "''") > 0 Then
            Return (tVal)
        End If

        Dim i As Integer = Len(tVal)
        Dim ch As String = ""
        Dim NewStr As String = ""
        Dim S1 As String = ""
        Dim S2 As String = ""
        Dim A As String()
        If InStr(1, tVal, "'") > 0 Then
            A = tVal.Split("'")
            For i = 0 To UBound(A)
                NewStr = NewStr + A(i).Trim + "''"
            Next
            NewStr = Mid(NewStr, 1, NewStr.Length - 2)
        Else
            NewStr = tVal
        End If
        Return NewStr
    End Function
    Public Function PutBackSingleQuotes(ByVal tStr As String) As String

        If InStr(tStr, "''") = 0 Then
            Return (tStr)
        End If

        Dim TgtStr As String = "''"
        Dim S1 As String = ""
        Dim S2 As String = ""
        Dim L As Integer = Len(TgtStr)
        Dim I As Integer = 0

        Do While InStr(tStr, TgtStr, CompareMethod.Text) > 0
            I = InStr(tStr, TgtStr, CompareMethod.Text)
            S1 = Mid(tStr, 1, I - 1)
            S2 = Mid(tStr, I + L)
            tStr = S1 + "'" + S2
        Loop

        Return tStr
    End Function

    Function genEmailIdentifier(ByVal MessageSize As String, ByVal ReceivedTime As String, ByVal SenderEmailAddress As String, ByVal Subject As String, ByVal CurrentUserID As String) As String
        Dim EmailIdentifier As String = MessageSize + "~" + ReceivedTime + "~" + SenderEmailAddress + "~" + Mid(Subject, 1, 80) + "~" + CurrentUserID

        EmailIdentifier = PullOutSingleQuotes(EmailIdentifier)

        Return EmailIdentifier
    End Function

    Public Function getTempPdfWorkingDir() As String
        Dim TempSysDir As String = System.IO.Path.GetTempPath + "ECM\PDA\Extract"
        Dim D As Directory
        If Not D.Exists(TempSysDir) Then
            D.CreateDirectory(TempSysDir)
        End If
        ZeroizeDir()
        Return TempSysDir
    End Function

    Public Function getTempPdfWorkingErrorDir() As String
        Dim TempSysDir As String = System.IO.Path.GetTempPath + "ECM\FileERRORS"
        Dim D As Directory
        If Not D.Exists(TempSysDir) Then
            D.CreateDirectory(TempSysDir)
        End If
        Return TempSysDir
    End Function

    Private Sub ZeroizeDir()

        Dim TempSysDir As String = System.IO.Path.GetTempPath + "ECM\PDA\Extract"
        Dim D As Directory
        If Not D.Exists(TempSysDir) Then
            D.CreateDirectory(TempSysDir)
        End If

        Dim s As String
        For Each s In System.IO.Directory.GetFiles(TempSysDir)
            Try
                System.IO.File.Delete(s)
            Catch ex As Exception
                Console.WriteLine("99.131 - " + ex.Message)
            End Try

        Next s
    End Sub

    Public Function BlankOutSingleQuotes(ByVal sText As String) As String
        For i As Integer = 1 To sText.Length
            Dim CH As String = Mid(sText, i, 1)
            If CH.Equals("'") Then
                Mid(sText, i, 1) = " "
            End If
        Next
        Return sText
    End Function

    Function ExtractImages(ByVal SourceGuid As String, ByVal FQN As String, ByRef PdfImages As List(Of String)) As Integer


        Dim fName As String = IO.Path.GetFileName(FQN)
        Dim TempDir As String = getTempPdfWorkingDir()
        PdfImages.Clear()

        Dim RC As Integer = 0

        Try
            ' Load the PDF file.
            Dim doc As New PDFDocument(FQN)
            Try
                ' Serial number goes here
                doc.SerialNumber = "PDF4NET-H7WXK-B98L9-AOP4W-XLTFH-DRBS6"
                Dim i As Integer = 0
                While i < doc.Pages.Count
                    ' Convert the pages to PDFImportedPage to get access to ExtractImages method.
                    Dim ip As PDFImportedPage = TryCast(doc.Pages(i), PDFImportedPage)
                    Dim images As Bitmap() = ip.ExtractImages()
                    ' Save the page images to disk, if there are any.
                    Dim j As Integer = 0
                    While j < images.Length
                        RC += 1
                        Dim NewFileName As String = TempDir + "\ECM.PDF.Image." + SourceGuid + "." + i.ToString + "." + j.ToString() + ".TIF"
                        images(j).Save(NewFileName, ImageFormat.Tiff)
                        PdfImages.Add(NewFileName)
                        j = j + 1
                    End While
                    i = i + 1

                    frmExchangeMonitor.lblMessageInfo.Text = FQN + " : " + i.ToString + ": Embedded Images"
                    frmExchangeMonitor.lblMessageInfo.Refresh()
                    System.Windows.Forms.Application.DoEvents()

                End While
            Catch ex As Exception
                WriteToArchiveLog("ERROR 02 clsPdfAnalyzer:ExtractImages Message - " + ex.Message)
            Finally
                doc.Dispose()
            End Try
        Catch ex As Exception
            WriteToArchiveLog("ERROR 01 clsPdfAnalyzer:ExtractImages Message - " + ex.Message)
            WriteToArchiveLog("ERROR 02 clsPdfAnalyzer:ExtractImages FQN - " + FQN)
            Console.WriteLine(ex.Message)
            'Console.WriteLine(ex.InnerException.ToString)
        End Try
        Return RC
    End Function

    Public Sub WriteToKeyLog(ByVal sKey As String, ByVal AppendToFile As Boolean)

        Dim tFQN As String = GetKeyLogFileName()
        Dim SW As StreamWriter = New StreamWriter(tFQN, AppendToFile)

        Try
            'Dim cPath As String = GetCurrDir()        
            ' Create an instance of StreamWriter to write text to a file.
            Using SW
                ' Add some text to the file.                                    
                SW.WriteLine(sKey)
            End Using
        Catch ex As Exception
            If ddebug Then Console.WriteLine("clsDmaArch : WriteToArchiveLog : 688 : " + ex.Message)
        Finally
            SW.Close()
            SW.Dispose()
        End Try
    End Sub

    Function GetKeyLogFileName() As String
        Dim cPath As String = getTempEnvironDir()
        'Dim tFQN  = cPath + "\ECMLibrary.Trace.EMCQry.Log.txt"


        If Directory.Exists(LoggingPath) Then
            cPath = LoggingPath
        Else
            Try
                cPath = LoggingPath
                Directory.CreateDirectory(cPath)
            Catch ex As Exception
                cPath = getTempEnvironDir()
            End Try
        End If


        Dim TempSysDir As String = cPath + "\ECM\KeyLog"
        Dim D As Directory
        If Not D.Exists(TempSysDir) Then
            D.CreateDirectory(TempSysDir)
        End If

        cPath = TempSysDir

        Dim M As String = Now.Month.ToString.Trim
        'Dim D  = Now.Day.ToString.Trim
        Dim Y As String = Now.Year.ToString.Trim

        'Dim SerialNo  = M + "." + D + "." + Y + "."
        Dim SerialNo As String = M + "." + Y + "."

        Dim tFQN As String = cPath + "\ECMLibrary.Archive.KeyLog.Log." + SerialNo + "txt"
        Return tFQN
    End Function

End Class
