Imports System.IO
Imports System.Collections

Public Class clsLogging

    Dim dDeBug As Boolean = false
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
    Public Function getEnvVarUserID() As String
        Return Environment.UserName
    End Function

    Public Sub WriteToTempWebTraceLog(ByVal Msg As String)
        Try
            Dim M$ = Now.Month.ToString.Trim
            Dim D$ = Now.Day.ToString.Trim
            Dim Y$ = Now.Year.ToString.Trim

            Dim SerialNo$ = M + "." + D + "." + Y + "."

            Dim tFQN$ = "C:\temp\WebTrace.Log." + SerialNo$ + "txt"
            'Dim cPath As String = GetCurrDir()        
            Dim cPath As String = getTempEnvironDir()
            'Dim tFQN$ = cPath + "\ECMLibrary.Trace.EMCQry.Log.txt"
            Dim TempFolder As String = "C:\temp"
            Using sw As StreamWriter = New StreamWriter(tFQN, True)
                ' Add some text to the file.                                    
                sw.WriteLine(Now.ToString + ": " + Msg + vbCrLf)
                sw.Close()
            End Using
        Catch ex As Exception
            If dDeBug Then Console.WriteLine("clsDma : WriteToSqlLog : 688 : " + ex.Message)
        End Try
    End Sub

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
            If dDeBug Then Console.WriteLine("clsDma : WriteToSqlLog : 688 : " + ex.Message)
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
            If dDeBug Then Console.WriteLine("clsDma : WriteToSqlLog : 688 : " + ex.Message)
        End Try
    End Sub

    Function getTempEnvironDir() As String
        Return getEnvVarSpecialFolderApplicationData()
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
            If dDeBug Then Console.WriteLine("clsDma : WriteToSqlLog : 688 : " + ex.Message)
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
            If dDeBug Then Console.WriteLine("clsDma : WriteToSqlLog : 688 : " + ex.Message)
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
            If dDeBug Then Console.WriteLine("clsDma : WriteToSqlLog : 688 : " + ex.Message)
        End Try
    End Sub
    Sub OpenEcmErrorLog()
        Try
            'Dim cPath As String = GetCurrDir()        
            Dim cPath As String = getTempEnvironDir()
            'Dim tFQN$ = cPath + "\ECMLibrary.Trace.EMCQry.Log.txt"
            Dim TempFolder$ = getEnvVarSpecialFolderApplicationData()
            Dim M$ = Now.Month.ToString.Trim
            Dim D$ = Now.Day.ToString.Trim
            Dim Y$ = Now.Year.ToString.Trim
            Dim SerialNo$ = M + "." + D + "." + Y + "."
            Dim tFQN$ = TempFolder$ + "\ECMLibrary.Trace.ECMQry.Log." + SerialNo$ + "txt"
            ' Create an instance of StreamWriter to write text to a file.
            System.Diagnostics.Process.Start("notepad.exe", tFQN)
        Catch ex As Exception
            If dDeBug Then Console.WriteLine("clsDma : WriteToSqlLog : 688 : " + ex.Message)
        End Try
    End Sub
    Public Sub WriteToOcrLog(ByVal Msg As String)
        Try
            'Dim cPath As String = GetCurrDir()        
            Dim cPath As String = getTempEnvironDir()
            'Dim tFQN$ = cPath + "\ECMLibrary.Trace.EMCQry.Log.txt"

            Dim TempFolder$ = getEnvVarSpecialFolderApplicationData()
            Dim M$ = Now.Month.ToString.Trim
            Dim D$ = Now.Day.ToString.Trim
            Dim Y$ = Now.Year.ToString.Trim

            Dim SerialNo$ = M + "." + D + "." + Y + "."

            Dim tFQN$ = TempFolder$ + "\ECMLibrary.OCR.Log." + SerialNo$ + "txt"
            ' Create an instance of StreamWriter to write text to a file.
            Using sw As StreamWriter = New StreamWriter(tFQN, True)
                ' Add some text to the file.                                    
                sw.WriteLine(Now.ToString + ": " + Msg + vbCrLf)
                sw.Close()
            End Using
            If gRunUnattended = True Then
                gUnattendedErrors += 1
            End If
        Catch ex As Exception
            If dDeBug Then Console.WriteLine("clsDma : WriteToSqlLog : 688 : " + ex.Message)
        End Try
    End Sub
    Public Sub WriteToSqlLog(ByVal Msg As String)
        Try
            'Dim cPath As String = GetCurrDir()        
            Dim cPath As String = getTempEnvironDir()
            'Dim tFQN$ = cPath + "\ECMLibrary.Trace.EMCQry.Log.txt"

            Dim TempFolder$ = getEnvVarSpecialFolderApplicationData()
            Dim M$ = Now.Month.ToString.Trim
            Dim D$ = Now.Day.ToString.Trim
            Dim Y$ = Now.Year.ToString.Trim

            Dim SerialNo$ = M + "." + D + "." + Y + "."

            Dim tFQN$ = TempFolder$ + "\ECMLibrary.Event.Log." + SerialNo$ + "txt"
            ' Create an instance of StreamWriter to write text to a file.
            Using sw As StreamWriter = New StreamWriter(tFQN, True)
                ' Add some text to the file.                                    
                sw.WriteLine(Now.ToString + ": " + Msg + vbCrLf)
                sw.Close()
            End Using
            If gRunUnattended = True Then
                gUnattendedErrors += 1
            End If
        Catch ex As Exception
            If dDeBug Then Console.WriteLine("clsDma : WriteToSqlLog : 688 : " + ex.Message)
        End Try
    End Sub
    Public Sub WriteToContentDuplicateLog(ByVal TypeRec As String, ByVal RecGuid As String, ByVal RecIdentifier As String)
        Try
            Dim cPath As String = getTempEnvironDir()
            Dim TempFolder$ = getEnvVarSpecialFolderApplicationData()
            Dim tFQN$ = TempFolder$ + "\ECMLibrary.Duplicate.Content.Analysis.Log." + "txt"
            ' Create an instance of StreamWriter to write text to a file.
            Using sw As StreamWriter = New StreamWriter(tFQN, True)
                ' Add some text to the file.                                    
                sw.WriteLine(Now.ToString + ": " + TypeRec + Chr(254) + RecGuid + Chr(254) + RecIdentifier + vbCrLf)
                sw.Close()
            End Using
            If gRunUnattended = True Then
                gUnattendedErrors += 1
            End If
        Catch ex As Exception
            If dDeBug Then Console.WriteLine("clsDma : WriteToSqlLog : 688 : " + ex.Message)
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
                sw.WriteLine(Now.ToString + ": " + TypeRec + Chr(254) + RecGuid + Chr(254) + RecIdentifier + vbCrLf)
                sw.Close()
            End Using
        Catch ex As Exception
            If dDeBug Then Console.WriteLine("clsDma : WriteToSqlLog : 688 : " + ex.Message)
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

    End Sub

    Public Sub WriteToNoticeLog(ByVal Msg As String)
        Try
            'Dim cPath As String = GetCurrDir()        
            Dim cPath As String = getTempEnvironDir()
            'Dim tFQN$ = cPath + "\ECMLibrary.Trace.EMCQry.Log.txt"

            Dim TempFolder$ = getEnvVarSpecialFolderApplicationData()
            Dim M$ = Now.Month.ToString.Trim
            Dim D$ = Now.Day.ToString.Trim
            Dim Y$ = Now.Year.ToString.Trim

            Dim SerialNo$ = M + "." + D + "." + Y + "."

            Dim tFQN$ = TempFolder$ + "\ECMLibrary.Notice.Log." + SerialNo$ + "txt"
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
            If dDeBug Then Console.WriteLine("clsDma : WriteToSqlLog : 688 : " + ex.Message)
        End Try
    End Sub

    Public Sub WriteToPDFLog(ByVal Msg As String)
        Try
            'Dim cPath As String = GetCurrDir()        
            Dim cPath As String = getTempEnvironDir()
            'Dim tFQN$ = cPath + "\ECMLibrary.Trace.EMCQry.Log.txt"

            Dim TempFolder$ = getEnvVarSpecialFolderApplicationData()
            Dim M$ = Now.Month.ToString.Trim
            Dim D$ = Now.Day.ToString.Trim
            Dim Y$ = Now.Year.ToString.Trim

            Dim SerialNo$ = M + "." + D + "." + Y + "."

            Dim tFQN$ = TempFolder$ + "\ECMLibrary.PDF.Log." + SerialNo$ + "txt"
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
            If dDeBug Then Console.WriteLine("clsDma : WriteToSqlLog : 688 : " + ex.Message)
        End Try
    End Sub

    Public Sub WriteToInstallLog(ByVal Msg As String)
        Try
            'Dim cPath As String = GetCurrDir()        
            Dim cPath As String = getTempEnvironDir()
            'Dim tFQN$ = cPath + "\ECMLibrary.Trace.EMCQry.Log.txt"

            Dim TempFolder$ = getEnvVarSpecialFolderApplicationData()
            Dim M$ = Now.Month.ToString.Trim
            Dim D$ = Now.Day.ToString.Trim
            Dim Y$ = Now.Year.ToString.Trim

            Dim SerialNo$ = M + "." + D + "." + Y + "."

            Dim tFQN$ = TempFolder$ + "\ECMLibrary.Client.Installation.Log." + SerialNo$ + "txt"
            ' Create an instance of StreamWriter to write text to a file.
            Using sw As StreamWriter = New StreamWriter(tFQN, True)
                ' Add some text to the file.                                    
                sw.WriteLine(Now.ToString + ": " + Msg + vbCrLf)
                sw.Close()
            End Using
        Catch ex As Exception
            If dDeBug Then Console.WriteLine("clsDma : WriteToSqlLog : 688 : " + ex.Message)
        End Try
    End Sub

    Public Sub WriteToListenLog(ByVal Msg As String)
        Try
            'Dim cPath As String = GetCurrDir()        
            Dim cPath As String = getTempEnvironDir()
            'Dim tFQN$ = cPath + "\ECMLibrary.Trace.EMCQry.Log.txt"

            Dim TempFolder$ = getEnvVarSpecialFolderApplicationData()
            Dim M$ = Now.Month.ToString.Trim
            Dim D$ = Now.Day.ToString.Trim
            Dim Y$ = Now.Year.ToString.Trim

            Dim SerialNo$ = M + "." + D + "." + Y + "."

            Dim tFQN$ = TempFolder$ + "\ECMLibrary.Client.Listen.Log." + SerialNo$ + "txt"
            ' Create an instance of StreamWriter to write text to a file.
            Using sw As StreamWriter = New StreamWriter(tFQN, True)
                ' Add some text to the file.                                    
                sw.WriteLine(Now.ToString + ": " + Msg + vbCrLf)
                sw.Close()
            End Using
        Catch ex As Exception
            If dDeBug Then Console.WriteLine("clsDma : WriteToSqlLog : 688 : " + ex.Message)
        End Try
    End Sub
    Public Sub WriteFilesLog(ByVal Msg As String)
        Try
            'Dim cPath As String = GetCurrDir()        
            Dim cPath As String = getTempEnvironDir()

            Dim tFQN$ = cPath + "\ModifiedFilesLog.ECM"
            ' Create an instance of StreamWriter to write text to a file.
            Using sw As StreamWriter = New StreamWriter(tFQN, True)
                ' Add some text to the file.                                    
                sw.WriteLine(Now.ToString + ": " + Msg + vbCrLf)
                sw.Close()
            End Using
        Catch ex As Exception
            If dDeBug Then Console.WriteLine("clsDma : WriteToSqlLog : 688 : " + ex.Message)
        End Try
    End Sub

    Public Sub WriteToAttachLog(ByVal Msg As String)
        Try
            'Dim cPath As String = GetCurrDir()        
            Dim cPath As String = getTempEnvironDir()
            'Dim tFQN$ = cPath + "\ECMLibrary.Trace.EMCQry.Log.txt"

            Dim TempFolder$ = getEnvVarSpecialFolderApplicationData()
            Dim M$ = Now.Month.ToString.Trim
            Dim D$ = Now.Day.ToString.Trim
            Dim Y$ = Now.Year.ToString.Trim

            Dim SerialNo$ = M + "." + D + "." + Y + "."

            Dim tFQN$ = TempFolder$ + "\ECMLibrary.Client.Attach.Log." + SerialNo$ + "txt"
            ' Create an instance of StreamWriter to write text to a file.
            Using sw As StreamWriter = New StreamWriter(tFQN, True)
                ' Add some text to the file.                                    
                sw.WriteLine(Now.ToString + ": " + Msg + vbCrLf)
                sw.Close()
            End Using
        Catch ex As Exception
            If dDeBug Then Console.WriteLine("clsDma : WriteToAttachLog : 688 : " + ex.Message)
        End Try
    End Sub
    Public Sub WriteToEbExecLog(ByVal Msg As String)
        Try
            'Dim cPath As String = GetCurrDir()        
            Dim cPath As String = getTempEnvironDir()
            'Dim tFQN$ = cPath + "\ECMLibrary.Db.ExecQry.Log.txt"

            Dim TempFolder$ = getEnvVarSpecialFolderApplicationData()
            Dim M$ = Now.Month.ToString.Trim
            Dim D$ = Now.Day.ToString.Trim
            Dim Y$ = Now.Year.ToString.Trim

            Dim SerialNo$ = M + "." + D + "." + Y + "."

            Dim tFQN$ = TempFolder$ + "\ECMLibrary.Db.ExecQry.Log." + SerialNo$ + "txt"
            ' Create an instance of StreamWriter to write text to a file.
            Using sw As StreamWriter = New StreamWriter(tFQN, True)
                ' Add some text to the file.                                    
                sw.WriteLine(Now.ToString + ": " + Msg + vbCrLf)
                sw.Close()
            End Using
        Catch ex As Exception
            If dDeBug Then Console.WriteLine("clsDma : WriteToSqlLog : 688 : " + ex.Message)
        End Try
    End Sub
    Public Sub WriteToErrorLog(ByVal Msg As String)
        Try
            'Dim cPath As String = GetCurrDir()        
            Dim cPath As String = getTempEnvironDir()
            'Dim tFQN$ = cPath + "\ECMLibrary.Trace.EMCQry.Log.txt"

            Dim TempFolder$ = getEnvVarSpecialFolderApplicationData()
            Dim M$ = Now.Month.ToString.Trim
            Dim D$ = Now.Day.ToString.Trim
            Dim Y$ = Now.Year.ToString.Trim

            Dim SerialNo$ = M + "." + D + "." + Y + "."

            Dim tFQN$ = TempFolder$ + "\ECMLibrary.Error.Log." + SerialNo$ + "txt"
            ' Create an instance of StreamWriter to write text to a file.
            Using sw As StreamWriter = New StreamWriter(tFQN, True)
                ' Add some text to the file.                                    
                sw.WriteLine(Now.ToString + ": " + Msg + vbCrLf)
                sw.Close()
            End Using
        Catch ex As Exception
            If dDeBug Then Console.WriteLine("clsDma : WriteToSqlLog : 688 : " + ex.Message)
        End Try
    End Sub
    Public Sub WriteToTraceLog(ByVal Msg As String)
        Try
            Dim cPath As String = getTempEnvironDir()
            If Directory.Exists("c:\EcmTrace") Then
                cPath = "c:\EcmTrace"
            Else
                Try
                    cPath = "c:\EcmTrace"
                    Directory.CreateDirectory(cPath)
                Catch ex As Exception
                    cPath = getTempEnvironDir()
                End Try
            End If

            'Dim cPath As String = GetCurrDir()        

            'Dim tFQN$ = cPath + "\ECMLibrary.Trace.EMCQry.Log.txt"

            Dim TempFolder$ = cPath
            Dim M$ = Now.Month.ToString.Trim
            Dim D$ = Now.Day.ToString.Trim
            Dim Y$ = Now.Year.ToString.Trim

            Dim SerialNo$ = M + "." + D + "." + Y + "."

            Dim tFQN$ = TempFolder$ + "\ECMLibrary.Archive.Trace." + SerialNo$ + "txt"
            ' Create an instance of StreamWriter to write text to a file.
            Using sw As StreamWriter = New StreamWriter(tFQN, True)
                ' Add some text to the file.                                    
                sw.WriteLine(Now.ToString + ": " + Msg + vbCrLf)
                sw.Close()
            End Using
        Catch ex As Exception
            If dDeBug Then Console.WriteLine("clsDma : WriteToSqlLog : 688 : " + ex.Message)
        End Try
    End Sub

    Public Sub WriteToCrawlerLog(ByVal Msg As String)
        Try
            'Dim cPath As String = GetCurrDir()        
            Dim cPath As String = getTempEnvironDir()
            'Dim tFQN$ = cPath + "\ECMLibrary.Trace.EMCQry.Log.txt"

            Dim TempFolder$ = getEnvVarSpecialFolderApplicationData()
            Dim M$ = Now.Month.ToString.Trim
            Dim D$ = Now.Day.ToString.Trim
            Dim Y$ = Now.Year.ToString.Trim

            Dim SerialNo$ = M + "." + D + "." + Y + "."

            Dim tFQN$ = TempFolder$ + "\ECMLibrary.WebCrawl." + SerialNo$ + "txt"
            ' Create an instance of StreamWriter to write text to a file.
            Using sw As StreamWriter = New StreamWriter(tFQN, True)
                ' Add some text to the file.                                    
                sw.WriteLine(Now.ToString + ": " + Msg + vbCrLf)
                sw.Close()
            End Using
        Catch ex As Exception
            If dDeBug Then Console.WriteLine("clsDma : WriteToSqlLog : 688 : " + ex.Message)
        End Try
    End Sub
    Public Sub WriteToArchiveLog(ByVal Msg As String)
        Try
            'Dim cPath As String = GetCurrDir()        
            Dim cPath As String = getTempEnvironDir()
            'Dim tFQN$ = cPath + "\ECMLibrary.Trace.EMCQry.Log.txt"
            Dim TempFolder$ = getEnvVarSpecialFolderApplicationData()
            Dim M$ = Now.Month.ToString.Trim
            Dim D$ = Now.Day.ToString.Trim
            Dim Y$ = Now.Year.ToString.Trim

            Dim SerialNo$ = M + "." + D + "." + Y + "."

            Dim tFQN$ = TempFolder$ + "\ECMLibrary.Archive.Trace.Log." + SerialNo$ + "txt"
            ' Create an instance of StreamWriter to write text to a file.
            Using sw As StreamWriter = New StreamWriter(tFQN, True)
                ' Add some text to the file.                                    
                sw.WriteLine(Now.ToString + ": " + Msg + vbCrLf)
                sw.Close()
            End Using
        Catch ex As Exception
            If dDeBug Then Console.WriteLine("clsDma : WriteToSqlLog : 688 : " + ex.Message)
        End Try
    End Sub

    Public Sub WriteToAttachmentSearchLog(ByVal Msg As String)
        Try
            'Dim cPath As String = GetCurrDir()        
            Dim cPath As String = getTempEnvironDir()
            'Dim tFQN$ = cPath + "\ECMLibrary.Trace.EMCQry.Log.txt"
            Dim TempFolder$ = getEnvVarSpecialFolderApplicationData()
            Dim M$ = Now.Month.ToString.Trim
            Dim D$ = Now.Day.ToString.Trim
            Dim Y$ = Now.Year.ToString.Trim

            Dim SerialNo$ = M + "." + D + "." + Y + "."

            Dim tFQN$ = TempFolder$ + "\ECMLibrary.AttachSearch.Trace.Log." + SerialNo$ + "txt"
            ' Create an instance of StreamWriter to write text to a file.
            Using sw As StreamWriter = New StreamWriter(tFQN, True)
                ' Add some text to the file.                                    
                sw.WriteLine(Now.ToString + ": " + Msg + vbCrLf)
                sw.Close()
            End Using
        Catch ex As Exception
            If dDeBug Then Console.WriteLine("clsDma : WriteToSqlLog : 688 : " + ex.Message)
        End Try
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
            If dDeBug Then Console.WriteLine("clsDma : WriteToSqlLog : 688 : " + ex.Message)
        End Try
    End Sub
    Sub CleanOutTempDirectoryImmediate()

        Try
            Dim TempFolder$ = getEnvVarSpecialFolderApplicationData()
            'Dim storefile as clsDirectory
            'Dim directory As String
            Dim files As String()
            Dim FQN As String

            files = Directory.GetFiles(TempFolder$, "ECM*.*")
            ''Dim T As TimeSpan

            For Each FQN In files
                Try
                    Kill(FQN)
                Catch ex As Exception
                    MsgBox("Delete Notice: " + FQN + vbCrLf + ex.Message)
                End Try
            Next

        Catch ex As Exception
            Me.WriteToSqlLog("NOTICE CleanOutTempDirectory: " + ex.Message)
        End Try

    End Sub
    Sub CleanOutTempDirectory()

        Try
            Dim TempFolder$ = getEnvVarSpecialFolderApplicationData()
            'Dim storefile as clsDirectory
            'Dim dir As String
            Dim files As String()
            Dim FQN As String

            files = directory.Getfiles(TempFolder$, "ECM*.*")
            'Dim T As TimeSpan

            For Each FQN In files
                Dim FileDate As Date = GetFileCreateDate(FQN)

                'Dim objFileInfo As New FileInfo(FQN)
                'Dim dtCreationDate As DateTime = objFileInfo.CreationTime

                Dim tsTimeSpan As TimeSpan
                Dim iNumberOfDays As Integer
                'Dim strMsgText As String

                tsTimeSpan = Now.Subtract(FileDate)

                iNumberOfDays = tsTimeSpan.Days
                If iNumberOfDays > gDaysToKeepTraceLogs Then
                    Kill(FQN)
                End If
            Next

        Catch ex As Exception
            Me.WriteToSqlLog("NOTICE CleanOutTempDirectory: " + ex.Message)
        End Try

    End Sub

    Sub CleanOutErrorDirectoryImmediate()

        Try
            Dim UTIL As New clsUtilitySVR

            Dim TempFolder$ = UTIL.getTempPdfWorkingErrorDir

            UTIL = Nothing

            'Dim storefile as clsDirectory
            'Dim directory As String
            Dim files As String()
            Dim FQN As String

            files = directory.Getfiles(TempFolder$, "*.*")
            'Dim T As TimeSpan

            For Each FQN In files
                Try
                    Kill(FQN)
                Catch ex As Exception
                    MsgBox("Delete Notice: " + FQN + vbCrLf + ex.Message)
                End Try
            Next

        Catch ex As Exception
            Me.WriteToSqlLog("NOTICE CleanOutTempDirectory: " + ex.Message)
        End Try

    End Sub

    Sub CleanOutErrorDirectory()

        Try
            Dim UTIL As New clsUtilitySVR

            Dim TempFolder$ = UTIL.getTempPdfWorkingErrorDir

            UTIL = Nothing

            'Dim storefile as clsDirectory
            'Dim directory As String
            Dim files As String()
            Dim FQN As String

            files = directory.Getfiles(TempFolder$, "*.*")
            'Dim T As TimeSpan

            For Each FQN In files
                Dim FileDate As Date = GetFileCreateDate(FQN)

                'Dim objFileInfo As New FileInfo(FQN)
                'Dim dtCreationDate As DateTime = objFileInfo.CreationTime

                Dim tsTimeSpan As TimeSpan
                Dim iNumberOfDays As Integer
                'Dim strMsgText As String

                tsTimeSpan = Now.Subtract(FileDate)

                iNumberOfDays = tsTimeSpan.Days
                If iNumberOfDays > gDaysToKeepTraceLogs Then
                    Kill(FQN)
                End If
            Next

        Catch ex As Exception
            Me.WriteToSqlLog("NOTICE CleanOutTempDirectory: " + ex.Message)
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
            If dDeBug Then Console.WriteLine("clsDma : WriteToTempFile : 688 : " + ex.Message)
        End Try
    End Sub
    Sub PurgeDirectory(ByVal DirectoryName As String, ByVal Pattern As String)

        Try
            Dim TempFolder$ = getEnvVarSpecialFolderApplicationData()
            'Dim directory As String = ""
            Dim files As String()
            Dim FQN As String

            files = Directory.GetFiles(DirectoryName, Pattern)
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
            Me.WriteToSqlLog("NOTICE CleanOutTempDirectory: " + ex.Message)
        End Try

    End Sub

    Public Sub WriteToProcessLog(ByVal Msg As String)
        Try
            'Dim cPath As String = GetCurrDir()        
            Dim cPath As String = getTempEnvironDir()
            'Dim tFQN$ = cPath + "\ECMLibrary.Trace.EMCQry.Log.txt"

            Dim TempFolder$ = getEnvVarSpecialFolderApplicationData()
            Dim M$ = Now.Month.ToString.Trim
            Dim D$ = Now.Day.ToString.Trim
            Dim Y$ = Now.Year.ToString.Trim

            Dim SerialNo$ = M + "." + D + "." + Y + "."

            Dim tFQN$ = TempFolder$ + "\ECMLibrary.Memory.Process.Log." + SerialNo$ + "txt"
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
            If dDeBug Then Console.WriteLine("clsDma : WriteToSqlLog : 688 : " + ex.Message)
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
            'Dim tFQN$ = cPath + "\ECMLibrary.Trace.EMCQry.Log.txt"

            Dim TempFolder$ = getEnvVarSpecialFolderApplicationData()
            Dim M$ = Now.Month.ToString.Trim
            Dim D$ = Now.Day.ToString.Trim
            Dim Y$ = Now.Year.ToString.Trim

            Dim SerialNo$ = M + "." + D + "." + Y + "."

            Dim tFQN$ = TempFolder$ + "\ECMLibrary.Timer.Log." + SerialNo$ + "txt"
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
            If dDeBug Then Console.WriteLine("clsDma : WriteToSqlLog : 688 : " + ex.Message)
        End Try
    End Sub
    Public Sub WriteToFileProcessLog(ByVal FQN As String)

        Try
            Dim cPath As String = getTempEnvironDir()
            Dim TempFolder$ = getEnvVarSpecialFolderApplicationData()
            Dim M$ = Now.Month.ToString.Trim
            Dim D$ = Now.Day.ToString.Trim
            Dim Y$ = Now.Year.ToString.Trim

            Dim SerialNo$ = M + "." + D + "." + Y + "."

            Dim tFQN$ = TempFolder$ + "\ECMLibrary.FilesProcessed.Log." + SerialNo$ + "txt"
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
            If dDeBug Then Console.WriteLine("clsDma : WriteToSqlLog : 688 : " + ex.Message)
        End Try
    End Sub
    Sub WriteMemoryTrack()
        Dim p As Process

        For Each p In Process.GetProcesses
            Dim S As String = ""
            Dim D As Double = CDbl(p.WorkingSet64).ToString
            Dim P1 As String = p.ToString.Remove(0, 27)
            Dim P2 As String = (D / 1000000) & " MB"

            If InStr(P1, "ECM", CompareMethod.Text) > 0 Then
                WriteToProcessLog(P1 + " : " + P2)
            End If
        Next
    End Sub


End Class
