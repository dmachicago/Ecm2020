'Description:
'This is a simple program that shows how to download files from the web and save them. The program uses the HttpWebRequest and HttpWebResponse classes to request and retrieve the requested file. The data are read into a buffer. A FileStream class is used to save the file to disk. In this example, a doppler radar map that covers the area I live is requested and saved to a file called "weather.jpg". Since the data are downloaded and read into the buffer asynchronously, a loop is required to read and keep track of how many bytes have been read, and the point in the stream where the next read should start. The loop will continue until the buffer is full or 0 bytes are read, indicating the end of the stream has been reached. The buffer must be sized large enough to hold the file. This is not a problem in this case as the doppler jpg's are a standard and known size.
'Requirement:
'Requires .NET SDK
'How To Compile?
'vbc /r:System.Net.dll /r:System.IO.dll webretrieve.vb.

Imports System.IO
Imports System.Net
Imports System.Text

Class clsWebRetrieve

    ''' <summary>
    ''' Allows for VERY LARGE file downloads 100KB at a time. The limitation here will be the amount of available memory.
    ''' </summary>
    ''' <param name="SiteUrl">An example would be "http://maps.weather.com/web/radar"</param>
    ''' <param name="FileName">The File Name to Download</param>
    ''' <param name="SaveToDir">The Directory where the downloaded file is to be saved.</param>
    ''' <param name="FileIsCompressed">If the file being downloaded is compressed, set this true and it will be decompressed by this routine after download.</param>
    ''' <remarks></remarks>
    Public Sub DownLoadFile(ByVal SiteUrl As String, ByVal FileName As String, ByVal SaveToDir As String, ByVal FileIsCompressed As Boolean)
        Dim SaveToFqn As String = ""
        Dim DownLoadFile As String = ""
        If Mid(SiteUrl, SiteUrl.Length, 1) = "/" Then
        Else
            SiteUrl = SiteUrl + "/"
        End If
        DownLoadFile = SiteUrl + FileName

        If Mid(SaveToDir, SiteUrl.Length, 1) = "/" Then
        Else
            SaveToDir = SaveToDir + "/"
        End If
        SaveToFqn = SaveToDir + FileName

        Dim wr As HttpWebRequest = CType(WebRequest.Create(DownLoadFile), HttpWebRequest)
        Dim ws As HttpWebResponse = CType(wr.GetResponse(), HttpWebResponse)
        Dim str As Stream = ws.GetResponseStream()
        Dim inBuf(100000) As Byte
        Dim bytesToRead As Integer = CInt(inBuf.Length)
        Dim bytesRead As Integer = 0
        While bytesToRead > 0
            Dim n As Integer = str.Read(inBuf, bytesRead, bytesToRead)
            If n = 0 Then
                Exit While
            End If
            bytesRead += n
            bytesToRead -= n
        End While
        Dim fstr As New FileStream(SaveToFqn, FileMode.OpenOrCreate, FileAccess.Write)
        fstr.Write(inBuf, 0, bytesRead)
        str.Close()
        fstr.Close()
    End Sub 'Main

    ''' <summary>
    ''' 
    ''' </summary>
    ''' <param name="SiteUrl">An example would be "http://maps.weather.com/web/radar"</param>
    ''' <param name="FileName">The File Name to Download</param>
    ''' <param name="SaveToDir">The Directory where the downloaded file is to be saved.</param>
    ''' <param name="ChunkSize">The size (in bytes) to be downloaded each loop of the process. The max size is 1MB, the min size is 4096 bytes.</param>
    ''' <param name="FileIsCompressed">If the file being downloaded is compressed, set this true and it will be decompressed by this routine after download.</param>
    ''' <remarks></remarks>

    Public Sub DownLoadFileInParts(ByVal SiteUrl As String, ByVal FileName As String, ByVal SaveToDir As String, ByVal ChunkSize As Integer, ByVal FileIsCompressed As Boolean)

        If ChunkSize > 1000000 Then
            ChunkSize = 1000000
        End If
        If ChunkSize < 4096 Then
            ChunkSize = 4096
        End If

        Dim SaveToFqn As String = ""
        Dim DownLoadFile As String = ""
        If Mid(SiteUrl, SiteUrl.Length, 1) = "/" Then
        Else
            SiteUrl = SiteUrl + "/"
        End If
        DownLoadFile = SiteUrl + FileName

        If Mid(SaveToDir, SiteUrl.Length, 1) = "/" Then
        Else
            SaveToDir = SaveToDir + "/"
        End If
        SaveToFqn = SaveToDir + FileName

        Dim wr As HttpWebRequest = CType(WebRequest.Create(DownLoadFile), HttpWebRequest)
        Dim ws As HttpWebResponse = CType(wr.GetResponse(), HttpWebResponse)
        Dim str As Stream = ws.GetResponseStream()
        Dim inBuf(ChunkSize) As Byte
        Dim bytesToRead As Integer = CInt(inBuf.Length)
        Dim bytesRead As Integer = 0

        Dim fstr As New FileStream(SaveToFqn, FileMode.OpenOrCreate, FileAccess.Write)
        Dim currOffset As Integer = 0
        While bytesToRead > 0
            Dim n As Integer = str.Read(inBuf, bytesRead, bytesToRead)
            If n = 0 Then
                Exit While
            End If
            fstr.Write(inBuf, currOffset, ChunkSize)
            currOffset += n
            bytesRead += n
            bytesToRead -= n
        End While


        str.Close()
        fstr.Close()
    End Sub 'Main
End Class 'clsWebRetrieve
