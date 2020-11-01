Imports System.IO

Public Class clsLogging
    Public Sub WriteToArchiveFileTraceLog(ByVal Msg$, ByVal Zeroize As Boolean)
        Try
            'Dim cPath As String = getTempEnvironDir()
            Dim LogPath As String = System.Configuration.ConfigurationManager.AppSettings("LogPath")
            'Dim TempFolder$ = getEnvVarSpecialFolderApplicationData()
            Dim M$ = Now.Month.ToString.Trim
            Dim D$ = Now.Day.ToString.Trim
            Dim Y$ = Now.Year.ToString.Trim

            Dim SerialNo$ = M + "." + D + "." + Y + "."

            Dim tFQN As String = LogPath + "\ECMLibrary.Archive.FileTrace.Log." + SerialNo$ + "txt"
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
            Console.WriteLine("clsDma : WriteToSqlLog : 688 : " + ex.Message)
        End Try
    End Sub
End Class
