Imports System.IO

Public Class clsLogging

    Public Sub ViewTodayLog()
        Try
            'Dim cPath As String = GetCurrDir()        
            Dim cPath As String = getTempEnvironDir()
            'Dim tFQN$ = cPath + "\ECMLibrary.Trace.EMCQry.Log.txt"

            Dim TempFolder As String = getTempEnvironDir()
            Dim M$ = Now.Month.ToString.Trim
            Dim D$ = Now.Day.ToString.Trim
            Dim Y$ = Now.Year.ToString.Trim

            Dim SerialNo$ = M + "." + D + "." + Y + "."

            Dim tFQN As String = TempFolder + "ECMLibrary.Download.Log." + SerialNo$ + "txt"
            If File.Exists(tFQN) Then
                System.Diagnostics.Process.Start("notepad.exe", tFQN)
            Else
                MessageBox.Show("Log file not found...")
            End If
        Catch ex As Exception
            MsgBox("clsLogging : ViewTodayLog : 688 : " + ex.Message)
        End Try
    End Sub
    Public Sub WriteLog(ByVal Msg As String)
        Try
            'Dim cPath As String = GetCurrDir()        
            Dim cPath As String = getTempEnvironDir()
            'Dim tFQN$ = cPath + "\ECMLibrary.Trace.EMCQry.Log.txt"

            Dim TempFolder As String = getTempEnvironDir()
            Dim M$ = Now.Month.ToString.Trim
            Dim D$ = Now.Day.ToString.Trim
            Dim Y$ = Now.Year.ToString.Trim

            Dim SerialNo$ = M + "." + D + "." + Y + "."

            Dim tFQN As String = TempFolder + "ECMLibrary.Download.Log." + SerialNo$ + "txt"
            ' Create an instance of StreamWriter to write text to a file.
            Using sw As StreamWriter = New StreamWriter(tFQN, True)
                ' Add some text to the file.                                    
                sw.WriteLine(Now.ToString + ": " + Msg)
                sw.Close()
            End Using
        Catch ex As Exception
            MsgBox("clsLogging : WriteToSqlLog : 688 : " + ex.Message)
        End Try
    End Sub

    Function getLogPath() As String
        Dim cPath As String = getTempEnvironDir()
        'Dim tFQN$ = cPath + "\ECMLibrary.Trace.EMCQry.Log.txt"

        Dim TempFolder As String = getTempEnvironDir()
        Dim M$ = Now.Month.ToString.Trim
        Dim D$ = Now.Day.ToString.Trim
        Dim Y$ = Now.Year.ToString.Trim

        Dim SerialNo$ = M + "." + D + "." + Y + "."

        Dim tFQN As String = TempFolder + "ECMLibrary.Download.Log." + SerialNo$ + "txt"
        Return tFQN

    End Function
    Function getTempEnvironDir() As String
        Return System.IO.Path.GetTempPath
    End Function
    Public Function getEnvApplicationExecutablePath() As String
        Return My.Application.Info.DirectoryPath
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
    Public Function getEnvVarUserID() As String
        Return Environment.UserName
    End Function
    Public Function getRestoreDirEmail() As String
        If gDownloadDIR.Trim.Length > 0 Then
            Dim tDir As String = gDownloadDIR + "\ECM.Email.Restore"
            tDir.Replace("\\", "\")
            If Not Directory.Exists(gDownloadDIR) Then
                Directory.CreateDirectory(gDownloadDIR)
            End If
            Return tDir
        Else
            Return getEnvVarSpecialFolderMyDocuments() + "\ECM.Email.Restore"
        End If
    End Function
    Public Function getRestoreDirContent() As String
        If gDownloadDIR.Trim.Length > 0 Then
            Dim tDir As String = gDownloadDIR + "\ECM.Content.Restore"
            tDir.Replace("\\", "\")
            If Not Directory.Exists(gDownloadDIR) Then
                Directory.CreateDirectory(gDownloadDIR)
            End If
            Return tDir
        Else
            Return getEnvVarSpecialFolderMyDocuments() + "\ECM.Content.Restore"
        End If
    End Function
    Public Function getRestoreDirPreview() As String
        If gDownloadDIR.Trim.Length > 0 Then
            Dim tDir As String = gDownloadDIR + "\ECM.Preview"
            tDir.Replace("\\", "\")
            If Not Directory.Exists(gDownloadDIR) Then
                Directory.CreateDirectory(gDownloadDIR)
            End If
            Return tDir
        Else
            Return System.IO.Path.GetTempPath + "\ECM.Preview"
        End If
    End Function


    Sub MakeRestoreDirectories()

        Dim EmailDir As String = getEnvVarSpecialFolderMyDocuments() + "ECM.EmailRestore"
        Dim DocDir As String = getEnvVarSpecialFolderMyDocuments() + "ECM.ContentRestore"
        Dim PrevDir As String = System.IO.Path.GetTempPath + "ECM.Preview"

        If Not Directory.Exists(PrevDir) Then
            Directory.CreateDirectory(PrevDir)
        End If
        If Not Directory.Exists(EmailDir) Then
            Directory.CreateDirectory(EmailDir)
        End If
        If Not Directory.Exists(DocDir) Then
            Directory.CreateDirectory(DocDir)
        End If

    End Sub

    Sub DeletePreviewFiles()
        Dim PreviewDir As String = getRestoreDirPreview()
        Dim s As String

        If Not Directory.Exists(PreviewDir) Then
            Return
        End If

        Try
            For Each s In System.IO.Directory.GetFiles(PreviewDir)
                System.IO.File.Delete(s)
            Next s
        Catch ex As Exception
            Console.WriteLine("NOTICE: " + ex.Message)
        End Try

    End Sub
    Sub DeleteContentFiles()
        Dim PreviewDir As String = getRestoreDirContent()
        Dim s As String

        If Not Directory.Exists(PreviewDir) Then
            Return
        End If

        For Each s In System.IO.Directory.GetFiles(PreviewDir)
            System.IO.File.Delete(s)
        Next s

    End Sub
    Sub DeleteEMailFiles()
        Dim PreviewDir As String = getRestoreDirEmail()
        Dim s As String

        If Not Directory.Exists(PreviewDir) Then
            Return
        End If

        For Each s In System.IO.Directory.GetFiles(PreviewDir)
            System.IO.File.Delete(s)
        Next s

    End Sub

    Function CreateDirIfMissing(ByVal dName As String) As Boolean
        Dim B As Boolean = True

        Try
            If Not Directory.Exists(dName) Then
                Directory.CreateDirectory(dName)
            End If
        Catch ex As Exception
            B = False
        End Try

        Return B
    End Function

End Class
