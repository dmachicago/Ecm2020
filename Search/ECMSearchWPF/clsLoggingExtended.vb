' ***********************************************************************
' Assembly         : ECMSearchWPF
' Author           : wdale
' Created          : 07-16-2020
'
' Last Modified By : wdale
' Last Modified On : 07-16-2020
' ***********************************************************************
' <copyright file="clsLoggingExtended.vb" company="D. Miller and Associates, Limited">
'     Copyright @ DMA Ltd 2020 all rights reserved.
' </copyright>
' <summary></summary>
' ***********************************************************************
Imports System.IO

''' <summary>
''' Class clsLoggingExtended.
''' </summary>
Public Class clsLoggingExtended

    ''' <summary>
    ''' The log
    ''' </summary>
    Dim LOG As New clsLogMain

    ''' <summary>
    ''' Initializes a new instance of the <see cref="clsLoggingExtended"/> class.
    ''' </summary>
    Public Sub New()
        If Not Directory.Exists("ECMLogs") Then
            Directory.CreateDirectory("ECMLogs")
        End If
    End Sub


    ''' <summary>
    ''' Views the today log.
    ''' </summary>
    Public Sub ViewTodayLog()
        Try
            'Dim cPath As String = GetCurrDir()
            Dim cPath As String = LOG.getTempEnvironDir()
            'Dim tFQN$ = cPath + "\ECMLibrary.Trace.EMCQry.Log.txt"

            Dim TempFolder As String = LOG.getTempEnvironDir()
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

    ''' <summary>
    ''' Writes the trace log.
    ''' </summary>
    ''' <param name="Msg">The MSG.</param>
    Public Sub WriteTraceLog(ByVal Msg As String)
        Try
            'Dim cPath As String = GetCurrDir()
            Dim cPath As String = LOG.getTempEnvironDir()
            'Dim tFQN$ = cPath + "\ECMLibrary.Trace.EMCQry.Log.txt"

            If Not Directory.Exists("c:\ECMLogs") Then
                Directory.CreateDirectory("c:\ECMLogs")
            End If
            Dim TempFolder As String = LOG.getTempEnvironDir()
            TempFolder = "c:\ECMLogs\"
            Dim M$ = Now.Month.ToString.Trim
            Dim D$ = Now.Day.ToString.Trim
            Dim Y$ = Now.Year.ToString.Trim

            Dim SerialNo$ = M + "." + D + "." + Y + "."

            Dim tFQN As String = TempFolder + "ECMLibrary.Trace.Log." + SerialNo$ + "txt"
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

    ''' <summary>
    ''' Writes the log.
    ''' </summary>
    ''' <param name="Msg">The MSG.</param>
    Public Sub WriteLog(ByVal Msg As String)
        Try
            'Dim cPath As String = GetCurrDir()
            Dim cPath As String = LOG.getTempEnvironDir()
            'Dim tFQN$ = cPath + "\ECMLibrary.Trace.EMCQry.Log.txt"

            If Not Directory.Exists("ECMLogs") Then
                Directory.CreateDirectory("ECMLogs")
            End If
            Dim TempFolder As String = LOG.getTempEnvironDir()
            TempFolder = "c:\ECMLogs\"
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

    ''' <summary>
    ''' Gets the log path.
    ''' </summary>
    ''' <returns>System.String.</returns>
    Function getLogPath() As String
        Dim cPath As String = LOG.getTempEnvironDir()
        'Dim tFQN$ = cPath + "\ECMLibrary.Trace.EMCQry.Log.txt"

        Dim TempFolder As String = LOG.getTempEnvironDir()
        Dim M$ = Now.Month.ToString.Trim
        Dim D$ = Now.Day.ToString.Trim
        Dim Y$ = Now.Year.ToString.Trim

        Dim SerialNo$ = M + "." + D + "." + Y + "."

        Dim tFQN As String = TempFolder + "ECMLibrary.Download.Log." + SerialNo$ + "txt"
        Return tFQN

    End Function

    ''' <summary>
    ''' Xgets the temporary environ dir.
    ''' </summary>
    ''' <returns>System.String.</returns>
    Public Function xgetTempEnvironDir() As String
        Return System.IO.Path.GetTempPath
    End Function

    ''' <summary>
    ''' Gets the env application executable path.
    ''' </summary>
    ''' <returns>System.String.</returns>
    Public Function getEnvApplicationExecutablePath() As String
        Return My.Application.Info.DirectoryPath
    End Function

    ''' <summary>
    ''' Gets the env variable special folder my documents.
    ''' </summary>
    ''' <returns>System.String.</returns>
    Public Function getEnvVarSpecialFolderMyDocuments() As String
        Return Environment.GetFolderPath(Environment.SpecialFolder.MyDocuments)
    End Function

    ''' <summary>
    ''' Gets the env variable special folder local application data.
    ''' </summary>
    ''' <returns>System.String.</returns>
    Public Function getEnvVarSpecialFolderLocalApplicationData() As String
        Return Environment.GetFolderPath(Environment.SpecialFolder.LocalApplicationData)
    End Function

    ''' <summary>
    ''' Gets the env variable special folder common application data.
    ''' </summary>
    ''' <returns>System.String.</returns>
    Public Function getEnvVarSpecialFolderCommonApplicationData() As String
        Return Environment.GetFolderPath(Environment.SpecialFolder.CommonApplicationData)
    End Function

    ''' <summary>
    ''' Gets the env variable special folder application data.
    ''' </summary>
    ''' <returns>System.String.</returns>
    Public Function getEnvVarSpecialFolderApplicationData() As String
        Return Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData)
    End Function

    ''' <summary>
    ''' Gets the env variable version.
    ''' </summary>
    ''' <returns>System.String.</returns>
    Public Function getEnvVarVersion() As String
        Return Environment.Version.ToString
    End Function

    ''' <summary>
    ''' Gets the name of the env variable user domain.
    ''' </summary>
    ''' <returns>System.String.</returns>
    Public Function getEnvVarUserDomainName() As String
        Return Environment.UserDomainName.ToString
    End Function

    ''' <summary>
    ''' Gets the env variable processor count.
    ''' </summary>
    ''' <returns>System.String.</returns>
    Public Function getEnvVarProcessorCount() As String
        Return Environment.ProcessorCount.ToString
    End Function

    ''' <summary>
    ''' Gets the env variable operating system.
    ''' </summary>
    ''' <returns>System.String.</returns>
    Public Function getEnvVarOperatingSystem() As String
        Return Environment.OSVersion.ToString()
    End Function

    ''' <summary>
    ''' Gets the name of the env variable machine.
    ''' </summary>
    ''' <returns>System.String.</returns>
    Public Function getEnvVarMachineName() As String
        Return Environment.MachineName
    End Function

    ''' <summary>
    ''' Gets the env variable user identifier.
    ''' </summary>
    ''' <returns>System.String.</returns>
    Public Function getEnvVarUserID() As String
        Return Environment.UserName
    End Function

    ''' <summary>
    ''' Gets the restore dir email.
    ''' </summary>
    ''' <returns>System.String.</returns>
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

    ''' <summary>
    ''' Gets the content of the restore dir.
    ''' </summary>
    ''' <returns>System.String.</returns>
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

    ''' <summary>
    ''' Gets the restore dir preview.
    ''' </summary>
    ''' <returns>System.String.</returns>
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

    ''' <summary>
    ''' Makes the restore directories.
    ''' </summary>
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

    ''' <summary>
    ''' Deletes the preview files.
    ''' </summary>
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

    ''' <summary>
    ''' Deletes the content files.
    ''' </summary>
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

    ''' <summary>
    ''' Deletes the e mail files.
    ''' </summary>
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

    ''' <summary>
    ''' Creates the dir if missing.
    ''' </summary>
    ''' <param name="dName">Name of the d.</param>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
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