Imports System.IO
Imports System.IO.File
Imports System.IO.FileStream
Imports System.Web
' NOTE: You can use the "Rename" command on the context menu to change the class name "Service1" in code, svc and config file together.
Public Class Service1
    Implements ITransferService

    Public Sub New()
    End Sub

    Public Function GetData(ByVal value As Integer) As String Implements ITransferService.GetData
        Return String.Format("You entered: {0}", value)
    End Function

    Public Function GetDataUsingDataContract(ByVal composite As CompositeType) As CompositeType Implements ITransferService.GetDataUsingDataContract
        If composite Is Nothing Then
            Throw New ArgumentNullException("composite")
        End If
        If composite.BoolValue Then
            composite.StringValue &= "Suffix"
        End If
        Return composite
    End Function

    Public Function DownloadFile(ByVal request As DownloadRequest) As RemoteFileInfo
        Dim result As New RemoteFileInfo()
        Try
            Dim filePath As String = System.IO.Path.Combine("c:\Uploadfiles", request.FileName)
            Dim fileInfo As New System.IO.FileInfo(filePath)

            ' check if exists
            If Not fileInfo.Exists Then
                Throw New System.IO.FileNotFoundException("File not found", request.FileName)
            End If

            ' open stream
            'Dim inStream As New System.IO.StreamReader(filePath, System.IO.FileMode.Open, System.IO.FileAccess.Read)
            'Dim inStream As New System.IO.StreamReader(filePath)
            Dim inStream As New System.IO.StreamReader(filePath, System.Text.Encoding.UTF8)

            ' return result 
            result.FileName = request.FileName
            result.Length = fileInfo.Length
            result.FileByteStream = inStream

        Catch ex As Exception
        End Try
        Return result
    End Function
    Public Sub UploadFile(ByVal request As RemoteFileInfo)

        Dim sourceStream As StreamReader = request.FileByteStream

        '** How do I change this to a relative URL/PATH on the server
        Dim uploadFolder As String = "C:\upload\"

        Dim filePath As String = Path.Combine(uploadFolder, request.FileName)

        '** We can files that are ASCII as will as UNICODE - how do I handle that?
        'Using targetStream = New FileStream(filePath, FileMode.Create, FileAccess.Write, FileShare.None)
        Using targetStream = New FileStream(filePath, FileMode.Create, FileAccess.Write)
            'read from the input stream in 61440 byte chunks
            Const bufferLen As Integer = 61440

            Dim buffer As Byte() = New Byte(bufferLen - 1) {}
            Dim BufferOfChars As Char() = buffer.ToString.ToCharArray()
            Dim count As Integer = 0

            While (count = sourceStream.Read(BufferOfChars, 0, bufferLen)) > 0
                ' save to output stream
                targetStream.Write(buffer, 0, 61440)
            End While
            targetStream.Close()
            sourceStream.Close()
        End Using

    End Sub

End Class
