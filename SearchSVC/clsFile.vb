Imports System.IO

Public Class clsFile

    Dim DMA As New clsDmaSVR
    Dim LOG As New clsLogging
    Dim UTIL As New clsUtilitySVR

    Public Function FileToByte(ByVal fileName As String) As Byte()

        '** Added this second AS string for Liz - she thought the 
        '** archive process was changing the dates on her files.
        '** So, I had to prove to her that it was not.
        Dim UseMethodOne As Boolean = True

        Dim TempDir$ = System.IO.Path.GetTempPath
        Dim fName$ = DMA.getFileName(fileName)
        Dim TempFile$ = TempDir$ + "\" + fName + ".bak"

        If UseMethodOne = True Then
            TempFile = fileName
        Else
            My.Computer.FileSystem.CopyFile(fileName, TempFile$, True)
        End If

        Try
            Dim fs As System.IO.FileStream = New System.IO.FileStream(TempFile$, System.IO.FileMode.Open, System.IO.FileAccess.Read)
            Dim br As System.IO.BinaryReader = New System.IO.BinaryReader(fs)
            Dim bArray() As Byte = br.ReadBytes(Convert.ToInt32(br.BaseStream.Length))
            br.Close()
            If UseMethodOne = True Then
            Else
                '** Delete the temp copy of the file.
                My.Computer.FileSystem.DeleteFile(TempFile)
            End If

            Return (bArray)
        Catch ex As Exception
            Try

                StopWinWord()
                Dim fs As System.IO.FileStream = New System.IO.FileStream(TempFile$, System.IO.FileMode.Open, System.IO.FileAccess.Read)
                Dim br As System.IO.BinaryReader = New System.IO.BinaryReader(fs)
                Dim bArray() As Byte = br.ReadBytes(Convert.ToInt32(br.BaseStream.Length))
                br.Close()
                LOG.WriteToSqlLog("clsFile : FileToByte : 11a : " + ex.Message + vbCrLf + " - " + fileName)
                Return (bArray)
            Catch ex2 As Exception
                LOG.WriteToSqlLog("clsFile : FileToByte : 11b : " + ex2.Message + vbCrLf + " - " + fileName)
                Return Nothing
            End Try
        End Try


    End Function
    Public Function WriteArrayToFile(ByVal FQN as string, byval byteData As Byte()) As Boolean
        Try
            Dim b As Boolean = True
            Dim oFileStream As System.IO.FileStream

            oFileStream = New System.IO.FileStream(FQN, System.IO.FileMode.Create)
            oFileStream.Write(byteData, 0, byteData.Length)
            oFileStream.Close()

            Return b
        Catch ex As Exception
            Debug.Print(ex.Message)
            log.WriteToSqlLog("clsFile : WriteArrayToFile : 18 : " + ex.Message)
            Return false
        End Try
    End Function

    Sub StopWinWord()
        Dim ProcessList As System.Diagnostics.Process()
        ProcessList = System.Diagnostics.Process.GetProcesses()
        Dim Proc As System.Diagnostics.Process
        For Each Proc In ProcessList
            If Proc.ProcessName.Equals("WinWord") Then
                Console.WriteLine("Name {0} ID {1}", Proc.ProcessName, Proc.Id)
                Proc.Kill()
            End If
        Next
    End Sub

    Public Function OverwriteFile(ByVal FQN As String, ByVal SText As String) As Boolean
        'Dim Contents As String
        Dim bAns As Boolean = false
        Dim objReader As StreamWriter
        Try
            objReader = New StreamWriter(FQN)
            objReader.Write(SText)
            objReader.Close()
            bAns = True
        Catch Ex As Exception
            LOG.WriteToSqlLog("ERROR: SaveTextToFile 100 - " + Ex.Message)
            bAns = false
        End Try
        Return bAns
    End Function

    Public Sub AppendToFile(ByVal FQN As String, ByVal sMsg As String)

        Dim swriter As StreamWriter = File.AppendText(FQN)
        Try
            'swriter = File.AppendText(FQN)
            swriter.WriteLine(sMsg)
        Catch ex As Exception
            LOG.WriteToSqlLog("ERROR: SaveTextToFile 100 - " + ex.Message)
        Finally
            swriter.Close()
            swriter.Dispose()
        End Try
        
    End Sub

End Class
