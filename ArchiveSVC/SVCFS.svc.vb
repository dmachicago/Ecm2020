Imports System.IO

' NOTE: You can use the "Rename" command on the context menu to change the class name "Service1" in code, svc and config file together.
Public Class SVCFS
    Implements IService1

    Dim FSVC As New clsFiles
    Dim LOG As New clsLogging

    Public Sub New()
    End Sub

    Public Sub RemoteFileUpload(ByVal request As RemoteFileUploadMsg) Implements IService1.RemoteFileUpload
        Dim ErrMsg As String = ""
        Try
            ErrMsg = FSVC.UploadRemoteFile(request)
        Catch ex As Exception
            LOG.WriteToArchiveFileTraceLog(ex.Message.ToString, False)
        End Try
    End Sub

    Public Sub UploadZippedFile(ByVal CompressedData As FileStream) Implements IService1.UploadZippedFile
        FSVC.UploadZippedFile(CompressedData)
    End Sub

    Public Sub UploadFile(ByVal fileData As Stream) Implements IService1.UploadFile
        FSVC.UploadFile(fileData)
    End Sub

    Public Function GetData(ByVal value As Integer) As String Implements IService1.GetData
        Return String.Format("You entered: {0}", value)
    End Function

    Public Function GetDataUsingDataContract(ByVal composite As CompositeType) As CompositeType Implements IService1.GetDataUsingDataContract
        If composite Is Nothing Then
            Throw New ArgumentNullException("composite")
        End If
        If composite.BoolValue Then
            composite.StringValue &= "Suffix"
        End If
        Return composite
    End Function

End Class
