Imports System.IO
'Imports Microsoft.Win32
Imports System.IO.Compression
Public Class clsCompression
    Public Function StrToByteArray(ByVal str As String) As Byte()
        Dim encoding As New System.Text.UTF8Encoding()
        Return encoding.GetBytes(str)
    End Function 'StrToByteArray
    Public Function ByteArrayToStr(ByVal dBytes As Byte()) As String
        Dim str As String
        Dim enc As New System.Text.UTF8Encoding()
        str = enc.GetString(dBytes)
        Return str
    End Function

    Public Function CompressStringToBuffer(ByVal tgtStr As String, ByRef OriginalSize As Double, ByRef CompressedSize As Double) As Byte()

        Dim CompressedDataBuffer() As Byte
        CompressedDataBuffer = StrToByteArray(tgtStr)

        If CompressedDataBuffer.Length = 0 Then
            CompressedDataBuffer = Nothing
            Return CompressedDataBuffer
        End If

        OriginalSize = CompressedDataBuffer.Length

        Dim gzBuffer() As Byte = CompressBuffer(CompressedDataBuffer)

        CompressedDataBuffer = gzBuffer
        CompressedSize = CompressedDataBuffer.Length
        Return CompressedDataBuffer

    End Function

    Public Function DeCompressBufferToString(ByVal CompressedDataBuffer As Byte(), ByRef OriginalSize As Double, ByRef CompressedSize As Double) As String
        CompressedSize = CompressedDataBuffer.Length
        Dim DeCompressedDataBuffer As Byte() = DecompressBuffer(CompressedDataBuffer)
        OriginalSize = DeCompressedDataBuffer.Length
        Dim S As String = ByteArrayToStr(DeCompressedDataBuffer)
        Return S
    End Function

    Public Function CompressBuffer(ByVal BufferToCompress As Byte()) As Byte()
        Dim ms As New MemoryStream()
        Dim zip As New GZipStream(ms, CompressionMode.Compress, True)
        zip.Write(BufferToCompress, 0, BufferToCompress.Length)
        zip.Close()
        ms.Position = 0

        Dim outStream As New MemoryStream()

        Dim compressed As Byte() = New Byte(ms.Length - 1) {}
        ms.Read(compressed, 0, compressed.Length)

        Dim gzBuffer As Byte() = New Byte(compressed.Length + 3) {}
        Buffer.BlockCopy(compressed, 0, gzBuffer, 4, compressed.Length)
        Buffer.BlockCopy(BitConverter.GetBytes(BufferToCompress.Length), 0, gzBuffer, 0, 4)
        Return gzBuffer

    End Function
    Public Function DeCompressBuffer(ByVal BufferToDecompress As Byte()) As Byte()
        Dim ms As New MemoryStream()
        Dim msgLength As Integer = BitConverter.ToInt32(BufferToDecompress, 0)
        ms.Write(BufferToDecompress, 4, BufferToDecompress.Length - 4)

        Dim buffer As Byte() = New Byte(msgLength - 1) {}

        ms.Position = 0
        Dim zip As New GZipStream(ms, CompressionMode.Decompress)
        zip.Read(buffer, 0, buffer.Length)

        Return buffer
    End Function
End Class
