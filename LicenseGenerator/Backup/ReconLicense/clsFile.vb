Public Class clsFile
    Public Function FileToByte(ByVal fileName As String) As Byte()
        Try
            Dim fs As System.IO.FileStream = New System.IO.FileStream(fileName, System.IO.FileMode.Open, System.IO.FileAccess.Read)
            Dim br As System.IO.BinaryReader = New System.IO.BinaryReader(fs)
            Dim bArray() As Byte = br.ReadBytes(Convert.ToInt32(br.BaseStream.Length))
            br.Close()
            'StopWord()
            Return (bArray)
        Catch ex As Exception
            Try
                StopWord()
                Dim fs As System.IO.FileStream = New System.IO.FileStream(fileName, System.IO.FileMode.Open, System.IO.FileAccess.Read)
                Dim br As System.IO.BinaryReader = New System.IO.BinaryReader(fs)
                Dim bArray() As Byte = br.ReadBytes(Convert.ToInt32(br.BaseStream.Length))
                br.Close()
                Return (bArray)
            Catch ex2 As Exception
                Return Nothing
            End Try
        End Try

    End Function
    Public Function WriteArrayToFile(ByVal FQN$, ByVal byteData As Byte()) As Boolean
        Try
            Dim b As Boolean = True
            Dim oFileStream As System.IO.FileStream

            oFileStream = New System.IO.FileStream(FQN, System.IO.FileMode.Create)
            oFileStream.Write(byteData, 0, byteData.Length)
            oFileStream.Close()

            Return b
        Catch ex As Exception
            Debug.Print(ex.Message)
            Return False
        End Try
        
    End Function
    Sub StopWord()
        Dim ProcessList As System.Diagnostics.Process()

        ProcessList = System.Diagnostics.Process.GetProcesses()

        Dim Proc As System.Diagnostics.Process

        For Each Proc In ProcessList
            Console.WriteLine("Name {0} ID {1}", Proc.ProcessName, Proc.Id)
            If Proc.ProcessName.Equals("WinWord") Then
                Proc.Kill()
            End If
        Next
    End Sub
End Class
